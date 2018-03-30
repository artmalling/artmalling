<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal2150.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 기간별실적
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
 var top = 420;		//해당화면의 동적그리드top위치
 var CUR_GR;
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');   
    
	// 컴퍼넌트 세팅
    initEmEdit(EM_SALE_DT_S,      "YYYYMMDD", PK);   // 실적 시작일
    initEmEdit(EM_SALE_DT_E,      "YYYYMMDD", PK);   // 실적 종료일
    initEmEdit(EM_BF_SALE_DT_S,   "YYYYMMDD", PK);   // 대비 시작일
    initEmEdit(EM_BF_SALE_DT_E,   "YYYYMMDD", PK);   // 대비 종료일
	//initEmEdit(EM_SALE_M,         "YYYYMM",	  PK);	 // 매출월
	//initEmEdit(EM_BF_SALE_M,      "YYYYMM",	  PK);	 // 대비월
	
    initEmEdit(EM_PUMBUN_CD,   "CODE^6^0", NORMAL);          //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN^40",   READ);            //브랜드(조회)

    // 콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD,   "CODE^0^30,NAME^0^140", 1, PK);		// 점(조회)
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80",  1, NORMAL);	// 팀(조회)
    //initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80",  1, NORMAL);	// 파트(조회)
    //initComboStyle(LC_PC_CD,DS_PC_CD,     "CODE^0^30,NAME^0^80",  1, NORMAL);	// PC(조회)

    //현재년도 셋팅
    EM_SALE_DT_S.alignment = 1;
    EM_SALE_DT_E.alignment = 1;
    // 실적
    EM_SALE_DT_S.text    = varToMon+"01";
    EM_SALE_DT_E.text    = varToday;
    //EM_SALE_M.text       = varToMon;
    
    /*
    // 대비
    EM_BF_SALE_DT_S.text = addDate("m", -1, varToMon+"01");
    EM_BF_SALE_DT_E.text = addDate("m", -1, varToday);
    EM_BF_SALE_M.text    = addDate("m", -1, varToMon+"01");
	*/
	
    /* 아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02 */
    EM_BF_SALE_DT_S.text = getBeforeYearDay(EM_SALE_DT_S.text );
    EM_BF_SALE_DT_E.text = getBeforeYearDay(EM_SALE_DT_E.text );
    //EM_BF_SALE_M.text    = varBf_Year_Mon;
    
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;
    //alert(strOrgFlag);
    getStore2("DS_STR_CD", "Y", "", "Y", strOrgFlag);                                             	// 점   
    //getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                        	// 팀
    getEtcCode("DS_DEPT_CD"    , "D", "D216", "Y"); 																		//팀
    //getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); 	// 파트    
    //getPc2("DS_PC_CD", "Y",     LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC  
    LC_STR_CD.BindColVal  = strcd;   
    LC_DEPT_CD.Index = 0;
    //LC_TEAM_CD.Index = 0;
    //LC_PC_CD.Index   = 0;
    
	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    orgFlagCheck(orgFlag);
    CUR_GR = GD_MASTER;
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    RD_GUBUN.CodeValue = "1";
    RD_GROUP.CodeValue = "3";
    
	EM_SALE_DT_S.Enable    = true;
	EM_SALE_DT_E.Enable    = true;
	EM_BF_SALE_DT_S.Enable = true;
	EM_BF_SALE_DT_E.Enable = true;
	//EM_SALE_M.Enable       = false;
	//EM_BF_SALE_M.Enable    = false;
	
	document.getElementById("RD_GROUP").style.display = "none";
	//document.getElementById("EM_SALE_FLAG").style.display = "none";
	
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2("1"); //DETAIL
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal215","DS_O_MASTER" );
}

