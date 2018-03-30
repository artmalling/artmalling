<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 청구대상 데이터 수정
 * 작  성  일  : 2010.05.31
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9270.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.31 (김영진) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var chkSave     = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_CARD_NO,     "GEN^10",               NORMAL);
    initEmEdit(EM_APPR_NO,     "0000000000",           NORMAL);
    //initEmEdit(EM_JBRCH_ID,    "GEN^15",               NORMAL);
    initEmEdit(EM_REQ_DT,      "TODAY",                PK);           //조회from
    initEmEdit(EM_REQ_TO_DT,   "TODAY",                PK);           //조회 to
    initEmEdit(EM_CARD_NO,     "0000-0000-0000-0000",  NORMAL);       //카드번호
    initEmEdit(EM_DIV_MONTH,   "00",                   NORMAL);       //할부
    
    initEmEdit(EM_REC_FLAG_R,    "GEN^1",                READ); 
    initEmEdit(EM_DEVICE_ID_R,   "GEN^10",               READ); 
    initEmEdit(EM_COMP_NO_R,     "#000000000",           READ); 
    initEmEdit(EM_CARD_NO_R,     "0000-0000-0000-0000",     READ); 
    initEmEdit(EM_EXP_DT_R,      "0000",                 READ); 
    initEmEdit(EM_DIV_MONTH_R,   "NUMBER^2^0",           READ); 
    initEmEdit(EM_APPR_AMT_R,    "NUMBER^12^0",          READ); 
    initEmEdit(EM_SVC_AMT_R,     "NUMBER^12^0",          READ); 
    initEmEdit(EM_APPR_NO_R,     "0000000000",           READ); 
    initEmEdit(EM_APPR_DT_R,     "YYYYMMDD",             READ); 
    initEmEdit(EM_APPR_TIME_R,   "00:00:00",             READ); 
    initEmEdit(EM_CAN_DT_R,      "YYYYMMDD",             READ);
    initEmEdit(EM_CAN_TIME_R,    "00:00:00",             READ);
    initEmEdit(EM_CCOMP_CD_R,    "GEN^2",                READ);  
    initEmEdit(EM_CCOMP_NM_R,    "GEN^40",               READ);  
    initEmEdit(EM_JBRCH_ID_R,    "GEN^15",               READ); 
    initEmEdit(EM_DOLLAR_FLAG_R, "GEN^4",                READ);
    initEmEdit(EM_FILLER_R,      "GEN^66",               READ);
    

    initEmEdit(EM_REC_FLAG_D,    "GEN^1",                NORMAL); 
    initEmEdit(EM_DEVICE_ID_D,   "CODE^10",              NORMAL); 
    initEmEdit(EM_COMP_NO_D,     "#000000000",           NORMAL); 
    initEmEdit(EM_CARD_NO_D,     "0000-0000-0000-0000",  NORMAL); 
    initEmEdit(EM_EXP_DT_D,      "0000",                 NORMAL); 
    initEmEdit(EM_DIV_MONTH_D,   "NUMBER^2^0",           NORMAL); 
    initEmEdit(EM_APPR_AMT_D,    "NUMBER^12^0",          NORMAL); 
    initEmEdit(EM_SVC_AMT_D,     "NUMBER^12^0",          NORMAL); 
    initEmEdit(EM_APPR_NO_D,     "0000000000",           NORMAL); 
    initEmEdit(EM_APPR_DT_D,     "YYYYMMDD",             NORMAL); 
    initEmEdit(EM_APPR_TIME_D,   "00:00:00",             NORMAL);
    
    initEmEdit(EM_CAN_DT_D,      "YYYYMMDD",             NORMAL); 
    initEmEdit(EM_CAN_TIME_D,    "00:00:00",             NORMAL);
    initEmEdit(EM_CCOMP_CD_D,    "00",                   NORMAL);
    initEmEdit(EM_CCOMP_NM_D,    "GEN^40",               READ);  
    initEmEdit(EM_DOLLAR_FLAG_D, "GEN^4",                NORMAL);
    initEmEdit(EM_FILLER_D,      "GEN^66",               NORMAL);

    initComboStyle(LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^100", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);
    initComboStyle(LC_BRCH_CD,  DS_BRCH_CD,  "CODE^0^120,NAME^0^180", 1, NORMAL);
    
    initComboStyle(LC_WORK_FLAG_R, DS_O_WORK_FLAG_R, "CODE^0^30,NAME^0^80", 1, READ);     //작업구분
    initComboStyle(LC_WORK_FLAG_D, DS_O_WORK_FLAG_D, "CODE^0^30,NAME^0^80", 1, NORMAL);   //작업구분
    initComboStyle(LC_BCOMP_CD_R, DS_O_BCOMP_CD_R, "CODE^0^30,NAME^0^100", 1, READ);      //매입사
    initComboStyle(LC_BCOMP_CD_D, DS_O_BCOMP_CD_D, "CODE^0^30,NAME^0^100", 1, NORMAL);    //매입사
    initComboStyle(LC_JBRCH_ID_D, DS_O_JBRCH_ID_D, "CODE^0^120, NAME^0^180", 1, NORMAL);  //가맹점번호
    
    getEtcCode("DS_O_WORK_FLAG_R", "D", "D035", "N");
    getEtcCode("DS_O_WORK_FLAG_D", "D", "D035", "N");
    getBcompCode("DS_O_BCOMP_CD_R", "", "", "N");    
    getBcompCode("DS_O_BCOMP_CD_D", "", "", "N"); 

    // 초기값설정
    getStore("DS_STR_CD", "Y", "", "N");
    setComboData(LC_STR_CD,  DS_STR_CD.NameValue(0, "CODE")); 
    
    // 매입사코드콤보 목록 가져오기 및 초기값 설정
    getBcompCode("DS_BCOMP_CD", "", "", "Y");
    setComboData(LC_BCOMP_CD,  "%"); 
    
    //DS_O_JBRCH_ID_D.ClearData();
    //getJbrchCode("DS_O_JBRCH_ID_D", this.BindColVal, "N");
    
    showMaster();
    
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}     name="NO"             width=30   align=center</FC>'
                        + '<FC>id=ORG_REC_FLAG     name="레코드구분"       width=70   align=center  SumText= ""</FC>'
                        + '<FC>id=ORG_DEVICE_ID    name="단말기번호"       width=80   align=center  SumText= "합계"</FC>'
                        + '<FC>id=ORG_WORK_FLAG    name="작업구분"         width=60   align=center show=false</FC>'
                        + '<FC>id=ORG_WORK_FLAG_NM name="작업구분"         width=100  align=left   SumText= ""</FC>'
                        + '<FC>id=ORG_COMP_NO      name="사업자번호"       width=100  align=center mask="XXX-XX-XXXXX"  SumText= ""</FC>'
                        + '<FC>id=ORG_CARD_NO      name="카드번호"         width=140  align=center mask="XXXX-XXXX-XXXX-XXXX"  SumText= ""</FC>'
                        + '<FC>id=ORG_EXP_DT       name="유효기간"         width=100  align=center mask="XX/XX"  SumText= ""</FC>'
                        + '<FC>id=ORG_DIV_MONTH    name="할부"             width=40   align=right  SumText= ""</FC>'
                        + '<FC>id=ORG_APPR_AMT     name="승인금액"         width=100   align=right  SumText=@sum</FC>'
                        + '<FC>id=ORG_SVC_AMT      name="봉사료"           width=90   align=right   SumText= ""</FC>'
                        + '<FC>id=ORG_APPR_NO      name="승인번호"         width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=ORG_APPR_DT      name="승인일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=ORG_APPR_TIME    name="승인시간"         width=80   align=center  SumText= "" mask="XX:XX:XX"</FC>'
                        + '<FC>id=ORG_CAN_DT       name="취소일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=ORG_CAN_TIME     name="취소시간"         width=80   align=center  SumText= "" mask="XX:XX:XX"</FC>'
                        + '<FC>id=ORG_CCOMP_CDNM   name="발급사코드/명"    width=100  align=left    SumText= ""</FC>'
                        + '<FC>id=ORG_BCOMP_CD     name="매입사코드/명"    width=100  align=left    SumText= ""  Data="DS_O_BCOMP_CD_R:CODE:NAME"</FC>' 
                        + '<FC>id=ORG_JBRCH_ID     name="가맹점번호"       width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=REQ_DT       name="청구일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=SEQ_NO       name="청구순번"         width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=FCL_FLAG       name="시설구분"         width=80   align=center  SumText= "" show="false"</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}
