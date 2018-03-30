<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 년월매출순위(협력사별/브랜드별)
 * 작 성 일 : 2012.06.04
 * 작 성 자 : DHL
 * 수 정 자 : 
 * 파 일 명 : psal4570.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 년월매출순위(협력사별/브랜드별)
 * 이    력 : 2012.06.04 DHL
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
   SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
   	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 

/**
 
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 160;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER1"/>');
   
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    // EMedit에 초기화( gauce.js )    i
    initEmEdit(EM_SALE_DT_S, "SYYYYMM",  PK); 	//조회 매출 월 FROM
    initEmEdit(EM_SALE_DT_E, "EYYYYMM",  PK);	//조회 매출 월 TO

    initEmEdit(EM_SEARCH_CNT, "NUMBER^9^0",  NORMAL);         //조회건수   
    EM_SEARCH_CNT.alignment = 2;
    EM_SEARCH_CNT.Text = 50;
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);               //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);          //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);          //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);              //PC(조회)
    
      
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                                 // 점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                            // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);                     // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag); // PC  
 	
    LC_STR_CD.Index  = 0;   
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    orgFlagCheck(orgFlag);

    var strStrCd        = LC_STR_CD.BindColVal;      //점
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
	var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
	
    //alert("strStrCd : " +strStrCd);
    //alert("strSaleDtS : " +strSaleDtS);
    //alert("strSaleDtE : " +strSaleDtE);
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal457", "DS_O_MASTER" );
}

// 협력사 대표브랜드별 조회 화면 //
function gridCreate1(){

    var hdrProperies = '<COLUMNINFO>'
    
			         + '       <COLUMN id="STRCD" refcolid="STR_CD" view="false">'
			         + '           <HEADER left="0" top="0" right="0" bottom="40" text="점" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			         + '           <VIEW left="0" top="0" right="0" bottom="20" edit="" borderstyle="Line" bordercolor="#dddddd"/>'
			         + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
			         //+ '           <GROUP level="1"/>'
			         + '       </COLUMN>'

			         + '       <COLUMN id="RANKNO" refcolid="RANK_NO" index="1">'
                     + '           <SUPPRESS>              <REFCOLID>RANK_NO</REFCOLID>           </SUPPRESS>'
			         + '           <HEADER left="0" top="0" right="30" bottom="40" text="순위" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			         + '           <VIEW left="0" top="0" right="30" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			         + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
			         //+ '           <GROUP level="1"/>'
			         + '       </COLUMN>'

                     + '       <COLUMN id="VENCD" refcolid="VEN_CD" index="2">'
                     //+ '           <SUPPRESS>              <REFCOLID>VEN_CD</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="30" top="0" right="90" bottom="40" text="협력사;코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="30" top="0" right="90" bottom="20" align="Center"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     //+ '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="VENNM"  refcolid="VEN_NM" index="3">'
                     //+ '           <SUPPRESS>              <REFCOLID>VEN_NAME</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="90" top="0" right="210" bottom="40" text="협력사명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="90" top="0" right="210" bottom="20" align="leftCenter" borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     //+ '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="REPPUMBUNCD"  refcolid="REP_PUMBUN_CD" index="4">'
                     //+ '           <SUPPRESS>              <REFCOLID>REP_PUMBUN_CD</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="210" top="0" right="290" bottom="40" text="대표;브랜드코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="210" top="0" right="290" bottom="20" align="Center" borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     //+ '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="REPPUMBUNNM"  refcolid="REP_PUMBUN_NM" index="5">'
                     //+ '           <SUPPRESS>              <REFCOLID>REP_PUMBUN_NM</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="290" top="0" right="410" bottom="40" text="대표브랜드명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="290" top="0" right="410" bottom="20" align="leftCenter" borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     //+ '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="MONTHAVG"  refcolid="MONTH_AVG">'
                     + '           <HEADER left="410" top="0" right="510" bottom="40" text="월평균" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="410" top="0" right="510" bottom="20" align="RightCenter"  displayformat="#,##0" borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(MONTH_AVG)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(NORM_SALE_AMT)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOTNORMSALE"  refcolid="TOT_NORM_SALE">'
                     + '           <HEADER left="510" top="0" right="610" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="510" top="0" right="610" bottom="20" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(TOT_NORM_SALE)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(ACHIEVE_RATE)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE01"  refcolid="NORM_SALE_01">'
                     + '           <HEADER left="610" top="0" right="710" bottom="40" text="1월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="610" top="0" right="710" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_01)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE02"  refcolid="NORM_SALE_02">'
                     + '           <HEADER left="710" top="0" right="810" bottom="40" text="2월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="710" top="0" right="810" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_02)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE03"  refcolid="NORM_SALE_03">'
                     + '           <HEADER left="810" top="0" right="910" bottom="40" text="3월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="810" top="0" right="910" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_03)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE04"  refcolid="NORM_SALE_04">'
                     + '           <HEADER left="910" top="0" right="1010" bottom="40" text="4월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="910" top="0" right="1010" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_04)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE05"  refcolid="NORM_SALE_05">'
                     + '           <HEADER left="1010" top="0" right="1110" bottom="40" text="5월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1010" top="0" right="1110" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_05)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE06"  refcolid="NORM_SALE_06">'
                     + '           <HEADER left="1110" top="0" right="1210" bottom="40" text="6월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1110" top="0" right="1210" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_06)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE07"  refcolid="NORM_SALE_07">'
                     + '           <HEADER left="1210" top="0" right="1310" bottom="40" text="7월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1210" top="0" right="1310" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_07)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE08"  refcolid="NORM_SALE_08">'
                     + '           <HEADER left="1310" top="0" right="1410" bottom="40" text="8월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1310" top="0" right="1410" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_08)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE09"  refcolid="NORM_SALE_09">'
                     + '           <HEADER left="1410" top="0" right="1510" bottom="40" text="9월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1410" top="0" right="1510" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_09)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE10"  refcolid="NORM_SALE_10">'
                     + '           <HEADER left="1510" top="0" right="1610" bottom="40" text="10월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1510" top="0" right="1610" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_10)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE11"  refcolid="NORM_SALE_11">'
                     + '           <HEADER left="1610" top="0" right="1710" bottom="40" text="11월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1610" top="0" right="1710" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_11)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NORMSALE12"  refcolid="NORM_SALE_12">'
                     + '           <HEADER left="1710" top="0" right="1810" bottom="40" text="12월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="1710" top="0" right="1810" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_12)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
                     + '       </COLUMN>'

                     + '     </COLUMNINFO>';
    

    initMGridStyle(GD_MASTER, "common", hdrProperies);
    
    GD_MASTER.EnableDblClkAtNotEditable = true;
    GD_MASTER.ViewSummary = 1;
}

// 브랜드  선택 //
function gridCreate2(){
    var hdrProperies = '<COLUMNINFO>'
			        
			        + '       <COLUMN id="STRCD" refcolid="STR_CD" view="false">'
			        + '           <HEADER left="0" top="0" right="0" bottom="40" text="점" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="0" top="0" right="0" bottom="20" edit="" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
			        //+ '           <GROUP level="1"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="RANKNO" refcolid="RANK_NO" index="1">'
			        + '           <SUPPRESS>              <REFCOLID>RANK_NO</REFCOLID>           </SUPPRESS>'
			        + '           <HEADER left="0" top="0" right="30" bottom="40" text="순위" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="0" top="0" right="30" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
			        //+ '           <GROUP level="1"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="PUMBUNCD"  refcolid="PUMBUN_CD" index="2">'
			        //+ '           <SUPPRESS>              <REFCOLID>PUMBUN_CD</REFCOLID>           </SUPPRESS>' //  view="false"
			        + '           <HEADER left="30" top="0" right="110" bottom="40" text="브랜드코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="30" top="0" right="110" bottom="20" align="Center" borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
			        //+ '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="PUMBUNNM"  refcolid="PUMBUN_NM" index="3">'
			        //+ '           <SUPPRESS>              <REFCOLID>PUMBUN_NM</REFCOLID>           </SUPPRESS>'
			        + '           <HEADER left="110" top="0" right="230" bottom="40" text="브랜드명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="110" top="0" right="230" bottom="20" align="leftCenter" borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
			        //+ '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="MONTHAVG"  refcolid="MONTH_AVG">'
			        + '           <HEADER left="230" top="0" right="330" bottom="40" text="월평균" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="230" top="0" right="330" bottom="20" align="RightCenter"  displayformat="#,##0" borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(MONTH_AVG)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(NORM_SALE_AMT)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="TOTNORMSALE"  refcolid="TOT_NORM_SALE">'
			        + '           <HEADER left="330" top="0" right="430" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="330" top="0" right="430" bottom="20" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(TOT_NORM_SALE)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(ACHIEVE_RATE)"/>'
			        + '       </COLUMN>'
			        
			        + '       <COLUMN id="NORMSALE01"  refcolid="NORM_SALE_01">'
			        + '           <HEADER left="430" top="0" right="530" bottom="40" text="1월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="430" top="0" right="530" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_01)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE02"  refcolid="NORM_SALE_02">'
			        + '           <HEADER left="530" top="0" right="630" bottom="40" text="2월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="530" top="0" right="630" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_02)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE03"  refcolid="NORM_SALE_03">'
			        + '           <HEADER left="630" top="0" right="730" bottom="40" text="3월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="630" top="0" right="730" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_03)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE04"  refcolid="NORM_SALE_04">'
			        + '           <HEADER left="730" top="0" right="830" bottom="40" text="4월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="730" top="0" right="830" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_04)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE05"  refcolid="NORM_SALE_05">'
			        + '           <HEADER left="830" top="0" right="930" bottom="40" text="5월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="830" top="0" right="930" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_05)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE06"  refcolid="NORM_SALE_06">'
			        + '           <HEADER left="930" top="0" right="1030" bottom="40" text="6월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="930" top="0" right="1030" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_06)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE07"  refcolid="NORM_SALE_07">'
			        + '           <HEADER left="1030" top="0" right="1130" bottom="40" text="7월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="1030" top="0" right="1130" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_07)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE08"  refcolid="NORM_SALE_08">'
			        + '           <HEADER left="1130" top="0" right="1230" bottom="40" text="8월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="1130" top="0" right="1230" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_08)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE09"  refcolid="NORM_SALE_09">'
			        + '           <HEADER left="1230" top="0" right="1330" bottom="40" text="9월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="1230" top="0" right="1330" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_09)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE10"  refcolid="NORM_SALE_10">'
			        + '           <HEADER left="1330" top="0" right="1430" bottom="40" text="10월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="1330" top="0" right="1430" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_10)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE11"  refcolid="NORM_SALE_11">'
			        + '           <HEADER left="1430" top="0" right="1530" bottom="40" text="11월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="1430" top="0" right="1530" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_11)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '       <COLUMN id="NORMSALE12"  refcolid="NORM_SALE_12">'
			        + '           <HEADER left="1530" top="0" right="1630" bottom="40" text="12월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
			        + '           <VIEW left="1530" top="0" right="1630" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
			        //+ '           <CHILD type="edit" inputtype="num" editable="false"/>' 
			        + '           <VIEWSUMMARY text="@GFSUM(NORM_SALE_12)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
			        //+ '           <GROUP level="1"  bgcolor="#99bb99" text="@GFSUBSUM(SALE_AVG_DAY)"/>'
			        + '       </COLUMN>'
			
			        + '     </COLUMNINFO>';


initMGridStyle(GD_MASTER, "common", hdrProperies);

GD_MASTER.EnableDblClkAtNotEditable = true;
GD_MASTER.ViewSummary = 1;
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search(strOrgFlag) {

    if( LC_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_STR_CD.Focus();
        return false;
    }else if( EM_SALE_DT_S.Text == "" || EM_SALE_DT_E.Text == ""){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "기간");            
        EM_SALE_DT_S.Focus();
        return false;
    }

    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    
    if(EM_ORG_FLAG.CodeValue=="1"){ 
    	var strOrgFlag = EM_ORG_FLAG.CodeValue;      // '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />'; //조직구분 코드
    	
    }else {
    	var strOrgFlag = EM_ORG_FLAG.CodeValue;    	
    }   
   	var strSearchFg     = EM_GB_FLAG.CodeValue;      //조회구분
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strSearchCnt    = EM_SEARCH_CNT.text;        //조회건수
    
    //GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
    //GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
    
    if (strSearchFg == "1") {
        // Output Data Set Header 초기화
        DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER1"/>');
       
        //그리드 초기화
        gridCreate1(); //마스터
    }else if (strSearchFg == "2") {
        // Output Data Set Header 초기화
        DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');
       
        //그리드 초기화
        gridCreate2(); //마스터
    }
    
    var goTo       = "searchMaster" ;  
    var action     = "O";     
    var parameters = "&strOrgFlag="         +encodeURIComponent(strOrgFlag)      //조직구분 코드
                   + "&strSearchFg="        +encodeURIComponent(strSearchFg)     //조회구분
                   + "&strStrCd="           +encodeURIComponent(strStrCd)        //점
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)       //팀
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)       //파트
                   + "&strPCCd="            +encodeURIComponent(strPCCd)         //PC
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)      //매출일자-1
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)      //매출일자-2
                   + "&strSearchCnt="       +encodeURIComponent(strSearchCnt)    //조회건수 
                   ;
    
    TR_MAIN.Action="/dps/psal457.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //alert("1");
    GD_MASTER.focus();
    // 조회결과 Return
    //alert("2");
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    //alert("3");

    //스크롤바 위치 조정
    //GD_MASTER.SETVSCROLLING(0);
    //alert("4");
    //GD_MASTER.SETHSCROLLING(0);
    //alert("5");
    
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Save() {

    
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "년월매출순위분석";

   	var strSearchFg     = EM_GB_FLAG.CodeValue;      //조회구분
   	if (strSearchFg=="1") {
   		strTitle = strTitle + " 협력사";
   	} else if (strSearchFg=="2") {
   		strTitle = strTitle + " 브랜드";
   	}
   		
    var strStrCd        = LC_STR_CD.Text;            //점
    var strDeptCd       = LC_DEPT_CD.Text;           //팀
    var strTeamCd       = LC_TEAM_CD.Text;           //파트
    var strPCCd         = LC_PC_CD.Text;             //PC
    
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strSearchCnt    = EM_SEARCH_CNT.text;        //조회건수
    
    var parameters = "점 "           + strStrCd
                   + " ,   팀 "     + strDeptCd
                   + " ,   파트 "       + strTeamCd
                   + " ,   PC "      + strPCCd
                   + " ,   매출기간 "  + strSaleDtS + " ~ "  + strSaleDtE ;
    
        parameters = parameters 
                   + " ,   조회건수 "  + strSearchCnt
    	           + " ,   단위: 천원";
    
    //GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    //openExcel2(GD_MASTER, strTitle, parameters, true );
    openExcelM2(GD_MASTER, strTitle, parameters, true, g_strPid );
 	//openExcel5(GD_MASTER, strTitle, parameters, true , "",g_strPid );   
}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */

 function btn_Conf() {
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
	 
    switch (gbn){
    case "search" :

        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }
        //팀 체크
        if (isNull(LC_DEPT_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","팀");
            LC_DEPT_CD.focus();
            return false;
        }

        //PC가 전체가 이닐경우 파트 체크
        if(LC_PC_CD.BindColVal != "%" && LC_TEAM_CD.BindColVal == "%"){
            showMessage(Information, OK, "USER-1003","파트");
            LC_TEAM_CD.focus();
            return false;
        }
        //매출일자
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출기간"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 6 ) {
            showMessage(Information, OK, "USER-1027","매출기간","6");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMM(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출기간");
            EM_SALE_DT_S.focus();
            return false;
        }

        if(EM_SEARCH_CNT.text == ""){
        	showMessage(Information, OK, "USER-1003","조회건수"); 
        	EM_SEARCH_CNT.focus();
            return false;
        }

        if(EM_SEARCH_CNT.text <= 0){
        	showMessage(Information, OK, "USER-1008","조회건수", "0"); 
            EM_SEARCH_CNT.focus();
            return false;
        }

        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출기간"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 6 ) {
            showMessage(Information, OK, "USER-1027","매출기간","6");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMM(EM_SALE_DT_E.text)){
            showMessage(Information, OK, "USER-1004","매출기간");
            EM_SALE_DT_E.focus();
            return false;
        }if(!isBetweenFromTo(EM_SALE_DT_S.text, EM_SALE_DT_E.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        break;
    }
    return true;
}

</script>

</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->
<!-- 조회건수 -->

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

<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 기간From -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;    
</script>

<!-- 기간To -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;    
</script>

 <!-- Grid GD_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>

</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>

</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

</script>

<script language="javascript">

</script>

<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_ORG_FLAG event=OnSelChange()>
	//매장조직
	if(EM_ORG_FLAG.CodeValue=="1"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		
		getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                       // 점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.Index = 0; 
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	    
	 //매입조직
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;		
	    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                       // 점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
	     
	    LC_STR_CD.Index = 0; 
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0;
	    
	}

</script>

<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    // var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

<!-- 조회구분 면경시 -->
<script language=JavaScript for=EM_GB_FLAG event=OnSelChange()>
    
</script>


<!-- 조회건수 -->
<script language=JavaScript for=EM_SEARCH_CNT event=onKillFocus()>
    if(EM_SEARCH_CNT.Text == ""){
    	EM_SEARCH_CNT.Text = 50;
    }
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>    
    
    var strOrgFlag=EM_ORG_FLAG.CodeValue;
	
	
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC
    
    LC_DEPT_CD.Index = 0; 
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0; 
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
    	var strOrgFlag=EM_ORG_FLAG.CodeValue;        
        getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트
    }else{
        DS_TEAM_CD.ClearData();
        insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
    if(LC_TEAM_CD.BindColVal != "%"){
    	
    	var strOrgFlag=EM_ORG_FLAG.CodeValue;        
        getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=EM_SALE_DT_S event=OnSelChange()>
	EM_SALE_DT_E.text = addDate(EM_SALE_DT_S.text);
</script>

<!-- 마스터 그리드 컬럼 변경시 저장 체크 처리 -->
<script language=Javascript for=GD_MASTER
   event=OnColumnPosChanged(Row,Colid)>
</script>

<script language="javascript" for=GD_MASTER
   event=OnUserColor(Row,eventid)>
</script>

<script language=JavaScript for=DS_O_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row

// 이 Event에서 SetColumn을 사용하는 것은 의미가 없다. Changed를 수행한 후 SetColumn이 자동으로 수행되기 때문이다.
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

if(!this.Modified)
	return;
	
    //영업조회월
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출기간"); 
        EM_SALE_DT_S.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 6 ) {
        showMessage(Information, OK, "USER-1027","매출기간","6");
        EM_SALE_DT_S.text = varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","매출기간");
        EM_SALE_DT_S.text = varToMon;
        return ;
    }

    // EM_SALE_E_DT.text = addDate('M',-1, EM_SALE_S_DT.text);
</script>


<!-- 매장으로 접근시 에는 매장 매입이 Enable 되고 매입 접근시 Disable 된다 -->


<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>
if(!this.Modified)
    return;

    //영업조회월
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출기간"); 
        EM_SALE_DT_E.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 6 ) {
        showMessage(Information, OK, "USER-1027","매출기간","6");
        EM_SALE_DT_E.text = varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","매출기간");
        EM_SALE_DT_E.text = varToMon;
        return ;
    }

