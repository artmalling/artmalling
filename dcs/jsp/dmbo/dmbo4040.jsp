<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 승인처리 > 전자쿠폰발급
 * 작  성  일  : 2010.03.08
 * 작  성  자  : 장형욱
 * 수  정  자  : 
 * 파  일  명  : dmbo4040.jsp
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
    /*
    //-- 입력필드
    initEmEdit(EM_BRCH_NAME,     "GEN^40",       READ);  //가맹점명
    initEmEdit(EM_PROC_DT,       "YYYYMMDD",     READ);  //처리일자    
    initEmEdit(EM_CUST_NAME,     "GEN^40",       READ);  //회원명
    initEmEdit(EM_PROC_NAME,     "GEN^40",       READ);  //처리구분
    initEmEdit(EM_POINT,         "NUMBER^9^0",   READ);  //적립/차감금액
    initEmEdit(EM_REASON_NM,     "GEN^40",       READ);  //적립/차감 사유유형    

    initEmEdit(TXA_REMARK,       "GEN^100",      READ);
    */
    
    initComboStyle(LC_S_STR_CD, DS_O_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_S_JEHU_ONLY_YN, DS_O_S_JEHU_ONLY_YN, "CODE^0^20,NAME^0^100", 1, NORMAL);

    //-- 검색필드
    initEmEdit(EM_S_DT_S,       "YYYYMMDD", PK);           //시작일
    initEmEdit(EM_E_DT_S,       "YYYYMMDD", PK);           //종료일    
  
    //initEmEdit(EM_BRCH_NAME_S,    "GEN^40", READ);         //가맹점명    
    
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드    
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    
    initComboStyle(LC_CUST_GRADE    , DS_O_CUST_GRADE    , "CODE^0^30,NAME^0^80", 1, NORMAL);   //회원등급
    initComboStyle(LC_POCARD_PREFIX , DS_O_POCARD_PREFIX , "CODE^0^30,NAME^0^80", 1, NORMAL);   //패밀리카드구분
    initComboStyle(LC_STR_CD        , DS_O_STR_CD        , "CODE^0^30,NAME^0^110", 1, NORMAL);   //점코드
    initComboStyle(LC_APP_FLAG      , DS_O_APP_FLAG      , "CODE^0^30,NAME^0^80", 1, NORMAL);   //적용방법
    initComboStyle(LC_JEHU_ONLY_YN  , DS_O_JEHU_ONLY_YN  , "CODE^0^30,NAME^0^80", 1, READ);   //제휴카드ONLY여부
    initComboStyle(LC_CPN_TYPE      , DS_O_CPN_TYPE      , "CODE^0^30,NAME^0^110", 1, NORMAL);   //전자쿠폰종류
    
    initEmEdit(EM_ISSUE_CNT,   "NUMBER^9^0",  NORMAL);  //발행매수
    initEmEdit(EM_CUST_ID,     "GEN^9",       NORMAL);  //회원ID
    initEmEdit(EM_CUST_NAME,   "GEN^40",      READ);    //회원명
    initEmEdit(EM_DC_RATE,     "NUMBER^9^0",  NORMAL);  //DC율
    initEmEdit(EM_DC_AMT,      "NUMBER^9^0",  NORMAL);  //금액
    initEmEdit(EM_S_DT,        "YYYYMMDD",    NORMAL);  //적용시작일
    initEmEdit(EM_E_DT,        "YYYYMMDD",    NORMAL);  //적용종료일
    
    //조회용
    getStore("DS_O_S_STR_CD", "Y", "", "N");
    getEtcCode("DS_O_S_JEHU_ONLY_YN",  "D", "D022", "Y");
    
    //입력용
    getEtcCode("DS_O_CUST_GRADE",   "D", "D011", "Y");
    getEtcCode("DS_O_POCARD_PREFIX",  "D", "D104", "Y");
    getStore("DS_O_STR_CD", "Y", "", "N");    
    getEtcCode("DS_O_APP_FLAG",      "D", "D112", "N");
    getEtcCode("DS_O_JEHU_ONLY_YN",  "D", "D022", "N");
    getEtcCode("DS_O_CPN_TYPE",      "D", "D110", "N");
    
    //
    getStore("DS_I_STR_CD", "Y", "", "N");    
    getEtcCode("DS_I_APP_FLAG",      "D", "D112", "N");
    getEtcCode("DS_I_JEHU_ONLY_YN",  "D", "D022", "N");
    getEtcCode("DS_I_CPN_TYPE",      "D", "D110", "N");
    getEtcCode("DS_I_ISSUE_PATH",    "D", "D111", "N");
        
    LC_S_STR_CD.Index = 0;
    LC_S_JEHU_ONLY_YN.Index = 0;
    
    indexSetting("Search");
    
    //조회일자 초기값.
    //EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    //EM_E_DT_S.text =  <%=toDate%>;
    
    //btn_Search();
    
    //enableControl(IMG_ADD, false);
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmbo404","DS_IO_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"              width="30"   align=center  </FC>'
                     + '<FC>id=STR_CD       name="점코드"           width="140"   align=center  Edit=none  EDITSTYLE=LOOKUP    DATA="DS_I_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=CUST_ID      name="회원ID"           width="80"   align=center    Edit=none</FC>'
                     + '<FC>id=CUST_NAME    name="회원명"           width="50"   align=left     Edit=none</FC>'
                     + '<FC>id=CPN_ID       name="쿠폰ID"           width="90"   align=left     Edit=none  show=false</FC>'
                     + '<FC>id=CPN_NM       name="쿠폰이름"         width="120"   align=left   Edit=true  </FC>'
                     + '<FC>id=APP_FLAG     name="적용방법"         width="60"   align=center   Edit=true  EDITSTYLE=LOOKUP    DATA="DS_I_APP_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=DC_RATE      name="DC율"             width="70"   align=right   Edit={IF(APP_FLAG="R","true","false")}</FC>'
                     + '<FC>id=DC_AMT       name="금액"             width="85"   align=right   Edit={IF(APP_FLAG="P","true","false")}</FC>'
                     + '<FC>id=START_DT     name="*적용시작일"       width="90"   align=center   Edit=true  EditStyle=Popup</FC>'
                     + '<FC>id=END_DT       name="*적용종료일"       width="90"   align=center  Edit=true   EditStyle=Popup</FC>'
                     + '<FC>id=JEHU_ONLY_YN name="제휴카드여부"     width="80"   align=center   Edit=None  EDITSTYLE=LOOKUP    DATA="DS_I_JEHU_ONLY_YN:CODE:NAME"</FC>'
                     + '<FC>id=CPN_TYPE     name="전자쿠폰종류"     width="130"   align=center   Edit=true  EDITSTYLE=LOOKUP    DATA="DS_I_CPN_TYPE:CODE:NAME"</FC>'
                     + '<FC>id=ISSUE_PATH   name="발급경로"         width="100"   align=center   Edit=none  EDITSTYLE=LOOKUP    DATA="DS_I_ISSUE_PATH:CODE:NAME"</FC>';                     
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
	 if (DS_IO_DETAIL.IsUpdated ) {
	        ret = showMessage(QUESTION, YESNO, "USER-1084");
	        if (ret != "1") {
	            return false;
	        } 
	    }
	DS_IO_DETAIL.ClearData();
	indexSetting("Search");
	
	var strJehuOnlyYn   = LC_S_JEHU_ONLY_YN.BindColVal;
	var strCustId       = EM_CUST_ID_S.text;
    var strSdt          = EM_S_DT_S.text;
    var strEdt          = EM_E_DT_S.text;
    var strStrCd        = LC_S_STR_CD.BindColVal;
     
    /*
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    } */    
    
    if (eval(strSdt) > eval(strEdt) ) {
        showMessage(EXCLAMATION, OK, "USER-1015",  "종료일자");
        EM_E_DT_S.Focus();
        return;     
    }    
    bfListRowPosition = 0;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strCustId="       + encodeURIComponent(strCustId)
    				+ "&strSdt="          + encodeURIComponent(strSdt)
                    + "&strEdt="          + encodeURIComponent(strEdt)
                    + "&strStrCd="        + encodeURIComponent(strStrCd)
                    + "&strJehuOnlyYn="   + encodeURIComponent(strJehuOnlyYn);
    TR_MAIN.Action  = "/dcs/dmbo404.do?goTo="+goTo+parameters;  
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
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_New() {
	 if (DS_IO_DETAIL.IsUpdated ) {
	        ret = showMessage(QUESTION, YESNO, "USER-1085");
	        if (ret != "1") {
	            return false;
	        } 
	    }
	 
	 DS_IO_DETAIL.ClearData();
	 DS_IO_DETAIL.AddRow();
	 
	 indexSetting("New");
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028"); 
        return;
    }
    
	if(!chkGridValidation()){
		return;
	}
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
        return;
    
    var goTo        = "save";
    var action      = "I";  //조회는 O
    TR_MAIN.Action  ="/dcs/dmbo404.do?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();  	

    btn_Search();
}
 
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * btn_Save()
  * 작 성 자 : 장형욱
  * 작 성 일 : 2010-03-08
  * 개    요 : DB에 저장 / 수정 / 삭제 처리
  * return값 : void
  */
 function btn_AddSave() {
 	// 저장할 데이터 없는 경우
     if (!DS_IO_DETAIL.IsUpdated){
         //저장할 내용이 없습니다
         showMessage(INFORMATION , OK, "USER-1028"); 
         return;
     }
 	if(!chkValidation())
 		return;
     
     //변경또는 신규 내용을 저장하시겠습니까?
     if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
         return;
     
     var goTo        = "saveIssue";
     var action      = "I";  //조회는 O
     TR_MAIN.Action  ="/dcs/dmbo404.do?goTo="+goTo;   
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
     TR_MAIN.Post();  	

  // 정상 처리일 경우 조회
     if( TR_MAIN.ErrorCode == 0){
         btn_Search();        
     }
 }
 
