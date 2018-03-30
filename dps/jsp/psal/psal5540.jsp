<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > OK캐쉬백상품권교환현황
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : psal5540.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : OK캐쉬백매출현황을 조회한다
 * 이    력 :
 *        2010.04.08 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir          = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단
 /**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    
    //EMEDIT 설정
    setEmEdit();
    
    //콤보 초기화
    setCombo();

    //그리드 초기화
    gridCreate();
    
    //화면로딩시 점콤보에 포커스
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2010-04-08
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_APP_S_DT, "SYYYYMMDD"  , PK);    //조회 시작일
    initEmEdit(EM_APP_E_DT, "TODAY"      , PK);    //조회 종료일
    initEmEdit(EM_POS_NO  , "NUMBER2^4^0", NORMAL);//포스번호
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
	 //initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^140", 1, PK);       //점(조회) 콤보
	 initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^140", 1, READ);       //점(조회) 콤보
	    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    //LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드
    LC_STR_CD.BindColVal = '01'; // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;

}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : OK캐쉬백매출현황 MASTER 및 DETAIL 그리드 초기화 
 * return값 : void
*/
function gridCreate(){
    //MASTER 그리드
    var hdrProperies = '<C>id={currow}    width=30  align=center name="NO"</C>'
                     + '<C>id=TRAN_DT     width=80  align=center name="매출일자" mask="XXXX/XX/XX" SUMTEXT="합계"</C>'
                     + '<G>name="합계"'
                     + '<C>id=TOT_SUM_CNT     width=80  align=right  name="건수" SUMTEXT=@SUM</C>'
                     + '<C>id=TOT_SUM_AMT     width=100  align=right  name="OCB" SUMTEXT=@SUM</C>'
				     + '<C>id=TOT_CONV_POINT           width=100  show=true align=right name="포인트" SUMTEXT=@SUM</C>'
				     + '<C>id=TOT_CONV_GIFT_AMT        width=100  show=true align=right name="상품권금액" SUMTEXT=@SUM</C>'
                     + '</G>'
                     + '<G>name="OCB 상품권교환 "'
                     + '<C>id=OCC_CNT     width=80  align=right  name="건수" SUMTEXT=@SUM</C>'
                     + '<C>id=TOT_AMT     width=100  align=right  name="OCB" SUMTEXT=@SUM</C>'
				     + '<C>id=CONV_POINT           width=100  show=true align=right name="포인트" SUMTEXT=@SUM</C>'
				     + '<C>id=CONV_GIFT_AMT        width=100  show=true align=right name="상품권금액" SUMTEXT=@SUM</C>'
                     + '</G>'
                     + '<G>name="OCB 상품권교환 취소"'
                     + '<C>id=RTN_OCC_CNT     width=80  align=right  name="건수" SUMTEXT=@SUM</C>'
                     + '<C>id=RTN_TOT_AMT   width=100  align=right  name="OCB" SUMTEXT=@SUM</C>'
				     + '<C>id=RTN_CONV_POINT           width=100  show=true align=right name="포인트" SUMTEXT=@SUM</C>'
				     + '<C>id=RTN_CONV_GIFT_AMT        width=100  show=true align=right name="상품권금액" SUMTEXT=@SUM</C>'
                     + '</G>'
                     ;
                     
    initGridStyle(GD_OK_SAL_MST, "common", hdrProperies, false);
    GD_OK_SAL_MST.ViewSummary = "1";
    
    //DETAIL 그리드
    var hdrProperies1 = '<C>id={currow}    width=35  align=center name="NO"</C>'
				    	+ '<C>id=TRAN_DT              width=100  show=true align=center name="거래일자" mask="XXXX/XX/XX"</C>'
				    	+ '<C>id=TRAN_SEQ             width=60  show=true align=center name="전문번호" </C>'
				    	+ '<C>id=TRAN_SUB_SEQ         width=60  show=true align=center name="전문번호_SUB" </C>'
				    	+ '<C>id=TRAN_FLAG            width=60  show=true align=center name="거래구분" </C>'
				    	+ '<C>id=STATUS               width=60  show=true align=center name="Status" </C>'
				    	+ '<C>id=CONV_POINT           width=80  show=true align=right name="포인트" SUMTEXT=@SUM</C>'
				    	+ '<C>id=CONV_GIFT_AMT        width=80  show=true align=right name="상품권금액" SUMTEXT=@SUM</C>'
				    	+ '<C>id=TERM_NO              width=100  show=true align=center name="단말기번호" </C>'
				    	+ '<C>id=VEN_INFO             width=60  show=true align=center name="업체정보" </C>'
				    	+ '<C>id=POS_ENTRY_MODE       width=100  show=true align=center name="Pos Entry Mode" </C>'
				    	+ '<C>id=TRACK_II             width=180  show=true align=left name="Track II" </C>'
				    	+ '<C>id=FS                   width=40  show=true align=center name="FS" </C>'
				    	+ '<C>id=SALE_FLAG            width=60  show=true align=center name="판매구분" </C>'
				    	+ '<C>id=TOT_AMT              width=80  show=true align=right name="총금액" SUMTEXT=@SUM</C>'
				    	+ '<C>id=SVC_AMT              width=80  show=true align=right name="봉사료" SUMTEXT=@SUM</C>'
				    	+ '<C>id=VAT_AMT              width=80  show=true align=right name="세금(부가세)" SUMTEXT=@SUM</C>'
				    	+ '<C>id=SUP_AMT              width=100  show=true align=right name="공급금액" SUMTEXT=@SUM</C>'
				    	+ '<C>id=WORKING_KEY_INDEX    width=100  show=true align=center name="Working Key Index" </C>'
				    	+ '<C>id=PWD_NO               width=60  show=true align=center name="비밀번호" </C>'
				    	+ '<C>id=ORG_APPR_NO          width=100  show=true align=center name="원거래승인번호" </C>'
				    	+ '<C>id=ORG_APPR_DT          width=100  show=true align=center name="원거래승인일자" mask="XXXX/XX/XX"</C>'
				    	+ '<C>id=USER_INFO            width=80  show=true align=center name="사용자정보" </C>'
				    	+ '<C>id=BRCH_ID              width=80  show=true align=center name="가맹점ID" </C>'
				    	+ '<C>id=BRCH_NO              width=100  show=true align=center name="가맹점번호" </C>'
				    	+ '<C>id=BRCH_USE_FIELD       width=100  show=true align=center name="가맹점사용필드" </C>'
				    	+ '<C>id=POINT_FLAG           width=80  show=true align=center name="포인트 구분" </C>'
				    	+ '<C>id=KSNET_RESRV          width=100  show=true align=center name="KSNET Reserved" </C>'
				    	+ '<C>id=DONGLE_FLAG          width=80  show=true align=center name="동글구분" </C>'
				    	+ '<C>id=MEDIA_FLAG           width=80  show=true align=center name="매체구분" </C>'
				    	+ '<C>id=MOBILE_FLAG          width=80  show=true align=center name="이통사구분" </C>'
				    	+ '<C>id=CCARD_FLAG           width=80  show=true align=center name="신용카드종류" </C>'
				    	+ '<C>id=TRAN_TYPE            width=60  show=true align=center name="거래형태" </C>'
				    	+ '<C>id=ESIGN_YN             width=80  show=true align=center name="전자서명 유무" </C>'
				    	+ '<C>id=CARD_TYPE            width=80  show=true align=center name="카드 Type" </C>'
				    	+ '<C>id=MESG1                width=140  show=true align=left name="Message1" </C>'
				    	+ '<C>id=MESG2                width=140  show=true align=left name="Message2" </C>'
				    	+ '<C>id=APPR_NO              width=100  show=true align=center name="승인번호" </C>'
				    	+ '<C>id=PURCHASE_CD          width=80  show=true align=center name="발급사코드" </C>'
				    	+ '<C>id=PURCHASE_CARD_TYPE   width=140  show=true align=center name="카드종류명" </C>'
				    	+ '<C>id=PUBLISH_CD           width=80  show=true align=center name="매입사코드" </C>'
				    	+ '<C>id=PUBLISH_NAME         width=140  show=true align=center name="매입사명" </C>'
				    	+ '<C>id=WORKING_KEY          width=100  show=true align=center name="Working Key" </C>'
				    	+ '<C>id=PREP_POINT           width=100  show=true align=right name="예비 포인트" SUMTEXT=@SUM</C>'
				    	+ '<C>id=OCC_POINT            width=100  show=true align=right name="발생 포인트" SUMTEXT=@SUM</C>'
				    	+ '<C>id=USE_PSBL_POINT       width=100  show=true align=right name="가용 포인트" SUMTEXT=@SUM</C>'
				    	+ '<C>id=ACML_POINT           width=100  show=true align=right name="누적 포인트" SUMTEXT=@SUM</C>'
				    	+ '<C>id=NOTI1                width=100  show=true align=center name="Notice1" </C>'
				    	+ '<C>id=NOTI2                width=100  show=true align=center name="Notice2" </C>'
				    	+ '<C>id=RESRV                width=100  show=true align=center name="Reserved" </C>'
                      ;
                     
    initGridStyle(GD_OK_SAL_DTL, "common", hdrProperies1, false);
    GD_OK_SAL_DTL.ViewSummary = "1"; 
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//1. validation
	if (isNull(LC_STR_CD.BindColVal)){
		showMessage(EXCLAMATION, OK, "USER-1002", "점"); //(점)은/는 반드시 선택해야 합니다.
		LC_STR_CD.Focus();
        return;
    }
	if (isNull(EM_APP_S_DT.text)){
		showMessage(EXCLAMATION, OK, "USER-1003", "기간"); //(기간)은/는 반드시 입력해야 합니다.
		EM_APP_S_DT.focus();
        return;
    }
	if (isNull(EM_APP_E_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간"); //(기간)은/는 반드시 입력해야 합니다.
        EM_APP_E_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_APP_S_DT.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "기간");//(기간)은/는 유효하지 않는 날짜입니다.
        EM_APP_S_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_APP_E_DT.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "기간");//(기간)은/는 유효하지 않는 날짜입니다.
        EM_APP_E_DT.focus();
        return;
    }
    if(EM_APP_S_DT.text > EM_APP_E_DT.text){
    	showMessage(EXCLAMATION, OK, "USER-1015"); //시작일은 종료일보다 작아야 합니다.
        EM_APP_S_DT.focus();
        return;
    }
    
    //2. 데이터셋 초기화
    DS_OK_SAL_MST.ClearData();
    DS_OK_SAL_DTL.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo       = "searchOkSalMst";
    
    var action     = "O";
    var parameters = "&strStoreCd="      + LC_STR_CD.BindColVal              //점구분코드
                   + "&strStartDt="      + EM_APP_S_DT.text                  //조회기간 시작일 
                   + "&strEndDt="        + EM_APP_E_DT.text                  //조회기간 종료일
                   + "&strPosNo="        + EM_POS_NO.text                    //POS번호
                   ;

    DS_OK_SAL_MST.DataID = "/dps/psal554.ps?goTo="+goTo+parameters;
    DS_OK_SAL_MST.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : 상세정보  호출
 * return값 : void
