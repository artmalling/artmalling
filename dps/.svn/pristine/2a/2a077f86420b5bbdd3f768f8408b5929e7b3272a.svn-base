<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 협력사코드> 협력사관리
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod1210.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사정보 및 점별 협력사 정보, 협력사 담당자 정보를 관리한다.
 * 이    력 :
 *        2010.01.17 (정진영) 신규작성
 *        2010.02.10 (박종은) 수정  
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var check=0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit() {
	 
	// Input Data Set Header 초기화

	// Output Data Set Header 초기화
	DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
	DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
	DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');

	// MARIO OUTLET START
	//사업자번호 입력시 먼저 존재하는 사업자번호에 해당하는 사업자 정보 조회
	DS_O_COMP_INFO.setDataHeader('<gauce:dataset name="H_SEL_COMPINFO"/>');
	// MARIO OUTLET END
	
    //탭 초기화(품목)
    initTab("TAB_VEN");
	//그리드 초기화
	gridCreate1(); //마스터
	gridCreate2(); //점별 협력사 정보
	gridCreate3(); //입력사 담당자 정보

    setTabItemIndex('TAB_VEN',1);
	JUMIN.style.display = "none";
	// EMedit에 초기화
	//조회  
	initEmEdit(EM_VEN_CD,               "CODE^6^0",      NORMAL);      //협력사코드(조회)
	initEmEdit(EM_VEN_NAME,             "GEN^40",        NORMAL);      //협력사명(조회)
	initEmEdit(EM_REP_VEN_CD,           "CODE^6^0",      NORMAL);      //대표협력사코드(조회)
	initEmEdit(EM_REP_VEN_NAME,         "GEN^40",        READ);        //대표협력사명(조회)
	
	// MARIO OUTLET START
	//initEmEdit(EM_ACC_CD,               "CODE^10^#",     NORMAL);      //거래선(조회)
	//EM_ACC_CD.Alignment = 0;
	//initEmEdit(EM_ACC_NAME,             "GEN",           NORMAL);      //거래선명(조회)
    // MARIO OUTLET END
    //등록
	//시스템정보
	initEmEdit(EM_VEN_CD_I,             "GEN",           READ);        //협력사코드 
	initEmEdit(EM_VEN_NAME_I,           "GEN^40",        PK);          //협력사명
	initEmEdit(EM_VEN_SHORT_NAME_I,     "GEN^20",        PK);          //협력사약명
	// MARIO OUTLET START
	initEmEdit(EM_BUY_ACC_VEN_CD_I,     "CODE^10^0",     PK);          //재무거래선
	//EM_BUY_ACC_VEN_CD_I.Alignment = 0;
    //initEmEdit(EM_BUY_ACC_VEN_NAME_I,    "GEN",            NORMAL);      //매입거래선명
	//initEmEdit(EM_SALE_ACC_VEN_CD_I,    "CODE^10^#",     PK);          //매출거래선
	//EM_SALE_ACC_VEN_CD_I.Alignment = 0;
    //initEmEdit(EM_SALE_ACC_VEN_NAME_I,    "GEN",           NORMAL);      //매출거래선명
    // MARIO OUTLET END
    
	initEmEdit(EM_REP_VEN_CD_I,         "CODE^6^0",      NORMAL);      //대표협력사 코드
	EM_REP_VEN_CD_I.Format = "000000";
	EM_REP_VEN_CD_I.Alignment = 0;
	initEmEdit(EM_REP_VEN_NAME_I,       "GEN^40",        READ);        //대표협력사 명
	//initEmEdit(EM_OCOMP_TAX_ID_I,       "CODE^15^#",     NORMAL);      //타사 전자세금계산서ID
	initEmEdit(EM_BIZ_S_DT_I,           "YYYYMMDD",      PK);          //거래시작일 
	//EM_BIZ_S_DT_I.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
	initEmEdit(EM_BIZ_E_DT_I,           "YYYYMMDD",      PK);          //거래종료일
	//EM_BIZ_E_DT_I.text = "99991231";
	
	//사업자정보
	initEmEdit(EM_COMP_NO_I,            "NUMBER^10^0",   PK);          //사업자번호
	EM_COMP_NO_I.Format = "000-00-00000";
	EM_COMP_NO_I.Alignment = 0;
	initEmEdit(EM_CORP_NO_I,            "NUMBER^13^0",   NORMAL);          //법인번호
	EM_CORP_NO_I.Format = "000000-0000000";
	EM_CORP_NO_I.Alignment = 0;
	initEmEdit(EM_COMP_NAME_I,          "GEN^40",      PK);          //상호명
	initEmEdit(EM_REP_NAME_I,           "GEN^40",      PK);          //대표자명
	initEmEdit(EM_BIZ_STAT_I,           "GEN^40",      PK);          //업태 
	initEmEdit(EM_BIZ_CAT_I,            "GEN^40",      PK);          //종목
	initEmEdit(EM_POST_NO_I,            "GEN^5",  READ);        //우편번호
    //EM_POST_NO_I.Format = "000-000";
    EM_POST_NO_I.Alignment = 1;
	initEmEdit(EM_ADDR_I,               "GEN^80",      READ);        //주소
	initEmEdit(EM_DTL_ADDR_I,           "GEN^80",      NORMAL);          //상세주소
	initEmEdit(EM_PHONE1_NO_I,          "CODE^4^0",  PK);          //전화번호
	
	initEmEdit(EM_PHONE2_NO_I,          "CODE^4^0",  PK);          //전화번호
	
	initEmEdit(EM_PHONE3_NO_I,          "CODE^4^0",  PK);          //전화번호
	
	initEmEdit(EM_FAX1_NO_I,            "CODE^4^0",  NORMAL);          //FAX번호
	
	initEmEdit(EM_FAX2_NO_I,            "CODE^4^0",  NORMAL);          //FAX번호
	
	initEmEdit(EM_FAX3_NO_I,            "CODE^4^0",  NORMAL);          //FAX번호
	
	
	EM_PHONE1_NO_I.alignment    = 3; //1:가운데정렬, 2:오른쪽, 3:왼쪽
	EM_PHONE2_NO_I.alignment    = 3;
	EM_PHONE3_NO_I.alignment    = 3;
	EM_FAX1_NO_I.alignment      = 3;
	EM_FAX2_NO_I.alignment      = 3;
	EM_FAX3_NO_I.alignment      = 3;

	//점별 협력사 정보 
	initEmEdit(EM_BANK_ACC_NO_I,        "CODE^20^0", NORMAL);      //입금계좌
	//EM_BANK_ACC_NO_I.Format = "00000000000000000000";
	EM_BANK_ACC_NO_I.alignment      = 3;
	initEmEdit(EM_ACC_NO_OWN_I,         "GEN^40",      NORMAL);      //예금주
	initEmEdit(EM_BIZ_S_DT_I2,          "YYYYMMDD",    PK);          //거래시작일 
	//EM_BIZ_S_DT_I2.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
	initEmEdit(EM_BIZ_E_DT_I2,          "YYYYMMDD",    PK);          //거래종료일
	//EM_BIZ_E_DT_I2.text = "99991231";
	initEmEdit(EM_SBNS_CAL_RATE_I2 ,"NUMBER^2^2", NORMAL);               //판매장려금적용율
	EM_SBNS_CAL_RATE_I2.NumericRange = "0~+:0";
	initEmEdit(EM_ACC_VEN_CD_I,     "GEN^40",     PK);          //점 재무거래선
	
	//콤보 초기화
	//조회
	// MARIO OUTLET START
	initComboStyle(LC_COMP_FLAG, DS_COMP_FLAG, "CODE^0^30,NAME^0^150", 1, NORMAL);                  //사업자구분
	getEtcCode("DS_COMP_FLAG", "D", "P024", "Y");
	LC_COMP_FLAG.Index = 0;
	LC_COMP_FLAG.Focus();
	
	initEmEdit(LC_COMP_NO,            "NUMBER^10^0",   NORMAL);          //사업자번호
	LC_COMP_NO.Format = "000-00-00000";
	LC_COMP_NO.Alignment = 0;
    
	//initComboStyleSearch(LC_BUY_SALE_FLAG, DS_BUY_SALE_FLAG,"CODE^0^30,NAME^0^80", 1, NORMAL);     //매입매출구분(조회)
	//getEtcCode("DS_BUY_SALE_FLAG", "D", "P017", "Y");
	//LC_BUY_SALE_FLAG.Index = 0;
	//LC_BUY_SALE_FLAG.Focus();
	// MARIO OUTLET START

	initComboStyleSearch(LC_BIZ_TYPE, DS_BIZ_TYPE, "CODE^0^30,NAME^0^90",1, NORMAL);               //거래형태(조회)
	getEtcCode("DS_BIZ_TYPE", "D", "P003", "Y");
	LC_BIZ_TYPE.Index = 0;
	
	initComboStyleSearch(LC_USE_YN, DS_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);                  //사용유무(조회)
	getEtcCode("DS_USE_YN", "D", "D022", "Y");
	LC_USE_YN.Index = 1;
	
	//등록 
	//시스템정보
	initComboStyle(LC_BUY_SALE_FLAG_I, DS_BUY_SALE_FLAG_I, "CODE^0^30,NAME^0^80", 1, PK);          //매입매출구분
	getEtcCode("DS_BUY_SALE_FLAG_I", "D", "P017", "N");
	
	initComboStyle(LC_BIZ_TYPE_I, DS_BIZ_TYPE_I, "CODE^0^30,NAME^0^90", 1, PK);                    //거래형태
	getEtcCode("DS_BIZ_TYPE_I", "D", "P003", "N");
	
	initComboStyle(LC_BIZ_FLAG_I, DS_BIZ_FLAG_I, "CODE^0^30,NAME^0^150", 1, PK);                    //거래구분
	getEtcCode("DS_BIZ_FLAG_I", "D", "P001", "N");
	
	initComboStyle(LC_COMP_FLAG_I, DS_COMP_FLAG_I, "CODE^0^30,NAME^0^150", 1, PK);                  //사업자구분
	getEtcCode("DS_COMP_FLAG_I", "D", "P024", "N");
	
  //initComboStyle(LC_ETAX_ISSUE_FLAG_I, DS_ETAX_ISSUE_FLAG_I, "CODE^0^30,NAME^0^80", 1, PK);      //전자세금계산서발행구분 
  //getEtcCode("DS_ETAX_ISSUE_FLAG_I", "D", "P044", "N");
	
	//initComboStyle(LC_RVS_ISSUE_FLAG_I, DS_RVS_ISSUE_FLAG_I, "CODE^0^30,NAME^0^80", 1, PK);        //역발행구분
	//getEtcCode("DS_RVS_ISSUE_FLAG_I", "D", "P037", "N");
	
	initComboStyle(LC_EDI_YN_I, DS_EDI_YN_I, "CODE^0^30,NAME^0^80", 1, PK);                        //EDI사용여부
	getEtcCode("DS_EDI_YN_I", "D", "D022", "N");
	
	initComboStyle(LC_USE_YN_I, DS_USE_YN_I, "CODE^0^30,NAME^0^80", 1, PK);                        //사용여부
	getEtcCode("DS_USE_YN_I", "D", "D022", "N");

	// MARIO OUTLET START
    ////initComboStyle(LC_SAP_DEL_HOLD, DS_SAP_DEL_HOLD, "CODE^0^30,NAME^0^80", 1, READ);                        //SAP삭제보류구분
    ////getEtcCode("DS_SAP_DEL_HOLD", "D", "P087", "N");
    // MARIO OUTLET END
     
	//점별협력사정보
	initComboStyle(LC_STR_CD_I, DS_STR_CD_I, "CODE^0^30,NAME^0^140", 1, PK);                        //점
	//getStore("DS_STR_CD_I", "N", "", "N");
	getFlc("DS_STR_CD_I", "C", "", "N", "N");  
	
	initComboStyle(LC_PAY_CYC_I, DS_PAY_CYC_I, "CODE^0^30,NAME^0^80", 1, PK);                      //지불주기
	getEtcCode("DS_PAY_CYC_I", "D", "P052", "N");
	LC_PAY_CYC_I.Index = 0;
    
	initComboStyle(LC_PAY_DT_FLAG_I, DS_PAY_DT_FLAG_I, "CODE^0^30,NAME^0^120", 1, PK);              //지불일구분
	//getEtcCode("DS_PAY_DT_FLAG_I", "D", "P051", "N");
	getEtcCodeRefer("DS_PAY_DT_FLAG_I", "D", "P051", "N");
	DS_PAY_DT_FLAG_I.UseFilter = true;
	DS_PAY_DT_FLAG_I.Filter();
	    
	initComboStyle(LC_PAY_WAY_I, DS_PAY_WAY_I, "CODE^0^30,NAME^0^80", 1, PK);                      //지불방법
	getEtcCode("DS_PAY_WAY_I", "D", "P049", "N");
	//LC_PAY_WAY_I.Index = 0; 
	
    
    getEtcCode("DS_TAX_ITG_ISSUE_FLAG_I", "D", "P033", "N");                                       //통합발행구분

	initComboStyle(LC_PAY_HOLI_FLAG_I, DS_PAY_HOLI_FLAG_I, "CODE^0^30,NAME^0^80", 1, PK);          //지불시기구분 
	getEtcCode("DS_PAY_HOLI_FLAG_I", "D", "P050", "N");
	//LC_PAY_HOLI_FLAG_I.Index = 1;
	initComboStyle(LC_ROUND_FLAG_I, DS_ROUND_FLAG_I, "CODE^0^30,NAME^0^80", 1, PK);                //반올림구분
	getEtcCode("DS_ROUND_FLAG_I", "D", "P021", "N");
	
	initComboStyle(LC_POS_CAL_FLAG_I, DS_POS_CAL_FLAG_I, "CODE^0^30,NAME^0^80", 1, PK);            //POS정산구분
	getEtcCode("DS_POS_CAL_FLAG_I", "D", "P084", "N");
	
	initComboStyle(LC_BANK_CD_I, DS_BANK_CD_I, "CODE^0^30,NAME^0^80", 1, NORMAL);                  //은행코드
	getEtcCode("DS_BANK_CD_I", "D", "P041", "N");
	insComboFirstNullId(LC_BANK_CD_I,"");

    EM_BANK_ACC_NO_I.Enable = false;
    EM_ACC_NO_OWN_I.Enable  = false;
	          
	initComboStyle(LC_USE_YN_I2, DS_USE_YN_I2, "CODE^0^30,NAME^0^80", 1, PK);                      //사용여부
	getEtcCode("DS_USE_YN_I2", "D", "D022", "N");
	//LC_USE_YN_I2.Index = 0;
	getEtcCode("DS_VEN_TASK_FLAG", "D", "P075", "N"); //업무구분
	getEtcCode("DS_USE_YN_I3", "D", "D022", "N");

	initEmEdit(EM_VIEW_POS_CNT_I,          "NUMBER^7^0",  NORMAL);          //대면포스 대수
    initEmEdit(EM_VIEW_POS_DEPOSIT_I,      "NUMBER^9^0",  NORMAL);          //대면포스 보증금
    initEmEdit(EM_VIEW_POS_RENT_I,         "NUMBER^9^0",  NORMAL);          //대면포스 사용료

    initEmEdit(EM_FB_POS_CNT_I,            "NUMBER^7^0",  NORMAL);          //F&B 대수
    initEmEdit(EM_FB_POS_DEPOSIT_I,        "NUMBER^9^0",  NORMAL);          //F&B 보증금
    initEmEdit(EM_FB_POS_RENT_I,           "NUMBER^9^0",  NORMAL);          //F&B 사용료

    initEmEdit(EM_MINI_POS_CNT_I,          "NUMBER^7^0",  NORMAL);          //MINI 대수
    initEmEdit(EM_MINI_POS_DEPOSIT_I,      "NUMBER^9^0",  NORMAL);          //MINI 보증금
    initEmEdit(EM_MINI_POS_RENT_I,         "NUMBER^9^0",  NORMAL);          //MINI 사용료

    initEmEdit(EM_PDA_POS_CNT_I,           "NUMBER^7^0",  NORMAL);          //PDA 대수
    initEmEdit(EM_PDA_POS_DEPOSIT_I,       "NUMBER^9^0",  NORMAL);          //PDA 보증금
    initEmEdit(EM_PDA_POS_RENT_I,          "NUMBER^9^0",  NORMAL);          //PDA 사용료

    initEmEdit(EM_MON_POS_CNT_I,           "NUMBER^7^0",  NORMAL);          //PDA 대수
    initEmEdit(EM_MON_POS_DEPOSIT_I,       "NUMBER^9^0",  NORMAL);          //PDA 보증금
    initEmEdit(EM_MON_POS_RENT_I,          "NUMBER^9^0",  NORMAL);          //PDA 사용료
    
    initComboStyle(LC_ADMIN_EXP_USE_I, DS_ADMIN_EXP_USE_I, "CODE^0^30,NAME^0^80", 1, PK);   //일반관리비청구구분
    getEtcCode("DS_ADMIN_EXP_USE_I", "D", "P094", "N");
    insComboFirstNullId(LC_ADMIN_EXP_USE_I,"");
    
    initComboStyle(LC_CARD_FEE_I, DS_CARD_FEE_I, "CODE^0^30,NAME^0^80", 1, PK);   //카드수수료 부담
    getEtcCode("DS_CARD_FEE_I", "D", "P090", "N");
    insComboFirstNullId(LC_CARD_FEE_I,"");
    
    initComboStyle(LC_DZ_SLP_FLAG, DS_DZ_SLP_FLAG, "CODE^0^30,NAME^0^80", 1, PK);   //회계전표발행방법
    getEtcCode("DS_DZ_SLP_FLAG", "D", "P620", "N");
    insComboFirstNullId(LC_DZ_SLP_FLAG,"");
    
    
    initComboStyle(LC_COMBINE_ISSUE_FLAG_I, DS_COMBINE_ISSUE_FLAG, "CODE^0^30,NAME^0^80", 1, PK);   //통합발행구분
    getEtcCode("DS_COMBINE_ISSUE_FLAG", "D", "P033", "N");
    
    getEtcCodeRefer("DS_POS_RENT", "D", "P092", "N");         //pos사용료구분
    getEtcCodeRefer("DS_POS_DEPOSIT", "D", "P093", "N");      //pos보증금구분
    
    setObjectGD2(false); 
	registerUsingDataset("pcod121", "DS_IO_DETAIL2, DS_O_DETAIL, DS_IO_MASTER")
	newMaster = false;
	// MARIO OUTLET START
	////LC_SAP_DEL_HOLD.Enable   = false;
	// MARIO OUTLET END
	setObjectNew(false);
	setObject(false);
	setObjectGD2(false);
	EM_BIZ_S_DT_I.Enable           = false;
}

