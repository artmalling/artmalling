<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 의류잡화단품관리(A-Type)
 * 작 성 일 : 2010.03.15
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod5030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 의류잡화단품(A-Type)의 스타일정보 및 단품정보를 관리한다
 * 이    력 :
 *        2010.03.15 (정진영) 신규작성
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
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfMasterRow=0;
 var btnSaveYn=false;
 var isOnPopup = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-16
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_STYLEMST"/>');
    DS_SKUMST.setDataHeader('<gauce:dataset name="H_SEL_SKUMST"/>');
    DS_STRSTYLE.setDataHeader('<gauce:dataset name="H_SEL_STRSTYLEMST"/>');
    DS_SKUDTL.setDataHeader('<gauce:dataset name="H_SEL_STRSKUMST"/>');
    DS_O_COPY_POINT.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

    //탭초기화
    initTab('TAB_MAIN');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //단품정보
    gridCreate3(); //점별단품정보
    gridCreate4(); //단품상세정보

    // EMedit에 초기화
    initEmEdit(EM_O_PUMBUN_CD        , "CODE^6"     , PK);          //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME      , "GEN"        , READ);        //브랜드명
    initEmEdit(EM_O_STYLE_CD         , "CODE^11"    , NORMAL);      //스타일코드
    initEmEdit(EM_O_STYLE_NAME       , "GEN^40"     , NORMAL);      //스타일명
    initEmEdit(EM_I_PUMBUN_CD        , "CODE^6"     , PK);          //브랜드코드
    initEmEdit(EM_I_PUMBUN_NAME      , "GEN"        , READ);        //브랜드명
    initEmEdit(EM_I_REP_PUMBUN_NAME  , "GEN"        , READ);        //대표브랜드
    initEmEdit(EM_I_VEN_NAME         , "GEN"        , READ);        //협력사
    initEmEdit(EM_I_STYLE_CD         , "CODE^14"    , READ);        //스타일코드
    initEmEdit(EM_I_STYLE_NAME       , "GEN^40"     , PK);          //스타일명
    initEmEdit(EM_I_RECP_NAME        , "GEN^20"     , PK);          //영수증명
    initEmEdit(EM_I_BRAND_CD         , "CODE^5"     , READ);        //브랜드코드
    initEmEdit(EM_I_BRAND_NAME       , "GEN"        , READ);        //브랜드명
    initEmEdit(EM_I_ORIGIN_AREA_CD   , "CODE^3"     , NORMAL);      //원산지코드
    initEmEdit(EM_I_ORIGIN_AREA_NAME , "GEN"        , READ);        //원산지명
    initEmEdit(EM_I_VEN_STYLE_CD     , "CODE^24"    , NORMAL);      //업체스타일
    initEmEdit(EM_I_BAS_SPEC_CD      , "NUMBER^6^2" , NORMAL);      //기본규격
    initEmEdit(EM_I_CMP_SPEC_CD      , "NUMBER^3^2" , NORMAL);      //구성규격
    initEmEdit(EM_I_MAKER_CD         , "CODE^6"     , NORMAL);      //메이커코드
    initEmEdit(EM_I_MAKER_NAME       , "GEN"        , READ);        //메이커명
    initEmEdit(EM_I_REMARK           , "GEN^100"    , NORMAL);      //비고

    //콤보 초기화
    initComboStyle(LC_O_PUMMOK_CD        , DS_O_PUMMOK_CD        , "CODE^0^60,NAME^0^120" , 1, NORMAL);          //품목
    initComboStyle(LC_O_BRAND_CD         , DS_O_BRAND_CD         , "CODE^0^60,NAME^0^120" , 1, NORMAL);          //브랜드
    initComboStyle(LC_O_SUB_BRD_CD       , DS_O_SUB_BRD_CD       , "CODE^0^60,NAME^0^120" , 1, NORMAL);          //서브브랜드
    initComboStyle(LC_O_PLAN_YEAR        , DS_O_PLAN_YEAR        , "CODE^0^60,NAME^0^120" , 1, NORMAL);          //기획년도
    initComboStyle(LC_O_SEASON_CD        , DS_O_SEASON_CD        , "CODE^0^60,NAME^0^120" , 1, NORMAL);          //시즌
    initComboStyle(LC_O_ITEM_CD          , DS_O_ITEM_CD          , "CODE^0^60,NAME^0^120" , 1, NORMAL);          //아이템
    initComboStyle(LC_I_PUMMOK_CD        , DS_I_PUMMOK_CD        , "CODE^0^60,NAME^0^90"  , 1, PK);              //품목
    initComboStyle(LC_I_SUB_BRD_CD       , DS_I_SUB_BRD_CD       , "CODE^0^30,NAME^0^120" , 1, PK);              //서브브랜드
    initComboStyle(LC_I_PLAN_YEAR        , DS_I_PLAN_YEAR        , "CODE^0^30,NAME^0^120" , 1, PK);              //기획년도
    initComboStyle(LC_I_SEASON_CD        , DS_I_SEASON_CD        , "CODE^0^30,NAME^0^120" , 1, PK);              //시즌
    initComboStyle(LC_I_ITEM_CD          , DS_I_ITEM_CD          , "CODE^0^30,NAME^0^120" , 1, PK);              //아이템
    initComboStyle(LC_I_SIZE_TYPE        , DS_I_SIZE_TYPE        , "CODE^0^30,NAME^0^120" , 1, PK);              //사이즈타입
    initComboStyle(LC_I_SEX_CD           , DS_I_SEX_CD           , "CODE^0^30,NAME^0^120" , 1, PK);              //성별
    initComboStyle(LC_I_CURRENCY_CD      , DS_I_CURRENCY_CD      , "CODE^0^30,NAME^0^120" , 1, NORMAL);          //통화코드
    initComboStyle(LC_I_SALE_UNIT_CD     , DS_I_SALE_UNIT_CD     , "CODE^0^30,NAME^0^120" , 1, PK);              //판매단위
    initComboStyle(LC_I_BAS_SPEC_UNIT_CD , DS_I_BAS_SPEC_UNIT_CD , "CODE^0^30,NAME^0^120" , 1, NORMAL);          //기본규격단위
    initComboStyle(LC_I_USE_YN           , DS_I_USE_YN           , "CODE^0^30,NAME^0^120" , 1, PK);              //사용여부
    initComboStyle(LC_I_CMP_SPEC_UNIT_CD , DS_I_CMP_SPEC_UNIT_CD , "CODE^0^30,NAME^0^120" , 1, NORMAL);          //구성규격단위
    initComboStyle(LC_O_COPY_POINT       , DS_O_COPY_POINT       , "CODE^0^30,NAME^0^120" , 1, PK);              //복사기준점
    initComboStyle(LC_O_USE_YN           , DS_O_USE_YN           , "CODE^0^30,NAME^0^120" , 1, PK);              //사용여부 CENTRAL
    

    //0보다 큰값 입력(NUMBER)
    EM_I_BAS_SPEC_CD.NumericRange = "0~+:0";
    EM_I_CMP_SPEC_CD.NumericRange = "0~+:0";
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_PLAN_YEAR", "D", "P012", "Y");
    getEtcCode("DS_O_SEASON_CD", "D", "P035", "Y");
    getEtcCode("DS_O_ITEM_CD", "D", "P036", "Y");
    getEtcCode("DS_I_SUB_BRD_CD", "D", "P031", "N");
    getEtcCode("DS_I_PLAN_YEAR", "D", "P012", "N");
    getEtcCode("DS_I_SEASON_CD", "D", "P035", "N");
    getEtcCode("DS_I_ITEM_CD", "D", "P036", "N");
    getEtcCode("DS_I_SIZE_TYPE", "D", "P027", "N");
    getEtcCode("DS_I_SEX_CD", "D", "P032", "N");
    getEtcCode("DS_I_CURRENCY_CD", "D", "P065", "N");
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");
    getEtcCode("DS_I_BAS_SPEC_UNIT_CD", "D", "P013", "N");
    getEtcCode("DS_I_USE_YN", "D", "D022", "N");
    getEtcCode("DS_I_CMP_SPEC_UNIT_CD", "D", "P013", "N");
    getEtcCode("DS_O_USE_YN", "D", "D022", "N"); //CENTRAL
    
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");
    getEtcCodeRefer("DS_I_SIZE_CD", "D", "P026", "N");

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_PUMMOK_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    DS_O_BRAND_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    DS_O_SUB_BRD_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    
    //빈값 추가
    insComboFirstNullId(LC_I_CURRENCY_CD,"");
    insComboFirstNullId(LC_I_BAS_SPEC_UNIT_CD,"");
    insComboFirstNullId(LC_I_CMP_SPEC_UNIT_CD,"");

    // 기본값 입력( gauce.js )
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD, "%", "전체", 1 );
    insComboData(LC_O_USE_YN,    "%", "전체", 1 ); //CENTRAL
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_PUMMOK_CD,"%");
    setComboData(LC_O_BRAND_CD,"%");
    setComboData(LC_O_SUB_BRD_CD,"%");
    setComboData(LC_O_PLAN_YEAR,"%");
    setComboData(LC_O_SEASON_CD,"%");
    setComboData(LC_O_ITEM_CD,"%");
    setComboData(LC_I_CURRENCY_CD,"");
    setComboData(LC_I_BAS_SPEC_UNIT_CD,"");
    setComboData(LC_I_CMP_SPEC_UNIT_CD,"");
    setComboData(LC_O_USE_YN,"%"); //CENTRAL
    
    
    DS_I_SIZE_CD.UseFilter = true;
    DS_SKUDTL.UseFilter = true;
    
    mainEnable( );
    
    //조회후 결과표시 초기화
    setPorcCount("CLEAR");
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod503","DS_MASTER,DS_SKUMST,DS_STRSTYLE,DS_SKUDTL" );
    
    
    EM_O_PUMBUN_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"          width=30   align=center</FC>'
                     + '<FC>id=STYLE_CD     name="스타일코드"  width=120    align=center</FC>'
                     + '<FC>id=STYLE_NAME   name="스타일명"    width=120   align=left</FC>'
                     + '<FC>id=PUMMOK_CD    name="품목"        width=100   align=left EditStyle=Lookup data="DS_O_PUMMOK_CD:CODE:NAME"</FC>'
                     + '<FC>id=USE_YN       name="사용여부"    width=60    align=left</FC>'
                     ;

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     name="NO"            width=30   align=center</FC>'
                     + '<FC>id=COLOR_CD     name="*칼라"          width=90   align=left edit={IF(CurStatus="I","true","false")} EditStyle=Lookup data="DS_I_COLOR_CD:CODE:NAME" ListCount=3</FC>'
                     + '<FC>id=SIZE_CD      name="*사이즈"        width=90   align=left edit={IF(CurStatus="I","true","false")} EditStyle=Lookup data="DS_I_SIZE_CD:CODE:NAME" ListCount=3</FC>'
                     + '<FC>id=SKU_CD       name="단품코드"      width=120   align=center edit="none"</FC>'
                     + '<FC>id=INPUT_PLU_CD name="소스마킹코드"  width=120   align=left edit={IF(CurStatus="I","true","false")} edit="Numeric"</FC>'
                     + '<FC>id=PLU_FLAG     name="PLU구분"      width=30  value={IF(INPUT_PLU_CD="","1","2")} align=center edit="none"  show=false</FC>';

    initGridStyle(GD_SKUMST, "common", hdrProperies, true);
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}      name="NO"           width=30  align=center</FC>'
                     + '<FC>id=SEL           name="선택"         width=30  value={IF(STYLE_CD="",IF(CurStatus="U","T","F"),"T")} align=center EditStyle=CheckBox</FC>'
                     + '<FC>id=STR_CD        name="*점"           width=80  edit="none"  align=left EditStyle=Lookup data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=SAL_COST_PRC  name="*판매원가"     width=70  edit="Numeric"  edit={IF(BIZ_TYPE="2" OR BIZ_TYPE="3" OR BIZ_TYPE="5","false",IF(STYLE_CD="","true","false"))}  align=right</FC>'
                     + '<FC>id=SALE_PRC      name="*판매매가"     width=70  edit="Numeric" edit={IF(STYLE_CD="","true","false")}  align=right</FC>'
                     + '<FC>id=SALE_MG_RATE  name="*마진율"       width=70  edit="RealNumeric" edit={IF(BIZ_TYPE="1","false",IF(STYLE_CD="","true","false"))}  align=right</FC>'
                     + '<FC>id=ADV_ORD_YN    name="*권고발주여부"  width=85  edit={IF(PBN_ADV_ORD_YN="Y","true","false")} EditStyle="Combo" data="Y:YES,N:NO" align=left</FC>'
                     + '<FC>id=SALE_S_DT     name="판매시작일"    width=85  edit="Numeric" edit={IF(STYLE_CD="" OR SALE_S_DT="","true",IF(SALE_S_DT<'+getTodayFormat("YYYYMMDD")+',"false","true"))}  mask="XXXX/XX/XX" EditStyle="Popup" align=center</FC>'
                     + '<FC>id=SALE_E_DT     name="판매종료일"    width=85  edit="Numeric" mask="XXXX/XX/XX" EditStyle="Popup" align=center</FC>'
                     + '<FC>id=BUY_S_DT      name="매입시작일"    width=85  edit="Numeric" edit={IF(STYLE_CD="" OR BUY_S_DT="","true",IF(BUY_S_DT<'+getTodayFormat("YYYYMMDD")+',"false","true"))} mask="XXXX/XX/XX" EditStyle="Popup" align=center</FC>'
                     + '<FC>id=BUY_E_DT      name="매입종료일"    width=85  edit="Numeric" mask="XXXX/XX/XX" EditStyle="Popup" align=center</FC>'
                     + '<FC>id=USE_YN        name="사용여부"      width=70  EditStyle="Combo" data="Y:YES,N:NO" align=left</FC>';

    initGridStyle(GD_STRSTYLE, "common", hdrProperies, false);
}


