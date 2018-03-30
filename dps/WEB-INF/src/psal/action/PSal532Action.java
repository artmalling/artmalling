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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import psal.dao.PSal527DAO;
import psal.dao.PSal532DAO;
import psal.dao.PSal533DAO;

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

public class PSal532Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal533Action.class);

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
	

	/** 
	 * <p>
	 * 마스터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal532DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal532DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "MAIN_MASTER");
			list = dao.searchMaster(form, OrgFlag, userid);
			helper.setListToDataset(list, dSet);
		
			
		} catch (Exception e) {
			//e.printStackTrace();
			
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/** 
	 * <p>
	 * 디테일 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDitail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal532DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal532DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchDitail(form, OrgFlag, userid);
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p> 공제등록 키값 중복체크 </p>
	 * 
	 */
	public ActionForward checkKeyVlaue(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	        
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PSal532DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
	
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PSal532DAO(); 
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "CHECK");
			
			list   = dao.checkKeyVlaue(form, userId, org_flag); 
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
	 * <p> 공제등록 키값 중복체크 </p>
	 * 
	 */
	public ActionForward checkKeyVlaue2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	        
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PSal532DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
	
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PSal532DAO(); 
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "CHECK");
			
			list   = dao.checkKeyVlaue2(form, userId, org_flag); 
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
	 * <p> 월별 대행업체 수수료 관리 수정 삭제 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal532DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
            helper.setDataSetHeader(dSet[1], "H_SEL_DETAIL");
            
			MultiInput mi1[] = new MultiInput[2];
			mi1[0] = helper.getMutiInput(dSet[0]);		
			mi1[1] = helper.getMutiInput(dSet[1]);	
			
			dao = new PSal532DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.save(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			helper.close(ret+"건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 마리오 수수료 조회
	 * </p>
	 * 
	 */
	public ActionForward searchCharge(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal532DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
         
			dao = new PSal532DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "SEARCHCHARGE");
			
			list = dao.searchCharge(form, OrgFlag, userid);
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 마리오 이익율 조회
	 * </p>
	 * 
	 */
	public ActionForward searchInterest(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal532DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
			dao = new PSal532DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT3");
			helper.setDataSetHeader(dSet, "MARIOPROFRATE2");
			list = dao.searchInterest(form, OrgFlag, userid);
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 마리오 이익율 조회
	 * </p>
	 * 
	 */
	public ActionForward searchMarioeek(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal532DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
			dao = new PSal532DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
			list = dao.searchMarioeek(form, OrgFlag, userid);
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 인터파크 이익율 조회
	 * </p>
	 * 
	 */
	public ActionForward interparkeek(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal532DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
			dao = new PSal532DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "MARIOPROFRATE");
			list = dao.searchMarioeek(form, OrgFlag, userid);
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward valCheck(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal532DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  
		int ret             = 0;
		String res		    = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_PROCESSOR");
                   
            helper.setDataSetHeader(dSet[0], "MAIN_MASTER");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal532DAO();    
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
