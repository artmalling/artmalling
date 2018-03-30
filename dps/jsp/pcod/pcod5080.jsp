<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 의류잡화단품조회
 * 작 성 일 : 2010.03.22
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod5080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 의류잡화단품정보를 조회한다.
 * 이    력 :
 *        2010.03.22 (이재득) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strPumbunCd   = "";
var strPummokCd   = "";
var strStyleCd    = "";
var strStyleNm    = "";
var strSkuCd      = "";
var strSkuNm      = "";
var strBrandCd    = "";
var strSubBrdCd   = "";
var strPlanYear   = "";
var strSeasonCd   = "";
var strItemCd     = "";
var strMngCd1     = "";
var strMngCd2     = "";
var strMngCd3     = "";
var strMngCd4     = "";
var strMngCd5     = "";
var g_strPid           = "<%=pageName%>";                 // PID

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_I_SKU_COND.setDataHeader(   
            'PUMBUN_CD:STRING(6)'            
            +',PUMMOK_CD:STRING(8)'                        
            +',STYLE_CD:STRING(54)'
            +',STYLE_NM:STRING(40)'
            +',SKU_CD:STRING(13)'
            +',SKU_NM:STRING(40)'
            +',BRAND_CD:STRING(2)'
            +',SUB_BRD_CD:STRING(2)'
            +',PLAN_YEAR:STRING(1)'
            +',SEASON_CD:STRING(1)'
            +',ITEM_CD:STRING(2)'
            +',MNG_CD1:STRING(10)'
            +',MNG_NM1:STRING(40)'            
            +',MNG_CD2:STRING(10)'
            +',MNG_NM2:STRING(40)'
            +',MNG_CD3:STRING(10)'
            +',MNG_NM3:STRING(40)'
            +',MNG_CD4:STRING(10)'
            +',MNG_NM4:STRING(40)'
            +',MNG_CD5:STRING(10)'
            +',MNG_NM5:STRING(40)'); 
    DS_I_SKU_COND.ClearData();
    DS_I_SKU_COND.Addrow();
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화 
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6^0",  PK);  //브랜드코드
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", READ);   //브랜드명    
    initEmEdit(EM_O_STYLE_CD, "CODE^54^#",  NORMAL); //스타일코드
    initEmEdit(EM_O_STYLE_NM, "GEN^40", NORMAL);  //스타일명 
    initEmEdit(EM_O_SKU_CD, "CODE^13^#", NORMAL); //단품코드
    initEmEdit(EM_O_SKU_NM, "GEN^40", NORMAL);    //단품명
    initEmEdit(EM_O_MNG_CD1, "CODE^10", NORMAL);   //관리목목1코드
    initEmEdit(EM_O_MNG_NM1, "GEN^40", READ);     //관리항목1명
    initEmEdit(EM_O_MNG_CD2, "CODE^10",  NORMAL);  //관리항목2코드
    initEmEdit(EM_O_MNG_NM2, "GEN^40", READ);     //관리항목2명 
    initEmEdit(EM_O_MNG_CD3, "CODE^10", NORMAL);   //관리항목3코드
    initEmEdit(EM_O_MNG_NM3, "GEN^40", READ);     //관리항목3명
    initEmEdit(EM_O_MNG_CD4, "CODE^10",  NORMAL);  //관리항목4코드
    initEmEdit(EM_O_MNG_NM4, "GEN^40", READ);     //관리항목4명 
    initEmEdit(EM_O_MNG_CD5, "CODE^10", NORMAL);   //관리항목5코드
    initEmEdit(EM_O_MNG_NM5, "GEN^40", READ);     //관리항목5명
    
    //콤보 초기화
    initComboStyle(LC_O_PUMMOK_CD,DS_O_PUMMOK_CD, "CODE^0^70,NAME^0^100", 1, NORMAL);  //품목(조회)
    initComboStyle(LC_O_BRAND_CD,DS_O_BRAND_CD, "CODE^0^70,NAME^0^100", 1, NORMAL);  //브랜드
    initComboStyle(LC_O_SUB_BRD_CD,DS_O_SUB_BRD_CD, "CODE^0^70,NAME^0^100", 1, NORMAL);  //서브브랜드
    initComboStyle(LC_O_PLAN_YEAR,DS_O_PLAN_YEAR, "CODE^0^70,NAME^0^100", 1, NORMAL);  //기획년도
    initComboStyle(LC_O_SEASON_CD,DS_O_SEASON_CD, "CODE^0^70,NAME^0^100", 1, NORMAL);  //시즌
    initComboStyle(LC_O_ITEM_CD,DS_O_ITEM_CD, "CODE^0^70,NAME^0^100", 1, NORMAL);  //아이템
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_O_PLAN_YEAR", "D", "P012", "Y");       //칼라  
    getEtcCode("DS_O_SEASON_CD", "D", "P035", "Y");       //사이즈
    getEtcCode("DS_O_ITEM_CD", "D", "P036", "Y");         //원산지
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    getEtcCode("DS_I_ORIGIN_AREA_CD", "D", "P040", "N");  //원산지  
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    getEtcCode("DS_I_BAS_SPEC_UNIT", "D", "P013", "N");   //기본규격단위
    getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위
    getEtcCode("DS_I_MAKER_CD", "D", "P019", "N");        //메이커코드    
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_PUMMOK_CD.setDataHeader('CODE:STRING(8),NAME:STRING(40)');
    DS_O_BRAND_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_SUB_BRD_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD, "%", "전체", 1 );
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_PUMMOK_CD,"%");
    setComboData(LC_O_BRAND_CD,"%");
    setComboData(LC_O_SUB_BRD_CD,"%");
    setComboData(LC_O_PLAN_YEAR,"%");
    setComboData(LC_O_SEASON_CD,"%");
    setComboData(LC_O_ITEM_CD,"%");
    
    //조회조건 Enable여부를 초기화한다.
    setEnableControl("");
    
    EM_O_PUMBUN_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"            width=30    align=center  </FC>'
                     + '<FC>id=STYLE_CD        name="스타일코드"     width=120   align=left  </FC>'
                     + '<FG>id=COLOR           name="칼라"'
                     + '<FC>id=COLOR_CD        name="코드"          width=50   align=center    </FC>'
                     + '<FC>id=COLOR_CD        name="명"            width=80   align=left    EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"</FC>'
                     + '</FG>'
                     + '<FG>id=SIZE            name="사이즈"'
                     + '<FC>id=SIZE_CD         name="코드"          width=50    align=center    </FC>'
                     + '<FC>id=SIZE_CD         name="명"            width=60    align=left    EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"</FC>'
                     + '</FG>'
                     + '<FC>id=SKU_CD          name="단품코드"       width=110   align=center  </FC>'
                     + '<FC>id=SKU_NAME        name="단품명"         width=130   align=left    </FC>'
                     + '<FC>id=RECP_NAME       name="영수증명"       width=130    align=left    </FC>' 
                     + '<FC>id=INPUT_PLU_CD    name="소스마킹코드"   width=110    align=left  </FC>'
                     + '<FC>id=PUMMOK_CD       name="품목코드"       width=90    align=center  </FC>'
                     + '<FC>id=PUMMOK_NAME     name="품목명"         width=100    align=left    </FC>'
                     + '<FC>id=ORIGIN_AREA_CD  name="원산지"         width=60    align=left   EditStyle=Lookup    Data="DS_I_ORIGIN_AREA_CD:CODE:NAME"</FC>'
                     + '<FC>id=MODEL_NO        name="모델코드"       width=200    align=left   </FC>'                      
                     + '<FC>id=SALE_UNIT_CD    name="판매단위"       width=60    align=left   EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=BAS_SPEC_CD     name="기본규격"       width=60    align=right   </FC>'                      
                     + '<FC>id=BAS_SPEC_UNIT   name="기본규격단위"   width=90    align=left   EditStyle=Lookup    Data="DS_I_BAS_SPEC_UNIT:CODE:NAME"</FC>'
                     + '<FC>id=CMP_SPEC_CD     name="구성규격"       width=65    align=right    </FC>'
                     + '<FC>id=CMP_SPEC_UNIT   name="구성규격단위"   width=90    align=left   EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"</FC>'                                          
                     + '<FC>id=MAKER_CD        name="메이커"         width=100    align=left    EditStyle=Lookup    Data="DS_I_MAKER_CD:CODE:NAME"</FC>'
                     + '<FC>id=USE_YN          name="사용여부"       width=55    align=center   </FC>'                     
                     + '<FC>id=REMARK          name="비고"           width=200    align=left   </FC>';
                     
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
 * 작 성 일 : 2010.03.21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    DS_IO_MASTER.ClearData();
    DS_I_SKU_COND.UserStatus(1) = '1';
    
    strPumbunCd   = EM_O_PUMBUN_CD.Text;
    strPummokCd   = LC_O_PUMMOK_CD.Text;
    strStyleCd    = EM_O_STYLE_CD.Text;
    strStyleNm    = EM_O_STYLE_NM.Text;
    strSkuCd      = EM_O_SKU_CD.Text;
    strSkuNm      = EM_O_SKU_NM.Text;
    strBrandCd    = LC_O_BRAND_CD.Text;
    strSubBrdCd   = LC_O_SUB_BRD_CD.Text;
    strPlanYear   = LC_O_PLAN_YEAR.Text;
    strSeasonCd   = LC_O_SEASON_CD.Text;
    strItemCd     = LC_O_ITEM_CD.Text;
    strMngCd1     = EM_O_MNG_CD1.Text;
    strMngCd2     = EM_O_MNG_CD2.Text;
    strMngCd3     = EM_O_MNG_CD3.Text;
    strMngCd4     = EM_O_MNG_CD4.Text;
    strMngCd5     = EM_O_MNG_CD5.Text;
    
    if( strPumbunCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NM.Text == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod508.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_I_SKU_COND=DS_I_SKU_COND,"+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
     if (strStyleCd == "")
         strStyleCd = "전체";
     if (strStyleNm == "")
         strStyleNm = "전체";
     if (strSkuCd == "")
         strSkuCd = "전체";
     if (strSkuNm == "")
         strSkuNm = "전체";
     if (strMngCd1 == "")
         strMngCd1 = "전체";
     if (strMngCd2 == "")
         strMngCd2 = "전체";
     if (strMngCd3 == "")
         strMngCd3 = "전체";
     if (strMngCd4 == "")
         strMngCd4 = "전체";
     if (strMngCd5 == "")
         strMngCd5 = "전체";
     
     var parameters = "브랜드코드="+strPumbunCd                    
                    + " -품목코드="+strPummokCd
                    + " -스타일코드="+strStyleCd 
                    + " -스타일명="+strStyleNm
                    + " -단품코드="+strSkuCd 
                    + " -단품명="+strSkuNm
                    + " -브랜드="+strBrandCd 
                    + " -서브브랜드="+strSubBrdCd
                    + " -기획년도="+strPlanYear 
                    + " -시즌="+strSeasonCd
                    + " -아이템="+strItemCd 
                    + " -관리항목1="+strMngCd1                    
                    + " -관리항목2="+strMngCd2                    
                    + " -관리항목3="+strMngCd3                    
                    + " -관리항목4="+strMngCd4                    
                    + " -관리항목5="+strMngCd5;
       
   //openExcel2(GD_MASTER, "의류잡화단품조회", parameters, true );
   openExcel5(GD_MASTER, "의류잡화단품조회", parameters, true , "",g_strPid );

   GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * setPumbunCdCombo()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010.03.21
 * 개    요 : 브랜드POPUP/품목COMBO를 조회한다.
 * return값 : void
 */
function setPumbunCdCombo(evnflag){
    var codeObj = EM_O_PUMBUN_CD;
    var nameObj = EM_O_PUMBUN_NM;
    var pmkComboObj = LC_O_PUMMOK_CD;
    var styleType = ""
    //eval(pmkComboObj.ComboDataID).ClearData();    
    
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";        
        setEnableControl(styleType);
        eval(pmkComboObj.ComboDataID).ClearData();
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
        
        return;
    }

    var result = null;

    if( evnflag == "POP" ){
        result = strPbnPop2(codeObj,nameObj,'Y','','','','','','','','1','3');
         
    }else if( evnflag == "NAME" ){
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'','','','','','','','1','3');

        if( result != null){
            codeObj.Text = result.get("PUMBUN_CD");
            nameObj.Text = result.get("PUMBUN_NAME");
        }
    }

    if( result != null || DS_SEARCH_NM.CountRow == 1){      
        var pumbunCd = codeObj.Text;
        getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"N");
        getStyleBrand("DS_O_BRAND_CD", pumbunCd, "Y");
        getStyleSubBrand("DS_O_SUB_BRD_CD", pumbunCd, "Y");        
        styleType = result != null ? result.get("STYLE_TYPE") : DS_SEARCH_NM.NameValue(1,"STYLE_TYPE");
        //콤보에 '전체' 추가
        insComboData(pmkComboObj,"%","전체",1);        
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(LC_O_BRAND_CD,"%");
        setComboData(LC_O_SUB_BRD_CD,"%");
        setComboData(pmkComboObj,"%");
    }else{      
        EM_O_PUMBUN_CD.Text = "";       
    }
    setEnableControl(styleType);
} 

