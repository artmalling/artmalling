<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품입고/반품 > 사은행사 상품권 불출/반납
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE3040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.19 (김슬기) 신규작성
 *        2011.03.02 (김성미) 프로그램 작성
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
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var btnClickSave = false;
var btnClickSearch = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    gridCreate3();
    
    // EMedit에 초기화    
    initEmEdit(EM_S_EVENT_S_DT, "SYYYYMMDD", PK);            //조회 시작일
    initEmEdit(EM_S_EVENT_E_DT, "TODAY", PK);            //조회 종료일
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11", NORMAL);                //조회 행사코드
    initEmEdit(EM_S_EVENT_NM, "GEN", READ);                  //조회 행사 명
    initEmEdit(EM_EVENT_CD, "NUMBER3^11", PK);                  //행사코드
    initEmEdit(EM_EVENT_NM, "GEN", READ);                    //행사명
    initEmEdit(EM_DESK_CHAR_ID, "GEN^10", PK);              //DESK 담당자 ID
    initEmEdit(EM_DESK_CHAR_NM, "GEN", READ);                //DESK 담당자 명
    initEmEdit(EM_INOUT_DT, "YYYYMMDD", PK);             //불출일자
    
    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);      //조회점
    
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);  //등록 점
    initComboStyle(LC_INOUT_FLAG,DS_O_INOUT_FLAG, "CODE^0^30,NAME^0^80", 1, PK);  //불출반납구분      
    
    getEtcCode("DS_O_INOUT_FLAG",   "D", "M007", "N");
    
    getStore("DS_O_S_STR", "Y", "1", "N");
    getStore("DS_O_STR", "Y", "1", "N");
    LC_S_STR.Index = 0;
    setObject(false);
    LC_S_STR.Focus();
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=STR_NM      name="점"           width=60   align=left</FC>'
			        + '<FC>id=EVENT_CD    name="행사코드"       width=90  align=center</FC>'
                    + '<FC>id=EVENT_NAME    name="행사명"       width=140  align=left</FC>';
                     
    initGridStyle(GD_EVENT, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}          name="NO"         width=30   align=center</FC>'
			        + '<FC>id=INOUT_DT           name="불출일자"  sumtext="합계"  mask="XXXX/XX/XX"   width=80  align=center</FC>'
			        + '<FC>id=SLIP_NO            name="순번"     width=60   align=center</FC>'
                    + '<FC>id=INOUT_FLAG_NM      name="불출/반납"       width=80  align=center</FC>'
                    + '<FC>id=QTY                name="수량"   sumtext=@sum  width=60   align=right</FC>'
                    + '<FC>id=AMT                name="금액"   sumtext=@sum    width=80  align=right</FC>'
                    + '<FC>id=DESK_CHAR_NM       name="DESK담당자"     width=80   align=left</FC>';
                     
    initGridStyle(GD_GIFTINOUTINFO, "common", hdrProperies2, false);
}

