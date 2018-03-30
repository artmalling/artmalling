<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 타사카드 > 실적관리 > 일별 카드사별 수수료조회
 * 작 성 일 : 2012.06.22
 * 작 성 자 : DHL
 * 수 정 자 : 
 * 파 일 명 : psal9530.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");
	String fromDate = new java.text.SimpleDateFormat("yyyyMM")
			.format(new java.util.Date()) + "01";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var EXCEL_PARAMS = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();  

    //-- 입력필드
    initEmEdit(EM_S_DT_S, "YYYYMMDD",    PK);    
    initEmEdit(EM_E_DT_S, "today",       PK);      
    
    initComboStyle(LC_STR_CD_S,  DS_O_S_STR, "CODE^0^20, NAME^0^80", 1, PK);
    
    // EMedit에 초기화
    getStore("DS_O_S_STR", "Y", "", "N");
    //LC_STR_CD_S.index = 0;      

    //초기값설정
    setComboData(LC_STR_CD_S,  DS_O_S_STR.NameValue(0, "CODE"));
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD_S.BindColVal = strcd;

    EM_S_DT_S.text = <%=fromDate%>;
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}          name="NO"           width=30    align=center   bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}</FC>'  // D4FFD4 FFF0E0
                        + '<FC>id=SALE_DT           name="매출일자"         width=85    align=center   mask={IF(SALE_DT = "합 계", "합 계", "XXXX/XX/XX")}  bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=BCOM_NM           name="매입사 코드/명"     width=120   align=left     bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=CCOM_NM           name="발급사 코드/명"     width=120   align=left     bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=DCARD_NM          name="카드종류"         width=120    align=left     bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=FEE_RATE_GB       name="수수료구분"        width=90    align=left     bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=SALE_AMT          name="매출액"          width=100    align=right    mask="###,###"      bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=FEE_RATE          name="수수료율"         width=60    align=right    bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=FEE_AMT           name="수수료"          width=100    align=right    mask="###,###"      bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}    </FC>'
                        + '<FC>id=INCOME_AMT        name="예상입금액"        width=100    align=right    mask="###,###"    bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        + '<FC>id=ROUND_FG          name="반올림구분"        width=100    align=left    bgcolor={IF(SALE_DT = "합 계" ,"#D4D4FF", IF(BCOM_NM = "소 계" , "#D4FFD4", IF(CCOM_NM = "소 계" , "#FFFFE0", "white")))}   </FC>'
                        ;                               
                        
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //GD_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
	 
	if (trim(LC_STR_CD_S.BindColVal).length == 0) {
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD_S.Focus();
	    return;
	}  
    if (trim(EM_S_DT_S.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회기간");
        EM_S_DT_S.Focus();
        return;
    }
    if (trim(EM_E_DT_S.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "조회기간");
        EM_E_DT_S.Focus();
        return;
    }   
    
    if(EM_S_DT_S.text > EM_E_DT_S.text){             // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DT_S.Focus();
        return;
    }  
     
    EXCEL_PARAMS  = "점포명="     + LC_STR_CD_S.text;
    EXCEL_PARAMS += "-조회기간="  + EM_S_DT_S.text + "~" + EM_E_DT_S.text;
        
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="  +  encodeURIComponent(LC_STR_CD_S.BindColVal)   
                    + "&strSDt="    +  encodeURIComponent(EM_S_DT_S.text)  
                    + "&strEDt="    +  encodeURIComponent(EM_E_DT_S.text);
                     
    
    TR_MAIN.Action  = "/dps/psal953.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }

    bfListRowPosition = 0;
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-02-17
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    var ExcelTitle = "일별 카드사별 수수료조회"
    openExcel2(GD_MASTER, ExcelTitle, EXCEL_PARAMS, true );
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
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = <%=fromDate%>;
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_DT_S)){
        initEmEdit(EM_E_DT_S, "today",       PK); 
    }
</script>  

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_S_STR classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>> </object>
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
	
    var obj   = document.getElementById("GD_MASTER");
    
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
                        <th width="80" class="point">점포명</th>
                        <td width="320"><comment id="_NSID_"> <object
                            id=LC_STR_CD_S classid=<%=Util.CLSID_LUXECOMBO%> width=159
                            align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>    
                            
                        <th width="80" class="point">조회기간</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
                            id="_NSID_"> <object id=EM_E_DT_S
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_E_DT_S)" /></td>    
                        </td>
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
	<tr>
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=503 classid=<%=Util.CLSID_GRID%> tabindex=1>
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