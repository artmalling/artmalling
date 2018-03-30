<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 정산관리> 자사상품권 정산
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif6220.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김성미) 신규작성
 *        2011.05.26 (김성미) 프로그램작성 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/popup.js"       type="text/javascript"></script>
<script language="javascript"  src="/pot/js/popup_mss.js"   type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strCurRow = 0;
var clickBtnSearch = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    //initEmEdit(EM_CAL_YM, "THISMN", PK);    //적용종료일
    initEmEdit(EM_CAL_YMD_FROM, "SYYYYMMDD", PK);       //일자 from
    initEmEdit(EM_CAL_YMD_TO, "TODAY", PK);         //일자 to
    
    //콤보 초기화
  initComboStyle(LC_S_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);    //법인구분
  
  getStore("DS_O_STR", "Y", "", "N");
  
  LC_S_STR.Index = 0;
  LC_S_STR.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}           name="NO"         width=25   align=center</FC>'
                     + '<FC>id=YYYYMMDD           name="정산기간"     width=70 mask="XXXX/XX/XX"  align=center</FC>'
                     + '<FC>id=DRAWL_STR_NM       name="회수점"       width=80  align=left</FC>'
                     + '<FC>id=TOT_DRAWL_QTY      name="당월총회수"       width=80  align=right</FC>'
                     + '<FC>id=T_STR_DRAWL_QTY    name="당점판매회수"     width=80   align=right</FC>'
                     + '<FC>id=O_STR_DRAWL_QTY    name="타점판매회수"     width=80   align=right</FC>';
                   
    initGridStyle(GD_TOTAL, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
        + '<FC>id=YYYYMMDD     name="정산기간" sumtext="합계"    width=80  mask="XXXX/XX/XX"   align=center</FC>'
        + '<FC>id=SALE_STR_NM  name="판매점"     width=100   align=left</FC>'
        + '<FC>id=DRAWL_QTY    name="회수수량"   sumtext=@sum    width=80  align=right</FC>'
        + '<FC>id=DRAWL_AMT    name="회수금액"  sumtext=@sum   width=90   align=right</FC>';
      
   initGridStyle(GD_SUB_TOTAL, "common", hdrProperies1, false);
   GD_SUB_TOTAL.ViewSummary = 1; 
   var hdrProperies2 = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
       + '<FC>id=YYYYMMDD     name="회수일자" sumtext="합계"    width=80  mask="XXXX/XX/XX"   align=center</FC>'
       + '<FC>id=DRAWL_STR_NM      name="회수점"     width=80   align=left</FC>'
       + '<FC>id=GIFT_TYPE_NAME      name="상품권종류" sumtext="합계"    width=80   align=left</FC>'
       + '<FC>id=GIFT_AMT_NAME    name="금종"       width=70  align=left</FC>'
       + '<FC>id=DRAWL_QTY    name="회수수량"  sumtext=@sum   width=70   align=right</FC>'
       + '<FC>id=DRAWL_AMT    name="회수금액"  sumtext=@sum   width=70   align=right</FC>';
     
  initGridStyle(GD_DETAIL, "common", hdrProperies2, false);
  GD_DETAIL.ViewSummary = 1; 
  
  var hdrProperies3 = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
	    	  + '<FC>id=STR_NM      name="회수점"  edit=none   width=120 sumtext="합계"   align=left</FC>'
      + '<FC>id=GIFT_TYPE_NAME    name="상품권종류"   edit=none    width=120  align=left</FC>'
      + '<FC>id=GIFT_AMT_NAME    name="금종" edit=none    width=120  align=left</FC>'
      + '<FC>id=CAL_QTY    name="회수수량"  edit=none sumtext=@sum   width=110   align=right</FC>'
      + '<FC>id=CAL_AMT    name="회수금액"  edit=none sumtext=@sum   width=120   align=right</FC>'
      + '<FC>id=CONF_FLAG_NM    name="확정구분"  edit=none   width=80   align=left</FC>'
      + '<FC>id=CLOSE_FLAG_NM    name="마감여부" edit=none    width=80   align=left</FC>';
    
 initGridStyle(GD_GIFTCAL, "common", hdrProperies3, false);
 GD_GIFTCAL.ViewSummary = 1; 
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_S_STR.BindColVal == ""){  // 회수점
        showMessage(EXCLAMATION , OK, "USER-1001", "회수점");
        return;
    }
    //if(EM_CAL_YM.Text.length < 6){   // 정산년월
    //    showMessage(EXCLAMATION , OK, "USER-1001","정산년월");
    //    EM_S_S_DT.Focus();
    //    return;
    // }
    
    var strYmdFrom    = EM_CAL_YMD_FROM.Text;  //회수일자 FROM
    var strYmdTo      = EM_CAL_YMD_TO.Text;      //회수일자 TO
    
    if(strYmdFrom > strYmdTo) {
   	 showMessage(INFORMATION, OK, "USER-1015");
   	 EM_CAL_YMD_FROM.Focus();
   	 return;
    }
    
    clickBtnSearch = true;
    DS_O_TOTAL.ClearData();
    DS_O_SUB_TOTAL.ClearData();
    DS_O_GIFTCAL.ClearData();
    DS_O_DETAIL.ClearData();
    
    
    var parameters = "&strStrCd="+LC_S_STR.BindColVal
				    + "&strYmdFrom="+ encodeURIComponent(strYmdFrom)
				    + "&strYmdTo="  + encodeURIComponent(strYmdTo)
				    ;
				    
    TR_MAIN.Action="/mss/mgif622.mg?goTo=getTotal"+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_TOTAL=DS_O_TOTAL,O:DS_O_SUB_TOTAL=DS_O_SUB_TOTAL)"; //조회는 O
    TR_MAIN.Post();
    
    strCurRow = DS_O_SUB_TOTAL.RowPosition;
    
    if(DS_O_TOTAL.CountRow > 0 && DS_O_SUB_TOTAL.CountRow > 0 ) getDetail();
    clickBtnSearch = false;
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-06-03
 * 개    요 : 자사상품권 정산내용 저장
 * return값 : void
 */
