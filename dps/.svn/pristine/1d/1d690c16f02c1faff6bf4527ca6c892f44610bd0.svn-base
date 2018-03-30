<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 대금지불> 실지불액 계산/확정/이월처리
 * 작 성 일 : 2010.05.17
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay3060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실지불액 계산/확정/이월처리
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
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";                            // 현재날짜
var valCheck          = 0;                             // validation check 완료여부 (5일경우 다 체크함)
var valMsg            = 0;                             // validation check 메세지 발생 여부
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 400;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_LIST"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_O_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_I_SEARCH.setDataHeader('<gauce:dataset name="H_SEARCH"/>');
     DS_I_SEARCH_TMP.setDataHeader('<gauce:dataset name="H_SEARCH"/>');
     DS_I_SEARCH.AddRow();
     // Output Data Set Header 초기화
   
     // EMedit에 초기화
     initEmEdit(EM_VEN_CD,       "000000",   NORMAL);          // 협력사코드
     initEmEdit(EM_VEN_NM,       "GEN^40",   READ);            // 협력사명
     initEmEdit(EM_YYYYMM,       "THISMN",   PK);              // 매입/매출년월
     initEmEdit(EM_SALE_S_DT,    "YYYYMMDD", READ);            // 매입/매출기간 시작일
     initEmEdit(EM_SALE_E_DT,    "YYYYMMDD", READ);            // 매입/매출기간 종료일
     initEmEdit(EM_S_PUMBUN_CD,      "000000",      NORMAL);         // 브랜드코드
     initEmEdit(EM_S_PUMBUM_NM,      "GEN^40",      READ);           // 브랜드명
     
   //년월일 전달로 셋팅
     var strYyyyMm = EM_YYYYMM.Text + "01";
     EM_YYYYMM.Text = setDateAdd('M', -1, strYyyyMm).substring(0, 6);

     // 그리드 초기화
     gridCreate1(); //작업내역 리스트
     
     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD,      "CODE^0^30,NAME^0^80", 1, NORMAL);    // 점(조회)
     initComboStyle(LC_PAY_CYC,DS_O_PAY_CYC,     "CODE^0^30,NAME^0^80", 1, PK);        // 지불주기
     initComboStyle(LC_PAY_CNT,DS_O_PAY_CNT,     "CODE^0^30,NAME^0^80", 1, PK);        // 지불회차
     
     getStore("DS_IO_STR_CD",     "Y", "", "Y");   
     getEtcCode("DS_O_PAY_CYC",   "D", "P052", "N");            // 조회지불주기
     getEtcCode("DS_O_PAY_CNT",   "D", "P407", "N");            // 조회지불회차
     getEtcCode("DS_O_BIZ_TYPE",  "D", "P002", "Y");            // 거래형태
     
     LC_STR_CD.index   = 0;
     LC_PAY_CYC.index  = 0;
     LC_PAY_CNT.index  = 0;
//     EM_YYYYMM.Focus(); 

