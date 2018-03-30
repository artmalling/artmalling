<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상담/계약 > 상담관리 > 신규상담처리(단변POPUP)
 * 작 성 일 : 2011.02.25
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : mcou1011.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 신규상담처리(단변)
 * 이    력 : 2011.02.25 (김유완) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	String contextRoot = request.getContextPath();
	
    //기본 URL
    String u = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
    String webDir = u.substring(0, u.lastIndexOf("mss")-1);
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"	    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strReqDt    = dialogArguments[0];
var strReqSeq   = dialogArguments[1];
var strToday    = getTodayFormat("yyyymmdd");
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

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MO_COUNSELANS_P"/>');
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MO_COUNSELREQ_P"/>');
    
    //그리드 초기화
    gridCreate("Dtl");
    
    // EMedit에 초기화
    initEmEdit(EM_RQ_COMPNM,    "GEN", READ);   // [상담신청]회사명
    initEmEdit(EM_RQ_REPNM,     "GEN", READ);   // [상담신청]대표자명
    initEmEdit(EM_RQ_DATE, "YYYYMMDD", READ);   // [상담신청]신청일자
    initEmEdit(EM_RQ_NAME,      "GEN", READ);   // [상담신청]신청인
    initEmEdit(EM_RQ_PHONE1_NO, "GEN", READ);   // [상담신청]전화번호1
    initEmEdit(EM_RQ_PHONE2_NO, "GEN", READ);   // [상담신청]전화번호2
    initEmEdit(EM_RQ_PHONE3_NO, "GEN", READ);   // [상담신청]전화번호3
    initEmEdit(EM_RQ_MOBILE_PH1,"GEN", READ);   // [상담신청]휴대폰번호1
    initEmEdit(EM_RQ_MOBILE_PH2,"GEN", READ);   // [상담신청]휴대폰번호2
    initEmEdit(EM_RQ_MOBILE_PH3,"GEN", READ);   // [상담신청]휴대폰번호3
    initEmEdit(EM_RQ_TITLE,     "GEN", READ);   // [상담신청]제목
    initEmEdit(EM_RQ_EMAIL,     "GEN", READ);   // [상담신청]Email
    initTxtAreaEdit(TXT_RQ_CONTEN,     READ);   // [상담신청]상담신청내역
    initComboStyle(LC_RQ_FILE,DS_O_REQFILSE, "ATTCH_SEQ^0^30,FILE_NM^0^80", 1, NORMAL);         // [상담신청]첨부파일
    initEmEdit(EM_DELI_PLACE,   "GEN", NORMAL); // [답변내역]상담장소
    EM_DELI_PLACE.Language = 1;
    initEmEdit(EM_DELI_DT,      "YYYYMMDD", NORMAL);    // [답변내역]상담예정일
    initEmEdit(EM_BY_PHONE1_NO, "NUMBER3^3^2", NORMAL); // [답변내역]바이어연락처1
    initEmEdit(EM_BY_PHONE2_NO, "NUMBER3^4^2", NORMAL); // [답변내역]바이어연락처2
    initEmEdit(EM_BY_PHONE3_NO, "NUMBER3^4^2", NORMAL); // [답변내역]바이어연락처3
    initTxtAreaEdit(TXT_ANS_CONTENT,   NORMAL);         // [답변내역]답변
    initEmEdit(EM_AN_FILE,      "GEN", READ);           // [답변내역]첨부파일
    initComboStyle(LC_RJT_REASON,DS_LC_RJT_REASON, "CODE^0^30,NAME^0^80", 1, NORMAL);           // [답변내역]거절상세
    initComboStyle(LC_ANS_TYPE,DS_LC_ANS_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);               // [답변내역]답변유형
    initComboStyle(LC_ONOFFLINE_FLAG,DS_LC_ONOFFLINE_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);   // [답변내역]ON/OFF라인상담여부 

    initComboStyle(LC_DELI_TIME_HH,DS_LC_DELI_TIME_HH, "CODE^0^30,NAME^0^30", 1, NORMAL);        //최초약속 시간
    initComboStyle(LC_DELI_TIME_MM,DS_LC_DELI_TIME_MM, "CODE^0^30,NAME^0^80", 1, NORMAL);        //최초약속 분
    
    //시스템 코드 공통코드에서 발행기 가지고 오기
    getEtcCode("DS_LC_RJT_REASON",   "D", "M072", "N");     //[답변내역]거절상세
    getEtcCode("DS_LC_ANS_TYPE",   "D", "M071", "N");       //[답변내역]답변유형
    getEtcCode("DS_LC_ONOFFLINE_FLAG",   "D", "M070", "N"); //[답변내역]ON/OFF라인상담여부 
    getEtcCode("DS_LC_DELI_TIME_HH",   "D", "M059", "N");   //[답변내역]시간
    getEtcCode("DS_LC_DELI_TIME_MM",   "D", "M060", "N");   //[답변내역]분
    objControl(false);
    btn_Search();
}

