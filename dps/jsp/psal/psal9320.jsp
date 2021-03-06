<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 입금상세데이터조회
 * 작  성  일  : 2010.06.01
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9320.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.06.01 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%> 
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var strToday = '<%=Util.getToday("yyyyMMdd")%>'
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_PAY_DT_S,       "YYYYMMDD",    PK);
    initEmEdit(EM_PAY_DT_E,       "TODAY",       PK);
    
    initEmEdit(EM_PAY_DT,         "TODAY",       PK);

    initEmEdit(EM_RECV_CNT_R,     "NUMBER^7^0",  READ); 
    initEmEdit(EM_RECV_AMT_R,     "NUMBER^12^0", READ); 
    initEmEdit(EM_RTN_CNT_R,      "NUMBER^7^0",  READ); 
    initEmEdit(EM_RTN_AMT_R,      "NUMBER^12^0", READ); 
    initEmEdit(EM_DEFER_CNT_R,    "NUMBER^7^0",  READ); 
    initEmEdit(EM_DEFER_AMT_R,    "NUMBER^12^0", READ); 
    initEmEdit(EM_CLEAR_CNT_R,    "NUMBER^7^0",  READ); 
    initEmEdit(EM_CLEAR_AMT_R,    "NUMBER^12^0", READ); 
    initEmEdit(EM_TOT_CNT_R,      "NUMBER^7^0",  READ);
    initEmEdit(EM_TOT_AMT_R,      "NUMBER^12^0", READ);
    initEmEdit(EM_COMIS_AMT_R,    "NUMBER^12^0", READ);
    initEmEdit(EM_PEXPT_AMT_R,    "NUMBER^12^0", READ);
    initEmEdit(EM_JBRCH_ID_R,     "GEN^15",      READ);
    initEmEdit(EM_JBRCH_NM_R,     "GEN^40",      READ);
    initEmEdit(EM_PEXPT_DT_R,     "000000",      READ);
    initEmEdit(EM_SEND_DT_R,      "000000",      READ);
    //initEmEdit(EM_ACCNT_MIG_DT_R, "00000000",    READ);
    initEmEdit(EM_REAL_DT,        "0000/00/00",  READ);

    initComboStyle(LC_STR_CD, DS_COND_STR_CD, "CODE^0^30, NAME^0^80", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);
    initComboStyle(LC_BRCH_CD,  DS_BRCH_CD,  "CODE^0^120,NAME^0^180", 1, NORMAL);
    
    // 초기값설정
    getStore("DS_COND_STR_CD", "Y", "", "N");
    setComboData(LC_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
    
    // 매입사코드콤보 목록 가져오기 및 초기값 설정
    getBcompCode("DS_BCOMP_CD", "", "", "Y");
    setComboData(LC_BCOMP_CD,  "%"); 
    
    EM_PAY_DT_S.Text = addDate("D", "-1", EM_PAY_DT_E.Text);
    
    enableControl(IMG_REAL_DT, false);
    
    showMaster();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    //registerUsingDataset("psal9320","DS_O_MASTER");
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}      name="NO"          width=30   align=center</FC>'
    	                + '<FC>id=CHK_BOX       name=""            width=20   align=center  HeadCheckShow=true  Edit={IF(FLAG="1","true","false")} EditStyle=CheckBox  </FC>'
				    	+ '<FC>id=REC_FLAG      name="레코드구분"   width=70   align=left   edit=none SumText= "합계"</FC>'
				    	+ '<FC>id=JBRCH_ID      name="가맹점번호"   width=90   align=left   edit=none</FC> '
				    	+ '<FC>id=JBRCH_NM      name="가맹점번호명"  width=150 align=left    edit=none</FC>'
				    	+ '<G> name="접수"'
				    	+ '<FC>id=RECV_CNT      name="접수건수"     width=90   align=right  edit=none SumText=@sum</FC>'
				    	+ '<FC>id=RECV_AMT      name="접수금액"     width=110  align=right  edit=none SumText=@sum</FC>'
				    	+ '</G>'
				    	+ '<G> name="반송"'
				    	+ '<FC>id=RTN_CNT       name="반송건수"     width=90   align=right  edit=none SumText=@sum</FC>'
				    	+ '<FC>id=RTN_AMT       name="반송금액"     width=100  align=right  edit=none SumText=@sum</FC>'
				    	+ '</G>'
				    	+ '<G> name="보류"'
				    	+ '<FC>id=DEFER_CNT     name="보류건수"     width=90   align=right  edit=none SumText=@sum</FC>'
				    	+ '<FC>id=DEFER_AMT     name="보류금액"     width=100  align=right  edit=none SumText=@sum</FC>'
				    	+ '</G>'
				    	+ '<G> name="보류해제"'
				    	+ '<FC>id=CLEAR_CNT     name="보류해제건수" width=90   align=right  edit=none SumText=@sum</FC>'
				    	+ '<FC>id=CLEAR_AMT     name="보류해제금액" width=100  align=right  edit=none SumText=@sum</FC>'
				    	+ '</G>'
				    	+ '<G> name="합계"'
				    	+ '<FC>id=TOT_CNT       name="합계건수"     width=90   align=right  edit=none SumText=@sum</FC>'
                        + '<FC>id=TOT_AMT       name="합계금액"     width=110  align=right  edit=none SumText=@sum</FC>'
                        + '</G>'
                        + '<FC>id=COMIS_AMT     name="수수료"       width=100  align=right  edit=none</FC>'
                        + '<FC>id=PEXPT_DT      name="입금일자"     width=80   align=center edit=none mask="XX/XX/XX"</FC>'
                        + '<FC>id=PEXPT_AMT     name="입금액"       width=110  align=right  edit=none</FC>'                        
                        + '<FC>id=SEND_DT       name="전송일자"     width=80   align=center edit=none mask="XX/XX/XX"</FC>'
                        + '<FC>id=FILLER        name="FILLER"       width=80  align=left    show=false edit=none</FC>'
                        + '<FC>id=ACCNT_MIG_DT  name="회계기표일자"  width=115  align=center show=false edit=none mask="XXXX/XX/XX-XXXXX"</FC>'                        
                        + '<FC>id=PAY_DT        name="PAY_DT"       width=80  align=left    show=false</FC>'
                        + '<FC>id=PAY_SEQ       name="PAY_SEQ"      width=80  align=left    show=false</FC>'
                        + '<FC>id=SEQ_NO        name="SEQ_NO"       width=80  align=left    show=false</FC>'
                        + '<FC>id=STR_CD        name="STR_CD"       width=80  align=left    show=false</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
     (3) 엑셀       - btn_Excel()
 *************************************************************************/
 /**
  * btn_Search()
  * 작 성 자     : 김영진
  * 작 성 일     : 2010-06-01
  * 개       요     : 조회시 호출
  * return값 : void
  */
 function btn_Search() {
	  
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD.Focus();
	    return false;
	}
    if(trim(EM_PAY_DT_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","입금수신시작일");
        EM_PAY_DT_S.Focus();
        return;
    }
    if(trim(EM_PAY_DT_E.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","입금수신종료일");
        EM_PAY_DT_E.Focus();
        return;
    }
    if(EM_PAY_DT_S.Text > EM_PAY_DT_E.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_PAY_DT_S.Focus();
        return;
    }
     //조회
     showMaster();
 }

/**
 * btn_Save()
 * 작   성   자 : 김영진
 * 작   성   일 :2010-06-01
 * 개           요 : 회계기표일자 저장
 * return값 : void
 */
function btn_Save(){
    var intUpCnt = 0;
    // 조회 내역이 없을 경우
    if(DS_O_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
        return;
    }
    
    for(var i=1; i<=DS_O_MASTER.CountRow; i++){
        if(DS_O_MASTER.NameValue(i, "CHK_BOX") == 'T'){
        	intUpCnt++;
        }
    }
    
    if (!checkDateTypeYMD(EM_PAY_DT) && EM_PAY_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "입금처리일자"); 
        return;
    }
    
    if (!checkDateTypeYMD(EM_PAY_DT)){
        showMessage(EXCLAMATION, OK, "USER-1007", "입금처리일자"); 
        return;
    }
    
    // 저장할 데이터 없는 경우
    if (intUpCnt == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "저장할 자료를 선택하세요."); //저장할 자료를 선택하세요.
        return;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
  
    saveData();    
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 :2010-06-01
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "입금상세데이터조회";
//    openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
        openExcel5(GR_MASTER, ExcelTitle, strExlParam, true , "",g_strPid );

    GR_MASTER.Focus();
}

 /*************************************************************************
  * 3. 함수
  *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 입금상세데이터조회
 * return값 : void
 */
