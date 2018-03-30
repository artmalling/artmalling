<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 정산관리> 자사위탁판매 입금등록
 * 작 성 일 : 2011.06.09
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif6050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.06.09 (김성미) 프로그램작성 
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
<script language="javascript"  src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strCurRow = 0;
var strToday;
var btnSearchClick = false;
var btnNewClick = false;
var flagModify = false;
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

function doInit(){

	 DS_O_VENPAY.setDataHeader('<gauce:dataset name="H_VENPAY"/>');
	  
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_CAL_YM, "THISMN", PK);    //조회 시작월
    initEmEdit(EM_E_CAL_YM, "THISMN", PK);    //조회 종료월
    initEmEdit(EM_S_VEN_CD, "NUMBER3^6", NORMAL);             //협력사코드
    initEmEdit(EM_S_VEN_NM, "GEN", READ);                     //협력사명
    
    /*initEmEdit(EM_PAY_DT, "TODAY", PK);    //입금일자
    initEmEdit(EM_VEN_CD, "NUMBER3^6", NORMAL);             //협력사코드
    initEmEdit(EM_VEN_NM, "GEN", READ);                     //협력사명
    initEmEdit(EM_PAY_AMT, "NUMBER^12^0", PK);             //입금액
    initEmEdit(EM_FEE_PAY_AMT, "NUMBER^12^0", PK);                     //수수료금액
    */
    //콤보 초기화
  initComboStyle(LC_S_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);    //본사점(조회)
  //initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);    //본사점(등록)
  
  getStore("DS_O_S_STR", "N", "", "N");
  getStore("DS_O_STR", "N", "", "N");
  strToday = getTodayDB("DS_O_RESULT");
 // setObject("1");
  LC_S_STR.Index = 0;
  LC_S_STR.Focus();
}


