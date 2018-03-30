<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 당초계획
 * 작 성 일 : 2010.07.04
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal2060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대을Btype매출계획등록
 * 이    력 :2010.07.04 박종은
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

function doInit(){
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');    
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_EXE_YM, "YYYYMM", PK);                                            //계획년월
    EM_EXE_YM.alignment = 1;
    
    
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, PK);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)

    initEmEdit(EM_PUMBUN_CD,         "CODE^6^0",    NORMAL);          //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME,       "GEN^40",      READ);            //브랜드(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y");   // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    //현재년도 셋팅
    EM_EXE_YM.text = varToMon;
    GD_MASTER.Focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal206","DS_IO_DETAIL,DS_IO_MASTER" );
        
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30     align=center     BgColor={decode(ERROR_CHECK,"","white","yellow")} </FC>'
                     + '<FC>id=CONF_FLAG               name="선택"         width=50     align=center    Edit="" EditStyle=CheckBox HeadCheck=false HeadCheckShow=true</FC>'
                     + '<FC>id=STR_CD                  name="점"           width=40     align=center     Edit=none    show=true</FC>'
                     + '<FC>id=STR_NAME                name="점명"         width=70     align=left      Edit=none   </FC>'
                     + '<FC>id=DEPT_CD                 name="팀"         width=40     align=center    Edit=none    </FC>'
                     + '<FC>id=TEAM_CD                 name="파트"           width=40     align=center    Edit=none    </FC>'
                     + '<FC>id=PC_CD                   name="PC"           width=40     align=center    Edit=none    </FC>'
                     + '<FC>id=ORG_NAME                name="PC명"         width=80     align=left      Edit=none    SumText="합계"</FC>'
                     + '<FC>id=EXE_YM                  name="목표년월"      width=100    align=left      Edit=""      show=false</FC>'
                     + '<FC>id=CONF_DT                 name="확정일자"      width=100    align=center   Edit=Numeric Mask="XXXX/XX/XX"   EditStyle=Popup  </FC>'
                     + '<G>                            name="브랜드별일매출목표합계"'
                     + '<C>id=ORIGIN_NORM_MG_RATE      name="마진"         width=100     align=right        Edit=none mask="###,###" </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_TOT     name="목표매출"      width=100     align=right     SumText={SubSum(ORIGIN_SALE_TAMT_TOT)}    Edit=none mask="###,###" </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_TOT     name="이익"         width=100     align=right     SumText={SubSum(ORIGIN_PROF_TAMT_TOT)}   Edit=none mask="###,###" </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_TOT    name="매출신장율"    width=100     align=right     Dec=2     Edit=none mask="##0.00" </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_TOT    name="이익신장율"    width=80     align=right     Dec=2      Edit=none mask="###0.00" </C>'
                     + '</G>'                          
                                                                             
                     ;
                    
    
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
}