/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD.Focus();
	    return false;
	}
	
	if(trim(EM_REQ_DT.Text).length == 0){         
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자From");
        EM_REQ_DT.Focus();
        return;
    }
	if(trim(EM_REQ_TO_DT.Text).length == 0){         
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자To");
        EM_REQ_TO_DT.Focus();
        return;
    }
   
    //조회
    showMaster();
}

/**
 * btn_Save()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-05-31
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_O_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
	
    if (LC_JBRCH_ID_D.BindColVal == ""){        
        showMessage(EXCLAMATION, OK, "USER-1002", "가맹점번호");
        LC_JBRCH_ID_D.Focus();
        return;
    }
	
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
     }
    chkSave = "T";
    
    var goTo        = "save";
    var action      = "I";
	
    TR_MAIN.Action  ="/dps/psal927.ps?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();
    
    if( TR_MAIN.ErrorCode == 0){
    	showMaster();
    }
    
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-05-31
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "청구대상 데이터 조회";
    openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
    GR_MASTER.Focus();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 청구대상 데이터 조회 
 * return값 : void
 */
function showMaster(){ 
	 
	var strStrCd   = LC_STR_CD.BindColVal;
	var strReqDt   = EM_REQ_DT.text;
	var strReqToDt = EM_REQ_TO_DT.text; 
	var strBcompCd = LC_BCOMP_CD.BindColVal;
	var strJbrchId = LC_BRCH_CD.BindColVal;
	var strCardNo  = EM_CARD_NO.text;
	var strApprNo  = EM_APPR_NO.text;
	var strDivMonth  = EM_DIV_MONTH.text;
	
	strExlParam = "점포명="     + LC_STR_CD.Text
                + " -청구일자From=" + strReqDt
                + " -청구일자To="   + strReqToDt
                + " -카드매입사=" + LC_BCOMP_CD.Text
                + " -가맹점번호=" + strJbrchId
                + " -카드번호="   + strCardNo
                + " -승인번호="   + strApprNo
                + " -할부="      + strDivMonth;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strReqDt="   + encodeURIComponent(strReqDt)
                    + "&strReqToDt=" + encodeURIComponent(strReqToDt)
                    + "&strBcompCd=" + encodeURIComponent(strBcompCd)
                    + "&strJbrchId=" + encodeURIComponent(strJbrchId)
                    + "&strCardNo="  + encodeURIComponent(strCardNo)
                    + "&strApprNo="  + encodeURIComponent(strApprNo)
                    + "&strDivMonth="+ encodeURIComponent(strDivMonth);
    
    TR_SUB.Action  ="/dps/psal927.ps?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_SUB.Post();

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    chkSave = "";
}

