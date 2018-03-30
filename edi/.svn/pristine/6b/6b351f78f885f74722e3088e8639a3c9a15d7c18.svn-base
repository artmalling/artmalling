package eord.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import ecom.vo.SessionInfo2;
import eord.dao.EOrd103DAO; 
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class EOrd103Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EOrd103Action.class);

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
	/**
	 * <p> 택발행 마스터 조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd103DAO dao = null;
		
		try{
			dao = new EOrd103DAO();
			
			Json = dao.getMaster(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 택발행 디테일  조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd103DAO dao = null;
		
		try{
			dao = new EOrd103DAO();
			
			Json = dao.getDetail(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p> 택발행 이후 마스터 정보 수정한다. </p>
	 * 
	 */
	public ActionForward updTagFlagData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd103DAO dao = null;
		String userId = "";
		
		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();			
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			userId   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			
			dao = new EOrd103DAO();
			
			sb = dao.updTagFlagData(form, userId);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 택발행 디테일  조회</p>
	 * 
	 */
	public ActionForward getPrint(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
 
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd103DAO dao = null;

		try{ 
			dao = new EOrd103DAO();
 
			Json = dao.getPrint(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 현재달의 주 </p>
	 * 
	 */
	public ActionForward getMonthWeek(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@");
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd103DAO dao = null;
		
		try{
			dao = new EOrd103DAO();
			
			Json = dao.getMonthWeek(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	} 
}
