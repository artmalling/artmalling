package ejob.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import ejob.dao.EJob901DAO;

public class EJob901Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EJob901Action.class);
	
	/**
	 * 구인리스트 init
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoto = form.getParam("goTo");
		try{
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
           
            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());
            }
		}catch(Exception e){
			e.printStackTrace();
			logger.error("list", e);
		}
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 구인리스트 조회
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		EJob901DAO dao = new EJob901DAO();
		StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		//페이지에 보여줄 레코드 수
		int pageRecord = 10;
		try{
			// 페이징을 위하여 현재 페이지 번호와 리스트의 총 카운트를 구한다.
			// 총 카운트 구하기
			Map totalcountMap = dao.getSearchCount(form);
			String totalcount = totalcountMap.get("CNT").toString();
			
			// 리스트를 구한다.
			sb = dao.getSearch(form, totalcount, pageRecord);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getSearch", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 구인리스트 삭제
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		EJob901DAO dao = new EJob901DAO();
		StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		try{
			sb = dao.delList(form);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("delList", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 팝업 : 구인등록, 조회,수정팝업
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward openJobPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		EJob901DAO dao = new EJob901DAO();
		String strGoto = form.getParam("goTo");
		String mode = form.getParam("mode");
		Map infoMap = new HashMap();
		
		
		try {
			if (mode.equals("U")) {
				// 히트수 업데이트 
				dao.upHit(form);
				infoMap = dao.getDetail(form);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[openJobPop]", e);
		}
		
		if (mode.equals("U")) {
			request.setAttribute("infoMap",infoMap);
		}
		return mapping.findForward("openJobPop");
	}
	
	/**
	 * 구인등록 / 수정
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward saveDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		StringBuffer sb = null;
		EJob901DAO dao = null;
		String strGoto = form.getParam("goTo");
		
		try{
			dao = new EJob901DAO();
			
			sb = dao.saveDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward("saveDetail");
	}
	
	
	/**
	 * 구인상세보기 삭제
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		EJob901DAO dao = new EJob901DAO();
		StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		try{
			sb = dao.delDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("delDetail", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * 팝업 : 협력업체선택팝업 Open
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward openVendorPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[openVendorPop]", e);
		}
        
		return mapping.findForward("openVendorPop");
	}
	
	/**
	 * 팝업 : 협력업체선택팝업조회
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getSearchOpenVendor(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		EJob901DAO dao = new EJob901DAO();
		StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		try{
			sb = dao.getSearchOpenVendor(form);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getSearchOpenVendor", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
}
