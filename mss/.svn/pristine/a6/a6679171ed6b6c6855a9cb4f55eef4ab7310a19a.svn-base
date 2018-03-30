<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 판매/회수 > 상품권 재사용일자내역 조회
 * 작 성 일 : 2011.08.05
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : mgif3130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 재사용일자내역 조회을 조회 한다.
 * 이    력 : 2011.08.05 (김유완) 신규개발
 *         
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 //디테일 두번 조회 막기 위해
 var old_Row = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.08.05
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MG_GIFTREUSE_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MG_GIFTREUSE_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_S_REQ_YMD_FROM,       "SYYYYMMDD",        PK);        //재사용일자 from
    initEmEdit(EM_S_REQ_YMD_TO,         "TODAY",            PK);        //재사용일자 to
    initEmEdit(EM_S_GIFTCARD_NO,        "NUMBER3^18",       NORMAL);    //재사용일자 to
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD,           "CODE^0^30,NAME^0^80", 1,   PK);        //점
    initComboStyle(LC_GIFT_TYPE_CD,DS_O_GIFTTPM,    "CODE^0^30,NAME^0^80", 1,   NORMAL);    //상품권종류
    initComboStyle(LC_GIFT_AMT_TYPE,DS_O_GIFTAMT,   "REAL_CODE^0^40,NAME^0^80", 1,NORMAL);  //금종조회
    getStore("DS_O_STR_CD", "Y", "", "N");
    getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
    getGiftCd("getGiftAmt", "DS_O_GIFTAMT"); //금종조회()
    getGiftCd("getGiftAmt", "DS_G_GIFTAMT"); //금종조회(그리드사용:필터미사용)
    LC_GIFT_TYPE_CD.AddData("%^전체");
    LC_GIFT_AMT_TYPE.AddData("%^전체");
    
    LC_STR_CD.index = 0;
    LC_STR_CD.Focus();
    LC_GIFT_TYPE_CD.index = 0;
    LC_GIFT_AMT_TYPE.index = 0;
}

function gridCreate(){
    // 메인그리드
    var hdrProperies = ''
        + '<FC>ID={CURROW}          NAME="NO"' 
        + '                                             WIDTH=35       ALIGN=CENTER </FC>'
        + '<FC>ID=DRAWL_STR         NAME="점"'         
        + '                                             WIDTH=135      ALIGN=LEFT   EDITSTYLE=LOOKUP DATA="DS_O_STR_CD:CODE:NAME"</FC>'
        + '<FC>ID=REG_DT            NAME="일자"'         
        + '                                             WIDTH=135      ALIGN=CENTER SUMTEXT="합계"    MASK="XXXX/XX/XX"</FC>'
        + '<FC>ID=GIFT_TYPE_NAME    NAME="상품권종류"'         
        + '                                             WIDTH=155      ALIGN=LEFT</FC>'
        + '<FC>ID=GIFT_AMT_NM       NAME="금종"'           
        + '                                             WIDTH=120      ALIGN=LEFT</FC>'
        + '<FC>ID=GIFT_QTY          NAME="수량"'           
        + '                                             WIDTH=100      ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
        + '<FC>ID=GIFT_AMT          NAME="금액"'           
        + '                                             WIDTH=100      ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
        ;
        initGridStyle(GD_MASTER, "common", hdrProperies, false);
        GD_MASTER.ViewSummary = "1";
        
    // 상세그리드
    var hdrProperiesD = ''
        + '<FC>ID={CURROW}          NAME="NO"' 
        + '                                             WIDTH=35       ALIGN=CENTER</FC>'
        + '<FC>ID=DRAWL_STR         NAME="점"'         
        + '                                             WIDTH=135      ALIGN=LEFT   EDITSTYLE=LOOKUP DATA="DS_O_STR_CD:CODE:NAME"</FC>'
        + '<FC>ID=REG_DT            NAME="일자"'         
        + '                                             WIDTH=135      ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
        + '<FC>ID=GIFT_TYPE_NAME    NAME="상품권종류"'         
        + '                                             WIDTH=155      ALIGN=LEFT</FC>'
        + '<FC>ID=GIFT_AMT_NM       NAME="금종"'           
        + '                                             WIDTH=120      ALIGN=LEFT</FC>'
        + '<FC>ID=GIFTCARD_NO       NAME="상품권번호"'           
        + '                                             WIDTH=200      ALIGN=CENTER</FC>'
        ;
        initGridStyle(GD_DETAIL, "common", hdrProperiesD, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.08.05
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_STR_CD.BindColVal.length == 0){ 
		showMessage(INFORMATION, OK, "USER-1001", "점");
		LC_STR_CD.focus();
		return;
	}
	    
	if (EM_S_REQ_YMD_FROM.Text == "") {
        showMessage(INFORMATION, OK, "USER-1000", "조회기간(시작~종료)을 입력하세요");
        EM_S_REQ_YMD_FROM.focus();
        return;
	}
	
	if (EM_S_REQ_YMD_TO.Text == "") {
        showMessage(INFORMATION, OK, "USER-1000", "조회기간(시작~종료)을 입력하세요");
        EM_S_REQ_YMD_TO.focus();
        return;
	}
	
	// 조회조건 셋팅
	var strStrCd       = LC_STR_CD.BindColVal;         //점코드
	var strReqYmdFrom  = EM_S_REQ_YMD_FROM.Text;       //재사용일자 FROM
	var strReqYmdTo    = EM_S_REQ_YMD_TO.Text;         //재사용일자 TO
	var strGiftCd      = EM_S_GIFTCARD_NO.Text;        //상품권코드
	var strGiftType    = LC_GIFT_TYPE_CD.BindColVal;   //상품권종류
	var strGiftAmt     = LC_GIFT_AMT_TYPE.BindColVal;  //금종
	
	if(strReqYmdFrom > strReqYmdTo) {
	    showMessage(INFORMATION, OK, "USER-1015");
	    EM_S_REQ_YMD_FROM.Focus();
	    return;
	}
	
	//데이타 셋 클리어
	DS_O_MASTER.ClearData();
	DS_O_DETAIL.ClearData();
	
	var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
	               + "&strReqYmdFrom="+ encodeURIComponent(strReqYmdFrom)
	               + "&strReqYmdTo =" + encodeURIComponent(strReqYmdTo)
	               + "&strGiftCd   =" + encodeURIComponent(strGiftCd)
	               + "&strGiftType =" + encodeURIComponent(strGiftType)
	               + "&strGiftAmt  =" + encodeURIComponent(strGiftAmt);
	//마스터
	TR_MAIN.Action="/mss/mgif313.mg?goTo=getMaster"+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
	TR_MAIN.Post();
	
	//디테일
	TR_DETAIL.Action="/mss/mgif313.mg?goTo=getDetail"+parameters;  
	TR_DETAIL.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)";
	TR_DETAIL.Post();
	
	// 조회결과 Return
	setPorcCount("SELECT", GD_MASTER);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getGiftCd()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.05
 * 개    요 : 상품권종류/금종 가져오기
 * return값 : void
 */
