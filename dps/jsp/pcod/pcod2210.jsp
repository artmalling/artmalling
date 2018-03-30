<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 브랜드코드> 브랜드관리
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 브랜드정보 및 점별 브랜드 정보, 브랜드별 담당자 정보를 관리한다.
 * 이    력 :
 *        2010.01.17 (정진영) 신규작성
 *        20120507 * DHL * 수정 * 브랜드별 품목 등록시 비단품일때 대중소세 품목 등록
 *                                협력사매장관리형태 속성 추가
 *                                층 앞에 관 항목 추가
 *        20120618 * DHL * 수정 * 입대갑 등록 가능
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>

<%String jumbrand = "점별브랜드정보"; %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfMasterRowPosition = 0;
 var btnSaveClick = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	
	//탭초기화
	initTab('TAB_MAIN');
	    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_PBNPMK.setDataHeader('<gauce:dataset name="H_SEL_PBNPMK"/>');
    DS_STRPBN.setDataHeader('<gauce:dataset name="H_SEL_STRPBN"/>');
    DS_PBNVENEMP.setDataHeader('<gauce:dataset name="H_SEL_PBNVENEMP"/>');
    
    DS_I_PBN_COND.setDataHeader(
            'BIZ_TYPE:STRING(1)'
            +',SKU_FLAG:STRING(1)'
            +',PUMBUN_TYPE:STRING(1)'
            +',PUMBUN_FLAG:STRING(1)'
            +',SKU_TYPE:STRING(1)'
            +',USE_YN:STRING(1)'
            +',REC_PUMBUN:STRING(6)'
            +',VEN_CD:STRING(6)'
            +',VEN_NAME:STRING(40)'
            +',PUMBUN_CD:STRING(6)'
            +',PUMBUN_NAME:STRING(40)'
            +',STATUS:STRING(40)');
    DS_I_PBN_COND.ClearData();
    DS_I_PBN_COND.Addrow();

    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //점별 브랜드 정보
    gridCreate3(); //브랜드 담당자 정보
    gridCreate4(); //관리품목

    // EMedit에 초기화
    initEmEdit(EM_O_REC_PUMBUN, "CODE^6^0", NORMAL);  //대표브랜드(조회)
    initEmEdit(EM_O_REC_PUMBUN_NM, "GEN^40", READ);   //대표브랜드(조회)
    initEmEdit(EM_O_VEN, "CODE^6^0", NORMAL);         //협력사(조회)
    initEmEdit(EM_O_VEN_NM, "GEN^40", NORMAL);        //협력사(조회)
    initEmEdit(EM_O_PUMBUN, "CODE^6^0", NORMAL);      //브랜드(조회)
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", NORMAL);     //브랜드(조회)
    initEmEdit(EM_SP_E_MAIL, "GEN^40", PK);       //이메일
    initEmEdit(EM_I_PUMBUN_CD, "CODE^6^0", READ);     //브랜드코드 
    initEmEdit(EM_I_PUMBUN_NM, "GEN^40", PK);         //브랜드명
    initEmEdit(EM_I_RECP_NM, "GEN^20", PK);           //영수증명 
    initEmEdit(EM_I_VEN, "CODE^6^0", PK);             //협력사
    initEmEdit(EM_I_VEN_NM, "GEN^40", READ);          //협력사
    initEmEdit(EM_I_REC_PUMBUN, "CODE^6^0", NORMAL);  //대표브랜드
    initEmEdit(EM_I_REC_PUMBUN_NM, "GEN^40", READ);   //대표브랜드
    initEmEdit(EM_I_BRAND, "CODE^5", NORMAL);         //브랜드
    initEmEdit(EM_I_BRAND_NM, "GEN^40", READ);        //브랜드
    initEmEdit(EM_I_APP_S_DT, "YYYYMMDD", PK);        //적용시작일 
    initEmEdit(EM_I_APP_E_DT, "YYYYMMDD", PK);        //적용종료일
    
    ////initEmEdit(EM_SP_BUY_ORG_CD    ,"CODE^10", PK);  // MARIO OUTLET
    initEmEdit(EM_SP_BUY_ORG_CD    ,"CODE^10", PK);
    initEmEdit(EM_SP_BUY_ORG_NM    ,"GEN^40", READ);
    initEmEdit(EM_SP_CHAR_BUYER_NM ,"GEN^40", READ);
    initEmEdit(EM_SP_SALE_ORG_CD   ,"CODE^10", PK);
    initEmEdit(EM_SP_SALE_ORG_NM   ,"GEN^40", READ);
    initEmEdit(EM_SP_CHAR_SM_NM    ,"GEN^40", READ);
    initEmEdit(EM_SP_LOW_MG_RATE   ,"NUMBER^3^2", PK);
    
    initEmEdit(EM_TEL_NO1   ,"CODE^4^0", PK);
    initEmEdit(EM_TEL_NO2   ,"CODE^4^0", PK);
    initEmEdit(EM_TEL_NO3   ,"CODE^4^0", PK);
    
    
    initEmEdit(EM_SP_AREA_SIZE     ,"NUMBER^5^2", PK);
    initEmEdit(EM_SP_APP_S_DT      ,"YYYYMMDD", PK);
    initEmEdit(EM_SP_APP_E_DT      ,"YYYYMMDD", PK);
    
    EM_SP_LOW_MG_RATE.NumericRange = "0~+:0"; 
    
    EM_SP_AREA_SIZE.NumericRange = "0~+:0";

    //콤보 초기화


    initComboStyle(LC_O_BIZ_TYPE,DS_O_BIZ_TYPE, "CODE^0^30,NAME^0^90", 1, NORMAL);       //거래형태(조회)
    initComboStyle(LC_O_SKU_FLAG,DS_O_SKU_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);       //단품구분(조회)
    initComboStyle(LC_O_PUMBUN_TYPE,DS_O_PUMBUN_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL); //브랜드유형(조회)
    initComboStyle(LC_O_PUMBUN_FLAG,DS_O_PUMBUN_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL); //브랜드구분(조회)
    initComboStyle(LC_O_SKU_TYPE,DS_O_SKU_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);       //단품종류(조회)
    initComboStyle(LC_O_USE_YN,DS_O_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);           //사용여부(조회)
    initComboStyle(LC_I_TAX_FLAG,DS_I_TAX_FLAG, "CODE^0^30,NAME^0^110", 1, PK);          //과세구분 
    initComboStyle(LC_I_PUMBUN_FLAG,DS_I_PUMBUN_FLAG, "CODE^0^30,NAME^0^110", 1, PK);    //브랜드구분 
    initComboStyle(LC_I_PUMBUN_TYPE,DS_I_PUMBUN_TYPE, "CODE^0^30,NAME^0^110", 1, PK);    //브랜드유형
    initComboStyle(LC_I_SKU_FLAG,DS_I_SKU_FLAG, "CODE^0^30,NAME^0^110", 1, PK);          //단품구분 
    initComboStyle(LC_I_SKU_TYPE,DS_I_SKU_TYPE, "CODE^0^30,NAME^0^110", 1, PK);          //단품종류
    initComboStyle(LC_I_STYLE_TYPE,DS_I_STYLE_TYPE, "CODE^0^30,NAME^0^110", 1, PK);      //의류단품코드구분
    initComboStyle(LC_I_ITG_ORD_FLAG,DS_I_ITG_ORD_FLAG, "CODE^0^30,NAME^0^110", 1, PK);  //통합발주여부
    initComboStyle(LC_I_USE_YN,DS_I_USE_YN, "CODE^0^30,NAME^0^110", 1, PK);              //사용여부
    initComboStyle(LC_I_BIZ_TYPE,DS_I_BIZ_TYPE, "CODE^0^30,NAME^0^110", 1, READ);        //거래형태
    
    initComboStyle(LC_SP_STR_CD           , DS_SP_STR_CD           , "CODE^0^30,NAME^0^160", 1, PK);
    initComboStyle(LC_SP_SALE_BUY_FLAG    , DS_SP_SALE_BUY_FLAG    , "CODE^0^30,NAME^0^160", 1, PK);
    initComboStyle(LC_SP_SLIDING_FLAG     , DS_SP_SLIDING_FLAG     , "CODE^0^30,NAME^0^160", 1, PK); // MARIO OUTLET
    
    initComboStyle(LC_SP_CHK_YN           , DS_SP_CHK_YN           , "CODE^0^30,NAME^0^80", 1, PK);
    //initComboStyle(LC_SP_COST_CAL_WAY  , DS_SP_COST_CAL_WAY  , "CODE^0^30,NAME^0^160", 1, PK);
    initComboStyle(LC_SP_ADV_ORD_YN       , DS_SP_ADV_ORD_YN       , "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_SP_EVALU_YN         , DS_SP_EVALU_YN         , "CODE^0^30,NAME^0^160", 1, PK);
    initComboStyle(LC_SP_USE_YN           , DS_SP_USE_YN           , "CODE^0^30,NAME^0^160", 1, PK);
    initComboStyle(LC_SP_PUSE_YN          , DS_SP_USE_YN           , "CODE^0^30,NAME^0^160", 1, PK);
    initComboStyle(LC_SP_RENTB_MGAPP_FLAG , DS_SP_RENTB_MGAPP_FLAG , "CODE^0^30,NAME^0^160", 1, PK);
    
    initComboStyle(LC_SP_FLOR_CD          , DS_SP_FLOR_CD          , "CODE^0^30,NAME^0^80", 1, PK);

    // 20120507 * DHL 추가 --> 
    initComboStyle(LC_SP_HALL_CD          , DS_SP_HALL_CD          , "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_SP_VEN_MNG_FLAG     , DS_SP_VEN_MNG_FLAG     , "CODE^0^30,NAME^0^160", 1, PK);
    // 20120507 * DHL 추가 <--
 	
    initComboStyle(LC_SP_EDI_YN        , DS_SP_EDI_YN        , "CODE^0^30,NAME^0^80", 1, PK);  //EDI사용여부
    LC_I_PUMBUN_TYPE.ListCount        = 11;  //브랜드 유형 리스트 표시 갯수 조정
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
 	// 20120618 * DHL * 수정 * 입대갑 등록 가능 -->
    // 원본
    // getEtcCode("DS_O_BIZ_TYPE", "D", "P002", "Y");
    // 수정
    getEtcCode("DS_O_BIZ_TYPE", "D", "P003", "Y");
    // 20120618 * DHL * 수정 * 입대갑 등록 가능 <--
    getEtcCode("DS_O_SKU_FLAG", "D", "P014", "Y");
    getEtcCode("DS_O_PUMBUN_TYPE", "D", "P070", "Y");
    getEtcCode("DS_O_PUMBUN_FLAG", "D", "P069", "Y");    
    getEtcCode("DS_O_SKU_TYPE", "D", "P015", "Y");
    getEtcCode("DS_O_USE_YN", "D", "D022", "Y");
    
    getEtcCode("DS_I_TAX_FLAG", "D", "P004", "N");    
    getEtcCode("DS_I_PUMBUN_FLAG", "D", "P069", "N");
    getEtcCode("DS_I_PUMBUN_TYPE", "D", "P070", "N");
    getEtcCode("DS_I_SKU_FLAG", "D", "P014", "N");    
    getEtcCode("DS_I_SKU_TYPE", "D", "P015", "N");
    getEtcCode("DS_I_STYLE_TYPE", "D", "P042", "n");
    getEtcCode("DS_I_ITG_ORD_FLAG", "D", "D022", "N");    
    getEtcCode("DS_I_USE_YN", "D", "D022", "N");
 	// 20120618 * DHL * 수정 * 입대갑 등록 가능 -->
    // 원본
    // getEtcCode("DS_I_BIZ_TYPE", "D", "P002", "N");
    // 수정
    getEtcCode("DS_I_BIZ_TYPE", "D", "P003", "N");
    // 20120618 * DHL * 수정 * 입대갑 등록 가능 <--   
    getEtcCode("DS_SP_EDI_YN", "D", "D022", "N");
    
    getEtcCode("DS_SP_CHK_YN", "D", "D022", "N");    
    getEtcCode("DS_SP_ADV_ORD_YN", "D", "D022", "N");
    getEtcCode("DS_SP_EVALU_YN", "D", "D022", "N");
    getEtcCode("DS_SP_USE_YN", "D", "D022", "N");
    getEtcCode("DS_SP_SALE_BUY_FLAG", "D", "P067", "N");
    getEtcCode("DS_SP_SLIDING_FLAG", "D", "P199", "N"); //MARIO OUTLET
    
    //getEtcCode("DS_SP_COST_CAL_WAY", "D", "P039", "N");    
    getEtcCode("DS_SP_RENTB_MGAPP_FLAG", "D", "P086", "N");
    
    getEtcCode("DS_SP_FLOR_CD",  "D", "P061", "N");
    getEtcCode("DS_I_TAG_FLAG", "D", "P063", "N");
    getEtcCode("DS_I_TAG_PRT_OWN_FLAG", "D", "P064", "N");
    getEtcCode("DS_I_PBNPMK_USE_YN", "D", "D022", "N");    
    getEtcCode("DS_I_VEN_TASK_FLAG", "D", "P075", "N");
    getEtcCode("DS_I_PBNVENEMP_USE_YN", "D", "D022", "N");
    
    // 20120507 * DHL 추가 --> 
    getEtcCode("DS_SP_HALL_CD",  "D", "P197", "N");
    getEtcCode("DS_SP_VEN_MNG_FLAG",  "D", "P196", "N");
    // 20120507 * DHL 추가 <--
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_BIZ_TYPE,"%");
    setComboData(LC_O_SKU_FLAG,"%");
    setComboData(LC_O_PUMBUN_TYPE,"%");
    setComboData(LC_O_PUMBUN_FLAG,"%");
    setComboData(LC_O_SKU_TYPE,"%");
    setComboData(LC_O_USE_YN,"Y");

    mainPummokUpdate('R');
    
    //결과표시 초기화
    setPorcCount("CLEAR");
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod221","DS_MASTER,DS_PBNPMK,DS_STRPBN,DS_PBNVENEMP" );
    
    LC_O_BIZ_TYPE.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width=30   align=center</FC>'
                     + '<FG>                name="브랜드" '
                     + '<FC>id=PUMBUN_CD    name="코드"     width=55   align=center</FC>'
                     + '<FC>id=PUMBUN_NAME  name="명"       width=130  align=left</FC>'
                     + '</FG>'
                     + '<FG>                name="협력사" '
                     + '<FC>id=VEN_CD       name="코드"     width=55   align=center</FC>'
                     + '<FC>id=VEN_NAME     name="명"       width=150  align=left</FC>'
                     + '</FG>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=STR_CD      name="*점"     width=90   align=left  edit=none EditStyle=Lookup  Data="DS_SP_STR_CD:CODE:NAME" </FC>'
                     // 20120507 * DHL 추가  -->
                     + '<FC>id=VEN_MNG_FLAG    name="협력사관리"     width=100   align=left  edit=none EditStyle=Lookup  Data="DS_SP_VEN_MNG_FLAG:CODE:NAME" </FC>'
                     // 20120507 * DHL 추가  <--
                     + '<FC>id=BUY_ORG_NM    name="*매입조직"       width=80  align=left edit=none</FC>'
                     + '<FC>id=CHAR_BUYER_NM    name="바이어"     width=80   align=left edit=none</FC>'
                     + '<FC>id=SALE_ORG_NM      name="*판매조직"     width=80   align=left edit=none</FC>'
                     + '<FC>id=CHAR_SM_NM    name="SM"       width=80  align=left edit=none</FC>'
                     + '<FC>id=SALE_BUY_FLAG    name="*판매분매입구분"       width=95  align=left   edit=none EditStyle=Lookup  Data="DS_SP_SALE_BUY_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=CHK_YN    name="*검품여부"     width=70   align=left edit=none</FC>'
                     //+ '<FC>id=COST_CAL_WAY    name="*원가산정방법"     width=90   align=left  edit=none EditStyle=Lookup  Data="DS_SP_COST_CAL_WAY:CODE:NAME" </FC>'
                     + '<FC>id=RENTB_MGAPP_FLAG    name="임대B수수료구분"     width=100   align=left  edit=none EditStyle=Lookup  Data="DS_SP_RENTB_MGAPP_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=LOW_MG_RATE    name="*최저마진율"       width=90  align=right edit=none</FC>'
                     //+ '<FC>id=SBNS_CAL_RATE    name="판매장려금적용율"     width=120   align=right edit=none</FC>'
                     // 20120507 * DHL 추가  -->
                     + '<FC>id=HALL_CD     name="*관"     width=100   align=left  edit=none EditStyle=Lookup  Data="DS_SP_HALL_CD:CODE:NAME" </FC>'
                     // 20120507 * DHL 추가  <--
                     + '<FC>id=FLOR_CD     name="*층"     width=100   align=left  edit=none EditStyle=Lookup  Data="DS_SP_FLOR_CD:CODE:NAME" </FC>'
                     + '<FC>id=AREA_SIZE      name="면적"     width=70   align=right edit=none</FC>'
                     + '<FC>id=ADV_ORD_YN    name="권고발주여부"     width=90   align=left edit=none</FC>'
                     + '<FC>id=EVALU_YN    name="*평가대상여부"     width=90   align=left edit=none</FC>'
                     + '<FC>id=APP_S_DT    name="*적용시작일"       width=90 mask="XXXX/XX/XX" align=center edit=none</FC>'
                     + '<FC>id=APP_E_DT    name="*적용종료일"       width=90 mask="XXXX/XX/XX"  align=center edit=none</FC>'/
                     + '<FC>id=USE_YN    name="*사용여부"     width=70   align=left edit=none</FC>';

    initGridStyle(GD_STRPBN, "common", hdrProperies, false);
}
function gridCreate3(){
    var hdrProperies = '<FC>id={currow}       name="NO"          width=30   align=center</FC>'
                     + '<FC>id=VEN_TASK_FLAG  name="*업무구분"      edit={IF(FLAG=1,"false","true")}    width=70   align=left EditStyle=Lookup  Data="DS_I_VEN_TASK_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=CHAR_NAME      name="*담당자명"      edit={IF(FLAG=1,"false","true")} width=70  align=left</FC>'
                     + '<FG>name="전화번호"  '
                     + '<FC>id=PHONE1_NO      name="지역"         Edit="Numeric" edit={IF(FLAG=1,"false","true")}   width=55   align=left</FC>'
                     + '<FC>id=PHONE2_NO      name="앞자리"   		 Edit="Numeric" edit={IF(FLAG=1,"false","true")}  width=55   align=left</FC>'
                     + '<FC>id=PHONE3_NO      name="뒷자리"       Edit="Numeric" edit={IF(FLAG=1,"false","true")}  width=55   align=left</FC>'
                     + '</FG>'
                     + '<FG>name="휴대전화"  '
                     + '<FC>id=HP1_NO         name="통신사"   	    Edit="Numeric" edit={IF(FLAG=1,"false","true")}  width=55   align=left</FC>'
                     + '<FC>id=HP2_NO         name="앞자리"       Edit="Numeric" edit={IF(FLAG=1,"false","true")}  width=55   align=left</FC>'
                     + '<FC>id=HP3_NO         name="뒷자리"       Edit="Numeric"  edit={IF(FLAG=1,"false","true")}  width=55   align=left</FC>'
                     + '</FG>'
                     + '<FC>id=EMAIL          name="이메일"        width=140 edit={IF(FLAG=1,"false","true")} edit="AlphaEtc" align=left</FC>'
                     + '<FC>id=SMEDI_ID       name="스마일 EDI ID"  width=100   edit={IF(FLAG=1,"false","true")}  edit="AlphaNum"  align=left show=false</FC>'
                     + '<FC>id=USE_YN         name="*사용여부"      width=70  edit={IF(FLAG=1,"false","true")} align=left EditStyle=Lookup  Data="DS_I_PBNVENEMP_USE_YN:CODE:NAME" </FC>';

    initGridStyle(GD_PBNVENEMP, "common", hdrProperies, true);
}
function gridCreate4(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width=25   align=center</FC>'
                     + '<FC>id=PUMMOK_CD    name="*품목"     width=83   align=center EditStyle=Popup edit="AlphaNum" </FC>'
                     + '<FC>id=PUMMOK_NAME  name="품목명"    width=87  align=left edit=none</FC>'
                     + '<FC>id=PUMMOK_SRT_CD  name="단축코드"     width=60   align=center edit=none</FC>'
                     + '<FC>id=TAG_FLAG      name="*택구분"     width=85   align=left  EditStyle=Lookup  Data="DS_I_TAG_FLAG:CODE:NAME" show=true edit=none </FC>'
                     + '<FC>id=TAG_PRT_OWN_FLAG  name="*택발행주체"     width=70   align=left EditStyle=Lookup  Data="DS_I_TAG_PRT_OWN_FLAG:CODE:NAME" show=false </FC>'
                     + '<FC>id=USE_YN    name="*사용여부"       width=63  align=left EditStyle=Lookup  Data="DS_I_PBNPMK_USE_YN:CODE:NAME" </FC>';

    initGridStyle(GD_PBNPMK, "common", hdrProperies, true);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if( DS_MASTER.IsUpdated || DS_PBNPMK.IsUpdated || DS_PBNVENEMP.IsUpdated || DS_STRPBN.IsUpdated){
         if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
        	 if( DS_MASTER.IsUpdated ||DS_PBNPMK.IsUpdated){
        		 setTabItemIndex("TAB_MAIN",1);
                 EM_I_PUMBUN_NM.Focus();
        	 }else if( DS_STRPBN.IsUpdated){
                 setTabItemIndex("TAB_MAIN",2);
                 EM_SP_BUY_ORG_CD.Focus();
        	 }else{
                 setTabItemIndex("TAB_MAIN",3);
                 GD_PBNVENEMP.Focus();
        	 }
             return;               
         }
		 
	}
	mainPummokUpdate('R');
    bfMasterRowPosition = 0;
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	var rowStatus = DS_MASTER.RowStatus(DS_MASTER.RowPosition);
	
	if(rowStatus != '1'){
	    if( DS_PBNPMK.IsUpdated || DS_PBNVENEMP.IsUpdated || DS_STRPBN.IsUpdated){
	    	// 변경된 상세내역이 존재합니다. 신규 추가하시겠습니까?
	    	if( showMessage(QUESTION, YESNO, "USER-1050") != 1){ 
	    	    setTabItemIndex('TAB_MAIN',1);
	    	    EM_I_PUMBUN_NM.Focus();
	    		return;
	    	}
	    }  
	           
	}else{
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1){
            setTabItemIndex('TAB_MAIN',1);
            EM_I_PUMBUN_NM.Focus();
            return;             	
        }
        DS_MASTER.DeleteRow(DS_MASTER.CountRow);
	}
    DS_PBNPMK.ClearData();
    DS_PBNVENEMP.ClearData();
    DS_STRPBN.ClearData();  
	DS_MASTER.addRow();
    DS_MASTER.NameValue(DS_MASTER.CountRow,"USE_YN") = "Y";
    //DS_MASTER.NameValue(DS_MASTER.CountRow,"APP_S_DT") = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
    DS_MASTER.NameValue(DS_MASTER.CountRow,"APP_S_DT") = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
    DS_MASTER.NameValue(DS_MASTER.CountRow,"APP_E_DT") = "99991231";
    setTabItemIndex('TAB_MAIN',1);
    
    EM_I_PUMBUN_NM.Focus();
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	var dtlSaveFlag = "";
	var pumbunCode = "";
    var pumbunName = "";
    var strCd = "";
    bfMasterRowPosition = 0;
    if(DS_MASTER.IsUpdated){
        if( !checkPbnmstValidation() )
            return;

        // 마감체크 (common.js)
        if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
            showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
            EM_I_PUMBUN_NM.Focus();
            return;
        }
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        	setTabItemIndex("TAB_MAIN",1);
        	EM_I_PUMBUN_NM.Focus();
            return;
        }
        
        pumbunCode = DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_CD");
        pumbunName = DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_NAME");
        btnSaveClick = true;
        TR_MAIN.Action="/dps/pcod221.pc?goTo=savePbnmst";
        TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
        TR_MAIN.Post();
        btnSaveClick = false;
        
    }else{
    	
    	if( !DS_STRPBN.IsUpdated 
    		&& !DS_PBNVENEMP.IsUpdated 
    		&& !DS_PBNPMK.IsUpdated ){
    		//저장할 내용이 없습니다.
    		showMessage(INFORMATION, OK, "USER-1028");
            setTabItemIndex('TAB_MAIN',1);
    		if(DS_MASTER.CountRow < 1){
    			LC_O_BIZ_TYPE.Focus();
    			return;
    		}
    		GD_MASTER.Focus();
    		return;
    	}

        var strPumbunCd = DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_CD");
        var strPumbunName = DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_NAME");
        var strRecpName = DS_MASTER.NameValue(DS_MASTER.RowPosition, "RECP_NAME");
        var strVenCd = DS_MASTER.NameValue(DS_MASTER.RowPosition, "VEN_CD");
        var strBizType = DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_TYPE");
        var strBizFlag = DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_FLAG");
        var strPumbunType = DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_TYPE");
        var strSkuFlag = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SKU_FLAG");
        var strSkuType = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SKU_TYPE");
        var strStyleType = DS_MASTER.NameValue(DS_MASTER.RowPosition, "STYLE_TYPE");
        if( strPumbunCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","브랜드가 존재하지 않습니다.");
        	return;
        }
        if( !checkPbnpmkValidation() )
            return;
        if( !checkStrpbnValidation() )
            return;
        if( !checkPbnvenempValidation() )
            return;
        
        if(DS_STRPBN.IsUpdated ){
        	dtlSaveFlag = "STR";
        }else if(DS_PBNVENEMP.IsUpdated){
            dtlSaveFlag = "EMP";
        }else if(DS_PBNPMK.IsUpdated ){
            dtlSaveFlag = "PMK";
        }

        // 마감체크 (common.js)
        if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
            showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
            EM_I_PUMBUN_NM.Focus();
            return;
        }
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        	if(dtlSaveFlag == "STR" ){
                setTabItemIndex("TAB_MAIN",2);
                EM_SP_BUY_ORG_CD.Focus();        		
        	}else if(dtlSaveFlag == "EMP"){
                setTabItemIndex("TAB_MAIN",3);
                GD_PBNVENEMP.Focus(); 
        	}else{
                setTabItemIndex("TAB_MAIN",1);
                GD_PBNPMK.Focus();
        	}
            return;
        }
        
        pumbunCode = strPumbunCd;
        pumbunName = strPumbunName;
        var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                       + "&strPumbunName="+encodeURIComponent(strPumbunName)
                       + "&strRecpName="+encodeURIComponent(strRecpName)
                       + "&strVenCd="+encodeURIComponent(strVenCd)
                       + "&strBizType="+encodeURIComponent(strBizType)
                       + "&strBizFlag="+encodeURIComponent(strBizFlag)
                       + "&strPumbunType="+encodeURIComponent(strPumbunType)
                       + "&strSkuFlag="+encodeURIComponent(strSkuFlag)
                       + "&strSkuType="+encodeURIComponent(strSkuType)
                       + "&strStyleType="+encodeURIComponent(strStyleType);
        btnSaveClick = true;
        TR_MAIN.Action="/dps/pcod221.pc?goTo=saveDetail"+parameters;
        TR_MAIN.KeyValue="SERVLET(I:DS_STRPBN=DS_STRPBN,I:DS_PBNVENEMP=DS_PBNVENEMP,I:DS_PBNPMK=DS_PBNPMK)"; //조회는 O
        TR_MAIN.Post();
        btnSaveClick = false;
    }
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        searchMaster();        
        var row = pumbunCode != "" ? DS_MASTER.NameValueRow("PUMBUN_CD",pumbunCode):DS_MASTER.NameValueRow("PUMBUN_NAME",pumbunName);
        row = row<1?1:row;
        if(row!=1){
            DS_STRPBN.ClearData();
            DS_PBNPMK.ClearData();
            DS_PBNVENEMP.ClearData();
        }
        DS_MASTER.RowPosition = row;
        
    }

    if(dtlSaveFlag == "STR" ){
        setTabItemIndex("TAB_MAIN",2);
        GD_STRPBN.Focus();               
    }else if(dtlSaveFlag == "EMP"){
        setTabItemIndex("TAB_MAIN",3);
        GD_PBNVENEMP.Focus(); 
    }else if(dtlSaveFlag == "PMK"){
        setTabItemIndex("TAB_MAIN",1);
        GD_PBNPMK.Focus();
    }else{
        setTabItemIndex("TAB_MAIN",1);
        GD_MASTER.Focus();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
*************************************************************************/
/**
 * btn_addPbnpmkRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 관리품목의 행을 추가한다.
 * return값 : void
**/ 
function btn_addPbnpmkRow(){
	if( DS_MASTER.RowPosition < 1){
	    showMessage(INFORMATION, OK, "USER-1025");
	    LC_O_BIZ_TYPE.Focus();
	    return;
	} 
	
	
	if(DS_PBNPMK.countrow == 0) {
		DS_PBNPMK.AddRow();
	    DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"USE_YN") = "Y";
	    DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"TAG_PRT_OWN_FLAG") = "1";	
	    setFocusGrid(GD_PBNPMK,DS_PBNPMK,DS_PBNPMK.CountRow,"PUMMOK_CD");
	    

		// 20170226 기본값 세팅
		var strSkuFlag = DS_MASTER.NameValue(DS_MASTER.Rowposition, "SKU_FLAG");
		var strSkuType = DS_MASTER.NameValue(DS_MASTER.Rowposition, "SKU_TYPE");
		
		if(strSkuFlag == "1"){			// 단품
			
			if(strSkuType == "1"){		// 규격, 의류
				DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"PUMMOK_CD") = "09090101";	
			}else{						// 신선
				DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"PUMMOK_CD") = "09100101";
			}
		}else if(strSkuFlag == "2"){		// 비단품
			DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"PUMMOK_CD") = "09080101";	
		}
			
		setFocusGrid(GD_PBNPMK,DS_PBNPMK,DS_PBNPMK.CountRow,"USE_YN");

	} else {
		DS_PBNPMK.AddRow();
	    DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"USE_YN") = "Y";
	    DS_PBNPMK.NameValue(DS_PBNPMK.CountRow,"TAG_PRT_OWN_FLAG") = "1";
	    setFocusGrid(GD_PBNPMK,DS_PBNPMK,DS_PBNPMK.CountRow,"PUMMOK_CD");
	}

	// 20170215 기본값 세팅
	var strSkuFlag = DS_MASTER.NameValue(DS_MASTER.Rowposition, "SKU_FLAG");
	
	if(strSkuFlag == "1"){			// 단품
	    DS_PBNPMK.NameValue(DS_PBNPMK.CountRow, "TAG_FLAG") = "1S";	
		
	}else if(strSkuFlag == "2"){	// 비단품
	    DS_PBNPMK.NameValue(DS_PBNPMK.CountRow, "TAG_FLAG") = "2S";
	}
}

