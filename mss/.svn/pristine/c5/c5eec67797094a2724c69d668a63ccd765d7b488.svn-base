<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 실적요약> 고객 현황
 * 작 성 일 : 2011.06.30
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0830.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월별 고객 현황 추이를 조회한다.
 * 이    력 :
 *        2011.06.30 (이정식) 신규작성
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
var lo_selectedRow1 = 0;
var lo_selectedRow2 = 0;
var lo_StrNm        = "";
var lo_StrCd        = "";
var lo_Date         = "";
var lo_tabIdx       = 1;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
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
    
    initTab("TB_NORMAL");
    
    //그리드 초기화
    gridCreate();
    
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-30
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_SALE_YM, "YYYYMM", PK); //년월
	EM_SALE_YM.Text = "<%=strDate%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
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
 * 작 성 일 : 2011-06-30
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
    var hdrProperies1 = '<COLUMNINFO>' 
                      + '    <COLUMN id="STRCD" refcolid="STR_CD" >'
                      + '        <SUPPRESS><REFCOLID>STR_CD</REFCOLID></SUPPRESS>'
                      + '        <HEADER left="0" top="0" right="40" bottom="20" text="점코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="0" top="0" right="40" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="STRNM" refcolid="STR_NM" >'
                      + '        <SUPPRESS><REFCOLID>STR_NM</REFCOLID></SUPPRESS>'
                      + '        <HEADER left="40" top="0" right="120" bottom="20" text="점명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="40" top="0" right="120" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="DIVFLAG1" refcolid="FLAG1" >'
                      + '        <HEADER left="120" top="0" right="230" bottom="20" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="120" top="0" right="230" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      
    var hdrProperies2 = '        <VIEWSUMMARY text="구매고객수"  bgcolor="#b9d9ea"/>'
    var hdrProperies3 = '        <VIEWSUMMARY text="매출액"  bgcolor="#b9d9ea"/>'

    var hdrProperies4 = '    </COLUMN>'                     
                      + '    <COLUMN id="DIVFLAG2" refcolid="FLAG2" >'
                      + '        <VIEW left="120" top="20" right="230" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="등급구성비"  bgcolor="#b9d9ea"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="TOTAL1" refcolid="TOTAL" >'
                      + '        <HEADER left="230" top="0" right="340" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="230" top="0" right="340" bottom="20" align="RightCenter" edit="" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(TOTAL)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="TOTAL2" refcolid="" >'
                      + '        <VIEW left="230" top="20" right="340" text="@((BLACK+GOLD+BLUE+GREEN)/TOTAL *100)" bottom="40" align="RightCenter" displayformat="#,##0" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="@((GFSUM(BLACK)+GFSUM(GOLD)+GFSUM(BLUE)+GFSUM(GREEN))/GFSUM(TOTAL) *100)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLACK1" refcolid="BLACK" >'
                      + '        <HEADER left="340" top="0" right="440" bottom="20" text="블랙" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="340" top="0" right="440" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLACK)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLACK2" refcolid="" >'
                      + '        <VIEW left="340" top="20" right="440" bottom="40" text="@(BLACK/TOTAL *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLACK)/GFSUM(TOTAL)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GOLD1" refcolid="GOLD" >'
                      + '        <HEADER left="440" top="0" right="540" bottom="20" text="골드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="440" top="0" right="540" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GOLD)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GOLD2" refcolid="" >'
                      + '        <VIEW left="440" top="20" right="540" bottom="40" text="@(GOLD/TOTAL *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GOLD)/GFSUM(TOTAL)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLUE1" refcolid="BLUE" >'
                      + '        <HEADER left="540" top="0" right="640" bottom="20" text="블루" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="540" top="0" right="640" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLUE)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLUE2" refcolid="" >'
                      + '        <VIEW left="540" top="20" right="640" bottom="40" text="@(BLUE/TOTAL *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLUE)/GFSUM(TOTAL)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GREEN1" refcolid="GREEN" >'
                      + '        <HEADER left="640" top="0" right="740" bottom="20" text="그린" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="640" top="0" right="740" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GREEN)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GREEN2" refcolid="" >'
                      + '        <VIEW left="640" top="20" right="740" bottom="40" text="@(GREEN/TOTAL *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GREEN)/GFSUM(TOTAL)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'
                     
    var hdrProperies5 = '    <COLUMN id="DIVFLAG3" refcolid="FLAG3" >'
                      + '        <HEADER left="740" top="0" right="850" bottom="20" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="740" top="0" right="850" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="매출액"  bgcolor="#b9d9ea"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="DIVFLAG4" refcolid="FLAG4" >'
                      + '        <VIEW left="740" top="20" right="850" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="등급구성비"  bgcolor="#b9d9ea"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="TOTAL3" refcolid="TOTAL_AMT" >'
                      + '        <HEADER left="850" top="0" right="960" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="850" top="0" right="960" bottom="20" align="RightCenter" edit="" displayformat="#,##0" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(TOTAL_AMT)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="TOTAL4" refcolid="" >'
                      + '        <VIEW left="850" top="20" right="960" text="@((BLACK_AMT+GOLD_AMT+BLUE_AMT+GREEN_AMT)/TOTAL_AMT *100)" bottom="40" align="RightCenter" displayformat="#,##0" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEWSUMMARY text="@((GFSUM(BLACK_AMT)+GFSUM(GOLD_AMT)+GFSUM(BLUE_AMT)+GFSUM(GREEN_AMT))/GFSUM(TOTAL_AMT) *100)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLACK3" refcolid="BLACK_AMT" >'
                      + '        <HEADER left="960" top="0" right="1060" bottom="20" text="블랙" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="960" top="0" right="1060" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLACK_AMT)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLACK4" refcolid="" >'
                      + '        <VIEW left="960" top="20" right="1060" bottom="40" text="@(BLACK_AMT/TOTAL_AMT *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLACK_AMT)/GFSUM(TOTAL_AMT)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GOLD3" refcolid="GOLD_AMT" >'
                      + '        <HEADER left="1060" top="0" right="1160" bottom="20" text="골드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="1060" top="0" right="1160" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GOLD_AMT)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GOLD4" refcolid="" >'
                      + '        <VIEW left="1060" top="20" right="1160" bottom="40" text="@(GOLD_AMT/TOTAL_AMT *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GOLD_AMT)/GFSUM(TOTAL_AMT)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLUE3" refcolid="BLUE_AMT" >'
                      + '        <HEADER left="1160" top="0" right="1260" bottom="20" text="블루" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="1160" top="0" right="1260" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLUE_AMT)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="BLUE4" refcolid="" >'
                      + '        <VIEW left="1160" top="20" right="1260" bottom="40" text="@(BLUE_AMT/TOTAL_AMT *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(BLUE_AMT)/GFSUM(TOTAL_AMT)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GREEN3" refcolid="GREEN_AMT" >'
                      + '        <HEADER left="1260" top="0" right="1360" bottom="20" text="그린" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                      + '        <VIEW left="1260" top="0" right="1360" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GREEN_AMT)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'                     
                      + '    <COLUMN id="GREEN4" refcolid="" >'
                      + '        <VIEW left="1260" top="20" right="1360" bottom="40" text="@(GREEN_AMT/TOTAL_AMT *100)" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                      + '        <VIEWSUMMARY text="@GFSUM(GREEN_AMT)/GFSUM(TOTAL_AMT)*100" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                      + '    </COLUMN>'
                     
    var hdrProperies6 = '</COLUMNINFO>';
        
    initMGridStyle(GD_CUST_TAB1, "common", hdrProperies1+hdrProperies2+hdrProperies4+hdrProperies6);
    GD_CUST_TAB1.ViewSummary   = 1;
    
    initMGridStyle(GD_CUST_TAB2, "common", hdrProperies1+hdrProperies3+hdrProperies4+hdrProperies6);
    GD_CUST_TAB2.ViewSummary   = 1;
    
    initMGridStyle(GD_EXCEL, "common", hdrProperies1+hdrProperies2+hdrProperies4+hdrProperies5+hdrProperies6);
    GD_EXCEL.ViewSummary   = 1;
    
    //GD_CUST_TAB1.Sort = true;
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
 * 작 성 일 : 2011-06-30
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
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
    
    var parameters = "&strStrCd="  + LC_STR_CD.BindColVal //점코드
                   + "&strSaleYm=" + EM_SALE_YM.text      //년월
                   ;
    lo_StrNm = LC_STR_CD.text;
    lo_StrCd = LC_STR_CD.BindColVal;
    lo_Date  = EM_SALE_YM.text;
    
    if(lo_tabIdx == 1 ){
	    DS_CUST_TAB1.ClearData();
		
		lo_selectedRow1 = 0;
		
		IFR_CUST_PIE.location.href = "/mss/jsp/blank.jsp";
	    IFR_CUST_GRID.location.href = "/mss/jsp/blank.jsp";
		
		var goTo       = "searchCustGrade" ;    
	    var action     = "O";     
	    
	    DS_CUST_TAB1.DataID   = "/mss/meis083.me?goTo="+goTo+parameters;
	    DS_CUST_TAB1.SyncLoad = "true";
	    DS_CUST_TAB1.Reset();
    } else {
        DS_CUST_TAB2.ClearData();
        
        lo_selectedRow2 = 0;
        
        IFR_CUST_PIE2.location.href = "/mss/jsp/blank.jsp";
        IFR_CUST_GRID2.location.href = "/mss/jsp/blank.jsp";
        
        var goTo       = "searchCustSale" ;    
        var action     = "O";     

        DS_CUST_TAB2.DataID   = "/mss/meis083.me?goTo="+goTo+parameters;
        DS_CUST_TAB2.SyncLoad = "true";
        DS_CUST_TAB2.Reset();
    }
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
    var parameters = "&strStrCd="  + DS_CUST_TAB1.NameValue(row,"STR_CD")
                   + "&strSaleYm=" + DS_CUST_TAB1.NameValue(row,"SALE_YM")
                   + "&tabFlag=1"
                   ;
    IFR_CUST_PIE.location.href  = "/mss/meis083.me?goTo=chart1"+parameters;
    IFR_CUST_GRID.location.href = "/mss/meis083.me?goTo=chart2"+parameters;
}

