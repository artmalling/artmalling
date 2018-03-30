/**
 * 시스템명 : 자바스크립트 공통함수
 * 작 성 일 : 2006-10-04
 * 작 성 자 : FKL 
 * 수 정 자 : 
 * 파 일 명 : common.js
 * 버    전 : 1.0    
 * 인 코 딩 : EUC-KR
 * 개    요 : 자바스크립트 표준 공통 함수
 * 이    력 : 2006.10.04 최초 개발 
 *         2007.03.18 패스워드 Check 모듈 추가 
 *         2007.05.14 TEXTAREA 마우스 포인터 수정 
 *         2007.06.29 CTRL+N 막음 
 *         2007.08.15 searchDoneWait 수정 
 */


/**
공통함수 목록
☞-------------------FUNCTION ---------------------------------
_ws_              MS Roll Up Patch, Object 태그 처리용 
checkIt           변수에 값이 있는지 유무 
isNull            Object가 Null유무 
isEmpty           Ovject의 빈값 유무 
isEmptyVal        변수의 빈값 유무 
nvl               변수의 값이 Null일 경우 대체값 반환
containsChars     Char Check 
containsCharsOnly Char Check
isAlphabet        알파벳 유무 
isUpperCase       대문자가 존재 하냐 Chck  
isLowerCase       소문자 유무 Check 
isNumber          숫자만 존재하냐  Check
isAlphaNum        문자와 숫자만 존재하냐 Check 
isNumDash         음수인지 Check
searchDoneWait    조회중 닫기 처리 
syncFromToDt      시작일자보다 작을경우 종료일자(To Date)를 시작일자와 동일하게 설정
enableControl     Object 사용/미사용 컨트롤
☞-------------------FUNCTION(중요 전프로그램에 영향을 미침)-----------
errorHandler      Jsp Script Error 처리 ( 한시적으로 막음  )
onMouseDown       오른쪽키 처리       
onMouseOver       마우스 Over 처리 

☞-------------------FUNCTION(버튼)----------------------------
createButton      버튼 생성 
replaceButton     버튼 Enable/Disable 처리 
btn_logExcel      엑셀    버튼 log 처리 
btn_logPrint      프린터  버튼 log 처리 
*/


var DateConst = 86400000;
var strAuthorization = new Array();
var strButtonAuthorization = "";
var mainWindow = false;

var strDetect = navigator.userAgent.toLowerCase();
var Browser;              //Browser 종류    
var Version;              //Browser 버전    
var windowsXPSP2 = false; //Window XP2 여부 
var strCheckIt;           //체크 임시       
var place;

Browser = checkIt('msie')?"Internet Explorer":"others";
if (!Version)Version=strDetect.charAt(place+strCheckIt.length);

if(strDetect.indexOf("sv1")) windowsXPSP2 = true;

/*
*공백제거한다.
*/
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.string = function(l) {
	var s = '', i = 0;
	while (i++ < l) {
		s += this; 
	}
	return s;
}

String.prototype.zf = function(l) {
	return '0'.string(l - this.length) + this;
}

Number.prototype.zf = function(l) {
	return this.toString().zf(l);
}



function processKey() 
{ 
	if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode >= 112 && event.keyCode <= 123)) { 
		event.keyCode = 0; 
		event.cancelBubble = true; 
		event.returnValue = false; 
    }
}

//document.onkeydown = processKey;
//document.oncontextmenu = nocontextmenu;
//document.onmousedown = norightclick;
//document.onselectstart=new Function("return false");
//document.ondragstart=new Function("return false");


/**
* _ws_(id)
* 작성자     : 권대용
* 작성일자 : 2007-01-01
* 개요        : MS Roll Up Patch, Object 태그 처리용
* return : Void
*/

 function _ws_(id)
 {
     document.write(id.innerHTML);
     id.id = "";
 }
 function btn_Save2() {
    window.status='';
    btn_Save();
}
	 
function btn_Search2() {
    window.status='';
    btn_Search();
}
 
function btn_Delete2() {
    window.status='';
    btn_Delete();
}
 
function btn_New2() {
    window.status='';
    btn_New();
}
 
function btn_Excel2() {
    window.status='';
    btn_Excel();
}
 
function btn_Print2() {
    window.status='';
    btn_Print();
}
 
function btn_Conf2() {
    window.status='';
    btn_Conf();
}
 
function btn_Help2() {
    window.status='';
    btn_Help();
}

/**
* checkIt(string)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 변수에 값이 있는지 Check  ( System 에서 사용 )
* return : String
*/
function checkIt(string){
  place = strDetect.indexOf(string) + 1;
  strCheckIt = string;
  return place;
}
/**
* isNull(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : Null Check
* return : true/false
*/
function isNull(obj) {
  return (typeof(obj) == 'undefined' || obj == null || obj == "") ? true : false;
}

/**
* isEmpty(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 빈값 Check
* return : true/false
*/
function isEmpty(obj) {
  return (obj.value == null || obj.value.replace(/ /gi,"") == "") ? true : false;
}

/**
* isEmptyVal(val)
* 작성자     : 엄준석
* 작성일자 : 2010-09-13
* 개요        : 빈값 Check
* return : true/false
*/
function isEmptyVal(val) {
  return (val == null || val.replace(/ /gi,"") == "") ? true : false;
}

/**
* nvl(val,ret)
* 작성자     : 엄준석
* 작성일자 : 2010-09-13
* 개요        : 빈값 Check
* return : ret
*/
function nvl(val,ret) {
  return (val == null || val == "") ? ret : val;
}



/**
* containsChars(obj, strChars)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 문자 Search 없음 true 있음 false 
* return : true/false
*/
function containsChars(obj, strChars) {
  for (var i=0, n=obj.value.length; i < n; i++) {
    if (strChars.indexOf(obj.value.charAt(i)) != -1) {
        return true;
    }
  }
  return false;
}

/**
* containsCharsOnly(obj, strChars)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 문자 Search 없음 false 있음 true
*          문자가 한개라도 존재 하지 않으면 true 
* return : true/false
*/
function containsCharsOnly(obj, strChars) {
  for (var i=0, n=obj.value.length; i<n; i++) {
    if (strChars.indexOf(obj.value.charAt(i)) == -1) {
        return false;
    }
  }
  return true;
}

/**
* containsCharsOnlyValue(obj, strChars)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 특수문자 Search 없음 true 있음 false 
* return : true/false
*/
function containsCharsOnlyValue(obj, strChars) {
  for (var i=0, n=obj.length; i < n; i++) {
    if (strChars.indexOf(obj.value.charAt(i)) == -1) {
        return false;
    }
  }
  return true;
}


/**
* isAlphabet(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 알파벳  Check 
* return : true/false
*/
function isAlphabet(obj) {
  var strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  return containsCharsOnly(obj, strChars);
}

/**
* isUpperCase(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 대문자냐 Check 
* return : true/false
*/

function isUpperCase(obj) {
  var strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return containsCharsOnly(obj,strChars);
}

/**
* isLowerCase(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 소문자인지 Check 
* return : true/false
*/

function isLowerCase(obj) {
  var strChars = "abcdefghijklmnopqrstuvwxyz";
  return containsCharsOnly(obj,strChars);
}

/**
* isNumber(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 숫자인지 Check 
* return : true/false
*/

function isNumber(obj) {
  var strChars = "0123456789";
  return containsCharsOnlyValue(obj,strChars);
}
/**
* isAlphaNum(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 알파벳인지 Check 
* return : true/false
*/
function isAlphaNum(obj) {
  var strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  return containsCharsOnly(obj,strChars);
}

/**
* isNumDash(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 음수인지 CHeck 
* return : true/false
*/
function isNumDash(obj) {
  var strChars = "-0123456789";
  return containsCharsOnly(obj,strChars);
}

/**
* isNumDash(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 콤마가 ,[.] 있는지 여부 Check 
* return : true/false
*/
function isNumComma(obj) {
  var strChars = ".,0123456789";
  return containsCharsOnly(obj,strChars);
}


/**
* isValidFormat(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 문자가 존재하는지 없는지 Check 
* return : true/false
*/

function isValidFormat(obj,format) {
  return obj.value.search(format) != -1 ? true : false;
}

function isValidEmail(obj) {
  var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
  return isValidFormat(obj,format);
}

function isValidPhone(obj) {
  var format = /^(\d+)-(\d+)-(\d+)$/;
  return isValidFormat(obj,format);
}


/**
* isValidStrFormat(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 문자가 존재하는지 없는지 Check 
* return : true/false
*/

function isValidStrFormat(str,format) {
  return str.search(format) != -1 ? true : false;
}

function isValidStrEmail(str) {
  var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
  return isValidStrFormat(str,format);
}

function isValidStrPhone(str) {
  var format = /^(\d+)-(\d+)-(\d+)$/;
  return isValidStrFormat(str,format);
}


/**
* containsStrChars(str, strChars)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 문자 Search 없음 true 있음 false 
* return : true/false
*/
function containsStrChars(str, strChars) {
  for (var i=0, n=str.length; i < n; i++) {
    if (strChars.indexOf(str.charAt(i)) != -1) {
        return true;
    }
  }
  return false;
}

/**
* containsStrCharsOnly(str, strChars)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 문자 Search 없음 false 있음 true
*          문자가 한개라도 존재 하지 않으면 true 
* return : true/false
*/
function containsStrCharsOnly(str, strChars) {
  for (var i=0, n=str.length; i<n; i++) {
    if (strChars.indexOf(str.charAt(i)) == -1) {
        return false;
    }
  }
  return true;
}

/**
* containsStrCharsOnlyValue(str, strChars)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 특수문자 Search 없음 true 있음 false 
* return : true/false
*/
function containsStrCharsOnlyValue(str, strChars) {
  for (var i=0, n=str.length; i < n; i++) {
    if (strChars.indexOf(str.charAt(i)) == -1) {
        return false;
    }
  }
  return true;
}


/**
* isAlphabetStr(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 알파벳  Check 
* return : true/false
*/
function isAlphabetStr(str) {
  var strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  return containsStrCharsOnly(str, strChars);
}

/**
* isUpperCaseStr(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 대문자냐 Check 
* return : true/false
*/

function isUpperCaseStr(str) {
  var strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return containsStrCharsOnly(str,strChars);
}

/**
* isLowerCase(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 소문자인지 Check 
* return : true/false
*/

function isLowerCaseStr(str) {
  var strChars = "abcdefghijklmnopqrstuvwxyz";
  return containsStrCharsOnly(obj,strChars);
}

/**
* isNumber(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 숫자인지 Check 
* return : true/false
*/

function isNumberStr(str) {
  var strChars = "0123456789";
  return containsStrCharsOnlyValue(str,strChars);
}
/**
* isAlphaNumStr(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 알파벳인지 Check 
* return : true/false
*/
function isAlphaNumStr(str) {
  var strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  return containsStrCharsOnly(str,strChars);
}

/**
* isNumDash(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 음수인지 CHeck 
* return : true/false
*/
function isNumDashStr(str) {
  var strChars = "-0123456789";
  return containsStrCharsOnly(str,strChars);
}

/**
* isNumDashStr(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 콤마가 ,[.] 있는지 여부 Check 
* return : true/false
*/
function isNumCommaStr(str) {
  var strChars = ".,0123456789";
  return containsStrCharsOnly(str,strChars);
}

/**
* removeComma(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 콤마 제거 
* return : void
*/
function removeComma(obj) {
  return obj.value.replace(/,/gi,"");
}

/**
* removeComma2(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 콤마 제거 
* return : void
*/
function removeComma2(str) {
  return str.replace(/,/gi,"");
}

/**
* getByteLength(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 바이트수  
* return : int
*/
function getByteLength(obj) {
  var intByteLength = 0;
  
  var objTag = obj.tagName.toUpperCase();

  if (objTag == "OBJECT") {
	  for (var i=0, n=obj.text.length;i<n;i++) {
	    var oneChar = escape(obj.text.charAt(i));
	    if ( oneChar.length == 1 ) {
	      intByteLength ++;
	    } else if (oneChar.indexOf("%u") != -1) {
	      intByteLength += 2;
	    } else if (oneChar.indexOf("%") != -1) {
	      intByteLength += oneChar.length/3;
	    }
	  }
  } else {
	  for (var i=0, n=obj.value.length;i<n;i++) {
	    var oneChar = escape(obj.value.charAt(i));
	    if ( oneChar.length == 1 ) {
	      intByteLength ++;
	    } else if (oneChar.indexOf("%u") != -1) {
	      intByteLength += 2;
	    } else if (oneChar.indexOf("%") != -1) {
	      intByteLength += oneChar.length/3;
	    }
	  }
  }
  return intByteLength;
}

/**
* getByteValLength(value)
* 작성자     : FKL
* 작성일자 : 2010-12-21
* 개요        : 바이트수  
* return : int
*/
function getByteValLength(val) {
  var intByteLength = 0;
  
  for (var i=0, n=val.length;i<n;i++) {
    var oneChar = escape(val.charAt(i));
    if ( oneChar.length == 1 ) {
      intByteLength ++;
    } else if (oneChar.indexOf("%u") != -1) {
      intByteLength += 2;
    } else if (oneChar.indexOf("%") != -1) {
      intByteLength += oneChar.length/3;
    }
  }

  return intByteLength;
}



/**
* getRawData(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        :  '-' 를 없앤다 
* return : int
*/

function getRawZip(strZip) {
  return (strZip==null || strZip=="") ? "" : strZip.replace( /-/g,"");
}

/**
* getRawAmt(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        :  ',' 를 없앤다 
* return : int
*/
function getRawAmt(strAmt) {
  var strPatt = /\,/g;
  return strAmt == "" ? "0" : strAmt.replace(strPatt,"");
}


/**
* isYYYYMM(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : YYYY-MM 형식으로 데이터를 보내준다 
* return : str
*/

function isYYYYMM(strDate) {
  strDate =getRawData(strDate);
  strDate = replaceStr(strDate," ", "");
  var strYear = "", strMonth = "";
  var intYear = 0, intMonth = 0;
  if (strDate.length != 6) { return ""; } else { strYear = strDate.substring(0,4); strMonth = strDate.substring(4,6);}
  if (isNaN(strYear) || isNaN(strMonth)) return "";
  intYear = parseInt(strYear,'10');
  intMonth = parseInt(strMonth,'10');
  if (intYear < 0001) intYear = 0;
  if (intMonth < 01 || intMonth > 12) intMonth = 0;
  if (intYear == 0 || intMonth == 0 ) return "";
  return strYear+"-"+strMonth;
}

/**
* isYYYYMMDD(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : YYYY-MM-DD 형식으로 데이터를 보내준다 
* return : str
*/
function isYYYYMMDD(strDate) {
  strDate = getRawData(strDate);
  strDate = replaceStr(strDate," ", "");
  var strYear = "", strMonth = "", strDay = "";
  var intYear = 0, intMonth = 0, intDay = 0;

  if (strDate.length != 8) {
    return "";
  } else {
    strYear = strDate.substring(0,4);
    strMonth = strDate.substring(4,6);
    if (parseFloat(strMonth) < 10)
      strMonth = "0" + parseFloat(trim(strMonth));

    strDay = strDate.substring(6,8);
    if (parseFloat(strDay) < 10)
      strDay = "0" + parseFloat(trim(strDay));
  }
  if (isNaN(strYear) || isNaN(strMonth) || isNaN(strDay)) return "";
  intYear = parseInt(strYear,'10');
  intMonth = parseInt(strMonth,'10');
  intDay = parseInt(strDay,'10');

  if (intYear < 1) intYear = 0;
  if (intMonth < 1 || intMonth > 12) intMonth = 0;
  if (intDay < 1) intDay = 0;
  if ( intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12)  {
    if (intDay > 31) intDay = 0;
  } else if (intMonth == 4 || intMonth == 6 ||  intMonth == 9 || intMonth == 11) {
    if (intDay > 30) intDay = 0;
  } else if (intMonth == 2 )  {
    if (intYear % 4 != 0 || (intYear % 100 == 0 && intYear % 400 != 0)) {
      if (intDay > 28) intDay = 0;
    } else if (intDay > 29) intDay = 0;
  }
  if (intYear == 0 || intMonth == 0 || intDay == 0) return "";
  return strYear+"-"+strMonth+"-"+strDay;
}


/**
* checkYYYYMMDD(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 존재하는 일인지 Check 
* return : true/false
*/

function checkYYYYMMDD(strDate) {
  strDate = getRawData(strDate);
  var strYear = "", strMonth = "", strDay = "";
  var intYear = 0, intMonth = 0, intDay = 0;

  if (strDate.length != 8) {
    return false;
  } else {
    strYear = strDate.substring(0,4);
    strMonth = strDate.substring(4,6);
    if (parseFloat(strMonth) < 10) strMonth = "0" + parseFloat(trim(strMonth));
    strDay = strDate.substring(6,8);
    if (parseFloat(strDay) < 10)
      strDay = "0" + parseFloat(trim(strDay));
  }
  if (isNaN(strYear) || isNaN(strMonth) || isNaN(strDay)) return false;
  intYear = parseInt(strYear,'10');
  intMonth = (strMonth,'10');
  intDay = parseInt(strDay,'10');
  if (intYear < 1) intYear = 0;
  if (intMonth < 1 || intMonth > 12) intMonth = 0;
  if (intDay < 1) intDay = 0;
  if ( intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12)  {
    if (intDay > 31) intDay = 0;
  } else if (intMonth == 4 || intMonth == 6 ||  intMonth == 9 || intMonth == 11) {
    if (intDay > 30) intDay = 0;
  } else if (intMonth == 2 )  {
    if (intYear % 4 != 0 || (intYear % 100 == 0 && intYear % 400 != 0)) {
      if (intDay > 28) intDay = 0;
    } else if (intDay > 29) intDay = 0;
  }
  if (intYear == 0 || intMonth == 0 || intDay == 0) return false;
  return true;
}

/**
* checkYYYYMM(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 존재하는 형식이 년월인지 Check 해서 
*          참이면 TRUE 아니면 FALSE를 리턴한다 
* return : true/false
*/
function checkYYYYMM(strDate) {
  strDate = isYYYYMM(strDate)
  if (strDate == ""){
      return false;
  }  
  return true;
}

/**
* isHHMM(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 시간을 체크하고 HH:MM타입으로 바꾼다
* return : true/false
*/

function isHHMM(strTime) {
  strTime = getRawData(strTime);
  var strHour = "", strMinute = "";
  var intHour = 0, intMinute = 0;
  if (strTime.length != 4) {
    return "";
  } else {
    strHour = strTime.substring(0,2);
    strMinute = strTime.substring(2,4);
  }
  if (isNaN(strHour) || isNaN(strMinute)) return "";
  intHour = parseInt(strHour,'10');
  intMinute = parseInt(strMinute,'10');
  if (intHour<00 || intHour>24) intHour = -1;
  if (intHour == 24){
  	if (intMinute != 00) intMinute = -1;
  }else{
  	if (intMinute<00 || intMinute>=60) intMinute = -1;
  }
  if (intHour==-1 || intMinute==-1 ) return "";
  return strHour+":"+strMinute;
}

/**
* isHHMMSS(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 시간을 체크하고 HH:MM:DD타입으로 바꾼다
* return : true/false
*/

function isHHMMSS(strTime) {
  strTime = getRawData(strTime);
  var strHour = "", strMinute = "", strSec = "";
  var intHour = 0, intMinute = 0, intSec = 0;
  if (strTime.length != 6) {
    return "";
  } else {
    strHour = strTime.substring(0,2);
    strMinute = strTime.substring(2,4);
    strSec = strTime.substring(4,6);
  }
  if (isNaN(strHour) || isNaN(strMinute) || isNaN(strSec)) return "";
  intHour = parseInt(strHour,'10');
  intMinute = parseInt(strMinute,'10');
  intSec = parseInt(strSec,'10');
  if (intHour<00 || intHour>=24) intHour = -1;
  if (intMinute<00 || intMinute>=60) intMinute = -1;
  if (intSec<00 || intSec>=60) intSec = -1;
  if (intHour==-1 || intMinute==-1 || intSec==-1) return "";
  return strHour+":"+strMinute+":"+strSec;
}

