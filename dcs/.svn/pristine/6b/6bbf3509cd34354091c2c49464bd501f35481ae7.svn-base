<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 세대관리
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 김영진 
 * 파  일  명  : dctm1060.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 기명회원 가입 신청서를 등록한다
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.14 (김영진) 수정
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
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<%
	String strSsNo = (request.getParameter("strSsno") != null && !"".equals(request.getParameter("strSsno").trim())) ? request.getParameter("strSsno") : "";
	String strCustId = (request.getParameter("strCustid") != null && !"".equals(request.getParameter("strCustid").trim())) ? request.getParameter("strCustid") : "";
	String strCardNo = (request.getParameter("strCardno") != null && !"".equals(request.getParameter("strCardno").trim())) ? request.getParameter("strCardno") : "";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var flag = "Y";
var strCompPersFlag = "P";
var strCustid   = "";
var strCustid2  = "";
var strNewYn    = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-24
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 165;		//해당화면의 동적그리드top위치
 var top2 = 165;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_MASTER2"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	 
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
	initEmEdit(EM_SS_NO,     "000000", NORMAL);           //생년월일
	initEmEdit(EM_SS_NO2,    "000000", NORMAL);           //생년월일
	initEmEdit(EM_CARD_NO,   "0000-0000-0000-0000", NORMAL);
	initEmEdit(EM_CARD_NO2,  "0000-0000-0000-0000", NORMAL);
    initEmEdit(EM_CUST_ID,   "GEN^9",  NORMAL);         //회원코드
    initEmEdit(EM_CUST_NAME, "GEN^40", READ);           //회원명
    initEmEdit(EM_CUST_ID2,  "GEN^9",  NORMAL);         //회원코드
    initEmEdit(EM_CUST_NAME2,"GEN^40", READ);           //회원명
    initEmEdit(EM_CUST_ID1_H,"GEN^9",  NORMAL);         //회원코드
    initEmEdit(EM_CUST_ID2_H,"GEN^9",  NORMAL);         //회원코드
    
	//initEmEdit(EM_CHK,     "#", NORMAL);		        //이동버튼체크
    if(EM_CUST_ID.Text!=""){
		showMaster();
	}
	//버튼 동작 disabled = true
    enableControl(IMG_ACTMOVE, false);
    enableControl(IMG_SAVE2,   false);
    
    EM_CUST_ID1_H.style.display = "none";
    EM_CUST_ID2_H.style.display = "none";
    
    EM_CARD_NO.Focus();

    //기명개인회원가입신청서등록  화면에서 넘어오는 파라메타
    if("<%=strSsNo%>" != "" || "<%=strCardNo%>" != "" || "<%=strCustId%>" != ""){
        initSearch();
    }
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm106","DS_O_MASTER,DS_O_MASTER2");
}
/**
 * initSearch()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.04.07
 * 개       요 : Init시 기명개인회원가입신청서등록 화면에서 넘어오는 값이 있으면 조회
 * return값 :
 */
