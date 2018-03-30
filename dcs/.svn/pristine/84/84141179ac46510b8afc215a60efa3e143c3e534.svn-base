<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 포인트정산 > 기부관리 > 기부세금공제대상조회
 * 작 성 일 : 2010.06.17
 * 작 성 자 : 김영진
 * 수 정 자 : 
 * 파 일 명 : dmtc7060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.17 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String strToYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
    String strSDt = strToYear + "0101";
    String strEDt = strToYear + "1231";
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
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-17
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	 
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); 
    
    //EMedit에 초기화
    initEmEdit(EM_DON_DATE_S,    "YYYYMMDD",    PK);           //시작일
    initEmEdit(EM_DON_DATE_E,    "YYYYMMDD",    PK);           //종료일
    initEmEdit(EM_DON_ID_S,      "GEN^9",       NORMAL);       //기부명
    initEmEdit(EM_DON_NAME_S,    "GEN^40",      READ);         //기부명    
    initEmEdit(EM_DON_POINT_S,   "NUMBER^9^0",  READ);         //조건금액

    //조회일자 초기값.
    EM_DON_DATE_S.text = addDate("Y", "-1", '<%=strSDt%>');
    EM_DON_DATE_E.text = addDate("Y", "-1", '<%=strEDt%>');
    EM_DON_POINT_S.Text = "10000";
    
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"             width=30        align=center</FC>'
                     + '<FC>id=DON_ID        name="기부ID"         width=90       align=center</FC>'
                     + '<FC>id=DON_NAME      name="기부명"         width=120       align=left</FC>'
                     + '<FC>id=CUST_ID       name="회원ID"         width=85        align=center</FC>'
                     + '<FC>id=CUST_NAME     name="회원명"         width=100       align=left</FC>'
                     + '<FC>id=DON_POINT     name="기부포인트"     width=110        align=right</FC>'
                     + '<FC>id=HOME_ZIP_CD   name="우편번호"       width=70        align=center</FC>'
                     + '<FC>id=HOME_ADDR1    name="주소"           width=150       align=left</FC>'
                     + '<FC>id=HOME_ADDR2    name="상세주소"       width=150       align=left</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    var strDonSDt   = EM_DON_DATE_S.Text;
    var strDonEDt   = EM_DON_DATE_E.Text;
    var strDonId    = EM_DON_ID_S.Text;  
    var strDonNm    = EM_DON_NAME_S.Text;
    var strDonPoint = EM_DON_POINT_S.Text;
    
    EXCEL_PARAMS  = "조회기간="  + strDonSDt + "~" + strDonEDt;
    EXCEL_PARAMS += "-기부ID="   + strDonId;
    EXCEL_PARAMS += "-기부명="   + strDonNm;
    EXCEL_PARAMS += "-조건금액=" + strDonPoint;
	
    if (trim(EM_DON_DATE_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회시작일");
        EM_DON_DATE_S.Focus();
        return;
    } else if (trim(EM_DON_DATE_E.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회종료일");
        EM_DON_DATE_E.Focus();
        return;
    }     	

    if(EM_DON_DATE_S.Text > EM_DON_DATE_E.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_DON_DATE_S.Focus();
        return;
    }
	                
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strDonSDt="   + encodeURIComponent(strDonSDt)
                    + "&strDonEDt="   + encodeURIComponent(strDonEDt)
                    + "&strDonId="    + encodeURIComponent(strDonId)
                    + "&strDonPoint=" + encodeURIComponent(strDonPoint);
    TR_MAIN.Action  = "/dcs/dmtc706.dc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GR_MASTER.Focus();        
    }
    else {
        EM_DON_DATE_S.Focus();
    }    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_Excel()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-17
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "기부세금공제대상조회"
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
    GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getDonPop()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-17
 * 개    요 : 기부등록 찾기 팝업
 * 사용방법 : getCustPop(objCd, objNm)
 *            arguments[0] -> 팝업 그리드 더블클릭시 기부등록코드를 받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 기부등록명을 받아올 EMEDIT ID
 * return값 : array
*/
function getDonPop(objCd, objNm)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
       
    arrArg.push(rtnMap);
    arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/dcs/dmtc701.dc?goTo=popUpList",
                                           arrArg,
                                           "dialogWidth:600px;dialogHeight:403px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map = arrArg[0];
        objCd.Text = map.get("DON_ID");
        objNm.Text = map.get("DON_NAME");
    } else {
        if(objNm.Text == "") {
            objCd.Text = "";
            objNm.Text = "";     
            objCd.focus();
        }
    }
}   
  
/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-06-17
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    
    EM_DON_NAME_S.Text = "";//조건입력시 코드초기화 
    if (EM_DON_ID_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_DON_ID_S.Text.length == 9) { //TAB,ENTER 키 실행시에만 
                
            var strDonId   = EM_DON_ID_S.Text;
            var goTo       = "getOneWithoutPop" ;    
            var action     = "O";     
            var parameters = "&strDonId="+encodeURIComponent(strDonId);
            TR_MAINs="/dcs/dmtc701.dc?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
            TR_MAIN.Post();
               
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_DON_ID_S.Text   = DS_O_RESULT.NameValue(1, "DON_ID");
                EM_DON_NAME_S.Text = DS_O_RESULT.NameValue(1, "DON_NAME");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getDonPop(EM_DON_ID_S, EM_DON_NAME_S)
            }
        }
    }   
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_DON_ID_S event=onKillFocus()>
    if (EM_DON_ID_S.Text.length != 9) {
        EM_DON_NAME_S.Text = "";
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_DON_DATE_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_DON_DATE_S)){
    	EM_DON_DATE_S.text = addDate("Y", "-1", '<%=strSDt%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_DON_DATE_E event=onKillFocus()>
	if(!checkDateTypeYMD(EM_DON_DATE_E)){
		EM_DON_DATE_E.text = addDate("Y", "-1", '<%=strEDt%>');
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
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 팝업용  -->
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
						<th width="80" class="point">조회기간</th>
						<td width="195"><comment id="_NSID_"> <object
							id=EM_DON_DATE_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_DON_DATE_S)" />- <comment
							id="_NSID_"> <object id=EM_DON_DATE_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_DON_DATE_E)" /></td>

						<th width="80">기부명</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_DON_ID_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							onKillFocus="javascript:onKillFocus()"
							onKeyUp="javascript:keyPressEvent(event.keyCode);"></object> </comment> <script> _ws_(_NSID_);</script>

						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" onclick="getDonPop(EM_DON_ID_S, EM_DON_NAME_S)" />
						<comment id="_NSID_"> <object id=EM_DON_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">조건금액</th>
						<td><comment id="_NSID_"> <object id=EM_DON_POINT_S
							classid=<%=Util.CLSID_EMEDIT%> height=100 width=100 tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
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
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GR_MASTER width="100%" height=504
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object></td>
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
