<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 본사점 반품등록
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (김성미) 신규작성
          2011.03.25 (김슬기) 수정개발
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
<script language="javascript" src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var gv_preRownoMaster = "0";  //이전ROWNO
var gv_preRownoDetail = "0";  //이전ROWNO
var gv_giftno = "";
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
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_S_RFD_S_DT, "SYYYYMMDD", PK);    //시작기간(조회)
    initEmEdit(EM_S_RFD_E_DT, "YYYYMMDD", PK);    //종료기간(조회)
    initEmEdit(EM_I_RFD_DT, "YYYYMMDD", PK);      //반품일자
    initEmEdit(EM_I_RFD_SLIP_NO, "GEN", READ);    //신청순번
    initEmEdit(EM_I_RFD_QTY_SUM, "NUMBER^12^0", READ);    //총반품수량
    initEmEdit(EM_I_RFD_AMT_SUM, "NUMBER^12^0", READ);    //총반품금액
    initEmEdit(EM_I_GIFT_S_NO, "NUMBER3^18^0", NORMAL); //시작번호
    initEmEdit(EM_I_GIFT_E_NO, "NUMBER3^18^0", NORMAL); //종료번호
    
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);           //반품점(조회)
    //initComboStyle(LC_S_STR_CONF,DS_S_STR_CONF, "CODE^0^30,NAME^0^80", 1, NORMAL);   //반품확정(조회)
    //initComboStyle(LC_S_HSTR_CONF,DS_I_HSTR_CONF, "CODE^0^30,NAME^0^80", 1, NORMAL); //본사확정(조회)
    initComboStyle(LC_I_STR_CD,DS_I_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);           //반품점
    initComboStyle(LC_I_HSTR_CD,DS_I_HSTR_CD, "CODE^0^30,NAME^0^80", 1, PK);         //본사점
    
    //공통코드에서 가져 오기
    getStore("DS_S_STR_CD", "Y", "1", "N");
    getStore("DS_I_STR_CD", "Y", "1", "N");
    getStore("DS_I_HSTR_CD", "N", "0", "N");
    
    EM_I_RFD_SLIP_NO.alignment = 1;
    
    LC_S_STR_CD.Focus();
    LC_S_STR_CD.Index    = 0;  
    LC_I_STR_CD.Index    = 0;  
    LC_I_HSTR_CD.Index   = 0;
    LC_S_STR_CONF.Index  = 0;
    LC_S_HSTR_CONF.Index = 0;  
    
    EM_S_RFD_S_DT.Text = getTodayFormat("YYYYMM01");
    EM_S_RFD_E_DT.Text = getTodayFormat("YYYYMMDD");
    EM_I_RFD_DT.Text   = getTodayFormat("YYYYMMDD");
        
    setObject(false);

  //  CHK_SINGLE.disabled = true;
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif207", "DS_DETAIL");   
     
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"      width=30  align=center</FC>' 
                     + '<FC>id=STR_CD    name="반품점"   width=70  align=left'
                     + ' EDITSTYLE=LOOKUP   DATA="DS_I_STR_CD:CODE:NAME" </FC>'
                     + '<FC>id=RFD_DT      name="반품일자" width=80  align=center Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=RFD_SLIP_NO name="순번"     width=70  align=center</FC>'
                     + '<FC>id=HSTR_CD   name="본사점"   width=70  align=left'
                     + ' EDITSTYLE=LOOKUP   DATA="DS_I_HSTR_CD:CODE:NAME" </FC>'
                     + '<FC>id=STR_CONF    name="반품확정" width=60  align=left</FC>'
                     + '<FC>id=HSTR_CONF   name="본사확정" width=60  align=left</FC>';
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}
    
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}      name="NO"         width=30  align=center</FC>'
                     + '<FC>id=GIFT_AMT_NAME name="금종명"     width=80  align=left   </FC>'
                     + '<FC>id=GIFTCERT_AMT  name="상품권금액" width=80  align=right  Edit=Numeric</FC>'
                     + '<FC>id=GIFT_S_NO     name="시작번호"   width=150 align=center </FC>'
                     + '<FC>id=GIFT_E_NO     name="종료번호"   width=150 align=center sumtext="합계"</FC>'
                     + '<FC>id=RFD_QTY       name="반품수량"   width=70  align=right  Edit=Numeric sumtext={subsum(RFD_QTY)}</FC>'
                     + '<FC>id=RFD_AMT       name="반품금액"   width=120 align=right  Edit=Numeric sumtext={subsum(RFD_AMT)}</FC>';        
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
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
     setObject(false);
    if (DS_DETAIL.IsUpdated || DS_MASTER.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요
            DS_MASTER.RowPosition = gv_preRownoMaster;
            DS_DETAIL.RowPosition = gv_preRownoDetail;
            return;
        }      
    }  
    if (EM_S_RFD_S_DT.Text > EM_S_RFD_E_DT.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "종료기간", "시작기간");
        EM_S_RFD_E_DT.Focus();
        return;
    }
    
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd    = LC_S_STR_CD.BindColVal;    //반품점코드
    var strRfdDtS   = EM_S_RFD_S_DT.Text;        //시작기간
    var strRfdDtE   = EM_S_RFD_E_DT.Text;        //종료기간    
    var strStrConf  = LC_S_STR_CONF.BindColVal;  //반품확정   
    var strHstrConf = LC_S_HSTR_CONF.BindColVal; //본사확정
       
    var goTo = "getMaster";
    var action = "O";
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strRfdDtS="   + encodeURIComponent(strRfdDtS)
                   + "&strRfdDtE="   + encodeURIComponent(strRfdDtE)
                   + "&strStrConf="  + encodeURIComponent(strStrConf)
                   + "&strHstrConf=" + encodeURIComponent(strHstrConf);
    TR_MAIN.Action = "/mss/mgif207.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_MASTER=DS_MASTER)";
    TR_MAIN.Post();

    if (DS_MASTER.CountRow != 0) {
        GD_MASTER.Focus();      
        
        if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
            //alert();
            EM_I_GIFT_S_NO.Enable = false;
            EM_I_GIFT_E_NO.Enable = false;  
            enableControl(btnDelRow, false);
        }
        else {
            EM_I_GIFT_S_NO.Enable = true;
            EM_I_GIFT_E_NO.Enable = true; 
            enableControl(btnDelRow, true);
        }
    }else {
        return;
       //showMessage(STOPSIGN, OK, "GAUCE-1003", TR_MAIN.SrvErrMsg('GAUCE',i));
    } 
 //   setObject(false);
    
    gv_preRownoMaster = DS_MASTER.RowPosition;
    gv_preRownoDetail = DS_DETAIL.RowPosition;
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_MASTER.RealCount(1,DS_MASTER.CountRow));
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if (DS_DETAIL.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1050") != "1") {
            DS_MASTER.RowPosition = gv_preRownoMaster;
            DS_DETAIL.RowPosition = gv_preRownoDetail;
        } else {
            //DS_MASTER.ClearData();
            DS_DETAIL.ClearData();
            setObject(true);
            enableControl(btnDelRow, true);
            LC_I_STR_CD.Focus();
        }
    }else {
    	
    	  for(var i=1; i<=DS_MASTER.CountRow; i++){
              if(DS_MASTER.NameValue(i,"RFD_SLIP_NO")== ""){
                 return false; 
              }       
         }
          DS_MASTER.AddRow();
          
        DS_MASTER.Undo(gv_preRownoMaster);
        
      //  DS_MASTER.ClearData();
        DS_DETAIL.ClearData();
        setObject(true);
        enableControl(btnDelRow, true);
        LC_I_STR_CD.Focus();
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
    if (DS_MASTER.CountRow == 0){
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
    
    if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
        showMessage(Question, OK, "USER-1000", "반품확정된 전표는 삭제할 수 없습니다")
        return;
    }
    
    if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_SLIP_NO")== ""){
    	 showMessage(StopSign, OK, "USER-1019");
         return;
     }    
    
    if (DS_DETAIL.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1056") != "1") {
            DS_MASTER.RowPosition = gv_preRownoMaster;
            DS_DETAIL.RowPosition = gv_preRownoDetail;
            return;
        }
    }    
    if (!DS_DETAIL.IsUpdated) {
        if(showMessage(Question, YESNO, "USER-1023") != 1){
             return;
        }
    }
    

    DS_DETAIL.UseChangeInfo = "false";
    
    var strRfdDt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT");
    var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strRfdSlipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_SLIP_NO");
    var strGiftSNo   = DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"GIFT_S_NO");
    var strGiftENo   = DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"GIFT_S_NO");  
    
    var goTo = "delete";
    var parameters = "&strRfdDt="     + encodeURIComponent(strRfdDt)
                   + "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strRfdSlipNo=" + encodeURIComponent(strRfdSlipNo)
                   + "&strGiftSNo="   + encodeURIComponent(strGiftSNo)
                   + "&strGiftENo="   + encodeURIComponent(strGiftENo);
    TR_MAIN.Action = "/mss/mgif207.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post(); 
    
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
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
    if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
        showMessage(StopSign, OK, "USER-1000", "반품확정된 전표는 수정이 불가능 합니다. ");
        return;
    }
    if (DS_DETAIL.IsUpdated){
        if (checkDup() == true){
            return;
        }   
    }  
    if (!DS_DETAIL.IsUpdated){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }
        
    if(!checkDSBlank(GD_MASTER, "1")) return;  
    if(!checkDSBlank(GD_DETAIL, "1")) return;   
    
    var strToday = getTodayFormat("YYYYMMDD");
    
    if(EM_I_RFD_DT.Text < strToday) {
    	showMessage(StopSign, OK, "USER-1000", "반품일자는 오늘보다 이전일 수 없습니다.");
    	EM_I_RFD_DT.Text = getTodayFormat("YYYYMMDD");
        return;
    }
    
  //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return;
    }
    var strStrCd  = LC_I_STR_CD.BindColVal;     // 반품점
    var strRfdDt  = EM_I_RFD_DT.Text;           // 반품일자
    var strHstrCd = LC_I_HSTR_CD.BindColVal;    // 본사점
    var strSilpNo = EM_I_RFD_SLIP_NO.Text;      // 신청순번
    
    var goTo = "save";
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strRfdDt="  + encodeURIComponent(strRfdDt)
                   + "&strHstrCd=" + encodeURIComponent(strHstrCd)
                   + "&strSilpNo=" + encodeURIComponent(strSilpNo);
    TR_MAIN.Action = "/mss/mgif207.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post();
   
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
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
    if (DS_MASTER.CountRow == 0){
        showMessage(StopSign, OK, "USER-1079", "확정");
        return;
    }
    if (DS_DETAIL.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1082") != "1") {
            DS_MASTER.RowPosition = gv_preRownoMaster;
            DS_DETAIL.RowPosition = gv_preRownoDetail;
            return;
        }
    }    
    if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
    //	alert(DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF"));
        showMessage(StopSign, OK, "USER-1000", "이미 반품확정된 전표입니다. ");
        return;
    }

    // 마감체크 (common.js) : 일마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_MASTER.NameValue(DS_MASTER.RowPosotion,"STR_CD")
                      , DS_MASTER.NameValue(DS_MASTER.RowPosotion,"RFD_DT")
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "일", "");
        return;
    }
    
    // 마감체크 (common.js) : 월마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_MASTER.NameValue(DS_MASTER.RowPosotion,"STR_CD")
                      , DS_MASTER.NameValue(DS_MASTER.RowPosotion,"RFD_DT")
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        return;
    }
    
    if (!DS_DETAIL.IsUpdated) {
        if(showMessage(Question, YESNO, "USER-1205") != 1){
             return;
        }
    }       
    

    gv_preRownoMaster = DS_MASTER.RowPosition;
    
    DS_DETAIL.UseChangeInfo = "false";
    
    var strRfdDt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT");
    var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strRfdSlipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_SLIP_NO");  
    
    var goTo = "conf";
    var parameters = "&strRfdDt="     + encodeURIComponent(strRfdDt)
                   + "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strRfdSlipNo=" + encodeURIComponent(strRfdSlipNo);
    TR_MAIN.Action = "/mss/mgif207.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post();

    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    btn_Search();
    
    DS_MASTER.RowPosition = gv_preRownoMaster;
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* getDetail()
* 작 성 자 : 김슬기
* 작 성 일 : 2011-03-25
* 개    요 :  디테일 리스트 조회
* return값 : void
*/
function getDetail(){ 
    var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strRfdDt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT");
    var strRfdSlipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_SLIP_NO");
   
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strRfdDt="     + encodeURIComponent(strRfdDt)
                   + "&strRfdSlipNo=" + encodeURIComponent(strRfdSlipNo);
   
    TR_MAIN.Action="/mss/mgif207.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
} 

