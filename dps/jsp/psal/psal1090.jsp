<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 당초계획
 * 작 성 일 : 2010.04.04
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal1090.jsp 
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 당초월매출계획조회
 * 이    력 :2010.04.04 박종은
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
 var top = 150;		//해당화면의 그리드top위치
function doInit(){
    
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    //gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_PLAN_YEAR, "YYYY", PK);                                            //계획년
    EM_PLAN_YEAR.alignment = 1;
    initEmEdit(EM_PUMBUN_CD,         "CODE^6^0",    NORMAL);          //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME,       "GEN^40",      READ);          //브랜드(조회)
    
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
    
    //현재년도 셋팅
    EM_PLAN_YEAR.text = today.getYear();
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal109","DS_O_MASTER" );
    
}

function gridCreate1(){

    var hdrProperies = '<COLUMNINFO>'
                    
                     + '       <COLUMN id="CD" refcolid="CODE" index="1">'
                     + '           <HEADER left="0" top="0" right="100" bottom="40" text="코드"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="0" top="0" right="100" bottom="40" edit="" borderstyle="Line" bordercolor="#dddddd" />'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="NM"  refcolid="NAME" index="2">'
                     + '           <HEADER left="100" top="0" right="200" bottom="40" text="명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="100" top="0" right="200" bottom="40" align="leftCenter"   borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GBN_BFYY"  refcolid="GUBUN_BFYY" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="200" top="0" right="300" bottom="20" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="전년매출"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOT"  refcolid="TOTAL">'
                     + '           <HEADER left="300" top="0" right="1000" bottom="20" text="년합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYNORMSAMTTOT"  refcolid="BFYY_NORM_SAMT_TOT">'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="0" right="400" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_NORM_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYEVTSAMTTOT"  refcolid="BFYY_EVT_SAMT_TOT">'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="0" right="500" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALETAMTTOT"  refcolid="BFYY_SALE_TAMT_TOT">'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="500" top="0" right="600" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFTAMTTOT"  refcolid="BFYY_PROF_TAMT_TOT">'
                     + '           <HEADER left="600" top="20" right="700" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="600" top="0" right="700" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYSALECRATETOT"  refcolid="BFYY_SALE_CRATE_TOT">'
                     + '           <HEADER left="700" top="20" right="780" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="700" top="0" right="780" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="BFYYPROFCRATETOT"  refcolid="BFYY_PROF_CRATE_TOT">'
                     + '           <HEADER left="780" top="20" right="860" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="780" top="0" right="860" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="GBN_ORIGIN"  refcolid="GUBUN_ORIGIN" >'
                     + '           <HEADER fix="true" left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="200" top="20" right="300" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="당초목표"  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINNORMSAMTTOT"  refcolid="ORIGIN_NORM_SAMT_TOT" >'
                     + '           <HEADER left="300" top="20" right="400" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="20" right="400" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINEVTSAMTTOT"  refcolid="ORIGIN_EVT_SAMT_TOT" >'
                     + '           <HEADER left="400" top="20" right="500" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="20" right="500" bottom="40" align="RightCenter" displayformat="#,##0" borderstyle="Line" bordercolor="#dddddd" />'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALETAMTTOT"  refcolid="ORIGIN_SALE_TAMT_TOT" >'
                     + '           <HEADER left="500" top="20" right="600" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="500" top="20" right="600" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFTAMTTOT"  refcolid="ORIGIN_PROF_TAMT_TOT" >'
                    + '            <HEADER left="600" top="20" right="700" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                      + '          <VIEW left="600" top="20" right="700" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT_TOT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALECRATETOT"  refcolid="ORIGIN_SALE_CRATE_TOT" >'
                     + '           <HEADER left="700" top="20" right="780" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="700" top="20" right="780" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFCRATETOT"  refcolid="ORIGIN_PROF_CRATE_TOT" >'
                     + '           <HEADER left="780" top="20" right="860" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="780" top="20" right="860" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINSALEIRATETOT"  refcolid="ORIGIN_SALE_IRATE_TOT">'
                     + '           <HEADER left="860" top="20" right="930" bottom="40" text="매출신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="860" top="0" right="930" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="ORIGINPROFIRATETOT"  refcolid="ORIGIN_PROF_IRATE_TOT" >'
                     + '           <HEADER left="930" top="20" right="1000" bottom="40" text="이익신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="930" top="0" right="1000" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'

                     
    var j = 0;
    for(i=1;i<= 12; i++){
        
        hdrProperies +=  

                       '       <COLUMN id="TOT'+i+'"  refcolid="TOTAL'+i+'">'
                     + '           <HEADER left="'+(900+((i+j)*100))+'" top="0" right="'+(1600+((i+j)*100))+'" bottom="20" text="'+i+'월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYNORMSAMT'+i+'"  refcolid="BFYY_NORM_SAMT'+i+'">'
                     + '           <HEADER left="'+(900+((i+j)*100))+'" top="20" right="'+(1000+((i+j)*100))+'" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(900+((i+j)*100))+'" top="0" right="'+(1000+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_NORM_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYEVTSAMT'+i+'"  refcolid="BFYY_EVT_SAMT'+i+'">'
                     + '           <HEADER left="'+(1000+((i+j)*100))+'" top="20" right="'+(1100+((i+j)*100))+'" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1000+((i+j)*100))+'" top="0" right="'+(1100+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_EVT_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYSALETAMT'+i+'"  refcolid="BFYY_SALE_TAMT'+i+'">'
                     + '           <HEADER left="'+(1100+((i+j)*100))+'" top="20" right="'+(1200+((i+j)*100))+'" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1100+((i+j)*100))+'" top="0" right="'+(1200+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_SALE_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYPROFTAMT'+i+'"  refcolid="BFYY_PROF_TAMT'+i+'">'
                     + '           <HEADER left="'+(1200+((i+j)*100))+'" top="20" right="'+(1300+((i+j)*100))+'" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1200+((i+j)*100))+'" top="0" right="'+(1300+((i+j)*100))+'" bottom="20" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BFYY_PROF_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYSALECRATE'+i+'"  refcolid="BFYY_SALE_CRATE'+i+'">'
                     + '           <HEADER left="'+(1300+((i+j)*100))+'" top="20" right="'+(1400+((i+j)*100-20))+'" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1300+((i+j)*100))+'" top="0" right="'+(1400+((i+j)*100-20))+'" bottom="20" align="RightCenter" displayformat="#,###.00" borderstyle="Line" bordercolor="#dddddd" />'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BFYYPROFCRATE'+i+'"  refcolid="BFYY_PROF_CRATE'+i+'">'
                     + '           <HEADER left="'+(1400+((i+j)*100-20))+'" top="20" right="'+(1480+((i+j)*100-20))+'" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1400+((i+j)*100-20))+'" top="0" right="'+(1480+((i+j)*100-20))+'" bottom="20" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINNORMSAMT'+i+'"  refcolid="ORIGIN_NORM_SAMT'+i+'" >'
                     + '           <HEADER left="'+(900+((i+j)*100))+'" top="20" right="'+(1000+((i+j)*100))+'" bottom="40" text="정상매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(900+((i+j)*100))+'" top="20" right="'+(1000+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_NORM_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINEVTSAMT'+i+'"  refcolid="ORIGIN_EVT_SAMT'+i+'" >'
                     + '           <HEADER left="'+(1000+((i+j)*100))+'" top="20" right="'+(1100+((i+j)*100))+'" bottom="40" text="행사매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1000+((i+j)*100))+'" top="20" right="'+(1100+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_EVT_SAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINSALETAMT'+i+'"  refcolid="ORIGIN_SALE_TAMT'+i+'" >'
                     + '           <HEADER left="'+(1100+((i+j)*100))+'" top="20" right="'+(1200+((i+j)*100))+'" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1100+((i+j)*100))+'" top="20" right="'+(1200+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_SALE_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINPROFTAMT'+i+'"  refcolid="ORIGIN_PROF_TAMT'+i+'" >'
                     + '           <HEADER left="'+(1200+((i+j)*100))+'" top="20" right="'+(1300+((i+j)*100))+'" bottom="40" text="이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1200+((i+j)*100))+'" top="20" right="'+(1300+((i+j)*100))+'" bottom="40" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(ORIGIN_PROF_TAMT'+i+')"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="0" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINSALECRATE'+i+'"  refcolid="ORIGIN_SALE_CRATE'+i+'" >'
                     + '           <HEADER left="'+(1300+((i+j)*100))+'" top="20" right="'+(1400+((i+j)*100-20))+'" bottom="40" text="매출구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1300+((i+j)*100))+'" top="20" right="'+(1400+((i+j)*100-20))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINPROFCRATE'+i+'"  refcolid="ORIGIN_PROF_CRATE'+i+'" >'
                     + '           <HEADER left="'+(1400+((i+j)*100-20))+'" top="20" right="'+(1480+((i+j)*100-20))+'" bottom="40" text="이익구성비" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1400+((i+j)*100-20))+'" top="20" right="'+(1480+((i+j)*100-20))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINSALEIRATE'+i+'"  refcolid="ORIGIN_SALE_IRATE'+i+'">'
                     + '           <HEADER left="'+(1480+((i+j)*100-20))+'" top="20" right="'+(1560+((i+j)*100-30))+'" bottom="40" text="매출신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1480+((i+j)*100-20))+'" top="0" right="'+(1560+((i+j)*100-30))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="ORIGINPROFIRATE'+i+'"  refcolid="ORIGIN_PROF_IRATE'+i+'" >'
                     + '           <HEADER left="'+(1560+((i+j)*100-30))+'" top="20" right="'+(1630+((i+j)*100-30))+'" bottom="40" text="이익신장율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(1560+((i+j)*100-30))+'" top="0" right="'+(1630+((i+j)*100-30))+'" bottom="40" align="RightCenter" displayformat="#,###.00"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,###.00"/>' 
                     + '           <CHILD type="edit" inputtype="num" decimal="2" editable="false"/>' 
                     + '       </COLUMN>'
          j += 6;
        
    }
   
        hdrProperies +='     </COLUMNINFO>';
    initMGridStyle(GD_MASTER, "common", hdrProperies);
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
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
    var strPumbunCd     = EM_PUMBUN_CD.text;         //브랜드코드
    
    //Mgrid.LayoutInfo("ColumnInfo", "colid::<HEADER>::text") [ = sValue ]
    //alert(strPCCd+"    "+strTeamCd);
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear)
                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd);
    
    TR_MAIN.Action="/dps/psal109.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(strTeamCd == "%" && strPCCd == "%"){
        GD_MASTER.LayoutInfo("ColumnInfo", "CD::<HEADER>::text") = "파트코드"
        GD_MASTER.LayoutInfo("ColumnInfo", "NM::<HEADER>::text") = "파트명"
    }
    else{
    	if(strTeamCd != "%" && strPCCd == "%"){
            GD_MASTER.LayoutInfo("ColumnInfo", "CD::<HEADER>::text") = "PC코드"
            GD_MASTER.LayoutInfo("ColumnInfo", "NM::<HEADER>::text") = "PC명"
        }
    	else{
    		if(strTeamCd != "%" && strPCCd != "%"){
                GD_MASTER.LayoutInfo("ColumnInfo", "CD::<HEADER>::text") = "브랜드코드"
                GD_MASTER.LayoutInfo("ColumnInfo", "NM::<HEADER>::text") = "브랜드명"
            }
    	}
    }
    GD_MASTER.focus();
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
        //계획년도
        if (isNull(EM_PLAN_YEAR.text) ==true ) {
            showMessage(INFORMATION, OK, "USER-1003","목표년도"); 
            EM_PLAN_YEAR.focus();
            return false;
        }
        //계획년도 자릿수, 공백 체크
        if (EM_PLAN_YEAR.text.replace(" ","").length != 4 ) {
            showMessage(INFORMATION, OK, "USER-1027","목표년도","4");
            EM_PLAN_YEAR.focus();
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

<!-- 브랜드코드 변경시 -->   
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    EM_PUMBUN_NAME.Text = "";
    if(EM_PUMBUN_CD.text.length != 0){            
        var rtnMap = setRepPumbunNmWithoutToGridPop( "DS_O_PUMBUN_CD", this.Text, EM_PUMBUN_NAME.Text, 'N', '1');
        if (rtnMap != null){
        	EM_PUMBUN_CD.Text = rtnMap.get("PUMBUN_CD");
        	EM_PUMBUN_NAME.Text = rtnMap.get("PUMBUN_NAME");
        }else{
        	EM_PUMBUN_CD.Text = "";
        	EM_PUMBUN_NAME.Text = "";
        }
    }
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
<object id="DS_IO_DETAIL_ORG" classid=<%=Util.CLSID_DATASET%>></object>
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
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)-top) <= top) {
    	grd_height = top+300;    	
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
                  <th class="point">목표년도</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%> width=90
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  </td>
                  <th width="80">브랜드</th>
                  <td colspan="5"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
                      classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
                      align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                      src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                      onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"
                      align="absmiddle" /> <comment id="_NSID_"> <object
                      id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
                      align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
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
                     id=GD_MASTER width=100% height=483 classid=<%=Util.CLSID_MGRID%> tabindex=1>
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

</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>