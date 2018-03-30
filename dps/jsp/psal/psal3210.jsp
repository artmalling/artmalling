<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal3210.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출속보현황(조직별)
 * 이    력 :2010.04.08 박종은
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
	SessionInfo sessionInfo = (SessionInfo) session
			.getAttribute("sessionInfo");
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
	 var top = 150;		//해당화면의 동적그리드top위치
	var strOrgFlag = "1";//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';

	function doInit() {
		
		//Master 그리드 세로크기자동조정  2013-07-17
		var obj   = document.getElementById("GD_MASTER"); 
		obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


		// Input Data Set Header 초기화

		// Output Data Set Header 초기화
		DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
		
		//그리드 초기화
		gridCreate1(); //마스터
		
		// EMedit에 초기화

		initEmEdit(EM_SALE_DT_S, "YYYYMMDD", PK); //매출연도
		initEmEdit(EM_SALE_DT_E, "YYYYMMDD", PK); //매출연도
		EM_SALE_DT_S.alignment = 1;

		
		

		

		
		

		//콤보 초기화
		//initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK); //점(조회)

		//팀
		//initComboStyle(LC_DEPT_CD, DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //팀(조회)

		//파트
		//initComboStyle(LC_TEAM_CD, DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //파트(조회)

		//PC
		//initComboStyle(LC_PC_CD, DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //PC(조회)
		initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL); //점(조회)
		var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드   
		//var strOrgFlag = EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    

		//getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag); //점   
		//getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag); //점   
		//getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag); // 팀    
		//getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal,
				//LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); // 파트    
		//getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal,
				//LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC    
		getEtcCode("DS_UNIT"    ,"D"   ,"P622"  ,"N" );         
		//LC_STR_CD.BindColVal = strcd;
		//LC_DEPT_CD.Index = 0;
		//LC_TEAM_CD.Index = 0;
		//LC_PC_CD.Index = 0;
		EM_UNIT.Index = 1;
		var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';

		EM_SALE_DT_S.text = varToday; //매출일자 시작 당일 
		EM_SALE_DT_E.text = varToday; //매출일자 시작 당일
		
		GD_MASTER.focus();
		//LC_STR_CD.Focus();
		//사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
		registerUsingDataset("psal321", "DS_O_MASTER");

	}

	function gridCreate1() {

			var	hdrProperies = ''
				 + '<C>id=TITLE					name="구분"				width=100	align=left		suppress=1		</FC>'
				 + '<C>id=PUMBUN_CD   			name="브랜드코드"			width=80	align=left		BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</FC>'
				 + '<C>id=PUMBUN_NAME   		name="브랜드명"			width=150	align=left		SumText="합계"	BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</FC>'
				 + '<C>id=TOT_SALE_AMT			name="매출합계"			width=110	align=right		mask="#,###"	SumText={(sum(TOT_SALE_AMT)/2)}	BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 + '<C>id=DAY_AVG				name="일평균매출"			width=110	align=right		mask="#,###"	SumText={(sum(DAY_AVG)/2)} BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 + '<C>id=WEEK					name="주중일수"			width=70	align=right		mask="#,###"	SumText={(sum(WEEK)/2)} BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 + '<C>id=WEEK_AVG				name="주중일평균"			width=110	align=right		mask="#,###"	SumText={(sum(WEEK_AVG)/2)}	BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 + '<C>id=WEEKEND				name="주말일수"			width=70	align=right		mask="#,###"	SumText={(sum(WEEKEND)/2)}	BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 + '<C>id=WEEKEND_AVG			name="주말일평균"			width=110	align=right		mask="#,###"	SumText={(sum(WEEKEND_AVG)/2)}	BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 + '<C>id=MON_EXP				name="월예상매출액"		width=110	align=right		mask="#,###"	SumText={(sum(MON_EXP)/2)}	BgColor={decode(PUMBUN_NAME,"소계","#FFF7B1","#FFFFFF")}</C>'
				 
				 ;

			initGridStyle(GD_MASTER, "common", hdrProperies, false);
			//합계표시
			GD_MASTER.ViewSummary =	"1";   // view단 합계 
			GD_MASTER.DecRealData =	true;

			

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
		 search1();
		 //fn_sum();
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

		if (DS_O_MASTER.CountRow <= 0) {
			showMessage(INFORMATION, OK, "USER-1000",
					"다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
			return;
		}
		var strTitle = "F&B매출실적";

		//var strStrCd = LC_STR_CD.Text; //점
		//var strDeptCd = LC_DEPT_CD.Text; //팀
		//var strTeamCd = LC_TEAM_CD.Text; //파트
		//var strPCCd = LC_PC_CD.Text; //PC
		var strSaleDtS = EM_SALE_DT_S.text; //매출일자
		var strSaleDtS = EM_SALE_DT_E.text; //매출일자
		
		

		var parameters = "매출일자 : " + strSaleDtS + " ~ " + strSaleDtS + " , " + " 단위 : " + EM_UNIT.TEXT;

		GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
		openExcel2(GD_MASTER, strTitle,	parameters,	true );
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
	function search1(){
		//마스터, 디테일 그리드 클리어
		DS_O_MASTER.ClearData();

		
		//var strStrCd = LC_STR_CD.BindColVal; //점
		//var strDeptCd = LC_DEPT_CD.BindColVal; //팀
		//var strTeamCd = LC_TEAM_CD.BindColVal; //파트
		//var strPCCd = LC_PC_CD.BindColVal; //PC
		var SALE_DT_S = EM_SALE_DT_S.text; //시작년월
		var SALE_DT_E = EM_SALE_DT_E.text; //시작년월
		//    var strCuLv         = LC_CU_LV.BindVal;         //금액단위 
		
		var strEmUnit   = EM_UNIT.BindColVal;

		var goTo = "searchMaster";
		var action = "O";
		var parameters = "&SALE_DT_S="  + encodeURIComponent(SALE_DT_S)
					+ "&SALE_DT_E="     + encodeURIComponent(SALE_DT_E)
					+ "&strEmUnit="     + encodeURIComponent(strEmUnit)

		TR_MAIN.Action = "/dps/psal321.ps?goTo=" + goTo + parameters;
		TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
		TR_MAIN.Post();

		GD_MASTER.focus();
		// 조회결과 Return
		setPorcCount("SELECT", DS_O_MASTER.CountRow);

	}
	
	/**
	 * chkSave()
	 * 작 성 자 : 박종은
	 * 작 성 일 : 2010-03-14
	 * 개    요 :  저장
	 * return값 : void
	 */
	

	
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
	for (i = 0; i < TR_MAIN.SrvErrCount('UserMsg'); i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',
				i));
	}
