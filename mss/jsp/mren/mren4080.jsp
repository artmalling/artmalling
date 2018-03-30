<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비청구/입금관리 > 관리비 엑셀업로드
 * 작 성 일 : 2017.01.05
 * 작 성 자 : 윤지영
 * 수 정 자 : 
 * 파 일 명 : MREN408.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비를 엑셀 업로드 한다.
 * 이    력 : 2017.01.05 (윤지영) 신규작성
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
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	// PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript"> 
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_autoFlag = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 /** 
 * doInit()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.05
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;	//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
 function doInit(){ 
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    // 입력 Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_EXCEL.setDataHeader('<gauce:dataset name="H_SEL_EXCEL"/>');
    
    //그리드 초기화
    gridCreate();

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,  "CODE^0^30,NAME^0^100", 1, PK); //시설구분 
    initEmEdit(EM_S_CAL_SYM, "YYYYMM", PK);           //부과년월(FROM) 
    initEmEdit(EM_LOAD_DT,  "YYYYMMDD", PK);            //고유식별정보 수집 및 이용동의일자
    
    //콤보 초기화
    getFlc("DS_STR_CD", "M", "1", "Y", "N");          // 시설구분   
    LC_S_STR_CD.Focus();
    LC_S_STR_CD.Index = 0; 
    
    getVen("DS_VEN_CD", LC_S_STR_CD.BindColVal , "N"); // 협력사명
     
    EM_S_CAL_SYM.Text = getTodayFormat("YYYYMM");  
    EM_LOAD_DT.Text = "<%=toDate%>";
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mren408","DS_IO_MASTER" );
     
 }

 /**
 * gridCreate()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.05
 * 개    요 : 그리드SET
 * return값 : void
 */
 function gridCreate() {
    var hdrProperies =  
    	  '<FC>id={currow}    	 name="NO"       	 width=30    	align=center 	</FC>'
        + '<FC>id=VEN_CD         name="협력사코드 "      width=100    	align=center  	sumtext="합계"  </FC>' 
        + '<FC>id=VEN_CD         name="협력사명"      	 width=130    	align=center  	EditStyle=Lookup	Data="DS_VEN_CD:CODE:NAME"</FC>' 
        + '<FC>id=PAY_AMT        name="입금액"         width=100    	align=right     sumtext=@sum</FC>'
        + '<FC>id=PAY_DT         name="입금일자"     	 width=100    	align=center    mask="XXXX/XX/XX"</FC>' 
        + '<FC>id=PAY_ARR_AMT    name="연체액"       	 width=100    	align=right     sumtext=@sum</FC>'
        + '<FC>id=REMARK         name="비고"       	 width=180    	align=left      </FC>' 
        + '<FC>id=ERR_MSG        name="에러메세지"      width=280    	align=left      </FC>'   
		;
        
		initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
		GD_MASTER.ViewSummary = "1";
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
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.05
 * 개    요 : 조회시 호출
 * return값 : void
 */
 function btn_Search() {
    // parameters
    var strCd   	= LC_S_STR_CD.BindColVal;        // 시설구분
    var strCalym    = EM_S_CAL_SYM.Text;             // 부과년월  
    var strLoadDt   = EM_LOAD_DT.Text;             	 // 업로드 일자
    
    var goTo = "getMaster";
    var parameters = "&strCd="      + encodeURIComponent(strCd)
        		   + "&strCalym="   + encodeURIComponent(strCalym)
        		   + "&strLoadDt="  + encodeURIComponent(strLoadDt)
        		   ; 
    TR_MAIN.Action = "/mss/mren408.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.RealCount(1,DS_IO_MASTER.CountRow) );
    GD_MASTER.Focus(); 
 }

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

 /**
 * btn_Save()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.05
 * 개    요 : DB에 저장 
 * return값 : void
 */
 function btn_Save() { 
	 
	if(DS_IO_MASTER.CountRow == 0){
		showMessage(INFORMATION, OK, "GAUCE-1004");
		return;
	}  
	
	if(!checkValidation("Save"))    // validation 체크
		   return;  
	
	for(var i=1; i<=DS_IO_MASTER.CountRow;i++){
		if(DS_IO_MASTER.NameValue(i,"ERR_MSG") != "") {
			showMessage(INFORMATION, OK, "USER-1000", "에러메세지를 확인해주세요");
			setFocusGrid(GD_MASTER, DS_IO_MASTER, i, "ERR_MSG");
			return false;
		}  
	} 
	
	//변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){ 
    	GD_MASTER.Focus();
        return;
    }
	 
	for(var i=1; i<=DS_IO_MASTER.CountRow;i++){ 
		DS_IO_MASTER.UserStatus(i) = 1;
	}  
 
	// 저장 parameters 
	var strCd     = LC_S_STR_CD.BindColVal;   // 시설구분
	var strCalym  = EM_S_CAL_SYM.Text;        // 부과년월
	var strLoadDt = EM_LOAD_DT.Text;          // 업로드 일자

    var goTo = "save";
	var parameters = ""
				   + "&strCd=" + encodeURIComponent(strCd)
				   + "&strCalym=" + encodeURIComponent(strCalym) 
				   + "&strLoadDt=" + encodeURIComponent(strLoadDt) 
				   ;  
	TR_SAVE.Action = "/mss/mren408.mr?goTo=" + goTo + parameters;
	TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_SAVE.Post();
	
 }

 /**
 * btn_Excel()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.05
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {
    if (DS_IO_MASTER.CountRow > 0) {
        var ExcelTitle = "관리비 엑셀 업로드"   
        
        var excel_strcd = LC_S_STR_CD.BindColVal;   // [조회용]시설구분
        var excel_sGoal = EM_S_CAL_SYM.Text;        // [조회용]부가년월FROM
        
        var parameters = "시설구분="    +excel_strcd
                       + " - 부과년월=" +excel_sGoal;
        
        //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
        openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );
        GD_MASTER.Focus();
    } else {
        showMessage(INFORMATION, OK, "USER-1000", "조회 후 가능합니다.");
    }
 }

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.26
 * 개    요 : 출력
 * return값 : void
 */
