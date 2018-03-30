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

import meis.dao.MEis026DAO;

import com.gauce.GauceDataSet;

import common.util.Util;

/**
 * <p>계정별비용계획관리</p>
 * 
 * @created on 1.0, 2011/05/23
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis026Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis026Action.class);

	/** 
	 * <p>계정별비용계획관리 화면로딩</p>
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
	 * <p>계정별비용계획관리 엑셀 업로드 팝업화면 로딩</p>
	 */
	public ActionForward popup(ActionMapping mapping, ActionForm form,
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
	 * <p>계정별 비용계획조회</p>
	 */
	public ActionForward searchAcc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis026DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis026DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchAcc(form);
			helper.setDataSetHeader(dSet, "H_SEL_ACC");
			
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
	 * <p>조직별 비용계획조회</p>
	 */
	public ActionForward searchOrg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis026DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis026DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchOrg(form);
			helper.setDataSetHeader(dSet, "H_SEL_ORG");
			
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
	 * <p>월별 비용계획조회</p>
	 */
	public ActionForward searchMonth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis026DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis026DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchMonth(form);
			helper.setDataSetHeader(dSet, "H_SEL_MONTH");
			
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
	 * <p>조직기타정보와 월별 정보 셋팅</p>
	 */
	public ActionForward searchOrgMon(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet[] = null;
		GauceHelper2 helper = null;
		MEis026DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis026DAO();
			dSet    = new GauceDataSet[2];
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			dSet[0] = helper.getDataSet("DS_MONTH");
			dSet[1] = helper.getDataSet("DS_ETC");
			helper.setDataSetHeader(dSet[0], "H_SEL_MONTH");
            helper.setDataSetHeader(dSet[1], "H_SEL_ORG");
			
			list    = dao.searchMonth(form);
			helper.setListToDataset(list, dSet[0]);
			
			list    = dao.searchEtc(form);
			helper.setListToDataset(list, dSet[1]);
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
	 * 년월별 비용계획 등록/수정
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MEis026DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi[]     = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis026DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = new GauceDataSet[2];
			dSet[0]   = helper.getDataSet("DS_ORG");
			dSet[1]   = helper.getDataSet("DS_MONTH");
			mi        = new MultiInput[2];
			mi[0]     = helper.getMutiInput(dSet[0]);
			mi[1]     = helper.getMutiInput(dSet[1]);
			
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
	
	/**
	 * <p>
	 * 계정별 비용삭제
	 * </p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis026DAO dao      = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis026DAO();
			
			strGoTo   = form.getParam("goTo");
			dSet      = helper.getDataSet("DS_ACC");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.delete(form, mi);
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
	
	/**
	 * <p>
	 * 확정(확정취소)처리
	 * </p>
	 * 
	 */
	public ActionForward confirm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis026DAO dao      = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		String strUserId    = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis026DAO();
			strUserId = Util.getUserId(request);
			
			strGoTo   = form.getParam("goTo");
			dSet      = helper.getDataSet("DS_ACC");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.confirm(form, mi, strUserId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "계정항목 " + ret + "건 확정(확정취소)처리되었습니다");
		}
		return mapping.findForward("blank");
	}
	
	/**
	 * <p>
	 * 엑셀업로드 데이터의 벨리데이션 체크
	 * </p>
	 * 
	 */
	public ActionForward checkValidation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		List list           = null;
		MEis026DAO dao      = null;
		String strGoTo      = null;
		int ret             = 0;
		
		try {
			dao       = new MEis026DAO();
			dSet      = new GauceDataSet[2];
			helper    = new GauceHelper2(request, response, form);
			strGoTo   = form.getParam("goTo");
			dSet[0]   = helper.getDataSet("DS_ACC_PLAN");
			dSet[1]   = helper.getDataSet("DS_EXCEL");
			list      = dao.checkValidation(form, dSet[1]);
			
			helper.setDataSetHeader(dSet[0], "H_BIZ_UPLOAD");
			helper.setListToDataset(list, dSet[0]);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet[0]);
		}
		return mapping.findForward("blank");
	}
	
	/**
	 * <p>
	 * 엑셀업로드항목 저장
	 * </p>
	 * 
	 */
	public ActionForward uploadExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis026DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis026DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = helper.getDataSet("DS_ACC_PLAN");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.uploadExcel(form, mi, strUserId);
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
