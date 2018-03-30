<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ page import="ecmn.dao.EDcs101DAO"%><%

  String strCardNo = request.getParameter("cardNo");
  String strFromDt = request.getParameter("fromDt");
  String strToDt   = request.getParameter("toDt");

  EDcs101DAO dao = new EDcs101DAO();

  String xmlInfo = dao.getXmlInfo(strCardNo, strFromDt, strToDt);
  //alert("xmlInfo==="+xmlInfo);
  out.print(xmlInfo);

%>

