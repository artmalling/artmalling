<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 발행의뢰(인쇄업체)
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2011.01.17 (김성미) 신규작성
 *        2011.04.13 (김성미) 프로그램 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 500;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_YMD_FROM, "SYYYYMMDD", PK);       //일자 from
    initEmEdit(EM_S_YMD_TO, "TODAY", PK);         //일자 to
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_MAIN_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점구분
    initComboStyle(LC_O_CODE_FLAG,"", "CODE^0^30,NAME^0^80", 1, NORMAL);    //발행확정구분
    
    getStore("DS_O_MAIN_STR_CD", "N", "", "N");
    DS_O_MAIN_STR_CD.Filter();     //점구분 : 지점만 셋팅
    
    LC_O_CODE_FLAG.index = 0;
    LC_STR_CD.index = 0;
    LC_STR_CD.focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif112", "DS_IO_MASTER,DS_IO_DETAIL");  
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                    // + '<FC>id=P_CHK_GB      name="선택" Edit={IF(CODE_GUBUN="0","false",IF(REQ_CNT=0,"false","true"))}    width=50 align=center HeadCheckShow="true" EditStyle="CheckBox"</FC>'
                     + '<FC>id=STR_CD    name="점코드"  sumtext="합계"    SHOW=FALSE </FC>'
                     + '<FC>id=STR_NAME    name="점"       width=150  align=left edit=none</FC>'
                     + '<FC>id=REQ_DT    name="발행신청일자"       width=120 mask="XXXX/XX/XX" align=center edit=none</FC>'
                     + '<FC>id=REQ_SLIP_NO    name="발행순번"     width=100   align=center edit=none</FC>'
                     + '<FC>id=REQ_QTY_SUM    name="수량"   sumtext=@sum  width=100   align=right edit=none</FC>'
                     + '<FC>id=REQ_AMT_SUM    name="발행금액" sumtext=@sum    width=120   align=right edit=none</FC>'
                     + '<FC>id=CODE_GUBUN_NM    name="코드생성구분"     width=120   align=left edit=none</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
		        + '<FC>id=GIFT_TYPE_CD    name="상품권종류코드" SHOW=FALSE</FC>'
		        + '<FC>id=GIFT_TYPE_NAME    name="상품권종류" sumtext="합계"   width=100  align=left edit=none</FC>'
		        + '<FC>id=GIFT_AMT_TYPE    name="금종"      width=50  align=center edit=none</FC>'
		        + '<FC>id=GIFT_AMT_NAME    name="금종명"      width=100  align=left edit=none</FC>'
		        + '<FC>id=GIFTCERT_AMT    name="상품권금액"      width=80  align=right edit=none</FC>'
		        + '<FC>id=REQ_QTY    name="수량"  sumtext=@sum    width=50  align=right edit=none</FC>'
		        + '<FC>id=GIFT_S_NO    name="시작번호"      width=150  align=center edit=none</FC>'
		        + '<FC>id=GIFT_E_NO    name="종료번호"      width=150  align=center edit=none</FC>'
		        + '<FC>id=REQ_AMT    name="발행금액"  sumtext=@sum    width=100  align=right edit=none</FC>'
		        + '<FC>id=STAT_FLAG_NAME    name="상태구분 "   width=80  align=left edit=none</FC>';
		        
        initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
        GD_DETAIL.ViewSummary = "1";   
     var hdrProperies2 = '<FC>id=GIFT_AMT_TYPE    name="금종"      width=50  align=center edit=none</FC>'
                       + '<FC>id=GIFT_AMT_NAME    name="금종명"      width=120  align=left edit=none</FC>'
                       + '<FC>id=GIFTCARD_NO    name="상품권번호"      width=300  align=left edit=none</FC>'
                       + '<FC>id=GIFTCERT_AMT    name="상품권금액"      width=100  align=right edit=none</FC>';
            
    initGridStyle(GD_EXCEL, "common", hdrProperies2, true);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	// 조회조건 셋팅
    var strStrCd          = LC_STR_CD.BindColVal;   //점코드
    var strYmdFrom        = EM_S_YMD_FROM.Text;     //신청기간 from
    var strYmdTo          = EM_S_YMD_TO.Text;       //신청기간 to
    var strCodeFlag       = LC_O_CODE_FLAG.BindColVal;  //코드생성구분
    
    if(strYmdFrom > strYmdTo) {
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_YMD_FROM.Focus();
        return;
    }
    //데이타 셋 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
  
    var goTo       = "getReqMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strYmdFrom=" + encodeURIComponent(strYmdFrom)
                   + "&strYmdTo="   + encodeURIComponent(strYmdTo)
                   + "&strCodeFlag="+ encodeURIComponent(strCodeFlag)
                   ;
    TR_MAIN.Action="/mss/mgif112.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-13
 * 개    요 : 발행의뢰 신청 삭제
 * return값 : void
 */
