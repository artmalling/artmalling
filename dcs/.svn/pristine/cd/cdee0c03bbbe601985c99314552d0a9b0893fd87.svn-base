<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 포인트관리 > 소멸예정포인트 조회
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dctm3030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.22 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
	String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToMonth = strToMonth + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var strAddYm   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 100;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


	//Output Data Set Header 초기화
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_ADD_S_YM,    "YYYYMM",    PK);         //조회 시작일    
    //initEmEdit(EM_ADD_E_YM,    "YYYYMM", PK);         //조회 종료일
    //initEmEdit(EM_ADD_MONTH,   "YYYYMM",   PK);         //조회월    

    EM_ADD_S_YM.Text = addDate("M", "+1", '<%=strToMonth%>');
    EM_ADD_S_YM.readonly     	= true;
    //EM_ADD_S_YM.Text =  '<%=strToMonth%>'; 
    
    //nextDate   = nextMonth.substring(0,4)+ nextMonth.substring(5,7)
     //          + getLastDay( nextMonth.substring(0,4) , nextMonth.substring(5,7));
    
    //showMaster();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"                  width=80        align=center</FC>'
                     + '<FC>id=CUST_ID          name="회원(법인)ID"         width=120       align=left    </FC>'
                     + '<FC>id=CUST_NAME        name="회원(법인)명"         width=100       align=left SumText="합계" </FC>'
                     + '<FC>id=SS_NO            name="생년월일,사업자번호"     width=110       align=center   mask={IF(COMP_PERS_FLAG="C","XXX-XX-XXXXX","XXXXXX")}</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"             width=140       align=center   mask="XXXX-XXXX-XXXX-XXXX" show=true</FC>'
                     + '<FC>id=CUR_POINT	    name="현포인트"             width=100       align=right</FC>'
                     + '<FC>id=EXP_DT           name="소멸예정일자"         width=90       align=center   mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EXP_POINT        name="소멸예정포인트"       width=100       align=right SumText=@sum </FC>'
                     + '<FC>id=COMP_PERS_FLAG   name="법인/개인구분"        width=136       align=center   show=false</FC>'
                     + '<FC>id=MOBILE_PH1       name="이동전화번호"        width=100       align=center   </FC>'
                     + '<FC>id=SMS_YN           name="SMS수신여부"          width=100       align=center   </FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);

    GR_MASTER.ViewSummary = "1";
}
/*************************************************************************
 * 2. 공통버튼
    (1) 조회       - btn_Search(), subQuery()
    (2) 엑셀       - btn_Excel()
*************************************************************************/
/**
* btn_Search()
* 작 성 자     : 김영진
* 작 성 일     : 2010-03-22
* 개        요    : 조회시 호출
* return값 : void
*/
function btn_Search() {

	if(trim(EM_ADD_S_YM.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회일자");
        EM_ADD_S_YM.Focus();
        return;
    }
	showMaster();
}

/**
* btn_Excel()
* 작 성 자     : 김영진
* 작 성 일     : 2010-03-22
* 개       요     : 엑셀로 다운로드
* return값 : void
*/
function btn_Excel() {

    var ExcelTitle = "소멸예정포인트 내역"
    var parameters = " -조회월=" + strAddYm;

    openExcel2(GR_MASTER, ExcelTitle, parameters, true );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 포인트조회
 * return값 : void
 */
function showMaster(){

	//strSrchGubunNm  = RD_SRCH_GUBUN.DataValue;
	//strSrchGubun    = RD_SRCH_GUBUN.CodeValue;
    
    strAddYm   = EM_ADD_S_YM.Text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strAddYm=" + encodeURIComponent(strAddYm);    
    TR_MAIN.Action  ="/dcs/dctm303.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //Focus이동
    if(DS_O_MASTER.CountRow > 0){
    	GR_MASTER.Focus();
    }else{
    	//RD_SRCH_GUBUN.Focus();
    }
   
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_ADD_S_YM event=onKillFocus()>
    if(!checkDateTypeYM(EM_ADD_S_YM)){
    	return;
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_ADD_E_YM event=onKillFocus()>
    if(!checkDateTypeYM(EM_ADD_E_YM)){
    	return;
    }
</script>
<!-- 조회구분 OnSelChange()
<script language=JavaScript for=RD_SRCH_GUBUN event=OnSelChange()>
    if(this.CodeValue == strSrchGubun)return;
    if(RD_SRCH_GUBUN.CodeValue == 1){
    	document.getElementById("td1").style.display = "";
        document.getElementById("td2").style.display = "none";
        DS_O_MASTER.ClearData();
        gridCreate1(); 
        strSrchGubun = this.CodeValue;
    }else{
        document.getElementById("td1").style.display = "none";
        document.getElementById("td2").style.display = "";
        DS_O_MASTER.ClearData();
        gridCreate2(); 
        strSrchGubun = this.CodeValue;
    }
</script>
-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_O_MASTER"  classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
  <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>					    
						<th width="80" class="point">조회년월</th>
                        <td ><comment id="_NSID_"> <object
							id=EM_ADD_S_YM classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" />*익월 소멸예정 포인트만 조회 가능합니다.</td>
							<!-- onclick="javascript:openCal('M',EM_ADD_S_YM)" />*익월 소멸예정 포인트만 조회 가능합니다.</td> -->
							
						<th width="160" >* 포인트유효기간 : 12개월</th>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER
                    width="100%" height=504 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
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
                           
