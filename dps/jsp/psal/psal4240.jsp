<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.06.13
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4240.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 시간대별행사매출현황
 * 이    력 :2010.06.13 박종은
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
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');   
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_EVENT_DT_S,                      "YYYYMMDD",                READ);   //행사기간 시작일자
    EM_EVENT_DT_S.alignment = 1;

    initEmEdit(EM_EVENT_DT_E,                      "YYYYMMDD",                READ);   //행사기간 종료일자
    EM_EVENT_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_EVENT_DT_S.text =  varToMon+"01";

    EM_EVENT_DT_E.text =  varToday;
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //대비일자
    EM_SALE_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToMon+"01";

    EM_SALE_DT_E.text =  varToday;

    initEmEdit(EM_EVENT_CD   , "CODE^11^0",  PK);        //행사코드
    initEmEdit(EM_EVENT_NAME , "GEN^40"   ,  READ);      //행사명

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    

    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                  //점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
 	
    
    LC_STR_CD.BindColVal  = strcd;   
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
	orgFlagCheck(orgFlag);
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal424","DS_O_MASTER" );
    
}

function gridCreate1(){

    var hdrProperies = '<COLUMNINFO>'
                    
                     + '       <COLUMN id="PCCD" refcolid="CODE" index="1">'
                     + '           <HEADER left="0" top="0" right="150" bottom="20" text="조직코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="0" top="0" right="150" bottom="80" edit=""   bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="PCNAME"  refcolid="NAME" index="2">'
                     + '           <HEADER left="150" top="0" right="300" bottom="20" text="조직명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="150" top="0" right="300" bottom="80" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="GUBUNTOTAL"  refcolid="GUBUN_TOTAL" index="2">'
                     + '           <HEADER left="300" top="0" right="400" bottom="20" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="0" right="400" bottom="20" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'


                     + '       <COLUMN id="SALETOTAL"  refcolid="SALE_TOTAL" >'
                     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="0" right="500" bottom="20" borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" align="RightCenter" displayformat="#,##0" bordercolor="#dddddd" />'
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
                     + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" align="RightCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
        
          
        
    }
    
        hdrProperies +=
                       '       <COLUMN id="CUSTCNT"  refcolid="GUBUN_CUST_CNT" >'
                     + '           <HEADER left="300" top="0" right="400" bottom="20" text="구분"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="20" right="400" bottom="40" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
                
                     + '       <COLUMN id="CUSTCNTTOTAL"  refcolid="CUST_CNT_TOTAL" >'
                     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="20" right="500" bottom="40" borderstyle="Line"  align="RightCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])" displayformat="#,##0" bordercolor="#dddddd"/>'
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
                     + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="20" right="'+(500+((i+j-8)*100))+'" bottom="40"   align="RightCenter" displayformat="#,##0"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
        
        

    }

        hdrProperies +=
                       '       <COLUMN id="PROF"  refcolid="GUBUN_PROF" >'
                     + '           <HEADER left="300" top="0" right="400" bottom="20" text="구분"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="40" right="400" bottom="60" align="leftCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
                
                     + '       <COLUMN id="SALEPROFTOTAL"  refcolid="SALE_PROF_TOTAL" >'
                     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="40" right="500" bottom="60" borderstyle="Line"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
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
                     + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="40" right="'+(500+((i+j-8)*100))+'" bottom="60" align="RightCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
                
                
                
    }
    
    

        hdrProperies +=
                       '       <COLUMN id="GUBUNPROFRATE"  refcolid="GUBUN_PROF_RATE">'
                     + '           <HEADER left="300" top="0" right="400" bottom="20" text="구분"  bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="300" top="60" right="400" bottom="80" align="leftCenter" bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
                
                     + '       <COLUMN id="SALEPROFRATETOTAL"  refcolid="SALE_PROF_RATE_TOTAL" >'
                     + '           <HEADER fix="true" left="400" top="0" right="500" bottom="20" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="400" top="60" right="500" bottom="80" borderstyle="Line" bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  align="RightCenter" displayformat="#,##0" bordercolor="#dddddd"/>'
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
                       '       <COLUMN id="SALE_PROF_RATE'+i+'"  refcolid="SALEPROFRATE'+i+'">'
                     + '           <HEADER left="'+(400+((i+j-8)*100))+'" top="0" right="'+(500+((i+j-8)*100))+'" bottom="20" text="'+k+':00" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
                     + '           <VIEW left="'+(400+((i+j-8)*100))+'" top="60" right="'+(500+((i+j-8)*100))+'" bottom="80" align="RightCenter"  bgcolor="@DECODE(CODE,[],[#b9d9ea],[white])"  displayformat="#,##0"  borderstyle="Line" bordercolor="#dddddd"/>'
                     + '       </COLUMN>'
    
    

    }


        hdrProperies +='     </COLUMNINFO>';
        
    
    initMGridStyle(GD_MASTER, "common", hdrProperies);
    GD_MASTER.EnableDblClkAtNotEditable = true;
    
}

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
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strEventCd      = EM_EVENT_CD.text;          //행사코드
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strEventCd="         +encodeURIComponent(strEventCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal424.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    if(strTeamCd != "%" && strPCCd != "%" && strDeptCd != "%"){
    	GD_MASTER.LayoutInfo("ColumnInfo", "PCCD::<HEADER>::text")   = "브랜드코드"
        GD_MASTER.LayoutInfo("ColumnInfo", "PCNAME::<HEADER>::text") = "브랜드명"
    }
    else{
    	GD_MASTER.LayoutInfo("ColumnInfo", "PCCD::<HEADER>::text")   = "조직코드"
        GD_MASTER.LayoutInfo("ColumnInfo", "PCNAME::<HEADER>::text") = "조직명"
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

    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "시간대별행사매출현황";

    var parameters = "단위: 천원, 명";

    
    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strEventCd      = EM_EVENT_NAME.text;        //행사명
    var strSaleDtS      = EM_SALE_DT_S.text;         //매출일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //대비일자
    
    var parameters = "점 "                   + strStrCd
                   + ",   팀 "             + strDeptCd
                   + ",   파트 "               + strTeamCd
                   + ",   PC "              + strPCCd
                   + ",   행사명 "           + strEventCd
                   + ",   조회기간 "          + strSaleDtS + "~" + strSaleDtE
                   + ",   단위: 천원, 명, %";
    
    //openExcelM(GD_MASTER, strTitle, parameters, true );
    openExcelM2(GD_MASTER, strTitle, parameters, true ,g_strPid );

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

        if( EM_EVENT_CD.Text == ""){
            // (행사코드)은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003", "행사코드");
            EM_EVENT_CD.Focus();
            return;
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
        
        
        if(EM_SALE_DT_S.text > EM_SALE_DT_E.text) {
        	showMessage(Information, OK, "USER-1021","시작일자","종료일자");
            EM_SALE_DT_S.text = varToMon+"01";
            EM_SALE_DT_S.Focus();
            return false;
        }
        
        break;
   
    }
    return true;
}


