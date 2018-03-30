<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.04.18
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal3050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 시간대별매출속보현황(분류별)
 * 이    력 :2010.04.18 박종은
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
 var top = 200;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');   
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //매출일자1-2
    EM_SALE_DT_E.alignment = 1;
    
    initEmEdit(EM_CMPR_DT_E1,                      "YYYYMMDD",                PK);   //대비일자1-2(2011.08.27 MARIO OUTLET)
    EM_CMPR_DT_E1.alignment = 1;   
    
    initEmEdit(EM_CMPR_DT_S1,                      "YYYYMMDD",                PK);   //대비일자1-1(2011.08.27 MARIO OUTLET)
    EM_CMPR_DT_S1.alignment = 1;
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    
    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;
    EM_SALE_DT_E.text =  varToday;
    
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
    
    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                  //점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC    
    
    
    initComboStyle(LC_O_L_CD,DS_O_L_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //대분류
    //대분류 가지고 오기(popup_dps.js)
    getPmkLCode("DS_O_L_CD" , "Y"); 
    initComboStyle(LC_O_M_CD,DS_O_M_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //중분류
    initComboStyle(LC_O_S_CD,DS_O_S_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //소분류
    initComboStyle(LC_O_D_CD,DS_O_D_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //세분류
    //콤보데이터 기본값 설정( gauce.js )

    //setComboData(LC_O_L_CD,"%");    
   
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    LC_O_L_CD.Index  = 0;
    
    
 	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
 	
 	
    orgFlagCheck(orgFlag);
    var strCmprdt = searchCmpr();
    
    checkStrCmpr();
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal305","DS_O_MASTER" );
    
}

function gridCreate1(){

    var hdrProperies = '<COLUMNINFO>'
        
        + '       <COLUMN id="PCCD" refcolid="CODE" index="1">'
        + '           <HEADER left="0" top="0" right="100" bottom="20" text="점명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="0" top="0" right="100" bottom="240" edit=""  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
       
        + '       <COLUMN id="PCNAME"  refcolid="NAME" index="2">'
        + '           <HEADER left="100" top="0" right="200" bottom="20" text="분류명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="100" top="0" right="200" bottom="240" align="leftCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"    borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'

        + '       <COLUMN id="GBN" >'
        + '           <HEADER left="200" top="0" right="300" bottom="20" text="구" align="RightCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'

        + '       <COLUMN id="GBN" >'
        + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'

        + '       <COLUMN id="SALEDT"  refcolid="SALE_DT" index="2">'
        + '           <HEADER left="200" top="0" right="300" bottom="20" text="구" align="RightCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="200" top="0" right="300" bottom="100" align="leftCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'

        + '       <COLUMN id="GUBUNTOTAL"  refcolid="GUBUN_TOTAL" index="2">'//매출일-매출
        + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="300" top="0" right="400" bottom="20" align="leftCenter"   bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'


        + '       <COLUMN id="SALETOTAL"  refcolid="SALE_TOTAL" >'
        + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW              left="400" top="0" right="500" bottom="20" text="@(SALE_TOTAL)"  borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd" />'
        + '       </COLUMN>'
var j = 0;
var k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}
hdrProperies +=  
          '       <COLUMN id="SALE'+i+'"  refcolid="SALE'+i+'">'
        + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" text="@(SALE'+i+')" bottom="20" align="RightCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'



}


hdrProperies +=
'       <COLUMN id="GUBUNSALEIRATE"  refcolid="GUBUN_SALEIRATE" >' //
+ '           <HEADER left="300" top="0"  right="400"  bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW      left="300" top="20" right="400"  bottom="40" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'

+ '       <COLUMN id="SALEIRATETOTAL"  refcolid="SALEIRATE_TOTAL" >'
+ '           <HEADER fix="true" left="400" top="0"  right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW                 left="400" top="20" right="500" bottom="40" text="@(SALEIRATE_TOTAL)"  borderstyle="Line" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
+ '       </COLUMN>'
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
'       <COLUMN id="SALE_IRATE'+i+'"  refcolid="SALEIRATE'+i+'">'
+ '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0"  right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW      left="'+(400+((i+j-8)*100))+'" top="20" right="'+(500+((i+j-8)*100))+'" bottom="40" text="@(SALEIRATE'+i+')"  align="RightCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'



}




hdrProperies +=
	       '       <COLUMN id="PROF"  refcolid="GUBUN_PROF" >'//매출-이익
	     + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="300" top="40" right="400" bottom="60" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="SALEPROFTOTAL"  refcolid="SALE_PROF_TOTAL" >'
	     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="400" top="40" right="500" bottom="60" text="@(SALE_PROF_TOTAL)"  borderstyle="Line" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
		       '       <COLUMN id="SALE_PROF'+i+'"  refcolid="SALEPROF'+i+'">'
		     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="40" right="'+(500+((i+j-8)*100))+'" bottom="60" text="@(SALEPROF'+i+')"  align="RightCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	
	
}