function gridCreate2(lastday){
    var hdrProperies = '<FC>id={currow}                name="NO"          width=30     align=center      </FC>'
                     + '<FC>id=PUMBUN_CD               name="브랜드"         width=60     align=center     Edit=none    </FC>'
                     + '<FC>id=PUMBUN_NAME             name="브랜드명"       width=90     align=left       Edit=none    </FC>'
                     + '<FC>id=NORM_MG_RATE            name="마진"         width=70     align=center     Edit=none    </FC>'
                     + '<FC>id=TOTAL                   name="합계"         width=70     align=center     Edit=none    mask="###,###" </FC>'
    var j = 0;
    if(lastday == null){
        var lastDate = new Date(varToMon.substr(0,4), varToMon.substr(4,2), 0);
        lastday  = lastDate.getDate();
    }
    
    for(i=1;i<= lastday; i++){  
    	hdrProperies += '<C>id=ORIGIN_SALE_TAMT'+i+'                   name="'+i+'일"         width=80     align=right     mask="###,###" Edit={IF(CONF_FLAG="Y",none, "")}</C>'
    }
                     
        hdrProperies += '<C>id=CONF_FLAG               name="확정구분"         width=60     align=center     Edit=none    show=false</C>'
                     +  '<C>id=EXE_YM                  name="년월"            width=60     align=center     Edit=none    show=false</C>'
                     +  '<C>id=SALE_ORG_CD             name="조직코드"         width=60     align=center     Edit=none    show=false</C>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
   
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
    
    if (DS_IO_MASTER.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    

    //마스터, 디테일 그리드 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    searchChk = "S";
    //점 체크
    if (isNull(LC_STR_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","점");
        return;
    }
    
    //팀 체크
    if (isNull(LC_DEPT_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","팀");
        return;
    }

    //파트 체크
    if (isNull(LC_TEAM_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","파트");
        return;
    }
    
    //계획년도
    if (isNull(EM_EXE_YM.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","목표년월"); 
        return;
    }
    //계획년도 자릿수, 공백 체크
    if (EM_EXE_YM.text.replace(" ","").length != 6 ) {
        showMessage(INFORMATION, OK, "USER-1027","목표년도","6");
        return;
    }
    
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strPlanYM       = EM_EXE_YM.text;         //계획년도
    var strPumbunCd     = EM_PUMBUN_CD.text;         //브랜드코드
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                   + "&strPlanYM="        +encodeURIComponent(strPlanYM);
    
    TR_MAIN.Action="/dps/psal206.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //확정된 내역은 확정일자 수정 불가능
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
    }
    else{
        GD_MASTER.ColumnProp("CONF_DT","Edit")="";
    }
    
    GD_MASTER.ColumnProp('CONF_FLAG','HeadCheck')= "false";

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
}

/**
 * btn_New()
 * 작 성 자 : 박종은  
 * 작 성 일 : 2010-03-16
 * 개    요 :  화면 클리어
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-17
 * 개    요 : DB에 저장  / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (!DS_IO_DETAIL.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    changeSum();
    var strYYYYMM       = EM_EXE_YM.text;         //계획년도DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "YYYYMM");           //년월
    var lastDate        = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate      = lastDate.getDate();                                                 //마지막일자
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
        return;

    var parameters =   "&strEndDate="      +encodeURIComponent(strEndDate);
    
    TR_MAIN.Action = "/dps/psal206.ps?goTo=save"+parameters;
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
     if (!DS_IO_MASTER.IsUpdated ){
         //저장할 내용이 없습니다
         showMessage(INFORMATION, OK, "USER-1000","확정할 데이터가 없습니다.");
         return;
     }
     
     if(!chkValidation()) return;
     
     
     
     if( showMessage(QUESTION, YESNO, "USER-1000", "확정 또는 확정취소 하시겠습니까?") != 1 )
         return;
     
     TR_MAIN.Action="/dps/psal206.ps?goTo=saveconf";
     TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
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
* searchDetail()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-16
* 개    요 : 당초브랜드별월매출계획 조회
* return값 : void
*/
function searchDetail(){
	
    
    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PC_CD");            //PC
    var strPlanYM       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "EXE_YM");        //계획년월
    
    var lastDate = new Date(strPlanYM.substr(0,4), strPlanYM.substr(4,2), 0);
    lastday  = lastDate.getDate();
    gridCreate2(lastday);
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                   + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="            +encodeURIComponent(strTeamCd
                   + "&strPCCd="              +encodeURIComponent(strPCCd)
                   + "&strPlanYM="            +encodeURIComponent(strPlanYM);
    
    TR_DETAIL.Action="/dps/psal206.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();


    DS_IO_DETAIL.RowPosition = 1;

    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        searchChk = "A";
    }
    else{
        if(searchChk == "S" && DS_IO_DETAIL.CountRow != 0 ){
            GD_MASTER.ColumnProp("CONF_DT","Edit")="";
            searchChk = "A";
        }
        else{
            searchChk = "A";
        }
    }
    GD_MASTER.Focus();
}

/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(){



    //데이터 길이 체크
    for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){

        //확정체크 체크
        if(DS_IO_MASTER.OrgNameValue(j,"CONF_DT") != DS_IO_MASTER.NameValue(j,"CONF_DT") && DS_IO_MASTER.OrgNamevalue(j,"CONF_FLAG") =="F" && DS_IO_MASTER.Namevalue(j,"CONF_FLAG") =="F" ){
            showMessage(INFORMATION, OK, "USER-1000","확정 체크하셔야 합니다.");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,1,"CONF_FLAG");
            return false;
        }
        if(DS_IO_MASTER.NameValue(j, "CONF_FLAG") == "T" && DS_IO_MASTER.RowStatus(j) != 0){
            if(DS_IO_MASTER.NameValue(j, "CONF_DT") == ""){
                showMessage(INFORMATION, OK, "USER-1003","확정일자");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                return false;
            }
            if(DS_IO_MASTER.NameValue(j, "CONF_DT").replace(" ","").length != 8){
                showMessage(INFORMATION, OK, "USER-1027","확정일자","8");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                return false;
            }
            if(DS_IO_MASTER.NameValue(j, "CONF_DT") < varToday){
                showMessage(INFORMATION, OK, "USER-1020","확정일자", "당일");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                return false;
            }
        }
    }
    return true;
}
 
/**
 * btn_Add1()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-06-27
 * 개     요 : 브랜드추가
 * return값 : void
 */
