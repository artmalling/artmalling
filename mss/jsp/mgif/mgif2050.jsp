<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 출/입고> 지점입고 확정
 * 작 성 일 : 2011.04.27
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.04.27 (김성미) 프로그램 작성 
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
<script language="javascript" src="/<%=dir%>/js/common.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strToday   ;
 var btnClickSave = false;
 var strOldDate = "";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
   
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 //기간 : 시작
    initEmEdit(EM_E_DT, "TODAY", PK);                 //기간 : 종료
    initEmEdit(EM_IN_CONF_DT, "YYYYMMDD", PK);               //출고일자
    
    initComboStyle(LC_REQ_STR,DS_O_REQ_STR, "CODE^0^30,NAME^0^80", 1, PK);              //점구분
    initComboStyle(LC_H_STR,DS_O_H_STR, "CODE^0^30,NAME^0^80", 1, PK);              //점구분

    getStore("DS_O_REQ_STR", "Y", "", "N");
    getStore("DS_O_H_STR", "N", "", "N");
    strToday   = getTodayDB("DS_O_RESULT");
    setObject(false);
    DS_O_REQ_STR.Filter();     //점구분 : 매장점만 셋팅
    DS_O_H_STR.Filter();     //점구분 : 본사점만 셋팅
    if(DS_O_H_STR.CountRow == 1){
    	LC_H_STR.Index = 0;
    }else{
    	insComboData( LC_REQ_STR, "%", "전체",1);
    	LC_H_STR.Index = 0;
    }
    LC_REQ_STR.Index = 0;
    LC_REQ_STR.focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif205", "DS_O_MASTER,DS_O_DETAIL"); 
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width=30   align=center</FC>'
                     + '<FC>id=REQ_STR_NAME     name="신청점"     width=120   align=left</FC>'
                     + '<FC>id=OUT_STR_NAME       name="출고점"    sumtext="합계"   width=150align=left</FC>'
                     + '<FC>id=OUT_DT  name="출고일자"   mask="XXXX/XX/XX"    width=120   align=center</FC>'
                     + '<FC>id=OUT_SLIP_NO      name="순번"    width=150   align=center</FC>'
                     + '<FC>id=OUT_QTY  name="수량"  sumtext=@sum   width=110   align=right</FC>'
                     + '<FC>id=OUT_AMT  name="출고금액"  sumtext=@sum   width=110   align=right</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
        + '<FC>id=GIFT_AMT_NAME     name="금종명"  sumtext="합계"    width=70   align=left</FC>'
        + '<FC>id=GIFTCERT_AMT      name="상품권금액"       width=100  align=right</FC>'
        + '<FC>id=GIFT_S_NO           name="시작번호"     width=160   align=center</FC>'
        + '<FC>id=GIFT_E_NO  name="종료번호"  width=160   align=center</FC>'
        + '<FC>id=OUT_QTY  name="수량"  sumtext=@sum   width=130   align=right</FC>'
        + '<FC>id=OUT_AMT  name="출고금액"  sumtext=@sum   width=140   align=right</FC>';
        
    initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
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
 * 작 성 일 : 2011-04-26
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
	 if(EM_IN_CONF_DT.Text != ""){
        if(showMessage(QUESTION , YESNO, "USER-1073") != 1 ){
            return;
        }
    }
    // 조회조건 셋팅
    var strReqStr       = LC_REQ_STR.BindColVal;        //신청점 
    var strSdt          = EM_S_DT.Text;                 //신청기간 from
    var strEdt          = EM_E_DT.Text;                 //신청기간 to
    var strHStr         = LC_H_STR.BindColVal;          //출고점
    
    if(strEdt < strSdt) {
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    
    //데이타 셋 클리어
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
  
    EM_IN_CONF_DT.Text = "";
    setObject(false);
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strReqStr="+ encodeURIComponent(strReqStr)
                   + "&strSdt="   + encodeURIComponent(strSdt)
                   + "&strEdt="   + encodeURIComponent(strEdt)
                   + "&strHStr="  + encodeURIComponent(strHStr);
    
    TR_MAIN.Action="/mss/mgif205.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-26
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
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
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-26
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
	 // 저장할 데이터 없는 경우
    if (EM_IN_CONF_DT.Text == ""){
    	showMessage(EXCLAMATION , OK, "USER-1003", "입고확정일자");
    	EM_IN_CONF_DT.Focus();
        return;
    }

    var strOutDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "OUT_DT");
    if(EM_IN_CONF_DT.Text < strOutDt){
        showMessage(EXCLAMATION, OK, "USER-1020", "입고확정일자", "출고일자");
        EM_IN_CONF_DT.Text = strOutDt;
        EM_IN_CONF_DT.Focus();
       return;
    }
    
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_STR")
                      , EM_IN_CONF_DT.Text
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "일", "");
        EM_IN_CONF_DT.Focus();
        return;
    }
 
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_STR")
                      , EM_IN_CONF_DT.Text
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        EM_IN_CONF_DT.Focus();
        return;
    }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    btnClickSave = true;
    DS_O_MASTER.UserStatus(DS_O_MASTER.RowPosition) = 1;
    for(var i=1;i<=DS_O_DETAIL.CountRow;i++){
    	DS_O_DETAIL.UserStatus(i) = 1;
    }
    var strInConfDt = EM_IN_CONF_DT.Text;
    var parameters = "&strInConfDt="+encodeURIComponent(strInConfDt);  
    TR_MAIN.Action="/mss/mgif205.mg?goTo=save"+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER,I:DS_O_DETAIL=DS_O_DETAIL)";
    TR_MAIN.Post();
    btnClickSave = false;
    if(TR_MAIN.ErrorCode == 0){
    	EM_IN_CONF_DT.Text = ""; 
    	btn_Search();
    }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getDetail()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-18
  * 개    요 : 하단 상세 조회
  * return값 : void
  */
 function getDetail () {
    var row = DS_O_MASTER.RowPosition;
    var strOutDt = DS_O_MASTER.NameValue(row, "OUT_DT");
    var strOutStr = DS_O_MASTER.NameValue(row, "OUT_STR");
    var strOutSlipNo = DS_O_MASTER.NameValue(row, "OUT_SLIP_NO");
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strOutDt="     + encodeURIComponent(strOutDt)
                    + "&strOutStr="   + encodeURIComponent(strOutStr)
                    + "&strOutSlipNo="+ encodeURIComponent(strOutSlipNo);
    TR_DETAIL.Action="/mss/mgif205.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_DETAIL.CountRow > 0 )  setObject(true);
 }
 
 
 function setObject(flag){
    EM_IN_CONF_DT.Enable = flag;
    
    if(DS_O_MASTER.CountRow == 0 || DS_O_DETAIL.CountRow == 0){
        enableControl(IMG_CAL, false);
    }else{
        enableControl(IMG_CAL, true);
    }
}

 function chkOutDt(){
	 if(!checkDateTypeYMD(EM_IN_CONF_DT)) return;
	 
	 var strOutDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "OUT_DT");
	 if(EM_IN_CONF_DT.Text < strOutDt){
		 showMessage(EXCLAMATION, OK, "USER-1008", "출고일자", "입고확정일자");
		 EM_IN_CONF_DT.Text = strOutDt;
		 EM_IN_CONF_DT.Focus();
        return;
	 }
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
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
<script language=JavaScript for=DS_O_H_STR event=OnFilter(row)>
if (DS_O_H_STR.NameValue(row, "GBN") != "0") {// 본사점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_REQ_STR event=OnFilter(row)>
if (DS_O_REQ_STR.NameValue(row, "GBN") == "0") {// 매장점 만 셋팅
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if (DS_O_MASTER.CountRow > 0) {
    //디테일 조회
    getDetail();
 // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
 
    EM_IN_CONF_DT.Text = strToday;
    strOldDate = EM_IN_CONF_DT.Text;
}
</script>
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
if(EM_IN_CONF_DT.Text != strOldDate && !btnClickSave){
    if(showMessage(QUESTION , YESNO, "USER-1049") == 1 ){
    	EM_IN_CONF_DT.Text = "";
        return true;
    }else{
        return false;
    }
}
return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
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
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_H_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_REQ_STR" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF_S"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" class="point">신청점</th>
            <td  width="150">
                <comment id="_NSID_">
                   <object id=LC_REQ_STR classid=<%= Util.CLSID_LUXECOMBO %>  tabindex=1 height=100 width=140 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
              <th width="80">출고점</th>
            <td  width="150">
                <comment id="_NSID_">
                   <object id=LC_H_STR classid=<%= Util.CLSID_LUXECOMBO %>  tabindex=1 height=100 width=140 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
              </td>
            <th width="80" class="point">신청기간</th>
            <td>
                <comment id="_NSID_">
                <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=70 tabindex=1 align="absmiddle">
                </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" /> ~ 
               <comment id="_NSID_">
                <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width=70 tabindex=1 align="absmiddle">
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
            </td>
          </tr>           
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr valign="bottom">
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td class="PB05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=180 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_MASTER">
                <Param Name="ViewSummary"   value="1" >
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
         </tr>
        </table>
       </td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
              <th width="80" class="point">입고확정일자</th>
            <td>
                 <comment id="_NSID_">
                <object id=EM_IN_CONF_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:chkOutDt();"  width=120 tabindex=1 align="absmiddle">
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_CAL onclick="javascript:openCal('G',EM_IN_CONF_DT)" align="absmiddle" />
              </td>
          </tr>  
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr valign="bottom">
    <td class="dot"></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td class="sub_title">
            <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/> 신청내역
        </td>
        </tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=225 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_DETAIL">
                <Param Name="ViewSummary"   value="1" >
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
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
