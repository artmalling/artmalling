<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 정산관리> 자사위탁판매 채권관리
 * 작 성 일 : 2011.04.20
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : mgif6060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자사위탁판매의 월별 채권내역을 조회
 * 이    력 :
 *        2011.04.20 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir          = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 /**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    //화면로딩시 본사점콤보에 포커스
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-04-20
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_CLOSE_YM  , "THISMN", PK);     //마감년월
    initEmEdit(EM_JOINVEN_CD, "CODE^6", NORMAL); //가맹점코드(조회)
    initEmEdit(EM_JOINVEN_NM, "GEN^40", READ);   //가맹점명(조회)
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
    initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^90", 1, PK);     //본사점(조회) 콤보
    
    //본사점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "N", "0", "N");
    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';    // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0; 
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 위탁판매채권 그리드 초기화 
 * return값 : void
*/
function gridCreate(){
    var hdrProperies = '<C>id={currow}    width=35  align=center name="NO"</C>'
                     + '<C>id=CAL_YM      width=60  align=center name="마감년월" Mask="XXXX/XX"</C>'
                     + '<C>id=STR_NM    width=80  align=left   name="본사점"</C>'
                     + '<C>id=VEN_NM    width=105 align=left   name="위탁협력사" SumText="합계"</C>'
                     + '<C>id=BASIC_BOND_AMT    width=100 align=right  name="기초미수채권" SumText=@sum</C>'
                     + '<C>id=BOND_AMT    width=100 align=right  name="당월판매" SumText=@sum</C>'
                     + '<C>id=PAY_AMT     width=100 align=right  name="당월입금" SumText=@sum</C>'
                     + '<C>id=FEE_PAY_AMT     width=100 align=right  name="당월수수료입금" SumText=@sum</C>'
                     + '<C>id=TOT_PAY_AMT width=100 align=right  name="당월입금합계" SumText=@sum</C>'
                     + '<C>id=CUR_BOND_AMT    width=100 align=right  name="당월미수채권" SumText=@sum</C>'
                     + '<C>id=FINAL_BOND_AMT   width=100 align=right  name="기말미수채권" SumText=@sum</C>'
                     ;
                     
    initGridStyle(GD_CON_BOND, "common", hdrProperies, false);
    GD_CON_BOND.ViewSummary = "1";
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//1. validation
	if (isNull(LC_STR_CD.BindColVal)){
		showMessage(EXCLAMATION, OK, "USER-1002", "본사점"); //(본사점)은/는 반드시 선택해야 합니다.
		LC_STR_CD.Focus();
        return;
    }
	if (isNull(EM_CLOSE_YM.text)){
		showMessage(EXCLAMATION, OK, "USER-1003", "마감년월"); //(마감년월)은/는 반드시 입력해야 합니다.
		EM_CLOSE_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_CLOSE_YM.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "마감년월");//(마감년월)은/는 유효하지 않는 날짜입니다.
        EM_CLOSE_YM.focus();
        return;
    }
    //2. 데이터셋 초기화
    DS_CON_BOND.ClearData();
    
    //3. 조회시작
    var goTo       = "searchConBondList";
    
    var action     = "O";
    var parameters = "&strStoreCd=" + LC_STR_CD.BindColVal //본사점구분코드
                   + "&strCloseYM=" + EM_CLOSE_YM.text     //마감년월
                   + "&strVenCd="   + EM_JOINVEN_CD.text   //위탁협력사코드
                   ;
    DS_CON_BOND.DataID = "/mss/mgif606.mg?goTo="+goTo+parameters;
    DS_CON_BOND.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-20
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getVenCd()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-06
  * 개    요 : 가맹점 팝업 오픈시 점코드 필수
  * return값 : void
  */
 function getVenCd(){
       var strStrCd = eval(LC_STR_CD);
       var strVenCd = eval(EM_JOINVEN_CD);
       var strVenNm = eval(EM_JOINVEN_NM);
  
      if(strStrCd.BindColVal == ""){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            strStrCd.Focus();
            return;
        }
     getMssEvtVenPop( strVenCd, strVenNm, 'S', '3', '', strStrCd.BindColVal, '')
 }
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_CON_BOND event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_CON_BOND.focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_CON_BOND  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_CON_BOND event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 위탁협력사 정보 -->
<script language=JavaScript for=EM_JOINVEN_CD event=OnKillFocus()>
    if(!this.Modified) return;
        
    if(this.text==''){
        EM_JOINVEN_NM.Text = "";
        return;
    }
    if(this.Text.length > 0){
           if(LC_STR_CD.BindColVal == "%"){
               showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
               LC_STR_CD.Focus();
               return;
           }
           getMssEvtVenNonPop( "DS_O_RESULT", EM_JOINVEN_CD, EM_JOINVEN_NM, "E", "Y", "3", '', LC_STR_CD.BindColVal, '');
       }
</script>
 
<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    EM_JOINVEN_CD.Text = "";
    EM_JOINVEN_NM.Text = "";
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]본사점구분 -->
    <object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]위탁판매채권-->
    <object id="DS_CON_BOND"   classid=<%= Util.CLSID_DATASET %>></object>

<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
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
            <th width="80" class="point">본사점</th>
            <td width="120">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">마감년월</th>
            <td width="120">
              <comment id="_NSID_">
                <object id=EM_CLOSE_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this);" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_CLOSE_YM)" align="absmiddle" />
            </td>
            <th width="80">위탁협력사</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_JOINVEN_CD classid=<%= Util.CLSID_EMEDIT %> width=50 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" 
                onclick="javascript:getVenCd();"
                align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_JOINVEN_NM classid=<%= Util.CLSID_EMEDIT %> width=185 align="absmiddle"></object>
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
    <td valign="top" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_CON_BOND width="100%" height=506 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_CON_BOND">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
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