function convertDate(obj) {
  var retDate = obj.value;
  if ( retDate==null || retDate=="" ) return;
  if ( (retDate=isYYYYMMDD(retDate))=="" ) {return;} else { return obj.value = retDate;}
}


function ltrim( strStr ) {
  var intIdx=0;
  for(var i=0, n=strStr.length; i<n; i++ ) {
    if ( strStr.charAt(i)!=' ' )
      intIdx = i;
      break
  }
  return strStr.substring( intIdx, strStr.length );
}

function rtrim( strStr ) {
  var intLen = strStr.length;
  var intIdx = 0;
  for(intIdx = intLen-1 ; intIdx >= 0; intIdx-- ) {
    if ( strStr.charAt(intIdx)!=' ' )
      break;
  }
  return strStr.substring( 0, intIdx + 1 );
}

function trim(strStr) {
    return ltrim(rtrim(strStr));
}


function getTokenComma(strVal, strPatt) {
  var i = 0, intFst=0;
  var strCheckValue = strVal;
  var arrRst = new Array();
  while((intFst = strCheckValue.indexOf(strPatt)) >= 0) {
    if (intFst!=0)
      arrRst[i++] = strCheckValue.substring(0,intFst);
    strCheckValue = strCheckValue.substring(intFst+1, strCheckValue.length);
  }
  arrRst[i] = strCheckValue;
  return arrRst;
}

function getTokenCom(strVal, strPatt) {
  var i = 0, intFst=0;
  var strCheckValue = strVal;
  var arrRst = new Array();
  while((intFst = strCheckValue.indexOf(strPatt)) >= 0) {
    if (intFst!=0) {
      arrRst[i++] = strCheckValue.substring(0,intFst);
    } else if (intFst == 0)
      arrRst[i++] = "";
    strCheckValue = strCheckValue.substring(intFst+1, strCheckValue.length);
  }
  arrRst[i] = strCheckValue;
  return arrRst;
}
//우편번호
function convertZip(strVal) {
  strVal = getRawZip(strVal);
  if (strVal.length!=6) return "";
  return strVal.substring(0,3) + "-" + strVal.substring(3,6);
}

// 주민번호
function personalIDCheck(strID) {
  strID = getRawData(strID);
  if (strID.length!=13) return "";
  return strID.substring(0,6)+"-"+strID.substring(6,13);
}

/**
* convAmt(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 입력값의 세번째자리 마다 콤마를 찍어준다 (x,xxx)
* return : str
*/
function convAmt(strVal) {
  var strRst = "";  
  var intOrd = strVal.length; 
  if ((strVal.substring(0,1)) == "-") {
    strVal = strVal.substring(1,intOrd);
    intOrd -= 1; strRst = "-";
  }
  for(var i=0, n=strVal.length; i<n; i++) {
    strRst += strVal.substring(i, i+1);
    if (intOrd != 1 && (intOrd-1) % 3 == 0) strRst += ",";
    intOrd -= 1;
  }
  return strRst;
}
/**
* amtFormat(obj)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 오브젝트에 숫자형으로 콤마를 부여한다 
* return : str
*/
function amtFormat(obj) {
  var strSrcNumber = obj.value;
  if (trim(strSrcNumber) == '') return;
  strSrcNumber = getRawAmt(strSrcNumber);
  if (isNaN(strSrcNumber)) { obj.value = obj.defaultValue; return;}
  var strTxtNumber = '' + parseFloat(strSrcNumber);
  var strTemp;
  var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
  var arrNumber = strTxtNumber.split('.');
  arrNumber[0] += '.';
  do {
      arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
  } while (rxSplit.test(arrNumber[0]));
  strTemp = arrNumber.length > 1 ?  arrNumber.join('') : arrNumber[0].split('.')[0];
  return strTemp;
}

/**
* monthFormat()
* 작 성 자 : 한국후지쯔
* 작 성 일 : 2006-10-20
* 개     요 : OBJECT를 날짜 포멧으로 변환 
*         자릿수에 따라 Format 형식 변경 
*         4자리이면 : 년도 
*         6자리이면 : 년월
*         8자리이면 : 년월일 
* 사용방법 : gridInit(SH_TITLE)
*          arguments[0] -> OBJECT
*/
function monthFormat(obj) {
  var tempMonth = getRawData(obj.value);
  if (tempMonth.length == 4) {
    obj.value = tempMonth.substring(0,4) + "-" ;
  } else if (tempMonth.length == 6) {
    obj.value = tempMonth.substring(0,4) + "-" + tempMonth.substring(4,6);
  } else if (tempMonth.length == 8) {
    obj.value = tempMonth.substring(0,4) + "-" + tempMonth.substring(4,6) + "-" + tempMonth.substring(6,8);
  }
}

/**
* getDateFormat(String)
* 작 성 자 : 엄준석
* 작 성 일 : 2011-01-20
* 개     요 : 입력받은 값을 날짜 포멧으로 변환 
*         자릿수에 따라 Format 형식 변경 
*         4자리이면 : 년도 
*         6자리이면 : 년월
*         8자리이면 : 년월일 
* 사용방법 : arguments[0] -> String
*/
function getDateFormat(val) {
	var tempMonth = getRawData(trim(val));
	var retMonth = "";
	if (tempMonth.length == 0) return "";
	
	if (tempMonth.length == 4) {
		retMonth = tempMonth.substring(0,4);
	} else if (tempMonth.length == 6) {
		retMonth = tempMonth.substring(0,4) + "/" + tempMonth.substring(4,6);
	} else if (tempMonth.length == 8) {
		retMonth = tempMonth.substring(0,4) + "/" + tempMonth.substring(4,6) + "/" + tempMonth.substring(6,8);
	} else {
		alert("날짜 포멧을 지정할 수 없습니다.");
		return "";
	}
	
	return retMonth;
}

function checkMonth(obj) {
  var tempVal = getRawData(obj.value);
  if ( (tempVal.length != 0) && (tempVal.length != 6) ) {
    showMessage(Information, Ok, "US-1007", obj.title);
    obj.value = obj.defaultValue;
    obj.focus();
  } else {
    if ( (obj.value.length != 0) && (isYYYYMM(obj.value) == "") ) {
      showMessage(Information, Ok, "US-1007", obj.title);
      obj.value = obj.defaultValue;
      obj.focus();
    }
    obj.value = isYYYYMM(obj.value);
  }
}
/*
function onlyNumber() {
  if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;
}
*/

function checkString(strStr) {
  if (trim(strStr) == "" || isNaN(trim(strStr))) {
    return true;
  } else {
    return false;
  }
}

/**
* radioClear(obj)
* 작성자     : FKL
* 작성일자 : 2006-10-13
* 개요        : 오브젝트  Radio Clear
* return : true/false
*/

function radioClear(obj) {
  if (obj == null) return;
  if (obj.length==null) {
    if (obj.checked) obj.checked = false;
    return;
  }
  for(i=obj.length-1; i>=0; i--) {
    if ( obj[i].checked ) obj[i].checked = false;
  }
}

function checkIndex(obj) {
  if (obj == null) return null;
  if (obj.length==null)
    if (obj.checked) return 0;
  for(var i=obj.length-1; i>=0; i--)
      if (obj[i].checked) return i;
  return null;
}

function formClear(obj) {
  for(var i=0, n=obj.length;i<n;i++) {
    if (obj.item(i).tagName.toUpperCase() == "INPUT" ) {
      if (obj.item(i).type.toUpperCase() == "TEXT") {
        obj.item(i).value = "";
      } else if (obj.item(i).type.toUpperCase() == "PASSWORD") {
        obj.item(i).value = "";
      } else if (obj.item(i).type.toUpperCase() == "RADIO") {
        obj.item(i).checked = false;
      } else if (obj.item(i).type.toUpperCase() == "CHECKBOX") {
        obj.item(i).checked = false;
      }
    } else if (obj.item(i).tagName.toUpperCase() == "SELECT") {
      obj.item(i).selectedIndex = 0;
    }
  }
}



function getLastDay2(strDate) {
  //순수 날짜형식
  strDate = getRawData(strDate);
  if (strDate.length != 6) {
    showMessage(Information, Ok, "US-1007", obj.title);
    return -1;
  }
  if (strDate.length == 6) {
    strDate = strDate + "01";
  } else if (strDate.length == 7) {
    strDate = strDate + "-01";
  }
  intYear = strDate.substr(0,4) * 1;
  intMonth = strDate.substr(4,2) * 1;
  intMonth = (intMonth * 1) + 1;
  if (intMonth <= 0) {
    /* (년도) */
    intYear = parseInt(intYear) + parseInt(intMonth / 12);
    intYear = intYear - 1;

    /* (월) */
    intModMonth = intMonth % 12;
    intMonth = 12 + intModMonth;
  } else if (intMonth > 12) {
    //년도
    intYear = parseInt(intYear) + parseInt(intMonth / 12);
    //월

    intMonth = intMonth % 12;
  } else{
    intYear = strDate.substr(0,4);
  }
  if (intMonth <= 9) intMonth = "0" + intMonth;
  intDay = "01";
  
  //(날짜 차이-밀리세컨까지 숫자형)
  strRDate = new Date(intYear,parseInt(intMonth) - 1,parseInt(intDay));
  strRDate.setTime(strRDate.getTime() - parseInt(DateConst));
  return (strRDate.getDate());
}

function amtFormatDot(strSrcNumber, intLen) {
  var txtNumber = '' + strSrcNumber.toFixed(intLen);
  if (isNaN(txtNumber) || txtNumber == "") {
      showMessage(Information, Ok, "US-1005", obj.title);
  } else {
    var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
    var arrNumber = txtNumber.split('.');
    arrNumber[0] += '.';
    do {
      arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
    } while (rxSplit.test(arrNumber[0]));

    return arrNumber.length > 1 ? arrNumber.join('') : arrNumber[0].split('.')[0];
  }
}

function amtDecimals(obj, len) {
  var inputValue = obj.value;
  var numValue   = '0000000000';
  var strTmp;
  var returnValue;
  inputValue = getRawAmt(inputValue);
  if (isNaN(inputValue) || inputValue == "") {
    strTmp = '0.' + numValue.substring(0,len);
    returnValue = strTmp;
  } else {
    var strPatt = /\,/g;
    inputValue = inputValue.replace(strPatt,"");
    if (inputValue.indexOf('.') == -1) inputValue += ".";
    inputValue += numValue;
    strTmp = inputValue.substring(0,inputValue.indexOf('.'));
    strTmp = convAmt(strTmp);
    strTmp += ".";
    strTmp += inputValue.substring(inputValue.indexOf('.')+1, inputValue.indexOf('.')+len+1);
    returnValue = strTmp;
  }
  obj.value = returnValue;
}


/**
function isValidDateWith(strSDate, strEDate) {
  var intSDate = parseInt(parseFloat(getRawData(strSDate), 10), 10);
  var fltEDate = parseFloat(parseFloat(getRawData(strEDate), 10), 10);
  if (chkDateFormat(strSDate) == false) return false;
  if (chkDateFormat(strEDate) == false) return false;
  if (intSDate > fltEDate) {
    showMessage(Information, Ok, "US-1015");
    return false;
  }
  return true;
}
**/


function round(sval,n,cutGb) {
  var i, k=1, retVal;
  var intValue;
  var stringValue;
  var lastNum;
  for(i=0;i<=n;++i){
      k *= 10;
  }
  intValue = parseInt(sval * k);
  stringValue = String(intValue);
  if(cutGb == "1"){ //??????
    lastNum = stringValue.substring(stringValue.length - 1, stringValue.length);
    if(lastNum >= 5){
      intValue = intValue + 10;
      stringValue = String(intValue);
    }
  }
  k /= 10;
  stringValue = stringValue.substring(0,stringValue.length - 1);
  return (stringValue == null || stringValue == "") ? 0 : parseInt(stringValue) / k;
}



/**
* roundDec()
* 작 성 자 : ckj
* 작 성 일 : 2006-09-06
* 개    요 :  소숫점 이하 반올림 하기 
* 사용방법 : roundDec(val, dec)
*            arguments[0] -> 반올림할 값 
*            arguments[1] -> 반올림할 소숫점 위치, default - 1
*
*			 예) roundDec('5.463',1) => 5.5
*				roundDec('5.463',2) => 5.46
* return값 : void
*/

function roundDec(val, dec) {
	if( dec == undefined ) dec = 1;
	var tmp = val * ( dec * 10 );
	return  Math.round(tmp) / ( dec * 10 );
}


/**
* juminCheck(jumin1,jumin2 )
* 작 성 자 : FKL
* 작 성 일 : 2006.12.01
* 개    요 : 주민번호 Check
* 사용방법 : juminCheck("1234567","1234567")
* return값 : true/false
*/
function juminCheck_old(jumin1,jumin2) {
	  var strjumin1 = jumin1;
	  var strjumin2 = jumin2;
	  var i3=0;
	  for (var i=0, n=strjumin1.length;i<n;i++) {
	    var ch1 = strjumin1.substring(i,i+1);
	    if (ch1<'0' || ch1>'9')  i3=i3+1;
	  }
	  if ((strjumin1 == '') || ( i3 != 0 )) return false;
	  var i4=0;
	  for (var i=0, n=strjumin2.length;i<n;i++) {
	    var ch1 = strjumin2.substring(i,i+1);
	    if (ch1<'0' || ch1>'9') i4=i4+1;
	  }
	  if ((strjumin2 == '') || ( i4 != 0 )) return false;
	  if (strjumin1.substring(0,1) < 3) return false;
	  if (strjumin2.substring(0,1) > 2) return false;
	  if ((strjumin1.length > 7) || (strjumin2.length > 8)) return false;
	  if ((strjumin1 == '72') || ( strjumin2 == '18')) return false;
	  var f1=strjumin1.substring(0,1)         ;
	  var f2=strjumin1.substring(1,2)         ;
	  var f3=strjumin1.substring(2,3)         ;
	  var f4=strjumin1.substring(3,4)         ;
	  var f5=strjumin1.substring(4,5)         ;
	  var f6=strjumin1.substring(5,6)         ;
	  var hap=f1*2+f2*3+f3*4+f4*5+f5*6+f6*7   ;
	  var l1=strjumin2.substring(0,1)         ;
	  var l2=strjumin2.substring(1,2)         ;
	  var l3=strjumin2.substring(2,3)         ;
	  var l4=strjumin2.substring(3,4)         ;
	  var l5=strjumin2.substring(4,5)         ;
	  var l6=strjumin2.substring(5,6)         ;
	  var l7=strjumin2.substring(6,7)         ;
	  hap=hap+l1*8+l2*9+l3*2+l4*3+l5*4+l6*5   ;
	  hap=hap%11                              ;
	  hap=11-hap                              ;
	  hap=hap%10                              ;
	  return hap != l7 ? false : true;
	  return false;
}

/**
* juminCheck(jumin1,jumin2 )
* 작 성 자 : FKL
* 작 성 일 : 2006.12.01
* 개    요 : 주민번호 Check
* 사용방법 : juminCheck("1234567","1234567")
* return값 : true/false
*/
function juminCheck( str1, str2 ) {
	var str = "";
	str = str1 + str2;		  

	if(str =='') return false;	//공백이라면

	str = getRawData(str);	// "-" 제거
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
    if(((id_chk%11 == 0) && (chkdigit == 1)) || ((id_chk%11 ==10)&& (chkdigit ==0))){
         return true;
    }
    else if((id_chk %11 != 0) && (id_chk % 11 != 10 ) && (id_chk % 11 == chkdigit)){
         return true;
    }
    else{
         return false;
    }
}


/**
* juminCheck(jumin1,jumin2 )
* 작 성 자 : FKL
* 작 성 일 : 2006.12.01
* 개    요 : 외국인 주민번호 Check
* 사용방법 : juminCheck("1234567","1234567")
* return값 : true/false
*/
function juminCheckFore(reg_no) {
	var sum = 0;
	var odd = 0;
	
	buf = new Array(13);
	for (i = 0; i < 13; i++) buf[i] = parseInt(reg_no.charAt(i));
	
		odd = buf[7]*10 + buf[8];
		
		if (odd%2 != 0) {
		return false;
		}
		
		if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
		return false;
		}
		
		multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
		for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
		
		
		sum=11-(sum%11);
		
		if (sum>=10) sum-=10;
		
		sum += 2;
		
		if (sum>=10) sum-=10;
		
		if ( sum != buf[12]) {
		return false;
	}
	else {
	return true;
	}
}



/**
* telFormat()
* 작 성 자 : fkl
* 작 성 일 : 2006-09-06
* 개    요 :  전화번호 앞자리체크
* 사용방법 : firstTelFormat(obj,type), type - T:일반전화,H:휴대폰 
* return값 : bool
*/

function firstTelFormat(obj,type) {
    var strTel = obj.Text;
    var t = 0;
    if(type=="T"){
        var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                           '051', '052', '053', '054', '055', '061', '062',
                           '063', '064');
    }else if(type=="H"){
        var strDDD = new Array('010', '011', '012', '013', '015',
                           '016', '017', '018', '019');
    }
  
    for(var i=0, n=strDDD.length; i<n; i++) {
	    if (strTel == strDDD[i]) {	
            t=1;
        }
    }
    if(t==1){
	    return true;
    }else{
	    return false;
    }
}

/**
* firstTelFormatAll()
* 작 성 자 : fkl
* 작 성 일 : 2006-09-06
* 개    요 :  전화번호 앞자리체크
* 사용방법 : firstTelFormatAll(obj), type - 일반전화,휴대폰 
* return값 : bool
*/

function firstTelFormatAll(obj) {
    var strTel = obj.Text; 
    var t = 0;
    var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                           '051', '052', '053', '054', '055', '061', '062',
                           '063', '064', '010', '011', '012', '013', '015',
                           '016', '017', '018', '019');

  for(var i=0, n=strDDD.length; i<n; i++) {
	if (strTel == strDDD[i]) {	
        t=1;
    }
  }
  if(t==1){
	  return true;
  }else{
	  return false;
  }
}

/**
* firstTelFormatAll()
* 작 성 자 : fkl
* 작 성 일 : 2006-09-06
* 개    요 :  전화번호 앞자리체크
* 사용방법 : firstTelFormatAll(obj), type - 일반전화,휴대폰 
* return값 : bool
*/

function firstTelFormatAll2(obj) {
    var strTel = obj.value; 
    var t = 0;
    var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                           '051', '052', '053', '054', '055', '061', '062',
                           '063', '064', '010', '011', '012', '013', '015',
                           '016', '017', '018', '019');

  for(var i=0, n=strDDD.length; i<n; i++) {
	if (strTel == strDDD[i]) {	
        t=1;
    }
  }
  if(t==1){
	  return true;
  }else{
	  return false;
  }
}


/**
* telFormat()
* 작 성 자 : fkl
* 작 성 일 : 2006-09-06
* 개    요 :  전화번호 형식으로 변환 
* 사용방법 : telFormat(obj) 
* return값 : void
*/

