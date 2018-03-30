<%@page import="com.softwarefx.chartfx.server.*,
				com.softwarefx.StringAlignment,
				com.softwarefx.chartfx.server.dataproviders.ListProvider,
				kr.fujitsu.ffw.util.String2,
				java.util.Map,
				java.util.List,
				java.util.ArrayList,
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
	String chartTitle = "";

	String CHART_GUBUN = String2.trimToEmpty(request.getParameter("CHART_GUBUN"));
	String ORG_NAME = String2.trimToEmpty(request.getParameter("ORG_NAME"));
	String BIZ_PLAN_YEAR = String2.trimToEmpty(request.getParameter("BIZ_PLAN_YEAR")).substring(2);
	String PRE_RSLT_YEAR = String.valueOf(Integer.parseInt(BIZ_PLAN_YEAR) - 1);
	if(BIZ_PLAN_YEAR.equals("00")) PRE_RSLT_YEAR = "99";

	if(BIZ_PLAN_YEAR.length() < 2) BIZ_PLAN_YEAR = "0" + BIZ_PLAN_YEAR;
	if(PRE_RSLT_YEAR.length() < 2) PRE_RSLT_YEAR = "0" + PRE_RSLT_YEAR;

	List list = (List)request.getAttribute("list");
	
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	
	//데이터세팅
	chart1.getData().clear();
	chart1.getData().setSeries(2);
	chart1.getData().setPoints(list.size());
	
	for(int i = 0; i < list.size(); i++) {
		Map tMap = (Map)list.get(i);
		
		/* 시리즈, 포인트 , 값 */
		chart1.getData().set(0, i, Float.parseFloat((String)tMap.get("plan_sales_ratio")));			//계획
		chart1.getData().set(1, i, Float.parseFloat((String)tMap.get("pre_sales_ratio")));			//실적
		//라벨세팅
		chart1.getAxisX().getLabels().set(i,(String)tMap.get("biz_cd_nm"));		
	}
	
	if(CHART_GUBUN.equals("SALES_RATIO")) {
	
		chartTitle = "매출구성비";
		
	//매출이익구성비차트 호출
	} else if(CHART_GUBUN.equals("SALES_PROFIT_RATIO")) {
		
		chartTitle = "이익구성비";
		
	}
	
	//상위타이틀
	TitleDockable title = new TitleDockable(chartTitle);
	title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
	title.setAlignment(StringAlignment.CENTER);
	chart1.getTitles().add(title);

	//하위타이틀
	title = new TitleDockable(ORG_NAME);
	title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
	title.setAlignment(StringAlignment.CENTER);
	title.setDock(DockArea.BOTTOM);
	//title.setIndentation(10);
	chart1.getTitles().add(title);

	//범례세팅
    chart1.getSeries().get(0).setText(BIZ_PLAN_YEAR + " 계획");
    chart1.getSeries().get(1).setText(PRE_RSLT_YEAR + " 실적");
    
    //시리즈세팅
    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
    
	
	chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
	chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
	chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,11));
	chart1.getAllSeries().getPointLabels().setVisible(true);
	
	//범례세팅
    chart1.getLegendBox().setVisible(true);
    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,9));
    chart1.getLegendBox().setBorder(DockBorder.NONE);
    chart1.getLegendBox().setMarginX(0);
    chart1.getLegendBox().setMarginY(0);

	//3D세팅
	chart1.getView3D().setEnabled(true);
	chart1.getView3D().setCluster(false);
	chart1.getView3D().setPerspective(5);
	chart1.getView3D().setAngleX((short) 5);
	chart1.getView3D().setAngleY((short) 5);
	chart1.getView3D().setDepth(200);
	
	//차트모양세팅
	chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	chart1.getAllSeries().setVolume((short)50);
	chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	chart1.getAllSeries().getPointLabels().setVisible(true);
	chart1.getAllSeries().getPointLabels().setOffset(new Point(10,5));
	
	chart1.getPlotAreaMargin().setTop(30);
	chart1.setGallery(Gallery.BAR);
	chart1.getImageSettings().setInteractive(false);

//	chart1.setWidth(380);
//	chart1.setHeight(205);
//	chart1.renderControl();	
	
	chart1.setWidth(380);
	chart1.setHeight(190);
	chart1.renderToStream();	
	
} catch(Exception e) {}


%>
</div>        
    </body>
</html>
