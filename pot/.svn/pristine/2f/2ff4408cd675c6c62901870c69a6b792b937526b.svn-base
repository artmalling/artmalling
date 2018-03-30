<%
/*******************************************************************************
  * 시스템명 : 한국후지쯔 통합정보시스템 공통
  * 작 성 일 : 2010.12.12
  * 작 성 자 : 정지인
  * 수 정 자 :
  * 파 일 명 : left.jsp
  * 버    전 : 1.0
  * 개    요 : 좌측 메뉴 구성
  * 이    력 :
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty,common.dao.CCom900DAO,kr.fujitsu.ffw.util.String2"  %>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"	prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"		prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"	prefix="button" %>
<%
	/****************** 세션 서브시스템 셋팅 *****************/
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	if (sessionInfo != null) {
		if (request.getParameter("subsystem") != null && !"".equals(request.getParameter("subsystem"))) {
			sessionInfo.setSUB_SYS(request.getParameter("subsystem"));
		}
	}
	
	//영업관리(P), 영업지원(M), 시스템관리(T) 외의 값은 P로 고정
	if(sessionInfo.getSUB_SYS().equals("H") || sessionInfo.getSUB_SYS().equals("A") || sessionInfo.getSUB_SYS().equals("O")) {
		sessionInfo.setSUB_SYS("P");
	}
%>
<ajax:library />
<%
	String dir = BaseProperty.get("context.common.dir");
	String subCode2 = String2.trimToEmpty(request.getParameter("subsystem2"));
%>
<HTML>
<HEAD>
</HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"   type="text/javascript"></script>


<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var subSystem = '<c:out value="${sessionScope.sessionInfo.SUB_SYS}" />';     // login 주업무 영역
var isAllMenu = '<c:out value="${sessionScope.isAllMenu}" />';                  // 전체 권한을 가진 사용자
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

