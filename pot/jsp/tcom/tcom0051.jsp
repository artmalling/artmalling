<!-- 
/*******************************************************************************
 * 시스템명 : SMS보내기 
 * 작 성 일 : 2010.02.15
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : tcom0051.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 받는사람 추가 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8");  %>
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
<title>주소록-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script> 

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var opener = window.dialogArguments; 
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/ 
 /**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-15
 * 개    요 : initialize
 * return값 : void
 */

function doInit() 
{ 
    // Data Set Header 초기화
    DS_O_USER.setDataHeader('<gauce:dataset name="H_SEL_USER"/>');
    DS_O_RECV.setDataHeader('<gauce:dataset name="H_SEL_USER"/>');

    //그리드 초기화
    gridCreate();
    
    //콤보 초기화
    initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^20,NAME^0^110", 1, NORMAL);     //조직구분(조회) 
    initComboStyle(LC_O_STR_CD,     DS_O_STR_CD,    "CODE^0^20,NAME^0^110", 1, NORMAL);     //점(조회)
    initComboStyle(LC_O_DEPT_CD,    DS_O_DEPT_CD,   "CODE^0^20,NAME^0^110", 1, NORMAL);     //팀    
    initComboStyle(LC_O_TEAM_CD,    DS_O_TEAM_CD,   "CODE^0^20,NAME^0^110", 1, NORMAL);     //파트
    initComboStyle(LC_O_PC_CD,      DS_O_PC_CD,     "CODE^0^20,NAME^0^110", 1, NORMAL);     //PC   
     
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');   

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "Y"); 
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_O_STR_CD", "N", "", "Y");  
    
    //콤보데이터 기본값 설정( gauce.js ) 
    setComboData(LC_O_ORG_FLAG, "%");
    setComboData(LC_O_STR_CD,"%");  

    //라디오데이터 기본값 설정
    RD_SMS_GUBUN.CodeValue = "0";  // 임직원셋팅   
    
    // EMedit에 초기화 
    initEmEdit(EM_USER_NAME, "GEN^20", NORMAL);    //사원번호/명
    
    // 조회조건 
    EM_USER_NAME.Focus();
} 

function gridCreate(){

    var hdrProperies1 = '<FC>id={currow}         width=30   align=center	edit=none    	    name="NO"         	</FC>'
		     		  + '<FC>id=CHK       	 	 width=20    		  		edit={if(HP_NO="" ,"FALSE","TRUE")} editstyle=checkbox  HeadCheckShow=true	</FC>'
		     	      + '<FC>id=USER_ID          width=85                   edit=none			name="사용자/협력사" </FC>'
                      + '<FC>id=USER_NAME        width=95                   edit=none			name="성명"         </FC>' 
                      + '<FC>id=HP_NO        	 width=100                  edit=none			name="핸드폰NO"     </FC>'  
                      ;
                      
                     /* 
                      + '<FC>id=ORG_NAME         width=80   align=left      edit=none			name="조직"         	</FC>'
                      + '<FC>id=STR_NAME         width=80   align=left      edit=none			name="점"         	</FC>'
                      + '<FC>id=DEPT_NAME        width=90   align=left      edit=none			name="팀"         	</FC>'
                      + '<FC>id=TEAM_NAME        width=90   align=left      edit=none			name="파트"         	</FC>'
                      + '<FC>id=PC_NAME          width=90   align=left      edit=none			name="PC"			</FC>' 
                      ;
*/
    initGridStyle(GD_USER_LIST, "common", hdrProperies1, true); 
                     

    var hdrProperies2 = '<FC>id={currow}         width=30   align=center	edit=none    	    name="NO"         	</FC>'
					  + '<FC>id=CHK       	 	 width=20    		  		editstyle=checkbox  editstyle=checkbox  HeadCheckShow=true</FC>'
                      + '<FC>id=USER_ID          width=85                   edit=none			name="사용자/협력사" </FC>'
                      + '<FC>id=USER_NAME        width=95                   edit=none			name="성명"         </FC>' 
                      + '<FC>id=HP_NO        	 width=100                  edit=none			name="핸드폰NO"     </FC>' 
                      ;

    initGridStyle(GD_RECV_LIST, "common", hdrProperies2, true); 
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
* 작 성 일 : 2010-02-24
* 개    요 : 조회시 호출
* return값 : void
*/
function btn_Search() { 
ㅋ
	var strBindGbn		= RD_SMS_GUBUN.CodeValue;	   // SMS구분
    var strBindStrCd    = LC_O_STR_CD.BindColVal;      // 점
    var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;    // 조직 
    var strBindDeptCd   = LC_O_DEPT_CD.BindColVal;     // 팀
    var strBindTeamCd   = LC_O_TEAM_CD.BindColVal;     // 파트
    var strBindPcCd     = LC_O_PC_CD.BindColVal;       // PC 
    var strBindUserCd   = EM_USER_NAME.text;
    
    //협력사인경우 점이하 조직구분이 선택되는 경우 조직구분 필수체크
    /*if(strBindGbn == "1" && strBindOrgFlag=="%" && strBindStrCd != "%" )
    { 
        showMessage(STOPSIGN, OK, "USER-1000", "협력사인 경우 조직구분은 필수입니다.");
        LC_O_ORG_FLAG.focus();
        return ;
    }*/
    //DS_O_RECV.ClearData();
    var goTo       = "selectUserList" ;    
    var action     = "O";     
    var parameters = "&strGbn="    +encodeURIComponent(strBindGbn)
                   + "&strStrCd="  +encodeURIComponent(strBindStrCd)
                   + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag)
                   + "&strDeptCd=" +encodeURIComponent(strBindDeptCd)
                   + "&strTeamCd=" +encodeURIComponent(strBindTeamCd)
                   + "&strPcCd="   +encodeURIComponent(strBindPcCd) 
                   + "&strUserCd=" +encodeURIComponent(strBindUserCd) ;
    	
    TR_MAIN.Action="/pot/tcom005.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_USER=DS_O_USER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_USER.CountRow); 
     
}
/*************************************************************************
 * 3. 함수
*************************************************************************/

