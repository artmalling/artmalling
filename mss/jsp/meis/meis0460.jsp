<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영계획> 월별조직별판관비계획조회
 * 작 성 일 : 2011.06.28
 * 작 성 자 : 최재형
 * 수 정 자 : 
 * 파 일 명 : meis0460.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영계획의 월별조직별판관비계획을 조회한다.
 * 이    력 :
 *        2011.06.28 (최재형) 신규작성
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
var lo_PlanY = "";

var lo_strCd = "";
var lo_deptCd = "";
var lo_teamCd = "";
var lo_pcCd = "";

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

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
 * 작 성 자 : 최재형
 * 작 성 일 :  2011-06-28
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
 * 작 성 일 : 2011-06-28
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){

    initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^90", 1, PK);   		//[조회용]점
    initComboStyle(LC_DEPT_CD, DS_DEPT_CD, "CODE^0^30,NAME^0^90", 1, NORMAL);	// [조회용]부분    
    initComboStyle(LC_TEAM_CD, DS_TEAM_CD, "CODE^0^30,NAME^0^90", 1, NORMAL); 	// [조회용]파트    
    initComboStyle(LC_PC_CD, DS_PC_CD, "CODE^0^30,NAME^0^90", 1, NORMAL); 		// [조회용]PC
    
    getStore("DS_STR_CD", "N", "", "Y");         //점콤보 가져오기 ( gauce.js )
   
    //콤보데이터 기본값 설정( gauce.js )
    setComboData("LC_STR_CD",'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정

    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }

}

