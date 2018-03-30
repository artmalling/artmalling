<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 약속관리> 화원정보조회
 * 작 성 일 : 2011.06.27
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ecmn105.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 화원정보조회
 * 이    력 : 2011.06.27 (김유완) 신규작성 
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

<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
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
<script language="javascript">
 /*************************************************************************
  * 0. 전역변수
  *************************************************************************/
 var xhr    = null; //XMLHttpRequest 객체(전역)
 var xhrSave= null; //XMLHttpRequest 객체(전역)
 var strXhr = null;         //Main Json
 var strXhrSave = null;     //Save Json
 /*************************************************************************
  * 1. 초기설정
  *************************************************************************/
 /**
  * doInit()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-06-27
  * 개    요 : 해당 페이지 LOAD 시  
  * return값 : void
  */
 function doinit(){
     //버튼비활성화
     enableControl(BTN_NEWROW,  true);  // 신규    
     enableControl(BTN_DEL,     false); // 삭제
     enableControl(BTN_SAVE,    true);  // 저장
     enableControl(BTN_EXCEL,   false); // 엑셀
     enableControl(BTN_PRINTS,  false); // 프린터
     enableControl(BTN_CONF,    false); // 확정

     document.getElementById("TXT_ALLOW_DT1").value= <%=today%>;
     document.getElementById("TXT_ALLOW_DT2").value= <%=today%>;
     document.getElementById("TXT_ALLOW_DT3").value= <%=today%>;
     document.getElementById("TXT_ALLOW_DT4").value= <%=today%>;
     
     // 조회조건 초기화 주민번호
	 document.getElementById("TXT_CARD_NO").value   = "";
	 document.getElementById("TXT_CARD_PW").value   = "";
	 // 회원정보 초기화
	 document.getElementById("TXT_CUST_NAME").value= "";
	 document.getElementById("TXT_BRCH_NAME").value= "B010000001";
	 document.getElementById("TXT_CARD_NO").disabled = false;
	 document.getElementById("RD_CHK_DUP_N").checked = true;
	 document.getElementById("TXT_BIRTH_DT").value= "";
	 document.getElementById("TXT_HP1").value= "010";
	 document.getElementById("TXT_HP2").value= "";
	 document.getElementById("TXT_HP3").value= "";
	 document.getElementById("TXT_POST_NO").value= "";
	 document.getElementById("TXT_HADDR1").value= "";
	 document.getElementById("TXT_HADDR2").value= "";
	 document.getElementById("TXT_HADDR_O").value= "";

	 
	 document.getElementById("TXT_HP1").disabled = false;
	 document.getElementById("TXT_HP2").disabled = false;
	 document.getElementById("TXT_HP3").disabled = false;
	 
	 document.getElementById("RD_BIRTH_S").checked = true;
	 document.getElementById("RD_SEX_M").checked = true;
	 document.getElementById("RD_SMS_Y").checked = true;
	 document.getElementById("RD_POST_H").checked = true;
	 //document.getElementById("RD_ENTR_GAIN0").checked = true;
	 
	 document.getElementById("RD_ALLOW_Y1").checked = true;
	 document.getElementById("RD_ALLOW_Y2").checked = true;
	 document.getElementById("RD_ALLOW_Y3").checked = true;
	 document.getElementById("RD_ALLOW_Y4").checked = true;
	 
	 rdDisabled(false);
	 
	 document.getElementById("RD_ENTR_GAIN0").checked = false;
	 document.getElementById("RD_ENTR_GAIN1").checked = false;
	 document.getElementById("RD_ENTR_GAIN2").checked = false;

 }
 
 /*************************************************************************
  * 2. 버튼
  *************************************************************************/

 /**
  * btn_Sch()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  조회  
  * return값 : void
  */
 function btn_Sch(){
	// 회원정보 초기화
	//document.getElementById("TXT_CUST_NAME").value= "";
	//document.getElementById("TXT_ENTR_DATE").value= "";
	//document.getElementById("TXT_BRCH_NAME").value= "";
	//document.getElementById("TXT_NOTIC_ETC").value= "";
	//alert("!");
	  
	// 초기화
	//if (!checkValidateSearch()) return;
	
	
 }
 
 /**
  * btn_New()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  신규  
  * return값 : void
  */
 function btn_New(){
	 
	 // 입력 초기화 
	 var rtn = showMessage(INFORMATION, YESNO, "USER-1000",  "입력 내용을 초기화 하시겠습니까?");
		     	
	 if (rtn!=1) {
		     		
		return false;
		     	
	 }
	 doinit();
	 document.getElementById("TXT_CARD_NO").focus();
 }
 
 /*************************************************************************
  * 3. 함수
  *************************************************************************/
 
 /**
  * checkValidateSearch()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidateSearch() {
	var strSSNO1 = document.getElementById("TXT_SS_NO1").value;
	var strSSNO2 = document.getElementById("TXT_SS_NO2").value;
	//발송유형
	if (strSSNO1.length < 6) {
		showMessage(INFORMATION, OK, "USER-1003", "주민등록번호 앞자리(생년월일)");
		document.getElementById("TXT_SS_NO1").focus();
		return false;
	}
	
	//수신번호1
	if (strSSNO2.length < 7) {
		showMessage(INFORMATION, OK, "USER-1003", "주민등록번호 뒷자리");
		document.getElementById("TXT_SS_NO2").focus();
		return false;
	}
	
	//주민등록번호 정합성 체크
    if (!juminCheck(strSSNO1+""+ strSSNO2)) {
    	showMessage(INFORMATION, OK, "USER-1000", "주민등록번호가 올바르지 않습니다."); 
    	document.getElementById("TXT_NOTIC_ETC").value = "주민등록번호가 올바르지 않습니다.";
		return false;
    }
	return true;
 }
 
 /**
  * responseAjaxMst()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터GET
  * return값 : void
  */ 
 function responseAjaxMst(){
	if(xhr.readyState==4) {
	    if(xhr.status == 200) {
		    strXhr = eval(xhr.responseText); 
		    if (strXhr == undefined) {
                showMessage(Question, OK, "USER-1000", "잘못된 카드 번호 입니다.");
                document.getElementById("TXT_CARD_NO").value="";
                document.getElementById("TXT_CARD_NO").focus();
		    } else {
                
		     	var strRes = strXhr[0].CUST_ID
		     	
		     	if (strRes.length !=0) {
		     		showMessage(Question, OK, "USER-1000", "이미 등록된 카드 입니다.");
		     		document.getElementById("TXT_CARD_NO").value="";
	                document.getElementById("TXT_CARD_NO").focus();
		     	}
		     	else {
		     		document.getElementById("TXT_CARD_NO").disabled = true; 
		     	}
		    }
		} 
	}
 }

 /**
  * btn_Save()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  조회  
  * return값 : void
  */
 function btn_Save(){
    
	  //alert(<%= userid%>);
	  //SaveSSNO(); 
	  if (!document.getElementById("RD_ENTR_GAIN0").checked&&!document.getElementById("RD_ENTR_GAIN1").checked){
		  
		  showMessage(Information, OK, "USER-1000", "<b>가입 혜택</b> 선택은 필수 사항입니다.");
		  document.getElementById("RD_ENTR_GAIN0").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_CARD_NO").value.length < 13) {
		  
		  showMessage(Information, OK, "USER-1000", "올바른 <b>카드번호</b>가 아닙니다.<br><br> 다시 확인해주십시오.");
		  document.getElementById("TXT_CARD_NO").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_CARD_NO").disabled == false) {
		  
		  showMessage(Information, OK, "USER-1000", "<b>카드번호</b>가 유효한지 다시 확인해주십시오.");
		  document.getElementById("TXT_CARD_NO").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_CARD_PW").value.length < 4) {
		  
		  showMessage(Information, OK, "USER-1000", "<b>카드비밀번호</b>는 4자리를 입력해주십시오.");
		  document.getElementById("TXT_CARD_PW").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_CUST_NAME").value == "") {
		  
		  showMessage(Information, OK, "USER-1000", "<b>고객명</b>은 필수 입력 사항입니다.");
		  document.getElementById("TXT_CUST_NAME").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_BIRTH_DT").value.length < 8) {
		  
		  showMessage(Information, OK, "USER-1000", "<b>생년월일</b>은 필수 입력 사항입니다.");
		  document.getElementById("TXT_BIRTH_DT").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_POST_NO").value =="" ||
	      document.getElementById("TXT_HADDR1").value ==""  ) {
		  
		  showMessage(Information, OK, "USER-1000", "<b>자택 주소</b>는 필수 입력 사항입니다.");
		  sample4_execDaumPostcode();
		  return false;
		  
	  }
	  
	  if (document.getElementById("RD_ALLOW_N1").checked) {

		  showMessage(Information, OK, "USER-1000", "<b>개인정보의 수집 및 이용 동의</b>는 필수 사항입니다.");
		  document.getElementById("RD_ALLOW_Y1").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("RD_ALLOW_N2").checked) {

		  showMessage(Information, OK, "USER-1000", "<b>고유식별정보 수집 및 이용 동의</b>는 필수 사항입니다.");
		  document.getElementById("RD_ALLOW_Y2").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("RD_ALLOW_N3").checked) {

		  showMessage(Information, OK, "USER-1000", "<b>개인정보 처리업무 위탁 동의</b>는 필수 사항입니다.");
		  document.getElementById("RD_ALLOW_Y3").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("RD_ALLOW_N4").checked) {

		  showMessage(Information, OK, "USER-1000", "<b>개인정보 제3자 제공동의</b>는 필수 사항입니다.");
		  document.getElementById("RD_ALLOW_Y4").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("RD_CHK_DUP_N").checked){
		  
		  showMessage(Information, OK, "USER-1000", "<b>본인인증</b>이 진행되지 않았습니다.");
		  //document.getElementById("RD_ALLOW_Y4").focus();
		  return false;
		  
	  }
	  
	  if (document.getElementById("TXT_BRCH_NAME").value == ""){
		  
		  showMessage(Information, OK, "USER-1000", "<b>가입점</b> 선택은 필수 사항입니다.");
		  //document.getElementById("RD_ALLOW_Y4").focus();
		  return false;
		  
	  }
	  

	  
	  SaveSSNO();  
	  
 }
 

 /**
  * SaveSSNO()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  조회  
  * return값 : void
  */
 function SaveSSNO(){
	  
	  var Msg = "* 가입 혜택 : ";
	  
	  if (document.getElementById("RD_ENTR_GAIN0").checked) {
		  
		  Msg = Msg + "<b>포인트 적립</b>";
		  
	  }
	  else if (document.getElementById("RD_ENTR_GAIN1").checked) {
		  Msg = Msg + "<b>현장 즉시 할인</b>";
	  }
	  else if (document.getElementById("RD_ENTR_GAIN2").checked) {
		  Msg = Msg + "<b>사은품 지급</b>";
	  }
	  
	  var rtn = showMessage(Question, YESNO, "USER-1000",  "저장 하시겠습니까?<br><br>" +  Msg);
   	
		 if (rtn!=1) {
			     		
			return false;
			     	
		 }  
	  
    
    var strCardNo 	= document.getElementById("TXT_CARD_NO").value;
    var strCardPw 	= document.getElementById("TXT_CARD_PW").value;
    var strCustNm 	= document.getElementById("TXT_CUST_NAME").value;
	var strBrchCd 	= document.getElementById("TXT_BRCH_NAME").value;
	var strBirthDt	= document.getElementById("TXT_BIRTH_DT").value;
	var strHP1		= document.getElementById("TXT_HP1").value;
	var strHP2		= document.getElementById("TXT_HP2").value;
	var strHP3		= document.getElementById("TXT_HP3").value;
	var strPostNo 	= document.getElementById("TXT_POST_NO").value;
	var strHaddr1 	= document.getElementById("TXT_HADDR1").value;
	var strHaddr2 	= document.getElementById("TXT_HADDR2").value;
	var strHaddrO 	= document.getElementById("TXT_HADDR_O").value;
	var strAllowDt1 = document.getElementById("TXT_ALLOW_DT1").value;
	var strAllowDt2 = document.getElementById("TXT_ALLOW_DT2").value;
	var strAllowDt3 = document.getElementById("TXT_ALLOW_DT3").value;
	var strAllowDt4 = document.getElementById("TXT_ALLOW_DT4").value;
	
	var strBirthGb	= "";
	
	if(document.getElementById("RD_BIRTH_S").checked) {
		strBirthGb = "S"
	}
	else if (document.getElementById("RD_BIRTH_L").checked){
		strBirthGb = "L"
	}
    
	var strSex	= "";
	
	if(document.getElementById("RD_SEX_M").checked) {
		strSex = "M"
	}
	else if (document.getElementById("RD_SEX_F").checked){
		strSex = "F"
	}	
	
	var strSmsYn	= "";
	
	if(document.getElementById("RD_SMS_Y").checked) {
		strSmsYn = "Y"
	}
	else if (document.getElementById("RD_SMS_N").checked){
		strSmsYn = "N"
	}	
	
	var strPostHo	= "";
	
	if(document.getElementById("RD_POST_H").checked) {
		strPostHo = "H"
	}
	else if (document.getElementById("RD_POST_O").checked){
		strPostHo = "O"
	}	
	
	var strDi	= "";
	
	if(document.getElementById("RD_ENTR_GAIN0").checked) {
		strDi = "0"
	}
	else if (document.getElementById("RD_ENTR_GAIN1").checked){
		strDi = "1"
	}
	else if (document.getElementById("RD_ENTR_GAIN2").checked){
		strDi = "2"
	}
	

	var strAllow1	= "";
		
	if(document.getElementById("RD_ALLOW_Y1").checked) {
		strAllow1 = "Y"
	}
	else if (document.getElementById("RD_ALLOW_N1").checked){
		strAllow1 = "N"
	}
	
	var strAllow2	= "";
	
	if(document.getElementById("RD_ALLOW_Y2").checked) {
		strAllow2 = "Y"
	}
	else if (document.getElementById("RD_ALLOW_N2").checked){
		strAllow2 = "N"
	}
	
	var strAllow3	= "";
	
	if(document.getElementById("RD_ALLOW_Y3").checked) {
		strAllow3 = "Y"
	}
	else if (document.getElementById("RD_ALLOW_N3").checked){
		strAllow3 = "N"
	}
	
	var strAllow4	= "";
	
	if(document.getElementById("RD_ALLOW_Y4").checked) {
		strAllow4 = "Y"
	}
	else if (document.getElementById("RD_ALLOW_N4").checked){
		strAllow4 = "N"
	}

    var param = "&goTo=saveSSNO"   + "&strCardNo="     + encodeURIComponent(strCardNo)
    							   + "&strCardPw="     + encodeURIComponent(strCardPw)
    							   + "&strCustNm="     + encodeURIComponent(strCustNm)
    							   + "&strBrchCd="     + encodeURIComponent(strBrchCd)
    							   + "&strBirthDt="    + encodeURIComponent(strBirthDt)
    							   + "&strHP1="        + encodeURIComponent(strHP1)
    							   + "&strHP2="    	   + encodeURIComponent(strHP2)
    							   + "&strHP3="        + encodeURIComponent(strHP3)
    							   + "&strPostNo="     + encodeURIComponent(strPostNo)
    							   
    							   + "&strHaddr1="     + encodeURIComponent(strHaddr1)
    							   + "&strHaddr2="     + encodeURIComponent(strHaddr2)
    							   + "&strHaddrO="     + encodeURIComponent(strHaddrO)
    							   + "&strAllowDt1="   + encodeURIComponent(strAllowDt1)
    							   + "&strAllowDt2="   + encodeURIComponent(strAllowDt2)
    							   + "&strAllowDt3="   + encodeURIComponent(strAllowDt3)
    							   + "&strAllowDt4="   + encodeURIComponent(strAllowDt4)
    							   
    							   + "&strBirthGb="    + encodeURIComponent(strBirthGb)
    							   + "&strSex="        + encodeURIComponent(strSex)
    							   + "&strSmsYn="      + encodeURIComponent(strSmsYn)
    							   + "&strPostHo="     + encodeURIComponent(strPostHo)
    							   + "&strDi="     	   + encodeURIComponent(strDi)
    							   + "&strAllow1="     + encodeURIComponent(strAllow1)
    							   + "&strAllow2="     + encodeURIComponent(strAllow2)
    							   + "&strAllow3="     + encodeURIComponent(strAllow3)
    							   + "&strAllow4="     + encodeURIComponent(strAllow4)
    							   + "&strEntrDt="     + encodeURIComponent(<%=today%>)
   								   + "&strStrCd="     + encodeURIComponent(<%=strcd%>)
    							   ;

    
    
    
    //XMLHttpRequest 객체얻기
    xhrSave = createXMLHttpRequest();
    var url = "/edi/ecmn105.em?"+param;//URL
    xhrSave.onreadystatechange = responseAjaxSaveSSNO;  //콜백 함수  등록
    xhrSave.open("POST", url, true);//연결
    xhrSave.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
    xhrSave.send(null);//전송
 }
 
 /**
  * responseAjaxSaveSSNO()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  저장메시지
  * return값 : void
  */ 
  function responseAjaxSaveSSNO(){
	    if(xhrSave.readyState==4) {
	        if(xhrSave.status == 200) {
	            strXhrSave = eval(xhrSave.responseText); 
	            if (strXhrSave == undefined) {
	                showMessage(INFORMATION, OK, "GAUCE-1000", "저장에 실패 했습니다!");
	            } else {
	            	 
	                showMessage(QUESTION, OK, "GAUCE-1000", strXhrSave[0].MSG);
	                
	                if (strXhrSave[0].CD == "T") {
		                doinit();
		                document.getElementById("TXT_CARD_NO").focus();
		                
	            	}
	            }
	        } 
	    }
	 }
 
 /**
  * autoSetFocus()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  포커스 자동이동
  * return값 : void
  */ 
 function autoSetFocus(obj){
	 var strSSNO1 = document.getElementById("TXT_SS_NO1").value;
	 var strSSNO2 = document.getElementById("TXT_SS_NO2").value;
	 
	 if (obj.id == "TXT_SS_NO1") {
		 if (strSSNO1.length == 6) {
			 if (strSSNO2.length == 7) {
				 //btn_Sch();
				 document.getElementById("TXT_SS_NO2").focus();
			 } else {
				 document.getElementById("TXT_SS_NO2").focus();
			 }
		 }
	 } else {
         if (strSSNO2.length == 7) {
             if (strSSNO1.length == 6) {
                 btn_Sch();
             } else {
                 document.getElementById("TXT_SS_NO1").focus();
             }
         } 
	 } 
 }
 

 /**
 * juminCheck(jumin)
 * 작 성 자 : FKL
 * 작 성 일 : 2006.12.01
 * 개    요 : 주민번호 Check
 * 사용방법 : juminCheck("12345671234567")
 * return값 : true/false
 */
 function juminCheck( str ) {

     if(str =='') return false;  //공백이라면

     var mm = str.substring(2, 4);
     var dd = str.substring(4, 6);
     //str = getRawData(str);  // "-" 제거
     var  j=9
     var  id_chk=0

     object =  new Array(13)
     for(var i=0;i < 13;i++) {
         object[i] = str.substring(i,i+1)
     }
     var chkdigit = str.substring(12, 13)
     for(var i=0;i < 12;i++){
         if( i == 8 )
         j = 9
         object[i]=object[i]*j
         j--
         id_chk +=object[i]
     }
     if(mm == "00" || dd == "00"){
          return false;
     }else if(parseInt(mm) > 12 || parseInt(dd) > 31){
          return false;
     }else if(((id_chk%11 == 0) && (chkdigit == 1)) || ((id_chk%11 ==10)&& (chkdigit ==0))){
          return true;
     }
     else if((id_chk %11 != 0) && (id_chk % 11 != 10 ) && (id_chk % 11 == chkdigit)){
          return true;
     }
     else{
          return false;
     }
 }
 
 function sample4_execDaumPostcode() {
     new daum.Postcode({
         oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

             // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
             var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
             var extraRoadAddr = ''; // 도로명 조합형 주소 변수

             // 법정동명이 있을 경우 추가한다. (법정리는 제외)
             // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
             if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                 extraRoadAddr += data.bname;
             }
             // 건물명이 있고, 공동주택일 경우 추가한다.
             if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
             }
             // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
             if(extraRoadAddr !== ''){
                 extraRoadAddr = ' (' + extraRoadAddr + ')';
             }
             // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
             if(fullRoadAddr !== ''){
                 fullRoadAddr += extraRoadAddr;
             }
             
             if(data.userSelectedType == 'R'){}
             	//document.getElementById('EM_HOME_NEW_YN').text = 'Y';
             else{}
             	//document.getElementById('EM_HOME_NEW_YN').text = 'N';
             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             document.getElementById("TXT_POST_NO").value = data.zonecode; //5자리 새우편번호 사용
             //document.getElementById('EM_HNEW_ZIP_CD1').text = data.zonecode; //5자리 새우편번호 사용

             document.getElementById("TXT_HADDR1").value = fullRoadAddr;       // 도로명주소
             document.getElementById("TXT_HADDR_O").value = data.jibunAddress;   //지번주소
             
             //document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
				document.getElementById("TXT_HADDR2").focus();
				
             // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
             if(data.autoRoadAddress) {
                 //예상되는 도로명 주소에 조합형 주소를 추가한다.
                 var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                 //document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

             } else if(data.autoJibunAddress) {
                 var expJibunAddr = data.autoJibunAddress;
                 //document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

             } else {
                 //document.getElementById('guide').innerHTML = '';
             }
         }
     }).open();
 }

 function chkCardNo() {
	 
	 var strCardNo = document.getElementById("TXT_CARD_NO").value;    // 주민번호 앞자리 
	 	
	 	if (trim(strCardNo)=="") return false;
	 
		var param = "&goTo=getMaster"   + "&strCardNo="     + strCardNo ;
	    
	    //XMLHttpRequest 객체얻기
	    xhr = createXMLHttpRequest();
	    var url = "/edi/ecmn105.em?"+param;//URL
	    xhr.onreadystatechange = responseAjaxMst;  //콜백 함수  등록
	    xhr.open("POST", url, true);//연결
	    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
	    xhr.send(null);//전송
 }
 


 function chkDupHp(){
 	
     if (document.getElementById("RD_CHK_DUP_Y").checked){
    	 alert("이미 인증을 완료 하였습니다.");
    	 return false;
     }
	 var strHP1 = document.getElementById("TXT_HP1").value;    
	 var strHP2 = document.getElementById("TXT_HP2").value; 
	 var strHP3 = document.getElementById("TXT_HP3").value; 
	 

	 
 	 if(trim(strHP1) == "" || trim(strHP2) == "" || trim(strHP3) == ""){
         showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
         if(trim(strHP1) == ""){
        	 document.getElementById("TXT_HP1").focus();
         }else if(trim(strHP2) == ""){
        	 document.getElementById("TXT_HP2").focus();
         }else if(trim(strHP3) == ""){
        	 document.getElementById("TXT_HP3").focus();
         }
         return false;
     }
 	var param = "&goTo=getChkDup"   + "&strHP1="     + strHP1
 	 								+ "&strHP2="     + strHP2
 	 								+ "&strHP3="     + strHP3;
    
    //XMLHttpRequest 객체얻기
    xhr = createXMLHttpRequest();
    var url = "/edi/ecmn105.em?"+param;//URL
    xhr.onreadystatechange = responseAjaxChkDup;  //콜백 함수  등록
    xhr.open("POST", url, true);//연결
    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
    xhr.send(null);//전송
    
  

 }

 /**
  * responseAjaxChkDup()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터GET
  * return값 : void
  */ 
 function responseAjaxChkDup(){
	if(xhr.readyState==4) {
	    if(xhr.status == 200) {
		    strXhr = eval(xhr.responseText); 
		    
		    
		    if (strXhr == undefined) {
		    	chkScedCust(); // 탈퇴 내역 조회
		    	//sendSMS();
		    	return false;
		    }
		    
		    var strRes = strXhr[0].CUST_NAME;
		    var strEnt = strXhr[0].ENTR_DT;
		    
		
		    if (strRes.length !=0) {
		    	//var rtn = showMessage(INFORMATION, YESNO, "USER-1000",  "이미 등록된 전화번호 입니다. 계속 진행하시겠습니까?");
		     	var rtn = showMessage(INFORMATION, OK, "USER-1000",  "이미 등록된 전화번호 입니다.<br>*고객명 : " 
		     														+ strRes +  " *가입일자 : "+ strEnt);
		     	
		     	return false; //중복되면 가입 처리 진행 안되게 변경
		     	
		     	if (rtn!=1) {
		     		
		     		return false;
		     	
		     	}
		     	else {
		     		// 중복이어도 처리하겠다.. 인증 메세지 전송
		     		//sendSMS();
		     		return false;
		     	}
	     	
			} 

		}
 	}
 }
 
 function chkScedCust(){
	 	
	 var strHP1 = document.getElementById("TXT_HP1").value;    
	 var strHP2 = document.getElementById("TXT_HP2").value; 
	 var strHP3 = document.getElementById("TXT_HP3").value; 
	 

	 
 	 if(trim(strHP1) == "" || trim(strHP2) == "" || trim(strHP3) == ""){
         showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
         if(trim(strHP1) == ""){
        	 document.getElementById("TXT_HP1").focus();
         }else if(trim(strHP2) == ""){
        	 document.getElementById("TXT_HP2").focus();
         }else if(trim(strHP3) == ""){
        	 document.getElementById("TXT_HP3").focus();
         }
         return false;
     }
 	var param = "&goTo=getChkSced"   + "&strHP1="     + strHP1
 	 								+ "&strHP2="     + strHP2
 	 								+ "&strHP3="     + strHP3;
    
    //XMLHttpRequest 객체얻기
    xhr = createXMLHttpRequest();
    var url = "/edi/ecmn105.em?"+param;//URL
    xhr.onreadystatechange = responseAjaxChkSced;  //콜백 함수  등록
    xhr.open("POST", url, true);//연결
    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
    xhr.send(null);//전송
    
  

 }
 
 /**
  * responseAjaxChkSced()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터GET
  * return값 : void
  */ 
 function responseAjaxChkSced(){
	if(xhr.readyState==4) {
	    if(xhr.status == 200) {
	    	strXhr = eval(xhr.responseText); 

		    
		    var strRes = strXhr[0].CUST_NAME;
		    var strEnt = strXhr[0].ENTR_DT;
		    
		    if (strRes != "0") {
	     	
		     	showMessage(INFORMATION, OK, "USER-1000",  strRes);  // 혜택 미적용 알림 메세지

		     	document.getElementById("RD_ENTR_GAIN2").checked = true;
		     	rdDisabled(true);
		     	
		     	var rtn = 0;
		     	// 인증문자 발송
		     	sendSMS();
		     	
		     	if (rtn!=1) {
		     		
		     		return false;
		     	
		     	}
		     	else {
		     		// 중복이어도 처리하겠다.. 인증 메세지 전송
		     		//sendSMS();
		     		return false;
		     	}
	     	
			} else {
				sendSMS();
	     		return false;
			}

		}
 	}
 }
 
 function rdDisabled(tf) {

	 document.getElementById("RD_ENTR_GAIN0").disabled = tf;
	 document.getElementById("RD_ENTR_GAIN1").disabled = tf;
	 //document.getElementById("RD_ENTR_GAIN2").disabled = tf;
	 document.getElementById("RD_ENTR_GAIN2").disabled = true;  // 혜택 미적용은 항상 선택 못하도록 막음
	 
 }
 
 function sendSMS(){
 	

	 
	 var strHP1 	= document.getElementById("TXT_HP1").value;    
	 var strHP2 	= document.getElementById("TXT_HP2").value; 
	 var strHP3 	= document.getElementById("TXT_HP3").value;
	 var strSendGb	= "SMS_ARTBAT";	// 발송시 서비스 구분. SMS_ARTBAT : 배치용 서비스 , SMS_ART : 대량 발송용 서비스
	 
	 var rtn = showMessage(Question, YESNO, "USER-1000",  "<b>"+ strHP1 + " - " +strHP2 + " - " + strHP3
			 						+	" </b><br> 해당 번호로 인증을 진행하시겠습니까?");
	 
	 
	 if (rtn!=1) {
  		
  		return false;
  	
  	}
	 

 	var param = "&goTo=sendSMS"   + "&strHP1="     + strHP1
 	 							  + "&strHP2="     + strHP2
 	 							  + "&strHP3="     + strHP3
 	 							  + "&strUserId="	   + <%=userid%>
 								  + "&strSendGb="	   + strSendGb
 	;
    
    //XMLHttpRequest 객체얻기
    xhr = createXMLHttpRequest();
    var url = "/edi/ecmn105.em?"+param;//URL
    xhr.onreadystatechange = responseAjaxSendSMS;  //콜백 함수  등록
    xhr.open("POST", url, true);//연결
    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');   //한글 (POST시 반듯이 해당문구를 사용해야 Param으로인식)
    xhr.send(null);//전송

 }
 

 /**
  * responseAjaxSendSMS()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  마스터GET
  * return값 : void
  */ 
 function responseAjaxSendSMS(){
	if(xhr.readyState==4) {
	    if(xhr.status == 200) {
		    strXhr = eval(xhr.responseText); 
		    
		    
		    var strRes = strXhr[0].SMS_CD;
		    
		    if (strRes.length !=0) {
		    	//var rtn = showMessage(INFORMATION, YESNO, "USER-1000",  "고객님께 발송된 인증번호가<br><br><b>[ "+strRes+" ] </b> 가 맞습니까? ");
		    	
		    	var arrArg  = new Array(strRes);
		    	
		    	var rtn =  window.showModalDialog("/edi/jsp/ecmn/ecmn1051.jsp?",
                        				arrArg,
                				"dialogWidth:250px;dialogHeight:130px;scroll:no;");
		    	
		    	//alert(rtn);
		    	//return false;
		     	
		     	if (rtn!=1) {
		     		
		     		document.getElementById("TXT_HP1").value = "";
		     		document.getElementById("TXT_HP2").value = "";
		     		document.getElementById("TXT_HP3").value = "";
		     		document.getElementById("TXT_HP1").focus();
		    		showMessage(EXCLAMATION, OK, "USER-1000",  "고객님의 번호를 다시 확인해주시기 바랍니다.");
		    		//alert("고객님의 번호를 다시 확인해주시기 바랍니다.");
		    		return false;
		     	
		     	}
		     	document.getElementById("RD_CHK_DUP_Y").checked = true;  // 인증 성공시
		     	document.getElementById("TXT_HP1").disabled = true;
	     		document.getElementById("TXT_HP2").disabled = true;
	     		document.getElementById("TXT_HP3").disabled = true;
	     	
			} 
		    

	     	
		}
 	}
 }
 
