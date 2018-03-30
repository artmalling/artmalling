<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원 매출 객단가 현황(일)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3310.jsp
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

<script type="text/javascript" src="/<%=dir%>/js/loader.js"></script>
<!-- script language="javascript" type="text/javascript" >	

	$(document).ready(function(){
		google.charts.load('current', {packages:['corechart'] });
		// 로딩 완료시 함수 실행하여 차트 생성
		if (typeof google.charts == 'undefined') {
			alert("undefined");
		} 
		else
			{
				//alert("요");
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {
					
					// 차트 데이터 설정
					var data = google.visualization.arrayToDataTable([
						['항목', '다리수'], // 항목 정의
						['개', 4], // 항목, 값 (값은 숫자로 입력하면 그래프로 생성됨)
						['메뚜기', 6],
						['문어', 8],
						['오징어', 10],
						['여기 운영자', 2]
					]);

					// 그래프 옵션
					var options = {
						width : 600, // 가로 px
						height : 400, // 세로 px
						bar : {
							groupWidth : '80%' // 그래프 너비 설정 %
						},
						legend : {
							position : 'none' // 항목 표시 여부 (현재 설정은 안함)
						}
					};

					var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
					chart.draw(data, options);
				}
			}
			
	});
	

	
</script-->

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
 var top = 100;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID 
 function doInit(){

		//Master 그리드 세로크기자동조정  2013-07-17
		//var obj   = document.getElementById("GR_MASTER");
		//	obj2  = document.getElementById("GD_DETAIL");

	 	//	obj2.style.height  = (parseInt(window.document.body.clientHeight)-top-obj.height-40) + "px";


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
	    //initEmEdit(EM_FROM_CS_DT, "YYYYMMDD",  PK);           // 대비조회일
	    //initEmEdit(EM_TO_CS_DT, "YYYYMMDD",  PK);           // 대비조회일    
	    //initEmEdit(EM_LOCAL_NM, "GEN^200",   NORMAL);            //브랜드(조회)
	 
	    
	    
	    //조회기간 초기값.
	    EM_FROM_BS_DT.text = <%=strFromDate%>;
	    EM_TO_BS_DT.text = <%=strToDate%>;
	    EM_FROM_ENT_DT.text = <%=strFromDate%>;
	    EM_TO_ENT_DT.text = <%=strToDate%>;
	    //EM_FROM_CS_DT.text = <%=strFromDate%>;
	    //EM_TO_CS_DT.text = <%=strToDate%>;    
	    LC_STR_CD.BindColVal  = strcd;  
	    
	    //화면 OPEN시 자동 조회
	    //btn_Search();
	    	// 차트를 사용하기 위한 준비입니다.
	
	    document.getElementById("EM_FROM_CS_DT").style.display = "none";
	    document.getElementById("EM_TO_CS_DT").style.display = "none";
	    document.getElementById("EM_LOCAL_NM").style.display = "none";
	    
		    
}
 



function gridCreate1(){
	var hdrProperies = '<FC>id={currow}      			name="NO"           	width=30    align=center </FC>'
                     + '<FC>id=GUBUN1           		name="구분" 			    width=90   	align=center   Suppress=2 </FC>'
                     + '<FC>id=GUBUN2   				name="맴버쉽구분"			width=120   align=center  </FC>'
                     + '<G> id = POST_TITLE				name=""	'
                     + '<FC>id=PRE		   				name="前"  		   		width=150   align=right  </FC>'
                     + '<FC>id=PRE_RATIO     			name="구성비"			width=100  	align=right  </FC>'
                     + '</G> '
                     + '<G> id = PRE_TITLE				name=""	'
                     + '<FC>id=POST     				name="後" 				width=150   align=right  </FC>'
                     + '<FC>id=POST_RATIO   			name="구성비"   			width=100   align=right  </FC>'
                     + '</G> '
                     + '<FC>id=TOT   					name="총계"   			width=120   align=right  /FC>'
                     + '<FC>id=TOT_RATIO    			name="구성비"			width=90    align=right  </FC>'
                     + '<FC>id=INCR   					name="증감"  			width=120   align=right  color = {if(INCR<0,"#FF0000")}</FC>'
                     + '<FC>id=INCR2   					name=" "				width=60    align=center color ={decode(INCR2,"▲","#0000FF","▼","#FF0000","#000000")} </FC>'
                     ;
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    //GR_MASTER.ViewSummary = "1";
}

