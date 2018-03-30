package ccom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ccom.dao.CCom002DAO;

import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

public class CCom002Action extends DispatchAction{
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom002Action.class);
	
	 /**
     * <p>
     * 우편번호 팝업 호출
     * </p>
     */
	
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String goTo = form.getParam("goTo");
		try {
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(goTo);
	}

    /**
     * <p>분류 조회 Pop</p>
     *
     * <p>분류 조회 Pop</p>
     */

    public ActionForward getOldAddr(ActionMapping mapping, ActionForm form,
      HttpServletRequest request, HttpServletResponse response)
      throws Exception 
    {
    	CCom002DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String sb2 = new String();
		String strGoto = form.getParam("goTo");
		try{
			dao = new CCom002DAO();
			sb = dao.getOldAddr(form);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getList error : ", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
    }


	public ActionForward getNewAddr(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		CCom002DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String sb2 = new String();
		String strGoto = form.getParam("goTo");
		try{
			dao = new CCom002DAO();
			sb = dao.getOldAddr(form);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getList error : ", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
     * <p> 시도,시군구 콤보 조회 </p>
     */
    public ActionForward getEtcCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	CCom002DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String sb2 = new String();
		String strGoto = form.getParam("goTo");
		try{
			dao = new CCom002DAO();
			sb = dao.getOldAddr(form);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getList error : ", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
    }
	
	
}
