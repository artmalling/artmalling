/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.action;

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
import mcae.dao.MCae601DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>사은품 지급 정산</p>
 * 
 * @created  on 1.0, 2011/03/15
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae601Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae601Action.class);

	/**
	 * <p>사은품 지급 정산</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = form.getParam("goTo"); // 분기할곳
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
	 * <p>사은행사 정산 정보 조회</p>
	 * 
	 */
	public ActionForward getEventInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae601DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			dao = new MCae601DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVENTINFO");
			helper.setDataSetHeader(dSet, "H_EVENTINFO");
			list = dao.getEventInfo(form);
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
	 * <p>사은행사 정산 정보 (제휴사카드사정산내역, 물품 정산내역) 조회</p>
	 * 
	 */
	public ActionForward getCalInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae601DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			dao = new MCae601DAO();
			dSet = new GauceDataSet[2];
			list = new List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_CARDCAL");
			helper.setDataSetHeader(dSet[0], "H_CARDCAL");
			dSet[1] = helper.getDataSet("DS_O_PRSNTCAL");
			helper.setDataSetHeader(dSet[1], "H_PRSNTCAL");
			list = dao.getCalInfo(form);
			for (int i = 0; i < list.length; i++) {
				helper.setListToDataset(list[i], dSet[i]);
			}
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>정산 재생성</p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = new GauceDataSet[2];
		MCae601DAO dao = new MCae601DAO();
		HttpSession session = request.getSession();
		String userId = null;
		MultiInput mi[] = new MultiInput[2];
		String strGoTo = form.getParam("goTo"); // 분기할곳
		int ret = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_PRSNTCAL");
			dSet[1] = helper.getDataSet("DS_O_CARDCAL");
			for (int i = 0; i < mi.length; i++) {
				mi[i] = helper.getMutiInput(dSet[i]);
			}
			ret = dao.save(form, mi, userId);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, ret + "건 저장 되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>사은행사 정산관리 상세 pop-up open</p>
	 * 
	 */
	public ActionForward openPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = form.getParam("goTo"); // 분기할곳
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
	 * <p>사은행사 정산관리 상세</p>
	 * 
	 */
	public ActionForward getEvtSkuStock(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae601DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			dao = new MCae601DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVTSKUSTOCK");
			helper.setDataSetHeader(dSet, "H_EVTSKUSTOCK");
			list = dao.getEvtSkuStock(form);
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
