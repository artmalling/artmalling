<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 기준정보> 경영실적항목조회
 * 작 성 일 : 2011.05.11
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영실적항목을 조회한다.
 * 이    력 :
 *        2011.05.11 (이정식) 신규작성
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
var lo_LCd   = "";
var lo_MCd   = "";
var lo_SCd   = "";
var lo_RptYn = "";
var lo_UseYn = "";
var lo_BizCd = "";
var lo_LNm   = "";
var lo_MNm   = "";
var lo_SNm   = "";
var lo_RptNm = "";
var lo_UseNm = "";
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
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
 * 작 성 일 :  2011-05-11
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_BIZ_CD, "CODE^6", NORMAL);//실적항목코드
    initEmEdit(EM_BIZ_NM, "GEN^60", READ);  //실적항목명
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	 initComboStyle(LC_BIZL_CD,  DS_BIZL_CD,  "CODE^0^30,NAME^0^90",  1, NORMAL); //대분류콤보초기화(조회)
	 initComboStyle(LC_BIZM_CD,  DS_BIZM_CD,  "CODE^0^30,NAME^0^90",  1, NORMAL); //중분류콤보초기화(조회)
	 initComboStyle(LC_BIZS_CD,  DS_BIZS_CD,  "CODE^0^30,NAME^0^90",  1, NORMAL); //소분류콤보초기화(조회)
     initComboStyle(LC_RPT_YN,   DS_RPT_YN,   "CODE^0^30,NAME^0^110", 1, NORMAL); //보고서사용콤보초기화
     initComboStyle(LC_USE_YN,   DS_USE_YN,   "CODE^0^30,NAME^0^110", 1, NORMAL); //사용여부콤보초기화
	 
	 getBizCdCombo(DS_BIZL_CD, "1", "Y");         //대분류콤보 데이터가져오기 ( gauce.js )
	 getEtcCode("DS_RPT_YN",   "D", "P091", "Y"); //보고서사용콤보 데이터가져오기 ( gauce.js )
	 getEtcCode("DS_USE_YN",   "D", "P091", "Y"); //사용여부콤보 데이터가져오기 ( gauce.js )
	 getEtcCode("DS_ACC_FLAG", "D", "M092", "N"); //계정/예산항목 구분콤보 데이터가져오기 ( gauce.js )

	 LC_BIZL_CD.Index = 0;
	 LC_RPT_YN.Index  = 0;
	 LC_USE_YN.Index  = 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow}     width=35  align=center name="NO"</C>'
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
                     + '<C>id=PRT_SEQ      width=60  align=right  name="출력순서"</C>'
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
 * 작 성 일 : 2011-05-11
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//2. 데이터셋 초기화
    DS_BIZ_MST.ClearData();
    DS_BIZ_DTL.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo       = "searchBizMst";
    var action     = "O";
    lo_LCd   = LC_BIZL_CD.BindColVal;
    lo_MCd   = LC_BIZM_CD.BindColVal;
    lo_SCd   = LC_BIZS_CD.BindColVal;
    lo_RptYn = LC_RPT_YN.BindColVal;
    lo_UseYn = LC_USE_YN.BindColVal;
    lo_BizCd = EM_BIZ_CD.text;
    lo_LNm   = LC_BIZL_CD.Text;
    lo_MNm   = LC_BIZM_CD.Text;
    lo_SNm   = LC_BIZS_CD.Text;
    lo_RptNm = LC_RPT_YN.Text;
    lo_UseNm = LC_USE_YN.Text;
    
    var parameters = "&strLCd="   + lo_LCd   //대분류코드
                   + "&strMCd="   + lo_MCd   //중분류코드
                   + "&strSCd="   + lo_SCd   //소분류코드
                   + "&strRptYN=" + lo_RptYn //보고서사용구분
                   + "&strUseYn=" + lo_UseYn //사용여부
                   + "&strBizCd=" + lo_BizCd //항목코드
                   ;
    
    DS_BIZ_MST.DataID = "/mss/meis003.me?goTo="+goTo+parameters;
    DS_BIZ_MST.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
	DS_BIZ_DTL.ClearData();
    var goTo          = "searchBizDtl";
    var action        = "O";
    var parameters    = "&strBizCd=" + DS_BIZ_MST.NameValue(row,"BIZ_CD"); //항목코드
   
    DS_BIZ_DTL.DataID = "/mss/meis003.me?goTo="+goTo+parameters;
    DS_BIZ_DTL.Reset();	 
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
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
    var parameters = "&strLCd="   + lo_LCd   //대분류코드
                   + "&strMCd="   + lo_MCd   //중분류코드
                   + "&strSCd="   + lo_SCd   //소분류코드
                   + "&strRptYN=" + lo_RptYn //보고서사용구분
                   + "&strUseYn=" + lo_UseYn //사용여부
                   + "&strBizCd=" + lo_BizCd //항목코드
                   ;

    DS_EXCEL.DataID = "/mss/meis003.me?goTo="+goTo+parameters;
    DS_EXCEL.Reset();
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * setBizCdNm()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-11
 * 개    요 : 항목코드POPUP/항목코드/명을 조회한다.
 * return값 : void
 */
