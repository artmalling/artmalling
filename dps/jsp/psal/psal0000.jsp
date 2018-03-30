<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal0000.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 기간별실적
 * 이    력 :2010.04.08 박종은
 * 
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
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 630;		//해당화면의 동적그리드top위치
 var CUR_GR;
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	
	 //Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	obj   = document.getElementById("GD_ACCNT"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top+480) + "px";
	
	initTab("TAB_MAIN");
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    //DS_O_APPRLINE.setDataHeader('<gauce:dataset name="H_SEL_APPRLINE"/>');
    DS_O_ACCNT.setDataHeader('<gauce:dataset name="H_SEL_ACCOUNT"/>');
    
	// 컴퍼넌트 세팅
    initEmEdit(EM_SALE_DT_S,      "YYYYMMDD", PK);   // 실적 시작일
    initEmEdit(EM_SALE_DT_E,      "YYYYMMDD", PK);   // 실적 종료일
    initEmEdit(EM_DEPT_NAME,   "GEN^80", NORMAL);   // 대비 시작일
    initEmEdit(EM_EMP_SEARCH,   "GEN^80", NORMAL);   // 대비 종료일
	//initEmEdit(EM_SALE_M,         "YYYYMM",	  PK);	 // 매출월
	//initEmEdit(EM_BF_SALE_M,      "YYYYMM",	  PK);	 // 대비월
	
    //initEmEdit(EM_PUMBUN_CD,   "CODE^6^0", NORMAL);          //브랜드(조회)
    initEmEdit(EM_DOC_TITLE, "GEN^80",   NORMAL);            //브랜드(조회)

    // 콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD,   "CODE^0^30,NAME^0^140", 1, PK);		// 점(조회)
   	initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80",  1, NORMAL);	// 결재상태
    //initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80",  1, NORMAL);	// 파트(조회)
    //initComboStyle(LC_PC_CD,DS_PC_CD,     "CODE^0^30,NAME^0^80",  1, NORMAL);	// PC(조회)

    //현재년도 셋팅
    EM_SALE_DT_S.alignment = 1;
    EM_SALE_DT_E.alignment = 1;
    // 실적
    EM_SALE_DT_S.text    = varToMon+"01";
    EM_SALE_DT_E.text    = varToday;
    //EM_SALE_M.text       = varToMon;
    
    /*
    // 대비
    EM_DEPT_NAME.text = addDate("m", -1, varToMon+"01");
    EM_EMP_SEARCH.text = addDate("m", -1, varToday);
    EM_BF_SALE_M.text    = addDate("m", -1, varToMon+"01");
	*/
	
    /* 아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02 */
    //EM_DEPT_NAME.text = getBeforeYearDay(EM_SALE_DT_S.text );
    //EM_EMP_SEARCH.text = getBeforeYearDay(EM_SALE_DT_E.text );
    //EM_BF_SALE_M.text    = varBf_Year_Mon;
    
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    //var strOrgFlag=EM_ORG_FLAG.CodeValue;
    //alert(strOrgFlag);
    //getStore2("DS_STR_CD", "Y", "", "Y", strOrgFlag);                                             	// 점   
    getEtcCode("DS_STR_CD"    , "D", "D220", "N"); 																		//점
    //getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                        	// 팀
    getEtcCode("DS_DEPT_CD"    , "D", "D221", "Y"); 																		//팀
    //getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); 	// 파트    
    //getPc2("DS_PC_CD", "Y",     LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC  
    if (strcd == "01")
    	strcd = "5200";	// 아트몰링 하단점
    else
    	strcd = "5100";	// 아트몰링 장안점
    	
    LC_STR_CD.BindColVal  = strcd;   
    LC_DEPT_CD.Index = 0;
    //LC_TEAM_CD.Index = 0;
    //LC_PC_CD.Index   = 0;
    
	//var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    //orgFlagCheck(orgFlag);
    CUR_GR = GD_MASTER;
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //RD_GUBUN.CodeValue = "1";
    //RD_GROUP.CodeValue = "3";
    
	EM_SALE_DT_S.Enable    = true;
	EM_SALE_DT_E.Enable    = true;
	//EM_DEPT_NAME.Enable = true;
	//EM_EMP_SEARCH.Enable = true;
	//EM_SALE_M.Enable       = false;
	//EM_BF_SALE_M.Enable    = false;
	
	//document.getElementById("RD_GROUP").style.display = "none";
	//document.getElementById("EM_SALE_FLAG").style.display = "none";
	
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //DETAIL
    gridCreate3();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    //registerUsingDataset("psal000","DS_O_MASTER" );
}