function btn_Save() {
	 /*
	// 저장할 데이터 없는 경우
	   if(DS_O_DETAIL.CountRow == 0){
	         //저장할 내용이 없습니다
	           showMessage(EXCLAMATION , OK, "USER-1028");
	           return;
	       }
	   if(DS_O_SAVEDATA_MST.CountRow == 0 || DS_O_SAVEDATA_DTL.CountRow == 0){
           //저장할 내용이 없습니다
             showMessage(EXCLAMATION , OK, "USER-1000","정산내역을 확인해 주세요.");
             return;
         }
	   
	   var strStr = DS_O_DETAIL.NameValue(1,"DRAWL_STR");
	   var strSaleStr =  DS_O_DETAIL.NameValue(1,"SALE_STR");
	   for(var i=1;i<=DS_O_GIFTCAL.CountRow;i++){
           if(strStr == DS_O_GIFTCAL.NameValue(1,"STR_CD") 
        		   && strSaleStr == DS_O_GIFTCAL.NameValue(1,"SALE_STR")){
        	   if (DS_O_GIFTCAL.NameValue(i,"CONF_FLAG") == "Y") {
        		   showMessage(EXCLAMATION , OK, "USER-1000", "확정이되어  등록이  불가능합니다.");
                   return;
               }
        	   if(DS_O_GIFTCAL.NameValue(i,"CLOSE_FLAG") == "TRUE"){
        		   showMessage(EXCLAMATION , OK, "USER-1068","","");
                   return;
        	   }
           }
       }
	
	   if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
	   
	   for(var i=1;i<=DS_O_SAVEDATA_MST.CountRow;i++){
		   DS_O_SAVEDATA_MST.UserStatus(i)= 1;
	   }
	   for(var i=1;i<=DS_O_SAVEDATA_DTL.CountRow;i++){
		   DS_O_SAVEDATA_DTL.UserStatus(i)= 1;
       }
	   var desSign = "";
	   if(DS_O_GIFTCAL.CountRow > 0){
		   desSign = "D";
	   }
	   var parameters = "&strStrCd="     + encodeURIComponent(DS_O_SUB_TOTAL.NameValue(DS_O_SUB_TOTAL.RowPosition, "DRAWL_STR"))
				       + "&strYM="       + encodeURIComponent(DS_O_SUB_TOTAL.NameValue(DS_O_SUB_TOTAL.RowPosition, "YYYYMM"))
				       + "&strSaleStrCd="+ encodeURIComponent(DS_O_SUB_TOTAL.NameValue(DS_O_SUB_TOTAL.RowPosition, "SALE_STR"))
				       + "&desSign="     + encodeURIComponent(desSign);
	   TR_MAIN.Action="/mss/mgif622.mg?goTo=save"+parameters;  
	   TR_MAIN.KeyValue="SERVLET(I:DS_O_SAVEDATA_MST=DS_O_SAVEDATA_MST,I:DS_O_SAVEDATA_DTL=DS_O_SAVEDATA_DTL)"; //조회는 O
	   TR_MAIN.Post();
	   strCurRow = DS_O_SUB_TOTAL.RowPosition;
	   
	  if(TR_MAIN.ErrorCode == 0) btn_Search();
	  */
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }
	
     // 조회조건 셋팅
     var strYmdFrom    = EM_CAL_YMD_FROM.Text;  //회수일자 FROM
     var strYmdTo      = EM_CAL_YMD_TO.Text;      //회수일자 TO
     
     if(strYmdFrom > strYmdTo) {
    	 showMessage(INFORMATION, OK, "USER-1015");
    	 EM_CAL_YMD_FROM.Focus();
    	 return;
     }
     
	 var parameters = "&strStrCd="+LC_S_STR.BindColVal
				    + "&strYmdFrom="+strYmdFrom
				    + "&strYmdTo="+strYmdTo
				    ;
				 
	 window.open("/mss/mgif622.mg?goTo=print"+parameters, "OZREPORT", 1000, 700);        
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011-06-03
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	// 저장할 데이터 없는 경우
	if(DS_O_GIFTCAL.CountRow == 0){
        //저장할 내용이 없습니다
          showMessage(EXCLAMATION , OK, "USER-1028");
          return;
      }
	
    if(!DS_O_GIFTCAL.IsUpdated){
          //저장할 내용이 없습니다
            showMessage(EXCLAMATION , OK, "USER-1028");
            return;
        }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    TR_MAIN.Action="/mss/mgif622.mg?goTo=confirm"; 
    TR_MAIN.KeyValue="SERVLET(I:DS_O_GIFTCAL=DS_O_GIFTCAL)"; //조회는 O
    TR_MAIN.Post();
    
    if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011-06-03q
 * 개    요 : 확정 처리
 * return값 : void
 */