/**
 * subQuery2()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : 
 * return값 : void
 */
function subQuery2(row){
    var parameters = "&strStrCd="  + DS_CUST_TAB2.NameValue(row,"STR_CD")
                   + "&strSaleYm=" + DS_CUST_TAB2.NameValue(row,"SALE_YM")  
                   ;
    IFR_CUST_PIE2.location.href  = "/mss/meis083.me?goTo=chart1"+parameters;
    IFR_CUST_GRID2.location.href = "/mss/meis083.me?goTo=chart2"+parameters;
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if(lo_tabIdx ==1){
		if(DS_CUST_TAB1.CountRow <= 0){
	        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	        return;
	    }
	} else {
		if(DS_CUST_TAB2.CountRow <= 0){
            showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
            return;
        }
	}
	
	var parameters = "&strStrCd="  + lo_StrCd //점코드
                   + "&strSaleYm=" + lo_Date  //년월
                   ;
    var goTo       = "getExcelData" ;    
    var action     = "O";     

    DS_EXCEL.DataID   = "/mss/meis083.me?goTo="+goTo+parameters;
    DS_EXCEL.Reset();
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * fn_changeTab()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-30
 * 개    요 : 탭변경시 호출
 * return값 : void
 */ 
function fn_changeTab(tabId, tabIdx) {
    lo_tabIdx = tabIdx;
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
<script language=JavaScript for=DS_CUST_TAB1 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_CUST_TAB1.Focus();
</script>

<script language=JavaScript for=DS_CUST_TAB2 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_CUST_TAB2.Focus();
</script>

<script language=JavaScript for=DS_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)){
    	showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    	return;
    } 
    
    var strTitle = "구매고객현황";

    var strStrNm = lo_StrNm; //점
    var strDate  = lo_Date;  //일자
        
    var parameters = "점 "       + strStrNm
                   + ",   일자"  + strDate;
        
    openExcelM(GD_EXCEL, strTitle, parameters, true );
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_CUST_TAB1  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_CUST_TAB2  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_EXCEL  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_CUST_TAB1 event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
    	 if(lo_selectedRow1 != ((row+1)/2)){
    		 lo_selectedRow1 = (row+1)/2;
    		 subQuery(row);
    	 }
     }
