<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%
	//**************************************************************************************************************
	//나이스평가정보 Copyright(c) NICE INFOMATION SERVICE INC. ALL RIGHTS RESERVED
	//
	//서비스명 : 마이핀('내번호') 서비스
	//페이지명 : 마이핀('내번호') 팝업 결과 처리 페이지
	//$ID$
    //**************************************************************************************************************

	String enc_data = request.getParameter("enc_data");		//인증 결과및 부가 정보를 암호화한 데이타입니다.
									//이 소스는 수신받은 데이터(인증결과)를 메인화면으로 전달 후 close 하는 역할을 합니다.
	String param_r1 = request.getParameter("param_r1"); 
	String param_r2 = request.getParameter("param_r2"); 
	String param_r3 = request.getParameter("param_r3"); 
	
	if (!enc_data.equals("") && enc_data != null) {
%>			
<head>
	<title>나이스평가정보 마이핀(내번호) 본인확인 서비스</title>
<script language='javascript'>
    function fnLoad() {
	    parent.opener.parent.document.vnoform.enc_data.value = "<%=enc_data%>";
		parent.opener.parent.document.vnoform.target = "Parent_window"; 				

		//인증완료시에 인증 결과를 수신하게 되는 고객 클라이언트 결과 페이지 URL
		parent.opener.parent.document.vnoform.action = "mypin_result.jsp";
		parent.opener.parent.document.vnoform.submit();
		self.close();
    }
</script> 		
</head>

<body onLoad="fnLoad()">
<%
    } else {
%>
<body onLoad="self.close()">
<%
	}
%>
</body>