function getDetail(){
	 DS_O_DETAIL.ClearData();
	 DS_O_GIFTCAL.ClearData();
	 DS_O_SAVEDATA_MST.ClearData();
	 DS_O_SAVEDATA_DTL.ClearData();

     var strYmdFrom    = EM_CAL_YMD_FROM.Text;  //회수일자 FROM
     var strYmdTo      = EM_CAL_YMD_TO.Text;      //회수일자 TO
    
	 var parameters = "&strStrCd="    + encodeURIComponent(DS_O_SUB_TOTAL.NameValue(DS_O_SUB_TOTAL.RowPosition, "DRAWL_STR"))
					+ "&strYmdFrom="  + encodeURIComponent(strYmdFrom)
					+ "&strYmdTo="    + encodeURIComponent(strYmdTo)
	                + "&strSaleStrCd="+ encodeURIComponent(DS_O_SUB_TOTAL.NameValue(DS_O_SUB_TOTAL.RowPosition, "SALE_STR"));
	 
	 TR_S_MAIN.Action="/mss/mgif622.mg?goTo=getDetail"+parameters;  
	 TR_S_MAIN.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL,O:DS_O_GIFTCAL=DS_O_GIFTCAL,O:DS_O_SAVEDATA_MST=DS_O_SAVEDATA_MST,O:DS_O_SAVEDATA_DTL=DS_O_SAVEDATA_DTL)"; //조회는 O
	 TR_S_MAIN.Post();
}

