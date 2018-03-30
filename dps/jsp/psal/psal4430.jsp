<!-- 
/*******************************************************************************
 * 시스템명	: 영업관리 > 매출관리 >	매출실적 > 층별/상품별 매출현황
 * 작 성 일	: 2010.07.28
 * 작 성 자	: 정진영
 * 수 정 자	: 홍종영
 * 파 일 명	: psal4430.jsp
 * 버	 전	: 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 
 * 이	 력	: 2010.07.28 (정진영) 신규작성 
 *		   2012.07.18 홍종영 ChartFX ->	ShiftChart 교체
 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"	  %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@	taglib uri="/WEB-INF/tld/c-rt.tld"		prefix="c" %>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld"	prefix="gauce" %>  
<%@	taglib uri="/WEB-INF/tld/app.tld"		prefix="loginChk" %>
<%@	taglib uri="/WEB-INF/tld/button.tld"	prefix="button"	%>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정													*-->
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
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript"  src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/message.js"	type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>
<script	language="javascript"  src="/<%=dir%>/js/shiftchart.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작															*-->
<!--*************************************************************************-->


<script	LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
// 엑셀	다운로드를 위한	전역 변수

/**
 * doInit()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 해당 페이지 LOAD 시  
 * return값	: void
 */
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	// Output Data Set Header 초기화
	DS_FLOOR.setDataHeader('<gauce:dataset name="H_SEL_FLOOR"/>');
	DS_PTYPE.setDataHeader('<gauce:dataset name="H_SEL_P_TYPE"/>');
	
	//그리드 초기화
	gridCreate1(); //마스터
	gridCreate2(); //마스터

	// EMedit에	초기화
	initEmEdit(EM_FROM_DT	, "TODAY"	, PK);	//기간 FROM
	initEmEdit(EM_TO_DT		, "TODAY"	, PK);	//기간 TO
	
	//콤보 초기화 
	initComboStyle(LC_STR_CD, DS_STR_CD	, "CODE^0^30,NAME^0^140",	1, PK);		//점(조회)
	//점코드 조회
	getStore("DS_STR_CD"  ,	"Y", "", "N");
    /* initComboStyle(LC_HALL_CD,DS_HALL_CD,	"CODE^0^30,NAME^0^140", 1, PK);		//관 (조회)
    시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_HALL_CD","D", "P197", "Y" ,"N");
    LC_HALL_CD.Index = 0; */
	
	//콤보데이터 기본값	설정( gauce.js )
	setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />');	//로그인 사용자 점 코드를 기본값으로 설정
	if(	LC_STR_CD.Index	< 0){
		LC_STR_CD.Index= 0;
	}

	LC_STR_CD.Focus();	
	
	//기본설정
// 	StartAdd1();		// 처음 보이는 화면에 기본 타입을 보여주기 위해 설정
// 	StartAdd2();		// 처음 보이는 화면에 기본 타입을 보여주기 위해 설정
}

function gridCreate1(){
	var	hdrProperies = '<FC>id={currow}			width=30	align=center	    name="NO"	 show=false </FC>'
					 /* + '<FC>id=HALL_FLOOR_NM	width=75	align=left		    name="관층"	 SubSumText=""	</FC>'				 
					 + '<FC>id=HALL_NAME		width=55	align=left		    suppress=1	 SubSumText="" name="관" SubSumText={decode(CurLevel,1,"관별소계","")} SubBgColor={decode(CurLevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")} 	</FC>' */	
					 + '<FC>id=FLOOR_NAME		width=55	align=left		    name="층"	 SubSumText=""	</FC>'
					 + '<FC>id=NORM_SALE_AMT	width=110	align=right			name="매출"	 sumtext={subsum(NORM_SALE_AMT)} 	</FC>'//SubBgColor={decode(HALL_CD,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	
					 + '<FC>id=CUST_CNT			width=80	align=right			name="객수"	 sumtext={subsum(CUST_CNT)} 	</FC>'
					 + '<FC>id=COMP_RATE		width=100	align=right			name="매출구성비"	 sumtext={subsum(COMP_RATE)} </FC>'
					 + '<FC>id=SALE_PROF_AMT	width=100	align=right			name="이익액"	 sumtext={subsum(SALE_PROF_AMT)} </FC>'
					 + '<FC>id=PURE_AMT			width=100	align=right			name="공급가"	 sumtext={subsum(PURE_AMT)}  </FC>'					 
					 + '<FC>id=PROF_RATE		width=100	align=right			name="이익율"	 sumtext={(subsum(SALE_PROF_AMT)/subsum(PURE_AMT))*100} </FC>'					 
					 + '<FC> id=level			name=레벨       Value={CurLevel}  show=false </FC>'
					 ;
	initGridStyle(GD_FLOOR,	"common", hdrProperies,	false);
	
	GD_FLOOR.ViewSummary = "1";	 
	GD_FLOOR.ColumnProp("FLOOR_NAME", "sumtext")		= "합계";
	//DS_FLOOR.SubSumExpr  = "1:HALL_NAME" ; 
	//GD_FLOOR.ColumnProp("HALL_NAME",   "sumtext")        = "소계";
}



