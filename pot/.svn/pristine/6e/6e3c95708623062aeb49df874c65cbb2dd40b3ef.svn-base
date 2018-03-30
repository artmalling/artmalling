<%@page import="kr.fujitsu.ffw.util.Date2"%>
<%@page import="java.util.Date"%>
<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템_매출속보
 * 작 성 일 : 2010.12.12
 * 작 성 자 : FKL 
 * 수 정 자 :
 * 파 일 명 : mainFrameSale_art.jsp
 * 버    전 : 1.0
 * 개    요 : 메인 화면
 * 이    력 : 
 ******************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty, java.util.List, java.util.Map, common.util.PagingHelper"   %>
   
<%@ taglib prefix="ajax" uri="/WEB-INF/tld/ajax-lib.tld"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<ajax:library /> 
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정												*-->
<!--*************************************************************************--> 
<%
	String dir       		= BaseProperty.get("context.common.dir");
    String today            = Date2.YYYYMMDDHHMMSS("");
    String today2           = Date2.YYYYMMDD("");
%>
<HTML> 
<HEAD> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<%-- <script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script> --%>
<%-- <script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script> --%>
<%-- <script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script> --%>
<%-- <script language="javascript"  src="/<%=dir%>/js/message.js"type="text/javascript"></script> --%>
<%-- <script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script> --%>


<script language="javascript" src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
</HEAD>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var nowDate     = '<%=today%>';
var strCd       = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';	// 점
var strUserId   = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';	// 사용자
var strOrgFlag  = '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';	// 매장, 매입구분
var strGroupCd  = '<c:out value="${sessionScope.sessionInfo.GROUP_CD}" />';	//그룹코드
var strViewLv   = '<c:out value="${sessionScope.sessionInfo.VIEW_LEVEL}" />';	//뷰레벨

var varCompday  = addDate("d", -364, nowDate);
var top = 50;		//해당화면의 동적그리드top위치

var gStrStrDt = "20160101";
var gStrEndDt = "20161231";


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
var CUR_GR;

