<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 월관리비등록
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN302.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월관리비를 등록한다
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.04.26 (김유완) 수정작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                    *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_currRow   = 1; 
var excelStrCd    = "";       // 시설구분
var excelCalYM    = "";             // 부과년월
var excelMntnitem = "";  // 관리비항목  
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit() {
    // 입력 Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_ITEMAMT"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");

    //그리드 초기화
    gridCreate();

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,               "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_YM,                             "YYYYMM", PK);                      // [조회용]부과년월
    initComboStyle(LC_S_MR_MNTNITEM,DS_S_MR_MNTNITEM,   "CODE^0^30,NAME^0^100", 1, NORMAL); // [조회용]관리비항목
    initComboStyle(LC_STR_CD,DS_STR_CD,                 "CODE^0^30,NAME^0^100", 1, PK);     // 시설구분
    initEmEdit(EM_CAL_YM,                               "YYYYMM", PK);                      // 부과년월
    initEmEdit(EM_FILS_LOC,                             "GEN", READ);                       // EXCEL경로
    
    //콤보 초기화
    getFlc("DS_STR_CD",         "M", "1", "Y", "N");    // [조회용]시설구분  
    LC_S_STR_CD.Focus();
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    //EM_CAL_YM.Text = getTodayFormat("YYYYMM");
    
    //등록 비활성화
    enableControl(IMG_FILE_SEARCH, false);  //Excel찾기버튼
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mren302","DS_IO_MASTER" );
    /*EXCEL파일*/
    INF_EXCELUPLOAD.FileFilterString = 16; 
    
    LC_S_STR_CD.Index = 0;
    LC_STR_CD.BindColVal = LC_S_STR_CD.BindColVal;
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate() {
    var hdrProperies = ''
        + '<FC>ID={CURROW}      NAME=NO'         
        + '                                     WIDTH=30    ALIGN=CENTER</FC>'
        + '<FC>ID=MNTN_ITEM_CD  NAME=*관리비항목'            
        + '                                     WIDTH=170   ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_MR_MNTNITEM:CODE:NAME"</FC>'
        + '<FC>ID=MNTN_AMT      NAME=*금액'        
        + '                                     WIDTH=130   ALIGN=RIGHT EDIT=NUMERIC </FC>'
        + '<FC>ID=REMARK         NAME=비고'            
        + '                                     WIDTH=450   ALIGN=LEFT</FC>'
        ;
        
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
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
 * 작 성 일 : 2010.04.25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            if (!checkValidate()) return;
        	
            //입력값 동기화
            EM_CAL_YM.Text     = EM_S_CAL_YM.Text;
            LC_STR_CD.BindColVal = LC_S_STR_CD.BindColVal;
            //getCloseYN(LC_STR_CD.BindColVal, EM_CAL_YM.Text);
            // 조회내역 마감여부체크
            if (EM_S_CAL_YM.Text.length > 0) {
                if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
                    objectControlDefault(false);
                } else {
                    objectControlDefault(true);
                }
            }
            
            // parameters
            var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
            var strCalYM    = EM_S_CAL_YM.Text;             // 부과년월
            var strMntnitem = LC_S_MR_MNTNITEM.BindColVal;  // 관리비항목
            
            excelStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
    		excelCalYM    = EM_S_CAL_YM.Text;             // 부과년월
    		excelMntnitem = LC_S_MR_MNTNITEM.BindColVal;  // 관리비항목    		
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strCalYM="      + encodeURIComponent(strCalYM)
                + "&strMntnitem="   + encodeURIComponent(strMntnitem);
            TR_MAIN.Action = "/mss/mren302.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            g_currRow = 1;
        } else {
            return;
        }
    }  else {
    	if (!checkValidate()) return;
    	
        //입력값 동기화
        EM_CAL_YM.Text     = EM_S_CAL_YM.Text;
        LC_STR_CD.BindColVal = LC_S_STR_CD.BindColVal;
        //getCloseYN(LC_STR_CD.BindColVal, EM_CAL_YM.Text);
        // 조회내역 마감여부체크
        if (EM_S_CAL_YM.Text.length > 0) {
            if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
                objectControlDefault(false);
            } else {
                objectControlDefault(true);
            }
        }
    	
        // parameters
		var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
		var strCalYM    = EM_S_CAL_YM.Text;             // 부과년월
		var strMntnitem = LC_S_MR_MNTNITEM.BindColVal;  // 관리비항목
		
		excelStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
		excelCalYM    = EM_S_CAL_YM.Text;             // 부과년월
		excelMntnitem = LC_S_MR_MNTNITEM.BindColVal;  // 관리비항목  
		
		var goTo = "getMaster";
		var parameters = ""
		    + "&strStrCd="      + encodeURIComponent(strStrCd)
		    + "&strCalYM="      + encodeURIComponent(strCalYM)
		    + "&strMntnitem="   + encodeURIComponent(strMntnitem);
		TR_MAIN.Action = "/mss/mren302.mr?goTo=" + goTo + parameters;
		TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
		TR_MAIN.Post();
        
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
        g_currRow = 1;
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {
	//시설, 부과년월 선택체크
    if (!chkBfCloseYN()) return;
	    
	// 신규
	GD_MASTER.SetColumn("MNTN_ITEM_CD");
	DS_IO_MASTER.AddRow();
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = LC_STR_CD.BindColVal;
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CAL_YM") = EM_CAL_YM.Text;
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "LOAD_FLAG") = "Y";
	GD_MASTER.SetColumn("MNTN_ITEM_CD");

}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	//시설, 부과년월 선택체크
	if (DS_IO_MASTER.CountRow > 0) {
	    if (!chkBfCloseYN()) return;
	    
	    //DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	}		
	
	if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) { // 신규시에만 삭제
	    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
	} else {
	    // 선택한 항목을 삭제하겠습니까?
	    if( showMessage(INFORMATION, YESNO, "USER-1023") != 1 ){
	        GD_MASTER.Focus();
	        return;
	    }  
	    
	    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
	    
	    // parameters
	    //var strStrCd    = LC_STR_CD.BindColVal;       // 시설구분
	    //var strCalYM    = EM_CAL_YM.Text;             // 부과년월
	    var goTo = "delete";
	    
	    TR_SAVE.Action = "/mss/mren302.mr?goTo=" + goTo;
	    TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
	    TR_SAVE.Post();
	}	
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidateSave()) return;
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
        //저장
        g_currRow = DS_IO_MASTER.RowPosition;
        // parameters
        var strStrCd    = LC_STR_CD.BindColVal;       // 시설구분
        var strCalYM    = EM_CAL_YM.Text;             // 부과년월
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren302.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var parameters = "시설구분="+nvl(excelStrCd,'전체')                    
                   + " -부과년월="+nvl(excelCalYM,'전체')    
                   + " -관리비항목="+nvl(excelMntnitem,'전체');
		
	GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	
    openExcel2(GD_MASTER, "월관리비등록", parameters, true );
    GD_MASTER.Focus();    
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getMntnitem()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 관리비항목코드가져오기
 * return값 :
 */
