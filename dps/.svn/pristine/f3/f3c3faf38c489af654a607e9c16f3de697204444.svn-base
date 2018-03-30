<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주관리 > 발주결재라인관리
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord2140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 발주결재라인관리
 * 이    력 :   
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
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
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dps.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strToday      = "";                            // 현재날짜
var strNextDay    = "";                            // 다음날
var flag          = false;
var headerInsFlag = false;  
var strGCount = 0;
var detailOrgGridCount   = 0;      //디테일 그리드 컨트롤 위한 변수(기존)
var detailAftGridCount   = 0;      //디테일 그리드 컨트롤 위한 변수(삭제후)

var beforeMasterRow  = 0;          //저장이후 변경된 행에 커서 옮기기 위함변수

var inta            = 0;
var bfListRowPosition = 0;                               // 이전 List Row Position
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
 var top2 = 420;		//해당화면의 동적그리드top위치
 
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	 

     strToday        = getTodayDB("DS_O_RESULT");
//     strToday        = getTodayFormat('YYYYMMDD');
     
//     alert(strToday);
     strNextDay      = setNextDay();
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');  

     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터   
     gridCreate2(); //디테일

     //콤보 초기화
     initComboStyle(LC_O_BZ_TYPE,DS_S_BIZ_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL); // 거래형태

     //공통코드에서 데이터셋 가져오기
     getEtcCode("DS_S_BIZ_FLAG", "D", "P215", "Y");       // 조회시 거래형태 
     getEtcCode("DS_BIZ_FLAG",   "D", "P215", "N");       // 입력시 거래형태 
     getEtcCode("DS_SLIP_FLAG",  "D", "P216", "N");       // 입력시 직매입 
     DS_SLIP_FLAG.UseFilter = true;

     //getEtcCode("DS_SLIP_FLAG",  "D", "P217", "N");       // 입력시 특정 
     
     registerUsingDataset("pord214","DS_IO_MASTER,DS_IO_DETAIL" );

     enableControl(IMG_ADD, false);
     enableControl(IMG_DEL, false);
     LC_O_BZ_TYPE.Index = 0;    //거래형태 전체로 선택
     LC_O_BZ_TYPE.Focus();      //로드시 포커스 거래형태로
 //    btn_Search();              //자동조회
 }

 function gridCreate1(){
     var hdrProperies =    '<FC>id={currow}         name="NO"                  width=25      align=center </FC>'   
                         + '<FC>id=BIZ_TYPE         name="거래형태"            width=55     align=left EditStyle=Lookup   Data="DS_BIZ_FLAG:CODE:NAME"</FC>'
                         + '<FC>id=SLIP_FLAG        name="전표구분"            width=70     align=left EditStyle=Lookup   Data="DS_SLIP_FLAG:CODE:NAME"</FC>'
                         + '<FC>id=APP_S_DT         name="적용시작일"          width=85    align=center EditStyle=Popup align=center Edit=Numeric mask="XXXX/XX/XX"</FC>'
                         + '<FC>id=APP_E_DT         name="적용종료일"          width=85    align=center EditStyle=Popup align=center Edit="none" mask="XXXX/XX/XX"</FC>'
                         + '<FC>id=ORD_REG_YN       name="발주등록"            width=57    align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=SM_CONF_YN       name="SM승인"              width=50     align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=STEAM_CONF_YN    name="영업팀장승인"        width=80    align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=ACC_CONF_YN      name="재무팀합의"          width=65    align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=BUYER_CONF_YN    name="바이어승인"          width=67    align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=BTEAM_CONF_YN    name="매입팀장승인"        width=77    align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=STR_CONF_YN      name="점장승인"            width=53    align=center EditStyle=Combo Data="Y:Y,N:N"</FC>'
                         + '<FC>id=CHK_CONF_YN      name="검품확정"            width=54     align=center EditStyle=Combo Data="Y:Y,N:N"</FC>';   
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies =    '<FC>id={currow}         name="NO"                  width=25      align=center </FC>'   
                         + '<FC>id=BIZ_TYPE         name="거래형태"            width=55     align=left Edit = "none" EditStyle=Lookup   Data="DS_BIZ_FLAG:CODE:NAME"</FC>'
                         + '<FC>id=SLIP_FLAG        name="전표구분"            width=70     align=left Edit = "none" EditStyle=Lookup   Data="DS_SLIP_FLAG:CODE:NAME"</FC>'
                         + '<FC>id=APP_S_DT         name="적용시작일"          width=85    align=center EditStyle=Popup align=center mask="XXXX/XX/XX" edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=APP_E_DT         name="적용종료일"          width=85    align=center EditStyle=Popup align=center Edit="none" mask="XXXX/XX/XX"</FC>'
                         + '<FC>id=ORD_REG_YN       name="발주등록"            width=57    align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=SM_CONF_YN       name="SM승인"              width=50     align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=STEAM_CONF_YN    name="영업팀장승인"        width=80    align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=ACC_CONF_YN      name="재무팀합의"          width=65    align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=BUYER_CONF_YN    name="바이어승인"          width=67    align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=BTEAM_CONF_YN    name="매입팀장승인"        width=77    align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=STR_CONF_YN      name="점장승인"            width=53    align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>'
                         + '<FC>id=CHK_CONF_YN      name="검품확정"            width=54     align=center EditStyle=Combo Data="Y:Y,N:N"  edit={IF(CHK_DATA="0","true","false")}</FC>';  
     initGridStyle(GR_DETAIL, "common", hdrProperies, true);  
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
    //저장안된 데이터 있는데 조회할때
    if(DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated ){
        if(showMessage(INFORMATION, YESNO, "USER-1073") != 1 ){
              return;
        }
    }
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    //마스터 조회
    
    inta = 0;
    bfListRowPosition = 0;
    getMaster();
    
    //포커스 위치 
    if(DS_IO_MASTER.CountRow == 0){
        LC_O_BZ_TYPE.Focus();    
    }else{
        GR_MASTER.SetColumn("BIZ_TYPE");   
        GR_MASTER.Focus();
    }
    //컴퍼넌트, 이미지 사용유무 
    enableControl(IMG_ADD, true);
    enableControl(IMG_DEL, true);
    setMasterGrid("none");      //마스터 그리드 입력 비활성화
    //마스터 조회된 카운트
//    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    headerInsFlag = false;
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {    
     
    var strRowPosition  = DS_IO_MASTER.RowPosition ;
    var strCountRow     = DS_IO_MASTER.CountRow;    

/*
    //신규입력시 포커스 이동
    if(strCountRow <7){
        DS_IO_DETAIL.ClearData();
        DS_IO_MASTER.Addrow();
        GR_MASTER.SetColumn("BIZ_TYPE");  //BIZ_TYPE
        GR_MASTER.Focus(); 
        strGCount = DS_IO_MASTER.CountRow;

    }else{
        //추가할 결재라인이 없음
        showMessage(INFORMATION, OK, "USER-1062"); 
        return;
    }
*/    
    if(DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
        if(showMessage(INFORMATION, YESNO, "USER-1072") != 1 ){ 
            return false;
            
        }else {
            
            headerInsFlag = false;  
            if(DS_IO_MASTER.IsUpdated){
                initMaster();                   //마스터 초기화(행추가와 같다)
                DS_IO_DETAIL.ClearData();
            }else{
                //신규입력시 포커스 이동
                if(strCountRow <7){
                    DS_IO_DETAIL.ClearData();
                    DS_IO_MASTER.Addrow();
                    initMaster();
                }else{
                    //추가할 결재라인이 없음
                    showMessage(INFORMATION, OK, "USER-1062"); 
                    return;
                }           
            }
            GR_MASTER.SetColumn("BIZ_TYPE");  //BIZ_TYPE
            GR_MASTER.Focus(); 
            strGCount = DS_IO_MASTER.CountRow;
            headerInsFlag = true;   
            return true;
        }
    }else{
        if(strCountRow <7){
                DS_IO_DETAIL.ClearData();
                DS_IO_MASTER.Addrow();
                GR_MASTER.SetColumn("BIZ_TYPE");  //BIZ_TYPE
                GR_MASTER.Focus(); 
                strGCount = DS_IO_MASTER.CountRow;

            }else{
                //추가할 결재라인이 없음
                showMessage(INFORMATION, OK, "USER-1062"); 
                return;
            }
            
    }

    //중복체크 
    var dupRow = checkDupKey(DS_IO_MASTER, "BIZ_TYPE||SLIP_FLAG");
    if (dupRow > 0) {
        showMessage(INFORMATION, OK, "GAUCE-1007", DS_IO_MASTER.CountRow);
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG") = "";
        return;
    }
     
            
    //마스터 그리드 입력부 활성화  
//    setMasterGrid("any");    
    
    //마스터 그리드 입력부 신규버튼 클릭시 초기값 셋팅
    initMaster();
    enableControl(IMG_ADD, false);  //행추가 이미지 비활성화    
    
    headerInsFlag = true;   
    return;
}


/**
 * initMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-14
 * 개    요 : Grid 초기화
 * return값 : void
 */
function initMaster(){

    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE")       = "";            //거래형태
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG")      = "";            //전표구분
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT")       = strNextDay;    //적용시작일 기본으로 셋팅    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_E_DT")       = '99991231';    //적용종료일 기본으로 셋팅    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORD_REG_YN")     = 'Y';           //발주등록    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SM_CONF_YN")     = 'Y';           //SM확정    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STEAM_CONF_YN")  = 'Y';           //영업팀장확정    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CONF_YN")    = 'Y';           //점장확정    
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUYER_CONF_YN")  = 'Y';           //바이어확정   
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ACC_CONF_YN")    = 'Y';           //재무팀협의(확정)   
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BTEAM_CONF_YN")  = 'Y';           //매입팀장확정
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CHK_CONF_YN")    = 'Y';           //검품확정     
}


