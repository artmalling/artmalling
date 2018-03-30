<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 단품엑셀업로드
 * 작 성 일 : 2010.03.29
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal5280.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품정보를 엑셀 업로드 한다
 * 이    력 :
 *        2010.03.29 (정진영) 신규작성
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
<title>단품 엑셀 업로드</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

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
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 200;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";



    // Input Data Set Header 초기화
    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_I_SEARCH_TMP.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    //탭초기화
    //initTab('TAB_MAIN');
    
    //그리드 초기화
    gridCreate1(); //규격단품
    
   
   //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    initComboStyle(ERR_FLAG,DS_ERR_FLAG, "CODE^0^30,NAME^0^140", 1, PK);
    
    getEtcCode("DS_ERR_FLAG" ,"D"   ,"P617"  ,"Y" );
    ERR_FLAG.index=0;
    getStore("DS_STR_CD", "Y", "", "N");  
	var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
	
	initEmEdit(EM_SALE_DT_S,                      "YYYYMM",                PK);   //시작일자
	EM_SALE_DT_S.alignment = 1;
    
    LC_STR_CD.BindColVal = strcd;
    initEmEdit(EM_FILS_LOC, "GEN^500", READ); //EXCEL경로
   //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;
    
    //조회후 결과표시 초기화
    setPorcCount("CLEAR");
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal528","DS_MASTER" );

    
    //setTimeout("EM_PUMBUN_CD.Focus();",50);
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            width=30  name="NO"     Edit=none sumtext="합계"             align=center</FC>'
                     + '<FC>id=SEL                 width=50  align=center             name="확인" EditStyle=CheckBox HeadCheckShow=true Edit={IF(PROC_FLAG="N","true","false")} </FC>'// Pointer=Hand
                     + '<FC>id=ORDERER_NM          width=90  align=left   Edit=none   name="주문처" </FC>'
                     + '<FC>id=PUMBUN_NAME         width=90  align=left   Edit=none   name="브랜드명" </FC>'
                     + '<FC>id=SALE_YM             width=90  align=left   Edit=none   name="매출월" </FC>'
                     + '<FC>id=ORDER_NO            width=90  align=left   Edit=none   name="주문번호"  </FC>'//EDIT="NUMBERIC"
                     + '<FC>id=ORDER_SEQ           width=90  align=left   Edit=none   name="주문순번" </FC>'
                     + '<FC>id=RECIEVER            width=90  align=left   Edit=none   name="수취인명"  </FC>'
                     + '<FC>id=PUCHASER            width=90  align=left   Edit=none   name="구매자명" </FC>'
                     + '<FC>id=PRODUCT_CD          width=150 align=left   Edit=none   name="상품번호" </FC>'
                     + '<FC>id=PRODUCT_NM          width=240 align=left   Edit=none   name="상품명" </FC>'
                     + '<FC>id=QTY                 width=90  align=left   Edit=none   name="수량" sumtext={subsum(QTY)} </FC>'
                     + '<FC>id=AMT                 width=90  align=left   Edit=none   name="판매금액" sumtext={subsum(AMT)} </FC>'
                     + '<FC>id=ERR_YN              width=50  align=center Edit=none   name="오류여부"   </FC>'//value={IF(ERR_CD="","N","Y")}
                     + '<FC>id=ERR_MSG             width=300 align=left   Edit=none   name="오류내용"   </FC>'//EditStyle="Combo" Data="'+errorMsgData+'"
                     + '<FC>id=CONF_FLAG           width=90  align=left   Edit=none   name="확정여부" EditStyle="Combo" Data="Y:확정,N:미확정" </FC>'
                     + '<FC>id=MAPPING_YN          width=90  align=left   Edit=none   name="전산매핑여부" EditStyle="Combo" Data="Y:확정,N:미확정" SHOW=FALSE </FC>'
                     + '<FC>id=SEQ_NO              width=90  align=left   Edit=none   name="데이터순번" SHOW=FALSE </FC>'
                     + '<FC>id=SAVECHECK           width=90  align=left   Edit=none   name="" SHOW=FALSE </FC>'//저장된 데이터인지 판단 
                     ;
                     
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    //합계표시
    GD_MASTER.ViewSummary = "1";   // view단 합계 
    GD_MASTER.DecRealData = true;
    
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
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 
	 DS_MASTER.ClearData();
    
    var strStrCd        = LC_STR_CD.BindColVal;         //점
    var strPlanYear     = EM_SALE_DT_S.text;         //계획년도
    var strErrYN        = ERR_FLAG.BindColval;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear)
                   + "&strErrYN="           +encodeURIComponent(strErrYN)
                   ;
    
    TR_MAIN.Action="/dps/psal528.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    
    
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    GD_MASTER.Focus();

    // 조회결과 Return
    setPorcCount("SELECT", DS_MASTER.CountRow); 
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2010-03-29
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
  
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 
    var strStrDt = EM_SALE_DT_S.text;
    var dataSetId = 'DS_MASTER';
    var grid = GD_MASTER;
    
    if( dataSetId.CountRow < 0){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        
        return;
    }
    if(strStrDt<varToMon){//DS_MASTER.NameValue(0,"RELEASE_DT")!
    	showMessage(INFORMATION, OK, "USER-1223"); 
    	return;
    }
    
   //var intRowCount   = DS_MASTER.CountRow;      
    
    var dataSet = eval(dataSetId);
    
    if(!DS_MASTER.IsUpdated){
	       showMessage(INFORMATION, OK, "USER-1002", "변경사항"); 
	       return;
	}
    
    var errRow = 0;
    for(var i=0; i<DS_MASTER.CountRow; i++){
    	
    	if(DS_MASTER.NameValue(i,"SAVECHECK")=="Y"){
    		showMessage(INFORMATION, OK, "USER-1225");//저장된 여부 체크
    		return;
    	}
    	
    } 
     //변경또는 신규 내용을 저장하시겠습니까?
    
    if( showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){
    	
    }
 	    var strStrCd=LC_STR_CD.BindColVal;
 	    var strStrDt=EM_SALE_DT_S.text;
 	    
 	    var goTo       = "save" ;    
 	    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
 	    			   + "&strStrDt="+encodeURIComponent(strStrDt)
 	                   ;
 	    
 	    TR_MAIN.Action="/dps/psal528.ps?goTo="+goTo+parameters;  
 	    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER="+dataSetId+")"; //조회는 O
 	    TR_MAIN.Post();
      
    // 정상 처리일 경우 초기화
    if( TR_MAIN.ErrorCode == 0){
    	clearAllItem();
    }
    //EM_PUMBUN_CD.Focus();
    //btn_Search(); 
} 

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-29
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	process();
}
/**
 * porcess()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭
 * return값 : void
 */
