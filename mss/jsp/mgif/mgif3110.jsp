<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 판매/회수 > 자사상품권 회수 비교표
 * 작 성 일 : 2011.03.18
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif3110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자사상품권 회수 내역을 조회 합니다.
 * 이    력 : 2011.03.14 (신익수) 신규개발
 *         
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var old_Row = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 430;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    getGiftCd("getGiftAmt", "DS_O_GIFTAMT"); //금종조회
    getGiftCd("getGiftTpm", "DS_O_GIFTTPM"); //상품권종류 조회
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DRAWL_YMD_FROM, "SYYYYMMDD", PK);   //회수일자 from
    initEmEdit(EM_S_DRAWL_YMD_TO, "TODAY", PK);         //회수일자 to
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    //getStore("DS_O_STR_CD", "Y", "", "N");
    getStore("DS_O_STR_CD", "Y", "", "Y");
    getEtcCode("DS_DRAWL_FLAG",    "D", "M076", "N"); //회수구분    
    getEtcCode("DS_POUT_TYPE",    "D", "M014", "N"); //불출유형
    getEtcCode("DS_SALE_FLAG",    "D", "M067", "N"); //판매구분
    LC_STR_CD.index = 0;
    LC_STR_CD.Focus();
}

function gridCreate(){
	 var hdrProperies = ''
						+ '<FC>ID={CURROW}            NAME="NO"' 
						+ '                                             WIDTH=35        ALIGN=CENTER</FC>'
						+ '<FC>ID=DRAWL_STR           NAME="점"'         
						+ '                                             WIDTH=135       ALIGN=LEFT   ALIGN=LEFT   EDITSTYLE=LOOKUP DATA="DS_O_STR_CD:CODE:NAME"</FC>'
						+ '<FC>ID=DRAWL_DT            NAME="일자"'         
						+ '                                             WIDTH=135       ALIGN=CENTER SUMTEXT="합계"    MASK="XXXX/XX/XX"</FC>'
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
						+ '                                               WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="강제회수"'
                        + '<FC>ID=QTY_2               NAME="매수"'           
                        + '                                             WIDTH=60        ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
                        + '<FC>ID=AMT_2               NAME="금액"'           
                        + '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="포인트반품회수"'
						+ '<FC>ID=QTY_6               NAME="매수"'           
						+ '                                             WIDTH=60       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_6               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="사은품반품회수"'
						+ '<FC>ID=QTY_7               NAME="매수"'           
						+ '                                             WIDTH=60  show=false     ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_7               NAME="금액"'           
						+ '                                           WIDTH=100   show=false     ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>'
						+ '<G>                        NAME="회수 계"'
						+ '<FC>ID=QTY_A               NAME="매수"'           
						+ '                                             WIDTH=40       ALIGN=RIGHT  SUMTEXT=@SUM</FC>'
						+ '<FC>ID=AMT_A               NAME="금액"'           
						+ '                                             WIDTH=100       ALIGN=RIGHT  SUMTEXT=@SUM</FC></G>';
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	
	var hdrProperiesD = ''
						+ '<FC>ID={CURROW}            NAME="NO"' 
						+ '                                             WIDTH=35        ALIGN=CENTER</FC>'
						+ '<FC>ID=GIFT_TYPE_NAME        NAME="상품권종류"  sumtext="합계" '         
						+ '                                             WIDTH=130       ALIGN=LEFT   </FC>'
						+ '<FC>ID=GIFT_AMT_NAME       NAME="금종명"'         
						+ '                                             WIDTH=120       ALIGN=LEFT   </FC>'
						+ '<FC>ID=GIFTCARD_NO         NAME="상품권번호"'         
						+ '                                             WIDTH=195       ALIGN=CENTER</FC>'
						+ '<FC>ID=DRAWL_AMT           NAME="금액"       sumtext=@sum '         
						+ '                                             WIDTH=135       ALIGN=RIGTH</FC>'
					    + '<FC>ID=DRAWL_FLAG          NAME="회수구분"'         
                        + '                                             WIDTH=145       ALIGN=left  EDITSTYLE=LOOKUP DATA="DS_DRAWL_FLAG:CODE:NAME"</FC>'
                        + '<FC>ID=POUT_TYPE           NAME="불출유형"'         
                        + '                                             WIDTH=145       ALIGN=left  EDITSTYLE=LOOKUP DATA="DS_POUT_TYPE:CODE:NAME"</FC>'
					    + '<FC>ID=SALE_FLAG          NAME="판매구분"'         
                        + '                                             WIDTH=145       ALIGN=left  EDITSTYLE=LOOKUP DATA="DS_SALE_FLAG:CODE:NAME"</FC>';
	initGridStyle(GD_DETAIL, "common", hdrProperiesD, false);
	GD_DETAIL.ViewSummary = "1"; 
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
	if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }
    
     // 조회조건 셋팅
     var strStrCd           = LC_STR_CD.BindColVal;     //점코드
     var strDrawlYmdFrom    = EM_S_DRAWL_YMD_FROM.Text; //회수일자 FROM
     var strDrawlYmdTo      = EM_S_DRAWL_YMD_TO.Text;   //회수일자 TO
     
     if(strDrawlYmdFrom > strDrawlYmdTo) {
         showMessage(INFORMATION, OK, "USER-1015");
         EM_S_DRAWL_YMD_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     DS_O_DETAIL.ClearData();
     
     var goTo       = "getGiftDrawlMst" ;    
     var parameters = "&strStrCd="       + encodeURIComponent(strStrCd)
                    + "&strDrawlYmdFrom="+ encodeURIComponent(strDrawlYmdFrom)
                    + "&strDrawlYmdTo="  + encodeURIComponent(strDrawlYmdTo);
     
     TR_MAIN.Action="/mss/mgif311.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET(O:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     old_Row = 1;
     
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
    if(DS_O_MASTER.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }

    var strStrCd           = LC_STR_CD.Text;     //점코드
    var strDrawlYmdFrom    = EM_S_DRAWL_YMD_FROM.Text; //회수일자 FROM
    var strDrawlYmdTo      = EM_S_DRAWL_YMD_TO.Text;   //회수일자 TO
    
    var parameters = " 점= "+strStrCd
    	+ " , 기간= "+strDrawlYmdFrom
		+ " ~ "+strDrawlYmdTo;

	var ExcelTitle = "자사상품권회수비교표"

	//openExcel2(GD_MASTER, ExcelTitle, parameters, true );
		openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );

	
	//var ExcelTitle = "자사상품권회수비교표"

	//openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
