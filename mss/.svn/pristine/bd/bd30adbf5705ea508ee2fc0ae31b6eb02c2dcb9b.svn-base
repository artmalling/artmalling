/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.action;

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

import mpro.dao.MPro107DAO;
import common.vo.SessionInfo;

/**
 * <p>약속 대장 관리</p>
 * 
 * @created  on 1.0, 2011/02/09
 * @created  by 김성미
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro107Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MPro107Action.class);

	/**
	 * <p>약속 대장 관리 화면</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}
	
	
	/**
	 * <p>약속 목록 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MPro107DAO dao = null;
		String strOrgFlag = "";
		String strUserId = "";
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            strOrgFlag = sessionInfo.getORG_FLAG();
            strUserId = sessionInfo.getUSER_ID();
            dao = new MPro107DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.getMaster(form, strUserId, strOrgFlag);
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
	 * <p>약속 내용 저장 </p>
	 * 
	 */
	public ActionForward savePromise(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MPro107DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			MultiInput mi = helper.getMutiInput(dSet);
			dao = new MPro107DAO();
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
	 * <p>약속 변경 팝업 open</p>
	 * 
	 */
	public ActionForward openHisPop(ActionMapping mapping, ActionForm form,
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
			logger.error("[openHisPop]", e);
		}

		return mapping.findForward("openHisPop");
	}
	
	/**
	 * <p>약속 변경 팝업 - 이전 약속내용 조회</p>
	 * 
	 */
	public ActionForward getHistory(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
			List list = null;
			List list1 = null;
			GauceHelper2 helper = null;
			GauceDataSet dSet[] = null;
			MPro107DAO dao = null;
	
			String strGoTo = form.getParam("goTo"); // 분기할곳
	
			try {
	
				dao = new MPro107DAO();
				dSet = new GauceDataSet[2];
				helper = new GauceHelper2(request, response, form);
				dSet[0] = helper.getDataSet("DS_O_HISTORY");
				helper.setDataSetHeader(dSet[0], "H_HISTORY");
				dSet[1] = helper.getDataSet("DS_O_MASTER");
				helper.setDataSetHeader(dSet[1], "H_HIS_MASTER");
				list = dao.getHistory(form);
				list1 = dao.getHistoryList(form);
				
				helper.setListToDataset(list, dSet[0]);
				helper.setListToDataset(list1, dSet[1]);
	
			} catch (Exception e) {
				logger.error("", e);
				helper.writeException("GAUCE", "002", e.getMessage());
			} finally {
				helper.close(dSet);
			}
			return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>약속변경  내용 저장 </p>
	 * 
	 */
	public ActionForward saveHistory(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet[] dSet = null;
		MPro107DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_CHANGE");
            dSet[1] = helper.getDataSet("DS_O_HISTORY");
			MultiInput miCng = helper.getMutiInput(dSet[0]);
			MultiInput miHis = helper.getMutiInput(dSet[1]);
			dao = new MPro107DAO();
			ret = dao.saveHistory(form, miCng, miHis,userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close("처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}

}
