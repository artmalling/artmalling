<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 타사카드 > 청구관리  > 수기승인등록
 * 작 성 일 : 2011.08.12
 * 작 성 자 : 김영진
 * 수 정 자 : 
 * 파 일 명 : psal9140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2011.08.12 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToMonth = strToMonth + "01";
	String strTime = new java.text.SimpleDateFormat("hh:mm:ss").format(new java.util.Date());
	strTime = strTime.replaceAll(":","");
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var intChangRow       = 0;
var strExlParam = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_CARDBIN.setDataHeader('<gauce:dataset name="H_CARDBIN"/>');
    
    //그리드 초기화
    gridCreate1();  

    //-- 입력필드 
    initEmEdit(EM_APPR_DT1_S,   "YYYYMMDD",      PK);    
    initEmEdit(EM_APPR_DT2_S,   "TODAY",         PK);      
    
    initComboStyle(LC_STR_CD_S,  DS_O_S_STR,  "CODE^0^30, NAME^0^100", 1, PK);
    initComboStyle(LC_BCOMP_S,   DS_O_BCOMP,  "CODE^0^30, NAME^0^90", 1, NORMAL);

    //EMedit에 초기화
    getBcompCode("DS_O_BCOMP", "", "", "Y");    
    getStore("DS_O_S_STR", "Y", "", "N");
    
    initEmEdit(EM_CARD_NO,    "0000-0000-0000-0000",  PK);  //-- 카드번호
    initEmEdit(EM_EXP_DT,     "00/MM",                PK);  
    initEmEdit(EM_DIV_MONTH,  "NUMBER^2^0",           NORMAL);  //-- 할부개월
    initEmEdit(EM_APPR_AMT,   "NUMBER^8^0",           PK);  //-- 총매출
    initEmEdit(EM_APPR_NO,    "0000000000",           PK);  //-- 승인번호
    initEmEdit(EM_APPR_DT,    "YYYYMMDD",             PK);       
    initEmEdit(EM_APPR_TIME,  "HHMISS",               PK);       
    initEmEdit(EM_CAN_DT,     "YYYYMMDD",             NORMAL);       
    initEmEdit(EM_CAN_TIME,   "HHMISS",               NORMAL);       
    initEmEdit(EM_CCOMP_CD,   "00",                   PK);             
    initEmEdit(EM_CCOMP_NM,   "GEN^20",               READ);       

    initComboStyle(LC_BCOMP_CD, DS_O_BCOMP_D,  "CODE^0^30, NAME^0^80",   1, PK);
    initComboStyle(LC_JBRCH_ID, DS_O_JBRCH_ID, "CODE^0^120, NAME^0^180", 1, PK);
    
    getBcompCode("DS_O_BCOMP_D", "", "", "N");     
    
    EM_APPR_DT1_S.text =  '<%=strToMonth%>';
    
    LC_BCOMP_S.index    = 0;
    LC_STR_CD_S.index   = 0;   
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal914","DS_IO_DETAIL");
    
    btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"            width=30      align=center</FC>'
                     + '<FC>id=CARD_NO      name="카드번호"       width=133     align=center mask="XXXX-XXXX-XXXX-XXXX" SumText= "합계"</FC>'
                     + '<FC>id=EXP_DT       name="유효기간"       width=55      align=center  mask="XX/XX"</FC>'
                     + '<FC>id=APPR_AMT     name="승인금액"       width=110     align=right   SumText=@sum</FC>'
                     + '<FC>id=DIV_MONTH    name="할부"           width=40      align=right</FC>'
                     + '<FC>id=APPR_DTIME   name="승인일시"       width=130     align=center mask="XXXX/XX/XX XX:XX:XX"</FC>'
                     + '<FC>id=APPR_NO      name="승인번호"       width=85      align=center</FC>'
                     + '<FC>id=CAN_DTIME    name="취소승인일시"   width=130     align=center mask="XXXX/XX/XX XX:XX:XX"</FC>'
                     + '<FC>id=CCOMP_NM     name="발급사"         width=100     align=left</FC>'
                     + '<FC>id=BCOMP_NM     name="매입사"         width=100     align=left</FC>'
                     + '<FC>id=JBRCH_ID     name="가맹점번호"     width=85      align=center</FC>'
                     + '<FC>id=CHRG_DT      name="청구일자"       width=80      align=center mask="XXXX/XX/XX"</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            return false;
        }else{
          strChangFlag = true;
        }
    }
    if (trim(LC_STR_CD_S.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
        LC_STR_CD_S.Focus();
        return;
    }   
    if (trim(EM_APPR_DT1_S.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1001",  "승인 시작일자");
        EM_APPR_DT1_S.Focus();
        return;
    }
    if (trim(EM_APPR_DT2_S.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1001",  "승인 종료일자");
        EM_APPR_DT2_S.Focus();
        return;
    }   
    
    if( EM_APPR_DT1_S.Text > EM_APPR_DT2_S.Text){        //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_APPR_DT1_S.Focus();
        return;
    }   
 
    //조회
    showMaster(); 
    bfListRowPosition = 0;
}

/**
 * btn_New()
 * 작   성   자 : 김영진
 * 작   성   일 : 2011-06-03
 * 개           요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
            setTimeout("LC_STR_CD_S.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "REQ_DT") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }
    DS_O_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();

    initComboStyle(LC_BCOMP_CD, DS_O_BCOMP_D,  "CODE^0^30, NAME^0^80",   1, PK);
    initComboStyle(LC_JBRCH_ID, DS_O_JBRCH_ID, "CODE^0^120, NAME^0^180", 1, PK);
    
    initEmEdit(EM_APPR_DT,    "TODAY",       PK);       
    initEmEdit(EM_APPR_TIME,  "HHMISS",      PK);       
    initEmEdit(EM_CAN_DT,     "YYYYMMDD",    NORMAL);       
    initEmEdit(EM_CAN_TIME,   "HHMISS",      NORMAL);       

    EM_APPR_TIME.TEXT = '<%=strTime%>';
    
    RD_WORK_FLAG.Enable= true;
    EM_CARD_NO.Enable  = true;
    EM_EXP_DT.Enable   = true;
    EM_DIV_MONTH.Enable= true;
    EM_APPR_AMT.Enable = true;
    EM_APPR_NO.Enable  = true;
    EM_APPR_DT.Enable  = true;
    EM_APPR_TIME.Enable= true;
    EM_CCOMP_CD.Enable = true;
    LC_BCOMP_CD.Enable = true;
    LC_JBRCH_ID.Enable = true;
    enableControl(IMG_APPR_DT, true);
    EM_CAN_DT.Enable   = false;
    EM_CAN_TIME.Enable = false;
    enableControl(IMG_CAN_DT,  false);
    
    RD_WORK_FLAG.CodeValue = "11";
    strChangFlag = false;
    bfListRowPosition = 0;
    intChangRow = 1;
    RD_WORK_FLAG.focus();
}

/**
 * btn_Save()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 
    if(DS_O_MASTER.CountRow != 0 && DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHRG_DT") != ""){
        showMessage(EXCLAMATION, OK, "USER-1000", "청구 완료건입니다. 수정 할 수 없습니다.");
        return;
    }
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }     

    if (trim(EM_CARD_NO.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드번호");
        EM_CARD_NO.Focus();
        return;
    }
    if (trim(EM_EXP_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "유효기간");
        EM_EXP_DT.Focus();
        return;
    } 
    if (trim(EM_CCOMP_CD.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사");
        EM_CCOMP_CD.Focus();
        return;
    }     
    if (trim(LC_BCOMP_CD.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "카드매입사");
        LC_BCOMP_CD.Focus();
        return;
    }     
    if (trim(LC_JBRCH_ID.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "가맹점번호");
        LC_JBRCH_ID.Focus();
        return;
    }     
    if (trim(EM_APPR_AMT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "승인금액");
        EM_APPR_AMT.Focus();
        return;
    }     
    if (trim(EM_APPR_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "승인일시");
        EM_APPR_DT.Focus();
        return;
    }   
    if (trim(EM_APPR_TIME.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "승인일시");
        EM_APPR_TIME.Focus();
        return;
    } 
    if (trim(EM_APPR_NO.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "승인번호");
        EM_APPR_NO.Focus();
        return;
    }     
    if(trim(EM_DIV_MONTH.Text).length == 0){
    	EM_DIV_MONTH.Text = "0";
    }
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
    }   
    
    if(intChangRow != 1){
        intChangRow = DS_O_MASTER.RowPosition;
    }
    bfListRowPosition = 0;
    saveData();
}

/**
 * btn_Delete()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개       요 : 선택된 수기승인 삭제 
 * return값 : void
 */
function btn_Delete(){
     
    var row = DS_IO_DETAIL.RowPosition;

    if(DS_O_MASTER.CountRow != 0 && DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CHRG_DT") != ""){
        showMessage(EXCLAMATION, OK, "USER-1000", "청구 완료건입니다. 삭제 할 수 없습니다.");
        return;
    }
    if (DS_O_MASTER.CountRow == 0){
        //삭제할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    
    if ( DS_O_MASTER.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1056") != 1 ){
            return false;
        }else{
            DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            doClick(DS_O_MASTER.RowPosition);
            return false;
        }
    }else{
        if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
            return;
        }
    }

    DS_IO_DETAIL.DeleteRow(row);
     
    var goTo       = "saveData";    
    var action     = "I";     
    var parameters = "&strReqDt="    + encodeURIComponent(DS_O_MASTER.NameValue(row ,"REQ_DT"))
                   + "&strFclFlag="  + encodeURIComponent(DS_O_MASTER.NameValue(row ,"FCL_FLAG"))
                   + "&strSeqNo="    + encodeURIComponent(DS_O_MASTER.NameValue(row ,"SEQ_NO"));
    
    TR_MAIN.Action  = "/dps/psal914.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    bfListRowPosition = 0;
    //조회
    showMaster(); 
}  

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2011-08-12
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "수기승인등록";
    openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
    GR_MASTER.Focus();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-12
 * 개       요     : 청구대상 데이터 조회 
 * return값 : void
 */
function showMaster(){     
	 
    var strStrCd   = LC_STR_CD_S.BindColVal;
    var strApprDt1 = EM_APPR_DT1_S.text; 
    var strApprDt2 = EM_APPR_DT2_S.text; 
    var strBcompCd = LC_BCOMP_S.BindColVal;
    
    strExlParam = "점포명="       + LC_STR_CD_S.Text
                + " -승인일자="   + strApprDt1 + "~" + strApprDt2
                + " -카드매입사=" + LC_BCOMP_S.Text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="     +  encodeURIComponent(strStrCd)  
                    + "&strApprDt1="   +  encodeURIComponent(strApprDt1)
                    + "&strApprDt2="   +  encodeURIComponent(strApprDt2)    
                    + "&strBcompCd="   +  encodeURIComponent(strBcompCd);  
    TR_MAIN1.Action  = "/dps/psal914.ps?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN1.Post();
 
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
 
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
        if(intChangRow > 0){
            bfListRowPosition = DS_O_MASTER.RowPosition;
            setFocusGrid(GR_MASTER, DS_O_MASTER, intChangRow);
            doClick(intChangRow);
        }
    }

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * doOnClick()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개       요 : 선택된 수기승인 상세 조회 
 * return값 : void
 */
function doClick(row){
    
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;

    var goTo          = "searchDetail";    
    var action        = "O";     
    var parameters    = "&strReqDt="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"REQ_DT"))
                      + "&strFclFlag=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"FCL_FLAG"))
                      + "&strSeqNo="   +encodeURIComponent( DS_O_MASTER.NameValue(row ,"SEQ_NO"));
    
    TR_DETAIL.Action  = "/dps/psal914.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    //청구일자가 없는 건은 수정/삭제가능
    if(DS_O_MASTER.NameValue(row ,"CHRG_DT") == ""){
    	RD_WORK_FLAG.Enable= true;
        EM_CARD_NO.Enable  = true;
        EM_EXP_DT.Enable   = true;
        EM_DIV_MONTH.Enable= true;
        EM_APPR_AMT.Enable = true;
        EM_APPR_NO.Enable  = true;
        EM_APPR_DT.Enable  = true;
        EM_APPR_TIME.Enable= true;
        EM_CCOMP_CD.Enable = true;
        LC_BCOMP_CD.Enable = true;
        LC_JBRCH_ID.Enable = true;
        enableControl(IMG_APPR_DT, true);

        if(RD_WORK_FLAG.CodeValue == "11"){
            EM_CAN_DT.Enable   = false;
            EM_CAN_TIME.Enable = false;
            enableControl(IMG_CAN_DT,  false);
        }else{
            EM_CAN_DT.Enable   = true;
            EM_CAN_TIME.Enable = true;
            enableControl(IMG_CAN_DT,  true);
        }
    }else{
        LC_STR_CD_S.Focus();
        RD_WORK_FLAG.Enable= false;
        EM_CARD_NO.Enable  = false;
        EM_EXP_DT.Enable   = false;
        EM_DIV_MONTH.Enable= false;
        EM_APPR_AMT.Enable = false;
        EM_APPR_NO.Enable  = false;
        EM_APPR_DT.Enable  = false;
        EM_APPR_TIME.Enable= false;
        EM_CCOMP_CD.Enable = false;
        LC_BCOMP_CD.Enable = false;
        LC_JBRCH_ID.Enable = false;
        enableControl(IMG_APPR_DT, false);
        EM_CAN_DT.Enable   = false;
        EM_CAN_TIME.Enable = false;
        enableControl(IMG_CAN_DT,  false);
    }
    
    //Dataset status 초기화.
    //DS_IO_DETAIL.ResetStatus();
}

