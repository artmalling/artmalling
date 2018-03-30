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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import pord.dao.POrd120DAO;

/**
 * <p></p>
 *  
 * @created  on 1.0, 2010/01/25
 * @created  by 박래형(FUJITSU KOREA LTD.)    
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd120Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd120Action.class);

	/**
	 * <p>품목 매입발주 매입/반품  마스터 내용 조회</p>
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
	 * <p>전표출력</p>
	 * 
	 */
	
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳
		GauceHelper2.initialize(form, request, response);
/*
		System.out.println(form.getParam("SlipNo"));
		System.out.println(form.getParam("SlipFlag"));
		System.out.println(form.getParam("SkuFlag"));
		System.out.println(form.getParam("Loop"));
*/		
		return mapping.findForward(strGoTo);
	}
	
	
	                    
	/**
	 * <p> 규격단품 매입발주 리스트 조회 </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		POrd120DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();
		org_flag 				= sessionInfo.getORG_FLAG();

		try {
			dao = new POrd120DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list = dao.getList(form, userId, org_flag); 
			
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
	 * <p> 전표 출력 LIST </p>
	 * 
	 */
	public ActionForward getPrintList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		GauceHelper2 helper     = null;
		GauceDataSet dSet1      = null;
		List list 			    = null;
		POrd120DAO dao 	    	= null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		
		try {
			dao = new POrd120DAO(); 
			helper = new GauceHelper2(request, response, form);
			
			
			/* 단일 출력 */
			dSet1 = helper.getDataSet("DS_PRINT");
			helper.setDataSetHeader(dSet1, "H_PRINT");
			list = dao.getPrintList(form);	
			helper.setListToDataset(list, dSet1);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet1);
		}
		return mapping.findForward(strGoTo);
		
	}	
	
	/**
	 * <p>
	 * 물품 입고/반품 저장/수정/삭제
	 * </p>
	 * 
	 * <p>
	 * 공통코드 삭제의 경우 데이터를 삭제하지 않고, 사용유무 Flag를 False 처리한다.
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {


		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		 
		POrd120DAO dao = null;
		int ret = 0;

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_CHECKMASTER");
			helper.setDataSetHeader(dSet, "H_LIST");
			MultiInput mi = helper.getMutiInput(dSet);	
			dao = new POrd120DAO();    
			System.out.println(" 데이터 업데이트 액션");
			ret = dao.save(form, mi);

		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
//			helper.close(dSet, ret + "건 처리되었습니다"); 
//			helper.close(dSet,"저장되었습니다."); 
			helper.close();
		}
		return mapping.findForward("save");
	}
}
