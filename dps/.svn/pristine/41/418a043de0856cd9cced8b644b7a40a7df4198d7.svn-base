<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출실적 > 매출카렌다
 * 작 성 일 : 2010.05.02
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출카렌다
 * 이    력 :2010.05.02 박종은
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
 var top = 150;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("calandal"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    
   
    
    // EMedit에 초기화
    
    initEmEdit(EM_EXE_YM_S,                      "YYYYMM",                PK);   //년월
    EM_EXE_YM_S.alignment = 1;

    //현재년도 셋팅
    EM_EXE_YM_S.text = varToMon;
    
    initEmEdit(EM_EXE_YM_E,                      "YYYYMM",                PK);   //년월
    
    //그리드 초기화
    //gridCreate1(); //마스터
    
    EM_EXE_YM_E.alignment = 1;

    //현재년도 셋팅
    EM_EXE_YM_E.text =  varToMon;
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';
   
    getStore("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                  //점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N", "", strOrgFlag);                                // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC    
    
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />'; 	
 	
    orgFlagCheck(orgFlag);
    
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal408","DS_O_MASTER" );
    //getCalandal();      //달력 
}

function gridCreate1(){

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
	 //gridCreate1();
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    getCalandal();
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


function callDetailPop(){
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strExeYmS       = EM_EXE_YM_S.text;         //시작년월
    var strExeYmE       = EM_EXE_YM_E.text;         //종료년월
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strExeYmS="          +encodeURIComponent(strExeYmS)
                   + "&strExeYmE="          +encodeURIComponent(strExeYmE);
    
    TR_MAIN.Action="/dps/psal408.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();


    
}

	function getCalandal(){
	    
		callDetailPop();
		
		var strDate  = EM_EXE_YM_S.text+"01";
	    var Lday = new Date(strDate.substr(0,4), strDate.substr(4,2), 0);
	    var lastday  = Lday.getDate();
	    
	    var year = strDate.substr(0,4);
	    var month = strDate.substr(4,2);
	    
	    var firstday = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, strDate.substr(6,2));
	    var firstdayweek = firstday.getDay();//0:일 ~6:토
	    var strWeekNum = firstdayweek+1;//1:일 ~7:토
	    var strWeek = "";
	    
	    var lastDay2 = new Date(strDate.substr(0,4), strDate.substr(4,2)-1, lastday);
        var lastDay2week = lastDay2.getDay();//0:일 ~6:토
        var strlastDay2 = lastDay2week+1;//1:일 ~7:토
        
     
	    var tempRow;
	    count = 0;
	    line = 1;
	    
	    var h=1;
	    
	    var strSaleTamt  = 0;
        var strCustCntT  = 0;
        var strProfTamt  = 0;
        var strCmprTamt  = 0;
        var strCustDanga = 0;
        var strIRate     = 0;
        var strAct       = 0;//계획,목표
        var strAchieve   = 0;//달성율
        var strCmprAct   = 0;//대비목표
        var strCmprAchieve=0;//대비 달성율
        
	    

	    var content = "";
	    content += "<table width='100%' height='100%' cellpadding=0 cellspacing=0 style='border-collapse:collapse; empty-cells:show; ' >";
	    content += "<tr>";
	    content += "<td COLSPAN=7 class='d_date' width='100%'  align='center'>";
	    content += "<table width='100%' align='center'>";
	    content += "<td>";
	    
	    content += "</tr>";
	    content += "<tr><td class='d_com' width='80px' >구분</td><td class='d_red'  width='90px'>SUN(일)</td><td class='d_com' width='90px'>MON(월)</td><td class='d_com' width='90px'>TUE(화)</td><td class='d_com' width='90px'>WED(수)</td><td class='d_com' width='90px'>THU(목)</td><td class='d_com' width='90px'>FRI(금)</td><td class='d_blue' width='90px'>SAT(토)</td><td class='d_com'  >주간/전체합계</td></tr>";
	    content += "<tr align=center>";
        content += "<td class='d_comh' >일자<br>매출<br>계획<br>달성율<br>객수<br>객단가<br>이익<br>신장율<br>대비매출<br>대비목표<br>대비달성율&nbsp;<br></a></td>";
	    
	    for( i = 0; i < firstdayweek; i++ ){
	    	
	    content += "<td class='d_day'>&nbsp;</td>";   
	       line++; 
	       
	    }
	    	    
	    for(j = 1; j <= lastday; j++ ){
	    	
	        if( line == 8 ){
	        	
	        	strSaleTamt  = comma(strSaleTamt);
	        	strAct       = comma(strAct);
	        	//strAchieve   = comma(strAchieve);
	        	strCustCntT  = comma(strCustCntT);
	        	strProfTamt  = comma(strProfTamt);
	        	strCmprTamt  = comma(strCmprTamt);
	        	strCustDanga = comma(strCustDanga);
	        	//strCmprAct   = comma(strCmprAct);
	        	//alert(strCmprAchieve);
	        	
	        	content += "<td id='td"+j+"' class='d_num' ><div align=left>&nbsp;</div><br><span class='red'  >"+strSaleTamt+"<br>"+strAct+"<br>"+strAchieve+"<br>"+strCustCntT+"<br>"+strCustDanga+"<br>"+strProfTamt+"<br>"+strIRate+"<br>"+strCmprTamt+"<br>"+strCmprAct+"<br>"+strCmprAchieve+"</sapn></a></td>";
	            content += "</tr><tr align=center>";
	            content += "<td class='d_comh' >일자<br>매출<br>계획<br>달성율<br>객수<br>객단가<br>이익<br>신장율<br>대비매출<br>대비목표<br>대비달성율&nbsp;<br></a></td>";  
                strSaleTamt  = 0;
                strAct       = 0;//계획
                strAchieve   = 0;
                strCustCntT  = 0;
                strProfTamt  = 0;
                strCmprTamt  = 0;
                strCustDanga = 0;
                strIRate     = 0;
                strCmprAct   = 0;
                strCmprAchieve=0;
	            line = 1;
	        }
	           
	        if(DS_O_MASTER.CountRow < 1 ){
	        	   content += "<td id='td"+j+"' class='d_num' ><div align=left>"+j+"</div><br><span class='red'  >"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"</sapn></a></td>";
            }else {
	            for(k = h; k <= DS_O_MASTER.CountRow; k++ ){
	               
	                if( DS_O_MASTER.NameValue(k, "DAYS") == j ){
	                    tempRow = k;
	                    break;
	                }else {
	                    tempRow = 0;
	                }
	            }
	            
	            strSaleTamt += parseInt(replaceStr(DS_O_MASTER.NameValue(1, "DAY"+j),",",""));//날짜 1~31일까지 0
	            strAct      += parseInt(replaceStr(DS_O_MASTER.NameValue(1, "ACT_DAY"+j),",",""));
	            
	            strCustCntT += parseInt(replaceStr(DS_O_MASTER.NameValue(1, "DAYCUSTCNT"+j),",",""));
	            strProfTamt += parseInt(replaceStr(DS_O_MASTER.NameValue(1, "DAYPROFAMT"+j),",",""));
	            strCmprTamt += parseInt(replaceStr(DS_O_MASTER.NameValue(1, "DAYCMPR"+j),",",""));
	            strCmprAct  += parseInt(replaceStr(DS_O_MASTER.NameValue(1, "ACT_DAYCMPR"+j),",",""));
	            
	            
	            if(strCustCntT == 0){
	            	strCustDanga = 0;
	            }
	            else{
	            	strCustDanga = getRoundDec("1",strSaleTamt/strCustCntT,0);
	            }
	            
	            if(strSaleTamt == 0){
	            	strIRate     = 0;
	            }
	            else{
	            	strIRate     = getRoundDec("1",(strSaleTamt - strCmprTamt)/strSaleTamt*100,2);
	            }
                
	            
	            if ( DS_O_MASTER.CountRow != 0 ){	  
	            	//alert(DS_O_MASTER.NameValue(1, "CMPR_ACHIEVERATE"+j));
	                content += "<td id='td"+j+"' class='d_num' ><div align=left>"+j+"</div><br><span class='red'  >"+DS_O_MASTER.NameValue(1, "DAY"+j)+"<br>"+DS_O_MASTER.NameValue(1, "ACT_DAY"+j)+"<br>"+DS_O_MASTER.NameValue(1, "ACHIEVERATE"+j)+"<br>"+DS_O_MASTER.NameValue(1, "DAYCUSTCNT"+j)+"<br>"+DS_O_MASTER.NameValue(1, "DAYCUSTDANGA"+j)+"<br>"+DS_O_MASTER.NameValue(1, "DAYPROFAMT"+j)+"<br>"+DS_O_MASTER.NameValue(1, "IRATE"+j)
	                		+  "<br>"+DS_O_MASTER.NameValue(1, "DAYCMPR"+j)+"<br>"+DS_O_MASTER.NameValue(1, "ACT_DAYCMPR"+j)+"<br>"+DS_O_MASTER.NameValue(1, "CMPR_ACHIEVERATE"+j)+"</sapn></a></td>";
	                //content += "<br><span class='red'>"+DS_O_MASTER.NameValue(1, "DAYCNT"+j)+"</sapn></a></td>";    
	                
	            }else {
	            	content += "<td id='td"+j+"' class='d_num' ><div align=left>"+j+"</div><br><span class='red' >"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"<br>"+0+"</sapn></a></td>";
	            } 
	            
	            
	        }

            line++; 
	        if(j == lastday ){//주간 전체 합계
            	for( m = 1; m <= 7 - strlastDay2; m++ ){
                    content += "<td class='d_day'>&nbsp;</td>";   
                    line++;  
                }
            	strSaleTamt  = comma(strSaleTamt);
            	strAct       = comma(strAct);
            	strAchieve   = comma(strAchieve);
                strCustCntT  = comma(strCustCntT);
                strProfTamt  = comma(strProfTamt);
                strCmprTamt  = comma(strCmprTamt);
                strCustDanga = comma(strCustDanga);
                strCmprAct   = comma(strCmprAct);
                //strCmprAchieve= comma(strCmprAchieve);
                content += "<td id='td"+j+"' class='d_num' ><div align=left >&nbsp;</div><br><span class='red'  >"+strSaleTamt+"<br>"+strAct+"<br>"+strAchieve+"<br>"+strCustCntT+"<br>"+strCustDanga+"<br>"+strProfTamt+"<br>"+strIRate+"<br>"+strCmprTamt+"<br>"+strCmprAct+"<br>"+strCmprAchieve+"</sapn></a></td>";
                line = 1;
            } 
	    }
	    
	    content += "</tr>"        
	        
	    content += "</tr>";
	    content += "</table>"
	    document.getElementById('calandal').innerHTML = content;    
	}

	function perYear(year, month){
	    
	    var cYear;
	    var cMonth;
	    
	    cYear = round(year, 0) - 1;
	    cMonth = month;
	    
	    getCalandal(cYear, cMonth);
	    
	}
	function PerMonth( year , month ){
	    
	    var mm = month;  
	    var cYear;
	    var cMonth;
	    
	    if( mm == "1" ){    
	       cYear = round(document.getElementById('selyear').value, 0) - 1;
	       cMonth = "12"; 
	       
	    }else {     
	        cYear = document.getElementById('selyear').value;
	        cMonth = round(document.getElementById('selmon').value, 0) - 1;
	             
	    }
	   
	    getCalandal(cYear, cMonth);
	    
	}
	function nextMonth(year, month){
	    var mm = month;  
	    var cYear;
	    var cMonth;    
	    
	    if( mm == "12" ){
	        cYear = round(document.getElementById('selyear').value, 0) + 1;
	        cMonth = "1";
	    }else {
	        cYear = document.getElementById('selyear').value;
	        cMonth = round(document.getElementById('selmon').value, 0) + 1;
	    }
	        
	    getCalandal(cYear, cMonth);
	}
	function nextYear(year, month){
	    var cYear;
	    var cMonth;
	    
	    cYear = round(year, 0) + 1;
	    cMonth = month;
	    
	    getCalandal(cYear, cMonth);
	}
