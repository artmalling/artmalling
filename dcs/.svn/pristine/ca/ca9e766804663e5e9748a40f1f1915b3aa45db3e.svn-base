<!-- 
/*******************************************************************************
 * 시스템명 : 회원관리 > 회원관리 > 카드관리 > 사업자(단체)명 수정
 * 작  성  일  : 2010.03.02
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm2032.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.03.02 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap = dialogArguments[0];
var strCustId = dialogArguments[1];
var strCustNm = dialogArguments[2];
function doInit(){
    
	DS_I_DATA.setDataHeader  ('<gauce:dataset name="H_CUST_NAME"/>');

    initEmEdit(EM_PRE_CUST_NAME, "GEN^40", NORMAL);                   
    initEmEdit(EM_AFT_CUST_NAME, "GEN^40", PK);
	initEmEdit(EM_CUST_ID_S, "GEN", NORMAL);              

    EM_PRE_CUST_NAME.Text = strCustNm;
    EM_CUST_ID_S.Text     = strCustId;

    EM_PRE_CUST_NAME.Enable = "false";

    EM_AFT_CUST_NAME.Focus();
    
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
 * editCustnm()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 회원명 수정
 * return값 : void
 */
function editCustnm()
{
    var chk;
    chk=true;

    if(EM_AFT_CUST_NAME.text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "변경후 회원명");
        EM_AFT_CUST_NAME.Focus();
        return false;
    }
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    var strBfCustnm= EM_PRE_CUST_NAME.Text;
    var strCustnm  = EM_AFT_CUST_NAME.text;
    var strCustid  = EM_CUST_ID_S.text;

    DS_I_DATA.ClearData();
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "CUST_ID"   )  = strCustid;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "CUST_NAME" )  = strCustnm;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "BF_CUST_NAME")= strBfCustnm;

    var goTo        = "editCustnmPro" ;    
    var action      = "I";
    TR_MAIN.Action  = "/dcs/dctm203.dm?goTo="+goTo;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_I_DATA=DS_I_DATA)";
    TR_MAIN.Post();

    saveClose();
}

function saveClose()
{
    var strColumnId = ""; 
    returnMap.put("CUST_NAME", EM_AFT_CUST_NAME.Text);
        
    window.returnValue = true;
    window.close();
   
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

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
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
							align="absmiddle" class="popR05 PL03" /> 사업자(단체)명 수정</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/save.gif" tabindex=2
									onClick="editCustnm()" /></td>
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
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="120">변경전 사업자(단체)명</th>
								<td><comment id="_NSID_"> <object
									id=EM_PRE_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=350
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="120" class="point">변경후 사업자(단체)명</th>
								<td><comment id="_NSID_"> <object
									id=EM_AFT_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=350 tabindex=1
									onkeyup="javascript:checkByteStr(EM_AFT_CUST_NAME, 40, '');"
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="120">회원아이디</th>
								<td><comment id="_NSID_"> <object id=EM_CUST_ID_S
									classid=<%=Util.CLSID_EMEDIT%> width=350 align="absmiddle">
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
