<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 저장품 > 저장품재고현황
 * 작 성 일 : 2010.06.02
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pstk4050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 저장품에 대한 현재고 현황을 조회  한다.
 * 이    력 :
 *        2010.06.02 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_FROM_DT     , "TODAY"    , PK);      //기간(From)
    initEmEdit(EM_TO_DT       , "TODAY"    , PK);      //기간(To)
    initEmEdit(EM_VEN_CD      , "CODE^6^0" , NORMAL);  //협력사코드
    initEmEdit(EM_VEN_NAME    , "GEN^40"   , READ);    //협력사명
    initEmEdit(EM_PUMBUN_CD   , "CODE^6^0" , NORMAL);  //브랜드코드
    initEmEdit(EM_PUMBUN_NAME , "GEN^40"   , READ);    //브랜드명
    initEmEdit(EM_SKU_CD      , "CODE^13^0", NORMAL);  //단품코드
    initEmEdit(EM_SKU_NAME    , "GEN^40"   , READ);    //단품명
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD      ,DS_STR_CD      , "CODE^0^30,NAME^0^155", 1, PK);      //점(조회)

    // 점코드 조회
    getStore("DS_STR_CD"    , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
    	LC_STR_CD.Index= 0;
    }
    
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center sumtext=""   name="NO"           </FC>'
                     + '<FC>id=PUMBUN_CD       width=55   align=center sumtext=""   name="브랜드;코드"     </FC>'
                     + '<FC>id=PUMBUN_NAME     width=110  align=left   sumtext=""   name="브랜드명"       </FC>'
                     + '<FC>id=SKU_CD          width=105  align=center sumtext=""   name="단품;코드"     </FC>'
                     + '<FC>id=SKU_NAME        width=125  align=left   sumtext=""   name="단품명"       </FC>'
                     + '<C>id=VEN_CD           width=55   align=center sumtext=""   name="협력사;코드"   </C>'
                     + '<C>id=VEN_NAME         width=110  align=left   sumtext=""   name="협력사명"     </C>'
                     + '<G>name="전일재고"'
                     + '<C>id=BAS_QTY          width=65   align=right  sumtext=@sum name="수량"         </C>'
                     + '<C>id=BAS_AMT          width=85   align=right  sumtext=@sum name="금액"         </C>'
                     + '</G>'
                     + '<G>name="입고"'
                     + '<C>id=IN_QTY           width=65   align=right  sumtext=@sum name="수량"         </C>'
                     + '<C>id=IN_AMT           width=85   align=right  sumtext=@sum name="금액"         </C>'
                     + '</G>'
                     + '<G>name="입고반품"'
                     + '<C>id=IN_RFD_QTY       width=65   align=right  sumtext=@sum name="수량"         </C>'
                     + '<C>id=IN_RFD_AMT       width=85   align=right  sumtext=@sum name="금액"         </C>'
                     + '</G>'
                     + '<G>name="출고"'
                     + '<C>id=OUT_QTY          width=65   align=right  sumtext=@sum name="수량"         </C>'
                     + '<C>id=OUT_AMT          width=85   align=right  sumtext=@sum name="금액"         </C>'
                     + '</G>'
                     + '<G>name="출고반품"'
                     + '<C>id=OUT_RFD_QTY      width=65   align=right  sumtext=@sum name="수량"         </C>'
                     + '<C>id=OUT_RFD_AMT      width=85   align=right  sumtext=@sum name="금액"         </C>'
                     + '</G>'
                     + '<G>name="기말재고"'
                     + '<C>id=TERM_END_QTY     width=65   align=right  sumtext=@sum name="수량"         </C>'
                     + '<C>id=TERM_END_AMT     width=85   align=right  sumtext=@sum name="금액"         </C>'
                     + '</G>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";  
    GD_MASTER.ColumnProp("SKU_CD", "sumtext")        = "합계";
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
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( EM_FROM_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간(From)");
        EM_FROM_DT.Focus();
        return;
    }
    if( EM_TO_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간(To)");
        EM_TO_DT.Focus();
        return;
    }
    if( EM_TO_DT.Text < EM_FROM_DT.Text){
        showMessage(EXCLAMATION, OK, "USER-1020", "기간(To)", "기간(From)");
        EM_TO_DT.Focus();
        return;
    }
    searchMaster();
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
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  저장품 재고 리스트 조회
 * return값 : void
 */
