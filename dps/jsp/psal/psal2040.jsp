<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 실행계획
 * 작 성 일 : 2010.04.05
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal2040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 파트별실행매출계획조회
 * 이    력 :2010.04.05 박종은
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
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
 var top = 350;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');   
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    
    initEmEdit(EM_EXE_YM_S,                      "YYYYMM",                PK);   //년월
    EM_EXE_YM_S.alignment = 1;

    //현재년도 셋팅
    EM_EXE_YM_S.text =  now.getYear().toString()+ "01" ;      //varToMon;
    
    initEmEdit(EM_EXE_YM_E,                      "YYYYMM",                PK);   //년월
    EM_EXE_YM_E.alignment = 1;

    //현재년도 셋팅
    EM_EXE_YM_E.text =  now.getYear().toString()+ "12" ;      //varToMon;
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y");   // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal204","DS_O_MASTER" );
    
}

function gridCreate1(){

    var hdrProperies = '<COLUMNINFO>'

                     + '       <COLUMN id="STRCD" refcolid="STR_CD" view="false">'
                     + '           <HEADER left="0" top="0" right="100" bottom="20" text="점" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="0" top="0" right="100" bottom="40" edit="" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '           <GROUP level="1"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="DEPTCD" refcolid="DEPT_CD"  view="false">'
                     + '           <HEADER left="0" top="0" right="100" bottom="20" text="팀" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="0" top="0" right="100" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '           <GROUP level="1"/>'
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="TEAMCD" refcolid="TEAM_CD" index="1">'
                     + '           <SUPPRESS>              <REFCOLID>TEAM_CD</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="0" top="0" right="100" bottom="20" text="파트코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="0" top="0" right="100" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '           <GROUP level="1"/>'
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="TEAMNAME"  refcolid="TEAM_NAME" index="2">'
                     + '           <SUPPRESS>              <REFCOLID>TEAM_NAME</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="100" top="0" right="200" bottom="20" text="파트명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="100" top="0" right="200" bottom="40" align="leftCenter"   borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
                     + '           <GROUP level="1"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="YM"  refcolid="EXE_YM" index="3">'
                     + '           <HEADER left="200" top="0" right="260" bottom="20" text="년월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="200" top="0" right="260" bottom="40"   displayformat="XXXX/XX" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '           <GROUP level="1" bgcolor="#99bb99" text="@CURLEVEL"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="GUBUNBFYY"  refcolid="GUBUN_BFYY" >'
                     + '           <HEADER fix="true" left="260" top="0" right="350" bottom="20" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="260" top="0" right="350" bottom="20" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="전년매출"  bgcolor="#b9d9ea"/>' 
                     + '           <GROUP level="1" color="red" bgcolor="#99bb99" text=""/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYNORMSAMTTOT"  refcolid="BFYY_NORM_SAMT">'
                     + '           <HEADER left="350" top="0" right="450" bottom="20" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="350" top="0" right="450" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_NORM_SAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <GROUP level="1" color="red" bgcolor="#99bb99" text="@GFSUBSUM(BFYY_NORM_SAMT)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYEVTSAMTTOT"  refcolid="BFYY_EVT_SAMT">'
                     + '           <HEADER left="450" top="0" right="550" bottom="20" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="450" top="0" right="550" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <GROUP level="1" color="red" bgcolor="#99bb99" text="@GFSUBSUM(BFYY_EVT_SAMT)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALETAMTTOT"  refcolid="BFYY_SALE_TAMT">'
                     + '           <HEADER left="550" top="0" right="650" bottom="20" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="550" top="0" right="650" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <GROUP level="1" color="red" bgcolor="#99bb99" text="@GFSUBSUM(BFYY_SALE_TAMT)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFTAMTTOT"  refcolid="BFYY_PROF_TAMT">'
                     + '           <HEADER left="650" top="0" right="750" bottom="20" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="650" top="0" right="750" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <GROUP level="1" color="red" bgcolor="#99bb99" text="@GFSUBSUM(BFYY_PROF_TAMT)"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALECRATETOT"  refcolid="BFYY_SALE_CRATE">'
                     + '           <HEADER left="750" top="0" right="830" bottom="20" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="750" top="0" right="830" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFCRATETOT"  refcolid="BFYY_PROF_CRATE">'
                     + '           <HEADER left="830" top="0" right="910" bottom="20" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="830" top="0" right="910" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALEIRATETOT"  refcolid="BFYY_SALE_IRATE">'
                     + '           <HEADER left="910" top="0" right="980" bottom="20" text="매출신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFIRATETOT"  refcolid="BFYY_PROF_IRATE" >'
                     + '           <HEADER left="980" top="0" right="1050" bottom="20" text="이익신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="GBN_ORIGIN"  refcolid="GUBUN_ORIGIN" >'
                     + '           <HEADER left="260" top="0" right="350" bottom="20" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="260" top="20" right="350" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="실행목표"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINNORMSAMTTOT"  refcolid="ORIGIN_NORM_SAMT" >'
                     + '           <HEADER left="350" top="0" right="450" bottom="20" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="350" top="20" right="450" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINEVTSAMTTOT"  refcolid="ORIGIN_EVT_SAMT" >'
                     + '           <HEADER left="450" top="0" right="550" bottom="20" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="450" top="20" right="550" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALETAMTTOT"  refcolid="ORIGIN_SALE_TAMT" >'
                     + '           <HEADER left="550" top="0" right="650" bottom="20" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="550" top="20" right="650" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFTAMTTOT"  refcolid="ORIGIN_PROF_TAMT" >'
                     + '           <HEADER left="650" top="0" right="750" bottom="20" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="650" top="20" right="750" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALECRATETOT"  refcolid="ORIGIN_SALE_CRATE" >'
                     + '           <HEADER left="750" top="0" right="830" bottom="20" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="750" top="20" right="830" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFCRATETOT"  refcolid="ORIGIN_PROF_CRATE" >'
                     + '           <HEADER left="830" top="0" right="910" bottom="20" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="830" top="20" right="910" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALEIRATETOT"  refcolid="ORIGIN_SALE_IRATE">'
                     + '           <HEADER left="910" top="0" right="980" bottom="20" text="매출신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="910" top="0" right="980" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFIRATETOT"  refcolid="ORIGIN_PROF_IRATE" >'
                     + '           <HEADER left="980" top="0" right="1050" bottom="20" text="이익신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="980" top="0" right="1050" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false" borderstyle="Line" bordercolor="#dddddd"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                     + '     </COLUMNINFO>';
   

        
    initMGridStyle(GD_MASTER, "common", hdrProperies);
    GD_MASTER.EnableDblClkAtNotEditable = true;
    GD_MASTER.ViewSummary = 1;
}