/**
 * gridCreate()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){

	var subSumBgColor = '{decode(curlevel,9999,"#BDDBEF",1,"#FFD0D0")}';		//레벨별 배경색
	var amtUnit = "1000000";
	var subSumText = "";														//소계 텍스트	
	var value = "";	 
	 
	var gd_profitAndLossPlan  = '<FC>id={currow}          width=25  align=center	name="NO" 		 SubBgColor=' + subSumBgColor + ' </FC>';
	gd_profitAndLossPlan += '<FC>id=BIZ_CD                 width=70  align=center name="판관비;중분류항목"   SubBgColor=' + subSumBgColor + ' </FC>';
	subSumText 	= '{decode(curlevel,9999,"합계",1,"소계")}';
	value		= "{BIZ_CD_NM}";
	gd_profitAndLossPlan += '<FC>id=BIZ_CD_NM value=' + value + '    SubSumText=' + subSumText + '              width=100 align=left   name="판관비;중분류항목명"     SubBgColor=' + subSumBgColor + ' </FC>';
	gd_profitAndLossPlan += '<G>name="판관비계획"';
	subSumText 	= "{ROUND(SUBSUM(PRE_RSLT_AMT)/" + amtUnit + ",0)}";
	value		= '{ROUND(PRE_RSLT_AMT/' + amtUnit + ',0)}';
	gd_profitAndLossPlan += '<C>id=PRE_RSLT_AMT value=' + value + '    SubSumText=' + subSumText + '         width=80  align=right  name="전년실적"   SubBgColor=' + subSumBgColor + ' </C>';
	subSumText 	= "{ROUND(SUBSUM(PLAN_AMT)/" + amtUnit + ",0)}";
	value		= '{ROUND(PLAN_AMT/' + amtUnit + ',0)}';
	gd_profitAndLossPlan += '<C>id=PLAN_AMT value=' + value + '    SubSumText=' + subSumText + '  width=80  align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
	subSumText 	= '{ DECODE(SUBSUM(PRE_RSLT_AMT),0,0, (SUBSUM(PLAN_AMT)-SUBSUM(PRE_RSLT_AMT))/SUBSUM(PRE_RSLT_AMT)*100 ) }';
	value		= '{DECREASE_RATE}';
	gd_profitAndLossPlan += '<C>id=DECREASE_RATE decao="2" value=' + value + '    SubSumText=' + subSumText + ' width=80  align=right  name="절감율" SubBgColor=' + subSumBgColor + ' </C>';
	gd_profitAndLossPlan += '</G>';
	
    for(var i = 1; i <= 12; i++) {
    	var month = "";
    	if(i < 10) month = "0" + i;
    	else month = i + "";
    	
    	subSumText 	= "{ROUND(SUBSUM(PRE_RSLT_AMT_"+ month +")/" + amtUnit + ",0)}";
    	value		= '{ROUND(PRE_RSLT_AMT_'+ month +'/' + amtUnit + ',0)}';          
    	gd_profitAndLossPlan += '<C>id=PRE_RSLT_AMT_' + month + ' show=false value=' + value + '    SubSumText=' + subSumText + '        width=80  align=right  name="전년실적"   SubBgColor=' + subSumBgColor + ' </C>';
    	subSumText 	= "{ROUND(SUBSUM(PLAN_AMT_"+ month +")/" + amtUnit + ",0)}";
    	value		= '{ROUND(PLAN_AMT_'+ month +'/' + amtUnit + ',0)}';
    	gd_profitAndLossPlan += '<C>id=PLAN_AMT_' + month + ' show=false value=' + value + '    SubSumText=' + subSumText + '  width=80  align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
    	subSumText 	= '{ DECODE(SUBSUM(PRE_RSLT_AMT_'+ month +'),0,0, (SUBSUM(PLAN_AMT_'+ month +')-SUBSUM(PRE_RSLT_AMT_'+ month +'))/SUBSUM(PRE_RSLT_AMT_'+ month +')*100 ) }';
    	value		= '{DECREASE_RATE_'+ month +'}'; 
    	gd_profitAndLossPlan += '<C>id=DECREASE_RATE_' + month + ' show=false decao="2" value=' + value + '    SubSumText=' + subSumText + ' width=80  align=right  name="증감율" SubBgColor=' + subSumBgColor + ' </C>';
    }
	
				         
    initGridStyle(GD_SALE_AND_MANAGE, "common", gd_profitAndLossPlan, false);
    DS_SALE_AND_MANAGE.SubSumExpr  = "total";
    
    var gd_profitAndLossPlanExcelHeader = '<FC>id={currow}          width=25  align=center	name="NO" 		 SubBgColor=' + subSumBgColor + ' </FC>';
    gd_profitAndLossPlanExcelHeader += '<FC>id=BIZ_CD                 width=60  align=center name="판관비;중분류항목"   SubBgColor=' + subSumBgColor + ' </FC>';
	subSumText 	= '{decode(curlevel,9999,"합계",1,"소계")}';
	value		= "{BIZ_CD_NM}";
    gd_profitAndLossPlanExcelHeader += '<FC>id=BIZ_CD_NM value=' + value + '    SubSumText=' + subSumText + '              width=100 align=left   name="판관비;중분류항목명"     SubBgColor=' + subSumBgColor + ' </FC>';
    
    gd_profitAndLossPlanExcelHeader += '<X>name="판관비계획"';
    
    gd_profitAndLossPlanExcelHeader += '<G>name="합계"';
	subSumText 	= "{ROUND(SUBSUM(PRE_RSLT_AMT)/" + amtUnit + ",0)}";
	value		= '{ROUND(PRE_RSLT_AMT/' + amtUnit + ',0)}';    
    gd_profitAndLossPlanExcelHeader += '<C>id=PRE_RSLT_AMT value=' + value + '    SubSumText=' + subSumText + '        width=80  align=right  name="전년실적"   SubBgColor=' + subSumBgColor + ' </C>';
	subSumText 	= "{ROUND(SUBSUM(PLAN_AMT)/" + amtUnit + ",0)}";
	value		= '{ROUND(PLAN_AMT/' + amtUnit + ',0)}';
    gd_profitAndLossPlanExcelHeader += '<C>id=PLAN_AMT value=' + value + '    SubSumText=' + subSumText + '  width=80  align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
	subSumText 	= '{ DECODE(SUBSUM(PRE_RSLT_AMT),0,0, (SUBSUM(PLAN_AMT)-SUBSUM(PRE_RSLT_AMT))/SUBSUM(PRE_RSLT_AMT)*100 ) }';
	value		= '{DECREASE_RATE}';    
    gd_profitAndLossPlanExcelHeader += '<C>id=DECREASE_RATE decao="2" value=' + value + '    SubSumText=' + subSumText + ' width=80  align=right  name="절감율" SubBgColor=' + subSumBgColor + ' </C>';
    gd_profitAndLossPlanExcelHeader += '</G>';

    for(var i = 1; i <= 12; i++) {
    	var month = "";
    	if(i < 10) month = "0" + i;
    	else month = i + "";
    	
        gd_profitAndLossPlanExcelHeader += '<G>name=' + i + '"월"';
    	subSumText 	= "{ROUND(SUBSUM(PRE_RSLT_AMT_"+ month +")/" + amtUnit + ",0)}";
    	value		= '{ROUND(PRE_RSLT_AMT_'+ month +'/' + amtUnit + ',0)}';          
        gd_profitAndLossPlanExcelHeader += '<C>id=PRE_RSLT_AMT_' + month + ' value=' + value + '    SubSumText=' + subSumText + '        width=80  align=right  name="전년실적"   SubBgColor=' + subSumBgColor + ' </C>';
    	subSumText 	= "{ROUND(SUBSUM(PLAN_AMT_"+ month +")/" + amtUnit + ",0)}";
    	value		= '{ROUND(PLAN_AMT_'+ month +'/' + amtUnit + ',0)}';
        gd_profitAndLossPlanExcelHeader += '<C>id=PLAN_AMT_' + month + ' value=' + value + '    SubSumText=' + subSumText + '  width=80  align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
    	subSumText 	= '{ DECODE(SUBSUM(PRE_RSLT_AMT_'+ month +'),0,0, (SUBSUM(PLAN_AMT_'+ month +')-SUBSUM(PRE_RSLT_AMT_'+ month +'))/SUBSUM(PRE_RSLT_AMT_'+ month +')*100 ) }';
    	value		= '{DECREASE_RATE_'+ month +'}'; 
        gd_profitAndLossPlanExcelHeader += '<C>id=DECREASE_RATE_' + month + ' decao="2" value=' + value + '    SubSumText=' + subSumText + ' width=80  align=right  name="증감율" SubBgColor=' + subSumBgColor + ' </C>';
        gd_profitAndLossPlanExcelHeader += '</G>';
    }
    
    gd_profitAndLossPlanExcelHeader += '</X>';
    
    //엑셀용
    initGridStyle(GD_SALE_AND_MANAGE_EXCEL, "common", gd_profitAndLossPlanExcelHeader, false);
    DS_SALE_AND_MANAGE_EXCEL.SubSumExpr  = "total";
}

/**
 * gridCreate()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate_bak(){
	
	var gd_profitAndLossPlan  = '<FC>id={currow}          width=25  align=center	name="NO" 		 BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
	gd_profitAndLossPlan += '<FC>id=BIZ_CD                 width=70  align=center name="판관비;중분류항목"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
	gd_profitAndLossPlan += '<FC>id=BIZ_CD_NM               width=100 align=left   name="판관비;중분류항목명"     BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
	gd_profitAndLossPlan += '<G>name="판관비계획"';
	gd_profitAndLossPlan += '<C>id=PRE_RSLT_AMT         width=80  align=right  name="전년실적"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
	gd_profitAndLossPlan += '<C>id=PLAN_AMT  width=80  align=right  name="계획" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
	gd_profitAndLossPlan += '<C>id=DECREASE_RATE width=80  align=right  name="절감율" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
	gd_profitAndLossPlan += '</G>';
				         
    initGridStyle(GD_SALE_AND_MANAGE, "common", gd_profitAndLossPlan, false);
    
    var gd_profitAndLossPlanExcelHeader = '<FC>id={currow}          width=25  align=center	name="NO" 		 BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
    gd_profitAndLossPlanExcelHeader += '<FC>id=BIZ_CD                 width=60  align=center name="판관비;중분류항목"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
    gd_profitAndLossPlanExcelHeader += '<FC>id=BIZ_CD_NM               width=100 align=left   name="판관비;중분류항목명"     BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </FC>';
    
    gd_profitAndLossPlanExcelHeader += '<X>name="판관비계획"';
    
    gd_profitAndLossPlanExcelHeader += '<G>name="합계"';
    gd_profitAndLossPlanExcelHeader += '<C>id=PRE_RSLT_AMT         width=80  align=right  name="전년실적"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_profitAndLossPlanExcelHeader += '<C>id=PLAN_AMT  width=80  align=right  name="계획" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_profitAndLossPlanExcelHeader += '<C>id=DECREASE_RATE width=80  align=right  name="절감율" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
    gd_profitAndLossPlanExcelHeader += '</G>';

    for(var i = 1; i <= 12; i++) {
    	var month = "";
    	if(i < 10) month = "0" + i;
    	else month = i + "";
    	
        gd_profitAndLossPlanExcelHeader += '<G>name=' + i + '"월"';
        gd_profitAndLossPlanExcelHeader += '<C>id=PRE_RSLT_AMT_' + month + '         width=80  align=right  name="전년실적"   BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
        gd_profitAndLossPlanExcelHeader += '<C>id=PLAN_AMT_' + month + '  width=80  align=right  name="계획" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
        gd_profitAndLossPlanExcelHeader += '<C>id=DECREASE_RATE_' + month + ' width=80  align=right  name="증감율" BgColor={decode(GROUP_ID,2,"#BDDBEF",1,"#FFD0D0")} </C>';
        gd_profitAndLossPlanExcelHeader += '</G>';
    }
    
    gd_profitAndLossPlanExcelHeader += '</X>';
    
    //엑셀용
    initGridStyle(GD_SALE_AND_MANAGE_EXCEL, "common", gd_profitAndLossPlanExcelHeader, false);
    
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
 * 작 성 일 : 2011-06-28
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
	//조회 초기화
	lo_searchFlag = false;

	//dataset 초기화
	DS_SALE_AND_MANAGE.ClearData();
    
    //1. validation
    if (isNull(EM_PLAN_YEAR.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영계획년도"); //(경영계획년도)은/는 반드시 입력해야 합니다.
        EM_PLAN_YEAR.focus();
        return;
    }
    
    var orgLevel = RD_ORG_LEVEL.CodeValue;

    if(orgLevel == "1") {
    	//dummy
    } else if(orgLevel == "2") {
    	
    	if(LC_STR_CD.BindColVal == "%") {
    		showMessage(INFORMATION, OK, "USER-1000", "점코드를 입력하세요.");
    		if(LC_STR_CD.Enable) LC_STR_CD.focus();
    		return;
    	} 
    	
    } else if(orgLevel == "3") {
    	
    	if(LC_DEPT_CD.BindColVal == "%") {
    		showMessage(INFORMATION, OK, "USER-1000", "팀코드를 입력하세요.");
    		if(LC_DEPT_CD.Enable) LC_DEPT_CD.focus();
    		return;
    	} else if(LC_STR_CD.BindColVal == "%") {
    		showMessage(INFORMATION, OK, "USER-1000", "점코드를 입력하세요.");
    		if(LC_STR_CD.Enable) LC_STR_CD.focus();
    		return;
    	} 
    	
    } else if(orgLevel == "4") {
    	
    	if(LC_TEAM_CD.BindColVal == "%") {
    		showMessage(INFORMATION, OK, "USER-1000", "파트코드를 입력하세요.");
    		if(LC_TEAM_CD.Enable) LC_TEAM_CD.focus();
    		return;
    	} else if(LC_TEAM_CD.BindColVal == "%") {
    		showMessage(INFORMATION, OK, "USER-1000", "팀코드를 입력하세요.");
    		if(LC_TEAM_CD.Enable) LC_TEAM_CD.focus();
    		return;
    	} else if(LC_STR_CD.BindColVal == "%") {
    		showMessage(INFORMATION, OK, "USER-1000", "점코드를 입력하세요.");
    		if(LC_STR_CD.Enable) LC_STR_CD.focus();
    		return;
    	}
    	
    }     

	var goTo = "searchSaleAndManagePlan";
	var action     = "O";
	var parameters = "";
	
	parameters    += "&strPlanY=" 		+ EM_PLAN_YEAR.text;    			//경영계획년도
	parameters    += "&strOrgLevel=" 	+ RD_ORG_LEVEL.CodeValue;    	//조직레벨
	parameters    += "&strStrCd=" 		+ LC_STR_CD.BindColVal; 			//점코드
	parameters    += "&strDeptCd=" 		+ LC_DEPT_CD.BindColVal; 			//팀코드
	parameters    += "&strTeamCd=" 		+ LC_TEAM_CD.BindColVal; 			//파트코드
	parameters    += "&strPcCd=" 		+ LC_PC_CD.BindColVal; 			//PC코드
	
    lo_PlanY 	= EM_PLAN_YEAR.Text;
	lo_strCd = LC_STR_CD.BindColVal;
	lo_deptCd = LC_DEPT_CD.BindColVal;
	lo_teamCd = LC_TEAM_CD.BindColVal;
	lo_pcCd = LC_PC_CD.BindColVal;
	
    DS_SALE_AND_MANAGE.DataID   = "/mss/meis046.me?goTo="+goTo+parameters;
    DS_SALE_AND_MANAGE.SyncLoad = "true";
    DS_SALE_AND_MANAGE.Reset();

}

/**
 * btn_New()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 엑셀저장용 데이터 조회
 * return값 : void
 */
