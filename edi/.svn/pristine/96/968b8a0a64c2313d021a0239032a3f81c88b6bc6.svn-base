package epro.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import epro.dao.EPro101DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class EPro101Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EPro101Action.class);

	/**
	 * <p>약속관리대장</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoTo = form.getParam("goTo");
		try {
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>마스터 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		try{
			dao = new EPro101DAO();
			sb = dao.getMaster(form);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getMaster error : ", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>상세조회 </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		EPro101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new EPro101DAO();
			
			sb = dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getMasterContent error : ", e);
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
		EPro101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String userId = "";
		String strGoto = form.getParam("goTo");
		try{
			dao = new EPro101DAO();
			HttpSession session = request.getSession();	
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			userId = sessionInfo.getUSER_ID();
			sb = dao.save(form, userId);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>약속관리 히스토리</p>
	 * 
	 */
	public ActionForward popup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoTo = form.getParam("goTo");
		try {
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}
	
	
	/**
	 * <p>약속대장 변경내용 조회 </p>
	 * 
	 */
	public ActionForward getPromise(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		EPro101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		try{
			dao = new EPro101DAO();
			sb = dao.getPromise(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>약속대장 변경 목록 조회 </p>
	 * 
	 */
	public ActionForward getHistory(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		EPro101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		try{
			dao = new EPro101DAO();
			sb = dao.getHistory(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>변경내용 저장 </p>
	 * 
	 */
	public ActionForward saveHistory(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		EPro101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String userId = "";
		String strGoto = form.getParam("goTo");
		try{
			dao = new EPro101DAO();
			HttpSession session = request.getSession();	
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			userId = sessionInfo.getUSER_ID();
			sb = dao.saveHistory(form, userId);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
}
