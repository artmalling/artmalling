<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2011.08.16
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal5400.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 마진별매출실적(협력사)
 * 이    력 :2011.08.16 박종은
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
 var top = 120;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER3"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER4"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER5"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER6"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');
    DS_O_MASTER3.setDataHeader('<gauce:dataset name="H_SEL_MASTER3"/>');
    DS_O_MASTER4.setDataHeader('<gauce:dataset name="H_SEL_MASTER4"/>');
    DS_O_MASTER5.setDataHeader('<gauce:dataset name="H_SEL_MASTER5"/>');
    DS_O_MASTER6.setDataHeader('<gauce:dataset name="H_SEL_MASTER6"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    gridCreate3();
    gridCreate4();
    gridCreate5();
    gridCreate6();
    
    //그리드 숨김
    document.getElementById("grid1").style.display = "";
    document.getElementById("grid2").style.display = "none";
    document.getElementById("grid3").style.display = "none";
    document.getElementById("grid4").style.display = "none";
    document.getElementById("grid5").style.display = "none";
    document.getElementById("grid6").style.display = "none";
    
    // EMedit에 초기화
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   // 시작일자
    EM_SALE_DT_S.alignment = 1;
    
    initEmEdit(EM_O_PUMBUN, "CODE^6^0", NORMAL);      //브랜드(조회)
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", NORMAL);     //브랜드(조회)

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   // 종료일자
    EM_SALE_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToMon+"01";
    EM_SALE_DT_E.text =  varToday;

   //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              // 점(조회)
    initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL);				// 단위

    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    
    getStore("DS_STR_CD", "Y", "1", "N");                                                  //점
    //getStore("DS_STR_CD", "N", "1", "Y");
    getEtcCode("DS_UNIT"    , "D", "P622", "N"); 									// 단위
    
    LC_STR_CD.BindColVal = strcd;
    //LC_STR_CD.Index=0;
    EM_UNIT.Index 	 = 1;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal540","DS_O_MASTER" );
    registerUsingDataset("psal540","DS_O_MASTER2" );
    registerUsingDataset("psal540","DS_O_MASTER3" );
    registerUsingDataset("psal540","DS_O_MASTER4" );
    registerUsingDataset("psal540","DS_O_MASTER5" );
    registerUsingDataset("psal540","DS_O_MASTER6" );
}


