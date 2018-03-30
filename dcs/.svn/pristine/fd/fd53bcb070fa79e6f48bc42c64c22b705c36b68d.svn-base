<!-- 
 * 시스템명 : 포인트카드 > 고객관리 > 회원관리 > 회원조회
 * 작 성 일 : 2016.11.01
 * 작 성 자 : KHJ
 * 수 정 자 : 
 * 파 일 명 : dctm5050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String fromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());  
    fromDate = fromDate + "01";
    String toDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
    
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

var	now	= new Date();
var	mon	= now.getMonth()+1;
if(mon < 10)mon	= "0" +	mon;
var	day	= now.getDate();
if(day < 10)day	= "0" +	day;
var varbfYear= now.getYear()-1; //전년도
var	varToday = now.getYear().toString()+ mon + day;
var	varToMon = now.getYear().toString()+ mon;
var	varBf_Year_Mon = varbfYear.toString()+ mon;
var old_Row = 0;
var strRegFlag = "0";  	// 0 : 조회자료, 1 : 엑셀 업로드자료
var nDisplayRow = 100;	// 그리드에 출력할 Row 갯수
var nPageNum = 0;		// Page 번호

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 180;		//해당화면의 동적그리드top위치
function doInit(){

    //Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top-80) + "px";
	
	obj   = document.getElementById("GD_MASTER2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top+30) + "px";
	
    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');			// 조회화면(회원리스트)
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER2"/>');		// 조회화면(발송리스트)
    DS_O_EXCELTEMP.setDataHeader('<gauce:dataset name="H_EXCELTEMP"/>');	// 엑셀 업로드 데이터셋(임시)
    DS_O_CONTENT.setDataHeader('<gauce:dataset name="H_CONTENT"/>');		// 발송 내용
    DS_O_RESULT.setDataHeader('<gauce:dataset name="H_MASTER"/>');			// 조회or엑셀업로드 데이터셋 
    DS_O_TEMP.setDataHeader('<gauce:dataset name="H_MASTER"/>');			// 발송내역 등록시 1000건씩 나누기 위한 임시 데이터셋
    DS_O_SEQ.setDataHeader('<gauce:dataset name="H_SEL_SEQ"/>');			// 문자 발송등록 채번 데이터셋
    
    //그리드 초기화
    gridCreate1(); // 수신자
    gridCreate2(); // 발송리스트
    
    var strOrgFlag = "1";
    
    // 탭 초기화
    initTab("TAB_MAIN");
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT, "YYYYMMDD", PK);         // 발송일(등록탭)
    initEmEdit(EM_REG_DT, "YYYYMMDD", PK);          // 등록일(발송탭)
    initEmEdit(EM_SUBJ,   "GEN^40", PK); 			// 문자제목
    initEmEdit(EM_RTN_NO, "GEN^13", PK); //내용		// 회신번호
    initEmEdit(TXT_EM_MEMO,   "GEN^2000", NORMAL); 	// 문자 내용(등록탭)
    initEmEdit(TXT_EM_MEMO2,   "GEN^2000", NORMAL); // 문자 내용(발송탭)
    initEmEdit(EM_ADDR,    "GEN^100",    NORMAL);   //주소
    initEmEdit(EM_ENTR_FR, "YYYYMMDD", PK);         // 가입일 (from)
    initEmEdit(EM_ENTR_TO, 	"YYYYMMDD", PK);        // 가입일 (to)
    initEmEdit(EM_FROM_POINT, 	"NUMBER^9^0", NORMAL);	// 포인트(from)
    initEmEdit(EM_TO_POINT, 	"NUMBER^9^0", NORMAL);  // 포인트(to)    
    initEmEdit(EM_AGE_FR, 	"NUMBER^9^0", NORMAL);      // 연령(from)
    initEmEdit(EM_AGE_TO, 	"NUMBER^9^0", NORMAL);      // 연령(to)
    initEmEdit(EM_PUMBUN_CD,   "CODE^6^0", NORMAL);     //브랜드코드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN^40",   READ);       //브랜드명(조회)
    initEmEdit(EM_SALE_FR, "YYYYMMDD", PK);            	// 매출시작일
    initEmEdit(EM_SALE_TO, 	"YYYYMMDD", PK);            // 매출종료일
    initEmEdit(EM_FILS_LOC, "GEN^500", READ); 			//EXCEL경로
    initEmEdit(EM_SEND_CNT, 	"NUMBER^9^0", NORMAL);  // 발송건수
      
    // Luxe Combo 초기화
    initComboStyle(LC_SEX_CD, 	DS_O_SEX_CD,	"CODE^0^30,NAME^0^110", 1, PK); 	//성별
    initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK); 	// 점(조회)
    initComboStyle(LC_DEPT_CD,	DS_DEPT_CD,		"CODE^0^30,NAME^0^80",  1, NORMAL);	// 팀(조회)
    initComboStyle(LC_TEAM_CD,	DS_TEAM_CD,		"CODE^0^30,NAME^0^80",  1, NORMAL);	// 파트(조회)
    initComboStyle(LC_PC_CD,	DS_PC_CD,		"CODE^0^30,NAME^0^80",  1, NORMAL);	// PC(조회)
    initComboStyle(LC_FLOOR_CD,	DS_O_FLOOR_CD,  "CODE^0^30,NAME^0^80",  1, NORMAL);	// 층(조회)

    // 콤보 데이터셋에 자료 조회    
    getEtcCode("DS_O_SEX_CD", "D", "D002", "Y");	// 성별
    getStore("DS_IO_STR_CD"	, "Y", "", "N");		// 점코드
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                        	// 팀
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); 	// 파트
    getPc2("DS_PC_CD", "Y",     LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC    
    getEtcCode("DS_O_FLOOR_CD", "D", "P061", "Y");	// 층
    
    // 컴포넌트 로딩시 onSelChange 이벤트가 동작되지 않아 그를 위한 timeout 
    setTimeout("LC_STR_CD.index   = 1;",30);
    setTimeout("LC_STR_CD.index   = 0;",30);

    // 컴포넌트 초기값.
    LC_DEPT_CD.index = 0;
    LC_SEX_CD.index = 0;
    LC_TEAM_CD.index = 0;
    LC_PC_CD.index   = 0;
    LC_FLOOR_CD.index   = 0;
    EM_PUMBUN_CD.text 		= "";
	EM_PUMBUN_NAME.text		= "";
	EM_PUMBUN_CD.Enabled 	= false;
	LC_FLOOR_CD.Enable	= false;
	EM_FROM_POINT.Text = 0;
    EM_TO_POINT.Text = 999999999;
    EM_SEND_CNT.Text = 999999999;
    EM_AGE_FR.Text = 0;
    EM_AGE_TO.Text = 999;
    EM_ENTR_FR.Text = <%=fromDate%>;
    EM_ENTR_TO.Text = <%=toDate%>;
    EM_SALE_FR.Text = <%=fromDate%>;
    EM_SALE_TO.Text = <%=toDate%>;
    EM_FROM_DT.Text = varToday;
    EM_REG_DT.Text 	= varToday;
    EM_FROM_DT.Enable = false;
    EM_REG_DT.Enable = false;
    TXT_EM_MEMO.Enable = true;
    TXT_EM_MEMO2.Enable = true;
    TXT_EM_MEMO2.Readonly = true;
    EM_FILS_LOC.text ="";
    RD_GROUP.CodeValue = 1;
    RD_GROUP2.CodeValue = 1;
    document.getElementById("IMG_SEND_PROC").src="/<%=dir%>/imgs/btn/send_pre.gif";
    
  	//화면OPEN시 "조회조건" 내용들은 false로 
    condOnOff(false);
  	
	// 페이지 카운트 초기화  	
    countPage(0,0);
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"           width=40    edit=none	align=center color={if(ERR<>"","red")}  </FC>'
    				//+ '<FC>id=CHK           name="선택"         width=60    align=center    HeadCheckShow=true EditStyle=CheckBox </FC>'
    				+ '<FC>id=CUST_NAME    	name="수신자명"     width=100   edit=none	show=true	color={if(ERR<>"","red")} sumtext ="합  계" </FC>'
                    + '<FC>id=HP_NO	    	name="수신번호" 	width=100  	edit=none	align=center color={if(ERR<>"","red")} </FC>'
                    + '<FC>id=CUST_ID    	name="수신자ID" 	width=100   edit=none	align=center color={if(ERR<>"","red")}  </FC>'
                    + '<FC>id=CUST_PT  		name="가용포인트"	width=100   edit=none	align=center color={if(ERR<>"","red")} </FC>'
                    + '<FC>id=ROW_NUM  		name="ROW_NUM" 		width=100   edit=none	align=center color={if(ERR<>"","red")} show=false</FC>'
                    ;
    initGridStyle(GD_MASTER, "common", hdrProperies, true); 
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     name="NO"           	width=40    edit=none	align=center color={if(SEND_FLAG="0","blue")}  </FC>'
    			//	+ '<FC>id=CHK           name="선택"         		width=60    align=center    HeadCheckShow=true EditStyle=CheckBox </FC>'
    				+ '<FC>id=REG_ID    	name="등록자"      		width=100   edit=none	show=true	color={if(SEND_FLAG="0","blue")} </FC>'
                    + '<FC>id=REG_DATE    	name="등록일자" 			width=100  	edit=none	align=center color={if(SEND_FLAG="0","blue")} </FC>'
                    + '<FC>id=SUBJ	    	name="제목" 				width=180   edit=none	align=left color={if(SEND_FLAG="0","blue")} </FC>'
                    + '<FC>id=REG_CNT  		name="등록건수"	 		width=100   edit=none	align=right color={if(SEND_FLAG="0","blue")} </FC>'
                    + '<FC>id=SEND_GB  		name="발송구분" 			width=100  edit=none	align=center color={if(SEND_FLAG="0","blue")} </FC>'
                    + '<FC>id=SEND_YN  		name="발송승인" 			width=80  	edit=none	align=center color={if(SEND_FLAG="0","blue")} </FC>'
                    + '<FC>id=TRAN_GRP  	name="발송그룹번호" 		width=100  	edit=none	align=center color={if(SEND_FLAG="0","blue")} </FC>'
                    ;
    initGridStyle(GD_MASTER2, "common", hdrProperies, true); 
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}     name="NO"           	width=40    edit=none	align=center color={if(ERR<>"","red")}  </FC>'
    				//+ '<FC>id=CHK           name="선택"         		width=60    align=center    HeadCheckShow=true EditStyle=CheckBox </FC>'
    				+ '<FC>id=MAEJANG_NAME  name="｛매장명｝"      		width=100   edit=none	show=true	color={if(ERR<>"","red")} sumtext ="합  계" </FC>'
                    + '<FC>id=HP_NO	    	name="수신번호" 			width=100  	edit=none	align=center color={if(ERR<>"","red")} </FC>'
                    + '<FC>id=TOT_AMT    	name="｛누계｝" 			width=100   edit=none	align=right color={if(ERR<>"","red")}  </FC>'
                    + '<FC>id=SALE_AMT    	name="｛매출｝" 			width=100   edit=none	align=right color={if(ERR<>"","red")}  </FC>'
                    + '<FC>id=SALE_CNT    	name="｛건수｝" 			width=100   edit=none	align=right color={if(ERR<>"","red")}  </FC>'
                    + '<FC>id=REG_CNT    	name="｛상품｝" 			width=100   edit=none	align=right color={if(ERR<>"","red")}  </FC>'
                    + '<FC>id=RANK    		name="｛순위｝" 			width=100   edit=none	align=center color={if(ERR<>"","red")}  </FC>'
                    ;
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
	// 현재 탭상태 확인
	switch(getTabItemSelect("TAB_MAIN")){
	    case 1:	// 등록탭
	    	if (RD_GROUP2.CodeValue !=1) {	// "업무구분"이 일반이 아닐 경우
	    		showMessage(QUESTION, OK, "USER-1000","온라인매출용 발송에서는 사용할 수 없는<br> 기능입니다.");
	    		break;
	    	}    	
	    	searchCust();	// 조회 시작
	        break;
	        
	    case 2:	//발송탭
	    	searchList();	// 조회 시작
	        break;
	}
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    var strFromDt = EM_FROM_DT.text;      				//시작일자
    var ExcelTitle = "문자발송리스트"
    var parameters =  "발송 월="   + strFromDt;
    openExcel2(GD_MASTER, ExcelTitle, parameters, true );
}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {
	// 현재 탭상태 확인
	switch(getTabItemSelect("TAB_MAIN")){
    case 1:	// 등록탭
    	if(DS_O_RESULT.CountRow>0){	// 이미 조회된 내용이 있을 경우 초기화 동의 메세지 팝업
    		if(showMessage(QUESTION, YESNO, "USER-1000","현재의 내용을 초기화 하고 신규로 작성하시겠습니까?") != 1){
    		return false;
    		}
        }
        loadExcelData();	// 엑셀자료 업로드 프로세스
        break;
        
    case 2:	// 발송탭 (발송탭에서는 신규 버튼 비활성)
    	showMessage(QUESTION, OK, "USER-1000","해당 탭에서는 사용할 수 없는 기능입니다.")
        break;
	}
}

