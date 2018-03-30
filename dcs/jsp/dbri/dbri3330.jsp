<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원 매출 객단가 현황(일)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3330.jsp
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
<script type="text/javascript" src="/<%=dir%>/js/jquery-1.12.4.min.js"></script>
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<script type="text/javascript" src="/<%=dir%>/js/loader.js"></script>
 </head>
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
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID 
 
 var g_strAddr	= [];
 g_strAddr[0] = "하단동";
 g_strAddr[1] = "명지동";
 g_strAddr[2] = "다대동";
 g_strAddr[3] = "당리동";
 g_strAddr[4] = "신평동";
 g_strAddr[5] = "괴정동";
 g_strAddr[6] = "장림동";
 g_strAddr[7] = "엄궁동";
 g_strAddr[8] = "신호동";
 g_strAddr[9] = "감천동";
 
 var g_strPumbunName = "";
 var g_strPumbunCode = "";

 
 function doInit(){

		//Master 그리드 세로크기자동조정  2013-07-17
		var obj   = document.getElementById("GR_ADDR");
		var obj2  = document.getElementById("GR_AGE");

	 		obj.style.height  = (parseInt(window.document.body.clientHeight)-top-obj2.height) + "px";


	    //Output Data Set Header 초기화
	    DS_O_AGE.setDataHeader('<gauce:dataset name="H_AGE"/>');
	    DS_O_ADDR.setDataHeader('<gauce:dataset name="H_ADDR"/>');
	    
	    
	    //그리드 초기화
	    gridCreate1(); //마스터
	    gridCreate2(); //디테일
	    
	 // 콤보 초기화
	 	var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';  
	 	
	    initComboStyle(LC_STR_CD,DS_STR_CD,   "CODE^0^30,NAME^0^140", 1, PK);		// 점(조회)
	    
	    getStore2("DS_STR_CD", "Y", "", "Y", 1);                                             	// 점   
	    
	    // EMedit에 초기화
	    initEmEdit(EM_SALE_DT_FR, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_SALE_DT_TO, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_PUMBUN_CD,   "CODE^6^0", PK);          //브랜드(조회)
	    initEmEdit(EM_PUMBUN_NAME, "GEN^40",   READ);            //브랜드(조회)
	    //initEmEdit(EM_FROM_ENT_DT, "YYYYMMDD",  PK);           // 가입일
	    //initEmEdit(EM_TO_ENT_DT, "YYYYMMDD",  PK);           // 가입일
	    //initEmEdit(EM_FROM_CS_DT, "YYYYMMDD",  PK);           // 대비조회일
	    //initEmEdit(EM_TO_CS_DT, "YYYYMMDD",  PK);           // 대비조회일    
	    //initEmEdit(EM_LOCAL_NM, "GEN^200",   NORMAL);            //브랜드(조회)
	 	
	    
	    
	    //조회기간 초기값.
	    EM_SALE_DT_FR.text = <%=strFromDate%>;
	    EM_SALE_DT_TO.text = <%=strToDate%>;
	    //EM_FROM_ENT_DT.text = <%=strFromDate%>;
	    //EM_TO_ENT_DT.text = <%=strToDate%>;
	    //EM_FROM_CS_DT.text = <%=strFromDate%>;
	    //EM_TO_CS_DT.text = <%=strToDate%>;    
	    LC_STR_CD.BindColVal  = strcd;  
	    RD_SELGUBUN.CodeValue = "1";
	    //화면 OPEN시 자동 조회
	    //btn_Search();
	    	// 차트를 사용하기 위한 준비입니다.
	
	    //document.getElementById("EM_FROM_CS_DT").style.display = "none";
	    //document.getElementById("EM_TO_CS_DT").style.display = "none";
	    //document.getElementById("EM_LOCAL_NM").style.display = "none";
	    
		    
}
 



