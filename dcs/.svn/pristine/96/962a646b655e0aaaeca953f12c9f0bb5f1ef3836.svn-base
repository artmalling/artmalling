<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 법인회원가입신청서등록 
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm1050.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 기명회원 가입 신청서를 등록한다
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.07 (김영진) 기능추가
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
<!--* A. 로그인 유무, 기본설정                                                                                                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String strSSno = "";
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
<OBJECT ID="SP_PP"  CLASSID="CLSID:BBC2D990-A303-4252-A0C7-88E333DFE2C4" CODEBASE="/dcs/jsp/dcthm/SP_PP.cab#Version=1,0,0,0" width=256 height=128>
</OBJECT>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strFlag = "INS";
var intCardCount = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    //Input Data Set Header 초기화
    //법인회원가입신청서등록 .
    DS_IO_CUST.setDataHeader  ('<gauce:dataset name="H_CUST"/>');
	//Output Data Set Header 초기화
    DS_O_CARD.setDataHeader('<gauce:dataset name="H_CARD"/>');
	
    DS_IO_CUST.ClearData();
    DS_IO_CUST.Addrow();

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_CARD_NO,      "0000-0000-0000-0000", NORMAL);    //카드번호
	initEmEdit(EM_SS_NO,        "#00-00-00000",        NORMAL);    //사업자번호
	initEmEdit(EM_CUST_NAME,    "GEN^40",              PK);        //성명
	initEmEdit(EM_CARD_PWD_NO,  "GEN^4",               PK);        //카드비밀번호
    initEmEdit(EM_REP_NAME,     "GEN^40",              PK);        //대표자명
    initEmEdit(EM_CHKSAVE,      "GEN^1",               NORMAL);    //저장시에 I,U 구분.
    initEmEdit(EM_CUST_ID,      "GEN",                 NORMAL);                                
    initEmEdit(EM_HHOLD_ID,     "GEN",                 NORMAL);                                       
    initEmEdit(EM_HOME_PH1,     "GEN^4",               NORMAL);
    initEmEdit(EM_HOME_PH2,     "GEN^4",               NORMAL);
    initEmEdit(EM_HOME_PH3,     "GEN^4",               NORMAL);
    initEmEdit(EM_HOME_ADDR1,   "GEN^200",             PK);   
    initEmEdit(EM_HOME_ADDR2,   "GEN^200",             PK);
    
    initEmEdit(EM_HOME_ZIP_CD1, "NUMBER^3^0",          PK);
    initEmEdit(EM_HOME_ZIP_CD2, "NUMBER^3^0",          PK);
    initEmEdit(EM_OFFI_NM,      "GEN^40",              PK);
    initEmEdit(EM_OFFI_PH1,     "GEN^4",               PK);
    initEmEdit(EM_OFFI_PH2,     "GEN^4",               PK);
    initEmEdit(EM_OFFI_PH3,     "GEN^4",               PK);
    initEmEdit(EM_EMAIL1,       "GEN^50",              NORMAL);
    initEmEdit(EM_EMAIL3,       "GEN^50",              NORMAL);
    initEmEdit(EM_CARD_COUNT,   "NUMBER^2^0",          PK);                    //카드발급매수
    initComboStyle(LC_EMAIL2,DS_O_EMAIL2, "CODE^0^30,NAME^0^110", 1, NORMAL);      //이메일주소목록
    initEmEdit(EM_HOME_NEW_YN,  "GEN^1",               NORMAL);                //집 - 구/신주소여부
    initComboStyle(LC_POCARD_PREFIX,DS_O_POCARD_PREFIX, "CODE^0^30,NAME^0^110", 1, NORMAL);  //카드종류
    
    getEtcCode("DS_O_EMAIL2", "D", "D013", "N");
    getEtcCodeRefer("DS_O_POCARD_PREFIX", "D", "D104", "N");
    getEtcCode("DS_I_POCARD_PREFIX", "D", "D104", "N");
        
    EM_CHKSAVE.Text = "I";
    LC_EMAIL2.BindColVal = "99";
    RD_EMAIL_YN.CodeValue = "Y";
    RD_SMS_YN.CodeValue   = "Y";
    LC_POCARD_PREFIX.Index = 0;

    EM_HOME_ZIP_CD1.Enable = "false";
	EM_HOME_ZIP_CD2.Enable = "false";
	EM_HOME_ADDR1.Enable   = "false";
    EM_HOME_ZIP_CD1.Alignment = 1;
    EM_HOME_ZIP_CD2.Alignment = 1;
    
    EM_HOME_NEW_YN.style.display = "none";
    //EM_EMAIL3.style.display      = "none";
	EM_CHKSAVE.style.display     = "none";
	EM_CUST_ID.style.display     = "none";
	EM_HHOLD_ID.style.display    = "none";

	EM_SS_NO.Focus();
	
    //신청서 화면이므로 최초 addrow Dataset status 초기화.
    DS_IO_CUST.ResetStatus();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm105","DS_IO_CUST");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}          name="NO"             width=30       align=center</FC>'
                     + '<FC>id=CARD_NO           name="카드번호"        width=260      align=center    Mask="XXXX-XXXX-XXXX-XXXX" </FC>'
                     + '<FC>id=REP_CARD_YN       name="대표카드여부"    width=160      align=center</FC>'
                     + '<FC>id=ISSUE_DT          name="발급일자"        width=170      align=center    Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=POCARD_PREFIX     name="패밀리카드구분"   width=160      align=left   EditStyle=Lookup  Data="DS_I_POCARD_PREFIX:CODE:NAME" </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-03-02
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_SS_NO.Text) == "" && trim(EM_CARD_NO.Text) == ""){
    	showMessage(EXCLAMATION, OK, "USER-1000",  "[사업자등록번호],[카드번호] 중 하나 이상  반드시 입력해야 합니다.");
        EM_SS_NO.Focus();
        return false;
    }
	showCustInfo();
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
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
    doInit();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    var chk;
	if(EM_SS_NO.Text.indexOf("B")==-1){
        chk = isSaupNO(EM_SS_NO.Text);
	}
    
    if(trim(EM_SS_NO.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "사업자등록번호");
        EM_SS_NO.Focus();
        return false;
    }
    if(chk==false){
        showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
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
        return false;
    }
    if(trim(EM_OFFI_PH2.text) != "" && trim(EM_OFFI_PH3.text) == ""
     || trim(EM_OFFI_PH2.text) == "" && trim(EM_OFFI_PH3.text) != ""){
        showMessage(EXCLAMATION, OK, "USER-1000",  "담당자전화를  정확히 입력하세요.");
        if(trim(EM_OFFI_PH2.text) == ""){
        	EM_OFFI_PH2.Focus();
        }else if(trim(EM_OFFI_PH3.text) == ""){
        	EM_OFFI_PH3.Focus();
        }
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
    }*/
    if(trim(EM_CARD_COUNT.text) == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "발급카드수");
        EM_CARD_COUNT.Focus();
        return false;
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
 * 작 성 일 : 2010-03-02
 * 개    요 : 법인회원가입신청서등록  저장
 * return값 : void
 */
