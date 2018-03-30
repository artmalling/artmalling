<!-- 
/*******************************************************************************
 * 시스템명 : 메인화면 > 매출속보 - 차트
 * 작 성 일 : 2010.07.21
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : mainFrameSaleChart.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.07.21 (정진영) 신규작성
 ******************************************************************************/
-->


<%@page import="java.awt.Color"%>
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
    <body style="overflow-x:hidden;overflow-y:hidden;" onContextMenu="return false;">
<%
ChartServer chart1      = new ChartServer(pageContext,request,response);

String chartType        = String2.trimToEmpty(request.getParameter("chartType"));
String strWidth         = String2.trimToEmpty(request.getParameter("strWidth"));
String strHeight        = String2.trimToEmpty(request.getParameter("strHeight"));
String strTitle         = String2.trimToEmpty(request.getParameter("strTitle"));
String strSubTitle     = String2.trimToEmpty(request.getParameter("strSubTitle"));
String strSubTitle2     = String2.trimToEmpty(request.getParameter("strSubTitle2"));
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
	    case 1: // 바와 선 표시
            chart1.getLegendBox().setVisible(false);
            chart1.setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 10));
            
	    	chart1.getPanes().add(new Pane());
	    	chart1.getSeries().get(0).setPane(chart1.getPanes().get(0));
	    	chart1.getSeries().get(0).setGallery(Gallery.LINES);
	    	chart1.getSeries().get(0).getAxisY().getLabelsFormat().setCustomFormat("###,###"); 
            chart1.getSeries().get(0).setColor(new Color(70, 180, 180, 200));
	    	chart1.getSeries().get(1).setPane(chart1.getPanes().get(1));
	    	chart1.getSeries().get(1).setGallery(Gallery.BAR);
            chart1.getSeries().get(1).getAxisY().getLabelsFormat().setCustomFormat("###,###"); 
            chart1.getSeries().get(1).setColor(new Color(95, 158, 160, 200));
            chart1.getPanes().get(1).setProportion(2);

            chart1.getAxisX().setLabelAngle((short)75);
            //좌측타이틀
            TitleDockable title = new TitleDockable(strSubTitle);
            title.setAlignment(StringAlignment.CENTER);
            title.setDock(DockArea.LEFT);
            chart1.getTitles().add(title);

            //chart1.setToolTipFormat("%s : %l"+"\n"+strSubTitle+"\n"+"%v");
            chart1.setToolTipFormat("%s : %l"+"\n"+"%v");
            
            chart1.getPlotAreaMargin().setTop(-1);
	        chart1.getPlotAreaMargin().setBottom(-1);
	        chart1.getPlotAreaMargin().setLeft(-1);
	        chart1.getPlotAreaMargin().setRight(0);

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