function initSearch(){
    EM_CUST_ID.Text = "<%=strCustId%>";
    EM_CARD_NO.Text = "<%=strCardNo%>";
    EM_SS_NO.Text = "<%=strSsNo%>";
    setCustInfoToDataSet("DS_O_RESULT", "SEL_CUSTSRCH", EM_CUST_ID.Text, EM_CARD_NO.Text, EM_SS_NO.Text, 'getOneWithoutPop',"P");
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_CUST_ID1_H.Text   = DS_O_RESULT.NameValue(1, "CUST_ID");
        if(trim(EM_CUST_ID.Text) != ""){
            EM_CUST_NAME.Text = DS_O_RESULT.NameValue(1, "CUST_NAME");
        }
    }
    if(trim(EM_CARD_NO.Text) != ""){
        EM_CARD_NO.Focus();
    }
    if(trim(EM_SS_NO.Text) != ""){
        EM_SS_NO.Focus();
    }
    if(trim(EM_CUST_ID.Text) != ""){
        EM_CUST_ID.Focus();
    }
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"             width=30        align=center</FC>'
    	             + '<FC>id=CUST_ID          name="회원ID"         width=50        align=center  show=false</FC>'
                     + '<FC>id=CUST_NAME        name="회원명"         width=50        align=left</FC>'
                     + '<FC>id=HHOLD_ID         name="세대주ID"       width=50        align=center  show=false</FC>'
                     + '<FC>id=HHOLD_MAN_ID     name="세대주회원ID"   width=50        align=center  show=false</FC>'
                     + '<FC>id=HHOLD_NAME       name="세대주명"       width=60        align=left</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"       width=140       align=center Mask="XXXX-XXXX-XXXX-XXXX" </FC>'
                     + '<FC>id=COMM_NAME1       name="카드종류"       width=130        align=left</FC>'
                     + '<FC>id=TAG              name="TAG"            width=80       show=false</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
	initGridStyle(GD_MASTER2, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-24
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	if( strNewYn == "N" ){
	     if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
	          setTimeout("GD_MASTER2.Focus();",50);
	         return false;
	     }else{
	         strNewYn = "";
	     }
	}
	
	if(trim(EM_SS_NO.Text).length == 0 && trim(EM_CUST_ID.Text).length == 0 && trim(EM_CARD_NO.Text).length == 0
			&& trim(EM_SS_NO2.Text).length == 0 && trim(EM_CUST_ID2.Text).length == 0 && trim(EM_CARD_NO2.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO.Focus();
        return;
    }
	if(trim(EM_SS_NO.Text).length > 0 && trim(EM_SS_NO.Text).length != 6){
	     showMessage(EXCLAMATION, OK, "USER-1000",  "[생년월일]을 정확하게 입력하세요.");
	     EM_SS_NO.Focus();
	     return;
	}
	// MARIO OUTLET
	//if(trim(EM_CARD_NO.Text).length > 0 && trim(EM_CARD_NO.Text).length != 16){
	if(trim(EM_CARD_NO.Text).length != 0 && trim(EM_CARD_NO.Text).length != 13 && trim(EM_CARD_NO.Text).length != 16 ) {
         showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호]를 정확하게 입력하세요.");
	     EM_CARD_NO.Focus();
	     return;
	}	
	if(trim(EM_SS_NO2.Text).length > 0 && trim(EM_SS_NO2.Text).length != 6){
        showMessage(EXCLAMATION, OK, "USER-1000",  "[생년월일]을 정확하게 입력하세요.");
        EM_SS_NO2.Focus();
        return;
   }	
	// MARIO OUTLET
	//if(trim(EM_CARD_NO2.Text).length > 0 && trim(EM_CARD_NO2.Text).length != 16){
    if(trim(EM_CARD_NO2.Text).length != 0 && trim(EM_CARD_NO2.Text).length != 13 && trim(EM_CARD_NO2.Text).length != 16 ) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호]를 정확하게 입력하세요.");
        EM_CARD_NO2.Focus();
        return;
   }
    
	DS_O_MASTER2.ClearData();
	showMaster();
	//조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-24
 * 개       요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	DS_O_MASTER2.ResetStatus();
	if( strNewYn == "N" ){
		if(showMessage(EXCLAMATION, YESNO, "USER-1000","변경내역이 있습니다. <br> 초기화  하시겠습니까?") != 1 ){
	        setTimeout("GD_MASTER2.Focus();",50);
            return false;
        }else{
        	strNewYn = "";
        }
	}
    var em = document.all.tags("object");
    if (em!=null){
      for (i = 0; i < em.length; i++) {
        
        if(em[i].classid=="<%=Util.CLSID_EMEDIT%>"){
        	em[i].Text = "";
        }
      }
    }
    doInit();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-01-14
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    flag = 'N';

    //저장할 데이터 없는 경우
    if ( strNewYn != "N" ){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
	saveData(flag);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-24
 * 개       요 : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
	EM_CUST_NAME.Text = "";//조건입력시 코드초기화
    
    if (trim(EM_CUST_ID.Text).length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_CUST_ID.Text.length == 9) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CUSTOMER", EM_CUST_ID.Text);
            
            if (DS_O_RESULT.CountRow == 1 ) {
            	EM_CUST_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
            	EM_CUST_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                if(trim(EM_CUST_NAME.Text) == ""){
                    getCompPop(EM_CUST_ID,EM_CUST_NAME,strCompPersFlag);
                }
            }
        }
    }
}
 