/**
 * orgDetail()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-14
 * 개    요 : Grid 초기값셋팅
 * return값 : void
 */
function orgDetail(){

    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE")       = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE");            //거래형태
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG")      = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG");            //전표구분    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT")       = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "APP_S_DT");            //전표구분    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "APP_E_DT")       = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "APP_E_DT");    //적용종료일 기본으로 셋팅    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "ORD_REG_YN")     = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "ORD_REG_YN");           //발주등록    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "SM_CONF_YN")     = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "SM_CONF_YN");           //SM확정    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "STEAM_CONF_YN")  = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "STEAM_CONF_YN");           //영업팀장확정    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "STR_CONF_YN")    = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "STR_CONF_YN");           //점장확정    
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "BUYER_CONF_YN")  = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "BUYER_CONF_YN");           //바이어확정   
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "ACC_CONF_YN")    = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "ACC_CONF_YN");           //재무팀협의(확정)   
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "BTEAM_CONF_YN")  = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "BTEAM_CONF_YN");           //매입팀장확정
    DS_IO_DETAIL.NameValue(DS_IO_MASTER.RowPosition, "CHK_CONF_YN")    = DS_IO_DETAIL.OrgNameValue(DS_IO_MASTER.RowPosition, "CHK_CONF_YN");           //검품확정     
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
 
