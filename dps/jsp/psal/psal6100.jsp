<!-- 
/*******************************************************************************
 * 시스템명 : 매출현황 > 매출실적 > 무인정산자료 비교표
 * 작 성 일 : 2016.10.27
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : psal6100.jsp
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
var tfAmtShow = "true";


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
    DS_MASTER_CROSS.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');

    // EMedit에 초기화
    initEmEdit(EM_SALE_DT,     "YYYYMMDD", PK);		// 시작일
    initEmEdit(EM_SALE_END_DT, "YYYYMMDD", PK);		// 종료일
    initEmEdit(EM_PROC_DT, "YYYYMMDD", NORMAL);		// 처리일
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
    registerUsingDataset("psal610","DS_MASTER_CROSS" );
    
    // 현재일자 세팅
    strToday    = getTodayDB("DS_TODAY");
    strYyyyMm   = strToday.substring(0, 6);
    EM_SALE_DT.alignment     = 1;
    EM_SALE_DT.Text          = strYyyyMm + "01";
    EM_SALE_END_DT.alignment = 1;
    EM_SALE_END_DT.Text      = strToday;
    EM_PROC_DT.alignment = 1;
    EM_PROC_DT.Text      = strToday;
    RD_GUBUN.CodeValue = "2";
    GD_MASTER.ColumnProp("SALE_DT", "Show") = "false";
    
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
	                 + '<FC> id=STR_CD            name="점"        width=80      align=left   show=false </FC>'
	                 + '<FC> id=SALE_DT           name="매출일자"  width=80      align=left    mask="XXXX/XX/XX" </FC>'                      
	                 + '<FC> id=POS_NO            name="POS번호"   width=80      align=center show=true  </FC>'                
	                 + '<FC> id=POS_NM            name="POS명"     width=120     align=left   show=true  sumtext="합  계" </FC>'
	                 + '<R>'
	                 + '   <G> name=$xkeyname_$$'
	                 + '       <C>ID=CAL_AMT_$$        name="정산기"    width=100  align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true" sumtext=@sum show="'+tfAmtShow+'"</C>'
	                 + '       <C>ID=NORM_TRAN_AMT_$$  name="시스템"    width=100  align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true" sumtext=@sum show="'+tfAmtShow+'"</C>'
// 	                 + '       <C>ID=DIFF_AMT_$$       name="차이"      width=100  align=right </C>'
	                 + '       <C>ID=DIFF_AMT_$$       name="차이"      width=100  align=right gte_columntype="number:0:true" gte_Summarytype="number:0:true" sumtext=@sum TextColor={if(DIFF_AMT_$$=0,"","red")} </C>'
	                 + '   </G>'
	                 + '</R>'
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
    var strRdGubun		= RD_GUBUN.CodeValue;
    var strChkGrp		= "";
    
    if(document.getElementById("pos_grping").checked)
    	strChkGrp = "1";
    else
    	strChkGrp = "0";
    var goTo         = "searchMaster" ;    
    var action       = "O";  
    var parameters   = "&strStrCd="  	+ encodeURIComponent(strCd)
				     + "&strSaleDt=" 	+ encodeURIComponent(strSaleDt)
				     + "&strSaleEndDt=" + encodeURIComponent(strSaleEndDt)
				     + "&strPosNo="  	+ encodeURIComponent(strPosNo)
				     + "&strRdGubun="  	+ encodeURIComponent(strRdGubun)
				     + "&strChkGrp="  	+ encodeURIComponent(strChkGrp)
				     ;
    TR_SEARCH_MASTER.Action   ="/dps/psal610.ps?goTo="+goTo+parameters;  
    TR_SEARCH_MASTER.KeyValue ="SERVLET("+action+":DS_MASTER=DS_MASTER)";
    TR_SEARCH_MASTER.Post();
    
    // 조회 후 결과표시
    setPorcCount("SELECT", GD_MASTER);
    
    if (strRdGubun==1) 
    	GD_MASTER.ColumnProp("SALE_DT", "Show") = "true";
    else
    	GD_MASTER.ColumnProp("SALE_DT", "Show") = "false";
    	
    
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

	var strTitle = "무인정산비교표";
	
	var strStrCd  = LC_STR_CD.BindColVal;		// 점
	var strSaleDt = EM_SALE_DT.BindColVal;		// 일자
	var strSaleEndDt = EM_SALE_END_DT.BindColVal;		// 일자
	var strPosNo  = EM_POS_NO.BindColVal;		// POS번호
	
	var parameters = "점 : "             + strStrCd
				   + " ,   일자 : "      + strSaleDt + " ~ " + strSaleEndDt
				   + " ,   포스번호 : "  + strSaleDt
				;      
	
	GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";		// GridToExcel 사용시 숨길 컬럼지정
	//openExcel2(GD_MASTER, strTitle, parameters, true );
	openExcel5(GD_MASTER, strTitle, parameters, true , "",g_strPid );
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

function fnChkProcess(strCd, strDate) {
	
	//alert(strDate+"!!!");
	var goTo       = "chkProcess" ;    
	var parameters =  "&strStrCd="		+encodeURIComponent(strCd)
					+ "&strDate="		+encodeURIComponent(strDate)
					;
	var action 	   = "O";
	TR_MAIN.Action  = "/dps/psal610.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_I_CONDITION=DS_I_CONDITION)"; //조회는 O
    TR_MAIN.Post();
    
    var rt_result  = DS_I_CONDITION.NameValue(1, "CNT");
    var rt_process = "";
    var strGb	   = "CAL";
    
    //alert(rt_result);
    //return;
    
    if (rt_result == 0) {
    	
    	showMessage(INFORMATION, OK, "USER-1000", "이관할 자료가 존재하지 않습니다.");
    	return;
    	
    }
    else if(rt_result == 2) {
    	
    	if (showMessage(QUESTION, YESNO, "USER-1000" , "이미 이관된 자료 입니다. 다시 처리하시겠습니까?") == 1)
    	{
    		rt_process = fnRunProcess(strCd, strDate, strGb);
    		return;
			
    	}
    }
    else {
    	if (showMessage(QUESTION, YESNO, "USER-1000",  "'"+strDate+"' 이관 처리를 진행 하시겠습니까?") == 1)
		{
			rt_process = fnRunProcess(strCd, strDate, strGb);
    		return;
		
		}
    }
    
}

function fnRunProcess(strCd, strDate, strGb) {

	//alert(strCd + " " + strDate + " " + strGb);
	searchSetWait("B"); // 프로그래스바
	var goTo       = "runProcess" ;    
	var parameters =  "&strStrCd="		+encodeURIComponent(strCd)
					+ "&strDate="		+encodeURIComponent(strDate)
					+ "&strGb="			+encodeURIComponent(strGb)
					;
	var action 	   = "O";
	TR_SAVE.Action  = "/dps/psal610.ps?goTo="+goTo+parameters;  
	TR_SAVE.KeyValue= "SERVLET("+action+":DS_I_CONDITION=DS_I_CONDITION)"; //조회는 O
    TR_SAVE.Post();
}


function amtSumm(tfTemp) {
	
	
	tfAmtShow  = !tfTemp;
	gridCreate();
	//GD_MASTER.ColumnProp("CAL_AMT_$$", "Show") = "false";
	//GD_MASTER.ColumnProp("NORM_TRAN_AMT_$$", "Show") = "false";
	
}

function chkGrpingTf(tf) {
	if (DS_MASTER_CROSS.CountRow>0) {
		var strMsg = showMessage(QUESTION , YESNO, "USER-1000","조회된 내역이 초기화 됩니다. 진행하시겠습니까?")
		if (strMsg!=1){
			document.getElementById("pos_grping").checked = !tf;
			return;
		}
	}
	DS_MASTER_CROSS.ClearData();
	DS_MASTER.ClearData();
}

function searchOGift(r,c) {
	/*	
		TOOLTIP 내용 :
			
		장비번호_장비명
		조회날짜(기간)
		타사상품권 내역
	*/
	var strRtnVal		= DS_MASTER_CROSS.NameValue(r,"POS_NO") + "_" + DS_MASTER_CROSS.NameValue(r,"POS_NM") + "\n";
	
	var strStrCd 		= DS_MASTER_CROSS.NameValue(r,"STR_CD");		//점코드
	var strSaleDt 		= DS_MASTER_CROSS.NameValue(r,"SALE_DT");		//매출일자 (from)
	var strSaleEndDt	= DS_MASTER_CROSS.NameValue(r,"SALE_TO");		//매출일자 (to)
	var strPosNo		= DS_MASTER_CROSS.NameValue(r,"POS_NO");		//장비번호
	//alert(DS_MASTER_CROSS);
	// 조회 구분
	if (RD_GUBUN.CodeValue == "1")	{
		var strRdGubun =  "DAY";	// 일자별
		strRtnVal = strRtnVal + DS_MASTER_CROSS.NameValue(r,"SALE_DT") + "\n";
	} else {
		var strRdGubun =  "";	// 기간합
		strRtnVal = strRtnVal + DS_MASTER_CROSS.NameValue(r,"SALE_DT") + " ~ " + DS_MASTER_CROSS.NameValue(r,"SALE_TO") +  "\n";
	}
	
	// 그룹화 유무
	if (document.getElementById("pos_grping").checked) {
		var strChkGrp = "GRP";	// 그룹화
	} else {
		var strChkGrp = "";		// 장비별
	}
		
	// 정산기or시스템 
	if ( c == 13 ) {
		var strSys	= "SYS";
		strRtnVal = "[시스템]" + "\n" + strRtnVal; 
	} else {
		var strSys	= "";
		strRtnVal = "[정산기]" + "\n" + strRtnVal;
	}
		
	var goTo         = "searchOGift" ;    
	var action       = "O";  
	var parameters   = "&strStrCd="  	+ encodeURIComponent(strStrCd)
				     + "&strSaleDt=" 	+ encodeURIComponent(strSaleDt)
				     + "&strSaleEndDt=" + encodeURIComponent(strSaleEndDt)
				     + "&strPosNo="  	+ encodeURIComponent(strPosNo)
				     + "&strRdGubun="  	+ encodeURIComponent(strRdGubun)
				     + "&strChkGrp="  	+ encodeURIComponent(strChkGrp)
				     + "&strSys="  		+ encodeURIComponent(strSys)
				     ;
	TR_SEARCH_MASTER.Action   ="/dps/psal610.ps?goTo="+goTo+parameters;  
	TR_SEARCH_MASTER.KeyValue ="SERVLET("+action+":DS_TEMP=DS_TEMP)";
	TR_SEARCH_MASTER.Post();
	
	if (DS_TEMP.CountRow > 0 ) {
		for (var i=1;i <= DS_TEMP.CountRow; i++ ) {
			strRtnVal = strRtnVal + DS_TEMP.NameValue(i,"RTNVAL")
			strRtnVal = strRtnVal.replace("<br>","");
			if (i != DS_TEMP.CountRow) 
				strRtnVal = strRtnVal + "\n";
		}
	} else {
		strRtnVal = strRtnVal + "내역 없음.";	
	}
	
	return strRtnVal;

}

