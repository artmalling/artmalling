<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 포인트현황 > SMS 회원 조회
 * 작  성  일  : 2012.06.04
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3160.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2012.06.04 (kj) 신규작성
 ******************************************************************************/
-->
<%@page import="oracle.sql.JAVA_STRUCT"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
	//String strFromDate = new java.text.SimpleDateFormat("yyyyMM")
	//		.format(new java.util.Date()) + "01";
	String strFromDate = new java.text.SimpleDateFormat("yyyyMMdd")
			.format(new java.util.Date());
	String strToDate = new java.text.SimpleDateFormat("yyyyMMdd")
			.format(new java.util.Date());
	String strToYear = new java.text.SimpleDateFormat("yyyy")
			.format(new java.util.Date());
	String strFromYear = Integer.parseInt(strToYear) - 40 + "";
	        strToYear   = Integer.parseInt(strToYear) - 20 + "";
%>
<script LANGUAGE="JavaScript">/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : kj
 * 작 성 일     : 2012.06.04
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	 
    //Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_S_DT, "YYYYMMDD",  PK); 		//조회기간
    initEmEdit(EM_TO_S_DT, "YYYYMMDD",  PK);		//조회기간
    initEmEdit(EM_FROM_S_YYYY, "YYYY",  PK);
    initEmEdit(EM_TO_S_YYYY, "YYYY",  PK);
    initEmEdit(EM_FROM_S_RANK, "NUMBER2^10^2", PK);
    initEmEdit(EM_TO_S_RANK, "NUMBER2^10^2", PK);
    
    initEmEdit(EM_FROM_S_AMT, "NUMBER2^10^2", PK);
    initEmEdit(EM_TO_S_AMT, "NUMBER2^10^2", PK);
    
    
    //조회조건 초기값.
    EM_FROM_S_DT.text = <%=strFromDate%>;
    EM_TO_S_DT.text = <%=strToDate%>;
    EM_FROM_S_YYYY.text = <%=strFromYear%>;
    EM_TO_S_YYYY.text = <%=strToYear%>;
    EM_FROM_S_RANK.text = 1;
    EM_TO_S_RANK.text = 1000;    
    CHK_BUSI_AREA1.checked = true;
    CHK_SEX_CD1.checked = true;
    CHK_SEX_CD2.checked = true;
    CHK_EMAIL_YN.checked = false;
    CHK_JUSO_YN.checked = false;
    
    // 검색조건 추가 2014.07.24
    CHK_SMS_Y.checked = true;
    CHK_SMS_N.checked = true;
    EM_FROM_S_AMT.text = 0;
    EM_TO_S_AMT.text = 1000000;    
    
    //화면 OPEN시 자동 조회
    //btn_Search();
}

