<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 카드분실신고이력
 * 작 성 일    : 2010.03.18
 * 작 성 자    : jinjung.kim
 * 수 정 자    : 
 * 파 일 명    : dctm2110.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.03.18 (jinjung.kim) 신규작성
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
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
<%
    String LOSS_DT_FROM = "";
    String LOSS_DT_TO = "";

    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
            "yyyyMMdd");
    java.util.Calendar cal = java.util.Calendar.getInstance();
    String strToDay = sdf.format(cal.getTime());
    String strPreDay = sdf.format(cal.getTime()).substring(0, 6) + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var RD_COMP_PERS_FLAG_VALUE = "P";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.18
 * 개       요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 240;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    
    //카드분실신고이력 DataSet Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); 

    //EMEDIT 초기화;
    initEmEdit(EM_LOSS_DT_FROM, "YYYYMMDD",            PK);         //신고일자1
    initEmEdit(EM_LOSS_DT_TO,   "YYYYMMDD",            PK);         //신고일자2
    initEmEdit(EM_CARD_NO_S,    "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_SS_NO_S,      "000000",     		   NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,    "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S,  "GEN^40",              READ);       //회원명
    initEmEdit(EM_CUST_NAME,    "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,      "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,     "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,     "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,     "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,    "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,   "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,   "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,   "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,        "000000",     		   READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,    "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,        "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",           READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",           READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,        "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,       "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,       "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,   "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,    "GEN^40",     		   READ);       //회원유형
    initEmEdit(EM_ENTR_DT,    "YYYYMMDD",             READ);        //가입일자 추가 16.12.22

    
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
    
    EM_LOSS_DT_FROM.Text = "<%=strPreDay%>";
    EM_LOSS_DT_TO.Text   = "<%=strToDay%>";

    EM_CARD_NO_S.focus();
}

/**
 * gridCreate1()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.18
 * 개       요  : 카드분실신고이력 GRID초기화
 * return값 : void
 */
function gridCreate1() {
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30   align=center  </FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=150  align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류코드"    width=100  align=center  show=false </FC>'
                     + '<FC>id=CARD_TYPE_NM    name="카드종류"        width=120  align=center  </FC>'
                     + '<FC>id=PROC_FLAG       name="카드상태코드"    width=100  align=center  show=false </FC>'
                     + '<FC>id=PROC_FLAG_NM    name="처리구분"        width=100  align=center  </FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=88   align=center  mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=CUST_ID         name="신고자"          width=100  align=center  show=false </FC>'
                     + '<FC>id=CUST_NAME       name="신고자"          width=100  align=left    </FC>'
                     + '<FC>id=LOSS_DT         name="신고일자"        width=88   align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REG_ID          name="접수자"          width=100  align=center  show=false </FC>'
                     + '<FC>id=USER_NAME       name="접수자"          width=100  align=left    </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.18
 * 개       요  : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if(trim(EM_LOSS_DT_FROM.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "신고일자는 필수입력항목입니다.");
        EM_LOSS_DT_FROM.Focus();
        return;
    }
    if(trim(EM_LOSS_DT_TO.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "신고일자는 필수입력항목입니다.");
        EM_LOSS_DT_TO.Focus();
        return;
    }
    if (EM_LOSS_DT_TO.Text < EM_LOSS_DT_FROM.Text) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "신고일자의 시작일이 종료일보다 큽니다.");
        EM_LOSS_DT_FROM.Focus();
        return;
    }
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CARD_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일 / 카드번호 / 회원/법인(단체)명 중 한가지는 필수입력항목입니다.");
        EM_SS_NO_S.Focus();
        return;
    } else {
        if (trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length != 9) {
             showMessage(EXCLAMATION, OK, "USER-1000",  "회원/법인(단체)은 9자리입니다.");
             EM_CUST_ID_S.focus();
             return;
        }
    }

    EM_SS_NO.Text     = "";
    EM_EMAIL.Text     = "";
    EM_HOME_PH.Text   = "";
    EM_MOBILE_PH.Text = "";

    srchEvent(RD_COMP_PERS_FLAG.CodeValue);

    showMaster();
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_Excel()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.18
 * 개       요  : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    var ExcelTitle = "카드분실신고이력";
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";
    openExcel2(GR_MASTER, ExcelTitle, "", true );
}


