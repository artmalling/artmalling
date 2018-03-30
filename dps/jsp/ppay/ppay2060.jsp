<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 선지불/보류/공제 > 공제등록
 * 작 성 일 : 2010.05.31
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : ppay2060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공제등록
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
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
	strToMonth = strToMonth + "01";
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
<!--

var strToday        = "";                            // 현재날짜
var strYYYYMMDD       = "";                            // 현재년월

var roundFlag       = "";                            // 반올림구분
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

     strToday  = getTodayDB("DS_O_RESULT");
     strYYYYMMDD = strToday;

     // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>' );
     DS_O_PAY_CNT.setDataHeader('CODE:STRING(2),NAME:STRING(40)'   );
     DS_SETVAT.setDataHeader   ('<gauce:dataset name="H_SETVAT"/>' );
     
     //그리드 초기화
     gridCreate1(); //마스터
     GR_MASTER.TitleHeight="30"; 
     // EMedit에 초기화
     
     
     initEmEdit(EM_SALE_DT       ,"YYYYMMDD"  ,READ  		 );        // 매입기간 시작일
     
     
    

     //콤보 초기화
     
     initComboStyle(LC_STR_CD,DS_IO_STR_CD    			,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 점(조회)
     getStore  ("DS_IO_STR_CD"    ,"Y"   ,""      ,"N" );   
     
     

     LC_STR_CD.index  = 0;
     EM_SALE_DT.text = strYYYYMMDD;
     
     btn_Search();
     
 }
 
 
 function gridCreate1(){
	 
     var hdrProperies = '<FC>id={currow}     name="NO"               titleheight=60 width=30   align=center</FC>'
                      + '<FC>id=SEL          name="선택"             width=50      align=center EditStyle=CheckBox  HeadCheckShow="true" Edit={IF(CONF_FLAG="Y","false","true")}</FC>'   
                      + '<FC>id=STR_CD       name="*점"              width=90      align=left   EditStyle=Lookup   Data="DS_IO_STR_CD:CODE:NAME"</FC>'   
                      + '<FC>id=SALE_DT      name="*매출일자"        width=80      align=center Edit=none Mask="XXXX/XX/XX" </FC>'   
                      + '<FC>id=PUMBUN_CD    name="*브랜드코드"      width=70      align=center EditStyle=Popup</FC>'
                      + '<FC>id=PUMBUN_NM    name="브랜드명"         width=120     align=left   Edit=none</FC>'
                      + '<FC>id=PUMMOK_CD    name="*품목코드"        width=70      align=center </FC>'
                      + '<FC>id=PUMMOK_NM    name="품목명"           width=120     align=left   Edit=none</FC>'
                      + '<FC>id=SEQ          name="순번"             width=50      align=center Edit=none </FC>'
                      + '<FC>id=TRAN_FLAG    name="매출구분"         width=120     align=left   EditStyle=Combo		Data="0:매출,1:반품" Edit={IF(CONF_FLAG="Y","false","true")}</FC>'
                      + '<FC>id=SALE_AMT     name="*매출금액"        gte_columntype="number:0:true" gte_Summarytype="number:0:true"          width=100   align=right  Edit={IF(CONF_FLAG="N","true","false")} sumtext={SUM(SALE_AMT)} </FC>'   
                      + '<FC>id=SALE_CNT     name="*객수"            gte_columntype="number:0:true" gte_Summarytype="number:0:true"          width=100   align=right  Edit={IF(CONF_FLAG="N","true","false")} sumtext={SUM(SALE_CNT)} </FC>'
                      + '<FC>id=CONF_FLAG    name="확정구분"         width=120     align=left  show=false </FC>';   
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
     
     
     GR_MASTER.ViewSummary =	"1";   // view단 합계 
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
  * 작 성 자     : 박래형
  * 작 성 일     : 2010-05-31
  * 개    요        : 조회시 필수 조회조건을 체크한 후 조회한다.
  * return값 : void
  */
 function btn_Search() {
      // 변경, 추가내역이 있을 경우
      if (DS_IO_MASTER.IsUpdated){
          if( showMessage(STOPSIGN, YESNO, "USER-1073") != 1 )
             return;
      }
     
      
          DS_IO_MASTER.ClearData();  
          // 조회조건 셋팅
          var strStrCd         = LC_STR_CD.BindColVal;                  // 점
          var strSale_dt       = EM_SALE_DT.text;                 

          getMaster("DS_IO_MASTER",strStrCd, strSale_dt);
          GR_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
          
          // 조회결과 Return
          setPorcCount("SELECT", GR_MASTER);
          GR_MASTER.SetColumn("SEL");
          GR_MASTER.Focus();
      
 }

 /**
  * getMaster(strStrCd, strYYYYMMDD, strPayCyc, strPayCnt, strVenCd)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요   : 마스터를 조회한다.
  * return값 : void
  */
function getMaster(dataSet, strStrCd, strSale_dt){
	var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSale_dt="+encodeURIComponent(strSale_dt)     
                    ;
    				
    TR_MAIN.Action  = "/dps/ppay206.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER="+dataSet+")"; // 조회는 O
    TR_MAIN.Post();    
} 
 
 
 

 
/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-08
 * 개    요 : 신규 추가
 * return값 : void
 */
function btn_New() {
	 
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : 삭제
 * return값 : void
 */
function btn_Delete() {
/*	
    // 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") != 1)
        return;    
    var intRowCount =  DS_IO_MASTER.CountRow;
    var intDelCnt   = 0;
    for(var i=intRowCount; i >= 1; i--){
        if(DS_IO_MASTER.NameValue(i, "SEL") == 'T'){
        	if(DS_IO_MASTER.RowStatus(i) == "1"){
        		DS_IO_MASTER.DeleteRow(i);
        	}else{
        		DS_IO_MASTER.DeleteRow(i);
        		intDelCnt++;
        	}        		
        }
    }       
    if(intDelCnt > 0){
	    var params = "&strFlag=delete" ;
	    
	    TR_MAIN.Action="/dps/ppay206.pp?goTo=save"+params; 
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    TR_MAIN.Post();	    
	    btn_search();
    }
    GR_MASTER.ColumnProp('SEL','HeadCheck')= "false";   //그리드 CHEKCBOX헤더 체크해제   
*/
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(StopSign, OK, "USER-1028");
       return;
    }

    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){
	 	
        TR_MAIN.Action="/dps/ppay206.pp?goTo=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }      
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-08
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if(DS_IO_MASTER.CountRow <= 0){
	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	        return;
	    }
	    var strTitle = "공제 등록";
	    
    var strStrCd         = LC_STR_CD.BindColVal;                  // 점
    //var strPayCyc        = LC_PAY_CYC.BindColVal;                 // 지불주기
    var strPayCnt        = LC_PAY_CNT.BindColVal;                 // 지불회차
    var strVenCd         = EM_S_VEN_CD.Text;                      // 협력사코드
    var strPumCd         = EM_S_PUMBUN_CD.Text;                   // 브랜드코드
    var strSaleSdt       = EM_SALE_DT.Text;
    var strSaleEdt       = EM_SALE_E_DT.Text;
	    
	    var parameters = "점 "           + strStrCd
			        + " ,   매출년월 " + strYYYYMMDD
			        + " ,   지불주기 " + strPayCyc
			        + " ,   지불회차 " + strPayCnt
			        + " ,   매출기간 " + strSaleSdt 
			        + " ~ " + strSaleEdt
			        + " ,   협력사 "   + strVenCd
			        + "     브랜드 "   + strPumCd;
	    
	    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GR_MASTER, strTitle, parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-08
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

function process(){
	 var strStrDt=EM_SALE_DT.text;
	    // 저장할 데이터 없는 경우
	    if (!DS_IO_MASTER.IsUpdated){
	       //저장할 내용이 없습니다
	       showMessage(EXCLAMATION, OK, "USER-1028");
	       return;
	    }
	    

	    if(!DS_IO_MASTER.IsUpdated){
		       showMessage(INFORMATION, OK, "USER-1002", "변경사항"); 
		       return;
		}
	    
	    
	    if( showMessage(STOPSIGN, YESNO,  "USER-1000","매출등록 하시겠습니까?") == 2 ){
	    	return;
	    }
		//var strStrCd=LC_STR_CD.BindColVal;
		//var strStrDt=EM_SALE_DT_S.text;
		   
		var goTo       = "valCheck" ;    
		var parameters = "";
		
		  /*  DS_I_SEARCH_TMP.ClearData();
		   var strData = DS_MASTER.ExportData(1,DS_MASTER.CountRow, true );
		   DS_I_SEARCH_TMP.ImportData(strData); */
		   
		   TR_VALCHECK.Action="/dps/ppay206.pp?goTo=valCheck"+parameters; 
		   TR_VALCHECK.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O//DS_I_SEARCH_TMP
		   TR_VALCHECK.Post(); 
		   btn_Search();
			    
	    
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * addRow()
  * 작 성 자     :박래형
  * 작 성 일     : 2010-05-31
  * 개    요        : ROW 추가
  * return값 : void
  */
 function addRow(){
	  
          DS_IO_MASTER.AddRow();

          //포커스 셋팅
          GR_MASTER.SetColumn("PUMBUN_CD");
          GR_MASTER.Focus();
          
          //초기값 셋팅
          //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VAT_YN")    = "Y";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CONF_FLAG")     = "N";          
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") 		= LC_STR_CD.BindColVal;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_DT") 		= EM_SALE_DT.Text;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMMOK_CD") 	= "7141";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMMOK_NM") 	= "샵윈도";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TRAN_FLAG") 	= "0";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_CNT") 		= "1";
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SEQ") 		    = DS_IO_MASTER.COUNTROW;
          
      
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
	/*
    if(showMessage(Question, YESNO, "USER-1023") != 1)
        return;
    
    var intRowCount =  DS_IO_MASTER.CountRow;
    for(var i=intRowCount; i >= 1; i--){
        if(DS_IO_MASTER.NameValue(i, "SEL") == 'T'){
            DS_IO_MASTER.DeleteRow(i);
        }
    }
    */
    
    if(DS_IO_MASTER.CountRow < 1){
		showMessage(INFORMATION, OK, "USER-1019");
        return;		
	}

	if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1){
		DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);		
        return;
    }   
    showMessage(INFORMATION, OK, "USER-1052");
    
    
    
    
 }

 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
	 
     var strStrCd        = LC_STR_CD.BindColVal;  
     var strUseYn        = "Y";                             // 사용여부
     var strPumBunType   = "";                              // 브랜드유형
     var strBizType      = "";                              // 거래형태
     var strMcMiGbn      = "";                              // 매출처/매입처구분
     var strBizFlag      = "";                              // 거래구분
    
     if(!btnFlag){
         var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                 ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                 ,strBizFlag);
     }else{
//         alert("btnFlag = " + btnFlag);
         var rtnMap = venPop(code, name
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
     }
    
 }
  /**
  * getPopGridVenInfo()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 :  그리드협력사 팝업
  * return값 : void
  */
   
  
  function getPopGridVenInfo(strVenCd, strVenNm, check){
	  
     var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");   // 점
     var strUseYn        = "Y";                                                          // 사용여부
     var strPumBunType   = "";                                                           // 브랜드유형
     var strBizType      = "";                                                           // 거래형태
     var strMcMiGbn      = "";                                                           // 매출처/매입처구분
     var strBizFlag      = "";                                                           // 거래구분

     var rtnMap = venToGridPop(strVenCd, ''
                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                          ,strBizFlag);
     if(rtnMap != null){
    	 DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD") = "";
    	 DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_NM") = "";
    	 if(check==1){
         	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = rtnMap.get("VEN_CD");
         	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = rtnMap.get("VEN_NAME");
         
         	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_CD") = rtnMap.get("VEN_CD");         
         	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_NM") = rtnMap.get("VEN_NAME");
         	return true;
    	 }else if(check==2){
    		 DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_CD") = rtnMap.get("VEN_CD");         
             DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_NM") = rtnMap.get("VEN_NAME");
         	return true;
    	 }
     }else{ 
         return false;
     }
 } 
  

 /** 그리드협력사 넌팝업
  * getNonPopGridVenInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 :  그리드협력사  넌팝업
  * return값 : void
  */
 function getNonPopGridVenInfo(){
     
     var strVenCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD" );
     var strVenNm        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM" );
     var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD" );    // 점
     var strUseYn        = "Y";                                                           // 사용여부
     var strPumBunType   = "";                                                            // 브랜드유형
     var strBizType      = "";                                                            // 거래형태
     var strMcMiGbn      = "";                                                            // 매출처/매입처구분
     var strBizFlag      = "";                                                            // 거래구분

     var rtnMap = setVenNmWithoutToGridPop( "DS_O_RESULT", strVenCd, '', "1"
                                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                         ,strBizFlag);
     if(rtnMap != null){
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = rtnMap.get("VEN_CD");
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = rtnMap.get("VEN_NAME"); 
         
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_CD") = rtnMap.get("VEN_CD");         
      	 DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_NM") = rtnMap.get("VEN_NAME");
         return true;
     }else{
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = "";    
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = "";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_CD") = "";
      	 DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DED_VEN_NM") = "";
         return false;
     }      
}

 

 /**
  * setPumbunCodeToGrid()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-04
  * 개    요 : 브랜드명을 등록한다.(Grid)
  * return값 : void
  */
 function setPumbunCodeToGrid(evnflag, row){
     var PUM_CD  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
     var PUM_NM = DS_IO_MASTER.NameValue(row,"PUMBUN_NM");
	 var STR_CD = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD")
	 var VEN_CD = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD")
	 var rtnMap = rtnMap = strPbnToGridPop( PUM_CD, PUM_NM, 'Y' ,'' , STR_CD);
	
     if(rtnMap == null)
     {
    	 return false;
     }
     if(rtnMap != null){
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD") = rtnMap.get("PUMBUN_CD");
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_NM") = rtnMap.get("PUMBUN_NAME");
         return true;
     }else{ 
         return false;
     }
     
 }
 
 /** 저장시 협력사 체크
  * checkVenCd()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 :  저장시 협력사 체크
  * return값 : void
  */
 function checkVenCd(row){
     
     var strVenCd        = DS_IO_MASTER.NameValue(row, "VEN_CD");
     var strVenNm        = DS_IO_MASTER.NameValue(row, "VEN_NM");
     var strStrCd        = DS_IO_MASTER.NameValue(row, "STR_CD");    // 점
     var strUseYn        = "Y";                                                           // 사용여부
     var strPumBunType   = "";                                                            // 브랜드유형
     var strBizType      = "";                                                            // 거래형태
     var strMcMiGbn      = "";                                                            // 매출처/매입처구분
     var strBizFlag      = "";                                                            // 거래구분

     var rtnMap = setVenNmWithoutToGridPop( "DS_O_RESULT", strVenCd, '', "0"
                                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                         ,strBizFlag);
     if(rtnMap != null){
    	 if(DS_IO_MASTER.NameValue(row, "VEN_NM") != rtnMap.get("VEN_NAME"))
    	 {
    		 DS_IO_MASTER.NameValue(row, "PUMBUN_CD") = "";
    		 DS_IO_MASTER.NameValue(row, "PUMBUN_NM") = "";
    	 }
    	 DS_IO_MASTER.NameValue(row, "VEN_NM")   = rtnMap.get("VEN_NAME");
    	 DS_IO_MASTER.NameValue(row, "DED_VEN_CD")   = DS_IO_MASTER.NameValue(row, "VEN_CD")
    	 DS_IO_MASTER.NameValue(row, "DED_VEN_NM")   = rtnMap.get("VEN_NAME");
         return true;
     }else{
         return false;
     }      
}
 

 /** 저장시 협력사 체크
  * checkVenCd()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 :  저장시 협력사 체크
  * return값 : void
  */
 function checkDedVenCd(row){
     
     var strVenCd        = DS_IO_MASTER.NameValue(row, "DED_VEN_CD");
     var strVenNm        = DS_IO_MASTER.NameValue(row, "DED_VEN_NM");
     var strStrCd        = DS_IO_MASTER.NameValue(row, "STR_CD");    // 점
     var strUseYn        = "Y";                                                           // 사용여부
     var strPumBunType   = "";                                                            // 브랜드유형
     var strBizType      = "";                                                            // 거래형태
     var strMcMiGbn      = "";                                                            // 매출처/매입처구분
     var strBizFlag      = "";                                                            // 거래구분

     var rtnMap = setVenNmWithoutToGridPop( "DS_O_RESULT", strVenCd, '', "0"
                                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                         ,strBizFlag);
     if(rtnMap != null){
    	 DS_IO_MASTER.NameValue(row, "DED_VEN_NM")   = rtnMap.get("VEN_NAME");
         return true;
     }else{
         return false;
     }      
}
 

 /** 저장시 브랜드 체크
  * checkPumCd()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-31
  * 개    요 :  저장시 브랜드 체크
  * return값 : void
  */
 function checkPumCd(row){
     
     var strPumCd        = DS_IO_MASTER.NameValue(row, "PUMBUN_CD");
     var strPumNm        = DS_IO_MASTER.NameValue(row, "PUMBUN_NM");
     var strStrCd        = DS_IO_MASTER.NameValue(row, "STR_CD");   					  // 점
     var strVenCd        = DS_IO_MASTER.NameValue(row, "VEN_CD");   					  // 협력사
     var strUseYn        = "Y";                                                           // 사용여부
     var strPumBunType   = "";                                                            // 브랜드유형
     var strBizType      = "";                                                            // 거래형태
     var strMcMiGbn      = "";                                                            // 매출처/매입처구분
     var strBizFlag      = "";                                                            // 거래구분
     
     if(strPumCd == "")
     {
    	return false;
     } else {
    	var rtnMap = setStrPbnNmWithoutToGridPop( "DS_O_RESULT", strPumCd, strPumNm, 'Y', "0" );
    	             
     }
     if(rtnMap != null){
         DS_IO_MASTER.NameValue(row, "PUMBUN_NM")   = rtnMap.get("PUMBUN_NAME");
         return true;
     }else{
         return false;
     }      
}
 
 /**
  * checkKeyVlaue(row)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 : 저장시 키값 중복 체크
  * return값 : void
  */
 function checkKeyVlaue(row) {
     var strStrCd    = DS_IO_MASTER.NameValue(row, "STR_CD");
     var strPayYm    = DS_IO_MASTER.NameValue(row, "PAY_YM");
     var strPayCyc   = DS_IO_MASTER.NameValue(row, "PAY_CYC");
     var strPayCnt   = DS_IO_MASTER.NameValue(row, "PAY_CNT");
     var strVenCd    = DS_IO_MASTER.NameValue(row, "VEN_CD");
     var strPumCd    = DS_IO_MASTER.NameValue(row, "PUMBUN_CD");
     var strReasonCd = DS_IO_MASTER.NameValue(row, "REASON_CD");
     
     var strKeyValue = strStrCd + strPayYm + strPayCyc + strPayCnt + strVenCd + strPumCd + strReasonCd;
     
     TR_MAIN.Action="/dps/ppay206.pp?goTo=checkKeyVlaue&strKeyValue="+strKeyValue; 
     TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT=DS_O_RESULT)"; //조회는 O
     TR_MAIN.Post(); 
     
