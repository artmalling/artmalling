<!-- 
/*******************************************************************************
 * 시스템명 : 회원관리 > 카드관리 > 생년월일수정
 * 작  성  일  : 2010.03.02
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm2031.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.03.02 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<% String dir = BaseProperty.get("context.common.dir"); %>
<% 
String ssNo   = (request.getParameter("ssNo")   != null && !"".equals(request.getParameter("ssNo").trim()))   ? request.getParameter("ssNo")   :"";
String custId = (request.getParameter("custId") != null && !"".equals(request.getParameter("custId").trim())) ? request.getParameter("custId") :"";
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strSsnoChk = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap       = dialogArguments[0];

function doInit(){
    
	DS_I_DATA.setDataHeader  ('<gauce:dataset name="H_SSNO"/>');

    initEmEdit(EM_PRE_SS_NO, "000000", NORMAL);                   
    initEmEdit(EM_AFT_SS_NO, "000000", PK);
	initEmEdit(EM_CUST_ID_S, "GEN", NORMAL);              

    EM_PRE_SS_NO.Text = "<%=ssNo%>";
	EM_CUST_ID_S.Text = "<%=custId%>";

    EM_PRE_SS_NO.Enable = "false";
    EM_AFT_SS_NO.Focus();

	EM_CUST_ID_S.Enable = "false";
    
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Close()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 닫기
 * return값 : void
 */
function btn_Close()
{
    window.close();
}

/**
 * editSsno()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : SSNO 수정
 * return값 : void
 */
function editSsno()
{
    var chk;
    if(trim(EM_AFT_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "생년월일");
        EM_AFT_SS_NO.Focus();
        return false;
    }
    if(EM_AFT_SS_NO.Text.substring(6,7)=="1" || EM_AFT_SS_NO.Text.substring(6,7)=="2" 
        || EM_AFT_SS_NO.Text.substring(6,7)=="3" || EM_AFT_SS_NO.Text.substring(6,7)=="4"){
          chk = juminCheck(EM_AFT_SS_NO.Text);
      }else{
          chk = juminCheckFore(EM_AFT_SS_NO.Text);
    }
    if(trim(EM_AFT_SS_NO.text).length == 6) chk = true;
    if(chk==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일이 아닙니다.");
        EM_AFT_SS_NO.Focus();
        return false;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    var strBfSsNo  = EM_PRE_SS_NO.Text
    var strSsno    = EM_AFT_SS_NO.text;
    var strCustid  = EM_CUST_ID_S.text;

    DS_I_DATA.ClearData();
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "SS_NO" )  = EM_AFT_SS_NO.Text;

    var goTo       = "editSsnoPro" ;    
    var action     = "I";
    var parameters = "&strBfSsNo=" + encodeURIComponent(strBfSsNo)
                   + "&strSsno="   + encodeURIComponent(strSsno)
                   + "&strCustid=" + encodeURIComponent(strCustid);    
    TR_MAIN.Action="/dcs/dctm203.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_I_DATA=DS_I_DATA)";
    TR_MAIN.Post();
    
    if(strSsnoChk != "Y"){
       saveClose();
    }
}

function saveClose()
{
    var strColumnId = "";
    returnMap.put("SS_NO", EM_AFT_SS_NO.Text);
        
    window.returnValue = true;
    window.close();
   
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
        var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|');
        var msg = strMsg[0]; 
        strSsnoChk = strMsg[1]; 
        showMessage(INFORMATION, OK, "USER-1000", msg);
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
<script language=JavaScript for=EM_AFT_SS_NO event=onKeyUp(kcode,scode)>
    if(EM_AFT_SS_NO.Text.length==13){
        
        var chk;
        if(EM_AFT_SS_NO.Text.substring(6,7)=="1" || EM_AFT_SS_NO.Text.substring(6,7)=="2" 
            || EM_AFT_SS_NO.Text.substring(6,7)=="3" || EM_AFT_SS_NO.Text.substring(6,7)=="4"){
              chk = juminCheck(EM_AFT_SS_NO.Text);
          }else{
              chk = juminCheckFore(EM_AFT_SS_NO.Text);
        }
        if(trim(EM_AFT_SS_NO.text).length == 6 || trim(EM_AFT_SS_NO.text).length == 6 ) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일이 아닙니다.");
            EM_AFT_SS_NO.Focus();
            return false;
        }
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
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
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="pop01"></td>
		<td class="pop02"></td>
		<td class="pop03"></td>
	</tr>
	<tr>
		<td class="pop04"></td>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="396" class="title"><img
							src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
							align="absmiddle" class="popR05 PL03" /> 생년월일 수정</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/save.gif" tabindex=2
									onClick="editSsno()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" tabindex=3
									height="22" onClick="btn_Close();" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="popT01 PB15">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">변경전 생년월일</th>
								<td><comment id="_NSID_"> <object id=EM_PRE_SS_NO
									classid=<%=Util.CLSID_EMEDIT%> width=60
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100" class="point">변경후 생년월일</th>
								<td><comment id="_NSID_"> <object id=EM_AFT_SS_NO tabindex=1
									classid=<%=Util.CLSID_EMEDIT%> width=60 align="absmiddle">
								</object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100">회원아이디</th>
								<td><comment id="_NSID_"> <object id=EM_CUST_ID_S
									classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle">
								</object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td class="pop06"></td>
	</tr>
	<tr>
		<td class="pop07"></td>
		<td class="pop08"></td>
		<td class="pop09"></td>
	</tr>
</table>
</body>
</html>
