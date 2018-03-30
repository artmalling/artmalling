
<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 단품스캔코드관리
 * 작 성 일 : 2010.03.28
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod5090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품의 스캔코드(소스마킹코드)를 관리 한다.
 * 이    력 :
 *        2010.03.28 (이재득) 작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var skuType = "";     //단품구분
var styleType = "";   //스타일타입
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_SKU_COND.setDataHeader(   
            'STR_CD:STRING(2)'
            +',PUMBUN_CD:STRING(6)'            
            +',PUMMOK_CD:STRING(8)'                        
            +',STYLE_CD_A:STRING(54)'
            +',STYLE_NM_A:STRING(40)'
            +',STYLE_CD_B:STRING(54)'
            +',STYLE_NM_B:STRING(40)'
            +',SKU_CD:STRING(13)'
            +',SKU_NM:STRING(40)'
            +',BARCODE:STRING(13)'
            +',BRAND_CD_A:STRING(2)'
            +',BRAND_CD_B:STRING(2)'
            +',SUB_BRD_CD_A:STRING(2)'
            +',SUB_BRD_CD_B:STRING(2)'
            +',PLAN_YEAR:STRING(1)'
            +',SEASON_CD:STRING(1)'
            +',ITEM_CD:STRING(2)'
            +',MNG_CD1:STRING(10)'                      
            +',MNG_CD2:STRING(10)'            
            +',MNG_CD3:STRING(10)'            
            +',MNG_CD4:STRING(10)'            
            +',MNG_CD5:STRING(10)'); 
    DS_SKU_COND.ClearData();
    DS_SKU_COND.Addrow();
    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6^0", PK);  //브랜드코드(조회)
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", READ);  //브랜드명(조회)
    initEmEdit(EM_O_SKU_CD, "CODE^13^0", NORMAL);  //단품코드(조회)
    initEmEdit(EM_O_SKU_NM, "GEN^40", NORMAL);  //단품명(조회)
    initEmEdit(EM_O_BARCODE, "CODE^13^0", NORMAL);  //스캔코드(조회)
    initEmEdit(EM_O_STYLE_CD_A, "CODE^13^0", NORMAL);  //스타일코드(A)
    initEmEdit(EM_O_STYLE_NM_A, "GEN^40", NORMAL);  //스타일명(A)
    initEmEdit(EM_O_STYLE_CD_B, "CODE^13^0", NORMAL);  //스타일코드(B)
    initEmEdit(EM_O_STYLE_NM_B, "GEN^40", NORMAL);  //스타일명(B)
        
    initEmEdit(EM_O_MNG_CD1, "CODE^10", NORMAL);     //관리목목1코드
    initEmEdit(EM_O_MNG_NM1, "GEN^40", READ);     //관리항목1명
    initEmEdit(EM_O_MNG_CD2, "CODE^10",  NORMAL);    //관리항목2코드
    initEmEdit(EM_O_MNG_NM2, "GEN^40", READ);     //관리항목2명 
    initEmEdit(EM_O_MNG_CD3, "CODE^10", NORMAL);     //관리항목3코드
    initEmEdit(EM_O_MNG_NM3, "GEN^40", READ);     //관리항목3명
    initEmEdit(EM_O_MNG_CD4, "CODE^10",  NORMAL);    //관리항목4코드
    initEmEdit(EM_O_MNG_NM4, "GEN^40", READ);     //관리항목4명 
    initEmEdit(EM_O_MNG_CD5, "CODE^10", NORMAL);     //관리항목5코드
    initEmEdit(EM_O_MNG_NM5, "GEN^40", READ);     //관리항목5명

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)    
    initComboStyle(LC_O_PUMMOK_CD,DS_O_PUMMOK_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //품목(조회)
    initComboStyle(LC_O_BRAND_CD_A,DS_O_BRAND_CD_A, "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드(A)
    initComboStyle(LC_O_SUB_BRD_CD_A,DS_O_SUB_BRD_CD_A, "CODE^0^30,NAME^0^80", 1, NORMAL);  //서브브랜드(A)
    initComboStyle(LC_O_PLAN_YEAR,DS_O_PLAN_YEAR, "CODE^0^30,NAME^0^80", 1, NORMAL);  //기획년도(A)
    initComboStyle(LC_O_SEASON_CD,DS_O_SEASON_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //시즌(A)
    initComboStyle(LC_O_ITEM_CD,DS_O_ITEM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //아이템(A)
    initComboStyle(LC_O_BRAND_CD_B,DS_O_BRAND_CD_B, "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드(B)
    initComboStyle(LC_O_SUB_BRD_CD_B,DS_O_SUB_BRD_CD_B, "CODE^0^30,NAME^0^80", 1, NORMAL);  //서브브랜드(B)
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_O_PLAN_YEAR", "D", "P012", "Y");       //기획년도  
    getEtcCode("DS_O_SEASON_CD", "D", "P035", "Y");       //시즌코드
    getEtcCode("DS_O_ITEM_CD", "D", "P036", "Y");         //아이템코드
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "Y");
    getStore("DS_I_STR_CD", "Y", "", "N");
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_PUMMOK_CD.setDataHeader('CODE:STRING(8),NAME:STRING(40)');
    DS_O_BRAND_CD_A.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_SUB_BRD_CD_A.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_BRAND_CD_B.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_SUB_BRD_CD_B.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD_A, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD_A, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD_B, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD_B, "%", "전체", 1 );
    
    //콤보데이터 기본값 설정( gauce.js )   
    setComboData(LC_O_STR_CD,"%");
    setComboData(LC_O_PUMMOK_CD,"%");
    setComboData(LC_O_BRAND_CD_A,"%");
    setComboData(LC_O_BRAND_CD_B,"%");
    setComboData(LC_O_SUB_BRD_CD_A,"%");
    setComboData(LC_O_SUB_BRD_CD_B,"%");
    setComboData(LC_O_PLAN_YEAR,"%");
    setComboData(LC_O_SEASON_CD,"%");
    setComboData(LC_O_ITEM_CD,"%");
    LC_O_STR_CD.Index = 0;
    
    //조회조건 Enable여부를 초기화한다.
    setEnableControl("", "");   
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod509","DS_MASTER" );
  
    EM_O_PUMBUN_CD.Focus();      
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=STR_CD      name="*점"        width=80   align=left   edit={IF(FLAG=1,"false","true")}  EditStyle=Lookup   Data="DS_I_STR_CD:CODE:NAME"</FC>'                     
                     + '<FC>id=SKU_CD      name="*단품코드"  width=130   align=center   EditStyle=Popup  edit={IF(FLAG=1,"false","true")}</FC>'
                     + '<FC>id=SKU_NAME    name="단품명"     width=130   align=left  edit=none</FC>'
                     + '<FC>id=BARCODE     name="*스캔코드"  width=110   align=center  edit="Numeric"  edit={IF(FLAG=1,"false","true")}</FC>'                     
                     + '<FC>id=STYLE_CD    name="스타일"     width=110   align=left  edit=none</FC>'
                     + '<FG>               name="칼라"'
                     + '<FC>id=COLOR_CD    name="코드"       width=45   align=center  edit=none</FC>'
                     + '<FC>id=COLOR_CD    name="명"         width=70   align=left  edit=none   EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"</FC>'
                     + '</FG>'
                     + '<FG>               name="사이즈"'
                     + '<FC>id=SIZE_CD     name="코드"       width=45   align=center  edit=none</FC>'
                     + '<FC>id=SIZE_CD     name="명"         width=60   align=left     edit=none   EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"</FC>'
                     + '</FG>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 일 : 2010.03.28
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
    if( EM_O_PUMBUN_CD.Text == ""){
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
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하세겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1 ){           
            GD_MASTER.Focus();
            return;
        }
    } 
    
    DS_MASTER.ClearData();
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }    
    
    for( var i = 1 ; i <= DS_MASTER.CountRow; i++){     
        if( DS_MASTER.NameValue( i, "STR_CD") == "" ){
            showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점코드");            
            setFocusGrid(GD_MASTER,DS_MASTER,i,"STR_CD");            
            return false;
        }else if ( DS_MASTER.NameValue( i, "SKU_CD") == "" ){
        	showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "단품코드");            
            setFocusGrid(GD_MASTER,DS_MASTER,i,"SKU_CD");
            return false;
        }else if ( DS_MASTER.NameValue( i, "BARCODE") == "" ){
        	showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "스캔코드");            
            setFocusGrid(GD_MASTER,DS_MASTER,i,"BARCODE");
            return false;
        }else if( DS_MASTER.NameValue( i, "BARCODE")!=""){          
            if(!isSkuCdCheckSum(lpad(DS_MASTER.NameValue( i, "BARCODE"),13,"0"))){
                showMessage(EXCLAMATION, OK, "USER-1069", "스캔코드");                 
                setFocusGrid(GD_MASTER,DS_MASTER,i,"BARCODE");
                return false;               
            }else {
                DS_MASTER.NameValue( i, "BARCODE") = lpad(DS_MASTER.NameValue( i, "BARCODE"),13,'0');
            }
        }else if( DS_MASTER.NameValue( i, "SKU_NAME")==""){
        	showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");            
            setFocusGrid(GD_MASTER,DS_MASTER,i,"SKU_NAME");
            return false;
        }           
    } 
    
    //스캔코드 중복체크
    var dupRow = checkDupKey(DS_MASTER, "STR_CD||BARCODE");    
    if (dupRow>0){
    	//var dupRow1 = checkDupKey(DS_MASTER, "SKU_CD");
    	//if (dupRow1>0){
    		showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);
            
            //DS_MASTER.NameValue( dupRow1, "BARCODE")    = "";
            DS_MASTER.RowPosition = dupRow;
            setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.CountRow,"BARCODE")
            return ;
    	//}        
    }
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_I_SKU_NAME.Focus();
        return;
    }

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
 
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd);
    
    TR_MAIN.Action="/dps/pcod509.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if( TR_MAIN.ErrorCode == 0){        
        btn_Search(); 
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.28
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010.03.28
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * searchMaster()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.28
  * 개    요 : 단품스캔코드정보를 조회한다. 
  * return값 : void
 */
 function searchMaster(){
      
     DS_SKU_COND.UserStatus(1) = '1';
     var goTo       = "searchMaster" ;    
     var action     = "O";
     var parameters = "&styleType="+encodeURIComponent(styleType);
     
     TR_MAIN.Action="/dps/pcod509.pc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET(I:DS_SKU_COND=DS_SKU_COND,"+action+":DS_MASTER=DS_MASTER)"; //조회는 O
     TR_MAIN.Post();
        
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
  }
 
 /**
  * btn_Add1()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.28
  * 개    요 : 그리드 Row추가 
  * return값 : void
 */
 function btn_Add1(){   
    if( EM_O_PUMBUN_CD.Text == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if (EM_O_PUMBUN_CD.Text != ""){         
        DS_MASTER.Addrow(); 
        setFocusGrid(GD_MASTER,DS_MASTER, DS_MASTER.RowPosition ,"STR_CD");
    }
 }

 /**
  * btn_Del1()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.28
  * 개    요 : 그리드 Row 삭제 
  * return값 : void
 */
 function btn_Del1(){
    var row = DS_MASTER.RowPosition;
    if( DS_MASTER.RowStatus(row) == "1")
        DS_MASTER.DeleteRow(row);
    else
        showMessage(INFORMATION, OK, "USER-1052");
    
    GD_MASTER.Focus();
 }
 
 /**
  * setPumbunCdCombo()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.28
  * 개    요 : 브랜드POPUP/품목COMBO를 조회한다.
  * return값 : void
  */
 function setPumbunCdCombo(evnflag){
     
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NM;
     var pmkComboObj = LC_O_PUMMOK_CD;
     skuType = "";
     styleType = "";
     
     //nameObj.Text = "";         
    
     if(codeObj.Text == "" && evnflag != "POP" ){
         setEnableControl(skuType , styleType);
         nameObj.Text = "";
         eval(pmkComboObj.ComboDataID).ClearData();
         DS_O_BRAND_CD_A.ClearData();
         DS_O_SUB_BRD_CD_A.ClearData();
         DS_O_BRAND_CD_B.ClearData();
         DS_O_SUB_BRD_CD_B.ClearData();
         // 기본값 입력( gauce.js )
         insComboData( pmkComboObj, "%", "전체", 1 );
         insComboData( LC_O_BRAND_CD_A, "%", "전체", 1 );
         insComboData( LC_O_SUB_BRD_CD_A, "%", "전체", 1 ); 
         insComboData( LC_O_BRAND_CD_B, "%", "전체", 1 );
         insComboData( LC_O_SUB_BRD_CD_B, "%", "전체", 1 );
         //콤보데이터 기본값 설정( gauce.js )
         setComboData(pmkComboObj,"%");
         setComboData(LC_O_BRAND_CD_A,"%");
         setComboData(LC_O_SUB_BRD_CD_A,"%");
         setComboData(LC_O_BRAND_CD_B,"%");
         setComboData(LC_O_SUB_BRD_CD_B,"%");
         return;
     }

     var result = null;

     if( evnflag == "POP" ){
         
         result = strPbnPop2(codeObj,nameObj,'Y','','','','','','','','1','','','','','');
         if(result != null){
        	 skuType = result.get("SKU_TYPE");
             styleType = result.get("STYLE_TYPE"); 
         }
     }else if( evnflag == "NAME" ){
         
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",'1','','','','','','','','1','','','','','');        

         //if( DS_SEARCH_NM.CountRow > 0){
         //    codeObj.Text = DS_SEARCH_NM.NameValue(1, "PUMBUN_CD");
        //    nameObj.Text = DS_SEARCH_NM.NameValue(1, "PUMBUN_NAME");
         //}        
     }

     if( result != null || DS_SEARCH_NM.CountRow == 1){  
    	 var pumbunCd = codeObj.Text;
         getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"N");
         getStyleBrand("DS_O_BRAND_CD_A", pumbunCd, "Y");
         getStyleSubBrand("DS_O_SUB_BRD_CD_A", pumbunCd, "Y");
         getStyleBrand("DS_O_BRAND_CD_B", pumbunCd, "Y");
         getStyleSubBrand("DS_O_SUB_BRD_CD_B", pumbunCd, "Y");   
         
         //콤보에 '전체' 추가
         insComboData(pmkComboObj,"%","전체",1);        
         //콤보데이터 기본값 설정( gauce.js )
         setComboData(LC_O_BRAND_CD_A,"%");
         setComboData(LC_O_SUB_BRD_CD_A,"%");
         setComboData(LC_O_BRAND_CD_B,"%");
         setComboData(LC_O_SUB_BRD_CD_B,"%");
         setComboData(pmkComboObj,"%");
     }
    	 
     setEnableControl(skuType , styleType);
     DS_MASTER.ClearData();
 } 
 
 /**
  * getSkuPop()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.28
  * 개    요 :  단품GridPopup
  * return값 : void
  */
  function getSkuPop(row, colid , popFlag){   
    var strSkuCd  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SKU_CD"); //단품코드   
    var strSkuNm  ="";  
    var strStrCd  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD"); //단품코드
    DS_MASTER.NameValue(row, "SKU_NAME")="";
    DS_MASTER.NameValue(row, "STYLE_CD")="";
    DS_MASTER.NameValue(row, "COLOR_CD")="";
    DS_MASTER.NameValue(row, "SIZE_CD")="";
    if(strSkuCd != "" && popFlag != "1"){
        
        var rtnMap = setStrSkuNmWithoutToGridPop("DS_O_RESULT", strSkuCd, strSkuNm , 'Y' , '1','',strStrCd,EM_O_PUMBUN_CD.Text,'','','Y','',skuType,'','','','');
        if(rtnMap != null){            
            DS_MASTER.NameValue(row, "SKU_CD")         = rtnMap.get("SKU_CD");
            DS_MASTER.NameValue(row, "SKU_NAME")       = rtnMap.get("SKU_NAME");
            DS_MASTER.NameValue(row, "STYLE_CD")       = rtnMap.get("STYLE_CD");
            DS_MASTER.NameValue(row, "COLOR_CD")       = rtnMap.get("COLOR_CD");
            DS_MASTER.NameValue(row, "SIZE_CD")        = rtnMap.get("SIZE_CD");         
        }       
    }else{
        if (popFlag =="1"){         
            var rtnMap = strSkuToGridPop(strSkuCd , strSkuNm,'Y','',strStrCd,EM_O_PUMBUN_CD.Text,'','','Y','',skuType,'','','','');
            if(rtnMap != null){         
                DS_MASTER.NameValue(row, "SKU_CD")         = rtnMap.get("SKU_CD");
                DS_MASTER.NameValue(row, "SKU_NAME")       = rtnMap.get("SKU_NAME");
                DS_MASTER.NameValue(row, "STYLE_CD")       = rtnMap.get("STYLE_CD");
                DS_MASTER.NameValue(row, "COLOR_CD")       = rtnMap.get("COLOR_CD");
                DS_MASTER.NameValue(row, "SIZE_CD")        = rtnMap.get("SIZE_CD");
            }
        }
    }    
        
 }
 
  function isBarCodeCheck(row,colid){
      
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
  * 작 성 일 : 2010.03.28
  * 개    요 : 단품구분에 따른 Enable여부를 변경한다.
  * return값 : void
  */
 function setEnableControl(skuType , styleType){   
     if (skuType = "3" && styleType == "1"){
         enableControl(LC_O_PLAN_YEAR, true);
         enableControl(LC_O_SEASON_CD, true);
         enableControl(LC_O_BRAND_CD_A, true);
         enableControl(LC_O_SUB_BRD_CD_A, true);
         enableControl(LC_O_BRAND_CD_B, false);
         enableControl(LC_O_SUB_BRD_CD_B, false);
         enableControl(LC_O_ITEM_CD, true);
         enableControl(EM_O_STYLE_CD_A, true);
         enableControl(EM_O_STYLE_NM_A, true);
         enableControl(EM_O_STYLE_CD_B, false);
         enableControl(EM_O_STYLE_NM_B, false);
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
         enableControl(IMG_STYLE_CD_A, true);
         enableControl(IMG_STYLE_CD_B, false);         
         setComboData(LC_O_BRAND_CD_B, "%");
         setComboData(LC_O_SUB_BRD_CD_B, "%");
         setComboData(LC_O_PUMMOK_CD, "%");
         EM_O_SKU_CD.Text = "";
         EM_O_SKU_NM.Text = ""; 
         EM_O_BARCODE.Text = "";
         EM_O_STYLE_CD_B.Text = "";
         EM_O_STYLE_NM_B.Text = "";
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
         
     }else if(skuType = "3" && styleType == "2"){
         enableControl(LC_O_PLAN_YEAR, false);
         enableControl(LC_O_SEASON_CD, false);
         enableControl(LC_O_BRAND_CD_A, false);
         enableControl(LC_O_SUB_BRD_CD_A, false);
         enableControl(LC_O_BRAND_CD_B, true);
         enableControl(LC_O_SUB_BRD_CD_B, true);
         enableControl(EM_O_STYLE_CD_A, false);
         enableControl(EM_O_STYLE_NM_A, false);
         enableControl(EM_O_STYLE_CD_B, true);
         enableControl(EM_O_STYLE_NM_B, true);
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
         enableControl(IMG_STYLE_CD_A, false);
         enableControl(IMG_STYLE_CD_B, true);
         setComboData(LC_O_PLAN_YEAR,"%");
         setComboData(LC_O_SEASON_CD,"%");
         setComboData(LC_O_ITEM_CD,"%");
         setComboData(LC_O_BRAND_CD_A, "%");
         setComboData(LC_O_SUB_BRD_CD_A, "%");
         setComboData(LC_O_PUMMOK_CD, "%");
         EM_O_SKU_CD.Text = "";
         EM_O_SKU_NM.Text = ""; 
         EM_O_BARCODE.Text = "";
         EM_O_STYLE_CD_A.Text = "";
         EM_O_STYLE_NM_A.Text = "";
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
     }else{
         enableControl(LC_O_BRAND_CD_A, false);
         enableControl(LC_O_SUB_BRD_CD_A, false);
         enableControl(LC_O_BRAND_CD_B, false);
         enableControl(LC_O_SUB_BRD_CD_B, false);
         enableControl(LC_O_PLAN_YEAR, false);
         enableControl(LC_O_SEASON_CD, false);
         enableControl(LC_O_ITEM_CD, false);
         enableControl(EM_O_STYLE_CD_A, false);
         enableControl(EM_O_STYLE_NM_A, false);
         enableControl(EM_O_MNG_CD1, false);
         enableControl(EM_O_MNG_CD2, false);
         enableControl(EM_O_MNG_CD3, false);
         enableControl(EM_O_MNG_CD4, false);
         enableControl(EM_O_MNG_CD5, false);
         enableControl(EM_O_STYLE_CD_B, false);
         enableControl(EM_O_STYLE_NM_B, false);
         enableControl(IMG_MNG_CD1, false);
         enableControl(IMG_MNG_CD2, false);
         enableControl(IMG_MNG_CD3, false);
         enableControl(IMG_MNG_CD4, false);
         enableControl(IMG_MNG_CD5, false);
         enableControl(IMG_STYLE_CD_A, false);
         enableControl(IMG_STYLE_CD_B, false);         
         setComboData(LC_O_PLAN_YEAR,"%");
         setComboData(LC_O_SEASON_CD,"%");
         setComboData(LC_O_ITEM_CD,"%");
         setComboData(LC_O_BRAND_CD_A, "%");
         setComboData(LC_O_SUB_BRD_CD_A, "%");
         setComboData(LC_O_BRAND_CD_B, "%");
         setComboData(LC_O_SUB_BRD_CD_B, "%");         
         EM_O_SKU_CD.Text = "";
         EM_O_SKU_NM.Text = "";         
         EM_O_STYLE_CD_A.Text = "";
         EM_O_STYLE_NM_A.Text = "";
         EM_O_STYLE_CD_B.Text = "";
         EM_O_STYLE_NM_B.Text = "";
         EM_O_BARCODE.Text = "";
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
<!-- 단품코드 변경시 -->
<script language=JavaScript for=EM_O_SKU_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if( this.Text == ""){
        EM_O_SKU_NM.Text = "";
        return;
    }
    setStrSkuNmWithoutPop( "DS_O_SKU_CD", this, EM_O_SKU_NM , 'Y' , '0','',LC_O_STR_CD.BindColVal,EM_O_PUMBUN_CD.Text,'','','','',skuType,'','','',''); 
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;    
    
    var row = DS_MASTER.RowPosition; 
    if(DS_MASTER.RowStatus(row)==1){
           // 초기화하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
            EM_O_PUMBUN_CD.Focus();
            return;         
        }       
    }
    setPumbunCdCombo("NAME");
    DS_MASTER.ClearData();
</script>

<!-- 스타일코드A 변경시 -->
<script language=JavaScript for=EM_O_STYLE_CD_A event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    EM_O_STYLE_NM_A.Text = "";
    if (EM_O_STYLE_CD_A.Text.length != 0){
        var rtnMap = setStyleNmWithoutToGridPop( "DS_O_STYLE_CD_A", this.Text, EM_O_STYLE_NM_A.Text ,'Y' , '0' ,'',EM_O_PUMBUN_CD.Text,'');
        if (rtnMap != null){
            EM_O_STYLE_CD_A.Text = rtnMap.get("STYLE_CD");
            EM_O_STYLE_NM_A.Text = rtnMap.get("STYLE_NAME");
        }
    }       
</script>

<!-- 스타일코드B 변경시 -->
<script language=JavaScript for=EM_O_STYLE_CD_B event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    EM_O_STYLE_NM_B.Text = "";
    if (EM_O_STYLE_CD_B.Text.length != 0){
        var rtnMap = setStyleNmWithoutToGridPop( "DS_O_STYLE_CD_B", this.Text, EM_O_STYLE_NM_B.Text ,'Y' , '0' ,'',EM_O_PUMBUN_CD.Text,'');
        if (rtnMap != null){
            EM_O_STYLE_CD_B.Text = rtnMap.get("STYLE_CD");
            EM_O_STYLE_NM_B.Text = rtnMap.get("STYLE_NAME");
        }
    }       
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

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    var strCd = DS_MASTER.NameValue(row, "STR_CD");
    if (strCd != ""){
        if (colid == "SKU_CD" && strCd != ""){         
            getSkuPop(row , colid , '1');
        }
    }else{
          showMessage(EXCLAMATION, OK, "USER-1003" , "점");
          setFocusGrid(GD_MASTER,DS_MASTER, row ,"STR_CD");
          return false;
    }   
</script>

<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    var orgValue = DS_MASTER.OrgNameValue(row,colid);
    var newValue = DS_MASTER.NameValue(row,colid);
    var changeFlag = (orgValue != newValue || DS_MASTER.RowStatus(row) == 1) ;
    var strCd = DS_MASTER.NameValue(row, "STR_CD");
    //var barCode = DS_MASTER.NameValue(row, "BARCODE");
    var skuCd = DS_MASTER.NameValue(row, "SKU_CD");
    if(row < 1 )
        return true;
    /** 
    switch(colid){
        case 'BARCODE':
            var value = eval(this.DataID).NameValue(row,colid);
            
            if(!isSkuCdCheckSum(lpad(value,13,"0"))){
                showMessage(EXCLAMATION, OK, "USER-1069", "스캔코드");
                eval(this.DataID).NameValue(row,colid) = "";
                eval(this.DataID).NameValue(row,"BARCODE") = "";
                setFocusGrid(GD_MASTER,DS_MASTER,row,"BARCODE");
                return false;               
            }
            eval(this.DataID).NameValue(row,"BARCODE") = lpad(value,13,0);            
            break;
        }
    */
    if (changeFlag ){
        if (strCd != ""){
            if (colid == "SKU_CD" && strCd != ""){         
                getSkuPop(row , colid , '');
            }
        }
        /**
        else{
            showMessage(EXCLAMATION, OK, "USER-1003" , "점");
            setFocusGrid(GD_MASTER,DS_MASTER, row,"STR_CD");
            return false;
        }*/
        
    } 
    
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    var orgValue = DS_MASTER.OrgNameValue(row,colid);
    var newValue = DS_MASTER.NameValue(row,colid);
    var changeFlag = (orgValue != newValue || DS_MASTER.RowStatus(row) == 1) ;
    var strCd = DS_MASTER.NameValue(row, "STR_CD");
    var barCode = DS_MASTER.NameValue(row, "BARCODE");
    var skuCd = DS_MASTER.NameValue(row, "SKU_CD");
    if(row < 1 )
        return true;
    
    switch(colid){
        case 'BARCODE':
            var value = eval(this.DataID).NameValue(row,colid);
            if (value==''){
                return true; 
            }
            var tmpInputPlu = lpad(value,13,"0");
            if( tmpInputPlu.substr(0,1)=='2'){            	
                showMessage(EXCLAMATION, OK, "USER-1069", "스캔코드");        
                eval(this.DataID).NameValue(row,colid) = "";
                setFocusGrid(GD_MASTER,DS_MASTER,row,"BARCODE");
                return false;
            }
            if(!isSkuCdCheckSum(tmpInputPlu)){
                showMessage(EXCLAMATION, OK, "USER-1069", "스캔코드");
                eval(this.DataID).NameValue(row,colid) = "";
                //eval(this.DataID).NameValue(row,"BARCODE") = "";
                setFocusGrid(GD_MASTER,DS_MASTER,row,"BARCODE");
                return false;               
            }
            eval(this.DataID).NameValue(row,"BARCODE") = lpad(value,13,0);            
            break;
        }
    if (changeFlag ){
        if (strCd != ""){
            if (colid == "SKU_CD" && strCd != ""){         
                getSkuPop(row , colid , '');
            }
        }
        /**
        else{
            showMessage(EXCLAMATION, OK, "USER-1003" , "점");
            setFocusGrid(GD_MASTER,DS_MASTER, row,"STR_CD");
            return false;
        }*/
        
    }
    return true;
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
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PUMMOK_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_BRAND_CD_A"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SUB_BRD_CD_A"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PLAN_YEAR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SEASON_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ITEM_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_BRAND_CD_B"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SUB_BRD_CD_B"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD1"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD3"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD4"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD5"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STYLE_CD_A"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STYLE_CD_B"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COLOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SIZE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SKU_COND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
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
            <th width="60" class="point">브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCdCombo('POP'); EM_O_PUMBUN_CD.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=79 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script> 
            </td>
            <th width="60">점</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">품목</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=220 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="60">단품코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_O_SKU_CD classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:strSkuPop(EM_O_SKU_CD,EM_O_SKU_NM,'Y','',LC_O_STR_CD.BindColVal,EM_O_PUMBUN_CD.Text,'','','','',skuType,'','','',''); EM_O_SKU_CD.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_SKU_NM classid=<%=Util.CLSID_EMEDIT%> width=250 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>              
            </td>
            <th width="60">스캔코드</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_O_BARCODE classid=<%=Util.CLSID_EMEDIT%> width=215 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60">브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_BRAND_CD_A classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">서브브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_SUB_BRD_CD_A classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">기획년도</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_PLAN_YEAR classid=<%= Util.CLSID_LUXECOMBO %> width=220 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="60">시즌</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_SEASON_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">아이템</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_ITEM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">스타일</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_O_STYLE_CD_A classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_STYLE_CD_A" class="PR03" onclick="javascript:stylePop(EM_O_STYLE_CD_A,EM_O_STYLE_NM_A,'Y','',EM_O_PUMBUN_CD.Text,'',''); EM_O_STYLE_CD_A.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_STYLE_NM_A classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>              
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60">브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_BRAND_CD_B classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">서브브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_SUB_BRD_CD_B classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">관리항목1</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD1 classid=<%= Util.CLSID_EMEDIT %> width=90 tabindex=1  align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD1" class="PR03" onclick="javascript:setInitCommonPop('관리항목1','P005','POP',EM_O_MNG_CD1,EM_O_MNG_NM1); EM_O_MNG_CD1.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM1 classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>          
            <th width="60">관리항목2</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD2 classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1  align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD2" class="PR03" onclick="javascript:setInitCommonPop('관리항목2','P006','POP',EM_O_MNG_CD2,EM_O_MNG_NM2); EM_O_MNG_CD2.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM2 classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td> 
            <th width="60">관리항목3</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD3 classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1  align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD3" class="PR03" onclick="javascript:setInitCommonPop('관리항목3','P007','POP',EM_O_MNG_CD3,EM_O_MNG_NM3); EM_O_MNG_CD3.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM3 classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td> 
            <th width="60">관리항목4</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD4 classid=<%= Util.CLSID_EMEDIT %> width=90 tabindex=1  align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD4" class="PR03" onclick="javascript:setInitCommonPop('관리항목4','P008','POP',EM_O_MNG_CD4,EM_O_MNG_NM4); EM_O_MNG_CD4.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM4 classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
          <tr>
            <th width="60">관리항목5</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD5 classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1  align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD5" class="PR03" onclick="javascript:setInitCommonPop('관리항목5','P009','POP',EM_O_MNG_CD5,EM_O_MNG_NM5); EM_O_MNG_CD5.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM5 classid=<%= Util.CLSID_EMEDIT %> width=80  tabindex=1 align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>  
            <th width="60">스타일</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_O_STYLE_CD_B classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_STYLE_CD_B" class="PR03" onclick="javascript:stylePop(EM_O_STYLE_CD_B,EM_O_STYLE_NM_B,'Y','',EM_O_PUMBUN_CD.Text,'',''); EM_O_STYLE_CD_B.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_STYLE_NM_B classid=<%=Util.CLSID_EMEDIT%> width=277 tabindex=1  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>              
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
      <td class="right PB02" valign="bottom">
      <img src="/<%=dir%>/imgs/btn/add_row.gif" onclick="javascript:btn_Add1();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" onclick="javascript:btn_Del1();""/>
    </td>
  </tr>
  <tr valign="top">
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td class="PT03">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=305 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
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
<object id=BO_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_SKU_COND>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c>col=STR_CD           ctrl=LC_O_STR_CD          param=BindColVal </c>
            <c>col=PUMBUN_CD        ctrl=EM_O_PUMBUN_CD       param=Text </c>                         
            <c>col=PUMMOK_CD        ctrl=LC_O_PUMMOK_CD       param=BindColVal </c>   
            <c>col=STYLE_CD_A       ctrl=EM_O_STYLE_CD_A      param=Text </c>            
            <c>col=STYLE_NM_A       ctrl=EM_O_STYLE_NM_A      param=Text </c>
            <c>col=STYLE_CD_B       ctrl=EM_O_STYLE_CD_B      param=Text </c>            
            <c>col=STYLE_NM_B       ctrl=EM_O_STYLE_NM_B      param=Text </c>
            <c>col=SKU_CD           ctrl=EM_O_SKU_CD          param=Text </c>
            <c>col=SKU_NM           ctrl=EM_O_SKU_NM          param=Text </c>  
            <c>col=BARCODE          ctrl=EM_O_BARCODE         param=Text </c>                       
            <c>col=BRAND_CD_A       ctrl=LC_O_BRAND_CD_A      param=BindColVal </c>
            <c>col=SUB_BRD_CD_A     ctrl=LC_O_SUB_BRD_CD_A    param=BindColVal </c>
            <c>col=BRAND_CD_B       ctrl=LC_O_BRAND_CD_B      param=BindColVal </c>
            <c>col=SUB_BRD_CD_B     ctrl=LC_O_SUB_BRD_CD_B    param=BindColVal </c>
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