function btn_Add1() {
    var strStrCd        = "";           //점
	var strDeptCd       = "";          //팀
	var strTeamCd       = "";          //파트
	var strPCCd         = "";            //PC
	var strPlanYM       = EM_EXE_YM.text;         //계획년도
	
	if(DS_IO_MASTER.CountRow > 0 ){
		strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
	    strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
	    strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
	    strPCCd         = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PC_CD");            //PC
	}
	else{
		strStrCd        = LC_STR_CD.BindColVal;      //점
	    strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
	    strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
	    strPCCd         = LC_PC_CD.BindColVal;       //PC
	} 
	
	if(strPCCd == "%") strPCCd = "00";
	
	var strOrgCd        = strStrCd + strDeptCd + strTeamCd + strPCCd + "00";
	
	var rtnMap = null;
	var strChk = 0;


	rtnMap = strPbnMultiSelPop('','','Y','', strStrCd, strOrgCd,'','','','','','','','5');
	if( rtnMap != null){
	    var total = rtnMap.length;
        if(total < 1){
            return;
        }
        var row = DS_IO_DETAIL.CountRow + 1;
    
        for( var i=0; i<total; i++){
        	strChk = 0;

        	for( var j=1; j <=DS_IO_DETAIL.CountRow; j++){
        		if(rtnMap[i].PUMBUN_CD == DS_IO_DETAIL.NameValue(j, "PUMBUN_CD")){
        			strChk = 1;
        		}
        	}
        	
        	if(strChk == 0){
        		DS_IO_DETAIL.AddRow();
        		row = DS_IO_DETAIL.CountRow;

                DS_IO_DETAIL.NameValue(row,"PUMBUN_CD")   = rtnMap[i].PUMBUN_CD;
                DS_IO_DETAIL.NameValue(row,"PUMBUN_NAME") = rtnMap[i].PUMBUN_NAME;
                DS_IO_DETAIL.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(strStrCd, rtnMap[i].PUMBUN_CD);
                DS_IO_DETAIL.NameValue(row,"SALE_ORG_CD") = rtnMap[i].SALE_ORG_CD;
                DS_IO_DETAIL.NameValue(row,"EXE_YM")      = strPlanYM;
        	}
            
        }
	}
	 
}

/**
 * btn_Del1()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-06-27
 * 개     요 : 브랜드 그리드 Row 삭제 
 * return값 : void
 */
function btn_Del1() {
    if (DS_IO_DETAIL.RowPosition > 0) {
        var row = DS_IO_DETAIL.RowPosition;
        if (DS_IO_DETAIL.RowStatus(row) == "1") //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
        {
        	DS_IO_DETAIL.DeleteRow(row);
        } else {
            showMessage(INFORMATION, OK, "USER-1052");
        }
    }
}

/**
 * getMarginNormMgRate()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 마진마스터에서 정상마진율을 조회한다.(Popup.js) 
 * return값 : void
 */
function getMarginNormMgRate(strCd, pumbunCd){
    var eventFlag = "";
    var appSDt    = varToday;
    
    setDataSet("DS_SEARCH_EVTFLAG","SEL_MARGINMST_EVENT_FLAG", strCd, pumbunCd);
    if(DS_SEARCH_EVTFLAG.CountRow > 0){
    	eventFlag = DS_SEARCH_EVTFLAG.NameValue(1, "COL1");
    }
    
    if( strCd == "" 
        || pumbunCd == ""
        || eventFlag == ""
        || appSDt == ""){
        return 0;        
    }
    
    setDataSet("DS_SEARCH_MGRATE","SEL_MARGINMST_NORM_MG_RATE", strCd, pumbunCd, eventFlag, appSDt);
    if( DS_SEARCH_MGRATE.CountRow == 1){
        return DS_SEARCH_MGRATE.NameValue(1,"COL1");
    }

    showMessage(EXCLAMATION, OK, "USER-1000", "정상마진율이 존재하지 않습니다.");
    return '';
}

/**
 * changeSum()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-29
 * 개    요 :  컬럼변경시 합계, 오차 계산
 * return값 : void
 */