function btn_Delete() {
/*   
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1023") != 1 )
        return; 

    delMaster();
    btn_Search();
*/
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
*/
function btn_Save(){   
	 
	 beforeMasterRow = DS_IO_MASTER.RowPosition; // 저장시점의 마스터 로우를 저장한다.

//	 alert("beforeMasterRow = " + beforeMasterRow);
	 
//    headerInsFlag = false;
//    strGCount = 0;
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(StopSign, OK, "USER-1028");
        return;
    }
    
    if(!checkValidation())
        return;

    if(DS_IO_MASTER.IsUpdated){  
        if(showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){
            saveMaster();      
        }
    }else if(DS_IO_DETAIL.IsUpdated){
        if(showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){
            saveDetail();
        }
    }
    //행추가 이미지 활성화     
    enableControl(IMG_ADD, true);  
//    headerInsFlag = true;    

    bfListRowPosition = 0;    

    //저장한뒤 변경된 마스터의 행으로 행 이동된다
    setFocusGrid(GR_MASTER, DS_IO_MASTER, beforeMasterRow, "BIZ_TYPE");   
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
 * checkValidation()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-22
 * 개    요 :  저장시 벨류 체크
 * return값 : void
 */
 function checkValidation(){
     // 마스터의 행과 포지션 로우를 가져온다
     var strRowPosition  = DS_IO_MASTER.RowPosition;
     var strCountRow     = DS_IO_MASTER.CountRow;
          
     var dupRow = checkDupKey(DS_IO_MASTER, "BIZ_TYPE||SLIP_FLAG");
     if(dupRow > 0){
          showMessage(INFORMATION, OK, "GAUCE-1000", "Row Num(" +strRowPosition+ ")에 중복된 데이터가 있습니다.");
          return false;
     }      
     
     if(DS_IO_MASTER.IsUpdated){
         if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE").length == 0){
             showMessage(INFORMATION, OK, "USER-1002", "거래형태");   
             return false;
         }
         if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG").length == 0){
             showMessage(INFORMATION, OK, "USER-1002", "전표구분");   
             return false;
         }
         if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT").length == 0){
             showMessage(INFORMATION, OK, "USER-1002", "적용시작일");   
             return false;
         }
     }
     if (headerInsFlag){
         getMasterCount();
         //메시지
         if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "RESULTCOUNT") >= 1){
             showMessage(INFORMATION, OK, "GAUCE-1000", "Row Num(" +strRowPosition+ ")에 중복된 데이터가 있습니다.");
//             showMessage(INFORMATION, OK, "USER-1028"); 
//             btn_Search();
             return false;
         }    	 
     }
     

     return true;
 }
 
 /**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-22
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster() {
     // 조회조건 셋팅
     var strBizType  = LC_O_BZ_TYPE.BindColVal;

     var goTo       = "getMaster" ;    
     var action     = "O";     
     var parameters = "&strBizType="+encodeURIComponent(strBizType);
     TR_S_MAIN.Action="/dps/pord214.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
     TR_S_MAIN.Post();   
     
     headerInsFlag = false;
 }
 
 /**
 * getDetail()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-22
 * 개    요 :  디테일 리스트 조회
 * return값 : void
 */
 function getDetail(){

    flag = false;
    
    
    var strBizType  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE")
    var strSlipFlag = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG");
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strBizType="+encodeURIComponent(strBizType)+
                     "&strSlipFlag="+encodeURIComponent(strSlipFlag);
    
    TR_MAIN.Action="/dps/pord214.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
 //   GR_DETAIL.SetColumn("APP_S_DT");   디테일 그리드가 변해서 그리드가 깜빡거림
 //   GR_DETAIL.Focus();  
    detailOrgGridCount = DS_IO_DETAIL.CountRow;
 }
 
 /**
  * saveMaster()
  * 작 성 자 : 
  * 작 성 일 : 2010-02-23
  * 개    요 : 마스터 저장처리
  * return값 : void
  */
 function saveMaster() {

     strGCount = 0;
     headerInsFlag = false;
//     alert("저장되나");
     TR_S_MAIN.Action="/dps/pord214.po?goTo=saveMaster&strFlag=saveMaster"; 
     TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
     TR_S_MAIN.Post();   

     getMaster();
 }
 
 /**
  * saveMaster()
  * 작 성 자 : 
  * 작 성 일 : 2010-02-23
  * 개    요 : 마스터 저장처리
  * return값 : void
  */
 function delMaster() {
      
    var checkBizType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE")
    var checkSlip    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG")
    var checkAppSDt  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT")
     
    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){      //신규행일경우
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
    }else{
        if(checkAppSDt == strToday){
            showMessage(INFORMATION, OK, "GAUCE-1000", "삭제할 수 없는 데이터 입니다.");
            return;
        }
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        
        TR_S_MAIN.Action="/dps/pord214.po?goTo=saveMaster&strFlag=deleMaster"; 
        TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
        TR_S_MAIN.Post();   
    }
 }
 
 /**
  * saveDetail()
  * 작 성 자 : 
  * 작 성 일 : 2010-02-23
  * 개    요 : 디테일 저장처리
  * return값 : void
  */

 function saveDetail() {
      
    //정합성 체크를 위한 카운트
    getDetailCount();

    var strAppSdt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT");
    if (DS_IO_DETAIL.IsUpdated){
        if(DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == 1){      
            if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"MAXDATE") >= strAppSdt){
            showMessage(INFORMATION, OK, "GAUCE-1000", "이미 적용시작일(" + strAppSdt + ") 이후로 등록된 건이 있습니다. 확인바랍니다.");
            getDetail();
            return; 
            }
        }
    }
  
    var strBizType   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "BIZ_TYPE");
    var strSlipFlag  = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_FLAG");
    
    //입력시
    var strAppSDt    = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT");   //입력된 현재 적용시작일
    var strAppEDt    = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT");   //기존에 있는 적용종료일을 위함
    var strPreAppEDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT");   //기존에 있는 적용시작일
    var strRowId     = DS_IO_MASTER.NameValue(DS_IO_DETAIL.RowPosition, "ROWID");      //기존에 있는 적용시작일
    strAppEDt        = setAppEDtDay(strAppEDt);                                  //(기존 적용종료일) = (현재적용시작일) - 1
    
    //수정시
    var strCurAppSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT");   //수정시에 변경된 적용시작일을 가져온다 
    strCurAppSDt     = setAppEDtDay(strCurAppSDt);                               //(기존 적용종료일) = (현재적용시작일) - 1                   
    
    var goTo        = "saveDetail" ; 
    var parameters  = "&strBizType="+encodeURIComponent(strBizType)
                    + "&strSlipFlag="+encodeURIComponent(strSlipFlag)
                    + "&strAppEDt="+encodeURIComponent(strAppEDt)
                    + "&strAppSDt="+encodeURIComponent(strAppSDt)
                    + "&strPreAppEDt="+encodeURIComponent(strPreAppEDt)
                    + "&strCurAppSDt="+encodeURIComponent(strCurAppSDt)
                    + "&strRowId="+encodeURIComponent(strRowId);
    
    TR_S_MAIN.Action= "/dps/pord214.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_S_MAIN.Post();
    
    btn_Search();
 } 
 
 /**
  * setDetailGrid()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-22
  * 개    요 :  디테일 리스트 입력 비활성화
  * return값 : void
  */
