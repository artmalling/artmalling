package ecmn.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.sun.corba.se.spi.orbutil.fsm.Action;

import ecmn.dao.ECmn102DAO;
import ecmn.dao.ECmn103DAO;
import ecom.vo.SessionInfo2;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

public class ECmn103Action extends DispatchAction  {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECmn103Action.class);

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
	 * <p>법률자문 리스트 조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = null;
		ECmn103DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			dao = new ECmn103DAO();
			
			Json = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>법률자문 등록 페이지 </p>
	 * 
	 */
	public ActionForward insertDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		
		try { 
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>법률자문 상세 페이지 </p>
	 * 
	 */
	public ActionForward listDtl(ActionMapping mapping, ActionForm form,
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
	 * <p>법률자문 등록, 수정 </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		StringBuffer sb = null;
		ECmn103DAO dao = null;
		int ret = 0;
		
		String strGoTo = String2.nvl(form.getParam("goTo"));
		
		try {
			sb = new StringBuffer();
			dao = new ECmn103DAO();
			
			
			if( "save".equals(form.getParam("strFlag")) ){						//수정
				sb = dao.save(form);
			}else if( "insert".equals(form.getParam("strFlag")) ){				//등록
				sb = dao.insert(form);
			}else {																//삭제
				sb = dao.delete(form);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>법률자문 상세 조회  </p>
	 * 
	 */
	
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoTo = form.getParam("goTo");
		StringBuffer sb = null;
		ECmn102DAO dao = null;
		
		try{
			
			sb = new StringBuffer();
			dao = new ECmn102DAO();
			
			sb = dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoTo);
	}
	
	
	
}
