<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품입고/반품 > 물품입고/반품등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE3010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
 *        2011.01.24 (김성미) 프로그램 작성
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strCurRow = 1;
var strGSlipNo = "";
var strSaveFlag = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 135;		//해당화면의 동적그리드top위치
 var top2 = 305;		//해당화면의 동적그리드top위치
function doInit(){

	 	
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	 
    // Input Data Set Header 초기화
       
    // Output Data Set Header 초기화
       DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
       DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
       DS_O_VEN_CD.setDataHeader('CODE:STRING(6),NAME:STRING(40)');
    
    //그리드 초기화
     gridCreate1(); // 전표 마스터
     gridCreate2(); // 전표 상세
    
    // EMedit에 초기화
    
    initEmEdit(EM_S_S_DT, "SYYYYMMDD", PK);                 // 조회 시작기간    
    initEmEdit(EM_S_E_DT, "TODAY", PK);                 // 조회 종료기간
    initEmEdit(EM_S_VEN_CD, "NUMBER3^6", NORMAL);             // 조회용 협력사 코드
    initEmEdit(EM_S_VEN_NM, "GEN", READ);             // 조회용 협력사 코드 명
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11", NORMAL);           // 조회용 행사  코드
    initEmEdit(EM_S_EVENT_NM, "GEN", READ);           // 조회용 행사 코드 명
    
    initEmEdit(EM_IN_DT, "TODAY", PK);                  // 입고/반품 일자
    initEmEdit(EM_EVENT_S_DT, "YYYYMMDD", READ);        // 행사 시작일    
    initEmEdit(EM_EVENT_E_DT, "YYYYMMDD", READ);        // 행사 종료일
    initEmEdit(EM_EVENT_CD, "NUMBER3^11", PK);                 // 행사  코드
    initEmEdit(EM_EVENT_NM, "GEN", READ);                 // 행사 코드 명
    initEmEdit(EM_TOT_QTY, "NUMBER^9^0", READ);         // 총수량
    initEmEdit(EM_TOT_AMT, "NUMBER^12^0", READ);        // 총금액
  
    //콤보 초기화
    initComboStyle(LC_S_STR,DS_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                    // 조회용 점코드     
    initComboStyle(LC_S_BUY_FLAG,DS_S_BUY_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);      // 조회용 입고/반품 구분
    
    initComboStyle(LC_STR,DS_STR, "CODE^0^30,NAME^0^80", 1, PK);                            // 등록용 점코드
    initComboStyle(LC_BUY_FLAG,DS_BUY_FLAG, "CODE^0^30,NAME^0^80", 1, PK);          // 등록용 입고/반품 구분
    initComboStyle(LC_VEN,DS_O_VEN_CD, "CODE^0^60,NAME^0^120", 1, PK);                // 등록용 협력사 코드
    
   
   //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_S_BUY_FLAG",   "D", "M094", "Y" ,"N");
    getEtcCode("DS_BUY_FLAG",   "D", "M094", "N", "N");

    getStore("DS_S_STR", "Y", "1", "N");
    getStore("DS_STR", "Y", "1", "N");
   
    //협력사 콤보용 데이터셋 조회
    getComboCd("DS_O_ALL_VEN", '',"SEL_VEN_ALL", '');
    registerUsingDataset("mcae301","DS_MASTER,DS_DETAIL" );
    
    // 처음 로딩시 전표마스터 내용 등록 불가
    setObject(false);
    
    //초기화값 셋팅
    LC_S_BUY_FLAG.Index = 0;
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=STR_CD      name="점"           width=60   align=left EditStyle=Lookup   Data="DS_STR:CODE:NAME"</FC>'
			        + '<FC>id=FULL_SLIP_NO   name="전표번호"       width=100  align=left</FC>'
                    + '<FC>id=BUY_FLAG    name="입/반구분"       width=60  align=left EditStyle=Lookup   Data="DS_BUY_FLAG:CODE:NAME"</FC>'
                    + '<FC>id=VEN_CD    name="협력사"      show=false width=90  align=left EditStyle=Lookup   Data="DS_O_VEN_CD:CODE:NAME"</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center edit="none"</FC>'
			        + '<FC>id=PUMBUN_CD   name="브랜드"     width=80   align=center edit="none"</FC>'
			        + '<FC>id=SKU_CD      name="사은품코드"       width=140  align=center edit="none"</FC>'
			        + '<FC>id=SKU_NAME    name="사은품명"     width=100   align=left edit="none"</FC>'
                    + '<FC>id=BUY_COST_PRC      name="매입원가"   width=60   align=right edit="none"</FC>'
                    + '<FC>id=QTY         name="수량"       width=40  align=right Edit="Numeric"</FC>'
                    + '<FC>id=AMT    name="금액"     width=90   align=right edit="none"</FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
* 작 성 일 : 2011-01-24
* 개    요 : 조회시 호출  
*         물품 입고/반품 내역 조회
* return값 : void
*/
function btn_Search() {
    
    if(LC_S_STR.BindColVal == ""){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        return;
    }
    if(EM_S_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_S_DT.Focus();
        return;
    }else if(EM_S_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_E_DT.Focus();
        return;
    }else if(EM_S_S_DT.Text > EM_S_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_S_DT.Focus();
        return;
    }
    
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_MASTER.NameValue(DS_MASTER.CountRow, "SLIP_NO") == "" && !strSaveFlag){
          if(showMessage(QUESTION , YESNO, "GAUCE-1000", "전표 마스터가 저장되지 않았습니다. <br> 조회하시겠습니까?") != 1 ){
              return;
          }else{
              DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
              }
    }
   getMaster();
}

/**
* btn_New()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-24
* 개    요 : Grid 레코드 추가\
*         전표 마스터 리스트에 레코드 추가 
* return값 : void
*/
function btn_New() {
    
    if(DS_MASTER.CountRow == 0){
        DS_MASTER.Addrow();
        setObject(true); 
        return;
    }
    
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
   if(DS_MASTER.NameValue(DS_MASTER.CountRow, "SLIP_NO") == ""){
         if(showMessage(QUESTION , YESNO, "GAUCE-1000", "전표 마스터가 저장되지 않았습니다. <br> 새로 등록하시겠습니까?") != 1 ){
             return;
         }else{
             DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
             }
   }
          
    DS_MASTER.Addrow();
    DS_DETAIL.ClearData();
    DS_O_VEN_CD.ClearData();
    DS_O_PUMBUN_CD.ClearData();
    initComboStyle(LC_VEN,DS_O_VEN_CD, "CODE^0^60,NAME^0^120", 1, PK);                // 등록용 협력사 코드
    setObject(true);
    
    LC_VEN.Enable = false;
}

/**
* btn_Delete()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-24
* 개    요 : 데이터 삭제
* return값 : void
*/
function btn_Delete() {
}

/**
* btn_Save()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-24
* 개    요 : DB에 저장 / 수정 / 삭제 처리
* return값 : void
*/
function btn_Save() {
   // 저장할 데이터 없는 경우
   if (!DS_DETAIL.IsUpdated && !DS_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION , OK, "USER-1028");
       return;
   }
   
   if(LC_STR.BindColVal == ""){  // 점코드
       showMessage(EXCLAMATION , OK, "USER-1002", "점");
       LC_STR.Focus();
       return;
   }
   if(EM_IN_DT.Text.length == 0){  // 입고/반품일자
       showMessage(EXCLAMATION , OK, "USER-1002", "입고/반품일자");
       EM_IN_DT.Focus();
       return;
   }
   if(EM_EVENT_CD.Text.length == 0){  // 행사코드
       showMessage(EXCLAMATION , OK, "USER-1002", "행사코드");
       EM_EVENT_CD.Focus();
       return;
   }   
   if(LC_VEN.Text.length == 0){  // 협력사
       showMessage(EXCLAMATION , OK, "USER-1002", "협력사");
       LC_VEN.Focus();
       return;
   } 
   //if(!checkDSBlank(GD_DETAIL, "1,2")) return;
   
   if(DS_DETAIL.CountRow == 0){
	     //저장할 내용이 없습니다
	       showMessage(EXCLAMATION , OK, "USER-1028");
	       return;
	   }
   
   if(EM_TOT_QTY.Text == 0){
	   showMessage(EXCLAMATION , OK, "USER-1003", "수량"); 
       setFocusGrid(GD_DETAIL, DS_DETAIL, 1, "QTY");
       return;
   }
   
   if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
   
   strSaveFlag = true;
   
   TR_S_MAIN.Action="/mss/mcae301.mc?goTo=save&strFlag=save"; 
   TR_S_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER,I:DS_DETAIL=DS_DETAIL)"; //조회는 O
   TR_S_MAIN.Post();
   
   strCurRow = DS_MASTER.RowPosition;
   
   btn_Search();
   strSaveFlag = false;
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
* setObject(flag)
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-26
* 개    요 :  전표마스터 내용 수정 가능여부 셋팅 (수정 가능시 Default 셋팅)
* return값 : void
*/
function setObject(flag){
   LC_STR.Enable = flag;    
   EM_IN_DT.Enable = flag; 
   LC_BUY_FLAG.Enable = flag;    
   EM_EVENT_CD.Enable = flag;    
   LC_VEN.Enable = flag;   
   enableControl(IMG_IN_DT, flag);
   enableControl(IMG_EVENT, flag);
   if(flag){
       LC_STR.Index = 0;
       LC_BUY_FLAG.Index = 0;
       EM_IN_DT.Text = getTodayFormat("yyyymmdd");
       LC_STR.Focus();
   }   
}

