/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.action;

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
import pcod.dao.PCod712DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>행사장 매출조회</p>
 * 
 * @created  on 1.0, 2016/10/27
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod712Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod712Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
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
	 * 행사장마스터를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PCod712DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PCod712DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			
			list = dao.searchMaster(form, userId);
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
	 * 행사장별 POS, 제외브랜드 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod712DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			list    = new List[1];
			dSet    = new GauceDataSet[1];
			dao     = new PCod712DAO();
			helper  = new GauceHelper2(request, response, form);
			
			dSet[0] = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL");
			list    = dao.searchDetail(form, userId);
			helper.setListToDataset(list[0], dSet[0]);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
}