function gridCreate(gdGnb){
    //답변내역 그리드
    if (gdGnb == "Dtl") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME="NO"'
            + '                                         WIDTH=30   ALIGN=CENTER</FC>'
            + '<FC>ID=REQ_DT        NAME="상담신청일자"'
            + '                                         WIDTH=100  ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=REQ_SEQ       NAME="순번"'
            + '                                         WIDTH=70   ALIGN=CENTER</FC>'
            + '<FC>ID=ANS_SEQ       NAME="답변순번"'
            + '                                         WIDTH=70   ALIGN=CENTER</FC>'
            + '<FC>ID=BUYER_NM      NAME="바이어"'
            + '                                         WIDTH=130  ALIGN=LEFT</FC>'
            + '<FC>ID=DELI_PLACE    NAME="상담장소  "'
            + '                                         WIDTH=240  ALIGN=LEFT</FC>'
            + '<FC>ID=DELI_DT       NAME="상담예정일"'
            + '                                         WIDTH=100  ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=DELI_TIME     NAME="상담예정시간"'
            + '                                         WIDTH=100  ALIGN=CENTER MASK="XX:XX" VALUE={DELI_TIME_HH&&DELI_TIME_MM}</FC>'            + '<FC>ID=DELI_TIME_HH  NAME="상담예정시간"'
            + '                                         WIDTH=100  ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=DELI_TIME_MM  NAME="상담예정시간(분)"'
            + '                                         WIDTH=100  ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=BUYER_CD      NAME="바이어ID  "'
            + '                                         WIDTH=100  ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=ONOFF_FLAG    NAME="온오프라인상담여부"'
            + '                                         WIDTH=100  ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=BUYER_PHONE1_NO   NAME="바바이연락처1"'
            + '                                         WIDTH=70   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=BUYER_PHONE2_NO   NAME="바바이연락처2"'
            + '                                         WIDTH=70   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=BUYER_PHONE3_NO   NAME="바바이연락처3"'
            + '                                         WIDTH=70   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=ANS_TYPE      NAME="답변유형"'
            + '                                         WIDTH=60   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=RJT_REASON    NAME="거절상세"'
            + '                                         WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=ANS_CONTENT   NAME="답변"'
            + '                                         WIDTH=70   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=FILE_NM       NAME="첨부파일"'
            + '                                         WIDTH=70   ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=FILE_GB       NAME="파일구분"'
            + '                                         WIDTH=70   ALIGN=CENTER</FC>'
            ;
        initGridStyle(GD_DETAIL, "COMMON", hdrProperies, false);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    var goTo = "getListMaster";
    var parameters = ""
        + "&strReqDt="      + encodeURIComponent(strReqDt) // 신청일자
        + "&strReqSeq="     + encodeURIComponent(strReqSeq) ;// SEQ 
    TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();
    
    if (DS_O_MASTER.CountRow < 1) return; 
    
    if (DS_O_MASTER.NameValue(1, "AUTHCHK") == "N") { //권한없음
        //버튼
        enableControl(IMG_BTN_NEW,false);
        enableControl(IMG_BTN_DEL,false);
        enableControl(IMG_BTN_SAVE,false);
        enableControl(IMG_BUYER_CHANGE,false);
    }  else {
        //버튼
        enableControl(IMG_BTN_NEW,true);
        enableControl(IMG_BTN_DEL,true);
        enableControl(IMG_BTN_SAVE,true);
        enableControl(IMG_BUYER_CHANGE,true);
    }
    //첨부파일가져오기
    getMasterFiles();
    //답변리스트 조회
    searchAnsList();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 if (DS_O_MASTER.CountRow == 1 ) {
		 if (!DS_IO_DETAIL.IsUpdated) {
			 DS_IO_DETAIL.AddRow();
			 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "REQ_DT")  = strReqDt; // 신청일자
			 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "REQ_SEQ") = strReqSeq;// 신청순번
			 DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "DELI_DT") = strToday; // 상담예정일
			 objControl(true);
			 enableControl(LC_RJT_REASON, false);
		 } 
	 } 
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_Delete() {
    //삭제하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1023") != 1 ){
        GD_DETAIL.Focus();
        return;
    }
    
    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
    var parameters = ""
        + "&strReqDt="      + encodeURIComponent(strReqDt) // 신청일자
        + "&strReqSeq="     + encodeURIComponent(strReqSeq);// SEQ 
    var goTo = "listDel";
    TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_MAIN.Post();
    
    //답변내역 재조회
    searchAnsList();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
    	
    	//저장시 체크
    	if (!checkValidate()) return;
    
    	//변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        }
    
        var goTo = "listSave";
        var parameters = "";
        TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_MAIN.Post();
        
        //답변내역 재조회
        searchAnsList();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    }
}