function gridCreate2(){
	var hdrProperies = '<FC>id={currow}      		name="NO"           	width=30    align=center	</FC>'
                     + '<FC>id=SALE_DT       		name="일자" 		      	width=100   align=center  SumText="합   계" mask = "XXXX/XX/XX" </FC>'
                     + '<FC>id=GUBUN       			name="조회구분"       	width=100   align=center  value = {decode(GUBUN,"PRE","매출","대비")} show = false </FC>'
                     + '<FC>id=TOT_AMT   			name="총 매출"  			width=120    align=right SumText=@sum</FC>'
                     + '<G>							name="회원"'
                     + '<FC>id=MEMB_AMT   			name="매출"  		   	width=120    align=right SumText=@sum </FC>'
                     + '<FC>id=MEMB_AMT_RATIO     	name="구성비"			width=90   align=right </FC>'
                     + '</G>'
                     + '<G>							name="일반"'
                     + '<FC>id=NORM_AMT     		name="매출" 				width=120    align=right SumText=@sum </FC>'
                     + '<FC>id=NORM_AMT_RATIO   	name="구성비"   			width=90    align=right show=true</FC>'
                     + '</G>'
                     + '<FC>id=TOT_CNT   			name="객수"   			width=100    align=right SumText=@sum show=true</FC>'
                     + '<FC>id=TOT_AMT_CNT    		name="객단가"			width=100   align=right show=true</FC>'
                     + '<G>							name="회원"'
                     + '<FC>id=MEMB_CNT   			name="객수"  			width=100    align=right SumText=@sum show=true </FC>'
                     + '<FC>id=MEMB_AMT_CNT   		name="객단가"			width=100    align=right show=true</FC>'
                     + '</G>'
                     + '<G>							name="일반"'
                     + '<FC>id=NORM_CNT   			name="객수"				width=100    align=right SumText=@sum show=true</FC>'
                     + '<FC>id=NORM_AMT_CNT   		name="객단가"	   	    width=100   align=right show=true</FC>'
                     + '</G>'
                     + '<FC>id=ENTR_CNT   			name="가입회원수" 		width=100    align=right SumText=@sum show=true</FC>'
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
		objGrd = GD_DETAIL;
		strTitle = "회원매출객수객단가비교(일자별)";
	}else if(rtnVal == "2"){
		objGrd = GR_MASTER;
		strTitle = "회원매출객수객단가비교(일자별)";
	}else{
		return;
	}
	
	var parameters = "매출조회시작일자="     + EM_FROM_BS_DT.Text
				   + "매출조회종료일자="     + EM_TO_BS_DT.Text
				   + "대비조회시작일자="     + EM_FROM_ENT_DT.Text
				   + "대비조회종료일자="     + EM_TO_ENT_DT.Text;
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
    
	var goTo        = "searchMaster";    
    var action      = "O";
    var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
					+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text)
					+ "&strFromENTDate="+ encodeURIComponent(EM_FROM_ENT_DT.Text)
					+ "&strToENTDate="  + encodeURIComponent(EM_TO_ENT_DT.Text)
					+ "&strStrCd="  + encodeURIComponent(LC_STR_CD.BindColVal)
    TR_MAIN.Action  ="/dcs/dbri331.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
        searchDetail();
        fnChkEnable();
        //drawChart_reday();
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
	
	//var strSido = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SIDO");
	//var strSigun = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SIGUN");
	
	
	if(DS_MASTER.CountRow <= 0) return false;
	
	var goTo        = "searchDetail";    
    var action      = "O";
	var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
					+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text)
					+ "&strFromENTDate="+ encodeURIComponent(EM_FROM_ENT_DT.Text)
					+ "&strToENTDate="  + encodeURIComponent(EM_TO_ENT_DT.Text)
					+ "&strStrCd="  + encodeURIComponent(LC_STR_CD.BindColVal)
					;
	TR_DETAIL.Action  ="/dcs/dbri331.db?goTo="+goTo+parameters;  
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
	 
		
		GR_MASTER.ColumnProp("POST_TITLE", "name") = EM_FROM_ENT_DT.TEXT + " ~ " +EM_TO_ENT_DT.TEXT;  
		GR_MASTER.ColumnProp("PRE_TITLE", "name") = EM_FROM_BS_DT.TEXT + " ~ " + EM_TO_BS_DT.TEXT;    
		
}
	
