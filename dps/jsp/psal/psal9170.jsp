<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 신용카드대금청구 > 청구관리 > 카드매출 조회
 * 작  성  일  : 2010.05.31 
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9170.jsp
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
	//PID 확인을 위한
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var btnSaveClick =  false;
var strDeviceId = "";
var top = 300;		//해당화면의 동적그리드top위치
var g_strPid           = "<%=pageName%>";                 // PID

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
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	 
    //Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_CARD_NO,     "GEN^10",               NORMAL);
    initEmEdit(EM_APPR_NO,     "0000000000",           NORMAL);
    //initEmEdit(EM_JBRCH_ID,    "GEN^15",               NORMAL);
    initEmEdit(EM_S_DT,        "SYYYYMMDD",            NORMAL);           //조회from
    initEmEdit(EM_E_DT,        "EYYYYMMDD",            NORMAL);           //조회 to
    initEmEdit(EM_CARD_NO,     "0000-0000-0000-0000-0000",  NORMAL);       //카드번호
    initEmEdit(EM_DIV_MONTH,   "00",                   NORMAL);       //할부
    initEmEdit(EM_POS_NO1,   "0000",                   NORMAL);       //POS번호
    
    
	//수정 시작
    initEmEdit(EM_SALE_DT,      "YYYYMMDD",              READ);    //수정
    initEmEdit(EM_POS_NO,       "CODE^10",               READ);    //포스번호
    initEmEdit(EM_TRAN_NO,      "CODE^6",                READ);    //거래번호
    initEmEdit(EM_POS_SEQ_NO,   "CODE^6",                READ);    //일련번호
    initEmEdit(EM_WORK_FLAG,    "GEN^10",                READ);    //거래구분
    initEmEdit(EM_CARD_NO2,     "0000-0000-0000-0000-0000", NORMAL);    //카드번호
    initEmEdit(EM_EXP_DT,       "GEN^10",              NORMAL);    //유효기간
    initEmEdit(EM_DIV_MONTH2,   "CODE^2",              NORMAL);    //할부
    initEmEdit(EM_APPR_AMT,     "",                      READ);    //승인금액
    initEmEdit(EM_SVC_AMT,      "",                      READ);    //봉사료
    initEmEdit(EM_APPR_NO2,     "CODE^20",             NORMAL);    //승인번호
    initEmEdit(EM_APPR_DT,      "YYYYMMDD",            NORMAL);    //승인일자
    initEmEdit(EM_APPR_TIME,    "00:00:00",            NORMAL);    //승인시간
    //initEmEdit(EM_VEN_NM,       "GEN^30",              NORMAL);    //승인밴사
    //initEmEdit(EM_CCOMP_NM2,    "GEN^30",              NORMAL);    //발급사코드
    //initEmEdit(EM_BCOMP_NM,     "GEN^30",              NORMAL);    //매입사코드
    initEmEdit(EM_JBRCH_ID,     "GEN^30",              READ);    //가맹점번호
    
    initComboStyle(EM_CCOMP_CD,   DS_CCOMP_NM,   "CODE^0^30,NAME^0^80", 1, NORMAL);//발급사코드
    getCcompCode("DS_CCOMP_NM", "", "", "N");//발급사코드
    EM_CCOMP_CD.Index=0;
    initComboStyle(EM_BCOMP_CD,   DS_BCOMP_NM,   "CODE^0^30,NAME^0^80", 1, NORMAL);//매입사코드
    getBcompCode("DS_BCOMP_NM", "", "", "N"); //매입사코드    
    EM_BCOMP_CD.Index=0;
    
    //끝

    initComboStyle(LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_BCOMP_CD, DS_BCOMP_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);
    initComboStyle(LC_BRCH_CD,  DS_BRCH_CD,  "CODE^0^120,NAME^0^180", 1, NORMAL);

    // 초기값설정
    getStore("DS_STR_CD", "Y", "", "N");
    setComboData(LC_STR_CD,  DS_STR_CD.NameValue(0, "CODE")); 
    
    searchVanId(DS_STR_CD.NameValue(0, "CODE"));
    
    var strVanIdCode = DS_O_VANID.NameValue(0, "COMM_PART");
    initComboStyle(EM_VEN_CD,   DS_VEN_NM,   "CODE^0^30,NAME^0^80", 1, NORMAL);//승인밴사
    getEtcCode("DS_VEN_NM" ,"D"   ,strVanIdCode  ,"N" );         //승인밴사
    EM_VEN_CD.Index=0;

    
    // 매입사코드콤보 목록 가져오기 및 초기값 설정
    getBcompCode("DS_BCOMP_CD", "", "", "Y");
    setComboData(LC_BCOMP_CD,  "%"); 
    //EM_APPR_AMT.align="right";
    //showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}     name="NO"             width=30   align=center</FC>'
                        + '<FC>id=SALE_DT      name="매출일자"       width=80   align=center  SumText= "합계"  mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=POS_NO       name="POS번호"       width=100   align=center SHOW=FALSE SumText= ""</FC>'
                        + '<FC>id=POS_NM       name="POS번호"       width=100   align=center  SumText= ""</FC>'
                        + '<FC>id=TRAN_NO      name="거래번호"       width=70   align=center  SumText= ""</FC>'
                        + '<FC>id=POS_SEQ_NO   name="일련번호"       width=70   align=center  SumText= ""</FC>'
                        + '<FC>id=WORK_FLAG    name="거래구분"         width=60   align=center </FC>'                                                
                        + '<FC>id=CARD_NO      name="카드번호"         width=170  align=center mask="XXXX-XXXX-XXXX-XXXX-XXXX"  SumText= ""</FC>'
                        + '<FC>id=EXP_DT       name="유효기간"         width=100  align=center mask="XX/XX"  SumText= ""</FC>'
                        + '<FC>id=DIV_MONTH    name="할부"             width=40   align=right  SumText= ""</FC>'
                        + '<FC>id=APPR_AMT     name="승인금액"         width=100   align=right  SumText=@sum</FC>'
                        + '<FC>id=SVC_AMT      name="봉사료"           width=90   align=right   SumText= ""</FC>'
                        + '<FC>id=APPR_NO      name="승인번호"         width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=APPR_DT      name="승인일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=APPR_TIME    name="승인시간"         width=80   align=center  SumText= "" mask="XX:XX:XX"</FC>'
                        + '<FC>id=CAN_DT       name="취소일자"         width=80   align=center  SumText= "" mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=CAN_TIME     name="취소시간"         width=80   align=center  SumText= "" mask="XX:XX:XX"</FC>'
                        + '<FC>id=VEN_NM       name="승인밴사"         width=100  align=left    SumText= ""</FC>'
                        + '<FC>id=VEN_CD       name="승인밴사코드"      width=100  align=left    SumText= "" SHOW=FALSE </FC>'
                        + '<FC>id=CCOMP_CD     name="발급사코드"       width=100  align=left    SumText= ""  SHOW=FALSE </FC>'
                        + '<FC>id=CCOMP_NM     name="발급사코드/명"    width=100  align=left    SumText= ""</FC>'
                        + '<FC>id=BCOMP_CD     name="매입사코드"       width=100  align=left    SumText= ""  SHOW=FALSE </FC>'
                        + '<FC>id=BCOMP_NM     name="매입사코드/명"    width=100  align=left    SumText= ""</FC>'
                        + '<FC>id=JBRCH_ID     name="가맹점번호"       width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=KEYIN_GB     name="수기입력구분"     width=80   align=center  SumText= "" </FC>'
                        + '<FC>id=DOLLAR_FLAG  name="달러구분"         width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=FILLER       name="거래브랜드품목"     width=200   align=center  SumText= ""</FC>'
                        + '<FC>id=PAY_TYPE_NM  name="결제유형"         width=80   align=center  SumText= ""</FC>'
                        + '<FC>id=POS_FLAG_NM  name="POS구분"          width=120   align=center  SumText= ""</FC>'
                        + '<FC>id=ORG_APPR_DT  name="원거래승인일자"   width=100   align=center  SumText= ""  mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=ORG_APPR_NO  name="원거래승인번호"   width=100   align=center  SumText= ""</FC>'
                        + '<FC>id=ORG_POS_NO   name="원거래POS번호"    width=100   align=center  SumText= ""</FC>'
                        + '<FC>id=ORG_SALE_DT  name="원거래매출일자"   width=100   align=center  SumText= ""  mask="XXXX/XX/XX"</FC>'
                        + '<FC>id=ORG_TRAN_NO  name="원거래거래번호"   width=100   align=center  SumText= ""</FC>'
                        + '<FC>id=SEND_DATE    name="가져온일자"       width=140   align=center  SumText= ""  </FC>'
                        + '<FC>id=SEND_STAT    name="가져오기상태"     width=100   align=center  SumText= ""</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
}
/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
     (3) 엑셀       - btn_Excel()
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
	/*
	if(trim(EM_REQ_DT.Text).length == 0){         
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자From");
        EM_REQ_DT.Focus();
        return;
    }
	if(trim(EM_REQ_TO_DT.Text).length == 0){         
        showMessage(EXCLAMATION, OK, "USER-1001","청구일자To");
        EM_REQ_TO_DT.Focus();
        return;
    }*/
   
    //조회
    showMaster();
}
/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    
    // 저장할 데이터 없는 경우
    if (!DS_O_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }    
    /* if (trim(EM_CCOMP_CD.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사 코드");
        EM_CCOMP_CD.Focus();
        return;
    } 
    if (trim(EM_CCOMP_NM.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드사명");
        EM_CCOMP_NM.Focus();
        return;
    } 
    if (trim(LC_BCOMP.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "매입사 코드");
        LC_BCOMP.Focus();
        return;
    }    
    if (trim(RD_BCOMP_YN.CodeValue).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "매입사여부");
        RD_BCOMP_YN.Focus();
        return;
    }       
     */
    saveData();
}
/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-05-31
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "카드매출조회";
    //openExcel2(GR_MASTER, ExcelTitle, strExlParam, true );
    openExcel5(GR_MASTER, ExcelTitle, strExlParam, true , "",g_strPid );

    GR_MASTER.Focus();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * saveData()
  * 작 성 자 : 장형욱
  * 작 성 일 : 2010-05-23
  * 개       요 : 카드발급사코드 관리 등록
  * return값 : void
  */
 function saveData(){
	var strStrCd   = LC_STR_CD.BindColVal; 
    var goTo        = "saveData";
    var action      = "I";  //조회는 O
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd);
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
     }
    TR_MAIN.Action  ="/dps/psal917.ps?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();

    btn_Search();
 }
  
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 청구대상 데이터 조회 
 * return값 : void
 */
