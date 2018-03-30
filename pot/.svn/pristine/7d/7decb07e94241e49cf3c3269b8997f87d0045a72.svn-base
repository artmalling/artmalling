<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원 찾기 팝업
 * 작  성  일  : 2010.02.28
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : CCOM4200.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.02.28 (김영진) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
	String flag = (request.getParameter("flag") != null && !"".equals(request.getParameter("flag").trim())) ? request.getParameter("flag") : "P";
	String strScrId = (request.getParameter("strScrId") != null && !"".equals(request.getParameter("strScrId").trim())) ? request.getParameter("strScrId") : "";
%>
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-28
 * 개      요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap = dialogArguments[0];

function doInit(){
    
    // Output Data Set Header 초기화
    DS_O_RESULT.setDataHeader('<gauce:dataset name="H_CUSTINFO"/>');
   
    gridCreate1(); //마스터

    //EMedit에 초기화
    initEmEdit(EM_CUST_NAME_S,     "GEN^40", NORMAL);                  //회원명
    initEmEdit(EM_MOBILE_PH1_S,    "000",    NORMAL);                  //휴대폰번호1
    initEmEdit(EM_MOBILE_PH2_S,    "0000",   NORMAL);                  //휴대폰번호2
    initEmEdit(EM_MOBILE_PH3_S,    "0000",   NORMAL);                  //휴대폰번호3
    initEmEdit(EM_HOME_PH1_S,      "000",    NORMAL);                  //전화번호1
    initEmEdit(EM_HOME_PH2_S,      "0000",   NORMAL);                  //전화번호2
    initEmEdit(EM_HOME_PH3_S,      "0000",   NORMAL);                  //전화번호3
    initEmEdit(EM_EMAIL1_S,        "GEN^50", NORMAL);                  //이메일1
    initEmEdit(EM_EMAIL2_S,        "GEN^50", NORMAL);                  //이메일2
    initComboStyle(LC_EMAIL2,DS_O_EMAIL2, "CODE^0^30,NAME^0^110", 1, NORMAL);  //이메일주소목록

    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_CARD_NO_S,      "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_S,        "000000",      		 NORMAL);     //생년월일
    
    getEtcCode("DS_O_EMAIL2", "D", "D013", "N");
    
    LC_EMAIL2.BindColVal = "99";
    EM_CUST_NAME_S.Language = 1;
    EM_CUST_NAME_S.Focus();
}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"                width=30   align=center</FC>'
                     + '<FC>id=CUST_ID         name="회원코드"          width=76    align=center</FC>'
                     + '<FC>id=CUST_NAME       name="회원명"            width=80   align=left</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"          width=140    align=center mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=SS_NO           name="생년월일"          width=70    align=center mask="XXXXXX"</FC>'
                     + '<FC>id=MOBILE_PH1      name="이동전화번호"      width=96    align=center</FC>'
                     + '<FC>id=MOBILE_PH2      name="이동전화번호"      width=0     align=center</FC>'
                     + '<FC>id=MOBILE_PH3      name="이동전화번호"      width=0     align=center</FC>'
                     + '<FC>id=HOME_PH1        name="자택전화번호"      width=96    align=center</FC>'
                     + '<FC>id=HOME_PH2        name="자택전화번호"      width=0     align=center</FC>'
                     + '<FC>id=HOME_PH3        name="자택전화번호"      width=0     align=center</FC>'
                     + '<FC>id=EMAIL1          name="이메일주소"        width=130   align=left</FC>'
                     + '<FC>id=EMAIL2          name="이메일주소"        width=0 </FC>'
                     + '<FC>id=HOME_ADDR       name="자택주소"          width=384   align=left</FC>';                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 닫기      - btn_Close()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-02-28
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_CUST_NAME_S.Text).length == 0 && trim(EM_MOBILE_PH1_S.Text).length == 0 
      && trim(EM_MOBILE_PH2_S.Text).length == 0 && trim(EM_MOBILE_PH2_S.Text).length == 0
      && trim(EM_MOBILE_PH3_S.Text).length == 0 && trim(EM_HOME_PH1_S.Text).length == 0
      && trim(EM_HOME_PH2_S.Text).length == 0  && trim(EM_HOME_PH3_S.Text).length == 0
      && trim(EM_CARD_NO_S.Text).length == 0 
      && trim(EM_SS_NO_S.Text).length == 0 
      && trim(EM_EMAIL1_S.Text).length == 0 && trim(EM_EMAIL2_S.Text).length == 0
      && LC_EMAIL2.BindColVal == "99"){
         showMessage(EXCLAMATION, OK, "USER-1000",  "조회 조건은 하나이상  반드시 입력해야 합니다.");
         EM_CUST_NAME_S.Focus();
         return;
    }
    if(trim(EM_CUST_NAME_S.text).length != 0){
        if(trim(EM_CUST_NAME_S.text).length < 2){
            showMessage(EXCLAMATION, OK, "USER-1047",  "[회원명]은 2");
            EM_CUST_NAME_S.Focus();
            return;
        }
    }
   　  if(trim(EM_MOBILE_PH1_S.Text) != "" && (trim(EM_MOBILE_PH2_S.Text) == "" || trim(EM_MOBILE_PH3_S.Text) == "")
     || trim(EM_MOBILE_PH2_S.Text) != "" && (trim(EM_MOBILE_PH1_S.Text) == "" || trim(EM_MOBILE_PH3_S.Text) == "")
     || trim(EM_MOBILE_PH3_S.Text) != "" && (trim(EM_MOBILE_PH1_S.Text) == "" || trim(EM_MOBILE_PH2_S.Text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1000",  "이동전화번호를  정확히 입력하세요.");
        if(trim(EM_MOBILE_PH1_S.Text) == ""){
            EM_MOBILE_PH1_S.Focus();
        }else if(trim(EM_MOBILE_PH2_S.Text) == ""){
            EM_MOBILE_PH2_S.Focus();
        }else if(trim(EM_MOBILE_PH3_S.Text) == ""){
            EM_MOBILE_PH3_S.Focus();
        }
        return false;
    }
    if(trim(EM_HOME_PH1_S.Text) != "" && (trim(EM_HOME_PH2_S.Text) == "" || trim(EM_HOME_PH3_S.Text) == "")
     || trim(EM_HOME_PH2_S.Text) != "" && (trim(EM_HOME_PH1_S.Text) == "" || trim(EM_HOME_PH3_S.Text) == "")
     || trim(EM_HOME_PH3_S.Text) != "" && (trim(EM_HOME_PH1_S.Text) == "" || trim(EM_HOME_PH2_S.Text) == "")){
        showMessage(EXCLAMATION, OK, "USER-1000",  "자택전화번호를  정확히 입력하세요.");
        if(trim(EM_HOME_PH1_S.Text) == ""){
            EM_HOME_PH1_S.Focus();
        }else if(trim(EM_HOME_PH2_S.Text) == ""){
            EM_HOME_PH2_S.Focus();
        }else if(trim(EM_HOME_PH3_S.Text) == ""){
            EM_HOME_PH3_S.Focus();
        }
        return false;
    }
    if(LC_EMAIL2.BindColVal == "99"){
    	if(trim(EM_EMAIL1_S.Text) == "" && (trim(EM_EMAIL2_S.Text) != "" )){
            showMessage(EXCLAMATION, OK, "USER-1000",  "이메일주소를  정확히 입력하세요.");
            EM_EMAIL1_S.Focus();
            return false;
        }else if(trim(EM_EMAIL1_S.Text) != "" && (trim(EM_EMAIL2_S.Text) == "" )){
        	showMessage(EXCLAMATION, OK, "USER-1000",  "이메일주소를  정확히 입력하세요.");
            EM_EMAIL2_S.Focus();
            return false;
        }   
    }else{
    	if(trim(EM_EMAIL1_S.Text) == "" && LC_EMAIL2.BindColVal != "99"){
            showMessage(EXCLAMATION, OK, "USER-1000",  "이메일주소를  정확히 입력하세요.");
            EM_EMAIL1_S.Focus();
            return false;
        }     
    } 
    if(trim(EM_EMAIL1_S.Text) != ""){
    	var strMail = EM_EMAIL1_S.Text + "@";
        if(LC_EMAIL2.BindColVal != "99"){
            strMail += LC_EMAIL2.Text;
        }else{
            strMail += EM_EMAIL2_S.Text;
        }
        if(!isValidStrEmail(strMail)){
            showMessage(EXCLAMATION, OK,"USER-1004","이메일");
            EM_EMAIL1_S.Focus();
            return false;
        }
    }    
    if(trim(EM_CARD_NO_S.text).length != 0){
        if(trim(EM_CARD_NO_S.text).length != 13){
        	showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호를  정확히 입력하세요.");
            EM_CARD_NO_S.Focus();
            return;
        }
    }
	/*
    if(trim(EM_SS_NO_S.text).length != 0){
        if(trim(EM_SS_NO_S.text).length != 6 && trim(EM_CUST_NAME_S.text).length != 0){
        	showMessage(EXCLAMATION, OK, "USER-1000",  "회원명과 같이 검색해야합니다");
            EM_SS_NO_S.Focus();
            return;
        }
        
        if(trim(EM_SS_NO_S.text).length == 6){
         	if(trim(EM_MOBILE_PH1_S.Text) == "" || (trim(EM_MOBILE_PH2_S.Text) == "" || trim(EM_MOBILE_PH3_S.Text) == "")){
			        showMessage(EXCLAMATION, OK, "USER-1000",  "이동전화번호를  정확히 입력하세요.");
			        if(trim(EM_MOBILE_PH1_S.Text) == ""){
			            EM_MOBILE_PH1_S.Focus();
			        }else if(trim(EM_MOBILE_PH2_S.Text) == ""){
			            EM_MOBILE_PH2_S.Focus();
			        }else if(trim(EM_MOBILE_PH3_S.Text) == ""){
			            EM_MOBILE_PH3_S.Focus();
			        }
			        return false;
			}
	     　 }
        
        
    }   
    */
    showMaster();
}


/**
* btn_Close()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-28
* 개      요  : 닫기
* return값 : void
*/
function btn_Close()
{
    window.returnValue = false; 
    window.close();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
* showMaster()
* 작   성   자 : 김영진
* 작   성   일 : 2010-02-28
* 개           요 : 회원/법인 찾기
* return값 : void
*/
function showMaster(){
    
    DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),COMP_PERS_FLAG:STRING(1),CUST_NAME:STRING(40),MOBILE_PH1:STRING(40),MOBILE_PH2:STRING(4),MOBILE_PH3:STRING(4),HOME_PH1:STRING(40),HOME_PH2:STRING(4),HOME_PH3:STRING(4),EMAIL1:STRING(40),EMAIL2:STRING(40),SCR_ID:STRING(7),CARD_NO:STRING(16),SS_NO:STRING(13)');
    
    var strCompPersFlag = '<%=flag%>';
    var strCustName = EM_CUST_NAME_S.text;
    var strMphone1  = EM_MOBILE_PH1_S.text;
    var strMphone2  = EM_MOBILE_PH2_S.text;
    var strMphone3  = EM_MOBILE_PH3_S.text;
    var strHphone1  = EM_HOME_PH1_S.text;
    var strHphone2  = EM_HOME_PH2_S.text;
    var strHphone3  = EM_HOME_PH3_S.text;
    var strEmail1   = trim(EM_EMAIL1_S.Text);
    var strEmail2   = trim(EM_EMAIL2_S.Text);
    var strScrId    = '<%=strScrId%>';
    var strCardNo   = trim(EM_CARD_NO_S.Text);
    var strSsNo     = trim(EM_SS_NO_S.Text);
    
    if(LC_EMAIL2.BindColVal == "99"){
    	strEmail2 = EM_EMAIL2_S.Text;
    }else{
    	strEmail2 = LC_EMAIL2.Text;
    }          
    
    var strServiceId= "SEL_CUSTOMER";
    var goTo        = "searchMaster" ;    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID")     = strServiceId;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "COMP_PERS_FLAG") = strCompPersFlag;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CUST_NAME")  = strCustName;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MOBILE_PH1") = strMphone1;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MOBILE_PH2") = strMphone2;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MOBILE_PH3") = strMphone3;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "HOME_PH1")   = strHphone1;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "HOME_PH2")   = strHphone2;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "HOME_PH3")   = strHphone3;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EMAIL1")     = strEmail1;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EMAIL2")     = strEmail2;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SCR_ID")     = strScrId;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CARD_NO")    = strCardNo;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SS_NO")      = strSsNo;

    TR_MAIN.Action   = "/<%=dir%>/ccom410.cc?goTo="+goTo; 
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT=DS_O_RESULT)";
    TR_MAIN.Post();

}

