<%@page import="com.softwarefx.chartfx.server.*,
				com.softwarefx.StringAlignment,
				com.softwarefx.chartfx.server.dataproviders.ListProvider,
				kr.fujitsu.ffw.util.*,
				java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>매출계획분석차트</title>
    </head>
    <body scroll=no>
<div style="overflow:hidden">    
<%

try {
	//차트구분
	String CHART_GB = request.getParameter("CHART_GB");

	String ORG_CD = request.getParameter("ORG_CD");
	String ORG_NAME = request.getParameter("ORG_NAME");
	String GROUP_ID = request.getParameter("GROUP_ID");
	
	String PLAN_SALES_AMT = request.getParameter("PLAN_SALES_AMT");
	String RSLT_SALES_AMT = request.getParameter("RSLT_SALES_AMT");
	String PRE_SALES_AMT = request.getParameter("PRE_SALES_AMT");
	String PLAN_SALES_PROFIT_AMT = request.getParameter("PLAN_SALES_PROFIT_AMT");
	String RSLT_SALES_PROFIT_AMT = request.getParameter("RSLT_SALES_PROFIT_AMT");
	String PRE_SALES_PROFIT_AMT = request.getParameter("PRE_SALES_PROFIT_AMT");
	
	String BIZ_PLAN_YEAR = String2.trimToEmpty(request.getParameter("strRsltY")).substring(2);
	String BIZ_RSLT_YEAR = String2.trimToEmpty(request.getParameter("strRsltY")).substring(2);	
	String PRE_RSLT_YEAR = String.valueOf(Integer.parseInt(BIZ_PLAN_YEAR) - 1);

	if(PRE_RSLT_YEAR.length() < 2) PRE_RSLT_YEAR = "0" + PRE_RSLT_YEAR;
	
	//매출액
	if(CHART_GB.equals("IFRAME_SALES_AMT_CHART")) {
		
		ChartServer chart1 = new ChartServer(pageContext,request,response);
		chart1.getData().setSeries(1);
		chart1.getData().setPoints(3);
		//시리즈, 포인트 , 값
		chart1.getData().set(0, 0, Long.parseLong(PLAN_SALES_AMT));	//계획 매출액
		chart1.getData().set(0, 1, Long.parseLong(RSLT_SALES_AMT));	//실적 매출액
		chart1.getData().set(0, 2, Long.parseLong(PRE_SALES_AMT));	//전년실적 매출액
		
		//상위타이틀
		TitleDockable title = new TitleDockable("매출액");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);

		title = new TitleDockable("(단위:백만원)");
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);

		//하위타이틀
		title = new TitleDockable(ORG_NAME);
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.BOTTOM);
		//title.setIndentation(10);
		chart1.getTitles().add(title);
		
		//라벨세팅
		chart1.getAxisX().getLabels().set(0,"매출\n계획");
		chart1.getAxisX().getLabels().set(1,"매출\n실적");
		chart1.getAxisX().getLabels().set(2,"전년\n실적");
		
		//포인트칼라
		chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));
		chart1.getPoints().get(2).setColor(new Color(156, 190, 99, 200));
		
		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
		chart1.getAxisX().setAutoScale(true);
		chart1.getAxisX().setAutoScroll(false);
		chart1.getAxisX().setLabelAngle((short)0);		
		
		//3D세팅
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(0);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(200);
		
		//차트모양세팅
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		chart1.getAllSeries().setVolume((short)40);
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
		chart1.getAllSeries().getPointLabels().setVisible(true);
		chart1.getAllSeries().getPointLabels().setOffset(new Point(10,5));
		
		chart1.getPlotAreaMargin().setTop(40);		
		chart1.setGallery(Gallery.BAR);
		chart1.getLegendBox().setVisible(false);
		chart1.getImageSettings().setInteractive(false);
		
