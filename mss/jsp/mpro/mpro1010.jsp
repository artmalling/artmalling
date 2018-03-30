<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 약속관리 > 약속관리 
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : mpro1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 약속대장관리
 * 이    력 :
 *        2011.01.18 (박종은) 신규작성
 *        2011.02.09 (김성미) 프로그램 작성
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
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript"><!--


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var btnClickSave = false;
 /**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var strCurRow = ""; // 저장전 선택된 로우 저장
function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // 조회내용 초기화
    initEmEdit(EM_S_SEARCH_DT, "SYYYYMMDD", PK);               //기간 시작일
    initEmEdit(EM_E_SEARCH_DT, "TODAY", PK);               //기간 종료일
    initEmEdit(EM_S_CUST, "GEN^40", NORMAL);                  //고객명
    initEmEdit(EM_S_PUMBUN_CD, "NUMBER3^6", NORMAL);              //브랜드코드
    initEmEdit(EM_S_PUMBUN_NM, "GEN", READ);                  //브랜드명

    //기본사항 EMEDIT
    initEmEdit(EM_TAKE_DT, "YYYYMMDD", PK);                  //접수일자
    initEmEdit(EM_TAKE_SEQ, "GEN", READ);                    //접수순번
    initEmEdit(EM_PUMBUN_CD, "NUMBER3^6", PK);                     //브랜드코드
    initEmEdit(EM_PUMBUN_NM, "GEN", READ);                     //브랜드명
    initEmEdit(EM_ORG_CD, "GEN", READ);                         //조직코드
    initEmEdit(EM_ORG_NM, "GEN", READ);                         //조직명
    initEmEdit(EM_TAKE_USER_NM, "GEN^40", READ);           //접수자 명
    
    // 고객정보 EMEDIT
    initEmEdit(EM_CUST_NM, "GEN^40", PK);                   //고객명
    initEmEdit(EM_POST_NO, "POST", READ);                  //우편번호
    initEmEdit(EM_ADDR, "GEN", READ);                        //주소
    initEmEdit(EM_DETL_ADDR, "GEN^80", PK);             //상세주소
    initEmEdit(EM_MOBILE_PH1, "NUMBER3^3^0", PK);            //휴대폰번호1    
    initEmEdit(EM_MOBILE_PH2, "NUMBER3^4^0", PK);            //휴대폰번호2
    initEmEdit(EM_MOBILE_PH3, "NUMBER3^4^0", PK);            //휴대폰번호3
    initEmEdit(EM_HOME_PH1, "NUMBER3^3^0", NORMAL);          //전화번호1
    initEmEdit(EM_HOME_PH2, "NUMBER3^4^0", NORMAL);          //전화번호2
    initEmEdit(EM_HOME_PH3, "NUMBER3^4^0", NORMAL);          //전화번호3
    
    // 약속내역 EMEDIT
    initEmEdit(EM_FRST_PROM_DT, "YYYYMMDD", PK);             //최초약속일
    initEmEdit(EM_MOD_PROM_DT, "YYYYMMDD", READ);          //변경약속일
    initEmEdit(EM_IN_DELI_DT, "YYYYMMDD", PK);               //입고예정일
    initEmEdit(EM_SKU_NM, "GEN^40", NORMAL);                 //상품명
    initTxtAreaEdit(TXT_PROM_DTL, NORMAL);                   //약속내역
    
    // 배송정보 EMEDIT    
    initEmEdit(EM_COUR_CUST_NM, "GEN^40", PK);               //고객명
    initEmEdit(EM_COUR_POST_NO, "POST", READ);                 //우편번호
    initEmEdit(EM_COUR_ADDR, "GEN", READ);                   //주소
    initEmEdit(EM_COUR_DTL_ADDR, "GEN^80", PK);             //상세주소
    initEmEdit(EM_COUR_MOBILE_PH1, "NUMBER3^3^0", PK);       //휴대폰번호1
    initEmEdit(EM_COUR_MOBILE_PH2, "NUMBER3^4^0", PK);       //휴대폰번호2
    initEmEdit(EM_COUR_MOBILE_PH3, "NUMBER3^4^0", PK);       //휴대폰번호3
    initEmEdit(EM_COUR_HOME_PH1, "NUMBER3^3^0", NORMAL);     //전화번호1
    initEmEdit(EM_COUR_HOME_PH2, "NUMBER3^4^0", NORMAL);     //전화번호2
    initEmEdit(EM_COUR_HOME_PH3, "NUMBER3^4^0", NORMAL);     //전화번호3
    initEmEdit(EM_COUR_COMP_NM, "GEN^40", NORMAL);           //택배회사
    initEmEdit(EM_COUR_SEND_NO, "GEN^40", NORMAL);           //운송장번호
    
    
    //콤보 초기화(조회)
    initComboStyle(LC_S_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, NORMAL);                //점
    initComboStyle(LC_S_SEARCH_FLAG,DS_O_S_SEARCH_FLAG, "CODE^0^30,NAME^0^80", 1, PK);    //조회구분
    initComboStyle(LC_S_PROM_TYPE,DS_O_S_PROM_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);    //약속유형(조회)
    
    //기본사항 콤보
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);                    //점(기본사항)

    //약속내역
    initComboStyle(LC_FRST_HH,DS_O_FRST_HH, "CODE^0^30,NAME^0^30", 1, PK);        //최초약속 시간
    initComboStyle(LC_FRST_MM,DS_O_FRST_MM, "CODE^0^30,NAME^0^80", 1, PK);        //최초약속 분
    initComboStyle(LC_PROM_TYPE,DS_O_PROM_TYPE, "CODE^0^30,NAME^0^80", 1, PK);      //약속유형     
    initComboStyle(LC_DELI_TYPE,DS_O_DELI_TYPE, "CODE^0^30,NAME^0^80", 1, PK);      //인도방식
    initComboStyle(LC_MOD_PROM_HH,DS_O_MOD_PROM_HH, "CODE^0^0,NAME^0^30", 1, READ);        //변경약속 시간
    initComboStyle(LC_MOD_PROM_MM,DS_O_MOD_PROM_MM, "CODE^0^30,NAME^0^80", 1, READ);        //변경약속 분
    initComboStyle(LC_DELI_STR,DS_O_DELI_STR, "CODE^0^30,NAME^0^80", 1, PK);        //인도점
    
   //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_O_S_SEARCH_FLAG",   "D", "M061", "N");
    getEtcCode("DS_O_S_PROM_TYPE",   "D", "M021", "Y");
    getEtcCode("DS_O_FRST_HH",   "D", "M059", "N");
    getEtcCode("DS_O_FRST_MM",   "D", "M060", "N");
    getEtcCode("DS_O_PROM_TYPE",   "D", "M021", "N");
    getEtcCode("DS_O_DELI_TYPE",   "D", "M022", "N");
    getEtcCode("DS_O_MOD_PROM_HH",   "D", "M059", "N");
    getEtcCode("DS_O_MOD_PROM_MM",   "D", "M060", "N");
    getEtcCode("DS_O_PROC_STAT_OLD",   "D", "M024", "N");
    
    DS_O_PROC_STAT.setDataHeader('CODE:STRING(1),NAME:STRING(40),SORT:DECIMAL(40),DISABLE:STRING(1)');
    var strData = DS_O_PROC_STAT_OLD.ExportData(1,DS_O_PROC_STAT_OLD.CountRow, true );
    DS_O_PROC_STAT.ImportData(strData);
    
   for(var i=1; i<=DS_O_PROC_STAT.CountRow;i++){
       if( DS_O_PROC_STAT.NameValue(i,"CODE") == 1 || DS_O_PROC_STAT.NameValue(i,"CODE") == 4 ){
           DS_O_PROC_STAT.NameValue(i,"DISABLE") = "T";
       }else{
           DS_O_PROC_STAT.NameValue(i,"DISABLE") = "F";
       }
   }
   DS_O_PROC_STAT.ResetStatus();
    
    getStore("DS_O_S_STR", "Y", "", "Y");
    getStore("DS_O_STR", "Y", "", "N");
    getStore("DS_O_DELI_STR", "Y", "", "N");
    setObject();
    
    // 조회구분 셋팅
    LC_S_SEARCH_FLAG.Index = 0;
    LC_S_STR.Index = 0;
    LC_S_PROM_TYPE.Index = 0;
    registerUsingDataset("mpro101","DS_IO_MASTER" );
    LC_S_STR.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"             width=30   align=center</FC>'
                     + '<FC>id=STR_CD            name="점"             width=80   align=left EditStyle=Lookup   Data="DS_O_STR:CODE:NAME" </FC>'
                     + '<FC>id=TAKE_DT            name="접수일자"       width=80   align=center Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=TAKE_SEQ            name="접수순번"            width=60   align=center</FC>'
                     + '<FC>id=PUMBUN_CD            name="브랜드"         width=60   align=center show=false</FC>'
                     + '<FC>id=PUMBUN_NM            name="브랜드"         width=60   align=center show=false</FC>'
                     + '<FC>id=CUST_NM            name="고객명"         width=60   align=left</FC>'
                     + '<FC>id=POST_NO            name="우편번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=ADDR            name="주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=DTL_ADDR            name="상세주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH1            name="휴대폰번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH2            name="휴대폰번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH3            name="휴대폰번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=FRST_PROM_DT            name="최초약속일"         width=60   align=center show=false</FC>'
                     + '<FC>id=FRST_PROM_HH            name="최초약속시간"         width=60   align=center show=false</FC>'
                     + '<FC>id=FRST_PROM_MM            name="최초약속분"         width=60   align=center show=false</FC>'
                     + '<FC>id=PROM_TYPE            name="약속유형"       width=60   align=center EditStyle=Lookup   Data="DS_O_PROM_TYPE:CODE:NAME" </FC>'
                     + '<FC>id=DELI_TYPE            name="인도방식"         width=60   align=center show=false</FC>'
                     + '<FC>id=DELI_STR            name="인도점"         width=60   align=center show=false</FC>'
                     + '<FC>id=IN_DELI_DT            name="입고예정일"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_CUST_NM            name="배송고객명"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_POST_NO            name="배송우편번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_ADDR            name="배송주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUT_ADDR_DTL            name="배송상세주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_MOBILE_PH1            name="배송휴대폰번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_MOBILE_PH2            name="배송휴대폰번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_MOBILE_PH3            name="배송휴대폰번호"         width=60   align=center show=false</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2011-02-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search(flag) {
    
     if(flag != "reset"){
         if(DS_IO_MASTER.IsUpdated){
            if(showMessage(QUESTION , YESNO, "GAUCE-1000", "약속내용이 저장되지 않았습니다. <br> 새로 조회하시겠습니까?") != 1 ){
                return;
                }
            }
     }
     if(LC_S_SEARCH_FLAG.Text.length == 0){  // 조회구분
        showMessage(EXCLAMATION , OK, "USER-1001", "조회구분");
        LC_S_SEARCH_FLAG.focus();
        return;
    }
    if(EM_S_SEARCH_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_SEARCH_DT.focus();
        return;
    }else if(EM_E_SEARCH_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        M_E_SEARCH_DT.focus();
        return;
    }else if(EM_S_SEARCH_DT.Text > EM_E_SEARCH_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_SEARCH_DT.focus();
        return;
    }

    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;
    var strSearchFlag   = LC_S_SEARCH_FLAG.BindColVal;
    var strSdt          = EM_S_SEARCH_DT.Text;
    var strEdt          = EM_E_SEARCH_DT.Text;
    var strCustNm       = EM_S_CUST.Text;
    var strPumbunCd     = EM_S_PUMBUN_CD.Text;
    var strPromType     = LC_S_PROM_TYPE.BindColVal;
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     +encodeURIComponent(strStrCd)
                   + "&strSearchFlag="+encodeURIComponent(strSearchFlag)
                   + "&strSdt="       +encodeURIComponent(strSdt)
                   + "&strEdt="       +encodeURIComponent(strEdt)
                   + "&strCustNm="    +encodeURIComponent(strCustNm)
                   + "&strPumbunCd="  +encodeURIComponent(strPumbunCd)
                   + "&strPromType="  +encodeURIComponent(strPromType);
    TR_MAIN.Action="/mss/mpro101.mp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //GD_MASTER.Focus();
    // 저장전 Row 셋팅
    if(strCurRow > 1){
        DS_IO_MASTER.RowPosition = strCurRow;
    }
    setObject();
 // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-02-16
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
       if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"TAKE_SEQ") == ""){
             if(showMessage(QUESTION , YESNO, "GAUCE-1000", "약속내용이 저장되지 않았습니다. <br> 새로 등록하시겠습니까?") != 1 ){
                 return;
             }else{
                 DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
                 }
       }
     
     DS_IO_MASTER.AddRow();
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_USER_ID") = "mss";
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_STAT") = "1";
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_DT") = getTodayFormat("yyyymmdd");
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FRST_PROM_DT") = getTodayFormat("yyyymmdd");
     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "IN_DELI_DT") = getTodayFormat("yyyymmdd");
     LC_STR.Index = 0 ;
     LC_FRST_HH.Index = 0 ;
     LC_FRST_MM.Index = 0 ;
     LC_PROM_TYPE.Index = 0 ;
     LC_DELI_TYPE.Index = 0 ;
     LC_DELI_STR.Index = 0 ;
     setObject();
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
 * 작 성 일 : 2011-02-16
 * 개    요 : DB에 저장 / 수정
 * return값 : void
 */
