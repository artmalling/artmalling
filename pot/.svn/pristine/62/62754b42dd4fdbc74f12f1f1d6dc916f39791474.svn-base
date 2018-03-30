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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.dao.CCom200DAO;

/**
 * <p>
 * 협렵사 조회 팝업
 * </p>
 * 
 * @created on 1.0, 2010/01/25
 * @created by 김성미 (FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom200Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom200Action.class);

	/**
	 * <p>
	 * 협력사 콤보 조회
	 * </p>
	 * 
	 */
	public ActionForward getComboCd(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom200DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet(form.getParam("strDataSet").toString());
			helper.setDataSetHeader(dSet, "H_COMBO");
			dao = new CCom200DAO();
			list = dao.getComboCd(form);
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
