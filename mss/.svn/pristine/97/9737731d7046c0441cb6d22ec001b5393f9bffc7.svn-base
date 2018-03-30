<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 월별경영실적지침관리
 * 작 성 일 : 2011.06.14
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0640.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 년월별로 경영실적 지침을 항목별로 등록관리한다.
 * 이    력 :
 *        2011.06.14 (이정식) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var btnSaveClick = false;
var tvClick      = false;
var onPopFlag    = false;
var tbIndex;
var lo_RsltYm    = "";
var lo_canPosChange = 1;
var lo_AccFlag;
var lo_LoadFlag  = 1;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    DS_BIZ_TREE.setDataHeader('<gauce:dataset name="H_SEL_BIZ_RSLT_TREE"/>');
    DS_BIZ_DTL.setDataHeader('<gauce:dataset name="H_SEL_BIZ_RSLT_DTL"/>');
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    inputCmpMode('R');
    enableControl(IMG_ROW_ADD,false);
    enableControl(IMG_ROW_DEL,false);
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0640","DS_BIZ_TREE,DS_BIZ_DTL" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-14
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
    initEmEdit(EM_BIZ_CD,  "CODE^6", PK); //실적항목코드
    initEmEdit(EM_BIZ_NM,  "GEN^60", PK); //실적항목명
    initEmEdit(EM_L_CD,    "CODE^2", PK); //대분류 
    initEmEdit(EM_L_NM,    "GEN^60", PK); //대분류 
    initEmEdit(EM_M_CD,    "CODE^2", PK); //중분류
    initEmEdit(EM_M_NM,    "GEN^60", PK); //중분류
    initEmEdit(EM_S_CD,    "CODE^2", PK); //소분류 
    initEmEdit(EM_S_NM,    "GEN^60", PK); //소분류 
    initEmEdit(EM_PRT_SEQ, "NUMBER^3^0", PK); //출력순서 
    initEmEdit(EM_P_CD,    "CODE^6", NORMAL); //상위항목코드
    initEmEdit(EM_P_NM,    "GEN^60", NORMAL); //상위항목명
    initEmEdit(EM_RSLT_YM, "THISMN", PK); //경영실적년월    
    
    EM_RSLT_YM.text = "<%=strYm%>";
    
    EM_L_CD.UpperFlag = 1;
    EM_M_CD.UpperFlag = 1;
    EM_S_CD.UpperFlag = 1;
    lo_RsltYm = EM_RSLT_YM.text;
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
     initComboStyle(LC_BIZ_L_CD, DS_BIZ_L_CD, "CODE^0^30,NAME^0^90",  1, NORMAL); //대분류콤보초기화
     initComboStyle(LC_BIZ_M_CD, DS_BIZ_M_CD, "CODE^0^30,NAME^0^90",  1, NORMAL); //중분류콤보초기화
     initComboStyle(LC_BIZ_S_CD, DS_BIZ_S_CD, "CODE^0^30,NAME^0^90",  1, NORMAL); //소분류콤보초기화
     
     initComboStyle(LC_BIZ_LVL,  DS_BIZ_LVL,  "CODE^0^30,NAME^0^110", 1, PK);     //항목레벨콤보초기화
     initComboStyle(LC_RPT_YN,   DS_RPT_YN,   "CODE^0^30,NAME^0^110", 1, PK);     //보고서사용콤보초기화
     initComboStyle(LC_USE_YN,   DS_USE_YN,   "CODE^0^30,NAME^0^110", 1, PK);     //사용여부콤보초기화
     
     getEtcCode("DS_BIZ_LVL",  "D", "M093", "N"); //항목레벨콤보 데이터가져오기 ( gauce.js )
     getEtcCode("DS_RPT_YN",   "D", "P091", "N"); //보고서사용콤보 데이터가져오기 ( gauce.js )
     getEtcCode("DS_USE_YN",   "D", "P091", "N"); //사용여부콤보 데이터가져오기 ( gauce.js )
     getEtcCode("DS_ACC_FLAG", "D", "M092", "N"); //계정/예산항목 구분콤보 데이터가져오기 ( gauce.js )
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
    var hdrProperies = '<C>id={currow}  width=35  align=center name="NO"</C>'
                     + '<C>id=ACC_FLAG  width=100 align=center name="계정/예산구분" EditStyle=Lookup data="DS_ACC_FLAG:CODE:NAME"</C>'
                     + '<C>id=ACC_CD    width=110 align=center name="*계정/예산항목" edit="AlphaNum" EditStyle=Popup</C>'
                     + '<C>id=ACC_CD_NM width=200 align=left   name="*항목명" edit="None" </C>'
                     ;
        
    initGridStyle(GD_BIZ_DTL, "common", hdrProperies, true);
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
 * 작 성 일 : 2011-06-14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if( DS_BIZ_TREE.IsUpdated){
        //변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            EM_BIZ_NM.Focus();
            return false;
        }
    }
    
    if( DS_BIZ_DTL.IsUpdated){
        //변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            EM_BIZ_NM.Focus();
            return false;
        }
    }
    
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
    
    DS_BIZ_MST.ClearData();
    DS_BIZ_TREE.ClearData();
    
    lo_RsltYm      = EM_RSLT_YM.text;
    var goTo       = "searchBizRsltTree" ;    
    var action     = "O";     
    var parameters = "&strRsltYm=" + EM_RSLT_YM.text; //경영실적년월
    
    DS_BIZ_TREE.DataID   = "/mss/meis064.me?goTo="+goTo+parameters;
    DS_BIZ_TREE.SyncLoad = "true";
    DS_BIZ_TREE.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

    if(DS_BIZ_TREE.CountRow < 1){
        //조회 후 신규 등록이 가능합니다.
        showMessage(INFORMATION, OK, "USER-1025");
        return;
    }
    
    var insRow = DS_BIZ_TREE.RowPosition;
    
    if( DS_BIZ_TREE.RowStatus(insRow)=="1"){
        //초기화하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
            EM_BIZ_NM.Focus();
            return;
        }
        DS_BIZ_DTL.ClearData();
        DS_BIZ_TREE.DeleteRow(insRow);
    }else{
        insRow = insRow+1;      
    }
    if( DS_BIZ_TREE.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
            EM_BIZ_NM.Focus();         
            return;
        }
        DS_BIZ_DTL.ClearData();
        DS_BIZ_TREE.UndoAll();
    }

    addTreeRow(insRow);
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    if(DS_BIZ_TREE.CountRow < 2 ){
        //삭제 할 데이터가 없습니다.
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    var row = DS_BIZ_TREE.RowPosition;
    
    if(row ==1) return;
    
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        return;
    }
    
    if(DS_BIZ_TREE.RowStatus(row) == "1"){
        DS_BIZ_TREE.DeleteRow(DS_BIZ_TREE.RowPosition);
        return;
    }

    DS_BIZ_TREE.UserStatus(row) = "2";

    var saveBizCd    = DS_BIZ_TREE.NameValue(DS_BIZ_TREE.RowPosition, "P_BIZ_CD");   
    btnSaveClick     = true;
    
    TR_MAIN.Action   = "/mss/meis064.me?goTo=delete";
    TR_MAIN.KeyValue = "SERVLET(I:DS_BIZ_TREE=DS_BIZ_TREE)";
    TR_MAIN.Post();
    
    btnSaveClick     = false;

    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        var row = DS_BIZ_TREE.NameValueRow("BIZ_CD",saveBizCd);
        row = row<1?1:row;
        DS_BIZ_TREE.RowPosition = row;

        setTimeout("TV_MAIN.Focus();"      , 70);
        setTimeout("TV_MAIN.Index = " + row, 70);
    } else {
        DS_BIZ_TREE.UserStatus(row) = "0";
    }
    
    EM_BIZ_NM.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if( !DS_BIZ_TREE.IsUpdated && !DS_BIZ_DTL.IsUpdated && lo_LoadFlag){
        //저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        
        if( DS_BIZ_TREE.CountRow > 0)
            TV_MAIN.Focus();
        else
            EM_BIZ_NM.Focus();
        
        return;
    }
    
    
    //경영실적항목마스터 필수체크
    if(!checkBizMstValidation())
        return;
    //경영실적항목상세 필수체크 
    if(!checkBizDtlValidation())
        return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        EM_BIZ_NM.Focus();
        return;
    }
    
    var saveBizCd    = EM_BIZ_CD.text;   
    btnSaveClick     = true;
    var parameters   = "&strBizCd="  + encodeURIComponent(saveBizCd)  //실적항목코드
                     + "&strRsltYm=" + encodeURIComponent(lo_RsltYm); 
    
    TR_MAIN.Action   = "/mss/meis064.me?goTo=save"+parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_BIZ_TREE=DS_BIZ_TREE,I:DS_BIZ_DTL=DS_BIZ_DTL)"; 
    TR_MAIN.Post();
    
    btnSaveClick     = false;

    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        var row = DS_BIZ_TREE.NameValueRow("BIZ_CD",saveBizCd);
        row = row<1?1:row;
        DS_BIZ_TREE.RowPosition = row;

        setTimeout("TV_MAIN.Focus();"      , 70);
        setTimeout("TV_MAIN.Index = " + row, 70);
    }
    
    EM_BIZ_NM.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  계정/예산항목정보 행추가
 * return값 : void
 */