/**
 * eventDt()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  행사기간조회
 * return값 : void
 */
function eventDt(){
    var strEventCd = EM_EVENT_CD.Text;          //행사코드
    
    var goTo       = "searchEventDt" ;    
    var action     = "O";     
    var parameters = "&strEventCd="         +encodeURIComponent(strEventCd);
    
    TR_DETAIL.Action="/dps/psal424.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_EVENTDT=DS_O_EVENTDT)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_EVENTDT.CountRow > 0){
        EM_EVENT_DT_S.TEXT = DS_O_EVENTDT.NameValue(1,"EVENT_S_DT");
        EM_EVENT_DT_E.TEXT = DS_O_EVENTDT.NameValue(1,"EVENT_E_DT");
    }
 }

/**
 * setEventCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사을 등록한다.
 * return값 : void
 */
function setEventCode(evnflag){
    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;
    var strCd = LC_STR_CD.BindColVal;

    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        bfEventCd = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        eventPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1,LC_STR_CD.BindColVal,'','','');
    }    

    if(EM_EVENT_CD.Text.length == 11){
        eventDt();
    }
    bfEventCd = codeObj.Text;
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
    var varToMon = now.getYear().toString()+ mon;
</script>
<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_ORG_FLAG event=OnSelChange()>
	if(EM_ORG_FLAG.CodeValue=="1"){
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
		getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal=strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		var strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
	     
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0;
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


<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME');
    
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

<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }

</script>

<!-- 매출종료일 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","종료일자"); 
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","종료일자","8");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","종료일자");
        EM_SALE_DT_E.text = varToday;
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

<comment id="_NSID_">
<object id="DS_O_EVENTDT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%=Util.CLSID_DATASET%>></object>
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
                  <th width="70">조직구분</th>
                  <td width="105" colspan="7" >
                    <comment id="_NSID_">
                    <object id="EM_ORG_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:95">
                    <param name=Cols    value="2">
                    <param name=Format  value="1^매장,2^매입">  
                    <param name=CodeValue  value="<%=sessionInfo.getORG_FLAG()%>">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>
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
                  <th class="point">행사코드</th>
                  <td colspan="3">
                      <comment id="_NSID_">
                      <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP');"  align="absmiddle" />
                      <comment id="_NSID_">
                      <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=109 tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                  </td>
                  <th class="point">행사기간</th>
                  <td colspan="3"><comment id="_NSID_"> <object
                     id=EM_EVENT_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  ~
                     <comment id="_NSID_"> <object
                     id=EM_EVENT_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  
                  </td>
               
               </tr>
               <tr>
                  <th class="point">매출기간</th>
                  <td colspan="3"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                  ~
                     <comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('G',EM_SALE_DT_E); " align="absmiddle" />
                  </td>
                  <th>단위</th>
                  <td colspan="3"> 천원, 명, %
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
                     id=GD_MASTER width=100% height=730 classid=<%=Util.CLSID_MGRID%> tabindex=1>
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
