<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영계획> 경영계획보고서조회
 * 작 성 일 : 2011.06.17
 * 작 성 자 : 최재형
 * 수 정 자 : 
 * 파 일 명 : meis0430.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영계획보고서조회를 조회한다.
 * 이    력 :
 *        2011.06.17 (최재형) 신규작성
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
var lo_tabChFlag = false;
var lo_teamSearchFlag = false;
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
    //tabInit(TB_NORMAL);
    //fn_changeTab(lo_tabIdx);
    initTab("TB_NORMAL");

    //그리드 초기화
    gridCreate();
    
    LC_STR_CD.Focus();
	
    //lo_searchFlag = true; 
    //setTimeout("btn_Search()", 100);
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
	

	var subSumBgColor = '{decode(curlevel,9999,"#BDDBEF",1,"#FFD0D0")}';		//레벨별 배경색;
	var amtUnit = "1000000";
	var subSumText = "";					//소계 텍스트	 
	
							

	var gd_tab1Header  = '<FC>id={currow}                  width=25 align=center name="NO"	SubBgColor=' + subSumBgColor + '  </FC>';
		gd_tab1Header += '<FC>id=ORG_CD                    width=80 align=center   name="조직코드"	SubBgColor=' + subSumBgColor + ' </FC>';
		
		subSumText = '{decode(curlevel,9999,"합계",1,"소계")}';
		gd_tab1Header += '<FC>id=ORG_NAME                  width=120 align=left     name="조직명" 	SubBgColor=' + subSumBgColor + ' SubSumText=' + subSumText + '  </FC>';

		gd_tab1Header += '<G>name="매출액(단위:백만)"';
		subSumText = "{ROUND(SUBSUM(PRE_SALES_AMT)/" + amtUnit + ",0)}";
		gd_tab1Header += '	<C>id=PRE_SALES_AMT     value={ROUND(PRE_SALES_AMT/' + amtUnit + ',0)}         width=80 align=right  name="전년" subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + '  </C>';
		subSumText = "{ROUND(SUBSUM(PLAN_SALES_AMT)/" + amtUnit + ",0)}";
		gd_tab1Header += '	<C>id=PLAN_SALES_AMT    value={ROUND(PLAN_SALES_AMT/' + amtUnit + ',0)}         width=80 align=right  name="계획" subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{DECODE(SUBSUM(PLAN_SALES_AMT),0,0, ROUND((SUBSUM(PLAN_SALES_AMT)-SUBSUM(PRE_SALES_AMT))/SUBSUM(PLAN_SALES_AMT)*100,2))}";
		gd_tab1Header += '	<C>id=SALES_GROWTH_RATE decao="2"   value={SALES_GROWTH_RATE}     width=60 align=right  name="신장율" subsumtext=' + subSumText + ' 	SubBgColor=' + subSumBgColor + ' </C>';
		gd_tab1Header += '</G>';
		
		gd_tab1Header += '<G>name="매출이익액(단위:백만)"';
		subSumText = "{ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/" + amtUnit + ",0)}";
		gd_tab1Header += '	<C>id=PRE_SALES_PROFIT_AMT  value={ROUND(PRE_SALES_PROFIT_AMT/' + amtUnit + ',0)}      width=80 align=right  name="전년" subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/" + amtUnit + ",0)}";
		gd_tab1Header += '	<C>id=PLAN_SALES_PROFIT_AMT  value={ROUND(PLAN_SALES_PROFIT_AMT/' + amtUnit + ',0)}     width=80 align=right  name="계획" subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{DECODE(SUBSUM(PLAN_SALES_PROFIT_AMT),0,0, ROUND((SUBSUM(PLAN_SALES_PROFIT_AMT)-SUBSUM(PRE_SALES_PROFIT_AMT))/SUBSUM(PLAN_SALES_PROFIT_AMT)*100,2))}";
		gd_tab1Header += '	<C>id=SALES_PROFIT_GROWTH_RATE decao="2"   value={SALES_PROFIT_GROWTH_RATE}   width=60 align=right  name="신장율" subsumtext=' + subSumText + '		SubBgColor=' + subSumBgColor + ' </C>';
		gd_tab1Header += '</G>';  

		gd_tab1Header += '<G>name="매출이익율(%)"';
		subSumText = "{DECODE(SUBSUM(PRE_SALES_AMT),0,0, ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/SUBSUM(PRE_SALES_AMT)*100,2)) }";
		gd_tab1Header += '	<C>id=PRE_SALES_PROFIT_RATE 	decao="2"   value={PRE_SALES_PROFIT_RATE}     width=80 align=right  name="전년" subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{DECODE(SUBSUM(PLAN_SALES_AMT),0,0, ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/SUBSUM(PLAN_SALES_AMT)*100,2)) }";
		gd_tab1Header += '	<C>id=PLAN_SALES_PROFIT_RATE    decao="2"   value={PLAN_SALES_PROFIT_RATE} width=80 align=right  name="계획" subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{(DECODE(SUBSUM(PLAN_SALES_AMT),0,0, ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/SUBSUM(PLAN_SALES_AMT)*100,2)))-(DECODE(SUBSUM(PRE_SALES_AMT),0,0, ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/SUBSUM(PRE_SALES_AMT)*100,2))) }";
		gd_tab1Header += '	<C>id=SALES_PROFIT_DIFFERENT    decao="2"   value={SALES_PROFIT_DIFFERENT} width=60 align=right  name="증감차"  subsumtext=' + subSumText + '	SubBgColor=' + subSumBgColor + '	</C>';
		gd_tab1Header += '</G>';              
				         
    initGridStyle(GD_TAB1, "common", gd_tab1Header, false);
    //GD_TAB1.ViewSummary = "1"; 
    
    //엑셀용
    initGridStyle(GD_TAB1_EXCEL, "common", gd_tab1Header, false);
    //GD_TAB1_EXCEL.ViewSummary = "1";    
    
    var gd_tab2Header  = '<FC>id={currow}                  width=25 align=center name="NO"	SubBgColor=' + subSumBgColor + '	</FC>';
    	gd_tab2Header += '<FC>id=ORG_CD      value={ORG_CD}              width=60 align=center   name="조직코드"	SubBgColor=' + subSumBgColor + '	</FC>';
    	
    	subSumText = '{decode(curlevel,9999,"합계",1,"소계")}';
    	gd_tab2Header += '<FC>id=ORG_NAME    value={ORG_NAME}              width=150 align=left     name="조직명"	SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</FC>';
    	
    	gd_tab2Header += '<G>name="매출"';
    	subSumText = '{DECODE(MAX(TOT_PRE_SALES_AMT),0,0, ROUND(SUBSUM(PRE_SALES_AMT)/MAX(TOT_PRE_SALES_AMT)*100,2) )}';
    	gd_tab2Header += '	<C>id=PRE_SALES_RATIO	decao="2"  value={PRE_SALES_RATIO}    width=80 align=right  name="전년구성비"	SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</C>';
    	subSumText = '{DECODE(MAX(TOT_PLAN_SALES_AMT),0,0, ROUND(SUBSUM(PLAN_SALES_AMT)/MAX(TOT_PLAN_SALES_AMT)*100,2) )}';
    	gd_tab2Header += '	<C>id=PLAN_SALES_RATIO	decao="2"  value={PLAN_SALES_RATIO}   width=80 align=right  name="계획구성비"	SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</C>';
    	subSumText = '{ DECODE(MAX(TOT_PLAN_SALES_AMT),0,0, ROUND(SUBSUM(PLAN_SALES_AMT)/MAX(TOT_PLAN_SALES_AMT)*100,2) ) - DECODE(MAX(TOT_PRE_SALES_AMT),0,0, ROUND(SUBSUM(PRE_SALES_AMT)/MAX(TOT_PRE_SALES_AMT)*100,2) ) }';
    	gd_tab2Header += '	<C>id=SALES_DIFFERENT 	decao="2"  value={SALES_DIFFERENT}  width=80 align=right  name="증감차"	SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</C>';
    	gd_tab2Header += '</G>';			             
    	
    	gd_tab2Header += '<G>name="매출이익"';
    	subSumText = '{DECODE(MAX(TOT_PRE_SALES_PROFIT_AMT),0,0, ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/MAX(TOT_PRE_SALES_PROFIT_AMT)*100,2) )}';
    	gd_tab2Header += '	<C>id=PRE_SALES_PROFIT_RATIO  decao="2"  value={PRE_SALES_PROFIT_RATIO}    width=80 align=right  name="전년구성비"	SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</C>';
    	subSumText = '{DECODE(MAX(TOT_PLAN_SALES_PROFIT_AMT),0,0, ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/MAX(TOT_PLAN_SALES_PROFIT_AMT)*100,2) )}';
    	gd_tab2Header += '	<C>id=PLAN_SALES_PROFIT_RATIO decao="2"  value={PLAN_SALES_PROFIT_RATIO}    width=80 align=right  name="계획구성비"	SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</C>';
    	subSumText = '{ DECODE(MAX(TOT_PLAN_SALES_PROFIT_AMT),0,0, ROUND(SUBSUM(PLAN_SALES_PROFIT_AMT)/MAX(TOT_PLAN_SALES_PROFIT_AMT)*100,2) ) - DECODE(MAX(TOT_PRE_SALES_PROFIT_AMT),0,0, ROUND(SUBSUM(PRE_SALES_PROFIT_AMT)/MAX(TOT_PRE_SALES_PROFIT_AMT)*100,2) ) }';
    	gd_tab2Header += '	<C>id=SALES_PROFIT_DIFFERENT  decao="2"  value={SALES_PROFIT_DIFFERENT}   width=80 align=right  name="증감차"		SubBgColor=' + subSumBgColor + ' subsumtext=' + subSumText + '	</C>';
    	gd_tab2Header += '</G>';
    	
    	subSumText = '{decode(curlevel,9999,FILL("1", LEN(MAX(GROUP_GUBUN))),1, FILL("0",LEN(MAX(GROUP_GUBUN))-1)&String(1))}';
    	gd_tab2Header += '<C>id=GROUP_GUBUN    show="false"    value={GROUP_GUBUN}            width=60 align=center   name="GROUP_GUBUN" subsumtext=' + subSumText + '	 	</C>';
    	subSumText = '{ DECODE(curlevel,9999,IF(MAX(STR_CD)="%","0000000000", MAX(STR_CD)&"00000000"),1, SUBMAX(STR_CD)&SUBMAX(DEPT_CD)&SUBMAX(TEAM_CD)&"0000"     )  }';
    	gd_tab2Header += '<C>id=HD_ORG_CD     show="false"     value={HD_ORG_CD}          width=60 align=center   name="HD_ORG_CD"	 subsumtext=' + subSumText + '	</C>';
    	subSumText = '{ MAX(BIZ_PLAN_YEAR) }';
    	gd_tab2Header += '<C>id=BIZ_PLAN_YEAR   show="false"   value={BIZ_PLAN_YEAR}              width=60 align=center   name="BIZ_PLAN_YEAR"	 subsumtext=' + subSumText + '	</C>';
    	subSumText = '{ MAX(ORG_LEVEL) }';
    	gd_tab2Header += '<C>id=ORG_LEVEL    show="false"     value={ORG_LEVEL}           width=60 align=center   name="ORG_LEVEL"	subsumtext=' + subSumText + ' 	</C>';
    	

	initGridStyle(GD_TAB2, "common", gd_tab2Header, false);
	//GD_TAB2.ViewSummary = "1";
	//엑셀용
    initGridStyle(GD_TAB2_EXCEL, "common", gd_tab2Header, false);
    //GD_TAB2_EXCEL.ViewSummary = "1";
	
    var gd_tab3Header  = '<FC>id={currow}                  width=25 align=center name="NO" 	SubBgColor=' + subSumBgColor + '	</FC>';
    	gd_tab3Header += '<FC>id=BIZ_CD                    width=60 align=center   name="대분류;항목코드" SubBgColor=' + subSumBgColor + '</FC>';
    	
    	subSumText = '{decode(curlevel,9999,"합계",1,"소계")}';
    	gd_tab3Header += '<FC>id=BIZ_CD_NM                  width=80 align=left     name="대분류;항목명"  subsumtext=' + subSumText + '  SubBgColor=' + subSumBgColor + '</FC>';
    	gd_tab3Header += '<G>name="손익계획"';
    	subSumText = "{ROUND(SUBSUM(PRE_RSLT_AMT)/" + amtUnit + ",0)}";
    	gd_tab3Header += '<C>id=PRE_RSLT_AMT value={ROUND(PRE_RSLT_AMT/' + amtUnit + ',0)}  subsumtext=' + subSumText + '   width=100 align=right  name="전년실적" SubBgColor=' + subSumBgColor + ' </C>';
    	subSumText = "{ROUND(SUBSUM(PLAN_AMT)/" + amtUnit + ",0)}";
    	gd_tab3Header += '<C>id=PLAN_AMT  	value={ROUND(PLAN_AMT/' + amtUnit + ',0)}	subsumtext=' + subSumText + '   width=100 align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
    	subSumText = '{ DECODE(SUBSUM(PRE_RSLT_AMT),0,0, ROUND((SUBSUM(PLAN_AMT) - SUBSUM(PRE_RSLT_AMT))/SUBSUM(PRE_RSLT_AMT)*100,2)  ) }';
    	gd_tab3Header += '<C>id=INC_DEC_RATIO decao="2"  subsumtext=' + subSumText + '   width=100 align=right  name="증감율" SubBgColor=' + subSumBgColor + ' </C>';
    	gd_tab3Header += '</G>';			             

	initGridStyle(GD_TAB3, "common", gd_tab3Header, false);
	DS_TAB3.SubSumExpr  = "total" ;

    var gd_tab3ExcelHeader  = '<FC>id={currow}                  width=25 align=center name="NO"  BgColor={decode(GROUP_ID,1,"#BDDBEF")} </FC>';
		gd_tab3ExcelHeader += '<FC>id=ORG_CD                    width=60 align=center   name="조직코드" BgColor={decode(GROUP_ID,1,"#BDDBEF")} </FC>';
		gd_tab3ExcelHeader += '<FC>id=ORG_NAME                  width=80 align=left     name="조직명"    BgColor={decode(GROUP_ID,1,"#BDDBEF")} </FC>';
    	gd_tab3ExcelHeader += '<FC>id=BIZ_CD                    width=60 align=center   name="대분류;항목코드"  BgColor={decode(GROUP_ID,1,"#BDDBEF")} </FC>';
    	gd_tab3ExcelHeader += '<FC>id=BIZ_CD_NM                  width=80 align=left     name="대분류;항목명"   BgColor={decode(GROUP_ID,1,"#BDDBEF")} </FC>';
    	gd_tab3ExcelHeader += '<G>name="손익계획"';
    	gd_tab3ExcelHeader += '<C>id=PRE_RSLT_AMT      width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,1,"#BDDBEF")} </C>';
    	gd_tab3ExcelHeader += '<C>id=PLAN_AMT     width=100 align=right  name="계획" BgColor={decode(GROUP_ID,1,"#BDDBEF")} </C>';
    	gd_tab3ExcelHeader += '<C>id=INC_DEC_RATIO     width=100 align=right  name="증감율" BgColor={decode(GROUP_ID,1,"#BDDBEF")} </C>';
    	gd_tab3ExcelHeader += '</G>';			             
	
	//엑셀용
    initGridStyle(GD_TAB3_EXCEL, "common", gd_tab3ExcelHeader, false);
	
	var gd_tab4_MHeader  = '<FC>id={currow}		width=25 align=center 	name="NO" SubBgColor=' + subSumBgColor + ' </FC>';
		gd_tab4_MHeader += '<FC>id=BIZ_CD       width=70 align=center   name="판관비;중분류항목" SubBgColor=' + subSumBgColor + ' </FC>';
		subSumText = '{decode(curlevel,9999,"합계",1,"소계")}';
		gd_tab4_MHeader += '<FC>id=BIZ_CD_NM  subsumtext=' + subSumText + '  width=80 align=left     name="판관비;중분류항목명"   SubBgColor=' + subSumBgColor + ' </FC>';
		gd_tab4_MHeader += '<G>name="판관비계획"';
		subSumText = "{ROUND(SUBSUM(PRE_RSLT_AMT)/" + amtUnit + ",0)}";
		gd_tab4_MHeader += '<C>id=PRE_RSLT_AMT  value={ROUND(PRE_RSLT_AMT/' + amtUnit + ',0)}  subsumtext=' + subSumText + '  width=100 align=right  name="전년실적" SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{ROUND(SUBSUM(PLAN_AMT)/" + amtUnit + ",0)}";
		gd_tab4_MHeader += '<C>id=PLAN_AMT  value={ROUND(PLAN_AMT/' + amtUnit + ',0)}  subsumtext=' + subSumText + ' width=100 align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
		//ROUND(DECODE(MMA.PRE_RSLT_AMT, 0, 0, (MMA.PLAN_AMT - MMA.PRE_RSLT_AMT)/MMA.PRE_RSLT_AMT*100),2)
		subSumText = '{ DECODE(SUBSUM(PRE_RSLT_AMT),0,0, ROUND((SUBSUM(PLAN_AMT) - SUBSUM(PRE_RSLT_AMT))/SUBSUM(PRE_RSLT_AMT)*100,2)  ) }';
		gd_tab4_MHeader += '<C>id=INC_DEC_RATIO  decao="2"  subsumtext=' + subSumText + '   width=100 align=right  name="절감율" SubBgColor=' + subSumBgColor + ' </C>';
		gd_tab4_MHeader += '</G>';
	
	initGridStyle(GD_TAB4_M, "common", gd_tab4_MHeader, false);
	DS_TAB4_M.SubSumExpr  = "total" ;
		
	var gd_tab4_SHeader = '<FC>id={currow}                  width=25 align=center name="NO" SubBgColor=' + subSumBgColor + ' </FC>';   
		gd_tab4_SHeader += '<FC>id=BIZ_CD       width=70 align=center   name="판관비;소분류항목" SubBgColor=' + subSumBgColor + ' </FC>';
		subSumText = '{decode(curlevel,9999,"합계",1,"소계")}';
		gd_tab4_SHeader += '<FC>id=BIZ_CD_NM  subsumtext=' + subSumText + '  width=80 align=left     name="판관비;소분류항목명"   SubBgColor=' + subSumBgColor + ' </FC>';
		gd_tab4_SHeader += '<G>name="판관비계획"';
		subSumText = "{ROUND(SUBSUM(PRE_RSLT_AMT)/" + amtUnit + ",0)}";
		gd_tab4_SHeader += '<C>id=PRE_RSLT_AMT   value={ROUND(PRE_RSLT_AMT/' + amtUnit + ',0)} subsumtext=' + subSumText + '  width=100 align=right  name="전년실적" SubBgColor=' + subSumBgColor + ' </C>';
		subSumText = "{ROUND(SUBSUM(PLAN_AMT)/" + amtUnit + ",0)}";
		gd_tab4_SHeader += '<C>id=PLAN_AMT   value={ROUND(PLAN_AMT/' + amtUnit + ',0)}  subsumtext=' + subSumText + '  width=100 align=right  name="계획" SubBgColor=' + subSumBgColor + ' </C>';
		//ROUND(DECODE(MMA.PRE_RSLT_AMT, 0, 0, (MMA.PLAN_AMT - MMA.PRE_RSLT_AMT)/MMA.PRE_RSLT_AMT*100),2)
		subSumText = '{ DECODE(SUBSUM(PRE_RSLT_AMT),0,0, ROUND((SUBSUM(PLAN_AMT)-SUBSUM(PRE_RSLT_AMT))/SUBSUM(PRE_RSLT_AMT)*100,2)  ) }';
		gd_tab4_SHeader += '<C>id=INC_DEC_RATIO  decao="2"  subsumtext=' + subSumText + '   width=100 align=right  name="절감율" SubBgColor=' + subSumBgColor + ' </C>';
		gd_tab4_SHeader += '</G>';

	initGridStyle(GD_TAB4_S, "common", gd_tab4_SHeader, false);
	DS_TAB4_S.SubSumExpr  = "total" ;

	var gd_tab4ExcelHeader = '<FC>id={currow}       width=25 align=center name="NO" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';   
		gd_tab4ExcelHeader += '<FC>id=ORG_CD        width=60 align=center   name="조직코드" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<FC>id=ORG_NAME      width=80 align=left     name="조직명"   BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<FC>id=BIZ_CD       	width=70 align=center   name="판관비;소분류항목" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<FC>id=BIZ_CD_NM    	width=80 align=left     name="판관비;소분류항목명"   BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<G>name="판관비계획"';
		gd_tab4ExcelHeader += '<C>id=PRE_RSLT_AMT  value={ROUND(PRE_RSLT_AMT/' + amtUnit + ',0)}  width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</C>';
		gd_tab4ExcelHeader += '<C>id=PLAN_AMT   value={ROUND(PLAN_AMT/' + amtUnit + ',0)}  	width=100 align=right  name="계획" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</C>';
		gd_tab4ExcelHeader += '<C>id=INC_DEC_RATIO	width=100 align=right  name="절감율" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</C>';
		gd_tab4ExcelHeader += '</G>';	
	
	//엑셀용
    initGridStyle(GD_TAB4_EXCEL, "common", gd_tab4ExcelHeader, false);
	
}

