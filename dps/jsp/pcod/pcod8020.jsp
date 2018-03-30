<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> POS조회
 * 작 성 일 : 2010.05.01
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS 정보를 조회한다.
 * 이    력 :
 *        2010.05.01 (정진영) 신규작성
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
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운을 위한 조회조건 전역 선언
 var excelStr;
 var excelPosNo;
 var excelPosName;
 var excelShopName;
 var excelPosFlag;
 var excelMstPosNo;
 var excelMstPosNmae;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_POS_NO            , "CODE^4"         , NORMAL);    // POS번호
    initEmEdit(EM_POS_NAME          , "GEN^40"         , NORMAL);    // POS명
    initEmEdit(EM_SHOP_NAME         , "GEN^20"         , NORMAL);    // 매장명
    initEmEdit(EM_MST_POS_NO        , "CODE^4"         , NORMAL);    // 마스터POS 번호
    initEmEdit(EM_MST_POS_NAME      , "GEN^40"         , NORMAL);    // 마스터POS 명
    //콤보 초기화
    initComboStyle(LC_STR_CD        , DS_STR_CD        , "CODE^0^30,NAME^0^130", 1, PK);           // 점
    initComboStyle(LC_POS_FLAG      , DS_POS_FLAG      , "CODE^0^30,NAME^0^130", 1, NORMAL);       // POS구분

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_POS_FLAG"     , "D", "P082", "Y");
    
    // 점코드 조회
    getStore("DS_STR_CD", "N", "1", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
    	LC_STR_CD.Index= 0;
    }
    setComboData(LC_POS_FLAG,'%')
        
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            width=25  align=center  name="NO"       </FC>'
                     + '<FC>id=POS_NO              width=60  align=center  name="POS번호"  </FC>'
                     + '<FC>id=POS_NAME            width=150 align=left    name="POS명"    </FC>'
                     + '<FC>id=STR_NAME            width=80  align=left    name="점"       </FC>'
                     + '<FC>id=SHOP_NAME           width=150 align=left    name="매장명"    </FC>'
                     + '<FC>id=FLOR_NAME           width=80  align=left    name="층"       </FC>'
                     + '<FC>id=POS_FLAG_NAME       width=100  align=left    name="POS구분"       </FC>'
                     + '<FC>id=ITEM_REG_TYPE_NAME  width=140  align=left    name="상품등록;형태"       </FC>'
                     + '<FC>id=MIX_REG_YN          width=80  align=left    name="혼합등록;가능여부"       </FC>'
                     + '<FG>name="마스터"'
                     + '<FC>id=MST_POS_NO          width=60  align=center  name="POS번호"  </FC>'
                     + '<FC>id=MST_POS_NAME        width=150 align=left    name="POS명"    </FC>'
                     + '</FG>'
                     + '<FC>id=PHONE_NO            width=120 align=left    name="전화번호"       </FC>'
                     + '<FC>id=RSPNS_NAME          width=120 align=left    name="책임자;이름"       </FC>'
                     + '<FC>id=RSPNS_TEL_NO        width=120 align=left    name="책임자;전화번호"       </FC>'
                     + '<FG>name="F&&B매장"'
                     + '<FC>id=FNB_SHOP_CD         width=60  align=center  name="코드"  </FC>'
                     + '<FC>id=FNB_SHOP_NAME       width=150 align=left    name="명"    </FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_PLACE_NAME    width=80  align=left    name="행사장"       </FC>'
                     + '<FG>name="메시지ID"'
                     + '<FC>id=UPER_MSG_ID         width=70  align=center  name="상단"  </FC>'
                     + '<FC>id=MIDL_MSG_ID         width=70  align=center  name="중간"  </FC>'
                     + '<FC>id=LWER_MSG_ID         width=70  align=center  name="하단 "  </FC>'
                     + '<FC>id=CASH_RECP_MSG_ID    width=70  align=center  name="현금영수증"  </FC>'
                     + '</FG>'
                     + '<FC>id=VEN_CD              width=60  align=left    name="협력사"       </FC>'
                     + '<FC>id=VEN_NAME            width=120 align=left    name="협력사명"     </FC>'
                     + '<FC>id=USE_YN              width=80  align=left    name="사용여부"     </FC>';
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
    var strPosNo       = EM_POS_NO.Text;
    var strPosName     = EM_POS_NAME.Text;
    var strShopName    = EM_SHOP_NAME.Text;
    var strMstPosNo    = EM_MST_POS_NO.Text;
    var strMstPosName  = EM_MST_POS_NAME.Text;
    var strPosFlag     = LC_POS_FLAG.BindColVal;
    // 엑셀 다운을 위한 현재 조회 값 저장
    setSearchValue2Excel();
    var goTo           = "searchMaster" ;    
    var action         = "O";     
    var parameters     = "&strStrCd="+encodeURIComponent(strStrCd)
                       + "&strPosNo="+encodeURIComponent(strPosNo)
                       + "&strPosName="+encodeURIComponent(strPosName)
                       + "&strShopName="+encodeURIComponent(strShopName)
                       + "&strMstPosNo="+encodeURIComponent(strMstPosNo)
                       + "&strMstPosName="+encodeURIComponent(strMstPosName)
                       + "&strPosFlag="+encodeURIComponent(strPosFlag);
    TR_MAIN.Action="/dps/pcod802.pc?goTo="+goTo+parameters;  
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

    //openExcel2(GD_MASTER, "POS조회", getSearchValue2Excel(), true );
    openExcel5(GD_MASTER, "POS조회", getSearchValue2Excel(), true , "",g_strPid );

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
 * setPosNo()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : POS 번호를 조회한다.
 * return값 : void
 */
