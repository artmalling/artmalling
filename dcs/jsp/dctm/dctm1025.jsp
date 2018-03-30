<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
																	                                                                       common.vo.SessionInfo, java.net.URLDecoder,
																	                                                                       kr.fujitsu.ffw.util.*"%> 

<%

/*

아이디: mario1
비번: 마리오1!

인증번호(001) 전송 : 
	mail_code : S0246
	auth_key : IBWT4E-EBQMCM-50BIT1-95LO1E
	
SMS수신동의(002) :	
	mail_code : S0248
	auth_key : H5R0FJ-EKU0PO-0124MI-RESYCS
		
SMS수신거부(003) :	
	mail_code : S0249
	auth_key : U7H1GA-23HAKM-8PMM29-7CJ3KB
	
*/


String sendType				= request.getParameter("sendType");
String M1							= request.getParameter("authNum");
String strMobilePh   		= request.getParameter("strMobilePh");
String strSMSMsg 			= "[형지 아트몰링] 마리오보너스카드 가입을 위한 개인 인증번호는 [" + M1 + "] 입니다.";

String mail_code				= "S0246";
String auth_key				= "IBWT4E-EBQMCM-50BIT1-95LO1E";

if ("002".equals(sendType)) { // 수신동의
	mail_code				= "S0248";
	auth_key				= "H5R0FJ-EKU0PO-0124MI-RESYCS";
	strSMSMsg 			= "[형지 아트몰링] 고객님께서 "+Util.formatDate(new Date(), "yyyy.MM.dd")+" 요청하신 수신동의가 처리 완료되었습니다.";
	M1							= Util.formatDate(new Date(), "yyyy.MM.dd");
} else if ("003".equals(sendType)) { // 수신거부
	mail_code				= "S0249";
	auth_key				= "U7H1GA-23HAKM-8PMM29-7CJ3KB";
	strSMSMsg 			= "[형지 아트몰링] 고객님께서 "+Util.formatDate(new Date(), "yyyy.MM.dd")+" 요청하신 수신거부가 처리 완료되었습니다.";
	M1							= Util.formatDate(new Date(), "yyyy.MM.dd");
}


System.out.println(">>>>>>>>>>>>>>>>>> 여기는 SMS 발송 페이지 <<<<<<<<<<<<<<<<<<<<<<<");

System.out.println("mail_code: " + mail_code);
System.out.println("auth_key: " + auth_key);
System.out.println("strMobilePh: " + strMobilePh);
System.out.println("M1: " + M1);



%>




<script language=JavaScript >	
	
	<% 
	if ("002".equals(sendType) || "003".equals(sendType)) { // 수신동의
	%>
		alert("전송되었습니다.");
	<%
	} else {
	%>
		alert("전송된 인증번호 6자리를 입력해주세요.");
	<%
	}
	%>
	
	parent.insSendMobileLog("<%=strSMSMsg%>");
	
</script>

