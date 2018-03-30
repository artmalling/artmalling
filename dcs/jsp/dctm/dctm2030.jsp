<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 개인회원조회/수정 
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진 
 * 수  정  자  : 
 * 파  일  명  : dctm2030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 개인회원을 조회/수정한다.
 * 이         력  :
 *           2010.03.02 (김영진) 신규작성
 *           2010.03.14 (김영진) 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
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
	String strSsNo	= (request.getParameter("strSsNo") != null && !"".equals(request.getParameter("strSsNo").trim())) ? request.getParameter("strSsNo") : "";	
	String strCardNo= (request.getParameter("strCardNo") != null && !"".equals(request.getParameter("strCardNo").trim())) ? request.getParameter("strCardNo") : "";
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var flag     = false;
var strFlag  = "INS";
var strToday = "<%=toDate%>";
var strBeforeCustGrade   = "";
var strBeforeCustGradeNm = "";
var sel_FilterExpr = "2";
var strFavorDept1YN = "";
var strFavorDept2YN = "";
var strFavorDept3YN = "";
var strFavorDept4YN = "";
var strFavorDept5YN = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**     
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
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
function doInit(){

    //Input Data Set Header 초기화
    //기명회원가입신청서 등록.
    //Output Data Set Header 초기화
    DS_IO_CUST.setDataHeader('<gauce:dataset name="H_CUSTINFO"/>');
    DS_O_CARD.setDataHeader('<gauce:dataset name="H_CARD"/>');
    
    DS_IO_CUST.ClearData();
    DS_IO_CUST.AddRow();
    
    //EMedit에 초기화    
    initEmEdit(EM_SS_NO_S,      "000000",      		   NORMAL);         //생년월일/사업자번호
    initEmEdit(EM_CARD_NO_S,    "0000-0000-0000-0000", NORMAL);         //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_CUST_NAME,    "GEN^50",              PK);             //성명
    initEmEdit(EM_CHKSAVE,      "GEN^1",               NORMAL);         //저장시에 I,U 구분.
    initEmEdit(EM_CUST_ID,      "GEN",                 NORMAL);                         
    initEmEdit(EM_HHOLD_ID,     "GEN",                 NORMAL); 
    initEmEdit(EM_SS_NO,        "000000",      		   PK);             //생년월일/사업자번호
    initEmEdit(EM_HNEW_ADDR1,   "GEN^200",             PK);   
    initEmEdit(EM_HNEW_ADDR2,   "GEN^200",             PK);
    initEmEdit(EM_HOME_ADDR1,   "GEN^200",    PK);   
    initEmEdit(EM_HOME_ADDR2,   "GEN^200",    PK);
    initEmEdit(EM_HNEW_ZIP_CD1, "GEN^5",          PK);
    initEmEdit(EM_HNEW_ZIP_CD2, "GEN^5",          PK);
    initEmEdit(EM_HOME_ZIP_CD1, "GEN^5", NORMAL);
    initEmEdit(EM_HOME_ZIP_CD2, "GEN^5", NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD1, "GEN^5",          NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD2, "GEN^5",          NORMAL);
    initEmEdit(EM_EMAIL1,       "GEN^50",              NORMAL);
    initEmEdit(EM_EMAIL3,       "GEN^50",              NORMAL);
    initEmEdit(EM_ON_TERMS5_DATE,       "GEN^50",              NORMAL);
    
    initEmEdit(EM_CARD_PWD_NO,  "0000",                PK);          //카드비밀번호
    initEmEdit(EM_OFFI_ADDR1,   "GEN^200",             NORMAL);   
    initEmEdit(EM_OFFI_ADDR2,   "GEN^200",             NORMAL);
    initEmEdit(EM_HOME_PH1,     "0000",                NORMAL);
    initEmEdit(EM_HOME_PH2,     "0000",                NORMAL);
    initEmEdit(EM_HOME_PH3,     "0000",                NORMAL);
    initEmEdit(EM_MOBILE_PH1,   "0000",                PK);
    initEmEdit(EM_MOBILE_PH2,   "0000",                PK);
    initEmEdit(EM_MOBILE_PH3,   "0000",                PK);    
    initEmEdit(EM_WED_DT,       "YYYYMMDD",            NORMAL);
    initEmEdit(EM_BIRTH_DT,     "YYYYMMDD",            PK);
    initEmEdit(EM_OFFI_PH1,     "0000",                NORMAL);
    initEmEdit(EM_OFFI_PH2,     "0000",                NORMAL);
    initEmEdit(EM_OFFI_PH3,     "0000",                NORMAL);
    initComboStyle(LC_EMAIL2,DS_O_EMAIL2, "CODE^0^30,NAME^0^90", 1, NORMAL);       //이메일주소목록
    initComboStyle(LC_FOREIGN,DS_O_FOREIGN, "CODE^0^30,NAME^0^110", 1, NORMAL);          //외국인국적
    initEmEdit(EM_OFFI_NM,      "GEN^40",              NORMAL);                    //직장부서명
    initEmEdit(EM_DEPT_NAME,    "GEN^40",              NORMAL);                    //부서
    initComboStyle(LC_POSITION,DS_O_POSITION, "CODE^0^30,NAME^0^110", 1, NORMAL);  //직위
    initEmEdit(EM_POSITION_ETC, "GEN^40",              NORMAL);                    //직위 - 기타
    initEmEdit(EM_HOME_NEW_YN,  "GEN^1",               NORMAL);                    //집 - 구/신주소여부
    initEmEdit(EM_OFFI_NEW_YN,  "GEN^1",               NORMAL);                    //회사 - 구/신주소여부
    initEmEdit(EM_AGENT_NAME,   "GEN^40",              NORMAL);        //대리인성명
    initEmEdit(EM_AGENT_SSNO,   "000000-0000000",      NORMAL);        //대리인주민번호
    initComboStyle(LC_AGENT_RELATION,DS_O_AGENT_RELATION, "CODE^0^30,NAME^0^110", 1, NORMAL); //관계
    initEmEdit(EM_AGENT_PH1,      "0000",              NORMAL);        //대리인전화번호1
    initEmEdit(EM_AGENT_PH2,      "0000",              NORMAL);        //대리인전화번호2
    initEmEdit(EM_AGENT_PH3,      "0000",              NORMAL);        //대리인전화번호3
    initEmEdit(EM_LEGAL_AGENT,    "GEN^40",            NORMAL);        //법정대리인
    
    initEmEdit(EM_OFF_TERMS1_DT,"YYYYMMDD",   PK);            //개인정보의 수집 및 이용 동의일자
    initEmEdit(EM_OFF_TERMS1_NAME,"GEN^40",   PK);            //개인정보의 수집 및 이용 동의자
    initEmEdit(EM_OFF_TERMS2_DT,  "YYYYMMDD", PK);            //고유식별정보 수집 및 이용동의일자
    initEmEdit(EM_OFF_TERMS2_NAME,"GEN^40",   PK);            //고유식별정보 수집 및 이용동의일자
    initEmEdit(EM_OFF_TERMS3_DT,  "YYYYMMDD", PK);            //개인정보 처리업무 위탁 동의일자
    initEmEdit(EM_OFF_TERMS3_NAME,"GEN^40",   PK);            //개인정보 처리업무 위탁 동의자
    initEmEdit(EM_OFF_TERMS4_DT,  "YYYYMMDD", PK);            //개인정보 제3자 제공 동의일자
    initEmEdit(EM_OFF_TERMS4_NAME,"GEN^40",   PK);            //개인정보 제3자 제공 동의자
    
    initEmEdit(EM_ENTR_DT,        "YYYYMMDD",          PK);            //가입일자
    initComboStyle(LC_ID_CHECK,DS_O_ID_CHECK, "CODE^0^30,NAME^0^110", 1, PK);  //신분증확인
    initEmEdit(EM_ISSUE_ORG,      "GEN^40",            NORMAL);        //발행기관
    initEmEdit(EM_ISSUE_DT,       "YYYYMMDD",          NORMAL);        //발행일자

    initComboStyle(LC_CUST_GRADE, DS_O_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
    initComboStyle(LC_VIP_FLAG,   DS_O_VIP_FLAG,   "CODE^0^30,NAME^0^110", 1, PK); //VIP등록구분
    
    initEmEdit(EM_O_PUMBUN_CD,   "CODE^6^0", 		   PK);  		   //품번코드(조회)
    initEmEdit(EM_O_PUMBUN_NM,   "GEN^40",			   READ);  		   //품번명(조회)
    initEmEdit(EM_ISSUE_CNT,     "GEN^4",              NORMAL);        //카드비밀번호
    initComboStyle(LC_CUST_TYPE,DS_O_CUST_TYPE, "CODE^0^30,NAME^0^110", 1, PK); //회원유형
    initComboStyle(LC_MOBILE_COMP,DS_O_MOBILE_COMP, "CODE^0^30,NAME^0^110", 1, NORMAL);          //통신사
	initComboStyle(LC_DIVISION,DS_O_DIVISION, "CODE^0^30,NAME^0^110", 1, NORMAL);          //통신사
	initComboStyle(LC_ENTR_CH,DS_O_ENTR_CH, "CODE^0^30,NAME^0^110", 1, NORMAL);          //통신사 
	initComboStyle(LC_CARD_GRADE,DS_O_CARD_GRADE, "CODE^0^30,NAME^0^110", 1, NORMAL);      //카드등급 
    
    initEmEdit(EM_REG_COL,   "GEN^40",			   READ);  		   //최초입력자
    initEmEdit(EM_MOD_COL,   "GEN^40",			   READ);  		   //최종수정자
    

    //콤보 초기화
    initComboStyle(LC_STR_CD, DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점
    getStore("DS_S_STR_CD", "N", "", "N");       //점(조회) 
    
    EM_CHKSAVE.Visible           = "false";
    EM_CUST_ID.Visible           = "false";
    EM_HHOLD_ID.Visible          = "false";
    EM_CHKSAVE.style.display     = "none";
    EM_CUST_ID.style.display     = "none";
    EM_HHOLD_ID.style.display    = "none";
    EM_CARD_NO.style.display     = "none";
    EM_HOME_NEW_YN.style.display = "none";      
    EM_OFFI_NEW_YN.style.display = "none";      
    EM_EMAIL3.style.display      = "none"; 
    LC_VIP_FLAG.style.display    = "none";    
                                                
    getEtcCode("DS_O_EMAIL2", "D", "D013", "N");
    getEtcCode("DS_O_FOREIGN", "D", "D122", "N");
    getEtcCode("DS_O_CARD_TYPE_CD", "D", "D029", "N");

    getEtcCode("DS_O_POSITION",   "D", "D045", "N");
    getEtcCode("DS_O_AGENT_RELATION",  "D",    "D042", "N");
    getEtcCode("DS_O_ID_CHECK",   "D", "D046", "N");
    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "N");
    getEtcCode("DS_O_VIP_FLAG",   "D", "D068", "N");
    getEtcCode("DS_O_CUST_TYPE", "D", "D115", "N");    
    getEtcCode("DS_O_MOBILE_COMP", "D", "D131", "N");
	getEtcCode("DS_O_ENTR_CH", "D", "D133", "N");
	getEtcCode("DS_O_DIVISION", "D", "D134", "N"); 
	getEtcCode("DS_O_CARD_GRADE", "D", "D011", "N"); //카드등급
	
	
    EM_CI.Text = "";
    EM_DI.Text = "";
    RD_EMAIL_YN.CodeValue      = "Y";
    RD_WED_YN.CodeValue        = "N";
    RD_LUNAR_FLAG.CodeValue    = "S";
    RD_SMS_YN.CodeValue        = "Y";
    RD_POST_RCV_CD.CodeValue   = "H";
    RD_HOUSE_FLAG.CodeValue    = "9";
    RD_HOUSE_TYPE.CodeValue    = "4";
    RD_NOCLS_REQ_YN.CodeValue  = "N";
    RD_ALIEN_YN.CodeValue      = "N";
    RD_NAME_CONF_YN.CodeValue  = "N"
    RD_SEX_CD.CodeValue		   = "F";
    RD_OFF_TERMS1_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_OFF_TERMS2_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_OFF_TERMS3_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    RD_OFF_TERMS4_YN.CodeValue = "Y";            //개인정보 제3자 제공 동의여부
    LC_CUST_GRADE.BindColVal   = "21";
    LC_CUST_TYPE.BindColVal    = "10";
    LC_CARD_GRADE.BindColVal   = "21";

    RD_TM_YN.CodeValue      = "N";
    EM_CHKSAVE.Text      = "I";
    LC_EMAIL2.BindColVal = "99";
    LC_ID_CHECK.BindColVal = "";
    EM_CUST_NAME.Language = 1;
    LC_MOBILE_COMP.index = 0;
	LC_DIVISION.index = 0;
	LC_ENTR_CH.index = 0;
    
	//결혼여부에 의한 속성제어
    EM_WED_DT.Text      = "";  
    setEnable(false);
    
    DS_O_CUST_GRADE.Filter();
    
    EM_HNEW_ZIP_CD1.Enable = false;
    EM_HNEW_ZIP_CD2.Enable = false;
    EM_HNEW_ADDR1.Enable   = false;
    
	EM_HOME_ZIP_CD1.Enable = false;
	EM_HOME_ZIP_CD2.Enable = false;
    EM_HOME_ADDR1.Enable   = false;
    
    EM_OFFI_ZIP_CD1.Enable = false;
    EM_OFFI_ZIP_CD2.Enable = false;
    EM_OFFI_ADDR1.Enable   = false;
    EM_ON_TERMS5_DATE.Enable   = false;

    EM_AGENT_NAME.Enable      = false;     
    EM_AGENT_SSNO.Enable      = false;     
    LC_AGENT_RELATION.Enable  = false;
    EM_AGENT_PH1.Enable       = false;      
    EM_AGENT_PH2.Enable       = false;      
    EM_AGENT_PH3.Enable       = false;      
    EM_LEGAL_AGENT.Enable     = false;    
    LC_ID_CHECK.Enable        = false;       
    EM_ISSUE_ORG.Enable       = false;      
    EM_ISSUE_DT.Enable        = false;
    EM_ISSUE_CNT.Enable       = false;
    enableControl(IMG_ISSUE_DT , false);
    LC_CARD_GRADE.Enable      = false;

    EM_HNEW_ZIP_CD1.Alignment = 1;
    EM_HNEW_ZIP_CD2.Alignment = 1;
    EM_HOME_ZIP_CD1.Alignment = 1;
	EM_HOME_ZIP_CD2.Alignment = 1;
    EM_OFFI_ZIP_CD1.Alignment = 1;
    EM_OFFI_ZIP_CD2.Alignment = 1;
    
    //EM_CARD_NO_S.Focus();
    EM_CARD_NO_CUT.Focus();
    
     
    //신청서 화면이므로 최초 addrow Dataset status 초기화.
    DS_IO_CUST.ResetStatus();
    
    if("<%=strSsNo%>" != "" || "<%=strCardNo%>" != ""){
    	EM_SS_NO_S.Text = "<%=strSsNo%>";
    	EM_CARD_NO_S.Text = "<%=strCardNo%>";
    	showMaster();
    }
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm203","DS_IO_CUST");
    
    EM_HNEW_ZIP_CD2.style.display="none";
    
    RD_ENTR_GAIN.CodeValue	   = "0";	// 맴버쉽가입고객 지급 혜택
    RD_ENTR_GAIN.Enable		   = "false";
}

function gridCreate1(){
    var hdrProperies = '';                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일]중 1개는  반드시 입력해야 합니다.");
	    EM_CARD_NO_S.Focus();
	    return;
	}else{
        // MARIO OUTLET
		//if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
        if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13 또는 16자리입니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
        if(trim(EM_SS_NO_S.Text).length == 6){}
        else if (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
            EM_SS_NO_S.Focus();
            return;   
        }
    }
      
    showMaster();
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
	strFlag  = "INS";
    var em = document.all.tags("object");
    if (em!=null){
      for (i = 0; i < em.length; i++) {
        
        if(em[i].classid=="<%=Util.CLSID_EMEDIT%>"){
        	em[i].Text = "";
        }
      }
    }
    doClearDt();
    //신청서 화면이므로 최초 addrow Dataset status 초기화.
    DS_IO_CUST.ResetStatus();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개    요 : DB에 저장
 * return값 : void
 */
