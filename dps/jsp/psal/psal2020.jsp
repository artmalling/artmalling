<!-- 
/*******************************************************************************
 * 시스템 명 : 백화점 영업관리 > 매출관리 > 실행계획
 * 작  성  일 : 2010.03.25
 * 작  성  자 : 박종은
 * 수  정  자 : 
 * 파  일  명 : psal2020.jsp
 * 버       전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요 : 실행PC별가중치등록
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
 var top = 350;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');  
    DS_IO_DETAIL_VIEW.setDataHeader('<gauce:dataset name="H_SEL_DETAIL_VIEW"/>');  
    DS_O_DAY_WEIGHT.setDataHeader('<gauce:dataset name="H_SEL_DAY_WEIGHT"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    //gridCreate2(); //디테일
    gridCreate3(); //디테일

    // EMedit에 초기화
    initEmEdit(EM_PLAN_YM,                      "YYYYMM",                PK);   //년월
    EM_PLAN_YM.alignment = 1;
    initEmEdit(EM_SALE_DAY_CNT,                 "NUMBER^5^2",            READ); //영업일수
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD,         "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD,       "CODE^0^30,NAME^0^80", 1, PK);  //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD,       "CODE^0^30,NAME^0^80", 1, PK);  //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD,           "CODE^0^30,NAME^0^80", 1, NORMAL);  //PC(조회)
    
    getStore("DS_STR_CD", "Y", "",                   "N");                                                // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                                // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "N");                         // 파트  
    getPc("DS_PC_CD",     "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y"); // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index     = 0;
    LC_TEAM_CD.Index     = 0;
    LC_PC_CD.Index       = 0;
    
    //현재년도 셋팅
    EM_PLAN_YM.text = varToMon;
    //detailCnt();

    // 월 영업일수  MARIO OUTLET
    countSaleDate();

    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal202","DS_IO_DETAIL" );

    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            name="NO"            width=30    align=center     </FC>'
                     + '<FC>id=STR_CD              name="점"            width=40    align=center      Edit=none   </FC>'
                     + '<FC>id=STR_NAME            name="점명"           width=80    align=left       Edit=none   </FC>'
                     + '<FC>id=DEPT_CD             name="팀"           width=40    align=center     Edit=none   </FC>'
                     + '<FC>id=DEPT_ORG_NAME       name="팀명"         width=80    align=left        Edit=none   </FC>'
                     + '<FC>id=TEAM_CD             name="파트"             width=40    align=center     Edit=none   </FC>'
                     + '<FC>id=TEAM_ORG_NAME       name="파트명"           width=80    align=left        Edit=none   </FC>'
                     + '<FC>id=PC_CD               name="PC"             width=40    align=center     Edit=none   </FC>'
                     + '<FC>id=PC_ORG_NAME         name="PC명"           width=80    align=left        Edit=none   </FC>'
                     + '<FC>id=YYYYMM              name="년월"           width=80    align=left        Edit=none   show=false</FC>'
                     + '<FC>id=BFYY_WEIGHT         name="전년가중치합"     width=100   align=right       Edit=none   </FC>'
                     + '<FC>id=ORIGIN_WEIGHT       name="당년가중치합"     width=100   align=right       Edit=none   </FC>'
                     ;
                    
    
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate3(){
	
    var hdrProperies = '<COLUMNINFO>'+
				    
                    '       <COLUMN id="PCCD" refcolid="PC_CD" index="1">'+
                    '           <HEADER left="0" top="0" right="100" bottom="40" text="PC" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                    ' <SUPPRESS>            <REFCOLID>PC_CD</REFCOLID>           </SUPPRESS>'+
                    '           <VIEW left="0" top="0" right="100" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'+
                    '       </COLUMN>'+
				    
                    '       <COLUMN id="NAME"  refcolid="ORG_NAME" index="2">'+
                    '           <HEADER left="100" top="0" right="200" bottom="40" text="PC명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                    ' <SUPPRESS>            <REFCOLID>ORG_NAME</REFCOLID>           </SUPPRESS>'+
                    '           <VIEW left="100" top="0" right="200" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '       </COLUMN>'+
                
                    '       <COLUMN id="GBN"  refcolid="GUBUN" index="3">'+
                    '           <HEADER left="200" top="0" right="300" bottom="40" text="구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '           <VIEW left="200" top="0" right="300" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '       </COLUMN>'+
                
                    '       <COLUMN id="TOTAL1"  refcolid="TOTAL" index="4">'+
                    '           <HEADER left="300" top="0" right="350" bottom="40" text="합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '           <VIEW left="300" top="0" right="350" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '       </COLUMN>'+
                
                    '       <COLUMN id="GAB1"  refcolid="GAB" index="5">'+
                    '           <HEADER fix="true" left="350" top="0" right="400" bottom="40" text="오차" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '           <VIEW left="350" top="0" right="400" bottom="40" borderstyle="Line" bordercolor="#dddddd"/>'+
                    '       </COLUMN>'
//     var strYYYYMM   = varToMon;                                                        //년월
    var strYYYYMM   = EM_PLAN_YM.Text;
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();   

				    for(i=1;i<= strEndDate; i++){
				        hdrProperies +=  
				                
                                '       <COLUMN id="DW' +i+'"  refcolid="DAYWEEK'+i+'"   view="false">'+
                                '           <HEADER left="'+(350+(i*50))+'" top="0" right="'+(400+(i*50))+'" bottom="20" text="'+i+'일" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                                '           <VIEW left="'+(350+(i*50))+'" top="0" right="'+(400+(i*50))+'" bottom="20" borderstyle="Line" bordercolor="#dddddd"/>'+
                                '       </COLUMN>'
				    }
				    for(i=1;i<= strEndDate; i++){
				        hdrProperies +=  
				                
                                '       <COLUMN id="D' +i+'"  refcolid="DAY'+i+'"  view="false">'+
                                '           <HEADER left="'+(350+(i*50))+'" top="20" right="'+(400+(i*50))+'" bottom="40" text="가중치" align="center" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'+
                                '           <VIEW left="'+(350+(i*50))+'" top="20" right="'+(400+(i*50))+'" bottom="40" text="@ROUND(DAY'+i+',2)" borderstyle="Line" bordercolor="#dddddd"/>'+
                                '           <CHILD type="edit" inputtype="num"  editable="true"/>' +
                                '       </COLUMN>'
				    }
				    hdrProperies +='     </COLUMNINFO>';
                    

    initMGridStyle(GD_DETAIL2, "common", hdrProperies);
    DS_IO_DETAIL_VIEW.UseChangeInfo = false;  
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
 * 작 성 일 : 2010-03-25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if (DS_IO_DETAIL_VIEW.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    

    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_IO_DETAIL_VIEW.ClearData();
    DS_O_DAY_WEIGHT.ClearData();

    //1. validation 
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strPlanYm       = EM_PLAN_YM.text;           //년월
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPlanYm="          +encodeURIComponent(strPlanYm);
    
    TR_MAIN.Action="/dps/psal202.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    detailCnt();
    // 조회결과 Return
    
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    GD_MASTER.focus();
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-25
 * 개    요 : DB에 저장  / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 /*
	if (!DS_IO_DETAIL_VIEW.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    */
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;
    
    var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PC_CD");            //PC
    var strYYYYMM       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "YYYYMM");           //년월
    var lastDate        = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate      = lastDate.getDate();                                                 //마지막일자
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
        return;

    var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
                    + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                    + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                    + "&strPCCd="         +encodeURIComponent(strPCCd)
                    + "&strYYYYMM="       +encodeURIComponent(strYYYYMM)
                    + "&strEndDate="      +encodeURIComponent(strEndDate);
    
    TR_MAIN.Action = "/dps/psal202.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL_VIEW=DS_IO_DETAIL_VIEW)"; 
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
    var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPCCd         = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PC_CD");            //PC
    var strYYYYMM       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "YYYYMM");           //년월
    
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                   + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="            +encodeURIComponent(strTeamCd)
                   + "&strPCCd="              +encodeURIComponent(strPCCd)
                   + "&strYYYYMM="            +encodeURIComponent(strYYYYMM)
                   + "&strEndDate="           +encodeURIComponent(strEndDate);
    
    TR_DETAIL.Action="/dps/psal202.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL_VIEW=DS_IO_DETAIL_VIEW)"; //조회는 O
    TR_DETAIL.Post();
    
    