function gridCreate1(){
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
        + '<FC>id=STR_CD      name="점" sumtext="합계" width=80 edit={if(CLOSE_FLAG = "TRUE", "false", if(SysStatus <> "I", "false", "true"))} align=left EditStyle=Lookup Data="DS_O_STR:CODE:NAME"</FC>'
        + '<FC>id=PAY_DT    name="입금일자" edit={if(CLOSE_FLAG = "TRUE", "false", if(SysStatus <> "I", "false", "true"))} width=80 mask="XXXX/XX/XX" EditLimit=8 edit=numeric EditStyle=Popup align=center</FC>'
        + '<FC>id=SEQ_NO      name="입금순번"  width=60 edit=none  align=center</FC>'
        + '<FC>id=VEN_CD    name="협력사코드"  edit={if(CLOSE_FLAG = "TRUE", "false", if(SysStatus <> "I", "false", "true"))}   width=80  align=left EditStyle=Popup </FC>'
        + '<FC>id=VEN_NM    name="협력사명"       width=100 edit=none  align=left</FC>'
        + '<FC>id=TOT_PAY_AMT    name="입금금액" edit={if(CLOSE_FLAG = "TRUE", "false", "true")}  sumtext=@sum  width=100  align=right</FC>'
        + '<FC>id=FEE_RATE    name="수수료율"   edit=none width=80  align=right</FC>'
        + '<FC>id=PAY_AMT    name="실입금금액" edit={if(CLOSE_FLAG = "TRUE", "false", "true")} sumtext=@sum  width=100  align=right</FC>'
        + '<FC>id=FEE_PAY_AMT    name="수수료금액" edit={if(CLOSE_FLAG = "TRUE", "false", "true")} sumtext=@sum width=100   align=right</FC>'
        + '<FC>id=CLOSE_FLAG_NM    name="마감여부"  width=60 edit=none  align=left</FC>';
      
   initGridStyle(GD_VENPAY, "common", hdrProperies1, true);
   GD_VENPAY.ViewSummary = 1; 
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
 * 작 성 일 : 2011-06-02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if(DS_O_VENPAY.IsUpdated){
         if (showMessage(QUESTION , YESNO, "USER-1073") != 1) return;
     }
	 
	if(LC_S_STR.BindColVal == ""){  // 본사점
        showMessage(EXCLAMATION , OK, "USER-1001", "본사점");
        return;
    }
    
	if(EM_S_CAL_YM.Text.length < 6){   // 정산년월
        showMessage(EXCLAMATION , OK, "USER-1001","조회시작월");
        EM_S_CAL_YM.Focus();
        return;
    }
    
	if(EM_E_CAL_YM.Text.length < 6){   // 정산년월
        showMessage(EXCLAMATION , OK, "USER-1001","조회종류월");
        EM_E_CAL_YM.Focus();
        return;
    }
	
	if(!isBetweenFromTo(EM_S_CAL_YM.Text,EM_E_CAL_YM.Text)){   // 정산년월
        showMessage(EXCLAMATION , OK, "USER-1008","종료월", "시작월");
        EM_E_CAL_YM.Focus();
        return;
    }
	
   var parameters = "&strStrCd=" + encodeURIComponent(LC_S_STR.BindColVal)
                  + "&strCalSYm="+ encodeURIComponent(EM_S_CAL_YM.Text)
                  + "&strCalEYm="+ encodeURIComponent(EM_E_CAL_YM.Text)
                  + "&strVenCd=" + encodeURIComponent(EM_S_VEN_CD.Text);
   
   TR_MAIN.Action="/mss/mgif605.mg?goTo=getMaster"+parameters;  
   TR_MAIN.KeyValue="SERVLET(O:DS_O_VENPAY=DS_O_VENPAY)"; //조회는 O
   TR_MAIN.Post();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 if(DS_O_VENPAY.IsUpdated){
		 if (showMessage(QUESTION , YESNO, "USER-1050") != 1) return;
	 }
	 
	 DS_O_VENPAY.ClearData();
	 LC_S_STR.Index = 0;
     
    /*
     EM_PAY_DT.Text = strToday;
     EM_VEN_CD.Text = "";
     EM_VEN_NM.Text = "";
     EM_PAY_AMT.Text = "0";
     EM_FEE_PAY_AMT.Text = "0";
     HID_PAY_SEQ_NO.Value = "";
     flagModify = false;
     btnNewClick = true;
	setObject("2");*/
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
 * 작 성 일 : 2011-06-03
 * 개    요 : 자사상품권 정산내용 저장
 * return값 : void
 */
function btn_Save() {
	
	  if(!DS_O_VENPAY.IsUpdated){
		  showMessage(EXCLAMATION , OK, "USER-1028");
          return;
	  }
	   //변경된 로우에 필수 등록 및 마감여부를 체크한다.
	  var checkItem = "1,2,4";
	  var checkItemList = checkItem==null?"":checkItem.split(",");
	  for(var i=1; i <= DS_O_VENPAY.CountRow; i++ ) {
	    if( DS_O_VENPAY.RowStatus(i) == 0 
	            || DS_O_VENPAY.RowStatus(i) == 2
	            || DS_O_VENPAY.RowStatus(i) == 4) 
	        continue;
	    
	    for( var j = 0 ; j < GD_VENPAY.CountColumn ; j++){
	           for(var k=0; k<checkItemList.length; k++){
	        	   var colId = GD_VENPAY.GetColumnID(checkItemList[k]);
		           if(DS_O_VENPAY.NameValue(i,colId) == ""){
		               // ()은/는 반드시 입력해야 합니다.
		               showMessage(Information, OK, "USER-1003",GD_VENPAY.GetHdrDispName(-3, colId));
		               DS_O_VENPAY.RowPosition = i;
		               GD_VENPAY.SetColumn(colId); //name 컬럼 
		               GD_VENPAY.Focus(); //그리드에 포커스 
		               return false;
		           }
		        }
	        }  
	    
	    // 정산 마감체크 (common.js)
        if( getCloseCheck('DS_CLOSECHECK'
                          , DS_O_VENPAY.NameValue(i,"STR_CD")
                          , DS_O_VENPAY.NameValue(i,"PAY_DT")
                          ,'MGIF','47','0','M') == 'TRUE'){
            showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
            GD_VENPAY.SetColumn("PAY_DT"); //name 컬럼 
            GD_VENPAY.Focus(); //그리드에 포커스 
            return;
        }else{
        	DS_O_VENPAY.NameValue(i, "CLOSE_FLAG") = "FALSE";
            DS_O_VENPAY.NameValue(i, "CLOSE_FLAG_NM") = "마감전";
		}
	  }    
	
	   if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
	  
	   TR_MAIN.Action="/mss/mgif605.mg?goTo=save"; 
	   TR_MAIN.KeyValue="SERVLET(I:DS_O_VENPAY=DS_O_VENPAY)"; 
	   TR_MAIN.Post();
	   
	   strCurRow = DS_O_VENPAY.RowPosition;
	   
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
 * 작 성 일 : 2011-06-03
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * getVenFee()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-06-02
  * 개    요 : 협력사 등록시 수수료율 조회
  * return값 : void
  */
 function getVenFee(){
    var parameters = "&strStrCd="+ encodeURIComponent(DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "STR_CD"))
                   + "&strPayDt="+ encodeURIComponent(DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "PAY_DT"))
                   + "&strVenCd="+ encodeURIComponent(DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "VEN_CD"));
    
    TR_MAIN.Action="/mss/mgif605.mg?goTo=getVenFee"+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_VENFEE=DS_O_VENFEE)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_O_VENFEE.CountRow ==0){
    	setVenFee();
        return;
    }
    setVenFee();
    DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "FEE_RATE") = DS_O_VENFEE.NameValue(1, "FEE_RATE");
    getCalculate("FEE_RATE");
    
 /*   GD_VENPAY.ColumnProp("STR_CD","Edit")="None";
    GD_VENPAY.ColumnProp("PAY_DT","Edit")="None";
    GD_VENPAY.ColumnProp("VEN_CD","Edit")="None"; */
 }
 /**
  * addRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-24
  * 개    요 : 행추가
  * return값 : void
  */

 function addRow(){
    var row = DS_O_VENPAY.CountRow; 
    // 점코드
    if(DS_O_VENPAY.NameValue(row, "STR_CD") == ""){
         showMessage(EXCLAMATION , OK, "USER-1003" , "점");
         setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "STR_CD");
         return;
    }
    // 입금일자
    if(DS_O_VENPAY.NameValue(row, "PAY_DT") == ""){
        showMessage(EXCLAMATION , OK, "USER-1003" , "입금일자");
        setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "PAY_DT");
        return;
    }
    // 협력사코드
    if(DS_O_VENPAY.NameValue(row, "VEN_CD") == ""){
        showMessage(EXCLAMATION , OK, "USER-1003" , "협력사");
        setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "VEN_CD");
        return;
    }
    
    // 필수 입력사항 체크후 마감여부 체크 
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_O_VENPAY.NameValue(row, "STR_CD")
                      , DS_O_VENPAY.NameValue(row, "PAY_DT")
                      ,'MGIF','47','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "PAY_DT");
        return;
    }else{
    	DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") = "FALSE";
        DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") = "마감전";
    }
  
    DS_O_VENPAY.AddRow(); 
   /* GD_VENPAY.ColumnProp("STR_CD","Edit")="";
    GD_VENPAY.ColumnProp("PAY_DT","Edit")="";
    GD_VENPAY.ColumnProp("VEN_CD","Edit")="";*/
    setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "STR_CD");
 }

 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-24
  * 개    요 : 행삭제
  * return값 : void
  */

 function delRow() {
     if(DS_O_VENPAY.CountRow == 0){
         showMessage(EXCLAMATION , OK, "USER-1019");
            return;
        }
     // 마감 된경우 삭제 불가
     if(DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "CLOSE_FLAG") == "TRUE"){
         showMessage(EXCLAMATION , OK, "USER-1150" , "", "삭제");
         return;
    }
     // 정산처리가 된경우에 메세지 처리
     if((DS_O_VENPAY.RowStatus(DS_O_VENPAY.RowPosition) == 0 || DS_O_VENPAY.RowStatus(DS_O_VENPAY.RowPosition) == 3)
    		 && DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "CAL_FLAG") > 0){
    	 if(showMessage(QUESTION, YESNO, "USER-1000", "정산등록이 된 입금내역입니다.\n 삭제후 재정산 작업을 실행하셔야 합니다. \n 삭제하시겠습니까?") != 1 ) return false;
    }
     DS_O_VENPAY.DeleteRow(DS_O_VENPAY.RowPosition);
 }
 
 function setVenFee(){
	  DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "FEE_RATE") = 0;
	  DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "FEE_PAY_AMT") = 0;
      DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "PAY_AMT") = 0;
      DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "TOT_PAY_AMT") = 0;
 }
 /**
 * getVenCd()
 * 작 성 자 : 
 * 작 성 일 : 2011-04-06
 * 개    요 : 가맹점 팝업 오픈시 점코드 필수
 * return값 : void
 */
