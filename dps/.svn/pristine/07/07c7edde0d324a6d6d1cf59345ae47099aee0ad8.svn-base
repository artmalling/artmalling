<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면매출정보(층) - 브랜드매출정보
 * 작 성 일 : 2010.06.29
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4321.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.29 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<title>브랜드매출정보</title>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var strCd         = dialogArguments[0];
var floorCd       = dialogArguments[1];
var pumbunCd      = dialogArguments[2];
var selDate       = dialogArguments[3];
var pumbunName    = dialogArguments[4];
var teamName      = dialogArguments[5];
var tmpDt         = new Date(selDate.substring(0,4),(Number(selDate.substring(4,6))-1),selDate.substring(6),0,0,0);
var selDateFormat = tmpDt.toFormatString("YYYY/MM/DD");
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_BRAND_INFO.setDataHeader('<gauce:dataset name="H_SEL_BRAND_INFO"/>');

    // EMedit에 초기화
    initEmEdit(EM_COMP_NAME             , "GEN"        , READ);
    initEmEdit(EM_TEAM_NAME            , "GEN"        , READ);
    initEmEdit(EM_REP_NAME            , "GEN"        , READ);
    initEmEdit(EM_START_DT             , "YYYYMMDD"   , READ);
    initEmEdit(EM_BIZ_STAT             , "GEN"        , READ);
    initEmEdit(EM_BIZ_CAT              , "GEN"        , READ);
    initEmEdit(EM_DAY_PLAN             , "NUMBER^13^0", READ);
    initEmEdit(EM_DAY_SALE             , "NUMBER^13^0", READ);
    initEmEdit(EM_DAY_GOAL_RATE        , "NUMBER^3^2" , READ);
    initEmEdit(EM_DAY_BFYY_SALE        , "NUMBER^13^0", READ);
    initEmEdit(EM_DAY_CUST_CNT         , "NUMBER^13^0", READ);
    initEmEdit(EM_DAY_CUST_AMT         , "NUMBER^13^0", READ);
    initEmEdit(EM_MONTH_PLAN           , "NUMBER^13^0", READ);
    initEmEdit(EM_MONTH_SALE           , "NUMBER^13^0", READ);
    initEmEdit(EM_MONTH_GOAL_RATE      , "NUMBER^3^2" , READ);
    initEmEdit(EM_MONTH_DAY_SALE       , "NUMBER^13^0", READ);
    initEmEdit(EM_MONTH_BFYY_SALE      , "NUMBER^13^0", READ);
    initEmEdit(EM_MONTH_PLAN_NEXT_RATE , "NUMBER^3^2" , READ);
    initEmEdit(EM_MONTH_PLAN_AMT       , "NUMBER^13^0", READ);
    initEmEdit(EM_MONTH_PLAN_GOAL_RATE , "NUMBER^3^2" , READ);
    initEmEdit(EM_YEAR_PLAN            , "NUMBER^13^0", READ);
    initEmEdit(EM_YEAR_SALE            , "NUMBER^13^0", READ);
    initEmEdit(EM_YEAR_GOAL_RATE       , "NUMBER^3^2" , READ);
    initEmEdit(EM_YEAR_DAY_SALE        , "NUMBER^13^0", READ);
    initEmEdit(EM_YEAR_BFYY_SALE       , "NUMBER^13^0", READ);
    initEmEdit(EM_YEAR_PLAN_NEXT_RATE  , "NUMBER^3^2" , READ);
    initEmEdit(EM_YEAR_PLAN_AMT        , "NUMBER^13^0", READ);
    initEmEdit(EM_YEAR_PLAN_GOAL_RATE  , "NUMBER^3^2" , READ);
    
    EM_TEAM_NAME.Text = teamName;
    
    var tmpImgSrc = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" />';
    var tmpStr = VEN_INFO.innerText;
	VEN_INFO.innerHTML   = tmpImgSrc + " " + selDateFormat + " " + pumbunName + " " + tmpStr;
	tmpStr = DAY_INFO.innerText;
	DAY_INFO.innerHTML   = tmpImgSrc + " " + selDateFormat + " " + tmpStr;
    tmpStr = MONTH_INFO.innerText;
	MONTH_INFO.innerHTML = tmpImgSrc + " " + selDateFormat + " " + tmpStr;
    tmpStr = YEAR_INFO.innerText;
	YEAR_INFO.innerHTML  = tmpImgSrc + " " + selDateFormat + " " + tmpStr;
	
	searchBrand();
}