//     gridCreate3(); //디테일
    DS_IO_DETAIL_VIEW.RowPosition = 1;
    // 조회결과 Return
    
    
    changeSum();
    DS_IO_DETAIL_VIEW.ResetStatus();
    GD_DETAIL2.focus();
    setPorcCount("SELECT", DS_IO_DETAIL_VIEW.CountRow);
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
        //팀 체크
        if (isNull(LC_DEPT_CD.BindColVal)==true ) {
            showMessage(INFORMATION, OK, "USER-1003","팀");
            return false;
        }
        //파트 체크
        if (isNull(LC_TEAM_CD.BindColVal)==true ) {
            showMessage(INFORMATION, OK, "USER-1003","파트");
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
    	
    	
    	// 2011.08.08 MARIO OUTLET COMMENT
        //if(DS_IO_DETAIL_VIEW.NameValue(2, "GAB") != 0){
        //	showMessage(INFORMATION, OK, "USER-1000","오차가 있습니다. 확인하십시오.");
        //    return false;
        //}
        // 2011.08.08 MARIO OUTLET COMMENT
        
        
        // MARIO OUTLET 2011.08.11 - DPS.PS_SCHEDULE의 가중치 합 < 등록가중치합인 경우 에러
        if ( DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORIGIN_WEIGHT_S") < DS_IO_DETAIL_VIEW.NameValue(2, "TOTAL")) {
            showMessage(INFORMATION, OK, "USER-1000", "PC별 가중치 합이 영업일 정보의 매출 표준 가중치합보다 큽니다. 확인 후 저장하십시오.");
            return false;
        }
        
        //당초브랜드별월매출계획 확정체크
        var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
        var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
        var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
        var strPCCd      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PC_CD");        //파트코드
        var strYYYYMM    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"YYYYMM");         //계획년월
        
        var goTo       = "searchConfFlag" ;    
        var action     = "O";     
        var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                       + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                       + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                       + "&strPCCd="            +encodeURIComponent(strPCCd)
                       + "&strYYYYMM="          +encodeURIComponent(strYYYYMM);

        TR_MAIN.Action="/dps/psal202.ps?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
        TR_MAIN.Post();
        
        if (DS_MCHKCONFFLAG.countRow == 0) {
            showMessage(INFORMATION, OK, "USER-1000", "당초브랜드별월매출목표가 미확정된 데이터입니다.확정 후 다시 등록하십시오.");
            return false;
        }
        
        var goTo       = "searchActConf" ;    
        var action     = "O";     
        var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                       + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                       + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                       + "&strPCCd="            +encodeURIComponent(strPCCd)
                       + "&strYYYYMM="          +encodeURIComponent(strYYYYMM);

        TR_MAIN.Action="/dps/psal202.ps?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET("+action+":DS_ACTCONF=DS_ACTCONF)"; 
        TR_MAIN.Post();
        
        if (DS_ACTCONF.countRow != 0) {
            showMessage(INFORMATION, OK, "USER-1000", "실행목표가 확정된 데이터입니다. 확정 취소 후 등록하십시오");
            return false;
        }

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

	    //1. validation Master 그리드 필수 입력 체크 
	    if(!chkValidation("save")) return;

	    var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
	    var strDeptCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
	    var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
	    var strPCCd         = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PC_CD");            //PC
	    var strYYYYMM       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "YYYYMM");           //년월
	    var lastDate        = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
	    var strEndDate      = lastDate.getDate();                                                 //마지막일자
	    
	    var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
	                    + "&strDeptCd="       +encodeURIComponent(strDeptCd)
	                    + "&strTeamCd="       +encodeURIComponent(strTeamCd)
	                    + "&strPCCd="         +encodeURIComponent(strPCCd)
	                    + "&strYYYYMM="       +encodeURIComponent(strYYYYMM)
	                    + "&strEndDate="      +encodeURIComponent(strEndDate);
	    
	    TR_MAIN.Action = "/dps/psal202.ps?goTo=save"+parameters;
	    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL_VIEW=DS_IO_DETAIL_VIEW)"; 
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
	var originTotal     = 0;
	var gab             = 0;
	var strYYYYMM   = EM_PLAN_YM.text;                                                        //년월
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate(); 
    
	for(i=1; i <= strEndDate; i++){
		bfyyTotal   += getRoundDec("1",DS_IO_DETAIL_VIEW.NameValue(1, "DAY"+i),2);
		originTotal += getRoundDec("1",DS_IO_DETAIL_VIEW.NameValue(2, "DAY"+i),2);
        
	}
	
	gab = getRoundDec("1", originTotal, 2) - getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_WEIGHT"),2);
	
	//DS_IO_DETAIL_VIEW.NameValue(1, "TOTAL") = bfyyTotal;
	//DS_IO_DETAIL_VIEW.NameValue(2, "TOTAL") = originTotal;
	//DS_IO_DETAIL_VIEW.NameValue(2, "GAB")   = gab;
	
	DS_IO_DETAIL_VIEW.NameValue(1, "TOTAL") = getRoundDec("1",bfyyTotal,2);
	DS_IO_DETAIL_VIEW.NameValue(2, "TOTAL") = getRoundDec("1",originTotal,2);
	DS_IO_DETAIL_VIEW.NameValue(2, "GAB")   = getRoundDec("1",gab,2);
	
	
	
	
    
}

 /**
  * detailCnt()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-03-29
  * 개    요 :  컬럼을 해당월의 마지막날까지만 보여준다
  * return값 : void
  */
