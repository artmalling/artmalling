<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 사은행사관리 > 사은품깆급 > 사은행사 엑셀지급 등록 
 * 작 성 일 : 2011.01.24
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : mcae4270.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경품행사 응모자 등록 한다
 * 이    력 : 2011.01.24 (김유완) 신규작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit() {
    // 입력 Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_PRMMENTY_DTL"/>');
    // 조회 Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_PRMMENTY_MST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_DETAIL");

    //그리드 초기화
    gridCreate("MST"); //마스터(행사정보)
    gridCreate("DTL"); //디테일(응모자정보)

    // EMedit에 초기화
    initEmEdit(EM_SEL_EVENT_SDATE, "SYYYYMMDD", PK); //행사시작일
    initEmEdit(EM_SEL_EVENT_EDATE, "TODAY", PK); //행사종료일
    initEmEdit(EM_SEL_EVENT_CD, "NUMBER3^11^0", NORMAL); //행사코드
    initEmEdit(EM_SEL_EVENT_NM, "GEN", READ); //행사명
    initEmEdit(EM_ENTRY_DT, "TODAY", PK); //행사년월
    initEmEdit(EM_FILS_LOC, "GEN", READ); //EXCEL경로
    
    //콤보 초기화
    initComboStyle(LC_SEL_STR_CD, DS_O_STR_COMBO, "CODE^0^30,NAME^0^80", 1,PK); //점콤보(조회)
    LC_SEL_STR_CD.Focus();
    getStore("DS_O_STR_COMBO", "Y", "1", "N");
    LC_SEL_STR_CD.Index = 0;
    
    //등록 비활성화
    enableControl(IMG_FILE_SEARCH, false);  //Excel찾기버튼
    enableControl(IMG_ADD_ROW, false);      //행추가
    enableControl(IMG_DEL_ROW, false);      //행삭제
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mcae427","DS_IO_DETAIL" );
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate(gdGnb) {
    //마스터그리드
    if (gdGnb == "MST") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=STR_CD        NAME=점코드'            
            + '                                     WIDTH=50    ALIGN=CENTER</FC>'
            + '<FC>ID=STR_NM        NAME=점명'               
            + '                                     WIDTH=100   ALIGN=LEFT</FC>'
            + '<FC>ID=EVENT_CD      NAME=행사코드'        
            + '                                     WIDTH=100   ALIGN=CENTER</FC>'
            + '<FC>ID=EVENT_NM      NAME=행사명'            
            + '                                     WIDTH=240   ALIGN=LEFT</FC>'
            + '<FC>ID=EVENT_S_DT    NAME=행사시작일'      
            + '                                     WIDTH=100   ALIGN=CENTER    MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=EVENT_E_DT    NAME=행사종료일'      
            + '                                     WIDTH=100   ALIGN=CENTER    MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=CMPL_NM       NAME=추첨여부'      
            + '                                     WIDTH=80    ALIGN=LEFT</FC>';
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    //디테일그리드
    } else if (gdGnb == "DTL") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'        
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=EVENT_CD     NAME=*행사코드'       
            + '                                     WIDTH=80    ALIGN=LEFT      LANGUAGE=1</FC>'
            + '<FC>ID=PRSNT_DT     NAME=사은품지급일자'       
            + '                                     WIDTH=110   ALIGN=CENTER    EDIT="NUMERIC"  MASK="XXXXXX-XXXXXXX"</FC>'
            + '<G>                  NAME=휴대폰번호'
            + '<C>ID=HP1_NO         NAME=*통신사'          
            + '                                     WIDTH=50    ALIGN=LEFT      EDIT="NUMERIC"</C>'
            + '<C>ID=HP2_NO         NAME=*국번'             
            + '                                     WIDTH=70    ALIGN=LEFT      EDIT="NUMERIC"</C>'
            + '<C>ID=HP3_NO         NAME=*번호'             
            + '                                     WIDTH=70    ALIGN=LEFT      EDIT="NUMERIC"</C></G>'            
            + '<G>                  NAME=전화번호'
            + '<C>ID=PHONE1_NO      NAME=*지역'             
            + '                                     WIDTH=50    ALIGN=LEFT      EDIT="NUMERIC"</C>'
            + '<C>ID=PHONE2_NO      NAME=*국번'             
            + '                                     WIDTH=70    ALIGN=LEFT      EDIT="NUMERIC"</C>'
            + '<C>ID=PHONE3_NO      NAME=*번호'             
            + '                                     WIDTH=70    ALIGN=LEFT      EDIT="NUMERIC"</C></G>'
            + '<C>ID=ADDR           NAME=주소'             
            + '                                     WIDTH=250   ALIGN=LEFT      LANGUAGE=1</C>'
            + '<C>ID=EMAIL          NAME=이메일주소'   
            + '                                     WIDTH=200   ALIGN=LEFT      EDIT="ALPHAETC" LANGUAGE=0</C>'
            + '<C>ID=RECP_NO        NAME=영수증번호'   
            + '                                     WIDTH=90    ALIGN=CENTER    SHOW=FALSE</C>'
            + '<C>ID=ENTY_PATH      NAME=응모경로'     
            + '                                     WIDTH=70    ALIGN=CENTER    SHOW=FALSE</C>';
        initGridStyle(GD_DETAIL, "COMMON", hdrProperies, true);
    }
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
 * 작 성 일 : 2011.01.24
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
    //조회전 디테일 변경내역 체크
    if (DS_IO_DETAIL.IsUpdated) {
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            //데이터셋 초기화 
            DS_IO_DETAIL.ClearData();
            EM_FILS_LOC.text = "";//경로명 표기 초기화
            return;
        } else {
            return;
        }
    } else {
        //데이터셋 초기화 
        DS_IO_DETAIL.ClearData();
        EM_FILS_LOC.text = "";//경로명 표기 초기화
    }
     
    if (!checkValidate())
        return;

    var strStrCd = LC_SEL_STR_CD.ValueOfIndex("CODE", LC_SEL_STR_CD.Index); //점코드
    var strEventSDate = EM_SEL_EVENT_SDATE.Text; //행시기간(From)
    var strEventEDate = EM_SEL_EVENT_EDATE.Text; //행시기간(To)
    var strEventCd = EM_SEL_EVENT_CD.Text;  //행사코드

    var goTo = "getMaster";
    var parameters = ""
            + "&strStrCd=" + encodeURIComponent(strStrCd)
            + "&strEventSDate=" + encodeURIComponent(strEventSDate) 
            + "&strEventEDate=" + encodeURIComponent(strEventEDate)
            + "&strEventCd="    + encodeURIComponent(strEventCd);
    TR_MAIN.Action = "/mss/mcae427.mc?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
    TR_MAIN.Post();
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //응모일자 체크
        var strEntryDt = (EM_ENTRY_DT.Text).replace(' ','');
        if (strEntryDt.length < 8) {
            showMessage(STOPSIGN, OK, "USER-1003", "응모일자");
            EM_ENTRY_DT.Focus();
            return;
        }
        
        //그리드 필수값 체크
        if (!checkDSBlank( GD_DETAIL, "1,3,4,5,6,7,8"))  return;
        //주소 문자열체크
        if (!checkValidateSave())  return;
        
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        }
        
        var strStrCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD"); //점코드
        var strEventCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "EVENT_CD"); //행사코드
        var strEntryDt = EM_ENTRY_DT.Text; //응모일자
        
        var goTo = "save";
        var parameters = ""
                + "&strStrCd="   + encodeURIComponent(strStrCd)
                + "&strEventCd=" + encodeURIComponent(strEventCd) 
                + "&strEntryDt=" + encodeURIComponent(strEntryDt);
        TR_MAIN.Action = "/mss/mcae427.mc?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_MAIN.Post();
        
        //저장 후 데이터셋을 비운다.
        DS_IO_DETAIL.ClearData();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011.01.24
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 행추가
 * return값 :
 */
