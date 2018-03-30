<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : psal5220.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
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
    
    // Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');   
    
    
    
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_PUMBUN_CD  , "CODE^6^0" ,  NORMAL);    //브랜드코드
    initEmEdit(EM_PUMBUN_NAME, "GEN^40"   ,  NORMAL);     //브랜드명
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);  
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);  
    EM_SALE_DT_E.alignment = 1;

    EM_SALE_DT_S.text =  varToMon+"01";
    
    initEmEdit(EM_APP_DT_S,                      "YYYYMMDD",                PK);  
    EM_APP_DT_S.alignment = 1;

    initEmEdit(EM_APP_DT_E,                      "YYYYMMDD",                PK);  
    EM_APP_DT_E.alignment = 1;

    EM_APP_DT_S.text =  varToMon+"01";

    EM_APP_DT_S.Enable = true;
    EM_APP_DT_E.Enable = true;
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y");   // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    EM_SALE_DT_E.text =  varToday;
    EM_APP_DT_E.text =  varToday;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal522","DS_O_MASTER,DS_IO_DETAIL" );
    
}

function gridCreate1(){
	   
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center</FC>'
    	+ '<FC>id=SALE_DT         name="매출일자"        	width=100  align=center mask="XXXX/XX/XX"</FC>'
    	+ '<FC>id=POS_NO          name="POS번호"        	width=100  align=center </FC>'
    	+ '<FC>id=PUMBUN_CD       name="브랜드코드"        	width=100  align=center </FC>'
    	+ '<FC>id=PUMBUN_NAME     name="브랜드명"        		width=100  align=center </FC>'
    	+ '<FC>id=PUMMOK_CD       name="품목코드"        	width=100  align=center </FC>'
    	+ '<FC>id=PUMMOK_NAME     name="품목명"        		width=100  align=center </FC>'
    	+ '<FC>id=EVENT_CD        name="행사코드"        	width=100  align=center </FC>'
    	+ '<FC>id=EVENT_NAME      name="행사명"        		width=100  align=center </FC>'
    	+ '<FC>id=EVENT_RATE      name="행사율"        		width=100  align=center </FC>'
    	+ '<FG>                     name="매출취소"'
    	+ '<FC>id=MOD_EVENT_FLAG_C  name="행사구분"        		width=100  align=center </C>'
    	+ '<FC>id=MOD_MG_RATE_C  	 name="마진율"        		width=100  align=center </C>'
    	+ '<FC>id=SALE_QTY_C        name="판매수량"        	width=100  align=right 	</C>'
    	+ '<FC>id=TOT_SALE_AMT_C    name="총매출금액"       width=100  align=right 	</C>'
    	+ '<FC>id=REDU_AMT_C        name="할인금액"        	width=100  align=right 	</C>'
    	+ '<FC>id=DC_AMT_C          name="에누리금액"       width=100  align=right 	</C>'
    	+ '</FG>'
		+ '<FG>                     name="매출발생"'
    	+ '<FC>id=MOD_EVENT_FLAG_N  name="행사구분"        		width=100  align=center </C>'
    	+ '<FC>id=MG_APP_DT_N  	 	 name="마진적용일"        		width=100 align=center mask="XXXX/XX/XX" </C>'
    	+ '<FC>id=MOD_MG_RATE_N  	 name="마진율"        		width=100  align=center </C>'
    	+ '<FC>id=SALE_QTY_N        name="판매수량"        	width=100  align=right 	</C>'
    	+ '<FC>id=TOT_SALE_AMT_N    name="총매출금액"       width=100  align=right 	</C>'
    	+ '<FC>id=REDU_AMT_N        name="할인금액"        	width=100  align=right 	</C>'
    	+ '<FC>id=DC_AMT_N          name="에누리금액"       width=100  align=right 	</C>'
    	+ '</FG>'
    	+ '<FC>id=REG_DATE        name="등록일시"        					width=150  align=center </FC>'
    	+ '<FC>id=REG_ID          name="등록자"        					width=80  align=center </FC>'

;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies,false);
}



/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
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
	
	 
	var strStrCd      = LC_STR_CD.BindColVal;
    var strDeptCd     = LC_DEPT_CD.BindColVal;
    var strTeamCd     = LC_TEAM_CD.BindColVal;
    var strPcCd       = LC_PC_CD.BindColVal;
    var strSaleDtS    = EM_SALE_DT_S.Text;
    var strSaleDtE    = EM_SALE_DT_E.Text;
    var strAppDtS     = EM_APP_DT_S.Text;
    var strAppDtE     = EM_APP_DT_E.Text;
    
    var strPumbunCd   = EM_PUMBUN_CD.Text;
    var strCheck      = CB_GUBUN.value;
    
    
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="    	+ encodeURIComponent(strStrCd)
                    + "&strDeptCd="   	+ encodeURIComponent(strDeptCd)
                    + "&strTeamCd="   	+ encodeURIComponent(strTeamCd)
                    + "&strPcCd="     	+ encodeURIComponent(strPcCd)
                    + "&strSaleDtS="  	+ encodeURIComponent(strSaleDtS)
                    + "&strSaleDtE="  	+ encodeURIComponent(strSaleDtE)
                    + "&strAppDtS="    	+ encodeURIComponent(strAppDtS)
                    + "&strAppDtE="    	+ encodeURIComponent(strAppDtE)
                    + "&strPumbunCd=" 	+ encodeURIComponent(strPumbunCd)
                    + "&strCheck=" 		+ encodeURIComponent(strCheck);
    TR_MAIN.Action  ="/dps/psal522.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
    	DS_O_MASTER.RowPosition = 0;
        sortColId( DS_O_MASTER, 0, "SALE_DT");
        GD_MASTER.Focus();
    }else{
    	EM_PUMBUN_CD.Focus();
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
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCode(evnflag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;
    var strCd = LC_STR_CD.BindColVal;
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }

    if( evnflag == "POP" ){
        strPbnPop(codeObj,nameObj,'Y','', strCd,'','','','','','');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",0,'', strCd,'','','','','','');
    }    
}