// 마스터
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               	name="NO"           width=30    align=center    </FC>'
			         + '<FC>id=CO_CD                  	name="점"			width=120    align=center	EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME" 	color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
			         + '<FC>id=USERPOSTNAME				name="부서"        	width=150   align=left      	color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
			         + '<C>id=DOCTITLE                 name="제목"         width=600   align=left      color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}	sumtext="합  계"</C>'
			         + '<FC>id=EXPENDDATE               name="결의일자"     width=90   	align=center   mask="XXXX/XX/XX"		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '<FC>id=EXPENDCOST		      	name="금액"         width=100   align=right    mask="###,###"   		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}	sumtext=@sum'
				     + '<FG> name="기안자"'
				     + '<FC>id=USEREMPNO                name="사번"         width=80   align=center      	color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '<FC>id=USERS                	name="명"         	width=80   align=center      	color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '</FG>'
				     + '<FG> name="결재정보"'
				     + '<FC>id=APPUSERNM                name="현결재자"    	width=80   align=center      		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '<FC>id=APPGBNM                	name="진행상태"    	width=70    align=center      		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '<FC>id=COMPLETEDDT              name="종결일시"    	width=170   align=center      		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '</FG>'
				     + '<FC>id=DOCID                	name="DOCID"    	width=80   align=center		show=false 		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
				     + '<FC>id=EXPENDNO                	name="EXPENDNO"    	width=80   align=center     show=false 		color={decode(APPGB,"1","#013ADF","2","#FF0040","#000000")}'
			         ;

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
}

//  디테일
function gridCreate2(){

	var hdrProperies = '<FC>id={currow}               	name="NO"           	width=30    align=center  Color={decode(COMP_AMT,0,"#000000","red")}  </FC>'
			        + '<FC>id=L_DESC                  	name="상세적요"     	width=200   align=left    Color={decode(COMP_AMT,0,"#000000","red")}  sumtext="합  계"</FC>'
			        + '<G> name="계정과목(차)"'
			        + '<FC>id=DEBITCODE					name="코드"				width=60	align=center    Color={decode(COMP_AMT,0,"#000000","red")} </FC>'
			        + '<FC>id=DEBITTITLE                name="명"             	width=150   align=left   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '<FC>id=L_COST                	name="공급가"          	width=100   	align=right    	mask="###,###"	Color={decode(COMP_AMT,0,"#000000","red")}	sumtext=@sum  </FC>'
			        + '<FC>id=VAT                		name="부가세"           width=100   	align=right    	mask="###,###"	Color={decode(COMP_AMT,0,"#000000","red")}	sumtext=@sum  </FC>'
			        + '</G>'
			        + '<G> name="계정과목(대)"'
			        + '<FC>id=DEBTERCODE				name="코드"				width=60	align=center    Color={decode(COMP_AMT,0,"#000000","red")} </FC>'
			        + '<FC>id=DEBTERTITLE               name="명"             	width=150   align=left   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '<FC>id=AMT			      		name="금액"         	width=100   	align=right     mask="###,###"  Color={decode(COMP_AMT,0,"#000000","red")}	sumtext=@sum </FC>'
			        + '</G>'
			        + '<FC>id=COMP_AMT			      	name="차액"         	width=100   	align=right    mask="###,###"  Color={decode(COMP_AMT,0,"#000000","red")}	sumtext=@sum </FC>'
			        + '<FC>id=AUTH_DATE               	name="증빙일자"        	width=80   align=center   	mask="XXXX/XX/XX"	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '<FC>id=AUTHTITLE               	name="증빙유형"        	width=140   align=left   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '<G> name="카드정보"'
			        + '<FC>id=CARDCD               		name="코드"             width=60   align=center   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '<FC>id=CARDNAME               	name="명"             	width=150   align=left   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '</G>'
			        + '<G> name="거래처정보"'
			        + '<FC>id=VENDCD               		name="코드"             width=60   align=center   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '<FC>id=VENDNAME               	name="명"             	width=150   align=left   	Color={decode(COMP_AMT,0,"#000000","red")}   </FC>'
			        + '</G>'
				   ;
			        

	initGridStyle(GD_DETAIL, "common", hdrProperies, false);
	GD_DETAIL.ViewSummary = "1";

}


