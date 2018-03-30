/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import mgif.dao.MGif311DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif311Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif311Action.class);

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
	 * <p>자사상품권 회수 비교표 마스터 조회 </p>
	 * 
	 */
	public ActionForward getGiftDrawlMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession session = request.getSession();
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif311DAO dao = null;
		String userId = null;
		String orgFlag = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        
		try {
			SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			orgFlag = sessionInfo.getORG_FLAG();
			dao = new MGif311DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.getGiftDrawlMst(form,userId, orgFlag);
			helper.setListToDataset(list, dSet);
			

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>자사상품권 회수 비교표 디테일 조회 </p>
	 * 
	 */
	public ActionForward getGiftDrawlDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif311DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif311DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getGiftDrawlDtl(form);
			helper.setListToDataset(list, dSet);
			

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>팝업호출.</p>
	 * 
	 */
	public ActionForward pop(ActionMapping mapping, ActionForm form,
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

		return mapping.findForward("pop");
	}

	 /**
	 * <p>자사상품권 회수 비교표 팝업 조회 </p>
	 * 
	 */
	 @SuppressWarnings("rawtypes")
    public ActionForward getGiftDrawlPop(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	List list			= null;
    	GauceHelper2 helper	= null;
    	GauceDataSet dSet	= null;
    	MGif311DAO dao		= null;
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

    		helper = new GauceHelper2(request, response, form);
    		dSet = new GauceDataSet();
    		dSet = helper.getDataSet("DS_O_MASTER_POP");			
    		helper.setDataSetHeader(dSet, "H_POPUP");
    		
    		dao = new MGif311DAO(); 
    		list = dao.getGiftDrawlPop(form); 
    		helper.setListToDataset(list, dSet);
    		
    	} catch (Exception e) {
    		logger.error("", e);
    		helper.writeException("GAUCE", "002", e.getMessage());
    	} finally {
    		helper.close(dSet);
    	}
    	return mapping.findForward(strGoTo); 
    }
}