function showRegMessage(strMsg, obj){
   showMessage(EXCLAMATION , OK, "USER-1000", strMsg);
   obj.Focus();
}



/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* getMaster()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-26
* 개    요 :  마스터 리스트 조회
* return값 : void
*/
function getMaster(){
	DS_MASTER.ClearData();
	DS_DETAIL.ClearData();
	// 조회조건 셋팅
   var strStrCd    = LC_S_STR.BindColVal;
   var strSdt      = EM_S_S_DT.Text;
   var strEdt      = EM_S_E_DT.Text;
   var strVenCd    = EM_S_VEN_CD.Text;
   var strBuyFlg   = LC_S_BUY_FLAG.BindColVal;
   var strEvtCd    = EM_S_EVENT_CD.Text;
  
   var goTo       = "getMaster" ;    
   var action     = "O";     
   var parameters = "&strStrCd="  +encodeURIComponent(strStrCd)
                  + "&strSdt="    +encodeURIComponent(strSdt)
                  + "&strEdt="    +encodeURIComponent(strEdt)
                  + "&strVenCd="  +encodeURIComponent(strVenCd)
                  + "&strBuyFlg=" +encodeURIComponent(strBuyFlg)
                  + "&strEvtCd="  +encodeURIComponent(strEvtCd);
   TR_S_MAIN.Action="/mss/mcae301.mc?goTo="+goTo+parameters;  
   TR_S_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
   TR_S_MAIN.Post();
   
   // 저장전 Row 셋팅
   if(strCurRow > 1){
	   DS_MASTER.RowPosition = strCurRow;
   }
   if(DS_MASTER.CountRow > 0){
	   getDetail();
   }
  setObject(false);
//조회결과 Return
  setPorcCount("SELECT", DS_MASTER.CountRow);
  
  GD_MASTER.Focus();
}