function btn_Save() {

	var chk;
    if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
      || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
        chk = juminCheck(EM_SS_NO.Text);
    }else{
        chk = juminCheckFore(EM_SS_NO.Text);
    }

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
    if(trim(EM_CUST_NAME.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_CUST_NAME.Focus();
        return false;
    }
    if(trim(EM_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "주민번호");
        EM_SS_NO.Focus();
        return false;
    }
	if(trim(EM_SS_NO.text).length == 6) chk = true;

    if(chk==false){
        if (showMessage(EXCLAMATION, YESNO, "USER-1000",  "유효한 주민번호가 아닙니다. 수정하시겟습니까?") != 1 ) {
            EM_SS_NO.Focus();
            return false;	
        }
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
        getPostPop_dcs(EM_HNEW_ZIP_CD1,EM_HNEW_ZIP_CD2,EM_HNEW_ADDR1,EM_HNEW_ADDR2,EM_HOME_NEW_YN);
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
        showMessage(EXCLAMATION, OK, "USER-1003",  "이메일주소");
        EM_EMAIL1.Focus();
        return;
    }
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
/*    
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
    
   /* if(trim(RD_OFF_TERMS2_YN.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의여부");
        RD_OFF_TERMS2_YN.Focus();
        return false;
    }*/
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
    //if(trim(EM_CI.text) == ""){
    //    showMessage(EXCLAMATION, OK, "USER-1000",  "본인인증은 반드시 해야 합니다");
    //    return false;
    //}
    /*
    if(LC_CUST_GRADE.BindColVal == "41" && trim(LC_VIP_FLAG.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "VIP등록구분");
        LC_VIP_FLAG.Focus();
        return false;
    }

    strFavorDept1YN = (document.getElementById("FAVOR_DEPT1").checked == true)? "Y":"N";
    strFavorDept2YN = (document.getElementById("FAVOR_DEPT2").checked == true)? "Y":"N";
    strFavorDept3YN = (document.getElementById("FAVOR_DEPT3").checked == true)? "Y":"N";
    strFavorDept4YN = (document.getElementById("FAVOR_DEPT4").checked == true)? "Y":"N";
    strFavorDept5YN = (document.getElementById("FAVOR_DEPT5").checked == true)? "Y":"N";
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT1_YN")  = strFavorDept1YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT2_YN")  = strFavorDept2YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT3_YN")  = strFavorDept3YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT4_YN")  = strFavorDept4YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT5_YN")  = strFavorDept5YN; 
    */
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
 * doClearDt()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개       요 : 설정초기화
 * return값 : void
 */
function doClearDt(){
	sel_FilterExpr = "2";
    DS_O_CUST_GRADE.Filter();

    RD_ALIEN_YN.CodeValue      = "N";
    RD_NAME_CONF_YN.CodeValue  = "N";
	RD_EMAIL_YN.CodeValue      = "Y";
	RD_WED_YN.CodeValue        = "N";
	RD_LUNAR_FLAG.CodeValue    = "S";
	RD_SMS_YN.CodeValue        = "Y";
	RD_OFF_TERMS2_YN.CodeValue = "Y";
	
	RD_POST_RCV_CD.CodeValue   = "H";
    RD_HOUSE_FLAG.CodeValue    = "9";
	RD_HOUSE_TYPE.CodeValue    = "4";
	RD_NOCLS_REQ_YN.CodeValue  = "N";
    LC_VIP_FLAG.style.display  = "none";    
    LC_CUST_GRADE.BindColVal   = "21" ;
    LC_CUST_TYPE.BindColVal    = "10";
   
	EM_CHKSAVE.Text = "I";
	LC_EMAIL2.BindColVal = "99";
	LC_AGENT_RELATION.BindColVal = "";

	//성명,주민번호,주소 수정버튼 비활성화
    IMG_MODIFY_NAME.disabled = true;
    //IMG_SOCIALNUM.disabled   = true;
    IMG_MODIFY_HOME_JUSO.disabled 	= true;
    IMG_MODIFY_OFFI_JUSO.disabled   = true;
    IMG_TELNUM.disabled   = true;
    
    LC_CUST_GRADE.Enable = true;
    EM_WED_DT.Enable     = false;  
    EM_CUST_NAME.Enable  = true;
    EM_SS_NO.Enable      = true;
    EM_HNEW_ADDR2.Enable = true;
    EM_OFFI_ADDR2.Enable = true;    
    EM_ISSUE_CNT.Enable  = false;
    
    EM_MOBILE_PH1.Enable  = true;
    EM_MOBILE_PH2.Enable  = true;
    EM_MOBILE_PH3.Enable  = true;
    EM_CARD_NO_S.Enable   = true;
    /*
    document.getElementById("FAVOR_DEPT1").checked = false;
    document.getElementById("FAVOR_DEPT2").checked = false;
    document.getElementById("FAVOR_DEPT3").checked = false;
    document.getElementById("FAVOR_DEPT4").checked = false;
    document.getElementById("FAVOR_DEPT5").checked = false;
*/
    LC_POSITION.BindColVal = "";
    LC_ID_CHECK.BindColVal = "";
    //결혼여부에 의한 속성제어
    EM_WED_DT.Text      = "";  
    setEnable(false);
    
    strBeforeCustGrade   = "";
    strBeforeCustGradeNm = "";
    
    //EM_CARD_NO_S.Focus();
    EM_CARD_NO_CUT.Focus();
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
 * saveData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개    요 : 개인회원  등록 저장
 * return값 : void
 */
function saveData(){ 

	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "COMP_PERS_FLAG")  = "P";                   // 법인/개인구분
	if(LC_EMAIL2.BindColVal == "99"){
	       DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = EM_EMAIL3.Text;
	}else{
	       DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = LC_EMAIL2.Text;
	}
	if(RD_EMAIL_YN.CodeValue == "Y"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "<%=toDate%>";          // 등록일자
    }else{
    	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "";                      // 등록일자
    }
    if(RD_SMS_YN.CodeValue == "Y"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SMS_AGREE_DT")   = "<%=toDate%>";
    }else{
    	 DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SMS_AGREE_DT")  = "";
    }                                                      
	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_STAT_FLAG") = "0";                    //회원상태
	/*
    var strAlienYN = "";
    if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
    || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){ 
        strAlienYN = "N";
    }else{
        strAlienYN = "Y";
    }
    if(trim(EM_SS_NO.text).length == 6) strAlienYN = "N";
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "ALIEN_YN")       = strAlienYN;         //외국인여부
    */
    //미성년자 여부 확인
    var intAge = getAge(EM_SS_NO.Text, "<%=toDate%>");
    
    var strChksave = EM_CHKSAVE.Text;
    var parameters = "&strChksave="+ encodeURIComponent(strChksave)
                   + "&strAge="    + encodeURIComponent(intAge)
                   + "&strUpdate=Y";

    TR_MAIN.Action="/dcs/dctm203.dm?goTo=saveData"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CUST=DS_IO_CUST)";
    TR_MAIN.Post();  
 
    if( TR_MAIN.ErrorCode == 0){
    	showMaster();
    }
    
}

