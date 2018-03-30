<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품지급정산 > 사은행사 정산관리
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE6010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 지급된 사은품에 대한 정산자료를 생성한다.
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
 *        2011.03.15 (김성미) 프로그램 작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); 
    gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11", PK);           //행사코드
    initEmEdit(EM_S_EVENT_NM, "GEN", READ);         //행사명
    
    initEmEdit(EM_EVENT_TYPE_NM, "GEN", READ);          //사은행사 유형
    initEmEdit(EM_EVENT_NM, "GEN", READ);          //행사명
    initEmEdit(EM_EVENT_S_DT, "YYYYMMDD", READ);        //행사기간S
    initEmEdit(EM_EVENT_E_DT, "YYYYMMDD", READ);         //행사기간E
    
    initEmEdit(EM_CAL_AMT, "NUMBER^12^0", READ);         //물품지급
    initEmEdit(EM_LOSS_AMT, "NUMBER^12^0", READ);          //LOSS금액
    initEmEdit(EM_GIFT_CAL_AMT, "NUMBER^12^0", READ);         //상품권지급

    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    
    getStore("DS_O_STR", "Y", "1", "N");
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=70   align=center</FC>'
			        + '<FC>id=CARD_COMP_NM    name="제휴카드사"       width=100  align=left</FC>'
                    + '<FC>id=VEN_NM    name="카드협력사"       width=100  align=left</FC>'
                    + '<FC>id=APP_RATE    name="부담율"    width=100  align=right</FC>'
                    + '<FC>id=PRSNT_PRD_AMT    name="물품지급금액"       width=100  align=right</FC>'
                    + '<FC>id=CAL_AMT    name="물품정산금액"       width=100  align=right</FC>'
                    + '<FC>id=PRSNT_GIFT_AMT    name="상품권지급금액"       width=100  align=right</FC>'
                    + '<FC>id=GIFT_CAL_AMT    name="상품권정산금액"       width=100  align=right</FC>'
                    + '<FC>id=TOT_CAL_AMT    name="총정산금액"       width=100  align=right</FC>'
                    + '<FC>id=CONF_FLAG_NM    name="정산확정"       width=100  align=left</FC>';
                     
    initGridStyle(GD_CARDCAL, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=VEN_NM    name="협력사"   sumtext="합계"     width=90  align=left</FC>'
			        + '<FC>id=IN_AMT    name="입고"  sumtext="@sum"    width=90   align=right</FC>'
			        + '<FG>id=VEN_NM    name="지급"       width=90  align=center'
                    + '<FC>id=PRSNT_AMT    name="정상지급"    sumtext="@sum"    width=90  align=right</FC>'
                    + '<FC>id=EXCP_PRSNT_AMT    name="예외지급"  sumtext="@sum"    width=90   align=right</FC>'
                    + '<FC>id=RECOVERY_AMT    name="지급취소(정상)"  sumtext="@sum"      width=90  align=right</FC>'
                    + '<FC>id=ETC_PRSNT_AMT    name="기타지급"   sumtext="@sum"     width=90  align=right</FC>'
                    + '<FC>id=TOT_PRSNT_AMT    name="누적지급"  sumtext="@sum"    width=90   align=right</FC></FG>'
                    + '<FC>id=LOSS_AMT    name="LOSS금액"   sumtext="@sum"      width=90  align=right</FC>'
                    + '<FC>id=PAY_AMT    name="지급금액"    sumtext="@sum"    width=90  align=right</FC>'
                    + '<FC>id=CAL_AMT    name="정산금액"   sumtext="@sum"   width=90   align=right</FC>'
                    + '<FC>id=CONF_FLAG_NM    name="정산확정"       width=90  align=left</FC>';
    GD_PRSNTCAL.ViewSummary = "1";                
    initGridStyle(GD_PRSNTCAL, "common", hdrProperies2, false);
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
 * 작 성 일 : 2011-03-15
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 DS_O_EVENTINFO.ClearData();
	 DS_O_CARDCAL.ClearData();
	 DS_O_PRSNTCAL.ClearData();
     
    if(LC_S_STR.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR.focus();
        return;
    }
    if(EM_S_EVENT_CD.Text.length == 0){   // 행사코드
        showMessage(EXCLAMATION , OK, "USER-1001","행사코드");
        EM_S_EVENT_CD.focus();
        return;
    }
    
    // 조회조건 셋팅
    var strStrCd            = LC_S_STR.BindColVal;
    var strEventCd          = EM_S_EVENT_CD.Text;
    
    var goTo       = "getEventInfo" ;    
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEventCd="+ encodeURIComponent(strEventCd);
    TR_MAIN.Action="/mss/mcae601.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_EVENTINFO=DS_O_EVENTINFO)"; //조회는 O
    TR_MAIN.Post();
   
    if(DS_O_EVENTINFO.CountRow == 0){
    	showMessage(EXCLAMATION , OK, "USER-1000","사은행사 정산정보가 없습니다.");
    	EM_S_EVENT_CD.Text = "";
    	EM_S_EVENT_NM.Text = "";
    	LC_S_STR.focus();
        return;
    }
    getCalInfo();
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
 * 작 성 일 : 2011-03-21
 * 개    요 :  사은행사 정산 저장
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

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getCalInfo()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-12-12
  * 개    요 : 조회시 호출
  * return값 : void
  */
 function getCalInfo() {
     
     // 조회조건 셋팅
     var strStrCd              = LC_S_STR.BindColVal;
     var strEventCd            = EM_S_EVENT_CD.Text;
     var strEventType          = DS_O_EVENTINFO.NameValue(DS_O_EVENTINFO.RowPosition,"EVENT_TYPE");
     
     var goTo       = "getCalInfo";    
     var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strEventCd="  + encodeURIComponent(strEventCd)
                    + "&strEventType="+ encodeURIComponent(strEventType);
     TR_MAIN.Action="/mss/mcae601.mc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET(O:DS_O_CARDCAL=DS_O_CARDCAL,O:DS_O_PRSNTCAL=DS_O_PRSNTCAL)"; //조회는 O
     TR_MAIN.Post();
    
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_PRSNTCAL.CountRow);
    
     if(DS_O_CARDCAL.CoutRow > 0 ) GD_CARDCAL.Focus(); return;
     
     if(DS_O_PRSNTCAL.CoutRow > 0 ) GD_PRSNTCAL.Focus();
    
 }
 
 /**
  * saveCal()
  * 작 성 자 : FKL
  * 작 성 일 : 2011-03-22
  * 개    요 : 정산재생성
  * return값 : void
  */
 function saveCal() {
     
	// 저장할 데이터 없는 경우
	    if (DS_O_EVENTINFO.CountRow == 0 && DS_O_CARDCAL.CountRow == 0 && DS_O_PRSNTCAL.CountRow == 0){
	        showMessage(EXCLAMATION , OK, "USER-1028");
	        return;
	    }
	    
	    var strCardFlag = 0;
	    // 제휴카드사 확정/미확정 건수 체크
	    for(var i=1;i<=DS_O_CARDCAL.CountRow;i++){
	        if(DS_O_CARDCAL.NameValue(i,"CONF_FLAG") != "1"){
	            DS_O_CARDCAL.UserStatus(i) = 1; 
	            strCardFlag += 1;
	        }
	    }
	    
	    var strSkuFlag = 0;
	    // 제휴카드사 확정/미확정 건수 체크
	    for(var j=1;j<=DS_O_PRSNTCAL.CountRow;j++){
	        if(DS_O_PRSNTCAL.NameValue(j,"CONF_FLAG") != "1"){
	            DS_O_PRSNTCAL.UserStatus(j) = 1; 
	            strSkuFlag += 1;
	        }
	    }
	    
	    if(strCardFlag == 0 && strSkuFlag == 0){
	        showMessage(EXCLAMATION , OK, "USER-1000","재생성할 미확정 정산 내역이 없습니다.");
	        return;
	    }
	    
	    if(showMessage(QUESTION , YESNO, "GAUCE-1000", "제휴카드사 정산내역 "+strCardFlag+"건,<br> 물품 정산내역 "+strSkuFlag+"건을 재생성 하시겠습니까?") != 1 ){
	        return;
	    }
	    
	    TR_MAIN.Action="/mss/mcae601.mc?goTo=save"; 
	    TR_MAIN.KeyValue="SERVLET(I:DS_O_PRSNTCAL=DS_O_PRSNTCAL,I:DS_O_CARDCAL=DS_O_CARDCAL)"; //조회는 O
	    TR_MAIN.Post();
	    
	    btn_Search();
 }
 
 /**
  * openPop()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-03-15
  * 개    요 : 정산 상세 자료조회 popup
  * return값 : void
  */
 function openPop(){
     var arrArg  = new Array();
     arrArg.push(DS_O_PRSNTCAL.NameValue(DS_O_PRSNTCAL.RowPosition,"STR_CD"));
     arrArg.push(DS_O_PRSNTCAL.NameValue(DS_O_PRSNTCAL.RowPosition,"EVENT_CD"));
     arrArg.push(DS_O_PRSNTCAL.NameValue(DS_O_PRSNTCAL.RowPosition,"VEN_CD"));
     var returnVal = window.showModalDialog("/mss/mcae601.mc?goTo=openPop",
                                            arrArg,
                                            "dialogWidth:900px;dialogHeight:320px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회용 행사코드명 한건 조회 -->
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_S_EVENT_CD.text ==""){
	EM_S_EVENT_NM.Text = "";
       return;
   }
   
if(EM_S_EVENT_CD.text!=null){
        if(EM_S_EVENT_CD.text.length > 0){
            // 조회 이벤트 조건 검색시 점코드 필수 
            if(LC_S_STR.BindColVal.length == 0){
                showMessage(EXCLAMATION, OK, "USER-1001", "점");
                return;
            }
            var ret = setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM, '', '', "N", LC_S_STR.BindColVal);
            
            // 조회내용이 없거나 1개 이상이면 팝업 호출
            if(ret.CountRow == 1){
            	EM_S_EVENT_CD.Text = ret.NameValue(ret.RowPosition, "EVENT_CD");
                EM_S_EVENT_NM.Text = ret.NameValue(ret.RowPosition, "EVENT_NM");
            }else{
                mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N', LC_S_STR.BindColVal);
            }
            
        }
    }