/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 저장
 * return값 : void
 */
function btn_Save() {
	// 현재 탭상태 확인
	switch(getTabItemSelect("TAB_MAIN")){
    case 1:	// 등록탭
    	if (strRegFlag=="0") 	// 조회된 고객자료의 경우
    		regProcess();
    	else
    		regProcess_excel(); // 엑셀 업로드 자료의 경우
    	
        break;
    		
    case 2: // 발송탭 (발송탭에서는 저장버튼 대신 발송 버튼 신규 추가)
    	showMessage(QUESTION, OK, "USER-1000","해당 탭에서는 사용할 수 없는 기능입니다.")
        break;
	}
}


/**
 * btn_Delete()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 삭제
 * return값 : void
 */
function btn_Delete() {
	// 현재 탭상태 확인
	switch(getTabItemSelect("TAB_MAIN")){
    case 1:	// 등록탭 (등록탭에서는 삭제 업무 비활성)
    	showMessage(QUESTION, OK, "USER-1000","해당 탭에서는 사용할 수 없는 기능입니다.");
        break;
    	
    case 2:	// 발송탭
    	// 발송 유무 확인
    	var strSendFlag = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition, "SEND_FLAG");
    	
    	if (strSendFlag!="0") 	// 기발송자료는 삭제 불가.
    		showMessage(QUESTION, OK, "USER-1000","이미 발송된 내역은 삭제할 수 없습니다.");
    	else 					// 미발송 자료 삭제 처리
    		delProcess();
    	break;
	}
}

/**
 * loadExcelData()
 * 작 성 자 : 김광래
 * 작 성 일 : 2016.12.26
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {

	var strRtn = "";
	
	var nFailCnt = 0;
	varSendCnt = 0;
	INF_EXCELUPLOAD.Value = "";
	EM_FILS_LOC.text = "";
	DS_O_EXCELTEMP.ClearData();
	DS_O_MASTER.ClearData();
	DS_O_RESULT.ClearData();
	
	INF_EXCELUPLOAD.Open();
	
	if (INF_EXCELUPLOAD.Value == "") return;
	
	//loadExcelData 옵션처리
	var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
	if (strExcelFileName == "''")
	    return;
	
	EM_FILS_LOC.text  = strExcelFileName;  //경로명 표기
	var strStartRow   = 2;                 //시작Row
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
	
	searchSetWait("B");
	
	// Excel파일 DateSet에 저장               
    DS_O_EXCELTEMP.Do("Excel.Application", strOption);
	
	/*
	// 1000건 이상의 자료는 등록 불가(부하 발생.)
	if (DS_O_EXCELTEMP.CountRow > 1000 ) {
		searchDoneWait();
		showMessage(INFORMATION, OK, "USER-1000","총 1000 건 초과되는 자료는 업로드 하실 수 없습니다." );
		DS_O_EXCELTEMP.ClearData();
		return false;
	}
	*/
	// 데이터 import 후 excel 종료
	DS_O_EXCELTEMP.Do("Excel.Close");
	
	// 자료 없을 경우 종료
	if (DS_O_EXCELTEMP.CountRow < 1) {
		showMessage(INFORMATION, OK, "USER-1000","업로드 내용이 존재하지 않습니다." );
		return;
	}
	
	/*
	if (RD_GROUP2.CodeValue == 1) {
	
		// 번호 중복 검사.
		for(nRow = DS_O_EXCELTEMP.CountRow; nRow >= 1; nRow--){
			
			strRtn = "";
			
			strRtn = chkCardNoDup(nRow);
			
			if (strRtn.length !=0) {
				
				//DS_O_EXCELTEMP.NameValue(nRow,"CHK") = "F";
				//DS_O_EXCELTEMP.NameValue(nRow,"ERR") = strRtn;
				DS_O_EXCELTEMP.DeleteRow(nRow);
				
				nFailCnt = nFailCnt+1;			
			}
			else{
				//DS_O_EXCELTEMP.NameValue(nRow,"CHK") = "T";
				varSendCnt = varSendCnt + 1;
			}
			
		}
	}
	*/
	
	// Excel에서 가져온 DATASET을 등록용 DATASET에 import 한다
	var strData = DS_O_EXCELTEMP.ExportData(1,DS_O_EXCELTEMP.CountRow, true );
	DS_O_RESULT.ImportData(strData);
	DS_O_EXCELTEMP.ClearData();
	
	if (DS_O_RESULT.CountRow>0){
		// 페이징을 위한 행 번호입력 
		for (var i = 1; i <= DS_O_RESULT.CountRow; i++) {
			DS_O_RESULT.NameValue(i,"ROW_NUM") = i;
		}
	    nPageNum = 1;
	    var nLstPage = Math.floor(DS_O_RESULT.CountRow / 100) + 1; 	// 마지막 페이지 번호
	    countPage(nPageNum,nLstPage);								// 페이지 카운드 표기
	    var strData = DS_O_RESULT.ExportData(1, 100, true);			// 첫 조회화면 1~100행
	    DS_O_MASTER.ImportData(strData);							// 그리드 DATASET에 import
	    DS_O_MASTER.ResetStatus();									// DATASET 자료들의 상태 초기화
    } else {
    	nPageNum = 0;
    	countPage(nPageNum,nPageNum);
    }
	
	setPorcCount("SELECT", DS_O_RESULT.CountRow);
	searchDoneWait();
	
	showMessage(INFORMATION, OK, "USER-1000","총 "+DS_O_RESULT.CountRow + "건 업로드 완료하였습니다." );
	
	strRegFlag = "1"; // 엑셀 업로드시 플래그 변경 : 1;
}

