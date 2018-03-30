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
 
import tcom.dao.TCom103DAO;
import tcom.dao.TCom104DAO;
import tcom.dao.TCom005DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
/**
 * <p>SMS발송</p>
 *  
 * @created  on 1.0, 2010/07/01
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class TCom005Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom005Action.class);

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
	 * <p>문자전송.</p>
	 * 
	 */
	public ActionForward sendSMS(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		TCom005DAO dao 		= null;
		int ret				= 0;
		
		HttpSession session = request.getSession();
		String userId	    = null;

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo"); 
			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);

			dSet = new GauceDataSet[2];
			dSet[0] =  helper.getDataSet("DS_IO_SMS_MASTER"); 
			dSet[1] =  helper.getDataSet("DS_O_SMS_LIST"); 
			
			helper.setDataSetHeader(dSet[0], "H_SEL_MASTER"); 
			helper.setDataSetHeader(dSet[1], "H_SEL_USER"); 
			
			MultiInput mi[] = new MultiInput[2];
			mi[0] = helper.getMutiInput(dSet[0]);		
			mi[1] = helper.getMutiInput(dSet[1]);		
			
			dao = new TCom005DAO(); 
			
			ret = dao.sendSMS(form, mi, userId);   
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet ,ret + "건 문자메세지를 보냈습니다.");
		}
		return mapping.findForward(strGoTo);
	}
	 	
	/**
	 * <p>받는사람 추가를 팝업으로 보여준다. : TCOM0051</p>
	 * 
	 */
	public ActionForward addSendUserPop(ActionMapping mapping, ActionForm form,
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
	 * <p> 받는사람 추가 POP TCOM0051 : 조회  </p>
	 * 
	 */
	public ActionForward selectUserList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom005DAO dao 		= null;
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try { 
			helper = new GauceHelper2(request, response, form);   

			dSet = helper.getDataSet("DS_O_USER"); 
			helper.setDataSetHeader(dSet, "H_SEL_USER");
			 
			dao = new TCom005DAO();
			list = dao.selectUserList(form);  
			helper.setListToDataset(list, dSet);   
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>예약발송  팝업으로 보여준다. : TCOM0052</p>
	 * 
	 */
	public ActionForward bookSmsPop(ActionMapping mapping, ActionForm form,
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

}