function telFormat(obj) {
  var strTel = obj.value;
  var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                         '051', '052', '053', '054', '055', '061', '062',
                         '063', '064', '010', '011', '012', '013', '015',
                         '016', '017', '018', '019');
  strTel = strTel.replace(/-/gi,"")
  if (strTel.length < 9) {
    return;
  } else if (strTel.substring(0,2) == strDDD[0]) {
    strTel = strTel.substring(0,2) + '-' + strTel.substring(2, strTel.length-4)
             + '-' + strTel.substring(strTel.length, strTel.length -4);
  } else {
    for(var i=1, n=strDDD.length; i<n; i++) {
      if (strTel.substring(0,3) == strDDD[i]) {
        strTel = strTel.substring(0,3) + '-' + strTel.substring(3, strTel.length-4)
                 + '-' + strTel.substring(strTel.length, strTel.length -4);
      }
    }
  }
  obj.value = strTel;
  return;
}

/**
* telStrFormat()
* 작 성 자 : fkl
* 작 성 일 : 2006-09-06
* 개    요 :  전화번호 형식으로 변환 
* 사용방법 : telFormat(str) 
* return값 : void
*/

function telStrFormat(str) {
  var strTel = str;
  var rtnTel = "";
  var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                         '051', '052', '053', '054', '055', '061', '062',
                         '063', '064', '010', '011', '012', '013', '015',
                         '016', '017', '018', '019');
  strTel = strTel.replace(/-/gi,"")
  if (strTel.length < 9) {
    return rtnTel;
  } else if (strTel.substring(0,2) == strDDD[0]) {
    if (strTel.length > 10) return rtnTel;
    rtnTel = strTel.substring(0,2) + '-' + strTel.substring(2, strTel.length-4)
             + '-' + strTel.substring(strTel.length, strTel.length -4);
  } else {
    for(var i=1, n=strDDD.length; i<n; i++) {
      if (strTel.substring(0,3) == strDDD[i]) {
        if (strTel.length == 9 || strTel.length > 11) return rtnTel;
        rtnTel = strTel.substring(0,3) + '-' + strTel.substring(3, strTel.length-4)
                 + '-' + strTel.substring(strTel.length, strTel.length -4);
      }
    }
  }
  return rtnTel;
}

function getTelNo1(str) {
  var strTel = str;
  var rtnTel = "";
  var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                         '051', '052', '053', '054', '055', '061', '062',
                         '063', '064', '010', '011', '012', '013', '015',
                         '016', '017', '018', '019');
  strTel = strTel.replace(/-/gi,"")
  if (strTel.length < 9) {
    return rtnTel;
  } else if (strTel.substring(0,2) == strDDD[0]) {
    rtnTel = strTel.substring(0,2);
  } else {
    for(var i=1, n=strDDD.length; i<n; i++) {
      if (strTel.substring(0,3) == strDDD[i]) {
        if (strTel.length <= 9) return rtnTel;
        rtnTel = strTel.substring(0,3);
        break;
      }
    }
  }
  return rtnTel;
}

function getTelNo2(str) {
  var strTel = str;
  var rtnTel = "";
  var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                         '051', '052', '053', '054', '055', '061', '062',
                         '063', '064', '010', '011', '012', '013', '015',
                         '016', '017', '018', '019');
  strTel = strTel.replace(/-/gi,"")
  if (strTel.length < 9) {
    return rtnTel;
  } else if (strTel.substring(0,2) == strDDD[0]) {
    rtnTel = strTel.substring(2, strTel.length-4);
  } else {
    for(var i=1, n=strDDD.length; i<n; i++) {
      if (strTel.substring(0,3) == strDDD[i]) {
        if (strTel.length <= 9) return rtnTel;
        rtnTel = strTel.substring(3, strTel.length-4);
        break;
      }
    }
  }
  return rtnTel;
}

function getTelNo3(str) {
  var strTel = str;
  var rtnTel = "";
  var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
                         '051', '052', '053', '054', '055', '061', '062',
                         '063', '064', '010', '011', '012', '013', '015',
                         '016', '017', '018', '019');
  strTel = strTel.replace(/-/gi,"")
  if (strTel.length < 9) {
    return rtnTel;
  } else if (strTel.substring(0,2) == strDDD[0]) {
    rtnTel = strTel.substring(strTel.length, strTel.length -4);
  } else {
    for(var i=1, n=strDDD.length; i<n; i++) {
      if (strTel.substring(0,3) == strDDD[i]) {
        if (strTel.length <= 9) return rtnTel;
        rtnTel = strTel.substring(strTel.length, strTel.length -4);
        break;
      }
    }
  }
  return rtnTel;
}

function checkDecimals(obj, intDecAllowed) {
  if (obj.value.indexOf('.') == -1) obj.value += ".0";
  strDecText = obj.value.substring(obj.value.indexOf('.')+1, obj.value.length);
  var arrRadixPoint = obj.value.split('.');
  if (strDecText.length > intDecAllowed || arrRadixPoint.length>2) {
    showMessage(Information, Ok, "US-1016", obj.title, intDecAllowed);
    obj.focus();
  }
}

function null2zero(obj) {
  if (trim(obj.value) == '') obj.value = '0';
}

/**
    Display
*/
function createButton(strButtonAuth) {
	  mainWindow = true;

	  if (strButtonAuth.length != 8) {
	    showMessage(StopSign, Ok, "USER-1000", "버튼 권한을 정확하게 입력하십시오");
	    return;
	  }
	  
	  var chrAuthSearch   = strButtonAuth.substring(0, 1);
	  var chrAuthNew      = strButtonAuth.substring(1, 2);
	  var chrAuthDelete   = strButtonAuth.substring(2, 3);
	  var chrAuthSave     = strButtonAuth.substring(3, 4);
	  var chrAuthExcel    = strButtonAuth.substring(4, 5);
	  var chrAuthPrint    = strButtonAuth.substring(5, 6);
	  var chrAuthDecision = strButtonAuth.substring(6, 7);
	  var chrAuthHelp     = strButtonAuth.substring(7, 8);
	  
	  var chrSSearch      = "1";
	  var chrSRun         = "1";
	  
	  strAuthorization.push(chrAuthSearch   + chrSSearch);
	  strAuthorization.push(chrAuthNew      + chrSRun);
	  strAuthorization.push(chrAuthDelete   + chrSRun);
	  strAuthorization.push(chrAuthSave     + chrSRun);
	  strAuthorization.push(chrAuthExcel    + chrSSearch);
	  strAuthorization.push(chrAuthPrint    + chrSSearch);
	  strAuthorization.push(chrAuthDecision + chrSRun);
	  strAuthorization.push(chrAuthHelp     + chrSSearch);
	    
	  var strButton = "";
	  
	//  MM_preloadImages('/edi/imgs/btn/search_o.gif','/edi/imgs/btn/new_o.gif','/edi/imgs/btn/delete_o.gif','/edi/imgs/btn/_save_o.gif','/edi/imgs/btn/excel_o.gif','/edi/imgs/btn/print_o.gif','/edi/imgs/btn/set_o.gif','/imgs/btn/b_help_o.gif');
	  //<td id="_btnHelp" ><img src="/imgs/btn/b_help_d.gif" border="0" id="btnhelp" disabled=true></td>
	  strButton = 
	    '<table border="0" cellspacing="0" cellpadding="0">' +
	    '<tr>' +    
	    '<td id="_btnSearch"   ><img src="/edi/imgs/btn/search_off.gif" border="0" id="btnSearch" disabled=true></td>' +
	    '<td id="_btnNew"      ><img src="/edi/imgs/btn/new_off.gif" border="0" id="btnNew" disabled=true></td>' +
	    '<td id="_btnDelete"   ><img src="/edi/imgs/btn/del_off.gif" border="0" id="btnDelete" disabled=true></td>' +
	    '<td id="_btnSave"     ><img src="/edi/imgs/btn/save_off.gif" border="0" id="btnSave" disabled=true></td>' +
	    '<td id="_btnExcel"    ><img src="/edi/imgs/btn/excel_off.gif" border="0" id="btnExcel" disabled=true></td>' +
	    '<td id="_btnPrint"    ><img src="/edi/imgs/btn/print_off.gif" border="0" id="btnPrint" disabled=true></td>' +
	    '<td id="_btnDecision" ><img src="/edi/imgs/btn/set_off.gif" border="0" id="btnDecision" disabled=true></td>' +
	    '</tr>' +   
	    '</table>';
	    document.writeln(strButton);
	}

	function replaceButton(intBtnSequence, blnShow) {
	  switch(intBtnSequence) {
	    case 0 :
	      if (blnShow) {
	        _btnCancel.innerHTML = '<img src="/edi/imgs/btn/cancel.gif" border="0" id="btnCancel" onClick="undo();" alt="여러개 선택한 항목에 대하여 취소 처리합니다." style="cursor:hand;"></a>';

	      } else {
	        _btnCancel.innerHTML = '<img src="/edi/imgs/btn/cancel_off.gif" border="0" id="btnCancel" disabled=true>';
	      }
	      break;
	    case 1 :
	      if (blnShow) {
	        _btnSearch.innerHTML = '<img src="/edi/imgs/btn/search.gif" border="0" id="btnSearch" onClick="btn_Search2();" alt="조회 기능을 수행합니다. (단축키 : ctrl + 1)" style="cursor:hand;"></a>';
	   	    _btnSearch.setAttribute("Auth", "true");
	      } else {
	        _btnSearch.innerHTML = '<img src="/edi/imgs/btn/search_off.gif" border="0" id="btnSearch" disabled=true>';
	        _btnSearch.setAttribute("Auth", "false");
	      }
	      break;
	    case 2 :
	      if (blnShow) {
	        _btnNew.innerHTML = '<img src="/edi/imgs/btn/new.gif" border="0" id="btnNew" onClick="btn_New2();" alt="화면 초기화 및 신규 입력 기능을 수행합니다. \n(단축키 : ctrl + 2)" style="cursor:hand;"></a>';
	        _btnNew.setAttribute("Auth", "true");
	      } else {
	        _btnNew.innerHTML = '<img src="/edi/imgs/btn/new_d.gif" border="0" id="btnNew" disabled=true>';
	        _btnNew.setAttribute("Auth", "false");
	      }
	      break;
	    case 3 :
	      if (blnShow) {
	        _btnDelete.innerHTML = '<img src="/edi/imgs/btn/del.gif" border="0" id="btnDelete" onClick="btn_Delete2();" alt="자료 삭제 처리 및 삭제 체크를 합니다. \n(단축키 : ctrl + 3)" style="cursor:hand;"></a>';
	        _btnDelete.setAttribute("Auth", "true");
	      } else {
	        _btnDelete.innerHTML = '<img src="/edi/imgs/btn/del_d.gif" border="0" id="btnDelete" disabled=true>';
	        _btnDelete.setAttribute("Auth", "false");
	      }
	      break;
	    case 4 :
	      if (blnShow) {
	        _btnSave.innerHTML = '<img src="/edi/imgs/btn/save.gif" border="0" id="btnSave" onClick="btn_Save2();" alt="자료를 저장 처리합니다. \n(단축키 : ctrl + 4)" style="cursor:hand;"></a>';
	        _btnSave.setAttribute("Auth", "true");
	      } else {
	        _btnSave.innerHTML = '<img src="/edi/imgs/btn/save_d.gif" border="0" id="btnSave" disabled=true>';
	        _btnSave.setAttribute("Auth", "false");
	      }
	      break;
	    case 5 :
	      if (blnShow) {
	        _btnExcel.innerHTML = '<img src="/edi/imgs/btn/excel.gif" border="0" id="btnExcel" onClick="btn_Excel2();" alt="조회된 내용을 엑셀/텍스트 파일로 변환합니다. \n(단축키 : ctrl + 5)" style="cursor:hand;"></a>';
	        _btnExcel.setAttribute("Auth", "true");
	      } else {
	        _btnExcel.innerHTML = '<img src="/edi/imgs/btn/excel_d.gif" border="0" id="btnExcel" disabled=true>';
	        _btnExcel.setAttribute("Auth", "false");
	      }
	      break;
	    case 6 :
	      if (blnShow) {
	        _btnPrint.innerHTML = '<img src="/edi/imgs/btn/print.gif" border="0" id="btnPrint" onClick="btn_Print2();" alt="레포트를 출력합니다. \n(단축키 : ctrl + 6)" style="cursor:hand;"></a>';
	        _btnPrint.setAttribute("Auth", "true");
	      } else {
	        _btnPrint.innerHTML = '<img src="/edi/imgs/btn/print_d.gif" border="0" id="btnPrint" disabled=true>' ;
	        _btnPrint.setAttribute("Auth", "false");
	      }
	      break;
	    case 7 :
	      if (blnShow) {
	        _btnDecision.innerHTML = '<img src="/edi/imgs/btn/set.gif" border="0" id="btnDecision" onClick="btn_Conf2();" alt="자료에 대하여 확정 처리합니다. \n(단축키 : ctrl + 7)" style="cursor:hand;"></a>';
	        _btnDecision.setAttribute("Auth", "true");
	      } else {
	        _btnDecision.innerHTML = '<img src="/edi/imgs/btn/set_d.gif" border="0" id="btnDecision" disabled=true>';
	        _btnDecision.setAttribute("Auth", "false");
	      }
	      break;
	   // case 8 :
	   //   if (blnShow) {
	   //     _btnHelp.innerHTML = '<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage(\'btnHelp\',\'\',\'/imgs/btn/b_help_o.gif\',1)"><img src="/imgs/btn/b_help.gif" border="0" id="btnhelp" onClick="btn_Help2();" alt="?????????? ???? ???????? ?? ?? ????????. \n(?????? : ctrl + 8)" style="cursor:hand;"></a>';
	   //     _btnHelp.setAttribute("Auth", "true");
	   //   } else {
	   //     _btnHelp.innerHTML = '<img src="/imgs/btn/b_help_d.gif" border="0" id="btnhelp" disabled=true>';
	   //     _btnHelp.setAttribute("Auth", "false");
	   //   }
	   //   break;
	    default :
	        break;
	  }
	}

function help_Auth() {
  sToken = ssoMainFrame.GetToken();
  if (sToken == null) sToken = "";
  if (sToken != "") {
    if (ssoMainFrame.verifyToken("127.0.0.1").indexOf("UID") == 0) {
      if (ssoMainFrame.GetPermission(SSOGROUP, '127.0.0.1') == "null" || ssoMainFrame.GetLastError() != 0) {
        return -1;
      } else {
      	return 0;
      }
    } else {
      return -1;
    }
  } else {
    return -1;
  }
}

/**
* searchSetWait()
* 작 성 자 : FKL
* 작 성 일 : 2007-01-01
* 개    요 : 화면 처리중 대기 메세지
* return값 : Void
*/
var openWaitWin = null;
function searchSetWait (strGubn) {

  var inHTML  = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> \n';
    	inHTML += '<html> \n';
    	inHTML += '<head> \n';
    	inHTML += '<title>작업 진행 상태</title> \n';
    	inHTML += '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> \n';
    	inHTML += '<link href="/css/common.css" rel="stylesheet" type="text/css"> \n';
    	inHTML += '</head> \n';
    	inHTML += '<body marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 onblur="self.focus()"> \n';
    	inHTML += '<center> \n';
    	inHTML += '<table  border="0" cellpadding="0" cellspacing="0" align="center"> \n';
    	inHTML += '	<tr> \n';
    	if (strGubn == "S") {
    	    inHTML += '		<td><img src="/edi/imgs/popup/img_search.gif"></td> \n';
    	} else if (strGubn == "B") {
    	    inHTML += '		<td><img src="/edi/imgs/popup/img_process.gif"></td> \n';
      }
    	inHTML += '	</tr> \n';
    	inHTML += '</table> \n';
    	inHTML += '</center> \n';
    	inHTML += '</body> \n';
    	inHTML += '</html> \n';
    	
var bodyWidth  = document.body.clientWidth;
var bodyHeight = document.body.clientHeight;      
/*document.getElementById("cfAjaxErrorLayer").style.left = (bodyWidth/2) - (508/2); //팝업의 width 사이즈
document.getElementById("cfAjaxErrorLayer").style.top = (bodyHeight/2) - (188/2);//팝업의 hight 사이즈 */
//	alert(window.screenTop + " // " + window.screenLeft + " // " + bodyWidth + " // " + bodyHeight);
//	var topPos	= Math.ceil(screen.height - 172 ) / 2;
//	var leftPos	= Math.ceil(screen.width -320) / 2;
//	var topPos	= Math.floor((screen.availHeight/2) - (508/2));
//	var leftPos	= Math.floor((screen.availWidth/2)- (188/2));	
	var topPos	= window.screenTop + Math.floor((bodyHeight/2) - (188/2));
	var leftPos	= window.screenLeft + Math.floor((bodyWidth/2) - (508/2));	
	
	if (/MSIE/.test(navigator.userAgent)) {
		if(navigator.appVersion.indexOf("MSIE 7.0")>=0){
	        //IE7에서의 처리
	        if(!openWaitWin) {
	        	openWaitWin = open("","","top="+topPos+",left="+leftPos+",width=508px,height=188px,center=yes");
	        }
	    } else {
	    	if(!openWaitWin) {
	        	openWaitWin = open("","","top="+topPos+",left="+leftPos+",width=508px,height=188px,center=yes");
	        }
	    }
	}
  //if (windowsXPSP2) {
  //    openWaitWin = open("","","top="+topPos+",left="+leftPos+",width=320px,height=192px");
  //} else {
  //    openWaitWin = open("","","top="+topPos+",left="+leftPos+",width=320px,height=172px");
  //}
  	
	
 	openWaitWin.document.writeln(inHTML);
	openWaitWin.document.close();
}

/**
* searchDoneWait()
* 작 성 자 : FKL
* 작 성 일 : 2007-01-01
* 개    요 : 화면 처리중 종료처리 
* return값 : Void
*/
function searchDoneWait() {
   try {
        if (openWaitWin != null) {
            openWaitWin.close();
            openWaitWin = null;
            document.focus();
        }
   } catch (exception) {
       openWaitWin = null;
   }
}
/**
* openWin( path,windowname,w,h,scroll,pos )
* 작 성 자 : 이의덕
* 작 성 일 : 2005-11-01
* 개    요 : Window를 open.
* return값 : void
*/
function openWin( path,windowname,w,h,scroll,pos ) {
  var win=null;
  if (windowsXPSP2) h = h + 20;
  win=window.open(path,windowname,getPopupSettings(w,h,scroll,pos));
  if (win.focus) win.focus();
}

function getPopupSettings(w,h,scroll,pos) {
  if (pos=="random") {
    LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;
    TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;
  }
  if (pos=="center") {
    LeftPosition=(screen.width)?(screen.width-w)/2:100;
    TopPosition=(screen.height)?(screen.height-h)/2:100;
  } else if ((pos!="center" && pos!="random")) {
     LeftPosition=0;TopPosition=20
  }
  if (scroll==null) scroll = 'no';
  settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';
  return settings;
}

function openDialogWin(path,windowname,w,h,scroll,pos) {
    var arrResult = new Array();
  if (windowsXPSP2) h = h + 20;
  arrResult = window.showModalDialog(path, windowname,getDialogPopupSettings(w,h,scroll,pos));
    if (typeof(arrResult) == 'object') return arrResult;
    else
    {
        if (arrResult == 'logout')
        { processLogin(); return; }
    }
}

function getToday() {
  var dt = new Date();
  return dt.getFullYear() + '/' + (dt.getMonth() + 1) + '/' + dt.getDate();
}

function getTodayFormat(format) {  
  var dt = new Date();
  
  return dt.toFormatString(format);
}

