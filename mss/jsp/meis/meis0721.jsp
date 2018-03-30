<%@page import="com.softwarefx.chartfx.server.*,
				com.softwarefx.StringAlignment,
				com.softwarefx.chartfx.server.dataproviders.ListProvider,
				java.awt.*,
				kr.fujitsu.ffw.control.ActionForm
			   "%>				
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>매출실적분석차트</title>
    </head>
    <body scroll=no>
<div style="overflow:hidden">    
<%

try {
	ActionForm form = (ActionForm)request.getAttribute("form");

	String CHART_GUBUN = form.getParam("CHART_GUBUN");

	ChartServer chart1 = new ChartServer(pageContext,request,response);
	
	//매출액
	if(CHART_GUBUN.equals("SALES_AMT")) {
		
		//데이터세팅
		chart1.getData().clear();
		chart1.getData().setSeries(0);
		chart1.getData().setPoints(3);
		
		/* 시리즈, 포인트 , 값 */
		chart1.getData().set(0, 0, form.getLong(1,"PLAN_SALES_AMT"));			//계획매출액
		chart1.getData().set(0, 1, form.getLong(1,"RSLT_SALES_AMT"));			//실적매출액
		chart1.getData().set(0, 2, form.getLong(1,"PRE_RSLT_SALES_AMT"));		//전년실적매출액
		
		//라벨세팅
		chart1.getAxisX().getLabels().set(0,"매출계획");
		chart1.getAxisX().getLabels().set(1,"매출실적");
		chart1.getAxisX().getLabels().set(2,"전년실적");		
		
		
		//타이틀 세팅
		
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
		title = new TitleDockable(form.getParam("ORG_NAME"));
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.BOTTOM);
		//title.setIndentation(10);
		chart1.getTitles().add(title);
		
	//매출이익액
	} else if(CHART_GUBUN.equals("SALES_RROFIT_AMT")) {
	
		//데이터세팅
		chart1.getData().clear();
		chart1.getData().setSeries(0);
		chart1.getData().setPoints(3);
		
		/* 시리즈, 포인트 , 값 */
		chart1.getData().set(0, 0, form.getLong(1,"PLAN_SALES_PROFIT_AMT"));			//계획매출액
		chart1.getData().set(0, 1, form.getLong(1,"RSLT_SALES_PROFIT_AMT"));			//실적매출액
		chart1.getData().set(0, 2, form.getLong(1,"PRE_RSLT_SALES_PROFIT_AMT"));		//전년실적매출액
		
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
		title = new TitleDockable(form.getParam("ORG_NAME"));
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.BOTTOM);
		//title.setIndentation(10);
		chart1.getTitles().add(title);
		
		
	//매출이익율
	} else if(CHART_GUBUN.equals("SALES_RROFIT_RATE")) {
		
		//데이터세팅
		chart1.getData().clear();
		chart1.getData().setSeries(0);
		chart1.getData().setPoints(3);
		
		/* 시리즈, 포인트 , 값 */
		chart1.getData().set(0, 0, form.getDouble(1,"PLAN_PROFIT_RATE"));			//계획매출액
		chart1.getData().set(0, 1, form.getDouble(1,"RSLT_PROFIT_RATE"));			//실적매출액
		chart1.getData().set(0, 2, form.getDouble(1,"PRE_RSLT_PROFIT_RATE"));		//전년실적매출액
		
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
		title = new TitleDockable(form.getParam("ORG_NAME"));
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.BOTTOM);
		//title.setIndentation(10);
		chart1.getTitles().add(title);

		chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
		
	} else {
		throw new Exception("");
	}
	
	//라벨세팅
	chart1.getAxisX().getLabels().set(0,"매출\n계획");
	chart1.getAxisX().getLabels().set(1,"매출\n실적");
	chart1.getAxisX().getLabels().set(2,"전년\n실적");		
	
	//포인터칼라
	chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
	chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));
	chart1.getPoints().get(2).setColor(new Color(165, 190, 90, 200));
	
	chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
	chart1.getAxisX().setAutoScale(true);
	chart1.getAxisX().setAutoScroll(false);
	chart1.getAxisX().setLabelAngle((short)0);
	
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
	
//	chart1.setWidth(250);
//	chart1.setHeight(205);
//	chart1.renderControl();

	chart1.setWidth(250);
	chart1.setHeight(195);
	chart1.renderToStream();	
} catch(Exception e) {}



%>
</div>        
    </body>
</html>
