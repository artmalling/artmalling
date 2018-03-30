<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 기준정보 > 기타관리 > 카드별현장할인내역등록
 * 작 성 일 : 2012.07.16
 * 작 성 자 : kj
 * 수 정 자 : 
 * 파 일 명 : pcodD010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2012.07.16 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      	= false;
var bfListRowPosition 	= 0;                             // 이전 List Row Position
var intChangRow       	= 0;
var EXCEL_PARAMS		= "";
var strToday 			= "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	strToday = getTodayDB("DS_O_RESULT");
	    
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); 

    initEmEdit(EM_CCOMP_CD_S,		"00",				READ);	//카드발급사(조회)         
    initEmEdit(EM_CCOMP_NM_S,   	"GEN^20",       	READ);		//카드발급사(조회
    initEmEdit(EM_CCOMP_CD,     	"00",           	READ);         
    initEmEdit(EM_CCOMP_NM,     	"GEN^20",       	READ);
    
    initEmEdit(EM_S_BIN_NO_S,   	"000000",       	PK);       //카드빈(조회)     
    initEmEdit(EM_E_BIN_NO_S,   	"000000",       	PK);       //카드빈(조회)
    initEmEdit(EM_BIN_NO,       	"000000",       	READ);        	
    
    initEmEdit(EM_S_DATE_S, 		"TODAY", 			PK);        //적용일자 F(조회)
    initEmEdit(EM_E_DATE_S, 		"TODAY", 			PK);        //적용일자 T(조회)
    initEmEdit(EM_APP_S_DT,     	"TODAY",       		PK);
    initEmEdit(EM_APP_E_DT,     	"TODAY",       		PK);
    
    initEmEdit(EM_USE_BAS_FR_AMT,   "NUMBER^13^0",     	NORMAL);
    initEmEdit(EM_USE_BAS_TO_AMT,   "NUMBER^13^0",      NORMAL);
    initEmEdit(EM_REDU_AMT,    		"NUMBER^13^0",      NORMAL);
    
    initComboStyle(LC_STR_CD_S,   DS_STR_CD_S,  "CODE^0^30,NAME^0^90", 1, PK);   //점(조회)
    initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);   //점(저장)
    
    // EMedit에 초기화
    getStore("DS_STR_CD", "Y", "", "N");         //점콤보 가져오기 (조회)
    getStore("DS_STR_CD_S", "Y", "", "N");         //점콤보 가져오기 (저장)
    
    LC_STR_CD_S.Index= 0;
    EM_S_BIN_NO_S.Text = "1";
    EM_E_BIN_NO_S.Text = "999999";
    enableControl(IMG_CCOMP_CD, false);

    //LC_STR_CD.Focus();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("pcodD01","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       name="NO"               	width=30      	align=center</FC>'
    				 + '<FC>id=STR_CD         name="점코드"         		width=100     	align=center show=false</FC>'
                     + '<FC>id=STR_NM         name="점"         			width=100     	align=center</FC>'
                     + '<FC>id=CCOMP_NM       name="카드발급사"        	width=100    	align=left</FC>'                     
                     + '<FC>id=BIN_NO         name="카드빈번호"         	width=100     	align=center</FC>'
                     + '<FC>id=APP_S_DT       name="적용시작일"        	width=80      	align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=APP_E_DT       name="적용종료일"        	width=80      	align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=SEQ_NO 		  name="순번"   				width=120    	align=right show=false</FC>'
                     + '<FC>id=USE_BAS_FR_AMT name="적용시작금액"   		width=120    	align=right</FC>'
                     + '<FC>id=USE_BAS_TO_AMT name="적용종료금액"   		width=120    	align=right</FC>'
                     + '<FC>id=REDU_AMT       name="할인금액"    		width=100    	align=right</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            return false;
        }else{
          strChangFlag = true;
        }
    }
    
	if(trim(EM_S_DATE_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DATE_S.Focus();
        return;
    }else if(trim(EM_E_DATE_S.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DATE_S.Focus();
        return;
    }else if(EM_S_DATE_S.Text > EM_E_DATE_S.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DATE_S.Focus();
        return;
    }    
    
    if(trim(EM_S_BIN_NO_S.text).length == 0){          //카드빈
        showMessage(EXCLAMATION, OK, "USER-1001","카드빈");
        EM_S_BIN_NO_S.Focus();
        return;
    }
    if(trim(EM_E_BIN_NO_S.text).length == 0){           //카드빈
        showMessage(EXCLAMATION, OK, "USER-1001","카드빈");
        EM_E_BIN_NO_S.Focus();
        return;
    }

    if( EM_S_BIN_NO_S.Text > EM_E_BIN_NO_S.Text){         //카드빈 정합성
        showMessage(EXCLAMATION, OK, "USER-1015","카드빈 시작번호는 카드빈 종료번호보다 작아야 합니다.");
        EM_S_BIN_NO_S.Focus();
        return;
    }
    
    showMaster();
}

/**
 * btn_New()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
            setTimeout("EM_CCOMP_CD.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "BIN_NO") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }
    
    DS_O_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    
    initEmEdit(EM_APP_S_DT,     	"TODAY",       		PK);
    initEmEdit(EM_APP_E_DT,     	"TODAY",       		PK);
	
	enableControl(IMG_CCOMP_CD, true);
    LC_STR_CD.Enable			= true;
    EM_APP_S_DT.Enable          = true;
    EM_APP_E_DT.Enable          = true;
    EM_USE_BAS_FR_AMT.Enable    = true;
    EM_USE_BAS_TO_AMT.Enable    = true;
    EM_REDU_AMT.Enable          = true;	
   
    strChangFlag = false;
    bfListRowPosition = 0;
    intChangRow = 1;
    //LC_STR_CD.Focus();
}
 

/**
 * btn_Save()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    } 
    if (trim(EM_BIN_NO.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드빈 번호");
        EM_BIN_NO.Focus();
        return;
    } 
    if (trim(LC_STR_CD.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
        LC_STR_CD.Focus();
        return;
    } 
    if (trim(EM_CCOMP_CD.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사");
        EM_CCOMP_CD.Focus();
        return;
    }    
    if (trim(EM_CCOMP_NM.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사명");
        EM_CCOMP_NM.Focus();
        return;
    }         
    if (trim(EM_APP_S_DT.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "적용시작일");
        EM_APP_S_DT.Focus();
        return;
    }
    if (trim(EM_APP_E_DT.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "적용종료일");
        EM_APP_E_DT.Focus();
        return;
    } 
    if (trim(EM_USE_BAS_FR_AMT.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "적용시작금액");
        EM_USE_BAS_FR_AMT.Focus();
        return;
    }
    if (trim(EM_USE_BAS_TO_AMT.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "적용종료금액");
        EM_USE_BAS_TO_AMT.Focus();
        return;
    }
    if(EM_APP_S_DT.text > EM_APP_E_DT.text){   // 적용시작일자<=적용종료일자 정합성체크
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_APP_S_DT.Focus();
        return false;
    }     
    if(EM_USE_BAS_FR_AMT.text > EM_USE_BAS_TO_AMT.text){   // 적용시작금액<=적용종료금액 정합성체크
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_USE_BAS_TO_AMT.Focus();
        return false;
    }     
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }   
    saveData();
}

/**
 * btn_Excel()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    var ExcelTitle = "카드별현장할인내역등록"
    openExcel2(GD_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개       요 : 카드발급사코드 관리 조회
 * return값 : void
 */
function showMaster(){

    var binNo  = EM_S_BIN_NO_S.text;
    var binNo2 = EM_E_BIN_NO_S.text
  
    if (binNo == "")
        binNo = "000000";   
    
    if (binNo2 == "")
        binNo2 = "999999";   
    
    EXCEL_PARAMS  = "점="				+ LC_STR_CD_S.Text;
    EXCEL_PARAMS += "-카드발급사="		+ EM_CCOMP_NM_S.text;
    EXCEL_PARAMS += "-조회기간="			+ EM_S_DATE_S.text + "~" + EM_E_DATE_S.text;
    EXCEL_PARAMS += "-카드빈번호="		+ binNo + "~" + binNo2;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="     +  encodeURIComponent(LC_STR_CD_S.BindColVal)
                    + "&strCcomp="     +  encodeURIComponent(EM_CCOMP_CD_S.text)
				    + "&strAppSDt="    +  encodeURIComponent(EM_S_DATE_S.text)
				    + "&strAppEDt="    +  encodeURIComponent(EM_E_DATE_S.text)
				    + "&strSBinNo="    +  encodeURIComponent(EM_S_BIN_NO_S.text)   
				    + "&strEBinNo="    +  encodeURIComponent(EM_E_BIN_NO_S.text) ;    
    
    TR_MAIN.Action  = "/dps/pcodD01.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GD_MASTER.Focus();
        if(intChangRow > 0){
            bfListRowPosition = DS_O_MASTER.RowPosition;
            setFocusGrid(GD_MASTER, DS_O_MASTER, intChangRow);
            doClick(intChangRow);
        }
    }else{
    	EM_S_BIN_NO_S.Focus();
    	DS_IO_DETAIL.ClearData();
    }

    bfListRowPosition = 0;
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * saveData()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개       요 : 카드발급사코드 관리 등록
 * return값 : void
 */
function saveData(){
   var goTo        = "saveData";
   var action      = "I";  //조회는 O
   TR_MAIN.Action  ="/dps/pcodD01.pc?goTo="+goTo;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
   TR_MAIN.Post();

   btn_Search();
}

/**
 * btn_Delete()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개       요 : 선택된 카드빈 삭제 
 * return값 : void
 */
function btn_Delete(row){
    var appSdt = DS_O_MASTER.NameValue(row ,"APP_S_DT");
    //시작일자가 현재일자보다 작거나 같을 경우 삭제 불가능, 즉 미래일자만 삭제가능
	if(parseInt(appSdt) < parseInt(strToday)){
		return;
	} 
     
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    
    DS_IO_DETAIL.DeleteRow(1);
     
    var goTo          = "saveData";    
    var action        = "I";     
    var parameters    = "&strStrCd="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"STR_CD"))
				      + "&strBinNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"BIN_NO"))
					  + "&strAppSDt="  + encodeURIComponent(DS_O_MASTER.NameValue(row ,"APP_S_DT"))
					  + "&strSeqNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"SEQ_NO"));
    
    TR_DETAIL.Action  = "/dps/pcodD01.pc?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
}  
  
