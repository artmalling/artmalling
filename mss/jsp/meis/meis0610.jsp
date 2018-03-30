<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 회계마감실적관리
 * 작 성 일 : 2011.06.08
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0610.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월별로 회계마감한 비용 실적 자료를 등록/확정한다.
 * 이    력 :
 *        2011.06.08 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strYm      = Date2.addMonth(-1);
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var btnSaveClick    = false;
var onPopFlag       = false;
var lo_IsSearched   = false;
var lo_StrCd        = "";
var lo_RsltYm       = "";
var lo_OrgFlag      = "";
var lo_CanPosChange = 1;
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    DS_ACC.setDataHeader('<gauce:dataset name="H_SEL_ACC"/>');
    DS_ORG.setDataHeader('<gauce:dataset name="H_SEL_ORG"/>');
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    enableControl(IMG_EXCEL,   false);
    enableControl(IMG_ROW_ADD, false);
    enableControl(IMG_ROW_DEL, false);
    
    LC_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0610","DS_ORG,DS_ACC" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-08
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_RSLT_YM, "THISMN", PK); //경영실적년도
	EM_RSLT_YM.text = "<%=strYm%>";
	lo_RsltYm = EM_RSLT_YM.Text;
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);   //점(조회)
	initComboStyle(LC_CONFIRM,  DS_CONFIRM, "CODE^0^30,NAME^0^90", 1, READ); //확정여부
	 
	getStore("DS_STR_CD", "N", "", "N");         //점콤보 가져오기 ( gauce.js )  
	getEtcCode("DS_CONFIRM",  "D", "P076", "N"); //항목레벨콤보 데이터가져오기 ( gauce.js )
	getEtcCode("DS_ORG_FLAG", "D", "P047", "N"); //조직구분콤보 데이터가져오기 ( gauce.js )
	
	//콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    lo_StrCd = LC_STR_CD.BindColVal;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<FC>id={currow} width=25 align=center name="NO"</FC>'
		             + '<FC>id=ACC_CD   width=78 align=center name="계정항목" edit="AlphaNum" EditStyle=Popup</FC>'
		             + '<C>id=ACC_NM    width=79 align=left   name="항목명"   edit="None" SumText="합계"</C>'
		             + '<C>id=RSLT_AMT  width=79 align=right  name="금액"     edit="None" SumText=@sum</C>'
                     ;
        
    initGridStyle(GD_ACC, "common", hdrProperies, true);
    GD_ACC.ViewSummary = "1";
    
    var hdrProperies1 = '<FC>id={currow} width=25 align=center name="NO"</FC>'
                      + '<FC>id=ORG_FLAG width=80 align=center name="조직구분" EditStyle=Lookup data="DS_ORG_FLAG:CODE:NAME"</FC>'
                      + '<FC>id=ORG_CD   width=80 align=center name="조직코드" edit="AlphaNum" EditStyle=Popup</FC>'
                      + '<FC>id=ORG_NAME width=80 align=left   name="조직명" edit="None" SumText="합계"</FC>'
                      + '<C>id=DEPT_NM   width=80 align=left   name="팀" edit="None" </C>'
                      + '<C>id=TEAM_NM   width=80 align=left   name="파트" edit="None" </C>'
                      + '<C>id=PC_NM     width=80 align=left   name="PC" edit="None" </C>'
                      + '<C>id=RSLT_AMT  width=80 align=right  name="금액" edit=Numeric SumText=@sum</C>'
                      ;

    initGridStyle(GD_ORG, "common", hdrProperies1, true);
    GD_ORG.ViewSummary = "1";
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(DS_ACC.IsUpdated || DS_ORG.IsUpdated){
        //변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            return false;
        }
    }
	
	DS_ACC.ClearData();
	DS_ORG.ClearData();

	lo_IsMasterLoaded = 0;
	//1. validation
    if (isNull(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영실적년월"); //(경영실적년월)은/는 반드시 입력해야 합니다.
        EM_RSLT_YM.focus();
        return;
    }
	
    if (!checkYYYYMM(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "경영실적년월");//(경영실적년월)은/는 유효하지 않는 날짜입니다.
        EM_RSLT_YM.focus();
        return;
    }
	
	var goTo        = "searchAcc" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="  + LC_STR_CD.BindColVal //점코드
                    + "&strRsltYm=" + EM_RSLT_YM.text      //경영실적년월
                    ;
    lo_StrCd        = LC_STR_CD.BindColVal;
    lo_RsltYm       = EM_RSLT_YM.Text;
    DS_ACC.DataID   = "/mss/meis061.me?goTo="+goTo+parameters;
    DS_ACC.SyncLoad = "true";
    DS_ACC.Reset();
    lo_IsSearched   = true;
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
	DS_ORG.ClearData();
    var goTo       = "searchOrg";
    var action     = "O";
    var parameters = "&strStrCd="  + DS_ACC.NameValue(row, "STR_CD")        //점코드
                   + "&strRsltYm=" + DS_ACC.NameValue(row, "BIZ_RSLT_YM") //경영실적년월
                   + "&strAccCd="  + DS_ACC.NameValue(row, "ACC_CD")        //계정항목코드
                   ;

    DS_ORG.DataID  = "/mss/meis061.me?goTo="+goTo+parameters;
    DS_ORG.SyncLoad = "true";
    DS_ORG.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	if(!lo_IsSearched){
		//조회 후 신규 등록이 가능합니다.
        showMessage(INFORMATION, OK, "USER-1025");
		return;
	}
	
    var insRow = DS_ACC.RowPosition;

    if(insRow > 0){
    	if(LC_CONFIRM.BindColVal != "1"){
            showMessage(EXCLAMATION, OK, "USER-1000", "확정건은 신규추가 불가합니다.");
            return;
        }
    	
    	if( DS_ACC.RowStatus(insRow)=="1"){
            //초기화하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
                return;
            }
            DS_ORG.ClearData();
            DS_ACC.DeleteRow(insRow);
        }
        
        if( DS_ACC.IsUpdated){
            if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
                return;
            }
            DS_ORG.ClearData();
            DS_ACC.UndoAll();
        }
    } else {
    	LC_CONFIRM.BindColVal = "1";
    	
    	enableControl(IMG_EXCEL,   true);
        enableControl(IMG_ROW_ADD, true);
        enableControl(IMG_ROW_DEL, true);
    }
    
    DS_ORG.ClearData();
    DS_ACC.AddRow();
    DS_ACC.NameValue(DS_ACC.CountRow, "STR_CD")        = lo_StrCd;
    DS_ACC.NameValue(DS_ACC.CountRow, "BIZ_RSLT_YM") = lo_RsltYm;
    enableControl(IMG_ROW_ADD, false);
    enableControl(IMG_ROW_DEL, false);
    setFocusGrid(GD_ACC,DS_ACC, DS_ACC.CountRow, "ACC_CD");
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	if(DS_ACC.CountRow < 1 ){
        //삭제 할 데이터가 없습니다.
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
	
	if(LC_CONFIRM.BindColVal != "1"){
		showMessage(EXCLAMATION, OK, "USER-1000", "확정건은 삭제 불가합니다.");
		return;
	}
	
	var row = DS_ACC.RowPosition;
	
	if(DS_ACC.RowStatus(row) == "1"){
		DS_ACC.DeleteRow(row);
		if(LC_CONFIRM.BindColVal == "1"){
	        enableControl(IMG_ROW_ADD, true);
	        enableControl(IMG_ROW_DEL, true);
	    } else {
	        enableControl(IMG_ROW_ADD, false);
	        enableControl(IMG_ROW_DEL, false);
	    }
		return;
	}
	
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        return;
    }

	DS_ACC.UserStatus(row) = "2";
	btnSaveClick     = true;
    TR_MAIN.Action   = "/mss/meis061.me?goTo=delete";
    TR_MAIN.KeyValue = "SERVLET(I:DS_ACC=DS_ACC)";
    TR_MAIN.Post();
    btnSaveClick     = false;
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0) btn_Search();

    LC_STR_CD.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if(!DS_ORG.IsUpdated){
        //저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    btnSaveClick    = true;
    var strAccRowPo = DS_ACC.RowPosition;
    var strOrgRowPo = DS_ORG.RowPosition;
    
    TR_MAIN.Action   = "/mss/meis061.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_ACC=DS_ACC,I:DS_ORG=DS_ORG)"; 
    TR_MAIN.Post();
    btnSaveClick     = false;
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	btn_Search();
    	DS_ACC.RowPosition = strAccRowPo;
    	DS_ORG.RowPosition = strOrgRowPo;
    }
    
    LC_STR_CD.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
	if(!lo_IsSearched){
        //조회 후 처리 가능합니다.
        showMessage(INFORMATION, OK, "USER-1000", "조회 후 처리 가능합니다.");
        return;
    }
	
	if(DS_ACC.CountRow == 0 || (DS_ACC.CountRow == 1 && DS_ACC.RowStatus(DS_ACC.RowPosition) == "1")){
		//확정(확정취소)할 데이터가 없습니다.
        showMessage(INFORMATION, OK, "USER-1000", "확정(확정취소)할 데이터가 없습니다.");
        return;
	}
	
    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
        return;
    }

    DS_ACC.UserStatus(DS_ACC.RowPosition) = "2";
    
    btnSaveClick    = true;
    
    var parameters = "&strConf=" + encodeURIComponent(LC_CONFIRM.BindColVal);
    
    TR_MAIN.Action   = "/mss/meis061.me?goTo=confirm" + parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_ACC=DS_ACC)"; //조회는 O
    TR_MAIN.Post();
    btnSaveClick     = false;
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }

    LC_STR_CD.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getExcelPopup()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 :  엑셀팝업
 * return값 : void
 */
