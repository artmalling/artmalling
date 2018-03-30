<!-- 
/*******************************************************************************
 * 시스템명	: 경영지원 > 사은행사관리 >	사은품 지급/취소 > 사은품예외지급현황조회
 * 작 성 일	: 2011.08.29
 * 작 성 자	: 김성미
 * 수 정 자	: 
 * 파 일 명	: MCAE4100.jsp
 * 버	 전	: 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개	 요	: 백화점의 각 점정보를 관리한다
 * 이	 력	:
 *		  2011.08.29 (김성미) 신규작성
 ******************************************************************************/
-->
<%@	page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@	taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@	taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@	taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@	taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인	유무, 기본설정												  	*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet"	type="text/css">
<script	language="javascript" src="/<%=dir%>/js/common.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/gauce.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/global.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/message.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup.js"		type="text/javascript"></script>
<script	language="javascript" src="/<%=dir%>/js/popup_mss.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작														  	*-->
<!--*************************************************************************-->

<script	LANGUAGE="JavaScript">
<!--


/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var	g_select =false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자	: FKL
 * 작 성 일	: 2010-12-12
 * 개	 요	: 해당 페이지 LOAD 시  
 * return값	: void
 */

function doInit(){

	// Input Data Set Header 초기화

	// Output Data Set Header 초기화
	
	//그리드 초기화
	gridCreate1();	   
	gridCreate2();
	
	// EMedit에	초기화
	initEmEdit(EM_S_DATE,		"SYYYYMMDD",	PK);			//기간S
	initEmEdit(EM_E_DATE,		"YYYYMMDD",		PK);			//기간E
	initEmEdit(EM_S_EVENT_CD,	"NUMBER3^11^0",	NORMAL);		//행사명
	initEmEdit(EM_S_EVENT_NAME,	"GEN^40",		READ);			//행사코드

	//콤보 초기화
	initComboStyle(LC_S_STR_CD,DS_S_STR_CD,	"CODE^0^30,NAME^0^80", 1, PK);	//점
	 
	EM_E_DATE.Text			= getTodayFormat("YYYYMMDD");					//기간E
	
	getStore("DS_S_STR_CD",	"Y", "1", "N");									//점(조회) 
	LC_S_STR_CD.Index = 0;
	LC_S_STR_CD.Focus();
}


function gridCreate1(){	
	var	hdrProperies ='<FC>id={currow}			name="NO"			width=70	align=center</FC>'
					+ '<FC>id=STR_CD			name="점"			width=100	align=center	EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME"	</FC>'
					+ '<FC>id=EVENT_CD			name="행사명"			width=150	align=left		show=false</FC>'
					+ '<FC>id=EVENT_NAME		name="행사명"			width=200	align=left</FC>'
					+ '<FC>id=EVENT_S_DT		name="기간S"			width=130	align=center	show=false</FC>'
					+ '<FC>id=EVENT_E_DT		name="기간E"			width=130	align=center	show=false</FC>'
					+ '<FC>id=EVENT_DT			name="행사기간"		width=150	align=center Mask="XXXX/XX/XX~XXXX/XX/XX"</FC>'
					+ '<FC>id=EVENT_PLU_FLAG	name="사은행사유형"	width=130	align=left</FC>'
					+ '<FC>id=USR_NAME			name="DESK담당자"		width=130	align=left</FC>';
					 
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){	
	var	hdrProperies2 ='<FC>id={currow}			name="NO"			width=30	align=center	</FC>'
					+ '<FC>id=PRSNT_DT			name="지급일"			width=100	align=center	Mask="XXXX/XX/XX"</FC>'
					+ '<FC>id=SKU_CD			name="사은품코드"		width=110	align=center	sumtext="합계"</FC>'
					+ '<FC>id=SKU_NAME			name="사은품명"		width=110	align=left		sumtext="합계"</FC>'
					+ '<FC>id=BUY_COST_PRC		name="매입원가"		width=100	align=right		sumtext=@sum</FC>'
					+ '<FC>id=EXCP_PRSNT_RSN	name="예외지급코드"	width=90	align=center	</FC>'
					+ '<FC>id=RSN_NAME			name="예외지급코드명"	width=140	align=left		</FC>'
					+ '<FC>id=CONF_NAME			name="승인자명"		width=100	align=left		</FC></FG>';
					 
	initGridStyle(GD_DETAIL, "common", hdrProperies2, false);
	GD_DETAIL.ViewSummary =	"1";
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
	if (EM_S_DATE.Text > EM_E_DATE.Text){ 
		showMessage(INFORMATION, OK, "USER-1008", "행사종료기간", "행사시작기간");
		EM_S_E_DT.Focus();
		return;
	}
	 
	// 조회조건	셋팅
	var	strStrCd		= LC_S_STR_CD.BindColVal;
	var	strSdt			= EM_S_DATE.Text;
	var	strEdt			= EM_E_DATE.Text;
	var	strEventCd		= EM_S_EVENT_CD.Text;
   
	var	goTo	   = "getMaster" ;	  
	var	action	   = "O";	  
	var	parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
				   + "&strSdt="    + encodeURIComponent(strSdt)
				   + "&strEdt="    + encodeURIComponent(strEdt)
				   + "&strEventCd="+ encodeURIComponent(strEventCd);
	TR_MAIN.Action="/mss/mcae410.mc?goTo="+goTo+parameters;	 
	TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)";	//조회는 O
	g_select =true;
	TR_MAIN.Post();
	g_select = false;
	
	setPorcCount("SELECT", GD_MASTER);
	
	if(DS_MASTER.CountRow !=0) {
		getDetail();
	}
	else{ 
		DS_MASTER.ClearData();
		DS_DETAIL.ClearData();
	} 
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
//	  DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
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
 * getSEvent()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-01-26
 * 개	 요	:  조회용 이벤트 팝업
 * return값	: void
 */
 function getSEvent(){
	
	// 조회	이벤트 조건	검색시 점코드 필수 
	if(LC_S_STR.BindColVal.length == 0){
		showMessage(EXCLAMATION, OK, "USER-1001", "점");
		return;
	}
	mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','Y', LC_STR.BindColVal
			, EM_S_S_DT.Text, EM_S_E_DT.Text ,'02');
	
 }
 