function gridCreate2(){
	var	hdrProperies = '<FC>id={currow}			width=30	align=center	sumtext=""		name="NO"	show=false </FC>'
					 + '<FC>id=PTYPE_NAME		width=100	align=left		sumtext=""		name="상품유형"	</FC>'
					 + '<C>id=TOTAL_SALE_AMT	width=100	align=right		sumtext=@sum	name="매출"		</C>'
					 + '<C>id=CUST_CNT			width=100	align=right		sumtext=@sum	name="객수"		</C>'
					 + '<C>id=CUST_SALE_AMT		width=95	align=right		sumtext=@sum	name="객단가"		</C>'
					 + '<C>id=COMP_RATE			width=95	align=right		sumtext=@sum	name="백분률"		show=false</C>';
	initGridStyle(GD_PTYPE,	"common", hdrProperies,	false);
	
	GD_PTYPE.ViewSummary = "1";	 
	GD_PTYPE.ColumnProp("PTYPE_NAME", "sumtext")		= "합계";
}

/*************************************************************************
  *	2. 공통버튼
	 (1) 조회		- btn_Search(),	subQuery()
	 (2) 신규		- btn_New()
	 (3) 삭제		- btn_Delete()
	 (4) 저장		- btn_Save()
	 (5) 엑셀		- btn_Excel()
	 (6) 출력		- btn_Print()
	 (7) 확정		- btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 조회시 호출
 * return값	: void
 */
function btn_Search() {

	if(	LC_STR_CD.BindColVal ==	""){
		showMessage(EXCLAMATION, OK, "USER-1002", "점");
		LC_STR_CD.Focus();
		return;
	}

	if(	EM_FROM_DT.Text	== ""){
		showMessage(EXCLAMATION, OK, "USER-1003", "기간(From)");
		EM_FROM_DT.Focus();
		return;
	}
	if(	EM_TO_DT.Text == ""){
		showMessage(EXCLAMATION, OK, "USER-1003", "기간(To)");
		EM_TO_DT.Focus();
		return;
	}

	if(	EM_TO_DT.Text <	EM_FROM_DT.Text){
		showMessage(EXCLAMATION, OK, "USER-1020", "기간(To)", "기간(From)");
		EM_TO_DT.Focus();
		return;
	}
	
	DS_FLOOR.ClearData();
	DS_PTYPE.ClearData();

	var	strStrCd	= LC_STR_CD.BindColVal;
	var	strFromDt	= EM_FROM_DT.Text;
	var	strToDt		= EM_TO_DT.Text;
  //var	strHallCd	= LC_HALL_CD.BindColVal;
	
	// 엑셀	다운을 위한	조회조건 저장
	//setSearchValue2Excel();
	
	var	goTo	   = "searchMaster"	;	 
	var	action	   = "O";	  
	var	parameters = "&strStrCd="	+	encodeURIComponent(strStrCd)
				   + "&strFromDt="	+	encodeURIComponent(strFromDt)
				   + "&strToDt="	+	encodeURIComponent(strToDt);
				   //+ "&strHallCd="	+	encodeURIComponent(strHallCd);
	TR_MAIN.Action="/dps/psal443.ps?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_FLOOR=DS_FLOOR,"+action+":DS_PTYPE=DS_PTYPE)"; //조회는	O
	TR_MAIN.Post();

	//setTimeout( "viewChart( 'CHART_001', '1',	'FLOOR_NAME', 'TOTAL_SALE_AMT',	DS_FLOOR, GD_FLOOR,	'층별매출');",0);
	//setTimeout( "viewChart( 'CHART_002', '1',	'PTYPE_NAME', 'TOTAL_SALE_AMT',	DS_PTYPE, GD_PTYPE,	'상품별매출');",50);
	//조회후 결과표시
	setPorcCount("SELECT",(DS_FLOOR.CountRow + DS_PTYPE.CountRow) );
	
	
// 	Start1();
// 	Start2();
	GD_FLOOR.Focus();
}

