<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 실행계획
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 영업일정보등록
 * 이    력 : 2010.03.23
 * 
 ******************************************************************************/-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
   String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/ds.css" rel="stylesheet" type="text/css">
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">




/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 80;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    // Input Data Set Header 초기화
	
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    GD_MASTER.TitleHeight =30;
    // EMedit에 초기화
    initEmEdit(EM_SALE_S_MON, "YYYYMM",   PK);          //영업조회월
    EM_SALE_S_MON.text = varToMon;
    initEmEdit(EM_SALE_S_DT, "YYYYMMDD", NORMAL);      //영업시작일자
    //EM_SALE_S_DT.text  = varToday;
    initEmEdit(EM_SALE_E_DT, "YYYYMMDD", NORMAL);      //대비시작일자
    //EM_SALE_E_DT.text  = varToday;
    EM_SALE_S_DT.text = EM_SALE_S_MON.text + "01";
    EM_SALE_E_DT.text = addDate('Y',-1, EM_SALE_S_DT.text);
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    //initComboStyle(EM_WEATHER,DS_WEATHER, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    getStore("DS_STR_CD", "Y", "", "N");                                // 점       
    LC_STR_CD.Index = 0;
    LC_STR_CD.focus();


    getEtcCode("DS_DAY_WEEK", "C", "C004", "N");                        //영업일자 요일
    getEtcCode("DS_HOLIDAY_GB", "D", "P600", "N");                      //영업일자 휴일구분
    getEtcCode("DS_CMPR_DAY", "C", "C004", "N");                        //대비일자 요일
    getEtcCode("DS_CMPR_HOLIDAY_GB", "D", "P600", "N");                 //대비일자 휴일구분
    getEtcCode("DS_WEATHER", "D", "P615", "N");    
    
    /* insComboFirstNullId(EM_WEATHER,"");
    setComboData(EM_WEATHER,"");  */
    
    GD_MASTER.ColumnProp('LOW_TEMP','Mask')="XX.XX";
    GD_MASTER.ColumnProp('HIGH_TEMP','Mask')="XX.XX";
    GD_MASTER.ColumnProp('AVRG_TEMP','Mask')="XX.XX";
    
    registerUsingDataset("psal201","DS_IO_MASTER" );
}

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}                name="NO"               width=30    align=center    Edit=none</FC>'
                      + '<FC>id=STR_CD                  name="점"                width=40    align=center    Edit=none    suppress=1</FC>'
                      + '<FC>id=STR_NAME                name="점명"              width=60    align=left      Edit=none    suppress=1   sumtext="합계"</FC>'
                      + '<FC>id=SALE_DT                 name="영업일자"           width=80    align=center    Edit=none    mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=DAY_WEEK                name="요일"              width=70    align=center    Edit=none    EditStyle=Lookup   Data="DS_DAY_WEEK:CODE:NAME"</FC>'
                      + '<FC>id=STD_WEIGHT              name="매출;표준가중치"      width=80    align=right    Edit=""      sumtext={subsum(STD_WEIGHT)}    Dec=2</FC>'
                      + '<FC>id=HOLIDAY_GB              name="휴일구분"           width=70    align=center    Edit=""      EditStyle=Lookup   Data="DS_HOLIDAY_GB:CODE:NAME"</FC>'
                      + '<FC>id=SALE_REMARK             name="특이사항"           width=140    align=left     Edit=""</FC>'
                      + '<FC>id=WEATHER                 name="날씨"              width=70    align=center    Edit=""      EditStyle=Lookup   Data="DS_WEATHER:CODE:NAME"            </FC>'//  
                      + '<FC>id=LOW_TEMP                name="최저기온"           width=70    align=right     Edit=""      Dec=2  </FC>'
                      + '<FC>id=HIGH_TEMP               name="최고기온"           width=70    align=right     Edit=""      Dec=2  </FC>'
                      + '<FC>id=AVRG_TEMP               name="평균기온"           width=70    align=right     Edit=""      Dec=2  </FC>'
