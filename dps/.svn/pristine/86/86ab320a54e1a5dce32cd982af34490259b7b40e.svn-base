/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;



import pord.dao.POrd001DAO;


import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
/**
 * <p>  </p>                                                   
 * 
 * @created  on 1.0, 2010/02/16                              
 * @created  by 김경은 
 *  
 * @modified on    
 * @modified by                                      
 * @caused   by      
 */                           

public class POrd001Action extends DispatchAction {
	/*                                                        
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd001Action.class);

	                                               
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			HttpSession session     = request.getSession();
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
	
	
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				
		List list			= null;
		POrd001DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new POrd001DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list   = dao.searchMaster(form, userId, org_flag); 
			helper.setListToDataset(list, dSet);            

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
		
	}
	
	public ActionForward searchFile(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				
		List list			= null;
		POrd001DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new POrd001DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_IO_DTL_FILE");
			helper.setDataSetHeader(dSet, "H_FILE");
			list   = dao.searchFile(form, userId, org_flag); 
			helper.setListToDataset(list, dSet);            

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
		
	}
	
	
	public ActionForward saveFile(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd001DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId = sessionInfo.getUSER_ID();

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DTL_FILE");
			helper.setDataSetHeader(dSet, "H_FILE");			
			MultiInput mi = helper.getMutiInput(dSet);			
			dao = new POrd001DAO();			
			ret = dao.saveFile(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	
	public ActionForward deleteFile(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd001DAO dao = null;
		int ret = 0;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_IO_DTL_FILE");
			helper.setDataSetHeader(dSet, "H_FILE");
			MultiInput mi = new MultiInput(dSet);			
			dao = new POrd001DAO();			
			ret = dao.deleteFile(form, mi);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "삭제되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward filePop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("111111");
    	List list 			 = null;
    	GauceHelper2  helper = null;
		POrd001DAO dao 		 = null;
		GauceDataSet dSet 	 = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		System.out.println("2222");
		System.out.println("!!!!!"+strGoTo);
		
    	try {
    		System.out.println("333333");
			GauceHelper2.initialize(form, request, response); 
			System.out.println("444444");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(strGoTo, e);
            helper.writeException("GAUCE","002",e.getMessage());
            System.out.println("5555555");
        }
		return mapping.findForward(strGoTo);
	}
	
}