function gridCreate1(){
	var hdrProperies = '<FC>id={currow}      			name="NO"           width=30    align=center show=false </FC>'
					 + '<FC>id=RNK           			name="순위" 		width=50   	align=center   	Suppress=2 bgcolor={decode(RNK,"2","#FBFBEF","4","#FBFBEF","#ffffff")} </FC>'
					 + '<FG> id=PUMBUN					name="브랜드"	'
					 + '<FC>id=PUMBUN_CD           		name="코드" 		width=70   	align=center   	Suppress=2 bgcolor={decode(RNK,"2","#FBFBEF","4","#FBFBEF","#ffffff")} </FC>'
                     + '<FC>id=PUMBUN_NAME   			name="명"			width=120   align=center	Suppress=2 bgcolor={decode(RNK,"2","#FBFBEF","4","#FBFBEF","#ffffff")} </FC>'
                     + '</FG> '
                     + '<FC>id=GBNAME   				name="구분"			width=120   align=left value={decode(GB,"0","구매건수","1","구매구성비(%)","2","매출금액(원)","3","매출구성비(%)","객단가(원)")} bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<G> id=AGEUNDER20				name="20대미만"	'
                     + '<FC>id=CUST_CNT_UNDER20M		name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_UNDER20F     	name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGE20					name="20대"	'
                     + '<FC>id=CUST_CNT_20M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_20F    			name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGE30					name="30대"	'
                     + '<FC>id=CUST_CNT_30M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_30F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGE40					name="40대"	'
                     + '<FC>id=CUST_CNT_40M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_40F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGE50					name="50대"	'
                     + '<FC>id=CUST_CNT_50M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_50F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGE60					name="60대"	'
                     + '<FC>id=CUST_CNT_60M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_60F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGE70					name="70대"	'
                     + '<FC>id=CUST_CNT_70M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_70F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGEOVER80				name="80대이상"	'
                     + '<FC>id=CUST_CNT_OVER80M			name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_OVER80F     	name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     + '<G> id=AGETOT					name="계"	'
                     + '<FC>id=CUST_CNT_TOTM			name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '<FC>id=CUST_CNT_TOTF     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
                     + '</G> '
                     ;
                   
    initGridStyle(GR_AGE, "common", hdrProperies, false);
    //GR_AGE.ViewSummary = "1";
}