function getMntnitem(strDsSet, strCd, allGb) {
    var goTo = "getMntnitem";
    var parameters = ""
            + "&strAllGb=" + encodeURIComponent(allGb)
            + "&strStrCd=" + encodeURIComponent(strCd);
    TR_MAIN.Action = "/mss/mren302.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_MR_MNTNITEM="+strDsSet+")";
    TR_MAIN.Post();
}

/**
 * chkBfCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 마감여부체크
 * return값 :
 */
function chkBfCloseYN() {
    // 시설구분, 년월, 정산마감 시 신규 불가
    if (LC_STR_CD.BindColVal=="") {
        showMessage(INFORMATION, OK, "USER-1000", "월관리비 등록하려는 시설(구분)을 선택하세요");
        LC_STR_CD.Focus();
        return false;
    } 

    if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "")=="") {
        showMessage(INFORMATION, OK, "USER-1000", "월관리비 등록하려는 년월을 입력하세요");
        EM_CAL_YM.Focus();
        return false;
    } 
    
    //마감체크 함수
    if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
        var strCalY     = (EM_CAL_YM.Text).substring(0,4);
        var strCalM     = (EM_CAL_YM.Text).substring(5,6);
        showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
        return false;
    } 
    
	return true;
}

/**
 * getCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 마감여부체크
 * return값 :
 */