function Map(Delimitor) {
  this.Delimitor = (Delimitor == null ? "||" : Delimitor);
  this._MapClass = new ActiveXObject("Scripting.Dictionary");

  this.get = function(key) { return this._MapClass.exists(key) ? this._MapClass.item(key) : null; }
  this.getKey = function (value) {
    var keys = this.keys();
    var values = this.values();
    for (var i in values) {
       if (value == values[i]) return keys[i];
     }
    return "";
  }
  this.put = function(key, value) {
      var oldValue = this._MapClass.item(key);
      this._MapClass.item(key) = value;
      return value;
  }
  this.size = function() { return this._MapClass.count; }
  this.remove = function(key) {
    var value = this._MapClass.item(key);
    this._MapClass.remove(key);
    return value;
  }
  this.clear = function() {
    this._MapClass.removeAll();
  }
  this.keys = function() {
    return this._MapClass.keys().toArray();
  }
  this.values = function() {
    return this._MapClass.items().toArray();
  }
  this.containsKey = function(key) {
    return this._MapClass.exists(key);
  }
  this.containsValue = function(value) {
    var values = this.values();
    for (var i in values) {
      if (value == values[i]) {
        return true;
      }
    }
    return false;
  }
  this.isEmpty = function() { return this.size() <= 0;}
  this.putAll = function(map) {
    if (!(map instanceof Map)) {
      throw new Error(0, "Map.putAll(Map) method?? Map type?? parameter?? ??????????.");
    }
    var keys = map.keys();
    for (var i in keys) {
      this.put(keys[i], map.get(keys[i]));
    }
    return this;
  }

  this.toString = function(separator) {
    var keys = this.keys();
    var result = "";
    separator = separator == null ? "&" : separator;
    for (var i in keys) {
      result += (keys[i] + this.Delimitor + this._MapClass.item(keys[i]));
      if (i < this.size() - 1) {
        result += separator;
      }
    }
    return result;
  }
}

/** 20060925 임시적으로 막음 **/
/**
function errorHandler(message, url, line){
  showMessage(STOPSIGN, OK, "SC-1001", arguments);  
  return true;
}

window.onerror = errorHandler;

**/


function rpad(strTarget, intLen, strChar) {
  var intLength = intLen - strTarget.trim().length;
  var strTemp   = "";
  if (strTarget.trim().length == 0) return "";
  if (intLength <=0) intLen = 0;
  for (var i=1;i<=intLength;i++) {
      strTemp = strTemp + strChar;
  }
  return strTarget.trim() + strTemp;
}

function lpad(strTarget, intLen, strChar) {
  var intLength = intLen - strTarget.trim().length;
  var strTemp   = "";
  if (strTarget.trim().length == 0) return "";
  if (intLength <=0) intLen = 0;
  for (var i=1;i<=intLength;i++) {
      strTemp = strTemp + strChar;
  }
  return strTemp + strTarget.trim();
}

function nullToBlank(argString) {
  if (argString == null || argString == undefined) {
      return "";
  } else {
      return argString
  }
}

function nullToZero(str) {
  if (str == null || str == "" || str==undefined) {
      return "0";
  } else {
      return str;
  }
}

/**
* replaceStr(str,str,str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : REPLACE 실행 
* return : String
*/
function replaceStr(str,str1,str2) {

 if (str == "" || str == null) return str;

 while (str.indexOf(str1) != -1) {
  str = str.replace(str1,str2);
 }
 return str;

}

function Left(str, n){
	if (n <= 0) return "";
	else if (n > String(str).length) return str;
	else return String(str).substring(0,n);
}

function Right(str, n){
  if (n <= 0) return "";
  else if (n > String(str).length) return str;
  else {
     var iLen = String(str).length;
     return String(str).substring(iLen, iLen - n);
  }
}

function onSelectStart() {
  return (window.event.srcElement.tabIndex == -1 || window.event.srcElement.readOnly == true) ? false : true;
}
document.attachEvent('onselectstart', onSelectStart);

function onBeforeActivate() {
  return (window.event.srcElement.tabIndex == -1 || window.event.srcElement.readOnly == true) ? false : true;
}
document.attachEvent('onbeforeactivate', onBeforeActivate);

function loadHelp(){ 
    var goTo = "sysD061";
    var sUrl = "/ngisns/sysD06.sys?goTo=" + goTo+"&pgid="+parent.document.title;
 //   alert(parent.document.title);
    window.open( sUrl, 'new','resizable')
    return false;
}
document.attachEvent('onhelp', loadHelp)


function onMouseOver() {

    var oSource = window.event.srcElement ;    
    if (oSource != null) {        
        switch(window.event.srcElement.tagName.toUpperCase()) {
            case "INPUT" :      
                if (window.event.srcElement.type.toUpperCase() == "TEXT"){
                    if (window.event.srcElement.readOnly == true) {
                        window.event.srcElement.style.cursor = (Version == '6') ? "not-allowed" : "not-allowed";
                    } else {
                       window.event.srcElement.style.cursor = "text";
                    }
                    break;
                }
                break;
            case "OBJECT" :
              switch(window.event.srcElement.classid.toUpperCase()){
                case CLSID_EMEDIT :
                  window.event.srcElement.cursor = (window.event.srcElement.Enable == false) ? "No" : "IBeam";
                  break;
                case CLSID_LUXECOMBO :
                  window.event.srcElement.cursor = (window.event.srcElement.Enable == false) ? "No" : "Default";
                  break;
              }
              break;
            case "IMG" :
              if (window.event.srcElement.disabled == true) {
                window.event.srcElement.style.cursor = (Version == '6') ? "not-allowed" : "not-allowed";
              } else {
                window.event.srcElement.style.cursor = (window.event.srcElement.getAttribute("show") != "false") ? "hand" : "default";//  event.srcElement.style.cursor = "hand";
              }
              break;
            case "TEXTAREA" :
               if (window.event.srcElement.readOnly == true) {
                        window.event.srcElement.style.cursor = (Version == '6') ? "not-allowed" : "Default";
               } else {
                       window.event.srcElement.style.cursor = "text";
               }
              break;
            default :
            break;
        }
    }
}
document.attachEvent('onmouseover', onMouseOver);

function onClick() {

    var oSource = window.event.srcElement ;    
    if (oSource != null) {        
        switch(window.event.srcElement.tagName.toUpperCase()) {
            case "INPUT" :      
                if (window.event.srcElement.type.toUpperCase() == "TEXT"){
                    //window.event.srcElement.select(); [2011.07.29] INPUT 전체선택 하지 않음
                }
                break;
            case "OBJECT" :
            case "IMG" :
            case "TEXTAREA" :
            default :
            break;
        }
    }
}
document.attachEvent('onclick', onClick);

// Form이 로딩시 처리 
function onReadyStateChange(){
  if (document.readyState=="complete" && mainWindow) {
    if (strAuthorization[0] == "11") replaceButton(1, true);
    if (strAuthorization[1] == "11") replaceButton(2, true);
    if (strAuthorization[2] == "11") replaceButton(3, true);
    if (strAuthorization[3] == "11") replaceButton(4, true);
    if (strAuthorization[4] == "11") replaceButton(5, true);
    if (strAuthorization[5] == "11") replaceButton(6, true);
    if (strAuthorization[6] == "11") replaceButton(7, true);
    if (strAuthorization[7] == "11") replaceButton(8, true);
    //replaceButton(8, true);
  }
}

document.attachEvent('onreadystatechange', onReadyStateChange);

function keyDown(DnEvents) {

	// 백 스패이스 제어  Input박스&TextArea
	if (window.event.keyCode == 8){
		if ((document.activeElement.tagName.toUpperCase() != "TEXTAREA")  &&
			(document.activeElement.tagName.toUpperCase() != "OBJECT")    &&
			(document.activeElement.tagName.toUpperCase() != "INPUT")){
			return false;
		}
	}

	if (document.activeElement.tagName.toUpperCase() == "TEXTAREA")
		return true;

	if (document.activeElement.tagName.toUpperCase() == "SELECT") {
		if (window.event.keyCode==8)
			return false;
	}

	if (document.activeElement.tagName.toUpperCase() == "OBJECT") {
		if (document.activeElement.classid.toUpperCase()  == CLSID_GRID) {
			if (document.activeElement.getAttribute("AUTOROW") == "true") {
				if (event.keyCode == 9) {
					eval(document.activeElement.getAttribute("AUTOEVENT"));
					return false;
				}
			}
		}
	}

	var objLastObject;

	//TAB KEY일 경우 마지막 tabIndex가 0 이상일 경우 탭키를 후킹해서 감춤
	if (window.event.keyCode == 9 || window.event.keyCode == 13) {
		var obj = document.body.all;

		for(var i=obj.length - 1 ;i>=0;i--) {
			var strTagName = obj.item(i).tagName.toUpperCase();
			if (strTagName == "INPUT" || strTagName == "OBJECT" || strTagName == "TEXTAREA") {
				// TEXTAREA OBJECT 일경우 ENTER시 탭이동 안함
				if(document.activeElement.classid != null){
					if(window.event.keyCode == 13 && document.activeElement.classid.toUpperCase() == CLSID_TEXTAREA) {
						return;
					}
				}
				if(obj.item(i).tabIndex >= 0 ) {
					objLastObject = obj.item(i);
					break;
				}
			}
		}

		if (window.event.srcElement == objLastObject) {
			return (window.event.shiftKey || window.event.shiftLeft) ? true : false;
		}
	}

	if (window.event.keyCode == 13 && document.activeElement.autoTab != 'N') {
		window.event.keyCode = 9;
		return true;
	}



	// Ctrl + N 제어 처리
	if (window.event.ctrlKey == true) {
		try {
			if( window.event.keyCode == 78 ) {
				return false;
			}
		} catch(e) {
		}
	}

	// 단축키 추가
	if (window.event.ctrlKey == true) {
		try {
			if (window.dialogArguments == undefined  && opener==null) {
				oTemp = document.activeElement;

				switch(window.event.keyCode){
					case 49 : //1 -> 조회
						if (_btnSearch.getAttribute("Auth") == "true") {
							_btnSearch.focus();
							btn_Search();
						}
						break;
						
					case 50 : //2 -> 신규
						if (_btnNew.getAttribute("Auth") == "true"){
							_btnNew.focus();
						btn_New();
						}
						break;
						
					case 51 : //3 -> 삭제
						if (_btnDelete.getAttribute("Auth") == "true") {
							_btnDelete.focus();
							btn_Delete();
						}
						break;
						
					case 52 : //4 -> 저장
						if (_btnSave.getAttribute("Auth") == "true") {
							_btnSave.focus();
							btn_Save();
						}
						break;
						
					case 53 : //5 -> 엑셀
						if (_btnExcel.getAttribute("Auth") == "true") {
							_btnExcel.focus();
							btn_logExcel();
						}
					break;
					
					case 54 : //6 -> 출력
						if (_btnPrint.getAttribute("Auth") == "true") {
							_btnPrint.focus();
							btn_logPrint();
						}
					break;
					
					case 55 : //7 -> 행추가
						if (_btnSubadd.getAttribute("Auth") == "true") {
							_btnSubdel.focus();
							btn_SubAdd();
						}
					break;
					
					case 56 : //8 -> 행삭제
					if (_btnSubdel.getAttribute("Auth") == "true") {
							_btnSubdel.focus();
							btn_SubDel();
						}
						break;
						
					default :
						return true;
						break;
				}
				return false;
			}
		} catch(e) {
		}
	}
}
document.attachEvent("onkeydown", keyDown);




/////////////////////////////////////////////////////////////////START/////////
// TLE.js ( ?? ???????? : http://tle.madvirus.net/wiki )
//
// ????>
//
//	  var checker = new FormChecker(document.all);
//    checker.checkRequired('usrCd'  ,'사원번호를 입력하세요 ,,true); //???????? (?????????? ,alert??????  ,?????? ????)
//    //--?????? ???? ????--
//    checker.checkRequired('sndMail'    ,'?????? ?????? ??????????'      ,true);
//    checker.checkEmail   ('sndMail'    ,'?????? ?????? ?????? ??????????' ,true);
//    
//    function checkForm() {
//        if (checker.validate()) {
//            alert("?? ???? ????");
//        }
//    }
//
///////////////////////////////////////////////////////////////////////////////
function FormChecker(checkForm) {
	this.checkForm = checkForm;
	this.validatorList = new Array();
}
FormChecker.prototype.checkRequired = function(fieldName, errorMessage, focus) {
	this.validatorList.push(new RequiredValidator(this.checkForm, fieldName, errorMessage, focus));
}
FormChecker.prototype.checkMaxLength = function(fieldName, maxLength, errorMessage, focus) {
	this.validatorList.push(new MaxLengthValidator(this.checkForm, fieldName, maxLength, errorMessage, focus));
}
FormChecker.prototype.checkMaxLengthByte = function(fieldName, maxLength, errorMessage, focus) {
	this.validatorList.push(new MaxLengthByteValidator(this.checkForm, fieldName, maxLength, errorMessage, focus));
}

FormChecker.prototype.checkMinLength = function(fieldName, minLength, errorMessage, focus) {
	this.validatorList.push(new MinLengthValidator(this.checkForm, fieldName, minLength, errorMessage, focus));
}
FormChecker.prototype.checkMinLengthByte = function(fieldName, minLength, errorMessage, focus) {
	this.validatorList.push(new MinLengthByteValidator(this.checkForm, fieldName, minLength, errorMessage, focus));
}

FormChecker.prototype.checkRegex = function(fieldName, regex, errorMessage, focus) {
	this.validatorList.push(
		new RegexValidator(this.checkForm, fieldName, regex, errorMessage, focus));
}

FormChecker.prototype.checkAlphaNum = function(fieldName, errorMessage, focus) {
	this.validatorList.push(
		new RegexValidator(this.checkForm, fieldName, 
			/^[a-zA-Z0-9]+$/, errorMessage, focus));
}

FormChecker.prototype.checkOnlyNumber = function(fieldName, errorMessage, focus) {
	this.validatorList.push(
		new RegexValidator(this.checkForm, fieldName, 
			/^[0-9]+$/, errorMessage, focus));
}

FormChecker.prototype.checkDecimal = function(fieldName, errorMessage, focus) {
	this.validatorList.push(
		new RegexValidator(this.checkForm, fieldName, 
			/^(\-)?[0-9]*(\.[0-9]*)?$/, errorMessage, focus));
}

FormChecker.prototype.checkEmail = function(fieldName, errorMessage, focus) {
	this.validatorList.push(
		new RegexValidator(this.checkForm, fieldName, 
			/^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/, errorMessage, focus));
}

FormChecker.prototype.checkSelected = function(fieldName, firstIdx, errorMessage, focus) {
	this.validatorList.push(new SelectionValidator(this.checkForm, fieldName, firstIdx, errorMessage, focus));
}

FormChecker.prototype.checkAtLeastOneChecked = function(fieldName, errorMessage, focus) {
	this.validatorList.push(new AtLeastOneCheckValidator(this.checkForm, fieldName, errorMessage, focus));
}

FormChecker.prototype.validate = function() {
	for (vali = 0 ; vali < this.validatorList.length ; vali ++ ) {
		validator = this.validatorList[vali];
		if (validator.validate() == false) {
			showMessage(STOPSIGN, OK, "US-1000", validator.getErrorMessage());
			if (validator.isFocus() == true) {
			    this.checkForm[validator.getFieldName()].value = "";
				this.checkForm[validator.getFieldName()].focus();
			}
			return false;
		}
	}
	return true;
}

FormChecker.prototype.getForm = function() {
	return this.checkForm;
}


// Validator is base class of all validators
function Vaildator() {
}
Vaildator.prototype.getFieldName = function() {
	return this.fieldName;
}
Vaildator.prototype.getErrorMessage = function() {
	return this.errorMessage;
}
Vaildator.prototype.isFocus = function() {
	return this.focus;
}

// required validator
function RequiredValidator(form, fieldName, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.errorMessage = errorMessage;
	this.focus = focus;
}
RequiredValidator.prototype = new Vaildator;
RequiredValidator.prototype.validate = function() {
	return this.form[this.fieldName].value != '';
}

// max length validator
function MaxLengthValidator(form, fieldName, maxLength, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.errorMessage = errorMessage;
	this.focus = focus;
	this.maxLength = maxLength;
}
MaxLengthValidator.prototype = new Vaildator;
MaxLengthValidator.prototype.validate = function() {
	return this.form[this.fieldName].value.length <= this.maxLength;
}

// max length(byte) validator
function MaxLengthByteValidator(form, fieldName, maxLength, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.errorMessage = errorMessage;
	this.focus = focus;
	this.maxLength = maxLength;
}
MaxLengthByteValidator.prototype = new Vaildator;
MaxLengthByteValidator.prototype.validate = function() {
	str = this.form[this.fieldName].value;
	return(str.length+(escape(str)+"%u").match(/%u/g).length-1) <= this.maxLength;
}

// min length validator
function MinLengthValidator(form, fieldName, minLength, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.errorMessage = errorMessage;
	this.focus = focus;
	this.minLength = minLength;
}
MinLengthValidator.prototype = new Vaildator;
MinLengthValidator.prototype.validate = function() {
	return this.form[this.fieldName].value.length >= this.minLength;
}

// min length(byte) validator
function MinLengthByteValidator(form, fieldName, minLength, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.errorMessage = errorMessage;
	this.focus = focus;
	this.minLength = minLength;
}
MinLengthByteValidator.prototype = new Vaildator;
MinLengthByteValidator.prototype.validate = function() {
	str = this.form[this.fieldName].value;
	return(str.length+(escape(str)+"%u").match(/%u/g).length-1) >= this.minLength;
}

// regex pattern validator
function RegexValidator(form, fieldName, regex, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.regex = regex;
	this.errorMessage = errorMessage;
	this.focus = focus;
}
RegexValidator.prototype = new Vaildator;
RegexValidator.prototype.validate = function() {
	var str = this.form[this.fieldName].value;
	if (str.length == 0) return true;
	return str.search(this.regex) != -1;
}

// check selected
function SelectionValidator(form, fieldName, firstIdx, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.firstIdx = firstIdx;
	this.errorMessage = errorMessage;
	this.focus = focus;
}
SelectionValidator.prototype = new Vaildator;
SelectionValidator.prototype.validate = function() {
	var idx = this.form[this.fieldName].selectedIndex;
	return idx >= this.firstIdx;
}

// check checkbox checked
function AtLeastOneCheckValidator(form, fieldName, errorMessage, focus) {
	this.form = form;
	this.fieldName = fieldName;
	this.errorMessage = errorMessage;
	this.focus = focus;
}
AtLeastOneCheckValidator.prototype = new Vaildator;
AtLeastOneCheckValidator.prototype.validate = function() {
	ele = this.form[this.fieldName];
	if (typeof(ele[0]) != "undefined") {
		// 2~
		for (var idxe = 0 ; idxe < ele.length ; idxe++) {
			if (ele[idxe].checked == true) {
				return true;
			}
		}
		return false;
	} else {
		// only 1
		return ele.checked == true;
	}
}


/**
* getDate(strDate) 
* 개     요 : 요일 체크
* 특이사항 : INPUT  : 날짜 (YYYYMMDD)
*          OUTPUT : 해당 날짜의 요일
* return값 : 
*/
function getDay(strDay){	
		
        var days = new Array("토","일","월","화","수","목","금");
    
	intYear 	= parseInt(strDay.substring(0,4), 10); 	// ??
	intMonthTemp= parseInt(strDay.substring(4,6), 10); 	// ??
	intDay 		= parseInt(strDay.substring(6,8), 10); 	// ??	
	
	intMonth = parseInt(0);

	if (intMonthTemp == 1) {      
		intMonth = parseInt(13, 10);  
		intYear  = intYear-1;
	} else if (intMonthTemp == 2) {      
		intMonth = parseInt(14, 10);
		intYear  = intYear-1;
	} else {
		intMonth = intMonthTemp;
	}
	
	monFlag = parseInt(((intMonth+1)*3)/5, 10); 
	leapYearFlag = parseInt(intYear/4, 10);
	centYearFlag = parseInt(intYear/100, 10);
	leapCentYearFlag = parseInt(intYear/400, 10);
	cal = intDay+(intMonth*2)+monFlag+intYear+leapYearFlag-centYearFlag+leapCentYearFlag+2;
	weakFlag = parseInt(cal/7, 10);

	result = cal-(weakFlag*7);
	
	var resultDay = days[result];		 
	    
	return resultDay;
}


