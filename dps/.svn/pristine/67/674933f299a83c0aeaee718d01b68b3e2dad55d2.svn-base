<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > 월별대행업체 지불대상액 조회
 * 작 성 일  : 2012.07.05
 * 작 성 자  : 홍종영
 * 수 정 자  : 
 * 파 일 명  : psal5550.jsp
 * 버    전   : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요   : 
 * 이    력   : 2012.07.05 홍종영
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                               							*-->
<!--*************************************************************************-->
<loginChk:islogin />
<% String dir = BaseProperty.get("context.common.dir"); %>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        								*-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 var	strToday = getTodayFormat("yyyymm");
 var	strSDate = addDate('M',	-1,	strToday);
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
 var top = 100;		//해당화면의 동적그리드top위치
 
 var CyyyyCmmCdd;		//기준년기준월기준일
 var CyyyyCmm01;		//기준년기준월01일
 var Cyyyy0101;			//기준년01월01일
 var CyyyyPmm01;		//기준년전월01일
 var CyyyyPmm31;		//기준년전월31일
 var PyyyyCmm01;		//전년기준월01일
 var PyyyyCmmCdd;		//전년기준월기준일
 var Pyyyy0101;			//전년01월01일
 var PyyyyCmm31;		//전년기준월31일
 var PyyyyPmm31;		//전년전월31일
 var Cyyyy01;			//기준년01월
 var CyyyyPmm;			//기준년전월
 var PPyyyy;			// 전전년
 var PPyyyy1;			// 전전년
 
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');      
        
    
    
        
    // EMedit에 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);    
    
    
	initEmEdit(EM_S_DT, "SYYYYMMDD", PK);										//기간FROM(조회)
	 
	
	//단위
	initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL); 
	getEtcCode("DS_UNIT"    ,"D"   ,"P622"  ,"N" ); 																	// 단위
    //콤보 초기화
    getStore("DS_STR_CD", "Y", "", "N");                                        // 점        

    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';         // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    EM_UNIT.Index 	 = 0;
    EM_S_DT.alignment = 1;
    
    EM_S_DT.TEXT = varToday; 
    //EM_S_DT.TEXT = '20150130';
     
    Set_date(varToday);
    
  	//그리드 초기화
    gridCreate1(); //마스터
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal555","DS_O_MASTER" );
    
}

