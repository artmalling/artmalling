/*
 *  <script language="javascript" src="<%=dir%>/js/excelExport.js"    type="text/javascript"></script>
 *   enableControl(excel,true);    //엑셀
 *  <td><img src="<%=dir%>/imgs/btn/excel.gif" width="61" height="22" id="excel" onclick="javascript:if ( chBakClr(colnum) ) {excelExport('타이틀','TBL',pumbunCd);}"/></td>
 *   <div id="TBL">
 *   </div>
 *
 * 
 * 
 * 사용방법 (ECOM005 서비스가 있어야 합니다.)
 * 
 * 1. 사용하고자 하는 HTML에 이 파일을 include한다
 *
 *		<script language="javascript" src="경로/excelExport.js"></script>
 *
 *
 * 2. export 하고자 하는 table HTML을 div 로 두른다.
 *
 *		<div id= div아이디 >
 *			<table> ~ </table>
 *		</id>
 *
 *
 * 3. script내에서 excelExport() function 호출하기 (매개변수는 필요에 따라 입력한다. 매겨변수 id만 필수)
 *
 *		excelExport( 파일명, div아이디, 사용자아이디 )
 * 
 *
 */


/*********************************** 전역변수 설정.**************************************/
var exportflag = 0;		// body innerhtml내 태그 추가 진행 유무 구분자.
var strDS = "";

// 스타일 태그
var strStyleTag = " <style type='text/css'> "
				+ ".title{font-size:14px; color:#000000; font-weight:bold;}"
				+ " .sub_title {color:#386dc6; font-size:12px; font-weight:bold;}"
				+ " .g_table {Border-top:solid 2px #8daecc; Border-left:solid 1px #dddddd; Border-right:solid 1px #dddddd; Border-bottom:solid 1px #dddddd; font-size:12px;}"
				+ " .g_table TH {Border-left:solid 1px #dddddd; Border-bottom:solid 1px #dddddd;  padding-left:2px; font-size:12px; padding-right:2px; height:25px; background-color:#ececec; text-align:center; color:#5c5c5c; font-weight:100;letter-spacing:-1px; }"
				+ " .g_table TD {Border-left:solid 1px #dddddd; Border-right:solid 1px #dddddd; padding-left:2px; padding-right:2px; height:22px;}"
				+ " .g_table TD.r1 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#ffffff; text-align:center; font-size:12px;}"
				+ " .g_table TD.r2 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#f2f2f2; text-align:center; font-size:12px;}"
				+ " .g_table TD.r3 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#ffffff; text-align:left; font-size:12px;}"
				+ " .g_table TD.r4 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#ffffff; text-align:right; font-size:12px;}"
				+ " .g_table TH.point { background-image:url(/edi/imgs/comm/point.gif); background-repeat:no-repeat; Border:solid 1px #b4d0e1; height:22px; letter-spacing: -0.1ex; font-size:12px; font-weight:100; text-align:center; padding-left:10px; padding-right:5px;}"
				+ " .sum1 { padding-left:2px; padding-right:2px; height:22px; background-color:#b9d9ea; text-align:center; font-size:12px; text-align:center; font-weight:bold;}"
				+ " .sum2 { padding-left:2px; padding-right:2px; height:22px; background-color:#b9d9ea; text-align:right; font-size:12px;   }"
				+ " .g_table TD.msoTxt1 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#ffffff; text-align:center; font-size:12px; mso-number-format:'\@'; }"
				+ " .g_table TD.msoTxt2 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#f2f2f2; text-align:center; font-size:12px; mso-number-format:'\@'; }"
				+ " .g_table TD.msoTxt3 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#ffffff; text-align:left; font-size:12px; mso-number-format:'\@'; }"
				+ " .g_table TD.msoTxt4 { Border:solid 1px #b4d0e1; padding-left:2px; padding-right:2px; height:22px; background-color:#ffffff; text-align:right; font-size:12px; mso-number-format:'\@'; }"
				+ " .d_nu{font-family:dotum; font-size:20px; font-weight:bold; color:#002d60;  text-align:center; border:none; width:60px;} "
				+ " .d_date{font-family:dotum; font-weight:bold; color:#c66187; height:60px; text-align:center; Border-bottom:solid 2px #4b8eda; border-collapse:collapse;} "
				+ " .d_red{font-family:dotum;  background-color:#fff5f6; font-size:12px; color:#c66187; height:25px; text-align:center; Border:solid 1px #dddddd; border-collapse:collapse;} "
				+ " .d_com{font-family:dotum; background-color:#f6f6f6; font-size:12px; color:#797979; height:25px; text-align:center; Border:solid 1px #dddddd; border-collapse:collapse;} "
				+ " .d_blue{font-family:dotum;  background-color:#f5f9ff; font-size:12px; color:#457db4; height:25px; text-align:center; Border:solid 1px #dddddd; border-collapse:collapse;} "
				+ " .d_day{font-family:dotum; line-height:22px; font-size:12px; color:#515151; height:50px; text-align:center; Border:solid 1px #dddddd; empty-cells:show; border-collapse:collapse;} "
				+ " .d_num{font-family:dotum; line-height:22px; font-size:12px; color:#515151; height:50px; text-align:right; Border:solid 1px #dddddd; empty-cells:show; border-collapse:collapse; edit:numeric;} "
				+ " .d_comh{font-family:dotum; line-height:22px; font-size:12px; color:#797979; height:50px; text-align:center; Border:solid 1px #dddddd; empty-cells:show;  border-collapse:collapse;  background-color:#f6f6f6; } "
				+ " </style> "
				;

