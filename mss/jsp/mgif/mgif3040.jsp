<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 상품권 교환 판매등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.05.09 (김성미) 프로그램 작성
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
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
 var strOrgCd = '<c:out value="${sessionScope.sessionInfo.ORG_CD}" />';
 var strToday   ;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 530;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_SALE"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    DS_IO_RETURN.setDataHeader('<gauce:dataset name="H_RETURN"/>');
    DS_IO_SALE.setDataHeader('<gauce:dataset name="H_SALE"/>');
    DS_O_GIFT_CHECK.setDataHeader('<gauce:dataset name="H_GIFT_CHECK"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT, "TODAY", PK);                    // 판매일자
    //initEmEdit(EM_S_GIFT_S_NO, "NUMBER3^18", NORMAL);         // 시작번호
    //initEmEdit(EM_S_GIFT_E_NO, "NUMBER3^18", NORMAL);         // 종료번호
    initEmEdit(EM_S_GIFT_E_NO, "GEN^18", NORMAL);         // 판매상품권번호
    initEmEdit(EM_USER_NM,  "GEN", READ);                   // 등록자
    //initEmEdit(EM_R_GIFT_S_NO, "NUMBER3^18", NORMAL);         // 시작번호
    initEmEdit(EM_R_GIFT_E_NO, "GEN^18", NORMAL);         // 회수상품권번호
    //initEmEdit(EM_R_GIFT_E_NO, "NUMBER3^18", NORMAL);         // 종료번호
    
    //콤보 초기화
    initComboStyle(LC_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                  //점

    getStore("DS_O_S_STR", "Y", "", "N");
    EM_USER_NM.Text = strUserNM;
    strToday   = getTodayDB("DS_O_RESULT");
    EM_SALE_DT.Text = strToday;
    LC_STR.Index = 0;
    LC_STR.Focus();
    
  //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif304", "DS_IO_RETURN,DS_IO_SALE");   
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            name="NO"         width=25   align=center</FC>'
    	             + '<FC>id=FLAG                name="삭제"       EditStyle=checkbox width=50 HeadCheckShow=true  align=center</FC>'
    	             + '<FC>id=GIFT_TYPE_NAME      name="상품권종류" edit=none SumText="합계"  width=100   align=left</FC>'
                     + '<FC>id=GIFT_AMT_NAME       name="금종"   edit=none  width=100   align=left</FC>'
                     + '<FC>id=GIFTCARD_NO         name="상품권코드"   edit=none  width=180   align=center</FC>'
                     + '<FC>id=STAT_FLAG_NM         name="상품권상태정보"   edit=none  width=120   align=left</FC>'
                     + '<FC>id=QTY                 name="수량"  edit=none  SumText=@sum  width=100   align=right</FC>'
                     + '<FC>id=AMT                 name="판매금액" edit=none SumText=@sum    width=100   align=right</FC>';
                     
    initGridStyle(GD_RETURN, "common", hdrProperies, true);
    GD_RETURN.ViewSummary = "1";

    
    var hdrProperies1 = '<FC>id={currow}            name="NO"         width=25   align=center</FC>'
        + '<FC>id=FLAG                name="삭제"       EditStyle=checkbox width=50 HeadCheckShow=true  align=center</FC>'
        + '<FC>id=GIFT_TYPE_NAME      name="상품권종류" edit=none SumText="합계"   width=140   align=left</FC>'
        + '<FC>id=GIFT_AMT_NAME       name="금종"   edit=none  width=130   align=left</FC>'
        + '<FC>id=GIFTCARD_NO         name="상품권코드"   edit=none  width=180   align=center</FC>'
        + '<FC>id=QTY                 name="수량"  edit=none  SumText=@sum  width=100   align=right</FC>'
        + '<FC>id=AMT                 name="판매금액" edit=none SumText=@sum    width=150   align=right</FC>';
        
    initGridStyle(GD_SALE, "common", hdrProperies1, true);
    GD_SALE.ViewSummary = "1";
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
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-05-09
 * 개    요 : 판매 내역 초기화
 * return값 : void
 */
function btn_New() {
	  if((DS_IO_RETURN.CountRow > 0 || DS_IO_SALE.CountRow > 0) &&  (showMessage(QUESTION , YESNO, "USER-1085") != 1)){
          return;
      }
	 
	//CHK_RETURN_SINGLE.checked = false;
	//CHK_SALE_SINGLE.checked = false;
	setNew();
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
    if (DS_IO_RETURN.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1000","회수내역을 등록하세요.");
        return;
    }
	 
    if (DS_IO_SALE.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1000","판매내역을 등록하세요.");
        return;
    }
     
    var strRSum = 0;
    for(var i=1;i<=DS_IO_RETURN.CountRow;i++){
    	strRSum += DS_IO_RETURN.NameValue(i,"AMT");
    }
    
    var strSSum = 0;
    for(var j=1;j<=DS_IO_SALE.CountRow;j++){
    	strSSum += DS_IO_SALE.NameValue(j,"AMT");
    }
    
    if(strRSum != strSSum){
    	showMessage(EXCLAMATION , OK, "USER-1000","회수내역과 판매내역 금액이 일치하지 않습니다.");
        return;
    }
    
    // 마감체크 (common.js) : 판매시간마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_STR.BindColVal
                      , EM_SALE_DT.Text
                      ,'MGIF','08','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "판매시간", "");
        EM_SALE_DT.Focus();
        return;
    }
 
 
    
 // 마감체크 (common.js) : 일마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_STR.BindColVal
                      , EM_SALE_DT.Text
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "일", "");
        EM_SALE_DT.Focus();
        return;
    }
 
    // 수불 마감체크 (common.js) : 월마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_STR.BindColVal
                      , EM_SALE_DT.Text
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        EM_SALE_DT.Focus();
        return;
    }
 
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    var strParam = "&strSaleDt=" + encodeURIComponent(EM_SALE_DT.Text)
                 + "&strStrCd="  + encodeURIComponent(LC_STR.BindColVal)
                 + "&strPartCd=" + encodeURIComponent(strOrgCd)
                 + "&strSSum="   + encodeURIComponent(strSSum);
    
    TR_MAIN.Action="/mss/mgif304.mg?goTo=save"+strParam;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_RETURN=DS_IO_RETURN,I:DS_IO_SALE=DS_IO_SALE)";
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) {
    	setNew();
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
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 : 초기화
  * return값 : void
  */ 
 function setNew(){
	 DS_IO_RETURN.ClearData();
     DS_IO_SALE.ClearData();
    // EM_R_GIFT_S_NO.Text = "";
     EM_R_GIFT_E_NO.Text = "";
    // EM_S_GIFT_S_NO.Text = "";
     EM_S_GIFT_E_NO.Text = "";
    /* if(CHK_RETURN_SINGLE.checked)
    	 EM_R_GIFT_S_NO.Enable = false;
     else
    	 EM_R_GIFT_S_NO.Enable = true;
     
     if(CHK_RETURN_SINGLE.checked)
    	 EM_S_GIFT_S_NO.Enable = false;
     else
    	 EM_S_GIFT_S_NO.Enable = true;
    */
     LC_STR.Enable = true;
     LC_STR.Index = 0;
     EM_SALE_DT.Text = strToday;
     LC_STR.Focus();
}
 /**
 * onSingle()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 한장씩 판매 등록
 * return값 : void
 */ 
function onSingle(strGbn){
	if(strGbn == "R"){
		if(CHK_RETURN_SINGLE.checked){
	        EM_R_GIFT_S_NO.Text = "";
	        EM_R_GIFT_S_NO.Enable = false;
	    }else{
	        EM_R_GIFT_E_NO.Text = "";
	        EM_R_GIFT_S_NO.Enable = true;
	    }
	}else{
		if(CHK_SALE_SINGLE.checked){
	        EM_S_GIFT_S_NO.Text = "";
	        EM_S_GIFT_S_NO.Enable = false;
	    }else{
	        EM_S_GIFT_E_NO.Text = "";
	        EM_S_GIFT_S_NO.Enable = true;
	    }
	}
}


/**
 * getSaleInfo()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 판매내역 등록
 * return값 : void
 */ 
function getSaleInfo(strGbn){
	 var strSNo = "";
	 var strENo = "";
	 var strDataSet = "";
	 var strDataSet_T = "";
	 var strChk = "";
	 if(strGbn == "S"){
		// strSNo = eval(EM_S_GIFT_S_NO);
	     strENo = eval(EM_S_GIFT_E_NO);
	    // strChk = eval(CHK_SALE_SINGLE);
	     strDataSet = eval(DS_IO_SALE);
	     strDataSet_T = eval(DS_IO_SALE_T);
	 }else if(strGbn == "R"){
		// strSNo = eval(EM_R_GIFT_S_NO);
         strENo = eval(EM_R_GIFT_E_NO);
        // strChk = eval(CHK_RETURN_SINGLE); 
         strDataSet = eval(DS_IO_RETURN);
         strDataSet_T = eval(DS_IO_RETURN_T);
	 }
    if(strGbn == "S"){ // 한장씩 판매 등록하는경우 
    	if (strENo.Text == ""){  //기간
            showMessage(EXCLAMATION, OK, "USER-1003", "상품권번호");
            strENo.Focus();
            return;
        }
    }
    /*else{
    	 if (strSNo.Text == ""){  //기간
             showMessage(EXCLAMATION, OK, "USER-1003", "시작번호");
             strSNo.Focus()
             return;
         }
    	 
    	 if (strENo.Text == ""){  //기간
             showMessage(EXCLAMATION, OK, "USER-1003", "종료번호");
             strENo.Focus()
             return;
         }
    	 
    	 if (strSNo.Text > strENo.Text){  //기간
   	        showMessage(EXCLAMATION, OK, "USER-1008", "종료번호", "시작번호");
   	        strENo.Focus()
   	        return;
   	    }
    }*/
    strDataSet_T.ClearData();
    var goTo       = "getSaleInfo";
    var parameters = "&strGbn="       + encodeURIComponent(strGbn)
                   + "&strChk="       + encodeURIComponent(strChk.checked)
                   + "&strStrCd="     + encodeURIComponent(LC_STR.BindColVal)
                //   + "&strGiftSNo=" + encodeURIComponent(strSNo.Text) 
                   + "&strGiftENo="   + encodeURIComponent(strENo.Text); 
    TR_MAIN.Action   = "/mss/mgif304.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:"+strDataSet_T.id+"="+strDataSet_T.id+")";
    TR_MAIN.Post();
    
    if(strDataSet_T.CountRow == 0){
    	showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    	//strSNo.Text = "";
    	strENo.Text = "";
    	setTimeout(strSNo.id+".Focus()", 50);
        return;
    }
    
    // 기존 판매내역 확인
    var strTmp = "";
    for(var i=1;i<=strDataSet_T.CountRow;i++){
    	strTmp = strDataSet_T.NameValue(i, "GIFTCARD_NO");
    	for(var j=1;j<=strDataSet.CountRow;j++){
    		if(strTmp == strDataSet.NameValue(j, "GIFTCARD_NO")){
    			showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
    			strENo.Text = "";
                setTimeout(strENo.id+".Focus()", 50);
                return;
    		}
    	}
    }
   // strSNo.Text = "";
    strENo.Text = "";
    
    var strData = strDataSet_T.ExportData(1, strDataSet_T.CountRow, true);
    strDataSet.ImportData(strData);
    
    if(strGbn == "S"){
    	LC_STR.Enable = false;
    }
    
    if(strGbn == "S"){
         setTimeout("EM_S_GIFT_E_NO.Focus();",50);
     }else if(strGbn == "R"){
         setTimeout("EM_R_GIFT_E_NO.Focus();",50);
     }
}

/**
 * getGiftNoInfo(strObj, strGbn)
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 :  상품권 정보 조회
 * return값 : void
 */ 
function getGiftNoInfo(strObj, strGbn){
   // S : 판매용 상품권번호 조회, R : 회수용상품권 번호 조회
   
   // 회수용 상품권번호 조회 내용이 없는경우
   if(strGbn == "S" && DS_IO_RETURN.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "회수내역을 먼저 등록해 주세요.");
        strObj.Text = "";
        setTimeout("EM_R_GIFT_E_NO.Focus()", 50);
        return;
    }
	DS_O_GIFT_INFO.ClearData();
    var goTo       = "getGiftNoInfo";
    var parameters = "&strGiftNo=" + encodeURIComponent(strObj.Text)
                   + "&strStrCd="  + encodeURIComponent(LC_STR.BindColVal)
                   + "&strGbn="    + encodeURIComponent(strGbn); 
    TR_MAIN.Action   = "/mss/mgif304.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_GIFT_INFO=DS_O_GIFT_INFO)";
    TR_MAIN.Post();
    
    if(DS_O_GIFT_INFO.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
        strObj.Text = "";
        setTimeout(strObj.id+".Focus()", 50);
        return;
    }
    
    /*if(strObj.id == "EM_R_GIFT_S_NO" || strObj.id == "EM_S_GIFT_S_NO"){
    	DS_O_GIFT_CHECK.AddRow();
    	DS_O_GIFT_CHECK.NameValue(1, strGbn+"_GIFT_TYPE_CD") = DS_O_GIFT_INFO.NameValue(1,"GIFT_TYPE_CD");
    	DS_O_GIFT_CHECK.NameValue(1, strGbn+"_ISSUE_TYPE") = DS_O_GIFT_INFO.NameValue(1,"ISSUE_TYPE");
    	DS_O_GIFT_CHECK.NameValue(1, strGbn+"_GIFT_AMT_TYPE") = DS_O_GIFT_INFO.NameValue(1,"GIFT_AMT_TYPE");
    }else{
        if(strObj.id == "EM_R_GIFT_E_NO" && !CHK_RETURN_SINGLE.checked){
        	if((DS_O_GIFT_CHECK.NameValue(1, strGbn+"_GIFT_TYPE_CD") != DS_O_GIFT_INFO.NameValue(1,"GIFT_TYPE_CD"))
                    || (DS_O_GIFT_CHECK.NameValue(1, strGbn+"_ISSUE_TYPE") != DS_O_GIFT_INFO.NameValue(1,"ISSUE_TYPE"))
                    || (DS_O_GIFT_CHECK.NameValue(1, strGbn+"_GIFT_AMT_TYPE") != DS_O_GIFT_INFO.NameValue(1,"GIFT_AMT_TYPE"))){
                showMessage(EXCLAMATION, OK, "USER-1000", "금종을 확인해 주세요.");
                strObj.Text = "";
                setTimeout(strObj.id+".Focus()", 50);
                return;
            }
        }else if(strObj.id == "EM_S_GIFT_E_NO" && !CHK_SALE_SINGLE.checked){
        	if((DS_O_GIFT_CHECK.NameValue(1, strGbn+"_GIFT_TYPE_CD") != DS_O_GIFT_INFO.NameValue(1,"GIFT_TYPE_CD"))
                    || (DS_O_GIFT_CHECK.NameValue(1, strGbn+"_ISSUE_TYPE") != DS_O_GIFT_INFO.NameValue(1,"ISSUE_TYPE"))
                    || (DS_O_GIFT_CHECK.NameValue(1, strGbn+"_GIFT_AMT_TYPE") != DS_O_GIFT_INFO.NameValue(1,"GIFT_AMT_TYPE"))){
                showMessage(EXCLAMATION, OK, "USER-1000", "금종을 확인해 주세요.");
                strObj.Text = "";
                setTimeout(strObj.id+".Focus()", 50);
                return;
            }
        }
        
    	DS_O_GIFT_CHECK.ClearData();
    }*/
    getSaleInfo(strGbn);
}
/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 판매내역 삭제
 * return값 : void
 */ 