/**
 * btn_New()
 * 작 성 자	: shryu
 * 작 성 일	: 2006-06-20
 * 개	 요	: Grid 레코드 추가
 * return값	: void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: Grid 레코드 삭제
 * return값	: void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: DB에 저장	/ 수정 / 삭제 처리
 * return값	: void
 */
function btn_Save()	{
	 
}

/**
 * btn_Excel()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 엑셀로 다운로드
 * return값	: void
 */
function btn_Excel() {
	 
    if(DS_FLOOR.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }

		var	strStrCd	= LC_STR_CD.text;
		var	strFromDt	= EM_FROM_DT.Text;
		var	strToDt		= EM_TO_DT.Text;
		//var	strHallCd	= LC_HALL_CD.text;
  	      
      var parameters = "점 "         + strStrCd
			        + " ,   기간 " 	+ strFromDt 
			        + " ~ " + strToDt
			       // + "     관 "   + strHallCd
			        ;

      var strTitle = "층별매출현황(층별)";

      GD_FLOOR.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
      //openExcel2(GD_FLOOR, strTitle, parameters, true );	 
      openExcel5(GD_FLOOR, strTitle, parameters, true , "",g_strPid );


      //var strTitle = "상품별매출현황";
      
      //GD_PTYPE.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
      //openExcel2(GD_PTYPE, strTitle, parameters, true );	       
      
}

/**
 * btn_Print()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 페이지 프린트	인쇄
 * return값	: void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자	: 
 * 작 성 일	: 2010-12-12
 * 개	 요	: 확정 처리
 * return값	: void
 */