function getCloseYN() {
	//데이터 초기화
	//DS_IO_MASTER.ClearData();

	//마감체크 함수(getCloseCheck)
	if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
	    objectControlDefault(false);
        var strCalY     = (EM_CAL_YM.Text).substring(0,4);
        var strCalM     = (EM_CAL_YM.Text).substring(5,6);
        showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
        DS_IO_MASTER.ClearData();
        EM_CAL_YM.Text = "";
	} else {
		DS_IO_MASTER.ClearData();
	    objectControlDefault(true);
	}
}

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 값체크
 * return값 :
 */
function checkValidate() {
     if (LC_S_STR_CD.BindColVal == "") {
         showMessage(INFORMATION, OK, "USER-1000", "시설(구분)을 선택하세요");
         LC_S_STR_CD.Focus();
         return false;
     }
     
     if (EM_S_CAL_YM.Text == "") {
         showMessage(INFORMATION, OK, "USER-1000", "부과년월 입력/선택 하세요");
         EM_S_CAL_YM.Focus();
         return false;
     }

    return true;
}

/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 값체크
 * return값 :
 */
function checkValidateSave() {
    var strStrCd = LC_STR_CD.BindColVal;
    var strCalYM = EM_CAL_YM.Text;
    if (strStrCd == "") { // 시설구분 미등록시
        showMessage(STOPSIGN, OK, "USER-1000", "시설구분을 선택하셔야 합니다.");
        LC_STR_CD.Focus();
        return false;
    }
    if (strCalYM == "") { // 시설구분 미등록시
        showMessage(STOPSIGN, OK, "USER-1000", "부과년월을 입력하셔야 합니다.");
        EM_CAL_YM.Focus();
        return false;
    }
        
    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
        // 관리비항목
        if (DS_IO_MASTER.NameValue(i,"MNTN_ITEM_CD") == "") {
            showMessage(STOPSIGN, OK, "USER-1000", "관리비항목을 선택하세요.");
            DS_IO_MASTER.RowPosition = i;
            GD_MASTER.SetColumn("MNTN_ITEM_CD");
            return false;
        } 
        
        // 금액
        if (DS_IO_MASTER.NameValue(i,"MNTN_AMT") == "") {
            showMessage(STOPSIGN, OK, "USER-1000", "금액을 입력하세요.");
            DS_IO_MASTER.RowPosition = i;
            GD_MASTER.SetColumn("MNTN_AMT");
            return false;
        } 
        
        // 비고 
        var tmpLenE = checkLenByte(DS_IO_MASTER, i, "REMARK")
        if (tmpLenE > 400 ) {
            showMessage(STOPSIGN, OK, "USER-1048", "400(한글200/영문,숫자400)");
            DS_IO_MASTER.RowPosition = i;
            GD_MASTER.SetColumn("REMARK");
            return false;
        }
        
        //관리비 항목코드 중복체크 
       	var iItemCd = DS_IO_MASTER.NameValue(i,"MNTN_ITEM_CD");
        for(var k=i+1; k<=DS_IO_MASTER.CountRow; k++) {
        	var kItemCd = DS_IO_MASTER.NameValue(k,"MNTN_ITEM_CD");
        	if (iItemCd==kItemCd) {
        		showMessage(STOPSIGN, OK, "USER-1000", i+"번째행과"+ k +"번째행의  관리비항목가 중복됩니다.");
                DS_IO_MASTER.RowPosition = k;
                GD_MASTER.SetColumn("MNTN_ITEM_CD");
                return false;
        	}
        }
    }
    return true;
}

/**
 * checkLenByte()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 문자열 Byte체크
 * return값 :
 */
