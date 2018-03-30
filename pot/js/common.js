/**
 * 시스템명 : 자바스크립트 공통함수
 * 작 성 일 : 200-10-04
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : common.js
 * 버    전 : 1.0
 * 인 코 딩 : UTF-8
 * 개    요 : 자바스크립트 표준 공통 함수
 * 이    력 :
 */


/**
공통함수 목록
☞-------------------FUNCTION ---------------------------------
*
*/
var strAuthorization = new Array();
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
통합인증 샘플사이트 공통 스크립트.
*/

function CreateObject(vObject)
{
document.write(vObject.innerHTML);
vObject.id = "";
}
/*
 * WindowsAttachEvent START
 */
function onResize(){

	var obj   = window.document.getElementById("testdiv");
	if( obj != null){
		if((parseInt(window.document.body.clientHeight)-40 ) <= 0) {
			obj.style.height = "50px";
		} else {
		obj.style.height=(parseInt(window.document.body.clientHeight)-40 ) + "px";
		}
	}
}

window.attachEvent('onresize', onResize);

function onResize_div_grd1(){

	var obj   = window.document.getElementById("div_grd1");
	if( obj != null){
		if((parseInt(window.document.body.clientHeight)-40 ) <= 0) {
			obj.style.height = "50px";
		} else {
		obj.style.height=(parseInt(window.document.body.clientHeight)-40 ) + "px";
		}
	}
}

window.attachEvent('onresize', onResize_div_grd1);

function onResize_div_grd2(){

	var obj   = window.document.getElementById("div_grd2");
	if( obj != null){
		if((parseInt(window.document.body.clientHeight)-40 ) <= 0) {
			obj.style.height = "50px";
		} else {
		obj.style.height=(parseInt(window.document.body.clientHeight)-40 ) + "px";
		}
	}
}

window.attachEvent('onresize', onResize_div_grd2);


