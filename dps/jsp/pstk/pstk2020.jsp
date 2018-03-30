<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 인정LOSS율등록관리
 * 작 성 일 : 2010.04.04
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk202.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 인정LOSS율등록을 관리한다.
 * 이    력 :
 *        2010.04.04 (이재득) 작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strToday = '<%=Util.getToday("yyyyMMdd")%>'
 
 /**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top  = 100;		//해당화면의 동적그리드top위치

function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_TEMP.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_O_STK_YYYY,    "THISYR",    PK);     //실사년월
    initEmEdit(EM_O_PUMBUN_CD,   "CODE^6^0",  NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME, "GEN^40",    NORMAL); //브랜드명
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)   
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_COST_CAL_WAY", "D", "P039", "N");

    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk202","DS_IO_MASTER" );
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}           name="NO"              width=30     align=center    edit=none</FC>'    	             
                     + '<FC>id=PUMBUN_CD          name="*브랜드코드"        width=140   align=center    edit={IF(STR_CD="","true","false")}   EditStyle=Popup</FC>'
                     + '<FC>id=PUMBUN_NAME        name="브랜드명"           width=200   align=left      edit=none</FC>'
                     + '<FC>id=COST_CAL_WAY       name="재고평가구분"     width=140   align=left      edit=none    EditStyle=Lookup   Data="DS_O_COST_CAL_WAY:CODE:NAME"</FC>'
                     + '<FC>id=STK_YYYY           name="*적용년도"        width=140   align=center    Edit=Numeric   edit={IF(STR_CD="","true","false")}</FC>'
                     + '<FC>id=APP_LOSS_RATE      name="인정LOSS율(%)"    width=130   align=right     </FC>'                     
                     + '<FC>id=STR_CD             name="점"               width=100   show="false"    </FC>';
                   
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
 * 작 성 일 : 2010.04.04
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
    DS_IO_MASTER.ClearData();    

    var strStrCd      = LC_O_STR_CD.BindColVal;    
    var strStkYyyy    = EM_O_STK_YYYY.Text;
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strPumbunName = EM_O_PUMBUN_NAME.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYyyy="+encodeURIComponent(strStkYyyy)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strPumbunName="+encodeURIComponent(strPumbunName);    
    
    TR_MAIN.Action="/dps/pstk202.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER); 
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {	 
	 /*
	 for(var i = 1; i <= DS_IO_MASTER.CountRow; i++ ) {
		 var strStrCd = DS_IO_MASTER.NameValue(i, "STR_CD");		 
	        if( DS_IO_MASTER.RowStatus(i) == 1 && strStrCd == ""){
	            // 신규데이터 입력은 1건만 가능합니다.
	            showMessage(INFORMATION, OK, "USER-1078");
	            setFocusGrid(GD_MASTER, DS_IO_MASTER, i, "PUMBUN_CD");
	            return ;
	        }
	    }
	 */
	 DS_IO_MASTER.Addrow();
     setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMBUN_CD");

 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	//선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1023") != 1 ){
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"PUMBUN_CD");
        return;
    }
	
    // 신규입력이있을 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD").length == 0){
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        return;
    } 
    
    var strStrCd   = LC_O_STR_CD.BindColVal;
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd);  
    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);  
    
    TR_MAIN.Action="/dps/pstk202.pt?goTo=delete"+parameters;
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
 * 작 성 일 : 2010.04.04
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
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_I_SKU_NAME.Focus();
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
    var strStrCd = LC_O_STR_CD.BindColVal;
    
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd);    
    
    TR_MAIN.Action="/dps/pstk202.pt?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }else{
    	setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"PUMBUN_CD");
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * setPumbunCode()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : 브랜드 팝업을 실행한다.
  * return값 : void
 **/
 function setPumbunCode(evnFlag){
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
     
     if( evnFlag == 'POP'){
    	 strPbnPop(codeObj,nameObj,'Y');  
    	 searchPbnmst(codeObj);
         codeObj.Focus();
         return;
     }

     if( codeObj.Text ==""){
         return;
     }
     
     setStrPbnNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj ,'Y', '0'); 
     
     searchPbnmst(codeObj);  
 }
 
 /**
  * searchPbnmst()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-04
  * 개    요 : 브랜드 정보를 조회한다.
  * return값 : void
 **/

 function searchPbnmst(pbnCdObj) {
      var pumbunCd = pbnCdObj.Text;      
      if( pumbunCd.length != 6 )
          return;
      
      // 브랜드 정보 조회 popup_dps.js
      getPumbunInfo("DS_SEARCH_NM", pumbunCd);
      
      if ( DS_SEARCH_NM.countRow != 1  ){
          showMessage(EXCLAMATION, OK, "USER-1000", "브랜드 정보가 존재하지 않습니다.");
          EM_PUMBUN_CD.Text = "" ;
          EM_PUMBUN_NAME.Text = "" ;     
          return;
      }
      
      if( !(DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='1'
                 || DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='2')){
          showMessage(EXCLAMATION, OK, "USER-1000", "거래형태는 ['직매입','특정매입']만 가능합니다.");
          EM_O_PUMBUN_CD.Text = "" ;
          EM_O_PUMBUN_NAME.Text = "" ;
      }
 }
 
 /**
  * setPumbunCode()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : Grid브랜드 팝업을 실행한다.
  * return값 : void
 **/
 function setGridPumbunCode(evnFlag, row){
      
     var strCode = DS_O_MASTER.NameValue(row,"PUMBUN_CD");
     var strName = DS_O_MASTER.NameValue(row,"PUMBUN_NAME");
     
     if( evnFlag == 'POP'){
    	 strPbnToGridPop(strCode,strName,'Y');  
         searchPbnmst(strCode);
         strCode.Focus();
         return;
     }

     if( strCode.Text ==""){
         return;
     }
     
     setStrPbnNmWithoutPop("DS_SEARCH_NM", strCode, strName ,'Y', '0');
   
 }
 
 /**
  * searchPbnmst()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-04
  * 개    요 : Grid브랜드 정보를 조회한다.
  * return값 : void
 **/
