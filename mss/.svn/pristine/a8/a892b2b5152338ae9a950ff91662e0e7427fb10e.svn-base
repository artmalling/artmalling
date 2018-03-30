<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 가맹점 제휴상품권 회수관리
 * 작 성 일 : 2011.08.02
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 가맹점 제휴상품권 회수관리
 * 이    력 : 2011.08.02 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
 var strOrgCd = '<c:out value="${sessionScope.sessionInfo.ORG_CD}" />';
 var strToday   ;
 var btnSaveClick = false;
 var strCurrRow = 0;
 
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    // Input Data Set Header 초기화
	DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	DS_IO_MASTER_DEL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    getGiftCd("getGiftAmt", "DS_O_GIFTAMT"); //금종조회
    getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
    //그리드 초기화
    gridCreate();
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 // 회수일자 / 조회
    initEmEdit(EM_E_DT, "TODAY", PK);                 // 회수일자 / 조회
    initEmEdit(EM_S_VEN_CD,  "NUMBER3^6", NORMAL);                   // 등록자
    initEmEdit(EM_S_VEN_NM,  "GEN", READ);                   // 등록자
    initEmEdit(EM_DRAWL_DT, "YYYYMMDD", PK);              // 회수일자
    initEmEdit(EM_DRAWL_SLIP_NO, "GEN", READ);              // 순번
    initEmEdit(EM_VEN_CD, "NUMBER3^6", PK);                 // 가맹점
    initEmEdit(EM_VEN_NM, "GEN", READ);                     // 가맹점 명
    
    //콤보 초기화
    initComboStyle(LC_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                  //점
    initComboStyle(LC_DRAWL_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);            //점
    
    getStore("DS_O_S_STR", "Y", "", "N");
    getStore("DS_O_STR", "Y", "", "N");
    strToday   = getTodayDB("DS_O_RESULT");
    EM_E_DT.Text = strToday;
    LC_STR.Index = 0;
    LC_STR.Focus();
    setNew();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif312", "DS_IO_MASTER,DS_IO_DETAIL");
}

function gridCreate(){
	// 메인그리드
	var hdrProperies = ''
	    + '<FC>ID={CURROW}          NAME="NO"' 
	    + '                                                  WIDTH=35       ALIGN=CENTER</FC>'
	    + '<FC>ID=SLIP_NO           NAME="전표번호"'         
	    + '                                                  WIDTH=105      ALIGN=LEFT</FC>'
	    + '<FC>ID=VEN_NM            NAME="가맹점"'           
	    + '                                                  WIDTH=90       ALIGN=LEFT</FC>';
	    initGridStyle(GD_MASTER, "common", hdrProperies, false);
	    
	// 상세그리드
	var hdrProperiesD = ''
	    + '<FC>ID={CURROW}          NAME="NO"' 
	    + '                                                  WIDTH=35       ALIGN=CENTER</FC>'
	    + '<FC>ID=FLAG              NAME=""' 
	    + '                                                  WIDTH=20       ALIGN=CENTER    EDITSTYLE=CHECKBOX HEADCHECKSHOW=TRUE HEADALIGN=CENTER</FC>'
	    + '<FC>ID=GIFT_TYPE_CD      NAME="상품권종류"'          
	    + '                                                  WIDTH=140      ALIGN=LEFT      EDITSTYLE=LOOKUP DATA="DS_O_GIFTTPM:CODE:NAME" SUMTEXT="합계"</FC>'
	    + '<FC>ID=GIFT_AMT_TYPE     NAME="금종"'         
	    + '                                                  WIDTH=140      ALIGN=LEFT      EDITSTYLE=LOOKUP DATA="DS_O_GIFTAMT:CODE:NAME"</FC>'
	    + '<FC>ID=GIFTCERT_AMT      NAME="상품권금액"'         
	    + '                                                  WIDTH=110      ALIGN=RIGTH     EDIT=NONE</FC>'
	    + '<FC>ID=DRAWL_QTY         NAME="회수수량"'         
	    + '                                                  WIDTH=90       ALIGN=RIGTH     EDIT=NUMERIC   SUMTEXT=@SUM</FC>'
	    + '<FC>ID=DRAWL_AMT         NAME="회수금액"'         
	    + '                                                  WIDTH=130      ALIGN=RIGTH     EDIT=NONE      SUMTEXT=@SUM</FC>';
	    initGridStyle(GD_DETAIL, "common", hdrProperiesD, true);
	    GD_DETAIL.ViewSummary = "1";
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
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if((DS_IO_MASTER.CountRow > 0 && (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)) 
	            &&  (showMessage(QUESTION , YESNO, "USER-1084") != 1)){
	        return;
	    }
	 
	 if(LC_STR.BindColVal == ""){
        showMessage(EXCLAMATION , OK, "USER-1002",  "점");
        LC_STR.Focus();
        return;
    }
	 
	 if(EM_S_DT.Text > EM_E_DT.Text){
		showMessage(EXCLAMATION , OK, "USER-1015");
		EM_S_DT.Focus();
        return;
     }
  
	 
	 DS_IO_MASTER.ClearData();
	 DS_IO_DETAIL.ClearData();
	 
	 var strParam = "&strStrCd="   +encodeURIComponent(LC_STR.BindColVal)
	                 + "&strSDt="  +encodeURIComponent(EM_S_DT.Text)
	                 + "&strEDt="  +encodeURIComponent(EM_E_DT.Text)
	                 + "&strVenCd="+encodeURIComponent(EM_S_VEN_CD.Text);
	    
	    TR_MAIN.Action="/mss/mgif312.mg?goTo=getMaster"+strParam;  
	    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
	    TR_MAIN.Post();
	    if(strCurrRow > 0) DS_IO_MASTER.RowPosition = strCurrRow;
	    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnSaveClick){
		if(showMessage(QUESTION , YESNO, "USER-1050") == 1 ){
	        DS_IO_DETAIL.ClearData();
	        LC_STR.Index = 0;
	        EM_E_DT.Text = strToday;
	        EM_VEN_CD.Text = "";
	        EM_VEN_NM.Text = "";
	        setNew();
		} else {
            return;
		}
	} else {
        DS_IO_MASTER.AddRow();
        DS_IO_DETAIL.ClearData();
        setNew();
	}
}

