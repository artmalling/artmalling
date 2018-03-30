<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.05.19
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4250.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별매출현황
 * 이    력 :2010.05.19 박종은
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
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
 var top = 400;		//해당화면의 동적그리드top위치
 var check_bit = "0";
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
    
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	 
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');     
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');     
    DS_O_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    gridCreate3(); //디테일
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //종료일자
    EM_SALE_DT_E.alignment = 1;

    initEmEdit(EM_POSNO_S,                        "CODE^4^#",                NORMAL);   //시작포스번호
    EM_POSNO_S.alignment = 3;

    initEmEdit(EM_POSNO_E,                        "CODE^4^#",                NORMAL);   //종료포스번호
    EM_POSNO_E.alignment = 3;
    
    searchPosNoMM();
    if(DS_O_POSNOMM.CountRow >0 ){
    	EM_POSNO_S.text = DS_O_POSNOMM.NameValue(1, "POSNO_MIN");
        EM_POSNO_E.text = DS_O_POSNOMM.NameValue(1, "POSNO_MAX");
    }
    
    
    initEmEdit(EM_DEALNO,                        "CODE^5^0",                NORMAL);   //거래번호
    EM_DEALNO.alignment = 3;
    
    //현재년도 셋팅
    //EM_SALE_DT_S.text =  varToMon+"01";

    EM_SALE_DT_S.text =  varToday;
    EM_SALE_DT_E.text =  varToday;

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    getStore("DS_STR_CD", "Y", "", "Y");                                                          // 점
    //getStore2("DS_STR_CD", "Y", "1", "Y", strOrgFlag);                                                   //점
    
    //POS층
    initComboStyle(LC_POS_FLOOR,DS_POS_FLOOR, "CODE^0^30,NAME^0^80", 1, NORMAL);              
    getEtcCode("DS_POS_FLOOR"      , "D", "P061", "Y");
    LC_POS_FLOOR.Index = 0;
    
    //관
    initComboStyle(EM_HALL,DS_HALL, "CODE^0^30,NAME^0^80", 1, NORMAL);              
    getEtcCode("DS_HALL"      , "D", "P197", "Y");
    EM_HALL.Index = 0;
    
    //POS구분
    initComboStyle(LC_POS_FLAG,DS_POS_FLAG, "CODE^0^30,NAME^0^140", 1, NORMAL);             
    getEtcCode("DS_POS_FLAG", "D", "P082", "Y");
    LC_POS_FLAG.Index = 0;
    
	//단위(01:원,02:천원)
    initComboStyle(EM_UNIT, DS_UNIT, "CODE^0^30,NAME^0^80", 1, NORMAL);	
    getEtcCode("DS_UNIT"    , "D", "P622", "N"); 
    EM_UNIT.Index 	 = 1;
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal425","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"            	width=30    align=center    </FC>'
                     + '<FC>id=POS_NO                  name="POS번호"       	width=60    align=center   suppress="1"      	sumtext = "합계"</FC>'
                     + '<FC>id=DEALCNT                 name="거래건수"      	width=90    align=right    mask="###,###"    	sumtext={subsum(DEALCNT)}</FC>'
                     + '<FC>id=SALE_AMT_TOT            name="총매출"        	width=100   align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(SALE_AMT_TOT)/UNIT)} 	value={round(SALE_AMT_TOT/UNIT)}</FC>'
                     + '<FC>id=REDU_PRC                name="할인"          	width=100   align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(REDU_PRC)}</FC>'
                     + '<FC>id=SALE_AMT                name="매출"          	width=100   align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(SALE_AMT)/UNIT)}		value={round(SALE_AMT/UNIT)}</FC>'
                     + '<FC>id=DC_PRC                  name="에누리"        	width=100   align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(DC_PRC)}</FC>'
                     + '<FC>id=NET_SALE_AMT            name="순매출(VAT제외)"   width=100   align=right     mask="###,###"   	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(NET_SALE_AMT)/UNIT)}	value={round(NET_SALE_AMT/UNIT)}</FC>'
                     //+ '<FC>id=SALE_PROF_AMT           name="이익액"        width=100    align=right     mask="###,###"    sumtext={subsum(SALE_PROF_AMT)}</FC>'
                     + '<FC>id=SALE_DT_S               name="매출시작일자"   	width=80    align=center   mask="XXXX/XX/XX" 	show=false</FC>'
                     + '<FC>id=SALE_DT_E               name="매출종료일자"   	width=80    align=center   mask="XXXX/XX/XX" 	show=false</FC>'
                     + '<FC>id=STR_CD                  name="점"           		width=60    align=center   show=false</FC>'
                     ;
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}                name="NO"           		width=30     align=center    </FC>'
                     + '<FC>id=GUBUN                   name="구분"           	width=70     align=left     sumtext = "합계" suppress="1"</FC>'
                     + '<FC>id=SALE_DT                 name="매출일자"         	width=80     align=center   mask="XXXX/XX/XX"   suppress="2"</FC>'
                     + '<FC>id=POS_NO                  name="POS번호"        	width=70     align=center   suppress="3" </FC>'
                     + '<FC>id=TRAN_NO                 name="거래번호"        	width=70     align=center   suppress="3" </FC>'
                     + '<FC>id=SALE_AMT_TOT            name="총매출"        	width=100    align=right    mask="###,###"      gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(SALE_AMT_TOT)/UNIT)}	value={round(SALE_AMT_TOT/UNIT)}</FC>'
                     + '<FC>id=REDU_PRC                name="할인"          	width=80     align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(REDU_PRC)} </FC>'
                     + '<FC>id=SALE_AMT                name="매출"          	width=100    align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(SALE_AMT)/UNIT)} 		value={round(SALE_AMT/UNIT)}</FC>'
                     + '<FC>id=DC_PRC                  name="에누리"        	width=80   	 align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(DC_PRC)} </FC>'
                     + '<FC>id=NET_SALE_AMT            name="순매출(VAT제외)"   width=100    align=right    mask="###,###"    	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(NET_SALE_AMT)/UNIT)} 	value={round(NET_SALE_AMT/UNIT)}</FC>'
                     ;
        
        

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    //합계표시
    GD_DETAIL.ViewSummary = "1";
    GD_DETAIL.DecRealData = true;
}
function gridCreate3(){
    var hdrProperies = '<FC>id={currow}                name="NO"          	width=30    align=center  </FC>'
                     + '<FC>id=PUMBUN_CD               name="브랜드"      	width=60    align=center  </FC>'
                     + '<FC>id=PUMBUN_NAME             name="브랜드명"      width=80    align=left    </FC>'
                     + '<FC>id=TOT_SALE_AMT            name="총매출"        width=100	align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(TOT_SALE_AMT)/UNIT)}	value={round(TOT_SALE_AMT/UNIT)})</FC>'
                     + '<FC>id=REDU_AMT                name="할인"          width=80    align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(REDU_AMT)} </FC>'
                     + '<FC>id=NORM_SALE_AMT           name="매출"         	width=100   align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(NORM_SALE_AMT)/UNIT)}	value={round(NORM_SALE_AMT/UNIT)})</FC>'
                     + '<FC>id=DC_AMT                  name="에누리"        width=80    align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(DC_AMT)} </FC>'
                     + '<FC>id=NET_SALE_AMT            name="순매출"        width=100   align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(NET_SALE_AMT)/UNIT)} 	value={round(NET_SALE_AMT/UNIT)})</FC>'
                     + '<FC>id=CUST_CNT                name="객수"          width=80    align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={subsum(CUST_CNT)} </FC>'
                     + '<FC>id=CUST_UNIT_PRC           name="객단가"        width=100   align=right   mask="###,###"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext={round(subsum(CUST_UNIT_PRC)/UNIT)} value={round(CUST_UNIT_PRC/UNIT)})</FC>'
                     ;
        
        

    initGridStyle(GD_DETAIL2, "common", hdrProperies, false);
    //합계표시
    GD_DETAIL2.ViewSummary = "1";
    GD_DETAIL2.DecRealData = true;
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
    DS_O_DETAIL2.ClearData();
    check_bit = "0";
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      	//점
    var strPosFloor     = LC_POS_FLOOR.BindColVal;   	//POS층
    var strPosFlag      = LC_POS_FLAG.BindColVal;    	//POS구분
    var strPosNoS       = numFormat(EM_POSNO_S.text,4); //POS시작번호
    var strPosNoE       = numFormat(EM_POSNO_E.text,4); //POS종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         	//시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         	//종료일자
    var strDealNo       = EM_DEALNO.text;  			    //거래번호
    var strHallCd       = EM_HALL.BindColVal;
    var strEmUnit 		= EM_UNIT.BindColVal;			//단위

    if(strPosNoS == "") strPosNoS = "0000";
    if(strPosNoE == "") strPosNoE = "9999";
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPosFloor="        +encodeURIComponent(strPosFloor)
                   + "&strPosFlag="         +encodeURIComponent(strPosFlag)
                   + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                   + "&strPosNoE="          +encodeURIComponent(strPosNoE)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strDealNo="          +encodeURIComponent(strDealNo)
                   + "&strHallCd="          +encodeURIComponent(strHallCd)
                   + "&strEmUnit="			+encodeURIComponent(strEmUnit)
                   ;
    TR_MAIN.Action="/dps/psal425.ps?goTo="+goTo+parameters;  
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
	 
	if(DS_O_DETAIL2.CountRow <= 0){
	     showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	       return;
   }
	
	var strTitle = "POS별매출현황";
	
    
	var strStrCd        = LC_STR_CD.Text;      //점
	var strPosNo       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POS_NO");           //포스시작번호
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	

	var parameters = "점 "             + strStrCd
	               + " ,   매출기간 "  + strSaleDtS + " ~ " +  strSaleDtE
	               + " ,   POS번호 "  + strPosNo;
	
	//openExcel2(GD_DETAIL2, strTitle, parameters, true );
	openExcel5(GD_DETAIL2, strTitle, parameters, true , "",g_strPid );

	
	strTitle = "POS별매출현황_1";
	
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
  * btn_Search()
  * 작 성 자 : PJE
  * 작 성 일 : 2010-03-16
  * 개    요 : 조회시 호출
  * return값 : void
  */
 function search_Detail() {
     
     //마스터, 디테일 그리드 클리어
     DS_O_DETAIL.ClearData();
     
     var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");      	//점
     var strPosNo        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POS_NO");        //포스번호
     var strSaleDtS      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SALE_DT_S");     //매출시작일자
     var strSaleDtE      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SALE_DT_E");     //매출종료일자
     var strEmUnit 		 = EM_UNIT.BindColVal;												//단위
     
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strPosNo="           +encodeURIComponent(strPosNo)
                    + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                    + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                    + "&strEmUnit="			 +encodeURIComponent(strEmUnit);
     
     TR_DETAIL.Action="/dps/psal425.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();

     //GD_MASTER.focus();
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);

     //스크롤바 위치 조정
     GD_DETAIL.SETVSCROLLING(0);
     GD_DETAIL.SETHSCROLLING(0);
     
 }

 /**
  * btn_Search()
  * 작 성 자 : PJE
  * 작 성 일 : 2010-03-16
  * 개    요 : 조회시 호출
  * return값 : void
  */
 function search_Detail2() {
	  
	  
	  
     //마스터, 디테일 그리드 클리어
     DS_O_DETAIL2.ClearData();
     
     var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");      	//점
     var strPosNo        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POS_NO");        //포스번호
     var strSaleDtS      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SALE_DT_S");     //매출시작일자
     var strSaleDtE      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SALE_DT_E");     //매출종료일자
     var strEmUnit 		 = EM_UNIT.BindColVal;												//단위
     
     var goTo       = "searchDetail2" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strPosNo="           +encodeURIComponent(strPosNo)
                    + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                    + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                    + "&strEmUnit="			 +encodeURIComponent(strEmUnit);
     
     TR_DETAIL2.Action="/dps/psal425.ps?goTo="+goTo+parameters;  
     TR_DETAIL2.KeyValue="SERVLET("+action+":DS_O_DETAIL2=DS_O_DETAIL2)"; //조회는 O
     TR_DETAIL2.Post();

     //GD_MASTER.focus();    
     
     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_DETAIL2.CountRow);

     //스크롤바 위치 조정
     GD_DETAIL2.SETVSCROLLING(0);
     GD_DETAIL2.SETHSCROLLING(0);
     
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
        
        //기간
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
        /*
        if (EM_POSNO_S.text.replace(" ","").length > 4 && EM_POSNO_S.text != "") {
            showMessage(Information, OK, "USER-1027","POS시작번호","4");
            EM_POSNO_S.focus();
            return false;
        }

        if (EM_POSNO_E.text.replace(" ","").length > 4  && EM_POSNO_E.text != "") {
            showMessage(Information, OK, "USER-1027","POS종료번호","4");
            EM_POSNO_E.focus();
            return false;
        }
        
        if(EM_DEALNO.text != ""){
        	if(EM_POSNO_E.text != EM_POSNO_S.text ){
        		showMessage(Information, OK, "USER-1000","거래번호로 조회시 POS시작번호와 POS종료번호가 동일해야 합니다.");
        		EM_POSNO_S.focus();
        		return false;
        	}
        	if(LC_POS_FLOOR.BindColVal != "%"){
        		showMessage(Information, OK, "USER-1000","거래번호로 조회시 POS층은 전체여야 합니다.");
        		LC_POS_FLOOR.focus();
                return false;
        	}
        	if(LC_POS_FLAG.BindColVal != "%"){
        		showMessage(Information, OK, "USER-1000","거래번호로 조회시 POS구분은 전체여야 합니다.");
        		LC_POS_FLAG.focus();
                return false;
        	}
        }
        */
        break;
   
    }
    return true;
}

