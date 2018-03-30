<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 마감관리
 * 작 성 일 : 2010.05.20
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 마감을 관리한다.
 * 이    력 :
 *        2010.05.20 (이재득) 작성
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
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var strFlag = "";
var btnSaveClick = false;
var strToday = '<%=Util.getToday("yyyyMMdd")%>'

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');    
    //그리드 초기화
    gridCreate1(); //마스터
    //gridCreate2(); //디테일
    
    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_O_STK_YM, "YYYYMM",  NORMAL); //실사년월

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)   
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_I_STK_FLAG", "D", "P801", "N");

    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");
    getStore("DS_I_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk213","DS_IO_MASTER" );       
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"               width=30    align=center    edit="none"</FC>'
                     + '<FC>id=CHECK1        name="*마감"            width=40    align=center   HeadCheckShow=false EditStyle=CheckBox  edit={IF(SRVY_E_DT <"'+getTodayFormat("YYYYMMDD")+'" , "false", "true" )}</FC>'
                     + '<FC>id=CONF_CHECK    name="집계;여부"        width=40    align=center   HeadCheckShow=false EditStyle=CheckBox  edit=none</FC>'
                     + '<FC>id=STR_CD        name="점"              width=80    align=left     edit=none   EditStyle=Lookup   Data="DS_I_STR_CD:CODE:NAME"</FC>'                     
                     + '<FC>id=STK_YM        name="실사년월"         width=80    align=center   edit=none  Mask="XXXX/XX"</FC>'
                     + '<FC>id=STK_FLAG      name="구분"             width=60   align=left     edit=none  EditStyle=Lookup   Data="DS_I_STK_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=SRVY_DT       name="실사일자"         width=100   align=center  EditStyle=Popup  edit=none  Mask="XXXX/XX/XX"</FC>'
                     + '<FG>                 name="실사입력기간"'
                     + '<FC>id=SRVY_S_DT     name="시작일"            width=100    align=center     edit=none  Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=SRVY_E_DT     name="종료일"            width=100    align=center     edit=none  Mask="XXXX/XX/XX"</FC>'
                     + '</FG>'
                     + '<FC>id=CLOSE_DT      name="*마감일자"          width=100    align=center     EditStyle=Popup  edit={if(SRVY_E_DT <"'+getTodayFormat("YYYYMMDD")+'" , "false", if(CHECK1 == "T" AND Status = "N", "false","true") )} Edit=Numeric      Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=CLOSE_ID      name="마감자ID"          width=100    align=center     show="false"</FC>' 
                     + '<FC>id=CLOSE_NAME    name="마감자명"          width=100    align=center     EditStyle=PopupFix edit={if(SRVY_E_DT <"'+getTodayFormat("YYYYMMDD")+'" , "false", if(CHECK1 == "T" AND Status = "N", "false","true") )}</FC>'
                     + '<FC>id=TODAY_DT      name="SYSTEM일자"        width=100    align=center     Mask="XXXX/XX/XX" show="false"</FC>'
                     ;
                     
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
 * 작 성 일 : 2010.03.31
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
     
     //저장되지 않은 내용이 있을경우 경고
     if (DS_IO_MASTER.IsUpdated ) {
         ret = showMessage(QUESTION , YESNO, "USER-1059");
         if (ret != "1") {
             return false;
         } 
     } 
     
    if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }
    DS_IO_MASTER.ClearData();    

    var strStrCd   = LC_O_STR_CD.BindColVal;
    
    var strStkYm   = EM_O_STK_YM.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm);    
    
    TR_MAIN.Action="/dps/pstk213.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);
    setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
   
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.31
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
	// 확정할 데이터 없는 경우
    if ( !DS_IO_MASTER.IsUpdated ){
        //확정할 데이터를 선택하세요
        showMessage(INFORMATION, OK, "USER-1090");
        if( DS_IO_MASTER.CountRow < 1){            
            return;
        }           
        GD_MASTER.Focus();
        return;
    }
    var strMagamFlag = "";
  //DS_IO_MASTER.DeleteMarked();
    for( var i=1; i<=DS_IO_MASTER.CountRow; i++){
        var strConfDt     = DS_IO_MASTER.NameValue(i, "CLOSE_DT");  
        var strSrvyDt     = DS_IO_MASTER.NameValue(i, "SRVY_DT");
        var strCheck      = DS_IO_MASTER.NameValue(i, "CHECK1");  
        var strOrgCheck   = DS_IO_MASTER.OrgNameValue(i, "CHECK1");
        var strOrgCloseDt = DS_IO_MASTER.OrgNameValue(i, "CLOSE_DT");
        var strSrvyDt     = DS_IO_MASTER.NameValue(i, "SRVY_DT"); 
        var strTodayDt    = DS_IO_MASTER.NameValue(i, "TODAY_DT");
        var strConfCheck  = DS_IO_MASTER.NameValue(i, "CONF_CHECK");

        if (DS_IO_MASTER.NameValue(i, "CHECK1") == 'T') { //MARIO OUTLET ADD
	        if (strConfDt == "" && strCheck == "T"){
	            showMessage(EXCLAMATION, Ok,  "USER-1003", "마감일자");            
	            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CLOSE_DT");
	            return;
	        }else if(strCheck == "F" && DS_IO_MASTER.IsUpdated && strConfDt != ""){
	            showMessage(EXCLAMATION, Ok,  "USER-1041", "마감 체크 여부");            
	            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CHECK1");
	            return;
	        }
	        
	        if(strSrvyDt > strTodayDt && strCheck == "T"){
	        	showMessage(EXCLAMATION, Ok,  "GAUCE-1000", "재고조사 후 마감처리 가능 합니다.");            
	            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CHECK1");
	            return;
	        }
	        
	        if(strConfDt < strSrvyDt && strCheck == "T"){
	        	showMessage(EXCLAMATION, Ok,  "USER-1008", "마감일자", "실사재고일자");            
	            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CHECK1");
	            return;
	        }
	        
	        if(strConfCheck == "F"){
	            showMessage(EXCLAMATION, Ok,  "USER-1041", "집계 여부");            
	            setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"CONF_CHECK");
	            return;
	        }
	        
	        
	        if(strCheck == "T" && strConfDt != "" && strOrgCloseDt == "")
	            strMagamFlag = "0";
	        else if(strCheck == "F" && strConfDt == "" && strOrgCloseDt != "")
	            strMagamFlag = "1";       
        }
    }    
    
    //var strStkDt = DS_O_SRVY_DT.NameValue(1, "SRVY_DT");
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        LC_O_STR_CD.Focus();
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "GAUCE-1000", "마감(마감취소)하시겠습니까?") != 1 ){
        GD_MASTER.Focus();
        return;
    }    
    
    var parameters = "&strMagamFlag="+encodeURIComponent(strMagamFlag); 
    
    TR_MAIN.Action="/dps/pstk213.pt?goTo=conf"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

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

