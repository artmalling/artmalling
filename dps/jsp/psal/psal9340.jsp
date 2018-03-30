<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 카드청구 > 반송건 재청구 생성
 * 작 성 일 : 2010.05.26
 * 작 성 자 : 김영진
 * 수 정 자 : 
 * 파 일 명 : psal9340.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.26 (김영진) 신규작성
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
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM")
			.format(new java.util.Date());
	strToMonth = strToMonth + "01";
	// PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
var bfListRowPosition = 0;                             // 이전 List Row Position
var EXCEL_PARAMS = "";
var parametersD  = "";
var strChkCnt = 0;
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-26
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_IO_DETAIL_D.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1();  

    initEmEdit(EM_PAY_DT_S,    "YYYYMMDD",               PK);           //청구제외 시작기간    
    initEmEdit(EM_PAY_DT_E,    "TODAY",                  PK);           //청구제외 종료기간
    initEmEdit(EM_APPR_NO,     "0000000000",             NORMAL);       //승인번호
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000-0000",    NORMAL);       //카드번호
    initEmEdit(EM_VRTN_CD_S,   "00",                     NORMAL);       //VAN 반송코드
    initEmEdit(EM_VRTN_NM_S,   "GEN^40",                 READ);         //VAN 반송코드명

    initEmEdit(EM_REQ_DT_D,      "GEN^8",                NORMAL); 
    initEmEdit(EM_FLAG_D,        "GEN^1",                NORMAL); 
    initEmEdit(EM_CHRG_DT_R,     "GEN^8",                READ); 
    initEmEdit(EM_CHRG_SEQR,     "GEN^3",                READ); 
    initEmEdit(EM_SEQ_NO_R,      "GEN^7",                READ); 
    initEmEdit(EM_FILLER_R,      "GEN^66",               READ); 
    
    initEmEdit(EM_REC_FLAG_R,    "GEN^1",                READ); 
    initEmEdit(EM_DEVICE_ID_R,   "GEN^10",               READ); 
    initEmEdit(EM_COMP_NO_R,     "#000000000",           READ); 
    initEmEdit(EM_CARD_NO_R,     "00000000000000000000",     READ); 
    initEmEdit(EM_EXP_DT_R,      "0000",                 READ); 
    initEmEdit(EM_DIV_MONTH_R,   "NUMBER^2^0",           READ); 
    initEmEdit(EM_APPR_AMT_R,    "NUMBER^12^0",          READ); 
    initEmEdit(EM_SVC_AMT_R,     "NUMBER^12^0",          READ); 
    initEmEdit(EM_APPR_NO_R,     "0000000000",           READ); 
    initEmEdit(EM_APPR_DT_R,     "YYYYMMDD",             READ); 
    initEmEdit(EM_APPR_TIME_R,   "000000",               READ); 
    initEmEdit(EM_CAN_DT_R,      "YYYYMMDD",             READ); 
    initEmEdit(EM_CCOMP_CD_R,    "GEN^2",                READ);  
    initEmEdit(EM_CCOMP_NM_R,    "GEN^40",               READ);  
    initEmEdit(EM_JBRCH_ID_R,    "GEN^15",               READ); 
    initEmEdit(EM_DOLLAR_FLAG_R, "GEN^4",                READ); 

    initEmEdit(EM_REC_FLAG_D,    "GEN^1",                NORMAL); 
    initEmEdit(EM_DEVICE_ID_D,   "CODE^10",              NORMAL); 
    initEmEdit(EM_COMP_NO_D,     "#000000000",           NORMAL); 
    initEmEdit(EM_CARD_NO_D,     "00000000000000000000",     NORMAL); 
    initEmEdit(EM_EXP_DT_D,      "0000",                 NORMAL); 
    initEmEdit(EM_DIV_MONTH_D,   "NUMBER^2^0",           NORMAL); 
    initEmEdit(EM_APPR_AMT_D,    "NUMBER^12^0",          NORMAL); 
    initEmEdit(EM_SVC_AMT_D,     "NUMBER^12^0",          NORMAL); 
    initEmEdit(EM_APPR_NO_D,     "0000000000",           NORMAL); 
    initEmEdit(EM_APPR_DT_D,     "YYYYMMDD",             NORMAL); 
    initEmEdit(EM_APPR_TIME_D,   "000000",               NORMAL); 
    initEmEdit(EM_CAN_DT_D,      "YYYYMMDD",             NORMAL); 
    initEmEdit(EM_CCOMP_CD_D,    "00",                   NORMAL);
    initEmEdit(EM_CCOMP_NM_D,    "GEN^40",               READ);  
    initEmEdit(EM_DOLLAR_FLAG_D, "GEN^4",                NORMAL); 
    
    initComboStyle(LC_JBRCH_ID_S, DS_O_JBRCH_ID,   "CODE^0^120, NAME^0^180", 1, NORMAL);
    initComboStyle(LC_JBRCH_ID_D, DS_O_JBRCH_ID_D, "CODE^0^120, NAME^0^180", 1, NORMAL);
    
    initComboStyle(LC_BCOMP_CD_R, DS_O_BCOMP_CD_R, "CODE^0^30,NAME^0^100", 1, READ);
    initComboStyle(LC_BCOMP_CD_D, DS_O_BCOMP_CD_D, "CODE^0^30,NAME^0^100", 1, NORMAL);
    
    initEmEdit(EM_MEMO_D,  "GEN^40",        NORMAL); 
    initComboStyle(LC_WORK_FLAG_R, DS_O_WORK_FLAG_R, "CODE^0^30,NAME^0^80", 1, READ);
    initComboStyle(LC_WORK_FLAG_D, DS_O_WORK_FLAG_D, "CODE^0^30,NAME^0^80", 1, NORMAL);
    initComboStyle(LC_REASON_CD_D, DS_O_REASON_D,    "CODE^0^30,NAME^0^80", 1, NORMAL);
    
    initComboStyle(LC_S_STR, DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_COND_BCOMP_CD, DS_O_COND_CARDCOMP_CODE, "CODE^0^30,NAME^0^100", 1, NORMAL);
    
    getStore("DS_O_S_STR", "Y", "", "N");
    getBcompCode("DS_O_BCOMP_CD_R", "", "", "N");    
    getBcompCode("DS_O_BCOMP_CD_D", "", "", "N");    
    getBcompCode("DS_O_COND_CARDCOMP_CODE", "", "", "Y");    
    getVcardCode("DS_O_VRTN_CD", "", "", "Y");
    
    getEtcCode("DS_O_WORK_FLAG_R", "D", "D035", "N");
    getEtcCode("DS_O_WORK_FLAG_D", "D", "D035", "N");
    
    EM_PAY_DT_S.text = <%=strToMonth%>;

    EM_CHRG_DT_R.style.display = "none";
    EM_CHRG_SEQR.style.display = "none";
    EM_SEQ_NO_R.style.display  = "none";
    EM_FILLER_R.style.display  = "none";
    EM_FLAG_D.style.display    = "none";
    EM_REQ_DT_D.style.display  = "none";
    LC_JBRCH_ID_S.Enable = false;
    
    setComboData(LC_COND_BCOMP_CD,  "%");   
    LC_S_STR.Index = 0; 
    RD_BUYREQ_YN_D.CodeValue = "Y";
    LC_REASON_CD_D.Enable = false;
    
    LC_WORK_FLAG_D.Index = 0;
    LC_BCOMP_CD_D.Index = 0;

    showMaster();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal934","DS_O_MASTER,DS_IO_DETAIL_D");
}