function process(){
	 var strStrDt=EM_SALE_DT_S.text;
	    // 저장할 데이터 없는 경우
	    if (!DS_MASTER.IsUpdated){
	       //저장할 내용이 없습니다
	       showMessage(EXCLAMATION, OK, "USER-1028");
	       return;
	    }
	    

	    if(!DS_MASTER.IsUpdated){
		       showMessage(INFORMATION, OK, "USER-1002", "변경사항"); 
		       return;
		}
	    
	    if(strStrDt<varToMon){//DS_MASTER.NameValue(0,"RELEASE_DT")!
	    	showMessage(INFORMATION, OK, "USER-1223");//확정 날짜 비교 
	    	return;
	    }
	    	for(var i=0; i<DS_MASTER.CountRow+1; i++){
		    	
		    	if(DS_MASTER.NameValue(i,"ERR_YN")=="Y"){
		    		showMessage(INFORMATION, OK, "USER-1224");//오류 사항 여부 체크 
		    		return;
		    	}
		    	if(DS_MASTER.NameValue(i,"SAVECHECK")!="Y"){
		    		showMessage(INFORMATION, OK, "USER-1058");//저장된 여부 체크
		    		return;
		    	}
		    	
		    	if(DS_MASTER.NameValue(i,"MAPPING_YN")=="Y"){
		    		showMessage(INFORMATION, OK, "USER-1227");//전산매핑 여부
		    		GD_MASTER.Focus();
		    		return;
		    	}
		    	
		    	if(DS_MASTER.NameValue(i,"CONF_FLAG")=="Y"){
		    		DS_MASTER.NameValue(i,"CONF_FLAG")="N";
		    	}else{
		    		DS_MASTER.NameValue(i,"CONF_FLAG")="Y";
		    	}
	    	
	    }
	   dataSetId = 'DS_MASTER';
	   grid = GD_MASTER;
	   strCheckType = 1;
	    
	   if( showMessage(STOPSIGN, YESNO, "USER-1024") == 1 ){
	    	
	    }
	     
	    // 2. 마감체크한다.
	    CloseCheck();
	    
	    // 3. 마감체크후 마감체크가 onSuccess일 경우에 저장을 실행한다.(TR_VALCHECK확인)
}

