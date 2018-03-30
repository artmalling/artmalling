/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.action;

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
import pcod.dao.PCod713DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>POS별 브랜드관리</p>
 * 
 * @created  on 1.0, 2016/11/02
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod713Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod713Action.class);

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
	 * 행사장마스터를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PCod713DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new PCod713DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			
			list = dao.searchMaster(form);
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
	 * POS별 브랜드그룹 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod713DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			list    = new List[1];
			dSet    = new GauceDataSet[1];
			dao     = new PCod713DAO();
			helper  = new GauceHelper2(request, response, form);
			
			dSet[0] = helper.getDataSet("DS_DETAIL1");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL1");
			
			list   = dao.searchDetail1(form);
			
			helper.setListToDataset(list[0], dSet[0]);

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
	 * POS별 브랜드 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod713DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			list    = new List[1];
			dSet    = new GauceDataSet[1];
			dao     = new PCod713DAO();
			helper  = new GauceHelper2(request, response, form);
			
			dSet[0] = helper.getDataSet("DS_DETAIL2");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL2");
			
			list   = dao.searchDetail2(form);
			
			helper.setListToDataset(list[0], dSet[0]);

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
	 * POS별 브랜드그룹, 브랜드 저장
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod713DAO dao      = null;
		int ret = 0;
		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId           = sessionInfo.getUSER_ID();

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];

			dSet[0] = helper.getDataSet("DS_DETAIL1");
			dSet[1] = helper.getDataSet("DS_DETAIL2");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL1");	
			helper.setDataSetHeader(dSet[1], "H_SEL_DETAIL2");	
			
			MultiInput mi[] = new MultiInput[2];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			
			dao = new PCod713DAO();			
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
}