--></script>
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
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_TOTAL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<script language=JavaScript for=DS_O_SUB_TOTAL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
 if(clickBtnSearch) return;
 if(DS_O_SUB_TOTAL.CountRow > 0 ) getDetail();
</script>
<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<script language=JavaScript for=DS_O_GIFTCAL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_TOTAL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_SUB_TOTAL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_GIFTCAL event=OnClick(row,colid)>
if(row == 0 && colid != "FLAG") sortColId( eval(this.DataID), row, colid);
</script>
<script language="javascript"  for=GD_GIFTCAL event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    alter('bChek'+bCheck);
    if(bCheck == 1){
     strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_O_GIFTCAL.CountRow;i++){
        if (DS_O_GIFTCAL.NameValue(i,"CONF_FLAG") != "Y" && DS_O_GIFTCAL.NameValue(i,"CLOSE_FLAG") != "TRUE" ) {
        	DS_O_GIFTCAL.NameValue(i,"FLAG") = strFlag;
        }
    }
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
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_FCL_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_AREA_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_TOTAL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SUB_TOTAL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTCAL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SAVEDATA_MST"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SAVEDATA_DTL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" class="point">회수점</th>
            <td width="150">
                <comment id="_NSID_">
                   <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=148 align="absmiddle" tabindex=1>
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="100" class="point">정산기간</th>
	         <td >
                <comment id="_NSID_">
                    <object id=EM_CAL_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70" align="absmiddle"
                    onblur="javascript:checkDateTypeYMD(this);" > 
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_CAL_YMD_FROM)" /> ~ 
                 <comment id="_NSID_">
                    <object id=EM_CAL_YMD_TO classid=<%=Util.CLSID_EMEDIT%> width="70" align="absmiddle" 
                    onblur="javascript:checkDateTypeYMD(this);" >
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_CAL_YMD_TO)" align="absmiddle" />
             </td>
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr valign="top">
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
   <tr>
    <td><!-- 결제내역 -->
        <table width="400" border="0" cellspacing="0" cellpadding="0" >
        <tr>
        <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 회수내역
        </td>
        </tr>
        <tr>
        <td>
          <table width="400" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	      <tr>
	      <td>
	          <comment id="_NSID_"><OBJECT id=GD_TOTAL width=100% height=120 classid=<%=Util.CLSID_GRID%>>
	              <param name="DataID" value="DS_O_TOTAL">
	          </OBJECT></comment><script>_ws_(_NSID_);</script>
	      </td>  
	       </tr>
	      </table> 
        </td>
        </tr>
        <tr><td height=5></td></tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
              <comment id="_NSID_"><OBJECT id=GD_SUB_TOTAL width=100% height=150 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_SUB_TOTAL">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
    </td>
    <td width="100%" valign="top" class="PB05 PL05"><!-- 결제상세내역 -->
         <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
       <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 회수상세내역
        </td>
        </tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
              <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=280 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_DETAIL">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
    </td>
   </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot" colspan=3></td></tr>
  <!--  그리드의 구분dot & 여백  -->
   <tr>
   <td  colspan=3><!-- 정산자료 -->
     <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
        <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 정산자료
        </td>
        </tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
              <comment id="_NSID_"><OBJECT id=GD_GIFTCAL width=100% height=185 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_GIFTCAL">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
   </td>
   </tr>
   </table>
    </td>
    </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

