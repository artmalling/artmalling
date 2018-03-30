<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4530.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출속보현황(조직별)
 * 이    력 :2010.04.08 박종은
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
   
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;
    
    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //대비일자1(2011.08.27 MARIO OUTLET)
    EM_SALE_DT_E.alignment = 1;
    
    
    initEmEdit(EM_CMPR_DT_S1,                      "YYYYMMDD",                PK);   //대비일자 1-1
    EM_CMPR_DT_S1.alignment = 1;
    
    
    initEmEdit(EM_CMPR_DT_E1,                      "YYYYMMDD",                PK);   //대비일자1-2(2011.08.27 MARIO OUTLET)
    EM_CMPR_DT_E1.alignment = 1;
   
    
    initEmEdit(EM_CMPR_DT_S2,                      "YYYYMMDD",                PK);   //대비일자2-1(2011.08.27 MARIO OUTLET)
    EM_CMPR_DT_S2.alignment = 1;
   
    
    initEmEdit(EM_CMPR_DT_E2,                      "YYYYMMDD",                PK);   //대비일자2-2(2011.08.27 MARIO OUTLET)
    EM_CMPR_DT_E2.alignment = 1;
    
    
   
    //현재년월 세팅
    //EM_SALE_DT_S.text =  varToday;
    var searchDate=varToday;
    
    EM_SALE_DT_S.text  = varToday; //매출일자 당일 
    EM_SALE_DT_E.text  = varToday; //매출일자 당일
   
   

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);                                 //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                                //PC(조회)
    
      
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
    checkStrCmpr();
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
	var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
   
   
    //strCmprDt=searchCmprDate(strStrCd,strSaleDtS);
	
    /* 아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02 */
    strCmprDt=getBeforeYearDay(strSaleDtS );
    EM_CMPR_DT_S1.text=strCmprDt;
    EM_CMPR_DT_S2.text=strCmprDt;
    //strCmprDt=searchCmprDate(strStrCd,strSaleDtE);
    EM_CMPR_DT_E1.text=strCmprDt;
    EM_CMPR_DT_E2.text=strCmprDt; 
    
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal453","DS_O_MASTER" );
    
      
    
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
                     + '<FC>id=ORG_CD                 name="조직코드"      width=100    align=center    suppress=1</FC>'
                     + '<FC>id=ORG_NAME               name="조직명"        width=80    align=left      suppress=1   sumtext="합계"</FC>'
                     + '<C>id=ORIGIN_SALE_TAMT        name="실행목표"      width=100    align=right    mask="###,###"     value= {ORIGIN_SALE_TAMT} sumtext={subsum(ORIGIN_SALE_TAMT)}</C>' //실행계획
                     + '<C>id=TOT_SALE_AMT            name="실적"         width=100    align=right    mask="###,###"     value= {TOT_SALE_AMT} sumtext={subsum(TOT_SALE_AMT)}</C>'
                     + '<C>id=ACHIEVERATE             name="달성율"        width=60    align=right     mask="#,###.00"   sumtext={if(sum(ORIGIN_SALE_TAMT)= 0, 0, round((sum(TOT_SALE_AMT)/sum(ORIGIN_SALE_TAMT))*100,2))}</C>' //달성율                     
                     + '<C>id=TOT_COMP_RATE           name="구성비"        width=60    align=right     mask="#,###.00"   value= {(((TOT_SALE_AMT)/(sum(TOT_SALE_AMT)))*100)} </C>'//구성비
                     + '<C>id=REDU_AMT                name="할인"          width=100    align=right    mask="###,###"    value= {REDU_AMT} sumtext={subsum(REDU_AMT)}</C>'
                     + '<C>id=NORM_SALE_AMT           name="매출"          width=100    align=right    mask="###,###"    value= {NORM_SALE_AMT} sumtext={subsum(NORM_SALE_AMT)}</C>'
                     + '<C>id=DC_AMT                  name="에누리"        width=100    align=right    mask="###,###"    value= {DC_AMT} sumtext={subsum(DC_AMT)}</C>'
                     + '<C>id=NET_SALE_AMT            name="순매출"        width=100    align=right     mask="###,###"    value= {NET_SALE_AMT} sumtext={subsum(NET_SALE_AMT)} </C>'
                     + '<C>id=SALE_PROF_AMT           name="이익액"        width=100    align=right     mask="###,###"    value= {SALE_PROF_AMT} sumtext={subsum(SALE_PROF_AMT)}</C>'
                     + '<C>id=PROFRATE                name="이익율"        width=60    align=right     mask="#,###.00"   sumtext={if(sum(TOT_SALE_AMT)= 0, 0, round((sum(SALE_PROF_AMT)/sum(TOT_SALE_AMT))*100,2))}</C>'
                     + '<C>id=CUST_CNT                name="객수"         width=60    align=right      mask="###,###"    sumtext={subsum(CUST_CNT)}</C>'
                     + '<C>id=CUST_DANGA              name="객단가"        width=80    align=right     mask="###,###"     value= {CUST_DANGA} sumtext={if(sum(CUST_CNT)= 0, 0, round((sum(TOT_SALE_AMT)/sum(CUST_CNT)),0))}</C>'                    
                     + '<C>id=TOT_SALE_AMT_CMPR1      name="대비실적1"      width=100    align=right    mask="###,###"     value= {TOT_SALE_AMT_CMPR1} sumtext={subsum(TOT_SALE_AMT_CMPR1)}</C>'
                     + '<C>id=TOT_COMP_RATE_CMPR1     name="대비구성비1"    width=100    align=right     mask="#,###.00"   value= {(((TOT_SALE_AMT_CMPR)/(sum(TOT_SALE_AMT_CMPR)))*100)} </C>'
                     + '<C>id=SALEIRATE1              name="신장율1"       width=60    align=right     mask="#,###.00"   value= {(((TOT_SALE_AMT)/(sum(TOT_SALE_AMT_CMPR1)))*100)} </C>'
                     + '<C>id=TOT_SALE_AMT_CMPR2      name="대비실적2"     width=60    align=right     mask="#,###.00"    value= {TOT_SALE_AMT_CMPR2} sumtext={subsum(TOT_SALE_AMT_CMPR2)}  </C>'
                     + '<C>id=TOT_COMP_RATE_CMPR2     name="대비구성비2"     width=100    align=right     mask="#,###.00"  value= {(((TOT_SALE_AMT_CMPR2)/(sum(TOT_SALE_AMT_CMPR2)))*100)} </C>'
                     + '<C>id=SALEIRATE2              name="신장율2"       width=60    align=right     mask="#,###.00"  value= {(((TOT_SALE_AMT)/(sum(TOT_SALE_AMT_CMPR2)))*100)} </C>'
                     
                     + '<C>id=SKU_FLAG                name="단품구분"      width=100    align=center          </C>'//show=false 
                     ;
                     
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";   // view단 합계 
    GD_MASTER.DecRealData = true;
}
function checkStrCmpr(){
	if(EM_CMPR_FLAG.CodeValue=="1"){
			
		 EM_CMPR_DT_S1.Enable = "false";
		 EM_CMPR_DT_S2.Enable = "false";
		 EM_CMPR_DT_E1.Enable = "false";
		 EM_CMPR_DT_E2.Enable = "false";
	}else if(EM_CMPR_FLAG.CodeValue=="2"){
		
		 EM_CMPR_DT_S1.Enable = "true";
		 EM_CMPR_DT_S2.Enable = "true";
		 EM_CMPR_DT_E1.Enable = "true";
		 EM_CMPR_DT_E2.Enable = "true";
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
function btn_Search(strOrgFlag) {
	    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strCmprDtS1     = EM_CMPR_DT_S1.text;        //대비일자 1-1
    var strCmprDtE1     = EM_CMPR_DT_E1.text;        //대비일자 1-2
    var strCmprDtS2     = EM_CMPR_DT_S2.text;        //대비일자 2-1
    var strCmprDtE2     = EM_CMPR_DT_E2.text;        //대비일자 2-2
    var strCornerCd   = "%";
    if(EM_ORG_FLAG.CodeValue=="1"){ 
    	var strOrgFlag = EM_ORG_FLAG.CodeValue; //'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />'; //조직구분 코드
    	
    }else {
    	var strOrgFlag = EM_ORG_FLAG.CodeValue;
    	
    }   
   	var strCmprFlag     = EM_CMPR_FLAG.CodeValue;
    
    	
    
    GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
    GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
    
    
    var goTo       = "searchMaster" ;  
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)    //조직구분 코드
                   + "&strCmprFlag="        +encodeURIComponent(strCmprFlag)     //대비구분
                   + "&strCmprDtS1="        +encodeURIComponent(strCmprDtS1)     //대비일자 1-1
                   + "&strCmprDtE1="	    +encodeURIComponent(strCmprDtE1)     //대비일자 1-2
                   + "&strCmprDtS2="        +encodeURIComponent(strCmprDtS2)     //대비일자 2-1
                   + "&strCmprDtE2="        +encodeURIComponent(strCmprDtE2)     //대비일자 2-2 
                   + "&strCornerCd="        +encodeURIComponent(strCornerCd)
                   ;
    
    TR_MAIN.Action="/dps/psal453.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    
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
    var strTitle = "매출속보현황(조직별)";

    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strCmprDtS1     = EM_CMPR_DT_S1.text;        //대비일자 1-1
    var strCmprDtE1     = EM_CMPR_DT_E1.text;        //대비일자 1-2
    var strCmprDtS2     = EM_CMPR_DT_S2.text;        //대비일자 2-1
    var strCmprDtE2     = EM_CMPR_DT_E2.text;        //대비일자 2-2
    
    var parameters = "점 "           + strStrCd
                   + " ,   팀 "     + strDeptCd
                   + " ,   파트 "       + strTeamCd
                   + " ,   PC "      + strPCCd
                   + " ,   매출시작일자 "  + strSaleDtS
                   + " ,   매출종료일자 "  + strSaleDtE
                   + " ,   대비시작일자 "  + strCmprDtS1
                   + " ,   대비종료일자 "  + strCmprDtE1
                   + " ,   대비시작일자 "  + strCmprDtS2
                   + " ,   대비종료일자 "  + strCmprDtE2
    	           + " ,   단위: 원, 명, %";
    
    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    //openExcel2(GD_MASTER, strTitle, parameters, true );
    openExcel5(GD_MASTER, strTitle, parameters, true , "",g_strPid );
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
        }if(!isBetweenFromTo(EM_SALE_DT_S.text, EM_SALE_DT_E.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_SALE_DT_S.focus();
            return false;
        }/* if(!isBetweenFromTo(EM_CMPR_DT_S1.text, EM_CMPR_DT_E1.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_CMPR_DT_S1.focus();
            return false;
        }if(!isBetweenFromTo(EM_CMPR_DT_S2.text, EM_CMPR_DT_E2.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_CMPR_DT_S2.focus();
            return false;
        } */
        break;
   
    }
    return true;
}
/**
* getFlag(strDataSet, strStrCd, allGb
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 팀 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getDept(strDataSet, "01", "Y")
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 코드
*            arguments[2] -> '전체'를 보일건지 여부 ( Y/N )
*            arguments[3] -> 조직구분
*            --------------------- 미필수
*            arguments[4] -> 관리조직 여부 
* return값 : void
*/



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

