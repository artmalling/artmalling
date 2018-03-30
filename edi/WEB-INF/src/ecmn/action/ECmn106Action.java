package ecmn.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import ecmn.dao.ECmn106DAO;

/**
 * <p>화원정보조회</p>
 * 
 * @created  on 1.0, 2011.09.29
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class ECmn106Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	//private Logger logger = Logger.getLogger(ECmn106Action.class);

	/**
	 * <p>화면로드</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
        
		return mapping.findForward(form.getParam("goTo"));
	}
	
	
    /**
     * <p> 조회 </p> 
     * 
     */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        ECmn106DAO dao		= null;
        String json 		= null;
		try{
			dao = new ECmn106DAO();
			json = (String) dao.getMaster(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }
	
	/**
     * <p> 조회 </p> 
     * 
     */
	public ActionForward getChkDup(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        ECmn106DAO dao		= null;
        String json 		= null;
		try{
			dao = new ECmn106DAO();
			json = (String) dao.getChkDup(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }
	
	/**
	 * <p> 조회 </p> 
	 * 
	 */
	
	
	
	/**
     * <p> 조회 </p> 
     * 
     */
	public ActionForward sendSMS(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        ECmn106DAO dao		= null;
        String json 		= null;
		try{
			dao = new ECmn106DAO();
			json = (String) dao.sendSMS(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }
	
	/**
	 * <p> 조회 </p> 
	 * 
	 */
	
	
	
	
	public ActionForward saveSSNO(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		ECmn106DAO dao		= null;
		String json 		= null;
		HttpSession session = request.getSession();
		try{
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			String userId = sessionInfo.getUSER_ID();
			dao = new ECmn106DAO();
			json = (String) dao.saveSSNO(form, userId);
		}catch(Exception e){
			System.out.println("######################## ACT e : " + e);
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
		System.out.println(json);
		return mapping.findForward(form.getParam("goTo"));
	}
}