/**
 * gridCreate()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate_bak(){
	
	var gd_tab1Header  = '<FC>id={currow}                  width=25 align=center name="NO" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}  </FC>';
		gd_tab1Header += '<FC>id=ORG_CD                    width=80 align=center   name="조직코드" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")} </FC>';
		gd_tab1Header += '<FC>id=ORG_NAME                  width=120 align=left     name="조직명" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}   </FC>';
		gd_tab1Header += '<G>name="매출액(단위:백만)"';
		gd_tab1Header += '	<C>id=PRE_SALES_AMT              width=80 align=right  name="전년" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")} </C>';
		gd_tab1Header += '	<C>id=PLAN_SALES_AMT             width=80 align=right  name="계획" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")} </C>';
		gd_tab1Header += '	<C>id=SALES_GROWTH_RATE          width=60 align=right  name="신장율" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '</G>';
		gd_tab1Header += '<G>name="매출이익액(단위:백만)"';
		gd_tab1Header += '	<C>id=PRE_SALES_PROFIT_AMT       width=80 align=right  name="전년" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '	<C>id=PLAN_SALES_PROFIT_AMT      width=80 align=right  name="계획" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '	<C>id=SALES_PROFIT_GROWTH_RATE   width=60 align=right  name="신장율" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '</G>';  
		gd_tab1Header += '<G>name="매출이익율(%)"';
		gd_tab1Header += '	<C>id=PRE_SALES_PROFIT_RATE      width=80 align=right  name="전년" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '	<C>id=PLAN_SALES_PROFIT_RATE     width=80 align=right  name="계획" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '	<C>id=SALES_PROFIT_DIFFERENT     width=60 align=right  name="증감차" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
		gd_tab1Header += '</G>';              
				         
    initGridStyle(GD_TAB1, "common", gd_tab1Header, false);
    //엑셀용
    initGridStyle(GD_TAB1_EXCEL, "common", gd_tab1Header, false);
    
    
    var gd_tab2Header  = '<FC>id={currow}                  width=25 align=center name="NO" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</FC>';
    	gd_tab2Header += '<FC>id=ORG_CD                    width=60 align=center   name="조직코드" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</FC>';
    	gd_tab2Header += '<FC>id=ORG_NAME                  width=150 align=left     name="조직명"   BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</FC>';
    	gd_tab2Header += '<G>name="매출"';
    	gd_tab2Header += '	<C>id=PRE_SALES_RATIO      width=80 align=right  name="전년구성비" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
    	gd_tab2Header += '	<C>id=PLAN_SALES_RATIO     width=80 align=right  name="계획구성비" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
    	gd_tab2Header += '	<C>id=SALES_DIFFERENT     width=80 align=right  name="증감차" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
    	gd_tab2Header += '</G>';			             
    	gd_tab2Header += '<G>name="매출이익"';
    	gd_tab2Header += '	<C>id=PRE_SALES_PROFIT_RATIO      width=80 align=right  name="전년구성비" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
    	gd_tab2Header += '	<C>id=PLAN_SALES_PROFIT_RATIO     width=80 align=right  name="계획구성비" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
    	gd_tab2Header += '	<C>id=SALES_PROFIT_DIFFERENT     width=80 align=right  name="증감차" BgColor={decode(SUM_GUBUN,0,"#BDDBEF",1,"#FFD0D0")}</C>';
    	gd_tab2Header += '</G>';			             

	initGridStyle(GD_TAB2, "common", gd_tab2Header, false);
	//엑셀용
    initGridStyle(GD_TAB2_EXCEL, "common", gd_tab2Header, false);
	
    var gd_tab3Header  = '<FC>id={currow}                  width=25 align=center name="NO" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
    	gd_tab3Header += '<FC>id=BIZ_CD                    width=60 align=center   name="대분류;항목코드" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
    	gd_tab3Header += '<FC>id=BIZ_CD_NM                  width=80 align=left     name="대분류;항목명"   BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
    	gd_tab3Header += '<G>name="손익계획"';
    	gd_tab3Header += '<C>id=PRE_RSLT_AMT      width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
    	gd_tab3Header += '<C>id=PLAN_AMT     width=100 align=right  name="계획" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
    	gd_tab3Header += '<C>id=INC_DEC_RATIO     width=100 align=right  name="증감율" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
    	gd_tab3Header += '</G>';			             

	initGridStyle(GD_TAB3, "common", gd_tab3Header, false);

    var gd_tab3ExcelHeader  = '<FC>id={currow}                  width=25 align=center name="NO" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab3ExcelHeader += '<FC>id=ORG_CD                    width=60 align=center   name="조직코드" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab3ExcelHeader += '<FC>id=ORG_NAME                  width=80 align=left     name="조직명"   BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
    	gd_tab3ExcelHeader += '<FC>id=BIZ_CD                    width=60 align=center   name="대분류;항목코드" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
    	gd_tab3ExcelHeader += '<FC>id=BIZ_CD_NM                  width=80 align=left     name="대분류;항목명"   BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
    	gd_tab3ExcelHeader += '<G>name="손익계획"';
    	gd_tab3ExcelHeader += '<C>id=PRE_RSLT_AMT      width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
    	gd_tab3ExcelHeader += '<C>id=PLAN_AMT     width=100 align=right  name="계획" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
    	gd_tab3ExcelHeader += '<C>id=INC_DEC_RATIO     width=100 align=right  name="증감율" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
    	gd_tab3ExcelHeader += '</G>';			             
	
	//엑셀용
    initGridStyle(GD_TAB3_EXCEL, "common", gd_tab3ExcelHeader, false);
	
	var gd_tab4_MHeader  = '<FC>id={currow}		width=25 align=center 	name="NO" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab4_MHeader += '<FC>id=BIZ_CD       width=70 align=center   name="판관비;중분류항목" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab4_MHeader += '<FC>id=BIZ_CD_NM    width=80 align=left     name="판관비;중분류항목명"   BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab4_MHeader += '<G>name="판관비계획"';
		gd_tab4_MHeader += '<C>id=PRE_RSLT_AMT      width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
		gd_tab4_MHeader += '<C>id=PLAN_AMT     width=100 align=right  name="계획" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
		gd_tab4_MHeader += '<C>id=INC_DEC_RATIO     width=100 align=right  name="절감율" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
		gd_tab4_MHeader += '</G>';
	
	initGridStyle(GD_TAB4_M, "common", gd_tab4_MHeader, false);		
		
	var gd_tab4_SHeader = '<FC>id={currow}                  width=25 align=center name="NO" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';   
		gd_tab4_SHeader += '<FC>id=BIZ_CD       width=70 align=center   name="판관비;소분류항목" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab4_SHeader += '<FC>id=BIZ_CD_NM    width=80 align=left     name="판관비;소분류항목명"   BgColor={decode(GROUP_ID,1,"#BDDBEF")}</FC>';
		gd_tab4_SHeader += '<G>name="판관비계획"';
		gd_tab4_SHeader += '<C>id=PRE_RSLT_AMT      width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
		gd_tab4_SHeader += '<C>id=PLAN_AMT     width=100 align=right  name="계획" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
		gd_tab4_SHeader += '<C>id=INC_DEC_RATIO     width=100 align=right  name="절감율" BgColor={decode(GROUP_ID,1,"#BDDBEF")}</C>';
		gd_tab4_SHeader += '</G>';

	initGridStyle(GD_TAB4_S, "common", gd_tab4_SHeader, false);		

	var gd_tab4ExcelHeader = '<FC>id={currow}       width=25 align=center name="NO" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';   
		gd_tab4ExcelHeader += '<FC>id=ORG_CD        width=60 align=center   name="조직코드" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<FC>id=ORG_NAME      width=80 align=left     name="조직명"   BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<FC>id=BIZ_CD       	width=70 align=center   name="판관비;소분류항목" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<FC>id=BIZ_CD_NM    	width=80 align=left     name="판관비;소분류항목명"   BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</FC>';
		gd_tab4ExcelHeader += '<G>name="판관비계획"';
		gd_tab4ExcelHeader += '<C>id=PRE_RSLT_AMT   width=100 align=right  name="전년실적" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</C>';
		gd_tab4ExcelHeader += '<C>id=PLAN_AMT     	width=100 align=right  name="계획" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</C>';
		gd_tab4ExcelHeader += '<C>id=INC_DEC_RATIO	width=100 align=right  name="절감율" BgColor={decode(GROUP_ID,"11","#BDDBEF", "01", "#FFD0D0")}</C>';
		gd_tab4ExcelHeader += '</G>';	
	
	//엑셀용
    initGridStyle(GD_TAB4_EXCEL, "common", gd_tab4ExcelHeader, false);
	
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
	lo_tabChFlag = false;

	//dataset 초기화
	//DS_TAB1.ClearData();
	//DS_TAB2.ClearData();
	//DS_TAB3.ClearData();
	//DS_TAB4_M.ClearData();
	//DS_TAB4_S.ClearData();
    
    //1. validation
    if (isNull(EM_PLAN_YEAR.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영계획년도"); //(경영계획년도)은/는 반드시 입력해야 합니다.
        EM_PLAN_YEAR.focus();
        return;
    }

	var tabIdx = lo_tabIdx;
	var goTo = "";
	var action     = "O";
	var parameters = "&strStrCd=" + LC_STR_CD.BindColVal //점코드
    			   + "&strPlanY=" + EM_PLAN_YEAR.text    //경영계획년도
					;
	var dataSetObj = null;
	
	//매출계획분석
	if(tabIdx == 1) {
		goTo       = "searchTAB1" ;
		parameters += "&strOrgLevel=" +  document.getElementById("RD_ORG_LEVEL_TAB" + tabIdx).CodeValue;
		dataSetObj = document.getElementById("DS_TAB" + tabIdx);
	//매출구성계획분석
	} else if(tabIdx == 2) {
		goTo       = "searchTAB2" ;
		parameters += "&strOrgLevel=" +  document.getElementById("RD_ORG_LEVEL_TAB" + tabIdx).CodeValue;
		dataSetObj = document.getElementById("DS_TAB" + tabIdx);
	//손익계획분석	
	} else if(tabIdx == 3) {
		goTo       = "searchTAB3" ;
		parameters += "&strDeptCd=" + DS_TEAM_CD_TAB3.NameString(LC_TEAM_CD_TAB3.index + 1, "DEPT_CD");
		parameters += "&strTeamCd=" + LC_TEAM_CD_TAB3.BindColVal;
		parameters += "&strPcCd=" 	+ LC_PC_CD_TAB3.BindColVal;
		dataSetObj = document.getElementById("DS_TAB" + tabIdx);
		
		//UpdateChart();
		
	//판관비분석
	} else if(tabIdx == 4) {
		goTo       = "searchTAB4_M" ;
		parameters += "&strDeptCd=" + DS_TEAM_CD_TAB4.NameString(LC_TEAM_CD_TAB4.index + 1, "DEPT_CD");
		parameters += "&strTeamCd=" + LC_TEAM_CD_TAB4.BindColVal;
		parameters += "&strPcCd=" 	+ LC_PC_CD_TAB4.BindColVal;		
		dataSetObj = document.getElementById("DS_TAB" + tabIdx + "_M");
		
		//UpdateChart();
		
	} 
	
    lo_PlanY = EM_PLAN_YEAR.Text;
    //lo_StrCd = LC_STR_CD.BindColVal;
    lo_StrNm = LC_STR_CD.Text;
	
	dataSetObj.DataID   = "/mss/meis043.me?goTo="+goTo+parameters;
	dataSetObj.SyncLoad = "true";
	dataSetObj.Reset();

}

/**
 * sub_SearchTAB4_S()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 판관비 소분류 조회
 * return값 : void
 */