/**
* doInit()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-07
* 개    요 : 화면이 처음 로딩될때 호출되는 영역 입니다. 가우스 콤포넌트 초기화 포함
* return값 : void
*/
function doInit(){
	
	//트리 헤더 초기화
	DS_O_TREE_MAIN.setDataHeader('<gauce:dataset name="H_TREE_MAIN"/>');

	//서브시스템 헤더 초기화
	DS_I_SUB_SYSTEM.setDataHeader('<gauce:dataset name="H_SUB_SYSTEM"/>');

	//트리 보여주기
	showTreeView();

	//이미지 데이터셋 초기화
	initImgDataSet(IDS_IMAGE);

	//5분마다 알람 보여주기
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
* showTreeView()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : 트리 형태로 값을 뿌려줍니다.
* return값 : void
*/
function showTreeView(){
	DS_O_TREE_MAIN.ClearAll();
	var strSubSysCd = getSubSystemCode();
	setSubSystem(strSubSysCd);

	TR_MAIN.Action="/pot/tcom003.tc?goTo=treeview&subCode=<%=subCode2%>";
	TR_MAIN.KeyValue="SERVLET(I:DS_I_SUB_SYSTEM=DS_I_SUB_SYSTEM,O:DS_O_TREE_MAIN=DS_O_TREE_MAIN)";
	TR_MAIN.Post();
	
	
	// 시스템 관리일 때 모든메뉴 펼침
	if(strSubSysCd == "T" || strSubSysCd == "F" ){
		TV_MAIN.ExpandLevel = "3";
	}else{
		TV_MAIN.ExpandLevel = "1";
	}
	
    setTimeout("TV_MAIN.Focus();", 100);
	TV_MAIN.index= 1;
}

/**
* showTreeViewByName()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : 트리 형태로 값을 뿌려줍니다.
* return값 : void
*/
function showTreeViewByName(){
	if("<%=subCode2%>" == "F"){
		showMessage(INFORMATION, OK, "USER-1000", "즐겨찾기에서 검색기능은 지원되지 않습니다.");
		return;
	} else {
		DS_O_TREE_MAIN.ClearAll();
		setSubSystem(getSubSystemCode());

		TR_MAIN.Action="/pot/tcom003.tc?goTo=treeview&subCode=<%=subCode2%>&strPName=" + encodeURIComponent(textfield.value);
		TR_MAIN.KeyValue="SERVLET(I:DS_I_SUB_SYSTEM=DS_I_SUB_SYSTEM,O:DS_O_TREE_MAIN=DS_O_TREE_MAIN)";
		TR_MAIN.Post();
	}
}

/**
* setSubSystem()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : DB작업 수행시 SUB_SYSTEM값이 필요한 경우 데이터셋을 셋팅한다.
* return값 : void
*/
function setSubSystem(subSystem) {
	DS_I_SUB_SYSTEM.ClearData();
	DS_I_SUB_SYSTEM.Addrow();
	DS_I_SUB_SYSTEM.NameValue(DS_I_SUB_SYSTEM.RowPosition, "SUB_SYSTEM" )  = subSystem;
}

/**
* getSubSystemCode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : 현재 선택된 SUB_SYSTEM의 코드값을 리턴한다.
* return값 : SUB_SYSTEM (공통코드 TC01에 정의: C 문화센터, D 포인트카드, M 경영지원, O 온라인백오피스, P 백화점, T 포탈/시스템)
*/
function getSubSystemCode(){
	var sRetVal;
	<c:if test="${requestScope.systemCode!= null}">
		sRetVal = '<c:out value="${ requestScope.systemCode }"/>';
	</c:if>
	<c:if test="${requestScope.systemCode == null}">
		sRetVal = '<c:out value="${ sessionScope.sessionInfo.SUB_SYS }"/>';
	</c:if>

	return sRetVal;
}

// 불려질 url체크, 조회 중입니다.윈도우 떠있지 않을때
function urlLink(pid,url,lcode,mcode,title){
	if (url != '' && top.mainFrame.openWaitWin == null)
	{
		document.myForm.pid.value = pid;
		document.myForm.url.value = url;
		document.myForm.lcode.value = lcode;
		document.myForm.mcode.value = mcode;
		document.myForm.title.value = title;
		document.myForm.action = "/pot/jsp/openBzPage.jsp";

		//상태바 초기화
		setPorcCount("CLEAR");
		document.myForm.submit();
	}
}

/**
 * addFavorite()
 * 작 성 자 : fkl
 * 작 성 일 : 2007-01-16
 * 개    요 : 즐겨찾기 추가
 *         TreeView에서 즐겨찾기를
 *         Click하면 즐겨찾기 Table에 Insert
 * return값 : void
*/
function addFavorite(){

	var row = TV_MAIN.Index;
	if(row < 1){
		showMessage(INFORMATION, OK, "USER-1000", "프로그램을 선택하세요 ");
		return;
	}

	if (DS_O_TREE_MAIN.NameValue(row, "URL") == "")  {
		showMessage(INFORMATION, OK, "USER-1000", "즐겨찾기는 프로그램만 추가 가능합니다 ");
		return;
	}

	var programID = DS_O_TREE_MAIN.NameValue(row, "SCODE");
	var goTo         = "addFavorite";
	var action       = "O";
	TR_MAIN.Action   = "/pot/tcom007.tc?goTo="+goTo+"&programID="+programID;
	TR_MAIN.KeyValue = "SERVLET("+action+":DSPOST=DS_FAVORITE)";//조회는 O
	TR_MAIN.Post();

	if( TR_MAIN.ErrorCode == 0){
		for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
			showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
		}
		//showTreeView();
	}
}

/**
 * delFavorite()
 * 작 성 자 : fkl
 * 작 성 일 :
 * 개    요 : 즐겨찾기 추가
 *         TreeView에서 즐겨찾기를
 *         Click하면 즐겨찾기 Table에 Delete
 * return값 : void
*/
function delFavorite(){

	var row = TV_MAIN.Index;
	if(row < 1){
		showMessage(INFORMATION, OK, "USER-1000", "프로그램을 선택하세요 ");
		return;
	}

	if (DS_O_TREE_MAIN.NameValue(row, "URL") == "")  {
		return;
	}

	var programID    = DS_O_TREE_MAIN.NameValue(row, "SCODE");
	var goTo         = "delFavorite";
	var action       = "O";
	TR_MAIN.Action   = "/pot/tcom007.tc?goTo="+goTo+"&programID="+programID;
	TR_MAIN.KeyValue = "SERVLET("+action+":DSPOST=DS_FAVORITE)";//조회는 O
	TR_MAIN.Post();

	if( TR_MAIN.ErrorCode == 0){
		for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
			showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
		}
		showTreeView();
	}
}