function btn_Excel() {

	if(!lo_searchFlag || DS_SALE_AND_MANAGE.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
	    return false;
	}	 

	var goTo = "searchSaleAndManagePlan";
	var action     = "O";
	var parameters = "";
	
	parameters    += "&strPlanY=" 		+ lo_PlanY;    			//경영계획년도
	parameters    += "&strOrgLevel=" 	+ RD_ORG_LEVEL.CodeValue;    	//조직레벨
	parameters    += "&strStrCd=" 		+ lo_strCd; 			//점코드
	parameters    += "&strDeptCd=" 		+ lo_deptCd; 			//팀코드
	parameters    += "&strTeamCd=" 		+ lo_teamCd; 			//파트코드
	parameters    += "&strPcCd=" 		+ lo_pcCd; 			//PC코드

    DS_SALE_AND_MANAGE_EXCEL.DataID   = "/mss/meis046.me?goTo="+goTo+parameters;
    DS_SALE_AND_MANAGE_EXCEL.SyncLoad = "true";
    DS_SALE_AND_MANAGE_EXCEL.Reset();
}

/**
 * btn_Excel()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 엑셀저장
 * return값 : void
 */
function btn_ExcelDownload() {
			
	var parameters  = "조직명="           	+ DS_SALE_AND_MANAGE_EXCEL.NameString(1,"ORG_NAME");
		parameters += " , 경영계획년도= "  	+ lo_PlanY;
	var ExcelTitle = "조직별손익계획";
	
	openExcel2(GD_SALE_AND_MANAGE_EXCEL, ExcelTitle, parameters, true );
	
}
	
