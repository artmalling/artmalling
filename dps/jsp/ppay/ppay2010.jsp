<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 선급금/공제/보류 조회
 * 작 성 일 : 2010.05.03
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 선급금/공제/보류 조회
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
var strToday          = "";                            // 현재날짜
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 350;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_IO_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     DS_IO_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     DS_IO_DETAIL3.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     // Output Data Set Header 초기화
   
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     gridCreate3(); //디테일2
     gridCreate4(); //디테일3
     
     // EMedit에 초기화
     initEmEdit(EM_VEN_CD,    "000000",   NORMAL);          // 협력사코드
     initEmEdit(EM_VEN_NM,    "GEN^40",   READ);            // 협력사명
     initEmEdit(EM_YYYYMM,    "THISMN",   PK);              // 매입년월
     initEmEdit(EM_SALE_S_DT, "YYYYMMDD", READ);            // 매입기간 시작일
     initEmEdit(EM_SALE_E_DT, "YYYYMMDD", READ);            // 매입기간 종료일
     initEmEdit(EM_S_PUMBUN_CD,      "000000",      NORMAL);         // 브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,      "GEN^40",      READ);           // 브랜드명
     

     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD,      "CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
     initComboStyle(LC_PAY_CYC,DS_O_PAY_CYC,     "CODE^0^30,NAME^0^80", 1, PK);        // 지불주기
     initComboStyle(LC_PAY_CNT,DS_O_PAY_CNT,     "CODE^0^30,NAME^0^80", 1, PK);        // 지불회차
     
     getStore("DS_IO_STR_CD",     "Y", "", "N");   
     getEtcCode("DS_O_PAY_CYC",   "D", "P052", "N");            // 조회지불주기
     getEtcCode("DS_O_PAY_CNT",   "D", "P407", "N");            // 조회지불회차
     getEtcCode("DS_O_SLIP_FLAG", "D", "P201", "Y");            // 전표구분
     
     LC_STR_CD.index   = 0;
     LC_PAY_CYC.index  = 0;
     LC_PAY_CNT.index  = 0;
     LC_STR_CD.Focus(); 
     
     getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
     EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE");
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}          name="NO"                width=30    Edit=none sumtext="합계"  align=center</FC>'
                      + '<FC>id=SEL               name="선택"              width=60    align=center EditStyle=CheckBox  HeadCheckShow="true"    show=false</FC>'
                      + '<FC>id=STR_CD            name="점"                width=80    Edit=none EditStyle=Lookup Data="DS_IO_STR_CD:CODE:NAME" align=center</FC>'
                      + '<FC>id=PAY_YM            name="지불년월"          width=80    Edit=none Mask="XXXX/XX" align=center</FC>'
                      + '<FC>id=PAY_CYC           name="지불주기"          width=80    Edit=none EditStyle=Lookup Data="DS_O_PAY_CYC:CODE:NAME" align=center</FC>'
                      + '<FC>id=PAY_CNT           name="지불회차"          width=80    Edit=none EditStyle=Lookup Data="DS_O_PAY_CNT:CODE:NAME" align=center</FC>'
                      + '<FC>id=TAX_ISSUE_DT      name="세금계산서발행일"  width=110    Edit=none align=center show=false</FC>'
                      + '<FC>id=TAX_ISSUE_SEQ_NO  name="순번"              width=40    Edit=none align=center show=false</FC>'
                      + '<FC>id=VEN_CD            name="협력사코드"        width=70    Edit=none align=left</FC>'
                      + '<FC>id=VEN_NM            name="협력사명"          width=90    Edit=none align=left</FC>'
                      + '<FC>id=PUMBUN_CD         name="브랜드코드"         width=70     align=center</FC>'
                      + '<FC>id=PUMBUN_NM         name="브랜드명"           width=120     align=left</FC>'
                      + '<FC>id=PAY3              name="선급금금액"        width=95    Edit=none sumtext=@sum align=right</FC>'
                      + '<FC>id=PAY1              name="보류금액"          width=90    Edit=none sumtext=@sum align=right</FC>'
                      + '<FC>id=PAY21              name="공제금액(공제)"          width=90    Edit=none sumtext=@sum align=right</FC>'
                      + '<FC>id=PAY22              name="공제금액(입금)"          width=90    Edit=none sumtext=@sum align=right</FC>';
                      ;
                      
     initGridStyle(GR_MASTER, "common", hdrProperies, false);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"               width=30     Edit=none sumtext="합계" align=center shoe=false</FC>'
                      + '<FC>id=INPUT_DT          name="선급금지불일"      width=80     EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
                      + '<FC>id=SEQ_NO            name="순번"              width=50     Edit=none align=center </FC>'
                      + '<FC>id=REASON_CD         name="선급금코드"        width=70     align=center</FC>'
                      + '<FC>id=REASON_NM         name="선급금명"          width=100    Edit=none align=left</FC>'
                      + '<FC>id=INPUT_AMT         name="선급금금액"        width=80     sumtext=@sum align=rigth</FC>'
                      + '<FC>id=REMARK            name="비고"              width=80     align=left</FC>';
         
     initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
 }

 function gridCreate3(){
     var hdrProperies = '<FC>id={currow}         name="NO"                width=30     Edit=none sumtext="합계" align=center shoe=false</FC>'
			         + '<FC>id=INPUT_DT          name="보류등록일"        width=80     EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
			         + '<FC>id=SEQ_NO            name="순번"              width=50     Edit=none align=center </FC>'
			         + '<FC>id=REASON_CD         name="보류코드"          width=50     align=center</FC>'
			         + '<FC>id=REASON_NM         name="보류명"            width=100    Edit=none align=left</FC>'
			         + '<FC>id=INPUT_AMT         name="보류금액"          width=80     sumtext=@sum align=rigth</FC>'
			         + '<FC>id=REMARK            name="비고"              width=80     align=left</FC>';
     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
 }

 function gridCreate4(){
     var hdrProperies = '<FC>id={currow}         name="NO"               width=30     Edit=none sumtext="합계" align=center shoe=false</FC>'
			         + '<FC>id=INPUT_DT          name="공제등록일"        width=80     EditStyle=Popup Mask="XXXX/XX/XX" align=center</FC>'
			         + '<FC>id=SEQ_NO            name="순번"             width=50     Edit=none align=center </FC>'
			         + '<FC>id=REASON_CD         name="공제코드"         width=50     align=center</FC>'
                     + '<FC>id=REASON_NM         name="공제명"           width=100    Edit=none align=left</FC>'
                     + '<FC>id=VAT_YN            name="VAT여부"          width=70     align=left</FC>'
                     + '<FC>id=CASH_IN_YN        name="입금여부"          width=70     align=left</FC>'
			         + '<FC>id=INPUT_AMT         name="공제금액"         width=80     sumtext=@sum align=rigth</FC>'
			         + '<FC>id=REMARK            name="비고"             width=80     align=left</FC>';
     initGridStyle(GR_DETAIL3, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-05-03
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 DS_IO_DETAIL1.ClearData();
	 DS_IO_DETAIL2.ClearData();
	 DS_IO_DETAIL3.ClearData();
     intSearchCnt = 0;
     bfListRowPosition = 0;
     getMaster();
     // 조회결과 Return
     setPorcCount("SELECT", GR_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL1.DeleteRow(DS_IO_DETAIL1.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-05-03
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }

    if(!checkValidation("Save"))
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){    // validation 체크
        TR_MAIN.Action="/dps/ppay201.pp?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }   
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
		if(DS_IO_MASTER.CountRow <= 0){
		      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
		        return;
		    }
		    var strTitle = "선급금 공제 보류 조회";
		    
		    var strStrCd   = LC_STR_CD.BindColVal;                    // 점
		    var strYyyymm  = EM_YYYYMM.Text;                          // 매입년월
		    var strPayCyc  = LC_PAY_CYC.BindColVal;                   // 지불주기
		    var strPayCnt  = LC_PAY_CNT.BindColVal;                   // 지불회차
		    var strVenCd   = EM_VEN_CD.Text;                          // 협력사코드
		    var strPumCd   = EM_S_PUMBUN_CD.Text;                  // 브랜드코드
		    
		    var parameters = "점 "           + strStrCd
		                   + " ,   매출년월 " + strYyyymm
		                   + " ,   지불주기 " + strPayCyc
		                   + " ,   지불회차 " + strPayCnt
		                   + " ,   협력사 "   + strVenCd
		                   + "     브랜드 "   + strPumCd;
		    
		    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
//		    openExcel2(GR_MASTER, strTitle, parameters, true );
		    openExcel5(GR_MASTER, strTitle, parameters, true , "",g_strPid );

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){

    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL1.ClearData();                
    // 조회조건 셋팅
    var strStrCd   = LC_STR_CD.BindColVal;                    // 점
    var strYyyymm  = EM_YYYYMM.Text;                          // 매입년월
    var strPayCyc  = LC_PAY_CYC.BindColVal;                   // 지불주기
    var strPayCnt  = LC_PAY_CNT.BindColVal;                   // 지불회차
    var strVenCd   = EM_VEN_CD.Text;                          // 협력사코드
    var strPumCd   = EM_S_PUMBUN_CD.Text;                  // 브랜드코드

    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)
                   +  "&strYyyymm="+encodeURIComponent(strYyyymm)
                   +  "&strPayCyc="+encodeURIComponent(strPayCyc)
                   +  "&strPayCnt="+encodeURIComponent(strPayCnt)
                   +  "&strVenCd="+encodeURIComponent(strVenCd)
    			   +  "&strPumCd="+encodeURIComponent(strPumCd); 
    
    TR_MAIN.Action  = "/dps/ppay201.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
 }
 
 /**
 * getDetail()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 :  상세조회
 * return값 : void
 */
 function getDetail(){
    // 조회조건 셋팅
    var strStrCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");   // 점
    var strYyyymm  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_YM");   // 매입년월
    var strPayCyc  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CYC");  // 지불주기
    var strPayCnt  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PAY_CNT");  // 지불회차
    var strVenCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");   // 협력사코드
    var strPumCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");   // 브랜드코드

    var goTo         = "getDetail" ;    
    var action       = "O";     
    var parameters   =  "&strStrCd="+encodeURIComponent(strStrCd)
				     +  "&strYyyymm="+encodeURIComponent(strYyyymm)
				     +  "&strPayCyc="+encodeURIComponent(strPayCyc)
				     +  "&strPayCnt="+encodeURIComponent(strPayCnt)
				     +  "&strVenCd="+encodeURIComponent(strVenCd)
    				 +  "&strPumCd="+encodeURIComponent(strPumCd);
    
    TR_DETAIL.Action="/dps/ppay201.pp?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL1=DS_IO_DETAIL1,"
                                 +action+":DS_IO_DETAIL2=DS_IO_DETAIL2,"
                                 +action+":DS_IO_DETAIL3=DS_IO_DETAIL3)"; //조회는 O
    TR_DETAIL.Post();
 }
 
 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-04-13
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
      
      var messageCode = "USER-1001";
      
      //조회버튼 클릭시 Validation Check
      if(Gubun == "Search"){   
         
      }
      return true;
  }
 
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-05-03
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
       var strVenCd        = EM_VEN_CD.Text;                                          // 협력사
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

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	if(clickSORT)
	    return;

    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        getDetail();
        if(intSearchCnt == 0){
            // 조회결과 Return
            setPorcCount("SELECT", GR_MASTER);
            intSearchCnt++;
        }else
            setPorcCount("SELECT", DS_IO_DETAIL1.CountRow);

    }

