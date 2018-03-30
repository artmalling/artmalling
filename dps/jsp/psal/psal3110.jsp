<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박종은
 * 수 정 자 : 홍종영
 * 파 일 명 : psal3110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출속보현황(조직별)
 * 이    력 :2010.04.08 박종은
 *		  2012.07.17 홍종영 chart 교체
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
	SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                							*-->
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
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/shiftchart.js"	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        								*-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	 
	//Master 그리드 세로크기자동조정  2013-07-17
 	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";  
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_MASTER_CHART.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //대비일자
    EM_SALE_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;
    

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                  //점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
 	
    
    LC_STR_CD.BindColVal  = strcd;   
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    orgFlagCheck(orgFlag);
    
//     var strCmprdt = searchCmpr();
//     EM_SALE_DT_E.text =  addDate('D',-364, EM_SALE_DT_S.text);    // 2011.08.27 MARIO OUTLET
	var strCmprdt = getBeforeYearDay(varToday);//아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02
    EM_SALE_DT_E.text =  strCmprdt;    //아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    
	//기본설정
// 	StartAdd();		// 처음 보이는 화면에 기본 타입을 보여주기 위해 설정
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal311","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
			    	 + '<FC>id=STR_CD                 name="점코드"      width=100    align=center    suppress=1 show=false</FC>'
			         + '<FC>id=STR_NAME               name="점명"        width=80    align=left      suppress=1   </FC>'
                     + '<FC>id=ORG_CD                 name="조직코드"      width=100    align=center    suppress=2 show=false</FC>'
                     + '<FC>id=ORG_NAME               name="조직명"        width=150    align=left      suppress=2   sumtext="합계"</FC>'
                     + '<C>id=ORIGIN_SALE_TAMT        name="실행목표"      width=100    align=right    mask="###,###"     value={ORIGIN_SALE_TAMT} sumtext={subsum(ORIGIN_SALE_TAMT)}</C>'
                     //+ '<C>id=ORIGIN_SALE_TAMT2        name="실행계획"      width=90    align=right    mask="###,###"     value={IF(ORIGIN_SALE_TAMT=0,ORIGIN_SALE_TAMT,ORIGIN_SALE_TAMT/1000)} </C>'
                     + '<C>id=TOT_SALE_AMT            name="실적"          width=100    align=right    mask="###,###"     value= {TOT_SALE_AMT} sumtext={subsum(TOT_SALE_AMT)}</C>'
                     //+ '<C>id=TOT_SALE_AMT2            name="실적"          width=90    align=right    mask="###,###"     value= {IF(TOT_SALE_AMT=0,TOT_SALE_AMT,TOT_SALE_AMT/1000)} </C>'
                     + '<C>id=ACHIEVERATE             name="달성율(%)"        width=80    align=right     mask="#,###.00"    sumtext={round((sum(TOT_SALE_AMT)/sum(ORIGIN_SALE_TAMT))*100,2)}</C>'
                     + '<C>id=RATE                    name="구성비(%)"        width=80    align=right     mask="#,###.00"    value={round((TOT_SALE_AMT/sum(TOT_SALE_AMT))*100,2)}  Dec=2</C>'
                     + '<C>id=EXPECT_AMT              name="예상매출"        width=100    align=right     mask="###,###"    sumtext={subsum(EXPECT_AMT)}</C>'
                     + '<C>id=TOT_SALE_AMT_CMPR       name="대비실적"      width=100    align=right    mask="###,###"     sumtext={subsum(TOT_SALE_AMT_CMPR)}</C>'
                     //+ '<C>id=EXPECT_AMT2              name="예상매출"        width=90    align=right     mask="###,###"    value={IF(EXPECT_AMT=0,EXPECT_AMT,EXPECT_AMT/1000)}</C>'
                     //+ '<C>id=TOT_SALE_AMT_CMPR2       name="대비실적"      width=90    align=right    mask="###,###"     value={IF(TOT_SALE_AMT_CMPR=0,TOT_SALE_AMT_CMPR,TOT_SALE_AMT_CMPR/1000)} </C>'
                     + '<C>id=SALEIRATE               name="대비율(%)"        width=80    align=right     mask="#,###.00"    </C>'
                     //+ '<C>id=REDU_AMT                name="할인"          width=90    align=right    mask="###,###"    value= {REDU_AMT} sumtext={subsum(REDU_AMT)} show=false</C>'
                     //+ '<C>id=SALE_AMT                name="매출"          width=90    align=right    mask="###,###"    value= {SALE_AMT} sumtext={subsum(SALE_AMT)} show=false</C>'
                     //+ '<C>id=DC_AMT                  name="에누리"        width=90    align=right    mask="###,###"    value= {DC_AMT} sumtext={subsum(DC_AMT)} show=false</C>'
                     //+ '<C>id=NET_SALE_AMT            name="순매출"        width=90    align=right     mask="###,###"    value= {NET_SALE_AMT} sumtext={subsum(NET_SALE_AMT)} show=false</C>'
                     //+ '<C>id=SALE_PROF_AMT           name="이익액"        width=90    align=right     mask="###,###"    value= {SALE_PROF_AMT} sumtext={subsum(SALE_PROF_AMT)} show=false</C>'
                     //+ '<C>id=PROFRATE                name="이익율"        width=60    align=right     mask="#,###.00"   show=false</C>'
                     + '<C>id=CUST_CNT                name="객수"          width=60    align=right      mask="###,###"    sumtext={subsum(CUST_CNT)}</C>'
                     //+ '<C>id=CUST_DANGA              name="객단가"        width=80    align=right     mask="###,###"     value= {CUST_DANGA}</C> show=false'
                     + '<C>id=CUST_CNT_CMPR           name="대비객수"      width=80    align=right     mask="###,###"    sumtext={subsum(CUST_CNT_CMPR)}</C>'
                     + '<C>id=CUST_CNT_RATE           name="객수비(%)"      width=80    align=right     mask="#,###.00"  sumtext={round((sum(CUST_CNT)/sum(CUST_CNT_CMPR))*100,2)}</C>';
                     //IF(TOT_SALE_AMT=0,TOT_SALE_AMT,TOT_SALE_AMT/1000)
   
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
}
function orgFlagCheck(orgFlag){ 

	if (orgFlag == "11") {
		EM_ORG_FLAG.Enable = "false";
		EM_ORG_FLAG.Reset();
	}else if (orgFlag == "12") {
		EM_ORG_FLAG.Enable = "true";
		EM_ORG_FLAG.Reset();
	}else{
		EM_ORG_FLAG.Enable = "false";
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월

    
    /* 조건절 팀 조회시 */
    if(strDeptCd != "%"){
    	GD_MASTER.ColumnProp("STR_NAME", "name")   = "점명"
        GD_MASTER.ColumnProp("ORG_NAME", "name")   = "파트명"
    }
    
    /* 조건절 팀 and 파트 조회시 */
    if(strDeptCd != "%" && strTeamCd != "%" ){
    	GD_MASTER.ColumnProp("STR_NAME", "name")   = "점명"
        GD_MASTER.ColumnProp("ORG_NAME", "name")   = "PC명"
    }
    
    /* 조건절 팀 and 파트 and PC 조회시 */
    if(strTeamCd != "%" && strPCCd != "%" && strDeptCd != "%"){
        GD_MASTER.ColumnProp("STR_NAME", "name")   = "점명"
        GD_MASTER.ColumnProp("ORG_NAME", "name") = "브랜드명"
    }
    
    /* 전체 조회시 */
    if(strTeamCd == "%" && strPCCd == "%" && strDeptCd == "%"){
        GD_MASTER.ColumnProp("STR_NAME", "name")   = "점명"
        GD_MASTER.ColumnProp("ORG_NAME", "name")   = "조직명"
    }
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal311.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    
    //var iframeWidth = document.getElementById('CHART_001').clientWidth-40;
    //var iframeHeight = document.getElementById('CHART_001').clientHeight-10;
   
    //viewChart("CHART_001","2",iframeWidth,iframeHeight,"실행목표||실적||대비실적||예상매출||객수||대비객수","ORIGIN_SALE_TAMT_CHART||TOT_SALE_AMT_CHART||TOT_SALE_AMT_CMPR_CHART||EXPECT_AMT_CHART||CUST_CNT||CUST_CNT_CMPR","ORG_NAME",DS_O_MASTER, GD_MASTER,"일별 매출 속보 조회");
   
   
}

function getGridDataTypeToChartDataType(gridDataType){
    switch(gridDataType){
        case 2:
            return "Integer";
        case 3:
            return "Double";
    }
    return "String";
}


/* function viewChart( iFrameId, chartType, width, height, colLabel, dataId, yNameId, dataSet, grid, title){
    var colLabelList   = colLabel.split("||");
    var dataIdList     = dataId.split("||");
    var colLabelTotal  = colLabelList.length;
    var dataIdTotal    = dataIdList.length;
    var dataTotal      = dataSet.CountRow;
    
    if( colLabelTotal != dataIdTotal){
        return;
    }
    
    var dataXmlStr = '<?xml version="1.0" encoding="euc-kr"?>';
    dataXmlStr    += '  <CHARTFX>';
    dataXmlStr    += '    <COLUMNS>';
    dataXmlStr    += '      <COLUMN NAME="'+yNameId+'" TYPE="String"/>';
    for( var i=0; i<colLabelTotal; i++){        
        dataXmlStr    += '      <COLUMN NAME="'+dataIdList[i]+'" ';
        dataXmlStr    += '              TYPE="'+getGridDataTypeToChartDataType(dataSet.ColumnType(dataSet.ColumnIndex(dataIdList[i])))+'" ';
        dataXmlStr    += '              DESCRIPTION="'+colLabelList[i]+'"/>';       
    }
    dataXmlStr    += '    </COLUMNS>';
    
    for(var i=1; i<=dataTotal; i++){
    	
        dataXmlStr    += '     <ROW '+yNameId+'="'+grid.VirtualString2( i, yNameId ,0).replace("&","&amp;")+'"';
        
        for(var j=0; j<dataIdTotal; j++){
        	
            dataXmlStr    += '          '+dataIdList[j]+'="'+dataSet.NameValue( i, dataIdList[j])+'" ';
        }
        dataXmlStr    += '     ></ROW>';
        
    }
    
    dataXmlStr    += '  </CHARTFX>';
    
    var parameter = "[{chartType:'"+chartType+"'";
    if( width != null){
        parameter += ",strWidth:"+width;
    }
    if( height != null){
        parameter += ",strHeight:"+height;
    }
    if( title != null){
        parameter += ",strTitle:'"+title+"'";
    }
    parameter +=",xmlData:'"+dataXmlStr+"'";
    
    parameter +="}]";
    
    
    postwith(iFrameId,"/dps/jsp/psal/psal3111.jsp",eval(parameter)[0]);
} */

function postwith(taget,to,p) {
    
	var myForm = document.createElement("form");
    myForm.method="post" ;
    myForm.action = to ;
    myForm.target = taget;
    for (var k in p) {
    	var myInput = document.createElement("input");
        myInput.setAttribute("name", k) ;
        myInput.setAttribute("value", p[k]);
        myForm.appendChild(myInput);
    }
    document.body.appendChild(myForm) ;
    myForm.submit() ;
    document.body.removeChild(myForm) ;
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Save() {

    
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "매출속보현황(조직별)";

    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    
    var parameters = "점 "           + strStrCd
                   + " ,   팀 "     + strDeptCd
                   + " ,   파트 "       + strTeamCd
                   + " ,   PC "      + strPCCd
                   + " ,   매출일자 "  + strSaleDtS
                   + " ,   대비일자 "  + strSaleDtE ;
    
    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    //openExcel2(GD_MASTER, strTitle, parameters, true );
    openExcel5(GD_MASTER, strTitle, parameters, true , "",g_strPid );

}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */

 function btn_Conf() {
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/



/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
    switch (gbn){
    case "search" :

        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }
        //팀 체크
        if (isNull(LC_DEPT_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","팀");
            LC_DEPT_CD.focus();
            return false;
        }

        //PC가 전체가 이닐경우 파트 체크
        if(LC_PC_CD.BindColVal != "%" && LC_TEAM_CD.BindColVal == "%"){
            showMessage(Information, OK, "USER-1003","파트");
            LC_TEAM_CD.focus();
            return false;
        }
        //매출일자
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","대비일자"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","대비일자","8");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_E.text)){
            showMessage(Information, OK, "USER-1004","대비일자");
            EM_SALE_DT_E.focus();
            return false;
        }
        break;
   
    }
    return true;
}

