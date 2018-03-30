<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 포인트운영 > 특별포인트적립기준
 * 작 성 일    : 2012.06.05
 * 작 성 자    : 강진
 * 수 정 자    : 
 * 파 일 명    : dmbo6320.jsp
 * 버    전       : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가) 
 * 개    요       : 
 * 이    력       :
 *           2012.06.05 (강진) 신규작성
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
	String strToDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToDate = strToDate + "01";
%>
<script LANGUAGE="JavaScript"> 
<!--
var strChangFlag    = false;
var bfMasterRowPos = 0;       // 마스터조회여부
var LAST_MOD_ROW   = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    //Input,Output Data Set Header 초기화
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화    
    initEmEdit(EM_COND_DATE_F, 	"YYYYMMDD", 	PK);           	//조회일자 F
    //initEmEdit(EM_COND_DATE_F, 	"TODAY", 	PK);           	//조회일자 F
    initEmEdit(EM_COND_DATE_T, 	"TODAY", 		PK);           	//조회일자 T   
    initEmEdit(EM_BRCH_ID,     	"GEN^10",    	PK);
    initEmEdit(EM_BRCH_NAME,   	"GEN^40",    	READ);
    initEmEdit(EM_PLUS_POINT,	"NUMBER^9^0",	NORMAL);
    initEmEdit(EM_START_DT,    	"TODAY",        PK);   //-- 시작일자
    initEmEdit(EM_END_DT,      	"YYYYMMDD",     NORMAL);   //-- 종료일자
    
    initComboStyle(LC_COND_POINT_PLUS_GB, DS_COND_POINT_PLUS_GB, "CODE^0^30,NAME^0^100", 1, NORMAL);    //포인트구분(조회)
    initComboStyle(LC_POINT_PLUS_GB, DS_POINT_PLUS_GB, "CODE^0^30,NAME^0^100", 1, PK);    //포인트구분
 
    
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_COND_POINT_PLUS_GB", "D", "D116", "Y");
    getEtcCode("DS_POINT_PLUS_GB", "D", "D116", "N");

    //조회일자 초기값.
    //EM_COND_DATE_F.text = addDate("M", "-1", '<%=strToDate%>');  
    EM_COND_DATE_F.text = <%=strToDate%>;
    EM_END_DT.text = '99991231'; // 종료일자 초기화
    
    btn_Search()
    
    LC_POINT_PLUS_GB.Index = 0;
    LC_COND_POINT_PLUS_GB.Index=0;
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dmbo632","DS_O_MASTER,DS_IO_DETAIL"); 
}