function gridCreate1(){
    
    var hdrProperies = '<FC>id={currow}   name="NO"              width=30       align=center</FC>'       
                     + '<FC>id=CHK_BOX    name=""                width=20       align=center     HeadCheckShow=true Edit=true  EditStyle=CheckBox  </FC>'         
                     + '<FC>id=PAY_DT     name="반송일자"         width=100      align=center     edit=none  mask="XXXX/XX/XX" show=false</FC>'                                                    
                     + '<FC>id=PAY_SEQ    name="반송순번"         width=130      align=center     show=false </FC>'                                                    
                     + '<FC>id=SEQ_NO     name="SEQ_NO"           width=100     align=center     show=false </FC>'                                                    
                     + '<FC>id=REC_FLAG   name="레코드구분"        width=70     align=center     edit=none  </FC>'                                        
                     + '<FC>id=DATA_FLAG  name="데이터구분"        width=90      align=center     show=false </FC>'                                        
                     + '<FC>id=SALE_DT    name="매출일자"          width=65      align=center     edit=none   mask="XX/XX/XX"</FC>'                                        
                     + '<FC>id=RECV_DT    name="접수일자"          width=65     align=center     edit=none    mask="XX/XX/XX"</FC>'                                        
                     + '<FC>id=CARD_NO    name="카드번호"          width=170     align=left     edit=none   mask="XXXX-XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=DIV_MONTH  name="할부기간"          width=60     align=right      edit=none  </FC>'
                     + '<FC>id=APPR_NO    name="승인번호"          width=80     align=center     edit=none  </FC>'
                     + '<FC>id=CRTN_CD    name="카드사 반송코드"    width=96     align=center     edit=none  </FC>'                                                    
                     + '<FC>id=VRTN_CD    name="VAN사 반송코드"     width=100     align=center     show=false </FC>'                                        
                     + '<FC>id=VRTN_NM    name="VAN사 반송코드"     width=100     align=left       edit=none  </FC>'                                        
                     + '<FC>id=TRADE_AMT  name="거래금액"          width=90      align=center     show=false </FC>'                                        
                     + '<FC>id=CCOMP_CD   name="카드사코드"        width=120     align=left       show=false </FC>'                                        
                     + '<FC>id=CCOMP_NM   name="카드사코드"        width=70     align=left       edit=none  </FC>'
                     + '<FC>id=JBRCH_ID   name="가맹점번호"        width=100     align=right      show=false </FC>'
                     + '<FC>id=JBRCH_NM   name="가맹점번호"        width=140     align=left       edit=none  </FC>'
                     + '<FC>id=BUYREQ_YN  name="재청구여부"        width=65     align=center     edit=none  </FC>'
                     + '<FC>id=REASON_CD  name="재청구미생성사유"  width=160     align=left       edit=none  </FC>'
                     + '<FC>id=MEMO       name="사유메모"          width=160     align=left      edit=none  </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_save()
     (3) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-26
 * 개       요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL_D.IsUpdated){
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
          setTimeout("EM_REC_FLAG_D.Focus();",50);
            return false;
        }
    }
    if(trim( EM_PAY_DT_S.Text).length == 0){          //청구제외 시작일
        showMessage(EXCLAMATION, OK, "USER-1001","청구제외일자");
        EM_PAY_DT_S.Focus();
        return;
    }
    if(trim(EM_PAY_DT_E.Text).length == 0){           //청구제외 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","청구제외일자");
        EM_PAY_DT_E.Focus();
        return;
    }
    if( EM_PAY_DT_S.Text > EM_PAY_DT_E.Text){         //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_PAY_DT_S.Focus();
        return;
    }
    
    showMaster();
 }