function searchGridPbnmst(pbnCd, row) {   
      var pumbunCd = pbnCd;
      if( pumbunCd.length != 6 )
          return;
      
      // 브랜드 정보 조회 popup_dps.js
      getPumbunInfo("DS_SEARCH_NM", pumbunCd);
      
      if ( DS_SEARCH_NM.countRow != 1  ){
          showMessage(EXCLAMATION, OK, "USER-1000", "브랜드 정보가 존재하지 않습니다.");
          DS_IO_MASTER.NameValue(row, "PUMBUN_CD") = ""; 
          DS_IO_MASTER.NameValue(row, "PUMBUN_NAME") = ""; 
          DS_IO_MASTER.NameValue(row, "COST_CAL_WAY") = ""; 
          
          return;
      }
      
      if( !(DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='1'
                 || DS_SEARCH_NM.NameValue(1, "BIZ_TYPE")=='2')){
          showMessage(EXCLAMATION, OK, "USER-1000", "거래형태는 ['직매입','특정매입']만 가능합니다.");
          DS_IO_MASTER.NameValue(row, "PUMBUN_CD") = ""; 
          DS_IO_MASTER.NameValue(row, "PUMBUN_NAME") = ""; 
          DS_IO_MASTER.NameValue(row, "COST_CAL_WAY") = ""; 
          
          return;
      }
      
      getCostCalWay(pumbunCd);
 }
 
 /**
  * checkValidation()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : validation 체크
  * return값 : void
  */
 function checkValidation(){
	 if( LC_O_STR_CD.BindColVal == "%" || LC_O_STR_CD.BindColVal == ""){
	        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
	        LC_O_STR_CD.Focus;
	        return false;
	    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PUMBUN_CD") == "" ){
	        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "브랜드코드");            
	        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMBUN_CD");
	        return false;
	    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "PUMBUN_NAME") == "" ){
	        showMessage(EXCLAMATION , Ok,  "USER-1036", "브랜드코드");            
	        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"PUMBUN_CD");
	        return false;
	    }else if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STK_YYYY") == "" ){
	        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "적용년도");            
	        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_YYYY");
	        return false;
	    }
	 
	 for( var i = 1 ; i <= DS_IO_MASTER.CountRow; i++){
		 if( DS_IO_MASTER.NameValue( i, "APP_LOSS_RATE") != "0" ){
			 var appLossRate = DS_IO_MASTER.NameValue( i, "APP_LOSS_RATE");
			 
			 if (appLossRate > 100){
				 showMessage(EXCLAMATION , Ok,  "USER-1009", "인정LOSS율", "100%");
				 DS_IO_MASTER.NameValue( i, "APP_LOSS_RATE")= DS_IO_MASTER.OrgNameValue( i, "APP_LOSS_RATE");
				 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"APP_LOSS_RATE");
				 return false;
			 }else if (appLossRate < 0){
				 showMessage(EXCLAMATION , Ok,  "USER-1008", "인정LOSS율", "0%");
				 DS_IO_MASTER.NameValue( i, "APP_LOSS_RATE")= DS_IO_MASTER.OrgNameValue( i, "APP_LOSS_RATE");
				 setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"APP_LOSS_RATE");
				 return false;
			 }
		 }
	 }
	    
	 //Grid 날짜 유효성 체크
	 var strStkYyyy     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YYYY");
	 if(strStkYyyy.length < 4 && strStkYyyy.length != 0){
	     showMessage(EXCLAMATION , OK, "USER-1000", "입력하신 '"+strStkYyyy+"'는 유효하지 않는 날짜형식입니다.");
	     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YYYY") = getTodayFormat("YYYY");
	     setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STK_YYYY");
	     return false;
	 }
     return true;
  }
  
 /**
  * getCostCalWay()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 재고평가구분 조회
  * return값 : void
  */
 function getCostCalWay(strPumbunCd){
	 var strStrCd      = LC_O_STR_CD.BindColVal;    
	
	 //var strPumbunCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
	
	 var goTo       = "searchCostCalWay" ;    
	 var action     = "O";     
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)	                    
	                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd);    
	    
	    TR_MAIN.Action="/dps/pstk202.pt?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_COSTCALWAY=DS_IO_COSTCALWAY)"; //조회는 O
	    TR_MAIN.Post();
	    
	    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COST_CAL_WAY")= DS_IO_COSTCALWAY.NameValue(1 , "COST_CAL_WAY");
  }
 
 /**
  * checkOverLap()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-01
  * 개    요 : 중복 체크
  * return값 : void
  */
 function checkOverLap(row){
     var strStrCd    = LC_O_STR_CD.BindColVal;  
     var strPumbunCd = DS_IO_MASTER.NameValue(row,"PUMBUN_CD"); 
     var strStkYyyy  = DS_IO_MASTER.NameValue(row,"STK_YYYY");     
     var goTo        = "searchOverLap" ;    
     var action      = "O";     
     var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                      +"&strStkYyyy="+encodeURIComponent(strStkYyyy);    
        
     TR_MAIN.Action="/dps/pstk202.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_OVERLAP=DS_IO_OVERLAP)"; //조회는 O
     TR_MAIN.Post();
     
     if (DS_IO_OVERLAP.NameValue(1, "CNT") > 0 ){
         showMessage(EXCLAMATION , Ok,  "USER-1044");
         DS_IO_MASTER.NameValue(row, "STK_YYYY") = "";
         setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"STK_YYYY");
         return false;
     }
     return true;
  }
 
 
 
 
 
 function btn_Copy(){
 	
	
	
	if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }   
    
	if( EM_O_STK_YYYY.Text == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사년도");            
        EM_O_STK_YYYY.Focus();
        return false;
    }
	 
	 
	if(!CopyCheck()){
 		return false;
 	} 
 	
	 
	DS_IO_MASTER.ClearData(); 
	
 	var strStrCd    = LC_O_STR_CD.BindColVal;  
    var strStkYyyy  = EM_O_STK_YYYY.Text;     
    var goTo        = "copy" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)
                     +"&strStkYyyy="+encodeURIComponent(strStkYyyy);    
    
    DS_IO_TEMP.Addrow();
    
    TR_MAIN.Action="/dps/pstk202.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_TEMP=DS_IO_TEMP)"; //조회는 O
    TR_MAIN.Post();
    
    btn_Search();
    
	
 }
 /**
  * checkCopyFrom()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개    요    : 체크
  * return값 : void
  */
 function CopyCheck(){
    
	 if (DS_IO_MASTER.IsUpdated ) {
	    ret = showMessage(QUESTION , YESNO, "USER-1000","변경 된 내역이 존재합니다.<br>복사 하시겠습니까?");
	    if (ret != "1") {
	        return false;
	    } 
	 }
	  
	 var strStrCd    = LC_O_STR_CD.BindColVal;  
     var strStkYyyy  = EM_O_STK_YYYY.Text;     
     var goTo        = "searchCopyCheck" ;    
     var action      = "O";     
     var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYyyy="+encodeURIComponent(strStkYyyy);    
        
     TR_MAIN.Action="/dps/pstk202.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CHECK=DS_O_CHECK)"; //조회는 O
     TR_MAIN.Post();
     
     if (DS_O_CHECK.NameValue(1, "CNT1") < 1 ){
    	 // 전년도 정보없음
         showMessage(EXCLAMATION , Ok,  "USER-1000","전년도 정보가 존재하지 않습니다.");
    	 return false;
     }
     
     if (DS_O_CHECK.NameValue(1, "CNT2") > 0 ){
    	 // 당해년도 정보존재함
         showMessage(EXCLAMATION , Ok,  "USER-1000","실사년도 정보가 존재합니다.<br>삭제 후 작업하십시요.");
    	 return false;
     }
     
     return true;
  }

 
 /**
  * setPumbunCodeToGridMulti()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-04
  * 개    요 : 브랜드명을 등록한다.(Grid, 다중)
  * return값 : void
  */
 function setPumbunCodeToGridMulti(evnflag, row){
	 
	 var code  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
     var strCd = LC_O_STR_CD.BindColVal;
     if( code == "" && evnflag != "POP" ){
    	 DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
    	 DS_IO_MASTER.NameValue(row, "COST_CAL_WAY") = "";
    	 DS_IO_MASTER.NameValue(row, "STK_YYYY") = "";
    	 DS_IO_MASTER.NameValue(row, "APP_LOSS_RATE") = 0.00;
    	 return;     
     }
     var rtnMap = null;
     if( evnflag == "POP" ){
         rtnMap = strPbnMultiSelPop(code,'','Y','', strCd, '','','','','Y');
     }else if( evnflag == "NAME" ){
    	 DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
    	 DS_IO_MASTER.NameValue(row, "COST_CAL_WAY") = "";
    	 DS_IO_MASTER.NameValue(row, "STK_YYYY") = "";
    	 DS_IO_MASTER.NameValue(row, "APP_LOSS_RATE") = 0.00;
         rtnMap = setStrPbnNmWithoutToGridPop("DS_O_PUMBUN_CD",code,'',"Y",'1','', strCd, '','','','','Y');
         
     }    
     if( rtnMap != null){
    	 if(evnflag == "NAME"){
    		 DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
    		 DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
    		 searchGridPbnmst(rtnMap.get("PUMBUN_CD"),row);
    		 //getCostCalWay(rtnMap.get("PUMBUN_CD"));
             
    	 }else{
    		 var total = rtnMap.length;
    		 if(total < 1){
    	         if( DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
    	        	 DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = "";
    	         }
    	         return;
    		 }
    		 
    		 for( var i=0; i<total; i++){
    			 
    			 if( i!=0){
    			 	 DS_IO_MASTER.AddRow();
    			 }
    			 
    			 DS_IO_MASTER.NameValue(row+i,"PUMBUN_CD")   = rtnMap[i].PUMBUN_CD;
    			 DS_IO_MASTER.NameValue(row+i,"PUMBUN_NAME") = rtnMap[i].PUMBUN_NAME;
                 searchGridPbnmst(rtnMap[i].PUMBUN_CD,row+i);
    		 }
    	 }
     }else{
         if( DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
        	 DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = "";
         }
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
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
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_YYYY event=onKillFocus()>
    if(!this.Modified)
	    return;
    if(this.Text.length < 4 && this.Text.length != 0){
        showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+this.Text+"'는 유효하지 않는 날짜형식입니다.");
        EM_O_STK_YYYY.Text = getTodayFormat("YYYY");
        EM_O_STK_YYYY.Focus();        
        return;
    }else if( EM_O_STK_YYYY.Text == "" ){
        showMessage(StopSign, Ok,  "GAUCE-1005", "실사년도");
        EM_O_STK_YYYY.Text = getTodayFormat("YYYY");
        EM_O_STK_YYYY.Focus();
        return;
    }
</script>
<script language=JavaScript for=GD_MASTER
	event=CanColumnPosChange(row,colid)>   
    var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue = DS_IO_MASTER.NameValue(row,colid);
    var changeFlag = (orgValue != newValue || DS_IO_MASTER.RowStatus(row) == 1) ;
    var strCd = LC_O_STR_CD.BindColVal;
    
    switch (colid) {
        case "PUMBUN_CD" :               
            if( changeFlag ){            	
                eval(this.DataID).NameValue(row,"PUMBUN_NAME") = "";
                eval(this.DataID).NameValue(row,"COST_CAL_WAY") = "";
                if(newValue == ''){
                    return false;
                }
                var popupData = setStrPbnNmWithoutToGridPop("DS_O_PUMBUN_CD",newValue,'','Y','1','', strCd, '','','','','Y');
                if(popupData != null){
                	var strPumbunCd = popupData.get("PUMBUN_CD");
                    eval(this.DataID).NameValue(row,"PUMBUN_CD") = strPumbunCd;
                    eval(this.DataID).NameValue(row,"PUMBUN_NAME") = popupData.get("PUMBUN_NAME"); 
                    searchGridPbnmst(strPumbunCd, row);
                    
                }else {
                    eval(this.DataID).NameValue(row,"PUMBUN_NAME") = "";
                    eval(this.DataID).NameValue(row,"COST_CAL_WAY") = "";
                }
            }
            break;
    }  
    return true;
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>     
    if(row < 1)
        return true;
    
    switch(colid){
    case "APP_LOSS_RATE" :               
        //if( DS_IO_MASTER.NameValue( row, "APP_LOSS_RATE") != "0" ){            
            var appLossRate = DS_IO_MASTER.NameValue( row, "APP_LOSS_RATE");
            if (appLossRate > 100){
                showMessage(EXCLAMATION , Ok,  "USER-1009", "인정LOSS율", "100%");
                DS_IO_MASTER.NameValue( row, "APP_LOSS_RATE")= DS_IO_MASTER.OrgNameValue( row, "APP_LOSS_RATE");
                setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"APP_LOSS_RATE");
                return false;
            }else if (appLossRate < 0){
                showMessage(EXCLAMATION , Ok,  "USER-1008", "인정LOSS율", "0%");
                DS_IO_MASTER.NameValue( row, "APP_LOSS_RATE")= DS_IO_MASTER.OrgNameValue( row, "APP_LOSS_RATE");
                setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"APP_LOSS_RATE");
                return false;
            }
            return true;
        //}
        break; 
    }
    return true;