function btn_AddRow() {
    var strDsMst_RowCnt = DS_O_MASTER.CountRow;
    if (strDsMst_RowCnt > 0) {
        GD_DETAIL.SetColumn("ENTY_NAME");
        DS_IO_DETAIL.AddRow();
        GD_DETAIL.SetColumn("ENTY_NAME");
    }
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
    var strDsMst_RowCnt = DS_O_MASTER.CountRow;
    if (strDsMst_RowCnt > 0) {
        DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
    }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * popupDateFromTo()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 일자 From ~ To POPUP
 * return값 :
 */
function popupDateFromTo(mod_Em) {
    if (mod_Em == "f") {
        openCal('G', EM_SEL_EVENT_SDATE);
    } else {
        openCal('G', EM_SEL_EVENT_EDATE);
    }
    //syncFromToDt(EM_SEL_EVENT_SDATE, EM_SEL_EVENT_EDATE,mod_Em);
}

/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
	 
    if (popupNm == "ent") {//행사팝업
        //점체크
        if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "점");
            LC_SEL_STR_CD.Focus();
            return;
        }  
    
        var strEntSdt = EM_SEL_EVENT_SDATE.Text;
        var strEntEdt = EM_SEL_EVENT_EDATE.Text;
         eventPop( EM_SEL_EVENT_CD, EM_SEL_EVENT_NM, LC_SEL_STR_CD.BindColVal, "", "5", "", strEntSdt, strEntEdt);
    }
}

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 값체크
 * return값 :
 */
