<!--  
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 무기명회원 가입 신청서 등록
 * 작 성 일    : 2010.01.14
 * 작 성 자    : 김영진
 * 수 정 자    : 
 * 파 일 명    : dctm1020.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    : 기명회원 가입 신청서를 등록한다
 * 이       력    :
 *           2010.01.14 (김영진) 신규작성
 *           2010.02.12 (김영진) 기능추가
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
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<%
	//**************************************************************************************************************
	//나이스평가정보 Copyright(c) NICE INFORMATION SERVICE INC. ALL RIGHTS RESERVED
	//
	//서비스명 : 마이핀('내번호') 서비스
	//페이지명 : 마이핀('내번호') 메인 호출 페이지
        //
	//IN : MyPin번호                  OUT : 응답코드(유효성확인), DI
	//IN : MyPin번호, 이름            OUT : 응답코드(실명확인), DI, CI
	//IN : MyPin번호, 생년월일,이름   OUT : 응답코드(연령확인), DI, CI
	//IN : MyPin번호, 생년월일        OUT : 응답코드(연령확인,ARS), DI, CI
	//$ID$
        //**************************************************************************************************************

// 	String enc_data         = "";
// 	String sIDPCODE			= "AC38";		    //고객사이트 구분 ID를 입력해 주세요(나이스평가정보에서 발급한 사이트 ID)
// 	String sIDPPWD			= "11001206";		    //고객사이트 비밀 번호를 입력해 주세요(나이스평가정보에서 발급한 사이트 비밀번호)
// 	String sRETURNURL		= "http://192.168.122.102:8088/dcs/jsp/dctm/dctm1027_mypin.jsp";	//인증을 처리하고 팝업된 창을 닫기 위한 중간 URL
// 	Kisinfo.Check.IPIN2Client pCrypt = new Kisinfo.Check.IPIN2Client();
	
// 	int iResult = pCrypt.fnRequest(sIDPCODE, sIDPPWD, sIDPPWD, sRETURNURL);	//클라이언트 요청 정보 암호화 함수입니다. 
// 						//여기에서 sIDPPWD 는 위 소스와 같이 반드시 2회 입력합니다. 



// 	if (iResult == 0) {							
// 		//위 값이 0인 경우가 암호화 성공한 경우입니다. 
// 		enc_data = pCrypt.getCipherData();
// 		System.out.println("CLIENT enc_data : " + enc_data);
// 	} else if (iResult == -1) { 
// 		//암호화 시스템 오류
// 	} else if (iResult == -2) {                
// 		//암호화 처리 오류
// 	} else if (iResult == -3) {                
// 		//유효하지 않은 요청 데이터
// 	} else if (iResult == -9) {                
// 		//입력 데이타 오류
// 	}
// 	System.out.println("iResult : " + iResult);
// 	//************************************************************************************************************************

//     NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
//     String sSiteCode = "AB404";				// NICE로부터 부여받은 사이트 코드
//     String sSitePassword = "opAw43yU1Qqw";		// NICE로부터 부여받은 사이트 패스워드
    
//     String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
//                                                     	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
//     sRequestNumber = niceCheck.getRequestNO(sSiteCode);
//   	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
//    	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
//    	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
// 	String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
//     // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
// 	String sReturnUrl = "http://192.168.122.102:8088/dcs/jsp/dctm/dctm1027.jsp";
// 	String sErrorUrl = "http://192.168.122.102:8088/dcs/jsp/dctm/dctm1028.jsp";
	
// 	//String sReturnUrl = "http://192.168.122.102:8088/dcs/dctm102.dm?goTo=recvNiceId";
//     //String sErrorUrl = "http://192.168.122.102:8088/dcs/dctm102.dm?goTo=recvNiceId";
	
// 	//String sReturnUrl = "http://192.168.122.102:8088/dcs/jsp/dctm/dctm1027.jsp";      // 성공시 이동될 URL
//     //String sErrorUrl = "http://192.168.122.102:8088/dcs/jsp/dctm/dctm1028.jsp";          // 실패시 이동될 URL

//     // 입력될 plain 데이타를 만든다.
//     String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
//                         "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
//                         "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
//                         "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
//                         "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
//                         "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
//                         "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
//     String sMessage = "";
//     String sEncData = "";
    
//     int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
//     if( iReturn == 0 )
//     {
//         sEncData = niceCheck.getCipherData();
//     }
//     else if( iReturn == -1)
//     {
//         sMessage = "암호화 시스템 에러입니다.";
//     }    
//     else if( iReturn == -2)
//     {
//         sMessage = "암호화 처리오류입니다.";
//     }    
//     else if( iReturn == -3)
//     {
//         sMessage = "암호화 데이터 오류입니다.";
//     }    
//     else if( iReturn == -9)
//     {
//         sMessage = "입력 데이터 오류입니다.";
//     }    
//     else
//     {
//         sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
//     }
%>
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>	
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->



<script LANGUAGE="JavaScript">
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
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
                
                if(data.userSelectedType == 'R')
                	document.getElementById('EM_HOME_NEW_YN').text = 'Y';
                else
                	document.getElementById('EM_HOME_NEW_YN').text = 'N';
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('EM_HOME_ZIP_CD1').text = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('EM_HNEW_ZIP_CD1').text = data.zonecode; //5자리 새우편번호 사용

                document.getElementById('EM_HNEW_ADDR1').text = fullRoadAddr;       // 도로명주소
                document.getElementById('EM_HOME_ADDR1').text = data.jibunAddress;   //지번주소
                
                //document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
				document.getElementById('EM_HNEW_ADDR2').focus();
				
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
</script>
<script LANGUAGE="JavaScript">
<!--
var strFlag = "INS";
var intAge  = 0;  //나이
var strSaveYn = "N";
var strToday  = "<%=toDate%>";

window.name = "Parent_window"; 
function fnPopup2(){
		window.open('', 'popupMYPIN',"left=200, top=100, status=0, width=445, height=550");
		document.form_chk.target = "popupMYPIN";
		document.form_chk.action = "https://cert.vno.co.kr/MYPIN/mypin_ext.cb";
		document.form_chk.submit();
}
function fnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
}

