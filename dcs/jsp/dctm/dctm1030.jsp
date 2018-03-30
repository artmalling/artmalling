<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 기명회원 가입 신청서 등록
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm1030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 기명회원 가입 신청서를 등록한다
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.02.12 (김영진) 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<OBJECT CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
    <PARAM NAME="LPKPath" VALUE="DemoCtl.LPK">
</OBJECT>
<OBJECT ID="IObjSafety"
         CLASSID="CLSID:4F992C2B-5E53-4DD7-9B4F-19635ADD9586"
         CODEBASE="DemoCtl.CAB#version=1,2,0,1">
</OBJECT>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strFlag = "INS";
var intAge  = 0;  //나이
var strToday   = "<%=toDate%>";
var strBeforeCustGrade = "";
var sel_FilterExpr     = "2";
var strBeforeCustGrade   = "";
var strBeforeCustGradeNm = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
    // 기명회원가입신청서 등록.
    DS_IO_CUST.setDataHeader  ('<gauce:dataset name="H_CUSTINFO"/>');
    DS_O_CARD.setDataHeader('<gauce:dataset name="H_CARD"/>');
    
    DS_IO_CUST.ClearData();
    DS_IO_CUST.AddRow();
    
    // EMedit에 초기화    
    initEmEdit(EM_CUST_NAME,    "GEN^40",     PK);           //성명
    initEmEdit(EM_CHKSAVE,      "GEN^1",      NORMAL);       //저장시에 I,U 구분.
    initEmEdit(EM_CUST_ID,      "GEN",        NORMAL);                                
    initEmEdit(EM_HHOLD_ID,     "GEN",        NORMAL);                                        
    initEmEdit(EM_SS_NO,        "000000", 	  PK);       //생년월일/사업자번호
    initEmEdit(EM_HOME_ADDR1,   "GEN^200",    PK);   
    initEmEdit(EM_HOME_ADDR2,   "GEN^200",    PK);
    initEmEdit(EM_CARD_NO,      "0000-0000-0000-0000", READ); //카드번호
    initEmEdit(EM_HOME_ZIP_CD1, "NUMBER^3^0", PK);
    initEmEdit(EM_HOME_ZIP_CD2, "NUMBER^3^0", PK);
    initEmEdit(EM_OFFI_ZIP_CD1, "NUMBER^3^0", NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD2, "NUMBER^3^0", NORMAL);
    initEmEdit(EM_EMAIL1,       "GEN^50",     NORMAL);
    initEmEdit(EM_EMAIL3,       "GEN^50",     NORMAL);
    initEmEdit(EM_CARD_PWD_NO,  "GEN^4",      NORMAL);         //카드비밀번호
    initEmEdit(EM_OFFI_ADDR1,   "GEN^200",    NORMAL);   
    initEmEdit(EM_OFFI_ADDR2,   "GEN^200",    NORMAL);
    initEmEdit(EM_HOME_PH1,     "0000",       NORMAL);
    initEmEdit(EM_HOME_PH2,     "0000",       NORMAL);
    initEmEdit(EM_HOME_PH3,     "0000",       NORMAL);
    initEmEdit(EM_MOBILE_PH1,   "0000",       PK);
    initEmEdit(EM_MOBILE_PH2,   "0000",       PK);
    initEmEdit(EM_MOBILE_PH3,   "0000",       PK);      
    initEmEdit(EM_WED_DT,       "YYYYMMDD",   NORMAL);
    initEmEdit(EM_BIRTH_DT,     "YYYYMMDD",   PK);
    initEmEdit(EM_OFFI_PH1,     "0000",       NORMAL);
    initEmEdit(EM_OFFI_PH2,     "0000",       NORMAL);
    initEmEdit(EM_OFFI_PH3,     "0000",       NORMAL);
    //initEmEdit(EM_CHILD_CNT,    "NUMBER^2^0", NORMAL);      
    initComboStyle(LC_EMAIL2,DS_O_EMAIL2, "CODE^0^30,NAME^0^110", 1, NORMAL);  //이메일주소목록
    initEmEdit(EM_OFFI_NM,      "GEN^40",     NORMAL);        //직장부서명
    //initEmEdit(EM_INCOME_AMT,   "NUMBER^5^0", NORMAL);        //월 평균소득
    //initEmEdit(EM_FAMILY_CNT,   "NUMBER^3^0", NORMAL);        //가족수
    initEmEdit(EM_DEPT_NAME,    "GEN^40",     NORMAL);        //부서
    initComboStyle(LC_POSITION,DS_O_POSITION, "CODE^0^30,NAME^0^110", 1, NORMAL);  //직위
    initEmEdit(EM_POSITION_ETC, "GEN^40",     NORMAL);        //직위 - 기타
    initEmEdit(EM_AGENT_NAME,   "GEN^40",     NORMAL);        //대리인성명
    initEmEdit(EM_AGENT_SSNO,   "000000-0000000",  NORMAL);   //대리인주민번호
    initComboStyle(LC_AGENT_RELATION,DS_O_AGENT_RELATION, "CODE^0^30,NAME^0^110", 1, NORMAL); //관계
    initEmEdit(EM_AGENT_PH1,    "0000",       NORMAL);        //대리인전화번호1
    initEmEdit(EM_AGENT_PH2,    "0000",       NORMAL);        //대리인전화번호2
    initEmEdit(EM_AGENT_PH3,    "0000",       NORMAL);        //대리인전화번호3
    initEmEdit(EM_LEGAL_AGENT,  "GEN^40",     NORMAL);        //법정대리인
    initEmEdit(EM_OFF_TERMS1_DT,"YYYYMMDD",   PK);            //정보제공 동의일자
    initEmEdit(EM_OFF_TERMS1_NAME,"GEN^40",   PK);            //정보제공 동의성명
    initEmEdit(EM_OFF_TERMS2_DT,  "YYYYMMDD", PK);            //개인정보 제3자 제공 동의일자
    initEmEdit(EM_OFF_TERMS2_NAME,"GEN^40",   PK);            //개인정보 제3자 제공 동의자
    initEmEdit(EM_ENTR_DT,        "YYYYMMDD", PK);            //가입일자
    initComboStyle(LC_ID_CHECK,DS_O_ID_CHECK, "CODE^0^30,NAME^0^110", 1, PK);  //신분증확인
    initEmEdit(EM_ISSUE_ORG,      "GEN^40",   PK);        //발행기관
    initEmEdit(EM_ISSUE_DT,       "YYYYMMDD", PK);        //발행일자
    
    initEmEdit(EM_HOME_NEW_YN,     "GEN^1",   NORMAL);        //집 - 구/신주소여부
    initEmEdit(EM_OFFI_NEW_YN,     "GEN^1",   NORMAL);        //회사 - 구/신주소여부
    initEmEdit(EM_NOCLS_REQ_YN,    "GEN^1",   NORMAL); 

    initComboStyle(LC_CUST_GRADE, DS_O_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
    initComboStyle(LC_VIP_FLAG,   DS_O_VIP_FLAG,   "CODE^0^30,NAME^0^110", 1, PK); //VIP등록구분
    initComboStyle(LC_POCARD_PREFIX,DS_O_POCARD_PREFIX, "CODE^0^30,NAME^0^110", 1, NORMAL);  //카드종류
    
    initEmEdit(EM_O_PUMBUN_CD,  "CODE^6^0", PK);  //품번코드(조회)
    initEmEdit(EM_O_PUMBUN_NM,  "GEN^40", READ);  //품번명(조회)
    initComboStyle(LC_CUST_TYPE,DS_O_CUST_TYPE, "CODE^0^30,NAME^0^110", 1, PK); //회원유형        
    
    EM_HOME_NEW_YN.style.display  = "none";
    EM_OFFI_NEW_YN.style.display  = "none";
    EM_EMAIL3.style.display       = "none";
    EM_NOCLS_REQ_YN.style.display = "none";
    
    EM_CHKSAVE.Visible  = "false";
    EM_CUST_ID.Visible  = "false";
    EM_HHOLD_ID.Visible = "false";
    EM_CHKSAVE.style.display  = "none";
    EM_CUST_ID.style.display  = "none";
    EM_HHOLD_ID.style.display = "none";
    EM_POSITION_ETC.style.display = "none";
    LC_VIP_FLAG.style.display     = "none";
    
    getEtcCode("DS_O_EMAIL2",     "D", "D013", "N");
    getEtcCode("DS_O_POSITION",   "D", "D045", "N");
    getEtcCode("DS_O_AGENT_RELATION", "D", "D042", "N");
    getEtcCode("DS_O_ID_CHECK",   "D", "D046", "N");
    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "N");
    getEtcCode("DS_O_VIP_FLAG",   "D", "D068", "N");
    getEtcCodeRefer("DS_O_POCARD_PREFIX", "D", "D104", "N");
    getEtcCode("DS_O_CUST_TYPE", "D", "D115", "N");

    RD_EMAIL_YN.CodeValue      = "N";
    RD_WED_YN.CodeValue        = "N";
    RD_LUNAR_FLAG.CodeValue    = "S";
    RD_SMS_YN.CodeValue        = "Y";
    RD_POST_RCV_CD.CodeValue   = "H";
    RD_HOUSE_FLAG.CodeValue    = "9";
    RD_HOUSE_TYPE.CodeValue    = "4";
    RD_ALIEN_YN.CodeValue      = "N";
    RD_NAME_CONF_YN.CodeValue  = "N";
    RD_SEX_CD.CodeValue		   = "F";

    EM_CHKSAVE.Text          = "I";
    LC_EMAIL2.BindColVal     = "99";
    LC_ID_CHECK.BindColVal   = "";
    LC_CUST_GRADE.BindColVal = "21"
    LC_POCARD_PREFIX.Index = 0;
    LC_CUST_TYPE.Index     = 0;
    
    EM_HOME_ZIP_CD1.Enable = false;
    EM_HOME_ZIP_CD2.Enable = false;
    EM_HOME_ADDR1.Enable   = false;
    EM_OFFI_ZIP_CD1.Enable = false;
    EM_OFFI_ZIP_CD2.Enable = false;
    EM_OFFI_ADDR1.Enable   = false;
    //직원기재란
    EM_ISSUE_ORG.Enable    = false;
    EM_ISSUE_DT.Enable     = false;
    enableControl(IMG_ISSUE_DT , false);
    //14세 미만시
    EM_AGENT_NAME.Enable     = false;
    EM_AGENT_SSNO.Enable     = false;
    LC_AGENT_RELATION.Enable = false;
    EM_AGENT_PH1.Enable      = false;
    EM_AGENT_PH2.Enable      = false;
    EM_AGENT_PH3.Enable      = false;
    EM_LEGAL_AGENT.Enable    = false;
    
    EM_HOME_ZIP_CD1.Alignment = 1;
    EM_HOME_ZIP_CD2.Alignment = 1;
    EM_OFFI_ZIP_CD1.Alignment = 1;
    EM_OFFI_ZIP_CD2.Alignment = 1;
    EM_SS_NO.Focus();
    
    //결혼여부에 의한 속성제어
    EM_WED_DT.Text      = "";  
    EM_OFF_TERMS1_DT.Text = "<%=toDate%>";
    EM_OFF_TERMS2_DT.Text = "<%=toDate%>";
    EM_ENTR_DT.Text       = "<%=toDate%>";
    EM_ISSUE_CNT.Text	= "1";
    setEnable(false);
    
    //cardPrint("1111-2222-3333-4444","김영진");
    
}