function gridCreate4(){
    var hdrProperies = '<FC>id={currow}      name="NO"         width=25   align=center</FC>'
                     + '<FC>id=COLOR_CD      name="칼라"       width=70   edit="none" align=left EditStyle=Lookup data="DS_I_COLOR_CD:CODE:NAME" </FC>'
                     + '<FC>id=SIZE_CD       name="사이즈"     width=45   edit="none"  align=left EditStyle=Lookup data="DS_I_SIZE_CD:CODE:NAME"</FC>'
                     + '<FC>id=SKU_CD        name="단품코드"   width=100   edit="none"  align=center</FC>'
                     + '<FC>id=STR_CD        name="점"         width=80  edit="none"   align=left EditStyle=Lookup data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=LOW_ORD_QTY   name="최초발주량"  width=70  edit="Numeric" edit={IF(ADV_ORD_YN="Y","true","false")} align=right</FC>'
                     + '<FC>id=OTM_STK_QTY   name="적정재고량"  width=70  edit="Numeric" edit={IF(ADV_ORD_YN="Y","true","false")} align=right</FC>'
                     + '<FC>id=LEAD_TIME     name="리드타임"    width=70  edit="Numeric" edit={IF(ADV_ORD_YN="Y","true","false")} align=right</FC>';

    initGridStyle(GD_SKUDTL, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_MASTER.IsUpdated || DS_SKUMST.IsUpdated || DS_SKUDTL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1059")!=1){
            EM_I_STYLE_NAME.Focus();
            return;
        }
    }  
    DS_MASTER.ClearData();
    DS_SKUMST.ClearData();
    DS_STRSTYLE.ClearData();
    DS_SKUDTL.ClearData();

    mainEnable( );
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strPummokCd   = LC_O_PUMMOK_CD.BindColVal;
    var strStyleCd    = EM_O_STYLE_CD.Text;
    var strStyleName  = EM_O_STYLE_NAME.Text;
    var strBrandCd    = LC_O_BRAND_CD.BindColVal;
    var strSubBrdCd   = LC_O_SUB_BRD_CD.BindColVal;
    var strPlanYear   = LC_O_PLAN_YEAR.BindColVal;
    var strSeasonCd   = LC_O_SEASON_CD.BindColVal;
    var strItemCd     = LC_O_ITEM_CD.BindColVal;
    var strUseYn      = LC_O_USE_YN.BindColVal; //CENTRAL
    
    if( strPumbunCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NAME.Text == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }

    var goTo       = "searchStyle" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd=" +encodeURIComponent(strPumbunCd)
                   + "&strPummokCd=" +encodeURIComponent(strPummokCd)
                   + "&strStyleCd="	 +encodeURIComponent(strStyleCd)
                   + "&strStyleName="+encodeURIComponent(strStyleName)
                   + "&strBrandCd="  +encodeURIComponent(strBrandCd)
                   + "&strSubBrdCd=" +encodeURIComponent(strSubBrdCd)
                   + "&strPlanYear=" +encodeURIComponent(strPlanYear)
                   + "&strSeasonCd=" +encodeURIComponent(strSeasonCd)
                   + "&strItemCd="	 +encodeURIComponent(strItemCd)
                   + "&strUseYn="	 +encodeURIComponent(strUseYn); //CENTRAL
    
    bfMasterRow = 0;               
    TR_SUB.Action="/dps/pcod503.pc?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_STYLEMST=DS_MASTER)"; //조회는 O
    TR_SUB.Post();
    
    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if( DS_SKUMST.IsUpdated || DS_SKUDTL.IsUpdated){
        //변경된 상세내역이 존재합니다. 신규추가하시겠습니까>
        if( showMessage(QUESTION, YESNO, "USER-1050")!=1){
        	if(DS_SKUMST.IsUpdated){
        		setTabItemIndex('TAB_MAIN',2);
                GD_SKUMST.Focus();
        	}else{
                setTabItemIndex('TAB_MAIN',3);
                GD_STRSTYLE.Focus();        		
        	}
            return;                   
        }                
        refreshTab(2);
        refreshTab(3);
    }
     if( DS_MASTER.IsUpdated){
    	 var yesNoFlag;
    	 if(DS_MASTER.RowStatus(DS_MASTER.RowPosition)==1){
             //초기화하시겠습니까?
    		 yesNoFlag = showMessage(QUESTION, YESNO, "USER-1051")!=1;
    	 }else{
             //변경된 상세내역이 존재합니다. 신규입력하시겠습니까?
             yesNoFlag = showMessage(QUESTION, YESNO, "USER-1050")!=1;
    	 }
    	 
         if( yesNoFlag){
             setTabItemIndex('TAB_MAIN',1);
             EM_I_STYLE_NAME.Focus();
             return false;                   
         }
         refreshTab(1);
     }
     setTabItemIndex('TAB_MAIN',1);
     DS_SKUMST.ClearData();
     DS_STRSTYLE.ClearData();
     DS_SKUDTL.ClearData();
     DS_MASTER.addRow();
     DS_MASTER.NameValue(DS_MASTER.CountRow,"USE_YN") = "Y";
     EM_I_BAS_SPEC_CD.Text = '';   
	 mainEnable( true);
	 DS_MASTER.NameValue(DS_MASTER.CountRow,"PUMBUN_CD") = EM_O_PUMBUN_CD.Text;       
	 if(replaceStr(EM_O_PUMBUN_CD.Text," ","").length == 6){
	     setPumbunCode('NAME','I');
	 }
	 
	 EM_I_PUMBUN_CD.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-16
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-16
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated && !DS_SKUMST.IsUpdated && !DS_SKUDTL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if(DS_MASTER.CountRow <1){
        	EM_O_PUMBUN_CD.Focus();
        }else{
        	GD_MASTER.Focus();
        }
        return;
    }
    
    if( !checkStyleValidation())
        return;
    if( !checkSkuMstValidation())
        return;
    if( !checkStrStyleValidation())
        return;
    if( !checkSkuDtlValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_I_STYLE_NAME.Focus();
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	EM_I_STYLE_NAME.Focus();
        return;    	
    }
    var strStyleCd = EM_I_STYLE_CD.Text;
    var strStyleName = EM_I_STYLE_NAME.Text;
    var strSkuUpdateGb = checkModSkuItm(DS_MASTER.RowPosition)?'Y':'N';
    var parameters = "&strSkuUpdateGb="+encodeURIComponent(strSkuUpdateGb);
    btnSaveYn = true;
    TR_MAIN.Action="/dps/pcod503.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER,I:DS_SKUMST=DS_SKUMST,I:DS_SKUDTL=DS_SKUDTL)"; //조회는 O
    TR_MAIN.Post();
    btnSaveYn = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        var row = 1;
        if(strStyleCd != ""){
            row = DS_MASTER.NameValueRow('STYLE_CD',strStyleCd);
        }else{
            row = DS_MASTER.NameValueRow('STYLE_NAME',strStyleName);
        }
        row = row<1?1:row;
        DS_MASTER.RowPosition = row;    	
    }
    EM_I_STYLE_NAME.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-16
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-16
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
*************************************************************************/

