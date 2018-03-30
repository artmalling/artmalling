<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 발행입고확정
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (김성미) 신규작성
 *        2011.04.15 (김성미) 프로그램 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strToday = getTodayFormat("YYYYMMDD");
var strCurRow = 0;
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
 var top = 450;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 //기간 : 시작
    initEmEdit(EM_E_DT, "TODAY", PK);                 //기간 : 종료
  
	//콤보 초기화
	initComboStyle(LC_S_STR,DS_O_MAIN_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점구분
   
    getStore("DS_O_MAIN_STR_CD", "N", "", "N");
    DS_O_MAIN_STR_CD.Filter();
    
    LC_S_STR.Index = 0;
    LC_S_STR.focus();
  //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif113", "DS_IO_MASTER,DS_IO_DETAIL");  
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=60   align=center</FC>'
                     + '<FC>id=STR_NAME    name="점"     sumtext="합계"     width=100   align=left</FC>'
                     + '<FC>id=REQ_DT      name="발행신청일자"  width=120 mask="XXXX/XX/XX"  align=center</FC>'
                     + '<FC>id=REQ_SLIP_NO name="발행신청번호"  width=120  align=center</FC>'
                     + '<FC>id=REQ_QTY_SUM name="수량"     sumtext=@sum      width=150   align=right</FC>'
                     + '<FC>id=REQ_AMT_SUM name="발행금액"   sumtext=@sum    width=200   align=right</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}            name="NO"    edit=none   width=30   align=center</FC>'
                      + '<FC>id=GIFT_AMT_NAME       name="금종명"  edit=none  sumtext="합계"      width=60   align=left</FC>'
			    	  + '<FG>id=TITLE               name="신청내역" edit=none align=center'
			          + '<FC>id=GIFT_S_NO           name="시작번호" edit=none     width=140  align=center</FC>'  
			          + '<FC>id=GIFT_E_NO           name="종료번호" edit=none     width=140  align=center</FC>'  
			          + '<FC>id=REQ_QTY             name="수량"   sumtext=@sum   edit=none width=70  align=right</FC>'  
			          + '<FC>id=TOT_AMT             name="발행신청금액" edit=none  sumtext=@sum    width=100  align=right</FC>'  
			          + '</FG>'  
			          + '<FG> id=TITLE               name="기입고내역" edit=none align=center'  
			          + '<FC>id=PRE_IN_QTY               name="수량"   edit=none sumtext=@sum   width=70  align=right</FC>'  
			          + '<FC>id=PRE_TOT_IN_AMT           name="금액"  edit=none sumtext=@sum    width=100  align=right</FC>'  
			          + '</FG>'  
			          + '<FG> id=TITLE              name="입고내역" edit=none  align=center'  
			          + '<FC>id=IN_GIFT_S_NO             name="*시작번호"  edit="numeric"  edit={if(PRE_IN_QTY = REQ_QTY, "false", "true")}  width=140  align=center</FC>'  
			          + '<FC>id=IN_GIFT_E_NO    name="*종료번호"  edit="numeric" edit={if(PRE_IN_QTY = REQ_QTY, "false", "true")}   width=140  align=center</FC>'  
			          + '<FC>id=IN_QTY    name="수량" sumtext=@sum  edit=none    width=70  align=right</FC>'  
			          + '<FC>id=IN_TOT_AMT    name="금액"  sumtext=@sum     width=100 edit=none align=right</FC>'  
			          + '</FG>'  
			          + '<FC>id=IN_DT    name="*입고일자" EditLimit=8 edit=numeric EditStyle=Popup  mask="XXXX/XX/XX"  edit={if(PRE_IN_QTY = REQ_QTY, "false", "true")}  width=80  align=center</FC>'  
			          + '<FC>id=IN_GBN    name="입고여부"   edit=none   width=60  align=left</FC>';  
		        
        initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-18
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	// 조회조건 셋팅
    var strStrCd          = LC_S_STR.BindColVal;   //점코드
    var strSdt        = EM_S_DT.Text;     //신청기간 from
    var strEdt          = EM_E_DT.Text;       //신청기간 to
    
    if(strSdt > strEdt) {
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    
    //데이타 셋 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
  
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+ encodeURIComponent(strStrCd)
                   + "&strSdt="  + encodeURIComponent(strSdt)
                   + "&strEdt="  + encodeURIComponent(strEdt);
    
    TR_MAIN.Action="/mss/mgif113.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    if(strCurRow > 0 ) DS_IO_MASTER.RowPosition = strCurRow;
    strCurRow = 0;
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-18
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
    if(DS_IO_DETAIL.CountRow  == 0){
          //저장할 내용이 없습니다
            showMessage(EXCLAMATION , OK, "USER-1028");
            return;
     }
    
    
    if(!checkDSBlank(GD_DETAIL, "8,9,10,11,12")) return;
   
    // 마감체크 (common.js) : 일마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosotion,"STR_CD")
                      , DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosotion,"REQ_DT")
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "일", "");
        return;
    }
    
    // 마감체크 (common.js) : 월마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosotion,"STR_CD")
                      , DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosotion,"REQ_DT")
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        return;
    }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    
    DS_IO_DETAIL.SortExpr= "IN_DT";
    DS_IO_DETAIL.Sort();

    btnSaveClick = true;
    strCurRow = DS_IO_MASTER.RowPosition;
    TR_MAIN.Action="/mss/mgif113.mg?goTo=save"; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";  
    searchSetWait("GC");
    TR_MAIN.Post();
    btnSaveClick = false;
    if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
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
  * getDetail()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-18
  * 개    요 : 하단 상세 조회
  * return값 : void
  */
 function getDetail () {
    var row = DS_IO_MASTER.RowPosition;
	var strReqDt = DS_IO_MASTER.NameValue(row, "REQ_DT");
    var strStrCd = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strReqSlipNo = DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO");
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strReqDt="     + encodeURIComponent(strReqDt)
                    + "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strReqSlipNo="+ encodeURIComponent(strReqSlipNo);
    
    TR_DETAIL.Action="/mss/mgif113.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
 }

