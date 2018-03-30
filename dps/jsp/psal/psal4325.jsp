<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면매출정보(층) - 고객매출정보
 * 작 성 일 : 2010.06.30
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4325.jsp
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
<title>고객매출정보</title>
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
    DS_CUST_INFO_01.setDataHeader('<gauce:dataset name="H_SEL_CUST_INFO_01"/>');
    DS_CUST_INFO_02.setDataHeader('<gauce:dataset name="H_SEL_CUST_INFO_02"/>');
    DS_CUST_INFO_03.setDataHeader('<gauce:dataset name="H_SEL_CUST_INFO_03"/>');

    //그리드 초기화
    gridCreate1(); //등급
    gridCreate2(); //성별
    gridCreate3(); //연령
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT      , "YYYYMMDD"   , PK);
    initEmEdit(EM_TO_DT        , "YYYYMMDD"   , PK);
    
    EM_FROM_DT.Text = selDate;
    EM_TO_DT.Text   = selDate;
    
    var tmpImgSrc = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" />';
    var tmpStr = GRID_INFO_01.innerText;
    GRID_INFO_01.innerHTML   = tmpImgSrc + " " + pumbunName + " " + tmpStr;
    tmpStr = GRID_INFO_02.innerText;
    GRID_INFO_02.innerHTML  = tmpImgSrc + " " + pumbunName + " " + tmpStr;
    tmpStr = GRID_INFO_03.innerText;
    GRID_INFO_03.innerHTML  = tmpImgSrc + " " + pumbunName + " " + tmpStr;
    
    EM_FROM_DT.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center name="NO"           </FC>'
                     + '<FG>name="다이아몬드"'
                     + '<FC>id=GRADE_01_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=GRADE_01_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="플래트늄"'
                     + '<FC>id=GRADE_02_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=GRADE_02_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="골드"'
                     + '<FC>id=GRADE_03_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=GRADE_03_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="실버"'
                     + '<FC>id=GRADE_04_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=GRADE_04_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="합계"'
                     + '<FC>id=GRADE_TOTAL_AMT width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=GRADE_TOTAL_CNT width=60   align=right  name="객수 "         </FC>'
                     + '</FG>';

    initGridStyle(GD_CUST_INFO_01, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     width=30   align=center name="NO"           </FC>'
                     + '<FG>name="여성"'
                     + '<FC>id=SEX_F_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=SEX_F_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="남성"'
                     + '<FC>id=SEX_M_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=SEX_M_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="합계"'
                     + '<FC>id=SEX_TOTAL_AMT width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=SEX_TOTAL_CNT width=60   align=right  name="객수 "         </FC>'
                     + '</FG>';

    initGridStyle(GD_CUST_INFO_02, "common", hdrProperies, false);
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center name="NO"           </FC>'
                     + '<FG>name="20대미만"'
                     + '<FC>id=AGE_19_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_19_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="20대"'
                     + '<FC>id=AGE_20_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_20_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="30대"'
                     + '<FC>id=AGE_30_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_30_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="40대"'
                     + '<FC>id=AGE_40_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_40_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="50대"'
                     + '<FC>id=AGE_50_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_50_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="60대"'
                     + '<FC>id=AGE_60_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_60_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="70대이상"'
                     + '<FC>id=AGE_70_AMT    width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_70_CNT    width=60   align=right  name="객수 "         </FC>'
                     + '</FG>'
                     + '<FG>name="합계"'
                     + '<FC>id=AGE_TOTAL_AMT width=110  align=right  name="매출 "         </FC>'
                     + '<FC>id=AGE_TOTAL_CNT width=60   align=right  name="객수 "         </FC>'
                     + '</FG>';

    initGridStyle(GD_CUST_INFO_03, "common", hdrProperies, false);
    
    searchCust();
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
    
    searchCust();
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
 * searchCust()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  고객매출정보 조회
 * return값 : void
 */
function searchCust(){    
	var fromDt     = EM_FROM_DT.Text;
	var toDt       = EM_TO_DT.Text;
    var goTo       = "searchCust" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strFromDt="+encodeURIComponent(fromDt)
                   + "&strToDt="+encodeURIComponent(toDt);
    TR_MAIN.Action="/dps/psal432.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CUST_INFO_01=DS_CUST_INFO_01,"+action+":DS_CUST_INFO_02=DS_CUST_INFO_02,"+action+":DS_CUST_INFO_03=DS_CUST_INFO_03)"; //조회는 O
    TR_MAIN.Post();
    
    viewChart( 'CHART_003', '3', '20대미만||20대||30대||40대||50대||60대||70대이상', 'AGE_19_AMT||AGE_20_AMT||AGE_30_AMT||AGE_40_AMT||AGE_50_AMT||AGE_60_AMT||AGE_70_AMT', 'AGE_TOTAL_CNT', DS_CUST_INFO_03, GD_CUST_INFO_03, '연령별매출');
    setTimeout("viewChart( 'CHART_001', '3', '다이아몬드||플래트늄||골드||실버', 'GRADE_01_AMT||GRADE_02_AMT||GRADE_03_AMT||GRADE_04_AMT', 'GRADE_TOTAL_AMT', DS_CUST_INFO_01, GD_CUST_INFO_01, '등급별매출');",50);
    setTimeout("viewChart( 'CHART_002', '3', '여성||남성', 'SEX_F_AMT||SEX_M_AMT', 'SEX_TOTAL_AMT', DS_CUST_INFO_02, GD_CUST_INFO_02, '성별매출');",100);
    
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
 * viewChart()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  차트를 표시
 * return값 : void
 */
function viewChart( iFrameId, chartType, colLabel, dataId, totalAmtId, dataSet, grid, title){
    var colLabelList   = colLabel.split("||");
    var dataIdList     = dataId.split("||");
    var colLabelTotal  = colLabelList.length;
    var dataIdTotal    = dataIdList.length;
    var dataTotal      = dataSet.CountRow;
    
    if( colLabelTotal != dataIdTotal){
        return;
    }
    
    var row           = dataSet.RowPosition;
    var totalAmt      = dataSet.NameValue(row,totalAmtId);
    /*
    if( dataTotal < 1){
        return;
    }
    if( totalAmt < 1)
        return;
    
    */
    
    var iframeWidth = document.getElementById(iFrameId).clientWidth;
    var iframeHeight = 275 ;
    
    var dataXmlStr = '<?xml version="1.0" encoding="euc-kr"?>';
    dataXmlStr    += '  <CHARTFX>';
    dataXmlStr    += '    <COLUMNS>';
    dataXmlStr    += '      <COLUMN NAME="GUBN" ';
    dataXmlStr    += '              TYPE="String" />';
    dataXmlStr    += '      <COLUMN NAME="VAL" ';
    dataXmlStr    += '              TYPE="Double" />';   
    dataXmlStr    += '    </COLUMNS>';

    if( totalAmt > 0){
        for(var i=0; i<dataIdTotal; i++){
            dataXmlStr    += '     <ROW GUBN="'+replascXMLEscape(colLabelList[i])+'" ';
            dataXmlStr    += '          VAL="'+dataSet.NameValue( 1, dataIdList[i])+'" ';
            dataXmlStr    += '     ></ROW>';
        }
    }
        
    dataXmlStr    += '  </CHARTFX>';
    
    var parameter = "[{chartType:'"+chartType+"'";
    parameter += ",strWidth:"+iframeWidth;
    parameter += ",strHeight:"+iframeHeight;
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
<comment id="_NSID_"><object id="DS_CUST_INFO_01"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CUST_INFO_02"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CUST_INFO_03"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
              <span id="title1" class="PL03">고객매출정보</span>
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
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
                  <tr>
                    <td id=GRID_INFO_01  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 등급별고객매출</td>
                  </tr>
                  <tr valign="top" >
                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                      <tr>
                        <td>
                          <comment id="_NSID_">
                            <object id=GD_CUST_INFO_01 width=100% height=90 classid=<%=Util.CLSID_GRID%>>
                              <param name="DataID" value="DS_CUST_INFO_01">
                            </object>
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                      </tr>
                    </table></td>
                  </tr>                
                </table></td>
                <td width=350><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
                  <tr>
                    <td id=GRID_INFO_02  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 성별고객매출</td>
                  </tr>
                  <tr valign="top" >
                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                      <tr>
                        <td>
                          <comment id="_NSID_">
                            <object id=GD_CUST_INFO_02 width=100% height=90 classid=<%=Util.CLSID_GRID%>>
                              <param name="DataID" value="DS_CUST_INFO_02">
                            </object>
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                      </tr>
                    </table></td>
                  </tr>                
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
                  <tr>
                    <td id=GRID_INFO_03  style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " > 연령별고객매출</td>
                  </tr>
                  <tr valign="top" >
                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                      <tr>
                        <td>
                          <comment id="_NSID_">
                            <object id=GD_CUST_INFO_03 width=100% height=90 classid=<%=Util.CLSID_GRID%>>
                              <param name="DataID" value="DS_CUST_INFO_03">
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
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td width=28%><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
                  <tr>
                    <td style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " ><img
                      src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 등급별매출 그래프</td>
                  </tr>
                  <tr valign="top" >
                    <td ><iframe width="100%" height=282px id=CHART_001 name=CHART_001 src="" frameborder="0" ></iframe>
                    </td>
                  </tr>
                </table></td>
                <td width=27%><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
                  <tr>
                    <td style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " ><img
                      src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" />  성별매출 그래프</td>
                  </tr>
                  <tr valign="top" >
                    <td ><iframe width="100%" height=282px id=CHART_002 name=CHART_002 src="" frameborder="0" ></iframe>
                    </td>
                  </tr>
                </table></td>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table" style='border-top:0px;border-left:0px;border-right:0px;'>
                  <tr>
                    <td style='letter-spacing:0.0ex;border-top:0px;border-left:0px;border-right:0px;' class="sub_title PB03 " ><img
                      src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" />  연령별매출 그래프</td>
                  </tr>
                  <tr valign="top" >
                    <td ><iframe width="100%" height=282px id=CHART_003 name=CHART_003 src="" frameborder="0" ></iframe>
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