function getVenCd(flag){
    if(flag == "S"){
    	var strStrCd = eval(LC_S_STR);
    	var strVenCd = eval(EM_S_VEN_CD);
    	var strVenNm = eval(EM_S_VEN_NM);
    }else{
    	var strStrCd = eval(LC_STR);
        var strVenCd = eval(EM_VEN_CD);
        var strVenNm = eval(EM_VEN_NM);
    }
	 if(strStrCd.BindColVal == ""){
           showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
           strStrCd.Focus();
           return;
       }
    getMssEvtVenPop( strVenCd, strVenNm, 'S', '3', '', strStrCd.BindColVal, '');
}


/**
 * getCalculate()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 입금금액 계산
 * return값 : void
 */

function getCalculate(flag) {
	var row = DS_O_VENPAY.RowPosition;
    if(DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") == "TRUE"){
        showMessage(EXCLAMATION , OK, "USER-1150" , "", "수정");
        return;
   }
    switch(flag) {
        case "TOT_PAY_AMT" :   // 입금금액
            var strSum = DS_O_VENPAY.NameValue(row, "TOT_PAY_AMT") * (DS_O_VENPAY.NameValue(row, "FEE_RATE")/100);
        	DS_O_VENPAY.NameValue(row, "FEE_PAY_AMT") = strSum;
        	DS_O_VENPAY.NameValue(row, "PAY_AMT") = DS_O_VENPAY.NameValue(row, "TOT_PAY_AMT") - strSum;
            break;
        case "FEE_RATE" : // 수수료율
        	var strSum = DS_O_VENPAY.NameValue(row, "TOT_PAY_AMT") * (100/DS_O_VENPAY.NameValue(row, "FEE_RATE"));
            DS_O_VENPAY.NameValue(row, "FEE_PAY_AMT") = strSum;
            DS_O_VENPAY.NameValue(row, "PAY_AMT") = DS_O_VENPAY.NameValue(row, "TOT_PAY_AMT") - strSum;
            break;
        case "PAY_AMT" : // 실입금금액
        	DS_O_VENPAY.NameValue(row, "TOT_PAY_AMT") = DS_O_VENPAY.NameValue(row, "PAY_AMT") + DS_O_VENPAY.NameValue(row, "FEE_PAY_AMT");
            break;
        case "FEE_PAY_AMT" : // 수수료금액
        	DS_O_VENPAY.NameValue(row, "TOT_PAY_AMT") = DS_O_VENPAY.NameValue(row, "PAY_AMT") + DS_O_VENPAY.NameValue(row, "FEE_PAY_AMT");
            break;
    }
}
/**
 * setObject()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-10
 * 개    요 : 등록 컨포넌트 활성/비활성 설정
 * return값 : void
 */
