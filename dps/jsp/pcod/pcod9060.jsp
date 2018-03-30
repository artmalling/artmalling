<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > F&B매장정보> F&B 메뉴관리
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod9060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : F&B 매장 및 코너의 메뉴를 관리한다.
 * 이    력 :
 *        2010.01.19 (정진영) 신규작성
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
var bfStrCd;
var bfFnbShopFlag;
var bfFnbShopCd;
var bfMasterRow = 0;
var btnSaveYn = false;
var isOnPopup = false;
var top = 140;		//해당화면의 동적그리드top위치

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세

    // EMedit에 초기화
    initEmEdit(EM_FNB_SHOP_CD   , "CODE^4^0" ,  PK);      //매장코드(조회)
    initEmEdit(EM_FNB_SHOP_NAME , "GEN^20"   ,  READ);    //매장명(조회)
    initEmEdit(EM_MENU_FLAG_CD  , "CODE^2"   ,  NORMAL);  //메뉴분류(코너)크드(조회)
    initEmEdit(EM_MENU_FLAG_NAME, "GEN^20"   ,  NORMAL);  //메뉴분류(코너)명(조회)
    //콤보 초기화 
    initComboStyle(LC_STR_CD        ,DS_STR_CD        , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_FNB_SHOP_FLAG ,DS_FNB_SHOP_FLAG , "CODE^0^30,NAME^0^80", 1, PK);  //F&B매장구분(조회)
    initComboStyle(LC_USE_YN        ,DS_USE_YN        , "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FNB_SHOP_FLAG" , "D", "P078", "N");
    getEtcCode("DS_USE_YN"        , "D", "D022", "Y");
    
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_FNB_SHOP_FLAG, '1');
    setComboData(LC_USE_YN, 'Y');
    
    bfStrCd = LC_STR_CD.BindColVal;
    bfFnbShopFlag = LC_FNB_SHOP_FLAG.BindColVal;
    
    // 삭제된 로우 표시여부
    //DS_DETAIL.ViewDeletedRow = true;

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod906","DS_MASTER,DS_DETAIL" );
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       width=25   align=center name="NO"                    </FC>'
                     + '<FC>id=MENU_FLAG_CD   width=80   align=center name="메뉴분류코드;(코너코드)" </FC>'
                     + '<FC>id=MENU_FLAG_NAME width=100  align=left   name="메뉴분류명;(코너명)"     </FC>'
                     + '<FC>id=USE_YN         width=55   align=left   name="사용;여부 "              EditStyle=Combo Data="Y:YES,N:NO"</FC>';
 
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    GD_MASTER.TitleHeight = 45; 
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}   width=25  align=center edit=none    name="NO"         </FC>'
    				 + '<FC>id=STR_CD  width=0 align=left                show=false    </FC>'
    				 + '<FC>id=FNB_SHOP_CD  width=0 align=left                 show=false   </FC>'
    				 + '<FC>id=MENU_FLAG_CD  width=0 align=left                 show=false    </FC>'
    				 + '<FC>id=SKU_CD     width=120 align=center edit=Numeric name="*단품코드  "   EditStyle=Popup</FC>'
                     + '<FC>id=RECP_NAME  width=185 align=left                name="영수증명"     </FC>'
                     + '<FC>id=SORT_NO    width=70  align=right  edit=Numeric name="*정렬순서 "   </FC>'
                     + '<FC>id=USE_YN     width=70  align=left                name="*사용여부 "   EditStyle=Combo Data="Y:YES,N:NO"</FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( LC_FNB_SHOP_FLAG.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "F&B매장구분");
        LC_FNB_SHOP_FLAG.Focus();
        return;
    }
    if( EM_FNB_SHOP_CD.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "매장");
        EM_FNB_SHOP_CD.Focus();
        return;
    }
    if( EM_FNB_SHOP_NAME.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1036", "매장");
        EM_FNB_SHOP_CD.Focus();
        return;
    }
    
    if( DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_DETAIL.Focus();
            return ;
        }
    }
    bfMasterRow = 0;
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
    // 저장할 데이터 없는 경우
    if (!DS_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if(DS_DETAIL.CountRow > 0){
            GD_DETAIL.Focus();
            return;
        }
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_DETAIL.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return; 
    }
    
    TR_MAIN.Action="/dps/pcod906.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchDetail();        
    }
    GD_DETAIL.Focus();

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
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 추가
 * return값 : void
 */
