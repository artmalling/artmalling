<!-- 
/*******************************************************************************
 * 시스템명 : 매출현황 > 매출실적 > 무인정산자료 비교표 상세
 * 작 성 일 : 2016.10.27
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : psal6101.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 무인정산자료 비교표조회 한다.
 * 이    력 :
 *        2016.10.27 (박래형) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="common.util.Util, common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>무인정산기 상세조회</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script language="javascript" type="text/javascript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var strStrCd = dialogArguments[0];
 var strStrDt = dialogArguments[1];
 var strEndDt = dialogArguments[2];
 var strPosNo = dialogArguments[3];
 var strPosNm = dialogArguments[4];
 
/**
 * doInit() 
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	 initEmEdit(EM_PROC_DT, "YYYYMMDD", READ);		// 처리일
	 strToday    = getTodayDB("DS_TODAY");
	 EM_PROC_DT.TEXT = strToday;
	 gridCreate();
	 btn_Search();
}

/**
 * gridCreate()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-27
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){

	var hdrProperies = '<FC>id={currow}           	name="NO"           width=40      align=center edit=none           </FC>'
	                 + '<FC> id=STR_CD            	name="점"           width=80      align=left   show=false </FC>'
	                 + '<FC> id=SALE_DT           	name="매출일자"     width=90      align=center show=true  suppress=1 mask="XXXX/XX/XX" edit=none</FC>'                      
	                 + '<FG>						name="POS/PDA"		'
	                 + '<FC> id=POS_NO         		name="번호"   		width=70      align=center show=true edit=none </FC>'
	                 + '<FC> id=POS_NAME       		name="명"   		width=100     align=left   show=true  edit=none</FC>'
	                 + '</FG>'
	                 + '<FG>						name="구분"		'
	                 + '<FC> id=CAL_CD	       		name="코드"     	width=50     align=center   show=true edit=none  </FC>'
	                 + '<FC> id=CAL_NAME	       	name="명"     		width=120     align=left   show=true edit=none sumtext="합  계" </FC>'
	                 + '</FG>'
	                 + '<FC> id=CAL_AMT          	name="금액"         width=120     align=right  show=true  sumtext=@sum     </FC>'
	                 + '<FC> id=BIGO          		name="비고"     	width=200     align=left  show=true   </FC>'
	                 + '<FC> id=MOD_ID          	name="수정자"       width=90     align=center  show=true  edit=none     </FC>'
	                 + '<FC> id=MOD_DATE          	name="수정일시"     width=200     align=left  show=true  edit=none     </FC>'
	                 ;
	                 
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    GD_DETAIL.Editable	  =	true;
    GD_DETAIL.ViewSummary =	"1";	//합계 보이기
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

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * btn_Search()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.04.19
  * 개    요 : 조회시 호출
  * return값 : void
  */