function btn_addRow(){
    var strBizCd = EM_BIZ_CD.Text;
    DS_BIZ_DTL.AddRow();
    DS_BIZ_DTL.NameValue(DS_BIZ_DTL.CountRow, "BIZ_RSLT_YM") = lo_RsltYm;
    DS_BIZ_DTL.NameValue(DS_BIZ_DTL.CountRow, "BIZ_CD")      = strBizCd;
    setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL, DS_BIZ_DTL.CountRow, "ACC_FLAG");
}

/**
 * btn_delRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  계정/예산항목정보 행삭제
 * return값 : void
 */
function btn_delRow(){
    if( DS_BIZ_DTL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        TV_MAIN.Focus();
        return;
    }
    DS_BIZ_DTL.DeleteRow(DS_BIZ_DTL.RowPosition);
} 
 
/**
 * addTreeRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  트리에 신규 추가한다.
 * 사용법: addTreeRow(row)
 *        row --> 추가 할 로우 위치 
 *               ( 로우 위치의 데이터는 밑으로 밀려난다.)
 * return값 : void
 */
function addTreeRow(row) {
     var lCd    = DS_BIZ_TREE.NameValue(row-1, "BIZ_L_CD");
     var lNm    = DS_BIZ_TREE.NameValue(row-1, "BIZ_L_NM");
     var mCd    = DS_BIZ_TREE.NameValue(row-1, "BIZ_M_CD");
     var mNm    = DS_BIZ_TREE.NameValue(row-1, "BIZ_M_NM");
     var sCd    = DS_BIZ_TREE.NameValue(row-1, "BIZ_S_CD");
     var sNm    = DS_BIZ_TREE.NameValue(row-1, "BIZ_S_NM");
     var bizLvl = DS_BIZ_TREE.NameValue(row-1, "BIZ_CD_LEVEL"); 
     var rsltYm = DS_BIZ_TREE.NameValue(row-1, "BIZ_RSLT_YM");
     TV_MAIN.ReDraw = false;
     bizLvl = bizLvl < 3 ? (Number(bizLvl) + 1) : bizLvl ;
     DS_BIZ_TREE.InsertRow(row);
     DS_BIZ_TREE.NameValue(row, "BIZ_L_CD")     = bizLvl > 1 ? lCd : '';
     DS_BIZ_TREE.NameValue(row, "BIZ_L_NM")     = bizLvl > 1 ? lNm : '';
     DS_BIZ_TREE.NameValue(row, "BIZ_M_CD")     = bizLvl < 2 ? '' : (bizLvl > 2 ? mCd : '');
     DS_BIZ_TREE.NameValue(row, "BIZ_M_NM")     = bizLvl > 2 ? mNm : '';
     DS_BIZ_TREE.NameValue(row, "BIZ_S_CD")     = bizLvl < 3 ? '' : (bizLvl > 3 ? sCd : '');
     DS_BIZ_TREE.NameValue(row, "BIZ_S_NM")     = bizLvl > 3 ? sNm : '';
     DS_BIZ_TREE.NameValue(row, "P_BIZ_CD")     = bizLvl == 3 ? lCd+mCd+'00' : ((bizLvl == 2 ? lCd+'0000' : '000000'));
     DS_BIZ_TREE.NameValue(row, "BIZ_CD_LEVEL") = bizLvl;
     DS_BIZ_TREE.NameValue(row, "BIZ_RSLT_YM")  = rsltYm;
     DS_BIZ_TREE.NameValue(row, "BIZ_CD")       = ""; 
     DS_BIZ_TREE.NameValue(row, "BIZ_CD_NM")    = ""; 
     DS_BIZ_TREE.NameValue(row, "RPT_YN")       = "Y";
     DS_BIZ_TREE.NameValue(row, "USE_YN")       = "Y";
     TV_MAIN.ReDraw = true;
     inputCmpMode('I');
     
     EM_BIZ_NM.Focus();
} 
 
