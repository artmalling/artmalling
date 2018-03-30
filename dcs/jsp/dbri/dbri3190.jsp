<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 포인트현황> 회원매출현황(PC 상호간)
 * 작 성 일 : 2012.06.25
 * 작 성 자 : kj
 * 수 정 자 : 
 * 파 일 명 : dbri3190.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2012.06.25 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String strFromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strFromDate = strFromDate + "01";
    
	String strToDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	 
    initEmEdit(EM_S_DT_S, "YYYYMMDD",  PK);           // 대비조회일
    initEmEdit(EM_E_DT_S, "YYYYMMDD",  PK);           // 대비조회일
    
    //콤보 초기화
    //initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);   //점(조회)
    
	//콤보 초기화
	initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);                                 //점(조회)
7	//팀
	initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                            //팀(조회)
	//파트
	initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                            //파트(조회)
	//PC
	initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                                //PC(조회)
	
	//EM_S_DT_S.text = <%=strFromDate%>;
	EM_S_DT_S.text = <%=strToDate%>;
    EM_E_DT_S.text = <%=strToDate%>;  
    	
    //getStore("DS_STR_CD", "Y", "", "N");         //점콤보 가져오기 ( gauce.js )
	
    var strOrgFlag = '1';
    getStore("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                  //점
	getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                // 팀
	getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트
	getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC
    
    LC_STR_CD.Index= 0;
    LC_STR_CD.Focus();
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
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(trim(EM_S_DT_S.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DT_S.Focus();
        return;
    }
    if(trim(EM_E_DT_S.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DT_S.Focus();
        return;
    }

    if(trim(LC_TEAM_CD.BindColVal)  == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","파트");
        LC_DEPT_CD.Focus();
        return;
    }
    
    var parameters = "&strStrCd="   + LC_STR_CD.BindColVal //점코드
				   + "&strFromDate="+ EM_S_DT_S.Text
				   + "&strToDate="  + EM_E_DT_S.Text
				   + "&strDeptCd="  + LC_DEPT_CD.BindColVal
				   + "&strTeamCd="  + LC_TEAM_CD.BindColVal
				   + "&strPcCd="    + LC_PC_CD.BindColVal
                   ;
    
    IFrame.location.href="/dcs/jsp/dbri/dbri3191.jsp?"+parameters;
}

/**
 * subQuery()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {

    if(trim(EM_S_DT_S.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DT_S.Focus();
        return;
    }
    if(trim(EM_E_DT_S.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DT_S.Focus();
        return;
    }

    if(trim(LC_TEAM_CD.BindColVal)  == '%'){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","파트");
        LC_DEPT_CD.Focus();
        return;
    }
    
    var parameters = "&strStrCd="   + LC_STR_CD.BindColVal //점코드
				   + "&strFromDate="+ EM_S_DT_S.Text
				   + "&strToDate="  + EM_E_DT_S.Text
				   + "&strDeptCd="  + LC_DEPT_CD.BindColVal
				   + "&strTeamCd="  + LC_TEAM_CD.BindColVal
				   + "&strPcCd="  + LC_PC_CD.BindColVal
                   ;
    window.open("/dcs/jsp/dbri/dbri3191.jsp?"+parameters,"OZPRINT", 1000, 700);	 
}

/**
 * btn_Conf()
 * 작 성 자 : kj
 * 작 성 일 : 2012-06-25
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 대비조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
    	EM_S_DT_S.text = <%=strFromDate%>;
    }
</script>
    
<!-- 대비조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
		EM_E_DT_S.text = <%=strToDate%>;
	}
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>

	var strOrgFlag='1';


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
		var strOrgFlag='1';
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
	if(LC_TEAM_CD.BindColVal != "%"){

		var strOrgFlag='1';
		getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC
	}else{
		DS_PC_CD.ClearData();
		insComboData( LC_PC_CD, "%", "전체",1);
	}
	LC_PC_CD.Index   = 0;
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
  
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>

<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>

<object id="DS_PC_CD" classid=<%=Util.CLSID_DATASET%>></object>

    
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
    		<tr>
				<th width="70" class="point">점</th>
				<td width="105">
					<comment id="_NSID_">
						<object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"></object>
					</comment><script>_ws_(_NSID_);</script>
				</td>
				<th width="70" class="point">팀</th>
				<td width="150">
					<comment id="_NSID_">
						<object id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"></object>
					</comment>
					<script>_ws_(_NSID_);</script>
				</td>
				<th width="70" class="point">파트</th>
				<td width="150">
					<comment id="_NSID_">
						<object id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"></object>
					</comment>
					<script>_ws_(_NSID_);</script>
				</td>
				<th width="70">PC</th>
				<td >
					<comment id="_NSID_">
						<object id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle"></object>
					</comment>
					<script>_ws_(_NSID_);</script>
				</td>
			</tr>
          <tr>
            <!-- 
            <th width="100" class="point">점코드</th>
            <td><comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
             -->
            <th width="100" class="point">조회기간</th>
			<td colspan="3"><comment id="_NSID_"> <object
				id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
				tabindex=1
				align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
				src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
				onclick="javascript:openCal('G',EM_S_DT_S)" />-
				<comment id="_NSID_"> <object 
				id=EM_E_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
				tabindex=1
				align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
				src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
				onclick="javascript:openCal('G',EM_E_DT_S)" /></td>	
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
		<tr>
          <td class="BD4A" width="100%">
            <iframe id="IFrame" name="OZSEARCH" width="100%" height="480" scrolling="no" style="overflow-y:hidden;" src=""></iframe>
          </td>		  
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
