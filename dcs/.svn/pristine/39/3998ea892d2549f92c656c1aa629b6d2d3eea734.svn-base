<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 기타작업 > 회원정보 이행작업 
 * 작 성 일    : 2010.05.25
 * 작 성 자    : 김영진
 * 수 정 자    : 
 * 파 일 명    : dctm1910.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    : 
 * 이       력    :
 *           2010.05.25 (김영진) 신규작성
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strSeqNoS   = "1";
var strSeqNoE   = "100";
var strAutoSrch = "N";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    //Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); 
    gridCreate2();
    
    initEmEdit(EM_SEQ_NO_S, "NUMBER^7^0", PK);
    initEmEdit(EM_SEQ_NO_E, "NUMBER^7^0", PK);
    
    EM_SEQ_NO_S.Text = strSeqNoS;
    EM_SEQ_NO_E.Text = strSeqNoE;
}
     
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       name="NO"           width=30   align=left</FC>'
                     + '<FC>id=SEQ_NO         name=SEQ_NO         width=100  align=right</FC>'
                     + '<FC>id=MEMBERID       name=MEMBERID       width=100  align=left</FC>'
                     + '<FC>id=MEMBERNAME     name=MEMBERNAME     width=100  align=left</FC>'
                     + '<FC>id=PASSWORD       name=PASSWORD       width=100  align=left</FC>'
                     + '<FC>id=SS_NO          name=SS_NO          width=100  align=left</FC>'
                     + '<FC>id=EMAIL1         name=EMAIL1         width=100  align=left</FC>'
                     + '<FC>id=EMAIL2         name=EMAIL2         width=100  align=left</FC>'
                     + '<FC>id=BIRTH_DT       name=BIRTH_DT       width=100  align=left</FC>'
                     + '<FC>id=LUNAR_FLAG     name=LUNAR_FLAG     width=100  align=left</FC>'
                     + '<FC>id=HOME_ZIP_CD    name=HOME_ZIP_CD    width=100  align=left</FC>'
                     + '<FC>id=HOME_ADDR1     name=HOME_ADDR1     width=100  align=left</FC>'
                     + '<FC>id=HOME_ADDR2     name=HOME_ADDR2     width=100  align=left</FC>'
                     + '<FC>id=REG_DATE       name=REG_DATE       width=100  align=left</FC>'
                     + '<FC>id=EMAIL_YN       name=EMAIL_YN       width=100  align=left</FC>'
                     + '<FC>id=HOME_PH        name=HOME_PH        width=100  align=left</FC>'
                     + '<FC>id=MOBILE_PH      name=MOBILE_PH      width=100  align=left</FC>'
                     + '<FC>id=HOME_ZIP_SEQ   name=HOME_ZIP_SEQ   width=100  align=left</FC>'
                     + '<FC>id=USE_YN         name=USE_YN         width=100  align=left</FC>'
                     + '<FC>id=MOD_DATE       name=MOD_DATE       width=100  align=left</FC>'
                     + '<FC>id=CUST_FLAG      name=CUST_FLAG      width=100  align=left</FC>'
                     + '<FC>id=CUST_POINT     name=CUST_POINT     width=100  align=left</FC>'
                     + '<FC>id=SCOMP_EMP_YN   name=SCOMP_EMP_YN   width=100  align=left</FC>'
                     + '<FC>id=EMP_ID         name=EMP_ID         width=100  align=left</FC>'
                     + '<FC>id=DEPT_CD        name=DEPT_CD        width=100  align=left</FC>'
                     + '<FC>id=PROM_FLAG      name=PROM_FLAG      width=100  align=left</FC>'
                     + '<FC>id=CFM_REQNUM     name=CFM_REQNUM     width=100  align=left</FC>'
                     + '<FC>id=CFM_IPIN       name=CFM_IPIN       width=100  align=left</FC>'
                     + '<FC>id=CFM_DCHECK     name=CFM_DCHECK     width=100  align=left</FC>'
                     + '<FC>id=PROM_USER_ID   name=PROM_USER_ID   width=100  align=left</FC>'
                     + '<FC>id=PROM_CD        name=PROM_CD        width=100  align=left</FC>'
                     + '<FC>id=CARD_ISSUE_YN  name=CARD_ISSUE_YN  width=100  align=left</FC>'
                     + '<FC>id=TEMP_FLAG      name=TEMP_FLAG      width=100  align=left show=false</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}       name="NO"           width=30   align=left</FC>'
    	             + '<FC>id=SEQ_NO         name=SEQ_NO         width=100  align=right</FC>'
                     + '<FC>id=MEMBERID       name=MEMBERID       width=100  align=left</FC>'
                     + '<FC>id=MEMBERNAME     name=MEMBERNAME     width=100  align=left</FC>'
                     + '<FC>id=PASSWORD       name=PASSWORD       width=100  align=left</FC>'
                     + '<FC>id=SS_NO          name=SS_NO          width=100  align=left</FC>'
                     + '<FC>id=EMAIL1         name=EMAIL1         width=100  align=left</FC>'
                     + '<FC>id=EMAIL2         name=EMAIL2         width=100  align=left</FC>'
                     + '<FC>id=BIRTH_DT       name=BIRTH_DT       width=100  align=left</FC>'
                     + '<FC>id=LUNAR_FLAG     name=LUNAR_FLAG     width=100  align=left</FC>'
                     + '<FC>id=HOME_ZIP_CD    name=HOME_ZIP_CD    width=100  align=left</FC>'
                     + '<FC>id=HOME_ADDR1     name=HOME_ADDR1     width=100  align=left</FC>'
                     + '<FC>id=HOME_ADDR2     name=HOME_ADDR2     width=100  align=left</FC>'
                     + '<FC>id=REG_DATE       name=REG_DATE       width=100  align=left</FC>'
                     + '<FC>id=EMAIL_YN       name=EMAIL_YN       width=100  align=left</FC>'
                     + '<FC>id=HOME_PH        name=HOME_PH        width=100  align=left</FC>'
                     + '<FC>id=MOBILE_PH      name=MOBILE_PH      width=100  align=left</FC>'
                     + '<FC>id=HOME_ZIP_SEQ   name=HOME_ZIP_SEQ   width=100  align=left</FC>'
                     + '<FC>id=USE_YN         name=USE_YN         width=100  align=left</FC>'
                     + '<FC>id=MOD_DATE       name=MOD_DATE       width=100  align=left</FC>'
                     + '<FC>id=CUST_FLAG      name=CUST_FLAG      width=100  align=left</FC>'
                     + '<FC>id=CUST_POINT     name=CUST_POINT     width=100  align=left</FC>'
                     + '<FC>id=SCOMP_EMP_YN   name=SCOMP_EMP_YN   width=100  align=left</FC>'
                     + '<FC>id=EMP_ID         name=EMP_ID         width=100  align=left</FC>'
                     + '<FC>id=DEPT_CD        name=DEPT_CD        width=100  align=left</FC>'
                     + '<FC>id=PROM_FLAG      name=PROM_FLAG      width=100  align=left</FC>'
                     + '<FC>id=CFM_REQNUM     name=CFM_REQNUM     width=100  align=left</FC>'
                     + '<FC>id=CFM_IPIN       name=CFM_IPIN       width=100  align=left</FC>'
                     + '<FC>id=CFM_DCHECK     name=CFM_DCHECK     width=100  align=left</FC>'
                     + '<FC>id=PROM_USER_ID   name=PROM_USER_ID   width=100  align=left</FC>'
                     + '<FC>id=PROM_CD        name=PROM_CD        width=100  align=left</FC>'
                     + '<FC>id=CARD_ISSUE_YN  name=CARD_ISSUE_YN  width=100  align=left</FC>'
                     + '<FC>id=SS_NO_EN       name=SS_NO_EN       width=100  align=left</FC>'
                     + '<FC>id=EMAIL1_EN      name=EMAIL1_EN      width=100  align=left</FC>'
                     + '<FC>id=EMAIL2_EN      name=EMAIL2_EN      width=100  align=left</FC>'
                     + '<FC>id=HOME_PH1_EN    name=HOME_PH1_EN    width=100  align=left</FC>'
                     + '<FC>id=HOME_PH2_EN    name=HOME_PH2_EN    width=100  align=left</FC>'
                     + '<FC>id=HOME_PH3_EN    name=HOME_PH3_EN    width=100  align=left</FC>'
                     + '<FC>id=MOBILE_PH1_EN  name=MOBILE_PH1_EN  width=100  align=left</FC>'
                     + '<FC>id=MOBILE_PH2_EN  name=MOBILE_PH2_EN  width=100  align=left</FC>'
                     + '<FC>id=MOBILE_PH3_EN  name=MOBILE_PH3_EN  width=100  align=left</FC>'
                     + '<FC>id=PASSWORD_EN    name=PASSWORD_EN    width=100  align=left</FC>'
                     + '<FC>id=HCLS_ZIP_CD1   name=HCLS_ZIP_CD1   width=100  align=left</FC>'
                     + '<FC>id=HCLS_ZIP_CD2   name=HCLS_ZIP_CD2   width=100  align=left</FC>'
                     + '<FC>id=HCLS_ADDR1     name=HCLS_ADDR1     width=100  align=left</FC>'
                     + '<FC>id=HCLS_ADDR2     name=HCLS_ADDR2     width=100  align=left</FC>'
                     + '<FC>id=HOME_CLS_YN    name=HOME_CLS_YN    width=100  align=left</FC>'
                     + '<FC>id=HNEW_ZIP_CD1   name=HNEW_ZIP_CD1   width=100  align=left</FC>'
                     + '<FC>id=HNEW_ZIP_CD2   name=HNEW_ZIP_CD2   width=100  align=left</FC>'
                     + '<FC>id=HNEW_ADDR1     name=HNEW_ADDR1     width=100  align=left</FC>'
                     + '<FC>id=HNEW_ADDR2     name=HNEW_ADDR2     width=100  align=left</FC>'
                     + '<FC>id=HOME_NEW_YN    name=HOME_NEW_YN    width=100  align=left</FC>'
                     + '<FC>id=CARD_NO_EN     name=CARD_NO_EN     width=100  align=left</FC>'
                     + '<FC>id=CARD_NO        name=CARD_NO        width=100  align=left</FC>'
                     + '<FC>id=CUST_ID        name=CUST_ID        width=100  align=left</FC>'
                     + '<FC>id=SIDO           name=SIDO           width=100  align=left</FC>'
                     + '<FC>id=SIGUN          name=SIGUN          width=100  align=left</FC>'
                     + '<FC>id=GU             name=GU             width=100  align=left</FC>'
                     + '<FC>id=YDONG          name=YDONG          width=100  align=left</FC>'
                     + '<FC>id=DONGRI         name=DONGRI         width=100  align=left</FC>'
                     + '<FC>id=BUNJI_FLAG     name=BUNJI_FLAG     width=100  align=left</FC>'
                     + '<FC>id=BUNJI          name=BUNJI          width=100  align=left</FC>'
                     + '<FC>id=GAJI_BUNJI     name=GAJI_BUNJI     width=100  align=left</FC>'
                     + '<FC>id=BUILD_NAME     name=BUILD_NAME     width=100  align=left</FC>'
                     + '<FC>id=FLOOR          name=FLOOR          width=100  align=left</FC>'
                     + '<FC>id=BUILD_DONG     name=BUILD_DONG     width=100  align=left</FC>'
                     + '<FC>id=BUILD_HO       name=BUILD_HO       width=100  align=left</FC>'
                     + '<FC>id=MAIL_SEND_YN   name=MAIL_SEND_YN   width=100  align=left</FC>'
                     + '<FC>id=HHOLD_ID       name=HHOLD_ID       width=100  align=left</FC>'
                     + '<FC>id=TEMP_FLAG      name=TEMP_FLAG      width=100  align=left show=false</FC>';

    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
}
/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_SEQ_NO_S.Text).length = 0){
    	showMessage(EXCLAMATION, OK, "USER-1003",  "SEQ_NO");
    	EM_SEQ_NO_S.Focus();
        return;
    }
    if (trim(EM_SEQ_NO_E.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "SEQ_NO");
        EM_SEQ_NO_E.Focus();
        return;
    }
    showMaster();
 }
 