function setObject(flag) {
	 
	/* switch(flag) {
     case "1" :   // page loading        
    	 LC_STR.Enable = false;
    	 EM_PAY_DT.Enable = false;
    	 enableControl(IMG_CAL, false);
    	 EM_VEN_CD.Enable = false; 
    	 enableControl(IMG_VENDOR, false);
    	 EM_PAY_AMT.Enable = false;
    	 EM_FEE_PAY_AMT.Enable = false;
         break;
     case "2" : // new
    	 LC_STR.Enable = true;
         EM_PAY_DT.Enable = true;
         enableControl(IMG_CAL, true);
         EM_VEN_CD.Enable = true;
         enableControl(IMG_VENDOR, true);
         EM_PAY_AMT.Enable = true;
         EM_FEE_PAY_AMT.Enable = true;
         break;
     case "3" : // modify
    	 LC_STR.Enable = false;
         EM_PAY_DT.Enable = false;
         enableControl(IMG_CAL, false);
         EM_VEN_CD.Enable = false;
         enableControl(IMG_VENDOR, false);
         EM_PAY_AMT.Enable = true;
         EM_FEE_PAY_AMT.Enable = true;
         break;
 }
	*/
}

/**
 * setData()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-10
 * 개    요 : 입금내용 조회 or 선택시 컨퍼넌트에 값 설정
 * return값 : void
 */
