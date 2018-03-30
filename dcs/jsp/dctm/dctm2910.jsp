<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 연계카드등록
 * 작 성 일    : 
 * 작 성 자    : 
 * 수 정 자    : 
 * 파 일 명    : dctm2910.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           
 *           
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
	String strSsno = "EM_SS_NO_S";
%>
<script LANGUAGE="JavaScript">

var strCompPersFlag = "P";
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
	 
	//Output Data Set Header 초기화
	DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1();
    gridCreate2();
    
    getEtcCode("DS_POCARD_PREFIX", "D", "D104", "N");
    
    
    
    
    //EMedit에 초기화
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_H,     "000000",      		  NORMAL);     //생년월일_hidden
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
    initEmEdit(EM_SS_NO,       "000000",     		  READ);       //생년월일
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
    
    EM_CARD_NO_S.Focus();
    
    if("<%=strSsNo%>" != ""){
    	EM_SS_NO_S.Text = "<%=strSsNo%>";
    	if(srchEvent("P"))showMaster();
    }
}
 
function gridCreate1(){
   
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center</FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=90   align=center  mask="XXXX/XX/XX" edit=none</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=150  align=center  mask="XXXX-XXXX-XXXX-XXXX" edit=none</FC>'
                     + '<FC>id=POCARD_PREFIX  name="패밀리카드구분"   width=117   EditStyle=Lookup   Data="DS_POCARD_PREFIX:CODE:NAME"</FC>'
                     + '<FC>id=POCARD_PREFIX_NM  name="패밀리카드구분"   width=117  align=center show=false</FC>'
                     + '<FC>id=MAN_NM          name="세대주명"        width=100  align=left edit=none</FC>'
                     + '<FC>id=CARD_STAT_CD    name="카드상태코드"    width=100  show=false </FC>'
                     + '<FC>id=STAT_NM         name="카드상태"        width=90   align=center edit=none</FC>'
                     + '<FC>id=ENTR_PATH_CD    name="가입경로"        width=80   show=false</FC>'
                     + '<FC>id=BRCH_NAME       name="가입경로"        width=100  align=left edit=none</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류"        width=80   show=false</FC>'
                     + '<FC>id=TYPE_NM         name="카드종류"        width=100  align=left edit=none</FC>'
                     + '<FC>id=REMARK          name="분실처리이력"    width=117  align=left edit=none</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
	   
    var hdrProperies = '<FC>id={currow}        name="NO"            width=30   align=center</FC>'
                     + '<FC>id=LINK_CARD_NO    name="*연계카드번호"   width=160  align=center  mask="XXXX-XXXX-XXXX-XXXX" edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"       width=150  align=center  mask="XXXX-XXXX-XXXX-XXXX" show=false</FC>'
                     + '<FC>id=POCARD_PREFIX   name="*패밀리카드구분" width=110  align=center  EditStyle=Lookup   Data="DS_POCARD_PREFIX:CODE:NAME" edit=none</FC>'
                     + '<FC>id=CARD_TYPE_CD			   name="*패밀리카드" width=100  align=center edit="none" show=false</FC>'
                     + '<FC>id=REG_DATE        name="등록일시"       width=140   		align=center  	edit=none</FC>'
                     + '<FC>id=REG_ID          name="등록자ID"    	width=100      	align=center 	edit=none</FC>'
                     + '<FC>id=MOD_DATE        name="수정일시"    	width=140 	 	align=center  	edit=none</FC>'
                     + '<FC>id=MOD_ID          name="수정자ID"    	width=100      	align=center 	edit=none</FC>';
                     
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
}
/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(INFORMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    
    // MARIO OUTLET
    //if(trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16 ){
    if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {		
        showMessage(INFORMATION, OK, "USER-1000",  "[카드번호]의 입력형식이 올바르지 않습니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    if(trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6 ){
        showMessage(INFORMATION, OK, "USER-1000",  "[생년월일]의 입력형식이 올바르지 않습니다.");
        EM_SS_NO_S.Focus();
        return;
    }
    if(trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9 ){
        showMessage(INFORMATION, OK, "USER-1000",  "[회원명]의 입력형식이 올바르지 않습니다.");
        EM_CUST_ID_S.Focus();
        return;
    }
    
    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated ) {
        ret = showMessage(QUESTION, YESNO, "USER-1059");
        if (ret != "1") {
            return false;
        } 
    }
    
    DS_IO_DETAIL.ClearData();
    if(srchEvent("P"))showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}


