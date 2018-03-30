<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 멤버쉽운영 > 포인트양도등록
 * 작 성 일    : 2010.03.21
 * 작 성 자    : jinjung.kim
 * 수 정 자    : 
 * 파 일 명    : DMBO6090.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    : 2010.03.21 (jinjung.kim) 신규작성
 *           2010.05.04 (김영진)      신규버튼 기능 추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : jinjung.kim
 * 작 성 일     :2010.03.21
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    DS_O_CUST.setDataHeader('<gauce:dataset name="H_CUST"/>');//고객 Dataset 
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>'); //포인트 양도 마스터
    
    //그리드 초기화
    gridCreate1(); //마스터

    initEmEdit(EM_Q_CARD_NO,       "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_Q_SS_NO,         "000000",     	     NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,       "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S,     "GEN^40",              READ);       //회원명
    initEmEdit(EM_CUST_NM,         "GEN^40",              READ);       //회원명
    initEmEdit(EM_HOME_PH,         "GEN^20",              READ);       //자택전화
    initEmEdit(EM_MOBILE_PH,       "GEN^20",              READ);       //자택전화
    initEmEdit(EM_SS_NO,           "000000",     		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,       "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,           "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,    "NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,       "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,           "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_CUST_GTADE,      "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,       "GEN^40",     		  READ);       //회원유형
    initEmEdit(EM_GRANTOR,         "GEN^40",              READ);       //양도자
    initEmEdit(EM_GRANTEE,         "GEN^40",              READ);       //양수자
    initEmEdit(EM_GRANTOR_CARD_NO, "0000-0000-0000-0000", READ);       //카드번호
    initEmEdit(EM_GRANTEE_CARD_NO, "0000-0000-0000-0000", READ);       //카드번호
    initEmEdit(EM_PWD_NO,          "0000",                PK);     //누적포인트
    initEmEdit(EM_MOVE_POINT,      "NUMBER^9^0",          PK);     //양도포인트

    EM_PWD_NO.IsComma          = false;
    EM_PWD_NO.format           = "0000";

    EM_CUST_ID_H.style.display = "none";
    EM_CARD_NO_H.style.display = "none";
    EM_SS_NO_H.style.display   = "none";

    EM_Q_CARD_NO.focus();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmbo609","DS_IO_MASTER,DS_O_CUST");

}

/**
 * gridCreate1()
 * 작 성 자     : jinjung.kim
 * 작 성 일     :2010.03.21
 * 개       요  : 그리드 초기화
 * return값 : void
 */ 
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"             width=30   align=center  </FC>'
                     + '<FC>id=CHK         name="선택"           width=30   align=center  EditStyle=Checkbox  </FC>'
                     + '<FC>id=HHOLD_ID    name="세대주"         width=110  align=center  Edit=none show=false  </FC>'
                     + '<FC>id=HHOLD_NM    name="세대주명"       width=164  align=left    Edit=none </FC>'
                     + '<FC>id=CUST_ID     name="세대원"         width=110  align=center  Edit=none show=false </FC>'
                     + '<FC>id=CUST_NM     name="세대원명"       width=164  align=left    Edit=none </FC>'
                     + '<FC>id=CARD_NO     name="카드번호"       width=250  align=center  Edit=none mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=POINT       name="누적포인트"     width=135   align=right  Edit=none </FC>';

    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}