function onClick() {

	var oSource = window.event.srcElement ;
	if (oSource != null) {
		switch(window.event.srcElement.tagName.toUpperCase()) {
			case "INPUT" :
				if (window.event.srcElement.type.toUpperCase() == "TEXT"){
					window.event.srcElement.select();
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

function errorHandler(message, url, line){
	showMessage(STOPSIGN, OK, "SCRIPT-1001", arguments);
	return true;
}
window.onerror = errorHandler;

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
		if (document.activeElement.classid.toUpperCase()  == CLSID_GRID){
			if (document.activeElement.getAttribute("AUTOROW") == "true") {
				if (event.keyCode == 9){
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
			if (strTagName == "INPUT" || strTagName == "OBJECT") {
				// TEXTAREA OBJECT 일경우 ENTER시 탭이동 안함
				if(document.activeElement.classid != null) {
					if(window.event.keyCode == 13 && document.activeElement.classid.toUpperCase() == CLSID_TEXTAREA){
						return;
					}
				}

				if(obj.item(i).tabIndex >= 0 ){
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
	// Ctrl + O 제어 처리
	if (window.event.ctrlKey == true){
		try {
			if( window.event.keyCode == 78) {
				showMessage(STOPSIGN, OK, "USER-1000","새창열기(Ctrl + N) 사용불가");
				return false;
			}
			if( window.event.keyCode == 79) {
				showMessage(STOPSIGN, OK, "USER-1000","열기(Ctrl + O) 사용불가");
				return false;
			}
		} catch(e) {
		}
	}

	//새로고침 막기
	if(event.keyCode == 116) {
		try{
			var frame = window.external.GetFrame(window);
			var dsMdiInfo = frame.Provider('../').OuterWindow.parent.mainFrame.DS_MdiInfo; // MDI 정보 데이터셋
			var row = frame.Provider('../').OuterWindow.parent.mainFrame.fn_getActiveMdiPopup(); // Active 상태의 MDI 화면 데이터셋 번호
		} catch(e) {
			event.keyCode = 505;
		}
	}

	if (event.keyCode == 505) {
		return false;
	}

	// 단축키 추가
	if (window.event.ctrlKey == true){
		try {
			if (window.dialogArguments == undefined && typeof(window.external.GetFrame(window).Provider('../').OuterWindow.parent.mainFrame.DS_MdiInfo)=='object') {
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
						btn_Excel();
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

				case 112 : //F1도움말
					var frame = window.external.GetFrame(window);
					var dsMdiInfo = frame.Provider('../').OuterWindow.parent.mainFrame.DS_MdiInfo; // MDI 정보 데이터셋
					var row = frame.Provider('../').OuterWindow.parent.mainFrame.fn_getActiveMdiPopup(); // Active 상태의 MDI 화면 데이터셋 번호

					//초기화면제외
					if(row>1)
						helpPop(dsMdiInfo.NameValue(row,"PG_ID"));
					break;

				default :
					return true;
					break;
				}
				return false;
			}
		} catch(e) {
			//showMessage(STOPSIGN, OK, "GAUCE-1000","단축키를 지원하지 않거나,\n오류가 발생하였습니다.");
		}
	}
}


document.attachEvent("onkeydown", keyDown);

function onSelectStart() {
//  return (window.event.srcElement.tabIndex == -1 || window.event.srcElement.readOnly == true) ? false : true;
  return (window.event.srcElement.tabIndex == -1 ) ? false : true;
}
document.attachEvent('onselectstart', onSelectStart);

function onBeforeActivate() {
//return (window.event.srcElement.tabIndex == -1 || window.event.srcElement.readOnly == true) ? false : true;
  return (window.event.srcElement.tabIndex == -1 ) ? false : true;
}
document.attachEvent('onbeforeactivate', onBeforeActivate);


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
						window.event.srcElement.style.cursor = (Version == '6') ? "not-allowed" : "wait";
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

/*
 * WindowsAttachEvent END
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
* registerUsingDataset(strPId)
* 작성자   : 정지인
* 작성일자 : 2010.12.31
* 개요     : MDI 적용 후 화면 전환 시 변경된 데이터셋을 파악하여, 저장하기
* return   : Void
*/
//사용되는 데이터셋 등록
//argument[0] : Program ID
//argument[1] : 변경여부 확인 대상 데이터셋 ','로 구분
//registerUsingDataset("tcom101","DS_IO_DETAIL,DS_O_DETAIL")

//
function registerUsingDataset(strPId,dataSetStr){

	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.fn_registerUsingDataset(strPId,dataSetStr);
	} catch(e){
	}
}

/**
* getProgramName(strPId) /getButtonPermission(strPId)
* 작성자   : 정지인
* 작성일자 : 2010.12.31
* 개요     : 프로그램 ID로 프로그램명/ 프로그램 권한 전달
* return   : Void
*/
function getProgramName(strPId){
	try{
		frame = window.external.GetFrame(window);
		return frame.Provider('../').OuterWindow.fn_getProgramName(strPId);
	} catch(e){
	}
}

function getButtonPermission(strPId){
	try{
		frame = window.external.GetFrame(window);
		return frame.Provider('../').OuterWindow.fn_getButtonPermission(strPId);
	} catch(e){
	}
}



/**
* setFrameDBTodayMDI()
* 작성자   : 정진영
* 작성일자 : 2010.06.03
* 개요     : frame.jsp 에 정의 되어 있는 Ajax DB 일자 가져오기 실행(MDI 경우)
* return   : Void

function setFrameDBTodayMDI(){
	try{
		var frame01 = window.external.GetFrame(window);
		frame01.Provider('../../').OuterWindow.top.duplChkFrame.fn_getDBToday();
	} catch(e){
	}
}
*/
/**
* getFrameDBTodayYYYYMMDD()
* 작성자   : 정진영
* 작성일자 : 2010.06.03
* 개요     : frame.jsp 에 정의 되어 있는 YYYYMMDD 일자 가져오기
* return   : Void
*/
function getFrameDBTodayYYYYMMDD(){
	var tmp = "";
	try{
		var frame01 = window.external.GetFrame(window);
		tmp = frame01.Provider('../../').OuterWindow.top.topFrame.fn_getYYYYMMDD();
	} catch(e){
	}
	return tmp;
}


var serverInfoId = "_GET_SERVER_INFORMATION_";


/**
* createServerDateIframe()
* 작성자   : 정진영
* 작성일자 : 2010.06.03
* 개요     : frame.jsp 에 정의 되어 있는 YYYYMMDD 일자 가져오기
* return   : Void

function createServerDateIframe(){
	if(document.getElementById("HD_INP_YYYYMMDD") == null){
		var inpYyyymmdd = document.createElement("input");
		inpYyyymmdd.type = "hidden";
		inpYyyymmdd.id = "HD_INP_YYYYMMDD";
		document.getElementsByTagName("body")[0].appendChild(inpYyyymmdd);
	}
	var iFrame = null;

	if (window.addEventListener)	{
		// All broswers except IE
		iFrame = document.createElement("iframe");
	} else	{
		// Only for IE
		iFrame = document.createElement('<iframe name="' + serverInfoId + '">');
	}

	iFrame.id = serverInfoId;
	iFrame.src = "/pot/jsp/serverInfo.jsp";
	iFrame.style.display="none";

	var frameActive = function(evt)	{
		var isReady = false;

		if (window.addEventListener)	{
			// All broswers except IE
			isReady = true;
		} else	{
			// Only for IE
			if (this.readyState == "complete")	isReady = true;
		}

		if (isReady)	{
			var tmpToDay = this.contentWindow.getToday();
			document.getElementById("HD_INP_YYYYMMDD").value = tmpToDay;
		}
	};

	if(window.addEventListener)	{
		// All broswers except IE
		iFrame.addEventListener('load', frameActive, false);
	} else	{
		// Only for IE
		iFrame.onreadystatechange = frameActive;
	}
	var iframeList = document.body.getElementsByTagName("iframe");
	var hasiFrame = false;
	for(var i=0 ;i< iframeList.length; i++){
		if(iframeList[i].id == serverInfoId){
			hasiFrame = true;
			break;
		}
	}
	if(hasiFrame == true) {
		if(window.addEventListener)	{
			// All broswers except IE
			// FireFox has a problem with a reload algorithm
			document.getElementById(serverInfoId).src = "/pot/jsp/serverInfo.jsp";
		} else	{
			// Only for IE
			window.frames[serverInfoId].location.reload();
		}
	}
	else {
		document.getElementsByTagName("body")[0].appendChild(iFrame);
	}
}
*/
/**
* getDBTodayYYYYMMDD()
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 자바스크립트 정지.
* return : true/false
*/
function getDBTodayYYYYMMDD(){
	var tmpDate = "";
	if(document.getElementById("HD_INP_YYYYMMDD") != null){
		tmpDate = document.getElementById("HD_INP_YYYYMMDD").value;
	}
	return tmpDate;
}

/**
* wait( 1/1000 초)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 자바스크립트 정지.
* return : true/false
*/
function wait(msecs){
	var start = new Date().getTime();
	var cur = start;
	while(cur-start<msecs){
		cur= new Date().getTime();
	}
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
* containsCharsOnlyValue(obj, strChars, showMsgFlag, showMsg)
* 작성자     : 김선욱
* 작성일자 : 2010-06-08
* 개요        : Emedit 특수문자 Search 없음 true 있음 false
* return : true/false
*/
function containsCharsOnlyValueEmedit(obj, strChars, showMsgFlag, showMsg) {
  var strValue = obj.Text;
  for (var i=0; i < strValue.length; i++) {
	if (strChars.indexOf(strValue.charAt(i)) != -1) {
	  if(showMsgFlag == "Y"){
		showMessage(STOPSIGN, OK, "GAUCE-1000", showMsg);
	  }
	  obj.Text = "";
	  obj.Focus();
	  return false;
	}
  }
  return true;
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
function isValidStrIpAddr(str){
	var format = /^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$/;
	if(!isValidStrFormat(str,format) )
		return false;
	var tmpStr = str.split("\.");
	for(var i=0; i<4; i++ ){
		if( tmpStr[i] > 255)
			return false;
	}
	return true;
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
* isNumberStr(obj)
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

function onlyNumber() {
  if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;
}

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
		/* 2012.05.08 보너스회원가입신청서등록 화면에서 형지 아트몰링 전용  가외국인번호 생성으로 인하여 skip 강진
		odd = buf[7]*10 + buf[8];

		if (odd%2 != 0) {
		return false;
		}

		if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
		return false;
		}
		*/
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
* firstTelFormat()
* 작 성 자 : fkl
* 작 성 일 : 2006-09-06
* 개    요 :  전화번호 앞자리체크
* 사용방법 : firstTelFormat(obj,type), type - T:일반전화,H:휴대폰
* return값 : bool
*/

function firstTelFormat(obj,type) {
	var strTel = "";
	if (typeof(obj) == "object" ) {
		strTel = obj.Text;
	} else {
		strTel = obj;
	}

	if(type=="T"){
		var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
						   '051', '052', '053', '054', '055', '061', '062',
						   '063', '064', '070');
		for(var i=0, n=strDDD.length; i<n; i++) {
			if (strTel == strDDD[i]) {
				return true;
			}
		}
		return false;
	}else {
		var strDDD = new Array('010', '011', '012', '013', '015',
						   '016', '017', '018', '019');

		for(var i=0, n=strDDD.length; i<n; i++) {
			if (strTel == strDDD[i]) {
				return true;
			}
		}
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
	var strTel = "";
	if (typeof(obj) == "object" ) {
		strTel = obj.Text;
	} else {
		strTel = obj;
	}

	var t = 0;
	var strDDD = new Array('02' , '031', '032', '033', '041', '042', '043',
						   '051', '052', '053', '054', '055', '061', '062',
						   '063', '064', '010', '011', '012', '013', '015',
						   '016', '017', '018', '019', '070');

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

	strButton = '<table border="0" cellspacing="0" cellpadding="0">' +
				'	<tr>' +
				'		<td id="_btnSearch"   ><img src="/pot/imgs/btn/search_off.gif" border="0" id="btnSearch" disabled=true></td>' +
				'		<td id="_btnNew"      ><img src="/pot/imgs/btn/new_off.gif" border="0" id="btnNew" disabled=true></td>' +
				'		<td id="_btnDelete"   ><img src="/pot/imgs/btn/del_off.gif" border="0" id="btnDelete" disabled=true></td>' +
				'		<td id="_btnSave"     ><img src="/pot/imgs/btn/save_off.gif" border="0" id="btnSave" disabled=true></td>' +
				'		<td id="_btnExcel"    ><img src="/pot/imgs/btn/excel_off.gif" border="0" id="btnExcel" disabled=true></td>' +
				'		<td id="_btnPrint"    ><img src="/pot/imgs/btn/print_off.gif" border="0" id="btnPrint" disabled=true></td>' +
				'		<td id="_btnDecision" ><img src="/pot/imgs/btn/set_off.gif" border="0" id="btnDecision" disabled=true></td>' +
				'	</tr>' +
				'</table>';
	
	document.writeln(strButton);
}

function replaceButton(intBtnSequence, blnShow) {
  switch(intBtnSequence) {
	case 0 :
	  if (blnShow) {
		_btnCancel.innerHTML = '<img src="/pot/imgs/btn/cancel.gif" border="0" id="btnCancel" onClick="undo();" alt="여러개 선택한 항목에 대하여 취소 처리합니다." style="cursor:hand;"></a>';

	  } else {
		_btnCancel.innerHTML = '<img src="/pot/imgs/btn/cancel_off.gif" border="0" id="btnCancel" disabled=true>';
	  }
	  break;
	case 1 :
	  if (blnShow) {
		_btnSearch.innerHTML = '<img src="/pot/imgs/btn/search.gif" border="0" id="btnSearch" onClick="btn_Search2();" alt="조회 기능을 수행합니다. (단축키 : ctrl + 1)" style="cursor:hand;"></a>';
		_btnSearch.setAttribute("Auth", "true");
	  } else {
		_btnSearch.innerHTML = '<img src="/pot/imgs/btn/search_off.gif" border="0" id="btnSearch" disabled=true>';
		_btnSearch.setAttribute("Auth", "false");
	  }
	  break;
	case 2 :
	  if (blnShow) {
		_btnNew.innerHTML = '<img src="/pot/imgs/btn/new.gif" border="0" id="btnNew" onClick="btn_New2();" alt="화면 초기화 및 신규 입력 기능을 수행합니다. \n(단축키 : ctrl + 2)" style="cursor:hand;"></a>';
		_btnNew.setAttribute("Auth", "true");
	  } else {
		_btnNew.innerHTML = '<img src="/pot/imgs/btn/new_d.gif" border="0" id="btnNew" disabled=true>';
		_btnNew.setAttribute("Auth", "false");
	  }
	  break;
	case 3 :
	  if (blnShow) {
		_btnDelete.innerHTML = '<img src="/pot/imgs/btn/del.gif" border="0" id="btnDelete" onClick="btn_Delete2();" alt="자료 삭제 처리 및 삭제 체크를 합니다. \n(단축키 : ctrl + 3)" style="cursor:hand;"></a>';
		_btnDelete.setAttribute("Auth", "true");
	  } else {
		_btnDelete.innerHTML = '<img src="/pot/imgs/btn/del_d.gif" border="0" id="btnDelete" disabled=true>';
		_btnDelete.setAttribute("Auth", "false");
	  }
	  break;
	case 4 :
	  if (blnShow) {
		_btnSave.innerHTML = '<img src="/pot/imgs/btn/save.gif" border="0" id="btnSave" onClick="btn_Save2();" alt="자료를 저장 처리합니다. \n(단축키 : ctrl + 4)" style="cursor:hand;"></a>';
		_btnSave.setAttribute("Auth", "true");
	  } else {
		_btnSave.innerHTML = '<img src="/pot/imgs/btn/save_d.gif" border="0" id="btnSave" disabled=true>';
		_btnSave.setAttribute("Auth", "false");
	  }
	  break;
	case 5 :
	  if (blnShow) {
		_btnExcel.innerHTML = '<img src="/pot/imgs/btn/excel.gif" border="0" id="btnExcel" onClick="btn_Excel2();" alt="조회된 내용을 엑셀/텍스트 파일로 변환합니다. \n(단축키 : ctrl + 5)" style="cursor:hand;"></a>';
		_btnExcel.setAttribute("Auth", "true");
	  } else {
		_btnExcel.innerHTML = '<img src="/pot/imgs/btn/excel_d.gif" border="0" id="btnExcel" disabled=true>';
		_btnExcel.setAttribute("Auth", "false");
	  }
	  break;
	case 6 :
	  if (blnShow) {
		_btnPrint.innerHTML = '<img src="/pot/imgs/btn/print.gif" border="0" id="btnPrint" onClick="btn_Print2();" alt="레포트를 출력합니다. \n(단축키 : ctrl + 6)" style="cursor:hand;"></a>';
		_btnPrint.setAttribute("Auth", "true");
	  } else {
		_btnPrint.innerHTML = '<img src="/pot/imgs/btn/print_d.gif" border="0" id="btnPrint" disabled=true>' ;
		_btnPrint.setAttribute("Auth", "false");
	  }
	  break;
	case 7 :
	  if (blnShow) {
		_btnDecision.innerHTML = '<img src="/pot/imgs/btn/set.gif" border="0" id="btnDecision" onClick="btn_Conf2();" alt="자료에 대하여 확정 처리합니다. \n(단축키 : ctrl + 7)" style="cursor:hand;"></a>';
		_btnDecision.setAttribute("Auth", "true");
	  } else {
		_btnDecision.innerHTML = '<img src="/pot/imgs/btn/set_d.gif" border="0" id="btnDecision" disabled=true>';
		_btnDecision.setAttribute("Auth", "false");
	  }
	  break;
	default :
		break;
  }
}

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
  }else{
	  //createServerDateIframe();
  }
}

document.attachEvent('onreadystatechange', onReadyStateChange);

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
  return dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' + dt.getDate();
}

function getTodayFormat(format) {

  var dbToday = "";
  if( mainWindow ){
	  dbToday = getFrameDBTodayYYYYMMDD();
  }else{
	  dbToday = getDBTodayYYYYMMDD();
  }
  var dt;

  if( dbToday == ""){
	  dt = new Date();
  }else{
	  dt = new Date(dbToday.substring(0,4),(Number(dbToday.substring(4,6))-1),dbToday.substring(6),0,0,0);
  }

  return dt.toFormatString(format);
}

/**
 * postwith()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 : Iframe에 POST 방식으로 호출한다.
 * return값 : void
 */
function postwith(taget,to,p) {
	var myForm = document.createElement("form");
	myForm.method="post" ;
	myForm.action = to ;
	myForm.target = taget;
	for (var k in p) {
		var myInput = document.createElement("input");
		myInput.setAttribute("name", k) ;
		myInput.setAttribute("value", p[k]);
		myForm.appendChild(myInput);
	}
	document.body.appendChild(myForm) ;
	myForm.submit() ;
	document.body.removeChild(myForm) ;
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
				showMessage(EXCLAMATION, OK, "GAUCE-1000", maxByteLangth + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
			return str.substring(0,i);
		}
	}
	return null
}

/**
* checkByteStr(obj, maxByteLangth, showMsgFlag, row, colId)
* 작성자   : 김성미
* 작성일자 : 2010-03-29
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
  if (intYear == 0 || intMonth == 0 || intDay == 0) return false;
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

/**
* addDate(strFlg,intDiff,strCheckDate)
* 개    요 : 년, 월, 일 에대한 i만큼의 전후 날짜 계산
* 인    수 : 1. strFlg  : 구분 ("y":년, "m":월, "d":일)
*            2. i       : (-i:before, +i:after) difference value
*            3. strCheckDate : 날짜
*            4. Delimitor : 구분자 기본값('-')
* return값 : string YYYY-MM-DD
*/
function addDate(strFlg, i, strCheckDate, Delimitor) {
	Delimitor = Delimitor==null?"-":Delimitor;
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
	return retDate.getFullYear() + Delimitor + numFormat(retDate.getMonth()+1,2) + Delimitor + numFormat(retDate.getDate(),2);

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
 * cardCheckDigit()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-08
 * 개       요 : 카드번호 마지막자리 생성 
 * return값 : cardno
 */
function cardCheckDigit(no) {
	/*
	if(trim(no).length != 0){		
		for(var i=0; i<8; i++){
			no = "0" + no;
		}		
		no = no.substring(no.length, no.length-8);
	}	

	var cardNo   =  "2000" + no;
	var sum      =  0;
	var chkDigit =  0;
	
	// 체크디짓 계산
	var digit01    =  Number(cardNo.substring(0,1));	
	var digit02    =  Number(cardNo.substring(1,2));
	var digit03    =  Number(cardNo.substring(2,3));
	var digit04    =  Number(cardNo.substring(3,4));
	var digit05    =  Number(cardNo.substring(4,5));
	var digit06    =  Number(cardNo.substring(5,6));
	var digit07    =  Number(cardNo.substring(6,7));
	var digit08    =  Number(cardNo.substring(7,8));
	var digit09    =  Number(cardNo.substring(8,9));
	var digit10    =  Number(cardNo.substring(9,10));
	var digit11    =  Number(cardNo.substring(10,11));
	var digit12    =  Number(cardNo.substring(11,12));
	
	var sum       =  digit01 * 1  +  digit02 * 3
	              +  digit03 * 1  +  digit04 * 3
	              +  digit05 * 1  +  digit06 * 3
	              +  digit07 * 1  +  digit08 * 3
	              +  digit09 * 1  +  digit10 * 3
	              +  digit11 * 1  +  digit12 * 3;
	
	if( (sum % 10) > 0 ) {
		chkDigit  =  10 - (sum % 10);
	}else{
		chkDigit  =  sum % 10;
	}
	
	return cardNo + chkDigit;
	*/
	var cardNo;
	if(trim(no).length != 0){		
		for(var i=0; i<9; i++){
			no = "0" + no;
		}		
		no = no.substring(no.length, no.length-9);
		cardNo = "2000" + no;
	}	

	return cardNo;
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
				case 'hh12': return lpad(((h = dt.getHours() % 12) ? h : 12)+"", 2, "0");
				case 'hh24': return lpad((dt.getHours())+"", 2, "0");
				case 'mi':   return lpad(dt.getMinutes()+"", 2, "0");
				case 'ss':   return lpad(dt.getSeconds()+"", 2, "0");
				case 'a/p':  return dt.getHours() < 12 ? 'AM' : 'PM';
			}
		}
	);
}

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
 * enableControl(obj, objBoolean)
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-08
 * 개    요 : Object사용/미사용컨트롤
 * 사용방법 : enableControl(FILE_SEARCH, FALSE)
 *          obj        -> 컨트롤명(ID)
 *          objBoolean -> 사용유무
*/
function enableControl(obj, objBoolean) {
	switch(obj.tagName.toUpperCase()) {
		case "INPUT" :
			if (objBoolean) {
				obj.tabIndex = 1;
				obj.Enable = false;
			} else {
				obj.tabIndex = -1;
				obj.Enable = true;
			}
			break;
		case "TEXTAREA" :
			if (objBoolean) { // true
				obj.tabIndex = 1;
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
						obj.tabIndex = 1;
						obj.Enable   = true;
						obj.DefaultString = "";
					} else {
						obj.tabIndex = -1;
						obj.Enable   = false;
						obj.DefaultString = "";
					}
					break;
				case CLSID_EMEDIT :
					if (objBoolean) {
						obj.tabIndex = 1;
						obj.Enable   = true;
					} else {
						obj.tabIndex = -1;
						obj.Enable   = false;
					}
					break;
				case CLSID_GRID :
					if (objBoolean) {
					obj.tabIndex = 1;
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
 * 사용방법 : enableControl2(FILE_SEARCH, FALSE)
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
 * 사용방법 : enableImg(FILE_SEARCH, FALSE)
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
 * replascXMLEscape(str)
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-07-28
 * 개    요 : XML에서 사용되는 특수문자를 XML 데이터로 변환 한다.
 * 사용방법 :
 *
 * @param str
 * @returns
 */
function replascXMLEscape(str){
	if(str == null)
		return str;
	var len = str.length;
	if(len<1)
		return str;
	var tmpStr = "";
	for (var i = 0; i < len; i++) {
		var oneChar = str.charAt(i);
		switch(oneChar){
			case '&':
				tmpStr += '&amp;';
				break;
			case '<':
				tmpStr += '&lt;';
				break;
			case '>':
				tmpStr += '&gt;';
				break;
			case "'":
				tmpStr += '&apos;';
				break;
			case '"':
				tmpStr += '&quot;';
				break;
			default :
				tmpStr +=oneChar;
				break;
		}
	}
	return tmpStr;
}

/**
 * getRoundDec(roundFlag, num, dec)
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-15
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
* 작 성 일 : 2010-03-08
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
	var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
				   + "&strCloseDt="+encodeURIComponent(strCloseDt)
				   + "&strCloseTaskFlag="+encodeURIComponent(strCloseTaskFlag)
				   + "&strCloseUnitFlag="+encodeURIComponent(strCloseUnitFlag)
				   + "&strCloseAcntFlag="+encodeURIComponent(strCloseAcntFlag)
				   + "&strCloseFlag="+encodeURIComponent(strCloseFlag);

	TR_MAIN.Action="/pot/ccom000.cc?goTo=getCloseCheck"+parameters;
	TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDatasetId+")";
	TR_MAIN.Post();

	var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");
	}else
		return false;

}


/**
* getCalCheck()
* 작 성 자 : fkl
* 작 성 일 : 2016-12-30
* 개    요 :  익월정산여부체크
			  V_STR_CD          --> 점
			  V_YYYYMM          --> 년월
			  V_GBN             --> 업무구분(1:당월정확인, 2:익월정산확인, 3:관리비당월입금 확인, 4:임대료당월입금 확인)
* return값 : TRUE/FALSE
*            -- 선택월에 정산 자료 존재 함 ==> 마감 TRUE
*            -- 선택월에 정산 자료 존재안함 ==> 마감 FALSE
*/
function getCalCheck(strDatasetId, strStrCd, strYM , strGbn){

    var goTo = "getCalCheck";
    
	var parameters = "&strStrCd=" +encodeURIComponent(strStrCd)
				   + "&strYM="    +encodeURIComponent(strYM)
				   + "&strGbn="   +encodeURIComponent(strGbn)
				;

	TR_MAIN.Action="/pot/ccom000.cc?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue="SERVLET(O:DS_O_CALCHECK="+strDatasetId+")";
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
 * 작 성 일 : 2010-02-16
 * 개    요 :  바이어,SM여부 조회
 * return값 :  Y/N
 */
 function getBuyerYN(strDatasetId, strStrCd, strPumbunCd, strOrdDt){
	var goTo         = "getBuyerYN" ;
	var action       = "O";
	var parameters   =  "&strStrCd="+encodeURIComponent(strStrCd)+
	                    "&strPumbunCd="+encodeURIComponent(strPumbunCd)+
	                    "&strOrdDt="+encodeURIComponent(strOrdDt);
	TR_MAIN.Action   = "/pot/ccom000.cc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_RESULT="+strDatasetId+")";
	TR_MAIN.Post();

	var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");
	}else
		return false;
 }

 /**
  * getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
  * 개    요 :  협력사에 따라 반올림구분을 가져온다.
  * return값 : void
  */
  function getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd){
	 if(strStrCd.length != 0 && strVenCd.length != 0){
		 var goTo       = "getVenRoundFlag" ;
		 var action     = "O";
		 var parameters =  "&strToday="+encodeURIComponent(strToday)
						 + "&strStrCd="+encodeURIComponent(strStrCd)
						 + "&strVenCd="+encodeURIComponent(strVenCd);
		 TR_MAIN.Action   = "/pot/ccom000.cc?goTo="+goTo+parameters;
		 TR_MAIN.KeyValue = "SERVLET(O:DS_O_RESULT="+strDatasetId+")";
		 TR_MAIN.Post();
	 }
	var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");
	}else
		return false;

  }

 /**
  * getStrInOutYN(strDatasetId, strEStrCd, strFStrCd)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-31
  * 개    요 : 점간 점출입이 가능한지 확인한다.
  * return값 :  Y/N
  */
  function getStrInOutYN(strDatasetId, strEStrCd, strFStrCd){
	 var goTo         = "getStrInOutYN" ;
	 var action       = "O";
	 var parameters   =  "&strEStrCd="+encodeURIComponent(strEStrCd)
	                    +"&strFStrCd="+encodeURIComponent(strFStrCd);
	 TR_MAIN.Action   = "/pot/ccom000.cc?goTo="+goTo+parameters;
	 TR_MAIN.KeyValue = "SERVLET(O:DS_O_RESULT="+strDatasetId+")";
	 TR_MAIN.Post();

	 var dataSet = eval(strDatasetId);
	 if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");
	 }else
		 return false;
  }

 /**
  * getCalcPord(flag, numCost, numSale, numMgRate, strTaxFlag, roundFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-03-08
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
		
	  case "GAP_RATE2":	// 차익율
			switch (strTaxFlag){
			case "1":
				if(numSale == 0)
					break;

				rtnNum = getRoundDec("1", ((((numSale*10)/11) - numCost)/numCost) *100,2);

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
			rtnNum = getRoundDec(roundFlag, (((numSale*10)/11)*(100-numMgRate))/100);
			break;
		case "2":
			rtnNum = getRoundDec(roundFlag, (numSale*(100-numMgRate))/100);
			break;
		case "3":
			rtnNum = getRoundDec(roundFlag, (numSale*(100-numMgRate))/100);
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
			rtnNum = getRoundDec(roundFlag, (numCost*100*1.1)/tmp1,-1);
			//alert(rtnNum);
			break;
		case "2":
			if(numMgRate == 100)
				break;

			rtnNum = getRoundDec(roundFlag, (numCost*100)/tmp1,-1);
			break;
		case "3":
			if(numMgRate == 100)
				break;

			rtnNum = getRoundDec(roundFlag, (numCost*100)/tmp1,-1);
			break;
		}
		break;
	 case "VAT_AMT":	// 부가세
		switch (strTaxFlag){
		case "1":
			rtnNum = getRoundDec(roundFlag, numCost*0.1, 0);
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
   * isSkuCdCheckSum()
   * 작 성 자 : 정진영
   * 작 성 일 : 2010-03-10
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
   * 작 성 일 : 2010-03-10
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
			oddNumSum += parseInt(skuCd.charAt(i));		// 홀수합
		else
			evenNumSum += parseInt(skuCd.charAt(i));	// 짝수합
	  }
	  // 짝수번째의 숫자 합 * 3
	  var tmpEvenNum = evenNumSum*3;

	  // (짝수번째의 숫자 합 * 3 ) + 홀수번째 숫자 합
	  var tmpSum = oddNumSum + tmpEvenNum;

	  // 결과에 10의 배수가 되도록 더해진 최소수치 (0이상의 양수)
	  var returnVal = tmpSum%10 == 0 ? 0 : ( 10 - (tmpSum%10));

	  return returnVal ;
  }


/**
 * getSalCostPrc()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-10
 * 개    요 :  판매매가와 마진율을 등록하면 판매원가을 계산
 * return값 : int
 */
function getSalCostPrc(salePrc, saleMgRate, roundFlag, taxFlag){
	// 판매매가에서 과세구분에 따라 부가가치세 제외
	salePrc = taxFlag == '1'? ((salePrc*10)/11):salePrc;
	// 판매원가 계산 ( 판매가 * ((100 - 마진율)/100))
	var tmpSalCostPrc =  (salePrc * ( 100 - saleMgRate))/100 ;
	// 협력사의 반올림구분에 따라 소수점 처리 (common.js)
	tmpSalCostPrc = getRoundDec("1", tmpSalCostPrc);
	return tmpSalCostPrc;
}

/**
 * getSalePrc()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-10
 * 개    요 : 판매원가와 마진율을 등록하면 판매매가를 계산
 * return값 : int
 */
function getSalePrc( salCostPrc, saleMgRate, roundFlag, taxFlag){
	//판매매가 계산 ( 판매원가 /((100 - 마진율)/100))
	//var tmpSalePrc = salCostPrc / ((100 - saleMgRate)/100);
	//판매매가 계산 ( 판매원가 /(100 - 마진율))*100)
	var tmpSalePrc = (salCostPrc / (100 - saleMgRate))*100;
	// 판매매가에 과세구분에 따라 부가가치세 추가
	tmpSalePrc = taxFlag == '1'? tmpSalePrc*1.1:tmpSalePrc;
	// 반올림구분에 따라 소수점 처리 (common.js)
	tmpSalePrc = getRoundDec("1", tmpSalePrc);
	return tmpSalePrc;
}
/**
 * getSaleMgRate()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-10
 * 개    요 : 판매원가와 판매매가을 등록하면 마진율을 계산
 * return값 : int
 */
function getSaleMgRate( salCostPrc, salePrc, roundFlag, taxFlag, dec){
	//판매매가가 0 이면 마진율 0
	if( salePrc == 0)
		return 0;
	// 판매매가에서 과세구분에 따라 부가가치세 제외
	  salePrc = taxFlag == '1'? (((salePrc*10)/11)):(salePrc);
	  // 마진율계산 ( 판매매가 - 판매원가) / 판매매가 * 100 )
	  var tmpSaleMgRate = ( salePrc - salCostPrc ) / salePrc * 100;
	  //  반올림구분에 따라 소수점 처리 (common.js)
	  tmpSaleMgRate = getRoundDec("1", tmpSaleMgRate, dec==null?2:dec);
	  return tmpSaleMgRate;
}

/**
 * isValidInputByte()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-07
 * 개    요 : 입력 byte 체크
 * 사용방법 : isValidInputByte(grid, binder, fieldInfo)
 *            arguments[0] -> 데이터셋 오브젝트
 *            arguments[1] -> 데이터 셋의 바인드 오브젝트
 *            arguments[2] -> 새로 사이즈 변경할  필드정보(필드명:사이즈)
 *                            암호화필드 길이가 길어서 혹시 필요할것 같아서 만듬
 *
 *            if (!isValidInputByte(GD_MASTER, BO_HEADER, "test1:10|test2:20")) {
 *                return false;
 *            }
 * return값 : true, false
 */
function isValidInputByte(grid, binder, fieldInfo) {
	var dataSet = eval(grid.DataID);
	// 바인드 정보
	var bindInfo = binder.BindInfo;
	// 컬럼과 컴포넌트 매칭 정보를 맵으로 구성
	var tmpMap = new Map();
	while (bindInfo.indexOf("col=") != -1) {
		bindInfo = bindInfo.substring(bindInfo.indexOf("col=")+4);
		var tmpKey = bindInfo.substring(0,bindInfo.indexOf(" "));
		bindInfo = bindInfo.substring(bindInfo.indexOf("ctrl=")+5);
		var tmpValue = bindInfo.substring(0, bindInfo.indexOf(" "));
		tmpMap.put(tmpKey, tmpValue);
	}

	var row = dataSet.RowPosition;
	var fieldLength = 0;
	// 공백제거 새로 지정할 필드정보
	if (fieldInfo) {
		var fieldArray = fieldInfo.trim().split("|");
		fieldLength = fieldArray.length;
	}

	if (grid && binder && row > 0) {
		for (var i = 1; i <= dataSet.CountColumn; i++) {
			// col아이디
			var colid = dataSet.ColumnID(i);
			// 입력할 필드정보
			var component = tmpMap.get(colid);
			// 입력할 필드사이즈
			var colSize = dataSet.ColumnSize(dataSet.ColumnIndex(colid));
			// 새로 지정할 필드정보
			if (fieldLength > 0) {
				for (var k = 0; k < fieldLength; k++) {
					var field = fieldArray[k].split(":");
					if (colid == field[0] && field[1] > 0) {
						colSize = field[1];
						break;
					}
				}
			}
			// 입력할 필드값
			var colVal = dataSet.NameValue(row, colid);
			// 입력할 필드이름
			var colName = grid.GetHdrDispName(-3, colid);
			// 바이트체크
			var result = checkByteLengthStr(colVal, colSize, "N");
			// 메세지 보여주기
			if (result) {
				showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할 수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
				dataSet.NameValue(row, colid) = result;
				eval(component).Focus();
				return false;
				break;
			}
		}
	}

	return true;
}

/**
 * isValidGridInputByte()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-07
 * 개    요 : Grid 입력 byte 체크
 * 사용방법 : isValidGridInputByte(grid, fieldInfo)
 *            arguments[0] -> 그리드 오브젝트
 *            arguments[1] -> 새로 사이즈 변경할 필드정보(필드명:사이즈)
 *                            암호화필드 길이가 길어서 혹시 필요할것 같아서 만듬
 *
 *            if (!isValidGridInputByte(GD_MASTER, "test1:10|test2:20")) {
 *                return false;
 *            }
 * return값 : true, false
 */
function isValidGridInputByte(grid, fieldInfo) {
	var dataSet = eval(grid.DataID);
	var row = dataSet.CountRow;
	var fieldLength = 0;
	// 공백제거 새로 지정할 필드정보
	if (fieldInfo) {
		var fieldArray = fieldInfo.trim().split("|");
		fieldLength = fieldArray.length;
	}

	if (grid && dataSet && row > 0) {
		for (var i = 1; i <= row; i++) {
			var rowStatus = dataSet.RowStatus(i);

			// 입력 아닐때
			if (rowStatus == 0 || rowStatus == 2 || rowStatus == 4) {
				continue;
			}

			for (var m = 1; m <= dataSet.CountColumn; m++) {
				// col아이디
				var colid = dataSet.ColumnID(m);
				// 입력할 필드사이즈
				var colSize = dataSet.ColumnSize(dataSet.ColumnIndex(colid));
				// 새로 지정할 필드정보
				if (fieldLength > 0) {
					for (var k = 0; k < fieldLength; k++) {
						var field = fieldArray[k].split(":");
						if (colid == field[0] && field[1] > 0) {
							colSize = field[1];
							break;
						}
					}
				}
				// 입력할 필드값
				var colVal = dataSet.NameValue(i, colid);
				// 입력할 필드이름
				var colName = grid.GetHdrDispName(-3, colid);
				// 바이트체크
				var result = checkByteLengthStr(colVal, colSize, "N");
				// 메세지 보여주기
				if (result) {
					showMessage(EXCLAMATION, OK, "GAUCE-1000", i +"행의 "+ colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할 수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
					dataSet.NameValue(i, colid) = result;
					// 포커스
					dataSet.RowPosition = i;
					grid.SetColumn(colid);
					grid.Focus();
					return false;
					break;
				}

			}
		}
	}

   return true;
}

/**
 * isValidCardNo()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010-04-11
 * 개    요 : 카드번호 유효성 체크
 * 사용방법 : isValidCardNo(pCardNo)
 * return값 : true, false;
 */
function isValidCardNo(pCardNo) {

	var isValid = false;
	var intChkDigit = 0;
	if (null == pCardNo) pCardNo = "";

	if (16 != pCardNo.length) {
		isValid = false;
		return isValid;
	}
	var digit1  = parseInt(pCardNo.substring(0, 1));
	var digit2  = parseInt(pCardNo.substring(1, 2));
	var digit3  = parseInt(pCardNo.substring(2, 3));
	var digit4  = parseInt(pCardNo.substring(3, 4));
	var digit5  = parseInt(pCardNo.substring(4, 5));
	var digit6  = parseInt(pCardNo.substring(5, 6));
	var digit7  = parseInt(pCardNo.substring(6, 7));
	var digit8  = parseInt(pCardNo.substring(7, 8));
	var digit9  = parseInt(pCardNo.substring(8, 9));
	var digit10 = parseInt(pCardNo.substring(9, 10));
	var digit11 = parseInt(pCardNo.substring(10, 11));
	var digit12 = parseInt(pCardNo.substring(11, 12));
	var digit13 = parseInt(pCardNo.substring(12, 13));
	var digit14 = parseInt(pCardNo.substring(13, 14));
	var digit15 = parseInt(pCardNo.substring(14, 15));
	var chk_digit = pCardNo.substring(15, 16);

	var dSum =  (digit1  * 1) + (digit2  * 7)
			 +  (digit3  * 1) + (digit4  * 7)
			 +  (digit5  * 1) + (digit6  * 7)
			 +  (digit7  * 1) + (digit8  * 7)
			 +  (digit9  * 1) + (digit10 * 7)
			 +  (digit11 * 1) + (digit12 * 7)
			 +  (digit13 * 1) + (digit14 * 7)
			 +  (digit15 * 1) ;

	intChkDigit = 10 - (dSum - (Math.floor(dSum / 10) * 10));
	if(intChkDigit == 10){
		intChkDigit = 0;
	}
	if (chk_digit == intChkDigit.toString()) {
		isValid = true;
	} else {
		isValid = false;
	}
	return isValid;
}

/**
 * getDayOfWeekCount()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-04-12
 * 개    요 : 기간안에있는 요일 카운트 하기
 * 사용방법 : getDayOfWeekCount('20100101','20101231',['1','2','3','4','5','6','7']);
 *           '1':일요일, '2':월요일, '3':화요일...
 * return값 : number;
 */
function getDayOfWeekCount(startDt, endDt, days) {
	if (startDt == null || startDt.length != 8 ||
		endDt == null || endDt.length != 8 ||
		days == null || days.length == 0) return 0;

	var cnt = 0;
	var calDt = startDt;
	while (eval(calDt) <= eval(endDt)) {
		var d = new Date(calDt.substring(0,4), eval(calDt.substring(4,6))-1, calDt.substring(6,8));
		var dow = d.getDay()+1;
		for (var i = 0; i < days.length; i++) {
			if (days[i] == dow) cnt++;
		}
		var t = new Date(d.getFullYear(),d.getMonth(),d.getDate()+1);
		calDt = t.getFullYear()+''+numFormat(t.getMonth()+1,2)+''+numFormat(t.getDate(),2);
	}
	return cnt;
}

/**
 * isValidDate()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-04-14
 * 개    요 : 유효한 날짜인지 검사
 * 사용방법 : isValidDate('20100101');
 * return값 : true or false
 */
function isValidDate(yyyymmdd) {
	if (yyyymmdd == null || yyyymmdd == undefined || yyyymmdd.length != 8)
		return false;

	if (yyyymmdd.indexOf(' ') > -1) return false;
	var yyyy = parseInt(yyyymmdd.substring(0,4),10);
	var mm = parseInt(yyyymmdd.substring(4,6),10);
	var dd = parseInt(yyyymmdd.substring(6,8),10);
	var mon = [31,28,31,30,31,30,31,31,30,31,30,31];
	if (mm > 12 || mm < 1) return false;
	if ((yyyy % 4 == 0 && yyyy % 100 !=0) || yyyy % 400 == 0) mon[1] = 29;
	mm--;

	return (dd > 0 && dd <= mon[mm]);
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
	  inHTML += '<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"> \n';
	  inHTML += '<link href="/pot/css/mds.css" rel="stylesheet" type="text/css"> \n';
	  inHTML += '</head> \n';
	  inHTML += '<body marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 onblur="self.focus()"> \n';
	  inHTML += '<center> \n';
	  inHTML += '<table  border="0" cellpadding="0" cellspacing="0" align="center"> \n';
	  inHTML += '	<tr> \n';
	
	if (strGubn == "S") {
		inHTML += '		<td><img src="/pot/imgs/comm/img_search.gif"></td> \n';
	} else if (strGubn == "B") {
		inHTML += '		<td><img src="/pot/imgs/comm/img_process.gif"></td> \n';
	}
	inHTML += '	</tr> \n';
	inHTML += '</table> \n';
	inHTML += '</center> \n';
	inHTML += '</body> \n';
	inHTML += '</html> \n';

	var bodyWidth  = document.body.clientWidth;
	var bodyHeight = document.body.clientHeight;
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
 * setDateAdd()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 일,년,월 추가
 * return값 : YYYYMMDD형 일자
 *           setDateAdd("조회구분:Y,M,D", 추가일자, 기준DATE);
 *           setDateAdd("D", 1, "20100431"); => 20100501
 */
function setDateAdd(strAddGbn, strAddNum, strDate) {
	//일자 SET
	var currY = eval(strDate.substr(0, 4));
	var currM = eval(strDate.substr(4, 2));
	var currD = eval(strDate.substr(6, 2));

	//ADD DATE
	if (strAddGbn == "Y") {
		currY = eval(currY) + eval(strAddNum);
	} else if (strAddGbn == "M"){
		currM = eval(currM) + eval(strAddNum);
	} else if (strAddGbn == "D"){
		currD = eval(currD) + eval(strAddNum);
	}

	var addDate = new Date(currY, eval(currM)-1, currD);
	var tempY = addDate.getFullYear();
	var tempM = addDate.getMonth() + 1;
	var tempD = addDate.getDate();

	//YYYYMMDD형식으로 변경
	tempM = tempM < 10 ? "0" + tempM : tempM;
	tempD = tempD < 10 ? "0" + tempD : tempD;

	return tempY +""+ tempM +""+ tempD;
}


/**
 * getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd)
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-03-08
 * 개    요 :  협력사에 따라 반올림구분을 가져온다.
 * return값 : void
 */
 function getVenRoundFlag(strDatasetId, strToday, strStrCd, strVenCd){
	if(strStrCd.length != 0 && strVenCd.length != 0){
		var goTo       = "getVenRoundFlag" ;
		var action     = "O";
		var parameters =  "&strToday="+encodeURIComponent(strToday)
						+ "&strStrCd="+encodeURIComponent(strStrCd)
						+ "&strVenCd="+encodeURIComponent(strVenCd);
		TR_MAIN.Action   = "/pot/ccom000.cc?goTo="+goTo+parameters;
		TR_MAIN.KeyValue = "SERVLET(O:DS_O_RESULT="+strDatasetId+")";
		TR_MAIN.Post();
	}
	
	var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		return dataSet.NameValue(1, "V_RETURN");
	}else {
		return false;
	}
}

/**
 * getSaleDate(strDatasetId, strYyyymm, strPayCyc, strPayCnt)
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-08
 * 개    요     : 회차별 매출매입시작일, 종료일조회
 * return값     : void
 */
function getSaleDate(strDatasetId, strYyyymm, strPayCyc, strPayCnt) {
	eval(strDatasetId).ClearData();
	if(strPayCnt == "%")
		return;

	var goTo       = "getSaleDate" ;
	var action     = "O";
	var parameters =  "&strYyyymm="+encodeURIComponent(strYyyymm)
					+ "&strPayCyc="+encodeURIComponent(strPayCyc)
					+ "&strPayCnt="+encodeURIComponent(strPayCnt);
	TR_MAIN.Action  = "/pot/ccom000.cc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_SALE_DATE="+strDatasetId+")"; //조회는 O
	TR_MAIN.Post();
}

/**
 * getPayDate()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-08
 * 개    요     : 회차별 지불일
 * return값 : void
 */
function getPayDate(strDatasetId, strYyyymm, strPayCyc, strPayCnt) {
	eval(strDatasetId).ClearData();
	if(strPayCnt == "%")
		return;

	var goTo       = "getPayDate" ;
	var action     = "O";
	var parameters =  "&strYyyymm="+encodeURIComponent(strYyyymm)
					+ "&strPayCyc="+encodeURIComponent(strPayCyc)
					+ "&strPayCnt="+encodeURIComponent(strPayCnt);
	TR_MAIN.Action  = "/pot/ccom000.cc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_PAY_DATE="+strDatasetId+")"; //조회는 O
	TR_MAIN.Post();
}

/**
 * getIssueDate()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-14
 * 개    요        : 회차별 계산서 발행기간 조회
 * return값 : void
 */
function getIssueDate(strDatasetId,strStrCd,strYyyymm,strPayCyc,strPayCnt) {
	eval(strDatasetId).ClearData();
	var strToday   = getTodayDB(strDatasetId);
	var goTo       = "getIssueDate" ;
	var action     = "O";
	var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)
					+ "&strYyyymm="+encodeURIComponent(strYyyymm)
					+ "&strPayCyc="+encodeURIComponent(strPayCyc)
					+ "&strPayCnt="+encodeURIComponent(strPayCnt);
	TR_MAIN.Action  = "/pot/ccom000.cc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_ISSUE_DATE="+strDatasetId+")"; //조회는 O
	TR_MAIN.Post();

	var strIssueSdt = DS_O_ISSUE_DATE.NameValue(DS_O_ISSUE_DATE.RowPosition, "ISSUE_S_DT");
	var strIssueEdt = DS_O_ISSUE_DATE.NameValue(DS_O_ISSUE_DATE.RowPosition, "ISSUE_E_DT");

	// 세금계산서 발행기간 정보가 없음.
	if(DS_O_ISSUE_DATE.CountRow <= 0){
		showMessage(EXCLAMATION, OK, "USER-1087");
		return false;
	}

	// 세금계산서 발행기간이 아님.
	if(strToday < strIssueSdt || strToday > strIssueEdt){
		showMessage(EXCLAMATION, OK, "USER-1088");
		return false;
	}else{
		return true;
	}
}

/**
 * getTodayDB()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-22
 * 개    요     : 현재날짜(DB) 조회
 * return값     : void
 */
function getTodayDB(strDatasetId) {

	var goTo       = "getToday" ;
	var action     = "O";
	TR_MAIN.Action   = "/pot/ccom000.cc?goTo="+goTo;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_RESULT="+strDatasetId+")";
	TR_MAIN.Post();

	var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		return dataSet.NameValue(1, "TODAY");
	}else {
		return false;
	}
}

/**
 * ppayCloseCheck()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-05-16
 * 개    요     : 주기, 회차별 대금지불 마감 체크
 * return값     : void
 */
function ppayCloseCheck(strStrCd,strYyyymm,strPayCyc,strPayCnt) {

	var strCloseTaskFlag = "PPAY";                 // 업무구분(대금지불월마감)
	var strCloseUnitFlag = "";                     // 단위업무
	var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)
	var strCloseFlag     = "M";                    // 마감구분(월마감:M)

	if(strPayCyc == "1" && strPayCnt == "1")
		strCloseUnitFlag = "52";
	else if(strPayCyc == "2" && strPayCnt == "1")
		strCloseUnitFlag = "53";
	else if(strPayCyc == "2" && strPayCnt == "2")
		strCloseUnitFlag = "54";
	else if(strPayCyc == "3" && strPayCnt == "1")
		strCloseUnitFlag = "55";
	else if(strPayCyc == "3" && strPayCnt == "2")
		strCloseUnitFlag = "56";
	else if(strPayCyc == "3" && strPayCnt == "3")
		strCloseUnitFlag = "57";

	var closeFlag = getCloseCheck("DS_O_RESULT", strStrCd, strYyyymm, strCloseTaskFlag, strCloseUnitFlag, strCloseAcntFlag, strCloseFlag);

	return closeFlag;
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
	var minLength = 6; // 최소 길이
	var invalid = " "; // 공백은 불허


	// 최소 글자수 체크
	if (obj.value.length < minLength) {
		showMessage(STOPSIGN, OK, "USER-1000", "최소6자리 이상입니다.");
		showMessage(STOPSIGN, OK, "SCRIPT-1001", arguments);
		return false;
	}

	if (obj.value.indexOf(invalid) > -1) {
		showMessage(STOPSIGN, OK, "USER-1000", "공백은 허용하지 않습니다.");
		return false;
	}

	if(isAlphabet(obj)) {
		showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로 문자와 숫자를 혼용하여 사용하세요");
		return false;
	}


	if(isNumberStr(obj.value)) {
		showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로 문자와 숫자를 혼용하여 사용하세요");
		return false;
	}

	// 1234 오름 차순  Check
	for(i=0;i<obj.value.length;i++){

		char_num=obj.value.charAt(i).charCodeAt(0);

		if (parseInt(char_num)>=97 && parseInt(char_num)<=122){
			if((parseInt(strBefore+1))==parseInt(char_num)){
				ch=ch+1;
				if (ch>=3){
					showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로 연속된 문자를 허용하지 않습니다  ");
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
					showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로  연속된 문자를 허용하지 않습니다  ");
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
					showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로  연속된 문자를 허용하지 않습니다  ");
					return false;
				}
			} else {
				ch=0;
			}
			strBefore=char_num;
		}

		if((parseInt(strFore))==parseInt(char_num)){
			sh=sh+1;
			if (sh>=3){
				showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로  연속된 문자를 허용하지 않습니다  ");
				return false;
			}
		}else{
			sh=0;
		}

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
			showMessage(STOPSIGN, OK, "USER-1000", "특수문자는 허용하지 않습니다  ");
			return false;
		}
	}

	// 내림차순 Check 변수 초기화
	ch=0;
	strBefore = "";
	for(i=0;i<obj.value.length;i++){

		char_num=obj.value.charAt(i).charCodeAt(0);

		if (parseInt(char_num)>=97 && parseInt(char_num)<=122){
			if((parseInt(strBefore-1))==parseInt(char_num)){
				ch=ch+1;
				if (ch>=3){
					showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
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
					showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
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
					showMessage(STOPSIGN, OK, "USER-1000", "보안상의 이유로 한 문자로 연속된 문자를 허용하지 않습니다  ");
					return false;
				}
			} else {
				ch=0;
			}
			strBefore=char_num;
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
 * getSlipProcStat(strDatasetId, strStrCd , strSlipNo)
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-08-08
 * 개    요 : 전표의 상태를 조회한다.
 * return값 : SLIP_PROC_STAT
 */
function getSlipProcStat(strDatasetId, strStrCd , strSlipNo) {
	var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
				   + "&strSlipNo="+encodeURIComponent(strSlipNo);

	TR_MAIN.Action="/pot/ccom000.cc?goTo=getSlipProcStat"+parameters;
	TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDatasetId+")";
	TR_MAIN.Post();

	var dataSet = eval(strDatasetId);
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "SLIP_PROC_STAT");
	} else {
		return false;
	}
}

