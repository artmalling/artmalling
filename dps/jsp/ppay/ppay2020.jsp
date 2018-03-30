<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 선지불/보류/공제 > 선급금 등록
 * 작 성 일 : 2010.05.31
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay2020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 선급금 등록
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
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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

var strToday        = "";                            // 현재날짜
var strYYYYMM       = "";                            // 현재년월
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-31
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 200;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


     strToday  = getTodayDB("DS_O_RESULT");
     
     strYYYYMM = strToday.substring(2, 6);

     // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_O_PAY_CNT.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     
     //그리드 초기화
     gridCreate1(); //마스터
     // EMedit에 초기화
     initEmEdit(EM_YYYYMM      ,"THISMN"    ,PK);            // 지불년월
     initEmEdit(EM_SALE_S_DT   ,"YYYYMMDD"  ,READ);          // 매입기간 시작일
     initEmEdit(EM_SALE_E_DT   ,"YYYYMMDD"  ,READ);          // 매입매출기간 종료일
     initEmEdit(EM_S_VEN_CD    ,"000000"    ,NORMAL);        // 협력사코드
     initEmEdit(EM_S_VEN_NM    ,"GEN"       ,READ);          // 협력사명
     initEmEdit(EM_S_PUMBUN_CD,      "000000",      NORMAL);         // 브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,      "GEN^40",      READ);           // 브랜드명

     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD   ,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 점(조회)
     initComboStyle(LC_PAY_CYC,DS_O_PAY_CYC  ,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 지불주기
     initComboStyle(LC_PAY_CNT,DS_O_PAY_CNT  ,"CODE^0^30,NAME^0^80"  ,1  ,PK);       // 지불회차
     
     getStore("DS_IO_STR_CD"      ,"Y"   ,""      ,"N");   
     getEtcCode("DS_O_PAY_CYC"    ,"D"   ,"P052"  ,"N");         // 조회지불주기
     getEtcCode("DS_O_PAY_CNT"    ,"D"   ,"P407"  ,"N");         // 조회지불회차
     getEtcCode("DS_I_PAY_CYC"    ,"D"   ,"P052"  ,"N");         // 지불주기
     getEtcCode("DS_I_PAY_CNT"    ,"D"   ,"P407"  ,"N");         // 지불회차
     getEtcCode("DS_I_REASON_CD"  ,"D"   ,"P413"  ,"N");         // 선급금

     LC_STR_CD.index  = 0;
     LC_PAY_CYC.index = 0;
     LC_PAY_CNT.index = 0;
     LC_STR_CD.Focus();
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}     name="NO"               width=30    align=center</FC>'
                      + '<FC>id=SEL          name="선택"             width=50    align=center EditStyle=CheckBox  HeadCheckShow="true" Edit={IF(CONF_FLAG="N","true","false")}</FC>'
                      + '<FC>id=STR_CD       name="*점"              width=60    align=left   Edit=none EditStyle=Lookup   Data="DS_IO_STR_CD:CODE:NAME"</FC>'
                      + '<FC>id=PAY_YM       name="*지불년월"        width=80    align=center EditStyle=Popup Edit=Numeric Mask="XXXX/XX" </FC>'
                      + '<FC>id=PAY_CYC      name="*지불주기"        width=70    align=center EditStyle=Lookup Data="DS_I_PAY_CYC:CODE:NAME"</FC>'
                      + '<FC>id=PAY_CNT      name="*지불회차"        width=70    align=center EditStyle=Lookup Data="DS_I_PAY_CNT:CODE:NAME"</FC>'
                      + '<FC>id=VEN_CD       name="*협력사코드"      width=80    align=center EditStyle=Popup</FC>'
                      + '<FC>id=VEN_NM       name="협력사명"         width=120   align=left   Edit=none</FC>'
                      + '<FC>id=PUMBUN_CD    name="*브랜드코드"         width=70     align=center EditStyle=Popup</FC>'
                      + '<FC>id=PUMBUN_NM    name="브랜드명"           width=120     align=left Edit=none </FC>'
                      + '<FC>id=SEQ_NO       name="순번"             width=50    align=center Edit=none show=false </FC>'
                      + '<FC>id=INPUT_DT     name="선급금지불일"     width=80    align=center Edit=none Mask="XXXX/XX/XX" </FC>'
                      + '<FC>id=REASON_CD    name="*선급금"          width=140   align=left   EditStyle=Lookup Data="DS_I_REASON_CD:CODE:NAME"</FC>'
                      + '<FC>id=INPUT_AMT    name="*선급금금액"      width=110   align=right  Edit={IF(CONF_FLAG="N","Numeric","false")}</FC>'
                      + '<FC>id=REMARK       name="비고"             width=300   align=left   Edit={IF(CONF_FLAG="N","true","false")}</FC>'
                      + '<FC>id=KEY          name="KEY"              width=130   align=left   Edit=none show="false"</FC>'
                      + '<FC>id=CONF_FLAG    name="확정구분"          width=120   align=left   show="false"</FC>';
                      
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
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
  * 작 성 자     : 김경은
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

      if(checkValidation("Search")){
          DS_IO_MASTER.ClearData();  
          // 조회조건 셋팅
          var strStrCd         = LC_STR_CD.BindColVal;                  // 점
          var strYyyymm        = EM_YYYYMM.Text;                        // 지불년월
          var strPayCyc        = LC_PAY_CYC.BindColVal;                 // 지불주기
          var strPayCnt        = LC_PAY_CNT.BindColVal;                 // 지불회차
          var strVenCd         = EM_S_VEN_CD.Text;                      // 협력사코드
          var strPumCd         = EM_S_PUMBUN_CD.Text;                   // 브랜드코드
          var strSaleSdt       = EM_SALE_S_DT.Text;
          var strSaleEdt       = EM_SALE_E_DT.Text;

          getMaster("DS_IO_MASTER",strStrCd, strYyyymm, strPayCyc, strPayCnt, strVenCd, strPumCd, strSaleSdt, strSaleEdt);
          GR_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";
          
          // 조회결과 Return
          setPorcCount("SELECT", GR_MASTER);
          GR_MASTER.SetColumn("SEL");
          GR_MASTER.Focus();
      }
 }

 /**
  * getMaster(strStrCd, strYyyymm, strPayCyc, strPayCnt, strVenCd)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-31
  * 개    요   : 마스터를 조회한다.
  * return값 : void
  */