function btn_Delete() {
	 var row = DS_IO_MASTER.RowPosition;
	 
	// 코드 생성구분 여부에 따른 삭제 가능 여부 체크
    if(DS_IO_MASTER.NameValue(row, "CODE_GUBUN") == "1"){
    	showMessage(EXCLAMATION  , OK, "USER-1000", "생성된 신청 내역은 삭제할수 없습니다.");
    	return;
    }
    
    if(showMessage(QUESTION , YESNO, "USER-1032", "미발행신청 내역") != 1) return;
    
    var parameters = "&strStrCd="    + encodeURIComponent(DS_IO_MASTER.NameValue(row, "STR_CD"))
				   + "&strReqDt="    + encodeURIComponent(DS_IO_MASTER.NameValue(row, "REQ_DT"))
				   + "&strReqSlipNo="+ encodeURIComponent(DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO"));   
    var goTo       = "delIssueReq" ;    
    TR_MAIN.Action="/mss/mgif112.mg?goTo="+goTo+parameters;  
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 // 저장할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
	 
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CODE_GUBUN") == "1"){
    	showMessage(EXCLAMATION , OK, "USER-1000", "이미 생성된 자료  입니다.");
        return;
    }
	 
	var strCnt = 0;
	for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
		// 상태구분이 신청(01) 이거나 발행의뢰(02) 인경우에만 데이터셋 상태 변경
	    if(DS_IO_DETAIL.NameValue(i, "STAT_FLAG") == "01" || DS_IO_DETAIL.NameValue(i, "STAT_FLAG") == "02" || DS_IO_DETAIL.SysStatus(i) != 2){
	    	DS_IO_DETAIL.UserStatus (i) = "1";
	    	strCnt = strCnt + 1;
	    }
	}
    
	if(strCnt == 0 && !DS_IO_DETAIL.IsUpdated){
		 showMessage(EXCLAMATION , OK, "USER-1028");
	        return;
	}
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
 
    TR_MAIN.Action="/mss/mgif112.mg?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    searchSetWait("B");
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-15
 * 개    요 : 발행의뢰 목록 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	// 저장할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION , OK, "SCRIPT-1014");
        return;
    }
	
	DS_IO_MASTER.UserStatus (DS_IO_MASTER.RowPosition) = "1";
	
	searchSetWait("B");
    TR_MAIN.Action="/mss/mgif112.mg?goTo=getExcel";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,O:DS_O_EXCEL=DS_O_EXCEL)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_EXCEL.CountRow > 0) 
    	openExcel5(GD_EXCEL, "상품권 발행의뢰", "", true, true, "",g_strPid );
    	//openExcel2(GD_EXCEL, "상품권 발행의뢰", "", true, true);
    	//openExcel(GD_EXCEL, "상품권 발행의뢰", "", true );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
// 	var strReqDt      =  ""; 
//     var strStrCd      =  ""; 
//     var strReqSlipNo  =  ""; 
	    
// 	var arrReqDt      =  new Array(); 
//     var arrStrCd      =  new Array(); 
//     var arrReqSlipNo  =  new Array(); 
//     if(DS_IO_MASTER.CountRow == 0){
//     	showMessage(EXCLAMATION , OK, "USER-1031");
//         return;
//     }
//     if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CODE_GUBUN")== "0" 
//     		|| DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REQ_CNT")== "0"){
//     	showMessage(EXCLAMATION , OK, "USER-1000","미생성 자료입니다. 출력할 내용이 없습니다.");
//         return;
//     }
//     var k = 0;
//    // for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
//    // 	if(DS_IO_MASTER.NameValue(i,"P_CHK_GB") == "T"){
//     		arrReqDt[0]      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REQ_DT");
//             arrStrCd[0]      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");
//             arrReqSlipNo[0]   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REQ_SLIP_NO");
//   //          k = k + 1; 
//   //  	}
//   //  }
//     if(arrReqDt.length == 0){
//         showMessage(EXCLAMATION , OK, "USER-1031");
//         return;
//     }
//     if(arrReqDt.length == 1){
//     	strReqDt      =  arrReqDt[0];
//         strStrCd      =  arrStrCd[0];
//         strReqSlipNo  =  arrReqSlipNo[0];
//     }
//   //else{
//   //	 for(var j=0;j<arrReqDt.length;j++){
//   //	   if(j==0){
//   //		  strReqDt      =  arrReqDt[j];
//   //          strStrCd      =  arrStrCd[j];
//   //          strReqSlipNo  =  arrReqSlipNo[j];
//   //	   }else{
//   //    	   strReqDt      =  strReqDt + "/" + arrReqDt[j];
//   //           strStrCd      =  strStrCd + "/" + arrStrCd[j];
//   //           strReqSlipNo  =  strReqSlipNo + "/" + arrReqSlipNo[j]; 
//   //	   }    
//   //	}
//   // }
   
