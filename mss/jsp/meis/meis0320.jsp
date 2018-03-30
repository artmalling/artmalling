<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영계획> 경영계획배부이력조회
 * 작 성 일 : 2011.08.09
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0320.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영계획의 조직별 실적항목의 배부 금액의 이력을 조회한다.
 * 이    력 :
 *        2011.08.09 (이정식) 신규작성
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
    String strYm      = Date2.getYear() + Date2.getMonth();
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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단 
var lo_tabIdx       = 1;
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화

    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    initTab("TB_NORMAL");    
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-08-09
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_PLAN_YM, "YYYYMM", PK); //계획년월
    EM_PLAN_YM.Text = "<%=strYm%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	initComboStyle(LC_STR_CD  , DS_STR_CD , "CODE^0^30,NAME^0^80", 1, PK); //점(조회) 콤보
    initComboStyle(LC_DEPT_CD , DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //팀(조회) 콤보
    initComboStyle(LC_TEAM_CD , DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //파트(조회) 콤보
    initComboStyle(LC_PC_CD   , DS_PC_CD  , "CODE^0^30,NAME^0^80", 1, NORMAL); //PC(조회) 콤보
    initComboStyle(LC_ORG_LVL , DS_ORG_LVL, "CODE^0^20,NAME^0^40", 1, NORMAL); //조직레벨
    
    getStore("DS_STR_CD", "N", "", "N");                                                                  //점콤보 가져오기 ( gauce.js )      
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                                //팀콤보 가져오기 ( gauce.js )
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                         //파트콤보 가져오기 ( gauce.js )
    getPc("DS_PC_CD"    , "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y"); //PC콤보 가져오기 ( gauce.js )
    getEtcCode("DS_ORG_LVL", "D", "P048", "Y");    

    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';    // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    DS_ORG_LVL.DeleteRow(DS_ORG_LVL.CountRow);
    LC_ORG_LVL.Index = 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow} width=25  align=center name="NO"</C>'
		             + '<C>id=ORG_CD   width=80  align=center name="조직코드"</C>'
                     + '<C>id=ORG_NAME width=90  align=left   name="조직명"</C>'
                     ;

    initGridStyle(GD_ORG, "common", hdrProperies, false);
    
    var hdrProperies1 = '<C>id={currow}  width=25  align=center name="NO"</C>'
                      + '<C>id=BIZ_CD    width=75  align=center name="항목코드"</C>'
                      + '<C>id=BIZ_CD_NM width=80  align=left   name="항목명"</C>'
                      + '<C>id=TOT_AMT   width=90  align=right  name="합계금액"</C>'
                      + '<C>id=PLAN_AMT  width=90  align=right  name="계획금액"</C>'
                      + '<C>id=RECV_AMT  width=90  align=right  name="배부받은금액"</C>'
                      + '<C>id=DIV_AMT   width=90  align=right  name="배부금액"</C>'
                      ;

    initGridStyle(GD_BIZ, "common", hdrProperies1, false);
    
    var hdrProperies2 = '<FC>id={currow}    width=25  align=center name="NO"</FC>'
    	              + '<FC>id=STR_CD      width=40  align=center name="점코드"</FC>'
                      + '<FC>id=STR_NAME    width=80  align=center name="점명"</FC>'
                      + '<FC>id=ORG_CD      width=80  align=center name="조직코드"</FC>'
                      + '<FC>id=ORG_NAME    width=95  align=left   name="조직명" SumText="합계"</FC>'
                      + '<FC>id=BIZ_CD      width=75  align=center name="항목코드"</FC>'
                      + '<FC>id=BIZ_CD_NM   width=90  align=left   name="항목명"</FC>'
                      + '<C>id=DIV_SEQ      width=80  align=center name="배부기준차수"</C>'
                      + '<C>id=DIV_CD       width=85  align=center name="배부기준코드"</C>'
                      + '<C>id=DIV_CD_NM    width=95  align=left   name="배부기준코드명"</C>'
                      + '<C>id=DIV_RECV_AMT width=90  align=right  name="배부받은금액" SumText=@sum</C>'
                      ;
  
    initGridStyle(GD_RECV, "common", hdrProperies2, false);
    GD_RECV.ViewSummary = "1";
    
    var hdrProperies3 = '<FC>id={currow}    width=25  align=center name="NO"</FC>'
    	              + '<FC>id=STR_CD      width=40  align=center name="점코드"</FC>'
                      + '<FC>id=STR_NAME    width=80  align=center name="점명"</FC>'
                      + '<FC>id=ORG_CD      width=80  align=center name="조직코드"</FC>'
    	              + '<FC>id=ORG_NAME    width=95  align=left   name="조직명" SumText="합계"</FC>'
    	              + '<FC>id=BIZ_CD      width=75  align=center name="항목코드"</FC>'
    	              + '<FC>id=BIZ_CD_NM   width=90  align=left   name="항목명"</FC>'
    	              + '<C>id=DIV_SEQ      width=80  align=center name="배부기준차수"</C>'
    	              + '<C>id=DIV_CD       width=85  align=center name="배부기준코드"</C>'
    	              + '<C>id=DIV_CD_NM    width=95  align=left   name="배부기준코드명"</C>'
    	              + '<C>id=DIV_RATE     width=70  align=right  name="배부율"</C>'
    	              + '<C>id=DIV_RECV_AMT width=90  align=right  name="배부금액" SumText=@sum</C>'
    	              ;

    initGridStyle(GD_DIV, "common", hdrProperies3, false);
    GD_DIV.ViewSummary = "1";

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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//1. validation
    if (isNull(EM_PLAN_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "계획년월"); //(계획년월)은/는 반드시 입력해야 합니다.
        EM_PLAN_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_PLAN_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "계획년월");//(계획년월)은/는 유효하지 않는 날짜입니다.
        EM_PLAN_YM.focus();
        return;
    }

	//2. 데이터셋 초기화
    DS_BIZ.ClearData();
    DS_HIS.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo       = "searchOrg";

    var parameters = "&strPlanYm=" + EM_PLAN_YM.text       //계획년월
                   + "&strOrgLvl=" + LC_ORG_LVL.BindColVal //조직레벨
                   + "&strStrCd="  + LC_STR_CD.BindColVal  //점코드
                   + "&strDeptCd=" + LC_DEPT_CD.BindColVal //팀코드
                   + "&strTeamCd=" + LC_TEAM_CD.BindColVal //파트코드
                   + "&strPcCd="   + LC_PC_CD.BindColVal   //PC코드
                   ;
    DS_ORG.DataID = "/mss/meis032.me?goTo="+goTo+parameters;
    DS_ORG.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
	DS_BIZ.ClearData();
    var goTo          = "searchBiz";
    var parameters    = "&strStrCd="  + DS_ORG.NameValue(row,"STR_CD")
                      + "&strPlanYm=" + DS_ORG.NameValue(row,"BIZ_PLAN_YM")
                      + "&strOrgCd="  + DS_ORG.NameValue(row,"ORG_CD");
   
    DS_BIZ.DataID = "/mss/meis032.me?goTo="+goTo+parameters;
    DS_BIZ.Reset();	 
}

