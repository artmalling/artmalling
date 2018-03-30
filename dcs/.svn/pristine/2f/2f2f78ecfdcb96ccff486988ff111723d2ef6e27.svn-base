<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽 운영 > 승인처리> 포인트 강제적립/차감(회원미등록)
 * 작 성 일 : 2010.03.28
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dmbo7160.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.03.28 (장형욱) 신규작성
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
    request.setCharacterEncoding("utf-8");
    String fromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    fromDate = fromDate + "01";

    String strFlag = "P"; //개인회원
    String strSsno = "EM_SS_NO_S";
%>
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
var strCustid   = "";
var strCardno   = "";
var strSsno     = "";
var strBrchCd   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

	var GET_USER_AUTH_VALUE = getBrchUserAuth('<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />');
	
    //Input Data Set Header 초기화
    //적립차감 포인트 등록.
    DS_I_POINT.setDataHeader  ('<gauce:dataset name="H_POINT"/>');
    
    DS_I_POINT.ClearData();
    DS_I_POINT.Addrow();
    
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_CUSTINFO.setDataHeader('<gauce:dataset name="H_CUSTINFO"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //당일 포인트 강제 적립 차감 등록 내역    
    
    //검색필드 초기화
    initEmEdit(EM_PROT_DT_F,       "YYYYMMDD",  PK);           //시작일
    initEmEdit(EM_PROT_DT_T,       "YYYYMMDD",  PK);           //종료일
    
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_SS_NO_H,     "000000",     		  NORMAL);     //생년월일_hidden
    initEmEdit(EM_SS_NO_S,     "000000",     		  NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
        
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",      		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
    initEmEdit(EM_REMARK,      "GEN^100",             NORMAL);
        
    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
        
    document.getElementById('titleSsno').innerHTML = "생년월일";
    document.getElementById('titleCust').innerHTML = "회원명";        
    tb_Radio.CodeValue       = "A"; 
    
    //조회일자 초기값.
    EM_PROT_DT_F.text = addDate("M", "-1", '<%=fromDate%>');
    EM_PROT_DT_T.text = <%=toDate%>;

    //권한
    /*
    if ("B" == GET_USER_AUTH_VALUE) {
    	initEmEdit(EM_BRCH_CD,      "GEN^10",   READ);     //가맹점코드
        enableControl(IMG_BRCH,   false);
    } else {
    	initEmEdit(EM_BRCH_CD,      "GEN^10",   NORMAL);   //가맹점코드
        enableControl(IMG_BRCH,   true); 
    }
    */
    initEmEdit(EM_BRCH_CD,      "GEN^10",   PK);     //가맹점코드
    
    initComboStyle2(LC_POINT_TYPE, DS_O_POINT_TYPE, "CODE^0^30,NAME^0^110", 1, PK);    //적립사유 유형    
    initEmEdit(EM_POINT2,        "NUMBER^9^0", PK);  
    initEmEdit(EM_BRCH_NAME,    "GEN^40",      READ);     //가맹명
     
    getEtcCode("DS_O_POINT_TYPE", "D", "D008", "N");
    
    //초기값설정
    setComboData(LC_POINT_TYPE,"");
    
    EM_BRCH_CD.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />';
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_CD.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }
    
    //EM_CARD_NO_S.Focus();
    EM_CARD_NO_CUT.Focus();
     //최초 addrow Dataset status 초기화.
    DS_I_POINT.ResetStatus();
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmbo716","DS_I_POINT");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"             width=30     align=center</FC>'
                     + '<FC>id=PROC_DT      name="처리일자"         width=80    align=center Mask="XXXX-XX-XX"</FC>'
                     + '<FC>id=CARD_NO      name="카드번호"         width=130   align=center  Mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=BRCH_NAME    name="가맹점명"         width=100   align=left</FC>'
                     + '<FC>id=ADD_POINT    name="적립포인트"       width="80"   align=right</FC>'
                     + '<FC>id=ADD_TYPE_NM  name="적립유형"         width="90"  align=left</FC>'
                     + '<FC>id=USE_POINT    name="사용포인트"       width="80"   align=right</FC>'
                     + '<FC>id=USE_TYPE_NM  name="사용유형"         width="90"  align=left</FC>'
                     + '<FC>id=RECP_NO      name="거래고유번호"      width="100"  align=center</FC>'; 
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
	var hdrProperies = '<FC>id={currow}     name="NO"         width="30"     align=center  </FC>'
                     + '<FC>id=BRCH_NAME    name="가맹점명"     width="90"   align=left    </FC>'
                     + '<FC>id=PROC_DT      name="처리일자"     width="80"   align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CUST_NAME    name="회원명/법인명" width="80"   align=center   </FC>'
                     + '<FC>id=PROC_NAME    name="구분"        width="70"    align=center   </FC>'
                     + '<FC>id=POINT        name="적립/차감금액" width="90"  align=right   </FC>'
                     + '<FC>id=REASON_NM    name="사유유형"     width="100"  align=left    </FC>'
                     + '<FC>id=REMARK       name="상세사유"     width="90"   align=left      </FC>'
                     + '<FC>id=CONF_DATE    name="승인일자"     width="80"   align=center   mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CONF_NAME    name="승인자"       width="70"   align=center  </FC>';
                     
    initGridStyle(GD_MASTER2, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
 * 개       요 : 조회시 호출
 * return값 : void
 */ 
function btn_Search() {
    if (DS_I_POINT.IsUpdated){
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
          setTimeout("tb_Radio.Focus();",50);
            return false;
        }
    }
	if(trim(EM_PROT_DT_F.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_PROT_DT_F.Focus();
        return;
    }
    if(trim(EM_PROT_DT_T.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_PROT_DT_T.Focus();
        return;
    }
    if(EM_PROT_DT_F.Text > EM_PROT_DT_T.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_PROT_DT_F.Focus();
        return;
    }
    
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }    
    
    if (RD_COMP_PERS_FLAG_S.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6)) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
        EM_SS_NO_S.Focus();
        return;
    }else if (RD_COMP_PERS_FLAG_S.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
        EM_SS_NO_S.Focus();
        return;
    }

    searchCustInfo();
    
    showMaster();
    searchTodayList();    
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_O_CUSTDETAIL.CountRow == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "회원정보가 존재하지 않습니다. 포인트 강제적립이나 차감할 수 없습니다.");
        return;
    }

    if (DS_O_CUSTDETAIL.NameValue(1, "CARD_NO") == "") {
        showMessage(StopSign, OK, "USER-1000",  "유효한 카드가 존재하지 않는 회원입니다. 포인트 강제적립/차감(회원미등록) 할 수 없습니다.");
        return;
    }

    if(EM_BRCH_CD.text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점명");
        EM_BRCH_CD.Focus();
        return false;
    } else if(tb_Radio.CodeValue == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "처리구분");
        tb_Radio.Focus();
        return false;
    } else if(LC_POINT_TYPE.index == -1){
        showMessage(EXCLAMATION, OK, "USER-1003",  "적립/차감 사유유형");
        LC_POINT_TYPE.Focus();
        return false;
    } else if(EM_POINT2.text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003",  "적립/차감 포인트");
        EM_POINT2.Focus();
        return false;
    } else if(parseInt(EM_POINT2.text) <= 0){
        showMessage(EXCLAMATION, OK, "USER-1008", "적립/차감 포인트","0");
        EM_POINT2.Focus();
        return false;
    }else if(tb_Radio.CodeValue == "U" && (parseInt(EM_POINT2.text) > parseInt(EM_POINT.text))) {
    	showMessage(StopSign, OK, "USER-1021", "차감포인트","누적포인트");
    	EM_POINT2.Focus();
    	return false;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }   
    
    
    saveData();
    
}