hdrProperies +=
	       '       <COLUMN id="CUSTCNT"  refcolid="GUBUN_CUST_CNT" index="2">'//매출일-구매객수
	     + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="300" top="60" right="400" bottom="80" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="CUSTCNTTOTAL"  refcolid="CUST_CNT_TOTAL" >'
	     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="400" top="60" right="500" bottom="80" borderstyle="Line"  align="RightCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  displayformat="#,##0" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
	       '       <COLUMN id="CUST_CNT'+i+'"  refcolid="CUSTCNT'+i+'">'
	     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="60" right="'+(500+((i+j-8)*100))+'" bottom="80" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'



}



// 객단가     
hdrProperies +=
          '       <COLUMN id="GUBUNCUSTDANGA"  refcolid="GUBUN_CUST_DANGA" index="2">'//매출일-객단가
        + '           <HEADER left="300" top="0"  right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="300" top="80" right="400" bottom="100" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
   
        + '       <COLUMN id="CUSTDANGATOTAL"  refcolid="CUST_DANGA_TOTAL" >'
        + '           <HEADER fix="true" left="400" top="0"  right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW              left="400" top="80" right="500" bottom="100" text="@(CUST_DANGA_TOTAL)"  borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,###.0" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
                
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
          '       <COLUMN id="CUST_DANGA'+i+'"  refcolid="CUSTDANGA'+i+'">'
        + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0"  right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="'+(400+((i+j-8)*100))+'" top="80" right="'+(500+((i+j-8)*100))+'" text="@(CUSTDANGA'+i+')" bottom="100" align="RightCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  displayformat="#,###.0"  borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'



}



hdrProperies +=
'       <COLUMN id="GUBUNACCSALE"  refcolid="GUBUN_ACC_SALE" index="2">'//
+ '           <HEADER left="200" top="0"  right="400" bottom="20" text="구" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW   left="200" top="100" right="400" bottom="120" align="CenterCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'

+ '       <COLUMN id="ACCSALETOTAL"  refcolid="ACC_SALE_TOTAL" >'
+ '           <HEADER fix="true" left="400" top="0"  right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW              left="400" top="100" right="500" bottom="120" text="@(ACC_SALE_TOTAL)"  borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,###.0" bordercolor="#dddddd"/>'
+ '       </COLUMN>'
 
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
'       <COLUMN id="ACC_SALE'+i+'"  refcolid="ACCSALE'+i+'">'
+ '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0"  right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW   left="'+(400+((i+j-8)*100))+'" top="100" right="'+(500+((i+j-8)*100))+'" text="@(ACC_SALE'+i+')" bottom="120" align="RightCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  displayformat="#,###.0"  borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'



}



hdrProperies +=
'       <COLUMN id="GUBUNACCSALE1"  refcolid="GUBUN_ACC_SALE_1" index="2">'//
+ '           <HEADER left="200" top="0"  right="400" bottom="20" text="구" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW   left="200" top="120" right="400" bottom="140" align="CenterCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"   borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'

+ '       <COLUMN id="ACCCMPRSALETOTAL"  refcolid="ACC_CMPRSALE_TOTAL" >'
+ '           <HEADER fix="true" left="400" top="0"  right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW              left="400" top="120" right="500" bottom="140" text="@(ACC_CMPRSALE_TOTAL)"  borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  align="RightCenter" displayformat="#,###.0" bordercolor="#dddddd"/>'
+ '       </COLUMN>'

