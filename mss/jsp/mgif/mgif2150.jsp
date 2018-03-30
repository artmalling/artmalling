<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 위탁출고 등록
 * 작 성 일 : 2011.01.24
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.24 (김슬기) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

//디테일 조회 두번 막기 위해 
var old_Row = 0;
var btnClickSave = false;
var strToday   ;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 //기간 : 시작
    initEmEdit(EM_E_DT, "TODAY", PK);                 //기간 : 종료
    initEmEdit(EM_S_VEN_CD, "NUMBER3^6", NORMAL);             //협력사코드
    initEmEdit(EM_S_VEN_NM, "GEN", READ);                     //협력사명
    //입력부
    initEmEdit(EM_I_VEN_CD, "NUMBER3^6", PK);             //입력협력사코드
    initEmEdit(EM_I_VEN_NM, "GEN", READ);                     //입력협력사명
    initEmEdit(EM_I_DT, "TODAY", PK);                     //출고일자
    initEmEdit(EM_I_QTY, "NUMBER^9^0", READ);             //총수량
    initEmEdit(EM_I_AMT, "NUMBER^12^0", READ);             //총금액
    initEmEdit(EM_GIFT_S_NO, "NUMBER3^18", NORMAL);           //시작 번호
    initEmEdit(EM_GIFT_E_NO, "NUMBER3^18", NORMAL);         //종료번호
    
    //콤보 초기화
    initComboStyle(LC_S_STR,DS_S_STR, "CODE^0^30,NAME^0^80", 1, PK);                      //점(조회)
    initComboStyle(LC_I_STR,DS_I_STR, "CODE^0^30,NAME^0^80", 1, PK);                      //점(조회)
    
    getStore("DS_S_STR", "N", "", "N");
    getStore("DS_I_STR", "N", "", "N");
    
    DS_S_STR.Filter();     //점구분 : 본사점만 셋팅
    DS_I_STR.Filter();     //점구분 : 본사점만 셋팅
    
    LC_S_STR.Index = 0;
    LC_I_STR.Index = 0;
    LC_I_GB.Index = 0;
    
    strToday   = getTodayDB("DS_O_RESULT");
    
    setObject(false);
    
    LC_S_STR.Focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif215", "DS_IO_MASTER,DS_IO_DETAIL"); 
 }

