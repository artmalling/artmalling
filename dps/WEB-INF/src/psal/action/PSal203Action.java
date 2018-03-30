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

import com.gauce.GauceDataSet;

import psal.dao.PSal203DAO;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/23
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal203Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal203Action.class);

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
	 * PC별 가중치정보 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal203DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userId  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
			userId = sessionInfo.getUSER_ID();

			dao = new PSal203DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchMaster(form, OrgFlag, userId);
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
	 * PC별 가중치정보 상세 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal203DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userId  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
			userId = sessionInfo.getUSER_ID();

			dao = new PSal203DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
			list = dao.searchDetail(form, OrgFlag, userId);
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
	 * 영업일정보 체크 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSchedule(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal203DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();

			dao = new PSal203DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_SCHEDULE");
			helper.setDataSetHeader(dSet, "H_SEL_SCHEDULE");
			list = dao.searchSchedule(form, OrgFlag);
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
	 * 영업일정보 체크 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchBfyyWeek(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal203DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();

			dao = new PSal203DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_WEEK");
			helper.setDataSetHeader(dSet, "H_SEL_BFYYWEEK");
			list = dao.searchBfyyWeek(form, OrgFlag);
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
	 * 당초품번별월매출계획 확정데이터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchConfFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal203DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();

			dao = new PSal203DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MCHKCONFFLAG");
			helper.setDataSetHeader(dSet, "H_CONF_FLAG_M");
			list = dao.searchConfFlag(form, OrgFlag);
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
	 * 실행품번별일매출계획 확정,확정취소
	 * </p>
	 * 
	 */
	public ActionForward saveconf(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal203DAO dao      = null;
		int ret             = 0;
		HttpSession session = request.getSession();
		String userId       = null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			dao = new PSal203DAO();
			
			ret = dao.saveconf(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 실행품번별일매출계획 수정
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal203DAO dao      = null;
		int ret             = 0;
		HttpSession session = request.getSession();
		String userId       = null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL");
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			dao = new PSal203DAO();
			
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	


}
