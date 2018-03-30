<!-- 
 * 시스템명 : EMAIL 보내기 테스트
 * 작 성 일 : 2010.03.30
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dctm4320.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.03.30 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
     
        
  
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
    type="text/javascript"></script>
<script type="text/javascript" src="/<%=dir%>/js/HuskyEZCreator.js" ></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 300;		//해당화면의 동적그리드top위치
 var	today	 = new Date();
 var	old_Row	= 0;
 var	searchChk =	"";

 // 오늘	일자 셋팅 
 var	now	= new Date();
 var	mon	= now.getMonth()+1;
 if(mon < 10)mon	= "0" +	mon;
 var	day	= now.getDate();
 if(day < 10)day	= "0" +	day;
 var	varToday = now.getYear().toString()+ mon + day;
 var	varToMon = now.getYear().toString()+ mon;
 var bfListRowPosition = 0;                             // 이전 List Row Position
 
function doInit(){
	 
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    DS_SEND.setDataHeader('<gauce:dataset name="H_SEND"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터
    
    initEmEdit(EM_SALE_DT_S,					"YYYYMMDD",				PK);	//매출일자
	EM_SALE_DT_S.alignment = 1;
	
	initEmEdit(EM_SALE_DT_E,					"YYYYMMDD",				PK);	//대비일자1(2011.08.27 MARIO OUTLET)
	EM_SALE_DT_E.alignment = 1;
	
	EM_SALE_DT_S.text  = varToMon+"01"; //매출일자 당일 
	EM_SALE_DT_E.text  = varToday; //매출일자 당일
    //화면OPEN시 조회
    //btn_Search();
}





function gridCreate1(){
    var hdrProperies = '<FC>id=SEQ         name="SEQ"        width=30   align=left show=false</FC>' 
    				 + '<FC>id=GUBUN       name="발송구분"   	 width=60   align=center	EditStyle=Combo	edit=true	Data="01:전체발송,02:직접입력,03:브랜드" Edit={IF(STAT_FLAG="0","true","false")}</FC>'
    				 + '<FC>id=SEND_DT     name="발송일자"   width=80   align=center	EditStyle=Popup Edit=Numeric Mask="XXXX/XX/XX" Edit={IF(STAT_FLAG="0","true","false")}</FC>'
                     + '<FC>id=TITLE       name="제목"       width=160  align=left	edit=true Edit={IF(STAT_FLAG="0","true","false")}</FC>'
                     + '<FC>id=CONTENTS    name="내용"       width=160  align=left	show=false</FC>'
                     + '<FC>id=STAT_FLAG   name="상태"       width=60   align=left	edit=none EditStyle=Combo Data="0:발송전,1:발송중,2:발송완료,3:오류"</FC>'
                     + '<FC>id=TOTAL_CNT   name="총발송수"   width=60   align=right	edit=none</FC>'
                     + '<FC>id=SUCCESS_CNT name="발송완료"   width=60   align=right edit=none</FC>'
                     + '<FC>id=FAIL_CNT    name="발송실패"   width=60   align=right	edit=none</FC>'
					;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies = '<FC>id=SEQ         name="SEQ"        width=30   align=left show=false</FC>' 
    				 + '<FC>id=SEQ_NO      name="NO"     	 width=30   align=RIGHT</FC>'
    				 + '<FC>id=EMAIL       name="EMAIL"      width=300  align=left EditStyle=none Edit={IF(STAT_FLAG="0","true","false")}</FC>'
    				 + '<FC>id=STAT_FLAG   name="STAT_FLAG"  width=30   align=left EditStyle=none show=false</FC>'
    				 ;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
}

 
function doClick(row){
	
	//초기화
	oEditors.getById["content"].exec("SET_IR", [""]);
    	
    if( row == undefined ) 
         row = DS_IO_MASTER.RowPosition;
    
    var sHTML = DS_IO_MASTER.NameValue(row ,"CONTENTS");
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	
    
    
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 
	DS_IO_MASTER.ClearData();
	DS_IO_DETAIL.ClearData();
	
	var strFlag = "";
	bfListRowPosition = 0;
	
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strS_DT=" + encodeURIComponent(EM_SALE_DT_S.text)
    				+ "&strE_DT=" + encodeURIComponent(EM_SALE_DT_E.text)
    					;
    
    TR_MAIN.Action  = "/dcs/dctm435.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);  
        
    
}

function search_detail() {

	//데이터 초기화
	DS_IO_DETAIL.ClearData();
	
    var strseq		= "";
    
    
	    
    var goTo			= "searchdetail" ;    
    var action			= "O";     
    var parameters		= "&strseq="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SEQ"))
					    ;
	
    TR_DETAIL.Action="/dcs/dctm435.dm?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER); 
}

/**
 * btn_New()
 * 개    요 : 신규
 * return값 : void
 */

function btn_New() {

	DS_IO_MASTER.Addrow();
	DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SEND_DT") = varToday;
	DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STAT_FLAG") = "0";
	GD_MASTER.SetColumn("GUBUN");
    GD_MASTER.Focus();

}

/**
 * btn_Conf()
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

    
    
    
	if(DS_IO_MASTER.CountRow	== 0){
		  showMessage(INFORMATION, OK, "USER-1000","조회 후 실행하십시오.");
			return;
		}
    
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GUBUN") == "02" && DS_IO_DETAIL.countrow == 0) {
    	showMessage(INFORMATION, OK, "USER-1000","보낼대상자가 없습니다.");
    	return false;
    }
    
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STAT_FLAG") != "0" ) {
    	showMessage(INFORMATION, OK, "USER-1000","이미발송하였습니다.");
    	return false;
    }
    
    
	if( showMessage(QUESTION, YESNO, "USER-1000",DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TITLE")+"을 발송하시겠습니까?") != 1 ){
        return;
    }

    var goTo       = "send";
    
    
    var row = DS_IO_MASTER.RowPosition;
    
    var action     = "O";
    var parameters = "&strSEQ="      + DS_IO_MASTER.NameValue(row,"SEQ")
                   ;
    
    DS_SEND.DataID = "/dcs/dctm435.dm?goTo="+goTo+parameters;
    DS_SEND.Reset();
    
    showMessage(INFORMATION, OK, "USER-1000","발송요청하였습니다. \n 전체발송시간은 약 6시간정도 소요됩니다.");
    
    btn_Search();
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {

	 if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STAT_FLAG") != "0" ) {
	    	showMessage(INFORMATION, OK, "USER-1000","이미발송하였습니다.");
	    	return false;
	    }
	 
	//에디터내용 데이터셋에넣기
    var sHTML = oEditors.getById["content"].getIR();
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONTENTS") = sHTML;
	    
	    
	//구분값체크
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GUBUN") == ""){
    	showMessage(INFORMATION, OK, "USER-1000","발송구분을 입력하십시오.");
        GD_MASTER.SetColumn("GUBUN");  
        return false;
    }
	
    //제목체크
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TITLE") == ""){
    	showMessage(INFORMATION, OK, "USER-1000","제목을 입력하십시오.");
        GD_MASTER.SetColumn("TITLE");  
        return false;
    }

	if( !DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated){
        // 저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028"); 
        return;
    }
    
        
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    
    
    
   
    if(DS_IO_MASTER.IsUpdated) {
	    TR_MAIN.Action="/dcs/dctm435.dm?goTo=save";  
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
	    TR_MAIN.Post();
	    
	    
    } 
    if(DS_IO_DETAIL.IsUpdated) { 
    	
    	TR_DETAIL.Action="/dcs/dctm435.dm?goTo=savedetail";  
        TR_DETAIL.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
        TR_DETAIL.Post();	
    }
        
 
    if( TR_MAIN.ErrorCode == 0){
        btn_Search(); 
    }
 
    if( TR_DETAIL.ErrorCode == 0){
    	search_detail(); 
    }
	
	
    
}


/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2012-07-06
 * 개    요 : 삭제
 * return값 : void
 */
function btn_Delete() {
	// 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        return;
    }
    
	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
    
    TR_MAIN.Action="/dcs/dctm435.dm?goTo=delete";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    //트랜젝션이 다름
    TR_MAIN.Post();

    btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-30
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}