/**
 * btn_Print()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-28
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * fn_getOrg()
  * 작 성 자 : 최재형
  * 작 성 일 : 2011-06-28
  * 개    요 : 조직조회
  * return값 : void
  */ 
function fn_getOrg(dataSet, strAllGb, strStrCd, strDeptCd, strTeamCd, strPcCd, strOrgLevel) {
		
	var goTo = "getOrg";
	var parameters  = "&strAllGb=" +  strAllGb;
		parameters += "&strStrCd=" +  strStrCd;
		parameters += "&strDeptCd=" +  strDeptCd;
		parameters += "&strTeamCd=" +  strTeamCd;
		parameters += "&strPcCd=" +  strPcCd;
		parameters += "&strOrgLevel=" +  strOrgLevel;
		
	dataSet.DataID   = "/mss/meis043.me?goTo="+goTo+parameters;
	dataSet.SyncLoad = "true";
	dataSet.Reset();
		
}

/*************************************************************************
 * 4. 차트를 위한 함수
 *************************************************************************/
 
 /**
  * UpdateChart()
  * 작 성 자 : 최재형
  * 작 성 일 : 2011-06-28
  * 개    요 : 차트변경시 호출
  * return값 : void
  */ 
function UpdateChart(searchFlag) {	

	var goTo = "chartCall";
	var parameters = "";
	parameters    += "&strPlanY=" 		+ lo_PlanY;    			//경영계획년도
	parameters    += "&strOrgLevel=" 	+ RD_ORG_LEVEL.CodeValue;    	//조직레벨
	parameters    += "&strStrCd=" 		+ lo_strCd; 			//점코드
	parameters    += "&strDeptCd=" 		+ lo_deptCd; 			//팀코드
	parameters    += "&strTeamCd=" 		+ lo_teamCd; 			//파트코드
	parameters    += "&strPcCd=" 		+ lo_pcCd; 			//PC코드

	//손익계획 차트 호출
	if(searchFlag) {
		var CHART_GB = "IFRAME_SALE_AND_MANAGE_CHART";
		IFRAME_SALE_AND_MANAGE_CHART.location.href = "/mss/meis046.me?goTo="+goTo+parameters+"&CHART_GB=" + CHART_GB;		
	} else {
		
		var rowIdx = DS_SALE_AND_MANAGE.RowPosition;
		
		for(var i = 1; i <= DS_SALE_AND_MANAGE.CountColumn; i++) {
			var colName =  DS_SALE_AND_MANAGE.ColumnID(i);
			//var value = GD_SALES_RSLT.VirtualString2(rowIdx,colName,1);
			//var value = DS_SALE_AND_MANAGE.NameString(rowIdx,colName);
			var value = GD_SALE_AND_MANAGE.VirtualString2(rowIdx,colName,1);
			if(colName == "ORG_NAME" || colName == "BIZ_CD_NM") value = encodeURIComponent(value);
			parameters += "&" + colName + "=" + value;
		}
		
		//손익계획 월별추이 차트 호출
		CHART_GB = "IFRAME_SALE_AND_MANAGE_PLAN_CHART";
		IFRAME_SALE_AND_MANAGE_PLAN_CHART.location.href = "/mss/meis046.me?goTo="+goTo+parameters+"&CHART_GB=" + CHART_GB;				
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
<script language=JavaScript for=DS_SALE_AND_MANAGE event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

	lo_searchFlag = true;
    setPorcCount("SELECT", rowcnt);
    GD_SALE_AND_MANAGE.Focus();
    UpdateChart(true);
</script>

<script language=JavaScript for=DS_SALE_AND_MANAGE_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    btn_ExcelDownload();
    
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_SALE_AND_MANAGE  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=for=DS_SALE_AND_MANAGE_EXCEL  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_SALE_AND_MANAGE event=OnRowPosChanged(row)>
UpdateChart(false);
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=RD_ORG_LEVEL event=OnSelChange()>

</script>


<!-- 조회조건의 점코드 변경 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
lo_searchFlag = false;

//DATASET,전체구분,점,팀,파트,PC,조직레벨
fn_getOrg(DS_DEPT_CD, "Y", LC_STR_CD.BindColVal, "%", "%", "%", "2");
LC_DEPT_CD.Index= 0;
if(LC_STR_CD.BindColVal == "%") enableControl(LC_DEPT_CD, false);	
else enableControl(LC_DEPT_CD, true);	
</script>
<!-- 조회조건의 팀코드 변경 -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
lo_searchFlag = false;

//DATASET,전체구분,점,팀,파트,PC,조직레벨
fn_getOrg(DS_TEAM_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "%", "%", "3");
LC_TEAM_CD.Index= 0;
if(LC_DEPT_CD.BindColVal == "%") enableControl(LC_TEAM_CD, false);	
else enableControl(LC_TEAM_CD, true);
</script>

<!-- 조회조건의 파트코드 변경 -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
lo_searchFlag = false;

//DATASET,전체구분,점,팀,파트,PC,조직레벨
fn_getOrg(DS_PC_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "%", "4");
LC_PC_CD.Index= 0;
if(LC_TEAM_CD.BindColVal == "%") enableControl(LC_PC_CD, false);	
else enableControl(LC_PC_CD, true);
</script>

<!-- 조회조건의 PC코드 변경 -->
<script language=JavaScript for=LC_PC_CD event=OnSelChange()>
lo_searchFlag = false;

</script>

<script language=JavaScript for=GD_SALE_AND_MANAGE event=OnClick(row,colid)>
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
    <!--[콤보]팀코드 -->
    <object id="DS_DEPT_CD"   classid=<%= Util.CLSID_DATASET %>></object>    
    <!--[콤보]파트코드 -->
    <object id="DS_TEAM_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]PC코드 -->
    <object id="DS_PC_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    
    <!--[그리드]매출계획분석 -->
    <object id="DS_SALE_AND_MANAGE"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]매출계획분석 엑셀 -->
    <object id="DS_SALE_AND_MANAGE_EXCEL"      classid=<%= Util.CLSID_DATASET %>></object>
    


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
                                <th width="8%" class="point">계획년도</th>
                                <td width="42%" colspan="3">
                                    <comment id="_NSID_">
                                    <object id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle"></object>
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                                <th width="8%" class="point">조직구분</th>
			                    <td width="42%" colspan="3">
			                        <comment id="_NSID_">
			                        <object id=RD_ORG_LEVEL classid=<%=Util.CLSID_RADIO%>
			                                style="height:20; width:200">
			                            <param name=Cols    value="4">
			                            <param name=Format  value="1^점,2^팀,3^파트,4^PC">
			                            <param name=CodeValue  value="1">
			                        </object>  
			                        </comment><script> _ws_(_NSID_);</script>
			                    </td>                               
                            </tr>
                            
                            <tr>
                                <th>점</th>
                                <td>
                                    <comment id="_NSID_">
                                    <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> 
                                    		width=130 align="absmiddle"></object>
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>팀</th>
                                <td>
                                    <comment id="_NSID_">
                                    <object id=LC_DEPT_CD classid=<%= Util.CLSID_LUXECOMBO %> 
                                    		width=130 align="absmiddle"></object>
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>파트</th>
                                <td>
	                                <comment id="_NSID_"> 
	                                <object id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%>
											width=130 align="absmiddle"> 
									</object> 
									</comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>PC</th>
                                <td>
	                                <comment id="_NSID_"> 
	                                <object id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%>
											width=130 align="absmiddle"> 
									</object> 
									</comment><script>_ws_(_NSID_);</script>
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
			                                    <object id=GD_SALE_AND_MANAGE width="100%" height=180 classid=<%=Util.CLSID_GRID%>>
			                                        <param name="DataID" value="DS_SALE_AND_MANAGE">
			                                    </object></comment><script>_ws_(_NSID_);</script> 
                                    		</td>
                                    	</tr>
                                    </table> 
			                    </td>
			                </tr>
			            </table>
                    </td>
					<td width="400">
			            <table width="100%" height="180" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                <tr>
			                    <td width="100%">
			                    	<!-- 손익계획 차트 -->
									<iframe id="IFRAME_SALE_AND_MANAGE_CHART" width="100%" height="180" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                </tr>
            			</table> 								
					</td>  
                </tr>
            </table>
        </td>
    </tr>
	<tr><td height="5"></td></tr>    
    <tr>
        <td>
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            	<tr>
                	<td width="100%">
                   		<!-- 손익계획월별추이 차트 -->
						<iframe id="IFRAME_SALE_AND_MANAGE_PLAN_CHART" width="100%" height="295" style="overflow:hidden;" 
								src=""></iframe>
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
  <object id=GD_SALE_AND_MANAGE_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_SALE_AND_MANAGE_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>
