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
import mgif.dao.MGif604DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>자사위탁판매 정산</p>
 * 
 * @created  on 1.0, 2011/06/07
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MGif604Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

	/**
	 * <p>자사위탁판매 정산 화면</p>
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
	 * 자사 위탁판매 정산 내역 조회
	 * </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MGif604DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			dao = new MGif604DAO();
			dSet = new  GauceDataSet[2];
			list = new  List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_O_OUTREQCONF"); 
			helper.setDataSetHeader(dSet[0], "H_OUTREQCONF"); 
			dSet[1] = helper.getDataSet("DS_O_JOINCAL"); 
			helper.setDataSetHeader(dSet[1], "H_JOINCAL"); 
			list = dao.getList(form);
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
		GauceDataSet dSet = null;
		MGif604DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_OUTREQCONF");
			MultiInput mi = helper.getMutiInput(dSet);
			dao = new MGif604DAO();
			ret = dao.save(form, mi, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
}
