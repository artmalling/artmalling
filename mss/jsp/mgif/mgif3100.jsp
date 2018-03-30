<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 가맹점상품권회수관리
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 회수 등록
 * 이    력 :
 *        2011.05.19 (김성미) 프로그램작성
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
 var strOrgCd = '<c:out value="${sessionScope.sessionInfo.ORG_CD}" />';
 var strToday   ;
 var btnSaveClick = false;
 var strCurrRow = 0;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 125;		//해당화면의 동적그리드top위치
 var top2 = 220;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화
   DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
   DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 // 회수일자 / 조회
    initEmEdit(EM_E_DT, "TODAY", PK);                 // 회수일자 / 조회
    initEmEdit(EM_S_VEN_CD,  "NUMBER3^6", NORMAL);                   // 등록자
    initEmEdit(EM_S_VEN_NM,  "GEN", READ);                   // 등록자
    initEmEdit(EM_GIFT_NO, "GEN^12", NORMAL);           // 상품권코드
    initEmEdit(EM_DRAWL_DT, "YYYYMMDD", PK);              // 회수일자
    initEmEdit(EM_DRAWL_SLIP_NO, "GEN", READ);              // 순번
    initEmEdit(EM_VEN_CD, "NUMBER3^6", PK);                 // 가맹점
    initEmEdit(EM_VEN_NM, "GEN", READ);                     // 가맹점 명
    
  //콤보 초기화
    initComboStyle(LC_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                  //점
    initComboStyle(LC_DRAWL_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);            //점
    
    getStore("DS_O_S_STR", "Y", "", "N");
    getStore("DS_O_STR", "Y", "", "N");
    strToday   = getTodayDB("DS_O_RESULT");
    EM_E_DT.Text = strToday;
    LC_STR.Index = 0;
    LC_STR.Focus();
    
    setNew();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif310", "DS_IO_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                     + '<FC>id=SLIP_NO    name="전표번호" edit=none width=130  align=left</FC>'
                     + '<FC>id=VEN_NM    name="가맹점"   edit=none  width=90   align=left</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
    	+ '<FC>id=FLAG                name=""       EditStyle=checkbox width=20 HeadCheckShow=true HeadAlign=center align=center</FC>'
        + '<FC>id=GIFT_TYPE_NAME    name="상품권종류" SumText="합계"    edit=none  width=90   align=left</FC>'
        + '<FC>id=GIFT_AMT_NAME    name="금종"   edit=none  width=90   align=left</FC>'
        + '<FC>id=GIFTCERT_AMT    name="상품권금액" SumText=@sum edit=none   width=90   align=right</FC>'
        + '<FC>id=GIFTCARD_NO    name="상품권코드"  edit=none   width=140   align=center</FC>'
        + '<FC>id=QTY    name="수량"  SumText=@sum edit=none width=70   align=right</FC>'
        + '<FC>id=STAT_FLAG_NM    name="상품권상태"  edit=none   width=70   align=left</FC>'
        + '<FC>id=SALE_DT    name="판매일자"   edit=none show=false width=90  mask="XXXX/XX/XX" align=center</FC>';
        
        initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
        GD_DETAIL.ViewSummary = "1";
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
 * 작 성 일 : 2011-05-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if((DS_IO_MASTER.CountRow > 0 && (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)) 
	            &&  (showMessage(QUESTION , YESNO, "USER-1084") != 1)){
	        return;
	    }
	 
	 if(LC_STR.BindColVal == ""){
        showMessage(EXCLAMATION , OK, "USER-1002",  "점");
        LC_STR.Focus();
        return;
    }
	 
	 if(EM_S_DT.Text > EM_E_DT.Text){
		showMessage(EXCLAMATION , OK, "USER-1015");
		EM_S_DT.Focus();
        return;
     }
  
	 
	 DS_IO_MASTER.ClearData();
	 DS_IO_DETAIL.ClearData();
	 
	 var strParam = "&strStrCd="   + encodeURIComponent(LC_STR.BindColVal)
	                 + "&strSDt="  + encodeURIComponent(EM_S_DT.Text)
	                 + "&strEDt="  + encodeURIComponent(EM_E_DT.Text)
	                 + "&strVenCd="+ encodeURIComponent(EM_S_VEN_CD.Text);
	    
	    TR_MAIN.Action="/mss/mgif310.mg?goTo=getMaster"+strParam;  
	    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
	    TR_MAIN.Post();
	    if(strCurrRow > 0) DS_IO_MASTER.RowPosition = strCurrRow;
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
    
    DS_IO_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    setNew();
}

/**
 * btn_Delete()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-05-24
 * 개    요 : 상품권회수 내역 삭제
 * return값 : void
 */