/**
 * btn_New()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010-02-25
 * 개       요     : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
	//doInit()
	 
	DS_O_CUSTDETAIL.ClearData();
	DS_O_MASTER.ClearData();
	DS_O_MASTER2.ClearData();
    EM_CARD_NO_CUT.Text = "";
    EM_CARD_NO_S.Text = "";
    EM_CARD_NO_H.Text = "";
    EM_SS_NO_S.Text = "";
    EM_SS_NO_H.Text = "";
	EM_CUST_ID_S.Text = "";
	EM_CUST_NAME_S.Text = "";
    initEmEdit(EM_SS_NO,          "000000",      READ);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* showMaster()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
* 개    요 : 포인트강제적립차감 리스트 조회
* return값 : void
*/
function showMaster(){

    strCustid       = EM_CUST_ID_S.text;
    var strProrDt_f = EM_PROT_DT_F.text;
    var strProrDt_t = EM_PROT_DT_T.text;
    strCardno       = EM_CARD_NO_S.Text;
    strSsno         = EM_SS_NO_S.Text ;
    strCompFlag     = RD_COMP_PERS_FLAG_S.CodeValue;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strProrDt_f="    +encodeURIComponent(strProrDt_f)+
                     "&strProrDt_t="    +encodeURIComponent(strProrDt_t)+
                     "&strCustid="      +encodeURIComponent(strCustid) +
                     "&strCardno="      +encodeURIComponent(strCardno) +
                     "&strSsno="        +encodeURIComponent(strSsno)   +
                     "&strCompFlag="    +encodeURIComponent(strCompFlag);
    
    TR_MAIN.Action="/dcs/dmbo716.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
        EM_CARD_NO_S.Focus();
    }    
    clearData();
}