/**
 * setPumbunCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드 팝업을 실행한다.
 * return값 : void
**/
function setPumbunCode(evnFlag, svcFlag, codeObj, nameObj){
    
    if( evnFlag == 'POP'){
    	strPbnPop(codeObj,nameObj,'N')
        codeObj.Focus();        
        return;
    }
    
    if( codeObj.Text == ""){
        nameObj.Text = "";
        return;
    }
    
    setStrPbnNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 0);
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"		    	width=30    align=center    SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                    
                     + '<FC>id=PUMMOK_CD        name="품목코드"			width=80    align=center	</FC>'
                     + '<FC>id=PUMBOK_NM        name="온라인몰"			width=120   align=left     	</FC>'
                     + '<FC>id=PBN_CNT          name="누계 브랜드수"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"width=90    align=right		</FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     
                     + '<FC>id=DAY_SALE_AMT     name="당일 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right		mask="###,###"	   value={round(DAY_SALE_AMT/submax(UNIT))}		sumtext={round(subsum(DAY_SALE_AMT)/UNIT)}		</FC>'
                     + '<FC>id=ACC_SALE_AMT     name="누계 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	   value={round(ACC_SALE_AMT/submax(UNIT))} 	sumtext={round(subsum(ACC_SALE_AMT)/UNIT)}	    </FC>'//suppress=1
                     + '<FC>id=CUST_CNT 	    name="객수"				gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	   sumtext={subsum(CUST_CNT)}	        </FC>'//suppress=1
                     + '<FC>id=level            name=레벨 				Value={CurLevel}    width=50   show=false</FC>'
                     ;
    
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
  /*   DS_O_MASTER.SubSumExpr  = "3:TEAM_ORG_NAME, 2:PC_ORG_NAME, 1:VEN_CD " ; */
    GD_MASTER.ColumnProp("PUMBUN_NAME", "sumtext")        = "합계"; 
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}          name="NO"		    	width=30    align=center    SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                    
                     + '<FC>id=PUMMOK_CD         name="품목코드"		width=80    align=center    suppress=1	SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=PUMBOK_NM         name="온라인몰"		width=120   align=left      suppress=1  SubSumText="소 계"	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ONLINE_PC         name="온라인PC명"		width=150    align=left		suppress=2	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=PUMBUN_CD         name="브랜드코드"		width=90    align=center	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=PUMBUN_NM         name="브랜드명"		width=120   align=left		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     
                     + '<FC>id=DAY_SALE_AMT      name="당일 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right		mask="###,###"	value={round(DAY_SALE_AMT/submax(UNIT))}	sumtext={round(subsum(DAY_SALE_AMT)/UNIT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ACC_SALE_AMT      name="누계 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	value={round(ACC_SALE_AMT/submax(UNIT))}	sumtext={round(subsum(ACC_SALE_AMT)/UNIT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}   </FC>'//suppress=1
                     + '<FC>id=CUST_CNT		     name="객수"			gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	sumtext={subsum(CUST_CNT)}			SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}   </FC>'//suppress=1
                     + '<FC>id=level             name=레벨            	width=50    Value={CurLevel}       show=false</FC>'
                     ;
       
    
    initGridStyle(GD_MASTER2, "common", hdrProperies, false);
    //합계표시
    GD_MASTER2.ViewSummary = "1";
    GD_MASTER2.DecRealData = true;
    DS_O_MASTER2.SubSumExpr  = "1:PUMMOK_CD" ; 
    GD_MASTER2.ColumnProp("PUMBUN_NM", "sumtext")    = "합계"; 
}
function gridCreate3(){
    var hdrProperies = '<FC>id={currow}                name="NO"		    width=30     	align=center    SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                    
                     + '<FC>id=PUMMOK_CD               name="품목코드"		suppress=1   	width=80        align=center	SubSumText=""	    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=PUMBOK_NM               name="온라인몰"		suppress=1   	width=120       align=left	    SubSumText="소 계"	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ORG_CD                  name="PC 코드"		width=90     	align=center	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=ORG_NM                  name="PC 명"		    width=120    	align=left  	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	 </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     
                     + '<FC>id=DAY_SALE_AMT            name="당일 매출액"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   	align=right		mask="###,###"	value={round(DAY_SALE_AMT/submax(UNIT))}	sumtext={round(subsum(DAY_SALE_AMT)/UNIT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ACC_SALE_AMT            name="누계 매출액"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   	align=right  	mask="###,###" 	value={round(ACC_SALE_AMT/submax(UNIT))}	sumtext={round(subsum(ACC_SALE_AMT)/UNIT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}       </FC>'//suppress=1
                     + '<FC>id=CUST_CNT	 	           name="객수"			gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   	align=right  	mask="###,###" 	sumtext={subsum(CUST_CNT)}			SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}       </FC>'//suppress=1
                     + '<FC> id=level                  name=레벨 			Value={CurLevel}    width=50    show=false</FC>'
                     ;
       
    
    initGridStyle(GD_MASTER3, "common", hdrProperies, false);
    //합계표시
    GD_MASTER3.ViewSummary = "1";
    GD_MASTER3.DecRealData = true;
    DS_O_MASTER3.SubSumExpr  = "1:PUMMOK_CD" ; 
    GD_MASTER3.ColumnProp("ORG_NM", "sumtext")        = "합계"; 
}
function gridCreate4(){
    var hdrProperies = '<FC>id={currow}                name="NO"		    width=30    align=center    SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                    
                     + '<FC>id=PUMMOK_CD               name="품목코드"		width=80     suppress=1     align=center	SubSumText=""    	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=PUMBOK_NM               name="온라인몰"		width=120    suppress=1     align=left		SubSumText="소 계"	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}    </FC>'
                     + '<FC>id=VEN_CD                  name="협력사코드"	width=90     align=center	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=VEN_NM                  name="협력사명"		width=120    align=left		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     
                     + '<FC>id=DAY_SALE_AMT            name="당일 매출액"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120    align=right	mask="###,###"	value={round(DAY_SALE_AMT/submax(UNIT))}	sumtext={round(subsum(DAY_SALE_AMT)/UNIT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ACC_SALE_AMT            name="누계 매출액"	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120    align=right  	mask="###,###" 	value={round(ACC_SALE_AMT/submax(UNIT))}	sumtext={round(subsum(ACC_SALE_AMT)/UNIT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}   </FC>'//suppress=1
                     + '<FC>id=CUST_CNT		           name="객수"			gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120    align=right  	mask="###,###" 	sumtext={subsum(CUST_CNT)}		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}   </FC>'//suppress=1
                     + '<FC> id=level                  name=레벨 Value={CurLevel}    	 width=50   	show=false</FC>'
                     ;
       
    
    initGridStyle(GD_MASTER4, "common", hdrProperies, false);
    //합계표시
    GD_MASTER4.ViewSummary = "1";
    GD_MASTER4.DecRealData = true;
    DS_O_MASTER4.SubSumExpr  = "1:PUMMOK_CD" ; 
    GD_MASTER4.ColumnProp("VEN_NM", "sumtext")        = "합계"; 
}