//     alert("DS_O_RESULT = " + DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "KEYVALUE"));

     if(DS_O_RESULT.CountRow > 0){
    	 return false;
     }else
    	 return true;
 }
 
 /**
  * setVatXYN()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 : 공제코드 입력시 VAT 여부셋팅
  * return값 : void
  */
 function setVatXYN(row) {
	  
     var strReasonCd = DS_IO_MASTER.NameValue(row, "REASON_CD");     
     
     TR_MAIN.Action="/dps/ppay206.pp?goTo=setVatXYN&strReasonCd="+strReasonCd; 
     TR_MAIN.KeyValue="SERVLET(O:DS_SETVAT=DS_SETVAT)"; //조회는 O
     TR_MAIN.Post(); 
     
     DS_IO_MASTER.NameValue(row, "VAT_YN") = DS_SETVAT.NameValue(DS_SETVAT.RowPosition, "REFER_CODE");
 }
 
 /**
  * columnEditType(flag, modiFlag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요 : 그리드 컨트롤
  * return값 : void
  */
function columnEditType(flag, modiFlag){
	
    GR_MASTER.ColumnProp("STR_CD",      "Edit" )       = flag; 
    GR_MASTER.ColumnProp("PAY_YM",      "Edit" )       = flag;  
    GR_MASTER.ColumnProp("PAY_CYC",     "Edit" )       = flag; 
    GR_MASTER.ColumnProp("PAY_CNT",     "Edit" )       = flag; 
    GR_MASTER.ColumnProp("VEN_CD",      "Edit" )       = flag; 
    GR_MASTER.ColumnProp("PUMBUN_CD",   "Edit")       = flag;
    GR_MASTER.ColumnProp("DED_VEN_CD",   "Edit")       = flag;
    GR_MASTER.ColumnProp("REASON_CD",   "Edit" )       = flag;
  
    
    if(flag == "none"){
        GR_MASTER.ColumnProp("PAY_YM",  "Edit")   = flag;

        if(modiFlag == "N"){ // 입력금액, 비고 수정가능
            GR_MASTER.ColumnProp("INPUT_AMT",   "Edit")   = "any"; 
            GR_MASTER.ColumnProp("REMARK",      "Edit")   = "any";
        }else{
            GR_MASTER.ColumnProp("INPUT_AMT",   "Edit")   = "none"; 
            GR_MASTER.ColumnProp("REMARK",      "Edit")   = "none"; 
        }        	
    }else{
        GR_MASTER.ColumnProp("PAY_YM",      "Edit")   = "Numeric";
        GR_MASTER.ColumnProp("INPUT_AMT",   "Edit")   = "any"; 
        GR_MASTER.ColumnProp("REMARK",      "Edit")   = "any";     	
    }
}  
  

  /**
  * closeCheck()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요    : 저장시 일마감체크를 한다.
  * return값 : void
  */
  function closeCheck(row, strPayCyc, strPayCnt){
      
      var strStrCd         = DS_IO_MASTER.NameValue(row, "STR_CD");  // 점
      var strCloseDt       = strToday;                               // 마감체크일자
      var strCloseTaskFlag = "PPAY";                                 // 업무구분(매입월마감)
      var strCloseUnitFlag = "";                                     // 단위업무
      var strCloseAcntFlag = "0";                                    // 회계마감구분(0:일반마감)          
      var strCloseFlag     = "M";                                    // 마감구분(월마감:M)
     
      if(strPayCyc == "1"){
          strCloseUnitFlag = "52";
          
      }else if(strPayCyc == "2"){
          if(strPayCnt == "1"){
              strCloseUnitFlag = "53"; 
              
          }else if(strPayCnt == "2"){
              strCloseUnitFlag = "54"; 
          }      
          
      }else if(strPayCyc == "3"){
          if(strPayCnt == "1"){
              strCloseUnitFlag = "55"; 
              
          }else if(strPayCnt == "2"){
              strCloseUnitFlag = "56"; 
              
          }else if(strPayCnt == "3"){
              strCloseUnitFlag = "57";            
          }     
      }      
 
      var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                    , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
        
      if(closeFlag == "TRUE"){
          showMessage(EXCLAMATION, OK, "USER-1068", "대금지불","공제등록");
          return false;
      }else{
          return true;
      }    
  }   

  /**
  * calcAmt(row)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-31
  * 개    요    : VAT 여부에 따른 공급가 부가세 계산.
  * return값 : void
  */
  function calcAmt(row){
	  
      var strVatYn    = DS_IO_MASTER.NameValue(row, "VAT_YN");               // VAT 여부
      var intInputAmt = parseInt(DS_IO_MASTER.NameValue(row, "INPUT_AMT"));  // 입력금액
      var intSupAmt   = parseInt(DS_IO_MASTER.NameValue(row, "SUP_AMT"));    // 공급가
      var intVatAmt   = parseInt(DS_IO_MASTER.NameValue(row, "VAT_AMT"));    // 부가세
      var strStrCd    = DS_IO_MASTER.NameValue(row, "STR_CD");               // 점코드
      var strVenCd    = DS_IO_MASTER.NameValue(row, "VEN_CD");               // 협력사코드
            
      if(strVatYn == "Y"){
          roundFlag = getVenRoundFlag("DS_O_RESULT", strToday, strStrCd, strVenCd);
    	  //intVatAmt = getCalcPord("VAT_AMT", intInputAmt/1.1, "", "", "1", roundFlag); 
    	  intSupAmt = getRoundDec("1", (intInputAmt*10)/11)
    	  intVatAmt = intInputAmt - intSupAmt;
          
      }else if(strVatYn == "N" || strVatYn == "X"){
          intSupAmt = intInputAmt;
          intVatAmt = 0;          
      }    
      
      //계산값 셋팅
      DS_IO_MASTER.NameValue(row, "SUP_AMT") = intSupAmt;
      DS_IO_MASTER.NameValue(row, "VAT_AMT") = intVatAmt;
  }   
  
  

  /**
   * searchPumbunPop()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  조회조건 브랜드팝업
   * return값 : void
   */
   function searchPumbunPop(){
       var tmpOrgCd        = LC_STR_CD.BindColVal;
       var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
       var strStrCd        = LC_STR_CD.BindColVal;                                      // 점
       var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
       var strVenCd        = EM_S_VEN_CD.Text;                                            // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "";                                                        // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "";                                                        // 단품구분
       var strSkuType      = "";                                                        // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "";                                                       // 거래형태(2:특정) 
       var strSaleBuyFlag  = "";                                                        // 판매분매입구분


       var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, 'Y'
                              , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                              , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                              , strBizType,strSaleBuyFlag);
       if(rtnMap != null){
           return true;
       }else{
           return false;
       }
   }

   /**
    * searchPumbunNonPop()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-18
    * 개    요 :  조회조건 브랜드팝업
    * return값 : void
    */
    function searchPumbunNonPop(){
        var tmpOrgCd        = LC_STR_CD.BindColVal;
        var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
        var strStrCd        = LC_STR_CD.BindColVal;                                    // 점
        var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
        var strVenCd        = EM_S_VEN_CD.Text;                                          // 협력사
        var strBuyerCd      = "";                                                        // 바이어
        var strPumbunType   = "";                                                        // 브랜드유형
        var strUseYn        = "Y";                                                       // 사용여부
        var strSkuFlag      = "";                                                        // 단품구분
        var strSkuType      = "";                                                        // 단품종류(1:규격단품)
        var strItgOrdFlag   = "";                                                        // 통합발주여부
        var strBizType      = "";                                                       // 거래형태(2:특정) 
        var strSaleBuyFlag  = "";                                                        // 판매분매입구분


        var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, "Y", "1"
                               , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                               , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                               , strBizType,strSaleBuyFlag);           

        if(rtnMap != null){
            return true;
        }else{
            return false;
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
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
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid); 
</script>
<!-- 
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	var strStrCd  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
	var strPayYm  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_YM");
	var strPayCyc = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CYC");
	var strPayCnt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CNT");