/**
 * getTreeToCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  트리 데이터를 이용하여 콤보 데이터를 구성한다.
 * 사용법: getTreeToCombo(dataSet,lvl,lCd,mCd,sCd)
 *        dataSet --> 콤보데이터셋
 *        lvl     --> 구성할 품목 레벨
 *        lCd     --> 대분류코드
 *        mCd     --> 중분류코드
 * return값 : void
 */
function getTreeToCombo(dataSet,lvl,lCd,mCd){
    dataSet.ClearAll();
    dataSet.setDataHeader('BIZ_CD:STRING(6),CODE:STRING(2),NAME:STRING(60)');
    dataSet.Addrow();
    dataSet.NameValue(1, "CODE") = "%";
    dataSet.NameValue(1, "NAME") = "전체";
    for( var i = 1 ; i <= DS_BIZ_TREE.CountRow; i++) {
        var bizLvl = DS_BIZ_TREE.NameValue(i, "BIZ_CD_LEVEL");
        if( lvl == bizLvl ) {
            var bizCd  = DS_BIZ_TREE.NameValue(i, "BIZ_CD");
            var bizNm  = DS_BIZ_TREE.NameValue(i, "BIZ_CD_NM");
            var bizLCd = DS_BIZ_TREE.NameValue(i, "BIZ_L_CD");
            var bizMCd = DS_BIZ_TREE.NameValue(i, "BIZ_M_CD");
            var bizSCd = DS_BIZ_TREE.NameValue(i, "BIZ_S_CD");
            if( (lCd!=null?bizLCd==lCd:true)&&(mCd!=null?bizMCd==mCd:true)){
                dataSet.Addrow();
                dataSet.NameValue(dataSet.CountRow, "CODE")   = lCd==null?bizLCd:(mCd==null?bizMCd:bizSCd);
                dataSet.NameValue(dataSet.CountRow, "NAME")   = bizNm;
                dataSet.NameValue(dataSet.CountRow, "BIZ_CD") = bizCd;
            }
        }
    }
}