function doInit(){
	
	//Master 그리드 세로크기자동조정  2013-07-17
// 	var obj   = document.getElementById("GD_MASTER"); 
// 	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
// 	var tmpStr      = TD_TIME_VIEW.innerText;
// 	var tmpTimeStr  = nowDate.substring(0,4)+"년 "+nowDate.substring(4,6)+"월 "+nowDate.substring(6,8)+"일 "+nowDate.substring(8,10)+":"+nowDate.substring(10,12);
// 	var tmpcompDate = varCompday.substring(0,4)+"년 "+varCompday.substring(5,7)+"월 "+varCompday.substring(8,10)+"일 "
// 	TD_TIME_VIEW.innerText = "현재 : " + tmpTimeStr + "  " + " 대비 일자 : " + tmpcompDate + tmpStr ;

	var strinnerText = "매출기간 : " + gStrStrDt + " ~ " +  gStrEndDt ;
// 	TD_TIME_VIEW.innerText = strinnerText;

    getStore("DS_STR_CD", "Y", "", "N");			// 점
    
    gridCreate1();	
    gridCreate2("1"); //DETAIL
    
    RD_GROUP.CodeValue = "3";	// 브랜드로
    
	// 컴퍼넌트 세팅
    initEmEdit(EM_SALE_DT_S,      "YYYYMMDD", PK);   // 실적 시작일
    initEmEdit(EM_SALE_DT_E,      "YYYYMMDD", PK);   // 실적 종료일
    initEmEdit(EM_BF_SALE_DT_S,   "YYYYMMDD", PK);   // 대비 시작일
    initEmEdit(EM_BF_SALE_DT_E,   "YYYYMMDD", PK);   // 대비 종료일
	initEmEdit(EM_SALE_M,         "YYYYMM",	  PK);	 // 매출월
	initEmEdit(EM_BF_SALE_M,      "YYYYMM",	  PK);	 // 대비월
    
    //현재년도 셋팅
    EM_SALE_DT_S.alignment    = 1;
    EM_SALE_DT_E.alignment    = 1;
    EM_BF_SALE_DT_S.alignment = 1;
    EM_BF_SALE_DT_E.alignment = 1;
    
    // 실적
//     EM_SALE_DT_S.text    = varToMon+"01";
    EM_SALE_DT_S.text    = varToday;
    EM_SALE_DT_E.text    = varToday;
    EM_SALE_M.text       = varToMon;
    
    /*
    // 대비
    EM_BF_SALE_DT_S.text = addDate("m", -1, varToMon+"01");
    EM_BF_SALE_DT_E.text = addDate("m", -1, varToday);
    EM_BF_SALE_M.text    = addDate("m", -1, varToMon+"01");
	*/
	
    /* 아트몰링 전년도 동일 요일 일자 로 셋팅(대비일자) 2017.01.02 */
//     EM_BF_SALE_DT_S.text = getBeforeYearDay(EM_SALE_DT_S.text );
    EM_BF_SALE_DT_S.text = getBeforeYearDay(EM_SALE_DT_E.text );
    EM_BF_SALE_DT_E.text = getBeforeYearDay(EM_SALE_DT_E.text );
    EM_BF_SALE_M.text    = varBf_Year_Mon;
	
	EM_SALE_DT_S.Enable    = true;
	EM_SALE_DT_E.Enable    = true;
	EM_BF_SALE_DT_S.Enable = true;
	EM_BF_SALE_DT_E.Enable = true;
	EM_SALE_M.Enable       = false;
	EM_BF_SALE_M.Enable    = false;
	CUR_GR = GD_MASTER;
	
	// 자동조회
    searchMaster_art();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
			         + '<FC>id=STR_CD                 name="점"           width=80    align=left      suppress=1 EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME" </FC>'
			         + '<FC>id=TEAM_CD                name="팀"           width=80    align=center    Show=false       </FC>'
			         + '<G> name="파트"'
			         + '<FC>id=PART_CD                name="코드"         width=50    align=center    </FC>'
			         + '<FC>id=PART_NM                name="명"           width=100   align=left      </FC>'
			         + '</G>'
			         + '<FC>id=SEARCH_CD              name="조회코드"     width=50    align=center    Show=false       </FC>'
			         + '<G> name="매출"'
			         + '<FC>id=ORIGIN_SALE_TAMT       name="목표"         width=100   align=right     mask="###,###"   </FC>'
// 			         + '<FC>id=TOT_SALE_AMT           name="(실적)총매출" width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=NET_SALE_AMT           name="(실적)매출"   width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=ACHIEVE_RATE           name="달성율"       width=60    align=right     mask="#,###.00"  </FC>'
// 			         + '<FC>id=BF_TOT_SALE_AMT        name="(대비)총매출" width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=BF_NET_SALE_AMT        name="(대비)매출"   width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=SALE_ACHV_RATE         name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="이익"'
			         + '<FC>id=SALE_PROF_AMT          name="실적"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=BF_SALE_PROF_AMT       name="대비"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=PROF_ACHV_RATE         name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="이익율비교"'
			         + '<FC>id=PROF_RATE              name="실적"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '<FC>id=BF_PROF_RATE           name="대비"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="고객수"'
			         + '<FC>id=CUST_CNT               name="실적"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '<FC>id=BF_CUST_CNT            name="대비"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '<FC>id=CUST_CNT_ACHV_RATE     name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="객단가"'
			         + '<FC>id=CUST_DANGA             name="실적"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=BF_CUST_DANGA          name="대비"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=CUST_DANGA_ACHV_RATE   name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<C>id=ORDER_FLAG              name="정렬순번"     width=90    align=right     Show=false   </C>'
                     ;
	
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
// 	GD_MASTER.DecRealData = true;

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
}

