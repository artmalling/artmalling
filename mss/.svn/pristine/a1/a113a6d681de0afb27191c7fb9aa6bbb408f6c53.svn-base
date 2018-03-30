package medi.action;

import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import medi.dao.MEdi105DAO;


import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/22
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */


public class MEdi105Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEdi105Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */	
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
			//System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
           
            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());
            } 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}
	 
	/**
	 * <p>Q&A 관리 조회 </p>
	 * 
	 */	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MEdi105DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			dao = new MEdi105DAO();
			helper = new GauceHelper2(request, response, form);
			dSet =helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			list = dao.getMaster(form);
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
			helper.close(dSet);
		}		
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>Q&A  팝업 상세 조회</p>
	 * 
	 */	
	
	public ActionForward getPopupDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MEdi105DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_POPUPDETAIL");
			
			dao = new MEdi105DAO();
			
			list = dao.getPopupDetail(form);
			
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> Q&A  팝업 </p>
	 * 
	 */	
	
	public ActionForward listDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
						
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[listDtl]", e);
		}

		return mapping.findForward("listDtl");
	}
	
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MEdi105DAO dao = null;
		String userid = "";
		int ret = 0;
		System.out.println("bb");
		HttpSession session = request.getSession();
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		String strFlg = String2.nvl(form.getParam("strFlg")); 
		try{
		
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userid = sessionInfo.getUSER_ID();
            
            helper = new GauceHelper2(request, response, form);
            
            dSet = helper.getDataSet("DS_MASTER");
            helper.setDataSetHeader(dSet, "H_POPUPDETAIL");
            
            MultiInput mi = helper.getMutiInput(dSet);
            
            dao = new MEdi105DAO();
            
            
            	ret = dao.save(form, userid, mi);
            
			
		}catch(Exception e){
			logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
}