/**
 * searchCmpr()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchCmpr(){

    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strSaleDtS      = EM_SALE_DT_S.text;         //매출일자
    
    var goTo       = "searchCmprdt" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS);
    
    TR_MAIN.Action="/dps/psal311.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CMPRDT=DS_O_CMPRDT)"; //조회는 O
    TR_MAIN.Post();

    if(DS_O_CMPRDT.CountRow > 0){
        return DS_O_CMPRDT.NameValue(0,"CMPR_DT");
    }
    return "" ;
    
}

function StartAdd(){
	//차트 클리어
	Chart.ClearChart();
	
	//y축 최소값/최대값/증가값/자동값 설정
	SetChartAxisStyle("Chart", "Left", 0, 1000000000, 200000000, "true", "true", "false");
	
	//타이틀
	TitleTextFix("Chart","Header","일별 매출 속보 조회");
	Chart.Header.CustomPosition =true;
	Chart.Header.Left = 380;
	
	//웰
	Chart.Walls.Visible = true;
	Chart.Walls.Right.Size = 10;
	Chart.Walls.Back.Transparent = true;

	//Panel 설정
	Chart.Panel.Gradient.Visible = "true";
	Chart.Panel.ForeColor = Chart.ToOLEColor("ced8e0");
	Chart.Panel.Gradient.StartColor =Chart.ToOLEColor("ffffff");
	Chart.Panel.Gradient.MidColor =Chart.ToOLEColor("ffffff");
	Chart.Panel.Gradient.EndColor =Chart.ToOLEColor("ffffff");
	
	//3D 설정
	SetAspectStyle("Chart", "false");
	//범례 설정
	Chart.Legend.Visible = true;
	Chart.Legend.Alignment = 3;
	
	Chart.Legend.Left = 150;
	Chart.Legend.Top = 265;
	Chart.Legend.CustomPosition = true;
	Chart.Legend.ColumnWidthAuto = false;
	Chart.Legend.ColumnWidths(0) = 68;
	
	//Zoom 설정
	Chart.Zoom.Enable=false;
}

function Start(){
	//기본설정
	StartAdd();
	//Chart.ClearChart();
	
	//시리즈 추가
	Chart.AddSeries(4);	
	
	//시리즈 1
	Chart.Series(0).DataID								= "DS_O_MASTER_CHART";
	Chart.Series(0).YValues.Column						= "ORIGIN_SALE_TAMT";
	Chart.Series(0).PointLabels.Column					= "ORG_NAME";
	Chart.Series(0).Title								= "실행목표";
	Chart.Series(0).Color								= Chart.ToOLEColor(SEREIS_COLOR_21);
	Chart.Series(0).ColorEachPoint						= "false";
	Chart.Series(0).asBar.MultiBar						= "1";
	Chart.Series(0).asBar.BarWidth						= "740";
	
	//시리즈 2
  	var new_series2 = 0;
	new_series2 = Chart.AddSeries(4);
	Chart.Series(new_series2).DataID					= "DS_O_MASTER_CHART";
	Chart.Series(new_series2).YValues.Column			= "TOT_SALE_AMT";
	Chart.Series(new_series2).PointLabels.Column		= "ORG_NAME";
	Chart.Series(new_series2).Title						= "실적";
	Chart.Series(new_series2).Color						= Chart.ToOLEColor(SEREIS_COLOR_22);
	Chart.Series(new_series2).ColorEachPoint			= "false";
	Chart.Series(new_series2).asBar.MultiBar			= "1";
	Chart.Series(new_series2).asBar.BarWidth			= "740";	
	
	//시리즈 3
  	var new_series3 = 0;
	new_series3 = Chart.AddSeries(4);
	Chart.Series(new_series3).DataID					= "DS_O_MASTER_CHART";
	Chart.Series(new_series3).YValues.Column			= "TOT_SALE_AMT_CMPR";
	Chart.Series(new_series3).PointLabels.Column		= "ORG_NAME";
	Chart.Series(new_series3).Title						= "대비실적";
	Chart.Series(new_series3).Color						= Chart.ToOLEColor(SEREIS_COLOR_23);
	Chart.Series(new_series3).ColorEachPoint			= "false";
	Chart.Series(new_series3).asBar.MultiBar			= "1";
	Chart.Series(new_series3).asBar.BarWidth			= "740";	
	
	//시리즈 4
  	var new_series4 = 0;
	new_series4 = Chart.AddSeries(4);
	Chart.Series(new_series4).DataID					= "DS_O_MASTER_CHART";
	Chart.Series(new_series4).YValues.Column			= "EXPECT_AMT";
	Chart.Series(new_series4).PointLabels.Column		= "ORG_NAME";
	Chart.Series(new_series4).Title						= "예상매출";
	Chart.Series(new_series4).Color						= Chart.ToOLEColor(SEREIS_COLOR_24);
	Chart.Series(new_series4).ColorEachPoint			= "false";
	Chart.Series(new_series4).asBar.MultiBar			= "1";
	Chart.Series(new_series4).asBar.BarWidth			= "800";	
	
	//시리즈 5
  	var new_series5 = 0;
	new_series5 = Chart.AddSeries(4);
	Chart.Series(new_series5).DataID					= "DS_O_MASTER_CHART";
	Chart.Series(new_series5).YValues.Column			= "CUST_CNT";
	Chart.Series(new_series5).PointLabels.Column		= "ORG_NAME";
	Chart.Series(new_series5).Title						= "객수";
	Chart.Series(new_series5).Color						= Chart.ToOLEColor(SEREIS_COLOR_25);
	Chart.Series(new_series5).ColorEachPoint			= "false";
	Chart.Series(new_series5).asBar.MultiBar			= "1";
	Chart.Series(new_series5).asBar.BarWidth			= "740";	
	
	//시리즈 6
  	var new_series6 = 0;
	new_series6 = Chart.AddSeries(4);
	Chart.Series(new_series6).DataID					= "DS_O_MASTER_CHART";
	Chart.Series(new_series6).YValues.Column			= "CUST_CNT_CMPR";
	Chart.Series(new_series6).PointLabels.Column		= "ORG_NAME";
	Chart.Series(new_series6).Title						= "대비객수";
	Chart.Series(new_series6).Color						= Chart.ToOLEColor(SEREIS_COLOR_26);
	Chart.Series(new_series6).ColorEachPoint			= "false";
	Chart.Series(new_series6).asBar.MultiBar			= "1";
	Chart.Series(new_series6).asBar.BarWidth			= "740";
		
	//차트 리로드
	Chart.reset();
}

function xx(){
	DS_O_MASTER_CHART.ClearData();
	
	DS_O_MASTER_CHART.addRow();
	
	DS_O_MASTER_CHART.NameValue(1,"ORIGIN_SALE_TAMT")	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORIGIN_SALE_TAMT");
	DS_O_MASTER_CHART.NameValue(1,"TOT_SALE_AMT")		= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TOT_SALE_AMT");
	DS_O_MASTER_CHART.NameValue(1,"TOT_SALE_AMT_CMPR")	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TOT_SALE_AMT_CMPR");
	DS_O_MASTER_CHART.NameValue(1,"EXPECT_AMT")			= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"EXPECT_AMT");
	DS_O_MASTER_CHART.NameValue(1,"CMPR_SALE_AMT_TOT")	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CUST_CNT");
	DS_O_MASTER_CHART.NameValue(1,"CUST_CNT_CMPR")		= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CUST_CNT_CMPR");
	DS_O_MASTER_CHART.NameValue(1,"ORG_NAME")			= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORG_NAME");

// 	Start();
}

</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     								*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 								*-->
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

 <!-- Grid GD_MASTER OnPopup event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>

 </script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	xx();
</script>

<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>
<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_ORG_FLAG event=OnSelChange()>

	/*
	if(EM_ORG_FLAG.CodeValue=="1"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
		getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal=strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
	     
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0;
	}
	*/
	//var strOrgFlag=EM_ORG_FLAG.CodeValue;

	var strOrgFlag="1";					//매입도 모든점을 표시
	var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점
	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀
	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트
	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC
	
	LC_STR_CD.BindColVal=strcd;
	LC_DEPT_CD.Index = 0;
	LC_TEAM_CD.Index = 0;
	LC_PC_CD.Index   = 0;