/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 신규       - btn_New()
     (3) 엑셀       - btn_Excel()
     (4) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.21
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
     if(trim(EM_Q_CARD_NO.Text).length == 0 && trim(EM_Q_SS_NO.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호/생년월일/회원명 중 하나는 반드시 입력되어야 합니다.");
        EM_Q_CARD_NO.Focus();
        return;
     }else {
        if (trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length != 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
            EM_CUST_ID_S.focus();
            return;
       }
    }
     
     EXCEL_PARAMS  = "카드번호="  + EM_Q_CARD_NO.Text;
     EXCEL_PARAMS += "-생년월일=" + EM_Q_SS_NO.Text;
     EXCEL_PARAMS += "-회원="     + EM_CUST_ID_S.Text;
     EXCEL_PARAMS += "-회원명="   + EM_CUST_NAME_S.Text;
     
    
    EM_EMAIL.Text     = "";
    EM_HOME_PH.Text   = "";
    EM_MOBILE_PH.Text = "";

    showMaster();

    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.05.04
 * 개       요 : 초기화
 * return값 : void
 */
function btn_New() {
	DS_IO_MASTER.ClearData();
	DS_O_CUST.ClearData();
	EM_SS_NO.Text       = "";
	initEmEdit(EM_SS_NO,          "000000",      READ);
    EM_EMAIL.Text       = "";
	EM_HOME_PH.Text     = "";
	EM_MOBILE_PH.Text   = "";
	EM_Q_CARD_NO.Text   = "";
    EM_Q_SS_NO.Text     = "";
    EM_CUST_ID_S.Text   = "";
    EM_CUST_NAME_S.Text = "";
	EM_CARD_NO_CUT.Text   = "";	
	
	EM_PWD_NO.Text     = "";
    EM_MOVE_POINT.Text   = "";
}

/**
 * btn_Excel()
 * 작 성 자     :jinjung.kim
 * 작 성 일     : 2010.03.21
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";
    var ExcelTitle = "포인트양도등록";
    openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
}

/**
 * btn_Save()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.03.21
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    if ( !check_data() ) return ;
    var ds = DS_IO_MASTER;
    var PWD_NO = DS_O_CUST.NameValue(1, "PWD_NO");

    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    }
   
    for (var i = 1; i <= ds.CountRow; i++) {
        if (ds.NameValue(i, "CHK") == "T" && ds.NameValue(i, "MOVE_POINT") > 0 && trim(ds.NameValue(i, "MOVE_POINT").toString()).length > 0) {
            ds.NameValue(i, "PWD_NO") = PWD_NO;
        }
    }

    saveData();
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.21
 * 개       요     : 포인트 양도 등록 조회
 * return값 : void
 */
function showMaster(){
    var goTo        = "searchMaster";    
    var parameters  = "&SS_NO="     + encodeURIComponent(EM_Q_SS_NO.Text);
        parameters += "&CARD_NO="   + encodeURIComponent(EM_Q_CARD_NO.Text);
        parameters += "&CUST_ID="   + encodeURIComponent(EM_CUST_ID_S.Text);

    TR_RETRIEVE.Action  ="/dcs/dmbo609.do?goTo="+goTo+parameters;  
    TR_RETRIEVE.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER,O:DS_O_CUST=DS_O_CUST)"; 
    TR_RETRIEVE.Post();
}

/**
 * saveData()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.21
 * 개       요     : 포인트 양도 등록 저장
 * return값 : void
 */
function saveData() {
    var goTo = "saveData";
    TR_SAVE.Action  ="/dcs/dmbo609.do?goTo="+goTo;
    TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
    TR_SAVE.Post();  
}

/**
 * check_data()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.21
 * 개       요     : 포인트 양도 등록 저장시 유효성 검증.
 * return값 : void
 */
function check_data() {

    if (DS_O_CUST.CountRow <= 0 || !DS_IO_MASTER.IsUpdated) return false;

    var POINT = DS_O_CUST.NameValue(1, "POINT");   
    if (POINT == 0 || trim(POINT.toString()).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "양도자의 누적포인트가 존재하지 않습니다.");
        return false;
    }

    var ds = DS_IO_MASTER;

    var CHECK_COUNT = 0;
    var MOVE_POINT_SUM = 0;
    for (var i = 1; i <= ds.CountRow; i++) {
        if (ds.NameValue(i, "CHK") == "T") {
            CHECK_COUNT++;
            MOVE_POINT_SUM += ds.NameValue(i, "MOVE_POINT");
        }

        var GRANTOR_CARD_NO = ds.NameValue(i, "GRANTOR_CARD_NO");
        if (trim(GRANTOR_CARD_NO).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "양도자의 유효한 카드가 존재하지 않습니다.");
            return false;
        }
        var CARD_NO = ds.NameValue(i, "CARD_NO");
        if(trim(CARD_NO).length == 0) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "양수자의 유효한 카드가 존재하지 않습니다.");
            return false;
        }
    }
    if (0 == CHECK_COUNT) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "선택된 양수자가 존재하지 않습니다.");
        GR_MASTER.SetColumn("CHK");
        return false;
    }
    if (MOVE_POINT_SUM == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "양도할 포인트를 입력하십시오.");
        EM_MOVE_POINT.focus();
        return false;
    }
    if(parseInt(trim(EM_MOVE_POINT.Text)) < 0){
        showMessage(EXCLAMATION, OK, "USER-1004",  "양도포인트");
        EM_MOVE_POINT.Focus();
        return;
    }
    if (MOVE_POINT_SUM > POINT) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "양도할 포인트가 양도자의 누적 포인트보다 큽니다.");
        EM_MOVE_POINT.focus();
        return false;
    }
