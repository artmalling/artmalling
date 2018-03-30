<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 승인처리 > 포인트 강제적립차감승인
 * 작  성  일  : 2010.03.08
 * 작  성  자  : 장형욱
 * 수  정  자  : 
 * 파  일  명  : dmbo6130.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (장형욱) 신규작성 
 *           2010.05.04 (김영진) 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<% 
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strToMonth = strToMonth + "01";
    String toDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var bfListRowPosition = 0;                             // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-08
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
 
	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
	
	// Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');	 
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
	
    //그리드 초기화
    gridCreate1(); //마스터
    
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();  
    
    //검색조건
    /*
    if ("B" == GET_USER_AUTH_VALUE) {
    	initEmEdit(EM_BRCH_CD_S,    "GEN^10", READ);       //가맹점코드
        enableControl(IMG_BRCH,     false);
    } else {
    	initEmEdit(EM_BRCH_CD_S,    "GEN^10", NORMAL);       //가맹점코드
        enableControl(IMG_BRCH,     true); 
    }
    */
    initEmEdit(EM_BRCH_CD_S,    "GEN^10", PK);       //가맹점코드
    
    //-- 검색필드
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);           //시작일
    initEmEdit(EM_E_DT_S,       "YYYYMMDD", PK);           //종료일    
  
    initEmEdit(EM_BRCH_NAME_S,    "GEN^40", READ);         //가맹점명    
    
    //-- 입력필드
    initEmEdit(EM_BRCH_NAME,     "GEN^40",       READ);  //가맹점명
    initEmEdit(EM_PROC_DT,       "YYYYMMDD",     READ);  //처리일자    
    initEmEdit(EM_CUST_NAME,     "GEN^40",       READ);  //회원명
    initEmEdit(EM_PROC_NAME,     "GEN^40",       READ);  //처리구분
    initEmEdit(EM_POINT,         "NUMBER^9^0",   READ);  //적립/차감금액
    initEmEdit(EM_REASON_NM,     "GEN^40",       READ);  //적립/차감 사유유형    

    initEmEdit(TXA_REMARK,       "GEN^100",      READ);
    
    
    //default ;
    EM_BRCH_CD_S.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />'; //소속가맹점 
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_CD_S.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_CD_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }
    
    //조회일자 초기값.
    EM_S_DT_S.text =  <%=toDate%>;
    EM_E_DT_S.text =  <%=toDate%>;
    
    //btn_Search();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmbo613","DS_IO_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width="30"   align=center  </FC>'
                     + '<C>id=SAVE_CHK      name="선택"        width="40"   align=center  EditStyle=CheckBox  Edit={IF(FLAG="1","true","false")} HeadCheckShow=true </C>'
                     + '<FC>id=BRCH_NAME    name="가맹점명"     width="90"   align=left    Edit=none</FC>'
                     + '<FC>id=PROC_DT      name="처리일자"     width="80"   align=center  Edit=none  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CUST_NAME    name="회원명"       width="60"  align=left   Edit=none</FC>'
                     + '<FC>id=PROC_NAME    name="구분"        width="70"   align=center    Edit=none </FC>'
                     + '<FC>id=TOT_POINT    name="누적포인트"    width="85"   align=right   Edit=none</FC>'
                     + '<FC>id=POINT        name="적립/차감금액" width="85"   align=right   Edit=none</FC>'
                     + '<FC>id=REASON_NM    name="사유유형"     width="100"   align=left    Edit=none</FC>'
                     + '<FC>id=REMARK       name="상세사유"     width="300"  align=left    Edit=none </FC>'
                     + '<FC>id=CONF_DATE    name="승인일자"     width="80"   align=center  Edit=none  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=FLAG         name="승인여부"     width="80"   align=center  show=false</FC>'
                     + '<FC>id=CONF_NAME    name="승인자"       width="60"   align=center  Edit=none</FC>'
                     
                     + '<FC>id=BRCH_ID      name="hidden"       width="80"  align=left   show=false</FC>'
                     + '<FC>id=SEQ_NO       name="hidden"       width="80"  align=left   show=false</FC>'
                     + '<FC>id=REASON_CD    name="hidden"       width="80"  align=left   show=false</FC>'
                     + '<FC>id=CARD_NO      name="hidden"       width="80"  align=left   show=false</FC>'
                     + '<FC>id=PROC_FLAG    name="hidden"       width="80"  align=left   show=false</FC>'
                     + '<FC>id=CONF_ID      name="hidden"       width="80"  align=left   show=false</FC>'
                     + '<FC>id=CUST_ID      name="hidden"       width="80"  align=left   show=false</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
    var strSdt          = EM_S_DT_S.text;
    var strEdt          = EM_E_DT_S.text;
    var strBrch_cd      = EM_BRCH_CD_S.text;
    var str_search_type = RD_SEARCH_TYPE.CodeValue;
       
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    } else if (trim(EM_BRCH_CD_S.text).length != 10){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점");
        EM_BRCH_CD_S.Focus();
        return;
    }     
    
    if (eval(strSdt) > eval(strEdt) ) {
        showMessage(EXCLAMATION, OK, "USER-1015",  "종료일자");
        EM_E_DT_S.Focus();
        return;     
    }    
    bfListRowPosition = 0;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="          + encodeURIComponent(strSdt)
                    + "&strEdt="          + encodeURIComponent(strEdt)
                    + "&strBrch_cd="      + encodeURIComponent(strBrch_cd)
                    + "&str_search_type=" + encodeURIComponent(str_search_type);
    TR_MAIN.Action  = "/dcs/dmbo613.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();      	 
    
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    if (DS_IO_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
        EM_S_DT_S.Focus();
    }    
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    var intRowStatus = 1;
    var intUpCnt     = 0;
    var intFlagCnt   = 0;
    //DS Row 상태 초기화
    DS_IO_MASTER.ResetStatus();
    
    // 조회 내역이 없을 경우
    if(DS_IO_MASTER.CountRow < 0){
         showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
         return;
    }else{
    	//조회 내용이 전체 승인일 경우 저장할 내용 없음 메세지 처리
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if(DS_IO_MASTER.NameValue(i, "SAVE_CHK") != 'T'){
                var strRealFlag = DS_IO_MASTER.NameValue(i, "FLAG");   
                if(strRealFlag == 2){
                    intFlagCnt++; 
                }

            }
        }
        if(intFlagCnt == DS_IO_MASTER.CountRow){
            showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
            return;
        }
        
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){             
            if(DS_IO_MASTER.NameValue(i, "SAVE_CHK") == 'T'){
                intUpCnt++; 
                DS_IO_MASTER.UserStatus(i) = intRowStatus;                
                var brch_id   = DS_IO_MASTER.NameValue(i, "BRCH_ID");
                var card_no   = DS_IO_MASTER.NameValue(i, "CARD_NO");
                var proc_flag = DS_IO_MASTER.NameValue(i, "PROC_FLAG");
                var tot_point = DS_IO_MASTER.NameValue(i, "TOT_POINT");
                var point     = DS_IO_MASTER.NameValue(i, "POINT");
                var reason_cd = DS_IO_MASTER.NameValue(i, "REASON_CD");
                var remark    = DS_IO_MASTER.NameValue(i, "REMARK");
                
                if (parseInt(point) <= 0) {
                    showMessage(EXCLAMATION, OK, "USER-1008", "적립/차감금액","0");
                    return;
                }
                
                if (proc_flag == "U" && (parseInt(point) > parseInt(tot_point))) {
                	showMessage(StopSign, OK, "USER-1021", "차감포인트","누적포인트");
                	return;
                }
            }else{
                DS_IO_MASTER.UserStatus(i) = 0;
            }
        }
    }
    // 저장할 데이터 없는 경우
    if (intUpCnt <= 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "저장할 자료를 선택하세요."); 
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }       
    
    var goTo        = "saveData";
    var action      = "I";  //조회는 O
    TR_MAIN.Action  ="/dcs/dmbo613.do?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();  	

    btn_Search();
}
 