function checkValidate() {
    //점체크
    if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_SEL_STR_CD.Focus();
        return;
    }  
    
    //시작, 종료일 일자체크
    var em_sdate = (trim(EM_SEL_EVENT_SDATE.Text)).replace(' ','');
    var em_edate = (trim(EM_SEL_EVENT_EDATE.Text)).replace(' ','');
    if (em_sdate.length < 8) {
        showMessage(STOPSIGN, OK, "USER-1003", "시작일");
        EM_SEL_EVENT_SDATE.Focus();
        return false;
    } else if (em_edate.length < 8) {
        showMessage(STOPSIGN, OK, "USER-1003", "종료일");
        EM_SEL_EVENT_EDATE.Focus();
        return false;
    }

    if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
        showMessage(STOPSIGN, OK, "USER-1015");
        EM_SEL_EVENT_SDATE.Focus();
        return false;
    }

    return true;
}


/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 값체크
 * return값 :
 */
function checkValidateSave() {
    var strEntS = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "EVENT_S_DT");
    var strEntE = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "EVENT_E_DT");
    var strEtDt = EM_ENTRY_DT.Text;
    if (strEtDt < strEntS || strEtDt > strEntE) {//행사기간이 아닐때
        showMessage(STOPSIGN, OK, "USER-1000", "응모일자는 선택한 행사 기간내("+strEntS+"~"+strEntE+")에만 적용이 가능합니다.");
        EM_ENTRY_DT.Focus();
        return false;
    }
        
    for (i=1; i<=DS_IO_DETAIL.CountRow; i++) {
        // 휴대폰번호 국번
        if (!firstTelFormat(DS_IO_DETAIL.NameValue(i,"HP1_NO"), "H")) {
            showMessage(STOPSIGN, OK, "USER-1000", "휴대전화의 통신사 번호형식이 맞지 않습니다.");
            DS_IO_DETAIL.RowPosition = i;
            GD_DETAIL.SetColumn('HP1_NO');
            return false;
        } 
        
        // 전화번호 지역번호
        if (!firstTelFormat(DS_IO_DETAIL.NameValue(i,"PHONE1_NO"), "T")) {
            showMessage(STOPSIGN, OK, "USER-1000", "올바르지 않은 지역번호 입니다.");
            DS_IO_DETAIL.RowPosition = i;
            GD_DETAIL.SetColumn('PHONE1_NO');
            return false;
        } 
    	
        //주소체크
        var tmpLenA = checkLenByte(DS_IO_DETAIL, i, "ADDR")
        if (tmpLenA > 80 ) {
            showMessage(STOPSIGN, OK, "USER-1048", "80");
            DS_IO_DETAIL.RowPosition = i;
            GD_DETAIL.SetColumn('ADDR');
            return false;
        } 
        
        //이메일체크
        var tmpLenE = checkLenByte(DS_IO_DETAIL, i, "EMAIL")
        if (tmpLenE > 40 ) {
            showMessage(STOPSIGN, OK, "USER-1048", "40");
            DS_IO_DETAIL.RowPosition = i;
            GD_DETAIL.SetColumn('EMAIL');
            return false;
        } 
    }
    return true;
}

/**
 * searchDtl()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 상세조회(마스터 그리드 선택시) - 미사용
 * return값 :
 */