function showMaster(){    
	 
	var strStrCd   = LC_STR_CD.BindColVal;
	var strReqDt   = EM_S_DT.text;
	var strReqToDt = EM_E_DT.text; 
	var strBcompCd = LC_BCOMP_CD.BindColVal;
	var strJbrchId = LC_BRCH_CD.BindColVal;
	var strCardNo  = EM_CARD_NO.text;
	var strApprNo  = EM_APPR_NO.text;
	var strDivMonth = EM_DIV_MONTH.text;
	var strSInOut   = LC_S_IN_OUT.BindColVal;
	var strSInOutNm = LC_S_IN_OUT.Text;
	var strPosNo  = EM_POS_NO1.text;
	
	strExlParam = "점포명="     + LC_STR_CD.Text
	            + " -조회기간구분=" + strSInOutNm
                + " -조회기간From=" + strReqDt
                + " -조회기간To="   + strReqToDt
                + " -카드매입사=" + LC_BCOMP_CD.Text
                + " -가맹점번호=" + strJbrchId
                + " -카드번호="   + strCardNo
                + " -승인번호="   + strApprNo
                + " -할부="      + strDivMonth
                + " -Pos번호="      + strPosNo;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strReqDt="   + encodeURIComponent(strReqDt)
                    + "&strReqToDt=" + encodeURIComponent(strReqToDt)
                    + "&strBcompCd=" + encodeURIComponent(strBcompCd)
                    + "&strJbrchId=" + encodeURIComponent(strJbrchId)
                    + "&strCardNo="  + encodeURIComponent(strCardNo)
                    + "&strApprNo="  + encodeURIComponent(strApprNo)
                    + "&strDivMonth="  + encodeURIComponent(strDivMonth)
                    + "&strSInOut="  + encodeURIComponent(strSInOut)
    				+ "&strPosNo="  + encodeURIComponent(strPosNo);
    
    TR_MAIN.Action  ="/dps/psal917.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    searchVanId(strStrCd);
    var strVanIdCode = DS_O_VANID.NameValue(0, "COMM_PART");
    //initComboStyle(EM_VEN_CD,   DS_VEN_NM,   "CODE^0^30,NAME^0^80", 1, NORMAL);//승인밴사
    //getEtcCode("DS_VEN_NM" ,"D"   ,strVanIdCode  ,"N" );         //승인밴사
    
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

}

