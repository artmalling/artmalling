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

import pord.dao.POrd201DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

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

public class POrd201Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd201Action.class);

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
		POrd201DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();
		org_flag 				= sessionInfo.getORG_FLAG();

		try {
			dao = new POrd201DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list = dao.getList(form, userId, org_flag); 

			System.out.println("::::::::org_flag = " +org_flag);
			System.out.println("::::::::::::::::::::: "+ list.size());
			
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
	 * <p>품목 매입발주 매입/반품  디테일 내용을 조회한다.</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.getMaster(form);
			//System.out.println("list size : "+ list.size());
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
	 *  <p>품목 매입발주 매입/반품  디테일 내용을 조회한다.</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getDetail(form);
//			System.out.println("list size : "+ list.size());
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
	 * 품목매입발주 SM 확정처리
	 * </p>
	 * 
	 * <p>
	 * 판매조직이고 SM인 경우 확정/확정취소가 가능 함
	 * </p>
	 * 
	 */
	public ActionForward conf(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {


		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		 
		POrd201DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		// 임시
		String org_flag = null;  // 조직구분 (1:판매, 2:매입)

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();
			
			helper = new GauceHelper2(request, response, form);
			
			dao = new POrd201DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.conf(form, userId, org_flag );
			
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(); 
		}
		return mapping.findForward("conf");
	}
	
	/**
	 * <p>행사구분 조회.</p>
	 * 
	 */
	public ActionForward getMarginFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_EVENT_FLAG");
//			System.out.println("getMarginFlag 타나");
			helper.setDataSetHeader(dSet, "H_MARGIN_FLAG");
			list = dao.getMarginFlag(form);
			//System.out.println("list size : "+ list.size());
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
	 * <p>행사율 조회.</p>
	 * 
	 */
	public ActionForward getMarginRate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_EVENT_RATE");
			helper.setDataSetHeader(dSet, "H_MARGIN_RATE");
			list = dao.getMarginRate(form);
			//System.out.println("list size : "+ list.size());
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
	 * <p>행사율 조회.</p>
	 * 
	 */
	public ActionForward getPummokInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_PUMMOK_INFO");
			helper.setDataSetHeader(dSet, "H_PUMMOK_INFO");
			list = dao.getPummokInfo(form);
			//System.out.println("list size : "+ list.size());
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
	 * <p>승인,반려,취소시 현재전표상태값 체크</p>
	 * 
	 */
	public ActionForward chkStrProStat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_CHK_STRPROCSTAT");
			helper.setDataSetHeader(dSet, "H_CHK_STRPROCSTAT");
			list = dao.chkStrProStat(form);
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
