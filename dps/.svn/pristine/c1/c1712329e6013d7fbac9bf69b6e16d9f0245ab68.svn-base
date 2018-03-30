<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 행사테마관리
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod7010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사 테마 정보를 관리한다
 * 이    력 :
 *        2010.01.18 (정진영) 신규작성
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
 var btnSaveClick = false;
 var tbIndex;
 var tvClick = false;
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
    DS_TREE_MAIN.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    

    // EMedit에 초기화    
    initEmEdit(EM_EVENT_THME_CD  , "CODE^4" , READ);    //태마코드
    initEmEdit(EM_EVENT_L_CD     , "CODE^1" , PK);      //대분류 
    initEmEdit(EM_EVENT_L_NAME   , "GEN^40" , READ);    //대분류 
    initEmEdit(EM_EVENT_M_CD     , "CODE^1" , PK);      //중분류
    initEmEdit(EM_EVENT_M_NAME   , "GEN^40" , READ);    //중분류
    initEmEdit(EM_EVENT_S_CD     , "CODE^2" , PK);      //소분류 
    initEmEdit(EM_EVENT_S_NAME   , "GEN^40" , READ);    //소분류 
    initEmEdit(EM_EVENT_THME_NAME, "GEN^40" , PK);      //테마명
    initEmEdit(EM_REMARK         , "GEN^100", NORMAL);  //비고

    //콤보 초기화
   initComboStyle(LC_O_EVENT_L_CD    , DS_O_EVENT_L_CD    , "CODE^0^30,NAME^0^140", 1, NORMAL);  //대분류(조회)
   initComboStyle(LC_O_EVENT_M_CD    , DS_O_EVENT_M_CD    , "CODE^0^30,NAME^0^140", 1, NORMAL);  //중분류(조회)
   initComboStyle(LC_O_EVENT_S_CD    , DS_O_EVENT_S_CD    , "CODE^0^30,NAME^0^140", 1, NORMAL);  //소분류(조회)
   initComboStyle(LC_O_USE_YN        , DS_O_USE_YN        , "CODE^0^30,NAME^0^140", 1, NORMAL);  //사용여부(조회)
   initComboStyle(LC_O_EVENT_L_CD_T  , DS_O_EVENT_L_CD_T  , "CODE^0^30,NAME^0^80", 1, NORMAL);  //대분류(트리)
   initComboStyle(LC_O_EVENT_M_CD_T  , DS_O_EVENT_M_CD_T  , "CODE^0^30,NAME^0^80", 1, NORMAL);  //중분류(트리)
   initComboStyle(LC_O_EVENT_S_CD_T  , DS_O_EVENT_S_CD_T  , "CODE^0^30,NAME^0^80", 1, NORMAL);  //소분류(트리)
   initComboStyle(LC_USE_YN          , DS_USE_YN          , "CODE^0^30,NAME^0^140", 1, PK);      //사용여부

   //시스템 코드 공통코드에서 가지고 오기( popup.js )
   getEtcCode("DS_O_USE_YN", "D", "D022", "Y");
   getEtcCode("DS_USE_YN", "D", "D022", "N");
   
   //행사테마 대분류 가지고 오기( popup_dps.js )
   getEvtThmeLCode("DS_O_EVENT_L_CD", "Y");
   
   //콤보데이터 기본값 설정( gauce.js )
   setComboData(LC_O_USE_YN,"%");
   
   inputCmpMode('R');

   setComboData(LC_O_EVENT_L_CD,'%');
   //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
   registerUsingDataset("pcod701","DS_TREE_MAIN" );
   LC_O_EVENT_L_CD.Focus();   
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
    if( DS_TREE_MAIN.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
        	EM_EVENT_L_CD.Focus();
            return false;
        }
    }
    DS_TREE_MAIN.ClearData();

    var strLCd   = LC_O_EVENT_L_CD.BindColVal;
    var strMCd   = LC_O_EVENT_M_CD.BindColVal;
    var strSCd   = LC_O_EVENT_S_CD.BindColVal;
    var strUseYn = LC_O_USE_YN.BindColVal;

    var goTo       = "searchTreeMaster" ;    
    var action     = "O";     
    var parameters = "&strLCd="+encodeURIComponent(strLCd)
                   + "&strMCd="+encodeURIComponent(strMCd)
                   + "&strSCd="+encodeURIComponent(strSCd)
                   + "&strUseYn="+encodeURIComponent(strUseYn);
    TR_MAIN.Action="/dps/pcod701.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_TREE_MAIN=DS_TREE_MAIN)"; //조회는 O
    TR_MAIN.Post();

    getTreeToCombo(DS_O_EVENT_L_CD_T,'1');
    setComboData(LC_O_EVENT_L_CD_T,'%');
    //조회후 결과표시
    setPorcCount("SELECT",DS_TREE_MAIN.CountRow);  

    DS_TREE_MAIN.RowPosition = 1;
    TV_MAIN.Reset();
    TV_MAIN.Focus();
    TV_MAIN.Index = 2;
    TV_MAIN.Focus();
   
    
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    TV_MAIN.Focus();
    if(DS_TREE_MAIN.CountRow < 1){
        // 조회 후 신규 등록이 가능합니다.
        showMessage(INFORMATION, OK, "USER-1025");
        LC_O_EVENT_L_CD.Focus();
        return;
    }
    var insRow = DS_TREE_MAIN.RowPosition;
    if( DS_TREE_MAIN.RowStatus(insRow)=='1'){
        // 초기화하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
        	EM_EVENT_L_CD.Focus();
            return;
        }
        DS_TREE_MAIN.DeleteRow(insRow);
    }else{
        insRow = insRow+1;      
    }
    
    if( DS_TREE_MAIN.IsUpdated){
    	// 변경된 상세 내역이 존재합니다. 신규 추가 하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
        	EM_EVENT_L_CD.Focus();         
            return;
        }
        DS_TREE_MAIN.UndoAll();
    }
    
    addTreeRow(insRow);
          
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
    
    if( !DS_TREE_MAIN.IsUpdated ){
        // 저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        
        if( DS_TREE_MAIN.CountRow > 0)
            TV_MAIN.Focus();
        else
        	LC_O_EVENT_L_CD.Focus();
        
        return;
    }
    //필수 입력체크 
    if(!checkEvtThmeValidation())
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	EM_EVENT_THME_NAME.Focus();
        return;
    }
    var saveEvtThmeCd = getSaveEvtThmeCd();   
    btnSaveClick = true;
    TR_MAIN.Action="/dps/pcod701.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_TREE_MAIN=DS_TREE_MAIN)"; 
    TR_MAIN.Post();
    btnSaveClick = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        var sLcd = LC_O_EVENT_L_CD.BindColVal;
        var sMcd = LC_O_EVENT_M_CD.BindColVal;
        var sScd = LC_O_EVENT_S_CD.BindColVal;
        btn_Search();
        
        var row = DS_TREE_MAIN.NameValueRow("EVENT_THME_CD",saveEvtThmeCd);
        row = row<1?1:row;
        getEvtThmeLCode("DS_O_EVENT_L_CD", "Y");
        setTimeout("setComboData(LC_O_EVENT_L_CD,'"+sLcd+"');",50);
        setTimeout("setComboData(LC_O_EVENT_M_CD,'"+sMcd+"');",70);
        setTimeout("setComboData(LC_O_EVENT_S_CD,'"+sScd+"');",90);

        DS_TREE_MAIN.RowPosition = row;
        setTimeout("TV_MAIN.Focus();",80);
        setTimeout("TV_MAIN.Index = "+row+";",80);
    }
    EM_EVENT_THME_NAME.Focus();
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
* addTreeRow()
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-09
* 개    요 :  트리에 신규 추가한다.
* 사용법: addTreeRow(row)
*        row --> 추가 할 로우 위치 
*               ( 로우 위치의 데이터는 밑으로 밀려난다.)
* return값 : void
*/
function addTreeRow(row) {

    var lCd = DS_TREE_MAIN.NameValue(row-1, "EVENT_L_CD");
    var lNm = DS_TREE_MAIN.NameValue(row-1, "EVENT_L_NAME");
    var mCd = DS_TREE_MAIN.NameValue(row-1, "EVENT_M_CD");
    var mNm = DS_TREE_MAIN.NameValue(row-1, "EVENT_M_NAME");
    var eventThmeCd = DS_TREE_MAIN.NameValue(row-1, "EVENT_THME_CD"); 
    var eventThmeLvl = DS_TREE_MAIN.NameValue(row-1, "EVENT_THME_LEVEL");
    
    eventThmeLvl = eventThmeLvl < 3 ? (Number(eventThmeLvl) + 1) : eventThmeLvl ;
    if(!getParentUseYn(eventThmeCd,eventThmeLvl)){
        showMessage(EXCLAMATION, OK, "USER-1000", "상위 분류가 사용할 수 없는 상태 입니다.");
    	return;
    }
    	
    DS_TREE_MAIN.InsertRow(row);
    if( row != DS_TREE_MAIN.RowPosition){
        DS_TREE_MAIN.InsertRow(row);    	
    }
    DS_TREE_MAIN.NameValue(row, "EVENT_L_CD")       = eventThmeLvl > 1 ? lCd : '';
    DS_TREE_MAIN.NameValue(row, "EVENT_L_NAME")     = eventThmeLvl > 1 ? lNm : '';
    DS_TREE_MAIN.NameValue(row, "EVENT_M_CD")       = eventThmeLvl > 2 ? mCd : '';
    DS_TREE_MAIN.NameValue(row, "EVENT_M_NAME")     = eventThmeLvl > 2 ? mNm : '';
    DS_TREE_MAIN.NameValue(row, "EVENT_S_CD")       = '';
    DS_TREE_MAIN.NameValue(row, "EVENT_S_NAME")     = '';
    DS_TREE_MAIN.NameValue(row, "EVENT_THME_LEVEL") = ""+eventThmeLvl;
    DS_TREE_MAIN.NameValue(row, "EVENT_THME_CD")    = ""; 
    DS_TREE_MAIN.NameValue(row, "EVENT_THME_NAME")  = "";
    DS_TREE_MAIN.NameValue(row, "USE_YN")           = "Y"; 

    inputCmpMode('I');
    if(eventThmeLvl == 1 )
    	EM_EVENT_L_CD.Focus();
    else if(eventThmeLvl == 2 )
        EM_EVENT_M_CD.Focus();
    else if(eventThmeLvl == 3 )
        EM_EVENT_S_CD.Focus();
    else
        EM_EVENT_THME_NAME.Focus();
}
/**
* getTreeToCombo()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  트리 데이터를 이용하여 콤보 데이터를 구성한다.
* 사용법: getTreeToCombo(dataSet,lvl,lCd,mCd)
*        dataSet --> 콤보데이터셋
*        lvl     --> 구성할 품목 레벨
*        lCd     --> 대분류코드
*        mCd     --> 중분류코드
* return값 : void
*/
function getTreeToCombo(dataSet,lvl,lCd,mCd,sCd){

    dataSet.ClearAll();
    if(lvl < 3){
        dataSet.setDataHeader('EVENT_THME_CD:STRING(4),CODE:STRING(1),NAME:STRING(40)');    	
    }else{
        dataSet.setDataHeader('EVENT_THME_CD:STRING(4),CODE:STRING(2),NAME:STRING(40)');    	
    }
    dataSet.Addrow();
    dataSet.NameValue(1, "CODE") = "%";
    dataSet.NameValue(1, "NAME") = "전체";
    for( var i = 1 ; i <= DS_TREE_MAIN.CountRow; i++) {
        var evnetThmeLvl = DS_TREE_MAIN.NameValue(i, "EVENT_THME_LEVEL");
        if( lvl == evnetThmeLvl ) {
            var evnetThmeCd = DS_TREE_MAIN.NameValue(i, "EVENT_THME_CD");
            var evnetThmeNm = DS_TREE_MAIN.NameValue(i, "EVENT_THME_NAME");
            var evnetLCd    = DS_TREE_MAIN.NameValue(i, "EVENT_L_CD");
            var evnetMCd    = DS_TREE_MAIN.NameValue(i, "EVENT_M_CD");
            var evnetSCd    = DS_TREE_MAIN.NameValue(i, "EVENT_S_CD");
            if( (lCd!=null?evnetLCd==lCd:true)
                && (mCd!=null?evnetMCd==mCd:true)
                && (sCd!=null?evnetSCd==sCd:true)){
                
                dataSet.Addrow();
                dataSet.NameValue(dataSet.CountRow, "CODE")              = lCd==null?evnetLCd:(mCd==null?evnetMCd:evnetSCd);
                dataSet.NameValue(dataSet.CountRow, "NAME")              = evnetThmeNm;
                dataSet.NameValue(dataSet.CountRow, "EVENT_THME_CD")  = evnetThmeCd;
                
            }
                
        }
    }
}