/**
 * slipProcStatCheck(strStrCd , strSlipNo)
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-08-08
 * 개    요 : 전표상태가확정되었을 경우 수정/삭제 불가능
 * return값 : true/false
 */
function slipProcStatCheck(strStrCd, strSlipNo) {
	var strSlipProcStat = "";
	if(strSlipNo != ""){
		strSlipProcStat = getSlipProcStat("DS_O_RESULT", strStrCd, strSlipNo);
		if(strSlipProcStat != "00"){
			showMessage(EXCLAMATION, OK, "USER-1218");
			return false;
		}
		return true;
	}
	return true;
}

/**
 * gfnCheckDup()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-25
 * 개    요 : 중복 키 체크
 * return값 : bool
 */
function gfnCheckDup(objDs, strKeyVal, strKeyColumn) {

    var arrKeyColumn = strKeyColumn.split(":");
    var strDsKeyVal  = "";
    var nCnt         = 0;

    for(var i = 1; i <= objDs.CountRow; i++){
        strDsKeyVal = "";
        for(var j = 0; j < arrKeyColumn.length; j++){
            strDsKeyVal += objDs.NameValue(i, arrKeyColumn[j]);
        }
        if(strKeyVal == strDsKeyVal){
            nCnt++;
        }
//         alert("strKeyVal = " + strKeyVal + ", strDsKeyVal = " + strDsKeyVal);
    }
    return nCnt;
}