/**
 * btn_Excel()
 * 작  성 자    : 김영진
 * 작  성 일    : 2010-05-26
 * 개        요    : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }

    var ExcelTitle = "반송건 재청구 생성";
    //openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
    openExcel5(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true , "",g_strPid );

}

/**
 * btn_save()
 * 작  성 자    : 김영진
 * 작  성 일    : 2010-05-27
 * 개        요    : 싱글 저장
 * return값 : void
 */
function btn_Save(){
	strChkCnt = 0;
    for(var i=1; i<=DS_O_MASTER.CountRow; i++){
        if(DS_O_MASTER.NameValue(i, "CHK_BOX") != 'F'){
            strChkCnt++; 
        }
    }
    if (!DS_O_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    if( strChkCnt == 0 && RD_BUYREQ_YN_D.CodeValue == "N"){
        
        if(trim(LC_REASON_CD_D.Text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1002",  "재청구미생성사유");
            LC_REASON_CD_D.Focus();
            return;
        }
        
        if(trim(EM_MEMO_D.Text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1003",  "사유메모");
            EM_MEMO_D.Focus();
            return;
        }
    }
    if(strChkCnt > 1){  //일괄생성여부
    	//저장여부 QUESTION
        if( showMessage(QUESTION, YESNO, "USER-1000", "반송데이터를 수정없이 재청구데이타로 일괄생성 하시겠습니까?") != 1 ){
            return;
        }
    }else{
    	if(trim(EM_REQ_DT_D.Text) != ""){
            showMessage(EXCLAMATION, OK, "USER-1000",  "재청구가 완료되어 수정 할 수 없습니다.");
            GR_MASTER.Focus();
            return;
    	}
    	
    	//저장여부 QUESTION
        if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
            return;
        }
    }
    saveData();
    bfListRowPosition = 0;
 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-26
 * 개       요     : 조회시 호출
 * return값 : void
 */
function showMaster(){
	
    var strRegDtS   = EM_PAY_DT_S.Text; 
    var strRegDtE   = EM_PAY_DT_E.Text; 
    var strApprNo   = EM_APPR_NO.Text; 
    var strCardNo   = EM_CARD_NO_S.Text; 
    var strJbrchId  = LC_JBRCH_ID_S.BindColVal; 
    var strStrCd    = LC_S_STR.BindColVal;
    var strBcompCd  = LC_COND_BCOMP_CD.BindColVal;
    var strVrtnCd   = EM_VRTN_CD_S.Text;
    var strVrtnNm   = EM_VRTN_NM_S.Text;

   //var strBuyReqYn = RD_BUYREQ_YN.CodeValue;
    
    EXCEL_PARAMS = "점포명="  + LC_S_STR.Text
                 + " -반송수신일자=" + strRegDtS
                 + "~" + strRegDtE
                 + " -승인번호="   + strApprNo 
                 + " -카드매입사=" + LC_COND_BCOMP_CD.Text
                 + " -가맹점번호=" + strJbrchId
                 + " -카드번호="   + strCardNo
                 + " -VAN사 반송코드=" + strVrtnCd + " : " + strVrtnNm;
                 //+ " -재청구여부=" + RD_BUYREQ_YN.DataValue;

    var goTo        = "searchMaster";    
    var action      = "O";   
    var parameters  = "&strRegDtS="   + encodeURIComponent(strRegDtS)
                    + "&strRegDtE="   + encodeURIComponent(strRegDtE)
                    + "&strApprNo="   + encodeURIComponent(strApprNo)
                    + "&strCardNo="   + encodeURIComponent(strCardNo)
                    + "&strJbrchId="  + encodeURIComponent(strJbrchId)
                    + "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strBcompCd="  + encodeURIComponent(strBcompCd)
                    + "&strVrtnCd="   + encodeURIComponent(strVrtnCd);
                    //+ "&strBuyReqYn=" + strBuyReqYn;
    
    TR_MAIN2.Action  = "/dps/psal934.ps?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN2.Post();
    
    //그리드 CHEKCBOX헤더 체크해제
    GR_MASTER.ColumnProp('CHK_BOX','HeadCheck')= "false";
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GR_MASTER.Focus();    
    }else{
        LC_S_STR.Focus();
        DS_O_DETAIL.ClearData();
        DS_IO_DETAIL_D.ClearData();
    }
    
    bfListRowPosition = 0;
} 
/**
 * doOnClick()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-26
 * 개       요 : 선택된 반송건 재청구 상세 조회 
 * return값 : void
 */
function doClick(row){
     
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
     
    var strSaleDt   = DS_O_MASTER.NameValue(row ,"SALE_DT");
    var strCardNo   = DS_O_MASTER.NameValue(row ,"CARD_NO");
    var strApprNo   = DS_O_MASTER.NameValue(row ,"APPR_NO");
    var strJbrchId  = DS_O_MASTER.NameValue(row ,"JBRCH_ID");
    var strDivMonth = DS_O_MASTER.NameValue(row ,"DIV_MONTH");
    var strApprAmt  = DS_O_MASTER.NameValue(row ,"TRADE_AMT");
    
    var goTo    = "searchDetail";    
    var action  = "O";     
    parametersD = "&strSaleDt="   + encodeURIComponent(strSaleDt)
                + "&strCardNo="   + encodeURIComponent(strCardNo)
                + "&strApprNo="   + encodeURIComponent(strApprNo)
                + "&strJbrchId="  + encodeURIComponent(strJbrchId)
                + "&strDivMonth=" + encodeURIComponent(strDivMonth)
                + "&strApprAmt="  + encodeURIComponent(strApprAmt);

    TR_DETAIL.Action  = "/dps/psal934.ps?goTo="+goTo+parametersD;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    if(DS_O_DETAIL.CountRow > 0){
        if(trim(EM_COMP_NO_R.Text) != ""){
            initEmEdit(EM_COMP_NO_R,     "#00-00-00000",         READ);
        }
        if(trim(EM_CARD_NO_R.Text) != ""){
            initEmEdit(EM_CARD_NO_R,     "0000-0000-0000-0000-0000",  READ);
        }
        if(trim(EM_EXP_DT_R.Text) != ""){
            initEmEdit(EM_EXP_DT_R,      "00/00",                READ);
        }
        if(trim(EM_APPR_TIME_R.Text) != ""){
            initEmEdit(EM_APPR_TIME_R,   "HH:NN:SS",             READ);
        }
    }
}  

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-27
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode, objCd, objNm) {
	 objNm.Text = "";//조건입력시 코드초기화
    if (objCd.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || objCd.Text.length == 2) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CARDBIN", objCd.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
            	objCd.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
            	objNm.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(objCd, objNm);
            }
        }
    }
}

 /**
  * keyPressEvent2()
  * 작 성 자 : 김영진
  * 작 성 일 : 2010-05-27
  * 개      요  : Enter, Tab키 이벤트
  * return값 :
  */
 function keyPressEvent2(kcode) {
	 EM_VRTN_NM_S.Text = "";//조건입력시 코드초기화
     if (EM_VRTN_CD_S.Text.length > 0 ) {
         if (kcode == 13 || kcode == 9 || EM_VRTN_CD_S.Text.length == 2) { //TAB,ENTER 키 실행시에만 
             setNmToDataSet("DS_O_RESULT", "SEL_VANCODE", EM_VRTN_CD_S.Text);
             if (DS_O_RESULT.CountRow == 1 ) {
            	 EM_VRTN_CD_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
            	 EM_VRTN_NM_S.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
             } else {
                 //1건 이외의 내역이 조회 시 팝업 호출
                 getVrtnPop(EM_VRTN_CD_S, EM_VRTN_NM_S);
             }
         }
     }
 }
  