/**
* getDetail()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-26
* 개    요 :  디테일 리스트 조회
* return값 : void
*/
function getDetail(){

   var strIndt      = DS_MASTER.NameValue(DS_MASTER.RowPosition,"IN_DT");
   var strSlipNo    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");
   var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
   var strEventCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");
   var strVenCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD");
   var strBuyFlag   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"BUY_FLAG");
   
   var goTo       = "getDetail" ;    
   var action     = "O";     
   var parameters = "&strIndt="   + encodeURIComponent(strIndt)
                  + "&strSlipNo=" + encodeURIComponent(strSlipNo)
                  + "&strStrCd="  + encodeURIComponent(strStrCd)
                  + "&strEventCd="+ encodeURIComponent(strEventCd)
                  + "&strVenCd="  + encodeURIComponent(strVenCd)
                  + "&strBuyFlag="+ encodeURIComponent(strBuyFlag);
   
   TR_S_MAIN.Action="/mss/mcae301.mc?goTo="+goTo+parameters;  
   TR_S_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
   TR_S_MAIN.Post();

   if(DS_MASTER.CountRow > 0 && strSlipNo == "") {
	   for(var i=1;i<=DS_DETAIL.CountRow;i++){
		   DS_DETAIL.UserStatus(i) = 1;  
	   }
	   
	   setFocusGrid(GD_DETAIL, DS_DETAIL,1, "QTY");
   }
}

