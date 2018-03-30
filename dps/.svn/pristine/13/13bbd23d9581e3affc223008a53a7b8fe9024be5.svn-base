/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.action;

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

import org.apache.log4j.Logger;

import pstk.dao.PStk302DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>백화점영업관리> 재고수불> 재고실사> 기간수불장현황(단품)</p>
 * 
 * @created  on 1.0, 2010/05/19
 * @created  by 이재득
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk302Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PStk302Action.class);
	
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
	 * <p>
	 * 수량기준 수불장현황을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSkuQty(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk302DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new PStk302DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_SKUDAYQTY");
			helper.setDataSetHeader(dSet, "H_SEL_SKUQTY");
			list = dao.searchSkuQty(form);
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
	 *  금액기준 수불장 현황을 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSkuAmt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk302DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {	
			dao = new PStk302DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_SKUDAYAMT");
			helper.setDataSetHeader(dSet, "H_SEL_SKUAMT");
			list = dao.searchSkuAmt(form);
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
	 * 수불장현황(단품)을 출력한다.
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
}
