<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 기준정보관리 
 * 작 성 일 : 2010.05.04
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : MREN3070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월간접관리비 배부 
 * 이    력 : 2010.05.04(신익수) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session 
			.getAttribute("sessionInfo");
	String contextRoot = request.getContextPath();
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

var old_Row = 0;
var now = new Date();
var year = now.getYear();
var mon = now.getMonth()+1;
if(mon < 10)mon = "0" + mon;

var thisMonth = year + mon;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_DETAIL");
    
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); 
    
    // EMedit에 초기화
    initEmEdit(EM_S_CAL_YM, "THISMN", PK);       //조회 부과년월 
    initEmEdit(EM_I_CAL_YM, "THISMN", PK);       //등록 부과년월 
    
    //콤보초기화
    initComboStyle(LC_S_DIV_ITEMCD, DS_O_ITEMCD,"CODE^0^30,NAME^0^80", 1, PK);              //
    initComboStyle(LC_I_DIV_ITEMCD, DS_IO_ITEMCD,"CODE^0^30,NAME^0^80", 1, PK);              //
    
    getEtcCode("DS_O_ITEMCD","D","M078","Y");  
    getEtcCode("DS_I_ITEMCD","D","M078","N");  
    getEtcCode("DS_IO_ITEMCD","D","M078","Y");
    
    LC_S_DIV_ITEMCD.index = 0;
    LC_I_DIV_ITEMCD.index = 0;
    
    btn_Search();
    
}

function gridCreate(){
	var hdrProperies = ''
			+ '<FC>ID={CURROW}           NAME="NO"  WIDTH=30      ALIGN=CENTER</FC>'
			+ '<FC>ID=CAL_YM        NAME="부과년월"   WIDTH=70   edit={IF(CHECKGB=T,"true","false")}  EDIT=Numeric MASK="XXXX/XX"   EDITSTYLE=POPUP   ALIGN=center </FC>'
			+ '<FC>ID=DIV_ITEM_CD        NAME="배부항목"   WIDTH=120   edit={IF(CHECKGB=T,"true","false")}  ALIGN=LEFT EDITSTYLE=LOOKUP    DATA="DS_I_ITEMCD:CODE:NAME"</FC>'
			+ '<FC>ID=MNTN_AMT           NAME="배부금액"   WIDTH=110     ALIGN=RIGHT</FC>';
			
		    initGridStyle(GD_MASTER, "common", hdrProperies, true);
	
    var hdrProperies1 = ''
	    	+ '<FC>ID={CURROW}           NAME="NO"  WIDTH=30      ALIGN=CENTER</FC>'
	        + '<FC>ID=STR_CD        NAME="시설구분코드" SHOW=FALSE  </FC>'
	        + '<FC>ID=STR_NAME        NAME="시설구분"  WIDTH=90     ALIGN=LEFT  </FC>'
	        + '<FC>ID=MNTN_ITEM_CD       NAME="관리비항목코드"    WIDTH=90     ALIGN=CENTER  </FC>'
	        + '<FC>ID=MNTN_ITEM_NM       NAME="관리비항목명"    WIDTH=170     ALIGN=LEFT</FC>'
	        + '<FC>ID=MNTN_AMT           NAME="배부금액"   WIDTH=90     ALIGN=RIGHT</FC>'
	        + '<FC>ID=DIV_RATE           NAME="배부율"   WIDTH=80      ALIGN=RIGHT</FC>'
	        + '<FC>ID=DIV_ITEM_CD        NAME="배부항목코드"   SHOW=FALSE</FC>'
	        
            initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
	
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
 * 작 성 일 : 2010.04.01
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//데이타셋 초기화
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
	
    var strCalYm       = EM_S_CAL_YM.Text;            // 부과년월
    var strItemCd        = LC_S_DIV_ITEMCD.BindColVal;           //간접비 항목
    
    var goTo       = "getMntnItemMst" ;    
    var action     = "O";     
    var parameters = "&strCalYm=" + encodeURIComponent(strCalYm)
                    +"&strItemCd="+ encodeURIComponent(strItemCd)
				    ;
    
    TR_MAIN.Action="/mss/mren307.mr?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    //setPorcCount("SELECT", GD_MASTER);
    old_Row = 1;
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(StopSign, OK, "USER-1028");
       return;
    }
     
    //ccheck 
    if(!checkValidation("Save")) {
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") != 1 )
        return;
    
    var goTo       = "save" ;  
 
    TR_MAIN.Action="/mss/mren307.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    btn_Search();   
    
}