/**
 * btn_addPbnpmkRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 관리품목의 행을 삭제한다.
 * return값 : void
**/ 
function btn_delPbnpmkRow(){
	if(DS_PBNPMK.CountRow < 1){
		showMessage(INFORMATION, OK, "USER-1019");
        LC_O_BIZ_TYPE.Focus();
        return;		
	}

	if(DS_PBNPMK.RowStatus(DS_PBNPMK.RowPosition) == 1){
	    DS_PBNPMK.DeleteRow(DS_PBNPMK.RowPosition);		
	    if( DS_PBNPMK.IsUpdated){
	        mainPummokUpdate("R");
	    }else{
	        mainPummokUpdate("U");
	    }
        return;
    }   
    showMessage(INFORMATION, OK, "USER-1052");
    GD_PBNPMK.Focus();
}
/**
 * btn_addStrpbnRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 점별브랜드의 행을 추가한다.
 * return값 : void
**/ 
function btn_addStrpbnRow(){
    if( DS_MASTER.RowPosition < 1){
        showMessage(INFORMATION, OK, "USER-1025");
        LC_O_BIZ_TYPE.Focus();
        return;
    } 
    DS_STRPBN.AddRow();
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"STR_CD") = "01";
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"EVALU_YN") = "Y";
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"USE_YN") = "Y";
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"MPOS_USE") = "Y";
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"SALE_BUY_FLAG") = LC_I_BIZ_TYPE.BindColVal == '2' ? '1':'1';
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"CHK_YN") = "Y";
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"ADV_ORD_YN") = "N";
    //DS_STRPBN.NameValue(DS_STRPBN.CountRow,"APP_S_DT") = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"APP_S_DT") = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
    DS_STRPBN.NameValue(DS_STRPBN.CountRow,"APP_E_DT") = "99991231";

    if( ( LC_I_SKU_TYPE.BindColVal == '3' || LC_I_SKU_TYPE.BindColVal == '1') && LC_I_BIZ_TYPE.BindColVal == '1' ){
        enableControl(LC_SP_ADV_ORD_YN, true);
    }else{
        enableControl(LC_SP_ADV_ORD_YN, false);
    }
    
    LC_SP_STR_CD.Focus();
}
/**
 * btn_addPbnpmkRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 점별브랜드의 행을 삭제한다.
 * return값 : void
**/ 
function btn_delStrpbnRow(){
    if(DS_STRPBN.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_O_BIZ_TYPE.Focus();
        return;     
    }
    if(DS_STRPBN.RowStatus(DS_STRPBN.RowPosition) == 1){
    	DS_STRPBN.DeleteRow(DS_STRPBN.RowPosition);     
        return;
    }   
    showMessage(INFORMATION, OK, "USER-1052");
}

