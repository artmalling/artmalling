<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면매출정보(층) - 차트
 * 작 성 일 : 2010.07.01
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4329.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.30 (정진영) 신규작성
 ******************************************************************************/
-->


<%@page import="java.awt.Point"%>
<%@page import="common.util.Util"%>
<%@page import="common.vo.SessionInfo"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.galleries.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="kr.fujitsu.ffw.util.*"%>
<%@page import="kr.fujitsu.ffw.base.BaseProperty"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String dir = BaseProperty.get("context.common.dir");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
    </head>
    <body style="overflow-x:hidden;overflow-y:auto;">
<%
ChartServer chart1      = new ChartServer(pageContext,request,response);

String chartType        = String2.trimToEmpty(request.getParameter("chartType"));
String strWidth         = String2.trimToEmpty(request.getParameter("strWidth"));
String strHeight        = String2.trimToEmpty(request.getParameter("strHeight"));
String strTitle         = String2.trimToEmpty(request.getParameter("strTitle"));
String XmlData          = String2.trimToEmpty(request.getParameter("xmlData"));

try{

	int width = strWidth.equals("")?600:Integer.valueOf(strWidth);
	int height = strHeight.equals("")?400:Integer.valueOf(strHeight);
	chart1.setWidth(width);
	chart1.setHeight(height);
	
	XmlDataProvider cfxXML = new XmlDataProvider();
	cfxXML.loadXML(XmlData);
	chart1.getDataSourceSettings().setDataSource(cfxXML);

    if(chart1.getData().getSeries() < 1){
    	throw new Exception("NO_DATA");
    }

	switch(Integer.valueOf(chartType)){
	    case 1: // 가로 형 표시
	        chart1.getLegendBox().setVisible(false);
	        chart1.setGallery(Gallery.GANTT);
            chart1.setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 12));
	        chart1.getAxisY().setVisible(false);
	        chart1.getAxisY().getLabelsFormat().setCustomFormat("###,###"); 
	        chart1.getAllSeries().getPointLabels().setVisible(true);
	        chart1.getAllSeries().getPointLabels().setTextColor(java.awt.Color.BLACK);
	        chart1.getAllSeries().getPointLabels().setOffset(new Point(1,2));
	        chart1.getPlotAreaMargin().setBottom(-1);
	        chart1.getPlotAreaMargin().setTop(-1);
	        chart1.getPlotAreaMargin().setLeft(-1);
	        chart1.getPlotAreaMargin().setRight(-1);
	        chart1.getAxisY().setMax( chart1.getAxisY().getMax()+(chart1.getAxisY().getMax()/12));
	        chart1.getAxisY().setAutoScale(true);
	        break;
	    case 2: // 바형에 선 표시

	        chart1.getLegendBox().setVisible(false);
	        chart1.setGallery(Gallery.BAR);
            chart1.setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 12));
	        chart1.getAxisY().setVisible(false);
	        chart1.getAxisY().getLabelsFormat().setCustomFormat("###,###"); 
	        SeriesAttributes serie1;
	        serie1 = chart1.getSeries().get(1);
	        serie1.setAxisY(chart1.getAxisY2());
	        serie1.getAxisY().setVisible(false);
	        serie1.getAxisY().getLabelsFormat().setCustomFormat("###,###"); 
	        serie1.getPointLabels().setVisible(true);
	        serie1.getPointLabels().setTextColor(java.awt.Color.BLACK);
	        serie1.getPointLabels().setAlignment(StringAlignment.CENTER);
	        serie1.getPointLabels().setOffset(new Point(4,5));
	        serie1.setGallery(Gallery.LINES);
	        serie1.setMarkerShape(MarkerShape.CIRCLE);
	        serie1.bringToFront();
	        chart1.getPlotAreaMargin().setBottom(-1);
	        chart1.getPlotAreaMargin().setLeft(-1);
	        chart1.getPlotAreaMargin().setRight(-1);

	        break;
	    case 3: // 원형 표시
            chart1.setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 11));
	        chart1.getLegendBox().setVisible(true);
	        chart1.getLegendBox().setDock(DockArea.BOTTOM);
	        chart1.getLegendBox().setPlotAreaOnly(false);
	        chart1.getLegendBox().setAutoSize(true);
	        chart1.getAllSeries().getPointLabels().setVisible(true);
	        chart1.getAxisY().getLabelsFormat().setCustomFormat("###,###"); 
	        //chart1.getAllSeries().getPointLabels().setFormat("%l"+":"+"%p"+"%%");
	        chart1.setGallery(Gallery.DOUGHNUT);
	        Pie pie = (Pie) chart1.getGalleryAttributes();
	        chart1.getAxisY().setVisible(true);
	        pie.setShowLines(true);
	        pie.setLabelsInside(true);
	        chart1.getView3D().setCluster(true);

	        chart1.getPlotAreaMargin().setBottom(-1);
	        chart1.getPlotAreaMargin().setTop(-1);
	        chart1.getPlotAreaMargin().setLeft(-1);
	        chart1.getPlotAreaMargin().setRight(-1);
	        chart1.getAxisX().setSeparation(-10); 
	        chart1.getAxisY().setSeparation(-10);
	        
	        chart1.setToolTipFormat("%l"+":"+"%p"+"%%"+"\n"+"총매출:"+"%t"+"\n"+"매   출:"+"%v");
	        
	        break;
	}
	SimpleBorder myBorder = new SimpleBorder();
	myBorder.setType(SimpleBorderType.NONE);
	chart1.setBorder(myBorder);

	GradientBackground myBorder1 = new GradientBackground();
	myBorder1.setEffectArea(0);
	chart1.setBackground(myBorder1);


	chart1.setRenderFormat("PNG");
	chart1.getImageSettings().setInteractive(false);
	chart1.renderControl();
}catch(Exception e){
	if(e.getMessage().equals("NO_DATA")){
	    String errorHtml = "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0' height='100%' style='border:0px;'>";
	    errorHtml += "<tr>";                
	    errorHtml += "  <td style='border:0px;' width='50%' class='right'><img src='/"+dir+"/imgs/comm/ms03.gif' width=50 height=50 show=false ></td>";                
	    errorHtml += "  <td style='border:0px;' valign='middle' > 데이타가 존재하지 않습니다.</td>";
	    errorHtml += "</tr>";
	    errorHtml += "</table>";
	    out.write(errorHtml);
	}
}
%>        
    </body>
</html>
