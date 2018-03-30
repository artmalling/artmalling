<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 포인트관리 > 기부내역조회
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm3020.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.22 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
    String strSsno = "EM_SS_NO_S";
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToMonth = strToMonth + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

	//Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); 
    
    // EMedit에 초기화
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",      		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
     
    initEmEdit(EM_USE_F_DT,    "YYYYMMDD",            PK);         //조회 시작기간    
    initEmEdit(EM_USE_T_DT,    "TODAY",               PK);         //조회 종료기간
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    initEmEdit(EM_SS_NO_S,     "000000",      		  NORMAL);     //생년월일
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_SS_NO_H,     "#00000",     		  NORMAL);     //생년월일_hidden
    initEmEdit(EM_CARD_NO_H,   "0000000000000000",    NORMAL);     //카드번호_hidden
    
    EM_USE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    RD_COMP_PERS_FLAG_S.Focus();

    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
    RD_COMP_PERS_FLAG_S.CodeValue = strCompPersFlag;
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"               width=30       align=center</FC>'
                     + '<FC>id=DON_DATE         name="기부일자"         width=106       align=center    mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=DON_ID           name="기부처ID"         width=200       align=center    show=false</FC>'
                     + '<FC>id=DON_TARGET       name="기부처명"         width=200       align=left SumText="합계" </FC>'
                     + '<FC>id=DON_POINT        name="기부포인트"       width=140       align=right SumText=@sum </FC>'
                     + '<FC>id=DON_CTPOINT      name="기부처총액"       width=150       align=right SumText=@sum </FC>'
                     + '<FC>id=DON_ATPOINT      name="전체기부처총액"   width=150       align=right SumText=@sum </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);

    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
 * 2. 공통버튼
    (1) 조회       - btn_Search(), subQuery()
*************************************************************************/