function gridCreate3(){ 
    var hdrProperies3 ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                    + '<FC>id=GIFT_AMT_NAME    name="금종명"  sumtext="합계"  edit=none   width=120  align=left</FC>'
                    + '<FC>id=BUY_COST_PRC    name="상품권금액"  edit=none   width=90   align=right</FC>'
                    + '<FC>id=QTY    name="수량"   sumtext=@sum  width=100 Edit="Numeric"  align=right</FC>'
                    + '<FC>id=AMT    name="입고금액"  sumtext=@sum   width=100 edit=none  align=right</FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies3, true);
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
 * 작 성 일 : 2011-03-03
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_S_STR.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR.focus();
        return;
    }
    if(EM_S_EVENT_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_EVENT_S_DT.focus();
        return;
    }else if(EM_S_EVENT_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_EVENT_E_DT.focus();
        return;
    }else if(EM_S_EVENT_S_DT.Text > EM_S_EVENT_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_EVENT_S_DT.focus();
        return;
    }

    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;
    var strSdt          = EM_S_EVENT_S_DT.Text;
    var strEdt          = EM_S_EVENT_E_DT.Text;
    var strEventCd      = EM_S_EVENT_CD.Text;
    var goTo       = "getEvtInfo" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strEventSDt="+ encodeURIComponent(strSdt)
                   + "&strEventEDt="+ encodeURIComponent(strEdt)
                   + "&strEventCd=" + encodeURIComponent(strEventCd);
    btnClickSearch = true;
    TR_MAIN.Action="/mss/mcae304.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_EVTINFO=DS_O_EVTINFO)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_EVTINFO.CountRow > 0){
       // 사은행사 상품권 불출/반납 리스트 조회
       getGiftInoutList();   
       // 상품권 불출 마스터 내용 조회
       getGiftInoutMst();   
       // 상품권 불출 상세내용 조회
       getGiftInoutDtl();
       
       GD_EVENT.Focus();
    }else{
    	DS_O_GIFTINOUTINFO.ClearData();
    	DS_IO_MASTER.ClearData();
    	DS_IO_DETAIL.ClearData();
         setObject(false);
    }
    btnClickSearch = false;
 // 조회결과 Return
    setPorcCount("SELECT", DS_O_EVTINFO.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-03
 * 개    요 : 사은행사 불출/반남 신규
 * return값 : void
 */
function btn_New() {
	if(DS_O_EVTINFO.CountRow == 0){
		showMessage(EXCLAMATION , OK, "USER-1025");
		return;
	}
   if(DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
        if(showMessage(QUESTION , YESNO, "GAUCE-1000", "변경된 내용이 있습니다. 초기화 하시겠습니까?") != 1 ){
            return;
        }
    }else if(DS_IO_MASTER.NameValue(1, "SLIP_NO") == "" && !DS_IO_MASTER.IsUpdated){
       if(showMessage(QUESTION , YESNO, "GAUCE-1000", "신규 등록 중입니다. 초기화 하시겠습니까?") != 1 ){
           return;
       }
   }
   DS_IO_MASTER.ClearData();
   getGiftInoutMst("new");
   setObject(true,"new");
   getGiftInoutDtl();  
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
	   if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated || DS_IO_DETAIL.CountRow == 0){
	       //저장할 내용이 없습니다
	       showMessage(EXCLAMATION , OK, "USER-1028");
	       return;
	   }
	   
	// 필수 입력사항 체크 
	   if(LC_STR.BindColVal.length == 0){  // 점코드
	        showMessage(EXCLAMATION , OK, "USER-1002", "점");
	        LC_STR.focus();
	        return;
	    }
	   if(EM_EVENT_CD.Text.length < 11){  // 행사코드
           showMessage(EXCLAMATION , OK, "USER-1002", "행사코드");
           EM_EVENT_CD.focus();
           return;
       }
	   //if(EM_DESK_CHAR_ID.Text.length < 10){  // 담당자
	    if(EM_DESK_CHAR_ID.Text == ""){  // 담당자
           showMessage(EXCLAMATION , OK, "USER-1002", "DESK 담당자");
           EM_DESK_CHAR_ID.focus();
           return;
       }
	   if(EM_INOUT_DT.Text == ""){  // 불출일자
           showMessage(EXCLAMATION , OK, "USER-1002", "불출일자");
           EM_INOUT_DT.focus();
           return;
       }
	   if(LC_INOUT_FLAG.BindColVal.length == 0){  // 불출반납구분
           showMessage(EXCLAMATION , OK, "USER-1002", "불출반납구분");
           LC_INOUT_FLAG.focus();
           return;
       }
	   var strSum = 0;
	   for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
          strSum += DS_IO_DETAIL.NameValue(i,"QTY");
       }
	   
	   if(strSum == 0){
		   showMessage(EXCLAMATION , OK, "USER-1003", "수량"); 
		   setFocusGrid(GD_DETAIL, DS_IO_DETAIL, 1, "QTY");
		   return;
	   }
	   
	   for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
		   DS_IO_DETAIL.UserStatus(i) = 1; 
	   }
	   
	   DS_IO_MASTER.UserStatus(1) = 1; 
	   
	   if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
	   
	   btnClickSave = true;
	   TR_MAIN.Action="/mss/mcae304.mc?goTo=save"; 
	   TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
	   TR_MAIN.Post();
	   
	   btnClickSave = false;
	   if(TR_MAIN.ErrorCode == 0)btn_Search();
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
  * setObject()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-03
  * 개    요 : 오브젝트 활성/비활성화 셋팅
  * return값 : void
  */
 function setObject(strFlag, strUpdate) {
	  
	  LC_STR.Enable = strFlag;
	  EM_EVENT_CD.Enable = strFlag;
	  EM_DESK_CHAR_ID.Enable = strFlag;
	  EM_INOUT_DT.Enable = strFlag;
	  LC_INOUT_FLAG.Enable = strFlag;
	  GD_DETAIL.Enable = strFlag;
	  enableControl(IMG_EVENT, strFlag);
	  enableControl(IMG_DESK_CHAR, strFlag);

	  if(strUpdate == "update"){ // 담당자만 수정가능
		  EM_DESK_CHAR_ID.Enable = true;
		  GD_DETAIL.Enable = true;
		  enableControl(IMG_DESK_CHAR, true);
      }
	  
	  if(strUpdate == "new"){ // 새로 등록시 점코드 행사코드 수정 불가
		  LC_STR.Enable = false;
	      EM_EVENT_CD.Enable = false;
	      enableControl(IMG_EVENT, false);
	      LC_INOUT_FLAG.Index = 0;
      }
 }
 