/**
 * modifyClear()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 수정한 정보를 원래 Data로 변경 조회 
 * return값 : void
 */
function modifyClear(){ 
	EM_REC_FLAG_D.Text =              EM_REC_FLAG_R.Text;      
	EM_DEVICE_ID_D.Text =             EM_DEVICE_ID_R.Text;     
	LC_WORK_FLAG_D.BindColVal =       LC_WORK_FLAG_R.BindColVal;          
	EM_COMP_NO_D.Text =               EM_COMP_NO_R.Text;        
	EM_CARD_NO_D.Text =               EM_CARD_NO_R.Text;      
	EM_EXP_DT_D.Text =                EM_EXP_DT_R.Text;       
	EM_DIV_MONTH_D.Text =             EM_DIV_MONTH_R.Text;    
	EM_APPR_AMT_D.Text =              EM_APPR_AMT_R.Text;     
	EM_SVC_AMT_D.Text =               EM_SVC_AMT_R.Text;      
	EM_APPR_NO_D.Text =               EM_APPR_NO_R.Text;      
	EM_APPR_DT_D.Text =               EM_APPR_DT_R.Text;      
	EM_APPR_TIME_D.Text =             EM_APPR_TIME_R.Text;    
	EM_CAN_DT_D.Text =                EM_CAN_DT_R.Text;       
	EM_CAN_TIME_D.Text =              EM_CAN_TIME_R.Text;     
	EM_CCOMP_CD_D.Text =              EM_CCOMP_CD_R.Text;
	EM_CCOMP_NM_D.Text =              EM_CCOMP_NM_R.Text; 
	LC_BCOMP_CD_D.BindColVal =        LC_BCOMP_CD_R.BindColVal;     
	LC_JBRCH_ID_D.BindColVal =        EM_JBRCH_ID_R.Text;     
	EM_DOLLAR_FLAG_D.Text =           EM_DOLLAR_FLAG_R.Text;  
	EM_FILLER_D.Text =                EM_FILLER_R.Text;
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-31
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
<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_BCOMP_CD  OnRowPosChanged(row)(row,colid)-->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD_R event=onKillFocus()>
    if ((EM_CCOMP_CD_R.Modified) && (EM_CCOMP_CD_R.Text.length != 2)) {
        EM_CCOMP_NM_R.Text = "";
    }
</script>

<!-- 청구일자 onKillFocus() -->
<script language=JavaScript for=EM_REQ_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_REQ_DT)){
        initEmEdit(EM_REQ_DT,    "TODAY",     PK);        
    }