/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-27
 * 개       요     : 저장
 * return값 : void
 */
function saveData(){
	 
	var row       = DS_O_MASTER.RowPosition;
	var strFlag   = EM_FLAG_D.Text;
	var strPayDt  = DS_O_MASTER.NameValue(row ,"PAY_DT");
	var strPaySeq = DS_O_MASTER.NameValue(row ,"PAY_SEQ");
	var strSeqNo  = DS_O_MASTER.NameValue(row ,"SEQ_NO");
	var parameters = "&strFlag="   + encodeURIComponent(strFlag)
                   + "&strPayDt="  + encodeURIComponent(strPayDt)
                   + "&strPaySeq=" + encodeURIComponent(strPaySeq)
                   + "&strSeqNo="  + encodeURIComponent(strSeqNo);

    var goTo        = "saveData";
    var action      = "I";  //조회는 O
	if(strChkCnt > 1){
		goTo        = "saveBatch";
	    TR_MAIN2.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
	}else{
		DS_IO_DETAIL_D.UserStatus(1) = 1;
	    TR_MAIN2.KeyValue="SERVLET("+action+":DS_IO_DETAIL_D=DS_IO_DETAIL_D)"; 
	}
    TR_MAIN2.Action  ="/dps/psal934.ps?goTo="+goTo+parameters;   
    TR_MAIN2.Post();
    
    strChkCnt = 0;
    showMaster();
    
}

