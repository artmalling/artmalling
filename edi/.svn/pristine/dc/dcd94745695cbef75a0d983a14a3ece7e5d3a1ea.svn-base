package ecmn.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecmn.dao.ECmn101DAO;
import ecom.vo.SessionInfo2;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class ECmn101Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECmn101Action.class);

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
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ECmn101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new ECmn101DAO();
			
			sb = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}

		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/*
	 * 공지사항 메인조회
	 */
	public ActionForward getMasterMain(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ECmn101DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new ECmn101DAO();
			
			sb = dao.getMasterMain(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}

		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>상세조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		StringBuffer sb = new StringBuffer();
		ECmn101DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			
			dao = new ECmn101DAO();
			
			sb = dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
}