/**
 * subQuery2()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 
 * return값 : void
 */
function subQuery2(row){
 	var divFlag = "1";
 	if(lo_tabIdx != 1 ) {
 		divFlag = "2";
 	}
 	
 	var parameters = "&strPlanYm=" + DS_BIZ.NameValue(row,"BIZ_PLAN_YM")
                   + "&strStrCd="  + DS_BIZ.NameValue(row,"STR_CD")
                   + "&strOrgCd="  + DS_BIZ.NameValue(row,"ORG_CD")
                   + "&strBizCd="  + DS_BIZ.NameValue(row,"BIZ_CD")
                   + "&strFlag="   + divFlag
                   ;
 	var goTo       = "searchHis" ;
 	
 	DS_HIS.ClearData();
 	DS_HIS.DataID   = "/mss/meis032.me?goTo="+goTo+parameters;
 	DS_HIS.SyncLoad = "true";
 	DS_HIS.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-09
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * fn_changeTab()
  * 작 성 자 : 이정식
  * 작 성 일 : 2011-08-09
  * 개    요 : 탭변경시 호출
  * return값 : void
  */ 
 function fn_changeTab(tabId, tabIdx) {
     lo_tabIdx = tabIdx;
     
     if (DS_BIZ.CountRow >0 && DS_BIZ.RowPosition>0) {
         subQuery2(DS_BIZ.RowPosition);
     }
 }
 
 /**
  * fn_getOrg()
  * 작 성 자 : 최재형
  * 작 성 일 : 2011-07-01
  * 개    요 : 조직조회
  * return값 : void
  */ 
function fn_getOrg(dataSet, strAllGb, strStrCd, strDeptCd, strTeamCd, strPcCd, strOrgLevel) {
		
	var goTo = "getOrg";
	var parameters  = "&strAllGb=" +  strAllGb;
		parameters += "&strStrCd=" +  strStrCd;
		parameters += "&strDeptCd=" +  strDeptCd;
		parameters += "&strTeamCd=" +  strTeamCd;
		parameters += "&strPcCd=" +  strPcCd;
		parameters += "&strOrgLevel=" +  strOrgLevel;
		
	dataSet.DataID   = "/mss/meis043.me?goTo="+goTo+parameters;
	dataSet.SyncLoad = "true";
	dataSet.Reset();
		
}  
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
<script language=JavaScript for=DS_ORG event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
</script>

<script language=JavaScript for=DS_BIZ event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>

<script language=JavaScript for=DS_HIS event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_ORG  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_BIZ  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_HIS  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_ORG event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         subQuery(row);
     }