function sub_SearchTAB4_S(row) {

	DS_TAB4_S.ClearData();
	 
	var strPlanY 	= DS_TAB4_M.NameString(row,"BIZ_PLAN_YEAR");
	var strStrCd 	= DS_TAB4_M.NameString(row,"STR_CD");
	var strDeptCd	= DS_TAB4_M.NameString(row,"DEPT_CD");
	var strTeamCd 	= DS_TAB4_M.NameString(row,"TEAM_CD");
	var strPcCd 	= DS_TAB4_M.NameString(row,"PC_CD");
	var strBizCd 	= DS_TAB4_M.NameString(row,"BIZ_CD");
	 
	var goTo = "searchTAB4_S";
	var action     = "O";
	var parameters  = "&strPlanY=" + strPlanY; //년
		parameters += "&strStrCd=" + strStrCd; 
		parameters += "&strDeptCd=" + strDeptCd;
		parameters += "&strTeamCd=" + strTeamCd; 
		parameters += "&strPcCd=" + strPcCd; 
		parameters += "&strBizCd=" + strBizCd; 

	DS_TAB4_S.DataID   = "/mss/meis043.me?goTo="+goTo+parameters;
	DS_TAB4_S.SyncLoad = "true";
	DS_TAB4_S.Reset();
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
	
	var tabIdx = lo_tabIdx;
	var val_dataSetObj = null;
	
	if(tabIdx == 4) {
		val_dataSetObj = document.getElementById("DS_TAB" + tabIdx + "_M");
	} else {
		val_dataSetObj = document.getElementById("DS_TAB" + tabIdx);
	}
	 
	if(!lo_searchFlag || val_dataSetObj.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
	    return false;
	}	 

	var goTo = "";
	var action     = "O";
	var parameters = "&strStrCd=" + LC_STR_CD.BindColVal //점코드
    			   + "&strPlanY=" + EM_PLAN_YEAR.text    //경영계획년도
					;
	
	//매출계획분석
	if(tabIdx == 1) {
		goTo       = "searchTAB1_EXCEL" ;
		parameters += "&strOrgLevel=" +  document.getElementById("RD_ORG_LEVEL_TAB" + tabIdx).CodeValue;
		dataSetObj = document.getElementById("DS_TAB" + tabIdx + "_EXCEL");
	//매출구성계획분석
	} else if(tabIdx == 2) {
		goTo       = "searchTAB2_EXCEL" ;
		parameters += "&strOrgLevel=" +  document.getElementById("RD_ORG_LEVEL_TAB" + tabIdx).CodeValue;
		dataSetObj = document.getElementById("DS_TAB" + tabIdx + "_EXCEL");
	//손익계획분석	
	} else if(tabIdx == 3) {
		goTo       = "searchTAB3_EXCEL" ;
		parameters += "&strDeptCd=" + DS_TEAM_CD_TAB3.NameString(LC_TEAM_CD_TAB3.index + 1, "DEPT_CD");
		parameters += "&strTeamCd=" + LC_TEAM_CD_TAB3.BindColVal;
		parameters += "&strPcCd=" 	+ LC_PC_CD_TAB3.BindColVal;
		dataSetObj = document.getElementById("DS_TAB" + tabIdx + "_EXCEL");
		
	//판관비분석
	} else if(tabIdx == 4) {
		goTo       = "searchTAB4_EXCEL" ;
		parameters += "&strDeptCd=" + DS_TEAM_CD_TAB4.NameString(LC_TEAM_CD_TAB4.index + 1, "DEPT_CD");
		parameters += "&strTeamCd=" + LC_TEAM_CD_TAB4.BindColVal;
		parameters += "&strPcCd=" 	+ LC_PC_CD_TAB4.BindColVal;		
		dataSetObj = document.getElementById("DS_TAB" + tabIdx + "_EXCEL");
		
	} 
	
    lo_PlanY = EM_PLAN_YEAR.Text;
    //lo_StrCd = LC_STR_CD.BindColVal;
    lo_StrNm = LC_STR_CD.Text;
	
	dataSetObj.DataID   = "/mss/meis043.me?goTo="+goTo+parameters;
	dataSetObj.SyncLoad = "true";
	dataSetObj.Reset();

	
}

