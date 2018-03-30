package eord.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import eord.dao.EOrd102DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import ecom.util.Barcode;

public class EOrd102Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EOrd102Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
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
	 * <p>전표출력 조회</p>
	 * 
	 */
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd102DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			dao = new EOrd102DAO();
			
			sb = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		
		return mapping.findForward(strGoto); 
	}
	 
	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward print2(ActionMapping mapping, ActionForm form,
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
	 * <p>전표출력 조회</p>
	 * 
	 */
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		StringBuffer sb = null;
		System.out.println(form.getParam("SlipNo"));

		String strGoTo = form.getParam("goTo"); // 분기할곳 
		
		System.out.println(form.getParam("StrCd"));
		sb = new StringBuffer();
		sb.append(form.getParam("StrCd"));  
		sb.append(form.getParam("SlipNo"));
		sb.append(form.getParam("SlipFlag"));
		sb.append(form.getParam("SkuFlag"));
		sb.append(form.getParam("Loop"));
		sb.append(form.getParam("totCount")); 
		ActionUtil.sendAjaxResponse(response, sb);
//		GauceHelper2.initialize(form, request, response);
		System.out.println(form.getParam("SlipNo"));

	/*	System.out.println(form.getParam("SlipNo"));
		System.out.println(form.getParam("SlipFlag"));
		System.out.println(form.getParam("SkuFlag"));
		System.out.println(form.getParam("Loop"));*/ 
		return mapping.findForward(strGoTo);
	}
	
    /**
     * <p>전표출력 팝업</p>
     *
     */
    public ActionForward printPopup(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        List masterList = null;
        List detailList = null;
        EOrd102DAO dao = null;
        String strGoto = form.getParam("goTo");

        try {
            dao = new EOrd102DAO();

            masterList = dao.getPrintMaster(form);
            detailList = dao.getPrintDetail(form);

        } catch(Exception e) {
            e.printStackTrace();
            logger.error("", e);
        }

        request.setAttribute("masterList", masterList);
        request.setAttribute("detailList", detailList);

        return mapping.findForward(strGoto);
    }

    public ActionForward barcode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        String strGoto = form.getParam("goTo");
        String strData = form.getParam("Data");
        Barcode barcode = null;

        try {
            barcode = new Barcode();
            barcode.make(request, response, strData);
        } catch(Exception e) {
            e.printStackTrace();
            logger.error("", e);
        }

        return mapping.findForward(strGoto);
    }

}