/**
* btnLogPrint()
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 프린터 버튼을 누르면 Log를 남기고 후에 출력을 실행 한다 
* return : true/false
*/
function btn_logPrint() {
    
    var goTo       	= "logInsert";
	var action     	= "O";
	var flag        = "04";
	var programID   = SH_GOTO.value;
	
	var parameters 	= "&programID="+programID+"&flag="+flag;
	TR_PrintLog.Action="/ngisns/comA99.com?goTo="+goTo+parameters;
    TR_PrintLog.KeyValue="SERVLET("+action+":DSPOST=DS_PrintLog)";//조회는 O
	TR_PrintLog.Post();		
	
    //프린터 실행 
    btn_Print();
}

/**
* btn_logExcel()
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 프린터 버튼을 누르면 Log를 남기고 후에 출력을 실행 한다 
* return : true/false
*/
function btn_logExcel() {
    
    var goTo       	= "logInsert";
	var action     	= "O";
	var flag        = "03";
	var programID   = SH_GOTO.value;
	
	var parameters 	= "&programID="+programID+"&flag="+flag;
	TR_PrintLog.Action="/ngisns/comA99.com?goTo="+goTo+parameters;
    TR_PrintLog.KeyValue="SERVLET("+action+":DSPOST=DS_PrintLog)";//조회는 O
	TR_PrintLog.Post();		
	
    //엑셀 실행 
    btn_Excel();
}
/*
 * 입력값의 바이트 길이를 리턴
 * 파라미터 : obj->해당 Object, maxByteLangth 최대byte수
 */