function showMaster(){    
	 //enableControl(IMG_APPLY_DATA, false);
    var strStrCd    = LC_STR_CD.BindColVal;
    var strPayDtS   = EM_PAY_DT_S.Text; 
    var strPayDtE   = EM_PAY_DT_E.Text;  
    var strJbrchId  = LC_BRCH_CD.BindColVal;    
    
    strExlParam = "점코드="         + strStrCd   + " : " + LC_STR_CD.Text
                + " -입금수신일자=" + strPayDtS  +  "~"  + strPayDtE
                + " -가맹점번호="   + strJbrchId;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strPayDtS="  + encodeURIComponent(strPayDtS)
                    + "&strPayDtE="  + encodeURIComponent(strPayDtE)
                    + "&strJbrchId=" + encodeURIComponent(strJbrchId);
    
    TR_MAIN.Action  ="/dps/psal932.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 CHEKCBOX헤더 체크해제
    GR_MASTER.ColumnProp('CHK_BOX','HeadCheck')= "false";
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
        
        if(trim(EM_PEXPT_DT_R.Text) != ""){
            initEmEdit(EM_PEXPT_DT_R,     "00/00/00",    READ);
        }
        if(trim(EM_SEND_DT_R.Text) != ""){
            initEmEdit(EM_SEND_DT_R,      "00/00/00",    READ);
        }
        //if(trim(EM_ACCNT_MIG_DT_R.Text) != ""){
        //    initEmEdit(EM_ACCNT_MIG_DT_R, "0000/00/00-00000",  READ);
        //}
    }else{
    	LC_STR_CD.Focus();
    }
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}
 
