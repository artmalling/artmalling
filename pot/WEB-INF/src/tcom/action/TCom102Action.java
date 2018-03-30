/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

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

import tcom.dao.TCom102DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>시스템메뉴-메뉴/프로그램 관리</p>
 *
 * @created  on 1.0, 2010/12/12
 * @created  by 정지인(FUJITSU KOREA LTD.)
 *
 * @modified on
 * @modified by
 * @caused   by
 */
public class TCom102Action extends DispatchAction {

	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom102Action.class);

	/**
	 * <p>메뉴/프로그램 관리 페이지를 보여준다.</p>
	 *
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

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
	 * <p>선택된 분류에 해당하는 모든 프로그램을 보여준다.</p>
	 *
	 */
	public ActionForward treeview(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom102DAO dao 		= null;

		try {

			dao = new TCom102DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_TREE_MAIN");
			helper.setDataSetHeader(dSet, "H_TREE_MAIN");
			list = dao.getTreeList(form);

			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[treeview]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward("treeview");
	}

	/**
	 * <p>대분류 메뉴를 보여준다.</p>
	 *
	 */
	public ActionForward selectLmenu(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom102DAO dao 		= null;

		try {

			dao = new TCom102DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_IO_LMENU");
			helper.setDataSetHeader(dSet, "H_SEL_LMENU");
			list = dao.getLMENU(form);

			helper.setListToDataset(list, dSet);

		} catch (Exception e) {

			e.printStackTrace();
			logger.error("[selectLmenu]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward("selectLmenu");
	}

	/**
	 * <p>중분류 메뉴를 보여준다.</p>
	 *
	 */
	public ActionForward selectMmenu(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom102DAO dao 		= null;

		try {

			dao = new TCom102DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_IO_MMENU");
			helper.setDataSetHeader(dSet, "H_SEL_MMENU");

			dao = new TCom102DAO();
			list = dao.getMMENU(form);

			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[selectMmenu]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward("selectMmenu");
	}

	/**
	 * <p>소분류 메뉴를 보여준다.</p>
	 *
	 */
	public ActionForward selectSmenu(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom102DAO dao 		= null;

		try {

			dao = new TCom102DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_IO_SMENU");
			helper.setDataSetHeader(dSet, "H_SEL_SMENU");

			list = dao.getSMENU(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[selectSmenu]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward("selectSmenu");
	}

	/**
	 * <p>선택된 분류에 해당하는 모든 프로그램을 보여준다.</p>
	 *
	 */
	public ActionForward selectProgram(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom102DAO dao 		= null;

		try {

			dao = new TCom102DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_IO_PROGRAM");
			helper.setDataSetHeader(dSet, "H_SEL_PROGRAM");

			list = dao.getPROGRAM(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[selectProgram]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward("selectProgram");
	}

	/**
	 * <p> 변경사항을 저장한다.(등록,수정,삭제)
	 */
	public ActionForward saveAll(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		TCom102DAO dao = null;
		int ret = 0;

		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId = sessionInfo.getUSER_ID();

		String strGoTo = form.getParam("goTo"); // 분기할곳


		try {
			helper = new GauceHelper2(request, response, form);

			dSet = new GauceDataSet[4];
			dSet[0] = helper.getDataSet("DS_IO_LMENU");
			dSet[1] = helper.getDataSet("DS_IO_MMENU");
			dSet[2] = helper.getDataSet("DS_IO_SMENU");
			dSet[3] = helper.getDataSet("DS_IO_PROGRAM");

			helper.setDataSetHeader(dSet[0], "H_SEL_LMENU");
			helper.setDataSetHeader(dSet[1], "H_SEL_MMENU");
			helper.setDataSetHeader(dSet[2], "H_SEL_SMENU");
			helper.setDataSetHeader(dSet[3], "H_SEL_PROGRAM");

			MultiInput mi[] = new MultiInput[4];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			mi[2] = helper.getMutiInput(dSet[2]);
			mi[3] = helper.getMutiInput(dSet[3]);

			dao = new TCom102DAO();
			
			ret = dao.saveAll(form, mi, userId);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet,  "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}

}