/*    
    if (trim(DS_O_CUST.NameValue(1, "PWD_NO")).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "비밀번호를 입력하십시오.");
        EM_PWD_NO.focus();
        return false;
    }
    if (trim(DS_O_CUST.NameValue(1, "PWD_NO")).length != 4) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "비밀번호 자릿수를 확인하세요.");
        EM_PWD_NO.focus();
        return false;
    }
*/
    return true;
}

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
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
<script language=JavaScript for=TR_RETRIEVE event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_O_CUST.CountRow > 0) {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    } else {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    }
    if (DS_IO_MASTER.CountRow > 0) {
        GR_MASTER.focus();
    } else {
        EM_Q_CARD_NO.focus();
    }
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    btn_Search();
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_RETRIEVE event=onFail>
    trFailed(TR_RETRIEVE.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 고객정보 조회완료  OnLoadCompleted(rowcnt) -->
<script language=JavaScript for=DS_O_CUST event=OnLoadCompleted(rowcnt)>
    if (rowcnt <= 0) return;

    var email  = this.NameValue(1, "EMAIL1") + this.NameValue(1, "EMAIL2"); 
    var home   = this.NameValue(1, "HOME_PH1") + this.NameValue(1, "HOME_PH2") + this.NameValue(1, "HOME_PH3"); 
    var mobile = this.NameValue(1, "MOBILE_PH1") + this.NameValue(1, "MOBILE_PH2") + this.NameValue(1, "MOBILE_PH3"); 
    
    if ("" != email) {
        EM_EMAIL.Text = this.NameValue(1, "EMAIL1") + "@" +  this.NameValue(1, "EMAIL2");
    }
    if ("" != home) {
        EM_HOME_PH.Text = this.NameValue(1, "HOME_PH1") + "-" + this.NameValue(1, "HOME_PH2") +"-" + this.NameValue(1, "HOME_PH3"); 
    }
    if ("" != mobile) {
        EM_MOBILE_PH.Text = this.NameValue(1, "MOBILE_PH1") +"-" + this.NameValue(1, "MOBILE_PH2") +"-" + this.NameValue(1, "MOBILE_PH3"); 
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
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
		EM_Q_CARD_NO.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
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
  <object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_CUST"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_RETRIEVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

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
       <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="77">카드번호</th> 
                <td width="170">
							<comment id="_NSID_"> <object style="display:none"
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                  <comment id="_NSID_">
                    <object id=EM_Q_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width="155" tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">생년월일</th>
                <td width="150">
                  <comment id="_NSID_">
                    <object id=EM_Q_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=105  tabindex=1 ></object>
                    </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">회원명</th>
                <td>
                  <comment id="_NSID_">
                    <object id=EM_CUST_ID_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                   <comment id="_NSID_">
                    <object id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                   <comment id="_NSID_">
                    <object id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <comment id="_NSID_">
                    <object id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1 onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S','P');" align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'P')"/> 
                  <comment id="_NSID_">
                    <object id=EM_CUST_NAME_S classid=<%=Util.CLSID_EMEDIT%> width=75 align="absmiddle"></object>       
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
      <td class="dot"></td>
    </tr>
    <tr>
      <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80">회원명</th>
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_CUST_NM classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object> 
                 </comment>
                 <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">자택전화</th> 
                <td width="160">
                  <comment id="_NSID_">
                  <object id=EM_HOME_PH classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  </td>
                <th width="80">이동전화</th>
                <td>
                  <comment id="_NSID_">
                  <object id=EM_MOBILE_PH classid=<%=Util.CLSID_EMEDIT%> width=168 tabindex=1></object>
                 </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
              </tr>
             <tr>
                <th width="80">생년월일</th>
                <td>
                  <comment id="_NSID_">
                   <object id=EM_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                   </td>
                <th>회원주소</th>
                <td colspan="3">
                  <comment id="_NSID_">
                <object id=EM_HOME_ADDR classid=<%=Util.CLSID_EMEDIT%> width=429 tabindex=1 align="absmiddle"></object>
                 </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
              </tr>
              <tr>
                <th >가용포인트</th>
                <td>
                  <comment id="_NSID_">       
                    <object id=EM_POINT classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>  
                </td>     
                <th>이메일주소</th>
                <td>
                  <comment id="_NSID_">     
                    <object id=EM_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>     
                </td>
                <th>회원등급</th>
                <td>
                  <comment id="_NSID_">       
                    <object id=EM_CUST_GTADE classid=<%=Util.CLSID_EMEDIT%> width=168 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script> 
                </td>
              </tr>
              <tr>           
				<th>회원유형</th>
				<td colspan="5"><comment id="_NSID_"> <object id=EM_CUST_TYPE
					classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
				</td>  
                <th style="display:none">발생포인트</th>
                <td style="display:none">
                  <comment id="_NSID_">       
                    <object id=EM_OCCURS_POINT classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>  
                </td>
				<th style="display:none">가용+발생</th>
				<td style="display:none"><comment id="_NSID_"> <object id=EM_SUM_POINT
					classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GR_MASTER width="100%" height=347 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_IO_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
     <td> 
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80">양도자 성명</th>
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_GRANTOR classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object> 
                 </comment>
                 <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">카드번호</th> 
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_GRANTOR_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width="140" tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
                 <th  width="80" class="point" style="display : none">비밀번호</th>
                <td style="display : none">
                  <comment id="_NSID_">       
                    <object id=EM_PWD_NO classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>  
                </td>     
            </tr>
            <tr>
                <th width="80">양수자 성명</th>
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_GRANTEE classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object> 
                 </comment>
                 <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">카드번호</th> 
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_GRANTEE_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width="140" tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
                <th  width="80" class="point">양도포인트</th>
                <td>
                  <comment id="_NSID_">       
                    <object id=EM_MOVE_POINT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>  
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
  <object id=BD_MASTER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_IO_MASTER>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
            <c>col=GRANTOR_NM       ctrl=EM_GRANTOR             Param=Text </c>
            <c>col=GRANTOR_CARD_NO  ctrl=EM_GRANTOR_CARD_NO     Param=Text </c>
            <c>col=CUST_NM          ctrl=EM_GRANTEE             Param=Text </c>
            <c>col=CARD_NO          ctrl=EM_GRANTEE_CARD_NO     Param=Text </c>
            <c>col=MOVE_POINT       ctrl=EM_MOVE_POINT          Param=Text </c>
        '>
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=BD_DETAIL classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_O_CUST>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
            <c>col=CUST_NAME      ctrl=EM_CUST_NM            Param=Text </c>
            <c>col=SS_NO          ctrl=EM_SS_NO              Param=Text </c>
            <c>col=HOME_ADDR      ctrl=EM_HOME_ADDR          Param=Text </c>
            <c>col=POINT          ctrl=EM_POINT              Param=Text </c>
            <c>col=OCCURS_POINT   ctrl=EM_OCCURS_POINT       Param=Text </c>
            <c>col=SUM_POINT      ctrl=EM_SUM_POINT    		 Param=Text</c>
            <c>col=CUST_GRADE_NM  ctrl=EM_CUST_GTADE         Param=Text </c>
            <c>col=PWD_NO         ctrl=EM_PWD_NO             Param=Text </c>
            <c>col=CUST_TYPE_NM   ctrl=EM_CUST_TYPE          Param=Text</c>
        '>
  </object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

