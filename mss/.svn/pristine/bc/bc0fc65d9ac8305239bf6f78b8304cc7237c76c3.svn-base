<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품지급정산 > 협력사별 정산확정
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE6030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var old_Row = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_IO_CARD_DETAIL.setDataHeader('<gauce:dataset name="H_CARD_DETAIL"/>');
    DS_IO_MUL_DETAIL.setDataHeader('<gauce:dataset name="H_MUL_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    gridCreate1(); //카드 디테일
    gridCreate2(); //물품 디테일
    
    // EMedit에 초기화
    initEmEdit(EM_S_EVENT_S_DT, "SYYYYMMDD", PK);         //행사기간 S
    initEmEdit(EM_S_EVENT_E_DT, "TODAY", PK);         //행사기간 E
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11", NORMAL);         //행사코드
    initEmEdit(EM_S_EVENT_NM, "GEN^11", READ);           //행사코드명
    
    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점
    getStore("DS_O_S_STR", "Y", "1", "N");
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();

}


function gridCreate(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=70   align=center</FC>'
			        + '<FC>id=STR_NM    name="점"       width=100  align=left</FC>'
                    + '<FC>id=EVENT_NAME    name="행사명"       width=150  align=left</FC>'
                    + '<FC>id=EVENT_DT    name="행사기간"       width=150  align=center</FC>'
                    + '<FC>id=EVENT_TYPE_NM    name="사은행사유형"       width=150  align=left</FC>'
                    + '<FC>id=EVENT_GIFT_NM    name="사은품종류"       width=150  align=left</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=70   align=center</FC>'
    	           + '<FC>id=CHK    name=""    edit={if(CONF_FLAG == "1", false, true)}   width=30  align=center  EditStyle=CheckBox  HeadCheckShow="true" </FC>'
                    + '<FC>id=CCOMP_NM    name="제휴카드사"    edit=none   width=100  align=left</FC>'
                    + '<FC>id=VEN_NAME    name="카드협력사"    edit=none   width=100  align=left</FC>'
                    + '<FC>id=APP_RATE    name="부담율"      edit=none width=60  align=right</FC>'
                    + '<FC>id=CAL_AMT    name="물품정산금액"  edit=none     width=100  align=right</FC>'
                    + '<FC>id=GIFT_CAL_AMT    name="상품권정산금액"    edit=none   width=100  align=right</FC>'
                    + '<FC>id=TOTAL_AMT    name="총정산금액"    edit=none   width=100  align=right</FC>'
                    + '<FC>id=CONF_FLAG_NM    name="정산확정"   edit=none    width=100  align=left</FC>'
                    ;
                     
    initGridStyle(GD_CARD_DETAIL, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
    	            + '<FC>id=CHK    name=""   edit={if(CONF_FLAG == "1", false, true)}    width=30  align=center  EditStyle=CheckBox  HeadCheckShow="true" </FC>'
			        + '<FC>id=VEN_NM    name="협력사"   sumtext="합계"   edit=none  width=90  align=left </FC>'
			        + '<FC>id=IN_AMT    name="입고"  sumtext="@sum"  edit=none  width=90   align=right</FC>'
			        + '<FG>id=VEN_NM    name="지급"       width=90 edit=none align=center'
			        + '<FC>id=PRSNT_AMT    name="정상지급"    sumtext="@sum" edit=none   width=90  align=right</FC>'
			        + '<FC>id=EXCP_PRSNT_AMT    name="예외지급"  sumtext="@sum"  edit=none  width=90   align=right</FC>'
			        + '<FC>id=RECOVERY_AMT    name="지급취소(정상)"  sumtext="@sum"   edit=none   width=90  align=right</FC>'
			        + '<FC>id=ETC_PRSNT_AMT    name="기타지급"   sumtext="@sum"  edit=none   width=90  align=right</FC>'
			        + '<FC>id=TOT_PRSNT_AMT    name="누적지급"  sumtext="@sum"  edit=none  width=90   align=right</FC></FG>'
			        + '<FC>id=LOSS_AMT    name="LOSS금액"   sumtext="@sum"    edit=none  width=90  align=right</FC>'
			        + '<FC>id=PAY_AMT    name="지급금액"    sumtext="@sum"  edit=none  width=90  align=right</FC>'
			        + '<FC>id=CAL_AMT    name="정산금액"   sumtext="@sum"   edit=none width=90   align=right</FC>'
			        + '<FC>id=CONF_FLAG_NM    name="정산확정"   edit=none    width=100  align=left</FC>'
			        ;
                     
    initGridStyle(GD_MUL_DETAIL, "common", hdrProperies, true);
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_S_STR.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR.focus();
        return;
    }
    if(EM_S_EVENT_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_EVENT_S_DT.focus();
        return;
    }else if(EM_S_EVENT_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_EVENT_E_DT.focus();
        return;
    }else if(EM_S_EVENT_S_DT.Text > EM_S_EVENT_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_EVENT_S_DT.focus();
        return;
    }
    
    DS_O_MASTER.ClearData();
    DS_IO_CARD_DETAIL.ClearData();
    DS_IO_MUL_DETAIL.ClearData();
    
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;
    var strSdt          = EM_S_EVENT_S_DT.Text;
    var strEdt          = EM_S_EVENT_E_DT.Text;
    var strEventCd      = EM_S_EVENT_CD.Text;
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strSdt="    + encodeURIComponent(strSdt)
                   + "&strEdt="    + encodeURIComponent(strEdt)
                   + "&strEventCd="+ encodeURIComponent(strEventCd);
    TR_MAIN.Action="/mss/mcae603.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    old_Row = 1;
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
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
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
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	// 저장할 데이터 없는 경우
     if (!DS_IO_CARD_DETAIL.IsUpdated && !DS_IO_MUL_DETAIL.IsUpdated) {
        showMessage(EXCLAMATION , OK, "USER-1000","확정할 내용이 없습니다.");
        return;
    }
	
     if (showMessage(QUESTION , YESNO, "USER-1000", "확정 하시겠습니까?") != 1) return;
     
	TR_MAIN.Action="/mss/mcae603.mc?goTo=save"; 
	TR_MAIN.KeyValue="SERVLET(I:DS_IO_CARD_DETAIL=DS_IO_CARD_DETAIL,I:DS_IO_MUL_DETAIL=DS_IO_MUL_DETAIL)";
	                  
	TR_MAIN.Post();
	btn_Search();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getSEvent()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-01-26
  * 개    요 :  조회용 이벤트 팝업
  * return값 : void
  */
  function getSEvent(){
     
     // 조회 이벤트 조건 검색시 점코드 필수 
     if(LC_S_STR.BindColVal.length == 0){
         showMessage(EXCLAMATION , OK, "USER-1001", "점");
         return;
     }
    //mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N',LC_S_STR.BindColVal, EM_S_EVENT_S_DT.Text, EM_S_EVENT_E_DT.Text);
    mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR.BindColVal, '4/6');
  }
  
  /**
   * getDtl()
   * 작 성 자 : 신익수
   * 작 성 일 : 2011-06-03
   * 개    요 :  카드별,물품별 조회
   * return값 : void
   */
  function getDtl(strStrCd,strEventCd) {
	   
	    DS_IO_CARD_DETAIL.ClearData();
	    DS_IO_MUL_DETAIL.ClearData();
	   
	    //카드별 조회
	    var goTo       = "getCardDetail" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
	                   + "&strEventCd="+ encodeURIComponent(strEventCd);
	    TR_CARD_DETAIL.Action="/mss/mcae603.mc?goTo="+goTo+parameters;  
	    TR_CARD_DETAIL.KeyValue="SERVLET("+action+":DS_IO_CARD_DETAIL=DS_IO_CARD_DETAIL)"; //조회는 O
	    TR_CARD_DETAIL.Post();
	    
	    //물품별 조회
	    var goTo1       = "getMulDetail" ;
        var action1     = "O";     
        var parameters1 = "&strStrCd=" + encodeURIComponent(strStrCd)
                       + "&strEventCd="+ encodeURIComponent(strEventCd);
        TR_MUL_DETAIL.Action="/mss/mcae603.mc?goTo="+goTo1+parameters1;  
        TR_MUL_DETAIL.KeyValue="SERVLET("+action1+":DS_IO_MUL_DETAIL=DS_IO_MUL_DETAIL)"; //조회는 O
        TR_MUL_DETAIL.Post();
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
<script language=JavaScript for=TR_CARD_DETAI event=onSuccess>
    for(i=0;i<TR_CARD_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CARD_DETAI.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_MUL_DETAI event=onSuccess>
    for(i=0;i<TR_MUL_DETAI.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MUL_DETAI.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_CARD_DETAI event=onFail>
trFailed(TR_CARD_DETAI.ErrorMsg);
</script>
<script language=JavaScript for=TR_MUL_DETAI event=onFail>
trFailed(TR_MUL_DETAI.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row != row ){
    var strStrCd = DS_O_MASTER.NameValue(row, "STR_CD");
    var strEventCd = DS_O_MASTER.NameValue(row, "EVENT_CD");

    // 디테일 조회
    getDtl(strStrCd,strEventCd);
}
old_Row = row;

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language="javascript"  for=GD_CARD_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
    	strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_CARD_DETAIL.CountRow;i++){
        if (DS_IO_CARD_DETAIL.NameValue(i,"CONF_FLAG") != "1") {
            DS_IO_CARD_DETAIL.NameValue(i,"CHK") = strFlag;
        }
    }
</script>

<script language="javascript"  for=GD_MUL_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_MUL_DETAIL.CountRow;i++){
    	if (DS_IO_MUL_DETAIL.NameValue(i,"CONF_FLAG") != "1") {
           DS_IO_MUL_DETAIL.NameValue(i,"CHK") = strFlag;
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
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CARD_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MUL_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_S_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_CARD_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MUL_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
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
              <th width="50" class="point">점</th>
              <td width="120">
                  <comment id="_NSID_">
                     <object id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> width="117" tabindex=1 align="absmiddle"> 
                     </object>
                  </comment><script>_ws_(_NSID_);</script>
              </td>
              <th width="60" class="point">행사기간</th>
              <td width="200">
                  <comment id="_NSID_">
                     <object id=EM_S_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%> width="70" onblur="javascript:checkDateTypeYMD(this);" tabindex=1 align="absmiddle"> 
                     </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_EVENT_S_DT)" /> ~ 
                  <comment id="_NSID_">
                     <object id=EM_S_EVENT_E_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" tabindex=1 align="absmiddle">
                     </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_EVENT_E_DT)" align="absmiddle" />
              </td>
              <th width="60">행사코드</th>
              <td><comment id="_NSID_"> 
                      <object id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"> 
                      </object> 
                  </comment> <script>_ws_(_NSID_);</script> 
                  <img src="/pot/imgs/btn/detail_search_s.gif" onclick="javascript:getSEvent();" align="absmiddle" /> 
                  <comment id="_NSID_"> 
                      <object id=EM_S_EVENT_NM classid=<%=Util.CLSID_EMEDIT%> width=120 align="absmiddle">
                      </object> 
                 </comment> <script> _ws_(_NSID_);</script>
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
    <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>             
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=190 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
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
    <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>             
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_CARD_DETAIL width=100% height=65 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_CARD_DETAIL">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>           
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_MUL_DETAIL width=100% height=228 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_MUL_DETAIL">
                <Param Name="ViewSummary"   value="1" >
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</DIV>
</body>
</html>