/**
  * getGiftInoutList()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-03
  * 개    요 : 상품권 불출/반납 리스트 조회
  * return값 : void
  */
 function getGiftInoutList() {
	  var row = DS_O_EVTINFO.RowPosition;
	  // 조회조건 셋팅
	    var strStrCd        = DS_O_EVTINFO.NameValue(row, "STR_CD");
	    var strEventCd      = DS_O_EVTINFO.NameValue(row, "EVENT_CD");
	    var goTo       = "getGiftInoutList" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
	                   + "&strEventCd="+ encodeURIComponent(strEventCd);
	    TR_MAIN.Action="/mss/mcae304.mc?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_GIFTINOUTINFO=DS_O_GIFTINOUTINFO)"; //조회는 O
	    TR_MAIN.Post();
 }
 
 /**
  * getGiftInoutMst()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-03
  * 개    요 : 상품권 불출/반납 마스터 조회
  * return값 : void
  */
 function getGiftInoutMst(flag) {
	  // 조회조건 셋팅
	  if(DS_O_GIFTINOUTINFO.CountRow == 0 || flag == "new"){
		var strStrCd        = DS_O_EVTINFO.NameValue(DS_O_EVTINFO.RowPosition, "STR_CD");
        var strEventCd      = DS_O_EVTINFO.NameValue(DS_O_EVTINFO.RowPosition, "EVENT_CD");
        var strInOutDt      = getTodayFormat("yyyymmdd");
        var strSlipNo       = "";
        var strInoutFlag    = "0"; 
        setObject(true,"new");
	  }else{
		var strStrCd        = DS_O_GIFTINOUTINFO.NameValue(DS_O_GIFTINOUTINFO.RowPosition, "STR_CD");
        var strEventCd      = DS_O_GIFTINOUTINFO.NameValue(DS_O_GIFTINOUTINFO.RowPosition, "EVENT_CD");
        var strInOutDt      = DS_O_GIFTINOUTINFO.NameValue(DS_O_GIFTINOUTINFO.RowPosition, "INOUT_DT");
        var strSlipNo       = DS_O_GIFTINOUTINFO.NameValue(DS_O_GIFTINOUTINFO.RowPosition, "SLIP_NO");
        var strInoutFlag    = DS_O_GIFTINOUTINFO.NameValue(DS_O_GIFTINOUTINFO.RowPosition, "INOUT_FLAG");
        setObject(false,"update");
	  }
	    var goTo       = "getGiftInoutMst" ;    
        var action     = "O";     
        var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                       + "&strEventCd="  + encodeURIComponent(strEventCd)
                       + "&strInOutDt="  + encodeURIComponent(strInOutDt)
                       + "&strSlipNo="   + encodeURIComponent(strSlipNo)
                       + "&strInoutFlag="+ encodeURIComponent(strInoutFlag);
        TR_DTL.Action="/mss/mcae304.mc?goTo="+goTo+parameters;  
        TR_DTL.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_DTL.Post();
 }
 
 /**
  * getGiftInoutDtl()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-03
  * 개    요 : 상품권 불출/반납 상세 목록 조회
  * return값 : void
  */
 function getGiftInoutDtl() {
       var row = DS_IO_MASTER.RowPosition; 
      // 조회조건 셋팅
        var strStrCd        = DS_IO_MASTER.NameValue(row, "STR_CD");
        var strEventCd      = DS_IO_MASTER.NameValue(row, "EVENT_CD");
        var strSlipNo      = DS_IO_MASTER.NameValue(row, "SLIP_NO");
        var strInoutDt      = DS_IO_MASTER.NameValue(row, "INOUT_DT");
        
        var goTo       = "getGiftInoutDtl" ;    
        var action     = "O";     
        var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                       + "&strEventCd="+ encodeURIComponent(strEventCd)
                       + "&strInoutDt="+ encodeURIComponent(strInoutDt)
                       + "&strSlipNo=" + encodeURIComponent(strSlipNo);

        TR_DTL.Action="/mss/mcae304.mc?goTo="+goTo+parameters;  
        TR_DTL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
        TR_DTL.Post();
 }
 
 /**
  * getValiEvent()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-03
  * 개    요 : 행사코드 등록전 점코드 등록 여부 체크 
  * return값 : void
  */
 function getValiEvent(strStrCd) {
	 if(strStrCd == ""){
	     showMessage(EXCLAMATION , OK, "USER-1002", "점");
	     LC_STR.Focus();
	     return false;
	 }
	 return true;
 }
 
 /**
  * getEvent()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-03
  * 개    요 : 행사코드 등록전 점코드 등록 여부 체크 
  * return값 : void
  */
 function getEvent() {
	  var strStrCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");
	  if(!getValiEvent(strStrCd)) return;
	  mssEventPop('SEL_STR_EVENT_POP',EM_EVENT_CD,EM_EVENT_NM,'','','N', DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD")
			     , EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text ,'02');
 }

