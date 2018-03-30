<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영계획> 월별조직별매출계획조회
 * 작 성 일 : 2011.06.23
 * 작 성 자 : 최재형
 * 수 정 자 : 
 * 파 일 명 : meis0440.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영계획의 월별 점별 매출/이익액/이익율 계획을 조회한다.
 * 이    력 :
 *        2011.06.23 (최재형) 신규작성
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
//조회여부
var lo_searchFlag = false;
var lo_tabIdx = 1;
var lo_StrNm = "";
var lo_PlanY = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();

    //탭 초기화
    initTab("TB_NORMAL");
    
    //그리드 초기화
    gridCreate();
    
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 최재형
 * 작 성 일 :  2011-06-17
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
    initEmEdit(EM_PLAN_YEAR, "THISYR", PK); //계획년도
    lo_PlanY = EM_PLAN_YEAR.Text;
}

/**
 * setCombo()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){

    initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);   //점(조회)
    getStore("DS_STR_CD", "N", "", "N");         //점콤보 가져오기 ( gauce.js )
   
    //콤보데이터 기본값 설정( gauce.js )
    setComboData("LC_STR_CD",'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정

    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }

}

/**
 * gridCreate()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	 
	var subSumBgColor = '{decode(curlevel,9999,"#BDDBEF",1,"#FFD0D0")}';		//레벨별 배경색
	var amtUnit = "1000000";
	var subSumText = "";														//소계 텍스트	
	var value = "";
	
	var gd_salesPlanHeader  = '<FC>id={currow} name="NO"          width=25  align=center	 		 SubBgColor=' + subSumBgColor + ' </FC>';
	gd_salesPlanHeader += '<FC>id=ORG_CD   name="조직코드"              width=60  align=center    SubBgColor=' + subSumBgColor + ' </FC>';
	subSumText 	= '{decode(curlevel,9999,"합계",1,"소계")}';
	value		= "{ORG_NAME}";
	gd_salesPlanHeader += '<FC>id=ORG_NAME name="조직명" value=' + value + '    SubSumText=' + subSumText + '          width=100 align=left        SubBgColor=' + subSumBgColor + ' </FC>';
	subSumText 	= "{ROUND(SUBSUM(PLAN_SALES_AMT)/" + amtUnit + ",0)}";
	value		= '{ROUND(PLAN_SALES_AMT/' + amtUnit + ',0)}';		
	gd_salesPlanHeader += '<C>id=PLAN_SALES_AMT name="매출금액" value=' + value + ' SubSumText=' + subSumText + '       width=80  align=right     SubBgColor=' + subSumBgColor + ' </C>';
	subSumText 	= "{ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/" + amtUnit + ",0)}";
	value		= '{ROUND(PLAN_SALES_PROFIT_AMT/' + amtUnit + ',0)}';				
	gd_salesPlanHeader += '<C>id=PLAN_SALES_PROFIT_AMT name="매출이익액" value=' + value + '    SubSumText=' + subSumText + '  width=80  align=right   SubBgColor=' + subSumBgColor + ' </C>';
	subSumText 	= '{ DECODE(SUBSUM(PLAN_SALES_AMT),0,0, SUBSUM(PLAN_SALES_PROFIT_AMT)/SUBSUM(PLAN_SALES_AMT)*100  ) }';
	value		= '{PLAN_PROFIT_RATE}';						
	gd_salesPlanHeader += '<C>id=PLAN_PROFIT_RATE  name="매출이익율" decao="2"  value=' + value + ' SubSumText=' + subSumText + ' width=80  align=right   SubBgColor=' + subSumBgColor + ' </C>';

	//계획매출액		
	//gd_salesPlanHeader += '<C>id=PLAN_SALES_AMT         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
	for(var i = 1; i <= 12; i++) {
		var mon = i + "";
		if(mon.length == 1) mon = "0" + mon;
		subSumText 	= '{ROUND(SUBSUM(PLAN_SALES_AMT_' + mon + ')/' + amtUnit + ',0)}';
		value		= '{ROUND(PLAN_SALES_AMT_' + mon + '/' + amtUnit + ',0)}';
		gd_salesPlanHeader += '<C>id=PLAN_SALES_AMT_' + mon + ' name="PLAN_SALES_AMT_' + mon + '" value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false </C>';		
	}
	
	//계획매출이익
    //gd_salesPlanHeader += '<C>id=PLAN_SALES_PROFIT_AMT         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
	for(var i = 1; i <= 12; i++) {
		var mon = i + "";
		if(mon.length == 1) mon = "0" + mon;
		subSumText 	= '{ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT_' + mon + ')/' + amtUnit + ',0)}';
		value		= '{ROUND(PLAN_SALES_PROFIT_AMT_' + mon + '/' + amtUnit + ',0)}';
		gd_salesPlanHeader += '<C>id=PLAN_SALES_PROFIT_AMT_' + mon + ' name=PLAN_SALES_PROFIT_AMT_' + mon + '  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false </C>';		
	}

	//계획이익율
    //gd_salesPlanHeader += '<C>id=PLAN_PROFIT_RATE         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
	for(var i = 1; i <= 12; i++) {
		var mon = i + "";
		if(mon.length == 1) mon = "0" + mon;
		subSumText 	= '{ DECODE(SUBSUM(PLAN_SALES_AMT_' + mon + '),0,0, SUBSUM(PLAN_SALES_PROFIT_AMT_' + mon + ')/SUBSUM(PLAN_SALES_AMT_' + mon + ')*100  ) }';
		value		= '{PLAN_PROFIT_RATE_' + mon + '}';
		gd_salesPlanHeader += '<C>id=PLAN_PROFIT_RATE_' + mon + ' name=PLAN_PROFIT_RATE_' + mon + ' value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false decao="2" </C>';		
	}
		
    //전년매출액
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {

			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_AMT)/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_AMT/' + amtUnit + ',0)}';
			gd_salesPlanHeader += '<C>id=PRE_SALES_AMT  name=PRE_SALES_AMT  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_AMT_' + mon + ')/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_AMT_' + mon + '/' + amtUnit + ',0)}';
			gd_salesPlanHeader += '<C>id=PRE_SALES_AMT_' + mon + ' name=PRE_SALES_AMT_' + mon + ' value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false </C>';					
		}
		
	}

    //전년매출이익
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {

			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_PROFIT_AMT/' + amtUnit + ',0)}';
			gd_salesPlanHeader += '<C>id=PRE_SALES_PROFIT_AMT name=PRE_SALES_PROFIT_AMT  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_PROFIT_AMT_' + mon + ')/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_PROFIT_AMT_' + mon + '/' + amtUnit + ',0)}';
			gd_salesPlanHeader += '<C>id=PRE_SALES_PROFIT_AMT_' + mon + ' name=PRE_SALES_PROFIT_AMT_' + mon + '  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false </C>';					
		}
		
	}    

    //전년이익율
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {
			subSumText 	= '{DECODE(SUBSUM(PRE_SALES_AMT),0,0, SUBSUM(PRE_SALES_PROFIT_AMT)/SUBSUM(PRE_SALES_AMT)*100   )}';
			value		= '{PRE_PROFIT_RATE}';
			gd_salesPlanHeader += '<C>id=PRE_PROFIT_RATE name=PRE_PROFIT_RATE  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false decao="2" </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{DECODE(SUBSUM(PRE_SALES_AMT_' + mon + '),0,0, SUBSUM(PRE_SALES_PROFIT_AMT_' + mon + ')/SUBSUM(PRE_SALES_AMT_' + mon + ')*100   )}';
			value		= '{PRE_PROFIT_RATE_' + mon + '}';
			gd_salesPlanHeader += '<C>id=PRE_PROFIT_RATE_' + mon + ' name=PRE_PROFIT_RATE_' + mon + '  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' show=false decao="2" </C>';					

		}
		
	}    
    
    initGridStyle(GD_SALES_PLAN, "common", gd_salesPlanHeader, false);

    
    var gd_salesPlanExcelHeader = '<FC>id={currow}          width=25  align=center	name="NO" 		 SubBgColor=' + subSumBgColor + ' </FC>';
    gd_salesPlanExcelHeader += '<C>id=ORG_CD                 width=60  align=center name="조직코드"   SubBgColor=' + subSumBgColor + ' </FC>';
	subSumText 	= '{decode(curlevel,9999,"합계",1,"소계")}';
	value		= "{ORG_NAME}";
	gd_salesPlanExcelHeader += '<FC>id=ORG_NAME name="조직명" value=' + value + '    SubSumText=' + subSumText + '          width=100 align=left        SubBgColor=' + subSumBgColor + ' </FC>';
    
    
	gd_salesPlanExcelHeader += '<X>name="계획"';
	
    gd_salesPlanExcelHeader += '<G>name="매출액"';
	//계획매출액
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {

			subSumText 	= '{ROUND(SUBSUM(PLAN_SALES_AMT)/' + amtUnit + ',0)}';
			value		= '{ROUND(PLAN_SALES_AMT/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT  name="년합계"  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{ROUND(SUBSUM(PLAN_SALES_AMT_' + mon + ')/' + amtUnit + ',0)}';
			value		= '{ROUND(PLAN_SALES_AMT_' + mon + '/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_' + mon + ' name='+i+'월    value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
		}
		
	}
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="매출이익"';
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {

			subSumText 	= '{ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/' + amtUnit + ',0)}';
			value		= '{ROUND(PLAN_SALES_PROFIT_AMT/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT name=년합계  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT_' + mon + ')/' + amtUnit + ',0)}';
			value		= '{ROUND(PLAN_SALES_PROFIT_AMT_' + mon + '/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_' + mon + ' name='+i+'월     value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
		}
		
	}     
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="이익율"';
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {
			subSumText 	= '{DECODE(SUBSUM(PLAN_SALES_AMT),0,0, SUBSUM(PLAN_SALES_PROFIT_AMT)/SUBSUM(PLAN_SALES_AMT)*100   )}';
			value		= '{PLAN_PROFIT_RATE}';
			gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE name="년합계"  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + '  decao="2" </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{DECODE(SUBSUM(PLAN_SALES_AMT_' + mon + '),0,0, SUBSUM(PLAN_SALES_PROFIT_AMT_' + mon + ')/SUBSUM(PLAN_SALES_AMT_' + mon + ')*100   )}';
			value		= '{PLAN_PROFIT_RATE_' + mon + '}';
			gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_' + mon + ' name="'+i+'월"  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + '  decao="2" </C>';					

		}
		
	}     
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '</X>';
    
    gd_salesPlanExcelHeader += '<X>name="전년실적"';
	
    gd_salesPlanExcelHeader += '<G>name="매출액"';
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {

			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_AMT)/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_AMT/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT  name=년합계  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_AMT_' + mon + ')/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_AMT_' + mon + '/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_' + mon + ' name=' + i + '월   value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
		}
		
	}    
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="매출이익"';
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {

			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_PROFIT_AMT/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT name=년합계  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{ROUND(SUBSUM(PRE_SALES_PROFIT_AMT_' + mon + ')/' + amtUnit + ',0)}';
			value		= '{ROUND(PRE_SALES_PROFIT_AMT_' + mon + '/' + amtUnit + ',0)}';
			gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_' + mon + ' name=' + i + '월   value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right </C>';					
		}
		
	}     
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="이익율"';
	for(var i = 0; i <= 12; i++) {
		if(i == 0) {
			subSumText 	= '{DECODE(SUBSUM(PRE_SALES_AMT),0,0, SUBSUM(PRE_SALES_PROFIT_AMT)/SUBSUM(PRE_SALES_AMT)*100   )}';
			value		= '{PRE_PROFIT_RATE}';
			gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE name=년  value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right  decao="2" </C>';					
			
		} else {

			var mon = i + "";
			if(mon.length == 1) mon = "0" + mon;
			
			subSumText 	= '{DECODE(SUBSUM(PRE_SALES_AMT_' + mon + '),0,0, SUBSUM(PRE_SALES_PROFIT_AMT_' + mon + ')/SUBSUM(PRE_SALES_AMT_' + mon + ')*100   )}';
			value		= '{PRE_PROFIT_RATE_' + mon + '}';
			gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_' + mon + ' name=' + i + '월   value=' + value + ' SubSumText=' + subSumText + '  SubBgColor=' + subSumBgColor + ' width=80  align=right  decao="2" </C>';					

		}
		
	}    
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '</X>';    
  
    
    
    //엑셀용
    initGridStyle(GD_SALES_PLAN_EXCEL, "common", gd_salesPlanExcelHeader, false);
    
}

/**
 * gridCreate()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate_bak(){
	
	var gd_salesPlanHeader  = '<FC>id={currow}          width=25  align=center	name="NO" 		 BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
		gd_salesPlanHeader += '<FC>id=ORG_CD                 width=60  align=center name="조직코드"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
		gd_salesPlanHeader += '<FC>id=ORG_NAME               width=100 align=left   name="조직명"     BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
		gd_salesPlanHeader += '<C>id=PLAN_SALES_AMT         width=80  align=right  name="매출금액"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
		gd_salesPlanHeader += '<C>id=PLAN_SALES_PROFIT_AMT  width=80  align=right  name="매출이익액" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
		gd_salesPlanHeader += '<C>id=PLAN_PROFIT_RATE width=80  align=right  name="매출이익율" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
				         
    initGridStyle(GD_SALES_PLAN, "common", gd_salesPlanHeader, false);
    
    var gd_salesPlanExcelHeader = '<FC>id={currow}          width=25  align=center	name="NO" 		 BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
    gd_salesPlanExcelHeader += '<C>id=ORG_CD                 width=60  align=center name="조직코드"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
    gd_salesPlanExcelHeader += '<C>id=ORG_NAME               width=100 align=left   name="조직명"     BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
	
    gd_salesPlanExcelHeader += '<X>name="계획"';
	
    gd_salesPlanExcelHeader += '<G>name="매출액"';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_01         width=80  align=right  name="1월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_02         width=80  align=right  name="2월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_03         width=80  align=right  name="3월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_04         width=80  align=right  name="4월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_05         width=80  align=right  name="5월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_06         width=80  align=right  name="6월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_07         width=80  align=right  name="7월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_08         width=80  align=right  name="8월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_09         width=80  align=right  name="9월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_10         width=80  align=right  name="10월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_11         width=80  align=right  name="11월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_AMT_12         width=80  align=right  name="12월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="매출이익"';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_01         width=80  align=right  name="1월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_02         width=80  align=right  name="2월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_03         width=80  align=right  name="3월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_04         width=80  align=right  name="4월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_05         width=80  align=right  name="5월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_06         width=80  align=right  name="6월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_07         width=80  align=right  name="7월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_08         width=80  align=right  name="8월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_09         width=80  align=right  name="9월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_10         width=80  align=right  name="10월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_11         width=80  align=right  name="11월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_SALES_PROFIT_AMT_12         width=80  align=right  name="12월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="이익율"';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_01         width=80  align=right  name="1월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_02         width=80  align=right  name="2월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_03         width=80  align=right  name="3월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_04         width=80  align=right  name="4월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_05         width=80  align=right  name="5월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_06         width=80  align=right  name="6월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_07         width=80  align=right  name="7월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_08         width=80  align=right  name="8월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_09         width=80  align=right  name="9월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_10         width=80  align=right  name="10월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_11         width=80  align=right  name="11월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PLAN_PROFIT_RATE_12         width=80  align=right  name="12월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '</X>';
    
    gd_salesPlanExcelHeader += '<X>name="전년실적"';
	
    gd_salesPlanExcelHeader += '<G>name="매출액"';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_01         width=80  align=right  name="1월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_02         width=80  align=right  name="2월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_03         width=80  align=right  name="3월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_04         width=80  align=right  name="4월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_05         width=80  align=right  name="5월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_06         width=80  align=right  name="6월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_07         width=80  align=right  name="7월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_08         width=80  align=right  name="8월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_09         width=80  align=right  name="9월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_10         width=80  align=right  name="10월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_11         width=80  align=right  name="11월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_AMT_12         width=80  align=right  name="12월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="매출이익"';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT         width=80  align=right  name="년합계"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_01         width=80  align=right  name="1월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_02         width=80  align=right  name="2월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_03         width=80  align=right  name="3월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_04         width=80  align=right  name="4월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_05         width=80  align=right  name="5월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_06         width=80  align=right  name="6월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_07         width=80  align=right  name="7월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_08         width=80  align=right  name="8월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_09         width=80  align=right  name="9월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_10         width=80  align=right  name="10월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_11         width=80  align=right  name="11월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_SALES_PROFIT_AMT_12         width=80  align=right  name="12월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '<G>name="이익율"';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE         width=80  align=right  name="년"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_01         width=80  align=right  name="1월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_02         width=80  align=right  name="2월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_03         width=80  align=right  name="3월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_04         width=80  align=right  name="4월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_05         width=80  align=right  name="5월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_06         width=80  align=right  name="6월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_07         width=80  align=right  name="7월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_08         width=80  align=right  name="8월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_09         width=80  align=right  name="9월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_10         width=80  align=right  name="10월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_11         width=80  align=right  name="11월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '<C>id=PRE_PROFIT_RATE_12         width=80  align=right  name="12월"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_salesPlanExcelHeader += '</G>';
	
    gd_salesPlanExcelHeader += '</X>';    
  
    
    
    //엑셀용
    initGridStyle(GD_SALES_PLAN_EXCEL, "common", gd_salesPlanExcelHeader, false);
    
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
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
	//조회 초기화
	lo_searchFlag = false;

	//dataset 초기화
	DS_SALES_PLAN.ClearData();
    
    //1. validation
    if (isNull(EM_PLAN_YEAR.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영계획년도"); //(경영계획년도)은/는 반드시 입력해야 합니다.
        EM_PLAN_YEAR.focus();
        return;
    }

	var goTo = "searchSalesPlan";
	var action     = "O";
	var parameters = "";
	parameters    += "&strStrCd=" + LC_STR_CD.BindColVal; 			//점코드
	parameters    += "&strPlanY=" + EM_PLAN_YEAR.text;    			//경영계획년도
	parameters    += "&strOrgLevel=" + RD_ORG_LEVEL.CodeValue;    	//조직레벨
	
	
    lo_PlanY = EM_PLAN_YEAR.Text;
    lo_StrNm = LC_STR_CD.Text;
	
    DS_SALES_PLAN.DataID   = "/mss/meis044.me?goTo="+goTo+parameters;
    DS_SALES_PLAN.SyncLoad = "true";
    DS_SALES_PLAN.Reset();

}

/**
 * btn_New()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 엑셀저장용 데이터 조회
 * return값 : void
 */
