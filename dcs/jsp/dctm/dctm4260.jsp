<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 고객관리 > 회원관리 > 회원가입현황조회(브랜드)
 * 작 성 일 : 2012.05.23
 * 작 성 자 : 강진
 * 수 정 자 : 
 * 파 일 명 : dctm4260.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 회원가입현황조회(브랜드)
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
	
	// PID 확인을 위한 
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dcs.js"     type="text/javascript"></script>
<script language="javascript" 	src="/<%=dir%>/js/popup_dps.js" 	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<%
	String strFromMonth = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) + "01";
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--

var strToday          = "";                            // 현재날짜
var g_strPid 		  = "<%=pageName%>";  			   // PID
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 100;		//해당화면의 동적그리드top위치
 function doInit(){
	 //Master 그리드 세로크기자동조정  2013-07-17
	 
	 //alert(g_strPid);
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 obj   = document.getElementById("GR_MASTER2");
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

     strToday = getTodayDB("DS_O_RESULT");
     
     initTab("TAB_MAIN");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER_GUBUN"/>');
   
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //마스터_구분
     
     // EMedit에 초기화
     initEmEdit(EM_FROM_DT, "YYYYMM", PK);            // 시작일
     initEmEdit(EM_TO_DT, 	"YYYYMM", PK);            // 종료일
     initEmEdit(EM_O_PUMBUN_CD,   "CODE^6^0", 		   NORMAL);  		   //품번코드(조회)
     initEmEdit(EM_O_PUMBUN_NM,   "GEN^40",			   READ);  		   //품번명(조회)     
     
     //EM_FROM_DT.Text = strToday;
     EM_FROM_DT.Text = <%=strToMonth%>;
     //EM_TO_DT.Text = strToday; 
     EM_TO_DT.Text = <%=strToMonth%>;
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}    	name="NO"				width=30    Edit=none  align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
    	  			  + '<FC>id=ORG_CD			name="조직코드"    		width=100   Edit=none  align=center show=false BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
    	  			  + '<FC>id=ORG_NM			name="조직명"    		width=140   Edit=none  align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
                 	  + '<FC>id=ENTR_PBN		name="가입브랜드"    		width=80    Edit=none  align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
                	  + '<FC>id=ENTR_PBN_NAME	name="브랜드명"    		width=140   Edit=none  align=center SumText="합 계" BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
                	  + '<FC>id=GUBUN			name="구분"    			width=70   Edit=none  align=center  show=false  BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
                	  + '<FC>id=CNT				name="합계"    			width=70   Edit=none  align=right  bgcolor="#e6e6e6" SumText=@sum FontStyle="bold"</FC>'
                	  + '<C>id=01				name="01"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=02				name="02"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=03				name="03"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=04				name="04"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=05				name="05"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=06				name="06"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=07				name="07"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=08				name="08"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=09				name="09"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=10				name="10"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=11				name="11"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=12				name="12"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=13				name="13"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=14				name="14"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=15				name="15"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=16				name="16"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=17				name="17"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=18				name="18"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=19				name="19"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=20				name="20"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=21				name="21"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=22				name="22"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=23				name="23"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=24				name="24"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=25				name="25"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=26				name="26"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=27				name="27"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=28				name="28"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=29				name="29"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=30				name="30"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  + '<C>id=31				name="31"    			width=70   Edit=none  align=right SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                	  ;                     
     initGridStyle(GR_MASTER, "common", hdrProperies, false);
     GR_MASTER.ViewSummary =	"1";	//합계 보이기
 }
 
 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}    		name="NO"				width=30    Edit=none  align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
    	  			  + '<FC>id=ORG_CD				name="조직코드"    		width=100   Edit=none  align=center show=false </FC>'
    	  			  + '<FC>id=ORG_NM				name="조직명"    		width=140   Edit=none  align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </FC>'
                 	  + '<FC>id=ENTR_PBN			name="가입브랜드"    		width=80    Edit=none  align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </FC>'
                	  + '<FC>id=ENTR_PBN_NAME		name="브랜드명"    		width=140   Edit=none  align=center SumText="합 계" BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
                	  + '<FG>						name="일자 계" '
                	  + '<FC>id=DIA_CNT				name="계"    			width=70   Edit=none  align=right bgcolor="#e6e6e6"  SumText=@sum FontStyle="bold"</FC>'
                	  + '<FC>id=DI0_CNT				name="적립"    			width=70   Edit=none  align=right  SumText=@sum FontStyle="bold"</FC>'
                	  + '<FC>id=DI1_CNT				name="할인"    			width=70   Edit=none  align=right  SumText=@sum FontStyle="bold"</FC>'
					  + '</FG>'
					  + '<G>						name="01" '
					  + '<C>id=DIA_01				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_01				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_01				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="02" '
					  + '<C>id=DIA_02				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_02				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_02				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="03" '
					  + '<C>id=DIA_03				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_03				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_03				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="04" '
					  + '<C>id=DIA_04				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_04				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_04				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="05" '
					  + '<C>id=DIA_05				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_05				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_05				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="06" '
					  + '<C>id=DIA_06				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_06				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_06				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="07" '
					  + '<C>id=DIA_07				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_07				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_07				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="08" '
					  + '<C>id=DIA_08				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_08				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_08				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="09" '
					  + '<C>id=DIA_09				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_09				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_09				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="10" '
					  + '<C>id=DIA_10				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_10				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_10				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="11" '
					  + '<C>id=DIA_11				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_11				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_11				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="12" '
					  + '<C>id=DIA_12				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_12				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_12				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="13" '
					  + '<C>id=DIA_13				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_13				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_13				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="14" '
					  + '<C>id=DIA_14				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_14				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_14				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="15" '
					  + '<C>id=DIA_15				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_15				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_15				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="16" '
					  + '<C>id=DIA_16				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_16				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_16				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="17" '
					  + '<C>id=DIA_17				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_17				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_17				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="18" '
					  + '<C>id=DIA_18				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_18				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_18				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="19" '
					  + '<C>id=DIA_19				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_19				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_19				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="20" '
					  + '<C>id=DIA_20				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_20				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_20				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="21" '
					  + '<C>id=DIA_21				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_21				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_21				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="22" '
					  + '<C>id=DIA_22				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_22				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_22				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="01" '
					  + '<C>id=DIA_23				name="23"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_23				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_23				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="24" '
					  + '<C>id=DIA_24				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_24				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_24				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="25" '
					  + '<C>id=DIA_25				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_25				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_25				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="26" '
					  + '<C>id=DIA_26				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_26				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_26				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="27" '
					  + '<C>id=DIA_27				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_27				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_27				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="28" '
					  + '<C>id=DIA_28				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_28				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_28				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="29" '
					  + '<C>id=DIA_29				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_29				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_29				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="30" '
					  + '<C>id=DIA_30				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_30				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_30				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
					  + '<G>						name="31" '
					  + '<C>id=DIA_31				name="계"    			width=70   Edit=none  align=right bgcolor="#fafafa"   SumText=@sum </C>'
					  + '<C>id=DI0_31				name="적립"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '<C>id=DI1_31				name="할인"    			width=70   Edit=none  align=right  SumText=@sum BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
					  + '</G>'
                	  ;
					  

     initGridStyle(GR_MASTER2, "common", hdrProperies, false);
     GR_MASTER2.ViewSummary =	"1";	//합계 보이기
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
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 조회시 호출
 * return값 : void
 */
 function btn_Search() {
	 
	 var strGubun = getTabItemSelect("TAB_MAIN");
	 
	 searchMaster(strGubun);
	 
 }

