<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원 매출 객단가 현황(일)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3320.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2012.05.30 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
	String strFromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strFromDate = strFromDate + "01";

	String strToDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 100;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID 
 function doInit(){
	 
		//Master 그리드 세로크기자동조정  2013-07-17
		var obj   = document.getElementById("GR_MASTER");
			obj2  = document.getElementById("GD_DETAIL");

	 		obj2.style.height  = (parseInt(window.document.body.clientHeight)-top-obj.height-40) + "px";

	 
	    //Output Data Set Header 초기화
	    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
	    
	    //그리드 초기화
	    gridCreate1(); //마스터
	    gridCreate2(); //디테일
	    
	    
	 // 콤보 초기화
	 	var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';  
	 	
	    initComboStyle(LC_STR_CD,DS_STR_CD,   "CODE^0^30,NAME^0^140", 1, PK);		// 점(조회)
	    
	    getStore2("DS_STR_CD", "Y", "", "Y", 1);                                             	// 점   
	    
	    // EMedit에 초기화
	    initEmEdit(EM_FROM_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_TO_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_FROM_ENT_DT, "YYYYMMDD",  PK);           // 가입일
	    initEmEdit(EM_TO_ENT_DT, "YYYYMMDD",  PK);           // 가입일
	    initEmEdit(EM_FROM_CS_DT, "YYYYMMDD",  PK);           // 대비조회일
	    initEmEdit(EM_TO_CS_DT, "YYYYMMDD",  PK);           // 대비조회일    
	    initEmEdit(EM_LOCAL_NM, "GEN^200",   NORMAL);            //브랜드(조회)
	 
	    
	    
	    //조회기간 초기값.
	    EM_FROM_BS_DT.text = <%=strFromDate%>;
	    EM_TO_BS_DT.text = <%=strToDate%>;
	    EM_FROM_ENT_DT.text = <%=strFromDate%>;
	    EM_TO_ENT_DT.text = <%=strToDate%>;
	    EM_FROM_CS_DT.text = <%=strFromDate%>;
	    EM_TO_CS_DT.text = <%=strToDate%>;    
	    LC_STR_CD.BindColVal  = strcd;  
	    
	    //화면 OPEN시 자동 조회
	    //btn_Search();
	    
	    document.getElementById("LC_STR_CD").style.display = "none"; // 필요 없어서 숨김.
	    document.getElementById("EM_FROM_BS_DT").style.display = "none";
	    document.getElementById("EM_TO_BS_DT").style.display = "none";
	    document.getElementById("EM_FROM_CS_DT").style.display = "none";
	    document.getElementById("EM_TO_CS_DT").style.display = "none";
	}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}      			name="NO"           	width=30    align=center	</FC>'
                     + '<FC>id=HEADER_ADDR       		name="시 / 도 / 군"      width=200   align=left  SumText= "합 계"</FC>'
                     + '<FG>							name="집  계"'
                     + '<FC>id=TOT   			 		name="총 가입객수"		width=120    align=right SumText=@sum</FC>'
                     + '<FC>id=RATIO   					name="구성비"	     	width=80    align=right </FC>'
                     + '<FC>id=WEEKSDAY_CNT     		name="주중가입"			width=90   align=right SumText=@sum</FC>'
                     + '<FC>id=WEEKEND_CNT     			name="주말가입"			width=90   align=right SumText=@sum</FC>'
                     + '</FG>'
                     + '<G>								name="평균"'
                     + '<C>id=CNT_AVG     				name="전일" 				width=90    align=right SumText=@sum </C>'
                     + '<C>id=WEEKSDAY_AVG     			name="주중" 				width=90    align=right SumText=@sum </C>'
                     + '<C>id=WEEKEND_AVG     			name="주말" 				width=90    align=right SumText=@sum </C>'
                     + '</G>'
                     + '<G>								name="일자"'
                     + '<C>id=DAY1		     			name="1일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY1,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY2		     			name="2일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY2,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY3		     			name="3일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY3,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY4		     			name="4일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY4,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY5		     			name="5일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY5,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY6		     			name="6일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY6,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY7		     			name="7일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY7,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY8		     			name="8일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY8,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY9		     			name="9일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY9,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY10	     				name="10일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY10,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY11		     			name="11일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY11,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY12		     			name="12일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY12,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY13		     			name="13일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY13,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY14		     			name="14일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY14,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY15		     			name="15일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY15,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY16		     			name="16일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY16,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY17		     			name="17일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY17,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY18		     			name="18일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY18,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY19		     			name="19일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY19,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY20	     				name="20일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY210,0,"ffffff","#FBEFEF")} /C>'
                     + '<C>id=DAY21		     			name="21일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY22,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY22		     			name="22일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY23,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY23		     			name="23일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY24,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY24		     			name="24일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY25,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY25		     			name="25일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY26,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY26		     			name="26일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY27,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY27		     			name="27일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY28,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY28		     			name="28일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY29,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY29		     			name="29일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY30,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY30	     				name="30일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY31,0,"ffffff","#FBEFEF")} </C>'
                     + '<C>id=DAY31	     				name="31일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY1,0,"ffffff","#FBEFEF")} </C>'
                     + '</G>' 
                     + '<FC>id=SIDO   					name="시도"   			width=80    align=right show=false</FC>'
                     + '<FC>id=SIGUN   					name="시군"   			width=80    align=right show=false</FC>'
                     + '<FC>id=SDT   					name="매출시작"  			width=60    align=right show=false </FC>'
                     + '<FC>id=EDT   					name="매출종료"			width=80    align=right show=false</FC>'
                	;
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

