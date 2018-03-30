<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 수입경비 > 수입발주대비 입고현황
 * 작 성 일 : 2010.03.12
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod5070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 수입발주대비 입고현황
 * 이    력 :
 *        2010.04.06 (박래형) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"     prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


var strToday        = "";   // 현재날짜
var strYYYYMM       = "";   // 현재날짜
var name            = "ORDER NO";

<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){
     
    //햔재날짜
     strToday  =   getTodayDB("DS_O_RESULT");   
     strYYYYMM =   strToday.substring(0,6);  
     
     // Input Data Set Header 초기화     
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>'); 

     // Output Data Set Header 초기화
     
     //그리드 초기화
     gridCreate1(); //마스터    
     
     // 조회부
     initEmEdit(EM_S_S_STANDARD_DT,      "TODAY",       PK);          //조회기준 기간 1
     initEmEdit(EM_S_E_STANDARD_DT,      "TODAY",       PK);          //조회기준 기간 2
     initEmEdit(EM_S_STANDARD_NO,        "GEN^30",      NORMAL);      //기준 NO
     initEmEdit(EM_S_PUMBUN_CD,          "000000",      NORMAL);      //브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,          "GEN^40",      READ);        //브랜드명
     initEmEdit(EM_S_VEN_CD,             "000000",      NORMAL);      //협력사코드
     initEmEdit(EM_S_VEN_NM,             "GEN^40",      READ);        //협력사명

                                                                     
     //콤보 초기화
     initComboStyle(LC_S_STR_CD,         DS_STR,             "CODE^0^30,NAME^0^80", 1, PK);      //조회부 점
     initComboStyle(LC_S_STANDARD_TYPE,  DS_O_STANDARD_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);  //기준일     

//     P229
     
     //공통코드에서 데이터 가지고 오기     
     getStore("DS_STR", "Y", "", "N");  
     getEtcCode("DS_O_STANDARD_TYPE",  "D", "P229", "N");       // 기준일
     
     //데이터셋 등록
     registerUsingDataset("pord507","DS_LIST");
     
     LC_S_STR_CD.Index = 0;
     LC_S_STANDARD_TYPE.Index = 0;
     LC_S_STR_CD.Focus();

     EM_S_S_STANDARD_DT.Text = (strYYYYMM + '01');

 }