<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>



  // SKU_FLAG : D(팀), T(파트), P(PC), C(CORNER), 1(단품), 2(비단품)
if(DS_O_MASTER.NameValue(row, "SKU_FLAG") == "2"){
	showMessage(INFORMATION, OK, "USER-1000","비단품 브랜드입니다. 더이상 조회 할 수 없습니다.");
    return;
}

if(DS_O_MASTER.NameValue(row, "SKU_FLAG") == "E"){
    showMessage(INFORMATION, OK, "USER-1000","단품입니다. 더이상 조회 할 수 없습니다.");
    return;
}

var strOrgFlag    = EM_ORG_FLAG.CodeValue;
var strStrCd      = DS_O_MASTER.NameValue(row, "ORG_CD").substr(0,2);
var strDeptCd     = DS_O_MASTER.NameValue(row, "ORG_CD").substr(2,2);
var strTeamCd     = DS_O_MASTER.NameValue(row, "ORG_CD").substr(4,2);
var strPcCd       = DS_O_MASTER.NameValue(row, "ORG_CD").substr(6,2);
if(strOrgFlag=="1"){	
	var strCornerCd   = DS_O_MASTER.NameValue(row, "ORG_CD").substr(8,2);
}else{
	var strCornerCd   = "%";
}
var strPumbunCd   = "";
var strCmprFlag   = EM_CMPR_FLAG.BindColVal; 