function btn_Excel() {
	
	if(!lo_searchFlag || DS_SALES_PLAN.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
	    return false;
	}	 

	var goTo = "searchSalesPlan";
	var action     = "O";
	var parameters = "";
	parameters    += "&strStrCd=" + LC_STR_CD.BindColVal; 			//점코드
	parameters    += "&strPlanY=" + EM_PLAN_YEAR.text;    			//경영계획년도
	parameters    += "&strOrgLevel=" + "4";    	//조직레벨
	
	
    lo_PlanY = EM_PLAN_YEAR.Text;
    lo_StrNm = LC_STR_CD.Text;
	
    DS_SALES_PLAN_EXCEL.DataID   = "/mss/meis044.me?goTo="+goTo+parameters;
    DS_SALES_PLAN_EXCEL.SyncLoad = "true";
    DS_SALES_PLAN_EXCEL.Reset();
	
}

/**
 * btn_Excel()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 엑셀저장
 * return값 : void
 */
function btn_ExcelDownload() {
			
	var parameters  = "점코드="           	+ lo_StrNm;
		parameters += " , 경영계획년도= "  	+lo_PlanY;
	var ExcelTitle = "조직별매출계획";
	
	openExcel2(GD_SALES_PLAN_EXCEL, ExcelTitle, parameters, true );
	
}
	