j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
'       <COLUMN id="ACC_SALEIRATE'+i+'"  refcolid="ACCSALEIRATE'+i+'">'
+ '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0"  right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW   left="'+(400+((i+j-8)*100))+'" top="120" right="'+(500+((i+j-8)*100))+'" text="@(ACC_SALEIRATE'+i+')" bottom="140" align="RightCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[#FFFFE0])"  displayformat="#,###.0"  borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'



}






hdrProperies += 
	       '       <COLUMN id="CMPRDT"  refcolid="CMPR_DT" index="2">'
	     + '           <VIEW left="200" top="140" right="300" bottom="220" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"   borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="GUBUNTOTALCMPR"  refcolid="GUBUN_TOTAL_CMPR" index="2">'//대비일-매출
	     + '           <HEADER left="300" top="0"  right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW   left="300" top="140" right="400" bottom="160" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"   borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="SALETOTALCMPR"  refcolid="SALE_TOTAL_CMPR" >'
	     + '           <HEADER fix="true" left="400" top="0"  right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW              left="400" top="140" right="500" bottom="160" text="@(SALE_TOTAL_CMPR)"  borderstyle="Line"   bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies +=
	       '       <COLUMN id="CMPRSALE'+i+'"  refcolid="CMPRSALE'+i+'">'
	     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="140" right="'+(500+((i+j-8)*100))+'" text="@(CMPRSALE'+i+')" bottom="160"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'



}
hdrProperies +=
	       '       <COLUMN id="PROFCMPR"  refcolid="GUBUN_PROF_CMPR" index="2">'//대비일-이익
	     + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="300" top="160" right="400" bottom="180" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"   borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="SALEPROFTOTALCMPR"  refcolid="SALE_PROF_TOTAL_CMPR" >'
	     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="400" top="160" right="500" bottom="180" text="@(SALE_PROF_TOTAL_CMPR)" borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
	       '       <COLUMN id="CMPRSALE_PROF'+i+'"  refcolid="CMPRSALEPROF'+i+'">'
	     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="160" right="'+(500+((i+j-8)*100))+'" text="@(CMPRSALEPROF'+i+')"  bottom="180"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'



}


hdrProperies +=
	       '       <COLUMN id="CUSTCNTCMPR"  refcolid="GUBUN_CUST_CNT_CMPR" index="2">'//대비일-구매객수
	     + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="300" top="180" right="400" bottom="200" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"   borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="CUSTCNTTOTALCMPR"  refcolid="CUST_CNT_TOTAL_CMPR" >'
	     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="400" top="180" right="500" bottom="200" borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
j = 0;
k = "";

for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
	       '       <COLUMN id="CMPRCUST_CNT'+i+'"  refcolid="CMPRCUSTCNT'+i+'">'
	     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="180" right="'+(500+((i+j-8)*100))+'" bottom="200"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" align="RightCenter" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'



}


//객단가       
hdrProperies +=
	       '       <COLUMN id="GUBUNCUSTDANGACMPR"  refcolid="GUBUN_CUST_DANGA_CMPR" index="2">'//대비일-객단가
	     + '           <HEADER left="300" top="0" right="400" bottom="20" text="분" align="leftCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="300" top="200" right="400" bottom="220" align="leftCenter"   bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	
	     + '       <COLUMN id="CUSTDANGATOTALCMPR"  refcolid="CUST_DANGA_TOTAL_CMPR" >'
	     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="400" top="200" right="500" bottom="220" text="@(CUST_DANGA_TOTAL_CMPR)"  borderstyle="Line" bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  align="RightCenter" displayformat="#,###.0"  bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
		     
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
	       '       <COLUMN id="CUST_DANGA_CMPR'+i+'"  refcolid="CMPRCUSTDANGA'+i+'">'
	     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="200" right="'+(500+((i+j-8)*100))+'" bottom="220"  text="@(CMPRCUSTDANGA'+i+')"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" align="RightCenter" displayformat="#,###.0"  borderstyle="Line" bordercolor="#dddddd"/>'
	     + '       </COLUMN>'
	


}


hdrProperies +=
'       <COLUMN id="GUBUNACCCMPRSALE"  refcolid="GUBUN_ACC_CMPRSALE" index="2">'//
+ '           <HEADER left="200" top="0"  right="400" bottom="20" text="구분" align="CenterCenter"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW   left="200" top="220" right="400" bottom="240" align="CenterCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'

