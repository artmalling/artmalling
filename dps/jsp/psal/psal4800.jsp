<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2011.08.16
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4800.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 마진별매출실적(협력사)
 * 이    력 :2011.08.16 박종은
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

    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToMon+"01";

    EM_SALE_DT_E.text =  varToday;

    initEmEdit(EM_S_VEN_CD             ,"000000"        ,NORMAL);  // 조회용 협력사코드
    initEmEdit(EM_S_VEN_NM             ,"GEN"           ,READ);    // 조회용 협력사코드명     
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              	//점(조회)
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //팀(조회)
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL);					//단위
    //구분 콤보 초기화
    initComboStyle(EM_PUMMOK_FLAG,DS_PUMMOK_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);               
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                     //점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);         // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC
    getEtcCode("DS_PUMMOK_FLAG"    ,"D"   ,"P420"  ,"N" );          // 구분
    getEtcCode("DS_UNIT"    , "D", "P622", "N"); 					//단위
   
 	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    orgFlagCheck(orgFlag);
    
    LC_STR_CD.BindColVal = strcd;
    //LC_STR_CD.Index=0;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    EM_PUMMOK_FLAG.Index=0;
    EM_UNIT.Index 	 = 1;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal480","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             name="NO"		width=30    align=center    SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=STR_CD               name="점"		width=100	align=center    Show=false</FC>'
                     + '<FG>						name="팀"'
                     + '<FC>id=DEPT_CD				name="코드"		width=30    align=center	suppress=2		SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=DEPT_NAME   		    name="명"		width=80    align=left		suppress=2		SubSumText={decode(curlevel,2,"팀별소계","")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG>'
                     + '<FG>						name="파트"'
                     + '<FC>id=TEAM_CD				name="코드"		width=30    align=center	suppress=2		SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=TEAM_NAME   		    name="명"		width=80    align=left		suppress=2		SubSumText={decode(curlevel,2,"파트별소계","")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG>'
                     + '<FG>						name="PC"'
                     + '<FC>id=PC_CD				name="코드"		width=30    align=center	suppress=1		SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=PC_NAME	        	name="명"		width=80    align=left		suppress=1		SubSumText={decode(curlevel,1,"PC별소계","")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG>'
                     + '<FG>                        name="협력사"'
                     + '<FC>id=VEN_CD               name="코드"		width=50    align=center	suppress=1		SubSumText=""										SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=VEN_NAME             name="명"		width=80    align=left		suppress=1		SubSumText={decode(curlevel,1,"협력사소계","")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '</FG>'
                     + '<FG>                        name="개별브랜드"'
                     + '<FC>id=REP_PUMBUN_CD        name="코드"		width=50    align=center	SubSumText=""	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=REP_PUMBUN_NAME      name="명"		width=80    align=left		sumtext="합계"	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '</FG>'                    
                     + '<FG>                        name="브랜드"   '  
                     + '<FC>id=PUMBUN_CD            name="코드"		width=50    align=center	SubSumText=""	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=PUMBUN_NAME          name="명"		width=80    align=left		sumtext="합계"	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '</FG>'                   	 
                     + '<FG>                        name="품목"     '
                     + '<FC>id=PUMMOK_CD            name="코드"		width=50    align=center	SubSumText=""	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=PUMMOK_NAME          name="명"		width=80    align=left		sumtext="합계"	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '</FG>'       
                     + '<FG>                         name="행사"'
                     + '<C>id=EVENT_FLAG            name="구분"		width=40    align=center	SubSumText=""	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
                     + '<C>id=EVENT_RATE            name="율"		width=40    align=center	SubSumText=""	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
                     + '</FG> '
                     + '<FC>id=MG_RATE              name="마진율"	width=60    align=right		mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	SubSumText=""						SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=TOT_SALE_AMT         name="총매출"	width=90    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(TOT_SALE_AMT)/UNIT)}		value={round(TOT_SALE_AMT/submax(UNIT))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=REDU_AMT             name="할인"		width=90    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(REDU_AMT)}			SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=SALE_AMT             name="매출"		width=90    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(SALE_AMT)/UNIT)}			value={round(SALE_AMT/submax(UNIT))}			SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=DC_AMT               name="에누리"	width=90    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(DC_AMT)}			SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=NET_SALE_AMT         name="순매출"	width=90    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(NET_SALE_AMT)/UNIT)}		value={round(NET_SALE_AMT/submax(UNIT))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=SALE_PROF_AMT        name="이익액"	width=90    align=right		mask="###,###"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(SALE_PROF_AMT)/UNIT)}		value={round(SALE_PROF_AMT/submax(UNIT))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC>id=PROFRATE             name="이익율"	width=60    align=right		mask="#,###.00"	gte_columntype="number:2:true" gte_Summarytype="number:2:true"	SubSumText=""	sumtext={subsum(SALE_PROF_AMT)/subsum(SALE_AMT)*100} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                     + '<FC> id=level               name=레벨 		Value={CurLevel}    width=50   show=false</FC>'
                     ;
       
    
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
    DS_O_MASTER.SubSumExpr  = "3:TEAM_ORG_NAME, 2:PC_ORG_NAME, 1:VEN_CD " ; 
    GD_MASTER.ColumnProp("PUMBUN_NAME", "sumtext")        = "합계";
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
 * 작 성 일 : 2011-03-16
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
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    var strPumbunCd     = EM_S_VEN_CD.Text;          //협력사코드
    var strPummmokFlag  = EM_PUMMOK_FLAG.BindColVal;
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strPummmokFlag="     +encodeURIComponent(strPummmokFlag)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
                   ;
    
    TR_MAIN.Action="/dps/psal480.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    controlGrid()

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
    var strTitle = "마진별매출실적(협력사)";

    var strStrCd        = LC_STR_CD.Text;       //점
    var strDeptCd       = LC_DEPT_CD.Text;      //팀
    var strTeamCd       = LC_TEAM_CD.Text;      //파트
    var strPCCd         = LC_PC_CD.Text;        //PC
    var strSaleDtS      = EM_SALE_DT_S.text;    //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;    //종료일자
    var strVencd        = EM_S_VEN_CD.text;     //브랜드코드
    var strEmUnit 		= EM_UNIT.text;			//단위
    
    var parameters = "점 "           	 + strStrCd
                   + " ,   팀 "     	 + strDeptCd
                   + " ,   파트 "       	 + strTeamCd
                   + " ,   PC "      	 + strPCCd
                   + " ,   매출기간 "    + strSaleDtS
                   + " ~ " + strSaleDtE
                   + " ,   협력사 "      + strVencd
                   + " ,   단위 "		 + strEmUnit
                   ;
    
    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    openExcel2(GD_MASTER, strTitle, parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-08
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {

	 
     
	 var strStrCd        = LC_STR_CD.BindColVal;      //점
	 var strStrNm        = LC_STR_CD.text;      //점
	    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
	    var strDeptNm       = LC_DEPT_CD.text;     //팀
	    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
	    var strTeamNm       = LC_TEAM_CD.text;     //파트
	    var strPCCd         = LC_PC_CD.BindColVal;       //PC
	    var strPCNm         = LC_PC_CD.text;       //PC
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strVenCd        = EM_S_VEN_CD.text;         //브랜드코드
	    var strVenNm        = EM_S_VEN_NM.text;         //브랜드코드
	    var strUserId       = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
	    
	    var parameters =  "&strStrCd="+strStrCd
					 	 + "&strStrNm="+encodeURIComponent(strStrNm)
				         + "&strSaleDtS="+strSaleDtS
				         + "&strSaleDtE="+strSaleDtE
				         + "&strDeptCd="+strDeptCd
				         + "&strDeptNm="+encodeURIComponent(strDeptNm)
				         + "&strTeamCd="+strTeamCd
				         + "&strTeamNm="+encodeURIComponent(strTeamNm)
				         + "&strPCCd="+strPCCd
				         + "&strPCNm="+encodeURIComponent(strPCNm)
				         + "&strVenCd="+strVenCd
					 	 + "&strVenNm="+encodeURIComponent(strVenNm)
					 	 + "&strUserId="+strUserId
					         ;

	    window.open("/dps/psal480.ps?goTo=print"+parameters,"OZREPORT", screen.availWidth, screen.availHeight);

	 
	 
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
 * controlGrid()
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-03-14
 * 개    요 :   그리드 숨김 표시
 * return값 : void
 */
 function controlGrid(){    
	
	if(EM_PUMMOK_FLAG.BindColVal=="1"){
		GD_MASTER.ColumnProp("PUMBUN_CD",      "show")   = false;
		GD_MASTER.ColumnProp("PUMBUN_NAME",    "show")   = false;
		GD_MASTER.ColumnProp("PUMMOK_CD",      "show")   = false;
		GD_MASTER.ColumnProp("PUMMOK_NAME",    "show")   = false;
		GD_MASTER.ColumnProp("REP_PUMBUN_CD",  "show")   = true;
		GD_MASTER.ColumnProp("REP_PUMBUN_NAME","show")   = true;
	}else if(EM_PUMMOK_FLAG.BindColVal=="2"){
		GD_MASTER.ColumnProp("REP_PUMBUN_CD",  "show")   = false;
		GD_MASTER.ColumnProp("REP_PUMBUN_NAME","show")   = false;
		GD_MASTER.ColumnProp("PUMBUN_CD",      "show")   = true;
		GD_MASTER.ColumnProp("PUMBUN_NAME",    "show")   = true;
		GD_MASTER.ColumnProp("PUMMOK_CD",      "show")   = false;
		GD_MASTER.ColumnProp("PUMMOK_NAME",    "show")   = false;
	} else if(EM_PUMMOK_FLAG.BindColVal=="3"){
		GD_MASTER.ColumnProp("REP_PUMBUN_CD",  "show")   = false;
		GD_MASTER.ColumnProp("REP_PUMBUN_NAME","show")   = false;
		GD_MASTER.ColumnProp("PUMBUN_CD",      "show")   = true;
		GD_MASTER.ColumnProp("PUMBUN_NAME",    "show")   = true;
		GD_MASTER.ColumnProp("PUMMOK_CD",      "show")   = true;
		GD_MASTER.ColumnProp("PUMMOK_NAME",    "show")   = true;
		
	} 
	
}
 
 

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-03-14
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
 * getVenInfo(code, name)
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-03-18
 * 개    요 :  브랜드에 따른 협력사 팝업
 * return값 : void
 */
function getVenInfo(code, name){
    var strStrCd        = LC_STR_CD.BindColVal;                                       // 점
    var strUseYn        = "Y";                                                       // 사용여부
    var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
    var strBizType      = "";                                                       // 거래형태
    var strMcMiGbn      = "";                                                       // 매출처/매입처구분
    var strBizFlag      = "";                                                        // 거래구분       

    var rtnMap = venPop(code, name
                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                         ,strBizFlag);
}

/**
 * getVenNonInfo(code, name)
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-03-18
 * 개    요 :  브랜드에 따른 협력사 팝업
 * return값 : void
 */
function getVenNonInfo(code, name){
    var strStrCd        = LC_STR_CD.BindColVal;                                       // 점
    var strUseYn        = "Y";                                                       // 사용여부
    var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
    var strBizType      = "";                                                       // 거래형태
    var strMcMiGbn      = "";                                                       // 매출처/매입처구분
    var strBizFlag      = "";                                                        // 거래구분
    
    var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                        ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                        ,strBizFlag);
    if(rtnMap != null){
        EM_S_VEN_CD.Text = rtnMap.get("VEN_CD");
        EM_S_VEN_NM.Text = rtnMap.get("VEN_NAME");
        return true;
    }else{
        return false;
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
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점		
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



<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
//    if(!this.Modified)
//        return;    
    if(EM_S_VEN_CD.Text != "")
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    else{
        EM_S_VEN_NM.Text = ""        
    }
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
<object id="DS_PUMMOK_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<comment id="_NSID_"> 
<object id="DS_UNIT"	classid=<%=Util.CLSID_DATASET%>></object> 
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
                  <th width="70">구분</th>
                  <td width="105"><comment id="_NSID_">
                  <object
                     id="EM_PUMMOK_FLAG"  classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle" >
                     </object> </comment><script>_ws_(_NSID_);</script></td> 
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
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width = "70"> 단위</th>
				  <td><comment id="_NSID_">	<object	
				  	 id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	tabindex=1 
				  	 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
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
                  
                  <th width="80">협력사</th>
                  <td colspan="3"><comment id="_NSID_"> <object id=EM_S_VEN_CD
                      classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
                      align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                      src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                      onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM); "
                      align="absmiddle" /> <comment id="_NSID_"> <object
                      id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=120
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
                     id=GD_MASTER width=100% height=455 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