function gridCreate1(){

     var hdrProperies = '<FC>id={currow}      	name="NO"             	width=30    align=center</FC>'
                      + '<FC>id=RANK  			name="순위"				width=30    align=center</FC>'
                      + '<FC>id=CUST_ID       	name="회원ID"      		width=100    align=center</FC>'
                      + '<FC>id=CUST_NAME    	name="회원명"      		width=100    align=center</FC>'
                      + '<FC>id=MOBILE_PH    	name="휴대전화번호"     	width=100    align=center</FC>'
                      + '<FC>id=SMS_YN    		name="SMS수신"     		width=100    align=center</FC>'
                      //+ '<FC>id=ADD_POINT    	name="총매출액"     		width=100    align=right</FC>'
                      + '<FC>id=SALE_AMT     	name="총매출액"   		width=100    align=right</FC>'
                      + '<FC>id=EMAIL     		name="이메일"   			width=200    align=left</FC>'
                      + '<FC>id=HOME_ADDR    	name="주소"	        	width=600    align=left</FC>';
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : kj
 * 작 성 일     : 2012.06.04
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(trim(EM_FROM_S_DT.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_FROM_S_DT.Focus();
        return;
    }
    if(trim(EM_TO_S_DT.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_TO_S_DT.Focus();
        return;
    }
    if(CHK_BUSI_AREA1.checked == false && CHK_BUSI_AREA2.checked == false && CHK_BUSI_AREA3.checked == false && CHK_BUSI_AREA4.checked == false && CHK_BUSI_AREA5.checked == false && CHK_BUSI_AREA6.checked == false && CHK_BUSI_AREA7.checked == false && CHK_BUSI_AREA8.checked == false && CHK_BUSI_AREA9.checked == false){
        showMessage(EXCLAMATION, OK, "USER-1001","상권");
        CHK_BUSI_AREA1.Focus();
        return;
    }
    if(CHK_SEX_CD1.checked == false && CHK_SEX_CD2.checked == false){
        showMessage(EXCLAMATION, OK, "USER-1001","성별");
        CHK_SEX_CD1.Focus();
        return;
    }
    if(trim(EM_FROM_S_YYYY.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001","시작생년");
        EM_FROM_S_YYYY.Focus();
        return;
    }
    if(trim(EM_TO_S_YYYY.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001","종료생년");
        EM_TO_S_YYYY.Focus();
        return;
    }
    if(trim(EM_FROM_S_RANK.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001","시작순위");
        EM_FROM_S_RANK.Focus();
        return;
    }
    if(trim(EM_TO_S_RANK.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001","종료순위");
        EM_TO_S_RANK.Focus();
        return;
    }    
    if(trim(EM_TO_S_RANK.Text) > trim(EM_FROM_S_RANK.Text) == 0){
        showMessage(EXCLAMATION, OK, "USER-1000","시작 및 종료 순위의 관계를 확인하세요");
        EM_FROM_S_RANK.Focus();
        return;
    }   
    
    if((trim(EM_TO_S_RANK.Text) - trim(EM_FROM_S_RANK.Text)) > 5000){
        showMessage(EXCLAMATION, OK, "USER-1000","시작 및 종료 순위는 5,000 건 내로 설정하세요");
        EM_FROM_S_RANK.Focus();
        return;
    }   
    
    showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_MASTER.RealCount(1, DS_MASTER.CountRow));
}

/**
 * btn_Excel()
 * 작 성 자     : kj
 * 작 성 일     : 2012.06.04
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
				   
    var parameters  = "조회시작년월="+ EM_FROM_S_DT.Text;
	    parameters +=	"조회종료년월="+ EM_TO_S_DT.Text;
	    parameters +=	"시작생년="+ EM_FROM_S_YYYY.Text;
	    parameters +=	"종료생년="+ EM_TO_S_YYYY.Text;
	    parameters +=	"시작순위="+ EM_FROM_S_RANK.Text;
	    parameters +=	"종료순위="+ EM_TO_S_RANK.Text;
	    parameters +=	"1차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA1").checked == true)? "1":"";
	    parameters +=	"2차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA2").checked == true)? "2":"";
	    parameters +=	"3차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA3").checked == true)? "3":"";
	    parameters +=	"4차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA4").checked == true)? "4":"";
	    parameters +=	"5차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA5").checked == true)? "5":"";
	    parameters +=	"6차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA6").checked == true)? "6":"";
	    parameters +=	"7차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA7").checked == true)? "7":"";
	    parameters +=	"8차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA8").checked == true)? "8":"";
	    parameters +=	"9차상권=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA9").checked == true)? "9":"";
	    parameters +=	"성별(남)=";
	    parameters +=	(document.getElementById("CHK_SEX_CD1").checked == true)? "M":"";
	    parameters +=	"성별(여)=";
	    parameters +=	(document.getElementById("CHK_SEX_CD2").checked == true)? "F":"";
	    parameters +=	"이메일여부=";
	    parameters +=	(document.getElementById("CHK_EMAIL_YN").checked == true)? "Y":"N";
	    parameters +=	"주소여부=";
	    parameters +=	(document.getElementById("CHK_JUSO_YN").checked == true)? "Y":"N";
	    
	    // 검색조건 추가 2014.07.24
	    parameters +=	"시작총매출액="+ EM_FROM_S_AMT.Text;
	    parameters +=	"종료총매출액="+ EM_TO_S_AMT.Text;
	    parameters +=	"SMS수신여부(Y)=";
	    parameters +=	(document.getElementById("CHK_SMS_Y").checked == true)? "Y":"";
	    parameters +=	"SMS수신여부(N)=";
	    parameters +=	(document.getElementById("CHK_SMS_N").checked == true)? "N":"";
    
    var ExcelTitle = "SMS 회원 조회"

    openExcel2(GR_MASTER, ExcelTitle, parameters, true );
    
    GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : kj
 * 작 성 일     : 2012.06.04
 * 개       요     : SMS 회원 조회
 * return값 : void
 */
function showMaster(){
    var goTo        = "searchMaster";    
    var action      = "O";
    
    var parameters  = "&strFromSDate="+ encodeURIComponent(EM_FROM_S_DT.Text);
	    parameters +=	"&strToSDate="+ encodeURIComponent(EM_TO_S_DT.Text);
	    parameters +=	"&strFromSYear="+ encodeURIComponent(EM_FROM_S_YYYY.Text);
	    parameters +=	"&strToSYear="+ encodeURIComponent(EM_TO_S_YYYY.Text);
	    parameters +=	"&strFromSRank="+ encodeURIComponent(EM_FROM_S_RANK.Text);
	    parameters +=	"&strToSRank="+ encodeURIComponent(EM_TO_S_RANK.Text);
	    parameters +=	"&strChkBusiArea1=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA1").checked == true)? "1":"";
	    parameters +=	"&strChkBusiArea2=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA2").checked == true)? "2":"";
	    parameters +=	"&strChkBusiArea3=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA3").checked == true)? "3":"";
	    parameters +=	"&strChkBusiArea4=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA4").checked == true)? "4":"";
	    parameters +=	"&strChkBusiArea5=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA5").checked == true)? "5":"";
	    parameters +=	"&strChkBusiArea6=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA6").checked == true)? "6":"";
	    parameters +=	"&strChkBusiArea7=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA7").checked == true)? "7":"";
	    parameters +=	"&strChkBusiArea8=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA8").checked == true)? "8":"";
	    parameters +=	"&strChkBusiArea9=";
	    parameters +=	(document.getElementById("CHK_BUSI_AREA9").checked == true)? "9":"";
	    parameters +=	"&strChkSexCd1=";
	    parameters +=	(document.getElementById("CHK_SEX_CD1").checked == true)? "M":"";
	    parameters +=	"&strChkSexCd2=";
	    parameters +=	(document.getElementById("CHK_SEX_CD2").checked == true)? "F":"";
	    parameters +=	"&strChkEmailYn=";
	    parameters +=	(document.getElementById("CHK_EMAIL_YN").checked == true)? "Y":"N";
	    parameters +=	"&strChkJusoYn=";
	    parameters +=	(document.getElementById("CHK_JUSO_YN").checked == true)? "Y":"N";
	    
	    // 검색조건 추가 2014.07.24
	    parameters +=	"&strChkSmsY=";
	    parameters +=	(document.getElementById("CHK_SMS_Y").checked == true)? "Y":"";
	    parameters +=	"&strChkSmsN=";
	    parameters +=	(document.getElementById("CHK_SMS_N").checked == true)? "N":"";
	    parameters +=	"&strFromSAmt="+ encodeURIComponent(EM_FROM_S_AMT.Text);
	    parameters +=	"&strToSAmt="+ encodeURIComponent(EM_TO_S_AMT.Text);
	    

    TR_MAIN.Action  ="/dcs/dbri316.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_FROM_S_DT.Focus();
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 조회기간 onKillFocus() -->
<script language=JavaScript for=EM_FROM_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_S_DT)){
    	EM_FROM_S_DT.text = <%=strFromDate%>;
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_TO_S_DT)){
    	EM_TO_S_DT.text = <%=strToDate%>;
    }    
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_"> <object id="DS_MASTER"
	classid=<%=Util.CLSID_DATASET%>> </object> </comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"> <object id="DS_I_CONDITION"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_"> <object id="TR_MAIN"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
	<!--공통 타이틀/버튼 -->
	<%@ include file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 // -->
	<div id="testdiv" class="testdiv">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="PT01 PB03">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="o_table">
						<tr>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="80" class="point">조회기간</th>
										<td width="200"><comment id="_NSID_"> <object
												id=EM_FROM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('G',EM_FROM_S_DT)" />- <comment
												id="_NSID_"> <object id=EM_TO_S_DT
												classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
												align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('G',EM_TO_S_DT)" />
										</td>
										<th width="80" class="point">상권구분</th>
										<td width="195"><input type="checkbox" id=CHK_BUSI_AREA1
											value="1" tabindex=1>1차 &nbsp;
											<input type="checkbox" id=CHK_BUSI_AREA2 value="2" tabindex=1>2차&nbsp;
											<input type="checkbox" id=CHK_BUSI_AREA3 value="3" tabindex=1 >3차 &nbsp;
                            <input type="checkbox" id=CHK_BUSI_AREA4 value="4" tabindex=1 >4차 &nbsp;
                            <input type="checkbox" id=CHK_BUSI_AREA5 value="5" tabindex=1 >5차 &nbsp;
                            <input type="checkbox" id=CHK_BUSI_AREA6 value="6" tabindex=1 >6차 &nbsp;
                            <input type="checkbox" id=CHK_BUSI_AREA7 value="7" tabindex=1 >7차 &nbsp;
                            <input type="checkbox" id=CHK_BUSI_AREA8 value="8" tabindex=1 >8차 &nbsp;
                            <input type="checkbox" id=CHK_BUSI_AREA9 value="9" tabindex=1 >9차 &nbsp;</td>
										<th width="80" class="point">성별</th>
										<td><input type="checkbox" id=CHK_SEX_CD1 value="M"
											tabindex=1>남 &nbsp;<input type="checkbox"
											id=CHK_SEX_CD2 value="F" tabindex=1>여 &nbsp;</td>
									</tr>
									<tr>
										<th width="80" class="point">생년</th>
										<td width="200"><comment id="_NSID_"> <object
												id=EM_FROM_S_YYYY classid=<%=Util.CLSID_EMEDIT%> width=70
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('Y',EM_FROM_S_YYYY)" />- <comment
												id="_NSID_"> <object id=EM_TO_S_YYYY
												classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
												align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('Y',EM_TO_S_YYYY)" />
										</td>
										<th width="80" class="point">순위</th>
										<td width="160"><comment id="_NSID_"> <object
												id=EM_FROM_S_RANK classid=<%=Util.CLSID_EMEDIT%> width=70
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>-
											<comment id="_NSID_"> <object id=EM_TO_S_RANK
												classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
												align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="80">고객정보</th>
										<td><input type="checkbox" id=CHK_EMAIL_YN tabindex=1>Email
											&nbsp;<input type="checkbox" id=CHK_JUSO_YN tabindex=1>주소
											&nbsp;</td>
									</tr>
									<tr>
										<th width="80">SMS수신여부</th>
										<td>
											<input type="checkbox" id=CHK_SMS_Y value="Y" tabindex=1 >수신 &nbsp;
											<input type="checkbox" id=CHK_SMS_N value="N" tabindex=1 >거부 &nbsp;
										</td>
										
							            <th width="80">총매출액</th>
										<td width="160"><comment id="_NSID_"> <object
												id=EM_FROM_S_AMT classid=<%=Util.CLSID_EMEDIT%> width=70
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>-
											<comment id="_NSID_"> <object id=EM_TO_S_AMT
												classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
												align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
							            
									</tr>
								</table></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td class="dot"></td>
			</tr>
			<tr valign="top">
				<td class="PB03">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="BD4A">
						<tr>
							<td><comment id="_NSID_"> <object id=GR_MASTER
									width="100%" height=484 classid=<%=Util.CLSID_GRID%> tabindex=1>
									<param name="DataID" value="DS_MASTER">
								</object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						</tr>
					</table></td>
			</tr>
		</table>
	</div>
	<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