/* 카드번호 자동생성_20160801_강연식 */
function make_cardno(){
		var goTo       = "getcardno" ;
		var action     = "O";
		
		TR_MAIN.Action   = "/dcs/dctm102.dm?goTo="+goTo;
		TR_MAIN.KeyValue = "SERVLET(O:DS_O_CARD=DS_O_CARD)";
		TR_MAIN.Post();
	
	var strCardNo = DS_O_CARD.NameValue(DS_O_CARD.RowPosition, "CARD_NO");
	

	if( strCardNo!=""){
		EM_CARD_NO_S.Text = strCardNo;
	}else {
		showMessage(EXCLAMATION, OK, "USER-1003",  "카드번호 생성오류");
	}
}	
	
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    // Input,Output Data Set Header 초기화
    // 무기명회원가입신청서 등록.
    DS_IO_CUST.setDataHeader  ('<gauce:dataset name="H_CUSTINFO"/>');
    DS_O_CARD.setDataHeader('<gauce:dataset name="H_CARD"/>');
    DS_O_DUPCHK.setDataHeader('<gauce:dataset name="H_DUP_CHK"/>');
    DS_O_SMS_CD.setDataHeader('<gauce:dataset name="H_SMS_CD"/>');
    

    //콤보 초기화
    initComboStyle(LC_STR_CD, DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점
    getStore("DS_S_STR_CD", "N", "", "N");       //점(조회) 
    
    DS_O_DUPCHK.ClearData();
    DS_O_SMS_CD.ClearData();
    
    DS_IO_CUST.ClearData();
    DS_IO_CUST.AddRow();
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드 
    //LC_STR_CD.Index = 0;
    //로그인 사번으로 가입점 세팅 16.12.19  
    LC_STR_CD.BindColVal = strcd; 
    
    // EMedit에 초기화  
    initEmEdit(EM_CUST_NAME,    "GEN^40",     PK);           //성명
    initEmEdit(EM_CHKSAVE,      "GEN^1",      NORMAL);       //저장시에 I,U 구분.
    initEmEdit(EM_CUST_ID,      "GEN",        NORMAL);                              
    initEmEdit(EM_HHOLD_ID,     "GEN",        NORMAL);                                     
    initEmEdit(EM_SS_NO,        "000000",	  PK);       //생년월일/사업자번호

    initEmEdit(EM_HNEW_ADDR1,   "GEN^200",    PK);   
    initEmEdit(EM_HNEW_ADDR2,   "GEN^200",    PK);
    
    initEmEdit(EM_HOME_ADDR1,   "GEN^200",    PK);   
    initEmEdit(EM_HOME_ADDR2,   "GEN^200",    PK);
    
    initEmEdit(EM_CARD_NO_S,    "0000-0000-0000-0000", PK);  //카드번호
    initEmEdit(EM_CARD_NO_CUT,  "00000000",   NORMAL);     //단축 카드번호
    initEmEdit(EM_HNEW_ZIP_CD1, "GEN^5", PK);
    initEmEdit(EM_HNEW_ZIP_CD2, "GEN^5", PK);

    initEmEdit(EM_HOME_ZIP_CD1, "GEN^5", NORMAL);
    initEmEdit(EM_HOME_ZIP_CD2, "GEN^5", NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD1, "GEN^5", NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD2, "GEN^5", NORMAL);
    
    initEmEdit(EM_EMAIL1,       "GEN^50",     NORMAL);
    initEmEdit(EM_EMAIL3,       "GEN^50",     NORMAL);
    initEmEdit(EM_CARD_PWD_NO,  "0000",      PK);       //카드비밀번호
    initEmEdit(EM_OFFI_ADDR1,   "GEN^200",    NORMAL);   
    initEmEdit(EM_OFFI_ADDR2,   "GEN^200",    NORMAL);
    initEmEdit(EM_HOME_PH1,     "0000",       NORMAL);
    initEmEdit(EM_HOME_PH2,     "0000",       NORMAL);
    initEmEdit(EM_HOME_PH3,     "0000",       NORMAL);
    initEmEdit(EM_MOBILE_PH1,   "0000",       PK);
    initEmEdit(EM_MOBILE_PH2,   "0000",       PK);
    initEmEdit(EM_MOBILE_PH3,   "0000",       PK);     
    initEmEdit(EM_WED_DT,       "YYYYMMDD",   NORMAL);
    initEmEdit(EM_BIRTH_DT,     "YYYYMMDD",   PK);
    initEmEdit(EM_OFFI_PH1,     "0000",       NORMAL);
    initEmEdit(EM_OFFI_PH2,     "0000",       NORMAL);
    initEmEdit(EM_OFFI_PH3,     "0000",       NORMAL);
    //initEmEdit(EM_CHILD_CNT,    "NUMBER^2^0", NORMAL);    
    initComboStyle(LC_EMAIL2,DS_O_EMAIL2, "CODE^0^30,NAME^0^110", 1, NORMAL);          //이메일주소목록
    initComboStyle(LC_FOREIGN,DS_O_FOREIGN, "CODE^0^30,NAME^0^110", 1, NORMAL);          //외국인국적
	initComboStyle(LC_CARD_TYPE_CD,DS_O_CARD_TYPE_CD, "CODE^0^30,NAME^0^110", 1, PK);  //카드구분
	initComboStyle(LC_CCOMP_CD,DS_CCOMP_CD, "CODE^0^30,NAME^0^110", 1, PK);  //카드사코드
	initComboStyle(LC_POCARD_PREFIX,DS_O_POCARD_PREFIX, "CODE^0^30,NAME^0^110", 1, NORMAL);  //카드종류
	initComboStyle(LC_MOBILE_COMP,DS_O_MOBILE_COMP, "CODE^0^30,NAME^0^110", 1, NORMAL);          //통신사
	initComboStyle(LC_ENTR_CH,DS_O_ENTR_CH, "CODE^0^30,NAME^0^110", 1, NORMAL);          //가입채널
	
    initEmEdit(EM_OFFI_NM,      "GEN^40",     NORMAL);        //직장부서명
    //initEmEdit(EM_INCOME_AMT,   "NUMBER^5^0", NORMAL);        //월 평균소득
    //initEmEdit(EM_FAMILY_CNT,   "NUMBER^3^0", NORMAL);        //가족수
    initEmEdit(EM_DEPT_NAME,    "GEN^40",     NORMAL);        //부서
    initComboStyle(LC_POSITION,DS_O_POSITION, "CODE^0^30,NAME^0^110", 1, NORMAL);  //직위
    initEmEdit(EM_POSITION_ETC, "GEN^40",     NORMAL);        //직위 - 기타
    initEmEdit(EM_AGENT_NAME,   "GEN^40",     NORMAL);        //대리인성명
    initEmEdit(EM_AGENT_SSNO,   "000000",  NORMAL);   //대리인생년월일
    initComboStyle(LC_AGENT_RELATION,DS_O_AGENT_RELATION, "CODE^0^30,NAME^0^110", 1, NORMAL); //관계
    initEmEdit(EM_AGENT_PH1,    "0000",       NORMAL);        //대리인전화번호1
    initEmEdit(EM_AGENT_PH2,    "0000",       NORMAL);        //대리인전화번호2
    initEmEdit(EM_AGENT_PH3,    "0000",       NORMAL);        //대리인전화번호3
    initEmEdit(EM_LEGAL_AGENT,  "GEN^40",     NORMAL);        //법정대리인
    
    initEmEdit(EM_OFF_TERMS1_DT,"YYYYMMDD",   PK);            //개인정보의 수집 및 이용 동의일자
    initEmEdit(EM_OFF_TERMS1_NAME,"GEN^40",   PK);            //개인정보의 수집 및 이용 동의자
    initEmEdit(EM_OFF_TERMS2_DT,  "YYYYMMDD", PK);            //고유식별정보 수집 및 이용동의일자
    initEmEdit(EM_OFF_TERMS2_NAME,"GEN^40",   PK);            //고유식별정보 수집 및 이용동의일자
    initEmEdit(EM_OFF_TERMS3_DT,  "YYYYMMDD", PK);            //개인정보 처리업무 위탁 동의일자
    initEmEdit(EM_OFF_TERMS3_NAME,"GEN^40",   PK);            //개인정보 처리업무 위탁 동의자
    initEmEdit(EM_OFF_TERMS4_DT,  "YYYYMMDD", PK);            //개인정보 제3자 제공 동의일자
    initEmEdit(EM_OFF_TERMS4_NAME,"GEN^40",   PK);            //개인정보 제3자 제공 동의자
    
    initEmEdit(EM_ENTR_DT,        "YYYYMMDD", PK);            //가입일자
    initComboStyle(LC_ID_CHECK,DS_O_ID_CHECK, "CODE^0^30,NAME^0^110", 1, PK);  //신분증확인
    initEmEdit(EM_ISSUE_ORG,      "GEN^40",   PK);        //발행기관
    initEmEdit(EM_ISSUE_DT,       "YYYYMMDD", PK);        //발행일자
    
    initEmEdit(EM_HOME_NEW_YN,     "GEN^1",    NORMAL);        //집 - 구/신주소여부
    initEmEdit(EM_OFFI_NEW_YN,     "GEN^1",    NORMAL);        //회사 - 구/신주소여부
    initEmEdit(EM_NOCLS_REQ_YN,    "GEN^1",    NORMAL);
    
    initEmEdit(EM_O_PUMBUN_CD,  "CODE^6^0", PK);  //품번코드(조회)
    initEmEdit(EM_O_PUMBUN_NM,  "GEN^40", READ);  //품번명(조회)
    initComboStyle(LC_CUST_GRADE,DS_O_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
    initComboStyle(LC_CUST_TYPE,DS_O_CUST_TYPE, "CODE^0^30,NAME^0^110", 1, PK); //회원유형
    initEmEdit(EM_ISSUE_CNT,  "0000", READ);  	  //카드발급횟수
    initEmEdit(EM_ETC_MEMO,  "GEN^40", NORMAL);   //적요추가 16.12.19
    
	initEmEdit(EM_CI,   "GEN^100",    NORMAL);
	initEmEdit(EM_DI,   "GEN^100",    NORMAL);
    EM_CI.Text = "";
    EM_DI.Text = "";
    
    EM_HOME_NEW_YN.style.display  = "none";
    EM_OFFI_NEW_YN.style.display  = "none";
    EM_EMAIL3.style.display       = "none";
    EM_NOCLS_REQ_YN.style.display = "none";

    EM_CHKSAVE.Visible  = "false";
    EM_CUST_ID.Visible  = "false";
    EM_HHOLD_ID.Visible = "false";
    EM_CHKSAVE.style.display  = "none";
    EM_CUST_ID.style.display  = "none";
    EM_HHOLD_ID.style.display = "none";
    EM_POSITION_ETC.style.display = "none";

    getEtcCode("DS_O_EMAIL2", "D", "D013", "N");
    getEtcCode("DS_O_FOREIGN", "D", "D122", "N");
    getEtcCode("DS_O_MOBILE_COMP", "D", "D131", "N");
	getEtcCode("DS_O_ENTR_CH", "D", "D133", "N");
	
    getEtcCode("DS_O_CARD_TYPE_CD", "D", "D029", "N");
    //getEtcCodeRefer("DS_O_POCARD_PREFIX", "D", "D104", "N");
    getEtcCode("DS_CCOMP_CD", "D", "D061", "N");

    getEtcCode("DS_O_POSITION", "D", "D045", "N");
    getEtcCode("DS_O_AGENT_RELATION", "D", "D042", "N");
    getEtcCode("DS_O_ID_CHECK", "D", "D046", "N");
    
    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "N");
    getEtcCode("DS_O_CUST_TYPE", "D", "D115", "N");
    
    RD_EMAIL_YN.CodeValue      = "Y";
    RD_TM_YN.CodeValue      = "N";
    RD_WED_YN.CodeValue        = "N";
    RD_LUNAR_FLAG.CodeValue    = "S";
    RD_SMS_YN.CodeValue        = "Y";
    RD_OFF_TERMS1_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_OFF_TERMS2_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_OFF_TERMS3_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_OFF_TERMS4_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_POST_RCV_CD.CodeValue   = "H";
    RD_HOUSE_FLAG.CodeValue    = "9";
    RD_HOUSE_TYPE.CodeValue    = "4";
    RD_ALIEN_YN.CodeValue      = "N";
    RD_NAME_CONF_YN.CodeValue  = "N";
    RD_SEX_CD.CodeValue		   = "F";
    
    RD_ENTR_GAIN.CodeValue	   = "0";	// 맴버쉽가입고객 지급 혜택
    RD_ENTR_GAIN.Enable		   = "false";
    
    EM_CHKSAVE.Text      = "I";
    LC_EMAIL2.BindColVal = "99";
    LC_CARD_TYPE_CD.BindColVal = "12";
    LC_POCARD_PREFIX.Index = 0;
    LC_CUST_GRADE.Index = 0;
    LC_CUST_TYPE.Index = 0;
    LC_ID_CHECK.Index = 6;
    LC_MOBILE_COMP.index = 0;
	LC_ENTR_CH.index = 0;

    EM_CUST_NAME.Language = 1;
    EM_HNEW_ADDR2.Language = 1;
    EM_HOME_ADDR2.Language = 1;
    EM_OFF_TERMS1_NAME.Language = 1;
    
	EM_HNEW_ZIP_CD1.Enable = false;
	EM_HNEW_ZIP_CD2.Enable = false;
    EM_HNEW_ADDR1.Enable   = false;

	EM_HOME_ZIP_CD1.Enable = false;
	EM_HOME_ZIP_CD2.Enable = false;
    EM_HOME_ADDR1.Enable   = false;
    
    EM_OFFI_ZIP_CD1.Enable = false;
    EM_OFFI_ZIP_CD2.Enable = false;
    EM_OFFI_ADDR1.Enable   = false;
    //직원기재란
    EM_ISSUE_ORG.Enable    = false;
    EM_ISSUE_DT.Enable     = false;
    enableControl(IMG_ISSUE_DT , false);
    //14세 미만시
    EM_AGENT_NAME.Enable     = false;
    EM_AGENT_SSNO.Enable     = false;
    LC_AGENT_RELATION.Enable = false;
    EM_AGENT_PH1.Enable      = false;
    EM_AGENT_PH2.Enable      = false;
    EM_AGENT_PH3.Enable      = false;
    EM_LEGAL_AGENT.Enable    = false;
    EM_CARD_NO_S.Enable      = true;

	EM_HNEW_ZIP_CD1.Alignment = 1;
	EM_HNEW_ZIP_CD2.Alignment = 1;
	EM_HOME_ZIP_CD1.Alignment = 1;
	EM_HOME_ZIP_CD2.Alignment = 1;
	EM_OFFI_ZIP_CD1.Alignment = 1;
	EM_OFFI_ZIP_CD2.Alignment = 1;
	//EM_SS_NO.Focus();
	EM_CARD_NO_CUT.Focus();
	
    EM_OFF_TERMS1_DT.Text = "<%=toDate%>";
    EM_OFF_TERMS2_DT.Text = "<%=toDate%>";
    EM_OFF_TERMS3_DT.Text = "<%=toDate%>";
    EM_OFF_TERMS4_DT.Text = "<%=toDate%>";
    EM_ENTR_DT.Text       = "<%=toDate%>";
    
    //결혼여부에 의한 속성제어
    EM_WED_DT.Text      = "";  
    //EM_CHILD_CNT.Text   = "";
    EM_ISSUE_CNT.Text	= "1";
    LC_FOREIGN.ENABLE = "FALSE";
	//RD_NAME_CONF_YN.ENABLE = "FALSE";
    setEnable(false);

    EM_HNEW_ZIP_CD2.style.display="none";
    EM_HOME_ZIP_CD2.style.display="none";
    
    if(parseInt(strToday) >= 20160805){
    	enableControl(EM_CARD_NO_S , true);
    	enableControl(EM_CARD_NO_CUT , false);
    	}
}

function gridCreate1(){
    var hdrProperies = '';                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}


/*************************************************************************
  * 2. 공통버튼
     (1) 신규       - btn_New()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    var em = document.all.tags("object");
    
    if (em!=null){
      for (i = 0; i < em.length; i++) {
        
        if(em[i].classid=="<%=Util.CLSID_EMEDIT%>"){
            em[i].Text = "";
        }
      }
    }
    doInit();
    strSaveYn = "N";
    /*
    document.getElementById("FAVOR_DEPT1").checked = false;
    document.getElementById("FAVOR_DEPT2").checked = false;
    document.getElementById("FAVOR_DEPT3").checked = false;
    document.getElementById("FAVOR_DEPT4").checked = false;
    document.getElementById("FAVOR_DEPT5").checked = false;
	*/ 
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : DB에 저장
 * return값 : void
 */
