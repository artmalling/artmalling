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
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.Properties;

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
import meis.dao.MEis072DAO;

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
import com.softwarefx.chartfx.server.dataproviders.XmlDataProvider;
import com.softwarefx.chartfx.server.galleries.Pie;
import common.util.Util;

/**
 * <p>경영실적보고서조회</p>
 * 
 * @created on 1.0, 2011/07/08
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis072Action extends DispatchAction {

	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis072Action.class);

	/** 
	 * <p>경영실적보고서조회 화면로딩</p>
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
	 * <p>TAB1조회 - 경영실적보고서중 매출계획분석</p>
	 */
	public ActionForward searchTAB1(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>매출실적분석탭 차트</p>
	 */
	public ActionForward chartTAB1(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		request.setAttribute("form", form);
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
	 * <p>TAB1조회 - 경영실적보고서중 매출계획분석</p>
	 */
	public ActionForward searchTAB1_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>TAB2조회 - 경영실적보고서중 매출구성실적분석</p>
	 */
	public ActionForward searchTAB2(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>TAB2조회 - 경영실적보고서중 매출구성실적분석 엑셀</p>
	 */
	public ActionForward searchTAB2_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
		MEis072DAO dao      = null;
		List list           = null;
		
		try {
			//차트키세팅
			this.setFXChartKey(request);
			
			dao     = new MEis072DAO();
			list    = dao.chartTAB2(form);
			
			request.setAttribute("list", list);
			request.setAttribute("form", form);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
	}	
	
	/** 
	 * <p>TAB3조회 - 경영실적보고서중 손익실적분석 조회</p>
	 */
	public ActionForward searchTAB3(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>TAB3조회 - 경영실적보고서중 손익실적분석 조회</p>
	 */
	public ActionForward searchTAB3_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>손익실적분석탭 차트</p>
	 */
	public ActionForward chartTAB3(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		MEis072DAO dao      = null;
		List list           = null;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			dao     = new MEis072DAO();
			list    = dao.chartTAB3(form);
			
			request.setAttribute("list", list);
			request.setAttribute("form", form);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
	}	
	
	/** 
	 * <p>TAB3조회 - 판관비중분류실적분석 조회</p>
	 */
	public ActionForward searchTAB4_M(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>TAB3조회 - 판관비계획분석 엑셀조회</p>
	 */
	public ActionForward searchTAB4_EXCEL(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis072DAO dao      = null;
		List list           = null;
		
		String strGoTo = form.getParam("goTo");
		
		try {
			dao     = new MEis072DAO();
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
	 * <p>판매관리분석탭 차트</p>
	 */
	public ActionForward chartTAB4(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		MEis072DAO dao      = null;
		List list           = null;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			dao     = new MEis072DAO();
			list    = dao.chartTAB4(form);
			
			request.setAttribute("list", list);
			request.setAttribute("form", form);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
	}	
	
	/** 
	 * <p>경영실적보고서출력 화면로딩</p>
	 */
	public ActionForward print(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo  = form.getParam("goTo"); // 분기할곳
		String strStrCd = null;
		String strStrNm = null;
		String strUsrId = null;
		MEis072DAO dao  = null;
		List list       = null;
		List temp       = null;
		boolean isExist = false;
		
		long preSalesAmt          = 0;
		long planSalesAmt         = 0;
		long rsltSalesAmt         = 0;
		long preSalesProfitAmt    = 0;
		long planSalesProfitAmt   = 0;
		long rsltSalesProfitAmt   = 0;
		float preSalesProfitRate  = 0;
		float planSalesProfitRate = 0;
		float rsltSalesProfitRate = 0;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			strUsrId = Util.getUserId(request);
			String strFilePath = BaseProperty.get("mss.file.upload.dir") + "chartimg/";
			File filePath =  new File(strFilePath);
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
			String strFileName = Date2.getDateWithMillisecond() + "_meis0720";
			String BIZ_RSLT_YM = form.getParam("BIZ_RSLT_YM");
			String SUM_GB = form.getParam("SUM_GB");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			Date cDate = sdf.parse(BIZ_RSLT_YM);
			Calendar cal = new GregorianCalendar();
			cal.setTime(cDate);
			cal.add(Calendar.YEAR, -1);
			Date pDate = cal.getTime();
			sdf.applyPattern("yy년MM월\n");
			if(SUM_GB.equals("2")) sdf.applyPattern("yy년MM월\n누계");
			
			//현년
			BIZ_RSLT_YM = sdf.format(cDate);
			//전년
			String PRE_BIZ_RSLT_YM = sdf.format(pDate);
			
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			dao      = new MEis072DAO();
			list     = dao.searchTAB1(form, true);
			
			for(int i=0; i <list.size() ; i++){
				temp = (List) list.get(i);
				if(temp.get(0).toString().startsWith(strStrCd)){
					isExist = true;
					strStrNm            = temp.get(1).toString();
					planSalesAmt        = Long.parseLong(temp.get(3).toString());
					rsltSalesAmt        = Long.parseLong(temp.get(4).toString());
					preSalesAmt         = Long.parseLong(temp.get(6).toString());
					planSalesProfitAmt  = Long.parseLong(temp.get(8).toString());
					rsltSalesProfitAmt  = Long.parseLong(temp.get(9).toString());
					preSalesProfitAmt   = Long.parseLong(temp.get(11).toString());
					planSalesProfitRate = Float.parseFloat(temp.get(13).toString());
					rsltSalesProfitRate = Float.parseFloat(temp.get(14).toString());
					preSalesProfitRate  = Float.parseFloat(temp.get(16).toString());
					break;
				}
			}
			
			Chart chart1 = new Chart();
			
			chart1.getData().setSeries(0);
			chart1.getData().setPoints(3);
			
			/* 시리즈, 포인트 , 값 */
			chart1.getData().set(0, 0, planSalesAmt); //계획매출액
			chart1.getData().set(0, 1, rsltSalesAmt); //실적매출액
			chart1.getData().set(0, 2, preSalesAmt);  //전년실적매출액
			
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
		
			title = new TitleDockable("(단위:백만)");
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
			
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)40);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.getLegendBox().setVisible(false);
			chart1.setWidth(350);
			chart1.setHeight(240);
			chart1.getImageSettings().setInteractive(false);
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_1.png");
			
			//데이터세팅
			chart1 = new Chart();
			chart1.getData().setSeries(0);
			chart1.getData().setPoints(3);
			
			/* 시리즈, 포인트 , 값 */
			chart1.getData().set(0, 0, planSalesProfitAmt);			//계획매출액
			chart1.getData().set(0, 1, rsltSalesProfitAmt);			//실적매출액
			chart1.getData().set(0, 2, preSalesProfitAmt);		//전년실적매출액
			
			//상위타이틀
			title = new TitleDockable("매출이익액");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:백만)");
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
			
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)40);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.getLegendBox().setVisible(false);
			chart1.setWidth(350);
			chart1.setHeight(240);
			chart1.getImageSettings().setInteractive(false);
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_2.png");
			
			//데이터세팅
			chart1 = new Chart();
			chart1.getData().setSeries(0);
			chart1.getData().setPoints(3);
			
			/* 시리즈, 포인트 , 값 */
			chart1.getData().set(0, 0, planSalesProfitRate); //계획매출액
			chart1.getData().set(0, 1, rsltSalesProfitRate); //실적매출액
			chart1.getData().set(0, 2, preSalesProfitRate);	 //전년실적매출액
			
			//상위타이틀
			title = new TitleDockable("매출이익율");
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 15);
			chart1.getView3D().setDepth(200);
			
			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)40);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.getLegendBox().setVisible(false);
			
			chart1.setWidth(350);
			chart1.setHeight(240);
			chart1.getImageSettings().setInteractive(false);
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_3.png");
			
			//매출구성비
			form.setParam("CHART_GUBUN", new String[]{"SALES_RATIO"});
			list    = dao.chartTAB2(form);
			chart1 = new Chart();
			chart1.getData().setSeries(0);
			chart1.getData().setPoints(list.size());
			
			for(int i = 0; i < list.size(); i++) {
				Map tMap = (Map)list.get(i);
			
				/* 시리즈, 포인트 , 값 */
				chart1.getData().set(0, i, Float.parseFloat((String)tMap.get("plan_sales_ratio")));			//계획
				chart1.getData().set(1, i, Float.parseFloat((String)tMap.get("rslt_sales_ratio")));			//실적
				chart1.getData().set(2, i, Float.parseFloat((String)tMap.get("pre_rslt_sales_ratio")));			//전년실적
				//라벨세팅
				chart1.getAxisX().getLabels().set(i,(String)tMap.get("biz_cd_nm"));		
			}
			
			title = new TitleDockable("매출구성비");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			//하위타이틀
			title = new TitleDockable(form.getParam("ORG_NAME"));
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
			title.setAlignment(StringAlignment.CENTER);
			title.setDock(DockArea.BOTTOM);
			//title.setIndentation(10);
			chart1.getTitles().add(title);
			
			//범례세팅
			chart1.getSeries().get(0).setText(BIZ_RSLT_YM + " 계획");
		    chart1.getSeries().get(1).setText(BIZ_RSLT_YM + " 실적");
		    chart1.getSeries().get(2).setText(PRE_BIZ_RSLT_YM + " 실적");
		    
		    //시리즈세팅
		    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
		    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
			chart1.getSeries().get(2).setColor(new Color(165, 190, 90, 200));
		    
			chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAxisX().setAutoScale(true);
			chart1.getAxisX().setAutoScroll(false);
			chart1.getAxisX().setLabelAngle((short)0);
			
			chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
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
			chart1.getAllSeries().setVolume((short)70);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(440);
			chart1.setHeight(290);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear(); 
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_4.png");
			
			//이익구성비
			form.setParam("CHART_GUBUN", new String[]{"SALES_PROFIT_RATIO"});
			list    = dao.chartTAB2(form);
			chart1 = new Chart();
			chart1.getData().setSeries(0);
			chart1.getData().setPoints(list.size());
			
			for(int i = 0; i < list.size(); i++) {
				Map tMap = (Map)list.get(i);
			
				/* 시리즈, 포인트 , 값 */
				chart1.getData().set(0, i, Float.parseFloat((String)tMap.get("plan_sales_ratio")));			//계획
				chart1.getData().set(1, i, Float.parseFloat((String)tMap.get("rslt_sales_ratio")));			//실적
				chart1.getData().set(2, i, Float.parseFloat((String)tMap.get("pre_rslt_sales_ratio")));			//전년실적
				//라벨세팅
				chart1.getAxisX().getLabels().set(i,(String)tMap.get("biz_cd_nm"));		
			}
			
			title = new TitleDockable("이익구성비");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);
			
			title = new TitleDockable(form.getParam("ORG_NAME"));
			title.setFont(new Font("Malgun Gothic",Font.PLAIN,12));
			title.setAlignment(StringAlignment.CENTER);
			title.setDock(DockArea.BOTTOM);
			//title.setIndentation(10);
			chart1.getTitles().add(title);

			//범례세팅
			chart1.getSeries().get(0).setText(BIZ_RSLT_YM + " 계획");
		    chart1.getSeries().get(1).setText(BIZ_RSLT_YM + " 실적");
		    chart1.getSeries().get(2).setText(PRE_BIZ_RSLT_YM + " 실적");
		    
		  //시리즈세팅
		    chart1.getSeries().get(0).setColor(new Color(189, 81, 74, 200));
		    chart1.getSeries().get(1).setColor(new Color(57, 105, 156, 200));
			chart1.getSeries().get(2).setColor(new Color(165, 190, 90, 200));
		    
			chart1.getAxisX().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
			chart1.getAxisX().setAutoScale(true);
			chart1.getAxisX().setAutoScroll(false);
			chart1.getAxisX().setLabelAngle((short)0);
			
			chart1.getAxisY().getLabelsFormat().setDecimals((short) 2);
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAxisY().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
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
			chart1.getAllSeries().setVolume((short)70);
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(10,10));
			
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(440);
			chart1.setHeight(290);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear(); 
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_5.png");
			
			//손익실적
			list    = dao.chartTAB3(form);
			chart1 = new Chart();
			chart1.getData().setSeries(3);
			chart1.getData().setPoints(list.size());
			for(int i = 0; i < list.size(); i++) {
				Map tMap = (Map)list.get(i);
				
				if(((String)tMap.get("biz_cd")).equals("")) { break; }
				
				//시리즈, 포인트 , 값
				chart1.getData().set(0, i, Double.parseDouble((String)tMap.get("plan_amt")));
				chart1.getData().set(1, i, Double.parseDouble((String)tMap.get("rslt_amt")));
				chart1.getData().set(2, i, Double.parseDouble((String)tMap.get("pre_rslt_amt")));
				
				String tStr = (String)tMap.get("biz_cd_nm");
				chart1.getAxisX().getLabels().set(i, tStr);
				
			}
			
			title = new TitleDockable("손익실적");
			title.setFont(new Font("Malgun Gothic",Font.BOLD,12));
			title.setAlignment(StringAlignment.CENTER);
			chart1.getTitles().add(title);

			title = new TitleDockable("(단위:백만)");
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
		    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		    
			//3D세팅
			chart1.getView3D().setEnabled(true);
			chart1.getView3D().setCluster(false);
			chart1.getView3D().setPerspective(0);
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 0);
			chart1.getView3D().setDepth(200);

			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)(10 * list.size()-1));
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(0,10));
		    
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(750);
			chart1.setHeight(260);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear();
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_6.png");
			
			//손익실적
			list    = dao.chartTAB4(form);
			chart1 = new Chart();
			chart1.getData().setSeries(3);
			chart1.getData().setPoints(list.size());
			
			for(int i = 0; i < list.size(); i++) {
				Map tMap = (Map)list.get(i);
				
				if(((String)tMap.get("biz_cd")).equals("")) { break; }
				//시리즈, 포인트 , 값
				chart1.getData().set(0, i, Double.parseDouble((String)tMap.get("plan_amt")));
				chart1.getData().set(1, i, Double.parseDouble((String)tMap.get("rslt_amt")));
				chart1.getData().set(2, i, Double.parseDouble((String)tMap.get("pre_rslt_amt")));
				
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
			chart1.getView3D().setAngleX((short) 10);
			chart1.getView3D().setAngleY((short) 0);
			chart1.getView3D().setDepth(200);

			//차트모양세팅
			chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
			chart1.getAllSeries().setVolume((short)(10 * list.size()-1));
			chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.BOLD,10));
			chart1.getAllSeries().getPointLabels().setVisible(true);
			chart1.getAllSeries().getPointLabels().setOffset(new Point(0,10));
		    
			chart1.setGallery(Gallery.BAR);
			chart1.setWidth(750);
			chart1.setHeight(260);
			chart1.getImageSettings().setInteractive(false);
			if(list.size() == 0) chart1.getData().clear();
			chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_7.png");
			
			//등급별 고객현황
			form.setParam("tabFlag"  , new String[]{"1"});
			
			String strData = dao.searchCustPie(form, strUsrId);
			XmlDataProvider cfxXML = new XmlDataProvider();
		    cfxXML.loadXML(strData);
		    chart1 = new Chart();
		    chart1.getLegendBox().setVisible(true);
		    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,8));
		    chart1.getDataSourceSettings().setDataSource(cfxXML);
		    chart1.setGallery(Gallery.PIE);
		    chart1.getPlotAreaMargin().setTop(-1);
		    chart1.getPlotAreaMargin().setBottom(-1);
		    chart1.getPlotAreaMargin().setLeft(0);
		    chart1.getPlotAreaMargin().setRight(0);
		    Pie pie = (Pie) chart1.getGalleryAttributes();
		    pie.setSquare(false);
		    pie.setLabelsInside(false);
		    
		    //포인트 칼라설정
		    chart1.getPoints().get(0).setColor(Color.black);		//블랙
		    chart1.getPoints().get(1).setColor(Color.yellow);	//골드
		    chart1.getPoints().get(2).setColor(Color.blue);		//블루
		    chart1.getPoints().get(3).setColor(Color.green);		//그린
		    
		    //3D세팅
			chart1.getView3D().setEnabled(true);
			chart1.getView3D().setAngleX((short) 30);
		    
		    chart1.getAllSeries().getPointLabels().setVisible(true);
		    chart1.getAllSeries().getPointLabels().setFormat("%v\n%p%%");
		    chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		    chart1.getAllSeries().setSeparateSlice((short)20);
		    
		    String strTitle = form.getParam("BIZ_RSLT_YM").substring(0, 4)+ "년 " 
		                    + form.getParam("BIZ_RSLT_YM").substring(4, 6) + "월 등급별 고객현황";
		    if(SUM_GB.equals("2")) strTitle += " 누계";

		    title = new TitleDockable(strTitle);
		    title.setFont(new Font("Malgun Gothic", Font.BOLD,12));
		    title.setAlignment(StringAlignment.CENTER);
		    chart1.getTitles().add(title);
		
		    chart1.setWidth(750);
			chart1.setHeight(260);
		    chart1.getImageSettings().setInteractive(false);
		    chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_8.png");
		    
		    //등급매출별 고객현황
			form.setParam("tabFlag"  , new String[]{"2"});
			
			strData = dao.searchCustPie(form, strUsrId);
			cfxXML = new XmlDataProvider();
		    cfxXML.loadXML(strData);
		    chart1 = new Chart();
		    chart1.getLegendBox().setVisible(true);
		    chart1.getLegendBox().setFont(new Font("Malgun Gothic",Font.PLAIN,8));
		    chart1.getDataSourceSettings().setDataSource(cfxXML);
		    chart1.setGallery(Gallery.PIE);
		    chart1.getPlotAreaMargin().setTop(-1);
		    chart1.getPlotAreaMargin().setBottom(-1);
		    chart1.getPlotAreaMargin().setLeft(0);
		    chart1.getPlotAreaMargin().setRight(0);
		    pie = (Pie) chart1.getGalleryAttributes();
		    pie.setSquare(false);
		    pie.setLabelsInside(false);
		    
		    //포인트 칼라설정
		    chart1.getPoints().get(0).setColor(Color.black);		//블랙
		    chart1.getPoints().get(1).setColor(Color.yellow);	//골드
		    chart1.getPoints().get(2).setColor(Color.blue);		//블루
		    chart1.getPoints().get(3).setColor(Color.green);		//그린
		    
		    //3D세팅
			chart1.getView3D().setEnabled(true);
			chart1.getView3D().setAngleX((short) 30);
			
			chart1.getAllSeries().getPointLabels().setVisible(true);
		    chart1.getAllSeries().getPointLabels().setFormat("%v\n%p%%");
		    chart1.getAllSeries().getPointLabels().setFont(new Font("Malgun Gothic",Font.PLAIN,10));
		    chart1.getAllSeries().setSeparateSlice((short)20);
		    
		    strTitle = form.getParam("BIZ_RSLT_YM").substring(0, 4)+ "년 " 
                     + form.getParam("BIZ_RSLT_YM").substring(4, 6) + "월 등급별 고객매출 현황(단위:백만)";
            if(SUM_GB.equals("2")) strTitle += " 누계";

            title = new TitleDockable(strTitle);
		    title.setFont(new Font("Malgun Gothic", Font.BOLD,12));
		    title.setAlignment(StringAlignment.CENTER);
		    chart1.getTitles().add(title);
		
		    chart1.setWidth(750);
			chart1.setHeight(260);
		    chart1.getImageSettings().setInteractive(false);
		    chart1.exportChart(FileFormat.PNG, strFilePath+strFileName+"_9.png");
			
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
