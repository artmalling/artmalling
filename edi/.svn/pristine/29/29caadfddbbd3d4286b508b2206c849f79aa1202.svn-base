package epay.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.sun.corba.se.spi.orbutil.fsm.Action;

import ecom.vo.SessionInfo2;
import epay.dao.Epay101DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class Epay101Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Epay101Action.class);

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
        
		return mapping.findForward("list");
	}
	
	/**
	 * <p>상세보기 대금지불 팝업</p>
	 * 
	 */
	public ActionForward popPredef(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;				//선급내역
		List list2 = null;				//보류내역
		List list3 = null;				//공제내역
		Epay101DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			dao = new Epay101DAO();
			
			list = dao.getdetail1(form);			//선급내역
			list2 = dao.getdetail2(form);			//보류내역
			list3 = dao.getdetail3(form);			//공제내역
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
        request.setAttribute("list", list);		//선급내역
        request.setAttribute("list2", list2); 	//보류내역
        request.setAttribute("list3", list3);	//공제내역
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		Epay101DAO dao = null;
		StringBuffer sb = null;
		
		try{
			sb = new StringBuffer();
			
			dao = new Epay101DAO();
			
			sb = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
			
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
}