/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 저장
 * return값 : void
 */
 function btn_Save(){
	
    for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
        DS_IO_MASTER.UserStatus(i) = 1;
    }
    
    var parameters  = "&strSeqNoS="   + encodeURIComponent(strSeqNoS)
                    + "&strSeqNoE="   + encodeURIComponent(strSeqNoE);
    strAutoSrch = "Y";
    TR_SAVE.Action="/dcs/dctm191.dm?goTo=saveData"+parameters;  
    TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
	searchSetWait("B");
	TR_SAVE.Post();  
	//showDetail();
 }
 
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 일단위 포인트 현황 조회 
 * return값 : void
 */
function showMaster(){
	
	strSeqNoS   = EM_SEQ_NO_S.Text;
	strSeqNoE   = EM_SEQ_NO_E.Text;
	var parameters  = "&strSeqNoS="   + encodeURIComponent(strSeqNoS)
                    + "&strSeqNoE="   + encodeURIComponent(strSeqNoE);
    var goTo        = "searchMaster";    
    var action      = "O";     
    TR_MAIN.Action  ="/dcs/dctm191.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 일단위 포인트 현황 조회 
 * return값 : void
 */
function showMaster2(){
    
    strSeqNoS   = EM_SEQ_NO_S.Text;
    strSeqNoE   = EM_SEQ_NO_E.Text;
    var parameters  = "&strSeqNoS="   + encodeURIComponent(strSeqNoS)
                    + "&strSeqNoE="   + encodeURIComponent(strSeqNoE);
    var goTo        = "searchMaster";    
    var action      = "O";     
    TR_MAIN.Action  ="/dcs/dctm191.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    if(strAutoSrch == "Y" && DS_IO_MASTER.CountRow > 0){
        btn_Save();
    }else{ 
        showDetail();
        searchDoneWait();
    }
}
/**
 * showDetail()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-25
 * 개       요     : 저장 후 조회 
 * return값 : void
 */