function delRow(strDs, strGrid){
	if(strDs.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1019");
		return;
	}
	var strCnt = strDs.CountRow;
	for(var i=1;i<=strCnt;i++){
    	if(strDs.NameValue(i,"FLAG") == "T"){
    		strDs.DeleteRow(i);     
    		i = i -1;
    	}
    }
	strGrid.ColumnProp('FLAG','HeadCheck')= "FALSE";
	
	if(strDs.id == "DS_IO_SALE" && strDs.CountRow == 0){
		LC_STR.Enable = true;
	}
}

/**
 * oz_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-05-09
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function oz_Print(pVal) {
	 //var params   = "&strSaleNo="+ pVal;
	 //window.open("/mss/mgif305.mg?goTo=print"+params, "OZREPORT", 1000, 700);     
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
        oz_Print(TR_MAIN.SrvErrMsg('UserMsg',i).substring(0,17));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_STR event=OnSelChange()>
if(DS_IO_RETURN.CountRow == 0) return;
</script>

<script language=JavaScript for=EM_SALE_DT event=OnKillFocus()>
if(this.Text < strToday){
    showMessage(EXCLAMATION, OK, "USER-1030", "판매일자");
    this.Text = strToday;
    this.Focus();
    return false;
}
return true;
</script>

<script language=JavaScript for=EM_R_GIFT_S_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout(this.id+".Focus()", 50);
    return;
}

// 기존 판매내역 확인
 for(var j=1;j<=DS_IO_RETURN.CountRow;j++){
     if(this.Text == DS_IO_RETURN.NameValue(j, "GIFTCARD_NO")){
         showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
         this.Text = "";
         setTimeout(this.id+".Focus()", 50);
         return false;
     }
 }
 
 getGiftNoInfo(this, "R");
return true;
</script>
<script language=JavaScript for=EM_R_GIFT_E_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout(this.id+".Focus()", 50);
    return;
}
/*
if(!CHK_RETURN_SINGLE.checked){
    if(EM_R_GIFT_S_NO.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권시작번호를 먼저 스캔해 주세요.");
        this.Text = "";
        setTimeout("EM_R_GIFT_S_NO.Focus()", 50);
        return;
    }

    if(this.Text < EM_R_GIFT_S_NO.Text){
        showMessage(EXCLAMATION, OK, "USER-1008", "종료번호", "시작번호");
        this.Text = "";
        setTimeout(this.id+".Focus()", 50);
        return;
    }
}*/
getGiftNoInfo(this, "R");
</script>
<script language=JavaScript for=EM_S_GIFT_S_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout(this.id+".Focus()", 50);
    return;
}

