<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 점내 불출신청
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 : 2011.01.18 (김성미) 신규작성
           2011.04.05 (김정민) 프로그램작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" 
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<% request.setCharacterEncoding("utf-8"); %>

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

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var gv_preRowno = "1";  //이전ROWNO
var lcstrVal    = "";   //이전LC_O_STR_CD
var g_select = false;
var strSaveFlag = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 var top2 = 265;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');

    //그리드 초기화
    gridCreate1(); //마스터&디테일
    
    // EMedit에 초기화
     initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                   //기간 : 시작
     initEmEdit(EM_E_DT, "YYYYMMDD", PK);                    //기간 : 종료
     initEmEdit(EM_I_POUT_REQ_DT, "YYYYMMDD", PK);           //불출신청일자
     
     //EM_S_DT.Text           = getTodayFormat("YYYYMMDD");   //기간 : 시작
     EM_E_DT.Text           = getTodayFormat("YYYYMMDD");   //기간 : 종료
     EM_I_POUT_REQ_DT.Text  = getTodayFormat("YYYYMMDD");   //불출신청일자
     
     initEmEdit(EM_O_EVENT_CD,   "GEN^11", NORMAL);         //행사코드(조회)
     initEmEdit(EM_O_EVENT_NAME, "GEN^40", READ);           //행사명(조회)
     initEmEdit(EM_I_ORG_CD,     "GEN^10",  NORMAL);         //신청부서코드
     initEmEdit(EM_I_ORG_NAME,   "GEN^40", READ);           //신청부서명
     initEmEdit(EM_I_EVENT_CD,   "GEN^11", NORMAL);         //행사코드
     initEmEdit(EM_I_EVENT_NAME, "GEN^40", READ);           //행사명
     initEmEdit(EM_I_POUT_RSN,   "GEN^50", NORMAL);         //사유 
  
    //콤보 초기화 
     initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              //점코드(조회)
     initComboStyle(LC_O_POUT_TYPE,DS_O_POUT_TYPE, "CODE^0^30,NAME^0^180", 1, NORMAL);    //불출유형(조회)
     initComboStyle(LC_O_CONF_FLAG,"", "CODE^0^30,NAME^0^60", 1, NORMAL);    //확정구분(조회)
     initComboStyle(LC_I_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              //점
     initComboStyle(LC_I_POUT_TYPE,DS_I_POUT_TYPE, "CODE^0^30,NAME^0^180", 1, NORMAL);    //불출유형
  
    //공통코드에서 가져오기
    getStore("DS_O_STR_CD", "Y", "1", "N");   //점(조회)
    getEtcCode("DS_O_POUT_TYPE", "D", "M014", "Y", "N", LC_O_POUT_TYPE);   //불출유형(조회)
    getEtcCode("DS_I_POUT_TYPE", "D", "M014", "N", "N", LC_I_POUT_TYPE);   //불출유형 
    
    // 불출유형중 재무강제불출(5) 삭제
    DS_O_POUT_TYPE.DeleteRow(DS_O_POUT_TYPE.NameValueRow("CODE","5"));
    DS_I_POUT_TYPE.DeleteRow(DS_I_POUT_TYPE.NameValueRow("CODE","5"));
    // 불출유형중 재무강제불출(특판)(6) 삭제
    DS_O_POUT_TYPE.DeleteRow(DS_O_POUT_TYPE.NameValueRow("CODE","6"));
    DS_I_POUT_TYPE.DeleteRow(DS_I_POUT_TYPE.NameValueRow("CODE","6"));
    
    LC_O_STR_CD.Index    = 0; //점(조회)
    LC_O_POUT_TYPE.Index = 0; //불출유형(조회)
    LC_O_CONF_FLAG.Index = 0; //확정구분(조회)
    
    //그리드DETAIL 콤보조회 
    getEtcCodeSub("DS_O_GIFT_TYPE_CD",  "1");                // 상품권종류       
    getEtcCodeSub("DS_O_GIFT_AMT_TYPE",  "2");                // 금종     
    getGiftType("DS_O_GIFT_AMT_TYPE_2");                // 금종(GRID)   
    
    getEnable(false);
   
    
    LC_I_STR_CD.BindColVal    = ""; //점 
    LC_I_POUT_TYPE.BindColVal = ""; //불출유형 
    EM_I_POUT_REQ_DT.Text = "";
    LC_I_POUT_TYPE.Text = "";
    
    enableControl(Addrow, false);
    enableControl(Delrow, false);
    
    LC_O_STR_CD.Focus();
    
  //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif210", "DS_O_MASTER,DS_O_DETAIL"); 
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"         width=25    align=center</FC>'
                     + '<FC>id=STR_CD           name="점"          width=70   align=center'
                     + ' EDITSTYLE=LOOKUP   DATA="DS_O_STR_CD:CODE:NAME"  </FC>'
                     + '<FC>id=POUT_REQ_DT      name="신청일자"     width=80   align=center'
                     + ' MASK="XXXX/XX/XX"</FC>'
                     + '<FC>id=POUT_REQ_SLIP_NO name="순번"        width=60   align=center</FC>'
                     + '<FC>id=CONF_FLAG        name="확정구분"     width=60   align=center  </FC>'
                     + '<FC>id=POUT_TYPE        name="불출유형"     width=120   align=left'
                     + ' EDITSTYLE=LOOKUP   DATA="DS_O_POUT_TYPE:CODE:NAME"  </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}            name="NO"           width=30   align=center</FC>'
				    	+ '<FC>id=POUT_REQ_SEQ_NO   name="순번"          width=100  align=right</FC>'
				        + ' edit=numeric Edit="NONE"  show="false" </FC>'
				        + '<FC>id=GIFT_TYPE_CD      name="*상품권종류" sumtext="합계"    width=130  align=left'
				        + ' EDITSTYLE=LOOKUP   DATA="DS_O_GIFT_TYPE_CD:CODE:NAME" </FC>'
				        + '<FC>id=GIFT_AMT_TYPE     name="*금종"         width=120  align=left'
                        + ' EDITSTYLE=LOOKUP   DATA="DS_O_GIFT_AMT_TYPE:CODE:NAME" </FC>' 
				        + '<FC>id=GIFTCERT_AMT      name="상품권금액"     width=90   align=right'
				        + ' edit=numeric Edit="NONE" </FC>'
				        + '<FC>id=REQ_QTY           name="*신청수량"  sumtext=@sum     width=90   align=right</FC>'
                        + ' edit=Numeric </FC>'
				        + '<FC>id=REQ_AMT           name="신청금액"  sumtext=@sum      width=100  align=right</FC>'
                        + ' edit=numeric Edit="NONE"  </FC>';
                    
        initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(DS_O_MASTER.CountRow >= 1){ 
        if (DS_O_MASTER.IsUpdated || DS_O_DETAIL.IsUpdated) {
            var ret = showMessage(Question, YesNo, "USER-1059");
            if (ret != "1") {
            	DS_O_MASTER.RowPosition = gv_preRowno;
                return;
            }
        } 
    }
    getEnable(false);
    
    if (EM_S_DT.Text > EM_E_DT.Text){  //기간
        showMessage(INFORMATION, OK, "USER-1008", "종료일자", "시작일자");
        EM_E_DT.Focus()
        return;
    }
 
    DS_O_MASTER.ClearData();

    var strStr      = LC_O_STR_CD.BindColVal;     //점코드
    var strSrart    = EM_S_DT.Text;               //기간 from
    var strEnd      = EM_E_DT.Text;               //기간 To
    var strEvent    = EM_O_EVENT_CD.Text;         //행사코드
    var strPout     = LC_O_POUT_TYPE.BindColVal;  //불출유형
    var strConf     = LC_O_CONF_FLAG.BindColVal;  //확정구분

    var goTo       = "getMaster";
    var action     = "O";
    var parameters = "&strStr="   + encodeURIComponent(strStr)
                   + "&strSrart=" + encodeURIComponent(strSrart) 
                   + "&strEnd="   + encodeURIComponent(strEnd)
                   + "&strPout="  + encodeURIComponent(strPout)
                   + "&strConf="  + encodeURIComponent(strConf)
                   + "&strEvent=" + encodeURIComponent(strEvent); 
    
    TR_MAIN.Action   = "/mss/mgif210.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)";
    g_select = true;
    TR_MAIN.Post();
    g_select = false;
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);  
    getDetail2();
    if (DS_O_MASTER.CountRow == 0) { 
    	DS_O_MASTER.ClearData();
    	DS_O_DETAIL.ClearData();
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
  
    for(var i=1; i<=DS_O_MASTER.CountRow; i++){
         if(DS_O_MASTER.NameValue(i,"POUT_REQ_SLIP_NO")== ""){
            return false; 
         }       
    }

    enableControl(Addrow, true);
    enableControl(Delrow, true);
    
     DS_O_MASTER.AddRow();
     
    EM_I_POUT_REQ_DT.Text = getTodayFormat("YYYYMMDD");   //신청일자
    EM_I_ORG_CD.Text = "";
    EM_I_ORG_NAME.Text = "";
    EM_I_EVENT_CD.Text = "";
    EM_I_EVENT_NAME.Text = "";
    EM_I_POUT_RSN.Text = "";
     
    //콤보
    LC_I_STR_CD.Index = 0;          //점 
    LC_I_POUT_TYPE.Index = 0;       //불출유형 

    DS_O_DETAIL.ClearData();

    DS_O_GIFT_AMT_TYPE.Filter();
    
    getEnable(true);
    setTimeout("LC_I_STR_CD.Focus()",100);  
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	if (DS_O_MASTER.CountRow == 0 || DS_O_DETAIL.CountRow == 0){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
	
	if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CONF_FLAG") == "확정"){
        showMessage(Question, OK, "USER-1000", "확정된 전표는 삭제할 수 없습니다")
        return;
    }
	
    if (DS_O_DETAIL.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1056") != "1") {
       //     DS_O_MASTER.RowPosition = gv_preRownoMaster;
       //     DS_O_DETAIL.RowPosition = gv_preRownoDetail;
            return;
        }
    }    
    if (!DS_O_DETAIL.IsUpdated) {
        if(showMessage(Question, YESNO, "USER-1023") != 1){
             return;
        }
    }
    

    DS_O_DETAIL.UseChangeInfo = "false";
    
    var strStrCd    = LC_I_STR_CD.BindColVal;     // 점 
    var strPoutDt   = EM_I_POUT_REQ_DT.Text;      // 신청일자 
    var strSlipno  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO");         // 불출사유
    
    var goTo = "delete";
    var parameters = "&strStrCd="       + encodeURIComponent(strStrCd) 
                   + "&strPoutDt="      + encodeURIComponent(strPoutDt)
                   + "&strSlipno="      + encodeURIComponent(strSlipno);
    TR_MAIN.Action = "/mss/mgif210.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_O_DETAIL=DS_O_DETAIL)";
    TR_MAIN.Post(); 
    
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    btn_Search();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
   /* if (DS_DETAIL.IsUpdated){
        if (checkDup() == true){
            return;
        }   
    }*/
    
    if (!DS_O_DETAIL.IsUpdated && !DS_O_MASTER.IsUpdated){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }
    if(LC_I_POUT_TYPE.BindColVal == "3") {
    	if(EM_I_EVENT_CD.Text == "") { 
            showMessage(INFORMATION, OK, "USER-1000", "불출유형이 사은행사 지급용일 경우 <br> 행사코드를 반드시 입력 하셔야 합니다.");
            setTimeout("LC_I_POUT_TYPE.Focus();", 50); 
            return;
    	}
    } 
    
    if(EM_I_ORG_CD.Text == "") {
    	showMessage(INFORMATION, OK, "USER-1000", "신청부서를 반드시 입력 하셔야 합니다.");
        setTimeout("EM_I_ORG_CD.Focus();", 50); 
        return;
    }
    
    if(EM_I_POUT_REQ_DT.Text == "") {
        showMessage(INFORMATION, OK, "USER-1000", "신청일자를 반드시 입력 하셔야 합니다.");
        setTimeout("EM_I_POUT_REQ_DT.Focus();", 50); 
        return;
    }
        
    for(var i=0; i <= DS_O_DETAIL.CountRow; i++) {
    	if(DS_O_DETAIL.NameValue(i,"GIFT_TYPE_CD") == "") {  
            showMessage(StopSign, OK, "USER-1002", "상품권종류"); 
            setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "GIFT_TYPE_CD");
            return;
    	}
    	if(DS_O_DETAIL.NameValue(i,"GIFT_AMT_TYPE") == "") {  
            showMessage(StopSign, OK, "USER-1002", "금종"); 
            setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "GIFT_AMT_TYPE");
            return;
        }
    	if(DS_O_DETAIL.NameValue(i,"REQ_QTY") == "" || DS_O_DETAIL.NameValue(i,"REQ_QTY") == 0) {  
            showMessage(StopSign, OK, "USER-1002", "신청수량"); 
            setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "REQ_QTY");
            return;
        }
    }
    
    if(DS_O_DETAIL.CountRow == "0") {
    	 showMessage(INFORMATION, OK, "USER-1000", "신청 상세내역을 입력 하셔야 합니다.");
         setTimeout("GD_DETAIL.Focus();", 50); 
         return;
    }
    
  //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
        LC_I_STR_CD.Focus();
        return;
    }
    
    var strStrCd    = LC_I_STR_CD.BindColVal;     // 점
    var strOrgCd    = EM_I_ORG_CD.Text;           // 신청부서
    var strPoutDt   = EM_I_POUT_REQ_DT.Text;      // 신청일자
    var strPoutType = LC_I_POUT_TYPE.BindColVal;  // 불출유형
    var strEventCd  = EM_I_EVENT_CD.Text;         // 행사코드
    var strPoutRsn  = EM_I_POUT_RSN.Text;         // 불출사유
    
    var strPoutSlip = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO");
    strSaveFlag = true;
    var goTo = "save";
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strOrgCd="    + encodeURIComponent(strOrgCd)
                   + "&strPoutDt="   + encodeURIComponent(strPoutDt)
                   + "&strPoutType=" + encodeURIComponent(strPoutType)
                   + "&strEventCd="  + encodeURIComponent(strEventCd)
                   + "&strPoutRsn="  + encodeURIComponent(strPoutRsn)
                   + "&strPoutSlip=" + encodeURIComponent(strPoutSlip);
    TR_MAIN.Action = "/mss/mgif210.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_O_DETAIL=DS_O_DETAIL,I:DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();
   
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    if(TR_MAIN.ErrorCode == 0) btn_Search();
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-05-06
 * 개    요 : 상품권 점내 불출 신청서 출력
 * return값 : void
 */
