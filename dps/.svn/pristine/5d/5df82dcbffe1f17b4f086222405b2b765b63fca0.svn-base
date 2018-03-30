<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 기타관리> EOD로그조회
 * 작 성 일 : 2010.08.04
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : pcodA020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 기간의 EOD로그를 조회한다.
 * 이    력 :
 *        2010.08.04 (김경은) 신규작성
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
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfStrCd;
var strToday;
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-08-04
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	 
	strToday = getTodayDB("DS_O_RESULT");
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    //EM_EDIT초기화
    initEmEdit(EM_BLD_DT,  "YYYYMMDD", PK);             // EOD일자
    initEmEdit(EM_PROC_ID, "GEN"     , NORMAL);         // 프로세스
     
    //콤보 초기화 
    initComboStyle(LC_WK_FLAG , DS_WK_FLAG , "CODE^0^50,NAME^0^100", 1, NORMAL);  // 작업구분
    initComboStyle(LC_LOG_CD  , DS_LOG_CD  , "CODE^0^50,NAME^0^100", 1, NORMAL);  // 로그코드
    //initComboStyle(LC_PROC_ID , DS_PROC_ID , "CODE^0^0,NAME^0^320", 1, NORMAL);  // 프로세스코드

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_WK_FLAG"   , "D", "P102", "Y");
    getEtcCode("DS_LOG_CD"    , "D", "P103", "Y");
    //getProcId();
    //insComboData(LC_PROC_ID, "%", "전체",1);
    
    EM_BLD_DT.Text = addDate("d", -1, strToday);
    LC_WK_FLAG.Index = 0;
    LC_LOG_CD.Index  = 0;
    //LC_PROC_ID.Index = 0;
    EM_BLD_DT.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            width=30   align=center                name="NO"  Color={decode(LOG_CD,"ERR","red")}</FC>'
    	             + '<FG> name="프로세스"' 
                     + '<FC>id=COMM_NAME1          width=150  align=left                  name="ID"  Color={decode(LOG_CD,"ERR","red")} </FC>'
                     + '<FC>id=COMM_NAME2          width=200  align=left                  name="명"  Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '</FG>'
                     + '<FC>id=BLD_DT              width=80   align=center                name="생성일자"  mask="XXXX/XX/XX"  Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=BLD_TIME            width=70   align=center                name="생성시간"  mask="XX:XX:XX" Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=STR_NM              width=100  align=left                  name="점"       Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=WK_FLAG_NM          width=60   align=left                  name="작업구분" Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=LOG_NM              width=60   align=left                  name="로그코드 " Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=TRG_CNT             width=80   align=right                 name="대상건수 " Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=SKIP_CNT            width=80   align=right                 name="SKIP건수 " Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=EXE_CNT             width=80   align=right                 name="실행건수 " Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=ERR_CNT             width=80   align=right                 name="에러건수 " Color={decode(LOG_CD,"ERR","red")}</FC>'
                     + '<FC>id=CMPL_CNT            width=80   align=right                 name="완료건수 " Color={decode(LOG_CD,"ERR","red")}</FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
    if( EM_BLD_DT.TEXT == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "EOD일자");
        EM_BLD_DT.Focus();
        return;
    }
	
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    if(DS_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "EOD로그조회";

    var strBldDt      = EM_BLD_DT.Text;
    var strWkFlag     = LC_WK_FLAG.Text;
    var strLogCd      = LC_LOG_CD.Text;
    var strProcId     = "";
    if(EM_PROC_ID.Text != "")
    	strProcId = "전체";
    else
    	strProcId = EM_PROC_ID.Text;
    
    
    var parameters = "EOD일자 - "       + strBldDt
                   + " ,   작업구분 - " + strWkFlag
                   + " ,   로그코드 - " + strLogCd
                   + " ,   프로세스 - " + strProcId;
    
   // GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    openExcel2(GD_MASTER, strTitle, parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
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
 * searchMaster()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-08-04
 * 개    요 :  기간의 EOD로그를 조회한다.
 * return값 : void
 */
function searchMaster(){
	 
    var strBldDt      = EM_BLD_DT.Text;
    var strWkFlag     = LC_WK_FLAG.BindColVal;
    var strLogCd      = LC_LOG_CD.BindColVal;
    var strProcId     = EM_PROC_ID.Text;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strBldDt=" +encodeURIComponent(strBldDt)
                   + "&strWkFlag="+encodeURIComponent(strWkFlag)
                   + "&strLogCd=" +encodeURIComponent(strLogCd)
                   + "&strProcId="+encodeURIComponent(strProcId);
    TR_MAIN.Action="/dps/pcodA02.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 

/**
 * getProcId()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-02-18
 * 개    요 :  프로세스 공통코드 가져오기
 * return값 : void
 */
function getProcId(){
     
    var goTo       = "getProcId" ;    
    var action     = "O";  
    var parameters = "";
    TR_MAIN.Action="/dps/pcodA02.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_PROC_ID=DS_PROC_ID)"; //조회는 O
    TR_MAIN.Post();    
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
<!-- EOD일자 변경시  -->
<script lanaguage=JavaScript for=EM_BLD_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_BLD_DT, addDate("d", -1, strToday));
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
<comment id="_NSID_"><object id="DS_WK_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LOG_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PROC_ID"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>    
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
            <th width="80" class="point">EOD일자</th>
            <td width="160">
               <comment id="_NSID_"> 
                    <object id=EM_BLD_DT classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1 align="absmiddle"> </object> 
                </comment><script> _ws_(_NSID_);</script> 
                <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_BLD_DT onclick="javascript:openCal('G',EM_BLD_DT)" align="absmiddle" />
            </td>
            <th width="80">작업구분</th>
            <td width="160">
               <comment id="_NSID_">
                 <object id=LC_WK_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1  align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">로그코드</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_LOG_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="80">프로세스</th>
            <td colspan=5>
               <comment id="_NSID_">
                 <object id=EM_PROC_ID classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1 align="absmiddle"> </object>
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