/**
* btn_addRow()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 단품정보 행을 추가한다.
*/
function btn_addRow(){
    var row = DS_MASTER.RowPosition;
	if( row < 1){
		showMessage(EXCLAMATION, OK, "USER-1042","스타일 정보");
        EM_I_STYLE_NAME.Focus();
		return;
	}
	
	DS_SKUMST.addRow();
    var pumbunCd = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var pumbunType = DS_MASTER.NameValue(row,"PUMBUN_TYPE");
    var styleCd = DS_MASTER.NameValue(row,"STYLE_CD");
    var skuRow = DS_SKUMST.CountRow;
    DS_SKUMST.NameValue(skuRow,"PUMBUN_TYPE") = pumbunType;
    DS_SKUMST.NameValue(skuRow,"STYLE_CD") = styleCd;
    DS_SKUMST.NameValue(skuRow,"PUMBUN_CD") = pumbunCd;
    
    setFocusGrid(GD_SKUMST,DS_SKUMST,skuRow,'COLOR_CD');
}

/**
* btn_delRow()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 단품정보 행을 삭제한다.
*/
function btn_delRow(){
	var row = DS_SKUMST.RowPosition;
	if( row < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
	if(DS_SKUMST.RowStatus(row)!=1){
		// 신규 입력데이터만 삭제 가능합니다.
		showMessage(INFORMATION, OK, "USER-1052");
		GD_SKUMST.Focus();
		return;
	}
	DS_SKUMST.deleteRow(row);
}

/**
* btn_rowCopy()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 점별스타일정보 행을 복사한다.
*/
function btn_rowCopy(){
   var strCd = LC_O_COPY_POINT.BindColVal;
   if( strCd == ''){
       // (복사기준점)은/는 반드시 선택해야 합니다.
       showMessage(EXCLAMATION, OK, "USER-1002", "복사기준점");
       LC_O_COPY_POINT.Focus();
       return;     
   }
	   
   var copyRow = DS_STRSTYLE.NameValueRow("STR_CD", strCd);
   var row = DS_STRSTYLE.RowPosition;
	   
   //복사기준점과 같은면 무시 
   if( copyRow==row)
       return;
   
   if( DS_STRSTYLE.NameValue(row,"STYLE_CD")!=""){
       // 신규데이터만 행복사가 가능합니다.
       showMessage(EXCLAMATION, OK, "USER-1070", "행복사");    
       GD_STRSTYLE.Focus();   
       return;
   }
   var toDay = getTodayFormat("YYYYMMDD");
   DS_STRSTYLE.NameValue(row,"SAL_COST_PRC") = DS_STRSTYLE.NameValue(copyRow,"SAL_COST_PRC");
   DS_STRSTYLE.NameValue(row,"SALE_PRC") = DS_STRSTYLE.NameValue(copyRow,"SALE_PRC");
   DS_STRSTYLE.NameValue(row,"SALE_MG_RATE") = DS_STRSTYLE.NameValue(copyRow,"SALE_MG_RATE");
   DS_STRSTYLE.NameValue(row,"ADV_ORD_YN") = DS_STRSTYLE.NameValue(row,"PBN_ADV_ORD_YN")=='Y'?DS_STRSTYLE.NameValue(copyRow,"ADV_ORD_YN"):'N';
   DS_STRSTYLE.NameValue(row,"SALE_S_DT") = DS_STRSTYLE.NameValue(copyRow,"SALE_S_DT")<toDay?toDay:DS_STRSTYLE.NameValue(copyRow,"SALE_S_DT");
   DS_STRSTYLE.NameValue(row,"SALE_E_DT") = DS_STRSTYLE.NameValue(copyRow,"SALE_E_DT")<toDay?'99991231':DS_STRSTYLE.NameValue(copyRow,"SALE_E_DT");
   DS_STRSTYLE.NameValue(row,"BUY_S_DT") = DS_STRSTYLE.NameValue(copyRow,"BUY_S_DT")<toDay?toDay:DS_STRSTYLE.NameValue(copyRow,"BUY_S_DT");
   DS_STRSTYLE.NameValue(row,"BUY_E_DT") = DS_STRSTYLE.NameValue(copyRow,"BUY_E_DT")<toDay?'99991231':DS_STRSTYLE.NameValue(copyRow,"BUY_E_DT");
   DS_STRSTYLE.NameValue(row,"USE_YN") = "Y";

   setCopyPoint();
   copyRowData(row);
}

/**
* btn_rowClear()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 점별스타일정보 행을 초기화한다.
*/
function btn_rowClear(){
    if( !GD_STRSTYLE.Editable)
        return;
    DS_STRSTYLE.Undo(DS_STRSTYLE.RowPosition);
    copyRowData(DS_STRSTYLE.RowPosition);
}

/**
* searchSkumst()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 단품정보를 조회
*/
function searchSkumst(){

    var strPumbunCd   = EM_I_PUMBUN_CD.Text;
    var strStyleCd    = EM_I_STYLE_CD.Text;
    
    if( strPumbunCd == ""){
        return;
    }
    
    if( EM_I_PUMBUN_NAME.Text == ""){
        return;
    }

    var goTo       = "searchSkumst" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strStyleCd=" +encodeURIComponent(strStyleCd);
    
    TR_MAIN.Action="/dps/pcod503.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_SKUMST=DS_SKUMST)"; //조회는 O
    TR_MAIN.Post();
    
}

/**
* searchStrStyle()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 점별스타일정보를 조회
*/
function searchStrStyle(){

    var strPumbunCd   = EM_I_PUMBUN_CD.Text;
    var strStyleCd    = EM_I_STYLE_CD.Text;
    
    if( strPumbunCd == ""){
        return;
    }
    
    if( EM_I_PUMBUN_NAME.Text == ""){
        return;
    }

    getStrPbnCode('DS_STR_CD',strPumbunCd,'N');
    
    var goTo       = "searchStrstyle" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strStyleCd=" +encodeURIComponent(strStyleCd);
    
    TR_MAIN.Action="/dps/pcod503.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_STRSTYLEMST=DS_STRSTYLE)"; //조회는 O
    TR_MAIN.Post();

    setCopyPoint();
}

/**
* searchStrSku()
* 작 성 자 : 
* 작 성 일 : 2010-03-16
* 개    요 : 점별단품정보를 조회
*/
function searchStrSku(){

    var strPumbunCd   = EM_I_PUMBUN_CD.Text;
    var strStyleCd    = EM_I_STYLE_CD.Text;
    
    if( strPumbunCd == ""){
        return;
    }
    
    if( EM_I_PUMBUN_NAME.Text == ""){
        return;
    }

    var goTo       = "searchStrsku" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strStyleCd=" +encodeURIComponent(strStyleCd);
    
    TR_MAIN.Action="/dps/pcod503.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_STRSKUMST=DS_SKUDTL)"; //조회는 O
    TR_MAIN.Post();
    
}

/**
 * checkModSkuItm() 
 * 작 성 자 : 
 * 작 성 일 : 2010-03-23
 * 개    요 : 변경된 스타일 정보중 단품정보가 존재하는지 체크
 */
function checkModSkuItm( row){
     if( DS_MASTER.OrgNameValue(row,"STYLE_NAME") != DS_MASTER.NameValue(row,"STYLE_NAME"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"RECP_NAME") != DS_MASTER.NameValue(row,"RECP_NAME"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"PUMMOK_CD") != DS_MASTER.NameValue(row,"PUMMOK_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"VEN_STYLE_CD") != DS_MASTER.NameValue(row,"VEN_STYLE_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"SALE_UNIT_CD") != DS_MASTER.NameValue(row,"SALE_UNIT_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"CMP_SPEC_CD") != DS_MASTER.NameValue(row,"CMP_SPEC_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"CMP_SPEC_UNIT") != DS_MASTER.NameValue(row,"CMP_SPEC_UNIT"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"BAS_SPEC_CD") != DS_MASTER.NameValue(row,"BAS_SPEC_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"BAS_SPEC_UNIT") != DS_MASTER.NameValue(row,"BAS_SPEC_UNIT"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"ORIGIN_AREA_CD") != DS_MASTER.NameValue(row,"ORIGIN_AREA_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"MAKER_CD") != DS_MASTER.NameValue(row,"MAKER_CD"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"REMARK") != DS_MASTER.NameValue(row,"REMARK"))
         return true;
     if( DS_MASTER.OrgNameValue(row,"USE_YN") != DS_MASTER.NameValue(row,"USE_YN"))
         return true;     
     return false;
}
/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 브랜드 팝입 및 이름 조회
 */
function setPumbunCode( evnflag, srvFlag){
    var codeObj = srvFlag=="S"?EM_O_PUMBUN_CD:EM_I_PUMBUN_CD;
    var nameObj = srvFlag=="S"?EM_O_PUMBUN_NAME:EM_I_PUMBUN_NAME;
    var pmkComboObj = srvFlag=="S"?LC_O_PUMMOK_CD:LC_I_PUMMOK_CD;
    eval(pmkComboObj.ComboDataID).ClearData();
    if( srvFlag == "I"){
    	EM_I_REP_PUMBUN_NAME.Text = "";
        EM_I_VEN_NAME.Text = "";
        
        // MARIO OUTLET
        EM_I_BRAND_CD.Text = "";
        EM_I_BRAND_NAME.Text = "";
        
    }else{
        DS_O_BRAND_CD.ClearData();
        DS_O_SUB_BRD_CD.ClearData();
        
        // 기본값 입력( gauce.js )
        insComboData( pmkComboObj, "%", "전체", 1 );
        insComboData( LC_O_BRAND_CD, "%", "전체", 1 );
        insComboData( LC_O_SUB_BRD_CD, "%", "전체", 1 );        
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(pmkComboObj,"%");
        setComboData(LC_O_BRAND_CD,"%");
        setComboData(LC_O_SUB_BRD_CD,"%");    	
    }
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var result = null;
	if( evnflag == "POP" ){
        result = strPbnPop2(codeObj,nameObj,'Y','','','','','','',srvFlag=="S"?'':'Y','1','3','','','','1');
        codeObj.Focus();        
    }else if( evnflag == "NAME" ){
        nameObj.Text = "";
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'','','','','','',srvFlag=="S"?'':'Y','1','3','','','','1');
    }

    if( result == null && DS_SEARCH_NM.CountRow != 1){
    	return;
    }
    var pumbunCd = codeObj.Text;
	if(srvFlag == "I"){
        getPumbunInfo("DS_SEARCH_NM",pumbunCd);
        
        if( DS_SEARCH_NM.CountRow > 0){
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"REP_PUMBUN_NAME") = DS_SEARCH_NM.NameValue(1,"REP_PUMBUN_NAME");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_NAME") = DS_SEARCH_NM.NameValue(1,"VEN_NAME");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"PUMBUN_TYPE") = DS_SEARCH_NM.NameValue(1,"PUMBUN_TYPE");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"SKU_TYPE") = DS_SEARCH_NM.NameValue(1,"SKU_TYPE");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"STYLE_TYPE") = DS_SEARCH_NM.NameValue(1,"STYLE_TYPE");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"BIZ_TYPE") = DS_SEARCH_NM.NameValue(1,"BIZ_TYPE");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"TAX_FLAG") = DS_SEARCH_NM.NameValue(1,"TAX_FLAG");
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"BRAND_CD") = DS_SEARCH_NM.NameValue(1,"BRAND_CD"); // MARIO OUTLET
            DS_MASTER.NameValue(DS_MASTER.RowPosition,"BRAND_NAME") = DS_SEARCH_NM.NameValue(1,"BRAND_NM"); // MARIO OUTLET
                
        }
    }
    getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"N",srvFlag=="S"?null:'Y');
        
    if(srvFlag == "S"){

        //공통코드에서 가지고 오기( popup_dps.js )
        getStyleBrand("DS_O_BRAND_CD", pumbunCd, "Y");
        getStyleSubBrand("DS_O_SUB_BRD_CD", pumbunCd, "Y");
            
        //콤보에 '전체' 추가
        insComboData(pmkComboObj,"%","전체",1);
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(pmkComboObj,"%");
        setComboData(LC_O_BRAND_CD,"%");
        setComboData(LC_O_SUB_BRD_CD,"%");
    }else{
        setComboData(pmkComboObj,DS_MASTER.OrgNameValue(DS_MASTER.RowPosition,"PUMMOK_CD"));
    }
}
 /**
  * setStyleCode()
  * 작 성 자 : 
  * 작 성 일 : 2010-03-16
  * 개    요 : 스타일 팝입 및 이름 조회
  */