//		chart1.setWidth(230);
//		chart1.setHeight(180);
//		chart1.renderControl();
		
		chart1.setWidth(220);
		chart1.setHeight(170);
		chart1.renderToStream();	
		
	//매출이익 
	} else if(CHART_GB.equals("IFRAME_SALES_PROFIT_AMT_CHART")) {

		ChartServer chart1 = new ChartServer(pageContext,request,response);
		chart1.getData().setSeries(1);
		chart1.getData().setPoints(3);
		//시리즈, 포인트 , 값
		chart1.getData().set(0, 0, Long.parseLong(PLAN_SALES_PROFIT_AMT));	//계획 매출이익액
		chart1.getData().set(0, 1, Long.parseLong(RSLT_SALES_PROFIT_AMT));	//실적 매출이익액
		chart1.getData().set(0, 2, Long.parseLong(PRE_SALES_PROFIT_AMT));	//전년실적 매출이익액
		chart1.getAxisX().getLabels().set(0,"이익계획");
		chart1.getAxisX().getLabels().set(1,"이익실적");
		chart1.getAxisX().getLabels().set(2,"전년실적");
		
		//상위타이틀
		TitleDockable title = new TitleDockable("매출이익액");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);

		title = new TitleDockable("(단위:백만원)");
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);

		//하위타이틀
		title = new TitleDockable(ORG_NAME);
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.BOTTOM);
		//title.setIndentation(10);
		chart1.getTitles().add(title);
		
		
		//라벨세팅
		chart1.getAxisX().getLabels().set(0,"이익\n계획");
		chart1.getAxisX().getLabels().set(1,"이익\n실적");
		chart1.getAxisX().getLabels().set(2,"전년\n실적");
		
		//포인트칼라
		chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));
		chart1.getPoints().get(2).setColor(new Color(156, 190, 99, 200));
		
		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
		chart1.getAxisX().setAutoScale(true);
		chart1.getAxisX().setAutoScroll(false);
		chart1.getAxisX().setLabelAngle((short)0);		
		
		//3D세팅
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(0);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(200);
		
		//차트모양세팅
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		chart1.getAllSeries().setVolume((short)40);
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
		chart1.getAllSeries().getPointLabels().setVisible(true);
		chart1.getAllSeries().getPointLabels().setOffset(new Point(10,5));
		
		chart1.getPlotAreaMargin().setTop(40);
		chart1.setGallery(Gallery.BAR);
		chart1.getLegendBox().setVisible(false);
		chart1.getImageSettings().setInteractive(false);
		
//		chart1.setWidth(230);
//		chart1.setHeight(180);
//		chart1.renderControl();
		
		chart1.setWidth(220);
		chart1.setHeight(170);
		chart1.renderToStream();		
		
	//매출액 월별추이
	} else if(CHART_GB.equals("IFRAME_TAB1_SALES_RSLT_CHART")) {
		
		ChartServer chart1 = new ChartServer(pageContext,request,response);
		chart1.getData().setSeries(3);
		chart1.getData().setPoints(12);
		
	    //chart1.getSeries().get(0).setText(BIZ_PLAN_YEAR + " 계획");
	    //chart1.getSeries().get(1).setText(PRE_RSLT_YEAR + " 실적");
	    chart1.getSeries().get(0).setText("매출계획");
	    chart1.getSeries().get(1).setText("매출실적");
	    chart1.getSeries().get(2).setText("전년실적");

	    
		//시리즈, 포인트 , 값
		for(int i = 0; i < 3; i++) {
			String key = "PLAN_SALES_AMT_";
			if(i == 1) key = "RSLT_SALES_AMT_";
			if(i == 2) key = "PRE_SALES_AMT_";

			for(int j = 0; j < 12; j++) {
				String month = j < 9 ? "0" + (j+1) : (j+1) + "";
				chart1.getData().set(i, j, Long.parseLong(request.getParameter(key + month)));
				if(i == 1) chart1.getAxisX().getLabels().set(j, month +"월");
			}
		}

		//상위타이틀
		TitleDockable title = new TitleDockable(ORG_NAME + " 매출액 월별추이");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,13));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);
		
		chart1.getAxisY().getTitle().setText("금액(단위:백만원)");
		chart1.getAxisY().getTitle().setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		chart1.getAxisY().setVisible(true);
		
		//시리즈칼라
		chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
		chart1.getSeries().get(2).setColor(new Color(156, 190, 99, 200));
		
		chart1.getAllSeries().setVolume((short)70);
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		chart1.getAllSeries().getPointLabels().setVisible(true);

		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		chart1.getAxisX().setAutoScale(true);
		chart1.getAxisX().setAutoScroll(false);
		chart1.getAxisX().setLabelAngle((short)0);			
		
        
		chart1.getDataGrid().setVisible(true);
        chart1.getDataGrid().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN,9));
        chart1.getDataGrid().setShowMarkers(true);
        chart1.getDataGrid().setHeight(70);
        
		//3D세팅
		/*
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(0);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(200);
		*/
		chart1.getPlotAreaMargin().setTop(40);		
        chart1.setGallery(Gallery.LINES);
        chart1.getLegendBox().setVisible(false);
        chart1.getImageSettings().setInteractive(false);

