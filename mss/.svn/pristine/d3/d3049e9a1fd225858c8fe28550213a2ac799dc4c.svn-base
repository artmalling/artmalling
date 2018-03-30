<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 약속관리 > 약속관리 > SMS발송관리
 * 작 성 일 : 2011.02.21
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : mpro1040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : SMS발송관리
 * 이    력 : 2011.02.21 (김유완) 수정개발
 *         
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정 
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 var g_toDate = getTodayFormat('YYYYMMDD');
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_DETAIL");
    
    //그리드 초기화
    gridCreate("mst"); //마스터
    gridCreate("dtl"); //디테일
    
    // EMedit에 초기화
    //조회
    initEmEdit(EM_SEARCH_S_DT, "SYYYYMMDD", PK);        //기간 시작일
    initEmEdit(EM_SEARCH_E_DT, "TODAY", PK);            //기간 종료일
    initEmEdit(EM_GUEST_NAME, "GEN^20^2", NORMAL);      //고객명
    EM_GUEST_NAME.Language = 1;

    //등록
    initEmEdit(EM_SEND_DT_I, "TODAY", READ);            //발송일자
    enableControl(IMG_SEND_DT_I,false);
    initEmEdit(EM_RECV_PH1_I, "NUMBER3^4^2", READ);     //수신번호
    initEmEdit(EM_RECV_PH2_I, "NUMBER3^4^2", READ);     //수신번호
    initEmEdit(EM_RECV_PH3_I, "NUMBER3^4^2", READ);     //수신번호
    initEmEdit(EM_SEND_PH1_I, "NUMBER3^4^2", READ);     //발신번호
    initEmEdit(EM_SEND_PH2_I, "NUMBER3^4^2", READ);     //발신번호
    initEmEdit(EM_SEND_PH3_I, "NUMBER3^4^2", READ);     //발신번호
    initComboStyle(LC_SEND_TYPE_I,DS_SEND_TYPE_I, "CODE^0^30,NAME^0^80", 1, READ);    //발송유형
    //initTxtAreaEdit(TXT_SEND_CONTENT_I, READ);          //비고
    initTxtAreaEdit(TXT_SEND_CONTENT_I, NORMAL);
    TXT_SEND_CONTENT_I.Enable    = false;  

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              //점(조회)
    initComboStyle(LC_SEARCH_FLAG,DS_SEARCH_FLAG, "CODE^0^30,NAME^0^80", 1, PK);    //조회구분
    initComboStyle(LC_PROM_TYPE,DS_PROM_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);    //약속유형
    //시스템 코드 공통코드에서 발행기 가지고 오기
    getStore("DS_STR_CD", "Y", "1", "N");
    LC_STR_CD.Index = 0;
    LC_STR_CD.Focus();
    getEtcCode("DS_SEARCH_FLAG",   "D", "M061", "N", "N", LC_SEARCH_FLAG);
    getEtcCode("DS_PROM_TYPE",   "D", "M021", "Y", "N", LC_PROM_TYPE);     //약속유형
    getEtcCode("DS_SEND_TYPE_I",   "D", "M025", "N");   //발송유형
}