function setData() {
/*
	 btnNewClick = false;
	 if(DS_O_VENPAY.CountRow == 0){
		 LC_STR.BindColVal = "";
	     EM_PAY_DT.Text = "";
	     EM_VEN_CD.Text = "";
	     EM_VEN_NM.Text = "";
	     EM_PAY_AMT.Text = "0";
	     EM_FEE_PAY_AMT.Text = "0";
	     HID_PAY_SEQ_NO.Value= "";
	     setObject("1");
	     return;
	 }else{
		 LC_STR.BindColVal = DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "STR_CD");
	     EM_PAY_DT.Text = DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "PAY_DT");
	     EM_VEN_CD.Text = DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "VEN_CD");
	     EM_VEN_NM.Text = DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "VEN_NM");
	     EM_PAY_AMT.Text = DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "PAY_AMT");
	     EM_FEE_PAY_AMT.Text = DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "FEE_PAY_AMT");
	     HID_PAY_SEQ_NO.Value= DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "PAY_SEQ_NO");
	 }
     
     if(DS_O_VENPAY.NameValue(DS_O_VENPAY.RowPosition, "CLOSE_FLAG") == "TRUE"){
    	 setObject("1");
    	 return;
     }else{
    	 setObject("3");
    	 return;
     }
     */
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
<!--------------------- 1. TR Success 메세지 처리  --- ------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_S_STR event=OnFilter(row)>
if (DS_O_S_STR.NameValue(row, "CODE") != "00") {// 본사점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_STR event=OnFilter(row)>
if (DS_O_STR.NameValue(row, "CODE") != "00") {// 본사점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_VENCAL event=CanRowPosChange(row)>
if(flagModify){ 
	if(showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_VENCAL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
 if(DS_O_VENCAL.CountRow > 0 && !btnSearchClick) {
	 getDetail();
	 setPorcCount("SELECT", DS_O_VENPAY.CountRow);
 }
</script>
<script language=JavaScript for=DS_O_VENPAY event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
 setData();
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=DS_O_VENCAL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=DS_O_VENPAY event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 flagModify = true;     
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_S_VEN_NM.Text = "";
        return;
    }
 if(this.Text.length > 0){
        if(LC_S_STR.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_S_STR.Focus();
            return;
        }
        getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "3", '', LC_S_STR.BindColVal, '');
    }
</script>

<script language=JavaScript for=GD_VENPAY    event=OnPopup(row,colid,data)>
    if(colid == "PAY_DT"){
        openCal(this,row,colid);    
    }
    if(colid == "VEN_CD"){
        var rtnMap = getMssEvtVenPop(DS_O_VENPAY.NameValue(row, "VEN_CD"), '', 'S', '3', '', '', '');
        if(rtnMap != null){
        	DS_O_VENPAY.NameValue(row, "VEN_CD") = rtnMap.CODE;
        	DS_O_VENPAY.NameValue(row, "VEN_NM") = rtnMap.NAME;
        	if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                && DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                && DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
             getVenFee(); // 수수료 정보조회
             return;
        }
        setVenFee();
        }
    }
</script>
<script language=JavaScript for=GD_VENPAY event=OnExit(row,colid,olddata)>
 switch(colid){
        case 'VEN_CD':
            if(DS_O_VENPAY.NameValue(row, "VEN_CD") == ""){
                DS_O_VENPAY.NameValue(row, "VEN_NM") = "";
                setVenFee();
                return;
            }
            if(DS_O_VENPAY.NameValue(row, "VEN_CD") != olddata){
            	DS_O_VENPAY.NameValue(row, "VEN_NM") = "";
                getMssEvtVenNonPop( "DS_O_RESULT", DS_O_VENPAY.NameValue(row, "VEN_CD"), "", "G", "N", "3", "");
                if(DS_O_RESULT.CountRow == 1){
                	DS_O_VENPAY.NameValue(row, "VEN_CD") = DS_O_RESULT.NameValue(1,"CODE");
                	DS_O_VENPAY.NameValue(row, "VEN_NM") = DS_O_RESULT.NameValue(1,"NAME");
                	if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                        && DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                        && DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
                     getVenFee(); // 수수료 정보조회
                     return;
                }
                setVenFee();
                    return;
                }else{
                    var rtnMap = getMssEvtVenPop(DS_O_VENPAY.NameValue(row, "VEN_CD"), '', 'S', '3', '', '', '');
                    if(rtnMap != null){
                    	DS_O_VENPAY.NameValue(row, "VEN_CD") = rtnMap.CODE;
                    	DS_O_VENPAY.NameValue(row, "VEN_NM") = rtnMap.NAME;
                    	if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                            && DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                            && DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
                         getVenFee(); // 수수료 정보조회
                         return;
                    }
                    setVenFee();
                    }else{
                    	DS_O_VENPAY.NameValue(row, "VEN_CD") = "";
                    	DS_O_VENPAY.NameValue(row, "VEN_NM") = "";
                    }
                }
            }
            break; 
        case 'STR_CD': // 점코드와  입금일자가 변경이 되면 마감여부를 체크해온다
            if(DS_O_VENPAY.NameValue(row, "PAY_DT") == "" || DS_O_VENPAY.NameValue(row, "STR_CD") == ""){
            	DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") == "";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") == "";
                return;
            }
            if( getCloseCheck('DS_CLOSECHECK'
                              , DS_O_VENPAY.NameValue(row, "STR_CD")
                              , DS_O_VENPAY.NameValue(row, "PAY_DT")
                              ,'MGIF','47','0','M') == 'TRUE'){
                showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
                setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "PAY_DT");
                return;
            }else{
            	DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") = "FALSE";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") = "마감전";
                if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                    && DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                    && DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
                 getVenFee(); // 수수료 정보조회
                 return;
            }
            setVenFee();
            }
            break; 
        case 'PAY_DT': // 점코드와  입금일자가 변경이 되면 마감여부를 체크해온다
        	 if(DS_O_VENPAY.NameValue(row, "PAY_DT") == "" || DS_O_VENPAY.NameValue(row, "STR_CD") == ""){
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") == "";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") == "";
                return;
            }
        
            if( getCloseCheck('DS_CLOSECHECK'
                              , DS_O_VENPAY.NameValue(row, "STR_CD")
                              , DS_O_VENPAY.NameValue(row, "PAY_DT")
                              ,'MGIF','47','0','M') == 'TRUE'){
                showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
                setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "PAY_DT");
                return;
            }else{
            	DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") = "FALSE";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") = "마감전";
                if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                    && DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                    && DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
                 getVenFee(); // 수수료 정보조회
                 return;
            }
            setVenFee();
            }
            break;  
        case 'TOT_PAY_AMT': // 수수료율 변경시 금액 계산
            getCalculate(colid);
             break;  
        case 'PAY_AMT': // 수수료율 변경시 금액 계산
            getCalculate(colid);
             break;  
        case 'FEE_PAY_AMT': // 수수료율 변경시 금액 계산
            getCalculate(colid);
             break; 
    }