function setDetailGrid(flag){
          
    GR_DETAIL.ColumnProp("BIZ_TYPE", "Edit")        = "none";   
    GR_DETAIL.ColumnProp("SLIP_FLAG", "Edit")       = "none";   
    GR_DETAIL.ColumnProp("APP_S_DT", "Edit")        = flag;   
    GR_DETAIL.ColumnProp("ORD_REG_YN", "Edit")      = flag;   
    GR_DETAIL.ColumnProp("SM_CONF_YN", "Edit")      = flag;   
    GR_DETAIL.ColumnProp("STEAM_CONF_YN", "Edit")   = flag;   
    GR_DETAIL.ColumnProp("STR_CONF_YN", "Edit")     = flag;   
    GR_DETAIL.ColumnProp("BUYER_CONF_YN", "Edit")   = flag;   
    GR_DETAIL.ColumnProp("ACC_CONF_YN", "Edit")     = flag;   
    GR_DETAIL.ColumnProp("BTEAM_CONF_YN", "Edit")   = flag;   
    GR_DETAIL.ColumnProp("CHK_CONF_YN", "Edit")     = flag; 

}

/**
 * setDetailGrid()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-22
 * 개    요 :  디테일 리스트 입력 비활성화
 * return값 : void
 */
function setMasterGrid(flag){
     
   GR_MASTER.ColumnProp("BIZ_TYPE", "Edit")        = flag;   
   GR_MASTER.ColumnProp("SLIP_FLAG", "Edit")       = flag;   
   GR_MASTER.ColumnProp("APP_S_DT", "Edit")        = flag;   
   GR_MASTER.ColumnProp("ORD_REG_YN", "Edit")      = flag;   
   GR_MASTER.ColumnProp("SM_CONF_YN", "Edit")      = flag;   
   GR_MASTER.ColumnProp("STEAM_CONF_YN", "Edit")   = flag;   
   GR_MASTER.ColumnProp("STR_CONF_YN", "Edit")     = flag;   
   GR_MASTER.ColumnProp("BUYER_CONF_YN", "Edit")   = flag;   
   GR_MASTER.ColumnProp("ACC_CONF_YN", "Edit")     = flag;   
   GR_MASTER.ColumnProp("BTEAM_CONF_YN", "Edit")   = flag;   
   GR_MASTER.ColumnProp("CHK_CONF_YN", "Edit")     = flag;
}

 /**
  * addDetailRow()
  * 작 성 자     :박래형
  * 작 성 일     : 2010-02-22
  * 개    요        : 발주결재라인 등록위한  ROW 추가
  * return값 : void
  */
 function addDetailRow(){
    flag = true;

    if (DS_IO_DETAIL.IsUpdated){
        if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){ 
                  return false;
        }else {
          getDetail();
            return true;
        }
    }
    
    //기존데이터 수정 하지 못하게 하기 위함.
    for(var i = 1; i<=DS_IO_DETAIL.CountRow; i++){
        DS_IO_DETAIL.NameValue(1, "CHK_DATA")= 1; 
    }
    DS_IO_DETAIL.ResetStatus();


    //디테일 Row 추가
    DS_IO_DETAIL.InsertRow(1);  
    GR_DETAIL.SetColumn("APP_S_DT");
    GR_DETAIL.Focus();  

    //DETAIL 그리드 입력부 신규버튼 클릭시 초기값 셋팅
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "BIZ_TYPE_NM")    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE_NM"); //거래형태 명   
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "BIZ_TYPE")       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE");    //거래형태    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_FLAG_NM")   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG_NM");//전표구분 명
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SLIP_FLAG")      = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG");   //전표구분   
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_E_DT")       = '99991231';    //적용종료일 기본으로 셋팅    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ORD_REG_YN")     = 'Y';           //발주등록    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SM_CONF_YN")     = 'Y';           //SM확정    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STEAM_CONF_YN")  = 'Y';           //영업팀장확정    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CONF_YN")    = 'Y';           //점장확정    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "BUYER_CONF_YN")  = 'Y';           //바이어확정   
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "ACC_CONF_YN")    = 'Y';           //재무팀협의(확정)   
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "BTEAM_CONF_YN")  = 'Y';           //매입팀장확정
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHK_CONF_YN")    = 'Y';           //검품확정
    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHK_DATE")       = 0;  
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CHK_DATA")       = 0;    
    
    //기존데이터의 적용시작일이 오늘보다 크거나 같으면 기존 데이터 적용시작일+1, 아니면 내일 날짜로 셋팅
    if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition + 1, "APP_S_DT") >= strToday){ 
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT")   = setAddDate(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition + 1, "APP_S_DT"));    //적용시작일 = 이전적용시작일 + 1로 셋팅     
    }else{
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = strNextDay;
    }
    
    //행추가 이미지 비활성화 
    enableControl(IMG_ADD, false);         
 } 

 /**
* delDetailRow()
* 작 성 자 : 박래형
* 작 성 일 : 2010-02-22
* 개    요 : 디테일 행삭제
* return값 : void
*/
function delDetailRow(){

    if(DS_IO_DETAIL.NameValue(1, "APP_S_DT") <= strToday){
        showMessage(StopSign, OK, "USER-1000", "삭제할 수 없는 데이터 입니다.");
        return;
    }
    
    if(DS_IO_DETAIL.CountRow == 0){
       showMessage(INFORMATION, OK, "USER-1019");
       return;
    }
    //행삭제 되기전 기존데이터가 조건이 맞으면 수정가능할수 있게 
    if((DS_IO_DETAIL.NameValue(2, "APP_S_DT") > strToday) && (DS_IO_DETAIL.NameValue(2, "APP_E_DT") == '99991231')){
        DS_IO_DETAIL.NameValue(2, "CHK_DATA")= 0; 
        DS_IO_DETAIL.ResetStatus();            
    }
    
    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);  
    
    detailAftGridCount = DS_IO_DETAIL.CountRow;        //삭제후 디테일 카운트
    
    //행삭제시 이미지 셋팅
    enableControl(IMG_ADD, true);
    if((DS_IO_DETAIL.NameValue(1, "APP_S_DT") > strToday) && (DS_IO_DETAIL.NameValue(1, "APP_E_DT") == '99991231')){
        enableControl(IMG_DEL, true);  
    }else{
        enableControl(IMG_DEL, false); 
    }   

    if(detailOrgGridCount != detailAftGridCount){
        enableControl(IMG_ADD, false);     
        enableControl(IMG_DEL, false);      
    }else{
        enableControl(IMG_DEL, true);   
        DS_IO_DETAIL.ResetStatus();                 
    }
} 
  
 /**
  * setNextDay()
  * 작 성 자     :박래형
  * 작 성 일     : 2010-02-22
  * 개    요        : 시스템일자 +1을 정한다
  * return값 : strNextDay
  */
 function setNextDay(){
      
     var array_date = null;
     var strNextDay = null;
     array_date = addDate("d", 1, strToday).split("-");
     strNextDay = array_date[0] + array_date[1] + array_date[2];  
     return strNextDay;
 } 
 
 /**
  * setAppEDtDay(date)
  * 작 성 자     :박래형
  * 작 성 일     : 2010-02-22
  * 개    요        : 적용시작일 -1을 정한다.
  * return값 : strNextDay
  */
 function setAppEDtDay(date){
      
     var array_date = null;
     var strBeforeDay = null;
     array_date = addDate("d", -1, date).split("-");
     strBeforeDay = array_date[0] + array_date[1] + array_date[2];  
     return strBeforeDay;
 } 
 
 /**
  * setAddAppEDtDay(date)
  * 작 성 자     :박래형
  * 작 성 일     : 2010-02-22
  * 개    요        : 적용시작일 +1을 정한다.
  * return값 : strafterDay
  */
 function setAddAppEDtDay(date){
      
     var array_date = null;
     var strafterDay = null;
     array_date = addDate("d", +1, date).split("-");
     strafterDay = array_date[0] + array_date[1] + array_date[2];  
     return strafterDay;
 } 
 
 /**
  * setAddDate(date)
  * 작 성 자     :박래형
  * 작 성 일     : 2010-02-22
  * 개    요        : 입력일 +1을 정한다.
  * return값 : strNextDay
  */
 function setAddDate(date){
      
     var array_date = null;
     var strBeforeDay = null;
     array_date = addDate("d", 1, date).split("-");
     strBeforeDay = array_date[0] + array_date[1] + array_date[2];  
     return strBeforeDay;
 }
 
 /**
  * setMessageDate(date)
  * 작 성 자     :박래형
  * 작 성 일     : 2010-03-23
  * 개    요        : 날짜형식으로 반환(표시형식만).
  * return값 : strNextDay
  */
 function setMessageDate(date){
      
     var strYyyyMmDd = null;
     strYyyyMmDd = date.substring(0,4) + '/' + date.substring(4,6) + '/' + date.substring(6,8)
     return strYyyyMmDd;
 }

 /**
 * getMasterCount()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-07
 * 개    요 :  디테일 체크 카운트 조회
 * return값 : void
 */
 function getMasterCount(){
    
    var strBizType  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"BIZ_TYPE");
    var strSlipFlag = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SLIP_FLAG");
    
    var goTo       = "getMasterCount";    
    var action     = "O";     
    var parameters = "&strBizType="+encodeURIComponent(strBizType)+
                     "&strSlipFlag="+encodeURIComponent(strSlipFlag);
    
    TR_S_MAIN.Action="/dps/pord214.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_S_MAIN.Post();
 }

 /**
 * getDetailCount()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-07
 * 개    요 :  디테일 체크 카운트 조회
 * return값 : void
 */
 function getDetailCount(){
     
    var strBizType  = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"BIZ_TYPE");
    var strSlipFlag = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SLIP_FLAG");
    var strAppSDt   = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT");
    
    var goTo       = "getDetailCount";    
    var action     = "O";     
    var parameters = "&strBizType="+encodeURIComponent(strBizType)+
                     "&strSlipFlag="+encodeURIComponent(strSlipFlag)+
                     "&strAppSDt="+encodeURIComponent(strAppSDt);
    
    TR_C_MAIN.Action="/dps/pord214.po?goTo="+goTo+parameters;  
    TR_C_MAIN.KeyValue="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_C_MAIN.Post();
 }

 function checkAppDt(APP_S_DT){

     getDetailCount();
     
     //디테일 신규행만 데이터 수정 가능
        if (DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == 1){
            return true;
        }else if(APP_S_DT > strToday){
            if(DS_O_RESULT.NameValue(1,"MAXDATE") > APP_S_DT){
                return false;
            }
            return true;        
        }else{
            return false;
        }
 }

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

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  -------------------------------><!-- 달력 그리드 set -->