function searchMaster(){

	DS_MASTER.ClearData();
    
    var strStrCd      = LC_STR_CD.BindColVal;
    var strFromDt     = EM_FROM_DT.Text;
    var strToDt       = EM_TO_DT.Text;
    var strVenCd      = EM_VEN_CD.Text;
    var strPumbunCd   = EM_PUMBUN_CD.Text;
    var strSkuCd      = EM_SKU_CD.Text;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strFromDt="+encodeURIComponent(strFromDt)
                   + "&strToDt="+encodeURIComponent(strToDt)
                   + "&strVenCd="+encodeURIComponent(strVenCd)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd);
    TR_MAIN.Action="/dps/pstk405.pt?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * getVenCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사명을 등록한다.
 * return값 : void
 */
function getVenCode(evnflag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;
    var strObj  = LC_STR_CD;

    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        venPop(codeObj,nameObj,strObj.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1, strObj.BindColVal);
    }
}

/**
 * getCalDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function getCalDt(evnFlag, obj, scvFlag){
    
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    
    if(!checkDateTypeYMD( obj , getTodayFormat("YYYYMMDD")))
        return;
    
}
/**
 * getPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function getPumbunCode(evnflag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;
    var strObj  = LC_STR_CD;

    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
    	strPbnPop(codeObj,nameObj,'Y','',strObj.BindColVal,'','','','','','1');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
    	setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,'Y', 1,'', strObj.BindColVal,'','','','','','1');
    }    
}


/**
 * getSkuCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.
 * return값 : void
**/
function getSkuCode(evnFlag){
    var codeObj = EM_SKU_CD;
    var nameObj = EM_SKU_NAME;
    var strObj  = LC_STR_CD;

    if( codeObj.Text == "" && evnFlag != 'POP'){
        nameObj.Text = "";
        return;
    }
    
    if( evnFlag == 'POP'){
        strSkuPop(codeObj,nameObj,'Y', '', strObj.BindColVal, EM_PUMBUN_CD.Text, '', '', 'Y', '', '', EM_VEN_CD.Text);
        codeObj.Focus();
    }else{
        setStrSkuNmWithoutPop("DS_SEARCH_NM", codeObj, v,'Y', 1, '', strObj.BindColVal, EM_PUMBUN_CD.Text, '', '', 'Y', '', '', EM_VEN_CD.Text);
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


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME');
</script>
<!-- 매장(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getPumbunCode('NAME');
</script>
<!-- 기간(From)(조회) -->
<script language=JavaScript for=EM_FROM_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_FROM_DT,"S");
</script>
<!-- 기간(To)(조회) -->
<script language=JavaScript for=EM_TO_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_TO_DT,"S");
</script>
<!-- 출고/반품일자 -->
<script language=JavaScript for=EM_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getSkuCode('NAME');
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
<comment id="_NSID_"><object id="DS_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width=50 class="point">점</th>
            <td width="190">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=190 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="50" class="point">기간</th>
            <td width="210">
              <comment id="_NSID_">
                <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:getCalDt('POP', EM_FROM_DT,'S')" align="absmiddle" />&nbsp;~
              <comment id="_NSID_">
                <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:getCalDt('POP', EM_TO_DT,'S')" align="absmiddle" />
            </td>
            <th width="50">협력사</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=115  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >브랜드코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=110  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >단품코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_SKU_CD classid=<%=Util.CLSID_EMEDIT%>  width=95  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getSkuCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_SKU_NAME classid=<%=Util.CLSID_EMEDIT%>  width=350  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
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
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=480 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
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

</body>
</html>