/* 
                      + '<FC>id=CMPR_DT                 name="대비일자"           width=80    align=center    Edit=none    mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=CMPR_DAY                name="대비요일"           width=70    align=center    Edit=none    EditStyle=Lookup   Data="DS_CMPR_DAY:CODE:NAME"</FC>'
                      + '<FC>id=CMPR_HOLIDAY_GB         name="휴일구분"           width=70    align=center    Edit=none    EditStyle=Lookup   Data="DS_CMPR_HOLIDAY_GB:CODE:NAME"</FC>'
                      + '<FC>id=CMPR_STD_WEIGHT         name="대비일자;표준가중치"   width=80    align=right    Edit=none    sumtext={subsum(CMPR_STD_WEIGHT)}    Dec=2</FC>'
                      + '<FC>id=CMPR_SALE_REMARK        name="특이사항"           width=140    align=left     Edit=none</FC>';
 */                      
					  + '<FC>id=CMPR_DT                 name="대비일자"           width=80    align=center    Edit=""      EditStyle=Popup Edit=Numeric mask="XXXX/XX/XX"</FC>'
					  + '<FC>id=CMPR_DAY                name="대비요일"           width=70    align=center    Edit=none    EditStyle=Lookup   Data="DS_CMPR_DAY:CODE:NAME"</FC>'
					  + '<FC>id=CMPR_HOLIDAY_GB         name="휴일구분"           width=70    align=center    Edit=none    EditStyle=Lookup   Data="DS_CMPR_HOLIDAY_GB:CODE:NAME"</FC>'
					  + '<FC>id=CMPR_STD_WEIGHT         name="대비일자;표준가중치"   width=80    align=right    Edit=""    sumtext={subsum(CMPR_STD_WEIGHT)}    Dec=2</FC>'
					  + '<FC>id=CMPR_SALE_REMARK        name="특이사항"           width=140    align=left     Edit=""</FC>';

     initGridStyle(GD_MASTER, "common", hdrProperies, true);
     //합계표시
     GD_MASTER.ViewSummary = "1";
     GD_MASTER.DecRealData = true;
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
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    //저장체크
    if (DS_IO_MASTER.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    DS_IO_MASTER.ClearData();

    var strStrCd     = LC_STR_CD.BindColVal;   //점
    
    //1. validation 
    if(!chkValidation("search")) return;
    
    var strSMon      = EM_SALE_S_MON.text;       //영업조회월
    
    var goTo         = "searchMaster";
    var action       = "O";
    var parameters   = "&strStrCd="            + encodeURIComponent(strStrCd)
                     + "&strSMon="             + encodeURIComponent(strSMon);
    TR_MAIN.Action   = "/dps/psal201.ps?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    if(DS_IO_MASTER.CountRow > 0){
    	setFocusGrid(GD_MASTER, DS_IO_MASTER, 1, "STD_WEIGHT");
        GD_MASTER.Focus();
    }
    
}

/**
 * btn_New()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개     요 : Grid 레코드 추가// 영업시작일자 기준으로 해당 월의 마지막 날까지 레코드 추가
 * return값 : void
 */
