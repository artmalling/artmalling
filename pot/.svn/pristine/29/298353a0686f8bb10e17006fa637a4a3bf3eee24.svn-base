<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1046.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 사용자별 프로그램 사용권한(TAB1) 권한복사-> 팝업
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
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>권한-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script> 
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************--> 
<script LANGUAGE="JavaScript">
/**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-15
 * 개    요 : initialize
 * return값 : void
 */

var strTUserId    = dialogArguments[0];
var strTUserName  = dialogArguments[1];  
var opener        = dialogArguments[2]; 
var strGubun      = dialogArguments[3]; 
 
function doInit() 
{   

	 // 헤더초기화
   	DS_IO_MAIN.setDataHeader ('<gauce:dataset name="H_COPY_MAIN"/>'); 

	initEmEdit(EM_S_EMP_NO	, "GEN^10"	, READ); 	// A
	initEmEdit(EM_S_EMP_NAME, "GEN"		, READ);    // A명 
	initEmEdit(EM_T_EMP_NO	, "GEN^10"	, NORMAL);  // B
	initEmEdit(EM_T_EMP_NAME, "GEN"		, READ);    // B사원명
	
	EM_S_EMP_NO.Text 	= dialogArguments[0];
	EM_S_EMP_NAME.Text 	= dialogArguments[1];
	
	EM_T_EMP_NO.focus();
}  


/**
* btn_Save()
* 작 성 자 : ckj
* 작 성 일 : 2006-08-08
* 개    요 : 권한복사하기
* return값 : void
*/
function btn_Save()
{
	if(EM_T_EMP_NO.Text == "")
	{
        showMessage(EXCLAMATION, OK, "USER-1003", "A");
        EM_T_EMP_NO.focus();
        return;
	}
	
	if(EM_T_EMP_NO.Text == EM_S_EMP_NO.Text)
	{
        showMessage(EXCLAMATION, OK, "USER-1000", "A와 B가 동일합니다.");
        EM_S_EMP_NO.focus();
        return;
	}
	
	if( showMessage(QUESTION, YESNO, "USER-1000", "["+EM_T_EMP_NAME.Text+"]의 권한을 [" + EM_S_EMP_NAME.Text + "]에게 복사하시겠습니까?") != 1 ) 
	        return; 
	
	DS_IO_MAIN.ClearData();
	DS_IO_MAIN.AddRow();
	DS_IO_MAIN.NameValue(1,"T_USER_ID")= EM_T_EMP_NO.Text ;
	DS_IO_MAIN.NameValue(1,"S_USER_ID")= EM_S_EMP_NO.Text ;

    var goTo       = "saveCopyAuth" ;    
    var parameters = "&strGubun="+encodeURIComponent(strGubun);
    
    TR_MAIN.Action="/pot/tcom104.tc?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MAIN = DS_IO_MAIN)";   
    TR_MAIN.Post();  
    
	if (strGubun=="User")
    	opener.parent.showUsrpgm( 'U', EM_S_EMP_NO.Text, opener.DS_IO_USRPGM); 
    else
    	opener.showJjauth(EM_S_EMP_NO.Text); 
    btn_Close();
}
function btn_Close()
{
	this.close();
}
</script>
</head>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************--> 
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
 
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_T_EMP_NO event=onKillFocus()>
   // if (EM_S_EMP_NO.Text.length > 0 ) {
	   if(!this.Modified) return;
        
	    if(this.text==''){
	    	EM_T_EMP_NAME.Text = "";
	        return;
	    } 
	    
        getUserNonPop("DS_O_RESULT", EM_T_EMP_NO, EM_T_EMP_NAME, "E" , "Y", "");       
          
    //}
</script>

<!--------------------- 1. 가우스DataSet  -------------------------------------> 
<comment id="_NSID_"><object id="DS_IO_MAIN"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>    
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>    
<!--------------------- 2. Transaction  ---------------------------------------> 
<comment id="_NSID_"><object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>> <param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

<body  onLoad="doInit();"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">권한복사 : A -> B</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                 <td><img src="/<%=dir%>/imgs/btn/save.gif"   width="50" height="22"   onClick="btn_Save()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif"   width="50" height="22"   onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      
      <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">   
		<tr><td class="popT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          	<tr><td>
          		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              	<tr>
	                <th width="80">A</th> 
		            <td>
		            	<comment id="_NSID_">
		                	<object id=EM_T_EMP_NO classid=<%= Util.CLSID_EMEDIT %> width=78 tabindex=0 align="absmiddle"></object>
		                </comment><script>_ws_(_NSID_);</script>
		                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:getUserPop(EM_T_EMP_NO, EM_T_EMP_NAME, 'S', '');" align="absmiddle"/>
		                <comment id="_NSID_">
		                	<object id=EM_T_EMP_NAME classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=0 align="absmiddle"></object>
		                </comment><script>_ws_(_NSID_);</script>
					</TD>
              	</tr>
              	<tr>
	                <th width="80">B</th> 
		            <td>
		            	<comment id="_NSID_">
		                	<object id=EM_S_EMP_NO classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=0 align="absmiddle"></object>
		                </comment><script>_ws_(_NSID_);</script>
		                <comment id="_NSID_">
		                	<object id=EM_S_EMP_NAME classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=0 align="absmiddle"></object>
		                </comment><script>_ws_(_NSID_);</script>
					</TD>
              	</tr>
              	
            	</table>
            </td></tr>
        	</table>
        	</td></tr>
        </table></td>
      </tr>
    </table></td>
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