/**
 * btn_Close()
 * 작 성 자 : FKL
 * 작 성 일 : 2006.07.12
 * 개    요 : Close
 * return값 : void
 */  
function btn_Close()
{
    window.close();
}

// < 버튼 : 사용자목록 <- 받는이목록 데이터 이동
function moveLeft()
{ 
	var cntRow 	  = 0;
	var cntDupRow = 0;

	if (DS_O_RECV.CountRow < 1) return;
	
	GD_USER_LIST.ReDraw = false;
	GD_RECV_LIST.ReDraw = false;
	for (var i=DS_O_RECV.CountRow; i>=1; i--)
	{
	    if(DS_O_RECV.NameValue(i,"CHK") == "T")
	    {
	       if( DS_O_USER.NameValueRow("GBN_FLAG",  DS_O_RECV.NameValue(i, "GBN_FLAG") ) == 0 ) 
	       {
	    	   DS_O_USER.AddRow();
	    	   DS_O_USER.NameValue(DS_O_USER.CountRow, "USER_ID")     	= DS_O_RECV.NameValue(i, "USER_ID"); 
	    	   DS_O_USER.NameValue(DS_O_USER.CountRow, "USER_NAME")     = DS_O_RECV.NameValue(i, "USER_NAME"); 
	    	   DS_O_USER.NameValue(DS_O_USER.CountRow, "HP_NO")     	= DS_O_RECV.NameValue(i, "HP_NO");   
	    	   DS_O_USER.NameValue(DS_O_USER.CountRow, "GBN_FLAG")      = DS_O_RECV.NameValue(i, "GBN_FLAG");   

	    	   DS_O_RECV.DeleteRow(i);
	           cntRow += 1;
	       }
	       else{

	    	   DS_O_RECV.DeleteRow(i);
	           cntRow += 1;
	       }
	    }
	} 
	GD_USER_LIST.ReDraw = true;
	GD_RECV_LIST.ReDraw = true;

	if(cntRow == 0) showMessage(EXCLAMATION, OK, "USER-1000", "제외 할 대상이 없습니다.");
	
	/*
    if  (cntRow >0)   
    	showMessage(EXCLAMATION, OK, "USER-1000", cntRow + " 건 추가하였습니다."); 
    else                  
    	showMessage(EXCLAMATION, OK, "USER-1000", "추가할 대상이 없습니다.");
	*/
}

