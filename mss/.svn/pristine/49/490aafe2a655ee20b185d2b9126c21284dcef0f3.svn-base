<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 정산관리>가맹점 정산조회
 * 작 성 일 : 2011.03.18
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif6080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 가맹점 정산 내역을 조회 한다.
 * 이    력 : 2011.03.14 (신익수) 신규개발
 *         
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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--


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
 var top = 120;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
  
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_CAL_YM_FROM, "THISMN", PK);       //폐기일자 from
    initEmEdit(EM_S_CAL_YM_TO, "THISMN", PK);         //폐기일자 to
    initEmEdit(EM_O_JOINVEN_CD, "GEN^6", NORMAL);  //가맹점코드 (조회)
    initEmEdit(EM_O_JOINVEN_NM, "GEN^40", READ);  //가맹점명 (조회)
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //점
    
    getStore("DS_O_STR_CD", "Y", "", "Y");
    
    LC_STR_CD.index = 0;
    
    LC_STR_CD.Focus();
}

function gridCreate(){
	 var hdrProperies =   '<FC>id={currow}         name="NO"          width=25   align=center</FC>'
				        + '<FC>id=CAL_YM              name="정산년월"     width=100   align=center mask="XXXX/XX" sumtext="합계"</FC>'
				        + '<FC>id=STR_NM             name="점"          width=100  align=left </FC>'
				        + '<FC>id=VEN_NM             name="가맹점"          width=180  align=left </FC>'
				        + '<FC>id=BOND_AMT             name="자사상품권;회수금액"          width=80  align=right  sumtext=@sum </FC>'
				        + '<FC>id=BOND_AMT2         name="제휴상품권;회수금액"      width=100   align=light sumtext=@sum </FC>'
				        + '<FC>id=REAL_PAY_AMT          name="총회수 정산금액"     width=100   align=light sumtext=@sum </FC>'
				        + '<FC>id=FEE_RATE          name="수수료율"     width=100   align=light sumtext=@sum </FC>'
				        + '<FC>id=FEE_SUP_AMT             name="수수료공급가"          width=80  align=right  sumtext=@sum </FC>'
                        + '<FC>id=FEE_VAT_AMT         name="수수료부가세"      width=100   align=light sumtext=@sum </FC>'
                        + '<FC>id=FEE_TOT_AMT          name="수수료합계"     width=100   align=light sumtext=@sum </FC>'
                        + '<FC>id=CAL_AMT          name="정산금액"     width=100   align=light sumtext=@sum </FC>'
                        ;
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	GD_MASTER.TitleHeight = 40;
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
	if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }

     // 조회조건 셋팅
     var strStrCd        = LC_STR_CD.BindColVal;           //점코드
     var strCalYmFrom          = EM_S_CAL_YM_FROM.Text;  //회수일자 FROM
     var strCalYmTo          = EM_S_CAL_YM_TO.Text;      //회수일자 TO
     var strVenCd = EM_O_JOINVEN_CD.Text;//가맹점 코드 
     
     if(strCalYmFrom > strCalYmTo) {
         showMessage(INFORMATION, OK, "USER-1000","시작월은 종료월보다 작아야 합니다.");
         EM_S_CAL_YM_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     
     var goTo       = "getJoinCalMst" ;    
     var action     = "O";     
     var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strCalYmFrom="+ encodeURIComponent(strCalYmFrom)
                    + "&strCalYmTo="  + encodeURIComponent(strCalYmTo)
                    + "&strVenCd="    + encodeURIComponent(strVenCd)
                    ;
     
     TR_MAIN.Action="/mss/mgif608.mg?goTo="+goTo+parameters;  
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
     var ExcelTitle = "가맹점 정산조회";
         openExcel2(GD_MASTER, ExcelTitle, "", true );
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN1.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN1.ErrorMsg);
    for(i=1;i<TR_MAIN1.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN1.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 
 <script language=JavaScript for=EM_O_JOINVEN_CD event=OnKillFocus()>
//if(this.Text.length > 0){
	if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_JOINVEN_NM.Text = "";
        return;
    }
    
  /*  if(LC_STR_CD.BindColVal == "%"){
        showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
        LC_STR_CD.Focus();
        return;
    }*/
    getMssEvtVenNonPop( "DS_O_RESULT", EM_O_JOINVEN_CD, EM_O_JOINVEN_NM, "E", "Y", "2", '', LC_STR_CD.BindColVal);
//}
//return true;
</script>
 
<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	EM_O_JOINVEN_CD.Text = "";
	EM_O_JOINVEN_NM.Text = "";
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
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
             <th width="80" >점</th>
             <td width="170">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle" tabindex=1></object>
               </comment>
               <script>_ws_(_NSID_);</script> 
             </td>
             <th width="80" class="POINT">정산년월</th>
             <td>
                <comment id="_NSID_">
                    <object id=EM_S_CAL_YM_FROM classid=<%=Util.CLSID_EMEDIT%> width="60" onblur="checkDateTypeYM(this);" align="absmiddle" tabindex=1> 
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('M',EM_S_CAL_YM_FROM)" /> ~ 
                 <comment id="_NSID_">
                    <object id=EM_S_CAL_YM_TO classid=<%=Util.CLSID_EMEDIT%> width="60" onblur="checkDateTypeYM(this);" align="absmiddle" tabindex=1>
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_CAL_YM_TO)" align="absmiddle" />
             </td>
         </tr>
         <tr>
              <th width="80" >가맹점</th>
             <td colspan="4">
                <comment id="_NSID_">
                <object id=EM_O_JOINVEN_CD classid=<%= Util.CLSID_EMEDIT %> width=50 align="absmiddle" tabindex=1>
                </object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:getMssEvtVenPop( EM_O_JOINVEN_CD, EM_O_JOINVEN_NM, 'S', '2', '', LC_STR_CD.BindColVal);"   align="absmiddle" />
                                                                                        
              <comment id="_NSID_">
                <object id=EM_O_JOINVEN_NM classid=<%= Util.CLSID_EMEDIT %> width=155 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
             </td>
         </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->

  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=760 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
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

