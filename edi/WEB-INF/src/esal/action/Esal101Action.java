package esal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecmn.dao.ECmn101DAO;
import ecom.vo.SessionInfo2;
import esal.dao.Esal101DAO;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class Esal101Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal101Action.class);

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
	 * <p>마스터조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	    Esal101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new Esal101DAO();
			
			sb = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>디테일조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	    Esal101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new Esal101DAO();
			
			sb = dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getDetail : ", e);
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	
}
