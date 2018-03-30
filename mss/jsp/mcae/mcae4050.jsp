<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > POS 사은품 회수관리
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE4050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
 *        2011.03.14 (김성미) 프로그램 작성
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var btnSaveClick = false;
var strCurRow = 0;
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
 var top = 375;		//해당화면의 동적그리드top위치
 var top2 = 530;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_PRSNTRECP"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	var obj   = document.getElementById("GD_GIFT"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";


    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터    
    gridCreate2();
    gridCreate3();
    
    // EMedit에 초기화
    initEmEdit(EM_POS_CD, "NUMBER3^4", NORMAL);        //POS코드
    initEmEdit(EM_POS_NM, "GEN", READ);           //POS명
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);         //영수증일자S
    initEmEdit(EM_E_DT, "TODAY", PK);         //영수증일자E
    initEmEdit(EM_NDRAWL_RSN, "GEN^100", NORMAL);          //미반납사유
    initEmEdit(EM_REMARK, "GEN^100", NORMAL);         //적요
    initEmEdit(EM_PAY_AMT, "NUMBER^12^0", READ);             //대납금액
    initEmEdit(EM_APPR_CHAR_ID, "GEN^10", READ);         //승인자코드
    initEmEdit(EM_APPR_CHAR_NM, "GEN", READ);         //승인자명

    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_DRAWLFLAG,DS_O_DRAWLFLAG, "CODE^0^30,NAME^0^80", 1, READ);      //사은품회수구분
    initComboStyle(LC_NDRAWL_RSN_CD,DS_O_NDRAWL_RSN_CD, "CODE^0^30,NAME^0^80", 1, READ);      //미반납 사유코드
    initComboStyle(LC_S_FLOR,DS_O_FLOR_CD, "CODE^0^30,NAME^0^70", 1, NORMAL);  //층
    
    getEtcCode("DS_O_GDRAWLFLAG",   "D", "M064", "N", "N");
    getEtcCode("DS_O_DRAWLFLAG",   "D", "M064", "N", "N", LC_DRAWLFLAG);
    getEtcCode("DS_O_NDRAWL_RSN_CD",   "D", "M005", "N", "N", LC_NDRAWL_RSN_CD);
    getEtcCode("DS_O_FLOR_CD", "D", "P061", "Y", "N", LC_S_FLOR);
    
    getStore("DS_O_STR", "Y", "1", "N");
    LC_NDRAWL_RSN_CD.Text = "";
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();
}



function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=STR_NM      name="점"           width=70   align=left  </FC>'
			        + '<FC>id=FLOR_NM    name="층"       width=50  align=left</FC>'
                    + '<FC>id=POS_NO    name="POS"       width=60  align=center</FC>'
                    + '<FC>id=RECEIPT_NO    name="취소영수증"       width=160 mask="XX-XXXXXXXX-XXXX-XXXXX" align=left</FC>'
                    + '<FC>id=SKU_NM    name="지급사은품"  sumtext="합계"     width=80  align=left</FC>'
                    + '<FC>id=PRSNT_AMT    name="매입원가"       width=90  align=right</FC>'
                    + '<FC>id=DIV_AMT    name="지급안분금액"  show=false     width=90  align=right</FC>'
                    + '<FC>id=DRAWLFLAG    name="회수구분"   EditStyle=Lookup   Data="DS_O_GDRAWLFLAG:CODE:NAME"    width=70  align=left</FC>'
                    + '<FC>id=PAY_AMT    name="대납금액"    sumtext=@sum   width=90  align=right</FC>'
                    + '<FC>id=PROC_STAT_NM    name="처리여부"    sumtext=@sum   width=90  align=left</FC>';
                     
    initGridStyle(GD_POSRECOVERY, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=STR_NM    name="점"       width=90  align=left</FC>'
			        + '<FC>id=SALE_DT    name="영수증일자"  mask="XXXX/XX/XX"   width=80   align=center</FC>'
			        + '<FC>id=POS_NO    name="POS_NO"       width=70  align=CENTER</FC>'
			        + '<FC>id=TRAN_NO    name="영수증번호"       width=70  align=center</FC>'
                    + '<FC>id=SALE_AMT    name="인정금액"       width=70  align=right</FC>'
                    + '<FC>id=DIV_AMT    name="지급안분금액"       width=80  align=right</FC>';
                     
    initGridStyle(GD_PRSNTRECP, "common", hdrProperies2, false);
}

