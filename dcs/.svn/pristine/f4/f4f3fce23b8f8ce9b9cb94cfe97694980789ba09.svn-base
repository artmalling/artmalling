<!-- 
/*******************************************************************************
 * 시스템명 : 회원관리 > 카드관리 > 카드번호변경
 * 작  성  일  : 2016.12.27
 * 작  성  자  : 윤지영
 * 수  정  자  : 
 * 파  일  명  : dctm2035.jsp
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

var returnMap = dialogArguments[0]; 
var strCardNo = dialogArguments[1];
var strCustNo = dialogArguments[2];

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
	
	DS_I_DATA.setDataHeader  ('<gauce:dataset name="H_CARD_NO"/>');
	
	initEmEdit(EM_PRE_CARD_NO, "0000-0000-0000-0000", NORMAL);                   
	initEmEdit(EM_AFT_CARD_NO, "0000-0000-0000-0000", PK);
	initEmEdit(EM_CUST_ID_S, "GEN", NORMAL);              
	//카드등급
	initComboStyle(LC_CARD_GRADE,DS_O_CARD_GRADE, "CODE^0^30,NAME^0^110", 1, NORMAL);       
	getEtcCode("DS_O_CARD_GRADE", "D", "D011", "N"); //카드등급
 
	EM_AFT_CARD_NO.Language = 1; 
	EM_PRE_CARD_NO.Text = strCardNo;  //변경전 카드번호
	EM_CUST_ID_S.Text   = strCustNo;  //고객번호
	
	EM_PRE_CARD_NO.Enable = "false";
	EM_CUST_ID_S.Enable = "false";
	LC_CARD_GRADE.Enable = "false";
	
	EM_AFT_CARD_NO.Focus();
	     
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
 * 개       요 : 회원명 수정
 * return값 : void
 */
 function editCardno(){
    var chk;
    chk=true;

    if(EM_AFT_CARD_NO.text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "변경후 카드번호");
        EM_AFT_CARD_NO.Focus();
        return false;
    }
    if(EM_PRE_CARD_NO.Text == EM_AFT_CARD_NO.text ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "변경전 카드번호와 변경 후 카드번호는 동일할 수 없습니다. 변경 후 카드번호를 확인해주세요.");
        EM_AFT_CARD_NO.Focus();
        return false;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    var strBfCardNo= EM_PRE_CARD_NO.Text; //변경전 카드번호
    var strCardNo  = EM_AFT_CARD_NO.text; //변경후 카드번호
    var strCustNo  = EM_CUST_ID_S.text;   //고객번호

    DS_I_DATA.ClearData();
    DS_I_DATA.Addrow();
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "CUST_ID"   )= strCustNo;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "CARD_NO" )  = strCardNo;
    DS_I_DATA.NameValue(DS_I_DATA.RowPosition, "BF_CARD_NO")= strBfCardNo;

    var goTo        = "editCardnoPro" ;    
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
    //returnMap.put("CARD_NO", EM_AFT_CARD_NO.Text);
        
    window.returnValue = true;
    window.close(); 
 }

 /**
 * Cardgrade()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-27 
 * 개       요 :카드등급을 조회한다.
 * return값 : void
 */
 function Cardgrade(){
	  
	var strCardNo  = EM_AFT_CARD_NO.text; //변경 후 카드번호 
	
	var goTo       = "searchCard" ;    
	var action     = "O";     
	var parameters =  "&strCardNo=" + encodeURIComponent(strCardNo);
	
	TR_MAIN.Action  ="/dcs/dctm203.dm?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CARD=DS_IO_CARD)"; //조회는 O
	TR_MAIN.Post();
	
	if(DS_IO_CARD.CountRow > 0){
		//카드등급
		LC_CARD_GRADE.BindColVal = DS_IO_CARD.NameValue(DS_IO_CARD.RowPosition ,"CARD_GRADE");
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

<!-- 변경후 카드번호 onKillFocus()-->
<script language=JavaScript for=EM_AFT_CARD_NO event=onKillFocus()> 
    if(trim(EM_AFT_CARD_NO.Text).length == "13"){
    	//카드등급 조회
    	Cardgrade();
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
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_I_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_CARD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script> 

<comment id="_NSID_">
<object id="DS_O_CARD_GRADE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script> 

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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
							align="absmiddle" class="popR05 PL03" /> 카드번호 수정</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/save.gif" tabindex=2
									onClick="editCardno()" /></td>
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
								<th width="100">변경전 카드번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_PRE_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=380
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th width="100" class="point">변경후 카드번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_AFT_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=380
									tabindex=1
									onkeyup="javascript:checkByteStr(EM_AFT_CARD_NO, 40, '');"
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="100">카드등급</th>
								<td><comment id="_NSID_"> <object
									id=LC_CARD_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=158
									tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
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
