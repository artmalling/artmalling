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

import pord.dao.POrd101DAO;
import pord.dao.POrd123DAO;


import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>명동보리밥대출입전표생성</p>
 * 
 * @created  on 1.0, 2011/11/23
 * @created  by 강종엽
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class POrd123Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd123Action.class);

	/**
	 * <p>명동보리밥대출입전표생성화면 </p>
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
	 * <p> 명동보리밥대출입전표생성 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd123DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		//00 String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			//org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_I_SEARCH");
                   
            helper.setDataSetHeader(dSet[0], "H_SEARCH");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new POrd123DAO();    
			// 등록및수정, 삭제 분기
			 
			ret = dao.save(form, mi1, userId);
			
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			System.out.println(":::"+ret);
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], "처리되었습니다");
		}
		return mapping.findForward("save");
	}
	

	/**
	 * <p> 최종 매입월 구하기 </p> 
	 * 
	 */
	public ActionForward getLastMonth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)   
			throws Exception {
                 
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		POrd123DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();

		try {
			dao = new POrd123DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_LASTMONTH");
			helper.setDataSetHeader(dSet, "H_LASTMONTH");
			list = dao.getLastMonth(form);      //DAO call

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