/**
 * searchPosNo()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosNo(strPosNo){

    var goTo       = "searchPosNo" ;    
    var action     = "O";     
    var parameters = "&strPosNo="           +encodeURIComponent(strPosNo);
    
    TR_DETAIL.Action="/dps/psal425.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNO=DS_O_POSNO)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNO.CountRow > 0){
    	
        return true;
    }
    
    return false;
}

/**
 * searchPosNoMM()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosNoMM(){

    var goTo       = "searchPosNoMM" ;    
    var action     = "O";     
    var parameters = "";
    
    TR_DETAIL.Action="/dps/psal425.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNOMM=DS_O_POSNOMM)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNOMM.CountRow > 0){
        return true;
    }
    return false;
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
    search_Detail();
 	search_Detail2();
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnLoadCompleted >
	search_Detail();
	search_Detail2();
    
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row) >
		
		
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

<!-- POS시작번호 -->
<script language=JavaScript for=EM_POSNO_S event=onKillFocus()>
/*
    var strPosNo = EM_POSNO_S.text;
    
    if(strPosNo != ""){
        if(!searchPosNo(strPosNo)){
        	showMessage(Information, OK, "USER-1000","존재하지 않는 POS시작번호입니다.");
        	return true;
        }
    }
    return true;
    */
</script>