/**
* getGiftCnt()
* 작 성 자 : 김슬기
* 작 성 일 : 2011-03-25
* 개    요 :  상품권상태정보확인 
* return값 : void
*/
function getGiftCnt(strGiftSNo, strGiftENo){
   
    var strStrCd   = LC_I_STR_CD.BindColVal;
    var strRfdDt = EM_I_RFD_DT.Text;
   
    var goTo       = "getGiftCnt" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strGiftSNo=" + encodeURIComponent(strGiftSNo)
                   + "&strGiftENo=" + encodeURIComponent(strGiftENo)
                   + "&strRfdDt="   + encodeURIComponent(strRfdDt);   
    
    TR_MAIN.Action="/mss/mgif207.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_GIFT_CNT=DS_GIFT_CNT)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_GIFT_CNT.CountRow == 1){
    	if(DS_GIFT_CNT.NameValue(1,"GIFTCARD_CNT") == DS_GIFT_CNT.NameValue(1,"GIFTCARD_ALL_CNT")){
    		   return true;	
    	}else{
    		return false;
    	}
    }
    return false;
    
} 

/**
* getGiftStat()
* 작 성 자 : 김슬기
* 작 성 일 : 2011-03-25
* 개    요 :  상품권상태정보확인 
* return값 : void
*/
function getGiftStat(strGiftSNo, strGiftENo){
   
	if(!getGiftCnt(strGiftSNo, strGiftENo)){
		showMessage(STOPSIGN, OK, "USER-1000", "연속되지 않는 상품권 번호 입니다.");
		EM_I_GIFT_E_NO.Text = "";
		setTimeout("EM_I_GIFT_E_NO.Focus();", 50);
		return;
	}
	
	var strStrCd   = LC_I_STR_CD.BindColVal;
 //   var strGiftSNo = EM_I_GIFT_S_NO.Text;
 //   var strGiftENo = EM_I_GIFT_E_NO.Text;
    var strRfdDt = EM_I_RFD_DT.Text;
   
    var goTo       = "getGiftStat" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strGiftSNo=" + encodeURIComponent(strGiftSNo)
                   + "&strGiftENo=" + encodeURIComponent(strGiftENo)
                   + "&strRfdDt="   + encodeURIComponent(strRfdDt);   
    
    TR_MAIN.Action="/mss/mgif207.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_GIFTSTAT)"; //조회는 O
    TR_MAIN.Post();
    
   if (DS_GIFTSTAT.CountRow != 0) { 
        DS_DETAIL.ImportData(DS_GIFTSTAT.ExportData(1, DS_GIFTSTAT.CountRow, true));    
    }else {
       // showMessage(STOPSIGN, OK, "USER-1000", "등록할 수 없는 상품권입니다.");
       return;
    }    

    gv_preRownoMaster = DS_MASTER.RowPosition;
    gv_preRownoDetail = DS_DETAIL.RowPosition;
    //DS_DETAIL.UserStatus(DS_DETAIL.RowPosition) = 1;  
    EM_I_GIFT_S_NO.Text = "";
    EM_I_GIFT_E_NO.Text = "";
    EM_I_GIFT_S_NO.Focus();
} 
 
