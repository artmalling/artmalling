/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

import gauce.lib.gauceDataSet;

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
import mgif.dao.MGif622DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>자사상품권 정산</p>
 * 
 * @created  on 1.0, 2011/05/26
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif622Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

	/**
	 * <p>자사상품권 정산 화면</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = form.getParam("goTo");
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
	 * <p>
	 * 회수 마스터 내역 조회
	 * </p>
	 * 
	 */
	public ActionForward getTotal(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MGif622DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			dao = new MGif622DAO();
			dSet = new  GauceDataSet[2];
			list = new  List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_TOTAL"); 
			helper.setDataSetHeader(dSet[0], "H_TOTAL"); 
			dSet[1] = helper.getDataSet("DS_O_SUB_TOTAL"); 
			helper.setDataSetHeader(dSet[1], "H_SUB_TOTAL"); 
			list = dao.getTotal(form);
			
			for(int i=0;i<list.length;i++){
				helper.setListToDataset(list[i], dSet[i]);
			}

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
	 * 자사 상품권 회수 상세내역 조회
	 * </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MGif622DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			dao = new MGif622DAO();
			dSet = new  GauceDataSet[4];
			list = new  List[4];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_DETAIL");
			dSet[1] = helper.getDataSet("DS_O_GIFTCAL");
			helper.setDataSetHeader(dSet[1], "H_GIFTCAL");
			dSet[2] = helper.getDataSet("DS_O_SAVEDATA_MST");
			helper.setDataSetHeader(dSet[2], "H_SAVEDATA_MST");
			dSet[3] = helper.getDataSet("DS_O_SAVEDATA_DTL");
			helper.setDataSetHeader(dSet[3], "H_SAVEDATA_DTL");
			
			list = dao.getDetail(form);
			for(int i=0;i<list.length;i++){
				helper.setListToDataset(list[i], dSet[i]);
			}
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
	 * 자사상품권 정산 저장
	 * </p>
	 * 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MGif622DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			dao = new MGif622DAO();
			dSet = new GauceDataSet[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_SAVEDATA_MST");
			helper.setDataSetHeader(dSet[0], "H_SAVEDATA_MST");
			dSet[1] = helper.getDataSet("DS_O_SAVEDATA_DTL");
			helper.setDataSetHeader(dSet[1], "H_SAVEDATA_DTL");
			MultiInput[] mi = new MultiInput[2];
			
			 mi[0] = helper.getMutiInput(dSet[0]);
			 mi[1] = helper.getMutiInput(dSet[1]);
			ret = dao.save(form, mi, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet[0], "처리되었습니다.");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 자사상품권 정산 확정
	 * </p>
	 * 
	 * 
	 */
	public ActionForward confirm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif622DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_GIFTCAL");
			helper.setDataSetHeader(dSet, "H_GIFTCAL");
			MultiInput mi = helper.getMutiInput(dSet);
			dao = new MGif622DAO();
			ret = dao.confirm(form, mi, userId);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
}
