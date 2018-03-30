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

import psal.dao.PSal505DAO;

import com.gauce.GauceDataSet;

/**
 * <p>상품권매출현황</p>
 * 
 * @created on 1.0, 2010/04/06
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal505Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal505Action.class);

	/** 
	 * <p>상품권매출현황 화면로딩</p>
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = null; 
		try {
			strGoTo = form.getParam("goTo"); // 분기할곳
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}

		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>상품권매출 현황조회</p>
	 */
	public ActionForward searchVouSalList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		PSal505DAO dao      = null;
		List list           = null;
		String strGoTo      = null;

		strGoTo = form.getParam("goTo");
		
		try {
			dao     = new PSal505DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			
			//현황 리스트 데이터 가져오기
            dSet   = helper.getDataSet("DS_VOU_SAL");
			helper.setDataSetHeader(dSet, "H_SEL_VOU_SAL_LIST");

			list    = dao.searchVouSalList(form);
			helper.setListToDataset(list, dSet);
			
			
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
}