function gridCreate1() {
	var hdrProperies = '<FC>id={currow}         name="NO"                    width=30   align=center         </FC>'
			         + '<FC>id=VEN_CD           name="협력사코드"              width=100   align=center     Edit=none </FC>'
			         + '<FC>id=VEN_NAME         name="협력사명"                width=150   align=left     Edit=none </FC>'
			         + '<FC>id=VEN_SHORT_NAME   name="협력사약명"              width=70   align=center     show=false</FC>'
			         + '<FC>id=BUY_SALE_FLAG    name="매입매출구분"            width=70   align=center     EditStyle=Lookup   Data="DS_BUY_SALE_FLAG_I:CODE:NAME"  show=false</FC>'
			         + '<FC>id=BIZ_TYPE         name="거래형태"               width=70   align=center     EditStyle=Lookup   Data="DS_BIZ_TYPE_I:CODE:NAME"           show=false</FC>'
			         + '<FC>id=BIZ_FLAG         name="거래구분"               width=70   align=center     EditStyle=Lookup   Data="DS_BIZ_FLAG_I:CODE:NAME"           show=false</FC>'
			         // CENTRAL SQURE START
			         + '<FC>id=BUY_ACC_VEN_CD   name="재무거래선"              width=70   align=center     show=false</FC>'
			         //+ '<FC>id=SALE_ACC_VEN_CD  name="매출거래선"              width=70   align=center     show=false</FC>'
			         // CENTRAL SQURE END
			         + '<FC>id=REP_VEN_CD       name="대표협력사"              width=70   align=center     show=false</FC>'
			         + '<FC>id=REP_VEN_NAME     name="대표협력사명"            width=70   align=center     show=false</FC>'
			         + '<FC>id=COMP_FLAG        name="사업자구분"              width=70   align=center     EditStyle=Lookup   Data="DS_COMP_FLAG_I:CODE:NAME"         show=false</FC>'
			         //+ '<FC>id=ETAX_ISSUE_FLAG  name="전자세금계산서발행구분"    width=70   align=center     EditStyle=Lookup   Data="DS_ETAX_ISSUE_FLAG_I:CODE:NAME"   show=false</FC>'
			         //+ '<FC>id=RVS_ISSUE_FLAG   name="역발행구분"              width=70   align=center     EditStyle=Lookup   Data="DS_RVS_ISSUE_FLAG_I:CODE:NAME"    show=false</FC>'
			         //+ '<FC>id=OCOMP_TAX_ID     name="타사전자세금계산서ID"     width=70   align=center     show=false</FC>'
			         + '<FC>id=USE_YN           name="사용여부"               width=70   align=center     EditStyle=Lookup   Data="DS_USE_YN_I:CODE:NAME"                 show=false</FC>'
			         + '<FC>id=BIZ_S_DT         name="거래시작일"              width=70   align=center        show=false</FC>'
			         + '<FC>id=BIZ_E_DT         name="거래종료일"              width=70   align=center        show=false</FC>'
			         + '<FC>id=COMP_NO          name="사업자번호"              width=70   align=center        show=false</FC>'
			         + '<FC>id=CORP_NO          name="법인번호"               width=70   align=center     show=false        "</FC>'
			         + '<FC>id=COMP_NAME        name="상호명"                 width=70   align=center     show=false</FC>'
			         + '<FC>id=REP_NAME         name="대표자명"               width=70   align=center     show=false</FC>'
			         + '<FC>id=BIZ_STAT         name="업태"                   width=70   align=center         show=false</FC>'
			         + '<FC>id=BIZ_CAT          name="종목"                   width=70   align=center         show=false</FC>'
			         + '<FC>id=POST_NO          name="우편번호"               width=70   align=center     show=false</FC>'
			         + '<FC>id=ADDR             name="주소"                   width=70   align=center         show=false</FC>'
			         + '<FC>id=DTL_ADDR         name="상세주소"                width=70   align=center     show=false</FC>'
			         + '<FC>id=PHONE1_NO        name="전화번호1"               width=70   align=center     show=false</FC>'
			         + '<FC>id=PHONE2_NO        name="전화번호2"               width=70   align=center     show=false</FC>'
			         + '<FC>id=PHONE3_NO        name="전화번호3"               width=70   align=center     show=false</FC>'
			         + '<FC>id=FAX1_NO          name="FAX번호1"               width=70   align=center         show=false</FC>'
			         + '<FC>id=FAX2_NO          name="FAX번호2"               width=70   align=center         show=false</FC>'
			         + '<FC>id=FAX3_NO          name="FAX번호3"               width=70   align=center         show=false</FC>'
                     + '<FC>id=SAP_DEL_FLAG     name="SAP삭제보류구분"          width=70   align=center         show=false</FC>'
                     + '<FC>id=SAP_IF_DATE      name="SAP삭제보류구분 I/F"      width=70   align=center         show=false</FC>';

	initGridStyle(GD_MASTER, "common", hdrProperies, true);
}
function gridCreate2() {
	var hdrProperies = '<FC>id={currow}             name="NO"              width=30   align=center</FC>'
                     + '<FC>id=VEN_CD               name="협력사코드"        width=70   align=center   show=false </FC>'
                     + '<FC>id=VEN_NAME             name="협력사명"         width=90   align=left     Edit=none    show=false</FC>'
                     + '<FC>id=VEN_SHORT_NAME       name="협력사약명"        width=70   align=center     show=false</FC>'
                     + '<FC>id=BIZ_TYPE             name="거래형태"          width=70   align=center     show=false</FC>'
                     + '<FC>id=BIZ_FLAG             name="거래구분"          width=70   align=center     show=false</FC>'
                     + '<FC>id=STR_CD               name="*점"              width=120   align=left     EditStyle=Lookup   Data="DS_STR_CD_I:CODE:NAME"</FC>'
                     + '<FC>id=PAY_CYC              name="*지불주기"         width=70   align=left     EditStyle=Lookup   Data="DS_PAY_CYC_I:CODE:NAME"</FC>'
                   //+ '<FC>id=PAY_CNT              name="지불회차"         width=70   align=left     EditStyle=Lookup   Data="DS_PAY_CNT_I:CODE:NAME" show=false</FC>'
                     + '<FC>id=PAY_DT_FLAG          name="*지불일"         width=70   align=left     EditStyle=Lookup   Data="DS_PAY_DT_FLAG_I:CODE:NAME"</FC>'
                     + '<FC>id=PAY_WAY              name="*지불방법"         width=70   align=left     EditStyle=Lookup   Data="DS_PAY_WAY_I:CODE:NAME"</FC>'
                     + '<FC>id=TAX_ITG_ISSUE_FLAG   name="*통합발행구분"      width=90   align=left     EditStyle=Lookup   Data="DS_TAX_ITG_ISSUE_FLAG_I:CODE:NAME"</FC>'
                     + '<FC>id=PAY_HOLI_FLAG        name="*지불시기구분"     width=90   align=left     EditStyle=Lookup   Data="DS_PAY_HOLI_FLAG_I:CODE:NAME"</FC>'
                     + '<FC>id=ROUND_FLAG           name="*반올림구분"       width=80   align=left     EditStyle=Lookup   Data="DS_ROUND_FLAG_I:CODE:NAME"</FC>'
                     + '<FC>id=POS_CAL_FLAG         name="*POS정산구분"      width=110   align=left     EditStyle=Lookup   Data="DS_POS_CAL_FLAG_I:CODE:NAME"</FC>'
                     + '<FC>id=EDI_YN               name="EDI사용여부"      width=80   align=center     EditStyle=Lookup   Data="DS_EDI_YN_I:CODE:NAME"</FC>'
                     + '<FC>id=BANK_CD              name="은행코드"         width=70   align=left    EditStyle=Lookup   Data="DS_BANK_CD_I:CODE:NAME"</FC>'
                     + '<FC>id=BANK_ACC_NO          name="입금계좌"         width=70   align=left  </FC>'
                     + '<FC>id=ACC_NO_OWN           name="예금주"           width=70   align=left  </FC>'
                     + '<FC>id=SBNS_CAL_RATE        name="판매장려금적용율"  width=120   align=right edit=none</FC>'
                   //+ '<FC>id=CHRG_WAY             name="청구방법"         width=70   align=left     EditStyle=Lookup   Data="DS_CHRG_WAY_I:CODE:NAME" show=false</FC>'
                   //+ '<FC>id=CHRG_COND            name="청구조건"         width=70   align=left     EditStyle=Lookup   Data="DS_CHRG_COND_I:CODE:NAME" show=false</FC>'
                   //+ '<FC>id=CHRG_DT_FLAG         name="청구결재일"       width=70   align=left     EditStyle=Lookup   Data="DS_CHRG_DT_FLAG_I:CODE:NAME" show=false</FC>'
                     + '<FC>id=USE_YN               name="*사용여부"         width=70   align=center     EditStyle=Lookup   Data="DS_USE_YN_I2:CODE:NAME"</FC>'
                     + '<FC>id=BIZ_S_DT             name="*거래시작일"       width=80   align=center   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=BIZ_E_DT             name="*거래종료일"       width=80   align=center   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=MNTN_CHRG_FLAG       name="일반관리비청구구분"  width=70   align=center     show=false</FC>'
                     + '<FC>id=CARD_FEE_CHRG        name="카드수수료부담"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEQTY_1         name="대면포스대수"       width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_DEPOSIT_1        name="대면포스보증금"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEFEE_1         name="대면포스사용료"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEQTY_2         name="F&B포스대수"       width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_DEPOSIT_2        name="F&B포스보증금"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEFEE_2         name="F&B포스사용료"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEQTY_3         name="MINI포스대수"       width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_DEPOSIT_3        name="MINI포스보증금"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEFEE_3         name="MINI포스사용료"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEQTY_4         name="PDA포스대수"       width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_DEPOSIT_4        name="PDA포스보증금"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEFEE_4         name="PDA포스사용료"     width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEQTY_5         name="돈통대수"          width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_DEPOSIT_5        name="돈통보증금"        width=70   align=center     show=false</FC>'
                     + '<FC>id=POS_USEFEE_5         name="돈통사용료"        width=70   align=center     show=false</FC>'
                     ;

	initGridStyle(GD_DETAIL, "common", hdrProperies, false);
}

function gridCreate3() {
	var hdrProperies = '<FC>id={currow}         name="NO"               width=30   align=center </FC>'
                     + '<FC>id=VEN_CD           name="협력사코드"        width=70   align=center   show=false </FC>'
                     + '<FC>id=VEN_NAME         name="협력사명"          width=70   align=center   show=false  </FC>'
                     + '<FC>id=SEQ_NO           name="순번"             width=70   align=center   show=false </FC>'
                     + '<FC>id=VEN_TASK_FLAG    name="*업무구분"          width=70   align=left     edit="" EditStyle=Lookup   Data="DS_VEN_TASK_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=CHAR_NAME        name="*담당자명"          width=70   align=left  </FC>'
                     + '<G> name=전화번호'
                     + '<C>id=PHONE1_NO         name="지역"             width=70   align=center    EDIT="NUMERIC"    </C>'
                     + '<C>id=PHONE2_NO         name="앞자리"             width=70   align=center    EDIT="NUMERIC"    </C>'
                     + '<C>id=PHONE3_NO         name="뒷자리"             width=70   align=center    EDIT="NUMERIC"    </C>'
                     + '</G>'
                     + '<G> name=휴대전화'
                     + '<C>id=HP1_NO            name="통신사"           width=70   align=center    EDIT="NUMERIC"    </C>'
                     + '<C>id=HP2_NO            name="앞자리"             width=70   align=center    EDIT="NUMERIC"    </C>'
                     + '<C>id=HP3_NO            name="뒷자리"             width=70   align=center    EDIT="NUMERIC"    </C>'
                     + '</G>'
                     + '<C>id=EMAIL             name="이메일"             width=140   align=left    Edit=AlphaEtc   EditLimitText=40   </C>'
//                      + '<C>id=SMEDI_ID          name="스마일;EDI ID"      width=90   align=left    Edit=AlphaNum   EditLimitText=20   mask="XXXXXXXXXXXXXXXXXXXX"</C>'
                     + '<C>id=USE_YN            name="사용여부"           width=70   align=center EditStyle=Lookup   Data="DS_USE_YN_I3:CODE:NAME"</C>';

	initGridStyle(GD_DETAIL2, "common", hdrProperies, true);
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
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL2.IsUpdated || DS_O_DETAIL.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1059");
        if (ret != "1") {
        	return false;
        } 
    }
	DS_IO_MASTER.ClearData();
	DS_O_DETAIL.ClearData();
	DS_IO_DETAIL2.ClearData();
	
	searchMaster();
	if(DS_IO_MASTER.CountRow > 0){
		searchDetail();
	    searchDetail2();
	}
	setObject(false);
	setObjectGD2(false);
	GD_MASTER.Focus();
	newMaster = false;
	setTabItemIndex( "TAB_VEN", 1); 
}

/**
 * btn_New()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	setTabItemIndex( "TAB_VEN", 1); 
	setObjectNew(true);
	setObject(true);
	EM_VEN_NAME_I.focus();
	
	
	
	if(!newMaster){
        if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL2.IsUpdated || DS_O_DETAIL.IsUpdated)
            if( showMessage(QUESTION, YESNO, "USER-1050") != 1)
                return;
    }else{
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1)
            return;     
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
    }
	

    if (DS_IO_MASTER.CountRow == 0) {
        DS_IO_MASTER.ClearData();
        DS_IO_MASTER.Addrow();
        DS_O_DETAIL.ClearData();
        DS_IO_DETAIL2.ClearData();
        EM_BIZ_S_DT_I.Enable = true;
        EM_BIZ_E_DT_I.text = "99991231";
        //EM_BIZ_S_DT_I.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        LC_USE_YN_I.Index = 0;
        
        
        /* 자주쓰는 기본코드 세팅     */
        LC_BUY_SALE_FLAG_I.Index = 0;
    	LC_BIZ_TYPE_I.Index = 1;
    	LC_BIZ_FLAG_I.Index = 1;
    	LC_COMP_FLAG_I.Index = 0;
    	//LC_RVS_ISSUE_FLAG_I.Index = 1;
    	//LC_ETAX_ISSUE_FLAG_I.Index = 2;
    	

        if(LC_COMP_FLAG_I.BindColVal == "6"){
            BUBIN.style.display = "none";
            JUMIN.style.display = "";
        }
        else{
            BUBIN.style.display = "";
            JUMIN.style.display = "none";
        }
        setObject(true);
        setObjectGD2(true);
        newMaster = true;
        return;
    }
    
    
    
	DS_IO_MASTER.Addrow();
	DS_O_DETAIL.ClearData();
	DS_IO_DETAIL2.ClearData();
	EM_BIZ_S_DT_I.Enable = true;
	EM_BIZ_E_DT_I.text = "99991231";
    //EM_BIZ_S_DT_I.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
    EM_BIZ_S_DT_I.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
    LC_USE_YN_I.Index = 0;
    
    /* 자주쓰는 기본코드 세팅     */
    LC_BUY_SALE_FLAG_I.Index = 0;
	LC_BIZ_TYPE_I.Index = 1;
	LC_BIZ_FLAG_I.Index = 1;
	LC_COMP_FLAG_I.Index = 0;
  //LC_RVS_ISSUE_FLAG_I.Index = 1;
  //LC_ETAX_ISSUE_FLAG_I .Index = 2;
    
    
    if(LC_COMP_FLAG_I.BindColVal == "6"){
        BUBIN.style.display = "none";
        JUMIN.style.display = "";
    }
    else{
        BUBIN.style.display = "";
        JUMIN.style.display = "none";
    }
	setObject(true);
	setObjectGD2(true);
	newMaster = true;
	
	
	
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if (!DS_IO_DETAIL2.IsUpdated && !DS_O_DETAIL.IsUpdated	&& !DS_IO_MASTER.IsUpdated) {
		showMessage(INFORMATION, OK, "USER-1028");
		if(DS_IO_MASTER.CountRow > 0 ){
			setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "STR_CD");
		}
		else{
			// MARIO OUTLET START
			//LC_BUY_SALE_FLAG.Focus();
			LC_COMP_FLAG.Focus();
			// MARIO OUTLET END
		}
        return;
		
	}
	var srtVenName           = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NAME");
    var srtVenCd             = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
    var strSaveGbn           = DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition);
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation()) return;

	//변경또는 신규 내용을 저장하시겠습니까?
	if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
		return;

    var parameters   = "&strVenCd="          + encodeURIComponent(srtVenCd);
    
	TR_MAIN.Action = "/dps/pcod121.pc?goTo=save"+parameters;
	TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_O_DETAIL=DS_O_DETAIL,I:DS_IO_DETAIL2=DS_IO_DETAIL2)"; //조회는 O
	TR_MAIN.Post();

	setObject(false);
	setObjectGD2(false);
	newMaster = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
		btn_Search();
	    
	    if(strSaveGbn == "1"){
	        //DS_IO_MASTER.RowPosition = DS_IO_MASTER.NameValueRow("VEN_NAME",srtVenName);
	        var row = srtVenName != "" ? DS_IO_MASTER.NameValueRow("VEN_NAME",srtVenName):DS_IO_MASTER.NameValueRow("VEN_CD",srtVenCd);
	    }
	    else{
	        //DS_IO_MASTER.RowPosition = DS_IO_MASTER.NameValueRow("VEN_CD",srtVenCd);
	        var row = srtVenCd != "" ? DS_IO_MASTER.NameValueRow("VEN_CD",srtVenCd):DS_IO_MASTER.NameValueRow("VEN_NAME",srtVenName);
	    }
	    
	    row = row<1?1:row;
	    DS_IO_MASTER.RowPosition = row;
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {

}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
    var newMaster = false;