</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->

<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *--><!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<!-- 메인 -->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    searchDoneWait();
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        if(TR_SAVE.SrvErrMsg('UserMsg',i) != "OK"){
            showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
        }else{
            showMessage(INFORMATION, OK, "USER-1000", "처리되었습니다.");
            EM_SALE_DT.TEXT = EM_PROC_DT.TEXT;
            EM_SALE_END_DT.TEXT = EM_PROC_DT.TEXT;
            btn_Search();
            ;
        }
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

<script language=JavaScript for=TR_SAVE event=onFail>
    searchDoneWait();
    trFailed(TR_SAVE.ErrorMsg);
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
	var strPosNm  = DS_MASTER_CROSS.NameValue(DS_MASTER_CROSS.RowPosition, "POS_NM");
	var arrArg    = new Array(strStrCd, strStrDt, strEndDt, strPosNo, strPosNm);
 	//alert("arrArg = " + arrArg);
	
	
	var returnVal = window.showModalDialog("/dps/jsp/psal/psal6101.jsp?"
			                              , arrArg
			                              , "dialogWidth:1150px;dialogHeight:420px;scroll:no;");
	// 입력/수정이 완료 됐을경우 재조회
	if (returnVal=="0")
		btn_Search();
	
	return;
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

<!-- 매출시작일 -->
<script language=JavaScript for=EM_PROC_DT event=onKillFocus()>

    //영업조회일
    if (isNull(EM_PROC_DT.text) ==true ) {
        showMessage(Information, OK, "USER-1003","처리일자"); 
        EM_PROC_DT.text = strToday;
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_PROC_DT.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","처리일자","8");
        EM_PROC_DT.text = strToday;
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_PROC_DT.text) ) {
        showMessage(Information, OK, "USER-1069","처리일자");
        EM_PROC_DT.text = strToday;
        return ;
    }
    

