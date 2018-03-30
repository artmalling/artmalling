/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;



import com.gauce.GauceDataSet;

import dctm.dao.DCtm426DAO;

import common.vo.SessionInfo;
/**
 * <p>회원가입현황조회(브랜드)</p>
 * 
 * @created  on 1.0, 2012.05.23
 * @created  by 강진(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2012.05.23
 * @modified by 
 * @caused   by 회원가입현황조회(브랜드)
 */

public class DCtm426Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm426Action.class);

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
		DCtm426DAO dao 		= null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		String strDSName      = form.getParam("strDSName"); 
		String strHeadName      = form.getParam("strHeadName"); 

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new DCtm426DAO();  
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet(strDSName);
			helper.setDataSetHeader(dSet, strHeadName);                    
			list   = dao.getMaster(form, userId, org_flag); 
			
			helper.setListToDataset(list, dSet);            

		} catch (Exception e) {
			logger.error("", e);                       
			System.out.println(e.getMessage());
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}        
		return mapping.findForward(strGoTo);
	}
}