function getMaster(dataSet, strStrCd, strYyyymm, strPayCyc, strPayCnt, strVenCd, strPumCd, strSaleSdt, strSaleEdt){
	var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strYyyymm="+encodeURIComponent(strYyyymm)     
                    + "&strPayCyc="+encodeURIComponent(strPayCyc)      
                    + "&strPayCnt="+encodeURIComponent(strPayCnt)     
                    + "&strVenCd="+encodeURIComponent(strVenCd)
                    + "&strPumCd="+encodeURIComponent(strPumCd)
                    + "&strSaleSdt="+encodeURIComponent(strSaleSdt)
                    + "&strSaleEdt="+encodeURIComponent(strSaleEdt); 
    TR_MAIN.Action  = "/dps/ppay202.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER="+dataSet+")"; // 조회는 O
    TR_MAIN.Post();
    
}
 
/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-08
 * 개    요 : 신규 추가
 * return값 : void
 */
function btn_New() {
	 
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
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
	    
	    TR_MAIN.Action="/dps/ppay202.pp?goTo=save"+params; 
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    TR_MAIN.Post();	    
	    btn_search();
    }
    GR_MASTER.ColumnProp('SEL','HeadCheck')= "false";   //그리드 CHEKCBOX헤더 체크해제   
*/
}