/**
 * searchMaster()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 :  협력사마스터 리스트 조회
 * return값 : void
 */
function searchMaster() {

	newMaster = false;
	DS_IO_MASTER.ClearData();

	// CENTRAL SQURE START
	var strCompFlag      = LC_COMP_FLAG.BindColVal;			//사업자구분
	var strCompNo	 	 = LC_COMP_NO.text;					//사업자번호
	//var strBuySaleFlag   = LC_BUY_SALE_FLAG.BindColVal;   //매입매출구분
	// CENTRAL SQURE END
	var strBizType       = LC_BIZ_TYPE.BindColVal;			//거래형태
	var strVenCd         = EM_VEN_CD.text;					//협력사
    var strVenName       = EM_VEN_NAME.text;				//협력사명
	var strRepVenCd      = EM_REP_VEN_CD.text;				//대표협력사
	// CENTRAL SQURE START
	//var strAccCd         = EM_ACC_CD.text;                //거래선코드
	//var strAccCd2        = EM_ACC_CD.text;                //거래선코드
	// CENTRAL SQURE END
	var strUseYN         = LC_USE_YN.BindColVal;			//사용여부

	var goTo         = "searchMaster";
	var action       = "O";
	
	// CENTRAL SQURE START
	//var parameters   = "&strBuySaleFlag="    + strBuySaleFlag 
	//                 + "&strBizType="        + strBizType 
	//                 + "&strVenCd="          + strVenCd 
	//                 + "&strRepVenCd="       + strRepVenCd 
	//                 + "&strAccCd="          + strAccCd 
	//                 + "&strAccCd2="         + strAccCd2 
	//                 + "&strUseYN="          + strUseYN
    //                 + "&strVenName="        + encodeURI(encodeURIComponent(strVenName)) ;
	// CENTRAL SQURE END                
	var parameters   = "&strCompFlag="       + encodeURIComponent(strCompFlag)
					 + "&strCompNo="		 + encodeURIComponent(strCompNo)
					 + "&strBizType="        + encodeURIComponent(strBizType) 
	                 + "&strVenCd="          + encodeURIComponent(strVenCd) 
	                 + "&strRepVenCd="       + encodeURIComponent(strRepVenCd)
	                 + "&strUseYN="          + encodeURIComponent(strUseYN)
                     + "&strVenName="        + encodeURIComponent(strVenName);
	TR_MAIN.Action   = "/dps/pcod121.pc?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_IO_MASTER=DS_IO_MASTER)"; 
	TR_MAIN.Post();

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    if(DS_IO_MASTER.CountRow > 0){
    	setObjectNew(true);
    	}
}

/**
 * setObject(flag)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-01-26
 * 개    요 :  전표마스터 내용 수정 가능여부 셋팅 (수정 가능시 Default 셋팅)
 * return값 : void
 */
function setObject(flag) {
	//EM_VEN_NAME_I.Enable        = flag;
	LC_BUY_SALE_FLAG_I.Enable   = flag;
	LC_BIZ_TYPE_I.Enable        = flag;
	LC_BIZ_FLAG_I.Enable        = flag;
	
	
	
	
// 	EM_COMP_NO_I.Enable         = flag;
	//EM_CORP_NO_I.Enable         = flag;
}
 
function setObjectGD2(flag) {
	LC_STR_CD_I.Enable           = flag;
	LC_PAY_CYC_I.Enable          = flag;
	LC_PAY_DT_FLAG_I.Enable      = flag;
	//LC_PAY_WAY_I.Enable          = flag;
	//LC_COMBINE_ISSUE_FLAG_I.Enable = flag;
	LC_POS_CAL_FLAG_I.Enable     = flag;
}

function setObjectNew(flag) {
	 EM_VEN_NAME_I.Enable           = flag;
	 EM_VEN_SHORT_NAME_I.Enable     = flag;
	 EM_REP_VEN_CD_I.Enable         = flag;
	 
	 EM_BIZ_E_DT_I.Enable           = flag;
	 LC_COMP_FLAG_I.Enable          = flag;
	 //LC_RVS_ISSUE_FLAG_I.Enable     = flag;
	 LC_USE_YN_I.Enable             = flag;
	 //LC_ETAX_ISSUE_FLAG_I.Enable    = flag;
	 //EM_OCOMP_TAX_ID_I.Enable       = flag;
	 
	 EM_CORP_NO_I.Enable            = flag;
	 EM_COMP_NAME_I.Enable          = flag;
	 EM_REP_NAME_I.Enable           = flag;
	 EM_BIZ_STAT_I.Enable           = flag;
	 EM_BIZ_CAT_I.Enable            = flag;
	 EM_DTL_ADDR_I.Enable           = flag;
	 EM_PHONE1_NO_I.Enable          = flag;
     EM_PHONE2_NO_I.Enable          = flag;
     EM_PHONE3_NO_I.Enable          = flag;
	 EM_FAX1_NO_I.Enable            = flag;
     EM_FAX2_NO_I.Enable            = flag;
     EM_FAX3_NO_I.Enable            = flag;
     
     EM_BUY_ACC_VEN_CD_I.Enable     = flag;//매입 거래선
     
     LC_PAY_WAY_I.Enable            = flag;
     LC_COMBINE_ISSUE_FLAG_I.Enable = flag;
     LC_PAY_HOLI_FLAG_I.Enable      = flag;
     LC_ROUND_FLAG_I.Enable         = flag;
     LC_BANK_CD_I.Enable            = flag;
     LC_USE_YN_I2.Enable            = flag;
     LC_EDI_YN_I.Enable             = flag;
     EM_BIZ_S_DT_I2.Enable          = flag;
     EM_BIZ_E_DT_I2.Enable          = flag;
     EM_SBNS_CAL_RATE_I2.Enable     = flag;
}


function setObjectEM(flag) { 
	EM_VIEW_POS_CNT_I.Enable       = flag;    
	EM_VIEW_POS_DEPOSIT_I.Enable   = flag;     
	EM_VIEW_POS_RENT_I.Enable      = flag;  
    
	EM_FB_POS_CNT_I.Enable         = flag;     
	EM_FB_POS_DEPOSIT_I.Enable     = flag;     
	EM_FB_POS_RENT_I.Enable        = flag;   
    
	EM_MINI_POS_CNT_I.Enable       = flag;     
	EM_MINI_POS_DEPOSIT_I.Enable   = flag;     
	EM_MINI_POS_RENT_I.Enable      = flag;  
    
	EM_PDA_POS_CNT_I.Enable        = flag; 
	EM_PDA_POS_DEPOSIT_I.Enable    = flag; 
	EM_PDA_POS_RENT_I.Enable       = flag; 
    
	EM_MON_POS_CNT_I.Enable        = flag; 
	EM_MON_POS_DEPOSIT_I.Enable    = flag; 
	EM_MON_POS_RENT_I.Enable       = flag; 
}

/**
 * chkGrid()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-01-26
 * 개    요 :  점별협력사, 협력사담당자 그리드 데이터 수정, 삽입 건수
 * return값 : void
 */
function chkGrid() {
	chk_grid1 = 0;
	chk_grid2 = 0;
	
	for ( var i = 1; i <= DS_O_DETAIL.CountRow; i++) {
		if (DS_O_DETAIL.RowStatus(i) != "0") { 
			chk_grid1 += 1;
		}
	}
	for ( var i = 1; i <= DS_IO_DETAIL2.CountRow; i++) {
		if (DS_IO_DETAIL2.RowStatus(i) != "0") { 
			chk_grid1 += 1;
		}
	}
}

/**
 * searchDetail()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 :  점별협력사 리스트 조회
 * return값 : void
 */
function searchDetail() {
	DS_O_DETAIL.ClearData();

	var strVenCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");

	var goTo           = "searchDetail";
	var action         = "O";
	var parameters     = "&strVenCd=" + encodeURIComponent(strVenCd);
	TR_DETAIL.Action   = "/dps/pcod121.pc?goTo=" + goTo + parameters;
	TR_DETAIL.KeyValue = "SERVLET(" + action + ":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	TR_DETAIL.Post();

    //스크롤바 위치 조정
    GD_DETAIL.SETVSCROLLING(0);
    GD_DETAIL.SETHSCROLLING(0);
	// 조회결과 Return
	//setPorcCount("SELECT", DS_O_DETAIL.CountRow);
}

/**
 * searchDetail2()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 :  협력사담당자 리스트 조회
 * return값 : void
 */
function searchDetail2() {
	DS_IO_DETAIL2.ClearData();

	var strVenCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");

	var goTo         = "searchDetail2";
	var action       = "O";
	var parameters   = "&strVenCd=" + encodeURIComponent(strVenCd);
	TR_DETAIL2.Action   = "/dps/pcod121.pc?goTo=" + goTo + parameters;
	TR_DETAIL2.KeyValue = "SERVLET(" + action + ":DS_IO_DETAIL2=DS_IO_DETAIL2)";  
	TR_DETAIL2.Post();

    //스크롤바 위치 조정
    GD_DETAIL2.SETVSCROLLING(0);
    GD_DETAIL2.SETHSCROLLING(0);
	// 조회결과 Return
	//setPorcCount("SELECT", DS_IO_DETAIL2.CountRow);
}

/**
 * btn_Add1()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개     요 : 점별협력사 그리드 Row추가 
 * return값 : void
 */
function btn_Add1() {
	if (DS_IO_MASTER.RowPosition > 0) {
		var strVEN_CD         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD");
        var strVEN_NAME       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_NAME");
        var strVEN_SHORT_NAME = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_SHORT_NAME");
        var strBIZ_TYPE       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_TYPE");
        var strBIZ_FLAG       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_FLAG");
        
		DS_O_DETAIL.Addrow();
		DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "VEN_CD")         = strVEN_CD;
		DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "VEN_NAME")       = strVEN_NAME;
		DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "VEN_SHORT_NAME") = strVEN_SHORT_NAME;
		DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "BIZ_TYPE")       = strBIZ_TYPE;
		DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "BIZ_FLAG")       = strBIZ_FLAG;
		setObjectGD2(true);
		if(strBIZ_TYPE == "5"){
			DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "POS_CAL_FLAG")       = "3";
			LC_POS_CAL_FLAG_I.Enable = false;
		}
		else{
			LC_POS_CAL_FLAG_I.Enable = true;
		}
		if( strBIZ_TYPE=="1"){
			EM_SBNS_CAL_RATE_I2.Enable = true;
        }
        else{
        	EM_SBNS_CAL_RATE_I2.Enable = false;
        }
		
		LC_STR_CD_I.focus();
		EM_BIZ_E_DT_I2.text = "99991231";
	    //EM_BIZ_S_DT_I2.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
	    EM_BIZ_S_DT_I2.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
	    LC_USE_YN_I2.Index = 0;
	    
	    //if(strBIZ_TYPE == "2"){
	    	LC_PAY_CYC_I.BindColVal            =  "1";  //지불주기 1주기
	    	LC_PAY_DT_FLAG_I.BindColVal        =  "02"; //지불일 익월10일후
	    	LC_PAY_WAY_I.BindColVal            =  "01"; //지불방법 현금
	    	LC_COMBINE_ISSUE_FLAG_I.BindColVal =  "1";  //통합발행구분 통합발행
	    	LC_PAY_HOLI_FLAG_I.BindColVal      =  "2";  //지불시기구분 휴일후지불
	    	LC_ROUND_FLAG_I.BindColVal         =  "2";  //반올림구분 원미만버림
	    	LC_POS_CAL_FLAG_I.BindColVal       =  "1";  //포스정산구분 백화저포스
	    	LC_ADMIN_EXP_USE_I.BindColVal      =  "3";  //일반관리비청구구분 제외
	    	LC_CARD_FEE_I.BindColVal           =  "1";  //카드수수료부담 당사
	    	LC_STR_CD_I.BindColVal             =  "01";  //지불주기 1주기
	    	LC_DZ_SLP_FLAG.BindColVal          =  "2";	//전표발행구분
	    	LC_EDI_YN_I.BindColVal			   =  "Y";
	    //}
	}
}

/**
 * btn_Del1()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개     요 : 점별협력사 그리드 Row 삭제 
 * return값 : void
 */
function btn_Del1() {
	if (DS_IO_MASTER.RowPosition > 0) {
		var row = DS_O_DETAIL.RowPosition;
		if (DS_O_DETAIL.RowStatus(row) == "1") //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
		{
			DS_O_DETAIL.DeleteRow(row);
		} else {
			showMessage(INFORMATION, OK, "USER-1052");
		}
		
		row = DS_O_DETAIL.RowPosition;
		if (DS_O_DETAIL.RowStatus(row) == "0") //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
		{
			setObjectGD2(false);
		} else {
			setObjectGD2(true);
		}
	}
}

/**
 * btn_Add2()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개     요 : 협력사담당자 그리드 Row추가 
 * return값 : void
 */
function btn_Add2() {
	if (DS_IO_MASTER.RowPosition > 0) {
		var strVEN_CD = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
        var strVEN_NAME = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NAME");

		DS_IO_DETAIL2.Addrow();
		DS_IO_DETAIL2.NameValue(DS_IO_DETAIL2.RowPosition, "VEN_CD") = strVEN_CD;
        DS_IO_DETAIL2.NameValue(DS_IO_DETAIL2.RowPosition, "VEN_NAME") = strVEN_NAME;
		setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, DS_IO_DETAIL2.RowPosition, "VEN_TASK_FLAG");
		DS_IO_DETAIL2.NameValue(DS_IO_DETAIL2.RowPosition, "USE_YN") = "Y";
	}
}

/**
 * btn_Del2()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 : 협력사담당자 그리드 Row 삭제 
 * return값 : void
 */
function btn_Del2() {
	if (DS_IO_MASTER.RowPosition > 0) {
		var row = DS_IO_DETAIL2.RowPosition;
		if (DS_IO_DETAIL2.RowStatus(row) == "1") {
			DS_IO_DETAIL2.DeleteRow(row);
		}
		else{
			showMessage(INFORMATION, OK, "USER-1052");
		}
	}
}


