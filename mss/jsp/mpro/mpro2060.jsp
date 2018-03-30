<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 약속관리 > 약속분석
 * 작 성 일 : 2011.03.11
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : mpro2060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 해피콜미이행조회
 * 이    력 :
 
 *        2011.03.11 (오형규)
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
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

var strCd    = dialogArguments[0];
var takeDt      = dialogArguments[1];
var userid      = dialogArguments[2];
var strToday    = getTodayFormat("yyyymmdd")

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_POP_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
        

    //기본사항 EMEDITEM_SEL_DATE
    
    initEmEdit(EM_TAKE_DT, "YYYYMMDD", READ);                  //접수일자
    initEmEdit(EM_TAKE_SEQ, "GEN", READ);                    //접수순번
    initEmEdit(EM_PUMBUN_CD, "GEN^6", READ);                     //브랜드코드
    initEmEdit(EM_PUMBUN_NM, "GEN", READ);                     //브랜드명
    initEmEdit(EM_ORG_CD, "GEN", READ);                         //조직코드
    initEmEdit(EM_ORG_NM, "GEN", READ);                         //조직명
    initEmEdit(EM_TAKE_USER_NM, "GEN^40", READ);           //접수자 명
    
    // 고객정보 EMEDIT
    initEmEdit(EM_CUST_NM, "GEN^40", READ);                   //고객명
    initEmEdit(EM_POST_NO, "POST", READ);                  //우편번호
    initEmEdit(EM_ADDR, "GEN", READ);                        //주소
    initEmEdit(EM_DETL_ADDR, "GEN^100", READ);             //상세주소
    initEmEdit(EM_MOBILE_PH1, "GEN^3", READ);            //휴대폰번호1    
    initEmEdit(EM_MOBILE_PH2, "GEN^4", READ);            //휴대폰번호2
    initEmEdit(EM_MOBILE_PH3, "GEN^4", READ);            //휴대폰번호3
    initEmEdit(EM_HOME_PH1, "GEN^3", READ);          //전화번호1
    initEmEdit(EM_HOME_PH2, "GEN^4", READ);          //전화번호2
    initEmEdit(EM_HOME_PH3, "GEN^4", READ);          //전화번호3
    
    // 약속내역 EMEDIT
    initEmEdit(EM_FRST_PROM_DT, "YYYYMMDD", READ);             //최초약속일
    initEmEdit(EM_MOD_PROM_DT, "YYYYMMDD", READ);          //변경약속일
    initEmEdit(EM_IN_DELI_DT, "YYYYMMDD", READ);               //입고예정일
    initEmEdit(EM_SKU_NM, "GEN^40", READ);                 //상품명
    initTxtAreaEdit(TXT_PROM_DTL, READ);                   //약속내역
    
    // 배송정보 EMEDIT    
    initEmEdit(EM_COUR_CUST_NM, "GEN^40", READ);               //고객명
    initEmEdit(EM_COUR_POST_NO, "POST", READ);                 //우편번호
    initEmEdit(EM_COUR_ADDR, "GEN", READ);                   //주소
    initEmEdit(EM_COUR_DTL_ADDR, "GEN^100", READ);             //상세주소
    initEmEdit(EM_COUR_MOBILE_PH1, "GEN^3", READ);       //휴대폰번호1
    initEmEdit(EM_COUR_MOBILE_PH2, "GEN^4", READ);       //휴대폰번호2
    initEmEdit(EM_COUR_MOBILE_PH3, "GEN^4", READ);       //휴대폰번호3
    initEmEdit(EM_COUR_HOME_PH1, "GEN^3", READ);     //전화번호1
    initEmEdit(EM_COUR_HOME_PH2, "GEN^4", READ);     //전화번호2
    initEmEdit(EM_COUR_HOME_PH3, "GEN^4", READ);     //전화번호3
    initEmEdit(EM_COUR_COMP_NM, "GEN^40", READ);           //택배회사
    initEmEdit(EM_COUR_SEND_NO, "GEN^40", READ);           //운송장번호
        
    
    //기본사항 콤보
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, READ);                    //점(기본사항)

    //약속내역
    initComboStyle(LC_FRST_HH,DS_O_FRST_HH, "CODE^0^30,NAME^0^30", 1, READ);        //최초약속 시간
    initComboStyle(LC_FRST_MM,DS_O_FRST_MM, "CODE^0^30,NAME^0^80", 1, READ);        //최초약속 분
    initComboStyle(LC_PROM_TYPE,DS_O_PROM_TYPE, "CODE^0^30,NAME^0^80", 1, READ);      //약속유형     
    initComboStyle(LC_DELI_TYPE,DS_O_DELI_TYPE, "CODE^0^30,NAME^0^80", 1, READ);      //인도방식
    initComboStyle(LC_MOD_PROM_HH,DS_O_MOD_PROM_HH, "CODE^0^0,NAME^0^30", 1, READ);        //변경약속 시간
    initComboStyle(LC_MOD_PROM_MM,DS_O_MOD_PROM_MM, "CODE^0^30,NAME^0^80", 1, READ);        //변경약속 분
    initComboStyle(LC_DELI_STR,DS_O_DELI_STR, "CODE^0^30,NAME^0^80", 1, READ);        //인도점
    
   //시스템 코드 공통코드에서 가지고 오기
    
    
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
   DS_O_PROC_STAT.NameValue(2,"DISABLE") = "T";
   DS_O_PROC_STAT.NameValue(3,"DISABLE") = "T";   
   DS_O_PROC_STAT.ResetStatus();
    
    getStore("DS_O_STR", "Y", "1", "Y");            //점코드    
    getStore("DS_O_DELI_STR", "Y", "N", "N", "N");
    
    
    getDetailSearch();
    
    // 조회구분 셋팅    
    registerUsingDataset("mpro202","DS_IO_MASTER" );
    
    
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"             width=30   align=center</FC>'
                     + '<FC>id=STR_CD            name="점"             width=80   align=left EditStyle=Lookup   Data="DS_O_STR:CODE:NAME" </FC>'
                     + '<FC>id=TAKE_DT            name="접수일자"       width=80   align=center Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=TAKE_SEQ            name="접수순번"            width=60   align=center show = false</FC>'
                     + '<FC>id=PUMBUN_CD            name="브랜드"         width=60   align=center show=false</FC>'
                     + '<FC>id=PUMBUN_NM            name="브랜드명"         width=60   align=center show=false</FC>'
                     + '<FC>id=CUST_NM            name="고객명"         width=60   align=center show=false </FC>'
                     + '<FC>id=POST_NO            name="우편번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=ADDR            name="주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=DTL_ADDR            name="상세주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH1            name="휴대폰번호1"         width=60   align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH2            name="휴대폰번호2"         width=60   align=center show=false</FC>'
                     + '<FC>id=MOBILE_PH3            name="휴대폰번호3"         width=60   align=center show=false</FC>'
                     + '<FC>id=FRST_PROM_DT            name="최초약속일"         width=60   align=center show=false</FC>'
                     + '<FC>id=FRST_PROM_HH            name="최초약속시간"         width=60   align=center show=false</FC>'
                     + '<FC>id=FRST_PROM_MM            name="최초약속분"         width=60   align=center show=false</FC>'
                     + '<FC>id=PROM_TYPE            name="약속유형"       width=60   align=center EditStyle=Lookup   Data="DS_O_PROM_TYPE:CODE:NAME" SHOW=FALSE </FC>'
                     + '<FC>id=DELI_TYPE            name="인도방식"         width=60   align=center show=false</FC>'
                     + '<FC>id=DELI_STR            name="인도점"         width=60   align=center show=false</FC>'
                     + '<FC>id=IN_DELI_DT            name="입고예정일"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_CUST_NM            name="배송고객명"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_POST_NO            name="배송우편번호"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_ADDR            name="배송주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUT_ADDR_DTL            name="배송상세주소"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_MOBILE_PH1            name="배송휴대폰번호1"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_MOBILE_PH2            name="배송휴대폰번호2"         width=60   align=center show=false</FC>'
                     + '<FC>id=COUR_MOBILE_PH3            name="배송휴대폰번호3"         width=60   align=center show=false</FC>'
                     + '<FC>id=OVERDAY             name="경과일"         width=60   align=center </FC>';
                     
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
function btn_Search() {
     
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-02-16
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
 * 작 성 일 : 2011-02-16
 * 개    요 : DB에 저장 / 수정
 * return값 : void
 */
function btn_Save() {
    
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
  * setObject()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011-03-07
  * 개    요 : 등록정보 enable 셋팅
  * return값 : void
  */
  
 function setObject()
{
       
    
    
   // enableControl(date2, false);
   // enableControl(date3, false);
  //  enableControl(zipcode2, false);
  //  enableControl(custimpo, false);
    
     
}
 
 /**
  * setObject()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011-03-07
  * 개    요 : popup 상세 조회
  * return값 : void
  */ 
function getDetailSearch(){
      
    setObject();
        
    var goTo       = "getDetailPopup";    
    var action     = "O";     
    var parameters =   "&strCd="   + encodeURIComponent(strCd)
                     + "&takeDt="  + encodeURIComponent(takeDt);   
    
    TR_MAIN.Action="/mss/mpro205.mp?goTo="+goTo+parameters + "&userid=" + encodeURIComponent(userid);  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
}
 
function btn_Close(){
    window.close();
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--  ===================GD_MASTER============================ -->
<!-- Grid Master CanRowPosChange event 처리 -->

<!--  ===================GD_MASTER============================ -->


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
<body onLoad="doInit();" class="PL10 PT05">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td class="title"><img
          src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
          align="absmiddle" class="popR05 PL03" /> <SPAN id="title1"
          class="PL03">해피콜미이행조회상세팝업</SPAN></td>
      <td>
      <table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
              <td class="PR10">
                  <img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22" onClick="btn_Close();" />
              </td>
          </tr>
        </table>
        </td>
    </tr>
</table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">  
  <tr>
    <td class="PB05 PT05 PR03">        
     <table width="100%" border="0" cellspacing="0" cellpadding="0">        
        <tr valign=top>
        <td width="32%">        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 약속목록</td></tr>
        <tr><td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                   <tr>
                       <td width="100%">
                           <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=650 classid=<%=Util.CLSID_GRID%>>
                               <param name="DataID" value="DS_IO_MASTER">
                           </OBJECT></comment><script>_ws_(_NSID_);</script>
                       </td>
                   </tr>
         </table>
        </td></tr>
        </table>
    </td>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>기본사항</td>
            </tr>
            <tr valign="top">
                  <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                        
                            <tr>
                                <th width="90">점</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=LC_STR name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=168 align="absmiddle" tabindex=1>
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="90">접수일자</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_TAKE_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>                                      
                                </td>
                            </tr>
                            
                            <tr>
                                <th width="90">접수순번</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=EM_TAKE_SEQ classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">접수자</th>
                                <td> 
                                      <comment id="_NSID_">
                                          <object id=EM_TAKE_USER_NM classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                              </tr>
                              
                              <tr>
                                <th width="90">브랜드</th>
                                <td colspan="3">
                                      <comment id="_NSID_">
                                          <object id=EM_PUMBUN_CD name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 align="absmiddle">
                                          </object>
                                          </comment>
                                      <script> _ws_(_NSID_);</script>                                      
                                       <comment id="_NSID_">
                                          <object id=EM_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=326 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>조직코드</th>
                                <td colspan="3">
                                      <comment id="_NSID_">
                                          <object id=EM_ORG_CD classid=<%=Util.CLSID_EMEDIT%>  width=120 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <comment id="_NSID_">
                                          <object id=EM_ORG_NM classid=<%=Util.CLSID_EMEDIT%>  width=326 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                              </tr>
                              
                        </table></td>
                    </tr>
                    <tr height=20>
                        <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif" id="custimpo" class="PR03" align="absmiddle"/>고객정보</td>
                    </tr>
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                        
                            <tr>
                                <th width="90">고객명</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=EM_CUST_NM name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">SMS수신여부 </th>
                                <td width="170"><input id="CHK_SMS_YN" name="CONTENTS" type="checkbox" disabled="false" /></td>
                            </tr>
                            
                            <tr>
                                <th width="90">우편번호</th>
                                <td colspan="3">
                                      <comment id="_NSID_">
                                          <object id=EM_POST_NO name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">주소</th>
                                <td  colspan="3">
                                      <comment id="_NSID_">
                                          <object id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=449 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">상세주소</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_DETL_ADDR name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=449 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>                           
                                <tr>
                                <th width="90">휴대폰번호</th>
                                <td width="170">
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
                    <tr height=20>
                        <td><table width="100%">
                            <tr>
                                <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle" />약속내역
                                </td>                                
                            </tr>
                        </table></td>
                    </tr>
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90">최초약속일</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_FRST_PROM_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <comment id="_NSID_">
                                          <object id=LC_FRST_HH name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                       <comment id="_NSID_">
                                          <object id=LC_FRST_MM name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">약속유형</th>
                                <td width=170>
                                      <comment id="_NSID_">
                                          <object id=LC_PROM_TYPE name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=168 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="90">인도방식</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=LC_DELI_TYPE name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=168 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">변경약속일</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_MOD_PROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       <comment id="_NSID_">
                                          <object id=LC_MOD_PROM_HH classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                       <comment id="_NSID_">
                                          <object id=LC_MOD_PROM_MM classid=<%= Util.CLSID_LUXECOMBO %> width=90 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">인도점</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=LC_DELI_STR name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=168 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="90">입고예정일</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_IN_DELI_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">상품명</th>
                                <td colspan=3>
                                      <comment id="_NSID_">
                                          <object id=EM_SKU_NM name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=449 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">약속내역</th>
                                <td colspan="3" class="PB03 PT03">
                                      <comment id="_NSID_">
                                       <object id=TXT_PROM_DTL name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%>   width=450 height=50 tabindex=1 align="absmiddle">
                                        </object></comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr height=20>
                        <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>배송정보&nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90">고객명</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_CUST_NM name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">우편번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_POST_NO name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">주소</th>
                                <td colspan="3">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_ADDR classid=<%=Util.CLSID_EMEDIT%>  width=449 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>                                
                            </tr>
                            <tr>
                                <th width="90">상세주소</th>
                                <td colspan="3">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_DTL_ADDR name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=449 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">휴대폰번호</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_MOBILE_PH1 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_MOBILE_PH2 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_MOBILE_PH3 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">전화번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_HOME_PH1 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_HOME_PH2 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                       - <comment id="_NSID_">
                                          <object id=EM_COUR_HOME_PH3 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=40 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">택배회사</th>
                                <td width="170">
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_COMP_NM name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="90">운송장번호</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_COUR_SEND_NO name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr height=20>
                        <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>진행상태</td>
                    </tr>
                    <tr>
                        <td><table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th>
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
    </td>
    </tr>
    </table>
    </td>
    </tr>
</table>

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