<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER
    event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(STOPSIGN, OK, "GAUCE-1007", row);
} else {
    showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!this.Modified)
        return;
    if (this.Text.length > 4){
        if(!checkDateTypeYM(this)){
            this.Text = '';
            return;
        }  
    }
    
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)> 
    if(row < 1)
        return true;
    
    var strUserId = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
    var strUserNm = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
    switch(colid){
    case "CLOSE_DT":       
        if (DS_IO_MASTER.NameValue(row, "CLOSE_DT") == ""){ 
            DS_IO_MASTER.NameValue(row, "CLOSE_ID") = "";
            DS_IO_MASTER.NameValue(row, "CLOSE_NAME") = "";
            return true;  
        }else{
            DS_IO_MASTER.NameValue(row, "CLOSE_ID") = strUserId;
            DS_IO_MASTER.NameValue(row, "CLOSE_NAME") = strUserNm;
            return true; 
        }       
            
        if(!checkDateTypeYMD(GD_MASTER,colid,''))           
            return false;
        
        break;
    case "CHECK1":        
        if( DS_IO_MASTER.NameValue(row,colid) =="T"){            
            DS_IO_MASTER.NameValue(row,"CLOSE_DT") = getTodayFormat("YYYYMMDD");
        }else
          	DS_IO_MASTER.NameValue(row,"CLOSE_DT") = "";
        break;
       
        /*
    case "CLOSE_NAME": 
    	
        var value = DS_IO_MASTER.NameValue(row,"CLOSE_ID");         
        
        setNmToDataSet('DS_SEARCH_NAME', 'SEL_USR_MST', value);
        if(DS_SEARCH_NAME.CountRow == 1){
            DS_IO_MASTER.NameValue(row,"CLOSE_ID")   = DS_SEARCH_NAME.NameValue(1,"CODE_CD");
            DS_IO_MASTER.NameValue(row,"CLOSE_NAME") = DS_SEARCH_NAME.NameValue(1,"CODE_NM");
            return;
        } 
        rtnMap = commonPopToGrid('사원','SEL_USR_MST_TEST', value);
        if( rtnMap.size() > 0){
            DS_IO_MASTER.NameValue(row,"CLOSE_ID")   = rtnMap.get("CODE_CD");
            DS_IO_MASTER.NameValue(row,"CLOSE_NAME") = rtnMap.get("CODE_NM");
            return;
        }
        if( DS_IO_MASTER.NameValue(row,"CLOSE_NAME") == ""){
            DS_IO_MASTER.NameValue(row,"CLOSE_ID")   = "";
        }
        break;
    	*/
    }
</script>



<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) {
    case "CLOSE_DT":  
        openCal(GD_MASTER, row, colid, "G");   //그리드 달력    
        break;
    case "CLOSE_NAME":
    	var rtnVal = commonPopToGrid('사원','SEL_USR_MST_TEST',DS_IO_MASTER.NameValue(row,"CLOSE_ID"));
        if( rtnVal.size() > 1){
            eval(this.DataID).NameValue(row,"CLOSE_ID") = rtnVal.get("CODE_CD");
            eval(this.DataID).NameValue(row,colid) = rtnVal.get("CODE_NM");
            return;
        }
        if( DS_IO_MASTER.NameValue(row, colid) == ""){
            DS_IO_MASTER.NameValue(row,"CLOSE_ID")   = "";
        }
        break;
    } 
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STK_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_OVERLAP" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NAME" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
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
                        <th width="80" class="point">점</th>
                        <td width="165"><comment id="_NSID_"> <object id=LC_O_STR_CD
                            classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="80">실사년월</th>
                        <td colspan = "3"><comment id="_NSID_"> <object
                            id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%> width=138 tabindex=1
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                            onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>
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
        <td class="PT05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"><object id=GD_MASTER
                    width="100%" height=497 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_MASTER">
                </object></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BO_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c></c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