function changeSum(){
	if(DS_IO_DETAIL.CountRow < 1) return;
    var strPlanYM = DS_IO_DETAIL.NameValue(1,"EXE_YM");
	var lastDate = new Date(strPlanYM.substr(0,4), strPlanYM.substr(4,2), 0);
	lastday  = lastDate.getDate();
	var total = 0;
	for(j=1; j <= DS_IO_DETAIL.CountRow; j++){
		total = 0;
		for(i=1; i<= lastday; i++){
			total += DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT"+i);
	    }
		DS_IO_DETAIL.NameValue(j,"TOTAL") = total;
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
<script language=JavaScript for=DS_IO_DETAIL event=OnDataError(row,colid)>
var colName = GD_DETAIL.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(EXCLAMATION, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(EXCLAMATION, OK, "GAUCE-1007", row);
    DS_IO_MASTER.DeleteRow(row);
} else {
    //showMessage(EXCLAMATION, OK, "USER-1000", this.ErrorMsg);
}
</script>
 <!-- Grid GD_MASTER OnPopup event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
 
    switch (colid) {
    case "CONF_DT" :
        openCal(GD_MASTER, row, colid);   //그리드 달력 
        break;
    }
     
 </script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>

if(row > 0 && old_Row >0){  
    if(DS_IO_DETAIL.CountRow == 0){
    	GD_MASTER.ReDraw = "false";
        GD_MASTER.Editable = false;
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") = "F";
        //DS_IO_MASTER.NameValue(row,"CONF_DT") = "";

        GD_MASTER.ReDraw = "true";
    }
    else{
        if(DS_IO_MASTER.RowStatus(row) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
            GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        }
        else{
            GD_MASTER.ColumnProp("CONF_DT","Edit")="";
        }
    } 
} 
else{
		setFocusGrid(GD_MASTER, DS_IO_MASTER,0,colid);
	    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
	
}

GD_MASTER.Editable = true;

</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid)>
		
    if(colid == "CONF_DT") {
    	if(DS_IO_MASTER.Namevalue(row,"CONF_FLAG") == "T" ){
	    	if(!checkDateTypeYMD(this,colid,'')){
	        	setTimeout("setFocusGrid(GD_MASTER,DS_IO_MASTER,"+row+",'"+colid+"');",50);
	            return false;
	        }
    	}
	}
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row >0){
    searchDetail();
}

if(row > 0 && old_Row >0){  
    if(DS_IO_DETAIL.CountRow == 0 && DS_IO_MASTER.RowStatus(row) == 0){
    	GD_MASTER.ReDraw = "false";
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
        //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") = "F";
        //DS_IO_MASTER.NameValue(row,"CONF_DT") = "";
        setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
        GD_MASTER.ReDraw = "true";
    }
    else{
        if(DS_IO_MASTER.RowStatus(row) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
        	GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
            setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
        }
        else{
            GD_MASTER.ColumnProp("CONF_DT","Edit")="";
            setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
        }
        
    } 
} 

old_Row = row;
</script>
<script language=JavaScript for=GD_MASTER event=OnCheckClick(row,colid,check)>

</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>

        sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
   
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
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                       // 파트   
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC  
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC   
    LC_PC_CD.Index   = 0;
</script>

<!-- 브랜드코드 변경시 -->   
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    EM_PUMBUN_NAME.Text = "";
    if(EM_PUMBUN_CD.text.length != 0){            
        var rtnMap = setRepPumbunNmWithoutToGridPop( "DS_O_PUMBUN_CD", this.Text, EM_PUMBUN_NAME.Text, 'N', '1');
        if (rtnMap != null){
            EM_PUMBUN_CD.Text = rtnMap.get("PUMBUN_CD");
            EM_PUMBUN_NAME.Text = rtnMap.get("PUMBUN_NAME");
        }else{
            EM_PUMBUN_CD.Text = "";
            EM_PUMBUN_NAME.Text = "";
        }
    }
</script>

<script language=JavaScript for=DS_IO_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>

</script>

<script language=JavaScript for=GD_DETAIL
   event=OnColumnPosChanged(Row,Colid)>
DS_IO_DETAIL.ReDraw = false;

changeSum();
DS_IO_DETAIL.ReDraw = true;
</script>


<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    var j = 0;

    if(bCheck == "1"){
        for(i=1; i <= DS_IO_MASTER.CountRow; i++){
                DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "T";  
        }
    }
    else{
        for(i=1; i <= DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "F";
        }
    }
    
    //old_Row = 1;
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
<object id="DS_SEARCH_EVTFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEARCH_MGRATE" classid=<%=Util.CLSID_DATASET%>></object>
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

<comment id="_NSID_">
<object id="DS_IO_DETAIL_CHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL_ORG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKORGPUMBUN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
                  <th width="70" class="point">팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70"  class="point">파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">년월</th>
                  <td colspan="3"><comment id="_NSID_"> <object
                     id=EM_EXE_YM classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_EXE_YM)" align="absmiddle" />
                  </td>
                  <th width="80">브랜드</th>
                  <td colspan="3"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
                      classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
                      align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                      src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                      onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"
                      align="absmiddle" /> <comment id="_NSID_"> <object
                      id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
                      align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
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
                     id=GD_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_MASTER">
                     <Param Name="UsingOneClick"     value="1">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
   
   <tr>
        <td class="right PB02 PT10" valign="bottom"><img
                                    src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
                                    onclick="javascript:btn_Add1();" hspace="2" /><img
                                    src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
                                    onclick="javascript:btn_Del1();" /></td>
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
                     id=GD_DETAIL width=100% height=261 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_DETAIL">
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