function chkCardNoDup(RowNum) {	// 미사용
	
	var nLp;
	var strCmprCardNo	= "";
	var strCmprCustNm	= "";
	var strCardNo		= DS_O_EXCELTEMP.NameValue(RowNum,"HP_NO");
	var strErr			= "";
	
	//alert(strCardNo);
		
	for(nLp = 1; nLp < RowNum; nLp++){
		strCmprCardNo	= DS_O_EXCELTEMP.NameValue(nLp,"HP_NO");
		//alert(strCmprCardNo);
		if (strCardNo==strCmprCardNo) {
			strErr = "ERR";
			//strCmprCustNm = DS_O_EXCELTEMP.NameValue(nLp,"HP_NO");
			//strErr = strErr + strCmprCustNm + '],'
			//alert(strErr);
			return strErr;
		}
	}
	return strErr;
}

/**
 * GetStrLengthB(str)
 * 작 성 자 : jyk
 * 작 성 일 : 2018.03.16
 * 개    요 : 문자열 Byte 수 반환
 * return값 : strLength
 */ 
function GetStrLengthB(str) {

	var nLength = 0;

	for (i = 0; i < str.length; i++)
	{
	var code = str.charCodeAt(i)
	var ch = str.substr(i,1).toUpperCase()

	code = parseInt(code)

	if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0)))
		nLength = nLength + 2;
	else
		nLength = nLength + 1;
	}	
	
	return nLength;
}

/**
 * CutStrByte(str, len)
 * 작 성 자 : jyk
 * 작 성 일 : 2018.03.16
 * 개    요 : 문자열을 해당 길이만큼 자르기.
 * return값 : String
 */ 
function CutStrByte(str, len) {

	var count = 0;
	var j = 0;
	
	for(var i = 0; i < str.length; i++) {
			
		var code = str.charCodeAt(i)
		var ch = str.substr(i,1).toUpperCase()
		code = parseInt(code)

		if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0)))
			count = count + 2;
		else
			count = count + 1;
		
		if(count >  len) {
			if(escape(str.charAt(i)) == "%0A")
				i--;
			break;	
		}
	}
	return str.substring(0, i);
}

/**
 * regProcess()
 * 작 성 자 : jyk
 * 작 성 일 : 2018.03.16
 * 개    요 : 조회 내용을 
 * return값 : 
 */ 
function regProcess() {	// 조회 회원 자료 발송 등록.
	
	//DS_O_RESULT.ClearData();
	DS_O_TEMP.ClearData();
	DS_O_SEQ.ClearData();
	DS_O_CONTENT.ClearData();
	DS_O_CONTENT.AddRow();
	
	var nRow= 0;
	var strStrCd  = LC_STR_CD.BindColVal;				//점
    var strFromDt = EM_ENTR_FR.text;      				//시작일자
    var strToDt   = EM_ENTR_TO.text;       				//종료일자
    var nRegCnt	  = 1000;								//등록 단위
    var nStartIdx = 1;									// 시작 레코드 번호
    var nRowCnt   = 0;									// 조회내역건수
    var nTemp     = 0;									// 진행 건수
    var nForNum   = 0;
    var strData   = "";
    var strSEX_CD     = LC_SEX_CD.BindColVal;			// 성별
    var strPoint_from = EM_FROM_POINT.text;        		// 포인트
    var strPoint_to   = EM_TO_POINT.text;       		// 포인트 
    var strSMs        = "";								// SMS수신거부제외
    var strContent	= TXT_EM_MEMO.TEXT;					// 내용
    var strSubj 	= EM_SUBJ.text;						// 제목
    var strHOME_ADDR   = EM_ADDR.Text;					// 주소	
    
    
    if (RD_GROUP2.CodeValue==1)
    	var strOpGubun = "1";
   	else
   		var strOpGubun = "2";
    
    if (CHK_SMS.checked == true) {
    	strSMs        = "Y";	
    } else {
    	strSMs        = "%";
    }
   
    DS_O_CONTENT.NameValue(1,"MSG") = strContent;
    DS_O_CONTENT.UserStatus(1)="1";
    
    var strRtnNo	= EM_RTN_NO.TEXT;	// 회신번호
    strRtnNo		= strRtnNo.trim();
    
    if (strRtnNo=="")					// 회신번호 공란일 경우 기본 번호.
    	strRtnNo = "1800-5550";

     // 오류내용 검사
	 if (strSubj.length == 0){
		 showMessage(INFORMATION, OK, "USER-1000","문자 제목은 필수 항목입니다.");
		 EM_SUBJ.focus();
		 return false;
	 }
     
	 if (GetStrLengthB(strSubj) > 40){
		 showMessage(INFORMATION, OK, "USER-1000","문자 제목은 40 Byte를 초과할 수 없습니다. 현재 Byte : " + GetStrLengthB(strSubj));
		 EM_SUBJ.focus();
		 return false;
	 }
     
	 if (strContent.length == 0){
		 showMessage(INFORMATION, OK, "USER-1000","문자 내용은 필수 항목입니다.");
		 TXT_EM_MEMO.focus();
		 return false;
	 }
	 
	 var nMsgLength = GetStrLengthB(strContent);
	 var nMaxLength = document.getElementById("memo_maxlength").value;
	 
	 if (nMsgLength > nMaxLength) {
		 showMessage(INFORMATION, OK, "USER-1000","작성내용의 글자수가 제한된 수보다 초과 합니다.(최대 "+nMaxLength+"자)");
		 TXT_EM_MEMO.focus();
		 return false;		 
	 }
	 
	 if (DS_O_RESULT.CountRow==0) {
		 showMessage(INFORMATION, OK, "USER-1000","발송할 연락처가 존재하지 않습니다.");
		 return false;
	 }
	// 오류내용 검사 끝.

	
	//변경또는 신규 내용을 저장하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
    	return false;

	
	if ( strRtnNo.length == 0 )  // 공란일시 대표번호로 (위에 있지만 그냥 넣어둠.)
		strRtnNo = "1800-5550"; 
	
	searchSetWait("B");
	/*    
    var goTo        = "searchCust";    
    var action      = "O";     
    var parameters  = "&strStrCd="     	   + encodeURIComponent(strStrCd)
			        + "&strFromDt="        + encodeURIComponent(strFromDt)
			        + "&strToDt="     	   + encodeURIComponent(strToDt) 
			        + "&strSubj="    	   + encodeURIComponent(strSubj)
                    + "&strSEX_CD="        + encodeURIComponent(strSEX_CD)
                    + "&strPoint_from="    + encodeURIComponent(strPoint_from)
                    + "&strPoint_to="      + encodeURIComponent(strPoint_to)
                    + "&strSMs="           + encodeURIComponent(strSMs)
                    + "&strRtnNo="   	   + encodeURIComponent(strRtnNo)
                    + "&strHOME_ADDR="     + encodeURIComponent(strHOME_ADDR)
                    + "&strContent="       + encodeURIComponent("")
                    + "&strGb="       	   + encodeURIComponent("reg")
                    ;
                  
    TR_MAIN.Action  = "/dcs/dctm505.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_TEMP=DS_O_TEMP)"; //조회는 O
    TR_MAIN.Post();    
    //alert(DS_O_RESULT.CountRow);
    */
    
    // 발송 등록 순번 채번
	var goTo        = "seqSlpNo";    
    var action      = "O";     
    var parameters  = "";
   
    TR_MAIN.Action  = "/dcs/dctm505.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_SEQ=DS_O_SEQ)"; //조회는 O
    TR_MAIN.Post();  
	
    if (DS_O_SEQ.CountRow != 0) {
    	strSeqNo	= DS_O_SEQ.NameValue(1, "SEQ_NO");
    }
    else{
    	showMessage(INFORMATION, OK, "USER-1000","[오류] 문자 발송 채번에 실패하였습니다.");
    	return;
    }
    
    searchSetWait("B");
    
    nRowCnt = DS_O_RESULT.CountRow;
	
	var strSendDate = EM_FROM_DT.text; 
	var strSendGb	= RD_GROUP.CodeValue;
	if  (strSendGb==1) strSendGb = "SMS";	// 1: 단문(sms) 2: 장문(lms)
	else strSendGb = "LMS";
	
	// for문 loop 횟수
	nForNum = Math.ceil(nRowCnt/nRegCnt);
	
	for(var i = 1; i <= nForNum; i++) {
		DS_O_TEMP.ClearData();		
		nTemp = nTemp + nRegCnt;
		if (nTemp > nRowCnt ) {
			nRegCnt = nRegCnt - (nTemp - nRowCnt);
		}
		strData = DS_O_RESULT.ExportData(nStartIdx,nRegCnt, true );
		DS_O_TEMP.ImportData(strData);
	    for (nRow=1; nRow <= DS_O_TEMP.CountRow; nRow++)
    	{
	    	DS_O_RESULT.UserStatus(nRow) = 1; // 상태값을 변경하여 저장하도록 한다.
    	}
		parameters =  "&strSendDate="      	+encodeURIComponent(strSendDate)
        			+ "&strSendGb="      	+encodeURIComponent(strSendGb)
        			+ "&strContent="		+encodeURIComponent("")
        			+ "&strOpGubun="		+encodeURIComponent(strOpGubun)
        			+ "&strSeqNo="         + encodeURIComponent(strSeqNo)
	    			;
		if (i == nForNum) {
			TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=save"+parameters;
			TR_MAIN2.KeyValue = "SERVLET(I:DS_O_TEMP=DS_O_TEMP,I:DS_O_CONTENT=DS_O_CONTENT)"; 
			TR_MAIN2.Post();
		} else {
			TR_MAIN3.Action = "/dcs/dctm505.dm?goTo=save"+parameters;
			TR_MAIN3.KeyValue = "SERVLET(I:DS_O_TEMP=DS_O_TEMP,I:DS_O_CONTENT=DS_O_CONTENT)"; 
			TR_MAIN3.Post();
		}

		nStartIdx = nStartIdx + nRegCnt; 
	}
	
	/*
	parameters =  "&strSendDate="      	+encodeURIComponent(strSendDate)
	            + "&strSendGb="      	+encodeURIComp
	            onent(strSendGb)
	            + "&strContent="			+encodeURIComponent("")
	            + "&strOpGubun="			+encodeURIComponent(strOpGubun)
			    ;
	TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=save"+parameters;
	TR_MAIN2.KeyValue = "SERVLET(I:DS_O_RESULT=DS_O_RESULT,I:DS_O_CONTENT=DS_O_CONTENT)"; 
	TR_MAIN2.Post();
	
	*/
 }