/**
 * getDetail()
 * 작 성 자	: 김정민
 * 작 성 일	: 2011-05-06
 * 개	 요	: DETAIL조회
 * return값	: void
 */
function getDetail() {	
	 if(DS_MASTER.CountRow == "0") {
		  return;	 
	 }

	 var strStrCd	 = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
	 var strEventCd	 = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD"); 
	 
	 var goTo		= "getDetail" ;	   
	 var action		= "O";	   
	 var parameters	= "&strStrCd="	  +	encodeURIComponent(strStrCd)
					+ "&strEventCd="  +	encodeURIComponent(strEventCd);
	
	 TR_MAIN.Action="/mss/mcae410.mc?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
	 TR_MAIN.Post();
	 
	 setPorcCount("SELECT",	GD_DETAIL);	   
}

/**
 * getDetail2()
 * 작 성 자	: 김정민
 * 작 성 일	: 2011-05-06
 * 개	 요	: DETAIL조회
 * return값	: void
 */
function getDetail2() {	 
	 if(DS_MASTER.CountRow == "0") {
		  return;	 
	 }

	 var strStrCd	 = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
	 var strEventCd	 = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD"); 
	 var strSdate	 = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT");	
	 var strEdate	 = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT");	
	
	 var goTo		= "getDetail" ;	   
	 var action		= "O";	   
	 var parameters	= "&strStrCd="	  +	encodeURIComponent(strStrCd)
					+ "&strEventCd="  +	encodeURIComponent(strEventCd)
					+ "&strSdate="	  +	encodeURIComponent(strSdate)
					+ "&strEdate="	  +	encodeURIComponent(strEdate);
	
	 TR_MAIN.Action="/mss/mcae410.mc?goTo="+goTo+parameters;  
	 TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
	 TR_MAIN.Post(); 
}

/**
 * openPop()
 * 작 성 자	: 김성미
 * 작 성 일	: 2011-03-15
 * 개	 요	: 정산 상세	자료조회 popup
 * return값	: void
 */