function detailCnt(){
    var strYYYYMM   = EM_PLAN_YM.text;                                                        //년월
	var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
	var strEndDate  = lastDate.getDate();                                                     //마지막일자
	 
	for(i=1; i<= strEndDate; i++){
		if(i <= strEndDate){
			GD_DETAIL2.LayoutInfo("ColumnInfo", "D"+i+"::view")  = true;
	        GD_DETAIL2.LayoutInfo("ColumnInfo", "DW"+i+"::view") = true;
	        GD_DETAIL2.LayoutInfo("ColumnInfo", "D"+i+"H"+"::view")  = true;
            GD_DETAIL2.LayoutInfo("ColumnInfo", "DW"+i+"H"+"::view") = true;
		}
		else{
			GD_DETAIL2.LayoutInfo("ColumnInfo", "D"+i+"::view")  = false;
	        GD_DETAIL2.LayoutInfo("ColumnInfo", "DW"+i+"::view") = false;
	        GD_DETAIL2.LayoutInfo("ColumnInfo", "D"+i+"H"+"::view")  = false;
            GD_DETAIL2.LayoutInfo("ColumnInfo", "DW"+i+"H"+"::view") = false;
		}
		
	}
    
}

/**
 * bfyyPCWeightCopy()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-29
 * 개    요 :  전년pc별가중치 복사
 * return값 : void
 */
