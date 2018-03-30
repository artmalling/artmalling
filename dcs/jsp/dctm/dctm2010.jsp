<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 카드관리 > 개인카드조회
 * 작 성 일    : 2010.01.14
 * 작 성 자    : 김영진
 * 수 정 자    : 
 * 파 일 명    : dctm2010.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.01.14 (김영진) 신규작성
 *           2010.02.25 (김영진) 기능추가
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
	String strSsNo 	= (request.getParameter("strSsNo") != null && !"".equals(request.getParameter("strSsNo").trim())) ? request.getParameter("strSsNo") : "";
	String strCardNo= (request.getParameter("strCardNo") != null && !"".equals(request.getParameter("strCardNo").trim())) ? request.getParameter("strCardNo") : "";
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
<!--
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
 var top = 240;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	 
	//Output Data Set Header 초기화
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();
    
    //EMedit에 초기화
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_H,     "000000",     	 	  NORMAL);     //생년월일_hidden
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
    initEmEdit(EM_SS_NO,       "000000",   		      READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
    initEmEdit(EM_ENTR_DT,    "YYYYMMDD",             READ);       //가입일자 추가 16.12.22

   
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
    
    if("<%=strSsNo%>" != "" || "<%=strCardNo%>" != ""){
    	EM_SS_NO_S.Text = "<%=strSsNo%>";
    	EM_CARD_NO_S.Text = "<%=strCardNo%>";
    	btn_Search();
    }    
}
 
function gridCreate1(){
   
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center</FC>'
                     + '<FC>id=ISSUE_DT        name="발급일자"        width=90   align=center  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CARD_NO         name="카드번호"        width=150  align=center  mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=POCARD_PREFIX  name="패밀리카드구분"   width=117   show=false</FC>'
                     + '<FC>id=POCARD_PREFIX_NM  name="패밀리카드구분"   width=117  align=center </FC>'
                     + '<FC>id=MAN_NM          name="세대주명"        width=100  align=left</FC>'
                     + '<FC>id=CARD_STAT_CD    name="카드상태코드"    width=100  show=false</FC>'
                     + '<FC>id=STAT_NM         name="카드상태"        width=90   align=center</FC>'
                     + '<FC>id=ENTR_PATH_CD    name="가입경로"        width=80   show=false</FC>'
                     + '<FC>id=BRCH_NAME       name="가입경로"        width=100  align=left</FC>'
                     + '<FC>id=CARD_TYPE_CD    name="카드종류"        width=120   show=false</FC>'
                     + '<FC>id=TYPE_NM         name="카드종류"        width=120  align=left</FC>'
                     + '<FC>id=REMARK          name="분실처리이력"    width=117  align=left </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
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
    
    if(srchEvent("P"))showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {

     initEmEdit(EM_SS_NO_H,     "000000",      		   NORMAL);     //생년월일_hidden
     initEmEdit(EM_SS_NO_S,     "000000",     		   NORMAL);     //생년월일
     initEmEdit(EM_SS_NO,       "000000-0000000",      READ);       //사업자번호
   
	DS_O_CUSTDETAIL.ClearData();
    DS_O_MASTER.ClearData();
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
    TR_MAIN.Action  ="/dcs/dctm201.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //sortColId( DS_O_MASTER, 0, "");
    if(DS_O_MASTER.CountRow > 0){
    	DS_O_MASTER.RowPosition = 0;
        //sortColId( DS_O_MASTER, 0, "CARD_NO");
        GR_MASTER.Focus();
    }else{
        EM_CARD_NO_S.Focus();
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
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
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
		<td><%@ include file="/jsp/common/cmemSearch.jsp"%> 
		</td>
	</tr>
		<tr>
	    <td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm203.dm','개인회원조회/수정','DCTM')">개인회원조회/수정</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l" style="display:none"> </td>
			    <td class="btn_c" style="display:none"><a href="#" onclick="gourl('dmbo622.do','영수증사후적립 (고객미등록)','DMBO')">영수증사후적립</a></td>
			    <td class="btn_r" style="display:none"></td>
			    <td class="btn_l" style="display:none"> </td>
			    <td class="btn_c" style="display:none"><a href="#" onclick="gourl('dmbo999.do','회원정보안내(소멸예정)','DMBO')">회원정보안내(소멸예정)</a></td>
			    <td class="btn_r" style="display:none"></td>
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
		<td><%@ include file="/jsp/common/memView.jsp"%> 
		</td>
	</tr>

	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" 
			class="BD4A"> 
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=660 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
            <c>col=ENTR_DT  	 ctrl=EM_ENTR_DT      Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

