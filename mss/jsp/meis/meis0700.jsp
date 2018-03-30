<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 경영실적생성
 * 작 성 일 : 2011.06.20
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0700.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전 점 경영실적을 생성한다.
 * 이    력 :
 *        2011.06.20 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strYm      = Date2.addMonth(-1);
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
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
 * 작 성 일 : 2011-06-20
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
    
    EM_RSLT_YM.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0700","DS_BIZ_RSLT" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-20
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
    initEmEdit(EM_RSLT_YM, "YYYYMM", PK); //경영실적년월
    EM_RSLT_YM.Text = "<%=strYm%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow}     width=40  align=center name="NO"</C>'
		             + '<C>id=CHECK_FLAG   width=20  align=center name="" EditStyle=checkbox HeadCheck=false HeadCheckShow=true edit={IF(EDIT_FLAG="1","true","false")}</C>'
                     + '<C>id=STR_NM       width=95  align=left   name="점명" edit="None"</C>'
                     + '<C>id=CREATE_FLAG  width=110 align=center name="보고서생성여부" edit="None"</C>'
                     + '<C>id=CONF_FLAG    width=110 align=center name="보고서확정여부" edit="None"</C>'
                     ;
        
    initGridStyle(GD_BIZ_RSLT, "common", hdrProperies, true);
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
 * 작 성 일 : 2011-06-20
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_BIZ_RSLT.IsUpdated){
        //변경내역이 있습니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1){
        	EM_RSLT_YM.Focus();
            return false;
        }
    }
    
    //1. validation
    if (isNull(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영실적년월"); //(경영실적년월)은/는 반드시 입력해야 합니다.
        EM_RSLT_YM.focus();
        return;
    }
    
    if (!checkYYYYMM(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "경영실적년월");//(경영실적년월)은/는 유효하지 않는 날짜입니다.
        EM_RSLT_YM.focus();
        return;
    }
	
	DS_BIZ_RSLT.ClearData();
	
	//헤더체크초기화
    GD_BIZ_RSLT.ColumnProp('CHECK_FLAG','HeadCheck') = false;
	
	var goTo       = "searchBizRslt" ;    
    var action     = "O";     
    var parameters = "&strRsltYm="  + EM_RSLT_YM.text //경영실적년월
                   ;
    
    DS_BIZ_RSLT.DataID   = "/mss/meis070.me?goTo="+goTo+parameters;
    DS_BIZ_RSLT.SyncLoad = "true";
    DS_BIZ_RSLT.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-20
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
	if (!DS_BIZ_RSLT.IsUpdated){
        //확정할 데이터를 선택하세요
        showMessage(INFORMATION, OK, "USER-1000", "생성할 데이터를 선택하세요");
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1000", "보고서를 생성(삭제)하시겠습니까?") != 1 ){
        return;
    }

    TR_MAIN.Action   = "/mss/meis070.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_BIZ_RSLT=DS_BIZ_RSLT)"; 
    TR_MAIN.Post();
    
    btn_Search();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
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
<script language=JavaScript for=DS_BIZ_RSLT event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_BIZ_RSLT.Focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_BIZ_RSLT  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_BIZ_RSLT event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_BIZ_RSLT event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_BIZ_RSLT.CountRow; i++) 
        	if(DS_BIZ_RSLT.NameString(i, "EDIT_FLAG") == "1") //변경전 적용 시작일이 크지 않은 경우만 수정 가능
        		DS_BIZ_RSLT.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_BIZ_RSLT.CountRow; i++) DS_BIZ_RSLT.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
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
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]계정항목 -->
    <object id="DS_BIZ_RSLT"      classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
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
            <th width="80">경영실적년월</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_BIZ_RSLT width="100%" height="502" classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_BIZ_RSLT">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
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