function gridCreate1(){
    var hdrProperies = '<FC>id=STR_NM    name="점"          width=80    align=left</FC>'
        + '<FC>id=PUMBUN_CD              name="브랜드코드"    width=60   align=center </FC>'
        + '<FC>id=PUMBUN_NM              name="브랜드명"      width=120   align=left </FC>'
        + '<FC>id=VEN_CD                 name="협력사코드"  width=80   align=center </FC>'
        + '<FC>id=VEN_NM                 name="협력사명"    width=130   align=left </FC>'
        + '<FC>id=OFFER_DT               name="OFFER 일자"  width=80    align=center  Mask="XXXX/XX/XX" </FC>'
        + '<FC>id=OFFER_SHEET_NO         name="OFFER NO"    width=220   align=center </FC>'
        + '<FC>id=CURRENCY_CD            name="화폐단위"     width=60   align=center </FC>'
        + '<FG> name = "ORDER"'
        + '<FC>id=ORDER_TOT_QTY          name="수량"        width=60   align=right </FC>'
        + '<FC>id=ORDER_TOT_AMT          name="외화금액"    width=110   align=right </FC>'
        + '<FC>id=ORDER_WON_TOT_AMT      name="원화금액"    width=110   align=right </FC></FG>'
        + '<FG> name = "OFFER"'
        + '<FC>id=OFFER_TOT_QTY          name="수량"        width=60   align=right </FC>'
        + '<FC>id=OFFER_TOT_AMT          name="외화금액"    width=110   align=right </FC>'
        + '<FC>id=OFFER_TOT_WON_AMT      name="원화금액"    width=110   align=right </FC>'
        + '<FG>name = "INVOICE"'
        + '<FC>id=INVOICE_TOT_QTY        name="수량"        width=60   align=right </FC>'
        + '<FC>id=INVOICE_TOT_AMT        name="외화금액"    width=110   align=right </FC>'
        + '<FC>id=INVOICE_WON_TOT_AMT    name="원화금액"    width=110   align=right </FC>'
        + '<FG> name ="입고(검품)"'
        + '<FC>id=CHK_TOT_QTY            name="수량"        width=60   align=right </FC>'
        + '<FC>id=CHK_EXC_TAMT           name="외화금액"    width=110   align=right </FC>'
        + '<FC>id=CHK_COST_TAMT          name="원화금액"    width=110   align=right </FC></FG>';                     

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 

    if(checkValue("Search")){
        getList();
        // 조회결과 Return
        setPorcCount("SELECT", GR_MASTER);
        if(DS_LIST.CountRow == 0){
        	LC_S_STR_CD.Focus();
            return;
        }
    }
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {      
 
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {       

}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
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
 * 작 성 일 : 2010-03-107
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){
     
     
    // 조회조건 셋팅
    var strStrCd         = LC_S_STR_CD.BindColVal;          // 점
    var strStanddard     = LC_S_STANDARD_TYPE.BindColVal;   // 기준일
    var strSStandardDt   = EM_S_S_STANDARD_DT.Text;         // 조회기간1
    var strEStandardDt   = EM_S_E_STANDARD_DT.Text;         // 조회기간2
    var strStandardNo    = EM_S_STANDARD_NO.Text;           // 기준에 따른 NO
    var strPumbun        = EM_S_PUMBUN_CD.Text;             // 브랜드
    var strVen           = EM_S_VEN_CD.Text;                // 협력사
   
    var goTo       = "getList" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
				    + "&strStanddard="+encodeURIComponent(strStanddard)   
				    + "&strSStandardDt="+encodeURIComponent(strSStandardDt)     
                    + "&strEStandardDt="+encodeURIComponent(strEStandardDt)      
                    + "&strStandardNo="+encodeURIComponent(strStandardNo)       
                    + "&strPumbun="+encodeURIComponent(strPumbun)        
                    + "&strVen="+encodeURIComponent(strVen);  
    TR_MAIN.Action="/dps/pord507.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_MAIN.Post();
 }
/**
 * checkValue(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-03-12
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValue(Gubun) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_S_STR_CD.Text.length == 0){                                    // 점
             showMessage(EXCLAMATION, OK, messageCode, "점");
             LC_S_STR_CD.Focus();
             return false;
         }   
         if(EM_S_S_STANDARD_DT.Text.length == 0){                                //INVOICE 기간1
             showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
             EM_S_S_STANDARD_DT.Focus();
             return false;
         }  
         if(EM_S_E_STANDARD_DT.Text.length == 0){                                //INVOICE 기간2
             showMessage(EXCLAMATION, OK, messageCode, "OFFER 기간");
             EM_S_E_STANDARD_DT.Focus();
             return false;
         } 
         
         if(EM_S_S_STANDARD_DT.Text > EM_S_E_STANDARD_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_S_STANDARD_DT.Focus();
             return false;
         }
         return true;
         break;
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
      var strStrCd        = LC_S_STR_CD.BindColVal;                                       // 점
      var strOrgCd        = tmpOrgCd+"00000000";                                         // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

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
      var strOrgCd        = tmpOrgCd+"00000000";                                       // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "0";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "1";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "1";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "1";                                                       // 판매분매입구분

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
   * getVenInfo(code, name)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  조회 브랜드에 따른 협력사 팝업
   * return값 : void
   */
  function getVenInfo(code, name){
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strUseYn        = "Y";                                                       // 사용여부
      var strPumBunType   = "0";                                                       // 브랜드유형
      var strBizType      = "1";                                                        // 거래형태
      var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
      var strBizFlag      = "";                                                        // 거래구분

      var rtnMap = venPop(code, name
                           ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                           ,strBizFlag);
      if(rtnMap != null){
          return true;
      }else{
          return false;
      }
  }
 
  

  /**
   * getVenNonInfo(code, name)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  브랜드에 따른 협력사 팝업
   * return값 : void
   */
  function getVenNonInfo(code, name){
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strUseYn        = "Y";                                                       // 사용여부
      var strPumBunType   = "0";                                                       // 브랜드유형
      var strBizType      = "1";                                                        // 거래형태
      var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
      var strBizFlag      = "";                                                        // 거래구분

      var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                          ,strBizFlag);
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>

    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>

    trFailed(TR_S_MAIN.ErrorMsg);
</script>



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)> 
if(clickSORT)
    return;