/**
* getGiftAmttype()
* 작 성 자 : 김정민
* 작 성 일 : 2011-04-01
* 개    요 :  상품권 권종조회 
* return값 : void  gv_giftno
*/
function getGiftAmttype(strGiftno, strGbn){  
    
       var strStrCd   = LC_I_STR_CD.BindColVal;
       var strRfdDt = EM_I_RFD_DT.Text;
       
        var goTo       = "getGiftAmttype" ;    
        var action     = "O";     
        var parameters = "&strGiftno="   + encodeURIComponent(strGiftno)
                       + "&strRfdDt="    + encodeURIComponent(strRfdDt);
        TR_MAIN.Action="/mss/mgif207.mg?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
        TR_MAIN.Post(); 
       if(DS_O_RESULT.CoutRow !="0") {
           if(strGbn == "S") {
               if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"STAT_FLAG") == "03") {
                   gv_giftno = DS_O_RESULT.NameValue(1,"GIFT_AMT_TYPE"); 
               }
               else {
                   showMessage(Question, OK, "USER-1000", "상품권의 상태가 지점입고가 아닙니다.");
                   EM_I_GIFT_S_NO.Text = "";
                   setTimeout("EM_I_GIFT_S_NO.Focus();", 50);
                   return;
               }
               if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"IN_STR") != strStrCd) {
                   showMessage(Question, OK, "USER-1000", "해당매장에 해당하지 않는 상품권 입니다.");
                   EM_I_GIFT_S_NO.Text = "";
                   setTimeout("EM_I_GIFT_S_NO.Focus();", 50);
                   return;
               }
               
            // 데이터 입력후 반품점, 일자 수정불가
               EM_I_RFD_DT.Enable = false;
               LC_I_STR_CD.Enable = false;
           }
           else {
               if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"STAT_FLAG") == "03") {
            	   if(!CHK_SINGLE.checked){
	                   if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFT_AMT_TYPE") != gv_giftno) {
	                       showMessage(Question, OK, "USER-1000", "상품권의 권종이 다릅니다.");
	                       EM_I_GIFT_E_NO.Text = "";
	                       setTimeout("EM_I_GIFT_E_NO.Focus();", 50);
	                       return;
	                   }
            	   }
               }
               else {
                   showMessage(Question, OK, "USER-1000", "상품권의 상태가 지점입고가 아닙니다.");
                   EM_I_GIFT_E_NO.Text = "";
                   setTimeout("EM_I_GIFT_E_NO.Focus();", 50);
                   return;
               }
               
               if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"IN_STR") != strStrCd) {
                   showMessage(Question, OK, "USER-1000", "해당매장에 해당하지 않는 상품권 입니다.");
                   EM_I_GIFT_E_NO.Text = "";
                   setTimeout("EM_I_GIFT_E_NO.Focus();", 50);
                   return;
               }
           }
       }
       else {
           if(strGbn == "S") {
               showMessage(Question, OK, "USER-1000", "등록되지 않은 상품권 번호입니다.");
               EM_I_GIFT_S_NO.Text = "";
               setTimeout("EM_I_GIFT_S_NO.Focus();", 50);
           }
           else {
               showMessage(Question, OK, "USER-1000", "등록되지 않은 상품권 번호입니다.");
               EM_I_GIFT_E_NO.Text = "";
               setTimeout("EM_I_GIFT_E_NO.Focus();", 50);
           }
       }
}