function getGiftCd(strTarget, strDateSet){
    var strParam = strTarget+"&strGiftType=01"; //자사상품권
    //상품권관리 > 상품권 판매/회수> 가맹점 제휴상품권 회수관리의 함수를 이용
    TR_DETAIL.Action="/mss/mgif312.mg?goTo="+strParam;  
    TR_DETAIL.KeyValue="SERVLET(O:DS_O_CODE="+ strDateSet +")";
    TR_DETAIL.Post();
    
    eval(strDateSet).AddRow();
    if (strTarget == "getGiftTpm") {
        eval(strDateSet).NameValue(eval(strDateSet).RowPosition, "CODE") = "%";
    } else {
        eval(strDateSet).NameValue(eval(strDateSet).RowPosition, "REAL_CODE") = "%";
    }
    eval(strDateSet).NameValue(eval(strDateSet).RowPosition, "NAME") = "전체";
    eval(strDateSet).SortExpr="+CODE";
    eval(strDateSet).Sort();
}

-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
old_Row = row;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=LC_GIFT_TYPE_CD event=OnSelChange()>
DS_O_GIFTAMT.Filter();     // 금종필터
LC_GIFT_AMT_TYPE.index = 0;
</script>

<script language=JavaScript for=DS_O_GIFTAMT event=OnFilter(row)>
// 금종필터
    if (LC_GIFT_TYPE_CD.BindColVal == "%") {
    	return true;
    } else {
        if (LC_GIFT_TYPE_CD.BindColVal == DS_O_GIFTAMT.NameValue(row,"GIFT_TYPE_CD")) {
            return true;
        } else { 
        	if (DS_O_GIFTAMT.NameValue(row,"REAL_CODE") == "%") {
        	    return true;
        	} else {
	            return false;
        	}
        }
    }
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTTPM"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTAMT"      classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_G_GIFTAMT"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="POINT">점</th>
						<td width="110"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=109
							align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script></td>
						<th width="80" class="POINT">기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_REQ_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70"
							onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_REQ_YMD_FROM)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_REQ_YMD_TO
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width="70"
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_REQ_YMD_TO)"
							align="absmiddle" /></td>
                        <th width="80" class="POINT">상품권번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_GIFTCARD_NO classid=<%=Util.CLSID_EMEDIT%> width="130" align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>상품권종류</th>
						<td><comment id="_NSID_"> <object
							id=LC_GIFT_TYPE_CD classid=<%=Util.CLSID_LUXECOMBO%> width=109
							align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script></td>
						<th>금종</th>
						<td colspan=3><comment id="_NSID_"> <object
							id=LC_GIFT_AMT_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=109
							align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=220 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
					<Param Name="ViewSummary" value="1">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
					width=100% height=243 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_DETAIL">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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

