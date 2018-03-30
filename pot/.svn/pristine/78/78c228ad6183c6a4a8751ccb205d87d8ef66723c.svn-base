<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.02.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 권한관리 
 * 이    력 : 
     2010.06.01 수정
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
<%
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>
 
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var glbOrgFlag =  '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';
 var glbTab2Open="N";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-06-01
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){ 
    
    //사용자별 프로그램 사용권한 (ccom1041.jsp) 초기화 (Tab.1) 
    initByUser(); 
    
    //그룹별 프로그램 사용권한 (ccom1042.jsp) 초기화 (Tab.2) 
    //initByGroup(); 
    
    //조직권한 (ccom1043.jsp) 초기화 (Tab.3) 
    initJojik(); 

    //탭
    initTab("TB_NORMAL");

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("tcom104","DS_IO_USRPGM,DS_O_GRPATH,DS_IO_JJAUTH" );
    
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
 * 작 성 일 : 2010-06-01
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	// 그룹권한은 조회가 존재하지 않음
	
    DS_IO_USRPGM.ClearAll();
    
    // 사용자별 프로그램 사용권한에서 검색
    if( getTabId()=='U' ) 
        selectUsrmstUser();    
    //그룹별 프로그램 사용권한에서 검색
	else if( getTabId()=="J" ) 
        selectUsrmstJojik(); 
    
    if(getTabId()=='U' )setPorcCount("SELECT", DS_O_USRMST.CountRow); 
}  
/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-06-01
 * 개    요 : 신규등록시 호출
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Save()
 * 작 성 자 : ckj
 * 작 성 일 : yyyy-mm-dd
 * 개    요 : DB에 입력 / 수정 / 삭제 처리
 * return값 : void
 */ 
function btn_Save() 
{
	var objDs;

    if(getTabId()=='U') objDs = DS_IO_USRPGM;  
    if(getTabId()=='G') objDs = DS_O_GRPATH;  
    if(getTabId()=='J') objDs = DS_IO_JJAUTH;  
    
    // alert("getTabId() => " + getTabId() + "////" + objDs.CountRow);
    // 저장할 데이터 없는 경우 
    if (!objDs.IsUpdated )
    {   //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028"); 
        return;
    } 
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ) return; 
    saveData(objDs); 
}

/**
 * btn_Delete()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-07
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete()
{
    if(getTabId()=='U') 
    {
    	objDs   = DS_IO_USRPGM;  
        objGrid = GD_USRPGM_U;  
    }
    if(getTabId()=='G')
    {
    	objDs   = DS_O_GRPATH;  
        objGrid = GD_GRPATH_G;   
    }

    if(getTabId()=='J')
    {
        objDs   = DS_IO_JJAUTH;  
        objGrid = GD_JJAUTH_J;   
    }
        
    // 삭제할 데이터 없는 경우
    if (objDs.CountRow < 1){
        //삭제할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1019"); 
        return;
    }
    
    // 상세에 변경내역있을  경우 
    if(objDs.IsUpdated){
    	if( showMessage(QUESTION, YESNO, "USER-1000", "변경된 상세내역이 존재합니다.<br>선택한 항목을 삭제하시겠습니까?") != 1 ) return;   
    }
    else
    {
        //선택한 항목을 삭제하겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ) return; 
    }	
     
    
    // 삭제위치 잡기
    objGrid.ReDraw = false;
    for( var i=objDs.CountRow ; i>0 ; i-- ){
        if( objDs.RowMark(i) == 1 ) objDs.NameValue(i,"GBN") = "Y"; 
    }
     
    for( var i=objDs.CountRow ; i>0 ; i-- )
    {
        if( objDs.NameValue(i,"GBN")=="Y" ) objDs.DeleteRow(i); 
    }
    objGrid.ReDraw = true;
    
    saveData(objDs);
}

function saveData(objDs)
{
    var rtnVal;
    
    if (getTabId() =='J')
    {
        rtnVal = DS_O_USRMST_J.NameValue(DS_O_USRMST_J.rowPosition, "USER_ID");

        TR_MAIN.Action  = "/pot/tcom104.tc?goTo=updateJjauth" ; 
        TR_MAIN.KeyValue= "SERVLET(I:DS_IO_JJAUTH=DS_IO_JJAUTH)"; 
        TR_MAIN.Post(); 
        
        // 저장 후 처리
        if(TR_MAIN.ErrorCode == 0) showJjauth(rtnVal); 
        
    }
    else
    {
        if(getTabId()=='U') 
            rtnVal = DS_O_USRMST.NameValue(DS_O_USRMST.rowPosition, "USER_ID");
        else if(getTabId() =='G')
            rtnVal = DS_O_PGROUP_T2.NameValue(DS_O_PGROUP_T2.rowPosition, "GROUP_CD"); 

        var parameters = "&strDS="+encodeURIComponent(objDs.id)+"&strGbn="+encodeURIComponent(getTabId()); 
        
        TR_MAIN.Action= "/pot/tcom104.tc?goTo=updatePrAuth"+parameters; 
        TR_MAIN.KeyValue= "SERVLET(I:"+objDs.id+"="+objDs.id+")";
        TR_MAIN.Post(); 

        // 저장 후 처리
        if(TR_MAIN.ErrorCode == 0)  showUsrpgm(getTabId(), rtnVal, objDs); 
    }  
 
}
/**
 * selectPgroup()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-07
 * 개    요 : 그룹 정보를 가져옵니다.
 * return값 : void
 */