//디테일
function gridCreate2(strGrpCd){

	var strGrpNm = "";
	if(strGrpCd == "1"){		// PC
		strGrpNm = "PC";
	}else if(strGrpCd == "2"){	// 코너
		strGrpNm = "코너";
	}else if(strGrpCd == "3"){	// 브랜드
		strGrpNm = "브랜드";
	}
	
	var hdrProperies = '<FC>id={currow}               name="NO"           width=30    align=center    </FC>'
			         + '<G> id=GRP_TITLE name="' + strGrpNm + '"'
			         + '<FC>id=GRP_CD                 name="코드"         width=70    align=center    </FC>'
			         + '<FC>id=GRP_NM                 name="명"           width=120   align=left      </FC>'
			         + '</G>'
			         + '<G> name="매출"'
			         + '<FC>id=ORIGIN_SALE_TAMT       name="목표"         width=100   align=right     mask="###,###"   </FC>'
// 			         + '<FC>id=TOT_SALE_AMT           name="(실적)총매출" width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=NET_SALE_AMT           name="(실적)매출"   width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=ACHIEVE_RATE           name="달성율"       width=60    align=right     mask="#,###.00"  </FC>'
// 			         + '<FC>id=BF_TOT_SALE_AMT        name="(대비)총매출" width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=BF_NET_SALE_AMT        name="(대비)매출"   width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=SALE_ACHV_RATE         name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="이익"'
			         + '<FC>id=SALE_PROF_AMT          name="실적"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=BF_SALE_PROF_AMT       name="대비"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=PROF_ACHV_RATE         name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="이익율비교"'
			         + '<FC>id=PROF_RATE              name="실적"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '<FC>id=BF_PROF_RATE           name="대비"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="고객수"'
			         + '<FC>id=CUST_CNT               name="실적"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '<FC>id=BF_CUST_CNT            name="대비"         width=60    align=right     mask="#,###.00"  </FC>'
			         + '<FC>id=CUST_CNT_ACHV_RATE     name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
			         + '<G> name="객단가"'
			         + '<FC>id=CUST_DANGA             name="실적"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=BF_CUST_DANGA          name="대비"         width=100   align=right     mask="###,###"   </FC>'
			         + '<FC>id=CUST_DANGA_ACHV_RATE   name="신장율"       width=60    align=right     mask="#,###.00"  </FC>'
			         + '</G>'
	                 ;
	initGridStyle(GD_DETAIL, "common", hdrProperies, false);

    //스크롤바 위치 조정
//     GD_DETAIL.SETVSCROLLING(0);
//     GD_DETAIL.SETHSCROLLING(0);
}


// 조직별 매출속보 마스터 조회
function searchMaster_art(){

	// 개별그룹(고객센터)는 메인화면 매출조회에서 제외
	if(strGroupCd == "198") return;
// 	if(strViewLv == "2") return;
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
//     DS_O_DETAIL.ClearData();

	var strSaleFlag  = EM_SALE_FLAG.CodeValue;
    var strSaleDtS   = "";	              // (실적)시작년월
    var strSaleDtE   = "";	              // (실적)종료년월
    var strBfSaleDtS = "";	              // (대비)시작년월
    var strBfSaleDtE = "";	              // (대비)종료년월
    
	if(strSaleFlag == "1"){	// 기간
	    strSaleDtS   = EM_SALE_DT_S.Text;   
	    strSaleDtE   = EM_SALE_DT_E.Text;   
	    strBfSaleDtS = EM_BF_SALE_DT_S.Text;
	    strBfSaleDtE = EM_BF_SALE_DT_E.Text;
	    
	}else{					// 월
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
	    strSaleDtS     = EM_SALE_M.Text + "01";							// 해당월의 첫째날
	    strSaleDtE     = addDate("d", -1, addDate("m", 1, strSaleDtS));	// 해당월의 마지막날
	    strSaleDtE     = strSaleDtE.replace(/\-/g,'');
	    /* 대비월 */
	    strBfSaleDtS   = EM_BF_SALE_M.Text + "01";							// 해당월의 첫째날
	    strBfSaleDtE   = addDate("d", -1, addDate("m", 1, strBfSaleDtS));	// 해당월의 마지막날
	}
    
//     alert("strSaleDtS = " + strSaleDtS + ", strSaleDtE = " + strSaleDtE + ", strBfSaleDtS = " + strBfSaleDtS + ", strBfSaleDtE = " + strBfSaleDtE);
    
    
    var strStrCd   = strCd;						// 점
    var goTo       = "searchMaster_art" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strCd)
				   + "&strSaleDtS="   + encodeURIComponent(strSaleDtS)
				   + "&strSaleDtE="   + encodeURIComponent(strSaleDtE)
				   + "&strBfSaleDtS=" + encodeURIComponent(strBfSaleDtS)
				   + "&strBfSaleDtE=" + encodeURIComponent(strBfSaleDtE)
                   ;  

    TR_MAIN.Action="/pot/tcom001.tc?goTo=searchMaster_art"+parameters; 
    TR_MAIN.KeyValue="SERVLET(O:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

