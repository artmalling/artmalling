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
    <title>주간 매출 TREND 현황 </title>
  </head>
  <form id="form1" action="/mss/ChartCallbackServlet" method="post">
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
	    String strData1  = request.getAttribute("xmlData1").toString();
	    String strData2  = request.getAttribute("xmlData2").toString();
	    String strPrint  = String2.trimToEmpty(request.getParameter("strPrint"));
	
	    //주간매출 TRNED 현황
	    XmlDataProvider cfxXML = new XmlDataProvider();
	    cfxXML.loadXML(strData1);
	    ChartServer chart1 = new ChartServer();
	    chart1.setFormID("form1");
	    chart1.setAsFirstChart();
	    chart1.setWebContainer(pageContext, request, response);

	    chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	    chart1.getLegendBox().setVisible(false);
	    chart1.getDataSourceSettings().setDataSource(cfxXML);
	    chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	    chart1.getAxisX().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 10));
	    chart1.getDataGrid().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 8));
	    chart1.getDataGrid().setAutoSize(false);
	    chart1.getDataGrid().setHeight(65);

	        
	    //상위타이틀
	    TitleDockable title = new TitleDockable("주간 매출  TREND현황");
	    title.setFont(new Font("Malgun Gothic", Font.BOLD,12));
	    title.setAlignment(StringAlignment.CENTER);
	    chart1.getTitles().add(title);
	    
	    title = new TitleDockable("금액(단위:백만)");
	    title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
	    title.setAlignment(StringAlignment.CENTER);
	    title.setDock(DockArea.LEFT);
	    chart1.getTitles().add(title);
	
	    DataGrid obj = chart1.getDataGrid();
	    obj.setVisible(true);
	    if(!"1".equals(strPrint)){
	    	chart1.setWidth(390);
	        chart1.setHeight(248);
	    } else {
	    	chart1.setWidth(800);
	        chart1.setHeight(500);
	    }
	    
	    chart1.getImageSettings().setInteractive(true);
	    chart1.setContextMenus(false);
	    if(!"1".equals(strPrint)) chart1.renderControl();
	    
	    //객수/객단가 추이
	    XmlDataProvider cfxXML2 = new XmlDataProvider();
        cfxXML2.loadXML(strData2);
        ChartServer chart2 = new ChartServer(pageContext,request,response);
        chart2.setFormID("form1");
        chart2.setAsLastChart();
        chart2.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
        chart2.getLegendBox().setVisible(false);
        chart2.getDataSourceSettings().setDataSource(cfxXML2);
        chart2.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
        chart2.getAxisX().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 10));
        chart2.getDataGrid().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 8));
        chart2.getDataGrid().setHeight(60);
        
        TitleDockable title2 = new TitleDockable("객수/객단가 추이");
        title2.setFont(new Font("Malgun Gothic", Font.BOLD,12));
        title2.setAlignment(StringAlignment.CENTER);
        chart2.getTitles().add(title2);
        
        title = new TitleDockable("금액(단위:천)");
        title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
        title.setAlignment(StringAlignment.CENTER);
        title.setDock(DockArea.LEFT);
        chart2.getTitles().add(title);
        
        DataGrid obj2 = chart2.getDataGrid();
        obj2.setVisible(true);
        if(!"1".equals(strPrint)){
        	chart2.setWidth(390);
            chart2.setHeight(248);
        } else {
        	chart2.setWidth(800);
            chart2.setHeight(500);
        }        
        chart2.getImageSettings().setInteractive(true);
        chart2.setContextMenus(false);
        if(!"1".equals(strPrint)) chart2.renderControl();
%>
  </body>
  </form>
</html>
<%
        
        if("1".equals(strPrint)){
        	String strFilePath = BaseProperty.get("mss.file.upload.dir") + "chartimg/";
        	File filePath =  new File(strFilePath);
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
        	String strFileName = Date2.getDateWithMillisecond() + "_meis0810";
        	
        	chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_1.png");
        	chart2.exportChart(FileFormat.PNG, strFilePath+strFileName+"_2.png");
        	
        	%>
        	<script>
                parent.print("<%=strFileName%>");
            </script>
        	<%
        }
    } catch(Exception e){
    	%>      
        <script>
            showMessage(STOPSIGN , OK, "SERVER-1001", "<%=e.getMessage()%>");
        </script>
<%    	
    }
%>