function gridCreate1(){
    var hdrProperies = '';                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 신규       - btn_New()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	strFlag  = "INS";
    strBeforeCustGrade   = "";
    strBeforeCustGradeNm = "";
    
    sel_FilterExpr = "2";
    DS_O_CUST_GRADE.Filter();
    
    var em = document.all.tags("object");
    if (em!=null){
      for (i = 0; i < em.length; i++) {
        
        if(em[i].classid=="<%=Util.CLSID_EMEDIT%>"){
        	em[i].Text = "";
        }
      }
    }
    doInit();
    //document.getElementById("FAVOR_DEPT1").checked = false;
    //document.getElementById("FAVOR_DEPT2").checked = false;
    //document.getElementById("FAVOR_DEPT3").checked = false;
    //document.getElementById("FAVOR_DEPT4").checked = false;
    //document.getElementById("FAVOR_DEPT5").checked = false;
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : DB에 저장
 * return값 : void
 */
function btn_Save() {

    if(trim(EM_CARD_NO.Text) != ""){
        //신규등록만 가능합니다.
        showMessage(EXCLAMATION, OK, "USER-1000", "신규등록만 가능합니다.");
        return false;
    }
    var chk;
    if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
      || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
        chk = juminCheck(EM_SS_NO.Text);
    }else{
        chk = juminCheckFore(EM_SS_NO.Text);
    }
    if(trim(EM_SS_NO.text).length == 6) chk = true;
    
    if(getAge(EM_SS_NO.Text, "<%=toDate%>") < 20){ //우리나라 20은 만나이 19와 같다
        showMessage(EXCLAMATION, OK, "USER-1003",  "19세 미만은 등록할 수 없습니다.");
        return false;
    }     

    if(LC_CUST_GRADE.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "회원등급");
        LC_CUST_GRADE.Focus();
        return false;    	
    }
    if(LC_CUST_TYPE.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "회원유형");
        LC_CUST_TYPE.Focus();
        return false;    	
    }    
    if(trim(EM_CUST_NAME.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_CUST_NAME.Focus();
        return false;
    }
    if(trim(EM_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "주민번호");
        EM_SS_NO.Focus();
        return false;
    }
    if(chk==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 주민번호가 아닙니다.");
        EM_SS_NO.Focus();
        return false;
    }
/*    
    if( trim(EM_CARD_PWD_NO.Text).length > 0 && trim(EM_CARD_PWD_NO.Text).length < 4){
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드비밀번호는 4자리입니다.");
        EM_CARD_PWD_NO.Focus();
        return false;
    }
*/    
    if(EM_CHKSAVE.Text == "I"){
        if(!isNumberStr(EM_CARD_PWD_NO.Text)){
            showMessage(EXCLAMATION, OK, "USER-1005",  "카드비밀번호");
            EM_CARD_PWD_NO.Focus();
            EM_CARD_PWD_NO.selectAll;
            return false;
        } 
    }else{
        if(!isNumberStr(EM_CARD_PWD_NO.Text) && EM_CARD_PWD_NO.Text != "****"){
            showMessage(EXCLAMATION, OK, "USER-1005",  "카드비밀번호");
            EM_CARD_PWD_NO.Focus();
            return false;
        } 
    }
    
    if(trim(EM_BIRTH_DT.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "본인생일");
        return false;
    }
    
    if(RD_SEX_CD.CodeValue == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성별구분");
        return false;
    }     
    
    if(EM_HOME_ZIP_CD1.text=="" || EM_HOME_ZIP_CD2.text == ""){     
        showMessage(EXCLAMATION, OK, "USER-1003",  "자택주소");
        getPostPop_dcs(EM_HOME_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HOME_ADDR1,EM_HOME_ADDR2,EM_HOME_NEW_YN);
        return false;
    }
    if(trim(EM_HOME_ADDR2.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "자택상세주소");
        EM_HOME_ADDR2.Focus();
        return false;
    }    
    
    if(trim(EM_MOBILE_PH1.text) == "" || trim(EM_MOBILE_PH2.text) == "" || trim(EM_MOBILE_PH3.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
        if(trim(EM_MOBILE_PH1.text) == ""){
            EM_MOBILE_PH1.Focus();
        }else if(trim(EM_MOBILE_PH2.text) == ""){
            EM_MOBILE_PH2.Focus();
        }else if(trim(EM_MOBILE_PH3.text) == ""){
            EM_MOBILE_PH3.Focus();
        }
        return false;
    }
    if(firstTelFormat(EM_MOBILE_PH1,"H")==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
        return false;
    }
    if(RD_EMAIL_YN.CodeValue == "Y" && trim(EM_EMAIL1.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "이메일 수신동의가 '예'일 경우 이메일 주소를 입력하셔야 합니다.");
        EM_EMAIL1.Focus();
        return;
    }
/*
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
    if(trim(EM_WED_DT.Text).length != 0){
        var strWedDt = EM_WED_DT.Text; 
        if(parseInt(strWedDt) > parseInt(strToday)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "미래일자는 입력할 수 없습니다.");
            EM_WED_DT.Focus();
            return false;
        }
    }
    if(LC_POSITION.BindColVal == "99" && trim(EM_POSITION_ETC.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "기타직위");
        EM_POSITION_ETC.Focus();
        return false;
    }
    if(trim(EM_OFFI_PH1.text) != "" && (trim(EM_OFFI_PH2.text) == "" || trim(EM_OFFI_PH3.text) == "")
    || trim(EM_OFFI_PH2.text) != "" && (trim(EM_OFFI_PH1.text) == "" || trim(EM_OFFI_PH3.text) == "")
    || trim(EM_OFFI_PH3.text) != "" && (trim(EM_OFFI_PH1.text) == "" || trim(EM_OFFI_PH2.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1000",  "직장전화를  정확히 입력하세요.");
        if(trim(EM_OFFI_PH1.text) == ""){
            EM_OFFI_PH1.Focus();
        }else if(trim(EM_OFFI_PH2.text) == ""){
            EM_OFFI_PH2.Focus();
        }else if(trim(EM_OFFI_PH3.text) == ""){
            EM_OFFI_PH3.Focus();
        }
        return false;
    }
    if(RD_POST_RCV_CD.CodeValue == "O"){
        if(EM_OFFI_ZIP_CD1.text=="" || EM_OFFI_ZIP_CD2.text == ""){       
            showMessage(EXCLAMATION, OK, "USER-1003",  "직장주소");
            getPostPop_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN);
            return false;
        }
        if(trim(EM_OFFI_ADDR2.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "직장상세주소");
            EM_OFFI_ADDR2.Focus();
            return false;
        }
    }

    if(intAge < 14){
        if(trim(EM_AGENT_NAME.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "이름");
            EM_AGENT_NAME.Focus();
            return false;
        }
        if(trim(EM_AGENT_SSNO.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "주민등록번호");
            EM_AGENT_SSNO.Focus();
            return false;
        }
        if(trim(LC_AGENT_RELATION.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1002",  "관계");
            LC_AGENT_RELATION.Focus();
            return false;
        }
        if(trim(EM_AGENT_PH1.text) != "" && (trim(EM_AGENT_PH2.text) == "" || trim(EM_AGENT_PH3.text) == "")
        || trim(EM_AGENT_PH2.text) != "" && (trim(EM_AGENT_PH1.text) == "" || trim(EM_AGENT_PH3.text) == "")
        || trim(EM_AGENT_PH3.text) != "" && (trim(EM_AGENT_PH1.text) == "" || trim(EM_AGENT_PH2.text) == "")){
            showMessage(EXCLAMATION, OK, "USER-1000",  "전화번호를  정확히 입력하세요.");
            if(trim(EM_AGENT_PH1.text) == ""){
                EM_AGENT_PH1.Focus();
            }else if(trim(EM_AGENT_PH2.text) == ""){
                EM_AGENT_PH2.Focus();
            }else if(trim(EM_AGENT_PH3.text) == ""){
                EM_AGENT_PH3.Focus();
            }
            return false;
        }
        if(trim(EM_LEGAL_AGENT.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "법정대리인");
            EM_LEGAL_AGENT.Focus();
            return false;
        }
    }
*/    
    if(trim(EM_OFF_TERMS1_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의일자");
        EM_OFF_TERMS1_DT.Focus();
        return false;
    }
    if(trim(EM_OFF_TERMS1_NAME.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_OFF_TERMS1_NAME.Focus();
        return false;
    }
    
    if(trim(EM_OFF_TERMS2_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "동의일자");
        EM_OFF_TERMS2_DT.Focus();
        return false;
    }
    if(trim(EM_OFF_TERMS2_NAME.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
        EM_OFF_TERMS2_NAME.Focus();
        return false;
    }
    
    if(trim(EM_ENTR_DT.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가입일자");
        EM_ENTR_DT.Focus();
        return false;
    }

    if(trim(LC_ID_CHECK.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "신분증확인");
        LC_ID_CHECK.Focus();
        return false;
    }
    
    if(LC_ID_CHECK.BindColVal != "9"){
        if(trim(EM_ISSUE_ORG.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "발행기관");
            EM_ISSUE_ORG.Focus();
            return false;
        }
        if(trim(EM_ISSUE_DT.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1003",  "발행일자");
            EM_ISSUE_DT.Focus();
            return false;
        }
        var strIssueDt = EM_ISSUE_DT.Text; 
        if(parseInt(strIssueDt) > parseInt(strToday)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "미래일자는 입력할 수 없습니다.");
            EM_ISSUE_DT.Focus();
            return false;
        }
    }
/*
    if(LC_CUST_GRADE.BindColVal == "41" && trim(LC_VIP_FLAG.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "VIP등록구분");
        LC_VIP_FLAG.Focus();
        return false;
    }
*/
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
 * saveData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-12
 * 개       요 : 기명회원가입신청서 등록 저장
 * return값 : void
 */
function saveData(){

	//var strFavorDept1YN = (document.getElementById("FAVOR_DEPT1").checked == true)? "Y":"N";
    //var strFavorDept2YN = (document.getElementById("FAVOR_DEPT2").checked == true)? "Y":"N";
    //var strFavorDept3YN = (document.getElementById("FAVOR_DEPT3").checked == true)? "Y":"N";
    //var strFavorDept4YN = (document.getElementById("FAVOR_DEPT4").checked == true)? "Y":"N";
    //var strFavorDept5YN = (document.getElementById("FAVOR_DEPT5").checked == true)? "Y":"N";
    
    var strFavorDept1YN = "N";
    var strFavorDept2YN = "N";
    var strFavorDept3YN = "N";
    var strFavorDept4YN = "N";
    var strFavorDept5YN = "N";
    
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT1_YN")  = strFavorDept1YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT2_YN")  = strFavorDept2YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT3_YN")  = strFavorDept3YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT4_YN")  = strFavorDept4YN;  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT5_YN")  = strFavorDept5YN;  

    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "COMP_PERS_FLAG")  = "P";                   // 법인/개인구분
    if(EM_NOCLS_REQ_YN.Text == ""){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "NOCLS_REQ_YN")= "Y";                   // 클랜징미적용요청여부
    }
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HOME_CLS_YN")     = "Y";                   // 클렌징 여부
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_FAX1")       = "";
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_FAX2")       = "";
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_FAX3")       = "";
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_INTER_PH")   = "";
    if(LC_EMAIL2.BindColVal == "99"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = EM_EMAIL3.Text;
    }else{
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = LC_EMAIL2.Text;
    }
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "<%=toDate%>";          // 등록일자           
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SMS_AGREE_DT")   = "<%=toDate%>";                                                                     
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OFFI_CLS_YN")    = "Y";                    //오피스주소클랜징여부
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCOMP_EMP_YN")   = "N";                    //계열사직원여부                    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_STAT_FLAG") = "0";                    //회원상태
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "WEB_USER_ID")    = "";                     
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "WEB_PASSWD")     = "";                     
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "I_PIN")          = "";                     //아이핀가입
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "ENTR_PATH")      = "";   
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCED_REQ_DT")    = "";                     //탈퇴요청일
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCED_TAKE_FLAG") = "";  
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "SCED_PROC_DT")   = ""; 
    
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HOLD_CAR_YN")  = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "INCOME_AMT")   = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAMILY_CNT")   = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CHILD_CNT")    = ""; 
    
    var strAlienYN = "";
    if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
    || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){ 
        strAlienYN = "N";
    }else{
        strAlienYN = "Y";
    }
    if(trim(EM_SS_NO.text).length == 6) strAlienYN = "N";
    	
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "ALIEN_YN")       = strAlienYN;         //외국인여부
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HORI_ADDR1")     = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "HORI_ADDR2")     = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OORI_ADDR1")     = ""; 
    DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "OORI_ADDR2")     = "";

    var strChksave = EM_CHKSAVE.Text;
    var parameters = "&strChksave="+ encodeURIComponent(strChksave)
                   + "&strAge="    + encodeURIComponent(intAge)
                   + "&strUpdate=N";

    TR_MAIN.Action="/dcs/dctm103.dm?goTo=saveData"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CUST=DS_IO_CUST)";
    TR_MAIN.Post();  

}