/*************************************************************************
  * 2. 공통버튼
     (2) 닫기       - btn_Close()
 *************************************************************************/

/**
 * btn_Close()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 화면 종료
 * return값 : void
 */
function btn_Close() {
    window.returnValue = false;
    window.close();      
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
//

/**
 * searchBrand()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  브랜드매출정보 조회
 * return값 : void
 */
function searchBrand(){    
    var goTo       = "searchBrand" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strDt="+encodeURIComponent(selDate);
    TR_MAIN.Action="/dps/psal432.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_BRAND_INFO=DS_BRAND_INFO)"; //조회는 O
    TR_MAIN.Post();
    
} 

/**
 * winClose()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  창 종료시 실행
 * return값 : void
 */
function winClose( ){
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
    trFailed(TR_MAIN.ErrorMsg);
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

<!-- 서브 시스템 값 가져오기  -->

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_BRAND_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<body onLoad="doInit();" onUnload="winClose()" >

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">브랜드매출정보</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr>
                <td colspan="4" id=VEN_INFO  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 매출현황(특정)</td>
              </tr>
              <tr>
                <th width=100 >거래처명</th>
                <td width=150 >
                   <comment id="_NSID_">
                    <object id=EM_COMP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <th width=100 >소속팀</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_TEAM_NAME classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>          
              <tr>
                <th >대표자명</th>
                <td >
                   <comment id="_NSID_">
                    <object id=EM_REP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <th >시작일</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_START_DT classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>
              <tr>
                <th >업태</th>
                <td >
                   <comment id="_NSID_">
                    <object id=EM_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <th >업종</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_BIZ_CAT classid=<%=Util.CLSID_EMEDIT%>  width=150  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr>
                <td colspan="6" id=DAY_INFO style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 당일내역</td>
              </tr>
              <tr>
                <th width=100 >목표</th>
                <th width=100 >실적</th>
                <th width=100 >달성율</th>
                <th width=100 >전년실적</th>
                <th width=100 >고객수</th>
                <th >객단가</th>
              </tr>          
              <tr>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_DAY_PLAN classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_DAY_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_DAY_GOAL_RATE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_DAY_BFYY_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_DAY_CUST_CNT classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_DAY_CUST_AMT classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr>
                <td colspan="5" id=MONTH_INFO style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 월간누계</td>
                <td colspan="3" style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " ><img
                  src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 월간목표</td>
              </tr>
              <tr>
                <th width=100 >목표</th>
                <th width=100 >실적</th>
                <th width=80 >달성율</th>
                <th width=100 >일평균</th>
                <th width=100 >전년실적</th>
                <th width=80 >신장율</th>
                <th width=100 >목표</th>
                <th >진척율</th>
              </tr>          
              <tr>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_PLAN classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_GOAL_RATE classid=<%=Util.CLSID_EMEDIT%>  width=85  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_DAY_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_BFYY_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_PLAN_NEXT_RATE classid=<%=Util.CLSID_EMEDIT%>  width=85  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_PLAN_AMT classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_MONTH_PLAN_GOAL_RATE classid=<%=Util.CLSID_EMEDIT%>  width=85  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>                
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr>
                <td colspan="5" id=YEAR_INFO  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 년간누계</td>
                <td colspan="3" style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " ><img
                  src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 년간목표</td>
              </tr>
              <tr>
                <th width=100 >목표</th>
                <th width=100 >실적</th>
                <th width=80 >달성율</th>
                <th width=100 >일평균</th>
                <th width=100 >전년실적</th>
                <th width=80 >신장율</th>
                <th width=100 >목표</th>
                <th >진척율</th>
              </tr>          
              <tr>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_PLAN classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_GOAL_RATE classid=<%=Util.CLSID_EMEDIT%>  width=85  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_DAY_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_BFYY_SALE classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_PLAN_NEXT_RATE classid=<%=Util.CLSID_EMEDIT%>  width=85  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_PLAN_AMT classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_YEAR_PLAN_GOAL_RATE classid=<%=Util.CLSID_EMEDIT%>  width=85  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>                
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
    <td class="pop06" ></td>
  </tr>
  <tr>
    <td class="pop07" ></td>
    <td class="pop08" ></td>
    <td class="pop09" ></td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_BRAND_INFO>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
        <c>col=COMP_NAME                  ctrl=EM_COMP_NAME               param=Text </c>
        <c>col=REP_NAME                   ctrl=EM_REP_NAME                param=Text </c>
        <c>col=APP_S_DT                   ctrl=EM_START_DT                param=Text </c>
        <c>col=BIZ_STAT                   ctrl=EM_BIZ_STAT                param=Text </c>
        <c>col=BIZ_CAT                    ctrl=EM_BIZ_CAT                 param=Text </c>
        <c>col=DAY_GOAL_SALE_AMT          ctrl=EM_DAY_PLAN                param=Text </c>
        <c>col=DAY_SALE_AMT               ctrl=EM_DAY_SALE                param=Text </c>
        <c>col=DAY_GOAL_SALE_RATE         ctrl=EM_DAY_GOAL_RATE           param=Text </c>
        <c>col=DAY_BFYY_SALE_AMT          ctrl=EM_DAY_BFYY_SALE           param=Text </c>
        <c>col=DAY_CUST_CNT               ctrl=EM_DAY_CUST_CNT            param=Text </c>
        <c>col=DAY_CUST_AMT               ctrl=EM_DAY_CUST_AMT            param=Text </c>
        <c>col=MONTH_GOAL_SALE_AMT        ctrl=EM_MONTH_PLAN              param=Text </c>
        <c>col=MONTH_SALE_AMT             ctrl=EM_MONTH_SALE              param=Text </c>
        <c>col=MONTH_GOAL_SALE_RATE       ctrl=EM_MONTH_GOAL_RATE         param=Text </c>
        <c>col=MONTH_DAY_AMT              ctrl=EM_MONTH_DAY_SALE          param=Text </c>
        <c>col=MONTH_BFYY_SALE_AMT        ctrl=EM_MONTH_BFYY_SALE         param=Text </c>
        <c>col=MONTH_BF_AF_RATE           ctrl=EM_MONTH_PLAN_NEXT_RATE    param=Text </c>
        <c>col=MONTH_GOAL_MONTH_AMT       ctrl=EM_MONTH_PLAN_AMT          param=Text </c>
        <c>col=MONTH_GOAL_MONTH_RATE      ctrl=EM_MONTH_PLAN_GOAL_RATE    param=Text </c>
        <c>col=YEAR_GOAL_SALE_AMT         ctrl=EM_YEAR_PLAN               param=Text </c>
        <c>col=YEAR_SALE_AMT              ctrl=EM_YEAR_SALE               param=Text </c>
        <c>col=YEAR_GOAL_SALE_RATE        ctrl=EM_YEAR_GOAL_RATE          param=Text </c>
        <c>col=YEAR_DAY_AMT               ctrl=EM_YEAR_DAY_SALE           param=Text </c>
        <c>col=YEAR_BFYY_SALE_AMT         ctrl=EM_YEAR_BFYY_SALE          param=Text </c>
        <c>col=YEAR_BF_AF_RATE            ctrl=EM_YEAR_PLAN_NEXT_RATE     param=Text </c>
        <c>col=YEAR_GOAL_YEAR_AMT         ctrl=EM_YEAR_PLAN_AMT           param=Text </c>
        <c>col=YEAR_GOAL_YEAR_RATE        ctrl=EM_YEAR_PLAN_GOAL_RATE     param=Text </c>
    '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