function gridCreate2(){
   var hdrProperies = '<FC>id={currow}      			name="NO"           	width=30    align=center	</FC>'
			        + '<FC>id=GU			       		name="구"      			width=140   align=left  SumText= "합 계"</FC>'
			        + '<FC>id=DONGS			       		name="읍/면/동"    	  	width=200   align=left  </FC>'
			        + '<FG>								name="집  계"'
			        + '<FC>id=TOT   			 		name="총 가입객수"		width=120    align=right SumText=@sum</FC>'
			        + '<FC>id=RATIO   					name="구성비"	     	width=80    align=right </FC>'
			        + '<FC>id=WEEKSDAY_CNT  	   		name="주중가입"			width=90   align=right SumText=@sum</FC>'
			        + '<FC>id=WEEKEND_CNT     			name="주말가입"			width=90   align=right SumText=@sum</FC>'
			        + '</FG>'
			        + '<G>								name="평균"'
			        + '<C>id=CNT_AVG     				name="전일" 				width=90    align=right SumText=@sum </C>'
			        + '<C>id=WEEKSDAY_AVG     			name="주중" 				width=90    align=right SumText=@sum </C>'
			        + '<C>id=WEEKEND_AVG     			name="주말" 				width=90    align=right SumText=@sum </C>'
			        + '</G>'
			        + '<G>								name="일자"'
			        + '<C>id=DAY1		     			name="1일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY1,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY2		     			name="2일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY2,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY3		     			name="3일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY3,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY4		     			name="4일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY4,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY5		     			name="5일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY5,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY6		     			name="6일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY6,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY7		     			name="7일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY7,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY8		     			name="8일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY8,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY9		     			name="9일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY9,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY10	     				name="10일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY10,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY11		     			name="11일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY11,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY12		     			name="12일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY12,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY13		     			name="13일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY13,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY14		     			name="14일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY14,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY15		     			name="15일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY15,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY16		     			name="16일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY16,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY17		     			name="17일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY17,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY18		     			name="18일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY18,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY19		     			name="19일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY19,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY20	     				name="20일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY20,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY21		     			name="21일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY21,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY22		     			name="22일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY22,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY23		     			name="23일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY23,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY24		     			name="24일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY24,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY25		     			name="25일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY25,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY26		     			name="26일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY26,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY27		     			name="27일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY27,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY28		     			name="28일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY28,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY29		     			name="29일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY29,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY30	     				name="30일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY30,0,"ffffff","#FBEFEF")}</C>'
			        + '<C>id=DAY31	     				name="31일" 				width=70    align=right SumText=@sum bgcolor={decode(DAY31,0,"ffffff","#FBEFEF")}</C>'
			        + '</G>' 
			        ; 
			         
                      
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    GD_DETAIL.ViewSummary = "1";
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 조회시 호출
 * return값 : void
 */
 function btn_Search() {
	 
		//마스터, 디테일 그리드 클리어
	    DS_MASTER.ClearData();
	    DS_O_DETAIL.ClearData();
	 		
	 
		 //점 체크
		 /*
	     if (isNull(LC_STR_CD.BindColVal)==true ) {
	         showMessage(Information, OK, "USER-1003","점");
	         LC_STR_CD.focus();
	         return false;
	     }
	     */
		/*
	    if(trim(EM_FROM_BS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_FROM_BS_DT.Focus();
	        return;
	    }
	    if(trim(EM_TO_BS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_TO_BS_DT.Focus();
	        return;
	    }
	    */
	    if(trim(EM_FROM_ENT_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_FROM_ENT_DT.Focus();
	        return;
	    }
	    if(trim(EM_TO_ENT_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_TO_ENT_DT.Focus();
	        return;
	    }	 
	    /*
	    if(trim(EM_FROM_CS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_FROM_CS_DT.Focus();
	        return;
	    }
	    if(trim(EM_TO_CS_DT.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_TO_CS_DT.Focus();
	        return;
	    } 
	    alert("!!!");
	    */
	   	showMaster();
	    //조회결과 Return
	    setPorcCount("SELECT", DS_MASTER.RealCount(1, DS_MASTER.CountRow));
	}

/**
 * btn_Excel()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	
	var objGrd = "";
	var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
	var strTitle = "";
    
	if(rtnVal == "1"){
		objGrd = GR_MASTER;
		strTitle = "지역별 회원가입현황(시/도/군)";
	}else if(rtnVal == "2"){
		objGrd = GD_DETAIL;
		strTitle = "지역별 회원가입현황(구/동/읍)";
	}else{
		return;
	}
	
	var parameters = "가입조회시작일자="     + EM_FROM_ENT_DT.Text
				   + "가입조회종료일자="     + EM_TO_ENT_DT.Text;
	/*
	var obj  = document.getElementById("CHK_ILJA");
	
	if(obj.checked){
		//매출기간
		parameters = parameters
				   + "대비조회시작일자="     + EM_FROM_CS_DT.Text
				   + "대비조회종료일자="     + EM_TO_CS_DT.Text;
	}
	*/
	
	objGrd.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
	
	//openExcel2(objGrd, strTitle, parameters, true);
	openExcel5(objGrd, strTitle, parameters, true, "",g_strPid );
	    
    objGrd.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : kj
 * 작 성 일     : 2010-02-16
 * 개       요     : 일단위 포인트 현황 조회 
 * return값 : void
 */
function showMaster(){
    
	var tfChkInmall = document.getElementById("CHK_INMALL").checked;
	var tfChkMobile = document.getElementById("CHK_MOBILE").checked;
	var strOptions	= "";
	
	if (tfChkInmall&&tfChkMobile) {
		strOptions = "ALL";
	} else {
		if (tfChkInmall)
			strOptions = "INMALL";
		else
			strOptions = "MOBILE";
	}
	 
	var goTo        = "searchMaster";    
    var action      = "O";
    var parameters  = "&strFromENTDate="+ encodeURIComponent(EM_FROM_ENT_DT.Text)
					+ "&strToENTDate="  + encodeURIComponent(EM_TO_ENT_DT.Text)
					+ "&strLocalNm="  + encodeURIComponent(EM_LOCAL_NM.TEXT)
					+ "&strOptions="  + encodeURIComponent(strOptions)
					;
    TR_MAIN.Action  ="/dcs/dbri332.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_FROM_BS_DT.Focus();
    }
}

/**
 * searchDetail()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-04-20
 * 개    요 : 브랜드별실적 조회
 * return값 : void
 */
 function searchDetail(){
	
	var strSido = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SIDO");
	var strSigun = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SIGUN");
	var strSdt = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SDT");
	var strEdt = DS_MASTER.NameValue(DS_MASTER.RowPosition, "EDT");
	var strOptions = DS_MASTER.NameValue(DS_MASTER.RowPosition, "OPTIONS");
	
	
	
	if(DS_MASTER.CountRow <= 0) return false;
	
	var goTo        = "searchDetail";    
    var action      = "O";
	var parameters  = "&strFromENTDate="+ encodeURIComponent(strSdt)
					+ "&strToENTDate="  + encodeURIComponent(strEdt)
					+ "&strSido="	+ encodeURIComponent(strSido.trim())
					+ "&strSigungu="+ encodeURIComponent(strSigun.trim())
					+ "&strOptions="+ encodeURIComponent(strOptions.trim())
					;
	TR_DETAIL.Action  ="/dcs/dbri332.db?goTo="+goTo+parameters;  
	TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	TR_DETAIL.Post();
	
	if(DS_O_DETAIL.CountRow > 0){
		GD_DETAIL.Focus();
	}else{
		EM_FROM_BS_DT.Focus();
	}
    
    // 조회결과 Return
    setPorcCount("SELECT",DS_O_DETAIL.RealCount(1, DS_O_DETAIL.CountRow));

 }

/**
 * fnChkEnable()
 * 작 성 자     :  
 * 작 성 일     : 2016-12-26
 * 개       요    : 대비일자 체크 박스 체크인 경우 그리드 처리
 * return값 : void
 */
function fnChkEnable(){
	 
	DS_MASTER.ClearData(); 
	 
	if(CHK_ILJA.checked == true){ 
		
		GR_MASTER.ColumnProp("PRE_TOT_SALE_AMT", "Show") = "true";  
		GR_MASTER.ColumnProp("CUST_CNT_YY", "Show") = "true";    
		GR_MASTER.ColumnProp("PRE_TOT_DANGA", "Show") = "true";  
		GR_MASTER.ColumnProp("PRE_CUST_SALE_AMT", "Show") = "true";  
		GR_MASTER.ColumnProp("PRE_CUST_SALE_RATE", "Show") = "true";  
		GR_MASTER.ColumnProp("CUST_CNT_YZ", "Show") = "true";  
		GR_MASTER.ColumnProp("PRE_CUST_DANGA", "Show") = "true";  
		GR_MASTER.ColumnProp("PRE_NCUST_SALE_AMT", "Show") = "true";  
		GR_MASTER.ColumnProp("PRE_NCUST_SALE_RATE", "Show") = "true";  
		GR_MASTER.ColumnProp("CUST_CNT_YZ_1", "Show") = "true";  
		GR_MASTER.ColumnProp("PRE_NCUST_DANGA", "Show") = "true"; 
		
	} else if (CHK_ILJA.checked == false)  {   
		
		GR_MASTER.ColumnProp("PRE_TOT_SALE_AMT", "Show") = "false";   
		GR_MASTER.ColumnProp("CUST_CNT_YY", "Show") = "false"; 
		GR_MASTER.ColumnProp("CUST_CNT_YY", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_TOT_DANGA", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_CUST_SALE_AMT", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_CUST_SALE_RATE", "Show") = "false";  
		GR_MASTER.ColumnProp("CUST_CNT_YZ", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_CUST_DANGA", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_NCUST_SALE_AMT", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_NCUST_SALE_RATE", "Show") = "false";  
		GR_MASTER.ColumnProp("CUST_CNT_YZ_1", "Show") = "false";  
		GR_MASTER.ColumnProp("PRE_NCUST_DANGA", "Show") = "false";   
		
	}
}


/**
 * fnChk(obj)
 * 작 성 자     :  
 * 작 성 일     : 2017-11-21
 * 개       요    : 체크박스 옵션 모두 해제 금지
 * return값 : void
 */
function fnChk(obj){
	
	 var tfTemp = !obj.checked;
	 
	 if (!document.getElementById("CHK_INMALL").checked&&!document.getElementById("CHK_MOBILE").checked) {
		 alert("반드시 한가지 옵션은 선택되어야 합니다.");
		 obj.checked = tfTemp;
	 }

}

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    CUR_GR = this;
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row > 0){
    searchDetail();
}
old_Row = row;

</script>

<!-- 기준조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_BS_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_BS_DT)){
    	EM_FROM_BS_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 기준조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_BS_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_BS_DT)){
		EM_TO_BS_DT.text = <%=strToDate%>;
	}