/**
 * showMaster()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-14
 * 개      요  : 주민번호로 회원정보를 가져온다.
 * return값 : void
 */
function showMaster(){
	if(trim(EM_SS_NO.text).length == 6 && 
			(trim(EM_MOBILE_PH1.text) == "" || trim(EM_MOBILE_PH2.text) == "" || trim(EM_MOBILE_PH3.text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1003",  "휴대전화");
        return false;
    }	 
	 
	var vPoCardPrefix = LC_POCARD_PREFIX.BindColVal;
	EM_EMAIL3.text = ""; 
	strBeforeCustGrade   = "";
	strBeforeCustGradeNm = "";
	
    sel_FilterExpr = "2";
    DS_O_CUST_GRADE.Filter();
    
    var strSsno    = EM_SS_NO.text;

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strSsno="+encodeURIComponent(strSsno)
				   + "&strMobilePh1="+encodeURIComponent(EM_MOBILE_PH1.Text)
				   + "&strMobilePh2="+encodeURIComponent(EM_MOBILE_PH2.Text)
				   + "&strMobilePh3="+encodeURIComponent(EM_MOBILE_PH3.Text);
    
    TR_MAIN.Action ="/dcs/dctm103.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CUST=DS_IO_CUST)"; //조회는 O
    TR_MAIN.Post();
    
    //정보 유 Focus:카드, 비밀번호 무:내국인/외국인
    if(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_NAME") != ""){
        setTimeout( "EM_CARD_PWD_NO.Focus();",50);
    }else{
        EM_CUST_NAME.Focus();
    }

    var strFavorDept1YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT1_YN");
    var strFavorDept2YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT2_YN");
    var strFavorDept3YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT3_YN");
    var strFavorDept4YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT4_YN");
    var strFavorDept5YN = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "FAVOR_DEPT5_YN");
    
    if(EM_CHKSAVE.Text=="U"){
    	strFlag = "UPD";
        EM_CUST_NAME.Enable = "false";
        EM_SS_NO.Enable     = "false";
        if(EM_CARD_PWD_NO.Text!=""){
            EM_CARD_PWD_NO.Text = "****";
        }
        strBeforeCustGrade   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"CUST_GRADE");
        strBeforeCustGradeNm = LC_CUST_GRADE.Text;
    }
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Text   = DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2");
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", EM_EMAIL3.Text);
    }
    if(strFlag == "UPD" && (LC_EMAIL2.BindColVal == "" || LC_EMAIL2.BindColVal == "99")){
        setComboData(LC_EMAIL2,"99");
        EM_EMAIL3.style.display = "";
    }else if (LC_EMAIL2.BindColVal == "" || LC_EMAIL2.BindColVal == "99"){
    	setComboData(LC_EMAIL2,"99");
        EM_EMAIL3.style.display = "";
    }else{
        EM_EMAIL3.Text = ""; 
        EM_EMAIL3.style.display = "none";
    }
    if(RD_WED_YN.CodeValue=="Y"){
        setEnable(true);
    }
    LC_POCARD_PREFIX.BindColVal = vPoCardPrefix;
    /*
    if(strFavorDept1YN == "Y") document.getElementById("FAVOR_DEPT1").checked = true;
    if(strFavorDept2YN == "Y") document.getElementById("FAVOR_DEPT2").checked = true;
    if(strFavorDept3YN == "Y") document.getElementById("FAVOR_DEPT3").checked = true;
    if(strFavorDept4YN == "Y") document.getElementById("FAVOR_DEPT4").checked = true;
    if(strFavorDept5YN == "Y") document.getElementById("FAVOR_DEPT5").checked = true;
    */
    if(EM_EMAIL3.Text == "99") EM_EMAIL3.Text = "";
    if(EM_ISSUE_CNT.Text == "0") EM_ISSUE_CNT.Text	= "1";
    
    document.getElementById('IMG_REAL_NAME').focus();
}

