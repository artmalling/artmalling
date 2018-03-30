<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 기명회원 가입 신청서 팝업
 * 작  성  일  : 2010.01.25
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm1031.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.25 (김영진) 신규작성
 *           2010.02.14 (김영진) 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap   = dialogArguments[0];
var strCustId   = dialogArguments[1];
var strCustNm   = dialogArguments[2];
var strCardNo   = dialogArguments[3];
var strSsNo     = dialogArguments[4];
function doInit(){
    
    initEmEdit(EM_CUST_BUSI_NM1, "GEN^40", NORMAL);
	initEmEdit(EM_CUST_ID1, "GEN^40", NORMAL);
    initEmEdit(EM_CARD_NO1, "0000-0000-0000-0000", NORMAL);                   
    initEmEdit(EM_SSNO_BUSI_NO1, "000000", NORMAL);

    EM_CUST_BUSI_NM1.Text  = strCustNm;
    EM_CARD_NO1.Text       = strCardNo;
    EM_SSNO_BUSI_NO1.Text  = strSsNo;
    EM_CUST_ID1.Text       = strCustId;

    EM_CUST_BUSI_NM1.Enable = "false";
	EM_CARD_NO1.Enable      = "false";
	EM_SSNO_BUSI_NO1.Enable = "false";

    EM_CUST_ID1.Visible       = "false";
    EM_CUST_ID1.style.display = "none";
}

/*************************************************************************
  * 2. 공통버튼
 *************************************************************************/

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Close()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-14
 * 개       요 : 닫기
 * return값 : void
 */
function btn_Close()
{
    window.close();
}

/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-15
 * 개       요 : 세대관리화면이동
 * return값 : void
 */
function gourl()
{
	var strColumnId = "";

	returnMap.put("CUST_BUSI_NM1", EM_CUST_BUSI_NM1.Text);
	returnMap.put("CARD_NO1",      EM_CARD_NO1.Text);
	returnMap.put("SSNO_BUSI_NO1", EM_SSNO_BUSI_NO1.Text);
	returnMap.put("CUST_ID1",      EM_CUST_ID1.Text);

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
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
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
<form name="myForm" target="myhiddenFrame"><input type="hidden"
	name="pid"> <input type="hidden" name="url"> <input
	type="hidden" name="lcode"> <input type="hidden" name="mcode">
<input type="hidden" name="title"></form>
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
							align="absmiddle" class="popR05 PL03" /> 기명회원 카드번호 발급</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/hhold.gif"
									onClick="gourl();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
									height="22" onClick="btn_Close();" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="popT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100">회원명</th>
								<td><comment id="_NSID_"> <object
									id=EM_CUST_BUSI_NM1 classid=<%=Util.CLSID_EMEDIT%> width=380
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="100">생년월일</th>
								<td><comment id="_NSID_"> <object
									id=EM_SSNO_BUSI_NO1 classid=<%=Util.CLSID_EMEDIT%> width=380
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100">카드번호</th>
								<td><comment id="_NSID_"> <object id=EM_CARD_NO1
									classid=<%=Util.CLSID_EMEDIT%> width=380> </object> </comment> <script> _ws_(_NSID_);</script>
								<comment id="_NSID_"> <object id=EM_CUST_ID1
									classid=<%=Util.CLSID_EMEDIT%> width=380> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
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
<iframe name="myhiddenFrame" style="display: none;"></iframe>