/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {

     initEmEdit(EM_SS_NO_H,     "000000",    		   NORMAL);     //생년월일_hidden
     initEmEdit(EM_SS_NO_S,     "000000",    		   NORMAL);     //생년월일
     initEmEdit(EM_SS_NO,       "000000-0000000",      READ);       //사업자번호
   
	DS_O_CUSTDETAIL.ClearData();
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    
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
                    ;
    TR_MAIN.Action  ="/dcs/dctm291.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    sortColId( DS_IO_MASTER, 0, "");
    
    if(DS_IO_MASTER.CountRow > 0){
    	DS_IO_MASTER.RowPosition = 0;
        sortColId( DS_IO_MASTER, 0, "CARD_NO");
        GR_MASTER.Focus();
        searchDetail();
    }else{
        EM_CARD_NO_S.Focus();
    }

}



function searchDetail(){

	
	var strCardNo        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CARD_NO");
    
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strCardNo="      + encodeURIComponent(strCardNo);
    
    TR_DETAIL.Action="/dcs/dctm291.dm?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
   
}


function btn_Add1(){
	
	if(DS_IO_MASTER.RowPosition > 0) {
    	DS_IO_DETAIL.Addrow();
    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"CARD_NO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CARD_NO");
    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"CARD_TYPE_CD") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CARD_TYPE_CD");
    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"POCARD_PREFIX") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"POCARD_PREFIX");
    	 
	}
}


function btn_Del1(){
	
	var row = DS_IO_DETAIL.RowPosition;
	DS_IO_DETAIL.DeleteRow(row);
	
}

function btn_Save() {
	
	if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
        
    }
	
	
	for(vari=1;i<DS_IO_DETAIL.CountRow;i++)
	{
		var vLcNo 		= DS_IO_DETAIL.NameValue(i,"LINK_CARD_NO");
		var vCNo  		= DS_IO_DETAIL.NameValue(i,"CARD_NO");
		var vPcPrefix 	= DS_IO_DETAIL.NameValue(i,"POCARD_PREFIX");
		
		
		
		
		if(trim(vLcNo).length < 1){
	        showMessage(INFORMATION, OK, "USER-1003",  "연계카드번호.");
	        DS_IO_DETAIL.RowPosition = i;
	        return;
	    }
		
		// MARIO OUTLET
		//if(trim(vLcNo).length > 0 && trim(vLcNo).length < 16 ){
		if(trim(vLcNo).length != 0 && trim(vLcNo).length != 13 && trim(vLcNo).length != 16 ) {	
	        showMessage(INFORMATION, OK, "USER-1000",  "[연계카드번호]의 입력형식이 올바르지 않습니다.");
	        DS_IO_DETAIL.RowPosition = i;
	        return;
	    }
		
		if(trim(vPcPrefix).length < 1){
	        showMessage(INFORMATION, OK, "USER-1002",  "패밀리카드구분");
	        DS_IO_DETAIL.RowPosition = i;
	        return;
	    }
		
	}
	
	var retChk  = checkDupKey(DS_IO_DETAIL, "LINK_CARD_NO");
	 
    if (retChk != 0) {
        showMessage(Information, OK, "USER-1044",retChk);
        return;
    }
	
	
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
    
    TR_MAIN.Action="/dcs/dctm291.dm?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL, I:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
    
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	searchDetail();
	    
    }
    
        
}

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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=Javascript>
    // 이전 Focus에 대한 정보를 저장한다.
    var old_Row = 0;
</script>

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

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
	
	if(row > 0 && old_Row != row ){
		if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated ) {
		    ret = showMessage(QUESTION, YESNO, "USER-1059");
		    if (ret != "1") {
		    	DS_IO_MASTER.RowPosition = old_Row;
		        return;
		    } else {
		    	var ColCnt = this.CountColumn;
                for( var i=1; i<=ColCnt;i++){
                    if(this.RWStatus(old_Row,i) != 0)
                        this.NameValue( old_Row, this.ColumnID(i)) = this.OrgNameValue(old_Row,this.ColumnID(i));
                }
	                
		    }
		    
		}
		searchDetail();
	}
	
	
	old_Row = row;
	
	
	
	
</script> 

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	
	if(colid == "POCARD_PREFIX") {
		var vPoCardPrefix = DS_IO_MASTER.NameValue(row,colid);
		
		for(var i =1;i<=DS_IO_DETAIL.CountRow;i++)
		{
			DS_IO_DETAIL.NameValue(i,"POCARD_PREFIX") = vPoCardPrefix;
		}
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
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
    <object id="DS_POCARD_PREFIX" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
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
					width="100%" height=190 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title PB03 PT10"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" /> 연계카드(주사용카드)↓카드번호 사용시 ↑카드번호 사용처리 </td>
				<td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif"
					hspace="2" onclick="javascript:btn_Add1();" /> <img
					src="/<%=dir%>/imgs/btn/del_row.gif"
					onclick="javascript:btn_Del1();" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" 
			class="BD4A"> 
			<tr>
				<td><comment id="_NSID_"> <object id=GD_DETAIL
					width="100%" height=174 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_DETAIL">
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