/**
 * recData()
 * 작 성 자     : 조형욱
 * 작 성 일     : 2010-05-23
 * 개       요     : 파일 데이타 수신 
 * return값 : void
 */
function recData(){ 
	 
	if(trim(LC_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_STR_CD.Focus();
        return false;
    }
	
	/*
    if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }*/
    //
    var strPayDt = EM_PAY_DT.Text;
    var goTo        = "recData";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_STR_CD.BindColVal)
                    + "&strPayDt="     + encodeURIComponent(strPayDt);
    TR_MAIN.Action  ="/dps/psal932.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
//    	enableControl(IMG_APPLY_DATA, false);
//        setTimeout("enableControl(IMG_APPLY_DATA, true);",60000);
    }    
}

function recData_first(){ 
	 
	if(trim(LC_STR_CD.BindColVal).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_STR_CD.Focus();
        return false;
    }
	
	/*
    if(trim(EM_COND_REQ_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자");
        EM_COND_REQ_DT.Focus();
        return;
    }*/
    //
    var strPayDt = EM_PAY_DT.Text;
    var goTo        = "recData_first";    
    var action      = "O";     
    var parameters  = "&paramStrCd="   + encodeURIComponent(LC_STR_CD.BindColVal)
                    + "&strPayDt="     + encodeURIComponent(strPayDt);
    TR_MAIN.Action  ="/dps/psal932.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
//    	enableControl(IMG_APPLY_DATA, false);
//        setTimeout("enableControl(IMG_APPLY_DATA, true);",60000);
    }    
}


/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 회계기표일자 저장
 * return값 : void
 */
