<%@page import=" com.softwarefx.chartfx.server.*
               , com.softwarefx.StringAlignment
               , com.softwarefx.chartfx.server.dataproviders.*
               , com.softwarefx.chartfx.server.galleries.Bubble
               , java.awt.*
               , java.util.List
               , java.util.ArrayList
               , java.util.Map
               , java.util.HashMap
               , java.util.Random
               , kr.fujitsu.ffw.control.ActionForm
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
    <title>행사매출달성/신장현황</title>
  </head>
  <body>
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

    	ActionForm form = (ActionForm)request.getAttribute("form");
    	List list = (List)request.getAttribute("list");
    	
		double dMinAchRate = 0;	//달성율 최소값
		double dMaxAchRate = 0;	//달성율 최대값
		
		double dMinGrowthRate = 0;	//신장율 최소값
		double dMaxGrowthRate = 0;  //신장율 최대값
		
		for(int i = 0; i < list.size(); i++) {
			
			Map tMap = (Map)list.get(i);

			String themNm = (String)tMap.get("thme_nm");								//테마명
			double achRatio = Double.parseDouble((String)tMap.get("ach_ratio"));			//달성율
			double groRatio = Double.parseDouble((String)tMap.get("gro_ratio"));			//신장율
			long totSaleAmt = Long.parseLong((String)tMap.get("tot_sale_amt"));			//실적매출액
			
			if(i == 0) {
				dMinAchRate = achRatio; 
				dMaxAchRate = achRatio; 
				
				dMinGrowthRate = groRatio;
				dMaxGrowthRate = groRatio;
			} else {
				if(dMinAchRate > achRatio) dMinAchRate = achRatio;
				if(dMaxAchRate < achRatio) dMaxAchRate = achRatio;
				
				if(dMinGrowthRate > groRatio) dMinGrowthRate = groRatio;
				if(dMaxGrowthRate < groRatio) dMaxGrowthRate = groRatio;
			}
				
		}
		
		dMinAchRate = Math.floor((dMinAchRate)/10)*10-5;
		dMaxAchRate = Math.ceil((dMaxAchRate)/10)*10+5;

		dMinGrowthRate = Math.floor((dMinGrowthRate)/10)*10-3;
		dMaxGrowthRate = Math.ceil((dMaxGrowthRate)/10)*10+3;
		
		ChartServer chart1 = new ChartServer(pageContext,request,response);
		
		chart1.getData().clear();

	    //상위타이틀
	    TitleDockable title = new TitleDockable("행사매출 달성/신장 현황");
	    title.setFont(new Font("Malgun Gothic", Font.BOLD,14));
	    title.setAlignment(StringAlignment.CENTER);
	    chart1.getTitles().add(title);
		
		title = new TitleDockable("달성율");
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,11));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.BOTTOM);
		chart1.getTitles().add(title);

		title = new TitleDockable("신장율");
		title.setFont(new Font("Malgun Gothic",Font.PLAIN,11));
		title.setAlignment(StringAlignment.CENTER);
		title.setDock(DockArea.LEFT);
		chart1.getTitles().add(title);

		//X축 설정
		chart1.getAxisX().setMin(dMinAchRate);
		chart1.getAxisX().setMax(dMaxAchRate);
		chart1.getAxisX().setStep((dMaxAchRate - dMinAchRate)/5);
		chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
		chart1.getAxisX().getLabelsFormat().setDecimals((short) 1);
		chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		//chart1.getAxisX().setLabelAngle((short)90);		
		
		//Y축설정
		chart1.getAxisY().setMin(dMinGrowthRate);
		chart1.getAxisY().setMax(dMaxGrowthRate);
		chart1.getAxisY().setStep(20);
		chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,11));		
		chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
		chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
		
		chart1.getData().setSeries(2);
		int pointSize = (int)(dMaxAchRate - dMinAchRate);
		chart1.getData().setPoints(pointSize);
		
		Map dupMap = new HashMap();			//달성율 중복체크용
		
		for(int i = 0; i < pointSize; i++) {
			
			int tPoint = i + (int)dMinAchRate;
			
			for(int j = 0; j < list.size(); j++) {

				Map tMap = (Map)list.get(j);

				String themNm = (String)tMap.get("thme_nm");								//테마명
				float achRatio = Float.parseFloat((String)tMap.get("ach_ratio"));			//달성율
				float groRatio = Float.parseFloat((String)tMap.get("gro_ratio"));			//신장율
				long totSaleAmt = Long.parseLong((String)tMap.get("tot_sale_amt"));			//실적매출액
				int rank = Integer.parseInt((String)tMap.get("rank"));

				if(tPoint == (int)achRatio) {
					
					Random random = new Random();
					Color tColor = new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255), 160);
					
					if(!dupMap.containsKey(tPoint)) {
						
						dupMap.put(tPoint, tColor);						
						
						//시리즈, 포인트, 값
						chart1.getData().set(0, i, groRatio);
						chart1.getData().set(1, i, rank*rank);
						//chart1.getData().set(1, i, rank+5);
						
						chart1.getPoints().get(i).setColor(tColor);
						
					} else {
						
						int totSeries = chart1.getData().getSeries();
						chart1.getData().setSeries(totSeries + 2);

						//시리즈, 포인트, 값
						chart1.getData().set(totSeries, i, groRatio);
						chart1.getData().set(totSeries + 1, i, rank*rank);
						//chart1.getData().set(1, i, rank+5);
						
						tColor = (Color)dupMap.get(tPoint);
						
					}

					//범례아이템 설정
					CustomLegendItem c = new CustomLegendItem(); 
					c.setText(themNm); 
					c.setMarkerShape(MarkerShape.MARBLE); 
					c.setColor(tColor); 
					chart1.getLegendBox().getCustomItems().add(c); 
					
				}

				
			}
			
		}
		
		//범례세팅
	    chart1.getLegendBox().setVisible(true);
	    chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
	    chart1.getLegendBox().setDock(DockArea.BOTTOM);
	    chart1.getLegendBox().setContentLayout(ContentLayout.SPREAD);	
	    chart1.getLegendBox().setMarginX(0);
	    chart1.getLegendBox().setMarginY(0);    
	    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
	    //chart1.getLegendBox().setHeight(40);
	    
	    LegendItemAttributes ItemAttribute = new LegendItemAttributes();
	    ItemAttribute.setVisible(false);
	    chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(), ItemAttribute);
	    
		chart1.setGallery(Gallery.BUBBLE);
		//버블사이즈
		Bubble gallery = (Bubble) chart1.getGalleryAttributes();
		gallery.setMaximumBubbleSize(6);
		
	    chart1.setWidth(340);
        chart1.setHeight(485);
        chart1.getImageSettings().setInteractive(true);
        chart1.setContextMenus(false);
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