function btn_Print() {
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/ 
 
 /**
 * loadExcelData()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.11
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
 function loadExcelData() {  

	if(!checkValidation("Load"))    // validation 체크
		   return;  
		
	//Fils Open창
	INF_EXCELUPLOAD.Open();
	
	//loadExcelData 옵션처리
	var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
	
	if (strExcelFileName == "''")
	    return;
	EM_FILS_LOC.text = strExcelFileName;//경로명 표기
	
	var strStartRow   = 1; //시작Row
	var strEndRow     = 0; //끝Row
	var strReadType   = 0; //읽기모드
	var strBlankCount = 3; //공백row개수
	var strLFTOCR     = 0; //줄바꿈처리 
	var strFireEvent  = 1; //이벤트발생
	var strSheetIndex = 1; //Sheet Index 추가
	var strtrEtc = "1,0";  //기타
	
	//DataSetID.Do("Excel.Application", "'FileName', nStartRow, nEndRow, nReadType, blankCount, LFCR, FireEvent, SheetIndex, DelimiterSymbol, StartCol") 
	var strOption = strExcelFileName
		    + "," + strStartRow + "," + strEndRow + "," + strReadType 
		    + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
		    + "," + strSheetIndex + "," + strtrEtc;
	
	//초기화
	DS_EXCEL.ClearData();
	DS_IO_MASTER.ClearData();
	
	//Excel파일 DateSet에 저장               
	DS_EXCEL.Do("Excel.Application", strOption);
	 
    //엑셀을 닫아준다.
    DS_EXCEL.Do("Excel.Close");
	 
    if(DS_EXCEL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "0 건 로드 되었습니다.");
        LC_S_STR_CD.Focus();
        return;
    } else {  
    	//Dataset import
    	DS_IO_MASTER.ImportData(DS_EXCEL.ExportData(1, DS_EXCEL.CountRow, true)); 
    	//순번처리
    	for (var row=1; row<=DS_EXCEL.CountRow; row++){  
    		DS_IO_MASTER.NameValue(row, "SEQ_NO") = row;
    	}	
        showMessage(INFORMATION, OK, "USER-1000", DS_IO_MASTER.CountRow+ " 건 로드 되었습니다.");
        EM_FILS_LOC.text = ""; 
        //엑셀 업로드시 체크 자동  처리
        loadExcelChk();
    } 
 }

 /**
 * loadExcelChk()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2017.01.11
 * 개    요 : 엑셀 체크 처리
 * return값 :
 */ 
 function loadExcelChk(){
	
	if(DS_IO_MASTER.CountRow == 0){
		showMessage(INFORMATION, OK, "USER-1000", "처리 할 내역이 없습니다.");
		return;
	} 

	var strCd    = LC_S_STR_CD.BindColVal;    // 시설구분
	var strCalym = EM_S_CAL_SYM.Text;         // 부과년월
	var strLoadDt = EM_LOAD_DT.Text;          // 업로드 일자


    var goTo = "tempProcess";
	var parameters = ""
				   + "&strCd=" 	   + encodeURIComponent(strCd)
				   + "&strCalym="  + encodeURIComponent(strCalym) 
				   + "&strLoadDt=" + encodeURIComponent(strLoadDt) 
				   ; 
	
	TR_CHECK.Action = "/mss/mren408.mr?goTo=" + goTo + parameters;
	TR_CHECK.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_CHECK.Post(); 
  
 }
 
 /**
 * checkValidation()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-01-03
 * 개    요        : 조회조건 값 체크 
 * return값 : void
 */
 function checkValidation(Gubun) {
        
    //엑셀 업로드시  Validation Check
 	if(Gubun == "Load") { 
 		if (LC_S_STR_CD.Text == "") {
 			showMessage(INFORMATION, OK, "USER-1000", "시설구분을 입력하세요. 엑셀파일을 다시 업로드 해주세요");
 			DS_IO_MASTER.ClearData();
 			LC_S_STR_CD.Focus();
 			return false;
 		} 

 		if (EM_S_CAL_SYM.Text == "") {
 			showMessage(INFORMATION, OK, "USER-1000", "부과년월을 입력하세요. 엑셀파일을 다시 업로드 해주세요");
 			DS_IO_MASTER.ClearData();
 			EM_S_CAL_SYM.Focus();
 			return false;
 		} 
 	//저장시  Validation Check
 	}else if(Gubun == "Save") {
 		if (LC_S_STR_CD.Text == "") {
 			showMessage(INFORMATION, OK, "USER-1000", "시설구분을 입력하세요.");
 			DS_IO_MASTER.ClearData();
 			LC_S_STR_CD.Focus();
 			return false;
 		} 

 		if (EM_S_CAL_SYM.Text == "") {
 			showMessage(INFORMATION, OK, "USER-1000", "부과년월을 입력하세요.");
 			DS_IO_MASTER.ClearData();
 			EM_S_CAL_SYM.Focus();
 			return false;
 		} 
 		
 		if (EM_LOAD_DT.Text == "") {
 			showMessage(INFORMATION, OK, "USER-1000", "업로드일자를 입력하세요.");
 			DS_IO_MASTER.ClearData();
 			EM_LOAD_DT.Focus();
 			return false;
 		}  
 	}  
 	return true; 
 } 
  
    
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
	//재조회 처리
	btn_Search();
</script>

<script language=JavaScript for=TR_CHECK event=onSuccess>
	for(i=0;i<TR_CHECK.SrvErrCount('UserMsg');i++) {
	    showMessage(INFORMATION, OK, "USER-1000", TR_CHECK.SrvErrMsg('UserMsg',i));
	}
	//재조회 처리
	btn_Search();
</script> 
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<script language=JavaScript for=TR_CHECK event=onFail>
	trFailed(TR_CHECK.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
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
<comment id="_NSID_"><object id="DS_IO_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CLOSE_YN"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EXCEL"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_VEN_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENT_TYPE"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
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

<comment id="_NSID_">
<object id="TR_CHECK" classid=<%=Util.CLSID_TRANSACTION%>>
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
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
}
</script>
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
	                        <th  width="70" class="point">시설구분</th>
	                        <td  width="115"><comment id="_NSID_"><object
	                            id=LC_S_STR_CD  classid=<%=Util.CLSID_LUXECOMBO%> width="110"
	                            tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
	                        <th width="70" class="point">부과년월</th> 
	                        <td colspan="2" width="110"><comment id="_NSID_"><object id=EM_S_CAL_SYM
	                            classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
	                            onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
		                        </object></comment><script>_ws_(_NSID_);</script>
		                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
		                         	onclick="javascript:openCal('M',EM_S_CAL_SYM);" /> </td>
		                         	 
                          	 
	                    </tr>
	                    <tr>
	                    	<th width="70" class="point">업로드일자</th>
							<td width="115"><comment id="_NSID_"> <object
								id=EM_LOAD_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_LOAD_DT)"/></td> 
	                    	<th width="70" >엑셀업로드</th>
			                <td width="320" ><comment id="_NSID_"><object
			                    id=EM_FILS_LOC style="vertical-align: middle;"
			                    classid=<%=Util.CLSID_EMEDIT%> width="250"></object></comment><script>_ws_(_NSID_);</script>
			                    <img id="IMG_FILE_SEARCH" style="vertical-align: middle;"
			                    src="/<%=dir%>/imgs/btn/file_search.gif" width="62" height="18"
			                    onclick="loadExcelData();"/> </td> 
			                 <td><a href="/mss/samplefiles/calpayUpload.xls"><img
			                    style="vertical-align: middle;"
			                    src="/<%=dir%>/imgs/btn/excel_down.gif" width="82" height="18" /></a></td> 
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
                    width="100%" height=474 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID"       value="DS_IO_MASTER">
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