function regProcess_excel() { // 엑셀 업로드자료 발송 등록.

	DS_O_TEMP.ClearData();
	DS_O_CONTENT.ClearData();
	DS_O_CONTENT.AddRow();
	
	var nRow= 0;
    var nRegCnt	  = 1000;								//등록 단위
    var nStartIdx = 1;									// 시작 레코드 번호
    var nRowCnt   = 0;									// 조회내역건수
    var nTemp     = 0;									// 진행 건수
    var nForNum   = 0;
    var strData   = "";
    var strMsg  	= TXT_EM_MEMO.text;
	var strSubj 	= EM_SUBJ.text;
	var strRtnNo	= EM_RTN_NO.text;
	var strCustNm 	= "";
	var strCustId 	= "";
	var strCustPt 	= "";
	var strHpNo	= "";
	if (RD_GROUP2.CodeValue==1)
		var strOpGubun = "1";
	else
	 	var strOpGubun = "2";
	    
	// 오류내용 검사
	 if (strSubj.length == 0){
		 showMessage(INFORMATION, OK, "USER-1000","문자 제목은 필수 항목입니다.");
		 EM_SUBJ.focus();
		 return false;
	 }
	 if (strMsg.length == 0){
		 showMessage(INFORMATION, OK, "USER-1000","문자 내용은 필수 항목입니다.");
		 TXT_EM_MEMO.focus();
		 return false;
	 }
	 var nMsgLength = GetStrLengthB(strMsg);
    var nMaxLength = document.getElementById("memo_maxlength").value;
	 if (nMsgLength > nMaxLength) {
		 showMessage(INFORMATION, OK, "USER-1000","작성내용의 글자수가 제한된 수보다 초과 합니다.(최대 "+nMaxLength+"자)");
		 TXT_EM_MEMO.focus();
		 return false;		 
	 }
	 if (!DS_O_RESULT.IsUpdated) {
		 showMessage(INFORMATION, OK, "USER-1000","발송할 연락처가 존재하지 않습니다.");
		 return false;
	 }
	// 오류내용 검사 끝.
	
	//변경또는 신규 내용을 저장하시겠습니까?
	    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
	    	return false;
	
	if ( strRtnNo.length == 0 )  // 공란일시 대표번호로
		strRtnNo = "1800-5550"; 
	
	
	var goTo        = "seqSlpNo";    
    var action      = "O";     
    var parameters  = "";
                 
    TR_MAIN.Action  = "/dcs/dctm505.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_SEQ=DS_O_SEQ)"; //조회는 O
    TR_MAIN.Post();  
	
    if (DS_O_SEQ.CountRow != 0) {
    	strSeqNo	= DS_O_SEQ.NameValue(1, "SEQ_NO");
    }
    else{
    	showMessage(INFORMATION, OK, "USER-1000","[오류] 문자 발송 채번에 실패하였습니다.");
    	return;
    }
	
    
 	// 데이터셋에 문자 내용 입력.
	searchSetWait("B");
 	
	nRowCnt	= DS_O_RESULT.CountRow;
	
	for(nRow = 1; nRow <= DS_O_RESULT.CountRow; nRow++){
		
		strHpNo   = DS_O_RESULT.NameValue(nRow,"HP_NO");
		strHpNo	= strHpNo.replace(/-/gi, "");
		DS_O_RESULT.NameValue(nRow,"SUBJ")	= strSubj;
		DS_O_RESULT.NameValue(nRow,"HP_NO")	= strHpNo.trim();
		DS_O_RESULT.NameValue(nRow,"RTN_NO")= strRtnNo.trim();
	}
	//alert(strSeqNo);
	DS_O_CONTENT.NameValue(1,"MSG") = strMsg;
	DS_O_CONTENT.UserStatus(1)="1";
	
	//alert(strOpGubun);
	
	var strSendDate = EM_FROM_DT.text; 
	var strSendGb	= RD_GROUP.CodeValue;
	if  (strSendGb==1) strSendGb = "SMS";	// 1: 단문(sms) 2: 장문(lms)
	else strSendGb = "LMS";
	
	

	nForNum = Math.ceil(nRowCnt/nRegCnt);
	
	for(var i = 1; i <= nForNum; i++) {
		
		DS_O_TEMP.ClearData();		
		
		nTemp = nTemp + nRegCnt;
		
		if (nTemp > nRowCnt ) {
			nRegCnt = nRegCnt - (nTemp - nRowCnt);
		}
		
		strData = DS_O_RESULT.ExportData(nStartIdx,nRegCnt, true );
		DS_O_TEMP.ImportData(strData);
		
	    for (nRow=1; nRow <= DS_O_TEMP.CountRow; nRow++)
    	{
	    	DS_O_TEMP.UserStatus(nRow) = 1; // 상태값을 변경하여 저장하도록 한다.
    	}
		
		parameters =  "&strSendDate="      	+encodeURIComponent(strSendDate)
        			+ "&strSendGb="      	+encodeURIComponent(strSendGb)
        			+ "&strContent="		+encodeURIComponent("")
        			+ "&strOpGubun="		+encodeURIComponent(strOpGubun)
        			+ "&strSeqNo="         + encodeURIComponent(strSeqNo)
	    			;
		
		if (i == nForNum) {
			
			TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=save"+parameters;
			TR_MAIN2.KeyValue = "SERVLET(I:DS_O_TEMP=DS_O_TEMP,I:DS_O_CONTENT=DS_O_CONTENT)"; 
			TR_MAIN2.Post();
			
		} else {

			TR_MAIN3.Action = "/dcs/dctm505.dm?goTo=save"+parameters;
			TR_MAIN3.KeyValue = "SERVLET(I:DS_O_TEMP=DS_O_TEMP,I:DS_O_CONTENT=DS_O_CONTENT)"; 
			TR_MAIN3.Post();
			
		}

		nStartIdx = nStartIdx + nRegCnt; 
		
	}
	
	/*	
	var parameters =  "&strSendDate="      	+encodeURIComponent(strSendDate)
					+ "&strSendGb="      	+encodeURIComponent(strSendGb)
					+ "&strContent="		+encodeURIComponent("")
					+ "&strOpGubun="		+encodeURIComponent(strOpGubun)
					+ "&strSeqNo="			+encodeURIComponent("0")
					;

	TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=save"+parameters;
	TR_MAIN2.KeyValue = "SERVLET(I:DS_O_RESULT=DS_O_RESULT,I:DS_O_CONTENT=DS_O_CONTENT)"; 
	TR_MAIN2.Post();
	
	*/
	countPage(0,0);
}



function searchList() {
	
	searchSetWait("B");
	var strSendDate = EM_REG_DT.text;
	var parameters =  "&strSendDate="      	+encodeURIComponent(strSendDate)
						;

	TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=searchMaster"+parameters;
	TR_MAIN2.KeyValue = "SERVLET(O:DS_O_MASTER2=DS_O_MASTER2)"; 
	TR_MAIN2.Post();
}