/**
 * btn_Delete()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 : 상품권회수 내역 삭제
 * return값 : void
 */
function btn_Delete() {
	    
    // 마감체크 (common.js) : 월마감 / 정산마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_DRAWL_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','47','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "정산 월", "");
        LC_DRAWL_STR.Focus();
        return;
    }
     
    // 마감체크 (common.js) : 일마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_DRAWL_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 일", "");
        LC_DRAWL_STR.Focus();
        return;
    }
    
 
    // 마감체크 (common.js) : 월마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_DRAWL_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 월", "");
        LC_DRAWL_STR.Focus();
        return;
    }
    
    if (showMessage(QUESTION , YESNO, "USER-1023") != 1) return;
    
    DS_IO_MASTER_DEL.ClearData();
    DS_IO_MASTER_DEL.AddRow();
    DS_IO_MASTER_DEL.NameValue(1, "DRAWL_DT")      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_DT");
    DS_IO_MASTER_DEL.NameValue(1, "DRAWL_STR")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_STR");
    DS_IO_MASTER_DEL.NameValue(1, "DRAWL_SLIP_NO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_SLIP_NO");

    TR_MAIN.Action="/mss/mgif312.mg?goTo=delete";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER_DEL=DS_IO_MASTER_DEL)";
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) {
        btn_Search();
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.08.02
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0 || DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    // 마감체크 (common.js) : 월마감 / 정산마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_DRAWL_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','47','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "정산 월", "");
        LC_DRAWL_STR.Focus();
        return;
    }
    
 // 마감체크 (common.js) : 일마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_DRAWL_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 일", "");
        LC_DRAWL_STR.Focus();
        return;
    }
     
    // 마감체크 (common.js) : 월마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_DRAWL_STR.BindColVal
                      , EM_DRAWL_DT.Text
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 월", "");
        LC_DRAWL_STR.Focus();
        return;
    }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
  
    var strParam = "&strRowStatus="+ encodeURIComponent(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition));
    
    TR_MAIN.Action="/mss/mgif312.mg?goTo=save"+strParam;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();
    if(strCurrRow == 0) strCurrRow = DS_IO_MASTER.RowPosition;
    DS_IO_MASTER.ClearData();
    if(TR_MAIN.ErrorCode == 0) {
        btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.08.02
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.08.02
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.02
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.08.02
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    for (i=1; i<=DS_IO_DETAIL.CountRow; i++) {
		//상품권종류
		if (DS_IO_DETAIL.NameValue(i,"GIFT_TYPE_CD") == "") {
		    DS_IO_DETAIL.RowPosition = i;
		    GD_DETAIL.SetColumn("GIFT_TYPE_CD");
		    showMessage(INFORMATION, OK, "USER-1002", "상품권종류");
		    return false;
		}
		  
		//금종
		if (DS_IO_DETAIL.NameValue(i,"GIFT_AMT_TYPE") == "") {
		    DS_IO_DETAIL.RowPosition = i;
		    GD_DETAIL.SetColumn("GIFT_AMT_TYPE");
		    showMessage(INFORMATION, OK, "USER-1002", "금종");
		    return false;
		}
		
		//회수수량
		if (DS_IO_DETAIL.NameValue(i,"DRAWL_QTY") == "" || eval(DS_IO_DETAIL.NameValue(i,"DRAWL_QTY")) == 0) {
		    DS_IO_DETAIL.RowPosition = i;
		    GD_DETAIL.SetColumn("DRAWL_QTY");
		    showMessage(INFORMATION, OK, "USER-1002", "회수수량");
		    return false;
		}
    } 
    
    return true;
}

 
/**
 * setNew()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 : 초기화
 * return값 : void
 */ 