/**
 * btn_addPbnvenempRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드별협력사담당자의 행을 추가한다.
 * return값 : void
**/ 
function btn_addPbnvenempRow(){
    if( DS_MASTER.RowPosition < 1){
        showMessage(INFORMATION, OK, "USER-1025");
        LC_O_BIZ_TYPE.Focus();
        return;
    } 
    DS_PBNVENEMP.AddRow();
    DS_PBNVENEMP.NameValue(DS_PBNVENEMP.CountRow,"USE_YN") = "Y";
    setFocusGrid(GD_PBNVENEMP,DS_PBNPMK,DS_PBNVENEMP.CountRow,"VEN_TASK_FLAG");
}
/**
 * btn_delPbnvenempRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드별협력사담당자의 행을 삭제한다.
 * return값 : void
**/ 
function btn_delPbnvenempRow(){
    if(DS_PBNVENEMP.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_O_BIZ_TYPE.Focus();
        return;     
    }
    if(DS_PBNVENEMP.RowStatus(DS_PBNVENEMP.RowPosition) == 1){
        DS_PBNVENEMP.DeleteRow(DS_PBNVENEMP.RowPosition);     
        return;
    }   
    showMessage(INFORMATION, OK, "USER-1052");
}

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-25
 * 개    요 : 브랜드 정보을 조회한다.
 * return값 : void
**/ 
function searchMaster(){
	//setTabItemIndex("TAB_MAIN",1);
    GD_PBNPMK.Editable    = true;    
    enableControl(IMG_PMK_ADD, true);   
    enableControl(IMG_PMK_DEL, true);
    DS_STRPBN.ClearData();
    DS_PBNPMK.ClearData();
    DS_PBNVENEMP.ClearData();
    DS_MASTER.ClearData();
    DS_I_PBN_COND.UserStatus(1) = '1';
    var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_SUB.Action="/dps/pcod221.pc?goTo="+goTo;  
    TR_SUB.KeyValue="SERVLET(I:DS_I_PBN_COND=DS_I_PBN_COND,"+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);
}
/**
 * searchPbnpmk()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-25
 * 개    요 : 브랜드 관리품목을 조회한다.
 * return값 : void
**/ 
function searchPbnpmk(){

	DS_PBNPMK.ClearData();

    var strPumbunCd = EM_I_PUMBUN_CD.Text;

    var goTo       = "searchPbnpmk" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd);
    TR_MAIN.Action="/dps/pcod221.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_PBNPMK=DS_PBNPMK)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * searchStrpbn()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-25
 * 개    요 : 점별브랜드을 조회한다.
 * return값 : void
**/ 
function searchStrpbn(){
	DS_STRPBN.ClearData();

    var strPumbunCd = EM_I_PUMBUN_CD.Text;

    var goTo       = "searchStrpbn" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd);
    TR_MAIN.Action="/dps/pcod221.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_STRPBN=DS_STRPBN)"; //조회는 O
    TR_MAIN.Post();
    
	
}
/**
 * searchPbnvenemp()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-25
 * 개    요 : 협력사담당자를 조회한다.
 * return값 : void
**/ 
function searchPbnvenemp(){
	DS_PBNVENEMP.ClearData();

    var strPumbunCd = EM_I_PUMBUN_CD.Text;
    var strVenCd = EM_I_VEN.Text;

    var goTo       = "searchPbnvenemp" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                      ;
    TR_MAIN.Action="/dps/pcod221.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_PBNVENEMP=DS_PBNVENEMP)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * searchMainBuyer()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-25
 * 개    요 : 정 바이어를 조회한다.
 * return값 : void
**/ 
function searchMainBuyer( orgCodeObj, flag){
	var orgCode = orgCodeObj.Text;
	
	if( orgCode.length == 10){
		//popup_dps.js
		getMainBuyer("DS_BUYER", orgCode, flag=='BUY'?"2":"1" );
		
	    if (DS_BUYER.countRow == 1) {
	    	DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_CD":"CHAR_SM_CD") = DS_BUYER.NameValue(DS_BUYER.RowPosition, "BUYER_CD") ;
            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_NM":"CHAR_SM_NM") = DS_BUYER.NameValue(DS_BUYER.RowPosition, "BUYER_NAME") ;
	    }
	    
	    /*
	    else{
	    	if(flag=='BUY')
	    		showMessage(EXCLAMATION, OK, "USER-1000", "["+orgCode+"] "+DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"BUY_ORG_NM":"SALE_ORG_NM")+"의 (정)바이어가 없습니다.");
	    	else
	    		showMessage(EXCLAMATION, OK, "USER-1000", "["+orgCode+"] "+DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"BUY_ORG_NM":"SALE_ORG_NM")+"의 (정)SM이 없습니다.");
	    	
	    	orgCodeObj.Text = "";
            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"BUY_ORG_NM":"SALE_ORG_NM") = "";
	    	DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_CD":"CHAR_SM_CD") = "";
            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_NM":"CHAR_SM_NM") = "";
	    }
	    */
	    
	}else{
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_CD":"CHAR_BUYER_CD") = "";
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"BUY_ORG_NM":"SALE_ORG_NM") = "";
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_CD":"CHAR_SM_CD") = "";
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, flag=='BUY'?"CHAR_BUYER_NM":"CHAR_SM_NM") = "";
		
	}
}

/**
 * searchVenmst()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 협력사 정보를 조회한다.
 * return값 : void
**/

function searchVenmst(venCdObj) {
	 var venCd = venCdObj.Text;
	 if( venCd.length == 6 ){
		 
		 //popup_dps.js
		 getVenInfo("DS_VENMST", venCd);
		 
		 if ( DS_VENMST.countRow == 1  ) {
	        if( DS_VENMST.NameValue(1, "BIZ_TYPE")=='1'
	        	||DS_VENMST.NameValue(1, "BIZ_TYPE")=='2'
	        	||DS_VENMST.NameValue(1, "BIZ_TYPE")== '3'
	        	||DS_VENMST.NameValue(1, "BIZ_TYPE")== '4'
	            ||DS_VENMST.NameValue(1, "BIZ_TYPE")== '5'){
	            DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_TYPE") = DS_VENMST.NameValue(DS_VENMST.RowPosition, "BIZ_TYPE") ;
	            DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_FLAG") = DS_VENMST.NameValue(DS_VENMST.RowPosition, "BIZ_FLAG") ;
	        }else{
	          	showMessage(EXCLAMATION, OK, "USER-1000", "거래형태는 ['직매입','특정매입','임대을A','임대을B','임대갑']만 가능합니다.");
	            DS_MASTER.NameValue(DS_MASTER.RowPosition, "VEN_NAME") = "" ;
	            DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_TYPE") = "" ;
	            DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_FLAG") = "" ;
	        }
	    }else{
	    	showMessage(EXCLAMATION, OK, "USER-1000", "협력사의 거래구분 및 거래유형이  존재하지 않습니다.");
            DS_MASTER.NameValue(DS_MASTER.RowPosition, "VEN_NAME") = "" ;
	     	DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_TYPE") = "" ;
            DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_FLAG") = "" ;
	    }
	 }
}
/**
 * clickStrPbnTab()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 점별브랜드 탭  클릭시 실행
 * return값 : void
**/
function clickStrPbnTab(){
	if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1075", "이동");
        LC_O_BIZ_TYPE.Focus();
		return false;
	}
    if( DS_MASTER.IsUpdated || DS_PBNPMK.IsUpdated){
    	if(showMessage(QUESTION, YESNO, "USER-1049")!=1){
            if(DS_MASTER.IsUpdated){
                setTabItemIndex('TAB_MAIN',1);
                EM_I_PUMBUN_NM.Focus();
            }else{
                setTabItemIndex('TAB_MAIN',1);
                setFocusGrid( GD_PBNPMK, DS_PBNPMK, DS_PBNPMK.RowPosition, "PUMMOK_CD");
            }
            return false;
    	}
    	DS_MASTER.UndoAll();
    	DS_PBNPMK.UndoAll();
    }

}
/**
 * clickPbnVenEmpTab()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 협력사담당자 탭 클릭시 실행
 * return값 : void
**/
function clickPbnVenEmpTab(){
    if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1075", "이동");
        LC_O_BIZ_TYPE.Focus();
        return false;
    }
    if( DS_MASTER.IsUpdated || DS_PBNPMK.IsUpdated){
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1){
            if(DS_MASTER.IsUpdated){
                setTabItemIndex('TAB_MAIN',1);
                EM_I_PUMBUN_NM.Focus();
            }else{
                setTabItemIndex('TAB_MAIN',1);
                setFocusGrid( GD_PBNPMK, DS_PBNPMK, DS_PBNPMK.RowPosition, "PUMMOK_CD");
            }
            return false;
        }
        DS_MASTER.UndoAll();
        DS_PBNPMK.UndoAll();
    }
}

/**
 * clickPumbunTab()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드 탭 클릭시 실행
 * return값 : void
**/
function clickPumbunTab(){
	  
    if( DS_PBNVENEMP.IsUpdated || DS_STRPBN.IsUpdated){
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1){
        	if( DS_STRPBN.IsUpdated){
                setTabItemIndex('TAB_MAIN',2);
                EM_SP_BUY_ORG_CD.Focus();        		
        	}else{
                setTabItemIndex('TAB_MAIN',3);     
                setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, DS_PBNVENEMP.RowPosition, "CHAR_NAME");
        	}
            return false;
        }
        DS_STRPBN.UndoAll();
        DS_PBNVENEMP.UndoAll();
    }
}