/**
* searchTodayList()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
* 개    요 : 포인트강제적립차감 리스트 조회
* return값 : void
*/
function searchTodayList(){
    var goTo       = "searchTodayList" ;    
    var action     = "O";     
    var parameters = "&strCustid="  + encodeURIComponent(strCustid) +
                     "&strCardno="  + encodeURIComponent(strCardno) +
                     "&strSsno="    + encodeURIComponent(strSsno)  + 
                     "&strBrchCd="  + encodeURIComponent(strBrchCd);
    TR_MAIN2.Action="/dcs/dmbo716.do?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
    TR_MAIN2.Post();
    
    setPorcCount("SELECT", DS_O_MASTER2.CountRow);    
    
    if (DS_O_MASTER2.CountRow > 0 ) {
        GD_MASTER2.Focus();        
    }else {
        EM_CARD_NO_S.Focus();
    }    
}

/**
* searchCustInfo()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
* 개    요 : 회원정보 조회
* return값 : void
*/
function searchCustInfo(){
    var goTo        = "searchCustInfo";    
    var parameters  = "&CARD_NO="        + encodeURIComponent(EM_CARD_NO_S.Text);
        parameters += "&SS_NO="          + encodeURIComponent(EM_SS_NO_S.Text);
        parameters += "&CUST_ID="        + encodeURIComponent(EM_CUST_ID_S.Text);
        parameters += "&COMP_PERS_FLAG=" + encodeURIComponent(RD_COMP_PERS_FLAG_S.CodeValue);
        
    TR_MAIN2.Action="/dcs/dmbo716.do?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue="SERVLET(O:DS_O_CUSTDETAIL=DS_O_CUSTDETAIL)"; //조회는 O
    TR_MAIN2.Post();
}

/**
* saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
* 개    요 : 포인트강제적립차감 저장
* return값 : void
*/
function saveData(){

    strCustid   = EM_CUST_ID_S.text;
    strCardno   = DS_O_CUSTDETAIL.NameValue(1, "CARD_NO");
    strSsno     = EM_SS_NO_S.text;
    strBrchCd   = EM_BRCH_CD.text;

    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "BRCH_CD"   ) = strBrchCd;                 // 가맹점코드
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "CARD_NO"   ) = strCardno;                 // 카드번호
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "PROC_FLAG" ) = tb_Radio.CodeValue;        // 처리구분
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "POINT"     ) = EM_POINT2.text;            // 적립금
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "REASON_CD" ) = LC_POINT_TYPE.BindColVal;  // 사유유형
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "REMARK"    ) = EM_REMARK.text;            // 상세내용
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "SS_NO"     ) = strSsno;                   // 상세내용
    DS_I_POINT.NameValue(DS_I_POINT.RowPosition, "CUST_ID"   ) = strCustid;                 // 회원명
 
    
    TR_MAIN.Action="/dcs/dmbo716.do?goTo=saveData";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_POINT=DS_I_POINT)";
    TR_MAIN.Post();  
    clearData();
}

