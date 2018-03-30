<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > 사은품증정현황
 * 작 성 일 : 2010.04.18
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : psal6020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 사은품증정현황을 조회한다
 * 이    력 :
 *        2010.04.18 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir          = BaseProperty.get("context.common.dir");
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단
 /**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
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
    
    //화면로딩시 점콤보에 포커스
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2010-04-18
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_APP_S_DT   , "SYYYYMMDD"  , PK);    //조회 시작일
    initEmEdit(EM_APP_E_DT   , "TODAY"      , PK);    //조회 종료일

    initEmEdit(EM_EVENT_CD   , "CODE^11^0",  NORMAL);    //행사코드
    initEmEdit(EM_EVENT_NAME , "GEN^40"   ,  READ);      //행사명
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
    initComboStyle(LC_STR_CD  , DS_STR_CD , "CODE^0^40,NAME^0^80", 1, PK); //점(조회) 콤보
    
    getStore("DS_STR_CD", "Y", "", "N"); //점콤보 가져오기 ( gauce.js )      

    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';    // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : 사은품증정현황 MASTER 및 DETAIL 그리드 초기화 
 * return값 : void
*/
function gridCreate(){
    //MASTER 그리드
    var hdrProperies = '<C>id={currow}     width=30  align=center name="NO"</C>'
                     + '<C>id=SKU_NAME     width=90  align=left   name="구분" SumText="합계"</C>'
                     + '<G>name="사은품 증정대상매출"'
                     + '<C>id=TOT_SALE_AMT width=83  align=right  name="순매출" SumText=@sum</C>'
                     + '<C>id=RATIO1       width=83  align=right  name="매출비" value={Round(SALE_PRC/sum(TOT_SALE_AMT)*100,2)} DEC=2 SumText={sum(Round(SALE_PRC/sum(TOT_SALE_AMT)*100,2))}</C>'
                     + '<C>id=RATIO2       width=83  align=right  name="구성비" value={Round(TOT_SALE_AMT/sum(TOT_SALE_AMT)*100,2)} DEC=2 SumText={sum(Round(TOT_SALE_AMT/sum(TOT_SALE_AMT)*100,2))}</C>'
                     + '</G>'
                     + '<G>name="사은품지급현황"'
                     + '<C>id=PRSNT_QTY    width=83  align=right  name="수량" SumText=@sum</C>'
                     + '<C>id=SALE_PRC     width=83  align=right  name="사은품비용" SumText=@sum</C>'
                     + '<C>id=RATIO3       width=83  align=right  name="매출비" value={Round(PRSNT_AMT/sum(TOT_SALE_AMT)*100,2)} DEC=2 SumText={sum(Round(PRSNT_AMT/sum(TOT_SALE_AMT)*100,2))}</C>'
                     + '<C>id=RATIO4       width=83  align=right  name="증정율" value={Round(PRSNT_AMT/sum(PRSNT_AMT)*100,2)} DEC=2 SumText={sum(Round(PRSNT_AMT/sum(PRSNT_AMT)*100,2))}</C>'
                     + '<C>id=RATIO5       width=83  align=right  name="구성비" value={Round(SALE_PRC/sum(SALE_PRC)*100,2)} DEC=2 SumText={sum(Round(SALE_PRC/sum(SALE_PRC)*100,2))}</C>'
                     + '</G>'
                     + '<C>id=EVENT_CD     width=90  align=left   name="행사코드" show=false</C>'
                     ;
                     
    initGridStyle(GD_GIFT_PRST_MST, "common", hdrProperies, false);
    GD_GIFT_PRST_MST.ViewSummary = "1";
    
    //DETAIL 그리드
    var hdrProperies1 = '<C>id={currow}     width=30  align=center name="NO"</C>'
                      + '<C>id=PRSNT_FLAG   width=90  align=left   name="구분"</C>'
                      + '<G>name="사은품 증정대상매출"'
                      + '<C>id=TOT_SALE_AMT width=83  align=right  name="순매출" SumText=@sum</C>'
                      + '<C>id=RATIO1       width=83  align=right  name="매출비" value={Round(SALE_PRC/sum(TOT_SALE_AMT)*100,2)} DEC=2 SumText={sum(Round(SALE_PRC/sum(TOT_SALE_AMT)*100,2))}</C>'
                      + '<C>id=RATIO2       width=83  align=right  name="구성비" value={Round(TOT_SALE_AMT/sum(TOT_SALE_AMT)*100,2)} DEC=2 SumText={sum(Round(TOT_SALE_AMT/sum(TOT_SALE_AMT)*100,2))}</C>'
                      + '</G>'
                      + '<G>name="사은품지급현황"'
                      + '<C>id=PRSNT_QTY    width=83  align=right  name="수량" SumText=@sum</C>'
                      + '<C>id=SALE_PRC     width=83  align=right  name="사은품비용" SumText=@sum</C>'
                      + '<C>id=RATIO3       width=83  align=right  name="매출비" value={Round(PRSNT_AMT/sum(TOT_SALE_AMT)*100,2)} DEC=2 SumText={sum(Round(PRSNT_AMT/sum(TOT_SALE_AMT)*100,2))}</C>'
                      + '<C>id=RATIO4       width=83  align=right  name="증정율" value={Round(PRSNT_AMT/sum(PRSNT_AMT)*100,2)} DEC=2 SumText={sum(Round(PRSNT_AMT/sum(PRSNT_AMT)*100,2))}</C>'
                      + '<C>id=RATIO5       width=83  align=right  name="구성비" value={Round(SALE_PRC/sum(SALE_PRC)*100,2)} DEC=2 SumText={sum(Round(SALE_PRC/sum(SALE_PRC)*100,2))}</C>'
                      + '</G>'
                      ;
                     
    initGridStyle(GD_GIFT_PRST_DTL, "common", hdrProperies1, false);
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
 * 작 성 일 : 2010-04-18
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//1. validation
	if (isNull(LC_STR_CD.BindColVal)){
		showMessage(EXCLAMATION, OK, "USER-1002", "점"); //(점)은/는 반드시 선택해야 합니다.
		LC_STR_CD.Focus();
        return;
    }
	if (isNull(EM_APP_S_DT.text)){
		showMessage(EXCLAMATION, OK, "USER-1003", "기간"); //(기간)은/는 반드시 입력해야 합니다.
		EM_APP_S_DT.focus();
        return;
    }
	if (isNull(EM_APP_E_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간"); //(기간)은/는 반드시 입력해야 합니다.
        EM_APP_E_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_APP_S_DT.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "기간");//(기간)은/는 유효하지 않는 날짜입니다.
        EM_APP_S_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_APP_E_DT.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "기간");//(기간)은/는 유효하지 않는 날짜입니다.
        EM_APP_E_DT.focus();
        return;
    }
    if(EM_APP_S_DT.text > EM_APP_E_DT.text){
    	showMessage(EXCLAMATION, OK, "USER-1015"); //시작일은 종료일보다 작아야 합니다.
        EM_APP_S_DT.focus();
        return;
    }
    
    //2. 데이터셋 초기화
    DS_GIFT_PRST_MST.ClearData();
    DS_GIFT_PRST_DTL.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo       = "searchGiftPrstMst";
    
    var action     = "O";
    var parameters = "&strStoreCd=" + LC_STR_CD.BindColVal  //점구분코드
                   + "&strStartDt=" + EM_APP_S_DT.text      //기간 시작일 
                   + "&strEndDt="   + EM_APP_E_DT.text      //기간 종료일
                   + "&strEventCd=" + EM_EVENT_CD.text      //행사코드
                   ;
    DS_GIFT_PRST_MST.DataID = "/dps/psal602.ps?goTo="+goTo+parameters;
    DS_GIFT_PRST_MST.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : 상세정보  호출
 * return값 : void