/**
 * checkPbnmstValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드정보 입력 값을 체크한다.
 * return값 : void
**/
function checkPbnmstValidation(){
    var check = false;
    var titleNm = "";
    var componentId = "";
    var row;

    for(var i = 1; i <= DS_MASTER.CountRow; i++ ) {
	    var rowStatus = DS_MASTER.RowStatus(i);
	    
	    if( rowStatus == 0 
	          || rowStatus == 2
	          || rowStatus == 4)
	            continue;
	    if( DS_MASTER.NameValue( i, "PUMBUN_NAME") == ''){
            check = true;
            titleNm = "브랜드명";
            componentId = "EM_I_PUMBUN_NM";
            row = i;
            break;
        }
	    if( !checkInputByte( null, DS_MASTER, i, 'PUMBUN_NAME', '브랜드명',  "EM_I_PUMBUN_NM"))
	        return;
	    
        if( DS_MASTER.NameValue( i, "RECP_NAME") == ''){
            check = true;
            titleNm = "영수증명";
            componentId = "EM_I_RECP_NM";
            row = i;
            break;
        }
        if( !checkInputByte( null, DS_MASTER, i, 'RECP_NAME', '영수증명',  "EM_I_RECP_NM"))
            return;
        
        if( DS_MASTER.NameValue( i, "VEN_CD") == ''){
            check = true;
            titleNm = "협력사";
            componentId = "EM_I_VEN";
            row = i;
            break;
        }
        
        if( DS_MASTER.NameValue( i, "VEN_NAME") == ''){
            check = true;
            titleNm = "협력사";
            componentId = "EM_I_VEN";
            row = i;
            break;
        }        
        
        if( DS_MASTER.NameValue( i, "PUMBUN_FLAG") == ''){
            check = true;
            titleNm = "브랜드구분";
            componentId = "LC_I_PUMBUN_FLAG";
            row = i;
            break;
        }        

        if( DS_MASTER.NameValue( i, "REP_PUMBUN_CD") != '' && DS_MASTER.NameValue( i, "REP_PUMBUN_NAME") == ''){
            // 존재하지 않는 대표 브랜드 코드 입니다.
            showMessage(EXCLAMATION, OK, "USER-1036", "대표 브랜드 코드");
            EM_I_REC_PUMBUN.Focus();
            return false;
        }
        
        
        if( DS_MASTER.NameValue( i, "PUMBUN_TYPE") == ''){
            check = true;
            titleNm = "브랜드유형";
            componentId = "LC_I_PUMBUN_TYPE";
            row = i;
            break;
        }        
        
        if( DS_MASTER.NameValue( i, "TAX_FLAG") == ''){
            check = true;
            titleNm = "과세구분";
            componentId = "LC_I_TAX_FLAG";
            row = i;
            break;
        }        
        
        if( DS_MASTER.NameValue( i, "SKU_FLAG") == ''){
            check = true;
            titleNm = "단품구분";
            componentId = "LC_I_SKU_FLAG";
            row = i;
            break;
        }
        if( DS_MASTER.NameValue( i, "BIZ_TYPE") == "1"                    //직매입 &&
        		&& !(DS_MASTER.NameValue( i, "RECP_NAME") == '까르뜨')     //까르뜨 네이버샵 문제로  적용.2016-02-15 
        		&& DS_MASTER.NameValue( i, "SKU_FLAG") == "2"             //비단품 &&
        		&& !( DS_MASTER.NameValue( i, "PUMBUN_TYPE") == "1" 
                   || DS_MASTER.NameValue( i, "PUMBUN_TYPE") == "6" 
                   || DS_MASTER.NameValue( i, "PUMBUN_TYPE") == "7" 
                   || DS_MASTER.NameValue( i, "PUMBUN_TYPE") == "8" 
                   || DS_MASTER.NameValue( i, "PUMBUN_TYPE") == "9" 
                   || DS_MASTER.NameValue( i, "PUMBUN_TYPE") == "A")){
            showMessage(EXCLAMATION, OK, "USER-1000", "거래 형태가 [직매입] 일경우 <br>단품 구분은 [비단품]을 선택 할수 없습니다.");
        	LC_I_SKU_FLAG.Focus();
        	return false;
        }
        
        if( DS_MASTER.NameValue( i, "SKU_FLAG") == '1' && DS_MASTER.NameValue( i, "SKU_TYPE") == ''){
            check = true;
            titleNm = "단품종류";
            componentId = "LC_I_SKU_TYPE";
            row = i;
            break;
        }        
        
        if( DS_MASTER.NameValue( i, "SKU_TYPE") == '3' && DS_MASTER.NameValue( i, "STYLE_TYPE") == ''){
            check = true;
            titleNm = "의류단품 코드구분";
            componentId = "LC_I_STYLE_TYPE";
            break;
        } 

        if( DS_MASTER.NameValue( i, "ITG_ORD_FLAG") == ''){
            check = true;
            titleNm = "통합발주여부";
            componentId = "LC_I_ITG_ORD_FLAG";
            row = i;
            break;
        }
        
        /*
        // 20120607 * DHL * 주석처리 START -->
        if( DS_MASTER.NameValue( i, "BRAND_CD") == ''){
            check = true;
            titleNm = "브랜드 코드";
            componentId = "EM_I_BRAND";
            break;
        }
        
        if( DS_MASTER.NameValue( i, "BRAND_CD") != '' && DS_MASTER.NameValue( i, "BRAND_NM") == ''){
            // 존재하지 않는 브랜드 코드 입니다.
            showMessage(EXCLAMATION, OK, "USER-1036", "브랜드 코드");
            EM_I_BRAND_NM.Focus();
            return false;
        }
        // 20120607 * DHL * 주석처리  END <--
        */

        if( DS_MASTER.NameValue( i, "APP_S_DT") == ''){
            check = true;
            titleNm = "적용시작일";
            componentId = "EM_I_APP_S_DT";
            row = i;
            break;
        } 
        if( DS_MASTER.NameValue( i, "APP_E_DT") == ''){
            check = true;
            titleNm = "적용종료일";
            componentId = "EM_I_APP_E_DT";
            row = i;
            break;
        } 
        
        if( DS_MASTER.NameValue( i, "APP_S_DT") > DS_MASTER.NameValue( i, "APP_E_DT") ){
            showMessage(EXCLAMATION, OK, "USER-1008", "적용시작일","적용종료일");
            EM_I_APP_S_DT.Focus();
        	return false;
        }
	}

    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setTabItemIndex('TAB_MAIN',1);
        eval(componentId).Focus();
        return false;
    }
	return true;
}

/**
 * checkPbnpmkValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 관리품목 입력 값을 체크한다.
 * return값 : void
**/
function checkPbnpmkValidation(){
    var check = false;
    var titleNm = "";
    var columnId = "";
    var row;

    // 점코드 중복체크
    var dupRow = checkDupKey(DS_PBNPMK, "PUMMOK_CD");
    if (dupRow > 0) {
        showMessage(EXCLAMATION, Ok,  "USER-1044");
        
        setTabItemIndex('TAB_MAIN',1);
        setFocusGrid( GD_PBNPMK, DS_PBNPMK, dupRow, "PUMMOK_CD");
        return ;
    }
    for(var i = 1; i <= DS_PBNPMK.CountRow; i++ ) {
        var rowStatus = DS_PBNPMK.RowStatus(i);
        
        if( rowStatus == 0 
              || rowStatus == 2
              || rowStatus == 4)
                continue;
        if( DS_PBNPMK.NameValue( i, "PUMMOK_CD") == ''){
            check = true;
            titleNm = "품목";
            columnId = "PUMMOK_CD";
            row = i;
            break;;
        }
        
        if( DS_PBNPMK.NameValue( i, "PUMMOK_NAME") == ''){
            // 존재하지 않는 품목 코드 입니다.
            showMessage(EXCLAMATION, OK, "USER-1000", "존재하지 않는 품목 코드 입니다.");
            setFocusGrid(GD_PBNPMK,DS_PBNPMK,i,'PUMMOK_CD');
            return false;
        }
        
        if( DS_PBNPMK.NameValue( i, "TAG_FLAG") == ''){
            check = true;
            titleNm = "택구분";
            columnId = "TAG_FLAG";
            row = i;
            break;
        }        
        
        
//         if( LC_I_SKU_FLAG.BindColVal == "1"){
//             if( DS_PBNPMK.NameValue( i, "TAG_FLAG") != '1S'){
//                 showMessage(EXCLAMATION, OK, "USER-1000", "단품의 택구분은 1단 만 가능합니다.");
//                 setFocusGrid(GD_PBNPMK,DS_PBNPMK,i,'TAG_FLAG');
//                 return false;
//             }        
//         }else{
//             if( DS_PBNPMK.NameValue( i, "TAG_FLAG") == '1S'){
//                 showMessage(EXCLAMATION, OK, "USER-1000", "비단품의 택구분은 2단만 가능합니다.");
//                 setFocusGrid(GD_PBNPMK,DS_PBNPMK,i,'TAG_FLAG');
//                 return false;
//             }        
//         }
        
        
//         if( DS_PBNPMK.NameValue( i, "TAG_PRT_OWN_FLAG") == ''){
//             check = true;
//             titleNm = "택발행주체";
//             columnId = "TAG_PRT_OWN_FLAG";
//             row = i;
//             break;
//         }        
        
        if( DS_PBNPMK.NameValue( i, "USE_YN") == ''){
            check = true;
            titleNm = "사용여부";
            columnId = "USE_YN";
            row = i;
            break;
        }        
    }

    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setTabItemIndex('TAB_MAIN',1);
        setFocusGrid( GD_PBNPMK, DS_PBNPMK, row, columnId);
        return false;
    }
    return true;
}

/**
 * checkStrpbnValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 점별브랜드 입력 값을 체크한다.
 * return값 : void
**/
function checkStrpbnValidation(){
    var check = false;
    var titleNm = "";
    var componentId = "";
    var row;
    
    for(var i = 1; i <= DS_STRPBN.CountRow; i++ ) {
        var rowStatus = DS_STRPBN.RowStatus(i);
        
        if( rowStatus == 0 
              || rowStatus == 2
              || rowStatus == 4)
                continue;
        if( DS_STRPBN.NameValue( i, "STR_CD") == ''){
            check = true;
            titleNm = "점";
            componentId = "LC_SP_STR_CD";
            row = i;
            break;
        } 
        var dupRow = checkDupKey( DS_STRPBN ,"STR_CD")
        if( dupRow > 0 ){
            showMessage(EXCLAMATION, OK, "USER-1044");
            DS_STRPBN.RowPosition = dupRow;
            LC_SP_STR_CD.Focus();
            return false;
        }
        
        var strCd = DS_STRPBN.NameValue( i, "STR_CD");
        var strNmme = LC_SP_STR_CD.ValueByColumn("CODE", strCd, "NAME");
        
        
        // MARIO OUTLET
        /* 20120507 * DHL 주석 제외  --> */
        var strFlag = LC_SP_STR_CD.ValueByColumn("CODE", strCd, "STR_FLAG");
        
        if( strFlag != "0" && DS_STRPBN.NameValue( i, "BUY_ORG_CD") == ''){
            check = true;
            titleNm = "매입조직";
            componentId = "EM_SP_BUY_ORG_CD";
            row = i;
            break;
        } 

        /* 20120507 * DHL 수정  --> */
        
        if( DS_STRPBN.NameValue( i, "BUY_ORG_CD") != ''){
	        if( DS_STRPBN.NameValue( i, "BUY_ORG_NM") == ''){
	            // 존재하지 않는 매입조직 코드 입니다.
	            showMessage(EXCLAMATION, OK, "USER-1000", "존재하지 않는 매입조직 코드 입니다.");
	            setTabItemIndex('TAB_MAIN',2);
	            DS_STRPBN.RowPosition = i;
	            EM_SP_BUY_ORG_CD.Focus();
	            return false;
	        }
	        
	        
	        /*
	        if( DS_STRPBN.NameValue( i, "CHAR_BUYER_NM") == ''){
	            showMessage(EXCLAMATION, OK, "USER-1000", "["+DS_STRPBN.NameValue( i, 'BUY_ORG_CD')+"] "+DS_STRPBN.NameValue(i, 'BUY_ORG_NM')+"의 (정)바이어가 없습니다.");
	            DS_STRPBN.RowPosition = i;
	            EM_SP_BUY_ORG_CD.Focus();
	            return false;
	        }
	        */
	        
	        
	        if( LC_I_ITG_ORD_FLAG.BindColVal == 'N' && DS_STRPBN.NameValue( i, "BUY_ORG_CD").substring(0,2) != strCd ){
	            showMessage(EXCLAMATION, OK, "USER-1000", "매입조직 코드는 " + strNmme + "의 조직 코드 가 아닙니다.");
	            DS_STRPBN.RowPosition = i;
	            EM_SP_BUY_ORG_CD.Focus();
	            return false;
	        }
        }
        
        /* 20120507 * DHL * 수정  <-- */
        /* 20120507 * DHL * 주석 제외  <-- */
        // MARIO OUTLET
        // 20120507 * DHL * 위로 위치 이동  -->
        //var strFlag = LC_SP_STR_CD.ValueByColumn("CODE", strCd, "STR_FLAG");
        // 20120507 * DHL * 위로  위치 이동  <--
        
        if( strFlag != "0" && DS_STRPBN.NameValue( i, "SALE_ORG_CD") == ''){
            check = true;
            titleNm = "판매조직";
            componentId = "EM_SP_SALE_ORG_CD";
            row = i;
            break;
        } 
        /* 20120507 * DHL 수정  --> */
               
        if( DS_STRPBN.NameValue( i, "SALE_ORG_CD") != '' ){
        	
        	if(DS_STRPBN.NameValue( i, "SALE_ORG_NM") == ''){
                // 존재하지 않는 판매조직 코드 입니다.
                showMessage(EXCLAMATION, OK, "USER-1000", "존재하지 않는 판매조직 코드 입니다.");
                setTabItemIndex('TAB_MAIN',2);
                DS_STRPBN.RowPosition = i;
                EM_SP_SALE_ORG_CD.Focus();
                return false;
            } 

        	
        	/*
            if( DS_STRPBN.NameValue( i, "CHAR_SM_NM") == ''){
            	showMessage(EXCLAMATION, OK, "USER-1000", "["+DS_STRPBN.NameValue( i, 'SALE_ORG_CD')+"] "+DS_STRPBN.NameValue(i, 'SALE_ORG_NM')+"의 (정)SM이 없습니다.");
                DS_STRPBN.RowPosition = i;
                EM_SP_SALE_ORG_CD.Focus();
                return false;
            }
        	*/
            
            if( DS_STRPBN.NameValue( i, "SALE_ORG_CD").substring(0,2) != strCd ){
                showMessage(EXCLAMATION, OK, "USER-1000", "판매조직 코드는 " + strNmme + "의 조직 코드 가 아닙니다.");
                DS_STRPBN.RowPosition = i;
                EM_SP_SALE_ORG_CD.Focus();
                return false;
            }
        }
        
        /* 20120507 * DHL * 수정  <-- */
        

        if( DS_STRPBN.NameValue( i, "SALE_BUY_FLAG") == ''){
            check = true;
            titleNm = "판매분매입";
            componentId = "LC_SP_SALE_BUY_FLAG";
            row = i;
            break;
        } 

        if( DS_STRPBN.NameValue( i, "SLIDING_FLAG") == ''){
            check = true;
            titleNm = "슬라이딩구분";
            componentId = "LC_SP_SLIDING_FLAG";
            row = i;
            break;
        } 
        
        if( DS_STRPBN.NameValue( i, "CHK_YN") == ''){
            check = true;
            titleNm = "검품여부";
            componentId = "LC_SP_CHK_YN";
            row = i;
            break;
        } 
        /*
        if( DS_STRPBN.NameValue( i, "COST_CAL_WAY") == ''){
            check = true;
            titleNm = "원가산정방법";
            componentId = "LC_SP_COST_CAL_WAY";
            row = i;
            break;
        } 
        */
        if( DS_STRPBN.NameValue( i, "RENTB_MGAPP_FLAG") == '' && LC_I_BIZ_TYPE.BindColVal == "5"){
            check = true;
            titleNm = "임대B수수료구분";
            componentId = "LC_SP_RENTB_MGAPP_FLAG";
            row = i;
            break;
        } 
        
        // 20120507 * DHL * 추가 -->
        if( DS_STRPBN.NameValue( i, "HALL_CD") == ''){
            check = true;
            titleNm = "관";
            componentId = "LC_SP_HALL_CD";
            row = i;
            break;
        }
        // 20120507 * DHL * 추가 <--

        if( DS_STRPBN.NameValue( i, "FLOR_CD") == ''){
            check = true;
            titleNm = "층";
            componentId = "LC_SP_FLOR_CD";
            row = i;
            break;
        } 
        if( DS_STRPBN.NameValue( i, "EVALU_YN") == ''){
            check = true;
            titleNm = "평가대상여부";
            componentId = "LC_SP_EVALU_YN";
            row = i;
            break;
        } 
        /*
        if( DS_STRPBN.NameValue( i, "EVALU_YN") == 'Y' && DS_STRPBN.NameValue( i, "AREA_SIZE") == ''){
            check = true;
            titleNm = "면적";
            componentId = "EM_SP_AREA_SIZE";
            row = i;
            break;
        } 
        */
        
        if( DS_STRPBN.NameValue( i, "APP_S_DT") == ''){
            check = true;
            titleNm = "적용시작일";
            componentId = "EM_SP_APP_S_DT";
            row = i;
            break;
        } 
        if( DS_STRPBN.NameValue( i, "APP_E_DT") == ''){
            check = true;
            titleNm = "적용종료일";
            componentId = "EM_SP_APP_E_DT";
            row = i;
            break;
        } 
        if( DS_STRPBN.RowStatus(row)==1 && DS_STRPBN.NameValue( i, "APP_S_DT") <= getTodayFormat("YYYYMMDD") ){
            showMessage(EXCLAMATION, OK,"USER-1030","적용시작일");
            DS_STRPBN.RowPosition = i;
            EM_SP_APP_S_DT.Focus();
            return false;
        }
        if( DS_STRPBN.RowStatus(row)==1 && DS_STRPBN.NameValue( i, "APP_E_DT") <= getTodayFormat("YYYYMMDD") ){
            showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
            DS_STRPBN.RowPosition = i;
            EM_SP_APP_E_DT.Focus();
            return false;
        }
        if( DS_STRPBN.NameValue( i, "APP_S_DT") > DS_STRPBN.NameValue( i, "APP_E_DT")){
            showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
            DS_STRPBN.RowPosition = i;
            EM_SP_APP_E_DT.Focus();
            return false;
        }
        
        if( DS_STRPBN.NameValue( i, "EDI_YN") == ''){
            check = true;
            titleNm = "EDI사용여부";
            componentId = "LC_SP_EDI_YN";
            row = i;
            break;
        } 
    }

    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setTabItemIndex('TAB_MAIN',2);
        DS_STRPBN.RowPosition = row;
        eval(componentId).Focus();
        return false;
    }
    return true;
}

