<!-- 
/*******************************************************************************
 * 시스템 명 : 백화점 영업관리 > 매출관리 > 실행계획
 * 작  성  일 : 2010.03.31
 * 작  성  자 : 박종은
 * 수  정  자 : 
 * 파  일  명 : psal2080.jsp
 * 버       전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요 : 실행브랜드별일매출계획수정및확정
 * 이       력 :
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
 var top = 100;		//해당화면의 동적그리드top위치
 
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');   
    
    //그리드 초기화
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_PLAN_YM,                      "YYYYMM",                PK);   //년월
    EM_PLAN_YM.alignment = 1;
    
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD,         "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    
    
    
    getStore("DS_STR_CD", "Y", "",                   "N");                                                // 점        
    
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    
    //현재년도 셋팅
    EM_PLAN_YM.text = varToMon;
    
    var lastDate    = new Date(EM_PLAN_YM.text.substr(0,4), EM_PLAN_YM.text.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    
    
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal208","DS_IO_DETAIL" );

    
    btn_Search();
}


function gridCreate2(lastday){

        var j = 0;
        var thisDate = null;
        var thisWeek = "";
        var strWeek = "";
        var strDay  = "";
		

        if(lastday == null){
    	    var lastDate = new Date(varToMon.substr(0,4), varToMon.substr(4,2), 0);
    	    lastday  = lastDate.getDate();
        }
        

        var hdrProperies =
           '<FC>id=STR_CD       width=100    align=center   name="점코드"     </FC>'
         + '<FC>id=STR_NAME	    width=110    align=left     name="점명"     </FC>'
      	 + '<FC>id=EXE_YM       width=100    align=center   name="년월"       </FC>'
  		 + '<FC>id=PC_CD	    width=65     align=center   name="PC코드"     </FC>'
  		 + '<FC>id=PC_NAME	    width=110    align=left     name="PC명"     sumtext="합계"  </FC>'
         + '<C>id=ACT_AMT       width=200    align=RIGHT    name="실행목표"  edit={DECODE(CONF_FLAG,"Y","false","N","true")}  sumtext={sum(ACT_AMT)}   </C>'
         + '<C>id=CONF_FLAG     width=60     align=center   name="확정유무"  EDIT=NONE  </C>'
         + '<C>id=TEMP	        width=60     align=center   name="확정위한체크값"  SHOW=FALSE   </C>'

 		 ;
	
 		GD_DETAIL.ViewSummary = "1";


 		initGridStyle(GD_DETAIL, "common", hdrProperies, true);
    
}

function rtuWeek(week){
	
	switch(week){
	case 1 :
		return "일";
		break;
	case 2 :
		return "월";
        break;
    case 3 :
        return "화";
        break;
    case 4 :
        return "수";
        break;
    case 5 :
        return "목";
        break;
    case 6 :
        return "금";
        break;
    case 7 :
        return "토";
        break;
    
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
 * loadExcelData()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-04
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
 
 
 
/**
 * btn_Search()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
	
    if (DS_IO_DETAIL.IsUpdated){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    
    //마스터, 디테일 그리드 클리어
    DS_IO_DETAIL.ClearData();
	
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strPlanYm       = EM_PLAN_YM.text;           //년월
    
    
    var goTo       = "searchDetail";    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPlanYm="          +encodeURIComponent(strPlanYm);
    
    TR_MAIN.Action="/dps/psal208.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);
    //스크롤바 위치 조정
  
    if(DS_IO_DETAIL.countrow == 0) {
    	//alert("목표데이터가 없습니다. 신규버튼으로 생성하세요.");
    	//btn_New();
    	searchDetail_new();
    }
    
    return true;
}

/**
 * btn_New()
 * 작 성 자 :   
 * 작 성 일 : 
 * 개     요 :  
 * return값 : 
 */
