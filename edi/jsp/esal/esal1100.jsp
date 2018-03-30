<!--
/*******************************************************************************
 * 시스템명 : 협력사EDI > 영업실적 > 단골고객등록
 * 작 성 일 : 2012.06.25
 * 작 성 자 :
 * 수 정 자 :
 * 파 일 명 : esal1100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단골 고객 등록
 * 이    력 : 2012.06.25 (조승배) 신규작성
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
	String userid 	= sessionInfo.getUSER_ID();		//사용자아이디
	String strcd 	= sessionInfo.getSTR_CD();		//점코드
	String strNm 	= sessionInfo.getSTR_NM();		//점명
	String gb 		= sessionInfo.getGB();			//1. 협력사, 2.브랜드
	String vencd 	= sessionInfo.getVEN_CD();		//협력사코드
	String venNm 	= sessionInfo.getVEN_NAME();	//협력사명
	
	System.out.println("dir : " + dir);

%>
<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>아트몰링</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />

<script language="javascript"  src="<%=dir%>/js/common.js"	type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/popup.js"	type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/message.js"	type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/global.js"	type="text/javascript"></script>
<script language="javascript"  src="<%=dir%>/js/gauce.js"	type="text/javascript"></script>

<script language="javascript"><!--

//전역변수 셋팅
var strcd	= '<%=strcd%>';		//점코드
var userid	= '<%=userid%>';
var gb		= '<%=gb%>';
var vencd	= '<%=vencd%>';
var venNm	= '<%=venNm%>';
var g_strcd	= '<%=strcd%>';
var strMst	= "";
var chkcardno   = 0;
var gsInsertChk = 0;			//신규시 1(insert), 조회시 2(update)

/**
 * doinit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  최초로딩시
 * return값 : void
 */
function doinit(){
	 /* 버튼비활성화  */
	enableControl(search,true);		//조회
	enableControl(newrow,true);		//신규
	enableControl(del,true);		//삭제
	enableControl(save,true);		//저장
	enableControl(excel,false);		//엑셀
	enableControl(prints,false);	//프린터

	/* 조회 항목  */
	//initDateText('SYYYYMMDD', 'em_S_Date');	//시작일
	//initDateText("TODAY", "em_E_Date");		//종료일

	/* 이메일 기본 콤보 */
	getSelectCombo("D", "D013", "IN_DOMAIN_FLAG");
	getSelectCombo("D", "P626", "IN_GRADE_FLAG");

	/*조회부*/
	getPumbunCombo(g_strcd, vencd, "pubumCd", "Y", "2");			//점별 브랜드 select box
	getPumbunCombo(g_strcd, vencd, "IN_PUMBUN_CD", "N","2");		//입력부 브랜드
}

/**
 * getSelectCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  조회부 공통 부문
 * return값 : void
 */
function getSelectCombo(syspat, compart, target){

	var param = "&goTo=getEtcCode&syspat="+syspat+"&compart="+compart;
	<ajax:open callback="on_SelectComboXML"
		param="param"
		method="POST"
		urlvalue="/edi/ccom001.cc"/>

	<ajax:callback function="on_SelectComboXML">

	var pumbun = document.getElementById(target);

	if( rowsNode.length > 0 ){
		for( i =0; i < rowsNode.length; i++){
			var opt = document.createElement("option");
			opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);

			var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
			opt.appendChild(text);
			pumbun.appendChild(opt);
		}

		pumbun[pumbun.length-1].selected = true;
	}

	</ajax:callback>
}

/**
 * getPumbunCombo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  점별브랜드콤보
 * return값 : void
 0. strcd : 점코드
 1. vencd : 협력사코드
 2. target : 진행 할 항목
 4. YN : Y 전체 포함        N 전체 포함 안함
 */
function getPumbunCombo(strcd, vencd, target, YN, skuFlag){
	var param = "";

	param = "&goTo=getPumbunCombo&strcd=" + strcd
			 + "&vencd=" + vencd
			 + "&gb=" + gb
			 + "&skuFlag=" + skuFlag;


	<ajax:open callback="on_loadedXML"
		param="param"
		method="POST"
		urlvalue="/edi/ccom001.cc"/>

	<ajax:callback function="on_loadedXML">

	var pumbun = document.getElementById(target);

	if( rowsNode.length > 0 ){
		for( i =0; i < rowsNode.length; i++){
			var opt = document.createElement("option");
			opt.setAttribute("value", rowsNode[i].childNodes[0].childNodes[0].nodeValue);

			var text = document.createTextNode(rowsNode[i].childNodes[1].childNodes[0].nodeValue);
			opt.appendChild(text);
			pumbun.appendChild(opt);
		}
	}

	</ajax:callback>
}

//브랜드에 따른 처리
function getpumbunGbBu() {

}

//신규
function btn_new() {

	gsInsertChk = 1;	//신규 셋팅

	fn_init("");	//초기화

}

//조회
function btn_Search() {
	fn_init("disabled");	//상세 정보 disable 처리

	var b_strcd 	= document.getElementById("strcd").value;			//점코드
	var vencd 		= document.getElementById("vencd").value;			//협력사코드
	var pubumCd 	= document.getElementById("pubumCd").value;			//브랜드코드
	var custName 	= document.getElementById("custName").value;  		//고객명
	var cardNo 		= document.getElementById("cardNo").value;			//카드번호
	var sDate 		= document.getElementById("em_S_Date").value;		//시작일
	var eDate 		= document.getElementById("em_E_Date").value;		//종료일

	//alert("b_strcd : " + b_strcd + "\nvencd : " + vencd + "\npubumCd : " + pubumCd + "\ncustName : " + custName + "\ncardNo : " + cardNo + "\nsDate : " + sDate + "\neDate : " + eDate);

	//시작, 종료일 일자체크(값이 있을경우)
	if(sDate != "" || eDate != "") {	//시작일은/는 반드시 선택해야 합니다.(종료일이 있을경우)
		if (sDate == "") {	//등록 시작일이 필요 합니다.
			showMessage(StopSign, OK, "USER-1008", "등록시작일", "");
			document.getElementById("em_S_Date").focus();
			return;
		} else if(eDate == "") {	//종료일은/는 반드시 선택해야 합니다.(시작일이 있을경우)
			showMessage(StopSign, OK, "USER-1002", "등록종료일", "");
			document.getElementById("em_E_Date").focus();
			return;
		} else if (sDate > eDate) { //시작일은 종료일보다 커야 합니다.
			showMessage(StopSign, OK, "USER-1002", "종료일", "시작일");
			document.getElementById("em_S_Date").focus();
			return;
		}
	}

	//스크롤 위치 초기화
	document.all.DivListTitle.scrollLeft = 0;
	document.all.DivListContent.scrollLeft = 0;

	//json 사용 ajax
	var param = "&goTo=getList&strcd=" 	+ b_strcd
			  + "&vencd="              	+ vencd
			  + "&pubumCd="            	+ encodeURIComponent(pubumCd)
			  + "&custName="     		+ encodeURIComponent(custName)
			  + "&cardNo="             	+ cardNo
			  + "&sDate="              	+ sDate
			  + "&eDate="              	+ eDate;

	var Urleren = "/edi/esal110.es";
	URL = Urleren + "?" +param;
	strMst = getXMLHttpRequest();
	strMst.onreadystatechange = responseGetList;
	strMst.open("GET", URL, true);
	strMst.send(null);
}