/**
 * btn_Excel()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 엑셀저장
 * return값 : void
 */
function btn_ExcelDownload() {
	 
	 var tabIdx = lo_tabIdx;
		
	//TAB1용 엑셀
	if(tabIdx == 1) {
			
		var parameters  = "점코드="           	+ lo_StrNm;
			parameters += " , 경영계획년도= "  	+lo_PlanY;
		var ExcelTitle = "매출계획분석";

		openExcel2(GD_TAB1_EXCEL, ExcelTitle, parameters, true );
		
	//TAB2용 엑셀	
	} else if(tabIdx == 2) {

		var parameters  = "점코드="           	+ lo_StrNm;
			parameters += " , 경영계획년도= "  	+lo_PlanY;
		var ExcelTitle = "매출구성비계획분석";

	openExcel2(GD_TAB2_EXCEL, ExcelTitle, parameters, true );
		
	//TAB3용 엑셀	
	} else if(tabIdx == 3) {
			
		var parameters  = "점코드="           	+ lo_StrNm;
			parameters += " , 경영계획년도= "  	+lo_PlanY;
		var ExcelTitle = "손익계획분석";

		openExcel2(GD_TAB3_EXCEL, ExcelTitle, parameters, true );

	//TAB4용 엑셀
	} else if(tabIdx == 4) {
			
		var parameters  = "점코드="           	+ lo_StrNm;
			parameters += " , 경영계획년도= "  	+lo_PlanY;
		var ExcelTitle = "판관비분석";

		openExcel2(GD_TAB4_EXCEL, ExcelTitle, parameters, true );
	
	}
	
}
	
