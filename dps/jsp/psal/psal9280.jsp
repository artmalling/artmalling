<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal9280.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 카드사별매출현황
 * 이    력 :2010.04.25 박종은
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
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');     
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');     
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //종료일자
    EM_SALE_DT_E.alignment = 1;

    initEmEdit(EM_POSNO_S,                        "CODE^4^0",                NORMAL);   //시작포스번호
    EM_POSNO_S.alignment = 3;

    initEmEdit(EM_POSNO_E,                        "CODE^4^0",                NORMAL);   //종료포스번호
    EM_POSNO_E.alignment = 3;

    searchPosNoMM();
    if(DS_O_POSNOMM.CountRow >0 ){
        EM_POSNO_S.text = DS_O_POSNOMM.NameValue(1, "POSNO_MIN");
        EM_POSNO_E.text = DS_O_POSNOMM.NameValue(1, "POSNO_MAX");
    }
    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToMon+"01";

    EM_SALE_DT_E.text =  varToday;

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        
    //발급사
    initComboStyle(LC_CARDSA,DS_CARDSA, "CODE^0^30,NAME^0^100", 1, NORMAL);              
    getComboCd("DS_CARDSA", "", "SEL_CARD_COMP", "");
    insComboData( LC_CARDSA, "%", "전체",1);
    LC_CARDSA.Index = 0;
    //매입사
    initComboStyle(LC_BCOMP_CD,DS_BCOMP_CD, "CODE^0^30,NAME^0^100", 1, NORMAL);              
    getComboCd("DS_BCOMP_CD", "", "SEL_CARD_BCOMP", "");
    insComboData( LC_BCOMP_CD, "%", "전체",1);
    LC_BCOMP_CD.Index = 0;
    //POS층
    initComboStyle(LC_POS_FLOOR,DS_POS_FLOOR, "CODE^0^30,NAME^0^80", 1, NORMAL);              
    getEtcCode("DS_POS_FLOOR"      , "D", "P061", "Y");
    LC_POS_FLOOR.Index = 0;
    //POS구분
    initComboStyle(LC_POS_FLAG,DS_POS_FLAG, "CODE^0^30,NAME^0^140", 1, NORMAL);             
    getEtcCode("DS_POS_FLAG", "D", "P082", "Y");
    LC_POS_FLAG.Index = 0;
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal928","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"                    width=30    align=center    </FC>'
    
                     + '<FG>                           name="매입사" '
                     + '<FC>id=CARD_PURCHASE           name="코드"                   width=30   align=center         suppress="1"</FC>'
                     + '<FC>id=BCOMP_NM                name="명"                     width=100   align=left         sumtext="합계" suppress="1"</FC>'
                     + '</FG>' 
                     + '<FG>                           name="발급사" '
                     + '<FC>id=CARD_PUBLISH            name="코드"                   width=30   align=center         suppress="1"</FC>'
                     + '<FC>id=CCOMP_NM                name="명"                     width=100   align=left         sumtext="합계" suppress="1"</FC>'
                     + '</FG>'
                     + '<FC>id=TOTAL                   name="매출건수"              width=60    align=right          mask="###,###"    sumtext={subsum(TOTAL)}</FC>'
                     + '<FC>id=SALE_AMT                name="매출금액"                width=100    align=right       mask="###,###"    sumtext={subsum(SALE_AMT)}</FC>'
                    
                     + '<FC>id=NORM_SALE_AMT           name="정상금액"                width=100    align=right       mask="###,###"    sumtext={subsum(NORM_SALE_AMT)}</FC>'
                     + '<FC>id=NORM_CNT                name="정상매출;건수"          width=60    align=right          mask="###,###"    sumtext={subsum(NORM_CNT)}       </FC>'
                     + '<FC>id=RET_SALE_AMT            name="반품액"                 width=120    align=right        mask="###,###"    sumtext={subsum(RET_SALE_AMT)}</FC>'
                     + '<FC>id=RET_CNT                 name="반품건수"                width=60    align=right        mask="###,###"    sumtext={subsum(RET_CNT)}       </FC>'
                     
                     + '<FC>id=DAY_CAN_CNT             name="당일취소;건수"            width=60    align=right        mask="###,###"    sumtext={subsum(DAY_CAN_CNT)}</FC>'
                     + '<FC>id=DAY_CAN_NORM_CNT        name="당일취소;(정상)건수"       width=65    align=right        sumtext={subsum(DAY_CAN_NORM_CNT)}       </FC>'//mask="###,###"
                     + '<FC>id=DAY_CAN_NORM_AMT        name="당일취소;(정상)금액"       width=100    align=right        mask="###,###"    sumtext={subsum(DAY_CAN_NORM_AMT)}</FC>'
                     + '<FC>id=DAY_CAN_RET_CNT         name="당일취소;(취소)건수"       width=65    align=right        sumtext={subsum(DAY_CAN_RET_CNT)}       </FC>'// mask="###,###" 
                     + '<FC>id=DAY_CAN_RET_AMT         name="당일취소;(취소)금액"       width=100    align=right        mask="###,###"    sumtext={subsum(DAY_CAN_RET_AMT)}       </FC>'
                     
                     + '<FC>id=STR_CD                  name="점"                    width=100   align=left       show=false</FC>'
                     + '<FC>id=LSSU_COMP               name="카드사"                 width=100   align=left       show=false</FC>'
                     + '<FC>id=FLOR_CD                 name="층"                    width=100   align=left       show=false</FC>'
                     + '<FC>id=POS_FLAG                name="포스구분"               width=100   align=left       show=false</FC>'
                     + '<FC>id=POS_NO_S                name="포스번호"               width=100   align=left       show=false</FC>'
                     + '<FC>id=POS_NO_E                name="포스번호"               width=100   align=left       show=false</FC>'
                     + '<FC>id=SALE_DT_S               name="조회일자"               width=100   align=left       show=false</FC>'
                     + '<FC>id=SALE_DT_E               name="조회일자"               width=100   align=left       show=false</FC>'
                     + '<FC>id=CARD_FLAG               name="카드구분"               width=100   align=left       show=false</FC>'
                     ;
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    DS_O_MASTER.SubSumExpr  = "CARD_FLAG"; 
    GD_MASTER.ColumnProp("BCOMP_NM", "SubSumText")        = "소계"; 
    GD_MASTER.DecRealData = true;
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30    align=center    sumtext = "" subsumtext= ""</FC>'
                     + '<FC>id=SALE_DT                 name="매출일자"         width=80    align=center   mask="XXXX/XX/XX"   suppress="1" SubBgColor=#FFFFE0 subsumtext= "일자별소계" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=POS_NO                  name="POS번호"        width=60    align=center     suppress="2" SubBgColor=#FFFFE0 sumtext = "" subsumtext= "" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=CNT                     name="매출건수"          width=60    align=right    mask="###,###"    sumtext={subsum(CNT)}      SubBgColor=#FFFFE0 </FC>'
                     + '<FC>id=SALE_AMT                name="매출금액"          width=90    align=right    mask="###,###"    sumtext={subsum(SALE_AMT)} SubBgColor=#FFFFE0 </FC>'
                     + '<FC>id=NORM_SALE_AMT           name="정상금액"          width=90    align=right     mask="###,###"    sumtext={subsum(NORM_SALE_AMT)}</FC>'
                     + '<FC>id=NORM_CNT                name="매출건수"      width=60    align=right    mask="###,###"    sumtext={subsum(NORM_CNT)}       </FC>'
                     + '<FC>id=RET_SALE_AMT            name="반품액"          width=90    align=right     mask="###,###"    sumtext={subsum(RET_SALE_AMT)}</FC>'
                     + '<FC>id=RET_CNT                 name="반품건수"      width=60    align=right    mask="###,###"    sumtext={subsum(RET_CNT)}       </FC>'                     
                     ;
        
        

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    //합계표시
    GD_DETAIL.ViewSummary = "1";
    DS_O_DETAIL.SubSumExpr  = "1:SALE_DT" ; 
    GD_DETAIL.ColumnProp("SALE_DT", "sumtext")        = "합계";
    GD_DETAIL.DecRealData = true;
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
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strCardsa       = LC_CARDSA.BindColVal;      //카드사
    var strBcomp        = LC_BCOMP_CD.BindColVal;      //매입사
    var strPosFloor     = LC_POS_FLOOR.BindColVal;   //포스층
    var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    
    if(strPosNoS == "") strPosNoS = "0000";
    if(strPosNoE == "") strPosNoE = "9999";
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strCardsa="          +encodeURIComponent(strCardsa)
                   + "&strBcomp="           +encodeURIComponent(strBcomp)
                   + "&strPosFloor="        +encodeURIComponent(strPosFloor)
                   + "&strPosFlag="         +encodeURIComponent(strPosFlag)
                   + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                   + "&strPosNoE="          +encodeURIComponent(strPosNoE)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   ;
    
    TR_MAIN.Action="/dps/psal928.ps?goTo="+goTo+parameters;  
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
    var strTitle = "카드사별매출현황";
    
    var strStrCd        = LC_STR_CD.Text;      //점
    var strCardsa       = LC_CARDSA.Text;      //카드사
    var strBcomp        = LC_BCOMP_CD.Text;      //매입사
    var strPosFloor     = LC_POS_FLOOR.Text;   //포스층
    var strPosFlag      = LC_POS_FLAG.Text;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자

    if(strPosNoS == "") strPosNoS = "0000";
    if(strPosNoE == "") strPosNoE = "9999";
    
    var parameters = 
         "점 "              +strStrCd
       + " , 카드사 "        +strCardsa
       + " , 매입사 "        +strBcomp
       + " , POS층 "        +strPosFloor
       + " , POS구분 "      +strPosFlag
       + " , 매출기간 "      +strSaleDtS + "~" + strSaleDtE
       + " , POS시작번호 "   +strPosNoS
       + " , POS종료번호 "   +strPosNoE;
        
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
// 조회조건 셋팅
	
    var strTitle = "카드사별매출현황";
    var strStrNm        = LC_STR_CD.Text;      //점이름
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strCardsa       = LC_CARDSA.BindColVal;      //카드사
    var strBcomp        = LC_BCOMP_CD.BindColVal;      //매입사
    var strPosFloor     = LC_POS_FLOOR.BindColVal;   //포스층
    var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	
    if(strPosNoS == ""||strPosNoS==null){
    	strPosNoS = "0000";
    }
    if(strPosNoE == ""){
    	strPosNoE = "9999";
    }
    
     var parameters = "&strStrCd="+strStrCd  
                   + "&strCardsa="+strCardsa
			       + "&strBcomp="+strBcomp                  
			       + "&strPosFloor="+strPosFloor
			       + "&strPosFlag="+strPosFlag
			       + "&strSaleDtS="+strSaleDtS
			       + "&strSaleDtE="+strSaleDtE
			       + "&strPosNoS="+strPosNoS
			       + "&strPosNoE="+strPosNoE
			       ;
			       
    window.open("/dps/psal928.ps?goTo=print"+parameters,"OZREPORT", 1000, 700);  
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
  * 작 성 일 : 2011-03-16
  * 개    요 : 조회시 호출
  * return값 : void
  */
  
 function searchDetail() {
     
     
     var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");            //점
     var strCardsa       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CARD_PUBLISH");         //카드사
     var strBcomp        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CARD_PURCHASE");      //매입사
     var strPosFloor     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "FLOR_CD");           //포스층
     var strPosFlag      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POS_FLAG");          //포스구분
     var strPosNoS       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POS_NO_S");          //포스시작번호
     var strPosNoE       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POS_NO_E");          //포스종료번호
     var strSaleDtS      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SALE_DT_S");         //시작일자
     var strSaleDtE      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SALE_DT_E");         //종료일자
     var strCardFlag     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CARD_FLAG");         //카드구분
     
     if(strPosNoS == "") strPosNoS = "0000";
     if(strPosNoE == "") strPosNoE = "9999";
     
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strCardsa="          +encodeURIComponent(strCardsa)
                    + "&strBcomp="           +encodeURIComponent(strBcomp)
                    + "&strPosFloor="        +encodeURIComponent(strPosFloor)
                    + "&strPosFlag="         +encodeURIComponent(strPosFlag)
                    + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                    + "&strPosNoE="          +encodeURIComponent(strPosNoE)
                    + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                    + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                    + "&strCardFlag="        +encodeURIComponent(strCardFlag);
     
     TR_DETAIL.Action="/dps/psal928.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();

     GD_DETAIL.focus();
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);

     //스크롤바 위치 조정
     GD_DETAIL.SETVSCROLLING(0);
     GD_DETAIL.SETHSCROLLING(0);
     
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
        /*
        if (EM_POSNO_S.text.replace(" ","").length != 4 && EM_POSNO_S.text != "") {
            showMessage(Information, OK, "USER-1027","POS시작번호","4");
            EM_SALE_DT_E.focus();
            return false;
        }

        if (EM_POSNO_E.text.replace(" ","").length != 4  && EM_POSNO_E.text != "") {
            showMessage(Information, OK, "USER-1027","POS종료번호","4");
            EM_SALE_DT_E.focus();
            return false;
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
    
    TR_DETAIL.Action="/dps/psal928.ps?goTo="+goTo+parameters;  
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
    
    TR_DETAIL.Action="/dps/psal928.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNOMM=DS_O_POSNOMM)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNOMM.CountRow > 0){
        return true;
    }
    return false;
}


/**
 * getDummyTable()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 빈 테이블을 입력한다.
 * return값 : void
 */