/**
 * checkPbnvenempValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드별협력사담당자 입력 값을 체크한다.
 * return값 : void
**/
function checkPbnvenempValidation(){
    var check = false;
    var titleNm = "";
    var columnId = "";
    var row;

    for(var i = 1; i <= DS_PBNVENEMP.CountRow; i++ ) {
        var rowStatus = DS_PBNVENEMP.RowStatus(i);
        
        if( rowStatus == 0 
              || rowStatus == 2
              || rowStatus == 4)
                continue;

        if( DS_PBNVENEMP.NameValue( i, "VEN_TASK_FLAG") == ''){
            check = true;
            titleNm = "업무구분";
            columnId = "VEN_TASK_FLAG";
            row = i;
            break;
        }

        if( DS_PBNVENEMP.NameValue( i, "CHAR_NAME") == ''){
            check = true;
            titleNm = "담당자명";
            columnId = "CHAR_NAME";
            row = i;
            break;
        }
        if( !checkInputByte( GD_PBNVENEMP, DS_PBNVENEMP, i, 'CHAR_NAME', '담당자명',  null))
            return;
        /*
        if( DS_PBNVENEMP.NameValue( i, "PHONE1_NO") == ''){
            check = true;
            titleNm = "전화번호-지역";
            columnId = "PHONE1_NO";
            row = i;
            break;
        }
        if( DS_PBNVENEMP.NameValue( i, "PHONE2_NO") == ''){
            check = true;
            titleNm = "전화번호-국번";
            columnId = "PHONE2_NO";
            row = i;
            break;
        }
        if( DS_PBNVENEMP.NameValue( i, "PHONE3_NO") == ''){
            check = true;
            titleNm = "전화번호-번호";
            columnId = "PHONE3_NO";
            row = i;
            break;
        }
        
        if( DS_PBNVENEMP.NameValue( i, "HP1_NO") == ''){
            check = true;
            titleNm = "휴대전화-통신사";
            columnId = "HP1_NO";
            row = i;
            break;
        }
        if( DS_PBNVENEMP.NameValue( i, "HP2_NO") == ''){
            check = true;
            titleNm = "휴대전화-국번";
            columnId = "HP2_NO";
            row = i;
            break;
        }
        if( DS_PBNVENEMP.NameValue( i, "HP3_NO") == ''){
            check = true;
            titleNm = "휴대전화-번호";
            columnId = "HP3_NO";
            row = i;
            break;
        }
        if( DS_PBNVENEMP.NameValue( i, "EMAIL") == ''){
            check = true;
            titleNm = "이메일";
            columnId = "EMAIL";
            row = i;
            break;
        }
        */
        
        if( DS_PBNVENEMP.NameValue( i, "EMAIL") != ''){
	        if(!isValidStrEmail(DS_PBNVENEMP.NameValue( i, "EMAIL"))){
	            showMessage(EXCLAMATION, OK,"USER-1004","이메일");
	            setTabItemIndex('TAB_MAIN',3);
	            setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, i, "EMAIL");
// 	            setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "EMAIL");',50);
	            return false;
	        }
        }
        
        if( DS_PBNVENEMP.NameValue( i, "USE_YN") == ''){
            check = true;
            titleNm = "사용여부";
            columnId = "USE_YN";
            row = i;
            break;
        }
    }

    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setTabItemIndex('TAB_MAIN',3);
        setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, row, columnId);
        return false;
    }
    return true;
}
/**
 * getOrgPop()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 조직 팝업을 실행한다.
 * return값 : void
**/
function getOrgPop( orgCdObj , orgNmObj, flag){
	if( LC_SP_STR_CD.BindColVal == ''){
        // (점)은/는 반드시 선택해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_SP_STR_CD.Focus();
        return;
	}
	var rtnVal = orgPop( orgCdObj, orgNmObj, 'N','','',flag=='BUY'?'2':'1',flag=='BUY'?'4':'5','Y',LC_SP_STR_CD.BindColVal);
	if(rtnVal != null){		
		if(flag=='BUY'){
			if( rtnVal.get("PC_CD") == "00" || rtnVal.get("CORNER_CD") !="00"){
		        showMessage(EXCLAMATION, OK, "USER-1000", "매입조직은 PC 레벨에서 선택하여야 합니다.");
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
		        orgNmObj.Text = "";
		        orgCdObj.Focus();
		        return;			
			}
		} else{
            if(  rtnVal.get("CORNER_CD") =="00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "판매조직은 코너 레벨에서 선택하여야 합니다.");
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
                orgNmObj.Text = "";
                orgCdObj.Focus();
                return;         
            }			
		}
	    searchMainBuyer(orgCdObj,flag);
	}else{
		if( orgNmObj.Text == '' ){
	        if(flag=='BUY'){
	            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
	            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
	        }else{
	            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
	            DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
	        }			
		}
	}
    orgCdObj.Focus();
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
        if(svcFlag=="I"){
            searchVenmst(EM_I_VEN);
            return;
        }
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , svcFlag=='I'?1:0,'',svcFlag=='I'?'Y':'');
	
    if(svcFlag=="I"){
        searchVenmst(EM_I_VEN);
        return;
    }
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

/**
 * setInitCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 공통코드 팝업 및 이름  조회
 * return값 : void
 */
function setInitCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : 'SEL_COMM_CODE_ONLY';
    if( evnflag == "POP" ){
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
        return;
    }
    
    setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
}

/**
 * mainPummokUpdate()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 브랜드정보의 입력 정보 활성화 제거
 * return값 : void
 */
function mainPummokUpdate( mode){
	
	var flag = mode=="R"?false:true;
    enableControl(EM_I_PUMBUN_NM, flag);
    enableControl(EM_I_RECP_NM, flag);
    enableControl(EM_I_VEN, flag);
    enableControl(EM_I_REC_PUMBUN, flag);
    enableControl(EM_I_BRAND, flag);
    enableControl(EM_I_APP_E_DT, flag);
    enableControl(LC_I_PUMBUN_FLAG, flag);
    enableControl(LC_I_PUMBUN_TYPE, flag);
    enableControl(LC_I_USE_YN, flag);
    enableControl(IMG_APP_E_DT, flag);
    enableControl(IMG_BRAND, flag);
    enableControl(IMG_VEN, flag);
    enableControl(IMG_REC_PUMBUN, flag);
    enableControl(EM_I_APP_S_DT, flag);
    enableControl(IMG_APP_S_DT, flag);

    enableControl(LC_I_TAX_FLAG, mode=="I"?true:false);
    enableControl(EM_I_VEN, mode=="I"?true:false);
    enableControl(IMG_VEN, mode=="I"?true:false);
    enableControl(LC_I_SKU_FLAG, mode=="I"?true:false);//단품구분
    enableControl(LC_I_PUMBUN_TYPE, mode=="I"?true:false);
    enableControl(LC_I_SKU_TYPE, mode=="I"?true:false);
    enableControl(LC_I_STYLE_TYPE, mode=="I"?true:false);
    
    if(LC_I_BIZ_TYPE.BindColVal == '1' && LC_I_SKU_FLAG.BindColVal == "1"){
        enableControl(LC_I_ITG_ORD_FLAG, flag);
    }else{
        enableControl(LC_I_ITG_ORD_FLAG, false);
    }
    
    if( mode=="U" && DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_S_DT") <= getTodayFormat("YYYYMMDD")){
        enableControl(EM_I_APP_S_DT, false);
        enableControl(IMG_APP_S_DT, false);
    }
}

/**
 * strPbnCnt()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 점별브랜드정보 활성화 제거
 * return값 : void
 */
function strPbnCntFalse( ){
    

    enableControl(EM_SP_BUY_ORG_CD, false);
    enableControl(EM_SP_BUY_ORG_NM, false);
    enableControl(EM_SP_CHAR_BUYER_NM, false);
    enableControl(EM_SP_SALE_ORG_CD, false);
    enableControl(EM_SP_SALE_ORG_NM, false);
    enableControl(EM_SP_CHAR_SM_NM, false);
    enableControl(EM_SP_LOW_MG_RATE, false);
    //enableControl(EM_SP_SBNS_CAL_RATE, false);
    enableControl(EM_SP_AREA_SIZE, false);
    enableControl(EM_SP_APP_S_DT, false);
    enableControl(EM_SP_APP_E_DT, false);
    enableControl(LC_SP_STR_CD, false);
    enableControl(LC_SP_SALE_BUY_FLAG, false);
    enableControl(LC_SP_SLIDING_FLAG, false); // MARIO OUTLET
    enableControl(LC_SP_CHK_YN, false);
    //enableControl(LC_SP_COST_CAL_WAY, false);
    enableControl(LC_SP_ADV_ORD_YN, false);
    enableControl(LC_SP_EVALU_YN, false);
    enableControl(LC_SP_USE_YN, false);
    enableControl(LC_SP_PUSE_YN, false);
    enableControl(LC_SP_RENTB_MGAPP_FLAG, false);
    enableControl(LC_SP_EDI_YN, false);
    enableControl(IMG_SP_APP_S_DT, false);
    enableControl(LC_SP_FLOR_CD, false);
    // 20120507 * DHL 추가 -->
    enableControl(LC_SP_VEN_MNG_FLAG, false);
    enableControl(LC_SP_HALL_CD, false);
    // 20120507 * DHL 추가 <--
}
/**
 * checkOrgDefStr()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 매입 조직에 다른 점의 조직이 있는지 체크
 * return값 : void
 */
function checkOrgDefStr(){
	 if( DS_STRPBN.CountRow < 1){
		 return true;
	 }
	 
	 for( var i =1; i<=DS_STRPBN.CountRow ; i++ ){
		 var strCd = DS_STRPBN.NameValue(i,"STR_CD");
		 var buyOrgCd = DS_STRPBN.NameValue(i,"BUY_ORG_CD");
		 if( strCd != buyOrgCd.substring(0,2)){
			 return false;
		 }
	 }
	 
	 return true;
}



/**
 * setBrandCd()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 브랜드를 조회함
 * return값 : void
 */
function setBrandCd(evnFlag, selInGb,codeObj, nameObj){

   if( evnFlag == 'POP'){
   	getBrandPop(codeObj,nameObj,'N')
       codeObj.Focus();        
       return;
   }
   
   if( codeObj.Text == ""){
       nameObj.Text = "";
       return;
   }
   
   setStrBrdNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1);
} 


/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_pbn_emg(){

        var strPumbunCd 	= DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_CD");
		//var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
		var strProcDt       = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));

        if( strPumbunCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","브랜드가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&strPumbunCd="  + encodeURIComponent(strPumbunCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod221.pc?goTo=sendpbnemg"+parameters;
	        TR_MAIN.KeyValue="SERVLET(O:DS_MASTER=DS_MASTER)"; //조회는 O
	    	TR_MAIN.Post();        
	    }
}


/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_pmk_emg(){

        var strPumbunCd 	= DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_CD");
		//var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
		var strProcDt       = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));

        if( strPumbunCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","브랜드가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&strPumbunCd="  + encodeURIComponent(strPumbunCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod221.pc?goTo=sendpmkemg"+parameters;
	        TR_MAIN.KeyValue="SERVLET(O:DS_MASTER=DS_MASTER)"; //조회는 O
	    	TR_MAIN.Post();        
	    }
}
-->
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

<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
  
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
  

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_STRPBN event=OnDataError(row,colid)>
    if(colid == 'STR_CD'){
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_SP_STR_CD.Focus();
    }else{
        showMessage(EXCLAMATION, OK, "USER-1044", row);
        LC_SP_STR_CD.Focus();
    }
</script>
<script language=JavaScript for=DS_PBNPMK event=OnDataError(row,colid)>
    if(colid == 'PUMMOK_CD'){
        showMessage(EXCLAMATION, OK, "USER-1003", "품목");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1044", row);
    }
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)
        return;
    if( row > 0 ) { 
        if( this.RowStatus(row) == 1){
        	mainPummokUpdate("I");
        } else{
            mainPummokUpdate("U");
            if( bfMasterRowPosition == row)
            	return;
            bfMasterRowPosition = row;
            //setTabItemIndex("TAB_MAIN",1);
            //점콤보 가져오기 ( popup_dps.js )
            getStrVenCode("DS_SP_STR_CD",EM_I_VEN.Text, "N");
            searchPbnpmk();
            searchStrpbn();
            searchPbnvenemp();
        }
    }
</script>
<script language=JavaScript for=DS_MASTER event=OnColumnChanged(row,colid)>

    if( DS_MASTER.IsUpdated){
    	GD_PBNPMK.Editable    = false;
        enableControl(IMG_PMK_ADD, false);
        enableControl(IMG_PMK_DEL, false);
    }else{
        GD_PBNPMK.Editable    = true;    
        enableControl(IMG_PMK_ADD, true);	
        enableControl(IMG_PMK_DEL, true);
    }
</script>
<script language=JavaScript for=DS_PBNPMK event=OnColumnChanged(row,colid)>
    if( this.IsUpdated){
    	mainPummokUpdate("R");
    }else{
        mainPummokUpdate("U");
    }
</script>
<script language=JavaScript for=DS_PBNPMK event=CanRowPosChange(row)>

    var rowStatus = DS_PBNPMK.RowStatus(row);
    var check = false;
    var titleNm = "";
    var columnId = "";
    if( rowStatus == 0 
              || rowStatus == 2
              || rowStatus == 4)
                return;
    
    if( DS_PBNPMK.NameValue( row, "PUMMOK_CD") == ''){
        check = true;
        titleNm = "품목";
        columnId = "PUMMOK_CD";
    }else if( DS_PBNPMK.NameValue( row, "PUMMOK_NAME") == ''){
        // 존재하지 않는 품목 코드 입니다.
        showMessage(EXCLAMATION, OK, "USER-1000", "존재하지 않는 품목 코드 입니다.");
        return false;
    }
//     else if( DS_PBNPMK.NameValue( row, "TAG_FLAG") == ''){
//         check = true;
//         titleNm = "택구분";
//         columnId = "TAG_FLAG";
//     }
//     else if( DS_PBNPMK.NameValue( row, "TAG_PRT_OWN_FLAG") == ''){
//         check = true;
//         titleNm = "택발행주체";
//         columnId = "TAG_PRT_OWN_FLAG";
//     }
    else if( DS_PBNPMK.NameValue( row, "USE_YN") == ''){
        check = true;
        titleNm = "사용여부";
        columnId = "USE_YN";
    }        
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setTabItemIndex('TAB_MAIN',1);
        setFocusGrid( GD_PBNPMK, DS_PBNPMK, row, columnId);
        return false;
    }
    
