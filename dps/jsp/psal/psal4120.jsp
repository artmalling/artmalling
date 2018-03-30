<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.05.12
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 요일별매출실적
 * 이    력 :2010.05.12 박종은
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

function doInit(){
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');     
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //종료일자
    EM_SALE_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_SALE_DT_S.text =  addDate("d", -6, varToday, "");

    EM_SALE_DT_E.text =  varToday;

    initEmEdit(EM_PUMBUN_CD,         "CODE^6^0",    NORMAL);          //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME,       "GEN^40",      READ);            //브랜드(조회)

    //그리드 초기화
    gridCreate1(); //마스터
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "", "N", strOrgFlag);                                                  //점   
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N", "", strOrgFlag);                                // 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트    
    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC  
 	
        
    LC_STR_CD.BindColVal  = strcd;   
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    orgFlagCheck(orgFlag);
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal412","DS_O_MASTER" );
    
}


function gridCreate1(){
	var strDay    = EM_SALE_DT_S.Text;
    var strDay2   = EM_SALE_DT_E.Text;
	var thisDate  = new Date(strDay.substr(0,4), strDay.substr(4,2)-1, strDay.substr(6,2));
    var thisWeek  = "";
    var strWeek   = "";
    var strFromTo = daysBetween(strDay, strDay2);
    
    var hdrProperies = '<FC>id={currow}                name="NO"            width=30    align=center    </FC>'
                     + '<FC>id=ORG_CD                  name="코드"           width=100    align=center   </FC>'
                     + '<FC>id=ORG_NAME                name="명"             width=100    align=left       sumtext="합계"</FC>'
                     + '<G>                            name="총합계"  '
                     + '<C>id=NORM_AMT                 name="정상"           width=90    align=right    mask="###,###"    sumtext={subsum(NORM_AMT)}</C>'
                     + '<C>id=EVENT_AMT                name="행사"           width=90    align=right    mask="###,###"    sumtext={subsum(EVENT_AMT)}</C>'
                     + '<C>id=TOT_AMT                  name="합계"           width=100    align=right    mask="###,###"    sumtext={subsum(TOT_AMT)}</C>'
                     + '<C>id=CRATE                    name="구성비"          width=60    align=right    mask="###.00"    sumtext={subsum(CRATE)}</C>'
                     + '</G>'

                     for(i=0;i<=strFromTo;i++){
                         var j = i;
                         strDayH   = addDate("d", j, strDay, "");
                         thisDate = new Date(strDayH.substr(0,4), strDayH.substr(4,2)-1, strDayH.substr(6,2));
                         thisWeek = thisDate.getDay();
                         strWeek  = thisWeek+1;
                         strWeek  = rtuWeek(strWeek);
                         strDayH  = strDayH.substr(0,4)+"/"+strDayH.substr(4,2)+"/"+strDayH.substr(6,2);
                         
                         hdrProperies +=
                           '<X>                            name="'+strWeek+'"  '
                         + '<R>'
                         + '<G>                            name="'+strDayH+'"'
                         + '<C>id=NORM_AMT'+j+'            name="정상"           width=90    align=right    mask="###,###"    sumtext={subsum(NORM_AMT'+j+')}</C>'
                         + '<C>id=EVENT_AMT'+j+'           name="행사"           width=90    align=right    mask="###,###"    sumtext={subsum(EVENT_AMT'+j+')}</C>'
                         + '<C>id=TOT_AMT'+j+'             name="합계"           width=100    align=right    mask="###,###"    sumtext={subsum(TOT_AMT'+j+')}</C>'
                         + '<C>id=CRATE'+j+'               name="구성비"          width=60    align=right    mask="###.00"    sumtext={subsum(CRATE'+j+')}</C>'
                         + '<G>'
                         + '</R>'
                         + '</X>'
                         
                         i =j;
                     }
                     ;
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
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
<!-- 매장으로 접근시 에는 매장 매입이 Enable 되고 매입 접근시 Disable 된다 -->
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
    gridCreate1();
    
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPCCd         = LC_PC_CD.BindColVal;       //PC
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
    var strPumbunCd     = EM_PUMBUN_CD.text;         //브랜드코드
    var strFromTo       = daysBetween(strSaleDtS, strSaleDtE);
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPCCd="            +encodeURIComponent(strPCCd)
                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strFromTo="          +encodeURIComponent(strFromTo)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal412.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    if(strTeamCd == "%" && strPCCd == "%" && strDeptCd == "%"){
        GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
        GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
    }
    else{
        if(strTeamCd == "%" && strPCCd == "%" && strDeptCd != "%"){
            GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
            GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
        }
        else{
            if(strTeamCd != "%" && strPCCd == "%"  && !strDeptCd == "%"){
                GD_MASTER.ColumnProp("ORG_CD", "name")   = "조직코드"
                GD_MASTER.ColumnProp("ORG_NAME", "name") = "조직명"
            }
            else{
                if(strTeamCd != "%" && strPCCd != "%" && strDeptCd != "%"){
                    GD_MASTER.ColumnProp("ORG_CD", "name")   = "브랜드코드"
                    GD_MASTER.ColumnProp("ORG_NAME", "name") = "브랜드명"
                }
            }
        }
    }
    
    GD_MASTER.REDRAW = false;
    crate();
    DS_O_MASTER.ResetStatus();
    GD_MASTER.REDRAW = true;
    
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
      var strTitle = "요일별매출실적";

      var strOrgFlag      = EM_ORG_FLAG.Text;
      var strStrCd        = LC_STR_CD.Text;      //점
      var strDeptCd       = LC_DEPT_CD.Text;     //팀
      var strTeamCd       = LC_TEAM_CD.Text;     //파트
      var strPCCd         = LC_PC_CD.Text;       //PC
      var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
      var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
      var strPumbunCd     = EM_PUMBUN_CD.text;         //브랜드코드
      var strFromTo       = daysBetween(strSaleDtS, strSaleDtE);
      
      //var parameters = "단위 : 원, 명, %";
      
      var parameters = "점 "         + strStrCd
			        + " ,   팀 " 	+ strDeptCd
			        + " ,   파트 " 	+ strTeamCd
			        + " ,   PC " 	+ strPCCd
			        + " ,   매출기간 " 	+ strSaleDtS 
			        + " ~ " + strSaleDtE
			        + "     브랜드 "   + strPumbunCd;
      	    
      GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
      openExcel2(GD_MASTER, strTitle, parameters, true );
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
            showMessage(Information, OK, "USER-1003","팀");
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
        if(daysBetween(EM_SALE_DT_S.text, EM_SALE_DT_E.text) >= 7){
        	showMessage(INFORMATION, OK, "USER-1000","매출기간은 7일을 넘을 수 없습니다."); 
        	//EM_SALE_DT_S.text =  addDate("d", -6, EM_SALE_DT_E.text, "");
            EM_SALE_DT_S.focus();
            return false;
        }
        break;
   
    }
    return true;
}