function btn_Save() {

    if(strSaveYn == "Y"){
        //신규등록만 가능합니다.
        showMessage(EXCLAMATION, OK, "USER-1000", "신규등록만 가능합니다.");
        return false;
    }
    
    var chk;
    
    if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
      || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
        chk = juminCheck(EM_SS_NO.Text);
    }else{
        chk = juminCheckFore(EM_SS_NO.Text);
    }
    if(trim(EM_SS_NO.text).length == 6 || trim(EM_SS_NO.text).length == 13 ) chk = true; 
    

    
    //추가_2000년 이후  나이계산을 위해 (20160325)
    var birth = EM_BIRTH_DT.Text.substring(0,4);
    var yymmdd = "<%=toDate%>";   
    var year = yymmdd.substring(0,4);

	var ageage = 0;
	
	ageage = (parseInt(year) -  parseInt(birth) + 1);
  
    if(getAge(EM_SS_NO.Text, "<%=toDate%>") < 20){
    	// 20141118 마케팅팀 업무연락으로 나이 만 18세로 수정 수정 
    }

    
    
    if(getAge(EM_SS_NO.Text, "<%=toDate%>") < 19){ //우리나라 19은 만나이 18과 같다
        //showMessage(EXCLAMATION, OK, "USER-1003",  "19세 미만은 등록할 수 없습니다.");
        //return false;
    }
   
  
    //수정 (getAge(EM_SS_NO.Text -> ageage로) (20160325)
	//alert(ageage);
    //if(ageage < 14){ //우리나라 19은 만나이 18과 같다
    //    showMessage(EXCLAMATION, OK, "USER-1003",  "14세 미만은 등록할 수 없습니다.");
    //    return false;
    //}
    

    if(LC_CUST_GRADE.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "회원등급");
        LC_CUST_GRADE.Focus();
        return false;    	
    }
    if(LC_CUST_TYPE.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "회원유형");
        LC_CUST_TYPE.Focus();
        return false;    	
    }    
    if(EM_CHKSAVE.Text=="I" && trim(EM_CARD_NO_S.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드번호");
        EM_CARD_NO_S.Focus();
        return false;
    }
    if(trim(EM_CUST_NAME.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_CUST_NAME.Focus();
        return false;
    }
    if(trim(EM_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "생년월일");
        EM_SS_NO.Focus();
        return false;
    }

    if(chk==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일이 아닙니다.");
        EM_SS_NO.Focus();
        return false;
    }
    
    if( trim(EM_CARD_PWD_NO.Text).length >= 0 && trim(EM_CARD_PWD_NO.Text).length < 4){
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드비밀번호는 4자리입니다.");
        EM_CARD_PWD_NO.Focus();
        return false;
    }
 
    if(EM_CHKSAVE.Text == "I"){
        if(!isNumberStr(EM_CARD_PWD_NO.Text)){
    	    showMessage(EXCLAMATION, OK, "USER-1005",  "카드비밀번호");
    	    EM_CARD_PWD_NO.Focus();
    	    EM_CARD_PWD_NO.selectAll;
    	    return false;
    	} 
    }else{
    	if(!isNumberStr(EM_CARD_PWD_NO.Text) && EM_CARD_PWD_NO.Text != "****"){
            showMessage(EXCLAMATION, OK, "USER-1005",  "카드비밀번호");
            EM_CARD_PWD_NO.Focus();
            return false;
        } 
    }
    if(trim(EM_BIRTH_DT.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "본인생일");
        return false;
    }
    if(RD_SEX_CD.CodeValue == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성별구분");
        return false;
    }    
	if(EM_HNEW_ZIP_CD1.text==""){		
	    showMessage(EXCLAMATION, OK, "USER-1003",  "자택주소");
	    sample4_execDaumPostcode();
        return false;
    }
    if(trim(EM_HNEW_ADDR2.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "자택상세주소");
        EM_HNEW_ADDR2.Focus();
        return false;
    }    
    
    if(trim(EM_MOBILE_PH1.text) == "" || trim(EM_MOBILE_PH2.text) == "" || trim(EM_MOBILE_PH3.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
        if(trim(EM_MOBILE_PH1.text) == ""){
        	EM_MOBILE_PH1.Focus();
        }else if(trim(EM_MOBILE_PH2.text) == ""){
        	EM_MOBILE_PH2.Focus();
        }else if(trim(EM_MOBILE_PH3.text) == ""){
        	EM_MOBILE_PH3.Focus();
        }
        return false;
    }
    /*
    if(firstTelFormat(EM_MOBILE_PH1,"H")==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
        return false;
    }
    */
    if(RD_EMAIL_YN.CodeValue == "Y" && trim(EM_EMAIL1.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "이메일 수신동의가 '예'일 경우 이메일 주소를 입력하셔야 합니다.");
        EM_EMAIL1.Focus();
        return;
    }    
/*
    if(LC_EMAIL2.BindColVal != "99" && trim(EM_EMAIL1.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "이메일주소");
        EM_EMAIL1.Focus();
        return;
    }
    if( trim(EM_EMAIL3.Text).length != 0){
        if(LC_EMAIL2.BindColVal == "99" && trim(EM_EMAIL1.Text).length == 0 ){
            showMessage(EXCLAMATION, OK, "USER-1003",  "이메일주소");
            EM_EMAIL1.Focus();
            return;
        }
    }
    if( trim(EM_EMAIL1.Text).length != 0){
        if(LC_EMAIL2.BindColVal == "99" && trim(EM_EMAIL3.Text).length == 0 ){
            showMessage(EXCLAMATION, OK, "USER-1003",  "도메인");
            EM_EMAIL3.Focus();
            return;
        }
    }
    
    if(trim(EM_WED_DT.Text).length != 0){
        var strWedDt = EM_WED_DT.Text; 
        if(parseInt(strWedDt) > parseInt(strToday)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "미래일자는 입력할 수 없습니다.");
            EM_WED_DT.Focus();
            return false;
        }
    }
    if(LC_POSITION.BindColVal == "99" && trim(EM_POSITION_ETC.Text).length == 0){
    	showMessage(EXCLAMATION, OK, "USER-1003",  "기타직위");
    	EM_POSITION_ETC.Focus();
        return false;
    }
    if(trim(EM_OFFI_PH1.text) != "" && (trim(EM_OFFI_PH2.text) == "" || trim(EM_OFFI_PH3.text) == "")
    || trim(EM_OFFI_PH2.text) != "" && (trim(EM_OFFI_PH1.text) == "" || trim(EM_OFFI_PH3.text) == "")
    || trim(EM_OFFI_PH3.text) != "" && (trim(EM_OFFI_PH1.text) == "" || trim(EM_OFFI_PH2.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1000",  "직장전화를  정확히 입력하세요.");
        if(trim(EM_OFFI_PH1.text) == ""){
            EM_OFFI_PH1.Focus();
        }else if(trim(EM_OFFI_PH2.text) == ""){
            EM_OFFI_PH2.Focus();
        }else if(trim(EM_OFFI_PH3.text) == ""){
            EM_OFFI_PH3.Focus();
        }
        return false;
    }
    if(RD_POST_RCV_CD.CodeValue == "O"){
        if(EM_OFFI_ZIP_CD1.text=="" || EM_OFFI_ZIP_CD2.text == ""){       
            showMessage(EXCLAMATION, OK, "USER-1003",  "직장주소");
            getPostPop_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN);
            return false;
        }
        if(trim(EM_OFFI_ADDR2.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "직장상세주소");
            EM_OFFI_ADDR2.Focus();
            return false;
        }
    }
    
    //미성년자 여부 확인   
    if(intAge < 14){
    	if(trim(EM_AGENT_NAME.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "이름");
            EM_AGENT_NAME.Focus();
            return false;
        }
    	if(trim(EM_AGENT_SSNO.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "생년월일");
            EM_AGENT_SSNO.Focus();
            return false;
        }
    	if(trim(LC_AGENT_RELATION.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1002",  "관계");
            LC_AGENT_RELATION.Focus();
            return false;
        }
        if(trim(EM_AGENT_PH1.text) != "" && (trim(EM_AGENT_PH2.text) == "" || trim(EM_AGENT_PH3.text) == "")
        || trim(EM_AGENT_PH2.text) != "" && (trim(EM_AGENT_PH1.text) == "" || trim(EM_AGENT_PH3.text) == "")
        || trim(EM_AGENT_PH3.text) != "" && (trim(EM_AGENT_PH1.text) == "" || trim(EM_AGENT_PH2.text) == "")){
            showMessage(EXCLAMATION, OK, "USER-1000",  "전화번호를  정확히 입력하세요.");
        	if(trim(EM_AGENT_PH1.text) == ""){
        		EM_AGENT_PH1.Focus();
        	}else if(trim(EM_AGENT_PH2.text) == ""){
        		EM_AGENT_PH2.Focus();
        	}else if(trim(EM_AGENT_PH3.text) == ""){
        		EM_AGENT_PH3.Focus();
        	}
        	return false;
        }
        if(trim(EM_LEGAL_AGENT.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "법정대리인");
            EM_LEGAL_AGENT.Focus();
            return false;
        }
    }
*/    
    
    if(trim(EM_OFF_TERMS1_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의일자");
        EM_OFF_TERMS1_DT.Focus();
        return false;
    }
    /*if(trim(EM_OFF_TERMS1_NAME.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_OFF_TERMS1_NAME.Focus();
        return false;
    }*/
    
    if(trim(EM_OFF_TERMS2_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의일자");
        EM_OFF_TERMS2_DT.Focus();
        return false;
    }
	/*
    if(trim(EM_OFF_TERMS2_NAME.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_OFF_TERMS2_NAME.Focus();
        return false;
    }
    */

    if(trim(EM_OFF_TERMS3_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의일자");
        EM_OFF_TERMS3_DT.Focus();
        return false;
    }
    
    if(trim(EM_OFF_TERMS4_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의일자");
        EM_OFF_TERMS4_DT.Focus();
        return false;
    }
    if(trim(EM_ENTR_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가입일자");
        EM_ENTR_DT.Focus();
        return false;
    }
    /*
    if(trim(LC_ID_CHECK.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "신분증확인");
        LC_ID_CHECK.Focus();
        return false;
    }
    
    if(LC_ID_CHECK.BindColVal != "9"){
    	if(trim(EM_ISSUE_ORG.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "발행기관");
            EM_ISSUE_ORG.Focus();
            return false;
        }
    	if(trim(EM_ISSUE_DT.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "발행일자");
            EM_ISSUE_DT.Focus();
            return false;
        }
    	
    	var strIssueDt = EM_ISSUE_DT.Text; 
    	if(parseInt(strIssueDt) > parseInt(strToday)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "미래일자는 입력할 수 없습니다.");
            EM_ISSUE_DT.Focus();
            return false;
        }
    }
    */
	 //if(trim(EM_CI.text) == ""){
     //   showMessage(EXCLAMATION, OK, "USER-1000",  "본인인증은 반드시 해야 합니다");
     //   return false;
     //}
    
    if (RD_NAME_CONF_YN.CodeValue  != "Y") {
    	
    	showMessage(EXCLAMATION, OK, "USER-1000",  "핸드폰을 통한 본인인증은 반드시 해야 합니다.");
        return false;
     };

    //저장할 데이터 없는 경우
    if (!DS_IO_CUST.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
  
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    saveData();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
* saveData()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-12
* 개       요 : 무기명회원가입신청서 등록 저장
* return값 : void
*/
function saveData(){
	
	
	//var strFavorDept1YN = (document.getElementById("FAVOR_DEPT1").checked == true)? "Y":"N";
    //var strFavorDept2YN = (document.getElementById("FAVOR_DEPT2").checked == true)? "Y":"N";
    //var strFavorDept3YN = (document.getElementById("FAVOR_DEPT3").checked == true)? "Y":"N";
    //var strFavorDept4YN = (document.getElementById("FAVOR_DEPT4").checked == true)? "Y":"N";
    //var strFavorDept5YN = (document.getElementById("FAVOR_DEPT5").checked == true)? "Y":"N";
    
	//if(RD_NAME_CONF_YN.CodeValue == "N")
	//{
	//		 showMessage(EXCLAMATION, OK, "USER-1028", "본인인증 후 가입 가능합니다");
	//		 return;
	//}
	
    var strFavorDept1YN = "N";
    var strFavorDept2YN = "N";
    var strFavorDept3YN = "N";
    var strFavorDept4YN = "N";
    var strFavorDept5YN = "N";
    
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT1_YN")  = strFavorDept1YN;  
	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT2_YN")  = strFavorDept2YN;  
	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT3_YN")  = strFavorDept3YN;  
	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT4_YN")  = strFavorDept4YN;  
	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT5_YN")  = strFavorDept5YN;  

    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "COMP_PERS_FLAG")  = "P";                   // 법인/개인구분
    if(EM_NOCLS_REQ_YN.Text == ""){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "NOCLS_REQ_YN")= "Y";                   // 클랜징미적용요청여부
    }
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HOME_CLS_YN")     = "Y";                   // 클렌징 여부
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_FAX1")       = "";
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_FAX2")       = "";
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_FAX3")       = "";
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_INTER_PH")   = "";
    if(LC_EMAIL2.BindColVal == "99"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = EM_EMAIL3.Text;
    }else{
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = LC_EMAIL2.Text;
    }

    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "<%=toDate%>";          // 등록일자           
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SMS_AGREE_DT")   = "<%=toDate%>";                                                                     
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_CLS_YN")    = "Y";                    //오피스주소클랜징여부
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCOMP_EMP_YN")   = "N";                    //계열사직원여부                    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_STAT_FLAG") = "0";                    //회원상태
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "WEB_USER_ID")    = "";                     
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "WEB_PASSWD")     = "";                     
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "I_PIN")          = "";                     //아이핀가입
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "ENTR_PATH")      = "";   
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCED_REQ_DT")    = "";                     //탈퇴요청일
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCED_TAKE_FLAG") = "";  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCED_PROC_DT")   = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CARD_NO")        = EM_CARD_NO_S.Text; 
   
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HOLD_CAR_YN")  = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "INCOME_AMT")   = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAMILY_CNT")   = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CHILD_CNT")    = ""; 
  
    /*
    var strAlienYN = "";믿ㄱ
    if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
    || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){ 
    	strAlienYN = "N";
    }else{
    	strAlienYN = "Y";
    }
    if(trim(EM_SS_NO.text).length == 6) strAlienYN = "N";
    
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "ALIEN_YN")       = strAlienYN;         //외국인여부
    */
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HORI_ADDR1")     = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HORI_ADDR2")     = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OORI_ADDR1")     = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OORI_ADDR2")     = "";  
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "DI")     = RD_ENTR_GAIN.CodeValue;  

    var strChksave = EM_CHKSAVE.Text;
    var strUpdate = "N";
    if (strChksave == "U") {
    	strUpdate = "Y";
    }
    var parameters = "&strSsno="+encodeURIComponent(EM_SS_NO.text)
                   + "&strMobilePh1="+encodeURIComponent(EM_MOBILE_PH1.Text)
                   + "&strMobilePh2="+encodeURIComponent(EM_MOBILE_PH2.Text)
                   + "&strMobilePh3="+encodeURIComponent(EM_MOBILE_PH3.Text)
		           + "&strChksave="+strChksave
                   + "&strUpdate="+strUpdate;

    TR_MAIN.Action="/dcs/dctm102.dm?goTo=saveData"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CUST=DS_IO_CUST)";
    TR_MAIN.Post();  

    
}

