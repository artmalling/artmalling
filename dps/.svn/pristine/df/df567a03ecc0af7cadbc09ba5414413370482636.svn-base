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

import pcod.dao.PCod610DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>단품가격예약등록</p>
 * 
 * @created  on 1.0, 2010/04/01
 * @created  by 이정식
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod610Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod610Action.class);

	/**
	 * <p>단품가격예약등록 화면로딩</p>
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
	 * 단품가격을 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod610DAO dao = null;
		String userId  = null;
		String orgFlag = null;
		HttpSession session = request.getSession();

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			orgFlag = sessionInfo.getORG_FLAG();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_SKU_COND");
			dSet[1] = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet[1], "H_SEL_MASTER");
			dao = new PCod610DAO();
			MultiInput mi = new MultiInput(dSet[0]);			
			list = dao.searchMaster(form, mi, userId, orgFlag);
			helper.setListToDataset(list, dSet[1]);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>단건의 점별단품가격정보조회</p>
	 */
	public ActionForward searchSkuPrcInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		PCod610DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			strGoTo = form.getParam("goTo"); //분기할곳
			dao     = new PCod610DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			list    = dao.searchSkuPrcInfo(form);
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/**
	 * <p>
	 * 단품가격을 저장
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		PCod610DAO dao      = null;
		MultiInput mi       = null;
		HttpSession session = null;
		SessionInfo sI      = null;
		String userId       = null;
		int ret             = 0;
		
		try {
			helper  = new GauceHelper2(request, response, form);
			dao     = new PCod610DAO();
			
			session = request.getSession();
			sI      = (SessionInfo) session.getAttribute("sessionInfo");
			userId  = sI.getUSER_ID();
			dSet    = helper.getDataSet("DS_MASTER");
			mi      = helper.getMutiInput(dSet);

			ret     = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			e.printStackTrace();
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward("blank");
	}
}
