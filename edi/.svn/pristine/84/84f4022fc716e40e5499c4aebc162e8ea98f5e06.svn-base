package epro.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import ecom.vo.SessionInfo2;
import epro.dao.EPro103DAO;

/**
 * <p>SMS발송관리</p>
 * 
 * @created  on 1.0, 2011/06/27
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class EPro103Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	//private Logger logger = Logger.getLogger(EPro103Action.class);

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
     * <p> 마스터 조회 </p> 
     * 
     */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        EPro103DAO dao		= null;
        String json 		= null;
		try{
			dao = new EPro103DAO();
			json = (String) dao.getMaster(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }
   
    /**
     * <p> SMS리스트(디테일) 조회 </p> 
     * 
     */ 
    public ActionForward getDetail(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        EPro103DAO dao		= null;
        String json 		= null;
		try{
			dao = new EPro103DAO();
			json = (String) dao.getDetail(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }	
    
    /**
     * <p>저장</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        EPro103DAO dao		= null;
        String json 		= null;
		try{
			HttpSession session = request.getSession();	
			SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
			String userId = sessionInfo.getUSER_ID();
			dao = new EPro103DAO();
			json = (String) dao.save(form, userId);
			System.out.println(":::::::::::::::::::::::::::: " + json);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
        return mapping.findForward(form.getParam("goTo"));
    }
}
