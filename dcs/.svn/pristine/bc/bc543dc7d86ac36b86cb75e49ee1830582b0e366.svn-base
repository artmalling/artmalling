<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 멤버쉽운영 > 기준정보 > 캠페인회원조회팝업
 * 작  성  일  : 2010.03.18
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dmbo2011.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.03.18 (김영진) 신규작성
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCamId   = dialogArguments[0];
var strCamNm   = dialogArguments[1];

var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-18
 * 개      요  : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	 
	var GET_STR_CD = getGstrCd();
	var sessionStrCd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';
	//Output Data Set Header 초기화
    DS_O_CUSTLIST.setDataHeader('<gauce:dataset name="H_POPCUST"/>');
    
    //그리드 초기화
    gridCreate1();

    //EMedit에 초기화
    initEmEdit(EM_CAM_NM,      "GEN^40", READ);         //캠페인명
    initEmEdit(EM_CUST_NAME_S, "GEN^40", NORMAL);       //회원명
    initComboStyle(LC_STR_CD, DS_O_STR_CD,  "STR_CD^0^30,STR_NM^0^110", 1, PK); 
    
    getStrCd("DS_O_STR_CD", "", "", "Y");
    
    //권한
    if(GET_STR_CD == sessionStrCd){
        LC_STR_CD.Index = 0;
    }else{
        LC_STR_CD.BindColVal = sessionStrCd;
        LC_STR_CD.Enable = false;
    }

    EM_CUST_NAME_S.Focus();
    
    EM_CAM_NM.Text = strCamNm;

    //OPEN시 회원조회
    showMaster();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"            width=30    align=center</FC>'
                     + '<FC>id=CUST_ID       name="회원ID"        width=72    align=center</FC>'
                     + '<FC>id=CUST_NAME     name="회원명"        width=86    align=left</FC>'
                     + '<FC>id=STR_CD        name="점포코드"      width=90    align=center      show=false </FC>'
                     + '<FC>id=STR_NM        name="점포명"        width=85    align=left</FC>'
                     + '<FC>id=BIRTH_DT      name="생년월일"      width=78    align=center      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=MOBILE_PH1    name="휴대폰번호"    width=94    align=center</FC>'
                     + '<FC>id=MOBILE_PH2    name="휴대폰번호"    width=0     align=center</FC>'
                     + '<FC>id=MOBILE_PH3    name="휴대폰번호"    width=0     align=center</FC>'
                     + '<FC>id=PNT_TYPE      name="적립유형"      width=0     align=center      show=false</FC>'
                     + '<FC>id=PNT_NAME      name="적립유형"      width=95    align=left</FC>'
                     + '<FC>id=ADD_PNT       name="추가포인트"    width=76   align=right</FC>'
                     + '<FC>id=ADD_RATE      name="추가적립율"    width=72    align=right</FC>'
                     + '<FC>id=ADD_TIMES     name="추가배수"      width=62    align=right</FC>';

    initGridStyle(GR_CUSTLIST, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-18
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(trim(EM_CUST_NAME_S.text).length < 2){
        showMessage(EXCLAMATION, OK, "USER-1047",  "회원명은 2");
        EM_CUST_NAME_S.Focus();
        return;
    }
    showMaster();
}

/**
 * btn_Excel()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-18
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "캠페인 회원 조회"
        
    GR_CUSTLIST.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    GR_CUSTLIST.GridToExcelExtProp("HideColumn") = "{MOBILE_PH2}"; 
    GR_CUSTLIST.GridToExcelExtProp("HideColumn") = "{MOBILE_PH3}"; 
    openExcel2(GR_CUSTLIST, ExcelTitle, EXCEL_PARAMS, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
* showMaster()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-18
* 개           요 : 
* return값 : void
*/
function showMaster(){
	
    var strCustNm   = EM_CUST_NAME_S.Text;    
    var goTo        = "popCustSearch";    
    var action      = "O";     
    var parameters  = "&strCustNm="  + encodeURIComponent(strCustNm)
                    + "&strCamId="   + encodeURIComponent(strCamId)
                    + "&strStrCd="   + encodeURIComponent(LC_STR_CD.BindColVal);    
    
    EXCEL_PARAMS  = "캠페인명=" + strCamNm;
    EXCEL_PARAMS += "-점포코드="+ LC_STR_CD.BindColVal;
    EXCEL_PARAMS += "-점포명="  + LC_STR_CD.Text;
    EXCEL_PARAMS += "-회원명="  + strCustNm;

    TR_MAIN.Action  ="/dcs/dmbo201.do?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CUSTLIST=DS_O_CUSTLIST)"; //조회는 O
    TR_MAIN.Post();
}

/**
* btn_Close()
* 작 성 자 : 김영진
* 작 성 일 : 2010-03-18
* 개      요  : 닫기
* return값 : void
*/
function btn_Close()
{
    window.close();
}

/**
 * getStrCd()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-17
 * 개      요  : STR_CD LIST 조회
 * return값 :
 */
function getStrCd(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) { 
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1),STR_CD:STRING(50)');

    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    DS_I_COMMON.NameValue(1, "STR_CD")    = strCamId;
        
    TR_MAIN.Action  = "/dcs/dmbo201.do?goTo=getEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
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
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_CUSTLIST event=OnClick(row,colid)>
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
<object id="DS_O_CUSTLIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
							align="absmiddle" class="popR05 PL03" /> 캠페인 회원 조회</td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/search.gif" height="22"
									onClick="btn_Search();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/excel.gif" height="22"
									onClick="btn_Excel()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" height="22"
									onClick="btn_Close();" /></td>
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
								<th width="80" >캠페인명</th>
								<td colspan="3"><comment id="_NSID_"> <object id=EM_CAM_NM
									classid=<%=Util.CLSID_EMEDIT%> width=246 tabindex=1
									align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th width="80" class="point">점포</th>
								<comment id="_NSID_">
								<td width="320"><object id=LC_STR_CD
									classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
									align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
								<th width="80">회원명</th>
								<td><comment id="_NSID_"> <object
									id=EM_CUST_NAME_S classid=<%=Util.CLSID_EMEDIT%> width=130
									tabindex=1 align="absmiddle"
									onkeyup="javascript:checkByteStr(EM_CUST_NAME_S, 40,'','','');"
									onkeyDown="javascript:checkByteStr(EM_CUST_NAME_S, 40,'','','');"
									onkeyPress="javascript:checkByteStr(EM_CUST_NAME_S, 40,'','','');">></object>
								</comment> <script> _ws_(_NSID_);</script>&nbsp;(2자 이상 입력하세요.)</td>
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
							id=GR_CUSTLIST width="100%" height=380
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_CUSTLIST">
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

