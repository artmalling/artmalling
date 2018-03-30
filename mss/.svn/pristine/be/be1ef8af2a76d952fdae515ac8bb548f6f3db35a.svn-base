/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package meis.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.Point;
import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.net.InetAddress;

import common.util.Util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.String2;
import meis.dao.MEis043DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import com.softwarefx.StringAlignment;
import com.softwarefx.chartfx.server.AxisFormat;
import com.softwarefx.chartfx.server.Chart;
import com.softwarefx.chartfx.server.ContentLayout;
import com.softwarefx.chartfx.server.DockArea;
import com.softwarefx.chartfx.server.DockBorder;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.dataproviders.ListProvider;

/**
 * <p>경영계획보고서조회</p>
 * 
 * @created on 1.0, 2011/06/17
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis043Action extends DispatchAction {

	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis043Action.class);

	/** 
	 * <p>경영계획보고서조회 화면로딩</p>
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>경영실적에서 쓰이는 조직조회</p>
	 */
	public ActionForward getOrg(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getOrg(form);
			helper.setDataSetHeader(dSet, "H_SEL_ORG");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
	/** 
	 * <p>TAB1조회 - 경영계획보고서중 매출계획분석</p>
	 */
	public ActionForward searchTAB1(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchTAB1(form, false);
			helper.setDataSetHeader(dSet, "H_SEL_TAB1");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}

	/** 
	 * <p>TAB1조회 - 경영계획보고서중 매출계획분석</p>
	 */
	public ActionForward searchTAB1_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchTAB1_EXCEL(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB1_EXCEL");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
	/** 
	 * <p>매출계획분석탭 차트</p>
	 */
	public ActionForward chartTAB1(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			//차트키세팅
			this.setFXChartKey(request);
			GauceHelper2.initialize(form, request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}	
	
	/** 
	 * <p>TAB2조회 - 경영계획보고서중 매출구성계획분석</p>
	 */
	public ActionForward searchTAB2(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB2(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB2");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
	/** 
	 * <p>TAB2조회 - 경영계획보고서중 매출구성계획분석 엑셀</p>
	 */
	public ActionForward searchTAB2_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB2_EXCEL(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB2");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
	/** 
	 * <p>매출구성계획분석탭 차트</p>
	 */
	public ActionForward chartTAB2(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		MEis043DAO dao      = null;
		List list           = null;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			dao     = new MEis043DAO();
			list    = dao.chartTAB2(form, "");
			 
			request.setAttribute("list", list);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
	}	
	
	/** 
	 * <p>TAB3조회 - 경영계획보고서중 손익계획분석 조회</p>
	 */
	public ActionForward searchTAB3(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB3(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB3");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
	/** 
	 * <p>TAB3조회 - 경영계획보고서중 손익계획분석 조회</p>
	 */
	public ActionForward searchTAB3_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB3_EXCEL(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB3_EXCEL");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	

	/** 
	 * <p>손익계획분석탭 차트</p>
	 */
	public ActionForward chartTAB3(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		MEis043DAO dao      = null;
		List list           = null;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			dao     = new MEis043DAO();
			list    = dao.chartTAB3(form);
			
			request.setAttribute("list", list);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
	}

	/** 
	 * <p>TAB3조회 - 판관비중분류계획분석 조회</p>
	 */
	public ActionForward searchTAB4_M(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB4_M(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB4");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>TAB3조회 - 판관비소분류계획분석 조회</p>
	 */
	public ActionForward searchTAB4_S(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB4_S(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB4");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
	/** 
	 * <p>판매관리분석탭 차트</p>
	 */
	public ActionForward chartTAB4(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		MEis043DAO dao      = null;
		List list           = null;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			dao     = new MEis043DAO();
			list    = dao.chartTAB4(form);
			
			request.setAttribute("list", list);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>TAB3조회 - 판관비계획분석 엑셀조회</p>
	 */
	public ActionForward searchTAB4_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis043DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis043DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			list    = dao.searchTAB4_EXCEL(form);
			helper.setDataSetHeader(dSet, "H_SEL_TAB4_EXCEL");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>경영계획보고서출력 화면로딩</p>
	 */
	public ActionForward print(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo  = form.getParam("goTo"); // 분기할곳
		String strStrCd = null;
		String strPlanY = null;
		String strStrNm = null;
		MEis043DAO dao  = null;
		List list       = null;
		List temp       = null;
		
		long preSalesAmt          = 0;
		long planSalesAmt         = 0;
		long preSalesProfitAmt    = 0;
		long planSalesProfitAmt   = 0;
		float preSalesProfitRate  = 0;
		float planSalesProfitRate = 0;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			String strFilePath = BaseProperty.get("mss.file.upload.dir") + "chartimg/";
			File filePath =  new File(strFilePath);
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
			String strFileName = Date2.getDateWithMillisecond() + "_meis0430";
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			dao      = new MEis043DAO();
			list     = dao.searchTAB1(form, true);
			for(int i=0; i <list.size() ; i++){
				temp = (List) list.get(i);
				if(temp.get(0).toString().startsWith(strStrCd)){
					strStrNm            = temp.get(1).toString();
					preSalesAmt         = Long.parseLong(temp.get(3).toString());
					planSalesAmt        = Long.parseLong(temp.get(4).toString());
					preSalesProfitAmt   = Long.parseLong(temp.get(6).toString());
					planSalesProfitAmt  = Long.parseLong(temp.get(7).toString());
					preSalesProfitRate  = Float.parseFloat(temp.get(9).toString());
					planSalesProfitRate = Float.parseFloat(temp.get(10).toString());
					break;
				}
			}
			//차이트 이미 생성 및 파일로저장
			java.lang.Object[] allArrays = new java.lang.Object[2];
			
			long[] series = {planSalesAmt, preSalesAmt};
			String[] labels = {"매출\n계획", "전년\n실적"};
			
			allArrays[0] = series;
			allArrays[1] = labels;
			
			Chart chart1 = new Chart();
			ListProvider lstDataProvider = new ListProvider(allArrays);
			chart1.getDataSourceSettings().setDataSource(lstDataProvider);
			
			//상위타이틀
			TitleDockable title = new TitleDockable("매출액");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:백만)");
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			//하위타이틀
			title = new TitleDockable(strStrNm);
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
			title.setAlignment(StringAlignment.CENTER);
			title.setDock(DockArea.BOTTOM);
			//title.setIndentation(10);
			chart1.getTitles().add(title);
			
			chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
			chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));

			//차트모양세팅

			chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
				
			//3D세팅
			chart1.getView3D().setEnabled(true);
			chart1.getView3D().setCluster(false);
			chart1.getView3D().setPerspective(5);
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
				
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)40);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.getLegendBox().setVisible(false);
			chart1.setWidth(350);
			chart1.setHeight(240);
			chart1.getImageSettings().setInteractive(false);
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_1.png");
			
			series[0] = planSalesProfitAmt;
			series[1] = preSalesProfitAmt;
			labels[0] = "이익\n계획";
			labels[1] = "전년\n실적";
			//Load Array of Arrays
			allArrays[0] = series;
			allArrays[1] = labels;
			
			chart1 = new Chart();
			lstDataProvider = new ListProvider(allArrays);
			chart1.getDataSourceSettings().setDataSource(lstDataProvider);
			
			title = new TitleDockable("매출이익액");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:백만)");
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			//하위타이틀
			title = new TitleDockable(strStrNm);
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
			title.setAlignment(StringAlignment.CENTER);
			title.setDock(DockArea.BOTTOM);
			//title.setIndentation(10);
			chart1.getTitles().add(title);
			
			chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
			chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));

			//차트모양세팅

			chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
				
			//3D세팅
			chart1.getView3D().setEnabled(true);
			chart1.getView3D().setCluster(false);
			chart1.getView3D().setPerspective(5);
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
				
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)40);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.getLegendBox().setVisible(false);
			chart1.setWidth(350);
			chart1.setHeight(240);
			chart1.getImageSettings().setInteractive(false);
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_2.png");

			float[] series2 = {planSalesProfitRate, preSalesProfitRate};
			labels[0] = "이익율\n계획";
			labels[1] = "전년\n실적";
			//Load Array of Arrays
			allArrays[0] = series2;
			allArrays[1] = labels;
			
			chart1 = new Chart();
			lstDataProvider = new ListProvider(allArrays);
			chart1.getDataSourceSettings().setDataSource(lstDataProvider);
			
			title = new TitleDockable("매출이익율");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:%)");
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			//하위타이틀
			title = new TitleDockable(strStrNm);
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
			title.setAlignment(StringAlignment.CENTER);
			title.setDock(DockArea.BOTTOM);
			//title.setIndentation(10);
			chart1.getTitles().add(title);

			chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
			
			chart1.getPoints().get(0).setColor(new Color(189, 81, 74, 200));
			chart1.getPoints().get(1).setColor(new Color(57, 105, 156, 200));

			//차트모양세팅

			chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,11));
				
			//3D세팅
			chart1.getView3D().setEnabled(true);
			chart1.getView3D().setCluster(false);
			chart1.getView3D().setPerspective(5);
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
				
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)40);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.getLegendBox().setVisible(false);
			chart1.setWidth(350);
			chart1.setHeight(240);
			chart1.getImageSettings().setInteractive(false);
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_3.png");
			
			//매출구성비 이미지 저장
			list    = dao.chartTAB2(form, "SALES_RATIO");
			
			String chartTitle = "";
			String CHART_GUBUN = String2.trimToEmpty(form.getParam("CHART_GUBUN"));
			String ORG_NAME = String2.trimToEmpty(form.getParam("ORG_NAME"));
			String BIZ_PLAN_YEAR = String2.trimToEmpty(form.getParam("BIZ_PLAN_YEAR")).substring(2);
			String PRE_RSLT_YEAR = String.valueOf(Integer.parseInt(BIZ_PLAN_YEAR) - 1);

			if(BIZ_PLAN_YEAR.length() < 2) BIZ_PLAN_YEAR = "0" + BIZ_PLAN_YEAR;
			if(PRE_RSLT_YEAR.length() < 2) PRE_RSLT_YEAR = "0" + PRE_RSLT_YEAR;
			
			chart1 = new Chart();
			
			for(int i = 0; i < list.size(); i++) {
				Map tMap = (Map)list.get(i);
				
				/* 시리즈, 포인트 , 값 */
				chart1.getData().set(0, i, Float.parseFloat((String)tMap.get("plan_sales_ratio")));			//계획
				chart1.getData().set(1, i, Float.parseFloat((String)tMap.get("pre_sales_ratio")));			//실적
				//라벨세팅
				chart1.getAxisX().getLabels().set(i,(String)tMap.get("biz_cd_nm"));		
			}
			chartTitle = "매출구성비";
			
			title = new TitleDockable(chartTitle);
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

			if(list.size() != 0){
				//범례세팅
			    chart1.getSeries().get(0).setText(BIZ_PLAN_YEAR + " 계획");
			    chart1.getSeries().get(1).setText(PRE_RSLT_YEAR + " 실적");
			    
			    //시리즈세팅
			    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
			    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
			}
			
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
			
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)50);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(440);
			chart1.setHeight(290);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear(); 
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_4.png");
			
			//매출구성비 이미지 저장
			list    = dao.chartTAB2(form, "SALES_PROFIT_RATIO");
			
			chart1 = new Chart();
			
			for(int i = 0; i < list.size(); i++) {
				Map tMap = (Map)list.get(i);
				
				/* 시리즈, 포인트 , 값 */
				chart1.getData().set(0, i, Float.parseFloat((String)tMap.get("plan_sales_ratio")));			//계획
				chart1.getData().set(1, i, Float.parseFloat((String)tMap.get("pre_sales_ratio")));			//실적
				//라벨세팅
				chart1.getAxisX().getLabels().set(i,(String)tMap.get("biz_cd_nm"));		
			}
			chartTitle = "이익구성비";
			
			title = new TitleDockable(chartTitle);
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

			if(list.size() != 0){
				//범례세팅
			    chart1.getSeries().get(0).setText(BIZ_PLAN_YEAR + " 계획");
			    chart1.getSeries().get(1).setText(PRE_RSLT_YEAR + " 실적");
			    
			    //시리즈세팅
			    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
			    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
			}
			
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
			
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)50);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(440);
			chart1.setHeight(290);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear();
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_5.png");
			
			//손익계획이미지 생성
			list    = dao.chartTAB3(form);
			
			int pSize = list.size();

			chart1 = new Chart();
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
			
			title = new TitleDockable("손익계획");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:백만)");
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
			//chart1.getAxisX().setLabelAngle((short)90);	

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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 0);
			chart1.getView3D().setDepth(200);

			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)(10 * pSize));
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
		    
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(750);
			chart1.setHeight(260);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear();
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_6.png");
			
			//이익구성비 생성
			list    = dao.chartTAB4(form);
			
			pSize = list.size();

			chart1 = new Chart();
			
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
			
			title = new TitleDockable("판매관리비");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:백만)");
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
			
			chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAxisX().setAutoScale(true);
			chart1.getAxisX().setAutoScroll(false);
			//chart1.getAxisX().setLabelAngle((short)90);	
			
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 0);
			chart1.getView3D().setDepth(200);

			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)(10 * pSize));
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
		    
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(750);
			chart1.setHeight(260);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear();
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_7.png");
			
			request.setAttribute("strFileName", strFileName);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		
		return mapping.findForward(strGoTo);
	}
	
	private void setFXChartKey(HttpServletRequest request) throws Exception {
		/************ fujitsu.config파일을 읽어들임 ******************************/

		Properties fujitsuDeptProps = Util.getFujitsudeptProperties();
		String serverName = fujitsuDeptProps.getProperty("server.name");
		 
		/************ Chart FX의 운영기처리 **************************************/
		if (serverName.equals(request.getServerName())){
		    // Server

		    String myServer1 = "10.1.100.26";
		    String myServer2 = "10.1.100.28";

		    // IP Check
		    InetAddress Address = InetAddress.getLocalHost();
		    String ipCheck = Address.getHostAddress();  
		    if (ipCheck.equals(myServer1))                                                       
		    {                                                          
		          System.out.println(myServer1);                        
		          com.softwarefx.chartfx.server.Chart.setLicenseString("Ck4o2ftbAQCl942vct3jQEEBAAABAAAABUNGSjcwC1NGWERPV05MT0FERk5TPTE7TWFwcz1QLDMyMSxDRko3MCwxO1N0YXRpc3RpY2FsPVAsMzIxLENGSjcwLDE7R2F1Z2VzPVAsMzIxLENGSjcwLDEBAAAAAVIAAUSHAXVzZXIubmFtZT1qZXVzCmphdmEudmVyc2lvbj0xLjUuMC4xMQp1c2VyLmhvbWU9L2pldXMKaG9zdD1kY3d3MDEKamF2YS5ob21lPS9vcHQvamF2YTEuNS9qcmUKb3MubmFtZT1IUC1VWAppcD0xMC4xLjEwMC4yNgpvcy5hcmNoPUlBNjROCgAAAAABIA==*&VaqX89ojq8EhmT1sny7X3kA4ww35vFL0Y3RhkyGuQG1IN/vLUOHoHpz58B/ncSbnPzVkROKAZxL72nwkc6X+1hNaKgH1em5rhD3LCViNbW/1p0WxJ4lFA8Fs5REmPCoI0yGuoKDWjebPFLyaCTGV1P74/RfYb0bUBB0d1ZdQ9Ow=");  
		    }                                                          
		    else if (ipCheck.equals(myServer2))
		    { 
		          System.out.println(myServer2); 
		          com.softwarefx.chartfx.server.Chart.setLicenseString("HyTrXftbAADEvO9Pc93jQAMBAAABAAAAB0NGSjcwQVALU0ZYRE9XTkxPQURMTlM9MTtNYXBzPVAsMjU5LENGSjcwQVAsMTtTdGF0aXN0aWNhbD1QLDI1OSxDRko3MEFQLDE7R2F1Z2VzPVAsMjU5LENGSjcwQVAsMQEAAAABUgABRIcBdXNlci5uYW1lPWpldXMKamF2YS52ZXJzaW9uPTEuNS4wLjExCnVzZXIuaG9tZT0vamV1cwpob3N0PWRjd3cwMgpqYXZhLmhvbWU9L29wdC9qYXZhMS41L2pyZQpvcy5uYW1lPUhQLVVYCmlwPTEwLjEuMTAwLjI4Cm9zLmFyY2g9SUE2NE4KAAAAAA==*&xnud56E5jC1x+mNS7hs+3N1npFDpQdYOK3QO3BdCwtZiMVmdV434Qhaj4nTkPpFIO3R7inWvd1EzpCTllJRBRFYdBW8N135CGwlTAcx66JpiBzLsWKIqHPLXI3E0r7zRxJDxBsb9sg/toi0FYHNjzgEBH5j7oSxC313FVllyGnk=");  
		    }
		}
	}
	
}
