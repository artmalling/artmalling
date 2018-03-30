<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원정보안내
 * 작  성  일  : 2010.03.23
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo9990.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  :  
 * 이         력  :
 *           2010.03.23 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
    strToMonth = strToMonth + "01";
    
    String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<script LANGUAGE="JavaScript">
<!--
var strSsnoFlag = 'EM_SS_NO_S'; //조회용 사업자/주민구분 
var nextDate    = "";           //조회기간 설정용
//공통조회조건
var strCompPersFlag = "";
var strSsNo     = "";
var strCustId   = "";
var strCardNo   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-23
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var top = 405;		//해당화면의 동적그리드top위치
var top1 = 270;		//해당화면의 동적그리드top위치
 
function doInit(){
	
	var obj   = document.getElementById("GR_CLRPOINT"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	
	var obj   = document.getElementById("GR_POINT"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top1) + "px";


    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER_P"/>');
    DS_O_POINT.setDataHeader('<gauce:dataset name="H_POINT"/>');
    DS_O_CLR_POINT.setDataHeader('<gauce:dataset name="H_CLR_POINT"/>');
    //DS_O_CLR_POINT.setDataHeader('<gauce:dataset name="H_CLR_POINT_REAL"/>');
    
    //그리드 초기화
    gridCreate1();
    gridCreate3();
    gridCreate4();
    gridCreate5();

    // EMedit에 초기화 - View 단
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",    		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형

    //EMedit에 초기화 - 기본정보 검색조건
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_SS_NO_H,     "000000",      		  NORMAL);     //생년월일_hidden
    initEmEdit(EM_SS_NO_S,     "000000",     		  NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    
    
    //EMedit에 초기화 - 포인트 적립/사용 이력
    initEmEdit(EM_S_DT,      "YYYYMMDD",     PK);         //조회 시작기간    
    initEmEdit(EM_E_DT,      "TODAY",        PK);         //조회 종료기간
    initEmEdit(EM_BRCH_ID_S, "GEN^10",       NORMAL);     //가맹점
    initEmEdit(EM_BRCH_NM_S, "GEN^40",       READ);       //가맹점명
    
    //EMedit에 초기화 - 소멸예정안내 
    initEmEdit(EM_S_DT_S,     "TODAY",        PK);          //조회 시작기간    
    initEmEdit(EM_E_DT_S,     "YYYYMMDD",     PK);          //조회 종료기간
    
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
    
    //20131211 소멸예정포인트를 월별로만 조회 가능하게 수정 pcs  // 20160727 소멸예정포인트 일자로 조회 가능하게 수정 강연식
    RD_DM_FLAG.CodeValue 	= "2";
    RD_DM_FLAG.Enable    	= true;
    EM_S_DT_S.readonly     	= true;
    
    
    
    EM_S_DT.Text   = addDate("M", "-1", '<%=strToMonth%>');   
  //EM_S_DT_S.Text = addDate("D", "+1", EM_S_DT_S.Text);
  EM_S_DT_S.Text = addDate("D", "+1", EM_S_DT_S.Text);
    //EM_S_DT_S.Text = addDate("M", "+1", '<%=strToMonth%>');
    
    //var nextMonth  = addDate("M", "+1", EM_S_DT_S.Text);
   // var nextMonth  = addDate("M", "+12", EM_S_DT_S.Text);
    
    var nextMonth  = addDate("M", "+1", EM_S_DT_S.Text);
    nextDate   = nextMonth.substring(0,4)+ nextMonth.substring(5,7)
               + getLastDay( nextMonth.substring(0,4) , nextMonth.substring(5,7));
    EM_E_DT_S.Text = nextDate;
    RD_COMP_PERS_FLAG_S.Focus();
    
    //strCompPersFlag
  
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center SHOW=FALSE</FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=80  align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=120  align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=SS_NO           name="생년월일"        width=150  align=center  show="false"</FC>'
                     + '<FC>id=MAN_NM          name="세대주명"        width=80  align=left</FC>'
                     + '<FC>id=CARD_STAT_CD    name="카드상태코드"    width=80  show=false</FC>'
                     + '<FC>id=STAT_NM         name="카드상태"        width=70   align=center</FC>'
                     + '<FC>id=ENTR_PATH_CD    name="가입경로"        width=80   show=false</FC>'
                     + '<FC>id=BRCH_NAME       name="가입경로"        width=100  align=left</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류"        width=80   show=false</FC>'
                     + '<FC>id=TYPE_NM         name="카드종류"        width=100  align=left</FC>'
                     + '<FC>id=REMARK          name="비고"            width=117  align=left </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30        align=center</FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=100       align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=196       align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=SS_NO           name="생년월일"        width=150       align=center  show="false"</FC>'
                     + '<FC>id=REP_YN          name="대표카드여부"    width=100       align=center</FC>'
                     + '<FC>id=CARD_STAT_CD    name="카드상태코드"    width="80"      show=false</FC>'
                     + '<FC>id=STAT_NM         name="카드상태"        width="110"     align=center</FC>'
                     + '<FC>id=ENTR_PATH_CD    name="가입경로"        width="80"      show=false</FC>'
                     + '<FC>id=BRCH_NAME       name="가입경로"        width="110"     align=left</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류"        width="80"      show=false</FC>'
                     + '<FC>id=TYPE_NM         name="카드종류"        width="110"     align=left</FC>'
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30        align=center</FC>'
                     + '<FC>id=PROC_DT          name="처리일자"         width=80        align=center      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=PROC_TIME        name="처리시간"         width=70        align=center      mask="XX:XX:XX"</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"         width=120       align=center      mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=BRCH_ID          name="가맹점ID"         width=60        align=center      show=false</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"         width=80       align=left</FC>'
                     + '<FC>id=ADD_POINT        name="적립포인트"       width=80        align=right</FC>'
                     + '<FC>id=ADD_TYPE         name="적립유형"         width=80        align=center      show=false</FC>'
                     + '<FC>id=ADD_TYPE_NM      name="적립유형"         width=80        align=left</FC>'
                     + '<FC>id=USE_POINT        name="사용포인트"       width=80        align=right</FC>'
                     + '<FC>id=USE_TYPE         name="사용유형"         width=100       align=center      show=false</FC>'
                     + '<FC>id=USE_TYPE_NM      name="사용유형"         width=100       align=left</FC>'
                     + '<FC>id=RECP_NO          name="거래고유번호"     width=150       align=center</FC>';
        
                     
    initGridStyle(GR_POINT, "common", hdrProperies, false);
}

function gridCreate4(){
    var hdrProperies = '<FC>id={currow}         name="NO"                  width=30        align=center</FC>'
                     + '<FC>id=CUST_ID          name="회원(법인)ID"         width=120       align=left    show=false</FC>'
                     + '<FC>id=CUST_NAME        name="회원(법인)명"         width=120       align=left</FC>'
                     + '<FC>id=SS_NO            name="생년월일,사업자번호"     width=130       align=center   mask={IF(COMP_PERS_FLAG="C","XXX-XX-XXXXX","XXXXXX")}</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"             width=160       align=center   mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=CARD_TYPE_CD     name="카드종류"             width=120       align=center   show=false</FC>'
                     + '<FC>id=CARD_TYPE_NM     name="카드종류"             width=120       align=left</FC>'
                     + '<FC>id=EXP_DT           name="소멸예정일자"         width=100       align=center   mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EXP_POINT        name="소멸예정포인트"       width=116       align=right</FC>'
                     + '<FC>id=COMP_PERS_FLAG   name="법인/개인구분"        width=136       align=center   show=false</FC>';
                                  
    initGridStyle(GR_CLRPOINT, "common", hdrProperies, false);
}

function gridCreate5(){
	/*
    var hdrProperies =  '<FC>id={currow}         name="NO"                  width=30        align=center</FC>'
                     + '<FC>id=CUST_ID          name="회원(법인)ID"         width=120       align=left    show=false</FC>'
                     + '<FC>id=CUST_NAME        name="회원(법인)명"         width=120       align=left</FC>'
                     + '<FC>id=SS_NO            name="주민(사업자)번호"     width=200       align=center   mask={IF(COMP_PERS_FLAG="C","XXX-XX-XXXXX","XXXXXX-X******")}</FC>'
                     + '<FC>id=EXP_MONTH        name="소멸예정월"           width=120       align=center   mask="XXXX/XX"</FC>'
                     + '<FC>id=EXP_POINT        name="소멸예정포인트"       width=136       align=right</FC>'
                     + '<FC>id=COMP_PERS_FLAG   name="법인/개인구분"        width=136       align=center   show=false</FC>';
    */
    
    var hdrProperies =  '<FC>id={currow}         name="NO"                  width=30        align=center</FC>'
                     + '<FC>id=CUST_ID          name="회원(법인)ID"         width=120       align=left    show=false</FC>'
                     + '<FC>id=CUST_NAME        name="회원(법인)명"         width=120       align=left</FC>'
                     + '<FC>id=SS_NO            name="생년월일,사업자번호"     width=200       align=center   mask={IF(COMP_PERS_FLAG="C","XXX-XX-XXXXX","XXXXXX")}</FC>'
                     + '<FC>id=EXP_MONTH        name="소멸예정월"           width=120       align=center   mask="XXXX/XX"</FC>'
                     + '<FC>id=EXP_POINT        name="소멸예정포인트"       width=136       align=right</FC>'
                     + '<FC>id=COMP_PERS_FLAG   name="법인/개인구분"        width=136       align=center   show=false</FC>';
    
    
    /*var hdrProperies =  '<FC>id={currow}         name="NO"              width=30        align=center					</FC>'
        			+ '<FC>id=CUST_ID          name="회원(법인)ID"			width=120       align=left		show=false		</FC>'
        			+ '<FC>id=CUST_NAME        name="회원(법인)명"			width=120       align=left						</FC>'
			        + '<FC>id=EXP_MONTH        name="소멸예정월"			width=120       align=center	mask="XXXX/XX"	</FC>'
			        + '<FC>id=CALC_POINT       name="소멸예정포인트"			width=136       align=right						</FC>'
			        + '<FC>id=EXP_POINT        name="계산소멸예정포인트"		width=136       align=right		show=false		</FC>'
			        + '<FC>id=COMP_PERS_FLAG   name="법인/개인구분"			width=136       align=center	show=false		</FC>';*/  //20160727_기존 사용분
    initGridStyle(GR_CLRPOINT, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
    if(RD_COMP_PERS_FLAG_S.CodeValue=="P" && (trim(EM_SS_NO_S.Text).length == 0 
	   && trim(EM_CUST_ID_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0)){
	    showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호],[생년월일],[회원명] 중 하나 이상  반드시 입력해야 합니다.");
	    EM_CARD_NO_S.Focus();
	    return;
	}else if(RD_COMP_PERS_FLAG_S.CodeValue=="C" && (trim(EM_SS_NO_S.Text).length == 0 
	         && trim(EM_CUST_ID_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0)){
	    showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호],[사업자번호],[법인명] 중 하나 이상  반드시 입력해야 합니다.");
	    EM_CARD_NO_S.Focus();
	    return;
	}else{
		// MARIO OUTLET
		//if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
		if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {			
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13자리 또는 16자리입니다.");
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
        if (trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원/법인(단체)은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }
	}
    
    if(trim(EM_S_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DT.Focus();
        return;
    }
    if(trim(EM_E_DT.Text).length == 0){          // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DT.Focus();
        return;
    }
    if(EM_S_DT.Text > EM_E_DT.Text){             // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    
    if(trim(EM_S_DT_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DT_S.Focus();
        return;
    }
    if(trim(EM_E_DT_S.Text).length == 0){          // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DT_S.Focus();
        return;
  }
  if(EM_S_DT_S.Text > EM_E_DT_S.Text){             // 조회일 정합성
      showMessage(EXCLAMATION, OK, "USER-1015");
      EM_S_DT_S.Focus();
      return;
  }
    //보유카드현황
    if(RD_COMP_PERS_FLAG_S.CodeValue == "P"){
        gridCreate1(); 
    }else if(RD_COMP_PERS_FLAG_S.CodeValue == "C"){
        gridCreate2();
    }
  
    //소멸예정안내(월별/일별)
    if(RD_DM_FLAG.CodeValue == "1"){
        gridCreate4(); 
    }else if(RD_DM_FLAG.CodeValue == "2"){
        gridCreate5(); 
    }
    if(srchEvent(RD_COMP_PERS_FLAG_S.CodeValue))showMaster();
}
    

/**
 * btn_Excel()
 * 작 성 자 : kj
 * 작 성 일 : 2010-04-01
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "회원정보안내(소멸예정)"
		GR_POINT.GridToExcelExtProp("HideColumn") = "CUST_ID";       // GridToExcel 사용시 숨길 컬럼지정
	openExcel2(GR_POINT, ExcelTitle, "", true );
}


function btn_New() {
	doInit();
	
    DS_O_POINT.ClearData();
    DS_O_CLR_POINT.ClearData();
    DS_O_CUSTDETAIL.ClearData();
    
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
	EM_CARD_NO_CUT.Text   = "";	
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개       요     : 회원정보 조회
 * return값 : void
 */
function showMaster(){
    //공통
    strCompPersFlag = RD_COMP_PERS_FLAG_S.CodeValue;
    strSsNo     = EM_SS_NO_S.Text;
    strCustId   = EM_CUST_ID_S.Text;
    strCardNo   = EM_CARD_NO_S.Text;
    
    if(trim(EM_CUST_ID_S.Text).length == 0){
        strCustId = EM_CUST_ID_H.Text;
    }
    if(trim(EM_CARD_NO_S.Text).length == 0){
        strCardNo = EM_CARD_NO_H.Text;
    }
    if(trim(EM_SS_NO_S.Text).length == 0){
        strSsNo   = EM_SS_NO_H.Text;
    }
    
    //포인트 적립/사용 이력
    var strUseFDt   = EM_S_DT.Text;
    var strUseTDt   = EM_E_DT.Text;
    var strBrchId   = EM_BRCH_ID_S.Text;
    //소멸예정안내
    var strAddFDt   = EM_S_DT_S.Text;
    var strAddTDt   = EM_E_DT_S.Text;
    var strSrchGubun= RD_DM_FLAG.CodeValue; 
    
    var action      = "O"; 
    var goTo        = "searchMaster";      
    var parameters  = "&strCompPersFlag=" + encodeURIComponent(strCompPersFlag)
    	            + "&strSsNo="         + encodeURIComponent(strSsNo)
                    + "&strCustId="       + encodeURIComponent(strCustId)
                    + "&strCardNo="       + encodeURIComponent(strCardNo)
                    + "&strUseFDt="       + encodeURIComponent(strUseFDt)
                    + "&strUseTDt="       + encodeURIComponent(strUseTDt)
                    + "&strBrchId="       + encodeURIComponent(strBrchId)
                    + "&strAddFDt="       + encodeURIComponent(strAddFDt)
                    + "&strAddTDt="       + encodeURIComponent(strAddTDt)
                    + "&strSrchGubun="    + encodeURIComponent(strSrchGubun); 

    TR_MAIN.Action  = "/dcs/dmbo999.do?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER,"+action+":DS_O_POINT=DS_O_POINT,"+action+":DS_O_CLR_POINT=DS_O_CLR_POINT)"; //조회는 O
    TR_MAIN.Post();

    GR_MASTER.Focus();
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
	
    srchClrPoint();
    /*
    if (DS_O_CLR_POINT.CountRow == 0) {
    	showMessage(StopSign, OK, "USER-1000",  "소멸예정 포인트가 없습니다.");
    }
    */
}

/**
 * srchPoint()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개       요     : 포인트 적립/사용 이력
 * return값 : void
 */
function srchPoint(){

	if(DS_O_CUSTDETAIL.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1000","회원정보 조회 후 처리 가능합니다.");
		EM_CARD_NO_S.Focus();
	    return;
	}
	if(trim(EM_S_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_S_DT.Focus();
        return;
    }
    if(trim(EM_E_DT.Text).length == 0){          // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_E_DT.Focus();
        return;
    }
    if(EM_S_DT.Text > EM_E_DT.Text){             // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    
    //포인트 적립/사용 이력
    var strUseFDt   = EM_S_DT.Text;
    var strUseTDt   = EM_E_DT.Text;
    var strBrchId   = EM_BRCH_ID_S.Text;
    var goTo        = "searchPoint";    
    var action      = "O";     
    var parameters  = "&strUseFDt=" + encodeURIComponent(strUseFDt)
                    + "&strUseTDt=" + encodeURIComponent(strUseTDt)
                    + "&strBrchId=" + encodeURIComponent(strBrchId)
                    + "&strCardNo=" + encodeURIComponent(strCardNo)
                    + "&strSsNo="   + encodeURIComponent(strSsNo)
                    + "&strCustId=" + encodeURIComponent(strCustId)
                    + "&strCompPersFlag=" + encodeURIComponent(strCompPersFlag);   
    TR_MAIN.Action  = "/dcs/dmbo999.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_POINT=DS_O_POINT)"; //조회는 O
    TR_MAIN.Post();
    
    GR_POINT.Focus();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_POINT.CountRow);
}

/**
 * srchClrPoint()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-23
 * 개       요     : 소멸예정안내리스트
 * return값 : void
 */
function srchClrPoint(){
	
	if(DS_O_CUSTDETAIL.CountRow == 0){
	     showMessage(EXCLAMATION, OK, "USER-1000","회원정보 조회 후 처리 가능합니다.");
	     EM_CARD_NO_S.Focus();
	     return;
	}
	if(trim(EM_S_DT_S.Text).length == 0){          // 조회시작일
	      showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	      EM_S_DT_S.Focus();
	      return;
	}
	if(trim(EM_E_DT_S.Text).length == 0){          // 조회 종료일
	    showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
	    EM_E_DT_S.Focus();
	    return;
	}
	if(EM_S_DT_S.Text > EM_E_DT_S.Text){             // 조회일 정합성
	    showMessage(EXCLAMATION, OK, "USER-1015");
	    EM_S_DT_S.Focus();
	    return;
	}

	//소멸예정안내(월별/일별)
    if(RD_DM_FLAG.CodeValue == "1"){
        gridCreate4(); 
    }else if(RD_DM_FLAG.CodeValue == "2"){
        gridCreate5(); 
    }
	
    //소멸예정안내
    var strAddFDt   = EM_S_DT_S.Text;
    var strAddTDt   = EM_E_DT_S.Text;
    var strSrchGubun= RD_DM_FLAG.CodeValue; 
    var goTo        = "searchClrPoint";    
    var action      = "O";     
    var parameters  = "&strAddFDt="    + encodeURIComponent(strAddFDt)
                    + "&strAddTDt="    + encodeURIComponent(strAddTDt)
                    + "&strSrchGubun=" + encodeURIComponent(strSrchGubun)
                    + "&strCustId="    + encodeURIComponent(strCustId);    
    TR_MAIN.Action  = "/dcs/dmbo999.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CLR_POINT=DS_O_CLR_POINT)"; //조회는 O
    TR_MAIN.Post();
        
    GR_CLRPOINT.Focus();
    //alert("DS_O_CLR_POINT.CountRow"+DS_O_CLR_POINT.CountRow);
    //조회결과 Return pcs
    setPorcCount("SELECT", DS_O_CLR_POINT.CountRow);
    //alert("DS_O_CLR_POINT.CountRow"+DS_O_CLR_POINT.CountRow);
    
    setExpPointCalc();
    
    if (DS_O_CLR_POINT.CountRow == 0) {
    	showMessage(StopSign, OK, "USER-1000",  "소멸예정 포인트가 없습니다.");
    }
    
}

/**
 * 
 * 작 성 자 : 전주원
 * 작 성 일 : 2014-06-16
 * 개      요  : 소멸예정을 1년 연장표시할 변수선언
 */
var SKIP_FROM = "201508";
var SKIP_TO = "201607";


/**
 * setExpPointCalc()
 * 작 성 자 : 박춘성
 * 작 성 일 : 2013-12-11
 * 개      요  : 소멸포인트 계산
 * return값 :
 */
function setExpPointCalc() {
	var exp_point = 0;
	
	var exp_points = new Array();
	var exp_points_size = 0;
	
	if (DS_O_CLR_POINT.CountRow != 0)
	{
		for(i=1; i <= DS_O_CLR_POINT.CountRow; i++)
		{	
			
			if(i==1)
			{
				DS_O_CLR_POINT.NameValue(i, "CALC_POINT") = DS_O_CLR_POINT.NameValue(i, "EXP_POINT"); 
			}else{
				
				if(DS_O_CLR_POINT.NameValue(i-1, "EXP_POINT") > DS_O_CLR_POINT.NameValue(i, "EXP_POINT"))
				{
					exp_point = DS_O_CLR_POINT.NameValue(i-1, "EXP_POINT") - DS_O_CLR_POINT.NameValue(i, "EXP_POINT");
					if (DS_O_CLR_POINT.NameValue(i-1, "CALC_POINT") >= exp_point)
					{
						DS_O_CLR_POINT.NameValue(i-1, "CALC_POINT") = DS_O_CLR_POINT.NameValue(i-1, "CALC_POINT") - exp_point;
						DS_O_CLR_POINT.NameValue(i, "CALC_POINT") = 0;
						exp_point=0;
					}else
					{
						for(j=i-1; j==1; j--)
						{
							if(DS_O_CLR_POINT.NameValue(j, "CALC_POINT") >= exp_point){
								DS_O_CLR_POINT.NameValue(j, "CALC_POINT") = DS_O_CLR_POINT.NameValue(j, "CALC_POINT") - exp_point;
								exp_point = 0;
								DS_O_CLR_POINT.NameValue(i, "CALC_POINT") = 0;
								break;
							}else{
								exp_point = exp_point - DS_O_CLR_POINT.NameValue(j, "CALC_POINT");
								DS_O_CLR_POINT.NameValue(j, "CALC_POINT") = 0;
							}	
						}
					}
				}
				else
					DS_O_CLR_POINT.NameValue(i, "CALC_POINT") = DS_O_CLR_POINT.NameValue(i, "EXP_POINT") - DS_O_CLR_POINT.NameValue(i-1, "EXP_POINT");
			}
		
			/**
			  * 
			  * 작 성 자 : 전주원
			  * 작 성 일 : 2014-06-16
			  * 개      요  : 2014.07.01 이후는 소멸예정포인트 유효기간 2년
			  */
			//if (DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") >= SKIP_FROM && DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") <= SKIP_TO)
			if (DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") >= SKIP_FROM)	
				exp_points[exp_points_size++] = DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") + "" + DS_O_CLR_POINT.NameValue(i, "CALC_POINT");
		}
		
		
		/**
		  * 
		  * 작 성 자 : 전주원
		  * 작 성 일 : 2014-06-16
		  * 개      요  : 2014.07.01 이후는 소멸예정포인트 유효기간 2년
		  */
		for(i=1; i <= DS_O_CLR_POINT.CountRow; i++) {
			
			//if (DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") >= SKIP_FROM && DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") <= SKIP_TO) {
			if (DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") >= SKIP_FROM) {	
				DS_O_CLR_POINT.NameValue(i, "CALC_POINT") = 0;
			}
		}
		reExpPointCalc(exp_points);
	}
}

 /**
  * reExpPointCalc()
  * 작 성 자 : 전주원
  * 작 성 일 : 2014-06-16
  * 개      요  : 2014.07.01 이후는 소멸예정포인트 유효기간 2년
  * 처리를 12(1년)에서  24(2년)으로 바꾼 후에 from ~ to 로 바꾼다
  */ 
function reExpPointCalc(_exp_points) {
	
	var comp_dt = "";
	var next_skip_from = (SKIP_FROM.substring(0, 4) * 1 + 1) + "" + SKIP_FROM.substring(4, 6);
	var next_skip_to = (SKIP_TO.substring(0, 4) * 1 + 1) + "" + SKIP_TO.substring(4, 6); 
	
	if (DS_O_CLR_POINT.CountRow != 0)
	{
		for(i=1; i <= DS_O_CLR_POINT.CountRow; i++)
		{
			//if (DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") >= next_skip_from && DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") <= next_skip_to) {
			if (DS_O_CLR_POINT.NameValue(i, "EXP_MONTH") >= next_skip_from) {				
				for (j=0; j < _exp_points.length; j++) {
					
					comp_dt = (_exp_points[j].substring(0, 4) * 1 + 1) + "" + _exp_points[j].substring(4, 6);
					
					if (comp_dt == DS_O_CLR_POINT.NameValue(i, "EXP_MONTH")) {
						DS_O_CLR_POINT.NameValue(i, "CALC_POINT") = _exp_points[j].substring(6);
						break;
					}
				}
			}
		}
	}
}



/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-23
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NM_S.Text = "";//조건입력시 코드초기화
    if (trim(EM_BRCH_ID_S.Text).length > 0 ) {
        if (kcode == 13 || kcode == 9 || trim(EM_BRCH_ID_S.Text).length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID_S.Text = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NM_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S);
            }
        }
    }
}
 
/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-23
 * 개      요  : 회원메모관리 화면으로 이동
 * return값 : void
 */
 function gourl(){
    
	try{
        frame01 = window.external.GetFrame(window);
        frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
    } catch(e){     
    } 

	var strCardNo = EM_CARD_NO_S.Text;
	var strCustId = EM_CUST_ID_S.Text;
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM112","/dcs/dctm112.dm?goTo=list&strCustId="+strCustId+"&strCardNo="+strCardNo,"MCUS","02","회원메모관리");	
}

/**
 * gourlCust()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-23
 * 개      요  : 회원관리 화면으로 이동
 * return값 : void
 */
function gourlCust(){
    
	try{
        frame01 = window.external.GetFrame(window);
        frame01.Provider('../').OuterWindow.showStatusBar(strMsg);        
    } catch(e){     
    }
    var strSsNo = "";
	var strCardNo = EM_CARD_NO_S.Text;
	var strCustId = EM_CUST_ID_S.Text;
    if(DS_O_MASTER.Count > 0) strSsNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SS_NO");
    if(RD_COMP_PERS_FLAG_S.CodeValue == "P"){   //개인회원
    	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM203","/dcs/dctm203.dm?goTo=list&strCustId="+strCustId+"&strCardNo="+strCardNo,"MCUS","02","개인회원조회/수정");    
    }else{                                      //법인회원
    	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM206","/dcs/dctm206.dm?goTo=list&strCustId="+strCustId+"&strCardNo="+strCardNo,"MCUS","02","법인회원조회/수정");    
    }
    
}

/**
 * gourlLinkCard()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-23
 * 개      요  : 연계카드등록 화면으로 이동
 * return값 : void
 */
function gourlLinkCard(){
    
	try{
        frame01 = window.external.GetFrame(window);
        frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
    } catch(e){     
    }     
    var strSsNo = "";
    if(DS_O_MASTER.Count > 0) strSsNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SS_NO");
    frame01.Provider('../').OuterWindow.top.leftFrame.urlLink("DCTM291","/dcs/dctm291.dm?goTo=list&strSsNo="+strSsNo,"MCUS","02","연계카드등록");
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
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
<script language=JavaScript for=RD_COMP_PERS_FLAG_S event=OnSelChange()>
    if (strCompPersFlag == this.CodeValue) return;
    if ("P" == this.CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML    = "생년월일";
        document.getElementById('titleSsno2').innerHTML    = "생년월일";
        document.getElementById('titleCustName').innerHTML = "회원명";
        document.getElementById('titleCust').innerHTML     = "회원명";
        document.getElementById('titleHomeAddr').innerHTML = "회원주소";
        document.getElementById('titleHomePH').innerHTML   = "자택전화";
        document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";

        strSsnoFlag = 'EM_SS_NO_S';
        initEmEdit(EM_SS_NO,       "000000",    		  READ);       //생년월일
        initEmEdit(EM_SS_NO_H,     "000000",   		      NORMAL);     //생년월일_hidden
        initEmEdit(EM_SS_NO_S,     "000000",      		  NORMAL);     //생년월일
        
        DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER_P"/>');
        strCompPersFlag = this.CodeValue;  
    } 
    else if ("C" == CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML    = "사업자등록번호";
        document.getElementById('titleSsno2').innerHTML    = "사업자등록번호";
        document.getElementById('titleCustName').innerHTML = "법인(단체)명";
        document.getElementById('titleCust').innerHTML     = "법인(단체)명";
        document.getElementById('titleHomeAddr').innerHTML = "대표자자택주소";
        document.getElementById('titleHomePH').innerHTML   = "대표전화";
        document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";
        strSsnoFlag = 'EM_SS_NO_S1';
        
        initEmEdit(EM_SS_NO,       "#00-00-00000",      READ);       //사업자번호
        initEmEdit(EM_SS_NO_H,     "#00-00-00000",      NORMAL);     //사업자번호_hidden
        initEmEdit(EM_SS_NO_S,     "#00-00-00000",      NORMAL);     //사업자번호
        
        DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER_C"/>');
        strCompPersFlag = this.CodeValue;  
    }
    DS_O_POINT.ClearData();
    DS_O_CLR_POINT.ClearData();
    DS_O_CUSTDETAIL.ClearData();
    
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

<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (trim(EM_BRCH_ID_S.Text).length != 10)) {
        EM_BRCH_NM_S.Text = "";
    }
</script>

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
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

<!-- 보유카드현황 oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 보유카드현황 DoubleClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnDblClick(row,colid)>
    if(DS_O_MASTER.NameValue(row, "MAN_NM") != ""){
    	gourlLinkCard();
    }
</script>

<!-- 포인트 적립/사용 이력 oneClick event 처리 -->
<script language=JavaScript for=GR_POINT event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 소멸예정안내 oneClick event 처리 -->
<script language=JavaScript for=GR_CLRPOINT event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT)){
        EM_S_DT.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT event=onKillFocus()>
    checkDateTypeYMD(EM_E_DT);
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = addDate("D", "+1", EM_S_DT_S.Text);
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
	if(!checkDateTypeYMD(EM_E_DT_S)){
	    EM_E_DT_S.text = <%=toDate%>;
	}
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_POINT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_CLR_POINT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_CUSTDETAIL"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
  <object id="DS_I_CONDITION"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_RESULT"   classid=<%=Util.CLSID_DATASET%>></object>
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
<script language='javascript'>
<!--

window.onresize = function(){
    var obj   = document.getElementById("testdiv"); 
    obj.style.height  = (parseInt(window.document.body.clientHeight)-50) + "px";
}

//-->
</script>


<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_CLRPOINT");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_POINT");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top1+150) {
    	grd_height = top1;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top1);
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                  <th width="76" style="display:none">회원구분</th>
                  <td colspan="5" style="display:none">
                    <comment id="_NSID_">
                      <object id=RD_COMP_PERS_FLAG_S classid=<%=Util.CLSID_RADIO%> style="height:20; width:150" tabindex=1>
                        <param name=Cols    value="2">
                        <param name=Format  value="P^개인회원,C^법인회원">
                        <param name=CodeValue  value="P">
                      </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>  
                  </td>
                </tr>
                <tr>
                  <th width="76">카드번호</th> 
                  <td width="170">
                    <comment id="_NSID_"> <object
					id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> style="display:none" width="55"
					tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_">
                      <object id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> width="0"></object> 
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_">
                      <object id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S',RD_COMP_PERS_FLAG_S.CodeValue);">
                      </object>       
                    </comment>
                    <script> _ws_(_NSID_);</script>
                  </td>            
                  <th width="80"><span id="titleSsNo1" style="Color:146ab9">생년월일</span></th>
                  <td width="150">
                    <comment id="_NSID_">
                      <object id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> width="0"></object> 
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_">
                      <object id=EM_SS_NO_S classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,strSsnoFlag,RD_COMP_PERS_FLAG_S.CodeValue);">
                      </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>
                  </td>
                  <th width="80"><span id="titleCust" style="Color:146ab9">회원명</span></th>
                  <td>
                    <comment id="_NSID_">
                      <object id=EM_CUST_ID_H classid=<%=Util.CLSID_EMEDIT%> width="0"></object> 
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_">
                      <object id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1 onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',RD_COMP_PERS_FLAG_S.CodeValue);" align="absmiddle"></object> 
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,RD_COMP_PERS_FLAG_S.CodeValue)"/> 
                    <comment id="_NSID_">
                      <object id=EM_CUST_NAME_S classid=<%=Util.CLSID_EMEDIT%> width=77 align="absmiddle"></object>       
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    &nbsp;&nbsp;&nbsp;&nbsp;<img src="/<%=dir%>/imgs/btn/memo_regi_s.gif" onclick="gourl()" align="absmiddle"/>
                    &nbsp;<img src="/<%=dir%>/imgs/btn/cust_info_modify.gif" onclick="gourlCust()" align="absmiddle"/>
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
    <!--공통 검색 -->
    <%@ include file="/jsp/common/memView.jsp"%>
    <!--공통 검색// -->
    
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
    	<tr>
    	<td class="sub_title PT07 PB02" width="700"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/> 보유카드현황</td>
    	<td class="sub_title PT07 PB02" width="100%"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/> 포인트 적립/사용 이력</td>
    	</tr>
    	<tr valign="top">
	      <td class="PB03">
	        <table width="700" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	          <tr>
	            <td>
	              <comment id="_NSID_">
	                <object id=GR_MASTER width="100%" height=90 classid=<%=Util.CLSID_GRID%> tabindex=1>
	                  <param name="DataID" value="DS_O_MASTER">
	                </object>
	              </comment>
	              <script> _ws_(_NSID_);</script>
	            </td>
	          </tr>
	        </table>
	      </td>
	      
	    <td rowspan=5>
	    	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                  <th width="75" class="point">조회기간</th>
                  <td width="200">
                    <comment id="_NSID_">
                      <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                      </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT)"/>-
                    <comment id="_NSID_">
                      <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
                      </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)"/></td>
                  <th width="75">가맹점</th>
                  <td>
                    <comment id="_NSID_">
                      <object id=EM_BRCH_ID_S classid=<%=Util.CLSID_EMEDIT%> width=76 tabindex=1 align="absmiddle" onKeyUp="javascript:keyPressEvent(event.keyCode);">
                      </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NM_S)"/>
                    <comment id="_NSID_">
                      <object id=EM_BRCH_NM_S classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
                      </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    &nbsp;&nbsp;&nbsp;<img src="/<%=dir%>/imgs/btn/search_s1.gif" height="18" align="absmiddle" onClick="javascript:srchPoint()"/>
                  </td>
                </tr>
                <tr>
                	<td colspan=4>
		                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
				          <tr>
				            <td>
				              <comment id="_NSID_">
				                <object id=GR_POINT width="100%" height=300 classid=<%=Util.CLSID_GRID%> tabindex=1>
				                  <param name="DataID" value="DS_O_POINT">
				                </object>
				              </comment>
				              <script> _ws_(_NSID_);</script>
				            </td>
				          </tr>
				        </table>
                	</td>
                </tr>
              </table>
	    	</td>
	    </tr>
	    <tr>
	      <td class="sub_title PT07 PB02"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/> 소멸예정안내</td>
	    </tr>
	    <tr>
	      <td class="PT01 PB03">
	        <table width="700" border="0" cellspacing="0" cellpadding="0" class="o_table">
	          <tr>
	            <td>
	              <table width="700" border="0" cellpadding="0" cellspacing="0" class="s_table">
	                <tr>
	                  <th width="80" class="point">조회기간</th>
	                  <td width="280">
	                    <comment id="_NSID_">
	                      <object id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
	                      </object>
	                    </comment>
	                    <script> _ws_(_NSID_);</script>
	                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT_S)"/> -
	                    	<!-- <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"/> -->
	                    <comment id="_NSID_">
	                      <object id=EM_E_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle">
	                      </object>
	                    </comment>
	                    <script> _ws_(_NSID_);</script>
	                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DT_S)"/></td>
	                  <th width="80">조회구분</th>
	                  <td colspan="3">
	                    <comment id="_NSID_">
	                      <object id=RD_DM_FLAG classid=<%=Util.CLSID_RADIO%> style="height:20; width:120;" align="absmiddle" tabindex=1>
	                        <param name=Cols    value="2">
	                        <param name=Format  value="1^일별,2^월별">
	                        <param name=CodeValue  value="1">
	                      </object>
	                    </comment>
	                    <script> _ws_(_NSID_);</script>
	                    &nbsp;&nbsp;&nbsp;<img src="/<%=dir%>/imgs/btn/search_s1.gif" align="absmiddle" onClick="javascript:srchClrPoint()"/></td>
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
	        <table width="700" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	          <tr>
	            <td>
	              <comment id="_NSID_">
	                <object id=GR_CLRPOINT width="100%" height=152 classid=<%=Util.CLSID_GRID%> tabindex=1>
	                  <param name="DataID" value="DS_O_CLR_POINT">
	                </object>
	              </comment>
	              <script> _ws_(_NSID_);</script>
	            </td>
	          </tr>
	        </table>
	      </td>
	    </tr>
    </table>
		
  </table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
  <object id=BD_CUSTDETAIL classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_O_CUSTDETAIL>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
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
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CTYPE_NAME    ctrl=EM_CUST_TYPE    Param=Text</c>
        '>
  </object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