function gridCreate(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=OUT_DT      name="출고일"     width=80   align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=STAT_FLAG_NM    name="출고구분"     width=80   align=left</FC>'
                     + '<FC>id=OUT_SLIP_NO    name="순번"       width=60  align=center</FC>'
                     + '<FC>id=VEN_NAME    name="위탁협력사"     width=120   align=left</FC>'
                     + '<FC>id=OUT_AMT    name="금액"     width=100   align=right</FC>'
                     
                     ;
                     
                     
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
        + '<FC>id=GIFT_AMT_NAME    name="금종명"      width=100  align=left sumtext="합계"</FC>'
        + '<FC>id=GIFTCERT_AMT    name="상품권금액"      width=80  align=right</FC>'
        + '<FC>id=GIFT_S_NO    name="시작번호"      width=120  align=center</FC>'
        + '<FC>id=GIFT_E_NO    name="종료번호"      width=120  align=center</FC>'
        + '<FC>id=OUT_QTY    name="수량"      width=50  align=right sumtext=@sum</FC>'
        + '<FC>id=OUT_AMT    name="금액"      width=100  align=right sumtext=@sum</FC>';
       
        initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
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
	if(DS_IO_DETAIL.IsUpdated){
        if(showMessage(QUESTION , YESNO, "USER-1072") != 1 ){
            return;
        }
   }
	
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;     //본사점
    var strOutDtFrom          = EM_S_DT.Text;     //기간 from
    var strOutDtTo          = EM_E_DT.Text;       //기간 to
    var strVenCd        = EM_S_VEN_CD.Text;     //위탁협력사
    var strOutGb        = LC_S_GB.BindColVal;     //출고구분
    
    
    if(strStrCd.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_S_STR.BindColVal.focus();
        return;
    }
    
    if(strOutDtFrom.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "조회기간[FROM]");
        EM_S_DT.focus();
        return;
    }
    
    if(strOutDtTo.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "조회기간[TO]");
        EM_E_DT.focus();
        return;
    }
    
    if(strOutDtFrom > strOutDtTo) {
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    
    //데이타 셋 클리어
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
  
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strOutDtFrom="+ encodeURIComponent(strOutDtFrom)
                   + "&strOutDtTo="  + encodeURIComponent(strOutDtTo)
                   + "&strVenCd="    + encodeURIComponent(strVenCd)
                   + "&strOutGb="    + encodeURIComponent(strOutGb)
                   ;
    
    TR_MAIN.Action="/mss/mgif215.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if (DS_IO_MASTER.CountRow != 0) { 
        setObject(false);
    } else {
    	LC_I_STR.Index = 0;
    	LC_I_GB.Index = 0;
    	EM_I_DT.Text = strToday;
    }
    
    old_Row = 1;
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 
	if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"OUT_SLIP_NO") == ""){
        if(showMessage(QUESTION , YESNO, "USER-1072") != 1 ){
            return;
        }else{
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
            }
    }
	 
	  DS_IO_MASTER.AddRow();
	  LC_I_STR.Index = 0;
	  LC_I_GB.Index = 0;
      //DS_IO_MASTER.ClearData();
      DS_IO_DETAIL.ClearData();
      
      EM_I_DT.Text = strToday;
      EM_I_VEN_CD.Text = "";
      EM_I_VEN_NM.Text = "";
      EM_GIFT_S_NO.Text = "";
      EM_GIFT_E_NO.Text = "";   
      CHK_SINGLE.checked = false;
      EM_I_VEN_CD.Focus();
      setObject(true);
     
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated) {
    	showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    if (DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    
    if(EM_I_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "출고일자");
        EM_I_DT.Focus();
        return false;
    }
    
    if(EM_I_VEN_CD.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "위탁협력사");
        EM_I_VEN_CD.Focus();
        return false;
    }
    
    if(EM_I_DT.Text < strToday){
        showMessage(EXCLAMATION , OK, "USER-1000", "출고일자는 오늘 이후로 선택하셔야합니다.");
        EM_I_DT.Focus();
        return;
    }
   
    //저장 
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    btnClickSave = true;
    
    var strTotalAmt = 0;
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
    	strTotalAmt = strTotalAmt + DS_IO_DETAIL.NameValue(i,"OUT_AMT");     
    }
    
    var parameters = "&strStrCd="   + encodeURIComponent(LC_I_STR.BindColVal)
                   + "&strOutDt="   + encodeURIComponent(EM_I_DT.Text)
                   + "&strTotalAmt="+ encodeURIComponent(strTotalAmt)
                   + "&strOutGb="   + encodeURIComponent(LC_I_GB.BindColVal)
                   + "&strVenCd="   + encodeURIComponent(EM_I_VEN_CD.Text)
                   ;
    
    TR_MAIN.Action="/mss/mgif215.mg?goTo=save"+parameters; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
                                
    TR_MAIN.Post();
    btnClickSave = false;
   
    DS_IO_CONF_S.ClearData();
    
    btn_Search();
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
  * getVenCd()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-06
  * 개    요 : 가맹점 팝업 오픈시 점코드 필수
  * return값 : void
  */
 function getVenCd(gubun){
	if (gubun == "1"){
		if(LC_S_STR.BindColVal == "%" || LC_S_STR.BindColVal == "" ){
	       showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
	       LC_S_STR.Focus();
	       return;
	    }
	    getMssEvtVenPop( EM_S_VEN_CD, EM_S_VEN_NM, 'S', '3', '', LC_S_STR.BindColVal, '', 'Y');
	} else {
		if(LC_I_STR.BindColVal == "%" || LC_I_STR.BindColVal == "" ){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_I_STR.Focus();
            return;
        }
     getMssEvtVenPop( EM_I_VEN_CD, EM_I_VEN_NM, 'S', '3', '', LC_I_STR.BindColVal, '', 'Y');
		
	}
 }

 /**
  * getDetail()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-18
  * 개    요 : 하단 상세 조회
  * return값 : void
  */
 function getDetail () {
   var row = DS_IO_MASTER.RowPosition;
   
   var strStatFlag = DS_IO_MASTER.NameValue(row, "STAT_FLAG");
    var strStrCd = DS_IO_MASTER.NameValue(row, "OUT_STR");
    var strOutDt = DS_IO_MASTER.NameValue(row, "OUT_DT");
    var strOutSlipNo = DS_IO_MASTER.NameValue(row, "OUT_SLIP_NO");
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
                    + "&strOutDt="     + encodeURIComponent(strOutDt)
                    + "&strOutSlipNo=" + encodeURIComponent(strOutSlipNo)
                    + "&strStatFlag="  + encodeURIComponent(strStatFlag)
                    ;
    
    TR_DETAIL.Action="/mss/mgif215.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
        
 }
 
 /**
  * onSingle()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 : 한장씩 판매 등록
  * return값 : void
  */ 
 function onSingle(){
     if(CHK_SINGLE.checked){
         EM_GIFT_S_NO.Text = "";
         EM_GIFT_S_NO.Enable = false;
     }else{
         EM_GIFT_E_NO.Text = "";
         EM_GIFT_S_NO.Enable = true;
     }
 }
 
 
 /**
  * getConf()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-26
  * 개    요 : 시작번호 조회
  * return값 : void
  */
 function getConf (strFlag) {
    var strGiftNo = strFlag.Text;
    DS_IO_CONF_S.ClearData();

    var strOutdDt = EM_I_DT.Text;
    var strVenCd = EM_I_VEN_CD.Text;
    var strStrCd = LC_I_STR.BindColVal;
    var strOutGb = LC_I_GB.BindColVal;     //출고구분
    var strOutDt = EM_I_DT.Text;           // 출고일자 
    
    var goTo       = "getConf" ;    
    var action     = "O";     
    
    //조회조건 
    var strGiftNo = strGiftNo;
    
    var parameters = "&strGiftNo="  + encodeURIComponent(strGiftNo)
                     + "&strStrCd=" + encodeURIComponent(strStrCd)
                     + "&strVenCd=" + encodeURIComponent(strVenCd)
                     + "&strOutGb=" + encodeURIComponent(strOutGb)
                     + "&strOutDt=" + encodeURIComponent(strOutDt)
                     
    ;
    
    TR_MAIN.Action="/mss/mgif215.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CONF_S=DS_IO_CONF_S)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_IO_CONF_S.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1000", "유효하지 않은 상품권 번호입니다.");
        if(strFlag.id == "EM_GIFT_S_NO"){
            EM_GIFT_S_NO.Text = "";
            setTimeout("EM_GIFT_S_NO.Focus();",100);
        }else{
            EM_GIFT_E_NO.Text = "";
            setTimeout("EM_GIFT_E_NO.Focus();",100);
        }
        
        return;
    }
    
    if(strFlag.id == "EM_GIFT_S_NO"){
        EM_GIFT_S_NO.Enable = false;
        DS_IO_DETAIL.AddRow();
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_TYPE_CD") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_CD");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "ISSUE_TYPE") = DS_IO_CONF_S.NameValue(1,"ISSUE_TYPE");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_AMT_TYPE") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_TYPE");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_AMT_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_NAME");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFTCERT_AMT") = DS_IO_CONF_S.NameValue(1,"GIFTCERT_AMT");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_S_NO") = strGiftNo;
        
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_STR") = LC_I_STR.BindColVal;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_DT") = EM_I_DT.Text;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "VEN_CD") = EM_I_VEN_CD.Text;
        
       
    }else{
        if(!CHK_SINGLE.checked){
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_E_NO") = strGiftNo;
        } else {
            DS_IO_DETAIL.AddRow();
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_TYPE_CD") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_CD");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "ISSUE_TYPE") = DS_IO_CONF_S.NameValue(1,"ISSUE_TYPE");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_AMT_TYPE") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_TYPE");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_AMT_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_NAME");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFTCERT_AMT") = DS_IO_CONF_S.NameValue(1,"GIFTCERT_AMT");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_S_NO") = strGiftNo;
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_E_NO") = strGiftNo;
            
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_STR") = LC_I_STR.BindColVal;
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_DT") = EM_I_DT.Text;
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "VEN_CD") = EM_I_VEN_CD.Text;
        }
        
        var parameters = "&strSGiftNo=" + encodeURIComponent(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_S_NO"))
                       + "&strEGiftNo=" + encodeURIComponent(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_E_NO"))
                       + "&strOutGb="   + encodeURIComponent(strOutGb)
                       + "&strStrCd="   + encodeURIComponent(strStrCd)
                       + "&strVenCd="   + encodeURIComponent(strVenCd)
                       + "&strOutDt="   + encodeURIComponent(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_DT"))   
                       ;
        TR_MAIN.Action="/mss/mgif215.mg?goTo=getCnt"+parameters;  
        TR_MAIN.KeyValue="SERVLET(O:DS_IO_CONF_CNT=DS_IO_CONF_CNT)"; //조회는 O
        TR_MAIN.Post();
        
        if(DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT") == 0){
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권 번호를 확인하세요.");
            EM_GIFT_E_NO.Text = "";
           setTimeout("EM_GIFT_E_NO.Focus();",100);
           return;
        }
        
        if(DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT") != DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_ALL_CNT")){
            showMessage(STOPSIGN, OK, "USER-1000", "연속되지 않는 상품권 번호 입니다.");
            EM_GIFT_E_NO.Text = "";
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_E_NO") = "";
            setTimeout("EM_GIFT_E_NO.Focus();",100);
            return;
        }
        
      //시작번호 초기화
        if(!CHK_SINGLE.checked){
            EM_GIFT_S_NO.Enable = true;
            EM_GIFT_E_NO.Enable = true;
            EM_GIFT_S_NO.Text = "";
            EM_GIFT_E_NO.Text = "";
            
        } else {
            EM_GIFT_S_NO.Enable = false;
            EM_GIFT_E_NO.Enable = true;
            EM_GIFT_S_NO.Text = "";
            EM_GIFT_E_NO.Text = "";
            
        }
        
        //수량 금액 셋팅
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_QTY") = DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT");
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_AMT") = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "OUT_QTY") * DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFTCERT_AMT");
      }
      
    enableControl(IMG_CAL, false);
    enableControl(IMG_VEN, false);
    enableControl(IMG_DELROW, true);
    
    LC_I_GB.Enable = false;
    LC_I_STR.Enable = false;
    EM_I_VEN_CD.Enable = false;
    EM_I_DT.Enable = false;
    
 }

 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-26
  * 개    요 : 행삭제
  * return값 : void
  */
 function delRow(){
	  
	 if(DS_IO_DETAIL.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }
	  
     DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.CountRow);
     
     EM_GIFT_S_NO.Text = "";
     EM_GIFT_E_NO.Text = "";
     EM_GIFT_S_NO.Enable = true;
     EM_GIFT_E_NO.Enable = true;
     EM_GIFT_S_NO.Focus();
 } 

 /**
  * setObject()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-26
  * 개    요 : 화면 체크 
  * return값 : void
  */
 function setObject(flag){
	    enableControl(IMG_CAL, flag);
	    enableControl(IMG_VEN, flag);
	    enableControl(IMG_DELROW, flag);
	    
	    LC_I_STR.Enable = flag;
	    EM_I_VEN_CD.Enable = flag;
	    EM_I_DT.Enable = flag;
	    EM_GIFT_S_NO.Enable = flag;
	    EM_GIFT_S_NO.Enable = flag;
	    EM_GIFT_E_NO.Enable = flag;
	    LC_I_GB.Enable = flag;
	    
	    if(flag){      
	       if (DS_IO_MASTER.CountRow == 0 ) {
		       EM_I_DT.Text = strToday; 
		       LC_I_STR.Index = 0;
		       LC_I_GB.Index = 0;
	       }    
	       CHK_SINGLE.disabled = false;
	    } else {
	       
	       CHK_SINGLE.disabled = true;
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 <script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_S_VEN_NM.Text = "";
        return;
    }

 if(this.Text.length > 0){
        if(LC_S_STR.BindColVal == ""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점코드");
            setTimeout("LC_S_STR.Focus();",50);
            return;
        }
        getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "3", '', LC_S_STR.BindColVal, '', 'Y');
    }