function selectPgroup(strDs){
	    
	var goTo       = "selPgroup" ;    
	var action     = "O";     
	var parameters = "&strDS=" +encodeURIComponent(strDs);
	     
	TR_MAIN.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET("+action+":"+strDs+"="+strDs+")"; //조회는 O
	TR_MAIN.Post(); 
}
    
/**
 * showTreeView()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-07
 * 개    요 : 트리 메뉴를 보여줍니다.
 * return값 : void
 */
function showTreeView(tabId,strDs)
{
     if( tabId == 'U' ) 
         //사용자별 프로그램 사용권한 
         TV_MAIN_U.ClearAll();
     else if( tabId == 'G' )
    	 //그룹별 프로그램 사용권한
         TV_MAIN_G.ClearAll();  

     var goTo       = "treeview";    
     var parameters = "&strSubSystem="+encodeURIComponent(getSubSystemCode(tabId)) + "&strDS=" +encodeURIComponent(strDs) ;
     var action     = "O"; 
     
     TR_MAIN.Action="/pot/tcom104.tc?goTo="+goTo+parameters;   
     TR_MAIN.KeyValue="SERVLET("+action+":"+strDs+"="+strDs+")"; //조회는 O
     TR_MAIN.Post();
 }

 /**
  * getSubSystemCode()
  * 작 성 자 : ckj
  * 작 성 일 : 2006-08-07
  * 개    요 : 현재 선택된 SUB_SYSTEM의 코드값을 리턴한다. 
  * return값 : SUB_SYSTEM (P,G,A or C)
  */
function getSubSystemCode(tabId){
    var subSys;
    if( tabId == 'U' )
        //사용자별 프로그램 사용권한 
        subSys = LC_SUB_SYSTEM_U.ValueOfIndex("CODE", LC_SUB_SYSTEM_U.Index);
    else if( tabId == 'G' )
    	//그룹별 프로그램 사용권한
        subSys = LC_SUB_SYSTEM_G.ValueOfIndex("CODE", LC_SUB_SYSTEM_G.Index);
    
    if(subSys=='')subSys = 'G';
    
    return subSys;
}

/**
 * showUsrpgm()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-11
 * 개    요 : 선택된 사용자의 프로그램권한을 프로그램 Grid에 보여준다.(그룹 권한과 함께)
 * return값 : void
 */
 function showUsrpgm(gbn, val) {
     // GBN : U = 사용자별 , G = 그룹별  
     var action     = "O"; 
     var goTo       = "selUsrpgm";    
     var parameters = "&strGbn="+encodeURIComponent(gbn)+"&strVal="+encodeURIComponent(val)+"&strDS="+encodeURIComponent(arguments[2].id);   

     TR_MAIN_PGMLIST.Action="/pot/tcom104.tc?goTo="+goTo+parameters;   
     TR_MAIN_PGMLIST.KeyValue="SERVLET("+action+":"+arguments[2].id+"="+arguments[2].id+")"; //조회는 O  
     TR_MAIN_PGMLIST.Post(); 

     setPorcCount("SELECT", eval(arguments[2].CountRow));
 }
 
 
 /**
  * addProgram()
  * 작 성 자 : ckj
  * 작 성 일 : 2006-08-07
  * 개    요 : 프로그램 Grid에 트리에서 선택된 값을 추가한다.
  * return값 : void
  */
