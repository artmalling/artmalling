<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> CMS쿠폰관리
 * 작 성 일 : 2010.05.25
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : CMS 쿠폰을 관리한다.
 * 이    력 :
 *        2010.05.25 (정진영) 신규작성
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
var bfStrCd;
var isOnPopup = false;
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
    DS_EXCEL.setDataHeader('<gauce:dataset name="H_SEL_EXCEL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_APP_DT_FROM  , "YYYYMMDD"  , PK);      //적용기간 FROM
    initEmEdit(EM_APP_DT_TO    , "YYYYMMDD"  , PK);      //적용기간 TO
    initEmEdit(EM_VEN_CD       , "CODE^6^0"  , NORMAL);  //협력사코드
    initEmEdit(EM_VEN_NAME     , "GEN^40"    , NORMAL);  //협력사명
    initEmEdit(EM_SKU_CD       , "CODE^13^0" , NORMAL);  //단품코드
    initEmEdit(EM_SKU_NAME     , "GEN^40"    , NORMAL);  //단품명
    initEmEdit(EM_CPN_CD       , "CODE^13^0" , NORMAL);  //쿠폰코드
    
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD     , DS_STR_CD     , "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    
    // 점코드 조회
    getStore("DS_STR_CD"    , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    bfStrCd = LC_STR_CD.BindColVal;
    
    EM_APP_DT_FROM.Text = getTodayFormat("YYYYMM")+"01";
    EM_APP_DT_TO.Text   = getTodayFormat("YYYYMMDD");

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod809","DS_MASTER" );
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center  edit=none     name="NO"              BgColor={if(ERROR_YN = "Y","orange","white")} </FC>'
                     + '<FC>id=SEL             width=60   align=center                name="삭제"            BgColor={if(ERROR_YN = "Y","orange","white")} EditStyle=CheckBox HeadCheckShow=true edit={IF(EDIT_YN="Y","true","false")}</FC>'
                     + '<FC>id=STR_CD          width=80   align=left    edit=none     name="점"              BgColor={if(ERROR_YN = "Y","orange","white")} EditStyle=Lookup  data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=CPN_CD          width=110  align=center  edit=Numeric  name="*쿠폰코드"       BgColor={if(ERROR_YN = "Y","orange","white")} edit={IF(SysStatus="I","true","false")} </FC>'
                     + '<FC>id=CPN_NAME        width=120  align=left                  name="*쿠폰명"         BgColor={if(ERROR_YN = "Y","orange","white")} edit={IF(EDIT_YN="Y","true","false")}</FC>'
                     + '<FC>id=SKU_CD          width=120  align=center  edit=Numeric  name="*단품코드"       BgColor={if(ERROR_YN = "Y","orange","white")} EditStyle=Popup edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=SKU_NAME        width=130  align=left    edit=none     name="단품명"          BgColor={if(ERROR_YN = "Y","orange","white")} </FC>'
                     + '<FC>id=CPN_QTY         width=80   align=right   edit=Numeric  name="수량"            BgColor={if(ERROR_YN = "Y","orange","white")} edit={IF(EDIT_YN="Y","true","false")}</FC>'
                     + '<FC>id=CPN_AMT         width=80   align=right   edit=Numeric  name="*쿠폰금액"       BgColor={if(ERROR_YN = "Y","orange","white")} edit={IF(EDIT_YN="Y","true","false")}</FC>'
                     + '<FC>id=APP_S_DT        width=85   align=center  edit=Numeric  name="*적용시작일"     BgColor={if(ERROR_YN = "Y","orange","white")} mask="XXXX/XX/XX" EditStyle=Popup edit={IF(EDIT_YN="Y","true","false")}</FC>'
                     + '<FC>id=APP_E_DT        width=85   align=center  edit=Numeric  name="*적용종료일"     BgColor={if(ERROR_YN = "Y","orange","white")} mask="XXXX/XX/XX" EditStyle=Popup edit={IF(END_YN="N","true","false")}</FC>';

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
    
    if( EM_APP_DT_FROM.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "적용기간(FROM)");
        EM_APP_DT_FROM.Focus();
        return;
    }

    if( EM_APP_DT_TO.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "적용기간(TO)");
        EM_APP_DT_TO.Focus();
        return;
    }

    if( EM_APP_DT_TO.Text < EM_APP_DT_FROM.Text){
        showMessage(EXCLAMATION, OK, "USER-1020", "적용기간(TO)","적용기간(FROM)");
        EM_APP_DT_TO.Focus();
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
	var total = 0;
	var noInsCnt = 0;
	for( var i=1; i<= DS_MASTER.CountRow; i++){
		if( DS_MASTER.NameValue(i,"SEL")=="T"){
			total++;
			DS_MASTER.RowMark(i) = 1;
	        if(DS_MASTER.RowStatus(i)!="1"){
	            if( DS_MASTER.NameValue(i,"EDIT_YN") != "Y" ){
                    DS_MASTER.ClearAllMark();
	                showMessage(INFORMATION, OK, "USER-1000", "적용전 데이터만 삭제 가능합니다.");
	                setFocusGrid(GD_MASTER, DS_MASTER, i, "SEL");
	                return;
	            }
	            noInsCnt++;
	        }
		}else{
            DS_MASTER.RowMark(i) = 0;
		}
	}
	if( total < 1){
        DS_MASTER.ClearAllMark();
        showMessage(INFORMATION, OK, "USER-1019");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
	}

	if( noInsCnt < 1 ){
	    DS_MASTER.DeleteMarked();
	    GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
        return; 
	}

    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        DS_MASTER.ClearAllMark();
        GD_MASTER.Focus();
        return; 
    }
    DS_MASTER.DeleteMarked();
    GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
    
    TR_MAIN.Action="/dps/pcod809.pc?goTo=delete";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
    }
    GD_MASTER.Focus();
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

    for( var i=1; i<= DS_MASTER.CountRow; i++){
        if( DS_MASTER.NameValue(i,"SEL")=="T"){
            showMessage(INFORMATION, OK, "USER-1000", "삭제 선택된 행이 존재합니다. <br>선택 해제 후 실행하세요.");
            setFocusGrid(GD_MASTER, DS_MASTER, i, "SEL");
            return;
        }
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

    GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
    
    TR_MAIN.Action="/dps/pcod809.pc?goTo=save";  
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
    var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
    var row = DS_MASTER.CountRow;
    DS_MASTER.NameValue(row,"STR_CD")     = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"CPN_QTY")    = 1;    
    //DS_MASTER.NameValue(row,"APP_S_DT")   = nextDay;    
    //DS_MASTER.NameValue(row,"APP_E_DT")   = nextDay;    
    DS_MASTER.NameValue(row,"EDIT_YN")    = "Y";    
    DS_MASTER.NameValue(row,"END_YN")     = "N";    
    
    setFocusGrid(GD_MASTER, DS_MASTER, row, "CPN_CD");
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
    if( DS_MASTER.NameValue(row,"EDIT_YN") != "Y" ){
        showMessage(INFORMATION, OK, "USER-1000", "적용전 데이터만 삭제 가능합니다.");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(row);
}

