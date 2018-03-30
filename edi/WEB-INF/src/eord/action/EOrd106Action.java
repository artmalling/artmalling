/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package eord.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import eord.dao.EOrd106DAO;

/**
 * <p> 규격단품 매입발주 등록 </p>                                                   
 * 
 * @created  on 1.0, 2011/02/16                              
 * @created  by 김경은 
 *  
 * @modified on    
 * @modified by                                      
 * @caused   by     
 */                           

public class EOrd106Action extends DispatchAction {
	/*                                                        
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EOrd106Action.class);

	/**            
	 * <p> 규격단품 매입발주 등록 화면 </p>                                          
	 * 
	 */                                                   
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoto = form.getParam("goTo");

		try {
  
			HttpSession session     = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");  
			 
            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());  
            } 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}  
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 규격단품 매입발주 리스트 조회 </p> 
	 * 
	 */ 
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		StringBuffer sb = null;
		EOrd106DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			sb = dao.getList(form, userid);

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 규격단품 매입발주 마스터 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		StringBuffer sb = null;
		EOrd106DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			sb = dao.getMaster(form, userid);

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 규격단품 매입발주 상세 조회 </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		StringBuffer sb = null;
		EOrd106DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			sb = dao.getDetail(form, userid);

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 품번 상세정보 조회 </p>
	 * 
	 */
	public ActionForward getPumbunInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		StringBuffer sb = null;
		EOrd106DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			sb = dao.getPumbunInfo(form, userid);

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 단품코드 상세정보 조회 </p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		StringBuffer sb = null;
		EOrd106DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			String userid   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			sb = dao.getSkuInfo(form, userid);

		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}

	/**
	 * <p>규격단품 매입발주 등록/수정  </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd106DAO dao = null;
		String userid = "";
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			userid   = sessionInfo.getUSER_ID();
			
			sb = dao.save(form, userid);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>규격단품 매입발주 삭제  </p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd106DAO dao = null;
		String userid = "";
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd106DAO();
			
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			userid   = sessionInfo.getUSER_ID();
			
			sb = dao.delete(form, userid);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
}