/**
 * CloseCheck()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 마감체크
 * return값 : void
 */
function CloseCheck(){
	 
	 var strStrCd=LC_STR_CD.BindColVal;
	 var strStrDt=EM_SALE_DT_S.text;
	    
	 var goTo       = "valCheck" ;    
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
	    			+ "&strStrDt="+encodeURIComponent(strStrDt)
	                ;
	 
     /* DS_I_SEARCH_TMP.ClearData();
     var strData = DS_MASTER.ExportData(1,DS_MASTER.CountRow, true );
     DS_I_SEARCH_TMP.ImportData(strData); */
     
     TR_VALCHECK.Action="/dps/psal528.ps?goTo="+goTo+parameters; 
     TR_VALCHECK.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O//DS_I_SEARCH_TMP
     TR_VALCHECK.Post(); 
     
     DS_MASTER.ClearData();
     
}

/**
 * addRow()
 * 작 성 자     :박래형
 * 작 성 일     : 2010-05-31
 * 개    요        : ROW 추가
 * return값 : void
 */
function addRow(){
	
}
 
/**
* delRow()
* 작 성 자 : 박래형
* 작 성 일 : 2010-05-31
* 개    요    : ROW 삭제
* return값 : void
*/
function delRow(){
	// 삭제 메세지 
   if(showMessage(Question, YESNO, "USER-1023") != 1)
       return;
   
   var intRowCount =  DS_MASTER.CountRow;
   for(var i=intRowCount; i >= 1; i--){
       if(DS_MASTER.NameValue(i, "SEL") == 'T'){
           DS_MASTER.DeleteRow(i);
       }
   }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/


/**
 * loadExcelData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function excelDown(){
	var href = document.getElementById("A_EXCEL_DOWN").href;
	var sampleUrl = "/dps/samplefiles/ONLINE_MONTH(Sample).xls";
  
    document.getElementById("A_EXCEL_DOWN").href = sampleUrl; 
	
}



/**
 * loadExcelData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
 function loadExcelData() {
		
	    
	   // 엑셀 파일명 초기화
	   INF_EXCELUPLOAD.Value = '';
	   //Fils Open창
	   INF_EXCELUPLOAD.Open();
	   
	   //loadExcelData 옵션처리
	   var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
	   if (strExcelFileName == "''")
	       return;

	   DS_MASTER.ClearData();
	   DS_CHKORGMST.ClearData(); 
	   var strStartRow = 1; //시작Row
	   var strEndRow = 0; //끝Row
	   var strReadType = 0; //읽기모드
	   var strBlankCount = 0; //공백row개수
	   var strLFTOCR = 0; //줄바꿈처리 
	   var strFireEvent = 1; //이벤트발생
	   var strSheetIndex = 1; //Sheet Index 추가
	   var strtrEtc = "1";//엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
	   var strtrcol = 0;//Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)
		
   
	   
	    var strOption = strExcelFileName
	        + "," + strStartRow + "," + strEndRow + "," + strReadType 
	        + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
	        + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
	    //Excel파일 DateSet에 저장               
	    DS_MASTER.Do("Excel.Application", strOption);
	    //DateSet에 저장 후  Excel Header ROW삭제(첫행)
	    //DS_MASTER.DeleteRow(1);
	   
	    //에러체크
	    errorState();

	    
	}
/**
* errorState()
* 작 성 자 : 박종은
* 작 성 일 : 2010.01.24
* 개     요 : 에러체크
* return값 :
*/
function errorState(){
   
    errorRow ="";
    errcnt = 0;
    errorchk();
    
}
/**
 * errorchk()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010.01.24
 * 개     요 : 에러체크
 * return값 :
 */
function errorchk(){
   
	 var j = 0;
	 var i = 0;
	
	   for(i=1; i <= DS_MASTER.CountRow; i++){
			var strStrCd           = LC_STR_CD.BindColVal;
			var strStrDt           = EM_SALE_DT_S.text;
		    var strOrdererNm       = DS_MASTER.NameValue(i,"ORDERER_NM");            
		    var strOrderNo         = DS_MASTER.NameValue(i,"ORDER_NO");
		    var strPumbunNm        = DS_MASTER.NameValue(i,"PUMBUN_NAME");
		    var strSaleYM          = strStrDt;//DS_MASTER.NameValue(i,"RELEASE_DT");                
		    var strOrderSeq        = DS_MASTER.NameValue(i,"ORDER_SEQ");
		    var strPumbunCd        = DS_MASTER.NameValue(i,"PRODUCT_CD");
	    	
		    DS_CHKORGMST.ClearData(); 
		    
	        var goTo        = "searchOrgMst";    
		    var action      = "O";     
		    var parameters  =						 
						        "&strOrdererNm="           +encodeURIComponent(strOrdererNm)
						      + "&strOrderNo="             +encodeURIComponent(strOrderNo) 
						      + "&strSaleYM="              +encodeURIComponent(strSaleYM) 
						      + "&strOrderSeq="            +encodeURIComponent(strOrderSeq) 
						      + "&strPumbunNm="            +encodeURIComponent(strPumbunNm)
						      + "&strStrDt="               +encodeURIComponent(strStrDt)
						      + "&strPumbunCd="            +encodeURIComponent(strPumbunCd)
					          + "&strStrCd="               +encodeURIComponent(strStrCd)
					          ; 

	            TR_MAIN.Action="/dps/psal528.ps?goTo="+goTo+parameters;  
	            TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKORGMST=DS_CHKORGMST)"; 
	            TR_MAIN.Post();
	            
	         
	        	DS_MASTER.NameValue(i,"SALE_YM")= strStrDt;
	            DS_MASTER.NameValue(i, "CONF_FLAG") = "N"//확정 기본값으로 N을 준다.
	            
	            /* if(DS_MASTER.NameValue(i,"ORDER_SEQ")==""){
	            	DS_MASTER.NameValue(i,"ERR_YN")="Y";
	            	DS_MASTER.NameValue(i,"ERR_MSG")="주문순번이 입력되지 않았습니다.";
	   	    	 
	   	    		 continue;
	   	       } */
	   	       if(DS_MASTER.NameValue(i,"QTY")==""){
	   	    		DS_MASTER.NameValue(i,"ERR_YN")="Y";
	   	    		DS_MASTER.NameValue(i,"ERR_MSG")="수량이 입력되지 않았습니다..";
	   		    	continue;
	   		   }
	   	       if(DS_MASTER.NameValue(i,"AMT")==""||DS_MASTER.NameValue(i,"AMT")=="0"||DS_MASTER.NameValue(i,"AMT")==0){
	   	    		DS_MASTER.NameValue(i,"ERR_YN")="Y";
	   	    		DS_MASTER.NameValue(i,"ERR_MSG")="금액이 입력되지 않았습니다.";
	   		    	continue;
	   		    	
	   		   }
		      
	          if( DS_CHKORGMST.NameValue(0,"ERR_CD")    == "001") {
	        	  DS_MASTER.NameValue(i,"ERR_YN") = "Y";
	        	  DS_MASTER.NameValue(i,"ERR_MSG")= "등록된 주문처가 아닙니다.";
	        	  continue;
	          }
	          if(DS_CHKORGMST.NameValue(0,"ERR_CD")     == "002") {
	        	  
		          	DS_MASTER.NameValue(i,"ERR_YN") = "Y";
		          	DS_MASTER.NameValue(i,"ERR_MSG")= "등록된 브랜드명이 아닙니다.";
		          	continue;
		      }
	          if( DS_CHKORGMST.NameValue(0,"ERR_CD")     == "003") {
	        	 
		          	DS_MASTER.NameValue(i,"ERR_YN") = "Y";
		          	DS_MASTER.NameValue(i,"ERR_MSG")= "등록된 데이타가 있습니다.";
		          	continue;
		      } 
	          
	         
	        	  DS_MASTER.NameValue(i,"ERR_YN") = "N";
	        	  
	          
	          
	   }
	    
}
/**
 * clearAllItem()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 모든 항목을 초기화한다.
 * return값 :
 */