function chkValidation(){

    //1. validation Master 그리드 필수 입력 체크 

    //협력사명
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NAME") == "") {
    	setTabItemIndex( "TAB_VEN", 1); 
        showMessage(EXCLAMATION, OK, "USER-1003", "협력사명");
        EM_VEN_NAME_I.focus();
        return false;
    }
    
    var colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("VEN_NAME"));
    var colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_NAME");
    var colName = "협력사명";
    var result  = checkByteLengthStr(colVal,colSize,"N");
    if( result){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_VEN_NAME_I.text = result;
        EM_VEN_NAME_I.focus();
        return false;
    }
           
    //협력사약명
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_SHORT_NAME") == "") {
    	setTabItemIndex( "TAB_VEN", 1); 
        showMessage(EXCLAMATION, OK, "USER-1003", "협력사약명");
        EM_VEN_SHORT_NAME_I.focus();
        return false;
    }

    colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("VEN_SHORT_NAME"));
    colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_SHORT_NAME");
    colName = "협력사약명";
    result  = checkByteLengthStr(colVal,colSize,"N");
    if( result){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_VEN_SHORT_NAME_I.text = result;
        EM_VEN_SHORT_NAME_I.focus();
        return false;
    }
    

    //매입매출구분
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_SALE_FLAG") == "") {
    	setTabItemIndex( "TAB_VEN", 1); 
        showMessage(EXCLAMATION, OK, "USER-1003", "매입매출구분");
        LC_BUY_SALE_FLAG_I.focus();
        return false;
    }
    
    /* if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_ACC_VEN_CD") == "") {
    	setTabItemIndex( "TAB_VEN", 1); 
        showMessage(EXCLAMATION, OK, "USER-1003", "매입거래선코드");
        EM_BUY_ACC_VEN_CD_I.focus();
        return false;
    } */
    // MARIO OUTLET START
    /* if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_SALE_FLAG") == "1") {
        //매입거래선
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_ACC_VEN_CD") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "매입거래처이므로 매입거래선");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_BUY_ACC_VEN_CD_I.focus();
            return false;
        }
    } else {
        //매출거래선
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_ACC_VEN_CD") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "매출거래처이므로 매출거래선");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_SALE_ACC_VEN_CD_I.focus();
            return false;
        }
    } */
    // MARIO OUTLET END
    //거래형태
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "거래형태");
        setTabItemIndex( "TAB_VEN", 1); 
        LC_BIZ_TYPE_I.focus(); 
        return false;
    }
    //거래구분 LC_BIZ_FLAG_I
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_FLAG") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "거래구분");
        setTabItemIndex( "TAB_VEN", 1); 
        LC_BIZ_FLAG_I.focus();
        return false;
    }
    
    //거래구분이 직매입이면 거래형태 직매입이어야 한다.
    if(LC_BIZ_FLAG_I.BindColVal == "10" ){
    	if(LC_BIZ_TYPE_I.BindColVal != "1" ){
    		showMessage(Information, OK, "USER-1000", "거래구분이 직매입입니다. 거래형태를 확인하십시오.");
            setTabItemIndex( "TAB_VEN", 1); 
            LC_BIZ_TYPE_I.focus();
            return false;
        }
    }
    
    //거래구분이 특정매입이면 거래형태 특정매입이어야 한다.
    if(LC_BIZ_FLAG_I.BindColVal == "20" ){
        if(LC_BIZ_TYPE_I.BindColVal != "2" ){
            showMessage(Information, OK, "USER-1000", "거래구분이 특정매입입니다. 거래형태를 확인하십시오.");
            setTabItemIndex( "TAB_VEN", 1); 
            LC_BIZ_TYPE_I.focus();
            return false;
        }
    }
    //거래구분이 임대을이면 거래형태 임대을이어야 한다.
    if(LC_BIZ_FLAG_I.BindColVal == "30" ){
        if(LC_BIZ_TYPE_I.BindColVal != "3" ){
            showMessage(Information, OK, "USER-1000", "거래구분이 임대을입니다. 거래형태를 확인하십시오.");
            setTabItemIndex( "TAB_VEN", 1); 
            LC_BIZ_TYPE_I.focus();
            return false;
        }
    }
    
    //거래구분이 임대갑이면 거래형태 임대갑이어야 한다.
    if(LC_BIZ_FLAG_I.BindColVal == "40" ){
        if(LC_BIZ_TYPE_I.BindColVal != "4" ){
            showMessage(Information, OK, "USER-1000", "거래구분이 임대갑입니다. 거래형태를 확인하십시오.");
            setTabItemIndex( "TAB_VEN", 1); 
            LC_BIZ_TYPE_I.focus();
            return false;
        }
    }

    //거래구분이 임대을B이면 거래형태 임대을B이어야 한다.
    if(LC_BIZ_FLAG_I.BindColVal == "50" ){
        if(LC_BIZ_TYPE_I.BindColVal != "5" ){
            showMessage(Information, OK, "USER-1000", "거래구분이 임대을B입니다. 거래형태를 확인하십시오.");
            setTabItemIndex( "TAB_VEN", 1); 
            LC_BIZ_TYPE_I.focus();
            return false;
        }
    }
    //사업자구분
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_FLAG") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "사업자구분");
        setTabItemIndex( "TAB_VEN", 1); 
        LC_COMP_FLAG_I.focus(); 
        return false;
    }
    //전자세금계산서발행구분
    /* if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ETAX_ISSUE_FLAG") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "전자세금계산서발행구분");
        setTabItemIndex( "TAB_VEN", 1); 
        LC_ETAX_ISSUE_FLAG_I.focus();
        return false;
    } */
    
    //역발행구분
    /* if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "RVS_ISSUE_FLAG") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "역발행구분");
        setTabItemIndex( "TAB_VEN", 1); 
        LC_RVS_ISSUE_FLAG_I.focus(); 
        return false;
    } */
    
    //사용여부
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "USE_YN") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "사용여부");
        setTabItemIndex( "TAB_VEN", 1); 
        LC_USE_YN_I.focus(); 
        return false;
    }
    
    // MARIO OUTLET START
    //SAP삭제보류구분
    /*
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SAP_DEL_FLAG") == "1") {
    	if(newMaster == true){
            showMessage(EXCLAMATION, OK, "USER-1000", "SAP삭제보류구분이 삭제 보류입니다. 등록할 수 없습니다.");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_VEN_SHORT_NAME_I.focus(); 
            return false;
    	}
    	else{
    		showMessage(EXCLAMATION, OK, "USER-1000", "SAP삭제보류구분이 삭제 보류입니다.");
    	}
    }
    */
    // MARIO OUTLET END
    
    //거래시작일
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_S_DT") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "거래시작일");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_BIZ_S_DT_I.focus();
        return false;
    }
    //거래종료일
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_E_DT") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "거래종료일");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_BIZ_E_DT_I.focus();
        return false;
    }
    //거래시작일 종료일 비교
    if (isBetweenFromTo(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_S_DT"), 
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_E_DT")) == "false") {
        showMessage(Information, OK, "USER-1015");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_BIZ_S_DT_I.focus();
        return false;
    }

    if(LC_COMP_FLAG_I.BindColVal != "6"){
    	
    	
    	//사업자번호
    	/*
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_NO") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "사업자번호");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_COMP_NO_I.focus();
            return false;
        }
    	*/
    	
    	/* 20170223
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_NO").length != 10 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_NO") != "") {
            showMessage(Information, OK, "USER-1027","사업자번호","10");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_COMP_NO_I.focus();
            return false;
        }
    	
    	
        //상호명
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_NAME") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "상호명");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_COMP_NAME_I.focus();
            return false;
        }

        //대표자명
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REP_NAME") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "대표자명");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_REP_NAME_I.focus();
            return false;
        }
        
        //업태
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_STAT") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "업태");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_BIZ_STAT_I.focus();
            return false;
        }
        //종목
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_CAT") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "종목");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_BIZ_CAT_I.focus();
            return false;
        }
        */

        
        /*
        //주소 -우편번호
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "POST_NO") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "우편번호");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_DTL_ADDR_I.focus();
            return false;
        }
        //주소 
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ADDR") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "주소");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_DTL_ADDR_I.focus();
            return false;
        }

        //전화번호 -지역
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PHONE1_NO") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "지역번호");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_PHONE1_NO_I.focus();
            return false;
        }
        //전화번호 - 국 
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PHONE2_NO") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "국번");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_PHONE2_NO_I.focus();
            return false;
        }
        //전화번호 - 번호
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PHONE3_NO") == "") {
            showMessage(EXCLAMATION, OK, "USER-1003", "전화번호");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_PHONE3_NO_I.focus();
            return false;
        }
        */
        
    }
    
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CORP_NO").length != 13 &&
    		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CORP_NO").length > 0) {
        showMessage(Information, OK, "USER-1027","법인번호","13");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_CORP_NO_I.focus();
        return false;
    }
    

    // 사업자번호 유효성체크
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_NO").length > 0){
        if (isSaupNO(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COMP_NO")) == false) {
            showMessage(Information, OK, "USER-1004", "사업자번호");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_COMP_NO_I.text = "";
            EM_COMP_NO_I.focus();
            return false;
        }
    }
    
    /*
    //법인번호    
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CORP_NO") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "법인번호");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_CORP_NO_I.focus();
        return false;
    }
    */
    
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CORP_NO").length != 13 &&
    		DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CORP_NO").length > 0) {
        showMessage(Information, OK, "USER-1027","법인번호","13");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_CORP_NO_I.focus();
        return false;
    }
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"COMP_NAME") != ""){
        colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("COMP_NAME"));
        colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"COMP_NAME");
        colName = "상호명";
        result  = checkByteLengthStr(colVal,colSize,"N");
        if( result){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
            EM_COMP_NAME_I.text = result;
            setTabItemIndex( "TAB_VEN", 1); 
            EM_COMP_NAME_I.focus();
            return false ;
        }
    }
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REP_NAME") != ""){
	    colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("REP_NAME"));
	    colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REP_NAME");
	    colName = "대표자명";
	    result  = checkByteLengthStr(colVal,colSize,"N");
	    if( result){
	        showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
	        setTabItemIndex( "TAB_VEN", 1); 
	        EM_REP_NAME_I.text = result;
	        EM_REP_NAME_I.focus();
	        return false ;
	    }
    }
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_STAT") != ""){
	    colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("BIZ_STAT"));
	    colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_STAT");
	    colName = "업태";
	    result  = checkByteLengthStr(colVal,colSize,"N");
	    if( result){
	        showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
	        setTabItemIndex( "TAB_VEN", 1); 
	        EM_BIZ_STAT_I.text = result;
	        EM_BIZ_STAT_I.focus();
	        return false ;
	    }
    }
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_CAT") != ""){
    	colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("BIZ_CAT"));
        colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_CAT");
        colName = "종목";
        result  = checkByteLengthStr(colVal,colSize,"N");
        if( result){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_BIZ_CAT_I.text = result;
            EM_BIZ_CAT_I.focus();
            return false ;
        }
    }
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"ADDR") != ""){
    	colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("ADDR"));
        colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"ADDR");
        colName = "주소";
        result  = checkByteLengthStr(colVal,colSize,"N");
        if( result){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_ADDR_I.text = result;
            EM_DTL_ADDR_I.focus();
            return false ;
        }
    }
    
/*
    //주소 - 상세주소
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DTL_ADDR") == "") {
        showMessage(EXCLAMATION, OK, "USER-1003", "상세주소");
        setTabItemIndex( "TAB_VEN", 1); 
        EM_DTL_ADDR_I.focus();
        return false;
    }*/
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DTL_ADDR") != ""){
    	colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("DTL_ADDR"));
        colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DTL_ADDR");
        colName = "상세주소";
        result  = checkByteLengthStr(colVal,colSize,"N");
        
        if( result){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
            setTabItemIndex( "TAB_VEN", 1); 
            EM_DTL_ADDR_I.text = result;
            EM_DTL_ADDR_I.focus();
            return false ;
        }
    }
    
	if(DS_O_DETAIL.IsUpdated){
	    //중복된 데이터 체크 
	    var retChk  = checkDupKey(DS_O_DETAIL, "STR_CD");
	    
	    if (retChk != 0) {
	        showMessage(Information, OK, "USER-1044",retChk);
	        setTabItemIndex( "TAB_VEN", 2); 
	        LC_STR_CD_I.focus();
	        return false;
	    }
	    //거래형태가 임대을이면 일반관리비청구구분, 카드수수료부담 필수
	    if(LC_BIZ_TYPE_I.BindColVal == "3" || LC_BIZ_TYPE_I.BindColVal == "5" || LC_BIZ_TYPE_I.BindColVal == "2"){
	        ADMINEXP_P.style.display = "";
	        if(LC_ADMIN_EXP_USE_I.BindColVal == ""){
	        	showMessage(EXCLAMATION, OK, "USER-1003", "일반관리비청구구분");
	        	setTabItemIndex( "TAB_VEN", 2); 
	        	LC_ADMIN_EXP_USE_I.focus();
                return false;
	        }
	        if(LC_CARD_FEE_I.BindColVal == ""){
                showMessage(EXCLAMATION, OK, "USER-1003", "카드수수료부담");
                setTabItemIndex( "TAB_VEN", 2); 
                LC_CARD_FEE_I.focus();
                return false;
            }
	    }

	    for ( var i = 1; i <= DS_O_DETAIL.CountRow; i++) {
	        //점
	        if (DS_O_DETAIL.NameValue(i, "STR_CD") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "점");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_STR_CD_I.focus();
	            return false;
	        }
	        //지불주기
	        if (DS_O_DETAIL.NameValue(i, "PAY_CYC") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "지불주기");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_PAY_CYC_I.focus();
	            return false;
	        }
	        //지불일
	        if (DS_O_DETAIL.NameValue(i, "PAY_DT_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "지불일");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_PAY_DT_FLAG_I.focus();
	            return false;
	        }
	        //지불방법    
	        if (DS_O_DETAIL.NameValue(i, "PAY_WAY") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "지불방법");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_PAY_WAY_I.focus();
	            return false;
	        }
	        //통합발행구분
	        if (DS_O_DETAIL.NameValue(i, "TAX_ITG_ISSUE_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "통합발행구분");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_COMBINE_ISSUE_FLAG_I.focus();
	            return false;
	        }
	        //지불시기구분
	        if (DS_O_DETAIL.NameValue(i, "PAY_HOLI_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "지불시기구분");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_PAY_HOLI_FLAG_I.focus();
	            return false;
	        }
	        //반올림구분
	        if (DS_O_DETAIL.NameValue(i, "ROUND_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "반올림구분");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_ROUND_FLAG_I.focus();
	            return false;
	        }
	        //POS정산구분
	            
	        if (DS_O_DETAIL.NameValue(i, "POS_CAL_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "POS정산구분");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_POS_CAL_FLAG_I.focus();
	            return false;
	        }
	        if (DS_O_DETAIL.NameValue(i, "DZ_SLP_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "회계전표발행방법.");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_POS_CAL_FLAG_I.focus();
	            return false;
	        }
	        //예금주
	        colSize = DS_O_DETAIL.ColumnSize(DS_O_DETAIL.ColumnIndex("ACC_NO_OWN"));
	        colVal  = DS_O_DETAIL.NameValue(i,"ACC_NO_OWN");
	        colName = "예금주";
	        result  = checkByteLengthStr(colVal,colSize,"N");
	        if( result){
	            showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
	            DS_O_DETAIL.NameValue(i,"ACC_NO_OWN") = result;
	            setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "ACC_NO_OWN");
	            return false ;
	        }
	        
	        //EDI사용여부
	        if (DS_O_DETAIL.NameValue(i, "EDI_YN") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "EDI사용여부");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_EDI_YN_I.focus();
	            return false;
	        }
	        
	        //사용여부
	        if (DS_O_DETAIL.NameValue(i, "USE_YN") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "사용여부");
	            setTabItemIndex( "TAB_VEN", 2); 
	            LC_USE_YN_I2.focus();
	            return false;
	        }
	        //거래시작일      
	        if (DS_O_DETAIL.NameValue(i, "BIZ_S_DT") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "거래시작일");
	            setTabItemIndex( "TAB_VEN", 2); 
	            EM_BIZ_S_DT_I2.focus();
	            return false;
	        }
	
	        //거래종료일
	        if (DS_O_DETAIL.NameValue(i, "BIZ_E_DT") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "거래종료일");
	            setTabItemIndex( "TAB_VEN", 2); 
	            EM_BIZ_E_DT_I2.focus();
	            return false;
	        }
	        //거래시작일 종료일 비교
	        if (isBetweenFromTo(DS_O_DETAIL.NameValue(i, "BIZ_S_DT"),
	        		DS_O_DETAIL.NameValue(i, "BIZ_E_DT")) == "false") {
	            showMessage(Information, OK, "USER-1215");
	            setTabItemIndex( "TAB_VEN", 2); 
	            EM_BIZ_S_DT_I2.focus();
	            return false;
	        }
	        
	    }
	}
	
	if(DS_IO_DETAIL2.IsUpdated){
	    for ( var i = 1; i <= DS_IO_DETAIL2.CountRow; i++) {
	        //업무구분
	        if (DS_IO_DETAIL2.NameValue(i, "VEN_TASK_FLAG") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "업무구분");
	            setTabItemIndex( "TAB_VEN", 3); 
	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "VEN_TASK_FLAG");
	            return false;
	        }
	        //담당자명
	        if (DS_IO_DETAIL2.NameValue(i, "CHAR_NAME") == "") {
	            showMessage(EXCLAMATION, OK, "USER-1003", "담당자명");
	            setTabItemIndex( "TAB_VEN", 3); 
	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "CHAR_NAME");
	            return false;
	        }
	        colSize = DS_IO_DETAIL2.ColumnSize(DS_IO_DETAIL2.ColumnIndex("CHAR_NAME"));
	        colVal  = DS_IO_DETAIL2.NameValue(i,"CHAR_NAME");
	        colName = "담당자명";
	        result  = checkByteLengthStr(colVal,colSize,"N");
	        if( result){
	            showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
	            DS_O_DETAIL.NameValue(i,"CHAR_NAME") = result;
	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "CHAR_NAME");
	            return false ;
	        }
	
// 	        //휴대전화
// 	        if (DS_IO_DETAIL2.NameValue(i, "HP1_NO") == "") {
// 	            showMessage(EXCLAMATION, OK, "USER-1003", "통신사");
// 	            setTabItemIndex( "TAB_VEN", 3); 
// 	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "HP1_NO");
// 	            return false;
// 	        }
// 	        //휴대전화
// 	        if (DS_IO_DETAIL2.NameValue(i, "HP2_NO") == "") {
// 	            showMessage(EXCLAMATION, OK, "USER-1003", "국번");
// 	            setTabItemIndex( "TAB_VEN", 3); 
// 	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "HP2_NO");
// 	            return false;
// 	        }
// 	        //휴대전화
// 	        if (DS_IO_DETAIL2.NameValue(i, "HP3_NO") == "") {
// 	            showMessage(EXCLAMATION, OK, "USER-1003", "번호");
// 	            setTabItemIndex( "TAB_VEN", 3); 
// 	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "HP3_NO");
// 	            return false;
// 	        }
// 	        //이메일
// 	        if (DS_IO_DETAIL2.NameValue(i, "EMAIL") == "") {
// 	            showMessage(EXCLAMATION, OK, "USER-1003", "이메일");
// 	            setTabItemIndex( "TAB_VEN", 3); 
// 	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "EMAIL");
// 	            return false;
// 	        }
// 	        if(!isValidStrEmail(DS_IO_DETAIL2.NameValue(i, "EMAIL"))){
// 	            showMessage(EXCLAMATION, OK, "USER-1004", "이메일");
// 	            setTabItemIndex( "TAB_VEN", 3); 
//                 setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "EMAIL");
//                 return false;
// 	        } 
	        //협력사의 전자세금계산서발행구분이 1:스마일EDI 이고 협력사담당자의 업무구분이 정산담당자
	        //일 경우 스마일EDI ID 필수 입력 
	        /*if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ETAX_ISSUE_FLAG") == "1" &&
	        		DS_IO_DETAIL2.NameValue(i, "VEN_TASK_FLAG") == "2" &&
	        		DS_IO_DETAIL2.NameValue(i, "SMEDI_ID") == "" ) {
	            showMessage(EXCLAMATION, OK, "USER-1003", "스마일EDI ID");
	            setTabItemIndex( "TAB_VEN", 3); 
	            setFocusGrid(GD_DETAIL2, DS_IO_DETAIL2, i, "SMEDI_ID");
	            return false;
	        }
	        */
	    }
	}

    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        return false;
    }
    return true;
}