</script>  

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD_D event=OnSelChange()>
    DS_O_JBRCH_ID_D.ClearData();
    getJbrchCode("DS_O_JBRCH_ID_D", LC_BCOMP_CD_D.BindColVal, "N");
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 매입사콤보 선택이벤트 처리 -->
<script language=JavaScript for=LC_BCOMP_CD event=OnSelChange()>
    DS_BRCH_CD.ClearData();
    if(this.BindColVal != "%"){
    	LC_BRCH_CD.Enable = true;
        getJbrchCode("DS_BRCH_CD", this.BindColVal, "N");
    }else{
    	LC_BRCH_CD.Enable = false;
    }
</script>

<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>

    if (chkSave == "" && DS_O_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else{
        	modifyClear();
        }
    }
</script>
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BRCH_CD" classid=<%=Util.CLSID_DATASET%>> </object>
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
<object id="DS_O_BCOMP_CD_R" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_BCOMP_CD_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_JBRCH_ID_D" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
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

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

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
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                              *-->
<!--*************************************************************************-->

<body onLoad="doInit();" class="PL10 PT15">

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
						<td width="170"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">청구일자</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_REQ_DT)" />
						~
						<comment id="_NSID_"> <object
							id=EM_REQ_TO_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_REQ_TO_DT)" />	
						</td>					
					</tr>
					<tr>						
						<th width="80">카드매입사</th>
						<td width="170"><comment id="_NSID_"> <object
							id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">가맹점번호</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=LC_BRCH_CD classid=<%=Util.CLSID_LUXECOMBO%> width=154
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="80">카드번호</th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=140
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">승인번호</th>
						<td width="170"><comment id="_NSID_"> <object
							id=EM_APPR_NO classid=<%=Util.CLSID_EMEDIT%> width=150
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">할부</th>
                        <td width="170"><comment id="_NSID_"> <object
                            id=EM_DIV_MONTH classid=<%=Util.CLSID_EMEDIT%> width=140
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=197 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
                        <td width="290"><comment id="_NSID_"> <object
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
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_CARD_NO_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_CARD_NO_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
						<th width="80">취소시간</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_CAN_TIME_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=EM_CAN_TIME_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
					<tr>
						<th width="80">발급사코드</th>
						<td width="290"><comment id="_NSID_"> <object id=EM_CCOMP_CD_R
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
                        <th width=80>매입사코드</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_BCOMP_CD_R classid=<%=Util.CLSID_LUXECOMBO%> width=128
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                           &nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=LC_BCOMP_CD_D
                            classid=<%=Util.CLSID_LUXECOMBO%> width=130  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80">가맹점번호</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_JBRCH_ID_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"> <object id=LC_JBRCH_ID_D
                            classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
                        <th width=80>달러구분</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_DOLLAR_FLAG_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_DOLLAR_FLAG_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width=80>FILLER</th>
                        <td width="290"><comment id="_NSID_"> <object
                            id=EM_FILLER_R classid=<%=Util.CLSID_EMEDIT%> width=125>
                        </object> </comment> <script> _ws_(_NSID_);</script>&nbsp;&nbsp;&nbsp; <comment
                            id="_NSID_"><object id=EM_FILLER_D
                            classid=<%=Util.CLSID_EMEDIT%> width=127  tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>                        
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
    <param name=DataID value=DS_O_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=ORG_REC_FLAG        ctrl=EM_REC_FLAG_R    Param=Text</c>
            <c>col=ORG_DEVICE_ID       ctrl=EM_DEVICE_ID_R   Param=Text</c>
            <c>col=ORG_WORK_FLAG       ctrl=LC_WORK_FLAG_R   Param=BindColVal</c>
            <c>col=ORG_COMP_NO         ctrl=EM_COMP_NO_R     Param=Text</c>
            <c>col=ORG_CCOMP_NM        ctrl=EM_CCOMP_NM_R    Param=Text</c>
            <c>col=ORG_CARD_NO         ctrl=EM_CARD_NO_R     Param=Text</c>
            <c>col=ORG_EXP_DT          ctrl=EM_EXP_DT_R      Param=Text</c>
            <c>col=ORG_DIV_MONTH       ctrl=EM_DIV_MONTH_R   Param=Text</c>
            <c>col=ORG_APPR_AMT        ctrl=EM_APPR_AMT_R    Param=Text</c>
            <c>col=ORG_SVC_AMT         ctrl=EM_SVC_AMT_R     Param=Text</c>
            <c>col=ORG_APPR_NO         ctrl=EM_APPR_NO_R     Param=Text</c>
            <c>col=ORG_APPR_DT         ctrl=EM_APPR_DT_R     Param=Text</c>
            <c>col=ORG_APPR_TIME       ctrl=EM_APPR_TIME_R   Param=Text</c>
            <c>col=ORG_CAN_DT          ctrl=EM_CAN_DT_R      Param=Text</c>
            <c>col=ORG_CAN_TIME        ctrl=EM_CAN_TIME_R    Param=Text</c>
            <c>col=ORG_CCOMP_CD        ctrl=EM_CCOMP_CD_R    Param=Text</c>
            <c>col=ORG_CCOMP_NM        ctrl=EM_CCOMP_NM_R    Param=Text</c>
            <c>col=ORG_BCOMP_CD        ctrl=LC_BCOMP_CD_R    Param=BindColVal</c>
            <c>col=ORG_JBRCH_ID        ctrl=EM_JBRCH_ID_R    Param=Text</c>
            <c>col=ORG_DOLLAR_FLAG     ctrl=EM_DOLLAR_FLAG_R Param=Text</c>
            <c>col=ORG_FILLER          ctrl=EM_FILLER_R      Param=Text</c>
            <c>col=REC_FLAG            ctrl=EM_REC_FLAG_D    Param=Text</c>
            <c>col=DEVICE_ID           ctrl=EM_DEVICE_ID_D   Param=Text</c>
            <c>col=WORK_FLAG           ctrl=LC_WORK_FLAG_D   Param=BindColVal</c>
            <c>col=COMP_NO             ctrl=EM_COMP_NO_D     Param=Text</c>
            <c>col=CCOMP_NM            ctrl=EM_CCOMP_NM_D    Param=Text</c>
            <c>col=CARD_NO             ctrl=EM_CARD_NO_D     Param=Text</c>
            <c>col=EXP_DT              ctrl=EM_EXP_DT_D      Param=Text</c>
            <c>col=DIV_MONTH           ctrl=EM_DIV_MONTH_D   Param=Text</c>
            <c>col=APPR_AMT            ctrl=EM_APPR_AMT_D    Param=Text</c>
            <c>col=SVC_AMT             ctrl=EM_SVC_AMT_D     Param=Text</c>
            <c>col=APPR_NO             ctrl=EM_APPR_NO_D     Param=Text</c>
            <c>col=APPR_DT             ctrl=EM_APPR_DT_D     Param=Text</c>
            <c>col=APPR_TIME           ctrl=EM_APPR_TIME_D   Param=Text</c>
            <c>col=CAN_DT              ctrl=EM_CAN_DT_D      Param=Text</c>
            <c>col=CAN_TIME            ctrl=EM_CAN_TIME_D    Param=Text</c>
            <c>col=CCOMP_CD            ctrl=EM_CCOMP_CD_D    Param=Text</c>
            <c>col=CCOMP_NM            ctrl=EM_CCOMP_NM_D    Param=Text</c>
            <c>col=BCOMP_CD            ctrl=LC_BCOMP_CD_D    Param=BindColVal</c>
            <c>col=JBRCH_ID            ctrl=LC_JBRCH_ID_D    Param=BindColVal</c>
            <c>col=DOLLAR_FLAG         ctrl=EM_DOLLAR_FLAG_D Param=Text</c>
            <c>col=FILLER              ctrl=EM_FILLER_D      Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<body>
</html>