/**
 * popCardInfo()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-17
 * 개       요 : 회원저장후에 카드정보 보여주는 팝업
 * return값 : void
 */
function popCardInfo(str1,str2,str3){

    var rtnMap  = new Map();
    var arrArg  = new Array();
    arrArg.push(rtnMap);
    arrArg.push(EM_CUST_ID.Text);
    arrArg.push(EM_CUST_NAME.Text);
    arrArg.push(EM_CARD_NO.Text);
    arrArg.push(EM_SS_NO.Text);
    var returnVal = window.showModalDialog("/dcs/dctm103.dm?goTo=popCard",
    		                               arrArg,
                                           "dialogWidth:540px;dialogHeight:134px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map   = arrArg[0];
        var strCustNm = map.get("CUST_BUSI_NM1");
        var strCardNo = map.get("CARD_NO1");
        var strSsNo   = map.get("SSNO_BUSI_NO1");
        var strCustId = map.get("CUST_ID1");
        
        //세대관리화면이동
    	try{
    		frame01 = window.external.GetFrame(window);
    		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
    	} catch(e){		
    	}	     
    	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM106","/dcs/dctm106.dm?goTo=list"+"&strCardno="+strCardNo+"&strSsno="+strSsNo+"&strCustid="+strCustId,"DCTM","01","세대관리");
    }
}

/**
* setEnable(flag)
* 작 성 자 : 김영진
* 작 성 일 : 2010-03-30
* 개      요  : 결혼여부에 인한 Enable 변경
* return값 : void
*/
function setEnable(flag){
    enableControl(IMG_WED_DT , flag);
    EM_WED_DT.Enable = flag;  
}


/**
* cardPrint(cardno,name, img1, img2){
* 작 성 자 : 김영진
* 작 성 일 : 2010-05-19
* 개      요  : 카드 출력
* return값 : void
*/
function cardPrint(cardno,name){

    //var localPath = "C:\\Program Files\\Datacard Card Printers\\"; //C:\\CARD_PRINT\\
    var cardno1=cardno.substring(0,4);
    var cardno2=cardno.substring(5,9);
    var cardno3=cardno.substring(10,13);
    var cardno4=cardno.substring(15,18);
    //alert(cardno4);
    IObjSafety.TextLine (1, cardno1 +" " + cardno2 +" " + cardno3 +" " + cardno4,  "Arial", 11, 70, 440, "True"); /*SIZE :11 LEFT :70 TOP :440 TRUE : 진하게*/
    IObjSafety.TextLine (2, name, "HY견고딕", 10, 550, 445, "True"); 

    IObjSafety.PrintCard("Smart Driver","222",cardno1 + cardno2 + cardno3 + cardno4,"333");        

}

