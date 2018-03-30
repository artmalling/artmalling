<!-- 
/*******************************************************************************
 * 시스템명 : 회원관리 > 카드관리 > 휴대전화변경 팝업
 * 작  성  일  : 2016.12.27
 * 작  성  자  : 윤지영
 * 수  정  자  : 
 * 파  일  명  : dctm2036.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2016.12.27 (윤지영) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">

var returnMap 	  = dialogArguments[0]; 
var strmobile_ph1 = dialogArguments[1];
var strmobile_ph2 = dialogArguments[2];
var strmobile_ph3 = dialogArguments[3]; 
var strCustNo 	  = dialogArguments[4]; 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 /**
 * doInit()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-27 
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */  
 function doInit(){ 
	
	DS_I_DATA.setDataHeader  ('<gauce:dataset name="H_TEL_NO"/>');
	
    initEmEdit(EM_MOBILE_PH1,   	"0000",     PK);
    initEmEdit(EM_MOBILE_PH2,   	"0000",     PK);
    initEmEdit(EM_MOBILE_PH3,   	"0000",     PK);   
    initEmEdit(EM_AFT_MOBILE_PH1,   "0000", 	PK);
    initEmEdit(EM_AFT_MOBILE_PH2,   "0000", 	PK);
    initEmEdit(EM_AFT_MOBILE_PH3,   "0000",  	PK);   
	initEmEdit(EM_CUST_ID_S, 		"GEN", 		NORMAL);        
	
	//변경전 휴대전화
	EM_MOBILE_PH1.Text = strmobile_ph1;  
	EM_MOBILE_PH2.Text = strmobile_ph2;   
	EM_MOBILE_PH3.Text = strmobile_ph3;  
	//고객번호
	EM_CUST_ID_S.Text   = strCustNo;  

	EM_MOBILE_PH1.Enable = "false";
	EM_MOBILE_PH2.Enable = "false";
	EM_MOBILE_PH3.Enable = "false";
	EM_CUST_ID_S.Enable = "false";
	
	EM_AFT_MOBILE_PH1.Focus(); 
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
 * btn_Close()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-27 
 * 개       요 : 닫기
 * return값 : void
 */
 function btn_Close(){
	window.close();
 }

 /**
 * editCardno()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-27 
 * 개       요 : 휴대전화 수정
 * return값 : void
 */
 function editTelno(){
    var chk;
    chk=true;

    if(EM_AFT_MOBILE_PH1.text == "" || EM_AFT_MOBILE_PH2.text == "" || EM_AFT_MOBILE_PH3.text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "변경후 휴대번호");
        EM_AFT_CARD_NO.Focus();
        return false;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    //변경전 휴대전화
    var strBfTelNo1= EM_MOBILE_PH1.Text; 
    var strBfTelNo2= EM_MOBILE_PH2.Text; 
    var strBfTelNo3= EM_MOBILE_PH3.Text;  
    //변경후 휴대전화
    var strTelNo1= EM_AFT_MOBILE_PH1.Text; 
    var strTelNo2= EM_AFT_MOBILE_PH2.Text; 
    var strTelNo3= EM_AFT_MOBILE_PH3.Text; 
    //고객번호
    var strCustNo  = EM_CUST_ID_S.text;   

    DS_I_DATA.ClearData();
    DS_I_DATA.Addrow(); 
    
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "CUST_ID") 		= strCustNo;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "BF_MOBILE_PH1") = strBfTelNo1;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "BF_MOBILE_PH2") = strBfTelNo2;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "BF_MOBILE_PH3") = strBfTelNo3;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "AFT_MOBILE_PH1")= strTelNo1;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "AFT_MOBILE_PH2")= strTelNo2;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "AFT_MOBILE_PH3")= strTelNo3;
    
    var goTo        = "editTelnoPro";    
    var action      = "I";
    TR_MAIN.Action  = "/dcs/dctm203.dm?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_I_DATA=DS_I_DATA)";
    TR_MAIN.Post();

    saveClose();
 }

 /**
 * saveClose()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-27 
 * 개       요 :  
 * return값 : void
 */
 function saveClose(){
    var strColumnId = ""; 
    returnMap.put("AFT_MOBILE_PH1", EM_AFT_MOBILE_PH1.Text);
    returnMap.put("AFT_MOBILE_PH2", EM_AFT_MOBILE_PH2.Text);
    returnMap.put("AFT_MOBILE_PH3", EM_AFT_MOBILE_PH3.Text);
        
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
							align="absmiddle" class="popR05 PL03" /> 휴대전화 수정</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/save.gif" tabindex=2
									onClick="editTelno()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
									height="22" onClick="btn_Close();" tabindex=3 /></td>
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
								<th width="100">변경전 휴대전화</th>
								<td><comment id="_NSID_"> <object
									id=EM_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"> </object> </comment>
									<script> _ws_(_NSID_);</script> -
									<comment id="_NSID_"> <object
									id=EM_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"> </object> </comment>
									<script> _ws_(_NSID_);</script> -
									<comment id="_NSID_"> <object
									id=EM_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"> </object> </comment>
									<script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="100" class="point">변경후 휴대전화</th>
								<td><comment id="_NSID_"> <object
									id=EM_AFT_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"> </object> </comment>
									<script> _ws_(_NSID_);</script> -
									<comment id="_NSID_"> <object
									id=EM_AFT_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"> </object> </comment>
									<script> _ws_(_NSID_);</script> -
									<comment id="_NSID_"> <object
									id=EM_AFT_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=30
									tabindex=1 align="absmiddle"> </object> </comment>
									<script> _ws_(_NSID_);</script>
							    </td>
							</tr>
							<tr>
								<th width="100">회원아이디</th>
								<td><comment id="_NSID_"> <object id=EM_CUST_ID_S
									classid=<%=Util.CLSID_EMEDIT%> width=380 align="absmiddle">
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