/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {

     initEmEdit(EM_SS_NO_S,      "000000",    		   NORMAL);//생년월일
     initEmEdit(EM_SS_NO,        "000000",    		   READ);//생년월일
  
     DS_O_RESULT.ClearData();
     DS_O_MASTER.ClearData();
     EM_CUST_ID_H.Text   = ""; 
     EM_CARD_NO_H.Text   = "";
     EM_SS_NO_H.Text     = "";
     EM_HOME_PH.Text     = ""; 
     EM_MOBILE_PH.Text   = ""; 
     EM_EMAIL.Text       = ""; 
     EM_CUST_ID_S.Text   = ""; 
     EM_CUST_NAME_S.Text = ""; 
     EM_CUST_NAME.Text   = "";
     EM_SS_NO.Text       = "";
     EM_CARD_NO_S.Text     = "";
     EM_SS_NO_S.Text     = "";
     EM_HOME_ADDR.Text   = "";
     EM_CUST_GTADE.Text  = "";
     EM_POINT.Text       = "";
     EM_CARD_NO_CUT.Text   = "";

}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.18
 * 개       요  : 카드 분실 이력 조회 
 * return값 : void
 */
function showMaster(){
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&COMP_PERS_FLAG=" + encodeURIComponent(RD_COMP_PERS_FLAG.CodeValue)
                    + "&LOSS_DT_FROM="   + encodeURIComponent(EM_LOSS_DT_FROM.Text)
                    + "&LOSS_DT_TO="     + encodeURIComponent(EM_LOSS_DT_TO.Text)
                    + "&SS_NO="          + encodeURIComponent(EM_SS_NO_S.Text)
                    + "&CARD_NO="        + encodeURIComponent(EM_CARD_NO_S.Text)
                    + "&CUST_ID="        + encodeURIComponent(EM_CUST_ID_S.Text);
    TR_MASTER.Action  ="/dcs/dctm211.dm?goTo="+goTo+parameters;  
    TR_MASTER.KeyValue="SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MASTER.Post();

}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리                                          *-->
<!--*    2. TR Fail 메세지 처리                                             *-->
<!--*    3. DataSet Success 메세지 처리                                     *-->
<!--*    4. DataSet Fail 메세지 처리                                        *-->
<!--*    5. DataSet 이벤트 처리                                             *-->
<!--*************************************************************************-->

