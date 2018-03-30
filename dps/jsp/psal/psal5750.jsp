<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2017.03.24
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal5750.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월별보고자료 작성
 * 이    력 :2017.03.24 김준영
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
 var CUR_GR;
 var top = 450;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID 
function doInit(){
	 

	//Master 그리드 세로크기자동조정  2013-07-17
	//var obj   = document.getElementById("GD_DETAIL"); 
	//obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	CUR_GR = GD_MASTER;
     
    // Input Data Set Header 초기화
    ;
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');  
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');  
    DS_O_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');    
    
    //그리드 초기화
    gridCreate1(); //MASTER
    gridCreate2(); //DETAIL
    gridCreate3(); //마스터 코멘트
    gridCreate4(); //DETAIL 코멘트
   
    GD_MASTER.GTitleHeight = 30;
    GD_MASTER.TitleHeight  = 30;
    
    GD_DETAIL.GTitleHeight = 30;
    GD_DETAIL.TitleHeight  = 30;
    
    GD_DETAIL2.GTitleHeight = 20;
    GD_DETAIL2.TitleHeight  = 30;
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMM",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMM",                PK);   //대비일자(MARIO OUTLET 2011.08.27)
    EM_SALE_DT_E.alignment = 1;

    //현재월  셋팅
    //EM_SALE_DT_S.text =  varToday;
    EM_SALE_DT_S.text =  varToMon;

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
   
    //단위
    initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL);	
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "", "Y", strOrgFlag);                                                  		//점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                              	// 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);          // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
    getEtcCode("DS_UNIT"    , "D", "P622", "N"); 		// 단위
        
    LC_STR_CD.BindColVal  = strcd;   
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    EM_UNIT.Index 	 = 0;
    
    /*
    var strCmprdt = searchCmpr();
    if(strCmprdt == ""){
        ////EM_SALE_DT_E.text =  addDate('Y',-1, EM_SALE_DT_S.text);  //2011.08.27 MARIO OUTLET
    	EM_SALE_DT_E.text =  addDate('D',-364, EM_SALE_DT_S.text);    // 2011.08.27 MARIO OUTLET
    }
    else{
        ////EM_SALE_DT_E.text =  strCmprdt;                           //2011.08.27 MARIO OUTLET
        EM_SALE_DT_E.text =  addDate('D',-364, EM_SALE_DT_S.text);    // 2011.08.27 MARIO OUTLET
    }
    */
    //var strCmprdt = getBeforeYearDay(varToday);//아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02
    
    
	var strCmprdt = searchCmpr();
    
    if(strCmprdt == ""){
        EM_SALE_DT_E.text =  addDate('Y',-1, EM_SALE_DT_S.text);
    }
    else{
        EM_SALE_DT_E.text =  strCmprdt;
    }
    EM_SALE_DT_E.text = strCmprdt;
    
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    orgFlagCheck(orgFlag);
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal575","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id=PART_NAME               name="구분"      width=80    align=center   BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} suppress=1 </FC>'
			         + '<FC>id=PC_NAME                name="MD"        width=90   align=left      BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'
                     + '<X>                            name="월간"'
			         +   '<G>                            name="금년"'
			         + '<C>id=PRO_AMT_M                name="목표"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(PRO_AMT_M/UNIT)} 		sumtext={round(subsum(PRO_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=SALE_AMT_M               name="실적"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(SALE_AMT_M/UNIT)} 			sumtext={round(subsum(SALE_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_ACHIV_RATE_M         name="달성"          width=70    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(ORIGIN_SALE_TAMT),0,0.00,round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_SALE_TAMT))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=AMT_INCRE_RATE_M         name="신장"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=CUST_CNT_M               name="고객수(명)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {CUST_CNT_M} 			sumtext={round(subsum(SALE_AMT_CMPR)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNT_INCRE_RATE_M         name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))}  BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNTAMT_M                 name="객단가(원)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {CNTAMT_M} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNTAMT_INCRE_RATE_M      name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         +   '</G>'
			         +   '<G>                            name="전년"'
			         + '<C>id=PRE_AMT_M                name="실적"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PRE_AMT_M/UNIT} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PCUST_CMT_M              name="고객수(명)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PCUST_CMT_M} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PCNTAMT_M                name="객단가(원)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PCNTAMT_M} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         +   '</G>'
			         + '</X>'
			         + '<X>                            name="년간"'
			         +   '<G>                            name="금년"'
			         + '<C>id=PRO_AMT_Y                name="목표"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(PRO_AMT_Y/UNIT)} 		sumtext={round(subsum(PRO_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=SALE_AMT_Y               name="실적"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(SALE_AMT_Y/UNIT)} 			sumtext={round(subsum(SALE_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_ACHIV_RATE_Y         name="달성"          width=70    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(ORIGIN_SALE_TAMT),0,0.00,round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_SALE_TAMT))*100,2))}  BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_INCRE_RATE_Y         name="신장"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))}  BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CUST_CNT_Y               name="고객수(명)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {CUST_CNT_Y} 			sumtext={round(subsum(SALE_AMT_CMPR)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNT_INCRE_RATE_Y         name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))}  BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNTAMT_M                 name="객단가(원)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {CNTAMT_Y} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNTAMT_INCRE_RATE_Y      name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         +   '</G>'
			         +   '<G>                            name="전년"'
			         + '<C>id=PRE_AMT_Y                name="실적"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PRE_AMT_Y/UNIT} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PCUST_CMT_Y              name="고객수(명)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PCUST_CMT_Y} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PCNTAMT_Y                name="객단가(원)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PCNTAMT_Y} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         +   '</G>'
			         + '</X>'
			        ;
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.SuppressOption = '1'; 
    //합계표시
    //GD_MASTER.ViewSummary = "1";
    //GD_MASTER.DecRealData = true;
}

