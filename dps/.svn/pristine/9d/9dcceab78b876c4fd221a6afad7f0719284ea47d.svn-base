<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > F&B매장정보> F&B 코너관리
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod9030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : F&B 코너정보를 관리한다.
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
var bfFnbShopCd;
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
    initEmEdit(EM_MENU_FLAG_CD  , "CODE^2"  , NORMAL);  //코너코드
    initEmEdit(EM_MENU_FLAG_NAME, "GEN^20"  , NORMAL);  //코너명
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD     , DS_STR_CD     , "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    initComboStyle(LC_FNB_SHOP_CD, DS_FNB_SHOP_CD, "CODE^0^30,NAME^0^130", 1, PK);      //매장(조회)
    initComboStyle(LC_USE_YN     , DS_USE_YN     , "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_USE_YN"        , "D", "D022", "Y");
    
    // 점코드 조회
    getStore("DS_STR_CD"    , "Y", "", "N");
    getStore("DS_I_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    bfStrCd = LC_STR_CD.BindColVal;

    // F&B매장중 코너매장 조회 (popup_dps.js)
    getFnBShopCornerCode("DS_FNB_SHOP_CD"  , LC_STR_CD.BindColVal, "Y" );
    //getFnBShopCornerCode("DS_I_FNB_SHOP_CD", '', "N", "Y" );

	
    // 필터 적용여부
    DS_I_FNB_SHOP_CD.UseFilter = true;
    
    //매장 콤보데이터 기본값 설정( 첫번째선택 )
    bfFnbShopCd = LC_FNB_SHOP_CD.BindColVal;
    
    setComboData(LC_FNB_SHOP_CD, '%');
    setComboData(LC_USE_YN, 'Y');
    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod903","DS_MASTER" );
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center  name="NO"              </FC>'
                     + '<FC>id=STR_CD          width=90   align=left    name="*점"              EditStyle=Lookup  data="DS_I_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=FNB_SHOP_CD     width=90   align=left    name="*매장"            EditStyle=Lookup  data="DS_I_FNB_SHOP_CD:CODE:NAME"</FC>'
                     + '<FC>id=MENU_FLAG_CD    width=75   align=center  name="*코너코드"        edit=alphaNum </FC>'
                     + '<FC>id=MENU_FLAG_NAME  width=200  align=left    name="*코너명"          </FC>'
                     + '<FC>id=ORD_PRT         width=130  align=left    name="*주문서출력프린터" </FC>'
                     + '<FC>id=SORT_NO         width=75   align=right   name="정렬순서"         </FC>'
                     + '<FC>id=USE_YN          width=90   align=left    name="*사용여부"        EditStyle=Combo data="Y:YES,N:NO" </FC>';

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
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    
    if( LC_FNB_SHOP_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "매장");
        LC_FNB_SHOP_CD.Focus();
        return;
    }
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
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
    if (!DS_MASTER.IsUpdated ){
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
    
    TR_MAIN.Action="/dps/pcod903.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
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
/**
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행추가
 * return값 : void
 */
function btn_addRow(){

    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    DS_MASTER.AddRow();
    var row = DS_MASTER.CountRow;
    DS_MASTER.NameValue(row,"STR_CD")     = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"FNB_SHOP_CD")= LC_FNB_SHOP_CD.BindColVal;
    DS_MASTER.NameValue(row,"DEL_YN")     = "Y";    
    DS_MASTER.NameValue(row,"USE_YN")     = "Y";    
    DS_I_FNB_SHOP_CD.Filter();
    
    setFocusGrid(GD_MASTER, DS_MASTER, row, "MENU_FLAG_CD");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
    var row  = DS_MASTER.RowPosition;
    if( DS_MASTER.NameValue(row,"DEL_YN") != "Y" ){
        showMessage(INFORMATION, OK, "USER-1000", "당일 등록 건만 삭제 가능 합니다.");
        GD_MASTER.Focus();
        return;
    }
    if(DS_MASTER.NameValue(row, "DTL_CNT") > 0){
        showMessage(INFORMATION, OK, "USER-1046");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(row);
}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  F&B코너 리스트 조회
 * return값 : void
 */
function searchMaster(){

    var strCd        = LC_STR_CD.BindColVal;
    var fnbShopCd    = LC_FNB_SHOP_CD.BindColVal;
    var menuFlagCd   = EM_MENU_FLAG_CD.Text;
    var menuFlagName = EM_MENU_FLAG_NAME.Text;
    var useYn        = LC_USE_YN.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="	 	 +encodeURIComponent(strCd)
                   + "&strFnbShopCd="	 +encodeURIComponent(fnbShopCd)
                   + "&strMenuFlagCd="	 +encodeURIComponent(menuFlagCd)
                   + "&strMenuFlagName=" +encodeURIComponent(menuFlagName)
                   + "&strUseYn="+useYn;
    TR_MAIN.Action="/dps/pcod903.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * getMenuFlagCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 코너명을 등록한다.
 * return값 : void
 */
function getMenuFlagCode(evnflag){
    var codeObj = EM_MENU_FLAG_CD;
    var nameObj = EM_MENU_FLAG_NAME;
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( LC_FNB_SHOP_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "매장");
        LC_FNB_SHOP_CD.Focus();
        return;
    }
    if( evnflag == "POP" ){
    	fnbCornerPop(codeObj,nameObj,LC_STR_CD.BindColVal,LC_FNB_SHOP_CD.BindColVal,'','2');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setFnbCornerNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0,LC_STR_CD.BindColVal,LC_FNB_SHOP_CD.BindColVal,'','2');
    }    
}
/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
    var row;
    var colid;
    var errYn = false;

    var dupRow = checkDupKey(DS_MASTER,"STR_CD||FNB_SHOP_CD||MENU_FLAG_CD");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_MASTER,DS_MASTER,dupRow,"MENU_FLAG_CD");
        return false;
    }
    
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"STR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            errYn = true;
            colid = "STR_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"FNB_SHOP_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "매장");
            errYn = true;
            colid = "FNB_SHOP_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"MENU_FLAG_CD")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1003", "코너코드");
            errYn = true;
            colid = "MENU_FLAG_CD";
            break;
        }
        var cdLen = replaceStr(DS_MASTER.NameValue(i,"MENU_FLAG_CD")," ","").length;
        if( cdLen !=2){
            showMessage(EXCLAMATION, OK, "USER-1027", "코너코드", 2);
            errYn = true;
            colid = "MENU_FLAG_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"MENU_FLAG_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "코너명");
            colid = "MENU_FLAG_NAME";    
            errYn = true;
            break;
        }

        if( !checkInputByte( GD_MASTER, DS_MASTER, i, "MENU_FLAG_NAME", "코너명") ){
            return false;
        }
        
        if( DS_MASTER.NameValue(i,"ORD_PRT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "주문서출력프린터");
            errYn = true;
            colid = "ORD_PRT";
            break;
        }
        if( !checkInputByte( GD_MASTER, DS_MASTER, i, "ORD_PRT", "주문서출력프린터") ){
            return false;
        }
        /*
        if( DS_MASTER.NameValue(i,"SORT_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "정렬순서");
            errYn = true;
            colid = "SORT_NO";
            break;
        }
        */
        if( DS_MASTER.NameValue(i,"USE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
            errYn = true;
            colid = "USE_YN";
            break;
        }
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
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
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
    	if(colid=="STR_CD")
    		showMessage(EXCLAMATION, OK, "USER-1002", "점");
    	else if(colid=="FNB_SHOP_CD")
            showMessage(EXCLAMATION, OK, "USER-1002", "매장");
        else if(colid=="MENU_FLAG_CD")
            showMessage(EXCLAMATION, OK, "USER-1003", "코너코드");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_I_FNB_SHOP_CD event=OnFilter(row)>
    var value = this.NameValue(row,"STR_CD");
    if( value != DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD"))
        return false;
    
    return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_MASTER event=OnRowPosChanged(row)>
    if( row < 1)
        return;
    DS_I_FNB_SHOP_CD.Filter();
</script> 
<script language=JavaScript for=GD_MASTER event=OnListSelect(index,row,colid)>
    if( row < 1)
        return;
    if( colid=='STR_CD'){
    	DS_I_FNB_SHOP_CD.Filter();
    	DS_MASTER.NameValue(row,"FNB_SHOP_CD") = "";
    }else if(colid="USE_YN"){
        if(DS_MASTER.NameValue(row,colid)=="N"){
            if(DS_MASTER.NameValue(row,"DTL_CNT") > 0){
                if(showMessage(QUESTION, YESNO, "USER-1000", "사용여부를 'NO'로 변경 시<br>상세 데이터도 'NO'로 변경됩니다.<br>변경하시겠습니까?")!=1){
                    DS_MASTER.NameValue(row,colid) = "Y";
                }
            }
        }else{
            if(DS_MASTER.NameValue(row,"MST_USE_YN") == "N"){
                showMessage(INFORMATION, OK, "USER-1000", "매장의 사용여부가 'NO'입니다.");
                DS_MASTER.NameValue(row,colid) = "N";
            }
        }
    }
</script> 
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd != this.BindColVal){
        if( DS_MASTER.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_MASTER.ClearData();
        // F&B매장중 코너매장 조회 (popup_dps.js)
        getFnBShopCornerCode("DS_FNB_SHOP_CD"  , LC_STR_CD.BindColVal, "N" );

        //매장 콤보데이터 기본값 설정( 첫번째선택 )
        LC_FNB_SHOP_CD.Index= 0;
        bfFnbShopCd = LC_FNB_SHOP_CD.BindColVal;
        bfStrCd = this.BindColVal;
    }
</script>
<!-- 매장 (조회) -->
<script language=JavaScript for=LC_FNB_SHOP_CD event=OnSelChange()>
    if( bfFnbShopCd != this.BindColVal){
        if( DS_MASTER.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","매장") != 1 ){
                setComboData(LC_FNB_SHOP_CD,bfFnbShopCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_MASTER.ClearData();
        bfFnbShopCd = LC_FNB_SHOP_CD.BindColVal;
    }
</script>
<!-- 코너(조회) -->
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
<comment id="_NSID_"><object id="DS_FNB_SHOP_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_FNB_SHOP_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="80" class="point">매장</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_FNB_SHOP_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">코너</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_MENU_FLAG_CD classid=<%=Util.CLSID_EMEDIT%>  width=40  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getMenuFlagCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MENU_FLAG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
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
               src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img 
               src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();"  /></td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=458 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
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