function addProgram(tabId)
 {
	
	var objDS;
	var objGrid;
	var objKey;
	
	if(tabId =="U")
	{
       if( getLastUserSelected() == "" ) 
        {
            showMessage(STOPSIGN, OK, "USER-1000", "사용자를 선택해주세요.");
            return;
        }
       
       objDS    = DS_IO_USRPGM; //대상데이터셋
       objGrid  = GD_USRPGM_U ; //그리드
       objKey   = DS_O_USRMST.NameValue(DS_O_USRMST.RowPosition, "USER_ID");
       
	}
	else if( tabId == 'G' )
	{
        if( getLastGroupSelected() == "" ) 
        {
            showMessage(STOPSIGN, OK, "USER-1000", "그룹을 선택해주세요.");
            return;
        }
        
        objDS    = DS_O_GRPATH;     //대상데이터셋
        objGrid  = GD_GRPATH_G ;    //그리드
        objKey   = DS_O_PGROUP_T2.NameValue(DS_O_PGROUP_T2.RowPosition, "GROUP_CD"); 
	}
    
    if( getLastProgramSelected(tabId) == "" ) {
        showMessage(STOPSIGN, OK, "USER-1000", "메뉴를 선택해주세요.");
        return;
    } 

    var codes = getLastProgramSelected(tabId);
    var scode, mcode, lcode;
    
    if( codes != '' ) 
    { 
        var codeArr = codes.split("|"); 
        lcode = (codeArr[0]==undefined)? "" : codeArr[0];
        mcode = (codeArr[1]==undefined)? "" : codeArr[1];
        scode = (codeArr[2]==undefined)? "" : codeArr[2]; 

        DS_O_PGMMST.ClearData();
        
        var goTo       = "selPgmmst";    
        var parameters = "&strLcdoe="+encodeURIComponent(lcode)+"&strMcdoe="+encodeURIComponent(mcode)+"&strScdoe="+encodeURIComponent(scode) ;
        var action     = "O"; 
        
        TR_MAIN.Action="/pot/tcom104.tc?goTo="+goTo+parameters;   
        TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PGMMST=DS_O_PGMMST)"; //조회는 O   
        TR_MAIN.Post(); 
        
        //프로그램 권한 GRID에 추가 
        
        objGrid.ReDraw =false; 
        var cntRow = 0;
        var cntDupRow = 0;
        
         for(var i=1 ; i<DS_O_PGMMST.CountRow+1 ;i++) 
         {
              if( objDS.NameValueRow("PID",DS_O_PGMMST.NameValue(i, "PID")) == 0 ) 
              {
            	  objDS.AddRow();
            	  
            	  objDS.NameValue(objDS.CountRow, "CODE" )         = objKey;
            	  objDS.NameValue(objDS.CountRow, "PID" )          = DS_O_PGMMST.NameValue(i, "PID");
            	  objDS.NameValue(objDS.CountRow, "NAME" )         = DS_O_PGMMST.NameValue(i, "PNAME1");
            	  objDS.NameValue(objDS.CountRow, "IS_RET" )       = DS_O_PGMMST.NameValue(i, "IS_RET");
            	  objDS.NameValue(objDS.CountRow, "IS_NEW" )       = DS_O_PGMMST.NameValue(i, "IS_NEW");
            	  objDS.NameValue(objDS.CountRow, "IS_DEL" )       = DS_O_PGMMST.NameValue(i, "IS_DEL");
            	  objDS.NameValue(objDS.CountRow, "IS_SAVE" )      = DS_O_PGMMST.NameValue(i, "IS_SAVE");
            	  objDS.NameValue(objDS.CountRow, "IS_EXCEL" )     = DS_O_PGMMST.NameValue(i, "IS_EXCEL");
            	  objDS.NameValue(objDS.CountRow, "IS_PRINT" )     = DS_O_PGMMST.NameValue(i, "IS_PRINT");
            	  objDS.NameValue(objDS.CountRow, "IS_CONFIRM" )   = DS_O_PGMMST.NameValue(i, "IS_CONFIRM");
            	  objDS.NameValue(objDS.CountRow, "IS_RET_GB" )    = DS_O_PGMMST.NameValue(i, "IS_RET_GB");
            	  objDS.NameValue(objDS.CountRow, "IS_NEW_GB" )    = DS_O_PGMMST.NameValue(i, "IS_NEW_GB");
            	  objDS.NameValue(objDS.CountRow, "IS_DEL_GB" )    = DS_O_PGMMST.NameValue(i, "IS_DEL_GB");
            	  objDS.NameValue(objDS.CountRow, "IS_SAVE_GB" )   = DS_O_PGMMST.NameValue(i, "IS_SAVE_GB");
            	  objDS.NameValue(objDS.CountRow, "IS_EXCEL_GB" )  = DS_O_PGMMST.NameValue(i, "IS_EXCEL_GB");
            	  objDS.NameValue(objDS.CountRow, "IS_PRINT_GB" )  = DS_O_PGMMST.NameValue(i, "IS_PRINT_GB");
            	  objDS.NameValue(objDS.CountRow, "IS_CONFIRM_GB" )= DS_O_PGMMST.NameValue(i, "IS_CONFIRM_GB");
            	  // MARIO OUTLET
            	  objDS.NameValue(objDS.CountRow, "SUB_SYSTEM" )   = DS_O_PGMMST.NameValue(i, "SUB_SYSTEM");
            	  objDS.NameValue(objDS.CountRow, "LNAME" )        = DS_O_PGMMST.NameValue(i, "LNAME");
            	  objDS.NameValue(objDS.CountRow, "MNAME" )        = DS_O_PGMMST.NameValue(i, "MNAME");
            	  objDS.NameValue(objDS.CountRow, "SNAME" )        = DS_O_PGMMST.NameValue(i, "SNAME");
                  // MARIO OUTLET
            	  cntRow += 1;
              } 
              else cntDupRow += 1; 
         }  
         objGrid.ReDraw =true;
    } 

    var msg = "";
    if (cntDupRow > 0) msg = "<br> "+cntDupRow+"건의 중복 데이터가 존재합니다.";
    
    if  (cntRow >0){
    	if(cntRow == 1) return;
    	showMessage(EXCLAMATION, OK, "USER-1000", cntRow + " 건 추가하였습니다." + msg);
    }   
    else if(cntRow ==0 && cntDupRow > 0){
    	showMessage(EXCLAMATION, OK, "USER-1000", msg);
    }   
    else{
    	showMessage(EXCLAMATION, OK, "USER-1000", "추가할 대상이 없습니다.");
    }                  
}

 /**
  * initComponentInTab()
  * 작 성 자 : ckj
  * 작 성 일 : 2006-08-10
  * 개    요 : TAB을 전환  
  * return값 : void
  */
