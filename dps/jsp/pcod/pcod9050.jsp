<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > F&B매장정보> F&B 메뉴분류관리 
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod9050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : F&B 메뉴분류정보를 관리한다.
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
var bfMasterRow = 0;
var btnSaveYn = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세

    // EMedit에 초기화
    initEmEdit(EM_VEN_CD       , "CODE^6^0", NORMAL);  //협력사코드
    initEmEdit(EM_VEN_NAME     , "GEN^40"  , NORMAL);  //협력사명
    initEmEdit(EM_FNB_SHOP_CD  , "CODE^4^0", NORMAL);  //매장코드
    initEmEdit(EM_FNB_SHOP_NAME, "GEN^40"  , NORMAL);  //매장명

    initEmEdit(EM_STR_NAME_B       , "GEN^40"  , READ);    //점
    initEmEdit(EM_FNB_SHOP_CD_B    , "GEN^40"  , READ);    //매장
    initEmEdit(EM_FNB_SHOP_NAME_B  , "GEN^40"  , READ);    //매장
    initEmEdit(EM_VEN_CD_B         , "GEN^40"  , READ);    //협력사
    initEmEdit(EM_VEN_NAME_B       , "GEN^40"  , READ);    //협력사
    initEmEdit(EM_USE_YN_B         , "GEN^40"  , READ);    //사용여부
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    initComboStyle(LC_USE_YN,DS_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_USE_YN"        , "D", "D022", "Y");
    
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_USE_YN, 'Y');
    
    // 삭제된 로우 표시여부
    //DS_DETAIL.ViewDeletedRow = true;

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod905","DS_MASTER,DS_DETAIL" );
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      width=25   align=center name="NO"      </FC>'
                     + '<FC>id=FNB_SHOP_CD   width=75   align=center name="매장코드" </FC>'
                     + '<FC>id=FNB_SHOP_NAME width=85   align=left   name="매장명"   </FC>'
                     + '<FC>id=USE_YN        width=75   align=center name="사용여부 " </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center  name="NO"               </FC>'
                     + '<FC>id=MENU_FLAG_CD    width=90   align=center  name="*메뉴분류코드"     edit=alphaNum </FC>'
                     + '<FC>id=MENU_FLAG_NAME  width=115  align=left    name="*메뉴분류명"       </FC>'
                     + '<FC>id=ORD_PRT         width=110  align=left    name="*주문서출력프린터" </FC>'
                     + '<FC>id=SORT_NO         width=65   align=right   name="정렬순서"         </FC>'
                     + '<FC>id=USE_YN          width=65   align=left    name="*사용여부"        EditStyle=Combo data="Y:YES,N:NO" </FC>';

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
    
    TR_MAIN.Action="/dps/pcod905.pc?goTo=save";  
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
	if( masterRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "매장 선택 후 행추가가 가능합니다.");
        if(DS_MASTER.CountRow < 1){
        	LC_STR_CD.Focus();
        }else{
        	GD_MASTER.Focus();
        }
		return;
	}
	if( DS_MASTER.NameValue(masterRow,"USE_YN")=="N"){
        showMessage(INFORMATION, OK, "USER-1000", "사용할 수 없는 매장입니다.");
        GD_MASTER.Focus();
        return;		
	}
	var strCd     = DS_MASTER.NameValue(masterRow,"STR_CD");
    var fnbShopCd = DS_MASTER.NameValue(masterRow,"FNB_SHOP_CD");
    DS_DETAIL.AddRow();
    var row = DS_DETAIL.CountRow;
    DS_DETAIL.NameValue(row,"STR_CD")      = strCd;
    DS_DETAIL.NameValue(row,"FNB_SHOP_CD") = fnbShopCd;
    DS_DETAIL.NameValue(row,"USE_YN")      = "Y";
    DS_DETAIL.NameValue(row,"DEL_YN")      = "Y";
    
    setFocusGrid(GD_DETAIL, DS_DETAIL, row, "MENU_FLAG_CD");
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
    if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "DTL_CNT") > 0){
        showMessage(INFORMATION, OK, "USER-1046");
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
    
    var strStrCd       = LC_STR_CD.BindColVal;
    var strFnbShopCd   = EM_FNB_SHOP_CD.Text;
    var strFnbShopName = EM_FNB_SHOP_NAME.Text;
    var strVenCd       = EM_VEN_CD.Text;
    var strVenName     = EM_VEN_NAME.Text;
    var strUseYn       = LC_USE_YN.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="		+encodeURIComponent(strStrCd)
                   + "&strFnbShopCd="	+encodeURIComponent(strFnbShopCd)
                   + "&strFnbShopName=" +encodeURIComponent(strFnbShopName)
                   + "&strVenCd="		+encodeURIComponent(strVenCd)
                   + "&strVenName="		+encodeURIComponent(strVenName)
                   + "&strUseYn="		+encodeURIComponent(strUseYn);
    TR_SUB.Action="/dps/pcod905.pc?goTo="+goTo+parameters;      
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
    var strStrCd     = DS_MASTER.NameValue(masterRow,"STR_CD");
    var strFnbShopCd = DS_MASTER.NameValue(masterRow,"FNB_SHOP_CD");

    
    var goTo       = "searchDetail" ;    
    var action     = "O";  
    var parameters = "&strStrCd="	 +encodeURIComponent(strStrCd)
                   + "&strFnbShopCd="+encodeURIComponent(strFnbShopCd);
    TR_MAIN.Action="/dps/pcod905.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_DETAIL);  

} 
/**
 * getVenCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사명을 등록한다.
 * return값 : void
 */