// > 버튼 : 사용자목록 -> 받는이목록 데이터 이동
function moveRight()
{     
	var cntRow 	  = 0;
	var chkCntRow = 0;
	var maxCntChk = 0;
	var errChk;

	if (DS_O_USER.CountRow < 1) return; 

	GD_USER_LIST.ReDraw = false;
	GD_RECV_LIST.ReDraw = false;
	for (var i=DS_O_USER.CountRow; i>=1; i--)
	{
	    if(DS_O_USER.NameValue(i,"CHK") == "T")
	    {
	    	chkCntRow +=1 ;
	       if( DS_O_RECV.NameValueRow("GBN_FLAG",  DS_O_USER.NameValue(i, "GBN_FLAG") ) == 0 ) 
	       { 
	    		/*
	    	   	if(DS_O_RECV.CountRow >= 10)
	    		{
	    			showMessage(EXCLAMATION, OK, "USER-1000", "최대 10명까지만 SMS전송 가능합니다.");
	    			errChk = "Y";
	    		   	break;
	    		}
	    		*/
	    	   	DS_O_RECV.AddRow();
	    	   	DS_O_RECV.NameValue(DS_O_RECV.CountRow, "CHK")     		= "T"; 
	    	   	DS_O_RECV.NameValue(DS_O_RECV.CountRow, "USER_ID")     	= DS_O_USER.NameValue(i, "USER_ID"); 
	    	   	DS_O_RECV.NameValue(DS_O_RECV.CountRow, "USER_NAME")    = DS_O_USER.NameValue(i, "USER_NAME"); 
	           	DS_O_RECV.NameValue(DS_O_RECV.CountRow, "HP_NO")     	= DS_O_USER.NameValue(i, "HP_NO");   
	           	DS_O_RECV.NameValue(DS_O_RECV.CountRow, "GBN_FLAG")     = DS_O_USER.NameValue(i, "GBN_FLAG");   
 
	           	DS_O_USER.DeleteRow(i);
	           	cntRow += 1; 
		            
	       }
	    }
	} 
	GD_USER_LIST.ReDraw = true;
	GD_RECV_LIST.ReDraw = true;
	
	if(chkCntRow > 0 && cntRow == 0)	showMessage(EXCLAMATION, OK, "USER-1000", "이미 추가한 대상입니다.");
	else if(cntRow == 0) 				showMessage(EXCLAMATION, OK, "USER-1000", "추가 할 대상이 없습니다.");
	/*
	if(errChk != "Y")
	{
	    if  (cntRow >0)   
	    	showMessage(EXCLAMATION, OK, "USER-1000", cntRow + " 건 추가하였습니다."); 
	    else                  
	    	showMessage(EXCLAMATION, OK, "USER-1000", "추가할 대상이 없습니다.");
	}
	*/
}