/**
 * inputCmpMode()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  실적항목정보 입력 컨트롤을 제어
 * return값 : void
 */
function inputCmpMode( mode ){
    var upd  = mode=="R"?false:true;
    var ins  = mode!="I"?false:true;
    var read = false;
    var bizLvl = DS_BIZ_TREE.NameValue( DS_BIZ_TREE.RowPosition, "BIZ_CD_LEVEL");
    
    enableControl(EM_BIZ_CD,  read);
    enableControl(EM_BIZ_NM,  read);                //실적항목명 
    enableControl(LC_BIZ_LVL, read);                //항목레벨
    enableControl(EM_L_CD,    read);                //대분류코드 
    enableControl(EM_L_NM,    read);                //대분류명 
    enableControl(EM_M_CD,    read);                //중분류코드
    enableControl(EM_M_NM,    read);                //중분류명
    enableControl(EM_S_CD,    read);                //소분류코드 
    enableControl(EM_S_NM,    read);                //소분류명
    enableControl(EM_P_CD,    read);                //상위항목코드
    enableControl(EM_P_NM,    read);                //상위항목명
    enableControl(EM_PRT_SEQ, mode=="R"?false:true);//출력순서
    enableControl(LC_USE_YN,  upd);                 //사용여부
    enableControl(LC_RPT_YN,  upd);                 //보고서사용
    enableControl(LC_USE_YN,  upd);                 //사용여부
    enableControl(IMG_BIZ,    ins);                 //팝업버튼
}

/**
 * searchBizDtl()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  계정/예산항목정보 조회
 * return값 : void
 */
function searchBizDtl(){
    var strBizCd = EM_BIZ_CD.Text;
    
    DS_BIZ_DTL.ClearData();

    var goTo          = "searchBizRsltDtl" ;    
    var action        = "O";     
    var parameters    = "&strBizCd="  + strBizCd
                      + "&strRsltYm=" + lo_RsltYm
                      + "&strFlag=0";;
    
    DS_BIZ_DTL.DataID = "/mss/meis064.me?goTo="+goTo+parameters;
    DS_BIZ_DTL.SyncLoad = "true";
    DS_BIZ_DTL.Reset();
}

/**
 * checkBizMstValidation()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  경영실적항목마스터 필수체크
 * return값 : void
 */
function checkBizMstValidation(){
    if(!DS_BIZ_TREE.IsUpdated) return true;
    
    var row = DS_BIZ_TREE.RowPosition;
    
    if(DS_BIZ_TREE.NameValue(row, "BIZ_CD_NM").trim() == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "실적항목명");
        EM_BIZ_NM.focus();
        return false;
    }
    if(getByteValLength(DS_BIZ_TREE.NameValue(row, "BIZ_CD_NM")) > 60){
        showMessage(EXCLAMATION, OK, "USER-1054", "실적항목명", "60");
        EM_BIZ_NM.focus();
        return false;
    }
    
    var obj   = null;
    var colNm = "";
    if(DS_BIZ_TREE.NameValue(row, "BIZ_CD_LEVEL") == "1"){
        obj   = EM_L_CD;
        colNm = "대분류";
    } else if(DS_BIZ_TREE.NameValue(row, "BIZ_CD_LEVEL") == "2"){
        obj   = EM_M_CD;
        colNm = "중분류";
    } else if(DS_BIZ_TREE.NameValue(row, "BIZ_CD_LEVEL") == "3"){
        obj   = EM_S_CD;
        colNm = "소분류";
    }
    
    if(obj.text.trim().length != 2){
        showMessage(EXCLAMATION, OK, "USER-1065", colNm + " 2자리");
        obj.focus();
        return false;
    }
    
    if (isNull(LC_RPT_YN.BindColVal)){
        showMessage(EXCLAMATION, OK, "USER-1002", "보고서사용");
        LC_RPT_YN.focus();
        return false;
    }
    
    if (isNull(LC_USE_YN.BindColVal)){
        showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
        LC_USE_YN.focus();
        return false;
    }
    
    var sameRow = DS_BIZ_TREE.NameValueRow("BIZ_CD_ORI", DS_BIZ_TREE.NameValue(row, "BIZ_CD"));
    if(sameRow != 0 && sameRow!= row){
        showMessage(EXCLAMATION, OK, "USER-1044");
        return false;
    }
    
    return true;
}