/**
 * saveData()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개       요 : 수기승인 등록/수정
 * return값 : void
 */
function saveData(){
     
	var strStrCd   = LC_STR_CD_S.BindColVal;
    var goTo       = "saveData";
    var action     = "I";  //조회는 O
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd);  
    
    TR_MAIN.Action  ="/dps/psal914.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();

    btn_Search();
}  

/**
 * searchCardBin(strCardNo)
 * 작 성 자     : 김영진
 * 작 성 일     : 2011-08-12
 * 개       요     : 카드번호 6자리로 카드 발급사, 매입사 코드 가져오기
 * return값 : void
 */
function searchCardBin(cardNo){ 
    var goTo        = "searchCardBin";    
    var action      = "O";     
    var parameters  = "&strCardNo="  +  encodeURIComponent(cardNo) ;  
    TR_CARDBIN.Action  = "/dps/psal914.ps?goTo="+goTo+parameters;  
    TR_CARDBIN.KeyValue= "SERVLET("+action+":DS_O_CARDBIN=DS_O_CARDBIN)"; //조회는 O
    TR_CARDBIN.Post();
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2011-08-12
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode, objCd, objNm) { 
    objNm.Text = "";//조건입력시 코드초기화 
	if (objCd.Text.length > 0 ) {
	    if (kcode == 13 || kcode == 9 || objCd.Text.length == 2) { //TAB,ENTER 키 실행시에만  
	        var goTo       = "searchOnMaster" ;    
	        var action     = "O";     
	        var parameters = "&strCcompCd="+encodeURIComponent(objCd.Text);
	        
	        TR_MAIN.Action="/pot/ccom027.cc?goTo="+goTo+parameters;
	        TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_RESULT)"; //조회는 O
	        TR_MAIN.Post();
	          
	        if (DS_O_RESULT.CountRow == 1 ) {
	            objCd.Text   = DS_O_RESULT.NameValue(1, "CODE");
	            objNm.Text   = DS_O_RESULT.NameValue(1, "NAME");
	        } else {
	             //1건 이외의 내역이 조회 시 팝업 호출
	            getCcompPop(objCd, objNm)
	        }
	    }  
	}  
} 
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
    intChangRow = 0;
    bfListRowPosition = DS_O_MASTER.RowPosition;