/**
* showMaster()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-14
* 개       요 : 생년월일로 회원정보를 가져온다.
* return값 : void
*/
function showMaster(){
	if(trim(EM_SS_NO.text).length == 6 && 
			(trim(EM_MOBILE_PH1.text) == "" || trim(EM_MOBILE_PH2.text) == "" || trim(EM_MOBILE_PH3.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
        return false;
    }	
	
	var vCardTypeCd = LC_CARD_TYPE_CD.BindColVal;
	var vPoCardPrefix = LC_POCARD_PREFIX.BindColVal;
	strFlag = "UPD";
	EM_EMAIL3.text = ""; 
	
    var strSsno    = EM_SS_NO.text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strSsno="+encodeURIComponent(strSsno)
                   + "&strMobilePh1="+encodeURIComponent(EM_MOBILE_PH1.Text)
                   + "&strMobilePh2="+encodeURIComponent(EM_MOBILE_PH2.Text)
                   + "&strMobilePh3="+encodeURIComponent(EM_MOBILE_PH3.Text);
    
    TR_MAIN.Action ="/dcs/dctm102.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CUST=DS_IO_CUST)"; //조회는 O
    TR_MAIN.Post();

    
    var strFavorDept1YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT1_YN");
    var strFavorDept2YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT2_YN");
    var strFavorDept3YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT3_YN");
    var strFavorDept4YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT4_YN");
    var strFavorDept5YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT5_YN");
    
    if(EM_CHKSAVE.Text=="U"){
        EM_CUST_NAME.Enable = "false";
	    EM_SS_NO.Enable     = "false";
	    //카드 비밀번호 조회되게 처리 17.01.12
	    //if(EM_CARD_PWD_NO.Text!=""){
	    //    EM_CARD_PWD_NO.Text = "****";
	    //}
	}
    
    if(EM_EMAIL1.Text != ""){
	    LC_EMAIL2.Text   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2");
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", EM_EMAIL3.Text);
    }

    if(strFlag == "UPD" && (LC_EMAIL2.BindColVal == "" || LC_EMAIL2.BindColVal == "99")){
        setComboData(LC_EMAIL2,"99");
        EM_EMAIL3.style.display = "";
    }else{
        EM_EMAIL3.Text = ""; 
        EM_EMAIL3.style.display = "none";
    }
    if(RD_WED_YN.CodeValue=="Y"){
    	setEnable(true);
    }
    
    LC_CARD_TYPE_CD.BindColVal = vCardTypeCd;
    LC_POCARD_PREFIX.BindColVal = vPoCardPrefix;
    
    
    /*
    if(strFavorDept1YN == "Y") document.getElementById("FAVOR_DEPT1").checked = true;
    if(strFavorDept2YN == "Y") document.getElementById("FAVOR_DEPT2").checked = true;
    if(strFavorDept3YN == "Y") document.getElementById("FAVOR_DEPT3").checked = true;
    if(strFavorDept4YN == "Y") document.getElementById("FAVOR_DEPT4").checked = true;
    if(strFavorDept5YN == "Y") document.getElementById("FAVOR_DEPT5").checked = true;
    */
    
    
    
    if(EM_EMAIL3.Text == "99") EM_EMAIL3.Text = "";
    if(EM_ISSUE_CNT.Text == "0") EM_ISSUE_CNT.Text	= "1";
    
    /*
    document.getElementById('IMG_REAL_NAME').focus();
    */
    
}

/**
* setEnable(flag)
* 작 성 자 : 김영진
* 작 성 일 : 2010-03-30
* 개      요  : 결혼여부에 인한 Enable 변경
* return값 : void
*/
function setEnable(flag){
    enableControl(IMG_WED_DT , flag);
    EM_WED_DT.Enable = flag;  
}

/**
* getAlienNoPop()
* 작 성 자 : 강진
* 작 성 일 : 2012. 05. 08
* 개    요 : 가외국인번호 생성 팝업
* return값 : void
*/
function getAlienNoPop(objNo)
{  
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);

	var returnVal = window.showModalDialog("/dcs/dctm102.dm?goTo=creatAlienSsno",
					arrArg,
		            "dialogWidth:278px;dialogHeight:115px;scroll:no;" +
		            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
		            
  	if (returnVal){
		var map = arrArg[0];
		objNo.Text = map.get("SS_NO");
 	}
}

/**
* ()
* 작 성 자 : 강진
* 작 성 일 : 2012. 05. 08
* 개       요 : 실명확인 팝업
* return값 : void
*/
function confirmName()
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(EM_SS_NO.Text);
	arrArg.push(EM_CUST_NAME.Text);
	arrArg.push(EM_CUST_ID.Text);
	arrArg.push(EM_DI.Text);
	arrArg.push(EM_CI.Text);
	arrArg.push(RD_ALIEN_YN.CodeValue);
	arrArg.push(LC_FOREIGN.Index);

	var returnVal = window.showModalDialog("/dcs/dctm102.dm?goTo=confRealName",
					arrArg,
		            "dialogWidth:278px;dialogHeight:115px;scroll:no;" +
		            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
           
  	if (returnVal){
		var map = arrArg[0];
		RD_NAME_CONF_YN.CodeValue = map.get("CONF_YN");
		if(map.get("CONF_YN") == "Y"){
			EM_CUST_NAME.Text = map.get("CUST_NAME");
			EM_SS_NO.Text = map.get("SS_NO");
			EM_BIRTH_DT.Text = map.get("BIRTH_DT");
			RD_SEX_CD.CodeValue	= map.get("SEX_CD");
			EM_DI.Text	= map.get("DI");
			EM_CI.Text	= map.get("CI");
			RD_ALIEN_YN.CodeValue = "Y";
			LC_FOREIGN.Index = 4;
		}	
 	} 
}

/**
* confirmMobile()
* 작 성 자 : 전주원
* 작 성 일 : 2015. 04. 21
* 개       요 : 휴대폰인증 팝업
* return값 : void
*/
function confirmMobile()
{	
	
	var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(EM_SS_NO.Text);
	arrArg.push(EM_CUST_NAME.Text);
	arrArg.push(EM_CUST_ID.Text);
	
	
	var returnVal = window.showModalDialog("/dcs/dctm102.dm?goTo=confRealMobile",
					arrArg,
		            "dialogWidth:350px;dialogHeight:200px;scroll:no;" +
		            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	
           
  	if (returnVal){
		var map = arrArg[0];
		RD_NAME_CONF_YN.CodeValue = map.get("CONF_YN");
		if(map.get("CONF_YN") == "Y"){
			
			EM_CUST_NAME.Text = map.get("CUST_NAME");
			EM_MOBILE_PH1.Text = map.get("MOBILE_PH1");
			EM_MOBILE_PH2.Text = map.get("MOBILE_PH2");
			EM_MOBILE_PH3.Text = map.get("MOBILE_PH3");
			
			//RD_NAME_CONF_YN.ENABLE = false;
		}	
 	} 
}



/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개      요  : 화면 이동
 * return값 : void
 */
function gourl(go,nm,s){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO_S.Text,s,"01",nm);
}


/**
 * chkDupHp()
 * 작 성 자 : 김준영
 * 작 성 일 : 2017-06-27
 * 개      요  : 핸드폰번호 중복 체크
 * return값 : void
 */

function chkDupHp(){
		
	if (RD_NAME_CONF_YN.CodeValue == "Y"){
   	 	alert("이미 인증을 완료 하였습니다.");
   	 	return false;
    }
	 
	 //EM_MOBILE_PH1.text = '010';
	 //EM_MOBILE_PH2.text = '9913';
	 //EM_MOBILE_PH3.text = '2814';
	 if(trim(EM_MOBILE_PH1.text) == "" || trim(EM_MOBILE_PH2.text) == "" || trim(EM_MOBILE_PH3.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
        if(trim(EM_MOBILE_PH1.text) == ""){
        	EM_MOBILE_PH1.Focus();
        }else if(trim(EM_MOBILE_PH2.text) == ""){
        	EM_MOBILE_PH2.Focus();
        }else if(trim(EM_MOBILE_PH3.text) == ""){
        	EM_MOBILE_PH3.Focus();
        }
        return false;
    }
	 
	var strHp1 = EM_MOBILE_PH1.text;
	var strHp2 = EM_MOBILE_PH2.text;
	var strHp3 = EM_MOBILE_PH3.text;
	
	DS_O_DUPCHK.ClearData();

    var goTo       = "chkDupHp" ;    
    var action     = "O";     
    var parameters = "&strHp1="+encodeURIComponent(strHp1)
                   + "&strHp2="+encodeURIComponent(strHp2)
                   + "&strHp3="+encodeURIComponent(strHp3)
                   ;
	    
    TR_MAIN.Action ="/dcs/dctm102.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DUPCHK=DS_O_DUPCHK)"; //조회는 O
    TR_MAIN.Post();
    
    if (DS_O_DUPCHK.CountRow>0) {
    	//alert(DS_O_DUPCHK.NameValue(1,"CUST_NAME"));
    	//var rtn = showMessage(INFORMATION, YESNO, "USER-1000",  "이미 등록된 전화번호 입니다. 계속 진행하시겠습니까?");
    	
    	var strRes =  DS_O_DUPCHK.NameValue(1,"CUST_NAME");
    	var strEnt =  DS_O_DUPCHK.NameValue(1,"ENTR_DT");
    	
    	var rtn = showMessage(INFORMATION, OK, "USER-1000",  "이미 등록된 전화번호 입니다.<br>*고객명 : " 
		     														+ strRes +  " *가입일자 : "+ strEnt);
    	
    	return false;
    	
    	if (rtn!=1) {
    		
    		return false;
    	
    	}
    }
    
    // 탈퇴회원 체크
    var chkSced = chkScedCust(strHp1, strHp2, strHp3);
    
    if (chkSced != "0") {
    	RD_ENTR_GAIN.CodeValue	   = "9";
    	showMessage(INFORMATION, OK, "USER-1000",  chkSced);
    }
    
    // 인증문자 발송
    sendSMS();

}


/**
 * chkScedCust(strHp1, strHp2, strHp3)
 * 작 성 자 : 김준영
 * 작 성 일 : 2017-11-09
 * 개      요  : 탈퇴 회원 체크, 재가입 회원일 경우 가입혜택 제외.
 * return값 : String
 */
function chkScedCust(strHp1, strHp2, strHp3) {
	 	
	 	DS_O_DUPCHK.ClearData();

	    var goTo       = "chkScedCust" ;    
	    var action     = "O";     
	    var parameters = "&strHp1="+encodeURIComponent(strHp1)
	                   + "&strHp2="+encodeURIComponent(strHp2)
	                   + "&strHp3="+encodeURIComponent(strHp3)
	                   ;
		    
	    TR_MAIN.Action ="/dcs/dctm102.dm?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DUPCHK=DS_O_DUPCHK)"; //조회는 O
	    TR_MAIN.Post();
	    
	    return DS_O_DUPCHK.NameValue(1,"CUST_NAME");
	    
}


/**
 * sendSMS()
 * 작 성 자 : 김준영
 * 작 성 일 : 2017-06-27
 * 개      요  : 인증을 위한 핸드폰 문자메세지 발송
 * return값 : void
 */
function sendSMS() {
	
	 	var strHp1 		= EM_MOBILE_PH1.text;
		var strHp2 		= EM_MOBILE_PH2.text;
		var strHp3 		= EM_MOBILE_PH3.text;
		var strSendGb 	= "SMS_ARTBAT";
		
		var rtn = showMessage(Question, YESNO, "USER-1000",  "<b>"+ strHp1 + " - " +strHp2 + " - " + strHp3
					+	" </b><br> 해당 번호로 인증을 진행하시겠습니까?");


		if (rtn!=1) {
			
			return false;
			
		}

	    var goTo       = "insRealName" ;    
	    var action     = "O";     
	    var parameters = "&strHp1="+encodeURIComponent(strHp1)
	                   + "&strHp2="+encodeURIComponent(strHp2)
	                   + "&strHp3="+encodeURIComponent(strHp3)
	                   + "&strSendGb="+encodeURIComponent(strSendGb)
	                   ;
		    
	    TR_MAIN.Action ="/dcs/dctm102.dm?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_SMS_CD=DS_O_SMS_CD)"; //조회는 O
	    TR_MAIN.Post();
	    
	    
	    
	    
	    if (DS_O_SMS_CD.CountRow>0) {
	    	//alert(DS_O_SMS_CD.NameValue(1,"SMS_CD"));
	    	
	    	var strSmsCd  = DS_O_SMS_CD.NameValue(1,"SMS_CD");
	    	
	    	//var rtn = showMessage(INFORMATION, YESNO, "USER-1000",  "고객님께 발송된 인증번호가<br><br><b>[ "+strSmsCd+" ] </b> 가 맞습니까? ");
	    	
	    	var arrArg  = new Array(strSmsCd);
		    	
		    	var rtn =  window.showModalDialog("/dcs/jsp/dctm/dctm1026.jsp?",
                        				arrArg,
                				"dialogWidth:250px;dialogHeight:130px;scroll:no;");
	    	
	    	if (rtn!=1) {
	    		
	    		EM_MOBILE_PH1.text = "";
	    		EM_MOBILE_PH2.text = "";
	    		EM_MOBILE_PH3.text = "";
	    		showMessage(EXCLAMATION, OK, "USER-1000",  "고객님의 번호를 다시 확인해주시기 바랍니다.");
	    		//alert("고객님의 번호를 다시 확인해주시기 바랍니다.");
	    		return false;
	    	
	    	}
	    	RD_NAME_CONF_YN.CodeValue  = "Y";
	    }
	
}


-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
    	var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|');
        showMessage(EXCLAMATION, OK, "USER-1000", strMsg[2]);
        if(strMsg[3] != "CHK"){
            EM_CUST_ID.Text  = strMsg[0]; 
            EM_HHOLD_ID.Text = strMsg[1]; 
            EM_CHKSAVE.Text = "U";
            EM_CUST_NAME.Enable = false;
            EM_SS_NO.Enable     = false;
        }
        if(EM_EMAIL1.Text != ""){
            LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
        }
        if( LC_EMAIL2.BindColVal == "" ){
            setComboData(LC_EMAIL2,"99");
        }
        //EM_CARD_NO_S.Enable = false;
        //strSaveYn = "Y";
       	
        LC_CARD_TYPE_CD.Focus();
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
    }
    if( LC_EMAIL2.BindColVal == "" ){
        setComboData(LC_EMAIL2,"99");
    }
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    }
</script>

<!-- 자택전화 onKillFocus()-->
<script language=JavaScript for=EM_HOME_PH1 event=onKillFocus()>
    if(trim(EM_HOME_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_HOME_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_HOME_PH1.Text = ""
            setTimeout( "EM_HOME_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 이동전화 onKillFocus()-->

<script language=JavaScript for=EM_MOBILE_PH1 event=onKillFocus()>
/*
    if(trim(EM_MOBILE_PH1.Text).length != 0){
        if(firstTelFormat(EM_MOBILE_PH1,"H")==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_MOBILE_PH1.Text = ""
            setTimeout( "EM_MOBILE_PH1.Focus();",50);
            return false;
        }
    }
*/
</script>


<script language=JavaScript for=RD_ALIEN_YN event=OnSelChange()>

	if(RD_ALIEN_YN.CodeValue == "Y")
	{
		LC_FOREIGN.ENABLE = "TRUE";
		//LC_CUST_GRADE.BindColVal = "21";
	} else {
		LC_FOREIGN.ENABLE = "FALSE";
		LC_FOREIGN.text = "";
		LC_FOREIGN.value = "";
		//LC_CUST_GRADE.BindColVal = "21";
	}

</script>



<!-- 휴대전화 onKeyUp()()-->
<script language=JavaScript for=EM_MOBILE_PH1 event=onKeyUp()>
	if(trim(EM_MOBILE_PH1.Text).length == 3){
    	setTimeout( "EM_MOBILE_PH2.Focus();",50);
    }
</script>
<!-- 휴대전화 onKeyUp()-->
<script language=JavaScript for=EM_MOBILE_PH2 event=onKeyUp()>
    if(trim(EM_MOBILE_PH2.Text).length == 4){
    	setTimeout( "EM_MOBILE_PH3.Focus();",50);
    }
</script>
<!-- 직장전화 onKillFocus()-->
<script language=JavaScript for=EM_OFFI_PH1 event=onKillFocus()>
    if(trim(EM_OFFI_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_OFFI_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_OFFI_PH1.Text = ""
            setTimeout( "EM_OFFI_PH1.Focus();",50);
            return false;
        }
    }
</script>

<!-- 이름자동 설정  onKillFocus() -->
<script language=JavaScript for=EM_CUST_NAME event=onKillFocus()>
    EM_OFF_TERMS1_NAME.Text = this.Text;
    EM_OFF_TERMS2_NAME.Text = this.Text;
</script>

<!-- 법정대리인 전화번호 onKillFocus()-->
<script language=JavaScript for=EM_AGENT_PH1 event=onKillFocus()>
    if(trim(EM_AGENT_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_AGENT_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_AGENT_PH1.Text = ""
            setTimeout( "EM_AGENT_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 생년월일  onKillFocus() -->

<script language=JavaScript for=EM_SS_NO event=onKillFocus()>
	if(trim(EM_SS_NO.Text).length != 0){
        var chk;
        if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
          || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
            chk = juminCheck(EM_SS_NO.Text);
        }else{
            chk = juminCheckFore(EM_SS_NO.Text);
        }
        if(trim(EM_SS_NO.text).length == 6 || trim(EM_SS_NO.text).length == 6) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일이 아닙니다.");
            EM_SS_NO.Text = "";
            setTimeout( "EM_SS_NO.Focus();",50);
            return false;
        }

		//생년월일 기본 세팅.
		//if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2"){
		//	EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
		//}else if(EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
		//	EM_BIRTH_DT.Text = "20"+EM_SS_NO.Text.substring(0,6);
		//}
		//(20160325_주석처리)
		//if(trim(EM_SS_NO.text).length == 6) EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
		
		//성별 기본 세팅.
		if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="3"
		 || EM_SS_NO.Text.substring(6,7)=="5" || EM_SS_NO.Text.substring(6,7)=="7"){
			RD_SEX_CD.CodeValue = "M";
		}else{
			RD_SEX_CD.CodeValue = "F";
		}
		//if(trim(EM_SS_NO.text).length == 6) RD_SEX_CD.CodeValue = "";

		if(trim(EM_SS_NO.text).length == 6) return true;
        if(!showMaster()) {
        	/*
            if(trim(EM_MOBILE_PH1.text) == ""){
            	setTimeout("EM_MOBILE_PH1.Focus();",50);
            }else if(trim(EM_MOBILE_PH2.text) == ""){
            	setTimeout("EM_MOBILE_PH2.Focus();",50);
            }else if(trim(EM_MOBILE_PH3.text) == ""){
            	setTimeout("EM_MOBILE_PH3.Focus();",50);
            } 
        	*/
            return;
        }

        if(trim(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"SCED_REQ_DT")) != ""){
            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 카드발급이 불가합니다.");
            btn_New();
            setTimeout("EM_AGENT_SSNO.Focus();",50);
            return false;
        }
        
        //정보 유 Focus:카드, 비밀번호 무:성명
        /*
        if(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_NAME") == ""){
            setTimeout( "EM_CUST_NAME.Focus();",50);
        }else if(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_NAME") != "" 
        		&& EM_CARD_NO_S.Text == ""){
            setTimeout( "EM_CARD_NO_S.Focus();",50);
        }else{
        	setTimeout( "EM_BIRTH_DT.Focus();",50);
        }
        */

        //미성년자 여부 확인
        /* -- 2016.11
        intAge = getAge(EM_SS_NO.Text, "<=toDate%>");
        if(intAge < 14){
            EM_AGENT_NAME.Enable     = true;
            EM_AGENT_SSNO.Enable     = true;
            LC_AGENT_RELATION.Enable = true;
            EM_AGENT_PH1.Enable      = true;
            EM_AGENT_PH2.Enable      = true;
            EM_AGENT_PH3.Enable      = true;
            EM_LEGAL_AGENT.Enable    = true;
        }else{
            EM_AGENT_NAME.Enable     = false;
            EM_AGENT_SSNO.Enable     = false;
            LC_AGENT_RELATION.Enable = false;
            EM_AGENT_PH1.Enable      = false;
            EM_AGENT_PH2.Enable      = false;
            EM_AGENT_PH3.Enable      = false;
            EM_LEGAL_AGENT.Enable    = false;
        }
        */
    }
</script>
 
<!-- 휴대폰번호  onKillFocus() -->
<script language=JavaScript for=EM_MOBILE_PH3 event=onKillFocus()>
	if (trim(EM_MOBILE_PH3.Text).length != 0){
		if ( (trim(EM_MOBILE_PH3.Text).length == 4) 
				&& (trim(EM_MOBILE_PH1.Text).length == 3) 
				&& ((trim(EM_MOBILE_PH2.Text).length == 3) || (trim(EM_MOBILE_PH2.Text).length == 4))
				&& (trim(EM_SS_NO.text).length >= 6)
				&& (trim(EM_SS_NO.text).length < 13)
			){
				
	        var chk;
	        if(trim(EM_SS_NO.text).length == 13) return true;
	        if(trim(EM_SS_NO.text).length >= 6) chk = true;
	        if(chk==false){
	            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일가 아닙니다.");
	            EM_SS_NO.Text = "";
	            //setTimeout( "EM_SS_NO.Focus();",50);
	            return false;
	        }
			
	        if(!showMaster()) {
	        	/*
	            if(trim(EM_MOBILE_PH1.text) == ""){
	            	setTimeout("EM_MOBILE_PH1.Focus();",50);
	            }else if(trim(EM_MOBILE_PH2.text) == ""){
	            	setTimeout("EM_MOBILE_PH2.Focus();",50);
	            }else if(trim(EM_MOBILE_PH3.text) == ""){
	            	setTimeout("EM_MOBILE_PH3.Focus();",50);
	            } 
	        	*/
	            return;
	        }
			
	        if(trim(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"SCED_REQ_DT")) != ""){
	            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 카드발급이 불가합니다.");
	            btn_New();
	            setTimeout("EM_AGENT_SSNO.Focus();",50);
	            return false;
	        }
	    }
	}	
</script>
 
<!-- 미성년자 법정대리인생년월일  onKillFocus() -->
<script language=JavaScript for=EM_AGENT_SSNO event=onKillFocus()>
    if(trim(EM_AGENT_SSNO.Text).length != 0){
        var chk;
        if(EM_AGENT_SSNO.Text.substring(6,7)=="1" || EM_AGENT_SSNO.Text.substring(6,7)=="2" 
          || EM_AGENT_SSNO.Text.substring(6,7)=="3" || EM_AGENT_SSNO.Text.substring(6,7)=="4"){
            chk = juminCheck(EM_AGENT_SSNO.Text);
        }else{
            chk = juminCheckFore(EM_AGENT_SSNO.Text);
        }
        if(trim(EM_AGENT_SSNO.text).length == 6) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일가 아닙니다.");
            EM_AGENT_SSNO.Text = "";
            setTimeout( "EM_AGENT_SSNO.Focus();",50);
            return false;
        }
    }
</script>

<!-- 도메인 OnSelChange() -->
<script language=JavaScript for=LC_EMAIL2 event=OnSelChange()>
    if(LC_EMAIL2.BindColVal == "99"){
        EM_EMAIL3.style.display = "";
    }else{
        EM_EMAIL3.style.display = "none";
    }   
</script>
<!-- 직위 OnSelChange() -->
<script language=JavaScript for=LC_POSITION event=OnSelChange()>
    if(LC_POSITION.BindColVal == "99"){
    	EM_POSITION_ETC.style.display = "";
    }else{
    	EM_POSITION_ETC.style.display = "none";
    }   
</script>
<script language=JavaScript for=RD_WED_YN event=OnSelChange()>
    if(RD_WED_YN.CodeValue=="Y"){
        setEnable(true);
    }else{
        setEnable(false);
        EM_WED_DT.Text = "";
    }
</script>
<!-- 카드번호 onKillFocus()-->
<script language=JavaScript for=EM_CARD_NO_S event=onKillFocus()>
    if( LC_CARD_TYPE_CD.BindColVal == 12 && trim(EM_CARD_NO_S.Text).length == 16){
        
    	if(!isValidCardNo(EM_CARD_NO_S.Text)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 카드번호가 아닙니다.");
            EM_CARD_NO_S.Text = "";
            setTimeout( "EM_CARD_NO_S.Focus();",50);
            return false;
        }else{
        	if(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CARD_PWD_NO") == ""){
                setTimeout( "EM_CARD_PWD_NO.Focus();",50);
            }else if(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SS_NO") == ""){
                setTimeout( "EM_SS_NO.Focus();",50);
            }else if(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_NAME") == "" ){
                setTimeout( "EM_CUST_NAME.Focus();",50);
            }else{
                setTimeout( "EM_BIRTH_DT.Focus();",50);
            }
        }
    }
</script>


<!-- 본인생일  onKillFocus() -->
<script language=JavaScript for=EM_BIRTH_DT event=onKillFocus()>
	//추가 20160325
    if(trim(EM_BIRTH_DT.Text).length != 8 && trim(EM_BIRTH_DT.Text).length > 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 본인생일이 아닙니다.");
        EM_BIRTH_DT.Text = "";
        setTimeout( "EM_BIRTH_DT.Focus();",50);
        return ;
    } 
	
    EM_SS_NO.text = EM_BIRTH_DT.Text.substring(2,8);
	
   //아래내용 주석처리 2000년 이후 세팅값이 적용되지 않았음 (20160325)
   // if(!checkDateTypeYMD(EM_BIRTH_DT)){
        //생년월일 기본 세팅.
       // if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2"){
          //  EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
      //  }else if(EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
        //    EM_BIRTH_DT.Text = "20"+EM_SS_NO.Text.substring(0,6);
      //  }
       // if(trim(EM_SS_NO.text).length == 6) EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
   // }
   
  
   
	if(trim(EM_SS_NO.Text).length != 0){
        var chk;
        
        if(trim(EM_SS_NO.text).length == 6) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 생년월일이 아닙니다.");
            EM_SS_NO.Text = "";
            //setTimeout( "EM_SS_NO.Focus();",50);
            return false;
        }

		//성별 기본 세팅.
		RD_SEX_CD.CodeValue = "F";

		//if(trim(EM_SS_NO.text).length == 6) return true;
		
			
		if ( (trim(EM_MOBILE_PH3.Text).length == 4) 
				&& (trim(EM_MOBILE_PH1.Text).length == 3) 
				&& ((trim(EM_MOBILE_PH2.Text).length == 3) || (trim(EM_MOBILE_PH2.Text).length == 4))
				&& (trim(EM_SS_NO.text).length == 6)
			)
		{
	        showMaster();
			if (DS_IO_CUST.RowCount > 0) return;
		}
		
        /*   2016.11
        if(trim(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"SCED_REQ_DT")) != ""){
            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 카드발급이 불가합니다.");
            btn_New();
            setTimeout("EM_AGENT_SSNO.Focus();",50);
            return false;
        }
        */

        //미성년자 여부 확인        
        /* -- 2016.11
        intAge = getAge(EM_SS_NO.Text, "<=toDate%>");
       
        if(intAge < 14){
            EM_AGENT_NAME.Enable     = true;
            EM_AGENT_SSNO.Enable     = true;
            LC_AGENT_RELATION.Enable = true;
            EM_AGENT_PH1.Enable      = true;
            EM_AGENT_PH2.Enable      = true;
            EM_AGENT_PH3.Enable      = true;
            EM_LEGAL_AGENT.Enable    = true;
        }else{
            EM_AGENT_NAME.Enable     = false;
            EM_AGENT_SSNO.Enable     = false;
            LC_AGENT_RELATION.Enable = false;
            EM_AGENT_PH1.Enable      = false;
            EM_AGENT_PH2.Enable      = false;
            EM_AGENT_PH3.Enable      = false;
            EM_LEGAL_AGENT.Enable    = false;
        }
        */
    }
	
	
	