/**
 * checkBizDtlValidation()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  경영실적항목상세 필수체크
 * return값 : void
 */
function checkBizDtlValidation(){
    if(!DS_BIZ_DTL.IsUpdated) return true;
    for( var i = 1 ; i <= DS_BIZ_DTL.CountRow; i++){
        var rowStatus = DS_BIZ_DTL.RowStatus(i);
        
        if(rowStatus == "1" || rowStatus == "3"){
            if(rowStatus == "1"){
                if (isNull(DS_BIZ_DTL.NameValue(i,"ACC_FLAG"))){
                    showMessage(EXCLAMATION, OK, "USER-1002", "계정/예산구분");
                    setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL,i,"ACC_FLAG");
                    return false;
                }
                if (isNull(DS_BIZ_DTL.NameValue(i,"ACC_CD"))){
                    showMessage(EXCLAMATION, OK, "USER-1002", "계정/예산항목");
                    setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL,i,"ACC_CD");
                    return false;
                }
                
                var newKey = DS_BIZ_DTL.NameValue(i,"ACC_FLAG") + DS_BIZ_DTL.NameValue(i,"ACC_CD");
                for(var y=1; y< i; y++){
                    var oriKey = DS_BIZ_DTL.NameValue(y,"ACC_FLAG") + DS_BIZ_DTL.NameValue(y,"ACC_CD");
                    if(newKey == oriKey){
                        showMessage(EXCLAMATION, OK, "USER-1044");
                        setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL,i,"ACC_CD");
                        return false;
                    }
                }
            }
            if (isNull(DS_BIZ_DTL.NameValue(i,"ACC_CD_NM").trim())){
                showMessage(EXCLAMATION, OK, "USER-1003", "항목명");
                setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL,i,"ACC_CD_NM");
                return false;
            }
            if (getByteValLength(DS_BIZ_DTL.NameValue(i,"ACC_CD_NM")) > 60){
                showMessage(EXCLAMATION, OK, "USER-1054", "항목명", "60");
                setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL,i,"ACC_CD_NM");
                return false;
            }
        }
    }
    return true;
}

/**
 * copyPreData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  전년동월실적COPY
 * return값 : void
 */