// 마스터
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
			         + '<FC>id=STR_CD                 name="점"           width=80    align=left      suppress=1 EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME" </FC>'
			         + '<G> name="파트"'
			         + '<FC>id=PRT_NM                 name=""           width=100   align=left      </FC>'
			         + '<FC>id=FLOR_NM                 name="층"           width=100   align=left      </FC>'
			         + '</G>'
			         + '<G> name="매출"'
				     + '<FC>id=PRO_AMT			      name="목표"         width=100   align=right     mask="###,###"   </FC>'
				     + '<FC>id=SALE_AMT		          name="(실적)매출"   width=100   align=right     mask="###,###"   </FC>'
				     + '<FC>id=SALE_RATIO             name="달성율"       width=60    align=right     mask="#,###.00"  </FC>'
				     + '<FC>id=BF_AMT		          name="(대비)매출"   width=100   align=right     mask="###,###"   </FC>'
				     + '<FC>id=BF_RATIO		          name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
				     + '</G>'
				     + '<G> name="이익"'
				     + '<FC>id=PROF_AMT     		  name="실적"         width=100   align=right     mask="###,###"   </FC>'
				     + '<FC>id=BF_PROF_AMT       name="대비"         width=100   align=right     mask="###,###"    </FC>'
				     + '<FC>id=BF_PROF_ACHIV_RATIO         name="신장율"       width=60    align=right     mask="#,###.00"   </FC>'
				     + '</G>'
				     + '<G> name="이익율비교"'
				     + '<G> name="이익율"'
				     + '<FC>id=PROF_RATIO             name="실적"         width=60    align=right     mask="#,###.00"  </FC>'
				     + '<FC>id=BF_PROF_RATIO          name="대비"         width=60    align=right     mask="#,###.00"   </FC>'
				     + '</G>'
				     + '<G> name="고객수"'
				     + '<FC>id=CUST_CNT               name="실적"         width=60    align=right     mask="#,###.00"  </FC>'
				     + '<FC>id=BF_CUST_CNT            name="대비"         width=60    align=right     mask="#,###.00"  </FC>'
				     + '<FC>id=BF_CUST_RATIO     name="신장율"       width=60    align=right   	  mask="#,###.00"   </FC>'
				     + '</G>'
				     + '<G> name="객단가"'
				     + '<FC>id=CUST_DANGA             name="실적"         width=100   align=right     mask="###,###"   </FC>'
				     + '<FC>id=BF_CUST_DANGA          name="대비"         width=100   align=right     mask="###,###"   </FC>'
				     //+ '<FC>id=CUST_DANGA_ACHV_RATE   name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
				     + '</G>'
			         + '<C>id=PRT_CD               name="브랜드"       width=90    align=right     Show=false   </C>'
			        ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

//  디테일
function gridCreate2(strGrpCd){
	
	var strGrpNm = "";
	if(strGrpCd == "1"){		// PC
		strGrpNm = "PC";
	}else if(strGrpCd == "2"){	// 코너
		strGrpNm = "코너";
	}else if(strGrpCd == "3"){	// 브랜드
		strGrpNm = "브랜드";
	}
	
	var hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center  BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        + '<G> name="파트"'
			        + '<FC>id=PRT_NM                 name="명"           width=100   align=left    BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        + '</G>'
			        + '<G> name="브랜드"'
			        + '<FC>id=PUMBUN_CD                 name="코드"           width=70  align=left     BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=PUMBUN_NAME               name="명"             width=150   align=left   BgColor={decode(EVENT_FLAG,"","#FFFACD")}   </FC>'
			        + '<FC>id=EVENT_FLAG                name="마진구분"        width=70   align=left    BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        + '</G>'
			        + '<G> name="매출"'
			        + '<FC>id=PRO_AMT			      name="목표"         width=100   align=right     mask="###,###"  BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=SALE_AMT		          name="(실적)매출"   width=100   align=right     mask="###,###"  BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=SALE_RATIO             name="달성율"       width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_AMT		          name="(대비)매출"   width=100   align=right     mask="###,###"  BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_RATIO		          name="신장율"       width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '</G>'
			        + '<G> name="이익"'
			        + '<FC>id=PROF_AMT     		  name="실적"         width=100   align=right     mask="###,###"  BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_PROF_AMT       name="대비"         width=100   align=right     mask="###,###"  BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        + '<FC>id=BF_PROF_ACHIV_RATIO         name="신장율"       width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        + '</G>'
			        + '<G> name="이익율비교"'
			        + '<G> name="이익율"'
			        + '<FC>id=PROF_RATIO             name="실적"         width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_PROF_RATIO          name="대비"         width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        + '</G>'
			        + '<G> name="고객수"'
			        + '<FC>id=CUST_CNT               name="실적"         width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_CUST_CNT            name="대비"         width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_CUST_RATIO     name="신장율"       width=60    align=right   	  mask="#,###.00"  BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '</G>'
			        + '<G> name="객단가"'
			        + '<FC>id=CUST_DANGA             name="실적"         width=100   align=right     mask="###,###"  BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '<FC>id=BF_CUST_DANGA          name="대비"         width=100   align=right     mask="###,###" BgColor={decode(EVENT_FLAG,"","#FFFACD")}  </FC>'
			        //+ '<FC>id=CUST_DANGA_ACHV_RATE   name="신장율"       width=60    align=right     mask="#,###.00" BgColor={decode(EVENT_FLAG,"","#FFFACD")} </FC>'
			        + '</G>'
			        //+ '<C>id=ORDER_FLAG              name="정렬순번"     width=90    align=right     Show=false   </C>'
				   ;
			        

initGridStyle(GD_DETAIL, "common", hdrProperies, false);
}