function checkLenByte(objDateSet, row, colid) {
    //byte체크
    var intByte = 0;
    var strTemp = objDateSet.NameValue(row, colid);
    for (k = 0; k < strTemp.length; k++) {
        var onechar = strTemp.charAt(k);
        if (escape(onechar).length > 4) {
            intByte += 2;
        } else {
            intByte++;
        }
    }
    return intByte;
}

/**
 * loadExcelData()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {
     if (!chkBfCloseYN()) return;
     
     INF_EXCELUPLOAD.Open();
 	if (INF_EXCELUPLOAD.SelectState) {
 	    //loadExcelData 옵션처리
 	    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
 	    if (strExcelFileName == "''") return;
 	    EM_FILS_LOC.text = strExcelFileName;//경로명 표기
 	    var strStartRow = 7; //시작Row
 	    var strEndRow = 0; //끝Row
 	    var strReadType = 0; //읽기모드
 	    var strBlankCount = 0; //공백row개수
 	    var strLFTOCR = 0; //줄바꿈처리 
 	    var strFireEvent = 1; //이벤트발생
 	    var strSheetIndex = 1; //Sheet Index 추가
 	    var strtrEtc = "1";//엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
 	    var strtrcol = 0;//Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)

 	    var strOption = strExcelFileName
 	    + "," + strStartRow + "," + strEndRow + "," + strReadType 
 	    + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
 	    + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
 	    
 	    //Excel파일 DateSet에 저장               
 	    DS_IO_MASTER.Do("Excel.Application", strOption);
 	    
 	    DS_IO_MASTER.DeleteRow(1);
	    
	    //입력값 체크
	    /*
	    var intDelCnt = 0;
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
	        if (DS_IO_MASTER.RowStatus(i) == 1) {
	            if (DS_IO_MASTER.NameValue(i, "LOAD_FLAG") == "") {
	                DS_IO_MASTER.NameValue(i, "CAL_YM") = EM_CAL_YM.Text;
	                DS_IO_MASTER.NameValue(i, "STR_CD") = LC_STR_CD.BindColVal;
	                DS_IO_MASTER.NameValue(i, "LOAD_FLAG") = "Y";
	            } 
	            var strMatch = false;
	            for (var k=1; k<=DS_MR_MNTNITEM.CountRow; k++) {
	                if (DS_IO_MASTER.NameValue(i, "MNTN_ITEM_CD") == DS_MR_MNTNITEM.NameValue(k, "CODE")) {
	                    DS_IO_MASTER.NameValue(i, "LOAD_FLAG") = "N";
	                    strMatch = true;
	                    break;  
	                }
	            }
	            //관리비항목코드와 맞는것이 없을 경우 코드불량
	            if (!strMatch) {
	                DS_IO_MASTER.DeleteRow(i);
	                i--;
	                intDelCnt++;
	            }
	        }
	    }
	    showMessage(INFORMATION, OK, "USER-1000", "(간접비)관리비항목코드가 일치하지 않는 '" + intDelCnt +"'건이 삭제 되었습니다. ");
	    EM_FILS_LOC.text= "";
	    */
	} 
}

/**
 * objectControlDefault()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 월관리비 등록 부 컨트롤
 * return값 :
 */
function objectControlDefault(objBoolean) {
    if (objBoolean) {
        GD_MASTER.Editable      = "true";
        //LC_STR_CD.Enable        = true;
        //EM_CAL_YM.Enable        = true;
        //이미지
        //enableControl(IMG_CAL_YM,true);
        enableControl(IMG_FILE_SEARCH,true);
    } else {
        GD_MASTER.Editable      = "false";
        //LC_STR_CD.Enable        = false;
        //EM_CAL_YM.Enable        = false;
        //이미지
        //enableControl(IMG_CAL_YM,false);
        enableControl(IMG_FILE_SEARCH,false);
    }
}