/**
 * showMaster()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-14
 * 개       요 : 카드번호, 주민번호로 회원정보를 가져온다.
 * return값 : void
 */
function showMaster(){
	
	EM_EMAIL3.text = ""; 
	flag = true;
	strBeforeCustGrade   = "";
	strBeforeCustGradeNm = "";
	
    sel_FilterExpr = "2";
    DS_O_CUST_GRADE.Filter();
    
    var strMobilePh1 = EM_MOBILE_PH1.Text;
    var strMobilePh2 = EM_MOBILE_PH2.Text;
    var strMobilePh3 = EM_MOBILE_PH3.Text;

    
	DS_IO_CUST.ClearData();

    var strCardNo  = EM_CARD_NO_S.text;
    var strSsNo    = EM_SS_NO_S.text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strCardNo=" + encodeURIComponent(strCardNo)
                   + "&strSsno="   + encodeURIComponent(strSsNo)
				   + "&strMobilePh1=" + encodeURIComponent(strMobilePh1)
				   + "&strMobilePh2=" + encodeURIComponent(strMobilePh2)
				   + "&strMobilePh3=" + encodeURIComponent(strMobilePh3);
	 
    TR_MAIN.Action  ="/dcs/dctm203.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CUST=DS_IO_CUST)"; //조회는 O
    TR_MAIN.Post();

    if(DS_IO_CUST.CountRow > 0){  
    	strFlag = "UPD";
    	/*
    	strFavorDept1YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT1_YN");
        strFavorDept2YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT2_YN");
        strFavorDept3YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT3_YN");
        strFavorDept4YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT4_YN");
        */
        if(EM_CHKSAVE.Text=="U"){
            EM_CUST_NAME.Enable  = "false";
            EM_SS_NO.Enable      = "false";
            EM_HNEW_ADDR2.Enable = "false";
            EM_OFFI_ADDR2.Enable = "false";
            
            EM_BIRTH_DT.Enable  = false;
            IMG_BIRTH_DT.disabled = true;
            
            EM_MOBILE_PH1.Enable  = false;
            EM_MOBILE_PH2.Enable  = false;
            EM_MOBILE_PH3.Enable  = false;
            
            //비밀번호 조회 처리 17.01.02
            //if(EM_CARD_PWD_NO.Text!=""){
            //    EM_CARD_PWD_NO.Text = "****";
            //}
            
            strBeforeCustGrade   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"CUST_GRADE");
            strBeforeCustGradeNm = LC_CUST_GRADE.Text;
        }
        
        if(EM_EMAIL1.Text != ""){
            LC_EMAIL2.Text   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2");
            LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", EM_EMAIL3.Text);
        }
        
        if(strFlag == "UPD" && LC_EMAIL2.BindColVal == ""){
            setComboData(LC_EMAIL2,"99");
            EM_EMAIL3.style.display = "";
        }else{
            EM_EMAIL3.Text = ""; 
            EM_EMAIL3.style.display = "none";
        }
        if(RD_WED_YN.CodeValue=="Y"){
            setEnable(true);
        }
        /*
        if(strFavorDept1YN == "Y") document.getElementById("FAVOR_DEPT1").checked = true;
        if(strFavorDept2YN == "Y") document.getElementById("FAVOR_DEPT2").checked = true;
        if(strFavorDept3YN == "Y") document.getElementById("FAVOR_DEPT3").checked = true;
        if(strFavorDept4YN == "Y") document.getElementById("FAVOR_DEPT4").checked = true;
        */
        
        //성명,주민번호,주소 수정버튼  활성화
        IMG_MODIFY_NAME.disabled = false;
        //IMG_SOCIALNUM.disabled   = false;
        IMG_MODIFY_HOME_JUSO.disabled 	= false;
        IMG_MODIFY_OFFI_JUSO.disabled   = false;
        IMG_TELNUM.disabled   = false;

        //EM_CARD_PWD_NO.Focus();
        //document.getElementById('IMG_REAL_NAME').focus();
        DS_IO_CUST.UserStatus(1) = 0;

        if(trim(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"SCED_REQ_DT")) != ""){
            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 회원정보 수정이 불가합니다.");
            btn_New();
            setTimeout("EM_AGENT_SSNO.Focus();",50);
            return false;
        }

        //미성년자 여부 확인
        /**        
        if(intAge < 14){
        	sel_FilterExpr = "1";
        	DS_O_CUST_GRADE.Filter();
            LC_CUST_GRADE.BindColVal = "11";
            LC_CUST_GRADE.Enable     = false;
        }else{
            LC_CUST_GRADE.Enable     = true;
        }
        */
        
        //카드발급횟수 활성화
        if(EM_ISSUE_CNT.Text > 0){
        	EM_ISSUE_CNT.Enable      = true;
        }

        //신청서 화면이므로 최초 addrow Dataset status 초기화.
        DS_IO_CUST.ResetStatus();
        
        EM_CARD_NO_S.enabled = false;

    }else{
        //설정초기화
        doClearDt();
    }
}