//	CHK5.disabled = true;

     document.getElementById("chk1").focus();
     
     getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
     EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
     
 //    btn_Search();
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"            width=40   align=center</FC>'                           
    	              + '<FC>id=JOB_PRG_NM         name="작업명"        width=200  align=left </FC>'
                      + '<FC>id=REG_DATE           name="작업일시"      width=140  align=left </FC>'
                      + '<FC>id=PROC_ID            name="작업자"        width=90  align=left </FC>'
                      + '<FC>id=PROC_YN            name="처리여부"      width=70   align=center </FC>'
                      + '<FC>id=STR_NM             name="점"            width=120  align=left </FC>'
                      + '<FC>id=VEN_NM             name="협력사"        width=150  align=left </FC>'
                      + '<FC>id=REMARK             name="비고"          width=300  align=left </FC>';

     initGridStyle(GR_LIST, "common", hdrProperies, false);
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 // 조회조건 셋팅
    var strPayYm         = EM_YYYYMM.Text;                       // 작업년월
    var strPayCyc        = LC_PAY_CYC.BindColVal;                 // 지불주기
    var strPayCnt        = LC_PAY_CNT.BindColVal;                 // 지불회차
    var strStrCd         = LC_STR_CD.BindColVal;                  // 점
    var strVenCd         = EM_VEN_CD.Text;                        // 협력사

   
    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters =  "&strPayYm="+encodeURIComponent(strPayYm)     
                    + "&strPayCyc="+encodeURIComponent(strPayCyc)     
                    + "&strPayCnt="+encodeURIComponent(strPayCnt)      
                    + "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strVenCd="+encodeURIComponent(strVenCd); 
    TR_S_MAIN.Action  = "/dps/ppay306.pp?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
    TR_S_MAIN.Post();
    
    setPorcCount("SELECT", GR_LIST);
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {

}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-17
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	
    
    
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-17
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
         var rtnMap = venPop(code, name
                            ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                            ,strBizFlag);
     }
 }
 
 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-05-17
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
      
	//조회버튼 클릭시 Validation Check
	if(Gubun == "Search"){   
	   
	}
	
	
	// 저장버튼 클릭시 Validation Check
	if(Gubun == "Save"){
    	  
		if(EM_YYYYMM.Text.length == 0){                                // 지불작업년월
            showMessage(INFORMATION, OK, "USER-1002", "지불작업년월");
            EM_YYYYMM.Focus();
            return false;
        }
		
		var cnt = 0;
	    if(CHK1.checked)
	        cnt++;
	    else if(CHK2.checked)
	        cnt++;
	    else if(CHK3.checked)
	        cnt++;
	    else if(CHK4.checked)
	        cnt++;
	    else if(CHK5.checked)
            cnt++;/*
	    else if(CHK6.checked)
            cnt++;
	    else if(CHK7.checked)
            cnt++;
	    else if(CHK8.checked)
            cnt++;
	    else if(CHK9.checked)
            cnt++;
	    else if(CHK10.checked)
            cnt++;
	    else if(CHK11.checked)
            cnt++;*/
	    
	    if(cnt <= 0){
	    	showMessage(EXCLAMATION, OK, "USER-1002","대금지불처리작업");
	    	document.getElementById("chk1").focus();
	    	return false;
	    }
    	
        if(EM_SALE_S_DT.Text.length == 0 || EM_SALE_E_DT.Text.length == 0){
            showMessage(EXCLAMATION, OK, "USER-1087");
            EM_YYYYMM.Focus();
            return false;
        }
        
//        var strStrCd   = LC_STR_CD.BindColVal;                    // 점
//        var strYyyymm  = EM_YYYYMM.Text;                          // 매입년월
//        var strPayCyc  = LC_PAY_CYC.BindColVal;                   // 지불주기
//        var strPayCnt  = LC_PAY_CNT.BindColVal;                   // 지불회차
//        
//        if(ppayCloseCheck(strStrCd,strYyyymm,strPayCyc,strPayCnt) == "TRUE"){
//            showMessage(INFORMATION, OK, "USER-1150", "대금지불월", "매입월","실지불액 계산/확정/이월처리");
//            return false;
//        }
         
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
      var strVenCd        = EM_VEN_CD.Text;                                            // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                        // 단품구분
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                       // 거래형태(2:특정) 
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분


      var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_S_PUMBUM_NM, 'Y'
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
  * CloseCheck()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-06-10
  * 개    요        : 마감체크
  * return값 : void
  */
 function CloseCheck(){
	for(var i = 1; i <= 5; i++){  
		DS_I_SEARCH_TMP.ClearData();
		var strData = DS_I_SEARCH.ExportData(1,DS_I_SEARCH.CountRow, true );
		DS_I_SEARCH_TMP.ImportData(strData);

		TR_VALCHECK.Action="/dps/ppay306.pp?goTo=valCheck&CHK="+i; 
		TR_VALCHECK.KeyValue="SERVLET(I:DS_I_SEARCH=DS_I_SEARCH_TMP)"; //조회는 O
		TR_VALCHECK.Post();
	}
 }
 
 /**
  * porcess()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-06-10
  * 개    요        : 처리버튼 클릭
  * return값 : void
  */
 function process(){
	  
	valCheck = 0;
	valMsg   = 0;
	
	if(!checkValidation("Save"))
	    return;
	
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK1")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK2")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK3")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK4")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK5")  = "N";/*
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK6")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK7")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK8")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK9")  = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK10") = "N";
	DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK11") = "N";*/
	
	// 1. 체크된 데이터를 데이터셋에 세팅
	if(CHK1.checked)
	    DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK1") = "Y";
	if(CHK2.checked)
	    DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK2") = "Y";
	if(CHK3.checked)
	    DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK3") = "Y";
	if(CHK4.checked)
	    DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK4") = "Y";
	if(CHK5.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK5") = "Y";/*
	if(CHK6.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK6") = "Y";
	if(CHK7.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK7") = "Y";
	if(CHK8.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK8") = "Y";
	if(CHK9.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK9") = "Y";
	if(CHK10.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK10") = "Y";
	if(CHK11.checked)
        DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "CHK11") = "Y";*/
	
	
	// 2. 마감체크한다.
	CloseCheck();
	
	// 3. 마감체크후 마감체크가 onSuccess일 경우에 저장을 실행한다.(TR_VALCHECK확인)
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
      var strVenCd        = EM_VEN_CD.Text;                                          // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                        // 단품구분
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                       // 거래형태(2:특정) 
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분


      var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUM_NM, "Y", "1"
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
<script language=JavaScript for=TR_SAVE event=onSuccess>
    searchDoneWait();
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        if(TR_SAVE.SrvErrMsg('UserMsg',i) != "OK"){
            showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
        }else{
            showMessage(INFORMATION, OK, "USER-1000", "처리되었습니다.");
        }
    }
    btn_Search();
</script>

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
<script language=JavaScript for=TR_VALCHECK event=onSuccess>
	for(i=0;i<TR_VALCHECK.SrvErrCount('UserMsg');i++) {
		if(TR_VALCHECK.SrvErrMsg('UserMsg',i) != "OK" && valMsg == 0){
			valMsg++;
			showMessage(INFORMATION, OK, "USER-1000", TR_VALCHECK.SrvErrMsg('UserMsg',i));
		}else{
            valCheck++;
		}
	}
	
	if(valCheck == 5){
		//처리하시겠습니까?
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){    // validation 체크
	        TR_SAVE.Action="/dps/ppay306.pp?goTo=save&strFlag=save"; 
	        TR_SAVE.KeyValue="SERVLET(I:DS_I_SEARCH=DS_I_SEARCH)"; //조회는 O
	        
	        searchSetWait("B");  // 프로그래스바
	        
	        TR_SAVE.Post();
	        
	        if(DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "SEL") == "F")
	            DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "SEL") = "";
	        else
	            DS_I_SEARCH.NameValue(DS_I_SEARCH.RowPosition, "SEL") = "F";
	    }  
	}
    
</script>
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_SAVE event=onFail>
    searchDoneWait();
    trFailed(TR_SAVE.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<script language=JavaScript for=TR_VALCHECK event=onFail>
    trFailed(TR_VALCHECK.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 협력사 KillFocus -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return
        
    if(EM_VEN_CD.Text != "")
        getVenInfo(EM_VEN_CD, EM_VEN_NM, false);
    else
        EM_VEN_NM.Text = "";
    
</script>

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
        EM_S_PUMBUM_NM.Text = "";  
</script>

<!-- 기준년월 KillFocus -->
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
    if(LC_PAY_CYC.BindColVal == "1")
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
<comment id="_NSID_"><object id="DS_IO_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEARCH"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEARCH_TMP" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LIST"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->

<comment id="_NSID_">
    <object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

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

<comment id="_NSID_">
<object id="TR_VALCHECK" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_LIST");
    
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
    <td class="PT01 PB03">
    
    <table width="85%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th rowspan="6" width="80" class="point">대금지불<BR>처리작업</th>
            <td rowspan="2" width = "175"><input type="checkbox" id="CHK1" tabindex=1 />특정/임대을  지불 대상액 확정</td>
          <tr>
          <!-- 
            <td width = "180"><input type="checkbox" id="CHK6" tabindex=2 />특정 매출수수료 SAP I/F</td>
            <td><input type="checkbox" id="CHK8" tabindex=2 />특정 매출수수료 SAP I/F (역분개)</td>
          </tr>
           
            <td width = "180"><input type="checkbox" id="CHK10" tabindex=3 />임대을 매출수수료 SAP I/F</td>
            <td><input type="checkbox" id="CHK11" tabindex=3 />임대을 매출수수료 SAP I/F (역분개)</td>
          </tr>
           -->
          <tr>
            <td><input type="checkbox" id="CHK2" tabindex=4 visible="False" />공제확정</td>
          </tr>
          <!-- 
            <td><input type="checkbox" id="CHK7" tabindex=5 />공제 SAP I/F</td>
            <td><input type="checkbox" id="CHK9" tabindex=6 />공제 SAP I/F (역분개)</td>
           -->
          <tr>
            <td colspan=3><input type="checkbox" id="CHK3" tabindex=7 />선급금/보류 확정</td>
          </tr>
          <tr>
            <td colspan=3><input type="checkbox" id="CHK4" tabindex=8 />실지불액 확정</td>
          </tr>
          <tr>
            <td colspan=3><input type="checkbox" id="CHK5" tabindex=9 />이월처리</td>
          </tr>
          <tr>
            <th class="point">지불작업년월</th>
            <td colspan=3>
                  <comment id="_NSID_">
                      <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=10 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_YYYYMM)"  align="absmiddle"/>
            </td>
          </tr>
          <tr>
            <th class="point">지불주기</th>
            <td colspan=3>
                    <comment id="_NSID_">
                        <object id=LC_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=364 tabindex=11 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th class="point">지불회차</th>
            <td colspan=3>
                    <comment id="_NSID_">
                        <object id=LC_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=364 tabindex=12 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>매출기간</th>
            <td colspan=3>
                  <comment id="_NSID_">
                      <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=173 tabindex=13 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  ~
                  <comment id="_NSID_">
                      <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=174 tabindex=14 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
            </td>            
          </tr>
          <tr>
            <th>점</th>
            <td colspan=3>
                    <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=364 tabindex=15 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
          </tr>
          <tr>
             <th>협력사</th>
             <td colspan=3>
               <comment id="_NSID_"> 
                   <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=108 tabindex=16 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_VEN_CD, EM_VEN_NM, true);" />
               <comment id="_NSID_"> 
                   <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=228 tabindex=17 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>
             </td>
         </tr>
         <tr>
         <th>브랜드</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=108 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();"  />
               <comment id="_NSID_"> 
                   <object id=EM_S_PUMBUM_NM classid=<%=Util.CLSID_EMEDIT%> width=228 tabindex=1 align="absmiddle" > </object> 
               </comment><script>_ws_(_NSID_);</script>
             </td>
          </tr>   
          <tr>
             <td colspan=4 align="Right">
               <img src="/<%=dir%>/imgs/btn/process.gif" id="IMG_porcess" align="absmiddle" onclick="javascript:process();" /> 
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
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td><b> [ 작업 현황 ] </b>
              </td>
          </tr>
          <tr>
          <td height=5></td>
          </tr>
          <tr valign="top">
              <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                      <td>
                        <comment id="_NSID_"> 
                            <OBJECT id=GR_LIST width=100% height=180 classid=<%=Util.CLSID_GRID%>>
                               <param name="DataID" value="DS_O_LIST">
                            </OBJECT> 
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                  </tr>
              </table>
              </td>
          </tr>
      </table>
      </td>
  </tr>
</table>
<comment id="_NSID_">
    <object id=BD_SEARCH classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_I_SEARCH>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=STR_CD              Ctrl=LC_STR_CD             param=BindColVal</c>
            <c>Col=PAY_YM              Ctrl=EM_YYYYMM             param=Text</c>
            <c>Col=PAY_CYC             Ctrl=LC_PAY_CYC            param=BindColVal</c>
            <c>Col=PAY_CNT             Ctrl=LC_PAY_CNT            param=BindColVal</c>
            <c>Col=TERM_S_DT           Ctrl=EM_SALE_S_DT          param=Text</c>
            <c>Col=TERM_E_DT           Ctrl=EM_SALE_E_DT          param=Text</c>      
            <c>Col=VEN_CD              Ctrl=EM_VEN_CD             param=Text</c>       
            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

