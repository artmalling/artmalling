<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 반송관리 > 재정구 잔여건 조회
 * 작  성  일  : 2010.06.07
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : psal9360.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.06.07 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-07
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();  

    //-- 입력필드
    initEmEdit(EM_VRTN_CD_S,  "00",          NORMAL);         
    initEmEdit(EM_VRTN_NM_S,  "GEN^20",      READ);  
    
    initEmEdit(EM_S_PAY_DT_S, "YYYYMMDD",    PK);    
    initEmEdit(EM_E_PAY_DT_S, "TODAY",       PK);     
    
    initComboStyle(LC_JBRCH_ID_S, DS_O_JBRCH_ID,  "CODE^0^120, NAME^0^180",   1, NORMAL);//가맹점번호
    initComboStyle(LC_STR_CD_S,   DS_O_S_STR,     "CODE^0^30,  NAME^0^80",    1, PK);
    initComboStyle(LC_BCOMP_S,    DS_O_BCOMP,    "CODE^0^30,   NAME^0^80",    1, NORMAL);
    
    
    //EMedit에 초기화
    getBcompCode("DS_O_BCOMP", "",  "", "Y");    
    getStore("DS_O_S_STR",     "Y", "", "N");
    
    EM_S_PAY_DT_S.Text   = addDate("D", "-1", EM_E_PAY_DT_S.Text);
    LC_BCOMP_S.BindColVal = "%";  
    LC_STR_CD_S.index = 0;   
    LC_STR_CD_S.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"              width=30      align=center</FC>'
                     + '<FC>id=PAY_DT      name="반송수신일자"     width=84      align=center  mask="XXXX/XX/XX"  SumText= "합계"</FC>'
                     + '<FC>id=BCOMP_NM    name="카드매입사"       width=90     align=left</FC>'
                     + '<FC>id=JBRCH_ID    name="가맹점번호"       width=80      align=center</FC>'
                     + '<FC>id=VRTN_NM     name="VAN사반송코드"    width=146     align=left</FC>'
                     + '<FC>id=CNT         name="반송건수"         width=80     align=right  SumText=@sum</FC>'
                     + '<FC>id=REBUY_CNT   name="재청구생성건수"   width=90     align=right  SumText=@sum</FC>'
                     + '<FC>id=NOBUY_CNT   name="미청구등록건수"   width=90     align=right  SumText=@sum</FC>'
                     + '<FC>id=NOREQ_CNT   name="미지정건수"       width=90     align=right  SumText=@sum</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-07
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
	
	if(trim(LC_STR_CD_S.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
	    LC_STR_CD_S.Focus();
	    return false;
	}
	if(trim(EM_S_PAY_DT_S.Text).length == 0){          // 조회시작일
	    showMessage(EXCLAMATION, OK, "USER-1001","반송수신 시작일");
	    EM_S_PAY_DT_S.Focus();
	    return;
	}
	if(trim(EM_E_PAY_DT_S.Text).length == 0){    // 조회 종료일
	    showMessage(EXCLAMATION, OK, "USER-1001","반송수신 종료일");
	    EM_E_PAY_DT_S.Focus();
	    return;
	}
	if(EM_S_PAY_DT_S.Text > EM_E_PAY_DT_S.Text){   // 조회일 정합성
	    showMessage(EXCLAMATION, OK, "USER-1015");
	    EM_S_PAY_DT_S.Focus();
	    return;
	}
    showMaster();
}

/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-07
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    var ExcelTitle = "재청구 잔여건 조회"
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-07
 * 개      요  : 조회
 * return값 :
 */