/**
 * gfnConvertToEan13Code(strEan13Cd)
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-11-22
 * 개    요 : EAN13 코드로 변환
 * return값 : strConvertCd
 */
function gfnConvertToEan13Code(strEan13Cd){

	// 문자열을 배열로 변환
	var arrCd = new Array(strEan13Cd.lenth);
	
	for(var i = 0; i < strEan13Cd.length; i++) arrCd[i] = strEan13Cd.substr(i, 1);
	
	var strFstCd = "";
	var arrFstCd = new Array(10);
	arrFstCd  = ["000000", "001011", "001101", "001110", "010011", "011001", "011100", "010101", "010110", "011010"];
	var objTb = { tb1 : { 0 : "A" , 1 : "B" , 2 : "C" , 3 : "D" , 4 : "E" , 5 : "F" , 6 : "G" , 7 : "H" , 8 : "I" , 9 : "J"}
	            , tb2 : { 0 : "K" , 1 : "L" , 2 : "M" , 3 : "N" , 4 : "O" , 5 : "P" , 6 : "Q" , 7 : "R" , 8 : "S" , 9 : "T"}
	            , tb3 : { 0 : "a" , 1 : "b" , 2 : "c" , 3 : "d" , 4 : "e" , 5 : "f" , 6 : "g" , 7 : "h" , 8 : "i" , 9 : "j"}
	            };
	
	var strConvertCd = "";
	var arr27Cd      = new Array(6); // 2~7번째 자리에서 사용할 코드 (objTb.tb1, objTb.tb2)
	for(var i = 0; i < arrCd.length; i++){
		
		// 1~7번째 자릿수에 따른 문자 변환로직
		if(i < 7){
			// 바코드의 첫번째 문자로 기본변환자료 세팅
			if(i == 0){

				// objTb에서 참조할 테이블 설정
				strFstCd   = arrFstCd[arrCd[i]];	// 첫번째 자리의 코드
				arr27Cd[0] = strFstCd.substr(0, 1);
				arr27Cd[1] = strFstCd.substr(1, 1);
				arr27Cd[2] = strFstCd.substr(2, 1);
				arr27Cd[3] = strFstCd.substr(3, 1);
				arr27Cd[4] = strFstCd.substr(4, 1);
				arr27Cd[5] = strFstCd.substr(5, 1);

				// 첫번째 바코드 숫자 세팅
				strConvertCd += arrCd[i];
			}else{

				if(arr27Cd[i-1] == "0"){
					strConvertCd += objTb.tb1[arrCd[i]];
				}else if(arr27Cd[i-1] == "1"){
					strConvertCd += objTb.tb2[arrCd[i]];	
				}
				if(i == 6) strConvertCd += "*";
			}
		}
		
		// 8~13자릿수에 따른 문자 변환로직
		else{
			strConvertCd += objTb.tb3[arrCd[i]];
			if(i == 12) strConvertCd += "+";
		}
	}
	
	return strConvertCd;	
}

