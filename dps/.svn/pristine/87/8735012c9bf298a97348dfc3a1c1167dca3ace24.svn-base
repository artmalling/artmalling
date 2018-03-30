<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품가격> 단품가격예약등수정(규격/신선)
 * 작 성 일 : 2010.04.04
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod6020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품의 판매가를 수정한다.
          (적용전 가격만 수정 가능)
 * 이    력 :
 *        2010.04.04 (정진영) 신규작성
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
var bfVenCd;
var bfPumbunCd;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-04
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_VEN_CD     , "CODE^6"    , NORMAL);      //협력사코드(조회)
    initEmEdit(EM_VEN_NAME   , "GEN"       , READ);    //협력사명(조회)
    initEmEdit(EM_PUMBUN_CD  , "CODE^6^0"  , PK);  //브랜드코드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN"       , READ);    //브랜드명(조회)
    initEmEdit(EM_SKU_CD     , "CODE^13^0" , NORMAL);  //단품코드(조회)
    initEmEdit(EM_SKU_NAME   , "GEN^40"    , NORMAL);  //단품명(조회)

    //콤보 초기화
    initComboStyle(LC_STR_CD   , DS_STR_CD   , "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)
    initComboStyle(LC_PUMMOK_CD, DS_PUMMOK_CD, "CODE^0^60,NAME^0^80", 1, NORMAL);  //품목(조회)

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_PUMMOK_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    
    // 기본값 입력( gauce.js )
    insComboData( LC_PUMMOK_CD, "%", "전체", 1 );
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "Y");
    
    //콤보데이터 기본값 설정( gauce.js )
    LC_STR_CD.Index = 0;
    setComboData(LC_PUMMOK_CD,"%");
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod602","DS_MASTER" );
    
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      width=30  align=center edit=none        name="NO" </FC>'
                     + '<FC>id=SEL           width=50 align=center                   name="삭제" EditStyle=CheckBox HeadCheckShow=true</FC>'
                     + '<FG> name="브랜드"'
                     + '<FC>id=PUMBUN_CD     width=60  align=center edit=none        name="코드" </FC>'
                     + '<FC>id=PUMBUN_NAME   width=130 align=left   edit=none        name="명"</FC>'
                     + '</FG>'
                     + '<FC>id=STR_CD        width=80  align=left   edit=none        name="점" EditStyle=Lookup data="DS_STR_CD:CODE:NAME" </FC>'
                     + '<FG> name="단품"'
                     + '<FC>id=SKU_CD        width=100 align=center edit=none        name="코드" </FC>'
                     + '<FC>id=SKU_NAME      width=130 align=left   edit=none        name="명"</FC>'
                     + '</FG>'
                     + '<FC>id=APP_S_DT      width=85  align=center                  name="*적용시작일"  mask="XXXX/XX/XX" EditStyle=Popup </FC>'
                     + '<FC>id=APP_E_DT      width=85  align=center edit=none        name="적용종료일"   mask="XXXX/XX/XX" EditStyle=Popup </FC>'
                     ////+ '<FC>id=NORM_COST_PRC width=80  align=right  edit=Numeric     name="*판매원가"       edit={IF((BIZ_TYPE=1 AND PUMBUN_TYPE=4) OR BIZ_TYPE=2 OR BIZ_TYPE=3 OR BIZ_TYPE=5,"false","true")} </FC>'
                     ////+ '<FC>id=NORM_SALE_PRC width=80  align=right  edit=Numeric     name="*판매매가"       edit={IF((BIZ_TYPE=1 AND PUMBUN_TYPE<>4) AND SKU_TYPE=2,"false","true")} </FC>'
                     + '<FC>id=NORM_COST_PRC width=80  align=right  edit=Numeric     name="*판매원가"       edit={IF((BIZ_TYPE=1 AND PUMBUN_TYPE=4 AND SKU_TYPE=2) OR BIZ_TYPE=2 OR BIZ_TYPE=3 OR BIZ_TYPE=5,"false","true")} </FC>'
                     + '<FC>id=NORM_SALE_PRC width=80  align=right  edit=Numeric     name="*판매매가"       edit={IF((BIZ_TYPE=1 AND PUMBUN_TYPE<>4) AND SKU_TYPE=2,"false","true")} </FC>'
                     + '<FC>id=NORM_MG_RATE  width=80  align=right  edit=RealNumeric name="*마진율"     edit={IF(BIZ_TYPE=1 AND SKU_TYPE=1,"false","true")} </FC>';

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
 * 작 성 일 : 2010-04-04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
    if( DS_MASTER.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1059")!=1){
            GD_MASTER.Focus();
            return;
        }
    }  
    DS_MASTER.ClearData();

    var strStrCd     = LC_STR_CD.BindColVal;
    var strVenCd     = EM_VEN_CD.Text;
    var strPumbunCd  = EM_PUMBUN_CD.Text;
    var strPummokCd  = LC_PUMMOK_CD.BindColVal;
    var strSkuCd     = EM_SKU_CD.Text;
    var strSkuName   = EM_SKU_NAME.Text;
    
    if( strPumbunCd == ""){
        // (협력사)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_PUMBUN_NAME.Text == ""){
        // 존재하지 않는 협력사입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_PUMBUN_CD.Focus();
        return;
    }

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strVenCd="+encodeURIComponent(strVenCd)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strPummokCd="+encodeURIComponent(strPummokCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd)
                   + "&strSkuName="+encodeURIComponent(strSkuName);
        
    TR_MAIN.Action="/dps/pcod602.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2010-04-04
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-04
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	 
    if( !checkDelYn()){
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_MASTER.CountRow < 1)
            EM_PUMBUN_CD.Focus();
        else
            GD_MASTER.Focus();
        
        return;
    }
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    
    //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        GD_MASTER.Focus();
        return;
    }
    
    for( var i=1; i<=DS_MASTER.CountRow; i++){
        if(DS_MASTER.NameValue(i,"SEL")=="T"){
            DS_MASTER.RowMark(i) = 1;
        }else{
            DS_MASTER.RowMark(i) = 0;           
        }
    }    

    DS_MASTER.DeleteMarked();
    
    TR_MAIN.Action="/dps/pcod602.pc?goTo=delete";
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	btn_Search();       
    }
    GD_MASTER.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-04
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if(checkDelYn()){
        showMessage(INFORMATION, OK, "USER-1000", "삭제 선택 해제 후 저장하세요.");
        GD_MASTER.Focus();
        return;		
	}
    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated  ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        
        if( DS_MASTER.CountRow < 1)
            EM_PUMBUN_CD.Focus();
        else
            GD_MASTER.Focus();
        
        return;
    }
    
    if( !checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return;
    }
    
    TR_MAIN.Action="/dps/pcod602.pc?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();       
    }
    GD_MASTER.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-04
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-04
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * checkDelYn()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 삭제 선택 여부
 * return값 : void