function btn_Apply()
{
    var objDs = opener.DS_O_SMS_LIST;  
    var cntRow = 0;
    var chkRow = 0;
    
	for (var i=1; i<=DS_O_RECV.CountRow; i++)
	{
	    if(DS_O_RECV.NameValue(i,"CHK") == "T")
	    {
	       if( objDs.NameValueRow("GBN_FLAG",  DS_O_RECV.NameValue(i, "GBN_FLAG") ) == 0 ) 
	       {  
	    		objDs.AddRow();
	    		objDs.NameValue(objDs.CountRow, "CHK")     		= "F"; 
	    		objDs.NameValue(objDs.CountRow, "USER_ID")     	= DS_O_RECV.NameValue(i, "USER_ID"); 
	    		objDs.NameValue(objDs.CountRow, "USER_NAME")    = DS_O_RECV.NameValue(i, "USER_NAME"); 
	    		objDs.NameValue(objDs.CountRow, "HP_NO")     	= DS_O_RECV.NameValue(i, "HP_NO");   
	    		objDs.NameValue(objDs.CountRow, "GBN_FLAG")     = DS_O_RECV.NameValue(i, "GBN_FLAG");    
 
	           	cntRow += 1;  
	       }
	       chkRow +=1;
	    }
	} 

	if (chkRow ==0)
    	showMessage(EXCLAMATION, OK, "USER-1000", " 추가할 대상을 선택하여 주십시요.");
	else if(cntRow >0 && cntRow > 0)       
    {
    	showMessage(EXCLAMATION, OK, "USER-1000", cntRow + " 건 추가하였습니다.");   
    	this.close();
    }
    else if(chkRow > 0 && cntRow == 0 )               
    	showMessage(EXCLAMATION, OK, "USER-1000", " 이미 추가한 대상입니다.");
	
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->  
<script language=JavaScript for=DS_O_USER event=OnLoadCompleted(rowcnt)>
	GD_USER_LIST.ColumnProp('CHK', 'HeadCheck')= false;

 /*
	if(RD_SMS_GUBUN.CodeValue == "0")
	{
		GD_RECV_LIST.ColumnProp('USER_ID','Name')='사용자ID';
		GD_USER_LIST.ColumnProp('USER_ID','Name')='사용자ID'; 
	}
	else
	{
		GD_RECV_LIST.ColumnProp('USER_ID','Name')='협력사';
		GD_USER_LIST.ColumnProp('USER_ID','Name')='협력사'; 
	}
*/
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language="javascript"  for=GD_USER_LIST event=OnHeadCheckClick(Col,Colid,bCheck)>
// 그리드 헤더 선택시 전체 선택/해제
	if (DS_O_USER.CountRow < 1) return;

	if(Colid =="CHK")
	{
		for (var i=1; i<=DS_O_USER.CountRow; i++)
		{
			if(DS_O_USER.NameValue(i,"HP_NO")!="") DS_O_USER.NameValue(i,"CHK") = (bCheck==true)?"T":"F" ;
		} 
	} 
</script>
<script language="javascript"  for=GD_RECV_LIST event=OnHeadCheckClick(Col,Colid,bCheck)>
// 그리드 헤더 선택시 전체 선택/해제
	if (DS_O_RECV.CountRow < 1) return;

	if(Colid =="CHK")
	{
		for (var i=1; i<=DS_O_RECV.CountRow; i++)
		{
			if(DS_O_RECV.NameValue(i,"HP_NO")!="") DS_O_RECV.NameValue(i,"CHK") = (bCheck==true)?"T":"F" ;
		} 
	} 
</script>

<script language=JavaScript for=GD_USER_LIST event=OnClick(row,colid)>
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_RECV_LIST event=OnClick(row,colid)>
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (LC_O_STR_CD.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%") 
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "N", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    getPc("DS_O_PC_CD", "N", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y", "",
                LC_O_ORG_FLAG.BindColVal);

    if(DS_O_PC_CD.CountRow < 1){
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
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
<!-- --------------------- 조회조건(searchBar) --------------------------------- -->
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_USER classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_RECV classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>">
      <param name="KeyName"   value="Toinb_dataid4">
    </object>
</comment>
<script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      	<tr><td>
      		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          	<tr>
            	<td class="title">
            		<img src="./imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/> 주소록</td>
            	<td width="414">
            		<table border="0" align="right" cellpadding="0" cellspacing="0">
              		<tr>
                		<td><img src="./imgs/btn/search.gif" width="50" height="22" onClick="btn_Search();" /></td>  
                		<td><img src="./imgs/btn/apply.gif"  width="50" height="22" onClick="btn_Apply();" /></td>  
                		<td><img src="./imgs/btn/close.gif"  width="50" height="22" onClick="btn_Close();" /></td>
              		</tr>
            		</table>
            	</td>
			</tr>
        	</table>
        </td></tr>
      	<tr><td class="popT01 PB03">
      		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          	<tr><td>
          		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              		<tr>
                		<th width="80">구분</th>
                		<td> 
				              <comment id="_NSID_"> 
				                <object id="RD_SMS_GUBUN" classid="<%=Util.CLSID_RADIO%>" height=18 width=130 align="absmiddle" tabindex=1>
				                  <param name="Cols" value="2">
				                  <param name="Format" value="0^임직원,1^협력사">
				                </object> 
				              </comment><script>_ws_(_NSID_);</script>    
		                </td>
                		<th width="80">조직구분</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=130 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
			            </td>
		                <th width="80">점</th> 
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %>  width=130 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
              		</tr>
              		<tr>
		                <th width="80">팀</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_DEPT_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                <th width="80">파트</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_TEAM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                <th width="80">PC</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_PC_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
              		</tr>
              		<tr> 
                		<th width="80">이름검색</th>
                		<td colspan="5"> 
		                   <comment id="_NSID_">
		                     <object id=EM_USER_NAME classid=<%=Util.CLSID_EMEDIT%> width=130 ></object>
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
              		</tr>
              		
            	</table>
            </td></tr>
        	</table>
        </td></tr>
        
       	<tr><td class="dot"></td></tr>
       	
      	<tr><td>
      		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          	<tr>
          		<td width="50%" class="sub_title PT05 PB03">
          			<img src="./imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>사용자 목록</td>
            	<td>&nbsp;</td>
            	<td width="50%" class="sub_title PL03 PT05 PB03 ">
            		<img src="./imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>받는이 목록</td>
          	</tr>
          	<tr>
          		<td >
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">
		            	<tr><td>
							<comment id="_NSID_"><OBJECT id=GD_USER_LIST width=100% height="280" classid=<%=Util.CLSID_GRID%>>
							<param name=DataID   value="DS_O_USER"> 
						</OBJECT></comment><script>_ws_(_NSID_);</script>
						</td></TR>
	            	</table>
            	</td>
            	<td class="PL03">
              		<img src="./imgs/btn/next.gif"   width="19" height="18" onClick="moveRight();">
            		<img src="./imgs/btn/before.gif" width="19" height="18" vspace="2"  onClick="moveLeft();"><br>
              	</td>
            	<td class="PL03">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">
		            	<tr><td>
							<comment id="_NSID_"><OBJECT id=GD_RECV_LIST width=100% height="280" classid=<%=Util.CLSID_GRID%>>
							<param name=DataID   value="DS_O_RECV"> 
						</OBJECT></comment><script>_ws_(_NSID_);</script>
						</td></TR>
	            	</table>
            	</td>
          	</tr>
        	</table>
		</td></tr>
		
 	</table>
 	</td>
    <td class="pop06" ></td>
  	</tr>
	
	<tr>
	   <td class="pop07" ></td>
	   <td class="pop08" ></td>
	   <td class="pop09" ></td>
	</tr>
</table>
</body>
</html>