function gridCreate(gbn){
    if (gbn == "mst") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}       NAME="NO"'
            + '                                          WIDTH=30    ALIGN=CENTER  </FC>'
            + '<FC>ID=STR_CD         NAME="점코드"'
            + '                                          WIDTH=80    ALIGN=LEFT SHOW=FALSE</FC>'
            + '<FC>ID=STR_NAME       NAME="점"'
            + '                                          WIDTH=80    ALIGN=LEFT  </FC>'
            + '<FC>ID=TAKE_DT        NAME="접수일자"'      
            + '                                          WIDTH=80    ALIGN=CENTER  MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=TAKE_SEQ       NAME="SEQ"'
            + '                                          WIDTH=50    ALIGN=CENTER  </FC>'
            + '<FC>ID=IN_DELI_DT     NAME="입고예정일"'
            + '                                          WIDTH=80    ALIGN=CENTER  MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=FRST_PROM_DT   NAME="약속예정일"'
            + '                                          WIDTH=80    ALIGN=CENTER  MASK="XXXX/XX/XX"  </FC>'
            + '<FC>ID=CUST_NM        NAME="고객명"'
            + '                                          WIDTH=80    ALIGN=LEFT  </FC>'
            + '<FC>ID=MOBILE_PH      NAME="고객연락처"'
            + '                                          WIDTH=120   ALIGN=LEFT  Value={decode(MOBILE_PH, "" ,(MOBILE_PH1&&"-"&&MOBILE_PH2&&"-"&&MOBILE_PH3),"")}</FC>'
            + '<FC>ID=PROM_TYPE      NAME="약속유형"'
            + '                                          WIDTH=80    ALIGN=LEFT  </FC>'
            + '<FC>ID=PROC_STAT      NAME="약속상태"'
            + '                                          WIDTH=80    ALIGN=LEFT  </FC>'
            + '<FC>ID=PROM_DTL       NAME="약속상세"'
            + '                                          WIDTH=120   ALIGN=LEFT  </FC>'
            + '<FC>ID=MOBILE_PH1     NAME="고객연락처"'
            + '                                          WIDTH=120   ALIGN=LEFT  SHOW=FALSE</FC>'
            + '<FC>ID=MOBILE_PH2     NAME="고객연락처"'
            + '                                          WIDTH=120   ALIGN=LEFT  SHOW=FALSE</FC>'
            + '<FC>ID=MOBILE_PH3     NAME="고객연락처"'
            + '                                          WIDTH=120   ALIGN=LEFT  SHOW=FALSE</FC>'
            + '<FC>ID=SMS_YN     NAME="SMS 수신여부"'
            + '                                          WIDTH=120   ALIGN=LEFT  SHOW=FALSE</FC>';
            initGridStyle(GD_MASTER, "common", hdrProperies, false);
    } else {
        var hdrProperies = ''
            + '<FC>ID={CURROW}       NAME="NO"'               
            + '                                          WIDTH=30   ALIGN=CENTER</FC>'
            + '<FC>ID=SEND_DT        NAME="발송일자"'
            + '                                          WIDTH=90    ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=SEQ_NO         NAME="SEQ"'
            + '                                          WIDTH=50    ALIGN=CENTER</FC>'
            + '<FC>ID=SEND_TYPE      NAME="발송유형"'
            + '                                          WIDTH=90    ALIGN=LEFT       EDITSTYLE=LOOKUP   DATA="DS_SEND_TYPE_I:CODE:NAME"</FC>'
            + '<FC>ID=SEND_CONTENT   NAME="발송내용"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>'
            + '<FC>ID=RECV_PH1       NAME="수신번호1"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>'
            + '<FC>ID=RECV_PH2       NAME="수신번호2"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>'
            + '<FC>ID=RECV_PH3       NAME="수신번호3"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>'
            + '<FC>ID=SEND_PH1       NAME="발신번호1"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>'
            + '<FC>ID=SEND_PH2       NAME="발신번호2"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>'
            + '<FC>ID=SEND_PH3       NAME="발신번호3"'
            + '                                          WIDTH=80    ALIGN=CENTER     SHOW=FALSE </FC>';
            initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    }
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
 * 작 성 일 : 2011.02.21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_DETAIL.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            //필수입력값 체크
            if (!checkValidate()) return;
            
            //parameters
            var strStrCd    = LC_STR_CD.BindColVal;     // 점코드
            var strSchFlag  = LC_SEARCH_FLAG.BindColVal;// 조회구분
            var strSchSdt   = EM_SEARCH_S_DT.Text;      // 기간(From)
            var strSchEdt   = EM_SEARCH_E_DT.Text;      // 기간(To)
            var strGuestNm  = EM_GUEST_NAME.Text;       // 고객명
            var strPromType = LC_PROM_TYPE.BindColVal;  // 약속유형
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strSchFlag="    + encodeURIComponent(strSchFlag) 
                + "&strSchSdt="     + encodeURIComponent(strSchSdt)
                + "&strSchEdt="     + encodeURIComponent(strSchEdt)
                + "&strGuestNm="    + encodeURIComponent(strGuestNm)
                + "&strPromType="   + encodeURIComponent(strPromType);
            TR_MAIN.Action = "/mss/mpro104.mp?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
            TR_MAIN.Post();
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
        
    }  else {
        //필수입력값 체크
        if (!checkValidate()) return;
        
        //parameters
        var strStrCd    = LC_STR_CD.BindColVal;     // 점코드
        var strSchFlag  = LC_SEARCH_FLAG.BindColVal;// 조회구분
        var strSchSdt   = EM_SEARCH_S_DT.Text;      // 기간(From)
        var strSchEdt   = EM_SEARCH_E_DT.Text;      // 기간(To)
        var strGuestNm  = EM_GUEST_NAME.Text;       // 고객명
        var strPromType = LC_PROM_TYPE.BindColVal;  // 약속유형
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strSchFlag="    + encodeURIComponent(strSchFlag) 
            + "&strSchSdt="     + encodeURIComponent(strSchSdt)
            + "&strSchEdt="     + encodeURIComponent(strSchEdt)
            + "&strGuestNm="    + encodeURIComponent(strGuestNm)
            + "&strPromType="   + encodeURIComponent(strPromType);
        TR_MAIN.Action = "/mss/mpro104.mp?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
        TR_MAIN.Post();
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {	 
     if (DS_O_MASTER.CountRow > 0) {
         if (DS_IO_DETAIL.IsUpdated) {
        	 var ret = showMessage(STOPSIGN, YesNo, "USER-1072");        	 
        	 if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SMS_YN") == "T") {
	        	 if (ret == "1") { 
		        	 searchDtl(1);
		             DS_IO_DETAIL.AddRow();
		             inPutEnable(true);//입력활성화
		             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEND_DT")  = g_toDate;
		             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECV_PH1") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOBILE_PH1");
		             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECV_PH2") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOBILE_PH2");
		             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECV_PH3") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOBILE_PH3");
	        	 } else {
	        		 return;
	        	 }
        	 }else
        	 {
        		 return;
        	 }
         } else {
        	 if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "SMS_YN") == "T") {
	             DS_IO_DETAIL.AddRow();
	             inPutEnable(true);//입력활성화
	             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEND_DT")  = g_toDate;
	             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECV_PH1") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOBILE_PH1");
	             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECV_PH2") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOBILE_PH2");
	             DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "RECV_PH3") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "MOBILE_PH3");
        	 }else {
        		   return;	 
             }
         }
     } else {
         showMessage(STOPSIGN, OK, "USER-1013");
     }
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
     if (DS_O_MASTER.CountRow > 0) {
         if (DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == 1) {
             DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
         } 
     }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수입력값 체크
        if (!checkValidateSave()) return;
    
        //저장전의 위치 저장(DS_IO_DETAIL)
        var preRowno = DS_IO_DETAIL.RowPosition;
        var strStrCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");     // 점코드
        var strTakeDt  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_DT");    // 접수일
        var strTakeSeq = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_SEQ");   // 접수SEQ
        
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        }
        
        var goTo = "save";
        var parameters = ""
            + "&strStrCd="     + encodeURIComponent(strStrCd) 
            + "&strTakeDt="    + encodeURIComponent(strTakeDt) 
            + "&strTakeSeq="   + encodeURIComponent(strTakeSeq);
        TR_MAIN.Action = "/mss/mpro104.mp?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_MAIN.Post();
        
        searchDtl(preRowno);
        
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011.02.21
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * searchDtl()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : SMS발송리스트 조회
  * return값 :
  */
 function searchDtl(preRowno) {  //DS_O_MASTER
        var strStrCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");     // 점코드
        var strTakeDt  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_DT");    // 접수일
        var strTakeSeq = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_SEQ");   // 접수SEQ
        
        var goTo = "getDetail";
        var parameters = ""
            + "&strStrCd="     + encodeURIComponent(strStrCd)
            + "&strTakeDt="    + encodeURIComponent(strTakeDt) 
            + "&strTakeSeq="   + encodeURIComponent(strTakeSeq);
        TR_MAIN2.Action = "/mss/mpro104.mp?goTo=" + goTo + parameters;
        TR_MAIN2.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";//조회:O 입력:I
        TR_MAIN2.Post();
        
        //저장전 위치
        if (preRowno > 0) {
            DS_IO_DETAIL.RowPosition = preRowno;
        }
        
        // 조회결과 Return
        setPorcCount("SELECT", GD_DETAIL);
 }
 

 /**
  * checkValidate()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidate() {
             
     //점체크
     if (LC_STR_CD.BindColVal == "") {//점 미선택시
         showMessage(STOPSIGN, OK, "USER-1003", "점");
         LC_STR_CD.Focus();
         return;
     } 
     
     //조회구분
     if (LC_SEARCH_FLAG.BindColVal == "") {//점 미선택시
         showMessage(STOPSIGN, OK, "USER-1003", "조회구분");
         LC_SEARCH_FLAG.Focus();
         return;
     } 
     
     //시작, 종료일 일자체크
     var em_sdate = (trim(EM_SEARCH_S_DT.Text)).replace(' ','');
     var em_edate = (trim(EM_SEARCH_E_DT.Text)).replace(' ','');
     if (em_sdate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1004", "시작일");
         EM_SEARCH_S_DT.Focus();
         return false;
     } else if (em_edate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1004", "종료일");
         EM_SEARCH_E_DT.Focus();
         return false;
     }

     if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_SEARCH_S_DT.Focus();
         return false;
     }
     return true;
 }


 /**
  * checkValidateSave()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidateSave() {
	 for (i=1; i<=DS_IO_DETAIL.CountRow; i++) {
		 if (DS_IO_DETAIL.RowStatus(i) == 1 || DS_IO_DETAIL.RowStatus(i) == 3) {
		     //발송일자
		     var strIpDate = (trim(DS_IO_DETAIL.NameValue(i, "SEND_DT"))).replace(' ','');
		     if (strIpDate.length < 8) {
		         showMessage(STOPSIGN, OK, "USER-1002", "발송일자");
		         DS_IO_DETAIL.RowPosition = i;
		         EM_SEND_DT_I.Focus();
		         return false;
		     } 
		     
		     //발송일자는 오늘 이후만 입력가능하다.
		     if (strIpDate < g_toDate ) {
		         EM_SEND_DT_I.Text = g_toDate;
		         showMessage(STOPSIGN, OK, "USER-1002", "발송일자");
		         DS_IO_DETAIL.RowPosition = i;
		         setTimeout("EM_SEND_DT_I.Focus()",100);
		         return;
		     }
		     
		     //발송유형
		     if (DS_IO_DETAIL.NameValue(i, "SEND_TYPE") == "") {
		         showMessage(STOPSIGN, OK, "USER-1002", "발송유형");
		         DS_IO_DETAIL.RowPosition = i;
		         setTimeout("LC_SEND_TYPE_I.Focus()",100);
		         return false;
		     } 
		     
		     //수신번호
		     var strRPh1 = (trim(DS_IO_DETAIL.NameValue(i, "RECV_PH1"))).replace(' ','');
		     if (strRPh1.length < 3) {
		         showMessage(STOPSIGN, OK, "USER-1004", "수신번호");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_RECV_PH1_I.Focus()",100);
		         return false;
		     } 
		     var strRPh2 = (trim(DS_IO_DETAIL.NameValue(i, "RECV_PH2"))).replace(' ','');
		     if (strRPh2.length < 3) {
		         showMessage(STOPSIGN, OK, "USER-1004", "수신번호");
		         EM_RECV_PH2_I.Focus();
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_RECV_PH2_I.Focus()",100);
		         return false;
		     } 
		     var strRPh3 = (trim(DS_IO_DETAIL.NameValue(i, "RECV_PH3"))).replace(' ','');
		     if (strRPh3.length < 4) {
		         showMessage(STOPSIGN, OK, "USER-1004", "수신번호");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_RECV_PH3_I.Focus()",100);
		         return false;
		     }
		     
		     //발신번호
		     var strSPh1 = (trim(DS_IO_DETAIL.NameValue(i, "SEND_PH1"))).replace(' ','');
		     if (strSPh1.length < 2) {
		    	 showMessage(STOPSIGN, OK, "USER-1004", "발신번호");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_SEND_PH1_I.Focus()",100);
		         return false;
		     } 
		     var strSPh2 = (trim(DS_IO_DETAIL.NameValue(i, "SEND_PH2"))).replace(' ','');
		     if (strSPh2.length < 3) {
		    	 showMessage(STOPSIGN, OK, "USER-1004", "발신번호");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_SEND_PH2_I.Focus()",100);
		         return false;
		     } 
		     var strSPh3 = (trim(DS_IO_DETAIL.NameValue(i, "SEND_PH3"))).replace(' ','');
		     if (strSPh3.length < 4) {
		         showMessage(STOPSIGN, OK, "USER-1004", "발신번호");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_SEND_PH3_I.Focus()",100);
		         return false;
		     } 
		     
		     
		     //발송내용
		     var strSCont = checkLenByte(DS_IO_DETAIL, i, "SEND_CONTENT");
		     if (strSCont < 1) {
		         showMessage(STOPSIGN, OK, "USER-1003", "발송내용");
		         DS_IO_DETAIL.RowPosition = i;
		         setTimeout("TXT_SEND_CONTENT_I.Focus()",100);
		         return false;
		     } else if (strSCont > 100) {
                 showMessage(STOPSIGN, OK, "USER-1048", "100");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("TXT_SEND_CONTENT_I.Focus()",100);
                 return false;
		     }
		 }
	 }
     return true;
 }

/**
 * checkLenByte()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 문자열 Byte체크
 * return값 :
 */