function gridCreate2(){
	var hdrProperies = '<FC>id={currow}      			name="NO"           width=30    align=center show=false </FC>'
					 + '<FC>id=RNK           			name="순위" 		width=50   	align=center   	Suppress=2 bgcolor={decode(RNK,"2","#FBFBEF","4","#FBFBEF","#ffffff")} </FC>'
					 + '<FG> id=PUMBUN					name="브랜드"	'
					 + '<FC>id=PUMBUN_CD           		name="코드" 		width=70   	align=center   	Suppress=2 bgcolor={decode(RNK,"2","#FBFBEF","4","#FBFBEF","#ffffff")} </FC>'
			        + '<FC>id=PUMBUN_NAME   			name="명"			width=120   align=center	Suppress=2 bgcolor={decode(RNK,"2","#FBFBEF","4","#FBFBEF","#ffffff")} </FC>'
			        + '</FG> '
			        + '<FC>id=GBNAME   				name="구분"			width=120   align=left value={decode(GB,"0","구매건수","1","구매구성비(%)","2","매출금액(원)","3","매출구성비(%)","객단가(원)")} bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<G> id=ADDR1					name="'+g_strAddr[0]+'"'
			        + '<FC>id=CUST_CNT_ADDR1M		name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR1F     	name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR2					name="'+g_strAddr[1]+'"'
			        + '<FC>id=CUST_CNT_ADDR2M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR2F    			name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR3					name="'+g_strAddr[2]+'"'
			        + '<FC>id=CUST_CNT_ADDR3M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR3F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR4					name="'+g_strAddr[3]+'"'
			        + '<FC>id=CUST_CNT_ADDR4M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR4F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR5					name="'+g_strAddr[4]+'"'
			        + '<FC>id=CUST_CNT_ADDR5M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR5F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR6					name="'+g_strAddr[5]+'"'
			        + '<FC>id=CUST_CNT_ADDR6M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR6F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR7					name="'+g_strAddr[6]+'"'
			        + '<FC>id=CUST_CNT_ADDR7M				name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR7F     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR8				name="'+g_strAddr[7]+'"'
			        + '<FC>id=CUST_CNT_ADDR8M			name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR8F     	name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR9				name="'+g_strAddr[8]+'"'
			        + '<FC>id=CUST_CNT_ADDR9M			name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR9F     	name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDR10				name="'+g_strAddr[9]+'"'
			        + '<FC>id=CUST_CNT_ADDR10M			name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_ADDR10F     	name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        + '<G> id=ADDRTPT					name="계"	'
			        + '<FC>id=CUST_CNT_TOTM			name="남"  		   	width=100   align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '<FC>id=CUST_CNT_TOTF     		name="여"			width=100  	align=right  bgcolor={decode(GB,"1","#FAFAFA","3","#FAFAFA","4","#F8E6E0","#ffffff")}</FC>'
			        + '</G> '
			        ;
                      
    initGridStyle(GR_ADDR, "common", hdrProperies, false);
    //GR_ADDR.ViewSummary = "1";
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
	    DS_O_ADDR.ClearData();
	    DS_O_AGE.ClearData();
	 		
	 
		 //점 체크
	     if (isNull(LC_STR_CD.BindColVal)==true ) {
	         showMessage(Information, OK, "USER-1003","점");
	         LC_STR_CD.focus();
	         return false;
	     }
	     	 

	    if(trim(EM_SALE_DT_FR.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_SALE_DT_FR.Focus();
	        return;
	    }
	    if(trim(EM_SALE_DT_TO.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	        EM_SALE_DT_TO.Focus();
	        return;
	    }
	    
	    if(trim(EM_PUMBUN_NAME.Text).length == 0){   // 조회기간
	        showMessage(EXCLAMATION, OK, "USER-1001","브랜드코드");
	        EM_SALE_DT_TO.Focus();
	        return;
	    }

	    showMaster();
	    searchDetail();
	    //조회결과 Return
	    g_strPumbunName = EM_PUMBUN_NAME.Text;
	    g_strPumbunCode = EM_PUMBUN_CD.Text;
	    PUMBUNNM1.innerText = " - " + g_strPumbunName;
	    PUMBUNNM2.innerText = " - " + g_strPumbunName;
	    setPorcCount("SELECT", DS_O_AGE.RealCount(1, DS_O_AGE.CountRow));
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
	
	if (RD_SELGUBUN.CodeValue == "1") 
		strTitle = " 구매건수기준 ";
	else if (RD_SELGUBUN.CodeValue == "2")
		strTitle = " 매출액기준 ";
	else
		strTitle = "";
	
	if(rtnVal == "1"){
		objGrd = GR_AGE;
		strTitle = g_strPumbunName + strTitle + "집계(연령구간별)";
	}else if(rtnVal == "2"){
		objGrd = GR_ADDR;
		strTitle = g_strPumbunName + strTitle + "집계(지역별)";
	}else{
		return;
	}
	
	var parameters = "매출조회시작일자 = "     + EM_SALE_DT_FR.Text
				   + " 매출조회종료일자 = "     + EM_SALE_DT_TO.Text
				   + " 브랜드 = "				 + g_strPumbunName+"("+g_strPumbunCode+")"
				   ;
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
    
	var goTo        = "searchAge";    
    var action      = "O";
    var parameters  = "&strSaleDtFr="+ encodeURIComponent(EM_SALE_DT_FR.Text)
					+ "&strSaleDtTo="  + encodeURIComponent(EM_SALE_DT_TO.Text)
					+ "&strStrCd="  + encodeURIComponent(LC_STR_CD.BindColVal)
					+ "&strPumbunCd="  + encodeURIComponent(EM_PUMBUN_CD.Text)
					+ "&strSelGubun="  + encodeURIComponent(RD_SELGUBUN.CodeValue)
					;
					
				
    TR_MAIN.Action  ="/dcs/dbri333.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_AGE=DS_O_AGE)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_ADDR.CountRow > 0){
        GR_AGE.Focus();
        //searchDetail();
        //fnChkEnable();
        //drawChart_reday();
    }else{
    	EM_SALE_DT_FR.Focus();
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
	
	//var strSido = DS_O_ADDR.NameValue(DS_O_ADDR.RowPosition, "SIDO");
	//var strSigun = DS_O_ADDR.NameValue(DS_O_ADDR.RowPosition, "SIGUN");
	
	
	//if(DS_O_ADDR.CountRow <= 0) return false;
	var strAddrSet = "";
	
	for (var i=0;i<=9;i++) {
		strAddrSet = strAddrSet + g_strAddr[i];
		if (i!=9)
			strAddrSet = strAddrSet + "|";
	}	
	
	var goTo        = "searchAddr";    
    var action      = "O";
	var parameters  = "&strSaleDtFr="+ encodeURIComponent(EM_SALE_DT_FR.Text)
					+ "&strSaleDtTo="  + encodeURIComponent(EM_SALE_DT_TO.Text)
					+ "&strStrCd="  + encodeURIComponent(LC_STR_CD.BindColVal)
					+ "&strPumbunCd="  + encodeURIComponent(EM_PUMBUN_CD.Text)
					+ "&strSelGubun="  + encodeURIComponent(RD_SELGUBUN.CodeValue)
					+ "&strAddr1="  + encodeURIComponent(g_strAddr[0])
					+ "&strAddr2="  + encodeURIComponent(g_strAddr[1])
					+ "&strAddr3="  + encodeURIComponent(g_strAddr[2])
					+ "&strAddr4="  + encodeURIComponent(g_strAddr[3])
					+ "&strAddr5="  + encodeURIComponent(g_strAddr[4])
					+ "&strAddr6="  + encodeURIComponent(g_strAddr[5])
					+ "&strAddr7="  + encodeURIComponent(g_strAddr[6])
					+ "&strAddr8="  + encodeURIComponent(g_strAddr[7])
					+ "&strAddr9="  + encodeURIComponent(g_strAddr[8])
					+ "&strAddr10="  + encodeURIComponent(g_strAddr[9])
					+ "&strAddrSet="  + encodeURIComponent(strAddrSet)
					;
	//alert(strAddrSet);
	TR_DETAIL.Action  ="/dcs/dbri333.db?goTo="+goTo+parameters;  
	TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_ADDR=DS_O_ADDR)"; //조회는 O
	TR_DETAIL.Post();
	
	if(DS_O_AGE.CountRow > 0){
		GR_ADDR.Focus();
	}else{
		EM_SALE_DT_FR.Focus();
	}
    
    // 조회결과 Return
    setPorcCount("SELECT",DS_O_AGE.RealCount(1, DS_O_AGE.CountRow));
    
    
  

 }

/**
 * fnChkEnable()
 * 작 성 자     :  
 * 작 성 일     : 2016-12-26
 * 개       요    : 대비일자 체크 박스 체크인 경우 그리드 처리
 * return값 : void
 */
function fnChkEnable(){
	 
		
		GR_AGE.ColumnProp("POST_TITLE", "name") = EM_FROM_ENT_DT.TEXT + " ~ " +EM_TO_ENT_DT.TEXT;  
		GR_AGE.ColumnProp("PRE_TITLE", "name") = EM_SALE_DT_FR.TEXT + " ~ " + EM_SALE_DT_TO.TEXT;    
		
}


-->
</script>



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
<script language=JavaScript for=GR_AGE event=OnClick(row,colid)>
    //sortColId( eval(this.DataID), row, colid);
    CUR_GR = this;
</script>
<script language=JavaScript for=GR_ADDR event=OnClick(row,colid)>
    //sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=DS_O_ADDR event=OnRowPosChanged(row)>
if(row > 0 && old_Row > 0){
}
old_Row = row;

</script>

<!-- 기준조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_SALE_DT_FR event=onKillFocus()>
    if(!checkDateTypeYMD(EM_SALE_DT_FR)){
    	EM_SALE_DT_FR.text = <%=strFromDate%>;
    }
</script>
    
<!-- 기준조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_SALE_DT_TO event=onKillFocus()>
	if(!checkDateTypeYMD(EM_SALE_DT_TO)){
		EM_SALE_DT_TO.text = <%=strToDate%>;
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
<object id="DS_O_ADDR" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AGE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
	
    var obj   = document.getElementById("GR_ADDR");
    var obj2  = document.getElementById("GR_AGE");
    
    var grd_height = 0;
    
    //alert(top);
    //alert((parseInt(window.document.body.clientHeight)));
    
    if((parseInt(window.document.body.clientHeight)) <= obj2.height) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top-obj2.height);
    }
    
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
		                <th width="100" class="point">점</th>
		                <td width="150" ><comment id="_NSID_"> <object
		                   id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
		            	<th width="100" class="point">매출일자</th>
						<td width="250"><comment id="_NSID_"> <object
							id=EM_SALE_DT_FR classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_SALE_DT_FR)" />-
							<comment id="_NSID_"> <object 
							id=EM_SALE_DT_TO classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_SALE_DT_TO)" /></td>
						<th width="80" class="point">브랜드</th>
			            <td width="200"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
			                classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
			                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
			                src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
			                onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"
			                align="absmiddle" /> <comment id="_NSID_"> <object
			                id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
			                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
			            </td> 
			            <th>원단위구분</th>
						<td style="border-right:0px">
						<comment id="_NSID_"> 
							<object id="RD_SELGUBUN" classid="<%=Util.CLSID_RADIO%>" width=200 height=18 align="absmiddle">
								<param name="Cols"   value="2">
								<param name="Format" value="1^구매건수기준,2^매출액기준">
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
		<td class="PB03">
		<table width="100%" height=380 border="0" cellspacing="0" cellpadding="0"
			>
			
			<tr>
                 <td width="100%">
                 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<td style="border-right:0px">  
							<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  align="absmiddle" /> <font style="font-size:13" align="absmiddle"><b>연령 구간 집계</b></font><font id=PUMBUNNM2></font>
						</td>  
					</tr>
				</table>
                 </td>			
			</tr>
			<tr>
                 <td width="100%">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GR_AGE width=100% height=350 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_AGE">
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
						
						<td style="border-right:0px">  
						<comment id="_NSID_"> <object
							id=EM_FROM_ENT_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle" style="display:none"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_ENT_DT)"  style="display:none"/>
							<comment id="_NSID_"> <object 
							id=EM_TO_ENT_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle" style="display:none"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_ENT_DT)" style="display:none" /> 
							<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  align="absmiddle" /> <font style="font-size:13" align="absmiddle"><b>지역별 집계</b></font><font id=PUMBUNNM1 ></font>
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
                     id=GR_ADDR width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_ADDR">
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


<script language="javascript" type="text/javascript">	

</script>

</body>
</html>