</script>
<script language=JavaScript for=DS_PBNVENEMP event=CanRowPosChange(row)>

    var check = false;
    var titleNm = "";
    var columnId = "";
    var rowStatus = DS_PBNVENEMP.RowStatus(row);
    
    if( rowStatus == 0 
          || rowStatus == 2
          || rowStatus == 4)
            return true;

    if( DS_PBNVENEMP.NameValue( row, "VEN_TASK_FLAG") == ''){
        check = true;
        titleNm = "업무구분";
        columnId = "VEN_TASK_FLAG";
    }else if( DS_PBNVENEMP.NameValue( row, "CHAR_NAME") == ''){
        check = true;
        titleNm = "담당자명";
        columnId = "CHAR_NAME";
    } else  if( !checkInputByte( GD_PBNVENEMP, DS_PBNVENEMP, row, 'CHAR_NAME', '담당자명',  null)){
    	return false;
    }
    /*
    else if( DS_PBNVENEMP.NameValue( row, "PHONE1_NO") == ''){
        check = true;
        titleNm = "전화번호-지역";
        columnId = "PHONE1_NO";
    }else if( DS_PBNVENEMP.NameValue( row, "PHONE2_NO") == ''){
        check = true;
        titleNm = "전화번호-국번";
        columnId = "PHONE2_NO";
    }else if( DS_PBNVENEMP.NameValue( row, "PHONE3_NO") == ''){
        check = true;
        titleNm = "전화번호-번호";
        columnId = "PHONE3_NO";
    }
    */ 
    else  if( !isNumberStr( DS_PBNVENEMP.NameValue( row, "PHONE1_NO"))){
        showMessage(EXCLAMATION, OK,"USER-1004","전화번호-지역");    
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "PHONE1_NO");',50); 
        return false;
    }else  if( !isNumberStr( DS_PBNVENEMP.NameValue( row, "PHONE2_NO"))){
        showMessage(EXCLAMATION, OK,"USER-1004","전화번호-국번");    
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "PHONE2_NO");',50); 
        return false;
    }else  if( !isNumberStr( DS_PBNVENEMP.NameValue( row, "PHONE3_NO"))){
        showMessage(EXCLAMATION, OK,"USER-1004","전화번호-번호");    
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "PHONE3_NO");',50); 
        return false;
    }else  if( !isNumberStr( DS_PBNVENEMP.NameValue( row, "HP1_NO"))){
        showMessage(EXCLAMATION, OK,"USER-1004","휴대전화-통신사");    
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "HP1_NO");',50); 
        return false;
    }else  if( !isNumberStr( DS_PBNVENEMP.NameValue( row, "HP2_NO"))){
        showMessage(EXCLAMATION, OK,"USER-1004","휴대전화-국번");    
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "HP2_NO");',50); 
        return false;
    }else  if( !isNumberStr( DS_PBNVENEMP.NameValue( row, "HP3_NO"))){
        showMessage(EXCLAMATION, OK,"USER-1004","휴대전화-번호");    
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "HP3_NO");',50); 
        return false;
    }
    /* else if( DS_PBNVENEMP.NameValue( row, "HP1_NO") == ''){
        check = true;
        titleNm = "휴대전화-통신사";
        columnId = "HP1_NO";
    }else if( DS_PBNVENEMP.NameValue( row, "HP2_NO") == ''){
        check = true;
        titleNm = "휴대전화-국번";
        columnId = "HP2_NO";
    }else if( DS_PBNVENEMP.NameValue( row, "HP3_NO") == ''){
        check = true;
        titleNm = "휴대전화-번호";
        columnId = "HP3_NO";
    }else if( DS_PBNVENEMP.NameValue( row, "EMAIL") == ''){
        check = true;
        titleNm = "이메일";
        columnId = "EMAIL";
    }
    else if(!isValidStrEmail(DS_PBNVENEMP.NameValue( row, "EMAIL"))){
        showMessage(EXCLAMATION, OK,"USER-1004","이메일");
        setTabItemIndex('TAB_MAIN',3);
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "EMAIL");',50);    
        return false;
    }*/
    else if( DS_PBNVENEMP.NameValue( row, "USE_YN") == ''){
        check = true;
        titleNm = "사용여부";
        columnId = "USE_YN";
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setTabItemIndex('TAB_MAIN',3);
        setTimeout('setFocusGrid( GD_PBNVENEMP, DS_PBNVENEMP, '+row+', "'+columnId+'");',50);  
        return false;
    }
    return true;
</script>
<script language=JavaScript for=DS_STRPBN event=OnRowPosChanged(row)>
    if( row < 1)
    	return;
    if( this.RowStatus(row) == 1){
        enableControl(LC_SP_STR_CD, true);
        enableControl(EM_SP_APP_S_DT, true);
        enableControl(IMG_SP_APP_S_DT, true);
    } else{
       enableControl(LC_SP_STR_CD, false);
       if( this.NameValue(row,"APP_S_DT") <= getTodayFormat("YYYYMMDD")){
           enableControl(EM_SP_APP_S_DT, false);
           enableControl(IMG_SP_APP_S_DT, false);
       }else{
           enableControl(EM_SP_APP_S_DT, true);
           enableControl(IMG_SP_APP_S_DT, true);    	   
       }
    }
</script>

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if( btnSaveClick || row < 1)
    	return true;
    
    if( DS_MASTER.IsUpdated || DS_PBNPMK.IsUpdated || DS_STRPBN.IsUpdated || DS_PBNVENEMP.IsUpdated){
    	//변경된 상세내역이 존재합니다 이동하시겠습니까>
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1){
            if( DS_PBNPMK.IsUpdated){
            	setTabItemIndex("TAB_MAIN",1);
                setTimeout("GD_PBNPMK.Focus();",50);
            }else if(DS_MASTER.IsUpdated){
                setTabItemIndex("TAB_MAIN",1);
                setTimeout("EM_I_PUMBUN_NM.Focus();",50);            	
            }else if(DS_STRPBN.IsUpdated){
                setTabItemIndex("TAB_MAIN",2);            	
                setTimeout("EM_SP_BUY_ORG_CD.Focus();",50);
            }else if(DS_PBNVENEMP.IsUpdated){
                setTabItemIndex("TAB_MAIN",3);
                setTimeout("GD_PBNVENEMP.Focus();",50);
            }
            return false;
        }
        DS_MASTER.UndoAll();
    }

    DS_STRPBN.ClearData();
    DS_PBNPMK.ClearData();
    DS_PBNVENEMP.ClearData();
    return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid, "DS_MASTER,DS_PBNPMK,DS_STRPBN,DS_PBNVENEMP" );
    
</script>

<script language=JavaScript for=GD_PBNPMK event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_STRPBN event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_PBNVENEMP event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
 
 

<script language=JavaScript for=GD_PBNVENEMP event=CanColumnPosChange(row,colid)>
    var orgValue = DS_PBNVENEMP.OrgNameValue(row,colid);
    var newValue = DS_PBNVENEMP.NameValue(row,colid);
    var changeFlag = orgValue != newValue || DS_PBNVENEMP.RowStatus(row) == 1 ? newValue != '' : false;

    switch(colid){
        case 'EMAIL':
            if( changeFlag ){
                if(!isValidStrEmail(newValue)){
                    showMessage(EXCLAMATION, OK,"USER-1004","이메일");
                    return false;
                }
            }
            break;
    }
    return true;
</script>
 
 
<script language=JavaScript for=GD_PBNPMK event=OnExit(row,colid,oldData)>

    var orgValue = DS_PBNPMK.OrgNameValue(row,colid);
    var newValue = DS_PBNPMK.NameValue(row,colid);
    var changeFlag = oldData != newValue  ;
    switch(colid){
        case 'PUMMOK_CD':
            if( changeFlag ){
            	// 이름을 클리어 한다.
            	DS_PBNPMK.NameValue(row,"PUMMOK_NAME") = "";
                DS_PBNPMK.NameValue(row,"PUMMOK_SRT_CD") = "";
            	// 코드가 비어있을 경우 무시
            	if(newValue == ''){
                    return true;
            	}
                // 20120508 * DHL * 수정 -->
            	// var pummokLvl = LC_I_SKU_FLAG.BindColVal == "1"?"4":"3";
            	var pummokLvl = "4";
                // 20120508 * DHL * 수정 <--
                
                // 이름을 가져온다.업을시 팝업 실행 (popup_dps.js)
                var popupData = setPummokNmWithoutToGridPop('DS_SEARCH_NM',newValue,'','1', '', pummokLvl,'','Y')
                // 팝업에서 값을 선택하거나 명이 존재할 시 값을 입력한다. 
            	if(popupData != null){
            		DS_PBNPMK.NameValue(row,"PUMMOK_CD") = popupData.get("PUMMOK_CD");
                    DS_PBNPMK.NameValue(row,"PUMMOK_SRT_CD") = popupData.get("PUMMOK_SRT_CD");
            		DS_PBNPMK.NameValue(row,"PUMMOK_NAME") = popupData.get("PUMMOK_NAME");
            		DS_PBNPMK.NameValue(row,"TAG_FLAG") = popupData.get("TAG_FLAG");
                // 값이 존재하지 않거나 아무것도 선택하지 않을시 클리어
            	} else {
            		DS_PBNPMK.NameValue(row,"PUMMOK_CD") = "";
            		DS_PBNPMK.NameValue(row,"PUMMOK_NAME") = "";
                    DS_PBNPMK.NameValue(row,"PUMMOK_SRT_CD") = "";
                    setTimeout("setFocusGrid(GD_PBNPMK,DS_PBNPMK,"+row+",'PUMMOK_CD');",50);
            	}
            }
            break;
    }
    return true;
</script>
<script language=JavaScript for=GD_PBNPMK event=OnPopup(row,colid,data)>
    // 20120508 * DHL * 수정 -->
	// var pummokLvl = LC_I_SKU_FLAG.BindColVal == "1"?"4":"3";
	var pummokLvl = "4";
    // 20120508 * DHL * 수정 <--
    // 팝업 실행 (popup_dps.js)
    var popupData = pummokToGridPop( data, '', '', pummokLvl,'','Y');
    // 팝업에서 선택하였을때 처리
    if(popupData != null){
    	DS_PBNPMK.NameValue(row,"PUMMOK_CD") = popupData.get("PUMMOK_CD");
    	DS_PBNPMK.NameValue(row,"PUMMOK_NAME") = popupData.get("PUMMOK_NAME");
    	DS_PBNPMK.NameValue(row,"TAG_FLAG") = popupData.get("TAG_FLAG");
        DS_PBNPMK.NameValue(row,"PUMMOK_SRT_CD") = popupData.get("PUMMOK_SRT_CD");
    // 팝업에서 아무것도 선택하지 않았을때 처리
    } else {
    	// 명이 존재 하지 않으면 코드도 클리어한다.
    	if( DS_PBNPMK.NameValue(row,"PUMMOK_NAME") == ""){
    		DS_PBNPMK.NameValue(row,"PUMMOK_CD") = "";
            DS_PBNPMK.NameValue(row,"PUMMOK_SRT_CD") = "";
    		
            setTimeout("setFocusGrid(GD_PBNPMK,DS_PBNPMK,"+row+",'PUMMOK_CD');",50);		
    	}
    }
</script>
 

<script language=JavaScript for=EM_O_REC_PUMBUN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setRecPumbunCode('NAME',EM_O_REC_PUMBUN,EM_O_REC_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_I_REC_PUMBUN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setRecPumbunCode('NAME',EM_I_REC_PUMBUN,EM_I_REC_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_O_VEN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setVenCode('NAME','S',EM_O_VEN,EM_O_VEN_NM);
</script>
<script language=JavaScript for=EM_I_VEN event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
    setVenCode('NAME','I',EM_I_VEN,EM_I_VEN_NM);
</script>
<script language=JavaScript for=EM_O_PUMBUN event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
    setPumbunCode('NAME','S',EM_O_PUMBUN,EM_O_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_SP_BUY_ORG_CD event=OnKillFocus()>

    var orgValue = DS_STRPBN.OrgNameValue(DS_STRPBN.RowPosition,"BUY_ORG_CD");

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;

    DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
    DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
    EM_SP_BUY_ORG_NM.Text = "";
    if( this.Text ==""){
        return;     
    }
    var strCd = LC_I_ITG_ORD_FLAG.BindColVal == 'Y'? '' : LC_SP_STR_CD.BindColVal;
    var rtnVal = setOrgNmWithoutPop('DS_SEARCH_NM', this, EM_SP_BUY_ORG_NM, 'N', '1','','','2','4','Y',strCd);
    if(DS_SEARCH_NM.CountRow > 0 || rtnVal != null){
    	if( DS_SEARCH_NM.CountRow > 0){
            if( DS_SEARCH_NM.NameValue(1,"PC_CD") == "00" || DS_SEARCH_NM.NameValue(1,"CORNER_CD") !="00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "매입조직은 PC 레벨에서 선택하여야 합니다.");
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
                EM_SP_BUY_ORG_NM.Text = "";
                return;         
            }
    	} else if(rtnVal != null){
            if( rtnVal.get("PC_CD") == "00" || rtnVal.get("CORNER_CD") !="00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "매입조직은 PC 레벨에서 선택하여야 합니다.");
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
                EM_SP_BUY_ORG_NM.Text = "";
                return;         
            }
    	}
        searchMainBuyer(this,"BUY");
    }else{
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
    }
</script>
<script language=JavaScript for=EM_SP_SALE_ORG_CD event=OnKillFocus()>
    var orgValue = DS_STRPBN.OrgNameValue(DS_STRPBN.RowPosition,"SALE_ORG_CD");

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    EM_SP_SALE_ORG_NM.Text = "";
    DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
    DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
    if( this.Text ==""){
        return;    	
    }   
    
    var rtnVal = setOrgNmWithoutPop('DS_SEARCH_NM', this, EM_SP_SALE_ORG_NM, 'N', '1','','','1','5','Y',LC_SP_STR_CD.BindColVal);

    if(DS_SEARCH_NM.CountRow > 0 || rtnVal != null){
        if( DS_SEARCH_NM.CountRow > 0){
            if( DS_SEARCH_NM.NameValue(1,"CORNER_CD") =="00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "매입조직은 코너 레벨에서 선택하여야 합니다.");
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
                EM_SP_SALE_ORG_NM.Text = "";
                return;         
            }
        } else if(rtnVal != null){
            if(  rtnVal.get("CORNER_CD") =="00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "판매조직은 코너 레벨에서 선택하여야 합니다.");
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
                DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
                EM_SP_SALE_ORG_NM.Text = "";
                return;         
            }     
        }
        searchMainBuyer(this,"SALE");
    }else{
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
    }
    
</script>
<script language=JavaScript for=EM_I_APP_S_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    //if( !checkDateTypeYMD(this,getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))),"DS_MASTER","APP_S_DT"))
    if( !checkDateTypeYMD(this,getRawData(addDate('D',0,getTodayFormat('YYYYMMDD'))),"DS_MASTER","APP_S_DT"))
        return;
    var orgValue = DS_MASTER.OrgNameValue(DS_MASTER.RowPosition,"APP_S_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    if( toDate >= this.Text){
        showMessage(EXCLAMATION, OK,"USER-1030","적용시작일");
        if(DS_MASTER.RowStatus(DS_MASTER.RowPosition) == 1)
            //DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_S_DT") = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        	DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_S_DT") = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        else
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_S_DT") = orgValue;
        return;
    }
</script>
<script language=JavaScript for=EM_I_APP_E_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if( !checkDateTypeYMD(this,'99991231',"DS_MASTER","APP_E_DT"))
        return;
    var appSDt = DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_S_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    if( toDate >= this.Text){
        showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_E_DT") = "99991231";
        return;
    }
    if( appSDt >= this.Text){
        showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"APP_E_DT") = "99991231";
        return;
    }
</script>


<script language=JavaScript for=EM_SP_APP_S_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    //if( !checkDateTypeYMD(this,getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))),"DS_STRPBN","APP_S_DT"))
    if( !checkDateTypeYMD(this,getRawData(addDate('D',0,getTodayFormat('YYYYMMDD'))),"DS_STRPBN","APP_S_DT"))
        return;

    var orgValue = DS_STRPBN.OrgNameValue(DS_STRPBN.RowPosition,"APP_S_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    if( toDate >= this.Text){
        showMessage(EXCLAMATION, OK,"USER-1030","적용시작일");
        if(DS_STRPBN.RowStatus(DS_STRPBN.RowPosition) == 1)
            //DS_STRPBN.NameValue(DS_STRPBN.RowPosition,"APP_S_DT") = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
            DS_STRPBN.NameValue(DS_STRPBN.RowPosition,"APP_S_DT") = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));
        else
            DS_STRPBN.NameValue(DS_STRPBN.RowPosition,"APP_S_DT") = orgValue;
    }    
