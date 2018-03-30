<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4730.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 브랜드별매출(전체)
 * 이    력 :2010.04.25 박종은
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

 var strOrgFlag = "1";

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
 var top = 140;		//해당화면의 동적그리드top위치
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
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    EM_SALE_DT_S.alignment = 1;
    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //종료일자
    EM_SALE_DT_E.alignment = 1;
    
    initEmEdit(EM_CMPR_DT_S1,                      "YYYYMMDD",                PK);   //대비시작일자
    EM_CMPR_DT_S1.alignment = 1;
    initEmEdit(EM_CMPR_DT_E1,                      "YYYYMMDD",                PK);   //대비종료일자
    EM_CMPR_DT_E1.alignment = 1;
        
    
    getEtcCode("DS_O_TEAM" ,"D"   ,"P250"  ,"Y" );         //파트코드
    
    
  //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                  //점
    //getStore("DS_STR_CD", "Y", "", "Y");                                                          // 점        
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                              // 팀 
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y");   // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;

    GD_MASTER.focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal473","DS_O_MASTER" );
    
  //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;

    EM_SALE_DT_E.text =  varToday;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    
    strCmprDt=searchCmprDate(strStrCd,varToday);
    EM_CMPR_DT_S1.text=strCmprDt;
    EM_CMPR_DT_E1.text=strCmprDt;
    
    EM_CMPR_DT_S1.Enable = "false";
	EM_CMPR_DT_E1.Enable = "false";
    
}

function gridCreate1(){
    var hdrProperies = '<FC> id=level				name=레벨 Value={CurLevel}   show=FALSE</FC>'
    				 + '<FC>id=STR_NAME				name="점"			width=90    align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")} suppress=1</FC>'
                     + '<FC>id=DEPT_NAME			name="팀"			width=80    align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")} suppress=2</FC>'
                     + '<FC>id=TEAM_NAME			name="파트"			width=50    align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")} suppress=3</FC>'
                     + '<FC>id=PC_NAME				name="PC"			width=80    align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")} suppress=4</FC>'
                     + '<FC>id=PUMBUN_CD			name="브랜드코드"	width=70    align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")} suppress=5</FC>'
                     + '<FC>id=PUMBUN_NM			name="브랜드"		width=100   align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")} suppress=6</FC>'
                     + '<FC>id=BRAND_TYPE			name="구분"			width=50    align=left		SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</FC>'
                     + '<FC>id=MG_RATE				name="마진율" 		width=60    align=right		mask="#,###.00"	SubSumText="소계"  SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</FC>'
                     
                     + '<C>id=ORIGIN_NORM_SAMT		name="목표"			width=100   align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(ORIGIN_NORM_SAMT)} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=TOT_SALE_AMT			name="실적"			width=100   align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(TOT_SALE_AMT)} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<FC>id=ACHIEVERATE			name="달성율" 		width=60    align=right		mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	sumtext={if(sum(ORIGIN_NORM_SAMT)= 0, 0, round((sum(TOT_SALE_AMT)/sum(ORIGIN_NORM_SAMT))*100,2))} SubSumText={if(subsum(ORIGIN_NORM_SAMT)= 0, 0, round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_NORM_SAMT))*100,2))} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</FC>'
                     + '<FC>id=TOT_COMP_RATE		name="구성비" 		width=60    align=right		mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	sumtext={if(subsum(TOT_SALE_AMT)= 0, 0, round((subsum(TOT_SALE_AMT)/subsum(TOT_SALE_AMT))*100,2))}  SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</FC>'
                     + '<C>id=SALE_PROF_AMT			name="이익액"		width=100   align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(SALE_PROF_AMT)} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=PROFRATE				name="이익율"		width=60    align=right     mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	SumText={sum(SALE_PROF_AMT)/sum(TOT_SALE_AMT)*100} SubSumText={SALE_PROF_AMT/TOT_SALE_AMT*100} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=CUST_CNT				name="객수"			width=60    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(CUST_CNT)} SubSumText={subsum(CUST_CNT)} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=CUST_DANGA			name="객단가"		width=100   align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={if(sum(CUST_CNT)= 0, 0, round((sum(TOT_SALE_AMT)/sum(CUST_CNT)),0))} subsumtext={if(subsum(CUST_CNT)= 0, 0, round((subsum(TOT_SALE_AMT)/subsum(CUST_CNT)),0))} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=P_TOT_SALE_AMT		name="대비실적"		width=100   align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(P_TOT_SALE_AMT)} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=TOT_COMP_RATE1		name="대비구성비" 	width=80    align=right		mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	sumtext={if(subsum(P_TOT_SALE_AMT)= 0, 0, round((subsum(P_TOT_SALE_AMT)/subsum(P_TOT_SALE_AMT))*100,2))} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     + '<C>id=SALEIRATE1			name="신장율" 		width=80    align=right		mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	sumtext={(sum(TOT_SALE_AMT) - sum(P_TOT_SALE_AMT))/sum(P_TOT_SALE_AMT)*100} subsumtext={(subsum(TOT_SALE_AMT) - subsum(P_TOT_SALE_AMT))/subsum(P_TOT_SALE_AMT)*100} SubBgColor={decode(curlevel,1,"#FFE08C",2,"#CEF279",3,"#B2EBF4",4,"#B5B2FF",5,"#FFA7A7")}</C>'
                     ;
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
    
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
    
    if(chkbox.checked == true)
    {
    	DS_O_MASTER.SubSumExpr  = "5:STR_NAME , 4:DEPT_NAME , 3:TEAM_NAME, 2:PC_NAME" ; 
    }	else	{
    	DS_O_MASTER.SubSumExpr  = "" ; 
    }
    
    if(!chkValidation("search")) return;
    

    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    
    var strCMPRDtS      = EM_CMPR_DT_S1.text;         //전년시작
    var strCMPRDtE      = EM_CMPR_DT_E1.text;         //전년종료
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strCMPRDtS="         +encodeURIComponent(strCMPRDtS)
                   + "&strCMPRDtE="         +encodeURIComponent(strCMPRDtE)
                   ;

    
    TR_MAIN.Action="/dps/psal473.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    
    GD_MASTER.SetAutoResizing("");
    
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
    var strTitle = "브랜드별매출(전체)";

    
    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    
    var parameters = "점 "           + strStrCd
                   + " ,   팀 "     + strDeptCd
                   + " ,   파트 "       + strTeamCd
                   + " ,   PC "      + strPCCd
                   + " ,   매출기간 "  + strSaleDtS
                   + " ~ " + strSaleDtE;
   
   
    
    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    openExcel2(GD_MASTER, strTitle, parameters, true );
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
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
    switch (gbn){
    case "search" :
/*
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
*/
        //매출일자
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출시작일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출시작일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출시작일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출종료일자"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출종료일자","8");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_E.text)){
            showMessage(Information, OK, "USER-1004","매출종료일자");
            EM_SALE_DT_E.focus();
            return false;
        }
        
        if(!isBetweenFromTo(EM_SALE_DT_S.text, EM_SALE_DT_E.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        break;
   
    }
    return true;
}