--></script>
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
searchDoneWait();
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MAIN_STR_CD event=OnFilter(row)>
if (DS_O_MAIN_STR_CD.NameValue(row, "CODE") == "00") {// 지점
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
    //디테일 조회
    getDetail();
 // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}
</script>
 <script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
 if(colid == "IN_GIFT_S_NO" || colid == "IN_GIFT_E_NO"){
	 if(DS_IO_DETAIL.NameValue(row,"IN_GIFT_S_NO") != "" && DS_IO_DETAIL.NameValue(row,"IN_GIFT_E_NO") != ""){
	     // 입고 가능 수량  조회
	      var strSNo = DS_IO_DETAIL.NameValue(row,"IN_GIFT_S_NO");
	      var strENo = DS_IO_DETAIL.NameValue(row,"IN_GIFT_E_NO");
	      var parameters = "&strSNo=" + encodeURIComponent(strSNo)
	                      + "&strENo="+ encodeURIComponent(strENo);
	      
	      TR_DETAIL.Action="/mss/mgif113.mg?goTo=getGiftCnt"+parameters;  
	      TR_DETAIL.KeyValue="SERVLET(O:DS_O_GIFTCNT=DS_O_GIFTCNT)"; //조회는 O
	      TR_DETAIL.Post();
	      if(DS_O_GIFTCNT.NameValue(1,"CNT") > 0){
	          DS_IO_DETAIL.NameValue(row,"IN_QTY") = DS_O_GIFTCNT.NameValue(1,"CNT");
	          DS_IO_DETAIL.NameValue(row, "IN_TOT_AMT") = DS_IO_DETAIL.NameValue(row,"IN_QTY") * DS_IO_DETAIL.NameValue(row, "GIFTCERT_AMT");
	      }else{
	          DS_IO_DETAIL.NameValue(row,"IN_QTY") = 0;
	          DS_IO_DETAIL.NameValue(row,"IN_TOT_AMT") = 0;
	      }
	 }else{
	     DS_IO_DETAIL.NameValue(row,"IN_QTY") = 0;
	     DS_IO_DETAIL.NameValue(row,"IN_TOT_AMT") = 0;
	 }
 }
</script>
 
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid , "DS_IO_DETAIL");
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,olddata)>
//시작번호, 종료번호 변경시 상품권번호 유효성 체크
if(colid == "IN_GIFT_S_NO" || colid == "IN_GIFT_E_NO"){
    var strGiftCardNo = DS_IO_DETAIL.NameValue(row, colid);
    if(strGiftCardNo.length == 0 ) return;
    if (strGiftCardNo.length != 12 && strGiftCardNo.length != 13 && strGiftCardNo.length != 16 && strGiftCardNo.length != 18) {
    	showMessage(EXCLAMATION , OK, "USER-1069", "상품권 번호");
        DS_IO_DETAIL.NameValue(row, colid) = "";
        DS_IO_DETAIL.NameValue(row,"IN_QTY") = 0;
        DS_IO_DETAIL.NameValue(row,"IN_TOT_AMT") = 0;
        setTimeout("setFocusGrid(GD_DETAIL, DS_IO_DETAIL,"+row+",'"+colid+"');", 50);
        return false;
    }
    var strGiftTypeCd = DS_IO_DETAIL.NameValue(row, "GIFT_TYPE_CD");
    var strIssueType = DS_IO_DETAIL.NameValue(row, "ISSUE_TYPE");
    var strGiftAmtType = DS_IO_DETAIL.NameValue(row, "GIFT_AMT_TYPE");
    
    var goTo       = "chkGiftCardNo" ;    
    var action     = "O";     
    var parameters = "&strGiftCardNo="  + encodeURIComponent(strGiftCardNo)
                    + "&strGiftTypeCd=" + encodeURIComponent(strGiftTypeCd)
                    + "&strIssueType="  + encodeURIComponent(strIssueType)
                    + "&strGiftAmtType="+ encodeURIComponent(strGiftAmtType);
    
    TR_DETAIL.Action="/mss/mgif113.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_CHK_NO=DS_O_CHK_NO)"; //조회는 O
    TR_DETAIL.Post();
    if(DS_O_CHK_NO.NameValue(1, "IN_CNT") == "1"){
    	showMessage(EXCLAMATION , OK, "USER-1000", "기입고된 상품권 번호 입니다.");
    	DS_IO_DETAIL.NameValue(row, colid) = "";
    	DS_IO_DETAIL.NameValue(row,"IN_QTY") = 0;
        DS_IO_DETAIL.NameValue(row,"IN_TOT_AMT") = 0;
        setTimeout("setFocusGrid(GD_DETAIL, DS_IO_DETAIL,"+row+",'"+colid+"');", 50);
        return false;
    }
    
    if(DS_O_CHK_NO.NameValue(1, "REQ_CNT") == "0"){
    	showMessage(EXCLAMATION , OK, "USER-1069", "상품권 번호");
        DS_IO_DETAIL.NameValue(row, colid) = "";
        DS_IO_DETAIL.NameValue(row,"IN_QTY") = 0;
        DS_IO_DETAIL.NameValue(row,"IN_TOT_AMT") = 0;
        setTimeout("setFocusGrid(GD_DETAIL, DS_IO_DETAIL,"+row+",'"+colid+"');", 50);
        return false;
    }
    
    return true;
}

