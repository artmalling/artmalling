<%@page import="com.softwarefx.chartfx.server.*,
				com.softwarefx.StringAlignment,
				com.softwarefx.chartfx.server.dataproviders.ListProvider,
				kr.fujitsu.ffw.util.*,
				kr.fujitsu.ffw.control.ActionForm,
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
        <title>판관비실적차트</title>
    </head>
    <body scroll=no>
<div style="overflow:hidden"> 
<%
try {
	//차트구분
	String CHART_GB = request.getParameter("CHART_GB");

	String BIZ_PLAN_YEAR = String2.trimToEmpty(request.getParameter("strRsltY")).substring(2);
	String BIZ_RSLT_YEAR = String2.trimToEmpty(request.getParameter("strRsltY")).substring(2);
	String PRE_RSLT_YEAR = String.valueOf(Integer.parseInt(BIZ_PLAN_YEAR) - 1);

	if(PRE_RSLT_YEAR.length() < 2) PRE_RSLT_YEAR = "0" + PRE_RSLT_YEAR;

	//손익실적차트
	if(CHART_GB.equals("IFRAME_SALE_AND_MANAGE_CHART")) {

		List list = (List)request.getAttribute("list");

		if(list.size() < 1) throw new Exception("에러아닙니다!!!");
		
		ChartServer chart1 = new ChartServer(pageContext,request,response);
		chart1.getData().clear();
		chart1.getData().setSeries(3);
		chart1.getData().setPoints(list.size());
		
	    chart1.getSeries().get(0).setText("계획");
	    chart1.getSeries().get(1).setText("실적");
	    chart1.getSeries().get(2).setText("전년실적");
		
		for(int i = 0; i < list.size(); i++) {
			
			Map tMap = (Map)list.get(i);
			
			if(!((String)tMap.get("group_id")).equals("0")) { break; }
			
			//시리즈, 포인트 , 값
			chart1.getData().set(0, i, Long.parseLong((String)tMap.get("plan_amt")));
			chart1.getData().set(1, i, Long.parseLong((String)tMap.get("rslt_amt")));
			chart1.getData().set(2, i, Long.parseLong((String)tMap.get("pre_rslt_amt")));
			
			String tStr = (String)tMap.get("biz_cd_nm");
			tStr = tStr.substring(0, 2) + "\n" + tStr.substring(2);
			chart1.getAxisX().getLabels().set(i,tStr);
			
		}
		
		//상위타이틀
		TitleDockable title = new TitleDockable("판매관리비");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);
		
		title = new TitleDockable("(단위:백만원)");
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);
		
		//시리즈칼라
		chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
		chart1.getSeries().get(2).setColor(new Color(156, 190, 99, 200));
		
		chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,9));
		
		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,8));
		chart1.getAxisX().setAutoScale(true);
		chart1.getAxisX().setAutoScroll(false);
		chart1.getAxisX().setLabelAngle((short)0);	
		
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,8));
		chart1.getAllSeries().getPointLabels().setVisible(true);
		chart1.getAllSeries().setVolume((short)60);
	    
		//3D세팅
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(0);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(100);

		//범례세팅
	    chart1.getLegendBox().setVisible(true);
	    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,9));
	    chart1.getLegendBox().setBorder(DockBorder.NONE);
	    chart1.getLegendBox().setMarginX(0);
	    chart1.getLegendBox().setMarginY(0);
	    //chart1.getLegendBox().setDock(DockArea.BOTTOM);
	    
	   	chart1.getPlotAreaMargin().setTop(42);
	    chart1.setGallery(Gallery.BAR);
	    chart1.getImageSettings().setInteractive(false);

//	    chart1.setWidth(380);
//	    chart1.setHeight(160);
//	    chart1.renderControl();
	    
		chart1.setWidth(370);
		chart1.setHeight(150);
		chart1.renderToStream();	

	//손익실적 월별추이 차트
	} else if(CHART_GB.equals("IFRAME_SALE_AND_MANAGE_RSLT_CHART")) {
		
		ActionForm form = (ActionForm)request.getAttribute("form");
		
		
		ChartServer chart1 = new ChartServer(pageContext,request,response);
		chart1.getData().clear();
		chart1.getData().setSeries(3);
		chart1.getData().setPoints(12);
		
		for(int i = 0; i < 12; i++) {
			
			String iMon = null;
			if(i < 9) iMon = "0" + (i + 1);
			else iMon = (i + 1) + "";
			
			//시리즈, 포인트 , 값
			chart1.getData().set(0, i, form.getLong(1,"PLAN_AMT_" + iMon));
			chart1.getData().set(1, i, form.getLong(1,"RSLT_AMT_" + iMon));
			chart1.getData().set(2, i, form.getLong(1,"PRE_RSLT_AMT_" + iMon));
			
			chart1.getAxisX().getLabels().set(i, iMon +"월");
			
		}
		
		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		
		//상위타이틀
		TitleDockable title = new TitleDockable(form.getParam("ORG_NAME") + " " + form.getParam("BIZ_CD_NM") + " 판관비실적 월별추이");
		title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
		title.setAlignment(StringAlignment.CENTER);
		chart1.getTitles().add(title);
		
		chart1.getAxisY().getTitle().setText("금액(단위:백만원)");
		chart1.getAxisY().getTitle().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		chart1.getAxisY().setVisible(true);

		//시리즈칼라
		chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
		chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
		chart1.getSeries().get(2).setColor(new Color(156, 190, 99, 200));
	    chart1.getSeries().get(0).setText("계획");
	    chart1.getSeries().get(1).setText("실적");
	    chart1.getSeries().get(2).setText("전년실적");
		
	    //포인트라벨
		chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		chart1.getAllSeries().getPointLabels().setVisible(true);
		chart1.getAllSeries().setVolume((short)60);
		chart1.getAllSeries().getPointLabels().setOffset(new Point(5,5));
		
		//3D세팅
		/*
		chart1.getView3D().setEnabled(true);
		chart1.getView3D().setCluster(false);
		chart1.getView3D().setPerspective(0);
		chart1.getView3D().setAngleX((short) 5);
		chart1.getView3D().setAngleY((short) 5);
		chart1.getView3D().setDepth(200);
		*/
		//데이타 그리드 세팅
	    chart1.getDataGrid().setVisible(true);
	    chart1.getDataGrid().setAutoSize(false);
	    chart1.getDataGrid().setShowHeader(false);
	    chart1.getDataGrid().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN,8));
	    chart1.getDataGrid().setShowMarkers(true);
	    chart1.getDataGrid().setShowHeader(true);
	    
	    chart1.getPlotAreaMargin().setTop(35);
	    chart1.setGallery(Gallery.LINES);
	    chart1.getLegendBox().setVisible(false);
	    chart1.getImageSettings().setInteractive(false);

//	    chart1.setWidth(800);
//	    chart1.setHeight(275);
//	    chart1.renderControl();	
		
		chart1.setWidth(795);
		chart1.setHeight(265);
		chart1.renderToStream();	
	    
	}	
} catch(Exception e) {}



%>
</div>        
    </body>
</html>