/**
 * btn_Print()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-10
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
    //1. validation
    if (isNull(EM_PLAN_YEAR.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영계획년도"); //(경영계획년도)은/는 반드시 입력해야 합니다.
        EM_PLAN_YEAR.focus();
        return;
    }
    
    var params = "&strStrCd="      + LC_STR_CD.BindColVal //점코드
               + "&strPlanY="      + EM_PLAN_YEAR.text    //경영계획년도
               + "&strOrgLevel=1"
               + "&BIZ_PLAN_YEAR=" + EM_PLAN_YEAR.text
               + "&HD_ORG_CD="     + LC_STR_CD.BindColVal + "00000000" 
               + "&ORG_NAME="      + encodeURIComponent(LC_STR_CD.text)
               + "&ORG_LEVEL=1"
               + "&strDeptCd=%"
               + "&strTeamCd=%"
               + "&strPcCd=%"
               ;

    window.open("/mss/meis043.me?goTo=print"+params,"OZREPORT", 1000, 700);
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
	//lo_searchFlag = false;
	lo_tabChFlag = true;

	if(lo_tabIdx == 1 || lo_tabIdx == 2) {
		if(LC_STR_CD.BindColVal == "%") {
			var rdObj = document.getElementById("RD_ORG_LEVEL_TAB" + lo_tabIdx);
			rdObj.CodeValue = 1;
		}
	} else if(lo_tabIdx == 3 || lo_tabIdx == 4) {
		fn_initTeamLc();
	}
	
	//lo_searchFlag = true;
	//if(lo_searchFlag) setTimeout("btn_Search()", 100);
	if(lo_searchFlag) {
		setTimeout("btn_Search()", 100);
	}else {
		//dataset 초기화
		DS_TAB1.ClearData();
		DS_TAB2.ClearData();
		DS_TAB3.ClearData();
		DS_TAB4_M.ClearData();
		DS_TAB4_S.ClearData();

		UpdateChart();		
	}
	
}

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

/**
 * fn_initTeamLc()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 파트 콤보를 초기화 한다.
 * return값 : void
 */ 
function fn_initTeamLc() {
	 
    var lc_teamObj = document.getElementById("LC_TEAM_CD_TAB" + lo_tabIdx);
    var ds_teamObj = document.getElementById("DS_TEAM_CD_TAB" + lo_tabIdx);

    var lc_pcObj = document.getElementById("LC_PC_CD_TAB" + lo_tabIdx);
    var ds_pcObj = document.getElementById("DS_PC_CD_TAB" + lo_tabIdx);
    
    initComboStyle(lc_teamObj,ds_teamObj, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]파트    
    initComboStyle(lc_pcObj,ds_pcObj, "CODE^0^30,NAME^0^80", 1, NORMAL);     // [조회용]PC   
    //파트콤보 조회
    fn_getOrg(ds_teamObj, "Y", LC_STR_CD.BindColVal, "%", "%", "%", "3");
    //PC콤보 조회
    fn_getOrg(ds_pcObj, "Y", LC_STR_CD.BindColVal
    					   , ds_teamObj.NameString(lc_teamObj.index+1, "DEPT_CD")
    					   , ds_teamObj.NameString(lc_teamObj.index+1, "TEAM_CD")
    					   , "%", "4");
    
    lc_teamObj.Index = 0;
    lc_pcObj.Index = 0;
    
    //enableControl(lc_pcObj, false);	
}

/**
 * fn_initPcLc()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : PC 콤보를 초기화 한다.
 * return값 : void
 */ 