/**
 * searchVanId()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-05-31
 * 개       요     : 점별 VANID 구분자 조회 
 * return값 : void
 */
function searchVanId(strStrCd){

	 var goTo       = "searchVanId" ;
	 var action     = "O";
	 var parameters =  "&strStrCd="+encodeURIComponent(strStrCd) ;

	 TR_VANID.Action  = "/dps/psal917.ps?goTo="+goTo+parameters;
	 TR_VANID.KeyValue= "SERVLET("+action+":DS_O_VANID=DS_O_VANID)"; //조회는 O
	 TR_VANID.Post();

//	return DS_O_CMPRDTDATE.NameValue(0,"CMPR_DT");
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
<script language=JavaScript for=TR_VANID event=onSuccess>
    for(i=0;i<TR_VANID.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_VANID.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
<script language=JavaScript for=TR_VANID event=onFail>
    trFailed(TR_VANID.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--DS_BCOMP_CD  OnRowPosChanged(row)(row,colid)-->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 카드발급사 onKillFocus() -->
<!-- <script language=JavaScript for=EM_CCOMP_CD event=onKillFocus()>
    if ((EM_CCOMP_CD.Modified) && (EM_CCOMP_CD.Text.length != 2)) {
        EM_CCOMP_NM.Text = "";
    }
</script>
 -->
<!-- 청구일자 onKillFocus() 
<script language=JavaScript for=EM_REQ_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_REQ_DT)){
        initEmEdit(EM_REQ_DT,    "TODAY",     PK);        
    }
</script>  
-->
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

<script language=JavaScript for=LC_S_IN_OUT event=OnSelChange()>
//조회조건초기화
if (LC_S_IN_OUT.BindColVal == "3") {
    EM_S_DT.Text = "";
    EM_E_DT.Text = "";
    EM_S_DT.Enable      = false;           
    EM_E_DT.Enable      = false;           
    enableControl(IMG_S_DT,false); // 조회기간 비활성화(팝업)
    enableControl(IMG_E_DT,false); // 조회기간 비활성화(팝업)
} else {
    initEmEdit(EM_S_DT,         "SYYYYMMDD",NORMAL); // [조회용]기간S
    initEmEdit(EM_E_DT,         "EYYYYMMDD",NORMAL); // [조회용]기간E
    enableControl(IMG_S_DT,true); // 조회기간 비활성화(팝업)
    enableControl(IMG_E_DT,true); // 조회기간 비활성화(팝업)
}
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>


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
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_VEN_NM" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_CCOMP_NM" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_NM" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_VANID" classid=<%=Util.CLSID_DATASET%>> </object>
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
<comment id="_NSID_">
<object id="TR_VANID" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                              *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>
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
						<th width="70" class="point">점포명</th>
						<td width="160"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>조회기간구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_IN_OUT
							classid=<%=Util.CLSID_LUXECOMBO%> width="154" 
							tabindex=1 align="absmiddle">
							<param name=CBData value="1^매출일자,2^가져온일자,3^당일청구대상">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value="NAME">
							<param name=ListExprFormat value="CODE^2^30,NAME^0^100">
							<param name=BindColumn value="CODE">
							<param name=Index value="0">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>조회기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment> <script>_ws_(_NSID_);</script> <img id=IMG_S_DT
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT)" /> ~ <comment
							id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img id=IMG_E_DT src="/<%=dir%>/imgs/btn/date.gif"
							align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" /></td>					
					</tr>
					<tr>						
						<th width="70">카드매입사</th>
						<td width="160"><comment id="_NSID_"> <object
							id=LC_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=145
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">가맹점번호</th>
						<td><comment id="_NSID_"> <object
							id=LC_BRCH_CD classid=<%=Util.CLSID_LUXECOMBO%> width=154
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">POS번호</th>
                        <td width="200"><comment id="_NSID_"> <object
                            id=EM_POS_NO1 classid=<%=Util.CLSID_EMEDIT%> width=140
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
					</tr>
					<tr>
						<th width="70">카드번호</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width=155
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">승인번호</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_APPR_NO classid=<%=Util.CLSID_EMEDIT%> width=150
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80">할부</th>
                        <td width="200"><comment id="_NSID_"> <object
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
					width="100%" height=315 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<!-- 추가 START -->
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
					    <th width="140">매출일자</th>
						<td ><comment id="_NSID_"> <object
							id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment> <script>_ws_(_NSID_);</script> <%-- <img id=IMG_S_DT
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_SALE_DT)" /> --%></td>
						 
						<th width="140" >POS번호</th>
						<td><comment id="_NSID_"> <object
									id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=50
									tabindex=1 align="absmiddle" > </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" >거래번호</th>
						<td><comment id="_NSID_"> <object
									id=EM_TRAN_NO classid=<%=Util.CLSID_EMEDIT%> width=50
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="140" >일련번호</th>
						<td><comment id="_NSID_"> <object
									id=EM_POS_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=50
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="140" >거래구분</th>
							<td><comment id="_NSID_"> <object
										id=EM_WORK_FLAG classid=<%=Util.CLSID_EMEDIT%> width=50
										tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						<th width="140" >카드번호</th>
							<td><comment id="_NSID_"> <object
										id=EM_CARD_NO2 classid=<%=Util.CLSID_EMEDIT%> width=160
										tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						<th width="80" >유효기간(YY/MM)</th>
							<td><comment id="_NSID_"> <object
										id=EM_EXP_DT classid=<%=Util.CLSID_EMEDIT%> width=100
										tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>
						<th width="140" >할부</th>
							<td><comment id="_NSID_"> <object
										id=EM_DIV_MONTH2 classid=<%=Util.CLSID_EMEDIT%> width=30
										tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							</td>	
							
					</tr>
					<tr>
						<th width="140" >승인금액</th>
								<td><comment id="_NSID_"> <object
											id=EM_APPR_AMT classid=<%=Util.CLSID_EMEDIT%> width=100
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
						<th width="140" >봉사료</th>
								<td><comment id="_NSID_"> <object
											id=EM_SVC_AMT classid=<%=Util.CLSID_EMEDIT%> width=100
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
						<th width="80" >승인번호</th>
								<td><comment id="_NSID_"> <object
											id=EM_APPR_NO2 classid=<%=Util.CLSID_EMEDIT%> width=100
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>	
						<th width="140" >승인일자</th>
								<td><comment id="_NSID_"> <object
											id=EM_APPR_DT classid=<%=Util.CLSID_EMEDIT%> width=70
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>	
					</tr>
					<tr>
						<th width="140" >승인시간</th>
								<td><comment id="_NSID_"> <object
											id=EM_APPR_TIME classid=<%=Util.CLSID_EMEDIT%> width=70
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
						
						<th width="80">승인밴사</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_VEN_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td><th width="80">발급사코드</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_CCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td></td><th width="80">매입사코드</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_BCOMP_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="140" >가맹점번호</th>
								<td ><comment id="_NSID_"> <object
											id=EM_JBRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=80
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><-가맹점번호 누락시 카드빈확인
								</td>
								<td colspan="2"></td>
					</tr>
								
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<!-- 추가 END -->
</table>
</div>
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_O_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
               <c>col=SALE_DT        ctrl=EM_SALE_DT           Param=Text</c>
               <c>col=POS_NO         ctrl=EM_POS_NO            Param=Text</c>
               <c>col=POS_NM         ctrl=EM_POS_NM            Param=Text</c>
               <c>col=TRAN_NO        ctrl=EM_TRAN_NO           Param=Text</c>
               <c>col=POS_SEQ_NO     ctrl=EM_POS_SEQ_NO        Param=Text</c>
               <c>col=WORK_FLAG      ctrl=EM_WORK_FLAG         Param=Text</c>
               <c>col=CARD_NO        ctrl=EM_CARD_NO2          Param=Text</c>
               <c>col=EXP_DT         ctrl=EM_EXP_DT            Param=Text</c>
               <c>col=DIV_MONTH      ctrl=EM_DIV_MONTH2        Param=Text</c>
               <c>col=APPR_AMT       ctrl=EM_APPR_AMT          Param=Text</c>
               <c>col=SVC_AMT        ctrl=EM_SVC_AMT           Param=Text</c>
               <c>col=APPR_NO        ctrl=EM_APPR_NO2          Param=Text</c>
               <c>col=APPR_DT        ctrl=EM_APPR_DT           Param=Text</c>
               <c>col=APPR_TIME      ctrl=EM_APPR_TIME         Param=Text</c>
               <c>col=CAN_DT         ctrl=EM_CAN_DT            Param=Text</c>
               <c>col=CAN_TIME       ctrl=EM_CAN_TIME          Param=Text</c>
               <c>col=VEN_NM         ctrl=EM_VEN_NM            Param=BindColVal</c>
               <c>col=VEN_CD         ctrl=EM_VEN_CD            Param=BindColVal</c>
               <c>col=CCOMP_CD       ctrl=EM_CCOMP_CD          Param=BindColVal</c>
               <c>col=CCOMP_NM       ctrl=EM_CCOMP_NM2         Param=BindColVal</c>
               <c>col=BCOMP_CD       ctrl=EM_BCOMP_CD          Param=BindColVal</c>
               <c>col=BCOMP_NM       ctrl=EM_BCOMP_NM          Param=BindColVal</c>
               <c>col=JBRCH_ID       ctrl=EM_JBRCH_ID          Param=Text</c>
               <c>col=KEYIN_GB       ctrl=EM_KEYIN_GB          Param=Text</c>
               <c>col=DOLLAR_FLAG    ctrl=EM_DOLLAR_FLAG       Param=Text</c>
               <c>col=FILLER         ctrl=EM_FILLER            Param=Text</c>
               <c>col=PAY_TYPE_NM    ctrl=EM_PAY_TYPE_NM       Param=Text</c>
               <c>col=POS_FLAG_NM    ctrl=EM_POS_FLAG_NM       Param=Text</c>
               <c>col=ORG_APPR_DT    ctrl=EM_ORG_APPR_DT       Param=Text</c>
               <c>col=ORG_APPR_NO    ctrl=EM_ORG_APPR_NO       Param=Text</c>
               <c>col=ORG_POS_NO     ctrl=EM_ORG_POS_NO        Param=Text</c>
               <c>col=POS_NM         ctrl=EM_POS_NM            Param=Text</c>
               <c>col=ORG_SALE_DT    ctrl=EM_ORG_SALE_DT       Param=Text</c>
               <c>col=ORG_TRAN_NO    ctrl=EM_ORG_TRAN_NO       Param=Text</c>
               <c>col=SEND_DATE      ctrl=EM_SEND_DATE         Param=Text</c>
               <c>col=SEND_STAT      ctrl=EM_SEND_STAT         Param=Text</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
	
<body>
</html>