*/
function subQuery(row){
    DS_GIFT_PRST_DTL.ClearData();
    var goTo       = "searchGiftPrstDtl";
    var action     = "O";
    
    var parameters = "&strStoreCd=" + DS_GIFT_PRST_MST.NameValue(row,"STR_CD")    //점코드
                   + "&strSkuCd="   + DS_GIFT_PRST_MST.NameValue(row,"SKU_CD")    //단품코드
                   + "&strStartDt=" + DS_GIFT_PRST_MST.NameValue(row,"START_DT")  //조회시작일
                   + "&strEndDt="   + DS_GIFT_PRST_MST.NameValue(row,"END_DT")    //조회종료일
                   + "&strEventCd=" + DS_GIFT_PRST_MST.NameValue(row,"EVENT_CD")    //이벤트코드
   
    DS_GIFT_PRST_DTL.DataID = "/dps/psal602.ps?goTo="+goTo+parameters;
    DS_GIFT_PRST_DTL.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-18
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * setEventCode()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-04
  * 개    요 : 행사코드
  * return값 : void
  */
 function setEventCode(evnflag){
     var codeObj = EM_EVENT_CD;
     var nameObj = EM_EVENT_NAME;
     var strCd = LC_STR_CD.BindColVal;

     
     if( codeObj.Text == "" && evnflag != "POP" ){
         nameObj.Text = "";
         bfEventCd = "";
         return;     
     }
     
     if( evnflag == "POP" ){
         eventPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','');
         codeObj.Focus();
     }else if( evnflag == "NAME" ){
         setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1,LC_STR_CD.BindColVal,'','','');
     }    

     bfEventCd = codeObj.Text;
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

<script language="javascript">
    var today    = new Date();

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

<script language=JavaScript for=DS_GIFT_PRST_MST event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_GIFT_PRST_MST.Focus();
</script>

<script language=JavaScript for=DS_GIFT_PRST_DTL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_GIFT_PRST_MST  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_GIFT_PRST_DTL  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_GIFT_PRST_MST event=OnRowPosChanged(row)>
     if (DS_GIFT_PRST_MST.CountRow >0 && row>0) {
         subQuery(row);
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_GIFT_PRST_MST event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_GIFT_PRST_DTL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"        classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]사은품증정현황 MASTER -->
    <object id="DS_GIFT_PRST_MST" classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]사은품증정현황 DETAIL -->
    <object id="DS_GIFT_PRST_DTL" classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80" class="point">점</th>
            <td width="120">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=120 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script></td>
            <th width="80" class="point">기간</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_APP_S_DT)" align="absmiddle" />
              ~ 
              <comment id="_NSID_">
                <object id=EM_APP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_APP_E_DT)" align="absmiddle" />
            </td>
          </tr>
          
          <tr>
             <th>행사코드</th>
             <td colspan="3">
                 <comment id="_NSID_">
                 <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                 </comment><script> _ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP');"  align="absmiddle" />
                 <comment id="_NSID_">
                 <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=109 tabindex=1 align="absmiddle"></object>
                 </comment><script> _ws_(_NSID_);</script>
             </td>
          
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_GIFT_PRST_MST width="100%" height=291 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_GIFT_PRST_MST">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_GIFT_PRST_DTL width="100%" height=175 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_GIFT_PRST_DTL">
                </object></comment><script>_ws_(_NSID_);</script>
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
</body>
</html>