function bfyyPCWeightCopy(){
    if(DS_IO_DETAIL_VIEW.CountRow == 0) return;
    
  
    if (showMessage(QUESTION, YESNO, "USER-1000", "전년PC별가중치를 복사 하시겠습니까?") != 1){
    	return;
    }
        

    var strYYYYMM   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "YYYYMM");                                                        //년월
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    
    for(i=1; i <= strEndDate; i++){
        DS_IO_DETAIL_VIEW.NameValue(2, "DAY"+i) = DS_IO_DETAIL_VIEW.NameValue(1, "DAY"+i);
    }
    changeSum();
}

function dayWeightCopy(){
    
	if(DS_IO_DETAIL_VIEW.CountRow == 0) return;
    
  
    if (showMessage(QUESTION, YESNO, "USER-1000", "영업일 정보의가중치를 복사 하시겠습니까?") != 1){
    	return;
    }
    
    var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
    var strYYYYMM       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "YYYYMM");           //년월
    
    
    var goTo       = "searchDayWeight" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                   + "&strYYYYMM="            +encodeURIComponent(strYYYYMM)
    
    TR_DETAIL.Action="/dps/psal202.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DAY_WEIGHT=DS_O_DAY_WEIGHT)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_DAY_WEIGHT.CountRow == 0) {
    	showMessage(INFORMATION, OK, "USER-1000", "영업일 가중치 정보가 없습니다.");
    	return;
    }
	
    var strYYYYMM   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "YYYYMM");                                                        //년월
    var lastDate    = new Date(strYYYYMM.substr(0,4), strYYYYMM.substr(4,2), 0);
    var strEndDate  = lastDate.getDate();                                                     //마지막일자
    
    for(i=1; i <= strEndDate; i++){
        DS_IO_DETAIL_VIEW.NameValue(2, "DAY"+i) = DS_O_DAY_WEIGHT.NameValue(i,"STD_WEIGHT");
    }
    changeSum();
}