function initComponentInTab(index) 
{ 
    if(index==1)
        setTabId('U');  
     
      switch(index) {
          case 1:
              setTabId('U'); 
              break;
          case 2:
              setTabId('G');
              break;
          case 3:
              setTabId('J'); 
              break;
      }       
      
  }
 
/**
 * setLastProgramSelected()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-08
 * 개    요 : 트리 메뉴에 선택된 마지막 코드 값을 기억해둔다.
 * return값 : void
 */
var lastProgramSelectedTab1= "";
var lastProgramSelectedTab2 = "";
function setLastProgramSelected(gbn, code) {
	if (gbn == "U") lastProgramSelectedTab1 = code;
    if (gbn == "G") lastProgramSelectedTab2 = code;
}

 /**
 * getLastProgramSelected()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-08
 * 개    요 : 트리 메뉴에 선택된 마지막 코드 값을 리턴한다.
 * return값 : void
 */
function getLastProgramSelected(gbn) {
    if (gbn == "U") return lastProgramSelectedTab1;
    if (gbn == "G") return lastProgramSelectedTab2; 
}

/**
* setLastUserSelected()
* 작 성 자 : ckj
* 작 성 일 : 2006-08-11
* 개    요 : 사용자 GRID에서 선택된 사용자ID를 셋팅한다. 
* return값 : void
*/
var lastUserSelected = "";
function setLastUserSelected(usrCd) {
    lastUserSelected = usrCd;
}

/**
* getLastUsrSelected()
* 작 성 자 : ckj
* 작 성 일 : 2006-08-11
* 개    요 : 사용자 Grid에서 선택된 마지막 사용자 
* return값 : void
*/
function getLastUserSelected() {
    return lastUserSelected;
}

/**
 * setTabId()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-11
 * 개    요 : 선택된 탭의 구분자를 셋팅한다. 
 * return값 : void
 */
 var TAB_ID = 'U';
 function setTabId(tabId) {
     TAB_ID = tabId;
 }
  
 /**
 * getTabId()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-11
 * 개    요 : 선택된 탭의 구분자를 린턴한다. 
 * return값 : str
 */
 function getTabId() {
     return TAB_ID;
 }
 /**
  * setLastGroupSelected()
  * 작 성 자 : ckj
  * 작 성 일 : 2006-08-08
  * 개    요 : 그룹 GRID에 선택된 마지막 값을 기억해둔다.
  * return값 : void
  */