/**
* clearData()
* 작 성 자 : 김영진
* 작 성 일 : 2010-05-03 
* 개      요 : 저장 후 초기화
* return값 : void
*/
function clearData(){
	tb_Radio.CodeValue       = "A"; 
	EM_POINT2.text           = "";      // 적립금
    LC_POINT_TYPE.BindColVal = "";      // 사유유형
    EM_REMARK.text           = "";      // 상세내용
    getEtcCode("DS_O_POINT_TYPE", "D", "D008", "N");
    EM_BRCH_CD.Text = '<c:out value="${sessionScope.sessionInfo.BRCH_ID}" />';
    setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_CD.Text);
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_BRCH_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
        EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
    }
    
    //최초 addrow Dataset status 초기화.
    DS_I_POINT.ResetStatus();
}

/**
 * keyPressEvent()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-28 
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
     EM_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_CD.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_CD.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_CD.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_CD,EM_BRCH_NAME);
            }
        }
    }
}    
 
/**
* initComboStyle2
* 작  성 자 : 김영진
* 작  성 일 : 2010-04-13
* 개        요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
* 사 용 법  : initComboStyle(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
*          initComboStyle(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
*/
function initComboStyle2(objCombo, strDataSet, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
    objCombo.ComboDataID      = strDataSet.id;
    objCombo.ListExprFormat   = strExprFormat;
    objCombo.FontSize         = "9";
    objCombo.FontName         = "돋움";
    objCombo.ListCount        = 10;
    objCombo.SearchColumn   = strExprFormat.split(",")[intSearchColumn].split("^")[0];
    objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
    objCombo.InheritColor   = true;
    if (strDsBindFlag != true){
        objCombo.SyncComboData    = false;
    }
    objCombo.WantSelChgEvent  = true;
    switch(THEME){
      case SPRING :
        break;
      case SUMMER :
        break;
      case FALL   :
        break;
      case WINTER :
        setObjTypeStyle( objCombo, "COMBO", strType );
        break;
      default :
      break;
    }
}

/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개      요  : 화면 이동
 * return값 : void
 */
function gourl(go,nm,s){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text,s,"01",nm);
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
        searchTodayList();
    }
</script>
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_CUSTDETAIL event=OnLoadCompleted(rowcnt)>
    //if (rowcnt == 0 || this.NameValue(1, "CARD_NO") == "") {
    //    showMessage(StopSign, OK, "USER-1000",  "유효한 카드가 존재하지 않는 회원입니다. 포인트 강제적립/차감(회원미등록) 할 수 없습니다.");
    //    return;
    //}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_COMP_PERS_FLAG_S event=OnSelChange()>
    if (strCompPersFlag == this.CodeValue) return;
    if ("P" == this.CodeValue) { 
        document.getElementById('titleSsno').innerHTML         = "생년월일";
        document.getElementById('titleSsNo2').innerHTML        = "생년월일";
        document.getElementById('titleCust').innerHTML         = "회원명";
        document.getElementById('titleCustName').innerHTML     = "회원명";
        document.getElementById('titleHomeAddr').innerHTML     = "회원주소";
        document.getElementById('titleHomePH').innerHTML       = "자택전화";
        document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";

        initEmEdit(EM_SS_NO_H,     "000000",      		  NORMAL);     //생년월일_hidden
        initEmEdit(EM_SS_NO_S,     "000000",      		  NORMAL);     //생년월일
        initEmEdit(EM_SS_NO,       "000000-0000000",      READ);       //사업자번호
        
        strCompPersFlag = this.CodeValue;  
    } 
    else if ("C" == this.CodeValue) {
        document.getElementById('titleSsno').innerHTML         = "사업자등록번호";
        document.getElementById('titleSsNo2').innerHTML        = "사업자등록번호";        
        document.getElementById('titleCust').innerHTML         = "법인(단체)명";
        document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
        document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
        document.getElementById('titleHomePH').innerHTML       = "대표전화";
        document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";

        initEmEdit(EM_SS_NO_H,     "#00-00-00000",      NORMAL);     //사업자번호_hidden
        initEmEdit(EM_SS_NO_S,     "#00-00-00000",      NORMAL);     //사업자번호
        initEmEdit(EM_SS_NO,       "#00-00-00000",      READ);       //사업자번호
        
        strCompPersFlag = this.CodeValue;  
    }
    
    DS_O_CUSTDETAIL.ClearData();
    DS_O_MASTER.ClearData();
    DS_O_MASTER2.ClearData();
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_HOME_PH.Text     = ""; 
    EM_MOBILE_PH.Text   = ""; 
    EM_EMAIL.Text       = ""; 
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = "";
    EM_CARD_NO_S.Text   = "";
    EM_SS_NO_S.Text     = "";
