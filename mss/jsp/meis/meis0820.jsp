<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 실적요약> 행사 Best/Worst Matrix
 * 작 성 일 : 2011.06.21
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0820.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사 Best/Worst Matrix 조회한다.
 * 이    력 :
 *        2011.06.21 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2,
                                                                       java.net.InetAddress,
                                                                       java.util.Properties" %> 
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
    String strDate    = Date2.getYear() + Date2.getMonth();
    
    /************ fujitsu.config파일을 읽어들임 ******************************/

    Properties fujitsuDeptProps = Util.getFujitsudeptProperties();
    String serverName = fujitsuDeptProps.getProperty("server.name");
     
    /************ Chart FX의 운영기처리 **************************************/
    if (serverName.equals(request.getServerName())){
        // Server

        String myServer1 = "10.1.100.26";
        String myServer2 = "10.1.100.28";

        // IP Check
        InetAddress Address = InetAddress.getLocalHost();
        String ipCheck = Address.getHostAddress();  
        if (ipCheck.equals(myServer1))                                                       
        {                                                          
              System.out.println(myServer1);                        
              com.softwarefx.chartfx.server.Chart.setLicenseString("Ck4o2ftbAQCl942vct3jQEEBAAABAAAABUNGSjcwC1NGWERPV05MT0FERk5TPTE7TWFwcz1QLDMyMSxDRko3MCwxO1N0YXRpc3RpY2FsPVAsMzIxLENGSjcwLDE7R2F1Z2VzPVAsMzIxLENGSjcwLDEBAAAAAVIAAUSHAXVzZXIubmFtZT1qZXVzCmphdmEudmVyc2lvbj0xLjUuMC4xMQp1c2VyLmhvbWU9L2pldXMKaG9zdD1kY3d3MDEKamF2YS5ob21lPS9vcHQvamF2YTEuNS9qcmUKb3MubmFtZT1IUC1VWAppcD0xMC4xLjEwMC4yNgpvcy5hcmNoPUlBNjROCgAAAAABIA==*&VaqX89ojq8EhmT1sny7X3kA4ww35vFL0Y3RhkyGuQG1IN/vLUOHoHpz58B/ncSbnPzVkROKAZxL72nwkc6X+1hNaKgH1em5rhD3LCViNbW/1p0WxJ4lFA8Fs5REmPCoI0yGuoKDWjebPFLyaCTGV1P74/RfYb0bUBB0d1ZdQ9Ow=");  
        }                                                          
        else if (ipCheck.equals(myServer2))
        { 
              System.out.println(myServer2); 
              com.softwarefx.chartfx.server.Chart.setLicenseString("HyTrXftbAADEvO9Pc93jQAMBAAABAAAAB0NGSjcwQVALU0ZYRE9XTkxPQURMTlM9MTtNYXBzPVAsMjU5LENGSjcwQVAsMTtTdGF0aXN0aWNhbD1QLDI1OSxDRko3MEFQLDE7R2F1Z2VzPVAsMjU5LENGSjcwQVAsMQEAAAABUgABRIcBdXNlci5uYW1lPWpldXMKamF2YS52ZXJzaW9uPTEuNS4wLjExCnVzZXIuaG9tZT0vamV1cwpob3N0PWRjd3cwMgpqYXZhLmhvbWU9L29wdC9qYXZhMS41L2pyZQpvcy5uYW1lPUhQLVVYCmlwPTEwLjEuMTAwLjI4Cm9zLmFyY2g9SUE2NE4KAAAAAA==*&xnud56E5jC1x+mNS7hs+3N1npFDpQdYOK3QO3BdCwtZiMVmdV434Qhaj4nTkPpFIO3R7inWvd1EzpCTllJRBRFYdBW8N135CGwlTAcx66JpiBzLsWKIqHPLXI3E0r7zRxJDxBsb9sg/toi0FYHNjzgEBH5j7oSxC313FVllyGnk=");  
        }
    }
    
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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var lo_StrNm        = "";
var lo_StrCd        = "";
var lo_Date         = "";
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단 
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
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
    
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-21
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_SALE_YM, "YYYYMM", PK); //경영실적년월
	EM_SALE_YM.Text = "<%=strDate%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, NORMAL);   //점(조회)
	 
	getStore("DS_STR_CD", "N", "", "Y");         //점콤보 가져오기 ( gauce.js )  
	
	//콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<FC>id={currow}     width=25 align=center name="NO"</FC>'
                     + '<FC>id=STR_NM       width=80 align=center name="점명" </FC>'
                     + '<FC>id=THME_NM      width=90 align=left   name="행사테마" SumText="합계"</FC>'
                     + '<C>id=GOAL_SALE_AMT width=110 align=right  name="계획금액" SumText={Sum(GOAL_SALE_AMT)}  value={GOAL_SALE_AMT}</C>'
                     + '<C>id=TOT_SALE_AMT  width=110 align=right  name="실적금액" SumText={Sum(TOT_SALE_AMT)}  value={TOT_SALE_AMT}</C>'
                     + '<C>id=ACH_RATIO     width=85 align=right  name="달성율"</C>'
                     + '<C>id=LST_SALE_AMT  width=110 align=right  name="전년실적" SumText={Sum(LST_SALE_AMT)}  value={LST_SALE_AMT}</C>'
                     + '<C>id=GRO_RATIO     width=85 align=right  name="신장율"</C>'
                     ;

    initGridStyle(GD_STR, "common", hdrProperies, false);
    GD_STR.ViewSummary = "1";

    var hdrProperies2 = '<FC>id={currow}     width=25  align=center name="NO"</FC>'
                      + '<FC>id=EVENT_CD     width=90  align=center name="행사코드" </FC>'
                      + '<FC>id=EVENT_NAME   width=150 align=left   name="행사명"   SumText="합계"</FC>'
                      + '<C>id=PERIOD        width=160 align=center name="기간"</C>'
                      + '<C>id=GOAL_SALE_AMT width=110  align=right  name="계획금액" SumText={Sum(GOAL_SALE_AMT)}  value={GOAL_SALE_AMT}</C>'
                      + '<C>id=TOT_SALE_AMT  width=110  align=right  name="실적금액" SumText={Sum(TOT_SALE_AMT)}  value={TOT_SALE_AMT}</C>'
                      + '<C>id=ACH_RATIO     width=85  align=right  name="달성율"</C>'
                      ;

    initGridStyle(GD_EVT, "common", hdrProperies2, false);
    GD_EVT.ViewSummary = "1";
    
    var hdrProperies3 = '<FC>id={currow}     width=25  align=center name="NO"</FC>'
                      + '<FC>id=STR_NM       width=120  align=center name="점명" </FC>'
                      + '<FC>id=THME_NM      width=150  align=left   name="행사테마" SumText="합계"</FC>'
                      + '<FC>id=EVENT_CD     width=90  align=center name="행사코드" </FC>'
                      + '<FC>id=EVENT_NAME   width=200 align=left   name="행사명"</FC>'
                      + '<C>id=PERIOD        width=220 align=center name="기간"</C>'
                      + '<C>id=GOAL_SALE_AMT width=110  align=right  name="계획금액" SumText=@sum</C>'
                      + '<C>id=TOT_SALE_AMT  width=110  align=right  name="실적금액" SumText=@sum</C>'
                      + '<C>id=ACH_RATIO     width=85  align=right  name="달성율"</C>'
                      ;

    initGridStyle(GD_EXCEL, "common", hdrProperies3, false);
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
 * 작 성 일 : 2011-06-21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_STR.IsUpdated){
        //변경내역이 있습니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1){
        	EM_SALE_YM.Focus();
            return false;
        }
    }
    
    //1. validation
    if (isNull(EM_SALE_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "년월"); //(년월)은/는 반드시 입력해야 합니다.
        EM_SALE_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_SALE_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "년월");//(년월)은/는 유효하지 않는 날짜입니다.
        EM_SALE_YM.focus();
        return;
    }
    
    lo_IsMasterLoaded = 0;
    DS_STR.ClearData();
    DS_EVT.ClearData();
	
	var goTo       = "searchThem" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  + LC_STR_CD.BindColVal //점코드
                   + "&strSaleDt=" + EM_SALE_YM.text      //년월
                   ;
    
    lo_StrNm = LC_STR_CD.text;
    lo_StrCd = LC_STR_CD.BindColVal;
    lo_Date  = EM_SALE_YM.text;
    
    //CHART호출
    IFR_EVENT.location.href = "/mss/meis082.me?goTo=chart"+parameters;
    
    DS_STR.DataID   = "/mss/meis082.me?goTo="+goTo+parameters;
    DS_STR.SyncLoad = "true";
    DS_STR.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
	DS_EVT.ClearData();
	 
    var goTo       = "searchEvent";
    var parameters = "&strStrCd="  + DS_STR.NameValue(row,"STR_CD")
                   + "&strSaleDt=" + DS_STR.NameValue(row,"SALE_DT")
                   + "&strThemCd=" + DS_STR.NameValue(row,"EVENT_THME_CD")
                   ;
    DS_EVT.DataID   = "/mss/meis082.me?goTo="+goTo+parameters;
    DS_EVT.SyncLoad = "true";
    DS_EVT.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if(DS_STR.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    
    DS_EXCEL.ClearData();
    var goTo       = "getExcelData";
    var action     = "O";
    var parameters = "&strStrCd="  + lo_StrCd //점코드
                   + "&strSaleDt=" + lo_Date  //년월
                   ;

    DS_EXCEL.DataID = "/mss/meis082.me?goTo="+goTo+parameters;
    DS_EXCEL.Reset();
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	if(DS_STR.RowPosition == 0){
		showMessage(EXCLAMATION , OK, "USER-1031");
        return;
	}
	
	row = DS_STR.RowPosition;
    var goTo = "chart";
    var parameters = "&strStrCd="  + DS_STR.NameValue(row,"STR_CD")
                   + "&strSaleDt=" + DS_STR.NameValue(row,"SALE_DT")
                   + "&strPrint=1"
                   ;
   IFR_WEEKLY_TREND_PRINT.location.href = "/mss/meis082.me?goTo="+goTo+parameters;
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 출력
 * return값 : void
 */
function print(fileName) {
    row = DS_STR.RowPosition;
    var params = "&strStrCd="    + DS_STR.NameValue(row,"STR_CD")
               + "&strSaleDt="   + DS_STR.NameValue(row,"SALE_DT")
               + "&strFileName=" + fileName

    window.open("/mss/meis082.me?goTo==print"+params,"OZREPORT", 1000, 700);
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
<script language=JavaScript for=DS_STR event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_STR.Focus();
</script>

<script language=JavaScript for=DS_EVT event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
    GD_STR.Focus();
</script>

<script language=JavaScript for=DS_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    //엑셀출력
    if (lo_StrNm == "") lo_StrNm = "전체";

    var parameters = "점="     + lo_StrNm
                   + " -년월=" + lo_Date;
    
    var ExcelTitle = "행사 Best/Worst";

    openExcel2(GD_EXCEL, ExcelTitle, parameters, true );
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_STR  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_EVT  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_EXCEL  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_STR event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
    	 subQuery(row);
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_STR event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
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
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]-->
    <object id="DS_STR"      classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_EVT"      classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_EXCEL"    classid=<%= Util.CLSID_DATASET %>></object>
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
    <td class="PT01 PB03" colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80">점코드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">년월</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=EM_SALE_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strDate%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_SALE_YM)" align="absmiddle" />
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr><td class="dot" colspan="2"></td></tr>
  <tr valign="top">
    <td width="45%" class="PT02 PR10">
      <table width="100%" height="275" border="0" cellpadding="0" cellspacing="0" class="s_table">
        <tr>
          <td class="BD4A" width="100%">
            <iframe id="IFR_EVENT" width="100%" height="502" style="overflow:hidden;" src=""></iframe>
          </td>
        </tr>
      </table>      
    </td>
    <td>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr class="PB10">
          <td class="BD4A">
            <comment id="_NSID_">
              <object id=GD_STR width="100%" height=230 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_STR">
              </object>
            </comment><script>_ws_(_NSID_);</script>                      
          </td>
        </tr>
        <tr>
          <td class="BD4A">
            <comment id="_NSID_">
              <object id=GD_EVT width="100%" height=260 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_EVT">
              </object>
            </comment><script>_ws_(_NSID_);</script>                      
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
<comment id="_NSID_">
  <object id=GD_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