function saveData(){
	var strPayDt = EM_PAY_DT.Text;
	var parameters = "&strPayDt="+encodeURIComponent(strPayDt);
    var goTo        = "saveData";
    var action      = "I";  //조회는 O, 저장은 I
    TR_MAIN.Action  ="/dps/psal932.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();
    
    showMaster();    
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-06-01
 * 개       요     : 회계기표일자 저장
 * return값 : void
 */
function applyData(){	
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD.Focus();
	    return false;
	}
	if (!checkDateTypeYMD(EM_PAY_DT) && EM_PAY_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "입금처리일자"); 
        return;
    }
    
    if (!checkDateTypeYMD(EM_PAY_DT)){
        showMessage(EXCLAMATION, OK, "USER-1007", "입금처리일자"); 
        return;
    }
    
    var strStrCd = LC_STR_CD.BindColVal;
    var strPayDt = EM_PAY_DT.Text;
	var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
		           + "&strPayDt="+encodeURIComponent(strPayDt);
    var goTo        = "saveData";
    var action      = "O";  //조회는 O, 저장은 I
    
    TR_MAIN.Action  ="/dps/psal932.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();
    
    
    //showMaster();
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript" for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_O_MASTER.CountRow; i++){
        	if(DS_O_MASTER.NameValue(i, "FLAG") != "2"){
                DS_O_MASTER.NameValue(i, "CHK_BOX") = 'T';
        	}
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_MASTER.CountRow; i++){
        	if(DS_O_MASTER.NameValue(i, "FLAG") != "2"){
                DS_O_MASTER.NameValue(i, "CHK_BOX") = 'F';
        	}
        }
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=onColumnChanged(row,colid)>
    var orgValue      = DS_O_MASTER.OrgNameValue(row,colid);
    var newValue      = DS_O_MASTER.NameValue(row,colid);
    //DS_O_MASTER.NameValue(row, "FLAG") = "1";
</script>

<!--DS_O_MASTER  OnRowPosChanged(row)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(DS_O_MASTER.NameValue(row, "ACCNT_MIG_DT") != ""){
        //initEmEdit(EM_ACCNT_MIG_DT_R, "0000/00/00-00000",  READ);
        initEmEdit(EM_REAL_DT,        "0000/00/00",  READ);
    }else{
    	//initEmEdit(EM_ACCNT_MIG_DT_R, "0000000000000",  READ);
    	initEmEdit(EM_REAL_DT,        "0000/00/00",  NORMAL);
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    if(colid == "CHK_BOX")return;
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD event=OnSelChange()>
    DS_BRCH_CD.ClearData();
    if(this.BindColVal != "%"){
        LC_BRCH_CD.Enable = true;
        getJbrchCode("DS_BRCH_CD", this.BindColVal, "N");
    }else{
        LC_BRCH_CD.Enable = false;
    }
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_PAY_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PAY_DT_S)){
        EM_PAY_DT_S.Text = addDate("D", "-1", EM_PAY_DT_E.Text);
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_PAY_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PAY_DT_E)){
    	initEmEdit(EM_PAY_DT_E,       "TODAY",       PK);
    }
</script>  
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BRCH_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>



<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
	<param name="TimeOut" value=1200000>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                              *-->
<!--*************************************************************************-->