var lastGroupSelected = "";
function setLastGroupSelected( groupCd ) {
	lastGroupSelected = groupCd;
}
	
/**
  * getLastGroupSelected()
  * 작 성 자 : ckj
  * 작 성 일 : 2006-08-08
  * 개    요 : 그룹 GRID에 선택된 마지막 값을 리턴한다.
  * return값 : void
  */
function getLastGroupSelected() {
	return lastGroupSelected;
}
/**
 * changeTab1()
 * 작 성 자 : 
 * 작 성 일 : 2010-02-28
 * 개    요 : 탭클릭시 변경 사항 체크
 * return값 : void
**/
function changeTab1()
{
 	if( DS_O_GRPATH.IsUpdated ) 
     {
         if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;  
         DS_O_GRPATH.UndoAll();
      }
     else if (DS_IO_JJAUTH.IsUpdated)
     {
         if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;  
         DS_IO_JJAUTH.UndoAll();
     }
     else initComponentInTab(1);
}
function changeTab2()
{
	if (glbTab2Open=="N") 
	{
		initByGroup();
		glbTab2Open = "Y"; 
	}
	
    if( DS_IO_USRPGM.IsUpdated ) 
    {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;  
        DS_IO_USRPGM.UndoAll();
     }
    else if (DS_IO_JJAUTH.IsUpdated)
    {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;  
        DS_IO_JJAUTH.UndoAll();
    }
    else initComponentInTab(2);
}
function changeTab3()
{
    if( DS_IO_USRPGM.IsUpdated ) 
    {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;  
        DS_IO_USRPGM.UndoAll();
    }
    else if( DS_O_GRPATH.IsUpdated ) 
    {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;  
        DS_O_GRPATH.UndoAll();
    }
    else initComponentInTab(3);
}
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess> 
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN1 event=onFail>
    trFailed(TR_MAIN1.ErrorMsg);
</script>


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>   



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************--> 

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!--  TAB1.2 프로그램더하기 버튼  -->
<comment id="_NSID_"><object id="DS_O_PGMMST"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 추가할 프로그램 담는 데이타셋 -->

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_MAIN_PGMLIST" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!-- --------------------- 사용안함-------------------- -->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_I_SUB_SYSTEM" 	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 리스트 불러오기 위한 조건  -->
<comment id="_NSID_"><object id="DS_I_GRPATH_COND" 	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 리스트 불러오기 위한 조건  -->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_I_USRMST_COND" 	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USRPGM_COND" 	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ============== Output용 -->
<comment id="_NSID_"><object id="DS_O_STORE"		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_O_BU"			classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_O_TEAMFLOOR"	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_O_PC"			classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<!-- =============== Input용 , Output용 -->
<comment id="_NSID_"><object id="DS_I_JJAUTH_COND" 	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<!--공통 타이틀/버튼 -->
	<%@ include file="/jsp/common/titleButton.jsp"%>
	<!--공통 타이틀/버튼 // -->

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="PT01 PB03">
		<!--tab start -->
			<div id=TB_NORMAL width="100%" height=555 TitleWidth=170 TitleAlign="center" TitleGap=3 >
				<menu TitleName="사용자별 프로그램 사용권한" 	DivId="tabUser"   ClickBfFunc="changeTab1" /> 
				<menu TitleName="그룹별 프로그램 사용권한" 	DivId="tabGroup"  ClickBfFunc="changeTab2" /> 
				<menu TitleName="조직권한" 					DivId="tabJojik"  ClickBfFunc="changeTab3" /> 
			</div>
	     <!-- tab end --> 
	     </td>
	</tr>
	<tr>
        <td>
            <!-- 사용자별 권한 관리  -->
			<div id="tabUser" style="display: ; position: absolute; top: 100px; width: 100%; height: 20;">
			     <jsp:include page="tcom1041.jsp" />
			</div>
			
			<!-- 그룹별 권한 관리  -->
			<div id="tabGroup" style="display: hidden; position: absolute; top: 61px; width: 100%; height: 20;">
			     <jsp:include page="tcom1042.jsp" />
			</div>
			
			<!-- 조직 권한 관리  --> 
			<div id="tabJojik" style="display: hidden; position: absolute; top: 100px; width: 100%; height: 20;">
			     <jsp:include page="tcom1043.jsp" />
			</div>
	    </td>
    </tr> 
	
	</table>
    </DIV>

</body>

</html>
