package ccom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
  
import ccom.dao.CCom016DAO;
 
import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

/**
 * <p>협력사 팝업</p>
 * 
 * @created  on 1.0, 2011/02/17	
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom016Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom016Action.class);

	/**
	 * <p>협력사  조회</p>
	 * 
	 */
	
	public ActionForward VenPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom016DAO dao = null;
		 
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
	 * <p>협력사코드 </p>
	 *  점에대한 협력사 코드 조회
	 */ 
	public ActionForward getVenPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom016DAO dao = null;
		
		
		String strGoto = form.getParam("goTo"); 
		try{
			sb = new StringBuffer();
			dao = new CCom016DAO();
 
			sb = dao.getVenPop(form);
		
		}catch(Exception e){
 
			e.printStackTrace();
		} 
		
		ActionUtil.sendAjaxResponse(response, sb);
		System.out.println("strGotostrGotostrGotostrGotostrGotostrGoto : " +strGoto);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>협력사코드조회 </p>
	 *  협력사 조회 1건 조회
	 */
	
	public ActionForward getVenBlur(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom016DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom016DAO();
			
			sb = dao.getVenBlur(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
}