/**
* setEventInfo()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-26
* 개    요 :  이벤트 팝업 등록후에 협력사 콤보 셋팅
* return값 : void
*/
function setEventInfo(){
   // 이벤트 팝업 등록후에 협력사 콤보 셋팅
   if(LC_STR.Text.length < 0 ) return;
   
   if(LC_STR.BindColVal == ""){  // 점코드
       showMessage(EXCLAMATION, OK, "USER-1001", "점");
       LC_STR.Focus();
       return;
   }
   mssEventMstPop('SEL_STR_EVENT_POP',EM_EVENT_CD,EM_EVENT_NM,LC_STR.BindColVal, '4/5/6','05', EM_IN_DT.Text , EM_IN_DT.Text);
   
   if(EM_EVENT_CD.Text.length == 11){
       getComboCd("DS_O_VEN_CD", EM_EVENT_CD.Text,"SEL_VEN_BY_EVENT",LC_STR.BindColVal);
       
       LC_VEN.Enable = true;
       LC_VEN.Index = 0;
   }
}

/**
* getSEvent()
* 작 성 자 : 김성미
* 작 성 일 : 2011-01-26
* 개    요 :  조회용 이벤트 팝업
* return값 : void
*/
function getSEvent(){
   
   // 조회 이벤트 조건 검색시 점코드 필수 
   if(LC_S_STR.BindColVal.length == 0){
       showMessage(EXCLAMATION, OK, "USER-1001", "점");
       return;
   }
   mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR.BindColVal, '4/5/6','05', EM_S_S_DT.Text, EM_S_E_DT.Text);
}

/**
* setVenCombo()
* 작 성 자 : 김성미
* 작 성 일 : 2011-03-04
* 개    요 :  협력사 콤보용 데이터셋 조회
* return값 : void
*/
function setVenCombo(){
	var strVenCombo = DS_O_ALL_VEN.ExportData(1, DS_O_ALL_VEN.CountRow, true);
	DS_O_VEN_CD.ImportData(strVenCombo);
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
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);

</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--  ===================DS_MASTER============================ -->
<!-- Grid DS_MASTER 변경시 DS_DETAIL의 마스터 내용 변경 -->
<script language=JavaScript for=DS_MASTER
	event=OnColumnChanged(row,colid)>
 if(colid == "EVENT_CD"){
	 if(DS_MASTER.NameValue(row, "SLIP_NO").length > 0){
	     EM_IN_DT.Enable = false;
	     getDetail();
	  // 조회결과 Return
         setPorcCount("SELECT", DS_DETAIL.CountRow);
	     initComboStyle(LC_VEN,DS_O_ALL_VEN, "CODE^0^60,NAME^0^120", 1, PK);                // 등록용 협력사 코드
	 }else{
	     DS_DETAIL.ClearData();
	     DS_O_VEN_CD.ClearData();
	     initComboStyle(LC_VEN,DS_O_VEN_CD, "CODE^0^60,NAME^0^120", 1, PK);                // 등록용 협력사 코드
	     getComboCd("DS_O_VEN_CD", EM_EVENT_CD.Text,"SEL_VEN_BY_EVENT", LC_STR.BindColVal);
	 } 
 }
</script>
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
if(clickSORT)
    return true;