</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);

</script>

<!-- Grid GR_DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);    
</script>




<script language=JavaScript for= LC_S_STANDARD_TYPE event=OnSelChange()>
//	alert("1");
	if(LC_S_STANDARD_TYPE.Index == 0){
		EM_S_STANDARD_NO.Text = "";
	    EM_S_STANDARD_NO.MaxLength = 30;
	    document.getElementById('STANDARD_NO').innerHTML = "OFFER NO";
	    
	}else if(LC_S_STANDARD_TYPE.Index == 1){
        EM_S_STANDARD_NO.Text = "";
        EM_S_STANDARD_NO.MaxLength = 30;
        document.getElementById('STANDARD_NO').innerHTML = "INVOICE NO";
	    
	}else if(LC_S_STANDARD_TYPE.Index == 2){
        EM_S_STANDARD_NO.Text = "";
        EM_S_STANDARD_NO.MaxLength = 13;
        document.getElementById('STANDARD_NO').innerHTML = "ORDER NO";
	}
</script>



<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//	EM_S_STANDARD_NO.Text = "";
	EM_S_PUMBUN_CD.Text   = "";
	EM_S_PUMBUN_NM.Text   = "";
	EM_S_VEN_CD.Text      = "";
	EM_S_VEN_NM.Text      = "";
</script>


<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_S_STANDARD_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_S_STANDARD_DT );
    
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_S_STANDARD_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_E_STANDARD_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_E_STANDARD_DT );
</script>


<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
        EM_S_PUMBUN_NM.Text = "";  
</script>



<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>

    if(EM_S_VEN_CD.Text != ""){
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    }else
        EM_S_VEN_NM.Text = "";  
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
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR"                classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_LIST"               classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STANDARD_TYPE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_M_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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

<DIV id="testdiv" class="testdiv">

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
                    <th class="point" width="70">점</th>
                    <td width="110">
                         <comment id="_NSID_">
                            <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle" tabindex=1 >
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="70">기준일</th>
                    <td width="110">
                         <comment id="_NSID_">
                            <object id=LC_S_STANDARD_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle" tabindex=1 >
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="80">조회기준 기간</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_S_STANDARD_DT classid=<%=Util.CLSID_EMEDIT%>  width=122 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_S_STANDARD_DT)" align="absmiddle"/>
                        ~
                        <comment id="_NSID_">
                              <object id=EM_S_E_STANDARD_DT classid=<%=Util.CLSID_EMEDIT%>  width=122 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_E_STANDARD_DT)" align="absmiddle"/>
                    </td>
                  </tr>
                  <tr>
                    <th><span id="STANDARD_NO" style="Color: 146ab9">OFFER NO</span></th>
                    <td colspan="7">
                        <comment id="_NSID_">
                              <object id=EM_S_STANDARD_NO classid=<%=Util.CLSID_EMEDIT%>  width=300 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th>브랜드</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=88 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=187 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th>협력사</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=88 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" />
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=187 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
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
    <tr valign="top">
        <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                    <td>
                        <comment id="_NSID_">
                            <OBJECT id=GR_MASTER width=100% height=454 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_LIST">
                            </OBJECT>
                        </comment><script>_ws_(_NSID_);</script>
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
<body>
</html>