</script>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                            *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                    *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ------------------------------>
<script language=JavaScript for=TR_MAIN event=onSuccess>
setTimeout("TV_MAIN.Focus();", 100);
setTimeout("TV_MAIN.index=1;", 100);
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 5. DataSet 이벤트 처리 ---------------------------------->
<!-- 트리 메뉴 클릭시 이벤트 : 해당 URL로 이동하기   -->
<script language=JavaScript for=TV_MAIN event=OnItemClick(index)>

// alert("index = " + index);

	var url = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "URL");
	var pid = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "SCODE");
	//var a = 'DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "URL")';

	var lcode = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "LCODE");
	var mcode = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "MCODE").substr(4,5);
	var title = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "TXT");

	urlLink(pid,url,lcode,mcode,title);

</script>
<!-- 즐겨찾기 추가/삭제   -->
<script language=JavaScript for=TV_MAIN event=OnContextMenu(x,y,row)>
	if ((TV_MAIN.ItemLevel == 4) && ('<%=subCode2%>' != 'F')){
		TV_MAIN.MenuData="즐겨찾기 추가^1^1^1";
		TV_MAIN.TrackPopupMenu(x,y);
	}

	if ((TV_MAIN.ItemLevel == 2)&& ('<%=subCode2%>' == 'F')){
		TV_MAIN.MenuData="즐겨찾기 삭제^2^2^2";
		TV_MAIN.TrackPopupMenu(x,y);
	}
</script>
<script language=JavaScript for=TV_MAIN event=OnCommand(code,text)>
	if (code == 1){
		addFavorite();
	}else{
		delFavorite();
	}
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                   *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<comment id="_NSID_"><object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>"><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!-- 트리뷰용 데이터셋 -->
<comment id="_NSID_"><object id="DS_O_TREE_MAIN" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FAVORITE" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>

<!-- 현재 선택된 서브시스템 : LUXCOMBO(LC_SUB_SYSTEM)의 선택된 값에 의해 정해짐 -->

<!--
		백화점		P dps
		경영지원		M mss
		포인트카드	D dcs
		문화센터		C ccs
		포탈			T pot
 -->
<comment id="_NSID_"><object id="DS_I_SUB_SYSTEM" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>
<!-- 이미지 적용을 위한 데이터셋 -->
<comment id="_NSID_"><object id="IDS_IMAGE" classid=<%=Util.CLSID_IMGDATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                            *-->
<!--*************************************************************************-->