function btn_New() {
	
	if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    
    //마스터, 디테일 그리드 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
	
    //1. validation 
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    
    var strPlanYm       = EM_PLAN_YM.text;           //년월
    
    var lastDate    = new Date(strPlanYm.substr(0,4), strPlanYm.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();
    
    var goTo       = "searchMaster_new" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPlanYm="          +encodeURIComponent(strPlanYm);
    
    TR_MAIN.Action="/dps/psal208.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    GD_DETAIL.ReDraw = false;
    gridCreate2(strEndDate);
    GD_DETAIL.ReDraw = true;
	  
   /*
    //확정된 내역은 확정일자 수정 불가능
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
    }
    else{
        GD_MASTER.ColumnProp("CONF_DT","Edit")="";
    }
   */
    
    
    // 조회결과 Return

    //스크롤바 위치 조정
  

    
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {
	 
	if( showMessage(QUESTION, YESNO, "USER-1000", DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORG_NAME") + "  PC를 삭제 하시겠습니까?") != 1 )
        return;
	 
	
	
	

}

/**
 * btn_Save()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-25
 * 개    요 : DB에 저장  / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if (!DS_IO_DETAIL.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
        
                                                 //마지막일자
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
        return;

    var parameters =  "";
    
    TR_MAIN.Action = "/dps/psal208.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();


    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

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
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 : 확정, 확정취소 처리
 * return값 : void
 */

 function btn_Conf() {


	
     if (DS_IO_DETAIL.countrow == 0){
         showMessage(INFORMATION, OK, "USER-1000","확정할 데이터가 없습니다.");
         return;
     }
     
     
     if( showMessage(QUESTION, YESNO, "USER-1000", "확정 또는 확정취소 하시겠습니까?") != 1 )
         return;
     
     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "TEMP") = "C";
     
     
     var	parameters = "&yyyymm="	   + encodeURIComponent(EM_PLAN_YM.text)
     					+ "&strStrCd=" + encodeURIComponent(LC_STR_CD.BindColVal)
     					;         
     
     TR_MAIN.Action="/dps/psal208.ps?goTo=saveconf"+parameters;
     TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_MAIN.Post();
     
	 
     // 정상 처리일 경우 조회
     if( TR_MAIN.ErrorCode == 0){
         btn_Search();
     }

 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/




/**
* searchDetail_new()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-16
* 개    요 : 당초브랜드별월매출계획 조회
* return값 : void
*/
function searchDetail_new(){
    
    var strStrCd        = LC_STR_CD.BindColVal;           //점
    var strYYYYMM       = EM_PLAN_YM.text;           //년월
    
    
       
    var goTo       = "searchDetail_new" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                	+ "&strYYYYMM="            +encodeURIComponent(strYYYYMM);
   
    TR_DETAIL.Action="/dps/psal208.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    GD_DETAIL.ReDraw = false;
    
    DS_IO_DETAIL.ResetStatus();
       
    GD_DETAIL.ReDraw = true;
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_DETAIL.CountRow);

    //showMessage(INFORMATION, OK, "USER-1000", "기초데이터를 생성하였습니다. 다시 조회해주세요.");
    
    btn_Search();
    GD_DETAIL.focus();
   
}

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 :  확정,확정취소
 * return값 : void
 */
function chkValidation(gbn){
    

	
	    switch (gbn) {
	    case "search" :  
	        //점 체크
	        if (isNull(LC_STR_CD.BindColVal)==true ) {
	            showMessage(INFORMATION, OK, "USER-1003","점");
	            return false;
	        }
	        
	        //계획년도
	        if (isNull(EM_PLAN_YM.text) ==true ) {
	            showMessage(INFORMATION, OK, "USER-1003","목표년도"); 
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_PLAN_YM.text.replace(" ","").length != 6 ) {
	            showMessage(INFORMATION, OK, "USER-1027","년월","6");
	            return false;
	        }
	        return true;
	        break;
	    case "save" : 
	        if(DS_IO_MASTER.ORGNameValue(DS_IO_MASTER.RowPosition, "CONF_FLAG") == "T"){
	        	showMessage(INFORMATION, OK, "USER-1000", "확정된 데이터입니다. 확정 취소 후 수정하십시오.");
	        	return false;
	        }
	        var Morigin_norm_samt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_NORM_SAMT");
	        var Morigin_evt_samt  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_EVT_SAMT");
	        var Morigin_prof_tamt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORIGIN_PROF_TAMT");
	        var Dorigin_norm_samt = 0;
	        var Dorigin_evt_samt  = 0;
	        var Dorigin_prof_tamt = 0;
	        for(i=1; i<= DS_IO_DETAIL.CountRow;i++){    
	        	Dorigin_norm_samt = getRoundDec("1",Dorigin_norm_samt,0)+getRoundDec("1",DS_IO_DETAIL.NameValue(i, "ORIGIN_NORM_SAMT_TOTAL_JUNG"),0);
	        	Dorigin_evt_samt  = getRoundDec("1",Dorigin_evt_samt,0)+getRoundDec("1",DS_IO_DETAIL.NameValue(i, "ORIGIN_EVT_SAMT_TOTAL_EVENT"),0);
	        	Dorigin_prof_tamt = getRoundDec("1",Dorigin_prof_tamt,0)+getRoundDec("1",DS_IO_DETAIL.NameValue(i, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0);
	            
	        }
	        /*
	        if(Morigin_norm_samt != Dorigin_norm_samt){
	        	showMessage(INFORMATION, OK, "USER-1000", "정상금액에 오차가 있습니다. 확인하십시오");
	            return false;
	        }
	        
	        if(Morigin_evt_samt != Dorigin_evt_samt){
	        	showMessage(INFORMATION, OK, "USER-1000", "행사금액에 오차가 있습니다. 확인하십시오");
	            return false;
	        }
	        
	        if(Morigin_prof_tamt != Dorigin_prof_tamt){
	        	showMessage(INFORMATION, OK, "USER-1000", "이익금액에 오차가 있습니다. 확인하십시오");
	            return false;
	        }
	        */
	        return true;
	        break;
	    
	    }
}


/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 :  확정,확정취소
 * return값 : void
 */
function chkSave(){
	changeSum();
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;

    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PC_CD");            //PC
    var strYYYYMM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    var lastDate        = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate      = lastDate.getDate();                                                 //마지막일자
    
    var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
                    + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                    + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                    + "&strPCCd="         +encodeURIComponent(strPCCd)
                    + "&strYYYYMM="       +encodeURIComponent(strYYYYMM)
                    + "&strEndDate="      +encodeURIComponent(strEndDate);
    
    TR_MAIN.Action = "/dps/psal208.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

}

/**
 * changeSum()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-29
 * 개    요 :  컬럼변경시 합계, 오차 계산
 * return값 : void
 */
function changeSum(){
	var bfyyTotal       = 0;
	var originNorm      = 0;
	var originEvt       = 0;
	var originTotal     = 0;
	var originProf      = 0;
	var gab             = 0;
	
    var strYYYYMM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                       //마지막일자
    
    
	for(i=1; i <= strEndDate; i++){
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i) = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT"+i),0)
		                                                                       +       getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT"+i),0),0)
		//originTotal = getRoundDec("1",getRoundDec("1",originTotal,0) + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0),0);
		//originProf  = getRoundDec("1",getRoundDec("1",originProf,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0),0);
		//originNorm  = getRoundDec("1",getRoundDec("1",originNorm,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT"+i),0),0);
		//originEvt   = getRoundDec("1",getRoundDec("1",originEvt,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT"+i),0),0);
		
	}
    
	for(i=1; i <= strEndDate; i++){
		originTotal = 0;
        originProf  = 0;
        originNorm  = 0;
        originEvt   = 0;
		for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
			originTotal = getRoundDec("1",getRoundDec("1",originTotal,0) + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT"+i),0),0);
	        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT"+i),0),0);
	        originNorm  = getRoundDec("1",getRoundDec("1",originNorm,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_NORM_SAMT"+i),0),0);
	        originEvt   = getRoundDec("1",getRoundDec("1",originEvt,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_EVT_SAMT"+i),0),0);
		}
		for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
			if(getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0) != 0){
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_CRATE"+i) 
	            = getRoundDec("1", getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0)/getRoundDec("1",originTotal,0)*100,2);
	        }
	        else{
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_CRATE"+i) = 0;
	        }
	        if(getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0) != 0){
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_CRATE"+i) 
	            = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0) /getRoundDec("1",originProf,0)*100,2);
	        }
	        else{
	            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_CRATE"+i) = 0;
	        }
		}
		
    }
	
	originTotal = 0;
    originProf  = 0;
    originNorm  = 0;
    originEvt   = 0;
    for(i=1; i <= strEndDate; i++){
        originTotal = getRoundDec("1",getRoundDec("1",originTotal,0) + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT"+i),0),0);
        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT"+i),0),0);
        originNorm  = getRoundDec("1",getRoundDec("1",originNorm,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT"+i),0),0);
        originEvt   = getRoundDec("1",getRoundDec("1",originEvt,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT"+i),0),0);
        
    }
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_NORM_SAMT_TOTAL_JUNG") = originNorm;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_EVT_SAMT_TOTAL_EVENT") = originEvt;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_SALE_TAMT_TOTAL_SALE") = originTotal;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORIGIN_PROF_TAMT_TOTAL_PROF") = originProf;
        
    originTotal = 0;
    originProf  = 0;  
    for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
    	originTotal = getRoundDec("1",getRoundDec("1",originTotal,0)  + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0),0);
        originProf  = getRoundDec("1",getRoundDec("1",originProf,0)   + getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0),0);
    }
       
    for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0) != 0){
            DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_CRATE_TOTAL_SALE") 
            = getRoundDec("1", getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT_TOTAL_SALE"),0)/getRoundDec("1",originTotal,0)*100,2);
        }
        else{
            DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_CRATE_TOTAL_SALE") = 0;
        }
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0) != 0){
            DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_CRATE_TOTAL_PROF") 
            = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT_TOTAL_PROF"),0) /getRoundDec("1",originProf,0)*100,2);
        }
        else{
            DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_CRATE_TOTAL_PROF") = 0;
        }
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
    //alert(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
    //alert(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
    //alert(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
    //alert(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_CONF event=onSuccess>
    for(i=0;i<TR_CONF.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CONF.SrvErrMsg('UserMsg',i));
    }
    //alert(TR_CONF.ErrorMsg);
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_CONF event=onFail>
    trFailed(TR_CONF.ErrorMsg);
    //alert(TR_CONF.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid GD_DETAIL OnExit event 처리  -->