/**
 * responseDetail()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 :  디테일 조회 시 조회 그리드에 데이터 넣기
 * return값 : void
 */
 function responseGetList()
 {
	if(strMst.readyState==4)
	{
		if(strMst.status == 200)
		{
			strMst = eval(strMst.responseText);
			
			var content = "<table width='230' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_list'>";
				
			if( strMst == undefined ){
				content += "	<tr>";
				content += "		<td class='r1' width='100'></td>"; 
				content += "		<td class='r1' width='13'></td>"; 
				//content += "		<td class='r1' width='115'></td>";
				//content += "		<td class='r1' width='90'></td>";
				//content += "		<td class='r1' width='65'></td>";
				content += "	</tr>";
				content += "</table>";
				document.getElementById("DivListContent").innerHTML = content;
				setPorcCount("SELECT", 0);
				return;
			} else if( strMst.length > 0 ){
				for( i = 0; i < strMst.length; i++ ){
					content += "	<tr onclick='fn_getDetailList("+i+");' style='cursor:hand;'>";
					content += "		<td class='r1' width='100'>" + strMst[i].CUST_NAME;
					content += "			<input type='hidden' name='REGUCUST_ID' id='REGUCUST_ID"+i+"' value='" + strMst[i].REGUCUST_ID + "' />";
				    content += "				<input type='hidden' name='SEQ_NO' 		id='SEQ_NO"+i+"' value='" + strMst[i].SEQ_NO + "' />";
					content += "		</td>";
					content += "		<td class='r1' width='130'>" + fn_getDateFormat(strMst[i].BIRTH_DT) + "</td>";
					//content += "		<td class='r1' width='115'>" + fn_getCardNo(strMst[i].CARD_NO) + "</td>";
					//content += "		<td class='r1' width='90'>" + strMst[i].MOBILE_PH1 + "-" + strMst[i].MOBILE_PH2 + "-" + strMst[i].MOBILE_PH3 + "</td>";
					//content += "		<td class='r1' width='65'>" + strMst[i].REG_DATE + "</td>";
					content += "	</tr>";
				}
			}
			content += "</table>";

			document.getElementById("DivListContent").innerHTML = content;
			setPorcCount("SELECT", strMst.length);
		}
	}
 }

//카드번호 '-' 처리
function fn_getCardNo(val) {
	var rtnVal = "";
	if(val.indexOf("-")<1) {
		rtnVal = val.substr(0, 4) + "-" + val.substr(4, 4) + "-" + val.substr(8, 4) + "-" + val.substr(12);
	}
	return rtnVal;
}

