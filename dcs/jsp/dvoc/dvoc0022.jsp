<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%
String fileName = request.getParameter("fileName");

System.out.println("▶▶▶▶ filename is ... : "+ fileName);

response.setHeader("Content-Type", "application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename="+fileName+".xls");
response.setHeader("Content-Description", "JSP Generated Data");
%>
${excelSource}