// form , iframe 태그
var strIframeTag =	"<iframe id='xlsFrame'  style='width: 0px; height: 0px; border: 0px; display:none;'></iframe>" //ifram 태그 
					+ "<form id=excelForm name=excelForm method=post target=xlsFrame > "							 // form 태그
					+ "<input type=hidden name=goTo>"
					+ "<input type=hidden name=filename>"	
					+ "<input type=hidden id=excelSource name=excelSource>"
					+ "</form>" 
					;

/***************************************************************************************/

function excelExport(filenm, divid, userid, cond) {
	//alert(cond);
	
	// 조회조건 확인.
	if (cond == undefined || cond == "") return;
	
	// Body 태그에 iframe 및 form 태그 추가.
	if (exportflag!=1) {
		document.body.innerHTML = strIframeTag + document.body.innerHTML; 
		// 태그 추가는 1회만 가능하도록 flag 값으로 확인.
		exportflag = 1;
	}
	
	// 파일명 설정(뒤에 년월일시분초를 붙여준다)
	var timestamp = new Date();
	timestamp = 	timestamp.getFullYear().toString()
				+ (timestamp.getMonth()+1).toString()
				+ timestamp.getDate().toString() 
				+ timestamp.getHours().toString() 
				+ timestamp.getMinutes().toString() 
				+ timestamp.getSeconds().toString()
				;
	filenm = filenm + "_" + timestamp;
	
	// PID 확인을 위한 접속 url 확인 및 substring
	var strUrl = document.URL;
	var strPID = strUrl.substring(strUrl.lastIndexOf("/")+1,strUrl.lastIndexOf("."));
	
	var goTo	= "excelExport";					// Action 명
	var strTbl	= document.getElementById(divid).innerHTML;	// 변환할 테이블 태그
	
	strTbl 		= strStyleTag + strTbl.replace(/border=0/gi,"border=1");			// 테이블 border 값이 0일경우 1로 변경
	strTbl		= filenm + strTbl;

	// CSS class 명 변경
	for (i=1;i<5;i++) {
		var strTgt	= "r"+i+" msoTxt" + i;
		var  strChg	= "msoTxt" + i;
		strTbl = strTbl.replace(new RegExp(strTgt,'gi'),strChg);
	}
	
	document.excelForm.action 				= "/edi/ecom005.ec";
	document.excelForm.goTo.value 			= goTo;
	document.excelForm.filename.value 		= encodeURIComponent(filenm);	
	document.excelForm.excelSource.value	= strTbl;			// 태그 내용은 그대로 전달.
	document.excelForm.submit();

	// 엑셀 변환 로그
	excelExportLog(filenm+"||"+cond, strPID , userid);
}

/**
 * chBakClr()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  색깔있는 로우 제거
 * return값 : void
 */

function chBakClr(colnum) {
	
	if (strMst==undefined) {
		//alert(strMst);
		return false;
	}
	
	g_pre_row = -1;
	//alert(strMst.length);
	for(n=0;n<=strMst.length-1;n++) {
		for(i=1;i<=colnum;i++) {
			//alert(n+"_"+i);
              document.getElementById(i+"tdId"+n).style.backgroundColor="#ffffff";
      	}
	}
}

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


function excelExportLog(filenm, pid, userid) {
	//alert("");
	filenm = filenm.substring(1,1000);
	
    var param = "&goTo=excelExportLog"	+ "&filenm="  	+ encodeURIComponent(filenm)
							    	   	+ "&pid=" 		+ encodeURIComponent(pid)
							    	   	+ "&userid=" 	+ encodeURIComponent(userid)
							    	   	;
    
	var Urleren = "/edi/ecom005.ec";  
	URL = Urleren + "?" +param; 
	strDS = getXMLHttpRequest(); 
	strDS.onreadystatechange = responseLogging;
	strDS.open("POST", URL, true); 
	strDS.send(null); 
	}
	
/**
 * responseLogging()
 * 작 성 자 : jyk
 * 작 성 일 : 2018-03-05
 * 개    요 :  엑셀다운 LOG작성
 * return값 : void
 */ 
function responseLogging(){
	if(strDS.readyState==4) {
		if(strDS.status == 200) {
			strDS = eval(strDS.responseText); 
	        if (strDS == undefined) {
	        	showMessage(INFORMATION, OK, "GAUCE-1000",  strDS[0].MSG);
	        } else {
	        	//showMessage(INFORMATION, OK, "GAUCE-1000",  strDS[0].MSG);
	        	return;
	        }
		} 
	}
}