if(row ==0) return;
if((DS_MASTER.IsUpdated || DS_DETAIL.IsUpdated) && !strSaveFlag){
	 if(showMessage(QUESTION, YESNO, "GAUCE-1000", "전표 마스터가 저장되지 않았습니다. <br> 이동하시겠습니까?") == 1 ){
		 if(DS_MASTER.NameValue(row,"FULL_SLIP_NO") == "") DS_MASTER.DeleteRow(row);
		 DS_MASTER.NameValue(row,"TOT_QTY") = DS_MASTER.OrgNameValue(row,"TOT_QTY");
         DS_MASTER.NameValue(row,"TOT_AMT") = DS_MASTER.OrgNameValue(row,"TOT_AMT")
		 return true;
     }else{
    	 return false;
     }
}
return true;
</script>

<script language=JavaScript for=DS_DETAIL
	event=OnColumnChanged(row,colid)>
 var strQty = parseInt(DS_DETAIL.NameValue(row, "QTY"));
 var strBuyCostPrc = parseInt(DS_DETAIL.NameValue(row, "BUY_COST_PRC"));
 
 DS_DETAIL.NameValue(row, "AMT") = strQty * strBuyCostPrc;
 
 EM_TOT_QTY.Text = DS_DETAIL.NameSum("QTY",0,0);
 EM_TOT_AMT.Text = DS_DETAIL.NameSum("AMT",0,0);
 setObject(false); 
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
//alert(clickSORT);
// if(clickSORT)
 //    return;
</script>
<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<!--  ===================DS_MASTER============================ -->

<!--  ===================GD_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
   if(row == 0) sortColId( eval(this.DataID), row, colid);
   var strVen = DS_MASTER.NameValue(row,"VEN_CD");
   if(DS_MASTER.IsUpdated) return;
   // 조회, 신규 여부에 따라 입고/반품일자 비활성 설정
   if(DS_MASTER.NameValue(row, "SLIP_NO").length > 0){
        EM_IN_DT.Enable = false;
        getDetail();
     // 조회결과 Return
        setPorcCount("SELECT", DS_DETAIL.CountRow);
        initComboStyle(LC_VEN,DS_O_ALL_VEN, "CODE^0^60,NAME^0^120", 1, PK);                // 등록용 협력사 코드
        setObject(false); 
    }else{
    	if(DS_O_VEN_CD.CountRow == 0)getComboCd("DS_O_VEN_CD", EM_EVENT_CD.Text,"SEL_VEN_BY_EVENT", LC_STR.BindColVal);
        DS_DETAIL.ClearData();
        initComboStyle(LC_VEN,DS_O_VEN_CD, "CODE^0^60,NAME^0^120", 1, PK);                // 등록용 협력사 코드
        setObject(true); 
    }
   DS_MASTER.NameValue(row,"VEN_CD") = strVen;  
</script>

<!-- Grid master 상하키 event 처리 -->
<script language=JavaScript for=GD_MASTER event=onKeyPress(keycode)>
    if ((keycode == 38) || (keycode == 40)){
            getDetail();
            // 조회결과 Return
            setPorcCount("SELECT", DS_DETAIL.CountRow);
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
   if(row == 0) sortColId( eval(this.DataID), row, colid);
   </script>
<!--  ===================GD_MASTER============================ -->
<!--  ===================GD_DETAIL============================ -->
<!--  ===================GD_DETAIL============================ -->
<!--  ===================SEARCH CONDITION AREA================= -->
<!-- 협력사명 한건 조회 -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_S_VEN_CD.Text ==""){
	EM_S_VEN_NM.Text = "";
       return;
   }
getEvtVenNonPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E" , "Y" , LC_S_STR.BindColVal,  '02')
</script>

<!-- 조회용 행사코드명 한건 조회 -->
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_S_EVENT_CD.Text ==""){
	EM_S_EVENT_NM.Text = "";
       return;
   }