if(DS_O_MASTER.NameValue(row, "ORG_CD").length == 10){//조직	
	LC_STR_CD.BindColVal  = strStrCd;

	if(strDeptCd !="00"){
	    LC_DEPT_CD.BindColVal = strDeptCd;
	    if(strTeamCd !="00"){
	        LC_TEAM_CD.BindColVal = strTeamCd;
	        if(strPcCd !="00"){
	            LC_PC_CD.BindColVal   = strPcCd;
	        }
	        
	    }
	    
	}
}
else {//브랜드
	strPumbunCd  = DS_O_MASTER.NameValue(row, "ORG_CD");
}

//마스터, 디테일 그리드 클리어
DS_O_MASTER.ClearData();

if(!chkValidation("search")) return;

var strStrCd        = LC_STR_CD.BindColVal;      //점
var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
var strPCCd         = LC_PC_CD.BindColVal;       //PC
var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
var strCmprDtS1     = EM_CMPR_DT_S1.text;        //대비일자 1-1
var strCmprDtE1     = EM_CMPR_DT_E1.text;        //대비일자 1-2
var strCmprDtS2     = EM_CMPR_DT_S2.text;        //대비일자 2-1
var strCmprDtE2     = EM_CMPR_DT_E2.text;        //대비일자 2-2
var strCmprFlag     = EM_CMPR_FLAG.CodeValue;
       