function clearAllItem(){
	
    // 엑셀 파일명 초기화
    INF_EXCELUPLOAD.Value = '';
    EM_FILS_LOC.text = '';
    // 데이터셋 초기화
    DS_EXECL_LOAD.ClearData();

    DS_MASTER.ClearData();
    
    GD_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
    
    
}

/**
 * clickGridHeadCheck()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 그리드 헤더 클릭시 모든 로우 반영
 * return값 :
 */
function clickGridHeadCheck( dataSet, value){
	for( var i=1; i<=dataSet.CountRow; i++){
		dataSet.NameValue(i,"SEL") = value==1?"T":"F";
	}
}

-->
</script>
<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
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
<script language=JavaScript for=TR_VALCHECK event=onSuccess>
    for(i=0;i<TR_VALCHECK.SrvErrCount('UserMsg');i++) {
        if(TR_VALCHECK.SrvErrMsg('UserMsg',i) != "OK"){
            showMessage(INFORMATION, OK, "USER-1000", TR_VALCHECK.SrvErrMsg('UserMsg',i));
        }else{
        	//변경또는 신규 내용을 저장하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){    // validation 체크
            	TR_SAVE.Action="/dps/ppay527.pp?goTo=save&strFlag=save"; 
            	TR_SAVE.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
                
                searchSetWait("B"); // 프로그래스바
                
                TR_SAVE.Post();
                
                if(DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "SEL") == "F")
                    DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "SEL") = "";
                else
                    DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "SEL") = "F";
                
            }    
        }
    }
    
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_MASTER,bCheck);
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
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
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_ERR_FLAG" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_EXECL_LOAD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHECK_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEARCH_TMP" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_SKU"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FRESH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ASTYLE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_BSTYLE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHKORGMST" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_MASTER" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_VALCHECK" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 634px; top: 88px; width: 68px; height: 18px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=EM_PUMBUN_TYPE classid=<%=Util.CLSID_EMEDIT%>  
     style="position: absolute; left: 0; top: 0; width: 0; height: 0; visibility: hidden;">></object>
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=EM_SKU_TYPE classid=<%=Util.CLSID_EMEDIT%>  
     style="position: absolute; left: 0; top: 0; width: 0; height: 0; visibility: hidden;">></object>
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=EM_STYLE_TYPE classid=<%=Util.CLSID_EMEDIT%>  
     style="position: absolute; left: 0; top: 0; width: 0; height: 0; visibility: hidden;">></object>
