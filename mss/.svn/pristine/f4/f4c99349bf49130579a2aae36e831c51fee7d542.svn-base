<%@page import="com.softwarefx.chartfx.server.*,
				com.softwarefx.StringAlignment,
				com.softwarefx.chartfx.server.dataproviders.ListProvider,
				kr.fujitsu.ffw.util.String2,
				kr.fujitsu.ffw.control.ActionForm,
				java.util.Map,
				java.util.List,
				java.util.ArrayList,
				java.text.*,
				java.util.*,				
				java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>판관비실적분석차트</title>
    </head>
    <body scroll=no>
<div style="overflow:hidden">    
<%

try {
	ActionForm form = (ActionForm)request.getAttribute("form");

	int dsCnt = form.getInt(1, "dsCnt");  

	if(dsCnt < 1) throw new Exception();
	
	String SUM_GB = form.getParam("strSumGb");

	/* 날짜 변환 */
	String BIZ_RSLT_YM = form.getParam("strRsltYm");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	Date cDate = sdf.parse(BIZ_RSLT_YM);
	Calendar cal = new GregorianCalendar();
	cal.setTime(cDate);
	cal.add(Calendar.YEAR, -1);
	Date pDate = cal.getTime();
	sdf.applyPattern("yy년MM월");
	if(SUM_GB.equals("2")) sdf.applyPattern("yy년MM월 누계");
	
	//현년
	BIZ_RSLT_YM = sdf.format(cDate);
	//전년
	String PRE_BIZ_RSLT_YM = sdf.format(pDate);
	/* 날짜변환 */
	
	List list = (List)request.getAttribute("list");
	int pSize = list.size();
	
	if(pSize < 1) {
		throw new Exception();
	}
	
	ChartServer chart1 = new ChartServer(pageContext,request,response);

	chart1.getData().setSeries(3);
	chart1.getData().setPoints(pSize);
	
	for(int i = 0; i < pSize; i++) {
		Map tMap = (Map)list.get(i);
		
		if(((String)tMap.get("biz_cd")).equals("")) { break; }
		//시리즈, 포인트 , 값
		chart1.getData().set(0, i, Double.parseDouble((String)tMap.get("plan_amt")));
		chart1.getData().set(1, i, Double.parseDouble((String)tMap.get("rslt_amt")));
		chart1.getData().set(2, i, Double.parseDouble((String)tMap.get("pre_rslt_amt")));
		
		String tStr = (String)tMap.get("biz_cd_nm");
		chart1.getAxisX().getLabels().set(i, tStr);
		
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
	
	//범례라벨세팅
    chart1.getSeries().get(0).setText(BIZ_RSLT_YM + " 계획");
    chart1.getSeries().get(1).setText(BIZ_RSLT_YM + " 실적");
    chart1.getSeries().get(2).setText(PRE_BIZ_RSLT_YM + " 실적");
    
    //시리즈세팅
    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));    
	chart1.getSeries().get(2).setColor(new Color(165, 190, 90, 200));     
	
	chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,11));
	chart1.getAllSeries().getPointLabels().setVisible(true);
	
	chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
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
    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
    
	//3D세팅
	chart1.getView3D().setEnabled(true);
	chart1.getView3D().setCluster(false);
	chart1.getView3D().setPerspective(0);
	chart1.getView3D().setAngleX((short) 5);
	chart1.getView3D().setAngleY((short) 5);
	chart1.getView3D().setDepth(200);

	//차트모양세팅
	chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
	chart1.getAllSeries().setVolume((short)(10 * pSize));
	chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
	chart1.getAllSeries().getPointLabels().setVisible(true);    
	chart1.getAllSeries().getPointLabels().setOffset(new Point(0,5));
    
	chart1.getPlotAreaMargin().setTop(40);
	chart1.setGallery(Gallery.BAR);
	chart1.getImageSettings().setInteractive(false);
	
//	chart1.setWidth(382);
//	chart1.setHeight(382);
//	chart1.renderControl();

	chart1.setWidth(370);
	chart1.setHeight(370);
	chart1.renderToStream();		
} catch(Exception e) {}



%>
</div>        
    </body>
</html>
