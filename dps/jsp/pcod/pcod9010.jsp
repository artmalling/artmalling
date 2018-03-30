<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > F&B매장정보> F&B매장관리
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod9010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : F&B 매장정보를 관리한다.
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
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var isOnPopup = false; // 그리드 팝업 실행여부
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

    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_VEN_CD       , "CODE^6^0", NORMAL);  //협력사코드
    initEmEdit(EM_VEN_NAME     , "GEN^40"  , NORMAL);  //협력사명
    initEmEdit(EM_FNB_SHOP_CD  , "CODE^4^0", NORMAL);  //매장코드
    initEmEdit(EM_FNB_SHOP_NAME, "GEN^40"  , NORMAL);  //매장명
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    initComboStyle(LC_USE_YN,DS_O_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_USE_YN"        , "D", "D022", "Y");
    
    getEtcCode("DS_FNB_SHOP_FLAG"   , "D", "P078", "N");
    getEtcCode("DS_CHNAL_FLAG"      , "D", "P056", "N");
    getEtcCode("DS_FNB_FLAG"        , "D", "P077", "N");
    getEtcCode("DS_FNB_BIZ_KIND_CD" , "D", "P079", "N");
    
    // 점코드 조회
    getStore("DS_O_STR_CD"  , "Y", "", "N");
    getStore("DS_I_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_USE_YN, 'Y');
    
    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod901","DS_MASTER" );
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center edit=none     name="NO"           </FC>'
                     + '<FC>id=STR_CD          width=80   align=left                 name="*점   "          EditStyle=Lookup data="DS_I_STR_CD:CODE:NAME" edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=FNB_SHOP_CD     width=60   align=center edit=none     name="*매장코드"      </FC>'
                     + '<FC>id=FNB_SHOP_NAME   width=120  align=left                 name="*매장명 "        </FC>'
                     + '<FC>id=FNB_SHOP_FLAG   width=90   align=left                 name="*매장구분"      EditStyle=Lookup data="DS_FNB_SHOP_FLAG:CODE:NAME" edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=VEN_CD          width=80   align=center edit=Numeric  name="*협력사코드 "    EditStyle=Popup edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=VEN_NAME        width=150  align=left   edit=none     name="협력사명 "      </FC>'
                     + '<FC>id=CHNAL_FLAG      width=90   align=left                 name="*채널구분 "      EditStyle=Lookup data="DS_CHNAL_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=FNB_FLAG        width=90   align=left                 name="*F&&B구분 "      EditStyle=Lookup data="DS_FNB_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=FNB_BIZ_KIND_CD width=90   align=left                 name="*F&&B업종 "      EditStyle=Lookup data="DS_FNB_BIZ_KIND_CD:CODE:NAME"</FC>'
                     + '<FC>id=REP_SHOP_CD     width=90   align=center               name="대표매장코드 "  EditStyle=Popup </FC>'
                     + '<FC>id=REP_SHOP_NAME   width=120  align=left   edit=none     name="대표매장명 "    </FC>'
                     + '<FC>id=USE_YN          width=70   align=left                 name="*사용여부 "      EditStyle=Combo  data="Y:YES,N:NO"</FC>';

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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//
    if( DS_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    
    DS_MASTER.ClearData();

    var strStrCd       = LC_STR_CD.BindColVal;
    var strVenCd       = EM_VEN_CD.Text;
    var strVenName     = EM_VEN_NAME.Text;
    var strFnbShopCd   = EM_FNB_SHOP_CD.Text;
    var strFnbShopName = EM_FNB_SHOP_NAME.Text;
    var strUseYn       = LC_USE_YN.BindColVal;

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="		 +encodeURIComponent(strStrCd)
                   + "&strVenCd="		 +encodeURIComponent(strVenCd)
                   + "&strVenName="  	 +encodeURIComponent(strVenName)
                   + "&strFnbShopCd="	 +encodeURIComponent(strFnbShopCd)
                   + "&strFnbShopName="	 +encodeURIComponent(strFnbShopName)
                   + "&strUseYn="		 +encodeURIComponent(strUseYn);
    TR_MAIN.Action="/dps/pcod901.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
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
    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    TR_MAIN.Action="/dps/pcod901.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
    GD_MASTER.Focus();


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
//

/**
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 추가
 * return값 : void
 */
function btn_addRow(){
    DS_MASTER.AddRow();
    DS_MASTER.NameValue(DS_MASTER.CountRow,"STR_CD")        = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(DS_MASTER.CountRow,"FNB_SHOP_FLAG") = "1";
    DS_MASTER.NameValue(DS_MASTER.CountRow,"USE_YN")        = "Y";
    DS_MASTER.NameValue(DS_MASTER.CountRow,"DEL_YN")        = "Y";
    
    setFocusGrid(GD_MASTER, DS_MASTER, DS_MASTER.CountRow, "STR_CD");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
    var ckeckYn = DS_MASTER.NameValue(DS_MASTER.RowPosition, "DEL_YN");
    if(ckeckYn == "N"){
        showMessage(INFORMATION, OK, "USER-1000", "당일 등록한 건만 삭제 가능합니다.");
        GD_MASTER.Focus();
        return;
    }
    if(DS_MASTER.NameValue(DS_MASTER.RowPosition, "DTL_CNT") > 0){
        showMessage(INFORMATION, OK, "USER-1046");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
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
    	fnbShopPop(codeObj,nameObj,LC_STR_CD.BindColVal,EM_VEN_CD.Text);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setFnbShopNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, LC_STR_CD.BindColVal,EM_VEN_CD.Text);
    }    
}

/**
 * setVenCodeToGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setVenCodeToGrid(evnFlag, row){
    var codeStr = DS_MASTER.NameValue(row,"VEN_CD");
    var strCd   = DS_MASTER.NameValue(row,"STR_CD");
    if( strCd == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'STR_CD');",50);
        return ;
    }
    if( codeStr == "" && evnFlag != 'POP'){
    	DS_MASTER.NameValue(row,"VEN_NAME") = "";
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
        rtnMap = venToGridPop(codeStr,'',strCd,'Y');
    }else{
        DS_MASTER.NameValue(row,"VEN_NAME") = "";
        rtnMap = setVenNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' , 1,strCd,'Y');
    }
    
    if( rtnMap == null){
        if( DS_MASTER.NameValue(row,"VEN_NAME") == ""){
            DS_MASTER.NameValue(row,"VEN_CD") = "";
        }       
        return;
    }
    
    DS_MASTER.NameValue(row,"VEN_CD")    = rtnMap.get("VEN_CD");
    DS_MASTER.NameValue(row,"VEN_NAME")  = rtnMap.get("VEN_NAME");
    
}
 /**
  * setRepFnbShopCodeToGrid()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-04-04
  * 개    요 : 대표매장 팝업을 실행한다.(그리드)
  * return값 : void
 **/
 function setRepFnbShopCodeToGrid(evnFlag, row){
     var codeStr = DS_MASTER.NameValue(row,"REP_SHOP_CD");
     var strCd   = DS_MASTER.NameValue(row,"STR_CD");
     var venCd   = DS_MASTER.NameValue(row,"VEN_CD");
     if( strCd == ""){
         showMessage(EXCLAMATION, OK, "USER-1002", "점");
         setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'STR_CD');",50);
         return ;
     }
     if( codeStr == "" && evnFlag != 'POP'){
         DS_MASTER.NameValue(row,"REP_SHOP_NAME") = "";
         return;
     }
     var rtnMap;
     if( evnFlag == 'POP'){
         rtnMap = fnbShopToGridPop(codeStr,'',strCd, '','Y','Y');
     }else{
         DS_MASTER.NameValue(row,"REP_SHOP_NAME") = "";
         rtnMap = setFnbShopNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' , 1,strCd, '','Y','Y');
     }
     
     if( rtnMap == null){
         if( DS_MASTER.NameValue(row,"REP_SHOP_NAME") == ""){
             DS_MASTER.NameValue(row,"REP_SHOP_CD") = "";
         }       
         return;
     }
     
     DS_MASTER.NameValue(row,"REP_SHOP_CD")    = rtnMap.get("FNB_SHOP_CD");
     DS_MASTER.NameValue(row,"REP_SHOP_NAME")  = rtnMap.get("FNB_SHOP_NAME");
     
 }
/**
 * checkMasterValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력값을 체크한다.
 * return값 : void
**/
function checkMasterValidation(){
    var row;
    var colid;
    var isCheck = false;
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" ||rowStatus == "3"))
            continue;
        row = i;
        if( DS_MASTER.NameValue(row,"STR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            colid = "STR_CD";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"FNB_SHOP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "매장명");
            colid = "FNB_SHOP_NAME";
            isCheck = true;
            break;
        }
        if( !checkInputByte( GD_MASTER, DS_MASTER, row, "FNB_SHOP_NAME", "매장명")){
            colid = "FNB_SHOP_NAME";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"FNB_SHOP_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "매장구분");
            colid = "FNB_SHOP_FLAG";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"VEN_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "협력사");
            colid = "VEN_CD";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"VEN_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "협력사");
            colid = "VEN_CD";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"CHNAL_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "채널구분");
            colid = "CHNAL_FLAG";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"FNB_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "F&B구분");
            colid = "FNB_FLAG";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"FNB_BIZ_KIND_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "F&B업종");
            colid = "FNB_BIZ_KIND_CD";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"REP_SHOP_CD")!="" && DS_MASTER.NameValue(row,"REP_SHOP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "대표매장코드");
            colid = "REP_SHOP_CD";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"USE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
            colid = "USE_YN";
            isCheck = true;
            break;
        }
    }

    if(isCheck){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
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
function btn_send_fnbshop_emg(){
	
	 	var strFnbShopCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"FNB_SHOP_CD");
		var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));

        if( strFnbShopCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","매장코드가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt=" 	  + encodeURIComponent(strProcDt)
	    					  + "&strFnbShopCd="  + encodeURIComponent(strFnbShopCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod901.pc?goTo=sendfnbshopemg"+parameters;
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_MASTER.NameValue(row,colid);
    if( oldData == value )
        return;
    switch(colid){
        case 'VEN_CD':  
            setVenCodeToGrid('NAME',row);
            break;
        case 'REP_SHOP_CD':  
        	setRepFnbShopCodeToGrid('NAME',row);
            break;
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        case 'VEN_CD':  
            setVenCodeToGrid('POP',row);
            break;
        case 'REP_SHOP_CD':
        	setRepFnbShopCodeToGrid('POP',row);
            break;
    }
    isOnPopup = false;
</script> 
 
<script language=JavaScript for=GD_MASTER event=OnListSelect(index,row,colid)>
    if(row<1)
        return;
    if(colid="USE_YN"){
    	if(DS_MASTER.NameValue(row,colid)=="N"){
    		if(DS_MASTER.NameValue(row,"DTL_CNT") > 0){
                if(showMessage(QUESTION, YESNO, "USER-1000", "사용여부를 'NO'로 변경 시<br>상세 데이터도 'NO'로 변경됩니다.<br>변경하시겠습니까?")!=1){
                	DS_MASTER.NameValue(row,colid) = "Y";
                }
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
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_STR_CD"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FNB_SHOP_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHNAL_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FNB_FLAG"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FNB_BIZ_KIND_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="80" class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">협력사</th>
            <td width="180">
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">매장</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getFnbShopCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >사용여부</th>
            <td colspan="5">
               <comment id="_NSID_">
                 <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
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
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="right PB03"><img 
               src="/<%=dir%>/imgs/btn/add_row.gif"  onclick="javascript:btn_addRow();" hspace="2" /><img 
               src="/<%=dir%>/imgs/btn/del_row.gif"  onclick="javascript:btn_delRow();" />
               
         			<td width="120">
            		<table width="100%" >
                    <td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_fnbshop_emg()">긴급F&B매장전송</a></td>
						    <td class="btn_r"></td>
						  </tr>
						</table>                
	                </td>		
					</table>				
		            </td>
		            
               </td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=457 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment><script>_ws_(_NSID_);</script>
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

</body>
</html>

