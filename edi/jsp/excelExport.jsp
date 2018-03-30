<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%
String filename = request.getParameter("filename");
String dir = request.getContextPath();
System.out.println("▶▶▶▶ filename is ... : "+ filename);

response.setHeader("Content-Type", "application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename="+filename+".xls");
//response.setHeader("Content-Disposition", "attachment; filename="+filename);
response.setHeader("Content-Description", "JSP Generated Data");
//response.setContentType("text/html;charset=ISO-8859-1");  //텍스트나 HTML문서이면서 문자인코딩은 ISO-8859-1 전송
response.setContentType("text/html;charset=utf-8");  //텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
%>

${excelSource}
