<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 >  VOC 관리  > 컴플레인 현황(POPUP)
 * 작 성 일 : 2016.11.15
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : DVOC0021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>

<%
	String dir = request.getContextPath();
	SessionInfo2 sessionInfo = (SessionInfo2) session
			.getAttribute("sessionInfo2");
	String userid = sessionInfo.getUSER_ID(); // 사용자아이디
	String strcd = sessionInfo.getSTR_CD(); // 점코드
	String strNm = sessionInfo.getSTR_NM(); // 점명
	String vencd = sessionInfo.getVEN_CD(); // 협력사코드
	String venNm = sessionInfo.getVEN_NAME(); // 협력사명
	String gb = sessionInfo.getGB(); // 1.협력사     2.브랜드
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	 String today = formatter.format(new java.util.Date());
%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->


<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인증번호 입력</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script language="javascript" type="text/javascript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var strSmsCd        = dialogArguments[0];

 
/**
 * doInit() 
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	
	document.getElementById("TXT_SMS_CD").value = strSmsCd;
	document.getElementById("TXT_SMS_CONF").value = "";
	    
 }

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * btn_Search()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.04.19
  * 개    요 : 조회시 호출
  * return값 : void
  */
function chk() {
	  
	  var returnValue = "";
	  
	  var cd   = document.getElementById("TXT_SMS_CD").value;
	  var comp = document.getElementById("TXT_SMS_CONF").value;
	  
	  if (trim(cd) == trim(comp)) {
		  alert("인증되었습니다.");
		  returnValue = "1";
		  window.returnValue = returnValue;
		  window.close();
	  }
	  else{
		  	alert("인증번호가 일치하지 않습니다.");
		  	document.getElementById("TXT_SMS_CONF").value ="";
		  	document.getElementById("TXT_SMS_CONF").focus();
		  	return false;
	  }
  }
  
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->  


<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->


<!-- =============== Output용 -->

<!-- =============== ONLOAD용 -->

<!-- =============== 공통함수용 -->

<!--------------------- 2. Transaction  --------------------------------------->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->

<body  onload="doInit();" class="PL10 PT15">


<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<input type="hidden" name="TXT_SMS_CD"
									id="TXT_SMS_CD" size="18" value=""  maxlength="6"   disabled="disabled" display="none"/> 
									<br>
<input type="text" name="TXT_SMS_CONF"
									id="TXT_SMS_CONF" size="18" value=""  maxlength="6" 
									onkeypress="javascript:onlyNumber();"
									onkeydown = "if (event.keyCode == 13) chk();" /> 
					<img
								src="<%=dir%>/imgs/btn/confirm.gif" align="absmiddle"
								onclick="javascript:chk();"
								 /><br>
								 <font size="2px" color="green">* 발송된 인증번호를 확인 후<br> 입력해 주세요.</font>

</body>
</html>