function btn_Print() {
	    var params   = "&strStrCd="+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD")
	                 + "&strPourReqDt="+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POUT_REQ_DT")
	                 + "&strPourReqSlipNo="+DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "POUT_REQ_SLIP_NO")
	                 + "&strUserID="+strUserID;
	    window.open("/mss/mgif210.mg?goTo=print"+params, "OZREPORT", 1000, 700);
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

/**
 * addRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행추가
 * return값 : void
 */

function addRow() {
   if(DS_O_MASTER.CountRow == 0){
       return;
   }  
   for(var i=1; i<=DS_O_DETAIL.CountRow; i++) {
	   if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD") == "") { 
           showMessage(EXCLAMATION, OK, "USER-1002", "상품권종류"); 
           setFocusGrid(GD_DETAIL, DS_O_DETAIL, i+1, "GIFT_TYPE_CD");
           return;
	   }
	   if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") == "") {  
           showMessage(EXCLAMATION, OK, "USER-1002", "금종"); 
           setFocusGrid(GD_DETAIL, DS_O_DETAIL, i+1, "GIFT_AMT_TYPE");
           return;
       }
	   if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"REQ_QTY") == "") { 
		   showMessage(EXCLAMATION, OK, "USER-1002", "신청수량"); 
           setFocusGrid(GD_DETAIL, DS_O_DETAIL, i+1, "REQ_QTY");
           return;
       }
   }
   DS_O_DETAIL.AddRow(); 
    
   if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD") == "") { 
       GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',   'Edit') = "NONE";   // 상품권종류
   }
   else { 
       GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',   'Edit') = "";   // 상품권종류 
   }
   
   setFocusGrid(GD_DETAIL, DS_O_DETAIL, DS_O_DETAIL.CountRow, "GIFT_TYPE_CD");
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {
    if(DS_O_DETAIL.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
           return;
       } 
    
    DS_O_DETAIL.DeleteRow(DS_O_DETAIL.RowPosition);
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-05
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail() { 
	 
	 if(DS_O_MASTER.CountRow >= 1) {
		 if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CONF_FLAG")== "확정") {
	          enableControl(Addrow, false);
	          enableControl(Delrow, false);
	     }
	     else {
	          enableControl(Addrow, true);
	          enableControl(Delrow, true);
	     }
	        var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
	        var strOrgCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORG_CD");
	        var strPoutReqDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_DT");
	        var strPoutType  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_TYPE");
            var strPoutSlipNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO");
	       
	        var goTo       = "getDetail" ;    
	        var action     = "O";     
	        var parameters = "&strStrCd="       + encodeURIComponent(strStrCd)
	                       + "&strOrgCd="       + encodeURIComponent(strOrgCd)
	                       + "&strPoutReqDt="   + encodeURIComponent(strPoutReqDt)
                           + "&strPoutType="    + encodeURIComponent(strPoutType)
	                       + "&strPoutSlipNo="  + encodeURIComponent(strPoutSlipNo);
	       
	        TR_MAIN.Action="/mss/mgif210.mg?goTo="+goTo+parameters;  
	        TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	        TR_MAIN.Post();
	        
	        setPorcCount("SELECT", GD_DETAIL);  
	        
	        // 조회시 CONF_FLAG 값에 따라 컨트롤제어
	        Conf_flag();

	        GD_DETAIL.Editable = "true";
	        GD_DETAIL.ColumnProp('GIFT_TYPE_CD',   'Edit') = "NONE";   // 상품권종류
	        GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',  'Edit') = "NONE";   // 금종 
	 } 
	 else {
		 return;
	 }
}

 /**
  * getDetail2()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-05
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail2() { 
     if(DS_O_MASTER.CountRow >= 1) {
         if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CONF_FLAG")== "확정") {
              enableControl(Addrow, false);
              enableControl(Delrow, false);
         }
         else {
              enableControl(Addrow, true);
              enableControl(Delrow, true);
         }
            var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
            var strOrgCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORG_CD");
            var strPoutReqDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_DT");
            var strPoutType  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_TYPE");
            var strPoutSlipNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO");
           
            var goTo       = "getDetail" ;    
            var action     = "O";     
            var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                           + "&strOrgCd="     + encodeURIComponent(strOrgCd)
                           + "&strPoutReqDt=" + encodeURIComponent(strPoutReqDt)
                           + "&strPoutType="  + encodeURIComponent(strPoutType)
                           + "&strPoutSlipNo="+ encodeURIComponent(strPoutSlipNo);
           
            TR_MAIN.Action="/mss/mgif210.mg?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
            TR_MAIN.Post();
            
            // 조회시 CONF_FLAG 값에 따라 컨트롤제어
            Conf_flag();
            GD_DETAIL.Editable = "true";
            GD_DETAIL.ColumnProp('GIFT_TYPE_CD',   'Edit') = "NONE";   // 상품권종류
            GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',  'Edit') = "NONE";   // 금종 
     } 
     else {
         return;
     }
}

 /**
  * getEtcCodeSub()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.10
  * 개    요 : 공통코드가져오기
  * return값 :
  */
 function getEtcCodeSub(objDateSet, objCode) {  
	 
	 var strGiftType = DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD"); 
	 
     var goTo = "getEtcCodeSub";
     var parameters = ""
         + "&strDSName="      + encodeURIComponent(objDateSet)
         + "&strEtcCode="     + encodeURIComponent(objCode)
         + "&strGiftType="    + encodeURIComponent(strGiftType);
      //   alert(objCode);
     TR_MAIN.Action = "/mss/mgif210.mg?goTo=" + goTo + parameters; 
     TR_MAIN.KeyValue = "SERVLET(O:"+objDateSet+"="+objDateSet+")";
     TR_MAIN.StatusResetType= "2";
     TR_MAIN.Post();
 }
 
 
 /**
  * getEnable()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.10
  * 개    요 : 공통코드가져오기
  * return값 :
  */
  function getEnable(strGbn) { 
	  if(strGbn == true){
		  LC_I_STR_CD.Enable = true;
          EM_I_POUT_REQ_DT.Enable = true;
          LC_I_POUT_TYPE.Enable = true;
          EM_I_EVENT_CD.Enable = false;
          EM_I_POUT_RSN.Enable = true;
          enableControl(popEvent, false);
          enableControl(popReq, true); 
	  }
	  else {
		  LC_I_STR_CD.Enable = false;
          EM_I_POUT_REQ_DT.Enable = false;
          LC_I_POUT_TYPE.Enable = false;
          EM_I_EVENT_CD.Enable = false;
          EM_I_POUT_RSN.Enable = true;
          enableControl(popEvent, false);
          enableControl(popReq, false);
	  }
  }
 

  /**
   * Select_gbn()
   * 작 성 자 : 김정민
   * 작 성 일 : 2011.04.07
   * 개    요 : 조회 후 CONF_FLAG값에 따라 컨트롤 제어
   * return값 :
   */
   function Conf_flag() { 
	   if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CONF_FLAG")== '확정') {  
	        GD_DETAIL.ColumnProp("GIFT_TYPE_CD","Edit")="None";
	        GD_DETAIL.ColumnProp("GIFT_AMT_TYPE","Edit")="None";
            GD_DETAIL.ColumnProp("REQ_QTY","Edit")="None"; 
            enableControl(Addrow, false);
            enableControl(Delrow, false);
	   } 
	   else {
		   GD_DETAIL.ColumnProp("GIFT_TYPE_CD","Edit")="";
           GD_DETAIL.ColumnProp("GIFT_AMT_TYPE","Edit")="";
           GD_DETAIL.ColumnProp("REQ_QTY","Edit")="Numeric"; 
		   enableControl(Addrow, true);
           enableControl(Delrow, true);
	   }
   }
 
  /**
   * getGiftType()
   * 작 성 자 : 김정민
   * 작 성 일 : 2011.04.07
   * 개    요 : 금종에대한 상품권금액 조회
   * return값 :
   */
 function getGiftType() {
//	 DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") = "";
	 
	 var strGiftType = DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD"); 
     var strGiftAmt  = DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE");

     var goTo = "getGiftType";
     var parameters = ""  
         + "&strGiftType="  + encodeURIComponent(strGiftType)
         + "&strGiftAmt="   + encodeURIComponent(strGiftAmt);
      //   alert(objCode);
     TR_MAIN.Action = "/mss/mgif210.mg?goTo=" + goTo + parameters; 
     TR_MAIN.KeyValue = "SERVLET(O:DS_O_GIFT_AMT_TYPE_2=DS_O_GIFT_AMT_TYPE_2)";
     TR_MAIN.StatusResetType= "2";
     TR_MAIN.Post(); 
 
     DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFTCERT_AMT")= DS_O_GIFT_AMT_TYPE_2.NameValue(1,"GIFTCERT_AMT");
     
 }
  
  function getEvtOrg(){
     var strStrCd  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
     var strEventCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"EVENT_CD"); 

     var goTo = "getEvtOrg";
     var parameters = ""  
         + "&strStrCd="     + encodeURIComponent(strStrCd)
         + "&strEventCd="   + encodeURIComponent(strEventCd);
     TR_MAIN.Action = "/mss/mgif210.mg?goTo=" + goTo + parameters; 
     TR_MAIN.KeyValue = "SERVLET(O:DS_I_ORG_CD=DS_I_ORG_CD)";
     TR_MAIN.Post(); 
     
     if(DS_I_ORG_CD.CountRow == 0){
    	 showMessage(EXCLAMATION, OK, "USER-1000", "행사별 조직코드 조회에 실패했습니다."); 
    	 EM_I_ORG_CD.Text = "";
    	 EM_I_ORG_NAME.Text = "";
    	 return;
     }
     EM_I_ORG_CD.Text = DS_I_ORG_CD.NameValue(1,"ORG_CD");
     EM_I_ORG_NAME.Text = DS_I_ORG_CD.NameValue(1,"ORG_NM");
  }
  
  
  function getEvent(){
	  mssEventMstPop('SEL_STR_EVENT_POP',EM_I_EVENT_CD,EM_I_EVENT_NAME,LC_I_STR_CD.BindColVal, '4/6', '', EM_I_POUT_REQ_DT.Text, EM_I_POUT_REQ_DT.Text);
	  if(EM_I_EVENT_CD.Text.length == "11"){
		  getEvtOrg();
	  }
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
 /*   showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

//alert("OnRowPosChanged(row)" + g_select);
if(clickSORT) return;
    if (row > 0 && g_select==false) {  
    	setTimeout("getDetail()",50);
    	GD_DETAIL.SetColumn("GIFT_TYPE_CD");
    }
    
    if(this.NameValue(row, "CONF_FLAG") != "")
    	getEnable(false);	
    else 
    	getEnable(true);
</script>  

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (DS_O_DETAIL.RowStatus(row) == "1") {
        GD_DETAIL.Editable = "true";
        GD_DETAIL.ColumnProp('GIFT_TYPE_CD',   'Edit') = "";       // 상품권종류
        GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',  'Edit') = "";       // 금종 
    } else {
        GD_DETAIL.Editable = "true";
        GD_DETAIL.ColumnProp('GIFT_TYPE_CD',   'Edit') = "NONE";   // 상품권종류
        GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',  'Edit') = "NONE";   // 금종 
    }
</script> 

<script language=JavaScript for=DS_O_GIFT_AMT_TYPE event=OnFilter(row)>
    if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD") != "") {
    	if(DS_O_GIFT_AMT_TYPE.NameValue(row,"TYPE").substring(0,4) == DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD")){ 
            return true;
    	}
    	else {
    		 return false;
    	} 
    }
    else { 
    	return;
    }
</script>

<!-- DETAIL에서 콤보 선택 시 이벤트 발생 -->
<script language=JavaScript for=GD_DETAIL event=OnCloseUp(row,colid)>
	if(colid == "GIFT_TYPE_CD") {
		if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD") == "") { 
		       GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',   'Edit') = "NONE";   // 상품권종류
		   }
		   else { 
		       GD_DETAIL.ColumnProp('GIFT_AMT_TYPE',   'Edit') = "";   // 상품권종류 
		   }
		
	    DS_O_GIFT_AMT_TYPE.Filter();
	}
	
    if(colid == "GIFT_AMT_TYPE") {
    	if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE")!= "") {
	    	if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD") == "") {
	    		showMessage(INFORMATION, OK, "USER-1000", "상품권종류를 먼저 선택 해야 합니다.");
	    		DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") = ""; 
	    		GD_DETAIL.SetColumn("GIFT_TYPE_CD");
	    		return;
	    	}
    	}
    	for (var i=1; i<=DS_O_DETAIL.CountRow-1; i++){
    		if(DS_O_DETAIL.ContRow == "1") {
    			return;
    		}
    		 if (DS_O_DETAIL.NameValue(i, "GIFT_TYPE_CD") == DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "GIFT_TYPE_CD")){
    			 if (DS_O_DETAIL.NameValue(i,"GIFT_AMT_TYPE") == DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE")) { 
    				 if(DS_O_DETAIL.CountRow == "0"){
    					 return;
    				 }
    				 else { 
                         showMessage(StopSign, OK, "USER-1018", i,"금종");
                         DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") = "";  
                         return;
    				 }
    			 }
    		 }
        }  
      if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") != "") {
    	  getGiftType();  
      } 
    }
    
</script>


<script language=JavaScript for=DS_O_DETAIL event=OnColumnChanged(row,colid)>
if(colid == "GIFT_TYPE_CD") {   
//	alert();
    //  alert(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"SKU_CD"));
        getGiftType("DS_O_GIFT_AMT_TYPE_2");                // 금종(GRID)  
       DS_O_GIFT_AMT_TYPE.Filter(); 
       DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") = "";
       DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFTCERT_AMT") = ""; 
       DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"REQ_QTY") = "";
       DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"REQ_AMT") = ""; 
    }
   
</script>

<!-- 조회 후 DETAIL 수정 후 MASTER 클릭시 이벤트 발생  -->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)> 

//alert("CanRowPosChange" + g_select);
if (!strSaveFlag) {
    if (DS_O_MASTER.CountRow > 0) {
        if (DS_O_MASTER.RowStatus(row) == 1) { // 신규행작성시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
            	DS_O_MASTER.DeleteRow(row);
                return true;    
            } else {
                return false;   
            }
        } else if (DS_O_MASTER.RowStatus(row) == 3) { //데이터 변경시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                rollBackRowData(DS_O_MASTER, row);
                return true;    
            } else {
                return false;   
            }
        }
        if(DS_O_DETAIL.IsUpdated) {
        	  var ret = showMessage(Question, YesNo, "USER-1049");
              if (ret == "1") {
                  rollBackRowData(DS_O_MASTER, row);
                  return true;    
              } else {
                  return false;   
              }
        }
        return true;
    }
    return true;
}
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,olddata)> 
    if(colid == "REQ_QTY") { 
    	var strAmt = DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFTCERT_AMT") * DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"REQ_QTY");
    	DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"REQ_AMT") = strAmt;
    }
</script>       
 
 
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
  
<script language=JavaScript for=LC_O_POUT_TYPE event=OnSelChange()>
    if(LC_O_POUT_TYPE.BindColVal == "3") {
        EM_O_EVENT_CD.Text = "";
        EM_O_EVENT_NAME.Text = "";
    	EM_O_EVENT_CD.Enable = true;
    	enableControl(EventImg, true);
    }
    else {
    	EM_O_EVENT_CD.Text = "";
        EM_O_EVENT_NAME.Text = "";
    	EM_O_EVENT_CD.Enable = false;
        enableControl(EventImg, false);
        
    }
</script> 

<script language=JavaScript for=LC_I_POUT_TYPE event=OnSelChange()>
// 기존에 등록된 경우엔 비활성화
if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO") != "") {
    // EM_I_EVENT_CD.Text = "";
    // EM_I_EVENT_NAME.Text = "";
     EM_I_EVENT_CD.Enable = false;
     enableControl(popEvent, false);
     EM_I_ORG_CD.Enable = false;
     enableControl(popOrg, false);
     return;
 }
 // 신규전표이며 불출유형이 3인경우 행사 및 신청부서 정보 초기화 
if(LC_I_POUT_TYPE.BindColVal == "3") {
	EM_I_EVENT_CD.Text = "";
    EM_I_EVENT_NAME.Text = "";
    EM_I_ORG_CD.Text = "";
    EM_I_ORG_NAME.Text = "";
    EM_I_EVENT_CD.Enable = true;
    enableControl(popEvent, true);
    EM_I_ORG_CD.Enable = false;
    enableControl(popOrg, false);
    return;
    
}
if(LC_I_POUT_TYPE.BindColVal != "3" ) {
       EM_I_EVENT_CD.Text = "";
       EM_I_EVENT_NAME.Text = "";
       EM_I_ORG_CD.Text = "";
       EM_I_ORG_NAME.Text = "";
       EM_I_EVENT_CD.Enable = false;
       enableControl(popEvent, false);
       EM_I_ORG_CD.Enable = true;
       enableControl(popOrg, true);
       
}
</script> 
 
<script language=JavaScript for=EM_O_EVENT_CD event=onKillFocus()>
   // if (EM_O_EVENT_CD.Text.length > 0 ) { 
	   
			   
		if(!this.Modified)
		        return;
		        
		    if(this.text==''){
		    	EM_O_EVENT_NAME.Text = "";
		        return;
		    }
		 
		if(LC_O_STR_CD.BindColVal == "%"){
		        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
		        LC_O_STR_CD.Focus();
		        return;
		    }
		setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_O_EVENT_CD, EM_O_EVENT_NAME, LC_O_STR_CD.BindColVal, '4');      
        if (DS_O_RESULT.CountRow == 1 ) {  
        	EM_O_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_O_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출   
            mssEventMstPop('SEL_STR_EVENT_POP',EM_O_EVENT_CD,EM_O_EVENT_NAME,LC_O_STR_CD.BindColVal, '4');
        }
 //   }  
</script>
 
<script language=JavaScript for=EM_I_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length > 0 ) { 
	  if(!this.Modified)
                return;
                
            if(this.text==''){
            	EM_I_EVENT_NAME.Text = "";
            	EM_I_ORG_CD.Text = "";
                EM_I_ORG_NAME.Text = "";
                return;
            }
         
            if(LC_I_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_I_STR_CD.Focus();
                return;
            }

        setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_I_EVENT_CD, EM_I_EVENT_NAME, LC_I_STR_CD.BindColVal, '4');     
        if (DS_O_RESULT.CountRow == 1 ) {  
        	EM_I_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
        	EM_I_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        	getEvtOrg();
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출  
          //  mssEventMstPop('SEL_STR_EVENT_POP',EM_I_EVENT_CD,EM_I_EVENT_NAME,LC_I_STR_CD.BindColVal, '4');
          //  mssEventMstPop('SEL_STR_EVENT_POP',EM_I_EVENT_CD,EM_I_EVENT_NAME,LC_I_STR_CD.BindColVal, '4/6', '', EM_I_POUT_REQ_DT.Text, EM_I_POUT_REQ_DT.Text);
            getEvent();
        }
        
  //  }  
     
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
<!-- 점조회 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 불출유형(조회) -->
<comment id="_NSID_"><object id="DS_O_POUT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 확정구분 -->
<comment id="_NSID_"><object id="DS_O_CONF_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 불출유형 -->
<comment id="_NSID_"><object id="DS_I_POUT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_TYPE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_AMT_TYPE_2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 
 <comment id="_NSID_">
<object id="DS_O_GIFT_AMT_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
 
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ORG_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="70" class="point">점</th>
            <td width="120">
                <comment id="_NSID_"> 
                <object id=LC_O_STR_CD classid=<%=Util.CLSID_LUXECOMBO%>  tabindex=1  height=100 width=120 align="absmiddle"></object> 
                </comment> 
                <script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">기간</th>
            <td width="250">
                <comment id="_NSID_"> 
                    <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle"  tabindex=1 
                            onblur="javascript:checkDateTypeYMD(this);"></object>
                </comment> 
                <script>_ws_(_NSID_);</script> 
                <img src="/<%=dir%>/imgs/btn/date.gif" id="btnactdt" align="absmiddle"
                     onclick="javascript:openCal('G',EM_S_DT)" /> ~
                <comment id="_NSID_"> 
                    <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle"  tabindex=1 
                            onblur="javascript:checkDateTypeYMD(this);"></object>
                </comment> 
                <script>_ws_(_NSID_);</script> 
                <img src="/<%=dir%>/imgs/btn/date.gif" id="btnactdt" align="absmiddle"
                     onclick="javascript:openCal('G',EM_E_DT)" />
           </td>
           <th width="80">확정구분</th>
             <td><comment id="_NSID_"> <object id=LC_O_CONF_FLAG
                            classid=<%=Util.CLSID_LUXECOMBO%> width="145" height=20
                            tabindex=1 align="absmiddle">
                            <param name=CBData value="%^전체,1^확정,9^신청">
                            <param name=CBDataColumns value="CODE,NAME">
                            <param name=SearchColumn value="NAME">
                            <param name=ListExprFormat value="CODE^0^30,NAME^0^100">
                            <param name=FontSiz value="9">
                            <param name=FontSiz value="돋움">
                            <param name=className value="combo">
                            <param name=BindColumn value="CODE">
                        </object> </comment><script>_ws_(_NSID_);</script></td>
          </tr>  
          <tr> 
            <th>불출유형</th>
             <td width="120">
               <comment id="_NSID_">
               <object id=LC_O_POUT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 tabindex=1  align="absmiddle">
               </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>행사</th> 
             <td colspan=3>
                 <comment id="_NSID_">
                       <object id=EM_O_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script> 
                 <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"  id=EventImg  
                      onclick="javascript:mssEventMstPop('SEL_STR_EVENT_POP',EM_O_EVENT_CD,EM_O_EVENT_NAME,LC_O_STR_CD.BindColVal, '4/6','',EM_S_DT.Text, EM_E_DT.Text);"  class="PR03"/> 
                 <comment id="_NSID_">
                       <object id=EM_O_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>   width=378 tabindex=1 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script>
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
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width=210>
            <table width="100%" border="1" cellpadding="0" cellspacing="0" class="BD4A">
            <tr>
            <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=450 height=764 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
            </tr>
            </table>
        </td>
        <td class="PL05">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT5" colspan=2>
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>신청마스터</td>
              </tr>
            </table>
           </td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="70" class="point">점</th>
		            <td width="160">
		                <comment id="_NSID_"> 
		                <object id=LC_I_STR_CD tabindex=1  classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=140 align="absmiddle"></object> 
		                </comment> 
		                <script>_ws_(_NSID_);</script>
		            </td>
		            <th width="70" class="point">신청부서</th>
                    <td>              
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
                  <tr>
                    <th width="70" class="point">신청일자</th>
                    <td>
                        <comment id="_NSID_">
		                <object id=EM_I_POUT_REQ_DT classid=<%=Util.CLSID_EMEDIT%>   width=117 tabindex=1 
		                 onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
		                </object>
		                 </comment><script>_ws_(_NSID_);</script>
		                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_I_POUT_REQ_DT)" align="absmiddle" id=popReq />
                    </td>
                    <th width="70" class="point">불출유형</th>
                    <td>
                       <comment id="_NSID_">
                       <object id=LC_I_POUT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100  tabindex=1  width=257 align="absmiddle">
                       </object>
                       </comment><script>_ws_(_NSID_);</script>
                    </td> 
                  </tr>
                   <tr>
                    <th>행사</th>
                    <td colspan=3>
                        <comment id="_NSID_">
                               <object id=EM_I_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>   width=117 tabindex=1 align="absmiddle">
                               </object>
                         </comment><script>_ws_(_NSID_);</script>
                         <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" class="PR03"  
                              onclick="javascript:getEvent();" id=popEvent /> 
                         <comment id="_NSID_">
                               <object id=EM_I_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>   width=363 tabindex=1 align="absmiddle">
                               </object>
                         </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>   
                  <tr> 
                    <th>불출사유</th>
                    <td colspan=3>
                        <comment id="_NSID_">
                          <object id=EM_I_POUT_RSN classid=<%=Util.CLSID_EMEDIT%>   width=505 tabindex=1
                            onkeyup="javascript:checkByteStr(this, 50, 'Y');" align="absmiddle">
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                            
                </table></td>
              </tr>
            </table></td>
          </tr>
          <!--  그리드의 구분dot & 여백  -->
          <tr height=5><td></td></tr>
		  <tr valign="bottom"><td class="dot"></td></tr>
		  <!--  그리드의 구분dot & 여백  -->
		  <tr>
            <td class="PT5" colspan=2>
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>신청상세</td>
                <td class="right">
	                <img id=Addrow src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"  hspace="2" onClick="javascript:addRow();"/>
	                <img id=Delrow src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onClick="javascript:delRow();"/>
                </td>
              </tr>
            </table>
           </td>
          
          </tr>
          <tr valign=top>
                <td>
                 <table width="100%" border="1" cellpadding="0" cellspacing="0" class="BD4A">
                      <tr>
                        <td> 
                        <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=620 tabindex=1 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_O_DETAIL">
                            </OBJECT></comment><script>_ws_(_NSID_);</script></td>
                      </tr>                                 
                    </table>
                </td>
          </tr>         
        </table>
         </td>
      </tr>
    </table></td>
  </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=STR_CD       Ctrl=LC_I_STR_CD        param=BindColVal</c>  
        <c>Col=ORG_CD       Ctrl=EM_I_ORG_CD        param=Text</c>   
        <c>Col=ORG_NAME     Ctrl=EM_I_ORG_NAME      param=Text</c>  
        <c>Col=POUT_REQ_DT  Ctrl=EM_I_POUT_REQ_DT   param=Text</c>  
        <c>Col=POUT_TYPE    Ctrl=LC_I_POUT_TYPE     param=BindColVal</c>   
        <c>Col=EVENT_CD     Ctrl=EM_I_EVENT_CD      param=Text</c>  
        <c>Col=EVENT_NAME   Ctrl=EM_I_EVENT_NAME    param=Text</c>    
        <c>Col=POUT_RSN     Ctrl=EM_I_POUT_RSN      param=Text</c>      
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

