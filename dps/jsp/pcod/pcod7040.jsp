<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 행사조회
 * 작 성 일 : 2010.05.03
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod7040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사정보를 조회한다
 * 이    력 :
 *        2010.05.03 (정진영) 신규작성
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
	//PID 확인을 위한
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
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운을 위한 조회조건 전역 선언
var excelEventDtFrom;
var excelEventDtTo;
var excelStr;
var excelEventCd;
var excelEventName;
var excelEventType;
var excelEventMngFlag;
var excelEvnetLCd;
var excelEvnetMCd;
var excelEvnetSCd;
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
    initEmEdit(EM_EVENT_DT_FROM, "YYYYMMDD" , PK);      //행사기간
    initEmEdit(EM_EVENT_DT_TO  , "YYYYMMDD" , PK);      //행사기간
    initEmEdit(EM_EVENT_CD     , "CODE^11"  , NORMAL);  //행사코드
    initEmEdit(EM_EVENT_NAME   , "GEN^40"   , NORMAL);  //행사명

    //콤보 초기화
    initComboStyle(LC_STR_CD        , DS_STR_CD        , "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)
    initComboStyle(LC_EVENT_TYPE    , DS_EVENT_TYPE    , "CODE^0^30,NAME^0^160", 1, NORMAL);  //행사종류(조회)
    initComboStyle(LC_EVENT_MNG_FLAG, DS_EVENT_MNG_FLAG, "CODE^0^30,NAME^0^110", 1, NORMAL);  //행사주관구분(조회)
    initComboStyle(LC_EVENT_L_CD    , DS_EVENT_L_CD    , "CODE^0^30,NAME^0^160", 1, NORMAL);  //행사테마(대)(조회)
    initComboStyle(LC_EVENT_M_CD    , DS_EVENT_M_CD    , "CODE^0^30,NAME^0^110", 1, NORMAL);  //행사테마(중)(조회)
    initComboStyle(LC_EVENT_S_CD    , DS_EVENT_S_CD    , "CODE^0^30,NAME^0^150", 1, NORMAL);  //행사테마(소)(조회)
    
  //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_EVENT_TYPE"    , "D", "P072", "Y");
    getEtcCode("DS_EVENT_MNG_FLAG", "D", "P073", "Y");

    //행사테마 대분류 가지고 오기( popup_dps.js )
    getEvtThmeLCode("DS_EVENT_L_CD", "Y");

    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "Y");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_EVENT_TYPE    ,"%");
    setComboData(LC_EVENT_MNG_FLAG,"%");
    setComboData(LC_EVENT_L_CD    ,"%");
    setComboData(LC_STR_CD        ,"%");
    LC_STR_CD.Index=0;

    
    // 행사년월 기본값
    var toDay = getTodayFormat("YYYYMMDD");
    EM_EVENT_DT_FROM.Text = getTodayFormat("YYYYMM")+'01';
    EM_EVENT_DT_TO.Text   = toDay;

    EM_EVENT_DT_FROM.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             width=30   align=center  name="NO"          </FC>'
                     + '<FC>id=EVENT_CD             width=110  align=center  name="행사코드"     </FC>'
                     + '<FC>id=EVENT_NAME           width=160  align=left    name="행사명"       </FC>'
                     + '<FC>id=STR_NAME             width=90   align=left    name="점"           </FC>'
                     + '<FG>name="행사테마"'
                     + '<FC>id=EVENT_THME_CD        width=55   align=center  name="코드"        </FC>'
                     + '<FC>id=EVENT_THME_NAME      width=120  align=left    name="명"          < /FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_S_DT           width=85   align=center  name="행사시작일"   mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=EVENT_E_DT           width=85   align=center  name="행사종료일"   mask="XXXX/XX/XX" </FC>'                     
                     + '<FC>id=EVENT_TYPE_NAME      width=90   align=left    name="행사종류"     </FC>'
                     + '<FC>id=EVENT_PLU_FLAG_NAME  width=110   align=left    name="행사유형"     </FC>'
                     + '<FC>id=EVENT_MNG_FLAG_NAME  width=90   align=left    name="행사주관;구분" </FC>'
                     + '<FC>id=EVENT_ORG_NAME       width=150  align=left    name="주관조직"     </FC>'
                     + '<FC>id=EVENT_CHAR_NAME      width=100  align=left    name="담당자"       </FC>';
 
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
    if( EM_EVENT_DT_FROM.Text == '') {
        showMessage(INFORMATION, OK, "USER-1003", "행사기간(From)");
        EM_EVENT_DT_FROM.Focus();
        return;
    }
    if( EM_EVENT_DT_TO.Text == '') {
        showMessage(INFORMATION, OK, "USER-1003", "행사기간(To)");
        EM_EVENT_DT_TO.Focus();
        return;
    }
    if( EM_EVENT_DT_FROM.Text > EM_EVENT_DT_TO.Text){
        showMessage(INFORMATION, OK, "USER-1020", "행사기간(TO)","행사기간(FORM)");
        EM_EVENT_DT_TO.Focus();
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

    //openExcel2(GD_MASTER, "행사조회", getSearchValue2Excel(), true );
    openExcel5(GD_MASTER, "행사조회", getSearchValue2Excel(), true , "",g_strPid );

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
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
function searchMaster(){
    
    DS_MASTER.ClearData();   
    
    var strEventDtFrom  = EM_EVENT_DT_FROM.Text;
    var strEventDtTo    = EM_EVENT_DT_TO.Text;
    var strStrCd        = LC_STR_CD.BindColVal;
    var strEventCd      = EM_EVENT_CD.Text;
    var strEventName    = EM_EVENT_NAME.Text;
    var strEventType    = LC_EVENT_TYPE.BindColVal;
    var strEventMngFlag = LC_EVENT_MNG_FLAG.BindColVal;
    var strEventLCd     = LC_EVENT_L_CD.BindColVal;
    var strEventMCd     = LC_EVENT_M_CD.BindColVal;
    var strEventSCd     = LC_EVENT_S_CD.BindColVal;
    
    setSearchValue2Excel();
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strEventDtFrom="	+encodeURIComponent(strEventDtFrom)
                   + "&strEventDtTo="	+encodeURIComponent(strEventDtTo)
                   + "&strStrCd="		+encodeURIComponent(strStrCd)
                   + "&strEventCd="		+encodeURIComponent(strEventCd)
                   + "&strEventName="	+encodeURIComponent(strEventName)
                   + "&strEventType="	+encodeURIComponent(strEventType)
                   + "&strEventMngFlag="+encodeURIComponent(strEventMngFlag)
                   + "&strEventLCd="	+encodeURIComponent(strEventLCd)
                   + "&strEventMCd="	+encodeURIComponent(strEventMCd)
                   + "&strEventSCd="	+encodeURIComponent(strEventSCd);    
    TR_MAIN.Action="/dps/pcod704.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    

    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  
} 

/**
 * setCalEventDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function setCalEventDt(evnFlag, obj){
	 
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    ;
    var dfDt = obj.id=="EM_EVENT_DT_FROM"?getTodayFormat("YYYYMM")+'01':getTodayFormat("YYYYMMDD");
        
    if(!checkDateTypeYMD( obj , dfDt))
        return;
} 
//

/**
 * setEventCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 행사코드를 조회한다.
 * return값 : void
 */
function setEventCode( evnFlag){

    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;
    var strObj = LC_STR_CD;
    
    var strCd = strObj.BindColVal;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( evnFlag == "POP" ){
        eventPop(codeObj,nameObj, strCd);
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
        setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 0, strCd);
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
    excelEventDtFrom  = EM_EVENT_DT_FROM.Text;
    excelEventDtTo    = EM_EVENT_DT_TO.Text;
    excelStr          = LC_STR_CD.Text;
    excelEventCd      = EM_EVENT_CD.Text;
    excelEventName    = EM_EVENT_NAME.Text;
    excelEventType    = LC_EVENT_TYPE.Text;
    excelEventMngFlag = LC_EVENT_MNG_FLAG.Text;
    excelEvnetLCd     = LC_EVENT_L_CD.Text;
    excelEvnetMCd     = LC_EVENT_M_CD.Text;
    excelEvnetSCd     = LC_EVENT_S_CD.Text;
}
/**
 * getSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회조건 입력 값 조회
 * return값 : void
 */
function getSearchValue2Excel(){
    var parameters = "행사기간="+nvl(excelEventDtFrom,'전체')+"~"+nvl(excelEventDtTo,'전체')
                   + " -점="+nvl(excelStr,'전체')                    
                   + " -행사코드="+nvl(excelEventCd,'전체')    
                   + " -행사코드명="+nvl(excelEventName,'전체')     
                   + " -행사종류="+nvl(excelEventType,'전체')    
                   + " -행사주관구분="+nvl(excelEventMngFlag,'전체')   
                   + " -행사테마(대)="+nvl(excelEvnetLCd,'전체')   
                   + " -행사테마(중)="+nvl(excelEvnetMCd,'전체') 
                   + " -행사테마(소)="+nvl(excelEvnetSCd,'전체');
    return parameters;
}
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
<!-- 행사기간(from)(조회) -->
<script language=JavaScript for=EM_EVENT_DT_FROM event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalEventDt('NAME',EM_EVENT_DT_FROM);
</script>
<!-- 행사기간(from)(조회) -->
<script language=JavaScript for=EM_EVENT_DT_TO event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalEventDt('NAME',EM_EVENT_DT_TO);
</script>
<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME');
</script>
<!-- 행사테마(대)(조회) -->
<script language=JavaScript for=LC_EVENT_L_CD event=OnSelChange()>
    DS_EVENT_M_CD.ClearData();
    DS_EVENT_S_CD.ClearData();
    getEvtThmeMCode("DS_EVENT_M_CD", this.BindColVal, "Y");
    setComboData(LC_EVENT_M_CD,'%');
</script>
<!-- 행사테마(중)(조회) -->
<script language=JavaScript for=LC_EVENT_M_CD event=OnSelChange()>
    DS_EVENT_S_CD.ClearData();
    getEvtThmeSCode("DS_EVENT_S_CD", LC_EVENT_L_CD.BindColVal, this.BindColVal, "Y");
    setComboData(LC_EVENT_S_CD,'%');
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
<comment id="_NSID_"><object id="DS_EVENT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_L_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_M_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_S_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="70" class="point">행사기간</th>
            <td width="200">
              <comment id="_NSID_">
                <object id=EM_EVENT_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:setCalEventDt('POP',EM_EVENT_DT_FROM);" align="absmiddle" />&nbsp;~
              <comment id="_NSID_">
                <object id=EM_EVENT_DT_TO classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:setCalEventDt('POP',EM_EVENT_DT_TO);" align="absmiddle" />
            </td>      
            <th width="70">점</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>                 
            <th width="70" >행사코드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=85 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script>
            </td>      
          </tr>
          <tr>
            <th >행사종류</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_EVENT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=199 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >행사주관구분</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=LC_EVENT_MNG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >행사테마(대)</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_EVENT_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width=199 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >행사테마(중)</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_EVENT_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >행사테마(소)</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_EVENT_S_CD classid=<%= Util.CLSID_LUXECOMBO %> width=192 tabindex=1 align="absmiddle"></object>
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
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
        <tr>
          <td>
            <comment id="_NSID_"><object id=GD_MASTER width="100%" height=453 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_MASTER">
            </object></comment><script>_ws_(_NSID_);</script>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table> 
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