if(EM_S_EVENT_CD.text!=null){
    if(EM_S_EVENT_CD.text.length > 0){
        // 조회 이벤트 조건 검색시 점코드 필수 
        if(LC_S_STR.BindColVal.length == 0){
            showMessage(EXCLAMATION , OK, "USER-1001", "점");
            return;
        }
     //   var ret = setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM, '', '', "N", LC_S_STR.BindColVal);
       var ret = setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM, LC_S_STR.BindColVal, '4/5/6', "05");
        // 조회내용이 없거나 1개 이상이면 팝업 호출
        if(ret.CountRow == 1){
            EM_S_EVENT_CD.Text = ret.NameValue(ret.RowPosition, "EVENT_CD");
            EM_S_EVENT_NM.Text = ret.NameValue(ret.RowPosition, "EVENT_NM");
        }else{
            mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR.BindColVal, '4/5/6','05', EM_S_S_DT.Text, EM_S_E_DT.Text);
        }
    }
}
</script>
<!--  ===================SEARCH CONDITION AREA================= -->

<!--  ===================INPUT AREA============================ -->
<!-- 등록용 행사코드명 한건 조회 -->
<script language=JavaScript for=EM_EVENT_CD event=onKillFocus()>
if( EM_EVENT_CD.Text =="") LC_VEN.Enable = false;
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if( EM_EVENT_CD.Text ==""){
		EM_EVENT_NM.Text = ""; 
		EM_EVENT_S_DT.Text = ""; 
		EM_EVENT_E_DT.Text = "";
		//협력사 콤보 클리어
		DS_O_VEN_CD.ClearData();
		LC_VEN.Enable = false;
	       return;
	   }
    if(EM_EVENT_CD.text!=null){
        if(EM_EVENT_CD.text.length > 0){
            var ret = setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_EVENT_CD, EM_EVENT_NM, EM_EVENT_S_DT, EM_EVENT_E_DT, "Y", LC_STR.BindColVal);
          //협력사 콤보 클리어
            DS_O_VEN_CD.ClearData();
          
            // 조회내용이 없거나 1개 이상이면 팝업 호출
            if(DS_O_RESULT.CountRow == 1){
                EM_EVENT_NM.Text = ret.NameValue(ret.RowPosition, "EVENT_NM");
            }else{
            	mssEventMstPop('SEL_STR_EVENT_POP',EM_EVENT_CD,EM_EVENT_NM,LC_STR.BindColVal, '4/5/6','05', EM_IN_DT.Text , EM_IN_DT.Text);
            	   
            }
            // 행사 조회시 관련 협력사 콤보 셋팅
            if(EM_EVENT_CD.Text.length > 0){
                getComboCd("DS_O_VEN_CD", EM_EVENT_CD.Text,"SEL_VEN_BY_EVENT", LC_STR.BindColVal);
            }
        }
        
        if( EM_EVENT_CD.Text =="") LC_VEN.Enable = false;
    }
</script>

<!-- 협력사 변경시 브랜드코드 데이터셋 조회 -->
<script language=JavaScript for=LC_VEN event=OnSelChange()>
     if(DS_MASTER.NameValue(DS_MASTER.RowPosition, "SLIP_NO").length == 0){
    	 getDetail();
    	// 조회결과 Return
         setPorcCount("SELECT", DS_DETAIL.CountRow);
    }
</script>

<!-- 점 변경시 초기화 -->
<script language=JavaScript for=LC_STR event=OnSelChange()>
    if(DS_MASTER.NameValue(DS_MASTER.RowPosition, "SLIP_NO") == ""){
    	DS_MASTER.NameValue(DS_MASTER.RowPosition, "EVENT_CD") = "";
    	DS_MASTER.NameValue(DS_MASTER.RowPosition, "EVENT_NM") = "";
    	DS_O_VEN_CD.ClearData();
    	DS_DETAIL.ClearData();
    }