/**
 * gfnToshibaTegPrint()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016.11.20
 * 개    요 : 도시바 SX-5T 프린터기 출력
 * return값 : void
 */
function gfnToshibaTegPrint( strSkuflag, arrLines1, arrLines2, arrLines3, arrLines4
		                   , arrLines5,  arrLines6, arrLines7, arrLines8, arrCnts){
    
    if(TEC_DO1.IsDriver != 1){
 	   alert("TEC B-SX5T 드라이버를 설치해 주세요");
	   return;
    }

	var strPaperX   = 600;						// 라벨 X크기
	var strPaperY   = 700;						// 라벨 Y크기
	var strX        = 5;			 			// 인쇄할 X위치
	var strY        = 80;						// 인쇄할 Y위치
	var strFont     = "";						// 폰트명
	var strFontSize = 35;						// 폰트크기
	var strBold     = 0;						// Bold유/무
	var strOpt      = 0;						// 회전(0,90,180,270)
	var strEan13Cd  = "";
	var strAmt      = "";
	
	// 텍라벨 사이즈 지정
	TEC_DO1.SetPaper(strPaperX, strPaperY);
	  
	if(strSkuflag == "2"){	// 품목이면
		for(var i = 0; i < arrCnts.length; i++){
			for(var j = 0; j < arrCnts[i]; j++){
				// 프린트 Open
				TEC_DO1.PrinterOpen();
				
				// 왼쪽 택 시작
				TEC_DO1.PrintText(strX+135, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);	// (점명 + 거래형태(특, 직))
				strY += 50;
				
				TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);		// PBN_RECP_NM (브랜드 영수증명)
				TEC_DO1.PrintText(strX+265, strY, strFont, strFontSize, strBold, strOpt, arrLines3[i]);	// EVENT_FLAG (행사구분)
				strY += 50;
				
				TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines4[i]);	// PMK_RECP_NM (품목 영수증명)
				strY += 50;

				strEan13Cd = gfnConvertToEan13Code(arrLines5[i]);	// Ean13코드로 변환
				TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);		// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D)
				strY += 160;
				
				strEan13Cd = gfnConvertToEan13Code(arrLines6[i]);	// Ean13코드로 변환
				TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);		// 29+EVENT_FLAG+SALE_PRC+C/D (21+행사구분+단가+C/D)
				strY += 160;
				
				strAmt = "￦ " + comma(arrLines7[i]);
				TEC_DO1.PrintText(strX+40, strY, strFont, 50, 1, strOpt, strAmt);	// SALE_PRC (금액)
				strY -= 470;
				// 왼쪽 택 종료
				
				// 오른쪽 택 시작
				strX += 360;
				TEC_DO1.PrintText(strX+135, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);	// (점명 + 거래형태(특, 직))
				strY += 50;
				
				TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);		// PBN_RECP_NM (브랜드 영수증명)
				TEC_DO1.PrintText(strX+265, strY, strFont, strFontSize, strBold, strOpt, arrLines3[i]);	// EVENT_FLAG (행사구분)
				strY += 50;
				
				TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines4[i]);	// PMK_RECP_NM (품목 영수증명)
				strY += 50;

				strEan13Cd = gfnConvertToEan13Code(arrLines5[i]);	// Ean13코드로 변환
				TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);		// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D)
				strY += 160;
				
				strEan13Cd = gfnConvertToEan13Code(arrLines6[i]);	// Ean13코드로 변환
				TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);		// 29+EVENT_FLAG+SALE_PRC+C/D (21+행사구분+단가+C/D)
				strY += 160;
				
				strAmt = "￦ " + comma(arrLines7[i]);
				TEC_DO1.PrintText(strX+40, strY, strFont, 50, 1, strOpt, strAmt);	// SALE_PRC (금액)
				strY -= 470;
				strX -= 360;
				// 오른쪽 택 종료
				