</script>

<!-- 가입조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_ENT_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_ENT_DT)){
    	EM_FROM_ENT_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 가입조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_ENT_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_ENT_DT)){
		EM_TO_ENT_DT.text = <%=strToDate%>;
	}
</script>

<!-- 대비조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_CS_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_CS_DT)){
    	EM_FROM_CS_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 대비조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_CS_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_CS_DT)){
		EM_TO_CS_DT.text = <%=strToDate%>;
	}
</script>


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
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

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    //alert(top);
    //alert((parseInt(window.document.body.clientHeight)));
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    //alert(grd_height);
    obj.style.height  = grd_height + "px";
    
}
</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
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
		                <!-- th width="100" class="point">점</th>
		                <td width="200"--><comment id="_NSID_"> <object
		                   id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><!-- /td-->
		                <th width="100" >시/도/군 명</th>
		                <td width="1000" ><comment id="_NSID_"> <object
		                   id=EM_LOCAL_NM classid=<%=Util.CLSID_EMEDIT%> width=200 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               		</tr>
					<tr>
						<!-- th width="100" class="point">매출일자</th>
						<td width="200"--><comment id="_NSID_"> <object
							id=EM_FROM_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <!-- img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_BS_DT)" /-->
							<comment id="_NSID_"> <object 
							id=EM_TO_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <!-- img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_BS_DT)" /></td--> 
						<th width="100" class="point">가입일자</th>
						<td width="1000"><comment id="_NSID_"> <object
							id=EM_FROM_ENT_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_ENT_DT)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_ENT_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_ENT_DT)" />
							<input type="checkbox" id=CHK_INMALL checked onclick="fnChk(this);"> 점내 가입
							<input type="checkbox" id=CHK_MOBILE checked onclick="fnChk(this);"> 모바일 가입
							</td> 
						<!-- th width="100"><input type="checkbox" id=CHK_ILJA onclick="fnChkEnable();">대비일자</th> 
						<td --><comment id="_NSID_">  
							<object
							id=EM_FROM_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <!-- img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_CS_DT)" /-->
							<comment id="_NSID_"> <object 
							id=EM_TO_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <!-- img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_CS_DT)" /></td-->					
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
		<td class="PB03">
		<table width="100%" height=400 border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
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
						<th width="100px">지역 상세</th>
						<td style="border-right:0px"> 
							* 조회 기간이 길수록 조회 시간이 오래 걸립니다 *  
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
                     id=GD_DETAIL width=100% height=200 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
