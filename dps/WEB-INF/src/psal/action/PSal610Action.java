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
import psal.dao.PSal610DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>무인정산자료 비교표</p>
 * 
 * @created  on 1.0, 2016/10/27
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal610Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal610Action.class);

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
	 * 무인정산자료 비교표 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal610DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PSal610DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			
			list = dao.searchMaster(form, userId);
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
	 * 무인정산자료 비교표 상세 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal610DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PSal610DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
			
			list = dao.searchDetail(form, userId);
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
	 * 무인정산자료 비교표 상세 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward chkProcess(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal610DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PSal610DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_I_CONDITION");
			helper.setDataSetHeader(dSet, "H_SEL_DATE");
			
			list = dao.chkProcess(form, userId);
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
	 * 무인정산자료 비교표 상세 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward runProcess(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal610DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입)   
		String ret          = "";
		try {
			System.out.println("try");
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_I_CONDITION");
                   
            helper.setDataSetHeader(dSet[0], "H_SEL_DATE");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal610DAO();    
			// 등록및수정, 삭제 분기
			System.out.println("go DAO");
			ret = dao.runProcess(form, mi1, userId, org_flag);
			System.out.println(ret);
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], ret);
		}
		return mapping.findForward("runProcess");
	}
	
	
	
	/** 
	 * <p>
	 * 무인정산자료 비교표 해당 일자 내역 유무를 조회.
	 * </p>
	 * 
	 */
	public ActionForward chkValexData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal610DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		//String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PSal610DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_SEL_CHKDATA");
			
			list = dao.chkValexData(form, userId);
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
	 * 정산기 내역 저장/수정
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal610DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL");
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			dao = new PSal610DAO();
			//System.out.println("1");
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
	
	
	/** 
	 * <p>
	 * 무인정산자료 타사 상품권 조회.
	 * </p>
	 * 
	 */
	public ActionForward searchOGift(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PSal610DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PSal610DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_TEMP");
			helper.setDataSetHeader(dSet, "H_SEL_OGIFT");
			
			list = dao.searchOGift(form, userId);
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