function setStyleCode( evnflag, srvFlag){
	
    var codeObj = srvFlag=="S"?EM_O_STYLE_CD:EM_I_STYLE_CD;
    var nameObj = srvFlag=="S"?EM_O_STYLE_NAME:EM_I_STYLE_NAME;
    var pumbunObj = srvFlag=="S"?EM_O_PUMBUN_CD:EM_I_PUMBUN_CD;

    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnflag == "POP" ){
        result = stylePop(codeObj,nameObj,'Y','',pumbunObj.Text,'','1');
        codeObj.Focus();
        
    }else if( evnflag == "NAME" ){
        nameObj.Text = "";
        result = setStyleNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",0,'',pumbunObj.Text,'','1');
    }
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
        codeObj.Focus();
        return;
    }

    nameObj.Text = "";
    setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
    codeObj.Focus();
}

/**
 * excelUpload()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 엑셀업로드
 * return값 : void
 */
function excelUpload(){
     showMessage(Information, OK, "USER-1000", "개발예정");
}
/**
 * tabClickBfFunc()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 텝 클릭 전 실행 함수
 * return값 : void
 */
function tabClickBfFunc( tabId, idx){
	
	switch(idx){
	    case 1:
            if( DS_SKUMST.IsUpdated){
                //변경된 상세내역이 존재합니다. 이동하시겠습니까>
                if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
                    GD_SKUMST.Focus();
                    return false;                   
                }                
                refreshTab(2);
                
            }
            if( DS_SKUDTL.IsUpdated){
            	//변경된 상세내역이 존재합니다. 이동하시겠습니까>
                if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
                    GD_STRSTYLE.Focus();
                	return false;                	
                }
                refreshTab(3);     
            }
	    	break;
	    case 2:
            if( DS_MASTER.IsUpdated){
                //변경된 상세내역이 존재합니다. 이동하시겠습니까>
                if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
                	EM_I_STYLE_NAME.Focus();
                    return false;                   
                }           
                refreshTab(1);     
            }
            if( DS_SKUDTL.IsUpdated){
                //변경된 상세내역이 존재합니다. 이동하시겠습니까>
                if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
                    GD_STRSTYLE.Focus();
                    return false;                   
                }           
                refreshTab(3);     
            }
            if(DS_MASTER.CountRow < 1){
                showMessage(INFORMATION, OK, "USER-1075", "이동");
                mainEnable();
                EM_O_PUMBUN_CD.Focus();
                return false;
            }
	    	break;
        case 3:
            if( DS_MASTER.IsUpdated){
                //변경된 상세내역이 존재합니다. 이동하시겠습니까>
                if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
                    EM_I_STYLE_NAME.Focus();
                    return false;                   
                }           
                refreshTab(1);     
            }
            if( DS_SKUMST.IsUpdated){
                //변경된 상세내역이 존재합니다. 이동하시겠습니까>
                if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
                    GD_SKUMST.Focus();
                    return false;                   
                }                
                refreshTab(2);
                
            }
            if(DS_MASTER.CountRow < 1){
                showMessage(INFORMATION, OK, "USER-1075", "이동");
                mainEnable();
                EM_O_PUMBUN_CD.Focus();
                return false;
            }
            break;
	}

    return true;
}

/**
 * tabClickFunc()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 탭 클릭 후 함수
 * return값 : void
 */
function tabClickFunc( tabId, idx){
    
    switch(idx){
        case 1:
        	EM_I_STYLE_NAME.Focus();
            break;
        case 2:
            searchSkumst();       
            gdSkumstEnable( true);     
            break;
        case 3:
            searchStrStyle();
            searchStrSku();
            gdStrstyleEnable( true);
            gdStrskuEnable( true)
        	GD_STRSTYLE.Focus();
            break;
    }

    return true;
}
/**
 * refreshTab()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 텝아이템을 초기화한다.
 * return값 : void
 */
function refreshTab(idx){
    
    switch(idx){
        case 1:
        	DS_MASTER.UndoAll();
        	bfMasterRow = 0;
        	if(DS_MASTER.RowPosition == 1){
                mainEnable( false);
        	}
            break;
        case 2:
            DS_SKUMST.UndoAll();
            break;
        case 3:
        	DS_STRSTYLE.UndoAll();
        	DS_SKUDTL.UndoAll();
            break;
    }
	
}

/**
 * mainEnable()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 스타일 정보 사용여부 지정
 * return값 : void
 */
