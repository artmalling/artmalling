<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 임대을 대금지불 산출현황
 * 작 성 일 : 2010.05.11
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : ppay3040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대을 대금지불 산출현황
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
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 200;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 strToday = getTodayDB("DS_O_RESULT");
	 
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     // Output Data Set Header 초기화
   
     //그리드 초기화
     gridCreate1(); //마스터     
     
     // EMedit에 초기화
     initEmEdit(EM_S_YYYYMM,         "THISMN",      PK);             // 매출년월
     initEmEdit(EM_S_SALE_S_DT,      "YYYYMMDD",    READ);           // 매출기간 시작일
     initEmEdit(EM_S_SALE_E_DT,      "YYYYMMDD",    READ);           // 매출기간 종료일
     initEmEdit(EM_S_VEN_CD,         "000000",      NORMAL);         // 협력사코드
     initEmEdit(EM_S_VEN_NM,         "GEN^40",      READ);           // 협력사명
     initEmEdit(EM_S_PUMBUN_CD,      "000000",      NORMAL);         // 브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,      "GEN^40",      READ);           // 브랜드명
     //initEmEdit(EM_PAY_DT,           "TODAY",       NORMAL);         // 지불일자
     
     //년월일 전달로 셋팅
     var strYyyyMm = EM_S_YYYYMM.Text + "01";
     EM_S_YYYYMM.Text = setDateAdd('M', -1, strYyyyMm).substring(0, 6);

     //콤보 초기화(조회조건)
     initComboStyle(LC_S_STR_CD,    DS_O_STR_CD,    "CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
     initComboStyle(LC_S_BUMUN,     DS_O_DEPT,      "CODE^0^30,NAME^0^80", 1, NORMAL);    // 조회용 팀     
     initComboStyle(LC_S_TEAM,      DS_O_TEAM,      "CODE^0^30,NAME^0^80", 1, NORMAL);    // 조회용 파트     
     initComboStyle(LC_S_PC,        DS_O_PC,        "CODE^0^30,NAME^0^80", 1, NORMAL);    // 조회용 PC
     initComboStyle(LC_S_PAY_CYC,   DS_O_PAY_CYC,   "CODE^0^30,NAME^0^80", 1, PK);        // 지불주기
     initComboStyle(LC_S_PAY_CNT,   DS_O_PAY_CNT,   "CODE^0^30,NAME^0^80", 1, PK);        // 지불회차    
     initComboStyle(LC_PAY_DT,      DS_O_PAY_DT,    "CODE^0^0,NAME^0^80",  1, NORMAL);    // 지불일자
     
     getStore("DS_O_STR_CD", "Y", "", "N");   
     getEtcCode("DS_O_PAY_CYC",   "D", "P052", "N");            // 조회지불주기
     getEtcCode("DS_O_PAY_CNT",   "D", "P407", "N");            // 조회지불회차
     
     //getPayDt();
     
     LC_S_STR_CD.index    = 0;
     LC_S_PAY_CYC.index   = 0;
     LC_S_PAY_CNT.index   = 0; 
     //LC_PAY_DT.index   = 0; 
     LC_S_STR_CD.Focus();
     
     getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
     EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}          name="NO"              width=30     align=center</FC>'
    	 			  + '<FC>id=PAY_DT            name="지불일자"        width=90     align=center  sumtext=""  mask="XXXX/XX/XX"</FC>'
			          + '<FC>id=SALE_ORG_TEAM_NM  name="파트"              width=100     align=left </FC>'
			          + '<FC>id=SALE_ORG_PC_NM    name="PC"              width=90     align=left </FC>'
			          + '<FC>id=VEN_CD            name="협력사코드"       width=70     align=center sumtext="합계"</FC>'
			          + '<FC>id=VEN_NM            name="협력사명"         width=120    align=left</FC>'
                      + '<FC>id=PUMBUN_CD         name="브랜드코드"         width=70     align=center</FC>'
                      + '<FC>id=PUMBUN_NM         name="브랜드명"           width=120     align=left</FC>'
                      + '<FC>id=EVENT_FLAG        name="마진코드"         width=60     align=center </FC>'
                      + '<FC>id=MG_RATE           name="마진율"           width=50    align=right  sumtext=@avg  </FC>'
                      + '<FC>id=SALE_TOT_AMT      name="총매출"           width=110     align=right  sumtext=@sum  </FC>'
                      + '<FC>id=REDU_AMT          name="할인"             width=90     align=right  sumtext=@sum  </FC>'
                      + '<FC>id=SALE_AMT          name="매출"             width=110     align=right  sumtext=@sum  </FC>'
                      + '<FC>id=SALE_COMIS_AMT    name="이익액"           width=100     align=right  sumtext=@sum  </FC>'
                      + '<FC>id=PAY_TRG_AMT       name="지불대상액"        width=100     align=right  sumtext=@sum  </FC>';
                      
     initGridStyle(GR_MASTER, "common", hdrProperies, false);     

     GR_MASTER.ViewSummary = "1";      
     //DS_IO_MASTER.SubSumExpr  = "VEN_CD"; 
     //GR_MASTER.ColumnProp("VEN_CD", "SubSumText")        = "소계";  
     GR_MASTER.ColumnProp("VEN_CD", "sumtext")           = "합계";  
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 if(checkValidation("Search")){
		 intSearchCnt = 0;
	     bfListRowPosition = 0;
	     getMaster();
	     // 조회결과 Return
	     setPorcCount("SELECT", GR_MASTER);
         
         if(DS_IO_MASTER.CountRow == 0)
             LC_S_STR_CD.Focus(); 
	 } 
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-05-11
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
		if(DS_IO_MASTER.CountRow <= 0){
		      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
		        return;
		    }
		    var strTitle = "임대을 대금지불 산출현황";
		    
		    var strStrCd   = LC_S_STR_CD.BindColVal;                    // 점
		    var strBumun   = LC_S_BUMUN.BindColVal;                     // 팀
		    var strTeam    = LC_S_TEAM.BindColVal;                      // 파트
		    var strPc      = LC_S_PC.BindColVal;                        // PC
		    var strYyyymm  = EM_S_YYYYMM.Text;                          // 매출년월
		    var strPayCyc  = LC_S_PAY_CYC.BindColVal;                   // 지불주기
		    var strPayCnt  = LC_S_PAY_CNT.BindColVal;                   // 지불회차
		    var strPayDt   = LC_PAY_DT.BindColVal;                      // 지불일자
		    var strSaleSdt = EM_S_SALE_S_DT.Text;                       // 매출기간시작
		    var strSaleEdt = EM_S_SALE_E_DT.Text;                       // 매출기간종료 
		    var strVenCd   = EM_S_VEN_CD.Text;                          // 협력사         
		    var strPumbunCd= EM_S_PUMBUN_CD.Text;                       // 브랜드         
		    
		    var parameters = "점 "           + strStrCd
		                   + " ,   팀 "    + strBumun
		                   + " ,   파트 "      + strTeam
		                   + " ,   PC "     + strPc
		                   + " ,   매출년월 " + strYyyymm
		                   + " ,   지불주기 " + strPayCyc
		                   + " ,   지불회차 " + strPayCnt
		                   + " ,   지불일자 " + strPayDt
		                   + " ,   매출기간 " + strSaleSdt 
		                   + " ~ " + strSaleEdt
		                   + " ,   협력사 "   + strVenCd
		                   + "     브랜드 "   + strPumbunCd;
		    
		    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