</script>
 <script language=JavaScript for=GD_VENPAY event=CanColumnPosChange(row,colid)>
 switch(colid){
        case 'STR_CD': // 점코드와  입금일자가 변경이 되면 마감여부를 체크해온다
        	 if(DS_O_VENPAY.NameValue(row, "PAY_DT") == "" || DS_O_VENPAY.NameValue(row, "STR_CD") == ""){
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") == "";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") == "";
                return;
            }
            if( getCloseCheck('DS_CLOSECHECK'
                              , DS_O_VENPAY.NameValue(row, "STR_CD")
                              , DS_O_VENPAY.NameValue(row, "PAY_DT")
                              ,'MGIF','47','0','M') == 'TRUE'){
                showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
                setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "PAY_DT");
                return;
            }else{
            	DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") = "FALSE";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") = "마감전";
                
                if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                		&& DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                		&& DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
                	 getVenFee(); // 수수료 정보조회
                	 return;
                }
                setVenFee();
            }
            break; 
        case 'PAY_DT': // 점코드와  입금일자가 변경이 되면 마감여부를 체크해온다
        	 if(DS_O_VENPAY.NameValue(row, "PAY_DT") == "" || DS_O_VENPAY.NameValue(row, "STR_CD") == ""){
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") == "";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") == "";
                return;
            }
            if( getCloseCheck('DS_CLOSECHECK'
                              , DS_O_VENPAY.NameValue(row, "STR_CD")
                              , DS_O_VENPAY.NameValue(row, "PAY_DT")
                              ,'MGIF','47','0','M') == 'TRUE'){
                showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
                setFocusGrid(GD_VENPAY, DS_O_VENPAY, DS_O_VENPAY.CountRow, "PAY_DT");
                return;
            }else{
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG") = "FALSE";
                DS_O_VENPAY.NameValue(row, "CLOSE_FLAG_NM") = "마감전";
                if(DS_O_VENPAY.NameValue(row, "PAY_DT") != "" 
                    && DS_O_VENPAY.NameValue(row, "STR_CD") != "" 
                    && DS_O_VENPAY.NameValue(row, "VEN_CD") != "" ){
                 getVenFee(); // 수수료 정보조회
                 return;
            }
            setVenFee();
            }
            break;  
    }