function gridCreate3(){
		
	var hdrProperies = '<FC>id={currow}               	name="NO"           	width=30    align=center    </FC>'
			        + '<G> name="계정과목"'
			        + '<FC>id=CODE						name="코드"				width=60	align=center     </FC>'
			        + '<FC>id=TITLE                		name="명"             	width=200   align=left	sumtext="합  계"   	   </FC>'
			        + '</G>'
			        + '<G> name="차변"'
			        + '<FC>id=L_COST                	name="공급가(①)"        width=150   	align=right	sumtext=@sum    	mask="###,###"	  </FC>'
			        + '<FC>id=VAT                		name="부가세(②)"        width=150   	align=right sumtext=@sum   	mask="###,###"	  </FC>'
			        + '<FC>id=L_AMT                		name="합계(① + ②)"      width=150   	align=right sumtext=@sum   	mask="###,###"	  </FC>'
			        + '</G>'
			        + '<G> name="대변"'
			        + '<FC>id=AMT			      		name="금액(③)"         	width=150   	align=right sumtext=@sum    mask="###,###"   </FC>'
			        + '</G>'
			        + '<FC>id=COMP_AMT      			name="차액;(① + ② - ③)" width=150   	align=right  sumtext=0 		</FC>'
			        + '</G>'
				   ;
			        
	
	initGridStyle(GD_ACCNT, "common", hdrProperies, false);
	GD_ACCNT.ViewSummary = "1";
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
    
	switch(getTabItemSelect("TAB_MAIN")){
    case 1:
    	searchMaster();
        break;
    case 2:
    	searchAccnt();
        break;
	} 
	 
    
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
	
	var objGrd 			= "";	// 변환 그리드
	var strSaleDtFr  	= EM_SALE_DT_S.text;
	var strSaleDtTo  	= EM_SALE_DT_E.text;
	var strTitle 		= "";
	var strSignKind		= LC_DEPT_CD.Text;
	
	var parameters = "";

	switch(getTabItemSelect("TAB_MAIN")){
    case 1:	// 지출결의내역
    	
    	var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    	
    	if(rtnVal == "1"){
    		objGrd = GD_MASTER;
    		strTitle = "지출결의서내역";
    	}else if(rtnVal == "2"){
    		objGrd = GD_DETAIL;
    		strTitle = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DOCTITLE");
    		if (strTitle.length > 20 )
    			strTitle = strTitle.substring(0,20) + "..._상세";
    		else
    			strTitle = strTitle + "_상세";
    	}else{
    		return;
    	}
    	
    	parameters = "점 - "         + LC_STR_CD.Text
		   				+ ",  결재진행상태 -   "      + LC_DEPT_CD.Text
		   		   		+ ",  결의일자 -   "      + strSaleDtFr + "~" + strSaleDtTo
		   		   		;
    	
    	openExcel5(objGrd, strTitle, parameters, true, "",g_strPid );
    	
        break;
    case 2: // 계정과목집계
    	objGrd = GD_ACCNT;
		strTitle = "계정과목집계";
		parameters = "점 - "         + LC_STR_CD.Text
	   				+ ",  집계결의일자 -   "      + strSaleDtFr + "~" + strSaleDtTo
	   				;

		openExcel5(objGrd, strTitle, parameters, true, "",g_strPid );
		
        break;
	}
 
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
  * searchMaster()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-04-20
  * 개    요 : 브랜드별실적 조회
  * return값 : void
  */
  function searchMaster(){
 	 

	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER.ClearData();
	    DS_O_DETAIL.ClearData();
	    
	    old_row=0;
	    
	    if(!chkValidation("search")) return;

	    var strStrCd        = LC_STR_CD.BindColVal;      // 점
	    var strSaleDtS   	= EM_SALE_DT_S.Text; 
	    var strSaleDtE   	= EM_SALE_DT_E.Text;
	    var strDocTitle 	= EM_DOC_TITLE.Text;
	    var strUserPostName	= EM_DEPT_NAME.Text;
	    var strUserEmpNo   	= EM_EMP_SEARCH.Text;
	    var strUserEmpName  = EM_EMP_SEARCH.Text;
	    var strAppGb   		= LC_DEPT_CD.BindColVal;;
	    var strChkExcept	= "0";
	    
	    if (CHK_EXCEPT.checked)
	    	strChkExcept = "1";
	    
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="     		+ encodeURIComponent(strStrCd)
					   + "&strSaleDtS="   		+ encodeURIComponent(strSaleDtS)
					   + "&strSaleDtE="   		+ encodeURIComponent(strSaleDtE)
					   + "&strDocTitle=" 		+ encodeURIComponent(strDocTitle)
					   + "&strUserPostName="	+ encodeURIComponent(strUserPostName)
	                   + "&strUserEmpNo="   	+ encodeURIComponent(strUserEmpNo)
	                   + "&strUserEmpName="   	+ encodeURIComponent(strUserEmpName)
	                   + "&strAppGb="   		+ encodeURIComponent(strAppGb)
	                   + "&strChkExcept="   	+ encodeURIComponent(strChkExcept)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal000.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	    TR_MAIN.Post();

		
	    GD_MASTER.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER.CountRow);

	    //스크롤바 위치 조정
	    GD_MASTER.SETVSCROLLING(0);
	    GD_MASTER.SETHSCROLLING(0);
  }
 
 /**
 * searchDetail()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-04-20
 * 개    요 : 브랜드별실적 조회
 * return값 : void
 */
 function searchDetail(){
	 
	 	DS_O_DETAIL.ClearData();
	 	
	  	if(DS_O_MASTER.CountRow <= 0) return false;
	    
	  	if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"APPGB") == "2") return false; // 반려상태는 조회 안함.
	 	
		//gridCreate2(RD_GROUP.CodeValue);

		//var strSaleFlag  = EM_SALE_FLAG.CodeValue;
	    
	    
		
	    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CO_CD");		//점
	    var nExpendNo  	 = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "EXPENDNO");		//파트
	    	    
	    var goTo       = "searchDetail" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
	                   + "&nExpendNo="  	+ encodeURIComponent(nExpendNo)
	                   ;
     
     TR_DETAIL.Action="/dps/psal000.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     
     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_DETAIL.CountRow);

     //스크롤바 위치 조정
