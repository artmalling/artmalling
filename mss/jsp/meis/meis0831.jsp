<%@page import=" com.softwarefx.chartfx.server.*
               , com.softwarefx.StringAlignment
               , com.softwarefx.chartfx.server.dataproviders.*
               , com.softwarefx.chartfx.server.galleries.*
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
    <title>등급별 구매고객현황</title>
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
	
	    //주간매출 TRNED 현황
	    XmlDataProvider cfxXML = new XmlDataProvider();
	    cfxXML.loadXML(strData);
	    
	    ChartServer chart1 = new ChartServer(pageContext, request, response);
	    chart1.getData().clear();
	    chart1.getDataSourceSettings().setDataSource(cfxXML);

	    chart1.setGallery(Gallery.PIE);
	    chart1.getPlotAreaMargin().setTop(-1);
	    chart1.getPlotAreaMargin().setBottom(-1);
	    chart1.getPlotAreaMargin().setLeft(0);
	    chart1.getPlotAreaMargin().setRight(0);
	    
	    //PIE 세팅
	    Pie pie = (Pie) chart1.getGalleryAttributes();
	    pie.setSquare(false);
	    //chart1.getAllSeries().setSeparateSlice((short)10);

	    //포인트 칼라설정
	    chart1.getPoints().get(0).setColor(Color.black);		//블랙
	    chart1.getPoints().get(1).setColor(Color.yellow);	//골드
	    chart1.getPoints().get(2).setColor(Color.blue);		//블루
	    chart1.getPoints().get(3).setColor(Color.green);		//그린
	    
		//3D세팅
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setAngleX((short) 30);
	    
		//범례세팅
		chart1.getLegendBox().setVisible(true);
	    chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
	    chart1.getLegendBox().setDock(DockArea.BOTTOM);
	    chart1.getLegendBox().setContentLayout(ContentLayout.SPREAD);	
	    chart1.getLegendBox().setMarginX(-1);
	    chart1.getLegendBox().setMarginY(-1);    
	    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,9));
	    //chart1.getLegendBox().setHeight(40);

	    LegendItemAttributes item = new LegendItemAttributes(); 
		item.setVisible(false); 
		chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(), item); 
	    
	    //상위타이틀
	    String strTitle = "등급별 구매고객현황";
	    if(!"1".equals(tabFlag)) strTitle= "등급별 구매고객매출 현황(단위:백만)";
	    TitleDockable title = new TitleDockable(strTitle);
	    title.setFont(new Font("Malgun Gothic", Font.BOLD,12));
	    title.setAlignment(StringAlignment.CENTER);
	    chart1.getTitles().add(title);
	
	    chart1.setWidth(300);
	    chart1.setHeight(228);
	    chart1.getImageSettings().setInteractive(false);
	    chart1.renderControl();

    } catch(Exception e){
    	%>      
        <script>
            showMessage(STOPSIGN , OK, "SERVER-1001", "<%=e.getMessage()%>");
        </script>
<%    	
    }
%>
  </body>
</html>
