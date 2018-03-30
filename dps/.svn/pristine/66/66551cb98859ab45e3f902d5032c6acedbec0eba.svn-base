<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 기타관리> 타임아웃관리
 * 작 성 일 : 2010.07.05
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcodA010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 타임아웃 정보를 관리한다
 * 이    력 :
 *        2010.07.05 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfStrCd;

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    //콤보 초기화 
    initComboStyle(LC_STR_CD         , DS_STR_CD         , "CODE^0^30,NAME^0^140" , 1, PK);      //점(조회)
    initComboStyle(LC_CLOSE_TASK_FLAG, DS_CLOSE_TASK_FLAG, "CODE^0^40,NAME^0^120", 1, NORMAL);  //마감업무구분(조회)
    initComboStyle(LC_CLOSE_FLAG     , DS_CLOSE_FLAG     , "CODE^0^30,NAME^0^130", 1, NORMAL);  //마감구분(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_CLOSE_TASK_FLAG"   , "D", "P097", "Y");
    getEtcCode("DS_CLOSE_FLAG"        , "D", "P098", "Y");
    getEtcCode("DS_CLOSE_TASK_FLAG_I" , "D", "P097", "N");
    getEtcCode("DS_CLOSE_FLAG_I"      , "D", "P098", "N");
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
        
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_CLOSE_TASK_FLAG,'%');
    setComboData(LC_CLOSE_FLAG     ,'%');
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcodA01","DS_MASTER" );
    
    bfStrCd = LC_STR_CD.BindColVal;
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=30   align=center edit=none     name="NO"                </FC>'
                     + '<FC>id=STR_CD          width=100  align=left   edit=none     name="*점"                EditStyle=Lookup data="DS_STR_CD:CODE:NAME" </FC>'
                     + '<FC>id=CLOSE_TASK_FLAG width=110  align=left                 name="*업무구분"          EditStyle=Lookup data="DS_CLOSE_TASK_FLAG_I:CODE:NAME" edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=CLOSE_UNIT_FLAG width=85   align=center edit=Numeric  name="*마감단위업무 "      edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=CLOSE_FLAG      width=75   align=left                 name="*마감구분 "          EditStyle=Lookup data="DS_CLOSE_FLAG_I:CODE:NAME" </FC>'
                     + '<FC>id=CLOSE_UNIT_NAME width=150  align=left                 name="*마감단위업무명 "    </FC>'
                     + '<FC>id=E_DAY           width=70   align=right                name="*종료일자 "          </FC>'
                     + '<FC>id=E_TIME          width=70   align=center edit=Numeric  name="*종료시간 "          mask="XX:XX"</FC>'
                     ////+ '<FC>id=SAP_CLOSE_FLAG  width=100  align=center edit=AlphaNum name="SAP마감구분 "       </FC>'
                     + '<FC>id=MCLOSE_PROC_YN  width=100  align=left                 name="월마감처리여부"     EditStyle=Combo data="Y:YES,N:NO"</FC>'
                     + '<FC>id=REMARK          width=700  align=left                 name="비고 "               </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
	//
    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
	
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    
    TR_MAIN.Action="/dps/pcodA01.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
    }
    GD_MASTER.Focus();

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
//
/**
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행추가
 * return값 : void
 */