/**
 * btn_delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 삭제 
 * return값 :
 */
function btn_Delete() {
	 
	 var sysStatus = DS_IO_MASTER.SysStatus(DS_IO_MASTER.RowPosition);
	 
	 if (sysStatus == 1) {
		 DS_IO_MASTER.DeleteRow(DS_IO_MASTER.Rowposition);  
		 
	 } else {
		
	    //삭제 하시겠습니까?
	    if(showMessage(QUESTION , YESNO, "USER-1032", "배부 항목") != 1) return;
	    
	    var strCalYm = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_YM");
	    var strItemCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DIV_ITEM_CD");
        
        var parameters = "&strCalYm="  + encodeURIComponent(strCalYm)
                        + "&strItemCd="+ encodeURIComponent(strItemCd);  
        
        var goTo       = "delete" ;    
       
        TR_MAIN.Action="/mss/mren307.mr?goTo="+goTo+parameters;  
        TR_MAIN.Post();
        
        if(TR_MAIN.ErrorCode == 0) btn_Search();
	 }
}

/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행추가
 * return값 :
 */
function btn_New() {
	DS_IO_DETAIL.ClearData();
	DS_IO_MASTER.AddRow();
	
	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_YM") = thisMonth;
	 
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
	
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * btn_DeleteRow()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 행삭제
  * return값 :
  */
 function btn_DeleteRow(){
    
    if (DS_IO_DETAIL.CountRow > 0) {
            DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.Rowposition);  
    }
	
}
 
 /**
  * getAutoDtl()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 디테일 조회
  * return값 :
  */
 function getMntnItemDtl(strCalYm,strItemCd) {
	var goTo       = "getMntnItemDtl" ;    
    var action     = "O";     
    var parameters = "&strCalYm="  + encodeURIComponent(strCalYm)
                     +"&strItemCd="+ encodeURIComponent(strItemCd);
    
    TR_SUB.Action="/mss/mren307.mr?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_SUB.Post();
    
 // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}
 
 /**
  * checkValidation()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 화면 체크 
  * return값 :
  */
 function checkValidation () {
  
  //마스터 체크
  var intRowCount = DS_IO_MASTER.CountRow;
      
  if(intRowCount > 0){
      for(var i=1; i <= intRowCount; i++){
    	var strCalYm = DS_IO_MASTER.NameValue(i, "CAL_YM");
        var strDivItem = DS_IO_MASTER.NameValue(i, "DIV_ITEM_CD");
        var intMntnAmt = DS_IO_MASTER.NameValue(i, "MNTN_AMT");
        
        if(strCalYm.length <= 0){
            showMessage(INFORMATION, OK, "USER-1003", "부과년월");
            GD_MASTER.SetColumn("CAL_YM"); 
            DS_IO_MASTER.RowPosition = i;  
            return false;
        }
        
        if(strDivItem.length <= 0){
            showMessage(INFORMATION, OK, "USER-1003", "배부항목");
            GD_MASTER.SetColumn("DIV_ITEM_NM"); 
            DS_IO_MASTER.RowPosition = i;  
            return false;
        }
        
        if(intMntnAmt == 0){
            showMessage(INFORMATION, OK, "USER-1003", "금액");
            GD_MASTER.SetColumn("MNTN_AMT");  
            DS_IO_MASTER.RowPosition = i;  
            return false;
        }
        
        // 중복체크
        var dupRow = checkDupKey(DS_IO_MASTER, "DIV_ITEM_CD");
        if (dupRow > 0) {
            showMessage(StopSign, Ok,  "USER-1044", "배부항목 " + dupRow);
            
            DS_IO_MASTER.RowPosition = dupRow;
            GD_MASTER.SetColumn("DIV_ITEM_CD");
            GD_MASTER.Focus(); 

            return false;
        }
     }
  }
 
  return true; 
 }
 
 /**
  * getDivItem()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 관리비배부 
  * return값 :
  */
 function getDivItem() {
	var strCalYm       = EM_I_CAL_YM.Text;            // 부과년월
    var strItemCd        = LC_I_DIV_ITEMCD.BindColVal;           //간접비 항목
    
    var strYm = strCalYm.substr(0,4) + "년" + strCalYm.substr(4,2) + "월";
    
    if(strCalYm.length <= 0){
        showMessage(INFORMATION, OK, "USER-1003", "부과년월");
        EM_I_CAL_YM.focus();
        return false;
    }
   
    if(showMessage(QUESTION , YESNO, "USER-1000", "이미 등록된 정보는 삭제되고 재생성 됩니다.<br>" + " " +strYm + " " + "관리비 배부를  실행하시겠습니까?") != 1) return;
    
    var goTo       = "getDivAmt" ;    
    var action     = "O";     
    var parameters = "&strCalYm=" + encodeURIComponent(strCalYm)
                    +"&strItemCd="+ encodeURIComponent(strItemCd)
                    ;
    
    TR_MAIN.Action="/mss/mren307.mr?goTo="+goTo+parameters;  
    TR_MAIN.Post();
    
    btn_Search();
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
<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    //저장 성공시 재조회
    btn_Search(g_currRow);
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row != row ){
	var strCalYm = DS_IO_MASTER.NameValue(row, "CAL_YM");
	var strItemCd = DS_IO_MASTER.NameValue(row, "DIV_ITEM_CD");
 
    // 디테일 조회
    getMntnItemDtl(strCalYm,strItemCd);
}
old_Row = row;

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
if (colid == "CAL_YM") {
//부과년월 
    if (row < 1) return;
    
    openCal(this,row,colid,'M');    
}
</script>


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
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ITEMCD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_ITEMCD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_AUTO_STRCD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_AUTO_ITEMCD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_ITEMCD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== ONLOAD용 -->

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
<body onLoad="doInit();" class="PL10 PT15 ">
<iframe id=IFPAGE name=IFPAGE src="about:blank" width=0 height=0></iframe>
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
					    <th width="70" class="POINT">부과년월</th>
                        <td width="130">
                            <comment id="_NSID_">
                               <object id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="60" onblur="checkDateTypeYM(this);" align="absmiddle" tabindex=1> 
                               </object>
                            </comment><script>_ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('M',EM_S_CAL_YM)" />
                        </td>
						<th width="70" >배부항목</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_S_DIV_ITEMCD classid=<%=Util.CLSID_LUXECOMBO%> width="127"
                            tabindex=1 height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="300">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td>
						<comment id="_NSID_">
						<OBJECT id=GD_MASTER width=100% height=503 tabindex=1 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER"/>
						</OBJECT></comment><script>_ws_(_NSID_);</script>
						
						</td>
					</tr>
				</table>
				</td>
				<td class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT05">
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
	                            <tr>
	                                <th width="60" class="POINT">부과년월</th>
	                                <td width="90">
	                                     <comment id="_NSID_">
						                    <object id=EM_I_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="60" onblur="checkDateTypeYM(this);" align="absmiddle" tabindex=1> 
						                    </object>
						                 </comment><script>_ws_(_NSID_);</script>
						                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('M',EM_I_CAL_YM)" />
	                                </td>
	                                <th width="60" >배부항목</th>
                                    <td width="130">
                                        <comment id="_NSID_"> <object
                                            id=LC_I_DIV_ITEMCD classid=<%=Util.CLSID_LUXECOMBO%> width="127"
                                            tabindex=1 height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                    </td>
                                    <td>
                                     <img src="/<%=dir%>/imgs/btn/div_item.gif" align="absmiddle" onclick="javascript:getDivItem();" />
                                    </td>
	                            </tr>
	                        </table>
                        
						   <table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr >
							 <td height=5>
							 </td>
							</tr>
							<tr>
								<td class="sub_title"  height=20>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 시설별 배부금액</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
									width=100% height=447 tabindex=1 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_DETAIL"/>
								</OBJECT></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</body>
</html>

