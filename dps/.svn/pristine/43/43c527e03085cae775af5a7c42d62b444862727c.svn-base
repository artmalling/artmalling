<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 품목코드> 품목코드관리
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod4010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 품목정보를 관리한다
 * 이    력 :
 *        2010.01.17 (정진영) 신규작성
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
    DS_STRPMKPRFRT.setDataHeader('<gauce:dataset name="H_SEL_STRPMKPRFRT"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_PUMMOK_CD, "CODE^8", READ);  //품목코드 
    initEmEdit(EM_PUMMOK_SRT_CD, "CODE^4^0", READ);  //품목단축코드
    initEmEdit(EM_PUMMOK_NAME, "GEN^40", PK);  //품목명 
    initEmEdit(EM_RECP_NAME, "GEN^20", PK);  //영수증명
    initEmEdit(EM_L_CD, "CODE^2", PK);  //대분류 
    initEmEdit(EM_L_NAME, "GEN^40", READ);  //대분류 
    initEmEdit(EM_M_CD, "CODE^2", PK);  //중분류
    initEmEdit(EM_M_NAME, "GEN^40", READ);  //중분류
    initEmEdit(EM_S_CD, "CODE^2", PK);  //소분류 
    initEmEdit(EM_S_NAME, "GEN^40", READ);  //소분류 
    initEmEdit(EM_D_CD, "CODE^2", PK);  //세분류
    initEmEdit(EM_D_NAME, "GEN^40", READ);  //세분류

    //콤보 초기화
	initComboStyle(LC_O_L_CD    , DS_O_L_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //대분류(조회)
	initComboStyle(LC_O_M_CD    , DS_O_M_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //중분류(조회)
	initComboStyle(LC_O_S_CD    , DS_O_S_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //소분류(조회)
	initComboStyle(LC_I_L_CD    , DS_I_L_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //대분류 
	initComboStyle(LC_I_M_CD    , DS_I_M_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //중분류
	initComboStyle(LC_I_S_CD    , DS_I_S_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //소분류  
	initComboStyle(LC_I_D_CD    , DS_I_D_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //세분류
	initComboStyle(LC_I_TAG_FLAG, DS_I_TAG_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //택구분
	initComboStyle(LC_I_UNIT_CD , DS_I_UNIT_CD , "CODE^0^30,NAME^0^80", 1, NORMAL);  //단위코드
	initComboStyle(LC_I_FRESH_YN, DS_I_FRESH_YN, "CODE^0^30,NAME^0^80", 1, PK);  //신선식품여부 
	initComboStyle(LC_I_FCL_FLAG, DS_I_FCL_FLAG, "CODE^0^30,NAME^0^80", 1, PK);  //시설구분
	
	//시스템 코드 공통코드에서 가지고 오기( popup.js )
	getEtcCode("DS_I_TAG_FLAG", "D", "P063", "N");
	getEtcCode("DS_I_UNIT_CD", "D", "P013", "N");
	getEtcCode("DS_I_FRESH_YN", "D", "D022", "N");
	getEtcCode("DS_I_FCL_FLAG", "D", "P034", "N");
	
	insComboFirstNullId(LC_I_TAG_FLAG,'');
	insComboFirstNullId(LC_I_UNIT_CD,'');
	//품목 대분류 가지고 오기( popup_dps.js )
	getPmkLCode("DS_O_L_CD", "Y");
	//점콤보 가져오기 ( popup_dps.js )
	getStore("DS_I_STR_CD", "N", "", "N");
	
	//콤보데이터 기본값 설정( gauce.js )
	setComboData(LC_O_L_CD,"%");
	
	enableControl(IMG_ROW_ADD,false);
	enableControl(IMG_ROW_DEL,false);  
	inputCmpMode('R');
	
	//사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
	registerUsingDataset("pcod401","DS_TREE_MAIN,DS_STRPMKPRFRT" );
	
	LC_O_L_CD.Focus();   
	
	// 화면 로드시 조회 2010-06-15 적용 >> 2016-09-08 자동조회 주석 처리.
	//btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"           width=30   align=center</FC>'
                     + '<FC>id=STR_CD          name="점"           width=110   align=left Edit={IF(SysStatus="I","true","false")} EditStyle=Lookup data="DS_I_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=GOAL_PROF_RATE  name="목표이익율"    width=110  edit="RealNumeric" align=right Edit={IF(APP_S_DT>="'+getTodayFormat("YYYYMMDD")+'" ,"true","false")}</FC>'
                     + '<FC>id=APP_S_DT        name="적용시작일"    width=110  edit="Numeric"  align=center mask="XXXX/XX/XX" EditStyle=Popup edit={IF(APP_S_DT="","true",IF(Status="I" AND SysStatus="I" ,"true",IF(APP_S_DT>="'+getTodayFormat("YYYYMMDD")+'" AND APP_E_DT="99991231" AND Status<>"I","true","false")))}</FC>'
                     + '<FC>id=APP_E_DT        name="적용종료일"    width=110   align=center mask="XXXX/XX/XX" edit="none"</FC>';
 
    initGridStyle(GD_STRPMKPRFRT, "common", hdrProperies, true);
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
        	EM_PUMMOK_NAME.Focus();
            return false;
        }
    }

    DS_STRPMKPRFRT.ClearData();
    DS_TREE_MAIN.ClearData();

    var strLCd   = LC_O_L_CD.BindColVal;
    var strMCd   = LC_O_M_CD.BindColVal;
    var strSCd   = LC_O_S_CD.BindColVal;

    var goTo       = "searchTreeMaster" ;    
    var action     = "O";     
    var parameters = "&strLCd="+encodeURIComponent(strLCd)
                   + "&strMCd="+encodeURIComponent(strMCd)
                   + "&strSCd="+encodeURIComponent(strSCd);
    TR_MAIN.Action="/dps/pcod401.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_TREE_MAIN=DS_TREE_MAIN)"; //조회는 O
    TR_MAIN.Post();

    //조회후 결과표시
    setPorcCount("SELECT",DS_TREE_MAIN.CountRow);  
    getTreeToCombo(DS_I_L_CD,'1');
    setComboData(LC_I_L_CD,'%');
    
    TV_MAIN.Focus();
    TV_MAIN.Index = 1;
    
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	if(DS_TREE_MAIN.CountRow < 1){
        // 조회 후 신규 등록이 가능합니다.
        showMessage(INFORMATION, OK, "USER-1025");
        LC_O_L_CD.Focus();
        return;
	}
    var insRow = DS_TREE_MAIN.RowPosition;
    if( DS_TREE_MAIN.RowStatus(insRow)=='1'){
    	// 초기화하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
        	EM_PUMMOK_NAME.Focus();
            return;
        }
        DS_STRPMKPRFRT.ClearData();
        DS_TREE_MAIN.DeleteRow(insRow);
    }else{
        insRow = insRow+1;    	
    }
    if( DS_TREE_MAIN.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
            EM_PUMMOK_NAME.Focus();        	
        	return;
        }
        DS_STRPMKPRFRT.ClearData();
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
	
	if( !DS_TREE_MAIN.IsUpdated && !DS_STRPMKPRFRT.IsUpdated){
		// 저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        
        if( DS_TREE_MAIN.CountRow > 0)
        	TV_MAIN.Focus();
        else
        	LC_O_L_CD.Focus();
        
        return;
	}
	//품목 필수 입력체크 
	if(!checkPmkValidation())
        return;
    //점별목표수익율 필수 입력체크 
    if(!checkStrpmkprfrtValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_PUMMOK_NAME.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
		EM_PUMMOK_NAME.Focus();
        return;
	}
	var savePummokCd = getSavePummokCd();   
	DS_STRPMKPRFRT.ResetUserStatus();
	btnSaveClick = true;
    TR_MAIN.Action="/dps/pcod401.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_TREE_MAIN=DS_TREE_MAIN,I:DS_STRPMKPRFRT=DS_STRPMKPRFRT)"; 
    TR_MAIN.Post();
    btnSaveClick = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	var sLcd = LC_O_L_CD.BindColVal;
        var sMcd = LC_O_M_CD.BindColVal;
        var sScd = LC_O_S_CD.BindColVal;
        btn_Search();
        var row = DS_TREE_MAIN.NameValueRow("PUMMOK_CD",savePummokCd);
        row = row<1?1:row;
        DS_TREE_MAIN.RowPosition = row;

        getPmkLCode("DS_O_L_CD", "Y");
        setTimeout("setComboData(LC_O_L_CD,'"+sLcd+"');",50);
        setTimeout("setComboData(LC_O_M_CD,'"+sMcd+"');",70);
        setTimeout("setComboData(LC_O_S_CD,'"+sScd+"');",90);
        
        setTimeout("TV_MAIN.Focus();",70);
        setTimeout("TV_MAIN.Index = " + row,70);
    }
    EM_PUMMOK_NAME.Focus();
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
	TV_MAIN.ReDraw = false;
    var lCd = DS_TREE_MAIN.NameValue(row-1, "L_CD");
    var lNm = DS_TREE_MAIN.NameValue(row-1, "L_NM");
    var mCd = DS_TREE_MAIN.NameValue(row-1, "M_CD");
    var mNm = DS_TREE_MAIN.NameValue(row-1, "M_NM");
    var sCd = DS_TREE_MAIN.NameValue(row-1, "S_CD");
    var sNm = DS_TREE_MAIN.NameValue(row-1, "S_NM");
    var dCd = DS_TREE_MAIN.NameValue(row-1, "D_CD");
    var dNm = DS_TREE_MAIN.NameValue(row-1, "D_NM");
    var pummokCd = DS_TREE_MAIN.NameValue(row-1, "PUMMOK_CD"); 
    var pummokLvl = DS_TREE_MAIN.NameValue(row-1, "PUMMOK_LEVEL"); 
    var tagFlag = DS_TREE_MAIN.NameValue(row-1, "TAG_FLAG"); 
    var unitCd = DS_TREE_MAIN.NameValue(row-1, "UNIT_CD"); 
    var freshYn = DS_TREE_MAIN.NameValue(row-1, "FRESH_YN"); 
    var fclFlag = DS_TREE_MAIN.NameValue(row-1, "FCL_FLAG"); 
    
    pummokLvl = pummokLvl < 4 ? (Number(pummokLvl) + 1) : pummokLvl ;
    DS_TREE_MAIN.InsertRow(row);
    if(row != DS_TREE_MAIN.RowPosition){
        DS_TREE_MAIN.InsertRow(row);    	
    }
    
    DS_TREE_MAIN.NameValue(row, "L_CD") = pummokLvl > 1 ? lCd : '';
    DS_TREE_MAIN.NameValue(row, "L_NM") = pummokLvl > 1 ? lNm : '';
    DS_TREE_MAIN.NameValue(row, "M_CD") = pummokLvl > 2 ? mCd : '';
    DS_TREE_MAIN.NameValue(row, "M_NM") = pummokLvl > 2 ? mNm : '';
    DS_TREE_MAIN.NameValue(row, "S_CD") = pummokLvl > 3 ? sCd : '';
    DS_TREE_MAIN.NameValue(row, "S_NM") = pummokLvl > 3 ? sNm : '';
    DS_TREE_MAIN.NameValue(row, "D_CD") = pummokLvl > 4 ? dCd : '';
    DS_TREE_MAIN.NameValue(row, "D_NM") = pummokLvl > 4 ? dNm : '';
    DS_TREE_MAIN.NameValue(row, "P_PUMMOK_CD") = pummokCd;
    DS_TREE_MAIN.NameValue(row, "PUMMOK_LEVEL") = ""+pummokLvl;
    DS_TREE_MAIN.NameValue(row, "PUMMOK_CD")    = ""; 
    DS_TREE_MAIN.NameValue(row, "PUMMOK_NAME")  = ""; 
    DS_TREE_MAIN.NameValue(row, "TAG_FLAG")    = tagFlag; 
    DS_TREE_MAIN.NameValue(row, "UNIT_CD")  = unitCd; 
    DS_TREE_MAIN.NameValue(row, "FRESH_YN")    = freshYn; 
    DS_TREE_MAIN.NameValue(row, "FCL_FLAG")  = fclFlag; 

    if( pummokLvl > 2 ){
        document.getElementById('TH_TAG_FLAG').className = "point";
        document.getElementById('TH_UNIT_CD').className = "point";
        setObjTypeStyle( LC_I_TAG_FLAG, "COMBO", PK );
        setObjTypeStyle( LC_I_UNIT_CD, "COMBO", PK );
    }else{
        document.getElementById('TH_TAG_FLAG').className = "";
        document.getElementById('TH_UNIT_CD').className = "";
        setObjTypeStyle( LC_I_TAG_FLAG, "COMBO", NORMAL );
        setObjTypeStyle( LC_I_UNIT_CD, "COMBO", NORMAL );
    }
    inputCmpMode('I');
    
    TV_MAIN.ReDraw = true;
    EM_PUMMOK_NAME.Focus();
}
/**
* searchStrpmkprfrt()
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-09
* 개    요 :  점별 목표이익율 조회
* return값 : void
*/
function searchStrpmkprfrt(){
	var strPummokCd = EM_PUMMOK_CD.Text;
	
	DS_STRPMKPRFRT.ClearData();

    var goTo       = "searchStrpmkprfrt" ;    
    var action     = "O";     
    var parameters = "&strPummokCd="+encodeURIComponent(strPummokCd);
    TR_SUB.Action="/dps/pcod401.pc?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_STRPMKPRFRT=DS_STRPMKPRFRT)"; //조회는 O
    TR_SUB.Post();
}
/**
* btn_addRow()
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-09
* 개    요 :  점별 목표이익율 행추가
* return값 : void
*/
function btn_addRow(){

    if( DS_TREE_MAIN.RowPosition < 1){
        showMessage(INFORMATION, OK, "USER-1025");
        LC_O_L_CD.Focus();
        return;
    } 
	if(DS_STRPMKPRFRT.CountRow > 0){
		for(var i=1; i<=DS_STRPMKPRFRT.CountRow; i++){
			if( DS_STRPMKPRFRT.SysStatus(i)=='1'){
		        // 신규데이터 입력은 1건만 가능합니다.
		        showMessage(EXCLAMATION, OK, "USER-1078");
		        setFocusGrid( GD_STRPMKPRFRT,DS_STRPMKPRFRT, i, "STR_CD");
		        return;
			}
		}
		
	    for(var i = 1; i <= DS_STRPMKPRFRT.CountRow; i++ ) {
	    	DS_STRPMKPRFRT.UserStatus(i) = 1;
	    }
	}
    var strPummokCd = EM_PUMMOK_CD.Text;
    DS_STRPMKPRFRT.AddRow();
    DS_STRPMKPRFRT.NameValue(DS_STRPMKPRFRT.CountRow, "PUMMOK_CD") = strPummokCd;
    DS_STRPMKPRFRT.NameValue(DS_STRPMKPRFRT.CountRow, "APP_S_DT") = "";
    DS_STRPMKPRFRT.NameValue(DS_STRPMKPRFRT.CountRow, "APP_E_DT") = "99991231";
    setFocusGrid( GD_STRPMKPRFRT,DS_STRPMKPRFRT, DS_STRPMKPRFRT.CountRow, "STR_CD");
    
}

/**
* btn_delRow()
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-09
* 개    요 :    점별 목표이익율 행삭제
* return값 : void
*/
function btn_delRow(){
    if( DS_STRPMKPRFRT.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        TV_MAIN.Focus();
        return;
    }
    
    if( DS_STRPMKPRFRT.SysStatus(DS_STRPMKPRFRT.RowPosition) != "1"){
        showMessage(INFORMATION, OK, "USER-1052");
        GD_STRPMKPRFRT.Focus();
        return;
    }
	DS_STRPMKPRFRT.DeleteRow(DS_STRPMKPRFRT.RowPosition);
	DS_STRPMKPRFRT.ResetUserStatus();
	
}

/**
* getTreeToCombo()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  트리 데이터를 이용하여 콤보 데이터를 구성한다.
* 사용법: getTreeToCombo(dataSet,lvl,lCd,mCd,sCd)
*        dataSet --> 콤보데이터셋
*        lvl     --> 구성할 품목 레벨
*        lCd     --> 대분류코드
*        mCd     --> 중분류코드
*        sCd     --> 소분류코드
* return값 : void
*/
function getTreeToCombo(dataSet,lvl,lCd,mCd,sCd){

	dataSet.ClearAll();
	dataSet.setDataHeader('PUMMOK_CD:STRING(8),CODE:STRING(2),NAME:STRING(40)');
    dataSet.Addrow();
    dataSet.NameValue(1, "CODE") = "%";
    dataSet.NameValue(1, "NAME") = "전체";
    for( var i = 1 ; i <= DS_TREE_MAIN.CountRow; i++) {
        var pummokLvl = DS_TREE_MAIN.NameValue(i, "PUMMOK_LEVEL");
        if( lvl == pummokLvl ) {
            var pummokCd = DS_TREE_MAIN.NameValue(i, "PUMMOK_CD");
            var pummokNm = DS_TREE_MAIN.NameValue(i, "PUMMOK_NAME");
            var pummokLCd = DS_TREE_MAIN.NameValue(i, "L_CD");
            var pummokMCd = DS_TREE_MAIN.NameValue(i, "M_CD");
            var pummokSCd = DS_TREE_MAIN.NameValue(i, "S_CD");
            var pummokDCd = DS_TREE_MAIN.NameValue(i, "D_CD");
            if( (lCd!=null?pummokLCd==lCd:true)
            	&& (mCd!=null?pummokMCd==mCd:true)
            	&& (sCd!=null?pummokSCd==sCd:true)){
            	
                dataSet.Addrow();
                dataSet.NameValue(dataSet.CountRow, "CODE")  = lCd==null?pummokLCd:(mCd==null?pummokMCd:(sCd==null?pummokSCd:pummokDCd));
                dataSet.NameValue(dataSet.CountRow, "NAME")  = pummokNm;
                dataSet.NameValue(dataSet.CountRow, "PUMMOK_CD")  = pummokCd;
            	
            }
            	
        }
    }
}

/**
 * inputCmpMode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  품목정복 입력 컨트롤을 제어
 * return값 : void
 */
function inputCmpMode( mode ){
	var upd  = mode=="R"?false:true;
	var ins  = mode!="I"?false:true;
	var read = false;
	var pmkLvl = DS_TREE_MAIN.NameValue( DS_TREE_MAIN.RowPosition, "PUMMOK_LEVEL");
	
    enableControl2(EM_PUMMOK_CD, read);
    enableControl2(EM_PUMMOK_SRT_CD, read);
    enableControl2(EM_PUMMOK_NAME, upd);  //품목명 
    enableControl2(EM_RECP_NAME, upd);  //영수증명
    enableControl2(EM_L_CD,  pmkLvl==1?ins:false);  //대분류 
    enableControl2(EM_L_NAME, read);  //대분류 
    enableControl2(EM_M_CD, pmkLvl==2?ins:false);  //중분류
    enableControl2(EM_M_NAME, read);  //중분류
    enableControl2(EM_S_CD, pmkLvl==3?ins:false);  //소분류 
    enableControl2(EM_S_NAME, read);  //소분류 
    enableControl2(EM_D_CD, pmkLvl==4?ins:false);  //세분류
    enableControl2(EM_D_NAME, read);  //세분류
    enableControl2(LC_I_TAG_FLAG, upd);  //택구분
    enableControl2(LC_I_UNIT_CD , upd);  //단위코드
    enableControl2(LC_I_FRESH_YN, ins);  //신선식품여부 
    enableControl2(LC_I_FCL_FLAG, upd);  //시설구분
}
/**
 * checkPmkValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  트리 DataSet 의  입력을 체크한다.
 * return값 : void
 */
function checkPmkValidation(){
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

        if( DS_TREE_MAIN.NameValue( i, "PUMMOK_NAME") == ''){
            check = true;
            titleNm = "품목명";
            componentId = "EM_PUMMOK_NAME";
            row = i;
            break;
        }
        if( !checkInputByte( null, DS_TREE_MAIN, i, "PUMMOK_NAME", "품목명", "EM_PUMMOK_NAME") )
            return false;

        if( DS_TREE_MAIN.NameValue( i, "RECP_NAME") == ''){
            check = true;
            titleNm = "영수증명";
            componentId = "EM_RECP_NAME";
            row = i;
            break;
        }
        if( !checkInputByte( null, DS_TREE_MAIN, i, "RECP_NAME", "영수증명", "EM_RECP_NAME") )
            return false;
        
        var pummokLvl = DS_TREE_MAIN.NameValue( i, "PUMMOK_LEVEL");
        
        if( rowStatus == 1){
        	
            if( pummokLvl == 1 && DS_TREE_MAIN.NameValue( i, "L_CD") == ''){
                check = true;
                titleNm = "대분류";
                componentId = "EM_L_CD";
                row = i;
                break;
            }
            if( pummokLvl == 1 && DS_TREE_MAIN.NameValue( i, "L_CD") == '00' ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "대분류 코드","00");
                EM_L_CD.Focus();
                return false;                    
            }

            if( pummokLvl == 2 && DS_TREE_MAIN.NameValue( i, "M_CD") == ''){
                check = true;
                titleNm = "중분류";
                componentId = "EM_M_CD";
                row = i;
                break;
            }
            if( pummokLvl == 2 && DS_TREE_MAIN.NameValue( i, "M_CD") == '00' ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "중분류 코드","00");
                EM_M_CD.Focus();
                return false;                    
            }

            if( pummokLvl == 3 && DS_TREE_MAIN.NameValue( i, "S_CD") == ''){
                check = true;
                titleNm = "소분류";
                componentId = "EM_S_CD";
                row = i;
                break;
            }
            if( pummokLvl == 3 && DS_TREE_MAIN.NameValue( i, "S_CD") == '00' ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "소분류 코드","00");
                EM_S_CD.Focus();
                return false;                    
            }

            if( pummokLvl == 4 && DS_TREE_MAIN.NameValue( i, "D_CD") == ''){
                check = true;
                titleNm = "세분류";
                componentId = "EM_D_CD";
                row = i;
                break;
            }
            if( pummokLvl == 3 && DS_TREE_MAIN.NameValue( i, "D_CD") == '00' ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "세분류 코드","00");
                EM_D_CD.Focus();
                return false;                    
            }
            
            if( DS_TREE_MAIN.NameValue( i, "FRESH_YN") == ''){
                check = true;
                titleNm = "신선식품여부";
                componentId = "LC_I_FRESH_YN";
                row = i;
                break;
            }
        }
        if( pummokLvl >= 3 && DS_TREE_MAIN.NameValue( i, "TAG_FLAG") == ''){
            check = true;
            titleNm = "택 구분";
            componentId = "LC_I_TAG_FLAG";
            row = i;
            break;
        }
        
        if( pummokLvl >= 3 && DS_TREE_MAIN.NameValue( i, "UNIT_CD") == ''){
            check = true;
            titleNm = "단위 구분";
            componentId = "LC_I_UNIT_CD";
            row = i;
            break;
        }
        
        if( DS_TREE_MAIN.NameValue( i, "FCL_FLAG") == ''){
            check = true;
            titleNm = "시설구분";
            componentId = "LC_I_FCL_FLAG";
            row = i;
            break;
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
 * checkStrpmkprfrtValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  점별목표이익율 DataSet 의  입력을 체크한다.
 * return값 : void
 */
function checkStrpmkprfrtValidation(){
	var check = false;
	var titleNm = "";
	var colId = "";
    var row = 0;
	
	for(var i = 1; i <= DS_STRPMKPRFRT.CountRow; i++ ) {
		var rowStatus = DS_STRPMKPRFRT.SysStatus(i);
		if( rowStatus == 0 
	        || rowStatus == 2
	        || rowStatus == 4)
	        continue;
		
        if( DS_STRPMKPRFRT.NameValue( i, "STR_CD") == ''){
            check = true;
            titleNm = "점";
            colId = "STR_CD";
            row = i;
            break;
        }
        if( DS_STRPMKPRFRT.NameString( i, "GOAL_PROF_RATE") == ''){
            check = true;
            titleNm = "목표이익율";
            colId = "GOAL_PROF_RATE";
            row = i;
            break;
        }

        if( parseInt(DS_STRPMKPRFRT.NameString( i, "GOAL_PROF_RATE")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "목표이익율","0");
            setFocusGrid(GD_STRPMKPRFRT,DS_STRPMKPRFRT,i,'GOAL_PROF_RATE');
            return false;                    
        }
        
        if( DS_STRPMKPRFRT.NameValue( i, "APP_S_DT") == ''){
            check = true;
            titleNm = "적용시작일";
            colId = "APP_S_DT";
            row = i;
            break;
        }
        if( DS_STRPMKPRFRT.NameValue( i, "APP_E_DT") == ''){
            check = true;
            titleNm = "적용종료일";
            colId = "APP_E_DT";
            row = i;
            break;
        }
        if ( DS_STRPMKPRFRT.NameValue( i, "APP_S_DT") > DS_STRPMKPRFRT.NameValue( i, "APP_E_DT")) {
            showMessage(EXCLAMATION, Ok,  "USER-1009", "적용시작일","적용종료일");    
            setFocusGrid(GD_STRPMKPRFRT,DS_STRPMKPRFRT,i,'APP_S_DT');
            return false;
        }
        if( DS_STRPMKPRFRT.NameValue( i, "APP_E_DT") == '99991231'){
        	
            var maxAppSDt = getMaxData( DS_STRPMKPRFRT, "APP_S_DT", rowStatus!='1', "STR_CD",DS_STRPMKPRFRT.NameValue(i,"STR_CD"));
            var maxRow = getNameValueRow(DS_STRPMKPRFRT, "STR_CD||APP_S_DT", (DS_STRPMKPRFRT.NameValue(i,"STR_CD")+"||"+maxAppSDt));
            if( maxRow != i ){
                showMessage(EXCLAMATION, Ok,  "USER-1000", "데이터의 [적용시작일]은 동일 점에서 가장 큰 [적용시작일] 이어야 합니다.");   
                setFocusGrid(GD_STRPMKPRFRT,DS_STRPMKPRFRT,i,"APP_S_DT");
                return false;    
            }
        }
	}

    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_STRPMKPRFRT,DS_STRPMKPRFRT,row,colId);
        return false;
    }
	return true;
}