function setPosNo( evnFlag, svrFlag){

    var codeObj = svrFlag=='S'?EM_POS_NO:EM_MST_POS_NO;
    var nameObj = svrFlag=='S'?EM_POS_NAME:EM_MST_POS_NAME;
    var strObj = LC_STR_CD;
    
    if( strObj.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        strObj.Focus();
        return;
    }
    var strCd = strObj.BindColVal;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnFlag == "POP" ){
    	posNoPop(codeObj,nameObj, strCd);
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
    	setPosNoNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 0, strCd);
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
	excelPosNo       = EM_POS_NO.Text;
	excelPosName     = EM_POS_NAME.Text;
	excelShopName    = EM_SHOP_NAME.Text;
	excelPosFlag     = LC_POS_FLAG.Text;
	excelMstPosNo    = EM_MST_POS_NO.Text;
	excelMstPosNmae  = EM_MST_POS_NAME.Text;
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
                   + " -POS번호="+nvl(excelPosNo,'전체')    
                   + " -POS번호명="+nvl(excelPosName,'전체')     
                   + " -매장명="+nvl(excelShopName,'전체')    
                   + " -POS구분="+nvl(excelPosFlag,'전체')   
                   + " -마스터POS번호="+nvl(excelMstPosNo,'전체')   
                   + " -마스터POS번호명="+nvl(excelMstPosNmae,'전체');
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
<!-- POS번호(조회) -->
<script language=JavaScript for=EM_POS_NO event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosNo('NAME','S');
</script>

<!-- 마스터POS 번호(조회) -->
<script language=JavaScript for=EM_MST_POS_NO event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPosNo('NAME','M');
</script>

<!-- 점 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    //
    EM_POS_NO.Text = "";
    EM_POS_NAME.Text = "";
    EM_MST_POS_NO.Text = "";
    EM_MST_POS_NAME.Text = "";
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
<comment id="_NSID_"><object id="DS_STR_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POS_FLAG"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="70" class="point">점</th>
            <td width="180">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=180 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">POS번호</th>
            <td width="180">
              <comment id="_NSID_">
                <object id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPosNo('POP','S');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_POS_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">매장명</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SHOP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=170  tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >POS구분</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_POS_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=180 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >마스터POS</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_MST_POS_NO classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPosNo('POP','M');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_MST_POS_NAME classid=<%=Util.CLSID_EMEDIT%>  width=100  tabindex=1 align="absmiddle"></object>
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
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=479 classid=<%=Util.CLSID_GRID%>>
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