/**
 * inputCmpMode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  입력 컨트롤을 제어
 * return값 : void
 */
function inputCmpMode( mode ){
    var upd  = mode=="R"?false:true;
    var ins  = mode!="I"?false:true;
    var read = false;
    var lvl = DS_TREE_MAIN.NameValue( DS_TREE_MAIN.RowPosition, "EVENT_THME_LEVEL");
    
//     enableControl(EM_EVENT_THME_CD  , read);               //테마코드
//     enableControl(EM_EVENT_THME_NAME, upd);                //테마명
//     enableControl(EM_EVENT_L_CD     , lvl==1?ins:false);   //대분류 
//     enableControl(EM_EVENT_L_NAME   , read);               //대분류 
//     enableControl(EM_EVENT_M_CD     , lvl==2?ins:false);   //중분류
//     enableControl(EM_EVENT_M_NAME   , read);               //중분류
//     enableControl(EM_EVENT_S_CD     , lvl==3?ins:false);   //소분류 
//     enableControl(EM_EVENT_S_NAME   , read);               //소분류 
//     enableControl(EM_REMARK         , upd);                //비고
//     enableControl(LC_USE_YN         , upd);                //사용여부
    
    enableControl2(EM_EVENT_THME_CD  , read);               //테마코드
    enableControl2(EM_EVENT_THME_NAME, upd);                //테마명
    enableControl2(EM_EVENT_L_CD     , lvl==1?ins:false);   //대분류 
    enableControl2(EM_EVENT_L_NAME   , read);               //대분류 
    enableControl2(EM_EVENT_M_CD     , lvl==2?ins:false);   //중분류
    enableControl2(EM_EVENT_M_NAME   , read);               //중분류
    enableControl2(EM_EVENT_S_CD     , lvl==3?ins:false);   //소분류 
    enableControl2(EM_EVENT_S_NAME   , read);               //소분류 
    enableControl2(EM_REMARK         , upd);                //비고
    enableControl2(LC_USE_YN         , upd);                //사용여부
}
/**
 * checkEvtThmeValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  트리 DataSet 의  입력을 체크한다.
 * return값 : void
 */
