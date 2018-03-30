/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

import org.apache.log4j.Logger;

import ecom.dao.ECom002DAO;



public class ECom002Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECom002Action.class);

	/**
	 * 로그 아웃을 하는 경우
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward logout(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {
			HttpSession session = request.getSession();
			session.removeAttribute("sessionInfo");
			session.invalidate();
			response.getWriter().println("<script>");
			response.getWriter().println("window.open('/edi/jsp/login.jsp', '', 'width=1024-10, height=768-55, status=1, resizable=1, titlebar=1, location=1, toolbar=1, menubar=1, scrollbars=1');");
			response.getWriter().println("parent.close();");
			response.getWriter().println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			throw e;
		}

		return mapping.findForward("logout");

	}

	/**
	 * 메인페이지로 이동
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward goMain(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("goMain");
	}


	/**
	 * 매출정보조회
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getSale(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		StringBuffer sb = null;
		ECom002DAO dao = null;
		String strGoto = form.getParam("goTo");

		try{
			dao = new ECom002DAO();

			sb = dao.getSale(form);

		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 대금정보조회
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getbillmst(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		StringBuffer sb = null;
		ECom002DAO dao = null;
		String strGoto = form.getParam("goTo");

		try{
			dao = new ECom002DAO();

			sb = dao.getbillmst(form);

		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		
		return mapping.findForward(strGoto);
	}
}