function getExcelPopup(){
    var parameters = "&strStrCd="  + lo_StrCd
                   + "&strRsltYm=" + lo_RsltYm
                   ;
    
    var returnVal = window.showModalDialog( "/mss/meis061.me?goTo=popup" + parameters
                                          , ""
                                          , "dialogWidth:930px;dialogHeight:378px;scroll:no;" 
                                          + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if(returnVal == "1") btn_Search();
}
/**
 * btn_addRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 :  조직별내역 행추가
 * return값 : void
 */
function btn_addRow(){
	var insRow = DS_ORG.RowPosition;
	if(DS_ORG.RowStatus(insRow) == "1" ){
		//초기화하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
            return;
        }
        DS_ORG.DeleteRow(insRow);
	}

	if( DS_ORG.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
            return;
        }
        DS_ORG.UndoAll();
    }
	
    DS_ORG.AddRow();
    DS_ORG.NameValue(DS_ORG.CountRow, "STR_CD")        = DS_ACC.NameValue(DS_ACC.RowPosition, "STR_CD");
    DS_ORG.NameValue(DS_ORG.CountRow, "BIZ_RSLT_YM") = DS_ACC.NameValue(DS_ACC.RowPosition, "BIZ_RSLT_YM");
    DS_ORG.NameValue(DS_ORG.CountRow, "ACC_CD")        = DS_ACC.NameValue(DS_ACC.RowPosition, "ACC_CD");
    setFocusGrid(GD_ORG,DS_ORG, DS_ORG.CountRow, "ORG_FLAG");
}