function checkLenByte(objDateSet, row, colid) {
    //byte체크
    var intByte = 0;
    var strTemp = objDateSet.NameValue(row, colid);
    for (k = 0; k < strTemp.length; k++) {
        var onechar = strTemp.charAt(k);
        if (escape(onechar).length > 4) {
            intByte += 2;
        } else {
            intByte++;
        }
    }
    return intByte;
}

 /**
  * callPop()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : 팝업호출
  * return값 :
  */
 function callPop(objName) {
     openCal('G',objName);
     //발송유형
     if (objName == EM_SEND_DT_I) {
        //발송일자는 오늘 이후만 입력가능하다.
         if ((EM_SEND_DT_I.Text).length < 1) return;

         if (EM_SEND_DT_I.Text < g_toDate ) {
             EM_SEND_DT_I.Text = g_toDate;
             showMessage(STOPSIGN, OK, "USER-1030", "발송일자");
             setTimeout("EM_SEND_DT_I.Focus()",100);
             return;
         }
     } 
 }
 
 /**
  * inPutEnable()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : 팝업호출
  * return값 :
  */
 function inPutEnable(objBoolean) {
      if (objBoolean) {
          initEmEdit(EM_SEND_DT_I, "YYYYMMDD", PK);     //발송일자
          enableControl(IMG_SEND_DT_I,true);
          initEmEdit(EM_RECV_PH1_I, "NUMBER3^4^2", PK); //수신번호
          initEmEdit(EM_RECV_PH2_I, "NUMBER3^4^2", PK); //수신번호
          initEmEdit(EM_RECV_PH3_I, "NUMBER3^4^2", PK); //수신번호
          initEmEdit(EM_SEND_PH1_I, "NUMBER3^4^2", PK); //발신번호
          initEmEdit(EM_SEND_PH2_I, "NUMBER3^4^2", PK); //발신번호
          initEmEdit(EM_SEND_PH3_I, "NUMBER3^4^2", PK); //발신번호
          initComboStyle(LC_SEND_TYPE_I,DS_SEND_TYPE_I, "CODE^0^30,NAME^0^80", 1, PK);    //발송유형
          TXT_SEND_CONTENT_I.Enable    = true;  
      } else {
          EM_SEND_DT_I.Enable    = false;
          enableControl(IMG_SEND_DT_I,false);
          EM_RECV_PH1_I.Enable    = false;
          EM_RECV_PH2_I.Enable    = false;
          EM_RECV_PH3_I.Enable    = false;
          EM_SEND_PH1_I.Enable    = false;
          EM_SEND_PH2_I.Enable    = false;
          EM_SEND_PH3_I.Enable    = false;
          LC_SEND_TYPE_I.Enable    = false;
          TXT_SEND_CONTENT_I.Enable    = false;  

      }
 }
 -->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN2.ErrorMsg);