function btn_Save() {
     // 저장할 데이터 없는 경우
       if (!DS_IO_MASTER.IsUpdated || DS_IO_MASTER.CountRow == 0){
           //저장할 내용이 없습니다
           showMessage(EXCLAMATION , OK, "USER-1028");
           return;
       }
     if(LC_DELI_TYPE.BindColVal == "02"){ // 택배수령시 배송정보 포함
         if(!checkBindBlank( GD_MASTER, BO_MASTER, "TAKE_SEQ")) return; 
     }else{
         if(!checkBindBlank( GD_MASTER, BO_MASTER, "TAKE_SEQ,COUR_CUST_NM,COUR_POST_NO,COUR_ADDR,COUR_ADDR_DTL,COUR_MOBILE_PH1,COUR_MOBILE_PH2,COUR_MOBILE_PH3"))
                return;
     }

     if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    
       btnClickSave = true;
       TR_MAIN.Action="/mss/mpro101.mp?goTo=savePromise";
       TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
       TR_MAIN.Post();
       btnClickSave = false;
       strCurRow = DS_IO_MASTER.RowPosition;
       
       // 정상 처리일 경우 조회
        if( TR_MAIN.ErrorCode == 0) btn_Search();
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
  * openHisPop()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-17
  * 개    요 : 약속변경 popup
  * return값 : void
  */
 function openHisPop()
 {
     if(DS_IO_MASTER.CountRow == 0){
         showMessage(EXCLAMATION , OK, "USER-1000", "변경할 약속 내용이 없습니다.");
         return;
     }
     
     if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_SEQ") == ""){
         showMessage(EXCLAMATION , OK, "USER-1000", "먼저 약속내용을 저장해주세요.");
         return;
     }
     
     if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_STAT") == "5"){
         showMessage(EXCLAMATION , OK, "USER-1000", "해피콜이 완료된 약속은 수정이 불가능합니다.");
         return;
     }
     
     var arrArg  = new Array();
    
     arrArg.push(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_DT"));
     arrArg.push(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD"));
     arrArg.push(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_SEQ"));   
     arrArg.push(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_STAT"));   
     
     var returnVal = window.showModalDialog("/mss/mpro101.mp?goTo=openHisPop",
                                            arrArg,
                                            "dialogWidth:1000px;dialogHeight:420px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     if(returnVal == "save") btn_Search();
 }

 /**
  * setDeliInfo()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-17
  * 개    요 : 배송정보 셋팅
  * return값 : void
  */
 function setDeliInfo()
{
     // if(document.getElementById("CHK_DELI").checked){
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_CUST_NM") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CUST_NM");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_POST_NO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "POST_NO");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_CUST_POST_NO") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CUST_POST_NO");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_ADDR") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ADDR");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_DTL_ADDR") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DTL_ADDR");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH1") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOBILE_PH1");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH2") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOBILE_PH2");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH3") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MOBILE_PH3");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH1") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HOME_PH1");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH2") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HOME_PH2");
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH3") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HOME_PH3");
     /* }else{
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_CUST_NM") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_POST_NO") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_CUST_POST_NO") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_ADDR") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_DTL_ADDR") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH1") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH2") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH3") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH1") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH2") = "";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH3") = "";
      }*/
}
 
 
 /**
  * setObject()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-17
  * 개    요 : 등록정보 enable 셋팅
  * return값 : void
  */
 function setObject()
{
     var contents = document.getElementsByName("CONTENTS");
     var courContents = document.getElementsByName("COUR_CONTENTS");
     if(DS_IO_MASTER.CountRow == 0 
             || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_STAT") == 4
             || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HAPPY_CALL_YN") == "T"){
         for(var i=0;i<contents.length;i++){
             contents[i].Enable = false;
             CHK_SMS_YN.disabled = true;
         }
        // 배송정보 
         for(var j=0;j<courContents.length;j++){
             courContents[j].Enable = false;
         }
         RD_PROC_STAT.Enable = false;
         setImgObject(false);
         enableControl(IMG_COUR_POST_NO, false);
         enableControl(IMG_COPY_CUST, false);
         enableControl(IMG_PUMBUN, false);
         enableControl(IMG_TAKE_DT, false);
         enableControl(IMG_POST_NO, false);
     }else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_STAT") != 4
          || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HAPPY_CALL_YN") != "T"
          || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_SEQ") == ""){
         
         for(var i=0;i<contents.length;i++){
             contents[i].Enable = true;
             CHK_SMS_YN.disabled = false;
         }
         enableControl(IMG_PUMBUN, true);
         enableControl(IMG_TAKE_DT, true);
         enableControl(IMG_POST_NO, true);
         if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAKE_SEQ") != ""){
             LC_STR.Enable = false;
             EM_TAKE_DT.Enable = false;
             EM_FRST_PROM_DT.Enable = false;
             LC_FRST_HH.Enable = false;
             LC_FRST_MM.Enable = false;
             LC_PROM_TYPE.Enable = false;
             EM_MOD_PROM_DT.Enable = false;
             LC_MOD_PROM_HH.Enable = false;
             LC_MOD_PROM_MM.Enable = false;
             LC_DELI_STR.Enable = false;
             EM_IN_DELI_DT.Enable = false;
             LC_DELI_TYPE.Enable = false;
             RD_PROC_STAT.Enable = "true";
             EM_PUMBUN_CD.Enable = false;
             RD_PROC_STAT.Reset();
             setImgObject(false);
             enableControl(IMG_PUMBUN, false);
             enableControl(IMG_TAKE_DT, false);
         }else{
             RD_PROC_STAT.Enable = false;
             setImgObject(true);
         }
         
         setCourObject();
     }
     
     LC_STR.Focus();
}
 
 /**
  * setImgObject()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-17
  * 개    요 : 등록정보 enable 셋팅
  * return값 : void
  */
 function setImgObject(strFlag)
{
     enableControl(IMG_FRST_PROM_DT, strFlag);
     enableControl(IMG_IN_DELI_DT, strFlag);
}
 
 /**
  * setCourObject()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-17
  * 개    요 : 배송정보 enable 셋팅
  * return값 : void
  */
 function setCourObject()
{
    var courContents = document.getElementsByName("COUR_CONTENTS");
    var strFlag = false;
    
    if(LC_DELI_TYPE.BindColVal == "02"){ // 01: 고객내방 , 02: 택배수령
        strFlag =  true;
    }
    
     // 배송정보 
     for(var j=0;j<courContents.length;j++){
         courContents[j].Enable = strFlag;
     }
     
     enableControl(IMG_COUR_POST_NO, strFlag);
     enableControl(IMG_COPY_CUST, strFlag);
     
     if(!strFlag){
        /* DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_CUST_NM") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_POST_NO") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_CUST_POST_NO") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_ADDR") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_DTL_ADDR") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH1") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH2") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_MOBILE_PH3") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH1") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH2") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COUR_HOME_PH3") = "";*/
     }
} 
 /**
  * openPop()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-22
  * 개    요 : 브랜드 팝업 오픈
  * return값 : void
  */
 function openPop(strFlag, strGbn){
      
      if(strFlag == "S"){
          var objCd = EM_S_PUMBUN_CD;
          var objNm = EM_S_PUMBUN_NM;
          var objStr = LC_S_STR;
      }else if(strFlag == "I"){
          var objCd = EM_PUMBUN_CD;
          var objNm = EM_PUMBUN_NM;
          var objStr = LC_STR;  
      }
      
      if(objStr.BindColVal == "" || objStr.BindColVal == "%"){
          showMessage(EXCLAMATION , OK, "USER-1000","브랜드 조회시에는 점을 선택해주세요.");
          objStr.Focus();
          return;
      }
      
      if(strGbn == "N" && objCd.Text.length > 0){
          setStrPbnNmWithoutPop("DS_O_RESULT", objCd, objNm, "Y", "1", "",objStr.BindColVal);
      }else{
          strPbnPop( objCd, objNm, "N", "", objStr.BindColVal);       
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
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if(DS_IO_MASTER.IsUpdated && !btnClickSave){
    if(showMessage(QUESTION , YESNO, "GAUCE-1000", "변경된 내용이 있습니다. 초기화 하시겠습니까?") == 1 ){
        btn_Search("reset");
        return true;
    }else{
        return false;
    }
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(row == 0) return;
setObject();
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--  ===================GD_MASTER============================ -->
<!-- Grid Master CanRowPosChange event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
strCurRow = row;
//setObject();
</script>

<!--  ===================GD_MASTER============================ -->
<!-- 조회용 브랜드  조회 -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_S_PUMBUN_CD.Text ==""){
    EM_S_PUMBUN_NM.Text = "";
       return;
   }
    if(EM_S_PUMBUN_CD.text!=null){
        if(EM_S_PUMBUN_CD.text.length > 0){
            openPop("S", "N");
        }
    }
</script>

<!-- 등록용 브랜드  조회 -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_PUMBUN_CD.Text ==""){
    EM_PUMBUN_NM.Text = "";
       return;
   }
    if(EM_PUMBUN_CD.text!=null){
        if(EM_PUMBUN_CD.text.length > 0){
            openPop("I", "N");
        }
    }
</script>
<script language=JavaScript for=LC_DELI_TYPE event=OnSelChange()>
if(DS_IO_MASTER.CountRow == 0 
        || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PROC_STAT") == 4
        || DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "HAPPY_CALL_YN") == "T") return;