function gridCreate1(){
	
    var hdrProperies = '<C>id="COMM_NAME2"				name="구분"				width=100	align=center	suppress=1	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="COMM_NAME1"				name="P/C"				SubSumText="소계"		width=150	align=center	suppress=2	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<G> name='+CyyyyCmmCdd.substring(0,4)+'년'+CyyyyCmmCdd.substring(4,6)+'월'
					 + '<C>id="SALE_AMT"				name="당일매출"			width=120	sumtext={subsum(SALE_AMT)/UNIT}			align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(SALE_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="ACT_AMT"					name="목표"				width=120	sumtext={subsum(ACT_AMT)/UNIT}			align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(ACT_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="ACC_SALE_AMT"			name="실적"				width=120	sumtext={subsum(ACC_SALE_AMT)/UNIT}		align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(ACC_SALE_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="ACHI_RATE"				name="달성율"			width=120		align=RIGHT	gte_columntype="number:1:true" gte_Summarytype="number:1:true"	value= {ACHI_RATE}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="P_SALE_AMT"				name="전년실적;("'+CyyyyCmmCdd.substring(4,6)+'-01~'+CyyyyCmmCdd.substring(4,6)+'-'+CyyyyCmmCdd.substring(6,8)+')'			
						+	'	height=90		width=120	sumtext={subsum(P_SALE_AMT)/UNIT}	align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(P_SALE_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="EXP_RATE"				name="신장율"			width=120	sumtext={subsum(ORIGIN_NORM_SAMT)}		align=RIGHT	gte_columntype="number:1:true" gte_Summarytype="number:1:true"	value= {EXP_RATE}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '</G> '
					 + '<G> name='+Cyyyy01.substring(0,4)+'년1~'+CyyyyPmm.substring(4,6)+'월누계'
					 + '<C>id="P_ACT_AMT"				name="목표"				width=120	sumtext={subsum(P_ACT_AMT)/UNIT}		align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(P_ACT_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="P_ACC_SALE_AMT"			name="실적"				width=120	sumtext={subsum(P_ACC_SALE_AMT)/UNIT}	align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(P_ACC_SALE_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="P_ACHI_RATE"				name="달성율"			width=120											align=RIGHT	gte_columntype="number:1:true" gte_Summarytype="number:1:true"	value= {P_ACHI_RATE}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="P_PRE_ACC_AMT"			name="전년실적"			width=120	sumtext={subsum(P_PRE_ACC_AMT)/UNIT}	align=RIGHT	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value= {round(P_PRE_ACC_AMT/UNIT)}	SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '<C>id="P_EXP_RATE"				name="신장율"	 		width=120											align=RIGHT	gte_columntype="number:1:true" gte_Summarytype="number:1:true"	value= {P_EXP_RATE}		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
					 + '</G> '
					 ;
	
	
	
	GD_MASTER.ViewSummary = "1";   // view단 합계
	GD_MASTER.DecRealData = true;					 
					 
    initGridStyle(GD_MASTER, "common", hdrProperies, false);    
    
    GD_MASTER.TitleHeight="30";
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
    
    //마스터 그리드 클리어
    DS_O_MASTER.ClearData();
        
    var strStrCd		= LC_STR_CD.BindColVal;		//점
    var strS_dt			= EM_S_DT.text;				//시작일자
    
    
    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
    
    
    
    
    Set_date(strS_dt);
    
    gridCreate1();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="	+encodeURIComponent(strStrCd)
                   + "&CyyyyCmmCdd="+encodeURIComponent(CyyyyCmmCdd)
                   + "&CyyyyCmm01="	+encodeURIComponent(CyyyyCmm01)
                   + "&Cyyyy0101="	+encodeURIComponent(Cyyyy0101)
                   + "&CyyyyPmm01="	+encodeURIComponent(CyyyyPmm01)
                   + "&CyyyyPmm31="	+encodeURIComponent(CyyyyPmm31)
                   + "&PyyyyCmm01="	+encodeURIComponent(PyyyyCmm01)
                   + "&PyyyyCmmCdd="+encodeURIComponent(PyyyyCmmCdd)
                   + "&Pyyyy0101="  +encodeURIComponent(Pyyyy0101)
                   + "&PyyyyCmm31=" +encodeURIComponent(PyyyyCmm31)
                   + "&PyyyyPmm31=" +encodeURIComponent(PyyyyPmm31)
                   + "&Cyyyy01="	+encodeURIComponent(Cyyyy01)
                   + "&CyyyyPmm="	+encodeURIComponent(CyyyyPmm)
                   + "&PPyyyy="		+encodeURIComponent(PPyyyy)
                   + "&PPyyyy1="	+encodeURIComponent(PPyyyy1)
                   + "&strEmUnit="	+encodeURIComponent(strEmUnit)
                   ;
    
    
    //alert(parameters);
    //return;
    
    TR_MAIN.Action="/dps/psal555.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 건수 조회
    setPorcCount("SELECT" ,DS_O_MASTER.CountRow );
    
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
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
	var strTitle = "부물별 온라인 매출실적";

    var strStrCd        = LC_STR_CD.Text;      //점
    var strSaleDtS      = EM_S_DT.text;         //시작일자
    
   
    var parameters = "점 "           + strStrCd
                   + " ,   매출일자 "  + strSaleDtS;
    if(DS_O_MASTER.CountRow <= 0){
	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	        return;
	    }
	    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER, strTitle, parameters, true );
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
 * setCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 필수 공통코드/명을 등록한다.
 * return값 : void
 */

function setInitCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : 'SEL_COMM_CODE_ONLY';
    if( evnflag == "POP" ){
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
        return;
    }
    
    setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
}



/**
 *	searchPumbunPop()
 *	작 성	자 :	홍종영
 *	작 성	일 :	2010-03-18
 *	개	 요 :  조회조건 브랜드팝업
 *	return값	: void
 */
 
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     								*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 								*-->
<!--*    1. TR Success 메세지 처리			                 					*-->
<!--*    2. TR Fail 메세지 처리                 										*-->
<!--*    3. DataSet Success 메세지 처리                 								*-->
<!--*    4. DataSet Fail 메세지 처리                 									*-->
<!--*    5. DataSet 이벤트 처리                 										*-->
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
    //sortColId( eval(this.DataID), row , colid); 
</script>

<script language="javascript">
	var today    = new Date();
	var old_Row = 0;
	var searchChk = "";

	// 오늘 일자 셋팅
	var now = new Date();
	var mon = now.getMonth()+1;
	
	var year = now.getYear();
	var p_year = now.getYear()-1;
	
	var p_mon = now.getMonth();
	
	if(mon < 10)mon = "0" + mon;
	var day = now.getDate();
	if(day < 10)day = "0" + day;
	var varToday = now.getYear().toString()+ mon + day;
	var varToMon = now.getYear().toString()+ mon;
	
	//now		//오늘
	//mon		//20150301
	
	
	