//      GD_DETAIL.SETVSCROLLING(0);
//      GD_DETAIL.SETHSCROLLING(0);
 }
 
 /**
  * searchAccnt()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-04-20
  * 개    요 : 브랜드별실적 조회
  * return값 : void
  */
  function searchAccnt(){
 	 

	    //마스터, 디테일 그리드 클리어
	    DS_O_ACCNT.ClearData();
    
	    if(!chkValidation("search")) return;

	    var strStrCd        = LC_STR_CD.BindColVal;      // 점
	    var strSaleDtS   	= EM_SALE_DT_S.Text; 
	    var strSaleDtE   	= EM_SALE_DT_E.Text;

	    var goTo       = "searchAccnt" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="     		+ encodeURIComponent(strStrCd)
					   + "&strSaleDtS="   		+ encodeURIComponent(strSaleDtS)
					   + "&strSaleDtE="   		+ encodeURIComponent(strSaleDtE)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal000.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_ACCNT=DS_O_ACCNT)"; //조회는 O
	    TR_MAIN.Post();

	    var nLamt = 0;
	    var nRamt = 0;
	    
	    for (var i=1;i<=DS_O_ACCNT.CountRow;i++) {
	    	nLamt =  nLamt + DS_O_ACCNT.NameValue(i,"L_AMT");
		    nRamt =  nRamt + DS_O_ACCNT.NameValue(i,"AMT");
	    }
	    
	    var strTemp = nLamt - nRamt;
	    
	    strTemp = strTemp.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    	GD_ACCNT.ColumnProp("COMP_AMT", "sumtext") = strTemp;
	    
	    GD_ACCNT.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_ACCNT.CountRow);

	    //스크롤바 위치 조정
	    GD_ACCNT.SETVSCROLLING(0);
	    GD_ACCNT.SETHSCROLLING(0);
  }


/**
 * chkValidation(gbn)
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
        
        // 결의일자
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","결의일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","결의일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","결의일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        
     // 결의일자
        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","결의일자"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","결의일자","8");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_E.text)){
        	showMessage(Information, OK, "USER-1004","결의일자");
            EM_SALE_DT_E.focus();
            return false;
        }
        	
        
        break;
   
    }
    return true;
}


/**
 * changeTab()
 * 작 성 자 : jyk
 * 작 성 일 : 2018-02-09
 * 개    요 : 탭 변경시 컴포넌트 처리
 * return값 : void
 */
function changeTab() {
	
	function lf_setCmpnt(tf) {	// local function - 컴포넌트 사용/미사용 설정
		CHK_EXCEPT.disabled 	= tf;
    	CHK_EXCEPT.checked		= tf;
    	EM_DOC_TITLE.enabled	= !tf;
    	EM_DEPT_NAME.enabled	= !tf;
    	EM_EMP_SEARCH.enabled	= !tf;
    	LC_DEPT_CD.enable		= !tf;
    	
    	EM_DOC_TITLE.text		= "";
    	EM_EMP_SEARCH.text		= "";
    	EM_DEPT_NAME.text		= "";
    	LC_DEPT_CD.index		= 0;
	}

	switch(getTabItemSelect("TAB_MAIN")){
    case 1:	// 지출결의내역
    	lf_setCmpnt(false);
        break;
    case 2: // 계정과목집계
    	lf_setCmpnt(true);
        break;
	}
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row >= 0){
    if (row!=old_Row)
	   	searchDetail();
}
old_Row = row;
return;
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
    var varbfYear= now.getYear()-1; //전년도
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
    var	varBf_Year_Mon = varbfYear.toString()+ mon;