+ '       <COLUMN id="ACCCMPRSALETOTAL"  refcolid="ACC_CMPRSALE_TOTAL" >'
+ '           <HEADER fix="true" left="400" top="0"  right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW              left="400" top="220" right="500" bottom="240" text="@(ACC_CMPRSALE_TOTAL)"  borderstyle="Line"   bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'
 
j = 0;
k = "";
for(i=9;i<= 23; i++){
if(i == 9){
k = "09";
}
else{
k = i;
}

hdrProperies += 
'       <COLUMN id="ACC_CMPRSALE'+i+'"  refcolid="ACCCMPRSALE'+i+'">'
+ '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0"  right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
+ '           <VIEW   left="'+(400+((i+j-8)*100))+'" top="220" right="'+(500+((i+j-8)*100))+'" text="@(ACC_CMPRSALE'+i+')" bottom="240" align="RightCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
+ '       </COLUMN>'



}



        hdrProperies +='     </COLUMNINFO>';
        
    
    initMGridStyle(GD_MASTER, "common", hdrProperies);
    GD_MASTER.EnableDblClkAtNotEditable = true;
    //GD_MASTER.ViewSummary = 1;
    //GD_MASTER.DecRealData = true;
    
}
function checkStrCmpr(){
	if(EM_CMPR_FLAG.CodeValue=="1"){
			
		 EM_CMPR_DT_S1.Enable = "false";
		 EM_CMPR_DT_E1.Enable = "false";
	}else if(EM_CMPR_FLAG.CodeValue=="2"){
		
		 EM_CMPR_DT_S1.Enable = "true";
		 EM_CMPR_DT_E1.Enable = "true";
	}
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
    var strSaleDtS      = EM_SALE_DT_S.text;         //매출일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //대비일자
    var strPummokL      = LC_O_L_CD.BindColVal;      //대분류
    var strPummokM      = LC_O_M_CD.BindColVal;      //중분류
    var strPummokS      = LC_O_S_CD.BindColVal;      //소분류
    var strPummokD      = LC_O_D_CD.BindColVal;      //세분류
//    var strCuLv         = LC_CU_LV.BindVal;         //금액단위 
    var strCuLv         = "0";         //금액단위 (0:원단위, 1:천원단위)
    var strCmprDtS1     = EM_CMPR_DT_S1.text;        //대비일자 1-1
    var strCmprDtE1     = EM_CMPR_DT_E1.text;        //대비일자 1-2
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strCmprFlag     = EM_CMPR_FLAG.CodeValue;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strPummokL="         +encodeURIComponent(strPummokL)
                   + "&strPummokM="         +encodeURIComponent(strPummokM)
                   + "&strPummokS="         +encodeURIComponent(strPummokS)
                   + "&strPummokD="         +encodeURIComponent(strPummokD)
                   + "&strCuLv="            +encodeURIComponent(strCuLv)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)     //조직구분 코드
                   + "&strCmprFlag="        +encodeURIComponent(strCmprFlag)     //대비구분
                   + "&strCmprDtS1="        +encodeURIComponent(strCmprDtS1)     //대비일자 1-1
                   + "&strCmprDtE1="	    +encodeURIComponent(strCmprDtE1)     //대비일자 1-2
                   ;
    
    TR_MAIN.Action="/dps/psal305.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    
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

    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "시간대별매출속보현황(분류별)";

    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //매출일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //대비일자
    var strPummokL      = LC_O_L_CD.Text;      //대분류
    var strPummokM      = LC_O_M_CD.Text;      //중분류
    var strPummokS      = LC_O_S_CD.Text;      //소분류
    
    //var parameters = "단위: 원, 명";
    var parameters = "점 "                + strStrCd
                   + ",   팀 "          + strDeptCd
                   + ",   파트 "            + strTeamCd
                   + ",   PC "           + strPCCd
                   + ",   매출일자 "       + strSaleDtS
                   + ",   대비일자 "       + strSaleDtE
                   + ",   대분류 "         + strPummokL
                   + ",   중분류 "         + strPummokM
                   + ",   소분류 "         + strPummokS
                   + ",   단위: 원, 명";
    
    openExcelM(GD_MASTER, strTitle, parameters, true );
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
            showMessage(Information, OK, "USER-1003","매출일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","대비일자"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","대비일자","8");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_E.text)){
            showMessage(Information, OK, "USER-1004","대비일자");
            EM_SALE_DT_E.focus();
            return false;
        }
        break;
   
    }
    return true;
}