<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row > 0){
    if (DS_IO_DETAIL.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1074");
        if (ret != "1") {
            DS_IO_MASTER.RowPosition = old_Row;
            return false;
        } 
    }

    	searchDetail();
    
    
}


old_Row = row;
</script>

<script language="javascript">
    var today    = new Date();
    var oldColid = "";
    var old_Row = 0;

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
    var changeAmt = 0;
</script>



<!-- <script language=JavaScript for=GD_DETAIL event=OnColumnPosChanged> -->
<script language=JavaScript for=DS_IO_DETAIL event=oncolumnchanged>

	//DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG")
	var i = 0;
	var Tot_sum = 0;
	
	if(DS_IO_MASTER.countrow != 0) {

		for(i=1; i<=31; i++){
			if(i < 10){
				Tot_sum += Number(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE0"+i))
			} else {
				Tot_sum += Number(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE"+i))
			}
		}
	}
	//alert(Tot_sum);
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"TOT_AMT") = Number(Tot_sum);
	

  return true;
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_PLAN_YM event=onKillFocus()>

    //영업조회월
    if (isNull(EM_PLAN_YM.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","년월"); 
        EM_PLAN_YM.text = varToMon;
        return ;
    }
    //영업조회월 자릿수, 공백 체크
    if (EM_PLAN_YM.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","년월","6");
        EM_PLAN_YM.text = varToMon;
        return ;
    }
    //년월형식체크
    if (!checkYYYYMM(EM_PLAN_YM.text) ) {
        showMessage(INFORMATION, OK, "USER-1069","년월");
        EM_PLAN_YM.text = varToMon;
        return ;
    }
    
    var lastDate    = new Date(EM_PLAN_YM.text.substr(0,4), EM_PLAN_YM.text.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    
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
<object id="DS_O_WEEK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_CONF" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
   style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
   <param name="Text" value='FileOpen'>
   <param name="Enable" value="true">
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
                  <td width="150"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th class="point" width="70">년월</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_PLAN_YM classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_PLAN_YM)" align="absmiddle" />
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


   <tr valign="top" class="PT10">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object 
                  id=GD_DETAIL width=100% height=301 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_DETAIL"> 
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
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