function setNew(){
    var contents = document.getElementsByName("CONTENTS");
    if(DS_IO_MASTER.CountRow == 0 || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_SLIP_NO") != "")
        var strFlag = false;
    else
        var strFlag = true;
    
    for(var i=0;i<contents.length;i++){
        contents[i].Enable = strFlag;
    }
    enableControl(IMG_CAL, strFlag);
    enableControl(IMG_VEN, strFlag);
    enableControl(IMG_ADD, strFlag);
    enableControl(IMG_DEL, strFlag);
    //GD_DETAIL.Editable = strFlag;
    
    if(strFlag){
		LC_DRAWL_STR.Index = 0;
		EM_DRAWL_DT.Text = strToday;
    }
    
    // 신규시에만 그리드 등록가능
    if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {
        GD_DETAIL.Editable = true;
    } else {
        GD_DETAIL.Editable = false;
    }
}

/**
 * setMstObj()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 : 초기화
 * return값 : void
 */ 
function setMstObj(strFlag){
    var contents = document.getElementsByName("CONTENTS");
    for(var i=0;i<contents.length;i++){
        contents[i].Enable = strFlag;
    }
    
    enableControl(IMG_CAL, strFlag);
    enableControl(IMG_VEN, strFlag);
}

/**
 * getDetail()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function getDetail() {
        var strParam = "&strStrCd="  + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_STR"))
                     + "&strDrawlDt="+ encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_DT"))
                     + "&strSlipNo=" + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_SLIP_NO"));
        
        TR_DTL.Action="/mss/mgif312.mg?goTo=getDetail"+strParam;  
        TR_DTL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_DTL.Post();
}

/**
 * addRow()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 :  행삭제
 * return값 : void
 */
function addRow(){
    if(LC_DRAWL_STR.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "회수점");
        LC_DRAWL_STR.Focus();
        return;
    }
    
    if(EM_DRAWL_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "회수일자");
        EM_DRAWL_DT.Focus();
        return;
    }
    
    if(EM_VEN_CD.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "가맹점코드");
        EM_VEN_CD.Focus();
        return;
    }
	 
	 DS_IO_DETAIL.AddRow();
	 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "DRAWL_DT")      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_DT");
	 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "DRAWL_STR")     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_STR");
	 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "DRAWL_SLIP_NO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_SLIP_NO");
	 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD")        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
}

/**
 * delRow()
 * 작 성 자 : 김유완
 * 작 성 일 : 2011.08.02
 * 개    요 :  행삭제
 * return값 : void
 */