//				alert("1");
				// 커팅위치 설정
				TEC_DO1.SetCutter(1, 0, 1, -5.5);
//				TEC_DO1.SetAdjustment(0, 0.0, 0.0);
				
				// 프린트 Close
				TEC_DO1.PrinterClose();
			}
		}
	}
	
	// 단품
	else{

		for(var i = 0; i < arrCnts.length; i++){
			for(var j = 0; j < arrCnts[i]; j++){
				// 프린트 Open
				TEC_DO1.PrinterOpen();
				
				if(arrLines8[i] == "1"){	// 규격단품
					
					strY += 150;
				
					// 왼쪽 택 시작
					TEC_DO1.PrintText(strX+135, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);	// STR_NM (점명)
					strY += 50;
					
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);		// PBN_RECP_NM+(BIZ_TYPE_NM+TAX_FLAG_NM) (브랜드 영수증명+거래형태(특,직)+과세구분)
					strY += 50;
					
					strEan13Cd = gfnConvertToEan13Code(arrLines3[i]);	// Ean13코드로 변환
					TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);			// SKU_CD (단품코드)
					strY += 160;
					
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines4[i]);		// SKU_NM (단품코드 명)
					strY += 50;
					
					strAmt = "￦ " + comma(arrLines5[i]);
					TEC_DO1.PrintText(strX+40, strY, strFont, 50, 1, strOpt, strAmt);	// SALE_PRC (금액)
					strY -= 310;
					// 왼쪽 택 종료
					
					strX += 360;
					
					// 오른쪽 택 시작
					TEC_DO1.PrintText(strX+135, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);	// STR_NM (점명)
					strY += 50;
					
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);		// PBN_RECP_NM+(BIZ_TYPE_NM+TAX_FLAG_NM) (브랜드 영수증명+거래형태(특,직)+과세구분)
					strY += 50;
					
					strEan13Cd = gfnConvertToEan13Code(arrLines3[i]);	// Ean13코드로 변환
					TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);			// SKU_CD (단품코드)
					strY += 160;
					
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines4[i]);		// SKU_NM (단품코드 명)
					strY += 50;
					
					strAmt = "￦ " + comma(arrLines5[i]);
					TEC_DO1.PrintText(strX+40, strY, strFont, 50, 1, strOpt, strAmt);	// SALE_PRC (금액)
					strY -= 310;
					// 오른쪽 택 종료	
					
					strX -= 360;	
					strY -= 150;			
				}
				
				else if(arrLines8[i] == "3"){	// 의류단품

					strY += 150;
				
					// 왼쪽 택 시작
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);		// STR_NM (점명)
					TEC_DO1.PrintText(strX+230, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);	// strMMYY (년월)
					strY += 50;
					
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines3[i]);		// SEASON_NM+PUMMOK_NM (시즌+품목명)
					strY += 50;
					
					strEan13Cd = gfnConvertToEan13Code(arrLines4[i]);	// Ean13코드로 변환
					TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);			// SKU_CD (단품코드)
					strY += 160;
					
					TEC_DO1.PrintText(strX, strY, strFont, 20, strBold, strOpt, arrLines5[i]);		// SKU_NM+COLOR_NM+SIZE_NM (단품명+컬러+사이즈)
					strY += 50;
					
					strAmt = "￦ " + comma(arrLines6[i]);
					TEC_DO1.PrintText(strX+40, strY, strFont, 50, 1, strOpt, strAmt);	// SALE_PRC (금액)
					strY -= 310;
					// 왼쪽 택 종료
					
					strX += 360;
					
					// 오른쪽 택 시작
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);		// STR_NM (점명)
					TEC_DO1.PrintText(strX+230, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);	// strMMYY (년월)
					strY += 50;
					
					TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines3[i]);		// SEASON_NM+PUMMOK_NM (시즌+품목명)
					strY += 50;
					
					strEan13Cd = gfnConvertToEan13Code(arrLines4[i]);	// Ean13코드로 변환
					TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);			// SKU_CD (단품코드)
					strY += 160;
					
					TEC_DO1.PrintText(strX, strY, strFont, 20, strBold, strOpt, arrLines5[i]);		// SKU_NM+COLOR_NM+SIZE_NM (단품명+컬러+사이즈)
					strY += 50;
					
					strAmt = "￦ " + comma(arrLines6[i]);
					TEC_DO1.PrintText(strX+40, strY, strFont, 50, 1, strOpt, strAmt);	// SALE_PRC (금액)
					strY -= 310;
					// 오른쪽 택 종료	
					
					strX -= 360;
					strY -= 150;
				}

				// 커팅위치 설정
				TEC_DO1.SetCutter(1, 0, 1, -5.5);
				
				// 프린트 Close
				TEC_DO1.PrinterClose();
			}
		}
	}
}




