<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 지점출고 신청
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (김성미) 신규작성
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

<script LANGUAGE="JavaScript"><!--
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
 var strToday   ;
 var btnClickSave = false;
 var strCurRow = 0;
function doInit(){

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 //기간 : 시작
    initEmEdit(EM_E_DT, "TODAY", PK);                 //기간 : 종료
    initEmEdit(EM_REQ_DT, "YYYYMMDD", PK);               //출고일
    initEmEdit(EM_REQ_SLIP_NO, "GEN", READ);           //점코드
    initEmEdit(EM_TOT_QTY, "NUMBER^12^0", READ);         //총신청수량
    initEmEdit(EM_TOT_AMT, "NUMBER^12^0", READ);          //사업자번호
    
    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);              //조회점
    initComboStyle(LC_REQ_STR,DS_O_REQ_STR, "CODE^0^30,NAME^0^80", 1, PK);      //신청점
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);              //본사점
    initComboStyle(LC_GIFT_TYPE_CD,DS_O_GIFT_TYPE_CD, "CODE^0^30,NAME^0^100", 1, PK);  //상품권종류
    
    strToday   = getTodayDB("DS_O_RESULT");
    getStore("DS_O_S_STR", "Y", "", "N");
    getStore("DS_O_REQ_STR", "Y", "", "N");
    getStore("DS_G_STR", "Y", "", "N");
    getStore("DS_O_STR", "N", "", "N");
    getCommCode();
    DS_O_STR.Filter();     //점구분 : 본사점만 셋팅
    LC_S_STR.Index = 0;
    setObject(false);
    LC_S_STR.Focus();
    
  //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif201", "DS_IO_MASTER,DS_IO_DETAIL");  
  
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width=30   align=center</FC>'
                     + '<FC>id=REQ_STR       name="점"     width=60 editstyle=Lookup Data="DS_G_STR:CODE:NAME"  align=left</FC>'
                     + '<FC>id=REQ_DT       name="신청일자"       width=80 mask="XXXX/XX/XX" align=center</FC>'
                     + '<FC>id=REQ_SLIP_NO    name="순번"     width=60   align=center</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"   edit=none      width=30   align=center</FC>'
        + '<FC>id=GIFT_TYPE_NAME    name="*상품권종류"      width=90 edit=none align=left</FC>'
        + '<FC>id=GIFT_AMT_NAME    name="*금종명"      width=90 edit=none align=left</FC>'
        + '<FC>id=GIFTCERT_AMT    name="상품권금액"      width=80 edit=none align=right</FC>'
        + '<FC>id=REQ_QTY    name="*신청수량"  sumtext=@sum  edit={if(STAT_FLAG == "01", true, false)}  width=70 edit=numeric align=right</FC>'
        + '<FC>id=TOT_AMT    name="신청금액"  sumtext=@sum    width=100 edit=none align=right</FC>'
        + '<FC>id=OUT_QTY    name="출고수량"  sumtext=@sum    width=70 edit=none align=right</FC>'
        + '<FC>id=STAT_FLAG_NAME    name="상태구분"   edit=none   width=70  align=left</FC>';
             
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	if(DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
        if(showMessage(QUESTION , YESNO, "USER-1072") != 1 ){
            return;
        }
   }
	
	// 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;     //신청기간 from 
    var strSdt          = EM_S_DT.Text;     //신청기간 from
    var strEdt          = EM_E_DT.Text;       //신청기간 to
    
    if(strEdt < strSdt) {
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
    
    TR_MAIN.Action="/mss/mgif201.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(strCurRow > 0){
    	DS_IO_MASTER.RowPosition = strCurRow;
    	strCurRow = 0;
    }else{
    	setObject(false);
    }
    
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
	 if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"REQ_SLIP_NO") == ""){
            if(showMessage(QUESTION , YESNO, "USER-1072") != 1 ){
                return;
            }else{
                DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
                }
      }
	   DS_IO_MASTER.AddRow();
	   LC_REQ_STR.Index = 0;
	   LC_STR.Index = 0;
	   EM_REQ_DT.Text = strToday;
	   setObject(true);
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	    var row = DS_IO_MASTER.RowPosition;
     
	    // 코드 생성구분 여부에 따른 삭제 가능 여부 체크
	    if(DS_IO_MASTER.NameValue(row, "STAT_FLAG") == "02"){
	        showMessage(EXCLAMATION  , OK, "USER-1000", "출고된 내역은 삭제할수 없습니다.");
	        return;
	    }
	    
	    if(showMessage(QUESTION , YESNO, "USER-1032", "지점출고 신청") != 1) return;
	    
	    var parameters = "&strStrCd="    + encodeURIComponent(DS_IO_MASTER.NameValue(row, "REQ_STR"))
	                   + "&strReqDt="    + encodeURIComponent(DS_IO_MASTER.NameValue(row, "REQ_DT"))
	                   + "&strReqSlipNo="+ encodeURIComponent(DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO"));   
	    var goTo       = "delete" ;    
	    TR_MAIN.Action="/mss/mgif201.mg?goTo="+goTo+parameters;  
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
    if (DS_IO_MASTER.CountRow == 0 || DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
	 
    // 필수 입력 사항 체크 
    if(!checkDSBlank( GD_DETAIL, "1,2")) return;    
    
    if(DS_IO_MASTER.SysStatus(DS_IO_MASTER.RowPosition) == "1" && EM_REQ_DT.Text < strToday){
    	 showMessage(EXCLAMATION, OK, "USER-1008", "신청일자", "오늘");
    	 EM_REQ_DT.Text = strToday ;
    	 EM_REQ_DT.Focus();
    	 return; 
    }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
    	if(DS_IO_DETAIL.SysStatus(i) == "3" && DS_IO_DETAIL.NameValue(i,"HSTR_CD") == "")DS_IO_DETAIL.NameValue(i,"HSTR_CD") = LC_STR.BindColVal;
    }
    btnClickSave = true;
    strCurRow = DS_IO_MASTER.RowPosition;
    TR_MAIN.Action="/mss/mgif201.mg?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();
    btnClickSave = false;
    if(TR_MAIN.ErrorCode == 0) DS_IO_MASTER.ClearData(); btn_Search();
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
  * getCommCode()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-18
  * 개    요 : 상품권종류 콤보 조회
  * return값 : void
  */
 function getCommCode(){
    TR_MAIN.Action="/mss/mgif201.mg?goTo=getGiftTypeCd";  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_GIFT_TYPE_CD=DS_O_GIFT_TYPE_CD)"; //조회는 O
    TR_MAIN.Post();
  }
  
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
    var strReqStr = DS_IO_MASTER.NameValue(row, "REQ_STR");
    var strReqSlipNo = DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO");
    var strGiftTypeCd = DS_IO_MASTER.NameValue(row, "GIFT_TYPE_CD");
    var strStatFlag = DS_IO_MASTER.NameValue(row, "STAT_FLAG");
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strReqDt="      + encodeURIComponent(strReqDt)
                    + "&strReqStr="    + encodeURIComponent(strReqStr)
                    + "&strReqSlipNo=" + encodeURIComponent(strReqSlipNo)
                    + "&strGiftTypeCd="+ encodeURIComponent(strGiftTypeCd)
                    + "&strStatFlag="  + encodeURIComponent(strStatFlag);
    TR_DETAIL.Action="/mss/mgif201.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
 }
 
 /**
  * getGiftTypeAmt()
  * 작 성 자 : 
  * 작 성 일 : 2011-06-14
  * 개    요 : 상품권종류에 따른 금종정보 조회
  *         현업 요청사항 추가 수정
  * return값 : void
  */
 function getGiftTypeAmt () {
    var strReqDt = EM_REQ_DT.Text;
    var strStrCd = LC_REQ_STR.BindColVal;
    var strHStrCd = LC_STR.BindColVal;
    var strGiftTypeCd = LC_GIFT_TYPE_CD.BindColVal;
    
    var goTo       = "getGiftTypeAmt" ;    
    var action     = "O";     
    var parameters = "&strReqDt="      + encodeURIComponent(strReqDt)
                    + "&strStrCd="     + encodeURIComponent(strStrCd)
                    + "&strHStrCd="    + encodeURIComponent(strHStrCd)
                    + "&strGiftTypeCd="+ encodeURIComponent(strGiftTypeCd);
    TR_DETAIL.Action="/mss/mgif201.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
 }
 
