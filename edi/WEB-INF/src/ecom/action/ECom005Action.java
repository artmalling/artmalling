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

import ecom.dao.ECom005DAO;
import ecom.vo.SessionInfo2;



public class ECom005Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECom005Action.class);

	 
	/**
	 * <p>MASTER조회</p>
	 * 
	 */
	public ActionForward chkIdPwd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		String strGoto = form.getParam("goTo");
		ECom005DAO dao = null; 
		String json = null;
		try{
			dao = new ECom005DAO();
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
		ECom005DAO dao = null; 
		String json = null;
		try{
			dao = new ECom005DAO();
			json = (String) dao.xmlPwd(form);
		}catch(Exception e){
			e.printStackTrace();
		}
 
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}  

	public ActionForward excelExport (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)            
			throws Exception {
		        
			HttpSession session = request.getSession();
			
			String excelSource 		= form.getParam("excelSource");
			String filename 		= form.getParam("filename");

		    //System.out.println(">>>>>>excelSource : "+ excelSource);
				try {
		        	//excelSource = new String(excelSource.getBytes("iso-8859-1"), "UTF-8");
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		            logger.error("[excelExport]", e);
		        }
		        
		        request.setAttribute("excelSource", excelSource);
		        request.getParameter(filename);
	        
		        return mapping.findForward("excelExport");
	}
	
	public ActionForward excelExportLog (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)            
			throws Exception {
		        
			ECom005DAO dao		= null;
			String json 		= null;
			HttpSession session = request.getSession();
			try{
				SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
				String userId = sessionInfo.getUSER_ID();
				dao = new ECom005DAO();
				json = (String) dao.excelExportLog(form, userId);
			}catch(Exception e){
				System.out.println("######################## ACT e : " + e);
				e.printStackTrace();
			}
			ActionUtil.sendAjaxResponse(response, json);
			System.out.println(json);
			return mapping.findForward(form.getParam("goTo"));
	}
}