//		    openExcel2(GR_MASTER, strTitle, parameters, true );
		    openExcel5(GR_MASTER, strTitle, parameters, true , "",g_strPid );

}

/**
 * btn_Print()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-11
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){

    // 조회조건 셋팅
    var strStrCd   = LC_S_STR_CD.BindColVal;                    // 점
    var strBumun   = LC_S_BUMUN.BindColVal;                     // 팀
    var strTeam    = LC_S_TEAM.BindColVal;                      // 파트
    var strPc      = LC_S_PC.BindColVal;                        // PC
    var strYyyymm  = EM_S_YYYYMM.Text;                          // 매출년월
    var strPayCyc  = LC_S_PAY_CYC.BindColVal;                   // 지불주기
    var strPayCnt  = LC_S_PAY_CNT.BindColVal;                   // 지불회차
    var strPayDt   = LC_PAY_DT.BindColVal;                      // 지불일자
    var strSaleSdt = EM_S_SALE_S_DT.Text;                       // 매출기간시작
    var strSaleEdt = EM_S_SALE_E_DT.Text;                       // 매출기간종료 
    var strVenCd   = EM_S_VEN_CD.Text;                          // 협력사         
    var strPumbunCd= EM_S_PUMBUN_CD.Text;                       // 브랜드         

    var goTo       = "getMaster";    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                   + "&strBumun="+encodeURIComponent(strBumun) 
                   + "&strTeam="+encodeURIComponent(strTeam) 
                   + "&strPc="+encodeURIComponent(strPc) 
                   + "&strYyyymm="+encodeURIComponent(strYyyymm) 
                   + "&strPayCyc="+encodeURIComponent(strPayCyc)   
                   + "&strPayCnt="+encodeURIComponent(strPayCnt)
                   + "&strPayDt=" +encodeURIComponent(strPayDt) 
                   + "&strVenCd="+encodeURIComponent(strVenCd)  
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd); 
                   
    TR_MAIN.Action  = "/dps/ppay304.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
 }
 
 /**
  * getPayDt()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-04-25
  * 개    요        : 지불일자  콤보 세팅을 위한 dataSet을 가져오는 함수 
  * return값 : void
  */
  function getPayDt() {
	DS_O_PAY_DT.ClearData();
	
	var strStrCd   = LC_S_STR_CD.BindColVal;                    // 점
	var strYyyymm  = EM_S_YYYYMM.Text;                          // 매출년월
	var strPayCyc  = LC_S_PAY_CYC.BindColVal;                   // 지불주기
	var strPayCnt  = LC_S_PAY_CNT.BindColVal;                   // 지불회차 
	var goTo         = "getPayDt" ;    
 	var action       = "O";     
 	var parameters = "&strStrCd="+encodeURIComponent(strStrCd)   
                   + "&strYyyymm="+encodeURIComponent(strYyyymm)   
                   + "&strPayCyc="+encodeURIComponent(strPayCyc)   
                   + "&strPayCnt="+encodeURIComponent(strPayCnt);
 	   
 	 TR_DETAIL.Action="/dps/ppay304.pp?goTo="+goTo+parameters;  
 	 TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_PAY_DT=DS_O_PAY_DT)"; //조회는 O
 	 TR_DETAIL.Post();
  }
 
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-05-11
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
     var strStrCd        = LC_S_STR_CD.BindColVal;  
     var strUseYn        = "Y";                             // 사용여부
     var strPumBunType   = "";                              // 브랜드유형
     var strBizType      = "3";                             // 거래형태(3:임대을)
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
  * searchPumbunPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunPop(){
      var tmpOrgCd        = LC_S_STR_CD.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
      var strVenCd        = EM_S_VEN_CD.Text;                                          // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                        // 단품구분
      var strSkuType      = "";                                                        // 단품종류
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "3";                                                       // 거래형태(3:임대을) 
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
       var tmpOrgCd        = LC_S_STR_CD.BindColVal;
       var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
       var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
       var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
       var strVenCd        = EM_S_VEN_CD.Text;                                          // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "";                                                        // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "";                                                        // 단품구분
       var strSkuType      = "";                                                        // 단품종류
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "3";                                                       // 거래형태(3:임대을) 
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

   
  /**
   * checkValidation()
   * 작 성 자     : 박래형
   * 작 성 일     : 2010-05-11
   * 개    요        :  값 체크 
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       var messageCode = "USER-1001";
       
       //조회버튼 클릭시 Validation Check
       if(Gubun == "Search"){    
           
           if(EM_S_YYYYMM.Text.length == 0){
               showMessage(INFORMATION, OK, "USER-1002", "매입/매출년월");
               EM_S_YYYYMM.Focus();
               return false;
           }
           
    	   return true;
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
<script language=JavaScript for=DS_I_SEARCH event=OnColumnChanged(row,colid)>
/*
    switch (colid) {
    case "PAY_YM":
    	EM_S_SALE_S_DT.Text = "";
        EM_S_SALE_E_DT.Text = "";
    	getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
    	EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
        EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
        break;
    }
*/
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
    switch (colid) {
    case "TAX_ITEM_VAT_AMT":
    	this.NameValue(row,"TAX_ITEM_TOT_AMT") = this.NameValue(row,"TAX_ITEM_SUP_AMT")
    	                                           + this.NameValue(row,"TAX_ITEM_VAT_AMT");
    	EM_VAT_AMT.Text = this.NameValue(row,"TAX_ITEM_VAT_AMT");
    	EM_TOT_AMT.Text = this.NameValue(row,"TAX_ITEM_TOT_AMT");
    	break;

    }

</script>

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid, "DS_IO_MASTER" );
</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>