function setObject(flag){
	LC_REQ_STR.Enable = flag;
	EM_REQ_DT.Enable = flag;
	LC_STR.Enable = flag;
	enableControl(IMG_CAL, flag);
	enableControl(IMG_SEARCH, flag);
    LC_GIFT_TYPE_CD.Enable = flag;
}

 function setSum(){
	var sumQty = 0;
    var sumTot = 0;
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
        sumQty = sumQty + DS_IO_DETAIL.NameValue(i, "REQ_QTY");
        sumTot = sumTot + DS_IO_DETAIL.NameValue(i, "TOT_AMT");
    }
    EM_TOT_QTY.Text = sumQty;
    EM_TOT_AMT.Text = sumTot;
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
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
<script language=JavaScript for=DS_O_STR event=OnFilter(row)>
if (DS_O_STR.NameValue(row, "GBN") == "0") {// 본사점
    return true;
}
return false;
</script>
<script language=JavaScript for=DS_O_S_STR event=OnFilter(row)>
if (DS_O_S_STR.NameValue(row, "GBN") == "1") {// 매장점
    return true;
}
return false;
</script>
<script language=JavaScript for=DS_O_REQ_STR event=OnFilter(row)>
if (DS_O_REQ_STR.NameValue(row, "GBN") == "1") {// 매장점
    return true;
}
return false;
</script>
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if((DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated)&& !btnClickSave){
    if(showMessage(QUESTION , YESNO, "USER-1049") == 1 ){
    	if(DS_IO_MASTER.NameValue(row, "REQ_SLIP_NO") == ""){
    		DS_IO_MASTER.DeleteRow(row);
    	}else{
    		DS_IO_MASTER.NameValue(row, "TOT_QTY") = DS_IO_MASTER.OrgNameValue(row, "TOT_QTY");
    		DS_IO_MASTER.NameValue(row, "TOT_AMT") = DS_IO_MASTER.OrgNameValue(row, "TOT_AMT"); 
    	}
        return true;
    }else{
        return false;
    }
}
return true;
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
   if (DS_IO_MASTER.CountRow > 0) {
   if(this.SysStatus(row) == "1") {
	   DS_IO_DETAIL.ClearData();
	   return;
   }
    //디테일 조회
	   getDetail();
	   setObject(false);
    // 조회결과 Return
       setPorcCount("SELECT", GD_DETAIL);
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
if(colid == "GIFT_AMT_TYPE" || colid == "REQ_QTY"){
    if(colid == "GIFT_AMT_TYPE"){
    	if(checkDupKey(this, colid) != 0){
            showMessage(EXCLAMATION , OK, "USER-1044");
            this.NameValue(row,"REQ_QTY") = "0";
            this.NameValue(row,"GIFT_AMT_TYPE") = "";
            this.NameValue(row,"GIFTCERT_AMT") = "0";
            this.NameValue(row,"REQ_QTY") = "";
            this.NameValue(row,"TOT_AMT") = "";
            return;
        }
    }
	
	DS_IO_DETAIL.NameValue(row, "TOT_AMT") = DS_IO_DETAIL.NameValue(row, "GIFTCERT_AMT") * DS_IO_DETAIL.NameValue(row, "REQ_QTY");
	setSum();
}
</script>

 <script language=JavaScript for=DS_IO_DETAIL event=OnLoadCompleted(rowcnt)>
 if(rowcnt == 0) return;
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
</script>
<script language=JavaScript for=GD_DETAIL event=OnCloseUp(row,colid)>
    if(colid == "GIFT_TYPE_CD") {
    	DS_IO_DETAIL.NameValue(row, "GIFT_AMT_TYPE") = "";
    	DS_IO_DETAIL.NameValue(row,"REQ_QTY") = "0";
    	DS_IO_DETAIL.NameValue(row,"GIFT_AMT_TYPE") = "";
    	DS_IO_DETAIL.NameValue(row,"GIFTCERT_AMT") = "0";
    	DS_IO_DETAIL.NameValue(row,"REQ_QTY") = "";
    	DS_IO_DETAIL.NameValue(row,"TOT_AMT") = "";
   	    setSum();
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
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_REQ_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_G_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_TYPE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
        <td><table width="100%" border="0" cellpadding="0"자cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td  width="150">
                <comment id="_NSID_">
                   <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 tabindex=1 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="80" class="point">신청기간</th>
            <td>
                <comment id="_NSID_">
                <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=70 tabindex=1 align="absmiddle">
                </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" /> ~ 
               <comment id="_NSID_">
                <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%>  onblur="javascript:checkDateTypeYMD(this);" width=70 tabindex=1 align="absmiddle">
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
            </td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="170"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=505 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
          </tr>
        </table>
        </td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>신청마스터</td>
          </tr>
          <tr class="PB05">
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="80" class="point">신청점</th>
                    <td width="110">
                    <comment id="_NSID_">
	                <object id=LC_REQ_STR classid=<%=Util.CLSID_LUXECOMBO%>   width=108 tabindex=1 tabindex=1 >
	                </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="80" class="point">신청일자</th>
                    <td width="110">
                    <comment id="_NSID_">
	                <object id=EM_REQ_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=85 tabindex=1 align="absmiddle" tabindex=1>
	                </object></comment><script>_ws_(_NSID_);</script>
	                <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_CAL  onclick="javascript:openCal('G',EM_REQ_DT)" align="absmiddle" />
                    </td>
                    <th width="80" >신청순번</th>
                    <td>
                    <comment id="_NSID_">
	                <object id=EM_REQ_SLIP_NO classid=<%=Util.CLSID_EMEDIT%>   width=108 tabindex=1>
	                </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                  <th width="80" class="point">본사점</th>
                    <td width="110">
                    <comment id="_NSID_">
                    <object id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%>   width=108 tabindex=1 tabindex=1 >
                    </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  <th width="80" >총신청수량</th>
                  <td width="110">
                  <comment id="_NSID_">
                <object id=EM_TOT_QTY classid=<%=Util.CLSID_EMEDIT%>   width=108 tabindex=1>
                </object></comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="80" >총신청금액</th>
                  <td>
                   <comment id="_NSID_">
                <object id=EM_TOT_AMT classid=<%=Util.CLSID_EMEDIT%>   width=108 tabindex=1>
                </object></comment><script>_ws_(_NSID_);</script>
                  </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
               <td class="PB05">
               <table width="100%" border="0" cellpadding="0" cellspacing="0">
                   <tr>
                       <td width="85%">
                       <table width="100%" border="0" cellpadding="0" cellspacing="0"
                           class="s_table">
                           <tr>
                               <th width="80" class="point">상품권종류</th>
                               <td><comment id="_NSID_"> <object
                                   id=LC_GIFT_TYPE_CD classid=<%=Util.CLSID_LUXECOMBO%>
                                   height=100 width=132 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                               <img src="/<%=dir%>/imgs/btn/search_s1.gif" id=IMG_SEARCH
                                   onclick="javascript:getGiftTypeAmt();" align="absmiddle" />
                               </td>
                           </tr>
                       </table>
                       </td>
                   </tr>
               </table>
               </td>
           </tr>
          <tr><td class="dot"></td></tr>
          <tr>
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr height="10"></tr>
              <tr>
                  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>신청상세</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
		        <tr>
		        <td>
		            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=385 classid=<%=Util.CLSID_GRID%>>
		                <param name="DataID" value="DS_IO_DETAIL">
		                <Param Name="ViewSummary"   value="1" >
		            </OBJECT></comment><script>_ws_(_NSID_);</script>
		        </td>  
		          </tr>
		        </table>
		    </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=REQ_STR          Ctrl=LC_REQ_STR         param=BindColVal</c>
        <c>Col=REQ_DT           Ctrl=EM_REQ_DT          param=Text</c>
        <c>Col=HSTR_CD          Ctrl=LC_STR             param=BindColVal</c>
        <c>Col=GIFT_TYPE_CD     Ctrl=LC_GIFT_TYPE_CD             param=BindColVal</c>
        <c>Col=REQ_SLIP_NO      Ctrl=EM_REQ_SLIP_NO     param=Text</c>
        <c>Col=TOT_QTY          Ctrl=EM_TOT_QTY         param=Text</c>
        <c>Col=TOT_AMT          Ctrl=EM_TOT_AMT         param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

