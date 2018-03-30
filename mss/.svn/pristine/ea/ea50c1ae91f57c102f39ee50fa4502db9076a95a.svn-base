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
import mcae.dao.MCae401DAO;
import mcae.dao.MCae401DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>
 * </p>
 * 
 * @created on 1.0, 2011/05/01
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae401Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae401Action.class);

	/**
	 * <p>
	 * 사은품 지급등록 초기화면
	 * </p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 사은 행사 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getEventCombo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae401DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae401DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVENT_COMBO");
			helper.setDataSetHeader(dSet, "H_COMBO");
			list = dao.getEventCombo(form);
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
	 * 사은 행사 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getEventInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae401DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae401DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVENT_INFO");
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
	 * 영수증 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getSaleInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae401DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae401DAO();
			dSet = new GauceDataSet[2];
			list = new List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_SALE_INFO_TMP");
			helper.setDataSetHeader(dSet[0], "H_SALE_INFO");
			dSet[1] = helper.getDataSet("DS_IO_SALE_CHK");
			helper.setDataSetHeader(dSet[1], "H_SALECHK");
			
			list = dao.getSaleInfo(form);
			helper.setListToDataset(list[0], dSet[0]);
			helper.setListToDataset(list[1], dSet[1]);
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
	 * 영수증 정보 조회 - 고객카드정보로 조회
	 * </p>
	 * 
	 */
	public ActionForward getSaleInfo2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae401DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae401DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_SALE_INFO_TMP");
			helper.setDataSetHeader(dSet, "H_SALE_INFO");
			list = dao.getSaleInfo2(form);
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
	 * 지급품 조회
	 * </p>
	 * 
	 */
	public ActionForward getSkuList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae401DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae401DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_SKU_LIST");
			helper.setDataSetHeader(dSet, "H_SKU_LIST");
			list = dao.getSkuList(form);
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
	 * 지급품 정보 (매입원가, 대상코드)조회
	 * </p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae401DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae401DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_SKU_INFO");
			helper.setDataSetHeader(dSet, "H_SKU_LIST");
			list = dao.getSkuInfo(form);
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
	 * 카드 고객 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getCardInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		List ret = null;
		String userId = "";
		HttpSession session = request.getSession();
		String strGo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CARD_INFO");
			helper.setDataSetHeader(dSet, "H_CARD_INFO");
			MCae401DAO dao = new MCae401DAO();
			ret = dao.getCardInfo(form, userId);
			helper.setListToDataset(ret, dSet);
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
	 * 사은품 지급 등록
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = new GauceDataSet[3];
		MCae401DAO dao = new MCae401DAO();
		HttpSession session = request.getSession();
		String userId = null;
		MultiInput mi[] = new MultiInput[3];
		String strGiftName = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			String strEventType = form.getParam("strEventType");
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_EVENT_INFO");
			if(strEventType.equals("02")){
				dSet[1] = helper.getDataSet("DS_IO_SALE_INFO_CARD");
			}else{
				dSet[1] = helper.getDataSet("DS_IO_SALE_INFO");
			}
			dSet[2] = helper.getDataSet("DS_IO_SKU_LIST");

			for (int i = 0; i < mi.length; i++) {
				mi[i] = helper.getMutiInput(dSet[i]);
			}
			
			ret = dao.save(form, mi, userId);
			strGiftName = mi[2].getString("SKU_NAME");
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, strGiftName + " 사은품이 지급 되었습니다.");
		}
		return mapping.findForward("save");
	}
}
