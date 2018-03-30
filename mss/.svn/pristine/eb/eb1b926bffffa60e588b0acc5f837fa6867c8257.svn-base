<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 제휴/브랜드상품권(쿠폰) 마스터등록
 * 작 성 일 : 2011.01.21
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.21 (김성미) 신규작성
 *        2011.03.28 (김성미) 프로그램 작송
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

<script LANGUAGE="JavaScript"><!--


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var btnSaveClick = false;
 var strCurGiftTypeCd = 0;
 var strToday = getTodayFormat("YYYYMMDD");
 /**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 360;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_GIFT_TYPE_CD, "GEN", NORMAL);               //상품권 종류 코드
    initEmEdit(EM_GIFT_TYPE_NAME, "GEN", READ);               //상품권 종류 명
    
    //콤보 초기화
    initComboStyle(LC_GIFT_TYPE_FLAG,DS_O_S_GIFT_TYPE_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);      //상품권종류 구분
    
    getGiftCommCode("s_flag");
    LC_GIFT_TYPE_FLAG.Index = 0;
    getGiftCommCode("flag");
    getGiftCommCode("payrec");
    getGiftCommCode("issue");
    setTimeout("LC_GIFT_TYPE_FLAG.Focus();",50);
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif102", "DS_IO_MASTER,DS_IO_DETAIL");   
   
}

function gridCreate(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                     + '<FC>id=GIFT_TYPE_CD      name="*상품권;종류" EditLimit=4 edit=numeric  edit=none  width=80   align=center</FC>'
                     + '<FC>id=GIFT_TYPE_NAME    name="*상품권종류 명"   EditLimit=40    width=90  align=left</FC>'
                     + '<FC>id=GIFT_TYPE_FLAG    name="*상품권종류; 구분"   edit={if(SysStatus = "I", "true", "false")}   width=80   align=left EditStyle=Lookup Data="DS_O_GIFT_TYPE_FLAG:CODE:NAME"</FC>'
                     + '<FG>id=TITLE    name="*사용기간"     align=center'
                     + '<FC>id=USE_S_DT    name="FROM"  edit={if(SysStatus = "I", "true", "false")}   width=100 mask="XXXX/XX/XX" EditLimit=8 edit=numeric EditStyle=Popup align=center</FC>'
                     + '<FC>id=USE_E_DT    name="TO"     width=100 mask="XXXX/XX/XX" EditLimit=8 edit=numeric EditStyle=Popup align=center</FC>'
                     + '</FG>'
                     + '<FC>id=PAYREC_FLAG    name="*수수료;구분"   edit={if(GIFT_TYPE_FLAG == "02", "true", if(GIFT_TYPE_FLAG == "04", "true", "false"))}   width=60   align=left EditStyle=Lookup Data="DS_O_PAYREC_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=VEN_CD    name="*협력사 ;코드" edit={if(GIFT_TYPE_FLAG == "02", "true", if(GIFT_TYPE_FLAG == "04", "true", "false"))}  EditStyle=Popup   width=60   align=center</FC>'
                     + '<FC>id=VEN_NM    name="*협력사 명"  edit=none   width=120   align=left</FC>'
                     + '<FC>id=GROUP_CD    name="그룹코드"   edit=none   width=60 align=center </FC>'
                     + '<FC>id=USE_YN    name="*사용;여부"      width=50 align=center EditStyle=CheckBox</FC>';
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
        + '<FC>id=ISSUE_TYPE      name="*발행형태"  edit={if(GIFT_AMT_TYPE = "", "true", "false")}   width=120   align=left EditStyle=Lookup Data="DS_O_ISSUE_TYPE:CODE:NAME"</FC>'
        + '<FC>id=GIFT_AMT_TYPE    name="*금종코드"       width=120  align=center edit=none</FC>'
        + '<FC>id=GIFT_AMT_NAME    name="*금종명"  EditLimit=40   width=180   align=left EditLimit=40</FC>'
        + '<FC>id=GIFTCERT_AMT    name="*상품권금액"  edit={if(GIFT_AMT_TYPE = "", "true", "false")}   width=120   EditLimit=9 align=right edit=numeric</FC>'
        + '<FC>id=RFD_PERMIT_RATE    name="환불 허용율"     width=120   EditLimit=3 align=right edit=numeric</FC>'
        + '<FC>id=USE_YN    name="*사용여부"      width=80 align=center EditStyle=CheckBox</FC>';
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
 * 작 성 일 : 2011-03-28
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnSaveClick){
	        if(showMessage(QUESTION , YESNO, "USER-1073") != 1 ){
	            return false;
	        }
	 }
         
	var goTo       = "getMaster";
    var parameters = "&strGiftTypeFlag=" + encodeURIComponent(LC_GIFT_TYPE_FLAG.BindColVal)
                   + "&strGiftTypeCd="   + encodeURIComponent(EM_GIFT_TYPE_CD.Text);
    TR_MAIN.Action="/mss/mgif102.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
    if(strCurGiftTypeCd != "") DS_IO_MASTER.RowPosition = DS_IO_MASTER.NameValueRow("GIFT_TYPE_CD",strCurGiftTypeCd);
    strCurGiftTypeCd = "";
    setTimeout("GD_MASTER.Focus();",50);
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-28
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	var row = DS_IO_MASTER.CountRow; 
    // 행추가가 되어 있는경우 메세지 처리
    if(DS_IO_MASTER.SysStatus(DS_IO_MASTER.CountRow) == 1){
        if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
            setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.CountRow, "GIFT_TYPE_CD");
            return;
        }
        DS_IO_MASTER.DeleteRow(row); 
    }
    DS_IO_MASTER.AddRow();
    setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.CountRow, "GIFT_TYPE_CD");
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
 * 작 성 일 : 2011-03-28
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
    if(DS_IO_MASTER.CountRow  == 0 && DS_IO_DETAIL.CountRow  == 0){
          //저장할 내용이 없습니다
            showMessage(EXCLAMATION , OK, "USER-1028");
            return;
     }
    btnSaveClick = true;
    if(!checkDSBlank(GD_MASTER, "2,3,4,5")){
        btnSaveClick = false; 
        return;
    }
    
    if(!isNumberStr(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_CD"))){
        showMessage(EXCLAMATION, OK, "USER-1005", "상품권 종류");
        setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "GIFT_TYPE_CD");
        btnSaveClick = false;
        return;
    }
    
    if(!checkByteStr(GD_MASTER, "40", "Y", DS_IO_MASTER.RowPosition, "GIFT_TYPE_NAME")){
         setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "GIFT_TYPE_NAME");
         btnSaveClick = false;
         return;
    }
    
    if(DS_IO_MASTER.SysStatus(DS_IO_MASTER.RowPosition) == "1" && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"USE_S_DT") <= strToday){
    	showMessage(EXCLAMATION, OK, "USER-1008", "시작일자", "오늘");
        setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "USE_S_DT");
        btnSaveClick = false;
        return;
    }
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"USE_E_DT") <= strToday){
        showMessage(EXCLAMATION, OK, "USER-1008", "종료일자", "오늘");
        setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "USE_E_DT");
        btnSaveClick = false;
        return;
    }
    
    if(!isBetweenFromTo(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"USE_S_DT"), DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"USE_E_DT"))){
        showMessage(EXCLAMATION, OK, "USER-1015");
        setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "USE_S_DT");
        btnSaveClick = false;
        return;
    }
    
    for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
        if(DS_IO_MASTER.NameValue(i,"GIFT_TYPE_FLAG") != "03"){ // 브랜드가  아닌경우 수수료, 협력사 정보 필수
        	  if(DS_IO_MASTER.NameValue(i,"PAYREC_FLAG") == ""){
        	        showMessage(EXCLAMATION, OK, "USER-1005", "수수료구분");
        	        setFocusGrid(GD_MASTER, DS_IO_MASTER, i, "PAYREC_FLAG");
        	        btnSaveClick = false;
        	        return;
        	    }
        	  if(DS_IO_MASTER.NameValue(i,"VEN_CD") == "" || DS_IO_MASTER.NameValue(i,"VEN_NM") == ""){
                  showMessage(EXCLAMATION, OK, "USER-1005", "협력사코드");
                  setFocusGrid(GD_MASTER, DS_IO_MASTER, i, "VEN_CD");
                  btnSaveClick = false;
                  return;
              }
        }
    }
   
    if(!checkDSBlank(GD_MASTER, "10")){
        btnSaveClick = false; 
        return;
    }
    
    if(!checkDSBlank(GD_DETAIL, "1,3,4,6")){
    	btnSaveClick = false; 
    	return;
    }
    
    if(DS_IO_DETAIL.CountRow > 0){
    	for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
    		if(!checkByteStr(GD_DETAIL, "40", "Y", i, "GIFT_AMT_NAME")){
    	         setFocusGrid(GD_DETAIL, DS_IO_DETAIL, i, "GIFT_AMT_NAME");
    	         btnSaveClick = false;
    	         return;
    	    }
    		
    		if(DS_IO_DETAIL.NameValue(i, "RFD_PERMIT_RATE") > 100){
                showMessage(EXCLAMATION, OK, "USER-1009", "환불 허용률", "100");
               DS_IO_DETAIL.NameValue(i, "RFD_PERMIT_RATE") = 0;
               setFocusGrid(GD_DETAIL, DS_IO_DETAIL, i, "RFD_PERMIT_RATE");
               btnSaveClick = false;
               return false;
           }
    	}
    }
    		
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1){
    	btnSaveClick = false; 
    	return;
    }
     
    strCurGiftTypeCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_CD");
    var goTo       = "save";
    var parameters = "&strGiftTypeCd="+ encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_CD"))
                    + "&strGiftFlag=" + encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_FLAG")); 
    
    TR_MAIN.Action="/mss/mgif102.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";  
    TR_MAIN.Post();
    btnSaveClick = false;
    
    if(TR_MAIN.ErrorCode == 0)  btn_Search();
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
  * getGiftCommCode()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-03-28
  * 개    요 : 상품권공통코드 조회  :s_flag => 조회용 상품권종류 구분, flag => 상품권종류 구분, payrec => 수수료 구분, issue => 발행형태
  * return값 : void
  */

 function getGiftCommCode(strFlag) {
     var strDataSet = "";
     var strCondi = "";
     switch(strFlag){
       case "s_flag" :
            strDataSet = "DS_O_S_GIFT_TYPE_FLAG";
            break;
       case "flag" :
            strDataSet = "DS_O_GIFT_TYPE_FLAG";
            break;
       case "payrec" :
            strDataSet = "DS_O_PAYREC_FLAG";
            break;
       case "issue" :
           strDataSet = "DS_O_ISSUE_TYPE";
           break
     }
     
     var goTo       = "getGiftCommCode";
     var parameters = "&strFlag="   + encodeURIComponent(strFlag)
                    + "&strDataSet="+ encodeURIComponent(strDataSet);
     TR_MAIN.Action="/mss/mgif102.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET(O:"+strDataSet+"="+strDataSet+")"; 
     TR_MAIN.Post();
 }
  
  