</script>
<script language=JavaScript for=DS_IO_DETAIL1 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<script language=JavaScript for=DS_IO_DETAIL2 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<script language=JavaScript for=DS_IO_DETAIL3 event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GR_DETAIL1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GR_DETAIL2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GR_DETAIL3 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
        dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
</script>
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
<comment id="_NSID_"><object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CYC"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PAY_CNT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SLIP_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL1"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL3"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="80" class="point">점</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
            <th width="80" class="point">조회년월</th>
            <td width="110">
                  <comment id="_NSID_">
                      <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_YYYYMM)"  align="absmiddle"/>
            </td>
            <th width="80" class="point">지불주기</th>
            <td width="110">
                    <comment id="_NSID_">
                        <object id=LC_PAY_CYC classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">지불회차</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_PAY_CNT classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >매입/매출기간</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=144 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  ~
                  <comment id="_NSID_">
                      <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=143 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
            </td>
            <td colspan="4"></td>
           </tr>
           <tr>
             <th>협력사</th>
             <td colspan="3">
               <comment id="_NSID_"> 
                   <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=88 tabindex=1 align="absmiddle"> </object> 
               </comment><script> _ws_(_NSID_);</script>
               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_VEN_CD, EM_VEN_NM, true);" />
               <comment id="_NSID_"> 
                   <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=190 tabindex=1 align="absmiddle" > </object> 
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

  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_MASTER width=100% height=285 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                        <Param Name="ViewSummary"   value="1" >
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>  
  <tr>
    <td height="5">
    </td>
  </tr>
  <tr valign="top">  
    <td width="100%">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">   
      <tr valign="middle" height=20>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td width="270" >
                <b>[선급금]</b>
            </td>
            <td width="3">
            </td>
            <td width="270">
                <b>[보류]</b>
            </td>
            <td width="3">
            </td>
            <td>
                <b>[공제]</b>
            </td>
          </tr>
        </table></td>
      </tr>
         
      <tr valign="top" align="">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td width="270" class="BD4A">
	            <comment id="_NSID_">
	                <OBJECT id=GR_DETAIL1 width=100% height=156 classid=<%=Util.CLSID_GRID%>>
	                    <param name="DataID" value="DS_IO_DETAIL1">
	                    <Param Name="ViewSummary"   value="1" >
	                </OBJECT>
	            </comment><script>_ws_(_NSID_);</script>
            </td>
            <td width="3">
            </td>
            <td width="270" class="BD4A">
	                <comment id="_NSID_">
	                    <OBJECT id=GR_DETAIL2 width=100% height=156 classid=<%=Util.CLSID_GRID%>>
	                        <param name="DataID" value="DS_IO_DETAIL2">
	                        <Param Name="ViewSummary"   value="1" >
	                    </OBJECT>
	                </comment><script>_ws_(_NSID_);</script>
            </td>
            <td width="3">
            </td>
            <td class="BD4A">
	            <comment id="_NSID_">
	                <OBJECT id=GR_DETAIL3 width=100% height=156 width=100% classid=<%=Util.CLSID_GRID%>>
	                    <param name="DataID" value="DS_IO_DETAIL3">
	                    <Param Name="ViewSummary"   value="1" >
	                </OBJECT>
	            </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table>
    </td>
  </tr>

</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