function openPop(){
	var	arrArg	= new Array();
	arrArg.push(DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD"));
	arrArg.push(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD"));
	arrArg.push(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD")); 
	 
	var	returnVal =	window.showModalDialog("/mss/mcae410.mc?goTo=openPop",
										   arrArg,
										   "dialogWidth:900px;dialogHeight:535px;scroll:no;" +
										   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝													 *-->
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
	showMessage(STOPSIGN, OK, "USER-1000", "Transaction	Fail!\n" + "ErrorCode :	" +	TR_MAIN.ErrorCode +	"\n" + "ErrorMsg  :	" +	TR_MAIN.ErrorMsg);
	for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++)	{
		showMessage(STOPSIGN, OK, "GAUCE-1000",	TR_MAIN.SrvErrMsg('GAUCE',i));
	}
</script>

<!---------------------	3. DataSet Success 메세지 처리	----------------------->
<!---------------------	4. DataSet Fail	메세지 처리	 -------------------------->
<!---------------------	5. DataSet 이벤트 처리	------------------------------->
<script	language=JavaScript	for=GD_MASTER event=OnClick(row,colid)>
	//정렬
	if (row	== 0){
		sortColId(eval(this.DataID), row, colid);
	}	 
</script>

<script	language=JavaScript	for=GD_DETAIL event=OnClick(row,colid)>
	//정렬
	if (row	== 0){
		sortColId(eval(this.DataID), row, colid);
	}	 
</script>

<script	language=JavaScript	for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
	if (row	> 0	&& g_select==false)	{  
		
		setTimeout("getDetail()",50);
	//	  GD_DETAIL.SetColumn("RANK");
	}	 
</script>

<script	language=JavaScript	for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>

<script	language=JavaScript	for=GD_DETAIL event=OnDblClick(row,colid)>
if(row == 0) return; 
openPop();
</script>

<!---------------------	6. 컴포넌트	이벤트 처리	 ------------------------------>
<script	language=JavaScript	for=EM_S_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length	> 0	) {	
	  if(!this.Modified)
				return;
				
			if(this.text==''){
				EM_S_EVENT_NAME.Text = "";
				return;
			}
		 
			if(LC_S_STR_CD.BindColVal == "%"){
				showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
				LC_S_STR_CD.Focus();
				return;
			}
		
		setMssEvtMstNmWithoutPop('DS_O_RESULT',	'SEL_STR_EVT_NAME',	EM_S_EVENT_CD, EM_S_EVENT_NAME,	LC_S_STR_CD.BindColVal,	'4');
		if (DS_O_RESULT.CountRow ==	1 )	{  
			EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,	"EVENT_CD");
			EM_S_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
		} else {
			//1건 이외의 내역이	조회 시	팝업 호출 
			mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '4');
		}
  //  }	 
	 
</script>

<script	language=JavaScript	for=LC_S_STR_CD	event=OnSelChange()>
	EM_S_EVENT_CD.Text = "";
	EM_S_EVENT_NAME.Text = "";
</script>
<!--*************************************************************************-->
<!--* C. 가우스	이벤트 처리	끝												 *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의									 *-->
<!--*	 1.	DataSet
<!--*	 2.	Transaction
<!--*************************************************************************-->

<!---------------------	1. DataSet	------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용	-->
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"	 classid=<%= Util.CLSID_DATASET	%>></object></comment><script>_ws_(_NSID_);</script>

<!---------------------	2. Transaction	--------------------------------------->
<comment id="_NSID_">
<object	id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName"	value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_">
<object	id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object	id="DS_I_CONDITION"	classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object	id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스	DataSet	& Transaction 정의 끝																						 *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작																																								*-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
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
			  <th width="60" class="point">점</th>
			  <td width="120" >
				  <comment id="_NSID_">
					  <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1	 height=100	width=120 align="absmiddle">
					  </object>
				  </comment><script>_ws_(_NSID_);</script>	 
			  </td>
			  <th width="60" class="point">기간</th>
			  <td width="200" >	
				  <comment id="_NSID_">
						  <object id=EM_S_DATE classid=<%= Util.CLSID_EMEDIT %>	width=70 tabindex=1	align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						  </object>
				  </comment><script>_ws_(_NSID_);</script>
				  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DATE)" />
				  ~
				  <comment id="_NSID_">
						  <object id=EM_E_DATE classid=<%= Util.CLSID_EMEDIT %>	width=70 tabindex=1	align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						  </object>
				  </comment><script>_ws_(_NSID_);</script>
				  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DATE)" />
			  </td>	 
			  <th width="60" >행사코드</th>
			  <td ><comment	id="_NSID_"> <object
				  id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=70
				  tabindex=1 align="absmiddle">	</object> </comment><script>_ws_(_NSID_);</script>
			  <img id=IMG_EVENT	src="/<%=dir%>/imgs/btn/detail_search_s.gif"
				  class="PR03" onclick="javascript:	mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '4');"
				  align="absmiddle"	/> <comment	id="_NSID_"> <object
				  id=EM_S_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>	width=135
				  tabindex=1 align="absmiddle">	</object> </comment><script>_ws_(_NSID_);</script>
			  </td>
		  </tr>
		</table></td>
	  </tr>
	</table></td>
  </tr>
  <tr>
	<td	height="5"></td>
  </tr>	  
  <tr>
	<td	class="dot"></td>
  </tr>	  
  <tr valign="top">
	<td><table width="100%"	border="0" cellspacing="0" cellpadding="0">
	  <tr valign="top">				   
		<td><table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
		  <tr>
			<td>
				<comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=242	classid=<%=Util.CLSID_GRID%>>
				<param name="DataID" value="DS_MASTER">
				</OBJECT></comment><script>_ws_(_NSID_);</script>
			</td>  
		  </tr>
		</table></td>
	  </tr>
	</table></td>
  </tr>
  <tr>
	<td	height="5"></td>
  </tr>
  <tr>
	<td	class="dot"></td>
  </tr>
  <tr valign="top">
	<td><table width="100%"	border="0" cellspacing="0" cellpadding="0">
	  <tr valign="top">				   
		<td><table width="100%"	border="0" cellspacing="0" cellpadding="0" class="BD4A">
		  <tr>
			<td>
				<comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=242	classid=<%=Util.CLSID_GRID%>>
				<param name="DataID" value="DS_DETAIL">
				</OBJECT></comment><script>_ws_(_NSID_);</script>
			</td>  
		  </tr>
		</table></td>
	  </tr>
	</table></td>
  </tr>
</table>
</DIV>
</body>
</html>