</script>
<script language=JavaScript for=GD_PRSNTCAL event=OnDblClick(row,colid)>
if(row == 0) return;
openPop();
</script>
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
 EM_S_EVENT_CD.Text = "";
 EM_S_EVENT_NM.Text = "";
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
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_EVENTINFO"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CARDCAL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PRSNTCAL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
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
<body onLoad="doInit();" class="PL10 PT15">
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
                      <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
	          <th width="80" class="point">행사코드</th>
	          <td> 
	              <comment id="_NSID_">
	                      <object id=EM_S_EVENT_CD classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>	
	               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N', LC_S_STR.BindColVal)"  align="absmiddle"/>  
	              <comment id="_NSID_">
                          <object id=EM_S_EVENT_NM classid=<%= Util.CLSID_EMEDIT %> width=150 tabindex=1 align="absmiddle">
                          </object>
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
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="sub_title">
              <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>사은행사 정산정보</td>   
           <td align="right">
            <img src="/<%=dir%>/imgs/btn/re_fee.gif" onclick="javascript:saveCal();" align="absmiddle"/> 
            </td>          
          </tr>
        </table></td>
      </tr>
      <tr> 
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>               
	        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
	          <tr>
	          <th width="83">사은행사 유형</th>
                <td width="140"> 
                    <comment id="_NSID_">
                            <object id=EM_EVENT_TYPE_NM classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
                            </object>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
	            <th width="83">행사명</th>
	            <td width="140"> 
	                <comment id="_NSID_">
	                        <object id=EM_EVENT_NM classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
	                        </object>
	                </comment><script>_ws_(_NSID_);</script>
	            </td>
	            <th width="80" >행사기간</th>            
	            <td align="absmiddle"> 
	                <comment id="_NSID_">
	                        <object id=EM_EVENT_S_DT classid=<%= Util.CLSID_EMEDIT %> width=103 tabindex=1 align="absmiddle">
	                        </object>
	                </comment><script>_ws_(_NSID_);</script>  
	                ~
	                <comment id="_NSID_">
	                        <object id=EM_EVENT_E_DT classid=<%= Util.CLSID_EMEDIT %> width=103 tabindex=1 align="absmiddle">
	                        </object>
	                </comment><script>_ws_(_NSID_);</script> 
	            </td>
	          </tr>
	          <tr>
                <th width="83">물품지급</th>
                <td width="140">
                    <comment id="_NSID_">
                        <object id=EM_CAL_AMT classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script> 
                <th width="80">LOSS금액</th>
                <td width="140"> 
                    <comment id="_NSID_">
                            <object id=EM_LOSS_AMT classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
                            </object>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80">상품권지급</th>            
                <td> 
                    <comment id="_NSID_">
                            <object id=EM_GIFT_CAL_AMT classid=<%= Util.CLSID_EMEDIT %> width=220 tabindex=1 align="absmiddle">
                            </object>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>  
	        </table></td>
	      </tr>
	    </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>  
  <tr valign="top">
    <td width="100%"  class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height=18><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="sub_title">
              <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>제휴카드사 정산내역</td>                
          </tr>
        </table></td>
      </tr> 
      <tr>             
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_CARDCAL width=100% height=70 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_CARDCAL">
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
  <tr>
    <td width="100%" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr height=18>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="sub_title">
              <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>물품 정산내역</td>                
          </tr>
        </table></td>
      </tr>   
      <tr>           
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_PRSNTCAL width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_PRSNTCAL">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_EVENT_INFO classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_EVENTINFO>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=EVENT_TYPE_NM    Ctrl=EM_EVENT_TYPE_NM    param=Text</c>
        <c>Col=EVENT_NAME       Ctrl=EM_EVENT_NM         param=Text</c>
        <c>Col=EVENT_S_DT       Ctrl=EM_EVENT_S_DT       param=Text</c>
        <c>Col=EVENT_E_DT       Ctrl=EM_EVENT_E_DT       param=Text</c>
        <c>Col=CAL_AMT          Ctrl=EM_CAL_AMT          param=Text</c>
        <c>Col=LOSS_AMT         Ctrl=EM_LOSS_AMT         param=Text</c>
        <c>Col=GIFT_CAL_AMT     Ctrl=EM_GIFT_CAL_AMT     param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

