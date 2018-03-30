<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 실적요약> 주간 TREND 현황
 * 작 성 일 : 2011.06.21
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0810.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 주간 매출 트렌드 및 고객 현황을 조회한다.
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
    String strDate    = Date2.YYYYMMDD();

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
var lo_selectedRow  = 0;
var lo_StrNm        = "";
var lo_Date         = "";
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
	initEmEdit(EM_SALE_DT, "YYYYMMDD", PK); //경영실적년월
	EM_SALE_DT.Text = "<%=strDate%>";
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
    var hdrProperies = '<COLUMNINFO>' 
                     + '    <COLUMN id="STRCD" refcolid="STR_CD" >'
                     + '        <SUPPRESS><REFCOLID>STR_CD</REFCOLID></SUPPRESS>'
                     + '        <HEADER left="0" top="0" right="40" bottom="40" text="점코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="0" top="0" right="40" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="STRNM" refcolid="STR_NM" >'
                     + '        <SUPPRESS><REFCOLID>STR_NM</REFCOLID></SUPPRESS>'
                     + '        <HEADER left="40" top="0" right="120" bottom="40" text="점명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="40" top="0" right="120" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="DIVFLAG1" refcolid="DIV_FLAG1" >'
                     + '        <HEADER left="120" top="0" right="170" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="120" top="0" right="170" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="기간계"  bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="DIVFLAG2" refcolid="DIV_FLAG2" >'
                     + '        <VIEW left="120" top="20" right="170" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="월누계"  bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="TOTSALE" >'
                     + '        <HEADER left="170" top="0" right="890" bottom="20" text="매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="ORIGINSALETAMT1" refcolid="ORIGIN_SALE_TAMT1" >'
                     + '        <HEADER left="170" top="20" right="280" bottom="40" text="계획" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="170" top="0" right="280" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT1)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="ORIGINSALETAMT2" refcolid="ORIGIN_SALE_TAMT2" >'
                     + '        <VIEW left="170" top="20" right="280" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT2)"  align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="EVTSALEAMT1" refcolid="EVT_SALE_AMT1" >'
                     + '        <HEADER left="280" top="20" right="390" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="280" top="0" right="390" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(EVT_SALE_AMT1)"  align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="EVTSALEAMT2" refcolid="EVT_SALE_AMT2" >'
                     + '        <VIEW left="280" top="20" right="390" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(EVT_SALE_AMT2)" align="RightCenter"  bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="NORMSALAMT1" refcolid="NORM_SAL_AMT1" >'
                     + '        <HEADER left="390" top="20" right="500" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="390" top="0" right="500" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(NORM_SAL_AMT1)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="NORMSALAMT2" refcolid="NORM_SAL_AMT2" >'
                     + '        <VIEW left="390" top="20" right="500" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(NORM_SAL_AMT2)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="TOTSALEAMT1" refcolid="TOT_SALE_AMT1" >'
                     + '        <HEADER left="500" top="20" right="620" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="500" top="0" right="620" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(TOT_SALE_AMT1)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="TOTSALEAMT2" refcolid="TOT_SALE_AMT2" >'
                     + '        <VIEW left="500" top="20" right="620" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(TOT_SALE_AMT2)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="RATIO11" refcolid="RATIO11" >'
                     + '        <HEADER left="620" top="20" right="700" bottom="40" text="달성율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="620" top="0" right="700" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(RATIO11)" align="RightCenter" bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="RATIO12" refcolid="RATIO12" >'
                     + '        <VIEW left="620" top="20" right="700" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(RATIO12)" align="RightCenter" bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="LSTSALEAMT1" refcolid="LST_SALE_AMT1" >'
                     + '        <HEADER left="700" top="20" right="810" bottom="40" text="전년실적" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="700" top="0" right="810" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(LST_SALE_AMT1)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="LSTSALEAMT2" refcolid="LST_SALE_AMT2" >'
                     + '        <VIEW left="700" top="20" right="810" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(LST_SALE_AMT2)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="RATIO21" refcolid="RATIO21" >'
                     + '        <HEADER left="810" top="20" right="890" bottom="40" text="증감율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="810" top="0" right="890" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(RATIO21)" align="RightCenter" bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="RATIO22" refcolid="RATIO22" >'
                     + '        <VIEW left="810" top="20" right="890" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(RATIO22)" align="RightCenter" bgcolor="#b9d9ea"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="TOTSALE" >'
                     + '        <HEADER left="890" top="0" right="1080" bottom="20" text="구매고객" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="CNT1" refcolid="CNT1" >'
                     + '        <HEADER left="890" top="20" right="980" bottom="40" text="고객수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="890" top="0" right="980" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(CNT1)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="CNT2" refcolid="CNT2" >'
                     + '        <VIEW left="890" top="20" right="980" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,##0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(CNT2)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,##0"/>' 
                     + '    </COLUMN>'
                     
                     + '    <COLUMN id="SALEPRICE1" refcolid="SALE_PRICE1" >'
                     + '        <HEADER left="980" top="20" right="1080" bottom="40" text="객단가" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '        <VIEW left="980" top="0" right="1080" bottom="20" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,###.0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(SALE_PRICE1)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,###.0"/>' 
                     + '    </COLUMN>'                     
                     + '    <COLUMN id="SALEPRICE2" refcolid="SALE_PRICE2" >'
                     + '        <VIEW left="980" top="20" right="1080" bottom="40" align="RightCenter" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,###.0"/>'
                     + '        <VIEWSUMMARY text="@GFSUM(SALE_PRICE2)" align="RightCenter" bgcolor="#b9d9ea" displayformat="#,###.0"/>' 
                     + '    </COLUMN>'
        
        + '     </COLUMNINFO>';
        
    initMGridStyle(GD_TREND, "common", hdrProperies);
    DS_TREND.UseChangeInfo = true;  
    GD_TREND.ViewSummary   = 1;
    //GD_TREND.Sort = true;
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
	if( DS_TREND.IsUpdated){
        //변경내역이 있습니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1){
        	EM_SALE_DT.Focus();
            return false;
        }
    }
    
    //1. validation
    if (isNull(EM_SALE_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영실적년월"); //(경영실적년월)은/는 반드시 입력해야 합니다.
        EM_SALE_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_SALE_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "경영실적년월");//(경영실적년월)은/는 유효하지 않는 날짜입니다.
        EM_SALE_DT.focus();
        return;
    }
	
	DS_TREND.ClearData();
	
	lo_selectedRow = 0;
	
	var goTo       = "searchWeeklyTrend" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  + LC_STR_CD.BindColVal //점코드
                   + "&strSaleDt=" + EM_SALE_DT.text      //경영실적년월
                   ;
    
    IFR_WEEKLY_TREND.location.href = "/mss/jsp/blank.jsp";
    
    lo_StrNm = LC_STR_CD.text;
    lo_Date  = EM_SALE_DT.text;
    DS_TREND.DataID   = "/mss/meis081.me?goTo="+goTo+parameters;
    DS_TREND.SyncLoad = "true";
    DS_TREND.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
    var goTo = "chart";
    var parameters = "&strStrCd="  + DS_TREND.NameValue(row,"STR_CD")
                   + "&strSaleDt=" + DS_TREND.NameValue(row,"SALE_DT")  
                   ;
    IFR_WEEKLY_TREND.location.href = "/mss/meis081.me?goTo="+goTo+parameters;
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
	if(DS_TREND.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	    return;
	}
	var strTitle = "주간 TREND 현황";

	var strStrNm = lo_StrNm; //점
	var strDate  = lo_Date;  //일자
	    
	var parameters = "점 "                   + strStrNm
	               + ",   일자"             + strDate;
	    
	openExcelM(GD_TREND, strTitle, parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	if(DS_TREND.RowPosition == 0){
		showMessage(EXCLAMATION , OK, "USER-1031");
        return;
	}
	
	row = DS_TREND.RowPosition;
    var goTo = "chart";
    var parameters = "&strStrCd="  + DS_TREND.NameValue(row,"STR_CD")
                   + "&strSaleDt=" + DS_TREND.NameValue(row,"SALE_DT")
                   + "&strPrint=1"
                   ;
   IFR_WEEKLY_TREND_PRINT.location.href = "/mss/meis081.me?goTo="+goTo+parameters;
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
    row = DS_TREND.RowPosition;
    var params = "&strStrCd="    + DS_TREND.NameValue(row,"STR_CD")
               + "&strSaleDt="   + DS_TREND.NameValue(row,"SALE_DT")
               + "&strFileName=" + fileName

    window.open("/mss/meis081.me?goTo=print"+params,"OZREPORT", 1000, 700);
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
<script language=JavaScript for=DS_TREND event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_TREND.Focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_TREND  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_TREND event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
    	 if(lo_selectedRow != ((row+1)/2)){
    		 lo_selectedRow = (row+1)/2;
    		 subQuery(row);
    	 }
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_TREND event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_TREND event=OnLButtonDown(type,index,colid,x,y)>
    if(type == "5"){
    	if(DS_TREND.CountRow <= 0) return;
        var goTo = "chart";
        row = DS_TREND.RowPosition;
        var parameters = "&strStrCd="
                       + "&strSaleDt=" + DS_TREND.NameValue(row,"SALE_DT")  
                       ;
        IFR_WEEKLY_TREND.location.href = "/mss/meis081.me?goTo="+goTo+parameters;
        
        lo_selectedRow = 0;
        DS_TREND.RowPosition = 0;
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
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]-->
    <object id="DS_TREND"      classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80" class="point">일자</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYMD(this, '<%=strDate%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_SALE_DT)" align="absmiddle" />
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
    <td valign="top">
      <table width="100%" height="275" border="0" cellpadding="0" cellspacing="0" class="s_table">
        <tr>
          <td class="BD4A" width="100%">
            <iframe id="IFR_WEEKLY_TREND" width="100%" height="270" scrolling="yes" style="overflow-y:hidden;" src=""></iframe>
          </td>
        </tr>
      </table>                     
    </td>
  </tr>
  <tr valign="top" class="PT03">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_TREND width=100% height=206 classid=<%=Util.CLSID_MGRID%>>
                          <param name="DataID" value="DS_TREND">
                          <param Name="IndicatorInfo"       value='<INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                          <param Name="sort"      value="false">
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
  </tr>
</table>
<iframe id="IFR_WEEKLY_TREND_PRINT" width="0" height="0" style="overflow:hidden;" src=""></iframe>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
