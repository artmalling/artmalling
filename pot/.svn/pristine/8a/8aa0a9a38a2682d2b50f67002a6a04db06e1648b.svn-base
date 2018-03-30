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

import org.apache.log4j.Logger;

import tcom.dao.TCom104DAO;
import tcom.dao.TCom304DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
/**
 * <p>실시간로그인현황</p>
 *  
 * @created  on 1.0, 2010/06/23
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class TCom304Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom304Action.class);

	/**
	 * <p>페이지LOAD.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	} 
	
	/** 
	 * <p>
	 *  실시간로그인현황을 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward selectList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom304DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_IO_USER");
			helper.setDataSetHeader(dSet, "H_SEL_USER");
			
			list = dao.selectList(form);
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
	 * <p>사용자 로그인이력을 팝업으로 보여준다.</p>
	 */
	public ActionForward logHistoryPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>사용자 로그인이력을보여준다.</p>
	 * POPUP
	 */ 
	public ActionForward selectLogHistory(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom304DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳 
		try {

			helper = new GauceHelper2(request, response, form);  
			dSet = helper.getDataSet("DS_O_HISTORY"); 
			helper.setDataSetHeader(dSet, "H_HISTORY"); 

			dao = new TCom304DAO();
			list = dao.selectLogHistory(form);
			 
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}

}