function searchCust() {

	DS_O_MASTER.ClearData();
	DS_O_RESULT.ClearData();
	var strStrCd  = LC_STR_CD.BindColVal;				//점
    var strFromDt = EM_ENTR_FR.text;      				//시작일자
    var strToDt   = EM_ENTR_TO.text;       				//종료일자
	 
    //var strCUST_GRADE = LC_CUST_GRADE.BindColVal;  		//회원등급
    var strSEX_CD     = LC_SEX_CD.BindColVal;			//성별
    var strPoint_from = EM_FROM_POINT.text;        		//포인트
    var strPoint_to   = EM_TO_POINT.text;       		//포인트
    
    var strSendCnt   = EM_SEND_CNT.text;       		//발송건수
    
    var strAge_from = EM_AGE_FR.text;        		//나이
    var strAge_to   = EM_AGE_TO.text;       		//나이
    
    var strSMs        = "";								//SMS수신거부제외
    
    if (CHK_SMS.checked == true) {
    	strSMs        = "Y";	
    }
    
    var strSchCond	  = "";
    
    if (COND_ONOFF.checked) {
    	strSchCond = "Y";
    }
    
    var strOrgCd = LC_STR_CD.BindColVal + LC_DEPT_CD.BindColVal + LC_TEAM_CD.BindColVal + LC_PC_CD.BindColVal;	// 조직
    var strFloor		= LC_FLOOR_CD.BindColVal;
    var strPumbunCd 	= EM_PUMBUN_CD.Text;
    var strSaleFr 		= EM_SALE_FR.text;      				//매출시작
    var strSaleTo  		= EM_SALE_TO.text;       				//매출종료
    var strCndtnGbn 	= RD_CONDITION.CodeValue; 				// 조회조건
    
    //var strContent 	= TXT_EM_MEMO.TEXT;
    var strSubj		= EM_SUBJ.TEXT;
    var strRtnNo	= EM_RTN_NO.TEXT;
    strRtnNo		= strRtnNo.trim();
    
    if (strRtnNo=="")
    	strRtnNo = "1800-5550";
        
    /*
    var strDM         = "";								//우편수신거부제외 
    if (CHK_DM.checked == true) {
    	strDM        = "H";	
    }
    */
    
    //strMOBILE_COMP = LC_MOBILE_COMP.BindColVal;
    
    //var strBIR_MONTH_S = LC_BIR_MONTH_S.BindColVal;     //생일월
    
    //var strRtn		= "";
    var nRow    	= 1;
    var nRow2    	= 1;
    var nFailCnt	= 0;
    //var varSendCnt 	= 0;
    searchSetWait("B");
    var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    var goTo        = "searchCust";    
    var action      = "O";     
    var parameters  = "&strStrCd="     	   + encodeURIComponent(strStrCd)
			        + "&strFromDt="        + encodeURIComponent(strFromDt)
			        + "&strToDt="     	   + encodeURIComponent(strToDt) 
			        + "&strSubj="    	   + encodeURIComponent(strSubj)
                    + "&strSEX_CD="        + encodeURIComponent(strSEX_CD)
                    + "&strPoint_from="    + encodeURIComponent(strPoint_from)
                    + "&strPoint_to="      + encodeURIComponent(strPoint_to)
                    + "&strSMs="           + encodeURIComponent(strSMs)
                    + "&strRtnNo="   	   + encodeURIComponent(strRtnNo)
                    + "&strHOME_ADDR="     + encodeURIComponent(strHOME_ADDR)
                    + "&strContent="       + encodeURIComponent("")
                    + "&strGb="       	   + encodeURIComponent("sch")
                    + "&strAge_from="     	+ encodeURIComponent(strAge_from)
                    + "&strAge_to="     	+ encodeURIComponent(strAge_to)
					// 조회조건                   
                    + "&strSchCond="       + encodeURIComponent(strSchCond)
                    + "&strCndtnGbn="       + encodeURIComponent(strCndtnGbn)
                    + "&strOrgCd="          + encodeURIComponent(strOrgCd)
                    + "&strFloor="         + encodeURIComponent(strFloor)
                    + "&strPumbunCd="      + encodeURIComponent(strPumbunCd)
                    + "&strSaleFr="        + encodeURIComponent(strSaleFr)
			        + "&strSaleTo="        + encodeURIComponent(strSaleTo)
			        + "&strSendCnt="        + encodeURIComponent(strSendCnt)
                    ;
                  
    TR_MAIN.Action  = "/dcs/dctm505.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_MAIN.Post();    
    
    /*
	for(nRow = DS_O_MASTER.CountRow; nRow >= 1; nRow--){
		for(nRow2 = 1; nRow2 <= nRow-1; nRow2++){
			if (DS_O_MASTER.NameValue(nRow,"HP_NO") == DS_O_MASTER.NameValue(nRow2,"HP_NO") ) {
				//alert(DS_O_MASTER.NameValue(nRow,"HP_NO"));
				//alert(DS_O_MASTER.NameValue(nRow2,"HP_NO"));
					DS_O_MASTER.DeleteRow(nRow);
					nFailCnt = nFailCnt+1;
					break;
			}
		}
		DS_O_MASTER.NameValue(nRow,"CHK") = "T";
	}	
	*/
    
    if (DS_O_RESULT.CountRow>0){
	    nPageNum = 1;
	    var nLstPage = Math.floor(DS_O_RESULT.CountRow / 100) ; // 마지막 페이지 번호
	    if (nLstPage != (DS_O_RESULT.CountRow / 100))
	    	nLstPage++;
	    countPage(nPageNum,nLstPage);
	    var strData = DS_O_RESULT.ExportData(1, 100, true);
	    DS_O_MASTER.ImportData(strData);
	    DS_O_MASTER.ResetStatus();
    } else {
    	nPageNum = 0;
    	countPage(nPageNum,nPageNum);
    }
	
    searchDoneWait();
	
    
    /*
    if (DS_O_MASTER.CountRow > 0 ) {
    	var strMaxCnt = DS_O_MASTER.NameValue(1,"TOT_ROW");
    	showMessage(INFORMATION, OK, "USER-1000","총 <b>"+strMaxCnt+ "건</b>의 자료가 조회 되었습니다. <br>"
    											+ "(이 중 "+(DS_O_MASTER.CountRow)+ " 건의 자료만 표시합니다.)"		
    	);
    	setPorcCount("SELECT", strMaxCnt);
        GD_MASTER.Focus();
        
    }
    else  {
    	showMessage(INFORMATION, OK, "USER-1000","조회 내용이 없습니다." );
    	setPorcCount("SELECT", DS_O_MASTER.CountRow);
    	EM_ADDR.Focus();
    }
    */
    
    if (DS_O_RESULT.CountRow > 0 ) {
    	//var strMaxCnt = DS_O_RESULT.NameValue(1,"TOT_ROW");
    	var strMaxCnt = DS_O_RESULT.CountRow;
    	showMessage(INFORMATION, OK, "USER-1000","총 <b>"+strMaxCnt+ "건</b>의 자료가 조회 되었습니다. <br>"
    											//+ "(이 중 "+(DS_O_MASTER.CountRow)+ " 건의 자료만 표시합니다.)"		
    	);
    	setPorcCount("SELECT", DS_O_RESULT.CountRow);
        GD_MASTER.Focus();
        
    }
    else  {
    	showMessage(INFORMATION, OK, "USER-1000","조회 내용이 없습니다." );
    	setPorcCount("SELECT", DS_O_RESULT.CountRow);
    	EM_ADDR.Focus();
    }
    strRegFlag = "0"; // 조회했기때문에 플레그 변경
    
    
}


function sendProcess() {
	// 기발송 문자는 전송처리X
	var strSendFlag = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"SEND_FLAG");
	if (strSendFlag!=0) return;
	
	// 전송 질의
	var strSubj	= DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"SUBJ")
	var strTemp = showMessage(QUESTION, YESNO, "USER-1000","'"+strSubj+"' 을(를) 전송하시겠습니까?");
	if (strTemp!=1)	return;
	
	// 프로세스 진행
	searchSetWait("B");
	var strTranGrp = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"TRAN_GRP");
	var strRegDate = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"REG_DATE");
		
	var parameters =  "&strTranGrp="      	+encodeURIComponent(strTranGrp)
					+ "&strRegDate="      	+encodeURIComponent(strRegDate)
					;

	TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=sendProcess"+parameters;
	TR_MAIN2.KeyValue = "SERVLET(O:DS_O_MASTER2=DS_O_MASTER2)"; 
	TR_MAIN2.Post();	
	
	btn_Search();
}

function setInit() {
	DS_O_MASTER.ClearData();
	DS_O_RESULT.ClearData();
	DS_O_TEMP.ClearData();
	EM_FROM_DT.Text 	= varToday;
    TXT_EM_MEMO.TEXT 	= "";
    EM_SUBJ.TEXT		= "";
    EM_RTN_NO.TEXT		= "";
    EM_FILS_LOC.text	= "";
    document.getElementById("memo_length").value = 0;
}




