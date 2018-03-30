package epro.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import epro.dao.EPro105DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class EPro105Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EPro105Action.class);

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
	 * <p>약속분석 현황 팝업 </p>
	 * 선택한 일자의 약속건수 상세보기 리스트 
	 */
	public ActionForward listDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		EPro105DAO dao = null;
		List list = null;
		try {
			dao = new EPro105DAO();
			
			list = dao.listDtl(form);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
        request.setAttribute("PROMISSLISTPOPUP", list);
		return mapping.findForward("listDtl");
	}
	
	/**
	 * <p>약속분석 현황 팝업 </p>
	 * 선택한 일자의 약속건수 상세보기 
	 */
	public ActionForward getPromissDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String json = null;
		EPro105DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			
			dao = new EPro105DAO();
			
			json = (String)dao.getPromissDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto); 
	}
	
	
	/**
	 * <p>약속분석 건수 현황 건수 조회</p>
	 * 
	 */
	public ActionForward getDayPromiss(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		StringBuffer sb = null;
		EPro105DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			
			dao = new EPro105DAO();
			
			sb = dao.getDayPromiss(form);
			
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto); 
	}
	
	
	
}