/**
 * getDataRead()
 * 작  성 자    : 김영진
 * 작  성 일    : 2010-05-27
 * 개        요    : 반송 건 청구 데이터 읽어오기
 * return값 : void
 */
function getDataRead(row){
    
	if( row == undefined ) 
	    row = DS_O_MASTER.RowPosition;
	    
	var strPayDt  = DS_O_MASTER.NameValue(row ,"PAY_DT");
	var	strPaySeq = DS_O_MASTER.NameValue(row ,"PAY_SEQ");
	var	strSeqNo  = DS_O_MASTER.NameValue(row ,"SEQ_NO");
		 
    var goTo        = "searchRead";    
    var action      = "O";     
    parametersD    += "&strPayDt="  + encodeURIComponent(strPayDt) 
                    + "&strPaySeq=" + encodeURIComponent(strPaySeq)
                    + "&strSeqNo="  + encodeURIComponent(strSeqNo); 
    TR_DETAIL2.Action  = "/dps/psal934.ps?goTo="+goTo+parametersD;  
    TR_DETAIL2.KeyValue= "SERVLET("+action+":DS_IO_DETAIL_D=DS_IO_DETAIL_D)"; //조회는 O
    TR_DETAIL2.Post();
    
    if(DS_IO_DETAIL_D.CountRow > 0){
        if(trim(EM_COMP_NO_D.Text) != ""){
            initEmEdit(EM_COMP_NO_D,     "#00-00-00000",         NORMAL); 
        }
        if(trim(EM_CARD_NO_D.Text) != ""){
            initEmEdit(EM_CARD_NO_D,     "0000-0000-0000-0000-0000",  NORMAL);
        }
        if(trim(EM_EXP_DT_D.Text) != ""){
            initEmEdit(EM_EXP_DT_D,      "00/00",                NORMAL);
        }
        if(trim(EM_APPR_TIME_D.Text) != ""){
            initEmEdit(EM_APPR_TIME_D,   "HH:NN:SS",             NORMAL);
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
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
    getDataRead(DS_O_MASTER.RowPosition);
</script>
<script language=JavaScript for=TR_DETAIL2 event=onSuccess>
    for(i=0;i<TR_DETAIL2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL2.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN2 event=onFail>
    trFailed(TR_MAIN2.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL2 event=onFail>
    trFailed(TR_DETAIL2.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if (strChkCnt == 0 && DS_IO_DETAIL_D.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("EM_REC_FLAG_D.Focus();",50);
            return false;
        }
    }else{
        bfListRowPosition = 0;
    }
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    if(clickSORT) return;
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);  
    }else if(DS_O_MASTER.CountRow > 0 && DS_IO_DETAIL_D.CountRow == 0){
        doClick(DS_O_MASTER.RowPosition);
    }else{
        DS_O_DETAIL.ClearData();
        DS_IO_DETAIL_D.ClearData();
    }
    
</script>

<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript" for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_O_MASTER.CountRow; i++){
            if(DS_O_MASTER.NameValue(i, "FLAG") != "2"){
                DS_O_MASTER.NameValue(i, "CHK_BOX") = 'T';
            }
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_MASTER.CountRow; i++){
            if(DS_O_MASTER.NameValue(i, "FLAG") != "2"){
                DS_O_MASTER.NameValue(i, "CHK_BOX") = 'F';
            }
        }
    }
</script>

<!-- VAN사 반송코드 onKillFocus() -->
<script language=JavaScript for=EM_VRTN_CD_S event=onKillFocus()>
    if (EM_VRTN_CD_S.Text.length < 2) {
    	EM_VRTN_CD_S.Text = "";
        EM_VRTN_NM_S.Text = "";
    }
</script>

<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD_D event=onKillFocus()>
    if (EM_CCOMP_CD_D.Text.length < 2) {
    	EM_CCOMP_CD_D.Text = "";
        EM_CCOMP_NM_D.Text = "";
    }
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_COND_BCOMP_CD event=OnSelChange()>
    DS_O_JBRCH_ID.ClearData();
    if(this.BindColVal != "%"){
	    LC_JBRCH_ID_S.Enable = true;
	    getJbrchCode("DS_O_JBRCH_ID", this.BindColVal, "N");
    }else{
  	    LC_JBRCH_ID_S.Enable = false;
    }
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD_D event=OnSelChange()>
    DS_O_JBRCH_ID_D.ClearData();
    getJbrchCode("DS_O_JBRCH_ID_D", this.BindColVal, "N");
</script>

<!-- 재청구여부 선택이벤트 처리 -->
<script language=JavaScript for=RD_BUYREQ_YN_D event=OnSelChange()>
    if(RD_BUYREQ_YN_D.CodeValue == "N"){
    	LC_REASON_CD_D.Enable = true;
        getEtcCode("DS_O_REASON_D", "D", "D066", "N");
    }else{
    	LC_REASON_CD_D.Enable = false;
    }
</script>

<!-- 반송수신일자 Start onKillFocus() -->
<script language=JavaScript for=EM_PAY_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PAY_DT_S)){
        EM_PAY_DT_S.text = <%=strToMonth%>;
    }