/**
 * keyPressEvent2()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-24
 * 개       요 : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent2(kcode) {
    EM_CUST_NAME2.Text = "";//조건입력시 코드초기화
    
    if (EM_CUST_ID2.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_CUST_ID2.Text.length == 9) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CUSTOMER", EM_CUST_ID2.Text);
            
            if (DS_O_RESULT.CountRow == 1 ) {
            	EM_CUST_ID2.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
            	EM_CUST_NAME2.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                if(trim(EM_CUST_NAME2.Text) == ""){
                	getCompPop(EM_CUST_ID2,EM_CUST_NAME2,strCompPersFlag);  
                }
            }
        }
    }
}

/**
* showMaster()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-24
* 개       요 : 세대관리 조회
* return값 : void
*/
function showMaster(){

    strCustid       = EM_CUST_ID.text;
	var strCardno   = EM_CARD_NO.text;
	var strSsno     = EM_SS_NO.text;

    strCustid2      = EM_CUST_ID2.text;
	var strCardno2  = EM_CARD_NO2.text;
	var strSsno2    = EM_SS_NO2.text;
	
	if(trim(strCustid) == ""){
		strCustid = EM_CUST_ID1_H.Text;
	}
	if(trim(strCustid2) == ""){
        strCustid2 = EM_CUST_ID2_H.Text;
    }
    
	
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strCustid="  + encodeURIComponent(strCustid)
                   + "&strCardno="  + encodeURIComponent(strCardno)
                   + "&strSsno="    + encodeURIComponent(strSsno)
				   + "&strCustid2=" + encodeURIComponent(strCustid2)
		           + "&strCardno2=" + encodeURIComponent(strCardno2)
                   + "&strSsno2="   + encodeURIComponent(strSsno2);
    TR_MAIN.Action="/dcs/dctm106.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER,O:DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
    TR_MAIN.Post();
    
    //버튼 활성화 /비활성화
    if((DS_O_MASTER2.CountRow == 0 && DS_O_MASTER.NameValue(1, "CUST_ID") == DS_O_MASTER.NameValue(1, "HHOLD_MAN_ID"))
      || DS_O_MASTER.NameValue(1, "HHOLD_MAN_ID") == DS_O_MASTER2.NameValue(1, "HHOLD_MAN_ID")){
    	enableControl(IMG_ACTMOVE, false);
        enableControl(IMG_SAVE2,   false);
    }else if(DS_O_MASTER2.CountRow == 0 && DS_O_MASTER.NameValue(1, "CUST_ID") != DS_O_MASTER.NameValue(1, "HHOLD_MAN_ID")){
    	enableControl(IMG_ACTMOVE, false);
        enableControl(IMG_SAVE2,   true);
    }else if(DS_O_MASTER2.CountRow > 0 && DS_O_MASTER.NameValue(1, "HHOLD_MAN_ID") != DS_O_MASTER2.NameValue(1, "HHOLD_MAN_ID")){
    	enableControl(IMG_ACTMOVE, true);
        enableControl(IMG_SAVE2,   false);
    }
    
    if(DS_O_MASTER.CountRow > 0){
        GD_MASTER.Focus();  
    }else if(DS_O_MASTER2.CountRow > 0){
        GD_MASTER2.Focus(); 
    }else{
        EM_CARD_NO.Focus(); 
    }
}

/**
* actMove()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-24
* 개       요 : 세대원을 세대주로 이동
* return값 : void
*/
function actMove(){
    var data = DS_O_MASTER.ExportData(1,DS_O_MASTER.CountRow,false); 
    DS_O_MASTER2.ImportData(data); 
    DS_O_MASTER.ClearData();
    strNewYn = "N";
}

/**
 * saveData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-24
 * 개       요 : 세대원 이동 저장
 * 파라미터 : gubun Y:단독세대구성, N:이동
 * return값 : void
 */
