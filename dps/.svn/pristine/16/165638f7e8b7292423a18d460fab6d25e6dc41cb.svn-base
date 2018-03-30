<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.05.13
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4200.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사테마별매출현황
 * 이    력 :2010.05.13 박종은
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
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //getStore("DS_STR_CD", "Y", "", "N");                                                          // 점
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드   
    var strOrgFlag=EM_ORG_FLAG.CodeValue;//'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';    
       
    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                  //점   
    
    initComboStyle(LC_O_EVENT_L_CD    , DS_O_EVENT_L_CD    , "CODE^0^30,NAME^0^200", 1, PK);  //행사테마(대)(조회)
    initComboStyle(LC_O_EVENT_M_CD    , DS_O_EVENT_M_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사테마(중)(조회)
    initComboStyle(LC_O_EVENT_S_CD    , DS_O_EVENT_S_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사테마(소)(조회)

    //행사테마 대분류 가지고 오기( popup_dps.js )
    getEvtThmeLCode("DS_O_EVENT_L_CD", "N");
    LC_O_EVENT_L_CD.Index = 0;
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    orgFlagCheck(orgFlag);
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal420","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               name="NO"             width=30    align=center    </FC>'
                     + '<FC>id=ETHEM_CD               name="테마코드"        width=60    align=center   suppress=1    sumtext="합계" subsumtext= "행사합계" SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=EVENT_THME_NAME        name="테마명"          width=80    align=left      suppress=1   SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=EVENT_CD               name="행사코드"        width=100    align=center   suppress=2     SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=EVENT_NAME             name="행사명"          width=120    align=left      suppress=2    SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=EVENT_S_DT             name="행사시작일자"     width=80    align=center   mask="XXXX/XX/XX"    suppress=3     SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=EVENT_E_DT             name="행사종료일자"     width=80    align=center   mask="XXXX/XX/XX"    suppress=3     SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=EVENT_PLACE_CD         name="행사장코드"      width=60    align=center    suppress=4     SubBgColor=#FFFFE0  show=false</FC>'
                     + '<FC>id=EVENT_PLACE_NAME       name="행사장명"        width=80    align=left      suppress=4    SubBgColor=#FFFFE0  show=false</FC>'
                     + '<C>id=TOT_SALE_AMT            name="총매출"          width=90    align=right      mask="###,###"      sumtext={subsum(TOT_SALE_AMT)} SubBgColor=#FFFFE0</C>'
                     + '<C>id=AVG_AMT                 name="일평균"          width=90    align=right    mask="###,###"    sumtext={subsum(AVG_AMT)} SubBgColor=#FFFFE0</C>'
                     + '<C>id=PROF_AMT                name="이익액"          width=90    align=right    mask="###,###"    sumtext={subsum(PROF_AMT)} SubBgColor=#FFFFE0</C>'
                     + '<C>id=PROF_RATE               name="이익율"          width=90    align=right      mask="###.00"    sumtext={decode(subsum(TOT_SALE_AMT),0,0.00,round((subsum(PROF_AMT)/subsum(TOT_SALE_AMT))*100,2))}   SubBgColor=#FFFFE0</C>'
                     + '<C>id=CUST_CNT                name="객수"            width=90    align=right       mask="###,###"    sumtext={subsum(CUST_CNT)}  SubBgColor=#FFFFE0</C>'
                     + '<C>id=CUST_CNT_DANGA          name="객단가"          width=90    align=right      mask="###,###"     sumtext={decode(subsum(CUST_CNT),0,0,subsum(TOT_SALE_AMT)/subsum(CUST_CNT))}  SubBgColor=#FFFFE0</C>'
                     ;
        
        

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
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
    var strOrgFlag      = EM_ORG_FLAG.CodeValue;
    var strStrCd        = LC_STR_CD.BindColVal;             //점
    var strLCd          = LC_O_EVENT_L_CD.BindColVal;       //테마코드 (대)
    var strMCd          = LC_O_EVENT_M_CD.BindColVal;       //테마코드 (중)
    var strSCd          = LC_O_EVENT_S_CD.BindColVal;       //테마코드 (소)
    var strSaleDtS      = EM_SALE_DT_S.text;                //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;                //종료일자
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strLCd="             +encodeURIComponent(strLCd)
                   + "&strMCd="             +encodeURIComponent(strMCd)
                   + "&strSCd="             +encodeURIComponent(strSCd)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strSaleDtE="         +encodeURIComponent(strSaleDtE)
                   + "&strOrgFlag="         +encodeURIComponent(strOrgFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal420.ps?goTo="+goTo+parameters;  
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
    var strTitle = "행사테마별매출현황";
    
    var strStrCd        = LC_STR_CD.Text;      //점
    var strLCd          = LC_O_EVENT_L_CD.Text;       //테마코드 (대)
    var strMCd          = LC_O_EVENT_M_CD.Text;       //테마코드 (중)
    var strSCd          = LC_O_EVENT_S_CD.Text;       //테마코드 (소)
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자

    
    var parameters = 
         "점 "              +strStrCd
       + " , 테마코드(대) "        +strLCd
       + " , 테마코드(중) "        +strMCd
       + " , 테마코드(소) "        +strSCd
       + " , 매출기간 "      +strSaleDtS + "~" + strSaleDtE;
        
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

    if(!chkValidation("search")){
        return;
    }

    var strStrCd        = LC_STR_CD.BindColVal;             //점
    var strLCd          = LC_O_EVENT_L_CD.BindColVal;       //테마코드 (대)
    var strMCd          = LC_O_EVENT_M_CD.BindColVal;       //테마코드 (중)
    var strSCd          = LC_O_EVENT_S_CD.BindColVal;       //테마코드 (소)
    

    var strStrCdN       = LC_STR_CD.Text;             //점
    var strLCdN         = LC_O_EVENT_L_CD.Text;       //테마코드 (대)
    var strMCdN         = LC_O_EVENT_M_CD.Text;       //테마코드 (중)
    var strSCdN         = LC_O_EVENT_S_CD.Text;       //테마코드 (소)
    
    var strSaleDtS      = EM_SALE_DT_S.text;                //시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;                //종료일자
    var strUserId       = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';

    
    var params   = "&strStrCd="   +strStrCd
                 + "&strLCd="     +strLCd
                 + "&strMCd="     +strMCd
                 + "&strSCd="     +strSCd
                 + "&strSaleDtS=" +strSaleDtS
                 + "&strSaleDtE=" +strSaleDtE
                 + "&strUserId="  +strUserId
                 + "&strStrCdN="  +encodeURIComponent(strStrCdN)
                 + "&strLCdN="    +encodeURIComponent(strLCdN)
                 + "&strMCdN="    +encodeURIComponent(strMCdN)
                 + "&strSCdN="    +encodeURIComponent(strSCdN);
    
    window.open("/dps/psal420.ps?goTo=print"+params,"OZREPORT", 1000, 700);
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
	    
	    LC_STR_CD.BindColVal=strcd; 
	}else if(EM_ORG_FLAG.CodeValue=="2"){
		var strOrgFlag=EM_ORG_FLAG.CodeValue;	
		var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	    getStore2("DS_STR_CD", "Y", "1", "N", strOrgFlag);                                                   //점
	    
	    LC_STR_CD.BindColVal = strcd;
	}
</script>

<!-- 행사테마(대)(조회) -->
<script language=JavaScript for=LC_O_EVENT_L_CD event=OnSelChange()>
    DS_O_EVENT_M_CD.ClearData();
    DS_O_EVENT_S_CD.ClearData();
    getEvtThmeMCode("DS_O_EVENT_M_CD", this.BindColVal, "Y");
    setComboData(LC_O_EVENT_M_CD,'%');
</script>
<!-- 행사테마(중)(조회) -->
<script language=JavaScript for=LC_O_EVENT_M_CD event=OnSelChange()>
    DS_O_EVENT_S_CD.ClearData();
    getEvtThmeSCode("DS_O_EVENT_S_CD", LC_O_EVENT_L_CD.BindColVal, this.BindColVal, "Y");
    setComboData(LC_O_EVENT_S_CD,'%');
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
<object id="DS_O_EVENT_L_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EVENT_M_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_EVENT_S_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>>
        <param name=SortExpr    value="+ETHEM_CD+ETHEM_NAME+EVENT_CD+EVENT_NAME+EVENT_S_DT+EVENT_E_DT+EVENT_PLACE_CD+EVENT_PLACE_NAME">
        <param name=Syncload    value="true">
        <param name=SubsumExpr  value="EVENT_CD">
</object>
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
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                  <th  width="70" class="point">행사테마(대)</th>
                  <td  width="105">
                    <comment id="_NSID_">
                      <object id=LC_O_EVENT_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width=95 tabindex=1 align="absmiddle"></object>
                     </comment><script>_ws_(_NSID_);</script>
                   </td>
                  <th  width="70">행사테마(중)</th>
                  <td  width="105">
                     <comment id="_NSID_">
                       <object id=LC_O_EVENT_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width=95 tabindex=1 align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th  width="70">행사테마(소)</th>
                  <td >
                    <comment id="_NSID_">
                      <object id=LC_O_EVENT_S_CD classid=<%= Util.CLSID_LUXECOMBO %> width=95 tabindex=1 align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
               </tr>
               <tr>
                  <th class="point">매출기간</th>
                  <td colspan="7"><comment id="_NSID_"> <object
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
                     id=GD_MASTER width=100% height=422 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