/**
* getGiftNo()
* 작 성 자 : 김정민
* 작 성 일 : 2011-04-01
* 개    요 :  상품권 중복 체크
* return값 : void  gv_giftno
*/
function getGiftNo(strCardNo, strGbn) {
     for(var i=1; i <=DS_DETAIL.CountRow; i++) {
         if(strGbn == "S") {
             if( DS_DETAIL.NameValue(i,"GIFT_S_NO")<=strCardNo &&  strCardNo <=DS_DETAIL.NameValue(i,"GIFT_E_NO")) {
                 showMessage(Question, OK, "USER-1000", "시작번호가 중복되었습니다.")
                 EM_I_GIFT_S_NO.Text = "";
                 setTimeout("EM_I_GIFT_S_NO.Focus();", 50);
                 return;
             }
         }
         else {
             if( DS_DETAIL.NameValue(i,"GIFT_S_NO")<=strCardNo &&  strCardNo <=DS_DETAIL.NameValue(i,"GIFT_E_NO")) {
                 showMessage(Question, OK, "USER-1000", "종료번호가 중복되었습니다.")
                 EM_I_GIFT_E_NO.Text = "";
                 setTimeout("EM_I_GIFT_E_NO.Focus();", 50); 
                 return;
             }
         }
     }
}

