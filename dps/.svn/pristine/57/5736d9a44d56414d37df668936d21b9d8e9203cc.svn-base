<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > POS별정산/마감현황
 * 작 성 일 : 2011.08.24
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal5151.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2011.08.24 (박종은) 신규작성
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
<title>POS별정산/마감현황</title>
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

var strDt         = dialogArguments[0];
var strPosNo      = dialogArguments[1];


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
    DS_DAY_INFO.setDataHeader('<gauce:dataset name="H_SEL_DAY_INFO"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    searchDay();
}

function gridCreate1(){
    var hdrProperies = '<FC>id=BALANCE_FLAG    width=40   align=right name="SEQ"      </FC>'
                     + '<FC>id=COMM_NAME1      width=120   align=left  name="항목명 "       </FC>'
                     + '<FG>                                           name="'+strPosNo+'"'
                     + '<FC>id=NORM_TRAN_CNT   width=50  align=right  name="건수 "       </FC>'
                     + '<FC>id=NORM_TRAN_AMT   width=110  align=right  name="금액 "       </FC>'
                     + '</FG>';

    initGridStyle(GD_DAY_INFO, "common", hdrProperies, false);
}



/*************************************************************************
  * 2. 공통버튼
     (2) 닫기       - btn_Close()
 *************************************************************************/
//

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    searchDay();
}


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
 * 작 성 일 : 2011-02-18
 * 개    요 :  pos정산 조회
 * return값 : void
 */
function searchDay(){    
	
    var goTo       = "searchDay" ;    
    var action     = "O";  
    var parameters = "&strDt="	 +encodeURIComponent(strDt)
                   + "&strPosNo="+encodeURIComponent(strPosNo)
                   ;
    
    TR_MAIN.Action="/dps/psal515.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DAY_INFO=DS_DAY_INFO)"; //조회는 O
    TR_MAIN.Post();
    
} 

/**
 * winClose()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011-02-18
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
<comment id="_NSID_"><object id="DS_DAY_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
              <span id="title1" class="PL03">POS정산/마감현황</span>
            </td>
          </tr>
        </table></td>
      </tr>
      
      <tr>
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr valign="top" >
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_DAY_INFO width=100% height=310 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_DAY_INFO">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
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

</body>
</html>
