<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품가격> 긴급매가조회
 * 작 성 일 : 2010.04.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod6080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 등록된 긴급매가를 조회한다.
 * 이    력 :
 *        2010.04.19 (정진영) 신규작성
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
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
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
//엑셀 다운을 위한 조회조건 전역 선언
 var searchType;  // 조회구분 10:규격, 20:신선, 31:의류A, 32:의류B
 // 규격,신선,의류A,의류B
 var excelStr;
 var excelPumbun;
 var excelPummok;
 var excelSkuCd;
 var excelSkuName;
 var excelEventCd;
 var excelEventName;
 var excelConfYn;
 var excelAppDtS;
 var excelAppDtE;
 // 의류A,의류B
 var excelBrand;
 var excelSubBrd;
 var excelStyleCd;
 var excelStyleName;
 // 의류A
 var excelPlanYear;
 var excelSeason;
 var excelItem;
 // 의류B
 var excelMng1;
 var excelMng2;
 var excelMng3;
 var excelMng4;
 var excelMng5;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){


    // Input Data Set Header 초기화
    DS_SEARCH_COND.setDataHeader(
            'STR_CD:STRING(2)'
            +',PUMBUN_CD:STRING(6)'
            +',PUMMOK_CD:STRING(8)'
            +',SKU_CD:STRING(13)'
            +',SKU_NAME:STRING(40)'
            +',EVENT_CD:STRING(11)'
            +',EVENT_NAME:STRING(40)'
            +',CONF_YN:STRING(1)'
            +',APP_DT_S:STRING(8)'
            +',APP_DT_E:STRING(8)'
            +',SKU_TYPE:STRING(1)'
            +',A_BRAND_CD:STRING(2)'
            +',A_SUB_BRD_CD:STRING(2)'
            +',PLAN_YEAR_CD:STRING(1)'
            +',SEASON_CD:STRING(1)'
            +',ITEM_CD:STRING(2)'
            +',A_STYLE_CD:STRING(11)'
            +',A_STYLE_NAME:STRING(40)'
            +',B_BRAND_CD:STRING(2)'
            +',B_SUB_BRD_CD:STRING(2)'
            +',MNG_CD1:STRING(10)'
            +',MNG_CD2:STRING(10)'
            +',MNG_CD3:STRING(10)'
            +',MNG_CD4:STRING(10)'
            +',MNG_CD5:STRING(10)'
            +',B_STYLE_CD:STRING(54)'
            +',B_STYLE_NAME:STRING(40)');
    DS_SEARCH_COND.ClearData();
    DS_SEARCH_COND.Addrow();

    // Output Data Set Header 초기화    
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    // EMedit에 초기화
    initEmEdit(EM_PUMBUN_CD        , "CODE^6"     , PK);          //브랜드코드
    initEmEdit(EM_PUMBUN_NAME      , "GEN"        , READ);        //브랜드명
    initEmEdit(EM_SKU_CD           , "CODE^13^0"  , NORMAL);      //단품코드
    initEmEdit(EM_SKU_NAME         , "GEN^40"     , NORMAL);      //단품명
    initEmEdit(EM_EVENT_CD         , "CODE^11"    , NORMAL);      //행사코드
    initEmEdit(EM_EVENT_NAME       , "GEN^40"     , NORMAL);      //행사명
    initEmEdit(EM_APP_DT_S         , "TODAY"      , PK);          //적용일 시작
    initEmEdit(EM_APP_DT_E         , "TODAY"      , PK);          //적용일 종료

    initEmEdit(EM_A_STYLE_CD       , "CODE^11"    , NORMAL);      //스타일코드A
    initEmEdit(EM_A_STYLE_NAME     , "GEN^40"     , NORMAL);      //스타일명A
    
    initEmEdit(EM_MNG_CD1          , "CODE^10"    , NORMAL);      //관리항목1
    initEmEdit(EM_MNG_NAME1        , "GEN^40"     , READ);        //관리항목1명
    initEmEdit(EM_MNG_CD2          , "CODE^10"    , NORMAL);      //관리항목2
    initEmEdit(EM_MNG_NAME2        , "GEN^40"     , READ);        //관리항목2명
    initEmEdit(EM_MNG_CD3          , "CODE^10"    , NORMAL);      //관리항목3
    initEmEdit(EM_MNG_NAME3        , "GEN^40"     , READ);        //관리항목3명
    initEmEdit(EM_MNG_CD4          , "CODE^10"    , NORMAL);      //관리항목4
    initEmEdit(EM_MNG_NAME4        , "GEN^40"     , READ);        //관리항목4명
    initEmEdit(EM_MNG_CD5          , "CODE^10"    , NORMAL);      //관리항목5
    initEmEdit(EM_MNG_NAME5        , "GEN^40"     , READ);        //관리항목5명
    initEmEdit(EM_B_STYLE_CD       , "CODE^54"    , NORMAL);      //스타일코드B
    initEmEdit(EM_B_STYLE_NAME     , "GEN^40"     , NORMAL);      //스타일명B

    //콤보 초기화
    initComboStyle(LC_STR_CD       , DS_STR_CD       , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_PUMMOK_CD    , DS_PUMMOK_CD    , "CODE^0^60,NAME^0^80", 1, NORMAL);  //품목(조회)
    initComboStyle(LC_CONF_YN      , DS_CONF_YN      , "CODE^0^60,NAME^0^80", 1, NORMAL);  //확정여부(조회)
    initComboStyle(LC_A_BRAND_CD   , DS_A_BRAND_CD   , "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드A(조회)
    initComboStyle(LC_A_SUB_BRD_CD , DS_A_SUB_BRD_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //서브브랜드A(조회)
    initComboStyle(LC_PLAN_YEAR_CD , DS_PLAN_YEAR_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //기획연도(조회)
    initComboStyle(LC_SEASON_CD    , DS_SEASON_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //시즌(조회)
    initComboStyle(LC_ITEM_CD      , DS_ITEM_CD      , "CODE^0^30,NAME^0^80", 1, NORMAL);  //아이템(조회)
    initComboStyle(LC_B_BRAND_CD   , DS_B_BRAND_CD   , "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드B(조회)
    initComboStyle(LC_B_SUB_BRD_CD , DS_B_SUB_BRD_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //서브브랜드B(조회)

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_PUMMOK_CD.setDataHeader('CODE:STRING(8),NAME:STRING(40)');
    DS_A_BRAND_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_A_SUB_BRD_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_B_BRAND_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_B_SUB_BRD_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_CONF_YN", "D", "D022", "Y");
    getEtcCode("DS_PLAN_YEAR_CD", "D", "P012", "Y");
    getEtcCode("DS_SEASON_CD", "D", "P035", "Y");
    getEtcCode("DS_ITEM_CD", "D", "P036", "Y");
    
    // 기본값 입력( gauce.js )
    insComboData( LC_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_A_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_A_SUB_BRD_CD, "%", "전체", 1 );
    insComboData( LC_B_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_B_SUB_BRD_CD, "%", "전체", 1 );
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_CONF_YN,"%");
    setComboData(LC_PUMMOK_CD,"%");
    setComboData(LC_A_BRAND_CD,"%");
    setComboData(LC_A_SUB_BRD_CD,"%");
    setComboData(LC_PLAN_YEAR_CD,"%");
    setComboData(LC_SEASON_CD,"%");
    setComboData(LC_ITEM_CD,"%");
    setComboData(LC_B_BRAND_CD,"%");
    setComboData(LC_B_SUB_BRD_CD,"%");
    
    seachEnable();
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     width=25  align=center name="NO"        </FC>'
                     + '<FC>id=STR_CD       width=70  align=left   name="점"        EditStyle=Lookup data="DS_STR_CD:CODE:NAME" </FC>'
                     + '<FC>id=SKU_CD       width=120 align=center name="단품코드"  </FC>'
                     + '<FC>id=SKU_NAME     width=150 align=left   name="단품명"    </FC>'
                     + '<C> id=APP_S_DT     width=85  align=center name="시작일"    mask="XXXX/XX/XX"</C>'
                     + '<C> id=SEQ_NO       width=55  align=right  name="순번"     </C>'
                     + '<C> id=APP_E_DT     width=85  align=center name="종료일"    mask="XXXX/XX/XX"</C>'
                     + '<C> id=EMG_COST_PRC width=80  align=right  name="판매원가"  </C>'
                     + '<C> id=EMG_SALE_PRC width=80  align=right  name="판매매가"  </C>'
                     + '<C> id=EMG_MG_RATE  width=80  align=right  name="마진율"    </C>'
                     + '<C> id=STYLE_CD     width=110 align=left   name="스타일"    show=false </C>'
                     + '<C> id=COLOR_NAME   width=90  align=left   name="칼라"      show=false </C>'
                     + '<C> id=SIZE_NAME    width=90  align=left   name="사이즈"    show=false </C>'
                     + '<C> id=EVENT_CD     width=110 align=center name="행사코드"  </C>'
                     + '<C> id=EVENT_NAME   width=90  align=left   name="행사명"    </C>'
                     + '<C> id=CONF_YN      width=90  align=center name="확정여부"  </C>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( EM_PUMBUN_CD.Text == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_PUMBUN_CD.Focus();
        return;
    }
    if( EM_PUMBUN_NAME.Text == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_PUMBUN_CD.Focus();
        return;
    }    
    if( EM_APP_DT_S.Text == ""){
        // (적용일(from))은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "적용일(FROM)");
        EM_APP_DT_S.Focus();
        return;
    }
    if( EM_APP_DT_E.Text == ""){
        // (적용일(to))은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "적용일(TO)");
        EM_APP_DT_E.Focus();
        return;
    }    
    if( EM_APP_DT_S.Text > EM_APP_DT_E.Text){
        // 시작일은 종료일보다 작아야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_APP_DT_S.Focus();
    	return;
    }
    // 엑셀 다운을 위한 값 바인드
    setSearchValue2Excel();
    
    DS_SEARCH_COND.UserStatus(1) = '1';
    var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod608.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_SEARCH_COND=DS_SEARCH_COND,"+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
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
    
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var parameters = "점="+nvl(excelStr,'전체')                    
                   + " -브랜드코드="+nvl(excelPumbun,'전체')    
                   + " -품목="+nvl(excelPummok,'전체')     
                   + " -단품코드="+nvl(excelSkuCd,'전체')    
                   + " -단품명="+nvl(excelSkuName,'전체')   
                   + " -확정여부="+nvl(excelConfYn,'전체')   
                   + " -행사코드="+nvl(excelEventCd,'전체')    
                   + " -행사명="+nvl(excelEventName,'전체')     
                   + " -적용일(From)="+nvl(excelAppDtS,'전체')    
                   + " -적용일(To)="+nvl(excelAppDtE,'전체')    ;
    
    // 의류A
    if( searchType == '31'){ // 조회구분 10:규격, 20:신선, 31:의류A, 32:의류B
        parameters += " -브랜드="+nvl(excelBrand,'전체')                        
                   +  " -서브브랜드="+nvl(excelSubBrd,'전체')    
                   +  " -기획년도="+nvl(excelPlanYear,'전체')     
                   +  " -시즌="+nvl(excelSeason,'전체')    
                   +  " -아이템="+nvl(excelItem,'전체')    
                   +  " -스타일코드="+nvl(excelStyleCd,'전체')    
                   +  " -스타일명="+nvl(excelStyleName,'전체')    ;        
    //의류B
    }else if( searchType == '32'){
        parameters += " -브랜드="+nvl(excelBrand,'전체')                        
                   +  " -서브브랜드="+nvl(excelSubBrd,'전체')    
                   +  " -관리항목1코드="+nvl(excelMng1,'전체')     
                   +  " -관리항목2코드="+nvl(excelMng2,'전체')     
                   +  " -관리항목3코드="+nvl(excelMng3,'전체')     
                   +  " -관리항목4코드="+nvl(excelMng4,'전체')     
                   +  " -관리항목5코드="+nvl(excelMng5,'전체')     
                   +  " -스타일코드="+nvl(excelStyleCd,'전체')    
                   +  " -스타일명="+nvl(excelStyleName,'전체')    ;
    }
      
    //openExcel2(GD_MASTER, "긴급매가조회", parameters, true );
    openExcel5(GD_MASTER, "긴급매가조회", parameters, true , "",g_strPid );

    if(DS_MASTER.CountRow < 1)
        LC_STR_CD.Focus();
    else
        GD_MASTER.Focus();
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
 * setSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
 * return값 : void
 */
function setSearchValue2Excel(){

    // 엑셀 다운을 위한 값 정의
    // 규격,신선,의류A,의류B
    excelStr       = LC_STR_CD.Text;
    excelPumbun    = EM_PUMBUN_CD.Text;
    excelPummok    = LC_PUMMOK_CD.Text;
    excelSkuCd     = EM_SKU_CD.Text;
    excelSkuName   = EM_SKU_NAME.Text;
    excelEventCd   = EM_EVENT_CD.Text;
    excelEventName = EM_EVENT_NAME.Text;
    excelConfYn    = LC_CONF_YN.Text;
    excelAppDtS    = EM_APP_DT_S.Text;
    excelAppDtE    = EM_APP_DT_E.Text;
    
    // 의류A
    if( searchType == '31'){ // 조회구분 10:규격, 20:신선, 31:의류A, 32:의류B
        excelBrand     = LC_A_BRAND_CD.Text;
        excelSubBrd    = LC_A_SUB_BRD_CD.Text;
        excelStyleCd   = EM_A_STYLE_CD.Text;
        excelStyleName = EM_A_STYLE_NAME.Text;
        excelPlanYear  = LC_PLAN_YEAR_CD.Text;
        excelSeason    = LC_SEASON_CD.Text;
        excelItem      = LC_ITEM_CD.Text;
        
    //의류B
    }else if( searchType == '32'){
        excelBrand     = LC_B_BRAND_CD.Text;
        excelSubBrd    = LC_B_SUB_BRD_CD.Text;
        excelStyleCd   = EM_B_STYLE_CD.Text;
        excelStyleName = EM_B_STYLE_NAME.Text;
        excelMng1      = EM_MNG_CD1.Text;
        excelMng2      = EM_MNG_CD2.Text;
        excelMng3      = EM_MNG_CD3.Text;
        excelMng4      = EM_MNG_CD4.Text;
        excelMng5      = EM_MNG_CD5.Text;       
    }
}
/**
 * seachEnable()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 스타일 구분에 따른 입력 컴포넌트 지정
 * return값 : void
 */
function seachEnable( flag){
    enableControl(LC_A_BRAND_CD  , flag==null? false:flag);
    enableControl(LC_A_SUB_BRD_CD, flag==null? false:flag);
    enableControl(LC_PLAN_YEAR_CD, flag==null? false:flag);
    enableControl(LC_SEASON_CD   , flag==null? false:flag);
    enableControl(LC_ITEM_CD     , flag==null? false:flag);
    enableControl(EM_A_STYLE_CD  , flag==null? false:flag);
    enableControl(EM_A_STYLE_NAME, flag==null? false:flag);
    enableControl(IMG_A_STYLE_CD , flag==null? false:flag);
    enableControl(LC_B_BRAND_CD  , flag==null? false:!flag);
    enableControl(LC_B_SUB_BRD_CD, flag==null? false:!flag);
    enableControl(EM_MNG_CD1     , flag==null? false:!flag);
    enableControl(EM_MNG_CD2     , flag==null? false:!flag);
    enableControl(EM_MNG_CD3     , flag==null? false:!flag);
    enableControl(EM_MNG_CD4     , flag==null? false:!flag);
    enableControl(EM_MNG_CD5     , flag==null? false:!flag);
    enableControl(EM_B_STYLE_CD  , flag==null? false:!flag);
    enableControl(EM_B_STYLE_NAME, flag==null? false:!flag);
    enableControl(IMG_B_STYLE_CD , flag==null? false:!flag);
    enableControl(IMG_MNG_CD1    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD2    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD3    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD4    , flag==null? false:!flag);
    enableControl(IMG_MNG_CD5    , flag==null? false:!flag);
    
    // 아무것도 선택되지 않으면 조회 값 초기화
    if(flag == null){
        setComboData(LC_A_BRAND_CD,"%");
        setComboData(LC_A_SUB_BRD_CD,"%");
        setComboData(LC_PLAN_YEAR_CD,"%");
        setComboData(LC_SEASON_CD,"%");
        setComboData(LC_ITEM_CD,"%");
        setComboData(LC_B_BRAND_CD,"%");
        setComboData(LC_B_SUB_BRD_CD,"%");
        EM_A_STYLE_CD.Text = "";
        EM_A_STYLE_NAME.Text = "";
        EM_B_STYLE_CD.Text = "";
        EM_B_STYLE_NAME.Text = "";
        EM_MNG_CD1.Text = "";
        EM_MNG_CD2.Text = "";
        EM_MNG_CD3.Text = "";
        EM_MNG_CD4.Text = "";
        EM_MNG_CD5.Text = "";
        EM_MNG_NAME1.Text = "";
        EM_MNG_NAME2.Text = "";
        EM_MNG_NAME3.Text = "";
        EM_MNG_NAME4.Text = "";
        EM_MNG_NAME5.Text = "";
    }else{
        // A 타입일 경우 B타입  입력 값 초기화
        if( flag){
            setComboData(LC_B_BRAND_CD,"%");
            setComboData(LC_B_SUB_BRD_CD,"%");
            EM_B_STYLE_CD.Text = "";
            EM_B_STYLE_NAME.Text = "";
            EM_MNG_CD1.Text = "";
            EM_MNG_CD2.Text = "";
            EM_MNG_CD3.Text = "";
            EM_MNG_CD4.Text = "";
            EM_MNG_CD5.Text = "";
            EM_MNG_NAME1.Text = "";
            EM_MNG_NAME2.Text = "";
            EM_MNG_NAME3.Text = "";
            EM_MNG_NAME4.Text = "";
            EM_MNG_NAME5.Text = "";     
        // B 타입 일경우 A 타입 입력 값 초기화
        }else{
            setComboData(LC_A_BRAND_CD,"%");
            setComboData(LC_A_SUB_BRD_CD,"%");
            setComboData(LC_PLAN_YEAR_CD,"%");
            setComboData(LC_SEASON_CD,"%");
            setComboData(LC_ITEM_CD,"%");       
            EM_A_STYLE_CD.Text = "";
            EM_A_STYLE_NAME.Text = "";  
        }
    }
}

/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCode(evnflag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;
    var pmkComboObj = LC_PUMMOK_CD;
    var strCd = LC_STR_CD.BindColVal;
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = '';
        eval(pmkComboObj.ComboDataID).ClearData();
        // 기본값 입력( gauce.js )
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");
        DS_MASTER.ClearData();
        seachEnable();
        clearStyleCnt();
        return;     
    }
    
    var result = null;
    if( evnflag == "POP" ){
       result = strPbnPop2(codeObj,nameObj,'Y','', strCd,'','','','','Y','1');
       codeObj.Focus();
    }else if( evnflag == "NAME" ){
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','','Y','1');
    }
    
    if( result != null || DS_SEARCH_NM.CountRow == 1){
        DS_MASTER.ClearData();
        var pumbunCd = codeObj.Text;
        var skuType = result != null ? result.get('SKU_TYPE'): DS_SEARCH_NM.NameValue(1,'SKU_TYPE');
        var styleType = result != null ? result.get('STYLE_TYPE'): DS_SEARCH_NM.NameValue(1,'STYLE_TYPE');
        // 신선 제외
        if( skuType == '2'){
            showMessage(INFORMATION, OK, "USER-1000", "규격단품, 의류잡화단품만 긴급매가를 수정할 수 있습니다.");
            codeObj.Text = "";
            nameObj.Text = "";
            DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = '';
            eval(pmkComboObj.ComboDataID).ClearData();
            // 기본값 입력( gauce.js )
            insComboData( pmkComboObj, "%", "전체", 1 );
            setComboData( pmkComboObj,"%");
            DS_MASTER.ClearData();
            seachEnable();
            clearStyleCnt();
            return;
        }
        
        DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = skuType;
        seachEnable(skuType!='3'?null:styleType=='1');

        if(skuType =='1')
            searchType = '10';
        else if(skuType =='2')
            searchType = '20';
        
        getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"Y");
        if(skuType=='3'){
            GD_MASTER.ColumnProp('STYLE_CD', 'show') = "TRUE";
            if(styleType=='1'){
                GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "TRUE";
                GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "TRUE";
                searchType = '31';
                //공통코드에서 가지고 오기( popup_dps.js )
                getStyleBrand("DS_A_BRAND_CD", pumbunCd, "Y");
                getStyleSubBrand("DS_A_SUB_BRD_CD", pumbunCd, "Y");
                
                //콤보데이터 기본값 설정( gauce.js )
                setComboData(LC_A_BRAND_CD,"%");
                setComboData(LC_A_SUB_BRD_CD,"%");
            }else{
                GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "FALSE";
                GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "FALSE";
                searchType = '32';
                //공통코드에서 가지고 오기( popup_dps.js )
                getStyleBrand("DS_B_BRAND_CD", pumbunCd, "Y");
                getStyleSubBrand("DS_B_SUB_BRD_CD", pumbunCd, "Y");
                
                //콤보데이터 기본값 설정( gauce.js )
                setComboData(LC_B_BRAND_CD,"%");
                setComboData(LC_B_SUB_BRD_CD,"%");
                
            }
        }else{
            GD_MASTER.ColumnProp('STYLE_CD', 'show') = "FALSE";
            GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "FALSE";
            GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "FALSE";
        }
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(pmkComboObj,"%");
        return;
    }
    if(nameObj.Text == ""){
        seachEnable();
        searchType = null;
        codeObj.Text = "";
        nameObj.Text = "";   
        DS_SEARCH_COND.NameValue(1,'SKU_TYPE') = '';
        eval(pmkComboObj.ComboDataID).ClearData();  
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");   
        DS_MASTER.ClearData();
        clearStyleCnt();
    }
}
/**
 * clearAllSearchCnt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 조회 입력 화면을  초기화 한다.
 * return값 : void
**/
function clearAllSearchCnt(){
    DS_SEARCH_COND.ClearData();
    DS_SEARCH_COND.Addrow();
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_PUMMOK_CD,"%");
    seachEnable();
    clearStyleCnt();
}
/**
 * clearStyleCnt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 의류잡화단품 정보를 초기화 한다.
 * return값 : void
**/
function clearStyleCnt(){
    GD_MASTER.ColumnProp('STYLE_CD', 'show') = "FALSE";
    GD_MASTER.ColumnProp('COLOR_NAME', 'show') = "FALSE";
    GD_MASTER.ColumnProp('SIZE_NAME', 'show') = "FALSE";
    DS_A_BRAND_CD.ClearData();
    DS_B_BRAND_CD.ClearData();
    DS_A_SUB_BRD_CD.ClearData();
    DS_B_SUB_BRD_CD.ClearData();
    // 기본값 입력( gauce.js )
    insComboData( LC_A_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_A_SUB_BRD_CD, "%", "전체", 1 );
    insComboData( LC_B_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_B_SUB_BRD_CD, "%", "전체", 1 );
    setComboData( LC_A_BRAND_CD,"%");
    setComboData( LC_A_SUB_BRD_CD,"%");
    setComboData( LC_B_BRAND_CD,"%");
    setComboData( LC_B_SUB_BRD_CD,"%");
    
}
/**
 * setStyleCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 스타일 팝업을 실행한다.
 * return값 : void
**/
function setStyleCode(evnFlag,styleFlag){
    var codeObj = styleFlag=='A'?EM_A_STYLE_CD:EM_B_STYLE_CD;
    var nameObj = styleFlag=='A'?EM_A_STYLE_NAME:EM_B_STYLE_NAME;

    if( evnFlag == 'POP'){
        stylePop(codeObj,nameObj,'Y','',EM_PUMBUN_CD.Text,'Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setStyleNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 0,'',EM_PUMBUN_CD.Text,'Y');

}
/**
 * setStrSkuCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.
 * return값 : void
**/
function setSkuCode(evnFlag){
    var codeObj = EM_SKU_CD;
    var nameObj = EM_SKU_NAME;

    if( evnFlag == 'POP'){
        strSkuPop(codeObj,nameObj,'Y','','',EM_PUMBUN_CD.Text, '','','Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";
        return;
    }
    
    setStrSkuNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 0,'','',EM_PUMBUN_CD.Text, '','','Y');

}

/**
 * setEventCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사 팝업을 실행한다.
 * return값 : void
**/
function setEventCode(evnFlag){
    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;

    if( evnFlag == 'POP'){
        eventPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','2');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 0,LC_STR_CD.BindColVal,'','','2');

}
/**
 * setInitCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 공통코드 팝업 및 이름  조회
 * return값 : void
 */
function setInitCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : (svcFlg == 'I'?'SEL_COMM_CODE_ONLY':'SEL_COMM_CODE_USE_REFER_ONLY');
    var mngCd1   = svcFlg == 'S2'?EM_MNG_CD1.Text:'';
    mngCd1 = mngCd1 == ''? '**********' : mngCd1;
    
    if( evnflag == "POP" ){
        if( svcFlg =='S'|| svcFlg == 'I' )
            commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
        else
            commonPop(title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );
        
        codeObj.Focus();
        return;
    }

    nameObj.Text = "";

    if( svcFlg =='S'|| svcFlg == 'I' )
        setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    else
        setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );
    
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    if( svcFlg =='S'|| svcFlg == 'I' )
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
    else
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );

    codeObj.Focus();
}


/**
 * setCalAppDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function setCalAppDt(evnFlag, type){
    var obj = type=='S'?EM_APP_DT_S:EM_APP_DT_E;
    
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    
    if(!checkDateTypeYMD( obj))
        return;
    
    DS_MASTER.ClearData();
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setPumbunCode("NAME");
</script>
<!-- 단품(조회) -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setSkuCode('NAME');
</script>
<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setEventCode('NAME');
</script>
<!-- 적용일(from)(조회) -->
<script language=JavaScript for=EM_APP_DT_S event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalAppDt('NAME','S');
</script>
<!-- 적용일(to)(조회) -->
<script language=JavaScript for=EM_APP_DT_E event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalAppDt('NAME','E');
</script>
<!-- 스타일A(조회) -->
<script language=JavaScript for=EM_A_STYLE_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setStyleCode('NAME','A');
</script>
<!-- 스타일B(조회) -->
<script language=JavaScript for=EM_B_STYLE_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setStyleCode('NAME','B');
</script>
<!-- 관리항목1(조회) -->
<script language=JavaScript for=EM_MNG_CD1 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목1','P005','NAME',EM_MNG_CD1,EM_MNG_NAME1,'S');
</script>
<!-- 관리항목2(조회) -->
<script language=JavaScript for=EM_MNG_CD2 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목2','P006','NAME',EM_MNG_CD2,EM_MNG_NAME2,'S2');
</script>
<!-- 관리항목3(조회) -->
<script language=JavaScript for=EM_MNG_CD3 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목3','P007','NAME',EM_MNG_CD3,EM_MNG_NAME3,'S2');
</script>
<!-- 관리항목4(조회) -->
<script language=JavaScript for=EM_MNG_CD4 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목4','P008','NAME',EM_MNG_CD4,EM_MNG_NAME4,'S2');
</script>
<!-- 관리항목5(조회) -->
<script language=JavaScript for=EM_MNG_CD5 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목5','P009','NAME',EM_MNG_CD5,EM_MNG_NAME5,'S2');
</script> 
 
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    DS_MASTER.ClearData();
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
<comment id="_NSID_"><object id="DS_STR_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PUMMOK_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CONF_YN"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_A_BRAND_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_A_SUB_BRD_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_B_BRAND_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_B_SUB_BRD_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PLAN_YEAR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEASON_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ITEM_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_SEARCH_COND"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

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
            <th width="53" class="point" >점</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="37" class="point">브랜드</th>
            <td width="210">
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=52 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setPumbunCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%= Util.CLSID_EMEDIT %> width=128 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="49">품목</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=205 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >단품</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%= Util.CLSID_EMEDIT %> width=92 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setSkuCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%= Util.CLSID_EMEDIT %> width=337 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >확정여부</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_CONF_YN classid=<%= Util.CLSID_LUXECOMBO %> width=205 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >행사코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%= Util.CLSID_EMEDIT %> width=92 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setEventCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%= Util.CLSID_EMEDIT %> width=337 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point">적용일</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_APP_DT_S classid=<%= Util.CLSID_EMEDIT %> width=73 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setCalAppDt('POP','S');" align="absmiddle" />
              ~
              <comment id="_NSID_">
                <object id=EM_APP_DT_E classid=<%= Util.CLSID_EMEDIT %> width=73 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setCalAppDt('POP','E');" align="absmiddle" />
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="53" >브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_A_BRAND_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="65">서브브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_A_SUB_BRD_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="53">기획년도</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_PLAN_YEAR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=200 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >시즌</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_SEASON_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >아이템</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_ITEM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >스타일</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_A_STYLE_CD classid=<%= Util.CLSID_EMEDIT %> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_A_STYLE_CD onclick="javascipt:setStyleCode('POP','A');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_A_STYLE_NAME classid=<%= Util.CLSID_EMEDIT %> width=94 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="53" >브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_B_BRAND_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="65">서브브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=LC_B_SUB_BRD_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="53">관리항목1</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD1 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD1 onclick="javascript:setInitCommonPop('관리항목1','P005','POP',EM_MNG_CD1,EM_MNG_NAME1,'S');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME1 classid=<%=Util.CLSID_EMEDIT%> width=94 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >관리항목2</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD2 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD2 onclick="javascript:setInitCommonPop('관리항목2','P006','POP',EM_MNG_CD2,EM_MNG_NAME2,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME2 classid=<%=Util.CLSID_EMEDIT%> width=84 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >관리항목3</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD3 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD3 onclick="javascript:setInitCommonPop('관리항목3','P007','POP',EM_MNG_CD3,EM_MNG_NAME3,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME3 classid=<%=Util.CLSID_EMEDIT%> width=84 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >관리항목4</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD4 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD4 onclick="javascript:setInitCommonPop('관리항목4','P008','POP',EM_MNG_CD4,EM_MNG_NAME4,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME4 classid=<%=Util.CLSID_EMEDIT%> width=94 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >관리항목5</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MNG_CD5 classid=<%=Util.CLSID_EMEDIT%> width=78 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MNG_CD5 onclick="javascript:setInitCommonPop('관리항목5','P009','POP',EM_MNG_CD5,EM_MNG_NAME5,'S2');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MNG_NAME5 classid=<%=Util.CLSID_EMEDIT%> width=84 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >스타일</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_B_STYLE_CD classid=<%= Util.CLSID_EMEDIT %> width=167 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_B_STYLE_CD onclick="javascipt:setStyleCode('POP','B');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_B_STYLE_NAME classid=<%= Util.CLSID_EMEDIT %> width=271 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=301 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_SEARCH_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_SEARCH_COND>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=STR_CD          ctrl=LC_STR_CD         param=BindColVal </c>
            <c>col=PUMBUN_CD       ctrl=EM_PUMBUN_CD      param=Text       </c>
            <c>col=PUMMOK_CD       ctrl=LC_PUMMOK_CD      param=BindColVal </c>
            <c>col=SKU_CD          ctrl=EM_SKU_CD         param=Text       </c>
            <c>col=SKU_NAME        ctrl=EM_SKU_NAME       param=Text       </c>
            <c>col=CONF_YN         ctrl=LC_CONF_YN        param=BindColVal </c>
            <c>col=EVENT_CD        ctrl=EM_EVENT_CD       param=Text       </c>
            <c>col=EVENT_NAME      ctrl=EM_EVENT_NAME     param=Text       </c>
            <c>col=APP_DT_S        ctrl=EM_APP_DT_S       param=Text       </c>
            <c>col=APP_DT_E        ctrl=EM_APP_DT_E       param=Text       </c>
            <c>col=A_BRAND_CD      ctrl=LC_A_BRAND_CD     param=BindColVal </c>
            <c>col=A_SUB_BRD_CD    ctrl=LC_A_SUB_BRD_CD   param=BindColVal </c>
            <c>col=PLAN_YEAR_CD    ctrl=LC_PLAN_YEAR_CD   param=BindColVal </c>
            <c>col=SEASON_CD       ctrl=LC_SEASON_CD      param=BindColVal </c>
            <c>col=ITEM_CD         ctrl=LC_ITEM_CD        param=BindColVal </c>
            <c>col=A_STYLE_CD      ctrl=EM_A_STYLE_CD     param=Text       </c>
            <c>col=A_STYLE_NAME    ctrl=EM_A_STYLE_NAME   param=Text       </c>
            <c>col=B_BRAND_CD      ctrl=LC_B_BRAND_CD     param=BindColVal </c>
            <c>col=B_SUB_BRD_CD    ctrl=LC_B_SUB_BRD_CD   param=BindColVal </c>
            <c>col=MNG_CD1         ctrl=EM_MNG_CD1        param=Text       </c>
            <c>col=MNG_CD2         ctrl=EM_MNG_CD2        param=Text       </c>
            <c>col=MNG_CD3         ctrl=EM_MNG_CD3        param=Text       </c>
            <c>col=MNG_CD4         ctrl=EM_MNG_CD4        param=Text       </c>
            <c>col=MNG_CD5         ctrl=EM_MNG_CD5        param=Text       </c>
            <c>col=B_STYLE_CD      ctrl=EM_B_STYLE_CD     param=Text       </c>
            <c>col=B_STYLE_NAME    ctrl=EM_B_STYLE_NAME   param=Text       </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>


