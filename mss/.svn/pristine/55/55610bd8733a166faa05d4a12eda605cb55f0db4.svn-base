/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import mren.dao.MRen401DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>관리비청구서관리</p>
 * 
 * @created  on 1.0, 2010.05.16
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MRen401Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MRen401Action.class);

	/**
	 * <p>
	 * 화면 LODA
	 * </p>
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
	 * <p>
	 * 출력화면 LODA
	 * </p>
	 * 
	 */
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳
		GauceHelper2.initialize(form, request, response);

		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 관리비입금내역 조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MRen401DAO dao = null;
		String strGoTo = form.getParam("goTo");
		try {
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MR_CALMST");
			dao = new MRen401DAO();
			list = dao.getMaster(form);
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
	 * 마감내역 확인
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getCheckClose(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MRen401DAO dao = null;
		String strGoTo = form.getParam("goTo");
		try {
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_O_CLOSE_YN");
			helper.setDataSetHeader(dSet, "H_SEL_CLOSE_YN");
			dao = new MRen401DAO();
			list = dao.getCheckClose(form);
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
	 * 저장
	 * </p>
	 */
	public ActionForward billingProcess(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MRen401DAO dao = null;
		String ret = "";
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_PARAMATER");
			helper.setDataSetHeader(dSet, "H_PARAMATER");
			MultiInput mi = helper.getMutiInput(dSet);
			dao = new MRen401DAO();
			ret = dao.billingProcess(form, mi, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, ret + "처리되었습니다");
		}

		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 전표 출력 LIST </p>
	 * 
	 */
	public ActionForward getPrintList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		GauceHelper2 helper     = null;
		GauceDataSet dSet1      = null;
		List list 			    = null;
		MRen401DAO dao 	    	= null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		
		try {
			dao = new MRen401DAO(); 
			helper = new GauceHelper2(request, response, form);
			
			
			/* 단일 출력 */
			dSet1 = helper.getDataSet("DS_PRINT");
			helper.setDataSetHeader(dSet1, "H_PRINT");
			list = dao.getPrintList(form);	
			helper.setListToDataset(list, dSet1);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet1);
		}
		return mapping.findForward(strGoTo);
		
	}	
}
