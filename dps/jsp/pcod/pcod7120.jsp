<!-- 
/*******************************************************************************
 * 시스템명 : 기준정보 > 행사코드 > 행사장 매출조회
 * 작 성 일 : 2016.10.27
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod7120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사장 매출조회 한다.
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
<%String dir = BaseProperty.get("context.common.dir");%>
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
var nTopSize = 330;

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
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-nTopSize) + "px";

    // Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');

    // EMedit에 초기화
    initEmEdit(EM_SALE_DT_S, "YYYYMMDD", PK);   //시작일자
    initEmEdit(EM_SALE_DT_E, "YYYYMMDD", PK);   //종료일자

    //현재년도 셋팅
    EM_SALE_DT_S.text =  strYyyyMm+"01";

    EM_SALE_DT_E.text =  strToday;

    // 콤보 초기화
    initComboStyle(LC_STR_CD,         DS_STR_CD,         "CODE^0^30,NAME^0^140", 1, PK);		// 점(조회)
    initComboStyle(LC_EVENT_PLACE_CD, DS_EVENT_PLACE_CD, "CODE^0^30,NAME^0^140", 1, NORMAL);	// 행사장(조회)
    
    // 공통 데이터 가져오기
    getStore("DS_STR_CD", "Y", "", "N");			// 점

    // 콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if(LC_STR_CD.Index < 0) LC_STR_CD.Index = 0; 
    
    // 행사장 콤보
    getEventPlaceCode("DS_EVENT_PLACE_CD", LC_STR_CD.BindColVal, "Y", "");
    LC_EVENT_PLACE_CD.Index = 0; 
    
    // 그리드 초기화
    gridCreate();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod712","DS_MASTER,DS_DETAIL" );
    
    // 현재일자 세팅
    strToday      = getTodayDB("DS_TODAY");
    strYyyyMm     = strToday.substring(0, 6);
    EM_SALE_DT_S.alignment = 1;
    EM_SALE_DT_E.alignment = 1;
    EM_SALE_DT_S.Text      = strYyyyMm + "01";
    EM_SALE_DT_E.Text      = strToday;
    
    // 테스트
//     EM_SALE_DT_S.Text      = "201607" + "01";
//     EM_SALE_DT_E.Text      = strToday;
    
    RD_GUBUN.CodeValue     = "1";
    
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
	var hdrProperies = "";
	
	// 행사장 마스터 그리드
    hdrProperies = '<FC>id={currow}         width=25    align=center  name="NO"         </FC>'
		         + '<FC>id=STR_CD           width=80    align=left    name="점"         EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME" </FC>'
		         + '<FC>id=EVENT_PLACE_CD   width=80    align=left    name="행사장"     EditStyle=Lookup   Data="DS_EVENT_PLACE_CD:CODE:NAME" </FC>'
		         + '<FC>id=SALE_QTY         width=120   align=right   name="매출수량"   </FC>'
		         + '<FC>id=TOT_SALE_AMT     width=120   align=right   name="총매출"     </FC>'
		         + '<FC>id=REDU_AMT         width=120   align=right   name="할인"       </FC>'
		         + '<FC>id=DC_AMT           width=120   align=right   name="에누리"     </FC>'
		         + '<FC>id=NORM_SALE_AMT    width=120   align=right   name="정상매출"   </FC>'
		         + '<FC>id=NET_SALE_AMT     width=120   align=right   name="순매출"     </FC>'
		         + '<FC>id=SALE_PROF_AMT    width=120   align=right   name="이익액"     </FC>'
		         + '<FC>id=CUST_CNT         width=120   align=right   name="객수"       </FC>'
		         + '<FC>id=CUST_AMT         width=120   align=right   name="객단가"     </FC>'
                 ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

	// 행사장별 POS 그리드
    hdrProperies = '<FC>id={currow}         width=25    align=center  name="NO"         </FC>'
		         + '<FG>name="브랜드"'                                 
		         + '<FC>id=PUMBUN_CD        width=80    align=center  name="코드"       </FC>'
		         + '<FC>id=PUMBUN_NAME      width=130   align=left    name="명"         </FC>'
		         + '</FG>'
		         + '<FC>id=SALE_QTY         width=120   align=right   name="매출수량"   </FC>'
		         + '<FC>id=TOT_SALE_AMT     width=120   align=right   name="총매출"     </FC>'
		         + '<FC>id=REDU_AMT         width=120   align=right   name="할인"       </FC>'
		         + '<FC>id=DC_AMT           width=120   align=right   name="에누리"     </FC>'
		         + '<FC>id=NORM_SALE_AMT    width=120   align=right   name="정상매출"   </FC>'
		         + '<FC>id=NET_SALE_AMT     width=120   align=right   name="순매출"     </FC>'
		         + '<FC>id=SALE_PROF_AMT    width=120   align=right   name="이익액"     </FC>'
		         + '<FC>id=CUST_CNT         width=120   align=right   name="객수"       </FC>'
		         + '<FC>id=CUST_AMT         width=120   align=right   name="객단가"     </FC>'
                 ;
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
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
    var strEventPlaceCd = LC_EVENT_PLACE_CD.BindColVal;
    var strSaleDtS      = EM_SALE_DT_S.Text;
    var strSaleDtE      = EM_SALE_DT_E.Text;
    var strGbn          = RD_GUBUN.CodeValue;
    
    var goTo         = "searchMaster" ;    
    var action       = "O";  
    var parameters   = "&strStrCd="        + encodeURIComponent(strCd)
				     + "&strEventPlaceCd=" + encodeURIComponent(strEventPlaceCd)
				     + "&strSaleDtS="      + encodeURIComponent(strSaleDtS)
				     + "&strSaleDtE="      + encodeURIComponent(strSaleDtE)
				     + "&strGbn="          + encodeURIComponent(strGbn)
				     ;
    TR_SEARCH_MASTER.Action   ="/dps/pcod712.pc?goTo="+goTo+parameters;  
    TR_SEARCH_MASTER.KeyValue ="SERVLET("+action+":DS_MASTER=DS_MASTER)";
    TR_SEARCH_MASTER.Post();
    
    // 조회 후 결과표시
    setPorcCount("SELECT", GD_MASTER);
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
 * searchDetail()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 행사장별 POS, 제외브랜드 조회
 * return값 : void
 */