-->
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DTL event=onSuccess>
    for(i=0;i<TR_DTL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DTL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DTL event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
 // 행사코드가 변경이 되면 점코드와 행사 코드 등록 여부를 판단하여 불출 상세 내역을 조회
    if(colid == "EVENT_CD"){
        var strStrCd = this.NameValue(row, "STR_CD");
        var strEventCd = this.NameValue(row, "EVENT_CD");
        if(strStrCd.length == 2 && strEventCd.length == 11){
           // getGiftInoutDtl();
        }
    }
</script>
  <!-- 행사 목록-->
 <script language=JavaScript for=DS_O_EVTINFO event=CanRowPosChange(row)>
 if(row ==0) return;
 if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnClickSave){
     if(showMessage(QUESTION , YESNO, "GAUCE-1000", "변경된 내용이 있습니다. 이동 하시겠습니까?") != 1 ){
         return false;
     }
 }
return true;
</script>

<script language=JavaScript for=DS_O_EVTINFO event=OnRowPosChanged(row)>
if(row ==0) return;
if(btnClickSearch) return;
// 사은행사 상품권 불출/반납 리스트 조회
getGiftInoutList();   
//상품권 불출 마스터 내용 조회
getGiftInoutMst();   
// 상품권 불출 상세내용 조회
getGiftInoutDtl();
</script>
 

<!-- 불출 목록--> 
<script language=JavaScript for=DS_O_GIFTINOUTINFO event=CanRowPosChange(row)>
if(row ==0) return;
if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnClickSave){
    if(showMessage(QUESTION , YESNO, "GAUCE-1000", "변경된 내용이 있습니다. 이동 하시겠습니까?") != 1 ){
        return false;
    }
}
return true;
</script>

<script language=JavaScript for=DS_O_GIFTINOUTINFO event=OnRowPosChanged(row)>
if(row ==0) return;
if(btnClickSearch) return;
// 상품권 불출 마스터 내용 조회
getGiftInoutMst();   
// 상품권 불출 상세내용 조회
getGiftInoutDtl();
</script>