function copyPreData(){
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
    
    var returnVal = window.showModalDialog( "/mss/meis064.me?goTo=list1&strRsltYm=" + EM_RSLT_YM.text
                                          , ""
                                          , "dialogWidth:870px;dialogHeight:450px;scroll:no;" 
                                          + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if(returnVal == "1"){
        var saveBizCd = EM_BIZ_CD.text;
        btn_Search();
        var row = DS_BIZ_TREE.NameValueRow("BIZ_CD",saveBizCd);
        row = row<1?1:row;
        DS_BIZ_TREE.RowPosition = row;

        setTimeout("TV_MAIN.Focus();"      , 70);
        setTimeout("TV_MAIN.Index = " + row, 70);
    }
}

/**
 * getExcelPopup()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  엑셀팝업
 * return값 : void
 */
function getExcelPopup(){
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
    
    var returnVal = window.showModalDialog( "/mss/meis064.me?goTo=list2&strRsltYm=" + EM_RSLT_YM.text
                                          , ""
                                          , "dialogWidth:950px;dialogHeight:378px;scroll:no;" 
                                          + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if(returnVal == "1"){
        var saveBizCd = EM_BIZ_CD.text;
        btn_Search();
        var row = DS_BIZ_TREE.NameValueRow("BIZ_CD",saveBizCd);
        row = row<1?1:row;
        DS_BIZ_TREE.RowPosition = row;

        setTimeout("TV_MAIN.Focus();"      , 70);
        setTimeout("TV_MAIN.Index = " + row, 70);
    }
}

/**
 * setBizCdNm()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 : 항목코드POPUP/항목코드/명을 조회한다.
 * return값 : void
 */
function setBizCdNm(){
    var codeObj = EM_BIZ_CD;
    var nameObj = EM_BIZ_NM;
    var bizLvl  = DS_BIZ_TREE.NameValue(DS_BIZ_TREE.RowPosition, "BIZ_CD_LEVEL");
    var pBizCd  = DS_BIZ_TREE.NameValue(DS_BIZ_TREE.RowPosition, "P_BIZ_CD");
    var result  = getBizPop(codeObj,nameObj,bizLvl,pBizCd);

    if( result != null ) {
    	LC_RPT_YN.BindColVal = result[2];
    	EM_PRT_SEQ.Text      = result[3];
    	LC_USE_YN.BindColVal = result[4];
    	EM_L_CD.Text         = result[0].substr(0,2);
    	EM_M_CD.Text         = result[0].substr(2,2);
    	EM_S_CD.Text         = result[0].substr(4,2);
    	
    	var strBizCd = EM_BIZ_CD.Text;
        
        DS_BIZ_DTL.ClearData();

        var goTo          = "searchBizRsltDtl" ;    
        var action        = "O";     
        var parameters    = "&strBizCd="  + strBizCd
                          + "&strRsltYm=" + lo_RsltYm
                          + "&strFlag=1";;
        
        DS_BIZ_DTL.DataID = "/mss/meis064.me?goTo="+goTo+parameters;
        DS_BIZ_DTL.SyncLoad = "true";
        DS_BIZ_DTL.Reset();
    	return;
    }
    
    if(nameObj.Text == "") codeObj.Text = "";
}

/**
 * getAccData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-14
 * 개    요 :  계정/예산항목 GridPopup
 * return값 : void
 */
function getAccData(row, colid , popFlag){
    var strBizCd   = EM_BIZ_CD.Text; //실적항목코드 
    var strAccFlag = DS_BIZ_DTL.NameValue(row, "ACC_FLAG"); //계정/예산구분   
    var strAccCd   = DS_BIZ_DTL.NameValue(row, colid);      //계정/예산항목  
   
    var rtnMap = null;
    
    if(popFlag != "1"){
    	DS_BIZ_DTL.NameValue(row, "ACC_CD_NM") = "";
        rtnMap = getAccNonPop("1", "DS_I_COMMON", strBizCd, strAccFlag, strAccCd);
    }else{
        rtnMap = getAccPop("1", strAccFlag, strAccCd);
    }
    if(rtnMap != null){            
        DS_BIZ_DTL.NameValue(row, "ACC_CD")    = rtnMap[0];
        DS_BIZ_DTL.NameValue(row, "ACC_CD_NM") = rtnMap[1];
    }else{
        if(DS_BIZ_DTL.NameValue(row, "ACC_CD_NM") == "") DS_BIZ_DTL.NameValue(row, "ACC_CD") = "";
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
<script language=JavaScript for=DS_BIZ_TREE event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt-1);
    getTreeToCombo(DS_BIZ_L_CD,'1');
    LC_BIZ_L_CD.Index = 0;
    TV_MAIN.Focus();
    DS_BIZ_TREE.RowMark(1) = '0';
    TV_MAIN.Index = 1;
</script>

<script language=JavaScript for=DS_BIZ_DTL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(rowcnt>0 && this.NameValue(1, "DIV_FLAG") == "0"){
    	this.UseChangeInfo = "false";
    	lo_LoadFlag = 0;
    	enableControl(IMG_ROW_ADD,true);
        enableControl(IMG_ROW_DEL,true);
    } else {
    	this.UseChangeInfo = "true";
    	lo_LoadFlag = 1;
    }
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_BIZ_TREE  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_BIZ_DTL  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_BIZ_TREE event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
        return;
    
    if(this.RowMark(row) == '1'){
        this.RowMark(row) = '0';
        EM_BIZ_NM.Focus();
        tvClick = false;
        return false;
    }
    
    if(DS_BIZ_DTL.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL,DS_BIZ_DTL.RowPosition,"ACC_FLAG");
            if(tvClick) this.RowMark(row) = '1';
            return false;
        }
        DS_BIZ_DTL.UndoAll();
    }
    
    if( this.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            if(tvClick) this.RowMark(row) = '1';
            EM_BIZ_NM.Focus();
            return false;
        }
        var rowStatus = this.RowStatus(row);   
        this.UndoAll();
        if( rowStatus=="1"){
            setTimeout("TV_MAIN.Reset();",50);
            setTimeout("TV_MAIN.Focus();",50);
            setTimeout("TV_MAIN.Index = " + (row <= tbIndex ? tbIndex-1:tbIndex)+";",50);
            if(tbIndex == 1) inputCmpMode("R");
                
        }
    }
</script>

