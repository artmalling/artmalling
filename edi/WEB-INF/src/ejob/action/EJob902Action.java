package ejob.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;
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

import ecom.util.fileCommon;
import ecom.vo.SessionInfo2;
import ejob.dao.EJob902DAO;

public class EJob902Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EJob902Action.class);
	
	/**
	 * 구직리스트 init
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
	 * 구직리스트 조회
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
		
		EJob902DAO dao = new EJob902DAO();
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
			logger.error("list", e);
		}
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 팝업 : 구직 조회팝업
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
		
		EJob902DAO dao = new EJob902DAO();
		String strGoto = form.getParam("goTo");
		Map infoMap = new HashMap();
		List fList = null;
		fList = null;
		infoMap = null;
		try {
				// 히트수 업데이트 
				dao.upHit(form);
				infoMap = dao.getDetail(form);
				// 파일 List
				
				fList = dao.getDetailFile(form);
				
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[openJobPop]", e);
		}
		
		request.setAttribute("infoMap",infoMap);
		request.setAttribute("fList",fList);
		return mapping.findForward("openJobPop");
	}
	
	/**
	 * 구직출력
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward printPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		EJob902DAO dao = new EJob902DAO();
		String strGoto = form.getParam("goTo");
		Map infoMap = new HashMap();
		
		
		try {
				infoMap = dao.getDetail(form);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[printPop]", e);
		}
		
		request.setAttribute("infoMap",infoMap);
		return mapping.findForward("printPop");
	}
	
	/**
	 * 파일다운로드
	 * 
	 * @param 
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward ejobFileDown(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {

			String fileName = form.getParam("fileName");
			String filePath = form.getParam("filePath");
			File sourceFile = null;
			
			sourceFile = new File( filePath + File.separator +  fileName.toString());

			if (sourceFile.exists()){
				new fileCommon().downloadFile(sourceFile.toString(), fileName, request, response);
			} else{
				response.setContentType("text/html; charset=UTF-8");
				response.getOutputStream().println("<script language=javascript>");
				String msg = new String("  alert('다운받으시려는 파일이 존재하지 않습니다.'); history.back();") ;
				response.getOutputStream().write(msg.getBytes("UTF-8"));
				response.getOutputStream().println("</script>");
			}
		} catch(Exception e){
			e.printStackTrace();
		} 
		return mapping.findForward("ejobFileDown");
	
	}

	
}