setCourObject();
</script>
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
EM_S_PUMBUN_CD.Text = "";
EM_S_PUMBUN_NM.Text = "";
</script>
<script language=JavaScript for=LC_STR event=OnSelChange()>
EM_PUMBUN_CD.Text = "";
EM_PUMBUN_NM.Text = "";
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
<comment id="_NSID_"><object id="DS_I_COMMON"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SCH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PROMISE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_SEARCH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROM_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_FRST_HH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_FRST_MM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PROM_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DELI_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DELI_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MOD_PROM_HH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MOD_PROM_MM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PROC_STAT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PROC_STAT_OLD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Input & Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<DIV id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
            <th width="80">점</th>
            <td width="120">
                  <comment id="_NSID_">
                      <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> width="120" align="absmiddle" tabindex=1>
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="POINT">조회구분</th>
            <td width="150">
                  <comment id="_NSID_">
                      <object id=LC_S_SEARCH_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width="150" align="absmiddle" tabindex=1>
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="POINT">기간</th>
            <td>
                      <comment id="_NSID_">
                          <object id=EM_S_SEARCH_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_SEARCH_DT)" align="absmiddle"/>
                      ~
                      <comment id="_NSID_">
                          <object id=EM_E_SEARCH_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_SEARCH_DT)" align="absmiddle"/>
            </td>
          </tr>
          <tr>
            <th width="80">고객명</th>
            <td width="120">
                      <comment id="_NSID_">
                          <object id=EM_S_CUST classid=<%=Util.CLSID_EMEDIT%> onKeyup="javascript:checkByteStr(this, 40, 'Y');" width="120" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
            
            </td>
            <th width="80">약속유형</th>
            <td width="150">
                  <comment id="_NSID_">
                      <object id=LC_S_PROM_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width="150" align="absmiddle" tabindex=1>
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">브랜드</th>
            <td>
                      <comment id="_NSID_">
                          <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width="60" tabindex=1 align="absmiddle">
                          </object>
                          </comment>
                      <script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:openPop('S')" align="absmiddle"/>
                        <comment id="_NSID_">
                          <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width="110" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      
            </td>
          </tr>
          </table>
        </td>
        </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr> 
  <tr>
    <td class="PB03">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td width="32%">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 약속목록</td></tr>
        <tr><td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr>
                        <td width="100%">
                            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=465 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_IO_MASTER">
                            </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
        </td></tr>
        </table>
    </td>
    <td>
     <div id="DIV_CONTENTS" style=" width:100%; height:490; overflow-y:scroll;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr height=15>
                <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>기본사항</td>
            </tr>
            <tr valign="top">
                  <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90" class="POINT">점</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=LC_STR name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="90" class="POINT">접수일자</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_TAKE_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width=120 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_TAKE_DT onclick="javascript:openCal('G',EM_TAKE_DT)" align="absmiddle"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">접수순번</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=EM_TAKE_SEQ classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                 <th class="POINT">접수자</th>
                                <td> 
                                      <comment id="_NSID_">
                                          <object id=EM_TAKE_USER_NM classid=<%=Util.CLSID_EMEDIT%>  width=143 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">조직코드</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_ORG_CD classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <comment id="_NSID_">
                                          <object id=EM_ORG_NM classid=<%=Util.CLSID_EMEDIT%>  width=261 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                               <th class="POINT">브랜드</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_PUMBUN_CD name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle">
                                          </object>
                                          </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_PUMBUN class="PR03" onclick="javascript:openPop('I')"  align="absmiddle"/>
                                       <comment id="_NSID_">
                                          <object id=EM_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=239 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr height=20>
                        <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>고객정보</td>
                    </tr>
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90" class="POINT">고객명</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=EM_CUST_NM name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onKeyup="javascript:checkByteStr(this, 40, 'Y');" width=140 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">SMS수신여부 </th>
                                <td><input id=CHK_SMS_YN name="CONTENTS" type="checkbox" tabindex=1/></td>
                            </tr>
                            <tr>
                                <th width="90" class="POINT">우편번호</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_POST_NO classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_POST_NO class="PR03" onclick="javascript:getPostPop(EM_POST_NO, EM_ADDR, EM_DETL_ADDR);" align="absmiddle"/>
                                </td>
                            </tr>
                            <tr>
                               <th width="90" class="POINT">주소</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%>  width=403 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90" class="POINT">상세주소</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_DETL_ADDR name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onKeyup="javascript:checkByteStr(this, 80, 'Y');" width=403 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90" class="POINT">휴대폰번호</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=EM_MOBILE_PH1 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script> 
                                      - <comment id="_NSID_">
                                          <object id=EM_MOBILE_PH2 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script> 
                                      - <comment id="_NSID_">
                                          <object id=EM_MOBILE_PH3 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">전화번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_HOME_PH1 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script> 
                                      - <comment id="_NSID_">
                                          <object id=EM_HOME_PH2 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script> 
                                      - <comment id="_NSID_">
                                          <object id=EM_HOME_PH3 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr>
                        <td><table width="100%">
                            <tr>
                                <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle" onclick="javascript:"/>약속내역
                                </td>
                                <td align="right"><img src="/<%=dir%>/imgs/btn/change_promise.gif" onClick="javascript:openHisPop();" align="absmiddle"/>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90" class="POINT">최초약속일</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_FRST_PROM_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width=120 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_FRST_PROM_DT onclick="javascript:openCal('G',EM_FRST_PROM_DT)" align="absmiddle"/>
                                      &nbsp;
                                      <comment id="_NSID_">
                                          <object id=LC_FRST_HH name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                       <comment id="_NSID_">
                                          <object id=LC_FRST_MM name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90" class="POINT">약속유형</th>
                                <td width=145>
                                      <comment id="_NSID_">
                                          <object id=LC_PROM_TYPE name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=145 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="90" class="POINT">인도방식</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=LC_DELI_TYPE name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">최종약속일</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_MOD_PROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      &nbsp;&nbsp;
                                       <comment id="_NSID_">
                                          <object id=LC_MOD_PROM_HH classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                       <comment id="_NSID_">
                                          <object id=LC_MOD_PROM_MM classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">인도점</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=LC_DELI_STR name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th class="POINT">입고예정일</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_IN_DELI_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width=120 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_IN_DELI_DT onclick="javascript:openCal('G',EM_IN_DELI_DT)" align="absmiddle"/>
                                </td>
                            </tr>
                            <tr>
                                <th>상품명</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_SKU_NM name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onKeyup="javascript:checkByteStr(this, 40, 'Y');"   width=400 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>약속내역</th>
                                <td colspan="3" class="PT03 PB03">
                                      <comment id="_NSID_">
                                       <object id=TXT_PROM_DTL name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%> onKeyup="javascript:checkByteStr(this, 4000, 'Y');"  width=400 height=50 tabindex=1 align="absmiddle">
                                        </object></comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr height="10"></tr>
                    <tr>
                        <table width="100%">
                            <tr>
                                <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle" onclick="javascript:"/>배송정보
                                </td>
                                <td align="right"><img src="/<%=dir%>/imgs/btn/cust_info_apply.gif" id=IMG_COPY_CUST onClick="javascript:setDeliInfo();" align="absmiddle"/>
                                </td>
                            </tr>
                        </table>
                          </td>
                    </tr>
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90" class="POINT">고객명</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_CUST_NM name="COUR_CONTENTS" onKeyup="javascript:checkByteStr(this, 40, 'Y');" classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90" class="POINT">우편번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_POST_NO classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" name=IMG_COUR_POST_NO class="PR03" onclick="javascript:getPostPop(EM_COUR_POST_NO, EM_COUR_ADDR, EM_COUR_DTL_ADDR);" align="absmiddle"/>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">주소</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_ADDR classid=<%=Util.CLSID_EMEDIT%>  width=403 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                             <tr>
                                <th class="POINT">상세주소</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_DTL_ADDR name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onKeyup="javascript:checkByteStr(this, 80, 'Y');" width=403 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT">휴대폰번호</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_MOBILE_PH1 name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_MOBILE_PH2 name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_MOBILE_PH3 name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th >전화번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_HOME_PH1 name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_HOME_PH2 name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_HOME_PH3 name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th>택배회사</th>
                                <td width="150">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_COMP_NM name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th >운송장번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_SEND_NO name="COUR_CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr height=22 >
                        <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>진행상태</td>
                    </tr>
                    <tr>
                        <td><table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width=400>
                                    <comment id="__NSID__">
                                    <object id=RD_PROC_STAT name="CONTENTS" classid=<%=Util.CLSID_RADIO%> style="height:30; width:400">
                                        <param name=RadioDataID         value="DS_O_PROC_STAT"> 
                                        <param name=DataID              value="DS_IO_MASTER"> 
                                        <param name=CodeRColumn         value="CODE">
                                        <param name=DataRColumn         value="NAME">
                                        <param name=CodeColumn          value="PROC_STAT">
                                        <param name=DataColumn          value="PROC_STAT_NM">
                                        <param name=DisabledColumn      value="DISABLE">
                                        <param name=Cols                value="4">  
                                    </object></comment><SCRIPT>_ws_(__NSID__);</SCRIPT>
                                    </th>
                                   <th>
                                    <input id=CHK_HAPPY_CALL_YN name="CONTENTS" type="checkbox" disabled="false"/> 해피콜 완료
                                    </th>
                            </tr>
                        </table></td>
                    </tr>
        </table></td>
            </tr>
           
        </table>
    </div>
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
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=STR_CD               ctrl=LC_STR             param=BindColVal</c>
        <c>col=TAKE_DT              ctrl=EM_TAKE_DT         param=Text</c>
        <c>col=TAKE_SEQ             ctrl=EM_TAKE_SEQ        param=Text</c>
        <c>col=PUMBUN_CD            ctrl=EM_PUMBUN_CD       param=Text</c>
        <c>col=PUMBUN_NM            ctrl=EM_PUMBUN_NM       param=Text</c>
        <c>col=ORG_CD               ctrl=EM_ORG_CD          param=Text</c>
        <c>col=ORG_NM               ctrl=EM_ORG_NM          param=Text</c>
        <c>col=TAKE_USER_NM         ctrl=EM_TAKE_USER_NM    param=Text</c>
        <c>col=CUST_NM              ctrl=EM_CUST_NM         param=Text</c>
        <c>col=SMS_YN               ctrl=CHK_SMS_YN         param=Checked</c>
        <c>col=POST_NO              ctrl=EM_POST_NO         param=Text</c>
        <c>col=ADDR                 ctrl=EM_ADDR            param=Text</c>
        <c>col=DTL_ADDR             ctrl=EM_DETL_ADDR       param=Text</c>
        <c>col=MOBILE_PH1           ctrl=EM_MOBILE_PH1      param=Text</c>
        <c>col=MOBILE_PH2           ctrl=EM_MOBILE_PH2      param=Text</c>
        <c>col=MOBILE_PH3           ctrl=EM_MOBILE_PH3      param=Text</c>
        <c>col=HOME_PH1             ctrl=EM_HOME_PH1        param=Text</c>
        <c>col=HOME_PH2             ctrl=EM_HOME_PH2        param=Text</c>
        <c>col=HOME_PH3             ctrl=EM_HOME_PH3        param=Text</c>
        <c>col=FRST_PROM_DT         ctrl=EM_FRST_PROM_DT    param=Text</c>
        <c>col=FRST_PROM_HH         ctrl=LC_FRST_HH         param=BindColVal</c>
        <c>col=FRST_PROM_MM         ctrl=LC_FRST_MM         param=BindColVal</c>
        <c>col=PROM_TYPE            ctrl=LC_PROM_TYPE       param=BindColVal</c>
        <c>col=DELI_TYPE            ctrl=LC_DELI_TYPE       param=BindColVal</c>
        <c>col=LAST_PROM_DT          ctrl=EM_MOD_PROM_DT     param=Text</c>
        <c>col=LAST_PROM_HH          ctrl=LC_MOD_PROM_HH     param=BindColVal</c>
        <c>col=LAST_PROM_MM          ctrl=LC_MOD_PROM_MM     param=BindColVal</c>
        <c>col=DELI_STR             ctrl=LC_DELI_STR        param=BindColVal</c>
        <c>col=IN_DELI_DT           ctrl=EM_IN_DELI_DT      param=Text</c>
        <c>col=SKU_NM               ctrl=EM_SKU_NM          param=Text</c>
        <c>col=PROM_DTL             ctrl=TXT_PROM_DTL       param=Text</c>
        <c>col=COUR_CUST_NM         ctrl=EM_COUR_CUST_NM    param=Text</c>
        <c>col=COUR_POST_NO         ctrl=EM_COUR_POST_NO    param=Text</c>
        <c>col=COUR_ADDR            ctrl=EM_COUR_ADDR       param=Text</c>
        <c>col=COUR_DTL_ADDR        ctrl=EM_COUR_DTL_ADDR   param=Text</c>
        <c>col=COUR_MOBILE_PH1      ctrl=EM_COUR_MOBILE_PH1 param=Text</c>
        <c>col=COUR_MOBILE_PH2      ctrl=EM_COUR_MOBILE_PH2 param=Text</c>
        <c>col=COUR_MOBILE_PH3      ctrl=EM_COUR_MOBILE_PH3 param=Text</c>
        <c>col=COUR_HOME_PH1        ctrl=EM_COUR_HOME_PH1   param=Text</c>
        <c>col=COUR_HOME_PH2        ctrl=EM_COUR_HOME_PH2   param=Text</c>
        <c>col=COUR_HOME_PH3        ctrl=EM_COUR_HOME_PH3   param=Text</c>
        <c>col=COUR_COMP_NM         ctrl=EM_COUR_COMP_NM    param=Text</c>
        <c>col=COUR_SEND_NO         ctrl=EM_COUR_SEND_NO    param=Text</c>
        <c>col=HAPPY_CALL_YN        ctrl=CHK_HAPPY_CALL_YN  param=Checked</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