/**
 * editSsno()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개      요  : 주민번호 변경
 * return값 : void
 */
function editSsno(objCd)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	
    var returnVal = window.showModalDialog("/dcs/dctm203.dm?goTo=editSsno&ssNo="+EM_SS_NO.Text+"&custId="+EM_CUST_ID.Text,
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:145px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("SS_NO");

		//생년월일 기본 세팅.
		if(objCd.Text.length == 6) EM_BIRTH_DT.Text = "19"+objCd.Text.substring(0,6);
	    if(objCd.Text.substring(7,8)=="1" || objCd.Text.substring(7,8)=="2"){
	        EM_BIRTH_DT.Text = "19"+objCd.Text.substring(0,6);
	    }else if(objCd.Text.substring(7,8)=="3" || objCd.Text.substring(7,8)=="4"){
	        EM_BIRTH_DT.Text = "20"+objCd.Text.substring(0,6);
	    }
		
	    EM_CARD_PWD_NO.Focus();
 	}
}

/**
 * editCustnm()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 회원명 변경
 * return값 : void
 */
function editCustnm(objNm)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(EM_CUST_ID.Text);
	arrArg.push(objNm.Text);
    var returnVal = window.showModalDialog(encodeURI("/dcs/dctm203.dm?goTo=editCustnm"),
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:145px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		objNm.Text = map.get("CUST_NAME");
		EM_CARD_PWD_NO.Focus();
 	}
}

/**
 * editJuso()
 * 작 성 자 : kj
 * 작 성 일 : 2012-05-16
 * 개       요 : 주소 변경
 * return값 : void
 */
