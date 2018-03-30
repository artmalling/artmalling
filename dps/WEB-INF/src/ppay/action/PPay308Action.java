/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.action;

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

import ppay.dao.PPay307DAO;
import ppay.dao.PPay308DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>대금지불내역 현황</p>              
 * 
 * @created  on 1.0, 2010/05/27              
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by         
 */
            
public class PPay308Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PPay308Action.class);

	/** 
	 * <p>대금지불내역 현황</p>
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
	 * <p> 대금지불내역 현황  </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list			= null;
		PPay308DAO dao 		= null;
		                       
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
	
			dao    = new PPay308DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list   = dao.getMaster(form);                  
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
	 * <p> 지불일자(콤보)  </p>
	 * 
	 */
	public ActionForward getPayDt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list			= null;
		PPay308DAO dao 		= null;
		                       
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
	
			dao    = new PPay308DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_PAY_DT");
			helper.setDataSetHeader(dSet, "H_PAY_DT");            
			list   = dao.getPayDt(form);                  
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