</script>
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
	for (i = 0; i < TR_MAIN2.SrvErrCount('UserMsg'); i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',
				i));
	}
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN2 event=onFail>
	trFailed(TR_MAIN2.ErrorMsg);
</script>
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
	for (i = 0; i < TR_DETAIL.SrvErrCount('UserMsg'); i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg(
				'UserMsg', i));
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
	sortColId(eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	
</script>

<script language="javascript">
	var today = new Date();
	var old_Row = 0;
	var searchChk = "";

	// 오늘 일자 셋팅 
	var now = new Date();
	var mon = now.getMonth() + 1;
	if (mon < 10)
		mon = "0" + mon;
	var day = now.getDate();
	if (day < 10)
		day = "0" + day;
	var varToday = now.getYear().toString() + mon + day;
	var varToMon = now.getYear().toString() + mon;
</script>
<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_ORG_FLAG event=OnSelChange()>
	if (EM_ORG_FLAG.CodeValue == "1") {

		
		var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드
		//getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag); //점		
		getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag); //점		
		getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag); // 팀		
		getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal,
				LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); // 파트		
		getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal,
				LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC	   	 

		LC_STR_CD.BindColVal = strcd;
		LC_DEPT_CD.Index = 0;
		LC_TEAM_CD.Index = 0;
		LC_PC_CD.Index = 0;

	} else if (EM_ORG_FLAG.CodeValue == "2") {

		
		var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드
		//getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag); //점		
		getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag); //점		
		getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag); // 팀		
		getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal,
				LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); // 파트		
		getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal,
				LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC  

		LC_STR_CD.BindColVal = strcd;
		LC_DEPT_CD.Index = 0;
		LC_TEAM_CD.Index = 0;
		LC_PC_CD.Index = 0;

	}
