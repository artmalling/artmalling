<!-- 
/**********************************************************************************
  * 시스템명 : 시스템관리 > 게시물관리 > 도움말관리
  * 작 성 일 : 2010.06.20
  * 작 성 자 : HOSEON
  * 수 정 자 :
  * 파 일 명 : tcom2020.jsp
  * 버    전 : 1.0        
  * 개    요 : 
  * 이    력 :
  ********************************************************************************/
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
    String version 	= BaseProperty.get("webeditor.version");
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
<script language="javascript"  src="/<%=dir%>/jsp/message.js"type="text/javascript"></script>

<script LANGUAGE="JavaScript">
<!--   
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var gTreeLvl = 0;
 var gTreeCd ;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
*/
function doInit(){
	// Output Data Set Header 초기화 || 트리
    DS_O_TREE_MAIN.setDataHeader('<gauce:dataset name="H_TREE_MAIN"/>');        
     
    //콤보 초기화 : 시스템구분
    initComboStyle(LC_SUB_SYSTEM,   DS_O_SUBSYSTEM, "CODE^0^30,NAME^0^80", 1, PK);
    //서브시스템 공통 코드 에서 가져 오기
    getEtcCode("DS_O_SUBSYSTEM",   "D", "TC01", "N"); 
    
    //콤보 기본값셋팅 = 백화점
    setComboData(LC_SUB_SYSTEM, "P");
     
    initTxtAreaEdit(TEXT_CONTENT, NORMAL);              // 내용
    initEmEdit(EM_PROGRAM_NM, "GEN^200", READ);        // 프로그램명
    initEmEdit(EM_MOD_DATE  , "GEN^40" , READ);        // 등록일시
    initEmEdit(EM_MOD_NAME  , "GEN^40" , READ);        // 등록자 

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    //registerUsingDataset("tcom202","DS_IO_MAIN" );
     
	// TEXTAREA 컴포넌트 
    //document.getElementById("divComp").style.visibility = "hidden";  
}    

/*************************************************************************
 * 2. 공통버튼
     (1) 조회 - btn_Search()
     (2) 신규 - btn_New()
     (3) 삭제 - btn_Delete()
     (4) 저장 - btn_Save()
     (5) 엑셀 - btn_Excel()
     (6) 출력 - btn_Print()
     (7) 행추가    - btn_SubAdd()
     (8) 행삭제    - btn_SubDel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : 조회시 호출 (타겟: 프로그램 그리드 )
 * return값 : void
 */ 
function btn_Search() {
    
}  

/**
 * btn_Save()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : DB에 입력 / 수정 / 삭제 처리
 * return값 : void
 */ 
function btn_Save() {
	//Wec.DefaultCharSet ="utf-8";   
	 /*
    if (!DS_IO_MAIN.IsUpdated ){ 
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        TEXT_CONTENT.Focus();
        return;
    } 
    */
    if (EM_PROGRAM_NM.text == "" || gTreeLvl != 4){ 
        showMessage(STOPSIGN, OK, "USER-1000",  "저장 할 프로그램을 선택하십시오.");
        return;
    } 
    
    /*
    //수정 필요
    var cWec = trim(Wec.TextValue.replace("\u000D", "")).length + Wec.GetFileNum(0);
    
    if(cWec == 0 ){
        showMessage(INFORMATION, OK, "USER-1003",  "내용");
        //TEXT_CONTENT.Focus();
        return;
    }
    
    // TEXT_CONTENT.Text=Wec.MimeValue 시 TEXT_CONTENT.Text 데이터가 없는  경우가 발생한다.
    TEXT_CONTENT.Text = "";
    TEXT_CONTENT.Text = Wec.MimeValue;
    */
 
    //if(Wec.MimeValue!="" && TEXT_CONTENT.Text=="")
    //alert(Wec.MimeValue + "\n ===================================== \n\n " + TEXT_CONTENT.Text);
    //alert(DS_IO_MAIN.RowPosition);
        
    DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPosition,"URL")   = "TEXT_CONTENT"; 
    DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPosition,"LCODE") = (DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE")).substring(1,4); 
    DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPosition,"MCODE") = (DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE")).substring(5,6); 
    DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPosition,"SCODE") = (DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE")).substring(6,14); 
    DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPosition,"PID")   = (DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE")).substring(6,14); 
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){ 
        return; 
    }
    	
    var goTo       = "save";    
    var parameters = "&strSubSystem="+encodeURIComponent(LC_SUB_SYSTEM.ValueOfIndex("CODE", LC_SUB_SYSTEM.Index)) ;
    var action     = "I"; 
    var strPid =  DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPostion, "PID") ;
    
    TR_MAIN.Action="/pot/tcom202.tc?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET(" +action+":DS_IO_MAIN = DS_IO_MAIN)"; 

	TR_MAIN.Post();   

    // 저장 후 처리
    if(TR_MAIN.ErrorCode == 0) selectHelp(strPid);
    
}  

/**
 * btn_New()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : 선택된 Grid 레코드 추가
 * return값 : void
 */ 
function btn_New() { 
}
    