function gridCreate1(){      
    var hdrProperies = '<FC>id={currow}        		name="NO"            		width=30    align=center</FC>'
			         + '<FC>id=BRCH_ID             	name="가맹점ID"         		width=100   align=left show=false</FC>'
			         + '<FC>id=BRCH_NAME           	name="가맹점명"         		width=100   align=left show=false</FC>'
                     + '<FC>id=POINT_PLUS_GB		name="특별포인트구분코드"		width=100   align=left show=false</FC>'
                     + '<FC>id=POINT_PLUS_GB_NM		name="특별포인트구분"   		width=100   align=left</FC>'
                     + '<FC>id=PLUS_POINT  			name="적립포인트"  			width=100   align=right</FC>'
                     + '<FC>id=START_DT        		name="적용시작일"  			width=100   align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=END_DT       		name="적용종료일"			width=100   align=center mask="XXXX/XX/XX"</FC>';
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
     (4) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
	    if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
	    	setTimeout("LC_POINT_PLUS_GB.Focus();",50);
	        return false;
        }else{
	        strChangFlag = true;
	    }
	}
	
	if(trim(EM_COND_DATE_F.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_COND_DATE_F.Focus();
        return;
    }else if(trim(EM_COND_DATE_T.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_COND_DATE_T.Focus();
        return;
    }else if(EM_COND_DATE_F.Text > EM_COND_DATE_T.Text){   // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_COND_DATE_F.Focus();
        return;
    }

    LAST_MOD_ROW = 0;
    
    showMaster();
}

/**
 * btn_New()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {
    if (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated){
	    if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
	        setTimeout("LC_POINT_PLUS_GB.Focus();",50);
	        return false;
	    }else{
	    	strChangFlag = true;
	        if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "POINT_PLUS_GB") == ""){
	        	alert(DS_O_MASTER.RowPosition);
	            DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
	        }
	    }
	}
    DS_O_MASTER.Addrow(); 
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    
    strChangFlag = false; 
    newData(true);

    LC_POINT_PLUS_GB.Index   	= -1;
    //EM_START_DT.text = '<%=strToDate%>'; // 시작일자 초기화
    //EM_END_DT.text = '99991231'; // 종료일자 초기화
    EM_BRCH_ID.Focus();
}

/**
 * btn_Save()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 특별포인트적립기준 저장
 * return값 : void
 */
function btn_Save() {
	 
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
    if(trim(EM_BRCH_ID.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "가맹점");
        EM_BRCH_ID.Focus();
        return false;
    }    
	if(trim(LC_POINT_PLUS_GB.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1002",  "포인트구분");
        LC_POINT_PLUS_GB.Focus();
        return;
    }
    if(trim(EM_START_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_START_DT.Focus();
        return false;
    }
    
    if(trim(EM_END_DT.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_END_DT.Focus();
        return false;
    }	

    if(EM_START_DT.text > EM_END_DT.text){   // 시작일자<=종료일자 정합성체크
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_END_DT.Focus();
        return false;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }

	saveDetail();

}

/**
 * btn_Excel()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 특별포인트적립기준 리스트 조회 
 * return값 : void
 */
function showMaster(){
    var strMemoDateF 	= EM_COND_DATE_F.Text;
    var strMemoDateT 	= EM_COND_DATE_T.Text;
    var strPointPlusGb  = LC_COND_POINT_PLUS_GB.BindColVal;

	DS_O_MASTER.ClearData();
	bfMasterRowPos = 0;
	
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strMemoDateF=" + encodeURIComponent(strMemoDateF)
                    + "&strMemoDateT=" + encodeURIComponent(strMemoDateT)
                    + "&strPointPlusGb="+ encodeURIComponent(strPointPlusGb);
    TR_MAIN.Action  = "/dcs/dmbo632.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post(); 

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    DS_O_MASTER.RowPosition = LAST_MOD_ROW>0?LAST_MOD_ROW : DS_O_MASTER.RowPosition;   
}

/**
 * showDetail()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 선택된 특별포인트적립기준 정보 상세 조회 
 * return값 : void
 */
function showDetail(){
	 
	var row = row = DS_O_MASTER.RowPosition;

	if(row == 0){
		DS_O_MASTER.ClearData();
		return;
	}	 

    var strBrchId   = DS_O_MASTER.NameValue(row ,"BRCH_ID");
    var strPointPlusGb = DS_O_MASTER.NameValue(row ,"POINT_PLUS_GB");
    var strMemoDateF = DS_O_MASTER.NameValue(row ,"START_DT");
    
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strBrchId="    		+ encodeURIComponent(strBrchId)
    				+ "&strPointPlusGb="  	+ encodeURIComponent(strPointPlusGb)
                    + "&strMemoDateF=" 		+ encodeURIComponent(strMemoDateF);
    TR_DETAIL.Action  = "/dcs/dmbo632.do?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
}

/**
 * saveDetail()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요     : 특별포인트적립기준 저장
 * return값 : void
 */
function saveDetail(){
    var goTo        = "save";
    var action      = "I";  //조회는 O, 저장은 I
    
    if(DS_O_MASTER.RowPosition != 0){
        LAST_MOD_ROW = DS_O_MASTER.RowPosition;
    }
    
    TR_MAIN.Action  ="/dcs/dmbo632.do?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_MAIN.Post();
    
    showMaster();
 }
 
/**
 * newData()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.06.05
 * 개       요    :
 * return값 : void
 */
function newData(flag) {
    EM_BRCH_ID.Enable   		= flag;
    LC_POINT_PLUS_GB.Enable	 	= flag;
    EM_START_DT.Enable 			= flag;
    EM_PLUS_POINT.Enable		= flag;
    enableControl(IMG_BRCH_ID, flag);  	
}  
 
/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID,EM_BRCH_NAME);
            }
        }
    }
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
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
    
    newData(false);   
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
    if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("LC_POINT_PLUS_GB.Focus();",50);
            return false;
        }else {
        	if(DS_O_MASTER.NameValue(row, "POINT_PLUS_GB") == "")
        	    DS_O_MASTER.DeleteRow(row);
            return true;
        }
    }else{
    	 return true;
    }