function gridCreate5(){
    var hdrProperies = '<FC>id={currow}                name="NO"		    width=30    align=center    SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                    
			    	 //+ '<FC>id=ORG_CD                  name="PC 코드"		suppress=1	width=90     align=center	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
			         + '<FC>id=ONLINE_PC               name="온라인PC명"	suppress=2	width=150    align=left		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
			    	 
			    	 + '<FC>id=ORG_NM                  name="PC 명"		    suppress=1	width=120    align=left  	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	 </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
			         
                     + '<FC>id=PUMBUN_CD               name="브랜드코드"		width=90    align=center	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=PUMBUN_NM               name="브랜드명"		width=120   align=left		SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")} </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     
                     + '<FC>id=DAY_SALE_AMT            name="당일 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right		mask="###,###"	value={round(DAY_SALE_AMT/submax(UNIT))}	sumtext={subsum(DAY_SALE_AMT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ACC_SALE_AMT            name="누계 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	value={round(ACC_SALE_AMT/submax(UNIT))}	sumtext={subsum(ACC_SALE_AMT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}       </FC>'//suppress=1
                     + '<FC>id=CUST_CNT		           name="객수"				gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	sumtext={subsum(CUST_CNT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}       </FC>'//suppress=1
                     + '<FC> id=level                  name=레벨                          width=50    Value={CurLevel}       show=false</FC>'
                     ;
       
    
    initGridStyle(GD_MASTER5, "common", hdrProperies, false);
    //합계표시
    GD_MASTER5.ViewSummary = "1";
    GD_MASTER5.DecRealData = true;
    DS_O_MASTER5.SubSumExpr  = "1:ONLINE_PC" ; 
    GD_MASTER5.ColumnProp("ORG_NM", "sumtext")    = "합계"; 
}
function gridCreate6(){
    var hdrProperies = '<FC>id={currow}                name="NO"		    width=30     align=center    SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}</FC>'
                    
    				 + '<FC>id=ONLINE_PC               name="온라인PC명"		suppress=1    width=150    align=left  	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	 </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=ORG_NM                  name="PC 명"		    	width=120    align=left  	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	 </FC>'//SubSumText={decode(curlevel,1,"협력사소계","")}
                     + '<FC>id=DAY_SALE_AMT            name="당일 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right		mask="###,###"	value={round(DAY_SALE_AMT/submax(UNIT))}	sumtext={subsum(DAY_SALE_AMT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}	</FC>'
                     + '<FC>id=ACC_SALE_AMT            name="누계 매출액"		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	value={round(ACC_SALE_AMT/submax(UNIT))}	sumtext={subsum(ACC_SALE_AMT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}       </FC>'//suppress=1
                     + '<FC>id=CUST_CNT		           name="객수"				gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=120   align=right  	mask="###,###" 	sumtext={subsum(CUST_CNT)}	SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1",4,"#FFF29A",5,"#FFF29A")}       </FC>'//suppress=1
                     + '<FC> id=level                  name=레벨 Value={CurLevel}    width=50   show=false</FC>'
                     ;
       
    
    initGridStyle(GD_MASTER6, "common", hdrProperies, false);
    //합계표시
    GD_MASTER6.ViewSummary = "1";
    GD_MASTER6.DecRealData = true;
    DS_O_MASTER6.SubSumExpr  = "1:ONLINE_PC" ; 
    GD_MASTER6.ColumnProp("ORG_NM", "sumtext")        = "합계"; 
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
 * 작 성 일 : 2011-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 if(EM_CMPR_FLAG.CodeValue=="1"){
	 	 searchMaster1();	 
	 }else if(EM_CMPR_FLAG.CodeValue=="2"){
		 searchMaster2();
	 }else if(EM_CMPR_FLAG.CodeValue=="3"){
		 searchMaster3();
	 }else if(EM_CMPR_FLAG.CodeValue=="4"){
		 searchMaster4();
	 }else if(EM_CMPR_FLAG.CodeValue=="5"){
		 searchMaster5();
	 }else if(EM_CMPR_FLAG.CodeValue=="6"){
		 searchMaster6();
	 }
	 
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
	 var strGubun        = EM_CMPR_FLAG.CodeValue;
	 
	    
    var strTitle = "온라인몰 매출 내역 현황";

    var strStrCd        = LC_STR_CD.Text;       //점
    var strSaleDtS      = EM_SALE_DT_S.text;    //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;    //종료일자
    var strEmUnit 		= EM_UNIT.text;			//단위
    
    var parameters = "점 "           + strStrCd
                   + " ,   매출기간 "  + strSaleDtS
                   + " ~ " + strSaleDtE
                   + " , 단위 " + strEmUnit
                   ;
    
    if(strGubun=="1"){
    	if(DS_O_MASTER.CountRow <= 0){
  	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
  	        return;
  	    }
	    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER, strTitle, parameters, true );
    	
    }else if(strGubun=="2"){
    	if(DS_O_MASTER2.CountRow <= 0){
  	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
  	        return;
  	    }
    	GD_MASTER2.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER2, strTitle, parameters, true );
    }else if(strGubun=="3"){
    	if(DS_O_MASTER3.CountRow <= 0){
  	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
  	        return;
  	    }
    	GD_MASTER3.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER3, strTitle, parameters, true );
    }else if(strGubun=="4"){
    	if(DS_O_MASTER4.CountRow <= 0){
  	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
  	        return;
  	    }
    	GD_MASTER4.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER4, strTitle, parameters, true );
    }else if(strGubun=="5"){
    	if(DS_O_MASTER5.CountRow <= 0){
    	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
    	        return;
    	    }
      	GD_MASTER5.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
  	    openExcel2(GD_MASTER5, strTitle, parameters, true );
    }else if(strGubun=="6"){
    	if(DS_O_MASTER6.CountRow <= 0){
    	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
    	        return;
    	    }
      	GD_MASTER6.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
  	    openExcel2(GD_MASTER6, strTitle, parameters, true );
    }
}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
	// 조회조건 셋팅
	
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    var strPayInfo = "";
    var strGubun        = EM_CMPR_FLAG.CodeValue;
    
   /*  strPayInfo = "월" + strPayCyc +"회, " +  LC_S_PAY_CNT.Text;
     */
     var parameters = "&strStrCd="+strStrCd  
                   + "&strSaleDtS="+strSaleDtS
			       + "&strSaleDtE="+strSaleDtE                  
			       + "&strPayInfo="+strPayInfo
			       + "&strGubun="+strGubun
			       ;
			       
    window.open("/dps/psal540.ps?goTo=print"+parameters,"OZREPORT", 1000, 700);   
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
 function searchMaster1(){
	
	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER.ClearData();
	    
	    if(!chkValidation("search")) return;
	    
	    var strStrCd        = LC_STR_CD.BindColVal;      //점
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strGubun        = EM_CMPR_FLAG.CodeValue;
	    var strBrnCd		= EM_O_PUMBUN.text;
	    var strBrnNm		= EM_O_PUMBUN_NM.text;
	    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strGubun="           +encodeURIComponent(strGubun)
	                   + "&strBrdCd="			+encodeURIComponent(strBrnCd)
	                   + "&strBrdNm="			+encodeURIComponent(strBrnNm)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal540.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	    TR_MAIN.Post();

	    GD_MASTER.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER.CountRow);
	    
	    //스크롤바 위치 조정
	    GD_MASTER.SETVSCROLLING(0);
	    GD_MASTER.SETHSCROLLING(0);	
 }
 
 function searchMaster2(){
		
	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER2.ClearData();
	    
	    if(!chkValidation("search")) return;
	    
	    var strStrCd        = LC_STR_CD.BindColVal;      //점
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strGubun        = EM_CMPR_FLAG.CodeValue;
	    var strBrnCd		= EM_O_PUMBUN.text;
	    var strBrnNm		= EM_O_PUMBUN_NM.text;
	    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strGubun="           +encodeURIComponent(strGubun)
	                   + "&strBrdCd="			+encodeURIComponent(strBrnCd)
	                   + "&strBrdNm="			+encodeURIComponent(strBrnNm)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal540.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
	    TR_MAIN.Post();

	    GD_MASTER2.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER2.CountRow);
	    
	    //스크롤바 위치 조정
	    GD_MASTER2.SETVSCROLLING(0);
	    GD_MASTER2.SETHSCROLLING(0);	
}
 
 function searchMaster3(){
		
	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER3.ClearData();
	    
	    if(!chkValidation("search")) return;
	    
	    var strStrCd        = LC_STR_CD.BindColVal;      //점
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strGubun        = EM_CMPR_FLAG.CodeValue;
	    var strBrnCd		= EM_O_PUMBUN.text;
	    var strBrnNm		= EM_O_PUMBUN_NM.text;
	    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strGubun="           +encodeURIComponent(strGubun)
	                   + "&strBrdCd="			+encodeURIComponent(strBrnCd)
	                   + "&strBrdNm="			+encodeURIComponent(strBrnNm)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;

	    TR_MAIN.Action="/dps/psal540.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER3=DS_O_MASTER3)"; //조회는 O
	    TR_MAIN.Post();

	    GD_MASTER3.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER3.CountRow);
	    
	    //스크롤바 위치 조정
	    GD_MASTER3.SETVSCROLLING(0);
	    GD_MASTER3.SETHSCROLLING(0);	
}
 
 function searchMaster4(){
		
	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER4.ClearData();
	    
	    if(!chkValidation("search")) return;
	    
	    var strStrCd        = LC_STR_CD.BindColVal;      //점
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strGubun        = EM_CMPR_FLAG.CodeValue;
	    var strBrnCd		= EM_O_PUMBUN.text;
	    var strBrnNm		= EM_O_PUMBUN_NM.text;
	    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strGubun="           +encodeURIComponent(strGubun)
	                   + "&strBrdCd="			+encodeURIComponent(strBrnCd)
	                   + "&strBrdNm="			+encodeURIComponent(strBrnNm)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal540.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER4=DS_O_MASTER4)"; //조회는 O
	    TR_MAIN.Post();

	    GD_MASTER4.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER4.CountRow);
	    
	    //스크롤바 위치 조정
	    GD_MASTER4.SETVSCROLLING(0);
	    GD_MASTER4.SETHSCROLLING(0);	
}
 
 function searchMaster5(){
		
	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER5.ClearData();
	    
	    if(!chkValidation("search")) return;
	    
	    var strStrCd        = LC_STR_CD.BindColVal;      //점
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strGubun        = EM_CMPR_FLAG.CodeValue;
	    var strBrnCd		= EM_O_PUMBUN.text;
	    var strBrnNm		= EM_O_PUMBUN_NM.text;
	    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strGubun="           +encodeURIComponent(strGubun)
	                   + "&strBrdCd="			+encodeURIComponent(strBrnCd)
	                   + "&strBrdNm="			+encodeURIComponent(strBrnNm)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal540.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER5=DS_O_MASTER5)"; //조회는 O
	    TR_MAIN.Post();

	    GD_MASTER5.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER5.CountRow);
	    
	    //스크롤바 위치 조정
	    GD_MASTER5.SETVSCROLLING(0);
	    GD_MASTER5.SETHSCROLLING(0);	
}
 
 function searchMaster6(){
		
	    //마스터, 디테일 그리드 클리어
	    DS_O_MASTER6.ClearData();
	    
	    if(!chkValidation("search")) return;
	    
	    var strStrCd        = LC_STR_CD.BindColVal;      //점
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strGubun        = EM_CMPR_FLAG.CodeValue;
	    var strBrnCd		= EM_O_PUMBUN.text;
	    var strBrnNm		= EM_O_PUMBUN_NM.text;
	    var strEmUnit 		= EM_UNIT.BindColVal;		 //단위
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
	                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
	                   + "&strGubun="           +encodeURIComponent(strGubun)
	                   + "&strBrdCd="			+encodeURIComponent(strBrnCd)
	                   + "&strBrdNm="			+encodeURIComponent(strBrnNm)
	                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
	                   ;
	    
	    TR_MAIN.Action="/dps/psal540.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER6=DS_O_MASTER6)"; //조회는 O
	    TR_MAIN.Post();

	    GD_MASTER6.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_O_MASTER6.CountRow);
	    
	    //스크롤바 위치 조정
	    GD_MASTER6.SETVSCROLLING(0);
	    GD_MASTER6.SETHSCROLLING(0);	
}
/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-03-14
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