function checkEvtThmeValidation(){
    var check = false;
    var titleNm = "";
    var componentId = ""; 
    var row = 0;
    for(var i = 1; i <= DS_TREE_MAIN.CountRow; i++ ) {
        var rowStatus = DS_TREE_MAIN.RowStatus(i);
        
        if( rowStatus == 0 
            || rowStatus == 2
            || rowStatus == 4)
            continue;

        if( DS_TREE_MAIN.NameValue( i, "EVENT_THME_NAME") == ''){
            check = true;
            titleNm = "테마명";
            componentId = "EM_EVENT_THME_NAME";
            row = i;
            break;
        }
        if( !checkInputByte( null, DS_TREE_MAIN, i, "EVENT_THME_NAME", "테마명", "EM_EVENT_THME_NAME") )
            return false;
        
        var eventThmeLvl = DS_TREE_MAIN.NameValue( i, "EVENT_THME_LEVEL");
        
        if( rowStatus == 1){
            
            if( eventThmeLvl == 1 && DS_TREE_MAIN.NameValue( i, "EVENT_L_CD") == ''){
                check = true;
                titleNm = "대분류";
                componentId = "EM_EVENT_L_CD";
                row = i;
                break;
            }

            if( eventThmeLvl == 2 && DS_TREE_MAIN.NameValue( i, "EVENT_M_CD") == ''){
                check = true;
                titleNm = "중분류";
                componentId = "EM_EVENT_M_CD";
                row = i;
                break;
            }
            if( eventThmeLvl == 2 && DS_TREE_MAIN.NameValue( i, "EVENT_M_CD") == '0' ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "중분류 코드","0");
                EM_EVENT_M_CD.Focus();
                return false;                    
            }

            if( eventThmeLvl == 3 && DS_TREE_MAIN.NameValue( i, "EVENT_S_CD") == ''){
                check = true;
                titleNm = "소분류";
                componentId = "EM_EVENT_S_CD";
                row = i;
                break;
            }
            if( eventThmeLvl == 3 && replaceStr(DS_TREE_MAIN.NameValue( i, "EVENT_S_CD") ," ","").length !=2){
                showMessage(EXCLAMATION, Ok,  "USER-1027", "소분류 코드",2);
                EM_EVENT_S_CD.Focus();
                return false;                                	
            }
            if( eventThmeLvl == 3 && DS_TREE_MAIN.NameValue( i, "EVENT_S_CD") == '00' ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "소분류 코드","00");
                EM_EVENT_S_CD.Focus();
                return false;                    
            }
            
        }
        
        if( DS_TREE_MAIN.NameValue( i, "USE_YN") == ''){
            check = true;
            titleNm = "사용여부";
            componentId = "LC_USE_YN";
            row = i;
            break;
        }
        
        if( !checkInputByte( null, DS_TREE_MAIN, i, "REMARK", "비고", "EM_REMARK") )
            return false;

        if( rowStatus == 1)
            continue;
        
        if( !getParentUseYn( DS_TREE_MAIN.NameValue( i, "EVENT_THME_CD"), eventThmeLvl)){
            showMessage(EXCLAMATION, OK, "USER-1000", "상위 분류가 사용할 수 없는 상태 입니다.");
            LC_USE_YN.Focus();
            return false;        	
        }
        if( !checkChildUesAllN( DS_TREE_MAIN.NameValue( i, "EVENT_THME_CD"), eventThmeLvl)){
            showMessage(EXCLAMATION, OK, "USER-1000", "하위 데이터 중 사용 중이 항목이 존재합니다.");
            LC_USE_YN.Focus();
            return false;           
        }
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        DS_TREE_MAIN.RowPosition = row;
        eval(componentId).Focus();
        return false;
    }
    return true;
}