<!-- 매장으로 접근시 에는 매장 매입이 Enable 되고 매입 접근시 Disable 된다 -->
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
    DS_O_DETAIL.ClearData();
    
    if(!chkValidation("search")) return;
    var strOrgFlag=EM_ORG_FLAG.CodeValue;
	//var strSaleFlag  = EM_SALE_FLAG.CodeValue;
	
    var strSaleDtS   = "";	              // (실적)시작년월
    var strSaleDtE   = "";	              // (실적)종료년월
    var strBfSaleDtS = "";	              // (대비)시작년월
    var strBfSaleDtE = "";	              // (대비)종료년월
    
	//if(strSaleFlag == "1"){	// 기간
	    strSaleDtS   = EM_SALE_DT_S.Text;   
	    strSaleDtE   = EM_SALE_DT_E.Text;   
	    strBfSaleDtS = EM_BF_SALE_DT_S.Text;
	    strBfSaleDtE = EM_BF_SALE_DT_E.Text;
	//}else{					// 월
		/*
	    strSaleDtS   = EM_SALE_M.Text + "01";							// 해당월의 첫째날
	    strSaleDtE   = addDate("d", -1, addDate("m", 1, strSaleDtS));	// 해당월의 마지막날
	    strBfSaleDtS = addDate("m", -1, strSaleDtS);					// 대비시작일 = (실적월+01) - 1개월
	    strBfSaleDtE = addDate("d", -1, strSaleDtS);					// 대비시작일 = (실적월+01) - 1개월
	    strSaleDtE   = strSaleDtE.replace(/\-/g,'');
	    
	    strBfSaleDtS = strBfSaleDtS.replace(/\-/g,'');
	    strBfSaleDtE = strBfSaleDtE.replace(/\-/g,'');
	    */
	    
	    /* 매출월 */
	    //strSaleDtS     = EM_SALE_M.Text + "01";							// 해당월의 첫째날
	    //strSaleDtE     = addDate("d", -1, addDate("m", 1, strSaleDtS));	// 해당월의 마지막날
	    //strSaleDtE     = strSaleDtE.replace(/\-/g,'');
	    /* 대비월 */
	    //strBfSaleDtS   = EM_BF_SALE_M.Text + "01";							// 해당월의 첫째날
	    //strBfSaleDtE   = addDate("d", -1, addDate("m", 1, strBfSaleDtS));	// 해당월의 마지막날
	    //strBfSaleDtE   = strBfSaleDtE.replace(/\-/g,'');
	//}
    
    var strStrCd        = LC_STR_CD.BindColVal;      // 점
    var strTeamCd       = LC_DEPT_CD.BindColVal;     // 팀
    //var strPartCd       = LC_TEAM_CD.BindColVal;     // 파트
    //var strPcCd         = LC_PC_CD.BindColVal;       // PC
    var strBrandCd      = EM_PUMBUN_CD.text;         // 브랜드코드
    var strSelFlag      = RD_GUBUN.CodeValue;        // 원단위 구분

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strTeamCd="    + encodeURIComponent(strTeamCd)
                   //+ "&strPartCd="    + encodeURIComponent(strPartCd)
                   //+ "&strPcCd="      + encodeURIComponent(strPcCd)
				   + "&strSaleDtS="   + encodeURIComponent(strSaleDtS)
				   + "&strSaleDtE="   + encodeURIComponent(strSaleDtE)
				   + "&strBfSaleDtS=" + encodeURIComponent(strBfSaleDtS)
				   + "&strBfSaleDtE=" + encodeURIComponent(strBfSaleDtE)
                   + "&strOrgFlag="   + encodeURIComponent(strOrgFlag)
                   + "&strBrandCd="   + encodeURIComponent(strBrandCd)
                   + "&strSelFlag="   + encodeURIComponent(strSelFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal215.ps?goTo="+goTo+parameters;  
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
	 
	var objGrd = "";
	var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    var strSaleDt    = "";	              // (실적)매출기간
    var strBfSaleDt  = "";	              // (대비)대비기간
    var str_Dt_M     = "";	              // 매출기간 or 매출월           
    var str_BF_Dt_M  = "";                // 매출기간 or 매출월
    var strTitle = "총괄매출현황(파트)";
    //var strRdGubun   = "";
    
	if(rtnVal == "1"){
		objGrd = GD_MASTER;
	}else if(rtnVal == "2"){
		objGrd = GD_DETAIL;
		strTitle = strTitle + "_상세"
	}else{
		return;
	}
	
	//기간 구분 ((  1:매출기간 2:매출월 ))
	/*
	if(EM_SALE_FLAG.CodeValue == "1"){
		//매출기간
		strSaleDt   = EM_SALE_DT_S.Text    + " ~ " + EM_SALE_DT_E.Text ;
		strBfSaleDt = EM_BF_SALE_DT_S.Text + " ~ " + EM_BF_SALE_DT_E.Text;
		str_Dt_M    = "매출기간 ";
		str_BF_Dt_M = "대비기간 ";
	}else{
		//매출월
		strSaleDt   = EM_SALE_M.Text;
		strBfSaleDt = EM_BF_SALE_M.Text;
		str_Dt_M    = "매출월 ";
		str_BF_Dt_M = "대비월 ";
	}
	*/
	
	//원단위 구분 1:원 , 1000:천원
 	
	if(RD_GUBUN.CodeValue == "1"){
 		strRdGubun = " 원";
	}else{
		strRdGubun = " 천원";
	}
	
	strSaleDt   = EM_SALE_DT_S.Text    + " ~ " + EM_SALE_DT_E.Text ;
	strBfSaleDt = EM_BF_SALE_DT_S.Text + " ~ " + EM_BF_SALE_DT_E.Text;
	str_Dt_M    = "매출기간 ";
	str_BF_Dt_M = "대비기간 ";
	
	
	
	var parameters = "점 "         + LC_STR_CD.Text
				   + ",  팀  "      + LC_DEPT_CD.Text
				   //+ ",  파트  "     + LC_TEAM_CD.Text
				   //+ ",  PC  "    + LC_PC_CD.Text
				   //+ ",  원단위   "   + strRdGubun
				   + ",  브랜드   "   + EM_PUMBUN_NAME.Text
				   + ',  "'       + str_Dt_M + '"    ' + strSaleDt
				   + ',  "'       + str_BF_Dt_M + '" ' + strBfSaleDt;

	

	//objGrd.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
	CUR_GR.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
	
	//openExcel2(objGrd, strTitle, parameters, true);
	openExcel5(objGrd, strTitle, parameters, true, "",g_strPid );
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
	 
	 	if(DS_O_MASTER.CountRow <= 0) return false;
	 
		//gridCreate2(RD_GROUP.CodeValue);

		//var strSaleFlag  = EM_SALE_FLAG.CodeValue;
	    var strSaleDtS   = "";	              // (실적)시작년월
	    var strSaleDtE   = "";	              // (실적)종료년월
	    var strBfSaleDtS = "";	              // (대비)시작년월
	    var strBfSaleDtE = "";	              // (대비)종료년월
	    
		//if(strSaleFlag == "1"){	// 기간
		    strSaleDtS   = EM_SALE_DT_S.Text;   
		    strSaleDtE   = EM_SALE_DT_E.Text;   
		    strBfSaleDtS = EM_BF_SALE_DT_S.Text;
		    strBfSaleDtE = EM_BF_SALE_DT_E.Text;
		    
		//}else{					// 월
			/*
		    strSaleDtS   = EM_SALE_M.Text + "01";							// 해당월의 첫째날
		    strSaleDtE   = addDate("d", -1, addDate("m", 1, strSaleDtS));	// 해당월의 마지막날
		    strBfSaleDtS = addDate("m", -1, strSaleDtS);					// 대비시작일 = (실적월+01) - 1개월
		    strBfSaleDtE = addDate("d", -1, strSaleDtS);					// 대비시작일 = (실적월+01) - 1개월
		    strSaleDtE   = strSaleDtE.replace(/\-/g,'');
		    
		    strBfSaleDtS = strBfSaleDtS.replace(/\-/g,'');
		    strBfSaleDtE = strBfSaleDtE.replace(/\-/g,'');
		    */
		    
		    /* 매출월 */
		    //strSaleDtS     = EM_SALE_M.Text + "01";							// 해당월의 첫째날
		//    strSaleDtE     = addDate("d", -1, addDate("m", 1, strSaleDtS));	// 해당월의 마지막날
		//    strSaleDtE     = strSaleDtE.replace(/\-/g,'');
		    /* 대비월 */
		    //strBfSaleDtS   = EM_BF_SALE_M.Text + "01";							// 해당월의 첫째날
		//    strBfSaleDtE   = addDate("d", -1, addDate("m", 1, strBfSaleDtS));	// 해당월의 마지막날
		//    strBfSaleDtE   = strBfSaleDtE.replace(/\-/g,'');
		//}
	    
		
	    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");		//점
	    var strSearchCd  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PRT_CD");		//파트
	    var strFloorCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "FLOR_CD");		//층
	    //var strGrpCd     = RD_GROUP.CodeValue;			// 조회구분
	    var strBrandCd   = EM_PUMBUN_CD.text;
	    var strSelFlag   = RD_GUBUN.CodeValue;        // 원단위 구분
	    
	    /*
	    if(strSearchCd.length == 2 || LC_PC_CD.BindColVal != "%"){
	    	strSearchCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD")
			            + LC_DEPT_CD.BindColVal
			            //+ LC_TEAM_CD.BindColVal
			            //+ LC_PC_CD.BindColVal
			            ;
	    }
	    */
	    
 	    //alert("strSearchCd = " + strSearchCd);
	    
	    var goTo       = "searchDetail" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
	                   + "&strSearchCd="  + encodeURIComponent(strSearchCd)
	                   + "&strSaleDtS="   + encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="   + encodeURIComponent(strSaleDtE)
	                   + "&strBfSaleDtS=" + encodeURIComponent(strBfSaleDtS)
	                   + "&strBfSaleDtE=" + encodeURIComponent(strBfSaleDtE)
	                   //+ "&strGrpCd="     + encodeURIComponent(strGrpCd)
	                   + "&strBrandCd="   + encodeURIComponent(strBrandCd)
	                   + "&strSelFlag="   + encodeURIComponent(strSelFlag)
	                   + "&strFloorCd="   + encodeURIComponent(strFloorCd)
	                   ;
     
     TR_DETAIL.Action="/dps/psal215.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);

     //스크롤바 위치 조정