function comma(amt){
	var strSaleTamt = "";
	var strSaleTamtS = String(amt);
    var strStringLen = strSaleTamtS.length;
    var strReCnt     = getRoundDec("3",strStringLen/3,0);
    var strMod       = strStringLen % 3;
    if(strStringLen <= 3) return strSaleTamtS;
    
    for(i=0; i<= strReCnt-1;i++){
        if(strMod == 0 && i == 0){
            strSaleTamt = strSaleTamtS.substr(0,3)+",";
        }
        else{
        	if(strMod != 0 && i == 0){
                strSaleTamt = strSaleTamtS.substr(0,strMod)+",";
        	}
        }
        if(i != 0) {
	        if(i == strReCnt-1){
	            if(i > 0 && strMod == 0){
	                strSaleTamt += strSaleTamtS.substr(i*3,3);
	            }
	            else{
	                strSaleTamt += strSaleTamtS.substr(i*3-(3-strMod),3);
	            }
	        }
	        else{
	            if(i > 0 && strMod == 0){
	                strSaleTamt += strSaleTamtS.substr(i*3,3)+",";
	            }
	            else{
	            	strSaleTamt += strSaleTamtS.substr(i*3-(3-strMod),3)+",";
	            }
	        }
        }
    }
    return strSaleTamt;
}
/**
 * chkValidation()
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
            showMessage(INFORMATION, OK, "USER-1003","대비년월"); 
            EM_EXE_YM_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_EXE_YM_E.text.replace(" ","").length != 6 ) {
            showMessage(INFORMATION, OK, "USER-1027","대비년월","6");
            EM_EXE_YM_E.focus();
            return false;
        }
        if(!checkYYYYMM(EM_EXE_YM_E.text)){
            showMessage(INFORMATION, OK, "USER-1004","대비년월");
            EM_EXE_YM_E.focus();
            return false;
        }
        
        break;
   
    }
    return true;
}
 

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
		
		var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
		var strOrgFlag=EM_ORG_FLAG.CodeValue;		
		getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                   //점		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	    
	   
		
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
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

<!-- 마스터 그리드 컬럼 변경시 저장 체크 처리 -->
<script language=Javascript for=GD_MASTER
   event=OnColumnPosChanged(Row,Colid)>

   
</script>


<!-- 년월 -->
<script language=JavaScript for=EM_EXE_YM_S event=onKillFocus()>

    //영업조회월
    if (isNull(EM_EXE_YM_S.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","년월"); 
        EM_EXE_YM_S.text =  varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_EXE_YM_S.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","년월","6");
        EM_EXE_YM_S.text =  varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_EXE_YM_S.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","년월");
        EM_EXE_YM_S.text =  varToMon;
        return ;
    }
    
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_EXE_YM_E event=onKillFocus()>


    //영업조회월
    if (isNull(EM_EXE_YM_E.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","년월"); 
        EM_EXE_YM_E.text =  varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_EXE_YM_E.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","년월","6");
        EM_EXE_YM_E.text =  varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_EXE_YM_E.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","년월");
        EM_EXE_YM_E.text =  varToMon;
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
	
    var obj   = document.getElementById("calandal");
    
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
                  </tr>
               <tr>
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" >팀</th>
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
                  <th class="point">매출년월</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_EXE_YM_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_EXE_YM_S)" align="absmiddle" />
                  <th class="point">대비년월</th>
                  <td colspan="5"><comment id="_NSID_"> <object
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
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><div id="calandal" style=" width:100%; height:430; overflow-y:auto;"></div>
        </td>
      </tr>
    </table></td>
  </tr>
  <!-- 
   <tr valign="top">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <div id="DIV_CONTENTS" style=" width:100%; height:478; overflow-y:auto;"> 
        
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=638 classid=<%=Util.CLSID_MGRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
                  
               </tr>
            </table>
            </div>
            </td>
         </tr>
      </table>
      </td>
   </tr>
 -->
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