/**
 * doOnClick()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개       요 : 선택된 클럽관리 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
 
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;

    var goTo          = "searchDetail";    
    var action        = "O";     
    var parameters    = "&strStrCd="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"STR_CD"))
				      + "&strBinNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"BIN_NO"))
					  + "&strAppSDt="  + encodeURIComponent(DS_O_MASTER.NameValue(row ,"APP_S_DT"))
					  + "&strSeqNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"SEQ_NO"));
    
    TR_DETAIL.Action  = "/dps/pcodD01.pc?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    fncChgEnable(row);
}

/**
 * doOnClick()
 * 작 성 자 : kj
 * 작 성 일 : 2012.07.16
 * 개       요 : 현재일에따라 수정가능 필드 설정 
 * return값 : void
 */
function fncChgEnable(row) {
    var appSdt = DS_O_MASTER.NameValue(row ,"APP_S_DT");
    var appEdt = DS_O_MASTER.NameValue(row ,"APP_E_DT");

    //현재일 > 적용종료일 (수정불가)
    if(parseInt(strToday) > parseInt(appEdt)){
        LC_STR_CD.Enable			= false;
        EM_APP_S_DT.Enable          = false;
        EM_APP_E_DT.Enable          = false;
        EM_USE_BAS_FR_AMT.Enable    = false;
        EM_USE_BAS_TO_AMT.Enable    = false;
        EM_REDU_AMT.Enable          = false;	
        enableControl(IMG_CCOMP_CD, false);
    }
    //적용시작일<= 현재일 <= 적용종료일 (적용종료일만 수정가능)
    if( parseInt(appSdt) <= parseInt(strToday) && parseInt(strToday) <= parseInt(appEdt)){
        LC_STR_CD.Enable			= false;
        EM_APP_S_DT.Enable          = false;
        EM_APP_E_DT.Enable          = true;
        EM_USE_BAS_FR_AMT.Enable    = false;
        EM_USE_BAS_TO_AMT.Enable    = false;
        EM_REDU_AMT.Enable          = false;
        enableControl(IMG_CCOMP_CD, false);
    }
  	//현재일 < 적용종료일 (수정가능)
    if(parseInt(strToday) < parseInt(appEdt)){
        LC_STR_CD.Enable			= false;
        EM_APP_S_DT.Enable          = false;
        EM_APP_E_DT.Enable          = true;
        EM_USE_BAS_FR_AMT.Enable    = true;
        EM_USE_BAS_TO_AMT.Enable    = true;
        EM_REDU_AMT.Enable          = true;
        enableControl(IMG_CCOMP_CD, false);
    }	
}