function checkByteLength(obj, maxByteLangth) {
    var intByteLength = 0;
    for (var i = 0; i < obj.value.length; i++) {
        var oneChar = escape(obj.value.charAt(i));
        if ( oneChar.length == 1 ) {
            intByteLength ++;
        } else if (oneChar.indexOf("%u") != -1) {
            intByteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            intByteLength += oneChar.length/3;
        }
        
        if (intByteLength > maxByteLangth) {
        	alert(maxByteLangth + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
        	obj.value = (obj.value).substring(0,i);
        	obj.focus();
        	return;
        }
    }
}

/*
 * 입력값의 바이트 길이를 리턴
 * 파라미터 : 문자 , maxByteLangth 최대byte수
 */
function checkByteLengthStr(str, maxByteLangth, showMsgFlag) {
	showMsgFlag = showMsgFlag==null?"Y":showMsgFlag;
    var intByteLength = 0;
    for (var i = 0; i < str.length; i++) {
        var oneChar = escape(str.charAt(i));
        if ( oneChar.length == 1 ) {
            intByteLength ++;
        } else if (oneChar.indexOf("%u") != -1) {
            intByteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            intByteLength += oneChar.length/3;
        }
        
        if (intByteLength > maxByteLangth) {
        	if(showMsgFlag=="Y")
        	    showMessage(STOPSIGN, OK, "GAUCE-1000", maxByteLangth + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
        	return str.substring(0,i);
        }
    }
    return null
}

/*
* 사용/미사용 radio click시 value를 변경한다.
*/
function changeRadio(obj){
	var name = obj.name;
	var newObj = eval("document.all."+name.substring(0,name.lastIndexOf("_")));
	newObj.value = obj.value;
}	
/*
* 사용/미사용 radio를  DataSet의 값으로 setting 한다.
*/
function setRadio(){
	var length = arguments.length;
	var Dsobj = arguments[0];

	for (var i=1; i<length; i++) {
		if ( Dsobj.NameValue(1,arguments[i]) == 1 || Dsobj.NameValue(1,arguments[i]) == "Y" ) { 
			eval("document.all."+arguments[i]+"_YN[0].checked = true");
			eval("document.all."+arguments[i]+"_YN[1].checked = false");
		} else { 
			eval("document.all."+arguments[i]+"_YN[1].checked = true");
			eval("document.all."+arguments[i]+"_YN[0].checked = false");
		}
	}
}	

/*
* Title Text를 일정 크기로 보여준다.
*/
function cutTitleText(str, len) {
	var newStr = "";
	if ( str.length <= len ) return str;
	newStr = str.substring(0,len) + " ..";
	return newStr;
}



/**
* isBetweenObj(fromObj, toObj)
* 개     요 : 날짜 Check
* 특이사항 : INPUT  : 날짜 (YYYYMMDD)
*          OUTPUT : 해당 날짜의 요일
* return값 : 
*/
function isBetweenObj(fromObj, toObj) {
	var date_from = fromObj.value.replace(/-/g,"");
	var date_to   = toObj.value.replace(/-/g,"");

	if ( date_from > date_to ){ 		
 		fromObj.focus();
 		return false;
 	}
 	
 	return true;
}

/**
* isBetweenFromTo(strFrom, strTo) 
* 개     요 : 날짜 Check
* 특이사항 :
* return값 : 
*/
function isBetweenFromTo(strFrom, strTo) {
	var date_from = strFrom.replace(/-/g,"");
	var date_to   = strTo.replace(/-/g,"");

	if ( date_from > date_to ){ 		 		
 		return false;
 	}
 	
 	return true;
}

/*
* Currency format 으로 변경한다.
* parameter 해당 객체명
*/
function toCurrency(){
	var length = arguments.length;
	var obj;

	for (var i = 0; i < length; i++){
		obj = eval("document.all." + arguments[i]);
        obj.value = formatPrice(obj.value, 1);
	}
}

/**
* checkByteStr(obj, maxByteLangth, showMsgFlag, row, colId)
* 작성자   : 김성미
* 작성일자 : 2011-03-29
* 개요     : 
* return   : 
*/
function checkByteStr(obj, maxByteLangth, showMsgFlag, row, colId) {
	var strValue = "";
	showMsgFlag = showMsgFlag==null?"Y":showMsgFlag;
    switch (obj.classid.toUpperCase()){
    	case CLSID_GRID:
    		var objDs = eval(obj.DataID);    		
    		strValue = objDs.NameValue(row, colId);
    		break;
    	case CLSID_EMEDIT:
    		strValue = obj.Text;
    		break;
    	case CLSID_TEXTAREA:
    		strValue = obj.Text;
    		break;	
    }
    var intByteLength = 0;
    for (var i = 0; i < strValue.length; i++) {
        var oneChar = escape(strValue.charAt(i));
        if ( oneChar.length == 1 ) {
            intByteLength ++;
        } else if (oneChar.indexOf("%u") != -1) {
            intByteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            intByteLength += oneChar.length/3;
        }
  
        if (intByteLength > maxByteLangth) {
        	if(showMsgFlag=="Y")
        	    showMessage(STOPSIGN, OK, "GAUCE-1000", maxByteLangth + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
        	switch (obj.classid.toUpperCase()){
	          	case CLSID_GRID:
	          		objDs.NameValue(row, colId) = strValue.substring(0,i);
	          		break;
	          	case CLSID_EMEDIT:
	          		obj.Text = strValue.substring(0,i);
	          		break;
	          	case CLSID_TEXTAREA:
	          		obj.Text = strValue.substring(0,i);
	          		break;
          }
        	return false;
        }
    }
    return true;
}



/**
 * initText(format, target)
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-13
 * 개    요 : eme edit의 스타일을 적용한다.
 * 
 * 사용방법 : initEmEdit(SYYYYMMDD, target);  SYYYYMMDD : 형태 target: text 이름
 * 
 */
function initDateText(format, target){
		// 오늘 일자 셋팅 
		  var now = new Date();
		  var mon = now.getMonth()+1;  //월
		  if(mon < 10)mon = "0" + mon;
		  var day = now.getDate();     //일
		  if(day < 10)day = "0" + day;	  
		  	  
		  if( format == "SYYYYMMDD" ){         //시작일 예)20110401
			  var varToday = now.getYear().toString() + "/" + mon + "/" + "01";
		  }else if( format == "EYYYYMMDD" ){   //종료일 예)20110431
			  var lastDate =new Date(now.getYear().toString(),mon, 0); //마지막일 구하기
		      var varToday = now.getYear().toString()+ "/" + mon + "/" + lastDate.getDate();
		  }else if( format == "TODAY"  ){
			  var varToday = now.getYear().toString()+ "/" + mon + "/" + day;
		  } else if( format == "YYYYMM" ){
			  var varToday = now.getYear().toString()+ "/" + mon;
		  }
		  document.getElementById(target).value = varToday;
	}

/**
 * initText(target, style, value)
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-13
 * 개    요 : eme edit의 스타일을 적용한다.
 * 
 * 사용방법 : initEmEdit("strcd", "PK", 데이타 값);  SYYYYMMDD : 형태 target: text 이름
 * 		1: text id 명  2: 활성화(READ) , 비활성화(PK)   3.value 
 */

function initEmText(target , style, value){
	    var obj = document.getElementById(target);
	    
	    if( style == "PK" ){		//text 비활성화
	    	
	    	obj.disabled = true;
	    	
	    }else if( style == "READ" ){	//활성화
	    
	    	obj.disabled = false;
	    }
	    obj.value = value;
	    return;
}


/**
 * onlyNum()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-05
 * 개    요 : 숫자 체크
 * return값 : void
 */

function onlyNumber(){
	var e = window.event;
    var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
    if (keyCode!=13) {
    	
        if((keyCode>47 && keyCode<58)) {
            e.returnValue = true;
        } else {
            e.returnValue= false;
        }
    }   
}

/**
 * onlyNum()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-05
 * 개    요 : 숫자 체크
 * return값 : void
 */

function onlyNumber2(){
	var e = window.event;
	var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
	if (keyCode!=13) {
		
		if((keyCode>47 && keyCode<58)) {
			e.returnValue = true;
		} else {
			showMessage(STOPSIGN, OK, "USER-1000","숫자만 입력 가능합니다.");
			//alert("숫자만 입력 가능합니다.");
			e.returnValue= false;
		}
	}   
}

/**
 * setPorcCount()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : tr결과에 대한 return value count세팅
 * return값 : void
 */

function setPorcCount(jobgubun, cnt){
	var gubun = jobgubun.toUpperCase();            //대문자로 변환
	
	switch(gubun){
	   case "SELECT" :
		   if( typeof(arguments[1]) == "object" ){
			   var cntId = arguments[1].id;
			   var cntCount = arguments[1].value;
			   window.status = "▒▒▒▒▒ [" + cntCount + "]건이 조회되었습니다. ▒▒▒▒▒";
		   }else {
			   window.status = "▒▒▒▒▒ [" + cnt + "]건이 조회되었습니다. ▒▒▒▒▒";
		   }
		   break;
	   case "CLEAR" :
		   window.status = "";
	       break;
	   default :
		   break;
	}
	if (cnt < 1) showMessage(Information, OK, "USER-1000","조회된 내역이 없습니다.");
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	
	
    return;
}

/**
 * dateCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 날짜 유효성 체크
 * return값 : void
 */

function dateCheck(obj, str){ 
	var value = getRawData(trim(obj.value));
	if( value == "" ){
		return false;
	}  
	if( value.length == 8 ){
		
		var sYY = value.substring(0,4);
		var sMM = value.substring(4,6);
		var sDD = value.substring(6,8);
	  
		//  alert(sYY + " , " + sMM + " , " + sDD);
	    
		//년도 체크
		//if(isNull(sYY.value)) return true;    
	  
		if (sYY.length != 4) { 
			showMessage(INFORMATION, OK, "USER-1000", "입력한 년도를 확인하세요.");  
			return false;
		}
	 
		if (sYY.substring(0,2) == "19" || sYY.substring(0,2) == "20") { 
			yy = parseFloat(sYY);
		}else {
			showMessage(INFORMATION, OK, "USER-1000", "입력한 년도를 확인하세요."); 
			if(str == "")
				obj.value = getTodayFormat("YYYY/MM/DD");
			else
				obj.value = str;
			
			obj.focus();
			return false;
		}  
	  
		//월 체크
		//if(isNull(sMM.value)) return true;   
	  
		//if(!isNull(sMM))plusZero(sMM);           
	  
		mm = parseFloat(sMM);

		if (mm == 1) 
			max_days = 31; 
		else if (mm == 2) { 
			if ((( yy % 4 == 0) && (yy % 100 != 0)) || (yy % 400 == 0)) //윤년
				max_days = 29; 
			else 
				max_days = 28; 
		}
		else if (mm == 3) 
			max_days = 31;
		else if (mm == 4) 
			max_days = 30;
		else if (mm == 5) 
			max_days = 31;
		else if (mm == 6) 
			max_days = 30;
		else if (mm == 7) 
			max_days = 31;
		else if (mm == 8) 
			max_days = 31;
		else if (mm == 9) 
			max_days = 30;
		else if (mm == 10) 
			max_days = 31;
		else if (mm == 11) 
			max_days = 30;
		else if (mm == 12) 
			max_days = 31;
		else {  
			showMessage(INFORMATION, OK, "USER-1000", "월을 잘못 입력하셨습니다. 다시입력하세요");  
			if(str != "")
				obj.value = "";
			
			obj.focus();
			return false; 
		} 
	 
		//일 체크
		//if(isNull(sDD.value)) return true; 

		//if(!isNull(sDD))plusZero(sDD);          
	 
		dd = parseFloat(sDD);  

		if (dd >= 1 && dd <= max_days){
			obj.value = value.substring(0,4) + "/" + value.substring(4,6) + "/" + value.substring(6,8);
			return true;
		}
		else {  
			showMessage(INFORMATION, OK, "USER-1000", "일을 잘못 입력하셨습니다. 다시입력하세요");   
			if(str != "")
				obj.value = "";
			obj.focus();
			return false; 
		} 
 
		if( !checkYYYYMMDD(value)){			
			alert("입력하신 "+value+" 는 유효하지 않는 날짜형식입니다.");
			if(str != "")
				obj.value = "";
			obj.focus();
			return ;
		} else {
			if(str == "")
				obj.value = value.substring(0,4) + "/" + value.substring(4,6) + "/" + value.substring(6,8);
			else
				obj.value = str;
			
			alert(obj.value);
		} 
		return;
	}else { 
		alert("입력하신 "+value+" 는 유효하지 않는 날짜형식입니다.");
		if(str != "")
			obj.value = "";
		obj.focus();
        obj.focus();
        return ;
	} 
	return ;
}

/**
 * dateOnblur()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 년월 유효성 체크
 * return값 : void
 */

function dateOnblur( obj ){
    
	// 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;  //월
    if(mon < 10)mon = "0" + mon;
    
	var value = getRawData(trim(obj.value));
    
    if( value == "" ){
        return false;
    }
    
    if( value.length < 7 ){
    	var sYY = value.substring(0,4);
		var sMM = value.substring(4,6); 
	  
		//  alert(sYY + " , " + sMM + " , " + sDD);
	    
		//년도 체크
		//if(isNull(sYY.value)) return true;    
	  
		if (sYY.length != 4) { 
			showMessage(INFORMATION, OK, "USER-1000", "입력한 년도를 확인하세요.");  
			return false;
		}
	 
		if (sYY.substring(0,2) == "19" || sYY.substring(0,2) == "20") { 
			yy = parseFloat(sYY);
		}else {
			showMessage(INFORMATION, OK, "USER-1000", "입력한 년도를 확인하세요.");  
			obj.value = getTodayFormat("YYYY/MM");
			obj.focus();
			return false;
		}  
	  
	  
		//월 체크
		//if(isNull(sMM.value)) return true;   
	  
		//if(!isNull(sMM))plusZero(sMM);           
	  
		mm = parseFloat(sMM);
	  
		if (1>mm || mm> 12) {
			showMessage(INFORMATION, OK, "USER-1000", "월을 잘못 입력하셨습니다. 다시입력하세요");  
			obj.value = getTodayFormat("YYYY/MM");
			obj.focus();
			return false; 
		}

    	if( !checkYYYYMM(value) ){
            showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+value+"' 는 유효하지 않는 날짜형식입니다."); 
    		obj.value = now.getYear().toString()+ "/" + mon;
    		obj.focus();
    	} else {
    		obj.value = value.substring(0,4) + "/" + value.substring(4,6);
    	}
    } else {
        showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+vlaue+"'는 유효하지 않는 날짜형식입니다.");
    	obj.focus();
    }
    
}

/**
 * dateCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 날짜 유효성 체크
 * return값 : void
 */
function dateValid(obj) {
	if(obj.value != "") {
		obj.value = obj.value.split("/").join("");
	}
}

/**
 * dateCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 날짜 유효성 체크
 * return값 : void
 */
function dateValid2(obj) {
	if(obj.value != "") {
		var YYYYMM = obj.value;
		obj.value = YYYYMM.substring(0,4) + "/" + YYYYMM.substring(4,6);
	}
}

/**
 * dateCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 전표 포맷 (1111-1111111)
 * 수 정 자 : DHL
 * 수 정 일 : 2012-06-11
 * 수정이력 : 전표 포맷 변경 (1111-1-111111)
 *           전표년월(4)-전표구분(1)-일련번호(7)
 * return값 : void () 
 */
function slip_format(strID, obj) {	
  strID = getRawData(strID);
/*  
  // 원본
  if (strID.length!=11){ 
	  return "";
  }else{
	  if(obj == undefined)
		  return strID.substring(0,4)+"-"+strID.substring(4,11);
	  else
		  obj.value = strID.substring(0,4)+"-"+strID.substring(4,11);
  }
  */

  if (strID.length!=12){ 
	  return "";
  }else{
	  if(obj == undefined)
		  return strID.substring(0,4)+"-"+strID.substring(4,5)+"-"+strID.substring(5,12);
	  else
		  obj.value = strID.substring(0,4)+"-"+strID.substring(4,5)+"-"+strID.substring(5,12);
  }

}



/**
 * pumbun()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 점별브랜드
 * return값 : void
 */
function pumbun(obj){
	
	var pumbunNm = document.getElementById("pubumNm");
	
	if( obj.value == "" ){
		pumbunNm.value = "";
		return;
	}
	if( obj.value != null ){
		if( obj.value.length > 0 ){
			openPop("S", "N");
		}else {
			return;
		}
	}
	
}
/**
 * openPop()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 점별브랜드(팝업 띄우기)
 * return값 : void
 */
function openPop(strFlag, strGb){
	
	if( strFlag == "S" ){
		var objCd = document.getElementById("pubumCd");
		var objNm = document.getElementById("pubumNm");
		var objStr = document.getElementById("strcd");
	}else if( strFlag == "I" ){
		var objCd = document.getElementById("pubumCd");
	    var objNm = document.getElementById("pubumNm");
	    var objStr = document.getElementById("strcd");
	}
	
	if( strGb == "N" && objCd.value.length > 0 ){
		alert("aa");
		setStrPbnNmWithoutPop(objCd, objNm, "Y", "1", objStr.value);
	}else {
		strPbnPop( objCd, objNm, "N", objStr.BindColVal);
	}
	
}
/**
 * setStrPbnNmWithoutPop()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-04-19
 * 개    요 : 점별브랜드
 * return값 : void
 */
function setStrPbnNmWithoutPop(objCd, objNm, authGb, searchTp, strcd){
	//alert("setStrPbnNmWithoutPop");
	if(trim(objCd.value) == "" && trim(objNm.value) == ""){
        return;
    }
	//alert(objCd.value);
	//alert(objNm.value);
	
	var param = "&goTo=searchOnWithoutPop&objcd="+objCd.value+"&objNm="+objNm+"&strcd="+strcd+"&authGb="+authGb;
	
	
}

/**
* addDate(strFlg,intDiff,strCheckDate)
* 개    요 : 년, 월, 일 에대한 i만큼의 전후 날짜 계산
* 인    수 : 1. strFlg  : 구분 ("y":년, "m":월, "d":일)
*            2. i       : (-i:before, +i:after) difference value
*            3. strCheckDate : 날짜
* return값 : string YYYY-MM-DD
*/
function addDate(strFlg, i, strCheckDate) {

	strCheckDate = getRawData(strCheckDate);

	var dateTypeVal = new Date(strCheckDate.substring(0,4),strCheckDate.substring(4,6)-1,strCheckDate.substring(6,8));

	var retDate;

	var nWeekDay=dateTypeVal.getDay();

	if (strFlg.toUpperCase() == "Y") {
		retDate = new Date(dateTypeVal.getFullYear() + eval(i),dateTypeVal.getMonth(),dateTypeVal.getDate());
	}
	else if (strFlg.toUpperCase() == "M") {
		retDate = new Date(dateTypeVal.getFullYear(),dateTypeVal.getMonth() + eval(i),dateTypeVal.getDate());
	}
	else if (strFlg.toUpperCase() == "D") {
		retDate = new Date(dateTypeVal.getFullYear(),dateTypeVal.getMonth(),dateTypeVal.getDate() + eval(i));
	}
	else{
		retDate = new Date(dateTypeVal.getFullYear(),dateTypeVal.getMonth(),dateTypeVal.getDate());
	}
	return retDate.getFullYear() + "/" + numFormat(retDate.getMonth()+1,2) + "/" + numFormat(retDate.getDate(),2);

}

/**
 * getCalcPord(flag, numCost, numSale, numMgRate, strTaxFlag, roundFlag)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-03-08
 * 개    요 : 발주매입(차익액, 차익율)을 계산한다.
 *            flag       ----> 계산할 항목
 *            numCost    ----> 원가(금액)
 *            numSale	  ----> 매가(금액)
 *            strTaxFlag ----> 과세구분(1: 과세, 2: 면세, 3: 영세)
 *            roundFlag  ----> 반올림구분 ( 3: 올림, 2: 버림, 1: 반올림 )
 * return값 : void
 */
 function getCalcPord(flag, numCost, numSale, numMgRate, strTaxFlag, roundFlag){
	 var rtnNum = 0;
	  var T=Number('1e'+8); 
	  var tmp1   = 0;
	  var tmp2   = 0;
	  
	  switch (flag) {
	  case "GAP_AMT":		// 차익액
	  	switch (strTaxFlag){
	   	case "1":
	   		rtnNum = getRoundDec("1", (numSale*10)/11 - numCost); 
	   		break;
	   	case "2":
	   		rtnNum = getRoundDec("1", numSale - numCost); 
	   		break;
	   	case "3":
	   		rtnNum = getRoundDec("1", numSale - numCost);
	   		break;
	   	}
	   	break;
    case "GAP_RATE":	// 차익율
   	switch (strTaxFlag){
	   	case "1":
	   		if(numSale == 0)
	   			break;

	   		rtnNum = getRoundDec("1", (((numSale*10)/11) - numCost)/((numSale*10)/11) *100,2);
	   		
	   		break;
	   	case "2":
	   		if(numSale == 0)
	   			break;
	   		
	   		rtnNum = getRoundDec("1",(numSale - numCost)/numSale * 100,2);
	   		break;
	   	case "3":
	   		if(numSale == 0)
	   			break;

	   		rtnNum = getRoundDec("1",(numSale - numCost)/numSale * 100,2);
	   		break;
	   	}
	   	break;
    case "COST_PRC":	// 원가단가
   	switch (strTaxFlag){
	   	case "1":
	   		//tmp1 = Math.round(((numSale*10)/11)*T)/T;
	   		//tmp2 = Math.round(((100-numMgRate)/100)*T)/T;
	   		//rtnNum = getRoundDec(roundFlag, tmp1 * tmp2);
	   		rtnNum = getRoundDec("1", (((numSale*10)/11)*(100-numMgRate))/100);
	   		//alert("rtnNum-1 : " +rtnNum);
	   		break;
	   	case "2":
	   		rtnNum = getRoundDec("1", (numSale*(100-numMgRate))/100);
	   	//	alert("rtnNum-2 : " +rtnNum);
	   		break;
	   	case "3":
	   		rtnNum = getRoundDec("1", (numSale*(100-numMgRate))/100);
	   	//	alert("rtnNum-3 : " +rtnNum);
	   		break;
	   	}
	   	break;
    case "SALE_PRC":	// 매가단가
   	 
   	tmp1 = Math.round((100-numMgRate)*T)/T;
    	
   	switch (strTaxFlag){
	   	case "1":
	 	   	if(numMgRate == 100)
	 	   		break;
	 	   	//alert((numCost*100*1.1)/tmp1 +":"+(numCost*100*1.1)/(100-numMgRate));
	 		//alert(getRoundDec(roundFlag, (numCost*100*1.1)/tmp1,-1) +":"+getRoundDec(roundFlag, (numCost*100*1.1)/(100-numMgRate),-1));
	   		rtnNum = getRoundDec("1", (numCost*100*1.1)/tmp1,-1);
	   		//alert(rtnNum);
	   		break;
	   	case "2":
	 	   	if(numMgRate == 100)
	 	   		break;
	 	   	
	   		rtnNum = getRoundDec("1", (numCost*100)/tmp1,-1);
	   		break;
	   	case "3":
	 	   	if(numMgRate == 100)
	 	   		break;

	   		rtnNum = getRoundDec("1", (numCost*100)/tmp1,-1);
	   		break;
	   	}
	   	break;
    case "VAT_AMT":	// 부가세
     	switch (strTaxFlag){
 	   	case "1":
 	   		rtnNum = getRoundDec(roundFlag, numCost*0.1);
 	   		break;
 	   	case "2":
 	   		rtnNum = 0;
 	   		break;
 	   	case "3":
 	   		rtnNum = 0;
 	   		break;
 	   	}
 	   	break; 	
	   	
	  }
	  return rtnNum;
 }
/**
* daysBetween('yyyymmdd','yyyymmdd')
* 개    요 : 두날짜의 일자 계산 
* return값 : string 
*/
function daysBetween(date1, date2) {
    date1 = new Date(date1.substring(0, 4), date1.substring(4, 6)-1, date1.substring(6,8));
    date2 = new Date(date2.substring(0, 4), date2.substring(4, 6)-1, date2.substring(6,8));
    var DSTAdjust = 0;
    oneMinute = 1000 * 60;
    var oneDay = oneMinute * 60 * 24;
    date1.setHours(0);
    date1.setMinutes(0);
    date1.setSeconds(0);
    date2.setHours(0);
    date2.setMinutes(0);
    date2.setSeconds(0);
    DSTAdjust = (date2.getTimezoneOffset( ) - 
                     date1.getTimezoneOffset( )) * oneMinute;
    var diff = date2.getTime( ) - date1.getTime() - DSTAdjust;
    return Math.ceil(diff/oneDay);
}



/**
* getRawData(strData)
* 개    요 : 입력값에서 구분자인 '/', '.', '-',':' 등을 제거하여 리턴
* return값 : string
*/
function getRawData(strData) {
    if (strData==null || strData == "")
        return "";
    strData = strData.replace(/\//g,"");
    strData = strData.replace(/-/g,"");
    strData = strData.replace(/\./g,"");
    strData = strData.replace(/\:/g,"");
    return strData;
}

/**
* numFormat(strNum, intLen)
* 개    요 : 숫자 자리수 포맷-자릿수에 맞게 '0'를 채움
* return값 : string
*/
function numFormat(strNum, intLen) {
    var strTmp = '' + strNum;
    var intLenNum = strTmp.length;
    var strRtnNum = '';

    if (intLenNum > intLen)
        return strTmp;

    for(i=0;i<intLen-intLenNum;i++) {
        strRtnNum = strRtnNum + '0';
    }

    return strRtnNum + strTmp;
}

// Enter 키 입력시 바로 조회
// 사용법 :  객체 속성에서  onKeyUp="btn_Search();"
/**
function enterQuery() {
	var length 	= arguments.length;
    if (!window.event.ctrlKey && (window.event.keyCode == 113 || window.event.keyCode == 13)) {
    	if ( length == 1 ) arguments[0].blur(); 
        btn_Search();
    }
}
**/
/**
* ChangeUpperCase(name)
* 개    요 : 대문자로 변환 INPUT 박스의 경우만 해당 
* return값 : string
*/
function ChangeUpperCaseObj(name) {
    var ch;
    for (var i = 0; i < name.value.length; i++) {
        ch = name.value.charCodeAt(i);
        if (ch < 128) name.value = name.value.toUpperCase();
    }
}


// 숫자체크 - 유효성check
function isDigit(value) {
    for (var i = 0; i < value.length; i++) {
        var oneChar = value.charAt(i)
        if (oneChar < "0" || oneChar > "9")
            return false
    }
    return true
}

/*===================================================*
// 필수 입력 항목을 check한다.
*===================================================*/
// Form Object를 Parameter로 받는다.

/**
function checkEssential(oDocument) {
    // 인자가 없으면 기본으로 self.document로 간주한다.
    if (arguments.length == 0) {
        oDocument = self.document;
    }

    var formObjs = oDocument.all;
	for (var intLoop = 0; intLoop < formObjs.length; intLoop++) {
	    if (formObjs[intLoop].tagName == "INPUT" || formObjs[intLoop].tagName == "SELECT" || formObjs[intLoop].tagName == "TEXTAREA") {
	        if (formObjs[intLoop].essential == undefined || formObjs[intLoop].essential == "N") continue;
	        if (formObjs[intLoop].value == "") {
	            alert(formObjs[intLoop].desc + "??(??) ???? ???? ???? ??????.");
	            formObjs[intLoop].focus();
	            return false;
	        }
	    }
	}
 
    return true;
}
**/

/**
  * onBlurTextBox()
  * 작 성 자  : 권대용 
  * 작 성 일  : 2007-01-15
  * 개     요  : Focus가 나갈때 실행 ㄴ
  * 사용방법: onBlurTextBox(OBJECT, String)
  * return값 : 
  */
  
function onBlurTextBox(pObj, pType){
    if (pType == "DATE") {
        if (pObj.value != null && pObj.value != "" ) {
           autoMaskEdit(pObj, '####-##-##');
            if (!checkYYYYMMDD(removeChar(pObj.value, '-'))) {
                pObj.focus();              
            }
        }
    }else if(pType=="YEAR"){
         if(pObj.value != null && pObj.value != ""){
             autoMaskEdit(pObj,'####');

            if (isNaN(pObj.value)){
                pObj.focus();
            }
        }
    }else if(pType=="MONTH"){
         if(pObj.value != null && pObj.value != ""){
            autoMaskEdit(pObj,'####-##');

            if(!isValidMonth(pObj.value.substring(pObj.value.length -2,pObj.value.length))){
               pObj.focus();
            }
        }
    }else if (pType == "MONEY"){
        if (pObj.value != null && pObj.value != ""){
            pObj.value = amtFormat(pObj);
        }
    }else if (pType == "ALPAANUM") {
        if (pObj.value != null && pObj.value != ""){
            if(!isAlphaNum(pObj)){
               pObj.focus();
            }
        }
    }else if (pType == "NUMERIC") {
        if (pObj.value != null && pObj.value != ""){
            if(!isNumber(pObj)){
               pObj.focus();
            }
        }
    }

}
/**
* 유효한(존재하는) 월(月)인지 체크
*/
function isValidMonth(mm)
{
    var m = parseInt(mm, 10);
    return (m >= 1 && m <= 12);
}


/**
 * TextBox?? focus?? ???????????? ???????????? ?????? ????
 * ex) <input type="text" onFocus="onFocusTextBox(this,'DATE');" value=''>
 *     <input type="text" onFocus="onFocusTextBox(this,'MONEY');" value=''>
 */
function onFocusTextBox(pObj, pType)
{
    if(pType=="DATE" || pType=="MONTH"){
        if (pObj.value != null && pObj.value != ""){
            var arrValue;
            var cutValue = "";
            arrValue = pObj.value.split('-');
            for (var i = 0; i < arrValue.length; i++)
                cutValue += arrValue[i];

            pObj.value = cutValue;

        }
    }
     else if (pType == "YEAR"){
        if (pObj.value != null && pObj.value != ""){
            pObj.select();
        }
    }
    else if (pType == "MONEY"){
        if (pObj.value != null && pObj.value != ""){
            var arrValue;
            var cutValue = "";
            arrValue = pObj.value.split(',');
            for (var i = 0; i < arrValue.length; i++)
                cutValue += arrValue[i];

            pObj.value = cutValue;

            pObj.select();
        }
    }
}
/**
  * onKeyUpTextBox()
  * 작 성 자  : 권대용 
  * 작 성 일  : 2007-01-15
  * 개     요  : KeyUp할때 발생 
  * 사용방법: onKeyUpTextBox(OBJECT, String)
  * return값 : 
  */
function onKeyUpTextBox(pObj, pType)
{
    if (pType == "DATE") {
        checkKeyPattern(pObj, '0123456789');
    }else if(pType=="YEAR"){
        checkKeyPattern(pObj,'0123456789');
    }else if(pType=="MONTH"){
        checkKeyPattern(pObj,'0123456789');
    }else if (pType == "MONEY"){
        checkKeyPattern(pObj, '0123456789,.');
    }else if (pType == "DIGITS"){
        checkKeyPattern(pObj, '0123456789,.-)');
    }else if(pType == "ALPAANUM") {
        checkKeyPattern(pObj, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789');
    }else if (pType == "SPECIAL"){
        checkKeyPattern2(pObj, '<>+=/~!@#$%^&*()_-');
    }else if (pType == "EXCEPTION"){
        checkKeyPattern2(pObj, '%');
    }else if (pType == "NUMERIC"){
        checkKeyPattern(pObj, '0123456789');
    }else if (pType == "TEL"){
        checkKeyPattern(pObj, '0123456789-');
    }else if (pType == "EMAIL"){
        checkKeyPattern2(pObj, '<>+=/~!#$%^&*()_-');
    }else if (pType == "SHORT"){
        checkKeyPattern2(pObj, '<>+=/~!@#$%^&*_-');
    }else if (pType == "CONTENTS"){
        checkKeyPattern2(pObj, '<>!@#$%');
    }
}

function getLastDay(year, month)
{
	var Last_Mon = new Array(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var Mon2;

	if (year % 4 == 0)
		Mon2 = true;
	else
		Mon2 = false;

	Last_Mon[1] = (Mon2) ? 29 : 28;

	return Last_Mon[month-1];
}

/*===================================================*
 * focus가 왔을때 '-'을 remove한 후 선택한다.
 *===================================================*/
function removeHyphen(oSource) {
    var str = oSource.value;

    while (str.indexOf("-") > -1)
    {
        str = str.substring(0, str.indexOf("-")) + str.substring(str.indexOf("-") + 1, str.length);
    }

    oSource.value = str;
    oSource.select();
}

/*
// -- > 내부에서 사용할려고 하는 함수 입니다. 사?G하지 마세요.
// checkPattern, checkKeyPattern ,   autoMaskEdit
// ------------------ START ----------------------------------
*/
function checkPattern(pObj, searchString)
{
    if (pObj.value != '' && pObj.value != null){
        if (pObj.value.search(searchString) != 0){
            pObj.focus();
            pObj.select();
        }
    }
}

/**
  * checkKeyPattern()
  * 작 성 자  : 권대용 
  * 작 성 일  : 2007-01-15
  * 개     요  : 패턴 Check 있으면 true 존재하지 않으면 'false'
  * 사용방법: checkKeyPattern(OBJECT, String)
  * return값 : 
  */
  
function checkKeyPattern(pObj, pAssignText){
    var tValue;
    tValue = pAssignText;

    var sourceValue;
    sourceValue = pObj.value;

    if (pObj.value != null && pObj.value != ""){
        for (var n_i = sourceValue.length - 1; n_i >= 0; n_i--){
            var tChar = sourceValue.charAt(n_i);
            var chkFlag = false;

            for (j = 0; j < tValue.length; j++){
                var compChar = tValue.charAt(j);

                if (tChar.toLowerCase() == compChar.toLowerCase()){
                    chkFlag = true;
                }
            }
            if (chkFlag == false){
                pObj.value = sourceValue.substring(0, n_i);
                event.cancelBubble = true;
                event.returnValue = false;
            }
        }
    }
}

/**
  * checkKeyPattern2()
  * 작 성 자  : 권대용 
  * 작 성 일  : 2007-05-25
  * 개     요  : 패턴 Check 있으면 false 존재하지 않으면 'true'
  * 사용방법: checkKeyPattern2(OBJECT, String)
  * return값 : 
  */
  
function checkKeyPattern2(pObj, pAssignText){
    var tValue;
    tValue = pAssignText;

    var sourceValue;
    sourceValue = pObj.value;

    if (pObj.value != null && pObj.value != ""){
        for (var n_i = sourceValue.length - 1; n_i >= 0; n_i--){
            var tChar = sourceValue.charAt(n_i);
            var chkFlag = true;

            for (j = 0; j < tValue.length; j++){
                var compChar = tValue.charAt(j);

                if (tChar.toLowerCase() == compChar.toLowerCase()){
                    chkFlag = false;
                }
            }
            if (chkFlag == false){
                pObj.value = sourceValue.substring(0, n_i);
                event.cancelBubble = true;
                event.returnValue = false;
            }
        }
    }
}

/**
  * checkValuePattern()
  * 작 성 자  : 엄준석
  * 작 성 일  : 2011-01-04
  * 개     요  : 패턴 Check 있으면 true 존재하지 않으면 'false'
  * 사용방법: checkValuePattern(String, String)
  * return값 : 
  */
function checkValuePattern(val, pAssignText){
    var tValue = pAssignText;
    var chkFlag = true;

    if (val != null && val != ""){
        for (var n_i = 0; n_i < val.length; n_i++){
            var tChar = val.charAt(n_i);
            chkFlag = false;

            for (j = 0; j < tValue.length; j++){
                var compChar = tValue.charAt(j);

                if (tChar.toLowerCase() == compChar.toLowerCase()){
                    chkFlag = true;
                }
            }
            
            if (chkFlag) continue;
            else return tChar;
        }
    }
    
    return chkFlag;
}

function autoMaskEdit(pObj, patternText)
{
    if (event.keyCode != 8)
    {
        var sourceValue = pObj.value;
        var mixedValue = '';

        for (var i = 0; i < patternText.length; i++)
        {
            if (patternText.charAt(i) != '#')
            {
                sourceValue = sourceValue.replace(patternText.charAt(i), '');
            }
        }

        var cutIDX = 0;
        var skipIDX = 0;
        for (var i = 0; i < patternText.length; i++)
        {
            if (patternText.charAt(i) == '#')
            {
                if (sourceValue.length > cutIDX)
                {
                    mixedValue = mixedValue + sourceValue.charAt(cutIDX);
                    cutIDX++;
                }
            }
            else
            {
                if (sourceValue.length > cutIDX)
                    mixedValue = mixedValue + patternText.charAt(i);
            }
        }

        if (mixedValue != '')
            pObj.value = mixedValue;
        else
            pObj.value = pObj.value;
    }
}


/*
    특정 문자 삭제
*/
function removeChar(prc, val)
{
    var retval = "";
    var i;

    for(i=0; i < prc.length; i++)
    {
        str = prc.substring(i, i+1);

        if( (str != val) && (str != " ") )
            retval = retval + str;
    }

    return retval;
}

/**
* setTitleText()
* 작 성 자  : 한국후지쯔 
* 작 성 일  : 2006-10-20
* 개     요  : Html Header  Setting
* 사용방법: setTitleText(String)
* return값 : 
*/
function setTitleText(titleText){
	var f=document.all;
	if (titleText == '' ) titleText = parent.titleText.value;
	
	f.titleText.innerText =titleText;
}

/**
* validatePwd()
* 작 성 자  : 한국후지쯔 
* 작 성 일  : 2007-03-28
* 개     요  : 패스워드 Check 
* 사용방법: validatePwd(obj)
* return값 : 
*/
function validatePwd(obj) {
	
	var ch = 0;
	var sh = 0;
	var strBefore = "";
	var char_num   = "";
	var strFore = "";
    var minLength = 8; // 최소 길이
    var invalid = " "; // 공백은 불허
	
	
    // 최소 글자수 체크
    if (obj.value.length < minLength) {
       showMessage(STOPSIGN, OK, "US-1000", "최소 8자리 이상입니다.");
       return false;
    }
    
    if (obj.value.indexOf(invalid) > -1) {
        showMessage(STOPSIGN, OK, "US-1000", "공백은 허용하지 않습니다.");
        return false;
    }   
    
    /*
    if(isAlphabet(obj)) {
        showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 문자와 숫자를 혼용하여 사용하세요");
        return false;
    }
    */
	// 1234 오름 차순  Check 
    for(i=0;i<obj.value.length;i++){
       
       char_num=obj.value.charAt(i).charCodeAt(0);
       /*
       if (parseInt(char_num)>=97 && parseInt(char_num)<=122){            
            if((parseInt(strBefore+1))==parseInt(char_num)){
               ch=ch+1;
               if (ch>=3){
                   showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                   return false;
               }
            }else {
                ch=0;     
            }
            strBefore=char_num;
        }

        if (parseInt(char_num)>=65 && parseInt(char_num)<=90){              
            if((parseInt(strBefore+1))==parseInt(char_num)){
                ch=ch+1;
                if (ch>=3){
                    showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                    return false;
                }
            }else{
                ch=0;
            }
            strBefore=char_num;
        }

        if(parseInt(char_num)>=48 && parseInt(char_num)<=57){
                       
            if((parseInt(strBefore+1))==parseInt(char_num)){
                ch=ch+1;
                if (ch>=3){
                    showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                    return false;
                }
            }else{
                ch=0;
            }
            strBefore=char_num;
         }

        if((parseInt(strFore))==parseInt(char_num)){
            sh=sh+1;
            if (sh>=3){
                showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                return false;
            }
        }else{
            sh=0;
        }
        */
        strFore=char_num;    
        
        
        //특수 문자 Chk 
        if (char_num == 33 || // ! 33 
            char_num == 64 || // @ 64 
            char_num == 35 || // # 35 
            char_num == 36 || // $ 36 
            char_num == 37 || // % 37 
            char_num == 94 || // ^ 94 
            char_num == 38 || // & 38 
            char_num == 42 || // * 42 
            char_num == 40 || // ( 40 
            char_num == 41 || // ) 41 
            char_num == 95 || // _ 95 
            char_num == 43 || // + 43 
            char_num == 92 || // \ 92 
            char_num == 124 || // | 124 
            char_num == 34 || // " 34 
            char_num == 39 ) { 
            showMessage(STOPSIGN, OK, "US-1000", "특수문자는 허용하지 않습니다  "); 
            return false;    
        }                 
    }
    
    // 내림차순 Check 변수 초기화 
    ch=0;
    strBefore = "";
    for(i=0;i<obj.value.length;i++){
       
       char_num=obj.value.charAt(i).charCodeAt(0);
       /*
       if (parseInt(char_num)>=97 && parseInt(char_num)<=122){            
            if((parseInt(strBefore-1))==parseInt(char_num)){
               ch=ch+1;
               if (ch>=3){
                   showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                   return false;
               }
            }else {
                ch=0;     
            }
            strBefore=char_num;
        }

        if (parseInt(char_num)>=65 && parseInt(char_num)<=90){              
            if((parseInt(strBefore-1))==parseInt(char_num)){
                ch=ch+1;
                if (ch>=3){
                    showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                    return false;
                }
            }else{
                ch=0;
            }
            strBefore=char_num;
        }

        if(parseInt(char_num)>=48 && parseInt(char_num)<=57){
                       
            if((parseInt(strBefore-1))==parseInt(char_num)){
                ch=ch+1;
                if (ch>=3){
                    showMessage(STOPSIGN, OK, "US-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
                    return false;
                }
            }else{
                ch=0;
            }
            strBefore=char_num;
         }    
         */       
    }
    return true;
}

/**
* isSaupNO()
* 작 성 자  : 김종환
* 작 성 일  : 2007-12-13
* 개     요  : 사업자 번호가 정확한지 확인한다.
* 사용방법: isSaupNO(iSaupNo)
* return값 : Boolean true이면 검증된 사업자번호
*/
function isSaupNO(iSaupNo) {
    var strSaupNo = iSaupNo.toString();
    
    if (strSaupNo.length != 10) {
        showMessage(STOPSIGN, OK, "GA-1000", "사업자번호는 10 자리입니다.");

        return false;
    }
    
    var arr_saup = strSaupNo.split("");
    var wtArray = new Array(1,3,7,1,3,7,1,3,5);
    var iSaup_9 = 0;
    var iSum_saup = 0;
    var iCheck_digit = 0;
    
    //1~8자리까지 가중치를 곱하여 모두 더한다.
    for (i = 0; i < 8; i++) {
      iSum_saup +=  eval(arr_saup[i]) * eval(wtArray[i]);
    }
    
    iSum_saup = iSum_saup % 10;
    //9번째 자리 숫자에 5를 곱한다.
    iSaup_9 = eval(arr_saup[8]) * 5
    
    //5를 곱한 값을 10으로 나누어  몫과 나머지를 각각 1~8합계에 더한다.
    iSum_saup +=  Math.floor(iSaup_9 / 10) + iSaup_9 % 10;
    
    //결과 값을 10에서 뺀다.
    iCheck_digit = 10 - (iSum_saup % 10);
    
    //계산 값을 10으로 나눈 나머지를 구한다. (Check Digit)
    iCheck_digit = iCheck_digit % 10;
    
    if (iCheck_digit != arr_saup[9]) {
        //alert("사업자 번호가 정확하지 않습니다.\n 다시 확인하신후 입력하십시오.");
        showMessage(STOPSIGN, OK, "GA-1000", "사업자번호가 정확하지 않습니다.<br>다시 확인하신 후 입력 하십시오.");
        return false;
    }
    
    return true;
}

/**
* showChgImg()
* 작 성 자  : 권기완
* 작 성 일  : 2007-01-08
* 개     요  : 이미지 display on/off
* 사용방법: showChgImg(imgId,showGb)
* return값 : void
*/
function showChgImg(imgId,showGb) {
	
	var obj = eval("document.all." + imgId);

	if(showGb)
	{
		obj.style.display = '';
	}else{
		obj.style.display = 'none';
	}
}

/*
* syncFromToDt()
* 작 성 자 : 정준형
* 작 성 일 : 2008-02-01
* 개    요 : 시작일자(From Data) 를 변경하였을때, 종료일자(To Date)가 더 작을경우 시작일자와 동일하게 설정한다.
* 사용방법 : syncFromToDt(emFromDt, emToDt)
*          arguments[0] -> 시작일자(From Data) EMEdit Object 
*          arguments[1] -> 종료일자(To Date) EMEdit Object
*          arguments[2] -> 기준일자(target) String ("f", "t")
*/

function syncFromToDt(emFromDt, emToDt, mod_Em) {
    var fromDt = emFromDt.Text;
    var toDt = emToDt.Text;
    if (mod_Em == "f") { //시작일변경
	    if (toDt == "") {
	    	emToDt.Text = fromDt;
	    } else {
	        if (fromDt > toDt) {
	            if (fromDt.length < toDt.length) {
	                emToDt.Text = fromDt + toDt.substring(fromDt.length-1);
	            } else {
	                emToDt.Text = fromDt;
	            }
	        }
	    }
    } else {			 //종료일변경
	    if (fromDt == "") {
	    	emFromDt.Text = toDt;
	    } else {
	        if (fromDt > toDt) {
	            if (fromDt.length < toDt.length) {
	            	emFromDt.Text = toDt + fromDt.substring(toDt.length-1);
	            } else {
	            	emFromDt.Text = toDt;
	            }
	        }
	    }
    }
}

function setObjEnable(strBtnId, bolEnableYn){
    if (bolEnableYn) {
        //버튼, 이미지 등 활성화
        document.getElementById(strBtnId).disabled = false;
        document.getElementById(strBtnId).style.cursor = "hand";
    } else {
        //버튼, 이미지 등 비활성화
        document.getElementById(strBtnId).disabled = true;
        document.getElementById(strBtnId).style.cursor = "default";
    }
}
  
  
  
/*
* syncFromToDt()
* 작 성 자 : 엄준석
* 작 성 일 : 2010-10-01
* 개    요 : 날짜 포멧터
* 사용방법 : date.toFormatString(format)
*          arguments[0] -> 날짜 포멧
*/
Date.prototype.toFormatString = function(f)
{
    if (!this.valueOf())
        return ' ';

    var dt = this;
	var gsDayNames = new Array(
	'일',
	'월',
	'화',
	'수',
	'목',
	'금',
	'토'
	);

    return f.replace(/(yyyy|yy|mm|ww|dd|hh12|hh24|mi|ss|a\/p)/gi,
        function($1)
        {
            switch ($1.toLowerCase())
            {
                case 'yyyy': return dt.getFullYear();
                case 'yy':   return dt.getFullYear().toString().substr(2);
                case 'mm':   return lpad((dt.getMonth() + 1)+"", 2, "0");
                case 'ww':   return gsDayNames[dt.getDay()];
                case 'dd':   return lpad(dt.getDate()+"", 2, "0");
                case 'hh12': return (h = dt.getHours() % 12) ? h : 12;
                case 'hh24': return dt.getHours();
                case 'mi':   return lpad(dt.getMinutes()+"", 2, "0");
                case 'ss':   return lpad(dt.getSeconds()+"", 2, "0");
                case 'a/p':  return dt.getHours() < 12 ? 'AM' : 'PM';
            }
        }
    );
}




///////////////////////////////////////////////////////////////////////////////
// Common.js
///////////////////////////////////////////////////////////////////END/////////


function MM_preloadImages() { //v3.0
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
	var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
	var p,i,x;  
	if(!d) d=document; 
	if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
	var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}





/**
 * 시스템명 : 자바스크립트 공통함수
 * 작 성 일 : 2010-10-29
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : 
 * 버    전 : 1.0
 * 인 코 딩 : UTF-8
 * 개    요 : 자바스크립트 공통 함수(cou.js에서 이관)
 * 이    력 : 
 */


/**
공통함수 목록
☞-------------------Data GET ---------------------------------
getVComGBData()         : GET V_COMGB Data
☞-------------------POPUP CALL ---------------------------------



☞-------------------GET NAME  ---------------------------------



☞-------------------GET LUXECOMBO ---------------------------------



☞-------------------FUNCTION  ---------------------------------
getDiffDay()            : 입력된 날짜 차이 일수 구하기
setEMEditDataType()     : EMEdit format 지정

*/

/**
    상수 정의
*/
//공통코드상수 정의
var ACCT        = "10";     //계정분류코드
var TAXOFFICE   = "12";     //세무서코드
var BANK        = "13";     //은행코드
var BILL        = "17";     //증빙유형코드
var EXPSCR      = "28";     //경비대변계정

var ACCTNM        = "계정분류";     //계정분류코드
var TAXOFFICENM   = "세무서";     //세무서코드
var BANKNM        = "은행";     //은행코드

var PAYACCNO    = "10";     //지급계좌구분
var EXPSNO    = "15";     //지출결의서상태구분


//EMEDIT TYPE 정의
var DATE_SEPARATOR    = "-";
var TIME_SEPARATOR    = ":";
/* 추후 작업해야할 상수 코드

--------------ACCODE--------------------------
	


------------V_COMGB-----------------------


*/

/**
* getDiffDay
* 작 성 자 : 회계
* 작 성 일 : 2007-02-28
* 개    요 : 입력된 날짜 차이 일수 구하기
* return값 : 날짜
* 사 용 법 : 
*/
function getDiffDay(){
    var vFromDt = arguments[0];
    var vToDt   = arguments[1];

    var vSYear = vFromDt.substr(0, 4)
    var vSMonth= vFromDt.substr(4, 2)
    var vSDate = vFromDt.substr(6, 2)

    var vEYear = vToDt.substr(0, 4)
    var vEMonth= vToDt.substr(4, 2)
    var vEDate = vToDt.substr(6, 2)

    var vStart=new Date(vSYear,vSMonth,vSDate).getTime();
    var vEnd  =new Date(vEYear,vEMonth,vEDate).getTime();
    var retDay=Math.abs((vStart-vEnd)/(1000*60*60*24))+1;
    return retDay;
}

/**
* setEMEditDataType
* 작 성 자 : 회계
* 작 성 일 : 2007-01-03
* 개    요 : EMEdit Data Type 정의 (EMEdit는 default가 number)
* 사 용 법 :
*
*           sEditName    EMEdit object id
*           sDataType    DATA Type
*                        일시 : "DAT", "DTM", "TIM"
*                            "DAT"       = YYYY-MM-DD
*                            "DAT_1"     = YY-MM-DD
*                            "DAT_2"     = YYYY-MM
*                            "DAT_3"     = YY-MM
*                            "DAT_4"     = MM-DD
*                            "DAT_5"     = YYYY
*                            "DAT_6"     = MM
*                            "DAT_7"     = DD
*                            "DTM"       = YYYY-MM-DD HH:MM:SS
*                            "DTM_01"    = YYYY-MM-DD HH:MM
*                            "DTM_03"    = YYYY-MM-DD HH
*                            "DTM_10"    = YY-MM-DD HH:MM:SS
*                            "DTM_11"    = YY-MM-DD HH:MM
*                            "DTM_13"    = YY-MM-DD HH
*                            "TIM"       = HH:MM:SS
*                            "TIM_1"     = HH:MM
*                            "TIM_2"     = MM:SS
*                            "TIM_3"     = HH
*                            "TIM_4"     = MM
*                            "TIM_5"     = SS
*                        숫자 : "AMT", "DEC" ("NUM"은 일반 Tag를 사용)
*                        가변 : "USR" (사용자지정 포맷)
*           param    extend DATA Type (Format)
*                        문자,숫자 혼용 : "#"
*                        문자 : "A", "Z" ("Z"는 공백입력 가능)
*                        숫자 : "0", "9" ("9"는 공백입력 가능)
*                        Data Type이 "AMT","DEC"인 경우 소숫점 자릿수
*                        Data Type이 "USR"인 경우 사용자 포맷
*           param    extend DATA Type
*                        숫자 max length
* 예    제 :
*           setEMEditDataType("EM_DATE","DAT");   //년월일
*           setEMEditDataType("EM_DATE","DAT_2"); //년월
*           setEMEditDataType("EM_DATE","DAT_5"); //년
*           setEMEditDataType("EM_DATE","DTM");   //년월일시분초
*           setEMEditDataType("EM_DATE","TIM");   //시분초
*           setEMEditDataType("EM_AMT","AMT","2","13"); //숫자형식이며 소숫점자리 2자리를 포함하여 13자리 포맷
*           setEMEditDataType("EM_JUMIN","USR","000000-0000000",); //주민등록번호형식
*           setEMEditDataType("EM_TEMP","#####",); //문자,숫자혼용
*/
function setEMEditDataType (sEditName, sDataType) {
    switch (sDataType.substr(0,3)) {
    case "DAT":
        var sFormat = "";
        
        switch (sDataType) {
        case "DAT":
            sFormat = "YYYY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD";
            break;
        case "DAT_1":
            sFormat = "YY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD";
            break;
        case "DAT_2":
            sFormat = "YYYY" + DATE_SEPARATOR + "MM";
            break;
        case "DAT_3":
            sFormat = "YY" + DATE_SEPARATOR + "MM";
            break;
        case "DAT_4":
            sFormat = "MM" + DATE_SEPARATOR + "DD";
            break;
        case "DAT_5":
            sFormat = "YYYY";
            break;
        case "DAT_6":
            sFormat = "MM";
            break;
        case "DAT_7":
            sFormat = "DD";
            break;
        }
        
        setEMEditDataFormat(sEditName, sFormat);
        break;
    case "DTM":
        var sFormat = "";
        
        switch (sDataType) {
        case "DTM":
            sFormat    = "YYYY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD"
                    + " 00" + TIME_SEPARATOR + "00" + TIME_SEPARATOR + "00";
            break;
        case "DTM_01":
            sFormat    = "YYYY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD"
                    + " 00" + TIME_SEPARATOR + "00";
            break;
        case "DTM_03":
            sFormat    = "YYYY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD"
                    + " 00";
            break;
        case "DTM_10":
            sFormat    = "YY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD"
                    + " 00" + TIME_SEPARATOR + "00" + TIME_SEPARATOR + "00";
            break;
        case "DTM_11":
            sFormat    = "YY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD"
                    + " 00" + TIME_SEPARATOR + "00";
            break;
        case "DTM_13":
            sFormat    = "YY" + DATE_SEPARATOR + "MM" + DATE_SEPARATOR + "DD"
                    + " 00";
            break;
        }
        setEMEditDataFormat(sEditName, sFormat);
        break;
    case "TIM":
        var sFormat = "";
        
        switch (sDataType) {
        case "TIM":
            sFormat    = "00" + TIME_SEPARATOR + "00" + TIME_SEPARATOR + "00";
            break;
        case "TIM_1":
            sFormat    = "00" + TIME_SEPARATOR + "00";
            break;
        case "TIM_2":
            sFormat    = "00" + TIME_SEPARATOR + "00";
            break;
        case "TIM_3":
            sFormat    = "00";
            break;
        case "TIM_4":
            sFormat    = "00";
            break;
        case "TIM_5":
            sFormat    = "00";
            break;
        }
        setEMEditDataFormat(sEditName, sFormat);
        break;
    case "AMT": case "DEC":
        if (arguments[2] == null) sExtDataType = "0";
        else sExtDataType = arguments[2];
        setEMEditDataPoint(sEditName, sExtDataType);
        
        if (arguments[3] == null)
            setEMEditMaxLength(sEditName, 10);
        else
            setEMEditMaxLength(sEditName, arguments[3]);
        break;
    case "USR":
        if (arguments[2] != null) sExtDataType = arguments[2];
        
        setEMEditDataFormat(sEditName, sExtDataType);
        break;
    default:
        break;
    }
}

/**
* setEMEditDataPoint
* 작 성 자 : 회계
* 작 성 일 : 2007-01-03
* 개    요 : EMEdit Data 소수점 자리수 
*/
function setEMEditDataPoint (sEditName, DecPoint) {
    if (DecPoint.toString() == "") DecPoint = 0;
    eval(sEditName).MaxDecimalPlace= retConvertInt(DecPoint);
}

/**
* setEMEditDataFormat
* 작 성 자 : 회계
* 작 성 일 : 2007-01-03
* 개    요 : EMEdit Data Format 지정
*/
function setEMEditDataFormat (sEditName, sFormat) {
    eval(sEditName).Format = sFormat;
}

/**
* setEMEditMaxLength
* 작 성 자 : 회계
* 작 성 일 : 2007-01-03
* 개    요 : EMEdit Data 정수부분 MaxLength
*/
function setEMEditMaxLength (sEditName, MaxLength) {
    if (MaxLength.toString() == "") MaxLength = 0;
    eval(sEditName).MaxLength= retConvertInt(MaxLength);
}




 
/**
  * fn_fixMod(pParam)
  * 작 성 자 : 김규종
  * 작 성 일 : 2010-10-27
  * 개    요 : 자바스크립트 나눗셈 보정
  * return값 : void
*/ 
function fn_fixMod(pParam){
	var returnValue = 0;
	
	returnValue = Math.round(pParam*1000)/1000;

	return returnValue;
}

/**
  * zeros(count)
  * 작 성 자 : 김규종
  * 작 성 일 : 2010-10-27
  * 개    요 : "0" 채워주기
  * return값 : void
*/ 
function zeros(count){
	var t = "";
	if(count <= 0){
		return "";
	}else if(count == 1){
	  	return "0";
	}else if(count == 2){
	  	return "00";
	}else{
		var n = Math.floor(count);
		var n1 = Math.floor(n/2);
		var n2 = n - 2*n1;
		var s1 = zeros(n1);
		t = s1 + s1 + zeros(n2);
	}
	return t;
}

/**
  * truncProc(s, npos)
  * 작 성 자 : 김규종
  * 작 성 일 : 2010-10-27
  * 개    요 : 정해진 자리수에서 절삭
  * return값 : void
*/
function truncProc(s, npos){
	var t = "0.0";
	var str = "" + s;
	var len = str.length;
	var ndx = str.indexOf(".");
	
	if(ndx < 0){
		t = str + "." + zeros(npos);
	}else if(len - ndx > npos + 1){
	  	t = str.substring(0, ndx + npos + 1);
	}else if(len - ndx == npos + 1){
	  	t = str;
	}else{
	  	t = str + zeros(ndx - len + npos + 1);
	}

	return Number(t);
}

/**
  * sleep(time)
  * 작 성 자 : 이정식
  * 작 성 일 : 2010-11-19
  * 개    요 : 슬립 함수 1000=> 1초
  * return값 : void
*/
function sleep(gap){
    var then,now;
    then = new Date().getTime();
    now=then;
    while((now-then)<gap) now=new Date().getTime();
}


/**
  * truncProc(s, npos)
  * 작 성 자 : 김규종
  * 작 성 일 : 2010-11-23
  * 개    요 : 정해진 자리수에서 반올림
  * 파라미터 : val = 값, precision= 소숫점 자릿수
  * return값 : void
*/
function roundProc(val,precision){
  if(isNaN(val) || isNaN(precision)){
    return "error";
  }

  val = val * Math.pow(10,precision); 
  val = Math.round(val); 
  return val/Math.pow(10,precision); 
}

/**
  * truncProc(s, npos)
  * 작 성 자 : 김규종
  * 작 성 일 : 2010-11-23
  * 개    요 : 부동소숫점
  * return값 : void
*/
function toFixedProc(amt){
  if(isNaN(amt)){
    return "error";
  }
  
  return Number(amt.toFixed(6));
}


/**
  * multiSelResult( returnObj )
  * 작 성 자 : 정진영
  * 작 성 일 : 2011-11-23
  * 개    요 : 멀티조회의 리턴 값을 만든다. 
  * return값 : List
  *             Map
*/
function multiSelResult( returnObj ){
    var tmpArray = new Array();
	for( var i=0; i<returnObj.length ; i++ ){
		var tmpStrMap = returnObj[i].split("&");
		var tmpMap = new Map();
		for(var j=0; j < tmpStrMap.length; j++){
			var tmpStr = tmpStrMap[j].split("||");
			tmpMap.put(tmpStr[0],tmpStr[1]);
		}
		tmpArray[i] = tmpMap;
	}
	return tmpArray;
}

/**
  * checkIP(strIP)
 : void
*/
function checkIP(strIP) {
    var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
    return expUrl.test(strIP);
}

/**
  * getSearchCondition(array)
  * 작 성 자 : 엄준석
  * 작 성 일 : 2011-01-25
  * 개     요 : 엑셀 출력시 화면 조회조건을 출력양식에 맞게 작성해줌
  * 사용방법 : getSearchCondition(array)
  *          array[0] -> 조회조건타이틀1^값1^값2^값3^구분문자  (예) "등록기간^" + getDateFormat(EM_ST_DT) + "^" + getDateFormat(EM_ED_DT) + "^~"
  *          array[0] -> 조회조건타이틀2^값                                 (예) "브랜드^" + trim(SH_BRAND_NM.value)"
*/
function getSearchCondition(array) {

	var objs = null;
	var aLength = array.length;
	var className = ""
	
	var retStr = "";
	
	for (var i = 0; i < aLength; i++) {
	
		var arrCond = array[i].split("^");
		var retStrTitle = "";
		var retStrContents = "";
		var cLength = arrCond.length;
		var chkCnt = 0;
	
		for (var j = 0; j < cLength; j++) {
		
			if (j == 0) {
				retStrTitle += " ▩ " + arrCond[j].replace(":", "&#58");
				continue;
			}
			if (cLength > 2 && j < cLength - 1) {
				if (!isEmptyVal(arrCond[j])) { 
					retStrContents += (j > 1 && j < cLength - 1 && !isEmptyVal(arrCond[j - 1]) ? " " + arrCond[cLength - 1] + " " : "") + arrCond[j];
				} else {
					chkCnt++;
				}
			} else if (cLength < 3) {
			
				if (!isEmptyVal(arrCond[j])) { 
					retStrContents += arrCond[j];
				} else {
					chkCnt++;
				}
			}
		}
		
		if (cLength < 3 && chkCnt > 0) continue;
		if (cLength > 2 && chkCnt > cLength - 2) continue;
		
		retStr += (i > 1 && i < aLength - 1 ? "^" : "") + retStrTitle + (cLength > 1 ? " &#58 " : "") + retStrContents;
	}
	
	return retStr;
}

/**
 * enableControl(obj, objBoolean)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-02-08
 * 개    요 : Object사용/미사용컨트롤
 * 사용방법 : enableControl(FILE_SEARCH, FALSE)
 *          obj        -> 컨트롤명(ID)
 *          objBoolean -> 사용유무
*/
function enableControl(obj, objBoolean) {
	switch(obj.tagName.toUpperCase()) {
		case "INPUT" :
			if (objBoolean) {
			    obj.tabIndex = 0;
			    obj.Enable = false;
			} else {
			    obj.tabIndex = -1;
			    obj.Enable = true;
			}
			break;
	    case "TEXTAREA" :
			if (objBoolean) { // true
			    obj.tabIndex = 0;
			    obj.Enable = false;
			} else {    // false
			    obj.tabIndex = -1;
			    obj.Enable = true;
			}
			break;
	    case "OBJECT" :
	    	switch(obj.classid.toUpperCase()) {
		        case CLSID_LUXECOMBO :
					if (objBoolean) {
					    obj.tabIndex = 0;
					    obj.Enable   = true;
					    obj.DefaultString = "==선택하세요==";
					} else { 
					    obj.tabIndex = -1;
					    obj.Enable   = false;
					    obj.DefaultString = "";
					}
					break;
		        case CLSID_EMEDIT :
		            if (objBoolean) {
		                obj.tabIndex = 0;
		                obj.Enable   = true;
		            } else {
		                obj.tabIndex = -1;
		                obj.Enable   = false;
		            }
			        break;
		        case CLSID_GRID :
		        	if (objBoolean) {
		            obj.tabIndex = 0;
		            obj.Enable   = true;
		        	} else {
		            obj.tabIndex = -1;
		            obj.Enable   = false;
		        	}
		        	break;
		        default :
		        	break;
	    	}
	    	break;
	    case "IMG" :
			if (objBoolean) {
			    obj.style.filter = 'alpha(opacity=100)';
			    obj.disabled = false;
			} else {
			    obj.style.filter = 'alpha(opacity=40)';
			    obj.disabled = true;
			}
			break;
	    default :
	    	break;
	}
}

/**
 * enableControl2(obj, objBoolean)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-02-08
 * 개    요 : Object사용/미사용컨트롤
 * 사용방법 : enableControl(FILE_SEARCH, FALSE)
 *          obj        -> 컨트롤명(ID)
 *          objBoolean -> 사용유무
*/
function enableControl2(obj, objBoolean) {

    obj.Enable = objBoolean;
}

/**
 * enableImg(obj, objBoolean)
 * 작 성 자 : FKL
 * 작 성 일 : 2011-02-08
 * 개    요 : Object사용/미사용컨트롤
 * 사용방법 : enableControl(FILE_SEARCH, FALSE)
 *          obj        -> 컨트롤명(ID)
 *          objBoolean -> 사용유무
*/
function enableImg(obj, objBoolean) {

	if (objBoolean) {
	    obj.style.filter = 'alpha(opacity=100)';
	    obj.disabled = false;
	} else {
	    obj.style.filter = 'alpha(opacity=40)';
	    obj.disabled = true;
	}
}

/**
 * getRoundProc(roundFlag, amt)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-03-08
 * 개    요 : 반올림구분에 따라서 금액을 올림(3), 버림(2), 반올림(1)한다.
 * 사용방법 : getRoundProc("1", 120.2)
 *          roundFlag        -> 반올림구분
 *          amt              -> 금액
*/
function getRoundProc(roundFlag, amt) {
	var rtnAmt = 0;
	switch(roundFlag) {
		case "1" :
			rtnAmt = Math.round(amt);
			break;
	    case "2" :
	    	rtnAmt = Math.ceil(amt);
			break;
	    case "3" :
	    	rtnAmt = Math.floor(amt);
	    	break;
	    default :
	    	rtnAmt = amt;
	    	break;
	}
	return rtnAmt;
}

/**
 * getRoundDec(roundFlag, num, dec)
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-03-15
 * 개    요 : 반올림구분에 따라서 소숫점 이하를 올림(3), 버림(2), 반올림(1)한다.
 * 사용방법 : getRoundProc("1", 120.223, 2)
 *          roundFlag        -> 반올림구분
 *          num              -> 숫자
 *          dec              -> 반올림할 소숫점 위치, default - 0
*/
function getRoundDec(roundFlag, num, dec) {
	var rtnNum = 0;
	if( dec == undefined ) dec = 0;	
	
	var tmp = parseInt(rpad("1",Math.abs(dec)+1,"0")) ;	
	
	switch(roundFlag) {
		case "1" :		
			rtnNum = dec<0?(Math.round(num/tmp)*tmp):(Math.round(num*tmp)/tmp);
			break;
	    case "2" :
	    	var stringValue = String( (dec<0?(num/tmp):(num*tmp)) );
	    	stringValue = stringValue.split("\.")[0];
	    	rtnNum = dec<0?(Number(stringValue)*tmp):(Number(stringValue)/tmp);
			break;
	    case "3" :	    
	    	var stringValue = String( (dec<0?(num/(tmp/10)):(num*(tmp*10))) );
	    	stringValue = stringValue.split("\.")[0];
	    	tmpNum = dec<0?(Number(stringValue)*(tmp/10)):(Number(stringValue)/(tmp*10));
	    	rtnNum = dec<0?(Math.ceil(tmpNum/tmp)*tmp):(Math.ceil(tmpNum*tmp)/tmp);
	    	//alert("num="+num+" | tmpNum*tmp="+(tmpNum*tmp) + " | rtnNum="+rtnNum);
	    	break;
	    default :
	    	rtnNum = num;
	    	break;
	}
	return rtnNum;
}

/**
* getCloseCheck()
* 작 성 자 : 이재득
* 작 성 일 : 2011-03-08
* 개    요 :  마감체크
              V_STR_CD          --> 점
              V_CLOSE_DT        --> 마감체크일자
              V_CLOSE_TASK_FLAG --> 업무구분(PCOD/MGIF/...)
              V_CLOSE_UNIT_FLAG --> 단위업무(매출일마감/수불일마감)
              V_CLOSE_ACNT_FLAG --> 회계마감 구분(일반마감:'0' / 회계마감:'1')
              V_CLOSE_FLAG      --> 마감구분(시간마감:T / 일마감:D / 월마감:M)
* return값 : TRUE/FALSE
*            -- 선택월에 마감 자료 존재 함 ==> 마감 TRUE
*            -- 선택월에 마감 자료 존재안함 ==> 마감 FALSE 
*/
function getCloseCheck(strDatasetId, strStrCd , strCloseDt , strCloseTaskFlag 
		, strCloseUnitFlag , strCloseAcntFlag , strCloseFlag){	
    var parameters = "&strStrCd="+strStrCd
                   + "&strCloseDt="+strCloseDt
                   + "&strCloseTaskFlag="+strCloseTaskFlag
                   + "&strCloseUnitFlag="+strCloseUnitFlag
                   + "&strCloseAcntFlag="+strCloseAcntFlag
                   + "&strCloseFlag="+strCloseFlag;
    
    TR_MAIN.Action="/edi/ccom000.cc?goTo=getCloseCheck"+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDatasetId+")";
    TR_MAIN.Post();
    
    var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");			     
	}else
		return false;
		
}

/**
 * getBuyerYN(strDatasetId, strToday)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-02-16
 * 개    요 :  바이어,SM여부 조회
 * return값 :  Y/N
 */
 function getBuyerYN(strDatasetId, strToday){
    var goTo         = "getBuyerYN" ;    
    var action       = "O";     
    var parameters   =  "&strToday="+strToday; 
    TR_MAIN.Action   = "/edi/ccom000.cc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_RESULT="+strDatasetId+")";
    TR_MAIN.Post();
    
    var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");			     
	}else
		return false;
 }

  

  /**
   * isSkuCdCheckSum()
   * 작 성 자 : 정진영
   * 작 성 일 : 2011-03-10
   * 개    요 : 단품코드 CheckSum 값을 검증한다.
   * return값 : void
   */

  function isSkuCdCheckSum( skuCd){
  	 if( skuCd == null)
  		 return false;
  	 if( skuCd.length != 13 || !isNumberStr(skuCd))
  		 return false;
  	 var checkSum = getSkuCdCheckSum(skuCd.substring(0,12));
  	 return  checkSum == skuCd.substring(12);
   }
  
 

  /**
   * getSkuCdCheckSum()
   * 작 성 자 : 정진영
   * 작 성 일 : 2011-03-10
   * 개    요 : 단품코드 CheckSum 값 생성한다. ( 12자리 숫자로)
   * return값 : void
   */
  function getSkuCdCheckSum( skuCd){
      if( skuCd == null)
          return null;
      if( skuCd.length != 12 || !isNumberStr(skuCd))
          return null;
      
      
      var oddNumSum = 0;       // 홀수번째 숫자 합
      var evenNumSum = 0;      // 짝수번째의 숫자 합
      
      for( var i = 0 ; i < 12 ; i++){
      	if( (i+1)%2 == 1)
      		oddNumSum += parseInt(skuCd.charAt(i));
      	else 
      		evenNumSum += parseInt(skuCd.charAt(i));
      }
      // 짝수번째의 숫자 합 * 3
      var tmpEvenNum = evenNumSum*3;

      // (짝수번째의 숫자 합 * 3 ) + 홀수번째 숫자 합
      var tmpSum = oddNumSum + tmpEvenNum;
      
      // 결과에 10의 배수가 되도록 더해진 최소수치 (0이상의 양수)
      var returnVal = tmpSum%10 == 0 ? 0 : ( 10 - (tmpSum%10));
      
      return returnVal ;
  }
  
function onResize(){

    var obj   = window.document.getElementById("testdiv");
    if( obj != null){
        obj.style.height=(parseInt(window.document.body.clientHeight)-40 ) + "px";
    }
}

function replaceWon(val){
	if(isNaN(val)){
		alert("숫자만 입력하세요");
	}
	var ret = 0;
	var strb = val.toString();
	var len = strb.length;
	if(len<4){
		ret = "￦"+strb;
	}
	else {
		var count = len/3;
		var slice = new Array();
		for(var i = 0 ; i<count ; i++){
			if(i*3 >= len){
				break;
			}
			slice[i] = strb.slice((i+1)* -3, len-(i*3));
		}

		var revslice = slice.reverse();
		var joinn = revslice.join(',');
		ret = "￦"+joinn; 
    }
	return ret
}

/**
* checkDupKey
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : strKeys("||" delimiter)로 중복체크를 하여
*            중복된 값이 존재 할 경우 해당 row를 아니면 0을 return한다.
* 사 용 법 : if (checkDupKey(ds_master, "col#1||col#2||col#3")) alert("중복된 데이터가 존재합니다.");
*/

function dupCheck(strKeys) {
  var intRowCount = document.getElementsByName(strKeys).length;
  var intChk;
  for (var i=0, n=intRowCount; i<n; i++) {
    for (var j=i+1, m=intRowCount; j<m; j++) {
      intChk = 0;
     // alert(document.getElementsByName(strKeys)[i].value+":"+document.getElementsByName(strKeys)[j].value);
	  if ((document.getElementsByName(strKeys)[i].value == document.getElementsByName(strKeys)[j].value) 
			  && (document.getElementsByName(strKeys)[i].value != "" )) {
	    intChk++;
	  }
      if (intChk == 1) return (j);
    }
  }
  return 0;
}


/***
 * createPageing 사용법
	createPageing (TotalCount, currentPage, pageSize, pageGroupSize);
  	리스트를 조회하면 데이터가 존재할 경우 삽입시키면 됩니다.
	Ex : if( rowsNode.length > 0 ){
	createPageing(totalcount,currentpage, 10, 10);
				
	각 파라미터에 대하여 설명합니다.
    1. TotalCount = 검색된 레코드 총 수 ( 한 페이지에 보여지는 총 수가 아닙니다.)
	2. currentPage = 현재 페이지 번호
	3. pageSize = 페이지에 보여질 행수
	4. pageGroupSize = 페이지 그룹으로 묶을 수 1.2.3....10  이런 식의 하단 페이지를 말합니다. 기본 10으로 지정하세요
	
	주희사항 필!!!
	1. 호출할 함수명은 반드시 createPageing 명을 사용하세요
	2. 모든 파라미터는 반드시 4개 모두 넘겨야 합니다. (전부 필수값)
	3. 리스트를 조회하는 자바스크립트 함수명은 getSearch로 명명하세요
	4. 하단에 보여지는 게시판 페이징의 테이블은 아래 코딩에 따르세요
	<table style="text-align:center;">
		<tr style="vertical-align:bottom">
			<td id="pageing" style="width:100%; height:26px; vertical-align:center;">
			이곳에 페이징이 표시 됩니다.
			</td>
		</tr>
	</table>
 */
function createPageing(count,currentPage, pageSize, pageGroupSize) {
	var strTag = "";
	
	var pageGroupCount = parseInt(count/(pageSize*pageGroupSize) + (count % (pageSize*pageGroupSize)==0? 0: 1));
	var numPageGroup   = Math.ceil((currentPage/pageGroupSize));
	
	var pageCount = parseInt(count/pageSize) + (count % pageSize == 0 ? 0 : 1);
	
	var startPage = pageGroupSize * (numPageGroup - 1) + 1;
	var endPage   = startPage + pageGroupSize - 1;
	
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	
	if(numPageGroup > 1) {
		strTag = "<a href='javascript:getSearch("+(numPageGroup-2)*pageGroupSize+1+");'>[이전]</a>";
	}
	for(var i = startPage; i<=endPage; i++) {
		if(i == currentPage) {
			strTag += "[<b>" + i +"</b>]";
		} else {
			strTag += "<a href='javascript:getSearch("+i+");'>[<font color='#oooooo'>" + i +"</font>]</a>";
		}
	}
	
	if(numPageGroup < pageGroupCount) {
		strTag += "<a href='javascript:getSearch("+((numPageGroup*pageGroupSize)+1)+");'>[다음]</a>";
	}
	
	document.getElementById("pageing").innerHTML = strTag;
	
	document.getElementById("currentPageNum").value = currentPage;
}


window.attachEvent('onresize', onResize);


//XMLHttpRequest 객채생성(브라우져별)
function createXMLHttpRequest() {
	if (window.ActiveXObject) { // IE5.0, IE6.0인 경우
		return new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) { // IE7.0 이후 버젼, Firefox, Safari, Opera 의
										// 경우
		return new XMLHttpRequest();
	}
}