function getVenCode(evnflag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        venPop(codeObj,nameObj,LC_STR_CD.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, LC_STR_CD.BindColVal);
    }    
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
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        fnbShopPop(codeObj,nameObj,LC_STR_CD.BindColVal,EM_VEN_CD.Text,'','','1');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setFnbShopNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, LC_STR_CD.BindColVal,EM_VEN_CD.Text,'','','1');
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

    var dupRow = checkDupKey(DS_DETAIL,"MENU_FLAG_CD");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_DETAIL,DS_DETAIL,dupRow,"MENU_FLAG_CD");
        return false;
    }
    
    for(var i=1; i<=DS_DETAIL.CountRow; i++){
        var rowStatus = DS_DETAIL.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;

        if( DS_MASTER.NameValue(DS_MASTER.RowPosition,"USE_YN")=="N"){
            showMessage(INFORMATION, OK, "USER-1000", "사용할 수 없는 매장입니다.");
            GD_MASTER.Focus();
            return;     
        }
        row = i;
        if( DS_DETAIL.NameValue(i,"MENU_FLAG_CD")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1003", "메뉴분류코드");
            errYn = true;
            colid = "MENU_FLAG_CD";
            break;
        }
        var cdLen = replaceStr(DS_DETAIL.NameValue(i,"MENU_FLAG_CD")," ","").length;
        if( cdLen !=2){
            showMessage(EXCLAMATION, OK, "USER-1027", "메뉴분류코드", 2);
            errYn = true;
            colid = "MENU_FLAG_CD";
            break;
        }
        if( DS_DETAIL.NameValue(i,"MENU_FLAG_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "메뉴분류명");
            colid = "MENU_FLAG_NAME";    
            errYn = true;
            break;
        }

        if( !checkInputByte( GD_DETAIL, DS_DETAIL, i, "MENU_FLAG_NAME", "메뉴분류명") ){
            return false;
        }
        
        if( DS_DETAIL.NameValue(i,"ORD_PRT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "주문서출력프린터");
            errYn = true;
            colid = "ORD_PRT";
            break;
        }
        if( !checkInputByte( GD_DETAIL, DS_DETAIL, i, "ORD_PRT", "주문서출력프린터") ){
            return false;
        }
        /*
        if( DS_DETAIL.NameValue(i,"SORT_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "정렬순서");
            errYn = true;
            colid = "SORT_NO";
            break;
        }
        */
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
function btn_send_fnbmenukind_emg(){
	
	 	var strFnbShopCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"FNB_SHOP_CD");
		var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));

        if( strFnbShopCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","매장코드가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  	  + encodeURIComponent(strProcDt)
	    					  + "&strFnbShopCd="  + encodeURIComponent(strFnbShopCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod905.pc?goTo=sendfnbmenukindemg"+parameters;
	    	TR_MAIN.KeyValue = "SERVLET(O:DS_MASTER=DS_MASTER)";
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
<script language=JavaScript for=DS_DETAIL event=OnDataError(row,colid)>
    var errorCode = DS_DETAIL.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "메뉴분류코드");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_DETAIL.ErrorMsg);       
    }