</script>

<script language=JavaScript for=DS_CUST_TAB2 event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         if(lo_selectedRow2 != ((row+1)/2)){
             lo_selectedRow2 = (row+1)/2;
             subQuery2(row);
         }
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_CUST_TAB1 event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_CUST_TAB2 event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_CUST_TAB1 event=OnLButtonDown(type,index,colid,x,y)>
    if(type == "5"){
    	if(DS_CUST_TAB1.CountRow <= 0) return;
    	
        row = DS_CUST_TAB1.RowPosition;
        var parameters = "&strStrCd="
        	           + "&strSaleYm=" + DS_CUST_TAB1.NameValue(row,"SALE_YM")
        	           + "&tabFlag=1"
                       ;
        IFR_CUST_PIE.location.href  = "/mss/meis083.me?goTo=chart1"+parameters;
        IFR_CUST_GRID.location.href = "/mss/meis083.me?goTo=chart2"+parameters;
        
        lo_selectedRow1 = 0;
        DS_CUST_TAB1.RowPosition = 0;
    }
</script>

<script language=JavaScript for=GD_CUST_TAB2 event=OnLButtonDown(type,index,colid,x,y)>
    if(type == "5"){
        if(DS_CUST_TAB2.CountRow <= 0) return;
        
        row = DS_CUST_TAB2.RowPosition;
        var parameters = "&strStrCd="
                       + "&strSaleYm=" + DS_CUST_TAB2.NameValue(row,"SALE_YM")
                       ;
        IFR_CUST_PIE2.location.href  = "/mss/meis083.me?goTo=chart1"+parameters;
        IFR_CUST_GRID2.location.href = "/mss/meis083.me?goTo=chart2"+parameters;
        
        lo_selectedRow2 = 0;
        DS_CUST_TAB2.RowPosition = 0;
    }
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
    <object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]-->
    <object id="DS_CUST_TAB1" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_CUST_TAB2" classid=<%= Util.CLSID_DATASET %>></object>
    <!--[엑셀출력]-->
    <object id="DS_EXCEL" classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80" class="point">년월</th>
            <td>
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
  <tr>
    <td class="PT01 PB03">
      <div id=TB_NORMAL width="100%" height=515 TitleWidth=120 TitleAlign="center" TitleStyle="" TitleGap=3>
        <menu TitleName="고객등급현황"      DivId="tr_tab1" ClickFunc="fn_changeTab"     />
        <menu TitleName="고객등급매출현황"  DivId="tr_tab2" ClickFunc="fn_changeTab"     />
      </div>             
    </td>
  </tr>
  
  <tr>
  	<td>
  	