/**
 * keyPressEvent()
 * 작 성 자 : kj
 * 작 성 일 : 2010-05-25
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode, objCd, objNm) {
	objNm.Text = "";//조건입력시 코드초기화 
    if (objCd.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || objCd.Text.length == 2) { //TAB,ENTER 키 실행시에만  
            var goTo       = "searchOnMaster" ;    
            var action     = "O";     
            var parameters = "&strCcompCd="+encodeURIComponent(objCd.Text);
            
            TR_MAIN.Action="/pot/ccom027.cc?goTo="+goTo+parameters;
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_RESULT)"; //조회는 O
            TR_MAIN.Post();
              
            if (DS_O_RESULT.CountRow == 1 ) {
            	objCd.Text   = DS_O_RESULT.NameValue(1, "CODE");
            	objNm.Text   = DS_O_RESULT.NameValue(1, "NAME");
            } else {
                 //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(objCd, objNm)
            }
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
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
    intChangRow = 0;
    bfListRowPosition = DS_O_MASTER.RowPosition;
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if (strChangFlag == false && DS_IO_DETAIL.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            //setTimeout("LC_STR_CD.Focus();",50);
            return false;
        }else{
        	 if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "BIN_NO") == ""){
                 DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
             }
             bfListRowPosition = row;
             intChangRow = 0;
        }
    }else{
    	return true;
    }
</script>
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    //그리드 첫 row 상세조회
    if(row != 0){
    	if( bfListRowPosition == row)
            return;
        if( intChangRow == 0 ){
            bfListRowPosition = row;
            doClick(row);
        }
    }else{
        DS_IO_DETAIL.ClearData();
    }
    if(DS_O_MASTER.CountRow > 0 && DS_IO_DETAIL.CountRow == 0){
        doClick(DS_O_MASTER.RowPosition);
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DATE_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DATE_S)){
    	initEmEdit(EM_S_DATE_S,    "TODAY",     PK);
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DATE_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_DATE_S)){
        initEmEdit(EM_E_DATE_S,    "TODAY",     PK);         
    }
</script>
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD_S event=onKillFocus()>
    if (EM_CCOMP_CD_S.Text.length < 2) {
        EM_CCOMP_CD_S.Text = "";
        EM_CCOMP_NM_S.Text = "";
    }
</script>
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD event=onKillFocus()>
    if (trim(EM_CCOMP_CD.Text).length < 2) {
        EM_CCOMP_CD.Text = "";
        EM_CCOMP_NM.Text = "";
    }
</script>

<!-- 적용일자 onKillFocus() -->
<script language=JavaScript for=EM_APP_S_DT event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    var toDate = getTodayFormat('YYYYMMDD');
    if( !checkDateTypeYMD(this,toDate,"GD_MASTER","EM_APP_S_DT"))
        return;
    var appEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_APP_E_DT");
    if( toDate > this.Text){
        showMessage(EXCLAMATION, OK, "USER-1000", "시작일자는 오늘 이후 일자만 가능 합니다.");
        this.Text = toDate;
        return;
    }
    if( appEDt < this.Text){
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 시작일자 보다 크거나 같아야 (시작일자 <= 종료일자) 합니다.");
        this.Text = toDate;
        return;
    }    
</script>  
<script language=JavaScript for=EM_APP_E_DT event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	if( !checkDateTypeYMD(this,'99991231',"GD_MASTER","EM_APP_E_DT"))
	    return;
	var appSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_APP_E_DT");
	var toDate = getTodayFormat('YYYYMMDD');
	var yesterDay = getRawData(addDate('D',-1,getTodayFormat('YYYYMMDD')));
	if( yesterDay > this.Text){
	    showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 어제 이후 일자만 가능 합니다.");
	    this.Text = "99991231";
	    return;
	}
	if( appSDt > this.Text){
	    showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 시작일자 보다 크거나 같아야 (시작일자 <= 종료일자) 합니다.");
	    this.Text = "99991231";
	    return;
	}
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD_S" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점코드</th>
						<td><comment id="_NSID_">
			                <object id=LC_STR_CD_S classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
			              	</comment><script>_ws_(_NSID_);</script>
			            </td>
			            <th width="80">카드발급사</th>
			            <td width="1100"><comment id="_NSID_"> <object
							id=EM_CCOMP_CD_S classid=<%=Util.CLSID_EMEDIT%> width=30
							tabindex=1 onKillFocus="javascript:onKillFocus()"
							onKeyUp="javascript:keyPressEvent(event.keyCode, EM_CCOMP_CD_S, EM_CCOMP_NM_S);"></object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getCcompPop(EM_CCOMP_CD_S, EM_CCOMP_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_CCOMP_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>							
					</tr>					
					<tr>
						<th width="80" class="point">조회기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DATE_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DATE_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DATE_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DATE_S)" /></td>
			            <th width="80">카드빈 번호</th>
			            <td width="340"><comment id="_NSID_"> <object
							id=EM_S_BIN_NO_S classid=<%=Util.CLSID_EMEDIT%> width=50
							tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>~
							<comment id="_NSID_"> <object
                            id=EM_E_BIN_NO_S classid=<%=Util.CLSID_EMEDIT%> width=50
                            tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
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
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점코드</th>
						<td width="180"><comment id="_NSID_"> <object 
						    id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
			              	</comment><script>_ws_(_NSID_);</script></td>
			              	
						<th width="80">카드발급사</th>
						<td width="180"><comment id="_NSID_">  <object
                            id=EM_CCOMP_CD classid=<%=Util.CLSID_EMEDIT%> width=30
                            tabindex=1 onKillFocus="javascript:onKillFocus()"></object> </comment> <script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_CCOMP_CD
                            align="absmiddle"
                            onclick="getCcompPop2(EM_CCOMP_CD, EM_CCOMP_NM, EM_BIN_NO)" /> <comment
                            id="_NSID_"> <object id=EM_CCOMP_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
							
						<th width="80" class="point">카드빈 번호</th>
                        <td><comment id="_NSID_"> <object
							id=EM_BIN_NO classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							onkeyup="javascript:checkByteStr(EM_CCOMP_CD, 6, '');"></object>
						</comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80" class="point">적용시작일</th>
						<td width="180"> <comment id="_NSID_"> <object id=EM_APP_S_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_APP_S_DT)" /></td>

						<th width="80">적용종료일</th>
						<td width="180"><comment id="_NSID_"> <object id=EM_APP_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_APP_E_DT)" /></td>

						<th width="80" ></th>
						<td><comment id="_NSID_"> <object
							id=EM_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=0 height=0 tabindex=1></object>
						</comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80" class="point">적용시작금액</th>
						<td width="180"><comment id="_NSID_"> <object id=EM_USE_BAS_FR_AMT
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>

						<th width="80" class="point">적용종료금액</th>
						<td width="180"><comment id="_NSID_"> <object id=EM_USE_BAS_TO_AMT
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
							
						<th width="80" class="point">할인금액</th>
						<td><comment id="_NSID_"> <object id=EM_REDU_AMT 
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
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
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
               <c>col=STR_CD     	 ctrl=LC_STR_CD        	   Param=BindColVal</c>
               <c>col=BIN_NO         ctrl=EM_BIN_NO            Param=Text</c>
               <c>col=APP_S_DT       ctrl=EM_APP_S_DT          Param=Text</c>
               <c>col=APP_E_DT       ctrl=EM_APP_E_DT          Param=Text</c>
               <c>col=SEQ_NO       	 ctrl=EM_SEQ_NO            Param=Text</c>
               <c>col=CCOMP_CD       ctrl=EM_CCOMP_CD          Param=Text</c>
               <c>col=CCOMP_NM       ctrl=EM_CCOMP_NM          Param=Text</c>
               <c>col=USE_BAS_FR_AMT ctrl=EM_USE_BAS_FR_AMT    Param=Text</c>
               <c>col=USE_BAS_TO_AMT ctrl=EM_USE_BAS_TO_AMT    Param=Text</c>
               <c>col=REDU_AMT       ctrl=EM_REDU_AMT          Param=Text</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