</script>
<script language=JavaScript for=TR_CARDBIN event=onSuccess>
    for(i=0;i<TR_CARDBIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CARDBIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN1 event=onFail>
    trFailed(TR_MAIN1.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<script language=JavaScript for=TR_CARDBIN event=onFail>
    trFailed(TR_CARDBIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("LC_STR_CD_S.Focus();",50);
            return false;
        }else {
            strChangFlag = true;
            intChangRow = 0;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "REQ_DT") == "")
                DS_O_MASTER.DeleteRow(row);
            return true;
        }
    }else{
         return true;
    }
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        if( intChangRow == 0 ){
            bfListRowPosition = row;
            doClick(row);
        }
    }else{
        DS_IO_DETAIL.ClearData();
    }
</script>

<!-- 승인일자 Start onKillFocus() -->
<script language=JavaScript for=EM_APPR_DT1_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_APPR_DT1_S)){
    	EM_APPR_DT1_S.text = '<%=strToMonth%>';
    }
</script>

<!-- 승인일자 End onKillFocus() -->
<script language=JavaScript for=EM_APPR_DT2_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_APPR_DT2_S)){
        initEmEdit(EM_APPR_DT2_S,   "TODAY",       PK);    
    }
</script>  

<!-- 처리구분 선택이벤트 처리 -->
<script language=JavaScript for=RD_WORK_FLAG event=OnSelChange()>
    if(this.CodeValue == "11"){
    	EM_CAN_DT.Text     = "";
    	EM_CAN_TIME.Text   = "";
        EM_CAN_DT.Enable   = false;
        EM_CAN_TIME.Enable = false;
        enableControl(IMG_CAN_DT,  false);
        EM_APPR_TIME.TEXT = '<%=strTime%>';
    }else{
        EM_CAN_DT.Enable   = true;
        EM_CAN_TIME.Enable = true;
        enableControl(IMG_CAN_DT,  true);
        initEmEdit(EM_CAN_DT,  "TODAY",           NORMAL); 
        EM_CAN_TIME.TEXT = '<%=strTime%>';
    }
