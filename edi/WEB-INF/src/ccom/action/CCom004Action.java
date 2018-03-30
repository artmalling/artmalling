/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
   
package ccom.action;
      
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

import org.apache.log4j.Logger;

import ccom.dao.CCom004DAO;
import ecom.vo.SessionInfo2;

/**
 * <p>단품코드(점별) 팝업</p>
 * 
 * @created  on 1.0, 2011/08/20
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom004Action extends DispatchAction {
	private Logger logger = Logger.getLogger(CCom004Action.class);

    /**
     * <p>
     * 단품코드(점별) 팝업
     * </p>
     */
    public ActionForward strSkuPop(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
	        SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			 if (sessionInfo != null) {
	                System.out.println("USER : " + sessionInfo.getUSER_ID());
	            } 
		}catch(Exception e){
			e.printStackTrace();
		}
		return mapping.findForward(strGoto);
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
		
		
		StringBuffer sb = null;
		CCom004DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new CCom004DAO();
			
			sb = dao.searchOnPop(form, true, userid, "");

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}

	/**
	 * <p>
	 * Popup.js 에서 조회
	 * </p>
	 * 
	 */
/*	public ActionForward searchOnWithoutPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom004DAO dao = null;
		MultiInput mi = null;
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_STRSKUMST");

			dao = new CCom004DAO();
			list = dao.searchOnPop(form, mi, true, userId, orgFlag);

			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}*/
	
	/**
	 * <p>
	 * 매입발주 Validation체크용 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnWithoutPordPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		
		StringBuffer sb = null;
		CCom004DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new CCom004DAO();
			
			sb = dao.searchOnPop(form, false, userid, "");

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
}