/**
 * getSaveEvtThmeCd()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  저장할 헹사테마 코드를 조회한다.
 * return값 : String
 */
function getSaveEvtThmeCd(){
    if(DS_TREE_MAIN.IsUpdated){
        for(var i = 1; i <= DS_TREE_MAIN.CountRow; i++ ) {
            var rowStatus = DS_TREE_MAIN.RowStatus(i);
            if( rowStatus == 0 
                    || rowStatus == 2
                    || rowStatus == 4)
                    continue;
            if(rowStatus == 1){
                var evtThmeCd = DS_TREE_MAIN.NameValue( i, "EVENT_L_CD");
                evtThmeCd += DS_TREE_MAIN.NameValue( i, "EVENT_M_CD")==''?'0':DS_TREE_MAIN.NameValue( i, "EVENT_M_CD");
                evtThmeCd += DS_TREE_MAIN.NameValue( i, "EVENT_S_CD")==''?'00':DS_TREE_MAIN.NameValue( i, "EVENT_S_CD");
                return evtThmeCd;
            }
            return DS_TREE_MAIN.NameValue( i, "EVENT_THME_CD");
        }
    }
}


/**
 * getParentUseYn()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  상위 분류의 사용여부를 조회한다.
 * return값 : Boolean
 */
function getParentUseYn( code, lvl){
	if(lvl == 1)
		return true;
	var parentRow = 0;
	if(lvl == 2){
		parentRow = getNameValueRow(DS_TREE_MAIN,"EVENT_THME_CD",code.substring(0,1)+"000");
	}else if(lvl == 3){
		parentRow = getNameValueRow(DS_TREE_MAIN,"EVENT_THME_CD",code.substring(0,2)+"00");
	}
	if( parentRow < 1)
		return false;
	if(DS_TREE_MAIN.NameValue(parentRow,"USE_YN")=="N"){
        return false;   
	}
	return true;
}