/**
 * btn_delRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 :  조직별내역 행삭제
 * return값 : void
 */
function btn_delRow(){
    if( DS_ORG.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    DS_ORG.DeleteRow(DS_ORG.RowPosition);
    DS_ACC.NameValue(DS_ACC.RowPosition, "RSLT_AMT") = GD_ORG.SummaryString('RSLT_AMT', 1);
}

/**
 * getAccData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 계정항목명을 등록한다.(Grid)
 * return값 : void
 */
 function getAccData(row, colid , popFlag){
    var strCd = DS_ACC.NameValue(row,"ACC_CD");
    var strYm = DS_ACC.NameValue(row,"BIZ_RSLT_YM");
    
    if( strCd == "" && popFlag != "1" ){
        DS_ACC.NameValue(row,"ACC_NM") = "";
        enableControl(IMG_ROW_ADD, false);
        enableControl(IMG_ROW_DEL, false);
        return;     
    }
    
    var rtnMap = null;
    
    if(popFlag != "1"){
    	DS_ACC.NameValue(row, "ACC_NM") = "";
        rtnMap = getAccNonPop("3", "DS_I_COMMON", "", strYm, strCd);
    }else{
        rtnMap = getAccPop("3", strYm, strCd);
    }  
    
    if( rtnMap != null){
        //조직코드 중복 체크
        var sameRow = DS_ACC.NameValueRow("ACC_CD", rtnMap[0]);
        if(sameRow != 0 && sameRow!= row){
            showMessage(EXCLAMATION, OK, "USER-1044");
            DS_ACC.NameValue(row,"ACC_CD") = "";
            enableControl(IMG_ROW_ADD, false);
            enableControl(IMG_ROW_DEL, false);
            setFocusGrid(GD_ACC,DS_ACC, row ,"ACC_CD");
            return;
        }
        
        DS_ACC.NameValue(row,"ACC_CD") = rtnMap[0];
        DS_ACC.NameValue(row,"ACC_NM") = rtnMap[1];
        enableControl(IMG_ROW_ADD, true);
        enableControl(IMG_ROW_DEL, true);
    }else{
    	if(DS_ACC.NameValue(row, "ACC_NM") == "") DS_ACC.NameValue(row, "ACC_CD") = "";
    	enableControl(IMG_ROW_ADD, false);
        enableControl(IMG_ROW_DEL, false);
    }
}
 
/**
 * setOrgCodeToGrid()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-08
 * 개    요 : 조직명을 등록한다.(Grid)
 * return값 : void
 */
function setOrgCodeToGrid(evnflag, row){
    var code    = DS_ORG.NameValue(row,"ORG_CD");
    var strCd   = DS_ORG.NameValue(row,"STR_CD");
    var strFlag = DS_ORG.NameValue(row,"ORG_FLAG");
    
    if( code == "" && evnflag != "POP" ){
    	DS_ORG.NameValue(row,"ORG_NAME") = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = orgCornerOutToGridPop(code,'','N','','',strFlag,'','Y', strCd);
    }else if( evnflag == "NAME" ){
    	DS_ORG.NameValue(row,"ORG_NAME") = "";
        rtnMap = setOrgCornerOutNmWithoutToGridPop("DS_SEARCH_NM",code,'',"N",1,'','',strFlag,'','Y', strCd);
    }    
    if( rtnMap != null){
    	if(rtnMap.get("STR_CD") == strCd){
    		//조직코드 중복 체크
            var sameRow = DS_ORG.NameValueRow("ORG_CD", rtnMap.get("ORG_CD"));
            if(sameRow != 0 && sameRow!= row){
                showMessage(EXCLAMATION, OK, "USER-1044");
                DS_ORG.NameValue(row,"ORG_CD") = "";
                setFocusGrid(GD_ORG,DS_ORG, row ,"ORG_CD");
                return;
            }
            
    		DS_ORG.NameValue(row,"ORG_CD")   = rtnMap.get("ORG_CD");
            DS_ORG.NameValue(row,"ORG_NAME") = rtnMap.get("ORG_NAME");            
            
            //조직기타정보와 월별 정보 셋팅
            var goTo         = "searchOrgInfo";
            
            var action       = "O";
            var parameters   = "&strStrCd="  + encodeURIComponent(DS_ORG.NameValue(row, "STR_CD"))   //점코드
                             + "&strRsltYm=" + encodeURIComponent(DS_ORG.NameValue(row, "BIZ_RSLT_YM")) //경영실적년월
                             + "&strAccCd="  + encodeURIComponent(DS_ORG.NameValue(row, "ACC_CD"))   //계정항목코드
                             + "&strOrgCd="  + encodeURIComponent(DS_ORG.NameValue(row, "ORG_CD"))   //조직코드
            
            TR_MAIN.Action   = "/mss/meis061.me?goTo="+goTo+parameters;
            TR_MAIN.KeyValue = "SERVLET("+action+":DS_ETC=DS_ETC)"; //조회는 O
            TR_MAIN.Post();
            
            DS_ORG.NameValue(row, "DEPT_NM") = DS_ETC.NameValue(1, "DEPT_NM");
            DS_ORG.NameValue(row, "TEAM_NM") = DS_ETC.NameValue(1, "TEAM_NM");
            DS_ORG.NameValue(row, "PC_NM")   = DS_ETC.NameValue(1, "PC_NM");
    	} else {
    		DS_ORG.NameValue(row,"ORG_CD")   = "";
            DS_ORG.NameValue(row,"ORG_NAME") = "";
            showMessage(EXCLAMATION, OK, "USER-1000", "점정보가 불일치 합니다.");
    	}
    }else{
        if( DS_ORG.NameValue(row,"ORG_NAME") == ""){
        	DS_ORG.NameValue(row,"ORG_CD")   = "";
        }
    }
}
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_ACC event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_ACC.Focus();
    if(rowcnt >0) LC_CONFIRM.BindColVal = DS_ACC.NameValue(1, "CONF_YN");
    else LC_CONFIRM.BindColVal = "";
    
    if(LC_CONFIRM.BindColVal == "1"){
    	enableControl(IMG_EXCEL,   true);
    	enableControl(IMG_ROW_ADD, true);
    	enableControl(IMG_ROW_DEL, true);
    } else {
    	enableControl(IMG_EXCEL,   false);
    	enableControl(IMG_ROW_ADD, false);
    	enableControl(IMG_ROW_DEL, false);
    }
</script>

<script language=JavaScript for=DS_ORG event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_ACC  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_ORG  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_ACC event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
        return;
    
    if( this.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;
        if( this.RowStatus(row)=="1" ) this.DeleteRow(row); 
        else this.UndoAll();
    }
    return true;
</script>

<script language=JavaScript for=DS_ACC event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0 && this.RowStatus(row)!="1") {
         subQuery(row);
     }