/**
 * clickStrVen()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : 점별협력사 탭  클릭시 실행
 * return값 : void
**/
function clickStrVen(){


	var vMasterRowStatus = DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition);
	/*
	if(vMasterRowStatus == "1") {
		showMessage(INFORMATION, OK, "신규입력 중 이동 할 수 없습니다.", "이동");
		return false;
	}
	*/
	if(DS_IO_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1075", "이동");
        // MARIO OUTLET START
        //LC_BUY_SALE_FLAG.Focus();
        // MARIO OUTLET END
        LC_COMP_FLAG.Focus();
        return false;
    }
	
    if( DS_IO_MASTER.IsUpdated){
        
        if(showMessage(QUESTION, YESNO, "USER-1074")!=1){
        	setTabItemIndex('TAB_VEN',1);
        	EM_VEN_NAME_I.Focus();
            return false;
        }
        DS_IO_MASTER.UndoAll();
        // MARIO OUTLET START
        DS_O_DETAIL.UndoAll();
        // MARIO OUTLET END
        LC_PAY_WAY_I.Focus();
    }
    if(LC_BIZ_TYPE_I.BindColVal == "1"){
    	 enableControl(EM_SBNS_CAL_RATE_I2, true);
    }else{
    	 enableControl(EM_SBNS_CAL_RATE_I2, false);
    }
    
    if(vMasterRowStatus == "1") {
    	searchDetail()
	}
 }

/**
 * clickVenUser()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : 협력사담당자 탭  클릭시 실행
 * return값 : void
**/
function clickVenUser(){


	var vMasterRowStatus = DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition);
	/*
	if(vMasterRowStatus == "1") {
		showMessage(INFORMATION, OK, "신규입력 중 이동 할 수 없습니다.", "이동");
		return false;
	}
	*/
	if(DS_IO_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1075", "이동");
        // MARIO OUTLET START
        //LC_BUY_SALE_FLAG.Focus();
        // MARIO OUTLET END
        LC_COMP_FLAG.Focus();
        return false;
    }
	
    if( DS_IO_MASTER.IsUpdated){
        
        if(showMessage(QUESTION, YESNO, "USER-1074")!=1){
            setTabItemIndex('TAB_VEN',1);
            EM_VEN_NAME_I.Focus();
            return false;
        }
        DS_IO_MASTER.UndoAll();
        // MARIO OUTLET START
        DS_O_DETAIL.UndoAll();
        // MARIO OUTLET END
        setFocusGrid( GD_DETAIL2, DS_IO_DETAIL2, DS_IO_DETAIL2.RowPosition, "VEN_TASK_FLAG");
        EM_VEN_NAME_I.Focus();
        return true;
    }
    
    if(vMasterRowStatus == "1") {
    	searchDetail2()
	}
    
 }


/**
 * clickVen()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : 협력사 탭  클릭시 실행
 * return값 : void
**/
function clickVen(){
	 
	 // MARIO OUTLET START
	 setObject(false);
     setObjectGD2(false);
     newMaster = false;
     EM_BIZ_S_DT_I.Enable =  false;
     // MARIO OUTLET END
     
    if(DS_O_DETAIL.IsUpdated){
        if(showMessage(QUESTION, YESNO, "USER-1074")!=1){
            setTabItemIndex('TAB_VEN',2);
            LC_PAY_WAY_I.Focus();
            return false;
        }
        DS_O_DETAIL.UndoAll();
        EM_VEN_NAME_I.Focus();
        return true;
        
        
    }
    
    if( DS_IO_DETAIL2.IsUpdated){
        
        if(showMessage(QUESTION, YESNO, "USER-1074")!=1){
            setTabItemIndex('TAB_VEN',3);
            setFocusGrid( GD_DETAIL2, DS_IO_DETAIL2, DS_IO_DETAIL2.RowPosition, "VEN_TASK_FLAG");
            return false;
        }
        DS_IO_DETAIL2.UndoAll();
        EM_VEN_NAME_I.Focus();
        return true;
    }
}


/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_ven_emg(){

        var srtVenCd             = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
		//var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
		var strProcDt       = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));

        if( srtVenCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","협력업체가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&srtVenCd="  + encodeURIComponent(srtVenCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod121.pc?goTo=sendvenemg"+parameters;
	        TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    	TR_MAIN.Post();        
	    }
}

// MARIO OUTLET START
/**
 * searchComp()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : 협력사 탭  클릭시 실행
 * return값 : void
**/
function searchComp(vCompNo){
	 
	 DS_O_COMP_INFO.ClearData();

	var strCompNo = vCompNo;

	var goTo         = "searchCompinfo";
	var action       = "O";
	var parameters   = "&strCompNo=" + encodeURIComponent(strCompNo);
	TR_SEARCH.Action   = "/dps/pcod121.pc?goTo=" + goTo + parameters;
	TR_SEARCH.KeyValue = "SERVLET(" + action + ":DS_O_COMP_INFO=DS_O_COMP_INFO)";  
	TR_SEARCH.Post();	
}
// MARIO OUTLET END
//-->

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
<!--  ===================SEARCH CONDITION AREA================= -->

<!--  ===================DS_MASTER============================ -->
<!-- Grid DS_MASTER 변경시 DS_DETAIL의 마스터 내용 변경 -->
<script language=JavaScript for=DS_IO_MASTER
	event=OnColumnChanged(row,colid)>
    
</script>
<!--  ===================DS_MASTER============================ -->

<!--  ===================GD_MASTER============================ -->

<script language=JavaScript for=DS_PAY_DT_FLAG_I event=OnFilter(row)>
    var value = this.NameValue(row,"REFER_CODE");
    
    if( value != LC_PAY_CYC_I.BindColVal)
        return false;
    
    return true;
</script>

<script language=JavaScript for=LC_PAY_CYC_I event=OnSelChange()>
    DS_PAY_DT_FLAG_I.Filter();
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
  sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
  
  if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD")!= ""){
	  setObject(false);
	        // CENTRAL SUARE START
	        //if(EM_BUY_ACC_VEN_CD_I.text == ""){
	        //    EM_BUY_ACC_VEN_CD_I.Enable  = true;
	        //}
	        //else{
	        //    EM_BUY_ACC_VEN_CD_I.Enable  = false;
	        //}
	        //if(EM_SALE_ACC_VEN_CD_I.text == ""){
	        //    EM_SALE_ACC_VEN_CD_I.Enable  = true;
	        //}
	        //else{
	        //    EM_SALE_ACC_VEN_CD_I.Enable  = false;
	        //}
	        // CENTRAL SUARE END
	    
  }
  else {
	  setObject(true);
	  // CENTRAL SUARE START
      //EM_BUY_ACC_VEN_CD_I.Enable  = true;
      //EM_SALE_ACC_VEN_CD_I.Enable = true;
      // CENTRAL SUARE END
  
  }
  
  var appSDt = DS_IO_MASTER.NameValue(row,"BIZ_S_DT");
  if( DS_IO_MASTER.RowStatus(row) != 1 && appSDt < getTodayFormat("YYYYMMDD") ){
      setObjTypeStyle( EM_BIZ_S_DT_I, "YYYYMMDD", READ );
      EM_BIZ_S_DT_I.enable = false;
  }else{
      setObjTypeStyle( EM_BIZ_S_DT_I, "YYYYMMDD", NORMAL );
      EM_BIZ_S_DT_I.enable = true;
  }
  if(LC_BIZ_TYPE_I.BindColVal == "1"){
      enableControl(EM_SBNS_CAL_RATE_I2, true);
 }else{
      enableControl(EM_SBNS_CAL_RATE_I2, false);
 }
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

 if(row > 0 && old_Row > 0 && DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) != "1"){
    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL2.IsUpdated || DS_O_DETAIL.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1074");
        if (ret != "1") {
        	DS_IO_MASTER.RowPosition = old_Row;
            return;
        } else {
        	if (DS_IO_MASTER.RowStatus(old_Row) == "1") //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
            {
                DS_IO_MASTER.DeleteRow(old_Row);
                // MARIO OUTLET START
                setObject(false);
                setObjectGD2(false);
                // MARIO OUTLET END
                newMaster = false;
                
            } else {
                //변경된 데이터 원상복귀
                var ColCnt = this.CountColumn;
                for( var i=1; i<=ColCnt;i++){
                    if(this.RWStatus(old_Row,i) != 0)
                        this.NameValue( old_Row, this.ColumnID(i)) = this.OrgNameValue(old_Row,this.ColumnID(i));
                }
                
                ColCnt = DS_O_DETAIL.CountColumn;
                for( var j=1; j<=DS_O_DETAIL.CountRow;j++){
	                for( var i=1; i<=ColCnt;i++){
	                    if(DS_O_DETAIL.RWStatus(j,i) != 0){
	                    	if(DS_O_DETAIL.RowStatus(j) == 1){
	                    		DS_O_DETAIL.DeleteRow(j);
	                    		break;
	                    	}
	                    	DS_O_DETAIL.NameValue( j, DS_O_DETAIL.ColumnID(i)) = DS_O_DETAIL.OrgNameValue(j,DS_O_DETAIL.ColumnID(i));
	                    }
	                }
                }
                
                ColCnt = DS_IO_DETAIL2.CountColumn;
                for( var j=1; j<=DS_IO_DETAIL2.CountRow;j++){
                    for( var i=1; i<=ColCnt;i++){
                        if(DS_IO_DETAIL2.RWStatus(j,i) != 0){
                            if(DS_IO_DETAIL2.RowStatus(j) == 1){
                            	DS_IO_DETAIL2.DeleteRow(j);
                                break;
                            }
                            DS_IO_DETAIL2.NameValue( j, DS_IO_DETAIL2.ColumnID(i)) = DS_IO_DETAIL2.OrgNameValue(j,DS_IO_DETAIL2.ColumnID(i));
                        }
                    }
                }
            }
        }
    }
    
    
    searchDetail();
	searchDetail2();

    //거래형태가 임대을이면 일반관리비청구구분, 카드수수료부담 필수
    if(LC_BIZ_TYPE_I.BindColVal == "3" || LC_BIZ_TYPE_I.BindColVal == "5" || LC_BIZ_TYPE_I.BindColVal == "2"){
        ADMINEXP_P.style.display = "";
        ADMINEXP.style.display = "none";
        setObjTypeStyle( LC_ADMIN_EXP_USE_I, "COMBO", PK );  
        CARDFEE_P.style.display = "";
        CARDFEE.style.display = "none";
        setObjTypeStyle( LC_CARD_FEE_I, "COMBO", PK );   
    }
    else{
        ADMINEXP_P.style.display = "none";
        ADMINEXP.style.display = "";
        setObjTypeStyle( LC_ADMIN_EXP_USE_I, "COMBO", NORMAL ); 
        CARDFEE_P.style.display = "none";
        CARDFEE.style.display = "";
        setObjTypeStyle( LC_CARD_FEE_I, "COMBO", NORMAL );  
    }
    //특정, 임대을A 일경우에만 POS사용료 등록가능
    if(LC_BIZ_TYPE_I.BindColVal == "3" || LC_BIZ_TYPE_I.BindColVal == "2"){
    	setObjectEM("true");
    }
    else{
    	setObjectEM("false");
    }
    
    
 }
if(LC_BIZ_TYPE_I.BindColVal == "1"){
     enableControl(EM_SBNS_CAL_RATE_I2, true);
}else{
     enableControl(EM_SBNS_CAL_RATE_I2, false);
}
 if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD")!= ""){
     setObject(false);
           // CENTRAL SUARE START
           //if(EM_BUY_ACC_VEN_CD_I.text == ""){
           //    EM_BUY_ACC_VEN_CD_I.Enable  = true;
           //}
           //else{
           //    EM_BUY_ACC_VEN_CD_I.Enable  = false;
           //}
           //if(EM_SALE_ACC_VEN_CD_I.text == ""){
           //    EM_SALE_ACC_VEN_CD_I.Enable  = true;
           //}
           //else{
           //    EM_SALE_ACC_VEN_CD_I.Enable  = false;
           //}
           // CENTRAL SUARE START
       
 }
 else {
     setObject(true);
     // CENTRAL SUARE START
     //EM_BUY_ACC_VEN_CD_I.Enable  = true;
     //EM_SALE_ACC_VEN_CD_I.Enable = true;
     // CENTRAL SUARE END
 }
 
 
 var appSDt = this.NameValue(row,"BIZ_S_DT");
 if( this.RowStatus(row) != 1 && appSDt < getTodayFormat("YYYYMMDD") ){
     setObjTypeStyle( EM_BIZ_S_DT_I, "YYYYMMDD", READ );
     EM_BIZ_S_DT_I.enable = false;
 }else{
     setObjTypeStyle( EM_BIZ_S_DT_I, "YYYYMMDD", NORMAL );
     EM_BIZ_S_DT_I.enable = true;
 }
 old_Row = row;
 </script>


<!-- 거래시작일 -->
<script language=JavaScript for=EM_BIZ_S_DT_I event=onKillFocus()>
    if(EM_BIZ_S_DT_I.text=='')
        return;
    if(EM_BIZ_S_DT_I.text.length != 8){
    	showMessage(EXCLAMATION, OK, "USER-1004", "거래시작일");
        //EM_BIZ_S_DT_I.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I.Focus();
        return;
    }

    //if(getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))) > EM_BIZ_S_DT_I.text){
    if(getRawData(addDate('D',0,getTodayFormat('YYYYMMDD'))) > EM_BIZ_S_DT_I.text){
        showMessage(EXCLAMATION, OK, "USER-1030", "거래시작일");
        //EM_BIZ_S_DT_I.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I.Focus();
        return;     
    }

</script>
<!-- 거래종료일 -->
<script language=JavaScript for=EM_BIZ_E_DT_I event=onKillFocus()>
    if(EM_BIZ_E_DT_I.text=='')
        return;
    if(EM_BIZ_E_DT_I.text.length !=8){
        showMessage(EXCLAMATION, OK, "USER-1004", "거래종료일");
        EM_BIZ_E_DT_I.text = "99991231";
        EM_BIZ_E_DT_I.Focus();
        return;
    }    

    if(EM_BIZ_S_DT_I.text > EM_BIZ_E_DT_I.text){
        showMessage(EXCLAMATION, OK, "USER-1000", "거래종료일은 거래시작일보다 커야 합니다.");
        EM_BIZ_E_DT_I.text = "99991231";
        EM_BIZ_E_DT_I.Focus();
        return;     
    }

</script>

<!-- 거래시작일 -->
<script language=JavaScript for=EM_BIZ_S_DT_I2 event=onKillFocus()>
    if(EM_BIZ_S_DT_I2.text=='')
        return;
    if(EM_BIZ_S_DT_I2.text.length != 8){
        showMessage(EXCLAMATION, OK, "USER-1004", "거래시작일");
        //EM_BIZ_S_DT_I2.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I2.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I2.Focus();
        return;
    }
    
    //if(getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))) > EM_BIZ_S_DT_I2.text){
    if(getRawData(addDate('D',0,getTodayFormat('YYYYMMDD'))) > EM_BIZ_S_DT_I2.text){
    	showMessage(EXCLAMATION, OK, "USER-1030", "거래시작일");
        //EM_BIZ_S_DT_I2.text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I2.text = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        EM_BIZ_S_DT_I2.Focus();
        return;     
    }

</script>
<!-- 거래종료일 -->
<script language=JavaScript for=EM_BIZ_E_DT_I2 event=onKillFocus()>
    if(EM_BIZ_E_DT_I2.text=='')
        return;
    if(EM_BIZ_E_DT_I2.text.length !=8){
        showMessage(EXCLAMATION, OK, "USER-1004", "거래종료일");
        EM_BIZ_E_DT_I2.text = "99991231";
        EM_BIZ_E_DT_I2.Focus();                                                                           
        return;
    }    

    if(EM_BIZ_S_DT_I2.text > EM_BIZ_E_DT_I2.text){
        showMessage(EXCLAMATION, OK, "USER-1000", "거래종료일은 거래시작일보다 커야 합니다.");
        EM_BIZ_E_DT_I2.text = "99991231";
        EM_BIZ_E_DT_I2.Focus();
        return;     
    }

</script>

<!-- 대면포스 -->
<script language=JavaScript for=EM_VIEW_POS_CNT_I event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
    return;

    var strRent    = 0;
    var strDeposit = 0;
    for(i=1; i<= DS_POS_RENT.CountRow; i++){
    	if(DS_POS_RENT.NameValue(i, "CODE") == "1"){
    		strRent = DS_POS_RENT.NameValue(i, "REFER_VALUE");
    	}
    }
    for(i=1; i<= DS_POS_DEPOSIT.CountRow; i++){
        if(DS_POS_DEPOSIT.NameValue(i, "CODE") == "1"){
        	strDeposit = DS_POS_DEPOSIT.NameValue(i, "REFER_VALUE");
        }
    }
    EM_VIEW_POS_DEPOSIT_I.Text = this.Text * strDeposit;
    EM_VIEW_POS_RENT_I.Text = this.Text * strRent;
    
</script>

<!-- F&B POS -->
<script language=JavaScript for=EM_FB_POS_CNT_I event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
         return;

    var strRent    = 0;
    var strDeposit = 0;
    for(i=1; i<= DS_POS_RENT.CountRow; i++){
        if(DS_POS_RENT.NameValue(i, "CODE") == "2"){
            strRent = DS_POS_RENT.NameValue(i, "REFER_VALUE");
        }
    }
    for(i=1; i<= DS_POS_DEPOSIT.CountRow; i++){
        if(DS_POS_DEPOSIT.NameValue(i, "CODE") == "2"){
            strDeposit = DS_POS_DEPOSIT.NameValue(i, "REFER_VALUE");
        }
    }
    EM_FB_POS_DEPOSIT_I.Text = this.Text * strDeposit;
    EM_FB_POS_RENT_I.Text = this.Text * strRent;
    
</script>

<!-- MINI POS -->
<script language=JavaScript for=EM_MINI_POS_CNT_I event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
    return;

    var strRent    = 0;
    var strDeposit = 0;
    for(i=1; i<= DS_POS_RENT.CountRow; i++){
        if(DS_POS_RENT.NameValue(i, "CODE") == "3"){
            strRent = DS_POS_RENT.NameValue(i, "REFER_VALUE");
        }
    }
    for(i=1; i<= DS_POS_DEPOSIT.CountRow; i++){
        if(DS_POS_DEPOSIT.NameValue(i, "CODE") == "3"){
            strDeposit = DS_POS_DEPOSIT.NameValue(i, "REFER_VALUE");
        }
    }
    EM_MINI_POS_DEPOSIT_I.Text = this.Text * strDeposit;
    EM_MINI_POS_RENT_I.Text = this.Text * strRent;
    
