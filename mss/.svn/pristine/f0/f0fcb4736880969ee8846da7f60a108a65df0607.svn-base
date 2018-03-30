<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 경영마감실적조회
 * 작 성 일 : 2011.07.06
 * 작 성 자 : 최재형
 * 수 정 자 : 
 * 파 일 명 : meis0690.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실적항목별/조직별로 경영마감실적를 조회한다.
 * 이    력 :
 *        2011.07.06 (최재형) 신규작성
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
var lo_StrCd = "";
var lo_StrNm = "";
var lo_RsltYm = "";
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
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
    
    LC_STR_CD.Focus();
}

/**
 * setEmEdit()
 * 작 성 자 : 최재형
 * 작 성 일 :  2011-07-06
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_RSLT_YM, "YYYYMM", PK); //경영실적년월
	EM_RSLT_YM.Text = "<%=strYm%>";
}

/**
 * setCombo()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
    initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);   //점(조회)
     
    getStore("DS_STR_CD", "N", "", "N");         //점콤보 가져오기 ( gauce.js )  
    getEtcCode("DS_ORG_FLAG", "D", "P047", "N"); //조직구분콤보 데이터가져오기 ( gauce.js )
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    lo_StrCd = LC_STR_CD.BindColVal;
    lo_StrNm = LC_STR_CD.Text;
}

/**
 * gridCreate()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	 
	var hdrProperies = '<FC>id={currow}     width=25 align=center name="NO"</FC>';
	hdrProperies += '<FC>id=BIZ_CD       width=100 align=center name="항목코드"</FC>';
	hdrProperies += '<C>id=BIZ_CD_NM     width=200 align=left   name="항목명"</C>';
	hdrProperies += '<C>id=SUM_AMT       width=90 align=right  name="합계금액"</C>';
	hdrProperies += '<C>id=RSLT_AMT      width=90 align=right  name="실적금액"</C>';
	hdrProperies += '<C>id=ADJST_AMT      width=90 align=right  name="조정금액"</C>';
	hdrProperies += '<C>id=ADJST_RECV_AMT      width=90 align=right  name="조정받은금액"</C>';
	hdrProperies += '<C>id=DIV_RECV_AMT  width=90 align=right  name="배부받은금액"</C>';
	hdrProperies += '<C>id=DIV_AMT       width=90 align=right  name="배부한금액"</C>';            

	initGridStyle(GD_BIZ, "common", hdrProperies, false);
	//GD_BIZ.ViewSummary = "1";

	var hdrProperies1 = '<FC>id={currow}    width=25 align=center   name="NO"</FC>';
	hdrProperies1 += '<FC>id=ORG_FLAG    width=120 align=left   name="조직구분" EditStyle=Lookup data="DS_ORG_FLAG:CODE:NAME"</FC>';
	hdrProperies1 += '<FC>id=ORG_CD      width=80 align=center   name="조직코드" </FC>';
	hdrProperies1 += '<FC>id=ORG_NAME    width=100 align=left     name="조직명" SumText="합계"</FC>';
	hdrProperies1 += '<C>id=SUM_AMT      width=90 align=right    name="합계금액" SumText=@sum</C>';
	hdrProperies1 += '<C>id=RSLT_AMT     width=90 align=right    name="실적금액" SumText=@sum</C>';
	hdrProperies1 += '<C>id=ADJST_AMT      width=90 align=right  name="조정금액" SumText=@sum</C>';
	hdrProperies1 += '<C>id=ADJST_RECV_AMT      width=90 align=right  name="조정받은금액" SumText=@sum</C>';
	hdrProperies1 += '<C>id=DIV_RECV_AMT width=90 align=right    name="배부받은금액" SumText=@sum</C>';
	hdrProperies1 += '<C>id=DIV_AMT      width=90 align=right    name="배부한금액" SumText=@sum</C>';

	initGridStyle(GD_ORG, "common", hdrProperies1, false);
	GD_ORG.ViewSummary = "1";

    var hdrProperies3 = '<C>id={currow}     width=35  align=center name="NO"</C>';
    hdrProperies3 += '<C>id=STR_CD       width=50  align=center name="점코드" </C>';
    hdrProperies3 += '<C>id=STR_NAME     width=70  align=left   name="점명"  </C>';
    hdrProperies3 += '<C>id=BIZ_CD       width=70  align=center name="실적항목" </C>';
    hdrProperies3 += '<C>id=BIZ_CD_NM    width=95  align=left   name="항목명"  </C>';
    hdrProperies3 += '<C>id=ORG_CD       width=85  align=center name="조직코드" </C>';
    hdrProperies3 += '<C>id=ORG_NAME     width=95  align=left   name="조직명" </C>';
    hdrProperies3 += '<C>id=BIZ_RSLT_YM  width=60  align=center name="년월" mask="XXXX/XX"</C>';
    hdrProperies3 += '<C>id=SUM_AMT      width=80  align=right  name="합계금액" </C>';
    hdrProperies3 += '<C>id=RSLT_AMT     width=80  align=right  name="실적금액" </C>';
    hdrProperies3 += '<C>id=ADJST_AMT      width=100 align=right  name="조정금액"</C>';
    hdrProperies3 += '<C>id=ADJST_RECV_AMT      width=100 align=right  name="조정받은금액"</C>';
    hdrProperies3 += '<C>id=DIV_RECV_AMT width=80  align=right  name="배부받은금액" </C>';
    hdrProperies3 += '<C>id=DIV_AMT      width=80  align=right  name="배부한금액" </C>';

	initGridStyle(GD_EXCEL, "common", hdrProperies3, false);

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
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    DS_BIZ.ClearData();
    DS_ORG.ClearData();


    lo_IsMasterLoaded = 0;
    
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
    
    var goTo       = "searchBiz" ;    
    var action     = "O";     
    var parameters = "&strStrCd=" + LC_STR_CD.BindColVal //점코드
                   + "&strRsltYm=" + EM_RSLT_YM.text    //경영계획년도
                   ;
    lo_RsltYm = EM_RSLT_YM.Text;
    lo_StrCd = LC_STR_CD.BindColVal;
    lo_StrNm = LC_STR_CD.Text;
    DS_BIZ.DataID   = "/mss/meis069.me?goTo="+goTo+parameters;
    DS_BIZ.SyncLoad = "true";
    DS_BIZ.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
    DS_ORG.ClearData();

    var goTo       = "searchOrg";
    var action     = "O";
    var parameters = "&strStrCd=" + DS_BIZ.NameValue(row, "STR_CD")        //점코드
                   + "&strRsltYm=" + DS_BIZ.NameValue(row, "BIZ_RSLT_YM") //경영계획년도
                   + "&strBizCd=" + DS_BIZ.NameValue(row, "BIZ_CD")        //실적항목코드
                   ;
   
    DS_ORG.DataID  = "/mss/meis069.me?goTo="+goTo+parameters;
    DS_ORG.SyncLoad = "true";
    DS_ORG.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    if(DS_BIZ.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    
    DS_EXCEL.ClearData();
    var goTo       = "getExcelData";
    var action     = "O";
    var parameters = "&strStrCd=" + lo_StrCd //점코드
                   + "&strRsltYm=" + lo_RsltYm //경영계획년도
                   ;

    DS_EXCEL.DataID = "/mss/meis069.me?goTo="+goTo+parameters;
    DS_EXCEL.Reset();
}

/**
 * btn_Print()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 최재형
 * 작 성 일 : 2011-07-06
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
<script language=JavaScript for=DS_BIZ event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_BIZ.Focus();
</script>

<script language=JavaScript for=DS_ORG event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>

<script language=JavaScript for=DS_EXCEL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    //엑셀출력

    var parameters = "점코드="          + lo_StrNm
                   + " , 경영계획년도= " +lo_RsltYm;
    var ExcelTitle = "경영마감실적조회";

    openExcel2(GD_EXCEL, ExcelTitle, parameters, true );
    
    GD_BIZ.Focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_BIZ  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<script language=JavaScript for=DS_ORG  event=OnLoadError()>
    if (this.ErrorCode == 0 ) showMessage(STOPSIGN, OK, "GAUCE-1010");
    else showMessage(STOPSIGN, OK, "GAUCE-1000", this.ErrorMsg);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_BIZ event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         subQuery(row);
     }
</script>

<script language=JavaScript for=DS_ORG event=OnRowPosChanged(row)>
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_BIZ event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_ORG event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
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
    <object id="DS_BIZ"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]조직 -->
    <object id="DS_ORG"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드콤보]조직구분 -->
    <object id="DS_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
    <!--엑셀-->
    <object id="DS_EXCEL"    classid=<%= Util.CLSID_DATASET %>></object>
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
        <td class="PT01 PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                            <tr>
                                <th width="80" class="point">점코드</th>
                                <td width="160">
                                    <comment id="_NSID_">
                                    <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th width="80" class="point">경영실적년월</th>
                                <td>
              						<comment id="_NSID_">
                						<object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              						</comment><script> _ws_(_NSID_);</script>
              						<img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                						 onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr><td class="dot"></td></tr>
    <tr valign="top">
    	<td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                    <td>
                        <comment id="_NSID_">
                        <object id=GD_BIZ width="100%" height=250 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_BIZ">
                        </object></comment><script>_ws_(_NSID_);</script>                      
                    </td>
                </tr>
            </table>    	
    	</td>
    </tr>
    <tr>
    	<td class="PT10">
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            	<tr>
                	<td>
                    	<comment id="_NSID_">
                        <object id=GD_ORG width="100%" height=250 classid=<%=Util.CLSID_GRID%>>
                        	<param name="DataID" value="DS_ORG">
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
<comment id="_NSID_">
  <object id=GD_EXCEL width="0" height=0 classid=<%=Util.CLSID_GRID%>>
    <param name="DataID" value="DS_EXCEL">
  </object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