function btn_addRow(){

    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    DS_MASTER.AddRow();
    var row = DS_MASTER.CountRow;
    DS_MASTER.NameValue(row,"STR_CD")     = LC_STR_CD.BindColVal;
    //DS_MASTER.NameValue(row,"CLOSE_FLAG") = "N";    
    
    setFocusGrid(GD_MASTER, DS_MASTER, row, "STR_CD");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
    var row  = DS_MASTER.RowPosition;
    if( DS_MASTER.RowStatus(row) != 1 ){
        showMessage(INFORMATION, OK, "USER-1052");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(row);
}

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  판매사원 리스트 조회
 * return값 : void
 */
function searchMaster(){
	 
    var strCd         = LC_STR_CD.BindColVal;
    var closeTaskFlag = LC_CLOSE_TASK_FLAG.BindColVal;
    var closeFlag     = LC_CLOSE_FLAG.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="		 +encodeURIComponent(strCd)
                   + "&strCloseTaskFlag="+encodeURIComponent(closeTaskFlag)
                   + "&strCloseFlag="	 +encodeURIComponent(closeFlag);
    TR_MAIN.Action="/dps/pcodA01.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 

/**
* checkHHMI(str)
* 작성자     : FKL
* 작성일자 : 2006-07-13
* 개요        : 존재하는 형식이 시분인지 Check 해서 
*          참이면 TRUE 아니면 FALSE를 리턴한다 
* return : true/false
*/
function checkHHMI(strTime) {
	strTime = getRawData(strTime);
	strTime = replaceStr(strTime," ", "");
	var strHour = "", strMinute = "";
	var intHour = 0, intMinute = 0;

	if (strTime.length != 4)
		return false;
	
	strHour   = strTime.substring(0,2);
	strMinute = strTime.substring(2,4);
    if(parseFloat(strHour)< 10)
    	strHour = "0" + parseFloat(trim(strHour));
	if(parseFloat(strMinute)< 10)
		strMinute = "0" + parseFloat(trim(strMinute));
	
	if (isNaN(strHour) || isNaN(strMinute) ) 
		return false;
	
	intHour   = parseInt(strHour,'10');
	intMinute = parseInt(strMinute,'10');
	
	if(intHour   > 23  && !(intHour == 24 && intMinute == 0) ) intHour   = -1;
	if(intMinute > 59 ) intMinute = -1;
	
	if( intHour   < 0 || intMinute < 0)
		return false;
	
	return true;
}

/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
    var row;
    var colid;
    var errYn = false;

    var dupRow = checkDupKey(DS_MASTER,"STR_CD||CLOSE_UNIT_FLAG");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_MASTER,DS_MASTER,dupRow,"CLOSE_UNIT_FLAG");
        return false;
    }
    
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"STR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            errYn = true;
            colid = "STR_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"CLOSE_TASK_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "업무구분");
            errYn = true;
            colid = "CLOSE_TASK_FLAG";
            break;
        }
        
        if( DS_MASTER.NameValue(i,"CLOSE_UNIT_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "마감단위업무");
            errYn = true;
            colid = "CLOSE_UNIT_FLAG";
            break;
        }

        if( replaceStr(DS_MASTER.NameValue(i,"CLOSE_UNIT_FLAG")," ","").length!=2){
            showMessage(EXCLAMATION, OK, "USER-1027", "마감단위업무",2);
            errYn = true;
            colid = "CLOSE_UNIT_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"CLOSE_UNIT_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "마감단위업무명");
            errYn = true;
            colid = "CLOSE_UNIT_NAME";
            break;
        }
        if( !checkInputByte( GD_MASTER, DS_MASTER, i, 'CLOSE_UNIT_NAME', '마감단위업무명')){
            errYn = true;
            colid = "CLOSE_UNIT_NAME";
            break;
        }
        /*
        if( DS_MASTER.NameValue(i,"SAP_CLOSE_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "SAP마감구분");
            errYn = true;
            colid = "SAP_CLOSE_FLAG";
            break;
        }
        */
        if( DS_MASTER.NameValue(i,"CLOSE_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "마감구분");
            errYn = true;
            colid = "CLOSE_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"E_DAY") > 0){
            showMessage(EXCLAMATION, OK, "USER-1021", "종료일자", 0);
            errYn = true;
            colid = "E_DAY";
            break;
        }
        if( DS_MASTER.NameValue(i,"E_TIME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "종료시간");
            errYn = true;
            colid = "E_TIME";
            break;
        }
        if( !checkHHMI(DS_MASTER.NameValue(i,"E_TIME"))){
            showMessage(INFORMATION, OK, "USER-1000", "유효하지 않는 시간형식 입니다.");
            errYn = true;
            colid = "E_TIME";
            break;
        }
        
        if( !checkInputByte( GD_MASTER, DS_MASTER, i, "REMARK", "비고") )
            return false;
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
}

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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
    	if( colid == "STR_CD"){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
    	}else{
            showMessage(EXCLAMATION, OK, "USER-1003", "마감단위업무");
    	}
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 ){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'E_TIME':
        	
            if( !checkHHMI(value) && value != "" ){
                showMessage(INFORMATION, OK, "USER-1000", "유효하지 않는 시간형식 입니다.");
                DS_MASTER.NameValue(row,colid) = olddata;
            }
            break;
    
    }
</script> 
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd != this.BindColVal){
        if( DS_MASTER.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_MASTER.ClearData();
    }
    bfStrCd = this.BindColVal;
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

<!-- =============== Input용 -->
<!-- 검색용 -->
    
<comment id="_NSID_"><object id="DS_STR_CD"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_TASK_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_CLOSE_TASK_FLAG_I"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_FLAG_I"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="160">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">업무구분</th>
            <td width="160">
               <comment id="_NSID_">
                 <object id=LC_CLOSE_TASK_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1  align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">마감구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_CLOSE_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="right PB03"><img 
               src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img 
               src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();"  /></td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=486 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