/**
 * countSaleDate()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-21
 * 개    요 :  확정,확정취소
 * return값 : void
 */
function countSaleDate(){

     var strStrCd        = LC_STR_CD.BindColVal;      //점
     var strYYYYMM       = EM_PLAN_YM.text;           //년월
        
     var goTo       = "countSaleDate" ;    
     var action     = "O";     
     var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                    + "&strYYYYMM="          +encodeURIComponent(strYYYYMM);

     TR_MAIN.Action="/dps/psal202.ps?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DAY_COUNT=DS_O_DAY_COUNT)"; 
     TR_MAIN.Post();
        
     if (DS_O_DAY_COUNT.countRow > 0) {
         EM_SALE_DAY_CNT.text = DS_O_DAY_COUNT.NameValue(DS_O_DAY_COUNT.countRow,"CNT");
     } else {
    	 EM_SALE_DAY_CNT.text = 0;
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
<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row <= 0 ){
    setFocusGrid(GD_MASTER, DS_O_MASTER,0,colid);
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
}
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row > 0){
    if (DS_IO_DETAIL_VIEW.IsUpdated ){
        ret = showMessage(QUESTION, YESNO, "USER-1074");
        if (ret != "1") {
            DS_O_MASTER.RowPosition = old_Row;
            return false;
        } 
    }
    searchDetail();
}

old_Row = row;
</script>

<script language="javascript">
    var today    = new Date();
    
    var old_Row = 0;

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
    // 점 영업일자 변경. MARIO OUTLET
    countSaleDate();
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

<script language=JavaScript for=DS_O_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row
</script>
<script language=JavaScript for=GD_DETAIL2 event=OnExit(colid,index,orgtext)>


</script>
 
<script language=JavaScript for=GD_DETAIL2 event=OnKillFocus()>
changeSum();
</script>

<script language=JavaScript for=DS_IO_DETAIL_VIEW event=OnRowPosChanged(row)>
    
</script>
  
 
<script language=JavaScript for=GD_DETAIL2 event=OnSelChanged(colid,index)>

if(index == 2){
	GD_DETAIL2.LayoutInfo("ColumnInfo", colid+"::<CHILD>::editable") ="true";
    GD_DETAIL2.ActivateEdit();
    changeSum();
}
else{
	GD_DETAIL2.LayoutInfo("ColumnInfo", colid+"::<CHILD>::editable") ="false";
}
GD_DETAIL2. EnableDblClkAtNotEditable = true;

</script>

<script language=JavaScript for=GD_DETAIL2 event=OnSelChange(colid,index)>

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
    
 	// 점 영업일자 변경. //MARIO OUTLET
    countSaleDate();
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
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_ACTCONF" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL_VIEW" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DAY_COUNT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DAY_WEIGHT" classid=<%=Util.CLSID_DATASET%>></object>
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
                  <td ><comment id="_NSID_"> <object
                     id=EM_PLAN_YM classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_PLAN_YM)" align="absmiddle" />
                  </td>
                  <th>영업일수</th>
                  <td colspan="5"><comment id="_NSID_"> <object
                     id=EM_SALE_DAY_CNT classid=<%=Util.CLSID_EMEDIT%> width=72
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
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
    
   <tr>
      <td class="right PB03 PT03">
      <table width="160" border="0" cellpadding="0" cellspacing="0">
         <tr>
         <th><img src="/<%=dir%>/imgs/btn/pc_add_2.gif"
               onclick="dayWeightCopy();" align="right" /></th>
            <th><img src="/<%=dir%>/imgs/btn/pc_add_copy.gif"
               onclick="bfyyPCWeightCopy();" align="right" /></th>
         </tr>
      </table>
      </td>
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
                  id=GD_DETAIL2 width=100% height=268 classid=<%=Util.CLSID_MGRID%>>
                     <param name="DataID" value="DS_IO_DETAIL_VIEW">
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