function btn_Conf()	{

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * setCalData()
 * 작 성 자	: 정진영
 * 작 성 일	: 2010-02-18
 * 개	 요	:  달력	팝업 실행
 * return값	: void
 */
function setCalData( evnFlag, obj){
	if(	evnFlag	== 'POP'){
		openCal('G',obj);
	}
	if(obj.Text	== "")
		return;
	
	if(!checkDateTypeYMD( obj ))
		return;
}
/**
 * viewChart()
 * 작 성 자	: 정진영
 * 작 성 일	: 2010-02-18
 * 개	 요	:  차트를 표시
 * return값	: void
 */
/* function	viewChart( iFrameId, chartType,	nameId,	amtId, dataSet,	grid, title){
	var	dataTotal	   = dataSet.CountRow; 
	var	totalAmt	  =	dataSet.sum(dataSet.ColumnIndex(amtId),0,0);
	if(	dataTotal <	1){
		return;
	}
	if(	totalAmt < 1)
		return;	   
	var	iframeWidth	= document.getElementById(iFrameId).clientWidth;
	var	iframeHeight = document.getElementById(iFrameId).clientHeight ;
	
	var	dataXmlStr = '<?xml	version="1.0" encoding="euc-kr"?>';
	dataXmlStr	  += '	<CHARTFX>';
	dataXmlStr	  += '	  <COLUMNS>';
	dataXmlStr	  += '		<COLUMN	NAME="GUBN"	';
	dataXmlStr	  += '				TYPE="String" />';
	dataXmlStr	  += '		<COLUMN	NAME="VAL" ';
	dataXmlStr	  += '				TYPE="Double" />';	 
	dataXmlStr	  += '	  </COLUMNS>';

	if(	totalAmt > 0){
		for(var	i=1; i<=dataTotal; i++){
			dataXmlStr	  += '	   <ROW	GUBN="'+replascXMLEscape(dataSet.NameValue(	i, nameId))+'" ';
			dataXmlStr	  += '			VAL="'+dataSet.NameValue( i, amtId)+'" ';
			dataXmlStr	  += '	   ></ROW>';
		}
	}
		
	dataXmlStr	  += '	</CHARTFX>';
	
	var	parameter =	"[{chartType:'"+chartType+"'";
	parameter += ",strWidth:"+iframeWidth;
	parameter += ",strHeight:"+iframeHeight;
	if(	title != null){
		parameter += ",strTitle:'"+title+"'";
	}
	parameter +=",xmlData:'"+dataXmlStr+"'";
	
	parameter +="}]";
	postwith(iFrameId,"/dps/jsp/psal/psal4439.jsp",eval(parameter)[0]);
} */
function StartAdd1(){

	//타이틀 헤더
	TitleTextFix("Chart1","Header","층별 매출");
	Chart1.Header.CustomPosition =true;
	Chart1.Header.Left = 155;
	Chart1.Header.Top = 30;

	//웰
	Chart1.Walls.Visible = false;
	//Panel	설정
	Chart1.Panel.Gradient.Visible =	"true";
	Chart1.Panel.ForeColor = Chart1.ToOLEColor("ced8e0");
	Chart1.Panel.Gradient.StartColor =Chart1.ToOLEColor("FF8C64");
	Chart1.Panel.Gradient.MidColor =Chart1.ToOLEColor("FFE2C3");
	Chart1.Panel.Gradient.EndColor =Chart1.ToOLEColor("FFFFFF");
	//Panal	여백(Percent)
	Chart1.Panel.MarginTop = 20;	// Chart1 Panel에서	상단 공백이	차지하는 %
	//축 표시여부
	Chart1.Axis.Left.Visible = false;
	Chart1.Axis.Right.Visible = false;
	Chart1.Axis.Top.Visible = false;
	Chart1.Axis.Bottom.Visible = false;
	Chart1.Axis.Depth.Visible = false;
	//3D 설정
	SetAspectStyle("Chart1", "false");
	//Zoom 설정
	Chart1.Zoom.Enable=false;
	Chart1.Panel.BackImageInside = true;
}


function Start1(){
	//차트 클리어
	Chart1.ClearChart();
	
	//타이틀 헤더
	TitleTextFix("Chart1","Header","층별 매출");
	Chart1.Header.CustomPosition =true;
	Chart1.Header.Left = 155;
	Chart1.Header.Top = 30;
	
	//Panel	설정
	Chart1.Panel.Gradient.Visible =	"true";
	Chart1.Panel.ForeColor = Chart1.ToOLEColor("ced8e0");
	Chart1.Panel.Gradient.StartColor =Chart1.ToOLEColor("FF8C64");
	Chart1.Panel.Gradient.MidColor =Chart1.ToOLEColor("FFE2C3");
	Chart1.Panel.Gradient.EndColor =Chart1.ToOLEColor("FFFFFF");
	//Panal	여백(Percent)
	Chart1.Panel.MarginTop = 20;	// Chart1 Panel에서	상단 공백이	차지하는 %
	
 	Chart1.AddSeries(8);
	Chart1.Series(0).DataID								= "DS_FLOOR";
	Chart1.Series(0).YValues.Column						= "COMP_RATE";
	Chart1.Series(0).PointLabels.Column					= "HALL_FLOOR_NM";
	Chart1.Series(0).asDonut.Circled					= "false";
	Chart1.Series(0).asDonut.XRadius					= "70";
	Chart1.Series(0).asDonut.YRadius					= "30";
	Chart1.Series(0).asDonut.DonutPercent				= "40";
	Chart1.Series(0).ValueFormat						= "###,##0.##%";
	
	SetAspectStyle("Chart1", "true");
	//차트 리로드
	Chart1.reset();
}

function StartAdd2(){
	//차트 클리어
	Chart2.ClearChart();
	//타이틀 헤더
	TitleTextFix("Chart2","Header","상품별 매출");
	Chart2.Header.CustomPosition =true;
	Chart2.Header.Left = 155;
	Chart2.Header.Top = 30;
	
	//웰
	Chart2.Walls.Visible = false;
	//Panel	설정
	Chart2.Panel.Gradient.Visible =	"true";
	Chart2.Panel.ForeColor = Chart2.ToOLEColor("ced8e0");
	Chart2.Panel.Gradient.StartColor =Chart2.ToOLEColor("FF8C64");
	Chart2.Panel.Gradient.MidColor =Chart2.ToOLEColor("FFE2C3");
	Chart2.Panel.Gradient.EndColor =Chart2.ToOLEColor("FFFFFF");
	//Panal	여백(Percent)
	Chart2.Panel.MarginTop = 20;	// Chart2 Panel에서	상단 공백이	차지하는 %
	//축 표시여부
	Chart2.Axis.Left.Visible = false;
	Chart2.Axis.Right.Visible = false;
	Chart2.Axis.Top.Visible = false;
	Chart2.Axis.Bottom.Visible = false;
	Chart2.Axis.Depth.Visible = false;
	//3D 설정
	SetAspectStyle("Chart2", "false");
	//Zoom 설정
	Chart2.Zoom.Enable=false;
	Chart2.Panel.BackImageInside = true;
}

function Start2(){
	//기본설정
	StartAdd2();
	
	//차트 클리어
	Chart2.ClearChart();
	//타이틀 헤더
	TitleTextFix("Chart2","Header","상품별 매출");
	
	Chart2.Header.CustomPosition =true;
	Chart2.Header.Left = 155;
	Chart2.Header.Top = 30;
	
	//Panel	설정
	Chart2.Panel.Gradient.Visible =	"true";
	Chart2.Panel.ForeColor = Chart2.ToOLEColor("ced8e0");
	Chart2.Panel.Gradient.StartColor =Chart2.ToOLEColor("FF8C64");
	Chart2.Panel.Gradient.MidColor =Chart2.ToOLEColor("FFE2C3");
	Chart2.Panel.Gradient.EndColor =Chart2.ToOLEColor("FFFFFF");
	//Panal	여백(Percent)
	Chart2.Panel.MarginTop = 20;	// Chart2 Panel에서	상단 공백이	차지하는 %
	Chart2.Panel.MarginLeft = 20;
 	Chart2.AddSeries(8);
	Chart2.Series(0).DataID								= "DS_PTYPE";
	Chart2.Series(0).YValues.Column						= "COMP_RATE";
	Chart2.Series(0).PointLabels.Column					= "PTYPE_NAME";
	Chart2.Series(0).asDonut.Circled					= "false";
	Chart2.Series(0).asDonut.XRadius					= "70";
	Chart2.Series(0).asDonut.YRadius					= "30";
	Chart2.Series(0).asDonut.DonutPercent				= "40";
	Chart2.Series(0).ValueFormat						= "###,##0.##%";
	
	SetAspectStyle("Chart2", "true");
	//차트 리로드
	Chart2.reset();
}
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝													 		*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리													*-->
<!--*	 1.	TR Success 메세지 처리
<!--*	 2.	TR Fail	메세지 처리
<!--*	 3.	DataSet	Success	메세지 처리
<!--*	 4.	DataSet	Fail 메세지	처리
<!--*	 5.	DataSet	이벤트 처리
<!--*************************************************************************-->
<!---------------------	1. TR Success 메세지 처리  ---------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onSuccess>
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>

<!---------------------	2. TR Fail 메세지 처리	------------------------------->
<script	language=JavaScript	for=TR_MAIN	event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<!---------------------	3. DataSet Success 메세지 처리	----------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->
<!---------------------	6. 컴포넌트	이벤트 처리	 ------------------------------>

<script	language=JavaScript	for=GD_MASTER event=OnClick(row,colid)>
	sortColId( eval(this.DataID), row ,	colid );	
</script>
<!-- 기간(from)(조회) -->
<script	language=JavaScript	for=EM_FROM_DT event=OnKillFocus()>
	//변경된 내역이	없으면 무시
	if(!this.Modified)
		return;
	setCalData('NAME', EM_FROM_DT);
</script>
<!-- 기간(to)(조회)	-->
<script	language=JavaScript	for=EM_TO_DT event=OnKillFocus()>
	//변경된 내역이	없으면 무시
	if(!this.Modified)
		return;
	setCalData('NAME', EM_TO_DT);
</script>
<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리	끝												*-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의									*-->
<!--*	 1.	DataSet
<!--*	 2.	Transaction
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용	-->
<comment id="_NSID_"><object id="DS_STR_CD"	   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HALL_CD"	   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값	가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"	   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"	   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_FLOOR"	classid=<%=	Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PTYPE"	classid=<%=	Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
	<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	  <param name="KeyName"	value="Toinb_dataid4">
	</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의 끝									*-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작																*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
	<!--공통 타이틀/버튼 -->
	<%@	include	file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 //	-->
	<div id="testdiv" class="testdiv">
		<table width="100%"	border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td	class="PT01	PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
						<tr>
							<td><table width="100%"	border="0" cellpadding="0" cellspacing="0" class="s_table">
									<tr>
										<th	width="60" class="point">점</th>
											<td	width="140">
												<comment id="_NSID_"> 
													<object	id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object> 
												</comment><script>_ws_(_NSID_);</script>
											</td>
										<th	width="60" class="point">기간</th>
											<td width="900">
												<comment id="_NSID_"> 
													<object	id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object> 
												</comment><script> _ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_NOTI_S_DT	onclick="javascript:setCalData('POP', EM_FROM_DT);" align="absmiddle" />
												&nbsp;&nbsp;~&nbsp;	
												<comment id="_NSID_">
													<object	id=EM_TO_DT	classid=<%=Util.CLSID_EMEDIT%> width=80	tabindex=1 align="absmiddle"></object> 
												</comment><script> _ws_(_NSID_);</script>
												<img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_NOTI_E_DT	onclick="javascript:setCalData('POP', EM_TO_DT);" align="absmiddle" />
											</td>
										<%-- <th	width="60" class="point">관</th>
										<td>
											<comment id="_NSID_"> 
												<object id=LC_HALL_CD classid=<%= Util.CLSID_LUXECOMBO %> width=180 tabindex=1 align="absmiddle"></object> 
											</comment><script>_ws_(_NSID_);</script></td> --%>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td	class="dot"></td>
			</tr>
			<tr>
				<td	class="sub_title PB03 PT10"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif"	class="PR03"
					align="absmiddle" /> 층별 매출현황</td>
			</tr>
			<tr>
				<td>
					<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="PL01">
						<tr	valign="top">
							<td>
								<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
									<tr>
										<td>
											<comment id="_NSID_"> 
												<object id=GD_FLOOR	width=100% height=370 classid=<%=Util.CLSID_GRID%>>
													<param name="DataID" value="DS_FLOOR">
												</object>
											</comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
							</td>
<!-- 							<td	width=400 class="PL05"> -->
<!-- 							<iframe width="100%" height=205px id=CHART_001	name=CHART_001 src="" frameborder="0"></iframe>	 -->
<%-- 								<comment id="_NSID_"> --%>
<%-- 									<object	id=Chart1 width=100% height=205	classid=<%=Util.CLSID_SHIFTCHART%> tabindex=1 > --%>
<!-- 										<param name="DataID" value="DS_FLOOR"> -->
<!-- 									</object> -->
<%-- 								</comment><script>_ws_(_NSID_);</script> --%>
<!-- 							</td> -->
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td	class="sub_title PB03 PT10"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif"	class="PR03"
					align="absmiddle" /> 상품별	매출현황</td>
			</tr>
			<tr>
				<td>
					<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="PL01">
						<tr	valign="top">
							<td>
								<table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
									<tr>
										<td>
											<comment id="_NSID_"> 
												<object id=GD_PTYPE	width=100% height=370 classid=<%=Util.CLSID_GRID%>>
													<param name="DataID" value="DS_PTYPE">
												</object> 
											</comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
							</td>
<!-- 							<td	width=400 class="PL05"> -->
<!-- 								<iframe width="100%" height=245px id=CHART_002	name=CHART_002 src="" frameborder="0" ></iframe> -->
<%-- 								<comment id="_NSID_"> --%>
<%-- 									<object	id=Chart2 width=100% height=245	classid=<%=Util.CLSID_SHIFTCHART%> tabindex=1 > --%>
<!-- 										<param name="DataID" value="DS_PTYPE"> -->
<!-- 									</object> -->
<%-- 								</comment><script>_ws_(_NSID_);</script> --%>
<!-- 							</td> -->
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<!-----------------------------------------------------------------------------
  Gauce	Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