</script>
<script language=JavaScript for=EM_SP_APP_E_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if( !checkDateTypeYMD(this,'99991231',"DS_STRPBN","APP_E_DT"))
        return;
    var appSDt = DS_STRPBN.NameValue(DS_STRPBN.RowPosition,"APP_S_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    if( toDate >= this.Text){
        showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        DS_STRPBN.NameValue(DS_STRPBN.RowPosition,"APP_E_DT") = "99991231";
        return;
    }
    if( appSDt >= this.Text){
       showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
       DS_STRPBN.NameValue(DS_STRPBN.RowPosition,"APP_E_DT") = "99991231";
    }
</script>
<script language=JavaScript for=LC_I_ITG_ORD_FLAG event=OnSelChange()>
    if( this.BindColVal == "N" && !checkOrgDefStr()){
        showMessage(INFORMATION, OK,"USER-1000","매입조직에 타점의 조직이 등록 되어있습니다.");
        this.BindColVal = 'Y';
    }
</script>
<script language=JavaScript for=LC_I_BIZ_TYPE event=OnSelChange()>
    switch(this.BindColVal){
        case '5' :   // 임대을B
            enableControl(LC_I_ITG_ORD_FLAG, false);
            enableControl(LC_SP_SALE_BUY_FLAG, false);
            enableControl(LC_SP_SLIDING_FLAG, true); // MARIO OUTLET
            enableControl(LC_I_SKU_FLAG, false);
            setComboData(LC_SP_SALE_BUY_FLAG,"1");
            setComboData(LC_SP_SLIDING_FLAG,"1"); // MARIO OUTLET
            setComboData(LC_I_SKU_FLAG,"2");
            setComboData(LC_I_ITG_ORD_FLAG,"N");   
            document.getElementById('TH_SP_RENTB_MGAPP_FLAG').className = "point";
            enableControl(LC_SP_RENTB_MGAPP_FLAG, true);
        	break;
       /*  case '4' :   // 임대갑
            enableControl(LC_I_ITG_ORD_FLAG, false);
            enableControl(LC_SP_SALE_BUY_FLAG, false);
            enableControl(LC_SP_SLIDING_FLAG, true); // MARIO OUTLET
            enableControl(LC_I_SKU_FLAG, false);
            setComboData(LC_SP_SALE_BUY_FLAG,"1");
            setComboData(LC_SP_SLIDING_FLAG,"1"); // MARIO OUTLET
            setComboData(LC_I_SKU_FLAG,"2");
            setComboData(LC_I_ITG_ORD_FLAG,"N");   
            document.getElementById('TH_SP_RENTB_MGAPP_FLAG').className = "point";
            enableControl(LC_SP_RENTB_MGAPP_FLAG, true);
        	break; */
        case '3' :   // 임대을A
            enableControl(LC_I_ITG_ORD_FLAG, false);
            enableControl(LC_SP_SALE_BUY_FLAG, false);
            enableControl(LC_SP_SLIDING_FLAG, false); // MARIO OUTLET
            enableControl(LC_I_SKU_FLAG, true);
            setComboData(LC_SP_SALE_BUY_FLAG,"1");
            setComboData(LC_SP_SLIDING_FLAG,"0"); // MARIO OUTLET
            //setComboData(LC_I_SKU_FLAG,"2");
            setComboData(LC_I_ITG_ORD_FLAG,"N");    
            document.getElementById('TH_SP_RENTB_MGAPP_FLAG').className = "";
            enableControl(LC_SP_RENTB_MGAPP_FLAG, false);   
            break;
        case '2' :   // 특정매입
            enableControl(LC_I_ITG_ORD_FLAG, false);
            enableControl(LC_SP_SALE_BUY_FLAG, true);
            enableControl(LC_SP_SLIDING_FLAG, true); // MARIO OUTLET
            enableControl(LC_SP_ADV_ORD_YN, false); 
            enableControl(LC_I_SKU_FLAG, true);  
            setComboData(LC_I_ITG_ORD_FLAG,"N");     
            setComboData(LC_SP_ADV_ORD_YN,"N");     
            document.getElementById('TH_SP_RENTB_MGAPP_FLAG').className = "";
            enableControl(LC_SP_RENTB_MGAPP_FLAG, false);   
            break;
        case '1' :   // 직매입
            enableControl(LC_I_ITG_ORD_FLAG, true);
            enableControl(LC_SP_SALE_BUY_FLAG, false);
            enableControl(LC_SP_SLIDING_FLAG, false); // MARIO OUTLET
            enableControl(LC_I_SKU_FLAG, true);
            setComboData(LC_SP_SALE_BUY_FLAG,"1");   
            setComboData(LC_SP_SLIDING_FLAG,"0"); // MARIO OUTLET
            document.getElementById('TH_SP_RENTB_MGAPP_FLAG').className = "";
            enableControl(LC_SP_RENTB_MGAPP_FLAG, false);   
            break;
    }
</script>

<!-- MARIO OUTLET -->
<script language=JavaScript for=LC_SP_SALE_BUY_FLAG event=OnSelChange()>
    switch(this.BindColVal){
    case '1' :   // 사전매입
        enableControl(LC_SP_SLIDING_FLAG, false); // MARIO OUTLET
        setComboData(LC_SP_SLIDING_FLAG, "0");    // MARIO OUTLET
        break;
    case '2' :   // 판매분매입
        enableControl(LC_SP_SLIDING_FLAG, true);  // MARIO OUTLET
        setComboData(LC_SP_SLIDING_FLAG, "0");    // MARIO OUTLET
        break;
    }
</script>
<!-- MARIO OUTLET -->

<script language=JavaScript for=LC_I_SKU_FLAG event=OnSelChange()>
    if(  this.BindColVal == '1' && this.Enable ){
        enableControl(LC_I_SKU_TYPE, true);
        //enableControl(LC_I_ITG_ORD_FLAG, true);
    }else{
        enableControl(LC_I_SKU_TYPE, false);
        enableControl(LC_I_STYLE_TYPE, false);
        setComboData(LC_I_SKU_TYPE,"");    
        setComboData(LC_I_STYLE_TYPE,"");    
        //enableControl(LC_I_ITG_ORD_FLAG, false);
        setComboData(LC_I_ITG_ORD_FLAG,"N");    
    }
</script>
<script language=JavaScript for=LC_I_SKU_TYPE event=OnSelChange()>
    if(  this.BindColVal == '3' && this.Enable ){
        enableControl(LC_I_STYLE_TYPE, true);
    }else{
        enableControl(LC_I_STYLE_TYPE, false);
        setComboData(LC_I_STYLE_TYPE,"");
    }

    if( ( this.BindColVal == '3' || this.BindColVal == '1') && LC_I_BIZ_TYPE.BindColVal == '1' ){
        enableControl(LC_SP_ADV_ORD_YN, true);
    }else{
        enableControl(LC_SP_ADV_ORD_YN, false);
        setComboData(LC_SP_ADV_ORD_YN,"N");
    }
</script>

<script language=JavaScript for=LC_SP_EVALU_YN event=OnSelChange()>
    if(  this.BindColVal == 'Y'  ){
        enableControl(EM_SP_AREA_SIZE, true);
        //TH_SP_AREA_SIZE.className = "point";
    }else{
    	TH_SP_AREA_SIZE.className = "";
        EM_SP_AREA_SIZE.Text = "";
        enableControl(EM_SP_AREA_SIZE, false);
    }
</script>
<script language=JavaScript for=LC_SP_STR_CD event=OnSelChange()>
    var strFlag = this.ValueByColumn("CODE", this.BindColVal, "STR_FLAG");
    if( strFlag == "0"){
        setObjTypeStyle( EM_SP_SALE_ORG_CD, 'EMEDIT', NORMAL);
        document.getElementById("TH_SP_SALE_ORG_CD").className = "";
        document.getElementById("TH_SP_CHAR_SM_NM").className = "";
    }else{
        setObjTypeStyle( EM_SP_SALE_ORG_CD, 'EMEDIT', PK);   
        document.getElementById("TH_SP_SALE_ORG_CD").className = "point";  
        document.getElementById("TH_SP_CHAR_SM_NM").className = "point";        
    }
</script>  
<script language=JavaScript for=EM_I_BRAND event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
setBrandCd('NAME','S',EM_I_BRAND,EM_I_BRAND_NM);
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
<object id="DS_O_BIZ_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_TAX_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PUMBUN_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PUMBUN_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SKU_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SKU_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STYLE_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_ITG_ORD_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BIZ_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_TAG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_TAG_PRT_OWN_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PBNPMK_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_VEN_TASK_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PBNVENEMP_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SP_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 20120507 * DHL 추가 STR -->
<comment id="_NSID_">
<object id="DS_SP_VEN_MNG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 20120507 * DHL 추가 END -->

<comment id="_NSID_">
<object id="DS_SP_SALE_BUY_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- MARIO OUTLET -->
<comment id="_NSID_">
<object id="DS_SP_SLIDING_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- MARIO OUTLET -->

<comment id="_NSID_">
<object id="DS_SP_CHK_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SP_RENTB_MGAPP_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 
<comment id="_NSID_">
<object id="DS_SP_COST_CAL_WAY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
 -->
<comment id="_NSID_">
<object id="DS_SP_ADV_ORD_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SP_EVALU_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SP_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SP_EDI_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 20120507 * DHL 추가 STR -->
<comment id="_NSID_">
<object id="DS_SP_HALL_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 20120507 * DHL 추가 END -->

<comment id="_NSID_">
<object id="DS_SP_FLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_PBN_COND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BUYER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_VENMST" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STRPBN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PBNVENEMP" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PBNPMK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
						<th width="80">거래형태</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_O_BIZ_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">단품구분</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_O_SKU_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">브랜드유형</th>
						<td><comment id="_NSID_"> <object
							id=LC_O_PUMBUN_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>브랜드구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_O_PUMBUN_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>단품종류</th>
						<td><comment id="_NSID_"> <object id=LC_O_SKU_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>사용여부</th>
						<td><comment id="_NSID_"> <object id=LC_O_USE_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>대표브랜드</th>
						<td><comment id="_NSID_"> <object
							id=EM_O_REC_PUMBUN classid=<%=Util.CLSID_EMEDIT%> width=50
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:setRecPumbunCode('POP',EM_O_REC_PUMBUN,EM_O_REC_PUMBUN_NM);"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_REC_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=60
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>협력사</th>
						<td><comment id="_NSID_"> <object id=EM_O_VEN
							classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:setVenCode('POP','S',EM_O_VEN,EM_O_VEN_NM)"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>브랜드</th>
						<td><comment id="_NSID_"> <object id=EM_O_PUMBUN
							classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:setPumbunCode('POP','S',EM_O_PUMBUN,EM_O_PUMBUN_NM);"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=60
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
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
				<td width="400">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_MASTER
							width="100%" height=456 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10" >
				<div id=TAB_MAIN width="100%" height=480 TitleWidth=90 TitleAlign="center" TitleGap=3 >
					<menu TitleName="브랜드"         DivId="tab_page1" ClickBfFunc="clickPumbunTab" />
					<menu TitleName="점별브랜드"     DivId="tab_page2" ClickBfFunc="clickStrPbnTab" />
					<menu TitleName="협력사담당자"   DivId="tab_page3" ClickBfFunc="clickPbnVenEmpTab" />
				</div>
				<div id=tab_page1 width="100%"  >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						
						<td class="sub_title PB03 PT10"  >
							<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 브랜드정보</td>
									<td>
									<table width="100%">
						            <td align="right">
												<table border="0" cellspacing="0" cellpadding="0">
												  <tr>
												    <td class="btn_l"> </td>
												    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_pbn_emg()">긴급브랜드전송</a></td>
												    <td class="btn_r"></td>
												  </tr>
												</table>                
							                </td>			
										</tr>
									</table>				
						            </td>
						            
						</table>
						</td>

