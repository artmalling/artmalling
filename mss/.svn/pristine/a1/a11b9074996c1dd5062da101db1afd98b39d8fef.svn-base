<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 간접비 자동배부 기준
 * 작 성 일 : 2010.05.04
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : MREN1080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 계량기 관리
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
    DS_IO_AUTO_STRCD.setDataHeader('<gauce:dataset name="H_AUTO_STR_CD"/>');
    DS_IO_AUTO_STRCD.setDataHeader('<gauce:dataset name="H_AUTO_ITEMCD"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_DETAIL");
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); 
    
    //콤보초기화
    initComboStyle(LC_S_DIV_ITEMCD, DS_O_ITEMCD,"CODE^0^30,NAME^0^80", 1, PK);              //
   
    getEtcCode("DS_O_ITEMCD","D","M078","Y");  
    getEtcCode("DS_I_ITEMCD","D","M078","N");  
    
    
    LC_S_DIV_ITEMCD.index = 0;
}

function gridCreate(){
	var hdrProperies = ''
			+ '<FC>ID={CURROW}           NAME="NO"  WIDTH=40      ALIGN=CENTER</FC>'
			+ '<FC>ID=DIV_ITEM_CD        NAME="배부항목"   WIDTH=120   edit={IF(CHECKGB=T,"true","false")}  ALIGN=LEFT EDITSTYLE=LOOKUP    DATA="DS_I_ITEMCD:CODE:NAME"</FC>'
			+ '<FC>ID=DIV_RATE           NAME="총배부율"   WIDTH=110      ALIGN=RIGHT</FC>';
			
		    initGridStyle(GD_MASTER, "common", hdrProperies, true);
	
    var hdrProperies1 = ''
	    	+ '<FC>ID={CURROW}           NAME="NO"  WIDTH=40      ALIGN=CENTER</FC>'
	        + '<FC>ID=STR_CD        NAME="시설구분" WIDTH=100   edit={IF(CHECKGB=T,"true","false")}   ALIGN=LEFT EDITSTYLE=LOOKUP    DATA="DS_IO_AUTO_STRCD:CODE:NAME"  </FC>'
	        + '<FC>ID=MNTN_ITEM_CD        NAME="관리비항목코드"  edit=none  WIDTH=90     ALIGN=CENTER  </FC>'
	        + '<FC>ID=MNTN_ITEM_NM           NAME="관리비항목명" edit=none   WIDTH=170     ALIGN=LEFT</FC>'
	        + '<FC>ID=DIV_RATE           NAME="배부율"   WIDTH=80      ALIGN=RIGHT</FC>'
	        + '<FC>ID=DIV_ITEM_CD           NAME="배부항목코드"   SHOW=FALSE</FC>'
	        
            initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
	
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
	
    var strAutoItemCd        = LC_S_DIV_ITEMCD.BindColVal;           //간접비 자동배부기준
    
    var goTo       = "getAutoMst" ;    
    var action     = "O";     
    var parameters = "&strAutoItemCd="+encodeURIComponent(strAutoItemCd)
				    ;
    
    TR_MAIN.Action="/mss/mren111.mr?goTo="+goTo+parameters;  
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
    if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated){
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
 
    TR_MAIN.Action="/mss/mren111.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
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
	   
	    var strAutoItemCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DIV_ITEM_CD");
        
        var parameters = "&strAutoItemCd="+ encodeURIComponent(strAutoItemCd);   
        var goTo       = "delete" ;    
       
        TR_MAIN.Action="/mss/mren111.mr?goTo="+goTo+parameters;  
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
  * btn_AddRow()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 행추가
  * return값 :
  */
 function btn_AddRow(){
	  
	if (DS_IO_MASTER.CountRow > 0) {
	  
		//마스터의 배부 항목별 점을 가져온다.
		var sysStatus = DS_IO_MASTER.SysStatus(DS_IO_MASTER.RowPosition);
	    
		//if (sysStatus != 0) {
	     //   showMessage(StopSign, OK, "USER-1000","배부항목 저장후 작업하세요.");
	     //   return;
	    //}
		
		//if (sysStatus == 0) {
			var strAutoItemCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DIV_ITEM_CD");
			
			
			if (strAutoItemCd.length > 0 ) {
				getAutoStrCd(strAutoItemCd);
	            
				if (DS_IO_AUTO_STRCD.CountRow > 0 ) {
					DS_IO_DETAIL.AddRow();
				} else {
					showMessage(StopSign, OK, "USER-1000","해당 배부항목에 시설이 존재 하지 않습니다.");
					return;
				}
			}
			
			
		//}
	}
}

 /**
  * btn_AddRow()
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
 function getAutoDtl(strAutoItemCd) {
	var goTo       = "getAutoDtl" ;    
    var action     = "O";     
    var parameters = "&strAutoItemCd="+encodeURIComponent(strAutoItemCd);
    
    TR_SUB.Action="/mss/mren111.mr?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_SUB.Post();
    
 // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}
 
 /**
  * getAutoDtl()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 자동배부된 점을 가져온다.
  * return값 :
  */
 function getAutoStrCd(strAutoItemCd) {
     
    if (strAutoItemCd == "") {
        showMessage(StopSign, OK, "USER-1000","배부항목이 선택 되있어야 합니다.");
        return;
    }
	
    var goTo       = "getAutoStrCd" ;    
    var action     = "O";     
    var parameters = "&strAutoItemCd="+strAutoItemCd;
    
    TR_SUB.Action="/mss/mren111.mr?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_IO_AUTO_STRCD=DS_IO_AUTO_STRCD)"; //조회는 O
    TR_SUB.Post();
 
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
      
        var strDivItem = DS_IO_MASTER.NameValue(i, "DIV_ITEM_CD");
        var intDivRate = DS_IO_MASTER.NameValue(i, "DIV_RATE");
        
        if(strDivItem.length <= 0){
            showMessage(INFORMATION, OK, "USER-1003", "배부항목");
            GD_MASTER.SetColumn("DIV_ITEM_NM"); 
            DS_IO_MASTER.RowPosition = i;  
            return false;
        }
        
        if(intDivRate == 0){
            showMessage(INFORMATION, OK, "USER-1003", "총배부율");
            GD_MASTER.SetColumn("DIV_RATE");  
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
  
  //디테일체크
  var intRowCount1 = DS_IO_DETAIL.CountRow;
  if(intRowCount1 > 0){
      for(var i=1; i <= intRowCount1; i++){
      
        var strCd = DS_IO_DETAIL.NameValue(i, "STR_CD");
        var intRate = DS_IO_DETAIL.NameValue(i, "DIV_RATE");
        
        if(strCd.length <= 0){
            showMessage(INFORMATION, OK, "USER-1003", "시설구분");
            GD_DETAIL.SetColumn("STR_CD"); 
            DS_IO_DETAIL.RowPosition = i;  
            return false;
        }
        
        if(intRate == 0){
            showMessage(INFORMATION, OK, "USER-1003", "배부율");
            GD_DETAIL.SetColumn("DIV_RATE");  
            DS_IO_DETAIL.RowPosition = i;  
            return false;
        }
        
        // 중복체크
        var dupRow = checkDupKey(DS_IO_DETAIL, "STR_CD");
        if (dupRow > 0) {
            showMessage(StopSign, Ok,  "USER-1044", "시설구분" + dupRow);
            
            DS_IO_DETAIL.RowPosition = dupRow;
            GD_DETAIL.SetColumn("STR_CD");
            GD_DETAIL.Focus(); 

            return false;
        }
     }
  }
  
  return true; 
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
    var strAutoItemCd = DS_IO_MASTER.NameValue(row, "DIV_ITEM_CD");
    
  //마스터의 배부 항목별 점을 가져온다.
    var sysStatus = DS_IO_MASTER.SysStatus(row);
    
    if (sysStatus == 0) {
    	//배부 항목 점을 가져온다.
        getAutoStrCd(strAutoItemCd);
    }
    
    // 디테일 조회
    getAutoDtl(strAutoItemCd);
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

<script language=JavaScript for=GD_DETAIL event=OnListSelect(index)>

   var strCd = DS_IO_AUTO_STRCD.NameValue(index, "CODE");
   var strAutoItemCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DIV_ITEM_CD");
   
   //자동배부항목 등록된 점별 관리비 항목 조회
   var goTo       = "getAutoItemCd" ;    
   var action     = "O";     
   var parameters = "&strCd="+strCd
                  + "&strAutoItemCd="+encodeURIComponent(strAutoItemCd);
   
   TR_SUB.Action="/mss/mren111.mr?goTo="+goTo+parameters;  
   TR_SUB.KeyValue="SERVLET("+action+":DS_IO_AUTO_ITEMCD=DS_IO_AUTO_ITEMCD)"; //조회는 O
   TR_SUB.Post();
   
   if (DS_IO_AUTO_ITEMCD.CountRow == 0) {
	   showMessage(StopSign, OK, "USER-1000","해당 시설에 등록된 관리비 항목이 없습니다.");
       return;  
   } else {
	   
	   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD") = strCd;
	   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MNTN_ITEM_CD") = DS_IO_AUTO_ITEMCD.NameValue(1,"MNTN_ITEM_CD");
	   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MNTN_ITEM_NM") = DS_IO_AUTO_ITEMCD.NameValue(1,"MNTN_ITEM_NM");
	   DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"DIV_ITEM_CD") = DS_IO_AUTO_ITEMCD.NameValue(1,"AUTO_DIV_ITEM");
	   
   }

</script>

<script language="javascript"  for=GD_DETAIL event=CanColumnPosChange(Row,Colid)>

if (Colid == "DIV_RATE") {
	
	var intRowCount = DS_IO_DETAIL.CountRow;
    var intDivRate = 0;
	
	for(var i=1; i <= intRowCount; i++){
		intDivRate = intDivRate + DS_IO_DETAIL.NameValue(i,"DIV_RATE");
	}
	
	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"DIV_RATE") < intDivRate) {
		showMessage(EXCLAMATION , OK, "USER-1000", "총배부율 안에 입력 해야 합니다.");
		return false;
	} else {
		return true;
	}
	
	intDivRate = 0;
	
}

</script>

<script language="javascript"  for=GD_MASTER event=CanColumnPosChange(Row,Colid)>

if (Colid == "DIV_RATE") {
    var intDivRate = DS_IO_MASTER.NameValue(Row,"DIV_RATE");

    if (intDivRate >  100) {
    	showMessage(EXCLAMATION , OK, "USER-1000", "100% 이하로 입력 해야 합니다.");
        return false;
    } else {
    	return true;
    }
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
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title">
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 시설별 배부율</td>
								<td class="right"><img id="IMG_ADD_ROW"
									onclick="btn_AddRow();" src="/<%=dir%>/imgs/btn/add_row.gif"
									width="52" height="18" hspace="2" /> <img id="IMG_DEL_ROW"
									onclick="btn_DeleteRow();" src="/<%=dir%>/imgs/btn/del_row.gif"
									width="52" height="18" /></td>
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
									width=100% height=479 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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