//	var strKey    = strStrCd + strPayYm + strPayCyc + strPayCnt;
//	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"KEY") = strKey;

    switch (colid) {
    
    case "PAY_YM":
        getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
        DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE"); 
    	break;
    	
    case "PAY_CYC":
        if(strPayCyc == "1"){
        	DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P407", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");       
            
        }else if(strPayCyc == "2"){
            DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P408", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");    
            
        }else if(strPayCyc == "3"){
            DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P409", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");        
        }
        break;
            
    case "PAY_CNT":
    	getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
    	DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
        break;
        
    case "REASON_CD":
    	setVatXYN(row);   
        break;
        
    case "VAT_YN":
        calcAmt(row);
        break;
        
    case "INPUT_AMT":
        calcAmt(row);
        break;
    }

</script>
 -->
<!--  -->
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>

	if(clickSORT)
	    return;
    
	if(DS_IO_MASTER.RowStatus(row) == 1)
		columnEditType("any", "N");
	else
		if(DS_IO_MASTER.NameValue(row, "CONF_FLAG") == "N"){  // 수정가능
	        columnEditType("none", "N");
		}else{
            columnEditType("none", "Y");
		}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if(DS_IO_MASTER.NameValue(i, "CONF_FLAG") == "N"){
                DS_IO_MASTER.NameValue(i, "SEL") = 'T';
            }
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "SEL") = 'F';
        }
    }