</script>
<!--
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
        if(LC_STR.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_STR.Focus();
            return;
        }
        getMssEvtVenNonPop( "DS_O_RESULT", EM_VEN_CD, EM_VEN_NM, "E", "Y", "3", '', LC_STR.BindColVal, '');
    }
</script>
<script language=JavaScript for=LC_STR event=OnKillFocus()>
flagModify = true;
</script>
  <script language=JavaScript for=EM_PAY_DT event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 flagModify = true;     
</script>
<script language=JavaScript for=EM_PAY_AMT event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
if(this.Text < 0){
	 showMessage(EXCLAMATION, OK, "USER-1000", "입금액이 0보다 작을수 없습니다.");
	 this.Text = 0;
	 setTimeout("EM_PAY_AMT.Focus();",50);
	return;
}     
 flagModify = true;     
</script>
<script language=JavaScript for=EM_FEE_PAY_AMT event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 if(this.Text < 0){
     showMessage(EXCLAMATION, OK, "USER-1000", "수수료금액 0보다 작을수 없습니다.");
     this.Text = 0;
     setTimeout("EM_FEE_PAY_AMT.Focus();",50);
    return;
}    
 flagModify = true;     
</script>
-->
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
<param name=UseFilter value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_VENPAY"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VENFEE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
<input type="hidden" id="HID_PAY_SEQ_NO">
<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">본사점</th>
            <td width="100">
                <comment id="_NSID_">
                   <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=98 align="absmiddle" tabindex=1>
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="80" class="point">정산년월</th>
            <td width=180>
               <comment id="_NSID_">
                 <object id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> onblur="checkDateTypeYM(this);" width=60 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_CAL_YM)" align="absmiddle" />
                  ~
                  <comment id="_NSID_">
                 <object id=EM_E_CAL_YM classid=<%=Util.CLSID_EMEDIT%> onblur="checkDateTypeYM(this);" width=60 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_E_CAL_YM)" align="absmiddle" />
              </td>
               <th width="80">위탁협력사</th>
            <td>
                <comment id="_NSID_">
                    <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle" tabindex=1>
                    </object>
                </comment>
                <script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="javascript:getVenCd('S');" class="PR03"/>
                 <comment id="_NSID_">
                    <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle">
                    </object>
                </comment>
                <script> _ws_(_NSID_);</script>
              </td>
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr>
  <!--<tr>
  <td class="PB05">
     <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
        <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">본사점</th>
            <td width="130">
                <comment id="_NSID_">
                   <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=130 align="absmiddle" tabindex=1>
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="80" class="point">입금일자</th>
            <td width=125>
               <comment id="_NSID_">
                 <object id=EM_PAY_DT classid=<%=Util.CLSID_EMEDIT%> onblur="checkDateTypeYMD(this);" width=98 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_CAL" onclick="javascript:openCal('G',EM_PAY_DT)" align="absmiddle" />
              </td>
               <th width="80">위탁협력사</th>
            <td>
                <comment id="_NSID_">
                    <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle" tabindex=1>
                    </object>
                </comment>
                <script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VENDOR" align="absmiddle" onclick="javascript:getVenCd('I');" class="PR03"/>
                 <comment id="_NSID_">
                    <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle">
                    </object>
                </comment>
                <script> _ws_(_NSID_);</script>
              </td>
          </tr> 
          <tr>
            <th width="80" class="point">입금액</th>
            <td width="130">
                <comment id="_NSID_">
                 <object id=EM_PAY_AMT classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">수수료금액</th>
            <td colspan=3>
               <comment id="_NSID_">
                 <object id=EM_FEE_PAY_AMT classid=<%=Util.CLSID_EMEDIT%> width=125 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
              </td>
          </tr>
        </table>
        </td>
        </tr>
        </table>
  </TD>
  </TR>
  --><!--<tr>
  <td class="PB05">
     <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
               <comment id="_NSID_"><OBJECT id=GD_VENCAL width=100% height=200 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_VENCAL">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
  </TD>
  </TR>
  --><TR>
  <td class="right PB05">
  <img src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18" onclick="javascript:addRow();" hspace="2"/>
  <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:delRow();"/>
  <TD>
  </tr>
  <tr>
  <td>
   <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
              <comment id="_NSID_"><OBJECT id=GD_VENPAY width=100% height=475 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_VENPAY">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
  </TD>
  </TR>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