</script>

<script language=JavaScript for=LC_S_STR event=OnSelChange()>
 EM_S_VEN_CD.Text = "";
 EM_S_VEN_NM.Text = "";
</script>

<script language=JavaScript for=EM_I_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_I_VEN_NM.Text = "";
        return;
    }

 if(this.Text.length > 0){
        if(LC_I_STR.BindColVal == ""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점코드");
            setTimeout("LC_I_STR.Focus();",50);
            return;
        }
        getMssEvtVenNonPop( "DS_O_RESULT", EM_I_VEN_CD, EM_I_VEN_NM, "E", "Y", "3", '', LC_I_STR.BindColVal, '', 'Y');
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<script language=JavaScript for=EM_GIFT_S_NO event=onKillFocus()>
if(!this.Modified)
    return;
if( EM_GIFT_S_NO.Text ==""){
       return;
   }
  
if(LC_I_STR.BindColVal == "%" || LC_I_STR.BindColVal == "" ){
    showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
    EM_GIFT_S_NO.Text ="";
    LC_I_STR.Focus();
    return;
}

if(EM_I_VEN_CD.Text == ""){
    showMessage(EXCLAMATION, OK, "USER-1002", "위탁협력사");
    EM_GIFT_S_NO.Text = "";
    EM_I_VEN_CD.Focus();
    return ;
}

if(EM_I_DT.Text == ""){
    showMessage(EXCLAMATION, OK, "USER-1002", "출고일자");
    EM_GIFT_S_NO.Text = "";
    EM_I_DT.Focus();
    return false;
}
/*
if(EM_I_DT.Text < strToday){
    showMessage(EXCLAMATION , OK, "USER-1000", "출고일자는 오늘 이후로 선택하셔야합니다.");
    EM_GIFT_S_NO.Text ="";
    EM_I_DT.Focus();
    return;
}*/

if(EM_GIFT_S_NO.Text.length == 13 || EM_GIFT_S_NO.Text.length == 16 || EM_GIFT_S_NO.Text.length == 18){
    for(var i=1;i<=DS_IO_CONF.CountRow;i++){
        if( DS_IO_DETAIL.NameValue(i,"GIFT_S_NO")<=EM_GIFT_S_NO.Text &&  EM_GIFT_S_NO.Text <=DS_IO_DETAIL.NameValue(i,"GIFT_E_NO")) {
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호가 중복됩니다.");
            this.Text = "";
            setTimeout("EM_GIFT_S_NO.Focus();",100);
            return;
        }
    }
    //하단 확정 내역 조회 
    getConf(this);
}
</script>
<script language=JavaScript for=EM_GIFT_E_NO event=onKillFocus()>
if(!this.Modified)
    return;
if( EM_GIFT_E_NO.Text ==""){
       return;
   }
if(EM_GIFT_E_NO.Text.length == 13 || EM_GIFT_E_NO.Text.length == 16 || EM_GIFT_E_NO.Text.length == 18){
    //개별 등록 일경우는 그냥 추가 
    if(!CHK_SINGLE.checked){
        if(EM_GIFT_S_NO.Text == ""){
            showMessage(EXCLAMATION , OK, "USER-1000", "시작번호를 먼저 스캔해 주세요.");
            this.Text = "";
            setTimeout("EM_GIFT_S_NO.Focus();",100);
            return;
        }
        if(EM_GIFT_E_NO.Text < EM_GIFT_S_NO.Text){
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호를 확인해 주세요.");
            this.Text = "";
            setTimeout("EM_GIFT_E_NO.Focus();",100);
            return;
        }
    } else {
    	if(LC_I_STR.BindColVal == "%" || LC_I_STR.BindColVal == "" ){
    	    showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
    	    EM_GIFT_E_NO.Text ="";
    	    LC_I_STR.Focus();
    	    return;
    	}

    	if(EM_I_VEN_CD.Text == ""){
    	    showMessage(EXCLAMATION, OK, "USER-1002", "위탁협력사");
    	    EM_GIFT_E_NO.Text = "";
    	    EM_I_VEN_CD.Focus();
    	    return ;
    	}

    	if(EM_I_DT.Text == ""){
    	    showMessage(EXCLAMATION, OK, "USER-1002", "출고일자");
    	    EM_GIFT_E_NO.Text = "";
    	    EM_I_DT.Focus();
    	    return false;
    	}
    	/*
    	if(EM_I_DT.Text < strToday){
    	    showMessage(EXCLAMATION , OK, "USER-1000", "출고일자는 오늘 이후로 선택하셔야합니다.");
    	    EM_GIFT_E_NO.Text ="";
    	    EM_I_DT.Focus();
    	    return;
    	}*/
    }
    
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
        if( DS_IO_DETAIL.NameValue(i,"GIFT_S_NO")<=EM_GIFT_E_NO.Text &&  EM_GIFT_E_NO.Text <=DS_IO_DETAIL.NameValue(i,"GIFT_E_NO")) {
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호가 중복됩니다.");
            this.Text = "";
            setTimeout("EM_GIFT_E_NO.Focus();",100);
            return;
        }
    }
    getConf(this);
}
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<script language=JavaScript for=DS_S_STR event=OnFilter(row)>
    if (DS_S_STR.NameValue(row, "GBN") == "1") {// 본사점
        return true;
    }
    return false;
