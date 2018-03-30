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
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import common.dao.CCom023DAO;
import common.vo.SessionInfo;

import com.gauce.GauceDataSet;

/**
 * <p>OFFER SHEET 팝업</p>
 * 
 * @created  on 1.0, 2010/03/24
 * @created  by 정진영
 * 
 * @modified on 
 * @modified by                           
 * @caused   by 
 */

public class CCom023Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom023Action.class);

    /**
     * <p>
     * OFFER SHEET 팝업
     * </p>
     */
    public ActionForward offerSheetPop(ActionMapping mapping, ActionForm form,
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
	 * OFFER SHEET HEADER 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOffmst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom023DAO dao = null;
		MultiInput mi = null;         

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_OFFMST");
			
			helper.setDataSetHeader(dSet[1], "H_SEL_OFFMST");
			
			mi = helper.getMutiInput(dSet[0]);

			dao = new CCom023DAO();
			list = dao.searchOffmst(form, mi);

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
	 * OFFER SHEET DETAIL 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOffdtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom023DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_O_OFFDTL");
			helper.setDataSetHeader(dSet, "H_SEL_OFFDTL");

			dao = new CCom023DAO();
			list = dao.searchOffdtl(form);
			
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
