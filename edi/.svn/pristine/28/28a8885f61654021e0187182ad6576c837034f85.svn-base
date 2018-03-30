package ccom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ccom.dao.CCom222DAO;
 
import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class CCom222Action extends DispatchAction{
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom222Action.class);

	/**
	 * <p>품목 단축 코드  조회</p>
	 * 
	 */
	
	public ActionForward pbnPmkSrtPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom222DAO dao = null;
		
		
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
	 * <p>품목단축코드 </p>
	 *  품번에 대한 품목단축코드 조회
	 */ 
	public ActionForward getPmkSrt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom222DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom222DAO();
		
			sb = dao.getPmkSrt(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
   
	/**
	 * <p>공통 코드 </p>
	 *  단축코드 조회 1건 조회
	 */
	
	public ActionForward getPmkSrtBlur(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom222DAO dao = null; 
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom222DAO();
			
			sb = dao.getPmkSrtBlur(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	     
}
