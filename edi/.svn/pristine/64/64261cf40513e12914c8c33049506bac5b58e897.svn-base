package eord.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import ecom.vo.SessionInfo2;
import eord.dao.EOrd101DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

public class EOrd101Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EOrd101Action.class);

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
	 * <p>리스트 조회</p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getList(form);
			System.out.println(sb.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	/**
	 * <p>마스트 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}

		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>마스트 조회 </p>
	 * 
	 */
	public ActionForward getpumbunGbBun(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getpumbunGbBun(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>행사율 구분  조회 </p>
	 * 
	 */
	public ActionForward getMarginFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getMarginFlag(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>행사율 조회 </p>
	 * 
	 */
	public ActionForward getMarginRate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getMarginRate(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}

	/**
	 * <p>상세 조회 </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		//System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^"+sb.codePointAt(0));
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>상세 조회 </p>
	 * 
	 */
	public ActionForward detailDel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.detailDel(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>품목 코드  </p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getSkuInfo(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 택발행 마스터 조회</p>
	 * 
	 */
	public ActionForward slipno(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd101DAO dao = null;
		
		try{
			dao = new EOrd101DAO();
			
			Json = dao.slipno(form);
		
		}catch(Exception e){
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!"+e);
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 전표상태 조회</p>
	 * 
	 */
	public ActionForward slip_flag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;

		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.slip_flag(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	} 
 
	/**
	 * <p>등록  </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;
		String userid = "";
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			HttpSession session = request.getSession();
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			userid   = sessionInfo.getUSER_ID();
			
			sb = dao.save(form, userid);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>등록  </p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;
		String userid = "";
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.delete(form);
			
		}catch(Exception e){
			e.printStackTrace();
		} 
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>등록  </p>
	 * 
	 */
	public ActionForward getVenRoundFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd101DAO dao = null;
		String userid = "";
		String strGoto = form.getParam("goTo");
		
		try{
			sb = new StringBuffer();
			dao = new EOrd101DAO();
			
			sb = dao.getVenRoundFlag(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	/**
	 * <p>마스트 조회 </p>
	 * 
	 */
	public ActionForward chkSlipProdStat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd101DAO dao = null;
		
		try{
			dao = new EOrd101DAO();
			
			Json = dao.chkSlipProdStat(form);
		
		}catch(Exception e){ 
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
  
}