/**
* btn_Search()
* 작 성 자     : 김영진
* 작 성 일     : 2010-03-22
* 개        요    : 조회시 호출
* return값 : void
*/
function btn_Search() {
	
	if(trim(EM_USE_F_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_USE_F_DT.Focus();
        return;
    }
	if(trim(EM_USE_T_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_USE_T_DT.Focus();
        return;
    }
	if(EM_USE_F_DT.Text > EM_USE_T_DT.Text){      // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_USE_F_DT.Focus();
        return;
    } 
	if(RD_COMP_PERS_FLAG_S.CodeValue == "P" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else if(RD_COMP_PERS_FLAG_S.CodeValue == "C" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[법인명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else{
        if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 16자리입니다.");
            RD_COMP_PERS_FLAG_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG_S.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 13)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG_S.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG_S.CodeValue == "P" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }else  if (RD_COMP_PERS_FLAG_S.CodeValue == "C" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "법인(단체)은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }
    }

    if(srchEvent(RD_COMP_PERS_FLAG_S.CodeValue))showMaster();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 포인트조회
 * return값 : void
 */
function showMaster(){

    var strUseFDt  = EM_USE_F_DT.Text;
    var strUseTDt  = EM_USE_T_DT.Text
    var strCardNo  = EM_CARD_NO_S.Text;
    var strSsNo    = EM_SS_NO_S.Text;
    var strCustId  = EM_CUST_ID_S.Text;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strUseFDt=" + encodeURIComponent(strUseFDt)
                    + "&strUseTDt=" + encodeURIComponent(strUseTDt)
                    + "&strCardNo=" + encodeURIComponent(strCardNo)
                    + "&strSsNo="   + encodeURIComponent(strSsNo)
                    + "&strCustId=" + encodeURIComponent(strCustId);    
    TR_MAIN.Action  ="/dcs/dctm302.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //Focus이동
    if(DS_O_MASTER.CountRow > 0){
    	GR_MASTER.Focus();
    }else{
    	RD_COMP_PERS_FLAG_S.Focus();
    }
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
}
 
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()> 
    if ((EM_CUST_ID_S.Modified) && (trim(EM_CUST_ID_S.Text).length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = ""; 
        EM_SS_NO_H.Text     = ""; 
    } 
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_USE_F_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_USE_F_DT)){
    	EM_USE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_USE_T_DT event=onKillFocus()>
    checkDateTypeYMD(EM_USE_T_DT);
</script>

<script language=JavaScript for=RD_COMP_PERS_FLAG_S event=OnSelChange()>
    if (strCompPersFlag == this.CodeValue) return;
    if ("P" == this.CodeValue) { 
        document.getElementById('titleSsno').innerHTML         = "생년월일";
        document.getElementById('titleSsNo2').innerHTML        = "생년월일";
        document.getElementById('titleCust').innerHTML         = "회원명";
        document.getElementById('titleCustName').innerHTML     = "회원명";
        document.getElementById('titleHomeAddr').innerHTML     = "회원주소";
        document.getElementById('titleHomePH').innerHTML       = "자택전화";
        document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";
        
        initEmEdit(EM_SS_NO_H,     "000000",    		  NORMAL);     //생년월일_hidden
        initEmEdit(EM_SS_NO_S,     "000000", 		      NORMAL);     //생년월일
        initEmEdit(EM_SS_NO,       "000000-0000000",      READ);       //사업자번호
        
        strCompPersFlag = this.CodeValue; 
    } else if ("C" == this.CodeValue) {
        document.getElementById('titleSsno').innerHTML         = "사업자등록번호";
        document.getElementById('titleSsNo2').innerHTML        = "사업자등록번호"; 
        document.getElementById('titleCust').innerHTML         = "법인(단체)명";
        document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
        document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
        document.getElementById('titleHomePH').innerHTML       = "대표전화";
        document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";

        initEmEdit(EM_SS_NO_H,     "#00-00-00000",      NORMAL);     //사업자번호_hidden
        initEmEdit(EM_SS_NO_S,     "#00-00-00000",      NORMAL);     //사업자번호
        initEmEdit(EM_SS_NO,       "#00-00-00000",      READ);       //사업자번호

        strCompPersFlag = this.CodeValue; 
    }
    DS_O_CUSTDETAIL.ClearData();
    DS_O_MASTER.ClearData();
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_HOME_PH.Text     = ""; 
    EM_MOBILE_PH.Text   = ""; 
    EM_EMAIL.Text       = ""; 
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = "";
    EM_CARD_NO_S.Text   = "";
    EM_SS_NO_S.Text     = "";
    
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
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
                        <th width="77">회원구분</th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=RD_COMP_PERS_FLAG_S classid=<%=Util.CLSID_RADIO%> tabindex=1
                            style="height: 20; width: 150">
                            <param name=Cols value="2">
                            <param name=Format value="P^개인회원,C^법인회원">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80" class="point">조회기간</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=EM_USE_F_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_USE_F_DT)" />- <comment
                            id="_NSID_"> <object id=EM_USE_T_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_USE_T_DT)" /></td>
                    </tr>
                   <tr>
                        <th width="77">카드번호</th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=EM_CARD_NO_H width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                            id="_NSID_"> <object id=EM_CARD_NO_S
                            classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S',strCompPersFlag);">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80"><span id="titleSsno" style="Color: 146ab9">생년월일</span></th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=EM_SS_NO_H width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                            id="_NSID_"> <object id=EM_SS_NO_S
                            classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'<%=strSsno%>',strCompPersFlag);">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80"><span id="titleCust" style="Color: 146ab9">회원명</span></th>
                        <td><comment id="_NSID_"> <object id=EM_CUST_ID_H
                            width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                            id="_NSID_"> <object id=EM_CUST_ID_S
                            classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',strCompPersFlag);"
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                            onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,strCompPersFlag)" />
                        <comment id="_NSID_"> <object id=EM_CUST_NAME_S
                            classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
                        </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td><%@ include file="/jsp/common/memView.jsp"%>
		</td>
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
					width="100%" height=392 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_CUSTDETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>