// 기존 판매내역 확인
 for(var j=1;j<=DS_IO_SALE.CountRow;j++){
     if(this.Text == DS_IO_SALE.NameValue(j, "GIFTCARD_NO")){
         showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
         this.Text = "";
         setTimeout(this.id+".Focus()", 50);
         return false;
     }
 }
 
 getGiftNoInfo(this, "S");
return true;
</script>
<script language=JavaScript for=EM_S_GIFT_E_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout(this.id+".Focus()", 50);
    return;
}
/*
if(!CHK_SALE_SINGLE.checked){
    if(EM_S_GIFT_S_NO.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권시작번호를 먼저 스캔해 주세요.");
        this.Text = "";
        setTimeout("EM_S_GIFT_S_NO.Focus()", 50);
        return;
    }

    if(this.Text < EM_S_GIFT_S_NO.Text){
        showMessage(EXCLAMATION, OK, "USER-1008", "종료번호", "시작번호");
        this.Text = "";
        setTimeout(this.id+".Focus()", 50);
        return;
    }
}*/
getGiftNoInfo(this, "S");
</script>

<script language="javascript"  for=GD_RETURN event=OnHeadCheckClick(Col,Colid,bCheck)>
	var strFlag = "";
	if(bCheck == 1){
		strFlag = "T";
	}else{
		strFlag = "F";
	}
	for(var i=1;i<=DS_IO_RETURN.CountRow;i++){
		DS_IO_RETURN.NameValue(i,"FLAG") = strFlag;
	}
