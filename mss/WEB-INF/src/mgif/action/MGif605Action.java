/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

import gauce.lib.gauceDataSet;

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
import mgif.dao.MGif102DAO;
import mgif.dao.MGif605DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>자사위탁판매 입금등록</p>
 * 
 * @created  on 1.0, 2011/06/09
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MGif605Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

	/**
	 * <p>자사위탁판매 정산 화면</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = form.getParam("goTo");
		try {
			GauceHelper2.initialize(form, request, response);
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 자사 위탁판매 정산 내역 조회
	 * </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif605DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			dao = new MGif605DAO();
			dSet = new  GauceDataSet();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_VENPAY"); 
			helper.setDataSetHeader(dSet, "H_VENPAY"); 
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
	 * 협력사 수수료 정보조회
	 * </p>
	 * 
	 */
	public ActionForward getVenFee(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif605DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			dao = new MGif605DAO();
			dSet = new  GauceDataSet();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_VENFEE"); 
			helper.setDataSetHeader(dSet, "H_VENFEE"); 
			list = dao.getVenFee(form);
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
	 * 자사위탁판매 입급 저장/ 수정
	 * </p>
	 * 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif605DAO dao = null;
		HttpSession session = request.getSession();
		String userId = null;
		MultiInput mi = null;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_VENPAY");
			mi = helper.getMutiInput(dSet);
			dao = new MGif605DAO();
			ret = dao.save(form, mi, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
}
