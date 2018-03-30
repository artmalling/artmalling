<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.05.24
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal5010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 정산/마감현황
 * 이    력 :2010.05.24 박종은
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
var top = 120;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER_CROSSTAB"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');      
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_POSNO_S,                        "CODE^4^0",                NORMAL);   //시작포스번호
    EM_POSNO_S.alignment = 3;
    
    initEmEdit(EM_POSNO_E,                        "CODE^4^#",                NORMAL);   //종료포스번호
    EM_POSNO_E.alignment = 3;
    
    searchPosNoMM();
    if(DS_O_POSNOMM.CountRow >0 ){
    	EM_POSNO_S.text = DS_O_POSNOMM.NameValue(1, "POSNO_MIN");
        EM_POSNO_E.text = DS_O_POSNOMM.NameValue(1, "POSNO_MAX");
    }
    
    
    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //getStore("DS_STR_CD", "Y", "", "N");                                                          // 점
    
    getStore2("DS_STR_CD", "Y",	"1", "Y", "1");													//점
	
    //관
    initComboStyle(EM_HALL,DS_HALL, "CODE^0^30,NAME^0^80", 1, NORMAL);              
    getEtcCode("DS_HALL"      , "D", "P197", "Y");
    EM_HALL.Index = 0;
    
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
    
    GD_MASTER_CROSSTAB.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal501","DS_O_MASTER" );
    
}


// 시스템집계, POS정산
function gridCreate(){
    var hdrProperies = '<FC>id={currow}                name="NO"            width=30     align=center   bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
    	             + '<FC>id=INQR_ORDER              name="순서"          width=0      align=right    bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
                     + '<FC>id=BALANCE_FLAG            name="SEQ"           width=40     align=right    bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
                     + '<FC>id=COMM_NAME1              name="항목명"        width=140    align=left     bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
                    // + '<C> Id=SUM                     name="소계"          width=100   Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500", String(""), CrossTabSum(NORM_TRAN_AMT))} Align=Right bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))}</C>'
                     + '<R>'
                     + '<G>                            name=$xkeyname_$$'
                     + '<C>id=NORM_TRAN_CNT_$$         name="건수"          gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=50     align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), NORM_TRAN_CNT_$$) } bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</C>'
                     + '<C>id=NORM_TRAN_AMT_$$         name="금액"          gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100    align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), NORM_TRAN_AMT_$$) } bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</C>'
                     + '</G>'
                     + '</R>'
                     ;

    initGridStyle(GD_MASTER_CROSSTAB, "common", hdrProperies, false);
    GD_MASTER_CROSSTAB.DataId = "DS_O_MASTER_CROSSTAB";
    
}

// 시스템-POS 대사
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}                name="NO"            width=30     align=center   bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
    	             + '<FC>id=INQR_ORDER              name="순서"          width=0      align=right    bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
                     + '<FC>id=BALANCE_FLAG            name="SEQ"           width=40     align=right    bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
                     + '<FC>id=COMM_NAME1              name="항목명"        width=140    align=left     bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))}</FC>'
                    // + '<C> Id=SUM                     name="소계"          width=100   Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500", String(""), CrossTabSum(NORM_TRAN_AMT))} Align=Right bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))}</C>'
                     + '<R>'
                     + '<G>                            name=$xkeyname_$$'
                     + '<C>id=NORM_TRAN_CNT01_$$       name="SYS건수"       gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=70     align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), NORM_TRAN_CNT01_$$) } bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))} </C>'
                     + '<C>id=NORM_TRAN_AMT01_$$       name="SYS금액"       gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100    align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), NORM_TRAN_AMT01_$$) } bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))} </C>'
                     + '<C>id=NORM_TRAN_CNT02_$$       name="POS건수"       gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=70     align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), NORM_TRAN_CNT02_$$) } bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))} </C>'
                     + '<C>id=NORM_TRAN_AMT02_$$       name="POS금액"       gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100    align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), NORM_TRAN_AMT02_$$) } bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))} </C>'
                     + '<C>id=GAP_CNT_$$               name="차이건수"      gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=70     align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), GAP_CNT_$$) }         bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))} TextColor={if(GAP_CNT_$$=0,"","red")}</C>'
                     + '<C>id=GAP_AMT_$$               name="차이금액"      gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100    align=right    mask="###,###"    Value={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", String(""), GAP_AMT_$$) }         bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG = "500" OR BALANCE_FLAG = "610" OR BALANCE_FLAG = "620", "#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189" OR BALANCE_FLAG = "699", "#FFFFE0", "white"))} TextColor={if(GAP_AMT_$$=0,"","red")}</C>'
                     + '</G>'
                     + '</R>'
                     ;

    initGridStyle(GD_MASTER_CROSSTAB, "common", hdrProperies, false);  
    GD_MASTER_CROSSTAB.DataId = "DS_O_MASTER_CROSSTAB2";  
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

    var strFlag         = RD_FLAG.CodeValue;         //집계구분
    
    if(strFlag != "%"){
    	gridCreate();
    	fnSearch();
    }else{
    	gridCreate2();
    	fnSearchAll();
    }
}