function delProcess() {
	
	// 기발송 문자는 삭제처리X
	var strSendFlag = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"SEND_FLAG");
	if (strSendFlag!=0) return;
	
	// 삭제 질의
	var strSubj	= DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"SUBJ")
	var strTemp = showMessage(QUESTION, YESNO, "USER-1000","'"+strSubj+"' 을(를) 삭제하시겠습니까?");
	if (strTemp!=1)	return;
	
	// 프로세스 진행
	searchSetWait("B");
	var strTranGrp = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"TRAN_GRP");
	var strRegDate = DS_O_MASTER2.NameValue(DS_O_MASTER2.RowPosition,"REG_DATE");
		
	var parameters =  "&strTranGrp="      	+encodeURIComponent(strTranGrp)
					+ "&strRegDate="      	+encodeURIComponent(strRegDate)
					;

	TR_MAIN2.Action = "/dcs/dctm505.dm?goTo=delProcess"+parameters;
	TR_MAIN2.KeyValue = "SERVLET(O:DS_O_MASTER2=DS_O_MASTER2)"; 
	TR_MAIN2.Post();	
	
	btn_Search();
	
}

function setComponents(tf) {  // 업무 구분 변경시 컴퍼넌트 셋팅
	
	DS_O_MASTER.ClearData();
	DS_O_RESULT.ClearData();
	
	LC_STR_CD.enable 		= tf;
	EM_ENTR_FR.enabled 		= tf;
	EM_ENTR_TO.enabled 		= tf;
	EM_SALE_FR.enabled 		= tf;
	EM_SALE_TO.enabled 		= tf;
	IMG_ENTR_FR.enabled 	= tf;
	IMG_ENTR_TO.enabled 	= tf;
	LC_SEX_CD.enable 		= tf;
	EM_FROM_POINT.enabled 	= tf;
	EM_TO_POINT.enabled 	= tf;
	EM_ADDR.enabled 		= tf;
	
	RD_CONDITION.enable 	= tf;
	LC_DEPT_CD.enable 		= tf;
	LC_TEAM_CD.enable 		= tf;
	LC_PC_CD.enable 		= tf;
	EM_PUMBUN_CD.enabled 	= tf;
	EM_PUMBUN_NAME.enabled	= tf;
	LC_FLOOR_CD.enable		= tf;
	document.getElementById("COND_ONOFF").disabled = !tf;
	if (tf) {
		RD_CONDITION.CodeValue	= 2;
		EM_PUMBUN_CD.enabled 	= !tf;
		EM_PUMBUN_NAME.enabled 	= !tf;
		LC_FLOOR_CD.enable 		= !tf;
		LC_DEPT_CD.index 		= 0;
		LC_FLOOR_CD.index 		= 0;
		EM_PUMBUN_CD.text 		= "";
		EM_PUMBUN_NAME.text 	= "";
		document.getElementById("COND_ONOFF").checked = tf;
	}
	
	document.getElementById("CHK_SMS").disabled 				= !tf;
	document.getElementById("IMG_ENTR_FR").disabled 			= !tf;
	document.getElementById("IMG_ENTR_TO").disabled 			= !tf;
	document.getElementById("IMG_SALE_FR").disabled 			= !tf;
	document.getElementById("IMG_SALE_TO").disabled 			= !tf;
	
	if (tf) {
		document.getElementById("A_EXCEL_DOWN").href	= "/dcs/samplefiles/SMS_CUST_INS_SAMPLE.xls";
		DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
		DS_O_RESULT.setDataHeader('<gauce:dataset name="H_MASTER"/>');
		DS_O_TEMP.setDataHeader('<gauce:dataset name="H_MASTER"/>');
		DS_O_EXCELTEMP.setDataHeader('<gauce:dataset name="H_EXCELTEMP"/>');
		gridCreate1();
		
	} else {
		document.getElementById("A_EXCEL_DOWN").href	= "/dcs/samplefiles/SMS_ONLINE_SALE_SAMPLE.xls";
		DS_O_MASTER.setDataHeader('<gauce:dataset name="H_ONLINE"/>');
		DS_O_RESULT.setDataHeader('<gauce:dataset name="H_ONLINE"/>');
		DS_O_TEMP.setDataHeader('<gauce:dataset name="H_ONLINE"/>');
		DS_O_EXCELTEMP.setDataHeader('<gauce:dataset name="H_ONLINE"/>');
		gridCreate3();
	}
		
	
}

function condOnOff(tf) {

	if (DS_O_MASTER.CountRow > 0) {
		
		if(showMessage(QUESTION, YESNO, "USER-1000","조회조건이 변경될 경우 조회된 내용이<br> 초기화 됩니다.<br> 진행하시겠습니까?") != 1) 
			COND_ONOFF.checked = !tf;
		else
			setComponents(true);
	} else {
		RD_CONDITION.enable 	= tf;
		LC_DEPT_CD.enable 		= tf;
		LC_TEAM_CD.enable 		= tf;
		LC_PC_CD.enable 		= tf;
		EM_PUMBUN_CD.enabled 	= tf;
		EM_PUMBUN_NAME.enabled	= tf;
		LC_FLOOR_CD.enable		= tf;
		EM_SALE_FR.enabled 		= tf;
		EM_SALE_TO.enabled 		= tf;
		document.getElementById("IMG_SALE_FR").disabled 			= !tf;
		document.getElementById("IMG_SALE_TO").disabled 			= !tf;
		
		if (tf) {
			RD_CONDITION.CodeValue	= 2;
			EM_PUMBUN_CD.enabled 	= !tf;
			EM_PUMBUN_NAME.enabled 	= !tf;
			LC_FLOOR_CD.enable 		= !tf;
			LC_DEPT_CD.index 		= 0;
			LC_FLOOR_CD.index 		= 0;
			EM_PUMBUN_CD.text 		= "";
			EM_PUMBUN_NAME.text 	= "";
		}
	}
	
}


/**
 * countPage(pagenum,lstpagenum)
 * 작 성 자     : jyk
 * 작 성 일     : 2018-01-09
 * 개      요      : 페이지 카운트 출력
 * return값 : void
 */ 
function countPage(pagenum,lstpagenum) {
	 obj 			= document.getElementById("pageCnt");
	 obj.innerText  = "　　"+ pagenum +" / "+ lstpagenum ;
}


/**
 * changePage(strAction)
 * 작 성 자     : jyk
 * 작 성 일     : 2018-01-09
 * 개      요      : 그리드 페이지 변경
 * return값 : void
 */
function changePage(strAction) {
	if (DS_O_RESULT.CountRow > 0 ) { 
		var nPage = 0;						// 페이지 리스트 시작번호
		//var nLstPage = Math.floor(DS_O_RESULT.CountRow/100)+1; // 마지막 페이지 번호
		var nLstPage = Math.floor(DS_O_RESULT.CountRow/100); // 마지막 페이지 번호
		if (nLstPage != (DS_O_RESULT.CountRow/100))
			nLstPage ++;
		if (strAction == "N") {				// next
			nPage = DS_O_MASTER.NameValue(DS_O_MASTER.CountRow,"ROW_NUM") + 1;		// 그리드 데이터셋 마지막 행 번호 + 1
			
			if (DS_O_RESULT.CountRow > nPage) {
				var strData = DS_O_RESULT.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_MASTER.ClearData();											
				DS_O_MASTER.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
				DS_O_MASTER.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = nPageNum + 1;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "마지막 페이지 입니다.");
				return;
			}
		} else if (strAction == "P") {		// previous
			nPage = DS_O_MASTER.NameValue(1,"ROW_NUM") - nDisplayRow;				// 그리드 데이터셋 첫 행 번호 - nDisplayRow
			if (nPage >= 1) {
				var strData = DS_O_RESULT.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_MASTER.ClearData();
				DS_O_MASTER.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
				DS_O_MASTER.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = nPageNum - 1;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "첫 페이지 입니다.");
				return;
			}
		} else if (strAction == "F") {		// first
			nPage = 1;																// 가장 첫페이지.
			if (nPage >= 1) {
				var strData = DS_O_RESULT.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_MASTER.ClearData();
				DS_O_MASTER.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
				DS_O_MASTER.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = 1;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "첫 페이지 입니다.");
				return;
			}
		} else if (strAction == "L") {		// last
			nPage = Math.floor(DS_O_RESULT.CountRow / nDisplayRow) * nDisplayRow + 1; // (데이터셋 총행수 / nDisplayRow) 소수점 버림 * nDisplayRow 
			//nPage = nLstPage * nDisplayRow + 1; // (데이터셋 총행수 / nDisplayRow) 소수점 버림 * nDisplayRow
			//alert(nPage);
			if (DS_O_RESULT.CountRow > nPage) {
				var strData = DS_O_RESULT.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_MASTER.ClearData();
				DS_O_MASTER.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
				DS_O_MASTER.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = nLstPage;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "마지막 페이지 입니다.");
				return;
			}
		}
	}
}


/**
 * setZero(obj)
 * 작 성 자     : jyk
 * 작 성 일     : 2018-01-09
 * 개      요      : 입력값 없을 경우 값 셋팅 
 * return값 : void
 */ 
