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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import ppay.dao.PPay306DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>실지불액 계산/확정/이월처리</p>
 * 
 * @created  on 1.0, 2010/05/17
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */ 

public class PPay306Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PPay306Action.class);

	/**
	 * <p>실지불액 계산/확정/이월처리 화면 </p>
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
	 * <p> 작업내역 리스트 조회 </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PPay306DAO dao 		= null;
		  
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PPay306DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list   = dao.getList(form, userId, org_flag); 
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
	 * <p> 실지불액 계산/확정/이월처리 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PPay306DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		String ret          = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_I_SEARCH");
                   
            helper.setDataSetHeader(dSet[0], "H_SEARCH");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PPay306DAO();    
			// 등록및수정, 삭제 분기
			if(form.getParam("strFlag").equals("save")){ 
				ret = dao.save(form, mi1, userId, org_flag);
			}  
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], ret);
		}
		return mapping.findForward("save");
	}
	
	/**
	 * <p> 실지불액 계산/확정/이월처리 Validation Check </p> 
	 * 
	 */
	public ActionForward valCheck(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PPay306DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		String res		    = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_I_SEARCH");
                   
            helper.setDataSetHeader(dSet[0], "H_SEARCH");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PPay306DAO();    
			res = dao.valCheck(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], res);
		}
		return mapping.findForward("valCheck");
	}
}