**/
function checkDelYn(){
    for( var i=1; i<=DS_MASTER.CountRow; i++){
        if(DS_MASTER.NameValue(i,"SEL")=="T"){
            return true;
        }
    }
    return false;    
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
    //var venCd = EM_VEN_CD.Text;

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 브랜드 변경 하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1063","브랜드" )!=1){
            codeObj.Text = bfPumbunCd;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        eval(pmkComboObj.ComboDataID).ClearData();
        nameObj.Text = "";
        // 기본값 입력( gauce.js )
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");
        return;     
    }
    
    var result = null;
    DS_SEARCH_NM.ClearData();
    if( evnflag == "POP" ){
        result = strPbnPop2(codeObj,nameObj,'Y','', strCd,'','','','','Y','1');
    }else if( evnflag == "NAME" ){
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','','Y','1');
    }
    if( result != null || DS_SEARCH_NM.CountRow == 1){
        var pumbunCd = codeObj.Text;
        var skuType = result != null ? result.get('SKU_TYPE'): DS_SEARCH_NM.NameValue(1,'SKU_TYPE');
        
        if( !(skuType == '1' || skuType == '2') ){
            showMessage(INFORMATION, OK, "USER-1000", "단품가격예약수정(규격/신선)은 [규격단품/신선단품] 만 등록 할 수 있습니다.");
            eval(pmkComboObj.ComboDataID).ClearData();
            codeObj.Text = "";
            nameObj.Text = "";      
            // 기본값 입력( gauce.js )
            insComboData( pmkComboObj, "%", "전체", 1 );
            setComboData( pmkComboObj,"%");
            bfPumbunCd = codeObj.Text;
        	return;
        }
        getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"Y");
        setComboData( pmkComboObj,"%");
       
    }else{
    	if( nameObj.Text == ""){
            eval(pmkComboObj.ComboDataID).ClearData();
            codeObj.Text = "";
            nameObj.Text = "";      
            // 기본값 입력( gauce.js )
            insComboData( pmkComboObj, "%", "전체", 1 );
            setComboData( pmkComboObj,"%");
    	}
    }
    bfPumbunCd = codeObj.Text;
    if( evnflag == "POP" ){
        codeObj.Focus();
    }
}
/**
 * setVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/
function setVenCode(evnFlag){
	var codeObj = EM_VEN_CD;
	var nameObj = EM_VEN_NAME;

    if( evnFlag == 'POP'){
        venPop(codeObj,nameObj,LC_STR_CD.BindColVal,'Y');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";      
        return;
    }
    
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 1,LC_STR_CD.BindColVal,'Y');

}

/**
 * searchVenmst()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 정보를 조회한다.
 * return값 : void
**/