/**
  * btn_DeleteRow()
  * 작 성 자 : 김슬기
  * 작 성 일 : 2011.03.25
  * 개    요 : 행삭제
  * return값 :
  */
function btn_DeleteRow() {
    if (DS_DETAIL.CountRow > 0) {          
        if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
            showMessage(Question, OK, "USER-1000", "반품확정된 전표는 삭제할 수 없습니다")
            return;
        }else{
            DS_DETAIL.DeleteRow(DS_DETAIL.RowPosition);
            if(DS_DETAIL.CountRow == 0){
            	// 반품상세 내역이 없는경우  반품점, 일자 수정가능 
                EM_I_RFD_DT.Enable = true;
                LC_I_STR_CD.Enable = true;
            }
        }        
    }
} 

/**
 * setObject(flag)
 * 작 성 자 : 김슬기
 * 작 성 일 : 2011-01-26
 * 개    요 :  반품등록 가능여부 셋팅 
 * return값 : void
 */
 function setObject(flag) {  
    if (flag == true){
        LC_I_STR_CD.Enable    = flag;
        EM_I_RFD_DT.Enable    = flag;
        LC_I_HSTR_CD.Enable   = flag;
        CHK_SINGLE.disabled = false;
        if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
            EM_I_GIFT_S_NO.Enable = false;
            EM_I_GIFT_E_NO.Enable = false;  
        }else{
            EM_I_GIFT_S_NO.Enable = true;
            EM_I_GIFT_E_NO.Enable = true;  
        } 
        if (DS_DETAIL.CountRow == 0) {
            enableControl(btnDelRow, false);
        }else{
            enableControl(btnDelRow, flag);
        }
        LC_I_STR_CD.Index     = 0;
        LC_I_HSTR_CD.Index    = 0;
        EM_I_RFD_DT.Text      = getTodayFormat("YYYYMMDD");
        EM_I_RFD_SLIP_NO.Text = "";
        EM_I_RFD_QTY_SUM.Text = "";
        EM_I_RFD_AMT_SUM.Text = "";
        EM_I_GIFT_S_NO.Text   = "";
        EM_I_GIFT_E_NO.Text   = "";  
    }else if (flag == false){
        LC_I_STR_CD.Enable    = flag;
        EM_I_RFD_DT.Enable    = flag;
        LC_I_HSTR_CD.Enable   = flag;
        CHK_SINGLE.disabled = true;
        if(DS_MASTER.CountRow > 0){
            EM_I_GIFT_S_NO.Enable = true;
            EM_I_GIFT_E_NO.Enable = true;  
            enableControl(btnDelRow, true);
        }else{
            EM_I_GIFT_S_NO.Enable = flag;
            EM_I_GIFT_E_NO.Enable = flag;
            enableControl(btnDelRow, flag);
            LC_I_STR_CD.BindColVal     = "";
            LC_I_HSTR_CD.BindColVal   = "";
            EM_I_RFD_DT.Text      = "";
            EM_I_RFD_SLIP_NO.Text = "";
            EM_I_RFD_QTY_SUM.Text = "";
            EM_I_RFD_AMT_SUM.Text = "";
            EM_I_GIFT_S_NO.Text   = "";
            EM_I_GIFT_E_NO.Text   = "";  
        }
         
        
    }    
}
 