-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                          *-->
<!--*    1. TR Success 메세지 처리                                                                                         *-->
<!--*    2. TR Fail 메세지 처리                                                                                               *-->
<!--*    3. DataSet Success 메세지 처리                                                                               *-->
<!--*    4. DataSet Fail 메세지 처리                                                                                     *-->
<!--*    5. DataSet 이벤트 처리                                                                                               *-->
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
    //저장 후 조회    
    LC_S_STR_CD.BindColVal  = LC_STR_CD.BindColVal;
    EM_S_CAL_YM.Text        = EM_CAL_YM.Text
    var goTo = "getMaster";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(LC_S_STR_CD.BindColVal)        // 시설구분
        + "&strCalYM="      + encodeURIComponent(EM_S_CAL_YM.Text)              // 부과년월
        + "&strMntnitem="   + encodeURIComponent(LC_S_MR_MNTNITEM.BindColVal);  // 관리비항목
    TR_MAIN.Action = "/mss/mren302.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
    // 조회결과 Return
    DS_IO_MASTER.RowPosition = g_currRow;
    setPorcCount("SELECT", GD_MASTER);
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT)return;
if (row > 0) {
	if (DS_IO_MASTER.RowStatus(row) == 0 ){
        GD_MASTER.ColumnProp('MNTN_ITEM_CD', 'Edit')  = "None"; // 관리비항목
	} else {
        GD_MASTER.ColumnProp('MNTN_ITEM_CD', 'Edit')  = "";     // 관리비항목
		
	}
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnCloseUp(row,colid)>
if (colid == "MNTN_ITEM_CD") {
    //관리비 항목코드 중복체크 
    var iItemCd = DS_IO_MASTER.NameValue(row,"MNTN_ITEM_CD");
    for(var k=i+1; k<=DS_IO_MASTER.CountRow; k++) {
    	if (row != k) {
	        var kItemCd = DS_IO_MASTER.NameValue(k,"MNTN_ITEM_CD");
	        if (iItemCd==kItemCd) {
	            showMessage(STOPSIGN, OK, "USER-1000", k +"번째행의  관리비항목과 중복됩니다.");
	            GD_MASTER.SetColumn("MNTN_ITEM_CD");
	            DS_IO_MASTER.NameValue(row,"MNTN_ITEM_CD") = "";
	            return;
	        }
    	} 
    }
}
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//[조회용]시설구분 변경시
getMntnitem("DS_S_MR_MNTNITEM", LC_S_STR_CD.BindColVal, "Y");
LC_S_MR_MNTNITEM.Index = 0;
</script>

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
//시설구분 변경시
getMntnitem("DS_MR_MNTNITEM", LC_STR_CD.BindColVal, "N");

//마감여부체크
if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
	getCloseYN();
}
</script>

<script language=JavaScript for=EM_CAL_YM event=OnKillFocus()>
// 마감여부체크
if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
	getCloseYN();
} 
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                      *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_MR_MNTNITEM"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MR_MNTNITEM"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_YN"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
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
						<th width="100" class="point">시설구분</th>
						<td width="145"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="143"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">부과년월</th>
						<td width="110"><comment id="_NSID_"><object
							id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="85"
							onblur="javascript:checkDateTypeYM(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
						<th width="100">관리비항목</th>
						<td><comment id="_NSID_"> <object
							id=LC_S_MR_MNTNITEM classid=<%=Util.CLSID_LUXECOMBO%> width=160
							align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="s_table">
					<tr>
						<th width="60" class="point">시설구분</th>
						<td width="100"><comment id="_NSID_"><object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="95"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="60" class="point">부과년월</th>
						<td width="85"><comment id="_NSID_"><object
							id=EM_CAL_YM style="vertical-align: middle;"
							onblur="javascript:checkDateTypeYM(this);"
							classid=<%=Util.CLSID_EMEDIT%> width="60"></object></comment><script>_ws_(_NSID_);</script><img
							id="IMG_CAL_YM" style="vertical-align: middle;"
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('M',EM_CAL_YM);" /></td>
						<th width="60">엑셀업로드</th>
						<td width="310"><comment id="_NSID_"><object
							id=EM_FILS_LOC style="vertical-align: middle;"
							classid=<%=Util.CLSID_EMEDIT%> width="230"></object></comment><script>_ws_(_NSID_);</script><img
							id="IMG_FILE_SEARCH" style="vertical-align: middle;"
							src="/<%=dir%>/imgs/btn/file_search.gif"
							onclick="javascript:loadExcelData();" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=471 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