/**
* doDoubleClick()
* 작 성 자 : 김영진
* 작 성 일 : 2010-02-28
* 개      요  : 데이터 선택시 닫기
* return값 : void
*/
function doDoubleClick(row)
{
    if(DS_O_RESULT.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1000",  "조회 내역이 없습니다. 조회 후 처리 가능합니다.");
         return;
    }
    if( row == undefined ) 
        row = DS_O_RESULT.RowPosition;

    if (row > 0) 
    {
        var strColumnId = "";
        
        for(var i=1;i<=DS_O_RESULT.CountColumn;i++)
        {
            returnMap.put(DS_O_RESULT.ColumnID(i), DS_O_RESULT.NameValue(row, DS_O_RESULT.ColumnID(i)));
        } 
        
        window.returnValue = true;
        window.close();
    }
    return false;         
}

/**
* fn_EnterSrch()
* 작 성 자 : 김영진
* 작 성 일 : 2010-06-14
* 개      요  : ENTER 키 입력시 조회
* return값 : void
*/
function fn_EnterSrch(){
	if(trim(EM_CUST_NAME_S.text).length > 1){
		btn_Search();
        setTimeout("GR_MASTER.Focus();",50);
	} 
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
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
    if(DS_O_RESULT.CountRow > 0){
        GR_MASTER.Focus();  
    }else{
        EM_CUST_NAME_S.Focus();
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=GR_MASTER event=OnDblClick(row,colid)>
// 그리드 double 클릭이벤트에서 처리 할 내역 추가         
    doDoubleClick(row);    
//
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 도메인 OnSelChange() -->
<script language=JavaScript for=LC_EMAIL2 event=OnSelChange()>
    if(LC_EMAIL2.BindColVal == "99"){
        EM_EMAIL2_S.style.display = "";
    }else{
        EM_EMAIL2_S.style.display = "none";
    }
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
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EMAIL2" classid=<%=Util.CLSID_DATASET%>></object>
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
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02"></td>
        <td class="pop03"></td>
    </tr>
    <tr>
        <td class="pop04"></td>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="396" class="title"><img
                            src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
                            align="absmiddle" class="popR05 PL03" /> 회원명 조회</td>
                        <td>
                        <table border="0" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50"
                                    height="22" onClick="btn_Search();" /></td>
                                <td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50"
                                    height="22" onClick="doDoubleClick()" /></td>
                                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
                                    height="22" onClick="btn_Close();" /></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td class="popT01 PB03">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="o_table">
                    <tr>
                        <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"
                            class="s_table">
                            <tr>
                                <th width="100">회원명</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_CUST_NAME_S classid=<%=Util.CLSID_EMEDIT%> width=132
                                    tabindex=1 align="absmiddle"
                                    onkeyup="javascript:checkByteStr(EM_CUST_NAME_S, 40, '', '', '');" onkeydown="if(event.keyCode==13){fn_EnterSrch()}"></object>
                                </comment> <script> _ws_(_NSID_);</script>&nbsp;(2자 이상 입력하세요.)</td>
                            </tr>
                            <tr>
                                <th width="100">이동전화번호</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_MOBILE_PH1_S classid=<%=Util.CLSID_EMEDIT%> width=30
                                    tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                                - <comment id="_NSID_"> <object id=EM_MOBILE_PH2_S
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> -
                                <comment id="_NSID_"> <object id=EM_MOBILE_PH3_S
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                            </tr>
                            <tr>
                                <th width="100">자택전화번호</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_HOME_PH1_S classid=<%=Util.CLSID_EMEDIT%> width=30
                                    tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                                - <comment id="_NSID_"> <object id=EM_HOME_PH2_S
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> -
                                <comment id="_NSID_"> <object id=EM_HOME_PH3_S
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
                            </tr>
							<tr>
								<th width="100">이메일주소</th>
								<td><comment id="_NSID_"> <object id=EM_EMAIL1_S
									classid=<%=Util.CLSID_EMEDIT%> width=132 tabindex=1
									align="absmiddle" 
									onkeyup="javascript:checkByteStr(EM_EMAIL1_S, 50, '', '', '');"></object>
								</comment> <script> _ws_(_NSID_);</script> @ <comment id="_NSID_">
								<object id=LC_EMAIL2 classid=<%=Util.CLSID_LUXECOMBO%>
									height=100 width=120 align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script><comment
									id="_NSID_"> <object id=EM_EMAIL2_S
									classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
									align="absmiddle"
									onkeyup="javascript:checkByteStr(EM_EMAIL2_S, 50, '');"></object>
								</comment> <script> _ws_(_NSID_);</script></td>
							</tr>		
							<tr>
								<th width="100">카드번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
									tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
								    <comment id="_NSID_"> <object
									id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width="125"
									tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>		
							<tr>
								<th width="100">생년월일</th>
								<td><comment id="_NSID_"> <object
									id=EM_SS_NO_S classid=<%=Util.CLSID_EMEDIT%> width="125"
									tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>				
						</table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="g_table">
                    <tr>
                        <td><!-- 마스터 --> <comment id="_NSID_"> <object
                            id=GR_MASTER width="540" height=200 classid=<%=Util.CLSID_GRID%> tabindex=1>
                            <param name="DataID" value="DS_O_RESULT">
                        </object> </comment> <script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
        <td class="pop06"></td>
    </tr>
    <tr>
        <td class="pop07"></td>
        <td class="pop08"></td>
        <td class="pop09"></td>
    </tr>
</table>
</body>
</html>

