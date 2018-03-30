<!-- 
/*******************************************************************************
 * 시스템명 : 매출현황 > 매출실적 > 무인정산자료 비교표
 * 작 성 일 : 2016.10.27
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : psal6110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 무인정산자료 비교표조회 한다.
 * 이    력 :
 *        2016.10.27 (박래형) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%

String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
 
<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var onPopup  = false;
var nTopSize = 100;
var g_strPid           = "<%=pageName%>";                 // PID

// 현재일자
var strToday   = "";
var strYyyyMm  = "";

// 디테일 조회구분
var gAllSearch = true;

// 데이터셋 이벤트 실행여부
var gEvtFlag   = true;   

/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	// 그리드 높이 자동 지정
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-nTopSize) + "px";

    // Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');

    // EMedit에 초기화
    initEmEdit(EM_SALE_DT,     "YYYYMMDD", PK);		// 시작일
    initEmEdit(EM_SALE_END_DT, "YYYYMMDD", PK);		// 종료일
    initEmEdit(EM_POS_NO,      "GEN",      NORMAL);	// POS 번호

    // 콤보 초기화
    initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);		// 점(조회)
    
    // 공통 데이터 가져오기
    getStore("DS_STR_CD", "Y", "", "N");			// 점

    // 콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if(LC_STR_CD.Index < 0) LC_STR_CD.Index = 0; 

    getEtcCode("DS_COMM_CODE", "D", "D132", "Y");		// 무인정산기 정산항목
    
    // 그리드 초기화
    gridCreate();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal611","DS_MASTER" );
    
    // 현재일자 세팅
    strToday    = getTodayDB("DS_TODAY");
    strYyyyMm   = strToday.substring(0, 6);
    EM_SALE_DT.alignment     = 1;
    EM_SALE_DT.Text          = strYyyyMm + "01";
    EM_SALE_END_DT.alignment = 1;
    EM_SALE_END_DT.Text      = strToday;
    
    // 로딩 후 포커스 위치 설정
    LC_STR_CD.Focus();
}

/**
 * gridCreate()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27 
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){

	var hdrProperies = '<FC>id={currow}           name="NO"        width=40      align=center            </FC>'
	                 + '<FC> id=STR_CD            name="점"    	   width=80      align=center   </FC>'
	                 + '<FC> id=SALE_DT           name="매출일자"   width=80      align=center   mask="XXXX/XX/XX" </FC>'                      
	                 + '<FC> id=POS_NO            name="장비번호"   width=80      align=center  </FC>'                
	                 + '<FC> id=POS_NAME          name="장비명"     width=120     align=center   sumtext="합  계" </FC>'
	                 + '<FC> id=BRAND_CD          name="브랜드코드" width=120     align=center   </FC>'
	                 + '<FC> id=BRAND_NAME        name="브랜드명"   width=120     align=left   </FC>'
	                 + '<C> id=TOT_AMT           name="매출금액"   width=80      align=right   sumtext=@sum </C>'
	                 + '<G>						  name="결제수단" '
	                 + '<C> id=CASH_AMT           name="현금"      width=80     align=right   sumtext=@sum </FC>'
	                 + '<C> id=CARD_AMT           name="카드"      width=80     align=right   sumtext=@sum </C>'
	                 + '<C> id=INGIFT_AMT         name="자사"      width=80     align=right   sumtext=@sum </C>'
	                 + '<C> id=OUTGIFT_AMT        name="타사"      width=80     align=right   sumtext=@sum </C>'
	                 + '<C> id=ETC_AMT1           name="외상"      width=80     align=right   sumtext=@sum </C>'
	                 + '<C> id=ETC_AMT2           name="온라인"      width=80     align=right   sumtext=@sum </C>'
	                 + '<C> id=ETC_AMT3           name="기타"      width=80     align=right   sumtext=@sum </C>'
	                 + '<C> id=ARTSKGWN           name="식권"      width=80     align=right   sumtext=@sum </C>'
	                 
	                 + '</G>'
	                 + '<C> id=ORD	    	      name="기타"      width=80     align=right   show = false </C>'
	                 ;

	initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.Editable	  =	false;
    GD_MASTER.ViewSummary =	"1";	//합계 보이기
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	// 값 체크
	if(!fnChkValidation("search")) return;
    
    var strCd           = LC_STR_CD.BindColVal;
    var strSaleDt       = EM_SALE_DT.Text;
    var strSaleEndDt    = EM_SALE_END_DT.Text;
    var strPosNo        = EM_POS_NO.Text;
    
    var goTo         = "searchMaster" ;    
    var action       = "O";  
    var parameters   = "&strStrCd="  + encodeURIComponent(strCd)
				     + "&strSaleDt=" + encodeURIComponent(strSaleDt)
				     + "&strSaleEndDt=" + encodeURIComponent(strSaleEndDt)
				     + "&strPosNo="  + encodeURIComponent(strPosNo)
				     ;
    TR_SEARCH_MASTER.Action   ="/dps/psal611.ps?goTo="+goTo+parameters;  
    TR_SEARCH_MASTER.KeyValue ="SERVLET("+action+":DS_MASTER=DS_MASTER)";
    TR_SEARCH_MASTER.Post();
    
    // 조회 후 결과표시
    setPorcCount("SELECT", GD_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    gAllSearch = false;
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    gAllSearch = false;
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var strTitle = "장비별매출자료";
	
	var strStrCd  = LC_STR_CD.BindColVal;		// 점
	var strSaleDt = EM_SALE_DT.Text;		// 일자
	var strSaleEndDt = EM_SALE_END_DT.Text;		// 일자
	var strPosNo  = EM_POS_NO.Text;		// POS번호
	
	
	
	var parameters = "점 : "             + strStrCd
				   + " ,  조회 기간 : "      + strSaleDt + " ~ " + strSaleEndDt
				  ;
	if (strPosNo.length != 0)
		{
		
			parameters = parameters +  " ,   포스번호 : "  + strPosNo; 	
		
		}
	
	
	GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";		// GridToExcel 사용시 숨길 컬럼지정
	//openExcel2(GD_MASTER, strTitle, parameters, true );
	openExcel5(GD_MASTER, strTitle, parameters, true, "",g_strPid );
}

/**
 * btn_Print()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 
/**
 * fnChkValidation()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 트랜잭션 발생전 값 체크
 * return값 : boolean
 */