<body onLoad="doInit();" class="PL10 PT15">

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
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점포명</th>
						<td width="310"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">입금수신일자</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_PAY_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PAY_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_PAY_DT_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_PAY_DT_E)" /></td>
					</tr>
					<tr>                       
                        <th width="80">카드매입사</th>
                        <td width="170"><comment id="_NSID_"> <object
                            id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80">가맹점번호</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=LC_BRCH_CD classid=<%=Util.CLSID_LUXECOMBO%> width=194
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
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
	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
			<tr>
					   <th width=80>입금처리일자</th>
						<td class="FS11 red"><comment id="_NSID_"> <object
							id=EM_PAY_DT classid=<%=Util.CLSID_EMEDIT%> width=110>
                            </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif"  align="absmiddle"
                            onclick="javascript:openCal('G',EM_PAY_DT)" />
                            <!--  매입VAN변경 20160301<img src="/<%=dir%>/imgs/btn/receive_pro_s.gif" onclick="recData();" align="absmiddle" />  -->
                            FRIST_DATA -> <input type="button" value="FIRSTDATA" onclick="recData_first();" />
                            <img src="/<%=dir%>/imgs/btn/apply.gif" id="IMG_APPLY_DATA"
                            onclick="applyData();" align="absmiddle" />
                              * 전송처리후 1분 후 적용 가능함. </td>   
					<!--  					   	
					   <td align=right colspan="6">* 회계기표일자는 실입금일자로 처리함.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					   </td>-->
					   
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td class="dot"></td>
	</tr>

	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=314 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width=80>접수건수</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_RECV_CNT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">접수금액</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_RECV_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">반송건수</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_RTN_CNT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script>
						<th width="80">반송금액</th>
						<td><comment id="_NSID_"> <object id=EM_RTN_AMT_R
							classid=<%=Util.CLSID_EMEDIT%> width=110> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width=80>지급보류건수</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_DEFER_CNT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">지급보류금액</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_DEFER_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">지급보류해제건수</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_CLEAR_CNT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script>
						<th width="80">지급보류해제금액</th>
						<td><comment id="_NSID_"> <object id=EM_CLEAR_AMT_R
							classid=<%=Util.CLSID_EMEDIT%> width=110> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width=80>합계건수</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_TOT_CNT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">합계금액</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_TOT_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">수수료</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_COMIS_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script>
						<th width="80">가맹점번호</th>
						<td><comment id="_NSID_"> <object id=EM_JBRCH_ID_R
							classid=<%=Util.CLSID_EMEDIT%> width=110> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width=80>입금일자</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_PEXPT_DT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">입금액</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_PEXPT_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">전송일자</th>
						<td width="110"><comment id="_NSID_"> <object
							id=EM_SEND_DT_R classid=<%=Util.CLSID_EMEDIT%> width=110>
						</object> </comment> <script> _ws_(_NSID_);</script>
						<!--  
						<th width="80">회계기표일자</th>
						<td><comment id="_NSID_"> <object id=EM_ACCNT_MIG_DT_R
							classid=<%=Util.CLSID_EMEDIT%> width=110> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>-->
					</tr>
					<tr>
						<th width=80>가맹점번호명</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_JBRCH_NM_R classid=<%=Util.CLSID_EMEDIT%> width=200>
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">실입금일자</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_REAL_DT classid=<%=Util.CLSID_EMEDIT%> width=90>
                        </object> </comment> <script> _ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" id="IMG_REAL_DT" align="absmiddle"
                            onclick="javascript:openCal('G',EM_REAL_DT)" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=RECV_CNT        ctrl=EM_RECV_CNT_R      Param=Text</c>
            <c>col=RECV_AMT        ctrl=EM_RECV_AMT_R      Param=Text</c>
            <c>col=RTN_CNT         ctrl=EM_RTN_CNT_R       Param=Text</c>
            <c>col=RTN_AMT         ctrl=EM_RTN_AMT_R       Param=Text</c>
            <c>col=DEFER_CNT       ctrl=EM_DEFER_CNT_R     Param=Text</c>
            <c>col=DEFER_AMT       ctrl=EM_DEFER_AMT_R     Param=Text</c>
            <c>col=CLEAR_CNT       ctrl=EM_CLEAR_CNT_R     Param=Text</c>
            <c>col=CLEAR_AMT       ctrl=EM_CLEAR_AMT_R     Param=Text</c>
            <c>col=TOT_CNT         ctrl=EM_TOT_CNT_R       Param=Text</c>
            <c>col=TOT_AMT         ctrl=EM_TOT_AMT_R       Param=Text</c>
            <c>col=COMIS_AMT       ctrl=EM_COMIS_AMT_R     Param=Text</c>
            <c>col=PEXPT_DT        ctrl=EM_PEXPT_DT_R      Param=Text</c>
            <c>col=PEXPT_AMT       ctrl=EM_PEXPT_AMT_R     Param=Text</c>
            <c>col=JBRCH_ID        ctrl=EM_JBRCH_ID_R      Param=Text</c>
            <c>col=SEND_DT         ctrl=EM_SEND_DT_R       Param=Text</c>            
            <c>col=JBRCH_NM        ctrl=EM_JBRCH_NM_R      Param=Text</c>
            <c>col=REAL_DT         ctrl=EM_REAL_DT         Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