</script>

<script type="text/javascript"> 


function Set_date(yyyymmdd) {
	
	
	
	//var date = "2015-03-19"; // 기준일
	var date = yyyymmdd.substring(0,4)+"-"+yyyymmdd.substring(4,6)+"-"+yyyymmdd.substring(6,8);
	var arrDate = date.split('-'); 
	var date_y=(arrDate[0]); 
	var date_m=(arrDate[1]);
	var date_d=(arrDate[2]);
	var mon;
	var day;
	
		
	mon = date_m;
	day = date_d;	
	
	
	var cur_date = date_y.toString()+mon+day;
	CyyyyCmmCdd =cur_date;		// 기준년월일
	
	var cur_date_01 = date_y.toString()+mon+"01";
	CyyyyCmm01 = cur_date_01;		// 기준년월01일
	
	Cyyyy0101 = date_y.toString()+"0101";	// 기준년0101
	
	for(var i=1;i<=1;i++) 
	{ 
	   if(date_m>1){date_m--;}else{date_y--; date_m=12;} 
	   if(date_m<10){ tmp_month = "0"+date_m; }else{ tmp_month = date_m; } 
	} 
	
	if(date_m < 10) {
		date_m = "0" + date_m;
	} else {
		date_m = date_m;
	}
		
	CyyyyPmm01 = date_y.toString()+date_m+"01";	// 기준년전달01
	CyyyyPmm31 = date_y.toString()+date_m+"31";	// 기준년전달31
	
	PyyyyPmm31 = date_m.toString()+"31";		// 전년전월31
	
	for(var i=1;i<=11;i++) 
	{ 
	   if(date_m>1){date_m--;}else{date_y--; date_m=12;} 
	   if(date_m<10){ tmp_month = "0"+date_m; }else{ tmp_month = date_m; } 
	} 
	
	PyyyyCmm01 = date_y.toString()+tmp_month+"01";		// 전년월01일
	PyyyyCmmCdd = date_y.toString()+tmp_month+day;		// 전년월일
	
	Pyyyy0101 = date_y.toString()+"0101";		// 전년0101일
	
	PPyyyy = Pyyyy0101.substring(0,4);		// 전전년
	PPyyyy1 = PPyyyy -1;
	
	if(date_m < 10) {
		date_m = "0" + date_m;
	} else {
		date_m = date_m;
	}
	
	PyyyyCmm31 = date_y.toString()+date_m.toString()+"31";		// 전년당월31
	PyyyyPmm31 = date_y.toString()+PyyyyPmm31;					// 전년전월31
	
	Cyyyy01 = CyyyyPmm31.substring(0,4)+"01";
	CyyyyPmm = CyyyyPmm31.substring(0,6);
	
	//ADD_MONTH
}
	

</script> 

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               							*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                 					*-->
<!--*    1. DataSet                                 						*-->
<!--*    2. Transaction                                 					*-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<!-- 검색용 -->

<comment id="_NSID_"> 
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_UNIT"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_SEARCH_NM"	classid=<%= Util.CLSID_DATASET %>></object> 
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"> 
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"> 
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object> 
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"> 
	<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
		<param name="KeyName" value="Toinb_dataid4">
	</object> 
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               					*-->
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
<!--* E. 본문시작                                                          								*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

	<!--공통 타이틀/버튼 -->
	<%@ include file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 // -->

	<div id="testdiv" class="testdiv">

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="PT01 PB03">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
						<tr>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
									<tr>
										<th width="70" class="point">점</th>
										<td width="160">
											<comment id="_NSID_"> 
												<object	id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=170 tabindex=1 align="absmiddle"></object> 
											</comment><script>_ws_(_NSID_);</script>
										</td>
										<th width="70" class="point">매출일자</th>
										<td>
											<comment id="_NSID_"> 
												<object	id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
											</comment><script>_ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" />
										<td>
									<comment id="_NSID_"> 
										<object	id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	tabindex=1 align="absmiddle"> </object> 
									</comment>
									<script>_ws_(_NSID_);</script>
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
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr valign="top">
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td width="100%"><comment id="_NSID_"> <object
												id=GD_MASTER width=100% height=480
												classid=<%=Util.CLSID_GRID%> tabindex=1>
												<param name="DataID" value="DS_O_MASTER">
											</object> </comment>
											<script>_ws_(_NSID_);</script>
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

	</div>
<body>
</html>