/**
* confirmName()
* 작 성 자 : 강진
* 작 성 일 : 2012. 05. 08
* 개       요 : 실명확인
* return값 : void
*/
function confirmName() {

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(EM_SS_NO.Text);
	arrArg.push(EM_CUST_NAME.Text);
	arrArg.push(EM_CUST_ID.Text);

	var returnVal = window.showModalDialog("/dcs/dctm102.dm?goTo=confRealName",
					arrArg,
		            "dialogWidth:278px;dialogHeight:115px;scroll:no;" +
		            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
           
  	if (returnVal){
		var map = arrArg[0];
		RD_NAME_CONF_YN.CodeValue = map.get("CONF_YN");			
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
        //저장하고 난 다음 카드 번호띠우기.
        var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|');
        EM_CUST_ID.Text  = strMsg[0]; 
        EM_HHOLD_ID.Text = strMsg[1]; 
        EM_CARD_NO.Text  = strMsg[2];
		if(EM_CARD_NO.Text!=""){
		  popCardInfo(EM_CUST_NAME.Text,EM_SS_NO.Text,'');
		  //cardPrint(EM_CARD_NO.Text,EM_CUST_NAME.Text)
		}
		EM_CHKSAVE.Text = "U";
	    EM_CUST_NAME.Enable = false;
	    EM_SS_NO.Enable     = false;
	    if(EM_EMAIL1.Text != ""){
            LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
        }
        if( LC_EMAIL2.BindColVal == "" ){
            setComboData(LC_EMAIL2,"99");
        }
	    DS_IO_CUST.ResetStatus();
	    EM_CARD_PWD_NO.Focus();
    }    
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
    }
    if( LC_EMAIL2.BindColVal == "" ){
        setComboData(LC_EMAIL2,"99");
    }
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_CUST_GRADE event=onFilter(row)>
    switch (sel_FilterExpr) {
    case "1":
        return true;
        break;
    case "2":
        if (DS_O_CUST_GRADE.NameValue(row,"CODE") != "11") return true
        else return false;
        break;
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 자택전화 onKillFocus()-->
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
<!-- 이동전화 onKillFocus()-->
<script language=JavaScript for=EM_MOBILE_PH1 event=onKillFocus()>
    if(trim(EM_MOBILE_PH1.Text).length != 0){
        if(firstTelFormat(EM_MOBILE_PH1,"H")==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_MOBILE_PH1.Text = ""
            setTimeout( "EM_MOBILE_PH1.Focus();",50);
            return false;
        }
    }
</script>
<!-- 휴대전화 onKeyUp()()-->
<script language=JavaScript for=EM_MOBILE_PH1 event=onKeyUp()>
	if(trim(EM_MOBILE_PH1.Text).length == 3){
    	setTimeout( "EM_MOBILE_PH2.Focus();",50);
    }
</script>
<!-- 휴대전화 onKeyUp()-->
<script language=JavaScript for=EM_MOBILE_PH2 event=onKeyUp()>
    if(trim(EM_MOBILE_PH2.Text).length == 4){
    	setTimeout( "EM_MOBILE_PH3.Focus();",50);
    }
</script>
<!-- 휴대전화 onKeyUp()-->
<script language=JavaScript for=EM_MOBILE_PH3 event=onKeyUp()>
    if(trim(EM_MOBILE_PH3.Text).length == 4){
        //setTimeout( "EM_SS_NO.Focus();",50);
    }
</script>
<!-- 직장전화 onKillFocus()-->
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
<!-- 법정대리인 전화번호 onKillFocus()-->
<script language=JavaScript for=EM_AGENT_PH1 event=onKillFocus()>
    if(trim(EM_AGENT_PH1.Text).length != 0){
        if(firstTelFormatAll(EM_AGENT_PH1)==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 번호가 아닙니다.");
            EM_AGENT_PH1.Text = ""
            setTimeout( "EM_AGENT_PH1.Focus();",50);
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
<!-- 직위 OnSelChange() -->
<script language=JavaScript for=LC_POSITION event=OnSelChange()>
    if(LC_POSITION.BindColVal == "99"){
        EM_POSITION_ETC.style.display = "";
    }else{
        EM_POSITION_ETC.style.display = "none";
    }   
</script>

<!-- 회원등급 OnSelChange() -->
<script language=JavaScript for=LC_CUST_GRADE event=OnSelChange()>
    //기존등급 => 등급변경시  QUESTION
    if( strFlag != "INS" && DS_IO_CUST.IsUpdated && strBeforeCustGradeNm != ""){
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

<!-- 주민등록번호  onKillFocus() -->
<script language=JavaScript for=EM_SS_NO event=onKillFocus()>
    if(trim(EM_SS_NO.Text).length != 0){
        var chk;
        if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2" 
          || EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
            chk = juminCheck(EM_SS_NO.Text);
        }else{
            chk = juminCheckFore(EM_SS_NO.Text);
        }
        if(trim(EM_SS_NO.text).length == 6) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 주민번호가 아닙니다.");
            EM_SS_NO.Text = "";
            setTimeout( "EM_SS_NO.Focus();",50);
            return false;
        }

        //생년월일 기본 세팅.
        if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2"){
            EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
        }else if(EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
            EM_BIRTH_DT.Text = "20"+EM_SS_NO.Text.substring(0,6);
        }
        if(trim(EM_SS_NO.text).length == 6) EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
        
		//성별 기본 세팅.
		if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="3"
		 || EM_SS_NO.Text.substring(6,7)=="5" || EM_SS_NO.Text.substring(6,7)=="7"){
			RD_SEX_CD.CodeValue = "M";
		}else{
			RD_SEX_CD.CodeValue = "F";
		}
		if(trim(EM_SS_NO.text).length == 6) RD_SEX_CD.CodeValue = "";        

        if(!showMaster()) {
            if(trim(EM_MOBILE_PH1.text) == ""){
            	setTimeout("EM_MOBILE_PH1.Focus();",50);
            }else if(trim(EM_MOBILE_PH2.text) == ""){
            	setTimeout("EM_MOBILE_PH2.Focus();",50);
            }else if(trim(EM_MOBILE_PH3.text) == ""){
            	setTimeout("EM_MOBILE_PH3.Focus();",50);
            }  
            return;
        }
        
        if(trim(DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"SCED_REQ_DT")) != ""){
        	showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 카드발급이 불가합니다.");
        	btn_New();
            setTimeout("EM_AGENT_SSNO.Focus();",50);
            return false;
        }

        //미성년자 여부 확인
        intAge = getAge(EM_SS_NO.Text, "<%=toDate%>");
        if(intAge < 14){
        	sel_FilterExpr = "1";
            DS_O_CUST_GRADE.Filter();
            EM_AGENT_NAME.Enable     = true;
            EM_AGENT_SSNO.Enable     = true;
            LC_AGENT_RELATION.Enable = true;
            EM_AGENT_PH1.Enable      = true;
            EM_AGENT_PH2.Enable      = true;
            EM_AGENT_PH3.Enable      = true;
            EM_LEGAL_AGENT.Enable    = true;
            LC_CUST_GRADE.BindColVal = "11";
            LC_CUST_GRADE.Enable     = false;
        }else{
            EM_AGENT_NAME.Enable     = false;
            EM_AGENT_SSNO.Enable     = false;
            LC_AGENT_RELATION.Enable = false;
            EM_AGENT_PH1.Enable      = false;
            EM_AGENT_PH2.Enable      = false;
            EM_AGENT_PH3.Enable      = false;
            EM_LEGAL_AGENT.Enable    = false;
            LC_CUST_GRADE.Enable     = true;
        }
    }
    	
</script>
<!-- 미성년자 법정대리인주민등록번호  onKillFocus() -->
<script language=JavaScript for=EM_AGENT_SSNO event=onKillFocus()>
    if(trim(EM_AGENT_SSNO.Text).length != 0){
        var chk;
        if(EM_AGENT_SSNO.Text.substring(6,7)=="1" || EM_AGENT_SSNO.Text.substring(6,7)=="2" 
          || EM_AGENT_SSNO.Text.substring(6,7)=="3" || EM_AGENT_SSNO.Text.substring(6,7)=="4"){
            chk = juminCheck(EM_AGENT_SSNO.Text);
        }else{
            chk = juminCheckFore(EM_AGENT_SSNO.Text);
        }
        if(trim(EM_AGENT_SSNO.text).length == 6) chk = true;
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 주민등록번호가 아닙니다.");
            EM_AGENT_SSNO.Text = "";
            setTimeout( "EM_AGENT_SSNO.Focus();",50);
            return false;
        }
    }
</script>

<!-- 이름자동 설정  onKillFocus() -->
<script language=JavaScript for=EM_CUST_NAME event=onKillFocus()>
    EM_OFF_TERMS1_NAME.Text = this.Text;
    EM_OFF_TERMS2_NAME.Text = this.Text;
</script>

<script language=JavaScript for=RD_WED_YN event=OnSelChange()>
    if(RD_WED_YN.CodeValue=="Y"){
    	setEnable(true);
    }else{
    	setEnable(false);
        EM_WED_DT.Text = "";
    }
</script>

<!-- 본인생일  onKillFocus() -->
<script language=JavaScript for=EM_BIRTH_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_BIRTH_DT)){
        //생년월일 기본 세팅.
        if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2"){
            EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
        }else if(EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
            EM_BIRTH_DT.Text = "20"+EM_SS_NO.Text.substring(0,6);
        }
        if(trim(EM_SS_NO.text).length == 6) EM_BIRTH_DT.Text = "19"+EM_SS_NO.Text.substring(0,6);
    }
