/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

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
import mgif.dao.MGif111DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>발행신청</p>
 * 
 * @created  on 1.0, 2011/04/08
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif111Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

	/**
	 * <p>발행신청</p>
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
	 * <p>상품권종류 코드 콤보 조회</p>
	 * 
	 */
	public ActionForward getGiftTypeCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif111DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif111DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_GIFT_TYPE_CD");
			helper.setDataSetHeader(dSet, "H_COMBO");
			list = dao.getGiftTypeCd(form);
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
	 * <p>발행신청 마스터 조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif111DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif111DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
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
	 * <p>발행 신청 상세조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif111DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif111DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getDetail(form);
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
	 * <p>발행 신청 금종 조회</p>
	 * 
	 */
	public ActionForward getNewDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif111DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif111DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getNewDetail(form);
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
	 * 발행신청 저장
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet = new GauceDataSet();
		MGif111DAO dao = new MGif111DAO();
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			MultiInput mi = helper.getMutiInput(dSet);
			ret = dao.save(form, mi, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, ret +"건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
}