/**
<!-- 매장으로 접근시 에는 매장 매입이 Enable 되고 매입 접근시 Disable 된다 -->


 * test
 * @returns
 */
function searchCmprDate(strStrCd,strSaleDt){


	 var goTo       = "searchCmprDate" ;
	 var action     = "O";
	 var parameters =  "&strStrCd="	 +encodeURIComponent(strStrCd)
					+  "&strSaleDtS="+encodeURIComponent(strSaleDt)
					;


	TR_MAIN.Action  = "/dps/psal301.ps?goTo="+goTo+parameters;
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





<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>

	  if(!this.Modified)
		return;
	
	  
	 
		 
		
	 var strStrCd        = LC_STR_CD.BindColVal;
	 var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
	 var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
	 strCmprDt=searchCmprDate(strStrCd,strSaleDtE);
	 
	 EM_CMPR_DT_E1.text=strCmprDt;

	 
	 //EM_SALE_DT_E.Focus();

	//영업조회월
	if (isNull(EM_SALE_DT_E.text) ==true ) {
		showMessage(Information, OK, "USER-1003","종료일자");
		EM_SALE_DT_E.text = varToMon;
		return ;
	}
	//영업조회월 자릿수, 공백 체크
	if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
		showMessage(Information, OK, "USER-1027","종료일자","8");
		EM_SALE_DT_E.text = varToday;
		return ;
	}
	//년월형식체크
	if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
		showMessage(Information, OK, "USER-1069","종료일자");
		EM_SALE_DT_E.text = varToday;
		return ;
	}

</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

	    if(!this.Modified)
		return;

	    
			

		var strStrCd        = LC_STR_CD.BindColVal;
		var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
		var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
		strCmprDt=searchCmprDate(strStrCd,strSaleDtS);
		
		EM_CMPR_DT_S1.text=strCmprDt;

		
		

		//EM_SALE_DT_S.Focus();

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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
/*
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
*/
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

<comment id="_NSID_"><object id="DS_O_TEAM"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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

<comment id="_NSID_">
<object id="DS_O_CMPRDTDATE" classid=<%=Util.CLSID_DATASET%>></object>
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
					<td width="105"><comment id="_NSID_"> <object
							id="EM_ORG_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1
							style="height: 20; width: 95">
							<param name=Cols value="2">
							<param name=Format value="1^매장,2^매입">
							<param name=CodeValue value="1">
						</object> </comment>
						<script>
							_ws_(_NSID_);
					</script></td>
					
					<th width="70" class="point">점</th>
                  	<td width="105" ><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                     <td colspan="2"><b>대비일자는 해당영업일에 연결되어있는 일자의 매출을 조회함</b></td>
                     
               </tr>
               <tr>
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
                  <th class="point" WIDTH="80" >매출기간</th>
                  <td width="220" ><comment id="_NSID_"> <object
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
                  <th class="point" WIDTH="80" ></th>
                  <td width="220" ><comment id="_NSID_"> <object
                     id=EM_CMPR_DT_S1 classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle" style="display:none"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_CMPR_DT_S1)" align="absmiddle" style="display:none"/>
                  
                     <comment id="_NSID_"> <object
                     id=EM_CMPR_DT_E1 classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle" style="display:none"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_CMPR_DT_E1.Enable) openCal('G',EM_CMPR_DT_E1); " align="absmiddle" style="display:none"/>
                  </td>
                  <th class="point" WIDTH="150" >소계출력<input type=checkbox id=chkbox checked></th><td colspan="3"></td>
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
                     id=GD_MASTER width=100% height=450 classid=<%=Util.CLSID_GRID%> tabindex=1>
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