function gridCreate3(){
    var hdrProperies3 ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                    + '<FC>id=GIFT_NAME    name="회수"       width=60  align=left</FC>'
                    + '<FC>id=PAY_QTY    name="수량"       width=60  align=right</FC>'
                    + '<FC>id=PAY_AMT    name="금액"       width=80  align=right</FC>';
                     
    initGridStyle(GD_GIFT, "common", hdrProperies3, false);
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
 * 작 성 일 : 2011-03-14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_S_STR.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR.focus();
        return;
    }
    if(EM_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_DT.focus();
        return;
    }else if(EM_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_E_DT.focus();
        return;
    }else if(EM_S_DT.Text > EM_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.focus();
        return;
    }

    DS_IO_POSRECOVERY.ClearData();
    DS_O_PRSNTRECP.ClearData();
    
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;
    var strSdt          = EM_S_DT.Text;
    var strEdt          = EM_E_DT.Text;
    var strFlorCd          = LC_S_FLOR.BindColVal;
    var strPosCd          = EM_POS_CD.Text;
    
    var goTo       = "getPosRecovery" ;    
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
                   + "&strSdt="   + encodeURIComponent(strSdt)
                   + "&strEdt="   + encodeURIComponent(strEdt)
                   + "&strFlorCd="+ encodeURIComponent(strFlorCd)
                   + "&strPosCd=" + encodeURIComponent(strPosCd);
    btnSaveClick = true;
    TR_MAIN.Action="/mss/mcae405.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_POSRECOVERY=DS_IO_POSRECOVERY)"; //조회는 O
    TR_MAIN.Post();
    btnSaveClick = false;
    if(DS_IO_POSRECOVERY.CountRow > 0){
    	if(strCurRow >0)DS_IO_POSRECOVERY.RowPosition = strCurRow;
    	getPsntRecp();
    	getGiftList();
    }
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_POSRECOVERY.CountRow);
    
    GD_POSRECOVERY.Focus();
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
 * 작 성 일 : 2011-03-14
 * 개    요 : 사은품 회수 저장
 * return값 : void
 */
