<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원 매출 객단가 현황(일)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3300.jsp
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
<%String dir = BaseProperty.get("context.common.dir");%>
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
	
	// PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
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
 var old_Row = 0; 
 var top = 10;		//해당화면의 동적그리드top위치
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
	    
	    document.getElementById("EM_FROM_CS_DT").style.display = "none";
	    document.getElementById("EM_TO_CS_DT").style.display = "none";
	}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}      			name="NO"           	width=30    align=center	</FC>'
                     + '<FC>id=HEADER_ADDR       		name="시 / 도 / 군"      width=200   align=left  SumText= "합 계"</FC>'
                     + '<FC>id=TOT_AMT   				name="회원매출"  			width=120    align=right SumText=@sum</FC>'
                     + '<FC>id=SALE_RATE   				name="매출구성비"     	width=80    align=right </FC>'
                     + '<FC>id=CUST_CNT     			name="구매객수"			width=90   align=right SumText=@sum</FC>'
                     + '<FC>id=SALE_CNT     			name="구매건수" 			width=90    align=right SumText=@sum </FC>'
                     + '<FC>id=SIDO   					name="시도"   			width=80    align=right show=false</FC>'
                     + '<FC>id=SIGUNGU   				name="시군구"   			width=80    align=right show=false</FC>'
                     + '<FC>id=STR_CD    				name="점코드"			width=120   align=right show=false</FC>'
                     + '<FC>id=SDT   					name="매출시작"  			width=60    align=right show=false </FC>'
                     + '<FC>id=EDT   					name="매출종료"			width=80    align=right show=false</FC>'
                     + '<FC>id=BF_SDT   				name="대비시작"			width=80    align=right show=false</FC>'
                     + '<FC>id=BF_EDT   				name="대비종료"   	    width=100   align=right show=false</FC>'
                     + '<FC>id=OVERSUM   				name="총계"     			width=80    align=right show=false</FC>'
                     ; 
			         
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