<BODY onLoad="doInit()" >
<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr height=0>
		<td class="l_o_bx01"></td>
		<td class="l_o_bx02"></td>
		<td class="l_o_bx03"></td>
	</tr>
	<tr height=0>
		<td width="3" class="l_o_bx04"></td>
		<td valign="top" >
			<table width="99%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
				<tr height=10>
					<td colspan="3" height=10>
						<!-- 즐겨찾기 이미지-->
						<%
							if ("F".equals(subCode2)) {
						%>
								<img src="/<%=dir%>/imgs/comm/left_title07.gif" width="173" height="42" />
						<%
							} else {
						%>
								<!-- sub_System 수정-->
								<!-- 
									기준정보 S
									매출관리 B
									매출현황 F
									영업관리 P
									고객관리 M 
									상품권관리 G
									사은행사 J
									임대관리 K
									시스템관리 T
								 -->
								 
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'S'}">
									<img src="/<%=dir%>/imgs/comm/left_title01.gif" />
								</c:if>
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'B'}">
									<img src="/<%=dir%>/imgs/comm/left_title02.gif" />
								</c:if>
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'F'}">
									<img src="/<%=dir%>/imgs/comm/left_title03.gif" />
								</c:if>
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'P'}">
									<img src="/<%=dir%>/imgs/comm/left_title04.gif" />
								</c:if>
								
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'M'}">
									<img src="/<%=dir%>/imgs/comm/left_title05.gif" />
								</c:if>
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'G'}">
									<img src="/<%=dir%>/imgs/comm/left_title06.gif" />
								</c:if>
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'J'}">
									<img src="/<%=dir%>/imgs/comm/left_title07.gif" />
								</c:if>
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'K'}">
									<img src="/<%=dir%>/imgs/comm/left_title08.gif" />
								</c:if>
								
								<c:if test="${ sessionScope.sessionInfo.SUB_SYS == 'T'}">
									<img src="/<%=dir%>/imgs/comm/left_title09.gif" />
								</c:if>
						<%
							}
						%>
					</td>
				</tr>
				<tr bgcolor="#efefef" >
					<td  class="l_i_bx04"></td>
					<td height="27" >
						<table border="0" align="center" cellpadding="0" cellspacing="0">
							<tr>
								<td class="PR05"><img src="/<%=dir%>/imgs/comm/left_search_tx.gif" width="20" height="12" /></td>
								<td><input type="text" name="textfield" id="textfield" class="left_search" onkeydown="if (event.keyCode == 13){ showTreeViewByName();return false;}"/></td>
								<td class="PL03">
									<a onClick="javascript:showTreeViewByName()">
										<img src="/<%=dir%>/imgs/btn/search_s.gif" width="14" height="13" />
									</a>
								</td>
							</tr>
						</table>
					</td>
					<td  class="l_i_bx06"></td>
				</tr>
				<tr>
					<td width="3" class="l_i_bx04"></td>
					<td width="98%" height="100%"  valign="top"  class="PT07">
					<!-- td width="167" height="462"  valign="top"  class="PT07"-->
						<!-- 가우스로 메뉴 넣기 START -->
						<comment id="_NSID_">
							<object id=TV_MAIN classid=<%=Util.CLSID_TREEVIEW%> height="100%" width=100% >
								<!-- object id=TV_MAIN classid=<%//=Util.CLSID_TREEVIEW%> height=462 width=100% -->
								<param name=DataID			value="DS_O_TREE_MAIN">		<!-- Bind할 DataSet의 ID -->
								<param name=TextColumn		value="TXT">				<!-- 컨텐츠 -->
								<param name=LevelColumn		value="LVL">				<!-- 레벨 -->
								<param name=ImgDataID		value="IDS_IMAGE">
								<param name=ImgOColumn		value="OIMG">
								<param name=ImgCColumn		value="CIMG">
								<param name=ImgDColumn		value="DIMG">
								<param name=ExpandOneClick	value="true">
								<param name=BorderStyle		value="0">
								<param name=ItemHeight      value="26">
								
								<param name=FontSize        value="11">
								<param name=FontName        value="돋움">
							</object>
						</comment><script>_ws_(_NSID_);</script>
						<!-- 가우스로 메뉴 넣기 END -->
					</td>
					<td class="l_i_bx06"></td>
				</tr>
				<tr>
					<td  class="l_i_bx07" /></td>
					<td  class="l_i_bx08"></td>
					<td  class="l_i_bx09" /></td>
				</tr>
			</table>
		</td>
		<td  class="l_o_bx06"></td>
	</tr>
	<!-- tr>
		<td class="l_o_bx04"></td>
		<td bgcolor="#efefef" class="PT05 PB03 PL10">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="16" ><img src="/<%//=dir%>/imgs/comm/left_link.gif" width="71" height="11" /></td>
				</tr>
				<tr>
					<td>
						<select name="select" id="select">
							<option>통합 정보시스템</option>
						</select>
					</td>
				</tr>
			</table>
		</td>
		<td class="l_o_bx06"></td>
	</tr-->
	<tr>
		<td class="l_o_bx07" /></td>
		<td class="l_o_bx08"></td>
		<td class="l_o_bx09" /></td>
	</tr>
</table>


<form name="myForm" target="myhiddenFrame">
	<input type="hidden" name="pid">
	<input type="hidden" name="url">
	<input type="hidden" name="lcode">
	<input type="hidden" name="mcode">
	<input type="hidden" name="title">
</form>

<!-----좌메뉴끝------>
<iframe  name="myhiddenFrame"  style="display:none;"></iframe>
</BODY>
</HTML>
<div id='tmp' style="visible:none"></div>
