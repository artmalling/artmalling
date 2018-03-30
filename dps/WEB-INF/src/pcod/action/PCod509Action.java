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

import pcod.dao.PCod509DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2010.03.28
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod509Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod509Action.class);

	/**
	 * <p>페이지를 로드한다.</p>
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
	 * 단품스캔코드를 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod509DAO dao = null;
		String userId = null;
		String orgFlag = null;
		HttpSession session = request.getSession();

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			orgFlag = sessionInfo.getORG_FLAG();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_SKU_COND");
			dSet[1] = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet[1], "H_SEL_MASTER");
			dao = new PCod509DAO();
			MultiInput mi = new MultiInput(dSet[0]);			
			list = dao.searchMaster(form, mi, userId, orgFlag);
			helper.setListToDataset(list, dSet[1]);

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
	 * 단품스캔코드를 저장한다.
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod509DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");

			MultiInput mi = helper.getMutiInput(dSet);
			
			dao = new PCod509DAO();
			
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
