<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 재청구진행현황
 * 작  성  일  : 2010.05.30
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9440.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.30 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    // Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_CHRG_DT_S,     "YYYYMMDD",    PK);
    initEmEdit(EM_CHRG_DT_E,     "TODAY",       PK);
    initEmEdit(EM_APPR_NO,       "0000000000",  NORMAL);           

    initComboStyle(LC_JBRCH_ID_S, DS_O_JBRCH_ID,    "CODE^0^120, NAME^0^180",  1, NORMAL);
    initComboStyle(LC_STR_CD,     DS_COND_STR_CD,   "CODE^0^30,  NAME^0^80",   1, PK);
    initComboStyle(LC_BCOMP_CD,   DS_COND_BCOMP_CD, "CODE^0^30,  NAME^0^80",   1, NORMAL);

    getStore("DS_COND_STR_CD", "Y", "", "N");
    getBcompCode("DS_COND_BCOMP_CD", "", "", "Y");

    //초기값설정
    setComboData(LC_STR_CD,  DS_COND_STR_CD.NameValue(0, "CODE"));
    setComboData(LC_BCOMP_CD,  "%");
    
    EM_CHRG_DT_S.Text = addDate("D", "-1", EM_CHRG_DT_E.Text);
    
    showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}         name="NO"           width=30   align=center</FC>'
				    	+ '<FC>id=RECV_DT          name="청구일자"      width=70   align=center mask="XX/XX/XX"</FC>'
				    	+ '<FC>id=BCOMP_NM         name="매입사"        width=90   align=left</FC>'
				    	+ '<FC>id=JBRCH_ID         name="가맹점번호"    width=80   align=center</FC>'
				    	+ '<FC>id=APPR_NO          name="승인번호"      width=80   align=center</FC>'
				    	+ '<FC>id=CARD_NO          name="카드번호"      width=140  align=center mask="XXXX-XXXX-XXXX-XXXX"</FC>'
				    	+ '<FC>id=PAY_DT           name="반송일자"      width=80   align=center mask="XXXX/XX/XX"</FC>'
				    	+ '<FC>id=VRTN_NM          name="반송사유"      width=160  align=left</FC>'
				    	+ '<FC>id=CHRG_DT          name="재청구일자"    width=80   align=center  mask="XXXX/XX/XX"</FC>'
				    	+ '<FC>id=IN_DT            name="입금예정일"    width=80   align=center  mask="XXXX/XX/XX"</FC>'
				    	+ '<FC>id=STATUS           name="회신상태"      width=80   align=center </FC>'
				    	+ '<FC>id=RTN_DT           name="회신일자"      width=80   align=center  mask={IF(RTN_DT="대기중","","XXXX/XX/XX")}</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
     (4) 엑셀       - btn_Excel()
 *************************************************************************/
 /**
  * btn_Search()
  * 작 성 자     : 김영진
  * 작 성 일     : 2010-05-30
  * 개       요     : 조회시 호출
  * return값 : void
  */
 function btn_Search() {
	  
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점코드");
	    LC_STR_CD.Focus();
	    return false;
	}
    if(trim(EM_CHRG_DT_S.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","재청구시작일");
        EM_CHRG_DT_S.Focus();
        return;
    }
    if(trim(EM_CHRG_DT_E.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","재청구종료일");
        EM_CHRG_DT_E.Focus();
        return;
    }
    if(EM_CHRG_DT_S.Text > EM_CHRG_DT_E.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_CHRG_DT_S.Focus();
        return;
    }
     //조회
     showMaster();
 }

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 :2010-05-30
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "재청구진행현황";
    openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
    GR_MASTER.Focus();
}

 /*************************************************************************
  * 3. 함수
  *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-30
 * 개       요     : 재청구현황조회 
 * return값 : void
 */
function showMaster(){    

    var strStrCd     = LC_STR_CD.BindColVal;
    var strChrgDtS   = EM_CHRG_DT_S.Text; 
    var strChrgDtE   = EM_CHRG_DT_E.Text;  
    var strJbrchId   = LC_JBRCH_ID_S.BindColVal;  
    var strApprNo    = EM_APPR_NO.Text;    
    var strBcompCd   = LC_BCOMP_CD.BindColVal;
    
    strExlParam = "점코드="       + strStrCd   + " : " + LC_STR_CD.Text
                + " -재청구일자=" + strChrgDtS + "~" 　　+ strChrgDtE
                + " -매입사="     + strBcompCd + " : " + LC_BCOMP_CD.Text
                + " -가맹점번호=" + strJbrchId
                + "-승인번호="    + strApprNo;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strChrgDtS=" + encodeURIComponent(strChrgDtS)
                    + "&strChrgDtE=" + encodeURIComponent(strChrgDtE)
                    + "&strJbrchId=" + encodeURIComponent(strJbrchId)
                    + "&strApprNo="  + encodeURIComponent(strApprNo)
                    + "&strBcompCd=" + encodeURIComponent(strBcompCd);
    
    TR_MAIN.Action  ="/dps/psal944.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	LC_STR_CD.Focus();
    }
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
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
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD event=OnSelChange()>
    DS_O_JBRCH_ID.ClearData();
    if(this.BindColVal != "%"){
        LC_JBRCH_ID_S.Enable = true;
        getJbrchCode("DS_O_JBRCH_ID", this.BindColVal, "N");
    }else{
        LC_JBRCH_ID_S.Enable = false;
    }
</script>
 
 <!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_CHRG_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_CHRG_DT_S)){
    	EM_CHRG_DT_S.Text = addDate("D", "-1", EM_CHRG_DT_E.Text);
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_CHRG_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_CHRG_DT_E)){
        initEmEdit(EM_CHRG_DT_E, "today",       PK); 
    }
</script>  
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_COND_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_JBRCH_ID classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
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
<!--* E. 본문시작                                                                                                                                                              *-->
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
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점코드</th>
						<td width="160"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">재청구일자</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_CHRG_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_CHRG_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_CHRG_DT_E
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_CHRG_DT_E)" /></td>
					</tr>
					<tr>
						<th width="80">매입사</th>
						<td><comment id="_NSID_"> <object id=LC_BCOMP_CD
							classid=<%=Util.CLSID_LUXECOMBO%> width=145 align="absmiddle"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">가맹점번호</th>
						<td width="205"><comment id="_NSID_"> <object
							id=LC_JBRCH_ID_S classid=<%=Util.CLSID_LUXECOMBO%> width=194
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">승인번호</th>
						<td><comment id="_NSID_"> <object id=EM_APPR_NO
							classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle"
							tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=479 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
</div>
<body>
</html>

