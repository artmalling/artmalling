package epro.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import epro.dao.EPro104DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class EPro104Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EPro104Action.class);

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
	 * <p>조회</p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro104DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String sb2 = new String();
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new EPro104DAO();
			
			sb = dao.getList(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>마스터 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro104DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new EPro104DAO();
			
			sb = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>마스터 입력부조회 </p>
	 * 
	 */
	public ActionForward getMasterContent(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro104DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new EPro104DAO();
			
			sb = dao.getMasterContent(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>삭제 </p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro104DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new EPro104DAO();
			
			sb = dao.delete(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>저장 </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro104DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String userId = "";
		
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new EPro104DAO();
			
			HttpSession session = request.getSession();	
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			userId = sessionInfo.getUSER_ID();
			
			if( "insert".equals(form.getParam("gbFlag")) ){
				
				sb = dao.insert(form, userId);
			} else {
				
				sb = dao.Modify(form, userId);
			}
			
			
			
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
}
