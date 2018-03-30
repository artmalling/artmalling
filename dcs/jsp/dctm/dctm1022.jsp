<!-- 
/*******************************************************************************
 * 시스템명 : 실명인증  팝업
 * 작 성 일 : 2012.05.08
 * 작 성 자 : kj
 * 수 정 자 : 
 * 파 일 명 : dctm1022.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실명인증  팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<title>실명확인-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var returnMap   = dialogArguments[0];
var sJumin  	= dialogArguments[1];
var sName   	= dialogArguments[2];
var sId     	= dialogArguments[3];
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
 function doInit(){
	 initEmEdit(EM_CUST_NAME,    "GEN^40",     PK);         //성명
	 initEmEdit(EM_SS_NO,        "000000", 	   PK);       //생년월일/사업자번호
	 EM_CUST_ID.style.display  = "none";
	 EM_CUST_NAME.Language = 1;

	 EM_CUST_NAME.Text	= sName;
	 EM_SS_NO.Text 		= sJumin;
	 EM_CUST_ID.Text	= sId;
	 
	 EM_CUST_NAME.Focus();
 }	
 
/*************************************************************************
 * 2. 함수
*************************************************************************/

   /**
    * btn_Close()
    * 작 성 자 : kj
    * 작 성 일 : 2012.05.08
    * 개    요 : Close
    * return값 : void
    */  
    function btn_Close()
    {
        window.returnValue = false; 
        window.close();
    }
    
    /**
     * insSsno()
     * 작 성 자 : kj
     * 작 성 일 : 2012.05.08
     * 개       요 : 실명확인
     * return값 : void
     */  
    function confirmName(strRtnCode, strConfYn, DI, CI)
    {
    	 var goTo       = "insRealName" ;    
   	     var action     = "O";     
	   	 var parameters = "&strSsno=" + encodeURIComponent(EM_SS_NO.Text)
						+ "&strCustName=" + encodeURIComponent(EM_CUST_NAME.text)
						+ "&strCustId=" + encodeURIComponent(EM_CUST_ID.Text)
						+ "&strRtnCode=" + encodeURIComponent(strRtnCode)
						+ "&strConfYn=" + encodeURIComponent(strConfYn) ;
   	     TR_MAIN.Action="/dcs/dctm102.dm?goTo="+goTo+parameters;  
   	     TR_MAIN.KeyValue="SERVLET("+action+":DS_LOG=DS_LOG)"; //조회는 O
   	     TR_MAIN.Post();

   	     sendClose(strConfYn, DI, CI);
    }
    
    function sendClose(strConfYn, DI, CI){
   		
   		//생년월일 기본 세팅.
   		var birthDt;
        if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="2"){
        	birthDt = "19"+EM_SS_NO.Text.substring(0,6);
        }else if(EM_SS_NO.Text.substring(6,7)=="3" || EM_SS_NO.Text.substring(6,7)=="4"){
        	birthDt = "20"+EM_SS_NO.Text.substring(0,6);
        }
   		if(trim(EM_SS_NO.text).length == 6) birthDt = "19"+EM_SS_NO.Text.substring(0,6);
   		
		//성별 기본 세팅.
		var sexCd;
		if(EM_SS_NO.Text.substring(6,7)=="1" || EM_SS_NO.Text.substring(6,7)=="3"
		 || EM_SS_NO.Text.substring(6,7)=="5" || EM_SS_NO.Text.substring(6,7)=="7"){
			sexCd = "M";
		}else{
			sexCd = "F";
		}
		if(trim(EM_SS_NO.text).length == 6) sexCd = "";      		
   		
    	returnMap.put("CONF_YN", strConfYn);
    	returnMap.put("CUST_NAME", EM_CUST_NAME.Text);
   		returnMap.put("SS_NO", EM_SS_NO.Text);   		
   		returnMap.put("BIRTH_DT", birthDt);
   		returnMap.put("SEX_CD", sexCd);
   		returnMap.put("DI", DI);
   		returnMap.put("CI", CI);
   		returnMap.put("ALIEN_YN", "Y");
   		returnMap.put("POSITION_ETC", 4);
    	window.returnValue = true;
    	window.close();    	
    }
    
    function btn_Conf() {

        if(trim(EM_CUST_NAME.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1003",  "성명");
            EM_CUST_NAME.Focus();
            return;
        }
        if(trim(EM_SS_NO.text) == ""){
            showMessage(EXCLAMATION, OK, "USER-1003",  "생년월일");
            EM_SS_NO.Focus();
            return;
        } 
        
    	var parameters  = "sJumin="	+ encodeURIComponent(EM_SS_NO.text)
    					+ "&sName="	+ encodeURIComponent(EM_CUST_NAME.text)
    					+ "&sId="	+ encodeURIComponent(sId) ;    

        document.getElementById("realName").src = '/dcs/jsp/dctm/dctm1023.jsp?' + parameters;
    }
    
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
    //for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
    //	showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    //}  
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    //trFailed(TR_MAIN.ErrorMsg);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LOG" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">
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
              <span id="title1" class="PL03">외국인확인</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td></td>
                <td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50" height="22" onClick="btn_Conf()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="popT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="58">성명</th>
                <td><comment id="_NSID_"> <object
								id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
								tabindex=1
								onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
								<comment id="_NSID_">
								<object id=EM_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=0
								align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
				</td>
              </tr>
              <tr>
                <th width="58">외국인번호</th>
                <td><comment id="_NSID_"> <object id=EM_SS_NO
								classid=<%=Util.CLSID_EMEDIT%> width=150 align="absmiddle"
								tabindex=2> </object> </comment> <script> _ws_(_NSID_);</script>
                </td>
                <comment id="_NSID_"> <object id=EM_CI
										classid=<%=Util.CLSID_EMEDIT%> width=50 align="absmiddle"
										tabindex=5 style="display:none;"> </object> </comment> <script> _ws_(_NSID_);</script>
										<comment id="_NSID_"> <object id=EM_DI
										classid=<%=Util.CLSID_EMEDIT%> width=600 align="absmiddle"
										tabindex=5 style="display:none;"> </object> </comment> <script> _ws_(_NSID_);</script>
              </tr>
            </table></td>
          </tr>
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
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<div style=position:absolute;left:0px;margin-top:0px;margin-left:0px;float:left;> 
	<iframe id="realName" src="" scrolling="no" frameborder="0" width="0" height="0" topmargin="0" leftmargin="0" ></iframe> 
</div> 
</body>
</html>
