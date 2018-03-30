<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 약속관리 > 해피콜관리 
 * 작 성 일 : 2011.02.25
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : mpro1050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전화통화관리
 * 이    력 :
 *
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

<% String dir = BaseProperty.get("context.common.dir"); %>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

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

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MRMASTER"/>');//마스터
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_HAPPYCALLMGRDETAIL"/>');//상세보기 
     
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_SALE_S_DT, "SYYYYMMDD", PK);          //기간 시작일
    initEmEdit(EM_SALE_E_DT, "TODAY", PK);          //기간 종료일
    initEmEdit(EM_CUST_NM, "GEN^40", NORMAL);       //고객명

    //콤보 초기화
    initComboStyle(LC_O_STRCD, DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              //점(조회)             
    initComboStyle(LC_O_SCH_FLAG, DS_O_SCH_FLAG, "CODE^0^30,NAME^0^80", 1, PK);              //조회구분    
    initComboStyle(LC_O_PROM_TYPE, DS_PROM_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);      //약속유형    
    initComboStyle(LC_CALL_HH,DS_O_CALL_HH, "CODE^0^30,NAME^0^30", 1, PK);        //통화일자 시간
    initComboStyle(LC_CALL_MM,DS_O_CALL_MM, "CODE^0^30,NAME^0^80", 1, PK);        //통화일자 분
    
    //상세 EMEDIT
    initEmEdit(EM_CALL_SEQ_NO_I, "GEN", NORMAL);                     //순번
    initEmEdit(EM_CALL_DT_I, "TODAY", NORMAL);                       //전화통화일자
    initEmEdit(EM_SEND_NM_I, "GEN^20", NORMAL);                         //발신자
    initEmEdit(EM_RECV_NM_I, "GEN^20", PK);                             //수신자
    initTxtAreaEdit(TEXT_CALL_DESC_I, NORMAL);                       //비고    
    //initEmEdit(RD_RESERCH_ITEM_I, "GEN", NORMAL);                    //상품수선만족도
    //initEmEdit(RD_RESERCH_SERVICE_I, "GEN", NORMAL);                 //상품만족도
    
    getStore("DS_O_STR_CD", "Y", "1", "N");            //점코드        
    getEtcCode("DS_O_SCH_FLAG",   "D", "M061", "N");//조회구분
    getEtcCode("DS_PROM_TYPE",   "D", "M021", "Y");//약속유형
    getEtcCode("DS_STR_CD", "D", "M034", "N");    
    getEtcCode("DS_O_CALL_HH",   "D", "M059", "N"); //통화일자 시간
    getEtcCode("DS_O_CALL_MM",   "D", "M060", "N"); //통화일자 분
    
    registerUsingDataset("mpro106","DS_O_MASTER, DS_O_DETAIL");
    
    LC_O_STRCD.Focus();
    
    LC_O_STRCD.Index = 0;
    LC_O_SCH_FLAG.Index = 0
    LC_O_PROM_TYPE.Index = 0
    
    EM_CALL_SEQ_NO_I.Enable = "false";
    EM_CALL_DT_I.Enable = "false";
    LC_CALL_HH.Enable = false;
    LC_CALL_MM.Enable = false;
    enableControl(calan,false);
    EM_SEND_NM_I.Enable = "false";
    EM_RECV_NM_I.Enable = "false";    
    TEXT_CALL_DESC_I.Enable = "false";
    RD_RESERCH_ITEM_I.Enable = "false";
    RD_RESERCH_SERVICE_I.Enable = "false";
    EM_CUST_NM.Language =1;
        
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"             width=30   align=center</FC>'                     
                     + '<FC>id=STR_CD        name="점"             width=80   align=left  </FC>'                                          
                     + '<FC>id=TAKE_DT       name="접수일자"       MASK="XXXX/XX/XX"  width=80   align=center  </FC>'
                     + '<FC>id=TAKE_SEQ      name="SEQ"            width=60   align=center  </FC>'
                     + '<FC>id=TAKE_USER_ID  name="접수자"         width=60   align=left  </FC>'
                     + '<FC>id=PROM_TYPE     name="약속유형"        width=60   align=left  </FC>'
                     + '<FC>id=DELI_TYPE     name="인도유형"        width=60   align=left  </FC>'
                     + '<FC>id=ADDR          name="주소"            width=120   align=left </FC>'
                     + '<FC>id=LAST_PROM_DT  name="최종약속일"     MASK="XXXX/XX/XX"  width=80   align=center   </FC>'                     
                     + '<FC>id=DELI_STR      name="인도점"           width=60   align=left  </FC>'
                     + '<FC>id=CUST_NM       name="고객명"           width=60   align=left  </FC>'
                     + '<FC>id=PHONE         name="전화번호"         width=60   Value={decode(PHONE, "" ,(PHONE1&&"-"&&PHONE2&&"-"&&PHONE3),"")} align=left  </FC>'
                     + '<FC>id=PUMBUN_CD     name="품목코드"         width=60   align=center  </FC>'
                     + '<FC>id=PUMBUN_NAME   name="품목명"           width=60   align=left  </FC>'
                     + '<FC>id=IN_DELI_DT    name="입고예정일"      MASK="XXXX/XX/XX"  width=80   align=center  </FC>'                     
                     + '<FC>id=SKU_NM        name="상품명"    width=80   align=left  </FC>'
                     + '<FC>id=PROM_DTL      name="약속상세"         width=60   align=left  </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center</FC>'
                     + '<FC>id=CALL_DT         name="전화통화일자"     Edit=None width=100 MASK="XXXX/XX/XX" align=center</FC>'                     
                     + '<FC>id=SEND_NM         name="발신자"          Edit=None width=80   align=left</FC>'
                     + '<FC>id=SEQ_NO          name="순번"            Edit=None width=70   align=center</FC>';
                     + '<FC>id=CALL_SEQ_NO     name="전화통화상세순번"            width=80   align=center SHOW=FALSE </FC>';
                     + '<FC>id=EM_CALL_DT      name="통화일자"            width=80  MASK="XXXX/XX/XX" align=center SHOW=FALSE </FC>';
                     + '<FC>id=CALL_HH         name="통화일자시간"           width=80   align=center SHOW=FALSE </FC>'
                     + '<FC>id=CALL_MM         name="통화일자분"          width=80   align=center SHOW=FALSE </FC>'
                     + '<FC>id=EM_SEND_NM      name="발신자"            width=80   align=center SHOW=FALSE </FC>';
                     + '<FC>id=RECV_NM         name="수신자"            width=80   align=center SHOW=FALSE </FC>';                     
                     + '<FC>id=CALL_DESC       name="통화내역"            width=80   align=center SHOW=FALSE </FC>';
                     + '<FC>id=RESERCH_ITEM    name="상품(수선)만족도"  width=80   align=center SHOW=FALSE </FC>';
                     + '<FC>id=RESERCH_SERVICE name="상품만족도"  width=80   align=center SHOW=FALSE </FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
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
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-02-22
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
     
     if( LC_O_STRCD.Text.length == 0 ){
         showMessage(STOPSIGN, OK, "USER-1001", "점");
         LC_O_STRCD.Focus();
         return;
     }
     if( LC_O_SCH_FLAG.Text.length == 0 ){
         showMessage(STOPSIGN, OK, "USER-1001", "조회구분");
         LC_O_SCH_FLAG.Focus();
         return;
     }   
     if( EM_SALE_S_DT.Text.length < 8 ){
         showMessage(STOPSIGN, OK, "USER-1001", "시작일");
         EM_SALE_S_DT.Focus();
         return;
     }
     if( EM_SALE_E_DT.Text.length < 8 ){
         showMessage(STOPSIGN, OK, "USER-1001", "종료일");
         EM_SALE_E_DT.Focus();
         return;
     }
     
    //시작, 종료일 일자체크
     var em_sdate = (trim(EM_SALE_S_DT.Text)).replace(' ','');
     var em_edate = (trim(EM_SALE_E_DT.Text)).replace(' ','');     
     
     if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_SALE_S_DT.Focus();
         return false;
     }     
     if( DS_O_DETAIL.IsUpdated ){
         
    	 if(showMessage(Question, YESNO, "USER-1059") != 1 ){
             
             return;
         }
                         
     }
     DS_O_DETAIL.ClearData();
     getSearch();//조회
     
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     if ( DS_O_MASTER.CountRow > 0) {
         
    	 
    	 if( DS_O_DETAIL.IsUpdated ){
             var ret = showMessage(STOPSIGN, YesNo, "USER-1072");
             if (ret != "1") { 
                 return;
             }else {
            	 DS_O_DETAIL.DeleteRow(DS_O_DETAIL.CountRow);
             }
             
         }
    	 
    	 DS_O_DETAIL.AddRow();
         DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "EM_CALL_DT") = getTodayFormat('YYYYMMDD');
         DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "CALL_DT") = getTodayFormat('YYYYMMDD');
         DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "RECV_NM") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CUST_NM");
         EM_CALL_DT_I.Enable = true;
         enableControl(calan,true);
         LC_CALL_HH.Enable = true;
         LC_CALL_MM.Enable = true;
         EM_SEND_NM_I.Enable = "true";
         EM_RECV_NM_I.Enable = "true";             
         TEXT_CALL_DESC_I.Enable = "true";
         RD_RESERCH_ITEM_I.Enable = "true";
         RD_RESERCH_SERVICE_I.Enable = "true";
         LC_CALL_HH.Index = 0;
         LC_CALL_MM.Index = 0;
         RD_RESERCH_ITEM_I.CodeValue = "1";
         RD_RESERCH_SERVICE_I.CodeValue = "1";
         EM_SEND_NM_I.Focus();
                 
     } else {
         showMessage(STOPSIGN, OK, "USER-1013");
     }    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

     
	// 삭제할 데이터 없는 경우
    if (DS_O_DETAIL.CountRow == 0){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
	
    if(showMessage(Question, YESNO, "USER-1023") != 1)
       return; 
     
     
    
     if( DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "SEND_NM").length == 0 
             && DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "SEQ_NO").length == 0 )
     {//신규에 통화일자 없을 경우
         DS_O_DETAIL.DeleteRow(DS_O_DETAIL.RowPosition);
         return false;
     }
     
     
     var strCallDt = DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "CALL_DT");//통화일자
     var strSeqNo = DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition, "SEQ_NO");//순번
     DS_O_DETAIL.UserStatus(DS_O_DETAIL.RowPosition)= 2;
     
     var parameters =   "&strCalDt=" + encodeURIComponent(strCallDt)
                      + "&strSeqNo=" + encodeURIComponent(strSeqNo);
     
     TR_MAIN.Action="/mss/mpro106.mp?goTo=save&strFlg=delete"+parameters; 
     TR_MAIN.KeyValue="SERVLET(I:DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_MAIN.Post();
     
     
     //getSearch();
     var row = DS_O_MASTER.RowPosition;
     getCallDetail2(row);
        
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     	      
     if ( !DS_O_DETAIL.IsUpdated ) {//변경 데이터가 있을때만 저장
         
         showMessage(INFORMATION, OK, "USER-1028");
         return;
         
     }else {
    	 
    	 if (!VailCheck()) return;
    	 
    	 if (showMessage(STOPSIGN, YESNO, "USER-1010") != 1) return;
    	 
         var strTakeDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_DT");//접수일자
         var strTakeSeq = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_SEQ");//접수일자
         var strCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STRCD");//접수일자
            
         var goTo = "save";         
         var parameters =   "&strTakeDt="  + encodeURIComponent(strTakeDt)
                          + "&strTakeSeq=" + encodeURIComponent(strTakeSeq)
                          + "&strCd="      + encodeURIComponent(strCd);
         
         TR_MAIN.Action = "/mss/mpro106.mp?strFlg=save&goTo=" + goTo + parameters;
         TR_MAIN.KeyValue = "SERVLET(I:DS_O_DETAIL=DS_O_DETAIL)";
         TR_MAIN.Post();
          
         getCallDetail2(DS_O_MASTER.RowPosition);
             
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
 
 function getSearch(){
                
      //필수입력값 체크
      //if (!checkValidate()) return;
      
      var strCd = LC_O_STRCD.BindColVal;
      var strSchFlag  = LC_O_SCH_FLAG.BindColVal;// 조회구분
      var sDate = EM_SALE_S_DT.Text;
      var eDate = EM_SALE_E_DT.Text;
      var custNm = EM_CUST_NM.Text;      
      var promType =  LC_O_PROM_TYPE.BindColVal;
      
      
      
      var goTo = "getMaster"
      var parameters = "&strCd="  + encodeURIComponent(strCd)
                 + "&strSchFlag=" + encodeURIComponent(strSchFlag)
                 + "&sDate="      + encodeURIComponent(sDate)
                 + "&eDate="      + encodeURIComponent(eDate)                          
                 + "&promType="   + encodeURIComponent(promType);
      
      TR_MAIN.Action = "/mss/mpro106.mp?goTo=" + goTo + parameters + "&custNm=" + encodeURIComponent(custNm);
      TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
      TR_MAIN.Post();
      
      if( DS_O_MASTER.CountRow  < 1 ){
    	  setPorcCount("SELECT", DS_O_MASTER.CountRow);          
          enableControl(calan,false);
          LC_CALL_HH.Enable = false;
          LC_CALL_MM.Enable = false;
          EM_SEND_NM_I.Enable = "false";
          EM_RECV_NM_I.Enable = "false";          
          TEXT_CALL_DESC_I.Enable = "false";
          return;
      }else {
               
          getCallDetail();
                
      }
      setPorcCount("SELECT", GD_MASTER);
      
}

function getCallDetail(){
	
	var takeSeq = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_SEQ");
    var strCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STRCD");
    var takeDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TAKE_DT");
    
    var goTo = "getDetail"
    var parameters =   "&takeSeq=" + encodeURIComponent(takeSeq)
                    +  "&strCd="   + encodeURIComponent(strCd)
                    +  "&takeDt="  + encodeURIComponent(takeDt);
    
    TR_MAIN.Action = "/mss/mpro106.mp?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)";//조회:O 입력:I
    TR_MAIN.Post();
    
    if( DS_O_DETAIL.CountRow < 1 ){        
        setPorcCount("SELECT", DS_O_DETAIL.CountRow);
        LC_CALL_HH.Enable = false;
        LC_CALL_MM.Enable = false;
        EM_SEND_NM_I.Enable = "false";
        EM_RECV_NM_I.Enable = "false";          
        TEXT_CALL_DESC_I.Enable = "false";
        RD_RESERCH_ITEM_I.Enable = "false";
        RD_RESERCH_SERVICE_I.Enable = "false";
        return;
    }
    
    RD_RESERCH_ITEM_I.Enable = "true";
    RD_RESERCH_SERVICE_I.Enable = "true";
    setPorcCount("SELECT", DS_O_DETAIL.CountRow);
}

function getCallDetail2(row){
    
    var takeSeq = DS_O_MASTER.NameValue(row, "TAKE_SEQ");
    var strCd = DS_O_MASTER.NameValue(row, "STRCD");
    var takeDt = DS_O_MASTER.NameValue(row, "TAKE_DT");
    
    var goTo = "getDetail"
    var parameters =   "&takeSeq=" + encodeURIComponent(takeSeq)
                    +  "&strCd="   + encodeURIComponent(strCd)
                    +  "&takeDt="  + encodeURIComponent(takeDt);
    
    TR_S_MAIN.Action = "/mss/mpro106.mp?goTo=" + goTo + parameters;
    TR_S_MAIN.KeyValue = "SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)";//조회:O 입력:I
    TR_S_MAIN.Post();
    
    if( DS_O_DETAIL.CountRow < 1 ){        
        setPorcCount("SELECT", DS_O_DETAIL.CountRow);
        LC_CALL_HH.Enable = false;
        LC_CALL_MM.Enable = false;
        EM_SEND_NM_I.Enable = "false";
        EM_RECV_NM_I.Enable = "false";          
        TEXT_CALL_DESC_I.Enable = "false";
        RD_RESERCH_ITEM_I.Enable = "false";
        RD_RESERCH_SERVICE_I.Enable = "false";
        return;
    }
    RD_RESERCH_ITEM_I.Enable = "true";
    RD_RESERCH_SERVICE_I.Enable = "true";
    setPorcCount("SELECT", DS_O_DETAIL.CountRow);
}

/**
 * VailCheck()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-03
 * 개    요 : 빈값 체크
 * return값 : true / false 
*/
function VailCheck(){
    
	for( i = 1; i <= DS_O_DETAIL.CountRow; i++ ){
			
		if (DS_O_DETAIL.RowStatus(i) == 1 || DS_O_DETAIL.RowStatus(i) == 3) {
			
			/* 통화일자시간  */
		    if( DS_O_DETAIL.NameValue(i, "CALL_HH") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "통화일자시간");
                DS_O_DETAIL.RowPosition = i;
                LC_CALL_HH.Focus();
                return false;
            }
		    
		    /* 통화일자분 */
		    if( DS_O_DETAIL.NameValue(i, "CALL_MM") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "통화일자분");
                DS_O_DETAIL.RowPosition = i;
                LC_CALL_MM.Focus();
                return false;
            }
		    
		    /* 발신자 */
		    if( DS_O_DETAIL.NameValue(i, "EM_SEND_NM") == "" ){
		    	showMessage(STOPSIGN, OK, "USER-1003", "발신자");
		    	DS_O_DETAIL.RowPosition = i;
		    	EM_SEND_NM_I.Focus();
		    	return false;
		    }
		    
		    /* 수신자 */
		    if( DS_O_DETAIL.NameValue(i, "RECV_NM") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "수신자");
                DS_O_DETAIL.RowPosition = i;
                EM_RECV_NM_I.Focus();
                return false;
            }
		    
		    /* 통화내역 */
		    if( DS_O_DETAIL.NameValue(i, "CALL_DESC") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "통화내역");
                DS_O_DETAIL.RowPosition = i;
                TEXT_CALL_DESC_I.Focus();
                return false;
            }
		}
	}
    return true;
}