<!--
function drawChart_reday() {
	
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
	
    function drawChart() {
        var data = new google.visualization.DataTable();
    		    data.addColumn('string', '매출 기간');
    		    data.addColumn('number', 'Motivation Level');
    		    data.addColumn('number', 'Energy Level');

        data.addRows([
          ['20170501', 1, .25],
          ['20170102', 2, .25],
          ['20170103', 3, .25],
          ['20170104', 6, .25],
          ['20170105', 1, .25],
          ['20170106', 2, .25],
          ['20170107', 4, .25],
          ['20170108', 3, .25],
          ['20170501', 1, .25],
          ['20170102', 2, .25],
          ['20170103', 3, .25],
          ['20170104', 6, .25],
          ['20170105', 1, .25],
          ['20170106', 2, .25],
          ['20170107', 4, .25],
          ['20170108', 3, .25],
          ['20170501', 1, .25],
          ['20170102', 2, .25],
          ['20170103', 3, .25],
          ['20170104', 6, .25],
          ['20170105', 1, .25],
          ['20170106', 2, .25],
          ['20170107', 4, .25],
          ['20170108', 3, .25]
         
        ]);
		var strTest = encodeURIComponent(DS_MASTER.NameValue(DS_MASTER.RowPosition, "GUBUN2"));
		alert(strTest);
        var options = {
          title: strTest,
          trendlines: {
            0: {type: 'linear', lineWidth: 5, opacity: .3},
            1: {type: 'exponential', lineWidth: 10, opacity: .3}
          },
	      width : 600, // 가로 px
		  height : 400, // 세로 px,
          hAxis: {
            title: 'Time of Day',
            format: 'h:mm a',
            viewWindow: {
              min: [1, 1, 1],
              max: [31, 30, 30]
            }
          },
          vAxis: {
            title: 'Rating (scale of 1-10)'
          }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, options);

        }
}
	
	
-->	


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
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    //sortColId( eval(this.DataID), row, colid);
    CUR_GR = this;
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
    CUR_GR = this;
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row > 0){
    
   
			

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
		                <th width="100" class="point">점</th>
		                <td width="200" colspan="7"><comment id="_NSID_"> <object
		                   id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
		                <!-- th width="100" >시/도/군 명</th>
		                <td width="200" colspan ="3"--><comment id="_NSID_"> <object
		                   id=EM_LOCAL_NM classid=<%=Util.CLSID_EMEDIT%> width=200 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><!-- /td-->
               		</tr>
					<tr>
						<th width="100" class="point">매출일자</th>
						<td width="1200"><comment id="_NSID_"> <object
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
						<!-- >th width="100"></th>
						<td width="800"></td--> 
						<!-- th width="100"><input type="checkbox" id=CHK_ILJA onclick="fnChkEnable();">대비일자</th> 
						<td --><comment id="_NSID_">  
							<object
							id=EM_FROM_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <!--img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_CS_DT)" /-->
							<comment id="_NSID_"> <object 
							id=EM_TO_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <!--img
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
                 <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_DETAIL">
                  </object> </comment><script>_ws_(_NSID_);</script></td>			
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
						<th width="100px">대비일자</th>
						<td style="border-right:0px">  
						<comment id="_NSID_"> <object
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
                     id=GR_MASTER width=100% height=400 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_MASTER">
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