</script>

 
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
</script>

<script	language=JavaScript	for=RD_GUBUN event=onSelChange()>
	
	var strTemp = RD_GUBUN.CodeValue;
	
	if (DS_MASTER_CROSS.CountRow>0) {
		var strMsg = showMessage(QUESTION , YESNO, "USER-1000","조회된 내역이 초기화 됩니다. 진행하시겠습니까?")
		if (strMsg!=1){
			strTemp--;
			if (strTemp==0)
				strTemp = 1;
				RD_GUBUN.CodeValue = strTemp;
				RD_GUBUN.Focus();
			return;
		}
	}
	
	DS_MASTER_CROSS.ClearData();
	DS_MASTER.ClearData();
	
	if (strTemp == 1)  // 일자별
		GD_MASTER.ColumnProp("SALE_DT", "Show") = "true";
	else 	// 기간합
		GD_MASTER.ColumnProp("SALE_DT", "Show") = "false";
	RD_GUBUN.Focus();
	
</script>


<script language=JavaScript for=GD_MASTER event=OnToolTipText(row,col,colid)>
	var strRtnVal = colid;
	switch (col) {
		case 12 : 
		case 13 :
				strRtnVal = searchOGift(row,col)
				return strRtnVal;
				break;
		default : break;
	}
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
<comment id="_NSID_"><object id="DS_TEMP"      		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
	<object id="DS_MASTER_CROSS" classid=<%=Util.CLSID_DATASET%>>
		<param name=DataID         value="DS_MASTER">
		<param name=Logical        value="true">
		<param name=GroupExpr      value="STR_CD:SALE_DT:POS_NO:POS_NM:SALE_TO,COMM_NAME,CAL_AMT:NORM_TRAN_AMT:DIFF_AMT">
	</object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!-- 메인 -->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
									</comment><script> _ws_(_NSID_);</script>
									<input type="checkbox" id=pos_grping onClick="chkGrpingTf(this.checked);" > *그룹화
								</td>
								<th width="70">조회 구분</th>
								<td>
									<comment id="_NSID_">
										<object id="RD_GUBUN" classid="<%=Util.CLSID_RADIO%>" width=180 height=18 align="absmiddle">
										<param name="Cols"   value="2">
										<param name="Format" value="1^일자별,2^기간합">
										</object> 
									</comment><script> _ws_(_NSID_);</script>
									<input type="checkbox" id=amt_summary onclick="javascript:amtSumm(this.checked)"> 차이금액만표기
									</td>
									 
								</td>
								<th  width="60" style="background-color:#F6CECE;color:#FE2E2E; display:none; ">자료이관 처리일자</th>
								<td style="display:none;">
									<comment id="_NSID_">
										<object id=EM_PROC_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle" style="display:none;"></object>
									</comment><script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_PROC_DT);" align="absmiddle" style="display:none;"/>
									　　<img src="/<%=dir%>/imgs/btn/process.gif" onclick="javascript:fnChkProcess(LC_STR_CD.BindColVal,EM_PROC_DT.TEXT);" align="absmiddle" style="display:none;"/>
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
							<param name="DataID" value="DS_MASTER_CROSS">
							<param name="ToolTip"		value="use=true;">
							<param name="ToolTipValue"		value="use=true;">
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