function btn_New() {
	//저장체크
    if (DS_IO_MASTER.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1085");
        if (ret != "1") {
            return false;
        } 
    }
	DS_IO_MASTER.ClearData();
	var strSaleSDate = EM_SALE_S_DT.text;             //영업시작일자
	var strCmprDate  = EM_SALE_E_DT.text;             //대비일자
	
    var lastDate = new Date(strSaleSDate.substr(0,4), strSaleSDate.substr(4,2), 0);
    var lastday  = lastDate.getDate();
	
	var strGap   = daysBetween(strSaleSDate, strSaleSDate.substr(0,6)+lastday);

    var strStrCd     = LC_STR_CD.BindColVal;   //점
    var strDate      = strSaleSDate;
    var strCDate     = strCmprDate;
    
	var j = 0;
	
    //영업시작일자의 월에 데이터 있는지 체크
    var goTo         = "searchSchedule";
    var action       = "O";
    var parameters   = "&strStrCd="            + encodeURIComponent(strStrCd) 
                     + "&strSaleSDate="        + encodeURIComponent(strSaleSDate);
    TR_MAIN.Action   = "/dps/psal201.ps?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_SCHEDULE=DS_SCHEDULE)"; 
    TR_MAIN.Post();
    
    
    if(DS_SCHEDULE.CountRow != 0){
        showMessage(StopSign, OK, "USER-1000", "해당월에 데이터가 있습니다. 조회 후 수정 하십시오.");
        return;
    }
    
    
	GD_MASTER.ReDraw = false;
	
	for(i=1; i <= strGap+1; i++){
		j = i;
		DS_IO_MASTER.Addrow();
		
		DS_IO_MASTER.NameValue(i,"STR_CD") = strStrCd;
		
		DS_IO_MASTER.NameValue(i,"STD_WEIGHT") = 1;
		for(k=0; k < DS_STR_CD.CountRow; k++){
			if(strStrCd == DS_STR_CD.NameValue(k,"CODE")){
				DS_IO_MASTER.NameValue(i,"STR_NAME") = DS_STR_CD.NameValue(k,"NAME");
			}
		}
		strDate = replaceStr(strDate, "-", "");
		
		DS_IO_MASTER.NameValue(i,"SALE_DT") = strDate;
		var thisDate = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, strDate.substr(6,2));
		var thisWeek = thisDate.getDay();
		var strWeek = thisWeek+1;

		var strWeekGb = "";
		
		
		switch (strWeek) {
	    case 1 :  strWeekGb = "2";
	        break;
        case 2 : strWeekGb = "0";
            break;
        case 3 :  strWeekGb = "0";
            break;
        case 4 :  strWeekGb = "0";
            break;
        case 5 :  strWeekGb = "0";
            break;
        case 6 :  strWeekGb = "0";
            break;
        case 7 :  strWeekGb = "1";
            break;
	    }
		
		DS_IO_MASTER.NameValue(i,"DAY_WEEK") = strWeek;
		DS_IO_MASTER.NameValue(i,"HOLIDAY_GB") = strWeekGb;
		
		strCDate = replaceStr(strCDate, "-", "");
		DS_IO_MASTER.NameValue(i,"CMPR_DT") = strCDate;
		
		thisDate = new Date(strCDate.substr(0,4), strCDate.substr(4,2)-1, strCDate.substr(6,2));
        thisWeek = thisDate.getDay();
        strWeek = thisWeek+1;
        
        strWeekGb = "";
        
        
        switch (strWeek) {
        case 1 :  strWeekGb = "2";
            break;
        case 2 : strWeekGb = "0";
            break;
        case 3 :  strWeekGb = "0";
            break;
        case 4 :  strWeekGb = "0";
            break;
        case 5 :  strWeekGb = "0";
            break;
        case 6 :  strWeekGb = "0";
            break;
        case 7 :  strWeekGb = "1";
            break;
        }
        
        DS_IO_MASTER.NameValue(i,"CMPR_DAY") = strWeek;
        DS_IO_MASTER.NameValue(i,"CMPR_HOLIDAY_GB") = strWeekGb;
        
		strCDate = addDate("d", +1, strCDate);
		strDate  = addDate("d", +1, strDate);
		
		
		i = j;
	}

    GD_MASTER.ReDraw = true;
    
    for(i=1; i <= DS_IO_MASTER.CountRow; i++){
    	j = i;
    	var strStrCd     = DS_IO_MASTER.NameValue(i, "STR_CD");       //점
        var strSDate     = DS_IO_MASTER.NameValue(i, "CMPR_DT");      //대비일자
        
        var goTo         = "searchCmpr";
        var action       = "O";
        var parameters   = "&strStrCd="            + encodeURIComponent(strStrCd)
                         + "&strSDate="            + encodeURIComponent(strSDate);
        TR_MAIN.Action   = "/dps/psal201.ps?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_CMPR=DS_CMPR)"; 
        TR_MAIN.Post();
        
        i = j;
        if(DS_CMPR.CountRow > 0){
        	DS_IO_MASTER.NameValue(i,"CMPR_HOLIDAY_GB")  = DS_CMPR.NameValue(1,"HOLIDAY_GB");
        	DS_IO_MASTER.NameValue(i,"CMPR_STD_WEIGHT")  = DS_CMPR.NameValue(1,"STD_WEIGHT");
            DS_IO_MASTER.NameValue(i,"CMPR_SALE_REMARK") = DS_CMPR.NameValue(1,"SALE_REMARK");
        }
    }

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    DS_IO_MASTER.RowPosition = 1;
    setFocusGrid(GD_MASTER, DS_IO_MASTER, 1, "STD_WEIGHT");
    GD_MASTER.Focus();
	
	
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Delete() {
    if(DS_IO_MASTER.CountRow == 0) return;
    
   
    var strStrCd     = DS_IO_MASTER.NameValue(1,"STR_CD");
    var strSMon      = DS_IO_MASTER.NameValue(1,"SALE_DT").substr(0,6);       //영업조회월
    
    //삭제하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1032", strSMon.substr(0,4)+"년"+strSMon.substr(4,2)+"월"+" 영업일정보") != 1)
        return;
    
    DS_IO_MASTER.DELETEROW(1);
    
    var goTo         = "del";
    var parameters   = "&strStrCd="            + encodeURIComponent(strStrCd) 
                     + "&strSMon="             + encodeURIComponent(strSMon);
    
    TR_MAIN.Action   = "/dps/psal201.ps?goTo=del"   + parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
    // 조회결과 Return
    GD_MASTER.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (!DS_IO_MASTER.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
        return;

    TR_MAIN.Action = "/dps/psal201.ps?goTo=save";
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Excel() {
	if(DS_IO_MASTER.CountRow	<= 0){
		  showMessage(INFORMATION, OK, "USER-1000","다운 할	내용이 없습니다. 조회 후 엑셀다운 하십시오.");
			return;
		}
		var	strTitle = "영업일정보등록";

		
		var	parameters = ""	;
		
		
		GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
		//openExcel2(GD_MASTER, strTitle,	parameters,	true );
		openExcel5(GD_MASTER, strTitle,	parameters,	true , "",g_strPid );

		

}

/**
 * btn_Print()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 :  
 * 개     요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 

 function chkValidation(gbn){
     //1. validation Master 그리드 필수 입력 체크 
	 var strStrCd     = DS_IO_MASTER.NameValue(i, "STR_CD");       //점
	 var strSaleSDate = EM_SALE_S_DT.text;                         //영업시작일자

     switch (gbn) {
     case "search" :  

    	    //영업조회월
    	    if (isNull(EM_SALE_S_MON.text) ==true ) {
    	        showMessage(INFORMATION, OK, "USER-1003","영업조회월"); 
    	        return false;
    	    }
    	    //영업조회월 자릿수, 공백 체크
    	    if (EM_SALE_S_MON.text.replace(" ","").length != 6 ) {
    	        showMessage(INFORMATION, OK, "USER-1027","영업조회월","6");
    	        return false;
    	    }
    	    //년월형식체크
    	    if (!checkYYYYMM(EM_SALE_S_MON.text) ) {
                showMessage(INFORMATION, OK, "USER-1069","영업조회월");
                return false;
            }
    	    return true;
         break;
     case "save" : 
    	 var colSize = 0;
         var colVal  = "";
         var colName = "";
         var result  = false;
    	 var stdWeight = 0;
    	 var strHolidayGbcnt = 0;
    	 
         for(i=1;i <= DS_IO_MASTER.CountRow; i++){
        	 stdWeight += getRoundDec("1",DS_IO_MASTER.NameValue(i,"STD_WEIGHT"),2);
        	 if(DS_IO_MASTER.NameValue(i,"HOLIDAY_GB") == "4"){
        		 strHolidayGbcnt++;
        	 }
        	 var colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("SALE_REMARK"));
             var colVal  = DS_IO_MASTER.NameValue(i,"SALE_REMARK");
             var colName = "특이사항";
             var result  = checkByteLengthStr(colVal,colSize,"N");
        	 if( result){
                 showMessage(INFORMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
                 DS_IO_MASTER.NameValue(i,"SALE_REMARK") = result;
                 setFocusGrid(GD_MASTER, DS_IO_MASTER, i, "SALE_REMARK");
                 return false;
             }
         }
         
         stdWeight = getRoundDec("1",stdWeight,2);
         
         if(DS_IO_MASTER.CountRow-strHolidayGbcnt < stdWeight){
        	 showMessage(INFORMATION, OK, "USER-1000","매출가중치의 총합이 월 총 일수("+(DS_IO_MASTER.CountRow-strHolidayGbcnt)+"일 기준)보다 클 수 없습니다."); 
        	 setFocusGrid(GD_MASTER, DS_IO_MASTER, 1, "STD_WEIGHT");
             return false;
         }
         return true;
         break;
     }
 }
 

/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function chkSave() {
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;

    TR_MAIN.Action = "/dps/psal201.ps?goTo=save";
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();

}
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    old_Row = row;
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>

return true;
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>

</script>

<!-- 20120605 * DHL * 추가  START  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
	if(colid == "CMPR_DT"){
		openCal(GD_MASTER,row,colid,'G');
	}
</script>
<!-- 20120605 * DHL * 추가    END  -->

<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>

var stdWeight = 0;
var strHolidayGbcnt = 0;

for(i=1;i <= DS_IO_MASTER.CountRow; i++){
    stdWeight += getRoundDec("1",DS_IO_MASTER.NameValue(i,"STD_WEIGHT"),2);
    if(DS_IO_MASTER.NameValue(i,"HOLIDAY_GB") == "4"){
        strHolidayGbcnt++;
    }
    
}

stdWeight = getRoundDec("1",stdWeight,2);

if(DS_IO_MASTER.CountRow-strHolidayGbcnt < stdWeight){
	GD_MASTER.ColumnProp("STD_WEIGHT", "SumColor") = "red";
}
else{
	GD_MASTER.ColumnProp("STD_WEIGHT", "SumColor") = "";
}

/*
switch (colid){
case  "STD_WEIGHT" :
    var stdWeight = 0;
    for(j=1;j <= DS_IO_MASTER.CountRow; j++){
        stdWeight += getRoundDec("3",DS_IO_MASTER.NameValue(j,"STD_WEIGHT"),2);
        
    }
    stdWeight = getRoundDec("3",stdWeight,2);
    
    if(DS_IO_MASTER.CountRow < stdWeight){
        showMessage(INFORMATION, OK, "USER-1000","매출가중치의 총합이 월 총 일수("+DS_IO_MASTER.CountRow+"일 기준)보다 클 수 없습니다."); 
        var ColCnt = this.CountColumn;
        for( var i=1; i<=ColCnt;i++){
            if(DS_IO_MASTER.RWStatus(row,i) != 0)
            	DS_IO_MASTER.NameValue( row, DS_IO_MASTER.ColumnID(i)) = DS_IO_MASTER.OrgNameValue(row,DS_IO_MASTER.ColumnID(i));
        }
        setFocusGrid(GD_MASTER, DS_IO_MASTER, row, "STD_WEIGHT");
        return false;
    }
    return true;
    break;
}
*/
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>

switch (colid){
case  "HOLIDAY_GB" :
	if(DS_IO_MASTER.NameValue(row, "HOLIDAY_GB")== "4"){
		DS_IO_MASTER.NameValue(row, "STD_WEIGHT")= 0;
	}
	break;

// 20120605 * DHL * 추가  START -->
case "CMPR_DT" :
	var strCmprDate = "";
	var thisDate = "";
	var thisWeek = "";
	var strWeek  = "";
	var strWeekGb = "";

	strCmprDate = DS_IO_MASTER.NameValue(row, "CMPR_DT");
	strCmprDate = replaceStr(strCmprDate, "-", "");	
	thisDate = new Date(strCmprDate.substr(0,4), strCmprDate.substr(4,2)-1, strCmprDate.substr(6,2));
	thisWeek = thisDate.getDay();
	strWeek = thisWeek+1;
	strWeekGb = "";
	
	
	switch (strWeek) {
	case 1 :  strWeekGb = "2";
	    break;
	case 2 : strWeekGb = "0";
	    break;
	case 3 :  strWeekGb = "0";
	    break;
	case 4 :  strWeekGb = "0";
	    break;
	case 5 :  strWeekGb = "0";
	    break;
	case 6 :  strWeekGb = "0";
	    break;
	case 7 :  strWeekGb = "1";
	    break;
	}
	
	DS_IO_MASTER.NameValue(row,"CMPR_DAY") = strWeek;
	DS_IO_MASTER.NameValue(row,"CMPR_HOLIDAY_GB") = strWeekGb;
	DS_IO_MASTER.NameValue(row, "CMPR_STD_WEIGHT")= 1;

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    DS_IO_MASTER.RowPosition = row;
    setFocusGrid(GD_MASTER, DS_IO_MASTER, 1, "CMPR_STD_WEIGHT");
    GD_MASTER.Focus();
    
	break;
	// 20120605 * DHL * 추가  START <--
}
</script>

<!-- 영업시작일자 -->
<script language=JavaScript for=EM_SALE_S_DT event=onKillFocus()>
    if(EM_SALE_S_DT.text.replace(" ","").length != 8){
        showMessage(INFORMATION, OK, "USER-1004", "영업시작일자");
        EM_SALE_S_DT.text = getTodayFormat('YYYYMMDD');
        EM_SALE_S_DT.Focus();
        return;
    }
    
</script>

<!--대비시작일자 -->
<script language=JavaScript for=EM_SALE_E_DT event=onKillFocus()>
    if(EM_SALE_E_DT.text.replace(" ","").length != 8){
        showMessage(INFORMATION, OK, "USER-1004", "대비시작일자");
        EM_SALE_E_DT.text = getTodayFormat('YYYYMMDD');
        EM_SALE_E_DT.Focus();
        return;
    }
    
</script>


<!-- 영업조회월 -->
<script language=JavaScript for=EM_SALE_S_MON event=onKillFocus()>

    //영업조회월
    if (isNull(EM_SALE_S_MON.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","영업조회월"); 
        EM_SALE_S_MON.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_S_MON.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","영업조회월","6");
        EM_SALE_S_MON.text = varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_SALE_S_MON.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","영업조회월");
        EM_SALE_S_MON.text = varToMon;
        return ;
    }
    EM_SALE_S_DT.text = EM_SALE_S_MON.text + "01";
    EM_SALE_E_DT.text = addDate('Y',-1, EM_SALE_S_DT.text);
    
</script>

<script language="javascript">
var today    = new Date();
var old_Row = 0;

//오늘 일자 셋팅 
var now = new Date();
var mon = now.getMonth()+1;
if(mon < 10)mon = "0" + mon;
var day = now.getDate();
if(day < 10)day = "0" + day;
var varToday = now.getYear().toString()+ mon + day;
var varToMon = now.getYear().toString()+ mon;
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
<comment id="_NSID_"><object id="DS_DAY_WEEK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CMPR_DAY"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HOLIDAY_GB"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CMPR_HOLIDAY_GB"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CMPR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SCHEDULE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_WEATHER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_COMMON classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
 
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="110">
                     <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </TD>
            <th width="80" class="point">영업조회월</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_SALE_S_MON classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_SALE_S_MON)" align="absmiddle"/>
            </td>
            <th width="80">영업시작일자</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_S_DT)" align="absmiddle"/>
            </td>
            <th width="110">대비시작일자</th>
            <td>
                  <comment id="_NSID_">
                      <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_E_DT)" align="absmiddle"/>
            </td>
            
          </tr>
          <tr>
          <td style="display:none;" >
                  <comment id="_NSID_">
                      <object id=EM_WEATHER classid=<%=Util.CLSID_LUXECOMBO%> style="display:none;" width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GD_MASTER width=100% height=510 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>            
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

