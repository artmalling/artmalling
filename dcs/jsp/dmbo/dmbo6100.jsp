<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 멤버쉽운영 > 포인트양도현황
 * 작 성 일    : 2010.03.23
 * 작 성 자    : jinjung.kim
 * 수 정 자    : 
 * 파 일 명    : DMBO6100.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.03.23 (jinjung.kim) 신규작성
 *
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>


<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
    java.util.Calendar cal = java.util.Calendar.getInstance();
    String PROC_DT_TO = sdf.format(cal.getTime());
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>

<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    initEmEdit(EM_PROC_DT_FROM, "YYYYMMDD", PK);
    initEmEdit(EM_PROC_DT_TO,   "YYYYMMDD", PK);

    EM_PROC_DT_FROM.Text   = addDate("M", "-1", '<%=strToMonth%>');
    EM_PROC_DT_TO.Text   = "<%=PROC_DT_TO%>";

    //btn_Search();

    EM_PROC_DT_FROM.focus();
}

/**
 * gridCreate1()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 그리드 초기화
 * return값 : void
 */
function gridCreate1(){
   
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center  </FC>'
                     + '<FC>id=PROC_DT         name="일자"           width=90   align=center  mask="XXXX/XX/XX" SumText="합계" </FC>'
                     + '<FC>id=F_CUST_ID       name="양도회원"       width=72  align=center  show=false  </FC>'
                     + '<FC>id=F_CUST_NAME     name="양도회원"       width=72  align=left    </FC>'
                     + '<FC>id=MOBILE_PH1      name="양도회원전화"   width=110  align=left    </FC>'
                     + '<FC>id=T_CUST_ID       name="양수회원"       width=80  align=center  show=false </FC>'
                     + '<FC>id=T_CUST_NAME     name="양수회원"       width=80  align=left    </FC>'
                     + '<G> name="양도인"'
                     + '<FC>id=F_BF_POINT      name="양도전 포인트"  width=90   align=right </FC>'
                     + '<FC>id=MOVE_POINT      name="양도포인트"     width=80   align=right SumText=@sum  </FC>'
                     + '<FC>id=F_AFT_POINT     name="양도후 포인트"  width=86   align=right </FC>'
                     + '</G>'
                     + '<G> name="양수인"'
                     + '<FC>id=T_BF_POINT      name="양수전 포인트"  width=86   align=right </FC>'
                     + '<FC>id=T_AFT_POINT     name="양수후 포인트"  width=86   align=right </FC>'
                     + '</G>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);

    GR_MASTER.ViewSummary = "1";
}



/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if(trim(EM_PROC_DT_FROM.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회기간의 시작일자는 필수입력항목입니다.");
        EM_PROC_DT_FROM.Focus();
        return;
    }

    if(trim(EM_PROC_DT_TO.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회기간의 종료일자는 필수입력항목입니다.");
        EM_PROC_DT_TO.Focus();
        return;
    }

    if (EM_PROC_DT_TO.Text < EM_PROC_DT_FROM.Text) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회기간의 시작일이 종료일보다 큽니다.");
        EM_PROC_DT_FROM.Focus();
        return;
    }
    EXCEL_PARAMS ="시작일자=" + EM_PROC_DT_FROM.Text;
    EXCEL_PARAMS +="-종료일자=" + EM_PROC_DT_TO.Text;
    

    showMaster();

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_Excel()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";
    var ExcelTitle = "포인트양도현황";
    //openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
    openExcel5(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true , "",g_strPid );

}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.05.04
 * 개       요 : 초기화
 * return값 : void
 */
function btn_New() {
	 
	DS_O_MASTER.ClearData();
	
    EM_PROC_DT_FROM.Text   = addDate("M", "-1", '<%=strToMonth%>');
    EM_PROC_DT_TO.Text   = "<%=PROC_DT_TO%>";
	
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.23
 * 개       요     : 포인트 양도 현황
 * return값 : void
 */
function showMaster(){
    var goTo        = "searchMaster";
    var parameters  = "&PROC_DT_FROM=" + encodeURIComponent(EM_PROC_DT_FROM.Text);
        parameters += "&PROC_DT_TO="   + encodeURIComponent(EM_PROC_DT_TO.Text);

    TR_MASTER.Action  ="/dcs/dmbo610.do?goTo="+goTo+parameters;  
    TR_MASTER.KeyValue="SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    TR_MASTER.Post();
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
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
<script language=JavaScript for=TR_MASTER event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_O_MASTER.CountRow > 0) {
        GR_MASTER.focus();
    } else {
        EM_PROC_DT_FROM.focus();
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MASTER event=onFail>
    trFailed(TR_MASTER.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_PROC_DT_FROM event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PROC_DT_FROM)){
    	EM_PROC_DT_FROM.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_PROC_DT_TO event=onKillFocus()>
	if(!checkDateTypeYMD(EM_PROC_DT_TO)){
		EM_PROC_DT_TO.text = <%=toDate%>;
	}
</script> 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                  *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                 *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>



<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80" class="point">조회기간</th>
                <td>
                    <comment id="_NSID_">
                      <object id=EM_PROC_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" tabindex=1> <img src="/<%=dir%>/imgs/icon/ico_calender.gif" align="absmiddle"/></object>
                    </comment>
                    <script> _ws_(_NSID_);</script>                                             
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_PROC_DT_FROM)"/> 
                    ~
                    <comment id="_NSID_">
                      <object id=EM_PROC_DT_TO classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" tabindex=1> <img src="/<%=dir%>/imgs/icon/ico_calender.gif" align="absmiddle"/></object>
                    </comment>
                    <script> _ws_(_NSID_);</script>                                             
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_PROC_DT_TO)"/> 
                </td>

              </tr>
          </table>
          </td>

         </tr>
       </table>
      </td>
    </tr>
    <tr>
      <td class="dot"></td>
    </tr>
    <tr valign="top">
      <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GR_MASTER width="100%" height=780 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
</div>


<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