</script>

<!-- PDA POS -->
<script language=JavaScript for=EM_PDA_POS_CNT_I event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;

    var strRent    = 0;
    var strDeposit = 0;
    for(i=1; i<= DS_POS_RENT.CountRow; i++){
        if(DS_POS_RENT.NameValue(i, "CODE") == "4"){
            strRent = DS_POS_RENT.NameValue(i, "REFER_VALUE");
        }
    }
    for(i=1; i<= DS_POS_DEPOSIT.CountRow; i++){
        if(DS_POS_DEPOSIT.NameValue(i, "CODE") == "4"){
            strDeposit = DS_POS_DEPOSIT.NameValue(i, "REFER_VALUE");
        }
    }
    EM_PDA_POS_DEPOSIT_I.Text = this.Text * strDeposit;
    EM_PDA_POS_RENT_I.Text = this.Text * strRent;
    
</script>

<!-- 돈통 -->
<script language=JavaScript for=EM_MON_POS_CNT_I event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    var strRent    = 0;
    var strDeposit = 0;
    for(i=1; i<= DS_POS_RENT.CountRow; i++){
        if(DS_POS_RENT.NameValue(i, "CODE") == "5"){
            strRent = DS_POS_RENT.NameValue(i, "REFER_VALUE");
        }
    }
    for(i=1; i<= DS_POS_DEPOSIT.CountRow; i++){
        if(DS_POS_DEPOSIT.NameValue(i, "CODE") == "5"){
            strDeposit = DS_POS_DEPOSIT.NameValue(i, "REFER_VALUE");
        }
    }
    EM_MON_POS_DEPOSIT_I.Text = this.Text * strDeposit;
    EM_MON_POS_RENT_I.Text = this.Text * strRent;
    
</script>

<script language=Javascript>
    // 이전 Focus에 대한 정보를 저장한다.
    var old_Row = 0;
    var old_Colid = '';
    var chk_grid1 = 0;
    var chk_grid2 = 0;
    var old_Row_Detail = 0;
    var old_Row_Detail2 = 0;
</script>

<script language=JavaScript for=DS_O_DETAIL
	event=onColumnChanged(Row,Colid)>
old_Row_Detail = Row;
</script>
<script language=JavaScript for=DS_IO_DETAIL2
	event=onColumnChanged(Row,Colid)>
old_Row_Detail2 = Row;
</script>
<!--  ===================GD_MASTER============================ -->

<!--  ===================GD_DETAIL============================ -->
<!-- Grid GD_DETAIL OnExit event 처리 -->
	<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
	sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
	if (DS_O_DETAIL.RowStatus(row) != 1){
	    setObjectGD2(false);
	}
	else {
	    setObjectGD2(true);
	}

</script>

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>

	if (DS_O_DETAIL.RowStatus(row) != 1){
	    setObjectGD2(false);
	}
	else {
	    setObjectGD2(true);
	}

    var appSDt = this.NameValue(row,"BIZ_S_DT");
    if( this.RowStatus(row) != 1 && appSDt < getTodayFormat("YYYYMMDD") ){
        setObjTypeStyle( EM_BIZ_S_DT_I2, "EMEDIT", READ );
        EM_BIZ_S_DT_I2.enable = false;
    }else{
        setObjTypeStyle( EM_BIZ_S_DT_I2, "EMEDIT", PK );
        EM_BIZ_S_DT_I2.enable = true;
    }

 </script>

<script language=JavaScript for=GD_DETAIL2 event=OnClick(row,colid)>

  sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬

  if (colid == "VEN_TASK_FLAG"){
	  if(DS_IO_DETAIL2.RowStatus(row) == 1) {
	        GD_DETAIL2.ColumnProp("VEN_TASK_FLAG","EDIT") = "ANY";
	    } else {
	    	GD_DETAIL2.ColumnProp("VEN_TASK_FLAG","EDIT") = "NONE";
	    }
  }

</script>

<!--  ===================SEARCH CONDITION AREA================= -->

<!-- 협력사코드 변경시 -->

<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_VEN_NAME.Text = "";
        return;
    }   
    setVenNmWithoutPop( "DS_O_RESULT", this, EM_VEN_NAME, '0');
</script>

<!-- 협력사명 변경시
<script language=JavaScript for=EM_VEN_NAME event=OnKillFocus()>  
if (EM_VEN_CD.Text.length != 0){
    var rtnMap = setVenNmWithoutToGridPop( "DS_O_RESULT", EM_VEN_CD.Text, this.Text, '0');
    if (rtnMap != null){
    	EM_VEN_CD.Text = rtnMap.get("VEN_CD");
    	EM_VEN_NAME.Text = rtnMap.get("VEN_NAME");
    }  
    else{
    	//EM_VEN_CD.Text = "";
        //EM_VEN_NAME.Text = "";
    }
}
</script>
 -->
<!-- 대표협력사코드 변경시 -->
<script language=JavaScript for=EM_REP_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_REP_VEN_NAME.Text = "";
        return;
    }   
    setRepVenNmWithoutPop( "DS_O_RESULT", this, EM_REP_VEN_NAME, '1');
</script>

<!-- 대표협력사코드 변경시 (등록) -->
<script language=JavaScript for=EM_REP_VEN_CD_I  event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_REP_VEN_NAME_I.Text = "";
    	// MARIO OUTLET START
    	EM_COMP_NO_I.Text = "";
    	EM_CORP_NO_I.Text = "";
    	EM_COMP_NAME_I.Text = "";
    	EM_REP_NAME_I.Text = "";
    	EM_BIZ_STAT_I.Text = "";
    	EM_BIZ_CAT_I.Text = "";
    	EM_POST_NO_I.Text = "";
    	EM_ADDR_I.Text = "";
    	EM_DTL_ADDR_I.Text = "";
    	EM_PHONE1_NO_I.Text = "";
    	EM_PHONE2_NO_I.Text = "";
    	EM_PHONE3_NO_I.Text = "";
    	EM_FAX1_NO_I.Text = "";
    	EM_FAX2_NO_I.Text = "";
    	EM_FAX3_NO_I.Text = ""; 
    	// MARIO OUTLET END
        return;
    } 
    // MARIO OUTLET START
    //setRepVenNmWithoutPop( "DS_O_RESULT", this, EM_REP_VEN_NAME_I, '1');
    // MARIO OUTLET END
    setRepVenNmWithoutPop_pcod101( "DS_O_RESULT", this,  EM_REP_VEN_NAME_I
												  		,EM_COMP_NO_I
												      	,EM_CORP_NO_I
												      	,EM_COMP_NAME_I
												      	,EM_REP_NAME_I
												      	,EM_BIZ_STAT_I
												      	,EM_BIZ_CAT_I
												      	,EM_POST_NO_I
												      	,EM_ADDR_I
												      	,EM_DTL_ADDR_I
												      	,EM_PHONE1_NO_I
												      	,EM_PHONE2_NO_I
												      	,EM_PHONE3_NO_I
												      	,EM_FAX1_NO_I
												      	,EM_FAX2_NO_I
												      	,EM_FAX3_NO_I,  '1');
</script>
<!-- 협력사명 변경시 (등록) -->
<script language=JavaScript for=EM_VEN_NAME_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;

    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == "3"){
        for(i=1; i<= DS_O_DETAIL.CountRow;i++){
        	DS_O_DETAIL.NameValue(i,"VEN_NAME") = EM_VEN_NAME_I.text;
    	}
    }
</script>

<!-- 협력사약명 변경시 (등록) -->
<script language=JavaScript for=EM_VEN_SHORT_NAME_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == "3"){
        for(i=1; i<= DS_O_DETAIL.CountRow;i++){
        	DS_O_DETAIL.NameValue(i,"VEN_SHORT_NAME") = EM_VEN_SHORT_NAME_I.text;
        }
    }
</script>

<!-- 거래형태 변경시 (등록) -->
<script language=JavaScript for=LC_BIZ_TYPE_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == "3"){
        for(i=1; i<= DS_O_DETAIL.CountRow;i++){
        	DS_O_DETAIL.NameValue(i,"BIZ_TYPE") = LC_BIZ_TYPE_I.text;
        }
    }
</script>

<!-- 거래구분 변경시 (등록) -->
<script language=JavaScript for=LC_BIZ_FLAG_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == "3"){
        for(i=1; i<= DS_O_DETAIL.CountRow;i++){
        	DS_O_DETAIL.NameValue(i,"BIZ_FLAG") = LC_BIZ_FLAG_I.text;
        }
    }
</script>

<!-- 사업자번호 변경시 (등록) -->
<script language=JavaScript for=EM_COMP_NO_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    searchComp(this.text); 
    
    if(DS_O_COMP_INFO.CountRow > 0){
    	EM_COMP_NO_I.text = DS_O_COMP_INFO.NameValue(1,"COMP_NO");
	  	EM_CORP_NO_I.text = DS_O_COMP_INFO.NameValue(1,"CORP_NO");
	  	EM_COMP_NAME_I.text = DS_O_COMP_INFO.NameValue(1,"COMP_NAME");
	  	EM_REP_NAME_I.text = DS_O_COMP_INFO.NameValue(1,"REP_NAME");
	  	EM_BIZ_STAT_I.text = DS_O_COMP_INFO.NameValue(1,"BIZ_STAT");
	  	EM_BIZ_CAT_I.text = DS_O_COMP_INFO.NameValue(1,"BIZ_CAT");
	  	EM_POST_NO_I.text = DS_O_COMP_INFO.NameValue(1,"POST_NO");
	  	EM_ADDR_I.text = DS_O_COMP_INFO.NameValue(1,"ADDR");
	  	EM_DTL_ADDR_I.text = DS_O_COMP_INFO.NameValue(1,"DTL_ADDR");
	  	EM_PHONE1_NO_I.text = DS_O_COMP_INFO.NameValue(1,"PHONE1_NO");
	  	EM_PHONE2_NO_I.text = DS_O_COMP_INFO.NameValue(1,"PHONE2_NO");
	  	EM_PHONE3_NO_I.text = DS_O_COMP_INFO.NameValue(1,"PHONE3_NO");
	  	EM_FAX1_NO_I.text = DS_O_COMP_INFO.NameValue(1,"FAX1_NO");
	  	EM_FAX2_NO_I.text = DS_O_COMP_INFO.NameValue(1,"FAX2_NO");
	  	EM_FAX3_NO_I.text = DS_O_COMP_INFO.NameValue(1,"FAX3_NO");
    }
    
    
</script>

<!--매입 거래선 입력시  -->
<!-- MARIO OUTLET COMMENT 처리
<script language=JavaScript for=EM_BUY_ACC_VEN_CD_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    //if(!this.Modified){        return;}
    
    if(EM_BUY_ACC_VEN_CD_I.text.length != 0){  
    	DS_O_ACCVEN_CD.ClearData();
    	setAccVenNmWithoutPop( "DS_O_ACCVEN_CD",EM_BUY_ACC_VEN_CD_I, EM_BUY_ACC_VEN_NAME_I, "1", 1,"");
    	EM_BUY_ACC_VEN_NAME_I.Text = "";
    	if(DS_O_ACCVEN_CD.CountRow == 0) return;
    	
        //EM_VEN_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"NAME1");          // 거래선명
        //EM_VEN_SHORT_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"SORTL") ;         // 이름2
        
        
       	if(DS_O_ACCVEN_CD.NameValue(1,"STCD3") == "") {
       		EM_CORP_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"STCD1");          // 세금번호1(주민등록번호)
           }
       	else{
       		EM_CORP_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"STCD3") ;         // 세금번호3(법인번호)
       	}
       
        	
       	EM_COMP_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"STCD2");          // 세금번호2(사업자번호)
        
       	EM_COMP_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"NAME1");          // 거래선명  //상호명
        
       	EM_BIZ_STAT_I.text = DS_O_ACCVEN_CD.NameValue(1,"J_1KFTIND");      // 산업유형(업태)
       	EM_BIZ_CAT_I.text = DS_O_ACCVEN_CD.NameValue(1,"J_1KFTBUS");      // 사업유형(종목)
       	EM_REP_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"J_1KFREPRE");     // 담당자이름(대표자명)
        
        var strPostno = DS_O_ACCVEN_CD.NameValue(1,"PSTLZ");
        strPostno = strPostno.replace("-","");
        strPostno = strPostno.replace(" ","");
        	
        
        
            if(strPostno.length == 6 && isNumberStr(strPostno) == true){
                EM_POST_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"PSTLZ");          // 우편번호
            }
        
            EM_ADDR_I.text = DS_O_ACCVEN_CD.NameValue(1,"ORT01");          // 도시(주소-동,리까지)
            EM_DTL_ADDR_I.text = DS_O_ACCVEN_CD.NameValue(1,"STRAS");          // 번지
       
        if(DS_O_ACCVEN_CD.NameValue(1,"SPERR") == "X" || DS_O_ACCVEN_CD.NameValue(1,"SPERR2") == "X" || DS_O_ACCVEN_CD.NameValue(1,"LOEVM") == "X" || DS_O_ACCVEN_CD.NameValue(1,"LOEVM2") == "X"){
            LC_SAP_DEL_HOLD.BindColVal = "1";
        }
        else{
            LC_SAP_DEL_HOLD.BindColVal = "0";
        }
        
        var strTel = DS_O_ACCVEN_CD.NameValue(1,"TELF1");
        strTel = strTel.replace(")","-");
        strTel = strTel.replace(" ","");
        var strDash = 0;
        var strPhone = "";
        var strRegion = "";    //지역번호
        var strExeNum = "";    //국번
        var strTelNum = "";    //번호
        
        for(i=0; i<= strTel.length-1;i++){
            if(strTel.substr(i,1) == "-"){
                strPhone += i+"";
                strDash++;
            }
        }
        if(strDash == 2){
        
            strRegion = strTel.substr(0,strPhone.substr(0,1));
            strExeNum = strTel.substr(parseInt(strPhone.substr(0,1))+1,parseInt(strPhone.substr(1,1)) - parseInt(strPhone.substr(0,1))-1);
            strTelNum = strTel.substr(parseInt(strPhone.substr(1,1))+1,strTel.length -parseInt(strPhone.substr(1,1)) -1 );
            
            
                if(strRegion.length <=4 && EM_PHONE1_NO_I.text == "") EM_PHONE1_NO_I.text  = strRegion;
                if(strExeNum.length <=4 && EM_PHONE2_NO_I.text == "") EM_PHONE2_NO_I.text  = strExeNum;
                if(strTelNum.length <=4 && EM_PHONE3_NO_I.text == "") EM_PHONE3_NO_I.text  = strTelNum;
            
        }
        
        strTel = DS_O_ACCVEN_CD.NameValue(1,"TELFX");
        strTel = strTel.replace(")","-");
        strTel = strTel.replace(" ","");
        var strDash = 0;
        var strPhone = "";
        var strRegion = "";    //지역번호
        var strExeNum = "";    //국번
        var strTelNum = "";    //번호
        
        for(i=0; i<= strTel.length-1;i++){
            if(strTel.substr(i,1) == "-"){
                strPhone += i+"";
                strDash++;
            }
        }
        if(strDash == 2){
            strRegion = strTel.substr(0,strPhone.substr(0,1));
            strExeNum = strTel.substr(parseInt(strPhone.substr(0,1))+1,parseInt(strPhone.substr(1,1)) - parseInt(strPhone.substr(0,1))-1);
            strTelNum = strTel.substr(parseInt(strPhone.substr(1,1))+1,strTel.length -parseInt(strPhone.substr(1,1)) -1 );
            if(EM_FAX1_NO_I.text == "" && EM_FAX2_NO_I.text == "" && EM_FAX3_NO_I.text == ""){
                if(strRegion.length <=4 && EM_FAX1_NO_I.text == "") EM_FAX1_NO_I.text  = strRegion;
                if(strExeNum.length <=4 && EM_FAX2_NO_I.text == "") EM_FAX2_NO_I.text  = strExeNum;
                if(strTelNum.length <=4 && EM_FAX3_NO_I.text == "") EM_FAX3_NO_I.text  = strTelNum;
            }
        }
    }   
</script>
-->

