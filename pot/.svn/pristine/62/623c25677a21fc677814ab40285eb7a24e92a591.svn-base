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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.dao.CCom916DAO;
import common.vo.SessionInfo;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

/**
 * <p>점, 부분, 팀, PC 콤보 조회</p>
 * 
 * @created  on 1.0, 2010/02/15	
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom916Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom916Action.class);

    /**
     * <p>
     * 점 조회
     * </p>
     */
    public ActionForward getBeforeYearDay(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
    	
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom916DAO   dao   = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			dao = new CCom916DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_CONDITION");
			helper.setDataSetHeader(dSet, "H_SEL_BEFORE_DAY");
			list = dao.getBeforeYearDay(form);
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