function gridCreate2(){
    var hdrProperies = '<FC>id=PART_NAME               name="구분"      width=80    align=center    suppress=1 BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
				     + '<FC>id=PC_NAME                 name="MD"        width=90   align=left       BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
			         + '<X>                            name="월간"'
        	         +   '<G>                            name="금년"'
			         + '<C>id=PRO_AMT_M                name="목표"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(PRO_AMT_M/UNIT)} 		sumtext={round(subsum(PRO_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=SALE_AMT_M               name="실적"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(SALE_AMT_M/UNIT)} 			sumtext={round(subsum(SALE_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_ACHIV_RATE_M         name="달성"          width=70    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(ORIGIN_SALE_TAMT),0,0.00,round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_SALE_TAMT))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=AMT_INCRE_RATE_M         name="신장"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=PROF_RATE_M              name="이익율"        width=100    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={round(subsum(SALE_AMT_CMPR)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PROF_INCRE_RATE_M        name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         +   '</G>'
			         +   '<G>                            name="전년"'
			         + '<C>id=PRE_AMT_M                name="실적"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PRE_AMT_M/UNIT} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PREPROF_RATE_M           name="이익율"        width=100    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"   sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         +   '</G>'
			         + '</X>'
			         + '<X>                            name="년간"'
        	         +   '<G>                            name="금년"'
			         + '<C>id=PRO_AMT_Y                name="목표"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(PRO_AMT_Y/UNIT)} 		sumtext={round(subsum(PRO_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=SALE_AMT_Y               name="실적"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(SALE_AMT_Y/UNIT)} 			sumtext={round(subsum(SALE_AMT_M)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_ACHIV_RATE_Y         name="달성"          width=70    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(ORIGIN_SALE_TAMT),0,0.00,round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_SALE_TAMT))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=AMT_INCRE_RATE_Y         name="신장"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=PROF_RATE_Y              name="이익율"        width=100    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={round(subsum(SALE_AMT_CMPR)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PROF_INCRE_RATE_Y        name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         +   '</G>'
			         +   '<G>                            name="전년"'
			         + '<C>id=PRE_AMT_Y                name="실적"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PRE_AMT_Y/UNIT} 			sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PREPROF_RATE_Y            name="이익율"        width=100    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"     sumtext={subsum(CNTAMT_M)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         +   '</G>'
			         + '</X>'
       					;
        
        

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    GD_DETAIL.SuppressOption = '1';
    //합계표시
   // GD_DETAIL.ViewSummary = "1";
   // GD_DETAIL.DecRealData = true;
}


