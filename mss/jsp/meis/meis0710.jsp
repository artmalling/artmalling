<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 경영실적 조회 및 확정
 * 작 성 일 : 2011.06.20
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0710.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 생성된 경영실적을 조회하고 확정한다.
 * 이    력 :
 *        2011.06.20 (이정식) 신규작성
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
    String strYm      = Date2.addMonth(-1);
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
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
    
    EM_RSLT_YM.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0710","DS_STORE" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-20
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	 initEmEdit(EM_RSLT_YM, "YYYYMM", PK); //경영실적년월
	 EM_RSLT_YM.Text = "<%=strYm%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	 initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, NORMAL);   //점(조회)
	 initComboStyle(LC_CONFIRM,  DS_CONFIRM, "CODE^0^30,NAME^0^90", 1, NORMAL); //확정구분(조회)
	 
	 getStore("DS_STR_CD", "N", "", "Y");        //점콤보 가져오기 ( gauce.js )  
	 getEtcCode("DS_CONFIRM", "D", "P076", "Y"); //확정구분 데이터가져오기 ( gauce.js )
	 getEtcCode("DS_ORG_FLAG", "D", "P047", "N"); //조직구분콤보 데이터가져오기 ( gauce.js )
	 
	 LC_STR_CD.Index= 0;
	 LC_CONFIRM.Index= 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow}   width=25  align=center name="NO"</C>'
                     + '<C>id=CHECK_FLAG width=20  align=center name="" EditStyle=checkbox HeadCheck=false HeadCheckShow=true</C>'
                     + '<C>id=STR_NM     width=70  align=left   name="점명" edit="None"</C>'
                     + '<C>id=CONF_YN    width=55  align=center name="확정여부" edit="None" EditStyle=Lookup data="DS_CONFIRM:CODE:NAME"</C>'
                     ;

    initGridStyle(GD_STORE, "common", hdrProperies, true);
    
    var hdrProperies1 = '<C>id={currow}   width=30  align=center name="NO"</C>'
                      + '<C>id=BIZ_CD     width=65  align=center name="항목코드" SumText="합계"</C>'
                      + '<C>id=BIZ_CD_NM  width=90  align=left   name="항목명"</C>'
                      + '<C>id=RSLT_AMT   width=120 align=right  name="실적금액" SumText=@sum</C>'
                      + '<C>id=SUM_AMT    width=120 align=right  name="년누계금액" SumText=@sum</C>'
                      ;

    initGridStyle(GD_BIZ_CD, "common", hdrProperies1, false);
    GD_BIZ_CD.ViewSummary = "1";
    
    var hdrProperies2 = '<FC>id={currow}  width=35  align=center name="NO"</FC>'
    	              + '<FC>id=ORG_FLAG  width=80  align=center name="조직구분" EditStyle=Lookup data="DS_ORG_FLAG:CODE:NAME"</FC>'
                      + '<FC>id=ORG_CD    width=80  align=center name="조직코드" SumText="합계"</FC>'
                      + '<FC>id=ORG_NAME  width=90  align=left   name="조직명"</FC>'
                      + '<C>id=RSLT_AMT   width=100 align=right  name="실적금액" SumText=@sum</C>'
                      + '<C>id=SUM_AMT    width=100 align=right  name="년누계금액" SumText=@sum</C>'
                      ;

    initGridStyle(GD_ORG, "common", hdrProperies2, false);
    GD_ORG.ViewSummary = "1";
    
    var hdrProperies3 = '<C>id=MONTH    width=35 align=center name="월"   SumText="합계"</C>'
                      + '<C>id=RSLT_AMT width=75 align=right  name="금액" SumText=@sum</C>'
                      ;

    initGridStyle(GD_MONTH, "common", hdrProperies3, false);
    GD_MONTH.ViewSummary = "1";
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
 * 작 성 일 : 2011-06-20
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(DS_STORE.IsUpdated){
        //변경내역이 있습니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1){
            EM_RSLT_YM.Focus();
            return false;
        }
    }
	
	//1. validation
    if (isNull(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영실적년월"); //(경영실적년월)은/는 반드시 입력해야 합니다.
        EM_RSLT_YM.focus();
        return;
    }
	
    if (!checkYYYYMM(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "경영실적년월");//(경영실적년월)은/는 유효하지 않는 날짜입니다.
        EM_RSLT_YM.focus();
        return;
    }
    
    //2. 데이터셋 초기화
    DS_STORE.ClearData();
    DS_BIZ_CD.ClearData();
    DS_ORG.ClearData();
    DS_MONTH.ClearData();
    
    //헤더체크초기화
    GD_STORE.ColumnProp('CHECK_FLAG','HeadCheck') = false;
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo          = "searchStore";
    var action        = "O";
    var parameters    = "&strStrCd="   + LC_STR_CD.BindColVal
                      + "&strYm="    + EM_RSLT_YM.text
                      + "&strConfirm=" + LC_CONFIRM.BindColVal;
    DS_STORE.DataID   = "/mss/meis071.me?goTo="+goTo+parameters;
    DS_STORE.SyncLoad = "true";
    DS_STORE.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 항목별
 * return값 : void
 */
function subQuery(row){
    //2. 데이터셋 초기화
	DS_BIZ_CD.ClearData();
    DS_ORG.ClearData();
    DS_MONTH.ClearData();
	    
    //3. 조회시작
    var goTo           = "searchBizCd";
    var action         = "O";
    var parameters     = "&strStrCd="   + DS_STORE.NameValue(row, "STR_CD")
                       + "&strYm="    + DS_STORE.NameValue(row, "BIZ_RSLT_YM");
    DS_BIZ_CD.DataID   = "/mss/meis071.me?goTo="+goTo+parameters;
    DS_BIZ_CD.SyncLoad = "true";
    DS_BIZ_CD.Reset();
}

/**
 * subQuery1()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 2차배분안 정보 조회
 * return값 : void
 */
function subQuery1(row){
    //2. 데이터셋 초기화
    DS_ORG.ClearData();
    DS_MONTH.ClearData();
        
    //3. 조회시작
    var goTo        = "searchOrg";
    var action      = "O";
    var parameters  = "&strStrCd="   + DS_BIZ_CD.NameValue(row, "STR_CD")
                    + "&strYm="    + DS_BIZ_CD.NameValue(row, "BIZ_RSLT_YM")
                    + "&strBizCd="   + DS_BIZ_CD.NameValue(row, "BIZ_CD");
    DS_ORG.DataID   = "/mss/meis071.me?goTo="+goTo+parameters;
    DS_ORG.SyncLoad = "true";
    DS_ORG.Reset();
}

/**
 * subQuery2()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 3차배분안 정보 조회
 * return값 : void
 */
function subQuery2(row){
    //2. 데이터셋 초기화
    DS_MONTH.ClearData();
    
    //3. 조회시작
    var goTo          = "searchMonth";
    var action        = "O";
    var parameters    = "&strStrCd="   + DS_ORG.NameValue(row, "STR_CD")
                      + "&strYm="    + DS_ORG.NameValue(row, "BIZ_RSLT_YM")
                      + "&strBizCd="   + DS_ORG.NameValue(row, "BIZ_CD")
                      + "&strOrgCd="   + DS_ORG.NameValue(row, "ORG_CD");
    DS_MONTH.DataID   = "/mss/meis071.me?goTo="+goTo+parameters;
    DS_MONTH.SyncLoad = "true";
    DS_MONTH.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
	if (!DS_STORE.IsUpdated){
        //확정할 데이터를 선택하세요
        showMessage(INFORMATION, OK, "USER-1090");
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
        return;
    }

    TR_MAIN.Action   = "/mss/meis071.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_STORE=DS_STORE)"; 
    TR_MAIN.Post();
    
    btn_Search();
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
<script language=JavaScript for=DS_STORE event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_STORE.Focus();
</script>

<script language=JavaScript for=DS_BIZ_CD event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_ORG event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_MONTH event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_STORE  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_BIZ_CD  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_ORG  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_MONTH  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_STORE event=OnRowPosChanged(row)>
    if (this.CountRow >0 && row>0) {
    	subQuery(row);
    }
</script>

<script language=JavaScript for=DS_BIZ_CD event=OnRowPosChanged(row)>
    if (this.CountRow >0 && row>0) {
    	subQuery1(row);
    }
</script>

<script language=JavaScript for=DS_ORG event=OnRowPosChanged(row)>
	if (this.CountRow >0 && row>0) {
	    subQuery2(row);
	}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_STORE event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_BIZ_CD event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_ORG event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_MONTH event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_STORE event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_STORE.CountRow; i++) DS_STORE.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_STORE.CountRow; i++) DS_STORE.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
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
    <!--[그리드]점별 -->
    <object id="DS_STORE"     classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]항목코드별 -->
    <object id="DS_BIZ_CD"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]조직별 -->
    <object id="DS_ORG"       classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]월별 -->
    <object id="DS_MONTH"     classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드콤보]조직구분 -->
    <object id="DS_ORG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]점-->
    <object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]점-->
    <object id="DS_CONFIRM"   classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80">점코드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">경영실적년월</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
            </td>
            <th width="80">확정구분</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_CONFIRM classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
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
        <td width="208"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_STORE width="100%" height=502 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_STORE">
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
                      <comment id="_NSID_"><object id=GD_BIZ_CD width="100%" height=265 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_BIZ_CD">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr >
            <td class="PT10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_ORG width="100%" height=223 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_ORG">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="130" class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_MONTH width="100%" height=502 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_MONTH">
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