</script>


<!-- 결혼기념일  onKillFocus() -->
<script language=JavaScript for=EM_WED_DT event=onKillFocus()>
    checkDateTypeYMD(EM_WED_DT);
</script>

<!-- 정보 제공 및 활용 동의일자  onKillFocus() -->
<script language=JavaScript for=EM_OFF_TERMS1_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OFF_TERMS1_DT);
</script>
<!-- 개인정보 제3자 제공 동의일자  onKillFocus() -->
<script language=JavaScript for=EM_OFF_TERMS2_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OFF_TERMS2_DT);
</script>
<!-- 정보 제공 및 활용 동의일자  onKillFocus() -->
<script language=JavaScript for=EM_OFF_TERMS3_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OFF_TERMS3_DT);
</script>
<!-- 개인정보 제3자 제공 동의일자  onKillFocus() -->
<script language=JavaScript for=EM_OFF_TERMS4_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OFF_TERMS4_DT);
</script>

<!-- 가입일자  onKillFocus() -->
<script language=JavaScript for=EM_ENTR_DT event=onKillFocus()>
    checkDateTypeYMD(EM_ENTR_DT);
</script>
<!-- 발행일자  onKillFocus() -->
<script language=JavaScript for=EM_ISSUE_DT event=onKillFocus()>
    checkDateTypeYMD(EM_ISSUE_DT);