function gridCreate3(){
    var hdrProperies = '<C>id=GROUP_NAME              name="구분"          width=90    align=center suppress=1 readonly=true '
    				 + ' Color={decode(GROUP_NAME,"패션/리빙","#D9418C","F&B/서비스","#2F9D27","직영","#146AB9","#000000")} BgColor={decode(GROUP_NAME,"패션/리빙","#FFD8D8","F&B/서비스","#B7F0B1","직영","#EBF2F8","#FFFFFF")}</C>'
    				 + '<C>id=ORG_NAME                name="MD"           width=90    align=center  suppress=2  readonly=true '
    				 + ' Color={decode(GROUP_NAME,"패션/리빙","#D9418C","F&B/서비스","#2F9D27","직영","#146AB9","#000000")} BgColor={decode(GROUP_NAME,"패션/리빙","#FFD8D8","F&B/서비스","#B7F0B1","직영","#EBF2F8","#FFFFFF")}</C>'
       				 + '<C>id=CMNTS1                  name="실적 분석"      width=500   align=left   readonly=true  </C>'
        			 + '<C>id=CMNTS2                  name="활성화 POINT"   width=500   align=left  readonly=true   </C>'                     
        			;
        
        

    initGridStyle(GD_MASTER2, "common", hdrProperies, false);
    GD_MASTER2.SuppressOption = '1';
    GD_MASTER2.ColumnProp("CMNTS1", "multiline") = "true";
    GD_MASTER2.ColumnProp("CMNTS2", "multiline") = "true";
    GD_MASTER2.ColumnProp("CMNTS1", "scroll") = "vert";
    GD_MASTER2.ColumnProp("CMNTS2", "scroll") = "vert";
    GD_MASTER2.RowHeight = "60";
    GD_MASTER2.ColSelect = "true";
    //합계표시
    //GD_MASTER.ViewSummary = "1";
    //GD_MASTER.DecRealData = true;
}


function gridCreate4(){
    var hdrProperies = '<C>id=GROUP_NAME              name="구분"          width=90    align=center  suppress=1 readonly=true  '
    	             + ' Color="#146AB9" BgColor="#EBF2F8" </C>'
                     + '<C>id=POST_CMNTS              name="전월"          width=500   align=left    readonly=true </C>'
                     + '<C>id=PRE_CMNTS               name="당월"          width=500   align=left   readonly=true  </C>'                     
                     ;
        
        

    initGridStyle(GD_DETAIL2, "common", hdrProperies, false);
    GD_DETAIL2.SuppressOption = '1';
    GD_DETAIL2.ColumnProp("POST_CMNTS", "multiline") = "true";
    GD_DETAIL2.ColumnProp("PRE_CMNTS", "multiline") = "true";
    GD_DETAIL2.ColumnProp("POST_CMNTS", "scroll") = "vert";
    GD_DETAIL2.ColumnProp("PRE_CMNTS", "scroll") = "vert";
    GD_DETAIL2.RowHeight = "60";
    GD_DETAIL2.ColSelect = "true";
    
    //합계표시
    //GD_MASTER.ViewSummary = "1";
    //GD_MASTER.DecRealData = true;
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
    DS_O_MASTER2.ClearData();
    DS_O_DETAIL2.ClearData();
    
    if(!chkValidation("search")) return;
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
                   ;
    
    TR_MAIN.Action="/dps/psal575.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    //스크롤바 위치 조정
    //GD_MASTER.SETVSCROLLING(0);
    //GD_MASTER.SETHSCROLLING(0);
    
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
    
	var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    
	if(rtnVal == "1"){
		CUR_GR = GD_MASTER;
	}else if(rtnVal == "2"){
		CUR_GR = GD_DETAIL;
	}else{
		return;
	}
    
    var strTitle 	= "월별 보고 자료";
    var strEmUnit 	= EM_UNIT.text;
    
    var parameters = "단위 "	+	strEmUnit	+	", %";
    CUR_GR.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    //openExcel2(CUR_GR, strTitle, parameters, true );
    openExcel5(CUR_GR, strTitle, parameters, true , "",g_strPid );
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
 * 작 성 일 : 2010-04-20
 * 개    요 : 브랜드별실적 조회
 * return값 : void
 */
 function searchDetail(){
	 
	  var strOrgFlag      = EM_ORG_FLAG.CodeValue;
	  var strStrCd        = LC_STR_CD.BindColVal;      //점
	  var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
	  var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
	  var strPCCd         = LC_PC_CD.BindColVal;       //PC
	  var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
	  var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
	  var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    
	    var goTo       = "searchDetail" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
	                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
	                   + "&strPCCd="            +encodeURIComponent(strPCCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;
	    
	    TR_DETAIL.Action="/dps/psal575.ps?goTo="+goTo+parameters;  
	    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	    TR_DETAIL.Post();

	    GD_DETAIL.focus();
	    
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_DETAIL.CountRow);

	    //스크롤바 위치 조정
	    GD_DETAIL.SETVSCROLLING(0);
	    GD_DETAIL.SETHSCROLLING(0);
     
     //DS_O_DETAIL.Filter();
 }



 /**
 * searchDetail2()
 * 작 성 자 : 김준영
 * 작 성 일 : 2017-03-26
 * 개    요 : 월별 내용 정리
 * return값 : void
 */
function searchDetail2(){
	 
       
     var strStrCd        = LC_STR_CD.BindColVal;   
     var strOrgFlag      = EM_ORG_FLAG.CodeValue;
     var strSaleDtS      = EM_SALE_DT_S.text;         //조회년월
     var strSaleDtE      = EM_SALE_DT_E.text;         //대비년월    
     
     
     var goTo       = "searchDetail2" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                    + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                    + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                    ;
     
     TR_DETAIL2.Action="/dps/psal575.ps?goTo="+goTo+parameters;  
     TR_DETAIL2.KeyValue="SERVLET("+action+":DS_O_DETAIL2=DS_O_DETAIL2)"; //조회는 O
     TR_DETAIL2.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_DETAIL2.CountRow);
     

     //스크롤바 위치 조정
     GD_DETAIL2.SETVSCROLLING(0);
     GD_DETAIL2.SETHSCROLLING(0);
     
     //DS_O_DETAIL.Filter();
 }





 /**
 * searchMaster2()
 * 작 성 자 : 김준영
 * 작 성 일 : 2017-03-26
 * 개    요 : 월별 내용 정리
 * return값 : void
 */
