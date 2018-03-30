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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import psal.dao.PSal443DAO;

/**
 * <p>영업관리 > 매출관리 > 매출실적 > 층별/상품별 매출현황</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal443Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal443Action.class);

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
	 * 마스터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal443DAO dao = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PSal443DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			// 층별 데이타 조회
			dSet[0] = helper.getDataSet("DS_FLOOR");
			helper.setDataSetHeader(dSet[0], "H_SEL_FLOOR");
			list = dao.searchFloor(form);
			helper.setListToDataset(list, dSet[0]);

			// 상품벌 데이타 조회
			dSet[1] = helper.getDataSet("DS_PTYPE");
			helper.setDataSetHeader(dSet[1], "H_SEL_P_TYPE");
			list = dao.searchPType(form);
			helper.setListToDataset(list, dSet[1]);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

}