<!-- TAB1 Start -->
<div id="tr_tab1" class="PT05">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="*">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
      				<tr>
        				<td>
        					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          						<tr>
            						<td>
              						<comment id="_NSID_">
                      				<object id=GD_CUST_TAB1 width=100% height=243 classid=<%=Util.CLSID_MGRID%>>
                        				<param name="DataID" value="DS_CUST_TAB1">
                        				<param Name="IndicatorInfo" value='<INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                        				<param Name="sort"      value="false">
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
		    <td width="10">&nbsp;</td>
			<td width="330" class="PT03">
	            <table width="100%" height="245" border="0" cellpadding="0" cellspacing="0" class="s_table">
		            <tr>
			            <td width="100%">
						<iframe id="IFR_CUST_PIE" width="100%" height="245" style="overflow:hidden;" 
								src=""></iframe>
	                    </td>
	                </tr>
       			</table> 								
			</td>		  	
		</tr>
        <tr>
			<td colspan="3">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                    	<td class="PT07">
                      		<table width="100%" height="205" border="0" cellpadding="0" cellspacing="0" class="s_table">
                        		<tr>
                          			<td class="BD4A">
                            		<iframe id="IFR_CUST_GRID" width="100%" height="226" src=""></iframe>
                          			</td>
                        		</tr>
                      		</table>
                    	</td>
                  	</tr>
            	</table>
      		</td>
     	</tr>		      
    </table>
</div>
<!-- TAB1 End -->

<!-- TAB2 Start -->
<div id="tr_tab2" class="PT05">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  		<tr>
        	<td width="*">
       			<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                    	<td>
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          		<tr>
                            		<td>
                              		<comment id="_NSID_">
                                	<object id=GD_CUST_TAB2 width=100% height=243 classid=<%=Util.CLSID_MGRID%>>
                                  		<param name="DataID" value="DS_CUST_TAB2">
                                  		<param Name="IndicatorInfo" value='<INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                                  		<param Name="sort"      value="false">
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
			<td width="10">&nbsp;</td>
            <td width="330" class="PT03">
	            <table width="100%" height="245" border="0" cellpadding="0" cellspacing="0" class="s_table">
		            <tr>
			            <td width="100%">
						<iframe id="IFR_CUST_PIE2" width="100%" height="245" style="overflow:hidden;" 
								src=""></iframe>
	                    </td>
	                </tr>
       			</table> 
           	</td>
     	</tr>
        <tr>
        	<td colspan="3">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                    	<td class="PT07">
                      		<table width="100%" height="205" border="0" cellpadding="0" cellspacing="0" class="s_table">
                        		<tr>
                          			<td class="BD4A">
                            		<iframe id="IFR_CUST_GRID2" width="100%" height="226" src=""></iframe>
                          			</td>
                        		</tr>
                      		</table>
                    	</td>
                  	</tr>
            	</table>
        	</td>
      	</tr>              
	</table>
</div>
<!-- TAB2 End -->
  	
  	</td>
  </tr>
</table>
</div>
<comment id="_NSID_">
  <object id=GD_EXCEL width=0 height=0 classid=<%=Util.CLSID_MGRID%>>
  <param name="DataID" value="DS_EXCEL">
  <param Name="IndicatorInfo" value='<INDICATORINFO width="0" fontsize="9" indexnumber="true"/>'>
  <param Name="sort"      value="false">
</object>
</comment><script>_ws_(_NSID_);</script>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