function showDetail(){
	
	var strSeqNoS   = EM_SEQ_NO_S.Text;
	var strSeqNoE   = EM_SEQ_NO_E.Text;
	 
	var parameters  = "&strSeqNoS="   + encodeURIComponent(strSeqNoS)
	                + "&strSeqNoE="   + encodeURIComponent(strSeqNoE);
    var goTo        = "searchDetail";    
    var action      = "O";     
    TR_DETAIL.Action  ="/dcs/dctm191.dm?goTo="+goTo+parameters;   
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
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
<script language=JavaScript for=TR_SAVE event=onSuccess>
    searchDoneWait();
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
       //showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
        strSeqNoS = parseInt(strSeqNoS) + 100;
        strSeqNoE = parseInt(strSeqNoE) + 100;
        EM_SEQ_NO_S.Text = strSeqNoS;
        EM_SEQ_NO_E.Text = strSeqNoE;
        showMaster2();
    }
</script>

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    searchDoneWait();
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    searchDoneWait();
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
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
<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="80" class="point">SEQ_NO</th>
						<td><comment id="_NSID_"> <object id=EM_SEQ_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1 align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script> ~ <comment id="_NSID_">
						<object id=EM_SEQ_NO_E classid=<%=Util.CLSID_EMEDIT%>
							width="80" tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GR_MASTER width="100%" height=250
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_MASTER">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GR_DETAIL width="100%" height=237
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_DETAIL">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