/**
 * btn_Close()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 창닫기
 * return값 : void
 */

function btn_Close(ent) {
	 // 0: 현재 창에서 close 
	 // 1: 현재 창에서 close 
	 window.returnValue = ent;
	 window.close();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * getMasterFiles()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 첨부파일 다운
 * return값 :
 */
function getMasterFiles() {
	var goTo = "getListMasterFiles";
	var parameters = ""
	    + "&strReqDt="      + encodeURIComponent(strReqDt) // 신청일자
	    + "&strReqSeq="     + encodeURIComponent(strReqSeq);// SEQ 
	TR_FILES.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
	TR_FILES.KeyValue = "SERVLET(O:DS_O_REQFILSE=DS_O_REQFILSE)";
	TR_FILES.Post();
	
    //파일다운로드버튼
    if (DS_O_REQFILSE.CountRow > 0 ) {
    	if (DS_O_MASTER.NameValue(1, "AUTHCHK") == "N") {
	        enableControl(IMG_RQ_FILE,false);
    	} else {
	        enableControl(IMG_RQ_FILE,true);
    	}
        LC_RQ_FILE.Enable    = true;  
        LC_RQ_FILE.index = 0;
    } else {
        LC_RQ_FILE.Enable    = false;  
        enableControl(IMG_RQ_FILE,false);
    }
}

 /**
  * searchAnsList()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 답변내역 조회
  * return값 :
  */
 function searchAnsList() {
    if (DS_O_MASTER.CountRow > 0) {
        var goTo = "getListDetail";
        var parameters = ""
            + "&strReqDt="      + encodeURIComponent(strReqDt) // 신청일자
            + "&strReqSeq="     + encodeURIComponent(strReqSeq);// SEQ 
        TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_MAIN.Post();
    }
    
    //상세리스트 내역이 없으면 입력비활성화
    if (DS_IO_DETAIL.CountRow < 1)  {
    	objControl(false);
    } else {
        if (DS_O_MASTER.NameValue(1, "AUTHCHK") != "N") { //권한없음
        	objControl(true);
        }
    }
 }
 
 /**
  * searchAnsList()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 답변내역 조회
  * return값 :
  */
 function btn_BuyerCng() {
     var arrArg  = new Array();
     arrArg.push(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_DT"));
     arrArg.push(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_SEQ"));
     arrArg.push(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "BUYER_CD"));
     
     var returnVal = window.showModalDialog("/mss/mcou101.mu?goTo=listCngBuyer",
                                            arrArg,
                                            "dialogWidth:700px;dialogHeight:132px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
   	 if (returnVal == "saveClose") {
   		btn_Close("saveClose");
   	 } 
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
     var strTemp = trim(objDateSet.NameValue(row, colid));
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
  * checkValidate()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidate() {
     for (i=1; i<=DS_IO_DETAIL.CountRow; i++) {
         if (DS_IO_DETAIL.RowStatus(i) == 1 || DS_IO_DETAIL.RowStatus(i) == 3) {
        	 
             //상담장소
             var strDPlace = checkLenByte(DS_IO_DETAIL, i, "DELI_PLACE");
             if (strDPlace > 50) {
                 showMessage(STOPSIGN, OK, "USER-1000", "답변내용은 50 Byte이상 입력할 수 없습니다.");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_DELI_PLACE.Focus()",100);
                 return false;
             }
        	 
             //상담예정일자
             var strIpDate = (trim(DS_IO_DETAIL.NameValue(i, "DELI_DT"))).replace(' ','');
             if (strIpDate.length < 8) {
                 showMessage(STOPSIGN, OK, "USER-1004", "상담예정일");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("EM_DELI_DT.Focus()",100);
                 return false;
             } 
             
             //상담예정일자는 오늘 이후만 입력가능하다.
             if (DS_IO_DETAIL.RowStatus(i) == 1) {
                 if (strIpDate < strToday ) {
                     EM_DELI_DT.Text = strToday;
                     showMessage(STOPSIGN, OK, "USER-1030", "상담예정일");
                     DS_IO_DETAIL.RowPosition = i;
                     setTimeout("EM_DELI_DT.Focus()",100);
                     return false;
                 }
             }
             
             //답변유형이 거절일 경우  거절상세는 필수
             var strAnsTp = DS_IO_DETAIL.NameValue(i, "ANS_TYPE");
             var strRjtRs = DS_IO_DETAIL.NameValue(i, "RJT_REASON");
             if (strAnsTp ==  "4") {
            	 if (strRjtRs.length < 1 ) {
                     EM_DELI_DT.Text = strToday;
                     showMessage(STOPSIGN, OK, "USER-1003", "[답변이 거절의 경우] 거절상세");
                     DS_IO_DETAIL.RowPosition = i;
                     setTimeout("LC_RJT_REASON.Focus()",100);
                     return false;
            	 }
             }
             
             //답변내용
             var strSCont = checkLenByte(DS_IO_DETAIL, i, "ANS_CONTENT");
             if (strSCont < 1) {
                 showMessage(STOPSIGN, OK, "USER-1003", "답변내용");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("TXT_ANS_CONTENT.Focus()",100);
                 return false;
             } else if (strSCont > 4000) {
                 showMessage(STOPSIGN, OK, "USER-1000", "답변내용은 4000 Byte이상 입력할 수 없습니다.");
                 DS_IO_DETAIL.RowPosition = i;
                 setTimeout("TXT_ANS_CONTENT.Focus()",100);
                 return false;
             }
             
         }
     }
     return true;
 }
 
 /**
  * objControl()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 버튼컨트롤
  * return값 :
  */
 function objControl(objBoolean) {
    if (objBoolean) {
    	if (DS_O_MASTER.NameValue(1, "AUTHCHK") != "N") {
    	//버튼
    	//enableControl(IMG_BTN_NEW,true);
    	//enableControl(IMG_BTN_SAVE,true);
    	//enableControl(IMG_BTN_DEL,true);
    	//enableControl(IMG_BUYER_CHANGE,true);
    	//오브젝트
    	enableControl(EM_DELI_PLACE,true);
    	enableControl(EM_DELI_DT,true);
    	enableControl(EM_BY_PHONE1_NO,true);
    	enableControl(EM_BY_PHONE2_NO,true);
    	enableControl(EM_BY_PHONE3_NO,true);
    	TXT_ANS_CONTENT.Enable    = true; 
        if (DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ANS_TYPE") == "4") {
            enableControl(LC_RJT_REASON, true);
        } else {
            enableControl(LC_RJT_REASON, false);
        }
    	enableControl(LC_ANS_TYPE,true);
    	enableControl(LC_ONOFFLINE_FLAG,true);
    	enableControl(LC_DELI_TIME_HH,true);
    	enableControl(LC_DELI_TIME_MM,true);
    	enableControl(EM_DELI_PLACE,true);
    	enableControl(EM_DELI_PLACE,true);
    	enableControl(EM_DELI_PLACE,true);
    	enableControl(EM_DELI_PLACE,true);
    	enableControl(IMG_DELI_DT,true);
    	//enableControl(IMG_RQ_FILE,true);
    	enableControl(IMG_AN_FILE,true);
    	enableControl(IMG_FILE_DEL,true);
    	}
    } else {
    	//버튼
    	//enableControl(IMG_BTN_NEW,false);
    	//enableControl(IMG_BTN_SAVE,false);
    	//enableControl(IMG_BTN_DEL,false);
    	//enableControl(IMG_BUYER_CHANGE,false);
        //오브젝트
        enableControl(EM_DELI_PLACE,false);
        enableControl(EM_DELI_DT,false);
        enableControl(EM_BY_PHONE1_NO,false);
        enableControl(EM_BY_PHONE2_NO,false);
        enableControl(EM_BY_PHONE3_NO,false);
        TXT_ANS_CONTENT.Enable    = false;  
        enableControl(LC_RJT_REASON,false);
        enableControl(LC_ANS_TYPE,false);
        enableControl(LC_ONOFFLINE_FLAG,false);
        enableControl(LC_DELI_TIME_HH,false);
        enableControl(LC_DELI_TIME_MM,false);
        enableControl(EM_DELI_PLACE,false);
        enableControl(EM_DELI_PLACE,false);
        enableControl(EM_DELI_PLACE,false);
        enableControl(EM_DELI_PLACE,false);
        enableControl(IMG_DELI_DT,false);
        //enableControl(IMG_RQ_FILE,false);
        enableControl(IMG_AN_FILE,false);
        enableControl(IMG_FILE_DEL,false);
    }
 }
 
 /**
  * deleteFile()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 파일열기
  * return값 :
  */
 function deleteFile() {
      var strFlag = "";
      if (DS_IO_DETAIL.OrgNameString(DS_IO_DETAIL.RowPosition,"FILE_NM") != "") {
          strFlag = "D";
      } else {
          strFlag = "N";
      }
          
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_GB") = strFlag;    // 파일Flag
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_PATH") = "";   // 경로명 표기
      DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_NM") = ""; // 경로명 표기
 }

 /**
  * openFile()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 파일열기
  * return값 :
  */
 function openFile() {
	//Fils Open창
	INF_FILEUPLOAD.Open();
	if (INF_FILEUPLOAD.SelectState) {
	    var strFileInfo = INF_FILEUPLOAD.Value; //파일이름
	    var tmpFileName = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1);
	    var strFileName = tmpFileName.substring(0, tmpFileName.lastIndexOf("."));
        var chrByre = checkLenByteStr(strFileName);
        var chrLen  = strFileName.length;
        /*[2011.07.26] 한글파일명 제한 해제
        if (chrByre != chrLen) {    // 파일명 한글
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 영문,숫자만으로 작성해주세요");
            return;
        } else */if (chrByre > 21) {  // 파일명 22Byte이내작성
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 21Byte(영문,숫자21자)이내로 작성해주세요");
            return;
        } else {
			if((1024 * 1024 * 5) < INF_FILEUPLOAD.FileInfo("size")){
			    showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 5M 를 넘을 수 없습니다.");
			    var strFlag = "";
			    if (DS_IO_DETAIL.OrgNameString(DS_IO_DETAIL.RowPosition,"FILE_NM") != "") {
			        strFlag = "D";
			    } else {
			        strFlag = "N";
			    }
			    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_GB") = strFlag;    // 파일Flag
			    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_PATH") = ""; // 경로명 표기
			    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_NM") = ""; // 경로명 표기
			} else {
			    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_GB") = "Y";    // 파일Flag
			    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_PATH") = strFileInfo;
			    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "FILE_NM") = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1)
			}
	    }
	} 
 }
 
 /**
  * checkLenByteStr()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 문자열 Byte체크
  * return값 :
  */
 function checkLenByteStr(str) {
     //byte체크
     var intByte = 0;
     for (k = 0; k < str.length; k++) {
         var onechar = str.charAt(k);
         if (escape(onechar).length > 4) {
             intByte += 2;
         } else {
             intByte++;
         }
     }
     return intByte;
 }
 
 /**
  * saveAsFiles()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.04.01
  * 개    요 : 값체크(저장)
  * return값 :
  */
 function saveAsFiles() {
	var strPath   = "upload/";    
	var strFileNm = LC_RQ_FILE.ValueOfIndex("FILE_NM", LC_RQ_FILE.index);       
	if( strFileNm != null  ) {                          
		iFrame.location.href="/mss/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+encodeURIComponent(strFileNm);
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
<script language=JavaScript for=TR_FILES event=onSuccess>
    for(i=0;i<TR_FILES.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_FILES.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_FILES event=onFail>
    trFailed(TR_FILES.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_DETAIL.CountRow > 0) {
    if (DS_O_MASTER.NameValue(1, "AUTHCHK") != "N") {
		if (DS_IO_DETAIL.NameValue(row, "ANS_TYPE") == "4") {
		    enableControl(LC_RJT_REASON, true);
		} else {
			enableControl(LC_RJT_REASON, false);
			//LC_RJT_REASON.DefaultString   = "";
			//LC_RJT_REASON.Index = -1;
		}
	}
}

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=EM_DELI_DT event=onKillFocus()>
//상담예정일 체크
checkDateTypeYMD( EM_DELI_DT );
</script>

<script language=JavaScript for=LC_ANS_TYPE event=OnSelChange()>
//답변유형에 따라 
if (DS_IO_DETAIL.CountRow > 0) {
    if (DS_O_MASTER.NameValue(1, "AUTHCHK") != "N") {
	    if (LC_ANS_TYPE.BindColVal == "4") { // 답변유형이 거절일경우 거절상세 활성화
	        enableControl(LC_RJT_REASON, true);
	        LC_RJT_REASON.Index = 0;
	    } else {
	        enableControl(LC_RJT_REASON, false);
	        LC_RJT_REASON.DefaultString   = "";
	        LC_RJT_REASON.Index = -1;
	    }
	}
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
<!-- ===============- Input용  -->
<comment id="_NSID_"><object id="DS_IO_DETAIL"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_REQFILSE"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_RJT_REASON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_ANS_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_ONOFFLINE_FLAG"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_PC_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_WORD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_PROC_STAT"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_DELI_TIME_HH"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_DELI_TIME_MM"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_FILES" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
    <param name="FileFilterString"  value=16>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->

<body onLoad="doInit();">
<iframe id=iFrame  name=iFrame src="about:blank" width=0 height=0 ></iframe>  
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="pop01"></td>
		<td class="pop02"></td>
		<td class="pop03"></td>
	</tr>
	<tr>
		<td class="pop04"></td>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="" class="title"><img
							src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
							align="absmiddle" class="popR05 PL03" /> <SPAN id="title1"
							class="PL03">상담신청 답변</SPAN></td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/new.gif" id="IMG_BTN_NEW"
									width="50" height="22" onClick="btn_New();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/del.gif"
									id="IMG_BTN_DEL" width="50" height="22" onClick="btn_Delete()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/save.gif"
									id="IMG_BTN_SAVE" width="50" height="22" onClick="btn_Save()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/buyer_change.gif "
									id="IMG_BUYER_CHANGE" width="77" height="22"
									onClick="btn_BuyerCng()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
									height="22" onClick="btn_Close('close');" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="10"></td>
			</tr>
			<tr>
				<td class="sub_title"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />상담신청정보</td>
			</tr>
			<tr>
				<td class="popT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="70">회사명</th>
								<td width="138"><comment id="_NSID_"> <object
									id=EM_RQ_COMPNM classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="70">대표자명</th>
								<td width="293"><comment id="_NSID_"> <object
									id=EM_RQ_REPNM classid=<%=Util.CLSID_EMEDIT%> width=290 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="70">신청일자</th>
								<td><comment id="_NSID_"> <object id=EM_RQ_DATE tabindex=1
									classid=<%=Util.CLSID_EMEDIT%> width=141 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>신청인</th>
								<td><comment id="_NSID_"> <object id=EM_RQ_NAME tabindex=1
									classid=<%=Util.CLSID_EMEDIT%> width=135 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
								<th>Email</th>
								<td><comment id="_NSID_"> <object id=EM_RQ_EMAIL tabindex=1
									classid=<%=Util.CLSID_EMEDIT%> width=290 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
								<th>휴대폰번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_RQ_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> - <comment
									id="_NSID_"> <object id=EM_RQ_MOBILE_PH2
									classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script> - <comment id="_NSID_">
								<object id=EM_RQ_MOBILE_PH3 tabindex=1 classid=<%=Util.CLSID_EMEDIT%>
									width=40 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_RQ_TITLE classid=<%=Util.CLSID_EMEDIT%> width=519 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th>전화번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_RQ_PHONE1_NO classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1 
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> - <comment
									id="_NSID_"> <object id=EM_RQ_PHONE2_NO tabindex=1
									classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script> - <comment id="_NSID_">
								<object id=EM_RQ_PHONE3_NO classid=<%=Util.CLSID_EMEDIT%> tabindex=1
									width=40 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>상담신청내역</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=TXT_RQ_CONTEN classid=<%=Util.CLSID_TEXTAREA%> height=95 tabindex=1
									width=755 tabindex=0 tabindex=1 align="absmiddle"> </object></comment> <script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
                                <td colspan="5"><comment id="_NSID_"> <object
                                    id=LC_RQ_FILE classid=<%=Util.CLSID_LUXECOMBO%> width=300 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                    <img id="IMG_RQ_FILE" onclick="javascript:saveAsFiles();"
                                    style="vertical-align: middle;"
                                    src="/<%=dir%>/imgs/btn/file_down.gif" />
                                </td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="2"></td>
			</tr>
			<tr>
				<td class="sub_title"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />답변내역</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr valign="top">
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td width="100%"><comment id="_NSID_"><object
									id=GD_DETAIL width=100% height=118 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_DETAIL">
								</object></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td class="sub_title"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" />답변상세</td>
			</tr>
			<tr>
				<td class="popT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="80">상담장소</th>
								<td width="215"><comment id="_NSID_"> <object
									id=EM_DELI_PLACE classid=<%=Util.CLSID_EMEDIT%> width=210 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="80">상담예정일</th>
								<td width="175"><comment id="_NSID_"> <object
									id=EM_DELI_DT classid=<%=Util.CLSID_EMEDIT%> width=122 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif" id="IMG_DELI_DT"
									onclick="javascript:openCal('G',EM_DELI_DT)" align="absmiddle" /></td>
								<th width="80">상담예정시간</th>
								<td><comment id="_NSID_"> <object
									id=LC_DELI_TIME_HH name="CONTENTS" tabindex=1
									classid=<%=Util.CLSID_LUXECOMBO%> width=60 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script> : <comment id="_NSID_">
								<object id=LC_DELI_TIME_MM name="CONTENTS" tabindex=1
									classid=<%=Util.CLSID_LUXECOMBO%> width=60 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>ON/OFF라인<BR>
								상담여부</th>
								<td><comment id="_NSID_"> <object
									id=LC_ONOFFLINE_FLAG classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1
									width=213 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th>바이어 연락처</th>
								<td colspan="3"><comment id="_NSID_"> <object 
									id=EM_BY_PHONE1_NO classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> - <comment
									id="_NSID_"> <object id=EM_BY_PHONE2_NO tabindex=1
									classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script> - <comment id="_NSID_">
								<object id=EM_BY_PHONE3_NO classid=<%=Util.CLSID_EMEDIT%> tabindex=1
									width=40 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>답변유형</th>
								<td><comment id="_NSID_"> <object id=LC_ANS_TYPE tabindex=1
									classid=<%=Util.CLSID_LUXECOMBO%> width=213 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
								<th>거절상세</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=LC_RJT_REASON classid=<%=Util.CLSID_LUXECOMBO%> width=144 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>상담답변내역</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=TXT_ANS_CONTENT classid=<%=Util.CLSID_TEXTAREA%> height=75 tabindex=1
									width=100% tabindex=0 tabindex=1 align="absmiddle"
									onkeyup="javascript:textAreaMaxlength(TXT_ANS_CONTENT, 4000);"
									onkeyDown="javascript:textAreaMaxlength(TXT_ANS_CONTENT, 4000);"
									onkeyPress="javascript:textAreaMaxlength(TXT_ANS_CONTENT, 4001);">
								</object></comment> <script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=EM_AN_FILE classid=<%=Util.CLSID_EMEDIT%> width=590
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/file_search.gif" id=IMG_AN_FILE
									onClick="javascript:openFile();" align="absmiddle" /><img
									id="IMG_FILE_DEL" style="vertical-align: middle;"
									onclick="javascript:deleteFile();"
									src="/<%=dir%>/imgs/btn/file_del.gif" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
		<td class="pop06"></td>
	</tr>
	<tr>
		<td class="pop07"></td>
		<td class="pop08"></td>
		<td class="pop09"></td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_IO_DETAIL classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_DETAIL>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=DELI_PLACE       Ctrl=EM_DELI_PLACE      param=Text</c>
        <c>Col=DELI_DT          Ctrl=EM_DELI_DT         param=Text</c>
        <c>Col=DELI_TIME_HH     Ctrl=LC_DELI_TIME_HH    param=BindColVal</c>
        <c>Col=DELI_TIME_MM     Ctrl=LC_DELI_TIME_MM    param=BindColVal</c>
        <c>Col=ONOFF_FLAG       Ctrl=LC_ONOFFLINE_FLAG  param=BindColVal</c>
        <c>Col=BUYER_PHONE1_NO  Ctrl=EM_BY_PHONE1_NO    param=Text</c>
        <c>Col=BUYER_PHONE2_NO  Ctrl=EM_BY_PHONE2_NO    param=Text</c>
        <c>Col=BUYER_PHONE3_NO  Ctrl=EM_BY_PHONE3_NO    param=Text</c>
        <c>Col=ANS_TYPE         Ctrl=LC_ANS_TYPE        param=BindColVal</c>
        <c>Col=RJT_REASON       Ctrl=LC_RJT_REASON      param=BindColVal</c>
        <c>Col=ANS_CONTENT      Ctrl=TXT_ANS_CONTENT    param=Text</c>
        <c>Col=FILE_NM          Ctrl=EM_AN_FILE         param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BD_O_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_O_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=COMP_NAME        Ctrl=EM_RQ_COMPNM       param=Text</c>
        <c>Col=REP_NAME         Ctrl=EM_RQ_REPNM        param=Text</c>
        <c>Col=REQ_DT           Ctrl=EM_RQ_DATE         param=Text</c>
        <c>Col=REQ_NAME         Ctrl=EM_RQ_NAME         param=Text</c>
        <c>Col=PHONE1_NO        Ctrl=EM_RQ_PHONE1_NO    param=Text</c>
        <c>Col=PHONE2_NO        Ctrl=EM_RQ_PHONE2_NO    param=Text</c>
        <c>Col=PHONE3_NO        Ctrl=EM_RQ_PHONE3_NO    param=Text</c>
        <c>Col=MOBILE_PH1       Ctrl=EM_RQ_MOBILE_PH1   param=Text</c>
        <c>Col=MOBILE_PH2       Ctrl=EM_RQ_MOBILE_PH2   param=Text</c>
        <c>Col=MOBILE_PH3       Ctrl=EM_RQ_MOBILE_PH3   param=Text</c>
        <c>Col=TITLE            Ctrl=EM_RQ_TITLE        param=Text</c>
        <c>Col=EMAIL            Ctrl=EM_RQ_EMAIL        param=Text</c>
        <c>Col=REQ_CONTENT      Ctrl=TXT_RQ_CONTEN      param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

