<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품지급정산 > 사은행사 정산관리 상세(pop-up)
 * 작 성 일 : 2011.03.15
 * 작 성 자 : 김성미
 * 수 정 자 : 
 * 파 일 명 : MCAE6011.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 정산자료의 협력사별 정산 상세 자료조회
 * 이    력 :
 *        2011.01.18 (김성미) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>물품정산 상세</title>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strStrCd       = dialogArguments[0];
 var strEventCd     = dialogArguments[1];
 var strVenCd       = dialogArguments[2];
/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
     gridCreate();
     // 상세내역 조회
     btn_Search();
     
}

function gridCreate(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                    + '<FC>id=SKU_NAME    name="사은품명"   sumtext="합계"    width=110  align=left</FC>'
                    + '<FC>id=BUY_COST_PRC    name="단가"     width=80   align=right</FC>'
                    + '<FC>id=IN_AMT    name="입고"  sumtext="@sum"   width=80   align=right</FC>'
                    + '<FC>id=RFD_AMT    name="반품"  sumtext="@sum"   width=80   align=right</FC>'
                    + '<FG>id=PRSNT_AMT    name="지급"       width=80  align=center'
                    + '<FC>id=PRSNT_AMT    name="정상지급"  sumtext="@sum"     width=80  align=right</FC>'
                    + '<FC>id=EXCP_PRSNT_AMT    name="예외지급"  sumtext="@sum"   width=80   align=right</FC>'
                    + '<FC>id=RECOVERY_AMT    name="지급취소"  sumtext="@sum"   width=80  align=right</FC>'
                    + '<FC>id=ETC_PRSNT_AMT    name="기타지급"  sumtext="@sum"     width=80  align=right</FC>'
                    + '<FC>id=TOT_PSNT_AMT    name="누적지급"   sumtext="@sum"  width=80   align=right</FC></FG>'
                    + '<FC>id=LOSS_AMT    name="LOSS금액"   sumtext="@sum"    width=80  align=right</FC>';
    GD_EVTSKUSTOCK.ViewSummary = "1";               
    initGridStyle(GD_EVTSKUSTOCK, "common", hdrProperies, false);
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    var goTo       = "getEvtSkuStock";    
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEventCd="+ encodeURIComponent(strEventCd)
                   + "&strVenCd="  + encodeURIComponent(strVenCd);
    TR_MAIN.Action="/mss/mcae601.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_EVTSKUSTOCK=DS_O_EVTSKUSTOCK)"; //조회는 O
    TR_MAIN.Post();
   
    if(DS_O_EVTSKUSTOCK.CountRow == 0){
        showMessage(StopSign, OK, "USER-1000","상세내역을 가져오는데 실패했습니다.");
        this.close();
    }
    GD_EVTSKUSTOCK.Focus();
}
/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}
/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}
/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}
/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}
/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * btn_Close()
  * 작 성 자 : ckj
  * 작 성 일 : 2006.07.12
  * 개    요 : Close
  * return값 : void
  */  
  function btn_Close()
  {
      window.close();
  }
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_EVTSKUSTOCK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
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
<body onLoad="doInit();" class="PL10 PT15">
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr><td>
  <table border="0" cellpadding="0" cellspacing="0">
     <tr>
      <td width="100%" class="title" align="left">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <SPAN id="title1" class="PL03">물품정산 상세내역</SPAN>
            </td>
       <td align="right" width=50><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
       </tr>
   </table>
  </td></tr>
  <tr valign="top">
    <td width="100%" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>             
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_EVTSKUSTOCK width=100% height=270 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_EVTSKUSTOCK">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
</body>
</html>

