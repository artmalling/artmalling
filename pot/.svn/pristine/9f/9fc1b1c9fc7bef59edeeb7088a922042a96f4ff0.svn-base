<!-- 
/*******************************************************************************
 * 시스템명 : SMS보내기
 * 작 성 일 : 2010.02.15
 * 작 성 자 : FKL
 * 수 정 자 : 
 * 파 일 명 : tcom4021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 조직코드 조회 팝업
 * 이    력 :
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
<title>SMS보내기</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_pot.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
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
    DS_O_SMS_LIST.setDataHeader('<gauce:dataset name="H_SEL_USER"/>');
    

    initEmEdit(EM_P_NAME    , "GEN^100"     , READ);        // 작성자 
    initEmEdit(EM_TEL1      , "CODE^4^0" , NORMAL);      // 전화번호 
    initEmEdit(EM_TEL2      , "CODE^4^0" , NORMAL);      // 전화번호 
    initEmEdit(EM_TEL3      , "CODE^4^0" , NORMAL);      // 전화번호 
    
    //그리드 초기화
    gridCreate();
     
    EM_P_NAME.Text = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />'; 

    EM_TEL1.Text = '<%=Util.getTelNo1(request)%>'; 
    EM_TEL2.Text = '<%=Util.getTelNo2(request)%>'; 
    EM_TEL3.Text = '<%=Util.getTelNo3(request)%>';  
    
    TXT_CONTENT.Text = "업무용으로만 사용해주세요.\n건당 N원의 비용이 발생합니다.";
    

} 

function gridCreate(){

    var hdrProperies1 = '<FC>id=USER_NAME        width=110    name="성명"         </FC>' 
                      + '<FC>id=HP_NO        	 width=120    name="핸드폰NO"     </FC>'  
                      ;
     initGridStyle(GD_SMS_LIST, "common", hdrProperies1, false); 
                     
}

/*************************************************************************
 * 3. 함수
*************************************************************************/
/**
 * addSendUser()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.07.04
 * 개    요 : 받는사람 추가
 * return값 : void
 */  
function addSendUser()
{
	window.showModalDialog( "/pot/tcom402.tc?goTo=addSendUserPop"
            , window.self
            , "dialogWidth:800px;dialogHeight:453px;scroll:no;" 
              + "resizable:no;help:no;unadorned:yes;center:yes;status:no");  
}
/**
 * clearSendUser()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.07.04
 * 개    요 : 초기화
 * return값 : void
 */  
function clearSendUser()
{
	TXT_CONTENT.Text = "";
	DS_O_SMS_LIST.ClearData();
}

/**
 * sendSMS()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.07.04
 * 개    요 : SMS전송
 * return값 : void
 */  
function sendSMS()
{
	if( !firstTelFormat(EM_TEL1.Text,"H") )
	{
		 alert("휴대전화 앞자리");
	}
}

/**
 * bookSMS()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.07.04
 * 개    요 : 예약전송
 * return값 : void
 */  
function bookSMS()
{
	window.showModalDialog( "/pot/tcom402.tc?goTo=bookSmsPop"
            , window.self
            , "dialogWidth:310px;dialogHeight:140px;scroll:no;" 
              + "resizable:no;help:no;unadorned:yes;center:yes;status:no");  

}
/**
 * onCheckLength()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  공지내용 입력 길이 저장
 * return값 : void
 */
function onCheckLength(){   
	 
	if (getByteValLength(TXT_CONTENT.Text) > 80 ) 
	{  
	    showMessage(STOPSIGN, OK, "USER-1000", "내용은 최대 80byte만 가능합니다.");  
		TXT_CONTENT.Text = cutByte(80); 
	}

	 document.all.spanByte.innerHTML ="<font color=white>" +  getByteValLength(TXT_CONTENT.Text) + " Byte </font>";
}