if(strPumbunCd != "" && strTeamCd != "%" && strPCCd != "%" && strDeptCd != "%" && strCornerCd != "00"){
		/* ---------------그리드 명 변경--------------------- */
	GD_MASTER.ColumnProp("ORG_CD", "name")   = "단품코드"
    GD_MASTER.ColumnProp("ORG_NAME", "name") = "단품명"
    	GD_MASTER.ColumnProp("CUST_CNT", "name") = "수량"
}
else{
	if(strTeamCd != "%" && strPCCd != "%" && strDeptCd != "%" && strCornerCd != "00"){
		/* ---------------그리드 명 변경--------------------- */
	    GD_MASTER.ColumnProp("ORG_CD", "name")   = "브랜드코드"
	    GD_MASTER.ColumnProp("ORG_NAME", "name") = "브랜드명"
	    	GD_MASTER.ColumnProp("CUST_CNT", "name") = "객수"
	}
	else{
		/* ---------------그리드 명 변경--------------------- */
	    GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
	    GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
	    	GD_MASTER.ColumnProp("CUST_CNT", "name") = "객수"
	}
}


var goTo       = "searchMaster2" ;    
var action     = "O";     
var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
               + "&strDeptCd="          +encodeURIComponent(strDeptCd)
               + "&strTeamCd="          +encodeURIComponent(strTeamCd)
               + "&strPCCd="            +encodeURIComponent(strPCCd)
               + "&strCornerCd="        +encodeURIComponent(strCornerCd)
               + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
               + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
               + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
               + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)      //조직구분 코드
               + "&strCmprFlag="        +encodeURIComponent(strCmprFlag)     //대비구분
               + "&strCmprDtS1="        +encodeURIComponent(strCmprDtS1)     //대비일자 1-1
               + "&strCmprDtE1="	    +encodeURIComponent(strCmprDtE1)     //대비일자 1-2
               + "&strCmprDtS2="        +encodeURIComponent(strCmprDtS2)     //대비일자 2-1
               + "&strCmprDtE2="        +encodeURIComponent(strCmprDtE2)     //대비일자 2-2
               ;

TR_MAIN.Action="/dps/psal453.ps?goTo="+goTo+parameters;  
TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
TR_MAIN.Post();

GD_MASTER.focus();
// 조회결과 Return
setPorcCount("SELECT", DS_O_MASTER.CountRow);//gauce.js  setPorcCount 

//스크롤바 위치 조정
GD_MASTER.SETVSCROLLING(0);
GD_MASTER.SETHSCROLLING(0);


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