</script>

<SCRIPT language=javascript>

function orgFlagCheck(orgFlag){ 

		if (orgFlag == "11") {
			EM_ORG_FLAG.Enable = "false";
			EM_ORG_FLAG.Reset();
		}else if (orgFlag == "12") {
			EM_ORG_FLAG.Enable = "true";
			EM_ORG_FLAG.Reset();
		}else{
			EM_ORG_FLAG.Enable = "false";
		}
}

</SCRIPT>

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
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PC_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_0_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
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
      <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
         class="o_table">
         <tr>
            <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
               class="s_table">
               <tr>
               	<!-- 신규추가 -->
                  <th class="point" width="95">조직구분</th>
                  <td width="105" >
                    <comment id="_NSID_">
                    <object id="EM_ORG_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:95">
                    <param name=Cols    value="2">
                    <param name=Format  value="1^매장,2^매입">                   
                    <param name=CodeValue  value="<%=sessionInfo.getORG_FLAG()%>">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>
                  <!-- 
                  <th width="80" ></th>
                  <td width="150">
                  </td>
                   -->
                  <th class="point" width="95">구분</th>
                  <td colspan = "5">
                    <comment id="_NSID_">
                    <object id="EM_GB_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:300">
                    <param name=Cols    value="3">
                    <param name=Format  value="1^협력사,2^브랜드">
                    <param name=CodeValue  value="2">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>
                  <!--             
                  <th width="70" ></th>
                  <td>
                  </td>
                   --> 
               </tr>
               <!-- 신규추가 끝 -->
               <tr>              
                  <th class="point" width="95">점</th>
                  <td width="115"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80" >팀</th>
                  <td width="130"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="95" >파트</th>
                  <td width="130"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
		            <th class="point" width="95">조회년월</th>
		            <td colspan="3">
		                <comment id="_NSID_">
		                      <object id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1>
		                      </object>
		                </comment><script> _ws_(_NSID_);</script>
		                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_SALE_DT_S)" align="absmiddle" />
		                 ~ <comment id="_NSID_">
		                      <object id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1>
		                      </object>
		                </comment><script> _ws_(_NSID_);</script>
		                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_SALE_DT_E)" align="absmiddle" />
		            </td>            
                  <th class="point" >조회건수</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_SEARCH_CNT classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                  </td>   
                  <th >단위</th>
                  <td >원
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
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_">
                  	<object id=GD_MASTER width=100% height=740 classid=<%=Util.CLSID_MGRID%> tabindex=1>
                     	<param name="DataID" value="DS_O_MASTER">
                     	<Param Name="IndicatorInfo"       value='<INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     	<Param Name="sort"      value="false">
                  	</object>
                  </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>