function btn_addRow(){
    var masterRow = DS_MASTER.RowPosition;
    var fnbShopFlag = LC_FNB_SHOP_FLAG.BindColVal;
    if( masterRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", (fnbShopFlag=="1"?"메뉴분류":"코너") + " 선택 후 행추가가 가능합니다.");
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }
    if( DS_MASTER.NameValue(masterRow,"USE_YN")=="N"){
        showMessage(INFORMATION, OK, "USER-1000", "사용할 수 없는 메뉴분류(코너)입니다.");
        GD_MASTER.Focus();
        return;     
    }
    var strCd      = DS_MASTER.NameValue(masterRow,"STR_CD");
    var fnbShopCd  = DS_MASTER.NameValue(masterRow,"FNB_SHOP_CD");
    var menuFlagCd = DS_MASTER.NameValue(masterRow,"MENU_FLAG_CD");
	
    DS_DETAIL.AddRow();
    var row = DS_DETAIL.CountRow;
    /*
    DS_DETAIL.NameValue(row,"STR_CD")       = strCd;
    DS_DETAIL.NameValue(row,"FNB_SHOP_CD")  = fnbShopCd;
    DS_DETAIL.NameValue(row,"MENU_FLAG_CD") = menuFlagCd;
    DS_DETAIL.NameValue(row,"USE_YN")       = "Y";
    DS_DETAIL.NameValue(row,"DEL_YN")       = "Y";
    */
    // DS_DETAIL.NameValue(row,"SORT_NO")       = DS_DETAIL.RowPosition;
    
    
    setFocusGrid(GD_DETAIL, DS_DETAIL, row, "SKU_CD");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_DETAIL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;     
    }
    var ckeckYn = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "DEL_YN");
    if(ckeckYn == "N"){
        showMessage(INFORMATION, OK, "USER-1000", "당일 등록한 건만 삭제 가능합니다.");
        GD_DETAIL.Focus();
        return;
    }

    if(DS_DETAIL.RowStatus(DS_DETAIL.RowPosition) != "1") return;
    DS_DETAIL.DeleteRow(DS_DETAIL.RowPosition);
}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  F&B매장 리스트 조회
 * return값 : void
 */
function searchMaster(){

    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd         = LC_STR_CD.BindColVal;
    var strFnbShopFlag   = LC_FNB_SHOP_FLAG.BindColVal;
    var strFnbShopCd     = EM_FNB_SHOP_CD.Text;
    var strMenuFlagCd    = EM_MENU_FLAG_CD.Text;
    var strMenuFlagName  = EM_MENU_FLAG_NAME.Text;
    var strUseYn         = LC_USE_YN.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="		+encodeURIComponent(strStrCd)
                   + "&strFnbShopFlag=" +encodeURIComponent(strFnbShopFlag)
                   + "&strFnbShopCd="	+encodeURIComponent(strFnbShopCd)
                   + "&strMenuFlagCd="  +encodeURIComponent(strMenuFlagCd)
                   + "&strMenuFlagName="+encodeURIComponent(strMenuFlagName)
                   + "&strUseYn="		+encodeURIComponent(strUseYn);
    TR_SUB.Action="/dps/pcod906.pc?goTo="+goTo+parameters;      
    TR_SUB.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  F&B매장메뉴분류 리스트 조회
 * return값 : void
 */
function searchDetail(){
    DS_DETAIL.ClearData();
    
    var masterRow    = DS_MASTER.RowPosition;
    if( masterRow < 1){
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }
    var strStrCd      = DS_MASTER.NameValue(masterRow,"STR_CD");
    var strFnbShopCd  = DS_MASTER.NameValue(masterRow,"FNB_SHOP_CD");
    var strMenuFlagCd = DS_MASTER.NameValue(masterRow,"MENU_FLAG_CD");

    
    var goTo       = "searchDetail" ;    
    var action     = "O";  
    var parameters = "&strStrCd="	  +encodeURIComponent(strStrCd)
                   + "&strFnbShopCd=" +encodeURIComponent(strFnbShopCd)
                   + "&strMenuFlagCd="+encodeURIComponent(strMenuFlagCd);
    TR_MAIN.Action="/dps/pcod906.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_DETAIL);  

} 
/**
 * getFnbShopCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 매장명을 등록한다.
 * return값 : void
 */
function getFnbShopCode(evnflag){
    var codeObj = EM_FNB_SHOP_CD;
    var nameObj = EM_FNB_SHOP_NAME;
    
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        if( DS_DETAIL.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 매장 을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","매장") != 1 ){
            	codeObj.Text = bfFnbShopCd;
                codeObj.Focus();
                return;
            }
        }
        nameObj.Text = "";
        EM_MENU_FLAG_CD.Text = "";
        EM_MENU_FLAG_NAME.Text = "";
        DS_MASTER.ClearData();
        DS_DETAIL.ClearData();
        return;     
    }

    var bfFnbShopName = nameObj.Text;
    if( evnflag == "POP" ){
        fnbShopPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','',LC_FNB_SHOP_FLAG.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setFnbShopNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1, LC_STR_CD.BindColVal,'','','',LC_FNB_SHOP_FLAG.BindColVal);
    }    
    
    if( DS_DETAIL.IsUpdated && codeObj.Text != bfFnbShopCd ){
        // 변경된 상세내역이 존재합니다. 매장 을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","매장") != 1 ){
            codeObj.Text = bfFnbShopCd;
            nameObj.Text = bfFnbShopName;
            codeObj.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    bfFnbShopCd = codeObj.Text;
}
/**
 * getMenuFlagCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 메뉴분류명을 등록한다.
 * return값 : void
 */