function btn_New() {
	doInit();
	
	DS_IO_DETAIL.ClearData();
	RD_SEARCH_TYPE.CodeValue = "0";
    
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * doOnClick()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-09
 * 개       요 : 포인트 강제처리요청 상세 조회 
 * return값 : void
 */
function doClick(row){
     
    if( row == undefined ) 
        row = DS_IO_MASTER.RowPosition;
     
    var strProcDt   = DS_IO_MASTER.NameValue(row ,"PROC_DT");
    var strBrchId   = DS_IO_MASTER.NameValue(row ,"BRCH_ID");
    var strCardNo   = DS_IO_MASTER.NameValue(row ,"CARD_NO");
    var strSeqNo    = DS_IO_MASTER.NameValue(row ,"SEQ_NO");
    
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strProcDt=" + encodeURIComponent(strProcDt)
                    + "&strBrchId=" + encodeURIComponent(strBrchId)
                    + "&strCardNo=" + encodeURIComponent(strCardNo)
                    + "&strSeqNo="  + encodeURIComponent(strSeqNo);
    
    
    //alert(strCardNo);
    TR_DETAIL.Action  =  "/dcs/dmbo613.do?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();      

    EM_BRCH_NAME.Text   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"BRCH_NAME");
    EM_PROC_DT.Text     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"PROC_DT");
    EM_CUST_NAME.Text   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"CUST_NAME");         
    EM_PROC_NAME.Text   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"PROC_NAME");     
    EM_POINT.Text       = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"POINT");      
    EM_REASON_NM.Text   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition ,"REASON_NM");  
    
} 