</script>
<!-- 결혼기념일  onKillFocus() -->
<script language=JavaScript for=EM_WED_DT event=onKillFocus()>
    checkDateTypeYMD(EM_WED_DT);
</script>
<!-- 정보 제공 및 활용 동의일자  onKillFocus() -->
<script language=JavaScript for=EM_OFF_TERMS1_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OFF_TERMS1_DT);
</script>
<!-- 개인정보 제3자 제공 동의일자  onKillFocus() -->
<script language=JavaScript for=EM_OFF_TERMS2_DT event=onKillFocus()>
    checkDateTypeYMD(EM_OFF_TERMS2_DT);
</script>
<!-- 가입일자  onKillFocus() -->
<script language=JavaScript for=EM_ENTR_DT event=onKillFocus()>
    checkDateTypeYMD(EM_ENTR_DT);
</script>
<!-- 발행일자  onKillFocus() -->
<script language=JavaScript for=EM_ISSUE_DT event=onKillFocus()>
    checkDateTypeYMD(EM_ISSUE_DT);
</script>

<!-- 신분증확인 OnSelChange() -->
<script language=JavaScript for=LC_ID_CHECK event=OnSelChange()>
    if(LC_ID_CHECK.BindColVal == "9"){
        EM_ISSUE_ORG.Enable = false;
        EM_ISSUE_DT.Enable  = false;
        enableControl(IMG_ISSUE_DT , false);
        EM_ISSUE_ORG.Text = "";
        EM_ISSUE_DT.Text  = "";
        
    }else{
        EM_ISSUE_ORG.Enable = true;
        EM_ISSUE_DT.Enable  = true;
        enableControl(IMG_ISSUE_DT , true);
    }
</script>
<script language=JavaScript for=DS_O_POCARD_PREFIX event=OnFilter(row)>


	if (DS_O_POCARD_PREFIX.NameValue(row,"REFER_CODE") == "0") return true
	else return false;


</script>