/**
 * getVenInfo(code, name)
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-03-18
 * 개    요 :  브랜드에 따른 협력사 팝업
 * return값 : void
 */
function getVenInfo(code, name){
    var strStrCd        = LC_STR_CD.BindColVal;                                       // 점
    var strUseYn        = "Y";                                                       // 사용여부
    var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
    var strBizType      = "";                                                       // 거래형태
    var strMcMiGbn      = "";                                                       // 매출처/매입처구분
    var strBizFlag      = "";                                                        // 거래구분       

    var rtnMap = venPop(code, name
                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                         ,strBizFlag);
}

/**
 * getVenNonInfo(code, name)
 * 작 성 자 : 박래형
 * 작 성 일 : 2011-03-18
 * 개    요 :  브랜드에 따른 협력사 팝업
 * return값 : void
 */
function getVenNonInfo(code, name){
    var strStrCd        = LC_STR_CD.BindColVal;                                       // 점
    var strUseYn        = "Y";                                                       // 사용여부
    var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
    var strBizType      = "";                                                       // 거래형태
    var strMcMiGbn      = "";                                                       // 매출처/매입처구분
    var strBizFlag      = "";                                                        // 거래구분
    
    var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                        ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                        ,strBizFlag);
    if(rtnMap != null){
        EM_S_VEN_CD.Text = rtnMap.get("VEN_CD");
        EM_S_VEN_NM.Text = rtnMap.get("VEN_NAME");
        return true;
    }else{
        return false;
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



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER3 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER4 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER5 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER6 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=chkbox event=onclick()>

	if(chkbox.checked == true)
	{
		DS_O_MASTER2.SubSumExpr  = "1:PUMMOK_CD" ;
		DS_O_MASTER3.SubSumExpr  = "1:PUMMOK_CD" ; 
		DS_O_MASTER4.SubSumExpr  = "1:PUMMOK_CD" ;
		DS_O_MASTER5.SubSumExpr  = "1:ONLINE_PC" ;
		DS_O_MASTER6.SubSumExpr  = "1:ONLINE_PC" ;
	}	else	{
		DS_O_MASTER2.SubSumExpr  = "" ;
		DS_O_MASTER3.SubSumExpr  = "" ; 
		DS_O_MASTER4.SubSumExpr  = "" ;
		DS_O_MASTER5.SubSumExpr  = "" ;
		DS_O_MASTER6.SubSumExpr  = "" ;
	}

</script>


<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

</script>
<script language=JavaScript for=EM_CMPR_FLAG event=OnSelChange()>
	if(EM_CMPR_FLAG.CodeValue=="1"){
		document.getElementById("grid1").style.display = "";
        document.getElementById("grid2").style.display = "none";
        document.getElementById("grid3").style.display = "none";
        document.getElementById("grid4").style.display = "none";
        document.getElementById("grid5").style.display = "none";
        document.getElementById("grid6").style.display = "none";
        
	}else if(EM_CMPR_FLAG.CodeValue=="2"){
		document.getElementById("grid1").style.display = "none";
        document.getElementById("grid2").style.display = "";
        document.getElementById("grid3").style.display = "none";
        document.getElementById("grid4").style.display = "none";
        document.getElementById("grid5").style.display = "none";
        document.getElementById("grid6").style.display = "none";
        
	}else if(EM_CMPR_FLAG.CodeValue=="3"){
		document.getElementById("grid1").style.display = "none";
        document.getElementById("grid2").style.display = "none";
        document.getElementById("grid3").style.display = "";
        document.getElementById("grid4").style.display = "none";
        document.getElementById("grid5").style.display = "none";
        document.getElementById("grid6").style.display = "none";
        
	}else if(EM_CMPR_FLAG.CodeValue=="4"){
		document.getElementById("grid1").style.display = "none";
        document.getElementById("grid2").style.display = "none";
        document.getElementById("grid3").style.display = "none";
        document.getElementById("grid4").style.display = "";
        document.getElementById("grid5").style.display = "none";
        document.getElementById("grid6").style.display = "none";
        
	}else if(EM_CMPR_FLAG.CodeValue=="5"){
		document.getElementById("grid1").style.display = "none";
        document.getElementById("grid2").style.display = "none";
        document.getElementById("grid3").style.display = "none";
        document.getElementById("grid4").style.display = "none";
        document.getElementById("grid5").style.display = "";
        document.getElementById("grid6").style.display = "none";
        
	}else if(EM_CMPR_FLAG.CodeValue=="6"){
		document.getElementById("grid1").style.display = "none";
        document.getElementById("grid2").style.display = "none";
        document.getElementById("grid3").style.display = "none";
        document.getElementById("grid4").style.display = "none";
        document.getElementById("grid5").style.display = "none";
        document.getElementById("grid6").style.display = "";
        
	}
</script>

<script language=JavaScript for=EM_O_PUMBUN event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
    setPumbunCode('NAME','S',EM_O_PUMBUN,EM_O_PUMBUN_NM);
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


<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
//    if(!this.Modified)
//        return;    
    if(EM_S_VEN_CD.Text != "")
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    else{
        EM_S_VEN_NM.Text = ""        
    }
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
<object id="DS_PUMMOK_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER3" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER4" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER5" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER6" classid=<%=Util.CLSID_DATASET%>></object>
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
    
    var obj   = document.getElementById("GD_MASTER2");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GD_MASTER3");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    var obj   = document.getElementById("GD_MASTER4");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_MASTER5");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_MASTER6");
    
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
               	
                  <th width="70" class="point">점</th>
                  <td width="100"  ><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" class="point">매출기간</th>
                  <td width="250"><comment id="_NSID_"> <object
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
                  
                  <th width="70">브랜드</th>
					<td width="250"><comment id="_NSID_"> <object id=EM_O_PUMBUN
						classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
						align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
						src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
						onclick="javascript:setPumbunCode('POP','S',EM_O_PUMBUN,EM_O_PUMBUN_NM);"
						align="absmiddle" /> <comment id="_NSID_"> <object
						id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=160
						tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
					</td>
				 <th width="70"> 단위</th>
				  <td><comment id="_NSID_">	<object	
				     id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=95	tabindex=1 
				     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               <tr>
                  
                  <th width="70">구분</th>
			    	<td width="150" colspan="5" >
					<comment id="_NSID_">
						<object id="EM_CMPR_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:600">
							<param name=Cols    value="6">
							<param name=Format  value="1^몰별,2^브랜드(몰별),3^PC(몰별),4^협력사별,5^브랜드별,6^PC별">
							<param name=CodeValue  value="1">
						</object>
					</comment><script> _ws_(_NSID_);</script>
				   </td>
                  <th class="point" WIDTH="150" >소계출력<input type=checkbox id=chkbox checked></th>
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
                  <td width="100%" id=grid1 >
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=475 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <td width="100%" id=grid2 >
                  <comment id="_NSID_"> <object
                     id=GD_MASTER2 width=100% height=475 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER2">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <td width="100%" id=grid3 >
                  <comment id="_NSID_"> <object
                     id=GD_MASTER3 width=100% height=475 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER3">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <td width="100%" id=grid4 >
                  <comment id="_NSID_"> <object
                     id=GD_MASTER4 width=100% height=475 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER4">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <td width="100%" id=grid5 >
                  <comment id="_NSID_"> <object
                     id=GD_MASTER5 width=100% height=475 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER5">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <td width="100%" id=grid6 >
                  <comment id="_NSID_"> <object
                     id=GD_MASTER6 width=100% height=475 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER6">
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