function searchVenmst(venCdObj) {
     var venCd = venCdObj.Text;
     if( venCd.length != 6 )
    	 return;
     
     // 협력사 정보 조회 popup_dps.js
     getVenInfo("DS_SEARCH_NM", venCd);
     
     if ( DS_SEARCH_NM.countRow != 1  ){
         showMessage(EXCLAMATION, OK, "USER-1000", "협력사 정보가 존재하지 않습니다.");
         EM_VEN_CD.Text = "" ;
         EM_VEN_NAME.Text = "" ;   	 
    	 return;
     }
     
     if( !(DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='1'
                || DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='2'
                || DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='3')){
         showMessage(EXCLAMATION, OK, "USER-1000", "거래형태는 ['직매입','특정매입','임대을']만 가능합니다.");
         EM_VEN_CD.Text = "" ;
         EM_VEN_NAME.Text = "" ;
     }

     bfVenCd = EM_VEN_CD.Text;
}

/**
 * setStrSkuCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.
 * return값 : void
**/
function setStrSkuCode(evnFlag){
    var codeObj = EM_SKU_CD;
    var nameObj = EM_SKU_NAME;


    if( evnFlag == 'NAME' && codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
    	strSkuPop(codeObj,nameObj,'Y','','',EM_PUMBUN_CD.Text, '','','Y');
        codeObj.Focus();
        return;
    }
    
    setStrSkuNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 'Y', 0,'','',EM_PUMBUN_CD.Text, '','','Y');

}

/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 단품가격정보 입력을 체크한다.
 * return값 : void
 */