/**
 * chkValidation()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-09
 * 개       요 : 신규등록시 validation
 * return값 : void
 */
function chkValidation(){
     if(LC_STR_CD.BindColVal == ""){
    	 showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
    	 LC_STR_CD.Focus();
    	 return false;
     }
     if(EM_ISSUE_CNT.Text == "" || EM_ISSUE_CNT.Text <= 0){
    	 showMessage(EXCLAMATION, OK, "USER-1003",  "발급매수");
    	 EM_ISSUE_CNT.Focus();
    	 return false;
     }
     if(LC_APP_FLAG.BindColVal == "R"){
    	 if(EM_DC_RATE.Text == null || EM_DC_RATE.Text <= 0){
    		 showMessage(EXCLAMATION, OK, "USER-1003",  "DC율");
    		 EM_DC_RATE.Focus();
        	 return false;
    	 }
     }else if(LC_APP_FLAG.BindColVal == "P"){
    	 if(EM_DC_AMT.Text == null || EM_DC_AMT.Text <= 0){
    		 showMessage(EXCLAMATION, OK, "USER-1003",  "금액");
    		 EM_DC_AMT.Focus();
        	 return false;
    	 }     
     }
     if(LC_CPN_TYPE.BindColVal == ""){
    	 showMessage(EXCLAMATION, OK, "USER-1003",  "전자쿠폰종류");
    	 LC_CPN_TYPE.Focus();
    	 return false;
     }
     
     if (trim(EM_S_DT.text).length == 0){
         showMessage(EXCLAMATION, OK, "USER-1003",  "적용시작일");
         EM_S_DT.Focus();
         return false;
     } else if (trim(EM_E_DT.text).length == 0){
         showMessage(EXCLAMATION, OK, "USER-1003",  "적용종료일");
         EM_E_DT.Focus();
         return false;
     }     
     var strSdt = EM_S_DT.text;
     var strEdt = EM_E_DT.text;     
     if (eval(strSdt) > eval(strEdt) ) {
         showMessage(EXCLAMATION, OK, "USER-1015",  "적용종료일");
         EM_E_DT.Focus();
         return false;     
     }
    return true;
} 