/**
 * keyPressEvent()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010.02.24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME_S.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_CD_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_CD_S.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_CD_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
            	EM_BRCH_CD_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_CD_S,EM_BRCH_NAME_S);
            }
        }
    }
}
 
 function clickGridHeadCheck( dataSet, value){
	 
		GD_MASTER.ReDraw = false;
		var j = dataSet.CountRow;
		
		if(j > 50000) {
			j = 50000;
		} else {
			j = dataSet.CountRow;
		}
		for( var i=1; i<=j; i++){
			if(DS_IO_MASTER.NameValue(i,"FLAG")=="1") {
				dataSet.NameValue(i,"SAVE_CHK") = value==1?"T":"F";
			}
		}
		GD_MASTER.ReDraw = true;
	}

	
 
 
-->
 -->
 
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
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_IO_MASTER,bCheck);
	
</script>
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row); 
    }else{
        DS_IO_DETAIL.ClearData();
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
	    EM_E_DT_S.text = <%=toDate%>;
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
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
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
<!--* E. 본문시작                                                                                                                                                               *-->
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
						<th width="60" class="point">조회기간</th>
						<td width="195"><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
						<th width="60">가맹점</th> 
						<td width="205"><comment id="_NSID_"> <object
							id=EM_BRCH_CD_S classid=<%=Util.CLSID_EMEDIT%> width=75
							tabindex=1 onKillFocus="javascript:onKillFocus()"
							onKeyUp="javascript:keyPressEvent(event.keyCode);"></object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" id="IMG_BRCH"
							onclick="getBrchPop(EM_BRCH_CD_S, EM_BRCH_NAME_S)" /> <comment
							id="_NSID_"> <object id=EM_BRCH_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="60">조회구분</th>
						<td><comment id="_NSID_"> <object id=RD_SEARCH_TYPE
							classid=<%= Util.CLSID_RADIO %> style="height: 20; width: 150"
							tabindex=1>
							<param name=Cols value="3">
							<param name=Format value="0^전체,2^승인,1^미승인">
							<param name=CodeValue value="0">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
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
				<td><object id=GD_MASTER width="100%" height=398
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_MASTER">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="100">가맹점명</th>
						<td width="100"><comment id="_NSID_"> <object
							id=EM_BRCH_NAME classid=<%=Util.CLSID_EMEDIT%> width=90
							tabindex=1></object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="100">처리일자</th>
						<td width="100"><comment id="_NSID_"> <object
							id=EM_PROC_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="100">회원명</th>
						<td><comment id="_NSID_"> <object id=EM_CUST_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="100">처리구분</th>
						<td><comment id="_NSID_"> <object id=EM_PROC_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1></object> </comment><script> _ws_(_NSID_);</script>
						</td>
						<th width="100">적립/차감금액</th>
						<td><comment id="_NSID_"> <object id=EM_POINT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1></object> </comment><script> _ws_(_NSID_);</script>
						</td>
						<th width="120">적립/차감 사유유형</th>
						<td><comment id="_NSID_"> <object id=EM_REASON_NM
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1></object> </comment><script> _ws_(_NSID_);</script>
						</td>
					</tr>
                    <tr>
                        <th width="100">상세사유</th>
                        <td colspan="5"><comment id="_NSID_"> <object
                            id=TXA_REMARK classid=<%=Util.CLSID_TEXTAREA%> style="width: 100%; height: 45px;"  tabindex=1></object>
                        </comment><script> _ws_(_NSID_);</script></td>
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
<object id=BD_HEADER classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
                                       <c>col=BRCH_NAME   ctrl=EM_BRCH_NAME     Param=Text</c>
                                       <c>col=PROC_DT     ctrl=EM_PROC_DT       Param=Text</c>
                                       <c>col=CUST_NAME   ctrl=EM_CUST_NAME     Param=Text</c>
                                       <c>col=PROC_NAME   ctrl=EM_PROC_NAME     Param=Text</c>
                                       <c>col=POINT       ctrl=EM_POINT         Param=Text</c>
                                       <c>col=REASON_NM   ctrl=EM_REASON_NM     Param=Text</c>            
                                       <c>col=REMARK      ctrl=TXA_REMARK       Param=Text</c>
                                      '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
