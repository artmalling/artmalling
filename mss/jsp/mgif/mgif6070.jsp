<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 정산관리> 가맹점 정산
 * 작 성 일 : 2011.04.21
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : mgif6070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 가맹점에서 결재사용 회수된 자사 상품권에 대한 정산을 처리한다.
 * 이    력 :
 *        2011.04.21 (이정식) 신규작성
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
 * 작 성 일 : 2011-04-21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 530;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_CAL_DTL"); 
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
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("mgfi6070","DS_COL_DTL" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-04-21
 * 개    요 : EMEDIT 설정 
 * return값 : void
*/
function setEmEdit(){
    initEmEdit(EM_CAL_YM    , "THISMN", PK);     //정산년월
    initEmEdit(EM_JOINVEN_CD, "CODE^6", NORMAL); //가맹점코드(조회)
    initEmEdit(EM_JOINVEN_NM, "GEN^40", READ);   //가맹점명(조회)
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : 콤보 설정 
 * return값 : void
*/
function setCombo(){
    initComboStyle(LC_STR_CD  , DS_STR_CD  , "CODE^0^30,NAME^0^90", 1, PK);       //점(조회) 콤보
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "1", "N");
    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'; // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : 회수내역 및 정산내역 그리드 초기화 
 * return값 : void
*/
function gridCreate(){
    //회수내역 그리드
    var hdrProperies = '<C>id={currow}         width=30  align=center name="NO"</C>'
    	             + '<C>id=CHECK_FLAG       width=20  align=center name="선택" EditStyle=checkbox HeadCheck=false HeadCheckShow=true</C>'
                     + '<C>id=CAL_YM           width=70  align=center edit=none name="정산월" Mask="XXXX/XX"</C>'
                     + '<C>id=STR_NAME         width=80  align=left   edit=none name="점" SumText="합계"</C>'
                     + '<C>id=VEN_NAME         width=90 align=left   edit=none name="가맹점"</C>'
                     + '<C>id=OUT_PAY_AMT1          width=110  align=right  edit=none name="자사상품권;회수금액" SumText=@sum</C>'
                     + '<C>id=OUT_PAY_AMT2      width=110  align=right  edit=none name="제휴상품권;회수금액" SumText=@sum</C>'
                     + '<C>id=TOT_OUT_PAY_AMT    width=110  align=right  edit=none name="총회수;정산금액" SumText=@sum </C>'
                     + '<C>id=BRCH_REC_FEE_RATE    width=110  align=right  edit=none name="가맹점수취;수수료율"</C>'
                     + '<C>id=FEE_SUP_AMT          width=95  align=right  edit=none name="수수료공급가" SumText=@sum</C>'
                     + '<C>id=FEE_VAT_AMT          width=95  align=right  edit=none name="수수료부가세" SumText=@sum</C>'
                     + '<C>id=FEE_TOT_AMT          width=95  align=right  edit=none name="수수료합계" SumText=@sum</C>'
                     + '<C>id=CAL_AMT          width=95  align=right  edit=none name="정산금액" SumText=@sum</C>'
                     ;
                     
    initGridStyle(GD_COL_DTL, "common", hdrProperies, true);
    GD_COL_DTL.ViewSummary = "1";
    GD_COL_DTL.TitleHeight = 40;
    
    //정산내역 그리드
    var hdrProperies1 = '<C>id={currow}    width=35   align=center name="NO"</C>'
    	              + '<C>id=CAL_YM      width=85   align=center name="정산월" Mask="XXXX/XX"</C>'
                      + '<C>id=STR_NAME    width=95   align=left   name="점" SumText="합계"</C>'
                      + '<C>id=VEN_NAME    width=110  align=left   name="가맹점"</C>'
                      + '<C>id=BOND_AMT     width=115  align=right  name="자사상품권;회수금액" SumText=@sum</C>'
                      + '<C>id=BOND_AMT2 width=115  align=right  name="제휴상품권;회수금액" SumText=@sum</C>'
                      + '<C>id=REAL_PAY_AMT     width=115  align=right  name="정산금액" SumText=@sum</C>'
                      + '<C>id=FEE_RATE     width=115  align=right  name="수수료율" SumText=@sum</C>'
                      + '<C>id=FEE_SUP_AMT          width=95  align=right  edit=none name="수수료공급가" SumText=@sum</C>'
                      + '<C>id=FEE_VAT_AMT          width=95  align=right  edit=none name="수수료부가세" SumText=@sum</C>'
                      + '<C>id=FEE_TOT_AMT          width=95  align=right  edit=none name="수수료합계" SumText=@sum</C>'
                      + '<C>id=CAL_AMT          width=95  align=right  edit=none name="정산금액" SumText=@sum</C>'
                      ;
                     
    initGridStyle(GD_CAL_DTL, "common", hdrProperies1, false);
    GD_CAL_DTL.ViewSummary = "1";
    GD_CAL_DTL.TitleHeight = 40;
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
 * 작 성 일 : 2011-04-21
 * 개    요 : 조회시 호출(회수내역과 정산내역 조회)
 * return값 : void
 */
function btn_Search() {
    //1. validation
    if (isNull(LC_STR_CD.BindColVal)){
        showMessage(EXCLAMATION, OK, "USER-1002", "점"); //(점)은/는 반드시 선택해야 합니다.
        LC_STR_CD.Focus();
        return;
    }
    if (isNull(EM_CAL_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "정산년월"); //(정산년월)은/는 반드시 입력해야 합니다.
        EM_CAL_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_CAL_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "정산년월");//(정산년월)은/는 유효하지 않는 날짜입니다.
        EM_CAL_YM.focus();
        return;
    }
    
    if( DS_COL_DTL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(EXCLAMATION, YESNO, "USER-1059") != 1 ){           
        	DS_COL_DTL.Focus();
            return;
        }
    }
    
    //2. 데이터셋 초기화
    DS_COL_DTL.ClearData();
    DS_CAL_DTL.ClearData();
    
    //3. 조회시작
    //헤더체크초기화
    GD_COL_DTL.ColumnProp('CHECK_FLAG','HeadCheck') = false;
    var goTo       = "searchCalInfo";
    
    var action     = "O";
    var parameters = "&strStoreCd=" + encodeURIComponent(LC_STR_CD.BindColVal) //본사점구분코드
                   + "&strCalYM="   + encodeURIComponent(EM_CAL_YM.text)       //정산년월
                   + "&strVenCd="   + encodeURIComponent(EM_JOINVEN_CD.text)   //가맹점
                   ;
    
    TR_MAIN.Action   = "/mss/mgif607.mg?goTo="+goTo+parameters;
    TR_MAIN.KeyValue = "SERVLET("+action+":DS_COL_DTL=DS_COL_DTL," + action+":DS_CAL_DTL=DS_CAL_DTL,"+ action+":DS_CALDTL=DS_CALDTL)"; //조회는 O    
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_COL_DTL);    
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : 
 * return값 : void
*/
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	//저장할 데이터 없는 경우
    if (!DS_COL_DTL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
	
    //마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK',LC_STR_CD.BindColVal,EM_CAL_YM.Text,'MGIF','47','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) return;
    
    TR_MAIN.Action   = "/mss/mgif607.mg?goTo=save";
    TR_MAIN.KeyValue = "SERVLET(I:DS_COL_DTL=DS_COL_DTL,I:DS_CALDTL=DS_CALDTL)"; //조회는 O
    TR_MAIN.Post();
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-04-21
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * chkCalDtl()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-08-08
  * 개    요 : 상세내역 체크
  * return값 : void
  */
 function chkCalDtl(row) {
	  var strFlag = DS_COL_DTL.NameValue(row, "CHECK_FLAG");
	  var strVenCdRow = DS_COL_DTL.NameValue(row, "VEN_CD");	  
	for(var i=1;i<=DS_CALDTL.CountRow;i++){
		if(DS_CALDTL.NameValue(i,"VEN_CD") == strVenCdRow){
			DS_CALDTL.NameValue(i,"CHECK_FLAG") = strFlag;
		}
	}
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
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_COL_DTL  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_CAL_DTL  event=OnLoadError()>
    dsFailed(this);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    EM_JOINVEN_CD.Text = "";
    EM_JOINVEN_NM.Text = "";
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- Grid sorting event 처리 -->
<script language=JavaScript for=GD_COL_DTL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    
    // 정산내역 클릭시 상세내역에 내용 반영
    
    chkCalDtl(row);
</script>

<script language=JavaScript for=GD_CAL_DTL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 가맹점 정보 -->
<script language=JavaScript for=EM_JOINVEN_CD event=OnKillFocus()>
    if(!this.Modified) return;
        
    if(this.text==''){
        EM_JOINVEN_NM.Text = "";
        return;
    }
    
    getMssEvtVenNonPop("DS_I_COMMON", EM_JOINVEN_CD, EM_JOINVEN_NM, "E" , "Y", "2","", LC_STR_CD.BindColVal); 
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_COL_DTL event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_COL_DTL.CountRow; i++) DS_COL_DTL.NameString(i, colid) = 'T';
        for(var i=1; i<=DS_CALDTL.CountRow; i++) DS_CALDTL.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_COL_DTL.CountRow; i++) DS_COL_DTL.NameString(i, colid) = 'F';
        for(var i=1; i<=DS_CALDTL.CountRow; i++) DS_CALDTL.NameString(i, colid) = 'F';
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
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]회수내역 -->
    <object id="DS_COL_DTL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]정산내역 -->
    <object id="DS_CAL_DTL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--정산상세내역 -->
    <object id="DS_CALDTL"   classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--마감체크 -->
    <object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object>
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

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_CAL_DTL");
    
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
            <td width="120">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">정산년월</th>
            <td width="120">
              <comment id="_NSID_">
                <object id=EM_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this);" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_CAL_YM)" align="absmiddle" />
            </td>
            <th width="80">가맹점</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_JOINVEN_CD classid=<%= Util.CLSID_EMEDIT %> width=50 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" 
                onclick="javascript:getMssEvtVenPop( EM_JOINVEN_CD, EM_JOINVEN_NM,'S','2','',LC_STR_CD.BindColVal,'');"
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
  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>회수내역</td>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_COL_DTL width="100%" height=380 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_COL_DTL">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>정산내역</td>
  <tr>
    <td class="PT01 PB03" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_CAL_DTL width="100%" height=380 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_CAL_DTL">
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