/**
 * chkGridValidation()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-09
 * 개       요 : 그리드 수정시 validation
 * return값 : void
 */
function chkGridValidation(){
     
     for(var i=1; i <= DS_IO_MASTER.CountRow; i++){
    	
    	 if(DS_IO_MASTER.RowStatus(i) == "3"){
    		 if(DS_IO_MASTER.NameValue(i, "STR_CD") == ""){
    	    	 showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
    	    	 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"STR_CD");
    	    	 return false;
    	     }
    		 if(DS_IO_MASTER.NameValue(i, "CPN_NM") == ""){
    	    	 showMessage(EXCLAMATION, OK, "USER-1003",  "쿠폰명");
    	    	 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CPN_NM");
    	    	 return false;
    	     }
    		 if(DS_IO_MASTER.NameValue(i, "APP_FLAG") == ""){
    	    	 showMessage(EXCLAMATION, OK, "USER-1003",  "적용방법");
    	    	 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"APP_FLAG");
    	    	 return false;
    	     }
    	     if(DS_IO_MASTER.NameValue(i, "APP_FLAG") == "R"){
    	    	 if(DS_IO_MASTER.NameValue(i, "DC_RATE") == "" || DS_IO_MASTER.NameValue(i, "DC_RATE") <= 0){
    	    		 showMessage(EXCLAMATION, OK, "USER-1003",  "DC율");
    	    		 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"DC_RATE");
    	        	 return false;
    	    	 }
    	     }else if(DS_IO_MASTER.NameValue(i, "APP_FLAG") == "P"){
    	    	 if(DS_IO_MASTER.NameValue(i, "DC_AMT") == "" || DS_IO_MASTER.NameValue(i, "DC_AMT") <= 0){
    	    		 showMessage(EXCLAMATION, OK, "USER-1003",  "금액");
    	    		 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"DC_AMT");
    	        	 return false;
    	    	 }     
    	     }
    	     if(DS_IO_MASTER.NameValue(i, "CPN_TYPE") == ""){
    	    	 showMessage(EXCLAMATION, OK, "USER-1003",  "전자쿠폰종류");
    	    	 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CPN_TYPE");
    	    	 return false;
    	     }
    	     
    	     if (DS_IO_MASTER.NameValue(i, "START_DT") == ""){
    	         showMessage(EXCLAMATION, OK, "USER-1003",  "적용시작일");
    	         setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"START_DT");
    	         return false;
    	     } else if (DS_IO_MASTER.NameValue(i, "ENT_DT") == ""){
    	         showMessage(EXCLAMATION, OK, "USER-1003",  "적용종료일");
    	         setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"ENT_DT");
    	         return false;
    	     }       
    	     if (DS_IO_MASTER.NameValue(i, "START_DT") > DS_IO_MASTER.NameValue(i, "ENT_DT") ) {
    	         showMessage(EXCLAMATION, OK, "USER-1015",  "적용종료일");
    	         setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"ENT_DT");
    	         return false;     
    	     }
    	 }
     }
    return true;
} 

