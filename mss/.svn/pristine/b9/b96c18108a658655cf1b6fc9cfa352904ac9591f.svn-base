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
import mgif.dao.MGif316DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/14
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 

public class MGif316Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif316Action.class);
	
    /**
     * <p>화면 LODA</p>
     * 
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        try {
            GauceHelper2.initialize(form, request, response);
        } catch (Exception e) {
            logger.error("", e);
        }
        return mapping.findForward("list");
    }
    
	/**
	 * <p>상품권 판매 마스터 조회 </p>
	 * 
	 */
	public ActionForward getGiftSaleMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif316DAO dao = null;
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			
			dao = new MGif316DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_SEL_GIFT_SALE_MST");
			helper.setDataSetHeader(dSet, "H_GIFT_SALE_MST");
			list = dao.getGiftSaleMst(form,userId);
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
	 * <p>금종 조회 </p>
	 * 
	 */
	public ActionForward getGiftAmtMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif316DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif316DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_SEL_GIFT_AMT_MST");
			helper.setDataSetHeader(dSet, "H_GIFT_AMT_MST");
			list = dao.getGiftAmtMst(form);
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
	 * <p>상품권 정보 조회 </p>
	 * 
	 */
	public ActionForward getGiftDtlAmtMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif316DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif316DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_SEL_GIFT_SALE_DETAIL");
			helper.setDataSetHeader(dSet, "H_GIFT_SALE_DETAIL");
			list = dao.getGiftDtlAmtMst(form);
			helper.setListToDataset(list, dSet);
			

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