/**
* checkDup()
* 작 성 자 : 김슬기
* 작 성 일 : 2011-03-24
* 개       요 : 중복된 값 체크
* return값 : void
*/
function checkDup(){
    for (var i=1; i<=DS_DETAIL.CountRow; i++){
        for (var j=1; j<=DS_DETAIL.CountRow; j++){
            if(i != j){
                if (DS_DETAIL.NameValue(i, "GIFT_S_NO") == DS_DETAIL.NameValue(j, "GIFT_S_NO")){
                    showMessage(StopSign, Ok,  "GAUCE-1007", j);
                    DS_DETAIL.RowPosition = j;
                    GD_DETAIL.Focus(GD_DETAIL.SetColumn("GIFT_S_NO"));
                    return true;
                }else if (DS_DETAIL.NameValue(i, "GIFT_E_NO") == DS_DETAIL.NameValue(j, "GIFT_E_NO")){
                    showMessage(StopSign, Ok,  "GAUCE-1007", j);
                    DS_DETAIL.RowPosition = j;
                    GD_DETAIL.Focus(GD_DETAIL.SetColumn("GIFT_E_NO"));
                    return true;
                }
            }            
        }
    }       
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
    	EM_I_GIFT_S_NO.Text = "";     
    	EM_I_GIFT_S_NO.Enable = false;
    }else{
    	EM_I_GIFT_S_NO.Text = "";
    	EM_I_GIFT_S_NO.Enable = true;
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
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);      
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var colName = GD_MASTER.GetHdrDispName(-3, colid);
    if (this.ErrorCode == "50018") {
        showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
    } else if (this.ErrorCode == "50019") {
        showMessage(STOPSIGN, OK, "GAUCE-1007", row);
    } else {
        showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
    }
</script>

