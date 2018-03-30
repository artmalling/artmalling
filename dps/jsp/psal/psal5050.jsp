<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > 상품권매출현황
 * 작 성 일 : 2010.04.06
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : psal5050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권매출현황을 조회한다
 * 이    력 :
 *        2010.04.06 (이정식) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

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
 * 작 성 일 : 2010-04-06
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_VOU_SAL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    //화면로딩시 점콤보에 포커스
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2010-04-06
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_APP_S_DT, "SYYYYMMDD", PK);  // 조회 시작일
    initEmEdit(EM_APP_E_DT, "TODAY"    , PK);  // 조회 종료일
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
    initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^140", 1, PK);     //점(조회) 콤보
    initComboStyle(LC_VOU_TYPE, DS_VOU_TYPE, "CODE^0^30,NAME^0^100", 1, NORMAL); //상품권구분 콤보
    
    //점콤보 가져오기 ( gauce.js )
    //getStore("DS_STR_CD", "Y", "", "N");
    getStore2("DS_STR_CD", "Y",	"1", "Y", "1");													//점
    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';    // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0; 
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_VOU_TYPE", "D", "P601", "Y");  //상품권구분 콤보
    LC_VOU_TYPE.Index = 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : 매출현황그리드 초기화 
 * return값 : void
*/
function gridCreate(){
    var hdrProperies = '<C>id={currow}    width=35   align=center name="NO"       SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=SALE_DT     width=75   align=center name="매출일자"   SubSumText={decode(curlevel,1,"",2,"일자별소계")}  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} Mask="XXXX/XX/XX"</C>'
                     + '<C>id=SP_FLAG_NM  width=100  align=left   name="상품권구분" SubSumText={decode(curlevel,2,"",1,"상품권구분소계")} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=TYPE_CD     width=50   align=center name="종류코드"   SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=TYPE_NM     width=85   align=center   name="종류명"     SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=GIFT_AMT_NM width=80   align=right  name="금종"      SubSumText="" SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=CNT         width=40   align=right  name="건수"      sumtext=@sum SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=PAY_AMT     width=85   align=right  name="상품권금액" sumtext=@sum SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=CASH_CHANGE width=85   align=right  name="환불액"    sumtext=@sum SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=RE_AMT      width=85   align=right  name="대체금액"   sumtext=@sum SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     + '<C>id=PAY_AMT_R   width=85   align=right  name="상품권회수" sumtext=@sum SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</C>'
                     ;
                     
    initGridStyle(GD_VOU_SAL, "common", hdrProperies, false);
  //합계표시
    GD_VOU_SAL.ViewSummary = "1";
    GD_VOU_SAL.DecRealData = true;
    DS_VOU_SAL.SubSumExpr  = "2:SALE_DT, 1:SP_FLAG_NM" ; 
    GD_VOU_SAL.ColumnProp("SP_FLAG_NM", "sumtext")        = "합계";
    
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
 * 작 성 일 : 2010-04-06
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//1. validation
	if (isNull(LC_STR_CD.BindColVal)){
		showMessage(EXCLAMATION, OK, "USER-1002", "점"); //(점)은/는 반드시 선택해야 합니다.
		LC_STR_CD.Focus();
        return;
    }
	if (isNull(EM_APP_S_DT.text)){
		showMessage(EXCLAMATION, OK, "USER-1003", "기간"); //(기간)은/는 반드시 입력해야 합니다.
		EM_APP_S_DT.focus();
        return;
    }
	if (isNull(EM_APP_E_DT.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간"); //(기간)은/는 반드시 입력해야 합니다.
        EM_APP_E_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_APP_S_DT.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "기간");//(기간)은/는 유효하지 않는 날짜입니다.
        EM_APP_S_DT.focus();
        return;
    }
    if (!checkYYYYMMDD(EM_APP_E_DT.text)){
    	showMessage(EXCLAMATION, OK, "USER-1061", "기간");//(기간)은/는 유효하지 않는 날짜입니다.
        EM_APP_E_DT.focus();
        return;
    }
    if(EM_APP_S_DT.text > EM_APP_E_DT.text){
    	showMessage(EXCLAMATION, OK, "USER-1015"); //시작일은 종료일보다 작아야 합니다.
        EM_APP_S_DT.focus();
        return;
    }
    
    //2. 데이터셋 초기화
    DS_VOU_SAL.ClearData();
    
    //3. 조회시작
    var goTo       = "searchVouSalList";
    
    var action     = "O";
    var parameters = "&strStoreCd=" + encodeURIComponent(LC_STR_CD.BindColVal)    //점구분코드
                   + "&strStartDt=" + encodeURIComponent(EM_APP_S_DT.text)          //조회기간 시작일 
                   + "&strEndDt="   + encodeURIComponent(EM_APP_E_DT.text)          //조회기간 종료일
                   + "&strVouType=" + encodeURIComponent(LC_VOU_TYPE.BindColVal)  //상품권구분코드
                   ;
    
//     DS_VOU_SAL.DataID = "/dps/psal505.ps?goTo="+goTo+parameters;
//     DS_VOU_SAL.Reset();

    TR_MAIN.Action  = "/dps/psal505.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_VOU_SAL=DS_VOU_SAL)"; //조회는 O
    TR_MAIN.Post();
    
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
    if(GD_VOU_SAL.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }
      var strTitle = "상품권매출현황";
      
      var parameters = "점 "         + LC_STR_CD.text
			        + " ,   기간 " 	+ EM_APP_S_DT.text 
			        + " ~ " + EM_APP_E_DT.text
			        + "     상품권종류 "   + LC_VOU_TYPE.text;
      	    
      GD_VOU_SAL.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
//      openExcel2(GD_VOU_SAL, strTitle, parameters, true );
      openExcel5(GD_VOU_SAL, strTitle, parameters, true , "",g_strPid );

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-04-06
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
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
<script language=JavaScript for=DS_VOU_SAL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_VOU_SAL.focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_VOU_SAL  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_VOU_SAL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]상품건구분 -->
    <object id="DS_VOU_TYPE"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]상품권매출현황 -->
    <object id="DS_VOU_SAL"   classid=<%= Util.CLSID_DATASET %>></object>

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

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_VOU_SAL");
    
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
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">기간</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_APP_S_DT)" align="absmiddle" />
              ~ 
              <comment id="_NSID_">
                <object id=EM_APP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('G',EM_APP_E_DT)" align="absmiddle" />
            </td>
            <th width="80">상품권구분</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_VOU_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle"></object>
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
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_VOU_SAL width="100%" height=506 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_VOU_SAL">
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
