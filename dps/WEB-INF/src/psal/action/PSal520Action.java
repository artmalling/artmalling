/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import psal.dao.PSal520DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>POS상품권점검현황</p>
 * 
 * @created on 1.0, 2011.08.28
 * @created by 김유완
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal520Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal520Action.class);

	/** 
	 * <p>POS상품권점검현황 화면로딩</p>
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		return mapping.findForward(form.getParam("goTo"));
	}
	
	/** 
	 * <p>POS상품권점검현황 MASTER조회</p>
	 */
	public ActionForward searchCouSalMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {


		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal520DAO dao = null;

		HttpSession session = request.getSession();
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			dao = new PSal520DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchCouSalMst(form);
			helper.setListToDataset(list, dSet);
			
			
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	

	/** 
	 * <p>
	 * POSNO MIN, MAX 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPosNoMM(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal520DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal520DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_POSNOMM");
			helper.setDataSetHeader(dSet, "H_SEL_POSNOMM");
			list = dao.searchPosNoMM(form, OrgFlag, userid);
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
	 * POSNO MIN, MAX 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPosFlorMM(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal520DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal520DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_POSFLORMM");
			helper.setDataSetHeader(dSet, "H_SEL_POSFLORMM");
			list = dao.searchPosFlorMM(form, OrgFlag, userid);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

}