/**
 * btn_Print()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
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
  * 작 성 자 : 최재형
  * 작 성 일 : 2011-06-17
  * 개    요 : 탭변경시 호출
  * return값 : void
  */ 
function fn_changeTab(tabId, tabIdx) {
	lo_tabIdx = tabIdx;
	
	UpdateChart(true);
}

/*************************************************************************
 * 4. 차트를 위한 함수
 *************************************************************************/
 
 /**
  * UpdateChart()
  * 작 성 자 : 최재형
  * 작 성 일 : 2011-06-17
  * 개    요 : 차트변경시 호출
  * return값 : void
  */ 
function UpdateChart(tabFlag) {	

	var tabIdx = lo_tabIdx;

	var rowIdx = DS_SALES_PLAN.RowPosition;

	var goTo = "chartCall";
	var parameters = "";
	
	for(var i = 1; i <= DS_SALES_PLAN.CountColumn; i++) {
		var colName =  DS_SALES_PLAN.ColumnID(i);
		var value = GD_SALES_PLAN.VirtualString2(rowIdx,colName,1);
		if(colName == "ORG_NAME") value = encodeURIComponent(value);
		parameters += "&" + colName + "=" + value;
	}
	
	parameters += "&strPlanY=" + lo_PlanY;
	
	if(!tabFlag) {
		//매출액 차트 호출
		var CHART_GB = "IFRAME_SALES_AMT_CHART";
		IFRAME_SALES_AMT_CHART.location.href = "/mss/meis044.me?goTo="+goTo+parameters+"&CHART_GB=" + CHART_GB;
		
		//매출이익 차트 호출
		CHART_GB = "IFRAME_SALES_PROFIT_AMT_CHART";
		IFRAME_SALES_PROFIT_AMT_CHART.location.href = "/mss/meis044.me?goTo="+goTo+parameters+"&CHART_GB=" + CHART_GB;				
	}
	
	if(tabIdx == 1) {
		//매출계획 차트 호출
		CHART_GB = "IFRAME_TAB1_SALES_PLAN_CHART";
		IFRAME_TAB1_SALES_PLAN_CHART.location.href = "/mss/meis044.me?goTo="+goTo+parameters+"&CHART_GB=" + CHART_GB;		
	} else if(tabIdx == 2) {
		//매출이익계획 차트 호출
		CHART_GB = "IFRAME_TAB2_SALES_PROFIT_PLAN_CHART";
		IFRAME_TAB2_SALES_PROFIT_PLAN_CHART.location.href = "/mss/meis044.me?goTo="+goTo+parameters+"&CHART_GB=" + CHART_GB;		
	}
	
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

<!--------------------- 2. TR Fail 메세지 처리  ----------------------------->

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_SALES_PLAN event=OnLoadStarted()>

//점:1, 파트:3, PC:4
var rdObj = document.getElementById("RD_ORG_LEVEL");
var value = rdObj.CodeValue;
if(value == "4") {
	DS_SALES_PLAN.SubSumExpr  = "total,1:STR_CD:DEPT_CD:TEAM_CD" ;
} else {
	DS_SALES_PLAN.SubSumExpr  = "total";
}

</script>

<script language=JavaScript for=DS_SALES_PLAN event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

	lo_searchFlag = true;
    setPorcCount("SELECT", rowcnt);
    GD_SALES_PLAN.Focus();
</script>

<script language=JavaScript for=DS_SALES_PLAN_EXCEL event=OnLoadStarted()>
//점:1, 파트:3, PC:4
DS_SALES_PLAN_EXCEL.SubSumExpr  = "total,1:STR_CD:DEPT_CD:TEAM_CD" ;
</script>

<script language=JavaScript for=DS_SALES_PLAN_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    btn_ExcelDownload();
    
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_SALES_PLAN  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=for=DS_SALES_PLAN_EXCEL  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_SALES_PLAN event=OnRowPosChanged(row)>
UpdateChart(false);
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->

<!-- 조회조건의 점코드 변경 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
lo_searchFlag = false;

//UpdateChart(false);

</script>

<script language=JavaScript for=GD_SALES_PLAN event=OnClick(row,colid)>
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
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>

    <!--[그리드]매출계획분석 -->
    <object id="DS_SALES_PLAN"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]매출계획분석 엑셀 -->
    <object id="DS_SALES_PLAN_EXCEL"      classid=<%= Util.CLSID_DATASET %>></object>
    


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
        <td class="PT01 PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            <tr>
                                <th width="80" class="point">점코드</th>
                                <td width="160">
                                    <comment id="_NSID_">
                                    <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80" class="point">경영계획년도</th>
                                <td width="70">
                                    <comment id="_NSID_">
                                    <object id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle"></object>
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="80" class="point">조직구분</th>
			                    <td>
			                        <comment id="_NSID_">
			                        <object id=RD_ORG_LEVEL classid=<%=Util.CLSID_RADIO%> tabindex=1 
			                                style="height:20; width:150">
			                            <param name=Cols    value="3">
			                            <param name=Format  value="1^점,3^파트,4^PC">
			                            <param name=CodeValue  value="1">
			                        </object>  
			                        </comment><script> _ws_(_NSID_);</script>
			                    </td>                               
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr><td class="dot"></td></tr>
  
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="*">
			            
			            <table width="100%" border="0" cellpadding="0" cellspacing="0">
			                <tr>
			                    <td>
                                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                                    	<tr>
                                    		<td  class="BD4A">
			                                    <comment id="_NSID_">
			                                    <object id=GD_SALES_PLAN width="100%" height=200 classid=<%=Util.CLSID_GRID%>>
			                                        <param name="DataID" value="DS_SALES_PLAN">
			                                    </object></comment><script>_ws_(_NSID_);</script> 
                                    		</td>
                                    	</tr>
                                    </table> 
			                    </td>
			                </tr>
			            </table>
                    </td>
					<td width="250">
			            <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                <tr>
			                    <td width="100%">
			                    	<!-- 매출액 차트 -->
									<iframe id="IFRAME_SALES_AMT_CHART" width="100%" height="200" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                </tr>
            			</table> 								
					</td>  
					<td width="250">
			            <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                <tr>
			                    <td width="100%">
			                    	<!-- 매출이익 차트 -->
									<iframe id="IFRAME_SALES_PROFIT_AMT_CHART" width="100%" height="200" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                </tr>
            			</table> 								
					</td>  					                  
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="PT05 PB03">
			<div id=TB_NORMAL width="100%" height=300 TitleWidth=100
				 TitleAlign="center" TitleStyle="" TitleGap=3>
				<menu TitleName="매출계획"      	DivId="tr_tab1"	ClickFunc="fn_changeTab"	 />
				<menu TitleName="매출이익계획"	DivId="tr_tab2" ClickFunc="fn_changeTab"	 />
			</div>             
        <!-- tab end --> 
        </td>
    </tr>
    <tr>
        <td>
        	<!-- 매출계획탭 Start -->
		    <div id="tr_tab1" class="PT05">
            	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                	<tr>
                    	<td width="100%">
                    		<!-- 매출계획 차트 -->
							<iframe id="IFRAME_TAB1_SALES_PLAN_CHART" width="100%" height="270" style="overflow:hidden;" 
									src=""></iframe>
                    	</td>
                	</tr>
         		</table>
		    </div>
		    <!-- 매출계획탭 End -->
    	</td>
    </tr>
    <tr>
        <td>
        	<!-- 매출이익계획탭 Start -->
		    <div id="tr_tab2" class="PT05">
            	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                	<tr>
                    	<td width="100%">
                    		<!-- 매출이익계획 차트 -->
							<iframe id="IFRAME_TAB2_SALES_PROFIT_PLAN_CHART" width="100%" height="270" style="overflow:hidden;" 
									src=""></iframe>
                    	</td>
                	</tr>
         		</table>
		    </div>
		    <!-- 매출이익계획탭 End -->
    	</td>
    </tr>        	
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
  <object id=GD_SALES_PLAN_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_SALES_PLAN_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>