</script>

<!-- 유효기간  onKillFocus() -->
<script language=JavaScript for=EM_EXP_DT event=onKillFocus()>
    if(trim(EM_EXP_DT.Text).length > 0 && trim(EM_EXP_DT.Text).length < 4){
        showMessage(EXCLAMATION, OK, "USER-1004",  "유효기간");
        EM_EXP_DT.Text = "";
        EM_EXP_DT.Focus();
        return;
    }
</script>  

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD event=OnSelChange()>
    DS_O_JBRCH_ID.ClearData();
    getJbrchCode("DS_O_JBRCH_ID", this.BindColVal, "N");
</script>

<!-- 카드번호 onKillFocus()-->
<script language=JavaScript for=EM_CARD_NO event=onKillFocus()>
    if(trim(EM_CARD_NO.Text).length > 0 && trim(EM_CARD_NO.Text).length < 16){
        showMessage(EXCLAMATION, OK, "USER-1004",  "카드번호");
        EM_CARD_NO.Text = "";
        setTimeout("EM_CARD_NO.Focus();",50);
        return false;
    }
    if(trim(EM_CARD_NO.Text).length == 16){
    	searchCardBin(this.Text);
    }
</script>

<!-- 승인일시  onKillFocus() -->
<script language=JavaScript for=EM_APPR_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_APPR_DT)){
        initEmEdit(EM_APPR_DT,  "TODAY",       PK);  
    }