</script>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
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
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
    if(LC_TEAM_CD.BindColVal != "%"){
    	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>


<!-- 마스터 그리드 컬럼 변경시 저장 체크 처리 -->
<script language=Javascript for=GD_MASTER   event=OnColumnPosChanged(Row,Colid)>

   
</script>

<script language="javascript" for=GD_MASTER   event=OnUserColor(Row,eventid)>

</script>

<script language=JavaScript for=DS_O_MASTER   event=onColumnChanged(Row,Colid)>
old_Row = Row

// 이 Event에서 SetColumn을 사용하는 것은 의미가 없다. Changed를 수행한 후 SetColumn이 자동으로 수행되기 때문이다.
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회월
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출일자"); 
        EM_SALE_DT_S.text = varToday;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","매출일자","8");
        EM_SALE_DT_S.text = varToday;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","매출일자");
        EM_SALE_DT_S.text = varToday;
        return ;
    }

    var strCmprdt = searchCmpr();
    EM_SALE_DT_E.text =  strCmprdt;
    
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>
/*
    //영업조회월
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","대비일자"); 
        EM_SALE_DT_E.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","대비일자","8");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","대비일자");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
*/    
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
<comment id="_NSID_"><object id="DS_STR_CD"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DEPT_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TEAM_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PC_CD"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PUMBUN_CD"classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER_CHART"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_0_PC"		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CMPRDT"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
	<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	   <param name="KeyName" value="Toinb_dataid4">
	</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
	<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	    <param name="KeyName" value="Toinb_dataid4">
	</object>