function mainEnable( flag){
    
    enableControl(EM_I_STYLE_NAME       , flag!=null);
    enableControl(EM_I_RECP_NAME        , flag!=null);
    enableControl(EM_I_ORIGIN_AREA_CD   , flag!=null);
    enableControl(IMG_ORIGIN_AREA_CD    , flag!=null);
    enableControl(EM_I_VEN_STYLE_CD     , flag!=null);
    enableControl(EM_I_BAS_SPEC_CD      , flag!=null);
    enableControl(EM_I_CMP_SPEC_CD      , flag!=null);
    enableControl(EM_I_MAKER_CD         , flag!=null);
    enableControl(IMG_MAKER_CD          , flag!=null);
    enableControl(EM_I_REMARK           , flag!=null);

    enableControl(LC_I_PUMMOK_CD        , flag!=null);
    enableControl(LC_I_SEX_CD           , flag!=null);
    enableControl(LC_I_CURRENCY_CD      , flag!=null);
    enableControl(LC_I_SALE_UNIT_CD     , flag!=null);
    enableControl(LC_I_BAS_SPEC_UNIT_CD , flag!=null);
    enableControl(LC_I_USE_YN           , flag!=null);
    enableControl(LC_I_CMP_SPEC_UNIT_CD , flag!=null);
     
    enableControl(IMG_SEARCH_PUMBUN, flag==null?false:flag);
    enableControl(EM_I_PUMBUN_CD, flag==null?false:flag);
    ////enableControl(IMG_SEARCH_BRAND, flag==null?false:flag);
    ////enableControl(EM_I_BRAND_CD, flag==null?false:flag);
    enableControl(LC_I_SUB_BRD_CD, flag==null?false:flag);
    enableControl(LC_I_PLAN_YEAR, flag==null?false:flag);
    enableControl(LC_I_SEASON_CD, flag==null?false:flag);
    enableControl(LC_I_ITEM_CD, flag==null?false:flag);
    enableControl(LC_I_SIZE_TYPE, flag==null?false:flag);
}

/**
 * gdSkumstEnable()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 단품 정보 사용여부 지정
 * return값 : void
 */
function gdSkumstEnable( flag){
    enableControl(IMG_SKUADD, flag);
    enableControl(IMG_SKUDEL, flag);

    GD_SKUMST.Editable    = flag;
} 
/**
 * gdStrstyleEnable()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 점별 스타일 정보 사용여부 지정
 * return값 : void
 */
function gdStrstyleEnable( flag){
    enableControl(LC_O_COPY_POINT, flag);
    enableControl(IMG_ROWCOPY, flag);
    enableControl(IMG_ROWCLEAR, flag);

    GD_STRSTYLE.Editable    = flag;
} 

/**
 * gdStrskuEnable()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 점별단품 정보 사용여부 지정
 * return값 : void
 */
function gdStrskuEnable( flag){
    GD_SKUDTL.Editable    = flag;
} 

/**
 * setCopyPoint()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 복사기준점을 생성한다.
 * return값 : void
 */
function setCopyPoint(){
    DS_O_COPY_POINT.ClearData();
    for( var i=1; i<=DS_STRSTYLE.CountRow; i++){
        if( DS_STRSTYLE.NameValue(i,"SEL")=="T"||DS_STRSTYLE.RowStatus(i)==3){
            DS_O_COPY_POINT.addRow();
            DS_O_COPY_POINT.NameValue(DS_O_COPY_POINT.CountRow,"CODE") = DS_STRSTYLE.NameValue(i,"STR_CD");
            DS_O_COPY_POINT.NameValue(DS_O_COPY_POINT.CountRow,"NAME") = DS_STR_CD.NameValue(DS_STR_CD.NameValueRow("CODE",DS_STRSTYLE.NameValue(i,"STR_CD")),"NAME");
        }
    }
}

/**
 * copyRowData()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 점별 스타일정보의 변경된 데이터를 단품상세정보에 반영한다.
 * return값 : void
 */
function copyRowData( row){
	var salCostPrc = DS_STRSTYLE.NameValue(row,"SAL_COST_PRC");
    var salePrc = DS_STRSTYLE.NameValue(row,"SALE_PRC");
    var saleMgRate = DS_STRSTYLE.NameValue(row,"SALE_MG_RATE");
    var advOrdYn = DS_STRSTYLE.NameValue(row,"ADV_ORD_YN");
    var saleSDt = DS_STRSTYLE.NameValue(row,"SALE_S_DT");
    var saleEDt = DS_STRSTYLE.NameValue(row,"SALE_E_DT");
    var buySDt = DS_STRSTYLE.NameValue(row,"BUY_S_DT");
    var buyEDt = DS_STRSTYLE.NameValue(row,"BUY_E_DT");
    var useYn = DS_STRSTYLE.NameValue(row,"USE_YN");
    
    for(var i=1; i<= DS_SKUDTL.CountRow; i++){
    	DS_SKUDTL.NameValue(i,"SAL_COST_PRC") = salCostPrc;
        DS_SKUDTL.NameValue(i,"SALE_PRC") = salePrc;
        DS_SKUDTL.NameValue(i,"SALE_MG_RATE") = saleMgRate;
        DS_SKUDTL.NameValue(i,"ADV_ORD_YN") = advOrdYn;
        if(advOrdYn=='N'){
            DS_SKUDTL.NameValue(i,"LOW_ORD_QTY") = '';
            DS_SKUDTL.NameValue(i,"OTM_STK_QTY") = '';
            DS_SKUDTL.NameValue(i,"LEAD_TIME") = '';
        }
        DS_SKUDTL.NameValue(i,"SALE_S_DT") = saleSDt;
        DS_SKUDTL.NameValue(i,"SALE_E_DT") = saleEDt;
        DS_SKUDTL.NameValue(i,"BUY_S_DT") = buySDt;
        DS_SKUDTL.NameValue(i,"BUY_E_DT") = buyEDt;
        DS_SKUDTL.NameValue(i,"USE_YN") = useYn;
    }
}


/**
 * checkStyleValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 스타일정보 입력을 체크한다.
 * return값 : void
 */
function checkStyleValidation(){
    var check = false;
    var titleNm = "";
    var componentId = "";
    var compTyle = "";
    
    var row = DS_MASTER.RowPosition;
    var rowStatus = DS_MASTER.RowStatus(row);
    if( rowStatus == 0 
            || rowStatus == 2
            || rowStatus == 4)
            return true;
    
    if( rowStatus == 1 && DS_MASTER.NameValue( row, "PUMBUN_CD") == ''){
        check = true;
        titleNm = "브랜드";
        componentId = "EM_I_PUMBUN_CD";
        compTyle = "EM";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "PUMBUN_NAME") == ''){
        // 존재하지 않은 브랜드 입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드")
        EM_I_PUMBUN_CD.Focus();
        return false;
    }

    if( !check && DS_MASTER.NameValue( row, "STYLE_NAME") == ''){
        check = true;
        titleNm = "스타일명";
        componentId = "EM_I_STYLE_NAME";
        compTyle = "EM";
    }
    
    if( !checkInputByte( null, DS_MASTER, row, "STYLE_NAME", "스타일명", "EM_I_STYLE_NAME") )
        return false;

    if( !check && DS_MASTER.NameValue( row, "RECP_NAME") == ''){
        check = true;
        titleNm = "영수증명";
        componentId = "EM_I_RECP_NAME";
        compTyle = "EM";
    }

    if( !checkInputByte( null, DS_MASTER, row, "RECP_NAME", "영수증명", "EM_I_RECP_NAME") )
        return false;
    
    if( !check && DS_MASTER.NameValue( row, "PUMMOK_CD") == ''){
        check = true;
        titleNm = "품목";
        componentId = "LC_I_PUMMOK_CD";
        compTyle = "LC";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "BRAND_CD") == ''){
        check = true;
        titleNm = "브랜드";
        componentId = "EM_I_BRAND_CD";
        compTyle = "EM";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "BRAND_NAME") == ''){
        // 존재하지 않은 브랜드 입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드")
        EM_I_BRAND_CD.Focus();
        return false;
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "SUB_BRD_CD") == ''){
        check = true;
        titleNm = "서브브랜드";
        componentId = "LC_I_SUB_BRD_CD";
        compTyle = "LC";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "PLAN_YEAR") == ''){
        check = true;
        titleNm = "기획년도";
        componentId = "LC_I_PLAN_YEAR";
        compTyle = "LC";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "SEASON_CD") == ''){
        check = true;
        titleNm = "시즌";
        componentId = "LC_I_SEASON_CD";
        compTyle = "LC";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "ITEM_CD") == ''){
        check = true;
        titleNm = "아이템";
        componentId = "LC_I_ITEM_CD";
        compTyle = "LC";
    }

    if( !check && rowStatus == 1 && DS_MASTER.NameValue( row, "SIZE_TYPE") == ''){
        check = true;
        titleNm = "사이즈타입";
        componentId = "LC_I_SIZE_TYPE";
        compTyle = "LC";
    }

    if( !check && DS_MASTER.NameValue( row, "SEX_CD") == ''){
        check = true;
        titleNm = "성별";
        componentId = "LC_I_SEX_CD";
        compTyle = "LC";
    }
    if( !check && DS_MASTER.NameValue( row, "ORIGIN_AREA_CD") != '' && DS_MASTER.NameValue( row, "ORIGIN_AREA_NAME") == ''){
        // 존재하지 않은 원산지 입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "원산지")
        EM_I_ORIGIN_AREA_CD.Focus();
        return false;
    }
    
    if( !check && DS_MASTER.NameValue( row, "SALE_UNIT_CD") == ''){
        check = true;
        titleNm = "판매단위";
        componentId = "LC_I_SALE_UNIT_CD";
        compTyle = "LC";
    }

    if( !check && DS_MASTER.NameValue( row, "MAKER_CD") != '' && DS_MASTER.NameValue( row, "MAKER_NAME") == ''){
        // 존재하지 않은 메이커 입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "메이커")
        EM_I_MAKER_CD.Focus();
        return false;
    }

    if( !check && DS_MASTER.NameValue( row, "USE_YN") == ''){
        check = true;
        titleNm = "사용여부";
        componentId = "LC_I_USE_YN";
        compTyle = "LC";
    }    

    if( !checkInputByte( null, DS_MASTER, row, "REMARK", "비고", "EM_I_REMARK") )
        return false;
    
    if( check ){
        // ()은/는 반드시 입력(선택)해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        eval(componentId).Focus();
        return false;
    }
    return true;
	 
}