/**
 * btn_Delete()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
 function btn_Delete() {  

	if(DS_IO_MAIN.CountRow < 1 || DS_IO_MAIN.NameValue(DS_IO_MAIN.RowPostion, "HELP_MSG") == "") { 
	    showMessage(INFORMATION, OK, "USER-1019");  
	    return;
	}
    if (gTreeLvl != 4){ 
        showMessage(STOPSIGN, OK, "USER-1000",  "삭제 할 프로그램을 선택하십시오.");
        return;
    } 
	    
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
	    return;
	}
	DS_IO_MAIN.DeleteRow(DS_IO_MAIN.RowPosition);    
	
	var strPid = (DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE")).substring(6,14);
	var goTo       = "save";
    var action     = "I";

    TR_MAIN.Action="/pot/tcom202.tc?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MAIN=DS_IO_MAIN)"; 
    TR_MAIN.Post();

	//Wec.ActiveTab = 0;
	//Wec.openFile("jsp/namo/defdoc.htm");
    selectHelp(strPid);
    
}

/**
 * btn_Excel()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */ 
function btn_Excel() { 
}

/**
 * btn_Print()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */ 
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : 확정 처리
 * return값 : void
 */ 
function btn_Conf() {
}   
 
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * showTreeView()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-11
 * 개    요 : 트리 형태로 값을 뿌려줍니다.
 * return값 : void
 */
 function showTreeView(){
     TV_MAIN.ClearAll(); 

     var goTo       = "treeview";    
     var parameters = "&strSubSystem="+encodeURIComponent(LC_SUB_SYSTEM.ValueOfIndex("CODE", LC_SUB_SYSTEM.Index)) ;
     var action     = "O"; 
     
     TR_MAIN.Action="/pot/tcom202.tc?goTo="+goTo+parameters;   
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_TREE_MAIN=DS_O_TREE_MAIN)"; //조회는 O 
     TR_MAIN.Post();   
 }
 /**
  * selectHelp()
  * 작 성 자 : ckj
  * 작 성 일 : 2006-07-11
  * 개    요 : 트리선택시(소메뉴까지 선택 시) 도움말 조회
  * return값 : void
  */
function selectHelp(pid)
{
    var goTo       = "selectHelp" ;    
    var action     = "O";     
    var parameters = "&strPid="+ encodeURIComponent(pid);
    //alert("")
    TR_MAIN.Action  ="/pot/tcom202.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MAIN=DS_IO_MAIN)"; //조회는 O
    TR_MAIN.Post();     
    //Wec.Value = TEXT_CONTENT.Text;
}

-->
</script>
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) 
    {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 서브시스템 LUXCOMBO 상태 변경시   -->
<script language=JavaScript for=LC_SUB_SYSTEM event=onSelChange()>
    showTreeView();
</script> 

<!-- 트리 메뉴 클릭시 이벤트 : Grid와 연동(Tree=>Grid)하기   -->
<script language=JavaScript for=TV_MAIN event=OnClick()>
	gTreeLvl =  TV_MAIN.ItemLevel;
	
    var code = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE"); 
     
    if( TV_MAIN.ItemLevel==4 )
    {
        if (code == gTreeCd) return;
        
        //Wec.EditMode = 1; 
    	code = code.substring(6,14); 
    	
    	EM_PROGRAM_NM.text = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "TXT");
        selectHelp(code); 
    }
    else  
	{
	   	DS_IO_MAIN.ClearData();
	   	// 메뉴단위인 경우 데이터celar
		//Wec.TextValue = ""; 
		//Wec.HeadValue = ""; 
	   	//Wec.ActiveTab = 0;
	   	EM_PROGRAM_NM.Text = "";
    	//Wec.EditMode = 0; 
	}

    gTreeCd = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE");
</script> 
<script language=JavaScript for=DS_IO_MAIN event=OnLoadCompleted(rowcnt)>
	
	/*
	Wec.ActiveTab = 0;
	if(TEXT_CONTENT.Text == "")
	{
	   	// 메뉴단위인 경우 데이터celar
		Wec.TextValue = ""; 
		Wec.HeadValue = ""; 
	}
   else 
	   Wec.Value = TEXT_CONTENT.Text;  
   
   if (rowcnt==0)
   {
		Wec.EditMode = 0;   
        showMessage(INFORMATION, OK, "USER-1000", "프로그램이 존재하지 않습니다.");
   }
   else
		Wec.EditMode = 1;
   */
   
   	var notiContent = TEXT_CONTENT.Text;
   
   	//alert(notiContent);
   
 	//데이터 내용 가져올 방법 연구해야 함
	if(notiContent == "") {
		notiContent = "<br>내용이 존재하지 않습니다.";
	}
	
	divTextContent.innerHTML = notiContent;
   
</script>

<script language="JavaScript" FOR="Wec" EVENT="OnInitCompleted()">  
	Wec.EditMode = 0;  
	Wec.SetDefaultFont("맑은 고딕");
	Wec.SetDefaultFontSize("10");
</script>

<!--------------------- 사용자처리 스크립트 끝------------------------>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<comment id="_NSID_">
    <object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>"><param name="KeyName" value="Toinb_dataid4"></object>
