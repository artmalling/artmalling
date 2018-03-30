<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 기준정보> 경영실적 배부기준항목 관리
 * 작 성 일 : 2011.08.08
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영실적의 배부에서 사용되는 배부기준코드를 관리한다.
 * 이    력 :
 *        2011.08.08 (이정식) 신규작성
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
 * 작 성 일 : 2011-08-08
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    DS_DIV_CD.setDataHeader('<gauce:dataset name="H_SEL_DIV"/>');
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    EM_DIV_CD.focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0060","DS_DIV_CD" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-08-08
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_DIV_CD,    "CODE^4", NORMAL); //배부기준코드
    initEmEdit(EM_DIV_NM,    "GEN^30", NORMAL); //배부기준코드명
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies1 = '<C>id={currow}  width=35   align=center name="NO"</FC>'
                      + '<C>id=DIV_CD    width=120  align=center name="배부기준코드" edit="None" </C>'
                      + '<C>id=DIV_CD_NM width=300  align=left   name="배부기준코드명" </C>'
                      + '<C>id=SORT_NO   width=100  align=right  name="정렬순서" edit=Numeric </C>'
                      + '<C>id=USE_YN    width=70   align=center name="사용유무" EditStyle=checkbox HeadCheck=false HeadCheckShow=true</C>'
                      ;

    initGridStyle(GD_DIV_CD, "common", hdrProperies1, true);
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
 * 작 성 일 : 2011-08-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(DS_DIV_CD.IsUpdated){
        //변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            return false;
        }
    }
	
	DS_DIV_CD.ClearData();
    var goTo       = "search";
    var action     = "O";
    var parameters = "&strDivCd=" + EM_DIV_CD.text 
                   + "&strDivNm=" + encodeURIComponent(EM_DIV_NM.text)
                   ;
   
    DS_DIV_CD.DataID   = "/mss/meis006.me?goTo="+goTo+parameters;
    DS_DIV_CD.SyncLoad = "true";
    DS_DIV_CD.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if(!DS_DIV_CD.IsUpdated){
        //저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
	
	for( var i = 1 ; i <= DS_DIV_CD.CountRow; i++){
        var rowStatus = DS_DIV_CD.RowStatus(i);
        if(rowStatus == "1" || rowStatus == "3"){
            if (isNull(DS_DIV_CD.NameValue(i,"DIV_CD_NM").trim())){
                showMessage(EXCLAMATION, OK, "USER-1003", "배부기준코드명");
                setFocusGrid(GD_DIV_CD,DS_DIV_CD,i,"DIV_CD_NM");
                return;
            }
            if (getByteValLength(DS_DIV_CD.NameValue(i,"DIV_CD_NM")) > 30){
                showMessage(EXCLAMATION, OK, "USER-1054", "배부기준코드명", "30");
                setFocusGrid(GD_DIV_CD,DS_DIV_CD,i,"DIV_CD_NM");
                return;
            }
            if (DS_DIV_CD.NameValue(i,"SORT_NO") == "0"){
                showMessage(EXCLAMATION, OK, "USER-1003", "정렬순서");
                setFocusGrid(GD_DIV_CD,DS_DIV_CD,i,"SORT_NO");
                return;
            }
        }
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    
    TR_MAIN.Action   = "/mss/meis006.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DIV_CD=DS_DIV_CD)"; 
    TR_MAIN.Post();
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_addRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 :  조직별내역 행추가
 * return값 : void
 */
function btn_addRow(){
	DS_DIV_CD.AddRow();
	DS_DIV_CD.NameValue(DS_DIV_CD.RowPosition, "USE_YN") = "T";
}

/**
 * btn_delRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-08
 * 개    요 :  조직별내역 행삭제
 * return값 : void
 */
function btn_delRow(){
    if( DS_DIV_CD.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    DS_DIV_CD.DeleteRow(DS_DIV_CD.RowPosition);
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
<script language=JavaScript for=DS_DIV_CD event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_DIV_CD  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_DIV_CD event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_DIV_CD.CountRow; i++) DS_DIV_CD.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_DIV_CD.CountRow; i++) DS_DIV_CD.NameString(i, colid) = 'F';
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
    <!--[그리드]배부기준 -->
    <object id="DS_DIV_CD"      classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80">배부기준코드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=EM_DIV_CD classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">배부기준코드명</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_DIV_NM classid=<%=Util.CLSID_EMEDIT%> width=160 align="absmiddle"></object>
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
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ROW_ADD onclick="javascript:btn_addRow();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_ROW_DEL onclick="javascript:btn_delRow();""/></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                          <tr>
                            <td>
                              <comment id="_NSID_"><object id=GD_DIV_CD width="100%" height=477 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_DIV_CD">
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