/**
 * setInitCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 공통코드 팝업 및 이름  조회
 * return값 : void
 */
function setInitCommonPop(title, comId, evnflag, codeObj, nameObj){
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    
    var mngCd1   = EM_O_MNG_CD1.Text;
    mngCd1 = mngCd1 == ''? '**********' : mngCd1;
    
    if( evnflag == "POP" ){
    	if( comId == "P005")
    		commonPop(title,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,'D',comId);
    	else
    		commonPop(title,'SEL_COMM_CODE_USE_REFER_ONLY',codeObj ,nameObj,'D',comId, '', mngCd1 );
    	
        codeObj.Focus();
        return;
    }

    nameObj.Text = "";
    if( comId == "P005")
    	setNmWithoutPop('DS_SEARCH_NM',title,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,'D',comId);
    else
    	setNmWithoutPop('DS_SEARCH_NM',title,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,'D',comId, '', mngCd1 );
    
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    if( comId == "P005")
        commonPop(title,'SEL_COMM_CODE_ONLY',codeObj ,nameObj,'D',comId);
    else
        commonPop(title,'SEL_COMM_CODE_USE_REFER_ONLY',codeObj ,nameObj,'D',comId, '', mngCd1 );
    codeObj.Focus();
}

/**
 * setEnableControl()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010.03.23
 * 개    요 : 의류잡화단품코드에 따른 Enable여부를 변경한다.
 * return값 : void
 */