</comment><script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_IO_MAIN"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 

<!-- 콤보박스  데이타셋  -->
<comment id="_NSID_"><object id="DS_O_SUBSYSTEM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 트리뷰용 데이터셋 -->
<comment id="_NSID_"><object id="DS_O_TREE_MAIN" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

</head>
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
	    <td class="PT01 PB03" valign="top" width="200">
	        <table width="200" border="0" cellspacing="0" cellpadding="0">
	        <tr><td>
			    <table width="200" border="0" cellspacing="0" cellpadding="0" class="o_table">
			    <tr><td>
		            <!-- search start -->
			        <table width="98%" border="0" cellpadding="0" cellspacing="0" class="s_table ">
			        <tr>
			           <th width="60" class="point">시스템구분</th>
			           <TD>
			               <comment id="_NSID_">
			                   <object id=LC_SUB_SYSTEM classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle"></object>
		                    </comment><script>_ws_(_NSID_);</script>
			           </TD>
		            </TR>
			        </table>
			        <!-- search end -->
		        </td></tr>
		        </table>
	        </td></tr>
	        
	        <tr><td class="nodot"></td></tr>
	        <tr><td class="dot"></td></tr>
	        
	        <tr ><td> 
	            <TABLE height="100%" width="100%" border="0" cellspacing="0" cellpadding="0"  >                
	            <TR>
		            <!-- 메뉴트리 -->
		            <TD width="200" align=center valign="top" class="BD2A"  >
		                <comment id="_NSID_">
		                  <object id=TV_MAIN classid=<%=Util.CLSID_TREEVIEW%>  width=100% height=506>
		                    <param name=DataID          value="DS_O_TREE_MAIN">
		                    <param name=TextColumn      value="TXT">
		                    <param name=LevelColumn     value="LVL">
		                    <param name=UseImage        value="false">
		                    <param name=ExpandOneClick  value="true">
		                    <param name=BorderStyle     value="0">
		                  </object>
		                  </comment><script>_ws_(_NSID_);</script>
		            </TD>
		         </TR>
		         </table>
	        </td></tr> 
	        </table>
	    </td>
        <td width="3"></td>       
        <td class="PT01 PB03" valign="top">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" > 
	        	<tr><td>
		            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
		            
		            <tr><td>
		                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table"> 
		                <tr>
		                    <th width="60">프로그램명</th>
		                    <td width="150">
		                       <comment id="_NSID_">
		                           <object id=EM_PROGRAM_NM width="150" align="absmiddle"  classid="<%=Util.CLSID_EMEDIT%>"></object>
		                       </comment><script> _ws_(_NSID_);</script>
		                    </td> 
			                <th width="60">등록자</th>
			                <td width="85">
			                   <comment id="_NSID_">
			                       <object id=EM_MOD_NAME width="85" align="absmiddle"  classid="<%=Util.CLSID_EMEDIT%>"></object>
			                   </comment><script> _ws_(_NSID_);</script>
			                 </td> 
		                    <th width="60">등록일시</th>
		                    <td >
		                       <comment id="_NSID_">
		                           <object id=EM_MOD_DATE width="125" align="absmiddle"  classid="<%=Util.CLSID_EMEDIT%>"></object>
		                       </comment><script> _ws_(_NSID_);</script>
		                     </td> 
		                
		                </tr>
		                </table>
		            </td></tr> 
		            </table>
		       	</td></tr>
	          
	            <tr><td class="nodot"></td></tr>
	            <tr>
	            	<td height="513">
			     		<!-- script language="javascript" src="/pot/jsp/namo/NamoWec7.js"></script-->
			     		<div id="divTextContent" style="overflow-y:scroll; width:100%; height:513; border:1; padding:4px;"></div>
	            	</td>
	            </tr>
            </table>  
         </td>
  </tr>
 </table> 
</DIV>
 
<div id="divComp">
<comment id="_NSID_"> 
    <object id=TEXT_CONTENT classid=<%=Util.CLSID_TEXTAREA%>  width=0 height=0>
        <param name=Enable         value="true">
        <param name=ReadOnly       value="false">
        <param name=CacheLoad      value="true">
        <param name=ApplyRTF       value="true">
        <param name=ApplyUTF8      value="true">
    </object>
</comment>
<script> _ws_(_NSID_);</script>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
  <object id=BD_HEADER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_IO_MAIN>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value=' 
            <c>col=URL_CONTENT        ctrl=TEXT_CONTENT         Param=Src</c> 
            <c>col=MOD_NAME           ctrl=EM_MOD_NAME          Param=Text</c> 
            <c>col=MOD_DATE           ctrl=EM_MOD_DATE          Param=Text</c> 
        '> 
  </object>
</comment>
<!--             
<c>col=URL_CONTENT        ctrl=TEXT_CONTENT     Param=src</c>
<c>col=URL_CONTENT        ctrl=Wec              Param=BaseURL</c>
<c>col=URL_CONTENT        ctrl=Wec              Param=Wec.BaseURL</c>          
 -->
<script>_ws_(_NSID_);</script>
</body>
</html>
