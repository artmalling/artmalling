<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면매출현황(전층)
 * 작 성 일 : 2010.06.29
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4310.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.29 (정진영) 신규작성
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
// 엑셀 다운로드를 위한 전역 변수

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
    initEmEdit(EM_FROM_DT    , "TODAY" , PK);  //기간 FROM
    initEmEdit(EM_TO_DT      , "TODAY" , PK);  //기간 TO
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD      ,DS_STR_CD      , "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    initComboStyle(LC_FLOOR_CD    ,DS_FLOOR_CD    , "CODE^0^30,NAME^0^110", 1, NORMAL);  //층(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FLOOR_CD", "D", "P061", "Y");
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_FLOOR_CD   , '%');

    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center sumtext=""   name="NO"           </FC>'
                     + '<FC>id=SALE_DT         width=80   align=center sumtext=""   name="매출일자"      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=FLOOR_CD        width=80   align=left   sumtext=""   name="층 "           EditStyle=Lookup data="DS_FLOOR_CD:CODE:NAME"</FC>'
                     + '<FC>id=FLOOR_NAME      width=100  align=left   sumtext=""   name="층명"          show=false </FC>'
                     + '<C>id=TOTAL_SALE_AMT   width=200  align=right  sumtext=@sum name="총매출 "       </C>'
                     + '<C>id=COMP_RATE        width=120  align=right  sumtext=@sum name="구성비 "       </C>'
                     + '<C>id=CUST_CNT         width=120  align=right  sumtext=@sum name="객수 "         </C>'
                     + '<C>id=CUST_SALE_AMT    width=150  align=right  sumtext=@sum name="객단가 "       </C>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    GD_MASTER.ViewSummary = "1";  
    GD_MASTER.ColumnProp("FLOOR_CD", "sumtext")        = "합계";
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
    
    DS_MASTER.ClearData();

    var strStrCd    = LC_STR_CD.BindColVal;
    var strFromDt   = EM_FROM_DT.Text;
    var strToDt     = EM_TO_DT.Text;
    var strFloorCd  = LC_FLOOR_CD.BindColVal;
    
    // 엑셀 다운을 위한 조회조건 저장
    //setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strFromDt="+encodeURIComponent(strFromDt)
                   + "&strToDt="+encodeURIComponent(strToDt)
                   + "&strFloorCd="encodeURIComponent(strFloorCd);
    TR_MAIN.Action="/dps/psal431.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);
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
 * setCalData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  달력 팝업 실행
 * return값 : void
 */
function setCalData( evnFlag, obj){
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    if(obj.Text == "")
        return;
    
    if(!checkDateTypeYMD( obj ))
        return;
}

/**
 * setSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
 * return값 : void
 */
function setSearchValue2Excel(){

    excelStr         = LC_STR_CD.Text;
    excelVenCd       = EM_VEN_CD.Text;
    excelVenName     = EM_VEN_NAME.Text;
    excelFnbShopCd   = EM_FNB_SHOP_CD.Text;
    excelFnbShopName = EM_FNB_SHOP_NAME.Text;
    excelChnalFlag   = LC_CHNAL_FLAG.Text;
    excelFnbFlag     = LC_FNB_FLAG.Text;
    excelFnbBizKind  = LC_FNB_BIZ_KIND.Text;
    excelUseYn       = LC_USE_YN.Text;
}
/**
 * getSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회조건 입력 값 조회
 * return값 : void
 */
function getSearchValue2Excel(){
    //
    var parameters = "점="+nvl(excelStr,'전체')                    
                   + " -협력사코드="+nvl(excelVenCd,'전체')    
                   + " -협력사명="+nvl(excelVenName,'전체')     
                   + " -매장코드="+nvl(excelFnbShopCd,'전체')    
                   + " -매장명="+nvl(excelFnbShopName,'전체')   
                   + " -채널구분="+nvl(excelChnalFlag,'전체')   
                   + " -F&B구분="+nvl(excelFnbFlag,'전체')  
                   + " -F&B업종="+nvl(excelFnbBizKind,'전체')  
                   + " -사용여부="+nvl(excelUseYn,'전체');
    return parameters;
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>


<!-- 기간(from)(조회) -->
<script language=JavaScript for=EM_FROM_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME', EM_FROM_DT);
</script>
<!-- 기간(to)(조회) -->
<script language=JavaScript for=EM_TO_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME', EM_TO_DT);
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
<comment id="_NSID_"><object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FLOOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="60" class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">기간</th>
            <td width="230">
              <comment id="_NSID_">
                <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif" id=IMG_NOTI_S_DT onclick="javascript:setCalData('POP', EM_FROM_DT);"  align="absmiddle" />&nbsp;&nbsp;~&nbsp;
              <comment id="_NSID_">
                <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif" id=IMG_NOTI_E_DT onclick="javascript:setCalData('POP', EM_TO_DT);"  align="absmiddle" />
            </td>
            <th width="60" >층</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_FLOOR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=508 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment><script>_ws_(_NSID_);</script>
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