function setBizCdNm(evnflag){     
    var codeObj     = EM_BIZ_CD;
    var nameObj     = EM_BIZ_NM;
     
    var result = null;
    DS_SEARCH_NM.ClearData();
    
    if( evnflag == "POP" ){
        result = getBizPop(codeObj,nameObj);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
    	getBizNonPop("DS_SEARCH_NM", codeObj, nameObj);
    }

    if( result != null || DS_SEARCH_NM.CountRow > 0) return;
    
    if(nameObj.Text == "") codeObj.Text = "";
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
    if (lo_BizCd == "") lo_BizCd = "전체";

    var parameters = "대분류="           + lo_LNm
                   + " -중분류="         + lo_MNm
                   + " -소분류="         + lo_SNm
                   + " -보고서사용구분=" + lo_RptNm
                   + " -사용여부="       + lo_UseNm
                   + " -항목코드="       + lo_BizCd;
    
    var ExcelTitle = "경영실적항목조회";

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
<script language=JavaScript for=LC_BIZL_CD event=OnSelChange()>
    DS_BIZM_CD.ClearData();
    DS_BIZS_CD.ClearData();
    getBizCdCombo(DS_BIZM_CD, "2", "Y", this.BindColVal) //중분류콤보 가져오기 ( gauce.js )
    LC_BIZM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_BIZM_CD event=OnSelChange()>
    DS_BIZS_CD.ClearData();
    getBizCdCombo(DS_BIZS_CD, "3", "Y", LC_BIZL_CD.BindColVal, this.BindColVal) //소분류콤보 가져오기 ( gauce.js )
    LC_BIZS_CD.Index = 0;
</script>

<script language=JavaScript for=GD_BIZ_MST event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_BIZ_DTL event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 항목코드(조회) -->
<script language=JavaScript for=EM_BIZ_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(this.text==''){
    	EM_BIZ_NM.Text = "";
        return;
    }

    setBizCdNm("NAME");
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
    <!--[콤보]대분류(조회) -->
    <object id="DS_BIZL_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]중분류(조회) -->
    <object id="DS_BIZM_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]소분류(조회) -->
    <object id="DS_BIZS_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]보고서사용 -->
    <object id="DS_RPT_YN"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]사용여부 -->
    <object id="DS_USE_YN"    classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80">대분류</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_BIZL_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">중분류</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_BIZM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">소분류</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_BIZS_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>보고서사용구분</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_RPT_YN classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>사용여부</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>항목코드</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_BIZ_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setBizCdNm('POP')"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_BIZ_NM classid=<%=Util.CLSID_EMEDIT%> width=79  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
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
                <comment id="_NSID_"><object id=GD_BIZ_MST width="100%" height=231 classid=<%=Util.CLSID_GRID%>>
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