/**
 * getDetail()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-24
 * 개    요 : 금종정보 목록 조회
 * return값 : void
 */
function getDetail() {
    var goTo       = "getDetail";
    var parameters = "&strGiftTypeFlag="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_TYPE_CD"));
    TR_DTL.Action="/mss/mgif102.mg?goTo="+goTo+parameters;  
    TR_DTL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_DTL.Post();
} 

/**
 * addRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행추가
 * return값 : void
 */

function addRow() {
   if(DS_IO_MASTER.CountRow == 0){
	   showMessage(EXCLAMATION , OK, "USER-1000" , "상품권종류정보를   등록 혹은 조회하세요.");
	   return;
   }
   
   if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_TYPE_FLAG") != '02') {
	   showMessage(EXCLAMATION , OK, "USER-1000" , "상품권종류 구분이 제휴상품권인경우에만 금종정보를 추가할수 있습니다.");
	   return;
   }
   
   var row = DS_IO_DETAIL.CountRow; 
   // 필수입력 사항 체크 
   if(DS_IO_DETAIL.NameValue(row, "GIFT_AMT_TYPE") == ""){
       // 금종명
       if(DS_IO_DETAIL.NameValue(row, "GIFT_AMT_NAME") == ""){
            showMessage(EXCLAMATION , OK, "USER-1003" , "금종명");
            setFocusGrid(GD_DETAIL, DS_IO_DETAIL, row, "GIFT_AMT_NAME");
            return;
       }
       // 상품권금액
       if(DS_IO_DETAIL.NameValue(row, "GIFTCERT_AMT") == ""){
           showMessage(EXCLAMATION , OK, "USER-1003" , "상품권금액");
           setFocusGrid(GD_DETAIL, DS_IO_DETAIL, row, "GIFTCERT_AMT");
           return;
           
       }
   }
   DS_IO_DETAIL.AddRow(); 
   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_TYPE_CD") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_CD");
   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "ISSUE_TYPE") = DS_O_ISSUE_TYPE.NameValue(1,"CODE");
   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "USE_YN") = "T";
   setFocusGrid(GD_DETAIL, DS_IO_DETAIL, DS_IO_DETAIL.CountRow, "GIFT_AMT_NAME");
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {
    if(DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1019");
           return;
       }
    if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GIFT_AMT_TYPE") != ""){
        showMessage(EXCLAMATION , OK, "USER-1039");
           return;
       }
    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
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
         if(showMessage(INFORMATION, YESNO, "USER-1074") != 1 ){
             return false;
         }
         if(DS_IO_MASTER.SysStatus(row) == "1"){
             DS_IO_MASTER.DeleteRow(row);
             return true;
         }
         // 이전 조회 값으로 셋팅
         DS_IO_MASTER.NameValue(row,"GIFT_TYPE_NAME") = DS_IO_MASTER.OrgNameValue(row,"GIFT_TYPE_NAME");
         DS_IO_MASTER.NameValue(row,"GIFT_TYPE_FLAG") = DS_IO_MASTER.OrgNameValue(row,"GIFT_TYPE_FLAG");
         DS_IO_MASTER.NameValue(row,"USE_S_DT") = DS_IO_MASTER.OrgNameValue(row,"USE_S_DT");
         DS_IO_MASTER.NameValue(row,"USE_E_DT") = DS_IO_MASTER.OrgNameValue(row,"USE_E_DT");
         DS_IO_MASTER.NameValue(row,"PAYREC_FLAG") = DS_IO_MASTER.OrgNameValue(row,"PAYREC_FLAG");
         DS_IO_MASTER.NameValue(row,"VEN_CD") = DS_IO_MASTER.OrgNameValue(row,"VEN_CD");
         DS_IO_MASTER.NameValue(row,"VEN_NM") = DS_IO_MASTER.OrgNameValue(row,"VEN_NM");
         DS_IO_MASTER.NameValue(row,"USE_YN") = DS_IO_MASTER.OrgNameValue(row,"USE_YN");
         return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(row == 0) return;
