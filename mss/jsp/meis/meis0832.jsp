<%@page import=" com.softwarefx.chartfx.server.*
               , com.softwarefx.StringAlignment
               , com.softwarefx.chartfx.server.dataproviders.*
               , java.awt.*
               , java.io.*
               , kr.fujitsu.ffw.util.String2
               , kr.fujitsu.ffw.util.Date2
               , kr.fujitsu.ffw.base.BaseProperty"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%    
    String dir        = BaseProperty.get("context.common.dir");
%>
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>구매고객 등급 현황 월별 추이 </title>
  </head>
  <body scroll=no>
<%
    String strErrMsg = request.getAttribute("error").toString();
    if(!"".equals(strErrMsg)){
%>    	
        <script>
            showMessage(STOPSIGN , OK, "SERVER-1001", "<%=strErrMsg%>");
        </script>
<%      
        return;    	
    }
    try{
	    String strData  = request.getAttribute("xmlData").toString();
	    String tabFlag = String2.trimToEmpty(request.getParameter("tabFlag"));
	
	    XmlDataProvider cfxXML = new XmlDataProvider();
	    cfxXML.loadXML(strData);
	    ChartServer chart1 = new ChartServer(pageContext, request, response);

	    chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	    chart1.getLegendBox().setVisible(false);
	    chart1.getDataSourceSettings().setDataSource(cfxXML);
	    chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	    chart1.getSeries().get(0).setColor(Color.black);
	    chart1.getSeries().get(1).setColor(Color.yellow);
	    chart1.getSeries().get(2).setColor(Color.blue);
	    chart1.getSeries().get(3).setColor(Color.green);
	    chart1.getAxisX().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 10));
	    chart1.getDataGrid().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 8));
	    chart1.getDataGrid().setAutoSize(false);
	    chart1.getDataGrid().setHeight(80);

	    //상위타이틀
	    String strTitle = "구매고객 등급 현황 월별 추이";
        if(!"1".equals(tabFlag)) strTitle = "구매고객 등급별 매출현황 월별 추이(단위:백만)";
	    TitleDockable title = new TitleDockable(strTitle);
	    title.setFont(new Font("Malgun Gothic", Font.BOLD,12));
	    title.setAlignment(StringAlignment.CENTER);
	    chart1.getTitles().add(title);
	    
	    String strTitle2 = "구매고객수";
	    if(!"1".equals(tabFlag)) strTitle2 = "매출액";
	    title = new TitleDockable(strTitle2);	    
	    title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
	    title.setAlignment(StringAlignment.CENTER);
	    title.setDock(DockArea.LEFT);
	    chart1.getTitles().add(title);
	
	    DataGrid obj = chart1.getDataGrid();
	    obj.setVisible(true);
	    chart1.setWidth(800);
	    chart1.setHeight(210);
	    chart1.getImageSettings().setInteractive(true);
	    chart1.setContextMenus(false);
	    chart1.renderControl();
%>
  </body>
</html>
<%
    } catch(Exception e){
    	%>      
        <script>
            showMessage(STOPSIGN , OK, "SERVER-1001", "<%=e.getMessage()%>");
        </script>
<%    	
    }
%>