function delRow(){
	if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
	
	if(DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
	
	var strCnt = DS_IO_DETAIL.CountRow;
	var delCnt = 0;
    for(var i=1;i<=strCnt;i++){
        if(DS_IO_DETAIL.NameValue(i,"FLAG") == "T"){
        	DS_IO_DETAIL.DeleteRow(i);     
            i = i -1;
            delCnt++;
        }
    }
    
    //선택없이 행삭제 버튼시 해당 행만 삭제
    if (delCnt==0) {
		DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);     
    }
    
	if(DS_IO_DETAIL.CountRow == 0){
		GD_DETAIL.ColumnProp('FLAG','HeadCheck')= "FALSE";
    }
}
 
/**
 * getVenCd()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.02
 * 개    요 : 가맹점 팝업 오픈시 점코드 필수
 * return값 : void
 */
function getVenCd(objStr, objCd, objNm){
		 
    if(objStr.BindColVal == "%" || objStr.BindColVal == "" ){
           showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
           objStr.Focus();
           return;
       }
    getMssEvtVenPop( objCd, objNm, 'S', '2', '', objStr.BindColVal, '', 'Y');
}

/**
 * getGiftCd()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.02
 * 개    요 : 상품권종류/금종 가져오기
 * return값 : void
 */
function getGiftCd(strTarget, strDateSet){
    var strParam = strTarget+"&strVenCd="+encodeURIComponent(EM_VEN_CD.Text);

    TR_CODE.Action="/mss/mgif312.mg?goTo="+strParam;  
    TR_CODE.KeyValue="SERVLET(O:DS_O_CODE="+ strDateSet +")";
    TR_CODE.Post();
}

/**
 * calGiftAmt()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.02
 * 개    요 : 회수금액계산
 * return값 : void
 */
function calGiftAmt(row){
	DS_IO_DETAIL.NameValue(row,'DRAWL_AMT') = DS_IO_DETAIL.NameValue(row,'GIFTCERT_AMT') * DS_IO_DETAIL.NameValue(row,'DRAWL_QTY');
}