function checkMasterValidation(){
    var check = false;
    var titleNm = "";
    var colId = "";
    var row = "";
    
    for(var i = 1; i <= DS_MASTER.CountRow; i++ ) {
        var rowStatus = DS_MASTER.RowStatus(i);
        if( rowStatus == 0 
                || rowStatus == 2
                || rowStatus == 4)
                continue;
        row = i;
        var bizType = DS_MASTER.NameValue(i,'BIZ_TYPE');
        var skuType = DS_MASTER.NameValue(i,'SKU_TYPE');
        if( Number(DS_MASTER.NameString( i, "NORM_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "원가","0");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'NORM_COST_PRC');
            return false;                    
        }
        var saleLow = 1;
        var lowMgRate = Number(DS_MASTER.NameString( i, "LOW_MG_RATE"));

        // 신선일 경우 - 매가는  0 입력 가능
        if( skuType == '2'){
            saleLow = 0;
        }
        // 직매입 신선일 경우 - 마진율은  0 입력 가능
        if(bizType == '1' && skuType == '2'){
        	lowMgRate = 0;
        }
        
        if( Number(DS_MASTER.NameString( i, "NORM_SALE_PRC")) < saleLow ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "매가",saleLow);
            setFocusGrid(GD_MASTER,DS_MASTER,i,'NORM_SALE_PRC');
            return false;                    
        }
        
     	// MARIO OUTLET 2011-08-11 
        // getRoundDec() 원단위 절사함수
        if(Number(DS_MASTER.NameString( i, "NORM_SALE_PRC")) > 0) {
            if((Number(DS_MASTER.NameString( i, "NORM_SALE_PRC"))%10) > 0) {
            	showMessage(EXCLAMATION, Ok,  "USER-1000", "판매매가는 원단위로 입력 할 수 없습니다.");
            	setFocusGrid(GD_MASTER,DS_MASTER,i,"NORM_SALE_PRC");
            	return false;	
            }
        }
        
        if( Number(DS_MASTER.NameString( i, "NORM_MG_RATE")) < lowMgRate ){
            if( lowMgRate == 0)
                showMessage(EXCLAMATION, Ok,  "USER-1020", "마진율",lowMgRate);
            else
                showMessage(EXCLAMATION, Ok,  "USER-1081", lowMgRate);
            
            setFocusGrid(GD_MASTER,DS_MASTER,i,'NORM_MG_RATE');
            return false;                    
        }
        
        if( Number(DS_MASTER.NameString( i, "NORM_MG_RATE")) > 100 ){
            showMessage(EXCLAMATION, Ok,  "USER-1021", "마진율","100");
            setFocusGrid(GD_MASTER,DS_MASTER,i,'NORM_MG_RATE');
            return false;                    
        }
        
        if( DS_MASTER.NameValue( i, "APP_S_DT") == ''){
            check = true;
            titleNm = "적용시작일";
            colId = "APP_S_DT";
            break;
        }
        
        if(!checkDateTypeYMD(GD_MASTER,"APP_S_DT",''))
            return false;
        
        var toDay = getTodayFormat("YYYYMMDD");
        if( DS_MASTER.NameValue( i, "APP_S_DT") <= toDay){
            showMessage(EXCLAMATION, OK, "USER-1011", "적용시작일");
            setFocusGrid(GD_MASTER,DS_MASTER,i,"APP_S_DT");
            return false;
        }
        if( DS_MASTER.NameValue( i, "APP_S_DT") > DS_MASTER.NameValue( i, "APP_E_DT")){
            showMessage(EXCLAMATION, OK, "USER-1008", "적용시작일","적용종료일");
            setFocusGrid(GD_MASTER,DS_MASTER,i,"APP_S_DT");
            return false;
        }
    }

    var dupRow = checkDupKey(DS_MASTER,"STR_CD||SKU_CD||APP_S_DT");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        return false;                               
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_MASTER,DS_MASTER,row,colId);
        return false;
    }
    return true;
}

/**
 * setCostSaleMg()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 로우의 타입에 따라 원가 매가 마진율을 계산한다.
 * return값 : void
 */