/**
 * btn_Add1()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010-09-08
 * 개    요 : 광역 그리드 Row추가
 * return값 : void
*/
function btn_Add1(){
	 
	 
	if(DS_IO_MASTER.CountRow	== 0){
	  showMessage(INFORMATION, OK, "USER-1000","조회 후 실행하십시오.");
		return;
	}
	
	if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STAT_FLAG") != "0" ) {
    	showMessage(INFORMATION, OK, "USER-1000","이미발송하였습니다.");
    	return false;
    }
	
	
	if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GUBUN") == "01"){
		    showMessage(INFORMATION, OK, "USER-1000","수신동의한 고객에 한하여 전체발송합니다.");
			return;
		} else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GUBUN") == "03") {
			showMessage(INFORMATION, OK, "USER-1000","브랜드정보에 등록된 이메일로 발송합니다.");
			return;
		}
	
	DS_IO_DETAIL.Addrow();

	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "SEQ") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"SEQ");		
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "SEQ_NO") = DS_IO_DETAIL.RowPosition;
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "STAT_FLAG") = "0";
	//DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "COMM_PART") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"COMM_CODE");	//구분코드
	//DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "INQR_ORDER") = "0";  	//순서
	//DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "USE_YN") = "T";  		//사용여부

	// 상세코드  포커스
	//setFocusGrid(GD_DETAIL,DS_IO_DETAIL, DS_IO_DETAIL.CountRow,  "COMM_CODE");
	
	GD_DETAIL.SetColumn("EMAIL");
    GD_DETAIL.Focus();
}