function setZero(obj) {
	 var strTemp = obj.text;
	 if (strTemp.length == 0) {
		 var strObjId =  obj.id;
		 if (strObjId.indexOf("FR") > 0) {
		 	 obj.text = 0;
		 }
		 else if  (strObjId.indexOf("TO") > 0) {
			 if (strObjId.indexOf("AGE") > 0)
				obj.text = 999;
			 else
				obj.text = 999999999;
		 } else {
			obj.text = 999999999;
		 }
	 }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
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
    searchDoneWait();
</script>

<script language=JavaScript for=TR_MAIN2 event=onSuccess>
	searchDoneWait();
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
	if (getTabItemSelect("TAB_MAIN")=="1") {
		setInit();	// 내용 초기화
		EM_REG_DT.TEXT = EM_FROM_DT.text;
		setTabItemIndex("TAB_MAIN",2);	// 발송탭 DISPLAY
		searchList();	// 발송탭 조회
	}
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	searchDoneWait();
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN2.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN3 event=onFail>
    trFailed(TR_MAIN3.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 매출시작일 -->
<script	language=JavaScript	for=EM_FROM_DT event=onKillFocus()>

	//영업조회일
	if (isNull(EM_FROM_DT.text) ==true ) {
		showMessage(Information, OK, "USER-1003","발송일자"); 
		EM_FROM_DT.text =	varToday;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_FROM_DT.text.replace("	","").length !=	8 )	{
		showMessage(Information, OK, "USER-1027","발송일자","8");
		EM_FROM_DT.text =	varToday;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMMDD(EM_FROM_DT.text)	) {
		showMessage(Information, OK, "USER-1069","발송일자");
		EM_FROM_DT.text =	varToday;
		return ;
	}


</script>

<script	language=JavaScript	for=EM_REG_DT event=onKillFocus()>

	//영업조회일
	if (isNull(EM_REG_DT.text) ==true ) {
		showMessage(Information, OK, "USER-1003","등록일자"); 
		EM_REG_DT.text =	varToday;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_REG_DT.text.replace("	","").length !=	8 )	{
		showMessage(Information, OK, "USER-1027","등록일자","8");
		EM_REG_DT.text =	varToday;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMMDD(EM_REG_DT.text)	) {
		showMessage(Information, OK, "USER-1069","등록일자");
		EM_REG_DT.text =	varToday;
		return ;
	}


</script>

<script language=JavaScript for=DS_O_MASTER2 event=OnRowPosChanged(row)>
	if(row > 0 && old_Row > 0 ){
    	var strContent 	=  DS_O_MASTER2.NameValue(row,"MSG");
    	var strSendFlag =  DS_O_MASTER2.NameValue(row,"SEND_FLAG");
    
    	TXT_EM_MEMO2.text = strContent;
    	if (strSendFlag=="0") document.getElementById("IMG_SEND_PROC").src="/<%=dir%>/imgs/btn/send_pre_c.gif";
    	else document.getElementById("IMG_SEND_PROC").src="/<%=dir%>/imgs/btn/send_pre.gif";
	}
	old_Row = row; 
//old_Row = row;

</script>


<!-- Grid sorting 기능  -->


<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    if (colid != "CHK") {
    //sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    }
    //alert(eval(this.DataID)+" "+ row + " " + colid)
</script>

<!-- 그리드 헤더 체크박스 클릭시 -->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

	var objDs = eval(this.DataID);
	var strProcFlag = "";
	
	this.redraw = false;
    switch(Colid){
        case "CHK":
            for (var row = 1; row <= objDs.CountRow; row++) {
            	
            	strProcFlag = DS_O_MASTER.NameValue(row,"ERR");
            	
            	if(strProcFlag == "") {
	            
            		if(bCheck){
	                	objDs.NameValue(row, "CHK") = "T";
	                }else{
	                	objDs.NameValue(row, "CHK") = "F";
	                }
            	}
            }
            break;
            
        default:
            break;
    }
    this.redraw = true;
</script>

<script	language=JavaScript	for=TXT_EM_MEMO event=onChange()>
	
	var strTemp = TXT_EM_MEMO.text;
	//alert(escape(strTemp.charAt(0)));
	//return ;

	var rtnLength = GetStrLengthB(strTemp);
	var limLength = document.getElementById("memo_maxlength").value;	
	 //alert(rtnLength);
	
	//document.getElementById("memo_length").value = rtnLength;
	
	if (rtnLength > limLength) {
		strTemp = CutStrByte(strTemp, limLength);
		// alert(strTemp);
		rtnLength = GetStrLengthB(strTemp);
		
		showMessage(QUESTION, OK, "USER-1000",limLength+" byte 초과 작성할 수 없습니다."); 
		TXT_EM_MEMO.text = strTemp;
	}
	
	document.getElementById("memo_length").value = rtnLength;
	
</script>

<script	language=JavaScript	for=RD_GROUP event=onSelChange()>
	
	var strTemp = RD_GROUP.CodeValue;
	
	if (strTemp == 1) { // 단문
		if(showMessage(QUESTION, YESNO, "USER-1000","작성 내용이 80 byte 이상인 경우 내용이 변경될 수 있습니다. 진행하시겠습니까?") != 1) { 
			RD_GROUP.CodeValue = "2";
			RD_GROUP.Focus();
		}
		else {
			strTemp = CutStrByte(TXT_EM_MEMO.text, 80);
			TXT_EM_MEMO.text = strTemp;
			document.getElementById("memo_maxlength").value = 80;
		}
	}
	else // 장문
		document.getElementById("memo_maxlength").value = 2000;
	
</script>


<script	language=JavaScript	for=RD_GROUP2 event=onSelChange()>
	
	var strTemp = RD_GROUP2.CodeValue;
	var tfTemp = false;
	
	if (DS_O_MASTER.CountRow > 0) {
	
		if(showMessage(QUESTION, YESNO, "USER-1000","업무 구분이 변경될 경우 조회된 내용이<br> 초기화 됩니다.<br> 진행하시겠습니까?") != 1) {
			if (strTemp == 1) { // 일반
				 
				RD_GROUP2.CodeValue = 2;
				RD_GROUP2.Focus();
			}
			else {				// 온라인
				RD_GROUP2.CodeValue = 1;
				RD_GROUP2.Focus();
			}
			return false;
		}
		
	}
	
	if (strTemp == 1) // 일반
		tfTemp = true;
	else 			// 온라인
		tfTemp = false;
	
	//alert(tfTemp);
	setComponents(tfTemp);

</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	var strOrgFlag="1";	
	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
var strOrgFlag="1";
    if(LC_DEPT_CD.BindColVal != "%"){
    	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트   
    }else{
        DS_TEAM_CD.ClearData();
        insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
var strOrgFlag="1";
    if(LC_TEAM_CD.BindColVal != "%"){
    	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<script language=JavaScript for=RD_CONDITION event=OnSelChange()>
	
	if(RD_CONDITION.CodeValue =="1"){
		EM_PUMBUN_CD.Enabled 	= true;
		
		LC_DEPT_CD.index 	= 0;
		LC_DEPT_CD.enable	= false;
		LC_TEAM_CD.enable	= false;
		LC_PC_CD.enable		= false;
		LC_FLOOR_CD.index 	= 0;
		LC_FLOOR_CD.Enable	= false;
	}else if (RD_CONDITION.CodeValue =="2") {
		EM_PUMBUN_CD.text 		= "";
		EM_PUMBUN_NAME.text		= "";
		EM_PUMBUN_CD.Enabled 	= false;

		
		LC_DEPT_CD.Enable	= true;
		LC_TEAM_CD.Enable	= true;
		LC_PC_CD.Enable		= true;
		
		LC_FLOOR_CD.index 	= 0;
		LC_FLOOR_CD.Enable	= false;
	}else if (RD_CONDITION.CodeValue =="3") {
		
		EM_PUMBUN_CD.text 		= "";
		EM_PUMBUN_NAME.text		= "";
		EM_PUMBUN_CD.Enabled 	= false;
		
		LC_DEPT_CD.index 	= 0;
		LC_DEPT_CD.Enable	= false;
		LC_TEAM_CD.Enable	= false;
		LC_PC_CD.Enable		= false;
		
		LC_FLOOR_CD.Enable	= true;
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
<comment id="_NSID_">
<object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
 
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_EXCELTEMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_SEX_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CONTENT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_SEQ" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PC_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_FLOOR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+180) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
	<param name="TimeOut"    value=2400000>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN3" classid=<%=Util.CLSID_TRANSACTION%>>
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
<div id=TAB_MAIN  width="100%" height=870 TitleWidth=90  TitleAlign="center" >
	<menu TitleName="등록"       DivId="tab_page1" Enable='true' />
	<menu TitleName="발송"       DivId="tab_page2" Enable='true' />
</div>
<div id=tab_page1 width="100%" >
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
						
						<th width="80" class="point">발송일자</th>
						<td width="150" > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_FROM_DT)" align="absmiddle" />
			            </td>
			            <th width="80" class="point">발송구분</th> 
						<td td width="300">
							<comment id="_NSID_"> 
								<object id="RD_GROUP" classid="<%=Util.CLSID_RADIO%>" width=180 height=18 align="absmiddle">
									<param name="Cols"   value="2">
									<param name="Format" value="1^단문(SMS),2^장문(LMS)">
								</object> 
							</comment><script>_ws_(_NSID_);</script>  
						</td>
						<th width="80" class="point">업무구분</th> 
						<td colspan="5" >
							<comment id="_NSID_"> 
								<object id="RD_GROUP2" classid="<%=Util.CLSID_RADIO%>" width=180 height=18 align="absmiddle">
									<param name="Cols"   value="2">
									<param name="Format" value="1^일반,2^온라인매출">
									<param name="enable" value="false">
								</object> 
							</comment><script>_ws_(_NSID_);</script>  
						</td>
					</tr>
				</table>
				</td>
					</tr>
					<tr>
						<td class="PT01 PB03">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="o_table">
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="78" class="point">가입점</th>
										<td width="150">  
											<comment id="_NSID_">
						                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 tabindex=1 align="absmiddle">
						                        </object>
						                    </comment><script>_ws_(_NSID_);</script> 
				                  		</td> 
										<th width="80" class="point">가입기간</th>
										<td width="300" > 
										 <comment id="_NSID_">
						                      <object id=EM_ENTR_FR classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
						                      </object>
						                  </comment><script> _ws_(_NSID_);</script>
						                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_ENTR_FR" onclick="javascript:openCal('G',EM_ENTR_FR)" align="absmiddle" />
						                  ~
						                  <comment id="_NSID_">
						                      <object id=EM_ENTR_TO classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
						                      </object>
						                  </comment><script> _ws_(_NSID_);</script>
						                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_ENTR_TO" onclick="javascript:openCal('G',EM_ENTR_TO)" align="absmiddle" />
							            </td> 
										<th width="80" class="point">성별</th>
										<td width="150"><comment id="_NSID_"> <object
											id=LC_SEX_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130
											tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="80" > 포인트구간</th>
										<td width="200"> 
										 <comment id="_NSID_">
						                      <object id=EM_FROM_POINT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle" onblur="javascript:setZero(EM_FROM_POINT)">
						                      </object>
						                  </comment><script> _ws_(_NSID_);</script>
						                 ~
						                  <comment id="_NSID_">
						                      <object id=EM_TO_POINT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle" onblur="javascript:setZero(EM_TO_POINT)">
						                      </object>
						                  </comment><script> _ws_(_NSID_);</script>
							            </td> 
										<th width="70">주소</th>
										<td ><comment id="_NSID_"> <object id=EM_ADDR
											width=180 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
											align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
											<input type="checkbox" id=CHK_SMS value="T"   align="absmiddle"  tabindex=1 checked>SMS수신거부제외 
										</td>
									</tr>
									<tr>
										<th width="78" >연령 범위</th>
										<td colspan="3">  
											 <comment id="_NSID_"> <object id=EM_AGE_FR
											width=110 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
											align="absmiddle" onblur="javascript:setZero(EM_AGE_FR)"></object> </comment> <script> _ws_(_NSID_);</script> 
											~
											<comment id="_NSID_"> <object id=EM_AGE_TO
											width=110 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
											align="absmiddle" onblur="javascript:setZero(EM_AGE_TO)"></object> </comment> <script> _ws_(_NSID_);</script>
				                  		</td>
				                  		<th width="80" >발송건수</th>
										<td colspan="5"> 
											<comment id="_NSID_">
							                      <object id=EM_SEND_CNT classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle" onblur="javascript:setZero(EM_SEND_CNT)">
							                      </object>
							                  </comment><script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="78" rowspan="2">조회조건 <input type="checkbox" id=COND_ONOFF onclick="condOnOff(this.checked);")></th>
										<td width="150" rowspan="2" >  
											<comment id="_NSID_">
						                    <object id="RD_CONDITION" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:50; width:150">
						                    <param name=Cols    value="2">
						                    <param name=Format  value="2^조직,1^브랜드,3^층">                   
						                    <param name=CodeValue  value="2">
						                    </object>  
						                    </comment><script> _ws_(_NSID_);</script> 
				                  		</td> 
				                  		<th width="80" >팀</th>
										<td width="300" > 
											<comment id="_NSID_">
											<object id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
							                   align="absmiddle"> </object>
							                </comment><script>_ws_(_NSID_);</script>
							            </td> 
										<th width="80" >파트</th>
										<td width="150">
											<comment id="_NSID_"> 
											<object id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   						align="absmiddle"> </object> </comment>
		                   						<script>_ws_(_NSID_);</script>
										</td>
										<th width="80" > PC</th>
										<td colspan="3"> 
											<comment id="_NSID_"> <object id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
						                   align="absmiddle"> </object> </comment>
						                   <script>_ws_(_NSID_);</script>
							            </td> 
									</tr>
									<tr>							
				                  		<th width="80" >브랜드</th>
										<td width="300" > 
											<comment id="_NSID_"> 
										 	 <object id=EM_PUMBUN_CD
							                   	classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							                   	align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							                   	src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							                   	onclick="if(RD_CONDITION.CodeValue =='1'){javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();}"
							                   	align="absmiddle" /> <comment id="_NSID_"> <object
							                   	id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
							                   	align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							            </td> 
										<th width="80" >층</th>
										<td width="150">
											<comment id="_NSID_"> <object
											id=LC_FLOOR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130
											tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="80" >매출기간</th>
										<td colspan="3">
											<comment id="_NSID_">
							                      <object id=EM_SALE_FR classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
							                      </object>
							                  </comment><script> _ws_(_NSID_);</script>
							                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_SALE_FR" onclick="javascript:openCal('G',EM_SALE_FR)" align="absmiddle" />
							                  ~
							                  <comment id="_NSID_">
							                      <object id=EM_SALE_TO classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
							                      </object>
							                  </comment><script> _ws_(_NSID_);</script>
							                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_SALE_TO" onclick="javascript:openCal('G',EM_SALE_TO)" align="absmiddle" />
						                  </td>
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
	<tr>
		<td class="dot"></td>
	</tr>

	<tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr>
        <td class="PT03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" >파일명</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width=500 tabindex=1 align="absmiddle" ></object>
              </comment><script>_ws_(_NSID_);</script>
              <a href="/dcs/samplefiles/SMS_CUST_INS_SAMPLE.xls" align="absmiddle" id=A_EXCEL_DOWN>
                <img src="/<%=dir%>/imgs/btn/excel_down.gif" border="0" align="absmiddle" >
              </a>
            </td >
          </tr>
        </table></td>
      </tr>
    </table></td>
  	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<div>☞ 페이지 이동 :
				<img src="/<%=dir%>/imgs/btn/first.gif" onclick="changePage('F')" align="absmiddle" />
				<img src="/<%=dir%>/imgs/btn/before2.gif" onclick="changePage('P')" align="absmiddle" />
				<img src="/<%=dir%>/imgs/btn/next2.gif"   onclick="changePage('N')" align="absmiddle" />
				<img src="/<%=dir%>/imgs/btn/last.gif"   onclick="changePage('L')" align="absmiddle" /></div>
				<div id="pageCnt"></div>
			</tr>
			<tr>
			<td width="70%"  >
				<object id=GD_MASTER width="100%" height="100%"
						classid=<%=Util.CLSID_GRID%> tabindex=1>
						<param name="DataID" value="DS_O_MASTER" tabindex=1>
				</object>
			</td>
			
				<td width="30%" height="100%">
				<br><b>▶ 제목 </b> - <comment id="_NSID_"> <object id=EM_SUBJ classid=<%=Util.CLSID_EMEDIT%>  width=400 tabindex=2 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
				<br><b>▶ 내용 </b> - 글자 Byte : <input type="text" id="memo_length" size=8 value=0 readonly style="text-align:center;"/>
				 <input type="hidden" id="memo_maxlength"  value=80 >
				<br><font color="red"> *영문, 띄어쓰기:1 Byte *한글, 줄바꿈:2 Byte *특수기호:기호에따라 Byte 수가 다름</font>
				<br>
				<comment id="_NSID_"> <object
						id=TXT_EM_MEMO classid=<%=Util.CLSID_TEXTAREA%> 
						style="
							width: 100%;
							height: 83%;
						"
						align="absmiddle"
						 ></object> </comment> <script> _ws_(_NSID_);</script>
				<br><br><b>▶ 회신번호 </b> - <comment id="_NSID_"> <object id=EM_RTN_NO classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=2 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
				※ 공란일 경우 대표번호 (1800-5550) 으로 발송.
				</td>
			</tr>
		</table>
		</td>
	</tr>
	
	
</table>
</div>
<div id=tab_page2 width="100%" >
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
						
						<th width="80" class="point">등록일자</th>
						<td width="1000" colspan="10" > 
						 <comment id="_NSID_">
		                      <object id=EM_REG_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_REG_DT)" align="absmiddle" />
		                  
		                  <img src="" id="IMG_SEND_PROC" onclick="javascript:sendProcess();" align="absmiddle" />
		                   
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
<!--  -->
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
			<td width="70%"  >
				<object id=GD_MASTER2 width="100%" height="100%"
						classid=<%=Util.CLSID_GRID%> tabindex=1>
						<param name="DataID" value="DS_O_MASTER2" tabindex=1>
				</object>
			</td>
			<td width="30%" height="100%">
				<br><b>▶ 내용 </b> 
				<br>
				<br>
				<comment id="_NSID_"> <object
						id=TXT_EM_MEMO2 classid=<%=Util.CLSID_TEXTAREA%> 
						style="
							width: 100%;
							height: 85%;
						"
						align="absmiddle"
						 ></object> </comment> <script> _ws_(_NSID_);</script>
				</td>
				
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
