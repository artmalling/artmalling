<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> 임대협력사명판관리 - 미리보기
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8041.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대 협력사의 POS 명판정보 미리보기
 * 이    력 :
 *        2010.04.25 (정진영) 신규작성
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
<title>명판 미리보기</title>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var compName    = dialogArguments[0];
 var compNo      = dialogArguments[1];
 var addr        = dialogArguments[2];
 var repName     = dialogArguments[3];
 var phone1No    = dialogArguments[4];
 var phone2No    = dialogArguments[5];
 var phone3No    = dialogArguments[6];

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	// 바이트에 맞게 자르기
	var tmpRtn = checkByteLengthStr(compName,28,'N');
	if( tmpRtn!=null)
		compName = tmpRtn;
	tmpRtn = checkByteLengthStr(addr,42,'N');
    if( tmpRtn!=null)
    	addr = tmpRtn;
    tmpRtn = checkByteLengthStr(repName,15,'N');
    if( tmpRtn!=null)
    	repName = tmpRtn;
	
	var topStr = rpadB(compName,28," ")+"  "+ compNo.substring(0,3)+"-"+compNo.substring(3,5)+"-"+compNo.substring(5);
	var btmStr = '대표자 : ' + rpadB(repName,15," ")+'  ☎'+lpadB((phone1No+"-"+phone2No+"-"+phone3No),14," ");
	TOP_TITLE.innerHTML = replaceStr(topStr," ", "&nbsp;");
	MID_TITLE.innerHTML = replaceStr(rpadB(addr,42," ")," ", "&nbsp;");
	BTM_TITLE.innerHTML = replaceStr(btmStr," ", "&nbsp;");
}

/**
 * lpadB()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Byte로 LPAD
 * return값 : void
 */
function lpadB(strTarget, intLen, strChar) {
	var targetByte = getByteValLength(strTarget.trim());
	var intLength = intLen - targetByte;
	var strTemp   = "";
	if (targetByte == 0) return "";
	if (intLength <=0) intLen = 0;	
	for (var i=1;i<=intLength;i++) {
	    strTemp = strTemp + strChar;
	}
    return strTemp + strTarget.trim();
}
/**
 * rpadB()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 :  Byte로 RPAD
 * return값 : void
 */
function rpadB(strTarget, intLen, strChar) {
    var targetByte = getByteValLength(strTarget.trim());
    var intLength = intLen - targetByte;
    var strTemp   = "";
    if (targetByte == 0) return "";
    if (intLength <=0) intLen = 0;  
    for (var i=1;i<=intLength;i++) {
        strTemp = strTemp + strChar;
    }
    return strTarget.trim()+ strTemp;
}
-->
</script>
</head>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 center">
<span id=TOP_TITLE style="font-family:'굴림체'; "></span><br>
<span id=MID_TITLE style="font-family:'굴림체'; "></span><br>
<span id=BTM_TITLE style="font-family:'굴림체'; "></span>
</body>
</html>

