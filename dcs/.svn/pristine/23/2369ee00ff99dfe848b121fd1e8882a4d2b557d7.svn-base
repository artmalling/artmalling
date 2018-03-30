<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 법인회원조회/수정
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 남형석
 * 수  정  자  : 
 * 파  일  명  : dctm2060.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (남형석) 신규작성
 *           2010.03.15 (김영진) 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"            prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	String strSSno = "";
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<%
	String strSsNo = (request.getParameter("strSsNo") != null && !"".equals(request.getParameter("strSsNo").trim())) ? request.getParameter("strSsNo") : "";	
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
var flag = false;
var strFlag = "INS";
var sel_FilterExpr       = "2";
var strBeforeCustGrade   = "";
var strBeforeCustGradeNm = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    //Input Data Set Header 초기화
    //법인회원조회/수정 .
    DS_IO_CUST.setDataHeader  ('<gauce:dataset name="H_CUST"/>');
   
    DS_IO_CUST.ClearData();
    DS_IO_CUST.Addrow();

    //EMedit에 초기화
    initEmEdit(EM_SS_NO_S,   "#00-00-00000",        NORMAL);   //사업자번호
    initEmEdit(EM_CARD_NO_S, "0000-0000-0000-0000", NORMAL);   //카드번호
    initEmEdit(EM_SS_NO,     "#00-00-00000",        PK);       //사업자번호
    initEmEdit(EM_CUST_NAME,   "GEN^40", PK);            //성명
    initEmEdit(EM_CARD_PWD_NO, "GEN^4",  PK);            //카드비밀번호
    initEmEdit(EM_REP_NAME,    "GEN^10", PK);            //대표자명
    initEmEdit(EM_CHKSAVE,     "GEN^1",  NORMAL);        //저장시에 I,U 구분.
    initEmEdit(EM_CUST_ID,     "GEN",    NORMAL);                                
    initEmEdit(EM_HHOLD_ID,    "GEN",    NORMAL);                                       
    initEmEdit(EM_HOME_PH1,    "0000",   NORMAL);
    initEmEdit(EM_HOME_PH2,    "0000",   NORMAL);
    initEmEdit(EM_HOME_PH3,    "0000",   NORMAL);
    initEmEdit(EM_OFFI_FAX1,   "0000",   NORMAL);
    initEmEdit(EM_OFFI_FAX2,   "0000",   NORMAL);
    initEmEdit(EM_OFFI_FAX3,   "0000",   NORMAL);
    initEmEdit(EM_HOME_ADDR1,  "GEN^200",PK);   
    initEmEdit(EM_HOME_ADDR2,  "GEN^200",PK);
    initEmEdit(EM_HOME_ZIP_CD1,"NUMBER^3^0", PK);
    initEmEdit(EM_HOME_ZIP_CD2,"NUMBER^3^0", PK);
    initEmEdit(EM_HOME_ZIP_SEQ,"GEN^3",  NORMAL);
    initEmEdit(EM_OFFI_NM,     "GEN^10", PK);
    initEmEdit(EM_OFFI_PH1,    "0000",   PK);
    initEmEdit(EM_OFFI_PH2,    "0000",   PK);
    initEmEdit(EM_OFFI_PH3,    "0000",   PK);
    initEmEdit(EM_EMAIL1,      "GEN^50", NORMAL);
    initEmEdit(EM_EMAIL3,      "GEN^50", NORMAL);
    
    initEmEdit(EM_CUST_ID_S,   "GEN^9",  NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S, "GEN^40", READ);       //회원명

    initComboStyle(LC_EMAIL2,DS_O_EMAIL2, "CODE^0^30,NAME^0^110", 1, NORMAL);  //이메일주소목록
    initEmEdit(EM_HOME_NEW_YN,  "GEN^1", NORMAL);    //집 - 구/신주소여부
 
    initComboStyle(LC_CUST_GRADE, DS_IO_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
    initComboStyle(LC_VIP_FLAG,   DS_O_VIP_FLAG,   "CODE^0^30,NAME^0^110", 1, PK); //VIP등록구분
    
    getEtcCode("DS_O_EMAIL2", "D", "D013", "N");
    getEtcCode("DS_IO_CUST_GRADE", "D", "D011", "N");
    getEtcCode("DS_O_VIP_FLAG",   "D", "D068", "N");
    EM_CHKSAVE.Text = "I";
    LC_EMAIL2.BindColVal = "99";
    LC_CUST_GRADE.BindColVal = "21"
    
    //라디오버튼 초기설정
    RD_EMAIL_YN.CodeValue = "Y";
    RD_SMS_YN.CodeValue   = "Y";
    
    EM_HOME_ZIP_CD1.Enable = false;
    EM_HOME_ZIP_CD2.Enable = false;
    EM_HOME_ADDR1.Enable   = false;
    EM_HOME_ZIP_CD1.Alignment = 1;
    EM_HOME_ZIP_CD2.Alignment = 1;
    
    EM_HOME_ZIP_SEQ.Visible       = false;
    EM_HOME_ZIP_SEQ.style.display = "none";
    EM_EMAIL3.style.display       = "none";
    EM_HOME_NEW_YN.style.display  = "none";
    EM_CHKSAVE.style.display      = "none";
    EM_CUST_ID.style.display      = "none";
    EM_HHOLD_ID.style.display     = "none";
    LC_VIP_FLAG.style.display     = "none";

    //성명,주민번호수정버튼 비활성화
    IMG_MODIFY_NAME.disabled = true;
    IMG_SOCIALNUM.disabled   = true;
    IMG_CARDINFO.disabled    = true;
    
    EM_CARD_NO_S.Focus();
    
    //신청서 화면이므로 최초 addrow Dataset status 초기화.
    DS_IO_CUST.ResetStatus();
    
    if("<%=strSsNo%>" != ""){
    	EM_SS_NO_S.Text = "<%=strSsNo%>";
    	showCustInfo();
    }
  
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm206","DS_IO_CUST");
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
 * 작 성 일 : 2010-03-15
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0
       && trim(EM_CUST_ID_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[사업자등록번호],[법인명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else{
        if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호]의 입력형식이 올바르지 않습니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
        if (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "[사업자번호]의 입력형식이 올바르지 않습니다.");
            EM_SS_NO_S.Focus();
            return;
        }
        if(trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9 ){
            showMessage(EXCLAMATION, OK, "USER-1000",  "[법인명]의 입력형식이 올바르지 않습니다.");
            EM_CUST_ID_S.Focus();
            return;
        }
    }
    showCustInfo();
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개       요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    var em = document.all.tags("object");
    if (em!=null){
      for (i = 0; i < em.length; i++) {
        
        if(em[i].classid=="<%=Util.CLSID_EMEDIT%>"){
            em[i].Text = "";
        }
      }
    }
    doClearDt();
    //신청서 화면이므로 최초 addrow Dataset status 초기화.
    DS_IO_CUST.ResetStatus();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    if(!flag){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 저장 가능합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    var chk;

    if(trim(EM_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업자등록번호");
        EM_SS_NO.Focus();
        return false;
    }
    if(EM_SS_NO.Text.indexOf("B")==-1){
        chk = isSaupNO(EM_SS_NO.Text);
    }
    if(chk==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
        EM_SS_NO.Focus();
        return false;
    }
    if(trim(EM_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업자등록번호");
        EM_SS_NO.Focus();
        return false;
    }
    if(trim(EM_CUST_NAME.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업자명");
        EM_CUST_NAME.Focus();
        return false;
    }
/*    
    if(trim(EM_CARD_PWD_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드비밀번호");
        EM_CARD_PWD_NO.Focus();
        return false;
    }
    if( trim(EM_CARD_PWD_NO.Text).length > 0 && trim(EM_CARD_PWD_NO.Text).length < 4){
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드비밀번호는 4자리입니다.");
        EM_CARD_PWD_NO.Focus();
        return false;
    }
*/    
    if(!isNumberStr(EM_CARD_PWD_NO.Text) && EM_CARD_PWD_NO.Text != "****"){
        showMessage(EXCLAMATION, OK, "USER-1005",  "카드비밀번호");
        EM_CARD_PWD_NO.Focus();
        return false;
    } 
    if(trim(EM_REP_NAME.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "대표자명");
        EM_REP_NAME.Focus();
        return false;
    }
    if(trim(EM_HOME_PH2.text) != "" && trim(EM_HOME_PH3.text) == "" 
     || trim(EM_HOME_PH2.text) == "" && trim(EM_HOME_PH3.text) != ""){
        showMessage(EXCLAMATION, OK, "USER-1000",  "대표전화를  정확히 입력하세요.");
        if(trim(EM_HOME_PH2.text) == ""){
            EM_HOME_PH2.Focus();
        }else if(trim(EM_HOME_PH3.text) == ""){
            EM_HOME_PH3.Focus();
        }
        return false;
    }
    if(trim(EM_HOME_ZIP_CD1.text)=="" || trim(EM_HOME_ZIP_CD2.text) == ""){     
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업장주소");
        getPostPop_dcs(EM_HOME_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HOME_ADDR1,EM_HOME_ADDR2,EM_HOME_NEW_YN);
        return false;
    }
    if(trim(EM_HOME_ADDR2.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업장상세주소");
        EM_HOME_ADDR2.Focus();
        return false;
    }    
    if(trim(EM_OFFI_NM.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "담당자명");
        EM_OFFI_NM.Focus();
        return false;
    }
    if(trim(EM_OFFI_PH1.text) == "" && trim(EM_OFFI_PH2.text) == "" && trim(EM_OFFI_PH3.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "담당자전화");
        EM_OFFI_PH1.Focus();
        return false;
    }
    if(trim(EM_OFFI_PH1.text)  != "" && (trim(EM_OFFI_PH2.text) == "" || trim(EM_OFFI_PH3.text) == "")
     || trim(EM_OFFI_PH2.text) != "" && (trim(EM_OFFI_PH1.text) == "" || trim(EM_OFFI_PH3.text) == "")
     || trim(EM_OFFI_PH3.text) != "" && (trim(EM_OFFI_PH1.text) == "" || trim(EM_OFFI_PH2.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1003",  "담당자전화");
        if(trim(EM_OFFI_PH1.text) == ""){
            EM_OFFI_PH1.Focus();
        }else if(trim(EM_OFFI_PH2.text) == ""){
            EM_OFFI_PH2.Focus();
        }else if(trim(EM_OFFI_PH3.text) == ""){
            EM_OFFI_PH3.Focus();
        }
        return false;
    }
    if(firstTelFormatAll(EM_OFFI_PH1)==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
        EM_OFFI_PH1.Focus();
        EM_OFFI_PH1.SelectAll = true;
        return false;
    }
    if(trim(EM_OFFI_FAX1.text) != "" && (trim(EM_OFFI_FAX2.text) == "" || trim(EM_OFFI_FAX3.text) == "")
    || trim(EM_OFFI_FAX2.text) != "" && (trim(EM_OFFI_FAX1.text) == "" || trim(EM_OFFI_FAX3.text) == "")
    || trim(EM_OFFI_FAX3.text) != "" && (trim(EM_OFFI_FAX1.text) == "" || trim(EM_OFFI_FAX2.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1000",  "FAX 번호를  정확히 입력하세요.");
        if(trim(EM_OFFI_FAX1.text) == ""){
            EM_OFFI_FAX1.Focus();
        }else if(trim(EM_OFFI_FAX2.text) == ""){
        	EM_OFFI_FAX2.Focus();
        }else if(trim(EM_OFFI_FAX3.text) == ""){
        	EM_OFFI_FAX3.Focus();
        }
        return false;
    }
    if(RD_EMAIL_YN.CodeValue == "Y" && trim(EM_EMAIL1.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "이메일주소");
        EM_EMAIL1.Focus();
        return;
    }
    if(LC_EMAIL2.BindColVal != "99" && trim(EM_EMAIL1.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "이메일주소");
        EM_EMAIL1.Focus();
        return;
    }
    if( trim(EM_EMAIL3.Text).length != 0){
        if(LC_EMAIL2.BindColVal == "99" && trim(EM_EMAIL1.Text).length == 0 ){
            showMessage(EXCLAMATION, OK, "USER-1003",  "이메일주소");
            EM_EMAIL1.Focus();
            return;
        }
    }
    if( trim(EM_EMAIL1.Text).length != 0){
        if(LC_EMAIL2.BindColVal == "99" && trim(EM_EMAIL3.Text).length == 0 ){
            showMessage(EXCLAMATION, OK, "USER-1003",  "도메인");
            EM_EMAIL3.Focus();
            return;
        }
    }
    if(LC_CUST_GRADE.BindColVal == "41" && trim(LC_VIP_FLAG.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "VIP등록구분");
        LC_VIP_FLAG.Focus();
        return false;
    }
    
    //저장할 데이터 없는 경우
    if (!DS_IO_CUST.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    saveData();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * doClearDt()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개       요 : 설정초기화
 * return값 : void
 */
function doClearDt(){
	strBeforeCustGrade   = "";
	strBeforeCustGradeNm = "";
    strFlag = "INS";
    
	LC_VIP_FLAG.BindColVal     = "";
    LC_VIP_FLAG.style.display  = "none";    
    LC_CUST_GRADE.BindColVal   = "21"   
    
    EM_CHKSAVE.Text = "I";
	LC_EMAIL2.BindColVal = "99";
	    
	//라디오버튼 초기설정
	RD_EMAIL_YN.CodeValue       = "Y";
	RD_SMS_YN.CodeValue         = "Y";

	//성명,주민번호수정버튼 비활성화
	IMG_MODIFY_NAME.disabled = true;
	IMG_SOCIALNUM.disabled   = true;
	IMG_CARDINFO.disabled    = true;
	
	//사업자번호,사업자명 활성화
	EM_CUST_NAME.Enable = true;
	EM_SS_NO.Enable     = true;
}
	
/**
 * saveData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개    요 : 법인회원조회/수정  저장
 * return값 : void
 */
function saveData(){

    if(LC_EMAIL2.BindColVal == "99"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = EM_EMAIL3.Text;
    }else{
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = LC_EMAIL2.Text;
    }         
    if(RD_EMAIL_YN.CodeValue == "Y"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "<%=toDate%>";          // 등록일자
    }else{
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "";                      // 등록일자
    }
    if(RD_SMS_YN.CodeValue == "Y"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SMS_AGREE_DT")   = "<%=toDate%>";
    }else{
         DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SMS_AGREE_DT")  = "";
    } 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CARD_COUNT")  = "0";
    
    var strChksave    = EM_CHKSAVE.Text;
    var parameters = "&strChksave=" + encodeURIComponent(strChksave)
                   + "&strUpdate=Y";

    TR_MAIN.Action="/dcs/dctm105.dm?goTo=saveData"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CUST=DS_IO_CUST)";
    TR_MAIN.Post();  

}

/**
 * showCustInfo()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개    요 : 법인회원의 회원정보를 가져온다.
 * return값 : void
 */
function showCustInfo(){
	strFlag = "UPD";
	flag = true;
	EM_EMAIL3.text = ""; 
	strBeforeCustGrade   = "";
	strBeforeCustGradeNm = "";
	
	DS_IO_CUST.ClearData();
	
    var strSsNo    = EM_SS_NO_S.text;
    var strCardNo  = EM_CARD_NO_S.text;
    var strCustId  = EM_CUST_ID_S.Text;

    var goTo       = "showCustInfo" ;    
    var action     = "O";     
    var parameters = "&strSsno="   + encodeURIComponent(strSsNo)
                   + "&strCardNo=" + encodeURIComponent(strCardNo)
                   + "&strCustId=" + encodeURIComponent(strCustId);
    TR_MAIN.Action="/dcs/dctm105.dm?goTo=" + goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CUST=DS_IO_CUST)"; //조회는 O
    TR_MAIN.Post();

    if(DS_IO_CUST.CountRow > 0){
    	//성명,주민번호수정버튼  활성화
        IMG_MODIFY_NAME.disabled = false;
        IMG_SOCIALNUM.disabled   = false;
        IMG_CARDINFO.disabled    = false;
        
        if(EM_CHKSAVE.Text=="U"){
            EM_CUST_NAME.Enable = false;
            EM_SS_NO.Enable     = false;
            if(EM_CARD_PWD_NO.Text!=""){
                EM_CARD_PWD_NO.Text = "****";
            }
            
            strBeforeCustGrade   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"CUST_GRADE");
            strBeforeCustGradeNm = LC_CUST_GRADE.Text;
        }

        LC_EMAIL2.Text   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2");
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", EM_EMAIL3.Text);
        if(strFlag == "UPD" && LC_EMAIL2.BindColVal == ""){
            setComboData(LC_EMAIL2,"99");
            EM_EMAIL3.style.display = "";
        }else{
            EM_EMAIL3.Text = ""; 
            EM_EMAIL3.style.display = "none";
        }
        
        if(trim(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"SCED_REQ_DT")) != ""){
            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 회원정보 수정이 불가합니다.");
            btn_New();
            setTimeout("EM_SS_NO_S.Focus();",50);
            return false;
        }
        EM_CARD_PWD_NO.Focus();
        //신청서 화면이므로 최초 addrow Dataset status 초기화.
        DS_IO_CUST.ResetStatus();
        
    }else{
    	//설정초기화
    	doClearDt();
    }
    
}

/**
 * showCardInfo()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-16
 * 개      요  : 카드정보 보기팝업
 * return값 : void
 */
function showCardInfo(objCd){
    var returnVal = window.showModalDialog("/dcs/dctm206.dm?goTo=showCardInfo&strSsNo="+objCd.Text,
                                           '',
                                           "dialogWidth:734px;dialogHeight:408px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
 * editSsno()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개      요  : 사업자번호 변경
 * return값 : void
 */
function editSsno(objCd){
	 
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/dcs/dctm206.dm?goTo=editSsno&ssNo="+EM_SS_NO.Text+"&custId="+EM_CUST_ID.Text,
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:145px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map = arrArg[0];
        objCd.Text = map.get("SS_NO");
    }  
}

/**
 * editCustnm()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개       요 : 사업자(단체)명 변경
 * return값 : void
 */
function editCustnm(objNm){
	 
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(EM_CUST_ID.Text);
    arrArg.push(objNm.Text);
    var returnVal = window.showModalDialog(encodeURI("/dcs/dctm206.dm?goTo=editCustnm"),
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:145px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map = arrArg[0];
        objNm.Text = map.get("CUST_NAME");
    }
}

/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-15
 * 개      요  : 회원메모관리 화면으로 이동
 * return값 : void
 */
function gourl(){
	 
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}	     
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM112","/dcs/dctm112.dm?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text+"&strCustId="+EM_CUST_ID_S.Text+"&strCompPersFlag=C","DCTM","01","회원메모관리");
}

/**
 * getCompCustId()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.05.31
 * 개    요 : Enter, Tab키 이벤트
 * return값 :
 */
 function getCompCustId(kcode) {
	 EM_CUST_NAME_S.Text = "";//조건입력시 코드초기화
	 var goTo      = "getOneWithoutPop";
     if (EM_CUST_ID_S.Text.length > 0 ) {
         if (kcode == 13 || kcode == 9 || EM_CUST_ID_S.Text.length == 9) { //TAB,ENTER 키 실행시에만 
             setCustInfoToDataSet("DS_O_RESULT", "SEL_CUSTSRCH", EM_CUST_ID_S.Text, '', '', goTo, 'C');
             if (DS_O_RESULT.CountRow == 1 ) {
            	 EM_CUST_NAME_S.Text = DS_O_RESULT.NameValue(1, "CUST_NAME");
             } else {
                 //1건 이외의 내역이 조회 시 팝업 호출
            	 getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'C');
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
        showMessage(INFORMATION, OK, "USER-1000", "정상적으로 변경 되었습니다.");
    }    
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
    }
    if( LC_EMAIL2.BindColVal == "" ){
        setComboData(LC_EMAIL2,"99");
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
    }
    if( LC_EMAIL2.BindColVal == "" ){
        setComboData(LC_EMAIL2,"99");
    }
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_CUST_GRADE event=onFilter(row)>
    switch (sel_FilterExpr) {
    case "1":
        return true;
        break;
    case "2":
        if (DS_IO_CUST_GRADE.NameValue(row,"CODE") != "11") return true
        else return false;
        break;
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = "";
    }
</script>
<!-- 대표전화  onKillFocus()-->
<script language=JavaScript for=EM_HOME_PH1 event=onKillFocus()>
    if(trim(EM_HOME_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_HOME_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_HOME_PH1.Text = ""
            setTimeout( "EM_HOME_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 담당자연락처 onKillFocus()-->
<script language=JavaScript for=EM_OFFI_PH1 event=onKillFocus()>
    if(trim(EM_OFFI_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_OFFI_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_OFFI_PH1.Text = ""
            setTimeout( "EM_OFFI_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!--  FAX 번호  onKillFocus()-->
<script language=JavaScript for=EM_OFFI_FAX1 event=onKillFocus()>
    if(trim(EM_OFFI_FAX1.Text).length != 0){
        if(firstTelFormat(EM_OFFI_FAX1,"T")==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_OFFI_FAX1.Text = ""
            setTimeout( "EM_OFFI_FAX1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 도메인 OnSelChange() -->
<script language=JavaScript for=LC_EMAIL2 event=OnSelChange()>
    if(LC_EMAIL2.BindColVal == "99"){
        EM_EMAIL3.style.display = "";
    }else{
        EM_EMAIL3.style.display = "none";
    }
</script>
<!-- 사업자 번호 onKillFocus()-->
<script language=JavaScript for=EM_SS_NO_S event=onKillFocus()>
    if(trim(EM_SS_NO_S.Text).length != 0){
        var chk;
        if(EM_SS_NO_S.Text.indexOf("B")==-1){
            chk = isSaupNO(EM_SS_NO_S.Text);
        }
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
            EM_SS_NO_S.Text = "";
            setTimeout( "EM_SS_NO_S.Focus();",50);    
            return false;
        }else if(trim(EM_SS_NO_S.Text).length != 10){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
            EM_SS_NO_S.Text = "";
            setTimeout( "EM_SS_NO_S.Focus();",30);    
            return false;
        }

        
        if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호]의 입력형식이 올바르지 않습니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
        if(trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9 ){
            showMessage(EXCLAMATION, OK, "USER-1000",  "[법인명]의 입력형식이 올바르지 않습니다.");
            EM_CUST_ID_S.Focus();
            return;
        }
        
        showCustInfo();
    }
</script>
<!-- 카드번호 onKillFocus()-->
<script language=JavaScript for=EM_CARD_NO_S event=onKillFocus()>
    if(trim(EM_CARD_NO_S.Text).length == 16){
        if(!isValidCardNo(EM_CARD_NO_S.Text)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 카드번호가 아닙니다.");
            EM_CARD_NO_S.Text = "";
            setTimeout( "EM_CARD_NO_S.Focus();",50);
            return false;
        }
        if (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "[사업자번호]의 입력형식이 올바르지 않습니다.");
            EM_SS_NO_S.Focus();
            return;
        }
        if(trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9 ){
            showMessage(EXCLAMATION, OK, "USER-1000",  "[법인명]의 입력형식이 올바르지 않습니다.");
            EM_CUST_ID_S.Focus();
            return;
        }
        showCustInfo();
    }
</script>

<!-- 회원등급 OnSelChange() -->
<script language=JavaScript for=LC_CUST_GRADE event=OnSelChange()>
    //기존등급 => 등급변경시  QUESTION
    if( strFlag != "INS" && DS_IO_CUST.IsUpdated && strBeforeCustGradeNm != "" ){
        if(strBeforeCustGradeNm != LC_CUST_GRADE.Text){
            if( showMessage(QUESTION, YESNO, "USER-1000", strBeforeCustGradeNm+"에서 "+LC_CUST_GRADE.Text+"(으)로 회원등급을 조정하시겠습니까?") != 1 ){
            	LC_CUST_GRADE.BindColVal = strBeforeCustGrade;
                return;
            }
        }
    }
    if(LC_CUST_GRADE.BindColVal == "41"){
        LC_VIP_FLAG.style.display = "";
        LC_VIP_FLAG.BindColVal    = ""
    }else{
        LC_VIP_FLAG.style.display = "none";
    }  
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_">
<object id="DS_O_EMAIL2" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_JOB_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CUST" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="Filter_s1.csv">
    <param name=UseFilter   value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_VIP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
						<th width="90">카드번호</th>
						<td width="310"><comment id="_NSID_"> <object
							id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width=154
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="90">사업자등록번호</th>
						<td><comment id="_NSID_"> <object id=EM_SS_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img
							src="/<%=dir%>/imgs/btn/memo_regi_s.gif" onclick="gourl()"
							tabindex=1 onkeydown="if(event.keyCode==13){gourl()}"
							align="absmiddle"></td>
					</tr>
					<tr>
						<th width="90">법인명</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 onKeyUp="javascript:getCompCustId(event.keyCode);"
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'C')" /> <comment
							id="_NSID_"> <object id=EM_CUST_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=150 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script></td>
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
		<td class="sub_title PB02"><img
			src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
			align="absmiddle" class="PR03" /> 필수입력사항</td>
	</tr>
	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="90" class="point">사업자등록번호</th>
						<td width="310"><comment id="_NSID_"> <object
							id=EM_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1></object>
						</comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/modify_business_s.gif" id="IMG_SOCIALNUM"
							onclick="editSsno(EM_SS_NO)" tabindex=1
							onkeydown="if(event.keyCode==13){editSsno(EM_SS_NO)}"
							align="absmiddle"></td>
						<th width="90">카드번호</th>
						<td><img src="/<%=dir%>/imgs/btn/card_info_view_s.gif"
							id="IMG_CARDINFO" onclick="showCardInfo(EM_SS_NO)" tabindex=1
							onkeydown="if(event.keyCode==13){showCardInfo(EM_SS_NO)}"
							align="absmiddle"></td>
					</tr>
					<tr>
						<th class="point">사업자(단체)명</th>
						<td><comment id="_NSID_"> <object id=EM_CUST_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
							onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"></object>
						</comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/modify_cor_s.gif" id="IMG_MODIFY_NAME"
							onclick="editCustnm(EM_CUST_NAME)" tabindex=1
							onkeydown="if(event.keyCode==13){editCustnm(EM_CUST_NAME)}"
							align="absmiddle"> <comment id="_NSID_"> <object
							id=EM_CHKSAVE classid=<%=Util.CLSID_EMEDIT%> width=0
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_CUST_ID
							classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
							id=EM_HHOLD_ID classid=<%=Util.CLSID_EMEDIT%> width=0
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th class="point">카드비밀번호</th>
						<td><comment id="_NSID_"> <object id=EM_CARD_PWD_NO
							classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th class="point">대표자명</th>
						<td><comment id="_NSID_"> <object id=EM_REP_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
							onkeyup="javascript:checkByteStr(EM_REP_NAME, 40, '');">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>대표전화</th>
						<td><comment id="_NSID_"> <object id=EM_HOME_PH1
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_HOME_PH2
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_HOME_PH3
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">사업장주소</th>
						<td colspan="2"
							style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
							id="_NSID_"> <object id=EM_HOME_NEW_YN
							classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script><comment id="_NSID_"> <object
							id=EM_HOME_ZIP_CD1 classid=<%=Util.CLSID_EMEDIT%> width=30
							tabindex=1 align="absmiddle">
							<param name=MaxLength value=3>
						</object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
						<object id=EM_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> width=30
							tabindex=1 align="absmiddle">
							<param name=MaxLength value=3>
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/search_post_s.gif" tabindex=1
							onclick="getPostPop_dcs(EM_HOME_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HOME_ADDR1,EM_HOME_ADDR2,EM_HOME_NEW_YN)"
							onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_HOME_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HOME_ADDR1,EM_HOME_ADDR2,EM_HOME_NEW_YN)}"
							align="absmiddle"> <comment id="_NSID_"> <object
							id=EM_HOME_ADDR1 classid=<%=Util.CLSID_EMEDIT%> width=255
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<td style="border-left: 1px solid #fff; padding-left: 0"><comment
							id="_NSID_"> <object id=EM_HOME_ADDR2
							classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=1
							align="absmiddle"
							onkeyup="javascript:checkByteStr(EM_HOME_ADDR2, 200, '');"></object>
						</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
							id=EM_HOME_ZIP_SEQ classid=<%=Util.CLSID_EMEDIT%> width=0
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">담당자명</th>
						<td><comment id="_NSID_"> <object id=EM_OFFI_NM
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
							onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th class="point">담당자전화</th>
						<td><comment id="_NSID_"> <object id=EM_OFFI_PH1
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_OFFI_PH2
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_OFFI_PH3
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>FAX 번호</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_OFFI_FAX1 classid=<%=Util.CLSID_EMEDIT%> width=30
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>-
						<comment id="_NSID_"> <object id=EM_OFFI_FAX2
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
							id="_NSID_"> <object id=EM_OFFI_FAX3
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>이메일주소</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_EMAIL1 classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
							align="absmiddle"
							onkeyup="javascript:checkByteStr(EM_EMAIL1, 50, '');"></object> </comment>
						<script> _ws_(_NSID_);</script> @ <comment id="_NSID_">
						<object id=LC_EMAIL2 classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=120 align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> <object id=EM_EMAIL3
							classid=<%=Util.CLSID_EMEDIT%> width=127 tabindex=1
							align="absmiddle" style="display: hidden"
							onkeyup="javascript:checkByteStr(EM_EMAIL3, 50, '');"></object> </comment>
						<script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>문자수신</th>
						<td><comment id="_NSID_"> <object id=RD_SMS_YN
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^예,N^아니오">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th>이메일수신</th>
						<td><comment id="_NSID_"> <object id=RD_EMAIL_YN
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^예,N^아니오">
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
		<td class="sub_title PT07 PB02"><img
			src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
			align="absmiddle" class="PR03" /> 옵션</td>
	</tr>
	<tr>
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="90" class="point">회원등급</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=158
							align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script><comment
							id="_NSID_"> <object id=LC_VIP_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width=140 align="absmiddle"
							tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
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
<object id=BO_CUST classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_CUST>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=SS_NO                     ctrl=EM_SS_NO                   Param=Text</c>
            <c>col=CUST_NAME                 ctrl=EM_CUST_NAME               Param=Text</c>
            <c>col=CARD_PWD_NO               ctrl=EM_CARD_PWD_NO             Param=Text</c>
            <c>col=HOME_ZIP_CD1              ctrl=EM_HOME_ZIP_CD1            Param=Text</c>
            <c>col=HOME_ZIP_CD2              ctrl=EM_HOME_ZIP_CD2            Param=Text</c>
            <c>col=HOME_ADDR1                ctrl=EM_HOME_ADDR1              Param=Text</c>
            <c>col=HOME_ADDR2                ctrl=EM_HOME_ADDR2              Param=Text</c>
            <c>col=HOME_PH1                  ctrl=EM_HOME_PH1                Param=Text</c>
            <c>col=HOME_PH2                  ctrl=EM_HOME_PH2                Param=Text</c>
            <c>col=HOME_PH3                  ctrl=EM_HOME_PH3                Param=Text</c>
            <c>col=EMAIL1                    ctrl=EM_EMAIL1                  Param=Text</c>
            <c>col=EMAIL2                    ctrl=LC_EMAIL2                  Param=BindColVal</c>
            <c>col=EMAIL3                    ctrl=EM_EMAIL3                  Param=Text</c>
            <c>col=EMAIL_YN                  ctrl=RD_EMAIL_YN                Param=CodeValue</c>
            <c>col=SMS_YN                    ctrl=RD_SMS_YN                  Param=CodeValue</c>
            <c>col=OFFI_NM                   ctrl=EM_OFFI_NM                 Param=Text</c>
            <c>col=OFFI_PH1                  ctrl=EM_OFFI_PH1                Param=Text</c>
            <c>col=OFFI_PH2                  ctrl=EM_OFFI_PH2                Param=Text</c>
            <c>col=OFFI_PH3                  ctrl=EM_OFFI_PH3                Param=Text</c>
            <c>col=CHKSAVE                   ctrl=EM_CHKSAVE                 Param=Text</c>
            <c>col=CUST_ID                   ctrl=EM_CUST_ID                 Param=Text</c>
            <c>col=HHOLD_ID                  ctrl=EM_HHOLD_ID                Param=Text</c>
            <c>col=REP_NAME                  ctrl=EM_REP_NAME                Param=Text</c>
            <c>col=OFFI_FAX1                 ctrl=EM_OFFI_FAX1               Param=Text</c>
            <c>col=OFFI_FAX2                 ctrl=EM_OFFI_FAX2               Param=Text</c>
            <c>col=OFFI_FAX3                 ctrl=EM_OFFI_FAX3               Param=Text</c>
            <c>col=HOME_NEW_YN               ctrl=EM_HOME_NEW_YN             Param=Text</c>
            <c>col=CUST_GRADE                ctrl=LC_CUST_GRADE              Param=BindColVal</c>
            <c>col=VIP_FLAG                  ctrl=LC_VIP_FLAG                Param=BindColVal</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>