<!-- POS종료번호 -->
<script language=JavaScript for=EM_POSNO_E event=onKillFocus()>
/*
    var strPosNo = EM_POSNO_E.text;
    if(strPosNo != ""){
        if(!searchPosNo(strPosNo)){
            showMessage(Information, OK, "USER-1000","존재하지 않는 POS종료번호입니다.");
            return true;
        }
    }
    return true;
    */
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
<object id="DS_O_POSNOMM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_POS_FLOOR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_POS_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"> 
<object id="DS_UNIT"	classid=<%=Util.CLSID_DATASET%>></object> 
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_HALL" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL2" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_POSNO" classid=<%=Util.CLSID_DATASET%>></object>
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
<comment id="_NSID_">
<object id="TR_DETAIL2" classid=<%=Util.CLSID_TRANSACTION%>>
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
    
	var obj   = document.getElementById("GD_DETAIL2");
    
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
                  <th width="80" class="point">점</th>
                  <td width="150"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">관구분</th>
					<td><comment id="_NSID_"> <object
                     id=EM_HALL classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>  
                  <th width="70">POS층</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_POS_FLOOR classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                 
               </tr>
               <tr>
                  <th class="point">매출기간</th>
                  <td width="250"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=90
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                  ~
                     <comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=90
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('G',EM_SALE_DT_E); " align="absmiddle" />
                  </td>
                   <th>POS구분</th>
                  <td width="150"><comment id="_NSID_"> <object
                     id=LC_POS_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                   <th>단위</th>
                   <td>	<comment id="_NSID_"><object	
                   	 id=EM_UNIT classid=<%=Util.CLSID_LUXECOMBO%> width=140	tabindex=1 
                   	 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
                  
              </tr>
              <tr>
                  <th>POS시작번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_S classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
                  <th>POS종료번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_E classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
                  <th>거래번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_DEALNO classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
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
                     id=GD_MASTER width=100% height=240 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr valign="top"  class="PT10">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top" >
            <td td width="50%" class="PR03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">                  
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL2 width=100% height=200 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_DETAIL2">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>      
            </td>
            
            <td td width="50%" class="PR03">
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
