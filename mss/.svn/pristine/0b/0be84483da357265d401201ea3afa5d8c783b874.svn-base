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

import meis.dao.MEis042DAO;

import com.gauce.GauceDataSet;

import common.util.Util;

/**
 * <p>경영계획 조회 및 확정</p>
 * 
 * @created on 1.0, 2011/06/03
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis042Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis042Action.class);

	/** 
	 * <p>경영계획 조회 및 확정 화면로딩</p>
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
	 * <p>점별 조회</p>
	 */
	public ActionForward searchStore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis042DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		String strUsrId     = null;
		
		try {
			dao      = new MEis042DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo");
			strUsrId = Util.getUserId(request);
			
			list     = dao.searchStore(form, strUsrId);
			helper.setDataSetHeader(dSet, "H_SEL_STORE");
			
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
	 * <p>항목별 조회</p>
	 */
	public ActionForward searchBizCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis042DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao      = new MEis042DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo");
			
			list     = dao.searchBizCd(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ_CD");
			
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
	
	/** 
	 * <p>조직별 조회</p>
	 */
	public ActionForward searchOrg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis042DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao      = new MEis042DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo");
			
			list     = dao.searchOrg(form);
			helper.setDataSetHeader(dSet, "H_SEL_ORG");
			
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
	
	/** 
	 * <p>월별 조회</p>
	 */
	public ActionForward searchMonth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis042DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao      = new MEis042DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo");
			
			list     = dao.searchMonth(form);
			helper.setDataSetHeader(dSet, "H_SEL_MONTH");
			
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
	
	/**
	 * <p>
	 * 확정 처리
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis042DAO dao      = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		String strUserId    = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis042DAO();
			strUserId = Util.getUserId(request);
			
			strGoTo   = form.getParam("goTo");
			dSet      = helper.getDataSet("DS_STORE");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.save(form, mi, strUserId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "경영계획보고서 확정 " + ret + "건 처리되었습니다");
		}
		return mapping.findForward("blank");
	}
}