function showMaster(){
	
    EXCEL_PARAMS  = "점포명="            + LC_STR_CD_S.text;
	EXCEL_PARAMS += "-반송수신일자="     + EM_S_PAY_DT_S.text + " ~ " + EM_E_PAY_DT_S.text;
	EXCEL_PARAMS += "-카드매입사="       + LC_BCOMP_S.text;
	EXCEL_PARAMS += "-가맹점번호="       + LC_JBRCH_ID_S.BindColVal;
	EXCEL_PARAMS += "-VAN사 반송코드="    + EM_VRTN_CD_S.text + " : " + EM_VRTN_NM_S.Text;
	    
	var goTo        = "searchMaster";    
	var action      = "O";     
	var parameters  = "&strStrCd="     +  encodeURIComponent(LC_STR_CD_S.BindColVal)   
	                + "&strSpayDt="    +  encodeURIComponent(EM_S_PAY_DT_S.text)  
	                + "&strEpayDt="    +  encodeURIComponent(EM_E_PAY_DT_S.text)  
	                + "&strVrtnCd="    +  encodeURIComponent(EM_VRTN_CD_S.text)   
	                + "&strBcomp="     +  encodeURIComponent(LC_BCOMP_S.BindColVal)     
	                + "&strJbrchId="   +  encodeURIComponent(LC_JBRCH_ID_S.BindColVal);   
	
	TR_MAIN.Action  = "/dps/psal936.ps?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	TR_MAIN.Post();
	
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
	
	if (DS_O_MASTER.CountRow > 0 ) {
	    GR_MASTER.Focus();        
	}else{
		LC_STR_CD_S.Focus();
	}
}

/**
 * keyPressEventVRTN()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-07
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEventVRTN(kcode) {   
	 EM_VRTN_NM_S.Text = "";//조건입력시 코드초기화 
    if (EM_VRTN_CD_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_VRTN_CD_S.Text.length == 2) { //TAB,ENTER 키 실행시에만 
             
            var goTo       = "searchOnMaster" ;    
            var action     = "O";     
            var parameters = "&strVrtnCd="+encodeURIComponent(EM_VRTN_CD_S.Text);
             
            TR_MAIN.Action="/pot/ccom028.cc?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_RESULT)"; //조회는 O
            TR_MAIN.Post();
               
            if (DS_O_RESULT.CountRow == 1 ) {
            	EM_VRTN_CD_S.Text   = DS_O_RESULT.NameValue(1, "CODE");
            	EM_VRTN_NM_S.Text   = DS_O_RESULT.NameValue(1, "NAME");
            } else {
                 //1건 이외의 내역이 조회 시 팝업 호출
                getVrtnPop(EM_VRTN_CD_S, EM_VRTN_NM_S)
            }
        }  
    }  
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
<!-- onKillFocus() -->
<script language=JavaScript for=EM_VRTN_CD_S event=onKillFocus()>
    if (EM_VRTN_CD_S.Text.length != 2) {
    	EM_VRTN_NM_S.Text = "";
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 반송수신일자 Start onKillFocus() -->
<script language=JavaScript for=EM_S_PAY_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_PAY_DT_S)){
    	 EM_S_PAY_DT_S.Text   = addDate("D", "-1", EM_E_PAY_DT_S.Text);
    }
</script>

 <!-- 반송수신일자 End onKillFocus() -->
<script language=JavaScript for=EM_E_PAY_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_PAY_DT_S)){
        initEmEdit(EM_E_PAY_DT_S,    "TODAY",       PK);  
    }
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_S event=OnSelChange()>
    DS_O_JBRCH_ID.ClearData();
    if(this.BindColVal != "%"){
        LC_JBRCH_ID_S.Enable = true;
        getJbrchCode("DS_O_JBRCH_ID", this.BindColVal, "N");
    }else{
        LC_JBRCH_ID_S.Enable = false;
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_S_STR classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_JBRCH_ID classid=<%=Util.CLSID_DATASET%>> </object>
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
						<th width="78" class="point">점포명</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_STR_CD_S classid=<%=Util.CLSID_LUXECOMBO%> width=120
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>

						<th width="78" class="point">반송수신일자</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_PAY_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_PAY_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_PAY_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_PAY_DT_S)" /></td>
					</tr>
					<tr>
					    <th width="78">카드매입사</th>
                        <td><comment id="_NSID_"> <object id=LC_BCOMP_S
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=120
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
						<th width="78">가맹점번호</th>
						<td width="160"><comment id="_NSID_"> <object
							id=LC_JBRCH_ID_S classid=<%=Util.CLSID_LUXECOMBO%> width=194
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">VAN사 반송코드</th>
						<td><comment id="_NSID_"> <object
							id=EM_VRTN_CD_S classid=<%=Util.CLSID_EMEDIT%> width=20
							tabindex=1 onKeyUp="javascript:keyPressEventVRTN(event.keyCode);"></object>
						</comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getVrtnPop(EM_VRTN_CD_S, EM_VRTN_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_VRTN_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
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
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=478 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
</body>
</html>
