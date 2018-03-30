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
import mgif.dao.MGif112DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>발행의뢰(인쇄업체)</p>
 * 
 * @created  on 1.0, 2011/04/13
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif112Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

	/**
	 * <p>발행의뢰(인쇄업체) 초기화면</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		try {
			GauceHelper2.initialize(form, request, response);
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward("list");
	}
	
	/**
	 * <p>발행의뢰 (인쇄업체) 마스터 조회 </p>
	 * 
	 */
	public ActionForward getReqMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif112DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif112DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.getReqMst(form);
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
	 * <p>발행의뢰 (인쇄업체) 디테일 조회 </p>
	 * 
	 */
	public ActionForward getReqDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif112DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif112DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getReqDtl(form);
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
	 * 미생성 발행신청 삭제
	 * </p>
	 * 
	 */
	public ActionForward delIssueReq(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet = new GauceDataSet();
		MGif112DAO dao = new MGif112DAO();
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			MultiInput mi = helper.getMutiInput(dSet);
			ret = dao.delIssueReq(form, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 발행의뢰 저장
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet = new GauceDataSet();
		MGif112DAO dao = new MGif112DAO();
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
			helper.close(dSet,"처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>발행의뢰 (인쇄업체) 내용 엑셀 저장 </p>
	 * 
	 */
	public ActionForward getExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MGif112DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif112DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new  GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet[0], "H_MASTER");
			dSet[1] = helper.getDataSet("DS_O_EXCEL");
			helper.setDataSetHeader(dSet[1], "H_EXCEL");
			MultiInput mi = helper.getMutiInput(dSet[0]);
			list = dao.getExcel(form, mi);
			helper.setListToDataset(list, dSet[1]);
			

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoTo = form.getParam("goTo"); // 분기할곳
		GauceHelper2.initialize(form, request, response);
		return mapping.findForward(strGoTo);
	}
}
