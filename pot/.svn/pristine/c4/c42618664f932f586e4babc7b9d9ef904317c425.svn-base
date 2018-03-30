<!-- 
/*******************************************************************************
 * 시스템명 : SMS보내기 
 * 작 성 일 : 2010.02.15
 * 작 성 자 : FKL
 * 수 정 자 : 
 * 파 일 명 : tcom4022.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 예약발송 팝업
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
<title>예약발송-POPUP</title>
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
	initEmEdit(EM_S_DATE    , "SYYYYMMDD"   , PK);          // 조회기간1
	initComboStyle(LC_O_HOUR,   DS_O_HOUR,		"CODE^0^20,NAME^0^30",  1, NORMAL);     //예약시간
	initComboStyle(LC_O_MINUTE,	DS_O_MINUTE,    "CODE^0^20,NAME^0^30",  1, NORMAL);     //예약 분 

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_HOUR"	, "D", "M059", "N");
    getEtcCode("DS_O_MINUTE", "D", "M060", "N");
    
    LC_O_HOUR.index = 0;
    LC_O_MINUTE.index = 0;
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
<comment id="_NSID_"><object id="DS_O_MINUTE"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_HOUR"     	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<table width="310" border="0" cellspacing="0" cellpadding="0">
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
            		<img src="./imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/> 예약발송</td>
            	<td width="120">
            		<table border="0" align="right" cellpadding="0" cellspacing="0">
              		<tr>
                		<td><img src="./imgs/btn/close.gif"  width="50" height="22" onClick="btn_Close();" /></td>
              		</tr>
            		</table>
            	</td>
			</tr>
        	</table>
        </td></tr>
      	 
        
       	<tr><td class="dot"></td></tr>
       	
      	<tr><td> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr><td>
      			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
	          	<tr>
	          		<th width="80">예약일자</td>
	                <td >
	                   <comment id="_NSID_"> 
	                       <object id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width=137 align="absmiddle"> </object> 
	                   </comment><script> _ws_(_NSID_);</script>
	                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT onclick="javascript:openCal('G',EM_S_DATE)" align="absmiddle" />
	                </td> 
				</tr>
				<tr>
	          		<th width="80" >예약시간</td>
	                <td >
	                	<comment id="_NSID_"> <object id=LC_O_HOUR classid=<%= Util.CLSID_LUXECOMBO %> 	 height=100 width=70 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
	                	<comment id="_NSID_"> <object id=LC_O_MINUTE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=70 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
	                </td> 
	          	</tr>
	          	<tr>
	          		<td colspan="2" align="center"><input type="button" value ="예약전송요청" class="s_table" style="cursor:pointer">
	          	</tr>
	        	</table>
	        </td></tr>
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