</script>

<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT_S.text = varToMon+"01";
        return false;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT_S.text = varToMon+"01";
        return false;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT_S.text = varToMon+"01";
        return false;
    }
return true;
</script>

<!-- 매출종료일 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","종료일자"); 
        EM_SALE_DT_E.text = varToday;
        return false;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","종료일자","8");
        EM_SALE_DT_E.text = varToday;
        return false;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","종료일자");
        EM_SALE_DT_E.text = varToday;
        return false;
    }
return true;
</script>

<!-- 브랜드코드 변경시 -->   
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
	if (EM_PUMBUN_CD.Text == "") EM_DOC_TITLE.Text = "";
	//var strTeamCd = "";
	//var strPcCd   = "";
	/*
	if(LC_TEAM_CD.BindColVal == "%"){
		strTeamCd = "00";
	}
	else{
		strTeamCd = LC_TEAM_CD.BindColVal;
	}
	if(LC_PC_CD.BindColVal == "%"){
		strPcCd = "00";
	}
	else{
		strPcCd = LC_PC_CD.BindColVal;
	}
	
	var strOrgCd = LC_STR_CD.bindcolval + LC_DEPT_CD.BindColVal + strTeamCd + strPcCd + "00";
	*/
	if(EM_PUMBUN_CD.text.length != 0){    
	    setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", EM_PUMBUN_CD, EM_DOC_TITLE, 'Y', '1','',LC_STR_CD.bindcolval);
	}
	
</script>

<script language=JavaScript for=RD_GROUP event=OnClick()>
	//searchDetail();
</script>

<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>

	var strDocId  	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DOCID");
	var strDocTitle = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DOCTITLE");
	var arrArg    = new Array(strDocId,strDocTitle);
	
 	//alert("arrArg = " + arrArg);
	
	
	var returnVal = window.showModalDialog("/dps/jsp/psal/psal0001.jsp?"
			                              , arrArg
			                              , "dialogWidth:800px;dialogHeight:300px;scroll:no;");

	return;
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
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_ACCNT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_0_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CMPRDT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
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
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    obj   = document.getElementById("GD_ACCNT");

    obj.style.height  = grd_height+480 + "px";
}
</script>

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
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">결재진행상태</th>
                  <td width="180" ><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                     <input type="checkbox" id="CHK_EXCEPT" checked> 반려제외
                  </td>
                  <th width="80">문서제목</th>
	               <td colspan="2"><comment id="_NSID_"> <object
	                   id=EM_DOC_TITLE classid=<%=Util.CLSID_EMEDIT%> width=500
	                   align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
	               </td>
                  
               </tr>
               <tr>
                  
                  <th width="60px" class="point">결의일자</th>
                  <td width="210px"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT_S);" align="absmiddle" />~
					<comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT_E);" align="absmiddle" />
                  </td>
                  <th>부서명</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_DEPT_NAME classid=<%=Util.CLSID_EMEDIT%> width=150
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  </td>
                   <th>사번or사원명</th>
					<td style="border-right:0px" colspan="2">
						<comment id="_NSID_"> <object
                     		id=EM_EMP_SEARCH classid=<%=Util.CLSID_EMEDIT%> width=150
                     		tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>   
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
   	  <td>
   	  <div id=TAB_MAIN  width="100%" height=800 TitleWidth=100  TitleAlign="center" onclick="changeTab();">
		<menu TitleName="지출결의내역"       DivId="tab_page1" Enable='true' />
		<menu TitleName="계정과목집계"       DivId="tab_page2" Enable='true' />
	 </div>
   	  </td>
   </tr>
   <tr>
   	<td>
   		<!--  tab_page1 -->
   		<div id="tab_page1">
   		<table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
      <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=450 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>

   <tr valign="top" class="PT10">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th width="100px">지결상세</th>
						<td style="border-right:0px">
							<font color=red> ㅿㅿ 상단 지출결의 내역 더블 클릭시 결재선을 확일 할 수 있습니다.</font>    
						</td>  
					</tr>
				</table>
			</td>
		</tr>
         <tr >
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL width=100% height=222 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_DETAIL">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
   	</table>
   	</div>
   	<!--  tab_page2 -->
   		<div id="tab_page2">
   		<table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
      <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_ACCNT width=100% height=750 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_ACCNT">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
   	</table>
   	</div>
   	</td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