<script language=JavaScript for=DS_DETAIL event=OnDataError(row,colid)>
    var colName = GD_DETAIL.GetHdrDispName(-3, colid);
    if (this.ErrorCode == "50018") {
        showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
    } else if (this.ErrorCode == "50019") {
        showMessage(STOPSIGN, OK, "GAUCE-1007", row);
    } else {
        showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
    }
</script>

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
if (DS_DETAIL.IsUpdated|| DS_MASTER.IsUpdated) { 
        if (showMessage(Question, YesNo, "USER-1049") != 1) { 
            return false;
        } else {
            return true;
        }        
    } else {
        return true;
    }
/*	if (DS_MASTER.IsUpdated) {
	    if (showMessage(Question, YesNo, "USER-1049") != 1) {
	        return false;
	    } else {
	    	DS_MASTER.DeleteRow(DS_MASTER.RowPosition);  
	        return true;
	    }        
	} else {
	    return true;
	} */
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0) {
        setTimeout("getDetail()",50);     
        EM_I_GIFT_S_NO.Text   = "";
        EM_I_GIFT_E_NO.Text   = "";     
        if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CONF") == "확정"){
            EM_I_GIFT_S_NO.Enable = false;
            EM_I_GIFT_E_NO.Enable = false;  
            enableControl(btnDelRow, false);
        }
        else {
            EM_I_GIFT_S_NO.Enable = true;
            EM_I_GIFT_E_NO.Enable = true; 
            enableControl(btnDelRow, true);
        }
    }    
</script>  

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
    if(clickSORT) return; 
</script>  
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
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



<script language=JavaScript for=EM_I_GIFT_S_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout("EM_I_GIFT_S_NO.Focus()", 50);
    return;
}

getGiftAmttype(EM_I_GIFT_S_NO.Text,"S");
getGiftNo(EM_I_GIFT_S_NO.Text,"S");

// 기존 판매내역 확인
 for(var j=1;j<=DS_MASTER.CountRow;j++){
     if(this.Text == DS_MASTER.NameValue(j, "GIFTCARD_NO")){
         showMessage(EXCLAMATION, OK, "USER-1000", "중복된 상품권 정보가 있습니다.");
         this.Text = "";
         setTimeout("EM_GIFT_S_NO.Focus()", 50);
         return;
     }
 }
