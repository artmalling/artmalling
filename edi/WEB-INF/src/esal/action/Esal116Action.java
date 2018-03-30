package esal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2; 
import esal.dao.Esal116DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class Esal116Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal116Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		
		try {
			
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
          
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
        
		return mapping.findForward(strGoto);
	}
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal116DAO dao = null;
		String json = null;
		
		try{
			dao = new Esal116DAO();
			json = (String) dao.getMaster(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	} 
	
	
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		Esal116DAO dao		= null;
		String json 		= null;
		HttpSession session = request.getSession();
		try{
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			String userId = sessionInfo.getUSER_ID();
			dao = new Esal116DAO();
			json = (String) dao.delete(form, userId);
		}catch(Exception e){
			System.out.println("######################## ACT e : " + e);
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
		System.out.println(json);
		return mapping.findForward(form.getParam("goTo"));
	}
	
	public ActionForward searchEmp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal116DAO dao = null;
		String json = null;
		
		try{
			dao = new Esal116DAO();
			json = (String) dao.searchEmp(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		Esal116DAO dao		= null;
		String json 		= null;
		HttpSession session = request.getSession();
		try{
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			String userId = sessionInfo.getUSER_ID();
			dao = new Esal116DAO();
			json = (String) dao.save(form, userId);
		}catch(Exception e){
			System.out.println("######################## ACT e : " + e);
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
		System.out.println(json);
		return mapping.findForward(form.getParam("goTo"));
	}
}