function searchMaster2(){
	 
       
     var strStrCd        = LC_STR_CD.BindColVal;   
     var strOrgFlag      = EM_ORG_FLAG.CodeValue;
     var strSaleDtS      = EM_SALE_DT_S.text;         //조회년월
     var strSaleDtE      = EM_SALE_DT_E.text;         //대비년월    
     
     
     var goTo       = "searchMaster2" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                    + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                    ;
     
     TR_MAIN2.Action="/dps/psal575.ps?goTo="+goTo+parameters;  
     TR_MAIN2.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
     TR_MAIN2.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_MASTER2.CountRow);
     

     //스크롤바 위치 조정
     //GD_MASTER2.SETVSCROLLING(0);
     //GD_MASTER2.SETHSCROLLING(0);
     
     //DS_O_DETAIL.Filter();
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
            showMessage(Information, OK, "USER-1003","매출년월"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 6 ) {
            showMessage(Information, OK, "USER-1027","매출년월","6");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMM(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출년월");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","대비년월"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 6 ) {
            showMessage(Information, OK, "USER-1027","대비년월","6");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMM(EM_SALE_DT_E.text)){
            showMessage(Information, OK, "USER-1004","대비년월");
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
    
    TR_MAIN.Action="/dps/psal575.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CMPRDT=DS_O_CMPRDT)"; //조회는 O
    TR_MAIN.Post();

    if(DS_O_CMPRDT.CountRow > 0){
        return DS_O_CMPRDT.NameValue(0,"CMPR_DT");
    }
    return "" ;
    
}

/* 조직구분의 따라 Enable 처리  */
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



<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN2.ErrorMsg);
</script>
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL2 event=onSuccess>
    for(i=0;i<TR_DETAIL2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL2.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL2 event=onFail>
    trFailed(TR_DETAIL2.ErrorMsg);
</script>


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

 <!-- Grid GD_MASTER OnPopup event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>

 </script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    //if(DS_O_MASTER.CountRow > 0){
   // 	searchDetail();
   // }
    CUR_GR = this;
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
   // sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>


<script language=JavaScript for=DS_O_MASTER event=OnLoadCompleted(rowcnt) >
//Master 그리드에 데이터 있을시 디테일 조회.
if(rowcnt > 0 ){
    searchDetail();
    searchDetail2();
    searchMaster2();
    
}
    
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
/*
if(row > 0 && old_Row > 0){
    searchDetail();
}
old_Row = row;
*/
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
	    
	    LC_STR_CD.BindColVal=strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
		
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		var strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);     
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

    //영업조회월
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출년월"); 
        EM_SALE_DT_S.text = varToday;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 6 ) {
        showMessage(Information, OK, "USER-1027","매출년월","6");
        EM_SALE_DT_S.text = varToday;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","매출년월");
        EM_SALE_DT_S.text = varToday;
        return ;
    }

    var strCmprdt = searchCmpr();
    
    if(strCmprdt == ""){
        EM_SALE_DT_E.text =  addDate('Y',-1, EM_SALE_DT_S.text);
    }
    else{
        EM_SALE_DT_E.text =  strCmprdt;
    }
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>
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

