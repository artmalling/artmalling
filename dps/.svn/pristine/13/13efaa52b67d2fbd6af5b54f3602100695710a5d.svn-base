<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : datagridtrue
    Created on : Mar 14, 2008, 3:33:41 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datagrid</title>
    </head>
    <body>
        <% 
        ChartServer chart1 = new ChartServer(pageContext, request, response);
        chart1.getLegendBox().setVisible(false);

        DataGrid obj = chart1.getDataGrid();
        obj.setVisible(true);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
%>
    </body>
</html>