//        chart1.setWidth(800);
//        chart1.setHeight(250);
//        chart1.renderControl();

		chart1.setWidth(795);
		chart1.setHeight(240);
		chart1.renderToStream();  

	//매출이익액 월별추이
	} else if(CHART_GB.equals("IFRAME_TAB2_SALES_PROFIT_RSLT_CHART")) {

		ChartServer chart1 = new ChartServer(pageContext,request,response);
		chart1.getData().setSeries(3);
		chart1.getData().setPoints(12);
		
	    //chart1.getSeries().get(0).setText(BIZ_PLAN_YEAR + " 계획");
	    //chart1.getSeries().get(1).setText(PRE_RSLT_YEAR + " 실적");
	    chart1.getSeries().get(0).setText("이익계획");
	    chart1.getSeries().get(1).setText("이익실적");
	    chart1.getSeries().get(2).setText("전년실적");	    
		
		//시리즈, 포인트 , 값
		for(int i = 0; i < 3; i++) {
			String key = "PLAN_SALES_PROFIT_AMT_";
			if(i == 1) key = "RSLT_SALES_PROFIT_AMT_";
			if(i == 2) key = "PRE_SALES_PROFIT_AMT_";
			for(int j = 0; j < 12; j++) {
				String month = j < 9 ? "0" + (j+1) : (j+1) + "";
				chart1.getData().set(i, j, Long.parseLong(request.getParameter(key + month)));
				if(i == 1) chart1.getAxisX().getLabels().set(j, month +"월");
			}
		}

		//상위타이틀
		TitleDockable title = new TitleDockable(ORG_NAME + " 매출이익액 월별추이");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,13));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);
		
		chart1.getAxisY().getTitle().setText("금액(단위:백만원)");
		chart1.getAxisY().getTitle().setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		chart1.getAxisY().setVisible(true);
		
		//시리즈칼라
		chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
		chart1.getSeries().get(2).setColor(new Color(156, 190, 99, 200));

		chart1.getAllSeries().setVolume((short)70);
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		chart1.getAllSeries().getPointLabels().setVisible(true);

		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		chart1.getAxisX().setAutoScale(true);
		chart1.getAxisX().setAutoScroll(false);
		chart1.getAxisX().setLabelAngle((short)0);			
		
        
		chart1.getDataGrid().setVisible(true);
        chart1.getDataGrid().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN,9));
        chart1.getDataGrid().setShowMarkers(true);
        chart1.getDataGrid().setHeight(70);
        
		//3D세팅
		/*
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(0);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(200);
		*/
		chart1.getPlotAreaMargin().setTop(40);
        chart1.setGallery(Gallery.LINES);
        chart1.getLegendBox().setVisible(false);
        chart1.getImageSettings().setInteractive(false);

//        chart1.setWidth(800);
//        chart1.setHeight(250);
//        chart1.renderControl();
		
		chart1.setWidth(795);
		chart1.setHeight(240);
		chart1.renderToStream();  
        
	} 

} catch(Exception e) {}


%>
</div>        
    </body>
</html>
