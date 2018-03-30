package esal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import esal.dao.Esal111DAO;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class Esal111Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal111Action.class);

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
		
		
	    Esal111DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		String json = null;
		try{
			dao = new Esal111DAO();
			json = (String)dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>디테일조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	    Esal111DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		String json = null;
		try{

			dao = new Esal111DAO();
			
			json = (String)dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getDetail : ", e);
		}
		
		
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	
	
}