function btn_Delete() {
	   // 삭제할 데이터가 없는 경우
    if (DS_IO_MASTER.CountRow == 0 || DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
//     // 마감체크 (common.js) : 월마감 / 정산마감
//     if( getCloseCheck('DS_CLOSECHECK'
//                       , LC_DRAWL_STR.BindColVal
//                       , EM_DRAWL_DT.Text
//                       ,'MGIF','47','0','M') == 'TRUE'){
//         showMessage(EXCLAMATION, Ok,  "USER-1068", "정산 월", "");
//         LC_DRAWL_STR.Focus();
//         return;
//     }
    
//  // 마감체크 (common.js) : 일마감 / 수불마감 
//     if( getCloseCheck('DS_CLOSECHECK'
//                       , LC_DRAWL_STR.BindColVal
//                       , EM_DRAWL_DT.Text
//                       ,'MGIF','25','0','D') == 'TRUE'){
//         showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 일", "");
//         LC_DRAWL_STR.Focus();
//         return;
//     }
     
//     // 마감체크 (common.js) : 월마감 / 수불마감 
//     if( getCloseCheck('DS_CLOSECHECK'
//                       , LC_DRAWL_STR.BindColVal
//                       , EM_DRAWL_DT.Text
//                       ,'MGIF','46','0','M') == 'TRUE'){
//         showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 월", "");
//         LC_DRAWL_STR.Focus();
//         return;
//     }
    
    
    if (EM_DRAWL_DT.text < strToday) {
    	showMessage(EXCLAMATION, OK, "USER-1000", "회수일이 오늘 이전인것은 삭제 할 수 없습니다.");
    	return;
    	
    }
    
    
    if (showMessage(QUESTION , YESNO, "USER-1023") != 1) return;
    
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
        DS_IO_DETAIL.UserStatus(i) = 2;
    }
    
    TR_MAIN.Action="/mss/mgif310.mg?goTo=delete";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) {
        btn_Search();
    }
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
     
//     // 마감체크 (common.js) : 월마감 / 정산마감
//     if( getCloseCheck('DS_CLOSECHECK'
//                       , LC_DRAWL_STR.BindColVal
//                       , EM_DRAWL_DT.Text
//                       ,'MGIF','47','0','M') == 'TRUE'){
//         showMessage(EXCLAMATION, Ok,  "USER-1068", "정산 월", "");
//         LC_DRAWL_STR.Focus();
//         return;
//     }
    
//     // 마감체크 (common.js) : 일마감 / 수불마감 
//     if( getCloseCheck('DS_CLOSECHECK'
//                       , LC_DRAWL_STR.BindColVal
//                       , EM_DRAWL_DT.Text
//                       ,'MGIF','25','0','D') == 'TRUE'){
//         showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 일", "");
//         LC_DRAWL_STR.Focus();
//         return;
//     }
     