function saveData(){

    intCardCount = EM_CARD_COUNT.text;
    if(LC_EMAIL2.BindColVal == "99"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = EM_EMAIL3.Text;
    }else{
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL2")  = LC_EMAIL2.Text;
    } 
    if(RD_EMAIL_YN.CodeValue == "Y"){
        DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "EMAIL_AGREE_DT") = "<%=toDate%>";  //등록일자
    }
	DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition, "CUST_GRADE")  = "21";
	
    var strChksave = EM_CHKSAVE.Text;
    var parameters = "&strChksave="+encodeURIComponent(strChksave)
                   + "&strUpdate=N";;

    TR_MAIN.Action="/dcs/dctm105.dm?goTo=saveData"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CUST=DS_IO_CUST)";
    searchSetWait("B");
    TR_MAIN.Post();  

}

/**
 * showCustInfo()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 법인회원의 회원정보를 가져온다.
 * return값 : void
 */
function showCustInfo(){
	strFlag = "UPD";
	EM_EMAIL3.text = ""; 
    var strSsno    = EM_SS_NO.text;
    var strCardNo  = EM_CARD_NO.Text;
    
    var goTo       = "showCustInfo" ;    
    var action     = "O";     
    var parameters = "&strSsno="   + encodeURIComponent(strSsno)
                   + "&strCardNo=" + encodeURIComponent(strCardNo);
    TR_MAIN.Action="/dcs/dctm105.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CUST=DS_IO_CUST)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_IO_CUST.CountRow > 0){
        if(EM_CHKSAVE.Text=="U"){
            EM_CUST_NAME.Enable = false;
            EM_SS_NO.Enable     = false;
            if(EM_CARD_PWD_NO.Text!=""){
                EM_CARD_PWD_NO.Text = "****";
            }
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
            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 카드발급이 불가합니다.");
            btn_New();
            setTimeout("EM_SS_NO.Focus();",50);
            return false;
        }
        
    }
    searchCardList();
    if(EM_CHKSAVE.Text=="U"){
        //신청서 화면이므로 최초 addrow Dataset status 초기화.
        DS_IO_CUST.ResetStatus();
        LC_POCARD_PREFIX.Index = 0;
    }
}