function fn_initPcLc() {
	 
	var lc_teamObj = document.getElementById("LC_TEAM_CD_TAB" + lo_tabIdx);
	var ds_teamObj = document.getElementById("DS_TEAM_CD_TAB" + lo_tabIdx);	 
	 
    var lc_pcObj = document.getElementById("LC_PC_CD_TAB" + lo_tabIdx);
    var ds_pcObj = document.getElementById("DS_PC_CD_TAB" + lo_tabIdx);
    
    initComboStyle(lc_pcObj,ds_pcObj, "CODE^0^30,NAME^0^80", 1, NORMAL);     // [조회용]PC   
/*    
    getPc("DS_PC_CD_TAB" + lo_tabIdx, "Y", LC_STR_CD.BindColVal, "%", lc_pcObj.BindColVal, "Y");
    getPc("DS_PC_CD_TAB" + lo_tabIdx, "Y"
    		, LC_STR_CD.BindColVal
    		, ds_teamObj.NameString(lc_teamObj.index+1, "DEPT_CD")
    		, ds_teamObj.NameString(lc_teamObj.index+1, "TEAM_CD")
    		, "Y");
*/    
//PC콤보 조회
    fn_getOrg(ds_pcObj, "Y", LC_STR_CD.BindColVal
    					   , ds_teamObj.NameString(lc_teamObj.index+1, "DEPT_CD")
    					   , ds_teamObj.NameString(lc_teamObj.index+1, "TEAM_CD")
    					   , "%", "4");
    
    lc_pcObj.Index = 0;
    
    
    if(lc_teamObj.BindColVal == "%") enableControl(lc_pcObj, false);	
    else enableControl(lc_pcObj, true);	
}


/**
 * fn_changeRadio()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-06-17
 * 개    요 : 라디오버튼변경시 호출
 * return값 : void
 */ 