-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
<script language=JavaScript for=TR_DTL event=onSuccess>
    for(i=0;i<TR_DTL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DTL.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_CODE event=onSuccess>
    for(i=0;i<TR_CODE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CODE.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DTL event=onFail>
trFailed(TR_DTL.ErrorMsg);
</script>
<script language=JavaScript for=TR_CODE event=onFail>
trFailed(TR_CODE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
 if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnSaveClick){
         if(showMessage(QUESTION , YESNO, "USER-1074") != 1 ){
             return false;
         }
         if(DS_IO_MASTER.NameValue(row,"SLIP_NO") == ""){
             DS_IO_MASTER.DeleteRow(row);
             return true;
         }
         return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
setNew();
if(row == 0) {
	return;
} else {
	if (DS_IO_MASTER.RowStatus(row) == 1) {
		LC_DRAWL_STR.Focus();   	
	} else {
		//getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
		getDetail();
		// 조회결과 Return
		setPorcCount("SELECT", GD_DETAIL);
		GD_MASTER.Focus();
	}
}

</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
// 디테일 내역 유무에 따른 마스터내역 활성/비활성화
if(row == 0) {
	setMstObj(true);
} else if (row == 1)  {
	setMstObj(false);
	//getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onColumnChanged(row,colid)>
//불출수량변경 시 불출금액 변경 
if (colid == 'DRAWL_QTY') {
	calGiftAmt(row);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 <script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_S_VEN_NM.Text = "";
        return;
    }
if(this.Text.length > 0){
    if(LC_STR.BindColVal == "%"){
        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
        LC_S_STR.Focus();
        return;
    }
    getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "2", '', LC_STR.BindColVal, '', 'Y');
}
</script>
 <script language=JavaScript for=EM_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_VEN_NM.Text = "";
        return;
    }
if(this.Text.length > 0){
    if(LC_DRAWL_STR.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
        LC_DRAWL_STR.Focus();
        return;
    }
    getMssEvtVenNonPop( "DS_O_RESULT", EM_VEN_CD, EM_VEN_NM, "E", "Y", "2", '', LC_DRAWL_STR.BindColVal, '', 'Y');
}
</script>
<script language=JavaScript for=EM_DRAWL_DT event=OnKillFocus()>
/*if(this.Text < strToday){
    showMessage(EXCLAMATION, OK, "USER-1030", "회수일자");
    this.Text = strToday;
    this.Focus();
    return false;
}*/
return true;
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
</script>
<script language="javascript"  for=GD_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
        DS_IO_DETAIL.NameValue(i,"FLAG") = strFlag;
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnCloseUp(row,colid)>
if (colid=="GIFT_TYPE_CD") { // 상품권종류
	DS_O_GIFTAMT.Filter();     // 금종필터
} else if (colid=="GIFT_AMT_TYPE") { // 금종
	//회수금액계산
	var dsRow = DS_O_GIFTAMT.NameValueRow("CODE", DS_IO_DETAIL.NameValue(row, "GIFT_AMT_TYPE"));
	DS_IO_DETAIL.NameValue(row, "GIFTCERT_AMT") = DS_O_GIFTAMT.NameValue(dsRow,"GIFTCERT_AMT")	
	calGiftAmt(row);
}
</script>

<script language=JavaScript for=DS_O_GIFTAMT event=OnFilter(row)>
// 금종필터
    if (DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GIFT_TYPE_CD") == DS_O_GIFTAMT.NameValue(row,"GIFT_TYPE_CD")) {
        return true;
    } else { 
        return false;
    }
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>   
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_STR"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_INFO"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTTPM"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTAMT"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER_DEL"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_DTL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_CODE" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작
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
						<th width="60" class="point">점</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=118 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="60" class="point">일자</th>
						<td width="200"><comment id="_NSID_"> <object id=EM_S_DT
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width=70 tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" /> ~
						<comment id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width=70 tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" /></td>
                        <th width="60">가맹점</th>
                        <td><comment id="_NSID_"><object
                            id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                            onclick="javascript:getVenCd(LC_STR, EM_S_VEN_CD, EM_S_VEN_NM);"
                            align="absmiddle" /> <comment id="_NSID_"><object
                            id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=150
                            tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
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
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign=top>
				<td width=230 class="PR05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_MASTER
							width=100% height=504 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="PB05">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="70" class="point">회수점</th>
										<td width="110"><comment id="_NSID_"> <object
											id=LC_DRAWL_STR name=CONTENTS
											classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=108
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<th width="70" class="point">회수일자</th>
										<td width="110"><comment id="_NSID_"><object
											id=EM_DRAWL_DT name=CONTENTS classid=<%=Util.CLSID_EMEDIT%>
											width=82 tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_CAL
											onclick="javascript:openCal('G',EM_DRAWL_DT)"
											align="absmiddle" /></td>
										<th width="70" class="point">전표번호</th>
										<td><comment id="_NSID_"><object
											id=EM_DRAWL_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=90
											tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="70" class="point">가맹점</th>
										<td colspan=5><comment id="_NSID_"><object
											id=EM_VEN_CD name=CONTENTS classid=<%=Util.CLSID_EMEDIT%>
											width=120 tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_VEN
											onclick="javascript:getVenCd(LC_DRAWL_STR,EM_VEN_CD,EM_VEN_NM);"
											align="absmiddle" /> <comment id="_NSID_"><object
											id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=158
											tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="PB05">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="right"><img src="/<%=dir%>/imgs/btn/add_row.gif"
									id=IMG_ADD width="52" height="18"
									onClick="javascript:addRow();" />
									<img src="/<%=dir%>/imgs/btn/del_row.gif"
                                    id=IMG_DEL width="52" height="18"
                                    onClick="javascript:delRow();" />
                                </td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="dot"></td>
					</tr>
					<tr>
						<td class="PT01 PB03">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
									width=100% height=416 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_DETAIL">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=DRAWL_STR           ctrl=LC_DRAWL_STR            param=BindColVal</c>
        <c>col=DRAWL_DT            ctrl=EM_DRAWL_DT             param=Text</c>
        <c>col=DRAWL_SLIP_NO       ctrl=EM_DRAWL_SLIP_NO        param=Text</c>
        <c>col=VEN_CD              ctrl=EM_VEN_CD               param=Text</c>
        <c>col=VEN_NM              ctrl=EM_VEN_NM               param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