function fnSearch(){
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strPosFloor     = LC_POS_FLOOR.BindColVal;   //포스층
    var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strGbn          = RD_GUBUN.CodeValue;        //POS, 층 구분
    var strHallCd       = EM_HALL.BindColVal;
    var strFlag         = RD_FLAG.CodeValue;         //집계구분
    if(strGbn != 0){
    	if(strPosNoS == "") strPosNoS = "0000";
        if(strPosNoE == "") strPosNoE = "9999";
    }
    else{
    	if(strPosNoS == "") strPosNoS = "00";
        if(strPosNoE == "") strPosNoE = "99";
    }
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPosFloor="        +encodeURIComponent(strPosFloor)
                   + "&strPosFlag="         +encodeURIComponent(strPosFlag)
                   + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                   + "&strPosNoE="          +encodeURIComponent(strPosNoE)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strGbn="             +encodeURIComponent(strGbn)
                   + "&strHallCd="          +encodeURIComponent(strHallCd)
                   + "&strFlag="            +encodeURIComponent(strFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    GD_MASTER_CROSSTAB.focus();	
}

function fnSearchAll(){
	
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strPosFloor     = LC_POS_FLOOR.BindColVal;   //포스층
    var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strGbn          = RD_GUBUN.CodeValue;        //POS, 층 구분
    var strHallCd       = EM_HALL.BindColVal;
    var strFlag         = RD_FLAG.CodeValue;         //집계구분
    if(strGbn != 0){
    	if(strPosNoS == "") strPosNoS = "0000";
        if(strPosNoE == "") strPosNoE = "9999";
    }
    else{
    	if(strPosNoS == "") strPosNoS = "00";
        if(strPosNoE == "") strPosNoE = "99";
    }
    
    var goTo       = "searchMasterAll" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPosFloor="        +encodeURIComponent(strPosFloor)
                   + "&strPosFlag="         +encodeURIComponent(strPosFlag)
                   + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                   + "&strPosNoE="          +encodeURIComponent(strPosNoE)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strGbn="             +encodeURIComponent(strGbn)
                   + "&strHallCd="          +encodeURIComponent(strHallCd)
                   + "&strFlag="            +encodeURIComponent(strFlag)
                   ;

    TR_MAIN.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
    TR_MAIN.Post();
    
    GD_MASTER_CROSSTAB.focus();	
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

	var strTitle = "POS별정산/마감현황";
	
	var strStrCd        = LC_STR_CD.BindColVal;      //점
	var strPosFloor     = LC_POS_FLOOR.BindColVal;   //포스층
	var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
	var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
	var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	var strGbn          = RD_GUBUN.CodeValue;   	 //POS, 층 구분
	var strFlag         = RD_FLAG.CodeValue;         //집계구분
	
	var parameters = "점 "           + strStrCd
	               + " ,   포스층"     + strPosFloor
	               + " ,   포스구분 "       + strPosFlag
	               + " ,   포스시작번호 "      + strPosNoS
	               + " ,   포스종료번호 "  + strPosNoE
	               + " ,   매출일자 "  + strSaleDtS
	               + " ,   구분 "  + strGbn ;
      
	
	if(strFlag != "%"){
		if(DS_O_MASTER_CROSSTAB.CountRow <= 0){
			showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
			return;
		}
	}else{
		if(DS_O_MASTER_CROSSTAB2.CountRow <= 0){
			showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
			return;
		}
	}
	GD_MASTER_CROSSTAB.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	//openExcel2(GD_MASTER_CROSSTAB, strTitle, parameters, true );
	openExcel5(GD_MASTER_CROSSTAB, strTitle, parameters, true , "",g_strPid );

}


/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {

    if(!chkValidation("search")){
        return;
    }

    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strPosFloor     = LC_POS_FLOOR.BindColVal;   //포스층
    var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strGbn          = RD_GUBUN.CodeValue;        //POS, 층 구분
    
    if(strGbn == "0"){
    	strGbn = "층";
    }
    else{
    	strGbn = "POS";
    }
    var strStrCdN       = LC_STR_CD.Text;      //점
    var strPosFloorN    = LC_POS_FLOOR.Text;   //포스층
    var strPosFlagN     = LC_POS_FLAG.Text;    //포스구분
    
    
    var strUserId       = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';

    /*
    var params   = "&strStrCd="        +strStrCd
                 + "&strPosFloor="     +strPosFloor
                 + "&strPosFlag="      +strPosFlag
                 + "&strPosNoS="       +strPosNoS
                 + "&strPosNoE="       +strPosNoE
                 + "&strSaleDtS="      +strSaleDtS
                 + "&strGbn="          +encodeURIComponent(strGbn)
                 + "&strUserId="       +strUserId
                 + "&strStrCdN="       +encodeURIComponent(strStrCdN)
                 + "&strPosFloorN="    +encodeURIComponent(strPosFloorN)
                 + "&strPosFlagN="     +encodeURIComponent(strPosFlagN);
    */
    var params   = "&strStrCd="       +strStrCd
			    + "&strPosFloor="     +strPosFloor
			    + "&strPosFlag="      +strPosFlag
			    + "&strPosNoS="       +strPosNoS
			    + "&strPosNoE="       +strPosNoE
			    + "&strSaleDtS="      +strSaleDtS
			    + "&strGbn="          +strGbn
			    + "&strUserId="       +strUserId
			    + "&strStrCdN="       +strStrCdN
			    + "&strPosFloorN="    +strPosFloorN
			    + "&strPosFlagN="     +strPosFlagN;

    
    
    window.open("/dps/psal501.ps?goTo=print"+params,"OZREPORT", 1000, 700);
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
        
        //기간
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        /*
        var strGbn   = RD_GUBUN.CodeValue;   //POS, 층 구분
        if(strGbn != 0){
            if (EM_POSNO_S.text.replace(" ","").length != 4 && EM_POSNO_S.text != "") {
                showMessage(Information, OK, "USER-1027","POS시작번호","4");
                EM_POSNO_S.focus();
                return false;
            }

            if (EM_POSNO_E.text.replace(" ","").length != 4  && EM_POSNO_E.text != "") {
                showMessage(Information, OK, "USER-1027","POS종료번호","4");
                EM_POSNO_E.focus();
                return false;
            }
        }
        else{
        	if (EM_POSNO_S.text.replace(" ","").length != 2 && EM_POSNO_S.text != "") {
                showMessage(Information, OK, "USER-1027","층시작번호","2");
                EM_POSNO_S.focus();
                return false;
            }

            if (EM_POSNO_E.text.replace(" ","").length != 2  && EM_POSNO_E.text != "") {
                showMessage(Information, OK, "USER-1027","층종료번호","2");
                EM_POSNO_E.focus();
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
    
    TR_DETAIL.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
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
    
    TR_DETAIL.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNOMM=DS_O_POSNOMM)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNOMM.CountRow > 0){
        return true;
    }
    return false;
}

/**
 * searchPosFlor()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosFlor(strPosFlor){

    var goTo       = "searchPosFlor" ;    
    var action     = "O";     
    var parameters = "&strPosFlor="           +encodeURIComponent(strPosFlor);
    
    TR_DETAIL.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSFLOR=DS_O_POSFLOR)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSFLOR.CountRow > 0){
        
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
function searchPosFlorMM(){

    var goTo       = "searchPosFlorMM" ;    
    var action     = "O";     
    var parameters = "";
    
    TR_DETAIL.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSFLORMM=DS_O_POSFLORMM)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSFLORMM.CountRow > 0){
        return true;
    }
    return false;
}

/**
 * searchPosFlor()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosFlorH(strPosFlorS, strPosFlorE){
	DS_O_POSFLORH.ClearData();
	
    var goTo       = "searchPosFlorH" ;    
    var action     = "O";     
    var parameters = "&strPosFlorS="         +encodeURIComponent(strPosFlorS)
                   + "&strPosFlorE="         +encodeURIComponent(strPosFlorE);
    
    TR_DETAIL.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSFLORH=DS_O_POSFLORH)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSFLORH.CountRow > 0){
        
        return true;
    }
    
    return false;
}

/**
 * searchPosFlor()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosNoH(strPosNoS, strPosNoE){
	DS_O_POSNOH.ClearData();
    
    var goTo       = "searchPosNoH" ;    
    var action     = "O";     
    var parameters = "&strPosNoS="         +encodeURIComponent(strPosNoS)
                   + "&strPosNoE="         +encodeURIComponent(strPosNoE);
    
    TR_DETAIL.Action="/dps/psal501.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNOH=DS_O_POSNOH)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNOH.CountRow > 0){
        
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
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

</script>
<script language=JavaScript for=RD_GUBUN event=OnSelChange()>
	var strGbn   = RD_GUBUN.CodeValue;   //POS, 층 구분
	if(strGbn == 0){
		LC_POS_FLOOR.enable = false;
		LC_POS_FLOOR.Index = 0;
		initEmEdit(EM_POSNO_S,                        "GEN^2",                NORMAL);   //시작포스번호
	    initEmEdit(EM_POSNO_E,                        "GEN^2",                NORMAL);   //종료포스번호
		searchPosFlorMM();
	    if(DS_O_POSNOMM.CountRow >0 ){
	        EM_POSNO_S.text = DS_O_POSFLORMM.NameValue(1, "POSFLOR_MIN");
	        EM_POSNO_E.text = DS_O_POSFLORMM.NameValue(1, "POSFLOR_MAX");
	    }
	}
	else{
		LC_POS_FLOOR.enable = true;
		initEmEdit(EM_POSNO_S,                        "CODE^4^#",                NORMAL);   //시작포스번호
	    initEmEdit(EM_POSNO_E,                        "CODE^4^#",                NORMAL);   //종료포스번호
		searchPosNoMM();
	    if(DS_O_POSNOMM.CountRow >0 ){
	        EM_POSNO_S.text = DS_O_POSNOMM.NameValue(1, "POSNO_MIN");
	        EM_POSNO_E.text = DS_O_POSNOMM.NameValue(1, "POSNO_MAX");
	    }
	}
	
// 	if(RD_FLAG.CodeValue == "%"){
// 		EM_POSNO_E.enable = false;
// 	}else{
// 		EM_POSNO_E.enable = true;
// 	}
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
    var strGbn   = RD_GUBUN.CodeValue;   //POS, 층 구분
    
    if(strPosNo != ""){
    	if(strGbn == 0){
            if(!searchPosFlor(strPosNo)){
        	    showMessage(Information, OK, "USER-1000","존재하지 않는 층시작번호입니다.");
        	    return true;
            }
    	}
    	else{
    		if(!searchPosNo(strPosNo)){
                showMessage(Information, OK, "USER-1000","존재하지 않는 POS시작번호입니다.");
                return true;
            }
    	}
    		
    }
    return true;
    */
</script>

<!-- POS종료번호 -->
<script language=JavaScript for=EM_POSNO_E event=onKillFocus()>
/*
    var strPosNo = EM_POSNO_E.text;
    var strGbn   = RD_GUBUN.CodeValue;   //POS, 층 구분
    
    if(strPosNo != ""){
    	if(strGbn == 0){
            if(!searchPosFlor(strPosNo)){
                showMessage(Information, OK, "USER-1000","존재하지 않는 층종료번호입니다.");
                return true;
            }
    	}
    	else{
    		if(!searchPosNo(strPosNo)){
                showMessage(Information, OK, "USER-1000","존재하지 않는 POS종료번호입니다.");
                return true;
            }
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

<!-- 집계 구분  변경시  -->
<script language=JavaScript for=RD_FLAG event=OnSelChange()>

// 	if(RD_FLAG.CodeValue =="%"){
// 		EM_POSNO_E.Enable = false;
// 	}else{
// 		EM_POSNO_E.Enable = true;
// 	}
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
<object id="DS_O_POSNOH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_HALL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_POSFLORH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSFLORMM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSFLOR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->


<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER_CROSSTAB" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="DS_O_MASTER">
    <param name=Logical     value="true">
    <param name=GroupExpr   value="BALANCE_FLAG:COMM_NAME1,POS_NO,:NORM_TRAN_CNT:NORM_TRAN_AMT"></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER_CROSSTAB2" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="DS_O_MASTER2">
    <param name=Logical     value="true">
    <param name=GroupExpr   value="BALANCE_FLAG:COMM_NAME1,POS_NO,:NORM_TRAN_CNT01:NORM_TRAN_AMT01:NORM_TRAN_CNT02:NORM_TRAN_AMT02:GAP_CNT:GAP_AMT"></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>>
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
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER_CROSSTAB");
    
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
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">구분</th>
                  <td width="105" >
                    <comment id="_NSID_">
                    <object id=RD_GUBUN classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:95">
                    <param name=Cols    value="2">
                    <param name=Format  value="0^층,1^POS">
                    <param name=CodeValue  value="1">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
                  </td> 
                  <th width="70">관구분</th>
					<td><comment id="_NSID_"> <object
                     id=EM_HALL classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>       
                  <th width="70">층</th>
                  <td colspan="3"><comment id="_NSID_"> <object
                     id=LC_POS_FLOOR classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>  
                  
               </tr>
               <tr>
               	  <th width="70" class="point">매출일자</th>
                  <td width="105" ><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=75
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                  <th>POS구분</th>
                  <td><comment id="_NSID_"> <object
                     id=LC_POS_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th>시작번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_S classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
                  <th>종료번호</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_POSNO_E classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">집계구분</th>
                  <td>
                    <comment id="_NSID_">
                    <object id=RD_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:350">
                    <param name=Cols    value="3">
                    <param name=Format  value="01^시스템집계,02^POS정산,%^시스템-POS 대사">
                    <param name=CodeValue  value="01">
                    </object>  
                    </comment><script> _ws_(_NSID_);</script> 
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
                     id=GD_MASTER_CROSSTAB width=100% height=482 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