/**
 * checkChildUesAllN()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  하위 분류의 사용여부가 모두 N 인지 체크한다.
 * return값 : Boolean
 */
function checkChildUesAllN( code, lvl){
	if(lvl == 3 )
		return true;
	var rtn = true;

    for(var i=1; i<=DS_TREE_MAIN.CountRow; i++){
    	if(DS_TREE_MAIN.NameValue(i,"EVENT_THME_CD") == code)
            continue;
    	
        if(lvl == 1){
        	if(DS_TREE_MAIN.NameValue(i,"EVENT_L_CD")!=code.substring(0,1))
        		continue;
        	if( DS_TREE_MAIN.NameValue(i,"USE_YN")=="Y"){
        		rtn=false;
        		break;
        	}
        }else if(lvl == 2){

            if( (DS_TREE_MAIN.NameValue(i,"EVENT_L_CD")+DS_TREE_MAIN.NameValue(i,"EVENT_M_CD")) != code.substring(0,2))
                continue;
            if( DS_TREE_MAIN.NameValue(i,"USE_YN")=="Y"){
                rtn=false;
                break;
            }
        }
    }
    return rtn;
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

<script language=JavaScript for=DS_TREE_MAIN event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
        return;

    if(this.RowMark(row) == '1'){
        this.RowMark(row) = '0';
        EM_EVENT_THME_NAME.Focus();
        tvClick = false;
        return false;
    }
    if( this.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            if(tvClick)
                this.RowMark(row) = '1';
            EM_EVENT_THME_NAME.Focus();
            return false;
        }
        var rowStatus = this.RowStatus(row);   
        this.UndoAll();
        if( rowStatus==1){
            setTimeout( "TV_MAIN.Reset();",50);
            setTimeout( "TV_MAIN.Focus();",50);
            setTimeout( "TV_MAIN.Index = " + (row <= tbIndex ? tbIndex-1:tbIndex)+";",50);
            if(tbIndex == 1)
                inputCmpMode("R");
                
        }
    }