/**
 * checkSkuMstValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 단품정보 입력을 체크한다.
 * return값 : void
 */
function checkSkuMstValidation(){
    var check = false;
    var titleNm = "";
    var colId = "";
    var row = "";
    for(var i = 1; i <= DS_SKUMST.CountRow; i++ ) {
        var rowStatus = DS_SKUMST.RowStatus(i);
        if( rowStatus == 0 
                || rowStatus == 2
                || rowStatus == 4)
                continue;
        row = i;
        
        if( DS_SKUMST.NameValue( i, "COLOR_CD") == ''){
            check = true;
            titleNm = "칼라";
            colId = "COLOR_CD";
            break;
        }

        if( DS_SKUMST.NameValue( i, "SIZE_CD") == ''){
            check = true;
            titleNm = "사이즈";
            colId = "SIZE_CD";
            break;
        }
        var dupRow = checkDupKey( DS_SKUMST, "COLOR_CD||SIZE_CD" );
        if( dupRow > 0){
        	showMessage(EXCLAMATION, OK, "USER-1044");
            setFocusGrid(GD_SKUMST,DS_SKUMST,dupRow,"COLOR_CD");
        	return false;
        }
        if( DS_SKUMST.NameValue( i, "INPUT_PLU_CD")!=''){
        	var tmpInputPlu = lpad(DS_SKUMST.NameValue( i, "INPUT_PLU_CD"),13,"0");
            if( tmpInputPlu.substr(0,1)=='2'){
                setFocusGrid(GD_SKUMST,DS_SKUMST,i,"INPUT_PLU_CD");
                showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");
                return false;               
            }
            if(!isSkuCdCheckSum(tmpInputPlu)){
                setFocusGrid(GD_SKUMST,DS_SKUMST,i,"INPUT_PLU_CD");
                showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");
                return false;               
            }
        }
        dupRow = checkDupKey( DS_SKUMST, "SKU_CD" );
        if( dupRow > 0){
            showMessage(EXCLAMATION, OK, "USER-1044");
            setFocusGrid(GD_SKUMST,DS_SKUMST,dupRow,"SKU_CD");
            return false;
        }
        
        DS_SKUMST.NameValue( i, "PLU_FLAG") = GD_SKUMST.VirtualString(i, "PLU_FLAG");

    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_SKUMST,DS_SKUMST,row,colId);
        return false;
    }
    return true;
}
/**
 * checkStrStyleValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 점별스타일정보 입력을 체크한다.
 * return값 : void
 */
function checkStrStyleValidation(){

    var check = false;
    var titleNm = "";
    var colId = "";
    var row = "";
    for(var i = 1; i <= DS_STRSTYLE.CountRow; i++ ) {
        var rowStatus = DS_STRSTYLE.RowStatus(i);
        if( rowStatus == 0 
                || rowStatus == 2
                || rowStatus == 4)
                continue;
        row = i;
        var styleCd = DS_STRSTYLE.NameValue( i, "STYLE_CD");
        
        if( Number(DS_STRSTYLE.NameString( i, "SAL_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "판매원가","0");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,i,'SAL_COST_PRC');
            return false;                    
        }
        if( Number(DS_STRSTYLE.NameString( i, "SALE_PRC")) < 1 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "판매매가","1");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,i,'SALE_PRC');
            return false;                    
        }
        var lowMgRate = Number(DS_STRSTYLE.NameString( i, "LOW_MG_RATE"));
        if( Number(DS_STRSTYLE.NameString( i, "SALE_MG_RATE")) < lowMgRate ){
            if( lowMgRate == 0)
                showMessage(EXCLAMATION, Ok,  "USER-1020", "마진율",lowMgRate);
            else
                showMessage(EXCLAMATION, Ok,  "USER-1081", lowMgRate);
            
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,i,'SALE_MG_RATE');
            return false;                    
        }
        if( Number(DS_STRSTYLE.NameString( i, "SALE_MG_RATE")) > 100 ){
            showMessage(EXCLAMATION, Ok,  "USER-1021", "마진율","100");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,i,'SALE_MG_RATE');
            return false;                    
        }
        /* 필수체크 제외 (2010.03.18 : 김수현 요청)

        if( DS_STRSTYLE.NameValue( i, "SALE_S_DT") == ''){
            check = true;
            titleNm = "판매시작일";
            colId = "SALE_S_DT";
            break;
        }
        if( DS_STRSTYLE.NameValue( i, "SALE_E_DT") == ''){
            check = true;
            titleNm = "판매종료일";
            colId = "SALE_E_DT";
            break;
        }
        if( DS_STRSTYLE.NameValue( i, "BUY_S_DT") == ''){
            check = true;
            titleNm = "매입시작일";
            colId = "BUY_S_DT";
            break;
        }
        if( DS_STRSTYLE.NameValue( i, "BUY_E_DT") == ''){
            check = true;
            titleNm = "매입종료일";
            colId = "BUY_E_DT";
            break;
        }
        */

        var toDay = getTodayFormat("YYYYMMDD");

        if( DS_STRSTYLE.NameValue( i, "SALE_S_DT") != DS_STRSTYLE.OrgNameValue( i, "SALE_S_DT")
                && DS_STRSTYLE.NameValue( i, "SALE_S_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "판매시작일");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,"SALE_S_DT");
            return false;
        }
        if( DS_STRSTYLE.NameValue( i, "SALE_E_DT") != DS_STRSTYLE.OrgNameValue( i, "SALE_E_DT")
                && DS_STRSTYLE.NameValue( i, "SALE_E_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "판매종료일");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,"SALE_E_DT");
            return false;
        }
        if( DS_STRSTYLE.NameValue( i, "BUY_S_DT") != DS_STRSTYLE.OrgNameValue( i, "BUY_S_DT")
                && DS_STRSTYLE.NameValue( i, "BUY_S_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "매입시작일");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,"BUY_S_DT");
            return false;
        }
        if( DS_STRSTYLE.NameValue( i, "BUY_E_DT") != DS_STRSTYLE.OrgNameValue( i, "BUY_E_DT")
                && DS_STRSTYLE.NameValue( i, "BUY_E_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "매입종료일");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,"BUY_E_DT");
            return false;
        }
                
        if( DS_STRSTYLE.NameValue( i, "SALE_S_DT") > DS_STRSTYLE.NameValue( i, "SALE_E_DT")){

            showMessage(EXCLAMATION, OK, "USER-1008", "판매시작일","판매종료일");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,"SALE_E_DT");
            return false;
        }
        
        if( DS_STRSTYLE.NameValue( i, "BUY_S_DT") > DS_STRSTYLE.NameValue( i, "BUY_E_DT")){

            showMessage(EXCLAMATION, OK, "USER-1008", "매입시작일","매입종료일");
            setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,"BUY_E_DT");
            return false;
        }
        
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,row,colId);
        return false;
    }
    return true;
}

/**
 * checkSkuDtlValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 단품상세정보 입력을 체크한다.
 * return값 : void
 */
function checkSkuDtlValidation(){
    var check = false;
    var titleNm = "";
    var colId = "";
    var row = "";
    for(var i = 1; i <= DS_SKUDTL.CountRow; i++ ) {
        var rowStatus = DS_SKUDTL.RowStatus(i);
        if( rowStatus == 0 
                || rowStatus == 2
                || rowStatus == 4)
                continue;
        row = i;

        
        var ordYn = DS_SKUDTL.NameValue( i, "ADV_ORD_YN");
        if( ordYn == 'Y' && DS_SKUDTL.NameValue( i, "LOW_ORD_QTY") == ''){
            check = true;
            titleNm = "최소발주량";
            colId = "LOW_ORD_QTY";
            break;
        }
        if( ordYn == 'Y' && DS_SKUDTL.NameValue( i, "OTM_STK_QTY") == ''){
            check = true;
            titleNm = "적정재고량";
            colId = "OTM_STK_QTY";
            break;
        }
        if( ordYn == 'Y' && DS_SKUDTL.NameValue( i, "LEAD_TIME") == ''){
            check = true;
            titleNm = "리드타임";
            colId = "LEAD_TIME";
            break;
        }
        
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_SKUDTL,DS_SKUDTL,row,colId);
        return false;
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

<script language=JavaScript for=DS_I_SIZE_CD event=OnFilter(row)>
    var value = this.NameValue(row,"REFER_CODE");
    if( value != LC_I_SIZE_TYPE.BindColVal)
        return false;
    
    return true;
</script>
<script language=JavaScript for=DS_SKUDTL event=OnFilter(row)>
	var value = this.NameValue(row,"STR_CD");
    if( value != DS_STRSTYLE.NameValue(DS_STRSTYLE.RowPosition,"STR_CD"))
        return false;
    
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(row < 1 || btnSaveYn)
        return true;
    
    if(DS_MASTER.IsUpdated 
    	|| DS_SKUMST.IsUpdated 
    	|| DS_SKUDTL.IsUpdated){

        //변경된 상세내역이 존재합니다. 이동하시겠습니까>
        if( showMessage(QUESTION, YESNO, "USER-1049")!=1){
        	EM_I_STYLE_NAME.Focus();
            return false;                   
        }        
        refreshTab(1);
    	
    }
    DS_STRSTYLE.ClearData();
    DS_SKUDTL.ClearData();
</script> 
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfMasterRow == row)
        return;
    bfMasterRow = row;
    if( this.NameValue(row,"PUMBUN_CD")!= ""){
        getPbnPmkCode('DS_I_PUMMOK_CD',this.NameValue(row,"PUMBUN_CD"),"N",'Y');
        setComboData(LC_I_PUMMOK_CD,DS_MASTER.OrgNameValue(DS_MASTER.RowPosition,"PUMMOK_CD"));
        searchSkumst();
        searchStrStyle();
        searchStrSku();
    }
    mainEnable( false);
    gdSkumstEnable( true);