//카드번호 체크
function fn_blurCardNo(obj) {
	
	var tmpVal = replaceStr(obj.value, '-', '');	//- 제거
	
	// '-' 제거된 카드번호가 13자리임
	if(tmpVal.length != 0) {
		if(tmpVal.length < 13) {
			alert("카드번호의 길이가 13자리를 보다 짧습니다.");
			obj.focus();
			obj.select();
		} else if(tmpVal.length > 13) {
			alert("카드번호는 13Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
			obj.value = (obj.value).substring(0,13);
			obj.focus();
			obj.select();
		} else {
			obj.value = fn_getCardNo(obj.value);
		}
	}
}

//카드 번호에 포커스가 왔을경우
function fn_focusCardNo(obj) {
	if(obj.value.length>0) {
		obj.value = replaceStr(obj.value, '-', '');	//- 제거
	}
}

//달력 '/' 처리
function fn_getDateFormat(val) {
	var rtnVal = "";
	if(val.indexOf("/")<1) {
		rtnVal = val.substr(0, 4) + "/" + val.substr(4, 2) + "/" + val.substr(6, 2);
	}
	return rtnVal;
}


function fn_getDetailList(idx) {

	gsInsertChk = 2;	//조회 셋텡

	var param = "&goTo=getDetailList"
			  + "&strcd=" 				+ document.getElementById("strcd").value
			  + "&vencd="              	+ document.getElementById("vencd").value
			  + "&reguCustId="         	+ document.getElementById("REGUCUST_ID"+idx).value
			  + "&seqNo=" 	        	+ document.getElementById("SEQ_NO"+idx).value;

	var Urleren = "/edi/esal110.es";
	
	
	
	
	URL = Urleren + "?" +param;
	
	strMst = getXMLHttpRequest();
	strMst.onreadystatechange = responseGetDetailList;
	strMst.open("GET", URL, true);
	strMst.send(null);
}

function responseGetDetailList() {
	if(strMst.readyState==4)
	{
		if(strMst.status == 200)
		{
			strMst = eval(strMst.responseText);

			if( strMst == undefined ){
				//데이터가 없을 때 시스템 오류
				showMessage(StopSign, OK, "USER-1034", "", "");
			} else if( strMst.length > 1 ) {
				//데이터가 1건보다 많을 때 시스템 오류
				showMessage(StopSign, OK, "USER-1034", "", "");

			} else if( strMst.length == 1 ) {

				fn_init("");	//상세 정보 enable 처리

				//document.getElementById("IN_STR_CD").value = strMst[0].STR_CD;
				//document.getElementById("IN_VEN_CD").value = strMst[0].VEN_CD;

				document.getElementById("IN_CARD_NO").value = fn_getCardNo(strMst[0].CARD_NO);	//카드번호
				document.getElementById("IN_CUST_NAME").value = strMst[0].CUST_NAME;			//성명
				document.getElementById("IN_CUST_ID").value = strMst[0].CUST_ID;			//고객번호
				document.getElementById("IN_BIRTH_DT").value = strMst[0].BIRTH_DT;				//생년월일
				document.getElementById("IN_WED_DT").value = strMst[0].WED_DT;					//결혼기념일
				//document.getElementById("IN_HOME_NEW_YN").value = strMst[0].HOME_NEW_YN;		//구주소체계 N
				document.getElementById("IN_HOME_ZIP_CD1").value = strMst[0].HOME_ZIP_CD1;		//자택주소 우편번호1
				document.getElementById("IN_HOME_ZIP_CD2").value = strMst[0].HOME_ZIP_CD2;		//자택주소 우편번호2
				document.getElementById("IN_HOME_ADDR1").value = strMst[0].HOME_ADDR1;			//자택주소1
				document.getElementById("IN_HOME_ADDR2").value = strMst[0].HOME_ADDR2;			//자택주소2
				document.getElementById("IN_HOME_PH1").value = strMst[0].HOME_PH1;				//자택전화1
				document.getElementById("IN_HOME_PH2").value = strMst[0].HOME_PH2;				//자택전화2
				document.getElementById("IN_HOME_PH3").value = strMst[0].HOME_PH3;				//자택전화3
				document.getElementById("IN_MOBILE_PH1").value = strMst[0].MOBILE_PH1;			//핸드폰번호1
				document.getElementById("IN_MOBILE_PH2").value = strMst[0].MOBILE_PH2;			//핸드폰번호2
				document.getElementById("IN_MOBILE_PH3").value = strMst[0].MOBILE_PH3;			//핸드폰번호3
				//document.getElementById("IN_OFFI_NEW_YN").value = strMst[0].OFFI_NEW_YN;		//구 주소체계 N
				document.getElementById("IN_OFFI_ZIP_CD1").value = strMst[0].OFFI_ZIP_CD1;		//직장주소 우편번호1
				document.getElementById("IN_OFFI_ZIP_CD2").value = strMst[0].OFFI_ZIP_CD2;		//직장주소 우편번호2
				document.getElementById("IN_OFFI_ADDR1").value = strMst[0].OFFI_ADDR1;			//직장주소1
				document.getElementById("IN_OFFI_ADDR2").value = strMst[0].OFFI_ADDR2;			//직장주소1
				document.getElementById("IN_OFFI_PH1").value = strMst[0].OFFI_PH1;				//직장전화번호1
				document.getElementById("IN_OFFI_PH2").value = strMst[0].OFFI_PH2;				//직장전화번호2
				document.getElementById("IN_OFFI_PH3").value = strMst[0].OFFI_PH3;				//직장전화번호3
				//document.getElementById("IN_OFFI_INTER_PH").value = strMst[0].OFFI_INTER_PH;	//직장내선번호(안씀)
				document.getElementById("IN_OFFI_FAX1").value = strMst[0].OFFI_FAX1;			//직장팩스번호1
				document.getElementById("IN_OFFI_FAX2").value = strMst[0].OFFI_FAX2;			//직장팩스번호2
				document.getElementById("IN_OFFI_FAX3").value = strMst[0].OFFI_FAX3;			//직장팩스번호3
				document.getElementById("IN_HOBBY").value = strMst[0].HOBBY;					//취미
				document.getElementById("TEXT_SALEAMT").value = strMst[0].TEXT_SALEAMT;				//3개월매출
				document.getElementById("IN_RELIGION").value = strMst[0].RELIGION;				//종교
				document.getElementById("IN_REG_DATE").value = strMst[0].REG_DATE;				//등록일
				document.getElementById("IN_ETC").value = strMst[0].ETC;						//기타
				document.getElementById("IN_FAMILY1").value = strMst[0].FAMILY1;				//가족사항1
				document.getElementById("IN_FAMILY1_NM").value = strMst[0].FAMILY1_NM;			//가족사항1 이름
				document.getElementById("IN_FAMILY2").value = strMst[0].FAMILY2;				//가족사항2
				document.getElementById("IN_FAMILY2_NM").value = strMst[0].FAMILY2_NM;			//가족사항2 이름
				document.getElementById("IN_FAMILY3").value = strMst[0].FAMILY3;				//가족사항3
				document.getElementById("IN_FAMILY3_NM").value = strMst[0].FAMILY3_NM;			//가족사항3 이름
				document.getElementById("IN_FAMILY4").value = strMst[0].FAMILY4;				//가족사항4
				document.getElementById("IN_FAMILY4_NM").value = strMst[0].FAMILY4_NM;			//가족사항4 이름
				document.getElementById("IN_ETC2").value = strMst[0].ETC2;						//특이사항
				document.getElementById("IN_EMAIL1").value = strMst[0].EMAIL1;					//이메일1
				document.getElementById("IN_EMAIL2").value = strMst[0].EMAIL2;					//이메일2
				document.getElementById("IN_REGUCUST_ID").value = strMst[0].REGUCUST_ID;		//단골고객번호
				document.getElementById("IN_SEQ_NO").value = strMst[0].SEQ_NO;					//순번

				//콤보박스, 라디오버튼 처리
				fn_setCombo("IN_PUMBUN_CD", strMst[0].PUMBUN_CD);					//브랜드
				fn_setCombo("IN_DOMAIN_FLAG", strMst[0].DOMAIN_FLAG);				//이메일 직접입력 또는 선택
				fn_setCombo("IN_GRADE_FLAG", strMst[0].GRADE_FLAG);				//등급 콤보
				fn_setRadio("IN_SEX_CD", strMst[0].SEX_CD);							//성별
				fn_setRadio("IN_BIRTH_LUNAR_FLAG", strMst[0].BIRTH_LUNAR_FLAG);		//생일구분
				fn_setRadio("IN_WED_LUNAR_FLAG", strMst[0].WED_LUNAR_FLAG);			//기념일구분
				fn_setRadio("IN_WED_FLAG", strMst[0].WED_FLAG);			//결혼여부
				fn_setRadio("IN_SMS_FLAG", strMst[0].SMS_FLAG);			//문자수신여부
				fn_setRadio("IN_EMAIL_FLAG", strMst[0].EMAIL_FLAG);			//메일수신여부

				//메일 구분
				fn_DomainChange(document.getElementById("IN_DOMAIN_FLAG"));
			}
		}
	}
}

//콤보박스, 라디오 버튼 값 셋팅 처리
function fn_setRadio(objVal, val) {
	var obj = document.getElementsByName(objVal);

	if(val != "") {
		for(var i=0;i<obj.length;i++) {
			if(obj[i].value == val) {
				obj[i].checked = true;
				break;
			}
		}
	}
}

//콤보박스, 라디오 버튼 값 셋팅 처리
function fn_setCombo(objVal, val) {
	var obj = document.getElementById(objVal);

	if(val != "") {
		for(var i=0;i<obj.length;i++) {
			if(obj[i].value == val) {
				obj[i].selected = true;
				break;
			}
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
function getXMLHttpRequest() {
	if(window.ActiveXObject){
		try{
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch(e1) {
			try{
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e2){
				return null;
			}
		}
	} else if(window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}

//삭제
function btn_del() {
	
	if(gsInsertChk==2) {
	
		if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ) return;
		
		var param =	  "&goTo=delete"
					+ "&strcd="					+ strcd
					+ "&vencd="					+ vencd
					+ "&seqNo="					+ document.getElementById("IN_SEQ_NO").value
					+ "&reguCustId="			+ document.getElementById("IN_REGUCUST_ID").value;
		
		<ajax:open callback="on_deletedXML"
			param="param"
			method="POST"
			urlvalue="/edi/esal110.es"/>

		<ajax:callback function="on_deletedXML">
		
		if( rowsNode.length > 0 ){
			var deleteCnt = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
			var RET = rowsNode[0].childNodes[1].childNodes[0].nodeValue;

			showMessage(StopSign, Ok, "USER-1000", RET);	//정상 처리

			if(deleteCnt > 0) {	//정상 삭제시 레프트 리스트 조회
				btn_Search();
			}
		}

		</ajax:callback>
	}
}

//저장
function btn_save() {
	
	var mode = "";

	
	if(chkcardno!=0){		

			mode = "chkcardno";

	} else if (chkcardno == 0){
	//신규시 1(insert), 조회시 2(update)
	if(gsInsertChk==1 || gsInsertChk==2) {

		if(gsInsertChk==1) {
			mode = "insert";
		} else if(gsInsertChk==2) {
			mode = "insert";
		}
		
		//기본값 체크 로직 필요
		//if(!fn_objChk(document.getElementById("IN_CARD_NO"), "카드번호")) return;
		if(!fn_objChk(document.getElementById("IN_CUST_NAME"), "성명")) return;
		//if(!fn_objChk(document.getElementById("IN_BIRTH_DT"), "생년월일")) return;
		
		if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) return;
		var param =	  "&goTo=insert"
					+ "&mode="					+ mode
					+ "&userid="				+ userid
					+ "&strcd="					+ strcd
					+ "&vencd="					+ vencd
					+ "&IN_PUMBUN_CD="			+ document.getElementById("IN_PUMBUN_CD").value
					+ "&IN_BIRTH_DT="			+ replaceStr(document.getElementById("IN_BIRTH_DT").value, '/', '')
					+ "&IN_BIRTH_LUNAR_FLAG="	+ getRadioValue(document.getElementsByName("IN_BIRTH_LUNAR_FLAG"))
					+ "&IN_CARD_NO="			+ replaceStr(document.getElementById("IN_CARD_NO").value, '-', '')
					+ "&IN_CUST_ID="			+ document.getElementById("IN_CUST_ID").value
					+ "&IN_CUST_NAME="			+ encodeURIComponent(document.getElementById("IN_CUST_NAME").value)
					+ "&IN_DOMAIN_FLAG="		+ document.getElementById("IN_DOMAIN_FLAG").value
					+ "&IN_EMAIL1="				+ document.getElementById("IN_EMAIL1").value
					+ "&IN_EMAIL2="				+ document.getElementById("IN_EMAIL2").value
					+ "&IN_ETC="				+ encodeURIComponent(document.getElementById("IN_ETC").value)
					+ "&IN_ETC2="				+ encodeURIComponent(document.getElementById("IN_ETC2").value)
					+ "&IN_FAMILY1="			+ encodeURIComponent(document.getElementById("IN_FAMILY1").value)
					+ "&IN_FAMILY1_NM="			+ encodeURIComponent(document.getElementById("IN_FAMILY1_NM").value)
					+ "&IN_FAMILY2="			+ encodeURIComponent(document.getElementById("IN_FAMILY2").value)
					+ "&IN_FAMILY2_NM="			+ encodeURIComponent(document.getElementById("IN_FAMILY2_NM").value)
					+ "&IN_FAMILY3="			+ encodeURIComponent(document.getElementById("IN_FAMILY3").value)
					+ "&IN_FAMILY3_NM="			+ encodeURIComponent(document.getElementById("IN_FAMILY3_NM").value)
					+ "&IN_FAMILY4="			+ encodeURIComponent(document.getElementById("IN_FAMILY4").value)
					+ "&IN_FAMILY4_NM="			+ encodeURIComponent(document.getElementById("IN_FAMILY4_NM").value)
					+ "&IN_HOBBY="				+ encodeURIComponent(document.getElementById("IN_HOBBY").value)
					+ "&IN_HOME_ADDR1="			+ encodeURIComponent(document.getElementById("IN_HOME_ADDR1").value)
					+ "&IN_HOME_ADDR2="			+ encodeURIComponent(document.getElementById("IN_HOME_ADDR2").value)
					+ "&IN_HOME_PH1="			+ document.getElementById("IN_HOME_PH1").value
					+ "&IN_HOME_PH2="			+ document.getElementById("IN_HOME_PH2").value
					+ "&IN_HOME_PH3="			+ document.getElementById("IN_HOME_PH3").value
					+ "&IN_HOME_ZIP_CD1="		+ document.getElementById("IN_HOME_ZIP_CD1").value
					+ "&IN_HOME_ZIP_CD2="		+ document.getElementById("IN_HOME_ZIP_CD2").value
					+ "&IN_MOBILE_PH1="			+ document.getElementById("IN_MOBILE_PH1").value
					+ "&IN_MOBILE_PH2="			+ document.getElementById("IN_MOBILE_PH2").value
					+ "&IN_MOBILE_PH3="			+ document.getElementById("IN_MOBILE_PH3").value
					+ "&IN_MOD_ID="				+ userid
					+ "&IN_OFFI_ADDR1="			+ encodeURIComponent(document.getElementById("IN_OFFI_ADDR1").value)
					+ "&IN_OFFI_ADDR2="			+ encodeURIComponent(document.getElementById("IN_OFFI_ADDR2").value)
					+ "&IN_OFFI_FAX1="			+ document.getElementById("IN_OFFI_FAX1").value
					+ "&IN_OFFI_FAX2="			+ document.getElementById("IN_OFFI_FAX2").value
					+ "&IN_OFFI_FAX3="			+ document.getElementById("IN_OFFI_FAX3").value
					+ "&IN_OFFI_PH1="			+ document.getElementById("IN_OFFI_PH1").value
					+ "&IN_OFFI_PH2="			+ document.getElementById("IN_OFFI_PH2").value
					+ "&IN_OFFI_PH3="			+ document.getElementById("IN_OFFI_PH3").value
					+ "&IN_OFFI_ZIP_CD1="		+ document.getElementById("IN_OFFI_ZIP_CD1").value
					+ "&IN_OFFI_ZIP_CD2="		+ document.getElementById("IN_OFFI_ZIP_CD2").value
					+ "&IN_REG_ID="				+ userid
					+ "&IN_RELIGION="			+ encodeURIComponent(document.getElementById("IN_RELIGION").value)
					+ "&IN_SEX_CD="				+ getRadioValue(document.getElementsByName("IN_SEX_CD"))
					+ "&IN_WED_DT="				+ replaceStr(document.getElementById("IN_WED_DT").value, '/', '')
					+ "&IN_WED_LUNAR_FLAG="		+ "S"// 현업 요청으로 인한 삭제 - 무조건 양력으로 설정 getRadioValue(document.getElementsByName("IN_WED_LUNAR_FLAG"))
					+ "&IN_WED_FLAG="			+ getRadioValue(document.getElementsByName("IN_WED_FLAG"))
					+ "&IN_REGUCUST_ID=" 		+ document.getElementById("IN_REGUCUST_ID").value
					+ "&IN_SMS_FLAG=" 			+ getRadioValue(document.getElementsByName("IN_SMS_FLAG")) 
					+ "&IN_EMAIL_FLAG=" 		+ getRadioValue(document.getElementsByName("IN_EMAIL_FLAG"))
					+ "&IN_GRADE_FLAG=" 		+ document.getElementById("IN_GRADE_FLAG").value
					+ "&IN_SEQ_NO=" 			+ document.getElementById("IN_SEQ_NO").value
					+ "&TEXT_SALEAMT="           + document.getElementById("TEXT_SALEAMT").value
				

		<ajax:open callback="on_insertedXML"
			param="param"
			method="POST"
			urlvalue="/edi/esal110.es"/>

		<ajax:callback function="on_insertedXML">

			if( rowsNode.length > 0 ){
				var insert1 = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
				var insert2 = rowsNode[0].childNodes[1].childNodes[0].nodeValue;
				var RET = rowsNode[0].childNodes[2].childNodes[0].nodeValue;

				showMessage(StopSign, Ok, "USER-1000", RET);	//정상 처리

				if(insert1 > 0) {	//정상 등록시 레프트 리스트 조회
					btn_Search();
				}
			}

		</ajax:callback>
	}
  }
}

//필수 데이터 체크
function fn_objChk(obj, objName) {
	if(obj.value == "") {
		showMessage(StopSign, Ok, "USER-1003", objName);
		obj.focus();
		obj.select();
		return false;
	} else {
		return true;
	}
}

function getRadioValue(obj) {
	var rtnVal = "";
	for(var i=0;i<obj.length;i++) {
		if(obj[i].checked == true) {
			rtnVal = obj[i].value;
			break;
		}
	}
	return rtnVal;
}


//타이틀과 내용 스크롤 고정
function scrollAll(){
	document.all.DivListTitle.scrollLeft = document.all.DivListContent.scrollLeft;
}
function scrollAll2(){
	document.all.DETAIL_Title.scrollLeft = document.all.DETAIL_CONTETN.scrollLeft;
}

//숫자 체크
function fn_NumChk() {
	if(event.keyCode < 45 || event.keyCode > 57)
		event.returnValue = false
}

//핸드폰 앞자리 3자리 체크
function fn_mobilePhoneNumChk(obj) {
//	firstTelFormatAll(document.getElementById("m_phone1").value);
	var strPhone1 = obj.value;
	if(strPhone1.length ==3) {
		if(strPhone1 == "010" || strPhone1 == "011" || strPhone1 == "016" || strPhone1 == "017" || strPhone1 == "018" || strPhone1 == "019") {

		}
		else {
			if(strPhone1.length == 0) {
			//	alert();
				return;
			}
			showMessage(StopSign, Ok, "USER-1000", "핸드폰 번호를 확인하세요");
			obj.focus();
			return;
		}
	}
}

//지역번호 앞자리 3자리 체크
function fn_phoneNumChk(obj) {
	if(trim(obj.value) != "" && firstTelFormatAll2(obj) == false){
		showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
		obj.focus();
		obj.select();
		return false;
	}
}

//각 셋팅값 초기화
function fn_init(disabled) {
	var contents = document.getElementsByName("contents");

	//고객 등록정보 enabled 처리
	for(var j=0;j<contents.length;j++){ // 배송정보
		contents[j].disabled = disabled;
		contents[j].value = "";
	}
	//미혼 체크 상태시 결혼일자 수정불가
	if(getRadioValue(document.getElementsByName("IN_WED_FLAG")) == "0"){
		document.getElementById("IN_WED_DT").value = "";
		document.getElementById("IN_WED_DT").disabled = "disabled";
		document.getElementById("IN_WED_DT_BTN").disabled = "disabled";
	}
	
	//라디오 enabled 처리(성별, 생일구분, 기념일구분)
	fn_radioInit(document.getElementsByName("IN_SEX_CD"), disabled);
	fn_radioInit(document.getElementsByName("IN_BIRTH_LUNAR_FLAG"), disabled);
	fn_radioInit(document.getElementsByName("IN_WED_FLAG"), disabled);
	fn_radioInit(document.getElementsByName("IN_SMS_FLAG"), disabled);
	fn_radioInit(document.getElementsByName("IN_EMAIL_FLAG"), disabled);
	//fn_radioInit(document.getElementsByName("IN_WED_LUNAR_FLAG"), disabled);

	//콤보 박스 초기화
	document.getElementById("IN_PUMBUN_CD").disabled = disabled;
	document.getElementById("IN_DOMAIN_FLAG").disabled = disabled;
	document.getElementById("IN_GRADE_FLAG").disabled = disabled;

	// 그외 객체 데이터 초기화
	initDateText("TODAY", "IN_REG_DATE");	//등록일

	document.getElementById("TEXT_SALEAMT").disabled = disabled;	//3개월매출
	document.getElementById("TEXT_SALEAMT").value = "";		//3개월매출
	document.getElementById("IN_HOME_ZIP_CD1").value = "";	//자택우편번호1
	document.getElementById("IN_HOME_ZIP_CD2").value = "";	//자택우편번호2
	document.getElementById("IN_OFFI_ZIP_CD1").value = "";	//직장우편번호1
	document.getElementById("IN_OFFI_ZIP_CD2").value = "";	//직장우편번호2
	
	document.getElementById("IN_REGUCUST_ID").value = "";	//직장우편번호2

	document.getElementById("IN_PUMBUN_CD")[0].selected = true;
	
	
}

//라디오 버튼 초기화
function fn_radioInit(obj, disabled) {
	for(var i=0;i<obj.length;i++) {
		obj[i].disabled = disabled;
	}

	obj[0].checked = true;
}

function fn_DomainChange(obj) {
	if(obj.value == '99') {
		document.getElementById("IN_EMAIL2").disabled = "";
	} else {
		document.getElementById("IN_EMAIL2").disabled = "disabled";
		document.getElementById("IN_EMAIL2").value = "";
	}
}

/**
* getPostPop()
* 작 성 자 : SBCHO
* 작 성 일 : 2012. 06. 26
* 개    요 : 우편번호 팝업
* 사용방법 : getPostPop(objCd, objNm1,objNm2)
*            arguments[0] -> C - 카드번호 조회(기존 고객 리스트에서 조회), N - 성명 조회(단골 고객 리스트에서 조회)
* return값 : array
*/

function getReguListPop(mode)
{
	
	
    var rtnMap  = new Map();
    var arrArg  = new Array();
    var strVal = "";
    var strPost1 = "";
    var strPost2 = "";

    arrArg.push(rtnMap);
    arrArg.push(mode);

    var returnVal = window.showModalDialog("/edi/esal110.es?goTo=getReguPop",
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:460px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		var map = arrArg[0];
		
		strVal = getRawZip(map.get("searchID"));	//mode - C : 고객번호, N : 단골고객번호
		
		var param = "&goTo=getReguList"
				  + "&searchID=" + strVal
				  + "&mode=" + mode;
		
		var Urleren = "/edi/esal110.es";
		URL = Urleren + "?" +param;

		strMst = getXMLHttpRequest();
		strMst.onreadystatechange = responseGetReguList;
		strMst.open("GET", URL, true);
		strMst.send(null);

 	}
}

function WED_CHECK(type){
	//fn_radioInit(document.getElementsByName("IN_WED_FLAG"), "true");
	if(type == "0"){
		document.getElementById("IN_WED_DT").value = "";
		document.getElementById("IN_WED_DT").disabled = "disabled";
		document.getElementById("IN_WED_DT_BTN").disabled = "disabled";
	}else{
		document.getElementById("IN_WED_DT").disabled = "";
		document.getElementById("IN_WED_DT_BTN").disabled = "";
	}
	//alert(getRadioValue(document.getElementsByName("IN_WED_FLAG")));
}

//결과 처리
function responseGetReguList() {
	if(strMst.readyState==4)
	{
		if(strMst.status == 200)
		{
			strMst = eval(strMst.responseText);

			if( strMst == undefined ){
				//데이터가 없을 때 시스템 오류
				showMessage(StopSign, OK, "USER-1034", "", "");
			} else if( strMst.length > 1 ) {
				//데이터가 1건보다 많을 때 시스템 오류
				showMessage(StopSign, OK, "USER-1034", "", "");

			} else if( strMst.length == 1 ) {

				fn_init("");	//상세 정보 enable 처리

				document.getElementById("IN_CARD_NO").value = fn_getCardNo(strMst[0].CARD_NO);	//카드번호
				document.getElementById("IN_CUST_ID").value = strMst[0].CUST_ID;	//카드번호
				document.getElementById("IN_CUST_NAME").value = strMst[0].CUST_NAME;			//성명
				document.getElementById("IN_BIRTH_DT").value = strMst[0].BIRTH_DT;				//생년월일
				document.getElementById("IN_WED_DT").value = strMst[0].WED_DT;					//결혼기념일
				document.getElementById("IN_HOME_ZIP_CD1").value = strMst[0].HOME_ZIP_CD1;		//자택주소 우편번호1
				document.getElementById("IN_HOME_ZIP_CD2").value = strMst[0].HOME_ZIP_CD2;		//자택주소 우편번호2
				document.getElementById("IN_HOME_ADDR1").value = strMst[0].HOME_ADDR1;			//자택주소1
				document.getElementById("IN_HOME_ADDR2").value = strMst[0].HOME_ADDR2;			//자택주소2
				document.getElementById("IN_HOME_PH1").value = strMst[0].HOME_PH1;				//자택전화1
				document.getElementById("IN_HOME_PH2").value = strMst[0].HOME_PH2;				//자택전화2
				document.getElementById("IN_HOME_PH3").value = strMst[0].HOME_PH3;				//자택전화3
				document.getElementById("IN_MOBILE_PH1").value = strMst[0].MOBILE_PH1;			//핸드폰번호1
				document.getElementById("IN_MOBILE_PH2").value = strMst[0].MOBILE_PH2;			//핸드폰번호2
				document.getElementById("IN_MOBILE_PH3").value = strMst[0].MOBILE_PH3;			//핸드폰번호3
				document.getElementById("IN_OFFI_ZIP_CD1").value = strMst[0].OFFI_ZIP_CD1;		//직장주소 우편번호1
				document.getElementById("IN_OFFI_ZIP_CD2").value = strMst[0].OFFI_ZIP_CD2;		//직장주소 우편번호2
				document.getElementById("IN_OFFI_ADDR1").value = strMst[0].OFFI_ADDR1;			//직장주소1
				document.getElementById("IN_OFFI_ADDR2").value = strMst[0].OFFI_ADDR2;			//직장주소1
				document.getElementById("IN_OFFI_PH1").value = strMst[0].OFFI_PH1;				//직장전화번호1
				document.getElementById("IN_OFFI_PH2").value = strMst[0].OFFI_PH2;				//직장전화번호2
				document.getElementById("IN_OFFI_PH3").value = strMst[0].OFFI_PH3;				//직장전화번호3
				document.getElementById("IN_OFFI_FAX1").value = strMst[0].OFFI_FAX1;			//직장팩스번호1
				document.getElementById("IN_OFFI_FAX2").value = strMst[0].OFFI_FAX2;			//직장팩스번호2
				document.getElementById("IN_OFFI_FAX3").value = strMst[0].OFFI_FAX3;			//직장팩스번호3
				document.getElementById("IN_HOBBY").value = strMst[0].HOBBY;					//취미
				document.getElementById("IN_RELIGION").value = strMst[0].RELIGION;				//종교
				document.getElementById("IN_ETC").value = strMst[0].ETC;						//기타
				document.getElementById("IN_FAMILY1").value = strMst[0].FAMILY1;				//가족사항1
				document.getElementById("IN_FAMILY1_NM").value = strMst[0].FAMILY1_NM;			//가족사항1 이름
				document.getElementById("IN_FAMILY2").value = strMst[0].FAMILY2;				//가족사항2
				document.getElementById("IN_FAMILY2_NM").value = strMst[0].FAMILY2_NM;			//가족사항2 이름
				document.getElementById("IN_FAMILY3").value = strMst[0].FAMILY3;				//가족사항3
				document.getElementById("IN_FAMILY3_NM").value = strMst[0].FAMILY3_NM;			//가족사항3 이름
				document.getElementById("IN_FAMILY4").value = strMst[0].FAMILY4;				//가족사항4
				document.getElementById("IN_FAMILY4_NM").value = strMst[0].FAMILY4_NM;			//가족사항4 이름
				document.getElementById("IN_EMAIL1").value = strMst[0].EMAIL1;					//이메일1
				document.getElementById("IN_EMAIL2").value = strMst[0].EMAIL2;					//이메일2
				document.getElementById("IN_REGUCUST_ID").value = strMst[0].REGUCUST_ID;		//단골고객번호
				document.getElementById("TEXT_SALEAMT").value = strMst[0].TEXT_SALEAMT;              //3개월매출
				
				
				//콤보박스, 라디오버튼 처리
				fn_setRadio("IN_SEX_CD", strMst[0].SEX_CD);							//성별
				fn_setRadio("IN_BIRTH_LUNAR_FLAG", strMst[0].BIRTH_LUNAR_FLAG);		//생일구분
				//fn_setRadio("IN_WED_LUNAR_FLAG", strMst[0].WED_LUNAR_FLAG);			//기념일구분
			}
		}
	}
}

--></script>

<body class="PL10 PT15" onload="doinit();">
<table width="97%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05" /> 단골고객등록</td>
				<td>
					<table border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/edi/imgs/btn/search.gif" width="50" height="22" id="search" 	onclick="btn_Search();" /></td>
							<td><img src="/edi/imgs/btn/new.gif" 	width="50" height="22" id="newrow" 	onclick="btn_new();" /></td>
							<td><img src="/edi/imgs/btn/del.gif" 	width="50" height="22" id="del" 	onclick="btn_del();"/></td>
							<td><img src="/edi/imgs/btn/save.gif" 	width="50" height="22" id="save" 	onclick="btn_save();" /></td>
							<td><img src="/edi/imgs/btn/excel.gif" 	width="61" height="22" id="excel" /></td>
							<td><img src="/edi/imgs/btn/print.gif" 	width="50" height="22" id="prints" /></td>
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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td width="140">
							<input type="text" name="strnm" id="strnm" size="20" value="<%=strNm%>" disabled="disabled" />
							<input type="hidden" name="strcd" id="strcd" value="<%=strcd%>" />
						</td>
						<th width="80" class="point input_pk">협력사코드</th>
						<td width="140">
							<input type="text" name="venNM" id="venNM" size="20" value="<%=venNm%>" disabled="disabled" />
							<input type="hidden" name="vencd" id="vencd" value="<%=vencd%>" />
						</td>
						<th class="point">브랜드코드</th>
						<td colspan="3"><select name="pubumCd" id="pubumCd" style="width: 193;"></select></td>
					</tr>
					<tr>
						<th width="80">고객명</th>
						<td width="140">
							<input type="text" name="custName" id="custName" size="20" onkeyup="checkByteLength(this, 40);" />
						</td>
						<th width="80"></th>
						<td width="140">
							<input type="hidden" name="cardNo" id="cardNo" size="20" onkeyup="checkByteLength(this, 13);" />
						</td>
						<th width="80">등록일</th>
						<td colspan="3">
							<input type="text" name="em_S_Date" id="em_S_Date" size="10" title="YYYY/MM/DD" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this, this.value);" onfocus="dateValid(this);" style='text-align: center; IME-MODE: disabled' />
							&nbsp;<img src="<%=dir%>/imgs/icon/ico_calender.gif" alt="시작일" align="absmiddle" onclick="openCal('G',em_S_Date);return false;" />
							&nbsp;~&nbsp;<input type="text" name="em_E_Date" id="em_E_Date" size="10" maxlength="10" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this, this.value);" onfocus="dateValid(this);" style='text-align: center; IME-MODE: disabled' />
							&nbsp;<img src="<%=dir%>/imgs/icon/ico_calender.gif" alt="종료일" align="absmiddle" onclick="openCal('G',em_E_Date);return false;" />
						</td>
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

	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="250">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
					<tr valign="top">
						<td>
							<div id="DivListTitle" style="width: 250px; overflow: hidden;">
								<table width="250" border="0" cellpadding="0" cellspacing="0" class="g_table">
									<tr>
										<th width="100">고객명</th>
										<th width="150">생년월일</th>
										<!--  <th width="115">카드번호</th>
										<th width="90">핸드폰번호</th>
										<th width="65">등록일</th>
										<th width="15">&nbsp;</th>-->
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="DivListContent" style="width: 250px; height: 462px; overflow: scroll" onscroll="scrollAll();">
								<table width="230" border="0" cellspacing="0" cellpadding="0" class="g_table" id="tb_list">
									<tr>
										<td width="100" align="center"></td>
										<td width="130" align="center"></td>
										<!--  <td width="115" align="center"></td>
										<td width="90" align="center"></td>
										<td width="65" align="center"></td> -->
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
				</td>
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PB03">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
										<tr>
											<th class="right" width="80"></th>
											<td width="160">
												<input type="hidden" name="contents" id="IN_CARD_NO" size="18" disabled="disabled" onfocus="fn_focusCardNo(this)" onblur="fn_blurCardNo(this);" />
												<!-- <img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="카드번호" align="absmiddle" disabled="disabled" onclick="javascript:getReguListPop('C');" name="contents" /> 2013-01-29 고정고객관련 서우석대리 요청 -->
												<input type="hidden" name="IN_REGUCUST_ID" id="IN_REGUCUST_ID" />
												<input type="hidden" name="IN_SEQ_NO" id="IN_SEQ_NO" />
											</td>
											<th  width="80" class="right_point"><img src="/edi/imgs/comm/point.gif" style="Border:solid 0px #b4d0e1; background-color:#ebf2f8;" />브랜드</th>
											<td colspan="2">
												<select name="IN_PUMBUN_CD" id="IN_PUMBUN_CD" class="combo_pk" disabled="disabled" onchange="getpumbunGbBu();" style="width: 160;">
												</select>
											</td>
										</tr>
										<tr>
											<th class="right_point"><img src="/edi/imgs/comm/point.gif" style="Border:solid 0px #b4d0e1; background-color:#ebf2f8;" />성명</th>
											<td>
												<input type="text" name="contents" id="IN_CUST_NAME" size="10" onkeyup="checkByteLength(this, 40);" disabled="disabled" />
												<input type="hidden" name="IN_CUST_ID" id="IN_CUST_ID" />
												<!-- <img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="성명" align="absmiddle" disabled="disabled" onclick="javascript:getReguListPop('N');" name="contents" /> 2013-01-29 고정고객관련 서우석대리 요청-->
											</td>
											<th class="right_point"><img src="/edi/imgs/comm/point.gif" style="Border:solid 0px #b4d0e1; background-color:#ebf2f8;" />성별</th>
											<td colspan="2">
												<input type="radio" name="IN_SEX_CD" id="IN_SEX_CD" value="M" disabled="disabled" checked />남&nbsp;
												<input type="radio" name="IN_SEX_CD" id="IN_SEX_CD" value="F" disabled="disabled" />여
											</td>
										</tr>
										<tr>
											<th class="right"><img src="/edi/imgs/comm/point.gif" style="Border:solid 0px #b4d0e1; background-color:#ebf2f8;" />생년월일</th>
											<td>
												<input type="text" name="contents" id="IN_BIRTH_DT" size="10" maxlength="10" disabled="disabled" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  tabindex="1" style='text-align:center;IME-MODE: disabled' />
												<img src="<%=dir%>/imgs/btn/date.gif" alt="생년월일" align="absmiddle" disabled="disabled" onclick="openCal('G',IN_BIRTH_DT);return false;" name="contents" />
											</td>
											<th class="right"><img src="/edi/imgs/comm/point.gif" style="Border:solid 0px #b4d0e1; background-color:#ebf2f8;" />생일구분</th>
											<td	colspan="2">
												<input type="radio" name="IN_BIRTH_LUNAR_FLAG" id="IN_BIRTH_LUNAR_FLAG" value="S" disabled="disabled" checked/>양력&nbsp;
												<input type="radio" name="IN_BIRTH_LUNAR_FLAG" id="IN_BIRTH_LUNAR_FLAG" value="L" disabled="disabled" />음력
											</td>
										</tr>
										<tr>
											<th class="right">결혼여부</th>
											<td>
												<input type="radio" name="IN_WED_FLAG" id="IN_WED_FLAG" value="0" disabled="disabled" checked="checked" onclick="javascript:WED_CHECK(0);"/>미혼&nbsp;
												<input type="radio" name="IN_WED_FLAG" id="IN_WED_FLAG" value="1" disabled="disabled" onclick="javascript:WED_CHECK(1);"/>기혼
											</td>
											<th class="right">결혼기념일</th>
											<td colspan="2">
												<input type="text" name="contents" id="IN_WED_DT" size="10" maxlength="10" disabled="disabled" onkeypress="javascript:onlyNumber();" onblur="dateCheck(this);" onfocus="dateValid(this);"  tabindex="1" style='text-align:center;IME-MODE: disabled' />
												<img src="<%=dir%>/imgs/btn/date.gif" alt="결혼기념일" align="absmiddle" disabled="disabled"  onclick="openCal('G',IN_WED_DT);return false;" name="contents" id="IN_WED_DT_BTN"/>
											<!--  현업 요청으로 인한 삭제 20121113 - 무조건 양력으로 설정 
												<input type="radio" name="IN_WED_LUNAR_FLAG" id="IN_WED_LUNAR_FLAG" value="S" disabled="disabled" checked />양력&nbsp;
												<input type="radio" name="IN_WED_LUNAR_FLAG" id="IN_WED_LUNAR_FLAG" value="L" disabled="disabled" />음력
											-->
											</td>
										</tr>
										<tr>
											<th class="right" rowspan="2">자택주소</th>
											<td colspan="4">
												<input type="text" name="IN_HOME_ZIP_CD1" id="IN_HOME_ZIP_CD1" size="3" maxlength="3" disabled="disabled" onclick="javascript:getPostPop2('IN_HOME_ZIP_CD1', 'IN_HOME_ZIP_CD2', 'IN_HOME_ADDR1', 'IN_HOME_ADDR2');" />&nbsp;-&nbsp;
												<input type="text" name="IN_HOME_ZIP_CD2" id="IN_HOME_ZIP_CD2" size="3" maxlength="3" disabled="disabled" onclick="javascript:getPostPop2('IN_HOME_ZIP_CD1', 'IN_HOME_ZIP_CD2', 'IN_HOME_ADDR1', 'IN_HOME_ADDR2');" />&nbsp;
												<img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="우편번호" align="absmiddle" disabled="disabled" onclick="javascript:getPostPop2('IN_HOME_ZIP_CD1', 'IN_HOME_ZIP_CD2', 'IN_HOME_ADDR1', 'IN_HOME_ADDR2');" name="contents" />
											</td>
										</tr>
										<tr>
											<td>
												<input type="text" name="contents" id="IN_HOME_ADDR1" size="24" maxlength="100" disabled="disabled" />

											</td>
											<td colspan="3">
												<input type="text" name="contents" id="IN_HOME_ADDR2" size="43" maxlength="100" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<th class="right">자택전화</th>
											<td>
												<input type="text" name="contents" id="IN_HOME_PH1" size="3" maxlength="3" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" onblur="javascript:fn_phoneNumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_HOME_PH2" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_HOME_PH3" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />
											</td>
											<th class="right">핸드폰번호</th>
											<td colspan="2">
												<input type="text" name="contents" id="IN_MOBILE_PH1" size="3" maxlength="3" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" onblur="javascript:fn_mobilePhoneNumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_MOBILE_PH2" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_MOBILE_PH3" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />
											</td>
										</tr>
										<tr>
											<th class="right" rowspan="2">직장주소</th>
											<td colspan="4">
												<input type="text" name="IN_OFFI_ZIP_CD1" id="IN_OFFI_ZIP_CD1" size="3" maxlength="3" disabled="disabled" onclick="javascript:getPostPop2('IN_OFFI_ZIP_CD1', 'IN_OFFI_ZIP_CD2', 'IN_OFFI_ADDR1', 'IN_OFFI_ADDR2');" />&nbsp;-&nbsp;
												<input type="text" name="IN_OFFI_ZIP_CD2" id="IN_OFFI_ZIP_CD2" size="3" maxlength="3" disabled="disabled" onclick="javascript:getPostPop2('IN_OFFI_ZIP_CD1', 'IN_OFFI_ZIP_CD2', 'IN_OFFI_ADDR1', 'IN_OFFI_ADDR2');" />&nbsp;
												<img src="<%=dir%>/imgs/btn/detail_search_s.gif" alt="우편번호" align="absmiddle" disabled="disabled" onclick="javascript:getPostPop2('IN_OFFI_ZIP_CD1', 'IN_OFFI_ZIP_CD2', 'IN_OFFI_ADDR1', 'IN_OFFI_ADDR2');" name="contents" />
											</td>
										</tr>
										<tr>
											<td>
												<input type="text" name="contents" id="IN_OFFI_ADDR1" size="24" onkeyup="checkByteLength(this, 200);" disabled="disabled" />

											</td>
											<td colspan="3">
												<input type="text" name="contents" id="IN_OFFI_ADDR2" size="43" onkeyup="checkByteLength(this, 200);" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<th class="right">직장전화</th>
											<td>
												<input type="text" name="contents" id="IN_OFFI_PH1" size="3" maxlength="3" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" onblur="javascript:fn_phoneNumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_OFFI_PH2" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_OFFI_PH3" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />
											</td>
											<th class="right">FAX번호</th>
											<td colspan="2">
												<input type="text" name="contents" id="IN_OFFI_FAX1" size="3" maxlength="3" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" onblur="javascript:fn_phoneNumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_OFFI_FAX2" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />&nbsp;-&nbsp;
												<input type="text" name="contents" id="IN_OFFI_FAX3" size="4" maxlength="4" disabled="disabled" onKeypress="javascript:fn_NumChk(this);" style="text-align:center;IME-MODE:disabled;" />
											</td>
										</tr>
										<tr>
											<th class="right">E-MAIL</th>
											<td><input type="text" name="contents" id="IN_EMAIL1" size="24" maxlength="64" disabled="disabled" /></td>
											<td colspan="2" style="text-align:right; padding-right:0px;">
												<select name="IN_DOMAIN_FLAG" id="IN_DOMAIN_FLAG" disabled="disabled" class="combo_pk" style="width:80; font-size :11;" onChange="fn_DomainChange(this);"></select>
											</td>
											<td ><input type="text" name="contents" id="IN_EMAIL2" size="24" onkeyup="checkByteLength(this, 128);" disabled="disabled" style="IME-MODE:disabled;" /></td>
										</tr>
										<tr>
											<th class="right">취미</th>
											<td><input type="text" name="contents" id="IN_HOBBY" size="24" onkeyup="checkByteLength(this, 100);" disabled="disabled" /></td>
											<th class="right">종교</th>
											<td colspan="2"><input type="text" name="contents" id="IN_RELIGION" size="24" onkeyup="checkByteLength(this, 100);" disabled="disabled" /></td>
										</tr>
										<tr>
											<th class="right">등록일</th>
											<td>
												<input type="text" name="IN_REG_DATE" id="IN_REG_DATE" size="10" maxlength="10" onkeypress="javascript:onlyNumber();" disabled="disabled" tabindex="1" style='text-align:center;IME-MODE: disabled' />
											</td>
											<th class="right">3개월매출</th>
											<td colspan="2"><input type="text" name="TEXT_SALEAMT" id="TEXT_SALEAMT" size="24" maxlength="40" onKeypress="javascript:fn_NumChk(this);" disabled="disabled" /></td>
										</tr>
										<tr>
											<th class="right">기타</th>
											<td colspan="4"><input type="text" name="contents" id="IN_ETC" size="70" onkeyup="checkByteLength(this, 200);" disabled="disabled" /></td>
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
					<td class="PB03"> 
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
							<th class="right" >등급</th>
								<td>
									<select name="IN_GRADE_FLAG" id="IN_GRADE_FLAG" disabled="disabled" class="combo_pk" style="width:80; font-size :11;"></select>
								</td>
								<th class="right" >SMS 발신</th>
								<td>
									<input type="radio" name="IN_SMS_FLAG" id="IN_SMS_FLAG" value="Y" disabled="disabled" checked/>동의&nbsp;
									<input type="radio" name="IN_SMS_FLAG" id="IN_SMS_FLAG" value="N" disabled="disabled" />비동의	
								</td>
								<th class="right" >E-MAIL 발신</th>
								<td colspan="3">
									<input type="radio" name="IN_EMAIL_FLAG" id="IN_EMAIL_FLAG" value="Y" disabled="disabled" checked/>동의&nbsp;
									<input type="radio" name="IN_EMAIL_FLAG" id="IN_EMAIL_FLAG" value="N" disabled="disabled" />비동의
								</td>
							</tr>
						</table>
						</td>
					</tr>	
					<tr>
						<td class="dot"></td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" height="134">
								<tr>
									<th width="200" colspan="2" class="c1">가족사항</th>
									<th width="" class="c1">특이사항</th>
								</tr>
								<tr>
									<td width="100" class="c1"><input type="text" name="contents" id="IN_FAMILY1" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
									<td width="100" class="c1"><input type="text" name="contents" id="IN_FAMILY1_NM" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
									<td rowspan="4" class="c1">
										<textarea style="height:100%;width:100%;"  name="contents" id="IN_ETC2" tabindex="1"  onkeyup="checkByteLength(this, 200);" disabled="disabled"  ></textarea>
									</td>
								</tr>
								<tr>
									<td class="c1"><input type="text" name="contents" id="IN_FAMILY2" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
									<td class="c1"><input type="text" name="contents" id="IN_FAMILY2_NM" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
								</tr>
								<tr>
									<td class="c1"><input type="text" name="contents" id="IN_FAMILY3" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
									<td class="c1"><input type="text" name="contents" id="IN_FAMILY3_NM" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
								</tr>
								<tr>
									<td class="c1"><input type="text" name="contents" id="IN_FAMILY4" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
									<td class="c1"><input type="text" name="contents" id="IN_FAMILY4_NM" size="16" onkeyup="checkByteLength(this, 40);" disabled="disabled" /></td>
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