/**
* searchDetail_art()
* 작 성 자 : 박종은
* 작 성 일 : 2010-04-20
* 개    요 : 품번별실적 조회
* return값 : void
*/
function searchDetail_art(){
	 
	gridCreate2(RD_GROUP.CodeValue);

	var strSaleFlag  = EM_SALE_FLAG.CodeValue;
    var strSaleDtS   = "";	              // (실적)시작년월
    var strSaleDtE   = "";	              // (실적)종료년월
    var strBfSaleDtS = "";	              // (대비)시작년월
    var strBfSaleDtE = "";	              // (대비)종료년월
    
	if(strSaleFlag == "1"){	// 기간
	    strSaleDtS   = EM_SALE_DT_S.Text;   
	    strSaleDtE   = EM_SALE_DT_E.Text;   
	    strBfSaleDtS = EM_BF_SALE_DT_S.Text;
	    strBfSaleDtE = EM_BF_SALE_DT_E.Text;
	    
	}else{					// 월
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
	    strSaleDtS     = EM_SALE_M.Text + "01";							// 해당월의 첫째날
	    strSaleDtE     = addDate("d", -1, addDate("m", 1, strSaleDtS));	// 해당월의 마지막날
	    strSaleDtE     = strSaleDtE.replace(/\-/g,'');
	    /* 대비월 */
	    strBfSaleDtS   = EM_BF_SALE_M.Text + "01";							// 해당월의 첫째날
	    strBfSaleDtE   = addDate("d", -1, addDate("m", 1, strBfSaleDtS));	// 해당월의 마지막날
	    strBfSaleDtE   = strBfSaleDtE.replace(/\-/g,'');
	}
    
	
    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");		//점
    var strSearchCd  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SEARCH_CD");
    var strGrpCd     = RD_GROUP.CodeValue;			// 조회구분
    
    var goTo       = "searchDetail_art" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strSearchCd="  + encodeURIComponent(strSearchCd)
                   + "&strSaleDtS="   + encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="   + encodeURIComponent(strSaleDtE)
                   + "&strBfSaleDtS=" + encodeURIComponent(strBfSaleDtS)
                   + "&strBfSaleDtE=" + encodeURIComponent(strBfSaleDtE)
                   + "&strGrpCd="     + encodeURIComponent(strGrpCd)
                   ;
    
    TR_DETAIL.Action="/pot/tcom001.tc?goTo=searchDetail_art"+parameters; 
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    // 조회결과 Return
//     setPorcCount("SELECT", DS_O_DETAIL.CountRow);
    
    //스크롤바 위치 조정
//     GD_DETAIL.SETVSCROLLING(0);
//     GD_DETAIL.SETHSCROLLING(0);
}

