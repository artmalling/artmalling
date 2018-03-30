<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 재고실사일정관리
 * 작 성 일 : 2010.03.31
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk201.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 재고실사 일정을 관리한다.
 * 이    력 :
 *        2010.03.31 (이재득) 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var strFlag = "";
var btnSaveClick = false;
var strToday = '<%=Util.getToday("yyyyMMdd")%>'

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');    
    //그리드 초기화
    gridCreate1(); //마스터
    //gridCreate2(); //디테일
    
    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_O_STK_S_YM, "YYYYMM",  NORMAL); //실사년월FROM
    initEmEdit(EM_O_STK_E_YM, "YYYYMM",  NORMAL); //실사년월TO
    initTxtAreaEdit(TXT_O_BIGO, NORMAL);              //내용

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)   
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_I_STK_FLAG", "D", "P801", "N");

    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");
    getStore("DS_I_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk201","DS_IO_MASTER" );
    
    //화면로드시 False처리
    TXT_O_BIGO.Enable = false;    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"               width=30    align=center    edit="none"</FC>'
                     + '<FC>id=CHECK1        name="마감"             width=40    align=center   HeadCheckShow=false EditStyle=CheckBox  edit=none</FC>'
                     + '<FC>id=STR_CD        name="*점"              width=110    align=left     edit={IF(FLAG="", "true", if(SRVY_S_DT <= SYS_DATE , "false", if(CHECK1="F", "true", "false") ))}   EditStyle=Lookup   Data="DS_I_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=OLD_STR_CD    name="*점"              width=70    align=left     show="false"</FC>'
                     + '<FC>id=STK_YM        name="*실사년월"         width=110    align=center   EditStyle=Popup   Edit=Numeric  edit={IF(FLAG="", "true", if(SRVY_S_DT <= SYS_DATE , "false", if(CHECK1="F", "true", "false") ))}    Mask="XXXX/XX"</FC>'
                     + '<FC>id=STK_FLAG      name="*실사;재고구분"    width=100   align=left     edit={IF(FLAG="", "true", if(SRVY_S_DT <= SYS_DATE , "false", if(CHECK1="F", "true", "false") ))}  EditStyle=Lookup   Data="DS_I_STK_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=SRVY_DT       name="*실사일자"         width=130   align=center  EditStyle=Popup  edit={IF(FLAG="", "true", if(SRVY_S_DT <= SYS_DATE , "false", if(CHECK1="F", "true", "false") ))}  Mask="XXXX/XX/XX"</FC>'
                     + '<FG>                 name="*실사입력기간"'
                     + '<FC>id=SRVY_S_DT     name="시작일"            width=130    align=center  EditStyle=Popup  Edit=Numeric   edit={IF(FLAG="", "true", if(SRVY_S_DT <= SYS_DATE , "false", if(CHECK1="F", "true", "false") ))}   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=SRVY_E_DT     name="종료일"            width=130    align=center  EditStyle=Popup  Edit=Numeric   edit={IF(FLAG="", "true", if(SRVY_E_DT < SYS_DATE , "false", if(CHECK1="F", "true", "false") ))}   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=BIGO          name="적용내역"          width=100    align=center  edit=none  show="false"</FC>'
                     + '<FC>id=FLAG          name="EDIT구분"         width=90    align=center   show="false"</FC>'
                     + '<FC>id=SYS_DATE      name="SYSDATE"          width=90    align=center   show="false"</FC>'
                     + '</FG>'
                     + '<FG>                 name="*재고기준기간"'
                     + '<FC>id=STK_S_DT     name="시작일"            width=130    align=center  EditStyle=Popup  Edit=Numeric   edit={IF(FLAG="", "true", if(CHECK1="F", "true", "false"))}   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=STK_E_DT     name="종료일"            width=130    align=center  EditStyle=Popup  Edit=Numeric   edit={IF(FLAG="", "true", if(CHECK1="F", "true", "false"))}   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=LOSS_APP_DATE  name="LOSS반영일자"    width=130   align=center  EditStyle=Popup  edit={IF(FLAG="", "true", if(CHECK1 == "T" , "false", "true" ))}  Mask="XXXX/XX/XX"</FC>'
                     + '</FG>'
                     
                     
                     
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 일 : 2010.03.31
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
     
     //저장되지 않은 내용이 있을경우 경고
     if (DS_IO_MASTER.IsUpdated ) {
         ret = showMessage(QUESTION , YESNO, "USER-1059");
         if (ret != "1") {
             return false;
         } 
     } 
     
    if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }
    
    if(EM_O_STK_S_YM.Text > EM_O_STK_E_YM.Text){ // 조회일 정합성
    	if(EM_O_STK_E_YM.Text != ""){
    		showMessage(INFORMATION, OK, "USER-1015");
            EM_O_STK_E_YM.Text = EM_O_STK_S_YM.Text;
            EM_O_STK_S_YM.Focus();
            return false;    		
    	}
    }
    
    DS_IO_MASTER.ClearData();    

    var strStrCd   = LC_O_STR_CD.BindColVal;
    
    var strStkSYm   = EM_O_STK_S_YM.Text;
    var strStkEYm   = EM_O_STK_E_YM.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkSYm="+encodeURIComponent(strStkSYm)
                    +"&strStkEYm="+encodeURIComponent(strStkEYm);    
    
    TR_MAIN.Action="/dps/pstk201.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);
    setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
    //데이타 조회시 결과값이 없으면 False 처리
    if (DS_IO_MASTER.CountRow == 0){
    	TXT_O_BIGO.Text = "";
        TXT_O_BIGO.Enable = false;
    }
    
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
	 for(var i = 1; i <= DS_IO_MASTER.CountRow; i++ ) {
         var strFlag = DS_IO_MASTER.NameValue(i, "FLAG");         
            if( DS_IO_MASTER.RowStatus(i) == 1 && strFlag == ""){
                // 신규데이터 입력은 1건만 가능합니다.
                showMessage(INFORMATION, OK, "USER-1078");
                setFocusGrid(GD_MASTER, DS_IO_MASTER, i, "STR_CD");
                return ;
            }
        }
     
     DS_IO_MASTER.Addrow();
     setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STR_CD");
	/*
    if( DS_IO_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 신규추가하시겠습니까?)        
        if(showMessage(QUESTION , YESNO, "USER-1050")!=1){ 
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
            return;         
        }else{
            DS_IO_MASTER.UndoAll(); 
            DS_IO_MASTER.ClearData();            
            DS_IO_MASTER.Addrow();            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STR_CD");
        }
    }else{      
        DS_IO_MASTER.ClearData();        
        DS_IO_MASTER.Addrow();        
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STR_CD");
    }
	*/
    
	//신규등록시 True 처리
    TXT_O_BIGO.Text = "";
    TXT_O_BIGO.Enable = true;
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    if (DS_IO_MASTER.CountRow == 0)
        return;
    
    var srvySDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SRVY_S_DT");
    var srvyEDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SRVY_E_DT");
    //ToDay 조회
    var strToDay = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SYS_DATE");
   
    //재고조사기간 조회
    if (srvyEDt < strToDay){
        showMessage(EXCLAMATION , OK, "USER-1026", "","과거재고실사");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
        return;
    }else if (strToDay >= srvySDt || strToDay >= srvyEDt){
        showMessage(EXCLAMATION , OK, "USER-1026", "","재고조사기간에");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
        return;
    }
    
    //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1023") != 1 ){
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
        return;
    }
    
    // 신규입력이있을 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FLAG").length == 0){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        return;
    }  
        
    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);     
    TR_MAIN.Action="/dps/pstk201.pt?goTo=delete";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){        
        btn_Search();       
    }    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {	 
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028");
        return;
    }  
    
    if (!checkValidation()){
        return;
    }
    
    if (!checkDateValidation()){        
        return;
    }  
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        LC_O_STR_CD.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
        return;
    
    //중복된 데이터 체크 
    //var retChk  = checkDupKey(DS_IO_MASTER, "STR_CD||STK_YM");
    
    //if (retChk != 0) {
    //    showMessage(Information, OK, "USER-1044",retChk);
    //    setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
    //    return;
    //}
    
    var strStrCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"OLD_STR_CD");
    var strBigo = TXT_O_BIGO.Text;
    
    //if( !checkInputByte(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "BIGO", "공지내역", ''))
        //return;
    
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd);
    
    btnSaveClick = true;
    TR_MAIN.Action="/dps/pstk201.pt?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    btnSaveClick = false;
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * checkDateValidation()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 날짜 형식 및 기간 체크
  * return값 : void
  */
 function checkDateValidation(){
    if(!checkDateTypeYM(GD_MASTER, "STK_YM", '')){    	
        var value = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YM")
        return false;
    }else if(!checkDateTypeYMD(GD_MASTER, "SRVY_DT", '')){   
        var value = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_DT")
        return false;
    }else if(!checkDateTypeYMD(GD_MASTER, "SRVY_S_DT", '')){    	
        var value = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_S_DT")
        return false;
    }else if(!checkDateTypeYMD(GD_MASTER, "SRVY_E_DT", '')){    	
    	var value = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_E_DT")
        return false;
    }   
    
    var srvySDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SRVY_S_DT");
    var srvyEDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SRVY_E_DT");
    //ToDay 조회
    var strToDay = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SYS_DATE");
    
    var strSrvyDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_DT");
    
    // MARIO OUTLET
    /*
    //날짜 Check(재고조사일 <=재고조사 입력시작일)
    if (!isBetweenFromTo(strSrvyDt, srvySDt)){        
        showMessage(EXCLAMATION , Ok,  "USER-1008", "시작일", "실사일자");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_S_DT");
        return false;
    }
  
    //날짜 Check(재고조사 입력시작일<=재고조사 입력종료일)
    if (!isBetweenFromTo(srvySDt, srvyEDt)){    	
        showMessage(EXCLAMATION , Ok,  "USER-1015");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_E_DT");
        return false;
    } 
    */
    
    // MARIO OUTLET
    if (!(srvySDt<= strSrvyDt && srvyEDt>=strSrvyDt)) {
        showMessage(EXCLAMATION , Ok,  "GAUCE-1000", "실사 일자는 실사 입력 기간에 포함되어 있어야 합니다.");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_S_DT");
        return false;
    }
    
    
    if(strToday.substring(0, 6) > DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STK_YM")){    	
    	showMessage(EXCLAMATION , Ok,  "USER-1020", "실사년월", "현재년월");
        DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YM") = "";
        setFocusGrid(GD_MASTER,DS_IO_MASTER.RowPosition,"STK_YM");
        return false;
    }
    
    var stkSDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STK_S_DT");
    var stkEDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STK_E_DT");
    
    //날짜 Check
    if (!isBetweenFromTo(stkSDt, stkEDt)){    	
        showMessage(EXCLAMATION , Ok,  "USER-1015");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_E_DT");
        return false;
    }
    
    /*
    if (strToDay >= srvySDt || strToDay >= srvyEDt){
        showMessage(EXCLAMATION , Ok,  "USER-1030", "실사입력기간");
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_S_DT");
        return false;
    }
    */
    return true;
}
 /*************************************************************************/
 /**
  * checkValidation()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : validation 체크
  * return값 : void
  */
 function checkValidation(){
     if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STR_CD") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STR_CD");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STK_YM") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사년월");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_YM");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STK_FLAG") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사재고구분");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_FLAG");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SRVY_DT") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사일자");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_DT");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SRVY_S_DT") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "시작일");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_S_DT");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SRVY_E_DT") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "종료일");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SRVY_E_DT");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STK_S_DT") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "시작일");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_S_DT");
            return false;
        }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STK_E_DT") == "" ){
            showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "종료일");            
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_E_DT");
            return false;
        }
     return true;
  }
 
 /**
  * checkOverLap()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : validation 체크
  * return값 : void
  */
 function checkOverLap(row){
	  var strToDay = DS_IO_MASTER.OrgNameValue(row,"SYS_DATE").substring(0,6);	  
     var orgStkYm = DS_IO_MASTER.OrgNameValue(row,"STK_YM");
     var newStkYm = DS_IO_MASTER.NameValue(row,"STK_YM");
     if (orgStkYm == newStkYm){
    	 return true;
     }
     if (newStkYm < strToDay){
    	 showMessage(EXCLAMATION , Ok,  "USER-1017", newStkYm );
         DS_IO_MASTER.NameValue(row, "STK_YM") = orgStkYm;
     }
     
     if (strFlag == "")
         orgStkYm = ""; 
     
     if (orgStkYm != newStkYm){
         var strStrCd   = DS_IO_MASTER.NameValue(row,"STR_CD");      
         var strStkYm   = DS_IO_MASTER.NameValue(row,"STK_YM");     
         var goTo       = "searchOverLap" ;    
         var action     = "O";     
         var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                         +"&strStkYm="+encodeURIComponent(strStkYm);    
            
         TR_MAIN.Action="/dps/pstk201.pt?goTo="+goTo+parameters;  
         TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_OVERLAP=DS_IO_OVERLAP)"; //조회는 O
         TR_MAIN.Post();
         
         if (DS_IO_OVERLAP.NameValue(1, "CNT") > 0 ){
             showMessage(EXCLAMATION , Ok,  "USER-1044");
             DS_IO_MASTER.NameValue(row, "STK_YM") = "";
             setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"STK_YM");
             return false;
         } 
     }  
     return true;
  }
 
 /**
  * checkSrvyDt()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 실사년도와 실사일자  체크
  * return값 : void
  */
 function checkSrvyDt(row){
     var strStkYm = DS_IO_MASTER.NameValue(row, "STK_YM") ;
     var strSrvyDt = DS_IO_MASTER.NameValue(row, "SRVY_DT").substring(0,6);
     var strOrgSrvyDt = DS_IO_MASTER.OrgNameValue(row, "SRVY_DT")
     
     if (strSrvyDt != strStkYm){
         showMessage(EXCLAMATION , Ok,  "USER-1089", "실사년월", "실사일자년월");
         DS_IO_MASTER.NameValue(row, "SRVY_DT") = strOrgSrvyDt;
         setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"SRVY_DT");
         return false;
     }
     return true;
  }
 
 /**
  * checkSrvySDt()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 실사시작일자  체크
  * return값 : void
  */
 function checkSrvySDt(row){	  
     var strSrvySDt = DS_IO_MASTER.NameValue(row, "SRVY_S_DT") ;
     var strSrvyEDt = DS_IO_MASTER.NameValue(row, "SRVY_E_DT") ;
     var strSrvyDt = DS_IO_MASTER.NameValue(row, "SRVY_DT");
     var strOrgSrvySdt = DS_IO_MASTER.OrgNameValue(row, "SRVY_S_DT") ;
     
     // ! (실사입력시작일<= 실사일자 && 실사일자  <== 실사입력종료일)
     if (!(strSrvySDt <= strSrvyDt &&  strSrvyDt <= strSrvyEDt)){
         showMessage(EXCLAMATION , Ok,  "USER-1020", "실사시작일자", "실사일자");
         DS_IO_MASTER.NameValue(row, "SRVY_S_DT") = strOrgSrvySdt;
         setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"SRVY_S_DT");
         return false;
     }
     return true;
  }
 
 /**
  * checkSrvyEDt()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 실사일자와 실사시작일자  체크
  * return값 : void
  */
 function checkSrvyEDt(row){      
     var strSrvySDt = DS_IO_MASTER.NameValue(row, "SRVY_S_DT") ;
     var strSrvyEDt = DS_IO_MASTER.NameValue(row, "SRVY_E_DT") ;
     var strSrvyDt = DS_IO_MASTER.NameValue(row, "SRVY_DT");
     var strOrgSrvydt = DS_IO_MASTER.OrgNameValue(row, "SRVY_DT") ;
     if (strSrvySDt != ""){
         // ! (실사입력시작일<= 실사일자 && 실사일자  <== 실사입력종료일)
         if (!(strSrvySDt <= strSrvyDt &&  strSrvyDt <= strSrvyEDt)){
             showMessage(EXCLAMATION , Ok,  "USER-1021", "실사일자", "실사시작일자");
             DS_IO_MASTER.NameValue(row, "SRVY_DT") = strOrgSrvydt;
             setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"SRVY_DT");
             return false;
         } 
     }
     
     return true;
  }
 
 /**
  * checkSrvySDt()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 시작일 종료일  체크
  * return값 : void
  */
 function checkSEDt(row){      
     var strSrvySDt = DS_IO_MASTER.NameValue(row, "SRVY_S_DT") ;
     var strSrvyEDt = DS_IO_MASTER.NameValue(row, "SRVY_E_DT");
     var strOrgSrvydt = DS_IO_MASTER.OrgNameValue(row, "SRVY_E_DT") ;
     
     if (strSrvyEDt != ""){
    	 if (!(strSrvyEDt >= strSrvySDt) || strSrvyEDt==""){
             showMessage(EXCLAMATION , Ok,  "USER-1020", "실사종료일", "실사시작일");
             DS_IO_MASTER.NameValue(row, "SRVY_E_DT") = strOrgSrvydt;
             setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"SRVY_E_DT");
             return false;
         }
     }
     
     return true;
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
<script language=JavaScript for=DS_IO_MASTER
    event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(STOPSIGN, OK, "GAUCE-1007", row);
} else {
    showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 실사년월FROM -->
<script language=JavaScript for=EM_O_STK_S_YM event=onKillFocus()>
    if(!this.Modified)
        return;
    //if (this.Text.length > 4){
        if(!checkDateTypeYM(this)){
            this.Text = '';
            return;
        }  
   // }
    
</script>

<!-- 실사년월TO -->
<script language=JavaScript for=EM_O_STK_E_YM event=onKillFocus()>
    if(!this.Modified)
        return;
    //if (this.Text.length > 4){
        if(!checkDateTypeYM(this)){
            this.Text = '';
            return;
        }  
    //}
    
</script>

<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>  

/*
    if(row < 1)
        return true;
    
    switch(colid){
    case "STK_YM":
        if (DS_IO_MASTER.NameValue(row, "STK_YM") == ""){
        	DS_IO_MASTER.NameValue(row, "STK_YM") = DS_IO_MASTER.OrgNameValue(row, "STK_YM");
            return true;
        }
        
        if(!checkDateTypeYM(this,colid,'')){
            return false; 
        }else if(!checkOverLap(row)){
                return false;
        }  
        var strToDay = strToday.substring(0, 6);
        
        var strStkYm = DS_IO_MASTER.NameValue(row, "STK_YM");
        
        if(strToDay > strStkYm){
        	showMessage(EXCLAMATION , Ok,  "USER-1020", "실사년월", "현재년월");
        	DS_IO_MASTER.NameValue(row, "STK_YM") = "";
        	setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"STK_YM");
        	return true;
        }
        break;
    case "SRVY_DT":
        if (DS_IO_MASTER.NameValue(row, "SRVY_DT") == "" ){
        	DS_IO_MASTER.NameValue(row, "SRVY_DT") = DS_IO_MASTER.OrgNameValue(row, "SRVY_DT");
        	 return true;
        }
           
        if(!checkDateTypeYMD(this,colid,''))
            return false;
        if(!checkSrvyDt(row)){
        	return;
        }else if(!checkSrvyEDt(row)){
            return;
        }
            
        break;    
    case "SRVY_S_DT":
        if (DS_IO_MASTER.NameValue(row, "SRVY_S_DT") == ""){
        	DS_IO_MASTER.NameValue(row, "SRVY_S_DT") = DS_IO_MASTER.OrgNameValue(row, "SRVY_S_DT");
        	return true;
        }
            
        if(!checkDateTypeYMD(this,colid,''))
            return false;
        if(!checkSrvySDt(row))
            return;
        break;  
        
    case "STK_S_DT":
        if (DS_IO_MASTER.NameValue(row, "STK_S_DT") == ""){
        	DS_IO_MASTER.NameValue(row, "STK_S_DT") = DS_IO_MASTER.OrgNameValue(row, "STK_S_DT");
        	return true;
        }
            
        if(!checkDateTypeYMD(this,colid,''))
            return false;
        if(!checkSrvySDt(row))
            return;
        break;  

    // LOSS 반영일자
    case "LOSS_APP_DATE":
    	
    	if (DS_IO_MASTER.NameValue(row, "LOSS_APP_DATE") != "") {
	    	if (DS_IO_MASTER.NameValue(row, "SRVY_DT") > DS_IO_MASTER.NameValue(row, "LOSS_APP_DATE")){
	    		showMessage(EXCLAMATION, Ok,  "GAUCE-1000", "LOSS 반영일자는 실사일자 보다 크거나 같아야 합니다."); 
	        	DS_IO_MASTER.NameValue(row, "LOSS_APP_DATE") = "";
	        	setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"LOSS_APP_DATE");
	        	return false;
	    	}
    	}
        break;
        
*/
        
        
        /*
    case "SRVY_E_DT":
        if (DS_IO_MASTER.NameValue(row, "SRVY_E_DT") == ""){
            return true;
        }
            
        if(!checkDateTypeYMD(this,colid,''))
            return false;
        if(!checkSEDt(row))
            return false;
        break; 
        
    }
*/
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)> 
    if(row < 1)
        return true;
    
    switch(colid){
    case "SRVY_E_DT":    	
        if (DS_IO_MASTER.NameValue(row, "SRVY_E_DT") == ""){        	
        	DS_IO_MASTER.NameValue(row, "SRVY_E_DT") = DS_IO_MASTER.OrgNameValue(row, "SRVY_E_DT");
        	return true;  
        }       
            
        if(!checkDateTypeYMD(GD_MASTER,colid,''))        	
        	return false;       
            
        if(!checkSEDt(row))        	
        	return;
        
        break; 
    
    // LOSS 반영일자
    case "LOSS_APP_DATE":
    	if (DS_IO_MASTER.NameValue(row, "LOSS_APP_DATE") != "") {
	    	if (DS_IO_MASTER.NameValue(row, "SRVY_DT") > DS_IO_MASTER.NameValue(row, "LOSS_APP_DATE")){
	    		showMessage(EXCLAMATION, Ok,  "GAUCE-1000", "LOSS 반영일자는 실사일자 보다 크거나 같아야 합니다."); 
	        	DS_IO_MASTER.NameValue(row, "LOSS_APP_DATE") = "";
	        	setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"LOSS_APP_DATE");
	        	return false;
	    	}
    	}
        break;
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) {
    case "STK_YM":
        openCal(GD_MASTER, row, colid, "M");   //그리드 달력    
        break;
    case "SRVY_DT":  
    case "SRVY_S_DT":  
    case "SRVY_E_DT":
    case "STK_S_DT" :
    case "STK_E_DT" :
    case "LOSS_APP_DATE" :
        openCal(GD_MASTER, row, colid, "G");   //그리드 달력    
        break;
    
    	
} 
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if( row > 0 ) {        
    var strFlag = DS_IO_MASTER.NameValue(row , "FLAG"); 
    var strToDay = DS_IO_MASTER.NameValue(row , "SYS_DATE"); 
    var orgSrvyEDt = DS_IO_MASTER.OrgNameValue(row,"SRVY_E_DT"); 
    var strCheck = DS_IO_MASTER.NameValue(row , "CHECK1"); 
    
    if ((orgSrvyEDt >= strToDay || strFlag == "") && strCheck == "F"){
    	        TXT_O_BIGO.Enable = true;
    }else
        TXT_O_BIGO.Enable = false;
    return;
}
 
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
    if( btnSaveClick || row < 1)
        return true;
    
    var strFlag = DS_IO_MASTER.NameValue(row , "FLAG"); 
    if (DS_IO_MASTER.IsUpdated  && strFlag == "") {
        ret = showMessage(QUESTION , YESNO, "USER-1074");
        if (ret != "1") {
            return false;
        }
        DS_IO_MASTER.UndoAll();
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
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STK_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_OVERLAP" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80" class="point">점</th>
                        <td width="165"><comment id="_NSID_"> <object id=LC_O_STR_CD
                            classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="80">실사년월</th>
                        <td colspan = "3"><comment id="_NSID_"> <object
                            id=EM_O_STK_S_YM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                            onclick="javascript:openCal('M',EM_O_STK_S_YM)" align="absmiddle" />
                        ~<comment id="_NSID_"> <object
                            id=EM_O_STK_E_YM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                            onclick="javascript:openCal('M',EM_O_STK_E_YM)" align="absmiddle" /></td>
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
        <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=298 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_MASTER">
                </object></comment><script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>                        
                        <th width="400">비고</th>                        
                    </tr>
                    <tr>
                        <td>
                            <comment id="_NSID_">
                                <object id=TXT_O_BIGO classid=<%=Util.CLSID_TEXTAREA%> height=167 
                                        onkeyup="javascript:textAreaMaxlength(TXT_O_BIGO, 2000);"
                                        onkeyDown="javascript:textAreaMaxlength(TXT_O_BIGO, 2000);"
                                        onkeyPress ="javascript:textAreaMaxlength(TXT_O_BIGO, 2000);" width=800 tabindex=1 > 
                                </object>
                            </comment>
                            <script>_ws_(_NSID_);</script></td>

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
<object id=BO_MASTER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c>col=BIGO     ctrl=TXT_O_BIGO        param=Text </c>             
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

