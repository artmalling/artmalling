<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 클럽관리 > 클럽코드 관리
 * 작 성 일 : 2010.05.19
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dctm1310.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.19 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var EXCEL_PARAMS = "";
var LAST_MOD_ROW = 0;
var strClubIdRow = "";
var strIsInsert = false;
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
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터      

    //-- 입력필드
    initEmEdit(EM_CLUB_ID,      "00",          PK);          
    initEmEdit(EM_CLUB_NAME,    "GEN^40",      PK);     
    initEmEdit(EM_CLUB_INFO,    "GEN^400",     PK);      
    
    //화면 OPEN시 조회
    btn_Search();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dctm131","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"           width=30      align=center</FC>'
                     + '<FC>id=CLUB_ID         name="클럽ID"       width=100     align=left</FC>'
                     + '<FC>id=CLUB_NAME       name="클럽명"       width=150     align=left</FC>'
                     + '<FC>id=CLUB_INFO       name="클럽설명"     width=490     align=left</FC>'
                     + '<FC>id=REG_DATE        name="REG_DATE"    width=0        show=false';
                     
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
          setTimeout("EM_CLUB_NAME.Focus();",50);
            return false;
        }else{
          strChangFlag = true;
        }
    }   
    
    var goTo        = "searchMaster";    
    var action      = "O";     
     
    TR_MAIN.Action  = "/dcs/dctm131.dm?goTo="+goTo;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
       
    	if (LAST_MOD_ROW > 0) {
    		if(strIsInsert == true){
                doClick(1);   
    		}else{
                doClick(LAST_MOD_ROW);   
                DS_O_MASTER.RowPosition = LAST_MOD_ROW;
                LAST_MOD_ROW = 0;
    		}
        } else {
            GD_MASTER.Focus();      
        }     
         
    }
    bfListRowPosition = 0;
}

/**
 * btn_New()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
            setTimeout("EM_CLUB_ID.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REG_DATE") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }
    strIsInsert = true;
    DS_O_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
    strChangFlag = false;

    initEmEdit(EM_CLUB_ID,      "00",       PK);
    EM_CLUB_ID.Text = "";
    EM_CLUB_ID.focus();
}
 

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     saveData();
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    var ExcelTitle = "클럽코드 관리"
    openExcel2(GD_MASTER, ExcelTitle, '', true );
}

 

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 클럽코드 관리 등록
 * return값 : void
 */
function saveData(){
     
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    }
          
   if (trim(EM_CLUB_ID.text).length == 0) {
       showMessage(EXCLAMATION, OK, "USER-1003",  "클럽ID");
       EM_CLUB_ID.Focus();
       return;
   } 
   
   if (trim(EM_CLUB_NAME.text).length == 0) {
       showMessage(EXCLAMATION, OK, "USER-1003",  "클럽명");
       EM_CLUB_NAME.Focus();
       return;
   } 
   
   if (trim(EM_CLUB_INFO.text).length == 0) {
       showMessage(EXCLAMATION, OK, "USER-1003",  "클럽설명");
       EM_CLUB_INFO.Focus();
       return;
   }    
   
   for(i = 0 ; i < DS_O_MASTER.CountRow ; i++){
	   if( strIsInsert == true && DS_O_MASTER.NameValue(i ,"CLUB_ID") == EM_CLUB_ID.Text){
	       showMessage(EXCLAMATION, OK, "USER-1000",  "이미 존재하는 클럽ID입니다.");
	       EM_CLUB_ID.Focus();
	       return;
	   }
   }

   if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
       return;
   }   
   
   strClubIdRow  = EM_CLUB_ID.Text;
   
   LAST_MOD_ROW = DS_O_MASTER.RowPosition;

   var goTo        = "saveData";
   var action      = "I";  //조회는 O
   TR_MAIN.Action  ="/dcs/dctm131.dm?goTo="+goTo;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
   TR_MAIN.Post();
   btn_Search();
   strIsInsert = false;
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

    var strClubId     = DS_O_MASTER.NameValue(row ,"CLUB_ID");
    
    var goTo          = "searchDetail";    
    var action        = "O";     
    var parameters    = "&strClubId=" + encodeURIComponent(strClubId);
    TR_DETAIL.Action  = "/dcs/dctm131.dm?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    initEmEdit(EM_CLUB_ID,      "GEN^2",       READ);  
    
    EM_CLUB_NAME.focus();
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
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if ( strChangFlag == false && (DS_O_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
        	if(DS_O_MASTER.NameValue(row, "REG_DATE") == ""){
                setTimeout("EM_CLUB_ID.Focus();",50);
        	}else{
                setTimeout("EM_CLUB_NAME.Focus();",50);
        	}
            return false;
        }else {
        	if(DS_O_MASTER.NameValue(row, "REG_DATE") == ""){
                DS_O_MASTER.DeleteRow(row);
                return true;
        	}
        }
    }else{
         return true;
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        doClick(row);  
    }else{
        DS_IO_DETAIL.ClearData();
    }
</script>

<!-- onKillFocus() -->
<script language=JavaScript for=EM_DON_ID_S event=onKillFocus()>
    if ((EM_DON_ID_S.Modified) && (EM_DON_ID_S.Text.length != 9)) {
        EM_CLUB_NAME_S.Text = "";
    }
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
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
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
        <td> </td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GD_MASTER
                    width="100%" height=474 classid=<%=Util.CLSID_GRID%> tabindex=1>
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
                        <th width="80" class="point">클럽ID</th>
                        <td width=60><comment id="_NSID_"> <object
                            id=EM_CLUB_ID classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
                            onkeyup="javascript:checkByteStr(EM_CLUB_ID, 2, '');"></object>
                        </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="80" class="point">클럽명</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_CLUB_NAME classid=<%=Util.CLSID_EMEDIT%> width=300 tabindex=1
                            onkeyup="javascript:checkByteStr(EM_CLUB_NAME, 40, '');"></object>
                        </comment> <script> _ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th width="80" class="point">클럽설명</th>
                        <td colspan="5"><comment id="_NSID_"> <object
                            id=EM_CLUB_INFO classid=<%=Util.CLSID_TEXTAREA%>
                            style="width: 100%; height: 40px;" tabindex=1
                            onkeyup="javascript:checkByteStr(EM_CLUB_INFO, 200, 'Y');"></object> </comment><script> _ws_(_NSID_);</script>
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
               <c>col=CLUB_ID         ctrl=EM_CLUB_ID             Param=Text</c>
               <c>col=CLUB_NAME       ctrl=EM_CLUB_NAME           Param=Text</c>
               <c>col=CLUB_INFO       ctrl=EM_CLUB_INFO           Param=Text</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

