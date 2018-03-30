<!-- 
/*******************************************************************************
 * 시스템명 : 공지사항관리
 * 작 성 일 : 2010.02.15
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : ccom9140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 도움말관리 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty, java.util.List"   %>
   
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
<title>공지사항-POPUP</title>
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
var strDeptMsg = "";
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
    DS_O_NOTICE.setDataHeader('<gauce:dataset name="H_NOTICE"/>');
    DS_O_DEPT_CD.setDataHeader('<gauce:dataset name="H_NOTICE_DEPT"/>');
    
    var parameters = dialogArguments;

	TR_MAIN.Action="/pot/ccom914.cc?goTo=searchNoticeMainPop"+parameters;
	TR_MAIN.KeyValue="SERVLET(O:DS_O_NOTICE = DS_O_NOTICE, O:DS_O_DEPT_CD = DS_O_DEPT_CD)";
	TR_MAIN.Post();
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
    
/**
 * saveAsFiles()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function downFile() {
        
       var strPath   = "notice/";    
       var strFileNm = DS_O_NOTICE.NameValue(DS_O_NOTICE.Rowposition, "FILE_NM");       
       if( strPath != null  ) {                          
           iFrame.location.href="/pot/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+strFileNm;
	   }   
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
<script language=JavaScript for=DS_O_NOTICE event=OnLoadCompleted(rowcnt)>  
  	document.all.tdTitle.innerText	= DS_O_NOTICE.NameValue(0,"NOTI_TITLE");  
 	document.all.tdGbn.innerText  	= DS_O_NOTICE.NameValue(0,"SEND_TO_ALL") + strDeptMsg; 
 	document.all.tdDate.innerText 	= DS_O_NOTICE.NameValue(0,"S_DATE") + "~" + DS_O_NOTICE.NameValue(0,"E_DATE"); 
 	document.all.tdName.innerText 	= DS_O_NOTICE.NameValue(0,"USER_NAME") ; 
 	document.all.tdTel.innerText  	= DS_O_NOTICE.NameValue(0,"TEL1")+ "-" + DS_O_NOTICE.NameValue(0,"TEL2") + "-" + DS_O_NOTICE.NameValue(0,"TEL3") ; 
 
 	if(DS_O_NOTICE.NameValue(0,"FILE_NM") != "")
 	{
 	 	document.getElementById("tdFile").innerHTML = "<img src='/"+"<%=dir%>"+"/imgs/btn/file_down.gif'  onclick='downFile();' align='absmiddle' />  " 
			+ DS_O_NOTICE.NameValue(0,"FILE_NM") ;
 	}

	var content ="";
	var sttHelpUrl = DS_O_NOTICE.NameValue(1, "NOTI_CONTENT");  
	content += "<table width='810' height='500' border='5' cellspacing='0' cellpadding='0' class='g_table'>";    
	content += "<tr><td>";

	if(sttHelpUrl == "")
		content += "<br>내용이 존재하지 않습니다.";
	else 
		content += "<br><iframe id='frmid' name='frm'  width='810'  height='500' frameborder='2'  marginwidth='0' marginheight='0'scrolling='auto' src='"+sttHelpUrl+"'></iframe>"; 
	   

    content += "</td></tr>";
	content += "</table>";
 
    document.getElementById("divContent").innerHTML = content; 

 	
 	
</script>

<script language=JavaScript for=DS_O_DEPT_CD event=OnLoadCompleted(rowcnt)>   
  
	if (DS_O_DEPT_CD.CountRow> 0)
	{
		strDeptMsg += " ( ";
		for(var i=1; i<=DS_O_DEPT_CD.CountRow; i++)
		{
			strDeptMsg+= ( DS_O_DEPT_CD.NameValue(i, "STR_NAME") + " " + DS_O_DEPT_CD.NameValue(i, "DEPT_NAME"));
			if (i < DS_O_DEPT_CD.CountRow) strDeptMsg+= " / ";  
		}
		strDeptMsg += " )";
	}
 	//document.all.spanDept.innerHTML = strDeptMsg;
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
<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_NOTICE classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_DEPT_CD classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
<body  onLoad="doInit();">
<iframe id=iFrame  name=iFrame src="about:blank" width=0 height=0 ></iframe>   
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
              <span id="title1" class="PL03">공지사항</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
            </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
		<tr><td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
        	<tr>
	        	<th>구분</th> 
	            <td colspan="3" id="tdGbn"></td> 
         	</tr>      
        	<tr>
	        	<th>게시기간</th> 
	            <td colspan="3" id="tdDate"></td>
         	</tr>
         	
	            <tr>
	              <th width="80">작성자</th>
	              <td id="tdName" width="200"></td> 
	              <th width="80">전화번호</th>
	              <td id="tdTel"></td>
	             </tr>
	             <tr>
	                  <th width="80" >제목</th>
	                  <td colspan =3 id ="tdTitle"></td> 
	              </tr>  
	             <tr>
	                  <th width="80" >첨부파일</th>
	                  <td colspan =3 ><span id ="tdFile"></span></td> 
	              </tr> 
         	</table>
         </td></tr>
         </table>
     </td></tr>
      <tr><td> 
      	<div id="divContent" style="width:810px;height:500px;"></div>   
     </td></tr>
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
