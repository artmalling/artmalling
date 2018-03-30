<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 상품권 특판등록
 * 작 성 일 : 2011.05.19
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 특판 등록
 * 이    력 :
 *        2011.05.19 (김정민) 프로그램 작성
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
 var top = 210;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT, "TODAY", PK);                    // 판매일자
    initEmEdit(EM_TOT_AMT, "NUMBER^12^0", READ);            // 결제금액
    initEmEdit(EM_GIFT_S_NO, "GEN^18", NORMAL);         // 시작번호
    initEmEdit(EM_GIFT_E_NO, "GEN^18", NORMAL);         // 종료번호
    initEmEdit(EM_REMARK, "GEN^50", NORMAL);            // 적요    
    //initEmEdit(EM_GIFT_S_NO, "NUMBER3^18", NORMAL);         // 시작번호
    //initEmEdit(EM_GIFT_E_NO, "NUMBER3^18", NORMAL);         // 종료번호
    initEmEdit(EM_USER_NM,  "GEN", READ);                   // 등록자
    initEmEdit(EM_PUM_NO,   "GEN^20", PK);                   // 등록자
    
    initEmEdit(EM_I_ORG_CD,     "GEN^10",  NORMAL);         //신청부서코드
    initEmEdit(EM_I_ORG_NAME,   "GEN^40", READ);           //신청부서명    
   
    //콤보 초기화
    initComboStyle(LC_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                  //점

    getStore("DS_O_S_STR", "Y", "", "N");
    DS_O_S_STR.Filter();     //점구분 : 매정점만 셋팅
    EM_USER_NM.Text = strUserNM;
    strToday   = getTodayDB("DS_O_RESULT");
    EM_SALE_DT.Text = strToday;
    LC_STR.Index = 0;
    LC_STR.Focus();
    
	//CHK_SINGLE.checked
    CHK_SINGLE.checked=true;
    CHK_SINGLE.disabled=true;
    setNew();	    

    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif302", "DS_IO_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            name="NO"         width=25   align=center</FC>' 
                     + '<FC>id=GIFT_TYPE_NAME      name="상품권명" SumText="합계"  width=100   align=left</FC>' 
                     + '<FC>id=ISSUE_TYPE          name="ISSUE_TYPE"    width=100  show=false align=left</FC>' 
                     + '<FC>id=GIFT_AMT_TYPE      name="GIFT_AMT_TYPE"    width=100 show=false  align=left</FC>' 
                     + '<FC>id=GIFTCERT_AMT        name="상품권금액"    width=100  align=right</FC>'
                     + '<FC>id=GIFTCARD_NO         name="상품권코드"   width=180   align=center</FC>'
                     + '<FC>id=QTY                 name="수량"  edit=none SumText="@sum"  width=70   align=right</FC>'
                     + '<FC>id=AMT                 name="판매금액" edit=none  SumText="@sum"  width=100   align=right</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
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
      if((DS_IO_MASTER.CountRow > 0) && (showMessage(QUESTION , YESNO, "USER-1085") != 1)){
          return;
      }

	  EM_I_ORG_CD.Text = "";
	  EM_I_ORG_NAME.Text = "";
	  
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
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    if(EM_I_ORG_CD.Text == "") {
    	showMessage(INFORMATION, OK, "USER-1000", "판매부서를 반드시 입력 하셔야 합니다.");
        setTimeout("EM_I_ORG_CD.Focus();", 50); 
        return;
    }
    
    if(EM_SALE_DT.Text < strToday){
        showMessage(EXCLAMATION, OK, "USER-1030", "판매일자");
        EM_SALE_DT.Text = strToday;
        EM_SALE_DT.Focus();
        return false;
    }
    
    if(EM_PUM_NO.Text == "") {
    	 showMessage(EXCLAMATION, OK, "USER-1000", "품의서 번호를 입력해야 합니다.");
    	 setTimeout("EM_PUM_NO.Focus()", 50);
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
 
 // 마감체크 (common.js) : 월마감
    if( getCloseCheck('DS_CLOSECHECK'
                      , LC_STR.BindColVal
                      , EM_SALE_DT.Text
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        EM_SALE_DT.Focus();
        return;
    }
 
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    
    var strOrgCd    = EM_I_ORG_CD.Text;           // 판매부서
    
    var strParam = "&strSaleDt="  + encodeURIComponent(EM_SALE_DT.Text)
                 + "&strStrCd="   + encodeURIComponent(LC_STR.BindColVal)
                 + "&strPartCd="  + encodeURIComponent(strOrgCd)
                 + "&strSaleAmt=" + encodeURIComponent(EM_TOT_AMT.Text)
                 + "&strPumNo="   + encodeURIComponent(EM_PUM_NO.Text)
                 + "&strRemark="  + encodeURIComponent(EM_REMARK.Text);
    
    TR_MAIN.Action="/mss/mgif302.mg?goTo=save"+strParam;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
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

 function setNew(){
     EM_GIFT_S_NO.Text = "";
     EM_GIFT_E_NO.Text = "";
     EM_TOT_AMT.Text = "";
     EM_PUM_NO.Text = "";
     EM_REMARK.Text = "";
   //  CHK_SINGLE.checked = false;
     LC_STR.Enable = true;
     DS_IO_MASTER.ClearData();
     DS_IO_MASTER_T.ClearData();
   //  if(flag) LC_STR.Index = 0;
     EM_SALE_DT.Text = strToday;
//   LC_STR.Focus();
     if(CHK_SINGLE.checked){
         EM_GIFT_S_NO.Enable = false;
         setTimeout("EM_GIFT_E_NO.Focus();",50);
     }else{
         EM_GIFT_S_NO.Enable = true;
         setTimeout("EM_GIFT_S_NO.Focus();",50);
     }
}
/**
 * onSingle()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 한장씩 판매 등록
 * return값 : void
 */ 
function onSingle(){
    if(CHK_SINGLE.checked){
        EM_GIFT_S_NO.Text = "";
        EM_GIFT_S_NO.Enable = false;
    }else{
        EM_GIFT_E_NO.Text = "";
        EM_GIFT_S_NO.Enable = true;
    }
}

/**
 * getSaleInfo()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 판매내역 등록
 * return값 : void
 */ 
function getSaleInfo(){
    if(CHK_SINGLE.checked){ // 한장씩 판매 등록하는경우 
        if (EM_GIFT_E_NO.Text == ""){  //기간
            showMessage(EXCLAMATION, OK, "USER-1003", "상품권번호");
            EM_GIFT_E_NO.Focus()
            return;
        }
         
    }else{
         if (EM_GIFT_S_NO.Text == ""){  //기간
             showMessage(EXCLAMATION, OK, "USER-1003", "시작번호");
             EM_GIFT_S_NO.Focus()
             return;
         }
         
         if (EM_GIFT_E_NO.Text == ""){  //기간
             showMessage(EXCLAMATION, OK, "USER-1003", "종료번호");
             EM_GIFT_E_NO.Focus()
             return;
         }
         
         if (EM_GIFT_S_NO.Text > EM_GIFT_E_NO.Text){  //기간
            showMessage(EXCLAMATION, OK, "USER-1008", "종료번호", "시작번호");
            EM_GIFT_E_NO.Focus()
            return;
        }
    }
    DS_IO_MASTER_T.ClearData();
    var goTo       = "getSaleInfo";
    var parameters = "&strGiftSNo=" + encodeURIComponent(EM_GIFT_S_NO.Text) 
                   + "&strGiftENo=" + encodeURIComponent(EM_GIFT_E_NO.Text) ; 
    TR_MAIN.Action   = "/mss/mgif302.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER_T=DS_IO_MASTER_T)";
    TR_MAIN.Post();
    
    if(DS_IO_MASTER_T.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
        EM_GIFT_S_NO.Text = "";
        EM_GIFT_E_NO.Text = "";
        setTimeout("EM_GIFT_S_NO.Focus()", 50);
        return;
    }
    
    // 기존 판매내역 확인
    var strTmp = "";
    for(var i=1;i<=DS_IO_MASTER_T.CountRow;i++){
        strTmp = DS_IO_MASTER_T.NameValue(i, "GIFTCARD_NO");
        for(var j=1;j<=DS_IO_MASTER.CountRow;j++){
            if(strTmp == DS_IO_MASTER.NameValue(j, "GIFTCARD_NO")){
                showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
                EM_GIFT_E_NO.Text = "";
                setTimeout("EM_GIFT_E_NO.Focus()", 50);
                return;
            }
        }
    }
    
    EM_GIFT_S_NO.Text = "";
    EM_GIFT_E_NO.Text = "";
    
    var strData = DS_IO_MASTER_T.ExportData(1, DS_IO_MASTER_T.CountRow, true);
    LC_STR.Enable = false;
    DS_IO_MASTER.ImportData(strData);
    getSum();
}

/**
 * getGiftNoInfo()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 판매내역 등록
 * return값 : void
 */ 
function getGiftNoInfo(strObj){
	 
	 if(EM_PUM_NO.Text == "") { 
	        showMessage(EXCLAMATION, OK, "USER-1000", "품의서 번호를 입력 후 상품권코드를 입력하세요");
	        EM_PUM_NO.Text = "";
	        strObj.Text = "";
	        setTimeout("EM_PUM_NO.Focus()", 50);
	        return;
	 } 
    DS_O_GIFT_INFO.ClearData();
    var goTo       = "getGiftNoInfo";
    var parameters = "&strGiftNo=" + encodeURIComponent(strObj.Text)
                   + "&strStrCd="  + encodeURIComponent(LC_STR.BindColVal); 
    TR_MAIN.Action   = "/mss/mgif302.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_GIFT_INFO=DS_O_GIFT_INFO)";
    TR_MAIN.Post();
    
    if(DS_O_GIFT_INFO.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
        strObj.Text = "";
        setTimeout(strObj.id+".Focus()", 50);
        return;
    }
    
    if(strObj.id == "EM_GIFT_S_NO"){
        HID_S_GIFT_TYPE.Value = DS_O_GIFT_INFO.NameValue(1,"GIFT_TYPE_CD");
        HID_S_ISSUE_TYPE.Value = DS_O_GIFT_INFO.NameValue(1,"ISSUE_TYPE");
        HID_S_GIFT_AMT.Value = DS_O_GIFT_INFO.NameValue(1,"GIFT_AMT_TYPE");
    }else{
        if(!CHK_SINGLE.checked){
            if((HID_S_GIFT_TYPE.Value != DS_O_GIFT_INFO.NameValue(1,"GIFT_TYPE_CD"))
                    || (HID_S_ISSUE_TYPE.Value != DS_O_GIFT_INFO.NameValue(1,"ISSUE_TYPE"))
                    || (HID_S_GIFT_AMT.Value != DS_O_GIFT_INFO.NameValue(1,"GIFT_AMT_TYPE"))){
                showMessage(EXCLAMATION, OK, "USER-1000", "금종을 확인해 주세요.");
                strObj.Text = "";
                setTimeout(strObj.id+".Focus()", 50);
                return;
            }
        }
        
        // 기존 판매내역 확인
         for(var j=1;j<=DS_IO_MASTER.CountRow;j++){
             if(EM_GIFT_E_NO.Text == DS_IO_MASTER.NameValue(j, "GIFTCARD_NO")){
                 showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
                 EM_GIFT_E_NO.Text = "";
                 setTimeout("EM_GIFT_E_NO.Focus()", 50);
                 return;
             }
         }
        
        getSaleInfo();
    }
    
}
/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 판매내역 삭제
 * return값 : void
 */ 
function delRow(){
    if(DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    var strCnt = DS_IO_MASTER.CountRow;
    var strDelCnt = 0;

            DS_IO_MASTER.DeleteRow(i);     
            i = i -1;
    if(DS_IO_MASTER.CountRow == 0) LC_STR.Enable = true;
    getSum();
}

/**
 * getSum()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-09
 * 개    요 : 결제 금액 계산
 * return값 : void
 */ 
function getSum(){
    var strSum = 0 ;
    for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
        strSum += DS_IO_MASTER.NameValue(i,"AMT");
    }
    EM_TOT_AMT.Text = strSum;
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
<script language=JavaScript for=DS_O_S_STR event=OnFilter(row)>
if (DS_O_S_STR.NameValue(row, "GBN") == "1") {// 매장점
    return true;
}
return false;
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_STR event=OnSelChange()>
if(DS_IO_MASTER.CountRow == 0) return;
</script>

<script language=JavaScript for=EM_SALE_DT event=OnKillFocus()>
//if(DS_IO_MASTER.CountRow == 0) return false;
if(this.Text < strToday){
    showMessage(EXCLAMATION, OK, "USER-1030", "판매일자");
    this.Text = strToday;
    this.Focus();
    return false;
}
return true;
</script>
<script language=JavaScript for=EM_GIFT_S_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout("EM_GIFT_S_NO.Focus()", 50);
    return;
}
getGiftNoInfo(this);

// 기존 판매내역 확인
 for(var j=1;j<=DS_IO_MASTER.CountRow;j++){
     if(this.Text == DS_IO_MASTER.NameValue(j, "GIFTCARD_NO")){
         showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
         this.Text = "";
         setTimeout("EM_GIFT_S_NO.Focus()", 50);
         return;
     }
 }
return true;
</script>
<script language=JavaScript for=EM_GIFT_E_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 12 && this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout("EM_GIFT_E_NO.Focus()", 50);
    return;
}
if(!CHK_SINGLE.checked){
    if(EM_GIFT_S_NO.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권시작번호를 먼저 스캔해 주세요.");
        this.Text = "";
        setTimeout("EM_GIFT_S_NO.Focus()", 50);
        return;
    }

    if(this.Text < EM_GIFT_S_NO.Text){
        showMessage(EXCLAMATION, OK, "USER-1008", "종료번호", "시작번호");
        this.Text = "";
        setTimeout("EM_GIFT_E_NO.Focus()", 50);
        return;
    }
}

getGiftNoInfo(this);
</script>

<script language=JavaScript for=EM_PUM_NO event=OnKillFocus()>
//if(this.Text == "") return;
//if(this.Text.length != 20){
 //   showMessage(EXCLAMATION, OK, "USER-1000", "품의서 번호를 확인해 주세요.");
  //  this.Text = "";
   // setTimeout("EM_PUM_NO.Focus()", 50);
    //return;
//}
 
</script>

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
        DS_IO_MASTER.NameValue(i,"FLAG") = strFlag;
    }
</script>

<script language=JavaScript for=EM_I_ORG_CD event=onKillFocus()>
  //  if (EM_I_ORG_CD.Text.length > 0 ) { 
    	var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';

    	if(!this.Modified)
            return;
            
        if(this.text==''){
        	EM_I_ORG_NAME.Text = "";
            return;
        }
     
        if(LC_I_STR_CD.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_I_STR_CD.Focus();
            return;
        }
    
    	 setOrgNmWithoutPop("DS_O_RESULT", EM_I_ORG_CD, EM_I_ORG_NAME , 'Y', 0,strUserID,'','','','',LC_I_STR_CD.BindColVal); 
 
        if (DS_O_RESULT.CountRow == 1 ) {  
        //	alert();
        	EM_I_ORG_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "ORG_CD");
        	EM_I_ORG_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "ORG_NAME");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출 
            orgPop(EM_I_ORG_CD, EM_I_ORG_NAME,'Y');
        }
   // }  
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
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>   
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER_T"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_INFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>   
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
	
    var obj   = document.getElementById("GD_MASTER");
    
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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" class="point">점</th>
            <td width="160">
                   <comment id="_NSID_">
                   <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=149 tabindex=1 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
            <th width="100" class="point">판매일자</th>
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
          <tr>
            <th class="point">품의서번호</th>
                <td colspan="1">
                <comment id="_NSID_"><object id=EM_PUM_NO classid=<%=Util.CLSID_EMEDIT%>   width=148 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80" class="point">판매부서</th>
                    <td colspan="3">              
                        <comment id="_NSID_">
                               <object id=EM_I_ORG_CD classid=<%=Util.CLSID_EMEDIT%>   width=80 tabindex=1 align="absmiddle">
                               </object>
                         </comment><script>_ws_(_NSID_);</script>
                         <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" class="PR03"  onclick="javascript:orgPop(EM_I_ORG_CD, EM_I_ORG_NAME,'N')" id=popOrg /> 
                         <comment id="_NSID_">
                               <object id=EM_I_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>   width=148 tabindex=1 align="absmiddle">
                               </object>
                         </comment><script>_ws_(_NSID_);</script>
                    </td>						
					</tr>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th  width="100">결제금액</th>
                <td  width="150">
                <comment id="_NSID_"><object id=EM_TOT_AMT classid=<%=Util.CLSID_EMEDIT%>   width=148 tabindex=1  align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                 <th  width="100">개별 판매 등록</th>
                <td>
                <input type="checkbox" id=CHK_SINGLE align="absmiddle" onclick="javascript:onSingle();" tabindex=1 > 
                </td>
                
            </tr>
            <tr>
                <th>시작번호</th>
                <td>
                <comment id="_NSID_"><object id=EM_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=148 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                <th>종료번호</th>
                <td>
                   <comment id="_NSID_"><object id=EM_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=148 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                
            </tr>
            <tr>
                <th>적요</th>
                <td colspan="3">
                <comment id="_NSID_"><object id=EM_REMARK classid=<%=Util.CLSID_EMEDIT%>   width=420 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                
            </tr>
           </table>
            </td>
            <td class="right" valign="bottom">
            <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:delRow();" />
            </td>
        </tr>
        </table>
        </td>
    </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr height="5"><td></td></tr>
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
    <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=680 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_MASTER">
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