function cutByte(len)
{
	var str = TXT_CONTENT.Text;
	var l = 0;
	for (var i =0; i<str.length; i++)
	{
		l += (str.charCodeAt(i)>128)? 2:1;
		if(l>len) return str.substring(0,i);
	}
	
	return str;
}
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

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=TXT_CONTENT event=OnChange()>
	document.all.spanByte.innerHTML ="<font color=white>" +  getByteValLength(TXT_CONTENT.Text) + " Byte </font>"; 
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
<comment id="_NSID_"><object id=DS_O_SMS_LIST classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>"><param name="KeyName"   value="Toinb_dataid4"></object></comment><script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="PB05 PT05">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="" class="title">
                  <img src="/<%=dir%>/imgs/comm/title_head.gif" align="absmiddle" class="popR05 PL03" />
                  <SPAN id="title1" class="PL03">SMS전송</SPAN>
                </td>
                <td>
                  <table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><img src="/<%=dir%>/imgs/btn/close.gif"   onClick="btn_Close();" /></td>
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
        <td class="PT10 PL20 PR20 PB20"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td><table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="p_sms01"></td>
              </tr>
              <tr>
                <td valign="top" class="p_sms02 PT20"><table width="182" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="230" colspan="2" valign="top" class="p_sms02_bx01"><table width="170" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td class="PT10 PB05"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="100%" class="PL10" ><img src="./imgs/sms/sms_icon.gif" width="23" height="12"></td>
                            <td><img src="./imgs/sms/sms_icon_02.gif" width="13" height="9"></td>
                            <td class="PL10 PR10"><img src="./imgs/sms/sms_icon_03.gif" width="14" height="9"></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td><img src="./imgs/sms/phine_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td  class="p_sms_input"> 	 
	                      <comment id="_NSID_">
	                          <object id=TXT_CONTENT classid=<%=Util.CLSID_TEXTAREA%> width=100% height=205 tabindex=8 align="absmiddle"  
                          onkeyup="javascript:onCheckLength();"
                          onkeydown="javascript:onCheckLength();" 
                          onkeypress="javascript:onCheckLength();"
                          ></object>
	                      </comment><script> _ws_(_NSID_);</script>
						</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td colspan="2"  class="p_sms02_bx02" align="right"><span id = "spanByte"></span></td>
                  </tr>
                  <tr valign="top">
                    <td class="PT03"><img src="./imgs/sms/sms_btn_01.gif" width="139" height="53" onClick="sendSMS();"></td>
                    <td  class="right PT03"><img src="./imgs/sms/sms_btn_02.gif" width="41" height="53" onClick="bookSMS();"></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td class="p_sms03">&nbsp;</td>
              </tr>
            </table></td>
            <td width="300"><table width="290" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td class="PT20 PB10"><img src="./imgs/sms/sms_tx_01.gif" width="65" height="14"></td>
              </tr>
              <tr>
                <td><table width="290" border="0" cellspacing="0" cellpadding="0" class="BD5A">
                  <tr>
                    <td class="center"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD2A">
                      <tr>
                        <td class="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="100" height="29" bgcolor="#F3F3F3" class="PL05 PR05 center" > 
			                   <comment id="_NSID_">
			                       <object id=EM_P_NAME width="100" align="absmiddle"  classid="<%=Util.CLSID_EMEDIT%>"></object>
			                   </comment><script> _ws_(_NSID_);</script>
                            </td>
                            <td class="PL05 PR05 left">
			                    <comment id="_NSID_"><object id=EM_TEL1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=4 > </object> </comment> <script> _ws_(_NSID_);</script>
			                    -
			                    <comment id="_NSID_"><object id=EM_TEL2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=5 > </object> </comment> <script> _ws_(_NSID_);</script>
			                    - 
			                    <comment id="_NSID_"><object id=EM_TEL3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=6 > </object> </comment> <script> _ws_(_NSID_);</script>
			                 </td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
             
              <tr>
                <td class="PT20 PB02"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="100" class=" PR05" >
                    	<img src="./imgs/sms/sms_tx_02.gif" width="65" height="14">
                    </td>
                    <td class="PL05 PR05 right">
                    	<img src="./imgs/btn/add_s.gif" 	width="42" height="18" hspace="2" onClick="addSendUser();">
                    	<img src="./imgs/btn/reset_s.gif" 	width="52" height="18" hspace="2" onClick="clearSendUser();">
                    </td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td><table width="290" border="0" cellspacing="0" cellpadding="0" class="BD5A">
                  <tr>
                    <td class="center"> 
		            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">
			            	<tr><td>
								<comment id="_NSID_"><OBJECT id=GD_SMS_LIST width=100% height="255" classid=<%=Util.CLSID_GRID%>>
								<param name=DataID   value="DS_O_SMS_LIST"> 
							</OBJECT></comment><script>_ws_(_NSID_);</script>
							</td></TR>
		            	</table>
                    
                    </td>
                  </tr>
                </table></td>
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
</html>