function getMenuFlagCode(evnflag){
    var codeObj = EM_MENU_FLAG_CD;
    var nameObj = EM_MENU_FLAG_NAME;

    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        setTimeout( "LC_STR_CD.Focus();",50);
        codeObj.Text = "";
        return;
    }
    if( LC_FNB_SHOP_FLAG.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "F&B매장구분");
        setTimeout( "LC_FNB_SHOP_FLAG.Focus();",50);
        codeObj.Text = "";
        return;
    }
    if( EM_FNB_SHOP_CD.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "매장");
        setTimeout( "EM_FNB_SHOP_CD.Focus();",50);
        codeObj.Text = "";
        return;
    }
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( evnflag == "POP" ){
        fnbCornerPop(codeObj,nameObj,LC_STR_CD.BindColVal,EM_FNB_SHOP_CD.Text,'',LC_FNB_SHOP_FLAG.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setFnbCornerNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0,LC_STR_CD.BindColVal,EM_FNB_SHOP_CD.Text,'',LC_FNB_SHOP_FLAG.BindColVal);
    }    
}
/**
 * setMenuFlagName()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : F&B매장구분에 따라 명칭변경
 * return값 : void
 */
function setMenuFlagName( flag){
	// F&B매장구분이 매장 일 경우
	if( flag == "1"){
		document.getElementById('TH_MENU_FLAG').innerText = "메뉴분류";
		GD_MASTER.ColumnProp("MENU_FLAG_CD","name") = "메뉴분류코드";
        GD_MASTER.ColumnProp("MENU_FLAG_NAME","name") = "메뉴분류명";
        
    // F&B매장구분이 코너 일 경우
	}else{
        document.getElementById('TH_MENU_FLAG').innerText = "코너";
        GD_MASTER.ColumnProp("MENU_FLAG_CD","name") = "코너코드";
        GD_MASTER.ColumnProp("MENU_FLAG_NAME","name") = "코너명";
	}
}