<!-- 대비 구분  변경시  -->
<script language=JavaScript for=EM_CMPR_FLAG event=OnSelChange()>
	var strStrCd        = LC_STR_CD.BindColVal;      //점
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
	var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
	var strCmprDt       = "";

	 if(EM_CMPR_FLAG.CodeValue=="1"){
	  
	  
// 	  strCmprDt=searchCmprDate(strStrCd,strSaleDtS);
	  strCmprDt=getBeforeYearDay(strSaleDtS); /* 아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02 */
	     EM_CMPR_DT_S1.text=strCmprDt;
	     EM_CMPR_DT_S2.text=strCmprDt;
// 	  strCmprDt=searchCmprDate(strStrCd,strSaleDtE);
	  strCmprDt=getBeforeYearDay(strSaleDtE); /* 아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02 */
	     EM_CMPR_DT_E1.text=strCmprDt;
	     EM_CMPR_DT_E2.text=strCmprDt; 
	     
		 EM_CMPR_DT_S1.Enable = "false";
		 EM_CMPR_DT_S2.Enable = "false";
		 EM_CMPR_DT_E1.Enable = "false";
		 EM_CMPR_DT_E2.Enable = "false";
		 
		
	}else if(EM_CMPR_FLAG.CodeValue=="2"){
		 
		 EM_CMPR_DT_S1.text=addDate('D',-7, EM_SALE_DT_S.text); // 2011.08.27 MARIO OUTLET
		 EM_CMPR_DT_S2.text=addDate('D',-7, EM_SALE_DT_S.text); // 2011.08.27 MARIO OUTLET
		 EM_CMPR_DT_E1.text=addDate('D',-7, EM_SALE_DT_E.text); // 2011.08.27 MARIO OUTLET
	     EM_CMPR_DT_E2.text=addDate('D',-7, EM_SALE_DT_E.text); // 2011.08.27 MARIO OUTLET 
		 
		 EM_CMPR_DT_S1.Enable = "true";
		 EM_CMPR_DT_S2.Enable = "true";
		 EM_CMPR_DT_E1.Enable = "true";
		 EM_CMPR_DT_E2.Enable = "true";
		 
		
		
	   
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
    
</script>


<!-- 매장으로 접근시 에는 매장 매입이 Enable 되고 매입 접근시 Disable 된다 -->
<SCRIPT language=javascript>
/**
 * test
 * @returns
 */
function searchCmprDate(strStrCd,strSaleDt){
	
	 
     var goTo       = "searchCmprDate" ;    
     var action     = "O";     
     var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)   
                    +  "&strSaleDtS="+encodeURIComponent(strSaleDt)
                    ;
   
    
    TR_MAIN.Action  = "/dps/psal453.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_CMPRDTDATE=DS_O_CMPRDTDATE)"; //조회는 O
    TR_MAIN.Post();
    
   
    return DS_O_CMPRDTDATE.NameValue(0,"CMPR_DT"); 

    
   
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
<object id="DS_O_CMPRDT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CMPRDTDATE" classid=<%=Util.CLSID_DATASET%>></object>
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
<%@ include file="/jsp/common/titleButton.jsp" %>
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
                  <td colspan="5">
                    <comment id="_NSID_">
                    <object id="EM_CMPR_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:150">
                    <param name=Cols    value="2">
                    <param name=Format  value="1^전년대비,2^전주대비">
                    <param name=CodeValue  value="1">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>  
               
               </tr>
               <!-- 신규추가 끝 -->
               <tr>              
                  <th width="70" class="point">점</th>
                  <td width="210"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" >팀</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" >파트</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">매출일자</th>
                  <td><comment id="_NSID_"> <object
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
                  <th >단위</th>
                  <td colspan="5">원, 명, %
                  </td>                  
               </tr>
               <tr>
               	  <th class="point">대비일자1</th> <!-- 대비일자1 -->
                  <td>
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
                  
                  <th class="point">대비일자2</th> <!-- 대비일자2 -->
                  <td colspan="5">
                     <comment id="_NSID_"> <object
                     id="EM_CMPR_DT_S2" classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_CMPR_DT_S2.Enable) openCal('G',EM_CMPR_DT_S2); " align="absmiddle" />~
                     
                 <comment id="_NSID_"> <object
                     id="EM_CMPR_DT_E2" classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_CMPR_DT_E2.Enable) openCal('G',EM_CMPR_DT_E2); " align="absmiddle" />
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
                     id=GD_MASTER width=100% height=720 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
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