<!-- 상품권 수량 변경후 금액 계산 -->
<script language=JavaScript for=DS_IO_DETAIL event=CanRowPosChange(row)>
var strQty = DS_IO_DETAIL.NameValue(row,"QTY");
var strBuyCostPrc = DS_IO_DETAIL.NameValue(row,"BUY_COST_PRC");
var strAmt = 0;
strAmt = strQty * strBuyCostPrc;
DS_IO_DETAIL.NameValue(row,"AMT") = strAmt;
return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,olddata)>
var strQty = DS_IO_DETAIL.NameValue(row,"QTY");
	if(DS_IO_DETAIL.NameValue(row, "QTY") < 0){
	    DS_IO_DETAIL.NameValue(row, "QTY") = 0;
	}else{
		var strBuyCostPrc = DS_IO_DETAIL.NameValue(row,"BUY_COST_PRC");
		var strAmt = 0;
		strAmt = strQty * strBuyCostPrc;
		DS_IO_DETAIL.NameValue(row,"AMT") = strAmt;
	}

</script>

<!-- DESK 담당자  조회 -->
<script language=JavaScript for=EM_DESK_CHAR_ID event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_DESK_CHAR_ID.Text ==""){
	EM_DESK_CHAR_NM.Text = "";
       return;
   } 
if(EM_DESK_CHAR_ID.text!=null){
        if(EM_DESK_CHAR_ID.text.length > 0){
        	getUserNonPop('DS_O_S_CHAR',EM_DESK_CHAR_ID,EM_DESK_CHAR_NM,'E','Y');
        }
    }
</script>

<!-- 조회 행사조회  조회 -->
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if( EM_S_EVENT_CD.Text ==""){
	    EM_S_EVENT_NM.Text = "";
	       return;
	   }
	if(EM_S_EVENT_CD.Text != null){
	    if(EM_S_EVENT_CD.Text.length > 0){
	        var ret = setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM, '', '', "N", LC_S_STR.BindColVal);
	        // 조회내용이 없거나 1개 이상이면 팝업 호출
	        if(ret.CountRow == 1){
	            EM_S_EVENT_NM.Text = ret.NameValue(ret.RowPosition, "EVENT_NM");
	        }else{
	            mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N', LC_S_STR.BindColVal , EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text,'02');
	        }
	    }
	}
</script>