</script>

<script language=JavaScript for=DS_I_STR event=OnFilter(row)>
	if (DS_I_STR.NameValue(row, "GBN") == "1") {// 본사점
	    return true;
	}
	return false;
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row != row ){
    if (DS_IO_MASTER.CountRow > 0) {
        
        //디테일 조회
        getDetail();
        // 조회결과 Return
        setPorcCount("SELECT", GD_DETAIL);
     
    }
}
old_Row = row;
</script>
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnClickSave){
    if(showMessage(QUESTION , YESNO, "USER-1049") == 1 ){
        if(this.NameValue(row,"OUT_SLIP_NO") == ""){ // 신규인 경우 삭제 
        	this.DeleteRow(row);
        	setObject(false);
        }
        return true;
    }else{
        return false;
    }
}
return true;
</script>
<!-- =============== Input용 -->
<!-- 검색용 -->


<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_IO_CONF"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF_S"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF_CNT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0"자cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="130">
                <comment id="_NSID_">
                   <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=130 width=100 tabindex=1 align="absmiddle">
                   </object>
                 </comment><script>_ws_(_NSID_);</script>  
            </td>
            <th width="80" class="point">기간</th>
            <td width="200">
               <comment id="_NSID_">
                <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" /> ~ 
               <comment id="_NSID_">
                <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
            </td>
            <th width="80" >출고 구분</th>
            <td align="absmiddle">
               <comment id="_NSID_"> <object id=LC_S_GB
                    classid=<%=Util.CLSID_LUXECOMBO%> width="120" height=120
                    tabindex=1 align="absmiddle">
                    <param name=CBData value="%^전체,03^위탁출고,04^위탁반품">
                    <param name=CBDataColumns value="CODE,NAME">
                    <param name=SearchColumn value="NAME">
                    <param name=ListExprFormat value="CODE^2^30,NAME^1^100">
                    <param name=BindColumn value="CODE">
                    <param name=Index value="0">
                </object> </comment><script>_ws_(_NSID_);</script>
            </td>
            
          </tr>
          <tr>
            <th width="80">위탁협력사</th>
            <td colspan=5>
                <comment id="_NSID_">
                     <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=80 tabindex=1 align="absmiddle" tabindex=1>
                     </object>
                 </comment>
                 <script> _ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="javascript:getVenCd('1');" class="PR03"  />
                  <comment id="_NSID_">
                     <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=180 tabindex=1 align="absmiddle">
                     </object>
                 </comment>
                 <script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="250"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=483 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
          </tr>
        </table>
        </td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>마스터</td>
          </tr>
          <tr>
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td >
                 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                 
                  <tr>
                    <th width="70" class="point">출고점</th>
                    <td  width="100">
                      <comment id="_NSID_">
                        <object id=LC_I_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 tabindex=1 align="absmiddle">
                        </object>
                      </comment><script>_ws_(_NSID_);</script>   
                    </td>
                    <th width="70" class="point">출고일자</th>
                    <td >
                    <comment id="_NSID_">
                    <object id=EM_I_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                    </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" id=IMG_CAL onclick="javascript:openCal('G',EM_I_DT)" />                     
                    </td>
                    
                    <th width="70" >출고 구분</th>
		            <td align="absmiddle">
		               <comment id="_NSID_"> <object id=LC_I_GB
		                    classid=<%=Util.CLSID_LUXECOMBO%> width="120" height=120
		                    tabindex=1 align="absmiddle">
		                    <param name=CBData value="03^위탁출고,04^위탁반품">
		                    <param name=CBDataColumns value="CODE,NAME">
		                    <param name=SearchColumn value="NAME">
		                    <param name=ListExprFormat value="CODE^2^30,NAME^1^100">
		                    <param name=BindColumn value="CODE">
		                    <param name=Index value="0">
		                </object> </comment><script>_ws_(_NSID_);</script>
            </td>
                  </tr>
                  <tr>
                    <th class="point" >위탁협력사</th>
                    <td colspan="5" >
                        <comment id="_NSID_">
                             <object id=EM_I_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=80 tabindex=1 align="absmiddle" tabindex=1>
                             </object>
                         </comment>
                         <script> _ws_(_NSID_);</script>
                         <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" id=IMG_VEN onclick="javascript:getVenCd('2');" class="PR03"  />
                          <comment id="_NSID_">
                             <object id=EM_I_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=250 tabindex=1 align="absmiddle">
                             </object>
                         </comment>
                         <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  
                  <tr>
                    <th  >총수량</th>
                    <td>
                      <comment id="_NSID_">
                      <object id=EM_I_QTY classid=<%=Util.CLSID_EMEDIT%>   width=100 tabindex=1 align="absmiddle">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >총금액</th>
                    <td>
                      <comment id="_NSID_">
                      <object id=EM_I_AMT classid=<%=Util.CLSID_EMEDIT%>   width=100 tabindex=1 align="absmiddle">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table>
                    </td>
              </tr>
              <tr height="5"><td></td></tr>
              <tr><td class="dot"></td></tr>
              <tr>
                <td>
               <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="70">시작번호</th>
                <td width="130">
                    <comment id="_NSID_">
                      <object id=EM_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=130 tabindex=1 align="absmiddle">
                      </object></comment><script>_ws_(_NSID_);</script>
                  </td>
                <th width="70">종료번호</th>
                <td width="130">
                    <comment id="_NSID_">
                      <object id=EM_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=130 tabindex=1 align="absmiddle">
                      </object></comment><script>_ws_(_NSID_);</script>
                </td>
               <th width="70">개별등록</th>
                <td>
                <input type="checkbox" id=CHK_SINGLE align="absmiddle" onclick="javascript:onSingle();" tabindex=1 > 
                </td>
              </tr> 
            </table>
            </td>
              </tr>
            </table></td>
          </tr>
          
          <tr>
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr height="10"></tr>
              <tr>
                  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>상세내역</td>
                  <td class="right"> <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" id=IMG_DELROW onclick="javascript:delRow();"/> </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
		        <tr>
		        <td>
		            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=330 classid=<%=Util.CLSID_GRID%>>
		                <param name="DataID" value="DS_IO_DETAIL">
		                <Param Name="ViewSummary"   value="1" >
		            </OBJECT></comment><script>_ws_(_NSID_);</script>
		        </td>  
		          </tr>
		        </table>
		    </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=OUT_STR          Ctrl=LC_I_STR         param=BindColVal</c>
        <c>Col=OUT_DT           Ctrl=EM_I_DT          param=Text</c>
        <c>Col=VEN_CD         Ctrl=EM_I_VEN_CD         param=Text</c>
        <c>Col=VEN_NAME      Ctrl=EM_I_VEN_NM     param=Text</c>
        <c>Col=OUT_QTY          Ctrl=EM_I_QTY         param=Text</c>
        <c>Col=OUT_AMT          Ctrl=EM_I_AMT         param=Text</c>
        <c>Col=OUT_STR          Ctrl=LC_I_STR         param=BindColVal</c>
        <c>Col=STAT_FLAG          Ctrl=LC_I_GB         param=BindColVal</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