if(clickSORT)
    return;

    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        if(intSearchCnt == 0){
            intSearchCnt++;
        }else
            setPorcCount("SELECT", DS_IO_DETAIL.CountRow);

    }

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 그리드 CHECK BOX 전체 선택 -->

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    if(LC_S_STR_CD.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_S_STR_CD.BindColVal, "Y");                                              // 팀 
        LC_S_BUMUN.Index = 0;
    }
/*
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
*/
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_S_BUMUN event=OnSelChange()>
    if(LC_S_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_S_STR_CD.BindColVal, LC_S_BUMUN.BindColVal, "Y");                       // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_S_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    
    LC_S_TEAM.Index = 0;   
/*
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
*/
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_S_TEAM event=OnSelChange()>
    if(LC_S_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_S_STR_CD.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    
    LC_S_PC.Index = 0;  
/*
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
*/
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_S_PC event=OnSelChange()>
/*
    EM_S_PB_CD.Text  = "";
    EM_S_PB_NM.Text  = "";
*/
</script>

<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
        dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
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

<!-- 매출년월 KillFocus -->
<script language=JavaScript for=EM_S_YYYYMM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    checkDateTypeYM(EM_S_YYYYMM);
    EM_S_SALE_S_DT.Text = "";
    EM_S_SALE_E_DT.Text = "";
    getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
    EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
    
    getPayDt();
    LC_PAY_DT.Index = 0;

</script>

<!-- 지불주기 변경시  -->
<script language=JavaScript for=LC_S_PAY_CYC event=OnSelChange()>
    EM_S_SALE_S_DT.Text = "";
    EM_S_SALE_E_DT.Text = "";
    
    DS_O_PAY_CNT.ClearData();
    if(LC_S_PAY_CYC.BindColVal == "1")
        getEtcCode("DS_O_PAY_CNT", "D", "P407", "N");         // 지불회차
    else if(LC_S_PAY_CYC.BindColVal == "2")
        getEtcCode("DS_O_PAY_CNT", "D", "P408", "N");         // 지불회차
    else if(LC_S_PAY_CYC.BindColVal == "3")
        getEtcCode("DS_O_PAY_CNT", "D", "P409", "N");         // 지불회차
        
    LC_S_PAY_CNT.index = 0;
</script>

<!-- 지불회차 변경시  -->
<script language=JavaScript for=LC_S_PAY_CNT event=OnSelChange()>
    EM_S_SALE_S_DT.Text = "";
    EM_S_SALE_E_DT.Text = "";

    getSaleDate("DS_O_SALE_DATE", EM_S_YYYYMM.Text, LC_S_PAY_CYC.BindColVal, LC_S_PAY_CNT.BindColVal);
    EM_S_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
    EM_S_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
    
    getPayDt();
    LC_PAY_DT.Index = 0;
</script>

<!-- 지불일자 onKillFocus() 
<script language=JavaScript for=EM_PAY_DT event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(!checkDateTypeYMD(EM_PAY_DT)){
        initEmEdit(EM_PAY_DT,    "TODAY",     PK);        
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
<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_DT"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ETAX_STAT" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEARCH"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SLIP_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_DATE"classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="70" class="point">점</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">팀</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_S_BUMUN classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="100">파트</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_S_TEAM classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">PC</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_S_PC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          
          <tr>
            <th class="point">매출년월</th>
            <td>
                  <comment id="_NSID_">
                      <object id=EM_S_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_YYYYMM)"  align="absmiddle"/>
            </td>
            <th class="point">지불주기</th>
            <td >
                    <comment id="_NSID_">
                        <object id=LC_S_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point">지불회차</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_S_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >지불일자</th>
            <td>
            		<comment id="_NSID_">
                        <object id=LC_PAY_DT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          
          <tr>
            <th>매출기간</th>
            <td colspan="7">
                  <comment id="_NSID_">
                      <object id=EM_S_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=97 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  ~
                  <comment id="_NSID_">
                      <object id=EM_S_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=97 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
            </td>         
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
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
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
  
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                    <td>
                          <comment id="_NSID_"> 
                              <OBJECT id=GR_MASTER width=100% height=437 classid=<%=Util.CLSID_GRID%>>
                                 <param name="DataID" value="DS_IO_MASTER">
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

 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_I_SEARCH>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=STR_CD              Ctrl=LC_S_STR_CD             param=BindColVal</c>
            <c>Col=PAY_YM              Ctrl=EM_S_YYYYMM             param=Text</c>
            <c>Col=PAY_CYC             Ctrl=LC_S_PAY_CYC            param=BindColVal</c>
            <c>Col=PAY_CNT             Ctrl=LC_S_PAY_CNT            param=BindColVal</c>
            <c>Col=BIZ_TYPE            Ctrl=LC_S_BIZ_TYPE           param=BindColVal</c>
            <c>Col=TAX_FLAG            Ctrl=LC_S_TAX_FLAG           param=BindColVal</c>
            <c>Col=TERM_S_DT           Ctrl=EM_S_SALE_S_DT          param=Text</c>
            <c>Col=TERM_E_DT           Ctrl=EM_S_SALE_E_DT          param=Text</c>      
            <c>Col=VEN_CD              Ctrl=EM_S_VEN_CD             param=Text</c>  
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>