<!-- 품번(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	    
	if(this.text==''){
		EM_O_PUMBUN_NM.Text = "";
	    return;
	}      
    setPumbunCdCombo("NAME");
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
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CUST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_">
<object id="DS_O_EMAIL2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CARD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_POSITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AGENT_RELATION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ID_CHECK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="Filter_s1.csv">
    <param name=UseFilter   value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_VIP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_POCARD_PREFIX" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter	value=true></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUST_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
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
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<!--공통 타이틀/버튼 -->
	<%@ include file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 // -->
	<div id="testdiv" class="testdiv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90">카드번호</th>
							<td width="310"><comment id="_NSID_"> <object id=EM_CARD_NO
								classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1> </object> </comment>
							<script> _ws_(_NSID_);</script></td>
							
						</tr>
						<tr>
							<th width="90">패밀리카드구분</th>
							<td><comment id="_NSID_"> <object
								id=LC_POCARD_PREFIX classid=<%=Util.CLSID_LUXECOMBO%> width=130
								tabindex=1 onClick="DS_O_POCARD_PREFIX.Filter()"> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
							<th width="90">카드비밀번호</th>
							<td><comment id="_NSID_"> <object
								id=EM_CARD_PWD_NO classid=<%=Util.CLSID_EMEDIT%> width=40
								tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
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
                align="absmiddle" class="PR03" /> 신청자정보</td>
        </tr>
        <tr>
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"
                        class="s_table">
                        <tr>
                            <th class="point">성명</th>
                            <td width="310"><comment id="_NSID_"> <object
                                id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
                                tabindex=5
                                onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                                id="_NSID_"> <object id=EM_CHKSAVE
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
                            <object id=EM_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=0
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                                id="_NSID_"> <object id=EM_HHOLD_ID
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90" class="point">주민번호</th>
                            <td><comment id="_NSID_"> <object id=EM_SS_NO
                                classid=<%=Util.CLSID_EMEDIT%> width=154 align="absmiddle"
                                tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
                                <img src="/<%=dir%>/imgs/btn/real_name.gif" tabindex=5 id="IMG_REAL_NAME"
								onkeydown="if(event.keyCode==13) confirmName()"  
								onclick="javascript:confirmName()" align="absmiddle" ></td>
                        </tr>
                        <tr>
                            <th width="90" class="point">본인생일</th>
                            <td><comment id="_NSID_"> <object id=EM_BIRTH_DT
                                classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle"
                                tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
                                src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                onclick="javascript:openCal('G',EM_BIRTH_DT)" /></td>
                            <th class="point">휴대전화</th>
                            <td><comment id="_NSID_"> <object id=EM_MOBILE_PH1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_MOBILE_PH2
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_MOBILE_PH3
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>                                        
                            <th>생일 구분</th>
                            <td><comment id="_NSID_"><object id=RD_LUNAR_FLAG
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
                                align="absmiddle" tabindex=5>
                                <param name=Cols value="2">
                                <param name=Format value="S^양력,L^음력">
                                <param name="AutoMargin" value="true">
                                <param name=CodeValue value="S">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
							<th>실명인증여부</th>
							<td><comment id="_NSID_"><object id=RD_NAME_CONF_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="N^미인증,Y^인증">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="N">
							</object> </comment> <script> _ws_(_NSID_);</script></td>                         
                        </tr>
                        <tr>
							<th>성별 구분</th>
							<td><comment id="_NSID_"><object id=RD_SEX_CD
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="M^남자,F^여자">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="F">
							</object> </comment> <script> _ws_(_NSID_);</script></td>                        
							<th>외국인정보</th>
							<td><comment id="_NSID_"><object id=RD_ALIEN_YN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="N^내국인,Y^외국인">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="Y">
							</object> </comment> <script> _ws_(_NSID_);</script></td>                           
                        </tr>
                        <tr>
                            <th>자택전화</th>
                            <td><comment id="_NSID_"> <object id=EM_HOME_PH1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_HOME_PH2
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_HOME_PH3
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th>SMS 수신동의</th>
                            <td><comment id="_NSID_"> <object id=RD_SMS_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=5>
                                <param name=Cols value="2">
                                <param name=Format value="Y^예,N^아니오">
                                <param name="AutoMargin" value="true">
                                <param name=CodeValue value="Y">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>                                                        
                        </tr>                    
                        <tr>
                            <th class="point">자택주소</th>
                            <td colspan="2"
                                style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_HOME_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_HOME_ZIP_CD1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
                            <object id=EM_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
                                width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif"
                                onclick="getPostPop_dcs(EM_HOME_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HOME_ADDR1,EM_HOME_ADDR2,EM_HOME_NEW_YN)"
                                align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR"
                                onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_HOME_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HOME_ADDR1,EM_HOME_ADDR2,EM_HOME_NEW_YN)}">
                            <comment id="_NSID_"> <object id=EM_HOME_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=255 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_HOME_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_HOME_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
						<tr>
							<th>카드발급횟수</th>
							<td><comment id="_NSID_"><object id=EM_ISSUE_CNT classid=<%=Util.CLSID_EMEDIT%> width=30
                                tabindex=5 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th>우편물 수령동의</th>
                            <td><comment id="_NSID_"> <object
                                id=RD_POST_RCV_CD classid=<%=Util.CLSID_RADIO%>
                                style="height: 20; width: 120" tabindex=5>
                                <param name=Cols value="2">
                                <param name=Format value="H^예,O^아니오">
                                <param name="AutoMargin" value="true">
                                <param name=CodeValue value="H">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>                                							
						</tr>
                        <tr>
                            <th>이메일주소</th>
                            <td><comment id="_NSID_"> <object id=EM_EMAIL1
                                classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=5
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_EMAIL1, 50, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script> @ <comment id="_NSID_">
                            <object id=LC_EMAIL2 classid=<%=Util.CLSID_LUXECOMBO%> height=100
                                width=105 align="absmiddle" tabindex=5> </object> </comment> <script> _ws_(_NSID_);</script>
                            <comment id="_NSID_"> <object id=EM_EMAIL3
                                classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=5
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_EMAIL3, 50, '');"
                                style="display: hidden"></object> </comment> <script> _ws_(_NSID_);</script>
                            </td>
                            <th>이메일 수신동의</th>
                            <td><comment id="_NSID_"> <object id=RD_EMAIL_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=5>
                                <param name=Cols value="2">
                                <param name=Format value="Y^예,N^아니오">
                                <param name="AutoMargin" value="true">
                                <param name=CodeValue value="Y">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
						<tr>
							<th class="point">회원등급</th>
							<td><comment id="_NSID_"> <object
								id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script><comment
								id="_NSID_"> <object id=LC_VIP_FLAG
								classid=<%=Util.CLSID_LUXECOMBO%> width=140 align="absmiddle"
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>
							<th class="point">회원유형</th>
							<td><comment id="_NSID_"> <object
								id=LC_CUST_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
							</td>	
						</tr>                                                  
                        <tr style="display:none">
                            <th width="90">결혼여부</th>
                            <td><comment id="_NSID_"> <object id=RD_WED_YN
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
                                tabindex=5>
                                <param name=Cols value="2">
                                <param name=Format value="N^미혼,Y^기혼">
                                <param name="AutoMargin" value="true">
                                <param name=CodeValue value="N">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90">결혼 기념일</th>
                            <td><comment id="_NSID_"> <object id=EM_WED_DT
                                classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
                                tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
                                src="/<%=dir%>/imgs/btn/date.gif" id="IMG_WED_DT"
                                align="absmiddle" onclick="javascript:openCal('G',EM_WED_DT)" /></td>
                        </tr>
                        <tr style="display:none">
                            <th width="90">주거형태</th>
                            <td><comment id="_NSID_"> <object id=RD_HOUSE_TYPE
                                classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 250"
                                tabindex=5>
                                <param name=Cols value="4">
                                <param name="AutoMargin" value="true">
                                <param name=Format value="1^APT,2^단독,3^연립,4^기타">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
                           <th width="90">주거구분</th>
                            <td><comment id="_NSID_"> <object
                                id=RD_HOUSE_FLAG classid=<%=Util.CLSID_RADIO%>
                                style="height: 20; width: 200" tabindex=5>
                                <param name=Cols value="4">
                                <param name=Format value="1^자가,2^전세,3^월세,9^기타">
                                <param name="AutoMargin" value="true">
                            </object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>
							<th>가입권유 브랜드</th>
							<td><comment id="_NSID_">
			                	<object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=5  align="absmiddle">
			                	</object></comment><script> _ws_(_NSID_);</script>
				                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCdCombo('POP'); EM_O_PUMBUN_CD.Focus();"  align="absmiddle" />
				                <comment id="_NSID_">
				                <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=5  align="absmiddle">
				                </object></comment><script> _ws_(_NSID_);</script>                        
                        </tr>
                        <!-- 
                        <tr>
                            <th width="90">선호 시설</th>
                            <td colspan="3">&nbsp;<input type="checkbox" id=FAVOR_DEPT1 value="N" tabindex=5>백화점쇼핑 &nbsp;<input
                                type="checkbox" id=FAVOR_DEPT2 value="N" tabindex=5>문화센터 &nbsp;<input
                                type="checkbox" id=FAVOR_DEPT3 value="N" tabindex=5>아트센터 &nbsp;<input
                                type="checkbox" id=FAVOR_DEPT4 value="N" tabindex=5>호텔 &nbsp;<input
                                type="checkbox" id=FAVOR_DEPT5 value="N" tabindex=5>테마파크 &nbsp;</td>
                        </tr>
                         -->
                    </table>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
        <tr style="display:none">
            <td class="sub_title PT07 PB02"><img
                src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
                align="absmiddle" class="PR03" /> 직장 및 학교정보</td>
        </tr>
        <tr style="display:none">
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"
                        class="s_table">
                        <tr>
                            <th width="90">직장(학교)</th>
                            <td width="310"><comment id="_NSID_"> <object
                                id=EM_OFFI_NM classid=<%=Util.CLSID_EMEDIT%> width=154
                                tabindex=5
                                onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90">부서</th>
                            <td><comment id="_NSID_"> <object id=EM_DEPT_NAME
                                classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=5
                                onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>
                            <th width="90">직위</th>
                            <td width="310"><comment id="_NSID_"> <object
                                id=LC_POSITION classid=<%=Util.CLSID_LUXECOMBO%> width=158
                                tabindex=5></object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_POSITION_ETC
                                classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=5
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                            <th width="90" style="width: 90px;">전화번호</th>
                            <td><comment id="_NSID_"> <object id=EM_OFFI_PH1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_OFFI_PH2
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                id="_NSID_"> <object id=EM_OFFI_PH3
                                classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
                                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>
                            <th width="90">주소</th>
                            <td colspan="2"
                                style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_OFFI_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_OFFI_ZIP_CD1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
                            <object id=EM_OFFI_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
                                width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif"
                                onclick="getPostPop_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)"
                                align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR"
                                onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)}">
                            <comment id="_NSID_"> <object id=EM_OFFI_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=256 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_OFFI_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_OFFI_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
        <tr style="display:none">
            <td class="sub_title PT07 PB02"><img
                src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
                align="absmiddle" class="PR03" /> 14세 미만 아동회원 가입신청서에 대한 법정대리인 동의</td>
        </tr>
        <tr style="display:none">
			<td class="PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90">이름</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_AGENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_AGENT_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90">주민등록번호</th>
							<td><comment id="_NSID_"> <object id=EM_AGENT_SSNO
								classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<th width="90">관계</th>
							<td width="310"><comment id="_NSID_"> <object
								id=LC_AGENT_RELATION classid=<%=Util.CLSID_LUXECOMBO%> width=158
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" style="width: 90px;">전화번호</th>
							<td><comment id="_NSID_"> <object id=EM_AGENT_PH1
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_AGENT_PH2
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
								id="_NSID_"> <object id=EM_AGENT_PH3
								classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						</tr>
						<tr>
							<td width="400" colspan="2">&nbsp;* 본인은 위 신청인의 개인정보
							수집/이용/제공에 동의합니다.
							</th>
							<th width="90">법정대리인</th>
							<td><comment id="_NSID_"> <object
								id=EM_LEGAL_AGENT classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_LEGAL_AGENT, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
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
                align="absmiddle" class="PR03" /> 정보 제공 및 활용 동의</td>
        </tr>
        <tr>
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						class="s_table">
						<tr>
							<th width="90" class="point">동의일자</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS1_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_OFF_TERMS1_DT)" /></td>
							<th width="90" class="point">성명</th>
							<td><comment id="_NSID_"> <object
								id=EM_OFF_TERMS1_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFF_TERMS1_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
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
                align="absmiddle" class="PR03" /> 개인정보 제3자 제공 동의</td>
        </tr>
        <tr>
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"
                        class="s_table">
						<tr>
							<th width="90" class="point">동의일자</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_OFF_TERMS2_DT classid=<%=Util.CLSID_EMEDIT%> width=80
								align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_OFF_TERMS2_DT)" /></td>
							<th width="90" class="point">성명</th>
							<td><comment id="_NSID_"> <object
								id=EM_OFF_TERMS2_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_OFF_TERMS2_NAME, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
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
                align="absmiddle" class="PR03" /> 가입일자</td>
        </tr>
        <tr>
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"
                        class="s_table">
                        <tr>
                            <th width="90" class="point">가입일자</th>
                            <td colspan="3"><comment id="_NSID_"> <object
                                id=EM_ENTR_DT classid=<%=Util.CLSID_EMEDIT%> width=80
                                align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                onclick="javascript:openCal('G',EM_ENTR_DT)" /></td>
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
                align="absmiddle" class="PR03" /> 직원기재</td>
        </tr>
        <tr>
            <td class="PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0"
                        class="s_table">
                        <tr>
                            <th width="90" class="point">신분증확인</th>
                            <td colspan="3"><comment id="_NSID_"> <object
                                id=LC_ID_CHECK classid=<%=Util.CLSID_LUXECOMBO%> width=158
                                align="absmiddle" tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
                        </tr>
                        <tr>
                            <th width="90" class="point">발행기관</th>
							<td width="310"><comment id="_NSID_"> <object
								id=EM_ISSUE_ORG classid=<%=Util.CLSID_EMEDIT%> width=154
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_ISSUE_ORG, 40, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<th width="90" class="point">발행일자</th>
							<td><comment id="_NSID_"> <object id=EM_ISSUE_DT
								classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
								tabindex=5></object> </comment> <script> _ws_(_NSID_);</script> <img
								src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
								onclick="javascript:openCal('G',EM_ISSUE_DT)" id=IMG_ISSUE_DT />
								<comment id="_NSID_"> <object
                                id=EM_NOCLS_REQ_YN  classid=<%=Util.CLSID_EMEDIT%> width=0
                                align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
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
            <c>col=SS_NO                    ctrl=EM_SS_NO                   Param=Text</c>
            <c>col=CUST_NAME                ctrl=EM_CUST_NAME               Param=Text</c>
            <c>col=CARD_PWD_NO              ctrl=EM_CARD_PWD_NO             Param=Text</c>
            <c>col=HOME_ZIP_CD1             ctrl=EM_HOME_ZIP_CD1            Param=Text</c>
            <c>col=HOME_ZIP_CD2             ctrl=EM_HOME_ZIP_CD2            Param=Text</c>
            <c>col=HOME_ADDR1               ctrl=EM_HOME_ADDR1              Param=Text</c>
            <c>col=HOME_ADDR2               ctrl=EM_HOME_ADDR2              Param=Text</c>
            <c>col=HOME_PH1                 ctrl=EM_HOME_PH1                Param=Text</c>
            <c>col=HOME_PH2                 ctrl=EM_HOME_PH2                Param=Text</c>
            <c>col=HOME_PH3                 ctrl=EM_HOME_PH3                Param=Text</c>
            <c>col=MOBILE_PH1               ctrl=EM_MOBILE_PH1              Param=Text</c>
            <c>col=MOBILE_PH2               ctrl=EM_MOBILE_PH2              Param=Text</c>
            <c>col=MOBILE_PH3               ctrl=EM_MOBILE_PH3              Param=Text</c>
            <c>col=EMAIL1                   ctrl=EM_EMAIL1                  Param=Text</c>
            <c>col=EMAIL2                   ctrl=LC_EMAIL2                  Param=BindColVal</c>
            <c>col=EMAIL3                   ctrl=EM_EMAIL3                  Param=Text</c>
            <c>col=EMAIL_YN                 ctrl=RD_EMAIL_YN                Param=CodeValue</c>
            <c>col=WED_YN                   ctrl=RD_WED_YN                  Param=CodeValue</c>
            <c>col=WED_DT                   ctrl=EM_WED_DT                  Param=Text</c>
            <c>col=BIRTH_DT                 ctrl=EM_BIRTH_DT                Param=Text</c>
            <c>col=LUNAR_FLAG               ctrl=RD_LUNAR_FLAG              Param=CodeValue</c>
            <c>col=SMS_YN                   ctrl=RD_SMS_YN                  Param=CodeValue</c>
            <c>col=POST_RCV_CD              ctrl=RD_POST_RCV_CD             Param=CodeValue</c>
            <c>col=OFFI_NM                  ctrl=EM_OFFI_NM                 Param=Text</c>
            <c>col=OFFI_PH1                 ctrl=EM_OFFI_PH1                Param=Text</c>
            <c>col=OFFI_PH2                 ctrl=EM_OFFI_PH2                Param=Text</c>
            <c>col=OFFI_PH3                 ctrl=EM_OFFI_PH3                Param=Text</c>
            <c>col=OFFI_ZIP_CD1             ctrl=EM_OFFI_ZIP_CD1            Param=Text</c>
            <c>col=OFFI_ZIP_CD2             ctrl=EM_OFFI_ZIP_CD2            Param=Text</c>
            <c>col=OFFI_ADDR1               ctrl=EM_OFFI_ADDR1              Param=Text</c>
            <c>col=OFFI_ADDR2               ctrl=EM_OFFI_ADDR2              Param=Text</c>
            <c>col=CHILD_CNT                ctrl=EM_CHILD_CNT               Param=Text</c>
            <c>col=CHKSAVE                  ctrl=EM_CHKSAVE                 Param=Text</c>
            <c>col=CUST_ID                  ctrl=EM_CUST_ID                 Param=Text</c>
            <c>col=HHOLD_ID                 ctrl=EM_HHOLD_ID                Param=Text</c>
            <c>col=CARD_NO                  ctrl=EM_CARD_NO                 Param=Text</c>
            <c>col=HOUSE_TYPE               ctrl=RD_HOUSE_TYPE              Param=CodeValue</c>
            <c>col=HOUSE_FLAG               ctrl=RD_HOUSE_FLAG              Param=CodeValue</c>
            <c>col=DEPT_NAME                ctrl=EM_DEPT_NAME               Param=Text</c>
            <c>col=POSITION                 ctrl=LC_POSITION                Param=BindColVal</c>
            <c>col=POSITION_ETC             ctrl=EM_POSITION_ETC            Param=Text</c>
            <c>col=AGENT_NAME               ctrl=EM_AGENT_NAME              Param=Text</c>
            <c>col=AGENT_SSNO               ctrl=EM_AGENT_SSNO              Param=Text</c>
            <c>col=AGENT_RELATION           ctrl=LC_AGENT_RELATION          Param=BindColVal</c>
            <c>col=AGENT_PH1                ctrl=EM_AGENT_PH1               Param=Text</c>
            <c>col=AGENT_PH2                ctrl=EM_AGENT_PH2               Param=Text</c>
            <c>col=AGENT_PH3                ctrl=EM_AGENT_PH3               Param=Text</c>
            <c>col=LEGAL_AGENT              ctrl=EM_LEGAL_AGENT             Param=Text</c>
            <c>col=OFF_TERMS1_DT            ctrl=EM_OFF_TERMS1_DT           Param=Text</c>
            <c>col=OFF_TERMS1_NAME          ctrl=EM_OFF_TERMS1_NAME         Param=Text</c>
            <c>col=OFF_TERMS2_DT            ctrl=EM_OFF_TERMS2_DT           Param=Text</c>
            <c>col=OFF_TERMS2_NAME          ctrl=EM_OFF_TERMS2_NAME         Param=Text</c>
            <c>col=ENTR_DT                  ctrl=EM_ENTR_DT                 Param=Text</c>
            <c>col=ID_CHECK                 ctrl=LC_ID_CHECK                Param=BindColVal</c>
            <c>col=ISSUE_ORG                ctrl=EM_ISSUE_ORG               Param=Text</c>
            <c>col=ISSUE_DT                 ctrl=EM_ISSUE_DT                Param=Text</c>
            <c>col=HOME_NEW_YN              ctrl=EM_HOME_NEW_YN             Param=Text</c>
            <c>col=OFFI_NEW_YN              ctrl=EM_OFFI_NEW_YN             Param=Text</c>
            <c>col=NOCLS_REQ_YN             ctrl=EM_NOCLS_REQ_YN            Param=Text</c>
            <c>col=CUST_GRADE               ctrl=LC_CUST_GRADE              Param=BindColVal</c>
            <c>col=VIP_FLAG                 ctrl=LC_VIP_FLAG                Param=BindColVal</c>
        	<c>col=POCARD_PREFIX            ctrl=LC_POCARD_PREFIX           Param=BindColVal</c>
        	<c>col=ALIEN_YN                 ctrl=RD_ALIEN_YN                Param=CodeValue</c>
        	<c>col=ALIEN_YN                 ctrl=RD_ALIEN_YN                Param=CodeValue</c>
        	<c>col=ENTR_PBN                 ctrl=EM_O_PUMBUN_CD             Param=Text</c>
        	<c>col=ENTR_PBN_NAME            ctrl=EM_O_PUMBUN_NM             Param=Text</c>            
            <c>col=CUST_TYPE                ctrl=LC_CUST_TYPE               Param=BindColVal</c>
            <c>col=SEX_CD             		ctrl=RD_SEX_CD            		Param=CodeValue</c>
            <c>col=ISSUE_CNT                ctrl=EM_ISSUE_CNT               Param=Text</c>
        '>
    </object>
    </comment>
    <script>_ws_(_NSID_);</script>
    <comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
</body>
</html>
