<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권 관리 > 상품권 판매/회수 > 자사상품권 회수 비교표 팝업 화면
 * 작 성 일 : 2011.03.18
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif3111.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 신규상담처리(단변)
 * 이    력 : 2011.03.18 (신익수) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	String sess_org_cd_t = sessionInfo.getORG_CD();
	
	int tmplen = (10 - (sess_org_cd_t.length()));
	String sess_org_cd = sess_org_cd_t;
	for (int i=0; i<tmplen; i++) {
	    sess_org_cd += "0";
	}

	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"	    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strDrawStr  = dialogArguments[1];
var strDrawlDt  = dialogArguments[2];

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	// Input Data Set Header 초기화
    DS_O_MASTER_POP.setDataHeader('<gauce:dataset name="H_POPUP"/>');
	
    getGiftCd("getGiftAmt", "DS_O_GIFTAMT"); //금종조회
    getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
    
    //그리드 초기화
    gridCreate();
    btn_Search();
}

function gridCreate(gdGnb){
    var hdrProperies = ''
						+ '<FC>ID={CURROW}            NAME="NO"' 
						+ '                                             WIDTH=35        ALIGN=CENTER</FC>'
						+ '<FC>ID=GIFT_TYPE_NAME        NAME="상품권종류"'         
						+ '                                             WIDTH=135       ALIGN=LEFT    SUMTEXT="합계"</FC>'
						+ '<FC>ID=GIFT_AMT_NAME       NAME="금종명"'         
						+ '                                             WIDTH=135       ALIGN=LEFT   SUBSUMTEXT=" 소계"</FC>'
						+ '<G>                        NAME="정상회수"'
						+ '<FC>ID=QTY_1               NAME="매수"'           
						+ '                                             WIDTH=60        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_1               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="교환회수"'
						+ '<FC>ID=QTY_3               NAME="매수"'           
						+ '                                             WIDTH=60       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_3               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="반품회수"'
						+ '<FC>ID=QTY_4               NAME="매수"'           
						+ '                                             WIDTH=60       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_4               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="가맹회수"'
						+ '<FC>ID=QTY_5               NAME="매수"'           
						+ '                                             WIDTH=60       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_5               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="강제회수"'
                        + '<FC>ID=QTY_2               NAME="매수"'           
                        + '                                             WIDTH=60        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=AMT_2               NAME="금액"'           
                        + '                                             WIDTH=100      ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="포인트반품회수"'
						+ '<FC>ID=QTY_6               NAME="매수"'           
						+ '                                             WIDTH=60       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_6               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="사은품반품회수"'
						+ '<FC>ID=QTY_7               NAME="매수"'           
						+ '                                             WIDTH=60    show=false    ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_7               NAME="금액"'           
						+ '                                           WIDTH=100     show=false   ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="회수 계"'
						+ '<FC>ID=QTY_A               NAME="매수"'           
						+ '                                             WIDTH=60       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_A               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
	initGridStyle(GD_MASTER_POP, "COMMON", hdrProperies, false);
	DS_O_MASTER_POP.SubSumExpr  = "1:GIFT_TYPE_CD" ;
	GD_MASTER_POP.TitleHeight  = "20";
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
    var goTo = "getGiftDrawlPop";
    var parameters = ""
        + "&strDrawStr="    + encodeURIComponent(strDrawStr)  // 점
        + "&strDrawlDt="    + encodeURIComponent(strDrawlDt);// 일자
    TR_MAIN.Action = "/mss/mgif311.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER_POP=DS_O_MASTER_POP)";
    TR_MAIN.Post();
}

/**
 * btn_Close()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 창닫기
 * return값 : void
 */

function btn_Close() {
	window.close();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * getGiftCd()
 * 작 성 자 : 
 * 작 성 일 : 2011.08.05
 * 개    요 : 상품권종류/금종 가져오기
 * return값 : void
 */
function getGiftCd(strTarget, strDateSet){
    var strParam = strTarget;
    //상품권관리 > 상품권 판매/회수> 가맹점 제휴상품권 회수관리의 함수를 이용
    TR_MAIN.Action="/mss/mgif312.mg?goTo="+strParam;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_CODE="+ strDateSet +")";
    TR_MAIN.Post();
}
 -->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER_POP event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1)  sortColId( eval(this.DataID), row , colid );
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Input용  -->
<comment id="_NSID_"><object id="DS_O_MASTER_POP"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTTPM"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTAMT"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->

<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td width="" class="title"><img
          src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
          align="absmiddle" class="popR05 PL03" /> <SPAN id="title1"
          class="PL03">
          자사상품권 회수 비교표 상세 팝업
          </SPAN></td>
      <td>
      <table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
              <td>
                  <img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22" onClick="btn_Close();" />
              </td>
          </tr>
        </table>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER_POP width=100% height=400 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER_POP">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
</table>
</body>
</html>