</script> 
<script language=JavaScript for=DS_STRSTYLE event=OnRowPosChanged(row)>
    if(row < 1 )
        return;
    
    DS_SKUDTL.Filter();
</script> 

<script language=JavaScript for=DS_MASTER event=OnColumnChanged(row,colId)>
    if(row < 1)
        return;
</script> 
 
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_SKUMST event=OnExit(row,colid,olddata)>
    if(row < 1 )
         return true;
    switch(colid){
        case 'INPUT_PLU_CD':
            var value = DS_SKUMST.NameValue(row,colid);
            if( value==""){
                DS_SKUMST.NameValue(row,"SKU_CD") = "";
                return true;
            }
            var tmpInputPlu = lpad(value,13,"0");
            if( tmpInputPlu.substr(0,1)=='2'){
                showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");        
                DS_SKUMST.NameValue(row,colid) = "";
                DS_SKUMST.NameValue(row,"SKU_CD") = "";
                return true;
            }
            if(!isSkuCdCheckSum(tmpInputPlu)){
                showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");
                DS_SKUMST.NameValue(row,colid) = "";
                DS_SKUMST.NameValue(row,"SKU_CD") = "";
                return false;               
            }
            DS_SKUMST.NameValue(row,"SKU_CD") = lpad(value,13,'0');
            break;
    }

</script>
 
  
 
<script language=JavaScript for=GD_STRSTYLE event=OnExit(row,colid)>
    if(row < 1 || btnSaveYn)
        return true;
    if(isOnPopup)
    	return;
    switch(colid){
        case 'SAL_COST_PRC':
        case 'SALE_PRC':
        case 'SALE_MG_RATE':
            var bizType = DS_MASTER.NameValue(DS_MASTER.RowPosition,"BIZ_TYPE");
            var taxFlag = DS_MASTER.NameValue(DS_MASTER.RowPosition,"TAX_FLAG");
            var roundFlag = eval(this.DataID).NameValue(row,"ROUND_FLAG");
            var salCostPrc = eval(this.DataID).NameString(row,"SAL_COST_PRC");
            var salePrc = eval(this.DataID).NameString(row,"SALE_PRC");
            var saleMgRate = eval(this.DataID).NameString(row,"SALE_MG_RATE");

            salCostPrc = Number(salCostPrc);
            salePrc = Number(salePrc);
            saleMgRate = Number(saleMgRate);
            // 거래형태[직매입]
            if( bizType == "1"){
            	//판매원가와 판매매가을 등록하면 마진율을 계산
            	eval(this.DataID).NameString(row,"SALE_MG_RATE") = getSaleMgRate( salCostPrc, salePrc, roundFlag, taxFlag);
            // 거래형태[특정매입]
            }else {
            	//판매매가와 마진율을 등록하면 판매원가을 계산
            	eval(this.DataID).NameString(row,"SAL_COST_PRC") = getSalCostPrc(salePrc, saleMgRate, roundFlag, taxFlag);
            }
            break;
        case 'SALE_S_DT':
        case 'SALE_E_DT':
        case 'BUY_S_DT':
        case 'BUY_E_DT':
            var value = eval(this.DataID).NameValue(row,colid);
            var orgValue = eval(this.DataID).OrgNameValue(row,colid);
            if( value == "" || value == orgValue)
                break;
            
            if(!checkDateTypeYMD(this,colid,'')){
                setTimeout("setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,"+row+",'"+colid+"');",50);
                copyRowData(row);
                return false;
            }
            
            var colName = this.GetHdrDispName(-3, colid);
            // 날짜는 금일 이후로 등록 가능합니다.
            if( value < getTodayFormat("YYYYMMDD")){
                // ()는 금일 이후로 등록 가능합니다.
                showMessage(EXCLAMATION, OK, "USER-1030", colName);
                eval(this.DataID).NameValue(row,colid) = "";
                setCopyPoint();
                setTimeout("setFocusGrid(GD_STRSTYLE,DS_STRSTYLE,"+row+",'"+colid+"');",50);
                copyRowData(row);
                return false;               
            }
            break;
    }
    setCopyPoint();
    copyRowData(row);
    return true;
</script>
 
 
<script language=JavaScript for=GD_STRSTYLE event=OnListSelect(index,row,colid)>
    if( row < 1)
        return;
    if( colid=='USE_YN'){
        if(LC_I_USE_YN.BindColVal == 'N' && index == 1){
            showMessage(EXCLAMATION, OK, "USER-1000", "단품의 사용여부가 'NO'입니다.");
            eval(this.DataID).NameValue(row,"USE_YN") = "N";
        }
    }
    setCopyPoint();
    copyRowData(row);
</script>

<script language=JavaScript for=GD_STRSTYLE event=OnKillFocus()>
    setCopyPoint();
    copyRowData(eval(this.DataID).RowPosition);
</script>
 
<script language=JavaScript for=GD_STRSTYLE event=OnPopup(row,colid,data)>
    isOnPopup=true;    
    openCal(this,row,colid);
    isOnPopup=false;
</script>
 
<script language=JavaScript for=LC_I_SIZE_TYPE event=OnSelChange()>
    DS_I_SIZE_CD.Filter();
</script>
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setPumbunCode( "NAME", "S");
</script>
<script language=JavaScript for=EM_O_STYLE_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setStyleCode( "NAME", "S");
</script>
<script language=JavaScript for=EM_I_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setPumbunCode( "NAME", "I");
</script>
<!-- 품목(입력) -->
<script language=JavaScript for=LC_I_PUMMOK_CD event=onSelChange()>
    if( this.BindColVal == '')
        return;
    DS_MASTER.NameValue(DS_MASTER.RowPosition,"PUMMOK_NAME") = this.Text;
    var unitCd = this.ValueByColumn("CODE", this.BindColVal, "UNIT_CD"); 

    DS_MASTER.NameValue(DS_MASTER.RowPosition,"SALE_UNIT_CD") =  DS_MASTER.NameValue(DS_MASTER.RowPosition,"SALE_UNIT_CD")==''?unitCd:DS_MASTER.NameValue(DS_MASTER.RowPosition,"SALE_UNIT_CD");
</script>
<!-- 판매단위(입력) -->
<script language=JavaScript for=LC_I_SALE_UNIT_CD event=onSelChange()>
    // 제외( 김수현:2010.04.05 요청)
    /*
    if( this.BindColVal == '')
        return;
    var unitCd = this.BindColVal;
    if(DS_MASTER.RowStatus(DS_MASTER.RowPosition)==1){
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"CMP_SPEC_UNIT") = DS_MASTER.NameValue(DS_MASTER.RowPosition,"CMP_SPEC_UNIT")!=''?unitCd:DS_MASTER.NameValue(DS_MASTER.RowPosition,"CMP_SPEC_UNIT");
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"BAS_SPEC_UNIT") = DS_MASTER.NameValue(DS_MASTER.RowPosition,"BAS_SPEC_UNIT")!=''?unitCd:DS_MASTER.NameValue(DS_MASTER.RowPosition,"BAS_SPEC_UNIT");
    }
    */
</script>
<!--  MARIO OUTLET
<script language=JavaScript for=EM_I_BRAND_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
setBrandCd('NAME','S',EM_I_BRAND_CD,EM_I_BRAND_NM);
</script>
 -->
<script language=JavaScript for=EM_I_ORIGIN_AREA_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setInitCommonPop('원산지','P040','NAME',EM_I_ORIGIN_AREA_CD,EM_I_ORIGIN_AREA_NAME,'I');
</script>
<script language=JavaScript for=EM_I_MAKER_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setInitCommonPop('메이커','P019','NAME',EM_I_MAKER_CD,EM_I_MAKER_NAME,'I');
</script>
 