//     // 마감체크 (common.js) : 월마감 / 수불마감 
//     if( getCloseCheck('DS_CLOSECHECK'
//                       , LC_DRAWL_STR.BindColVal
//                       , EM_DRAWL_DT.Text
//                       ,'MGIF','46','0','M') == 'TRUE'){
//         showMessage(EXCLAMATION, Ok,  "USER-1068", "수불 월", "");
//         LC_DRAWL_STR.Focus();
//         return;
//     }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
  
    TR_MAIN.Action="/mss/mgif310.mg?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();
    if(strCurrRow == 0) strCurrRow = DS_IO_MASTER.RowPosition;
    DS_IO_MASTER.ClearData();
    if(TR_MAIN.ErrorCode == 0) {
        btn_Search();
    }
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
  * setNew()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-05-09
  * 개    요 : 초기화
  * return값 : void
  */ 
 function setNew(){
     var contents = document.getElementsByName("CONTENTS");
     if(DS_IO_MASTER.CountRow == 0 || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_SLIP_NO") != "")
    	 var strFlag = false;
     else
    	 var strFlag = true;
     
     for(var i=0;i<contents.length;i++){
         contents[i].Enable = strFlag;
     }
     enableControl(IMG_CAL, strFlag);
     enableControl(IMG_VEN, strFlag);
     enableControl(IMG_DEL, strFlag);
     GD_DETAIL.Editable = strFlag;
     
     if(strFlag){
    	 LC_DRAWL_STR.Index = 0;
    	 EM_DRAWL_DT.Text = strToday;
     }
}

 /**
  * getDetail()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-05-24
  * 개    요 : 조회시 호출
  * return값 : void
  */
 function getDetail() {
         var strParam = "&strStrCd="  + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_STR"))
                      + "&strDrawlDt="+ encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_DT"))
                      + "&strSlipNo=" + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_SLIP_NO"));
         
         TR_DTL.Action="/mss/mgif310.mg?goTo=getDetail"+strParam;  
         TR_DTL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
         TR_DTL.Post();
 }
 
 /**
  * getGiftNoInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 :  상품권 정보 조회
  * return값 : void
  */ 
 function getGiftNoInfo(){

     DS_O_GIFT_INFO.ClearData();
     var goTo       = "getGiftNoInfo";
     var parameters = "&strStrCd="  + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_STR"))
                    + "&strDrawlDt="+ encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DRAWL_DT"))
                    + "&strVenCd="  + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD"))
                    + "&strGiftNo=" + encodeURIComponent(EM_GIFT_NO.Text); 
     TR_MAIN.Action   = "/mss/mgif310.mg?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(O:DS_O_GIFT_INFO=DS_O_GIFT_INFO)";
     TR_MAIN.Post();
     
     if(DS_O_GIFT_INFO.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
         EM_GIFT_NO.Text = "";
         setTimeout("EM_GIFT_NO.Focus()", 50);
         return;
     }
          
     var strData = DS_O_GIFT_INFO.ExportData(1, DS_O_GIFT_INFO.CountRow, true);
     DS_IO_DETAIL.ImportData(strData);
     EM_GIFT_NO.Text = "";
     setTimeout("EM_GIFT_NO.Focus()", 50);
 }

 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-19
  * 개    요 :  행삭제
  * return값 : void
  */
function delRow(){
	if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
	
	if(DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
	
	var strCnt = DS_IO_DETAIL.CountRow;
    for(var i=1;i<=strCnt;i++){
        if(DS_IO_DETAIL.NameValue(i,"FLAG") == "T"){
        	DS_IO_DETAIL.DeleteRow(i);     
            i = i -1;
        }
    }
    
	if(DS_IO_DETAIL.CountRow == 0){
		GD_DETAIL.ColumnProp('FLAG','HeadCheck')= "FALSE";
    }
}
 
/**
 * getVenCd()
 * 작 성 자 : 
 * 작 성 일 : 2011-04-06
 * 개    요 : 가맹점 팝업 오픈시 점코드 필수
 * return값 : void
 */
function getVenCd(objStr, objCd, objNm){
		 
    if(objStr.BindColVal == "%" || objStr.BindColVal == "" ){
           showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
           objStr.Focus();
           return;
       }
    getMssEvtVenPop( objCd, objNm, 'S', '2', '', objStr.BindColVal, '', 'Y');
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
trFailed(TR_DTL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
 if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnSaveClick){
         if(showMessage(QUESTION , YESNO, "USER-1074") != 1 ){
             return false;
         }
         if(DS_IO_MASTER.NameValue(row,"SLIP_NO") == ""){
             DS_IO_MASTER.DeleteRow(row);
             return true;
         }
         return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(row == 0) return;
getDetail();
setNew();
// 조회결과 Return
setPorcCount("SELECT", GD_DETAIL);
GD_MASTER.Focus();
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 <script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_S_VEN_NM.Text = "";
        return;
    }
if(this.Text.length > 0){
    if(LC_STR.BindColVal == "%"){
        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
        LC_S_STR.Focus();
        return;
    }
    getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "2", '', LC_STR.BindColVal, '', 'Y');
}
</script>
 <script language=JavaScript for=EM_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_VEN_NM.Text = "";
        return;
    }
if(this.Text.length > 0){
    if(LC_DRAWL_STR.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
        LC_DRAWL_STR.Focus();
        return;
    }
    getMssEvtVenNonPop( "DS_O_RESULT", EM_VEN_CD, EM_VEN_NM, "E", "Y", "2", '', LC_DRAWL_STR.BindColVal, '', 'Y');
}
</script>
<script language=JavaScript for=EM_DRAWL_DT event=OnKillFocus()>
/*if(this.Text < strToday){
    showMessage(EXCLAMATION, OK, "USER-1030", "회수일자");
    this.Text = strToday;
    this.Focus();
    return false;
}*/
return true;
</script>
 
<script language=JavaScript for=EM_GIFT_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout(this.id+".Focus()", 50);
    return;
}

if(LC_DRAWL_STR.BindColVal == ""){
    showMessage(EXCLAMATION, OK, "USER-1002", "회수점");
    this.Text = "";
    setTimeout("LC_DRAWL_STR.Focus();", 50);
    return;
}
if(EM_DRAWL_DT.Text == ""){
    showMessage(EXCLAMATION, OK, "USER-1002", "회수일자");
    this.Text = "";
    setTimeout("EM_DRAWL_DT.Focus();", 50);
    return;
}
if(EM_VEN_CD.Text == "" || EM_VEN_NM.Text == ""){
    showMessage(EXCLAMATION, OK, "USER-1002", "가맹점");
    this.Text = "";
    setTimeout("EM_VEN_CD.Focus();", 50);
    return;
}