</script>
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
EM_S_VEN_CD.Text = "";
EM_S_VEN_NM.Text = "";
EM_S_EVENT_CD.Text = "";
EM_S_EVENT_NM.Text = "";
</script>
<!--  ===================INPUT AREA============================ -->


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
<object id="DS_PUMBUN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_S_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_S_BUY_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_BUY_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_VEN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ALL_VEN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
<body onLoad="doInit();" class="PL10 PT15 ">

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
						<th width="80" class="point">점</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=140 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">기간</th>
						<td align="absmiddle"><comment id="_NSID_">
						<object id=EM_S_S_DT classid=<%=Util.CLSID_EMEDIT%> width=110
							onblur="javascript:checkDateTypeYMD(this);" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_S_DT)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1
							onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_E_DT)" /></td>
					</tr>
					<tr>
					<th width="80">입고반품구분</th>
                        <td width=140><comment id="_NSID_"> <object id=LC_S_BUY_FLAG
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
						<th>협력사</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1
							align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							align="absmiddle"
							onclick="javascript:getEvtVenPop( EM_S_VEN_CD, EM_S_VEN_NM, 'S', LC_S_STR.BindColVal, '02');" />
						<comment id="_NSID_"> <object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
                        <th>행사코드</th>
                        <td colspan=3><comment id="_NSID_"> <object
                            id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=140
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:getSEvent();" align="absmiddle" /> <comment
                            id="_NSID_"> <object id=EM_S_EVENT_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=180 tabindex=1
                            align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="270">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_MASTER
									width=300 height=750 classid=<%=Util.CLSID_GRID%> tabindex=1>
									<param name="DataID" value="DS_MASTER">
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT01 PB03">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="5"></td>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="sub_title"><img
											src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11"
											height="12" align="absmiddle" class="PR03" /> 입고/반품마스터</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td width="5"></td>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="80" class="point">점</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=160 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="80" class="point">입고/반품일자</th>
										<td width="160"><comment id="_NSID_"> <object
											id=EM_IN_DT classid=<%=Util.CLSID_EMEDIT%> width=135
											onblur="javascript:checkDateTypeYMD(this);" tabindex=1
											align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
										<img id=IMG_IN_DT src="/<%=dir%>/imgs/btn/date.gif"
											align="absmiddle" onclick="javascript:openCal('G',EM_IN_DT)" /></td>
										<th width="90" class="point">입고반품구분</th>
										<td><comment id="_NSID_"> <object
											id=LC_BUY_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=140 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="90" class="point">행사코드</th>
										<td colspan=3><comment id="_NSID_"> <object
											id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=135
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										<img id=IMG_EVENT src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											class="PR03" onclick="javascript:setEventInfo()"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_EVENT_NM classid=<%=Util.CLSID_EMEDIT%> width=250
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="90" class="point">행사기간</th>
										<td width="160" align="absmiddle"><comment id="_NSID_">
										<object id=EM_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%>
											width=70 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										~ <comment id="_NSID_"> <object id=EM_EVENT_E_DT
											classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th width="90" class="point">협력사</th>
										<td><comment id="_NSID_"> <object id=LC_VEN
											classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140
											align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="90">총수량</th>
										<td width="160"><comment id="_NSID_"> <object
											id=EM_TOT_QTY classid=<%=Util.CLSID_EMEDIT%> width=155
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<th width="90">총금액</th>
										<td><comment id="_NSID_"> <object id=EM_TOT_AMT
											classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="PL05">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="PT10">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="sub_title"><img
											src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"
											class="PR03" /> 입고/반품 상세</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
											width=100% height=580 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_DETAIL">
										</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=STR_CD          Ctrl=LC_STR          param=BindColVal</c>
        <c>Col=IN_DT           Ctrl=EM_IN_DT        param=Text</c>
        <c>Col=BUY_FLAG        Ctrl=LC_BUY_FLAG     param=BindColVal</c>
        <c>Col=EVENT_CD        Ctrl=EM_EVENT_CD     param=Text</c>
        <c>Col=EVENT_NM        Ctrl=EM_EVENT_NM     param=Text</c>
        <c>Col=EVENT_S_DT      Ctrl=EM_EVENT_S_DT   param=Text</c>
        <c>Col=EVENT_E_DT      Ctrl=EM_EVENT_E_DT   param=Text</c>
        <c>Col=VEN_CD          Ctrl=LC_VEN          param=BindColVal</c>
        <c>Col=TOT_QTY         Ctrl=EM_TOT_QTY      param=Text</c>
        <c>Col=TOT_AMT         Ctrl=EM_TOT_AMT      param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