</script>
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

<script language=JavaScript for=GD_DETAIL event=OnListSelect(index,row,colid)>
    if( row < 1)
        return;
    if(colid="USE_YN"){
        if(DS_DETAIL.NameValue(row,colid)=="N"){
            if(DS_DETAIL.NameValue(row,"DTL_CNT") > 0){
                if(showMessage(QUESTION, YESNO, "USER-1000", "사용여부를 'NO'로 변경 시<br>상세 데이터도 'NO'로 변경됩니다.<br>변경하시겠습니까?")!=1){
                	DS_DETAIL.NameValue(row,colid) = "Y";
                }
            }
        }else{
            if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"USE_YN") == "N"){
                showMessage(INFORMATION, OK, "USER-1000", "매장의 사용여부가 'NO'입니다.");
                DS_DETAIL.NameValue(row,colid) = "N";
            }
        }
    }
</script> 
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME');
</script>
<!-- 매장(조회) -->
<script language=JavaScript for=EM_FNB_SHOP_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getFnbShopCode('NAME');
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
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">매장</th>
            <td width="180">
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getFnbShopCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">협력사</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="80">사용여부</th>
            <td colspan="5">
               <comment id="_NSID_">
                 <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle">
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
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="50" >점</th>
                    <td width="120">
                      <comment id="_NSID_">
                        <object id=EM_STR_NAME_B classid=<%=Util.CLSID_EMEDIT%>  width=120  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th width="50" >매장</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_FNB_SHOP_CD_B classid=<%=Util.CLSID_EMEDIT%>  width=60  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_FNB_SHOP_NAME_B classid=<%=Util.CLSID_EMEDIT%>  width=170  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >사용여부</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_USE_YN_B classid=<%= Util.CLSID_EMEDIT %> width=120 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >협력사</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_VEN_CD_B classid=<%=Util.CLSID_EMEDIT%>  width=60  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_VEN_NAME_B classid=<%=Util.CLSID_EMEDIT%>  width=170  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              
                <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              	<tr>
                 <td class="right PB03"><img 
                 src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW onClick="javascript:btn_addRow();" hspace="2" /><img 
                 src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW onClick="javascript:btn_delRow();"  />
                    
                    <td width="140">
            		<table width="100%" >
                    <td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_fnbmenukind_emg()">긴급F&B메뉴분류전송</a></td>
						    <td class="btn_r"></td>
						  </tr>
						</table>                
	                </td>		
					</table>				
		            </td>
                
                </td> 
                </tr></table></td></tr>
                 </td>
               </tr>
              
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_DETAIL width=100% height=403 classid=<%=Util.CLSID_GRID%>>
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

<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
        <param name=DataID          value=DS_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>col=STR_NAME        ctrl=EM_STR_NAME_B      param=Text </c>
            <c>col=FNB_SHOP_CD     ctrl=EM_FNB_SHOP_CD_B   param=Text </c>
            <c>col=FNB_SHOP_NAME   ctrl=EM_FNB_SHOP_NAME_B param=Text </c>
            <c>col=VEN_CD          ctrl=EM_VEN_CD_B        param=Text </c>
            <c>col=VEN_NAME        ctrl=EM_VEN_NAME_B      param=Text </c>
            <c>col=USE_YN          ctrl=EM_USE_YN_B        param=Text </c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