/**
 * btn_excelUpload()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  엑셀업로드
 * return값 : void
 */
function btn_excelUpload(){

    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    var strCd = LC_STR_CD.BindColVal;
    
    if(DS_MASTER.CountRow > 0){
        if( showMessage(QUESTION, YESNO, "USER-1000", "그리드 초기화 후 데이터를 로드 합니다.<br>실행하시겠습니까?") != 1){
            GD_MASTER.Focus();
            return;        	
        }
        
    }
    GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
    DS_MASTER.ClearData();
    INF_EXCELUPLOAD.Value = "";
    // 파일 선택 다이얼 실행
    INF_EXCELUPLOAD.Open();
     
    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름     
    if (strExcelFileName == "''")
        return;
    //loadExcelData 옵션처리
    var strStartRow   = 1;                 //시작Row
    var strEndRow     = 0;                 //끝Row
    var strReadType   = 0;                 //읽기모드
    var strBlankCount = 0;                 //공백row개수
    var strLFTOCR     = 0;                 //줄바꿈처리 
    var strFireEvent  = 1;                 //이벤트발생
    var strSheetIndex = 1;                 //Sheet Index 추가

     
    var strOption = strExcelFileName
                  + "," + strStartRow + "," + strEndRow + "," + strReadType 
                  + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
                  + "," + strSheetIndex;

    DS_EXCEL.ClearData();
    
    // Excel파일 DateSet에 저장               
    DS_EXCEL.Do("Excel.Application", strOption);

    //엑셀을 닫아준다.
    DS_EXCEL.Do("Excel.Close");
    
    
    if(DS_EXCEL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "0 건 로드 되었습니다.");
        LC_STR_CD.Focus();
        return;
    }
    var goTo       = "searchExcelData" ;    
    var parameters = "&strStrCd="+encodeURIComponent(strCd);
    TR_MAIN.Action="/dps/pcod809.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_EXCEL=DS_EXCEL,O:DS_RESULT=DS_SEARCH_NM)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_SEARCH_NM.CountRow < 1){
    	LC_STR_CD.Focus();
    }else{
        DS_MASTER.ImportData( DS_SEARCH_NM.ExportData(1, DS_SEARCH_NM.CountRow, true));
        
        showMessage(INFORMATION, OK, "USER-1000", DS_SEARCH_NM.CountRow+ " 건 로드 되었습니다.");
    }
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
    var appDtFrom    = EM_APP_DT_FROM.Text;
    var appDtTo      = EM_APP_DT_TO.Text;
    var venCd        = EM_VEN_CD.Text;
    var venName      = EM_VEN_NAME.Text;
    var skuCd        = EM_SKU_CD.Text;
    var skuName      = EM_SKU_NAME.Text;
    var cpnCd        = EM_CPN_CD.Text;


    GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="	 +encodeURIComponent(strCd)
                   + "&strAppDtFrom="+encodeURIComponent(appDtFrom)
                   + "&strAppDtTo="	 +encodeURIComponent(appDtTo)
                   + "&strVenCd="	 +encodeURIComponent(venCd)
                   + "&strVenName="	 +encodeURIComponent(venName)
                   + "&strSkuCd="    +encodeURIComponent(skuCd)
                   + "&strSkuName="  +encodeURIComponent(skuName)
                   + "&strCpnCd="	 +encodeURIComponent(cpnCd);
    TR_MAIN.Action="/dps/pcod809.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * setCalAppDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function setCalAppDt(evnFlag, type){
    var obj = type=='S'?EM_APP_DT_FROM:EM_APP_DT_TO;
    
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    
    if(!checkDateTypeYMD( obj , type=='S'?(getTodayFormat("YYYYMM")+"01"):getTodayFormat("YYYYMMDD")))
        return;    
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
    	venPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','0');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0,LC_STR_CD.BindColVal,'','0');
    }    
}
/**
 * getSkuCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품명을 등록한다.
 * return값 : void
 */