function searchDetail() {
	var strCd           = DS_MASTER.NameValue(DS_MASTER.Rowposition, "STR_CD");
	var strEventPlaceCd = DS_MASTER.NameValue(DS_MASTER.Rowposition, "EVENT_PLACE_CD");
    var strSaleDtS      = EM_SALE_DT_S.Text;
    var strSaleDtE      = EM_SALE_DT_E.Text;
    var strGbn          = RD_GUBUN.CodeValue;
	
	var goTo         = "searchDetail";    
	var action       = "O";  
	var parameters   = "&strStrCd="        + encodeURIComponent(strCd)
				     + "&strEventPlaceCd=" + encodeURIComponent(strEventPlaceCd)
				     + "&strSaleDtS="      + encodeURIComponent(strSaleDtS)
				     + "&strSaleDtE="      + encodeURIComponent(strSaleDtE)
				     + "&strGbn="          + encodeURIComponent(strGbn)
	                 ;
	
// 	alert("parameters = " + parameters);
	TR_SEARCH_DETAIL.Action   ="/dps/pcod712.pc?goTo="+goTo+parameters;  
	TR_SEARCH_DETAIL.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)";
	TR_SEARCH_DETAIL.Post();
}
 
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

			DS_DETAIL.ClearData();
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

    // 행사장별 POS, 제외브랜드 조회
    searchDetail();
    gAllSearch = false;
</script>

<!-- 디테일 조회 -->
<script language=JavaScript for=TR_SEARCH_DETAIL event=onSuccess>
    for(i=0;i<TR_SEARCH_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SEARCH_DETAIL.SrvErrMsg('UserMsg',i));
    }
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

<!-- 디테일 조회 -->
<script language=JavaScript for=TR_SEARCH_DETAIL event=onFail>
    trFailed(TR_SEARCH_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!-- 데이터셋 행 변경시 -->
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>

    if(row > 0){
		// 조회버튼 클릭시 디테일조회 하지않는다.(여러번 조회 되는것 방지)
		if(gAllSearch) return false;
		
		// 행사장별 POS, 제외브랜드 조회
		searchDetail();
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER  event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 행사장코드(POPUP) -->
<script language=JavaScript for=EM_EVENT_PLACE_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
</script> 

<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT_S.text = strYyyyMm+"01";
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT_S.text = strYyyyMm+"01";
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT_S.text = strYyyyMm+"01";
        return ;
    }
    

</script>

<!-- 매출종료일 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","종료일자"); 
        EM_SALE_DT_E.text = strToday;
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","종료일자","8");
        EM_SALE_DT_E.text = strToday;
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","종료일자");
        EM_SALE_DT_E.text = strToday;
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
<comment id="_NSID_"><object id="DS_DETAIL"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_PLACE_CD" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POP"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TODAY"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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

<!-- 디테일 조회 -->
<comment id="_NSID_">
<object id="TR_SEARCH_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
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
								<th width="60" class="point">행사장코드</th>
								<td width="150">
									<comment id="_NSID_">
										<object id=LC_EVENT_PLACE_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="60" class="point">매출기간</th>
								<td width="210">
									<comment id="_NSID_">
										<object id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle">
										</object>
									</comment><script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT_S);" align="absmiddle" />
									~
									<comment id="_NSID_">
										<object id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle">
										</object>
									</comment> <script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT_E);" align="absmiddle" />
								</td>
								<th width="60" class="point">원단위구분</th>
								<td style="border-right:0px">
									<comment id="_NSID_"> 
										<object id="RD_GUBUN" classid="<%=Util.CLSID_RADIO%>" width=90 height=18 align="absmiddle">
											<param name="Cols"   value="2">
											<param name="Format" value="1^원,1000^천원">
										</object> 
									</comment><script>_ws_(_NSID_);</script>    
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
	
	<!-- 행사장 그리드 시작 -->
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
				<tr>
					<td width="100%" >
						<comment id="_NSID_"><object id=GD_MASTER width="100%" height=200px classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object></comment><script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 행사장 그리드 종료 -->
	
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td class="PT03 PB03" width=100%>
					<!-- 행사장별 POS 시작-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
							<tr>
								<td>
									<comment id="_NSID_">
										<object id=GD_DETAIL width="100%" height=360 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_DETAIL">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
					<!-- 행사장별 POS 종료-->
					</td>
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