/**
 * searchCmpr()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchCmpr(){

    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strSaleDtS      = EM_SALE_DT_S.text;         //매출일자
    
    var goTo       = "searchCmprdt" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS);
    
    TR_DETAIL.Action="/dps/psal305.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_CMPRDT=DS_O_CMPRDT)"; //조회는 O
    TR_DETAIL.Post();
    
    EM_CMPR_DT_S1.text = DS_O_CMPRDT.NameValue(0,"CMPR_DT");
    EM_CMPR_DT_E1.text = DS_O_CMPRDT.NameValue(0,"CMPR_DT");
}
function searchCmpr2(strStrCd,strSaleDtS){

    var goTo       = "searchCmprdt" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS);
    
    TR_DETAIL.Action="/dps/psal305.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_CMPRDT=DS_O_CMPRDT)"; //조회는 O
    TR_DETAIL.Post();
    
    return DS_O_CMPRDT.NameValue(1,"CMPR_DT");
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


<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
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
<script language="javascript">
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

</script>
<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_ORG_FLAG event=OnSelChange()>
	if(EM_ORG_FLAG.CodeValue=="1"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
		getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	    
	   
		
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;		
	    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
	    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0;
	    
	   
	}
</script>

<!-- 대비 구분  변경시  -->
<script language=JavaScript for=EM_CMPR_FLAG event=OnSelChange()>
	 if(EM_CMPR_FLAG.CodeValue=="1"){
		 var strStrCd        = LC_STR_CD.BindColVal;      //점
		 var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
		 var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
		 strCmprDt=searchCmpr2(strStrCd,strSaleDtS);
		 EM_CMPR_DT_S1.text=strCmprDt;
		 strCmprDt=searchCmpr2(strStrCd,strSaleDtE);
		 EM_CMPR_DT_E1.text=strCmprDt; 
		
	}else if(EM_CMPR_FLAG.CodeValue=="2"){
		var strStrCd        = LC_STR_CD.BindColVal;      //점
		var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
		var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
	   
	    
	    /* strCmprDt=searchCmpr2(strStrCd,strSaleDtS);
	    EM_CMPR_DT_S1.text=strCmprDt;
	    strCmprDt=searchCmpr2(strStrCd,strSaleDtE);
	    EM_CMPR_DT_E1.text=strCmprDt; */
	    
	    EM_CMPR_DT_S1.Text= addDate('D',-7, EM_SALE_DT_S.text);
		EM_CMPR_DT_E1.Text= addDate('D',-7, EM_SALE_DT_S.text); 
}
	 checkStrCmpr(); 
    
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
	
	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                // 팀 
	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
	
    if(LC_DEPT_CD.BindColVal != "%"){
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
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
	
    if(LC_TEAM_CD.BindColVal != "%"){
    	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>
if(!this.Modified)
	return;
	
var strStrCd        = LC_STR_CD.BindColVal;      //점
var strSaleDt       = EM_SALE_DT_S.Text;
if(EM_CMPR_FLAG.CodeValue=="2"){
	 return false;
}else{

var strCmprdt=searchCmpr2(strStrCd,strSaleDt);
EM_CMPR_DT_S1.text = strCmprdt;
}
    //영업조회월
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출일자"); 
        EM_SALE_DT_S.text = varToday;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","매출일자","8");
        EM_SALE_DT_S.text = varToday;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","매출일자");
        EM_SALE_DT_S.text = varToday;
        return ;
    }

    //EM_SALE_DT_E.text =  addDate('D',-364, EM_SALE_DT_S.text);    // 2011.08.27 MARIO OUTLET
    /*
    var strCmprdt = searchCmpr();
    
    if(strCmprdt == ""){
        EM_SALE_DT_E.text =  addDate('Y',-1, EM_SALE_DT_S.text);
    }
    else{
        EM_SALE_DT_E.text =  strCmprdt;
    }
    */
</script>

<script language=JavaScript for=LC_O_L_CD event=OnSelChange>
    DS_O_M_CD.ClearData();
    DS_O_S_CD.ClearData();
    getPmkMCode("DS_O_M_CD", LC_O_L_CD.BindColVal , "N" );     
        
    // 기본값 입력( gauce.js )
    insComboData( LC_O_M_CD, "%", "전체", 1 );    
    setComboData(LC_O_M_CD,"%");
</script>

<script language=JavaScript for=LC_O_M_CD event=OnSelChange>   
    DS_O_S_CD.ClearData();       
    getPmkSCode("DS_O_S_CD", LC_O_L_CD.BindColVal , LC_O_M_CD.BindColVal , "N" );    
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_S_CD, "%", "전체", 1 );    
    setComboData(LC_O_S_CD,"%");          