</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(Row)>
//마스터 row변경 전
if (DS_O_MASTER.CountRow > 0) {
    //마스터 선택 시 상세조회(선택 Row) 미사용
    if (DS_IO_DETAIL.IsUpdated) {//마스터 컬럼변경전 변경데이터 있을 시 이동할것인지 확인
        var ret = showMessage(Question, YesNo, "USER-1049");
        if (ret == "1") {
            return true;
        } else {
            return false;
        }
    } 
    return true;
}
return true;
</script>

<script language=JavaScript for=DS_O_MASTER event=onRowPosChanged(row)> 
if(clickSORT) return;
//마스터 row변경 후
if (row > 0) {
    searchDtl();//상세조회
} else {
    DS_IO_DETAIL.ClearData();
    //inPutEnable(false);
}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
//SMS발송리스트 row변경 후
if (row > 0) {
	if (DS_IO_DETAIL.RowStatus(row) == 1) {
		inPutEnable(true);
	} else {
        inPutEnable(false);
		/* [발송 작성된  SMS는 수정불가!]
	    if (DS_IO_DETAIL.NameValue(row, "SEND_DT") > g_toDate) { 
	        inPutEnable(true);
            EM_SEND_DT_I.Enable    = false;
            enableControl(IMG_SEND_DT_I,false);
	    } else {
	    }
		*/
	}
} else {
    inPutEnable(false);
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>


<script language=JavaScript for=EM_SEND_DT_I event=onKillFocus()>
//발송일자는체크
if (!checkDateTypeYMD( EM_SEND_DT_I )) return;

var strIpDate = (trim(EM_SEND_DT_I.Text)).replace(' ','');
//발송일자는 오늘 이후만 입력가능하다.
if (strIpDate < g_toDate ) {
    EM_SEND_DT_I.Text = g_toDate;
    showMessage(STOPSIGN, OK, "USER-1030", "발송일자");
    setTimeout("EM_SEND_DT_I.Focus()",100);
    return;
}
</script>

<script language=JavaScript for=EM_SEARCH_S_DT event=onKillFocus()>
//[조회용]시작일 체크
checkDateTypeYMD( EM_SEARCH_S_DT );
</script>

<script language=JavaScript for=EM_SEARCH_E_DT event=onKillFocus()>
//[조회용]종료일 체크
checkDateTypeYMD( EM_SEARCH_E_DT );
</script>

<script language=JavaScript for=LC_SEND_TYPE_I event=OnSelChange()>
if (DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == 1) {
	if (LC_SEND_TYPE_I.BindColVal == "") return;
	
	var strNm      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_NAME");   //점명
	var strCustNm  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CUST_NM");    //고객명
	var strSentType= LC_SEND_TYPE_I.ValueOfIndex("NAME", LC_SEND_TYPE_I.Index);    //전송타입
	var strProType = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PROM_TYPE");  //약속유형
	//Trim
	strProType = strProType.replace(/^\s*/,'');
	strProType = strProType.replace(/\s*$/,'');
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEND_CONTENT") = ""
		+ strCustNm +"님의 " + strProType +"이(가) " + strSentType + " 되었습니다. -" + strNm +"-"; 
}
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->   
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_FLAG"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PROM_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEND_TYPE_I"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>    
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                        <th width="70" class="POINT">점</th>
                        <td width="145"><comment id="_NSID_"> <object
                            id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70" class="POINT">조회구분</th>
                        <td width="145"><comment id="_NSID_"> <object
                            id=LC_SEARCH_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70" class="POINT">기간</th>
						<td><comment id="_NSID_"> <object id=EM_SEARCH_S_DT
							classid=<%=Util.CLSID_EMEDIT%> width=86 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:callPop(EM_SEARCH_S_DT);" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_SEARCH_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=86 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:callPop(EM_SEARCH_E_DT);" align="absmiddle" /></td>
					</tr>
                    <tr>
                        <th>고객명</th>
                        <td><comment id="_NSID_"> <object id=EM_GUEST_NAME
                            classid=<%=Util.CLSID_EMEDIT%> width=137 tabindex=1 onKeyup="javascript:checkByteStr(this, 40, 'Y');" 
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th>약속유형</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=LC_PROM_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                        <td width="100%"><comment id="_NSID_"><OBJECT
                            id=GD_MASTER width=100% tabindex=1 height=328 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_O_MASTER">
                        </OBJECT></comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td height="4"></td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr>
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> SMS리스트</td>
            </tr>
            <tr valign="top">
                <td width="300">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="100%"><comment id="_NSID_"><OBJECT
                            id=GD_DETAIL width=100% tabindex=1 height=125 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_DETAIL">
                        </OBJECT></comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
                <td class="PL05">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="s_table">
                            <tr>
                                <th width="70" class="POINT">발송일자</th>
                                <td width="145"><comment id="_NSID_"> <object
                                    id=EM_SEND_DT_I classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                                    id="IMG_SEND_DT_I"
                                    src="/<%=dir%>/imgs/btn/date.gif"
                                    onclick="javascript:callPop(EM_SEND_DT_I);"
                                    align="absmiddle" /></td>
                                <th width="70" class="POINT">발송유형</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_SEND_TYPE_I classid=<%=Util.CLSID_LUXECOMBO%> width=190 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                            <tr>
                                <th class="POINT">수신번호</th>
                                <td colspan=3><comment id="_NSID_"> <object
                                    id=EM_RECV_PH1_I classid=<%=Util.CLSID_EMEDIT%> width=40
                                    tabindex=1 align="right"> </object> </comment> <script> _ws_(_NSID_);</script>-
                                <comment id="_NSID_"> <object id=EM_RECV_PH2_I
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="right"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                    id="_NSID_"> <object id=EM_RECV_PH3_I
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="right"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                            </tr>
                            <tr>
                                <th class="POINT">발신번호</th>
                                <td colspan=3><comment id="_NSID_"> <object
                                    id=EM_SEND_PH1_I classid=<%=Util.CLSID_EMEDIT%> width=40
                                    tabindex=1 align="right"> </object> </comment> <script> _ws_(_NSID_);</script>-
                                <comment id="_NSID_"> <object id=EM_SEND_PH2_I
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="right"> </object> </comment> <script> _ws_(_NSID_);</script>- <comment
                                    id="_NSID_"> <object id=EM_SEND_PH3_I
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
                                    align="right"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                            </tr>
                            <tr>
                                <th class="POINT">발송내용</th>
								<td colspan=3><comment id="_NSID_"> <object
									id=TXT_SEND_CONTENT_I classid=<%=Util.CLSID_TEXTAREA%>
									height=50 width=100% tabindex=1 align="absmiddle"
									onkeyup="javascript:textAreaMaxlength(TXT_SEND_CONTENT_I, 80);"
									onkeyDown="javascript:textAreaMaxlength(TXT_SEND_CONTENT_I, 80);"
									onkeyPress="javascript:textAreaMaxlength(TXT_SEND_CONTENT_I, 80);">
								</object> </comment> <script>_ws_(_NSID_);</script></td>
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
<object id=BD_IO_DETAIL classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_DETAIL>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=SEND_DT          Ctrl=EM_SEND_DT_I           param=Text</c>
        <c>Col=SEND_TYPE        Ctrl=LC_SEND_TYPE_I         param=BindColVal</c>
        <c>Col=RECV_PH1         Ctrl=EM_RECV_PH1_I          param=Text</c>
        <c>Col=RECV_PH2         Ctrl=EM_RECV_PH2_I          param=Text</c>
        <c>Col=RECV_PH3         Ctrl=EM_RECV_PH3_I          param=Text</c>
        <c>Col=SEND_PH1         Ctrl=EM_SEND_PH1_I          param=Text</c>
        <c>Col=SEND_PH2         Ctrl=EM_SEND_PH2_I          param=Text</c>
        <c>Col=SEND_PH3         Ctrl=EM_SEND_PH3_I          param=Text</c>
        <c>Col=SEND_CONTENT     Ctrl=TXT_SEND_CONTENT_I     param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