function gridCreate2(){
	var hdrProperies = '<FC>id={currow}      			name="NO"           	width=30    align=center	</FC>'
                     + '<FC>id=HEADER_ADDR       		name="구" 		      	width=200   align=left  SumText="지역 계"/FC>'
                     + '<FC>id=DETAIL_ADDR       		name="읍/면/동/리"       	width=200   align=left  </FC>'
                     + '<FC>id=TOT_AMT   				name="회원매출"  			width=120    align=right SumText=@sum</FC>'
                     + '<FC>id=SALE_RATE   				name="매출구성비"     	width=80    align=right </FC>'
                     + '<FC>id=CUST_CNT     			name="구매객수"			width=90   align=right SumText=@sum</FC>'
                     + '<FC>id=SALE_CNT     			name="구매건수" 			width=90    align=right SumText=@sum </FC>'
                     + '<FC>id=SIDO   					name="시도"   			width=80    align=right show=false</FC>'
                     + '<FC>id=SIGUNGU   				name="시군구"   			width=80    align=right show=false</FC>'
                     + '<FC>id=STR_CD    				name="점코드"			width=120   align=right show=false</FC>'
                     + '<FC>id=SDT   					name="매출시작"  			width=60    align=right show=false </FC>'
                     + '<FC>id=EDT   					name="매출종료"			width=80    align=right show=false</FC>'
                     + '<FC>id=BF_SDT   				name="대비시작"			width=80    align=right show=false</FC>'
                     + '<FC>id=BF_EDT   				name="대비종료"   	    width=100   align=right show=false</FC>'
                     + '<FC>id=OVERSUM   				name="총계"     			width=80    align=right show=false</FC>'
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
	     if (isNull(LC_STR_CD.BindColVal)==true ) {
	         showMessage(Information, OK, "USER-1003","점");
	         LC_STR_CD.focus();
	         return false;
	     }
	     	 

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
		strTitle = "지역별 회원 매출(집계)";
	}else if(rtnVal == "2"){
		objGrd = GD_DETAIL;
		strTitle = "지역별 회원 매출(상세 집계)";
	}else{
		return;
	}
	
	var parameters = "매출조회시작일자="     + EM_FROM_BS_DT.Text
				   + "매출조회종료일자="     + EM_TO_BS_DT.Text
				   + "가입조회시작일자="     + EM_FROM_ENT_DT.Text
				   + "가입조회종료일자="     + EM_TO_ENT_DT.Text;
	
	var obj  = document.getElementById("CHK_ILJA");
	/*
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

	old_Row = DS_MASTER.RowPosition; 
	 
	var goTo        = "searchMaster";    
    var action      = "O";
    var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
					+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text)
					+ "&strFromCSDate="+ encodeURIComponent(EM_FROM_CS_DT.Text)
					+ "&strToCSDate="  + encodeURIComponent(EM_TO_CS_DT.Text)
					+ "&strFromENTDate="+ encodeURIComponent(EM_FROM_ENT_DT.Text)
					+ "&strToENTDate="  + encodeURIComponent(EM_TO_ENT_DT.Text)
					+ "&strStrCd="  + encodeURIComponent(LC_STR_CD.BindColVal)
					+ "&strLocalNm="  + encodeURIComponent(EM_LOCAL_NM.TEXT);
    TR_MAIN.Action  ="/dcs/dbri330.db?goTo="+goTo+parameters;  
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
	
	if(DS_MASTER.CountRow <= 0) return false;
	 
	var strSido 	= DS_MASTER.NameValue(DS_MASTER.RowPosition, "SIDO");
	var strSigun 	= DS_MASTER.NameValue(DS_MASTER.RowPosition, "SIGUN");
	var numOverSum 	= DS_MASTER.NameValue(DS_MASTER.RowPosition, "TOT_AMT");
	
	var goTo        = "searchDetail";    
    var action      = "O";
	var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
					+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text)
					+ "&strFromCSDate="+ encodeURIComponent(EM_FROM_CS_DT.Text)
					+ "&strToCSDate="  + encodeURIComponent(EM_TO_CS_DT.Text)
					+ "&strFromENTDate="+ encodeURIComponent(EM_FROM_ENT_DT.Text)
					+ "&strToENTDate="  + encodeURIComponent(EM_TO_ENT_DT.Text)
					+ "&strStrCd="  + encodeURIComponent(DS_MASTER.NameValue(DS_MASTER.RowPosition, "STR_CD"))
					+ "&strSido="	+ encodeURIComponent(strSido.trim())
					+ "&strSigungu="+ encodeURIComponent(strSigun.trim())
					+ "&numOverSum="+ encodeURIComponent(numOverSum);
	TR_DETAIL.Action  ="/dcs/dbri330.db?goTo="+goTo+parameters;  
	TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	TR_DETAIL.Post();
	
	    // 조회결과 Return
    setPorcCount("SELECT",DS_O_DETAIL.RealCount(1, DS_O_DETAIL.CountRow));
	/*    
    if(DS_O_DETAIL.CountRow > 0){
		GD_DETAIL.Focus();
	}else{
		EM_FROM_BS_DT.Focus();
	}
	alert("!");
	*/

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
//if(row > 0 && old_Row > 0) {
if (row != old_Row )
	searchDetail();
//}
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
		                <th width="100" class="point">점</th>
		                <td width="200"><comment id="_NSID_"> <object
		                   id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
		                <th width="100" >시/도/군 명</th>
		                <td width="200" colspan ="3"><comment id="_NSID_"> <object
		                   id=EM_LOCAL_NM classid=<%=Util.CLSID_EMEDIT%> width=200 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               		</tr>
					<tr>
						<th width="100" class="point">매출일자</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_FROM_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_BS_DT)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_BS_DT)" /></td> 
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
							onclick="javascript:openCal('G',EM_TO_ENT_DT)" /></td> 
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