</script>

<!-- 신분증확인 OnSelChange() -->
<script language=JavaScript for=LC_ID_CHECK event=OnSelChange()>
    if(LC_ID_CHECK.BindColVal == "9"){
    	EM_ISSUE_ORG.Enable = false;
    	EM_ISSUE_DT.Enable  = false;
    	enableControl(IMG_ISSUE_DT , false);
    	EM_ISSUE_ORG.Text = "";
    	EM_ISSUE_DT.Text  = "";
    	
    }else{
    	EM_ISSUE_ORG.Enable = true;
    	EM_ISSUE_DT.Enable  = true;
        enableControl(IMG_ISSUE_DT , true);
    }
</script>

 
<script language=JavaScript for=DS_O_POCARD_PREFIX event=OnFilter(row)>
if(LC_CARD_TYPE_CD.BindColVal == 12){
	if (DS_O_POCARD_PREFIX.NameValue(row,"REFER_CODE") == "1"){
		return true;
	}else 
		return false;
}else{
	if (DS_O_POCARD_PREFIX.NameValue(row,"REFER_CODE") == "1" || DS_O_POCARD_PREFIX.NameValue(row,"REFER_CODE") == "0"){
		return true;
	}else 
		return false;
}
	

</script>

<!-- 카드구분 OnSelChange() -->
<script language=JavaScript for=LC_CARD_TYPE_CD event=OnSelChange()>
	if(LC_CARD_TYPE_CD.BindColVal == "21"){
		getEtcCode("DS_CCOMP_CD", "D", "D061", "N");
	
		enableControl(LC_CCOMP_CD , true);
		LC_CCOMP_CD.index = 0;	
	}else{
		DS_CCOMP_CD.ClearData();
		insComboData( LC_CCOMP_CD, "00", "", 1 );
		enableControl(LC_CCOMP_CD , false);
		LC_CCOMP_CD.index = 0;
	}
	getEtcCodeRefer("DS_O_POCARD_PREFIX", "D", "D104", "N");
	LC_POCARD_PREFIX.Index = 0;
</script>

<!-- 품번(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	    
	if(this.text==''){
		EM_O_PUMBUN_NM.Text = "";
	    return;
	}          
    setPumbunCdCombo("NAME");
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
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CUST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_EMAIL2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_FOREIGN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CARD_TYPE_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CARD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>

<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DUPCHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>

<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SMS_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>

<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_POSITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AGENT_RELATION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ID_CHECK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CCOMP_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_POCARD_PREFIX" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter	value=true></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUST_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MOBILE_COMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ENTR_CH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

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
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<!--공통 타이틀/버튼 -->
	<%@ include file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 // -->
	<DIV id="testdiv" class="testdiv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90" class="point">카드구분</th>
							<td colspan="4" width="200"><comment id="_NSID_"> <object
								id=LC_CARD_TYPE_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
								width=158 align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
							<th width="90" class="point" style="display:none">카드사코드</th>
							<td style="display:none" width="160"><comment id="_NSID_"> <object 
								id=LC_CCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
								width=158 align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
							<th width="90" style="display:none">패밀리카드구분</th>
							<td style="display:none" ><comment id="_NSID_"> <object
								id=LC_POCARD_PREFIX classid=<%=Util.CLSID_LUXECOMBO%> width=130
								tabindex=1 onClick="DS_O_POCARD_PREFIX.Filter()"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90" class="point">카드번호</th>
							<td width="200"><comment id="_NSID_"> <object
								style="display:none" id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="100"
								tabindex=1 align="absmiddle" ></object> </comment> <script> _ws_(_NSID_);</script>
								<comment id="_NSID_"> <object
								id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width=130
								tabindex=1 > </object> </comment> <script> _ws_(_NSID_);</script>
								<input style="display:none"  type="button" value="카드번호생성"  onclick="javascript:make_cardno();"/></td>
							<th width="90" class="point">카드비밀번호</th>
							<td colspan="4" width="160"><comment id="_NSID_"> <object
								id=EM_CARD_PWD_NO classid=<%=Util.CLSID_EMEDIT%> width=80
								tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
            <td>
            <table width="100%">		
			<tr>
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 신청자정보</td>
			 <td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo642.do','영수증사후적립','DMBO')">영수증사후적립</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm116.dm','회원메모관리(신규)','DCTM')">회원메모관리(신규)</a></td>
			    <td class="btn_r"></td>	
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm201.dm','개인카드조회','DCTM')">개인카드조회</a></td>
			    <td class="btn_r"></td>	
			  </tr>
			</table>                
	    </td>		
		</tr>
		</table>				
       </td>
   	</tr>
		<tr>
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th class="point">성명</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
								id="_NSID_"> <object id=EM_CHKSAVE
								classid=<%=Util.CLSID_EMEDIT%> width=30 align="absmiddle"></object>
								</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
								<object id=EM_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=0
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
								id="_NSID_"> <object id=EM_HHOLD_ID
								classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
								</comment> <script> _ws_(_NSID_);</script></td>

							<th class="point" width="120">본인생일</th>
							<td><comment id="_NSID_"> <object id=EM_BIRTH_DT
								classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle"
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
								src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_BIRTH_DT)" />
								<comment id="_NSID_"> <object style="display:none"  id=EM_SS_NO width=154
								classid=<%=Util.CLSID_EMEDIT%> width=50 align="absmiddle"
								tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
						    </td>
						</tr>
						<tr>
							<th>생일 구분</th>
							<td><comment id="_NSID_"><object id=RD_LUNAR_FLAG
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="S^양력,L^음력">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="S">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th class="point">휴대전화</th>
							<td>
							
								<comment id="_NSID_">
								<object id=LC_MOBILE_COMP classid=<%=Util.CLSID_LUXECOMBO%> height=100  style="display : none"
								width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
								
								<comment id="_NSID_"> <object id=EM_MOBILE_PH1
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- 
								<comment id="_NSID_"> <object id=EM_MOBILE_PH2
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- 
								<comment id="_NSID_"> <object id=EM_MOBILE_PH3
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/real_name2.gif"
								onclick="chkDupHp();"
								align="absmiddle" tabindex=5 > * 본인 인증시 핸드폰으로 인증번호를 발송합니다.
								
								<!--  
								내   용 : 휴대폰 본인인증 팝업
								작성자 : jwjeon
								작성일 : 2015.04.22
								-->
								
								<!--<img src="/<%=dir%>/imgs/btn/real_name.gif"
								onclick="javascript:confirmMobile();" 
								align="absmiddle" tabindex=5>-->
								
								<!--<a href="javascript:fnPopup();">테스트버튼</a>-->
									<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