/**
 * btn_New()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.05.23
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    
}


/**
 * btn_Excel()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var strStrCd		= "02";						 
    var strFromDt       = EM_FROM_DT.Text;         // 시작일자
    //var strToDt         = EM_TO_DT.Text;           // 종료일자
    var strGbFlag       = EM_O_PUMBUN_CD.Text;     // 브랜드
    
	var parameters = "";
		parameters  = "조회구분="+strStrCd                    
			    	+ " -조회기간="+ strFromDt
			    	//+ "~"+ strToDt
			    	+ " -브랜드="+ strGbFlag
			    	;
	switch(getTabItemSelect("TAB_MAIN")){
	    case 1:
	    	openExcel5(GR_MASTER, "회원가입현황조회(브랜드)", parameters, true, "",g_strPid );
	        break;
	    case 2:
	    	openExcel5(GR_MASTER2, "회원가입현황조회(브랜드)", parameters, true, "",g_strPid );
	        break;
		} 
	    
	}



/**
 * btn_Print()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * checkValidation()
  * 작 성 자     : 강진
  * 작 성 일     : 2012.05.23
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */	 
 function checkValidation(Gubun) {
	 switch (Gubun){
	    case "search" :
	        
			//매출일자
	        if (isNull(EM_FROM_DT.Text) ==true ) {
	            showMessage(Information, OK, "USER-1003","시작일자"); 
	            EM_FROM_DT.focus();
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_FROM_DT.Text.replace(" ","").length != 6 ) {
	            showMessage(Information, OK, "USER-1027","시작일자","6");
	            EM_FROM_DT.focus();
	            return false;
	        }
	        if(!checkYYYYMM(EM_FROM_DT.Text)){
	        	showMessage(Information, OK, "USER-1004","시작일자");
	        	EM_FROM_DT.focus();
	            return false;
	        }
	        	
	        if (isNull(EM_TO_DT.Text) ==true ) {
	            showMessage(Information, OK, "USER-1003","종료일자"); 
	            EM_TO_DT.focus();
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_TO_DT.Text.replace(" ","").length != 6 ) {
	            showMessage(Information, OK, "USER-1027","종료일자","6");
	            EM_TO_DT.focus();
	            return false;
	        }
	        if(!checkYYYYMM(EM_TO_DT.Text)){
	            showMessage(Information, OK, "USER-1004","종료일자");
	            EM_TO_DT.focus();
	            return false;
	        }
	        
	        if(!isBetweenFromTo(EM_FROM_DT.Text, EM_TO_DT.Text)){
	            showMessage(INFORMATION, OK, "USER-1015"); 
	            EM_FROM_DT.focus();
	            return false;
	        }
	        /*
	        if(daysBetween(EM_FROM_DT.Text, EM_TO_DT.Text) >= 31){
	        	showMessage(INFORMATION, OK, "USER-1000","조회기간은 30일을 넘을 수 없습니다."); 
	        	EM_FROM_DT.focus();
	            return false;
	        }
	        */
	        break;
	   
	    }
	    return true;
      
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

 function searchMaster(strGubun) {
	 if(!checkValidation("search")) return;
		
		var tfChkInmall = document.getElementById("CHK_INMALL").checked;
		var tfChkMobile = document.getElementById("CHK_MOBILE").checked;
		var strOptions	= "";
		
		if (tfChkInmall&&tfChkMobile) {
			strOptions = "%";
		} else {
			if (tfChkInmall)
				strOptions = "C";
			else
				strOptions = "M";
		}
		
		var objDS 	  	= "";
		var objGR 	  	= "";
		var strDSName 	= "";
		var strHeadName = "";
			
		if (strGubun==1) {
			objDS		= DS_IO_MASTER;
			objGR		= GR_MASTER;
			strDSName	= "DS_IO_MASTER";
			strHeadName = "H_MASTER";
		} else {
			objDS = DS_IO_MASTER2;
			objGR = GR_MASTER2;
			strDSName	= "DS_IO_MASTER2";
			strHeadName = "H_MASTER_GUBUN";
		}
			
			
		 
		objDS.ClearData(); 
	    // 조회조건 셋팅
	    var strFromDt       = EM_FROM_DT.text;      // 시작일자
	    //var strToDt         = EM_TO_DT.text;        // 종료일자
	    var strGbFlag       = EM_O_PUMBUN_CD.Text;  // 브랜드
	    
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters =  "&strFromDt=" + encodeURIComponent(strFromDt)
					    //+ "&strToDt="   + encodeURIComponent(strToDt)
					    + "&strGbFlag=" + encodeURIComponent(strGbFlag)
					    + "&strOptions=" + encodeURIComponent(strOptions)
					    + "&strDSName=" + encodeURIComponent(strDSName)
					    + "&strHeadName=" + encodeURIComponent(strHeadName)
					    ; 
	    
	    TR_MAIN.Action  = "/dcs/dctm426.dm?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue= "SERVLET("+action+":"+strDSName+"="+strDSName+")"; 
	    TR_MAIN.Post();
	 
	    objGR.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", objDS.CountRow);

	    //스크롤바 위치 조정
	    objGR.SETVSCROLLING(0);
	    objGR.SETHSCROLLING(0);
 }
 
 
 
-->
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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 품번(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	    
	if(this.text==''){
		EM_O_PUMBUN_NM.Text = "";
	    return;
	}          
	setPumbunCdCombo("NAME");
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
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>	
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER2"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    var obj2   = document.getElementById("GR_MASTER2");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    obj2.style.height  = grd_height + "px";
    
    
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60" class="point">가입기간</th>
            <td width="140">
                  <comment id="_NSID_">
                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('M',EM_FROM_DT)" align="absmiddle" />
                   
                  <comment id="_NSID_">
                      <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle" style="display : none">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TO_DT" onclick="javascript:openCal('G',EM_TO_DT)" align="absmiddle" style="display : none" />
            </td>
            <th width="60" class="point">브랜드</th>
            <td>
            		<comment id="_NSID_">
                	<object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1  align="absmiddle">
                	</object></comment><script> _ws_(_NSID_);</script>
	                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCdCombo('POP'); EM_O_PUMBUN_CD.Focus();"  align="absmiddle" />
	                <comment id="_NSID_">
	                <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1  align="absmiddle">
	                </object></comment><script> _ws_(_NSID_);</script>
	                <input type="checkbox" id=CHK_INMALL checked onclick="fnChk(this);"> 점내 가입
					<input type="checkbox" id=CHK_MOBILE checked onclick="fnChk(this);"> 모바일 가입
            </td>
            <!--  
            <th width="10" class="point"></th>
            <td width="150"></td>
            -->            
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>

  <tr valign="top">
    <td>
    	<div id=TAB_MAIN  width="100%" height=870 TitleWidth=90  TitleAlign="center" >
		<menu TitleName="혜택합산"       DivId="tab_page1" Enable='true' />
		<menu TitleName="혜택구분"       DivId="tab_page2" Enable='true' />
		</div>
		<div id=tab_page1 width="100%" >
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr valign="top">
	        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
	          <tr>
	            <td width="100%">
	                <comment id="_NSID_">
	                    <OBJECT id=GR_MASTER width=100% height=780 classid=<%=Util.CLSID_GRID%>>
	                        <param name="DataID" value="DS_IO_MASTER"> 
	                    </OBJECT>
	                </comment><script>_ws_(_NSID_);</script>
	            </td>
	          </tr>
	        </table></td>
	      </tr>
	    </table>
	    </div>
	    <div id=tab_page2 width="100%" >
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		      <tr valign="top">
		        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
		          <tr>
		            <td width="100%">
		                <comment id="_NSID_">
		                    <OBJECT id=GR_MASTER2 width=100% height=780 classid=<%=Util.CLSID_GRID%>>
		                        <param name="DataID" value="DS_IO_MASTER2"> 
		                    </OBJECT>
		                </comment><script>_ws_(_NSID_);</script>
		            </td>
		          </tr>
		        </table></td>
		      </tr>
		    </table>
	    </div>
    </td>
  </tr>  
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