/**
 * searchCardList()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 법인회원의 카드정보 조회.
 * return값 : void
 */
function searchCardList(){

    var strCustid  = EM_CUST_ID.Text;
    var goTo       = "searchCardList" ;    
    var action     = "O";     
    var parameters = "&strCustid="    + encodeURIComponent(strCustid)
                   + "&intCardCount=" + encodeURIComponent(intCardCount);
    TR_CARD.Action="/dcs/dctm105.dm?goTo="+goTo+parameters;  
    TR_CARD.KeyValue="SERVLET("+action+":DS_O_CARD=DS_O_CARD,"+action+":DS_O_CARDPRINT=DS_O_CARDPRINT)"; //조회는 O
    TR_CARD.Post();
    
    sortColId( DS_O_CARD, 0, "");
    DS_O_CARD.RowPosition = 0;
    if(DS_O_CARD.CountRow > 0){
        sortColId( DS_O_CARD, 0, "CARD_NO");
    }
}

/**
 * insSsno()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-02
 * 개       요 : 법인회원의 가사업자번호생성.
 * return값 : void
 */
function insSsno(){

    var strCustid    = EM_CUST_ID.text;

    var goTo       = "insSsno" ;    
    var action     = "O";     
    var parameters = "" ;
    TR_MAIN.Action="/dcs/dctm105.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CARD=DS_O_CARD)"; //조회는 O
    TR_MAIN.Post();
    
    LC_EMAIL2.BindColVal = "99";
}

/**
 * cardPrint(cardno,name, img1, img2){
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-07-11
 * 개      요  : 카드 출력
 * return값 : void
 */
function cardPrint(cardno,name){
    var cardno1=cardno.substring(0,4);
    var cardno2=cardno.substring(4,8);
    var cardno3=cardno.substring(8,12);
    var cardno4=cardno.substring(12,16);
    var paramCardNo = cardno1 + "-" + cardno2 + "-" + cardno3 + "-" + cardno4;

    result = SP_PP.CARD_ISSUE( "",cardno,"",paramCardNo,"","","","","");
    if(result == "0;"){

    }else{
        if(result == "1;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "장비의 전원이나 연결상태를 확인하여 주십시오.[SetInteractiveMode]");
        }else if(result == "2;" || result == "3;" || result == "4;" ){
            var mode = "";
            if(result == "2;"){
                mode = "[StartDoc]";
            }else if(result == "3;"){
                mode = "[StartPage]";
            }else if(result == "4;"){
                mode = "[GetCardId]";
            }
            showMessage(EXCLAMATION, OK, "USER-1000",  "사용중인 컴퓨터와 장비의 상태를 확인하여 주십시오." + mode);
        }else if(result == "5;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "발급중 장비가 비정상적으로 종료 되었습니다.[GetCardStatus1]");
        }else if(result == "6;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "발급 대기시간을 초과 하였습니다.[TimeOut]");
        }else if(result == "7;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "장비의 정상발급 완료 해제 실패.[SetInteractiveMode]");
        }else if(result == "10;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "장비에서 카드를 삽입하지 못하였습니다.[FeedCard]");
        }else if(result == "12;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "장비내에서의 카드 이동이 원할하지 않습니다.[SmartCardContinue]");
        }else if(result == "15;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "Magstripe 기록에 실패하였습니다.");
        }else if(result == "16;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "MS1 Track Data가 76Byte를 초과하였습니다.");
        }else if(result == "17;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "MS2 Track Data가 37Byte를 초과하였습니다.");
        }else if(result == "18;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "MS3 Track Data가 104Byte를 초과하였습니다.");
        }else if(result == "20;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "Line 전사에 실패하였습니다.");
        }else if(result == "25;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "이미지(사진)전사에 실패하였습니다.");
        }else if(result == "31;" || result == "32"){
            
            var mode2 = "";
            if(result == "31;"){
                mode2 = "[EndPage Err]";
            }else if(result == "32;"){
                mode2 = "[StartPage Err]";
            }
        
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드 인쇄 중 에러입니다."+mode2);
        }else if(result == "40;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "발급 자료 검색 오류.");
        }else if(result == "41;"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "이미 발급된 자료 임.");
        }else{
            showMessage(EXCLAMATION, OK, "USER-1000",  "알 수 없는 에러가 발생하였습니다.");
        }
        searchDoneWait();
        return false;
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
		if(TR_MAIN.SrvErrMsg('UserMsg',i).indexOf("cid:")!=-1){
            EM_CUST_ID.Text =  TR_MAIN.SrvErrMsg('UserMsg',i).substring(4,13);
            searchCardList();
            searchDoneWait();
            showMessage(INFORMATION, OK, "USER-1000", "정상적으로 저장되었습니다.");
            EM_CHKSAVE.Text = "U";
            EM_CUST_NAME.Enable = false;
            EM_SS_NO.Enable     = false;
            EM_CARD_COUNT.Text  = "";
		}else if(TR_MAIN.SrvErrMsg('UserMsg',i).indexOf("rst:")!=-1){
		      EM_SS_NO.Text =  TR_MAIN.SrvErrMsg('UserMsg',i).substring(4,14);
		}else{
            showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
		}
    }  
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
    }
    if( LC_EMAIL2.BindColVal == "" ){
        setComboData(LC_EMAIL2,"99");
    }