/**
 * btn_Save()
 * 작 성 자 : 김경은
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

    if(!checkValidation("Save"))    // validation 체크
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){

        TR_MAIN.Action="/dps/ppay202.pp?goTo=save&strFlag=save&strYYYYMM="+strYYYYMM; 
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
	    var strTitle = "선급금 등록";
	    
        var strStrCd         = LC_STR_CD.BindColVal;                  // 점
        var strYyyymm        = EM_YYYYMM.Text;                        // 지불년월
        var strPayCyc        = LC_PAY_CYC.BindColVal;                 // 지불주기
        var strPayCnt        = LC_PAY_CNT.BindColVal;                 // 지불회차
        var strVenCd         = EM_S_VEN_CD.Text;                      // 협력사코드
        var strPumCd         = EM_S_PUMBUN_CD.Text;                   // 브랜드코드
        var strSaleSdt       = EM_SALE_S_DT.Text;
        var strSaleEdt       = EM_SALE_E_DT.Text;
	    
	    var parameters = "점 "           + strStrCd
			        + " ,   매출년월 " + strYyyymm
			        + " ,   지불주기 " + strPayCyc
			        + " ,   지불회차 " + strPayCnt
			        + " ,   매출기간 " + strSaleSdt 
			        + " ~ " + strSaleEdt
			        + " ,   협력사 "   + strVenCd
			        + "     브랜드 "   + strPumCd;
	    
	    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    //openExcel2(GR_MASTER, strTitle, parameters, true );
	    openExcel5(GR_MASTER, strTitle, parameters, true , "",g_strPid );

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
 * 작 성 일 : 2010-04-08
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * addRow()
  * 작 성 자     :김경은
  * 작 성 일     : 2010-05-31
  * 개    요        : ROW 추가
  * return값 : void
  */
 function addRow(){
	  
	  if(checkValidation("Save")){
          DS_IO_MASTER.AddRow();

          GR_MASTER.SetColumn("STR_CD");
          GR_MASTER.Focus();
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CONF_FLAG") = "N";
          
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = LC_STR_CD.BindColVal;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_YM") = EM_YYYYMM.Text;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CYC") = LC_PAY_CYC.BindColVal;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CNT") = LC_PAY_CNT.BindColVal;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = EM_S_VEN_CD.Text;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = EM_S_VEN_NM.Text;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD") = EM_S_PUMBUN_CD.Text;
          DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUM_NM") = EM_S_PUMBUN_NM.Text;
          
      }
 }
  
 /**
 * delRow()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-31
 * 개    요    : ROW 삭제
 * return값 : void
 */
 function delRow(){
	// 삭제 메세지 
    if(showMessage(Question, YESNO, "USER-1023") != 1)
        return;
    
    var intRowCount =  DS_IO_MASTER.CountRow;
    for(var i=intRowCount; i >= 1; i--){
        if(DS_IO_MASTER.NameValue(i, "SEL") == 'T'){
            DS_IO_MASTER.DeleteRow(i);
        }
    }
 }

 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
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
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-31
  * 개    요 :  그리드협력사 팝업
  * return값 : void
  */
 function getPopGridVenInfo(strVenCd, strVenNm){
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
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = rtnMap.get("VEN_CD");
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = rtnMap.get("VEN_NAME");
         return true;
     }else{ 
         return false;
     }
 }

 /** 그리드협력사 넌팝업
  * getNonPopGridVenInfo(code, name)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-31
  * 개    요 :  그리드협력사  넌팝업
  * return값 : void
  */
 function getNonPopGridVenInfo(){
     
     var strVenCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");
     var strVenNm        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM");
     var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");    // 점
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
         return true;
     }else{
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD") = "";    
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_NM") = "";
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
	 var rtnMap = rtnMap = strPbnToGridPop( PUM_CD, PUM_NM, 'Y' ,'' , STR_CD, '', VEN_CD );
	
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
  * 작 성 자 : 김경은
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
    	var rtnMap = setStrPbnNmWithoutToGridPop( "DS_O_RESULT", strPumCd, strPumNm, 'Y', "0" , "" , strStrCd , "" , strVenCd);
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
  * 작 성 자 : 김경은
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
     
     TR_MAIN.Action="/dps/ppay202.pp?goTo=checkKeyVlaue&strKeyValue="+strKeyValue; 
     TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT=DS_O_RESULT)"; //조회는 O
     TR_MAIN.Post(); 
     
