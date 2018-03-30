<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 법인카드조회 
 * 작 성 일    : 2010.01.14
 * 작 성 자    : 김영진
 * 수 정 자    : 
 * 파 일 명    : dctm2020.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    : 
 * 이       력    :
 *           2010.01.14 (김영진) 신규작성
 *           2010.02.25 (김영진) 기능추가
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String strSsno = "EM_SS_NO_S1";
%>
<script LANGUAGE="JavaScript">
<!-- 
var strCompPersFlag = "C";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-21
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();

    //EMedit에 초기화
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_H,     "#00-00-00000",        NORMAL);     //사업자번호_hidden
    initEmEdit(EM_SS_NO_S,     "#00-00-00000",        NORMAL);     //사업자번호
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
    initEmEdit(EM_SS_NO,       "#00-00-00000",        READ);       //사업자번호
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
     
    getEtcCode("DS_O_REP_YN",   "D", "D022", "N");
    
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
    
    document.getElementById('titleCustName').innerHTML = "법인명";
    document.getElementById('titleHomePH').innerHTML   = "대표전화";
    document.getElementById('titleSsNo2').innerHTML    = "사업자번호";
    document.getElementById('titleHomeAddr').innerHTML = "사업장주소";
    document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";

    EM_CARD_NO_S.Focus();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm202","DS_O_MASTER");
}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}        name="NO"             width=30        align=center</FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=120       align=center  edit=none  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=196       align=center  edit=none  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=REP_YN          name="*대표카드여부"   width=100       align=center  EditStyle=Lookup  Data="DS_O_REP_YN:CODE:CODE"</FC>'
                     + '<FC>id=CARD_STAT_CD    name="카드상태코드"    width="80"      show=false    edit=none</FC>'
                     + '<FC>id=STAT_NM         name="카드상태"        width="110"     align=center  edit=none</FC>'
                     + '<FC>id=ENTR_PATH_CD    name="가입경로"        width="80"      show=false    edit=none</FC>'
                     + '<FC>id=BRCH_NAME       name="가입경로"        width="110"     align=left    edit=none</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류"        width="80"      show=false    edit=none</FC>'
                     + '<FC>id=TYPE_NM         name="카드종류"        width="110"     align=left    edit=none</FC>'
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
	if (DS_O_MASTER.IsUpdated){
	    if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
	        setTimeout("GR_MASTER.Focus();",50);
	        return false;
	    }
	}
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[사업자번호],[법인명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    
    if(trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "[카드번호]의 입력형식이 올바르지 않습니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    if(trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "[사업자번호]의 입력형식이 올바르지 않습니다.");
        EM_SS_NO_S.Focus();
        return;
    }
    if(trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "[법인명]의 입력형식이 올바르지 않습니다.");
        EM_CUST_ID_S.Focus();
        return;
    }
    
    if(srchEvent("C"))showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-17
 * 개       요     : DB에 저장
 * return값 : void
 */
function btn_Save() {
	 
    var intUpCnt    = 0;
    var intRepYnRow = 0;
    
    //조회 내역이 없을 경우
    if(!DS_O_MASTER.IsUpdated){
         showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
         return;
    }else{

        for(var i=1; i<=DS_O_MASTER.CountRow; i++){
            var strRepYn = DS_O_MASTER.NameValue(i, "REP_YN");
            if ( strRepYn == "Y") {
                intUpCnt++; 
                intRepYnRow = i;
            }               
        }
        if(intUpCnt == 0){
            showMessage(EXCLAMATION, OK, "USER-1000", "대표카드는 반드시 설정해야합니다.");
            GR_MASTER.SetColumn("REP_YN");  
            DS_O_MASTER.RowPosition = intRepYnRow;
            return;
        }
        if(intUpCnt > 1){
            showMessage(EXCLAMATION, OK, "USER-1000", "대표카드는 1개만 설정 가능합니다.");
            GR_MASTER.SetColumn("REP_YN");  
            DS_O_MASTER.RowPosition = intRepYnRow;
            return;
        }
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
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-25
 * 개       요     : 개인카드 리스트 조회 
 * return값 : void
 */
function showMaster(){
 
	var strCardNo   = EM_CARD_NO_S.text;
	var strSsNo     = EM_SS_NO_S.text;
	var strCustId   = EM_CUST_ID_S.text;
	if(trim(EM_CUST_ID_S.Text).length == 0){
	    strCustId   = EM_CUST_ID_H.Text;
    }
	if(trim(EM_CARD_NO_S.Text).length == 0){
	    strCardNo = EM_CARD_NO_H.Text;
	}
	if(trim(EM_SS_NO_S.Text).length == 0){
	    strSsNo = EM_SS_NO_H.Text;
    }
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strCardNo="    + encodeURIComponent(strCardNo)
                    + "&strSsNo="      + encodeURIComponent(strSsNo)
                    + "&strCustId="    + encodeURIComponent(strCustId)
    TR_MAIN.Action  ="/dcs/dctm202.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    sortColId( DS_O_MASTER, 0, "");
    if(DS_O_MASTER.CountRow > 0){
    	if(trim(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"SCED_REQ_DT")) != ""){
    		DS_O_MASTER.ClearData();
            showMessage(EXCLAMATION, OK, "USER-1000",  "탈퇴예정고객입니다. 법인카드 조회/수정이 불가합니다.");
            setTimeout("EM_CARD_NO_S.Focus();",50);
            return false;
        }
    	DS_O_MASTER.RowPosition = 0;
    	sortColId( DS_O_MASTER, 0, "CARD_NO");
        GR_MASTER.Focus();
    }else{
    	EM_CARD_NO_S.Focus();
    }
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-15
 * 개       요     : 가맹점코드 저장
 * return값 : void
 */
function saveData(){
   var goTo        = "saveData";
   var action      = "I";  //조회는 O, 저장은 I
   TR_MAIN.Action  ="/dcs/dctm202.dm?goTo="+goTo;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
   TR_MAIN.Post();

   sortColId( DS_O_MASTER, 0, "");
   showMaster();
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
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = "";
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
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
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="DS_O_REP_YN" classid=<%=Util.CLSID_DATASET%>></object>
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
		<td><%@ include file="/jsp/common/cmemSearch.jsp"%>
		</td>
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
					width="100%" height=396 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
