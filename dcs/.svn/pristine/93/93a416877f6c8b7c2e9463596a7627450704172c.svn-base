<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 법인카드정보조회 팝업
 * 작  성  일  : 2010.03.16
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm2063.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.03.16 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%> 
<%String strCardNo = (request.getParameter("strCardNo") != null && !"".equals(request.getParameter("strCardNo").trim()))? request.getParameter("strCardNo"):"";
  String strSsNo   = (request.getParameter("strSsNo")   != null && !"".equals(request.getParameter("strSsNo").trim()))  ? request.getParameter("strSsNo")  :"";
%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-16
 * 개      요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	
	// Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //법인카드 정보 조회
    showMaster();
    sortColId( DS_O_MASTER, 0, "CARD_NO");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30        align=center</FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=100       align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=150       align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=REP_YN          name="대표카드여부"    width=90        align=center</FC>'
                     + '<FC>id=CARD_STAT_CD    name="카드상태코드"    width="80"      show=false</FC>'
                     + '<FC>id=STAT_NM         name="카드상태"        width="80"      align=center</FC>'
                     + '<FC>id=ENTR_PATH_CD    name="가입경로"        width="80"      show=false</FC>'
                     + '<FC>id=BRCH_NAME       name="가입경로"        width="110"     align=center</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류"        width="80"      show=false</FC>'
                     + '<FC>id=TYPE_NM         name="카드종류"        width="100"     align=center</FC>'
        
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
 *************************************************************************/
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* showMaster()
* 작   성   자 : 김영진
* 작   성   일 : 2010-03-16
* 개           요 : 
* return값 : void
*/
function showMaster(){
    var strCardNo   = '<%=strCardNo%>';
    var strSsNo     = '<%=strSsNo%>';
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strCardNo="+ encodeURIComponent(strCardNo)
                    + "&strSsNo="  + encodeURIComponent(strSsNo); 
    TR_MAIN.Action  ="/dcs/dctm202.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

function btn_Close()
{
    window.close();
}
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--  Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- ouput용 -->
<comment id="_NSID_">
  <object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="396" class="title">
                  <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/> 법인카드정보</td>
                <td>
                  <table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                      <td>
                        <img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">      
              <tr>
                <td>
                  <!-- 마스터 -->
                  <comment id="_NSID_">
                    <object id=GR_MASTER width="100%" height=350 classid=<%=Util.CLSID_GRID%>> 
                      <param name="DataID" value="DS_O_MASTER">
                    </object>    
                  </comment>
                  <script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td class="pop06" ></td>
  </tr>
  <tr>
    <td class="pop07" ></td>
    <td class="pop08" ></td>
    <td class="pop09" ></td>
  </tr>
</table>
</body>
</html>