<script language=JavaScript for=DS_BIZ_TREE event=OnRowPosChanged(row)>
    if( row < 1 )
        return;
    
    if(row == 1){
        enableControl(IMG_ROW_ADD,false);
        enableControl(IMG_ROW_DEL,false);
        DS_BIZ_DTL.ClearData();
        inputCmpMode("R");
        return;
    }
    
    if( this.RowStatus(row)=="1"){
        inputCmpMode("I");
        enableControl(IMG_ROW_ADD,false);
        enableControl(IMG_ROW_DEL,false);
        DS_BIZ_DTL.ClearData();
    }else{
        inputCmpMode("U");
        enableControl(IMG_ROW_ADD,true);
        enableControl(IMG_ROW_DEL,true);
        searchBizDtl();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=LC_BIZ_L_CD event=OnSelChange()>
    DS_BIZ_M_CD.ClearData();
    DS_BIZ_S_CD.ClearData();
    getTreeToCombo(DS_BIZ_M_CD,'2',this.BindColVal);
    LC_BIZ_M_CD.Index = 0;
    if(this.BindColVal != '%'){
        DS_BIZ_TREE.RowPosition 
          = DS_BIZ_TREE.NameValueRow("BIZ_CD",this.ValueByColumn("CODE",this.BindColVal,"BIZ_CD"));
        TV_MAIN.Focus();
    }
</script>

<script language=JavaScript for=LC_BIZ_M_CD event=OnSelChange()>
    DS_BIZ_S_CD.ClearData();
    getTreeToCombo(DS_BIZ_S_CD,'3',LC_BIZ_L_CD.BindColVal,this.BindColVal);
    LC_BIZ_S_CD.Index = 0;
    if(this.BindColVal != '%'){
        DS_BIZ_TREE.RowPosition 
          = DS_BIZ_TREE.NameValueRow("BIZ_CD",this.ValueByColumn("CODE",this.BindColVal,"BIZ_CD"));
        TV_MAIN.Focus();
    }
</script>

<script language=JavaScript for=LC_BIZ_S_CD event=OnSelChange()>
    if(this.BindColVal != '%'){
        DS_BIZ_TREE.RowPosition 
          = DS_BIZ_TREE.NameValueRow("BIZ_CD",this.ValueByColumn("CODE",this.BindColVal,"BIZ_CD"));
        TV_MAIN.Focus();
    }
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=TV_MAIN event=OnItemClick(ItemIndex)>
    tvClick = true;
    tbIndex = ItemIndex;
</script>

<script language=JavaScript for=EM_L_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text=='' || this.text.trim().length != 2) return;
    
    EM_BIZ_CD.text = EM_L_CD.text + EM_M_CD.text + EM_S_CD.text;
</script>

<script language=JavaScript for=EM_M_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text=='' || this.text.trim().length != 2) return;
    
    EM_BIZ_CD.text = EM_L_CD.text + EM_M_CD.text + EM_S_CD.text;
</script>

<script language=JavaScript for=EM_S_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text=='' || this.text.trim().length != 2) return;
    
    EM_BIZ_CD.text = EM_L_CD.text + EM_M_CD.text + EM_S_CD.text;
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnPopup(row,colid,data)>
    var accFlag = DS_BIZ_DTL.NameValue(row, "ACC_FLAG");
    if (accFlag != ""){
        if (colid == "ACC_CD"){
            onPopFlag = true;
            getAccData(row , colid , '1');
            onPopFlag = false;
        }
    } else {
    	showMessage(EXCLAMATION, OK, "USER-1003" , "계정/예산구분");
    	setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL, row ,"ACC_FLAG");  
    }
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnColumnPosChanged(row,colid)>
    if(colid != "ACC_CD" && lo_canPosChange){
        if(DS_BIZ_DTL.NameValue(row, "ACC_FLAG") == "") setFocusGrid(GD_BIZ_DTL,DS_BIZ_DTL, row ,"ACC_FLAG");
    }
    lo_canPosChange = 0;
</script>