/**
 * setSkuCodeToGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setSkuCodeToGrid(evnFlag, row){
    var codeStr = DS_DETAIL.NameValue(row,"SKU_CD");
   // var strCd   = DS_DETAIL.NameValue(row,"STR_CD");
    var venCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD");
    var strCd      = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var fnbShopCd  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"FNB_SHOP_CD");
    var menuFlagCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"MENU_FLAG_CD");
    
    if( codeStr == "" && evnFlag != 'POP'){
    	DS_DETAIL.NameValue(row,"SKU_NAME")  = "";
    	DS_DETAIL.NameValue(row,"RECP_NAME") = "";
        return;
    }
    
    var rtnMap = null;
    if( evnFlag == "POP" ){
   		rtnMap = strSkuMultiSelPop(codeStr
   								, ""
   								, "Y"
   								, ""
                				, strCd
                				, ""
                				, "4"
                				, ""
                				, ""
                				, ""
                				, ""
                				, venCd
                				, ""
                				, ""
                				, ""
                				, ""
                				, "");
   		
   	}else if( evnFlag == "NAME" ){
    	DS_DETAIL.NameValue(row,"SKU_NAME") = "";
        
        rtnMap = setStrSkuNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' ,'Y', 1, '', strCd, '', '4', '', 'Y', '', '', '','','','','',venCd);
    }
    
   
	
    if( rtnMap != null){
   		if( evnFlag == "NAME"){
            
   		 
   		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"STR_CD")       = strCd;
   		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"FNB_SHOP_CD")  = fnbShopCd;
   		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"MENU_FLAG_CD") = menuFlagCd;
   		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"USE_YN")       = "Y";
   		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"DEL_YN")       = "Y";
   		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SORT_NO")     = DS_DETAIL.RowPosition;
   		    
            DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD")    = rtnMap.get("SKU_CD");
    	    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_NAME")  = rtnMap.get("SKU_NAME");
    	    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"RECP_NAME") = rtnMap.get("RECP_NAME");
    	    
            return;
   	 	}else{
   	 		var j = 1;
   	 		for(var i = 0; i < rtnMap.length; i++){
               		
				DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SKU_CD")      = rtnMap[i].SKU_CD;
                DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SKU_NAME")    = rtnMap[i].SKU_NAME;
                DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "RECP_NAME")   = rtnMap[i].RECP_NAME;
                
                
                DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"STR_CD")       = strCd;
       		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"FNB_SHOP_CD")  = fnbShopCd;
       		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"MENU_FLAG_CD") = menuFlagCd;
       		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"USE_YN")       = "Y";
       		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"DEL_YN")       = "Y";
       		    DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SORT_NO")     = DS_DETAIL.RowPosition;
                
                if(j < rtnMap.length) {
                	DS_DETAIL.AddRow();
                	j++;
                }
                
                	
            }
            return;
   	 	}
    }
    
}
/**
 * checkValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkValidation(){
    var row;
    var colid;
    var errYn = false;

    var dupRow = checkDupKey(DS_DETAIL,"SKU_CD");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_DETAIL,DS_DETAIL,dupRow,"SKU_CD");
        return false;
    }
    
    for(var i=1; i<=DS_DETAIL.CountRow; i++){
        var rowStatus = DS_DETAIL.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        if( DS_MASTER.NameValue(DS_MASTER.RowPosition,"USE_YN")=="N"){
            showMessage(INFORMATION, OK, "USER-1000", "사용할 수 없는 메뉴분류(코너)입니다.");
            GD_MASTER.Focus();
            return;     
        }
        row = i;
        if( DS_DETAIL.NameValue(i,"SKU_CD")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_DETAIL.NameValue(i,"SKU_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");
            colid = "SKU_CD";    
            errYn = true;
            break;
        }
        if( DS_DETAIL.NameValue(i,"RECP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "영수증명");
            colid = "RECP_NAME";    
            errYn = true;
            break;
        }

        if( !checkInputByte( GD_DETAIL, DS_DETAIL, i, "RECP_NAME", "영수증명") ){
            return false;
        }
        

        if( DS_DETAIL.NameValue(i,"SORT_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "정렬순서");
            errYn = true;
            colid = "SORT_NO";
            break;
        }
        if( DS_DETAIL.NameValue(i,"USE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
            errYn = true;
            colid = "USE_YN";
            break;
        }
    }
    
    if(errYn){
        setFocusGrid(GD_DETAIL,DS_DETAIL,row,colid);
        return false;
    }
    return true;
}

/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_fnbmenu_emg(){
	
	 	var strFnbShopCd = DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"FNB_SHOP_CD");
		var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));

        if( strFnbShopCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","매장코드가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  	  + encodeURIComponent(strProcDt)
	    					  + "&strFnbShopCd="  + encodeURIComponent(strFnbShopCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod906.pc?goTo=sendfnbmenuemg"+parameters;
	    	TR_MAIN.KeyValue = "SERVLET(O:DS_DETAIL=DS_DETAIL)";
	    	//searchSetWait("B"); // 프로그래스바
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
<!-- 
<script language=JavaScript for=DS_DETAIL event=OnDataError(row,colid)>
    var errorCode = DS_DETAIL.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_DETAIL.ErrorMsg);       
    }
</script>
 -->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;

    if(DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1)
            return false;
        DS_DETAIL.ClearData();
    }
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfMasterRow == row)
        return;
    bfMasterRow = row;
    searchDetail();
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<script language=JavaScript for=GD_DETAIL event=OnListSelect(index,row,colid)>
    if( row < 1)
        return;
    if(colid="USE_YN"){
        if(DS_DETAIL.NameValue(row,colid)=="Y"){
            if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"USE_YN") == "N"){
                showMessage(INFORMATION, OK, "USER-1000", "메뉴분류(코너)의 사용여부가 'NO'입니다.");
                DS_DETAIL.NameValue(row,colid) = "N";
            }
        }
    }
</script> 
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_DETAIL.NameValue(row,colid);
    if( oldData == value )
        return;
    switch(colid){
        case 'SKU_CD':  
        	setSkuCodeToGrid('NAME',row);
            break;
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        case 'SKU_CD':  
        	setSkuCodeToGrid('POP',row);
            break;
    }
    isOnPopup = false;
</script>
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd == this.BindColVal)
        return;
    
    if( DS_DETAIL.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
            setComboData(LC_STR_CD,bfStrCd);
            GD_DETAIL.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    EM_FNB_SHOP_CD.Text    = "";
    EM_FNB_SHOP_NAME.Text  = "";
    EM_MENU_FLAG_CD.Text   = "";
    EM_MENU_FLAG_NAME.Text = "";
    
    bfStrCd = this.BindColVal;
</script>
<!-- F&B매장구분 (조회) -->
<script language=JavaScript for=LC_FNB_SHOP_FLAG event=OnSelChange()>
    //
    if( bfFnbShopFlag == this.BindColVal)
        return;
    
    if( DS_DETAIL.IsUpdated ){
        // 변경된 상세내역이 존재합니다. F&B매장구분 을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","F&B매장구분") != 1 ){
            setComboData(LC_FNB_SHOP_FLAG,bfFnbShopFlag);
            GD_DETAIL.Focus();
            return;
        }
    }
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    EM_FNB_SHOP_CD.Text    = "";
    EM_FNB_SHOP_NAME.Text  = "";
    EM_MENU_FLAG_CD.Text   = "";
    EM_MENU_FLAG_NAME.Text = "";
        
    bfFnbShopFlag = LC_FNB_SHOP_FLAG.BindColVal;
    setMenuFlagName(LC_FNB_SHOP_FLAG.BindColVal);
    
</script>

<!-- 매장(조회) -->
<script language=JavaScript for=EM_FNB_SHOP_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getFnbShopCode('NAME');
</script>
<!-- 메뉴분류(코너)(조회) -->
<script language=JavaScript for=EM_MENU_FLAG_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getMenuFlagCode('NAME');
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FNB_SHOP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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
}
</script>

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
            <th width="80" class="point">점</th>
            <td width="160">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle">
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">F&B매장구분</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_FNB_SHOP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">매장</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_CD classid=<%=Util.CLSID_EMEDIT%>  width=40  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getFnbShopCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=130  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th id=TH_MENU_FLAG >메뉴분류(코너)</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MENU_FLAG_CD classid=<%=Util.CLSID_EMEDIT%>  width=30 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getMenuFlagCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MENU_FLAG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >사용여부</th>
            <td colspan="3">
               <comment id="_NSID_">
                 <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                 </object>
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
        <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=479 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                
                <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              	<tr>
                <td class="right PB03"><img 
                 src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img 
                 src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();"  /></td>
                 
                    <td width="120">
            		<table width="100%" >
                    <td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_fnbmenu_emg()">긴급F&B메뉴전송</a></td>
						    <td class="btn_r"></td>
						  </tr>
						</table>                
	                </td>		
					</table>				
		            </td>
                
                </td> 
                </tr></table></td></tr>
                 
                 
              </tr>
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_DETAIL width=100% height=459 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_DETAIL">
                        </object>
                      </comment>
                      <script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
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

</body>
</html>

