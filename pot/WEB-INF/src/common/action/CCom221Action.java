/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;
import common.dao.CCom221DAO;

import com.gauce.GauceDataSet;

/**
 * <p>
 * 경영지원 - 경영실적조회 - 경영실적항목 분류조회
 * </p>
 * 
 * @created on 1.0, 2010/05/03
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom221Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom911Action.class);
	
	/** 
	 * <p>항목코드팝업 화면로딩</p>
	 */
	public ActionForward callPopup(ActionMapping mapping, ActionForm form,
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
	 * <p>계정/예산항목코드팝업 화면로딩</p>
	 */
	public ActionForward callPopup2(ActionMapping mapping, ActionForm form,
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
	 * <p>항목코드팝업 화면로딩-월별경영계획항목명세</p>
	 */
	public ActionForward callPopup3(ActionMapping mapping, ActionForm form,
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
	 * <p>경영실적항목코드 분류콤보조회</p>
	 */
	public ActionForward getBizCdCombo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao      = new CCom221DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo"); //분기할곳
			
			//경영실적항목코드 분류콤보조회
			list     = dao.getBizCdCombo(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ_CODE_LVL");
			
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
	 * <p>실적항목리스트조회</p>
	 */
	public ActionForward getBizList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new CCom221DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getBizList(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ_LIST");
			
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
	 * <p>실적항목리스트조회-월별경영계획항목명세테이블</p>
	 */
	public ActionForward getBizPlanList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new CCom221DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getBizPlanList(form);
			helper.setDataSetHeader(dSet, "H_SEL_ACC_LIST");
			
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
	 * <p>실적항목단건정보</p>
	 */
	public ActionForward getBizCdNm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new CCom221DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			//현황 리스트 데이터 가져오기
			list    = dao.getBizCdNm(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ_LIST");
			
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
	 * <p>실적항목단건정보-월별경영계획항목명세테이블</p>
	 */
	public ActionForward getBizPlanCdNm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new CCom221DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getBizPlanCdNm(form);
			helper.setDataSetHeader(dSet, "H_SEL_ACC_LIST");
			
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
	 * <p>계정/예산항목리스트조회</p>
	 */
	public ActionForward getAccList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new CCom221DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getAccList(form);
			helper.setDataSetHeader(dSet, "H_SEL_ACC_LIST");
			
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
	 * <p>계정/예산항목단건정보</p>
	 */
	public ActionForward getAccCdNm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new CCom221DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getAccCdNm(form);
			helper.setDataSetHeader(dSet, "H_SEL_ACC_LIST");
			
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
	 * <p>배부기준코드 콤보조회</p>
	 */
	public ActionForward getDivCombo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao      = new CCom221DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo"); //분기할곳
			
			//배부기준코드 콤보조회
			list     = dao.getDivCombo(form);
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
	 * <p>배부기준코드 마스터조회</p>
	 */
	public ActionForward getDivMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		CCom221DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao      = new CCom221DAO();
			dSet     = new GauceDataSet();
			helper   = new GauceHelper2(request, response, form);
			strGoTo  = form.getParam("goTo"); //분기할곳
			
			//배부기준코드 콤보조회
			list     = dao.getDivMst(form);
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
}
