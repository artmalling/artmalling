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
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import tcom.dao.TCom003DAO;

/**
 * <p>
 * 로긴 후 좌측 트리메뉴
 * </p>
 * 
 * @created on 1.0, 2010/12/14
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class TCom003Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom003Action.class);

	/**
	 * <p>
	 * 메뉴를 보여준다.
	 * </p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳

		GauceHelper2.initialize(form, request, response);
		request.setAttribute("systemCode", request.getParameter("systemCode"));

		return mapping.findForward(strGoTo);

	}

	/**
	 * <p>
	 * 메뉴를 트리로 표현할 정보를 보여준다.
	 * </p>
	 * 
	 */
	public ActionForward treeview(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		TCom003DAO code = null;
		MultiInput mi = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		String strSubCode = null;

		try {
			strSubCode = String2.trimToEmpty(form.getParam("subCode"));
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_SUB_SYSTEM");
			dSet[1] = helper.getDataSet("DS_O_TREE_MAIN");
			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_TREE_MAIN");

			// User ID를 세션에서 읽음
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");

			String userId = null;

			if (sessionInfo != null) {
				userId = sessionInfo.getUSER_ID();
			} else {
				return mapping.findForward(strGoTo);
			}

			code = new TCom003DAO();
			if("F".equals(strSubCode)){
				list = code.getFavorite(form, userId);
			} else {
				list = code.getTreeList(form, mi, userId);
			}

			helper.setListToDataset(list, dSet[1]);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, "성공적으로 요청처리 되었습니다. ");
		}
		return mapping.findForward(strGoTo);
	}

}