<!--매출 거래선 입력시  -->
<!-- MARIO OUTLET COMMENT 처리
<script language=JavaScript for=EM_SALE_ACC_VEN_CD_I event=onKillFocus()>
//변경된 내역이 없으면 무시
    //if(!this.Modified){        return;}
    
    if(EM_SALE_ACC_VEN_CD_I.text.length != 0){   
    	DS_O_ACCVEN_CD.ClearData();
    	setAccVenNmWithoutPop( "DS_O_ACCVEN_CD",EM_SALE_ACC_VEN_CD_I, EM_SALE_ACC_VEN_NAME_I, "2", 1, "");
    	EM_SALE_ACC_VEN_NAME_I.Text = "";
        if(DS_O_ACCVEN_CD.CountRow == 0) return;

        //EM_VEN_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"NAME1");          // 거래선명
        //EM_VEN_SHORT_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"SORTL") ;         // 이름2
        
        
        if(DS_O_ACCVEN_CD.NameValue(1,"STCD3") == "") {
            EM_CORP_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"STCD1");          // 세금번호1(주민등록번호)
           }
        else{
            EM_CORP_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"STCD3") ;         // 세금번호3(법인번호)
        }
       
            
        EM_COMP_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"STCD2");          // 세금번호2(사업자번호)
        
        EM_COMP_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"NAME1");          // 거래선명  //상호명
        
        EM_BIZ_STAT_I.text = DS_O_ACCVEN_CD.NameValue(1,"J_1KFTIND");      // 산업유형(업태)
        EM_BIZ_CAT_I.text = DS_O_ACCVEN_CD.NameValue(1,"J_1KFTBUS");      // 사업유형(종목)
        EM_REP_NAME_I.text = DS_O_ACCVEN_CD.NameValue(1,"J_1KFREPRE");     // 담당자이름(대표자명)
        
        var strPostno = DS_O_ACCVEN_CD.NameValue(1,"PSTLZ");
        strPostno = strPostno.replace("-","");
        strPostno = strPostno.replace(" ","");
            
        
            if(strPostno.length == 6 && isNumberStr(strPostno) == true){
                EM_POST_NO_I.text = DS_O_ACCVEN_CD.NameValue(1,"PSTLZ");          // 우편번호
            }
        
            EM_ADDR_I.text = DS_O_ACCVEN_CD.NameValue(1,"ORT01");          // 도시(주소-동,리까지)
            EM_DTL_ADDR_I.text = DS_O_ACCVEN_CD.NameValue(1,"STRAS");          // 번지
        
        if(DS_O_ACCVEN_CD.NameValue(1,"SPERR") == "X" || DS_O_ACCVEN_CD.NameValue(1,"SPERR2") == "X" || DS_O_ACCVEN_CD.NameValue(1,"LOEVM") == "X" || DS_O_ACCVEN_CD.NameValue(1,"LOEVM2") == "X"){
            LC_SAP_DEL_HOLD.BindColVal = "1";
        }
        else{
            LC_SAP_DEL_HOLD.BindColVal = "0";
        }
        
        var strTel = DS_O_ACCVEN_CD.NameValue(1,"TELF1");
        strTel = strTel.replace(")","-");
        strTel = strTel.replace(" ","");
        var strDash = 0;
        var strPhone = "";
        var strRegion = "";    //지역번호
        var strExeNum = "";    //국번
        var strTelNum = "";    //번호
        
        for(i=0; i<= strTel.length-1;i++){
            if(strTel.substr(i,1) == "-"){
                strPhone += i+"";
                strDash++;
            }
        }
        if(strDash == 2){
        
            strRegion = strTel.substr(0,strPhone.substr(0,1));
            strExeNum = strTel.substr(parseInt(strPhone.substr(0,1))+1,parseInt(strPhone.substr(1,1)) - parseInt(strPhone.substr(0,1))-1);
            strTelNum = strTel.substr(parseInt(strPhone.substr(1,1))+1,strTel.length -parseInt(strPhone.substr(1,1)) -1 );
            
            
                if(strRegion.length <=4 && EM_PHONE1_NO_I.text == "") EM_PHONE1_NO_I.text  = strRegion;
                if(strExeNum.length <=4 && EM_PHONE2_NO_I.text == "") EM_PHONE2_NO_I.text  = strExeNum;
                if(strTelNum.length <=4 && EM_PHONE3_NO_I.text == "") EM_PHONE3_NO_I.text  = strTelNum;
            
        }
        
        strTel = DS_O_ACCVEN_CD.NameValue(1,"TELFX");
        strTel = strTel.replace(")","-");
        strTel = strTel.replace(" ","");
        var strDash = 0;
        var strPhone = "";
        var strRegion = "";    //지역번호
        var strExeNum = "";    //국번
        var strTelNum = "";    //번호
        
        for(i=0; i<= strTel.length-1;i++){
            if(strTel.substr(i,1) == "-"){
                strPhone += i+"";
                strDash++;
            }
        }
        if(strDash == 2){
            strRegion = strTel.substr(0,strPhone.substr(0,1));
            strExeNum = strTel.substr(parseInt(strPhone.substr(0,1))+1,parseInt(strPhone.substr(1,1)) - parseInt(strPhone.substr(0,1))-1);
            strTelNum = strTel.substr(parseInt(strPhone.substr(1,1))+1,strTel.length -parseInt(strPhone.substr(1,1)) -1 );
            if(EM_FAX1_NO_I.text == "" && EM_FAX2_NO_I.text == "" && EM_FAX3_NO_I.text == ""){
                if(strRegion.length <=4 && EM_FAX1_NO_I.text == "") EM_FAX1_NO_I.text  = strRegion;
                if(strExeNum.length <=4 && EM_FAX2_NO_I.text == "") EM_FAX2_NO_I.text  = strExeNum;
                if(strTelNum.length <=4 && EM_FAX3_NO_I.text == "") EM_FAX3_NO_I.text  = strTelNum;
            }
        }
    }     
</script>
-->

<!-- 사업자구분 변경시 -->
<script language=JavaScript for= LC_COMP_FLAG_I event=OnSelChange()>
if(LC_COMP_FLAG_I.BindColVal == "6"){
    BUBIN.style.display     = "none";
    JUMIN.style.display     = "";
    SAUPJANOP.style.display = "none";
    SAUPJANON.style.display = "";
    SANGHOP.style.display   = "none";
    SANGHON.style.display   = "";
    UPTAEP.style.display    = "none";
    UPTAEN.style.display    = "";
    JUSOP.style.display     = "none";
    JUSON.style.display     = "";
    TELNOP.style.display    = "none";
    TELNON.style.display    = "";
    DAEPYOP.style.display   = "none";
    DAEPYON.style.display   = "";
    JONGMOKP.style.display  = "none";
    JONGMOKN.style.display  = "";
    
    EM_COMP_NO_I.style.background   = "white";
    EM_COMP_NAME_I.style.background = "white";
    EM_REP_NAME_I.style.background  = "white";
    EM_BIZ_STAT_I.style.background  = "white";
    EM_BIZ_CAT_I.style.background   = "white";
    EM_PHONE1_NO_I.style.background = "white";
    EM_PHONE2_NO_I.style.background = "white";
    EM_PHONE3_NO_I.style.background = "white";
    
}
else{
	BUBIN.style.display     = "";
    JUMIN.style.display     = "none";
    SAUPJANOP.style.display = "";
    SAUPJANON.style.display = "none";
    SANGHOP.style.display   = "";
    SANGHON.style.display   = "none";
    UPTAEP.style.display    = "";
    UPTAEN.style.display    = "none";
    JUSOP.style.display     = "";
    JUSON.style.display     = "none";
    TELNOP.style.display    = "";
    TELNON.style.display    = "none";
    DAEPYOP.style.display   = "";
    DAEPYON.style.display   = "none";
    JONGMOKP.style.display  = "";
    JONGMOKN.style.display  = "none";

    EM_COMP_NO_I.style.background   = "#fffddd";
    EM_COMP_NAME_I.style.background = "#fffddd";
    EM_REP_NAME_I.style.background  = "#fffddd";
    EM_BIZ_STAT_I.style.background  = "#fffddd";
    EM_BIZ_CAT_I.style.background   = "#fffddd";
    EM_PHONE1_NO_I.style.background = "#fffddd";
    EM_PHONE2_NO_I.style.background = "#fffddd";
    EM_PHONE3_NO_I.style.background = "#fffddd";

}
</script>

<!-- 은행코드변경시  -->
<script language=JavaScript for= LC_BANK_CD_I event=OnSelChange()>
if(LC_BANK_CD_I.BindColVal == ""){
	 EM_BANK_ACC_NO_I.Enable = false;
	 EM_ACC_NO_OWN_I.Enable  = false;
	 EM_BANK_ACC_NO_I.text = "";
     EM_ACC_NO_OWN_I.text  = "";
}
else{
    EM_BANK_ACC_NO_I.Enable = true;
    EM_ACC_NO_OWN_I.Enable  = true;
}
</script>
<!-- LC_BUY_SALE_FLAG_I -->

<!-- 매입매출구분 변경시 -->
<!-- MARIO OUTLET COMMENT
<script language=JavaScript for= LC_BUY_SALE_FLAG_I event=OnSelChange()>

if(LC_BUY_SALE_FLAG_I.BindColVal == "1"){
	BUYACCVENPOINT.style.display = "";
    BUYACCVEN.style.display = "none";
	SALEACCVENPOINT.style.display = "none";
    SALEACCVEN.style.display = "";
    EM_BUY_ACC_VEN_CD_I.style.background  = "#fffddd";
    EM_SALE_ACC_VEN_CD_I.style.background = "white";
}
else{
	BUYACCVENPOINT.style.display = "none";
    BUYACCVEN.style.display = "";
    SALEACCVENPOINT.style.display = "";
    SALEACCVEN.style.display = "none";
    EM_BUY_ACC_VEN_CD_I.style.background  = "white";
    EM_SALE_ACC_VEN_CD_I.style.background = "#fffddd";
}

if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD")!= ""){
    setObject(false);
}
else {
    setObject(true);
}

</script>
-->

<script language=JavaScript for=DS_O_DETAIL event=OnDataError(row,colid)>

    if(colid == 'STR_CD'){
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD_I.Focus();
    }else{
        showMessage(EXCLAMATION, OK, "USER-1044", row);
        LC_STR_CD_I.Focus();
    }
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
<!-- MARIO OUTLET
<comment id="_NSID_">
<object id="DS_BUY_SALE_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
-->
<comment id="_NSID_">
<object id="DS_COMP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BIZ_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_USE_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_CLOSECHECK classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 등록용 -->
<comment id="_NSID_">
<object id="DS_BUY_SALE_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BIZ_TYPE_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BIZ_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_COMP_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_ETAX_ISSUE_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_RVS_ISSUE_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_EDI_YN_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_USE_YN_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PAY_CYC_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PAY_CNT_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PAY_DT_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PAY_WAY_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TAX_ITG_ISSUE_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COMBINE_ISSUE_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PAY_HOLI_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_ROUND_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_POS_CAL_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BANK_CD_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHRG_WAY_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHRG_COND_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHRG_DT_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_USE_YN_I2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_VEN_TASK_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_USE_YN_I3" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- MARIO OUTLET START -->
<!-- 
<comment id="_NSID_">
<object id=DS_SAP_DEL_HOLD classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
 -->
<!-- MARIO OUTLET END -->

<comment id="_NSID_">
<object id=DS_ADMIN_EXP_USE_I classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_CARD_FEE_I classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_DZ_SLP_FLAG classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

   
<comment id="_NSID_">
<object id=DS_POS_RENT classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_POS_DEPOSIT classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 그리드 헤더 가져오기  -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_ACCVEN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- MARIO OUTLET START -->
<comment id="_NSID_">
<object id="DS_O_COMP_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- MARIO OUTLET END -->
<!-- ===============- Output용 -->

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

<comment id="_NSID_">
<object id="TR_DETAIL2" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- MARIO OUTLET -->
<comment id="_NSID_">
<object id="TR_SEARCH" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- MARIO OUTLET -->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


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
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
<!--
						<th width="100">매입매출구분</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_BUY_SALE_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
