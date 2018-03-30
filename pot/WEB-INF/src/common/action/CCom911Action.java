/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.action;

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

import com.gauce.GauceDataSet;
import common.dao.CCom911DAO;
import common.vo.SessionInfo;

/**
 * <p>
 * 공통코드 처리
 * </p>
 * 
 * @created on 1.0, 2010/12/12
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom911Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom911Action.class);

	/**
	 * <p>
	 * 공통 팝업
	 * </p>
	 */
	public ActionForward pop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 공통 팝업2
	 * </p>
	 */
	public ActionForward popOnlyCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 공통 팝업3 (Grid에서 호출할때의 팝업)
	 * </p>
	 */
	public ActionForward popToGrid(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 팝업에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom911DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_COMMON");

			dao = new CCom911DAO();
			list = dao.searchOnPop(form, mi);

			helper.setListToDataset(list, dSet[1]);

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
	 * 팝업에서 조회 (조건값을 파라메터로 넘겨 사용)
	 * </p>
	 * 
	 */
	public ActionForward searchOnPopWithCond(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom911DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_COMMON");

			dao = new CCom911DAO();
			list = dao.searchOnPopWithCond(form, mi);

			helper.setListToDataset(list, dSet[1]);

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
	 * 팝업 안띄우고 조회(1건)
	 * </p>
	 * 
	 */
	public ActionForward getOneWithoutPop(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom911DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_CONDITION");
			dSet[1] = helper.getDataSet("DS_O_RESULT");
			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_COMMON");

			dao = new CCom911DAO();
			list = dao.getOneWithoutPop(form, mi);
			helper.setListToDataset(list, dSet[1]);

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
	 * 공통 간편 Query 조회
	 * </p>
	 * 
	 */
	public ActionForward getCommonDataSet(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom911DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_CONDITION");
			dSet[1] = helper.getDataSet("DS_O_RESULT");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_COMMON_EASY");

			dao = new CCom911DAO();
			list = dao.getCommonDataSet(form, mi);

			helper.setListToDataset(list, dSet[1]);

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
	 * TO DO LIST 셋팅한다.
	 * </p>
	 * 
	 */
	public ActionForward enroll2DoList(ActionMapping mapping, ActionForm form
									 , HttpServletRequest request, HttpServletResponse response) throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		CCom911DAO dao 		= null;
		MultiInput mi 		= null;

		HttpSession session = request.getSession();
		String userId 		= null;
		int ret				= 0;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo"); 
			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_CONDITION"); 
			
			mi = helper.getMutiInput(dSet);

			dao = new CCom911DAO(); 
			ret = dao.enroll2DoList(form, mi, userId);  
			
 
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
}