</script>

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    	getCustInfoSrch(13,EM_CARD_NO_S,'EM_CARD_NO_S',strCompPersFlag);
    }
</script>

<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    } 
</script>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_PROT_DT_F event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PROT_DT_F)){
    	EM_PROT_DT_F.text = addDate("M", "-1", '<%=fromDate%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_PROT_DT_T event=onKillFocus()>
	if(!checkDateTypeYMD(EM_PROT_DT_T)){
		EM_PROT_DT_T.text = <%=toDate%>;
	}
</script> 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<script language=JavaScript for=tb_Radio event=OnSelChange()>
    if(tb_Radio.CodeValue=="A"){
        
        document.getElementById('txt1').innerHTML = "적립사유 유형";
        document.getElementById('txt2').innerHTML = "적립포인트";
        getEtcCode("DS_O_POINT_TYPE", "D", "D008", "N");
        //초기값설정
        setComboData(LC_POINT_TYPE,"");

    }else if(tb_Radio.CodeValue=="U"){
        document.getElementById('txt1').innerHTML = "차감사유 유형";
        document.getElementById('txt2').innerHTML = "차감포인트";
        getEtcCode("DS_O_POINT_TYPE", "D", "D009", "N");
        //초기값설정
        setComboData(LC_POINT_TYPE,"");
        
    }
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_I_POINT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTINFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_POINT_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 회원 팝업  -->
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
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
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
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="77" style="display:none">회원구분</th>
                        <td style="display:none"><comment id="_NSID_"> <object
                            id=RD_COMP_PERS_FLAG_S classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 150" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="P^개인회원,C^법인회원">
                            <param name=CodeValue value="P">
                            <param name=AutoMargin value="true">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>                    
                        <th width="77" class="point">조회기간</th>
                        <td colspan="5"><comment id="_NSID_"> <object id=EM_PROT_DT_F
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_PROT_DT_F)" />- <comment
                            id="_NSID_"> <object id=EM_PROT_DT_T
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object></comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_PROT_DT_T)" /></td>
                    </tr>
                    <tr>
                    <th width="57">카드번호</th>
                    <td width="170"><comment id="_NSID_"> <object 
                        id=EM_CARD_NO_H  width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object style="display:none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                         <comment
                        id="_NSID_"> <object id=EM_CARD_NO_S
                        classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S',strCompPersFlag);">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                    <th width="80"><span id="titleSsno" style="Color: 146ab9">사업자번호</span></th>
                    <td width="150"><comment id="_NSID_"> <object
                        id=EM_SS_NO_H  width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                        id="_NSID_"> <object id=EM_SS_NO_S
                        classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'<%=strSsno%>',strCompPersFlag);">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                    <th width="80"><span id="titleCust" style="Color: 146ab9">법인명</span></th>
                    <td><comment id="_NSID_"> <object id=EM_CUST_ID_H width=0
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
                        id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',strCompPersFlag);"
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                        onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,strCompPersFlag)" />
                    <comment id="_NSID_"> <object id=EM_CUST_NAME_S
                        classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script></td>
                </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>

	<tr>
	    <td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm116.dm','회원메모관리(신규)','DCTM')">회원메모관리(신규)</a></td>
			    <td class="btn_r"></td>			    
			  </tr>
			</table>                
	    </td>	
	</tr>
    <tr>
        <td class="dot"></td>
    </tr>	
