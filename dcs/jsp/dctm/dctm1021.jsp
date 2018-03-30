<!-- 
/*******************************************************************************
 * 시스템명 : 가외국인번호생성  팝업
 * 작 성 일 : 2012.05.08
 * 작 성 자 : kj
 * 수 정 자 : 
 * 파 일 명 : dctm1021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 가외국인번호생성  팝업
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
<title>가외국인번호생성-POPUP</title>
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
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var returnMap   = dialogArguments[0];
 
 function doInit(){
 	initEmEdit(EM_BIRTH_DT,     "YYYYMMDD",   PK);
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
     * 개       요 : 가외국인번호생성
     * return값 : void
     */  
    function btn_Conf()
    {
    	 if(EM_BIRTH_DT.text.length == 8){
    		 
   	         var goTo       = "getSsno" ;    
   	         var action     = "O";     
   	         var parameters = "&strBirthDt="+encodeURIComponent(EM_BIRTH_DT.text)+"&strSex="+encodeURIComponent(RD_SEX_FLAG.CodeValue) ;
   	         TR_MAIN.Action="/dcs/dctm102.dm?goTo="+goTo+parameters;  
   	         TR_MAIN.KeyValue="SERVLET("+action+":DS_O_CARD=DS_O_CARD)"; //조회는 O
   	         TR_MAIN.Post();
    	 }
    }
    
    function sendClose(){
    	window.returnValue = true;
    	window.close();    	
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
		if(TR_MAIN.SrvErrMsg('UserMsg',i).indexOf("rst:")!=-1){		
/********** 가외국인번호 생성 로직 사용안함
 			
			var sex; //외국인번호 뒷자리 1
		    var ret =  TR_MAIN.SrvErrMsg('UserMsg',i).substring(4,8); //외국인번호 뒷자리 2~5
		      
		    if(EM_BIRTH_DT.text.substring(0,2) == '19'){
		    	if(RD_SEX_FLAG.CodeValue == 'M') sex == '5';
		    	else sex = '6';
		    }else if(EM_BIRTH_DT.text.substring(0,1) == '2'){
		      	if(RD_SEX_FLAG.CodeValue == 'M') sex = '7';
		    	else sex = '8';
		    }
		      
		    var ssno = EM_BIRTH_DT.text.substring(2,8) + sex + ret + '0'; //외국인번호 뒷자리 6 (무조건 0)		      	      
		    var sum = 0; //외국인번호 뒷자리 7 (chkDigit)
		      
		    buf = new Array(13);
		    for (i = 0; i < 13; i++) buf[i] = parseInt(ssno.charAt(i));		      
		    multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
			for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
			sum=11-(sum%11);if (sum>=10) sum-=10;sum += 2;
			if (sum>=10) sum-=10;
			
			window.returnValue = ssno + sum;
**********/
			returnMap.put("SS_NO", TR_MAIN.SrvErrMsg('UserMsg',i).substring(4,17));
			sendClose();
		}else{
            showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
		}
    }  
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
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
<object id="DS_O_CARD" classid=<%=Util.CLSID_DATASET%>> </object>
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
              <span id="title1" class="PL03">가외국인번호생성</span>
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
                <th width="50">성별</th>
                <td><comment id="_NSID_"><object id=RD_SEX_FLAG
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 120"
								align="absmiddle">
								<param name=Cols value="2">
								<param name=Format value="M^남자,F^여자">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="M">
							</object> </comment> <script> _ws_(_NSID_);</script>
				</td>
              </tr>
              <tr>
                <th width="50">본인생일</th>
                <td><comment id="_NSID_"> <object id=EM_BIRTH_DT
					classid=<%=Util.CLSID_EMEDIT%> height=20 width=70 align="absmiddle">
					</object> </comment> <script> _ws_(_NSID_);</script> <img
					src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
					onclick="javascript:openCal('G',EM_BIRTH_DT)" />
                </td>
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

</body>
</html>