function searchDtl(rowNo) {
    var strStrCd = DS_O_MASTER.NameValue(rowNo, "STR_CD"); //점코드
    var strEventCd = DS_O_MASTER.NameValue(rowNo, "EVENT_CD"); //행사코드

    var goTo = "getDetail";
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strEventCd=" + encodeURIComponent(strEventCd);
    TR_MAIN.Action = "/mss/mcae427.mc?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";//조회:O 입력:I
    //searchSetWait("R"); //처리상태표시
    TR_MAIN.Post();
}

/**
 * checkLenByte()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
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
 * 작 성 일 : 2011.01.24
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {
    var strDsMst_RowCnt = DS_O_MASTER.CountRow;
    if (strDsMst_RowCnt > 0) {//마스터(행사)에 선택된 정보가 있어야 한다.
        //Fils Open창
        INF_EXCELUPLOAD.Open();

        //loadExcelData 옵션처리
        var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
        if (strExcelFileName == "''")
            return;
        EM_FILS_LOC.text = strExcelFileName;//경로명 표기
        var strStartRow = 1; //시작Row
        var strEndRow = 0; //끝Row
        var strReadType = 0; //읽기모드
        var strBlankCount = 3; //공백row개수
        var strLFTOCR = 0; //줄바꿈처리 
        var strFireEvent = 1; //이벤트발생
        var strSheetIndex = 1; //Sheet Index 추가
        var strtrEtc = "1,0";//기타

        //DataSetID.Do("Excel.Application", "'FileName', nStartRow, nEndRow, nReadType, blankCount, LFCR, FireEvent, SheetIndex, DelimiterSymbol, StartCol") 
        var strOption = strExcelFileName
            + "," + strStartRow + "," + strEndRow + "," + strReadType 
            + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
            + "," + strSheetIndex + "," + strtrEtc;
        //Excel파일 DateSet에 저장               
        DS_IO_DETAIL.Do("Excel.Application", strOption);
    } else {
        //showMessage(INFORMATION, OK, "USER-1000","선택된 이벤트 내역이 없습니다.<br>  이벤트 내역을 조회,선택 후 <br>응모자를 등록하세요");
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    //마스터 선택 시 상세조회(선택 Row) 미사용
    if (DS_IO_DETAIL.IsUpdated) {//마스터 컬럼변경전 변경데이터 있을 시 저장하고 변경할 것인지 확인
        var ret = showMessage(Question, YesNo, "USER-1049");
        if (ret == "1") {
            //데이터셋 초기화 
            DS_IO_DETAIL.ClearData();
            EM_FILS_LOC.text = "";//경로명 표기 초기화
            return true;
        } else {
            return false;
        }
    } else {
        //데이터셋 초기화 
        DS_IO_DETAIL.ClearData();
        EM_FILS_LOC.text = "";//경로명 표기 초기화
        return true;
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
//조회된 내역이 있을 경우에만 등록(Excel업로드,행추가,행삭제) 활성화
if (DS_O_MASTER.NameValue(row, "CMPL_FLAG") == "N") {
    //등록 활성화
    enableControl(IMG_FILE_SEARCH, true);  //Excel찾기버튼
    enableControl(IMG_ADD_ROW, true);      //행추가
    enableControl(IMG_DEL_ROW, true);      //행삭제
} else {
    //등록 비활성화
    enableControl(IMG_FILE_SEARCH, false);  //Excel찾기버튼
    enableControl(IMG_ADD_ROW, false);      //행추가
    enableControl(IMG_DEL_ROW, false);      //행삭제
}
</script>

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language="javascript"  for=GD_DETAIL event=CanColumnPosChange(row,Colid)>
//주소의 문자열 체크
if (Colid == "ADDR") {
    var tmpLen = checkLenByte(DS_IO_DETAIL, row, Colid)
    if (tmpLen > 80 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "80");
        return false;
    }  else {
        return true;
    }
}

//이메일  문자열 체크
if (Colid == "EMAIL") {
    var tmpLen = checkLenByte(DS_IO_DETAIL, row, Colid)
    if (tmpLen > 40 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "40");
        return false;
    }  else {
        return true;
    }
}
</script>
 
<script language=JavaScript for=EM_SEL_EVENT_CD event=OnKillFocus()>
//[조회용]행사; 코드 자동완성 및 팝업호출
//if (EM_SEL_EVENT_CD.Text.length > 0 ) {
	if(!this.Modified)
        return;

	if(this.text==''){
    	EM_SEL_EVENT_NM.Text = "";
        return;
    }
    
    if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
        EM_SEL_EVENT_CD.Text = "";
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_SEL_STR_CD.Focus();
        return;
    }
    var strEntSdt = EM_SEL_EVENT_SDATE.Text;
    var strEntEdt = EM_SEL_EVENT_EDATE.Text;
    //setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_SEL_EVENT_CD, EM_SEL_EVENT_NM, LC_SEL_STR_CD.BindColVal, '5');
    setEventNmWithoutPop( 'DS_O_RESULT', EM_SEL_EVENT_CD, EM_SEL_EVENT_NM, 1, LC_SEL_STR_CD.BindColVal, "", "5","", strEntSdt, strEntEdt);
    if (DS_O_RESULT.CountRow == 1 ) {  
    	EM_SEL_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
        EM_SEL_EVENT_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
    } else {
        //1건 이외의 내역이 조회 시 팝업 호출  
       // eventPop( EM_SEL_EVENT_CD, EM_SEL_EVENT_NM, LC_SEL_STR_CD.BindColVal, "", "5", "", strEntSdt, strEntEdt);
    }
//}
</script>

<script language=JavaScript for=EM_ENTRY_DT event=onKillFocus()>
//응모일자
checkDateTypeYMD( EM_ENTRY_DT );
</script>

<script language=JavaScript for=EM_SEL_EVENT_SDATE event=onKillFocus()>
//[조회용]시작일 체크
checkDateTypeYMD( EM_SEL_EVENT_SDATE );
</script>

<script language=JavaScript for=EM_SEL_EVENT_EDATE event=onKillFocus()>
//[조회용]종료일 체크
checkDateTypeYMD( EM_SEL_EVENT_EDATE );
</script>

<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
   EM_SEL_EVENT_CD.Text = "";
   EM_SEL_EVENT_NM.Text = "";
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
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_O_STR_COMBO"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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

<DIV id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td  class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="100" class="point">점</th>
                        <td width="200"><comment id="_NSID_"><object
                            id=LC_SEL_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="197"
                            align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
                        <th width="100" class="point">행사기간</th>
                        <td ><comment id="_NSID_"><object
                            id=EM_SEL_EVENT_SDATE classid=<%=Util.CLSID_EMEDIT%> width="150"
                            align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:popupDateFromTo('f');" /> ~ <comment
                            id="_NSID_"><object id=EM_SEL_EVENT_EDATE
                            classid=<%=Util.CLSID_EMEDIT%> width="150" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:popupDateFromTo('t');" align="absmiddle" /></td>
                    </tr>
                    <tr> 
                        <th>행사코드</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_SEL_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=90
                            align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script> <img
                            src="/pot/imgs/btn/detail_search_s.gif"
                            onclick="javascript:callPopup('ent');" align="absmiddle" /> <comment
                            id="_NSID_"> <object id=EM_SEL_EVENT_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=203 align="absmiddle">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
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
        <td class="PB05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=130px classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_O_MASTER">
                </object></comment><script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
            <tr>
                <th width="60" class="point">응모일자</th>
                <td width="110"><comment id="_NSID_"><object
                    id=EM_ENTRY_DT style="vertical-align: middle;"
                    classid=<%=Util.CLSID_EMEDIT%> width="70"></object></comment><script>_ws_(_NSID_);</script><img
                    style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/date.gif"
                    onclick="javascript:openCal('G',EM_ENTRY_DT)" /></td>
                <th width="60">엑셀업로드</th>
                <td width="320"><comment id="_NSID_"><object
                    id=EM_FILS_LOC style="vertical-align: middle;"
                    classid=<%=Util.CLSID_EMEDIT%> width="250"></object></comment><script>_ws_(_NSID_);</script><img
                    id="IMG_FILE_SEARCH" style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/file_search.gif" width="62" height="18"
                    onclick="loadExcelData();" /></td>
                <td width="75" align="center"><a
                    href="/mss/samplefiles/eventEntyUpload.xls"> <img
                    style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/excel_down.gif" width="82" height="18" /></a></td>
                <td align="right"><img id="IMG_ADD_ROW" style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
                    onclick="btn_AddRow();" hspace="2" /><img id="IMG_DEL_ROW"
                    style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
                    onclick="btn_DeleteRow();" /></td>
            </tr>
        </table>
        </td>
        </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_DETAIL
                    width="100%" height=308 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_DETAIL">
                </object></comment><script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