/**
 * excel_art()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function excel_art() {
	
	var objGrd = "";
	var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    var strSaleDt    = "";	              // (실적)매출기간
    var strBfSaleDt  = "";	              // (대비)대비기간
    var str_Dt_M     = "";	              // 매출기간 or 매출월           
    var str_BF_Dt_M  = "";                // 매출기간 or 매출월
    
	if(rtnVal == "1"){
		objGrd = GD_MASTER;
	}else if(rtnVal == "2"){
		objGrd = GD_DETAIL;
	}else{
		return;
	}
	//기간 구분 ((  1:매출기간 2:매출월 ))
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
	 
	var strTitle = "조직별 매출속보";
	
	var strStrCd        = strCd;		// 점
	
	var parameters = "점 "        + strStrCd
				   + ' ,  "'    + str_Dt_M + '"    ' + strSaleDt
				   + ' ,  "'    + str_BF_Dt_M + '" ' + strBfSaleDt;

	

	//objGrd.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
	CUR_GR.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
	
	openExcel2(objGrd, strTitle, parameters, true); 
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 ){
    searchDetail_art();
}

</script>

<script language=JavaScript for=RD_GROUP event=OnClick()>
searchDetail_art();
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 조직 구분  변경시  -->
<script language=JavaScript for=EM_SALE_FLAG event=OnSelChange()>

	if(EM_SALE_FLAG.CodeValue =="1"){
		EM_SALE_DT_S.Enable    = true;
		EM_SALE_DT_E.Enable    = true;
		EM_BF_SALE_DT_S.Enable = true;
		EM_BF_SALE_DT_E.Enable = true;
		EM_SALE_M.Enable       = false;
		EM_BF_SALE_M.Enable    = false;

// 		obj.style.filter = 'alpha(opacity=100)';
// 		obj.disabled = false;
		
// 		obj.style.filter = 'alpha(opacity=40)';
// 		obj.disabled = true;
		
	}else{
		EM_SALE_DT_S.Enable    = false;
		EM_SALE_DT_E.Enable    = false;
		EM_BF_SALE_DT_S.Enable = false;
		EM_BF_SALE_DT_E.Enable = false;
		EM_SALE_M.Enable       = true;
		EM_BF_SALE_M.Enable    = true;
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

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->

<comment id="_NSID_"><object id="DS_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
//     var obj   = document.getElementById("GD_DETAIL");
    
//     var grd_height = 0;
    
    
//     if((parseInt(window.document.body.clientHeight)) <= top+300) {
//     	grd_height = top;    	
//     } else {
//     	grd_height = (parseInt(window.document.body.clientHeight)-top);
//     }
//     obj.style.height  = grd_height + "px";

	
	var top = "310";
	//GD_DETAIL 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
}
</script>


<body onload="doInit();" >
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
  	<td>
	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
	    	<tr>
		      <td class="sub_title PB03 " ><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 매출속보</td>
		      <!-- MARIO OUTLET -->
		      <td class="right">(단위 : 천원)
		      <!-- MARIO OUTLET -->
		      </td>
	      	</tr>
	    </table>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">      
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
               <tr>
                  <th width="50"  rowspan="2" class="point">기간구분</th>
                  <td width="90" rowspan="2">
                    <comment id="_NSID_">
                    <object id="EM_SALE_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:95">
                    <param name=Cols    value="2">
                    <param name=Format  value="1^기간,2^월">                   
                    <param name=CodeValue  value="1">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>
                  <th width="60px" class="point">매출기간</th>
                  <td width="210px"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:if(!EM_SALE_M.Enable) openCal('G',EM_SALE_DT_S);" align="absmiddle" />~
					<comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:if(!EM_SALE_M.Enable) openCal('G',EM_SALE_DT_E);" align="absmiddle" />
                  </td>   
                  <th width="50px" class="point">매출월</th>
                  <td width="110px"><comment id="_NSID_"> <object
                     id=EM_SALE_M classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:if(!EM_SALE_DT_S.Enable) openCal('M',EM_SALE_M);" align="absmiddle"/>
                  </td>   
                  <td>
                  </td>    
               </tr>
               <tr>
                  <th class="point">대비기간</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_BF_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_BF_SALE_DT_S" onclick="javascript:if(!EM_BF_SALE_M.Enable) openCal('G',EM_BF_SALE_DT_S);" align="absmiddle" />~
                     <comment id="_NSID_"> <object
                     id=EM_BF_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_BF_SALE_DT_E" onclick="javascript:if(!EM_BF_SALE_M.Enable) openCal('G',EM_BF_SALE_DT_E);" align="absmiddle" />
                  </td> 
                  <th class="point">대비월</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_BF_SALE_M classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:if(!EM_BF_SALE_DT_S.Enable) openCal('M',EM_BF_SALE_M);" align="absmiddle"/>
                  </td> 
                  <td>
                  </td>    
               </tr>
            </table>
          </td>
          <td  class="right">
          <img src="/pot/imgs/btn/search.gif" border="0" id="btnSearch" onClick="searchMaster_art();">
          <img src="/pot/imgs/btn/excel.gif"  border="0" id="btnexcel"  onClick="excel_art();">
          </td>
        </tr>
      </table>
    </td>
    
  </tr>
  
  <tr>
    <td valign="top" colspan="2">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">      
        <tr>
          <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
                <td>
                  <comment id="_NSID_">
                    <object id=GD_MASTER width=100% height=200px classid=<%=Util.CLSID_GRID%>>
                      <param name="DataID" value="DS_O_MASTER">
                    </object>
                  </comment>
                  <script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
	<tr>
		<td height="8"></td>
	</tr>
   <tr valign="top" class="PT10">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="sub_title PB03 " ><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 매출속보(조직별)</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<td style="border-right:0px">
							<comment id="_NSID_"> 
								<object id="RD_GROUP" classid="<%=Util.CLSID_RADIO%>" width=180 height=18 align="absmiddle">
								<param name="Cols"   value="3">
								<param name="Format" value="1^PC,2^코너,3^브랜드">
								</object> 
							</comment><script>_ws_(_NSID_);</script>    
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
</body>
