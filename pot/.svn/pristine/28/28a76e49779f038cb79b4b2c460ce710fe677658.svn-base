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

import common.dao.CCom027DAO;
import common.vo.SessionInfo;

import com.gauce.GauceDataSet;


/**
 * <p>카드발급사 코드 팝업</p>
 * 
 * @created  on 1.0, 2010/05/23
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom027Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom027Action.class);

    /**
     * <p>
     * 카드발급사 코드 팝업
     * </p>
     */
    public ActionForward ccompPop(ActionMapping mapping, ActionForm form,
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
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        CCom027DAO      dao     = null;
         
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new CCom027DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
             
            list   = dao.searchMaster(form);
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
	 * Popup.js 에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        CCom027DAO      dao     = null;
         
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new CCom027DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
             
            list   = dao.searchMaster(form);
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