</comment><script>_ws_(_NSID_);</script>

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
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
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
										<th width="70">조직구분</th>
										<td width="105" colspan="7"><comment id="_NSID_"> <object
												id="EM_ORG_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1
												style="height: 20; width: 95">
												<param name=Cols value="2">
												<param name=Format value="1^매장,2^매입">
												<param name=CodeValue value="<%=sessionInfo.getORG_FLAG()%>">
											</object> </comment> <script>
												_ws_(_NSID_);
											</script>
										</td>
									</tr>
									<tr>
										<th width="70" class="point">점</th>
										<td width="105"><comment id="_NSID_"> <object
												id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
										</td>
										<th width="70">팀</th>
										<td width="105"><comment id="_NSID_"> <object
												id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
										</td>
										<th width="70">파트</th>
										<td width="105"><comment id="_NSID_"> <object
												id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
										</td>
										<th width="70">PC</th>
										<td><comment id="_NSID_"> <object id=LC_PC_CD
												classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
												align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
										</td>
									</tr>
									<tr>
										<th class="point">매출일자</th>
										<td><comment id="_NSID_"> <object
												id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_S)"
											align="absmiddle" />
										</td>
										<th class="point">대비일자</th>
										<td colspan="5"><comment id="_NSID_"> <object
												id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('G',EM_SALE_DT_E); "
											align="absmiddle" />
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

