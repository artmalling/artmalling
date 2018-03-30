<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 카드발급사코드관리
 * 작 성 일 : 2010.05.23
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : psal901.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.23 (장형욱) 신규작성
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
	// PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var intChangRow       = 0;
var EXCEL_PARAMS = "";
var g_strPid           = "<%=pageName%>";                 // PID

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
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();  

    //-- 입력필드
    initEmEdit(EM_CCOMP_CD,    "00",       READ);          
    initEmEdit(EM_CCOMP_NM,    "GEN^20",      PK);     
    
    initComboStyle(LC_BCOMP, DS_O_BCOMP, "CODE^0^30, NAME^0^80", 1, PK);
    
    // EMedit에 초기화
    getBcompCode("DS_O_BCOMP", "", "", "N");    
    
    //화면 OPEN시 조회
    btn_Search();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal901","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"            width=30       align=center</FC>'
                     + '<FC>id=CCOMP_CD        name="카드발급사 코드"  width=100      align=center</FC>'
                     + '<FC>id=CCOMP_NM        name="카드사명"        width=230     align=left</FC>'
                     + '<FC>id=BCOMP_CD        name="매입사 코드"      width=100     align=center</FC>'
                     + '<FC>id=BCOMP_NM        name="매입사명"        width=230     align=left</FC>'
                     + '<FC>id=BCOMP_YN        name="매입사여부"      width=90     align=center</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 신규       - btn_New()
     (2) 저장       - btn_Save()
     (3) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "BIN_NO") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }   
    
    var goTo        = "searchMaster";    
    var action      = "O";     
     
    TR_MAIN.Action  = "/dps/psal901.ps?goTo="+goTo;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
    	GD_MASTER.Focus();
        if(intChangRow > 0){
            bfListRowPosition = DS_O_MASTER.RowPosition;
            setFocusGrid(GD_MASTER, DS_O_MASTER, intChangRow);
            doClick(intChangRow);
        }
    }
    bfListRowPosition = 0;
}

/**
 * btn_New()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
            setTimeout("EM_CCOMP_CD.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "CCOMP_CD") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }
    
    
    DS_O_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    strChangFlag = false;
    RD_BCOMP_YN.CodeValue = "N";
    bfListRowPosition = 0;
    intChangRow = 1;
    initEmEdit(EM_CCOMP_CD,      "00",       PK);  
    EM_CCOMP_CD.Text = "";
    EM_CCOMP_CD.focus();
}
 
/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }    
    if (trim(EM_CCOMP_CD.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사 코드");
        EM_CCOMP_CD.Focus();
        return;
    } 
    if (trim(EM_CCOMP_NM.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드사명");
        EM_CCOMP_NM.Focus();
        return;
    } 
    if (trim(LC_BCOMP.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "매입사 코드");
        LC_BCOMP.Focus();
        return;
    }    
    if (trim(RD_BCOMP_YN.CodeValue).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "매입사여부");
        RD_BCOMP_YN.Focus();
        return;
    }       
    
    var strBcompCdYn = "N";
    for(var i=1; i<DS_O_MASTER.CountRow; i++){
        if( DS_O_MASTER.NameValue(i, "BCOMP_CD") == DS_IO_DETAIL.NameValue(1, "BCOMP_CD")
         && DS_O_MASTER.NameValue(i, "BCOMP_YN") == DS_IO_DETAIL.NameValue(1, "BCOMP_YN")
         && DS_O_MASTER.NameValue(i, "BCOMP_YN") == "Y"){
        	strBcompCdYn = "Y"; 
        }
    }
    
    if (strBcompCdYn == "Y") {
        showMessage(StopSign, OK, "USER-1000",  "매입사코드가 중복 되었습니다.");
        strBcompCdYn = "N";
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }   
    if(intChangRow != 1){
        intChangRow = DS_O_MASTER.RowPosition;
    }
    
    bfListRowPosition = 0;
    saveData();
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    var ExcelTitle = "카드발급코드 관리"
    //openExcel2(GD_MASTER, ExcelTitle, '', true );
    	openExcel5(GD_MASTER, ExcelTitle, '', true , "",g_strPid );

}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개       요 : 카드발급사코드 관리 등록
 * return값 : void
 */
function saveData(){
    
   var goTo        = "saveData";
   var action      = "I";  //조회는 O
   TR_MAIN.Action  ="/dps/psal901.ps?goTo="+goTo;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
   TR_MAIN.Post();

   btn_Search();
}
  
/**
 * doOnClick()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 선택된 클럽관리 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
     
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
     
    var goTo          = "searchDetail";    
    var action        = "O";     
    var parameters    = "&strCcompCd=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"CCOMP_CD"));
    TR_DETAIL.Action  = "/dps/psal901.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    initEmEdit(EM_CCOMP_CD,      "GEN^2",       READ);  
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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
    intChangRow = 0;
    bfListRowPosition = DS_O_MASTER.RowPosition;
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if ( strChangFlag == false && DS_IO_DETAIL.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("EM_CCOMP_NM.Focus();",50);
            return false;
        }else{
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "CCOMP_CD") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
            bfListRowPosition = row;
            intChangRow = 0;
        }  
    }else{
    	return true;
    }
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        if( intChangRow == 0 ){
            bfListRowPosition = row;
            doClick(row);
        }
    }else{
        DS_IO_DETAIL.ClearData();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
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
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_BCOMP classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
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

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=491 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">카드발급사코드</th>
						<td width="140"><comment id="_NSID_"> <object
							id=EM_CCOMP_CD classid=<%=Util.CLSID_EMEDIT%> width=20 tabindex=1
							onkeyup="javascript:checkByteStr(EM_CCOMP_CD, 2, '');"></object>
						</comment> <script> _ws_(_NSID_);</script></td>
						<th width="80" class="point">카드발급사명</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_CCOMP_NM classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1
							onkeyup="javascript:checkByteStr(EM_CCOMP_NM, 20, '');"></object>
						</comment> <script> _ws_(_NSID_);</script></td>

						<th width="80" class="point">매입사코드</th>
						<td><comment id="_NSID_"> <object id=LC_BCOMP
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=130
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="80">매입사여부</th>
						<td colspan="5"><comment id="_NSID_"> <object
							id=RD_BCOMP_YN classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 100" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^Yes,N^No">
							<param name=CodeValue value="Y">
						</object> </comment><script> _ws_(_NSID_);</script></td>
					</tr>
				</table>
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
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
               <c>col=CCOMP_CD       ctrl=EM_CCOMP_CD          Param=Text</c>
               <c>col=CCOMP_NM       ctrl=EM_CCOMP_NM          Param=Text</c>
               <c>col=BCOMP_CD       ctrl=LC_BCOMP             Param=BindColVal</c>
               <c>col=BCOMP_YN       ctrl=RD_BCOMP_YN          Param=CodeValue</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