// 확정일자
if(colid == "IN_DT"){

}
</script>
<script language=JavaScript for=GD_DETAIL event=OnKillFocus()>

</script>

<script language=JavaScript for=GD_DETAIL    event=OnPopup(row,colid,data)>
    if(colid == "IN_DT"){
        openCal(this,row,colid);
        if(DS_IO_DETAIL.NameValue(row,colid) == "") return true;
        if(!checkDateTypeYMD(this, colid)) return false;
        var strReqDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REQ_DT");
        if(DS_IO_DETAIL.NameValue(row,colid) < strReqDt){
            showMessage(EXCLAMATION, OK, "USER-1008", "시작일자", "발행신청일자");
            //DS_IO_DETAIL.NameValue(row,colid) = getRawData(addDate("d", +1, strReqDt));
            DS_IO_DETAIL.NameValue(row,colid) = strReqDt;
            return false;
        }
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

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_MAIN_STR_CD"  classid=<%= Util.CLSID_DATASET %>> <param name=UseFilter value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">   
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHK_NO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTCNT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="110">
                <comment id="_NSID_">
                   <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle" tabindex=1>
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
            <th width="80" class="point">신청기간</th>
            <td>
                <comment id="_NSID_">
                  <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=70 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                   <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)"  align="absmiddle"/> ~ &nbsp;
                   <comment id="_NSID_">
                   <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%>  onblur="javascript:checkDateTypeYMD(this);" width=70 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                   <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT)"  align="absmiddle"/> 
            </td>
          </tr>           
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr height=15 valign="bottom">
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=330 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_MASTER">
                <Param Name="ViewSummary"   value="1" >
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
         </tr>
        </table>
       </td>
  </tr>
      <!--  그리드의 구분dot 여백  -->
       <tr><td class="dot"></td></tr>
       <!-- 그리드의 구분dot 여백  -->
  <tr>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=440 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_DETAIL">
                <Param Name="ViewSummary"   value="1" >
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
         </tr>
        </table>
       </td>
  </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