function searchPosTran(strDt, strPosNo, strStrCd, strCardNo )
{
   
	var arrArg  = new Array();
	
    arrArg.push(strDt);
    arrArg.push(strPosNo);
    arrArg.push(strStrCd);
    arrArg.push(strCardNo);

    var returnVal = window.showModalDialog("/dps/psal928.ps?goTo=searchTran",
                                           arrArg,
                                           "dialogWidth:960px;dialogHeight:368px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
    
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


<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row >0){  
	searchDetail() ;
}
old_Row = row;

</script>
<!--  searchTran(strDt, strPosNo, strStrCd, strCardNo ) -->

<script language=JavaScript for=GD_DETAIL event=OnDblClick(row,colid)>
    
    var strDt       = DS_O_DETAIL.NameValue(row, "SALE_DT");
    var strPosNo    = DS_O_DETAIL.NameValue(row, "POS_NO");
    
    var strStrCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");
    //var strCardNo   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ACQU_COMP_CD");
    var strCardNo   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CARD_PUBLISH");
    
    if(strPosNo == ""){ return;}
    searchPosTran(strDt, strPosNo, strStrCd, strCardNo );
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
<object id="DS_CARDSA" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_POSNO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSNOMM" classid=<%=Util.CLSID_DATASET%>></object>
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
    
	var obj   = document.getElementById("GD_DETAIL");
    
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
                  
                  <th width="80">발급사</th>
                  <td width="150"><comment id="_NSID_"> <object
                     id=LC_CARDSA classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                  <th width="80">매입사</th>
                  <td><comment id="_NSID_"> <object
                     id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
               </tr>
               <tr>
                  <th class="point">매출기간</th>
                  <td colspan="3"><comment id="_NSID_"> <object
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
                  
                  <th>POS층</th>
                  <td><comment id="_NSID_"> <object
                     id=LC_POS_FLOOR classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
              </tr>
              <tr>
                  <th>POS구분</th>
                  <td><comment id="_NSID_"> <object
                     id=LC_POS_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th>POS시작번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_S classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
                  <th>POS종료번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_E classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
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
         <tr>
            <td width="1000">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
                class="BD4A">
                <tr>
                    <td><comment id="_NSID_"><object id=GD_MASTER
                        width=100% height=450 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_O_MASTER">
                    </object></comment><script>_ws_(_NSID_);</script></td>
                </tr>
            </table>
            </td>
            <td class="PL10">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
                class="BD4A">
                <tr>
                    <td><comment id="_NSID_"><object id=GD_DETAIL
                        width=100% height=450 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_O_DETAIL">
                    </object></comment><script>_ws_(_NSID_);</script></td>
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