</script>
<script language=JavaScript for=TR_CARD event=onSuccess>
    for(i=0;i<TR_CARD.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CARD.SrvErrMsg('UserMsg',i));
    }
    /* 카드발급 주석처리 차후 적용해야함 삭제하지 마세요
    for(i = 1; i < DS_O_CARDPRINT.CountRow + 1; i++){
        cardPrint(DS_O_CARDPRINT.NameValue(i,"CARD_NO"),EM_CUST_NAME.Text);
    }*/
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    searchDoneWait();
    if(EM_EMAIL1.Text != ""){
        LC_EMAIL2.Index  = LC_EMAIL2.IndexOfColumn("NAME", DS_IO_CUST.NameValue(DS_IO_CUST.RowPosition ,"EMAIL2"));
    }
    if( LC_EMAIL2.BindColVal == "" ){
        setComboData(LC_EMAIL2,"99");
    }
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_CARD event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
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
<!-- 도메인 OnSelChange() -->
<script language=JavaScript for=LC_EMAIL2 event=OnSelChange()>
    if(LC_EMAIL2.BindColVal == "99"){
        EM_EMAIL3.style.display = "";
    }else{
        EM_EMAIL3.style.display = "none";
    }
</script>
<!-- 사업자번호 onKillFocus() -->
<script language=JavaScript for=EM_SS_NO event=onKillFocus()>
    if(trim(EM_SS_NO.Text).length != 0){
        
        var chk;
	    if(EM_SS_NO.Text.indexOf("B")==-1){
            chk = isSaupNO(EM_SS_NO.Text);
	    }
        if(chk==false){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
            EM_SS_NO.Text = "";
            setTimeout( "EM_SS_NO.Focus();",50);    
            return false;
        }else if(trim(EM_SS_NO.Text).length != 10){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 사업자번호가 아닙니다.");
            EM_SS_NO.Text = "";
            setTimeout( "EM_SS_NO.Focus();",50);    
            return false;
        }
        showCustInfo();
    }
</script>
<!-- 카드번호 onKillFocus()-->
<script language=JavaScript for=EM_CARD_NO event=onKillFocus()>
    if(trim(EM_CARD_NO.Text).length != 0){
        if(!isValidCardNo(EM_CARD_NO.Text)){
            showMessage(EXCLAMATION, OK, "USER-1000",  "유효한 카드번호가 아닙니다.");
            EM_CARD_NO.Text = "";
            setTimeout( "EM_CARD_NO.Focus();",50);
            return false;
        }
        showCustInfo();
    }
