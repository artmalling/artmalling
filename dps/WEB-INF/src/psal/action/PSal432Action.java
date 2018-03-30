/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.util.Date2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;

import psal.dao.PSal432DAO;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal432Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal432Action.class);

	/**
	 * <p>페이지를 로드한다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

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
	 * <p>브랜드매출정보 팝업을 보여준다.</p>
	 * 
	 */
	public ActionForward brandSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

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
	 * <p>일별매출정보 팝업을 보여준다.</p>
	 * 
	 */
	public ActionForward daySearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

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
	 * <p>월별매출정보 팝업을 보여준다.</p>
	 * 
	 */
	public ActionForward monthSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

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
	 * <p>시간별매출정보 팝업을 보여준다.</p>
	 * 
	 */
	public ActionForward timeSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

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
	 * <p>고객매출정보 팝업을 보여준다.</p>
	 * 
	 */
	public ActionForward custSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

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
	 * <p>
	 * 마스터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal432DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_MASTER");
			dSet[1] = helper.getDataSet("DS_TIME");
			helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
			list = dao.searchMaster(form);
			helper.setListToDataset(list, dSet[0]);
			

			dSet[1].addDataColumn(new GauceDataColumn("TIME", GauceDataColumn.TB_STRING ,12, 0, GauceDataColumn.TB_NORMAL ));
			list = new ArrayList();
			list.add(Arrays.asList(Date2.YYYYMMDDHHMM("")));
			helper.setListToDataset(list, dSet[1]);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/** 
	 * <p>
	 * 도면을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchFloorPlan(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal432DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_FLOOR_PLAN");
			helper.setDataSetHeader(dSet, "H_SEL_FLOOR_PLAN");
			list = dao.searchFloorPlan(form);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 브랜드매출정보을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchBrand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal432DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_BRAND_INFO");
			helper.setDataSetHeader(dSet, "H_SEL_BRAND_INFO");
			list = dao.searchBrand(form);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 일별매출정보을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDay(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal432DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_DAY_INFO");
			helper.setDataSetHeader(dSet, "H_SEL_DAY_INFO");
			list = dao.searchDay(form);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 월별매출정보을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMonth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal432DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MONTH_INFO");
			helper.setDataSetHeader(dSet, "H_SEL_MONTH_INFO");
			list = dao.searchMonth(form);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 시간별매출정보을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchTime(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal432DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_TIME_INFO");
			helper.setDataSetHeader(dSet, "H_SEL_TIME_INFO");
			list = dao.searchTime(form);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 고객매출정보을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchCust(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal432DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal432DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[3];
			dSet[0] = helper.getDataSet("DS_CUST_INFO_01");
			dSet[1] = helper.getDataSet("DS_CUST_INFO_02");
			dSet[2] = helper.getDataSet("DS_CUST_INFO_03");
			helper.setDataSetHeader(dSet[0], "H_SEL_CUST_INFO_01");
			helper.setDataSetHeader(dSet[1], "H_SEL_CUST_INFO_02");
			helper.setDataSetHeader(dSet[2], "H_SEL_CUST_INFO_03");
			list = dao.searchCust_01(form);
			helper.setListToDataset(list, dSet[0]);
			list = dao.searchCust_02(form);
			helper.setListToDataset(list, dSet[1]);
			list = dao.searchCust_03(form);
			helper.setListToDataset(list, dSet[2]);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
}