<!-- 									<form name="form_chk" method="post"> -->
<!-- 										<input type="hidden" name="m" value="checkplusSerivce">						필수 데이타로, 누락하시면 안됩니다. -->
<%-- 										<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. --> --%>
<%-- 										<input type="hidden" name="enc_data" value="<%=enc_data%>"><!--마이핀--> --%>
										
<!-- 										업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
<!-- 										해당 파라미터는 추가하실 수 없습니다. --> 
<!-- 										<input type="hidden" name="param_r1" value=""> -->
<!-- 										<input type="hidden" name="param_r2" value=""> -->
<!-- 										<input type="hidden" name="param_r3" value=""> -->
										
<!-- 										<input type="button" value="휴대폰인증" onclick="javascript:fnPopup();"> -->
<!-- 										<input type="button" value="마이핀인증" onclick="javascript:fnPopup2();"> -->
<!-- 										<input type="button" value="외국인인증" onclick="javascript:confirmName();"> -->

<!-- 									</form> -->
										<comment id="_NSID_"><object id=EM_CI
										classid=<%=Util.CLSID_EMEDIT%> width=600 align="absmiddle"
										tabindex=5 style="display:none;"> </object> </comment> <script> _ws_(_NSID_);</script><br>
										<comment id="_NSID_"><object id=EM_DI
										classid=<%=Util.CLSID_EMEDIT%> width=600 align="absmiddle"
										tabindex=5 style="display:none;"> </object> </comment> <script> _ws_(_NSID_);</script>
									<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
									
									
