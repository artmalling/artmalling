/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package pord.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import pord.dao.POrd000DAO;

import common.vo.SessionInfo;

/**
 * <p> 발주매입 공통 </p>
 * 
 * @created  on 1.0, 2010/02/17	
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd000Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd000Action.class);

	/**
	 * <p> 로그인사번이 바이어/SM인지를 조회('Y') </p>
	 * 
	 */
	public ActionForward getBuyerYN(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null; 
		POrd000DAO dao = null;
		 
		
		HttpSession session = request.getSession();
		String userId = null;
		
		// 임시
		String org_flag = "1";  // 조직구분 (1:판매, 2:매입)
		String strBuyerYN 	= "";

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
						
			dao = new POrd000DAO();
			helper = new GauceHelper2(request, response, form);
			strBuyerYN = dao.getBuyerYN(form, org_flag, userId); 
			strBuyerYN = org_flag + "|" + strBuyerYN;
			System.out.println("strByuerYN :::: "+strBuyerYN);		
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(strBuyerYN);
		}
		return mapping.findForward(strGoTo);
	}
	
    
	/**
	 * <p> 협력사의 반올림구분  </p>
	 * 
	 */
	public ActionForward getVenRoundFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null; 
		POrd000DAO dao = null;
		 
		
		HttpSession session = request.getSession();
		String userId = null;

		String strRoundFlag 	= "";

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
						
			dao = new POrd000DAO();
			helper = new GauceHelper2(request, response, form);
			strRoundFlag = String2.nvl(dao.getVenRoundFlag(form)); 
System.out.println("strRoundFlag::"+strRoundFlag.length()+"::");
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(strRoundFlag);
		}
		return mapping.findForward(strGoTo);
	}

}