<!-- 사용여부 -->
<script language=JavaScript for=LC_I_USE_YN event=onSelChange()>
    if( this.BindColVal == '' || this.BindColVal == 'Y')
        return;
    for(var i=1; i<=DS_STRSTYLE.CountRow; i++){
        if(DS_STRSTYLE.NameValue(i,'SEL')=="T"
            || DS_STRSTYLE.RowStatus(i)==3){
            if(DS_STRSTYLE.NameValue(i,'USE_YN')=='Y'){
                showMessage(EXCLAMATION, OK, "USER-1000","점별단품정보에 사용여부가 [Y]인 항목이 존재합니다.");
                setComboData(this,"Y");
                return;
            }
        }
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
<comment id="_NSID_"><object id="DS_O_PUMMOK_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BRAND_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SUB_BRD_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PLAN_YEAR"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SEASON_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ITEM_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_PUMMOK_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SUB_BRD_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PLAN_YEAR"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEASON_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ITEM_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SIZE_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEX_CD"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CURRENCY_CD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SALE_UNIT_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_BAS_SPEC_UNIT_CD" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USE_YN"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CMP_SPEC_UNIT_CD" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_COLOR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SIZE_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_COPY_POINT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_USE_YN"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"             classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"             classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SKUMST"             classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STRSTYLE"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SKUDTL"             classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script> 
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object></comment><script>_ws_(_NSID_);</script>


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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="70" class="point">브랜드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width="50" tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascript:setPumbunCode('POP','S');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width="79" tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="70">품목</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=LC_O_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="70">스타일</th>
            <td colspan="5" >
              <comment id="_NSID_">
                <object id=EM_O_STYLE_CD classid=<%=Util.CLSID_EMEDIT%> width=136 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascript:setStyleCode('POP','S');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_STYLE_NAME classid=<%=Util.CLSID_EMEDIT%> width=250 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="70" >브랜드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_O_BRAND_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">서브브랜드</th>
            <td width="16">
              <comment id="_NSID_">
                <object id=LC_O_SUB_BRD_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70"> 기획년도</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_PLAN_YEAR classid=<%=Util.CLSID_LUXECOMBO%> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>시즌</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_SEASON_CD classid=<%=Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>아이템</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_ITEM_CD classid=<%=Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">사용여부</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>

          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot" ></td>
  </tr> 
  <tr>
    <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top" width="320"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width="100%" height=426 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td valign="top" class="PL10">
          <div id=TAB_MAIN  width="100%" height=430 TitleWidth=90 TitleAlign="center" >
             <menu TitleName="스타일"         DivId="tab_page1" ClickBfFunc="tabClickBfFunc" ClickFunc="tabClickFunc" />
             <menu TitleName="단품"           DivId="tab_page2" ClickBfFunc="tabClickBfFunc" ClickFunc="tabClickFunc" />
             <menu TitleName="점별단품"       DivId="tab_page3" ClickBfFunc="tabClickBfFunc" ClickFunc="tabClickFunc"  />
          </div>
          <div id=tab_page1 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td class="PT03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="60" class="point">브랜드</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_SEARCH_PUMBUN onclick="javascript:setPumbunCode('POP','I');" align="absmiddle" />
                      <comment id="_NSID_">
                        <object id=EM_I_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=238 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th width="60">대표브랜드</th>
                    <td width="160">
                      <comment id="_NSID_">
                        <object id=EM_I_REP_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="70">협력사</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">스타일코드</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_STYLE_CD classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">스타일명</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_STYLE_NAME classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">영수증명</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_RECP_NAME classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">품목</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_PUMMOK_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">브랜드</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_BRAND_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                      
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_SEARCH_BRAND 
                      	   onclick="javascript:setBrandCd('POP', 'S', EM_I_BRAND_CD,EM_I_BRAND_NAME);"
                           align="absmiddle" />
                       
                      <comment id="_NSID_">
                        <object id=EM_I_BRAND_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>

              
                    </td>
                    <th class="point">서브브랜드</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_SUB_BRD_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">기획년도</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_PLAN_YEAR classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">시즌</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_SEASON_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">아이템</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_ITEM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">사이즈타입</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_SIZE_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">성별</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_SEX_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >통화코드</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_CURRENCY_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >원산지</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_ORIGIN_AREA_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_ORIGIN_AREA_CD onclick="javascript:setInitCommonPop('원산지','P040','POP',EM_I_ORIGIN_AREA_CD,EM_I_ORIGIN_AREA_NAME,'I');" align="absmiddle" />
                      <comment id="_NSID_">
                        <object id=EM_I_ORIGIN_AREA_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >업체스타일</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_VEN_STYLE_CD classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">판매단위</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=LC_I_SALE_UNIT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >기본규격</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_BAS_SPEC_CD classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >기본규격단위</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_BAS_SPEC_UNIT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >구성규격</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_CMP_SPEC_CD classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >구성규격단위</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_CMP_SPEC_UNIT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >메이커</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_I_MAKER_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MAKER_CD onclick="javascript:setInitCommonPop('메이커','P019','POP',EM_I_MAKER_CD,EM_I_MAKER_NAME,'I');" align="absmiddle" />
                      <comment id="_NSID_">
                        <object id=EM_I_MAKER_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">사용여부</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_I_USE_YN classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >비고</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_I_REMARK classid=<%=Util.CLSID_EMEDIT%> width=389 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table>
          </div>
          <div id=tab_page2 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" width="52" id=IMG_SKUADD height="18" onclick="javascript:btn_addRow();"  hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" width="52"  id=IMG_SKUDEL height="18" onclick="javascript:btn_delRow();" /></td>
                  </tr> 
                </table></td>
              </tr>
              <tr>
                <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_SKUMST width="100%" height=374 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_SKUMST">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table>
          </div>
          <div id=tab_page3 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle"/>점별스타일정보</td>
                    <td class="right PB02" valign="bottom" ><img src="/<%=dir%>/imgs/comm/square_blue.gif" hspace="2" align="absmiddle"/>복사기준점
                      <comment id="_NSID_">
                        <object id=LC_O_COPY_POINT classid=<%= Util.CLSID_LUXECOMBO %> width=70 align="absmiddle" tabindex=1 hspace="2"></object>
                      </comment><script>_ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/copy_row.gif" id=IMG_ROWCOPY onClick="javascript:btn_rowCopy();" hspace="2" align="absmiddle"/><img src="/<%=dir%>/imgs/btn/reset_row.gif" id=IMG_ROWCLEAR onClick="javascript:btn_rowClear();" align="absmiddle"/>
                    </td>
                  </tr> 
                </table></td>
              </tr>
              <tr>
                <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_STRSTYLE width="100%" height=180 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_STRSTYLE">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td class="PT07"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle"/>단품상세정보</td>
                  </tr>
                </table></td>
              <tr>
                <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_SKUDTL width="100%" height=162 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_SKUDTL">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table>
          </div>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_MASTER>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
        <c>col=PUMBUN_CD          ctrl=EM_I_PUMBUN_CD          param=Text </c>
        <c>col=PUMBUN_NAME        ctrl=EM_I_PUMBUN_NAME        param=Text </c>
        <c>col=REP_PUMBUN_NAME    ctrl=EM_I_REP_PUMBUN_NAME    param=Text </c>
        <c>col=VEN_NAME           ctrl=EM_I_VEN_NAME           param=Text </c>
        <c>col=STYLE_CD           ctrl=EM_I_STYLE_CD           param=Text </c>
        <c>col=STYLE_NAME         ctrl=EM_I_STYLE_NAME         param=Text </c>
        <c>col=RECP_NAME          ctrl=EM_I_RECP_NAME          param=Text </c>
        <c>col=PUMMOK_CD          ctrl=LC_I_PUMMOK_CD          param=BindColVal </c>
        <c>col=BRAND_CD           ctrl=EM_I_BRAND_CD           param=Text </c>
        <c>col=BRAND_NAME         ctrl=EM_I_BRAND_NAME         param=Text </c>
        <c>col=SUB_BRD_CD         ctrl=LC_I_SUB_BRD_CD         param=BindColVal </c>
        <c>col=PLAN_YEAR          ctrl=LC_I_PLAN_YEAR          param=BindColVal </c>
        <c>col=SEASON_CD          ctrl=LC_I_SEASON_CD          param=BindColVal </c>
        <c>col=ITEM_CD            ctrl=LC_I_ITEM_CD            param=BindColVal </c>
        <c>col=SIZE_TYPE          ctrl=LC_I_SIZE_TYPE          param=BindColVal </c>
        <c>col=SEX_CD             ctrl=LC_I_SEX_CD             param=BindColVal </c>
        <c>col=CURRENCY_CD        ctrl=LC_I_CURRENCY_CD        param=BindColVal </c>
        <c>col=ORIGIN_AREA_CD     ctrl=EM_I_ORIGIN_AREA_CD     param=Text </c>        
        <c>col=ORIGIN_AREA_NAME   ctrl=EM_I_ORIGIN_AREA_NAME   param=Text </c>
        <c>col=VEN_STYLE_CD       ctrl=EM_I_VEN_STYLE_CD       param=Text </c>
        <c>col=SALE_UNIT_CD       ctrl=LC_I_SALE_UNIT_CD       param=BindColVal </c>
        <c>col=BAS_SPEC_CD        ctrl=EM_I_BAS_SPEC_CD        param=Text </c>
        <c>col=BAS_SPEC_UNIT      ctrl=LC_I_BAS_SPEC_UNIT_CD   param=BindColVal </c>   
        <c>col=CMP_SPEC_CD        ctrl=EM_I_CMP_SPEC_CD        param=Text </c>
        <c>col=CMP_SPEC_UNIT      ctrl=LC_I_CMP_SPEC_UNIT_CD   param=BindColVal </c>      
        <c>col=MAKER_CD           ctrl=EM_I_MAKER_CD           param=Text </c>
        <c>col=MAKER_NAME         ctrl=EM_I_MAKER_NAME         param=Text </c>
        <c>col=USE_YN             ctrl=LC_I_USE_YN             param=BindColVal </c>
        <c>col=REMARK             ctrl=EM_I_REMARK             param=Text </c>         
    '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