<!-- 			<tr valign="top"> -->
<!-- 				<td> -->
<!-- 					<table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
<!-- 						<tr valign="top"> -->
<!-- 							<td> -->
<!-- 								<table width="100%" border="0" cellspacing="0" cellpadding="0" -->
<!-- 									class="BD4A"> -->
<!-- 									<tr> -->
<!-- 										<td width="100%"> -->
<!-- 											<iframe width="100%" height=210 id=CHART_001 name=CHART_001 src="" frameborder="0" ></iframe> -->
<%-- 											<comment id="_NSID_"> <object id=Chart width=800 --%>
<%-- 												height=300 classid=<%=Util.CLSID_SHIFTCHART%>></object> --%>
<!-- 											<param name="DataID" value="DS_O_MASTER_CHART"> -->
<%-- 											</object> </comment> <script> --%>
<!-- 											</script> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 								</table> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr valign="top" class="PT10">
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr valign="top">
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td width="100%"><comment id="_NSID_"> <object
												id=GD_MASTER width=100% height=750
												classid=<%=Util.CLSID_GRID%> tabindex=1>
												<param name="DataID" value="DS_O_MASTER">
											</object> </comment> <script>
												_ws_(_NSID_);
											</script></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>

		</table>
		<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

	</div>
</body>
</html>