/**
 * keyPressEvent()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010.02.24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function indexSetting(flag) {
	 LC_CUST_GRADE.Index = 0; 
	 LC_POCARD_PREFIX.Index = 0; 
	 LC_STR_CD.Index = 0; 
	 LC_APP_FLAG.Index = 0; 
	 //LC_JEHU_ONLY_YN.Index = 0; 
	 LC_CPN_TYPE.Index = 0;
	 EM_CUST_NAME.Text = "";
	 
	//일자 초기값.
	 EM_S_DT.text =  <%=toDate%>;
	 EM_E_DT.text =  <%=toDate%>;
	 
	 if(flag == "Search"){
		 enableControl(LC_CUST_GRADE, false);
		 enableControl(LC_POCARD_PREFIX, false);
		 enableControl(LC_STR_CD, false);
		 enableControl(LC_APP_FLAG, false);
		 enableControl(LC_CPN_TYPE, false);
		 enableControl(EM_ISSUE_CNT, false);
		 enableControl(EM_CUST_ID, false);
		 enableControl(EM_DC_RATE, false);
		 enableControl(EM_DC_AMT, false);
		 enableControl(EM_S_DT, false);
		 enableControl(EM_E_DT, false);
		 enableControl(IMG_ADD, false);
		 enableControl(IMG_CUST, false);
		 enableControl(IMG_S_DT, false);
		 enableControl(IMG_E_DT, false);
		 
	 }else if(flag == "New"){
		 enableControl(LC_CUST_GRADE, true);
		 enableControl(LC_POCARD_PREFIX, true);
		 enableControl(LC_STR_CD, true);
		 enableControl(LC_APP_FLAG, true);
		 enableControl(LC_CPN_TYPE, true);
		 enableControl(EM_ISSUE_CNT, true);
		 enableControl(EM_CUST_ID, true);
		 if(LC_CPN_TYPE.BindColVal == "R"){
			 enableControl(EM_DC_RATE, true);
		 }else if(LC_CPN_TYPE.BindColVal == "P"){
			 enableControl(EM_DC_AMT, true);
		 }
		 enableControl(EM_S_DT, true);
		 enableControl(EM_E_DT, true);
		 enableControl(IMG_ADD, true);
		 enableControl(IMG_CUST, true);
		 enableControl(IMG_S_DT, true);
		 enableControl(IMG_E_DT, true);
	 }
	 
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
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) {
    case "START_DT":
    case "END_DT":
        openCal(GD_MASTER, row, colid, "G");   //그리드 달력    
        break;	
} 
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	if(row < 0)
		return;
	
	switch(colid){
  	  case "START_DT":
		  if(!checkDateTypeYMD(GD_MASTER,colid,'')){
			  this.NameValue(row, colid) = this.OrgNameValue(row, colid);
			  setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"START_DT");
			  return false;  
		  }
    	  if(this.NameValue(row, "END_DT") != ""){
    		  if(this.NameValue(row, colid) > this.NameValue(row, "END_DT")){
    			  showMessage(EXCLAMATION, OK, "USER-1015",  "적용종료일");
    			  this.NameValue(row, colid) = this.OrgNameValue(row, colid);
    			  setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"START_DT");
    			  return false;
    		  }
    	  }	
		  
		  break;
      case "END_DT":
    	  if(!checkDateTypeYMD(GD_MASTER,colid,'')){
    		  this.NameValue(row, colid) = this.OrgNameValue(row, colid);
    		  setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"ENT_DT");
    		  return false;
    	  }
    	      
    	  
    	  if(this.NameValue(row, "START_DT") > this.NameValue(row, colid)){
    		  showMessage(EXCLAMATION, OK, "USER-1015",  "적용종료일");
			  this.NameValue(row, colid) = this.OrgNameValue(row, colid);
			  setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"ENT_DT");
			  return false;
		  }
    	  break;
      case "CPN_TYPE":
    	  if(this.NameValue(row, colid) == "02"){
    		  this.NameValue(row, "JEHU_ONLY_YN") = "Y";    		  
    	  }else{
    		  this.NameValue(row, "JEHU_ONLY_YN") = "N";
    	  }
	}
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 회원ID 조회용 onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
    } 
</script>

<!-- 회원ID 입력용 onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID event=onKillFocus()>
    if ((EM_CUST_ID.Modified) && (EM_CUST_ID.Text.length != 9)) {
        EM_CUST_NAME.Text = ""; 
    } 
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        //EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    	EM_S_DT_S.text = "";
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
	    //EM_E_DT_S.text = <%=toDate%>;
	    EM_E_DT_S.text = "";
	}
</script> 

<!-- 입력 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT)){
        //EM_S_DT_S.text = addDate("M", "-1", '<%=strToMonth%>');
    	EM_S_DT.text = "";
    }
</script>
    
<!-- 입력 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT)){
	    //EM_E_DT_S.text = <%=toDate%>;
	    EM_E_DT.text = "";
	}
</script> 

<script language=JavaScript for=LC_APP_FLAG event=OnSelChange()>      
      if(LC_APP_FLAG.BindColVal == "R"){
    	  enableControl(EM_DC_RATE, true);
    	  enableControl(EM_DC_AMT, false);
      }else if(LC_APP_FLAG.BindColVal == "P"){
    	  enableControl(EM_DC_RATE, false);
    	  enableControl(EM_DC_AMT, true);
      }
</script>

<script language=JavaScript for=LC_CPN_TYPE event=OnSelChange()>      
      if(LC_CPN_TYPE.BindColVal == "01"){
    	  LC_JEHU_ONLY_YN.BindColVal = "N";
      }else if(LC_CPN_TYPE.BindColVal == "02"){
    	  LC_JEHU_ONLY_YN.BindColVal = "Y";
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


<comment id="_NSID_">
<object id="DS_O_S_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_S_JEHU_ONLY_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POCARD_PREFIX" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_APP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_JEHU_ONLY_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CPN_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_APP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_JEHU_ONLY_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CPN_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_ISSUE_PATH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
						<th width="80" class="point">점포명</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=158
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">회원명</th>
						<td width="240" colspan="3"><comment id="_NSID_"> <object
							id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S','P');"
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'P')" />
							<comment id="_NSID_"> <object id=EM_CUST_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">적용시작일</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" /></td>
						<th width="80">적용종료일</th>
							 <td><comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
						<th width="100">제휴카드ONLY여부</th>
						<td><comment id="_NSID_"> <object
							id=LC_S_JEHU_ONLY_YN classid=<%=Util.CLSID_LUXECOMBO%> width=158
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
	  <td class="PT10">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title"><img src="/pot/imgs/comm/ring_blue.gif"
					class="PR03" align="absmiddle" /> 신규발급입력</td>
				<td class="right"><img src="/pot/imgs/btn/issue_s.gif"
					hspace="2" id="IMG_ADD" onclick="javascript:btn_AddSave();" />
				</td>
			</tr>
		</table>
    </tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">회원등급</th>
						<td><comment id="_NSID_"> <object
							id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">패밀리카드구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_POCARD_PREFIX classid=<%=Util.CLSID_LUXECOMBO%> width=175
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">발행매수</th>
						<td><comment id="_NSID_"> <object id=EM_ISSUE_CNT
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment><script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="80" class="point">점코드</th>
						<td><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">회원명</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID','P');"
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							id="IMG_CUST" src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCompPop(EM_CUST_ID,EM_CUST_NAME,'P')" />
							<comment id="_NSID_"> <object id=EM_CUST_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">적용방법</th>
						<td><comment id="_NSID_"> <object
							id=LC_APP_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>						
					</tr>
                    <tr>
						<th width="80">DC율</th>
						<td><comment id="_NSID_"> <object id=EM_DC_RATE
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment><script> _ws_(_NSID_);</script>
						</td>
						<th width="80">금액</th>
						<td><comment id="_NSID_"> <object id=EM_DC_AMT
							classid=<%=Util.CLSID_EMEDIT%> width=170 tabindex=1></object> </comment><script> _ws_(_NSID_);</script>
						</td>
						<th width="80">전자쿠폰종류</th>
						<td><comment id="_NSID_"> <object
							id=LC_CPN_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
                    </tr>
                    <tr>
						<th width="80" class="point">적용시작일</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							id="IMG_S_DT" src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT)" /></td>
						<th width="80" class="point">적용종료일</th>
							 <td><comment
							id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							id="IMG_E_DT" src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT)" /></td>						
						<th width="100">제휴카드ONLY여부</th>
						<td><comment id="_NSID_"> <object
							id=LC_JEHU_ONLY_YN classid=<%=Util.CLSID_LUXECOMBO%> width=145
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
      <td class="sub_title PB03 PT10"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" /> 발급내역</td>
    </tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GD_MASTER width="100%" height=312
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_MASTER">
				</object></td>
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
        <c>col=CUST_GRADE     ctrl=LC_CUST_GRADE         Param=BindColVal</c>
        <c>col=POCARD_PREFIX  ctrl=LC_POCAD_PREFIX       Param=BindColVal</c>
        <c>col=ISSUE_CNT      ctrl=EM_ISSUE_CNT          Param=Text</c> 
        <c>col=STR_CD         ctrl=LC_STR_CD             Param=BindColVal</c>
        <c>col=CUST_ID        ctrl=EM_CUST_ID            Param=Text</c>
        <c>col=APP_FLAG       ctrl=LC_APP_FLAG           Param=BindColVal</c>            
        <c>col=DC_RATE        ctrl=EM_DC_RATE            Param=Text</c>        
        <c>col=DC_AMT         ctrl=EM_DC_AMT             Param=Text</c>
        <c>col=START_DT       ctrl=EM_S_DT               Param=Text</c>
        <c>col=END_DT         ctrl=EM_E_DT               Param=Text</c>
        <c>col=JEHU_ONLY_YN   ctrl=LC_JEHU_ONLY_YN       Param=BindColVal</c>
        <c>col=CPN_TYPE       ctrl=LC_CPN_TYPE           Param=BindColVal</c> 
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
