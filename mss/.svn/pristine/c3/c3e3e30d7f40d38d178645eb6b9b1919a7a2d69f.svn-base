/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package meis.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import meis.dao.MEis028DAO;

import com.gauce.GauceDataSet;

/**
 * <p>항목별비용계획조회</p>
 * 
 * @created on 1.0, 2011/05/30
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis028Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis028Action.class);

	/** 
	 * <p>항목별비용계획조회 화면로딩</p>
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
	 * <p>계정별 비용계획조회</p>
	 */
	public ActionForward searchBiz(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis028DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis028DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchBiz(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ");
			
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
	 * <p>조직별 비용계획조회</p>
	 */
	public ActionForward searchOrg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis028DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis028DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchOrg(form);
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
	 * <p>월별 비용계획조회</p>
	 */
	public ActionForward searchMonth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis028DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis028DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchMonth(form);
			helper.setDataSetHeader(dSet, "H_SEL_MONTH");
			
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
	 * <p>엑셀 데이터 조회</p>
	 */
	public ActionForward getExcelData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis028DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis028DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getExcelData(form);
			helper.setDataSetHeader(dSet, "H_BIZPLAN_EXCEL");
			
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
	
}