</script>
<!--  카드구분 Filter
<script language=JavaScript for=DS_O_POCARD_PREFIX event=OnFilter(row)>


	if (DS_O_POCARD_PREFIX.NameValue(row,"REFER_CODE") == "1") return true
	else return false;


</script>
-->
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<comment id="_NSID_">
<object id="DS_I_POCARD_PREFIX" classid=<%=Util.CLSID_DATASET%>> </object>
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
<comment id="_NSID_">
<object id="DS_O_CARD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CARDPRINT" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_POCARD_PREFIX" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter	value=true></object>
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
<object id="TR_CARD" classid=<%=Util.CLSID_TRANSACTION%>>
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="90">사업자등록번호</th>
						<td><comment id="_NSID_"> <object id=EM_SS_NO
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/add_business_s.gif" align="absmiddle" onclick="insSsno()"> <img
							src="/<%=dir%>/imgs/btn/biz_cod_search.gif" align="absmiddle" onclick="getSsNoPop(EM_SS_NO,'C')"></td>
						<th width="90">패밀리카드구분</th>
							<td><comment id="_NSID_"> <object
								id=LC_POCARD_PREFIX classid=<%=Util.CLSID_LUXECOMBO%> width=130
								tabindex=1 onClick="DS_O_POCARD_PREFIX.Filter()"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="90">카드번호</th>
						<td><comment id="_NSID_"> <object id=EM_CARD_NO
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
						<th width="90" class="point">사업자(단체)명</th>
						<td width="310"><comment id="_NSID_"> <object
							id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=154
							tabindex=1
							onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"></object>
						</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
							id=EM_CHKSAVE classid=<%=Util.CLSID_EMEDIT%> width=10 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_CUST_ID
							classid=<%=Util.CLSID_EMEDIT%> width=10 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_HHOLD_ID
							classid=<%=Util.CLSID_EMEDIT%> width=10 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="90" class="point">카드비밀번호</th>
						<td><comment id="_NSID_"> <object id=EM_CARD_PWD_NO
							classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="90" class="point">대표자명</th>
						<td width="310"><comment id="_NSID_"> <object id=EM_REP_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
							onkeyup="javascript:checkByteStr(EM_REP_NAME, 40, '');">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="90">대표전화</th>
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
						<th width="90" class="point">사업장주소</th>
						<td colspan="2"
							style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
							id="_NSID_"> <object id=EM_HOME_NEW_YN
							classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script><comment id="_NSID_"> <object
							id=EM_HOME_ZIP_CD1 classid=<%=Util.CLSID_EMEDIT%> width=30
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>-
						<comment id="_NSID_"> <object id=EM_HOME_ZIP_CD2
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/search_post_s.gif" id=IMG_SRCH_POST
							tabindex=1
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
						</comment> <script> _ws_(_NSID_);</script> 
						</td>
					</tr>
					<tr>
						<th width="90" class="point">담당자명</th>
						<td width="310"><comment id="_NSID_"> <object id=EM_OFFI_NM
							classid=<%=Util.CLSID_EMEDIT%> width=154 tabindex=1
							onkeyup="javascript:checkByteStr(EM_OFFI_NM, 40, '');">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="90" class="point">담당자전화</th>
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
						<th width="90">이메일주소</th>
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
						<th width="90">문자수신</th>
						<td width="310"><comment id="_NSID_"> <object id=RD_SMS_YN
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^예,N^아니오">
							<param name=CodeValue value="Y">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="90">이메일수신</th>
						<td><comment id="_NSID_"> <object id=RD_EMAIL_YN
							classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
							tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^예,N^아니오">
							<param name=CodeValue value="Y">
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
			align="absmiddle" class="PR03" /> 발급카드 리스트</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="90" class="point">발급카드수</th>
						<td><comment id="_NSID_"> <object id=EM_CARD_COUNT
							classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="820" height=263 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_CARD">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
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
			<c>col=HOME_NEW_YN               ctrl=EM_HOME_NEW_YN             Param=Text</c>
			<c>col=CARD_COUNT                ctrl=EM_CARD_COUNT              Param=Text</c>
			<c>col=POCARD_PREFIX             ctrl=LC_POCARD_PREFIX           Param=BindColVal</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>