</script>
<!--DS_O_MASTER  OnRowPosChanged(row)(row,colid)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;
    
	if( row < 1 || bfMasterRowPos == row)
    	return;
	
	bfMasterRowPos = row;
	
	showDetail();  
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_COND_DATE_F event=onKillFocus()>
    if(!checkDateTypeYMD(EM_COND_DATE_F)){
    	EM_COND_DATE_F.Text = addDate("M", "-1", '<%=strToDate%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_COND_DATE_T event=onKillFocus()>
    if(!checkDateTypeYMD(EM_COND_DATE_T)){
        initEmEdit(EM_COND_DATE_T,    "TODAY",     PK);         
    }
</script>

<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=EM_START_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    var toDate = getTodayFormat('YYYYMMDD');
    if( !checkDateTypeYMD(this,toDate,"GR_MASTER","EM_START_DT"))
        return;
    //var appSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_START_DT");
    var appEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT");
    //var toDate = getTodayFormat('YYYYMMDD');
    //var yesterDay = getRawData(addDate('D',-1,getTodayFormat('YYYYMMDD')));
    if( toDate > this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        showMessage(EXCLAMATION, OK, "USER-1000", "시작일자는 오늘 이후 일자만 가능 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = toDate;
        return;
    }
    if( appEDt < this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 시작일자 보다 크거나 같아야 (시작일자 <= 종료일자) 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = toDate;
        return;
    }
</script>	

<script language=JavaScript for=EM_END_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if( !checkDateTypeYMD(this,'99991231',"GR_MASTER","EM_END_DT"))
        return;
    var appSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_START_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    var yesterDay = getRawData(addDate('D',-1,getTodayFormat('YYYYMMDD')));
    if( yesterDay > this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 어제 이후 일자만 가능 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = "99991231";
        return;
    }
    if( appSDt > this.Text){
        //showMessage(EXCLAMATION, OK,"USER-1008","적용종료일","적용시작일");
        showMessage(EXCLAMATION, OK, "USER-1000", "종료일자는 시작일자 보다 크거나 같아야 (시작일자 <= 종료일자) 합니다.");
        //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EM_END_DT") = "99991231";
        this.Text = "99991231";
        return;
    }
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
<!-- =============== 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_POINT_PLUS_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_COND_POINT_PLUS_GB" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Input,Output용  -->
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">조회기간</th>
						<td><comment id="_NSID_"> <object
							id=EM_COND_DATE_F classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_COND_DATE_F)" />- <comment
							id="_NSID_"> <object id=EM_COND_DATE_T
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_COND_DATE_T)" /></td>
			            <th width="80">포인트구분</th>
			            <td width="340"><comment id="_NSID_"> <object
		                    id=LC_COND_POINT_PLUS_GB classid=<%=Util.CLSID_LUXECOMBO%> height=100
		                    width=155 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=294 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01">
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="s_table">
            <tr>
                <th width="100" class="point">가맹점</th>
                <td colspan="3" width="200"><comment id="_NSID_"> <object
							id=EM_BRCH_ID classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							onKeyUp="javascript:keyPressEvent(event.keyCode);"> </object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_BRCH_ID"
							align="absmiddle" onclick="getBrchPop(EM_BRCH_ID,EM_BRCH_NAME)" />
							<comment id="_NSID_"> <object id=EM_BRCH_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
				</td>
            </tr>
            <tr>
                <th width="100" class="point">특별포인트구분</th>
                <td width="200"><comment id="_NSID_"> <object
		                    id=LC_POINT_PLUS_GB classid=<%=Util.CLSID_LUXECOMBO%> height=100
		                    width=155 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
				</td>
                <th width="100">적립포인트</th>
                <td><comment id="_NSID_"> <object
							id=EM_PLUS_POINT classid=<%=Util.CLSID_EMEDIT%> width=160
							tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                </td>
            </tr>	            			
            <tr>
               <th width="100" class="point">시작일자</th>
                   <td><comment id="_NSID_"> <object
                        id=EM_START_DT classid=<%=Util.CLSID_EMEDIT%> width=138 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                        onclick="javascript:openCal('G',EM_START_DT)" />
                    </td> 
                 <th width="100" class="point">종료일자</th>
                   <td colspan="3"><comment id="_NSID_"> <object
                        id=EM_END_DT classid=<%=Util.CLSID_EMEDIT%> width=138 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                        onclick="javascript:openCal('G',EM_END_DT)" />
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
<object id=BD_DETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=BRCH_ID          ctrl=EM_BRCH_ID          Param=Text</c>
            <c>col=BRCH_NAME        ctrl=EM_BRCH_NAME        Param=Text</c> 
            <c>col=POINT_PLUS_GB    ctrl=LC_POINT_PLUS_GB    Param=BindColVal</c>
            <c>col=PLUS_POINT       ctrl=EM_PLUS_POINT     	 Param=Text</c>
            <c>col=START_DT         ctrl=EM_START_DT         Param=Text</c>
            <c>col=END_DT           ctrl=EM_END_DT           Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
