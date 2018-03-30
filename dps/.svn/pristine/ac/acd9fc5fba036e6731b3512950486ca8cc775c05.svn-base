<!--
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 기타관리 > 협력사 사원관리
 * 작 성 일 : 2012.07.04
 * 작 성 자 : 조승배
 * 수 정 자 :
 * 파 일 명 : pcodC010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사의 사원 정보를 관리한다.
 * 이    력 :
 *        2012.07.04 (조승배) 신규작성
 *        2012.08.27 (강     진) 수정 
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
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" 		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" 	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strStrCdPopUp   = "";
 var newMasterYn = false;			//신규 로우 존재 여부 확인

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
 */
 
var top = 140;		//해당화면의 동적그리드top위치
function doInit() {
	
	var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
	// Input Data Set Header 초기화

	// Output Data Set Header 초기화
	DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
	DS_IO_DETAIL1.setDataHeader('<gauce:dataset name="H_SEL_DETAIL1"/>');
	DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL1"/>');
	DS_IO_DETAIL3.setDataHeader('<gauce:dataset name="H_SEL_DETAIL1"/>');
	DS_IO_DETAIL4.setDataHeader('<gauce:dataset name="H_SEL_DETAIL1"/>');
	DS_IO_DETAIL5.setDataHeader('<gauce:dataset name="H_SEL_DETAIL1"/>');

	//탭 초기화(품목)
    initTab("TAB_VEN");
	
	gridCreate();
	//gridCreate1();
	//gridCreate2();
	//gridCreate3();
	//gridCreate4();
	gridCreate5();
	
	setTabItemIndex('TAB_VEN',1);

	/**************************************** TAB1(기본사항) ****************************************/
	//콤보 초기화
	//1. 조회조건
	initComboStyle(LC_O_STR_CD,		DS_O_STR_CD, 		"CODE^0^30,NAME^0^140",	1,	PK);  		//점(조회)
	initComboStyle(LC_O_GJDATE,		DS_O_GJDATE_TYPE, 	"CODE^0^30,NAME^0^80",	1,	PK);		//기준일
	initComboStyle(LC_O_DEL_FLAG,	DS_O_DEL_FLAG, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);	//퇴사구분
	initComboStyle(LC_O_EDU,		DS_O_EDU,		 	"CODE^0^30,NAME^0^80",	1,	NORMAL);	//CS교육
	
	//2. 본문내용
	initComboStyle(LC_IO_STR_CD,		DS_IO_STR_CD, 		"CODE^0^30,NAME^0^140",	1,	PK);  		//점(조회)
	initComboStyle(LC_IO_JOB_CD,		DS_IO_JOB_CD, 		"CODE^0^30,NAME^0^80",	1,	NORMAL);	//직급
	initComboStyle(LC_IO_DOMAIN_FLAG,	DS_IO_DOMAIN_FLAG, 	"CODE^0^30,NAME^0^80",	1,	NORMAL);	//도메인 구분
	
	
	initComboStyle(LC_IO_WED_YN,	    DS_IO_WED_YN, 		"CODE^0^30,NAME^0^80",	1,	NORMAL);	//결혼여부

	//EMEDIT 초기화
	//1. 조회조건
	initEmEdit(EM_O_VEN_CD,		"CODE^6^0",			NORMAL);   		//협력사코드
	initEmEdit(EM_O_VEN_NM,		"GEN^40",			READ);  		//협력사명
	initEmEdit(EM_O_PUMBUN,		"CODE^6^0",			NORMAL);		//브랜드
	initEmEdit(EM_O_PUMBUN_NM,	"GEN^40",			READ);			//브랜드
	initEmEdit(EM_O_KOR_NM,		"GEN",				NORMAL);  		//성명
	initEmEdit(EM_S_START_DT,	"YYYYMMDD",		NORMAL);		//조회기간 시작일
	initEmEdit(EM_S_END_DT,		"TODAY",			NORMAL);		//조회기간 종료일
	EM_S_START_DT.text = "20000101";
	//2. 본문내용
	initEmEdit(EM_IO_KOR_NM,			"GEN",				PK);  			//성명(한글)
	initEmEdit(EM_IO_PUMBUN_CD,			"CODE^6^0",			PK);  			//브랜드코드
	initEmEdit(EM_IO_PUMBUN_NM,			"GEN^40",			READ);  		//브랜드명
	initEmEdit(EM_IO_VEN_CD,			"CODE^6^0",			NORMAL);  		//협력사 코드
	initEmEdit(EM_IO_VEN_NM,			"GEN^40",			READ);  		//협력사 명
	initEmEdit(EM_IO_INSTR_DT,			"YYYYMMDD",			NORMAL);		//입점일
	initEmEdit(EM_IO_BIRTH_DT,			"YYYYMMDD",			PK);		//생년월일
	//initEmEdit(EM_IO_AGE,				"NUMBER^2^0",		NORMAL);		//나이
	initEmEdit(EM_IO_HOME_ZIP_CD,		"CODE^6^0",			READ);			    //집우편번호1
	initEmEdit(EM_IO_HOME_ADDR1,		"GEN^100",			NORMAL);			//집주소1
	initEmEdit(EM_IO_HOME_ADDR2,		"GEN^100",			NORMAL);			//집주소2
	initEmEdit(EM_IO_HOME_PH1,			"CODE^4^0",		NORMAL);			//전화1
	initEmEdit(EM_IO_HOME_PH2,			"CODE^4^0",		NORMAL);			//전화2
	initEmEdit(EM_IO_HOME_PH3,			"CODE^4^0",		NORMAL);			//전화3
	initEmEdit(EM_IO_MOBILE_PH1,		"CODE^4^0",		PK);		//핸드폰번호1
	initEmEdit(EM_IO_MOBILE_PH2,		"CODE^4^0",		PK);		//핸드폰번호2
	initEmEdit(EM_IO_MOBILE_PH3,		"CODE^4^0",		PK);		//핸드폰번호3
	initEmEdit(EM_IO_ORGN_ZIP_CD,		"CODE^6^0",		READ);			//본적우편번호
	initEmEdit(EM_IO_ORGN_ADDR1,		"GEN^100",			NORMAL);		//본적주소1
	initEmEdit(EM_IO_ORGN_ADDR2,		"GEN^100",			NORMAL);		//본적주소2
	initEmEdit(EM_IO_EMAIL1,			"GEN",				NORMAL);		//이메일1
	initEmEdit(EM_IO_EMAIL2,			"GEN",				NORMAL);		//이메일2
	initEmEdit(EM_IO_TEMP_PASS_NO,		"GEN^20",			NORMAL);		//임시출입증번호
	initEmEdit(EM_IO_TEMP_PASS_RET_DT,	"YYYYMMDD",			NORMAL);		//반납일
	initEmEdit(EM_IO_TEMP_PASS_ISSUE_DT,"YYYYMMDD",			NORMAL);		//정규사원증 접수일
	initEmEdit(EM_IO_EMP_ID_ISSUE_DT,	"YYYYMMDD",			NORMAL);		//정규사원증 발급일
	initEmEdit(EM_IO_OUTSTR_DT,			"YYYYMMDD",			NORMAL);		//퇴점일
	initEmEdit(EM_IO_MEMO,				"GEN^50",			NORMAL);		//메모
	initEmEdit(EM_HOME_NEW_YN,	     	"GEN^1",			NORMAL);		//새주소구분
	initEmEdit(EM_ORGN_NEW_YN,	     	"GEN^1",			NORMAL);		//본적 새주소구분
	
	EM_IO_HOME_ZIP_CD.Format = "000000";
	EM_IO_ORGN_ZIP_CD.Format = "000000";
	//EMEDIT 초기화 완료


	//점콤보 가져오기 ( gauce.js )
	getStore("DS_O_STR_CD", "N", "", "Y");					//점(조회조건)
	getStore("DS_IO_STR_CD", "N", "", "N");					//점(본문)

	//시스템 코드 공통코드에서 가지고 오기( popup.js )
	//1. 조회조건
	getEtcCode("DS_O_GJDATE_TYPE", 	"D", "P192", "N");		//기준일
	getEtcCode("DS_O_DEL_FLAG", 	"D", "P191", "Y");		//퇴사구분
	getEtcCode("DS_O_EDU",			"D", "P806", "Y");		//CS교육
	
	//2. 본문
	getEtcCode("DS_IO_JOB_CD", 		"D", "P251", "N");		//직급
	getEtcCode("DS_IO_DOMAIN_FLAG",	"D", "D013", "N");		//도메인 구분
	
	
	getEtcCode("DS_IO_WED_YN",		"D", "P187", "N");		//결혼여부

	
	//콤보데이터 기본값 설정( gauce.js )
	//1. 조회조건
	setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />');		//점
	setComboData(LC_O_GJDATE,"01");		//기준일
	setComboData(LC_O_DEL_FLAG,"%");	//퇴사구분
	setComboData(LC_O_EDU,"%");	//cs교육
	
	//setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
	
	//2. 본문
	setComboData(LC_IO_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />');		//점
	setComboData(LC_IO_JOB_CD,"01");		//직급
	setComboData(LC_IO_DOMAIN_FLAG,"99");	//도메인 구분
	setComboData(LC_IO_WED_YN,"N");			//결혼여부
	
	/**************************************** TAB2(인적사항) ***************************************
	initComboStyle(LC_IO_WORK_TYPE,				DS_IO_WORK_TYPE, 			"CODE^0^30,NAME^0^80",	1,	NORMAL);	//근무형태
	initComboStyle(LC_IO_HI_SCHL_GRUD_FLAG,		DS_IO_SCHL_GRUD_FLAG, 		"CODE^0^30,NAME^0^80",	1,	NORMAL);	//졸업현황(고등학교)
	initComboStyle(LC_IO_UNIVST_GRDU_FLAG,		DS_IO_SCHL_GRUD_FLAG, 		"CODE^0^30,NAME^0^80",	1,	NORMAL);	//졸업현황(대학교)
	initComboStyle(LC_IO_GRDU_SCHL_GRDU_FLAG,	DS_IO_SCHL_GRUD_FLAG, 		"CODE^0^30,NAME^0^80",	1,	NORMAL);	//졸업현황(대학원)
		
	
	initEmEdit(EM_M_KOR_NM,					"GEN",			READ);  	//성명(한글)
	initEmEdit(EM_M_CHI_NM,					"GEN",			READ);  	//성명(한자)
	initEmEdit(EM_M_PUMBUN_CD,				"GEN",			READ);  	//브랜드코드
	initEmEdit(EM_M_PUMBUN_NM,				"GEN",			READ);  	//브랜드명
	initEmEdit(EM_M_VEN_CD,					"GEN",			READ);  	//협력사 코드
	initEmEdit(EM_M_VEN_NM,					"GEN",			READ);  	//협력사 명
	initEmEdit(EM_M_JOB_NM,					"GEN",			READ);  	//직책
	initEmEdit(EM_M_BIRTH_DT,				"YYYYMMDD",		READ);		//생년월일
	initEmEdit(EM_M_BIRTH_LUNAR_FLAG,		"GEN",			READ);  	//생일구분
	initEmEdit(EM_M_AGE,					"NUMBER^2^0",	READ);		//나이
	initEmEdit(EM_M_HOME_ZIP_CD,			"GEN",			READ);		//집우편번호1
	initEmEdit(EM_M_HOME_ADDR1,				"GEN",			READ);		//집주소1
	initEmEdit(EM_M_HOME_ADDR2,				"GEN",			READ);		//집주소2
	initEmEdit(EM_M_HOME_PH1,				"GEN",			READ);		//전화1
	initEmEdit(EM_M_HOME_PH2,				"GEN",			READ);		//전화2
	initEmEdit(EM_M_HOME_PH3,				"GEN",			READ);		//전화3
	initEmEdit(EM_M_MOBILE_PH1,				"GEN",			READ);		//핸드폰번호1
	initEmEdit(EM_M_MOBILE_PH2,				"GEN",			READ);		//핸드폰번호2
	initEmEdit(EM_M_MOBILE_PH3,				"GEN",			READ);		//핸드폰번호3
	initEmEdit(EM_M_DOMAIN_FLAG,			"GEN",			READ);		//직접입력
	initEmEdit(EM_M_EMAIL1,					"GEN",			READ);		//이메일1
	initEmEdit(EM_M_EMAIL2,					"GEN",			READ);		//이메일2
	initEmEdit(EM_M_WED_YN,					"GEN",			READ);		//결혼여부
	initEmEdit(EM_M_WED_YN,					"GEN",			READ);		//나이	
	initEmEdit(EM_IO_TEMP_ENT_SUP_S_DT,		"YYYYMMDD",	    NORMAL);  	//일시행사지원시작일
	initEmEdit(EM_IO_TEMP_ENT_SUP_E_DT,		"YYYYMMDD",	    NORMAL);  	//일시행사지원종료일
	initEmEdit(EM_IO_BRD_FIX_AR_S_DT,		"YYYYMMDD",	    NORMAL);  	//브랜드고정A/R시작일
	initEmEdit(EM_IO_BRD_FIX_AR_E_DT,		"YYYYMMDD",	    NORMAL);  	//브랜드고정A/R종료일
	initEmEdit(EM_IO_LONG_ENT_SUP_S_DT,		"YYYYMMDD",	    NORMAL);  	//장기행사지원시작일
	initEmEdit(EM_IO_LONG_ENT_SUP_E_DT,		"YYYYMMDD",	    NORMAL);  	//장기행사지원종료일
	initEmEdit(EM_IO_LONG_WORK_S_DT,		"YYYYMMDD",	    NORMAL);  	//장기근무자시작일
	initEmEdit(EM_IO_LONG_WORK_E_DT,		"YYYYMMDD",	    NORMAL);  	//장기근무자종료일
	initEmEdit(EM_IO_HI_SCHL_GRDU_YM,		"YYYYMMDD",	    NORMAL);  	//고등학교졸업년월
	initEmEdit(EM_IO_HI_SCHL_NM,			"GEN^20",	    NORMAL);  	//고등학교명
	initEmEdit(EM_IO_HI_SCHL_LOCATION,		"GEN^20",	    NORMAL);  	//고등학교소재지
	initEmEdit(EM_IO_UNIVST_GRDU_YM,		"YYYYMMDD",	    NORMAL);  	//대학교졸업년월
	initEmEdit(EM_IO_UNIVST_NM,				"GEN^20",	    NORMAL);  	//대학교명
	initEmEdit(EM_IO_UNIVST_LOCATION,		"GEN^20",	    NORMAL);  	//대학교소재지
	initEmEdit(EM_IO_GRDU_SCHL_GRDU_YM,		"YYYYMMDD",	    NORMAL);  	//대학원졸업년도
	initEmEdit(EM_IO_GRDU_SCHL_NM,			"GEN^20",	    NORMAL);  	//대학원명
	initEmEdit(EM_IO_GRDU_SCHL_LOCATION,	"GEN^20",	    NORMAL);  	//대학원소재지
	initEmEdit(EM_IO_WORK_S_DT1,			"YYYYMMDD",	    NORMAL);  	//근무1기간시작일
	initEmEdit(EM_IO_WORK_E_DT1,			"YYYYMMDD",	    NORMAL);  	//근무1기간종료일
	initEmEdit(EM_IO_WORK_COMP1,			"GEN^20",	    NORMAL);  	//근무1소속회사명
	initEmEdit(EM_IO_WORK_BRD1,				"GEN^20",	    NORMAL);  	//근무1브랜드
	initEmEdit(EM_IO_WORK_JOB1,				"GEN^20",	    NORMAL);  	//근무1직책
	initEmEdit(EM_IO_WORK_LOCATION1,		"GEN^20",	    NORMAL);  	//근무1소재지
	initEmEdit(EM_IO_WORK_S_DT2,			"YYYYMMDD",	    NORMAL);  	//근무2기간시작일
	initEmEdit(EM_IO_WORK_E_DT2,			"YYYYMMDD",	    NORMAL);  	//근무2기간종료일
	initEmEdit(EM_IO_WORK_COMP2,			"GEN^20",	    NORMAL);  	//근무2소속회사명
	initEmEdit(EM_IO_WORK_BRD2,				"GEN^20",	    NORMAL);  	//근무2브랜드
	initEmEdit(EM_IO_WORK_JOB2,				"GEN^20",	    NORMAL);  	//근무2직책
	initEmEdit(EM_IO_WORK_LOCATION2,		"GEN^20",	    NORMAL);  	//근무2소재지
	initEmEdit(EM_IO_WORK_S_DT3,			"YYYYMMDD",	    NORMAL);  	//근무3기간시작일
	initEmEdit(EM_IO_WORK_E_DT3,			"YYYYMMDD",	    NORMAL);  	//근무3기간종료일
	initEmEdit(EM_IO_WORK_COMP3,			"GEN^20",	    NORMAL);  	//근무3소속회사명
	initEmEdit(EM_IO_WORK_BRD3,				"GEN^20",	    NORMAL);  	//근무3브랜드
	initEmEdit(EM_IO_WORK_JOB3,				"GEN^20",	    NORMAL);  	//근무3직책
	initEmEdit(EM_IO_WORK_LOCATION3,		"GEN^20",	    NORMAL);  	//근무3소재지
	initEmEdit(EM_IO_WORK_S_DT4,			"YYYYMMDD",	    NORMAL);  	//근무4기간시작일
	initEmEdit(EM_IO_WORK_E_DT4,			"YYYYMMDD",	    NORMAL);  	//근무4기간종료일
	initEmEdit(EM_IO_WORK_COMP4,			"GEN^20",	    NORMAL);  	//근무4소속회사명
	initEmEdit(EM_IO_WORK_BRD4,				"GEN^20",	    NORMAL);  	//근무4브랜드
	initEmEdit(EM_IO_WORK_JOB4,				"GEN^20",	    NORMAL);  	//근무4직책
	initEmEdit(EM_IO_WORK_LOCATION4,		"GEN^20",	    NORMAL);  	//근무4소재지
	
	getEtcCode("DS_IO_WORK_TYPE", 			"D", "P185", "N");		//근무형태
	getEtcCode("DS_IO_SCHL_GRUD_FLAG", 		"D", "P184", "N");		//졸업현황
	*/
	
	if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("tab_page1");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("TAB_VEN");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";

    /*화면 로드시 disable 처리*/
    enableCnt();

}

/**
 * gridCreate()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 그리드 생성
 * return값 : void
 */
function gridCreate() {
	var hdrProperies =  
					   '<FC>id={currow}				name="NO"				width=30	align=center	</FC>'
					 + '<FC>id=VENEMP_ID			name="사원마스터ID"		show=false </FC>'
					 + '<FC>id=KOR_NM				name="이름"				width=60	align=center	Edit=none </FC>'
					 + '<FC>id=STR_CD				name="점코드"			    show=false </FC>'
					 + '<FC>id=PUMBUN_CD			name="브랜드"				width=60	align=center	Edit=none </FC>'
					 + '<FC>id=PUMBUN_NAME			name="브랜드명"			width=120	align=left		Edit=none </FC>'
					 + '<FC>id=JOB_CD				name="직급코드"			show=false </FC>'
					 + '<FC>id=VEN_CD				name="협력사"				width=60	align=center	Edit=none </FC>'
					 + '<FC>id=VEN_NAME				name="협력사명"			width=150	align=left		Edit=none </FC>'
					 + '<FC>id=INSTR_DT				name="입점일"			    show=false </FC>'
					 + '<FC>id=SEX_CD				name="성별"				show=false </FC>'
					 + '<FC>id=AGE					name="나이"				show=false </FC>'
					 + '<FC>id=BIRTH_DT				name="생년월일"			show=false </FC>'
					 + '<FC>id=BIRTH_LUNAR_FLAG		name="생일구분"			show=false </FC>'
					 + '<FC>id=HOME_NEW_YN			name="새주소구분"			show=false </FC>'
					 + '<FC>id=HOME_ZIP_CD			name="우편번호"			show=false </FC>'
					 + '<FC>id=HOME_ADDR1			name="주소1"				show=false </FC>'
					 + '<FC>id=HOME_ADDR2			name="주소2"				show=false </FC>'
					 + '<FC>id=HOME_PH1				name="전화번호1"			show=false </FC>'
					 + '<FC>id=HOME_PH2				name="전화번호2"			show=false </FC>'
					 + '<FC>id=HOME_PH3				name="전화번호3"			show=false </FC>'
					 + '<FC>id=MOBILE_PH1			name="핸드폰번호1"		show=false </FC>'
					 + '<FC>id=MOBILE_PH2			name="핸드폰번호2"		show=false </FC>'
					 + '<FC>id=MOBILE_PH3			name="핸드폰번호3"		show=false </FC>'
					 + '<FC>id=ORGN_NEW_YN			name="본적새주소구분"			show=false </FC>'
					 + '<FC>id=ORGN_ZIP_CD1			name="본적우편번호1"		show=false </FC>'
					 + '<FC>id=ORGN_ZIP_CD2			name="본적우편번호2"		show=false </FC>'
					 + '<FC>id=ORGN_ADDR1			name="본적주소1"			show=false </FC>'
					 + '<FC>id=ORGN_ADDR2			name="본적주소2"			show=false </FC>'
					 + '<FC>id=EMAIL1				name="이메일1"			show=false </FC>'
					 + '<FC>id=EMAIL2				name="이메일2"			show=false </FC>'
					 + '<FC>id=DOMAIN_FLAG			name="도메인구분"			show=false </FC>'
					 + '<FC>id=TEMP_PASS_NO			name="임시출입증번호"		show=false </FC>'
					 + '<FC>id=TEMP_PASS_RET_DT		name="반납일"			show=false </FC>'
					 + '<FC>id=TEMP_PASS_ISSUE_DT	name="정규사원증접수일"	show=false </FC>'
					 + '<FC>id=EMP_ID_ISSUE_DT		name="정규사원증발급일"	show=false </FC>'
					 + '<FC>id=OUTSTR_DT			name="퇴점일"			show=false </FC>'
					 + '<FC>id=MEMO					name="메모"				show=false </FC>'
					 + '<FC>id=WED_YN				name="결혼여부"			show=false </FC>';

	initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate1() {
	var hdrProperies =  
		   '<FC>id={currow}				name="NO"				width=30	align=center	</FC>'
		 + '<FC>id=VENEMP_ID			name="ID"				show=false </FC>'  
		 + '<FC>id=DTL_FLAG				name="구분"				show=false </FC>'
		 + '<FC>id=DTL_SEQ_NO			name="순번"				show=false	</FC>'
		 + '<FC>id=REG_DATE				name="등록일"				width=90	align=left		Edit=none </FC>'
		 + '<FC>id=DTL_CONTENTS			name="내용"				width=500   align=left 		</FC>';

	initGridStyle(GD_DETAIL1, "common", hdrProperies, true);
}

function gridCreate2() {
	var hdrProperies =  
			   '<FC>id={currow}				name="NO"				width=30	align=center	</FC>'
			 + '<FC>id=VENEMP_ID			name="ID"				show=false </FC>'  
			 + '<FC>id=DTL_FLAG				name="구분"				show=false </FC>'
			 + '<FC>id=DTL_SEQ_NO			name="순번"				show=false	</FC>'
			 + '<FC>id=REG_DATE				name="등록일"				width=90	align=left		Edit=none </FC>'
			 + '<FC>id=DTL_CONTENTS			name="내용"				width=500   align=left 		</FC>';

	initGridStyle(GD_DETAIL2, "common", hdrProperies, true);
}

function gridCreate3() {
	var hdrProperies =  
			   '<FC>id={currow}				name="NO"				width=30	align=center	</FC>'
			 + '<FC>id=VENEMP_ID			name="ID"				show=false </FC>'  
			 + '<FC>id=DTL_FLAG				name="구분"				show=false </FC>'
			 + '<FC>id=DTL_SEQ_NO			name="순번"				show=false	</FC>'
			 + '<FC>id=REG_DATE				name="등록일"				width=90	align=left		Edit=none </FC>'
			 + '<FC>id=DTL_CONTENTS			name="내용"				width=500   align=left 		</FC>';

	initGridStyle(GD_DETAIL3, "common", hdrProperies, true);
}

function gridCreate4() {
	var hdrProperies =  
		   '<FC>id={currow}				name="NO"				width=30	align=center	</FC>'
		 + '<FC>id=VENEMP_ID			name="ID"				show=false </FC>'  
		 + '<FC>id=DTL_FLAG				name="구분"				show=false </FC>'
		 + '<FC>id=DTL_SEQ_NO			name="순번"				show=false	</FC>'
		 + '<FC>id=REG_DATE				name="등록일"				width=90	align=left		Edit=none </FC>'
		 + '<FC>id=DTL_CONTENTS			name="내용"				width=500   align=left 		</FC>';

	initGridStyle(GD_DETAIL4, "common", hdrProperies, true);
}

function gridCreate5() {
	var hdrProperies =  
					   '<FC>id={currow}				name="NO"				width=30	align=center	</FC>'
					 + '<FC>id=VENEMP_ID			name="ID"				show=false </FC>'  
					 + '<FC>id=DTL_FLAG				name="구분"				show=false </FC>'
					 + '<FC>id=DTL_SEQ_NO			name="순번"				show=false	</FC>'
					 + '<FC>id=REG_DATE				name="등록일"				width=90	align=center		Edit=none </FC>'
					 + '<FC>id=DTL_CONTENTS			name="내용"				width=500   align=left 		edit={DECODE(REG_DATE,"","true","false")}</FC>';

	initGridStyle(GD_DETAIL5, "common", hdrProperies, true);
}

/**
 * setPumbunCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드 팝업을 실행한다.
 * return값 : void
**/
function setPumbunCode(evnFlag, svcFlag, codeObj, nameObj){

	if( evnFlag == 'POP'){
		strPbnPop(codeObj,nameObj,'N')
		codeObj.Focus();
		return;
	}

	if( codeObj.Text == ""){
		nameObj.Text = "";
		return;
	}

	setStrPbnNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 0);
}

function fn_menuPop(val) {
	var mode = "I";
	var posNotiNo = "";
	if(val=='1'){
		var arrArg  = new Array();
	    
	    arrArg.push(mode);
	    arrArg.push(posNotiNo);
	    
	    var returnVal = window.showModalDialog("/dps/pcodC01.pc?goTo=detail",
	                                           arrArg,
	                                           "dialogWidth:1024px;dialogHeight:768px;scroll:yes;" +
	                                           "resizable:no;help:no;unadorned:yes;center:yes;status:yes");

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

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 조회
 * return값 : void
 */
function btn_Search() {

	//데이터 초기화
	DS_IO_MASTER.ClearData();
	
	var strStrCd		= LC_O_STR_CD.BindColVal;
    var strVenCd		= EM_O_VEN_CD.Text;
    //var strVenNm		= EM_O_VEN_NM.Text;
    var strPumBun		= EM_O_PUMBUN.Text;
    //var strPumBunNm		= EM_O_PUMBUN_NM.Text;
    var strKorNm		= EM_O_KOR_NM.Text;
    var strWorkType		= LC_O_DEL_FLAG.BindColVal;
    var strGJDate		= LC_O_GJDATE.BindColVal;
    var strSStartDt		= EM_S_START_DT.Text;
    var strSEndDt		= EM_S_END_DT.Text;
    var strEdu			= LC_O_EDU.BindColVal;
    
    if(strWorkType == "%") {
    	strWorkType = "";
    }
	    
    var goTo			= "searchMaster" ;    
    var action			= "O";     
    var parameters		= "&strStrCd=" 	 +encodeURIComponent(strStrCd)
					    + "&strVenCd=" 	 +encodeURIComponent(strVenCd)
					    + "&strPumBun="	 +encodeURIComponent(strPumBun)
					    + "&strKorNm=" 	 +encodeURIComponent(strKorNm)
					    + "&strWorkType="+encodeURIComponent(strWorkType)
					    + "&strGJDate="	 +encodeURIComponent(strGJDate)
					    + "&strSStartDt="+encodeURIComponent(strSStartDt)
					    + "&strSEndDt="  +encodeURIComponent(strSEndDt)
					    + "&strEdu="     +encodeURIComponent(strEdu)
					    ;
    

    TR_MAIN.Action="/dps/pcodC01.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER); 
}


function search_detail() {

	//데이터 초기화
	DS_IO_DETAIL5.ClearData();
	
    var venemp_id		= "";
    
    
	    
    var goTo			= "searchdetail" ;    
    var action			= "O";     
    var parameters		= "&venemp_id="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VENEMP_ID"))
					    + "&flag=5";
	
    TR_DETAIL.Action="/dps/pcodC01.pc?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL5=DS_IO_DETAIL5)"; //조회는 O
    TR_DETAIL.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER); 
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 신규
 * return값 : void
 */
function btn_New() {
	//기존의 신규로우 존재 시 데이타 클리어 
    //if( newMasterYn ) {
        //if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){   
            //return;
        //}
        //DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
    //}

    //수정된 내용 존재시
    if( DS_IO_MASTER.IsUpdated){
    	//변경 된 상세 내역이 존재합니다.<br> 신규 작성  하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1){            
            EM_STR_NAME.Focus();
            return ;
        }
        DS_IO_MASTER.UndoAll();
    }
        
    //행추가
    DS_IO_MASTER.Addrow();

    var row = DS_IO_MASTER.CountRow;
    
    newMasterYn = true;
    enableCnt("T");
    
    
    
    var	strcd	= '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';								// 로그인 점코드
	
    LC_IO_STR_CD.BindColVal  =	strcd;
    EM_IO_MOBILE_PH1.TEXT = "010";
    //입점일
    EM_IO_INSTR_DT.Text=varToday;
    //반납일
    //EM_IO_TEMP_PASS_RET_DT.Text=varToday;
    //정규사원증접수일
    //EM_IO_TEMP_PASS_ISSUE_DT.Text=varToday;
    //정규사원증 발급일
    //EM_IO_EMP_ID_ISSUE_DT.Text=varToday;
    //퇴점일
    //EM_IO_OUTSTR_DT.Text=varToday;
    
    
    EM_IO_KOR_NM.Focus();
    
    /* 성별 초기값 셋팅 */
    RD_IO_SEX_CD.CodeValue="M";
    /* 양력,음력 초기값 세팅 */
    RD_IO_BIRTH_LUNAR_FLAG.CodeValue="S";
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 삭제
 * return값 : void
 */
function btn_Delete() {
	// 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        return;
    }
    
	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
    
    TR_MAIN.Action="/dps/pcodC01.pc?goTo=delete";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    //트랜젝션이 다름
    TR_MAIN.Post();

    btn_Search();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 저장
 * return값 : void
 */
function btn_Save() {
	 
	 
	 
    if( !DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL5.IsUpdated){
        // 저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028"); 
        return;
    }
    
    //필수 입력체크 
    if(!checkValidation("Save"))
        return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
   
    if(DS_IO_MASTER.IsUpdated) {
	    TR_MAIN.Action="/dps/pcodC01.pc?goTo=save";  
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
	    TR_MAIN.Post();
	    
	    
    } 
    if(DS_IO_DETAIL5.IsUpdated) { 
    	
    	DS_IO_DETAIL5.NameValue(DS_IO_DETAIL5.RowPosition,"VENEMP_ID") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VENEMP_ID");
            	
    	TR_DETAIL.Action="/dps/pcodC01.pc?goTo=savedetail";  
        TR_DETAIL.KeyValue="SERVLET(I:DS_IO_DETAIL5=DS_IO_DETAIL5)"; 
        TR_DETAIL.Post();	
    }
        
 
    if( TR_MAIN.ErrorCode == 0){
        btn_Search(); 
    }
 
    if( TR_DETAIL.ErrorCode == 0){
    	search_detail(); 
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 엑셀
 * return값 : void
 */
function btn_Excel() {
	
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 출력
 * return값 : void
 */
function btn_Print() {
	
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 확정
 * return값 : void
 */
function btn_Conf() {
	
}

/**
 * btn_Add1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 그리드 Row추가 
 * return값 : void
 */
function btn_Add1() {
	//DS_IO_DETAIL5
	//GD_DETAIL5
	var i = 0;
	
	
	if( DS_IO_MASTER.RowPosition < 1){
	    showMessage(INFORMATION, OK, "USER-1025");
	    return;
	} 
	
	if( DS_IO_DETAIL5.IsUpdated){
    	//변경 된 상세 내역이 존재합니다.<br> 신규 작성  하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1){            
            return ;
        }
        DS_IO_DETAIL5.UndoAll();
    }
        
    //행추가
    DS_IO_DETAIL5.Addrow();
    
    
	
 }


/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab1(){}

/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab2(){}

/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab3(){}

/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab4(){}

/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab5(){}

/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab6(){}

/**
 * clickTab1()
 * 작 성 자 : 강진
 * 작 성 일 : 2012-08-27
 * 개       요 : 입점면접 탭 클릭시 실행 
 * return값 : void
**/
function clickTab7(){}

function enableCnt( flag ){

    enableControl(EM_IO_KOR_NM             , flag==null?false:flag);  //성명(한글)                                        
    enableControl(LC_IO_STR_CD             , flag==null?false:flag);  //점                                                              
    enableControl(EM_IO_PUMBUN_CD          , flag==null?false:flag);  //브랜드 코드                                                     
    enableControl(EM_IO_PUMBUN_NM          , flag==null?false:flag);  //브랜드 이름                                                     
    enableControl(LC_IO_JOB_CD             , flag==null?false:flag);  //직급                                                            
    enableControl(EM_IO_VEN_CD             , flag==null?false:flag);  //협력사코드                                                      
    enableControl(EM_IO_VEN_NM             , flag==null?false:flag);  //협력사이름                                                      
    enableControl(EM_IO_INSTR_DT           , flag==null?false:flag);  //입점일 
    enableControl(LC_IO_WED_YN             , flag==null?false:flag);  //결혼여부
   // enableControl(RD_IO_SEX_CD             , flag==null?false:flag);  //  성별/나이    (M:남, F:여)
    if(flag==null){
	    RD_IO_SEX_CD.Enable = "false";
	    RD_IO_BIRTH_LUNAR_FLAG.Enable = "false";
    }else{
    	RD_IO_SEX_CD.Enable = "true";
    	RD_IO_BIRTH_LUNAR_FLAG.Enable = "true";
    }
    //enableControl(EM_IO_AGE                , flag==null?false:flag);  //세                                                              
    enableControl(EM_IO_BIRTH_DT           , flag==null?false:flag);  //생년월일                                                        
    //enableControl(RD_IO_BIRTH_LUNAR_FLAG   , flag==null?false:flag);  //생일구분  (S:양력, L:음력)
    enableControl(EM_IO_HOME_ZIP_CD       , flag==null?false:flag);  //주소                                                           
    enableControl(EM_IO_HOME_ADDR1         , flag==null?false:flag);  //주소                                                            
    enableControl(EM_IO_HOME_ADDR2         , flag==null?false:flag);  //주소   
    
    enableControl(EM_IO_HOME_PH1           , flag==null?false:flag);  //전화번호                                                            
    enableControl(EM_IO_HOME_PH2           , flag==null?false:flag);  //전화번호                                                            
    enableControl(EM_IO_HOME_PH3           , flag==null?false:flag);  //전화번호 
    
    
    enableControl(EM_IO_MOBILE_PH1         , flag==null?false:flag);  //핸드폰                                                          
    enableControl(EM_IO_MOBILE_PH2         , flag==null?false:flag);  //핸드폰                                                          
    enableControl(EM_IO_MOBILE_PH3         , flag==null?false:flag);  //핸드폰                                                          
    enableControl(EM_IO_ORGN_ZIP_CD       , flag==null?false:flag); //본적                                                            
    enableControl(EM_IO_ORGN_ADDR1         , flag==null?false:flag);  //본적                                                            
    enableControl(EM_IO_ORGN_ADDR2         , flag==null?false:flag);  //본적                                                            
    enableControl(EM_IO_EMAIL1             , flag==null?false:flag); //이메일                                                          
    enableControl(LC_IO_DOMAIN_FLAG        , flag==null?false:flag);  //이메일
    
    enableControl(EM_IO_EMAIL2             , false);  //이메일                                                          
    enableControl(EM_IO_TEMP_PASS_NO       , flag==null?false:flag);  //임시출입증번호                                                  
    enableControl(EM_IO_TEMP_PASS_RET_DT   , flag==null?false:flag);  //반납                                                            
    enableControl(EM_IO_TEMP_PASS_ISSUE_DT , flag==null?false:flag);  //정규사원증(접수일)                                              
    enableControl(EM_IO_EMP_ID_ISSUE_DT    , flag==null?false:flag);  //정규사원증(발급일)                                              
    enableControl(EM_IO_OUTSTR_DT          , flag==null?false:flag);  //퇴점일                                                          
    enableControl(EM_IO_MEMO               , flag==null?false:flag);  //메모 
    
    return;
}
function btn_Del1(){
	
	
	if(DS_IO_DETAIL5.CountRow < 1){
		showMessage(INFORMATION, OK, "USER-1019");
        return;		
	}

	if(DS_IO_DETAIL5.RowStatus(DS_IO_DETAIL5.RowPosition) == 1){
		DS_IO_DETAIL5.DeleteRow(DS_IO_DETAIL5.RowPosition);		
        return;
    }   
	DS_IO_DETAIL5.DeleteRow(DS_IO_DETAIL5.RowPosition);
    //showMessage(INFORMATION, OK, "USER-1052");
}

/**
 * setRecPumbunCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 대표브랜드 팝업을 실행한다.
 * return값 : void
**/
function setRecPumbunCode(evnFlag, codeObj, nameObj){     
	if( evnFlag == 'POP'){
	    repPumbunPop(codeObj,nameObj,'N');
	    codeObj.Focus();	    
		return;
	}	
	if( codeObj.Text == ""){
	    nameObj.Text = "";
        return;
	}
	
	
	setRepPumbunNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 1);
}
/**
 * setVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/
function setVenCode(evnFlag, svcFlag, codeObj, nameObj){
    
    if( evnFlag == 'POP'){
    	venPop(codeObj,nameObj,'',svcFlag=='I'?'Y':'');
        codeObj.Focus();
        
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , svcFlag=='I'?1:0,'',svcFlag=='I'?'Y':'');
	
    
}

/**
 * checkValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 입력값을 검증한다.
 * return값 : void
 */
function checkValidation(Gubun){
	var messageCode = "USER-1001";
    
    // 저장버튼 클릭시 Validation Check
    if(Gubun == "Save"){          
        var intRowCount   = DS_IO_MASTER.CountRow;
        
        if(intRowCount > 0){
            for(var i=1; i <= intRowCount; i++){
         	  strRowStatus   = DS_IO_MASTER.RowStatus(i);               //신규, 수정 구분값     
         	 
         	 
         	 //if(DS_IO_MASTER.NameValue(i,"HOME_NEW_YN")=="Y"){
         	 //}else{
         		//DS_IO_MASTER.NameValue(i,"HOME_NEW_YN")="N";
         	 //}
         	 //if(DS_IO_MASTER.NameValue(i,"ORGN_NEW_YN")=="Y"){
         		 
         	 //}else{
         		//DS_IO_MASTER.NameValue(i,"ORGN_NEW_YN")="N";
         	 //}
         	
         	 
             if(DS_IO_MASTER.NameValue(i,"KOR_NM") == ""||DS_IO_MASTER.NameValue(i,"KOR_NM") == null){
                 showMessage(INFORMATION, OK, "USER-1003", "성명(한글)");
                 DS_IO_MASTER.RowPosition = i;  
                 return false;
            	 }
              
         	 if(DS_IO_MASTER.NameValue(i,"STR_CD").length <= 0){
                    showMessage(INFORMATION, OK, "USER-1003", "점");
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
            	 }
         	 
         	 if(DS_IO_MASTER.NameValue(i,"PUMBUN_CD").length <= 0){
                    showMessage(INFORMATION, OK, "USER-1003", "브랜드");
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
            	 }
         	 
         	if(EM_IO_PUMBUN_NM.length <= 0){
                showMessage(INFORMATION, OK, "USER-1003", "브랜드");
                DS_IO_MASTER.RowPosition = i;  
                return false;
        	 }
         	
         	//if(DS_IO_MASTER.NameValue(i,"VEN_CD").length <= 0){
                //showMessage(INFORMATION, OK, "USER-1003", "협력사코드");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
        	 //}
         	 
         	 if(DS_IO_MASTER.NameValue(i,"BIRTH_DT").length != 8){
                showMessage(INFORMATION, OK, "USER-1003", "생년월일");
                DS_IO_MASTER.RowPosition = i;  
                return false;
         		}
         	if(DS_IO_MASTER.NameValue(i,"INSTR_DT").length != 8){
                showMessage(INFORMATION, OK, "USER-1003", "입점일");
                DS_IO_MASTER.RowPosition = i;  
                return false;
         		}
         	
         	//if(DS_IO_MASTER.NameValue(i,"HOME_ZIP_CD")==null||DS_IO_MASTER.NameValue(i,"HOME_ZIP_CD")==""){
                //showMessage(INFORMATION, OK, "USER-1003", "우편번호");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
         		//}
         	
         	//if(DS_IO_MASTER.NameValue(i,"HOME_ADDR1")==null||DS_IO_MASTER.NameValue(i,"HOME_ADDR1")==""){
                //showMessage(INFORMATION, OK, "USER-1003", "주소");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
         		//}
         	//if(DS_IO_MASTER.NameValue(i,"HOME_ADDR2")==null||DS_IO_MASTER.NameValue(i,"HOME_ADDR2")==""){
                //showMessage(INFORMATION, OK, "USER-1003", "상세주소");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
         		//}
         	//if(DS_IO_MASTER.NameValue(i,"HOME_PH1")==null||DS_IO_MASTER.NameValue(i,"HOME_PH1")==""){
                //showMessage(INFORMATION, OK, "USER-1003", "전화번호 앞자리");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
         		//}
         	//if(DS_IO_MASTER.NameValue(i,"HOME_PH2")==null||DS_IO_MASTER.NameValue(i,"HOME_PH2")==""){
                //showMessage(INFORMATION, OK, "USER-1003", "전화번호 중간자리");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
         		//}
         	//if(DS_IO_MASTER.NameValue(i,"HOME_PH3")==null||DS_IO_MASTER.NameValue(i,"HOME_PH3")==""){
                //showMessage(INFORMATION, OK, "USER-1003", "전화번호 뒷자리");
                //DS_IO_MASTER.RowPosition = i;  
                //return false;
         		//}
         	
       		if(DS_IO_MASTER.NameValue(i,"MOBILE_PH1").length<=0||DS_IO_MASTER.NameValue(i,"MOBILE_PH1").length<3){
                  showMessage(INFORMATION, OK, "USER-1003", "핸드폰 앞자리");
                  DS_IO_MASTER.RowPosition = i;  
                  return false;
           		}
       		if(DS_IO_MASTER.NameValue(i,"MOBILE_PH2").length<=0||DS_IO_MASTER.NameValue(i,"MOBILE_PH2").length<3){
                  showMessage(INFORMATION, OK, "USER-1003", "핸드폰 중간자리");
                  DS_IO_MASTER.RowPosition = i;  
                  return false;
           		}
       		if(DS_IO_MASTER.NameValue(i,"MOBILE_PH3").length<=0||DS_IO_MASTER.NameValue(i,"MOBILE_PH3").length<4){
                  showMessage(INFORMATION, OK, "USER-1003", "핸드폰 뒷자리");
                  DS_IO_MASTER.RowPosition = i;  
                  return false;
           		}
         		
         	if(DS_IO_MASTER.NameValue(i,"ORGN_ZIP_CD")!=""){
         		if(DS_IO_MASTER.NameValue(i,"ORGN_ZIP_CD").length<6){
                    showMessage(INFORMATION, OK, "USER-1003", "본적 우편번호");
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
             		}
         		if(DS_IO_MASTER.NameValue(i,"ORGN_ADDR1")==""){
	                showMessage(INFORMATION, OK, "USER-1003", "본적 주소");
	                DS_IO_MASTER.RowPosition = i;  
	                return false;
	         		}
	         	if(DS_IO_MASTER.NameValue(i,"ORGN_ADDR2")==""){
	                showMessage(INFORMATION, OK, "USER-1003", "본적 상세주소");
	                DS_IO_MASTER.RowPosition = i;  
	                return false;
	         		}
    	        }
         	if(DS_IO_MASTER.NameValue(i,"EMAIL1")!=""){
         		if(DS_IO_MASTER.NameValue(i,"DOMAIN_FLAG").BindColVal==""){
         			showMessage(INFORMATION, OK, "USER-1000", "E-mail을 확인하세요.");
	                DS_IO_MASTER.RowPosition = i; 
	                return false;
         			}
         		}
     		}
        }
    }
    return true; 
}

function getPostPopGuBun(objCd,objNm1,objNm2,gubun)
{
	
	
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	//arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:900px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  
    
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("POST_NO");
		objNm1.Text = map.get("ADDR1");
		objNm2.Text = map.get("ADDR2");
		gubun.Text  = map.get("GUBUN");
		objNm2.Focus();	
 	}
    
}

</script>



</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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
<!--  ===================SEARCH CONDITION AREA START ================= -->

<!--  ===================DS_IO_MASTER START ============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_DETAIL의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER END ============================ -->

<!--  =================== GD_MASTER START ============================ -->

<script language=JavaScript for=DS_PAY_DT_FLAG_I event=OnFilter(row)>
 </script>

<!--  =================== GD_MASTER END ============================ -->
<!--  ===================GD_DETAIL START ============================ -->
<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
</script>
<!--  ===================GD_DETAIL END ============================ -->
<!--  ===================SEARCH CONDITION AREA END ================= -->
<!-- 협력사코드 변경시 -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
</script>
<script language=JavaScript for=EM_IO_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setRecPumbunCode('NAME',EM_IO_PUMBUN_CD,EM_IO_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_O_PUMBUN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setRecPumbunCode('NAME',EM_O_PUMBUN,EM_O_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_O_VEN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setVenCode('NAME','I',EM_O_VEN_CD,EM_O_VEN_NM);
</script>
<script language=JavaScript for=EM_IO_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
    setVenCode('NAME','I',EM_IO_VEN_CD,EM_IO_VEN_NM);
</script>
<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>
<script language=JavaScript for=LC_IO_DOMAIN_FLAG event=OnSelChange>
	if(LC_IO_DOMAIN_FLAG.BindColVal=="99"){
		
		enableControl(EM_IO_EMAIL2         , true);
	}else{
		enableControl(EM_IO_EMAIL2         , false);
	}
</script>
<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
	if (LC_O_STR_CD.BindColVal != "%"){
		strStrCdPopUp = LC_O_STR_CD.BindColVal;
	}else
		strStrCdPopUp = "";
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>


	search_detail();
	
    if( row < 1 )
        return;
    
    enableCnt("T");
      
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"><!-- 서브 시스템 값 가져오기  -->
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><!-- 점 -->
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"><!-- 기준일 -->
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"><!-- 직급 -->
<object id="DS_O_DEL_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"><!-- 졸업현황 -->
<object id="DS_IO_SCHL_GRUD_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL1" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL3" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL4" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL5" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- =============== Input/Output 겸용 -->
<comment id="_NSID_"> <!-- 점 -->
<object id="DS_IO_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"> <!-- 직급 -->
<object id="DS_IO_JOB_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"> <!-- 근무형태 -->
<object id="DS_IO_WORK_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"> <!-- 도메인 구분 -->
<object id="DS_IO_DOMAIN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>



<comment id="_NSID_"> <!-- CS교육 구분 -->
<object id="DS_O_EDU" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"> <!-- 결혼여부 -->
<object id="DS_IO_WED_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_VENMST" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("tab_page1");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("TAB_VEN");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    
    
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td width="160">
							<comment id="_NSID_">
								<object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width="100%" align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
						<th width="80">협력사</th>
						<td width="170">
							<comment id="_NSID_">
								<object id=EM_O_VEN_CD classid=<%= Util.CLSID_EMEDIT %> width=60 tabindex=1  align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:venPop(EM_O_VEN_CD,EM_O_VEN_NM); EM_O_VEN_CD.Focus();" align="absmiddle" />
							<comment id="_NSID_">
								<object id=EM_O_VEN_NM classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1  align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
						<th width="80">브랜드</th>
						<td colspan="3">
							<comment id="_NSID_">
								<object id=EM_O_PUMBUN classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1  align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:setPumbunCode('POP','S',EM_O_PUMBUN,EM_O_PUMBUN_NM);" align="absmiddle" />
							<comment id="_NSID_">
								<object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>성명</th>
						<td>
							<comment id="_NSID_">
								<object id=EM_O_KOR_NM classid=<%=Util.CLSID_EMEDIT%> width=98% tabindex=1 align="left"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
						<th>삭제구분</th>
						<td colspan="5">
							<comment id="_NSID_">
								<object id=LC_O_DEL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
						
					</tr>
					<tr>
						<th class="point">기준일</th>
						<td>
							<comment id="_NSID_">
								<object id=LC_O_GJDATE classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100% tabindex=1 align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
						<th>조회기간</th>
						<td colspan="3">
							<comment id="_NSID_">
								<object id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
							</comment><script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />
							&nbsp;~&nbsp;
							<comment id="_NSID_">
								<object id=EM_S_END_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
						</td>
						<th width="100">CS교육</th>
						<td>
							<comment id="_NSID_">
								<object id=LC_O_EDU classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
							</comment>
							<script>_ws_(_NSID_);</script>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="500">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
					<tr>
						<td>
							<comment id="_NSID_">
								<object id=GD_MASTER width="100%" height="453" classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_MASTER">
								</object>
							</comment>
							<script>_ws_(_NSID_);</script>
						</td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<div id=TAB_VEN width="100%" height=463 TitleWidth=80
					TitleAlign="center" TitleStyle="" TitleGap=3>
				<menu TitleName="기본사항" DivId="tab_page1" ClickBfFunc="clickTab1" />	
				<!-- 
				<menu TitleName="인적사항" DivId="tab_page2" ClickBfFunc="clickTab2" />
				<menu TitleName="교육사항" DivId="tab_page3" ClickBfFunc="clickTab3" />
				<menu TitleName="입점면접" DivId="tab_page4" ClickBfFunc="clickTab4" />
				<menu TitleName="근무평가" DivId="tab_page5" ClickBfFunc="clickTab5" />
				<menu TitleName="퇴점평가" DivId="tab_page6" ClickBfFunc="clickTab6" />
				<menu TitleName="기타사항" DivId="tab_page7" ClickBfFunc="clickTab7" />
				-->
				</div>
				<div id=tab_page1 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="sub_title PB03 PT10">
								<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 기본사항
							</td>
						</tr>
						<tr>
							<td>						
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="">
									<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
										<tr>
											<th width="90" class="point">성명(한글)</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_KOR_NM classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="left"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th class="point">점</th>
											<td>
												<comment id="_NSID_">
													<object id=LC_IO_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
											<th class="point">브랜드</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:setPumbunCode('POP','S',EM_IO_PUMBUN_CD,EM_IO_PUMBUN_NM);" align="absmiddle" />
												<comment id="_NSID_">
													<object id=EM_IO_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th>직급</th>
											<td>
												<comment id="_NSID_">
													<object id=LC_IO_JOB_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
											<th>협력사</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_VEN_CD classid=<%= Util.CLSID_EMEDIT %> width=45 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:venPop(EM_IO_VEN_CD,EM_IO_VEN_NM); EM_IO_VEN_CD.Focus();" align="absmiddle" />
												<comment id="_NSID_">
													<object id=EM_IO_VEN_NM classid=<%= Util.CLSID_EMEDIT %> width=78 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th>결혼여부</th>
											<td>
												<comment id="_NSID_">
													<object id=LC_IO_WED_YN classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>										
											</td>
											<th>성별</th>
											<td width="150">
												<comment id="_NSID_">
													<object id=RD_IO_SEX_CD classid=<%=Util.CLSID_RADIO%> width=150 height="20" tabindex=1>
														<param name=Cols value="2">
														<param name=Format value="M^남,F^여">
														<param name="AutoMargin" value="true">
														<param name=CodeValue value="M">
													 </object>
												</comment>
												<script>_ws_(_NSID_);</script>
												
											</td>
											<!-- 
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_AGE classid=<%= Util.CLSID_EMEDIT %> width=30 tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>세
											</td>
											 -->
										</tr>
										<tr>
											<th class="point">생년월일</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_BIRTH_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_BIRTH_DT)" align="absmiddle" />
											</td>
											<th>생일구분</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=RD_IO_BIRTH_LUNAR_FLAG classid=<%=Util.CLSID_RADIO%> width=140 height="20" tabindex=1>
														<param name=Cols value="2">
														<param name=Format value="S^양력,L^음력">
														<param name="AutoMargin" value="true">
														<param name=CodeValue value="S">
													 </object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th rowspan="2" >주소</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_HOME_ZIP_CD classid=<%=Util.CLSID_EMEDIT%> width=60  tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:getPostPopGuBun(EM_IO_HOME_ZIP_CD, EM_IO_HOME_ADDR1, EM_IO_HOME_ADDR2,EM_HOME_NEW_YN);EM_IO_HOME_ADDR2.Focus();" align="absmiddle" />
											</td>
											<td colspan="3">
												<comment id="_NSID_">
													<object id=EM_IO_HOME_ADDR1 classid=<%=Util.CLSID_EMEDIT%> width=256 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<comment id="_NSID_">
													<object id=EM_IO_HOME_ADDR2 classid=<%=Util.CLSID_EMEDIT%> width=411 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr style="display: none">
											<td colspan="4" >
												<comment id="_NSID_" >
													<object id=EM_HOME_NEW_YN classid=<%=Util.CLSID_EMEDIT%> width=411 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th >전화</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_HOME_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>-
												<comment id="_NSID_">
													<object id=EM_IO_HOME_PH2 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>-
												<comment id="_NSID_">
													<object id=EM_IO_HOME_PH3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
											<th class="point">핸드폰</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>-										
												<comment id="_NSID_">
													<object id=EM_IO_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>-
												<comment id="_NSID_">
													<object id=EM_IO_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th rowspan="2">본적</th>
											<td>
												
												<comment id="_NSID_">
													<object id=EM_IO_ORGN_ZIP_CD classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:getPostPopGuBun(EM_IO_ORGN_ZIP_CD, EM_IO_ORGN_ADDR1, EM_IO_ORGN_ADDR2,EM_ORGN_NEW_YN);EM_IO_ORGN_ADDR2.Focus();" align="absmiddle" />
											</td>
											<td colspan="3">
												<comment id="_NSID_">
													<object id=EM_IO_ORGN_ADDR1 classid=<%=Util.CLSID_EMEDIT%> width=256 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<comment id="_NSID_">
													<object id=EM_IO_ORGN_ADDR2 classid=<%=Util.CLSID_EMEDIT%> width=411 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr style="display: none">
											<td colspan="4">
												<comment id="_NSID_">
													<object id=EM_ORGN_NEW_YN classid=<%=Util.CLSID_EMEDIT%> width=411 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										
										<tr>
											<th>E-mail</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_EMAIL1 classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
											<td>
												<comment id="_NSID_">
													<object id=LC_IO_DOMAIN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1 align="absmiddle"></object>
												</comment>
												<script>_ws_(_NSID_);</script>
											</td>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_EMAIL2 classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
											<th>임시출입증번호</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_TEMP_PASS_NO classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
											<th>반납일</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_TEMP_PASS_RET_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_TEMP_PASS_RET_DT)" align="absmiddle" />
											</td>
										</tr>
										<tr>
											<th class="height">정규사원증<br>접수일</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_TEMP_PASS_ISSUE_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_TEMP_PASS_ISSUE_DT)" align="absmiddle" />
											</td>
											<th class="height">정규사원증<br>발급일</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_EMP_ID_ISSUE_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_EMP_ID_ISSUE_DT)" align="absmiddle" />
											</td>
										</tr>
										<tr>
											<th>입점일</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_IO_INSTR_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_INSTR_DT)" align="absmiddle" />
											</td>
											<th>퇴점일</th>
											<td colspan="2">
												<comment id="_NSID_">
													<object id=EM_IO_OUTSTR_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_OUTSTR_DT)" align="absmiddle" />									
											</td>									
										</tr>
										<tr>
											<th>CS교육</th>
											<td colspan="4">
												<input type="checkbox" id="CHK_EDU1" >입점
												<input type="checkbox" id="CHK_EDU2" >심화1차
												<input type="checkbox" id="CHK_EDU3" >심화2차
												<input type="checkbox" id="CHK_EDU4" >심화3차
											</td>
										</tr>
										<tr>
											<th>메모</th>
											<td colspan="4">
												<comment id="_NSID_">
													<object id=EM_IO_MEMO classid=<%=Util.CLSID_EMEDIT%> width=411 tabindex=1 align="absmiddle"></object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>									
					</table>	
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 기타사항</td>
									<td class="right PB02" valign="bottom"><img
										src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
										onclick="javascript:btn_Add1();" hspace="2" /><img
										src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
										onclick="javascript:btn_Del1();" /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
									<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
										width="100%">
										<tr>
											<td><comment id="_NSID_"><object id=GD_DETAIL5	width="100%" height=300 classid=<%=Util.CLSID_GRID%>>
												<param name="DataID" value="DS_IO_DETAIL5">
											</object></comment><script>_ws_(_NSID_);</script></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>									
					</table>			
				</div>
				
				
				<!-- 
				<div id=tab_page2 border=0 
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                        <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 기본정보</td>
	                            </tr>
	                        </table>
	                        </td>
	                    </tr>
						<tr>
	                        <td class="PT03">
	                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
	                            class="s_table">
	                            <tr>
									<th width="90">성명(한글)</th>
									<td width="150">
										<comment id="_NSID_">
											<object id=EM_M_KOR_NM classid=<%=Util.CLSID_EMEDIT%> width=143 tabindex=1 align="left"></object>
										</comment>									
										<script>_ws_(_NSID_);</script>
									</td>
									<th width="100">전화</th>
									<td colspan="2">
										<comment id="_NSID_">
											<object id=EM_M_HOME_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_M_HOME_PH2 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_M_HOME_PH3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>									
									</td>
								</tr>
								<tr>
									<th>성명(한자)</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_CHI_NM classid=<%=Util.CLSID_EMEDIT%> width=143 tabindex=1 align="left"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<th>핸드폰번호</th>
									<td colspan="2">
										<comment id="_NSID_">
											<object id=EM_M_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-										
										<comment id="_NSID_">
											<object id=EM_M_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>-
										<comment id="_NSID_">
											<object id=EM_M_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>							
								</tr>
								<tr>
									<th>결혼여부</th>
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_M_WED_YN classid=<%=Util.CLSID_EMEDIT%> width=143 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>생년월일</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_BIRTH_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_M_BIRTH_DT)" align="absmiddle" />
									</td>
									<th>생일구분</th>
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_M_BIRTH_LUNAR_FLAG classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>&nbsp;
										<comment id="_NSID_">
											<object id=EM_M_AGE classid=<%= Util.CLSID_EMEDIT %> width=30 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>세
									</td>								
								</tr>
								<tr>
									<th rowspan="2">주소</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_HOME_ZIP_CD classid=<%=Util.CLSID_EMEDIT%> width=60  tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:getPostPopGuBun(EM_M_HOME_ZIP_CD, EM_M_HOME_ADDR1, EM_M_HOME_ADDR2,EM_M_HOME_NEW_YN);EM_M_HOME_ADDR2.Focus();" align="absmiddle" />
									</td>
									<td colspan="3">
										<comment id="_NSID_">
											<object id=EM_M_HOME_ADDR1 classid=<%=Util.CLSID_EMEDIT%> width=260 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<comment id="_NSID_">
											<object id=EM_M_HOME_ADDR2 classid=<%=Util.CLSID_EMEDIT%> width=415 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr style="display: none">
									<td colspan="4" >
										<comment id="_NSID_" >
											<object id=EM_M_HOME_NEW_YN classid=<%=Util.CLSID_EMEDIT%> width=411 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<th>E-mail</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_EMAIL1 classid=<%=Util.CLSID_EMEDIT%> width=143 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_DOMAIN_FLAG classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<td colspan="2">
										<comment id="_NSID_">
											<object id=EM_M_EMAIL2 classid=<%=Util.CLSID_EMEDIT%> width=143 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>										
                            </table>
                        	</td>
                    	</tr>
                    	<tr>
	                        <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 입점 및 근무구분</td>
	                            </tr>
	                        </table>
	                        </td>
	                    </tr>
                    	<tr>
	                        <td class="PT03">
	                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
	                            class="s_table">
	                            <tr>	
									<th width="90">업체명(상호)</th>
									<td width="150">
										<comment id="_NSID_">
											<object id=EM_M_VEN_CD classid=<%= Util.CLSID_EMEDIT %> width=45 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:venPop(EM_M_VEN_CD,EM_M_VEN_NM); EM_M_VEN_CD.Focus();" align="absmiddle" />
										<comment id="_NSID_">
											<object id=EM_M_VEN_NM classid=<%= Util.CLSID_EMEDIT %> width=75 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>								
									</td>
									<th width="100"><input type="checkbox" id=CHK_WORK1 value="Y" tabindex=1>일시행사지원</th>
									<td colspan="2">
										<comment id="_NSID_">
											<object id=EM_IO_TEMP_ENT_SUP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_TEMP_ENT_SUP_S_DT)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_TEMP_ENT_SUP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_TEMP_ENT_SUP_E_DT)" align="absmiddle" />								
									</td>
								</tr>
								<tr>
									<th>브랜드명</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=45 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:setPumbunCode('POP','S',EM_M_PUMBUN_CD,EM_M_PUMBUN_NM);" align="absmiddle" />
										<comment id="_NSID_">
											<object id=EM_M_PUMBUN_NM classid=<%= Util.CLSID_EMEDIT %> width=75 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>								
									</td>
									<th><input type="checkbox" id=CHK_WORK2 value="Y" tabindex=1>브랜드고정A/R</th>
									<td colspan="2">
										<comment id="_NSID_">
											<object id=EM_IO_BRD_FIX_AR_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_BRD_FIX_AR_S_DT)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_BRD_FIX_AR_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_BRD_FIX_AR_E_DT)" align="absmiddle" />								
									</td>
								</tr>
								<tr>
									<th>직책</th>
									<td>
										<comment id="_NSID_">
											<object id=EM_M_JOB_NM classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>								
									<th><input type="checkbox" id=CHK_WORK3 value="Y" tabindex=1>장기행사지원</th>
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_IO_LONG_ENT_SUP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_LONG_ENT_SUP_S_DT)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_LONG_ENT_SUP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_LONG_ENT_SUP_E_DT)" align="absmiddle" />									
									</td>
								</tr>
								<tr>
									<th>근무형태</th>
									<td>
										<comment id="_NSID_">
											<object id=LC_IO_WORK_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=100% tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>								
									</td>								
									<th><input type="checkbox" id=CHK_WORK4 value="Y" tabindex=1>장기근무자</th>								
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_IO_LONG_WORK_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_LONG_WORK_S_DT)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_LONG_WORK_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_LONG_WORK_E_DT)" align="absmiddle" />									
									</td>
								</tr>										
                            </table>
                        	</td>
                    	</tr>
                    	<tr>
	                        <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 학력사항</td>
	                            </tr>
	                        </table>
	                        </td>
	                    </tr>
                    	<tr>
	                        <td class="PT03">
	                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
	                            class="s_table">
								<tr>
									<th width="90" style="text-align:center;">졸업년월</th>
	                                <th width="150" style="text-align:center;" >학교명</th>
	                                <th colspan=2 style="text-align:center;" >소재지</th>
	                                <th style="text-align:center;">졸업현황</th>
								</tr>
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_HI_SCHL_GRDU_YM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_HI_SCHL_GRDU_YM)" align="absmiddle" />
									</td>
									<td width="150">
										<comment id="_NSID_">
											<object id=EM_IO_HI_SCHL_NM classid=<%=Util.CLSID_EMEDIT%> width=103 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>고등학교
									</td>
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_IO_HI_SCHL_LOCATION classid=<%=Util.CLSID_EMEDIT%> width=223 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=LC_IO_HI_SCHL_GRUD_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=77 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_UNIVST_GRDU_YM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_UNIVST_GRDU_YM)" align="absmiddle" />
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_UNIVST_NM classid=<%=Util.CLSID_EMEDIT%> width=103 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>대학교
									</td>
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_IO_UNIVST_LOCATION classid=<%=Util.CLSID_EMEDIT%> width=223 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=LC_IO_UNIVST_GRDU_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=77 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>
								<tr>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_GRDU_SCHL_GRDU_YM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_GRDU_SCHL_GRDU_YM)" align="absmiddle" />
									</td>
									<td>
										<comment id="_NSID_">
											<object id=EM_IO_GRDU_SCHL_NM classid=<%=Util.CLSID_EMEDIT%> width=103 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>대학원
									</td>
									<td colspan=2>
										<comment id="_NSID_">
											<object id=EM_IO_GRDU_SCHL_LOCATION classid=<%=Util.CLSID_EMEDIT%> width=223 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
									<td>
										<comment id="_NSID_">
											<object id=LC_IO_GRDU_SCHL_GRDU_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=77 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</td>
								</tr>																
                            </table>
                        	</td>
                    	</tr>
                    	<tr>
	                        <td>
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 경력사항</td>
	                            </tr>
	                        </table>
	                        </td>
	                    </tr>
                    	<tr>
	                        <td class="PT03">
	                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
	                            class="s_table">
	                            <tr>
	                                <th width="200" style="text-align:center;">근무기간</th>
	                                <th width="50" style="text-align:center;" >소속회사</th>
	                                <th width="50" style="text-align:center;" >브랜드</th>
	                                <th width="40" style="text-align:center;" >직책</th>
	                                <th style="text-align:center;">소재지</th>
	                            </tr>
	                            <tr>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_S_DT1 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_S_DT1)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_WORK_E_DT1 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_E_DT1)" align="absmiddle" /></td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_COMP1 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_BRD1 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_JOB1 classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_LOCATION1 classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_S_DT2 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_S_DT2)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_WORK_E_DT2 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_E_DT2)" align="absmiddle" /></td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_COMP2 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_BRD2 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_JOB2 classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_LOCATION2 classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_S_DT3 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_S_DT3)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_WORK_E_DT3 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_E_DT3)" align="absmiddle" /></td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_COMP3 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_BRD3 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_JOB3 classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_LOCATION3 classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_S_DT4 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_S_DT4)" align="absmiddle" /> ~
										<comment id="_NSID_">
											<object id=EM_IO_WORK_E_DT4 classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
										</comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_IO_WORK_E_DT4)" align="absmiddle" /></td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_COMP4 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_BRD4 classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_JOB4 classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                                <td><comment id="_NSID_">
											<object id=EM_IO_WORK_LOCATION4 classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle"></object>
										</comment>
										<script>_ws_(_NSID_);</script>
	                                </td>
	                            </tr>	                            	                            	                            	                            
                            </table>
                        	</td>
                    	</tr>                    	
	                </table>	                
				</div>		
				<div id=tab_page3 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 교육사항</td>
									<td class="right PB02" valign="bottom"><img
										src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
										onclick="javascript:btn_Add1();" hspace="2" /><img
										src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
										onclick="javascript:btn_Del1();" /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
									<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
										width="100%">
										<tr>
											<td><comment id="_NSID_"><object id=GD_DETAIL1	width="100%" height=390 classid=<%=Util.CLSID_GRID%>>
												<param name="DataID" value="DS_IO_DETAIL1">
											</object></comment><script>_ws_(_NSID_);</script></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>									
					</table>
				</div>
				<div id=tab_page4 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 입점면접</td>
									<td class="right PB02" valign="bottom"><img
										src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
										onclick="javascript:btn_Add1();" hspace="2" /><img
										src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
										onclick="javascript:btn_Del1();" /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
									<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
										width="100%">
										<tr>
											<td><comment id="_NSID_"><object id=GD_DETAIL2	width="100%" height=390 classid=<%=Util.CLSID_GRID%>>
												<param name="DataID" value="DS_IO_DETAIL2">
											</object></comment><script>_ws_(_NSID_);</script></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>									
					</table>
				</div>
				<div id=tab_page5 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 근무평가</td>
									<td class="right PB02" valign="bottom"><img
										src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
										onclick="javascript:btn_Add1();" hspace="2" /><img
										src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
										onclick="javascript:btn_Del1();" /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
									<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
										width="100%">
										<tr>
											<td><comment id="_NSID_"><object id=GD_DETAIL3	width="100%" height=390 classid=<%=Util.CLSID_GRID%>>
												<param name="DataID" value="DS_IO_DETAIL3">
											</object></comment><script>_ws_(_NSID_);</script></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>									
					</table>
				</div>
				<div id=tab_page6 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="sub_title PB03 PT10"><img
										src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
										align="absmiddle" /> 퇴점평가</td>
									<td class="right PB02" valign="bottom"><img
										src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
										onclick="javascript:btn_Add1();" hspace="2" /><img
										src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
										onclick="javascript:btn_Del1();" /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
									<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
										width="100%">
										<tr>
											<td><comment id="_NSID_"><object id=GD_DETAIL4	width="100%" height=390 classid=<%=Util.CLSID_GRID%>>
												<param name="DataID" value="DS_IO_DETAIL4">
											</object></comment><script>_ws_(_NSID_);</script></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>									
					</table>
				</div>
				
				<div id=tab_page7 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
					
				</div>	
				-->																				
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
<object	id=BO_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
			<c>col=VENEMP_ID				                     		param=Text	</c>
			<c>col=KOR_NM				ctrl=EM_IO_KOR_NM				param=Text	</c>
			<c>col=STR_CD				ctrl=LC_IO_STR_CD				param=BindColVal	</c>
			<c>col=PUMBUN_CD			ctrl=EM_IO_PUMBUN_CD			param=Text	</c>
			<c>col=PUMBUN_NAME			ctrl=EM_IO_PUMBUN_NM			param=Text	</c>
			<c>col=JOB_CD				ctrl=LC_IO_JOB_CD				param=BindColVal	</c>
			<c>col=VEN_CD				ctrl=EM_IO_VEN_CD				param=Text	</c>
			<c>col=VEN_NAME				ctrl=EM_IO_VEN_NM				param=Text	</c>
			<c>col=INSTR_DT				ctrl=EM_IO_INSTR_DT				param=Text	</c>
			<c>col=SEX_CD				ctrl=RD_IO_SEX_CD				param=CodeValue	</c>
			<c>col=BIRTH_DT				ctrl=EM_IO_BIRTH_DT				param=Text	</c>
			<c>col=BIRTH_LUNAR_FLAG		ctrl=RD_IO_BIRTH_LUNAR_FLAG		param=CodeValue	</c>
			<c>col=HOME_ZIP_CD			ctrl=EM_IO_HOME_ZIP_CD			param=Text	</c>
			<c>col=HOME_ADDR1			ctrl=EM_IO_HOME_ADDR1			param=Text	</c>
			<c>col=HOME_ADDR2			ctrl=EM_IO_HOME_ADDR2			param=Text	</c>
			<c>col=HOME_NEW_YN			ctrl=EM_HOME_NEW_YN		    	param=Text	</c>
			<c>col=HOME_PH1				ctrl=EM_IO_HOME_PH1				param=Text	</c>
			<c>col=HOME_PH2				ctrl=EM_IO_HOME_PH2				param=Text	</c>
			<c>col=HOME_PH3				ctrl=EM_IO_HOME_PH3				param=Text	</c>
			<c>col=MOBILE_PH1			ctrl=EM_IO_MOBILE_PH1			param=Text	</c>
			<c>col=MOBILE_PH2			ctrl=EM_IO_MOBILE_PH2			param=Text	</c>
			<c>col=MOBILE_PH3			ctrl=EM_IO_MOBILE_PH3			param=Text	</c>
			<c>col=ORGN_ZIP_CD			ctrl=EM_IO_ORGN_ZIP_CD			param=Text	</c>
			<c>col=ORGN_ADDR1			ctrl=EM_IO_ORGN_ADDR1			param=Text	</c>
			<c>col=ORGN_ADDR2			ctrl=EM_IO_ORGN_ADDR2			param=Text	</c>
			<c>col=ORGN_NEW_YN			ctrl=EM_ORGN_NEW_YN  			param=Text	</c>
			<c>col=EMAIL1				ctrl=EM_IO_EMAIL1				param=Text	</c>
			<c>col=EMAIL2				ctrl=EM_IO_EMAIL2				param=Text	</c>
			<c>col=DOMAIN_FLAG			ctrl=LC_IO_DOMAIN_FLAG			param=BindColVal	</c>
			<c>col=TEMP_PASS_NO			ctrl=EM_IO_TEMP_PASS_NO			param=Text	</c>
			<c>col=TEMP_PASS_RET_DT		ctrl=EM_IO_TEMP_PASS_RET_DT		param=Text	</c>
			<c>col=TEMP_PASS_ISSUE_DT	ctrl=EM_IO_TEMP_PASS_ISSUE_DT	param=Text	</c>
			<c>col=EMP_ID_ISSUE_DT		ctrl=EM_IO_EMP_ID_ISSUE_DT		param=Text	</c>
			<c>col=OUTSTR_DT			ctrl=EM_IO_OUTSTR_DT			param=Text	</c>
			<c>col=MEMO					ctrl=EM_IO_MEMO					param=Text	</c>
			<c>col=WED_YN           	ctrl=LC_IO_WED_YN              	param=BindColVal	</c>			
			<c>col=M_RESI_NO			ctrl=EM_M_RESI_NO				param=Text	</c>
			<c>col=M_KOR_NM				ctrl=EM_M_KOR_NM				param=Text	</c>
			<c>col=M_CHI_NM				ctrl=EM_M_CHI_NM				param=Text	</c>
			<c>col=M_PUMBUN_CD          ctrl=EM_M_PUMBUN_CD             param=Text	</c>
			<c>col=M_PUMBUN_NAME		ctrl=EM_M_PUMBUN_NM				param=Text	</c>
			<c>col=M_VEN_CD             ctrl=EM_M_VEN_CD                param=Text	</c>
			<c>col=M_VEN_NAME			ctrl=EM_M_VEN_NM				param=Text	</c>
			<c>col=M_JOB_NM				ctrl=EM_M_JOB_NM				param=Text	</c>
			<c>col=M_BIRTH_DT			ctrl=EM_M_BIRTH_DT				param=Text	</c>
			<c>col=M_BIRTH_LUNAR_FLAG	ctrl=EM_M_BIRTH_LUNAR_FLAG		param=Text	</c>
			<c>col=M_HOME_ZIP_CD		ctrl=EM_M_HOME_ZIP_CD			param=Text	</c>
			<c>col=M_HOME_ADDR1			ctrl=EM_M_HOME_ADDR1			param=Text	</c>
			<c>col=M_HOME_ADDR2			ctrl=EM_M_HOME_ADDR2			param=Text	</c>
			<c>col=M_HOME_PH1			ctrl=EM_M_HOME_PH1				param=Text	</c>
			<c>col=M_HOME_PH2			ctrl=EM_M_HOME_PH2				param=Text	</c>
			<c>col=M_HOME_PH3			ctrl=EM_M_HOME_PH3				param=Text	</c>
			<c>col=M_MOBILE_PH1			ctrl=EM_M_MOBILE_PH1			param=Text	</c>
			<c>col=M_MOBILE_PH2			ctrl=EM_M_MOBILE_PH2			param=Text	</c>
			<c>col=M_MOBILE_PH3			ctrl=EM_M_MOBILE_PH3			param=Text	</c>
			<c>col=M_DOMAIN_FLAG		ctrl=EM_M_DOMAIN_FLAG			param=Text	</c>
			<c>col=M_EMAIL1				ctrl=EM_M_EMAIL1				param=Text	</c>
			<c>col=M_EMAIL2				ctrl=EM_M_EMAIL2				param=Text	</c>
			<c>col=M_WED_YN          	ctrl=EM_M_WED_YN	            param=Text	</c>			
			<c>col=WORK_TYPE			ctrl=LC_IO_WORK_TYPE			param=BindColVal	</c>
			<c>col=TEMP_ENT_SUP_YN		ctrl=EM_IO_TEMP_ENT_SUP_YN		param=Text	</c>
			<c>col=TEMP_ENT_SUP_S_DT	ctrl=EM_IO_TEMP_ENT_SUP_S_DT	param=Text	</c>
			<c>col=TEMP_ENT_SUP_E_DT	ctrl=EM_IO_TEMP_ENT_SUP_E_DT	param=Text	</c>
			<c>col=BRD_FIX_AR_YN		ctrl=EM_IO_BRD_FIX_AR_YN		param=Text	</c>
			<c>col=BRD_FIX_AR_S_DT		ctrl=EM_IO_BRD_FIX_AR_S_DT		param=Text	</c>
			<c>col=BRD_FIX_AR_E_DT		ctrl=EM_IO_BRD_FIX_AR_E_DT		param=Text	</c>
			<c>col=LONG_ENT_SUP_YN		ctrl=EM_IO_LONG_ENT_SUP_YN		param=Text	</c>
			<c>col=LONG_ENT_SUP_S_DT	ctrl=EM_IO_LONG_ENT_SUP_S_DT	param=Text	</c>
			<c>col=LONG_ENT_SUP_E_DT	ctrl=EM_IO_LONG_ENT_SUP_E_DT	param=Text	</c>
			<c>col=LONG_WORK_YN			ctrl=EM_IO_LONG_WORK_YN			param=Text	</c>
			<c>col=LONG_WORK_S_DT		ctrl=EM_IO_LONG_WORK_S_DT		param=Text	</c>
			<c>col=LONG_WORK_E_DT		ctrl=EM_IO_LONG_WORK_E_DT		param=Text	</c>
			<c>col=HI_SCHL_GRDU_YM		ctrl=EM_IO_HI_SCHL_GRDU_YM		param=Text	</c>
			<c>col=HI_SCHL_NM			ctrl=EM_IO_HI_SCHL_NM			param=Text	</c>
			<c>col=HI_SCHL_LOCATION		ctrl=EM_IO_HI_SCHL_LOCATION		param=Text	</c>
			<c>col=HI_SCHL_GRUD_FLAG	ctrl=LC_IO_HI_SCHL_GRUD_FLAG	param=BindColVal	</c>
			<c>col=UNIVST_GRDU_YM		ctrl=EM_IO_UNIVST_GRDU_YM		param=Text	</c>
			<c>col=UNIVST_NM			ctrl=EM_IO_UNIVST_NM			param=Text	</c>
			<c>col=UNIVST_LOCATION		ctrl=EM_IO_UNIVST_LOCATION		param=Text	</c>
			<c>col=UNIVST_GRDU_FLAG		ctrl=LC_IO_UNIVST_GRDU_FLAG		param=BindColVal	</c>
			<c>col=GRDU_SCHL_GRDU_YM	ctrl=EM_IO_GRDU_SCHL_GRDU_YM	param=Text	</c>
			<c>col=GRDU_SCHL_NM			ctrl=EM_IO_GRDU_SCHL_NM			param=Text	</c>
			<c>col=GRDU_SCHL_LOCATION	ctrl=EM_IO_GRDU_SCHL_LOCATION	param=Text	</c>
			<c>col=GRDU_SCHL_GRDU_FLAG	ctrl=LC_IO_GRDU_SCHL_GRDU_FLAG  param=BindColVal	</c>
			<c>col=WORK_S_DT1			ctrl=EM_IO_WORK_S_DT1			param=Text	</c>
			<c>col=WORK_E_DT1			ctrl=EM_IO_WORK_E_DT1			param=Text	</c>
			<c>col=WORK_COMP1			ctrl=EM_IO_WORK_COMP1			param=Text	</c>
			<c>col=WORK_BRD1			ctrl=EM_IO_WORK_BRD1			param=Text	</c>
			<c>col=WORK_JOB1			ctrl=EM_IO_WORK_JOB1			param=Text	</c>
			<c>col=WORK_LOCATION1		ctrl=EM_IO_WORK_LOCATION1		param=Text	</c>
			<c>col=WORK_S_DT2			ctrl=EM_IO_WORK_S_DT2			param=Text	</c>
			<c>col=WORK_E_DT2			ctrl=EM_IO_WORK_E_DT2			param=Text	</c>
			<c>col=WORK_COMP2			ctrl=EM_IO_WORK_COMP2			param=Text	</c>
			<c>col=WORK_BRD2			ctrl=EM_IO_WORK_BRD2			param=Text	</c>
			<c>col=WORK_JOB2			ctrl=EM_IO_WORK_JOB2			param=Text	</c>
			<c>col=WORK_LOCATION2		ctrl=EM_IO_WORK_LOCATION2		param=Text	</c>
			<c>col=WORK_S_DT3			ctrl=EM_IO_WORK_S_DT3			param=Text	</c>
			<c>col=WORK_E_DT3			ctrl=EM_IO_WORK_E_DT3			param=Text	</c>
			<c>col=WORK_COMP3			ctrl=EM_IO_WORK_COMP3			param=Text	</c>
			<c>col=WORK_BRD3			ctrl=EM_IO_WORK_BRD3			param=Text	</c>
			<c>col=WORK_JOB3			ctrl=EM_IO_WORK_JOB3			param=Text	</c>
			<c>col=WORK_LOCATION3		ctrl=EM_IO_WORK_LOCATION3		param=Text	</c>
			<c>col=WORK_S_DT4			ctrl=EM_IO_WORK_S_DT4			param=Text	</c>
			<c>col=WORK_E_DT4			ctrl=EM_IO_WORK_E_DT4			param=Text	</c>
			<c>col=WORK_COMP4			ctrl=CHK_EDU1					param=checked	</c>
			<c>col=WORK_BRD4			ctrl=CHK_EDU2					param=checked	</c>
			<c>col=WORK_JOB4			ctrl=CHK_EDU3					param=checked	</c>	
			<c>col=WORK_LOCATION4		ctrl=CHK_EDU4					param=checked	</c>	
	'>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>