</comment><script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
<!-- 
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="396" class="title">
      <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>
                      단품엑셀업로드
    </td>
    <td><table border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <table border="0" cellspacing="0" cellpadding="0">
            <tr>    
              <td><img src="/<%=dir%>/imgs/btn/del.gif" border="0"  id="IMG_BTN_DEL"  onclick="javascript:btn_del();" ></td>
              <td><img src="/<%=dir%>/imgs/btn/apply.gif" border="0" id="IMG_BTN_APPLY" onclick="javascript:btn_apply();" ></td>
            </tr>   
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
 -->
<div id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
                  <th width="70" class="point">점</th>
                  <td width="300"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                  <th class="point">매출월</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_SALE_DT_S)" align="absmiddle" />
                  </td>
                  <th width="70">오류구분</th>
                  <td width="150" >
                    <comment id="_NSID_">
                    <object id="ERR_FLAG" classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1 style="height:20; width:150">
                    	
					</object>
                    </comment><script> _ws_(_NSID_);</script> 
                  </td>     
            
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr>
        <td class="PT03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" >파일선택</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width=500 tabindex=1 align="absmiddle" ></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/file_search.gif" border="0"  id="IMG_FILE_SEARCH"  onclick="javascript:loadExcelData();" align="absmiddle" hspace="3">
              <a href="#" align="absmiddle" id=A_EXCEL_DOWN onClick="javascript:excelDown();">
                <img src="/<%=dir%>/imgs/btn/excel_down.gif" border="0" align="absmiddle" >
              </a>
            </td >
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <%-- 
  <tr align="right">
    <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td class="right">
             <img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addRow();" /> 
             <img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delRow();" />    
           </td>
         </tr>
      </table>
    </td>
  </tr>
   --%>
  <tr>
    <td  class="PT10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top">
          
          <div id=tab_page1 width="100%" >
            <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_MASTER width="100%" height=460 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_MASTER">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </div>
          
        </td>
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