</script>

<script language=JavaScript for=LC_O_S_CD event=OnSelChange>   
    DS_O_D_CD.ClearData();       
    getPmkDCode("DS_O_D_CD", LC_O_L_CD.BindColVal , LC_O_M_CD.BindColVal , LC_O_S_CD.BindColVal, "N" );    
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_D_CD, "%", "전체", 1 );    
    setComboData(LC_O_D_CD,"%");          
</script>

<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>
if(!this.Modified)
	return;
var strStrCd        = LC_STR_CD.BindColVal;      //점
var strSaleDt       = EM_SALE_DT_S.Text;
if(EM_CMPR_FLAG.CodeValue=="2"){
	 return false;
}else{

var strCmprdt=searchCmpr2(strStrCd,strSaleDt);
EM_CMPR_DT_S1.text = strCmprdt;
}
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>
if(!this.Modified)
	return;
var strStrCd        = LC_STR_CD.BindColVal;      //점
var strSaleDt       = EM_SALE_DT_E.Text;
if(EM_CMPR_FLAG.CodeValue=="2"){
	 return false;
}else{

var strCmprdt=searchCmpr2(strStrCd,strSaleDt);
EM_CMPR_DT_E1.text = strCmprdt;
}
/*
    //영업조회월
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","대비일자"); 
        EM_SALE_DT_E.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","대비일자","8");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","대비일자");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
*/    
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
<comment id="_NSID_">
<object id="DS_O_L_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_M_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_S_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_D_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>

<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_CMPRDT" classid=<%=Util.CLSID_DATASET%>></object>
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
               <th width="70">조직구분</th>
                  <td width="105" >
                    <comment id="_NSID_">
                    <object id="EM_ORG_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:95">
                    <param name=Cols    value="2">
                   
                    <param name=Format  value="1^매장,2^매입">                   
                   
                    <param name=CodeValue  value="<%=sessionInfo.getORG_FLAG()%>">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>
                  <th width="70">대비구분</th>
                  <td width="150" >
                    <comment id="_NSID_">
                    <object id="EM_CMPR_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:150">
                    <param name=Cols    value="2">
                    <param name=Format  value="1^전년대비,2^전주대비">
                    <param name=CodeValue  value="1">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>  
               	  <th>단위</th>
                  <td >원, 명
               </tr>
               <tr>
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">매출일자</th>
                  <td colspan="3"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />~
                     <comment id="_NSID_"> <object
                     id="EM_SALE_DT_E" classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_E)" align="absmiddle" />
                  </td>
                  <th class="point">대비일자</th> <!-- 대비일자1 -->
                  <td colspan="3">
                     <comment id="_NSID_"> <object
                     id=EM_CMPR_DT_S1 classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_CMPR_DT_S1.Enable) openCal('G',EM_CMPR_DT_S1); " align="absmiddle" />~
                      
                     <comment id="_NSID_"> <object
                     id="EM_CMPR_DT_E1" classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_CMPR_DT_E1.Enable) openCal('G',EM_CMPR_DT_E1); " align="absmiddle" />
                  </td>
                  
               </tr>
               <tr>
                   <th>대분류</th>
                   <td><comment id="_NSID_"> <object id=LC_O_L_CD
                       classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=95
                       tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                   <th>중분류</th>
                   <td><comment id="_NSID_"> <object id=LC_O_M_CD
                       classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=95
                       tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                   <th>소분류</th>
                   <td><comment id="_NSID_"> <object id=LC_O_S_CD
                       classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=95
                       tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                   
                   </td>
                   <th>세분류</th>
                   <td><comment id="_NSID_"> <object id=LC_O_D_CD
                       classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=95
                       tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                   
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
                     id=GD_MASTER width=100% height=430 classid=<%=Util.CLSID_MGRID%> tabindex=1>
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
