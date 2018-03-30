<%@page import="com.softwarefx.chartfx.server.*,
				com.softwarefx.StringAlignment,
				com.softwarefx.chartfx.server.dataproviders.ListProvider,
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
<%

try {
	String CHART_GUBUN = request.getParameter("CHART_GUBUN");

	//데이터 세팅
	String ORG_NAME = request.getParameter("ORG_NAME") == null ? "" : request.getParameter("ORG_NAME");
	//매출액
	String PRE_SALES_AMT = request.getParameter("PRE_SALES_AMT") == null ? "0" : request.getParameter("PRE_SALES_AMT");
	String PLAN_SALES_AMT = request.getParameter("PLAN_SALES_AMT") == null ? "0" : request.getParameter("PLAN_SALES_AMT");
	//매출이익액
	String PRE_SALES_PROFIT_AMT = request.getParameter("PRE_SALES_PROFIT_AMT") == null ? "0" : request.getParameter("PRE_SALES_PROFIT_AMT");
	String PLAN_SALES_PROFIT_AMT = request.getParameter("PLAN_SALES_PROFIT_AMT") == null ? "0" : request.getParameter("PLAN_SALES_PROFIT_AMT");
	//매출이익율
	String PRE_SALES_PROFIT_RATE = request.getParameter("PRE_SALES_PROFIT_RATE") == null ? "0" : request.getParameter("PRE_SALES_PROFIT_RATE");
	String PLAN_SALES_PROFIT_RATE = request.getParameter("PLAN_SALES_PROFIT_RATE") == null ? "0" : request.getParameter("PLAN_SALES_PROFIT_RATE");

	long preSalesAmt = Long.parseLong(PRE_SALES_AMT);
	long planSalesAmt = Long.parseLong(PLAN_SALES_AMT);
	long preSalesProfitAmt = Long.parseLong(PRE_SALES_PROFIT_AMT);
	long planSalesProfitAmt = Long.parseLong(PLAN_SALES_PROFIT_AMT);
	float preSalesProfitRate = Float.parseFloat(PRE_SALES_PROFIT_RATE);
	float planSalesProfitRate = Float.parseFloat(PLAN_SALES_PROFIT_RATE);

	//매출액
	java.lang.Object[] allArrays = new java.lang.Object[2];
	if(CHART_GUBUN.equals("SALES_AMT")) {
		
		long[] series1 = {planSalesAmt, preSalesAmt};
		String[] labels = {"매출\n계획", "전년\n실적"};
		//Load Array of Arrays
		allArrays[0] = series1;
		allArrays[1] = labels;
		
	//매출이익액	
	} else if(CHART_GUBUN.equals("SALES_RROFIT_AMT")) {

		long[] series1 = {planSalesProfitAmt, preSalesProfitAmt};
		String[] labels = {"이익\n계획", "전년\n실적"};
		//Load Array of Arrays
		allArrays[0] = series1;
		allArrays[1] = labels;
		
	//매출이익율	
	} else if(CHART_GUBUN.equals("SALES_RROFIT_RATE")) {
		
		float[] series1 = {planSalesProfitRate, preSalesProfitRate};
		String[] labels = {"이익율\n계획", "전년\n실적"};
		//Load Array of Arrays
		allArrays[0] = series1;
		allArrays[1] = labels;
	}

	ChartServer chart1 = new ChartServer(pageContext,request,response);

	ListProvider lstDataProvider = new ListProvider(allArrays);
	chart1.getDataSourceSettings().setDataSource(lstDataProvider);

	//매출액
	if(CHART_GUBUN.equals("SALES_AMT")) {
		
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
		
	//매출이익액	
	} else if(CHART_GUBUN.equals("SALES_RROFIT_AMT")) {

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
		
	//매출이익율	
	} else if(CHART_GUBUN.equals("SALES_RROFIT_RATE")) {
		
		//상위타이틀
		TitleDockable title = new TitleDockable("매출이익율");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);

		title = new TitleDockable("(단위:%)");
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

		chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
	}

		chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));

		//차트모양세팅

		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
			
		//3D세팅
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(5);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(200);
			
		//차트모양세팅
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		chart1.getAllSeries().setVolume((short)40);
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		chart1.getAllSeries().getPointLabels().setVisible(true);
		chart1.getAllSeries().getPointLabels().setOffset(new Point(10,5));
		
		chart1.getPlotAreaMargin().setTop(40);
		chart1.setGallery(Gallery.BAR);
		chart1.getLegendBox().setVisible(false);
		chart1.getImageSettings().setInteractive(false);

//		chart1.setWidth(250);
//		chart1.setHeight(205);
//		chart1.renderControl();

		chart1.setWidth(250);
		chart1.setHeight(195);
		chart1.renderToStream();	
} catch(Exception e) {}


%>
    </body>
</html>