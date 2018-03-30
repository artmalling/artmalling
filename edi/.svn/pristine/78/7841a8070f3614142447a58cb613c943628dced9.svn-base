package ccom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ccom.dao.CCom001DAO;
import ccom.dao.CCom010DAO;
 
import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class CCom010Action extends DispatchAction{
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom010Action.class);

	/**
	 * <p>품목  조회</p>
	 * 
	 */
	
	public ActionForward pbnPmkPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom010DAO dao = null;
		
		
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
	 * <p>품목코드 </p>
	 *  품번에 대한 품목코드 조회
	 */ 
	public ActionForward getPummok(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
		
			sb = dao.getPummok(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
   
	/**
	 * <p>공통 코드 </p>
	 *  품목 조회 1건 조회
	 */
	
	public ActionForward getPummokBlur(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom010DAO dao = null; 
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom010DAO();
			
			sb = dao.getPummokBlur(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	     
}