//      GD_DETAIL.SETVSCROLLING(0);
//      GD_DETAIL.SETHSCROLLING(0);
 }


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

        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }
        

        //PC가 전체가 이닐경우 파트 체크
//        if(LC_PC_CD.BindColVal != "%" && LC_TEAM_CD.BindColVal == "%"){
//            showMessage(Information, OK, "USER-1003","파트");
//            LC_TEAM_CD.focus();
//            return false;
//        }
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
        
        if(!isBetweenFromTo(EM_SALE_DT_S.text, EM_SALE_DT_E.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_SALE_DT_S.focus();
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
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
    var varbfYear= now.getYear()-1; //전년도
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
    var	varBf_Year_Mon = varbfYear.toString()+ mon;
</script>
<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_ORG_FLAG event=OnSelChange()>
	if(EM_ORG_FLAG.CodeValue=="1"){
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
		getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점	    
		//getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀
		getEtcCode("DS_DEPT_CD"    , "D", "D216", "Y"); 																		//팀
	    //getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    //getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal=strcd;
	    LC_DEPT_CD.Index = 0;
	    //LC_TEAM_CD.Index = 0;
	    //LC_PC_CD.Index   = 0; 
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);     
	    //getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀
	    getEtcCode("DS_DEPT_CD"    , "D", "D216", "Y"); 																		//팀
	    //getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    //getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
	     
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    //LC_TEAM_CD.Index = 0;
	    //LC_PC_CD.Index   = 0;
	}
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;	
	//getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀
	getEtcCode("DS_DEPT_CD"    , "D", "D216", "Y"); 																		//팀
	//getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	//getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC 
    //LC_DEPT_CD.Index = 0;
    //LC_TEAM_CD.Index = 0;
    //LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
    if(LC_DEPT_CD.BindColVal != "%"){
    	//getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트   
    }else{
        //DS_TEAM_CD.ClearData();
        //insComboData( LC_TEAM_CD, "%", "전체",1);
        //DS_PC_CD.ClearData();
        //insComboData( LC_PC_CD, "%", "전체",1);
    }
    //LC_TEAM_CD.Index = 0;
</script>



<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT_S.text = varToMon+"01";
        return false;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT_S.text = varToMon+"01";
        return false;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT_S.text = varToMon+"01";
        return false;
    }