</script>

<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_BIZ event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         subQuery2(row);
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    //getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                           // 팀 
    //getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                    // 파트  
    //getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y"); // PC
    
    fn_getOrg(DS_DEPT_CD, "Y", LC_STR_CD.BindColVal, "%", "%", "%", "2");
    
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
        //getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y"); // 파트
        fn_getOrg(DS_TEAM_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "%", "%", "3");
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
        //getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y"); // PC  
    	fn_getOrg(DS_PC_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "%", "4");
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
    <object id="DS_ORG"           classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_BIZ"           classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_HIS"           classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"        classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]팀구분 -->
    <object id="DS_DEPT_CD"       classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]파트구분 -->
    <object id="DS_TEAM_CD"       classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]PC구분 -->
    <object id="DS_PC_CD"         classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]조직레벨 -->
    <object id="DS_ORG_LVL"       classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_SEARCH_NM"   classid=<%= Util.CLSID_DATASET %>></object>
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
            <th>계획년월</th>
            <td colspan=3>
              <comment id="_NSID_">
                <object id=EM_PLAN_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_PLAN_YM)" align="absmiddle" />
            </td>
            <th>조직레벨</th>
            <td colspan=3>
              <comment id="_NSID_">
                <object id=LC_ORG_LVL classid=<%= Util.CLSID_LUXECOMBO %> width=110 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="70" class="point">점</th>
            <td width="130">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script></td>
            <th width="70" class="point">팀</th>
            <td width="130">
              <comment id="_NSID_">
                <object id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70" >파트</th>
            <td width="130">
              <comment id="_NSID_">
                <object id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">PC</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
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
        <td width="235"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_ORG width="100%" height=231 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_ORG">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_BIZ width="100%" height=231 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_BIZ">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT05 PB03">
      <div id=TB_NORMAL width="100%" height=242 TitleWidth=120 TitleAlign="center" TitleStyle="" TitleGap=3>
        <menu TitleName="배부받은이력" DivId="tr_tab1" ClickFunc="fn_changeTab" />
        <menu TitleName="배부이력"     DivId="tr_tab2" ClickFunc="fn_changeTab" />
      </div>             
    </td>
  </tr>
  <tr>
    <td>
      <div id="tr_tab1" class="PT03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td width="60%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          <tr>
                            <td>
                              <comment id="_NSID_"><object id=GD_RECV width="100%" height=207 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_HIS">
                              </object></comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <div id="tr_tab2" class="PT03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td width="60%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          <tr>
                            <td>
                              <comment id="_NSID_"><object id=GD_DIV width="100%" height=207 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_HIS">
                              </object></comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
  <object id=GD_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
