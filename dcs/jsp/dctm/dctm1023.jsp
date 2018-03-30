<%@page import="KISINFO.VNO.VNOInterop"%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.SNameCheck,
																	   common.NameCheck,				
																	   common.util.Util, 
                                                                       common.vo.SessionInfo, java.net.URLDecoder,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*"%>
<jsp:useBean id="NC6" class="common.SNameCheck" scope="request"/>
<jsp:useBean id="NC" class="common.NameCheck" scope="request"/>
<%

String SITECODE = ""; //나신평에서 발급받은 아이디
String SITEPW   = ""; //나신평에서 발급받은 패스워드
String sJumin	= request.getParameter("sJumin");
String sName 	= URLDecoder.decode(String2.trimToEmpty(request.getParameter("sName")), "UTF-8");
String sSiteCode				= "D081";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
String sSitePw					= "mARIO123";		// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
String sFlag		= "JID";	//주민번호:JID 안심키(외국인???):SID???
KISINFO.VNO.VNOInterop vnoInterop = new KISINFO.VNO.VNOInterop();

if(sJumin.length() == 6){
	SITECODE = "AC51";
	SITEPW = "74469442";
}else{
	SITECODE = "AC51";
	SITEPW = "74469442";
}

//주민번호와 이름 사이트아이디 패스워드의 값을 나신평에 넘겨주고 Rtn 에 리턴값을 받는다.
if((!sJumin.equals("")) && (!sName.equals(""))) {
	String Rtn = "";
	if(sJumin.length() == 6){
		Rtn = NC6.fnNameCheck(SITECODE, SITEPW, sJumin, sName);  //주민번호 앞자리 인증
	}else{
		NC.setChkName(sName);				// 
		Rtn = NC.setJumin(sJumin+SITEPW);
		
		//정상처리인 경우
		if(Rtn.equals("0")) 
		{
			NC.setSiteCode(SITECODE);
			NC.setTimeOut(30000);
			Rtn = NC.getRtn().trim(); 
		}		
	}
	
    if (Rtn.substring(0,1).equals("1")) {
    		int iRtnDI = vnoInterop.fnRequestDupInfo(sSiteCode, sSitePw, sJumin, sFlag);
    		String sDupInfo = vnoInterop.getDupInfo();
    		int iRtnCI = vnoInterop.fnRequestConnInfo(sSiteCode, sSitePw, sJumin, sFlag);
    		String sConnInfo = vnoInterop.getConnInfo();
    		if(iRtnDI == 1&& iRtnCI == 1){
    	    	//String gender = vnoInterop.getGender();
    	    	//String nationalInfo = vnoInterop.getNationalInfo();
%>
		<script language='javascript'>     
			alert("인증 성공");
    		parent.confirmName('<%=Rtn%>', 'Y', "<%=sDupInfo%>", "<%=sConnInfo%>");
    	</script>
<%      		
    		}else{
    			%>
    			<script language='javascript'>
    				alert("www.namecheck.co.kr 의 실명등록확인 또는 02-1600-1522 콜센터로 문의주시기 바랍니다.");
    				parent.confirmName('<%=Rtn%>', 'N', "", "");
    			</script>			
    	<%			
    		}
    	}else{
%>
		<script language='javascript'>
			alert("www.namecheck.co.kr 의 실명등록확인 또는 02-1600-1522 콜센터로 문의주시기 바랍니다.");
			parent.confirmName('<%=Rtn%>', 'N', "", "");
		</script>			
<%
	}
}else{
	out.println("성명이나 주민번호를 확인하세요.");
}
%>

