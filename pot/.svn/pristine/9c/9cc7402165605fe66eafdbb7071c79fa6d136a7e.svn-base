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
import common.dao.CCom900DAO;
import common.vo.SessionInfo;

/**
 * <p>공통사용함수</p>
 * 
 * @created  on 1.0, 2010/12/12	
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom900Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom900Action.class);

    /**
     * <p>
     * 공통코드를 조회한다.
     * </p>
     *
     * <p>
     * 공통코드관련된 내용을 하나의 SQL을 이용하여 처리한다.
     * </p>
     */
    public ActionForward getEtcCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom900DAO   dao   = null;
        MultiInput   mi     = null;

        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMMON");

            dao = new CCom900DAO();

            list = dao.getEtcCode(form, mi);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward("getEtcCode");
    }

    /**
     * <p>
     * 공통코드를 조회한다. REFER 포함
     * </p>
     *
     * <p>
     * 공통코드관련된 내용을 하나의 SQL을 이용하여 처리한다.
     * </p>
     */
    public ActionForward getEtcCodeRefer(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom900DAO   dao   = null;
        MultiInput   mi     = null;

        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMMON_REFER");

            dao = new CCom900DAO();

            list = dao.getEtcCodeRefer(form, mi);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward("getEtcCode");
    }
    
	/**
	 * <p>
	 * 엑셀 다운로드 로그 기록
	 * </p>
	 * 
	 */
	public ActionForward saveExcelDownLog(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom900DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			String userId = sessionInfo.getUSER_ID();
			String pid = sessionInfo.getPGM_ID();

			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_LOG");
			helper.setDataSetHeader(dSet, "H_DOWNLOG");

			MultiInput mi = helper.getMutiInput(dSet);
			
			dao = new CCom900DAO();
			ret = dao.saveExcelDownLog(form, mi, userId, pid);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
}