function saveData(gubun){

	if(gubun == "Y"){
	    //저장여부 QUESTION
	    if( showMessage(QUESTION, YESNO, "USER-1000", "독립세대구성을 처리 하시겠습니까?") != 1 ){
	        return;
	    }	
	}
	
    strCustid   = EM_CUST_ID.text;
    strCustid2  = EM_CUST_ID2.text;
    
    if(trim(strCustid) == ""){
        strCustid = EM_CUST_ID1_H.Text;
    }
    if(trim(strCustid2) == ""){
        strCustid2 = EM_CUST_ID2_H.Text;
    }
    
    if(trim(strCustid) == ""){
    	strCustid = EM_CUST_ID1_H.Text; 
    }else if(trim(strCustid2) == ""){
    	strCustid2 = EM_CUST_ID2_H.Text; 
    }
    
    strNewYn = gubun;
    var parameters = "&strCustid="+encodeURIComponent(strCustid)+
		             "&strCustid2="+encodeURIComponent(strCustid2)+
	                 "&strNewYn="+encodeURIComponent(strNewYn);

    TR_MAIN.Action="/dcs/dctm106.dm?goTo=saveData"+parameters;
    TR_MAIN.Post();  
    strNewYn = "";
    showMaster();
}

 /**
  * getCustSrch()
  * 작 성 자 : 김영진
  * 작 성 일 : 2010.02.23
  * 개       요 : Enter, Tab키 이벤트
  * return값 :
  */
 function getCustSrch(kcode,obj,objNm,cpflag) {
     var intLength = 0;
     var strSsNo   = ""; 
     var strCardNo = ""; 
     var strCustId = ""; 
     var intLength13 = 0;
     var intLength16 = 0;
     var goTo      = "getOneWithoutPop";
     if(objNm == 'EM_SS_NO1' || objNm == 'EM_SS_NO2'){
         //intLength = 13;
         intLength = 6;
         strSsNo = obj.Text;
     }else if(objNm == 'EM_CARD_NO1' || objNm == 'EM_CARD_NO2'){
         intLength = 16;
         intLength13 = 13;
         intLength16 = 16;
         strCardNo = trim(obj.Text);
     }
     if (trim(obj.Text).length > 0 ) {
         if (kcode == 13 || kcode == 9 || trim(obj.Text).length == intLength || trim(obj.Text).length == intLength13 || trim(obj.Text).length == intLength16) { //TAB,ENTER 키 실행시에만 
             setCustInfoToDataSet("DS_O_RESULT", "SEL_CUSTSRCH", strCustId, strCardNo, strSsNo, goTo, cpflag);
             if (DS_O_RESULT.CountRow == 1 ) {
            	 if(objNm == 'EM_SS_NO1'){
                     EM_CUST_ID1_H.Text = DS_O_RESULT.NameValue(1, "CUST_ID"); 
            	 }else if(objNm == 'EM_SS_NO2'){
            		 EM_CUST_ID2_H.Text = DS_O_RESULT.NameValue(1, "CUST_ID"); 
            	 }
            	 if(objNm == 'EM_CARD_NO1'){
                     EM_CUST_ID1_H.Text = DS_O_RESULT.NameValue(1, "CUST_ID"); 
                 }else if(objNm == 'EM_CARD_NO2'){
                     EM_CUST_ID2_H.Text = DS_O_RESULT.NameValue(1, "CUST_ID"); 
                 }
             }else{
            	 if(objNm == 'EM_SS_NO1' || objNm == 'EM_SS_NO2'){
            		 EM_CUST_ID1_H.Text   = "";
                 }else if(objNm == 'EM_SS_NO2' || objNm == 'EM_CARD_NO2'){
                	 EM_CUST_ID2_H.Text   = "";
                 }
                 
             }
         }
     }
 }
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
        if(flag == 'Y'){
        	GD_MASTER2.Focus();
        }else{
        	GD_MASTER.Focus();
        }
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    DS_O_MASTER.ClearData();
    DS_O_MASTER2.ClearData();
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 회원명 onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID event=onKillFocus()>
    if ((EM_CUST_ID.Modified) && (EM_CUST_ID.Text.length != 9)) {
        EM_CUST_NAME.Text = "";
    }
</script>
<script language=JavaScript for=EM_CARD_NO event=onKillFocus()>
    if (trim(EM_CARD_NO.Text) == "") {
    	EM_CUST_ID1_H.Text = "";
    }
</script>
<script language=JavaScript for=EM_SS_NO event=onKillFocus()>
    if (trim(EM_SS_NO.Text) == "") {
        EM_CUST_ID1_H.Text = "";
    }
</script>
<script language=JavaScript for=EM_CARD_NO2 event=onKillFocus()>
    if (trim(EM_CARD_NO2.Text) == "") {
        EM_CUST_ID2_H.Text = "";
    }