</script>
<!-- 반송수신일자 End onKillFocus() -->
<script language=JavaScript for=EM_PAY_DT_E event=onKillFocus()>
    if(!checkDateTypeYMD(EM_PAY_DT_E)){
        initEmEdit(EM_PAY_DT_E,    "TODAY",                  PK); 
    }
</script>  

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    if(colid == "CHK_BOX")return;
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
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
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL_D" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_VRTN_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_S_STR" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_JBRCH_ID" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_JBRCH_ID_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COND_CARDCOMP_CODE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_BCOMP_CD_R" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_BCOMP_CD_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_WORK_FLAG_R" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_WORK_FLAG_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_REASON_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
<object id="TR_DETAIL2" classid=<%=Util.CLSID_TRANSACTION%>>
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
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80" class="point">점포명</th>
                        <td width="165"><comment id="_NSID_"> <object
                            id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> width=159
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="85" class="point">반송수신일자</th>
                        <td width="200"><comment id="_NSID_"> <object
                            id=EM_PAY_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_PAY_DT_S)" />- <comment
                            id="_NSID_"> <object id=EM_PAY_DT_E
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_PAY_DT_E)" /></td>
                        <th width="80">승인번호</th>
                        <td><comment
                            id="_NSID_"> <object id=EM_APPR_NO
                            classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
						<th width="85">카드매입사</th>
                        <td width="165"><comment id="_NSID_"> <object
                            id=LC_COND_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=159
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width="80">가맹점번호</th>
                        <td colspan="3"><comment id="_NSID_">
                        <object id=LC_JBRCH_ID_S classid=<%=Util.CLSID_LUXECOMBO%> width=194
                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80">카드번호</th>
                        <td width="165"><comment id="_NSID_"> <object
                            id=EM_CARD_NO_S classid=<%=Util.CLSID_EMEDIT%> width=154
                            tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="85">VAN사 반송코드</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_VRTN_CD_S
							classid=<%=Util.CLSID_EMEDIT%> width=20 tabindex=1
							onKeyUp="javascript:keyPressEvent2(event.keyCode);"></object>
						</comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getVrtnPop(EM_VRTN_CD_S, EM_VRTN_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_VRTN_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=144 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<!--<th width="80">재청구여부</th>
                        <td><comment id="_NSID_"> <object
                            id=RD_BUYREQ_YN classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 120" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="Y^재청구,N^미청구">
                            <param name=CodeValue value="N">
                            <param name=AutoMargin value="true">
                        </object> </comment><script> _ws_(_NSID_);</script></td>  -->
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
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER
                    width="100%" height=200 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width=80>레코드구분</th>
                        <td width="400"><comment id="_NSID_"> <object
                            id=EM_REC_FLAG_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_REC_FLAG_D
                            classid=<%=Util.CLSID_EMEDIT%> width=125  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">단말기번호</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_DEVICE_ID_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object></comment><script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_DEVICE_ID_D
                            classid=<%=Util.CLSID_EMEDIT%> width=125  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                            <comment id="_NSID_"> <object
                            id=EM_CHRG_DT_R classid=<%=Util.CLSID_EMEDIT%> width=0>
                        </object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object
                            id=EM_CHRG_SEQR classid=<%=Util.CLSID_EMEDIT%> width=0>
                        </object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object
                            id=EM_SEQ_NO_R classid=<%=Util.CLSID_EMEDIT%> width=0>
                        </object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object
                            id=EM_FILLER_R classid=<%=Util.CLSID_EMEDIT%> width=0>
                        </object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object
                            id=EM_FLAG_D classid=<%=Util.CLSID_EMEDIT%> width=0>
                        </object> </comment> <script> _ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object
                            id=EM_REQ_DT_D classid=<%=Util.CLSID_EMEDIT%> width=0>
                        </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width=80>작업구분</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=LC_WORK_FLAG_R classid=<%=Util.CLSID_LUXECOMBO%> width=128>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=LC_WORK_FLAG_D
                            classid=<%=Util.CLSID_LUXECOMBO%> width=130  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">사업자번호</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_COMP_NO_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=EM_COMP_NO_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width=80>카드번호</th>
                        <td width="390"><comment id="_NSID_"> <object
                            id=EM_CARD_NO_R classid=<%=Util.CLSID_EMEDIT%> width=160>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_CARD_NO_D
                            classid=<%=Util.CLSID_EMEDIT%> width=160  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">유효기간</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_EXP_DT_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=EM_EXP_DT_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width=80>할부</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_DIV_MONTH_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_DIV_MONTH_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">승인금액</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_APPR_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=EM_APPR_AMT_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width=80>봉사료</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_SVC_AMT_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_SVC_AMT_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">승인번호</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_APPR_NO_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=EM_APPR_NO_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width=80>승인일자</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_APPR_DT_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_APPR_DT_D
                            classid=<%=Util.CLSID_EMEDIT%> width=107  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_APPR_DT_D)" /></td>
                        <th width="80">승인시간</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_APPR_TIME_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=EM_APPR_TIME_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
					<tr>
						<th width=80>취소일자</th>
						<td width="290"><comment id="_NSID_"> <object
							id=EM_CAN_DT_R classid=<%=Util.CLSID_EMEDIT%> width=125>
						</object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
							id="_NSID_"><object id=EM_CAN_DT_D
							classid=<%=Util.CLSID_EMEDIT%> width=107 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_CAN_DT_D)" /></td>
						<th width="80">발급사코드</th>
						<td><comment id="_NSID_"> <object id=EM_CCOMP_CD_R
							classid=<%=Util.CLSID_EMEDIT%> width=20 tabindex=1"></object> </comment> <script> _ws_(_NSID_);</script><comment
							id="_NSID_"> <object id=EM_CCOMP_NM_R
							classid=<%=Util.CLSID_EMEDIT%> width=102 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp;
						<comment id="_NSID_"> <object id=EM_CCOMP_CD_D
							classid=<%=Util.CLSID_EMEDIT%> width=20 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode, EM_CCOMP_CD_D, EM_CCOMP_NM_D);"></object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getCcompPop(EM_CCOMP_CD_D, EM_CCOMP_NM_D)" /> <comment
							id="_NSID_"> <object id=EM_CCOMP_NM_D
							classid=<%=Util.CLSID_EMEDIT%> width=82 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
                        <th width=80>매입사코드</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=LC_BCOMP_CD_R classid=<%=Util.CLSID_LUXECOMBO%> width=128
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                           &nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=LC_BCOMP_CD_D
                            classid=<%=Util.CLSID_LUXECOMBO%> width=130  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">가맹점번호</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_JBRCH_ID_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=LC_JBRCH_ID_D
                            classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th width=80>달러구분</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_DOLLAR_FLAG_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_DOLLAR_FLAG_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80">재청구여부</th>
                        <td><comment id="_NSID_"> <object
                            id=RD_BUYREQ_YN_D classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 127" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="Y^재청구,N^미청구">
                            <param name=CodeValue value="Y">
                            <param name=AutoMargin value="true">
                        </object> </comment><script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width=100>재청구미생성사유</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=LC_REASON_CD_D classid=<%=Util.CLSID_LUXECOMBO%> width=130 tabindex=1>
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="100">사유메모</th>
                        <td><comment
                            id="_NSID_"> <object id=EM_MEMO_D
                            classid=<%=Util.CLSID_EMEDIT%> width=268 tabindex=1 onkeyup="javascript:checkByteStr(EM_MEMO_D, 40,'N');"> </object> </comment> <script> _ws_(_NSID_);</script>
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
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=CHRG_DT         ctrl=EM_CHRG_DT_R     Param=Text</c>
            <c>col=CHRG_SEQ        ctrl=EM_CHRG_SEQ_R    Param=Text</c>
            <c>col=SEQ_NO          ctrl=EM_SEQ_NO_R      Param=Text</c>
            <c>col=REC_FLAG        ctrl=EM_REC_FLAG_R    Param=Text</c>
            <c>col=DEVICE_ID       ctrl=EM_DEVICE_ID_R   Param=Text</c>
            <c>col=WORK_FLAG       ctrl=LC_WORK_FLAG_R   Param=BindColVal</c>
            <c>col=COMP_NO         ctrl=EM_COMP_NO_R     Param=Text</c>
            <c>col=CCOMP_NM        ctrl=EM_CCOMP_NM_R    Param=Text</c>
            <c>col=CARD_NO         ctrl=EM_CARD_NO_R     Param=Text</c>
            <c>col=EXP_DT          ctrl=EM_EXP_DT_R      Param=Text</c>
            <c>col=DIV_MONTH       ctrl=EM_DIV_MONTH_R   Param=Text</c>
            <c>col=APPR_AMT        ctrl=EM_APPR_AMT_R    Param=Text</c>
            <c>col=SVC_AMT         ctrl=EM_SVC_AMT_R     Param=Text</c>
            <c>col=APPR_NO         ctrl=EM_APPR_NO_R     Param=Text</c>
            <c>col=APPR_DT         ctrl=EM_APPR_DT_R     Param=Text</c>
            <c>col=APPR_TIME       ctrl=EM_APPR_TIME_R   Param=Text</c>
            <c>col=CAN_DT          ctrl=EM_CAN_DT_R      Param=Text</c>
            <c>col=CAN_TIME        ctrl=EM_CAN_TIME_R    Param=Text</c>
            <c>col=CCOMP_CD        ctrl=EM_CCOMP_CD_R    Param=Text</c>
            <c>col=BCOMP_CD        ctrl=LC_BCOMP_CD_R    Param=BindColVal</c>
            <c>col=JBRCH_ID        ctrl=EM_JBRCH_ID_R    Param=Text</c>
            <c>col=DOLLAR_FLAG     ctrl=EM_DOLLAR_FLAG_R Param=Text</c>
            <c>col=FILLER          ctrl=EM_FILLER_R      Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=BD_HEADER2 classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_DETAIL_D>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=CHRG_DT         ctrl=EM_CHRG_DT_D      Param=Text</c>
            <c>col=CHRG_SEQ        ctrl=EM_CHRG_SEQ_D     Param=Text</c>
            <c>col=SEQ_NO          ctrl=EM_SEQ_NO_D       Param=Text</c>
            <c>col=REC_FLAG        ctrl=EM_REC_FLAG_D     Param=Text</c>
            <c>col=DEVICE_ID       ctrl=EM_DEVICE_ID_D    Param=Text</c>
            <c>col=WORK_FLAG       ctrl=LC_WORK_FLAG_D    Param=BindColVal</c>
            <c>col=COMP_NO         ctrl=EM_COMP_NO_D      Param=Text</c>
            <c>col=CARD_NO         ctrl=EM_CARD_NO_D      Param=Text</c>
            <c>col=EXP_DT          ctrl=EM_EXP_DT_D       Param=Text</c>
            <c>col=DIV_MONTH       ctrl=EM_DIV_MONTH_D    Param=Text</c>
            <c>col=APPR_AMT        ctrl=EM_APPR_AMT_D     Param=Text</c>
            <c>col=SVC_AMT         ctrl=EM_SVC_AMT_D      Param=Text</c>
            <c>col=APPR_NO         ctrl=EM_APPR_NO_D      Param=Text</c>
            <c>col=APPR_DT         ctrl=EM_APPR_DT_D      Param=Text</c>
            <c>col=APPR_TIME       ctrl=EM_APPR_TIME_D    Param=Text</c>
            <c>col=CAN_DT          ctrl=EM_CAN_DT_D       Param=Text</c>
            <c>col=CAN_TIME        ctrl=EM_CAN_TIME_D     Param=Text</c>
            <c>col=CCOMP_CD        ctrl=EM_CCOMP_CD_D     Param=Text</c>
            <c>col=CCOMP_NM        ctrl=EM_CCOMP_NM_D     Param=Text</c>
            <c>col=BCOMP_CD        ctrl=LC_BCOMP_CD_D     Param=BindColVal</c>
            <c>col=JBRCH_ID        ctrl=LC_JBRCH_ID_D     Param=BindColVal</c>
            <c>col=DOLLAR_FLAG     ctrl=EM_DOLLAR_FLAG_D  Param=Text</c>
            <c>col=FILLER          ctrl=EM_FILLER_D       Param=Text</c>
            <c>col=BUYREQ_YN       ctrl=RD_BUYREQ_YN_D    Param=CodeValue</c>
            <c>col=REASON_CD       ctrl=LC_REASON_CD_D    Param=BindColVal</c>
            <c>col=MEMO            ctrl=EM_MEMO_D         Param=Text</c>
            <c>col=FLAG            ctrl=EM_FLAG_D         Param=Text</c>
            <c>col=REQ_DT          ctrl=EM_REQ_DT_D       Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
