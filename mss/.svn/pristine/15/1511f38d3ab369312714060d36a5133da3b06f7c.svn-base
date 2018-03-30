<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 기초자료> 경영계획지침조회
 * 작 성 일 : 2011.05.20
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0250.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 년월별 경영계획 지침을 조회한다.
 * 이    력 :
 *        2011.05.20 (이정식) 신규작성
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
var lo_PlanYm    = "";
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
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
    
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-05-20
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_PLAN_YM, "THISMN", PK);
	lo_PlanYm = EM_PLAN_YM.text;
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	 getEtcCode("DS_ACC_FLAG", "D", "M092", "N"); //계정/예산항목 구분콤보 데이터가져오기 ( gauce.js )
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow}     width=35  align=center name="NO"</C>'
		             + '<C>id=PRT_SEQ      width=60  align=right  name="출력순서"</C>'
                     + '<C>id=BIZ_CD       width=65  align=center name="항목코드"</C>'
                     + '<C>id=BIZ_CD_NM    width=80  align=left   name="항목명" </C>'
                     + '<C>id=BIZ_CD_LEVEL width=60  align=center name="항목레벨" </C>'
                     + '<G> name="대분류"'
                     + '<C>id=BIZ_L_CD     width=45  align=center name="코드"</C>'
                     + '<C>id=BIZ_L_NM     width=80  align=left   name="명" </C>'
                     + '</G>'
                     + '<G> name="중분류"'
                     + '<C>id=BIZ_M_CD     width=45  align=center name="코드"</C>'
                     + '<C>id=BIZ_M_NM     width=80  align=left   name="명" </C>'
                     + '</G>'
                     + '<G> name="소분류"'
                     + '<C>id=BIZ_S_CD     width=45  align=center name="코드"</C>'
                     + '<C>id=BIZ_S_NM     width=80  align=left   name="명" </C>'
                     + '</G>'
                     + '<C>id=RPT_YN       width=55  align=center name="보고서;사용구분"</C>'
                     + '<C>id=USE_YN       width=55  align=center name="사용여부"</C>'
                     ;

    initGridStyle(GD_BIZ_MST, "common", hdrProperies, false);

	var hdrProperies1 = '<C>id={currow}  width=35  align=center name="NO"</C>'
                      + '<C>id=ACC_FLAG  width=100 align=center name="계정/예산구분" EditStyle=Lookup data="DS_ACC_FLAG:CODE:NAME"</C>'
                      + '<C>id=ACC_CD    width=110 align=center name="계정/예산항목" </C>'
                      + '<C>id=ACC_CD_NM width=200 align=left   name="항목명" </C>'
                      ;
        
    initGridStyle(GD_BIZ_DTL, "common", hdrProperies1, false);
    
    var hdrProperies2 = hdrProperies
                      + '<C>id=ACC_FLAG  width=100 align=center name="계정/예산구분" EditStyle=Lookup data="DS_ACC_FLAG:CODE:NAME"</C>'
                      + '<C>id=ACC_CD    width=110 align=center name="계정/예산항목" </C>'
                      + '<C>id=ACC_CD_NM width=200 align=left   name="항목명" </C>'
                      ;
    
    initGridStyle(GD_EXCEL, "common", hdrProperies2, false);
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
 * 작 성 일 : 2011-05-20
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//2. 데이터셋 초기화
    DS_BIZ_MST.ClearData();
    DS_BIZ_DTL.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo    = "searchBizMst";
    var action  = "O";
    lo_PlanYm   = EM_PLAN_YM.text;
    
    var parameters = "&strPlanYm=" + lo_PlanYm;
    
    DS_BIZ_MST.DataID = "/mss/meis025.me?goTo="+goTo+parameters;
    DS_BIZ_MST.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
	DS_BIZ_DTL.ClearData();
    var goTo          = "searchBizDtl";
    var action        = "O";
    var parameters    = "&strBizCd="  + DS_BIZ_MST.NameValue(row,"BIZ_CD")
                      + "&strPlanYm=" + lo_PlanYm;
   
    DS_BIZ_DTL.DataID = "/mss/meis025.me?goTo="+goTo+parameters;
    DS_BIZ_DTL.Reset();	 
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if(DS_BIZ_MST.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
	
    DS_EXCEL.ClearData();
    var goTo       = "getExcelData";
    var action     = "O";
    var parameters = "&strPlanYm=" + lo_PlanYm;

    DS_EXCEL.DataID = "/mss/meis025.me?goTo="+goTo+parameters;
    DS_EXCEL.Reset();
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-20
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
<script language=JavaScript for=DS_BIZ_MST event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_BIZ_MST.Focus();
</script>

<script language=JavaScript for=DS_BIZ_DTL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>

<script language=JavaScript for=DS_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    //엑셀출력

    var parameters = "경영계획년월=" + lo_PlanYm;
    
    var ExcelTitle = "경영계획지침조회";

    openExcel2(GD_EXCEL, ExcelTitle, parameters, true );
    
    GD_BIZ_MST.Focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_BIZ_MST  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_BIZ_DTL  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_EXCEL  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_BIZ_MST event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         subQuery(row);
     }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_BIZ_MST event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
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
    <!--[그리드]경영실적항목 Master데이터 -->
    <object id="DS_BIZ_MST"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]경영실적항목 Detail데이터 -->
    <object id="DS_BIZ_DTL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]계정/예산항목 구분코드 -->
    <object id="DS_ACC_FLAG"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--엑셀-->
    <object id="DS_EXCEL"     classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80" class="point">경영계획년월</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_PLAN_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this);" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_PLAN_YM)" align="absmiddle" />
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>실적항목정보</td>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_BIZ_MST width="100%" height=255 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_BIZ_MST">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>계정/예산항목정보</td>
  <tr>
    <td class="PT01 PB03" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_">
                  <object id=GD_BIZ_DTL width="100%" height=210 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_BIZ_DTL">
                  </object>
                </comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
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