</script>
<script language=JavaScript for=DS_TREE_MAIN event=OnRowPosChanged(row)>
    if( row < 1 )
        return;
    
    if(row == 1){
        inputCmpMode("R");
        return;
    }
    
    if( this.RowStatus(row)=="1"){
        inputCmpMode("I");
    }else{
        inputCmpMode("U");
    }    
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 
<script language=JavaScript for=TV_MAIN event=OnItemClick(ItemIndex)>
    tvClick = true;
    tbIndex = ItemIndex;
</script>
<script language=JavaScript for=LC_O_EVENT_L_CD event=OnSelChange()>
    DS_O_EVENT_M_CD.ClearData();
    DS_O_EVENT_S_CD.ClearData();
    getEvtThmeMCode("DS_O_EVENT_M_CD", this.BindColVal, "Y");
    setComboData(LC_O_EVENT_M_CD,'%');
</script>

<script language=JavaScript for=LC_O_EVENT_M_CD event=OnSelChange()>
    DS_O_EVENT_S_CD.ClearData();
    getEvtThmeSCode("DS_O_EVENT_S_CD", LC_O_EVENT_L_CD.BindColVal, this.BindColVal, "Y");
    setComboData(LC_O_EVENT_S_CD,'%');
</script>

<script language=JavaScript for=LC_O_EVENT_L_CD_T event=OnSelChange()>
    DS_O_EVENT_M_CD_T.ClearData();
    DS_O_EVENT_S_CD_T.ClearData();
    getTreeToCombo(DS_O_EVENT_M_CD_T,'2',LC_O_EVENT_L_CD_T.BindColVal);
    setComboData(LC_O_EVENT_M_CD_T,'%');
    if(this.BindColVal != '%'){
        TV_MAIN.Focus();
        TV_MAIN.Index = DS_TREE_MAIN.NameValueRow( "EVENT_THME_CD",this.ValueByColumn("CODE",this.BindColVal, "EVENT_THME_CD"));
    }
