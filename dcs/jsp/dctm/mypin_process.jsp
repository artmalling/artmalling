<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%
	//**************************************************************************************************************
	//���̽������� Copyright(c) NICE INFOMATION SERVICE INC. ALL RIGHTS RESERVED
	//
	//���񽺸� : ������('����ȣ') ����
	//�������� : ������('����ȣ') �˾� ��� ó�� ������
	//$ID$
    //**************************************************************************************************************

	String enc_data = request.getParameter("enc_data");		//���� ����� �ΰ� ������ ��ȣȭ�� ����Ÿ�Դϴ�.
									//�� �ҽ��� ���Ź��� ������(�������)�� ����ȭ������ ���� �� close �ϴ� ������ �մϴ�.
	String param_r1 = request.getParameter("param_r1"); 
	String param_r2 = request.getParameter("param_r2"); 
	String param_r3 = request.getParameter("param_r3"); 
	
	if (!enc_data.equals("") && enc_data != null) {
%>			
<head>
	<title>���̽������� ������(����ȣ) ����Ȯ�� ����</title>
<script language='javascript'>
    function fnLoad() {
	    parent.opener.parent.document.vnoform.enc_data.value = "<%=enc_data%>";
		parent.opener.parent.document.vnoform.target = "Parent_window"; 				

		//�����Ϸ�ÿ� ���� ����� �����ϰ� �Ǵ� �� Ŭ���̾�Ʈ ��� ������ URL
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