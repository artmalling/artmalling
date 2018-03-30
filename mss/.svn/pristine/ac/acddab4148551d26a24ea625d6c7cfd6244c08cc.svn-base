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
import mcae.dao.MCae106DAO;
import mcae.dao.MCae402DAO;
import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>
 * </p>
 * 
 * @created on 1.0, 2010/12/14
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae402Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae402Action.class);

	/**
	 * <p>
	 * 사은품 지급 취소 메인 화면
	 * </p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		try {

			GauceHelper2.initialize(form, request, response);

			HttpSession session = request.getSession();
			// System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");

			if (sessionInfo != null) {
				System.out
						.println("USER : " + sessionInfo.getUSER_ID());
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}

	/**
	 * <p>
	 * 사은품 지급 취소 : 행사 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getEventInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae402DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae402DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_EVENT_INFO");
			helper.setDataSetHeader(dSet, "H_EVENT_INFO");
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
	 * <p>
	 * 카드 콤보조회
	 * </p>
	 * 
	 */
	public ActionForward getCardComp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		List list = null;
		HttpSession session = request.getSession();
		String strGo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CARD_COMP");
			helper.setDataSetHeader(dSet, "H_CARD_COMBO");
			MCae402DAO dao = new MCae402DAO();
			list = dao.getCardComp(form);
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGo);
	}
	
	/**
	 * <p>
	 * 사은품 지급 취소 : 사은품 지급 영수증 내용 조회
	 * </p>
	 * 
	 */
	public ActionForward getPrsntInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae402DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae402DAO();
			dSet = new GauceDataSet[2];
			list = new List[2];
			helper = new GauceHelper2(request, response, form);
			if(form.getParam("strEventType").equals("02")){
				dSet[0] = helper.getDataSet("DS_IO_PRSNT_CARD");
				helper.setDataSetHeader(dSet[0], "H_PRSNT_INFO_CARD");
			}else{
				dSet[0] = helper.getDataSet("DS_IO_PRSNT");
				helper.setDataSetHeader(dSet[0], "H_PRSNT_INFO");
			}
			dSet[1] = helper.getDataSet("DS_IO_PRSNTRECP");
			helper.setDataSetHeader(dSet[1], "H_PRSNTRECP_INFO");
			list = dao.getPrsntInfo(form);
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
	 * <p>
	 * 사은품 지급 취소 등록
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = new GauceDataSet[3];
		MCae402DAO dao = new MCae402DAO();
		HttpSession session = request.getSession();
		String userId = null;
		MultiInput mi[] = new MultiInput[3];
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_EVENT_INFO");
			if(form.getParam("strEventType").equals("02")){
				dSet[1] = helper.getDataSet("DS_IO_PRSNT_CARD");
			}else{
				dSet[1] = helper.getDataSet("DS_IO_PRSNT");
			}
			dSet[2] = helper.getDataSet("DS_IO_PRSNTRECP");

			for (int i = 0; i < mi.length; i++) {
				mi[i] = helper.getMutiInput(dSet[i]);
			}
			ret = dao.save(form, mi, userId);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, "취소 처리되었습니다");
		}
		return mapping.findForward("save");
	}
}