/**
 * getSavePummokCd()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  저장할 품목 코드를 조회한다.
 * return값 : String
 */
function getSavePummokCd(){
    if(DS_TREE_MAIN.IsUpdated){
        for(var i = 1; i <= DS_TREE_MAIN.CountRow; i++ ) {
            var rowStatus = DS_TREE_MAIN.RowStatus(i);
            if( rowStatus == 0 
                    || rowStatus == 2
                    || rowStatus == 4)
                    continue;
            if(rowStatus == 1){
            	var pummokCd = DS_TREE_MAIN.NameValue( i, "L_CD");
                pummokCd += DS_TREE_MAIN.NameValue( i, "M_CD")==''?'00':DS_TREE_MAIN.NameValue( i, "M_CD");
                pummokCd += DS_TREE_MAIN.NameValue( i, "S_CD")==''?'00':DS_TREE_MAIN.NameValue( i, "S_CD");
                pummokCd += DS_TREE_MAIN.NameValue( i, "D_CD")==''?'00':DS_TREE_MAIN.NameValue( i, "D_CD");
                return pummokCd;
            }
            return DS_TREE_MAIN.NameValue( i, "PUMMOK_CD");
        }
    }
    if(DS_STRPMKPRFRT.IsUpdated){
        return DS_STRPMKPRFRT.NameValue( 1, "PUMMOK_CD");
    	
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

<script language=JavaScript for=DS_TREE_MAIN event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
    	return;
    if(this.RowMark(row) == '1'){
        this.RowMark(row) = '0';
        EM_PUMMOK_NAME.Focus();
        tvClick = false;
        return false;
    }
    if(DS_STRPMKPRFRT.IsUpdated ){
    	// 변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
        	setFocusGrid(GD_STRPMKPRFRT,DS_STRPMKPRFRT,DS_STRPMKPRFRT.RowPosition,"STR_CD");
            if(tvClick)
                this.RowMark(row) = '1';
            return false;
        }
        DS_STRPMKPRFRT.UndoAll();
    }
    if( this.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            if(tvClick)
                this.RowMark(row) = '1';
            EM_PUMMOK_NAME.Focus();
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

    GD_STRPMKPRFRT.Editable = false; 
    enableControl(IMG_ROW_ADD,false);
    enableControl(IMG_ROW_DEL,false);  
    if(row == 1){
    	DS_STRPMKPRFRT.ClearData();
    	inputCmpMode("R");
    	return;
    }
    
    if( this.RowStatus(row)=="1"){
    	inputCmpMode("I");
    }else{
    	inputCmpMode("U");
    }
    
    var freshYn = this.NameValue(row, "FRESH_YN");
    var pummokLvl = this.NameValue(row, "PUMMOK_LEVEL");
    // 소,세 에서 세만으로 변경 2010.06.21
    if( pummokLvl > 3 ){
    	document.getElementById('TH_TAG_FLAG').className = "point";
        document.getElementById('TH_UNIT_CD').className = "point";
    	setObjTypeStyle( LC_I_TAG_FLAG, "COMBO", PK );
        setObjTypeStyle( LC_I_UNIT_CD, "COMBO", PK );
    	if(freshYn == 'Y'){
            GD_STRPMKPRFRT.Editable = true;
            enableControl(IMG_ROW_ADD,true);
            enableControl(IMG_ROW_DEL,true);
    	}
    }else{
        document.getElementById('TH_TAG_FLAG').className = "";
        document.getElementById('TH_UNIT_CD').className = "";
        setObjTypeStyle( LC_I_TAG_FLAG, "COMBO", NORMAL );
        setObjTypeStyle( LC_I_UNIT_CD, "COMBO", NORMAL );
    }
    
    
    searchStrpmkprfrt();
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=DS_STRPMKPRFRT event=OnColumnChanged(row,colid)>
<!--//데이터셋의 값이 변경되었을때 처리 루틴
    switch(colid){
        case "STR_CD" :
        case "APP_S_DT" :
        	
            var checkValue = this.NameValue(row,colid);
            // 신규입력을 제외 최고의 적용시작일 
            var maxAppSDt = getMaxData( DS_STRPMKPRFRT, "APP_S_DT", true, "STR_CD",this.NameValue(row,"STR_CD"));
           
            if( checkValue == "" )
            	return;
            
            // 신규 입력이면서 점을 변경 시 적용시작일을 변경
            if(this.RowStatus(row)=="1" && colid == 'STR_CD'){
                var tmpMaxSdt =  getMaxData( DS_STRPMKPRFRT, "APP_S_DT", true, "STR_CD",this.NameValue(row,"STR_CD"));
                var todayAdd = getTodayFormat("YYYYMMDD");
                this.NameValue(row,"APP_S_DT") = (tmpMaxSdt =='' || tmpMaxSdt < getTodayFormat("YYYYMMDD"))?todayAdd:getRawData(addDate('D',1,tmpMaxSdt));
                return true;
            }
            
            // 입력 데이터의 중복 체크
            var dupRow = checkDupKey(this, "STR_CD||APP_S_DT");
            if (dupRow > 0) {
                showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);      
                var tmpMaxSdt =  getMaxData( DS_STRPMKPRFRT, "APP_S_DT", true, "STR_CD",this.NameValue(row,"STR_CD"));
                var todayAdd = getTodayFormat("YYYYMMDD");
                this.NameValue(row,"APP_S_DT") = (tmpMaxSdt =='' || tmpMaxSdt < getTodayFormat("YYYYMMDD"))?todayAdd:getRawData(addDate('D',1,tmpMaxSdt));
                setTimeout("setFocusGrid(GD_STRPMKPRFRT, DS_STRPMKPRFRT,"+row+",'APP_S_DT' );",50);
                return false;
            }
            
            // 적용시작일 수정시               
            if( colid == "APP_S_DT"){
            	// 세로운 적용시작일을 조회
                var newMaxAppSDt = getRawData(addDate('D',1,maxAppSDt));
                var toDay = getTodayFormat("YYYYMMDD");
                // 날짜형식인지 체크
                if(!checkDateTypeYMD(GD_STRPMKPRFRT,'APP_S_DT',this.RowStatus(row)!="1"?maxAppSDt:(maxAppSDt==''||maxAppSDt<toDay)?toDay:newMaxAppSDt))
                    return false;
                // 적용시작일이 오늘 보다 이전일 경우 에러
                if( this.NameValue(row,"APP_S_DT") < toDay){
                    showMessage(EXCLAMATION, Ok,  "USER-1030", "적용시작일");
                    if( this.RowStatus(row)!="1"){
                        this.NameValue(row,"APP_S_DT") = this.OrgNameValue(row,"APP_S_DT");
                    }else{
                        this.NameValue(row,"APP_S_DT") = (maxAppSDt==''||maxAppSDt<toDay)?toDay:newMaxAppSDt;
                    }
                    setTimeout("setFocusGrid(GD_STRPMKPRFRT, DS_STRPMKPRFRT,"+row+",'APP_S_DT' );",50);
                    return false;
                }                
                
                // 적용 시작일이 적용 종료일보다 작을 경우 에러 
                if ( checkValue > this.NameValue(row,"APP_E_DT") && this.NameValue(row,"APP_E_DT") !='') {
                    showMessage(EXCLAMATION, Ok,  "USER-1009", "적용시작일","적용종료일");    
                    if( this.RowStatus(row)!="1"){
                        this.NameValue(row,"APP_S_DT") = this.OrgNameValue(row,"APP_S_DT");
                    }else{
                        this.NameValue(row,"APP_S_DT") = (maxAppSDt==''||maxAppSDt<toDay)?toDay:newMaxAppSDt;
                    }
                    setTimeout("setFocusGrid(GD_STRPMKPRFRT, DS_STRPMKPRFRT,"+row+",'APP_S_DT' );",50);
                    return false;
                }
                
                // 적용시작일이 변경 되었을 경우 신규추가 제한
                if( this.OrgNameValue(row,"APP_S_DT") == checkValue){
                    enableControl(IMG_ROW_ADD,true);
                    enableControl(IMG_ROW_DEL,true);
                }else{
                    enableControl(IMG_ROW_ADD,false);
                    enableControl(IMG_ROW_DEL,false);       
                }
            }
            
            // 입력 값을 적용 시작일이 가장 큰 적용 시작일인지 체크
            maxAppSDt = getMaxData( DS_STRPMKPRFRT, "APP_S_DT", false, "STR_CD",this.NameValue(row,"STR_CD"));
            if( maxAppSDt != ''){
                var maxRow = getNameValueRow(this, "STR_CD||APP_S_DT", (this.NameValue(row,"STR_CD")+"||"+maxAppSDt));
                if( maxRow != row){
                    showMessage(EXCLAMATION, Ok,  "USER-1000", "데이터의 [적용시작일]은 동일 점에서 가장 큰 [적용시작일] 이어야 합니다.");   
                    this.NameValue(row,"APP_S_DT") = ''; 
                    setTimeout("setFocusGrid(GD_STRPMKPRFRT, DS_STRPMKPRFRT,"+row+",'APP_S_DT' );",50);
                    return false;    
                }
            }
            break;
        case "GOAL_PROF_RATE" :
        	var value = this.NameString(row,'GOAL_PROF_RATE');
        	if( parseInt(value) < 0 ){
                showMessage(EXCLAMATION, Ok,  "USER-1020", "목표이익율","0");

                if( this.RowStatus(row)!="1"){
                    this.NameValue(row,"GOAL_PROF_RATE") = this.OrgNameValue(row,"GOAL_PROF_RATE");
                }else{
                    this.NameValue(row,"GOAL_PROF_RATE") =  0;
                }
                setTimeout("setFocusGrid(GD_STRPMKPRFRT,DS_STRPMKPRFRT,"+row+",'GOAL_PROF_RATE');",50);
                return false;                    
        	}
            break;
        default :
            break;
    }
//-->
</script>

<script language=JavaScript for=TV_MAIN event=OnItemClick(ItemIndex)>
    tvClick = true;
    tbIndex = ItemIndex;
</script>
<script language=JavaScript for=GD_STRPMKPRFRT event=OnPopup(row,colid,data)>
    openCal(this,row,colid);
</script>
<script language=JavaScript for=GD_STRPMKPRFRT event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=LC_I_FRESH_YN event=OnSelChange()>
    if(this.BindColVal=="N"){
    	if(DS_STRPMKPRFRT.IsUpdated){
            if( showMessage(QUESTION, YESNO,  "USER-1000", "신선식품여부가 'N' 이면 <br>입력한 점별 목표이익율이 초기화 됩니다.<br>진행 하시겠습니까?")!= 1){
                setComboData(this,'Y');
            	return;
            }
            DS_STRPMKPRFRT.ClearData();
    	}  	
    }
    
</script>
<script language=JavaScript for=LC_O_L_CD event=OnSelChange()>
    DS_O_M_CD.ClearData();
    DS_O_S_CD.ClearData();
    getPmkMCode("DS_O_M_CD", this.BindColVal, "Y");
    setComboData(LC_O_M_CD,'%');
</script>

<script language=JavaScript for=LC_O_M_CD event=OnSelChange()>
    DS_O_S_CD.ClearData();
    getPmkSCode("DS_O_S_CD", LC_O_L_CD.BindColVal, this.BindColVal, "Y");
    setComboData(LC_O_S_CD,'%');
</script>

<script language=JavaScript for=LC_I_L_CD event=OnSelChange()>
    DS_I_M_CD.ClearData();
    DS_I_S_CD.ClearData();
    DS_I_D_CD.ClearData();
    getTreeToCombo(DS_I_M_CD,'2',LC_I_L_CD.BindColVal);
    setComboData(LC_I_M_CD,'%');
    if(this.BindColVal != '%'){
        DS_TREE_MAIN.RowPosition = DS_TREE_MAIN.NameValueRow( "PUMMOK_CD",this.ValueByColumn("CODE",this.BindColVal, "PUMMOK_CD"));
        TV_MAIN.Focus();
    }
</script>
<script language=JavaScript for=LC_I_M_CD event=OnSelChange()>
    DS_I_S_CD.ClearData();
    DS_I_D_CD.ClearData();
    getTreeToCombo(DS_I_S_CD,'3',LC_I_L_CD.BindColVal,LC_I_M_CD.BindColVal);
    setComboData(LC_I_S_CD,'%');
    if(this.BindColVal != '%'){
        DS_TREE_MAIN.RowPosition = DS_TREE_MAIN.NameValueRow( "PUMMOK_CD",this.ValueByColumn("CODE",this.BindColVal, "PUMMOK_CD"));
        TV_MAIN.Focus();
    }
</script>
<script language=JavaScript for=LC_I_S_CD event=OnSelChange()>
    DS_I_D_CD.ClearData();
    getTreeToCombo(DS_I_D_CD,'4',LC_I_L_CD.BindColVal,LC_I_M_CD.BindColVal,LC_I_S_CD.BindColVal);
    setComboData(LC_I_D_CD,'%');
    if(this.BindColVal != '%'){
        DS_TREE_MAIN.RowPosition = DS_TREE_MAIN.NameValueRow( "PUMMOK_CD",this.ValueByColumn("CODE",this.BindColVal, "PUMMOK_CD"));
        TV_MAIN.Focus();
    }
</script>
<script language=JavaScript for=LC_I_D_CD event=OnSelChange()>
    if(this.BindColVal != '%'){
        DS_TREE_MAIN.RowPosition = DS_TREE_MAIN.NameValueRow( "PUMMOK_CD",this.ValueByColumn("CODE",this.BindColVal, "PUMMOK_CD"));
        TV_MAIN.Focus();
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
<comment id="_NSID_"><object id="DS_O_L_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_M_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_I_L_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_M_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_S_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_D_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_TAG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_UNIT_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_FRESH_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_FCL_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_STRPMKPRFRT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TREE_MAIN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_O_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">중분류</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_O_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">소분류</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_S_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
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
                        <object id=LC_I_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="70">중분류</th>
                    <td width="75">
                      <comment id="_NSID_">
                        <object id=LC_I_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>소분류 </th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_I_S_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th>세분류</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_I_D_CD classid=<%= Util.CLSID_LUXECOMBO %> width=75 tabindex=1 align="absmiddle">
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
                      <object id=TV_MAIN classid=<%=Util.CLSID_TREEVIEW%> height=458 width=100% >
                        <param name=DataID          value="DS_TREE_MAIN">    <!-- Bind할 DataSet의 ID -->
                        <param name=TextColumn      value="V_PUMMOK_NAME">            <!-- 컨텐츠 -->
                        <param name=LevelColumn     value="PUMMOK_LEVEL">            <!-- 레벨 -->
                        <param name=UseImage        value="false">
                        <param name=ExpandLevel     value="2">
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
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 품목정보</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="80" class="point">품목코드 </th>
                    <td width="140">
                      <comment id="_NSID_">
                        <object id=EM_PUMMOK_CD classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                    <th width="80" class="point">품목단축코드</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_PUMMOK_SRT_CD classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point" >품목명 </th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_PUMMOK_NAME classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                    <th class="point">영수증명</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_RECP_NAME classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">대분류 </th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_L_CD classid=<%=Util.CLSID_EMEDIT%> width=35 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_L_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th class="point">중분류</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_M_CD classid=<%=Util.CLSID_EMEDIT%> width=35 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_M_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">소분류 </th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_S_CD classid=<%=Util.CLSID_EMEDIT%> width=35 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_S_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th class="point">세분류</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_D_CD classid=<%=Util.CLSID_EMEDIT%> width=35 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_D_NAME classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th id=TH_TAG_FLAG>택구분</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_I_TAG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th id=TH_UNIT_CD>단위코드</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_I_UNIT_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">신선식품여부 </th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_I_FRESH_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">시설구분</th>
                    <td>
                      <comment id="_NSID_">
                        <object id=LC_I_FCL_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 점별 목표이익율</td>
                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ROW_ADD onclick="javascript:btn_addRow();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_ROW_DEL onclick="javascript:btn_delRow();""/>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                    <tr>
                      <td>
                        <comment id="_NSID_"><object id=GD_STRPMKPRFRT width="100%" height=306 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_STRPMKPRFRT">
                        </object></comment><script>_ws_(_NSID_);</script>
                      </td>
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
            <c>col=PUMMOK_CD       ctrl=EM_PUMMOK_CD        param=Text </c>
            <c>col=PUMMOK_NAME     ctrl=EM_PUMMOK_NAME      param=Text </c>
            <c>col=RECP_NAME       ctrl=EM_RECP_NAME        param=Text </c>
            <c>col=PUMMOK_SRT_CD   ctrl=EM_PUMMOK_SRT_CD    param=Text </c>
            <c>col=L_CD            ctrl=EM_L_CD             param=Text </c>
            <c>col=L_NM            ctrl=EM_L_NAME           param=Text </c>
            <c>col=M_CD            ctrl=EM_M_CD             param=Text </c>
            <c>col=M_NM            ctrl=EM_M_NAME           param=Text </c>
            <c>col=S_CD            ctrl=EM_S_CD             param=Text </c>
            <c>col=S_NM            ctrl=EM_S_NAME           param=Text </c>
            <c>col=D_CD            ctrl=EM_D_CD             param=Text </c>
            <c>col=D_NM            ctrl=EM_D_NAME           param=Text </c>
            <c>col=FCL_FLAG        ctrl=LC_I_FCL_FLAG       param=BindColVal </c>
            <c>col=FRESH_YN        ctrl=LC_I_FRESH_YN       param=BindColVal </c>
            <c>col=TAG_FLAG        ctrl=LC_I_TAG_FLAG       param=BindColVal </c>
            <c>col=UNIT_CD         ctrl=LC_I_UNIT_CD        param=BindColVal </c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