/**
 * gfnToshibaTegPrint_pbnpmk()
 * 작 성 자 : 박래형
 * 작 성 일 : 2017.02.25
 * 개    요 : 도시바 SX-5T 프린터기 출력(브랜드품목)
 * return값 : void
 */
function gfnToshibaTegPrint_pbnpmk( arrLines1, arrLines2
		                          , arrLines3, arrLines4, arrCnts){
    
    if(TEC_DO1.IsDriver != 1){
 	   alert("TEC B-SX5T 드라이버를 설치해 주세요");
	   return;
    }

	var strPaperX   = 900;						// 라벨 X크기
	var strPaperY   = 700;						// 라벨 Y크기
	var strX        = 0;			 			// 인쇄할 X위치
	var strY        = 85;						// 인쇄할 Y위치
	var strFont     = "";						// 폰트명
	var strFontSize = 35;						// 폰트크기
	var strBold     = 0;						// Bold유/무
	var strOpt      = 0;						// 회전(0,90,180,270)
	var strEan13Cd  = "";
	var strAmt      = "";
	//var strX        = 50;			 			// 인쇄할 X위치
	//var strY        = 150;						// 인쇄할 Y위치
	
	// 텍라벨 사이즈 지정
	TEC_DO1.SetPaper(strPaperX, strPaperY);
	  
	for(var i = 0; i < arrCnts.length; i++){
		for(var j = 0; j < arrCnts[i]; j++){
			// 프린트 Open
			TEC_DO1.PrinterOpen();
			
			// 왼쪽 택 시작
			TEC_DO1.PrintText(strX+135, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);	// (점명 + 거래형태(특, 직))
			strY += 50;
			
			TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);		// PBN_RECP_NM (브랜드 영수증명)
			strY += 50;
			
			TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines3[i]);		// PMK_RECP_NM (품목 영수증명)
			strY += 50;

			strEan13Cd = gfnConvertToEan13Code(arrLines4[i]);	// Ean13코드로 변환
			TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);			// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D)
			//TEC_DO1.PrintText(strX, strY, "Code 128", 140, strBold, strOpt, strEan13Cd);			// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D)
			// 왼쪽 택 종료
			
			// 오른쪽 택 시작
			strX += 360;
			strY -= 150;
			TEC_DO1.PrintText(strX+135, strY, strFont, strFontSize, strBold, strOpt, arrLines1[i]);	// (점명 + 거래형태(특, 직))
			strY += 50;
			
			TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines2[i]);		// PBN_RECP_NM (브랜드 영수증명)
			strY += 50;
			
			TEC_DO1.PrintText(strX, strY, strFont, strFontSize, strBold, strOpt, arrLines3[i]);		// PMK_RECP_NM (품목 영수증명)
			strY += 50;

			strEan13Cd = gfnConvertToEan13Code(arrLines4[i]);	// Ean13코드로 변환
			TEC_DO1.PrintText(strX, strY, "Code EAN13", 140, strBold, strOpt, strEan13Cd);			// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D)
			//TEC_DO1.PrintText(strX, strY, "Code 128", 140, strBold, strOpt, strEan13Cd);			// 21+PUMBUN_CD+PUMMOK_SRT_CD+C/D (21+브랜드코드+품목단축코드+C/D)
			
			strY -= 150;
			strX -= 360;
//			// 오른쪽 택 종료
			
			// 커팅위치 설정
			TEC_DO1.SetCutter(1, 0, 1, -5.5);
//				TEC_DO1.SetAdjustment(0, 0.0, 0.0);
			
			// 프린트 Close
			TEC_DO1.PrinterClose();
		}
	}
}


/**
* comma(num)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 입력값의 세번째자리 마다 콤마를 찍어준다 (x,xxx)
* return : str
*/
function comma(num){
    var len, point, str;  
       
    num = num + "";  
    point = num.length % 3 ;
    len = num.length;  
   
    str = num.substring(0, point);  
    while (point < len) {  
        if (str != "") str += ",";  
        str += num.substring(point, point + 3);  
        point += 3;  
    }  
    return str;
}