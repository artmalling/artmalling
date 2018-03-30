<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.04.29
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 결제형태별매출실적
 * 이    력 :2010.04.29 박종은
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

var top = 140;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID

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

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //대비일자
    EM_SALE_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToMon+"01";

    EM_SALE_DT_E.text =  varToday;
    

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
    registerUsingDataset("psal407","DS_O_MASTER" );
    
}

function gridCreate1(){
	var strGbn  = RD_CRATE_FLAG.CodeValue;
	var strDisp = RD_DISP_FLAG.CodeValue;
	var strA   = 0;
	var hdrProperies;
	
	if (strDisp == "0") {
	
        hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
                     + '<FC>id=ORG_CD                 name="조직코드"       width=90    align=center   </FC>'
                     + '<FC>id=ORG_NAME               name="조직명"         width=120    align=left  sumtext="합계"  </FC>'
                     + '<FC>id=TOTAL                   name="합계"          width=100    align=right  gte_columntype="number:0:true" gte_Summarytype="number:0:true"	  mask="###,###"     sumtext={subsum(TOTAL)}</FC>'
                     + '<G>                           name="현금매출"'
                     + '<C>id=CASH_AMT                name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	 mask="###,###"     sumtext={subsum(CASH_AMT)}</C>'
                     + '<C>id=CASH_CRATE              name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(CASH_CRATE), subsum(CASH_AMT)/subsum(TOTAL)*100) }</C>'
                     + '</G>'
                     + '<G>                           name="제휴카드"'
                     + '<C>id=JCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	 mask="###,###"     sumtext={subsum(JCARD_AMT)}</C>'
                     + '<C>id=JCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(JCARD_CRATE), subsum(JCARD_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="신용카드"'
                     + '<C>id=OCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(OCARD_AMT)}</C>'
                     + '<C>id=OCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(OCARD_CRATE), subsum(OCARD_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="직불매출"'
                     + '<C>id=DCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(DCARD_AMT)}</C>'
                     + '<C>id=DCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(DCARD_CRATE), subsum(DCARD_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="은련매출"'
                     + '<C>id=CCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(CCARD_AMT)}</C>'
                     + '<C>id=CCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(CCARD_CRATE), subsum(CCARD_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="고객포인트"'
                     + '<C>id=POINT_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(POINT_AMT)}</C>'
                     + '<C>id=POINT_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(POINT_CRATE), subsum(POINT_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="자사상품권"'
                     + '<C>id=GIFT_DRAWL_AMT          name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(GIFT_DRAWL_AMT)}</C>'
                     + '<C>id=GIFT_CRATE              name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(GIFT_CRATE), subsum(GIFT_DRAWL_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="제휴상품권"'
                     + '<C>id=JGIFT_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(JGIFT_AMT)}</C>'
                     + '<C>id=JGIFT_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(JGIFT_CRATE), subsum(JGIFT_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="타사상품권"'
                     + '<C>id=OGIFT_DRAWL_AMT         name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(OGIFT_DRAWL_AMT)}</C>'
                     + '<C>id=OGIFT_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(OGIFT_CRATE), subsum(OGIFT_DRAWL_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="임대외상매출"'
                     + '<C>id=CREDIT_SALE_AMT         name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(CREDIT_SALE_AMT)}</C>'
                     + '<C>id=CREDIT_SALE_CRATE       name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(CREDIT_SALE_CRATE), subsum(CREDIT_SALE_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     + '<G>                           name="기타매출"'
                     + '<C>id=GITA_AMT                name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(GITA_AMT)}</C>'
                     + '<C>id=GITA_CRATE              name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(GITA_CRATE), subsum(GITA_AMT)/subsum(TOTAL)*100)}</C>'
                     + '</G>'
                     ;
        
	} else {
        hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
		        	+ '<FC>id=SALE_DT                name="매출일자"       width=90    align=center   mask="XXXX/XX/XX"</FC>'
		            + '<FC>id=ORG_CD                 name="조직코드"       width=90    align=center   </FC>'
		            + '<FC>id=ORG_NAME               name="조직명"         width=80    align=left  sumtext="합계"  </FC>'
		            + '<FC>id=TOTAL                   name="합계"          width=100    align=right  gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(TOTAL)}</FC>'
		            + '<G>                           name="현금매출"'
		            + '<C>id=CASH_AMT                name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(CASH_AMT)}</C>'
		            + '<C>id=CASH_CRATE              name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(CASH_CRATE), subsum(CASH_AMT)/subsum(TOTAL)*100) }</C>'
		            + '</G>'
		            + '<G>                           name="제휴카드"'
		            + '<C>id=JCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(JCARD_AMT)}</C>'
		            + '<C>id=JCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(JCARD_CRATE), subsum(JCARD_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="신용카드"'
		            + '<C>id=OCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(OCARD_AMT)}</C>'
		            + '<C>id=OCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(OCARD_CRATE), subsum(OCARD_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="직불매출"'
		            + '<C>id=DCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(DCARD_AMT)}</C>'
		            + '<C>id=DCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(DCARD_CRATE), subsum(DCARD_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="은련매출"'
		            + '<C>id=CCARD_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(CCARD_AMT)}</C>'
		            + '<C>id=CCARD_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(CCARD_CRATE), subsum(CCARD_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="고객포인트"'
		            + '<C>id=POINT_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(POINT_AMT)}</C>'
		            + '<C>id=POINT_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(POINT_CRATE), subsum(POINT_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="자사상품권"'
		            + '<C>id=GIFT_DRAWL_AMT          name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(GIFT_DRAWL_AMT)}</C>'
		            + '<C>id=GIFT_CRATE              name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(GIFT_CRATE), subsum(GIFT_DRAWL_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="제휴상품권"'
		            + '<C>id=JGIFT_AMT               name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(JGIFT_AMT)}</C>'
		            + '<C>id=JGIFT_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(JGIFT_CRATE), subsum(JGIFT_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="타사상품권"'
		            + '<C>id=OGIFT_DRAWL_AMT         name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(OGIFT_DRAWL_AMT)}</C>'
		            + '<C>id=OGIFT_CRATE             name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(OGIFT_CRATE), subsum(OGIFT_DRAWL_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="임대외상매출"'
		            + '<C>id=CREDIT_SALE_AMT         name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(CREDIT_SALE_AMT)}</C>'
		            + '<C>id=CREDIT_SALE_CRATE       name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(CREDIT_SALE_CRATE), subsum(CREDIT_SALE_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            + '<G>                           name="기타매출"'
		            + '<C>id=GITA_AMT                name="실적"          width=100    align=right   gte_columntype="number:0:true" gte_Summarytype="number:0:true"  mask="###,###"     sumtext={subsum(GITA_AMT)}</C>'
		            + '<C>id=GITA_CRATE              name="구성비"        width=60    align=right   gte_columntype="number:2:true" gte_Summarytype="number:2:true"  mask="#,###.00"    sumtext={if('+strGbn +'=='+strA+' , subsum(GITA_CRATE), subsum(GITA_AMT)/subsum(TOTAL)*100)}</C>'
		            + '</G>'
		            ;
	}

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
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
    gridCreate1();
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    var strDisp         = RD_DISP_FLAG.CodeValue;    //조회구분
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strDisp="            +encodeURIComponent(strDisp)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal407.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    GD_MASTER.ReDraw = false;
    ln_sum();
    GD_MASTER.ReDraw = true;

    if(strTeamCd == "%" && strPCCd == "%" && strDeptCd == "%"){
        GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
        GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
    }
    else{
        if(strTeamCd == "%" && strPCCd == "%" && strDeptCd != "%"){
            GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
            GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
        }
        else{
            if(strTeamCd != "%" && strPCCd == "%"  && !strDeptCd == "%"){
                GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
                GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
            }
            else{
                if(strTeamCd != "%" && strPCCd != "%" && strDeptCd != "%"){
                    GD_MASTER.ColumnProp("ORG_CD", "name")   = "브랜드코드"
                    GD_MASTER.ColumnProp("ORG_NAME", "name") = "브랜드명"
                }
            }
        }
    }
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
    var strTitle = "결제형태별매출실적";

    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPCCd         = LC_PC_CD.Text;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작년월
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료년월
    
    var parameters = "점 "           + strStrCd
                   + " ,   팀 "     + strDeptCd
                   + " ,   파트 "       + strTeamCd
                   + " ,   PC "      + strPCCd
                   + " ,   매출기간 "  + strSaleDtS
                   + " ~ " + strSaleDtE;
    
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
 * ln_sum()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  구성비, 신장율, 증감 계산
 * return값 : void
 */
function ln_sum(){
    var strCashAmtT   = 0;
    var strJCardAmtT  = 0;
    var strOCardAmtT  = 0;
    var strDCardAmtT  = 0;

    var strCCardAmtT  = 0;
    var strPointAmtT  = 0;
    var strGiftAmtT   = 0;
    var strJGitfAmtT  = 0;
    var strOGift_AmtT = 0;
    var strGita_AmtT  = 0;
    var strCreditSale_AmtT  = 0;

    for(i=1; i <= DS_O_MASTER.CountRow; i++){
        strCashAmtT        += DS_O_MASTER.NameValue(i, "CASH_AMT");
        strJCardAmtT       += DS_O_MASTER.NameValue(i, "JCARD_AMT");
        strOCardAmtT       += DS_O_MASTER.NameValue(i, "OCARD_AMT");
        strDCardAmtT       += DS_O_MASTER.NameValue(i, "DCARD_AMT");
        strCCardAmtT       += DS_O_MASTER.NameValue(i, "CCARD_AMT");
        strPointAmtT       += DS_O_MASTER.NameValue(i, "POINT_AMT");
        strGiftAmtT        += DS_O_MASTER.NameValue(i, "GIFT_DRAWL_AMT");
        strJGitfAmtT       += DS_O_MASTER.NameValue(i, "JGIFT_AMT");
        strOGift_AmtT      += DS_O_MASTER.NameValue(i, "OGIFT_DRAWL_AMT");
        strGita_AmtT       += DS_O_MASTER.NameValue(i, "GITA_AMT");
        strCreditSale_AmtT += DS_O_MASTER.NameValue(i, "CREDIT_SALE_AMT");
    }
    
    if(RD_CRATE_FLAG.CodeValue == 0){
    	
    	for(i=1; i <= DS_O_MASTER.CountRow; i++){
            DS_O_MASTER.NameValue(i, "CASH_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "CASH_AMT")/getRoundDec("1",strCashAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "JCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "JCARD_AMT")/getRoundDec("1",strJCardAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "OCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "OCARD_AMT")/getRoundDec("1",strOCardAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "DCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "DCARD_AMT")/getRoundDec("1",strDCardAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "CCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "CCARD_AMT")/getRoundDec("1",strCCardAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "POINT_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "POINT_AMT")/getRoundDec("1",strPointAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "GIFT_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "GIFT_DRAWL_AMT")/getRoundDec("1",strGiftAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "JGIFT_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "JGIFT_AMT")/getRoundDec("1",strJGitfAmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "OGIFT_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "OGIFT_DRAWL_AMT")/getRoundDec("1",strOGift_AmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "GITA_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "GITA_AMT")/getRoundDec("1",strGita_AmtT,0)*100,2);
            DS_O_MASTER.NameValue(i, "CREDIT_SALE_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "CREDIT_SALE_AMT")/getRoundDec("1",strCreditSale_AmtT,0)*100,2);
        }
    }
    else{
    	
        for(i=1; i <= DS_O_MASTER.CountRow; i++){
            DS_O_MASTER.NameValue(i, "CASH_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "CASH_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "JCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "JCARD_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "OCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "OCARD_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "DCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "DCARD_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "CCARD_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "CCARD_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "POINT_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "POINT_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "GIFT_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "GIFT_DRAWL_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "JGIFT_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "JGIFT_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "OGIFT_CRATE") = getRoundDec("1",DS_O_MASTER.NameValue(i, "OGIFT_DRAWL_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "GITA_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "GITA_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
            DS_O_MASTER.NameValue(i, "CREDIT_SALE_CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "CREDIT_SALE_AMT")/getRoundDec("1",DS_O_MASTER.NameValue(i, "TOTAL"),0)*100,2);
        }
    }
    
       
    DS_O_MASTER.ResetStatus();
    
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
                  <th width="70">팀</th>
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
                  <th>구성비</th>
                  <td width="170">
                    <comment id="_NSID_">
                    <object id=RD_CRATE_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:140">
                    <param name=Cols    value="2">
                    <param name=Format  value="0^조직,1^결제형태">
                    <param name=CodeValue  value="0">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td> 
                  <th>조회구분</th>
                  <td>
                    <comment id="_NSID_">
                    <object id=RD_DISP_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:140">
                    <param name=Cols    value="2">
                    <param name=Format  value="0^조직,1^일자">
                    <param name=CodeValue  value="0">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
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
                     id=GD_MASTER width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