</script>

<script language=JavaScript for=DS_ORG event=onColumnChanged(row,colid)>
    DS_ACC.NameValue(DS_ACC.RowPosition, "RSLT_AMT") = GD_ORG.SummaryString('RSLT_AMT', 1);
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_ACC event=OnPopup(row,colid,data)>
    onPopFlag = true;
    getAccData(row , colid , '1');
    onPopFlag = false;
</script>

<script language=JavaScript for=GD_ACC event=OnExit(row,colid,oldData)>
    if(row < 1) return;
    if( onPopFlag) return;
    if( oldData == DS_ACC.NameValue(row,colid)) return;
    
    if(colid=="ACC_CD"){
    	getAccData(row , colid , '0');
    }
    return true;
</script>

<script language=JavaScript for=GD_ORG event=OnPopup(row,colid,data)>
    var accFlag = DS_ORG.NameValue(row, "ORG_FLAG");
    if (accFlag != ""){
        onPopFlag = true;
        setOrgCodeToGrid('POP', row);
        onPopFlag = false;
    } else {
        showMessage(EXCLAMATION, OK, "USER-1003" , "조직구분");
        setFocusGrid(GD_ORG,DS_ORG, row ,"ORG_FLAG");  
    }
</script>

<script language=JavaScript for=GD_ORG event=OnColumnPosChanged(row,colid)>
    if(colid != "ORG_CD" && lo_CanPosChange){
        if(DS_ORG.NameValue(row, "ORG_FLAG") == "") setFocusGrid(GD_ORG,DS_ORG, row ,"ORG_FLAG");
    }
    lo_CanPosChange = 0;