-->
						 
						<th width="110">사업자구분</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_COMP_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						  
						<th width="100">사업자번호</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						
						<th width="100">거래형태</th>
						<td ><comment id="_NSID_"> <object
							id=LC_BIZ_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					
					</tr>
					<tr>	
						<th width="100">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:venPop(EM_VEN_CD, EM_VEN_NAME); EM_REP_VEN_CD.focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=65 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
							
						<th width="100">대표협력사</th>
						<td><comment id="_NSID_"> <object id=EM_REP_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:repVenPop(EM_REP_VEN_CD, EM_REP_VEN_NAME);"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_REP_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=65
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<!-- 조회 조건 삭제 MARIO OUTLET-->    
						<%-- <th width="100">거래선</th>
						<td><comment id="_NSID_"> <object id=EM_ACC_CD
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:accVenPop(EM_ACC_CD,EM_ACC_NAME, LC_BUY_SALE_FLAG.BindColVal); LC_USE_YN.focus();" align="absmiddle" /></td>
							<div style="display:none;">
							<comment id="_NSID_"> <object
                            id=EM_ACC_NAME classid=<%=Util.CLSID_EMEDIT%> width=65
                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                            --%>
                         
						<th>사용여부</th>
						<td><comment id="_NSID_"> <object id=LC_USE_YN
							classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
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
				<td width="320">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_MASTER
							width="100%" height="480" classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</object></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<div id=TAB_VEN width="100%" height=485 TitleWidth=90
					TitleAlign="center" TitleStyle="" TitleGap=3>
				<menu TitleName="협력사"      DivId="tab_page1" ClickBfFunc="clickVen" />
				<menu TitleName="점별협력사"   DivId="tab_page2" ClickBfFunc="clickStrVen" />
				<menu TitleName="협력사담당자" DivId="tab_page3"  ClickBfFunc="clickVenUser" />
				</div>
				<div id=tab_page1 border=0
					style="position: absolute; left: 0; top: 22px; width: 100%;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<td class="sub_title PB03 PT10"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
							align="absmiddle" /> 협력사 정보</td>
									<td>
									<table width="100%">
						            <td align="right">
												<table border="0" cellspacing="0" cellpadding="0">
												  <tr>
												    <td class="btn_l"> </td>
												    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_ven_emg()">긴급협력사전송</a></td>
												    <td class="btn_r"></td>
												  </tr>
												</table>                
							                </td>			
										</tr>
									</table>				
						            </td>				
						            
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="s_table">
									<tr>
										<th width="100" class="point">협력사코드</th>
										<td width="160"><comment id="_NSID_"> <object
											id=EM_VEN_CD_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="100" class="point">협력사명</th>
										<td><comment id="_NSID_"> <object
											id=EM_VEN_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">협력사약명</th>
										<td><comment id="_NSID_"> <object
											id=EM_VEN_SHORT_NAME_I classid=<%=Util.CLSID_EMEDIT%>
											width=140 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th  class="point">매입매출구분</th>
										<td><comment id="_NSID_"> <object
											id=LC_BUY_SALE_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
											width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th  class="point">거래형태</th>
										<td  ><comment id="_NSID_"> <object
											id=LC_BIZ_TYPE_I classid=<%=Util.CLSID_LUXECOMBO%>
											tabindex=1 width=143 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th  class="point">거래구분</th>
										<td><comment id="_NSID_"> <object
											id=LC_BIZ_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
											tabindex=1 width=143 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<!-- MARIO OUTLET -->
									
										<%-- <th id="SALEACCVENPOINT" width="100" class="point" style="display:">매출거래선</th>
                                        <th id="SALEACCVEN" width="100" style="display:none">매출거래선</th>
										<td><comment id="_NSID_"> <object
											id=EM_SALE_ACC_VEN_CD_I classid=<%=Util.CLSID_EMEDIT%>
											width=120 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											align="absmiddle" class="PR03" onclick="javascript: if(EM_SALE_ACC_VEN_CD_I.Enable) accVenPop(EM_SALE_ACC_VEN_CD_I,EM_SALE_ACC_VEN_NAME_I,'2', EM_COMP_NO_I.text); if(EM_SALE_ACC_VEN_CD_I.Enable)EM_SALE_ACC_VEN_CD_I.focus();" /></td>
										<div style="display:none;">
                                        <comment id="_NSID_"> <object
                                        id=EM_SALE_ACC_VEN_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=65
                                        tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </div> --%>
									</tr>
									
									<tr>
										<th >대표협력사</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_REP_VEN_CD_I classid=<%=Util.CLSID_EMEDIT%> width=50
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
											onclick="javascript:repVenPop_pcod101(EM_REP_VEN_CD_I, EM_REP_VEN_NAME_I
																		, EM_COMP_NO_I
																		, EM_CORP_NO_I
																		, EM_COMP_NAME_I
																		, EM_REP_NAME_I
																		, EM_BIZ_STAT_I
																		, EM_BIZ_CAT_I
																		, EM_POST_NO_I
																		, EM_ADDR_I
																		, EM_DTL_ADDR_I
																		, EM_PHONE1_NO_I
																		, EM_PHONE2_NO_I
																		, EM_PHONE3_NO_I
																		, EM_FAX1_NO_I
																		, EM_FAX2_NO_I
																		, EM_FAX3_NO_I ); EM_REP_VEN_CD_I.focus();"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_REP_VEN_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=348
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">사업자구분</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=LC_COMP_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
											tabindex=1 width=143 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
                                        <%-- <th width="100" class="point">역발행구분</th>
                                        <td width="150"><comment id="_NSID_"> <object
                                            id=LC_RVS_ISSUE_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
                                            tabindex=1 width=143 align="left"> </object> </comment><script>_ws_(_NSID_);</script>
                                        </td> --%>
									</tr>
									<tr>
										<th class="point">사용여부</th>
										<td ><comment id="_NSID_"> <object
											id=LC_USE_YN_I classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1
											width=143 align="left"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<!-- <th id="BUYACCVENPOINT" width="100" class="point" style="display:">매입거래선</th>
                                        <th id="BUYACCVEN" width="100" style="display:none">매입거래선</th> -->
                                        
                                        <th >재무거래선코드</th>
										<td><comment id="_NSID_"> <object
											id=EM_BUY_ACC_VEN_CD_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<%--<td width="150"><comment id="_NSID_"> <object
											id=EM_BUY_ACC_VEN_CD_I classid=<%=Util.CLSID_EMEDIT%>
											width=120 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script> 
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
											onclick="javascript: if(EM_BUY_ACC_VEN_CD_I.Enable)accVenPop(EM_BUY_ACC_VEN_CD_I,EM_BUY_ACC_VEN_NAME_I,'1', EM_COMP_NO_I.text); if(EM_BUY_ACC_VEN_CD_I.Enable)EM_BUY_ACC_VEN_CD_I.focus();" align="absmiddle" /></td>
										<div style="display:none;">
			                            <comment id="_NSID_"> <object
			                            id=EM_BUY_ACC_VEN_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=65
			                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> --%>
			                           <!--  </div> -->
										<!-- MARIO OUTLET START -->
										<!-- 
										<th width="100" class="point">SAP삭제보류구분</th>
                                        <td><comment id="_NSID_"> <object
                                            id=LC_SAP_DEL_HOLD classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1
                                            width=143 align="left"> </object> </comment><script>_ws_(_NSID_);</script>
                                        </td>
                                         -->
                                        <!-- MARIO OUTLET START -->
									</tr>
									<tr>
										<th class="point">거래시작일</th>
										<td ><comment id="_NSID_"> <object
											id=EM_BIZ_S_DT_I classid=<%=Util.CLSID_EMEDIT%> width=120
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											class="PR03" onclick="javascript: if(EM_BIZ_S_DT_I.Enable) openCal('G',EM_BIZ_S_DT_I)" />
										</td>
										<th class="point">거래종료일</th>
										<td><comment id="_NSID_"> <object
											id=EM_BIZ_E_DT_I classid=<%=Util.CLSID_EMEDIT%> width=120
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											class="PR03" onclick="javascript:openCal('G',EM_BIZ_E_DT_I)" />
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
                        <td class="sub_title PB03 PT10"><img
                            src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                            align="absmiddle" /> 사업자 정보</td>
                    </tr>
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="">
                            <tr valign="top">
                                <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                                    class="s_table">
                                    <tr>
										<th id=SAUPJANOP width="100" class="point" style="display:">사업자번호</th>
										<th id=SAUPJANON width="100"  style="display:none">사업자번호</th>
										<td width="160"><comment id="_NSID_"> <object
											id=EM_COMP_NO_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script></td>
										<th id="BUBIN" width="110" style="display:">법인번호</th>
										<th id="JUMIN" width="110" style="display:none">주민번호</th>
										<td><comment id="_NSID_"> <object
											id=EM_CORP_NO_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th id=SANGHOP class="point" style="display:">상호명</th>
                                        <th id=SANGHON style="display:none">상호명</th>
										<td ><comment id="_NSID_"> <object
											id=EM_COMP_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
                                        <th id=DAEPYOP class="point" style="display:">대표자명</th>
                                        <th id=DAEPYON style="display:none">대표자명</th>
										<td><comment id="_NSID_"> <object
											id=EM_REP_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th id=UPTAEP class="point" style="display:">업태</th>
                                        <th id=UPTAEN style="display:none">업태</th>
										<td ><comment id="_NSID_"> <object
											id=EM_BIZ_STAT_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
                                        <th id=JONGMOKP class="point" style="display:">종목</th>
                                        <th id=JONGMOKN style="display:none">종목</th>
										<td><comment id="_NSID_"> <object
											id=EM_BIZ_CAT_I classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
                                        <th id=JUSOP class="point" style="display:" rowspan="2">주소</th>
                                        <th id=JUSON style="display:none" rowspan="2">주소</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_POST_NO_I classid=<%=Util.CLSID_EMEDIT%> width=60
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
											onclick="javascript:getPostPop(EM_POST_NO_I, EM_ADDR_I, EM_DTL_ADDR_I); EM_DTL_ADDR_I.focus();"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_ADDR_I classid=<%=Util.CLSID_EMEDIT%> width=339
											tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script></td>
									</tr>
									<tr>
                                        <td colspan="3"><comment id="_NSID_">  <object id=EM_DTL_ADDR_I
                                            classid=<%=Util.CLSID_EMEDIT%> width=425 tabindex=1
                                            align="left"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                                    </tr>
									<tr>
                                        <th id=TELNOP class="point" style="display:">전화번호</th>
                                        <th id=TELNON style="display:none">전화번호</th>
										<td ><comment id="_NSID_"> <object
											id=EM_PHONE1_NO_I classid=<%=Util.CLSID_EMEDIT%> width=40
											tabindex=1 align="right"> </object> </comment> <script> _ws_(_NSID_);</script>-
										<comment id="_NSID_"> <object id=EM_PHONE2_NO_I
											classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
											align="right"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
											id="_NSID_"> <object id=EM_PHONE3_NO_I
											classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
											align="right"> </object> </comment> <script> _ws_(_NSID_);</script></td>
										<th>FAX번호</th>
										<td><comment id="_NSID_"> <object
											id=EM_FAX1_NO_I classid=<%=Util.CLSID_EMEDIT%> width=38
											tabindex=1 align="right"> </object> </comment> <script> _ws_(_NSID_);</script>-
										<comment id="_NSID_"> <object id=EM_FAX2_NO_I
											classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
											align="right"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
											id="_NSID_"> <object id=EM_FAX3_NO_I
											classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
											align="right"> </object> </comment> <script> _ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</div>
				
            <div id=tab_page2 width="100%">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="sub_title PB03 PT10"><img
                                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                                    align="absmiddle" /> 점별 협력사 정보</td>
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
                        <table border="0" cellspacing="0" cellpadding="0" class="BD4A"
                            width="100%">
                            <tr>
                                <td><comment id="_NSID_"><object id=GD_DETAIL
                                    width="100%" height=100 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_O_DETAIL">
                                </object></comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="PT03">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                            <tr>
                                <th width="150" class="point">점</th>
                                <td width="150"><comment id="_NSID_"> <object
                                    id=LC_STR_CD_I classid=<%=Util.CLSID_LUXECOMBO%> width=143
                                    tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="100" class="point">지불주기</th>
                                <td width="800"><comment id="_NSID_">
                                     <object
                                    id=LC_PAY_CYC_I classid=<%=Util.CLSID_LUXECOMBO%> width=143
                                    tabindex=1 align="left"> 
                                    </object> 
                                    </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="point">지불일</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_PAY_DT_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">지불방법</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_PAY_WAY_I classid=<%=Util.CLSID_LUXECOMBO%> width=143
                                    tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="point">통합발행구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_COMBINE_ISSUE_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">지불시기구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_PAY_HOLI_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="point">반올림구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_ROUND_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">POS정산구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_POS_CAL_FLAG_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>은행코드</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_BANK_CD_I classid=<%=Util.CLSID_LUXECOMBO%> width=143
                                    tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th>입금계좌</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_BANK_ACC_NO_I classid=<%=Util.CLSID_EMEDIT%>
                                    width=140 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>예금주</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_ACC_NO_OWN_I classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th class="point">사용여부</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_USE_YN_I2 classid=<%=Util.CLSID_LUXECOMBO%> width=143
                                    tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="point">EDI사용여부</th>
                                <td ><comment id="_NSID_"> <object
                                    id=LC_EDI_YN_I classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1
                                    width=143 align="left"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th >판매장려금적용율</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_SBNS_CAL_RATE_I2 classid=<%=Util.CLSID_EMEDIT%> width=143
                                    tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="point">거래시작일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_BIZ_S_DT_I2 classid=<%=Util.CLSID_EMEDIT%> width=118
                                    tabindex=1 align="center"> </object> </comment> <script> _ws_(_NSID_);</script>
                                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                    class="PR03" onclick="javascript: if(EM_BIZ_S_DT_I2.Enable) openCal('G',EM_BIZ_S_DT_I2)" />
                                </td>
                                <th class="point">거래종료일</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_BIZ_E_DT_I2 classid=<%=Util.CLSID_EMEDIT%> width=118
                                    tabindex=1 align="center"> </object> </comment> <script> _ws_(_NSID_);</script>
                                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                    class="PR03" onclick="javascript:openCal('G',EM_BIZ_E_DT_I2)" />
                                </td>
                            </tr>
                            <tr>
                                <th id="ADMINEXP_P" style="display:"  class="point">일반관리비청구구분</th>
                                <th id="ADMINEXP" style="display:none">일반관리비청구구분</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_ADMIN_EXP_USE_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <th id="CARDFEE_P" style="display:"  class="point">카드수수료부담</th>
                                <th id="CARDFEE" style="display:none">카드수수료부담</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_CARD_FEE_I classid=<%=Util.CLSID_LUXECOMBO%>
                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
	                            <th class="point"><b>회계전표발행방법"/n"(기본값인 개별발행브랜드별로 입력하세요.)</b></th>
	                                <td><comment id="_NSID_"> <object
	                                    id=LC_DZ_SLP_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
	                                    width=143 tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
	                                </td>
	                                
	                            <th width="100" >재무거래선코드</th>
									<td><comment id="_NSID_"> <object
										id=EM_ACC_VEN_CD_I classid=<%=Util.CLSID_EMEDIT%> width=140
										tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script>
									</td>       
	                                
                            </tr>
                        </table>
                        </td>
                        
                    </tr>
                    
                    <tr>
                        <td class="PT03">
                        <table width="55%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                            <tr>
                                <th width="100" style="text-align:center;">POS종류</th>
                                <th width="100" style="text-align:center;" >대수</th>
                                <th width="150" style="text-align:center;" >보증금</th>
                                <th style="text-align:center;">사용료(VAT별도)</th>
                            </tr>
                            <tr>
                                <th>대면POS</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_VIEW_POS_CNT_I classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_VIEW_POS_DEPOSIT_I classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_VIEW_POS_RENT_I classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>F&B POS</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_FB_POS_CNT_I classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_FB_POS_DEPOSIT_I classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_FB_POS_RENT_I classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>MINI POS</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MINI_POS_CNT_I classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MINI_POS_DEPOSIT_I classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MINI_POS_RENT_I classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>PDA POS</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_PDA_POS_CNT_I classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_PDA_POS_DEPOSIT_I classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_PDA_POS_RENT_I classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>돈통</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MON_POS_CNT_I classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MON_POS_DEPOSIT_I classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MON_POS_RENT_I classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1 align="left">
                                    </object> </comment> <script> _ws_(_NSID_);</script>
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
									align="absmiddle" /> 협력사 담당자 정보</td>
								<td class="right PB02" valign="bottom"><img
									src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
									onclick="javascript:btn_Add2();" hspace="2" /><img
									src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
									onclick="javascript:btn_Del2();" /></td>
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
<!-- 			                  <tr class="PT10"> -->
<!-- 			                    <td class="FS11 red">※ EDI 사용 업체의 경우 EDI담당자 정보가 있어야 EDI 사용자 정보 SMS 전송이 가능 합니다. -->
<!-- 			                    </td> -->
<!-- 			                  </tr> -->
<!-- 			                  <tr class="PT05"> -->
<!-- 			                    <td class="FS11 red">※ 스마일EDI 사용 업체의 경우 정산 담당자 정보가 있어야 전자세금계산서 처리가 가능 합니다. -->
<!-- 			                    </td> -->
<!-- 			                  </tr> -->
						</table>
						</td>
					</tr>
				</table>
				</div>
                </td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
			<td>
			<pre><h4>
			※ 주의사항
			거래구분 임대을 일시 임대협력사명판관리  화면에서 협력사를 등록해야합니다.
			</h4></pre>
			
			</td>
		</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_"> <object id=BO_MASTER	classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=VEN_CD               Ctrl=EM_VEN_CD_I                param=Text</c>
        <c>Col=VEN_NAME             Ctrl=EM_VEN_NAME_I              param=Text</c>
        <c>Col=VEN_SHORT_NAME       Ctrl=EM_VEN_SHORT_NAME_I        param=Text</c>
        <c>Col=BUY_SALE_FLAG        Ctrl=LC_BUY_SALE_FLAG_I         param=BindColVal</c>
        <c>Col=BIZ_TYPE             Ctrl=LC_BIZ_TYPE_I              param=BindColVal</c>
        <c>Col=BIZ_FLAG             Ctrl=LC_BIZ_FLAG_I              param=BindColVal</c>
        <c>Col=BUY_ACC_VEN_CD       Ctrl=EM_BUY_ACC_VEN_CD_I        param=Text</c>
        <c>Col=REP_VEN_CD           Ctrl=EM_REP_VEN_CD_I            param=Text</c>
        <c>Col=REP_VEN_NAME         Ctrl=EM_REP_VEN_NAME_I          param=Text</c>
        <c>Col=COMP_FLAG            Ctrl=LC_COMP_FLAG_I             param=BindColVal</c>
        <c>Col=USE_YN               Ctrl=LC_USE_YN_I                param=BindColVal</c>
        <c>Col=BIZ_S_DT             Ctrl=EM_BIZ_S_DT_I              param=Text</c>
        <c>Col=BIZ_E_DT             Ctrl=EM_BIZ_E_DT_I              param=Text</c>
        <c>Col=COMP_NO              Ctrl=EM_COMP_NO_I               param=Text</c>
        <c>Col=CORP_NO              Ctrl=EM_CORP_NO_I               param=Text</c>
        <c>Col=COMP_NAME            Ctrl=EM_COMP_NAME_I             param=Text</c>
        <c>Col=REP_NAME             Ctrl=EM_REP_NAME_I              param=Text</c>
        <c>Col=BIZ_STAT             Ctrl=EM_BIZ_STAT_I              param=Text</c>
        <c>Col=BIZ_CAT              Ctrl=EM_BIZ_CAT_I               param=Text</c>
        <c>Col=POST_NO              Ctrl=EM_POST_NO_I               param=Text</c>
        <c>Col=ADDR                 Ctrl=EM_ADDR_I                  param=Text</c>
        <c>Col=DTL_ADDR             Ctrl=EM_DTL_ADDR_I              param=Text</c>
        <c>Col=PHONE1_NO            Ctrl=EM_PHONE1_NO_I             param=Text</c>
        <c>Col=PHONE2_NO            Ctrl=EM_PHONE2_NO_I             param=Text</c>
        <c>Col=PHONE3_NO            Ctrl=EM_PHONE3_NO_I             param=Text</c>
        <c>Col=FAX1_NO              Ctrl=EM_FAX1_NO_I               param=Text</c>
        <c>Col=FAX2_NO              Ctrl=EM_FAX2_NO_I               param=Text</c>
        <c>Col=FAX3_NO              Ctrl=EM_FAX3_NO_I               param=Text</c>
        '>
</object> </comment><script>_ws_(_NSID_);</script> 
<!-- MARIO OUTLET START -->
<!-- 
        <c>Col=SAP_DEL_FLAG         Ctrl=LC_SAP_DEL_HOLD            param=BindColVal</c>
 -->
<!-- MARIO OUTLET START -->


 <comment id="_NSID_"> <object id=BO_DETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=STR_CD               Ctrl=LC_STR_CD_I            param=BindColVal</c>
        <c>Col=PAY_CYC              Ctrl=LC_PAY_CYC_I           param=BindColVal</c>
        <c>Col=PAY_DT_FLAG          Ctrl=LC_PAY_DT_FLAG_I       param=BindColVal</c>
        <c>Col=PAY_WAY              Ctrl=LC_PAY_WAY_I           param=BindColVal</c>
        <c>Col=TAX_ITG_ISSUE_FLAG   Ctrl=LC_COMBINE_ISSUE_FLAG_I  param=BindColVal</c>
        <c>Col=PAY_HOLI_FLAG        Ctrl=LC_PAY_HOLI_FLAG_I     param=BindColVal</c>
        <c>Col=ROUND_FLAG           Ctrl=LC_ROUND_FLAG_I        param=BindColVal</c>
        <c>Col=POS_CAL_FLAG         Ctrl=LC_POS_CAL_FLAG_I      param=BindColVal</c>
        <c>Col=BANK_CD              Ctrl=LC_BANK_CD_I           param=BindColVal</c>
        <c>Col=BANK_ACC_NO          Ctrl=EM_BANK_ACC_NO_I       param=Text</c>
        <c>Col=ACC_NO_OWN           Ctrl=EM_ACC_NO_OWN_I        param=Text</c>
        <c>Col=EDI_YN               Ctrl=LC_EDI_YN_I            param=BindColVal</c>
        <c>Col=USE_YN               Ctrl=LC_USE_YN_I2           param=BindColVal</c>
        <c>Col=BIZ_S_DT             Ctrl=EM_BIZ_S_DT_I2         param=Text</c>
        <c>Col=BIZ_E_DT             Ctrl=EM_BIZ_E_DT_I2         param=Text</c>
        <c>Col=MNTN_CHRG_FLAG       Ctrl=LC_ADMIN_EXP_USE_I     param=BindColVal</c>
        <c>Col=CARD_FEE_CHRG        Ctrl=LC_CARD_FEE_I          param=BindColVal</c>
        <c>Col=DZ_SLP_FLAG          Ctrl=LC_DZ_SLP_FLAG         param=BindColVal</c>
        <c>col=SBNS_CAL_RATE        ctrl=EM_SBNS_CAL_RATE_I2    param=Text </c>
        <c>Col=POS_USEQTY_1         Ctrl=EM_VIEW_POS_CNT_I      param=Text</c>
        <c>Col=POS_DEPOSIT_1        Ctrl=EM_VIEW_POS_DEPOSIT_I  param=Text</c>
        <c>Col=POS_USEFEE_1         Ctrl=EM_VIEW_POS_RENT_I     param=Text</c>
        <c>Col=POS_USEQTY_2         Ctrl=EM_FB_POS_CNT_I        param=Text</c>
        <c>Col=POS_DEPOSIT_2        Ctrl=EM_FB_POS_DEPOSIT_I    param=Text</c>
        <c>Col=POS_USEFEE_2         Ctrl=EM_FB_POS_RENT_I       param=Text</c>
        <c>Col=POS_USEQTY_3         Ctrl=EM_MINI_POS_CNT_I      param=Text</c>
        <c>Col=POS_DEPOSIT_3        Ctrl=EM_MINI_POS_DEPOSIT_I  param=Text</c>
        <c>Col=POS_USEFEE_3         Ctrl=EM_MINI_POS_RENT_I     param=Text</c>
        <c>Col=POS_USEQTY_4         Ctrl=EM_PDA_POS_CNT_I       param=Text</c>
        <c>Col=POS_DEPOSIT_4        Ctrl=EM_PDA_POS_DEPOSIT_I   param=Text</c>
        <c>Col=POS_USEFEE_4         Ctrl=EM_PDA_POS_RENT_I      param=Text</c>
        <c>Col=POS_USEQTY_5         Ctrl=EM_MON_POS_CNT_I       param=Text</c>
        <c>Col=POS_DEPOSIT_5        Ctrl=EM_MON_POS_DEPOSIT_I   param=Text</c>
        <c>Col=POS_USEFEE_5         Ctrl=EM_MON_POS_RENT_I      param=Text</c>
        <c>Col=ACC_VEN_CD           Ctrl=EM_ACC_VEN_CD_I        param=Text</c>
        '>
</object> </comment><script>_ws_(_NSID_);</script> 
</body>
</html>