function setEnableControl(styleType){   
    if (styleType == "1"){
        setComboData(LC_O_PLAN_YEAR,"%");
        setComboData(LC_O_SEASON_CD,"%");
        setComboData(LC_O_ITEM_CD,"%");
        enableControl(LC_O_PLAN_YEAR, true);
        enableControl(LC_O_SEASON_CD, true);
        enableControl(LC_O_ITEM_CD, true);
        enableControl(EM_O_MNG_CD1, false);
        enableControl(EM_O_MNG_CD2, false);
        enableControl(EM_O_MNG_CD3, false);
        enableControl(EM_O_MNG_CD4, false);
        enableControl(EM_O_MNG_CD5, false); 
        enableControl(IMG_MNG_CD1, false);
        enableControl(IMG_MNG_CD2, false);
        enableControl(IMG_MNG_CD3, false);
        enableControl(IMG_MNG_CD4, false);
        enableControl(IMG_MNG_CD5, false); 
        EM_O_MNG_CD1.Text = "";
        EM_O_MNG_NM1.Text = "";
        EM_O_MNG_CD2.Text = "";
        EM_O_MNG_NM2.Text = "";
        EM_O_MNG_CD3.Text = "";
        EM_O_MNG_NM3.Text = "";
        EM_O_MNG_CD4.Text = "";
        EM_O_MNG_NM4.Text = "";
        EM_O_MNG_CD5.Text = "";
        EM_O_MNG_NM5.Text = "";
        GD_MASTER.ColumnProp("COLOR", "show") = true;
        GD_MASTER.ColumnProp("SIZE",  "show") = true;
    }else if(styleType == "2"){
        setComboData(LC_O_PLAN_YEAR,"%");
        setComboData(LC_O_SEASON_CD,"%");
        setComboData(LC_O_ITEM_CD,"%");
        enableControl(LC_O_PLAN_YEAR, false);
        enableControl(LC_O_SEASON_CD, false);
        enableControl(LC_O_ITEM_CD, false);
        enableControl(EM_O_MNG_CD1, true);
        enableControl(EM_O_MNG_CD2, true);
        enableControl(EM_O_MNG_CD3, true);
        enableControl(EM_O_MNG_CD4, true);
        enableControl(EM_O_MNG_CD5, true); 
        enableControl(IMG_MNG_CD1, true);
        enableControl(IMG_MNG_CD2, true);
        enableControl(IMG_MNG_CD3, true);
        enableControl(IMG_MNG_CD4, true);
        enableControl(IMG_MNG_CD5, true);
        EM_O_MNG_CD1.Text = "";
        EM_O_MNG_NM1.Text = "";
        EM_O_MNG_CD2.Text = "";
        EM_O_MNG_NM2.Text = "";
        EM_O_MNG_CD3.Text = "";
        EM_O_MNG_NM3.Text = "";
        EM_O_MNG_CD4.Text = "";
        EM_O_MNG_NM4.Text = "";
        EM_O_MNG_CD5.Text = "";
        EM_O_MNG_NM5.Text = "";
        GD_MASTER.ColumnProp("COLOR", "show") = false;
        GD_MASTER.ColumnProp("SIZE",  "show") = false;
    }else{
        enableControl(LC_O_PLAN_YEAR, false);
        enableControl(LC_O_SEASON_CD, false);
        enableControl(LC_O_ITEM_CD, false);
        enableControl(EM_O_MNG_CD1, false);
        enableControl(EM_O_MNG_CD2, false);
        enableControl(EM_O_MNG_CD3, false);
        enableControl(EM_O_MNG_CD4, false);
        enableControl(EM_O_MNG_CD5, false);
        enableControl(IMG_MNG_CD1, false);
        enableControl(IMG_MNG_CD2, false);
        enableControl(IMG_MNG_CD3, false);
        enableControl(IMG_MNG_CD4, false);
        enableControl(IMG_MNG_CD5, false);
        setComboData(LC_O_PLAN_YEAR,"%");
        setComboData(LC_O_SEASON_CD,"%");
        setComboData(LC_O_ITEM_CD,"%");
        EM_O_MNG_CD1.Text = "";
        EM_O_MNG_NM1.Text = "";
        EM_O_MNG_CD2.Text = "";
        EM_O_MNG_NM2.Text = "";
        EM_O_MNG_CD3.Text = "";
        EM_O_MNG_NM3.Text = "";
        EM_O_MNG_CD4.Text = "";
        EM_O_MNG_NM4.Text = "";
        EM_O_MNG_CD5.Text = "";
        EM_O_MNG_NM5.Text = "";
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

<!-- 단품코드 변경시 -->
<script language=JavaScript for=EM_O_SKU_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
       return;
    if(this.text==''){
        EM_O_SKU_NM.Text = "";
        return;
    }        
    setStrSkuNmWithoutPop( "DS_O_SKU_CD", this, EM_O_SKU_NM , 'Y' , '0','','',EM_O_PUMBUN_CD.Text,'','','','','3');
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
       return;
    setPumbunCdCombo("NAME");
    //DS_IO_MASTER.ClearData();
</script>

<!-- 스타일코드 변경시 -->
<script language=JavaScript for=EM_O_STYLE_CD event=OnKillFocus()>    

    //변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    if(this.text==''){
        EM_O_STYLE_NM.Text = "";
        return;
    }        
    setStyleNmWithoutPop( "DS_O_STYLE_CD", this, EM_O_STYLE_NM ,'Y' , '0' ,'',EM_O_PUMBUN_CD.Text,'');
</script>

<script language=JavaScript for=EM_O_MNG_CD1 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목1','P005','NAME',EM_O_MNG_CD1,EM_O_MNG_NM1);
</script>
<script language=JavaScript for=EM_O_MNG_CD2 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목2','P006','NAME',EM_O_MNG_CD2,EM_O_MNG_NM2);
</script>
<script language=JavaScript for=EM_O_MNG_CD3 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목3','P007','NAME',EM_O_MNG_CD3,EM_O_MNG_NM3);
</script>
<script language=JavaScript for=EM_O_MNG_CD4 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목4','P008','NAME',EM_O_MNG_CD4,EM_O_MNG_NM4);
</script>
<script language=JavaScript for=EM_O_MNG_CD5 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setInitCommonPop('관리항목5','P009','NAME',EM_O_MNG_CD5,EM_O_MNG_NM5);
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<object id="DS_O_PUMMOK_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BRAND_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SUB_BRD_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PLAN_YEAR" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ITEM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SEASON_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STYLE_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MNG_CD1" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MNG_CD2" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MNG_CD3" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MNG_CD4" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MNG_CD5" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SKU_COND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SIZE_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_ORIGIN_AREA_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SALE_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BAS_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CMP_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MAKER_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
                        <th width="65" class="point">브랜드</th>
                        <td width="168"><comment id="_NSID_"> <object id=EM_O_PUMBUN_CD
                            classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:setPumbunCdCombo('POP'); EM_O_PUMBUN_CD.Focus();" align="absmiddle" />
                        <comment id="_NSID_"> <object id=EM_O_PUMBUN_NM
                            classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">품목</th>
                        <td width="165"><comment id="_NSID_"> <object id=LC_O_PUMMOK_CD
                            classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">스타일</th>
                        <td><comment id="_NSID_"> <object id=EM_O_STYLE_CD
                            classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:stylePop(EM_O_STYLE_CD,EM_O_STYLE_NM,'Y','',EM_O_PUMBUN_CD.Text,''); EM_O_STYLE_CD.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_STYLE_NM classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>                        
                        <th width="65">단품</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=EM_O_SKU_CD
                            classid=<%= Util.CLSID_EMEDIT %> width=160 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:strSkuPop(EM_O_SKU_CD,EM_O_SKU_NM,'Y','','',EM_O_PUMBUN_CD.Text,'','','','','3'); EM_O_SKU_CD.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_SKU_NM classid=<%= Util.CLSID_EMEDIT %> width=220 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">브랜드</th>
                        <td><comment id="_NSID_"> <object id=LC_O_BRAND_CD
                            classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=230 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        
                    </tr>
                    <tr>
                        <th width="65">서브브랜드</th>
                        <td colspan="5"><comment id="_NSID_"> <object id=LC_O_SUB_BRD_CD
                            classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>                        
                        <th width="65">기획년도</th>
                        <td><comment id="_NSID_"> <object id=LC_O_PLAN_YEAR
                            classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">시즌</th>
                        <td><comment id="_NSID_"> <object id=LC_O_SEASON_CD
                            classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">아이템</th>
                        <td><comment id="_NSID_"> <object id=LC_O_ITEM_CD 
                            classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=230 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>                        
                        <th width="65">관리항목1</th>
                        <td><comment id="_NSID_"> <object id=EM_O_MNG_CD1
                            classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD1" class="PR03"
                            onclick="javascript:setInitCommonPop('관리항목1','P005','POP',EM_O_MNG_CD1,EM_O_MNG_NM1); EM_O_MNG_CD1.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_MNG_NM1 classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">관리항목2</th>
                        <td><comment id="_NSID_"> <object id=EM_O_MNG_CD2
                            classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD2" class="PR03"
                            onclick="javascript:setInitCommonPop('관리항목2','P006','POP',EM_O_MNG_CD2,EM_O_MNG_NM2); EM_O_MNG_CD2.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_MNG_NM2 classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">관리항목3</th>
                        <td><comment id="_NSID_"> <object id=EM_O_MNG_CD3
                            classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD3" class="PR03"
                            onclick="javascript:setInitCommonPop('관리항목3','P007','POP',EM_O_MNG_CD3,EM_O_MNG_NM3); EM_O_MNG_CD3.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_MNG_NM3 classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="65">관리항목4</th>
                        <td><comment id="_NSID_"> <object id=EM_O_MNG_CD4
                            classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD4" class="PR03"
                            onclick="javascript:setInitCommonPop('관리항목4','P008','POP',EM_O_MNG_CD4,EM_O_MNG_NM4); EM_O_MNG_CD4.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_MNG_NM4 classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="60">관리항목5</th>
                        <td colspan="3"><comment id="_NSID_"> <object id=EM_O_MNG_CD5
                            classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD5" class="PR03"
                            onclick="javascript:setInitCommonPop('관리항목5','P009','POP',EM_O_MNG_CD5,EM_O_MNG_NM5); EM_O_MNG_CD5.Focus();"
                            align="absmiddle" /> <comment id="_NSID_"> <object
                            id=EM_O_MNG_NM5 classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><OBJECT id=GD_MASTER
                    width="100%" height=378 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_MASTER">
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_SKU_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_I_SKU_COND>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c>col=PUMBUN_CD        ctrl=EM_O_PUMBUN_CD       param=Text </c>            
            <c>col=PUMMOK_CD        ctrl=LC_O_PUMMOK_CD       param=BindColVal </c>   
            <c>col=STYLE_CD         ctrl=EM_O_STYLE_CD        param=Text </c>            
            <c>col=STYLE_NM         ctrl=EM_O_STYLE_NM        param=Text </c>
            <c>col=SKU_CD           ctrl=EM_O_SKU_CD          param=Text </c>
            <c>col=SKU_NM           ctrl=EM_O_SKU_NM          param=Text </c>                         
            <c>col=BRAND_CD         ctrl=LC_O_BRAND_CD        param=BindColVal </c>
            <c>col=SUB_BRD_CD       ctrl=LC_O_SUB_BRD_CD      param=BindColVal </c>
            <c>col=PLAN_YEAR        ctrl=LC_O_PLAN_YEAR       param=BindColVal </c>            
            <c>col=SEASON_CD        ctrl=LC_O_SEASON_CD       param=BindColVal </c>                         
            <c>col=ITEM_CD          ctrl=LC_O_ITEM_CD         param=BindColVal </c>
            <c>col=MNG_CD1          ctrl=EM_O_MNG_CD1         param=Text </c>                       
            <c>col=MNG_CD2          ctrl=EM_O_MNG_CD2         param=Text </c>  
            <c>col=MNG_CD3          ctrl=EM_O_MNG_CD3         param=Text </c>
            <c>col=MNG_CD4          ctrl=EM_O_MNG_CD4         param=Text </c>  
            <c>col=MNG_CD5          ctrl=EM_O_MNG_CD5         param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

