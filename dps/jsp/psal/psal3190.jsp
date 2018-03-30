<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal3190.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 마진별매출실적(브랜드별)
 * 이    력 :2010.04.25 박종은
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
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
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
	
        
       
   
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);             //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^0,NAME^0^80", 1, NORMAL);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^0,NAME^0^80", 1, NORMAL);        //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //PC(조회)
    
  	//단위(01:원,02:천원)
    initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL);				
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';
    
    getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   				// 점		
    //getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N", "", strOrgFlag);                                  			// 팀		
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           			// 파트		
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);  // PC
    getEtcCode("DS_UNIT"    , "D", "P622", "N"); 																		// 단위
    getEtcCode("DS_DEPT_CD"    , "D", "D214", "N"); 																		// 단위
    getEtcCode("DS_TEAM_CD"    , "D", "D214", "N"); 																		// 단위
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.BindColVal = "2200";
    LC_PC_CD.Index   = 0;
    EM_UNIT.Index 	 = 1;
    
 	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    orgFlagCheck(orgFlag);
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal319","DS_O_MASTER" );
    
    document.getElementById("LC_PC_CD").style.display = "none";
    document.getElementById("EM_UNIT").style.display = "none";
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}			name="NO"		width=30    align=center    </FC>'
			     	 + '<FC>id=STR_CD			name="점코드"	width=30    align=center	suppress=2 show=false</FC>'
    				 + '<FG>					name="구분"'
                     + '<FC>id=SALE_DT   	    name="일자"		width=100    align=center	suppress=2	SubSumText={decode(curlevel,1,"소  계")} mask={decode(len(SALE_DT),8,"XXXX/XX/XX","")}	 SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=WEEK				name="요일"		width=70    align=center	suppress=1	  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SALE_TIME		name="시간대"	width=80    align=center	displayformat="XXX:XX"	SubSumText=""  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'                     
                     + '</FG>'
        			 + '<FG>					name="전층 합계"'
        			 + '<FC>id=CNT_TOT 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_TOT)}		sumtext={round(subsum(CNT_TOT))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_TOT 			name="매출" 	    width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_TOT)}			sumtext={round(subsum(AMT_TOT))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'        			 
                     + '<FG>					name="B1층"'
        			 + '<FC>id=CNT_B1 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_B1)}		sumtext={round(subsum(CNT_B1))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_B1 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_B1)}			sumtext={round(subsum(AMT_B1))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="1층"'
        			 + '<FC>id=CNT_01 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_01)}		sumtext={round(subsum(CNT_01))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_01 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_01)}			sumtext={round(subsum(AMT_01))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="2층"'
        			 + '<FC>id=CNT_02 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_02)}		sumtext={round(subsum(CNT_02))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_02 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_02)}			sumtext={round(subsum(AMT_02))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="3층"'
        			 + '<FC>id=CNT_03 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_03)}		sumtext={round(subsum(CNT_03))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_03 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_03)}			sumtext={round(subsum(AMT_03))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="4층"'
        			 + '<FC>id=CNT_04 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_04)}		sumtext={round(subsum(CNT_04))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_04 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_04)}			sumtext={round(subsum(AMT_04))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="5층"'
        			 + '<FC>id=CNT_05 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_05)}		sumtext={round(subsum(CNT_05))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_05 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_05)}			sumtext={round(subsum(AMT_05))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="6층"'
        			 + '<FC>id=CNT_06 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_06)}		sumtext={round(subsum(CNT_06))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_06 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_06)}			sumtext={round(subsum(AMT_06))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="7층"'
        			 + '<FC>id=CNT_07 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_07)}		sumtext={round(subsum(CNT_07))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_07 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_07)}			sumtext={round(subsum(AMT_07))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="8층"'
        			 + '<FC>id=CNT_08 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_08)}		sumtext={round(subsum(CNT_08))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_08 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_08)}			sumtext={round(subsum(AMT_08))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="9층"'
        			 + '<FC>id=CNT_09 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_09)}		sumtext={round(subsum(CNT_09))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_09 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_09)}			sumtext={round(subsum(AMT_09))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="10층"'
        			 + '<FC>id=CNT_10 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_10)}		sumtext={round(subsum(CNT_10))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_10 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_10)}			sumtext={round(subsum(AMT_10))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="11층"'
        			 + '<FC>id=CNT_11 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_11)}		sumtext={round(subsum(CNT_11))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_11 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_11)}			sumtext={round(subsum(AMT_11))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="12층"'
        			 + '<FC>id=CNT_12 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_12)}		sumtext={round(subsum(CNT_12))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_12 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_12)}			sumtext={round(subsum(AMT_12))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="13층"'
        			 + '<FC>id=CNT_13 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_13)}		sumtext={round(subsum(CNT_13))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_13 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_13)}			sumtext={round(subsum(AMT_13))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="14층"'
        			 + '<FC>id=CNT_14 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_14)}		sumtext={round(subsum(CNT_14))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_14 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_14)}			sumtext={round(subsum(AMT_14))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="15층"'
        			 + '<FC>id=CNT_15 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_15)}		sumtext={round(subsum(CNT_15))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_15 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_15)}			sumtext={round(subsum(AMT_15))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="16층"'
        			 + '<FC>id=CNT_16 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_16)}		sumtext={round(subsum(CNT_16))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_16 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_16)}			sumtext={round(subsum(AMT_16))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="17층"'
        			 + '<FC>id=CNT_17 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_17)}		sumtext={round(subsum(CNT_17))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_17 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_17)}			sumtext={round(subsum(AMT_17))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'
        			 + '<FG>					name="18층"'
        			 + '<FC>id=CNT_18 			name="객수"     width=100    align=right	   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(CNT_18)}		sumtext={round(subsum(CNT_18))}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '<FC>id=AMT_18 			name="매출" 	   width=100    align=right    mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	value={round(AMT_18)}			sumtext={round(subsum(AMT_18))}  		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}	</FC>'
        			 + '</FG>'

    	             + '<FC>id=level			name=레벨 Value={CurLevel} show = false  </FC>'
                     ;
    	          
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    //GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
    //DS_O_MASTER.SubSumExpr  = "2:TEAM_CD, 1:PC_CD" ; 
    //GD_MASTER.ColumnProp("BRD_NAME", "sumtext")        = "합계";
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
    
    
    if (EM_SALE_DT_S.text==EM_SALE_DT_E.text){
    	chkavgbox.checked = false;
    }
    
    /* 소계출력 여부 */
    if(chkbox.checked == true){
    	DS_O_MASTER.SubSumExpr  = "1:SALE_DT" ;
	}else{
	 	DS_O_MASTER.SubSumExpr  = "" ;
    }
    
    var strChkTot = "N";
    var strChkAvg = "N";
    var strChkOnl = "N";
    
    if(chktotbox.checked == true){
    	strChkTot = "Y" ;
	}
    if(chkavgbox.checked == true){
    	strChkAvg = "Y" ;
    }
    if(chkonlbox.checked == true){
    	strChkOnl = "Y" ;
    }
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strSaleTmS="         +encodeURIComponent(strDeptCd)
                   + "&strSaleTmE="         +encodeURIComponent(strTeamCd)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
                   + "&strChkTot="			+encodeURIComponent(strChkTot)
                   + "&strChkAvg="			+encodeURIComponent(strChkAvg)
                   + "&strChkOnl="			+encodeURIComponent(strChkOnl);
    
    
    TR_MAIN.Action="/dps/psal319.ps?goTo="+goTo+parameters;  
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

    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "시간대매출속보현황";
    //(협력사 브랜드별)";

    var strStrCd        = LC_STR_CD.Text;      		 //점
    var strDeptCd       = LC_DEPT_CD.Text;     		 //팀
    var strTeamCd       = LC_TEAM_CD.Text;     		 //파트
    var strPCCd         = LC_PC_CD.Text;       	 	 //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    var strEmUnit 		= EM_UNIT.text; 			 //단위
    
    var parameters = "점 "           + strStrCd
                   + " ,   팀 "     + strDeptCd
                   + " ,   파트 "       + strTeamCd
                   + " ,   PC "      + strPCCd
                   + " ,   매출기간 "  + strSaleDtS
                   + " ~ " + strSaleDtE
                   + " ,단위" + strEmUnit;
    
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
            showMessage(Information, OK, "US팀-1003","팀");
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
	    //getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    //getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal = strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	    
		   
		
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                   //점		
	    //getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	    //getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
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
	
	//getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
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
       // insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    //LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
    if(LC_TEAM_CD.BindColVal != "%"){
    	//getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC   
    }else{
        //DS_PC_CD.ClearData();
        //insComboData( LC_PC_CD, "%", "전체",1);
    }
    //LC_PC_CD.Index   = 0;
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
    
    if (EM_SALE_DT_S.text==EM_SALE_DT_E.text){
    	chkavgbox.checked = false;
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
    
    if (EM_SALE_DT_S.text==EM_SALE_DT_E.text){
    	chkavgbox.checked = false;
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
               	<th width="70">조직구분</th>
                  <td width="105" colspan="9" >
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
                  <th width="70" class="point">매출기간</th>
                  <td width="205">
                  <comment id="_NSID_"> <object
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
                  <th width="70" >시간대</th>
                  <td width="205">
                  <comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                  ~                     
                  <comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <!-- >th width="70">PC</th>
                  <td width="105"--><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><!--/td-->
                  <th width = "70"></th>
				  <td><comment id="_NSID_">	<object	
				  	 id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	tabindex=1 
				  	 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
				  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox id=chkbox checked=true>소계출력
				  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox id=chktotbox checked=true>기간누계출력    
				  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox id=chkavgbox checked=true>평균누계출력
				  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox id=chkonlbox checked=true>온라인매출제외    
				  	 </td>
               </tr>
               <tr>
                  <td colspan="8">
					<font style="color: red; font-weight:bold">**수기등록브랜드는 제외**</font>
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
                     id=GD_MASTER width=100% height=430 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
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