//    // alert(strReqSlipNo);
//     var params   = "&strReqDt="+strReqDt
//                  + "&strStrCd="+strStrCd
//                  + "&strReqSlipNo="+strReqSlipNo
//                  + "&strParamCnt="+arrReqDt.length;
//     window.open("/mss/mgif112.mg?goTo=print"+params, "OZREPORT", 1000, 700);
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getReqDtl()
  * 작 성 자 : 
  * 작 성 일 : 2010-03-11
  * 개    요 : 하단 상세 조회
  * return값 : void
  */
 function getReqDtl (strReqDt,strStrCd,strReqSlipNo) {
  
    var goTo       = "getReqDtl" ;    
    var action     = "O";     
    var parameters = "&strReqDt="     +encodeURIComponent(strReqDt)
				    + "&strStrCd="    +encodeURIComponent(strStrCd)
				    + "&strReqSlipNo="+encodeURIComponent(strReqSlipNo);
    
    TR_MAIN1.Action="/mss/mgif112.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN1.Post();
 }
 
 function delRow(){
	// 코드 생성구분 여부에 따른 삭제 가능 여부 체크
	// DECODE(TA.STAT_FLAG, '01', '신청', '02', '발행의뢰', '03', '입고', '09','삭제') AS STAT_FLAG_NAME
	   
	    if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STAT_FLAG") == "09"){
	        showMessage(EXCLAMATION  , OK, "USER-1000", "이미 삭제된 내역입니다.");
	        return;
	    }
	
	    if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STAT_FLAG") == "03"){
            showMessage(EXCLAMATION  , OK, "USER-1000", "입고된 내역은 삭제할수 없습니다.");
            return;
        }
     DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
 } 
 
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
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
<script language=JavaScript for=TR_MAIN event=onSuccess>
    searchDoneWait();
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    searchDoneWait();
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MAIN_STR_CD event=OnFilter(row)>
if (DS_O_MAIN_STR_CD.NameValue(row, "CODE") == "00") {// 본사점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if(DS_IO_DETAIL.IsUpdated){
    if (showMessage(QUESTION , YESNO, "USER-1074") != 1) return false;
        return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if (DS_IO_MASTER.CountRow > 0) {
    var strReqDt = DS_IO_MASTER.NameValue(row, "REQ_DT");
    var strStrCd = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strReqSlipNo = DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO");

    //디테일 조회
    getReqDtl(strReqDt,strStrCd,strReqSlipNo);
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
    GD_MASTER.Focus();
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 전체 선택/해제 -->
<script language=JavaScript for=GD_MASTER
	event="OnHeadCheckClick(Col,Colid,bCheck)">       
if (Colid == "P_CHK_GB") {
        if (bCheck == 1) {
        	GD_MASTER.Redraw = false;
            for (var i = 1; i <= DS_IO_MASTER.CountRow; i++)
            {
                if(DS_IO_MASTER.NameValue(i, "CODE_GUBUN") == "0")continue;
                DS_IO_MASTER.NameValue(i, "P_CHK_GB") = "T";
            }    
            GD_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GD_MASTER.Redraw = false;
            for (var i = 1; i <= DS_IO_MASTER.CountRow; i++)
            {
            	if(DS_IO_MASTER.NameValue(i, "CODE_GUBUN") == "0")continue;
                DS_IO_MASTER.NameValue(i, "P_CHK_GB") = "F";
            } 
            GD_MASTER.Redraw = true;
        }
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row == 0 && colid != "P_CHK_GB") sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
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

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_MAIN_STR_CD" classid=<%=Util.CLSID_DATASET%>>
	<param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EXCEL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
	<param name=TimeOut    value=2400000>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
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
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
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
						<th width="100" class="point">점</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=118 align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th width="100" class="point">신청일자</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_S_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70"
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_YMD_FROM)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_YMD_TO
							classid=<%=Util.CLSID_EMEDIT%> width="70" align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_YMD_TO)" align="absmiddle" />
						</td>
						<th width="120">상품권발행확정구분</th>
						<td><comment id="_NSID_"> <object id=LC_O_CODE_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100>
							<param name=CBData value="%^전체,0^미확정,1^확정">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value=NAME>
							<param name=Sort value=False>
							<param name=ListExprFormat value="CODE^0^20,NAME^0^50">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr height=15 valign="bottom">
		<td class="dot"></td>
	</tr>
	<tr valign="top">
		<td class="PB05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=370 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
	   <td align="right">
	       <img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DELROW width="52" height="18" onclick="javascript:delRow();"/>
	   </td>
	</tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="BD4A">
		<tr>
			<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
				width=100% height=370 classid=<%=Util.CLSID_GRID%>>
				<param name="DataID" value="DS_IO_DETAIL">
				<param name=TimeOut    value=2400000>
			</OBJECT></comment><script>_ws_(_NSID_);</script></td>
		</tr>
	</table>
	</td>
	</tr>
</table>
</DIV>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<OBJECT id=GD_EXCEL width=0 height=0 classid=<%=Util.CLSID_GRID%>>
	<param name="DataID" value="DS_O_EXCEL">
</OBJECT>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