<tr>
	<td class="PT01 PB03">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="s_table">
				<tr>
					<th width="80"><span id="titleCustName" style="Color: 146ab9">회원명</span></th>
					<td width="160"><comment id="_NSID_"> <object
						id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=140
						tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
					<th width="80"><span id="titleHomePH" style="Color: 146ab9">자택전화</span></th>
					<td width="160"><comment id="_NSID_"> <object
						id=EM_HOME_PH classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
					</comment> <script> _ws_(_NSID_);</script></td>
					<th width="80"><span id="titleMobileOffiPH" style="Color: 146ab9">이동전화</span></th>
					<td><comment id="_NSID_"> <object id=EM_MOBILE_PH
						classid=<%=Util.CLSID_EMEDIT%> width=173 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
				</tr>
				<tr>
					<th width="80"><span id="titleSsNo2" style="Color: 146ab9">생년월일</span></th>
					<td><comment id="_NSID_"> <object id=EM_SS_NO
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
					<th><span id="titleHomeAddr" style="Color: 146ab9">회원주소</span></th>
					<td colspan="3"><comment id="_NSID_"> <object
						id=EM_HOME_ADDR classid=<%=Util.CLSID_EMEDIT%> width=434
						tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
				</tr>
				<tr>
					<th>가용포인트</th>
					<td><comment id="_NSID_"> <object id=EM_POINT
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
					<th>이메일주소</th>
					<td><comment id="_NSID_"> <object id=EM_EMAIL
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
					<th>회원등급</th>
					<td><comment id="_NSID_"> <object id=EM_CUST_GTADE
						classid=<%=Util.CLSID_EMEDIT%> width=173 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_HOME_PH1
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_HOME_PH2
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_HOME_PH3
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_MOBILE_PH1
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_MOBILE_PH2
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_MOBILE_PH3
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_EMAIL1
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object id=EM_EMAIL2
						classid=<%=Util.CLSID_EMEDIT%> width=0 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
				</tr>
				<tr>
					<th>발생포인트</th>
					<td><comment id="_NSID_"> <object id=EM_OCCURS_POINT
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
					<th>가용+발생</th>
					<td><comment id="_NSID_"> <object id=EM_SUM_POINT
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					</td>
					<th>회원유형</th>
					<td><comment id="_NSID_"> <object id=EM_CUST_TYPE
						classid=<%=Util.CLSID_EMEDIT%> width=173 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
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
            align="absmiddle" class="PR03" /> 포인트 적립/사용내역</td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GD_MASTER
                    width="100%" height=116 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment><script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="sub_title PT07 PB02"><img
            src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
            align="absmiddle" class="PR03" /> 당일 포인트 강제 적립 차감 등록 내역</td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GD_MASTER2
                    width="100%" height=85 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_O_MASTER2">
                </object> </comment><script>_ws_(_NSID_);</script></td>
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
                        <th width="100">처리구분</th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=tb_Radio classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 150" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="A^강제적립,U^강제차감">
                            <param name=CodeValue value="A">
                        </object> </comment><script> _ws_(_NSID_);</script></td>
                        <th width="100" class="point"><span id="txt1" style="Color: 146ab9">적립사유 유형</span></th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=LC_POINT_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=120 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="100" class="point"><span id="txt2" style="Color: 146ab9">적립포인트</span></th>
                        <td><comment id="_NSID_"><object id=EM_POINT2
                            classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1>
                            <param name=Alignment value=2>
                            <param name=Numeric value=true>
                            <param name=IsComma value=true>
                            <param name=MaxLength value=9>
                            <param name=MaxDecimalPlace value=2>
                        </object> </comment><script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="100" class="point">가맹점명</th>
                        <td colspan="5"><comment id="_NSID_"> <object
                            id=EM_BRCH_CD classid=<%=Util.CLSID_EMEDIT%> width="75"
                            align="absmiddle"
                            onKeyUp="javascript:keyPressEvent(event.keyCode);" tabindex="1"></object>
                        </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" id="IMG_BRCH"
                            onclick="getBrchPop(EM_BRCH_CD,EM_BRCH_NAME)" /> <comment
                            id="_NSID_"> <object id=EM_BRCH_NAME
                            classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="100">상세사유</th>
                        <td colspan="5"><comment id="_NSID_">
                           <object id=EM_REMARK classid=<%=Util.CLSID_TEXTAREA%> style="width: 100%; height: 45px;"  tabindex=1
                            onkeyup="javascript:checkByteStr(EM_REMARK, 100, 'Y');"></object>
                           </comment><script> _ws_(_NSID_);</script>
                        </td>
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
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_CUSTDETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=SUM_POINT  	 ctrl=EM_SUM_POINT 	  Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=BD_POINT classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_I_POINT>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=BRCH_CD      ctrl=EM_BRCH_CD      Param=Text</c>
            <c>col=PROC_FLAG    ctrl=tb_Radio        Param=CodeValue</c>
            <c>col=POINT        ctrl=EM_POINT2       Param=Text</c>
            <c>col=REASON_CD    ctrl=LC_POINT_TYPE   Param=BindColVal</c>
            <c>col=REMARK       ctrl=EM_REMARK       Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
