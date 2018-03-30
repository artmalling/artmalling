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

import pord.dao.POrd508DAO;
import pord.dao.POrd509DAO;

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

public class POrd509Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd509Action.class);

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
		POrd509DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();
		org_flag 				= sessionInfo.getORG_FLAG();

		try {
			dao = new POrd509DAO(); 
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
	 * <p>
	 * 제경비 등록 수정 삭제 
	 * </p>
	 * 
	 * <p>
	 * 공통코드 삭제의 경우 데이터를 삭제하지 않고, 사용유무 Flag를 False 처리한다.
	 * </p>
	 * 
	 */
	public ActionForward conf(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd509DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳	
		String msg     = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_LIST");
			  
            helper.setDataSetHeader(dSet[0], "H_LIST");			  
			MultiInput mi1 = helper.getMutiInput(dSet[0]);			 
			dao = new POrd509DAO();  
		    ret = dao.conf(form, mi1, userId);
		    
		    System.out.println("strYNGbn = " + form.getParam("strYNGbn"));
			if(form.getParam("strYNGbn").equals("Y")){
			    msg = "건 마감 되었습니다.";
			    
			}else{
			    msg = "건 마감취소 되었습니다.";			
			}
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0],ret + msg); 
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>수입제경비 등록/확정 마스터 조회  </p>
	 * 
	 */
	public ActionForward chkConfClose(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd509DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd509DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_CHK_CLOSE");
			helper.setDataSetHeader(dSet, "H_CHK_CLOSE");
			list = dao.chkConfClose(form);
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
