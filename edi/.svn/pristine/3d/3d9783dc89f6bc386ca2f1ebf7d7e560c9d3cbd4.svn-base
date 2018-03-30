package ecmn.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecmn.dao.ECmn104DAO;
import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class ECmn104Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECmn104Action.class);

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
	 * <p>댓글 팝업메뉴를 보여준다.</p>
	 * 
	 */
	
	public ActionForward popReply(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Map map = new HashMap();
		ECmn104DAO dao = null;
		List reglist = null;
		
		String strGoto = form.getParam("goTo");
		
		try {
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
            
            String vencd = sessionInfo.getVEN_CD();		//협력사코드
            
            dao = new ECmn104DAO();
            
            map = dao.popReply(form);			//게시글 상세보기
            reglist = dao.regnmList(form, vencd);	    //댓글 등록 권한 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		request.setAttribute("Map", map);
		request.setAttribute("reglist", reglist);
		return mapping.findForward(strGoto);
	}
	/**
	 * <p>댓글 등록</p>
	 * 
	 */
	public ActionForward ins_reply(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = new StringBuffer();
		ECmn104DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
            String userid = sessionInfo.getUSER_ID();		//아이디
            String vencd = sessionInfo.getVEN_CD();		    //협력사코드
            
			dao = new ECmn104DAO();
			
			sb = dao.ins_reply(form, userid, vencd);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>리스트 조회</p>
	 * 
	 */
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		StringBuffer sb = null;
		ECmn104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new ECmn104DAO();
			
			sb = dao.getMaster(form);
			
			
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
		ECmn104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			dao = new ECmn104DAO();
			
			if( "board".equals(form.getParam("strFlag")) ){		//게시판
				sb = dao.getDtBoard(form);
			} else if( "reply".equals(form.getParam("strFlag")) ){	//댓글
				sb = dao.getDtReply(form);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	/**
	 * <p>댓글 수정</p>
	 * 
	 */
	public ActionForward updReply( ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = new StringBuffer();
		ECmn104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
            String userid = sessionInfo.getUSER_ID();
            
			dao = new ECmn104DAO();
			
			sb = dao.updReply(form, userid);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>댓글 삭제</p>
	 * 
	 */
	public ActionForward delReply( ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = new StringBuffer();
		ECmn104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
            
			dao = new ECmn104DAO();
			
			sb = dao.delReply(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
}
