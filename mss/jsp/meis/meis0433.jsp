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
        <title>손익계획분석차트</title>
    </head>
    <body scroll=no>
<div style="overflow:hidden">    
<%

try {
	int dsCnt = Integer.parseInt(String2.trimToEmpty(request.getParameter("dsCnt")));

	if(dsCnt < 1) throw new Exception();

	String BIZ_PLAN_YEAR = String2.trimToEmpty(request.getParameter("strPlanY")).substring(2);
	String PRE_RSLT_YEAR = String.valueOf(Integer.parseInt(BIZ_PLAN_YEAR) - 1);
	if(BIZ_PLAN_YEAR.equals("00")) PRE_RSLT_YEAR = "99";

	if(BIZ_PLAN_YEAR.length() < 2) BIZ_PLAN_YEAR = "0" + BIZ_PLAN_YEAR;
	if(PRE_RSLT_YEAR.length() < 2) PRE_RSLT_YEAR = "0" + PRE_RSLT_YEAR;
	
	List list = (List)request.getAttribute("list");
	int pSize = list.size();
	
	if(pSize < 1) {
		throw new Exception();
	}
	
	ChartServer chart1 = new ChartServer(pageContext,request,response);

	chart1.getData().setSeries(2);
	chart1.getData().setPoints(pSize);
	
	for(int i = 0; i < pSize; i++) {
		Map tMap = (Map)list.get(i);
		
		if(((String)tMap.get("biz_cd")).equals("")) { break; }
		
		//시리즈, 포인트 , 값
		chart1.getData().set(0, i, Double.parseDouble((String)tMap.get("plan_amt")));
		chart1.getData().set(1, i, Double.parseDouble((String)tMap.get("pre_rslt_amt")));
		
		String tStr = (String)tMap.get("biz_cd_nm");
		chart1.getAxisX().getLabels().set(i, tStr);
		
	}

		//상위타이틀
	TitleDockable title = new TitleDockable("손익계획");
	title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
	title.setAlignment(StringAlignment.CENTER);
	chart1.getTitles().add(title);

	title = new TitleDockable("(단위:백만원)");
	title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	title.setAlignment(StringAlignment.CENTER);
	chart1.getTitles().add(title);
    
    chart1.getSeries().get(0).setText(BIZ_PLAN_YEAR + " 계획");
    chart1.getSeries().get(1).setText(PRE_RSLT_YEAR + " 실적");
    
    //시리즈세팅
    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));    
	
	chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,11));
	chart1.getAllSeries().getPointLabels().setVisible(true);
	
	chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
	chart1.getAxisX().setAutoScale(true);
	chart1.getAxisX().setAutoScroll(false);
	chart1.getAxisX().setLabelAngle((short)90);	

	//범례세팅
    chart1.getLegendBox().setVisible(true);
    chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
    chart1.getLegendBox().setDock(DockArea.BOTTOM);
    chart1.getLegendBox().setContentLayout(ContentLayout.SPREAD);	
    chart1.getLegendBox().setMarginX(0);
    chart1.getLegendBox().setMarginY(0);    
    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,12));
    
	//3D세팅
	chart1.getView3D().setEnabled(true);
	chart1.getView3D().setCluster(false);
	chart1.getView3D().setPerspective(0);
	chart1.getView3D().setAngleX((short) 5);
	chart1.getView3D().setAngleY((short) 5);
	chart1.getView3D().setDepth(200);

	//차트모양세팅
	chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	chart1.getAllSeries().setVolume((short)(15 * pSize));
	chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	chart1.getAllSeries().getPointLabels().setVisible(true); 
	chart1.getAllSeries().getPointLabels().setOffset(new Point(10,5));
    
	chart1.getPlotAreaMargin().setTop(40);
	chart1.setGallery(Gallery.BAR);
	chart1.getImageSettings().setInteractive(false);

//	chart1.setWidth(382);
//	chart1.setHeight(382);
//	chart1.renderControl();	
	
	chart1.setWidth(380);
	chart1.setHeight(370);
	chart1.renderToStream();		
} catch(Exception e) {}



%>
</div>        
    </body>
</html>