</script>

<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->
</head>
<body class="PL10 PR07 PT15" onload="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="396" class="title"><img
					src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
					align="absmiddle" class="PR05" />회원정보등록</td>
				<td>
				<table border="0" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<!-- >td><img src="<%=dir%>/imgs/btn/search.gif" width="50"
							height="22" id="search" onclick="javascript:btn_Sch();" /></td-->
						<td><img src="<%=dir%>/imgs/btn/new.gif" width="50"
							height="22" id="BTN_NEWROW" onclick="javascript:btn_New();" /></td>
						<td><img src="<%=dir%>/imgs/btn/del.gif" width="50"
							height="22" id="BTN_DEL" onclick="btn_del();" /></td>
						<td><img src="<%=dir%>/imgs/btn/save.gif" width="50"
							height="22" id="BTN_SAVE" onclick="btn_Save();" /></td>
						<td><img src="<%=dir%>/imgs/btn/excel.gif" width="61"
							height="22" id="BTN_EXCEL" onclick="btn_Excel();" /></td>
						<td><img src="<%=dir%>/imgs/btn/print.gif" width="50"
							height="22" id="BTN_PRINTS" /></td>
						<td><img src="<%=dir%>/imgs/btn/set.gif" width="50"
							height="22" id="BTN_CONF" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">카드번호</th>
						<td width="300"><input type="text" name="TXT_CARD_NO" id="TXT_CARD_NO" TITLE = "총 13자리"
							size="18" value="" maxlength="13" 
							onkeypress="javascript:onlyNumber();"
							onkeydown = "if (event.keyCode == 13) chkCardNo();"
							onblur = "javascript:chkCardNo();"
							/></td>
						<th width="80" class="point">카드비밀번호</th>
						<td><input type="text" name="TXT_CARD_PW" id="TXT_CARD_PW" TITLE = "총 4자리"
							size="10" value="" maxlength="4" 
							onkeypress="javascript:onlyNumber();"
							/></td>
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
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title">&nbsp;<img
					src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />회원정보</td>
			</tr>
			<tr>
				<td height="5">
				<td>
			</tr>
			<tr valign="top">
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="80" class="point">성명</th>
								<td width="150"><input type="text" name="TXT_CUST_NAME"
									id="TXT_CUST_NAME" size="18" value=""  /></td>
								<th width="100"  class="point">생년월일</th>
								<td><input type="text" name="TXT_BIRTH_DT"
									id="TXT_BIRTH_DT" size="18" value=""  maxlength="8"  
									onblur="dateCheck(this);" onfocus="dateValid(this);"
									 onkeypress="javascript:onlyNumber();"/> <img
								src="<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',TXT_BIRTH_DT)"
								/></td>
							</tr>
							<tr>
								<th>생일구분</th>
								<td><input type="radio" name="RD_BIRTH_GB"
							id="RD_BIRTH_S" value="S" checked="checked" /> 양력
									<input type="radio" name="RD_BIRTH_GB"
							id="RD_BIRTH_L" value="l" /> 음력</td>
							
								<th width="80" class="point">휴대전화</th>
								<td width="300"><input type="text" name="TXT_HP1"
									id="TXT_HP1" size="4" value="010"  maxlength="3"  />- 
												<input type="text" name="TXT_HP2"
									id="TXT_HP2" size="4" value=""  maxlength="4"  />-
												<input type="text" name="TXT_HP3"
									id="TXT_HP3" size="4" value=""  maxlength="4"  /><img src="<%=dir%>/imgs/btn/real_name2.gif"
								onclick="chkDupHp()"
								align="absmiddle"  />
								<input type="radio" name="RD_CHK_DUP"
								id="RD_CHK_DUP_N" value="N" checked="checked"  disabled /> 미인증
									<input type="radio" name="RD_CHK_DUP"
								id="RD_CHK_DUP_Y" value="Y" disabled /> 인증</td>
							</tr>
							<tr>
								<th>성별구분</th>
								<td><input type="radio" name="RD_SEX"
							id="RD_SEX_M" value="M" checked="checked" /> 남성
									<input type="radio" name="RD_SEX"
							id="RD_SEX_F" value="F" /> 여성</td>
								<th>SMS 수신동의</th>
								<td><input type="radio" name="RD_SMS_YN"
							id="RD_SMS_Y" value="Y" checked="checked" /> 동의
									<input type="radio" name="RD_SMS_YN"
							id="RD_SMS_N" value="N" /> 미동의</td>
							</tr>
							<tr>
								<th class = "point">가입점</th>
								<td><input type="text" name="TXT_BRCH_NAME"
									id="TXT_BRCH_NAME" size="20" value="" disabled="disabled" TITLE ="아트몰링" /></td>
								<th>우편물수신동의</th>
								<td><input type="radio" name="RD_POST_YN"
							id="RD_POST_H" value="H" checked="checked" /> 동의
									<input type="radio" name="RD_POST_YN"
							id="RD_POST_O" value="O" /> 미동의</td>
							</tr>
							
							<tr>
								<th class="point">자택주소</th>
								<td colspan ="3"><input type="text" name="TXT_POST_NO"
									id="TXT_POST_NO" size="8" value="" disabled="disabled" TITLE ="우편번호" /> - <img src="<%=dir%>/imgs/btn/search_post_s.gif"
								onclick="sample4_execDaumPostcode();"
								align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR">
								<input type="text" name="TXT_HADDR1"
									id="TXT_HADDR1" size="30" value="" disabled="disabled" TITLE ="신주소" />
							
								<input type="text" name="TXT_HADDR2"
									id="TXT_HADDR2" size="30" value=""  TITLE ="신주소상세" />
									</td>
								
							</tr>
							<tr>
								<th>자택구주소</th>
								<td colspan ="3">
								<input type="text" name="TXT_HADDR_O"
									id="TXT_HADDR_O" size="50" value="" disabled="disabled" TITLE ="구주소" />
									</td>
								
							</tr>
							
							<tr>
								<th>가입혜택</th>
								<td colspan ="3">
								<input type="radio" name="RD_ENTR_GAIN"
							id="RD_ENTR_GAIN0" value="0" /> 포인트적립
									<input type="radio" name="RD_ENTR_GAIN"
							id="RD_ENTR_GAIN1" value="1" /> 즉시할인
									<input type="radio" name="RD_ENTR_GAIN"
							id="RD_ENTR_GAIN2" value="9" /> 혜택미적용
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
	</tr>
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title">&nbsp;<img
					src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />개인정보의 수집 및 이용 동의</td>
			</tr>
			<tr>
				<td height="5">
				<td>
			</tr>
			<tr valign="top">
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="100"  class="point">동의일자</th>
								<td width="180" ><input type="text" name="TXT_ALLOW_DT1"
									id="TXT_ALLOW_DT1" size="18" value=""  maxlength="8"   disabled="disabled" /> <img
								src="<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',TXT_ALLOW_DT1)" 
								onblur="dateCheck(this);" onfocus="dateValid(this);"/></td>
								<th>동의여부</th>
								<td><input type="radio" name="RD_ALLOW_YN1"
								id="RD_ALLOW_Y1" value="Y" checked="checked" /> 동의
									<input type="radio" name="RD_ALLOW_YN1"
								id="RD_ALLOW_N1" value="N" /> 미동의</td>							
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
	
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title">&nbsp;<img
					src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />고유식별정보 수집 및 이용 동의</td>
			</tr>
			<tr>
				<td height="5">
				<td>
			</tr>
			<tr valign="top">
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="100"  class="point">동의일자</th>
								<td width="180" ><input type="text" name="TXT_ALLOW_DT2"
									id="TXT_ALLOW_DT2" size="18" value=""  maxlength="8"   disabled="disabled" /> <img
								src="<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',TXT_ALLOW_DT2)" 
								onblur="dateCheck(this);" onfocus="dateValid(this);"/></td>
								<th>동의여부</th>
								<td><input type="radio" name="RD_ALLOW_YN2"
								id="RD_ALLOW_Y2" value="Y" checked=RD_ALLOW_YN2 /> 동의
									<input type="radio" name="RD_ALLOW_YN2"
								id="RD_ALLOW_N2" value="N" /> 미동의</td>							
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title">&nbsp;<img
					src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />개인정보 처리업무 위탁</td>
			</tr>
			<tr>
				<td height="5">
				<td>
			</tr>
			<tr valign="top">
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="100"  class="point">동의일자</th>
								<td width="180" ><input type="text" name="TXT_ALLOW_DT3"
									id="TXT_ALLOW_DT3" size="18" value=""  maxlength="8"    disabled="disabled"/> <img
								src="<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',TXT_ALLOW_DT3)" 
								onblur="dateCheck(this);" onfocus="dateValid(this);"/></td>
								<th>동의여부</th>
								<td><input type="radio" name="RD_ALLOW_YN3"
								id="RD_ALLOW_Y3" value="Y" checked="checked" /> 동의
									<input type="radio" name="RD_ALLOW_YN3"
								id="RD_ALLOW_N3" value="N" /> 미동의</td>							
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title">&nbsp;<img
					src="<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />개인정보 제3자 제공동의</td>
			</tr>
			<tr>
				<td height="5">
				<td>
			</tr>
			<tr valign="top">
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="100"  class="point">동의일자</th>
								<td width="180" ><input type="text" name="TXT_ALLOW_DT4"
									id="TXT_ALLOW_DT4" size="18" value=""  maxlength="8"   disabled="disabled" /> <img
								src="<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',TXT_ALLOW_DT4)"
								onblur="dateCheck(this);" onfocus="dateValid(this);"/></td>
								<th>동의여부</th>
								<td><input type="radio" name="RD_ALLOW_YN4"
								id="RD_ALLOW_Y4" value="Y" checked="checked" /> 동의
									<input type="radio" name="RD_ALLOW_YN4"
								id="RD_ALLOW_N4" value="N" /> 미동의</td>							
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>

</table>
</body>
</html>