</script>

<script language="javascript"  for=GD_SALE event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_SALE.CountRow;i++){
        DS_IO_SALE.NameValue(i,"FLAG") = strFlag;
    }
</script>
<script language=JavaScript for=GD_RETURN event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_SALE event=OnClick(row,colid)>
    //정렬
    if (row == 0) sortColId(eval(this.DataID), row, colid);
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
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>   
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_RETURN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_RETURN_T"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_SALE_T"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>   
<comment id="_NSID_"><object id="DS_O_GIFT_CHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>  
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_SALE");
    
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
<input type="hidden" id="HID_S_GIFT_TYPE">
<input type="hidden" id="HID_S_ISSUE_TYPE">
<input type="hidden" id="HID_S_GIFT_AMT">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table" >
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" class="point">점</th>
            <td width="150">
                   <comment id="_NSID_">
                   <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=149 tabindex=1 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
            <th width="100" class="point">일자</th>
            <td  width="150">
                <comment id="_NSID_">
                  <object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=125 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT)" align="absmiddle" />
            </td>
            <th width="100">등록자</th>
            <td>
                  <comment id="_NSID_">
                  <object id=EM_USER_NM classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1>
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
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="PB05">
        <tr>
             <td class="sub_title" width="100"><img
                 src="/pot/imgs/comm/ring_blue.gif" class="PR03"
                 align="absmiddle" />회수내역</td>
         </tr>
        <tr>
            <td>
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="150">회수 상품권 번호</th>
                <td >
                   <comment id="_NSID_"><object id=EM_R_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
          <!--   <tr>
                <th width="100">시작번호</th>
                <td width="160">
                <comment id="_NSID_"><object id=EM_R_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="100">종료번호</th>
                <td width="160">
                   <comment id="_NSID_"><object id=EM_R_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                  <th  width="100">개별 등록</th>
                <td width="20">
                <input type="checkbox" id=CHK_RETURN_SINGLE align="absmiddle" onclick="javascript:onSingle('R');" tabindex=1 > 
                </td>
            </tr>
             -->
           </table>
            </td>
            <td class="right" valign="bottom">
            <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:delRow(DS_IO_RETURN, GD_RETURN);" />
            </td>
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
          <comment id="_NSID_"><OBJECT id=GD_RETURN width=100% height=320 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_RETURN">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
     <tr><td class="dot"></td></tr>
  <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="PB05">
        <tr>
             <td class="sub_title" width="100"><img
                 src="/pot/imgs/comm/ring_blue.gif" class="PR03"
                 align="absmiddle" />판매내역</td>
         </tr>
        <tr>
            <td>
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="150">판매 상품권 번호</th>
                <td>
                   <comment id="_NSID_"><object id=EM_S_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
            <!--
             <tr>
                <th width="100">시작번호</th>
                <td width="160">
                <comment id="_NSID_"><object id=EM_S_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="100">종료번호</th>
                <td width="160">
                   <comment id="_NSID_"><object id=EM_S_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=158 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                  <th  width="100">개별 등록</th>
                <td width="20">
                <input type="checkbox" id=CHK_SALE_SINGLE align="absmiddle" onclick="javascript:onSingle('S');" tabindex=1 > 
                </td>
            </tr> 
             -->
           </table>
            </td>
            <td class="right" valign="bottom">
            <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:delRow(DS_IO_SALE, GD_SALE);" />
            </td>
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
          <comment id="_NSID_"><OBJECT id=GD_SALE width=100% height=350 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_SALE">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
</table>
</DIV>
</body>
</html>

