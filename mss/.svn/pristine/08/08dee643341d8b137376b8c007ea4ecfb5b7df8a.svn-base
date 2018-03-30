<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 월 직접사용량 조회
 * 작 성 일 : 2010.04.20
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN3010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월 직접사용량 조회
 * 이    력 : 2010.04.20 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"          prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %> 

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
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_GAUGMST"/>');
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_S_FCL_FLAG,             "CODE^0^30,NAME^0^100", 1, PK); // [조회용]시설구분 
    initEmEdit(EM_S_GOAL_YM, "YYYYMM", PK);                                                 // [조회용]년월
    initEmEdit(EM_S_VEN_CD,     "GEN^6",NORMAL);                                            // [조회용]협력업사코드 
    initEmEdit(EM_S_VEN_NM,   "GEN^40",READ);                                               // [조회용]협력업사명   
    
    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_S_FCL_FLAG",             "M", "1", "Y", "N");                                // [조회용]시설구분  
    EM_S_GOAL_YM.Text = getTodayFormat("YYYYMM");
    LC_S_FCL_FLAG.Focus();
    LC_S_FCL_FLAG.index = "0"; // [조회용]시설구분 
}

function gridCreate(gdGnb){
	//마스터그리드
	if (gdGnb == "MST") {
	    var hdrProperies = ''
	        + '<FC>ID={CURROW}     NAME="NO"'
	        + '                                         WIDTH=30   ALIGN=CENTER </FC>'
	        + '<FC>ID=CNTR_ID      NAME="계약ID"'
	        + '                                         WIDTH=75   ALIGN=CENTER </FC>'
	        + '<FC>ID=VEN_CD       NAME="협력사코드"'
	        + '                                         WIDTH=75   ALIGN=CENTER </FC>'
	        + '<FC>ID=VEN_NM       NAME="협력사명"'
	        + '                                         WIDTH=170  ALIGN=LEFT </FC>'
	        + '<G>                 NAME="사용량"'
	        + '<FC>ID=GAUG_10      NAME="전기"'
	        + '                                         WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC </FC>'
	        + '<FC>ID=GAUG_20      NAME="급탕"'
            + '                                         WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC </FC>'
	        + '<FC>ID=GAUG_30      NAME="증기"'
            + '                                         WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC </FC>'
	        + '<FC>ID=GAUG_40      NAME="냉수"'
            + '                                         WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC </FC>'
	        + '<FC>ID=GAUG_50      NAME="가스"'
            + '                                         WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC </FC>'
	        + '<FC>ID=GAUG_60      NAME="수도"'
            + '                                         WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC </FC></G>'
	        ;   
	    initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
	 //  
    var strFclCd    = LC_S_FCL_FLAG.BindColVal;    // [조회용]시설구분
    var strGoalYm   = EM_S_GOAL_YM.Text;           // [조회용]부가년월
    var strVenCd    = EM_S_VEN_CD.Text;            // [조회용]협력사
    
    var goTo = "getMaster";
    var parameters = "&strFclCd="   + encodeURIComponent(strFclCd)
                   + "&strGoalYm="  + encodeURIComponent(strGoalYm)
                   + "&strVenCd="   + encodeURIComponent(strVenCd);
    TR_MAIN.Action = "/mss/mren301.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();

    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "월 직접사용량"        
	    //   
	    var excel_strcd  = LC_S_FCL_FLAG.Text;
	    var excel_sGoal  = EM_S_GOAL_YM.Text;
	    var excel_eVencd = EM_S_VEN_CD.Text;
        var excel_eVenNm = EM_S_VEN_NM.Text;
	    
	    var parameters = "시설구분="    +excel_strcd
	                   + " - 부과년월=" + excel_sGoal
	                   + " - 협력사="   +excel_eVencd + excel_eVenNm;
	    
	    openExcel2(GD_MASTER, ExcelTitle, parameters, true );
	    GD_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
  <script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()> 
//협력사코드 변경시
    if(!this.Modified) return;
       
    if(this.text==''){;
        EM_S_VEN_NM.Text = "";
        return;
    } 

    setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM , '1', LC_S_FCL_FLAG.BindColVal);
</script>

<script language=JavaScript for=LC_S_FCL_FLAG event=OnSelChange()>
//시설구분 변경시
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_S_FCL_FLAG"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
 
<!-- =============== 공통함수용 -->
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
 
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
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
						<th class="point" width="60">시설구분</th>
						<td width="133"><comment id="_NSID_"> <object
							id=LC_S_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="130"
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td> 
						<th width="80" class="point">부과년월</th>
						<td width="128"><comment id="_NSID_"> <object
							id=EM_S_GOAL_YM classid=<%=Util.CLSID_EMEDIT%> width=100
							tabindex=1 align="absmiddle" onblur="checkDateTypeYM(this);">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_GOAL_YM)" /></td>
						<th width="60">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_S_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:venPop(EM_S_VEN_CD, EM_S_VEN_NM, LC_S_FCL_FLAG.BindColVal);EM_S_VEN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=180
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<td height="1"></td>
	</tr>
	<tr valign="top">
		<td align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=503 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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