function editJuso(strAddrFlag)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(EM_CUST_ID.Text);
	arrArg.push(EM_HOME_NEW_YN.Text);
	arrArg.push(EM_HNEW_ZIP_CD1.Text);
	arrArg.push(EM_HNEW_ZIP_CD2.Text);
	arrArg.push(EM_HNEW_ADDR1.Text);
	arrArg.push(EM_HNEW_ADDR2.Text);
	arrArg.push(EM_OFFI_NEW_YN.Text);
	arrArg.push(EM_OFFI_ZIP_CD1.Text);
	arrArg.push(EM_OFFI_ZIP_CD2.Text);
	arrArg.push(EM_OFFI_ADDR1.Text);
	arrArg.push(EM_OFFI_ADDR2.Text);
	arrArg.push(EM_O_PUMBUN_CD.Text);
	arrArg.push(strAddrFlag);

		
    var returnVal = window.showModalDialog(encodeURI("/dcs/dctm203.dm?goTo=editJuso"),
                                           arrArg,
                                           "dialogWidth:820px;dialogHeight:145px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		var map = arrArg[0]; 
  		if(map.get("SEL_JUSO") == "H"){
	  		//도로명주소
  			EM_HNEW_ZIP_CD1.Text 	= map.get("HNEW_ZIP_CD1");
	  		EM_HNEW_ZIP_CD2.Text 	= map.get("HNEW_ZIP_CD2");
	  		EM_HNEW_ADDR1.Text 		= map.get("HNEW_ADDR1");
	  		EM_HNEW_ADDR2.Text 		= map.get("HNEW_ADDR2");
	  		//구주소
	  		EM_HOME_ADDR1.Text 		= map.get("HOME_ADDR1"); 
	  		EM_HOME_ADDR2.Text 		= map.get("HOME_ADDR2"); 
  		}else{
	  		EM_OFFI_ZIP_CD1.Text 	= map.get("OFFI_ZIP_CD1");
	  		EM_OFFI_ZIP_CD2.Text 	= map.get("OFFI_ZIP_CD2");
	  		EM_OFFI_ADDR1.Text 		= map.get("OFFI_ADDR1");
	  		EM_OFFI_ADDR2.Text 		= map.get("OFFI_ADDR2");
  		} 
  	}
}

 /**
 * editCardno()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-27
 * 개      요  : 카드번호 변경
 * return값 : void
 */
 function editCardno(objCd){
	 
    if(trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드정보를 입력 해주세요.");
        return false;
    }
    
	DS_IO_CARD.ClearData();
	
	//카드상태값 체크 
	var strCardNo  = EM_CARD_NO_S.text;
	  
    var goTo       = "searchChk_Card" ;    
    var parameters = "&strCardNo=" + encodeURIComponent(strCardNo) ;
	 
    TR_MAIN.Action  ="/dcs/dctm203.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_CARD=DS_IO_CARD)"; //조회는 O
    TR_MAIN.Post(); 
      
   	if(DS_IO_CARD.NameValue(1,"CNT")== 0){
       	showMessage(INFORMATION, OK, "USER-1000", "카드정보의 카드상태가 정상이 아닌 카드번호를 수정할 수 없습니다. 카드번호를 확인해주세요.");  
		return false;
   	} 
    
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);	 //카드번호
	arrArg.push(EM_CUST_ID.Text);//고객번호
	  
    var returnVal = window.showModalDialog("/dcs/dctm203.dm?goTo=editCardno",
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:145px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
  	if (returnVal){
		var map = arrArg[0];
		//objCd.Text = map.get("CARD_NO");  
		EM_CARD_NO_S.Focus();
 	}
 }

  /**
  * editTelno()
  * 작 성 자 : 윤지영
  * 작 성 일 : 2016-12-27
  * 개      요  : 휴대전화 변경
  * return값 : void
  */
  function editTelno(objCd1,objCd2,objCd3){
 	 
     if(trim(EM_MOBILE_PH1.Text).length == 0 || trim(EM_MOBILE_PH2.Text).length == 0 || trim(EM_MOBILE_PH3.Text).length == 0 ){
         showMessage(EXCLAMATION, OK, "USER-1000",  "휴대전화 정보를 입력 해주세요.");
         return false;
     } 
     
	var rtnMap  = new Map();
	var arrArg  = new Array();

	arrArg.push(rtnMap);
	arrArg.push(objCd1.Text);	  
	arrArg.push(objCd2.Text);	  
	arrArg.push(objCd3.Text);	  
	arrArg.push(EM_CUST_ID.Text); //고객번호 
	
    var returnVal = window.showModalDialog("/dcs/dctm203.dm?goTo=edit_Telno",
								            arrArg,
								            "dialogWidth:540px;dialogHeight:145px;scroll:no;" +
								            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
   	if (returnVal){
 		var map = arrArg[0]; 
 		objCd1.Text = map.get("AFT_MOBILE_PH1");  
 		objCd2.Text = map.get("AFT_MOBILE_PH2");  
 		objCd3.Text = map.get("AFT_MOBILE_PH3");  
 		//EM_MOBILE_PH1.Focus();
  	}
  }

/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개      요  : 회원메모관리 화면으로 이동
 * return값 : void
 */
function gourl(){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}	     
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM112","/dcs/dctm112.dm?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text+"&strCompPersFlag=P","DCTM","01","회원메모관리");
}

function gourl2(go,nm,s){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text,s,"01",nm);
}

/**
 * fn_chkYn(obj)
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-07-15
 * 개      요  : 체크박스
 * return값 : void
 */ 
function fn_chkYn(strBeYN,obj){
	if(strBeYN == "undefined" || strBeYN == "Y"){
		strBeYN = "";
	}
    if(document.getElementById(obj).checked == true){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, obj+"_YN") = "Y";
    }else{
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, obj+"_YN") = strBeYN;
    }
}

