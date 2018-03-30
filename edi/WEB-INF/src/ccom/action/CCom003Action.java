package ccom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ccom.dao.CCom003DAO;

import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

public class CCom003Action extends DispatchAction{
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom003Action.class);
	
	 /**
     * <p>
     * 도움말관리 팝업 호출
     * </p>
     */
	
	public ActionForward helpPop(ActionMapping mapping, ActionForm form,
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
     * <p>도움말 조회 Pop</p>
     *
     */

    public ActionForward getHelpMsg(ActionMapping mapping, ActionForm form,
      HttpServletRequest request, HttpServletResponse response)
      throws Exception 
    {
    	CCom003DAO dao = null;
		StringBuffer sb = new StringBuffer();
		String sb2 = new String();
		String strGoto = form.getParam("goTo");
		try{
			dao = new CCom003DAO();
			sb = dao.getHelpMsg(form);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getList error : ", e);
		}

		
		// System.out.println(sb);
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
    }

 
}