</script>  
 
<!-- 승인일시  onKillFocus() -->
<script language=JavaScript for=EM_APPR_TIME event=onKillFocus()>
    if(trim(EM_APPR_TIME.Text).length < 6){
        EM_APPR_TIME.TEXT = '<%=strTime%>';
    }
</script>  

<!-- 취소승인일시  onKillFocus() -->
<script language=JavaScript for=EM_CAN_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_CAN_DT)){
        initEmEdit(EM_CAN_DT,  "TODAY",       PK);  
    }
</script>  

<!-- 취소승인일시  onKillFocus() -->
<script language=JavaScript for=EM_CAN_TIME event=onKillFocus()>
    if(trim(EM_CAN_TIME.Text).length < 6){
    	EM_CAN_TIME.TEXT = '<%=strTime%>';
    }
</script>  

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_CARDBIN classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP_D classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_JBRCH_ID" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_S_STR classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_CARDBIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

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
						<th width="80" class="point">점포명</th>
						<td width="160"><comment id="_NSID_"> <object
							id=LC_STR_CD_S classid=<%=Util.CLSID_LUXECOMBO%> width=130
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80" class="point">승인일자</th>
                        <td width="200"><comment id="_NSID_"> <object id=EM_APPR_DT1_S
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_APPR_DT1_S)" />- <comment
                            id="_NSID_"> <object id=EM_APPR_DT2_S
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_APPR_DT2_S)" /></td>
						<th width="80">카드매입사</th>
						<td><comment id="_NSID_"> <object id=LC_BCOMP_S
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=120
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
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
	<tr>
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=397 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">처리구분</th>
						<td width="180"><comment id="_NSID_"> <object
							id=RD_WORK_FLAG classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 180" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="11^정상,12^취소">
							<param name="AutoMargin" value="true">
							<param name=CodeValue value="11">
						</object> </comment><script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">카드번호</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=157 tabindex=1></object>
						</comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">유효기간</th>
						<td><comment id="_NSID_"> <object id=EM_EXP_DT
							classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80" class="point">카드발급사</th>
						<td><comment id="_NSID_"> <object id=EM_CCOMP_CD
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode, EM_CCOMP_CD, EM_CCOMP_NM);"></object>
						</comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCcompPop(EM_CCOMP_CD, EM_CCOMP_NM)" /> <comment
							id="_NSID_"> <object id=EM_CCOMP_NM
							classid=<%=Util.CLSID_EMEDIT%> width=101 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">카드매입사</th>
						<td><comment id="_NSID_"> <object id=LC_BCOMP_CD
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=160
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">가맹점번호</th>
						<td><comment id="_NSID_"> <object id=LC_JBRCH_ID
							classid=<%=Util.CLSID_LUXECOMBO%> width=143 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80" class="point">승인금액</th>
						<td><comment id="_NSID_"> <object id=EM_APPR_AMT
							classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">승인일시</th>
						<td><comment id="_NSID_"> <object id=EM_APPR_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" id="IMG_APPR_DT"
							align="absmiddle" onclick="javascript:openCal('G',EM_APPR_DT)" />&nbsp;<comment
							id="_NSID_"> <object id=EM_APPR_TIME
							classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">승인번호</th>
						<td><comment id="_NSID_"> <object id=EM_APPR_NO
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">할부개월수</th>
						<td><comment id="_NSID_"> <object id=EM_DIV_MONTH
							classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">취소승인일시</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_CAN_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" id="IMG_CAN_DT"
							align="absmiddle" onclick="javascript:openCal('G',EM_CAN_DT)" />&nbsp;<comment
							id="_NSID_"> <object id=EM_CAN_TIME
							classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script></td>
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
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
               <c>col=WORK_FLAG   ctrl=RD_WORK_FLAG    Param=CodeValue</c>
               <c>col=CARD_NO     ctrl=EM_CARD_NO      Param=Text</c>
               <c>col=EXP_DT      ctrl=EM_EXP_DT       Param=Text</c>
               <c>col=DIV_MONTH   ctrl=EM_DIV_MONTH    Param=Text</c>
               <c>col=APPR_AMT    ctrl=EM_APPR_AMT     Param=Text</c>
               <c>col=APPR_NO     ctrl=EM_APPR_NO      Param=Text</c>
               <c>col=APPR_DT     ctrl=EM_APPR_DT      Param=Text</c>
               <c>col=APPR_TIME   ctrl=EM_APPR_TIME    Param=Text</c>
               <c>col=CAN_DT      ctrl=EM_CAN_DT       Param=Text</c>
               <c>col=CAN_TIME    ctrl=EM_CAN_TIME     Param=Text</c>
               <c>col=CCOMP_CD    ctrl=EM_CCOMP_CD     Param=Text</c>
               <c>col=CCOMP_NM    ctrl=EM_CCOMP_NM     Param=Text</c>
               <c>col=BCOMP_CD    ctrl=LC_BCOMP_CD     Param=BindColVal</c>
               <c>col=JBRCH_ID    ctrl=LC_JBRCH_ID     Param=BindColVal</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_CARDBIN>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
               <c>col=CCOMP_CD    ctrl=EM_CCOMP_CD     Param=Text</c>
               <c>col=CCOMP_NM    ctrl=EM_CCOMP_NM     Param=Text</c>
               <c>col=BCOMP_CD    ctrl=LC_BCOMP_CD     Param=BindColVal</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