</script>

<!-- GR_MASTER 데이터변경  -->
<script language=JavaScript for=GR_MASTER event=CanColumnPosChange(row,colid)>

    if(row < 1)
        return true;
    
    switch(colid){
    
    case "STR_CD":
        if(DS_IO_MASTER.NameValue(row, "STR_CD") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "점");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("STR_CD");
            GR_MASTER.Focus();
            return false;
        }else{
            return true;
        }
        break;
        
    	
    case "PUMBUN_CD":
        if(!checkPumCd(row)){
            showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
            DS_IO_MASTER.NameValue(row, "PUMBUN_NM") = "";
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("PUMBUN_CD");
            GR_MASTER.Focus();
            return false;           
        }
    	break;
/*    	
    case "INPUT_AMT":
        if(DS_IO_MASTER.NameValue(row, "INPUT_AMT") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "입력금액");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            GR_MASTER.SetColumn("INPUT_AMT");
            GR_MASTER.Focus();
            return false;
        }else{
            return true;
        }
        break;
*/
    }
</script>


<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
	
    switch(colid){
    
    case "PAY_YM":    	
    	openCal(GR_MASTER,row,colid,'D');
        break;
       
    case "VEN_CD":
        var strVenCd = DS_IO_MASTER.NameValue(row, "VEN_CD");
        var strVenNm = DS_IO_MASTER.NameValue(row, "VEN_NM");
        var check=1;
    	getPopGridVenInfo(strVenCd, strVenNm, check);
    	break;
    	
    case "DED_VEN_CD":
        var strVenCd = DS_IO_MASTER.NameValue(row, "DED_VEN_CD");
        var strVenNm = DS_IO_MASTER.NameValue(row, "DED_VEN_NM");
        var check=2;
    	getPopGridVenInfo(strVenCd, strVenNm, check); 
    	break;
    	
    case "PUMBUN_CD":
    	setPumbunCodeToGrid('POP', row);
    
    }