function getDrawlDtl(strDrawStr,strDrawlDt){
   
    var goTo       = "getGiftDrawlDtl" ;    
    var parameters = "&strDrawStr="+ encodeURIComponent(strDrawStr)
                   + "&strDrawlDt="+ encodeURIComponent(strDrawlDt);
    
    TR_MAIN1.Action="/mss/mgif311.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN1.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}

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

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel2() {
	 
    if(DS_O_MASTER.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }

    var strStrCd           = LC_STR_CD.Text;     //점코드
    var strDrawlYmdFrom    = EM_S_DRAWL_YMD_FROM.Text; //회수일자 FROM
    var strDrawlYmdTo      = EM_S_DRAWL_YMD_TO.Text;   //회수일자 TO
    
    var parameters = " 점= "+strStrCd
    	+ " , 기간= "+strDrawlYmdFrom
		+ " ~ "+strDrawlYmdTo;
	
	var ExcelTitle = "자사상품권회수비교표"

	//openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
		openExcel5(GD_DETAIL, ExcelTitle, parameters, true , "",g_strPid );

}

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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row != row ){
    var strDrawStr = DS_O_MASTER.NameValue(row, "DRAWL_STR");
    var strDrawlDt = DS_O_MASTER.NameValue(row, "DRAWL_DT");
    
    //점내 불출 내역 디테일 조회
    getDrawlDtl(strDrawStr,strDrawlDt);
}
old_Row = row;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1)  sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1)  sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>
	if( row < 1) return;
	var strDrawStr = DS_O_MASTER.NameValue(row, "DRAWL_STR");
	var strDrawlDt = DS_O_MASTER.NameValue(row, "DRAWL_DT");
	    
	var rtnMap  = new Map();
	var arrArg  = new Array();
	
	arrArg.push(rtnMap);
	arrArg.push(strDrawStr);
	arrArg.push(strDrawlDt);
	
	var returnVal = window.showModalDialog("/mss/mgif311.mg?goTo=pop",
	                                       arrArg,
	                                       "dialogWidth:800px;dialogHeight:430px;scroll:no;" +
	                                       "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	 
	if (returnVal){
	}
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DRAWL_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POUT_TYPE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SALE_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTTPM"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFTAMT"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
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
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80"  class="POINT">점</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=150 align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="POINT">기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_S_DRAWL_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70"
							onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DRAWL_YMD_FROM)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_DRAWL_YMD_TO
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width="70"
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_DRAWL_YMD_TO)"
							align="absmiddle" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=300 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
					<Param Name="ViewSummary" value="1">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
            </td>
            <td class="right" valign="bottom">
            <img src="/<%=dir%>/imgs/btn/excel.gif" onclick="btn_Excel2();" />
            </td>	
    </tr>        
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
					width=100% height=300 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_DETAIL">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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