<script language=JavaScript for=GD_BIZ_DTL event=OnExit(row,colid,oldData)>
    if(row < 1)
        return;
    if( onPopFlag)
        return;
    if( oldData == DS_BIZ_DTL.NameValue(row,colid))
        return;
    if(colid=="ACC_CD"){
    	//점코드 셋팅여부체크
        if(DS_BIZ_DTL.NameValue(row, "ACC_FLAG") == ""){
        	lo_canPosChange = 1;
        	showMessage(EXCLAMATION, OK, "USER-1003" , "계정/예산구분");
            return true;
        }
        getAccData(row , colid , '0');
    }
    return true;
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnDropDown(row,colid)>
    lo_AccFlag = DS_BIZ_DTL.NameValue(row, colid);
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnCloseUp(row,colid)>
    if(lo_AccFlag != DS_BIZ_DTL.NameValue(row, colid)){
    	DS_BIZ_DTL.NameValue(row, "ACC_CD")    = "";
    	DS_BIZ_DTL.NameValue(row, "ACC_CD_NM") = "";
    }
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
    <!--[콤보]대분류 -->
    <object id="DS_BIZ_L_CD"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]중분류 -->
    <object id="DS_BIZ_M_CD"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]소분류 -->
    <object id="DS_BIZ_S_CD"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[트리]경영실적항목트리 -->
    <object id="DS_BIZ_TREE"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--경영실적항목 Master데이터 -->
    <object id="DS_BIZ_MST"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]경영실적항목 Detail데이터 -->
    <object id="DS_BIZ_DTL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]계정/예산항목 구분코드 -->
    <object id="DS_ACC_FLAG"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]항목레벨 -->
    <object id="DS_BIZ_LVL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]보고서사용 -->
    <object id="DS_RPT_YN"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]사용여부 -->
    <object id="DS_USE_YN"    classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80" class="point">경영실적년월</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
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
            <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="70">대분류 </th>
                    <td width="75">
                      <comment id="_NSID_">
                        <object id=LC_BIZ_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="70">중분류</th>
                    <td width="75">
                      <comment id="_NSID_">
                        <object id=LC_BIZ_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>소분류 </th>
                    <td colsapn=3>
                      <comment id="_NSID_">
                        <object id=LC_BIZ_S_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr> 
            </table></td>
          </tr>
          <tr valign="top">
            <td width="100%" class="PT03">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD2A">
                <tr>
                  <td>
                    <comment id="_NSID_">
                      <object id=TV_MAIN classid=<%=Util.CLSID_TREEVIEW%> height=450 width=100% >
                        <param name=DataID       value="DS_BIZ_TREE">  <!-- Bind할 DataSet의 ID -->
                        <param name=TextColumn   value="V_BIZ_CD_NM">  <!-- 컨텐츠 -->
                        <param name=LevelColumn  value="BIZ_CD_LEVEL"> <!-- 레벨 -->
                        <param name=UseImage     value="false">
                        <param name=ExpandLevel  value="2">
                        <param name=BorderStyle  value="0">
                      </object>
                    </comment><script>_ws_(_NSID_);</script>                  
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table></td>
        <td class="PL10 "><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 품목정보</td>
                <td class="right PB02" valign="bottom">
                  <img src="/<%=dir%>/imgs/btn/copy_lastcomment.gif" onclick="javascript:copyPreData();" />
                  <img src="/<%=dir%>/imgs/btn/excel_s.gif" onclick="javascript:getExcelPopup();" />
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="80" class="point">실적항목코드 </th>
                    <td width="140">
                      <comment id="_NSID_">
                        <object id=EM_BIZ_CD classid=<%=Util.CLSID_EMEDIT%> width=117 tabindex=1 align="absmiddle">
                        </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" id=IMG_BIZ onclick="javascript:setBizCdNm()"  align="absmiddle" />
                    </td>
                    <th width="80" class="point">실적항목명</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=EM_BIZ_NM classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point" >항목레벨</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_BIZ_LVL classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">대분류</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=EM_L_CD classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_L_NM classid=<%=Util.CLSID_EMEDIT%> width=105 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">중분류</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=EM_M_CD classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_M_NM classid=<%=Util.CLSID_EMEDIT%> width=105 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th class="point">소분류 </th>
                    <td>
                      <comment id="_NSID_">
                        <object id=EM_S_CD classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_S_NM classid=<%=Util.CLSID_EMEDIT%> width=105 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">보고서사용 </th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_RPT_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">출력순서</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=EM_PRT_SEQ classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th id=TH_TAG_FLAG>사용여부</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th id=TH_UNIT_CD>상위항목코드</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=EM_P_CD classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_P_NM classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 계정/예산항목정보</td>
                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ROW_ADD onclick="javascript:btn_addRow();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_ROW_DEL onclick="javascript:btn_delRow();""/>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_BIZ_DTL width="100%" height=323 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_BIZ_DTL">
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
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
        <param name=DataID          value=DS_BIZ_TREE>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>col=BIZ_CD       ctrl=EM_BIZ_CD  param=Text</c>
            <c>col=BIZ_CD_NM    ctrl=EM_BIZ_NM  param=Text</c>
            <c>col=BIZ_L_CD     ctrl=EM_L_CD    param=Text</c>
            <c>col=BIZ_L_NM     ctrl=EM_L_NM    param=Text</c>
            <c>col=BIZ_M_CD     ctrl=EM_M_CD    param=Text</c>
            <c>col=BIZ_M_NM     ctrl=EM_M_NM    param=Text</c>
            <c>col=BIZ_S_CD     ctrl=EM_S_CD    param=Text</c>
            <c>col=BIZ_S_NM     ctrl=EM_S_NM    param=Text</c>
            <c>col=P_BIZ_CD     ctrl=EM_P_CD    param=Text</c>
            <c>col=P_BIZ_NM     ctrl=EM_P_NM    param=Text</c>
            <c>col=PRT_SEQ      ctrl=EM_PRT_SEQ param=Text</c>
            <c>col=BIZ_CD_LEVEL ctrl=LC_BIZ_LVL param=BindColVal</c>
            <c>col=RPT_YN       ctrl=LC_RPT_YN  param=BindColVal</c>
            <c>col=USE_YN       ctrl=LC_USE_YN  param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