return true;
</script>
<script language=JavaScript for=EM_I_GIFT_E_NO event=OnKillFocus()>
if(this.Text == "") return;
if(this.Text.length != 13 && this.Text.length != 16 && this.Text.length != 18){
    showMessage(EXCLAMATION, OK, "USER-1000", "상품권 번호를 확인해 주세요.");
    this.Text = "";
    setTimeout("EM_I_GIFT_E_NO.Focus()", 50);
    return;
}
if(!CHK_SINGLE.checked){
    if(EM_I_GIFT_S_NO.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1000", "상품권시작번호를 먼저 스캔해 주세요.");
        this.Text = "";
        setTimeout("EM_I_GIFT_S_NO.Focus()", 50);
        return;
    }

    if(this.Text < EM_I_GIFT_S_NO.Text){
        showMessage(EXCLAMATION, OK, "USER-1008", "종료번호", "시작번호");
        this.Text = "";
        setTimeout("EM_I_GIFT_E_NO.Focus()", 50);
        return;
    }

    getGiftAmttype(EM_I_GIFT_E_NO.Text,"E");
    getGiftStat(EM_I_GIFT_S_NO.Text, this.Text); 
}
else { 
    getGiftAmttype(EM_I_GIFT_E_NO.Text,"E");
    getGiftStat(this.Text, this.Text); 
}


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
<comment id="_NSID_">
<object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_GIFT_CNT"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_HSTR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_GIFTSTAT"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAILCHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT_NO"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>
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

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80" class="point">반품점</th>
                <td width="140">
                  <comment id="_NSID_">
                  <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80" class="point">기간</th>
                <td>
                  <comment id="_NSID_">
                  <object id=EM_S_RFD_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                  </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_RFD_S_DT)" align="absmiddle"/> 
                  ~ 
                  <comment id="_NSID_">
                  <object id=EM_S_RFD_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                  </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_RFD_E_DT)" align="absmiddle" />
                </td>
              </tr>
              <tr>
                <th >반품확정</th>
                <td>
                  <comment id="_NSID_">
                  <object id=LC_S_STR_CONF classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                    <param name=CBData          value="%^전체,Y^확정,N^미확정">
                    <param name=CBDataColumns   value="Code,Text">
                    <param name=ListExprFormat  value="Code^0^30,Text^0^115">
                    <param name=SearchColumn    value="Text">
                    <param name=BindColumn      value="Code">
                    </object></comment><script>_ws_(_NSID_);</script>
                </td>
                <th >본사확정</th>
                <td>
                  <comment id="_NSID_">
                  <object id=LC_S_HSTR_CONF classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                    <param name=CBData          value="%^전체,Y^확정,N^미확정">
                    <param name=CBDataColumns   value="Code,Text">
                    <param name=ListExprFormat  value="Code^0^30,Text^0^115">
                    <param name=SearchColumn    value="Text">
                    <param name=BindColumn      value="Code"> 
                  </object>
                  </comment><script>_ws_(_NSID_);</script>
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
  <tr valign="top">
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td width="200">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_MASTER width=100% height=480 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                  </object></comment><script>_ws_(_NSID_);</script>
               </td>  
             </tr>
           </table>
         </td>
         <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                 <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>반품 마스터</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td class="PB05"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
                  <tr>
                    <td class="PB05"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                      <tr>
                        <th width="80" class="point">반품점</th>
                        <td width="100">
                          <comment id="_NSID_">
                          <object id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80" class="point">반품일자</th>
                        <td width="105">
                          <comment id="_NSID_">
                          <object id=EM_I_RFD_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                          </object></comment><script>_ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_I_RFD_DT)" align="absmiddle" /> 
                        </td>
                        <th width="80">신청순번</th>
                        <td>
                          <comment id="_NSID_">
                          <object id=EM_I_RFD_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>
                      </tr>
                      <tr>
                        <th width="80" class="point">본사점</th>
                        <td>
                          <comment id="_NSID_">
                          <object id=LC_I_HSTR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th>총반품수량</th>
                        <td>
                          <comment id="_NSID_">
                          <object id=EM_I_RFD_QTY_SUM classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th>총반품금액</th>
                        <td>
                          <comment id="_NSID_">
                          <object id=EM_I_RFD_AMT_SUM classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle">
                          </object></comment><script>_ws_(_NSID_);</script>
                        </td>                        
                      </tr>
                    </table></td> 
                  </tr>
                  <tr>
                    <td class="dot"></td>
                  </tr>
                  <tr valign="top">
                    <td>
                      <table width=100%  border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td>
                            <table width=550  border="0" cellpadding="0" cellspacing="0" class="s_table">
                              <tr>
                                <th width="80">시작번호</th>
                                <td width="130">
                                  <comment id="_NSID_">
                                  <object id=EM_I_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
                                  </object></comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80">종료번호</th>
                                <td width="130">
                                  <comment id="_NSID_">
                                  <object id=EM_I_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
                                  </object></comment><script>_ws_(_NSID_);</script>
                                </td>
                                 <th  width="100">개별등록</th>
				                <td>
				                <input type="checkbox" id=CHK_SINGLE align="absmiddle" onclick="javascript:onSingle();" tabindex=1 > 
				                </td>
                              </tr>                                 
                            </table>
                          </td>
                          <td class="right"><img src="/<%=dir%>/imgs/btn/del_row.gif" id="btnDelRow" width="52" height="18" onclick="btn_DeleteRow()"/></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr valign="top">
            <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td class="dot"></td>
            </tr>
              <tr>
                <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>반품 상세</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_DETAIL width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                      <param name="DataID" value="DS_DETAIL">
                      </OBJECT></comment><script>_ws_(_NSID_);</script>
                    </td>  
                    </tr>
                  </table></td>
                </tr>         
              </table></td>
            </tr>
          </table></td>
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
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=STR_CD           Ctrl=LC_I_STR_CD       param=BindColVal</c>
        <c>Col=RFD_DT           Ctrl=EM_I_RFD_DT       param=Text</c>
        <c>Col=RFD_SLIP_NO      Ctrl=EM_I_RFD_SLIP_NO  param=Text</c>
        <c>Col=HSTR_CD          Ctrl=LC_I_HSTR_CD      param=BindColVal</c>
        <c>Col=RFD_QTY_SUM      Ctrl=EM_I_RFD_QTY_SUM  param=Text</c>
        <c>Col=RFD_AMT_SUM      Ctrl=EM_I_RFD_AMT_SUM  param=Text</c>        
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>