function fnChkValidation(strSid){
	
	switch(strSid){

		// 조회
		case "search":    
			if( LC_STR_CD.BindColVal == ""){
		        // (점)은/는 반드시 입력해야 합니다.
		        showMessage(EXCLAMATION, OK, "USER-1002", "점");
		        LC_STR_CD.Focus();
		        return false;
		    }

		    DS_MASTER.ClearData();
		    gAllSearch = true;
		    return true;
			break;
	
		default:
			return false;
			break;
	}
}

</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<!-- 메인 -->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!-- 마스터 조회 -->
<script language=JavaScript for=TR_SEARCH_MASTER event=onSuccess>
    for(i=0;i<TR_SEARCH_MASTER.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SEARCH_MASTER.SrvErrMsg('UserMsg',i));
    }
    gAllSearch = false;
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<!-- 메인 -->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!-- 마스터 조회 -->
<script language=JavaScript for=TR_SEARCH_MASTER event=onFail>
    trFailed(TR_SEARCH_MASTER.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!-- 데이터셋 행 변경시 -->
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>

    if(row > 0){
		// 조회버튼 클릭시 디테일조회 하지않는다.(여러번 조회 되는것 방지)
		if(gAllSearch) return false;
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER  event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>


<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>

	var strStrCd  = DS_MASTER_CROSS.NameValue(DS_MASTER_CROSS.RowPosition, "STR_CD");
	var strStrDt  = EM_SALE_DT.Text;
	var strEndDt  = EM_SALE_END_DT.Text;
	var strPosNo  = DS_MASTER_CROSS.NameValue(DS_MASTER_CROSS.RowPosition, "POS_NO");
	var arrArg    = new Array(strStrCd, strStrDt, strEndDt, strPosNo);
// 	alert("arrArg = " + arrArg);
	return;
	
	var returnVal = window.showModalDialog("/dps/jsp/psal/psal6111.jsp?"
			                              , arrArg
			                              , "dialogWidth:550px;dialogHeight:400px;scroll:no;");
</script>


<!-- 행사장코드(POPUP) -->
<script language=JavaScript for=EM_EVENT_PLACE_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
</script> 

<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT.text = strYyyyMm+"01";
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT.text = strYyyyMm+"01";
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT.text = strYyyyMm+"01";
        return ;
    }
    

</script>

 
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POP"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TODAY"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_COMM_CODE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
	<object id="DS_MASTER_CROSS" classid=<%=Util.CLSID_DATASET%>>
		<param name=DataID         value="DS_MASTER">
		<param name=Logical        value="true">
		<param name=GroupExpr      value="STR_CD:POS_NO:POS_NM:,COMM_NAME,CAL_AMT:NORM_TRAN_AMT:DIFF_AMT">
	</object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!-- 메인 -->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 마스터 조회 -->
<comment id="_NSID_">
<object id="TR_SEARCH_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<!-- 조회조건 영역 시작 -->
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="60" class="point">점</th>
								<td width="140">
									<comment id="_NSID_">
										<object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="60" class="point">기간</th>
								<td width="300">
									<comment id="_NSID_">
										<object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle">
										</object>
									</comment><script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT);" align="absmiddle" />~
									<comment id="_NSID_">
										<object id=EM_SALE_END_DT classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle">
										</object>
									</comment><script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_END_DT);" align="absmiddle" />
								</td>
								<th width="70">POS번호</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle">
										</object>
									</comment><script> _ws_(_NSID_);</script></td>
								</td>
								
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 조회조건 영역 종료 -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!-- 무인정산자료 비교표 시작 -->
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
				<tr>
					<td width="100%" >
						<comment id="_NSID_"><object id=GD_MASTER width="100%" height=600px classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object></comment><script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 무인정산자료 비교표 종료 -->
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>