/**
* confirmName()
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
* sendSMS()
* 작 성 자 : 전주원
* 작 성 일 : 2015. 04. 21
* 개       요 : 휴대폰인증 팝업
* return값 : void
*/
function sendSMS()
{	
	
	var rtnMap  = new Map();
    var arrArg  = new Array();
    
    if(trim(EM_CUST_ID.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "회원조회를 해주세요.");
        return false;
    }

    arrArg.push(rtnMap);
	arrArg.push(EM_CUST_NAME.Text);
	arrArg.push(EM_CUST_ID.Text);
	arrArg.push(RD_SMS_YN.CodeValue);
	arrArg.push(EM_MOBILE_PH1.Text);
	arrArg.push(EM_MOBILE_PH2.Text);
	arrArg.push(EM_MOBILE_PH3.Text);
	
	
	var returnVal = window.showModalDialog("/dcs/dctm102.dm?goTo=sendSMS",
					arrArg,
		            "dialogWidth:350px;dialogHeight:170px;scroll:no;" +
		            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	
    /*       
  	if (returnVal){
		var map = arrArg[0];
		
		RD_NAME_CONF_YN.CodeValue = map.get("CONF_YN");
		if(map.get("CONF_YN") == "Y"){
			
			EM_CUST_NAME.Text = map.get("CUST_NAME");
			EM_MOBILE_PH1.Text = map.get("MOBILE_PH1");
			EM_MOBILE_PH2.Text = map.get("MOBILE_PH2");
			EM_MOBILE_PH3.Text = map.get("MOBILE_PH3");
		
		}
 	} 
  	*/
  	
}

--></script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", "정상적으로 변경 되었습니다.");
        if(EM_EMAIL1.Text != ""){
            LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
        }
        if( LC_EMAIL2.BindColVal == "" ){
            setComboData(LC_EMAIL2,"99");
        }
        EM_CARD_PWD_NO.Focus();
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
<script language=JavaScript for=DS_O_CUST_GRADE event=onFilter(row)>
    switch (sel_FilterExpr) {
    case "1":
        return true;
        break;
    case "2":
        if (DS_O_CUST_GRADE.NameValue(row,"CODE") != "11") return true
        else return false;
        break;
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
	//EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    }  
</script>



<script language=JavaScript for=LC_CUST_TYPE event=OnSelChange()>

	if(LC_CUST_TYPE.BindColVal == "30") {
		EM_ON_TERMS5_DATE.Enable= true;
		EM_ON_TERMS5_DATE.focus();
	} else {
		EM_ON_TERMS5_DATE.Enable= false;
		EM_ON_TERMS5_DATE.text="";
	}

</script>


<script language=JavaScript for=RD_ALIEN_YN event=OnSelChange()>

	if(RD_ALIEN_YN.CodeValue == "Y")
	{
		LC_FOREIGN.ENABLE = "TRUE";
		LC_CUST_GRADE.BindColVal = "51";
	} else {
		LC_FOREIGN.ENABLE = "FALSE";
		LC_FOREIGN.text = "";
		LC_FOREIGN.value = "";
		LC_CUST_GRADE.BindColVal = "21";
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
<!-- 휴대전화 onKeyUp()()-->
<script language=JavaScript for=EM_MOBILE_PH1 event=onKeyUp()>
/*
	if(trim(EM_MOBILE_PH1.Text).length == 3){
    	setTimeout( "EM_MOBILE_PH2.Focus();",50);
    }
    */
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
<!-- 회원등급 OnSelChange() -->
<script language=JavaScript for=LC_CUST_GRADE event=OnSelChange()>
    //기존등급 => 등급변경시  QUESTION
    if( strFlag != "INS" && DS_IO_CUST.IsUpdated && strBeforeCustGradeNm != "" ){
        if(strBeforeCustGradeNm != LC_CUST_GRADE.Text){
            if( showMessage(QUESTION, YESNO, "USER-1000", strBeforeCustGradeNm+"에서 "+LC_CUST_GRADE.Text+"(으)로 회원등급을 조정하시겠습니까?") != 1 ){
            	LC_CUST_GRADE.BindColVal = strBeforeCustGrade;
                return;
            }
        }
    }
    if(LC_CUST_GRADE.BindColVal == "41"){
        LC_VIP_FLAG.style.display = "";
        LC_VIP_FLAG.BindColVal    = ""
    }else{
        LC_VIP_FLAG.style.display = "none";
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

<!-- 주민 번호 onKillFocus() -->
<script language=JavaScript for=EM_SS_NO_S event=onKillFocus()>
    if(trim(EM_SS_NO_S.Text).length != 0){
        var chk;
        if(EM_SS_NO_S.Text.substring(6,7)=="1" || EM_SS_NO_S.Text.substring(6,7)=="2" 
          || EM_SS_NO_S.Text.substring(6,7)=="3" || EM_SS_NO_S.Text.substring(6,7)=="4"){
            chk = juminCheck(EM_SS_NO_S.Text);
        }else{
            chk = juminCheckFore(EM_SS_NO_S.Text);
        }
        if(trim(EM_SS_NO_S.text).length == 6) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 주민번호가 아닙니다.");
            EM_SS_NO_S.Text = "";
            setTimeout( "EM_SS_NO_S.Focus();",50);
            return false;
        }

   		if(EM_CARD_NO_S.text=="" && trim(EM_SS_NO_S.text).length == 6 && 
   				(trim(EM_MOBILE_PH1.text) == "" || trim(EM_MOBILE_PH2.text) == "" || trim(EM_MOBILE_PH3.text) == "")){
            showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
            if(trim(EM_MOBILE_PH1.text) == ""){
            	setTimeout("EM_MOBILE_PH1.Focus();",50);
            }else if(trim(EM_MOBILE_PH2.text) == ""){
            	setTimeout("EM_MOBILE_PH2.Focus();",50);
            }else if(trim(EM_MOBILE_PH3.text) == ""){
            	setTimeout("EM_MOBILE_PH3.Focus();",50);
            }   		
        }else{    
        	showMaster();
        }
    }
</script>
<!-- 카드 번호onKeyUp(kcode,scode) -->
<script language=JavaScript for=EM_CARD_NO_S event=onKeyUp(kcode,scode)> 
//     if(trim(EM_CARD_NO_S.Text).length==13){
//     	showMaster();
//     }
</script>
<script language=JavaScript for=EM_CARD_NO_S event=onKillFocus()> 
    if(trim(EM_CARD_NO_S.Text).length==13){
    	showMaster();
    }
</script> 

<!-- 본인생일  onKillFocus() -->
<script language=JavaScript for=EM_BIRTH_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_BIRTH_DT)){
        //생년월일 기본 세팅.
        if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2"){
            EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
        }else if(EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
            EM_BIRTH_DT.Text = "20"+EM_SS_NO.Text.substring(0,6);
        }
        if(trim(EM_SS_NO.text).length == 6) EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
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

<!-- 가입일자  onKillFocus() -->
<script language=JavaScript for=EM_ENTR_DT event=onKillFocus()>
    checkDateTypeYMD(EM_ENTR_DT);
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
<object id="DS_O_FOREIGN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CUST" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_">
<object id="DS_O_EMAIL2" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_JOB_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CARD" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="Filter_s1.csv">
    <param name=UseFilter   value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_VIP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_DIVISION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ENTR_CH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script> 

<comment id="_NSID_">
<object id="DS_O_CARD_GRADE"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_CARD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script> 
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
	<div id="testdiv" class="testdiv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				class="o_table">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="87">카드번호</th>
							<td width="307">
			                    <comment id="_NSID_"> <object style="display:none"
								id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
								tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
							<comment id="_NSID_"> <object
								id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width=153
								tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script><img
						src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
						onclick="getCardPop(EM_CARD_NO_S,EM_CARD_NO_S,'P'); EM_CARD_NO_S.Focus();" />
						<img src="/<%=dir%>/imgs/btn/modify.gif" 
								tabindex=1 onclick="editCardno(EM_CARD_NO_S)" onkeydown="if(event.keyCode==13){editCardno(EM_CARD_NO_S)}" align="absmiddle"></td>
							
							<td><comment id="_NSID_"> <object id=EM_SS_NO_S
								classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1 style="display:none"> </object> </comment>
							<script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/memo_regi_s.gif" onclick="gourl()"
								tabindex=1 onkeydown="if(event.keyCode==13){gourl()}" align="absmiddle"></td>
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
            <td>
            <table width="100%">
                <tr>
	                <td width=100 class="sub_title PT07 PB02"><img
		                src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
		                align="absmiddle" class="PR03" /> 신청자정보
		            </td>
	                <td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" tabindex=1 onclick="gourl2('dctm201.dm','개인카드조회','DCTM')">개인카드조회</a></td>
						    <td class="btn_r"></td>
						    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" tabindex=1 onclick="gourl2('dmbo642.do','영수증사후적립','DMBO')">영수증사후적립</a></td>
						    <td class="btn_r"></td>
		    			    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" onclick="gourl2('dctm301.dm','포인트조회','DCTM')">포인트조회</a></td>
						    <td class="btn_r"></td>
						    <!-- <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" onclick="gourl2('dmbo999.do','회원정보안내(소멸예정)','DMBO')">회원정보안내(소멸예정)</a></td>
						    <td class="btn_r"></td> -->
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
                                id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=156
                                tabindex=1 align="absmiddle" onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"></object> </comment> <script> _ws_(_NSID_);</script>
                            <comment id="_NSID_"> <object id=EM_CHKSAVE
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
                            <object id=EM_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=0
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                                id="_NSID_"> <object id=EM_HHOLD_ID
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script> <comment
                                id="_NSID_"> <object id=EM_CARD_NO
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script><img
                                src="/<%=dir%>/imgs/btn/modify_name_s.gif" id="IMG_MODIFY_NAME" tabindex=1
                                onclick="editCustnm(EM_CUST_NAME)" onkeydown="if(event.keyCode==13){editCustnm(EM_CUST_NAME)}" align="absmiddle">
                            <img src="/<%=dir%>/imgs/btn/real_name.gif" tabindex=1 id="IMG_REAL_NAME"
								onkeydown="if(event.keyCode==13) confirmName();"  
								onclick="javascript:confirmName();" align="absmiddle" style="display:none"></td>
                           <th class="point" width=130>생년월일</th>
                            <td colspan="3"><comment id="_NSID_"> <object id=EM_SS_NO  width=156
                                classid=<%=Util.CLSID_EMEDIT%> width=60 align="absmiddle"
                                tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/modify.gif" tabindex=1
                                id="IMG_SOCIALNUM" onclick="editSsno(EM_SS_NO)" onkeydown="if(event.keyCode==13){editSsno(EM_SS_NO)}"
                                align="absmiddle"></td>
                        </tr>
                        <tr>
                            <th width="90" class="point">본인생일</th>
                            <td><comment id="_NSID_"> <object id=EM_BIRTH_DT
                                classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle"
                                tabindex=1></object> </comment> <script> _ws_(_NSID_);</script> <img
                                id="IMG_BIRTH_DT" src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                onclick="javascript:openCal('G',EM_BIRTH_DT)" /></td>
                            <th class="point">휴대전화</th>
                            <td colspan="3">
                            	<comment id="_NSID_">
								<object id=LC_MOBILE_COMP classid=<%=Util.CLSID_LUXECOMBO%> height=100 style="display : none"
								width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
                            	<comment id="_NSID_"> <object id=EM_MOBILE_PH1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_MOBILE_PH2
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_MOBILE_PH3
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                                 <img src="/<%=dir%>/imgs/btn/modify.gif" tabindex=1
                                id="IMG_TELNUM" onclick="editTelno(EM_MOBILE_PH1,EM_MOBILE_PH2,EM_MOBILE_PH3)" onkeydown="if(event.keyCode==13){editTelno(EM_MOBILE_PH1,EM_MOBILE_PH2,EM_MOBILE_PH3)}"
                                align="absmiddle">
                                
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
									<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
									<comment id="_NSID_"><object id=EM_CI
										classid=<%=Util.CLSID_EMEDIT%> width=600 align="absmiddle"
										tabindex=5 style="display:none;"> </object> </comment> <script> _ws_(_NSID_);</script><br>
										<comment id="_NSID_"><object id=EM_DI
										classid=<%=Util.CLSID_EMEDIT%> width=600 align="absmiddle"
										tabindex=5 style="display:none;"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>                                
                        </tr>
                        <tr>
                            <th>생일 구분</th>
                            <td><comment id="_NSID_"><object id=RD_LUNAR_FLAG
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
                                align="absmiddle" tabindex=1>
                                <param name=Cols value="2">
                                <param name=Format value="S^양력,L^음력">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>                        
                            <!-- <th>본인인증여부</th> -->
							<td style="display: none"><comment id="_NSID_"><object id=RD_NAME_CONF_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle" tabindex=1>
								<param name=Cols value="2">
								<param name=Format value="N^미인증,Y^인증">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="N">
							</object> </comment> <script> _ws_(_NSID_);</script></td>   
							<th>가입점</th>
							<td colspan="3"><comment id="_NSID_"><object
								id=LC_STR_CD   classid=<%=Util.CLSID_LUXECOMBO%> width=130
								tabindex=1 ></object></comment> <script> _ws_(_NSID_);</script></td> 
                        </tr>
                        <tr>
							<th>성별 구분</th>
							<td><comment id="_NSID_"><object id=RD_SEX_CD
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
								align="absmiddle" tabindex=1>
								<param name=Cols value="2">
								<param name=Format value="M^남자,F^여자">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="F">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th>외국인정보</th>
							<td colspan="3"><comment id="_NSID_"><object id=RD_ALIEN_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle" tabindex=1>
								<param name=Cols value="2">
								<param name=Format value="N^내국인,Y^외국인">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script>
							</td> 
							<td style="display: none"> 
							<comment id="_NSID_"><object
								id=LC_FOREIGN classid=<%=Util.CLSID_LUXECOMBO%> width=70
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>				
							</td> 		
								                        
                        </tr>
						<tr>
                            <th>자택전화</th>
                            <td><comment id="_NSID_"> <object id=EM_HOME_PH1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_HOME_PH2
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_HOME_PH3
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th>SMS 수신동의</th>
                            <td colspan="3"><comment id="_NSID_"> <object id=RD_SMS_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=1>
                                <param name=Cols value="2">
                                <param name=Format value="Y^예,N^아니오">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script>
                            
                            <!--  
								내   용 : SMS발송 팝업
								작성자 : jwjeon
								작성일 : 2015.04.28
								-->
								<img src="/<%=dir%>/imgs/btn/sms_send.gif"  style="display: none"
								onclick="javascript:sendSMS();" 
								align="absmiddle" tabindex=5>
                            
                            
                            </td>                                
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
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif" width=0
                                onclick="getPostPop_dcs(EM_HNEW_ZIP_CD1,EM_HNEW_ZIP_CD2,EM_HNEW_ADDR1,EM_HNEW_ADDR2,EM_HOME_NEW_YN)"
                                align="absmiddle" tabindex=1 id="IMG_HOME_ADDR" 
                                onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_HNEW_ZIP_CD1,EM_HNEW_ZIP_CD2,EM_HNEW_ADDR1,EM_HNEW_ADDR2,EM_HOME_NEW_YN)}">
                                <img src="/<%=dir%>/imgs/btn/modify_address_s.gif" id="IMG_MODIFY_HOME_JUSO" tabindex=1
                                onclick="editJuso('H')" onkeydown="if(event.keyCode==13){editJuso('H')}" align="absmiddle">
                            <comment id="_NSID_"> <object id=EM_HNEW_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=270 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td colspan="3" style="border-left: 1px solid #fff; padding-left: 0; width:300"><comment
                                id="_NSID_"> <object id=EM_HNEW_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=300 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_HNEW_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        </tr> 
                        <tr>
							<th class="point">자택주소(구주소)</th>
							<td colspan="2"
								style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0">
								<comment id="_NSID_"> 
								<object id=EM_HOME_ZIP_CD1 style="display : none" 
								classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
								</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
								<object id=EM_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> style="display : none" 
								width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/search_post_s.gif" style="display : none"
								onclick="sample4_execDaumPostcode()"
								align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR">
								<comment id="_NSID_"> <object id=EM_HOME_ADDR1
								classid=<%=Util.CLSID_EMEDIT%> width=390 align="absmiddle"></object>
								</comment> <script> _ws_(_NSID_);</script></td>
							<td style="border-left: 1px solid #fff; padding-left: 0"><comment
								id="_NSID_"> <object id=EM_HOME_ADDR2   style="display : none" 
								classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_HOME_ADDR2, 200, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<span id="guide" style="color:#999"></span>
						</tr>
						<tr>
							<th>카드발급횟수</th>
							<td><comment id="_NSID_">
								<object id=EM_ISSUE_CNT classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle">
                                </object> </comment> <script> _ws_(_NSID_);</script>
                            </td>
                            <th>우편물 수령동의</th>
                            <td colspan="3"><comment id="_NSID_"> <object
                                id=RD_POST_RCV_CD classid=<%=Util.CLSID_RADIO%>
                                style="height: 20; width: 120" tabindex=1>
                                <param name=Cols value="2">
                                <param name=Format value="H^예,O^아니오">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>                            							
						</tr>
                        <tr>
                            <th>이메일주소</th>
                            <td><comment id="_NSID_"> <object id=EM_EMAIL1
                                classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_EMAIL1, 50, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script> @ <comment id="_NSID_">
                            <object id=LC_EMAIL2 classid=<%=Util.CLSID_LUXECOMBO%> height=100
                                width=105 align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                            <comment id="_NSID_"> <object id=EM_EMAIL3
                                classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_EMAIL3, 50, '');"
                                style="display: hidden"></object> </comment> <script> _ws_(_NSID_);</script>
                            </td>
                            <th>이메일 수신동의</th>
                            <td colspan="3"><comment id="_NSID_"> <object id=RD_EMAIL_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=1>
                                <param name=Cols value="2">
                                <param name=Format value="Y^예,N^아니오">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
						<tr>
							<th class="point">회원등급</th>
							<td><comment id="_NSID_"> <object
								id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=1></object> </comment> <script> _ws_(_NSID_);</script><comment
								id="_NSID_"> <object id=LC_VIP_FLAG
								classid=<%=Util.CLSID_LUXECOMBO%> width=140 align="absmiddle"
								tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>
							<th class="point">TM 동의여부</th>
							<td><comment id="_NSID_"> <object id=RD_TM_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="Y^예,N^아니오">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
								
							<th class="point" width="100" style="display : none" >매장명</th>
							<td><comment id="_NSID_"> <object style="display : none" 
                                id=EM_ON_TERMS5_DATE classid=<%=Util.CLSID_EMEDIT%> width=200
                                tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>	
							
						</tr>
                        <tr style="display:none">
                            <th width="90">결혼여부</th>
                            <td><comment id="_NSID_"> <object id=RD_WED_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=1>
                                <param name=Cols value="2">
                                <param name=Format value="N^미혼,Y^기혼">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90">결혼 기념일</th>
                            <td><comment id="_NSID_"> <object id=EM_WED_DT
                                classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
                                tabindex=1></object> </comment> <script> _ws_(_NSID_);</script> <img
                                src="/<%=dir%>/imgs/btn/date.gif" id="IMG_WED_DT"
                                align="absmiddle" onclick="javascript:openCal('G',EM_WED_DT)" /></td>
                        </tr>
						<tr style="display:none">
							<th width="90">주거형태</th>
							<td><comment id="_NSID_"> <object id=RD_HOUSE_TYPE
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 250"
								tabindex=1>
								<param name=Cols value="4">
								<param name="AutoMargin" value="true">
								<param name=Format value="1^APT,2^단독,3^연립,4^기타">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="90">주거구분</th>
							<td><comment id="_NSID_"> <object id=RD_HOUSE_FLAG
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 200"
								tabindex=1>
								<param name=Cols value="4">
								<param name=Format value="1^자가,2^전세,3^월세,9^기타">
								<param name="AutoMargin" value="true">
							</object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
						<th class="point">회원유형</th>
							<td><comment id="_NSID_"> <object
								id=LC_CUST_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>
							<th>가입권유 브랜드</th>
							<td><comment id="_NSID_">
			                	<object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1  align="absmiddle">
			                	</object></comment><script> _ws_(_NSID_);</script>
				                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCdCombo('POP'); EM_O_PUMBUN_CD.Focus();"  align="absmiddle" />
				                <comment id="_NSID_">
				                <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1  align="absmiddle">
				                </object></comment><script> _ws_(_NSID_);</script></td> 						
						</tr> 
						<tr>
							<th class="point">카드등급</th>
							<td><comment id="_NSID_"> <object
								id=LC_CARD_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>
							<th class="point">카드비밀번호</th>
                            <td colspan=3><comment id="_NSID_"> <object  
                                id=EM_CARD_PWD_NO classid=<%=Util.CLSID_EMEDIT%> width=70
                                tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>  
						</tr>
						<tr>
							<th class="point">가입혜택</th>
							<td colspan=5><comment id="_NSID_"> <object id=RD_ENTR_GAIN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 400;"
								tabindex=5
								>
								<param name=Cols value="3">
								<param name=Format value="0^포인트적립,1^현장즉시할인,9^혜택미적용">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						</tr>                   
						<tr   style="display:none" >
							<th>회원구분 사용X</th>
							<td>
								<comment id="_NSID_">
								<object id=LC_DIVISION classid=<%=Util.CLSID_LUXECOMBO%> height=100
								width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
							<th>가입채널</th>
							<td>
								<comment id="_NSID_">
								<object id=LC_ENTR_CH classid=<%=Util.CLSID_LUXECOMBO%> height=100
								width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						 </tr>						
						<!--  
						<tr>
							<th width="90">선호 시설</th>
							<td colspan="3">&nbsp;<input type="checkbox" id=FAVOR_DEPT1
								onclick='fn_chkYn(strFavorDept1YN,"FAVOR_DEPT1")' tabindex=5>백화점 &nbsp;<input type="checkbox"
								id=FAVOR_DEPT2 onclick='fn_chkYn(strFavorDept2YN,"FAVOR_DEPT2")' tabindex=5>문화센터 &nbsp;<input
								type="checkbox" id=FAVOR_DEPT3 onclick='fn_chkYn(strFavorDept3YN,"FAVOR_DEPT3")' tabindex=5>아트센터
							&nbsp;<input type="checkbox" id=FAVOR_DEPT4 onclick='fn_chkYn(strFavorDept4YN,"FAVOR_DEPT4")' tabindex=5>호텔
							&nbsp;<input type="checkbox" id=FAVOR_DEPT5 onclick='fn_chkYn(strFavorDept5YN,"FAVOR_DEPT5")' tabindex=5>테마파크
							&nbsp;</td>
						</tr>
						-->
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
                                tabindex=1
                                onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90">부서</th>
                            <td><comment id="_NSID_"> <object id=EM_DEPT_NAME
                                classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
                                onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>
                            <th width="90">직위</th>
                            <td width="310"><comment id="_NSID_"> <object
                                id=LC_POSITION classid=<%=Util.CLSID_LUXECOMBO%> width=158
                                tabindex=1></object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_POSITION_ETC
                                classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=5
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90" style="width: 90px;">전화번호</th>
                            <td><comment id="_NSID_"> <object id=EM_OFFI_PH1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_OFFI_PH2
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_OFFI_PH3
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
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
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif" width=0
                                onclick="getPostPop_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)"
                                align="absmiddle" tabindex=1 id="IMG_OFFI_ADDR"
                                onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)}">
                                <img src="/<%=dir%>/imgs/btn/modify_address_s.gif" id="IMG_MODIFY_OFFI_JUSO" tabindex=1
                                onclick="editJuso('O')" onkeydown="if(event.keyCode==13){editJuso('O')}" align="absmiddle">
                            <comment id="_NSID_"> <object id=EM_OFFI_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=256 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_OFFI_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=1
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
		<tr style="display:none">
            <td class="sub_title PT07 PB02"><img
                src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
                align="absmiddle" class="PR03" /> 14세 미만 아동회원 가입신청서에 대한 법정대리인 동의</td>
        </tr>
        <tr style="display:none">
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
                                classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
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
							<th width="90" class="point">동의일자</th>
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
							<td><comment id="_NSID_"> <object id=RD_OFF_TERMS1_YN
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
							<th width="90" class="point">동의일자</th>
							<td width="110" ><comment id="_NSID_"> <object
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
					<table width="100%" border="0" cellpadding="0" cellspacing="0" border=""
						class="s_table">
						<tr>
							<th width="90" class="point">동의일자</th>
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
							<th width="90" class="point">동의일자</th>
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
							<td ><comment id="_NSID_"> <object id=RD_OFF_TERMS4_YN
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
                            <td width="110"><comment id="_NSID_"> <object
                                id=EM_ENTR_DT classid=<%=Util.CLSID_EMEDIT%> width=80
                                align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                onclick="javascript:openCal('G',EM_ENTR_DT)" id=IMG_ENTR_DT /></td>
                            <th width="90">최초입력자</th>
                            <td width="210"><comment id="_NSID_"> <object
                                id=EM_REG_COL classid=<%=Util.CLSID_EMEDIT%> width=200
                                tabindex=5></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                               <th width="90">최종수정자</th>
                            <td ><comment id="_NSID_"> <object
                                id=EM_MOD_COL classid=<%=Util.CLSID_EMEDIT%> width=200
                                tabindex=5></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
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
                            <th width="90">신분증확인</th>
                            <td colspan="3"><comment id="_NSID_"> <object
                                id=LC_ID_CHECK classid=<%=Util.CLSID_LUXECOMBO%> width=158
                                align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>
                            <th width="90">발행기관</th>
                            <td width="310"><comment id="_NSID_"> <object
                                id=EM_ISSUE_ORG classid=<%=Util.CLSID_EMEDIT%> width=154
                                tabindex=5
                                onkeyup="javascript:checkByteStr(EM_ISSUE_ORG, 40, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90">발행일자</th>
                            <td><comment id="_NSID_"> <object id=EM_ISSUE_DT
                                classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
                                tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
                                src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                onclick="javascript:openCal('G',EM_ISSUE_DT)" id=IMG_ISSUE_DT /></td>
                            
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
                align="absmiddle" class="PR03" /> 옵션</td>
        </tr>
        <tr style="display:none">
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"
                        class="s_table">
                        <tr>
                            <th width="90" class="point">주소클렌징 금지</th>
                            <td colspan="3" width="310"><comment id="_NSID_"> <object id=RD_NOCLS_REQ_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=1>
                                <param name=Cols value="2">
                                <param name=Format value="Y^예,N^아니오">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
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
            <c>col=CARD_NO                  ctrl=EM_CARD_NO                 Param=Text</c>
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
            <c>col=NOCLS_REQ_YN             ctrl=RD_NOCLS_REQ_YN            Param=CodeValue</c>
            <c>col=CUST_GRADE               ctrl=LC_CUST_GRADE              Param=BindColVal</c>
            <c>col=VIP_FLAG                 ctrl=LC_VIP_FLAG                Param=BindColVal</c>
        	<c>col=ENTR_PBN                 ctrl=EM_O_PUMBUN_CD             Param=Text</c>
        	<c>col=ENTR_PBN_NAME            ctrl=EM_O_PUMBUN_NM             Param=Text</c>            
            <c>col=CUST_TYPE                ctrl=LC_CUST_TYPE               Param=BindColVal</c>
            <c>col=ALIEN_YN                 ctrl=RD_ALIEN_YN                Param=CodeValue</c>
            <c>col=NAME_CONF_YN             ctrl=RD_NAME_CONF_YN            Param=CodeValue</c>
            <c>col=SEX_CD             		ctrl=RD_SEX_CD            		Param=CodeValue</c>             
            <c>col=ISSUE_CNT                ctrl=EM_ISSUE_CNT               Param=Text</c>
            <c>col=REG_COL	                ctrl=EM_REG_COL	                Param=Text</c>
            <c>col=MOD_COL	                ctrl=EM_MOD_COL	                Param=Text</c>
            <c>col=ON_TERMS5_DATE	        ctrl=EM_ON_TERMS5_DATE          Param=Text</c>
            <c>col=DI               		ctrl=EM_DI		                Param=Text</c>
            <c>col=DI               		ctrl=RD_ENTR_GAIN               Param=CodeValue</c>
			<c>col=CI                		ctrl=EM_CI    		            Param=Text</c>
			<c>col=MOBILE_COMP                ctrl=LC_MOBILE_COMP               Param=BindColVal</c>
			<c>col=TM_YN                    ctrl=RD_TM_YN                   Param=CodeValue</c>
			<c>col=DIVISION                ctrl=LC_DIVISION               Param=BindColVal</c>
			<c>col=ENTR_CH                ctrl=LC_ENTR_CH               Param=BindColVal</c>
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