//     alert("DS_O_RESULT = " + DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "KEYVALUE"));
     if(DS_O_RESULT.CountRow > 0){
    	 return false;
     }else
    	 return true;
 }
 
 /**
  * columnEditType(flag, modiFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-31
  * 개    요 : 그리드 컨트롤
  * return값 : void
  */
function columnEditType(flag, modiFlag){
	  
    GR_MASTER.ColumnProp("STR_CD",      "Edit")       = flag; 
    GR_MASTER.ColumnProp("PAY_YM",      "Edit")       = flag;  
    GR_MASTER.ColumnProp("PAY_CYC",     "Edit")       = flag; 
    GR_MASTER.ColumnProp("PAY_CNT",     "Edit")       = flag; 
    GR_MASTER.ColumnProp("VEN_CD",      "Edit")       = flag;
    GR_MASTER.ColumnProp("PUMBUN_CD",   "Edit")       = flag; 
    GR_MASTER.ColumnProp("REASON_CD",   "Edit")       = flag; 
    
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
   * checkValidation()
   * 작 성 자     : 김경은
   * 작 성 일     : 2010-05-31
   * 개    요        : validation 체크
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       var messageCode = "USER-1001";
       
       //조회버튼 클릭시 Validation Check
       if(Gubun == "Search"){   
           if(EM_YYYYMM.Text.length == 0){                                // 지불년월
               showMessage(INFORMATION, OK, "USER-1002", "지불년월");
               EM_YYYYMM.Focus();
               return false;
           }
       }
       
       // 저장버튼 클릭시 Validation Check
       if(Gubun == "Save"){          
           var intRowCount   = DS_IO_MASTER.CountRow;
           var strStrCd      = "";                     // 점
           var strPayYm      = "";                     // 지불년월        
           var strPayCyc     = "";                     // 지불주기
           var strPayCnt     = "";                     // 지불회차 
           var strIssueSdt   = "";                     // 시작일자
           var strIssueEdt   = "";                     // 종료일자
           var intInputAmt   = "";                     // 선지불금액 
           
           if(intRowCount > 0){
               for(var i=1; i <= intRowCount; i++){
                   
            	   strRowStatus = DS_IO_MASTER.RowStatus(i);               //신규, 수정 구분값            	   
            	   strStrCd     = DS_IO_MASTER.NameValue(i, "STR_CD");
            	   strPayYm     = DS_IO_MASTER.NameValue(i, "PAY_YM");
            	   strPayCyc    = DS_IO_MASTER.NameValue(i, "PAY_CYC");
                   strPayCnt    = DS_IO_MASTER.NameValue(i, "PAY_CNT");
                   strVenCd     = DS_IO_MASTER.NameValue(i, "VEN_CD");
                   strPumCd     = DS_IO_MASTER.NameValue(i, "PUMBUN_CD");
                   strReasonCd  = DS_IO_MASTER.NameValue(i, "REASON_CD");
                   intInputAmt  = DS_IO_MASTER.NameValue(i, "INPUT_AMT");
                   
            	   if(strStrCd.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "점");
                       GR_MASTER.SetColumn("STR_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
            	   
            	   if(strPayYm.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "지불년월");
                       GR_MASTER.SetColumn("PAY_YM");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
            	   
                   if(strPayCyc.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "지불주기");
                       GR_MASTER.SetColumn("PAY_CYC");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(strPayCnt.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "지불회차");
                       GR_MASTER.SetColumn("PAY_CNT");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(!checkVenCd(i)){
                       showMessage(INFORMATION, OK, "USER-1003", "협력사");
                       GR_MASTER.SetColumn("VEN_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(!checkPumCd(i)){
                       showMessage(INFORMATION, OK, "USER-1003", "품목");
                       GR_MASTER.SetColumn("PUMBUN_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   if(strReasonCd.length <= 0){
                       showMessage(INFORMATION, OK, "USER-1003", "선급금코드");
                       GR_MASTER.SetColumn("REASON_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }             
                   
                   if(intInputAmt <= 0){
                       showMessage(EXCLAMATION, OK, "USER-1008", "선지불금액", "0");
                       GR_MASTER.SetColumn("INPUT_AMT");
                       DS_IO_MASTER.RowPosition = i;  
                       GR_MASTER.Focus();
                       return false;
                   }
                   
                   // 신규와 수정일때를 구분한다.
                   if(strRowStatus == "1"){        //신규일때
                       if(!checkKeyVlaue(i)){
                           showMessage(INFORMATION, OK, "USER-1044", "KEY값");
                           DS_IO_MASTER.RowPosition = i;  
                           DS_IO_MASTER.NameValue(i,"SEL") = "T";
                           GR_MASTER.SetColumn("SEL");
                           return false;
                       }
                   
                       if(!closeCheck(i, strPayCyc, strPayCnt)){    //마감체크
                           DS_IO_MASTER.NameValue(i,"SEL") = "T";
                           GR_MASTER.SetColumn("SEL");
                           return false;
                       }    
                       
                   }else if(strRowStatus == "3"){  //수정일때
                       if(!closeCheck(i, strPayCyc, strPayCnt)){    //마감체크
                           DS_IO_MASTER.NameValue(i,"SEL") = "T";
                           GR_MASTER.SetColumn("SEL");
                           return false;
                       }    
                   }  
                   
/*                
                   if(!checkKeyVlaue(i)){
                       showMessage(INFORMATION, OK, "USER-1044", "KEY값");
                       GR_MASTER.SetColumn("REASON_CD");  
                       DS_IO_MASTER.RowPosition = i;  
                       return false;
                   }
                   
                   
                   // 중복체크
                   var dupRow = checkDupKey(DS_IO_MASTER, "KEY");
                   if (dupRow > 0) {
                       showMessage(StopSign, Ok,  "USER-1044", dupRow);
          
                       DS_IO_MASTER.RowPosition = dupRow;
                       //DS_IO_MASTER.NameValue(dupRow,"SEL") = "T";
                       GR_MASTER.SetColumn("SEL");
                       GR_MASTER.Focus(); 

                       return false;
                   }
*/                  
/*                   
                   // 등록된 발행기간이 있는지 조회한다.      
                   if(DS_IO_MASTER.RowStatus(i) == "1"){
	                   getMaster("DS_O_VAL_CHECK", strStrCd, strPayYm, strPayCyc, strPayCnt, "", "");
	                   if(DS_O_VAL_CHECK.CountRow > 0){
	                	   showMessage(StopSign, Ok,  "USER-1044", i);
	                	   return false;
	                   }
                   }
*/
               }
           }
       }
       return true; 
  }

  /**
  * closeCheck()
  * 작 성 자 : 김경은
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
          showMessage(EXCLAMATION, OK, "USER-1068", "대금지불마감","선급금등록");
          return false;
      }else{
          return true;
      }    
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

<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
sortColId(eval(this.DataID), row, colid);
</script>

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
            DS_IO_MASTER.NameValue(row,"SALE_S_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
            DS_IO_MASTER.NameValue(row,"SALE_E_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
            
        }else if(strPayCyc == "2"){
            DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P408", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");  
            DS_IO_MASTER.NameValue(row,"SALE_S_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
            DS_IO_MASTER.NameValue(row,"SALE_E_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
            
        }else if(strPayCyc == "3"){
            DS_IO_MASTER.NameValue(row,"PAY_CNT") = "";
            getEtcCode("DS_I_PAY_CNT", "D", "P409", "N");         // 지불회차
            getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
            DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE"); 
            DS_IO_MASTER.NameValue(row,"SALE_S_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
            DS_IO_MASTER.NameValue(row,"SALE_E_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
        }
        break;
            
    case "PAY_CNT":
    	getSaleDate("DS_O_SALE_DATE", strPayYm, strPayCyc, strPayCnt);
    	DS_IO_MASTER.NameValue(row,"INPUT_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
    	DS_IO_MASTER.NameValue(row,"SALE_S_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
        DS_IO_MASTER.NameValue(row,"SALE_E_DT") = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
        break;
    
    }

</script>
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
            DS_IO_MASTER.NameValue(i, "SEL") = 'T';
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
            return false;
        }else{
            return true;
        }
        break;
    case "INPUT_DT":
    	if(!checkDateTypeYMD(this,colid,'')){
    		if(DS_IO_MASTER.NameValue(row, colid).length == 0){
    			return true;
    		}
            return false;           
        }else{
            var strSaleSdt = DS_IO_MASTER.NameValue(row, "SALE_S_DT");
            var strSaleEdt = DS_IO_MASTER.NameValue(row, "SALE_E_DT");
            var strInputDt = DS_IO_MASTER.NameValue(row, "INPUT_DT");
            
        	if(!(strSaleSdt <= strInputDt && strSaleEdt >= strInputDt)){
                showMessage(EXCLAMATION, OK, "USER-1190", "선급금지불일","매입매출기간");
                DS_IO_MASTER.NameValue(row, "INPUT_DT") = strSaleEdt;
                return false;
            }
            return true;   
        }
        break;
    case "PAY_YM":
//        if(DS_IO_MASTER.NameValue(row, "PAY_YM") == "")
//            return true;
        if(!checkDateTypeYM(this,colid,'')){
            showMessage(EXCLAMATION, OK, "USER-1003", "지불년월");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            return false;        	
        }else{
            return true;   
        }
        break;
    case "PAY_CYC":
        if(DS_IO_MASTER.NameValue(row, "PAY_CYC") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "지불주기");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            return false;
        }else{
            return true;
        }
        break;
    case "PAY_CNT":
        if(DS_IO_MASTER.NameValue(row, "PAY_CNT") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "지불회차");
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            return false;
        }else{
            return true;
        }
        break;
    case "VEN_CD":
        if(!checkVenCd(row)){
            showMessage(EXCLAMATION, OK, "USER-1003", "협력사코드");
            DS_IO_MASTER.NameValue(row, "VEN_NM") = "";
            DS_IO_MASTER.NameValue(row, "SEL") = 'T';
            return false;           
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
    	openCal(GR_MASTER,row,colid,'M');
        break;
    case "VEN_CD":
        var strVenCd = DS_IO_MASTER.NameValue(row, "VEN_CD");
        var strVenNm = DS_IO_MASTER.NameValue(row, "VEN_NM");
    	getPopGridVenInfo(strVenCd, strVenNm);
    	break;
    case "PUMBUN_CD":
    	setPumbunCodeToGrid('POP', row);
    	break;
    case "INPUT_DT":
    	openCal(GR_MASTER,row,colid);
    	break;
    }
</script>

<!-- 지불년월 KillFocus -->
<script language=JavaScript for=EM_YYYYMM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    checkDateTypeYM(EM_YYYYMM);
    EM_SALE_S_DT.Text = "";
    EM_SALE_E_DT.Text = "";
    getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
    EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");

</script>

<!-- 지불주기 변경시  -->
<script language=JavaScript for=LC_PAY_CYC event=OnSelChange()>
	EM_SALE_S_DT.Text = "";
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
	EM_SALE_S_DT.Text = "";
	EM_SALE_E_DT.Text = "";

    getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
    EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
	
</script>

<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return
        
    if(EM_S_VEN_CD.Text != "")
        getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, false);
    else
        EM_S_VEN_NM.Text = "";
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

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STR_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VAL_CHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_REASON_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
            <th width="80" class="point">지불년월</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:javascript:openCal('M',EM_YYYYMM)"  align="absmiddle"/>
            </td>
            <th class="point" width="80">지불주기</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="80">지불회차</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
         
          <tr>
            <th>매입매출기간</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  ~
                  <comment id="_NSID_">
                      <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
            </td>
            <td colspan=4></td>
           </tr>
           <tr>
             <th>협력사</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM, true);" />
               <comment id="_NSID_"> 
                   <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=189 tabindex=1 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>
             </td>
             <th>브랜드</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();"  />
               <comment id="_NSID_"> 
                   <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=186 tabindex=1 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>
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