</script>

<script language=JavaScript for=GD_ORG event=OnExit(row,colid,oldData)>
    if(row < 1) return;
    if( onPopFlag) return;
    if( oldData == DS_ORG.NameValue(row,colid)) return;
    
    if(colid=="ORG_CD"){
        //조직코드 셋팅여부체크
        if(DS_ORG.NameValue(row, "ORG_FLAG") == ""){
            lo_CanPosChange = 1;
            showMessage(EXCLAMATION, OK, "USER-1003" , "조직코드");
            return true;
        }
        setOrgCodeToGrid('NAME', row);
    }
    return true;
</script>

<script language=JavaScript for=GD_ORG event=OnDropDown(row,colid)>
    lo_OrgFlag = DS_ORG.NameValue(row, colid);
</script>

<script language=JavaScript for=GD_ORG event=OnCloseUp(row,colid)>
    if(lo_OrgFlag != DS_ORG.NameValue(row, colid)){
        DS_ORG.NameValue(row, "ORG_CD")   = "";
        DS_ORG.NameValue(row, "ORG_NAME") = "";
        DS_ORG.NameValue(row, "DEPT_NM")  = "";
        DS_ORG.NameValue(row, "TEAM_NM")  = "";
        DS_ORG.NameValue(row, "PC_NM")    = "";
        DS_ORG.NameValue(row, "RSLT_AMT") = "";
        DS_ACC.NameValue(DS_ACC.RowPosition, "RSLT_AMT") = GD_ORG.SummaryString('RSLT_AMT', 1);
    }
</script>

<script language=JavaScript for=GD_ACC event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_ORG event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]확정구분 -->
    <object id="DS_CONFIRM"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]계정항목 -->
    <object id="DS_ACC"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]조직 -->
    <object id="DS_ORG"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드콤보]조직구분 -->
    <object id="DS_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_SEARCH_NM"   classid=<%=Util.CLSID_DATASET%>></object>
    <object id="DS_ETC"         classid=<%=Util.CLSID_DATASET%>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
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
            <th width="80" class="point">점코드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">경영실적년월</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
            </td>
            <th width="80">확정여부</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_CONFIRM classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
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
        <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_ACC width="100%" height=502 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_ACC">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 조직별 내역</td>
                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/excel_s.gif" id=IMG_EXCEL onclick="getExcelPopup();" /><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ROW_ADD onclick="javascript:btn_addRow();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_ROW_DEL onclick="javascript:btn_delRow();""/></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          <tr>
                            <td>
                              <comment id="_NSID_"><object id=GD_ORG width="100%" height=477 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_ORG">
                              </object></comment><script>_ws_(_NSID_);</script>
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
