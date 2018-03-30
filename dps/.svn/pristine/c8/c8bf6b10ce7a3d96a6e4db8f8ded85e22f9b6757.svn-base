/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import psal.dao.PSal707DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
                   
/**
 * <p> 월평가내역확조회(누계)</p>                                 
 *                                       
 * @created  on 1.0, 2011/07/11             
 * @created  by 김경은   
 *    
 * @modified on   
 * @modified by                                                     
 * @caused   by    
 */                                                                            
                         
public class PSal707Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal707Action.class);
                         
	/**
	 * <p>월평가내역조회(누계) 화면 </p>                      
	 *                
	 */                 
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo      = form.getParam("goTo"); // 분기할곳

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
                           
		return mapping.findForward(strGoTo);
	}
	                                   
	/**
	 * <p> 월평가내역조회 마스터(누계)  조회  </p> 
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
              
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PSal707DAO dao 		= null;
		                        
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try { 
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PSal707DAO();  
			helper = new GauceHelper2(request, response, form);    
			dSet   = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list   = dao.getMaster(form, userId, org_flag);                     
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