<td>
						            												
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="100" class="point">브랜드코드</th>
								<td width="140"><comment id="_NSID_"> <object
									id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=140
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="100" class="point">브랜드명</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=140
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">영수증명</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_RECP_NM classid=<%=Util.CLSID_EMEDIT%> width=140
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th class="point">협력사</th>
								<td><comment id="_NSID_"> <object id=EM_I_VEN
									classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_VEN
									class="PR03"
									onclick="javascript:setVenCode('POP','I',EM_I_VEN,EM_I_VEN_NM);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_I_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=65
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">거래형태</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_BIZ_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=140
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th class="point">브랜드구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_PUMBUN_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
									tabindex=1 width=140 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>대표브랜드</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_I_REC_PUMBUN classid=<%=Util.CLSID_EMEDIT%> width=50
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
									id=IMG_REC_PUMBUN class="PR03"
									onclick="javascript:setRecPumbunCode('POP',EM_I_REC_PUMBUN,EM_I_REC_PUMBUN_NM);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_I_REC_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=175
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">브랜드유형</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_PUMBUN_TYPE classid=<%= Util.CLSID_LUXECOMBO %>
									width=140 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="point">과세구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_TAX_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">단품구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_SKU_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="point">단품종류</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_SKU_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">의류단품<br>
								코드구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_STYLE_TYPE classid=<%= Util.CLSID_LUXECOMBO %>
									width=140 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="point">통합발주여부</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_ITG_ORD_FLAG classid=<%= Util.CLSID_LUXECOMBO %>
									width=140 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>공통브랜드</th>
								<td><comment id="_NSID_"> <object id=EM_I_BRAND
									classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_BRAND
									class="PR03"
									onclick="javascript:setBrandCd('POP', 'S', EM_I_BRAND,EM_I_BRAND_NM);"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_I_BRAND_NM classid=<%=Util.CLSID_EMEDIT%> width=65
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th class="point">사용여부</th>
								<td><comment id="_NSID_"> <object id=LC_I_USE_YN
									classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th class="point">적용시작일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=120
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_APP_S_DT
									align="absmiddle" class="PR03"
									onclick="javascript:openCal('G',EM_I_APP_S_DT)" /></td>
								<th class="point">적용종료일</th>
								<td><comment id="_NSID_"> <object
									id=EM_I_APP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=120
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_APP_E_DT
									align="absmiddle" class="PR03"
									onclick="javascript:openCal('G',EM_I_APP_E_DT)" /></td>
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
									align="absmiddle" /> 관리품목</td>
								<td class="right PB02" valign="bottom"><img
									src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_PMK_ADD width="52"
									height="18" onclick="javascript:btn_addPbnpmkRow();" hspace="2" /><img
									src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_PMK_DEL width="52"
									height="18" onclick="javascript: btn_delPbnpmkRow();" /></td>
									<td>
									<table width="100%">
						            <td align="right">
												<table border="0" cellspacing="0" cellpadding="0">
												  <tr>
												    <td class="btn_l"> </td>
												    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_pmk_emg()">긴급품목전송</a></td>
												    <td class="btn_r"></td>
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
						<td>
						<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
							width="100%">
							<tr>
								<td><comment id="_NSID_"><object id=GD_PBNPMK
									width="100%" height=155 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_PBNPMK">
								</object></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</div>
				
				<div id=tab_page2>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"   >
								<tr>
									<td class="sub_title PB03 PT10"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 점별  브랜드 정보</td>							
								<td class="right PB02" valign="bottom"><img
									src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
									onclick="javascript: btn_addStrpbnRow();" hspace="2" /><img
									src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
									onclick="javascript: btn_delStrpbnRow();" /></td>
								</tr>		
								<tr>
									<td width="100%">
											<comment id="_NSID_">
												<object id=GD_STRPBN width="140%" height=100 classid=<%=Util.CLSID_GRID%>>
													<param name="DataID" value="DS_STRPBN">
												</object>
											</comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="PT03">
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
									<tr>
										<th width="90" class="point">점</th> <!-- colspan="3" -->
										<td width="191"><comment id="_NSID_"> <object
											id=LC_SP_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190
											tabindex=1 align="absmiddle"></object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<th width="70">협력사관리</th>
										<td width="800">
										    <comment id="_NSID_">
		                                    <object id=LC_SP_VEN_MNG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=110 tabindex=1 align="absmiddle"> </object>
											</comment>
		                                    <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
									    <!-- MARIO OUTLET -->
										<!-- <th width="90" class="point">매입조직</th>  -->
										<!-- MARIO OUTLET -->
										<th width="90" class="point">매입조직</th>
										<td width="191"><comment id="_NSID_"> <object
											id=EM_SP_BUY_ORG_CD classid=<%=Util.CLSID_EMEDIT%> width=75
											tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
											onclick="javascript:getOrgPop(EM_SP_BUY_ORG_CD,EM_SP_BUY_ORG_NM,'BUY');"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_SP_BUY_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width=86
											tabindex=1 align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script>
										</td>
										<th width="70" class="point">바이어</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_CHAR_BUYER_NM classid=<%=Util.CLSID_EMEDIT%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point" id=TH_SP_SALE_ORG_CD>판매조직</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_SALE_ORG_CD classid=<%=Util.CLSID_EMEDIT%> width=75
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
											onclick="javascript:getOrgPop(EM_SP_SALE_ORG_CD,EM_SP_SALE_ORG_NM,'SALE');"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_SP_SALE_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width=86
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th id=TH_SP_CHAR_SM_NM class="point">SM</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_CHAR_SM_NM classid=<%=Util.CLSID_EMEDIT%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">판매분매입<br>/슬라이딩</th>
										<td>
										  <comment id="_NSID_">
										  <object id=LC_SP_SALE_BUY_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"> </object>
										  </comment>
										  <script> _ws_(_NSID_);</script>
										  <!-- MARIO OUTLET -->
										  <comment id="_NSID_">
										  <object id=LC_SP_SLIDING_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"> </object>
										  </comment>
										  <script> _ws_(_NSID_);</script>
										  <!-- MARIO OUTLET -->
										</td>
										<th class="point">검품여부</th>
										<td>
										    <comment id="_NSID_">
		                                    <object id=LC_SP_CHK_YN classid=<%=Util.CLSID_LUXECOMBO%> width=110 tabindex=1 align="absmiddle"> </object>
											</comment>
		                                    <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr><!-- 
										<th class="point">원가산정방법</th>
										<td><comment id="_NSID_"> <object
											id=LC_SP_COST_CAL_WAY classid=<%=Util.CLSID_LUXECOMBO%>
											width=190 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td> -->
		                                <th id=TH_SP_RENTB_MGAPP_FLAG >임대B수수료구분</th>
		                                <td><comment id="_NSID_"> <object
		                                    id=LC_SP_RENTB_MGAPP_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
		                                    width=190 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
		                                </td> 
										<th class="point">최저마진율</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_LOW_MG_RATE classid=<%=Util.CLSID_EMEDIT%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>								
		                                <th class="point">관/층</th>
		                                <td><comment id="_NSID_"> <object
		                                    id=LC_SP_HALL_CD classid=<%=Util.CLSID_LUXECOMBO%> 
		                                    width=95 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
		                                    <comment id="_NSID_"> <object
		                                    id=LC_SP_FLOR_CD classid=<%=Util.CLSID_LUXECOMBO%>
		                                    width=95 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
		                                </td>
										<th id=TH_SP_AREA_SIZE >면적(㎡)</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_AREA_SIZE classid=<%=Util.CLSID_EMEDIT%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">권고발주여부</th>
										<td ><comment id="_NSID_"> <object
											id=LC_SP_ADV_ORD_YN classid=<%=Util.CLSID_LUXECOMBO%> width=190
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th class="point">평가대상여부</th>
										<td><comment id="_NSID_"> <object
											id=LC_SP_EVALU_YN classid=<%=Util.CLSID_LUXECOMBO%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">사용여부</th>
										<td ><comment id="_NSID_"> <object
											id=LC_SP_USE_YN classid=<%=Util.CLSID_LUXECOMBO%> width=190
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th class="point">POS사용여부</th>
										<td ><comment id="_NSID_"> <object
											id=LC_SP_PUSE_YN classid=<%=Util.CLSID_LUXECOMBO%> width=190
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">E-MAIL</th>
										<td ><comment id="_NSID_"> <object
											id=EM_SP_E_MAIL classid=<%=Util.CLSID_EMEDIT%> width=200
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										
										<th class="point">매장전화번호</th>
										<td ><comment id="_NSID_"> <object
											id=EM_TEL_NO1 classid=<%=Util.CLSID_EMEDIT%> width=35
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>-
											<comment id="_NSID_"> <object
											id=EM_TEL_NO2 classid=<%=Util.CLSID_EMEDIT%> width=35
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>-
											<comment id="_NSID_"> <object
											id=EM_TEL_NO3 classid=<%=Util.CLSID_EMEDIT%> width=35
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">적용시작일</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
											src="/<%=dir%>/imgs/btn/date.gif" id=IMG_SP_APP_S_DT
											align="absmiddle" class="PR03"
											onclick="javascript:if( EM_SP_APP_S_DT.Enable ) openCal('G',EM_SP_APP_S_DT)" />
										</td>
										<th class="point">적용종료일</th>
										<td><comment id="_NSID_"> <object
											id=EM_SP_APP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
											src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											class="PR03"
											onclick="javascript:if( EM_SP_APP_E_DT.Enable ) openCal('G',EM_SP_APP_E_DT)" />
										</td>
									</tr>
									
									<tr>
										<th class="point">EDI사용여부</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=LC_SP_EDI_YN classid=<%=Util.CLSID_LUXECOMBO%> width=190
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				
				<div id=tab_page3>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title PB03 PT10"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 브랜드 담당자 정보</td>
								<td class="right PB02" valign="bottom"><img
									src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
									onclick="javascript: if(GD_PBNVENEMP.Editable) btn_addPbnvenempRow();"
									hspace="2" /><img src="/<%=dir%>/imgs/btn/del_row.gif"
									width="52" height="18"
									onclick="javascript: if(GD_PBNVENEMP.Editable) btn_delPbnvenempRow();" />
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
							width="100%">
							<tr>
								<td><comment id="_NSID_"><object id=GD_PBNVENEMP
									width="100%" height=350 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_PBNVENEMP">
								</object></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr class="PT10">
						<td class="FS11 red" style="display:none">※ 협력사의 기본 담당자는 수정 할 수 없습니다.</td>
					</tr>
					<tr class="PT05">
						<td class="FS11 red" style="display:none">※ EDI 사용 업체의 경우 EDI담당자 정보가 있어야 EDI 사용자
						정보 SMS 전송이 가능 합니다.</td>
					</tr>
					<tr class="PT05">
						<td class="FS11 red" style="display:none">※ 스마일EDI 사용 업체의 경우 정산 담당자 정보가 있어야
						전자세금계산서 처리가 가능 합니다.</td>
					</tr>
				</table>

				</div>
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
<object id=BO_PBN_COND classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_I_PBN_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=BIZ_TYPE          ctrl=LC_O_BIZ_TYPE      param=BindColVal </c>
            <c>col=SKU_FLAG          ctrl=LC_O_SKU_FLAG      param=BindColVal </c>
            <c>col=PUMBUN_TYPE       ctrl=LC_O_PUMBUN_TYPE   param=BindColVal </c>
            <c>col=PUMBUN_FLAG       ctrl=LC_O_PUMBUN_FLAG   param=BindColVal </c>
            <c>col=SKU_TYPE          ctrl=LC_O_SKU_TYPE      param=BindColVal </c>
            <c>col=USE_YN            ctrl=LC_O_USE_YN        param=BindColVal </c>
            <c>col=REC_PUMBUN        ctrl=EM_O_REC_PUMBUN    param=Text </c>
            <c>col=VEN_CD            ctrl=EM_O_VEN           param=Text </c>
            <c>col=VEN_NAME          ctrl=EM_O_VEN_NM        param=Text </c>
            <c>col=PUMBUN_CD         ctrl=EM_O_PUMBUN        param=Text </c>
            <c>col=PUMBUN_NAME       ctrl=EM_O_PUMBUN_NM     param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BO_MASTER classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=PUMBUN_CD         ctrl=EM_I_PUMBUN_CD     param=Text </c>
            <c>col=PUMBUN_NAME       ctrl=EM_I_PUMBUN_NM     param=Text </c>
            <c>col=VEN_CD            ctrl=EM_I_VEN           param=Text </c>
            <c>col=VEN_NAME          ctrl=EM_I_VEN_NM        param=Text </c>
            <c>col=RECP_NAME         ctrl=EM_I_RECP_NM       param=Text </c>
            <c>col=BIZ_TYPE          ctrl=LC_I_BIZ_TYPE      param=BindColVal </c>
            <c>col=REP_PUMBUN_CD     ctrl=EM_I_REC_PUMBUN    param=Text </c>
            <c>col=REP_PUMBUN_NAME   ctrl=EM_I_REC_PUMBUN_NM param=Text </c>
            <c>col=PUMBUN_FLAG       ctrl=LC_I_PUMBUN_FLAG   param=BindColVal</c>
            <c>col=PUMBUN_TYPE       ctrl=LC_I_PUMBUN_TYPE   param=BindColVal </c>
            <c>col=TAX_FLAG          ctrl=LC_I_TAX_FLAG      param=BindColVal </c>
            <c>col=SKU_FLAG          ctrl=LC_I_SKU_FLAG      param=BindColVal </c>
            <c>col=SKU_TYPE          ctrl=LC_I_SKU_TYPE      param=BindColVal </c>
            <c>col=STYLE_TYPE        ctrl=LC_I_STYLE_TYPE    param=BindColVal </c>
            <c>col=ITG_ORD_FLAG      ctrl=LC_I_ITG_ORD_FLAG  param=BindColVal </c>
            <c>col=BRAND_CD          ctrl=EM_I_BRAND         param=Text </c>
            <c>col=BRAND_NM          ctrl=EM_I_BRAND_NM      param=Text </c>
            <c>col=USE_YN            ctrl=LC_I_USE_YN        param=BindColVal </c>
            <c>col=APP_S_DT          ctrl=EM_I_APP_S_DT      param=Text </c>
            <c>col=APP_E_DT          ctrl=EM_I_APP_E_DT      param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BO_STRPBN classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_STRPBN>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=STR_CD            ctrl=LC_SP_STR_CD            param=BindColVal</c>
            <c>col=VEN_MNG_FLAG      ctrl=LC_SP_VEN_MNG_FLAG      param=BindColVal </c>
            <c>col=BUY_ORG_CD        ctrl=EM_SP_BUY_ORG_CD        param=Text </c>
            <c>col=BUY_ORG_NM        ctrl=EM_SP_BUY_ORG_NM        param=Text </c>
            <c>col=CHAR_BUYER_NM     ctrl=EM_SP_CHAR_BUYER_NM     param=Text </c>
            <c>col=SALE_ORG_CD       ctrl=EM_SP_SALE_ORG_CD       param=Text </c>
            <c>col=SALE_ORG_NM       ctrl=EM_SP_SALE_ORG_NM       param=Text </c>
            <c>col=CHAR_SM_NM        ctrl=EM_SP_CHAR_SM_NM        param=Text </c>
            <c>col=SALE_BUY_FLAG     ctrl=LC_SP_SALE_BUY_FLAG     param=BindColVal </c>
            <c>col=SLIDING_FLAG      ctrl=LC_SP_SLIDING_FLAG      param=BindColVal </c>
            <c>col=CHK_YN            ctrl=LC_SP_CHK_YN            param=BindColVal </c>
            <c>col=RENTB_MGAPP_FLAG  ctrl=LC_SP_RENTB_MGAPP_FLAG  param=BindColVal </c>                        
            <c>col=LOW_MG_RATE       ctrl=EM_SP_LOW_MG_RATE       param=Text </c>            
            <c>col=HALL_CD           ctrl=LC_SP_HALL_CD           param=BindColVal </c>
            <c>col=FLOR_CD           ctrl=LC_SP_FLOR_CD           param=BindColVal </c>
            <c>col=AREA_SIZE         ctrl=EM_SP_AREA_SIZE         param=Text </c>
            <c>col=ADV_ORD_YN        ctrl=LC_SP_ADV_ORD_YN        param=BindColVal </c>
            <c>col=EVALU_YN          ctrl=LC_SP_EVALU_YN          param=BindColVal </c>
            <c>col=USE_YN            ctrl=LC_SP_USE_YN            param=BindColVal </c>
            <c>col=EDI_YN            ctrl=LC_SP_EDI_YN            param=BindColVal </c>
            <c>col=MPOS_USE          ctrl=LC_SP_PUSE_YN           param=BindColVal </c>
            <c>col=E_MAIL            ctrl=EM_SP_E_MAIL            param=Text </c>
            <c>col=TEL_NO1           ctrl=EM_TEL_NO1	          param=Text </c>
            <c>col=TEL_NO2           ctrl=EM_TEL_NO2	          param=Text </c>
            <c>col=TEL_NO3           ctrl=EM_TEL_NO3	          param=Text </c>
            <c>col=APP_S_DT          ctrl=EM_SP_APP_S_DT          param=Text </c>
            <c>col=APP_E_DT          ctrl=EM_SP_APP_E_DT          param=Text </c>   
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