function setCostSaleMg( row){

    var bizType = DS_MASTER.NameValue(row,"BIZ_TYPE");
    var pumbunType = DS_MASTER.NameValue(row,"PUMBUN_TYPE");
    var skuType = DS_MASTER.NameValue(row,"SKU_TYPE");
    var taxFlag = DS_MASTER.NameValue(row,"TAX_FLAG");
    var roundFlag = DS_MASTER.NameValue(row,"ROUND_FLAG");
    var costPrc = DS_MASTER.NameString(row,"NORM_COST_PRC");
    var salePrc = DS_MASTER.NameString(row,"NORM_SALE_PRC");
    var mgRate = DS_MASTER.NameString(row,"NORM_MG_RATE");

    costPrc = Number(costPrc);
    salePrc = Number(salePrc);
    mgRate = Number(mgRate);
    // 거래형태[직매입]
    if( bizType == "1"){
        // 단품종류 [규격]
        if(skuType =="1"){
            // 판매원가와 판매매가을 등록하면 마진율을 계산
            DS_MASTER.NameValue(row,"NORM_MG_RATE") = getSaleMgRate(costPrc, salePrc, roundFlag, taxFlag);
        // 단품종류 [신선]
        }else if(skuType =="2"){
        	
        	// MARIO OUTLET 신선 FNB 단품인 경우 추가
        	if (pumbunType == "4") {
        		DS_MASTER.NameValue(row, "NORM_COST_PRC") = getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
        	} else {
        		// 판매원가와 마진율을 등록하면 판매매가을 계산
            	DS_MASTER.NameValue(row, "NORM_SALE_PRC") = getSalePrc(costPrc, mgRate, roundFlag, taxFlag);
        	}
        }
    // 거래형태[특정매입]
    }else {
        // 단품종류 [규격]
        if(skuType =="1"){
            // 판매매가와 마진율을 등록하면 판매원가을 계산
            DS_MASTER.NameValue(row,"NORM_COST_PRC") =  getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
        // 단품종류 [신선]
        }else if(skuType =="2"){
            // 판매원가와 마진율을 등록하면 판매매가을 계산
            DS_MASTER.NameValue(row,"NORM_COST_PRC") = getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
            
        }
    }
}

/**
 * clickGridHeadCheck()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 그리드 헤더 클릭시 모든 로우 반영
 * return값 :
 */
function clickGridHeadCheck( dataSet, value){
    for( var i=1; i<=dataSet.CountRow; i++){
        dataSet.NameValue(i,"SEL") = value==1?"T":"F";
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

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_MASTER,bCheck);
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 데이터변경  -->
<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>
    if(row < 1)
        return true;
    switch(colid){
        case 'APP_S_DT':
        case 'APP_E_DT':
            var value = DS_MASTER.NameValue(row,colid);
            var orgValue = DS_MASTER.OrgNameValue(row,colid);
            if( value == orgValue || value == "" )
                break;
        
            if(!checkDateTypeYMD(this,colid,''))
                return false;
            var colName = this.GetHdrDispName(-3, colid);
            // 날짜는 금일 이후로 등록 가능합니다.
            if( value <= getTodayFormat("YYYYMMDD")){
                // ()는 익일 이후로 등록 가능합니다.
                showMessage(EXCLAMATION, OK, "USER-1011", colName);
                DS_MASTER.NameValue(row,colid) = orgValue;
                return false;               
            }
            var dupRow = checkDupKey(DS_MASTER,"STR_CD||SKU_CD||APP_S_DT");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                return false;                           	
            }
            break;
        case 'NORM_COST_PRC':
        case 'NORM_SALE_PRC':
        case 'NORM_MG_RATE':
        	setCostSaleMg(row);
            break;
    }
</script>
<!-- 포커스 이동 일 경우  값 계산-->
<script language=JavaScript for=GD_MASTER event=onKillFocus()>
    setCostSaleMg(DS_MASTER.RowPosition);
</script>
<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    openCal(this,row,colid);
</script>
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setPumbunCode("NAME");
</script>
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setVenCode('NAME');
</script> 
<!-- 단품(조회) -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setStrSkuCode('NAME');
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
<comment id="_NSID_"><object id="DS_STR_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PUMMOK_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="60" >점</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">브랜드</th>
            <td width="190">
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=50 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setPumbunCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%= Util.CLSID_EMEDIT %> width=110 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">단품코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%= Util.CLSID_EMEDIT %> width=95 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascript:setStrSkuCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%= Util.CLSID_EMEDIT %> width=105 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >품목</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>협력사</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"> </object>
              </comment> <script> _ws_(_NSID_);</script><img
              src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:setVenCode('POP')" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="absmiddle"> </object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr >
    <td valign="top" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=478 classid=<%=Util.CLSID_GRID%>>
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

</body>
</html>