<!--  
<script language=JavaScript for=DS_IO_MASTER event=OnDataError()>
showMessage(INFORMATION, OK, "GAUCE-1007", DS_IO_MASTER.CountRow);


</script>
-->

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>   

    if(headerInsFlag){
//      alert("변경 내역이 ");
      if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){ 
    //      setFocusGrid(GR_MASTER, DS_IO_MASTER, strGCount, "BIZ_TYPE");   
          return false;
      }else {
    //      DS_IO_MASTER.DeleteRow(strGCount);
          DS_IO_MASTER.DeleteRow(row);
          headerInsFlag = false;
          strGCount = 0;
          return true;
      }
    }
//  headerInsFlag = false;
//  strGCount = 0;


    if (DS_IO_DETAIL.IsUpdated){
        if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){
            return false;
        }else {
            DS_IO_DETAIL.DeleteRow(row);
            headerInsFlag = false;
            return true;
        }
    } 


</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>

    if(row != 0)
        if(bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ROWID") != ""){
            getDetail();
        }
        
        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ROWID") != ""){
            if(inta <=1){  
                setPorcCount("SELECT", GR_MASTER);
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }   
        }        
     


    //마스터 신규행만 데이터 수정 가능
    if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){
           setMasterGrid("any");
           enableControl(IMG_ADD, false);
    }else{  
           setMasterGrid("none");
           enableControl(IMG_ADD, true);
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL event=CanRowPosChange(row)>   
/*   
    if (DS_IO_DETAIL.IsUpdated){
        if(showMessage(INFORMATION, YESNO, "GAUCE-1000", "변경된 내역이 있습니다. <br> 이동 하시겠습니까?") != 1 ){
            return false;
        }else {
            getDetail();
            enableControl(IMG_ADD, true);
            enableControl(IMG_ADD, true);
            return true;
        }
        return true;
    } 
*/         
</script>

<!-- 디테일 ROW 변경시 수정 여부를 판단한다. -->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
	if(DS_IO_DETAIL.RowStatus(row) == 1){
	    enableControl(IMG_DEL, true);       
    }else{
	    if(row == 1 && DS_IO_DETAIL.NameValue(row, "APP_S_DT") > strToday && DS_IO_DETAIL.NameValue(row, "APP_E_DT")=='99991231'){
	        enableControl(IMG_DEL, true);
	    }else{
	        enableControl(IMG_DEL, false);
		}
	}	
</script>


<script language=JavaScript for=DS_SLIP_FLAG event=onFilter(row)>
        switch (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE")) {
            case "1":
                return true;
                break;
            case "2":
                if (DS_SLIP_FLAG.NameValue(row,"CODE") == "A"||DS_SLIP_FLAG.NameValue(row,"CODE") == "B") return true
                else return false;
                break;
        }
</script>

 
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>

    //마스터의 적용시작일
    var str_App_S_Dt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT");
    var str_App_E_Dt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_E_DT");
    
    if(colid == "APP_S_DT"){
        if( isYYYYMMDD(str_App_S_Dt) == "" ){        
            showMessage(StopSign, OK, "USER-1007", "적용시작일");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = strNextDay;
            setFocusGrid(GR_MASTER, DS_IO_MASTER, row, "APP_S_DT");   
            return false;
        }
        
        if(str_App_S_Dt < strNextDay){     //적용시작일이 내일보다 작으면 안됨.
            showMessage(INFORMATION, OK, "USER-1076", strNextDay);
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT") = strNextDay;
            setFocusGrid(GR_MASTER, DS_IO_MASTER, row, "APP_S_DT");   
        }           
        
        if(str_App_E_Dt != "" && str_App_S_Dt >= str_App_E_Dt){     //적용시작일은 적용종료일보다 작아야 된다
            showMessage(INFORMATION, OK, "USER-1015");
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_S_DT") = strNextDay;
            
            GR_MASTER.SetColumn("APP_S_DT");  //BIZ_TYPE
            GR_MASTER.Focus();    
        }           
    }else if(colid == "BIZ_TYPE"){      //거래형태가 변하면
        if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE") == "1"){  //직매입이면
            DS_SLIP_FLAG.Filter();
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG") = "";
        }else{                                                              //특정이면
            DS_SLIP_FLAG.Filter();
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG") = "";
        }
    } 
    
    var dupRow = checkDupKey(DS_IO_MASTER, "BIZ_TYPE||SLIP_FLAG");
     if (dupRow > 0) {
         showMessage(INFORMATION, OK, "GAUCE-1007", DS_IO_MASTER.CountRow);
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SLIP_FLAG") = "";
         return;
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
    var str_App_S_Dt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT");     
    var str_App_E_Dt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "APP_E_DT");
    var str_Before_App_S_Dt = null;
    
    //한건 이상일때
    if(DS_IO_DETAIL.CountRow > 1){
        str_Before_App_S_Dt = DS_IO_DETAIL.NameValue(2, "APP_S_DT");        
    }
    
    
    if(colid == "APP_S_DT"){
        if( isYYYYMMDD(str_App_S_Dt) == "" ){
            showMessage(StopSign, OK, "USER-1007", "적용시작일");
            if (str_Before_App_S_Dt > strToday){
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = setAddDate(str_Before_App_S_Dt);
            }else{
                DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = strNextDay;
            }
            setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"APP_S_DT");
            GR_DETAIL.Focus();
            return;
        }else{
            if(str_Before_App_S_Dt > strToday){
                 if(str_App_S_Dt > str_Before_App_S_Dt){
                     return;
                 }else{
                     showMessage(INFORMATION, OK, "USER-1076", setMessageDate(str_Before_App_S_Dt));
                     DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = setAddDate(str_Before_App_S_Dt);
                     setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"APP_S_DT");   
                     return;
                 }
            }else{
                if(str_App_S_Dt <= strToday){
                    showMessage(INFORMATION, OK, "USER-1076", setMessageDate(strToday));
                    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = strNextDay;
                    setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"APP_S_DT");   
                    return;                     
                }
            }
        }
        if(str_App_E_Dt != "" && str_App_S_Dt >= str_App_E_Dt){     //적용시작일은 적용종료일보다 작아야 된다
            showMessage(INFORMATION, OK, "USER-1015");
            DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") = strNextDay;
            
            GR_DETAIL.SetColumn("APP_S_DT");  //BIZ_TYPE
            GR_DETAIL.Focus();    
        } 
    }    
    
    //디테일이 수정되면 행추가 이미지 비활성화
    if(DS_IO_DETAIL.RowStatus(1) == 1 || DS_IO_DETAIL.RowStatus(1) == 3){
        enableControl(IMG_ADD, false);
    }else{
        enableControl(IMG_ADD, true);       
    }    
</script>

<!-- 마스터 달력컨트롤 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
    openCal(GR_MASTER, row, colid);   //그리드 달력 
    
</script>

<!-- 디테일 달력컨트롤 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
    openCal(GR_DETAIL, row, colid);   //그리드 달력 
    
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<comment id="_NSID_"><object id="DS_O_STR_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_BIZ_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SLIP_FLAG"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_BIZ_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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

<comment id="_NSID_">
<object id="TR_C_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
    
	var obj   = document.getElementById("GR_DETAIL");
    
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
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="80">거래형태</th>
            <td>
                <comment id="_NSID_">
                    <object id=LC_O_BZ_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle">
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
    <td class="dot"></td>
  </tr>
  <tr>
     <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td>
                    <comment id="_NSID_">
                        <OBJECT id=GR_MASTER width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                        </OBJECT>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
        </table>
     </td>
  </tr>
  <tr valign="top">
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td class="dot"></td>
            </tr>
            <tr>
                <td class="right"><img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addDetailRow();" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delDetailRow();" />
                </td>
            </tr>
          <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                        <td>
                            <comment id="_NSID_">
                                <OBJECT id=GR_DETAIL width=100% height=410 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_IO_DETAIL">
                                </OBJECT>
                            </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
             </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr> 
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