*/
function subQuery(row){
    DS_OK_SAL_DTL.ClearData();
    var goTo       = "searchOkSalDtl";
    var action     = "O";
    var parameters = "&strStoreCd=" + DS_OK_SAL_MST.NameValue(row,"STR_CD")    //점코드
                   + "&strStartDt=" + DS_OK_SAL_MST.NameValue(row,"TRAN_DT")   //매출일자
                   ;
   
    DS_OK_SAL_DTL.DataID = "/dps/psal554.ps?goTo="+goTo+parameters;
    DS_OK_SAL_DTL.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

    if(DS_OK_SAL_MST.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "OK캐쉬백상품권교환현황(상세)";
   
    var parameters = 
		         "점 "              	+ LC_STR_CD.BindColVal              //점구분코드
		       + " , 조회기간 "      	+ EM_APP_S_DT.text                  //조회기간 시작일 
		       + " ~ "             	+ EM_APP_E_DT.text                  //조회기간 종료일
		       ;
        
    openExcel2(GD_OK_SAL_MST, strTitle, parameters, true );
    
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-08
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
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
  * btn_Excel()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.02.21
  * 개    요 : 엑셀로 다운로드
  * return값 : void
  */
 function btn_Xls2() {

	    if(DS_OK_SAL_DTL.CountRow <= 0){
	        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	          return;
	      }
	      var strTitle = "OK캐쉬백적상품권교환현황(상세)내역";
	     
	      var parameters = 
	  		         "점 "              	+ LC_STR_CD.BindColVal              //점구분코드
	  		       + " , 조회기간 "      	+ EM_APP_S_DT.text                  //조회기간 시작일 
	  		       + " ~ "             	+ EM_APP_E_DT.text                  //조회기간 종료일
	  		       ;
	          
	      openExcel2(GD_OK_SAL_DTL, strTitle, parameters, true );
 }
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_OK_SAL_MST event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_OK_SAL_MST.Focus();
</script>

<script language=JavaScript for=DS_OK_SAL_DTL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_OK_SAL_MST  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_OK_SAL_DTL  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_OK_SAL_MST event=OnRowPosChanged(row)>
     if (DS_OK_SAL_MST.CountRow >0 && row>0) {
         subQuery(row);
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_OK_SAL_MST event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_OK_SAL_DTL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"        classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]OK캐쉬백매출현황 MASTER -->
    <object id="DS_OK_SAL_MST"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]OK캐쉬백매출현황 DETAIL -->
    <object id="DS_OK_SAL_DTL"   classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">기간</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_APP_S_DT)" align="absmiddle" />
              ~ 
              <comment id="_NSID_">
                <object id=EM_APP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_APP_E_DT)" align="absmiddle" />
            </td>
            <th width="80">POS번호</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=140 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
            </td>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_OK_SAL_MST width="100%" height=200 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_OK_SAL_MST">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
	<tr>
            </td>
            <td class="right" valign="bottom">
            <img src="/<%=dir%>/imgs/btn/excel.gif" onclick="btn_Xls2();" />
            </td>	
    </tr>     
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td class="PT01 PB03" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_OK_SAL_DTL width="100%" height=267 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_OK_SAL_DTL">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
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
