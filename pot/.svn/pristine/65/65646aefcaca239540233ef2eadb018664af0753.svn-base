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
import tcom.dao.TCom404DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
/**
 * <p>업무배너관리</p>
 *  
 * @created  on 1.0, 2010/07/19
 * @created  by HSEON(FKL)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class TCom404Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom404Action.class);

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
	 *  배너리스트를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward selectBannerList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom404DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
 
		try {  
			dao = new TCom404DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_IO_MAIN");
			helper.setDataSetHeader(dSet, "H_SEL_MAIN");
			
			list = dao.selectBannerList(form);
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
	 * <p>배너정보를 등록/수정한다.</p>
	 *  
	 */
	public ActionForward saveBanner(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List 			list 	= null;
		GauceHelper2 	helper 	= null;
		GauceDataSet 	dSet 	= null;
		TCom404DAO 		dao 	= null;
		MultiInput 		mi 		= null; 
		int 			ret 	= 0;

		HttpSession session = request.getSession();
		String strGoTo 		= form.getParam("goTo"); 				// 분기할곳 
		
		String userId = null;
		try {

			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet   = new GauceDataSet();
			dSet   = helper.getDataSet("DS_IO_MAIN");
			mi 	   = helper.getMutiInput(dSet); 
			
			dao = new TCom404DAO();
			ret = dao.saveBanner(form, mi, userId); 

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally { 
			helper.close(dSet,ret + "건 처리되었습니다");
		}

		return mapping.findForward(strGoTo);
	}
}
