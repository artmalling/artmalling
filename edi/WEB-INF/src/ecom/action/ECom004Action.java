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
 
import ecom.dao.ECom004DAO;
import ecom.vo.SessionInfo2;  



public class ECom004Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECom004Action.class);

	 
	/**
	 * <p>MASTER조회</p>
	 * 
	 */
	public ActionForward chkIdPwd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		String strGoto = form.getParam("goTo");
		ECom004DAO dao = null; 
		String json = null;
		try{
			dao = new ECom004DAO();
			json = (String) dao.chkIdPwd(form);
		}catch(Exception e){
			e.printStackTrace();
		}
 
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	} 
	
	
	/**
	 * 비밀번호 변경시 확인
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward xmlPwd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		String strGoto = form.getParam("goTo");
		ECom004DAO dao = null; 
		String json = null;
		try{
			dao = new ECom004DAO();
			json = (String) dao.xmlPwd(form);
		}catch(Exception e){
			e.printStackTrace();
		}
 
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}  


	
	/**
	 * 비밀번호 오류시 PWDCNT UPDATE
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward idUpSelect(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
		ECom004DAO dao		= null;
        String json 		= null;
		try{ 
			HttpSession session = request.getSession();	
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
            System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); 
			dao = new ECom004DAO(); 
			json = (String) dao.idUpSelect(form);
			System.out.println(":::::::::::::::::::::::::::: " + json);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }  
}
