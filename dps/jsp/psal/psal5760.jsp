<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2017.03.24
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal5760.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 주간보고자료 작성
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
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	//var obj   = document.getElementById("GD_DETAIL"); 
	//obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	CUR_GR = GD_MASTER;
     
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');  
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');
    DS_O_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_IOMASTER"/>');    
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_IODETAIL"/>');    
    
    //그리드 초기화
    gridCreate1(); //MASTER
    gridCreate2(); //DETAIL
  
   
    GD_MASTER.GTitleHeight = 30;
    GD_MASTER.TitleHeight  = 30;
    
    GD_DETAIL.GTitleHeight = 30;
    GD_DETAIL.TitleHeight  = 30;
    
    //GD_DETAIL2.GTitleHeight = 20;
    //GD_DETAIL2.TitleHeight  = 30;
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;
    initEmEdit(EM_SALE_DT_S2,                     "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S2.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //대비일자(MARIO OUTLET 2011.08.27)
    EM_SALE_DT_E.alignment = 1;
    initEmEdit(EM_SALE_DT_E2,                      "YYYYMMDD",                PK);   //대비일자(MARIO OUTLET 2011.08.27)
    EM_SALE_DT_E2.alignment = 1;    

    //현재일  셋팅
    //EM_SALE_DT_S.text =  varToday;
    EM_SALE_DT_S.text =  varToday;
    EM_SALE_DT_S2.text =  varToday;
    
    initEmEdit(TXT_EM_MEMO_01,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_02,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_11,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_12,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_21,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_22,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_31,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_32,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_41,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_42,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_43,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_44,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_51,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_52,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_61,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_62,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_71,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_72,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_81,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_82,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_91,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_92,   "GEN^1000", PK); //내용
    
    
    initEmEdit(TXT_EM_MEMO_POST1,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_POST2,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_POST3,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_POST4,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_POST5,   "GEN^1000", PK); //내용
    //initEmEdit(TXT_EM_MEMO_POST6,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_PRE1,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_PRE2,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_PRE3,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_PRE4,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_PRE5,   "GEN^1000", PK); //내용
    //initEmEdit(TXT_EM_MEMO_PRE6,   "GEN^1000", PK); //내용
    

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
    
    
	var strCmprdt = searchCmpr("0");
    
    if(strCmprdt == ""){
        EM_SALE_DT_E.text =  addDate('Y',-1, EM_SALE_DT_S.text);
    }
    else{
        EM_SALE_DT_E.text =  strCmprdt;
    }
    EM_SALE_DT_E.text = strCmprdt;
    EM_SALE_DT_E2.text = strCmprdt;
    
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    orgFlagCheck(orgFlag);
    
    //GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal576","DS_IO_MASTER" );
    registerUsingDataset("psal576","DS_IO_DETAIL" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id=PART_NAME               name="구분"      width=80    align=center   BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} suppress=1 </FC>'
			         + '<FC>id=PC_NAME                name="MD"        width=90   align=left      BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'
                     + '<X>                            name="주간"'
			         +   '<G>                            name="금년"'
			         + '<C>id=PRO_AMT_D                name="목표"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(PRO_AMT_D/UNIT)} 		sumtext={round(subsum(PRO_AMT_D)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=SALE_AMT_D               name="실적"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(SALE_AMT_D/UNIT)} 			sumtext={round(subsum(SALE_AMT_D)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_ACHIV_RATE_D         name="달성"          width=70    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(ORIGIN_SALE_TAMT),0,0.00,round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_SALE_TAMT))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=AMT_INCRE_RATE_D         name="신장"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=CUST_CNT_D               name="고객수(명)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {CUST_CNT_D} 			sumtext={round(subsum(SALE_AMT_CMPR)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNT_INCRE_RATE_D         name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))}  BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNTAMT_D                 name="객단가(원)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {CNTAMT_D} 			sumtext={subsum(CNTAMT_D)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=CNTAMT_INCRE_RATE_D      name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         +   '</G>'
			         +   '<G>                            name="전년"'
			         + '<C>id=PRE_AMT_D                name="실적"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PRE_AMT_D/UNIT} 			sumtext={subsum(CNTAMT_D)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PCUST_CMT_D              name="고객수(명)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PCUST_CMT_D} 			sumtext={subsum(CNTAMT_D)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PCNTAMT_D                name="객단가(원)"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PCNTAMT_D} 			sumtext={subsum(CNTAMT_D)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         +   '</G>'
			         + '</X>'
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
				     + '<X>                            name="주간"'
        	         +   '<G>                            name="금년"'
			         + '<C>id=PRO_AMT_D                name="목표"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(PRO_AMT_D/UNIT)} 		sumtext={round(subsum(PRO_AMT_D)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=SALE_AMT_D               name="실적"         width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {round(SALE_AMT_D/UNIT)} 			sumtext={round(subsum(SALE_AMT_D)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=AMT_ACHIV_RATE_D         name="달성"          width=70    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(ORIGIN_SALE_TAMT),0,0.00,round((subsum(TOT_SALE_AMT)/subsum(ORIGIN_SALE_TAMT))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=AMT_INCRE_RATE_D         name="신장"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         + '<C>id=PROF_RATE_D              name="이익율"        width=100    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={round(subsum(SALE_AMT_CMPR)/UNIT)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PROF_INCRE_RATE_D        name="증감"          width=60    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"    sumtext={decode(subsum(SALE_AMT_CMPR),0,0.00,round(((subsum(TOT_SALE_AMT)-subsum(SALE_AMT_CMPR))/subsum(SALE_AMT_CMPR))*100,2))} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </C>'
			         +   '</G>'
			         +   '<G>                            name="전년"'
			         + '<C>id=PRE_AMT_D                name="실적"        width=100    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"     value= {PRE_AMT_D/UNIT} 			sumtext={subsum(CNTAMT_D)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         + '<C>id=PREPROF_RATE_D           name="이익율"        width=100    gte_columntype="number:2:true" gte_Summarytype="number:2:true"		align=right     mask="#,###.00"   sumtext={subsum(CNTAMT_D)} BgColor={decode(PC_NAME,"소계","#FFFFE0","합계","#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</C>'
			         +   '</G>'
			         + '</X>'
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


function EMCreate(){
    
	 var strStrCd        = LC_STR_CD.BindColVal;   
     var strOrgFlag      = EM_ORG_FLAG.CodeValue;
     var strSaleDtS      = EM_SALE_DT_S.text;         //조회년월
     var strSaleDtE      = EM_SALE_DT_E.text;         //대비년월    
     
     //alert("!!!!");
     
     var goTo       = "EMCreate" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                    + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
     
     TR_EMC.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
     TR_EMC.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
     TR_EMC.Post();
     
     if(DS_O_MASTER2.CountRow > 0){
     
	     
    	 
    	 if(DS_O_MASTER2.NameValue(1,"TF") == "true"){
    		 TXT_EM_MEMO_01.Enable = true;
    		 TXT_EM_MEMO_02.Enable =  true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_01.Enable = false;
    		 TXT_EM_MEMO_02.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(2,"TF") == "true"){
    		 TXT_EM_MEMO_11.Enable = true;
    		 TXT_EM_MEMO_12.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_11.Enable = false;
    		 TXT_EM_MEMO_12.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(3,"TF") == "true"){
    		 TXT_EM_MEMO_21.Enable = true;
    		 TXT_EM_MEMO_22.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_21.Enable = false;
    		 TXT_EM_MEMO_22.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(4,"TF") == "true"){
    		 TXT_EM_MEMO_31.Enable = true;
    		 TXT_EM_MEMO_32.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_31.Enable = false;
    		 TXT_EM_MEMO_32.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(5,"TF") == "true"){
    		 TXT_EM_MEMO_41.Enable = true;
    		 TXT_EM_MEMO_42.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_41.Enable = false;
    		 TXT_EM_MEMO_42.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(6,"TF") == "true"){
    		 TXT_EM_MEMO_43.Enable = true;
    		 TXT_EM_MEMO_44.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_43.Enable = false;
    		 TXT_EM_MEMO_44.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(7,"TF") == "true"){
    		 TXT_EM_MEMO_51.Enable = true;
    		 TXT_EM_MEMO_52.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_51.Enable = false;
    		 TXT_EM_MEMO_52.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(8,"TF") == "true"){
    		 TXT_EM_MEMO_61.Enable = true;
    		 TXT_EM_MEMO_62.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_61.Enable = false;
    		 TXT_EM_MEMO_62.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(9,"TF") == "true"){
    		 TXT_EM_MEMO_71.Enable = true;
    		 TXT_EM_MEMO_72.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_71.Enable = false;
    		 TXT_EM_MEMO_72.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(10,"TF") == "true"){
    		 TXT_EM_MEMO_81.Enable = true;
    		 TXT_EM_MEMO_82.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_81.Enable = false;
    		 TXT_EM_MEMO_82.Enable = false;
    	 }
    	 if(DS_O_MASTER2.NameValue(11,"TF") == "true"){
    		 TXT_EM_MEMO_91.Enable = true;
    		 TXT_EM_MEMO_92.Enable = true;    		 
    	 }
    	 else {
    		 TXT_EM_MEMO_91.Enable = false;
    		 TXT_EM_MEMO_92.Enable = false;
    	 }
    	 
	 }
     return;
     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_MASTER2.CountRow);
     

     //스크롤바 위치 조정
     //GD_MASTER2.SETVSCROLLING(0);
     //GD_MASTER2.SETHSCROLLING(0);
     
     //DS_O_DETAIL.Filter();   
        

    //initGridStyle(GD_MASTER2, "common", hdrProperies, false);
    //GD_MASTER2.SuppressOption = '1';
    //합계표시
    //GD_MASTER.ViewSummary = "1";
    //GD_MASTER.DecRealData = true;
}

function EMCreate2(){
    
	// 전월 내용 무조건 닫기
	TXT_EM_MEMO_POST1.Enable = false;
	TXT_EM_MEMO_POST2.Enable = false;
	TXT_EM_MEMO_POST3.Enable = false;
	TXT_EM_MEMO_POST4.Enable = false;
	TXT_EM_MEMO_POST5.Enable = false;
	
	var strStrCd        = LC_STR_CD.BindColVal;   
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strSaleDtS      = EM_SALE_DT_S.text;         //조회년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //대비년월    
    
    
    
    var goTo       = "EMCreate2" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
    
    TR_EMC2.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
    TR_EMC2.KeyValue="SERVLET("+action+":DS_O_DETAIL2=DS_O_DETAIL2)"; //조회는 O
    TR_EMC2.Post();
    
    if(DS_O_DETAIL2.CountRow > 0){
    	
	    	
	   	 if(DS_O_DETAIL2.NameValue(1,"TF") == "true"){
	   		TXT_EM_MEMO_PRE1.Enable = true;
	   	 }
	   	 else {
	   		TXT_EM_MEMO_PRE1.Enable = false;
	   	 }
	   	if(DS_O_DETAIL2.NameValue(2,"TF") == "true"){
	   		TXT_EM_MEMO_PRE2.Enable = true;
	   	 }
	   	 else {
	   		TXT_EM_MEMO_PRE2.Enable = false;
	   	 }
	   	if(DS_O_DETAIL2.NameValue(3,"TF") == "true"){
	   		TXT_EM_MEMO_PRE3.Enable = true;
	   	 }
	   	 else {
	   		TXT_EM_MEMO_PRE3.Enable = false;
	   	 }
	   	if(DS_O_DETAIL2.NameValue(4,"TF") == "true"){
	   		TXT_EM_MEMO_PRE4.Enable = true;
	   	 }
	   	 else {
	   		TXT_EM_MEMO_PRE4.Enable = false;
	   	 }
	   	if(DS_O_DETAIL2.NameValue(5,"TF") == "true"){
	   		TXT_EM_MEMO_PRE5.Enable = true;
	   	 }
	   	 else {
	   		TXT_EM_MEMO_PRE5.Enable = false;
	   	 }
   	 
	}
    return;
    // 조회결과 Return
    //setPorcCount("SELECT", DS_O_MASTER2.CountRow);
    

    //스크롤바 위치 조정
    //GD_MASTER2.SETVSCROLLING(0);
    //GD_MASTER2.SETHSCROLLING(0);
    
    //DS_O_DETAIL.Filter();   
       

   //initGridStyle(GD_MASTER2, "common", hdrProperies, false);
   //GD_MASTER2.SuppressOption = '1';
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
    
	 if (DS_IO_MASTER.IsUpdated||DS_IO_DETAIL.IsUpdated) {
			if(showMessage(StopSign, YESNO, "USER-1059") != 1 ){
				//setTimeout("LC_CLM_GRADE.Focus();",50);
		        return false;
			} 
	    }	 
	 
	 
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    
    if(!chkValidation("search")) return;
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strSaleDtS2      = EM_SALE_DT_S2.text;         //시작년월
    var strSaleDtE2      = EM_SALE_DT_E2.text;         //종료년월
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
                   + "&strSaleDtS2="         +encodeURIComponent(strSaleDtS2)
                   + "&strSaleDtE2="         +encodeURIComponent(strSaleDtE2)		
                   ;
    
    TR_MAIN.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
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
	 
	//저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated&&!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }

    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }	
    
    saveData();
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
    
	var rtnVal = showMessage(INFORMATION, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    
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
    openExcel2(CUR_GR, strTitle, parameters, true );
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
	  var strSaleDtS2      = EM_SALE_DT_S2.text;         //시작년월
	  var strSaleDtE2      = EM_SALE_DT_E2.text;         //종료년월
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
	                   + "&strSaleDtS2="         +encodeURIComponent(strSaleDtS2)
	                   + "&strSaleDtE2="         +encodeURIComponent(strSaleDtE2)	                   
	                   ;
	    
	    TR_DETAIL.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
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
     
     TR_DETAIL2.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
     TR_DETAIL2.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_DETAIL2.Post();
     
     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_DETAIL2.CountRow);
     

     //스크롤바 위치 조정
     //GD_DETAIL2.SETVSCROLLING(0);
     //GD_DETAIL2.SETHSCROLLING(0);
     
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
     
     TR_MAIN2.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
     TR_MAIN2.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
     TR_MAIN2.Post();
     
     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_MASTER2.CountRow);
     

     //스크롤바 위치 조정
     //GD_MASTER2.SETVSCROLLING(0);
     //GD_MASTER2.SETHSCROLLING(0);
     
     //DS_O_DETAIL.Filter();
 }


/**
 * saveData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개    요 : 
 * return값 : void
 */
function saveData(){ 

	var strStrCd        = LC_STR_CD.BindColVal;   
	var strOrgFlag      = EM_ORG_FLAG.CodeValue;
	var strSaleDtS      = EM_SALE_DT_S.text;         //조회년월
	var strSaleDtE      = EM_SALE_DT_E.text;         //대비년월
	
	var action     = "I";     
	var goTo       = "" ;    
    
    var parameters = "";
    
    var i = 0;
	
	
	//저장할 데이터 없는 경우
    if (DS_IO_MASTER.IsUpdated) {

	    var strOrg0			= "0101010100"; // 패션잡화
	    var strOrg1			= "0101010200"; // 여성
	    var strOrg2			= "0101010300"; // 남성
	    var strOrg3			= "0101010400"; // 레포츠
	    var strOrg4			= "0101010500"; // 유아동
	    var strOrg5			= "0101020100"; // 서비스
	    var strOrg6			= "0101020200"; // f&b
	    var strOrg7			= "0102010100"; // cgv
	    var strOrg8			= "0102010200"; // 한샘
	    var strOrg9			= "0102010300"; // 투썸
	    var strOrg10		= "0101010600"; // 리빙
	    var memo01			= TXT_EM_MEMO_01.text;
	    var memo02			= TXT_EM_MEMO_02.text;
	    var memo11			= TXT_EM_MEMO_11.text;
	    var memo12			= TXT_EM_MEMO_12.text;
	    var memo21			= TXT_EM_MEMO_21.text;
	    var memo22			= TXT_EM_MEMO_22.text;
	    var memo31			= TXT_EM_MEMO_31.text;
	    var memo32			= TXT_EM_MEMO_32.text;
	    var memo41			= TXT_EM_MEMO_41.text;
	    var memo42			= TXT_EM_MEMO_42.text;
	    var memo43			= TXT_EM_MEMO_43.text;
	    var memo44			= TXT_EM_MEMO_44.text;
	    var memo51			= TXT_EM_MEMO_51.text;
	    var memo52			= TXT_EM_MEMO_52.text;
	    var memo61			= TXT_EM_MEMO_61.text;
	    var memo62			= TXT_EM_MEMO_62.text;
	    var memo71			= TXT_EM_MEMO_71.text;
	    var memo72			= TXT_EM_MEMO_72.text;
	    var memo81			= TXT_EM_MEMO_81.text;
	    var memo82			= TXT_EM_MEMO_82.text;
	    var memo91			= TXT_EM_MEMO_91.text;
	    var memo92			= TXT_EM_MEMO_92.text;
	    
	    
	    
	     goTo       = "saveData" ;    
	    
	     parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
	                   + "&strOrg0="            +encodeURIComponent(strOrg0)
	                   + "&strOrg1="            +encodeURIComponent(strOrg1)
					   + "&strOrg2="            +encodeURIComponent(strOrg2)
					   + "&strOrg3="            +encodeURIComponent(strOrg3)
					   + "&strOrg4="            +encodeURIComponent(strOrg4)
					   + "&strOrg5="            +encodeURIComponent(strOrg5)
					   + "&strOrg6="            +encodeURIComponent(strOrg6)
					   + "&strOrg7="            +encodeURIComponent(strOrg7)
					   + "&strOrg8="            +encodeURIComponent(strOrg8)
					   + "&strOrg9="            +encodeURIComponent(strOrg9)
					   + "&strOrg10="            +encodeURIComponent(strOrg10)
					   + "&memo01="      		+encodeURIComponent(memo01)
					   + "&memo02="      		+encodeURIComponent(memo02)
					   + "&memo11="      		+encodeURIComponent(memo11)
					   + "&memo12="      		+encodeURIComponent(memo12)
					   + "&memo21="      		+encodeURIComponent(memo21)
					   + "&memo22="      		+encodeURIComponent(memo22)
					   + "&memo31="      		+encodeURIComponent(memo31)
					   + "&memo32="      		+encodeURIComponent(memo32)
					   + "&memo41="      		+encodeURIComponent(memo41)
					   + "&memo42="      		+encodeURIComponent(memo42)
					   + "&memo43="      		+encodeURIComponent(memo43)
					   + "&memo44="      		+encodeURIComponent(memo44)
					   + "&memo51="      		+encodeURIComponent(memo51)
					   + "&memo52="      		+encodeURIComponent(memo52)
					   + "&memo61="      		+encodeURIComponent(memo61)
					   + "&memo62="      		+encodeURIComponent(memo62)
					   + "&memo71="      		+encodeURIComponent(memo71)
					   + "&memo72="      		+encodeURIComponent(memo72)
					   + "&memo81="      		+encodeURIComponent(memo81)
					   + "&memo82="      		+encodeURIComponent(memo82)
					   + "&memo91="      		+encodeURIComponent(memo91)
					   + "&memo92="      		+encodeURIComponent(memo92)
	                   ;
	     
	    TR_MAIN2.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
	    TR_MAIN2.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //입력은 I?
	    TR_MAIN2.Post();
	
	    if( TR_MAIN2.ErrorCode == 50000 || TR_MAIN2.ErrorCode == 50052 ){ // 정상처리 되면 재조회
	    	i = i + 1;
	    }
	    else {
	    	alert("매출실적분석 자료 저장에 실패했습니다!");
	    	return;
	    }
    
    }
    
    if (DS_IO_DETAIL.IsUpdated) {
		
	    var strGrp1			= "104";
	    var strGrp2			= "115";
	    var strGrp3			= "112";
	    var strGrp4			= "113";
	    var strGrp5			= "114";
	        
	    var memoPre1   	= TXT_EM_MEMO_PRE1.text;
	    var memoPre2   	= TXT_EM_MEMO_PRE2.text;
	    var memoPre3   	= TXT_EM_MEMO_PRE3.text;
	    var memoPre4   	= TXT_EM_MEMO_PRE4.text;
	    var memoPre5   	= TXT_EM_MEMO_PRE5.text;
	    
	    goTo       =      "saveData2";
	    parameters =		"&strStrCd="		   +encodeURIComponent(strStrCd)
						  + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	    				  + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
	    				  + "&strGrp1="            +encodeURIComponent(strGrp1)
	    				  + "&strGrp2="            +encodeURIComponent(strGrp2)
	    				  + "&strGrp3="            +encodeURIComponent(strGrp3)
	    				  + "&strGrp4="            +encodeURIComponent(strGrp4)
	    				  + "&strGrp5="            +encodeURIComponent(strGrp5)
	    				  + "&memoPre1="           +encodeURIComponent(memoPre1)
	    				  + "&memoPre2="           +encodeURIComponent(memoPre2)
	    				  + "&memoPre3="           +encodeURIComponent(memoPre3)
	    				  + "&memoPre4="           +encodeURIComponent(memoPre4)
	    				  + "&memoPre5="           +encodeURIComponent(memoPre5)
	    ;
	    TR_DETAIL2.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
	    TR_DETAIL2.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //입력은 I?
	    TR_DETAIL2.Post();    
	    
	    if( TR_DETAIL2.ErrorCode == 50000 || TR_MAIN2.ErrorCode == 50052 ){ // 정상처리 되면 재조회
	    	i = i + 1;
	    }
	    else {
	    	alert("주간주요업무 자료 저장에 실패했습니다!");
	    	return;
	    } 
    }
    
    if (i != 0) {
    	btn_Search();
    }
    
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
        if (isNull(EM_SALE_DT_S2.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출일자"); 
            EM_SALE_DT_S2.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S2.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출일자","8");
            EM_SALE_DT_S2.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S2.text)){
        	showMessage(Information, OK, "USER-1004","매출일자");
            EM_SALE_DT_S2.focus();
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
        if (isNull(EM_SALE_DT_E2.text) ==true ) {
            showMessage(Information, OK, "USER-1003","대비일자"); 
            EM_SALE_DT_E2.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E2.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","대비일자","8");
            EM_SALE_DT_E2.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_E2.text)){
            showMessage(Information, OK, "USER-1004","대비일자");
            EM_SALE_DT_E2.focus();
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
function searchCmpr(gb){

    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strSaleDtS      = "";         //매출일자
    if ( gb == "0") {
        strSaleDtS      = EM_SALE_DT_S.text;         //매출일자
    } 
    else {
        strSaleDtS      = EM_SALE_DT_S2.text;         //매출일자
    }
    
    
    var goTo       = "searchCmprdt" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS);
    
    TR_MAIN.Action="/dps/psal576.ps?goTo="+goTo+parameters;  
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


<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_EMC event=onSuccess>
    for(i=0;i<TR_EMC.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_EMC.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_EMC event=onFail>
    trFailed(TR_EMC.ErrorMsg);
</script>

<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_EMC2 event=onSuccess>
    for(i=0;i<TR_EMC2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_EMC2.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_EMC2 event=onFail>
    trFailed(TR_EMC2.ErrorMsg);
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

  
    EMCreate(); //2 코멘트
    searchMaster2();
    
    EMCreate2(); //3 코멘트
    searchDetail2();
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

    var strCmprdt = searchCmpr("0");
    
    if(strCmprdt == ""){
        EM_SALE_DT_E.text =  addDate('Y',-1, EM_SALE_DT_S.text);
    }
    else{
        EM_SALE_DT_E.text =  strCmprdt;
    }
</script>

<script language=JavaScript for=EM_SALE_DT_S2 event=onKillFocus()>

    //영업조회월
    if (isNull(EM_SALE_DT_S2.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출일자"); 
        EM_SALE_DT_S2.text = varToday;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_SALE_DT_S2.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","매출일자","8");
        EM_SALE_DT_S2.text = varToday;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S2.text) ) {
        showMessage(Information, OK, "USER-1069","매출일자");
        EM_SALE_DT_S2.text = varToday;
        return ;
    }

    var strCmprdt = searchCmpr("1");
    
    if(strCmprdt == ""){
        EM_SALE_DT_E2.text =  addDate('Y',-1, EM_SALE_DT_S2.text);
    }
    else{
        EM_SALE_DT_E2.text =  strCmprdt;
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


<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script> 

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script> 



<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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

<comment id="_NSID_">
<object id="TR_EMC" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_EMC2" classid=<%=Util.CLSID_TRANSACTION%>>
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
                  <td width="210"><comment id="_NSID_"> <object
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
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                   ~
                  	   <comment id="_NSID_"> <object
                     id=EM_SALE_DT_S2 classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S2)" align="absmiddle" /> 
                  </td>
                  <th width = "70"> 단위</th>
				  <td colspan="5">
				     <comment id="_NSID_"> <object	
				     id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	
				     tabindex=1 align="absmiddle"> </object> </comment>	<script>_ws_(_NSID_);</script>
				     ,%
				  </td>
               </tr>
               <tr>
               		<th class="point">대비일자</th>
                  <td colspan="7">
                     <comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  	 <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('G',EM_SALE_DT_E); " align="absmiddle" />
                     ~
                     <comment id="_NSID_"> <object
                     id=EM_SALE_DT_E2 classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  	 <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_SALE_DT_E2.Enable) openCal('G',EM_SALE_DT_E2); " align="absmiddle" />
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
 	<tr>
        <td class="PT01">
        <b><h3>2. 매출실적분석
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table"> 
			   <tr>
				<th width="6%" style = "text-align:center">구분</th>
				<th width="6%" style = "text-align:center">MD</th>
					<td width="44%"  style = "text-align:center">실적분석</td>
					<td width="44%" colspan=7 style = "text-align:center">활성화POINT</td>
			   </tr>
			   <!--  패션  : 6  -->
			   <tr>
				<th width="100" rowspan=6 style = "background-color:#FFD8D8; color : #D9418C; text-align:center" >패션/리빙</th>
				<th width="100" style = "background-color:#FFD8D8; color : #D9418C; text-align:center">패션잡화</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_01 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_01, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_02 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_02, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "background-color:#FFD8D8; color : #D9418C; text-align:center">여성패션</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_11 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_11, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_12 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_12, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "background-color:#FFD8D8; color : #D9418C; text-align:center">남성패션</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_21 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_21, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_22 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_22, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "background-color:#FFD8D8; color : #D9418C; text-align:center">레포츠</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_31 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_31, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_32 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_32, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "background-color:#FFD8D8; color : #D9418C; text-align:center">유아동</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_41 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_41, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_42 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_42, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "background-color:#FFD8D8; color : #D9418C; text-align:center">리빙</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_43 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_43, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_44 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_44, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <!--  리빙  : 2  -->
			   <tr>
				<th width="100" rowspan=2 style = "background-color:#B7F0B1; color : #2F9D27; text-align:center">F&B/서비스</th>
				<th width="100" style = "background-color:#B7F0B1; color : #2F9D27; text-align:center">서비스</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_51 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_51, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_52 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_52, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "background-color:#B7F0B1; color : #2F9D27; text-align:center">F&B</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_61 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_61, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_62 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_62, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <!--  직영  : 3  -->
			   <tr>
				<th width="100" rowspan=3 style = "text-align:center">직영운영</th>
				<th width="100" style = "text-align:center">CGV</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_71 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_71, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_72 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_72, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="100" style = "text-align:center">한샘</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_81 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_81, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td> 
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_82 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_82, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td> 
			   </tr>
			   <tr>
				<th width="100" style = "text-align:center">투썸</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_91 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_91, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td> 
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_92 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 60px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_92, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
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
 	 	<tr>
        <td class="PT01">
        <b><h3>4. 주간주요업무
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table"> 
			   <tr>
				<th width="12%" style = "text-align:center">구분</th>
					<td width="44%"  style = "text-align:center">전주</td>
					<td width="44%" colspan=7 style = "text-align:center">금주</td>
			   </tr>
			   <tr>
				<th width="12%" style = " text-align:center">인사/총무</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_POST1 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_POST1, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_PRE1 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_PRE1, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="12%" style = " text-align:center">경리/회계</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_POST2 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_POST2, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_PRE2 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_PRE2, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="12%" style = " text-align:center">판매기획</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_POST3 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_POST3, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_PRE3 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_PRE3, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="12%" style = "text-align:center">영업</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_POST4 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_POST4, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_PRE4 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_PRE4, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <tr>
				<th width="12%" style = " text-align:center">직영운영</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_POST5 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_POST5, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_PRE5 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_PRE5, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr>
			   <!-- tr>
				<th width="12%" style = "text-align:center">직영운영</th>
					<td colspan=2><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_POST6 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_POST6, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>
					<td colspan=3><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_PRE6 classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_PRE6, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
			   </tr-->
        	</table>
        </td>
    </tr>  
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_IO_DETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value=' 
        <c>Col=TXT_EM_MEMO_POST1   Ctrl=TXT_EM_MEMO_POST1     param=Text</c> 
        <c>Col=TXT_EM_MEMO_PRE1    Ctrl=TXT_EM_MEMO_PRE1      param=Text</c>
        
        <c>Col=TXT_EM_MEMO_POST2   Ctrl=TXT_EM_MEMO_POST2     param=Text</c> 
        <c>Col=TXT_EM_MEMO_PRE2    Ctrl=TXT_EM_MEMO_PRE2      param=Text</c>
        
        <c>Col=TXT_EM_MEMO_POST3   Ctrl=TXT_EM_MEMO_POST3     param=Text</c> 
        <c>Col=TXT_EM_MEMO_PRE3    Ctrl=TXT_EM_MEMO_PRE3      param=Text</c>
        
        <c>Col=TXT_EM_MEMO_POST4   Ctrl=TXT_EM_MEMO_POST4     param=Text</c> 
        <c>Col=TXT_EM_MEMO_PRE4    Ctrl=TXT_EM_MEMO_PRE4      param=Text</c>
        
        <c>Col=TXT_EM_MEMO_POST5   Ctrl=TXT_EM_MEMO_POST5     param=Text</c> 
        <c>Col=TXT_EM_MEMO_PRE5    Ctrl=TXT_EM_MEMO_PRE5      param=Text</c>

        '>
</object>
</comment> 
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value=' 
        <c>Col=TXT_EM_MEMO_01   Ctrl=TXT_EM_MEMO_01     param=Text</c> 
        <c>Col=TXT_EM_MEMO_02   Ctrl=TXT_EM_MEMO_02     param=Text</c>
         
        <c>Col=TXT_EM_MEMO_11   Ctrl=TXT_EM_MEMO_11     param=Text</c> 
        <c>Col=TXT_EM_MEMO_12   Ctrl=TXT_EM_MEMO_12     param=Text</c>
        		        
        <c>Col=TXT_EM_MEMO_21   Ctrl=TXT_EM_MEMO_21     param=Text</c> 
        <c>Col=TXT_EM_MEMO_22   Ctrl=TXT_EM_MEMO_22     param=Text</c>
        
        <c>Col=TXT_EM_MEMO_31   Ctrl=TXT_EM_MEMO_31     param=Text</c> 
        <c>Col=TXT_EM_MEMO_32   Ctrl=TXT_EM_MEMO_32     param=Text</c>

        <c>Col=TXT_EM_MEMO_41   Ctrl=TXT_EM_MEMO_41     param=Text</c> 
        <c>Col=TXT_EM_MEMO_42   Ctrl=TXT_EM_MEMO_42     param=Text</c>
        
        <c>Col=TXT_EM_MEMO_43   Ctrl=TXT_EM_MEMO_43     param=Text</c> 
        <c>Col=TXT_EM_MEMO_44   Ctrl=TXT_EM_MEMO_44     param=Text</c>

        <c>Col=TXT_EM_MEMO_51   Ctrl=TXT_EM_MEMO_51     param=Text</c> 
        <c>Col=TXT_EM_MEMO_52   Ctrl=TXT_EM_MEMO_52     param=Text</c>
        
        <c>Col=TXT_EM_MEMO_61   Ctrl=TXT_EM_MEMO_61     param=Text</c> 
        <c>Col=TXT_EM_MEMO_62   Ctrl=TXT_EM_MEMO_62     param=Text</c>
        
        <c>Col=TXT_EM_MEMO_71   Ctrl=TXT_EM_MEMO_71     param=Text</c> 
        <c>Col=TXT_EM_MEMO_72   Ctrl=TXT_EM_MEMO_72     param=Text</c>
        
        <c>Col=TXT_EM_MEMO_81   Ctrl=TXT_EM_MEMO_81     param=Text</c> 
        <c>Col=TXT_EM_MEMO_82   Ctrl=TXT_EM_MEMO_82     param=Text</c>
        
        <c>Col=TXT_EM_MEMO_91   Ctrl=TXT_EM_MEMO_91     param=Text</c> 
        <c>Col=TXT_EM_MEMO_92   Ctrl=TXT_EM_MEMO_92     param=Text</c>
        
        '>
</object>
</comment> 
<script>_ws_(_NSID_);</script>
</div>
<body>
</html>
