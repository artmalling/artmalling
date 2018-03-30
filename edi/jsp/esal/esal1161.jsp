<!-- 
/*******************************************************************************
 * 시스템명 : 협력사EDI > 커뮤니티 > 협력사원관리
 * 작 성 일 : 2018.03.05
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : esal1161.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 2018.03.05 (jyk) 신규작성 
 *            
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
	SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
	String userid 	= sessionInfo.getUSER_ID(); // 사용자아이디
	String strcd 	= sessionInfo.getSTR_CD(); // 점코드
	String strNm 	= sessionInfo.getSTR_NM(); // 점명
	String vencd 	= sessionInfo.getVEN_CD(); // 협력사코드
	String venNm 	= sessionInfo.getVEN_NAME(); // 협력사명
	String pumbunCd	= sessionInfo.getPUMBUN_CD();      //브랜드코드
	String pumbunNm = sessionInfo.getPUMBUN_NAME();    //브랜드명
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
<title>사원정보</title>
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

 var gstrFlag         = dialogArguments[0];
 var gstrStrCd        = dialogArguments[1];	// 점코드
 var gstrPumbunCd     = dialogArguments[2];	// 브랜드코드
 var gstrEmpSeq       = dialogArguments[3];	// 순번
 
 
 var strMst = "";
 
/**
 * doInit() 
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	 
	if (gstrFlag == "U") {
		//alert("!!");	
		searchEmp();
	} else {
		document.getElementById("STRCD").value = gstrStrCd;
		document.getElementById("PUMBUNCD").value = gstrPumbunCd;
		document.getElementById("PUMBUNNM").value = "<%=pumbunNm%>"
		document.getElementById("EMPSEQ").value = gstrEmpSeq;
	}
	    
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
  * getXMLHttpRequest()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-04-18
  * 개    요 :  인터넷 유효성 체크??
  * return값 : void
  */ 
 function getXMLHttpRequest(){
     if(window.ActiveXObject){
     try{
            return new ActiveXObject("Msxml2.XMLHTTP");
     }
     catch(e1){
      try{
           return new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch (e2){
           return null;
      }
     }
    }
    else if(window.XMLHttpRequest){
         return new XMLHttpRequest();
    }
    else
    {
         return null;
    }
 }

  /**
   * chk()
   * 작 성 자 : jyk
   * 작 성 일 : 2018.03.05
   * 개    요 : 등록 내용 이상유무 체크
   * return값 : void
   */
 function chk() {
 	  
 	  var strTemp = "";
 	  var strTemp2 = "";
 	  
 	  strTemp = document.getElementById("HPNO").value;
 	  strTemp = strTemp.trim();
 	 	/* 연락처 9자리이상 11자리 미만, 숫자만 */
		if( strTemp.length <9||strTemp.length > 11 ){
          showMessage(STOPSIGN, OK, "USER-1000", "연락처가 잘못되었습니다.");
          document.getElementById("HPNO").focus();
          return false;
      	}
		if(!isNumberStr(strTemp)){
	   	  showMessage(EXCLAMATION, OK, "USER-1005",  "연락처");
	   	  document.getElementById("HPNO").focus();
          return false;
		}
		
		strTemp = document.getElementById("EMPNAME").value;
		strTemp = strTemp.trim();
		/* 사원명 필수 */
		if(strTemp.length < 1){
			showMessage(EXCLAMATION, OK, "USER-1003",  "사원명");
			document.getElementById("EMPNAME").focus();
          return false;
		}
		
		strTemp = document.getElementById("ENTRDT").value;
		strTemp = strTemp.replace(/\//gi,"");
		strTemp2 = document.getElementById("ENTRDT").value;
		strTemp2 = strTemp.replace(/\//gi,"");
		/* 입사일자 필수 */
		if(strTemp == ""){
		  showMessage(EXCLAMATION, OK, "USER-1003",  "입사일자");
		  document.getElementById("ENTRDT").focus();
          return false;
		}
		
		strTemp = document.getElementById("RETRDT").value;
		strTemp = strTemp.replace(/\//gi,"");
		/* 퇴사일자 필수 */
		/*
		if(strTemp == ""){
		  showMessage(EXCLAMATION, OK, "USER-1003",  "퇴사일자");
		  document.getElementById("RETRDT").focus();
          return false;
		}
		*/
		/* 입퇴사 일자 비교 */
		/*
		if(strTemp < strTemp2){
			showMessage(EXCLAMATION, OK, "USER-1000",  "퇴사일자는 입사일자보다 과거 일 수 없습니다.");
			document.getElementById("RETRDT").focus();
          return false;
		}
		*/
		save();
 	  
   }
  
 /**
  * save()
  * 작 성 자 : jyk
  * 작 성 일 : 2018.03.05
  * 개    요 : 신규 / 수정 내용 저장
  * return값 : void
  */
function save() {
	  // 저장여부 확인
	  if (showMessage(Question, YESNO, "USER-1010") != 1) return;
	  
	  // 저장 내용 작성 및 호출
	  var strStrCd 		= document.getElementById("STRCD").value;		//점코드
	  var strPumbunCd	= document.getElementById("PUMBUNCD").value;	//브랜드코드
	  var strEmpSeq 	= document.getElementById("EMPSEQ").value;	//순번
	  var strEmpName 	= document.getElementById("EMPNAME").value;	//사원명
	  var strHpNo 		= document.getElementById("HPNO").value;		//연락처
	  var strEntrDt 	= document.getElementById("ENTRDT").value;	//입사일자
	  strEntrDt			= strEntrDt.replace(/\//gi,"");					
	  var strRetrDt		= document.getElementById("RETRDT").value;	//퇴사일자
	  strRetrDt			= strRetrDt.replace(/\//gi,"");
	  
	  var strEmpFlag	= "";											//사원구분
	  if (document.getElementById("EMPFLAG0").checked)
		  strEmpFlag 	= document.getElementById("EMPFLAG0").value;
	  else if (document.getElementById("EMPFLAG1").checked)
		  strEmpFlag 	= document.getElementById("EMPFLAG1").value;
	  else if (document.getElementById("EMPFLAG2").checked) 
		  strEmpFlag 	= document.getElementById("EMPFLAG2").value;
	  
	  var strDelYn		= "";											//삭제구분
	  if (document.getElementById("DEL_Y").checked)
		  strDelYn 		= "Y";
	  else if (document.getElementById("DEL_N").checked)
		  strDelYn 		= "N";
	  
	  var strProcFlag 	= gstrFlag; 
	  
	  var param = "&goTo=save" 	+ "&strStrCd="  	+ encodeURIComponent(strStrCd)
	    						+ "&strPumbunCd=" 	+ encodeURIComponent(strPumbunCd)
	    						+ "&strEmpSeq=" 	+ encodeURIComponent(strEmpSeq)
	    						+ "&strEmpName=" 	+ encodeURIComponent(strEmpName)
	    						+ "&strEntrDt=" 	+ encodeURIComponent(strEntrDt)
	    						+ "&strRetrDt=" 	+ encodeURIComponent(strRetrDt)
	    						+ "&strHpNo=" 		+ encodeURIComponent(strHpNo)
	    						+ "&strEmpFlag=" 	+ encodeURIComponent(strEmpFlag)
	    						+ "&strDelYn=" 		+ encodeURIComponent(strDelYn)
	    						+ "&strProcFlag=" 	+ encodeURIComponent(strProcFlag)
	    						;

	  var Urleren = "/edi/esal116.es";  
	  URL = Urleren + "?" +param; 
	  strMst = getXMLHttpRequest(); 
	  strMst.onreadystatechange = responseSave;
	  strMst.open("POST", URL, true); 
	  strMst.send(null); 
}
	  

/**
 * responseSave()
 * 작 성 자 : jyk
 * 작 성 일 : 2018-03-05
 * 개    요 :  저장처리
 * return값 : void
 */ 
 function responseSave(){
	if(strMst.readyState==4) {
		if(strMst.status == 200) {
	    	strMst = eval(strMst.responseText); 
			if (strMst == undefined) {	// 저장자료 없을때
	        	showMessage(INFORMATION, OK, "GAUCE-1000",  strMst[0].MSG);
	        } else {	
	        	if (strMst[0].CD == "T") {	// 저장자료 처리되었을때
	            	showMessage(QUESTION, OK, "GAUCE-1000", strMst[0].MSG);
	                window.returnValue = 1;
	          		window.close();
	            }
	        }
	    } 
	}
}	


function searchEmp() {
	
	
	var strStrCd 	= gstrStrCd;
    var strPumbunCd = gstrPumbunCd;
    var strEmpSeq 	= gstrEmpSeq;
    
    var param = "&goTo=searchEmp" 	+ "&strStrCd="  	+ encodeURIComponent(strStrCd)
							    	+ "&strPumbunCd=" + encodeURIComponent(strPumbunCd)
							    	+ "&strEmpSeq=" 	+ encodeURIComponent(strEmpSeq)
							    	;
	var Urleren = "/edi/esal116.es";  
	URL = Urleren + "?" +param; 
	strMst = getXMLHttpRequest(); 
	strMst.onreadystatechange = responseSearchEmp;
	strMst.open("POST", URL, true); 
	strMst.send(null); 
	
}


/**
 * responseSearchEmp()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */ 
function responseSearchEmp() {
     
	 if(strMst.readyState==4)
     {
          if(strMst.status == 200)
          {
              strMst = eval(strMst.responseText); 
            
             // 조회된 데이터가 없을땐 메세지 출력후 닫기
              if(strMst == undefined) { 
                 //setPorcCount("SELECT", 0);
                 alert("조회내용이 없습니다!");
                 self.close();
                 return; 
               }
              
              for( i = 0; i < strMst.length; i++ ){   
            	  
            	  STRCD.value		= strMst[i].STR_CD;
            	  document.getElementById("STRNM").value 		= strMst[i].STR_NM;
            	  document.getElementById("PUMBUNCD").value	= strMst[i].PUMBUN_CD;
            	  document.getElementById("PUMBUNNM").value	= strMst[i].PUMBUN_NAME;
            	  document.getElementById("EMPNAME").value 	= strMst[i].EMP_NAME;
            	  document.getElementById("HPNO").value 	= strMst[i].HP_NO;
            	  document.getElementById("EMPSEQ").value	= strMst[i].EMP_SEQ;
            	  document.getElementById("ENTRDT").value	= strMst[i].ENTR_DT;
            	  document.getElementById("RETRDT").value	= strMst[i].RETR_DT;
				  
            	  if (strMst[i].DEL_YN == "N")
            		  document.getElementById("DEL_N").checked = "checked";
				  else
					  document.getElementById("DEL_Y").checked = "checked";
				  
				  if (strMst[i].EMP_FLAG == "1")
					  document.getElementById("EMPFLAG0").checked = "checked";
				  else if (strMst[i].EMP_FLAG == "2")
					  document.getElementById("EMPFLAG1").checked = "checked";
				  else if (strMst[i].EMP_FLAG == "3")
					  document.getElementById("EMPFLAG2").checked = "checked";
              }   
              
              setPorcCount("SELECT", strMst.length); 
              //chBak(0);
          } 
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
<table width="99%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="POINT">점</th>
            <td width="120">
            	<input type="text"  name="STRNM" id="STRNM" size="17" maxlength="10" value="<%=strNm%>" disabled="disabled" />
            	<input type="hidden" name="STRCD" id="STRCD" >
            </td>
            <th width="80">브랜드코드</th>
            <td width="120">
            	<input type="text"  name="PUMBUNCD" id="PUMBUNCD" size="17" maxlength="10" disabled="disabled" />
            </td>
            <th width="80">브랜드명</th>
            <td>
                <input type="text"  name="PUMBUNNM" id="PUMBUNNM" size="20" maxlength="10" disabled="disabled" />
            </td>
          </tr>
          <tr>
            <th width="80">사원명</th>
            <td width="120">
            	<input type="text"  name="EMPNAME" id="EMPNAME" size="17" maxlength="10"  />
            	<input type="hidden" name="EMPSEQ" id="EMPSEQ" >
            </td>
            <th width="80">연락처</th>
            <td width="120">
                <input type="text"  name="HPNO" id="HPNO" size="20" maxlength="11"  onKeyPress="javascript:onlyNumber();" />
            </td>
            <th width="80" class="POINT">사원구분</th>
            <td>
            	<input type="radio" name="EMPFLAG" id="EMPFLAG0" value="0" checked/> 매니져
				<input type="radio" name="EMPFLAG" id="EMPFLAG1" value="1" /> 직원 
				<input type="radio" name="EMPFLAG" id="EMPFLAG2" value="2" /> 아르바이트
			 </td>
            </td>
          </tr>
          <tr>
            <th>입사일자</th>
            <td>
                <input type="text" name="ENTRDT" id=""ENTRDT"" size="10" title="YYYY/MM/DD" value="" maxlength="10" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);"  style='text-align:center;IME-MODE: disabled' /> 
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="시작일" align="absmiddle" onClick="openCal('G',ENTRDT);return false;" /> 
            </td>
            <th>퇴사일자</th>
            <td>
            <input type="text" name="RETRDT" id="RETRDT" size="10" maxlength="10" value="" onKeyPress="javascript:onlyNumber();" onBlur="dateCheck(this);" onFocus="dateValid(this);" style='text-align:center;IME-MODE: disabled' />
                 <img src="<%=dir%>/imgs/btn/date.gif" alt="종료일" align="absmiddle" onClick="openCal('G',RETRDT);return false;" />
            </td>
            <th>삭제구분</th>
            <td>
            	<input type="radio" name="DELYN" id="DEL_N" value="N" checked="checked"/> 사용
				<input type="radio" name="DELYN" id="DEL_Y" value="Y" /> 삭제 </td>
            </td>
          </tr>
        </table>
        </td>
        </tr>
    </table></td>
  </tr>
</table>		
<img src="<%=dir%>/imgs/btn/save.gif" align="center" onclick="javascript:chk();" /> <img src="<%=dir%>/imgs/btn/close.gif" align="center" onclick="self.close();" />
						 

</body>
</html>