<script language=JavaScript for=DS_O_DETAIL event=OnFilter(row)>
if(
		DS_O_DETAIL.NameValue(row, "ORIGIN_SALE_TAMT")   == 0 &&	
		DS_O_DETAIL.NameValue(row, "TOT_SALE_AMT")       == 0 &&	
		DS_O_DETAIL.NameValue(row, "ACHIEVERATE") 	     == 0 &&	
		DS_O_DETAIL.NameValue(row, "SALE_AMT_CMPR")      == 0 &&	
		DS_O_DETAIL.NameValue(row, "SALEIRATE") 	     == 0 &&	
		DS_O_DETAIL.NameValue(row, "ORIGIN_SALE_TAMT_M") == 0 &&	
		DS_O_DETAIL.NameValue(row, "TOT_SALE_AMT_M") 	 == 0 &&	
		DS_O_DETAIL.NameValue(row, "ACHIEVERATE_M") 	 == 0 &&	
		DS_O_DETAIL.NameValue(row, "SALE_AMT_CMPR_M") 	 == 0 &&	
		DS_O_DETAIL.NameValue(row, "SALEIRATE_M") 		 == 0 &&	
		DS_O_DETAIL.NameValue(row, "ORIGIN_SALE_TAMT_Y") == 0 &&	
		DS_O_DETAIL.NameValue(row, "TOT_SALE_AMT_Y") 	 == 0 &&	
		DS_O_DETAIL.NameValue(row, "ACHIEVERATE_Y") 	 == 0 &&	
		DS_O_DETAIL.NameValue(row, "SALE_AMT_CMPR_Y") 	 == 0 &&	
		DS_O_DETAIL.NameValue(row, "SALEIRATE_Y") 		 == 0	
   ){
	return false;
}else{
	return true;
}
</script>

<script language="javascript"  for=GD_MASTER2 event=OnDblClick(Row,Colid)>
	if (Colid=="CMNTS1"||Colid=="CMNTS2"){
		GD_MASTER2.Editable = true;
		//alert("Occur OnDblClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		
	} else {
		GD_MASTER2.Editable = false;
	}
	   
	</script>	
<script language="javascript"  for=GD_MASTER2 event=OnClick(Row,Colid)>
	//alert("Occur OnDblClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
	
	//if (Colid!="CMNTS1"&&Colid!="CMNTS2"){
	//	Colid = "CMNTS1";

	//} else {
		
	//}
	
	GD_MASTER2.Editable = false;
		
   
</script>


<script language="javascript"  for=GD_DETAIL2 event=OnDblClick(Row,Colid)>
	if (Colid=="POST_CMNTS"||Colid=="PRE_CMNTS"){
		GD_DETAIL2.Editable = true;
		//alert("Occur OnDblClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		
	} else {
		GD_DETAIL2.Editable = false;
	}
	   
	</script>	
<script language="javascript"  for=GD_DETAIL2 event=OnClick(Row,Colid)>
	//alert("Occur OnDblClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
	
	//if (Colid!="POST_CMNTS"&&Colid!="PRE_CMNTS"){
	//	Colid = "POST_CMNTS";

	//} else {
		
	//}
	
	GD_DETAIL2.Editable = false;
		
   
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
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL2" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL2" classid=<%=Util.CLSID_TRANSACTION%>>
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
<body onLoad="doInit();" class="PL10 PT15">

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
                  <td width="105" colspan="7">
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
                  <th class="point">매출일자</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_SALE_DT_S)" align="absmiddle" />
                  </td>
                  <th class="point">대비일자</th>
                  <td >
                     <comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('M',EM_SALE_DT_E); " align="absmiddle" />
                  </td>
                  <th width = "70"> 단위</th>
				  <td colspan="5">
				     <comment id="_NSID_"> <object	
				     id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	
				     tabindex=1 align="absmiddle"> </object> </comment>	<script>_ws_(_NSID_);</script>
				     ,%
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
      <b><h3>1. 매출현황
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
  
   <tr valign="top">
      <td>
      <b><h3>2. 매출실적분석</h3></b> - 각 PC별 내용란을 더블 클릭하여 보이지 않는 내용을 확인 할 수 있습니다.
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER2 width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER2">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr valign="top">
      <td>
      <b><h3>3. 이익 실적 및 Review
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL width=100% height=380 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_DETAIL">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
   
   <tr valign="top">
      <td>
      <b><h3>4. 월간주요업무</h3></b>- 각 부서별 내용란을 더블 클릭하여 보이지 않는 내용을 확인 할 수 있습니다. 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL2 width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_DETAIL2">
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

