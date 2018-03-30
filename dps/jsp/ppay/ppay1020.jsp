<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 대금지불 > 세금계산서
 * 작 성 일 : 2010.04.11
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ppay1020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 발행대상 전표 매입세금계산서 생성
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
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-11
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

	 strToday = getTodayDB("DS_O_RESULT");
	 
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     // Output Data Set Header 초기화
   
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     // EMedit에 초기화
     initEmEdit(EM_VEN_CD,    "000000",   NORMAL);          // 협력사코드
     initEmEdit(EM_VEN_NM,    "GEN^40",   READ);            // 협력사명
     initEmEdit(EM_YYYYMM,    "THISMN",   PK);              // 매입년월
     initEmEdit(EM_SALE_S_DT, "YYYYMMDD", READ);            // 매입기간 시작일
     initEmEdit(EM_SALE_E_DT, "YYYYMMDD", READ);            // 매입기간 종료일
     initEmEdit(RD_ISSUE_FLAG ,"GEN"     , PK);              //구분(Y:생성, N:미생성) 

     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD,      "CODE^0^30,NAME^0^80", 1, PK);        // 점(조회)
     initComboStyle(LC_PAY_CYC,DS_O_PAY_CYC,     "CODE^0^30,NAME^0^80", 1, PK);        // 지불주기
     initComboStyle(LC_PAY_CNT,DS_O_PAY_CNT,     "CODE^0^30,NAME^0^80", 1, PK);        // 지불회차
     initComboStyle(LC_BIZ_TYPE,DS_O_BIZ_TYPE,   "CODE^0^30,NAME^0^80", 1, NORMAL);    // 거래형태
     initComboStyle(LC_TAX_FLAG,DS_O_TAX_FLAG,   "CODE^0^30,NAME^0^80", 1, NORMAL);    // 과세구분
     
     getStore("DS_IO_STR_CD",     "Y", "", "N");   
     getEtcCode("DS_O_PAY_CYC",   "D", "P052", "N");            // 조회지불주기
     getEtcCode("DS_O_PAY_CNT",   "D", "P407", "N");            // 조회지불회차
     getEtcCode("DS_IO_PAY_CNT",  "D", "P409", "N");            // 조회지불회차(그리드)
     getEtcCode("DS_O_BIZ_TYPE",  "D", "P215", "Y");            // 거래형태
     getEtcCode("DS_O_TAX_FLAG",  "D", "P004", "Y");            // 과세구분
     getEtcCode("DS_O_SLIP_FLAG", "D", "P201", "Y");            // 전표구분
     
     LC_STR_CD.index   = 0;
     LC_PAY_CYC.index  = 0;
     LC_PAY_CNT.index  = 0;
     LC_BIZ_TYPE.index = 0;
     LC_TAX_FLAG.index = 0;
     RD_ISSUE_FLAG.CodeValue = "%";
     LC_STR_CD.Focus();  
     
     getSaleDate("DS_O_SALE_DATE", EM_YYYYMM.Text, LC_PAY_CYC.BindColVal, LC_PAY_CNT.BindColVal);
     EM_SALE_S_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "S_DATE");
     EM_SALE_E_DT.Text = DS_O_SALE_DATE.NameValue(DS_O_SALE_DATE.RowPosition, "E_DATE"); 
 }

 function gridCreate1(){ 
     var hdrProperies = '<FC>id={currow}          name="NO"                width=30    Edit=none sumtext="합계"  align=center</FC>'
                      + '<FC>id=SEL               name="선택"              width=50    align=center Edit={IF(ISSUE_FLAG="N","true","false")} EditStyle=CheckBox  HeadCheckShow="true"   </FC>'
                      + '<FC>id=STR_CD            name="점"                width=80   Edit=none EditStyle=Lookup Data="DS_IO_STR_CD:CODE:NAME" align=left</FC>'
                      + '<FC>id=PAY_YM            name="매입년월"          width=60    Edit=none Mask="XXXX/XX" align=center</FC>'
                      + '<FC>id=PAY_CYC           name="지불주기"          width=60    Edit=none EditStyle=Lookup Data="DS_O_PAY_CYC:CODE:NAME" align=center</FC>'
                      + '<FC>id=PAY_CNT           name="지불회차"          width=60    Edit=none EditStyle=Lookup Data="DS_IO_PAY_CNT:CODE:NAME" align=center</FC>'
                      + '<FC>id=TAX_ISSUE_DT      name="세금계산서발행일"  width=110    Edit=none Mask="XXXX/XX/XX" align=center show=true</FC>'
                      + '<FC>id=TAX_ISSUE_SEQ_NO  name="순번"              width=40    Edit=none align=center show=false</FC>'
                      + '<FC>id=VEN_CD            name="협력사"            width=50    Edit=none align=center</FC>'
                      + '<FC>id=VEN_NM            name="협력사명"          width=130   Edit=none align=left</FC>'
                      + '<FC>id=PUMBUN_CD         name="브랜드코드"          width=130   Edit=none align=left show=false</FC>'
                      + '<FC>id=BIZ_TYPE          name="거래형태"          width=60    Edit=none EditStyle=Lookup Data="DS_O_BIZ_TYPE:CODE:NAME" align=center</FC>'
                      + '<FC>id=TAX_FLAG          name="과세구분"          width=60    Edit=none EditStyle=Lookup Data="DS_O_TAX_FLAG:CODE:NAME" align=center</FC>'
                      + '<FC>id=CHK_COST_TAMT     name="공급가액"          width=110   Edit=none sumtext=@sum align=right</FC>'
                      + '<FC>id=CHK_V_COST_TAMT   name="부가세액"          width=100   Edit=none sumtext=@sum align=right</FC>'
                      + '<FC>id=CHK_TOT_AMT       name="합계금액"          width=120   Edit=none sumtext=@sum align=right</FC>'
                      + '<FC>id=CHK_TOT_AMT       name="생성여부"          width=90    Edit=none Value={IF(ISSUE_FLAG="N","미생성","생성")} align=center </FC>'
                      + '<FC>id=RVS_ISSUE_FLAG    name="역발행구분"        width=90    Edit=none Value={IF(RVS_ISSUE_FLAG="1","정발행","역발행")} align=center </FC>'
                      ;
                      
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}          name="NO"             width=30     Edit=none sumtext="합계" align=center</FC>'
			          + '<FC>id=CHK_DT            name="검품확정일"      width=80    Edit=none Mask="XXXX/XX/XX" align=center</FC>'
			          + '<FC>id=SLIP_FLAG         name="구분"            width=40    EditStyle=Lookup Data="DS_O_SLIP_FLAG:CODE:NAME"  align=center</FC>'
			          + '<FC>id=SLIP_NO           name="전표번호"        width=100   Edit=none align=center Mask="XXXX-XXXXXXX"</FC>'
                      + '<FC>id=PUMBUN_CD         name="브랜드"            width=50    Edit=none align=center</FC>'
                      + '<FC>id=PUMBUN_NM         name="브랜드명"          width=100   Edit=none align=left</FC>'
                      + '<FC>id=CHK_COST_TAMT     name="공급가액"        width=110   Edit=none sumtext=@sum  align=right</FC>'
			          + '<FC>id=CHK_V_COST_TAMT   name="부가세액"        width=100   Edit=none sumtext=@sum  align=right</FC>'
			          + '<FC>id=CHK_TOT_AMT       name="합계금액"        width=110   Edit=none sumtext=@sum  align=right</FC>'
			          + '<FC>id=AUTO_SLIP         name="발생유형"        width=70    Edit=none align=left </FC>'
			          + '<FC>id=REMARK            name="비고"            width=200   Edit=none align=left </FC>';
         
     initGridStyle(GR_DETAIL, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-04-11
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 if(!checkValidation("Search"))
		  return;
	 
	 intSearchCnt = 0;
     bfListRowPosition = 0;
	 getMaster();
	 // 조회결과 Return
     setPorcCount("SELECT", GR_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-11
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-11
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-04-13
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
        TR_MAIN.Action="/dps/ppay102.pp?goTo=save&strFlag=save"; 
        TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_MAIN.Post();

        btn_Search();
    }   
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-11
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-11
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-11
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
 * 작 성 일 : 2010-04-13
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){

	DS_IO_MASTER.ClearData();
	DS_IO_DETAIL.ClearData();
    // 조회조건 셋팅
    var strStrCd     = LC_STR_CD.BindColVal;                    // 점
    var strYyyymm    = EM_YYYYMM.Text;                          // 매입년월
    var strPayCyc    = LC_PAY_CYC.BindColVal;                   // 지불주기
    var strPayCnt    = LC_PAY_CNT.BindColVal;                   // 지불회차
    var strVenCd     = EM_VEN_CD.Text;                          // 협력사코드
    var strBizType   = LC_BIZ_TYPE.BindColVal;                  // 거래구분
    var strTaxFlag   = LC_TAX_FLAG.BindColVal;                  // 과세구분
    var strSaleSdt   = EM_SALE_S_DT.Text;
    var strSaleEdt   = EM_SALE_E_DT.Text;
    var strIssueFlag = RD_ISSUE_FLAG.CodeValue;

    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)
                   +  "&strYyyymm="+encodeURIComponent(strYyyymm)
                   +  "&strPayCyc="+encodeURIComponent(strPayCyc)
                   +  "&strPayCnt="+encodeURIComponent(strPayCnt)
                   +  "&strVenCd="+encodeURIComponent(strVenCd)
                   +  "&strBizType="+encodeURIComponent(strBizType)
                   +  "&strTaxFlag="+encodeURIComponent(strTaxFlag)
                   +  "&strSaleSdt="+encodeURIComponent(strSaleSdt)
                   +  "&strSaleEdt="+encodeURIComponent(strSaleEdt)
                   +  "&strIssueFlag="+encodeURIComponent(strIssueFlag); 
    
    TR_MAIN.Action  = "/dps/ppay102.pp?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
 }
 
 /**
 * getDetail()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-04-13
 * 개    요 :  상세조회
 * return값 : void
 */
 function getDetail(){
	// 조회조건 셋팅
    var strStrCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");   // 점
    var strVenCd   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "VEN_CD");   // 협력사코드
    var strBizType = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BIZ_TYPE"); // 거래구분
    var strTaxFlag = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_FLAG"); // 과세구분
    var strSaleSdt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TERM_S_DT");
    var strSaleEdt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TERM_E_DT");
    var strTaxIssueDt    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_ISSUE_DT");
    var strTaxIssueSeqNo = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_ISSUE_SEQ_NO");
    var strPumbunCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
    
    var goTo         = "getDetail" ;    
    var action       = "O";     
    var parameters   = "&strStrCd="+encodeURIComponent(strStrCd)
				    +  "&strVenCd="+encodeURIComponent(strVenCd)
				    +  "&strBizType="+encodeURIComponent(strBizType)
				    +  "&strTaxFlag="+encodeURIComponent(strTaxFlag)
				    +  "&strSaleSdt="+encodeURIComponent(strSaleSdt)
                    +  "&strSaleEdt="+encodeURIComponent(strSaleEdt)
                    +  "&strTaxIssueDt="+encodeURIComponent(strTaxIssueDt)
                    +  "&strTaxIssueSeqNo="+encodeURIComponent(strTaxIssueSeqNo)
                    +  "&strPumbunCd="+encodeURIComponent(strPumbunCd); 
    
    TR_DETAIL.Action="/dps/ppay102.pp?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();

    GR_MASTER.ColumnProp('SEL','HeadCheck')= "FALSE";

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
         if(EM_YYYYMM.Text.length == 0){
        	 showMessage(INFORMATION, OK, "USER-1002", "매입년월");
             EM_YYYYMM.Focus();
             return false;
         }
         return true;
      }
      
      // 저장버튼 클릭시 Validation Check
      if(Gubun == "Save"){
    	  if(EM_SALE_S_DT.Text.length == 0 || EM_SALE_E_DT.Text.length == 0){
    		  showMessage(EXCLAMATION, OK, "USER-1087");
              EM_YYYYMM.Focus();
              return false;
    	  }
    	  
    	  var strStrCd    = DS_IO_MASTER.NameValue(1, "STR_CD");   
    	  var strPayYm    = DS_IO_MASTER.NameValue(1, "S_PAY_YM");
    	  var strPayCyc   = DS_IO_MASTER.NameValue(1, "S_PAY_CYC");
    	  var strPayCnt   = DS_IO_MASTER.NameValue(1, "S_PAY_CNT");
    	  var strSSaleSdt = DS_IO_MASTER.NameValue(1, "S_TERM_S_DT");
    	  var strSSaleEdt = DS_IO_MASTER.NameValue(1, "S_TERM_E_DT");
    	    
    	  if(!closeCheck(strSSaleSdt)){           // 마감체크(시작일)
    	      return false;
    	  }
    	  
    	  if(!closeCheck(strSSaleEdt)){           // 마감체크(종료일)
              return false;
          }
    	  
          if(!getIssueDate("DS_O_ISSUE_DATE",strStrCd,strPayYm,strPayCyc,strPayCnt)){
              return false;
          }
          
          if(ppayCloseCheck(strStrCd,strPayYm,strPayCyc,strPayCnt) == "TRUE"){
        	  showMessage(INFORMATION, OK, "USER-1150", "대금지불월", "매입세금계산서 생성");
        	  return false;
          }
          return true;
      }
  }
 
 /**
  * getVenInfo(code, name, btnFlag)
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-04-13
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name, btnFlag){
     var strStrCd        = LC_STR_CD.BindColVal;  
     var strUseYn        = "Y";                             // 사용여부
     var strPumBunType   = "0";                             // 브랜드유형
     var strBizType      = "";                              // 거래형태
     var strMcMiGbn      = "1";                             // 매출처/매입처구분(1:매입처)
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
 * closeCheck()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-09
 * 개    요    : 저장시 일마감체크를 한다. (마감시 생성가능)
 * return값 : void
 */
 function closeCheck(strCloseDt){
      var strStrCd         = LC_STR_CD.BindColVal;   // 점
      var strCloseTaskFlag = "PORD";                 // 업무구분(매입월마감)
      var strCloseUnitFlag = "42";                   // 단위업무
      var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
      var strCloseFlag     = "M";                    // 마감구분(월마감:M)
     
      var closeFlag = getCloseCheck( "DS_O_RESULT", strStrCd , strCloseDt , strCloseTaskFlag 
                                    , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
      
      if(closeFlag == "FALSE"){
          showMessage(EXCLAMATION, OK, "USER-1140", "매입월","매입세금계산서");
          return false;
      }else{
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
            setPorcCount("SELECT", DS_IO_DETAIL.CountRow);

    }

</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>
    if(clickSORT)
        return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- GR_MASTER event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
	if(colid != "SEL")
	    sortColId( eval(this.DataID), row, colid);
</script>
<!-- GR_DETAIL event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
	    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
    	if(dataSet.NameValue(i,"ISSUE_FLAG") == 'N')
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
<comment id="_NSID_"><object id="DS_IO_PAY_CNT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SLIP_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="80" class="point">매입년월</th>
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
            <th>거래형태</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_BIZ_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
            <th>과세구분</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_TAX_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >매입기간</th>
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
	         <th class="point">생성여부</th>
              <td colspan="3"><comment id="_NSID_"> <object
                  id=RD_ISSUE_FLAG classid=<%=Util.CLSID_RADIO%>
                  style="height: 20; width: 175" tabindex=2>
                  <param name=Cols value="3">
                  <param name=Format value="%^전체,Y^생성,N^미생성">
                  <param name=CodeValue value="0">
                  <param name=AutoMargin  value="true">
              </object> </comment> <script> _ws_(_NSID_);</script></td>
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
                    <OBJECT id=GR_MASTER width=100% height=170 classid=<%=Util.CLSID_GRID%>>
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
    <td class="dot"></td>
  </tr>

  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_DETAIL width=100% height=275 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_DETAIL">
                        <Param Name="ViewSummary"   value="1" >
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

