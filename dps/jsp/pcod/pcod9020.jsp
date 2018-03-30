<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > F&B매장정보> F&B매장조회
 * 작 성 일 : 2010.05.23
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod9030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : F&B 매장정보를 조회한다.
 * 이    력 :
 *        2010.05.23 (정진영) 신규작성
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
<%
	String dir = BaseProperty.get("context.common.dir");
	// PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
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
var excelStr;
var excelVenCd;
var excelVenName;
var excelFnbShopCd;
var excelFnbShopName;
var excelChnalFlag;
var excelFnbFlag;
var excelFnbBizKind;
var excelUseYn;
var g_strPid           = "<%=pageName%>";                 // PID

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
    initEmEdit(EM_VEN_CD       , "CODE^6^0", NORMAL);  //협력사코드
    initEmEdit(EM_VEN_NAME     , "GEN^40"  , NORMAL);  //협력사명
    initEmEdit(EM_FNB_SHOP_CD  , "CODE^4^0", NORMAL);  //매장코드
    initEmEdit(EM_FNB_SHOP_NAME, "GEN^40"  , NORMAL);  //매장명
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD      ,DS_STR_CD      , "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    initComboStyle(LC_CHNAL_FLAG  ,DS_CHNAL_FLAG  , "CODE^0^30,NAME^0^150", 1, NORMAL);  //채널구분(조회)
    initComboStyle(LC_FNB_FLAG    ,DS_FNB_FLAG    , "CODE^0^30,NAME^0^150", 1, NORMAL);  //F&B구분(조회)
    initComboStyle(LC_FNB_BIZ_KIND,DS_FNB_BIZ_KIND, "CODE^0^30,NAME^0^150", 1, NORMAL);  //F&B업종(조회)
    initComboStyle(LC_USE_YN      ,DS_USE_YN      , "CODE^0^30,NAME^0^110", 1, NORMAL);  //사용여부(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FNB_SHOP_FLAG", "D", "P078", "Y");
    getEtcCode("DS_USE_YN"       , "D", "D022", "Y");    
    getEtcCode("DS_CHNAL_FLAG"   , "D", "P056", "Y");
    getEtcCode("DS_FNB_FLAG"     , "D", "P077", "Y");
    getEtcCode("DS_FNB_BIZ_KIND" , "D", "P079", "Y");
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_CHNAL_FLAG   , '%');
    setComboData(LC_FNB_FLAG     , '%');
    setComboData(LC_FNB_BIZ_KIND , '%');
    setComboData(LC_USE_YN       , 'Y');    

    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center name="NO"           </FC>'
                     + '<FC>id=STR_CD          width=80   align=left   name="점   "          EditStyle=Lookup data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=FNB_SHOP_CD     width=60   align=center name="매장코드"      </FC>'
                     + '<FC>id=FNB_SHOP_NAME   width=150  align=left   name="매장명 "        </FC>'
                     + '<FC>id=FNB_SHOP_FLAG   width=90   align=left   name="매장구분"      EditStyle=Lookup data="DS_FNB_SHOP_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=VEN_CD          width=80   align=center name="협력사코드 "    </FC>'
                     + '<FC>id=VEN_NAME        width=150  align=left   name="협력사명 "      </FC>'
                     + '<FC>id=CHNAL_FLAG      width=90   align=left   name="채널구분 "      EditStyle=Lookup data="DS_CHNAL_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=FNB_FLAG        width=90   align=left   name="F&&B구분 "      EditStyle=Lookup data="DS_FNB_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=FNB_BIZ_KIND_CD width=90   align=left   name="F&&B업종 "      EditStyle=Lookup data="DS_FNB_BIZ_KIND:CODE:NAME"</FC>'
                     + '<FC>id=REP_SHOP_CD     width=90   align=center name="대표매장코드 "  </FC>'
                     + '<FC>id=REP_SHOP_NAME   width=150  align=left   name="대표매장명 "    show=false</FC>'
                     + '<FC>id=USE_YN          width=70   align=left   name="사용여부 "      EditStyle=Combo  data="Y:YES,N:NO"</FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
    
    DS_MASTER.ClearData();

    var strStrCd       = LC_STR_CD.BindColVal;
    var strVenCd       = EM_VEN_CD.Text;
    var strVenName     = EM_VEN_NAME.Text;
    var strFnbShopCd   = EM_FNB_SHOP_CD.Text;
    var strFnbShopName = EM_FNB_SHOP_NAME.Text;
    var strChnalFlag   = LC_CHNAL_FLAG.BindColVal;
    var strFnbFlag     = LC_FNB_FLAG.BindColVal;
    var strFnbBizKind  = LC_FNB_BIZ_KIND.BindColVal;
    var strUseYn       = LC_USE_YN.BindColVal;
    
    // 엑셀 다운을 위한 조회조건 저장
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="		+encodeURIComponent(strStrCd)
                   + "&strVenCd="		+encodeURIComponent(strVenCd)
                   + "&strVenName="		+encodeURIComponent(strVenName)
                   + "&strFnbShopCd="	+encodeURIComponent(strFnbShopCd)
                   + "&strFnbShopName="	+encodeURIComponent(strFnbShopName)
                   + "&strChnalFlag="	+encodeURIComponent(strChnalFlag)
                   + "&strFnbFlag="		+encodeURIComponent(strFnbFlag)
                   + "&strFnbBizKind="	+encodeURIComponent(strFnbBizKind)
                   + "&strUseYn="		+encodeURIComponent(strUseYn);
    TR_MAIN.Action="/dps/pcod902.pc?goTo="+goTo+parameters;  
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

    //openExcel2(GD_MASTER, "F&B매장조회", getSearchValue2Excel(), true );
    openExcel5(GD_MASTER, "F&B매장조회", getSearchValue2Excel(), true , "",g_strPid );

    if(DS_MASTER.CountRow < 1)
        LC_STR_CD.Focus();
    else
        GD_MASTER.Focus();
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
 * getVenCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사명을 등록한다.
 * return값 : void
 */
function getVenCode(evnflag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
    	venPop(codeObj,nameObj,LC_STR_CD.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, LC_STR_CD.BindColVal);
    }    
}

/**
 * getFnbShopCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 매장명을 등록한다.
 * return값 : void
 */
function getFnbShopCode(evnflag){
    var codeObj = EM_FNB_SHOP_CD;
    var nameObj = EM_FNB_SHOP_NAME;
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
    	fnbShopPop(codeObj,nameObj,LC_STR_CD.BindColVal,EM_VEN_CD.Text);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setFnbShopNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, LC_STR_CD.BindColVal,EM_VEN_CD.Text);
    }    
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


<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME');
</script>
<!-- 매장(조회) -->
<script language=JavaScript for=EM_FNB_SHOP_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getFnbShopCode('NAME');
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_FNB_SHOP_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHNAL_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FNB_FLAG"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FNB_BIZ_KIND"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="80" class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">협력사</th>
            <td width="200">
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">매장</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getFnbShopCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_FNB_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >채널구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_CHNAL_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >F&B구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_FNB_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=180 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >F&B업종</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_FNB_BIZ_KIND classid=<%= Util.CLSID_LUXECOMBO %> width=180 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >사용여부</th>
            <td colspan="5">
               <comment id="_NSID_">
                 <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
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
                <object id=GD_MASTER width=100% height=455 classid=<%=Util.CLSID_GRID%>>
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