function fn_changeRadio() {

    var tabIdx = lo_tabIdx;
	var tabObj = document.getElementById("RD_ORG_LEVEL_TAB" + tabIdx);
    
	var code = tabObj.CodeValue;
	//코드값이 점이 아니면 콤보의 점은 필수
	if(code != 1) {
	    var strCd = LC_STR_CD.BindColVal;

	    if(strCd == "%") {
	        showMessage(INFORMATION, OK, "USER-1000", "점코드 선택 후 변경하세요.");
	        tabObj.CodeValue = 1;
	        return;
	    } 
	}

	//조회 후 조직을 변경 했으면 자동으로 재조회한다.
	if(lo_searchFlag) {
		btn_Search();
	}
	 
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
function UpdateChart() {	

	var tabIdx = lo_tabIdx;
	
	//TAB1용 차트
	if(tabIdx == 1) {
	
		var rowIdx = DS_TAB1.RowPosition;

		var ORG_NAME = GD_TAB1.VirtualString2(rowIdx, "ORG_NAME",1);
		var PRE_SALES_AMT = GD_TAB1.VirtualString2(rowIdx, "PRE_SALES_AMT",1);				//전년실적매출액
		var PLAN_SALES_AMT = GD_TAB1.VirtualString2(rowIdx, "PLAN_SALES_AMT",1);					//계획매출액
		var PRE_SALES_PROFIT_AMT = GD_TAB1.VirtualString2(rowIdx, "PRE_SALES_PROFIT_AMT",1);		//전년실적매출이익액
		var PLAN_SALES_PROFIT_AMT = GD_TAB1.VirtualString2(rowIdx, "PLAN_SALES_PROFIT_AMT",1);	//계획매출이익액	
		var PRE_SALES_PROFIT_RATE = GD_TAB1.VirtualString2(rowIdx, "PRE_SALES_PROFIT_RATE",1);	//전년실적매출이익율
		var PLAN_SALES_PROFIT_RATE = GD_TAB1.VirtualString2(rowIdx, "PLAN_SALES_PROFIT_RATE",1);	//계획매출이익율

		var goTo = "chartTAB1";
		var parameters = "&ORG_NAME=" 				+ encodeURIComponent(ORG_NAME)          
					   + "&PRE_SALES_AMT="  		+ PRE_SALES_AMT 	
        			   + "&PLAN_SALES_AMT=" 		+ PLAN_SALES_AMT
					   + "&PRE_SALES_PROFIT_AMT="  	+ PRE_SALES_PROFIT_AMT 	
        			   + "&PLAN_SALES_PROFIT_AMT=" 	+ PLAN_SALES_PROFIT_AMT 	
					   + "&PRE_SALES_PROFIT_RATE="  + PRE_SALES_PROFIT_RATE 	
        			   + "&PLAN_SALES_PROFIT_RATE=" + PLAN_SALES_PROFIT_RATE 	
        				;

		//매출액차트호출
		var CHART_GUBUN = "SALES_AMT";
		IFRAME_TAB1_CHART_SALES_AMT.location.href = "/mss/meis043.me?goTo="+goTo+parameters+"&CHART_GUBUN=" + CHART_GUBUN;

		//매출이익액 차트 호출
		CHART_GUBUN = "SALES_RROFIT_AMT";
		IFRAME_TAB1_CHART_SALES_PROFIT_AMT.location.href = "/mss/meis043.me?goTo="+goTo+parameters+"&CHART_GUBUN=" + CHART_GUBUN;
		
		//매출이익율 차트 호출
		CHART_GUBUN = "SALES_RROFIT_RATE";
		IFRAME_TAB1_CHART_SALES_PROFIT_RATE.location.href = "/mss/meis043.me?goTo="+goTo+parameters+"&CHART_GUBUN=" + CHART_GUBUN;

	//TAB2용 차트	 
	} else if(tabIdx == 2) {

		var rowIdx = DS_TAB2.RowPosition;

		var ORG_CD = GD_TAB2.VirtualString2(rowIdx, "ORG_CD",1);
		var ORG_NAME = GD_TAB2.VirtualString2(rowIdx, "ORG_NAME",1);
		var SUM_GUBUN = GD_TAB2.VirtualString2(rowIdx, "SUM_GUBUN",1);
		var GROUP_GUBUN = GD_TAB2.VirtualString2(rowIdx, "GROUP_GUBUN",1);
		var HD_ORG_CD = GD_TAB2.VirtualString2(rowIdx, "HD_ORG_CD",1);
		var STR_CD = GD_TAB2.VirtualString2(rowIdx, "STR_CD",1);
		var BIZ_PLAN_YEAR = GD_TAB2.VirtualString2(rowIdx, "BIZ_PLAN_YEAR",1);
		var ORG_LEVEL = GD_TAB2.VirtualString2(rowIdx, "ORG_LEVEL",1);
		
		var goTo = "chartTAB2";
		var parameters = "&ORG_CD=" 				+ ORG_CD
					   + "&ORG_NAME=" 				+ encodeURIComponent(ORG_NAME)
					   + "&SUM_GUBUN=" 				+ SUM_GUBUN
					   + "&GROUP_GUBUN=" 			+ GROUP_GUBUN
					   + "&HD_ORG_CD=" 				+ HD_ORG_CD
					   + "&STR_CD=" 				+ STR_CD
					   + "&BIZ_PLAN_YEAR=" 			+ BIZ_PLAN_YEAR
					   + "&ORG_LEVEL=" 				+ ORG_LEVEL
						;		

		//매출구성비차트호출
		var CHART_GUBUN = "SALES_RATIO";

		IFRAME_TAB2_CHART_SALES_RATIO.location.href = "/mss/meis043.me?goTo="+goTo+parameters+"&CHART_GUBUN=" + CHART_GUBUN;

		//매출이익구성비차트호출
		CHART_GUBUN = "SALES_PROFIT_RATIO";
		IFRAME_TAB2_CHART_SALES_PROFIT_RATIO.location.href = "/mss/meis043.me?goTo="+goTo+parameters+"&CHART_GUBUN=" + CHART_GUBUN;
	
	//TAB3용 차트	
	} else if(tabIdx == 3) {
		
		var goTo = "chartTAB3";
		var parameters  = "&strStrCd=" + LC_STR_CD.BindColVal; //점코드
			parameters += "&strPlanY=" + EM_PLAN_YEAR.text;    //경영계획년도
			parameters += "&strDeptCd=" + DS_TEAM_CD_TAB3.NameString(LC_TEAM_CD_TAB3.index + 1, "DEPT_CD");
			parameters += "&strTeamCd=" + LC_TEAM_CD_TAB3.BindColVal;
			parameters += "&strPcCd=" 	+ LC_PC_CD_TAB3.BindColVal;
			parameters += "&dsCnt=" 	+ DS_TAB3.CountRow;
		
		IFRAME_TAB3_INC_DEC_RATIO.location.href = "/mss/meis043.me?goTo="+goTo+parameters;
	
	//TAB4용 차트	
	} else if(tabIdx == 4) {
		
		var goTo = "chartTAB4";
		var parameters  = "&strStrCd=" + LC_STR_CD.BindColVal; //점코드
			parameters += "&strPlanY=" + EM_PLAN_YEAR.text;    //경영계획년도
			parameters += "&strDeptCd=" + DS_TEAM_CD_TAB4.NameString(LC_TEAM_CD_TAB4.index + 1, "DEPT_CD");
			parameters += "&strTeamCd=" + LC_TEAM_CD_TAB4.BindColVal;
			parameters += "&strPcCd=" 	+ LC_PC_CD_TAB4.BindColVal;
			parameters += "&dsCnt=" 	+ DS_TAB4_M.CountRow;
		
			IFRAME_TAB4_SALE_MANAGE_AMT.location.href = "/mss/meis043.me?goTo="+goTo+parameters;	
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
<script language=JavaScript for=DS_TAB1 event=OnLoadStarted()>

//점:1, 파트:3, PC:4
var rdObj = document.getElementById("RD_ORG_LEVEL_TAB" + lo_tabIdx);
var value = rdObj.CodeValue;
if(value == "4") {
    DS_TAB1.SubSumExpr  = "total,1:STR_CD:DEPT_CD:TEAM_CD" ;
} else {
	DS_TAB1.SubSumExpr  = "total";
}

</script>

<script language=JavaScript for=DS_TAB1 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

	lo_searchFlag = true;
    setPorcCount("SELECT", rowcnt);
    GD_TAB1.Focus();
</script>


<script language=JavaScript for=DS_TAB2 event=OnLoadStarted()>

//점:1, 파트:3, PC:4
var rdObj = document.getElementById("RD_ORG_LEVEL_TAB" + lo_tabIdx);
var value = rdObj.CodeValue;
if(value == "4") {
	DS_TAB2.SubSumExpr  = "total,1:STR_CD:DEPT_CD:TEAM_CD" ;
} else {
	DS_TAB2.SubSumExpr  = "total";
}

</script>

<script language=JavaScript for=DS_TAB2 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
	
	lo_searchFlag = true;
    setPorcCount("SELECT", rowcnt);
    GD_TAB2.Focus();
</script>

<script language=JavaScript for=DS_TAB3 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

	lo_searchFlag = true;
    setPorcCount("SELECT", rowcnt);
    GD_TAB3.Focus();
    UpdateChart();
</script>

<script language=JavaScript for=DS_TAB4_M event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

	lo_searchFlag = true;
    setPorcCount("SELECT", rowcnt);
    GD_TAB4_M.Focus();
    UpdateChart();
</script>

<script language=JavaScript for=DS_TAB4_S event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    setPorcCount("SELECT", rowcnt);
    GD_TAB4_S.Focus();
</script>

<script language=JavaScript for=DS_TAB1_EXCEL event=OnLoadStarted()>
//점:1, 파트:3, PC:4
DS_TAB1_EXCEL.SubSumExpr  = "total,1:STR_CD:DEPT_CD:TEAM_CD" ;
</script>

<script language=JavaScript for=DS_TAB1_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    btn_ExcelDownload();
    
</script>

<script language=JavaScript for=DS_TAB2_EXCEL event=OnLoadStarted()>
//점:1, 파트:3, PC:4
DS_TAB2_EXCEL.SubSumExpr  = "total,1:STR_CD:DEPT_CD:TEAM_CD" ;
</script>

<script language=JavaScript for=DS_TAB2_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    btn_ExcelDownload();
    
</script>

<script language=JavaScript for=DS_TAB3_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    btn_ExcelDownload();
    
</script>

<script language=JavaScript for=DS_TAB4_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);

    btn_ExcelDownload();
    
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_TAB1  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB2  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB3  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB4_M  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB4_S  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB1_EXCEL  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB2_EXCEL  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB3_EXCEL  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_TAB4_EXCEL  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_TAB1 event=OnRowPosChanged(row)>
UpdateChart();
</script>

<script language=JavaScript for=DS_TAB2 event=OnRowPosChanged(row)>
UpdateChart();
</script>

<script language=JavaScript for=DS_TAB3 event=OnRowPosChanged(row)>
//UpdateChart();
</script>

<script language=JavaScript for=DS_TAB4_M event=OnRowPosChanged(row)>
//UpdateChart();
//판관비 소분류 조회
sub_SearchTAB4_S(row);
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->

<!-- 조회조건의 점코드 변경 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
lo_searchFlag = false;
//점코드가 전체면 라디오 버튼을 점으로 변경한다
if(LC_STR_CD.BindColVal == "%") {
	
	var rdObj = document.getElementById("RD_ORG_LEVEL_TAB" + lo_tabIdx);
	rdObj.CodeValue = 1;
}

if(lo_tabIdx == 3 || lo_tabIdx == 4) fn_initTeamLc();

//dataset 초기화
DS_TAB1.ClearData();
DS_TAB2.ClearData();
DS_TAB3.ClearData();
DS_TAB4_M.ClearData();
DS_TAB4_S.ClearData();

UpdateChart();

</script>

<!-- TAB3의 파트코드 변경 -->
<script language=JavaScript for=LC_TEAM_CD_TAB3 event=OnSelChange()>
fn_initPcLc();

//조회 후 조직을 변경 했으면 자동으로 재조회한다.
if(lo_searchFlag && !lo_tabChFlag) {
	btn_Search();
	lo_teamSearchFlag = true;
}

</script>

<!-- TAB3의 PC코드 변경 -->
<script language=JavaScript for=LC_PC_CD_TAB3 event=OnSelChange()>

//조회 후 조직을 변경 했으면 자동으로 재조회한다.
if(lo_searchFlag && !lo_tabChFlag) {
	if(!lo_teamSearchFlag) btn_Search();
	lo_teamSearchFlag = false;
}

</script>

<!-- TAB4의 파트코드 변경 -->
<script language=JavaScript for=LC_TEAM_CD_TAB4 event=OnSelChange()>
fn_initPcLc();

//조회 후 조직을 변경 했으면 자동으로 재조회한다.
if(lo_searchFlag && !lo_tabChFlag) {
	btn_Search();
	lo_teamSearchFlag = true;
}

</script>

<!-- TAB4의 PC코드 변경 -->
<script language=JavaScript for=LC_PC_CD_TAB4 event=OnSelChange()>

//조회 후 조직을 변경 했으면 자동으로 재조회한다.
if(lo_searchFlag && !lo_tabChFlag) {
	if(!lo_teamSearchFlag) btn_Search();
	lo_teamSearchFlag = false;
}

</script>

<!-- 탭1라디오버튼 변경 -->
<script language=JavaScript for=RD_ORG_LEVEL_TAB1 event=OnSelChange()>
fn_changeRadio();
</script>

<!-- 탭2라디오버튼 변경 -->
<script language=JavaScript for=RD_ORG_LEVEL_TAB2 event=OnSelChange()>
fn_changeRadio();
</script>

<script language=JavaScript for=GD_TAB1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_TAB2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_TAB3 event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_TAB4_M event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_TAB4_S event=OnClick(row,colid)>
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
    <!--[콤보]TAB3 파트코드 -->
    <object id="DS_TEAM_CD_TAB3"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]TAB3 PC코드 -->
    <object id="DS_PC_CD_TAB3"   classid=<%= Util.CLSID_DATASET %>></object>        
    <!--[콤보]TAB4 파트코드 -->
    <object id="DS_TEAM_CD_TAB4"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]TAB4 PC코드 -->
    <object id="DS_PC_CD_TAB4"   classid=<%= Util.CLSID_DATASET %>></object>        

    <!--[그리드]매출계획분석 -->
    <object id="DS_TAB1"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]매출계획분석 엑셀 -->
    <object id="DS_TAB1_EXCEL"      classid=<%= Util.CLSID_DATASET %>></object>
    
    <!--[그리드]매출구성계획분석 -->
    <object id="DS_TAB2"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]매출구성계획분석 엑셀 -->
    <object id="DS_TAB2_EXCEL"      classid=<%= Util.CLSID_DATASET %>></object>

    <!--[그리드]손익계획분석 -->
    <object id="DS_TAB3"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]손익계획분석 엑셀 -->
    <object id="DS_TAB3_EXCEL"      classid=<%= Util.CLSID_DATASET %>></object>
    
    <!--[그리드]판관비분석(중분류) -->
    <object id="DS_TAB4_M"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]판관비분석(소분류) -->
    <object id="DS_TAB4_S"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]판관비분석엑셀 -->
    <object id="DS_TAB4_EXCEL"      classid=<%= Util.CLSID_DATASET %>></object>


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
                                <td>
                                    <comment id="_NSID_">
                                    <object id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle"></object>
                                    </comment><script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- tr><td class="dot"></td></tr -->
    <tr>
        <td class="PT01 PB03">
			<div id=TB_NORMAL width="100%" height=485 TitleWidth=120
				 TitleAlign="center" TitleStyle="" TitleGap=3>
				<menu TitleName="매출계획분석"      	DivId="tr_tab1"	ClickFunc="fn_changeTab"	 />
				<menu TitleName="매출구성계획분석"	DivId="tr_tab2" ClickFunc="fn_changeTab"	 />
				<menu TitleName="손익계획분석" 		DivId="tr_tab3" ClickFunc="fn_changeTab"	 />
				<menu TitleName="판관비분석" 		DivId="tr_tab4" ClickFunc="fn_changeTab" 	 />
			</div>             
        <!-- tab end --> 
        </td>
    </tr>
    <!-- 매출계획분석  Start-->    
    <tr>
        <td>
    <div id="tr_tab1" class="PT05">    
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
			            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table PT05">
			                <tr>
			                    <th width="80" class="point">조직구분</th>
			                    <td>
			                        <comment id="_NSID_">
			                        <object id=RD_ORG_LEVEL_TAB1 classid=<%=Util.CLSID_RADIO%> tabindex=1 
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
                <tr>
                    <td class="PT05">
			            <table width="100%" border="0" cellpadding="0" cellspacing="0">
			                <tr>
			                    <td class="BD4A">
			                        <comment id="_NSID_">
			                        <object id=GD_TAB1 width="100%" height=185 classid=<%=Util.CLSID_GRID%>>
			                            <param name="DataID" value="DS_TAB1">
			                        </object></comment><script>_ws_(_NSID_);</script>                      
			                    </td>
			                </tr>
			            </table>                    
                    </td>
                </tr>
                <tr>
                    <td class="PT05">
			            <table width="100%" height="230" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                <tr>
			                    <td class="BD4A" width="270">
			                    	<!-- 매출액 차트 -->
									<iframe id="IFRAME_TAB1_CHART_SALES_AMT" width="270" height="225" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                    <td class="BD4A" width="270">
			                    	<!-- 매출이익액 차트 -->
									<iframe id="IFRAME_TAB1_CHART_SALES_PROFIT_AMT" width="270" height="225" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                    <td class="BD4A" width="*">
			                    	<!-- 매출이익율 차트 -->
									<iframe id="IFRAME_TAB1_CHART_SALES_PROFIT_RATE" width="270" height="225" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                </tr>
			            </table>                     
                    </td>
                </tr>
            </table>
    </div>                    
        </td>
    </tr>
    <!-- 매출계획분석  End-->
    
    <!-- 매출구성계획분석  Start-->    
    <tr >
        <td>
    <div id="tr_tab2" class="PT05">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table PT05">
                            <tr>
                                <th width="80" class="point">조직구분</th>
                                <td>
                                    <comment id="_NSID_">
                                    <object id=RD_ORG_LEVEL_TAB2 classid=<%=Util.CLSID_RADIO%> tabindex=1 
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
                <tr>
                    <td class="PT05">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="BD4A">
                                    <comment id="_NSID_">
                                    <object id=GD_TAB2 width="100%" height=190 classid=<%=Util.CLSID_GRID%>>
                                        <param name="DataID" value="DS_TAB2">
                                    </object></comment><script>_ws_(_NSID_);</script>                      
                                </td>
                            </tr>
                        </table>                    
                    </td>
                </tr>
                <tr>
                    <td class="PT05">
			            <table width="100%" height="225" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                <tr>
			                    <td class="BD4A" width="50%">
			                    	<!-- 매출액 차트 -->
									<iframe id="IFRAME_TAB2_CHART_SALES_RATIO" width="400" height="220" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                    <td class="BD4A" width="50%">
			                    	<!-- 매출이익액 차트 -->
									<iframe id="IFRAME_TAB2_CHART_SALES_PROFIT_RATIO" width="400" height="220" style="overflow:hidden;" 
											src=""></iframe>
			                    </td>
			                </tr>
			            </table>                
                    </td>
                </tr>
            </table>
    </div>        
        </td>
    </tr>
    <!-- 매출구성계획분석  End-->

    <!-- 손익계획분석  Start-->    
    <tr >
        <td>
    <div id="tr_tab3" class="PT05">    
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="400" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            <tr>
                                <th width="80" class="point">파트</th>
                                <td width="100">
	                                <comment id="_NSID_"> 
	                                <object id=LC_TEAM_CD_TAB3 classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=100 tabindex=1 align="absmiddle"> 
									</object> 
									</comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80" class="point">PC</th>
                                <td width="100">
	                                <comment id="_NSID_"> 
	                                <object id=LC_PC_CD_TAB3 classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=100 tabindex=1 align="absmiddle"> 
									</object> 
									</comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
							<tr><td></td></tr>                        
                        </table>                    
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"">
                            <tr>
								<td width="*">
                                	<table width="100%" height="410" border="0" cellpadding="0" cellspacing="0" class="s_table">
                                    	<tr>
                                    		<td  class="BD4A">
			                                    <comment id="_NSID_">
			                                    <object id=GD_TAB3 width="100%" height=410 classid=<%=Util.CLSID_GRID%>>
			                                        <param name="DataID" value="DS_TAB3">
			                                    </object></comment><script>_ws_(_NSID_);</script> 
                                    		</td>
                                    	</tr>
                                    </table>  								
								</td>
								<td width="10">
								</td>
								<td>
						            <table width="100%" height="410" border="0" cellpadding="0" cellspacing="0" class="s_table">
						                <tr>
						                    <td width="100%">
						                    	<!-- 손익계획 차트 -->
												<iframe id="IFRAME_TAB3_INC_DEC_RATIO" width="100%" height="400" style="overflow:hidden;" 
														src=""></iframe>
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
        </td>
    </tr>
    <!-- 손익계획분석  End-->
    
    <!-- 판관비분석  Start-->    
    <tr >
        <td>
    <div id="tr_tab4" class="PT05">    
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="400" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            <tr>
                                <th width="80" class="point">파트</th>
                                <td width="100">
	                                <comment id="_NSID_"> 
	                                <object id=LC_TEAM_CD_TAB4 classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=100 tabindex=1 align="absmiddle"> 
									</object> 
									</comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80" class="point">PC</th>
                                <td width="100">
	                                <comment id="_NSID_"> 
	                                <object id=LC_PC_CD_TAB4 classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=100 tabindex=1 align="absmiddle"> 
									</object> 
									</comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
							<tr><td></td></tr>                        
                        </table>                    
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"">
                            <tr>
								<td width="*">
									<table width="100%" height="10" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
			                                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                                    	<tr>
			                                    		<td  class="BD4A">
						                                    <comment id="_NSID_">
						                                    <object id=GD_TAB4_M width="100%" height=205 classid=<%=Util.CLSID_GRID%>>
						                                        <param name="DataID" value="DS_TAB4_M">
						                                    </object></comment><script>_ws_(_NSID_);</script> 
			                                    		</td>
			                                    	</tr>
			                                    </table>  																			
											</td>
										</tr>
										<tr><td height="1"></td></tr>                        
										<tr>
											<td>
			                                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
			                                    	<tr>
			                                    		<td  class="BD4A">
						                                    <comment id="_NSID_">
						                                    <object id=GD_TAB4_S width="100%" height=205 classid=<%=Util.CLSID_GRID%>>
						                                        <param name="DataID" value="DS_TAB4_S">
						                                    </object></comment><script>_ws_(_NSID_);</script> 
			                                    		</td>
			                                    	</tr>
			                                    </table>  																			
											</td>
										</tr>
                        			</table>								
								</td>
								<td width="10"></td>
								<td width="400">
						            <table width="100%" height="415" border="0" cellpadding="0" cellspacing="0" class="s_table">
						                <tr>
						                    <td width="100%">
						                    	<!-- 손익계획 차트 -->
												<iframe id="IFRAME_TAB4_SALE_MANAGE_AMT" width="100%" height="400" style="overflow:hidden;" 
														src=""></iframe>
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
        </td>
    </tr>
    <!-- 판관비분석  End-->    
    
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
  <object id=GD_TAB1_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_TAB1_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=GD_TAB2_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_TAB2_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=GD_TAB3_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_TAB3_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=GD_TAB4_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_TAB4_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
