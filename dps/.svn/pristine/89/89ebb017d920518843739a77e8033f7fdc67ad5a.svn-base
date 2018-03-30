<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면매출정보(층) - 월별매출정보
 * 작 성 일 : 2010.06.30
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4322.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.30 (정진영) 신규작성
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
<title>월별매출정보</title>
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
    DS_MONTH_INFO.setDataHeader('<gauce:dataset name="H_SEL_MONTH_INFO"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT      , "YYYYMMDD"   , PK);
    initEmEdit(EM_TO_DT        , "YYYYMMDD"   , PK);
    
    EM_FROM_DT.Text = selDate;
    EM_TO_DT.Text   = selDate;
    
    var tmpImgSrc = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" />';
    var tmpStr = GRID_INFO.innerText;
    GRID_INFO.innerHTML   = tmpImgSrc + " " + pumbunName + " " + tmpStr;
    tmpStr = GRAPH_INFO.innerText;
    GRAPH_INFO.innerHTML  = tmpImgSrc + " " + pumbunName + " " + tmpStr;
    
    EM_FROM_DT.Focus();
    
    searchMonth();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center name="NO"           </FC>'
                     + '<FC>id=SALE_YM         width=80   align=center name="매출년월"      mask="XXXX/XX"</FC>'
                     + '<FC>id=CUST_CNT        width=80   align=right  name="고객수 "       </FC>'
                     + '<FC>id=TOT_SALE_AMT    width=140  align=right  name="총매출 "       </FC>'
                     + '<FC>id=CUST_SALE_AMT   width=110  align=right  name="객단가 "       </FC>'
                     + '<FC>id=DC_AMT          width=110  align=right  name="에누리 "       </FC>'
                     + '<FC>id=SALE_PROF_AMT   width=110  align=right  name="이익액 "       </FC>'
                     + '<FC>id=SALE_PROF_RATE  width=80   align=right  name="이익율 "       </FC>';

    initGridStyle(GD_MONTH_INFO, "common", hdrProperies, false);
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
    //
    if( EM_FROM_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간(From)");
        EM_FROM_DT.Focus();
        return;
    }
    if( EM_TO_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간(To)");
        EM_TO_DT.Focus();
        return;
    }

    if( EM_TO_DT.Text < EM_FROM_DT.Text){
        showMessage(EXCLAMATION, OK, "USER-1020", "기간(To)", "기간(From)");
        EM_TO_DT.Focus();
        return;
    }
    
    searchMonth();
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
 * searchMonth()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  월별매출정보 조회
 * return값 : void
 */
function searchMonth(){    
	var fromDt     = EM_FROM_DT.Text;
	var toDt       = EM_TO_DT.Text;
    var goTo       = "searchMonth" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strFromDt="+encodeURIComponent(fromDt)
                   + "&strToDt="+encodeURIComponent(toDt);
    TR_MAIN.Action="/dps/psal432.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MONTH_INFO=DS_MONTH_INFO)"; //조회는 O
    TR_MAIN.Post();

    var total = DS_MONTH_INFO.CountRow;
    /*
    if(total < 1){
        return;
    }
    */
    var defRow = 4;
    var iframeWidth = document.getElementById('CHART_001').clientWidth;
    var iframeHeight = total * 40 ;
   
    viewChart('CHART_001',"1",iframeWidth,iframeHeight,"총매출","TOT_SALE_AMT","SALE_YM",DS_MONTH_INFO, GD_MONTH_INFO,"월별매출");
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

/**
 * getGridDataTypeToChartDataType()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  그리드 데이터 타입에 따른 차트 데이터셋 설정
 * return값 : void
 */
function getGridDataTypeToChartDataType(gridDataType){
    switch(gridDataType){
        case 2:
            return "Integer";
        case 3:
            return "Double";
    }
    return "String";
}

/**
 * viewChart()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  차트를 표시
 * return값 : void
 */
function viewChart( iFrameId, chartType, width, height, colLabel, dataId, yNameId, dataSet, grid, title){
    var colLabelList   = colLabel.split("||");
    var dataIdList     = dataId.split("||");
    var colLabelTotal  = colLabelList.length;
    var dataIdTotal    = dataIdList.length;
    var dataTotal      = dataSet.CountRow;
    
    if( colLabelTotal != dataIdTotal){
        return;
    }
    /*
    if( dataTotal < 1){
        return;
    }
    */
    var dataXmlStr = '<?xml version="1.0" encoding="euc-kr"?>';
    dataXmlStr    += '  <CHARTFX>';
    dataXmlStr    += '    <COLUMNS>';
    dataXmlStr    += '      <COLUMN NAME="'+yNameId+'" TYPE="String"/>';
    for( var i=0; i<colLabelTotal; i++){        
        dataXmlStr    += '      <COLUMN NAME="'+dataIdList[i]+'" ';
        dataXmlStr    += '              TYPE="'+getGridDataTypeToChartDataType(dataSet.ColumnType(dataSet.ColumnIndex(dataIdList[i])))+'" ';
        dataXmlStr    += '              DESCRIPTION="'+colLabelList[i]+'"/>';       
    }
    dataXmlStr    += '    </COLUMNS>';
    
    for(var i=1; i<=dataTotal; i++){
        dataXmlStr    += '     <ROW '+yNameId+'="'+replascXMLEscape(grid.VirtualString2( i, yNameId ,0))+'"';
        
        for(var j=0; j<dataIdTotal; j++){
            dataXmlStr    += '          '+dataIdList[j]+'="'+dataSet.NameValue( i, dataIdList[j])+'" ';
        }
        dataXmlStr    += '     ></ROW>';
        
    }
    dataXmlStr    += '  </CHARTFX>';
    
    
    
    var parameter = "[{chartType:'"+chartType+"'";
    if( width != null){
        parameter += ",strWidth:"+width;
    }
    if( height != null){
        parameter += ",strHeight:"+height;
    }
    if( title != null){
        parameter += ",strTitle:'"+title+"'";
    }
    parameter +=",xmlData:'"+dataXmlStr+"'";
    
    parameter +="}]";
    
    postwith(iFrameId,"/dps/jsp/psal/psal4329.jsp",eval(parameter)[0]);
}
/**
 * setCalData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  달력 팝업 실행
 * return값 : void
 */
function setCalData( evnFlag, obj){
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    if(obj.Text == "")
        return;
    
    if(!checkDateTypeYMD( obj ))
        return;
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


<!-- 기간(from)(조회) -->
<script language=JavaScript for=EM_FROM_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME', EM_FROM_DT);
</script>
<!-- 기간(to)(조회) -->
<script language=JavaScript for=EM_TO_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME', EM_TO_DT);
</script>
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
<comment id="_NSID_"><object id="DS_MONTH_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
              <span id="title1" class="PL03">월별매출정보</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50" height="22"   onClick="btn_Search();"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="60" class="point">기간</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script><img 
                    src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:setCalData('POP', EM_FROM_DT);"  align="absmiddle" />~
                  <comment id="_NSID_">
                    <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script><img 
                    src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:setCalData('POP', EM_TO_DT);"  align="absmiddle" />
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
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr>
                <td id=GRID_INFO  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 월별매출</td>
              </tr>
              <tr valign="top" >
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_MONTH_INFO width=100% height=200 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_MONTH_INFO">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>                
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
              <tr>
                <td id=GRAPH_INFO  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 월별매출 그래프</td>
              </tr>
              <tr valign="top" >
                <td ><iframe width="100%" height=243px id=CHART_001 name=CHART_001 src="" frameborder="0" ></iframe>
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

</body>
</html>
