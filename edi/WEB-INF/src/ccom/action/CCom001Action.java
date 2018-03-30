package ccom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

import org.apache.log4j.Logger;

import ccom.dao.CCom001DAO;
import ecom.vo.SessionInfo2;

public class CCom001Action extends DispatchAction{
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom001Action.class);
	
	/**
	 * <p>점별품번 (콤보) 조회</p>
	 * 
	 */
	
	public ActionForward getPumbunCombo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getPumbunCombo(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>점별품번 (콤보) 조회(재고조회용)</p>
	 * 
	 */
	
	public ActionForward getPumbunSTK(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getPumbunSTK(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>품목  조회</p>
	 * 
	 */
	
	public ActionForward pbnPmkPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
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
	 * <p>품목단축코드  조회</p>
	 * 
	 */
	
	public ActionForward pbnPmkSrtPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
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
	 * <p>공통 코드 </p>
	 * 
	 */
	
	public ActionForward getEtcCode(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getEtcCode(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>공통 코드 </p>
	 *  DB 현재일 
	 */
	
	public ActionForward getTodayDB(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getTodayDB(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>공통 코드 </p>
	 *  DB 현재일시간분초 
	 */
	
	public ActionForward getTodayTimeDB(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getTodayTimeDB(form);
		    
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
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getPummokBlur(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>공통 코드 </p>
	 *  품목단축코드 조회 1건 조회
	 */
	
	public ActionForward getPmkSrtBlur(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getPmkSrtBlur(form);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}

	
	/**
	 * <p>공통 코드 </p>
	 *  일 마감체크를 한다.
	 */
	
	public ActionForward getCloseCheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
		
			sb = dao.getCloseCheck(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>공통 코드 </p>
	 *  일 마감체크를 한다.
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
	 * <p>품목 단축코드 </p>
	 *  
	 */
	
	public ActionForward getPmkSrt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
		
			sb = dao.getPmkSrt(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>협력사 거래형태 </p>
	 *  
	 */
	
	public ActionForward getBizType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
		
			sb = dao.getBizType(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>점코드 조회 </p>
	 *  
	 */
	
	public ActionForward getStrCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		String strGoto = form.getParam("goTo");
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
		
			sb = dao.getStrCd(form);
		
		}catch(Exception e){
			e.printStackTrace();
			logger.error("CCom001Action getStrCd error :", e);
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 협력사 반올림 구분  </p>
	 * 
	 */
	public ActionForward getVenRoundFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		CCom001DAO dao = null;
		String userid = "";
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			
			sb = dao.getVenRoundFlag(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
    /**
     * <p>
     * 전표상태를 조회 한다.
     * </p>
     */
    public ActionForward getSlipProcStat(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
    	StringBuffer sb = null;
		CCom001DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new CCom001DAO();
			sb = dao.getSlipProcStat(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
    }
	
}