function getSkuCode(evnflag){
    var codeObj = EM_SKU_CD;
    var nameObj = EM_SKU_NAME;
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    var venCd = EM_VEN_CD.Text;
    venCd = replaceStr(venCd," ","").length == 6?venCd:"";
    if( evnflag == "POP" ){
    	strSkuPop(codeObj,nameObj,'Y','',LC_STR_CD.BindColVal,'','0','','','','1',venCd,'','','','Y');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrSkuNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,'Y', 0,'',LC_STR_CD.BindColVal,'','0','','','','1',venCd,'','','','Y');
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
    var codeStr = DS_MASTER.NameValue(row,"SKU_CD");
    var strCd   = DS_MASTER.NameValue(row,"STR_CD");
    
    if( codeStr == "" && evnFlag != 'POP'){
    	DS_MASTER.NameValue(row,"SKU_NAME")     = "";
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
        rtnMap = strSkuToGridPop(codeStr,'','Y', '', strCd, '', '0', '', 'Y', '', '1','','','','','Y');
    }else{
        DS_MASTER.NameValue(row,"SKU_NAME")  = "";
        rtnMap = setStrSkuNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' ,'Y', 1, '', strCd, '', '0', '', 'Y', '', '1','','','','','Y');
    }
    
    if( rtnMap == null){
        if( DS_MASTER.NameValue(row,"SKU_NAME") == ""){
        	DS_MASTER.NameValue(row,"SKU_CD")    = "";
        }       
        return;
    }

    DS_MASTER.NameValue(row,"SKU_CD")       = rtnMap.get("SKU_CD");
    DS_MASTER.NameValue(row,"SKU_NAME")     = rtnMap.get("SKU_NAME");
    
}
 /**
  * setCalAppDtGrid()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-04-04
  * 개    요 : 달력 팝업을 실행한다.
  * return값 : void
 **/
 function setCalAppDtGrid(evnFlag, type, row){
     var colid = type=='S'?"APP_S_DT":"APP_E_DT";
     
     if( evnFlag == 'POP'){
         openCal(GD_MASTER,row,colid);
     }

     if(!checkDateTypeYMD(GD_MASTER,colid,addDate("D",1,getTodayFormat("YYYYMMDD"),"")))
         return;
     
     if( type=='S'){
    	 if(DS_MASTER.NameValue(row,colid) <= getTodayFormat("YYYYMMDD")){
             showMessage(EXCLAMATION, OK, "USER-1011", "적용시작일");
             if(DS_MASTER.RowStatus(row)=="1"){
                 DS_MASTER.NameValue(row,"APP_S_DT")  = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
             }else{
                 DS_MASTER.NameValue(row,"APP_S_DT")  = DS_MASTER.OrgNameValue(row,"APP_S_DT");                                
             }
             setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'APP_S_DT');",50);
    	 }
     }else{
         if(DS_MASTER.NameValue(row,colid) < getTodayFormat("YYYYMMDD")){
             showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
             if(DS_MASTER.RowStatus(row)=="1"){
                 DS_MASTER.NameValue(row,"APP_E_DT")  = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
             }else{
                 DS_MASTER.NameValue(row,"APP_E_DT")  = DS_MASTER.OrgNameValue(row,"APP_E_DT");                                
             }
             setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'APP_E_DT');",50);
         }
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

    var dupRow = checkDupKey(DS_MASTER,"STR_CD||CPN_CD||SKU_CD||APP_S_DT");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_MASTER,DS_MASTER,dupRow,"APP_S_DT");
        return false;
    }
    
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"CPN_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "쿠폰코드");
            errYn = true;
            colid = "CPN_CD";
            break;
        }
        if( !isSkuCdCheckSum(DS_MASTER.NameValue(i,"CPN_CD"))){
            showMessage(EXCLAMATION, OK, "USER-1069", "쿠폰코드");
            errYn = true;
            colid = "CPN_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"CPN_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "쿠폰명");
            errYn = true;
            colid = "CPN_NAME";
            break;
        }
        if( !checkInputByte( GD_MASTER, DS_MASTER, i, "CPN_NAME", "쿠폰명") ){
            return false;            
        }
        if( DS_MASTER.NameValue(i,"SKU_CD")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"SKU_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");
            colid = "SKU_CD";    
            errYn = true;
            break;
        }

        if( DS_MASTER.NameValue(i,"CPN_AMT")==""){
            showMessage(EXCLAMATION, OK, "USER-1008", "쿠폰금액", 0 );
            errYn = true;
            colid = "CPN_AMT";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_S_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
            errYn = true;
            colid = "APP_S_DT";
            break;
        }
        if(!checkYYYYMMDD(DS_MASTER.NameValue(i,"APP_S_DT"))){
            showMessage(EXCLAMATION, OK, "USER-1007", "적용시작일");
            errYn = true;
            colid = "APP_S_DT";
            break;
        }
        if( rowStatus == "1" || DS_MASTER.NameValue(i,"APP_S_DT") != DS_MASTER.OrgNameValue(i,"APP_S_DT")){
            if( DS_MASTER.NameValue(i,"APP_S_DT") <= getTodayFormat("YYYYMMDD")){
                showMessage(EXCLAMATION, OK, "USER-1011", "적용시작일");
                errYn = true;
                colid = "APP_S_DT";
                break;              
            }
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "적용종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if(!checkYYYYMMDD(DS_MASTER.NameValue(i,"APP_E_DT"))){
            showMessage(EXCLAMATION, OK, "USER-1007", "적용종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( rowStatus == "1" || DS_MASTER.NameValue(i,"APP_E_DT") != DS_MASTER.OrgNameValue(i,"APP_E_DT")){
            if( DS_MASTER.NameValue(i,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
                showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
                errYn = true;
                colid = "APP_E_DT";
                break;              
            }
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT") < DS_MASTER.NameValue(i,"APP_S_DT")){
            showMessage(EXCLAMATION, OK, "USER-1020", "적용종료일", "적용시작일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if(checkDupDtSkuCD(i)){
            showMessage(EXCLAMATION, OK, "USER-1000", "단품의 중복되는 기간이 존재합니다.");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
}
/**
 * checkDupDtSkuCD()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품의 기간을 중복을 체크한다.
 * return값 : void
 */
function checkDupDtSkuCD(row){
    var skuCd     = DS_MASTER.NameValue(row,"SKU_CD");
    var appSDt    = DS_MASTER.NameValue(row,"APP_S_DT");
    var appEDt    = DS_MASTER.NameValue(row,"APP_E_DT");
    for( var i=1; i<=DS_MASTER.CountRow; i++ ){
        if(i==row)
            continue;
        if( DS_MASTER.NameValue(i,"SKU_CD") == skuCd
            && ((DS_MASTER.NameValue(i,"APP_S_DT") <= appSDt
            && DS_MASTER.NameValue(i,"APP_E_DT") >= appSDt)
            || (DS_MASTER.NameValue(i,"APP_S_DT") <= appEDt
            && DS_MASTER.NameValue(i,"APP_E_DT") >= appEDt)))
            return true;
    }
    return false;
    
}
/**
 * clickGridHeadCheck()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 그리드 헤더 클릭시 모든 로우 반영
 * return값 :
 */
function clickGridHeadCheck( dataSet, value){
	GD_MASTER.ReDraw = false; 
    for( var i=1; i<=dataSet.CountRow; i++){
    	if( dataSet.NameValue(i,"EDIT_YN") != "Y" ){
    		continue;
        }
        dataSet.NameValue(i,"SEL") = value==1?"T":"F";
    }
    GD_MASTER.ReDraw = true;
}

/**
 * checkValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 그리드 로우 값 검증
 * return값 :
 */
function checkValidation( row){

	var errYn = false;
	var rowStatus = DS_MASTER.RowStatus(row);
    if( DS_MASTER.NameValue(row,"CPN_CD")==""){
        errYn = true;
    }else if( !isSkuCdCheckSum(DS_MASTER.NameValue(row,"CPN_CD"))){
        errYn = true;
    }else if( DS_MASTER.NameValue(row,"CPN_NAME")==""){
        errYn = true;
    }else if( DS_MASTER.NameValue(row,"SKU_CD")=="" ){
        errYn = true;
    }else if( DS_MASTER.NameValue(row,"SKU_NAME")==""){
        errYn = true;
    }else if( DS_MASTER.NameValue(row,"CPN_AMT")==""){
        errYn = true;
    }else if( DS_MASTER.NameValue(row,"APP_S_DT")==""){
        errYn = true;
    }else if(!checkYYYYMMDD(DS_MASTER.NameValue(row,"APP_S_DT"))){
        errYn = true;
    }else if( rowStatus == "1" || DS_MASTER.NameValue(row,"APP_S_DT") != DS_MASTER.OrgNameValue(row,"APP_S_DT")){
        if( DS_MASTER.NameValue(row,"APP_S_DT") <= getTodayFormat("YYYYMMDD")){
            errYn = true;
        }
    }else if( DS_MASTER.NameValue(row,"APP_E_DT")==""){
        errYn = true;
    }else if(!checkYYYYMMDD(DS_MASTER.NameValue(row,"APP_E_DT"))){
        errYn = true;
    }else if( rowStatus == "1" || DS_MASTER.NameValue(row,"APP_E_DT") != DS_MASTER.OrgNameValue(row,"APP_E_DT")){
        if( DS_MASTER.NameValue(row,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
            errYn = true;
        }
    }else if( DS_MASTER.NameValue(row,"APP_E_DT") < DS_MASTER.NameValue(row,"APP_S_DT")){
        errYn = true;
    }else if(checkDupDtSkuCD(row)){
        errYn = true;
    }

    if(errYn){
    	DS_MASTER.NameValue(row,"ERROR_YN") = 'Y';
    }else{
    	DS_MASTER.NameValue(row,"ERROR_YN") = 'N';
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

<script language=JavaScript  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_MASTER,bCheck);
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    isOnPopup = true;
    switch(colid){
        case 'SKU_CD':
            setSkuCodeToGrid('POP', row);
            break;
        case 'APP_S_DT':
            setCalAppDtGrid('POP', 'S', row);
            break;
        case 'APP_E_DT':
        	setCalAppDtGrid('POP', 'E', row);
            break;
            
    }
    checkValidation( row);
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || isOnPopup){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'CPN_CD':
            if( !isSkuCdCheckSum(DS_MASTER.NameValue(row,"CPN_CD"))){
                showMessage(EXCLAMATION, OK, "USER-1069", "쿠폰코드");
                DS_MASTER.NameValue(row,"CPN_CD") = "";
                setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'CPN_CD');",50);
            }
            break;
        case 'SKU_CD':
            setSkuCodeToGrid('NAME', row);
            break;
        case 'APP_S_DT':
            setCalAppDtGrid('NAME', 'S', row);
            break;
        case 'APP_E_DT':
            setCalAppDtGrid('NAME', 'E', row);
            break;
    
    }
    checkValidation( row);
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
        GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
        DS_MASTER.ClearData();
        bfStrCd = this.BindColVal;
    }
</script>
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME');
</script>
<!-- 단품(조회) -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getSkuCode('NAME');
</script>
<!-- 적용기간(From)(조회) -->
<script language=JavaScript for=EM_APP_DT_FROM event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setCalAppDt('NAME','S');
</script>
<!-- 적용기간(To)(조회) -->
<script language=JavaScript for=EM_APP_DT_TO event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setCalAppDt('NAME','E');
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

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_EXCEL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 634px; top: 88px; width: 68px; height: 18px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
            <th width="60" class="point">점</th>
            <td width="120">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">적용기간</th>
            <td width="210">
              <comment id="_NSID_">
                <object id=EM_APP_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:setCalAppDt('POP','S')" align="absmiddle" />&nbsp;~
              <comment id="_NSID_">
                <object id=EM_APP_DT_TO classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:setCalAppDt('POP','E')" align="absmiddle" />
            </td>
            <th width="60">협력사</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=60  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=140  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >단품코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%=Util.CLSID_EMEDIT%>  width=99  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getSkuCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%=Util.CLSID_EMEDIT%>  width=285 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >쿠폰코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_CPN_CD classid=<%=Util.CLSID_EMEDIT%>  width=225  tabindex=1 align="absmiddle"></object>
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
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="right PB03"><a 
               href="/dps/samplefiles/CMS_COUPON_UPLOAD(Sample).xls" ><img 
                 src="/<%=dir%>/imgs/btn/excel_down.gif" align="absmiddle" />
               </a><img 
               src="/<%=dir%>/imgs/btn/excel_s.gif" onClick="javascript:btn_excelUpload();" hspace="2" /><img 
               src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" /></td>
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