<!-- 									마이핀(내번호) 서비스를 호출하기 위해서는 다음과 같은 form이 필요합니다 -->
								</td>							
						</tr>
						<tr>
							<th>성별 구분</th>
							<td><comment id="_NSID_"><object id=RD_SEX_CD
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="M^남자,F^여자">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="F">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th>SMS 수신동의</th>
							<td><comment id="_NSID_"> <object id=RD_SMS_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<!-- <th>본인인증여부</th> -->
							<td style="display: none" ><comment id="_NSID_"><object id=RD_NAME_CONF_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle" tabindex=5 >
								<param name=Cols value="2">
								<param name=Format value="N^미인증,Y^인증">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="N">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th>가입점</th>
							<td><comment id="_NSID_"><object
								id=LC_STR_CD   classid=<%=Util.CLSID_LUXECOMBO%> width=130
								tabindex=1 ></object></comment> <script> _ws_(_NSID_);</script></td>
							<th>외국인정보</th>							
							<td><comment id="_NSID_"><object id=RD_ALIEN_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="N^내국인,Y^외국인">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script>
							</td>
							<td style="display: none"> 
								     <comment id="_NSID_"> <object
										id=LC_FOREIGN classid=<%=Util.CLSID_LUXECOMBO%> width=70
										tabindex=5  style="display: hidden" ></object> </comment> <script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/add_alien_s.gif" 
										onclick="javascript:getAlienNoPop(EM_SS_NO); EM_SS_NO.Focus();"
										align="absmiddle" tabindex=5>
							</td>
						</tr>
						<tr>
							<th>자택전화</th>
							<td><comment id="_NSID_"> <object id=EM_HOME_PH1
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_HOME_PH2
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_HOME_PH3
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
						    </td>	
							<th>우편물 수령동의</th>
							<td><comment id="_NSID_"> <object
								id=RD_POST_RCV_CD classid=<%=Util.CLSID_RADIO%>
								style="height: 20; width: 120" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="H^예,O^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="H">
							</object> </comment> <script> _ws_(_NSID_);</script></td>							
						</tr>
						<tr>
							<th class="point">자택주소</th>
							<td colspan="2"
								style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_HOME_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
								id="_NSID_"> <object id=EM_HNEW_ZIP_CD1
								classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
							</object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
							<object id=EM_HNEW_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
								width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/search_post_s.gif"
								onclick="sample4_execDaumPostcode()"
								align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR">
							<comment id="_NSID_"> <object id=EM_HNEW_ADDR1
								classid=<%=Util.CLSID_EMEDIT%> width=255 align="absmiddle"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<td style="border-left: 1px solid #fff; padding-left: 0"><comment
								id="_NSID_"> <object id=EM_HNEW_ADDR2
								classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_HNEW_ADDR2, 200, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<span id="guide" style="color:#999"></span>
						</tr>
						
						
						<tr >
							<th class="point">자택주소(구주소)</th>
							<td colspan="2"
								style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0">
								<comment
								id="_NSID_"> <object id=EM_HOME_ZIP_CD1 style="display : none" 
								classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
							</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
							<object id=EM_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> 
								width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/search_post_s.gif" style="display : none"
								onclick="sample4_execDaumPostcode()"
								align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR">
							<comment id="_NSID_"> <object id=EM_HOME_ADDR1
								classid=<%=Util.CLSID_EMEDIT%> width=255 align="absmiddle"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<td style="border-left: 1px solid #fff; padding-left: 0"><comment
								id="_NSID_"> <object id=EM_HOME_ADDR2 style="display : none"
								classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_HOME_ADDR2, 200, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<span id="guide" style="color:#999"></span>
						</tr>
						
						<tr>
							<th>이메일주소</th>
							<td><comment id="_NSID_"> <object id=EM_EMAIL1
								classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_EMAIL1, 50, '');"></object>
							</comment> <script> _ws_(_NSID_);</script> @ <comment id="_NSID_">
							<object id=LC_EMAIL2 classid=<%=Util.CLSID_LUXECOMBO%> height=100
								width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
							<comment id="_NSID_"> <object id=EM_EMAIL3
								classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_EMAIL3, 50, '');"
								style="display: hidden"></object> </comment> <script> _ws_(_NSID_);</script>
							</td>
							<th>이메일 수신동의</th>
							<td><comment id="_NSID_"> <object id=RD_EMAIL_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th class="point">회원등급</th>
							<td><comment id="_NSID_"> <object
								id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>
							<th class="point">TM 동의여부</th>
							<td><comment id="_NSID_"> <object id=RD_TM_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="N">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
																			                            																															<tr style="display:none">
							<th width="90">결혼여부</th>
							<td><comment id="_NSID_"> <object id=RD_WED_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="N^미혼,Y^기혼">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="N">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="90">결혼 기념일</th>
							<td><comment id="_NSID_"> <object id=EM_WED_DT
								classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
								src="/<%=dir%>/imgs/btn/date.gif" id="IMG_WED_DT"
								align="absmiddle" onclick="javascript:openCal('G',EM_WED_DT)" /></td>
						</tr>
						<tr style="display:none">
							<th width="90">주거형태</th>
							<td><comment id="_NSID_"> <object id=RD_HOUSE_TYPE
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 250"
								tabindex=5>
								<param name=Cols value="4">
								<param name="AutoMargin" value="true">
								<param name=Format value="1^APT,2^단독,3^연립,4^기타">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="90">주거구분</th>
							<td><comment id="_NSID_"> <object
								id=RD_HOUSE_FLAG classid=<%=Util.CLSID_RADIO%>
								style="height: 20; width: 200" tabindex=5>
								<param name=Cols value="4">
								<param name=Format value="1^자가,2^전세,3^월세,9^기타">
								<param name="AutoMargin" value="true">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>	
						<tr>
						    <th class="point">회원유형</th>
							<td><comment id="_NSID_"> <object
								id=LC_CUST_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>   
							<th>가입권유 브랜드</th>
							<td><comment id="_NSID_">
			                	<object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=5  align="absmiddle">
			                	</object></comment><script> _ws_(_NSID_);</script>
				                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCdCombo('POP'); EM_O_PUMBUN_CD.Focus();"  align="absmiddle" />
				                <comment id="_NSID_">
				                <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=5  align="absmiddle">
				                </object></comment><script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90">적요</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_ETC_MEMO classid=<%=Util.CLSID_EMEDIT%> width=180
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_ETC_MEMO, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td> 
							<th width="90">가입혜택</th>
							<td width="1050">
							<comment id="_NSID_"> <object id=RD_ENTR_GAIN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 400"
								tabindex=5>
								<param name=Cols value="3">
								<param name=Format value="0^포인트적립,1^현장즉시할인,9^혜택미적용">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script>
							</td> 
						</tr>
						
						<!-- 
						<tr height="0">
							<td height="0" width="0"><input type="checkbox" id=FAVOR_DEPT1 value="N" tabindex=5 > &nbsp;<input
								type="checkbox" id=FAVOR_DEPT2 value="N" tabindex=5 > &nbsp;<input
								type="checkbox" id=FAVOR_DEPT3 value="N" tabindex=5 > &nbsp;<input
								type="checkbox" id=FAVOR_DEPT4 value="N" tabindex=5 > &nbsp;<input
                                type="checkbox" id=FAVOR_DEPT5 value="N" tabindex=5 > &nbsp;</td>
						</tr>
						 --> 
						 <tr style="display:none">
							<th>카드발급횟수</th>
							<td><comment id="_NSID_"><object id=EM_ISSUE_CNT classid=<%=Util.CLSID_EMEDIT%> width=30
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
							<th>가입채널</th>
							<td>
								<comment id="_NSID_">
								<object id=LC_ENTR_CH classid=<%=Util.CLSID_LUXECOMBO%> height=100
								width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						 </tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr style="display:none">
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 직장 및 학교정보</td>
		</tr>
		<tr style="display:none">
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90">직장(학교)</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_OFFI_NM classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90">부서</th>
							<td><comment id="_NSID_"> <object id=EM_DEPT_NAME
								classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90">직위</th>
							<td width="310"><comment id="_NSID_"> <object
								id=LC_POSITION classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script><comment
								id="_NSID_"> <object id=EM_POSITION_ETC
								classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" style="width: 90px;">전화번호</th>
							<td><comment id="_NSID_"> <object id=EM_OFFI_PH1
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_OFFI_PH2
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_OFFI_PH3
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90">주소</th>
							<td colspan="2"
								style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_OFFI_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
								id="_NSID_"> <object id=EM_OFFI_ZIP_CD1
								classid=<%=Util.CLSID_EMEDIT%> width=30 align="absmiddle">
							</object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
							<object id=EM_OFFI_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
								width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/search_post_s.gif"
								onclick="getPostPop_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)"
								align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR"
								onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)}">
							<comment id="_NSID_"> <object id=EM_OFFI_ADDR1
								classid=<%=Util.CLSID_EMEDIT%> width=256 align="absmiddle"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<td style="border-left: 1px solid #fff; padding-left: 0"><comment
								id="_NSID_"> <object id=EM_OFFI_ADDR2
								classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_OFFI_ADDR2, 200, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr  style="display:none;">
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 14세 미만 아동회원 가입신청서에 대한 법정대리인 동의</td>
		</tr>
		<tr  style="display:none;">
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90">이름</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_AGENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_AGENT_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90">생년월일</th>
							<td><comment id="_NSID_"> <object id=EM_AGENT_SSNO
								classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90">관계</th>
							<td width="310"><comment id="_NSID_"> <object
								id=LC_AGENT_RELATION classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" style="width: 90px;">전화번호</th>
							<td><comment id="_NSID_"> <object id=EM_AGENT_PH1
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_AGENT_PH2
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_AGENT_PH3
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<td width="400" colspan="2">&nbsp;* 본인은 위 신청인의 개인정보
							수집/이용/제공에 동의합니다.
							</th>
							<th width="90">법정대리인</th>
							<td><comment id="_NSID_"> <object
								id=EM_LEGAL_AGENT classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_LEGAL_AGENT, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 개인정보의 수집 및 이용 동의</td>
		</tr>
		
		<tr>
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="110" class="point">동의일자</th>
							<td width="110"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS1_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_OFF_TERMS1_DT)" /></td>
							<th class="point" style="display:none;">성명</th>
							<td style="display:none;"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS1_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFF_TERMS1_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" class="point">동의여부</th>
							<td ><comment id="_NSID_"> <object id=RD_OFF_TERMS1_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 고유식별정보 수집 및 이용 동의</td>
		</tr>
		<tr>
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="110" class="point">동의일자</th>
							<td width="110"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS2_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_OFF_TERMS2_DT)" /></td>
							<th width="90" class="point" style="display:none;">성명</th>
							<td style="display:none;"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS2_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFF_TERMS2_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" class="point">동의여부</th>
							<td  ><comment id="_NSID_"> <object id=RD_OFF_TERMS2_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 개인정보 처리업무 위탁</td>
		</tr>
		<tr>
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="110" class="point">동의일자</th>
							<td width="110"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS3_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_OFF_TERMS3_DT)" /></td>
							<th width="90" class="point" style="display:none;">성명</th>
							<td style="display:none;"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS3_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFF_TERMS3_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" class="point">동의여부</th>
							<td ><comment id="_NSID_"> <object id=RD_OFF_TERMS3_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 개인정보 제3자 제공동의</td>
		</tr>
		<tr>
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="110" class="point">동의일자</th>
							<td width="110"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS4_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_OFF_TERMS4_DT)" /></td>
							<th width="90" class="point" style="display:none;">성명</th>
							<td style="display:none;"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS4_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFF_TERMS4_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" class="point">동의여부</th>
							<td><comment id="_NSID_"> <object id=RD_OFF_TERMS4_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 가입일자</td>
		</tr>
		<tr>
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90" class="point">가입일자</th>
							<td colspan="3"><comment id="_NSID_"> <object
								id=EM_ENTR_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_ENTR_DT)" /></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td class="sub_title PT07 PB02"><img
				src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
				align="absmiddle" class="PR03" /> 직원기재</td>
		</tr>
		<tr style="display:none;">
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90" class="point">신분증확인</th>
							<td colspan="3"><comment id="_NSID_"> <object
								id=LC_ID_CHECK classid=<%=Util.CLSID_LUXECOMBO%> width=158
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90" class="point">발행기관</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_ISSUE_ORG classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_ISSUE_ORG, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" class="point">발행일자</th>
							<td><comment id="_NSID_"> <object id=EM_ISSUE_DT
								classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
								src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_ISSUE_DT)" id=IMG_ISSUE_DT />
								<comment id="_NSID_"> <object
                                id=EM_NOCLS_REQ_YN  classid=<%=Util.CLSID_EMEDIT%> width=0
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</div>
	<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
	<comment id="_NSID_">
	<object id=BO_CUST classid=<%=Util.CLSID_BIND%>>
		<param name=DataID value=DS_IO_CUST>
		<param name="ActiveBind" value=true>
		<param name=BindInfo
			value='
            <c>col=SS_NO                    ctrl=EM_SS_NO                   Param=Text</c>
            <c>col=CUST_NAME                ctrl=EM_CUST_NAME               Param=Text</c>
            <c>col=CARD_PWD_NO              ctrl=EM_CARD_PWD_NO             Param=Text</c>
            <c>col=HNEW_ZIP_CD1             ctrl=EM_HNEW_ZIP_CD1            Param=Text</c>
            <c>col=HNEW_ZIP_CD2             ctrl=EM_HNEW_ZIP_CD2            Param=Text</c>
            <c>col=HNEW_ADDR1               ctrl=EM_HNEW_ADDR1              Param=Text</c>
            <c>col=HNEW_ADDR2               ctrl=EM_HNEW_ADDR2              Param=Text</c>
            
            <c>col=HOME_ZIP_CD1             ctrl=EM_HOME_ZIP_CD1            Param=Text</c>
            <c>col=HOME_ZIP_CD2             ctrl=EM_HOME_ZIP_CD2            Param=Text</c>
            <c>col=HOME_ADDR1               ctrl=EM_HOME_ADDR1              Param=Text</c>
            <c>col=HOME_ADDR2               ctrl=EM_HOME_ADDR2              Param=Text</c>
            
            <c>col=HOME_PH1                 ctrl=EM_HOME_PH1                Param=Text</c>
            <c>col=HOME_PH2                 ctrl=EM_HOME_PH2                Param=Text</c>
            <c>col=HOME_PH3                 ctrl=EM_HOME_PH3                Param=Text</c>
            <c>col=MOBILE_PH1               ctrl=EM_MOBILE_PH1              Param=Text</c>
            <c>col=MOBILE_PH2               ctrl=EM_MOBILE_PH2              Param=Text</c>
            <c>col=MOBILE_PH3               ctrl=EM_MOBILE_PH3              Param=Text</c>
            <c>col=EMAIL1                   ctrl=EM_EMAIL1                  Param=Text</c>
            <c>col=EMAIL2                   ctrl=LC_EMAIL2                  Param=BindColVal</c>
            <c>col=EMAIL3                   ctrl=EM_EMAIL3                  Param=Text</c>
            <c>col=EMAIL_YN                 ctrl=RD_EMAIL_YN                Param=CodeValue</c>
            <c>col=WED_YN                   ctrl=RD_WED_YN                  Param=CodeValue</c>
            <c>col=WED_DT                   ctrl=EM_WED_DT                  Param=Text</c>
            <c>col=BIRTH_DT                 ctrl=EM_BIRTH_DT                Param=Text</c>
            <c>col=LUNAR_FLAG               ctrl=RD_LUNAR_FLAG              Param=CodeValue</c>
            <c>col=SMS_YN                   ctrl=RD_SMS_YN                  Param=CodeValue</c>
            <c>col=POST_RCV_CD              ctrl=RD_POST_RCV_CD             Param=CodeValue</c>
            <c>col=OFFI_NM                  ctrl=EM_OFFI_NM                 Param=Text</c>
            <c>col=OFFI_PH1                 ctrl=EM_OFFI_PH1                Param=Text</c>
            <c>col=OFFI_PH2                 ctrl=EM_OFFI_PH2                Param=Text</c>
            <c>col=OFFI_PH3                 ctrl=EM_OFFI_PH3                Param=Text</c>
            <c>col=OFFI_ZIP_CD1             ctrl=EM_OFFI_ZIP_CD1            Param=Text</c>
            <c>col=OFFI_ZIP_CD2             ctrl=EM_OFFI_ZIP_CD2            Param=Text</c>
            <c>col=OFFI_ADDR1               ctrl=EM_OFFI_ADDR1              Param=Text</c>
            <c>col=OFFI_ADDR2               ctrl=EM_OFFI_ADDR2              Param=Text</c>
            <c>col=CHKSAVE                  ctrl=EM_CHKSAVE                 Param=Text</c>
            <c>col=CUST_ID                  ctrl=EM_CUST_ID                 Param=Text</c>
            <c>col=HHOLD_ID                 ctrl=EM_HHOLD_ID                Param=Text</c>
            <c>col=CARD_NO                  ctrl=EM_CARD_NO_S               Param=Text</c>
            <c>col=CARD_TYPE_CD             ctrl=LC_CARD_TYPE_CD            Param=BindColVal</c>
            <c>col=HOUSE_TYPE               ctrl=RD_HOUSE_TYPE              Param=CodeValue</c>
            <c>col=HOUSE_FLAG               ctrl=RD_HOUSE_FLAG              Param=CodeValue</c>
            <c>col=DEPT_NAME                ctrl=EM_DEPT_NAME               Param=Text</c>
            <c>col=POSITION                 ctrl=LC_POSITION                Param=BindColVal</c>
            <c>col=POSITION_ETC             ctrl=LC_FOREIGN                 Param=BindColVal</c>
            <c>col=AGENT_NAME               ctrl=EM_AGENT_NAME              Param=Text</c>
            <c>col=AGENT_SSNO               ctrl=EM_AGENT_SSNO              Param=Text</c>
            <c>col=AGENT_RELATION           ctrl=LC_AGENT_RELATION          Param=BindColVal</c>
            <c>col=AGENT_PH1                ctrl=EM_AGENT_PH1               Param=Text</c>
            <c>col=AGENT_PH2                ctrl=EM_AGENT_PH2               Param=Text</c>
            <c>col=AGENT_PH3                ctrl=EM_AGENT_PH3               Param=Text</c>
            <c>col=LEGAL_AGENT              ctrl=EM_LEGAL_AGENT             Param=Text</c>
            <c>col=OFF_TERMS1_YN            ctrl=RD_OFF_TERMS1_YN           Param=CodeValue</c>
            <c>col=OFF_TERMS1_DT            ctrl=EM_OFF_TERMS1_DT           Param=Text</c>
            <c>col=OFF_TERMS1_NAME          ctrl=EM_OFF_TERMS1_NAME         Param=Text</c>
            <c>col=OFF_TERMS2_YN            ctrl=RD_OFF_TERMS2_YN           Param=CodeValue</c>
            <c>col=OFF_TERMS2_DT            ctrl=EM_OFF_TERMS2_DT           Param=Text</c>
            <c>col=OFF_TERMS2_NAME          ctrl=EM_OFF_TERMS2_NAME         Param=Text</c>
            
            <c>col=OFF_TERMS3_YN            ctrl=RD_OFF_TERMS3_YN           Param=CodeValue</c>
            <c>col=OFF_TERMS3_DT            ctrl=EM_OFF_TERMS3_DT           Param=Text</c>
            <c>col=OFF_TERMS3_NAME          ctrl=EM_OFF_TERMS3_NAME         Param=Text</c>
            <c>col=OFF_TERMS4_YN            ctrl=RD_OFF_TERMS4_YN           Param=CodeValue</c>
            <c>col=OFF_TERMS4_DT            ctrl=EM_OFF_TERMS4_DT           Param=Text</c>
            <c>col=OFF_TERMS4_NAME          ctrl=EM_OFF_TERMS4_NAME         Param=Text</c>
            
            <c>col=ENTR_DT                  ctrl=EM_ENTR_DT                 Param=Text</c>
            <c>col=ID_CHECK                 ctrl=LC_ID_CHECK                Param=BindColVal</c>
            <c>col=ISSUE_ORG                ctrl=EM_ISSUE_ORG               Param=Text</c>
            <c>col=ISSUE_DT                 ctrl=EM_ISSUE_DT                Param=Text</c>
            <c>col=HOME_NEW_YN              ctrl=EM_HOME_NEW_YN             Param=Text</c>
            <c>col=OFFI_NEW_YN              ctrl=EM_OFFI_NEW_YN             Param=Text</c>
            <c>col=NOCLS_REQ_YN             ctrl=EM_NOCLS_REQ_YN            Param=Text</c>
        	<c>col=POCARD_PREFIX            ctrl=LC_POCARD_PREFIX           Param=BindColVal</c>
        	<c>col=CCOMP_CD                 ctrl=LC_CCOMP_CD                Param=BindColVal</c>
			<c>col=ALIEN_YN                 ctrl=RD_ALIEN_YN                Param=CodeValue</c> 
			<c>col=NAME_CONF_YN             ctrl=RD_NAME_CONF_YN            Param=CodeValue</c>       	
        	<c>col=ENTR_PBN                 ctrl=EM_O_PUMBUN_CD             Param=Text</c>
        	<c>col=ENTR_PBN_NAME            ctrl=EM_O_PUMBUN_NM             Param=Text</c>
        	<c>col=CUST_GRADE               ctrl=LC_CUST_GRADE              Param=BindColVal</c>
        	<c>col=CUST_TYPE                ctrl=LC_CUST_TYPE               Param=BindColVal</c>
        	<c>col=SEX_CD             		ctrl=RD_SEX_CD            		Param=CodeValue</c>
			<c>col=ISSUE_CNT                ctrl=EM_ISSUE_CNT               Param=Text</c>
			<c>col=DI               		ctrl=EM_DI		                Param=Text</c>
			<c>col=CI                		ctrl=EM_CI    		            Param=Text</c>
			<c>col=MOBILE_COMP              ctrl=LC_MOBILE_COMP             Param=BindColVal</c>
			<c>col=TM_YN                    ctrl=RD_TM_YN                   Param=CodeValue</c>
			<c>col=ENTR_CH                  ctrl=LC_ENTR_CH                 Param=BindColVal</c>
			<c>col=STR_CD                   ctrl=LC_STR_CD                  Param=BindColVal</c>
			<c>col=ETC_MEMO                 ctrl=EM_ETC_MEMO                Param=Text</c>
        '>
	</object>
	</comment>
	<script>_ws_(_NSID_);</script>
	<comment id="_NSID_">
	<object id=BO_CARD classid=<%=Util.CLSID_BIND%>>
		<param name=DataID value=DS_O_CARD>
		<param name="ActiveBind" value=true>
		<param name=BindInfo
			value='
            <c>col=CARD_NO             ctrl=EM_CARD_NO_S            Param=Text</c>
            
        '>
	</object>
	</comment>
	<script>_ws_(_NSID_);</script>
	<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>	
</body>
</html>