</script>
<script language=JavaScript for=LC_O_EVENT_M_CD_T event=OnSelChange()>
    DS_O_EVENT_S_CD_T.ClearData();
    getTreeToCombo(DS_O_EVENT_S_CD_T,'3',LC_O_EVENT_L_CD_T.BindColVal,LC_O_EVENT_M_CD_T.BindColVal);
    setComboData(LC_O_EVENT_S_CD_T,'%');
    if(this.BindColVal != '%'){
        TV_MAIN.Focus();
        TV_MAIN.Index = DS_TREE_MAIN.NameValueRow( "EVENT_THME_CD",this.ValueByColumn("CODE",this.BindColVal, "EVENT_THME_CD"));
    }
</script>
<script language=JavaScript for=LC_O_EVENT_S_CD_T event=OnSelChange()>
    if(this.BindColVal != '%'){
        TV_MAIN.Focus();
        TV_MAIN.Index =  DS_TREE_MAIN.NameValueRow( "EVENT_THME_CD",this.ValueByColumn("CODE",this.BindColVal, "EVENT_THME_CD"));
    }
</script>

<script language=JavaScript for=LC_USE_YN event=OnSelChange()>
    if(DS_TREE_MAIN.RowStatus(DS_TREE_MAIN.RowPosition) == 1)
    	return;
    if( this.BindColVal == "N"){
    	var eventThemCd = DS_TREE_MAIN.NameValue(DS_TREE_MAIN.RowPosition,"EVENT_THME_CD");
        var eventLvl    = DS_TREE_MAIN.NameValue(DS_TREE_MAIN.RowPosition,"EVENT_THME_LEVEL");
    	if( !checkChildUesAllN(EM_EVENT_THME_CD.Text,Number(eventLvl))){
            showMessage(EXCLAMATION, OK, "USER-1000", "하위 데이터 중 사용 중이 항목이 존재합니다.");
            setComboData(LC_USE_YN,"Y");            
    	}
    }else{
        var eventThemCd = DS_TREE_MAIN.NameValue(DS_TREE_MAIN.RowPosition,"EVENT_THME_CD");
        var eventLvl    = DS_TREE_MAIN.NameValue(DS_TREE_MAIN.RowPosition,"EVENT_THME_LEVEL");
        if( !getParentUseYn(EM_EVENT_THME_CD.Text,Number(eventLvl))){
            showMessage(EXCLAMATION, OK, "USER-1000", "상위 분류가 사용할 수 없는 상태 입니다.");
            setComboData(LC_USE_YN,"N");            
        }
    }
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
<comment id="_NSID_"><object id="DS_O_EVENT_L_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_M_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_S_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_EVENT_L_CD_T"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_M_CD_T"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_S_CD_T"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_TREE_MAIN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80">대분류</th>
            <td width="170">
              <comment id="_NSID_">
                <object id=LC_O_EVENT_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width="170" tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">중분류</th>
            <td width="170">
              <comment id="_NSID_">
                <object id=LC_O_EVENT_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width="170" tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">소분류</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_EVENT_S_CD classid=<%=Util.CLSID_LUXECOMBO%> width="170" tabindex=1 align="absmiddle"></object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="80">사용여부</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=LC_O_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width="170" tabindex=1 align="absmiddle"></object>
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
            <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="70">대분류 </th>
                    <td width="75">
                      <comment id="_NSID_">
                        <object id=LC_O_EVENT_L_CD_T classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="70">중분류</th>
                    <td width="75">
                      <comment id="_NSID_">
                        <object id=LC_O_EVENT_M_CD_T classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>소분류 </th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=LC_O_EVENT_S_CD_T classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle"></object>
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
                      <object id=TV_MAIN classid=<%=Util.CLSID_TREEVIEW%> height=428 width=100% >
                        <param name=DataID          value="DS_TREE_MAIN">        <!-- Bind할 DataSet의 ID -->
                        <param name=TextColumn      value="V_EVENT_THME_NAME">            <!-- 컨텐츠 -->
                        <param name=LevelColumn     value="EVENT_THME_LEVEL">            <!-- 레벨 -->
                        <param name=UseImage        value="false">
                        <param name=ExpandLevel     value="1">
                        <param name=BorderStyle     value="0">
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
                <td class="sub_title PB03 PT05" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 테마정보</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="60" class="point">테마코드 </th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_EVENT_THME_CD classid=<%=Util.CLSID_EMEDIT%> width=167 tabindex=1 align="absmiddle"></object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th width="60" class="point">대분류 </th>
                    <td width="170">
                      <comment id="_NSID_">
                        <object id=EM_EVENT_L_CD classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_EVENT_L_NAME classid=<%=Util.CLSID_EMEDIT%> width=124 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th width="60" class="point">중분류</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_EVENT_M_CD classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_EVENT_M_NAME classid=<%=Util.CLSID_EMEDIT%> width=127 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th width="60" class="point">소분류 </th>
                    <td width="170">
                      <comment id="_NSID_">
                        <object id=EM_EVENT_S_CD classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_EVENT_S_NAME classid=<%=Util.CLSID_EMEDIT%> width=124 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th width="60" class="point" >테마명 </th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_EVENT_THME_NAME classid=<%=Util.CLSID_EMEDIT%> width=170 tabindex=1 align="absmiddle"></object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th width="60" class="point">사용여부 </th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=170 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th width="60" >비고 </th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%> width=420 tabindex=1 align="absmiddle"></object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          </table></td>
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
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
        <param name=DataID          value=DS_TREE_MAIN>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>col=EVENT_THME_CD       ctrl=EM_EVENT_THME_CD        param=Text </c>
            <c>col=EVENT_THME_NAME     ctrl=EM_EVENT_THME_NAME      param=Text </c>
            <c>col=EVENT_L_CD          ctrl=EM_EVENT_L_CD           param=Text </c>
            <c>col=EVENT_L_NAME        ctrl=EM_EVENT_L_NAME         param=Text </c>
            <c>col=EVENT_M_CD          ctrl=EM_EVENT_M_CD           param=Text </c>
            <c>col=EVENT_M_NAME        ctrl=EM_EVENT_M_NAME         param=Text </c>
            <c>col=EVENT_S_CD          ctrl=EM_EVENT_S_CD           param=Text </c>
            <c>col=EVENT_S_NAME        ctrl=EM_EVENT_S_NAME         param=Text </c>
            <c>col=REMARK              ctrl=EM_REMARK               param=Text </c>
            <c>col=USE_YN              ctrl=LC_USE_YN               param=BindColVal </c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
