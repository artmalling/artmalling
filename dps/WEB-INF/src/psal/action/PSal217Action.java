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
import pcod.dao.PCod713DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import psal.dao.PSal217DAO;
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

public class PSal217Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal217Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
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

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal217DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
            dao     = new PSal217DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			
			list    = dao.searchMaster(form, userid);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 행사구분 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMgHs(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal217DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
            dao     = new PSal217DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = helper.getDataSet("DS_HS_MG");
			helper.setDataSetHeader(dSet, "H_SEL_HS_MG");
			
			list    = dao.searchMgHs(form, userid);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 엑셀 업로드 브랜드명, 품목명, 행사율, 행사구분  조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal217DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
            dao     = new PSal217DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = helper.getDataSet("DS_HS_EXCEL");
			helper.setDataSetHeader(dSet, "H_SEL_EXCEL");
			
			list    = dao.searchExcel(form, userid);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 매출수기등록 품목
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal217DAO dao      = null;
		int ret = 0;
		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId           = sessionInfo.getUSER_ID();

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[1];

			dSet[0] = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");	
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			
			dao = new PSal217DAO();
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 결제수단 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPayType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal217DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
            dao     = new PSal217DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = helper.getDataSet("DS_PAY_TYPE");
			helper.setDataSetHeader(dSet, "H_SEL_PAY_TYPE");
			
			list    = dao.searchPayType(form, userid);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
}
