<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 회원탈퇴취소등록
 * 작  성  일  : 2010.03.23
 * 작  성  자  : 장형욱
 * 수  정  자  : 
 * 파  일  명  : dctm1100.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 기명회원 가입 신청서를 등록한다
 * 이         력  :
 *           2010.03.23 (장형욱) 신규작성 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
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
    String strSsno = "EM_SS_NO_S";
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
<%
    request.setCharacterEncoding("utf-8");
%>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-23
 * 개       요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input,Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');  
    
    //그리드 초기화
    gridCreate1(); //마스터
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_SS_NO_H,     "000000",     	  	  NORMAL);     //생년월일_hidden
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
    
    getEtcCode("DS_REASON_S", "D", "D019", "Y", "Y");  

    getEtcCode("DS_SCED_REQ_TYPE", "D", "D117", "Y", "Y");  

	EM_CARD_NO_CUT.Text   = "";
    EM_CARD_NO_S.Focus();    
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm110","DS_IO_MASTER");
}
 
function gridCreate1(){   
    var hdrProperies = '<FC>id={currow}       name="NO"        width=30    align=center  </FC>'
                     + '<FC>id=SAVE_CHK       name="선택"       width=40    align=center  Edit={IF(FLAG="Y","true","false")}  EditStyle=CheckBox </FC>'
                     + '<FC>id=CUST_NAME      name="회원/법인명" width=100    align=left    Edit=none</FC>'
                     + '<FC>id=SS_NO          name="생년월일,사업자번호"    width=110   align=center  Edit=none mask={decode(Len(SS_NO),13,"XXXXXX",10,"XXX-XX-XXXXX")}</FC>'
                     + '<FC>id=CARD_NO        name="카드번호"    width=147   align=center  Edit=none mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=SCED_REQ_DT    name="탈퇴요청일"  width=80    align=center  Edit=none mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REASON_NM      name="탈퇴사유"    width=90    align=left    Edit=none</FC>'
                     + '<FC>id=SCED_TAKE_NM   name="탈퇴접수형태" width=100  align=left   Edit=none</FC>'
                     + '<FC>id=POINT          name="누적포인트"   width=80   align=right   Edit=none</FC>'                     
                     + '<FC>id=REMARK   name="비고" width=150  align=left   Edit=none</FC>'
                     + '<FC>id=SCED_REQ_TYPE_NM      name="탈퇴요청형태"    width=90    align=left    Edit=none</FC>'
                     + '<FC>id=REMARK_SCED_REQ_TYPE  name="탈퇴요청비고"    width=150   align=left    Edit=none</FC>'
                     
                     + '<FC>id=CUST_ID        name="hidden"    width="165" show=false  Edit=none </FC>'
                     + '<FC>id=REASON_CD      name="hidden"    width="165" show=false  Edit=none </FC>'
                     + '<FC>id=SCED_TAKE_FLAG name="hidden"    width="165" show=false  Edit=none </FC>'
                     + '<FC>id=SCED_REQ_TYPE  name="hidden"    width="165" show=false  Edit=none </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-23
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
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
    
    srchEvent2(RD_COMP_PERS_FLAG_S.CodeValue, 'DCTM110');
    
    strCustId = EM_CUST_ID_S.text;
    strCardNo = EM_CARD_NO_S.text;
    strSSNo   = EM_SS_NO_S.text;
    
    var strCompFlag = RD_COMP_PERS_FLAG_S.CodeValue;
    
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strCustId="    + encodeURIComponent(strCustId)
                    + "&strCardNo="    + encodeURIComponent(strCardNo)
                    + "&strSSNo="      + encodeURIComponent(strSSNo)
                    + "&strCompFlag="  + encodeURIComponent(strCompFlag);

    TR_MAIN.Action  = "/dcs/dctm110.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();   

    if (DS_IO_MASTER.CountRow > 0 ) {
        setPorcCount("SELECT", DS_IO_MASTER.CountRow);
        GD_MASTER.SetColumn("REASON_CD");  
        GD_MASTER.RowPosition = i;
        GD_MASTER.Focus();        
    } else {
        if(trim(EM_CUST_NAME.Text) != ""){
            showMessage(EXCLAMATION, Ok, "USER-1000", "탈퇴하지 않은 회원이므로 조회 할 수 없습니다.");
        }else{
            setPorcCount("SELECT", DS_IO_MASTER.CountRow);
        }
        
        EM_CARD_NO_S.Focus();    
    }
}

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-23
 * 개       요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    var intRowStatus = 1;
    var intUpCnt     = 0;
    
    // 조회 내역이 없을 경우
    if(DS_IO_MASTER.CountRow < 0) {
         showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
         return;
    } else {
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if(DS_IO_MASTER.NameValue(i, "SAVE_CHK") == 'T'){
                intUpCnt++; 
                DS_IO_MASTER.UserStatus(i) = intRowStatus;             
            } else {
                DS_IO_MASTER.UserStatus(i) = 0;
            }
        }
    }
    
    // 저장할 데이터 없는 경우
    if (intUpCnt <= 0){
        showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }       
    
    var goTo        = "saveData";
    var action      = "I";  //조회는 O
    TR_MAIN.Action  ="/dcs/dctm110.dm?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();  

}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {

     initEmEdit(EM_SS_NO_H,     "000000",     		 NORMAL);     //생년월일_hidden
     initEmEdit(EM_SS_NO_S,     "000000",      		 NORMAL);     //생년월일
     initEmEdit(EM_SS_NO,       "000000-0000000",      READ);       //사업자번호
         
	DS_O_CUSTDETAIL.ClearData();
    DS_IO_MASTER.ClearData();
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
        DS_IO_MASTER.ClearData();
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
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

        initEmEdit(EM_SS_NO_H,     "000000",     		 NORMAL);     //생년월일_hidden
        initEmEdit(EM_SS_NO_S,     "000000",     		 NORMAL);     //생년월일
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
    DS_IO_MASTER.ClearData();
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

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    	getCustInfoSrch(13,EM_CARD_NO_S,'EM_CARD_NO_S',strCompPersFlag);
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_REASON_S" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SCED_REQ_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
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
                        <th width="77">회원구분</th>
                        <td colspan="5"><comment id="_NSID_"> <object
                            id=RD_COMP_PERS_FLAG_S classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 150" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="P^개인회원,C^법인회원">
                            <param name=CodeValue value="P">
                            <param name=AutoMargin value="true">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="77">카드번호</th>
                        <td width="170">
                        	<comment id="_NSID_"> <object
							id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
							tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
                        	<comment id="_NSID_"> <object
                            id=EM_CARD_NO_H  width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                            id="_NSID_"> <object id=EM_CARD_NO_S
                            classid=<%=Util.CLSID_EMEDIT%> width=105 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S',strCompPersFlag,'DCTM110');">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80"><span id="titleSsno" style="Color: 146ab9">사업자번호</span></th>
                        <td width="160"><comment id="_NSID_"> <object
                            id=EM_SS_NO_H  width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                            id="_NSID_"> <object id=EM_SS_NO_S
                            classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'<%=strSsno%>',strCompPersFlag,'DCTM110');">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80"><span id="titleCust" style="Color: 146ab9">법인명</span></th>
                        <td><comment id="_NSID_"> <object id=EM_CUST_ID_H width=0
                            classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                        </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
                            id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
                            onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',strCompPersFlag,'DCTM110');"
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                            onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,strCompPersFlag,'DCTM110')" />
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
        <td class="dot"></td>
    </tr>
    <%@ include file="/jsp/common/memView.jsp"%>
        <!-- 회원정보 공통 // -->
    <tr valign="top">
      <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
          <tr>
            <td><object id=GD_MASTER width="100%" height=373
                    classid=<%=Util.CLSID_GRID%> onClick="onClick()" tabindex=1>
                <param name="DataID" value="DS_IO_MASTER">
              </object></td>
          </tr>
        </table></td>
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