return true;
</script>

<!-- 매출종료일 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","종료일자"); 
        EM_SALE_DT_E.text = varToday;
        return false;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","종료일자","8");
        EM_SALE_DT_E.text = varToday;
        return false;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","종료일자");
        EM_SALE_DT_E.text = varToday;
        return false;
    }
return true;
</script>

<!-- 브랜드코드 변경시 -->   
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
	if (EM_PUMBUN_CD.Text == "") EM_PUMBUN_NAME.Text = "";
	//var strTeamCd = "";
	//var strPcCd   = "";
	/*
	if(LC_TEAM_CD.BindColVal == "%"){
		strTeamCd = "00";
	}
	else{
		strTeamCd = LC_TEAM_CD.BindColVal;
	}
	if(LC_PC_CD.BindColVal == "%"){
		strPcCd = "00";
	}
	else{
		strPcCd = LC_PC_CD.BindColVal;
	}
	
	var strOrgCd = LC_STR_CD.bindcolval + LC_DEPT_CD.BindColVal + strTeamCd + strPcCd + "00";
	*/
	if(EM_PUMBUN_CD.text.length != 0){    
	    setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", EM_PUMBUN_CD, EM_PUMBUN_NAME, 'Y', '1','',LC_STR_CD.bindcolval);
	}
	