</script>


<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
var newValue = DS_IO_MASTER.NameValue(row,colid);
var changeFlag = (orgValue != newValue || DS_IO_MASTER.RowStatus(row) == 1) ;
    switch (colid) {
        case "PUMBUN_CD" :  
        	setPumbunCodeToGridMulti('POP', row);
            break;   
    }
</script>

<!-- 
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
var newValue = DS_IO_MASTER.NameValue(row,colid);
var changeFlag = (orgValue != newValue || DS_IO_MASTER.RowStatus(row) == 1) ;
    switch (colid) {
        case "PUMBUN_CD" :  
        	//setGridPumbunCode('POP', row);
        	var popupData = strPbnToGridPop(data, '', 'Y');
            if(popupData != null){
            	var strPumbunCd = popupData.get("PUMBUN_CD");
                eval(this.DataID).NameValue(row,"PUMBUN_CD") = strPumbunCd;
                eval(this.DataID).NameValue(row,"PUMBUN_NAME") = popupData.get("PUMBUN_NAME");
                searchGridPbnmst(strPumbunCd, row);
                //getCostCalWay(strPumbunCd);
            } //else {
              //  eval(this.DataID).NameValue(row,"PUMBUN_CD") = "";
              //  eval(this.DataID).NameValue(row,"PUMBUN_NAME") = "";
              //  eval(this.DataID).NameValue(row,"COST_CAL_WAY") = "";
            //}
            break;   
    }
</script>
-->

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    setPumbunCode('NAME');    
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<object id="DS_O_COST_CAL_WAY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_IO_COSTCALWAY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_OVERLAP" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_TEMP" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>

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
						<th width="50" class="point">점</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="50" class="point">실사년도</th>
						<td width="70"><comment id="_NSID_"> <object
							id=EM_O_STK_YYYY classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> 
						<th width="50">브랜드</th>
						<td><comment id="_NSID_"> <object id=EM_O_PUMBUN_CD
							classid=<%= Util.CLSID_EMEDIT %> width=50 tabindex=1 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: setPumbunCode('POP');"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_PUMBUN_NAME classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						    <img src="/<%=dir%>/imgs/btn/btn_copyData.gif"
               			onclick="btn_Copy();" class="PR03" align="absmiddle"  />	
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
		<td class="PT10">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=498 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BO_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c></c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