</script>


	
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	

	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag); // 팀 
	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal,
			"Y", "", strOrgFlag); // 파트    
	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal,
			LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC 
	LC_DEPT_CD.Index = 0;
	LC_TEAM_CD.Index = 0;
	LC_PC_CD.Index = 0;
</script>



<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
	

	if (LC_DEPT_CD.BindColVal != "%") {
		getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal,
				LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); // 파트   
	} else {
		DS_TEAM_CD.ClearData();
		insComboData(LC_TEAM_CD, "%", "전체", 1);
		DS_PC_CD.ClearData();
		insComboData(LC_PC_CD, "%", "전체", 1);
	}
	LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
	

	if (LC_TEAM_CD.BindColVal != "%") {
		getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal,
				LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC   
	} else {
		DS_PC_CD.ClearData();
		insComboData(LC_PC_CD, "%", "전체", 1);
	}
	LC_PC_CD.Index = 0;
</script>


<!-- 마스터 그리드 컬럼 변경시 저장 체크 처리 -->
<script language=Javascript for=GD_MASTER
	event=OnColumnPosChanged(Row,Colid)>
	
</script>

<script language="javascript" for=GD_MASTER
	event=OnUserColor(Row,eventid)>
	
</script>

<script language=JavaScript for=DS_O_MASTER
	event=onColumnChanged(Row,Colid)>
	old_Row = Row

	// 이 Event에서 SetColumn을 사용하는 것은 의미가 없다. Changed를 수행한 후 SetColumn이 자동으로 수행되기 때문이다.
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
<comment id="_NSID_"> <object id="DS_STR_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_DEPT_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_TEAM_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="DS_PC_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="DS_O_PC"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="DS_O_PUMBUN_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="DS_I_COMMON"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_O_RESULT"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_I_CONDITION"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_UNIT"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"> <object id="DS_O_MASTER"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>




<comment id="_NSID_"> <object id="DS_0_PC"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="DS_O_STR_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_O_DEPT_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_O_TEAM_CD"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="DS_O_CMPRDT"
	classid=<%=Util.CLSID_DATASET%>></object> </comment>
<script>
	_ws_(_NSID_);
</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"> <object id="TR_MAIN"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="TR_MAIN2"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="TR_DETAIL"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>
	_ws_(_NSID_);
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
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
										<th class="point" width="70">매출일자</th>
										<td colspan="3"><comment id="_NSID_"> <object
												id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_S)"
											align="absmiddle" />~ <comment id="_NSID_"> <object
												id="EM_SALE_DT_E" classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_E)"
											align="absmiddle" /></td>
										<th  width="70"  >단위</th>
										<td width="105"><comment id="_NSID_"> <object
												id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95
												tabindex=1 align="absmiddle"> </object> </comment>
											<script>
												_ws_(_NSID_);
											</script>
										</td>
										<TD WIDTH="500"></TD>
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
										<td width="100%" id=td_old ><comment id="_NSID_"> <object
												id=GD_MASTER width=100% height=500
												classid=<%=Util.CLSID_GRID%> tabindex=1>
												<param name="DataID" value="DS_O_MASTER">
												<Param Name="IndicatorInfo"
													value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
												<Param Name="sort" value="false">
											</object> </comment>
											<script>
												_ws_(_NSID_);
											</script>
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