DS_IO_DETAIL.ClearData();
if(DS_IO_MASTER.NameValue(row, "GIFT_TYPE_FLAG") != '02'){
	setPorcCount("SELECT", GD_DETAIL);
	return;
}
getDetail();
//조회결과 Return
setPorcCount("SELECT", GD_DETAIL);
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
 switch(colid){
        case 'VEN_CD':
       
            break; 
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
 switch(colid){
        case 'VEN_CD':
        	if(DS_IO_MASTER.NameValue(row, "VEN_CD") == ""){
        		DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
        		return;
        	}
            if(DS_IO_MASTER.NameValue(row, "VEN_CD") != olddata){
            	DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
            	getMssEvtVenNonPop( "DS_O_RESULT", DS_IO_MASTER.NameValue(row, "VEN_CD"), "", "G", "N", "1", "");
            	if(DS_O_RESULT.CountRow == 1){
                    DS_IO_MASTER.NameValue(row, "VEN_CD") = DS_O_RESULT.NameValue(1,"CODE");
                    DS_IO_MASTER.NameValue(row, "VEN_NM") = DS_O_RESULT.NameValue(1,"NAME");
                    return;
                }else{
                	var rtnMap = getMssEvtVenPop(DS_IO_MASTER.NameValue(row, "VEN_CD"), '', 'S', '1', '', '', '');
                    if(rtnMap != null){
                        DS_IO_MASTER.NameValue(row, "VEN_CD") = rtnMap.CODE;
                        DS_IO_MASTER.NameValue(row, "VEN_NM") = rtnMap.NAME;
                    }else{
                    	DS_IO_MASTER.NameValue(row, "VEN_CD") = "";
                        DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
                    }
                }
            }
            break; 
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>
 if(btnSaveClick) return true;
 switch(colid){
        case 'GIFT_TYPE_CD':
        	 if(DS_IO_MASTER.NameValue(row,colid) != "" && DS_IO_MASTER.NameValue(row,colid) <= 999){
       	        showMessage(EXCLAMATION, OK, "USER-1000", "상품권 종류 코드는 1000번대 이상부터 등록이 가능합니다.");
       	        return false;
        	 }
	         break; 
        case 'USE_S_DT':
        	if(DS_IO_MASTER.NameValue(row,colid) == "") return true;
        	if(DS_IO_MASTER.SysStatus(row) !=  1 && DS_IO_MASTER.NameValue(row,colid) == DS_IO_MASTER.OrgNameValue(row,colid)) return true;
        	checkDateTypeYMD(this, colid);
            if(DS_IO_MASTER.NameValue(row,colid) <= strToday){
                showMessage(EXCLAMATION, OK, "USER-1008", "시작일자", "오늘");
                if(DS_IO_MASTER.SysStatus(row) ==  1){
                	DS_IO_MASTER.NameValue(row,colid) = getRawData(addDate("d", +1, strToday));
                }else{
                	DS_IO_MASTER.NameValue(row,colid) = DS_IO_MASTER.OrgNameValue(row,colid);
                }
                return false;
            }
            break; 
        case 'USE_E_DT':
        	if(DS_IO_MASTER.NameValue(row,colid) == "") return true;
        	if(DS_IO_MASTER.SysStatus(row) !=  1 && DS_IO_MASTER.NameValue(row,colid) == DS_IO_MASTER.OrgNameValue(row,colid)) return true;
            checkDateTypeYMD(this, colid);
            if(DS_IO_MASTER.NameValue(row,colid) <= strToday){
                showMessage(EXCLAMATION, OK, "USER-1008", "종료일자", "오늘");
                if(DS_IO_MASTER.SysStatus(row) ==  1){
                    DS_IO_MASTER.NameValue(row,colid) = getRawData(addDate("d", +1, strToday));
                }else{
                    DS_IO_MASTER.NameValue(row,colid) = DS_IO_MASTER.OrgNameValue(row,colid);
                }
                return false;
            }
            break; 
    }
return true;
</script>

<script language=JavaScript for=GD_DETAIL event=CanColumnPosChange(row,colid)>
switch (colid){
    case "RFD_PERMIT_RATE" :
    	if(DS_IO_DETAIL.NameValue(row, colid) > 100){
    	     showMessage(EXCLAMATION, OK, "USER-1009", "환불 허용률", "100");
    	    DS_IO_DETAIL.NameValue(row, colid) = 0;
    	    return false;
    	}
    	break;
}

return true;
</script>
<script language=JavaScript for=GD_MASTER    event=OnPopup(row,colid,data)>
    if(colid == "USE_S_DT" || colid == "USE_E_DT"){
        openCal(this,row,colid);    
    }
    if(colid == "VEN_CD"){
    	var rtnMap = getMssEvtVenPop(DS_IO_MASTER.NameValue(row, "VEN_CD"), '', 'S', '1', '', '', '');
    	//var rtnMap = venToGridPop(DS_IO_MASTER.NameValue(row, "VEN_CD"),"", "","","","","","95");
    	if(rtnMap != null){
    		DS_IO_MASTER.NameValue(row, "VEN_CD") = rtnMap.CODE;
    		DS_IO_MASTER.NameValue(row, "VEN_NM") = rtnMap.NAME;
    	}
    }
</script>

<script language=JavaScript for=EM_GIFT_TYPE_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if( EM_GIFT_TYPE_CD.Text ==""){
		EM_GIFT_TYPE_NAME.Text = ""; 
	       return;
	   }
    if(EM_GIFT_TYPE_CD.text!=null){
        if(EM_GIFT_TYPE_CD.text.length > 0){
        	getGiftTypeNonPop("DS_O_RESULT", EM_GIFT_TYPE_CD, EM_GIFT_TYPE_NAME, "E" , "Y")
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
<comment id="_NSID_"><object id="DS_O_S_GIFT_TYPE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_TYPE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAYREC_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<object id="TR_DTL" classid=<%=Util.CLSID_TRANSACTION%>>
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

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
             <th width="90">상품권종류구분</th>
            <td width="140">
                <comment id="_NSID_">
                   <object id=LC_GIFT_TYPE_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle" tabindex=1 >
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="80">상품권 종류</th>
            <td>
               <comment id="_NSID_">
                 <object id=EM_GIFT_TYPE_CD classid=<%=Util.CLSID_EMEDIT%>   width=60 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" class="PR03" onclick="javascript:getGiftTypePop(EM_GIFT_TYPE_CD,EM_GIFT_TYPE_NAME,'S','01');"/>
                 <comment id="_NSID_">
                 <object id=EM_GIFT_TYPE_NAME classid=<%=Util.CLSID_EMEDIT%>   width=100 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
 <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>상품권종류 정보
  </td>
  </tr>
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=220 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_MASTER">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
<!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
  <td>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>금종정보
    </td>
    <td class="right"><img src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18" onclick="javascript:addRow();" hspace="2"/> <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:delRow();"/>
    </td>
    </tr>
    </table>
  </td>
  </tr>
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=370 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_DETAIL">
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