function onlyChar(event){
	if((event.keyCode > 48 ) && (event.keyCode < 57)){
		event.returnValue=false;
	}
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

<!--------------------- 2. TR Fail 메세지 처리  ----------------------------- -->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ----------------------------- -->
<script language=JavaScript for=TR_S_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_S_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_S_MAIN.ErrorMsg);
    for(i=1;i<TR_S_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_S_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(Row)>
//마스터 row변경 전
if (DS_O_MASTER.CountRow > 0) {
    //마스터 선택 시 상세조회(선택 Row) 미사용
    if (DS_O_DETAIL.IsUpdated) {//마스터 컬럼변경전 변경데이터 있을 시 이동할것인지 확인
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


<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>

     if(clickSORT) return;
                    
     if(DS_O_DETAIL.NameValue(row, "CALL_DT") == "" && DS_O_DETAIL.NameValue(row, "SEND_NM") == ""
             && DS_O_DETAIL.NameValue(row, "SEND_NM") == "" ){
         enableControl(calan,true);
         LC_CALL_HH.Enable = true;
         LC_CALL_MM.Enable = true;
         EM_SEND_NM_I.Enable = "true";
         EM_RECV_NM_I.Enable = "true";         
         TEXT_CALL_DESC_I.Enable = "true";    
     }else {
         enableControl(calan,false);
         LC_CALL_HH.Enable = false;
         LC_CALL_MM.Enable = false;
         EM_SEND_NM_I.Enable = "true";
         EM_RECV_NM_I.Enable = "true";         
         TEXT_CALL_DESC_I.Enable = "true";
     }

</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    
    if(clickSORT) return;
    
    if( row > 0 ){
        getCallDetail2(row);    	
    }else {
        DS_O_DETAIL.ClearData();
    }

</script>

<!--  GD_MASTER 소팅 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    
    if( row < 1 ){
        sortColId( eval(this.DataID), row, colid);
    }
</script>


<!--  GD_MASTER 소팅 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);   
</script>

<script language=JavaScript for=EM_SALE_S_DT event=onKillFocus()>
    //[조회용]시작일 체크
   
    checkDateTypeYMD( EM_SALE_S_DT );

</script>

<script language=JavaScript for=EM_SALE_E_DT event=onKillFocus()>
    //[조회용]종료일 체크
    checkDateTypeYMD( EM_SALE_E_DT );
</script>
<!--  
<script language=JavaScript for=EM_CUST_NM event=onChar(char)>
     if (( char   >= 32) && (char   <= 126)){	  
		  alert("한글만 입력");
		  char = 0;		  
		  return;
	 }
</script>
 
<script language=JavaScript for=EM_CUST_NM event=onKeyDown(kcode,scode)>
//alert(kcode);
var kk = EM_CUST_NM.Text;

    if( kcode < 47 || kcode > 58 ){
    	
    	alert(kk.length);
    	
    }

</script>
--> 

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input 검색용 -->
<comment id="_NSID_"><object id="DS_PUMBUN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SCH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PROM_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CALL_HH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CALL_MM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="80" class="POINT">점</th>
                <td width="140">
                      <comment id="_NSID_" >
                          <object id=LC_O_STRCD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80" class="POINT">조회구분</th>
                <td width="140">
                      <comment id="_NSID_">
                          <object id=LC_O_SCH_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80" class="POINT">기간</th>
                <td>
                          <comment id="_NSID_">
                              <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
                              </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_S_DT);" align="absmiddle"/>
                          ~
                          <comment id="_NSID_">
                              <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
                              </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_E_DT);" align="absmiddle"/>
                </td>
            </tr>
            <tr>
                <th width="80">고객명</th>
                <td width="140">
                      <comment id="_NSID_">
                             <object id=EM_CUST_NM classid=<%= Util.CLSID_EMEDIT %>  width=140  tabindex=1  align="absmiddle" 
                               onkeydown="javascript:onlyChar(event);"
                               onkeypress="javascript:onlyChar(event);"
                               onkeyup="javascript:onlyChar(event);"  >
                             </object>
                       </comment>
                          <script> _ws_(_NSID_);</script>
                </td>                
                <th width="80">약속유형</th>
                <td colspan="3">
                      <comment id="_NSID_">
                          <object id=LC_O_PROM_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr> 
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr>
            <td width="100%">
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=285 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                <param name="DataID" value="DS_O_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td height="5" ></td>
  </tr> 
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr valign="top">
  </tr>
  
  <tr>
    <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 해피콜리스트</td>
                <td class="sub_title">&nbsp;<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>해피콜 상세</td>
            </tr>
            <tr valign="top">
                <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr>
                        <td width="100%">
                            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=167 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                                <param name="DataID" value="DS_O_DETAIL">
                            </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
              </td>
                <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                            <tr>
                                <th width="90">순번</th>
                                <td width="100">
                                      <comment id="_NSID_">
                                          <object id=EM_CALL_SEQ_NO_I  classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th width="70">전화통화일자</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_CALL_DT_I  classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_CALL_DT_I)" id="calan" align="absmiddle"/>
                                      <comment id="_NSID_">
                                          <object id=LC_CALL_HH name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=50 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                      <comment id="_NSID_">
                                          <object id=LC_CALL_MM name="CONTENTS" classid=<%= Util.CLSID_LUXECOMBO %> width=50 tabindex=1 align="absmiddle">
                                          </object>
                                      </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th class="POINT" width="90">발신자</th>
                                <td width="100">
                                      <comment id="_NSID_">
                                          <object id=EM_SEND_NM_I  classid=<%=Util.CLSID_EMEDIT%>  width=100 tabindex=1 onKeyup="javascript:checkByteStr(this, 40, 'Y');" align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                                <th class="POINT" width="70">수신자</th>
                                <td>
                                      <comment id="_NSID_">
                                          <object id=EM_RECV_NM_I   classid=<%=Util.CLSID_EMEDIT%>  width=205 tabindex=1 onKeyup="javascript:checkByteStr(this, 40, 'Y');" align="absmiddle">
                                          </object>
                                      </comment>
                                      <script> _ws_(_NSID_);</script>
                                </td>
                            </tr>                            
                            <tr>
                                <th class="POINT" width="90">통화내역</th>
                                <td colspan="3" class="PT02 PB02">
                                    <comment id="_NSID_"> 
                                        <object id=TEXT_CALL_DESC_I   classid=<%=Util.CLSID_TEXTAREA%> height=50 tabindex=1 width=400
                                         tabindex=1 align="absmiddle" maxLength="200" 
                                         onkeyup="javascript:textAreaMaxlength(TEXT_CALL_DESC_I, 200);"
                                         onkeyDown="javascript:textAreaMaxlength(TEXT_CALL_DESC_I, 200);"
                                         onkeyPress ="javascript:textAreaMaxlength(TEXT_CALL_DESC_I, 200);" 
                                         > 
                                        </object> 
                                    </comment>
                                    <script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="90">상품(수선)만족도</th>
                                <td colspan="3">
                                    <comment id="_NSID_">
                                        <object id=RD_RESERCH_ITEM_I classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:30; width:400">
                                        <param name=Cols    value="5">                                        
                                        <param name=Format  value="1^매우만족,2^만족,3^보통,4^불만족,5^매우불만족">
                                        <param name=CodeValue  value="1">
                                        </object>  
                                    </comment>
                                    <script> _ws_(_NSID_);</script> 
                                </td>
                            </tr>
                            <tr>
                                <th width="90">서비스 만족도</th>
                                <td colspan="3">
                                    <comment id="_NSID_">
                                        <object id=RD_RESERCH_SERVICE_I classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:30; width:400">
                                        <param name=Cols    value="5">          
                                        <param name=Format  value="1^매우만족,2^만족,3^보통,4^불만족,5^매우불만족">
                                        <param name=CodeValue  value="1">
                                        </object>  
                                    </comment>
                                    <script> _ws_(_NSID_);</script> 
                                </td>
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
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_"> <object id=BO_IO_DETAIL
    classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=CALL_SEQ_NO        Ctrl=EM_CALL_SEQ_NO_I          param=Text</c>
        <c>Col=EM_CALL_DT         Ctrl=EM_CALL_DT_I              param=Text</c>
        <c>Col=CALL_HH            Ctrl=LC_CALL_HH                param=BindColVal</c>
        <c>Col=CALL_MM            Ctrl=LC_CALL_MM                param=BindColVal</c>
        <c>Col=EM_SEND_NM         Ctrl=EM_SEND_NM_I              param=Text</c>
        <c>Col=RECV_NM            Ctrl=EM_RECV_NM_I              param=Text</c>
        <c>Col=CALL_DESC          Ctrl=TEXT_CALL_DESC_I          param=Text</c>
        <c>Col=RESERCH_ITEM       Ctrl=RD_RESERCH_ITEM_I         param=CodeValue</c>
        <c>Col=RESERCH_SERVICE    Ctrl=RD_RESERCH_SERVICE_I      param=CodeValue</c>        
        '>        
</object> </comment><script>_ws_(_NSID_);</script></div><body>

</body>
</html>

