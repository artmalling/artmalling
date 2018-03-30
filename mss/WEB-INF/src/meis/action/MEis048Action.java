/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package meis.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import meis.dao.MEis046DAO;
import meis.dao.MEis048DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

/**
 * <p>조직별손익계획상세 조회</p>
 * 
 * @created on 1.0, 2011/07/01
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis048Action extends DispatchAction {

	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis048Action.class);
	
	/** 
	 * <p>조직별손익계획상세 조회 화면로딩</p>
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
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
	 * <p>조직별손익계획상세 조회</p>
	 */
	public ActionForward searchProfitAndLossPlanDtl(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis048DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis048DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchProfitAndLossPlanDtl(form);
			helper.setDataSetHeader(dSet, "H_SEL_PROFIT_AND_LOSS_PLAN_DTL");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}	
	
}