function btn_Search() {
    
    var goTo         = "searchDetail";    
    var action       = "O";  
    var parameters   = "&strStrCd=" + encodeURIComponent(strStrCd)
				     + "&strStrDt=" + encodeURIComponent(strStrDt)
				     + "&strEndDt=" + encodeURIComponent(strEndDt)
				     + "&strPosNo=" + encodeURIComponent(strPosNo)
				     ;
    TR_MAIN.Action   ="/dps/psal610.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue ="SERVLET("+action+":DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post();

}
/**
 * addRow(strDt)
 * 작 성 자 : jyk
 * 작 성 일 : 2017.12.07
 * 개    요 : 행 추가
 * return값 : void
 */
function addRow(strDt) {

	// 내역내 추가하고자 하는 날짜가 존재하는지 체크
	var nRowCnt = DS_DETAIL.CountRow;
	var strTemp = "";
	
	for (var i = 1; i <= nRowCnt; i++) {
		strTemp = DS_DETAIL.NameValue(i,"SALE_DT");
		if (strDt==strTemp) {
			showMessage(INFORMATION, OK, "USER-1000", "조회 내역내 일자가 존재합니다.");
			return false;
		}
	}
	
	// 이관 내역 테이블에 존재하는지 체크
	if (chkValexData(strStrCd,strDt,strPosNo) != "0") {
		showMessage(INFORMATION, OK, "USER-1000", "정산기 입금내역이 존재합니다.기간을 조정하여 재조회하십시오.");
		return false;
	}
	
	// 로우 추가.
	for (i = 1; i <= 4; i++) {
		DS_DETAIL.AddRow();
		nRowCnt = DS_DETAIL.CountRow;
		DS_DETAIL.NameValue(nRowCnt,"STR_CD") = strStrCd;
		DS_DETAIL.NameValue(nRowCnt,"SALE_DT") = strDt;
		DS_DETAIL.NameValue(nRowCnt,"POS_NO") = strPosNo;
		DS_DETAIL.NameValue(nRowCnt,"POS_NAME") = strPosNm;
		if (i==1) {
			DS_DETAIL.NameValue(nRowCnt,"CAL_CD") 	= "01";
			DS_DETAIL.NameValue(nRowCnt,"CAL_NAME") = "현금";
		} else if (i==2) {
			DS_DETAIL.NameValue(nRowCnt,"CAL_CD") 	= "11";
			DS_DETAIL.NameValue(nRowCnt,"CAL_NAME") = "자사상품권";
		} else if (i==3) {
			DS_DETAIL.NameValue(nRowCnt,"CAL_CD") 	= "26";
			DS_DETAIL.NameValue(nRowCnt,"CAL_NAME") = "국민관광상품권";
		}	else {
			DS_DETAIL.NameValue(nRowCnt,"CAL_CD") = "28";
			DS_DETAIL.NameValue(nRowCnt,"CAL_NAME") = "GS상품권";
		}
	}
	
}
/**
 * chkValexData(strStr, strDt, strPos)
 * 작 성 자 : jyk
 * 작 성 일 : 2017.12.07
 * 개    요 : 행 추가
 * return값 : number
 */
function chkValexData(strStr, strDt, strPos) {

	DS_O_RESULT.ClearData();
	
	var goTo         = "chkValexData";    
    var action       = "O";  
    var parameters   = "&strStr=" + encodeURIComponent(strStr)
				     + "&strDt=" + encodeURIComponent(strDt)
				     + "&strPos=" + encodeURIComponent(strPos)
				     ;
    TR_MAIN.Action   ="/dps/psal610.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue ="SERVLET("+action+":DS_O_RESULT=DS_O_RESULT)";
    TR_MAIN.Post();

    var rtnVal = DS_O_RESULT.NameValue(1,"CNT");
    return rtnVal;
    
}

/**
 * saveData()
 * 작 성 자 : jyk
 * 작 성 일 : 2017.12.07
 * 개    요 : 입력/수정 내용 저장.
 * return값 : void
 */
function saveData() {
	
	if (!DS_DETAIL.IsUpdated) {
		showMessage(INFORMATION, OK, "USER-1000", "변경 내용이 없습니다.");
		return false;
	} 
 
	//변경또는 신규 내용을 저장하시겠습니까?
	if (showMessage(QUESTION, YESNO, "USER-1010") != 1)
		return false;
	
	
	var goTo        = "save";    
	var action      = "I";     
	var parameters  = ""
	                ;
	              
	TR_MAIN.Action  = "/dps/psal610.ps?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue= "SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; 
	TR_MAIN.Post();    
	
	window.returnValue = "0";
    self.close();

}
/**
 * init()
 * 작 성 자 : jyk
 * 작 성 일 : 2017.12.07
 * 개    요 : 내역 초기화(재조회) 여부 확인후 진행.
 * return값 : void
 */
function init() {
	
	if (DS_DETAIL.IsUpdated) {
		if (showMessage(QUESTION, YESNO, "USER-1000", "변경된 내역이 있습니다. 초기화 하시겠습니까?") != 1 ) 
			return false;
		else
			doInit();
	} else {
		doInit();
	}
		
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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->  
<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TODAY"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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

<body  onload="doInit();" class="PL10 PT15">

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
    <tr>
    	<td width="680" colspan="6">
		<p style="font-size=14px;font-style=bold;">
			<img src="/<%=dir%>/imgs/comm/title_head.gif">
		 	<b>POS/PDA <script>document.write(strPosNo+" ("+strPosNm+") 상세조회</b> "+strStrDt + " ~ " + strEndDt);</script>		 	 
		</p>
    	</td>
		<th width = "120" class="point">매출일자(행추가)</th>
    	<td width = "230">
	    	<comment id="_NSID_">
			<object id=EM_PROC_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
			</comment><script> _ws_(_NSID_);</script>
			<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_PROC_DT);" align="absmiddle" />
	    	<img src="/<%=dir%>/imgs/btn/add_row.gif" onclick="javascript:addRow(EM_PROC_DT.TEXT);">
	    	<img src="/<%=dir%>/imgs/btn/del_row.gif" onclick="javascript:delRow();" style="display=none;">
	    	<img src="/<%=dir%>/imgs/btn/init.gif" onclick="javascript:init();">
    	</td>
    	<td align="right">
    	<img src="/<%=dir%>/imgs/btn/save.gif" onclick="javascript:saveData();">
    	</td>
    </tr>
    <tr>
        <td colspan="10" class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
				<tr>
					<td width="100%" >
						<comment id="_NSID_"><object id=GD_DETAIL width="100%" height=350px classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_DETAIL">
						</object></comment><script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
        
        </td>
    </tr>

</table>
</body>
</html>