<!-- 행사조회  조회 -->
<script language=JavaScript for=EM_EVENT_CD event=onKillFocus()>
    var strStrCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");
    if(!getValiEvent(strStrCd)) return;
    
    if(EM_EVENT_CD.Text != null){
        if(EM_EVENT_CD.Text.length > 0){
            var ret = setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_EVENT_CD, EM_EVENT_NM, '', '', "N", strStrCd);
            // 조회내용이 없거나 1개 이상이면 팝업 호출
            if(ret.CountRow == 1){
                EM_EVENT_NM.Text = ret.NameValue(ret.RowPosition, "EVENT_NM");
            }else{
                mssEventPop('SEL_STR_EVENT_POP',EM_EVENT_CD,EM_EVENT_NM,'','','N', strStrCd, EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text,'02');
            }
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
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_INOUT_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_CHAR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_O_EVTINFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTINOUTINFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>    
<comment id="_NSID_">
<object id="TR_DTL" classid=<%=Util.CLSID_TRANSACTION%>>
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
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="80" class="point">점</th>
                        <td width="140">
                            <comment id="_NSID_">
                                <object id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> width="140" align="absmiddle"> 
                                </object>
                          </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">행사기간</th>
                        <td>
                            <comment id="_NSID_">
                                <object id=EM_S_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="90" align="absmiddle"> 
                                </object>
                            </comment><script>_ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_EVENT_S_DT)"/> ~ 
                            <comment id="_NSID_">
                                <object id=EM_S_EVENT_E_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="90" align="absmiddle">
                                </object>
                            </comment><script>_ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_EVENT_E_DT)" align="absmiddle" />
                        </td>
                    </tr>
                     <tr>
                        <th width="80">행사코드</th>
                        <td colspan=3> 
                            <comment id="_NSID_"> 
                                <object id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=140 align="absmiddle"> 
                                </object> 
                           </comment> <script>_ws_(_NSID_);</script> 
                           <img src="/pot/imgs/btn/detail_search_s.gif" onclick="javascript:mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N', LC_S_STR.BindColVal, EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text, '02');" align="absmiddle" /> 
                           <comment id="_NSID_"> 
                                <object id=EM_S_EVENT_NM classid=<%=Util.CLSID_EMEDIT%> width=180 align="absmiddle">
                                </object> 
                           </comment> <script> _ws_(_NSID_);</script>
                       </td>
                    </tr>
                </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="350" class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
                <td>
		            <comment id="_NSID_"><OBJECT id=GD_EVENT width=100% height=224 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_O_EVTINFO">
                    </OBJECT></comment><script>_ws_(_NSID_);</script>
		        </td>  
	          </tr>
	        </table></td>
	        <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	          <tr>	            
                <td>
                    <comment id="_NSID_"><OBJECT id=GD_GIFTINOUTINFO width=100% height=224 classid=<%=Util.CLSID_GRID%>>
	                     <param name="DataID" value="DS_O_GIFTINOUTINFO">
	                     <Param Name="ViewSummary"   value="1" >
	                </OBJECT></comment><script>_ws_(_NSID_);</script>
                </td>  
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
	       <tr>
	    <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td width="350" class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
              <tr>	              
                <th width="100" class="point">점</th>
                <td>
                   <comment id="_NSID_">
                        <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=230 align="absmiddle">
                        </object>
                  </comment><script>_ws_(_NSID_);</script> 
                </td>
              </tr>
              <tr>
                <th width="100" class="point">행사코드</th>
                <td>
                   <comment id="_NSID_">
                     <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1 align="absmiddle">
                     </object>
                   </comment><script> _ws_(_NSID_);</script> 
                   <img id=IMG_EVENT src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascript:getEvent();"  class="PR03" onclick=""  align="absmiddle"/>
                   <comment id="_NSID_">
                     <object id=EM_EVENT_NM classid=<%=Util.CLSID_EMEDIT%>   width=110 tabindex=1 align="absmiddle">
                     </object>
                   </comment><script> _ws_(_NSID_);</script> 
                </td>
              </tr>  
              <tr>
                <th width="100" class="point">DESK담당자</th>
                <td>
                   <comment id="_NSID_">
                     <object id=EM_DESK_CHAR_ID classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1 align="absmiddle">
                     </object>
                   </comment><script> _ws_(_NSID_);</script>
                   <img id=IMG_DESK_CHAR src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:getUserPop(EM_DESK_CHAR_ID,EM_DESK_CHAR_NM,'S');"  align="absmiddle"/>
                   <comment id="_NSID_">
                     <object id=EM_DESK_CHAR_NM classid=<%=Util.CLSID_EMEDIT%>   width=110 tabindex=1 align="absmiddle">
                     </object>
                   </comment><script> _ws_(_NSID_);</script> 
                </td>
              </tr>
              <tr>
                <th width="100" class="point">불출일자</th>
                <td>
                   <comment id="_NSID_">
                     <object id=EM_INOUT_DT classid=<%=Util.CLSID_EMEDIT%>  onblur="javascript:checkDateTypeYMD(this);" width=205 tabindex=1 align="absmiddle">
                     </object>
                   </comment><script> _ws_(_NSID_);</script> 
                   <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_INOUT_DT)" />
                </td>
              </tr>
              <tr>
                <th width="100" class="point">불출반납구분</th>
                <td>
                    <comment id="_NSID_">
                        <object id=LC_INOUT_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=230 align="absmiddle">
                        </object>
                  </comment><script>_ws_(_NSID_);</script> 
                </td>
              </tr>            
            </table></td>
	        <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>              
                <td>
                    <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=235 classid=<%=Util.CLSID_GRID%>>
                         <param name="DataID" value="DS_IO_DETAIL">
                         <Param Name="ViewSummary"   value="1" >
                    </OBJECT></comment><script>_ws_(_NSID_);</script>
                </td>  
              </tr>
            </table></td>
	      <tr>
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
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=INOUT_DT            ctrl=EM_INOUT_DT        param=Text</c>
        <c>col=STR_CD              ctrl=LC_STR             param=BindColVal</c>
        <c>col=INOUT_FLAG          ctrl=LC_INOUT_FLAG      param=BindColVal</c>
        <c>col=EVENT_CD            ctrl=EM_EVENT_CD        param=Text</c>
        <c>col=EVENT_NAME          ctrl=EM_EVENT_NM        param=Text</c>
        <c>col=DESK_CHAR_ID        ctrl=EM_DESK_CHAR_ID    param=Text</c>
        <c>col=DESK_CHAR_NM        ctrl=EM_DESK_CHAR_NM    param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