</script>


<!-- 지불년월 KillFocus -->
<script language=JavaScript for=EM_SALE_DT event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    checkDateTypeYM(EM_SALE_DT);
    EM_SALE_DT.Text = "";
    EM_SALE_E_DT.Text = "";
    getSaleDate("DS_O_SALE_DATE", EM_SALE_DT.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
    EM_SALE_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");

</script>


<!-- 지불주기 변경시  -->

<script language=JavaScript for=LC_PAY_CYC event=OnSelChange()>
	
	EM_SALE_DT.Text = "";
	EM_SALE_E_DT.Text = "";
	
	DS_O_PAY_CNT.ClearData();
	
    if(LC_PAY_CYC.BindColVal == "%")
    	
	    insComboData(LC_PAY_CNT, "%", "전체",1);
    else if(LC_PAY_CYC.BindColVal == "1")
	    getEtcCode("DS_O_PAY_CNT", "D", "P407", "N");         // 지불회차
	else if(LC_PAY_CYC.BindColVal == "2")
		getEtcCode("DS_O_PAY_CNT", "D", "P408", "N");         // 지불회차
	else if(LC_PAY_CYC.BindColVal == "3")
		getEtcCode("DS_O_PAY_CNT", "D", "P409", "N");         // 지불회차
		
	LC_PAY_CNT.index = 0;
		   
</script>

<!-- 지불회차 변경시  -->
<script language=JavaScript for=LC_PAY_CNT event=OnSelChange()>

	EM_SALE_DT.Text = "";
	EM_SALE_E_DT.Text = "";

    getSaleDate("DS_O_SALE_DATE", EM_SALE_DT.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
    EM_SALE_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
	
</script>


	
</script>
<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return
        
    if(EM_S_VEN_CD.Text != ""){
    	   	
        getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, false);        
    }
    else{
        EM_S_VEN_NM.Text = "";
    }
    
    
</script>

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
        EM_S_PUMBUN_NM.Text = "";  
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
<comment id="_NSID_"><object id="DS_I_PAY_CYC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PAY_CNT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SETVAT"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CASH_IN_YN"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STR_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VAL_CHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_REASON_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_VAT_YN"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


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
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
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
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
	            <td width="110">
		            <comment id="_NSID_">
		                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
		                </object>
		            </comment><script>_ws_(_NSID_);</script>
	            </td>
            	<th width="80">매출일자</th>
	            <td >
	                  <comment id="_NSID_">
	                      <object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
	                      </object>
	                  </comment>
	                  <script> _ws_(_NSID_);</script>
	            </td>
            
          </tr>
          
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>



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
  
  
  
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_MASTER width=100% height=435 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>