// 기존 판매내역 확인
 for(var j=1;j<=DS_IO_DETAIL.CountRow;j++){
     if(this.Text == DS_IO_DETAIL.NameValue(j, "GIFTCARD_NO")){
         showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
         this.Text = "";
         setTimeout(this.id+".Focus()", 50);
         return false;
     }
 }
 
 getGiftNoInfo();
return true;
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
</script>
<script language="javascript"  for=GD_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
        DS_IO_DETAIL.NameValue(i,"FLAG") = strFlag;
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
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>   
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<object id="TR_DTL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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
            <th width="100" class="point">점</th>
            <td width="120">
                   <comment id="_NSID_">
                   <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=118 tabindex=1 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
            <th width="100" class="point">일자</th>
            <td>
                <comment id="_NSID_">
                  <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=80 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" />
                    ~
                    <comment id="_NSID_">
                    <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=80 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
            </td>
          </tr> 
          <tr>
           <th width="100">가맹점</th>
              <td colspan=3>
                 <comment id="_NSID_"><object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle">
                </object></comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascript:getVenCd(LC_STR, EM_S_VEN_CD, EM_S_VEN_NM);" align="absmiddle" />
                 <comment id="_NSID_"><object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1 align="absmiddle">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr>
  <tr>
  <td>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr valign=top>
        <td width=250 class="PR05">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
              <td>
                  <comment id="_NSID_"><OBJECT id=GD_MASTER width=280 height=775 classid=<%=Util.CLSID_GRID%>>
                      <param name="DataID" value="DS_IO_MASTER">
                  </OBJECT></comment><script>_ws_(_NSID_);</script>
              </td>  
               </tr>
              </table> 
        </td>
        <td>
             <table width="100%" border="0" cellpadding="0" cellspacing="0">
               <tr>
                <td class="PB05">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="70" class="point">회수점</th>
                        <td width="110">
                            <comment id="_NSID_">
			                   <object id=LC_DRAWL_STR name=CONTENTS classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=108 tabindex=1 align="absmiddle">
			                   </object>
			               </comment><script>_ws_(_NSID_);</script> 
                        </td>
                         <th width="70" class="point">회수일자</th>
                        <td width="110">
                           <comment id="_NSID_"><object id=EM_DRAWL_DT name=CONTENTS classid=<%=Util.CLSID_EMEDIT%>   width=82 tabindex=1 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_CAL onclick="javascript:openCal('G',EM_DRAWL_DT)" align="absmiddle" />
                        </td>
                         <th width="70" class="point">순번</th>
                        <td>
                           <comment id="_NSID_"><object id=EM_DRAWL_SLIP_NO classid=<%=Util.CLSID_EMEDIT%>   width=50 tabindex=1 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                      <tr>
                        <th width="70" class="point">가맹점</th>
                        <td colspan=5>
                           <comment id="_NSID_"><object id=EM_VEN_CD name=CONTENTS classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_VEN onclick="javascript:getVenCd(LC_DRAWL_STR,EM_VEN_CD,EM_VEN_NM);" align="absmiddle" />
                           <comment id="_NSID_"><object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
                </tr>
               </table>
            </td>
          </tr>
            <tr>
		        <td class="PB05">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		        <tr>
		            <td>
		           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
		            <tr>
		                <th width="70">상품권 코드</th>
		                <td>
		                   <comment id="_NSID_"><object id=EM_GIFT_NO name=CONTENTS classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
		                  </object></comment><script>_ws_(_NSID_);</script>
		                </td>
		            </tr>
		        </table>
		        </td>
		        <td class="right">
		         <img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL width="52" height="18" onClick="javascript:delRow();"/>
		        </tr>
		       </table>
		    </td>
		  </tr>
		  <tr><td class="dot"></td></tr>
		    <tr>
		    <td class="PT01 PB03">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
		      <tr>
		      <td>
		          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=680 classid=<%=Util.CLSID_GRID%>>
		              <param name="DataID" value="DS_IO_DETAIL">
		          </OBJECT></comment><script>_ws_(_NSID_);</script>
		      </td>  
		       </tr>
		      </table> 
		    </td>
		    </tr>
            </table>
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
<comment id="_NSID_">
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=DRAWL_STR           ctrl=LC_DRAWL_STR            param=BindColVal</c>
        <c>col=DRAWL_DT            ctrl=EM_DRAWL_DT             param=Text</c>
        <c>col=DRAWL_SLIP_NO       ctrl=EM_DRAWL_SLIP_NO        param=Text</c>
        <c>col=VEN_CD              ctrl=EM_VEN_CD               param=Text</c>
        <c>col=VEN_NM              ctrl=EM_VEN_NM               param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