/**
* btn_Del1()
* 작 성 자 : 엄준석
* 작 성 일 : 2010-09-08
* 개    요 : 광역 그리드 Row 삭제
* return값 : void
*/
function btn_Del1(){
	
	
	if(DS_IO_MASTER.CountRow	== 0){
	  showMessage(INFORMATION, OK, "USER-1000","조회 후 실행하십시오.");
		return;
	}
	
	DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++)         
            DS_IO_MASTER.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++) DS_IO_MASTER.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);
        search_detail();
    }
</script>

<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
	
    switch(colid){
    
    case "SEND_DT":    	
    	openCal(GD_MASTER,row,colid,'D');
        break;
     
    
    }
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
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

<!-- GR_MASTER 데이터변경  -->
<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>

    if(row < 1)
        return true;
    
    switch(colid){
           
    case "SEND_DT":

        if(!checkDateTypeYMD(this,colid,'')){
            showMessage(EXCLAMATION, OK, "USER-1003", "발송일자");
            GD_MASTER.SetColumn("SEND_DT");
            GD_MASTER.Focus();
            return false;        	
        }else{
            return true;   
        }
        break;


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
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
			    <tr>
				<th class="point" width="150">발송일자</th>
										<td colspan="3"><comment id="_NSID_"> <object
												id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_S)"
											align="absmiddle" />~ <comment id="_NSID_"> <object
												id="EM_SALE_DT_E" classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_E)"
											align="absmiddle" /></td>
				</tr>
			</table>
			</tr>
		</table>
        </td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr valign="top">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr valign="top">
			<td width=600>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"> <object
								id=GD_MASTER width=100% height=200
								classid=<%=Util.CLSID_GRID%> tabindex=1>
								<param name="DataID" value="DS_IO_MASTER">
							</object> </comment>
							<script>_ws_(_NSID_);</script>
						</td><td></td>
					</tr>
				</table>
			</td>
			<td ROWSPAN=3>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><textarea name="content" id="content" rows="38" style="width:100%;"> </textarea>
						</td><td></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="10">
			<td class="PB01 PT01" align="right" height="10"><img src="/<%=dir%>/imgs/btn/add_row.gif"  class="PR03" onclick="javascript:btn_Add1();" />
				<img src="/<%=dir%>/imgs/btn/del_row.gif"  class="PR03"  onclick="javascript:btn_Del1();" />
			</td>
		</tr>
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"> <object
								id=GD_DETAIL width=100% height=530
								classid=<%=Util.CLSID_GRID%> tabindex=1>
								<param name="DataID" value="DS_IO_DETAIL">
							</object> </comment>
							<script>_ws_(_NSID_);</script>
						</td><td></td>
					</tr>
				</table>
			</td>
		</tr>
		</table>
        
    </tr>
</table>
</div>


<script type="text/javascript">

	var oEditors = [];
	
		
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		//sSkinURI: "SmartEditor2Skin.html",
		sSkinURI: "http://127.0.0.1:8088/pot/SmartEditor2Skin.html",				//운영 로벌 아이피 구분해서 적용
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});

</script>



</body>
</html>
