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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import meis.dao.MEis006DAO;

import com.gauce.GauceDataSet;

import common.util.Util;

/**
 * <p>경영실적 배부기준항목 관리</p>
 * 
 * @created on 1.0, 2011/08/08
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis006Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis006Action.class);

	/** 
	 * <p>경영실적 배부기준항목 관리 화면로딩</p>
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
	 * <p>배부기준항목 조회</p>
	 */
	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis006DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis006DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.search(form);
			helper.setDataSetHeader(dSet, "H_SEL_DIV");
			
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
	 * 배부기준항목 등록/수정
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis006DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis006DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = helper.getDataSet("DS_DIV_CD");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.save(form, mi, strUserId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward("blank");
	}
	
}