function gridCreate2(lastday){

    var hdrProperies = '<COLUMNINFO>'
                    
                     + '       <COLUMN id="PCCD" refcolid="CODE" index="1">'
                     + '           <HEADER left="0" top="0" right="100" bottom="40" text="PC코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="0" top="0" right="100" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="PCNAME"  refcolid="NAME" index="2">'
                     + '           <HEADER left="100" top="0" right="200" bottom="40" text="PC명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="100" top="0" right="200" bottom="40" align="leftCenter"   borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GBN_BFYY"  refcolid="GUBUN_BFYY" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="200" top="0" right="300" bottom="20" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="전년매출"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOT"  refcolid="TOTAL">'
                     + '           <HEADER left="300" top="0" right="1000" bottom="20" text="월합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYNORMSAMT"  refcolid="BFYY_NORM_SAMT_TOT">'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="0" right="400" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_NORM_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYEVTSAMT"  refcolid="BFYY_EVT_SAMT_TOT">'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="0" right="500" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALETAMT"  refcolid="BFYY_SALE_TAMT_TOT">'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="500" top="0" right="600" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFTAMT"  refcolid="BFYY_PROF_TAMT_TOT">'
                     + '           <HEADER left="600" top="20" right="700" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="600" top="0" right="700" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALECRATE"  refcolid="BFYY_SALE_CRATE_TOT">'
                     + '           <HEADER left="700" top="20" right="780" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="700" top="0" right="780" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFCRATE"  refcolid="BFYY_PROF_CRATE_TOT">'
                     + '           <HEADER left="780" top="20" right="860" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="780" top="0" right="860" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GBN_ORIGIN"  refcolid="GUBUN_ORIGIN" >'
                     + '           <HEADER left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="200" top="20" right="300" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="실행목표"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINNORMSAMT"  refcolid="ORIGIN_NORM_SAMT_TOT" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="20" right="400" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINEVTSAMT"  refcolid="ORIGIN_EVT_SAMT_TOT" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="20" right="500" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALETAMT"  refcolid="ORIGIN_SALE_TAMT_TOT" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="500" top="20" right="600" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#dddddd" />'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFTAMT"  refcolid="ORIGIN_PROF_TAMT_TOT" >'
                     + '           <HEADER left="600" top="20" right="700" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="600" top="20" right="700" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALECRATE"  refcolid="ORIGIN_SALE_CRATE_TOT" >'
                     + '           <HEADER left="700" top="20" right="780" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="700" top="20" right="780" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFCRATE"  refcolid="ORIGIN_PROF_CRATE_TOT" >'
                     + '           <HEADER left="780" top="20" right="860" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="780" top="20" right="860" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALEIRATE"  refcolid="ORIGIN_SALE_IRATE_TOT">'
                     + '           <HEADER left="860" top="20" right="930" bottom="40" text="매출신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="860" top="0" right="930" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFIRATE"  refcolid="ORIGIN_PROF_IRATE_TOT" >'
                     + '           <HEADER left="930" top="20" right="1000" bottom="40" text="이익신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="930" top="0" right="1000" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     
    var j = 0;
    if(lastday == null){
        var lastDate = new Date(varToMon.substr(0,4), varToMon.substr(4,2), 0);
        lastday  = lastDate.getDate();
    }
    
    for(i=1;i<= lastday; i++){
        
        hdrProperies +=  

                       '       <COLUMN id="TOT'+i+'"  refcolid="TOTAL'+i+'">'
                     + '           <HEADER left="'+(900+((i+j)*100))+'" top="0" right="'+(1600+((i+j)*100))+'" bottom="20" text="'+i+'일" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYNORMSAMT'+i+'"  refcolid="BFYY_NORM_SAMT'+i+'">'
                     + '           <HEADER left="'+(900+((i+j)*100))+'" top="20" right="'+(1000+((i+j)*100))+'" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(900+((i+j)*100))+'" top="0" right="'+(1000+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_NORM_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYEVTSAMT'+i+'"  refcolid="BFYY_EVT_SAMT'+i+'">'
                     + '           <HEADER left="'+(1000+((i+j)*100))+'" top="20" right="'+(1100+((i+j)*100))+'" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1000+((i+j)*100))+'" top="0" right="'+(1100+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYSALETAMT'+i+'"  refcolid="BFYY_SALE_TAMT'+i+'">'
                     + '           <HEADER left="'+(1100+((i+j)*100))+'" top="20" right="'+(1200+((i+j)*100))+'" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1100+((i+j)*100))+'" top="0" right="'+(1200+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYPROFTAMT'+i+'"  refcolid="BFYY_PROF_TAMT'+i+'">'
                     + '           <HEADER left="'+(1200+((i+j)*100))+'" top="20" right="'+(1300+((i+j)*100))+'" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1200+((i+j)*100))+'" top="0" right="'+(1300+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALECRATE'+i+'"  refcolid="BFYY_SALE_CRATE'+i+'">'
                     + '           <HEADER left="'+(1300+((i+j)*100))+'" top="20" right="'+(1400+((i+j)*100-20))+'" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1300+((i+j)*100))+'" top="0" right="'+(1400+((i+j)*100-20))+'" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYPROFCRATE'+i+'"  refcolid="BFYY_PROF_CRATE'+i+'">'
                     + '           <HEADER left="'+(1400+((i+j)*100-20))+'" top="20" right="'+(1480+((i+j)*100-20))+'" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1400+((i+j)*100-20))+'" top="0" right="'+(1480+((i+j)*100-20))+'" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
        
                     + '       <COLUMN id="ORIGINNORMSAMT'+i+'"  refcolid="ORIGIN_NORM_SAMT'+i+'" >'
                     + '           <HEADER left="'+(900+((i+j)*100))+'" top="20" right="'+(1000+((i+j)*100))+'" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(900+((i+j)*100))+'" top="20" right="'+(1000+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINEVTSAMT'+i+'"  refcolid="ORIGIN_EVT_SAMT'+i+'" >'
                     + '           <HEADER left="'+(1000+((i+j)*100))+'" top="20" right="'+(1100+((i+j)*100))+'" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1000+((i+j)*100))+'" top="20" right="'+(1100+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINSALETAMT'+i+'"  refcolid="ORIGIN_SALE_TAMT'+i+'" >'
                     + '           <HEADER left="'+(1100+((i+j)*100))+'" top="20" right="'+(1200+((i+j)*100))+'" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1100+((i+j)*100))+'" top="20" right="'+(1200+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINPROFTAMT'+i+'"  refcolid="ORIGIN_PROF_TAMT'+i+'" >'
                     + '           <HEADER left="'+(1200+((i+j)*100))+'" top="20" right="'+(1300+((i+j)*100))+'" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1200+((i+j)*100))+'" top="20" right="'+(1300+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINSALECRATE'+i+'"  refcolid="ORIGIN_SALE_CRATE'+i+'" >'
                     + '           <HEADER left="'+(1300+((i+j)*100))+'" top="20" right="'+(1400+((i+j)*100-20))+'" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1300+((i+j)*100))+'" top="20" right="'+(1400+((i+j)*100-20))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINPROFCRATE'+i+'"  refcolid="ORIGIN_PROF_CRATE'+i+'" >'
                     + '           <HEADER left="'+(1400+((i+j)*100-20))+'" top="20" right="'+(1480+((i+j)*100-20))+'" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1400+((i+j)*100-20))+'" top="20" right="'+(1480+((i+j)*100-20))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINSALEIRATE'+i+'"  refcolid="ORIGIN_SALE_IRATE'+i+'">'
                     + '           <HEADER left="'+(1480+((i+j)*100-20))+'" top="20" right="'+(1560+((i+j)*100-30))+'" bottom="40" text="매출신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1480+((i+j)*100-20))+'" top="0" right="'+(1560+((i+j)*100-30))+'" bottom="40" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#dddddd" />'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINPROFIRATE'+i+'"  refcolid="ORIGIN_PROF_IRATE'+i+'" >'
                     + '           <HEADER left="'+(1560+((i+j)*100-30))+'" top="20" right="'+(1630+((i+j)*100-30))+'" bottom="40" text="이익신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1560+((i+j)*100-30))+'" top="0" right="'+(1630+((i+j)*100-30))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '       </COLUMN>'
          j += 6;
        
    }
   
        hdrProperies +='     </COLUMNINFO>';
        
    
    initMGridStyle(GD_DETAIL, "common", hdrProperies);
    //GD_DETAIL.SelectedColor = "yellow";
    //GD_DETAIL.SelectedColorRate = 30;
    GD_DETAIL.EnableDblClkAtNotEditable = true;
    GD_DETAIL.ViewSummary = 1;
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
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strExeYmS      = EM_EXE_YM_S.text;         //시작년월
    var strExeYmE      = EM_EXE_YM_E.text;         //종료년월
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strExeYmS="          +encodeURIComponent(strExeYmS)
                   + "&strExeYmE="          +encodeURIComponent(strExeYmE);
    
    TR_MAIN.Action="/dps/psal204.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    
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

    if(DS_O_DETAIL.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "파트별실행매출목표조회";

    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strExeYmS       = EM_EXE_YM_S.text;         //시작년월
    var strExeYmE       = EM_EXE_YM_E.text;         //종료년월
    
    var parameters = "점 "                   + strStrCd
                   + ",   팀 "             + strDeptCd
                   + ",   파트 "               + strTeamCd
                   + ",   PC "              + strPCCd
                   + ",   기간 "          + strExeYmS + "~" + strExeYmE;
    
    //openExcelM(GD_DETAIL, strTitle, parameters, true );
    openExcelM2(GD_DETAIL, strTitle, parameters, true ,g_strPid );

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
 * searchDetail()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-16
 * 개    요 : 당초브랜드별월매출계획 조회
 * return값 : void
 */
 function searchDetail(){
     var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
     var strDeptCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
     var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
     var strPCCd         = LC_PC_CD.BindColVal;                                                //PC
     var strYYYYMM       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "EXE_YM");           //년월
     
     var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
     var strEndDate  = lastDate.getDate();                                                     //마지막일자
     
     gridCreate2(strEndDate);
     
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                    + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                    + "&strTeamCd="            +encodeURIComponent(strTeamCd)
                    + "&strPCCd="              +encodeURIComponent(strPCCd)
                    + "&strYYYYMM="            +encodeURIComponent(strYYYYMM)
                    + "&strEndDate="           +encodeURIComponent(strEndDate);
     
     TR_DETAIL.Action="/dps/psal204.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);
     
     GD_DETAIL.focus();
     GD_MASTER.Focus();
     
 }


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
            showMessage(INFORMATION, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }
        //팀 체크
        if (isNull(LC_DEPT_CD.BindColVal)==true ) {
            showMessage(INFORMATION, OK, "USER-1003","팀");
            LC_DEPT_CD.focus();
            return false;
        }

        //PC가 전체가 이닐경우 파트 체크
        if(LC_PC_CD.BindColVal != "%" && LC_TEAM_CD.BindColVal == "%"){
            showMessage(INFORMATION, OK, "USER-1003","파트");
            LC_TEAM_CD.focus();
            return false;
        }
        //계획년월
        if (isNull(EM_EXE_YM_S.text) ==true ) {
            showMessage(INFORMATION, OK, "USER-1003","시작년월"); 
            EM_EXE_YM_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_EXE_YM_S.text.replace(" ","").length != 6 ) {
            showMessage(INFORMATION, OK, "USER-1027","시작년월","6");
            EM_EXE_YM_S.focus();
            return false;
        }
        if(!checkYYYYMM(EM_EXE_YM_S.text)){
            showMessage(INFORMATION, OK, "USER-1004","시작년월");
            EM_EXE_YM_S.focus();
            return false;
        }
            
        if (isNull(EM_EXE_YM_E.text) ==true ) {
            showMessage(INFORMATION, OK, "USER-1003","종료년월"); 
            EM_EXE_YM_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_EXE_YM_E.text.replace(" ","").length != 6 ) {
            showMessage(INFORMATION, OK, "USER-1027","종료년월","6");
            EM_EXE_YM_E.focus();
            return false;
        }
        if(!checkYYYYMM(EM_EXE_YM_E.text)){
            showMessage(INFORMATION, OK, "USER-1004","종료년월");
            EM_EXE_YM_E.focus();
            return false;
        }
        //시작년월과 종료년월 between체크
        if(!isBetweenFromTo(EM_EXE_YM_S.text, EM_EXE_YM_E.text)){
            showMessage(INFORMATION, OK, "USER-1000","시작년월은 종료년월보다 클 수 없습니다."); 
            EM_EXE_YM_S.focus();
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

 <!-- Grid GD_MASTER OnPopup event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>

 </script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row > 0){
    searchDetail();
}
old_Row = row;
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
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
        getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트   
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
        getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
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
<script language=JavaScript for=EM_EXE_YM_S event=onKillFocus()>

    //영업조회월
    if (isNull(EM_EXE_YM_S.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","년월"); 
        EM_EXE_YM_S.text =  now.getYear().toString()+ "01" ;      //varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_EXE_YM_S.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","년월","6");
        EM_EXE_YM_S.text =  now.getYear().toString()+ "01" ;      //varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_EXE_YM_S.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","년월");
        EM_EXE_YM_S.text =  now.getYear().toString()+ "01" ;      //varToMon;
        return ;
    }
    
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_EXE_YM_E event=onKillFocus()>


    //영업조회월
    if (isNull(EM_EXE_YM_E.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","년월"); 
        EM_EXE_YM_E.text =  now.getYear().toString()+ "12" ;      //varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_EXE_YM_E.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","년월","6");
        EM_EXE_YM_E.text =  now.getYear().toString()+ "12" ;      //varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_EXE_YM_E.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","년월");
        EM_EXE_YM_E.text =  now.getYear().toString()+ "12" ;      //varToMon;
        return ;
    }
    
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
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL_CHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_CHKORGPUMBUN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_0_PC" classid=<%=Util.CLSID_DATASET%>></object>
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
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
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
      <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
         class="o_table">
         <tr>
            <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
               class="s_table">
               <tr>
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" class="point">팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" >파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">년월</th>
                  <td colspan="7"><comment id="_NSID_"> <object
                     id=EM_EXE_YM_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_EXE_YM_S)" align="absmiddle" />
                     ~
                     <comment id="_NSID_"> <object
                     id=EM_EXE_YM_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_EXE_YM_E)" align="absmiddle" />
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
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=195 classid=<%=Util.CLSID_MGRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr valign="top" class="PT10">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object 
                  id=GD_DETAIL width=100% height=273 classid=<%=Util.CLSID_MGRID%>>
                     <param name="DataID" value="DS_O_DETAIL">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
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