</script>
<script language=JavaScript for=EM_SS_NO2 event=onKillFocus()>
    if (trim(EM_SS_NO2.Text) == "") {
        EM_CUST_ID2_H.Text = "";
    }
</script>
<script language=JavaScript for=EM_CUST_ID2 event=onKillFocus()>
    if ((EM_CUST_ID2.Modified) && (EM_CUST_ID2.Text.length != 9)) {
        EM_CUST_NAME2.Text = "";
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
<!-- =============== 공통함수용 -->

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
<script language='javascript'>
<!--
window.onresize = function(){
    var obj   = document.getElementById("testdiv"); 
    obj.style.height  = (parseInt(window.document.body.clientHeight)-40) + "px";
}
//-->
</script>

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_MASTER2");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>
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
						<th width="100">이동할 세대원회원</th>
						<th width="75">카드번호</th>
						<td width="133"><comment id="_NSID_"><object
							id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=125 tabindex=1
							onKeyUp="javascript:getCustSrch(event.keyCode,this,'EM_CARD_NO1','P');">
						</object> </comment> <script>_ws_(_NSID_);</script>
                        <comment id="_NSID_">
                        <object id=EM_CUST_ID1_H classid=<%=Util.CLSID_EMEDIT%> width=0></object>
                        </comment> <script>_ws_(_NSID_);</script>
                        <comment id="_NSID_">
                        <object id=EM_CUST_ID2_H classid=<%=Util.CLSID_EMEDIT%> width=0></object></td>
                        </comment> <script>_ws_(_NSID_);</script>
						<th width="75">생년월일</th>
						<td width="109"><comment id="_NSID_"> <object
							id=EM_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							onKeyUp="javascript:getCustSrch(event.keyCode,this,'EM_SS_NO1','P');">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
						<th width="75">회원명</th>
						<td><comment id="_NSID_"> <object id=EM_CUST_ID
							classid=<%=Util.CLSID_EMEDIT%> width=65 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode);"></object></comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getCompPop(EM_CUST_ID,EM_CUST_NAME,'P')" /> <comment
							id="_NSID_"> <object id=EM_CUST_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=75></object></comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>이동할 세대주회원</th>
						<th>카드번호</th>
						<td><comment id="_NSID_"> <object id=EM_CARD_NO2
							classid=<%=Util.CLSID_EMEDIT%> width=125 tabindex=1
							onKeyUp="javascript:getCustSrch(event.keyCode,this,'EM_CARD_NO2','P');">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
						<th>생년월일</th>
						<td><comment id="_NSID_"> <object id=EM_SS_NO2
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
							onKeyUp="javascript:getCustSrch(event.keyCode,this,'EM_SS_NO2','P');">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
						<th>회원명</th>
						<td><comment id="_NSID_"> <object id=EM_CUST_ID2
							classid=<%=Util.CLSID_EMEDIT%> width=65 tabindex=1
							onKeyUp="javascript:keyPressEvent2(event.keyCode);"></object></comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getCompPop(EM_CUST_ID2,EM_CUST_NAME2,'P')" /> <comment
							id="_NSID_"> <object id=EM_CUST_NAME2
							classid=<%=Util.CLSID_EMEDIT%> width=75></object></comment><script>_ws_(_NSID_);</script>
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
			<tr>
				<td align="right" height="25"><img
					src="/<%=dir%>/imgs/btn/generation.gif" id="IMG_SAVE2"
					align="absmiddle" onclick="saveData('Y')"></td>
			</tr>
			<tr>
				<td valign="top">
				<table width="385" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"> <object id=GD_MASTER
							width="455" height=720 classid=<%=Util.CLSID_GRID%> tabindex=1>
							<param name="DataID" value="DS_O_MASTER">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td align="center" class="PL05 PR05" width="30"><img
					src="/<%=dir%>/imgs/btn/next.gif" id="IMG_ACTMOVE"
					align="absmiddle" onclick="actMove()"></td>
				<td width="100%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"> <object id=GD_MASTER2
							width="100%" height=720 classid=<%=Util.CLSID_GRID%> tabindex=1>
							<param name="DataID" value="DS_O_MASTER2">
						</object> </comment> <script>_ws_(_NSID_);</script></td>
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
</body>
</html>