function fn_onClick(){
	
	if(CB_GUBUN.value == "1") {
		CB_GUBUN.value = "0";
		EM_APP_DT_S.Enable = false;
		EM_APP_DT_E.Enable = false;
	} else {
		CB_GUBUN.value = "1"
		EM_APP_DT_S.Enable = true;
		EM_APP_DT_E.Enable = true;
		
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


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- Grid GD_MASTER OnPopup event 처리 -->
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
        getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트   
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
    if(LC_TEAM_CD.BindColVal != "%"){
        getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<!-- 년월 -->
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
    
    if(EM_SALE_DT_S.text > EM_SALE_DT_E.text) {
    	showMessage(Information, OK, "USER-1021","시작일자","종료일자");
        EM_SALE_DT_S.text = varToMon+"01";
        EM_SALE_DT_S.Focus();
        return ;
    }

</script>

<!-- 년월 -->
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
    
    if(EM_SALE_DT_S.text > EM_SALE_DT_E.text) {
    	showMessage(Information, OK, "USER-1020","종료일자","시작일자");
        EM_SALE_DT_E.text = varToday;
        EM_SALE_DT_E.Focus();
        return ;
    }
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_APP_DT_S event=onKillFocus()>

	if(CB_GUBUN.value == "1") {
	    //영업조회일
	    if (isNull(EM_APP_DT_S.text) ==true ) {
	        showMessage(Information, OK, "USER-1003","시작일자"); 
	        EM_APP_DT_S.text = varToMon+"01";
	        return ;
	    }
	    //영업조회일 자릿수, 공백 체크
	    if (EM_APP_DT_S.text.replace(" ","").length != 8 ) {
	        showMessage(Information, OK, "USER-1027","시작일자","8");
	        EM_APP_DT_S.text = varToMon+"01";
	        return ;
	    }
	    //일자형식체크
	    if (!checkYYYYMMDD(EM_APP_DT_S.text) ) {
	        showMessage(Information, OK, "USER-1069","시작일자");
	        EM_APP_DT_S.text = varToMon+"01";
	        return ;
	    }
	    
	    if(EM_APP_DT_S.text > EM_APP_DT_E.text) {
	    	showMessage(Information, OK, "USER-1021","시작일자","종료일자");
	    	EM_APP_DT_S.text = varToMon+"01";
	    	EM_APP_DT_S.Focus();
	        return ;
	    }
	}
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_APP_DT_E event=onKillFocus()>

	if(CB_GUBUN.value == "1") {
	    //영업조회일
	    if (isNull(EM_APP_DT_E.text) ==true ) {
	        showMessage(Information, OK, "USER-1003","종료일자"); 
	        EM_APP_DT_E.text = varToday;
	        return ;
	    }
	    //영업조회일 자릿수, 공백 체크
	    if (EM_APP_DT_E.text.replace(" ","").length != 8 ) {
	        showMessage(Information, OK, "USER-1027","종료일자","8");
	        EM_APP_DT_E.text = varToday;
	        return ;
	    }
	    //일자형식체크
	    if (!checkYYYYMMDD(EM_APP_DT_E.text) ) {
	        showMessage(Information, OK, "USER-1069","종료일자");
	        EM_APP_DT_E.text = varToday;
	        return ;
	    }
	    
	    if(EM_APP_DT_S.text > EM_APP_DT_E.text) {
	    	showMessage(Information, OK, "USER-1020","종료일자","시작일자");
	    	EM_APP_DT_E.text = varToday;
	    	EM_APP_DT_E.Focus();
	        return ;
	    }
    
	}
    
    
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    
    if(!this.Modified)
        return;
    setPumbunCode('NAME');
    
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
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
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
                  <th width="70" >팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">매출일자</th>
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
                  <th width="60" >브랜드</th>
		          <td colspan="3">
		              <comment id="_NSID_">
		                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"></object>
		              </comment><script> _ws_(_NSID_);</script>
		              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCode('POP');"  align="absmiddle" />
		              <comment id="_NSID_">
		                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1 align="absmiddle"></object>
		              </comment><script> _ws_(_NSID_);</script>
		          </td>
               </tr>
               <tr>
                  <th>마진적용일</th>
                  <td colspan="7" >
                  <comment id="_NSID_"> <object
                     id=EM_APP_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="middle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_APP_DT_S.Enable) openCal('G',EM_APP_DT_S);" align="middle" />
                  ~
                     <comment id="_NSID_"> <object
                     id=EM_APP_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="middle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_APP_DT_E.Enable) openCal('G',EM_APP_DT_E);" align="middle" />
                  <input type="checkbox" id="CB_GUBUN" checked="checked" value="1"  onclick="fn_onClick();"/> 
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
      <td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" 
			class="BD4A"> 
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=430 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
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