function btn_Save() {
 // 저장할 데이터 없는 경우
   if (DS_IO_POSRECOVERY.CountRow == 0){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION , OK, "USER-1028");
       return;
   }
 
   if (DS_IO_POSRECOVERY.NameValue(DS_IO_POSRECOVERY.RowPosition, "PROC_STAT") == "1" 
		   && !DS_IO_POSRECOVERY.IsUpdated ){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION , OK, "USER-1028");
       return;
   }
	
	var strReceiptNo = DS_IO_POSRECOVERY.NameValue(DS_IO_POSRECOVERY.RowPosition, "RECEIPT_NO");
    strReceiptNo = strReceiptNo.substring(0,2) + "-" 
                 + strReceiptNo.substring(2,6) 
                 + strReceiptNo.substring(6,8) 
                 + strReceiptNo.substring(8,10)+ "-"
                 + strReceiptNo.substring(10,14) + "-"
                 + strReceiptNo.substring(14,19);
    
    var strStrCd       = strReceiptNo.substring(1,3);
    var strSaleDt      = strReceiptNo.substring(3,11);
    var strPosNo       = strReceiptNo.substring(11,15);
    var strTranNo      = strReceiptNo.substring(15,20);
    
    if(showMessage(QUESTION , YESNO, "GAUCE-1000", strReceiptNo + "번 영수증을  저장하시겠습니까?") != 1 ){
        return;
    }
    
    DS_IO_POSRECOVERY.UserStatus(DS_IO_POSRECOVERY.RowPosition) = 1; 
    for(var i=1;i<=DS_O_PRSNTRECP.CountRow;i++){
    	DS_O_PRSNTRECP.UserStatus(i) = 1; 
    }
    btnSaveClick = true;
    strCurRow = DS_IO_POSRECOVERY.RowPosition;
    TR_MAIN.Action="/mss/mcae405.mc?goTo=save"; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_POSRECOVERY=DS_IO_POSRECOVERY,I:DS_O_PRSNTRECP=DS_O_PRSNTRECP)"; //조회는 O
    TR_MAIN.Post();
    btnSaveClick = false;
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
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
	    var ExcelTitle = "POS 사은품회수관리";
	        openExcel2(GD_POSRECOVERY, ExcelTitle, "", true );
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
  * getPsntRecp()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-14
  * 개    요 : 합산 영수증 정보 조회
  * return값 : void
  */
 function getPsntRecp() {
	 if(DS_IO_POSRECOVERY.CountRow ==0){  // 회수정보 조회 내역 여부 
	        showMessage(EXCLAMATION , OK, "USER-1001", "점");
	        return;
	    }

	    var row = DS_IO_POSRECOVERY.RowPosition;
	    var goTo       = "getPsntRecp" ;    
	    var parameters = "&strStrCd="  + encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "STR_CD"))
	                   + "&strPrsntDt="+ encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "PRSNT_DT"))
	                   + "&strPrsntNo="+ encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "PRSNT_NO"));
	    TR_MAIN.Action="/mss/mcae405.mc?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET(O:DS_O_PRSNTRECP=DS_O_PRSNTRECP)"; //조회는 O
	    TR_MAIN.Post();
 }
 
 /**
  * getGiftList()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-14
  * 개    요 : 사은품 정보 조회
  * return값 : void
  */
 function getGiftList() {
     if(DS_IO_POSRECOVERY.CountRow ==0){  // 회수정보 조회 내역 여부 
            showMessage(EXCLAMATION , OK, "USER-1001", "점");
            return;
        }

        var row = DS_IO_POSRECOVERY.RowPosition;
        var goTo       = "getGiftList" ;    
        var parameters = "&strSaleDt=" +encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "SALE_DT"))
                       + "&strStrCd="  +encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "STR_CD"))
                       + "&strPosNo="  +encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "POS_NO"))
                       + "&strTranNo=" +encodeURIComponent(DS_IO_POSRECOVERY.NameValue(row, "TRAN_NO"));
        TR_MAIN.Action="/mss/mcae405.mc?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET(O:DS_O_GIFT=DS_O_GIFT)"; //조회는 O
        TR_MAIN.Post();
        if(DS_IO_POSRECOVERY.NameValue(DS_IO_POSRECOVERY.RowPosition, "DRAWLFLAG") == "1"
        		|| DS_IO_POSRECOVERY.NameValue(DS_IO_POSRECOVERY.RowPosition, "DRAWLFLAG") == "2" ) LC_NDRAWL_RSN_CD.Enable =  false;
        else LC_NDRAWL_RSN_CD.Enable =  true;
        
 }
 
 /**
  * openPosPop()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-15
  * 개    요 : 포스팝업 오픈
  * return값 : void
  */
 function openPosPop() {
	
	  if(LC_S_FLOR.BindColVal == ""){
		  showMessage(EXCLAMATION , OK, "USER-1001", "층");
		  LC_S_FLOR.Focus();
		  return;
	  }
	  
	  posNoPop(EM_POS_CD,EM_POS_NM,LC_S_STR.BindColVal,LC_S_FLOR.BindColVal);
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_POSRECOVERY event=CanRowPosChange(row)>
 if(DS_IO_POSRECOVERY.IsUpdated && !btnSaveClick){
         if(showMessage(EXCLAMATION , YESNO, "USER-1074") != 1 ){
             return false;
         }
         DS_IO_POSRECOVERY.NameValue(row,"NDRAWL_RSN_CD") = DS_IO_POSRECOVERY.OrgNameValue(row,"NDRAWL_RSN_CD");
         DS_IO_POSRECOVERY.NameValue(row,"NDRAWL_RSN") = DS_IO_POSRECOVERY.OrgNameValue(row,"NDRAWL_RSN");
         DS_IO_POSRECOVERY.NameValue(row,"REMARK") = DS_IO_POSRECOVERY.OrgNameValue(row,"REMARK");
         return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_POSRECOVERY event=OnRowPosChanged(row)>
if(clickSORT)
    return;
if(row == 0) return;
if(btnSaveClick) return;
getPsntRecp();
getGiftList();
</script>
<script language=JavaScript for=DS_O_PRSNTRECP event=OnRowPosChanged(row)>
if(clickSORT)
    return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_POSRECOVERY event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_PRSNTRECP event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<!-- 포스 조회 -->
<script language=JavaScript for=EM_POS_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_POS_CD.Text ==""){
	EM_POS_NM.Text = "";
       return;
   }

   if(EM_POS_CD.Text != null){
        if(EM_POS_CD.Text.length > 0){
        	if(LC_S_FLOR.BindColVal == ""){
                showMessage(EXCLAMATION , OK, "USER-1001", "층");
                EM_POS_CD.Text = "";
                LC_S_FLOR.Focus();
                return;
            }
        	setPosNoNmWithoutPop("DS_O_RESULT", EM_POS_CD, EM_POS_NM , 1, LC_S_STR.BindColVal, LC_S_FLOR.BindColVal);
        	if(DS_O_RESULT.CountRow == 1){
        		EM_POS_CD.Text = DS_O_RESULT.NameValue(1, "POS_NO");
        		EM_POS_NM.Text = DS_O_RESULT.NameValue(1, "POS_NAME");
        	}
        }
    } 
</script>

<script language=JavaScript for=LC_S_STR event=OnSelChange()>
EM_POS_CD.Text = "";
EM_POS_NM.Text = ""; 
</script>

<script language=JavaScript for=LC_S_FLOR event=OnSelChange()>
EM_POS_CD.Text = "";
EM_POS_NM.Text = ""; 
</script>

<script language=JavaScript for=EM_NDRAWL_RSN event=onKillFocus()>
//checkByteStr(this, 100, 'Y');
</script>

<script language=JavaScript for=EM_REMARK event=onKillFocus()>
//checkByteStr(this, 100, 'Y');
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
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GDRAWLFLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DRAWLFLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_NDRAWL_RSN_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_FLOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_POSRECOVERY"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PRSNTRECP"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
	
    var obj   = document.getElementById("GD_PRSNTRECP");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_GIFT");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2+150) {
    	grd_height = top;    	
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

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
	          <th width="80" class="point">점</th>
	          <td width="140" >
	              <comment id="_NSID_">
                      <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=140 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>    
	          </td>
	          <th width="80">층</th>
	          <td width="140"> 
	               <comment id="_NSID_">
                      <object id=LC_S_FLOR classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=140 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>    
	          </td>  
	          <th width="80">POS</th>
	          <td>
	              <comment id="_NSID_">
	                      <object id=EM_POS_CD classid=<%= Util.CLSID_EMEDIT %> width=60 tabindex=1 align="absmiddle">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>  
	              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:openPosPop();"  align="absmiddle"/>
	              <comment id="_NSID_">
                          <object id=EM_POS_NM classid=<%= Util.CLSID_EMEDIT %> width=130 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>  
	          </td>
	      </tr>
	      <tr>
	          <th class="point">영수증일자</th>
              <td colspan="5" align="absmiddle">
                  <comment id="_NSID_">
                          <object id=EM_S_DT classid=<%= Util.CLSID_EMEDIT %> onblur="javascript:checkDateTypeYMD(this);" width=140 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT)" /> 
                  ~
                  <comment id="_NSID_">
                          <object id=EM_E_DT classid=<%= Util.CLSID_EMEDIT %> onblur="javascript:checkDateTypeYMD(this);" width=140 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" />      
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
   <td width="100%"  class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">          
     <tr>             
       <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
         <tr>
           <td>
                <comment id="_NSID_"><OBJECT id=GD_POSRECOVERY width=100% height=223 classid=<%=Util.CLSID_GRID%>>
               <param name="DataID" value="DS_IO_POSRECOVERY">
               <Param Name="ViewSummary"   value="1" >
               </OBJECT></comment><script>_ws_(_NSID_);</script>
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
   <td width="100%" ><table width="100%" border="0" cellspacing="0" cellpadding="0">          
     <tr>
       <td ><table width="520" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="sub_title">
                 <img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle" class="PR03"/>합산 영수증 정보</td>                
             </tr>
           </table></td>
         </tr>   
         <tr>           
           <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
             <tr>
               <td>
                   <comment id="_NSID_"><OBJECT id=GD_PRSNTRECP width=100% height=232 classid=<%=Util.CLSID_GRID%>>
                   <param name="DataID" value="DS_O_PRSNTRECP">
                   </OBJECT></comment><script>_ws_(_NSID_);</script>
               </td>  
             </tr>
           </table></td>
          </tr>          
        </table></td>
         <td width="100%" valign="top" class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="sub_title">
                 <img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle" />미반납 사유</td>                
             </tr>
           </table></td>
         </tr>   
         <tr>           
           <td><table width="100%" border="1" cellspacing="0" cellpadding="0" class="s_table">
             <tr>
               <th width="90" >사은품회수구분</th>
               <td >
                  <comment id="_NSID_">
                        <object id=LC_DRAWLFLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100%  tabindex=1 width=190 align="absmiddle">
                        </object>
                  </comment><script>_ws_(_NSID_);</script>
               </td> 
             </tr>
             <tr>
               <th width="90" >미반납 사유코드</th>
               <td >
                  <comment id="_NSID_">
                        <object id=LC_NDRAWL_RSN_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100% tabindex=1 width=190 align="absmiddle">
                        </object>
                  </comment><script>_ws_(_NSID_);</script>
               </td> 
             </tr>
             <tr>
               <th width="90" >미반납 사유</th>
               <td >
                  <comment id="_NSID_">
                      <object id=EM_NDRAWL_RSN classid=<%= Util.CLSID_EMEDIT %> 
                            onkeyup="javascript:checkByteStr(this, 100, 'Y');" width=190 tabindex=1 align="absmiddle" >
                      </object>
                  </comment><script>_ws_(_NSID_);</script> 
               </td> 
             </tr>
             <tr>
               <th width="90">적요</th>
               <td >
                  <comment id="_NSID_">
                      <object id=EM_REMARK classid=<%= Util.CLSID_EMEDIT %> 
                        onkeyup="javascript:checkByteStr(this, 100, 'Y');" width=190 tabindex=1 align="absmiddle" >
                      </object>
                  </comment><script>_ws_(_NSID_);</script> 
               </td> 
             </tr>
             <tr>
               <th width="90">대납금액</th>
               <td >
                  <comment id="_NSID_">
                      <object id=EM_PAY_AMT classid=<%= Util.CLSID_EMEDIT %> width=190 tabindex=1 align="absmiddle" >
                      </object>
                  </comment><script>_ws_(_NSID_);</script> 
               </td> 
             </tr>
             <tr>
               <th width="90">승인자</th>
               <td >
                  <comment id="_NSID_">
                      <object id=EM_APPR_CHAR_ID classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=1 align="absmiddle" >
                      </object>
                  </comment><script>_ws_(_NSID_);</script>  
                  <comment id="_NSID_">
                      <object id=EM_APPR_CHAR_NM classid=<%= Util.CLSID_EMEDIT %> width=107 tabindex=1 align="absmiddle" >
                      </object>
                  </comment><script>_ws_(_NSID_);</script> 
               </td> 
             </tr>
           </table></td>
          </tr>  
          <tr>
          <td class="PT05">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
             <tr>
               <td>
                   <comment id="_NSID_"><OBJECT id=GD_GIFT width=100% height=75 classid=<%=Util.CLSID_GRID%>>
                   <param name="DataID" value="DS_O_GIFT">
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
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_POSRECOVERY classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_POSRECOVERY>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=DRAWLFLAG        Ctrl=LC_DRAWLFLAG           param=BindColVal</c>
        <c>Col=NDRAWL_RSN_CD    Ctrl=LC_NDRAWL_RSN_CD       param=BindColVal</c>
        <c>Col=NDRAWL_RSN       Ctrl=EM_NDRAWL_RSN          param=Text</c>
        <c>Col=REMARK           Ctrl=EM_REMARK              param=Text</c>
        <c>Col=PAY_AMT          Ctrl=EM_PAY_AMT             param=Text</c>
        <c>Col=APPR_CHAR_ID     Ctrl=EM_APPR_CHAR_ID        param=Text</c>
        <c>Col=APPR_CHAR_NM     Ctrl=EM_APPR_CHAR_NM        param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