/**
 * crate()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-05-12
 * 개    요 :  구성비계산
 * return값 : void
 */
function crate(){
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	var strFromTo       = daysBetween(strSaleDtS, strSaleDtE);
	var strTotTot       = 0;
	var strTot0         = 0;
	var strTot1         = 0;
	var strTot2         = 0;
    var strTot3         = 0;
    var strTot4         = 0;
    var strTot5         = 0;
    var strTot6         = 0;
    
	
	for(i=1; i<=DS_O_MASTER.CountRow; i++){
		
			strTotTot       += DS_O_MASTER.NameValue(i, "TOT_AMT");
			strTot0         +=  DS_O_MASTER.NameValue(i, "TOT_AMT0");
            strTot1         +=  DS_O_MASTER.NameValue(i, "TOT_AMT1");
            strTot2         +=  DS_O_MASTER.NameValue(i, "TOT_AMT2");
            strTot3         +=  DS_O_MASTER.NameValue(i, "TOT_AMT3");
            strTot4         +=  DS_O_MASTER.NameValue(i, "TOT_AMT4");
            strTot5         +=  DS_O_MASTER.NameValue(i, "TOT_AMT5");
            strTot6         +=  DS_O_MASTER.NameValue(i, "TOT_AMT6");
	}
	
    for(i=1; i<=DS_O_MASTER.CountRow; i++){
        
            DS_O_MASTER.NameValue(i, "CRATE")  = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT")/strTotTot*100,2);
            DS_O_MASTER.NameValue(i, "CRATE0") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT0")/strTot0*100,2);
            DS_O_MASTER.NameValue(i, "CRATE1") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT1")/strTot1*100,2);
            DS_O_MASTER.NameValue(i, "CRATE2") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT2")/strTot2*100,2);
            DS_O_MASTER.NameValue(i, "CRATE3") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT3")/strTot3*100,2);
            DS_O_MASTER.NameValue(i, "CRATE4") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT4")/strTot4*100,2);
            DS_O_MASTER.NameValue(i, "CRATE5") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT5")/strTot5*100,2);
            DS_O_MASTER.NameValue(i, "CRATE6") = getRoundDec("1",DS_O_MASTER.NameValue(i, "TOT_AMT6")/strTot6*100,2);
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
		
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	    getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC	   	 
	    
	    LC_STR_CD.BindColVal=strcd;
	    LC_DEPT_CD.Index = 0;
	    LC_TEAM_CD.Index = 0;
	    LC_PC_CD.Index   = 0; 
	    
	   
		
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		
		var strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);     
	    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N", "", strOrgFlag);                                  // 팀		
	    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
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

	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N", "", strOrgFlag);                                  // 팀		
	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
	
    if(LC_DEPT_CD.BindColVal != "%"){
    	
    	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트   
    }else{
        DS_TEAM_CD.ClearData();
        insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
	var strOrgFlag=EM_ORG_FLAG.CodeValue;
	
    if(LC_TEAM_CD.BindColVal != "%"){
    	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>


<!-- 브랜드코드 변경시 -->   
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
EM_PUMBUN_NAME.Text = "";
var strTeamCd = "";
var strPcCd   = "";

if(LC_TEAM_CD.BindColVal == "%"){
    strTeamCd = "00";
}
else{
    strTeamCd = LC_TEAM_CD.BindColVal;
}
if(LC_PC_CD.BindColVal == "%"){
    strPcCd = "00";
}
else{
    strPcCd = LC_PC_CD.BindColVal;
}
var strOrgCd = LC_STR_CD.bindcolval + LC_DEPT_CD.BindColVal + strTeamCd + strPcCd + "00";

if(EM_PUMBUN_CD.text.length != 0){    
    setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", EM_PUMBUN_CD, EM_PUMBUN_NAME, 'Y', '1','',LC_STR_CD.bindcolval,strOrgCd);
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
                  <td width="105" >
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
                  <th width="70" class="point">팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" >파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">매출기간</th>
                  <td colspan="3"><comment id="_NSID_"> <object
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
                  
                  <th >브랜드</th>
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
                     id=GD_MASTER width=100% height=453 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER">
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