<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MASTER event=onSuccess>

    sortColId( DS_O_MASTER, 0, "");
    if (DS_O_MASTER.CountRow > 0) {
    	DS_O_MASTER.RowPosition = 0;
    	sortColId( DS_O_MASTER, 0, "CARD_NO");
        GR_MASTER.focus();
    } else {
    	RD_COMP_PERS_FLAG.focus();
    }
    if (DS_O_CUSTDETAIL.CountRow > 0) {
    	if(RD_COMP_PERS_FLAG_VALUE == "P"){
            initEmEdit(EM_SS_NO,          "000000",      READ);
    	}
    } else {
    	if(RD_COMP_PERS_FLAG_VALUE == "P"){
            initEmEdit(EM_SS_NO,          "000000",      READ);
    	}
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MASTER event=onFail>
    trFailed(TR_MASTER.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 카드분실신고이력 OnRowPosChanged(row) -->
<script language=JavaScript for=DS_O_CUSTDETAIL event=OnRowPosChanged(row)>
    if (row <= 0) return;
    var ssno   = this.NameValue(row, "SS_NO");
    var email  = this.NameValue(row, "EMAIL1") + this.NameValue(row, "EMAIL2"); 
    var home   = this.NameValue(row, "HOME_PH1") + this.NameValue(row, "HOME_PH2") + this.NameValue(row, "HOME_PH3"); 
    var mobile = this.NameValue(row, "MOBILE_PH1") + this.NameValue(row, "MOBILE_PH2") + this.NameValue(row, "MOBILE_PH3"); 
    
    if ("" != ssno) {
        EM_SS_NO.Text = ssno;
    }
    if ("" != email) {
        EM_EMAIL.Text = this.NameValue(row, "EMAIL1") + "@" +  this.NameValue(row, "EMAIL2")
    }
    if ("" != home) {
        EM_HOME_PH.Text = this.NameValue(row, "HOME_PH1") + " - " + this.NameValue(row, "HOME_PH2") +" - " + this.NameValue(row, "HOME_PH3"); 
    }
    if ("" != mobile) {
        EM_MOBILE_PH.Text = this.NameValue(row, "MOBILE_PH1") +" - " + this.NameValue(row, "MOBILE_PH2") +" - " + this.NameValue(row, "MOBILE_PH3"); 
    }

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_COMP_PERS_FLAG event=OnClick()>
    if (this.CodeValue == RD_COMP_PERS_FLAG_VALUE) return;
    RD_COMP_PERS_FLAG_VALUE = this.CodeValue ;
    if ("P" == this.CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML        = "생년월일";
        document.getElementById('titleSsno2').innerHTML        = "생년월일";
        document.getElementById('titleCustName').innerHTML     = "회원명";
        document.getElementById('titleCust').innerHTML         = "회원명";
        document.getElementById('titleHomeAddr').innerHTML     = "회원주소";
        document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";
        document.getElementById('titleHomePH').innerHTML       = "자택전화";
    
        initEmEdit(EM_SS_NO_S,      "000000",      NORMAL);//생년월일
        initEmEdit(EM_SS_NO,        "000000",      READ);//생년월일
    } 
    else if ("C" == CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML        = "사업자등록번호";
        document.getElementById('titleSsno2').innerHTML        = "사업자등록번호";
        document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
        document.getElementById('titleCust').innerHTML         = "법인(단체)명";
        document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
        document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";
        document.getElementById('titleHomePH').innerHTML       = "대표전화";

        initEmEdit(EM_SS_NO_S,     "#00-00-00000",        NORMAL);     //사업자번호
        initEmEdit(EM_SS_NO,       "#00-00-00000",        READ);       //사업자번호
    }
    DS_O_RESULT.ClearData();
    DS_O_MASTER.ClearData();
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_HOME_PH.Text     = ""; 
    EM_MOBILE_PH.Text   = ""; 
    EM_EMAIL.Text       = ""; 
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = ""; 
    EM_CUST_NAME.Text   = "";
    EM_SS_NO.Text       = "";
    EM_CARD_NO_S.Text     = "";
    EM_SS_NO_S.Text     = "";
    EM_HOME_ADDR.Text   = "";
    EM_CUST_GTADE.Text  = "";
    EM_POINT.Text       = "";
    EM_CARD_NO_CUT.Text   = "";
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

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_LOSS_DT_FROM event=onKillFocus()>
    if(!checkDateTypeYMD(EM_LOSS_DT_FROM)){
    	EM_LOSS_DT_FROM.Text = "<%=strPreDay%>";
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_LOSS_DT_TO event=onKillFocus()>
    if(!checkDateTypeYMD(EM_LOSS_DT_TO)){
        initEmEdit(EM_LOSS_DT_TO,    "TODAY",     PK);         
    }
</script>  
    
<script language=JavaScript for=EM_CUST_ID_S event=onKeyDown(kcode,scode)>
    if (!(kcode == 13 || kcode == 9)) EM_CUST_NAME_S.Text = "";
</script>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>



<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                       *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    1
    
    
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                              *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0"
            class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="s_table">
                    <tr>
                        <th width="77" style="display:none">회원구분</th>
                        <td width="160" style="display:none"><comment id="_NSID_"> <object
                            id=RD_COMP_PERS_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 140" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="P^개인카드,C^법인카드">
                            <param name=CodeValue value="P">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="77">카드번호</th>
                        <td width="170">
							<comment id="_NSID_"> <object style="display:none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        	<comment id="_NSID_"> <object
                            id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width="155"
                            tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">신고일자</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_LOSS_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width=80
                            align="absmiddle" tabindex=1> <img
                                src="/<%=dir%>/imgs/icon/ico_calender.gif" align="absmiddle" /></object>
                        </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_LOSS_DT_FROM)" /> ~ <comment
                            id="_NSID_"> <object id=EM_LOSS_DT_TO
                            classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"
                            tabindex=1> <img
                                src="/<%=dir%>/imgs/icon/ico_calender.gif" align="absmiddle" /></object>
                        </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_LOSS_DT_TO)" /></td>
                    </tr>

                    <tr> 
                        <th width="80"><span id="titleSsNo1" style="Color: 146ab9">생년월일</span></th>
                        <td><comment id="_NSID_"> <object id=EM_SS_NO_S
                            classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80"><span id="titleCust" style="Color: 146ab9">회원명</span></th>
                        <td><comment id="_NSID_"> <object id=EM_CUST_ID_H
                            classid=<%=Util.CLSID_EMEDIT%> align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object id=EM_CARD_NO_H
                            classid=<%=Util.CLSID_EMEDIT%> align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object id=EM_SS_NO_H
                            classid=<%=Util.CLSID_EMEDIT%> align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object id=EM_CUST_ID_S
                            classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',RD_COMP_PERS_FLAG.CodeValue);"
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                            onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,RD_COMP_PERS_FLAG.CodeValue)" />
                        <comment id="_NSID_"> <object id=EM_CUST_NAME_S
                            classid=<%=Util.CLSID_EMEDIT%> width=79 align="absmiddle"></object>
                        </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr height=1>
        <td></td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr>
        <td><%@ include file="/jsp/common/memView.jsp"%>
        </td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER
                    width="100%" height=650 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
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
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
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
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
            <c>col=ENTR_DT  	 ctrl=EM_ENTR_DT     Param=Text</c>
            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