</script>

<script language=JavaScript for=RD_GROUP event=OnClick()>
	searchDetail();
</script>
<!-- 조직 구분  변경시  -->



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
                  <th width="70">조직구분</th>
                  <td width="105"  colspan="7">
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
                  <td width="105" ><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80">브랜드</th>
	               <td colspan="2"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
	                   classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
	                   align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
	                   src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
	                   onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"
	                   align="absmiddle" /> <comment id="_NSID_"> <object
	                   id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
	                   align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
	               </td>
                  
               </tr>
               <tr>
                  
                  <th width="60px" class="point">매출기간</th>
                  <td width="210px"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT_S);" align="absmiddle" />~
					<comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT_E);" align="absmiddle" />
                  </td>
                  <th class="point">대비기간</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_BF_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_BF_SALE_DT_S" onclick="javascript:openCal('G',EM_BF_SALE_DT_S);" align="absmiddle" />~
                     <comment id="_NSID_"> <object
                     id=EM_BF_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_BF_SALE_DT_E" onclick="javascript:openCal('G',EM_BF_SALE_DT_E);" align="absmiddle" />
                  </td>
                   <th>원단위구분</th>
					<td style="border-right:0px" colspan="2">
						<comment id="_NSID_"> 
							<object id="RD_GUBUN" classid="<%=Util.CLSID_RADIO%>" width=90 height=18 align="absmiddle">
								<param name="Cols"   value="2">
								<param name="Format" value="1^원,1000^천원">
							</object> 
						</comment><script>_ws_(_NSID_);</script>    
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
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
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
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th width="100px">상세</th>
						<td style="border-right:0px">
							<comment id="_NSID_"> 
								<object id="RD_GROUP" classid="<%=Util.CLSID_RADIO%>" width=180 height=18 align="absmiddle">
									<param name="Cols"   value="3">
									<param name="Format" value="1^PC,2^코너,3^브랜드">
								</object> 
							</comment><script>_ws_(_NSID_);</script>
							<font color=red> * 이익율은 VAT 제외 금액입니다.</font>    
						</td>  
					</tr>
				</table>
			</td>
		</tr>
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL width=100% height=222 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_DETAIL">
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
