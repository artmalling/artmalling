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

import meis.dao.MEis064DAO;

import com.gauce.GauceDataSet;

import common.util.Util;

/**
 * <p>월별경영실적지침관리</p>
 * 
 * @created on 1.0, 2011/06/14
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis064Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis064Action.class);

	/** 
	 * <p>경영실적지침관리 화면로딩</p>
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
	 * <p>경영실적지침관리 항목마스터COPY 팝업화면 로딩</p>
	 */
	public ActionForward list1(ActionMapping mapping, ActionForm form,
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
	 * <p>경영실적지침관리 전월실적COPY 팝업화면 로딩</p>
	 */
	public ActionForward list2(ActionMapping mapping, ActionForm form,
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
	 * <p>경영실적지침관리 엑셀 업로드 팝업화면 로딩</p>
	 */
	public ActionForward list3(ActionMapping mapping, ActionForm form,
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
	 * <p>월별경영실적지침트리조회</p>
	 */
	public ActionForward searchBizRsltTree(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis064DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis064DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchBizRsltTree(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ_RSLT_TREE");
			
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
	 * <p>월별 계정/예산항목정보조회</p>
	 */
	public ActionForward searchBizRsltDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis064DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis064DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchBizRsltDtl(form);
			helper.setDataSetHeader(dSet, "H_SEL_BIZ_RSLT_DTL");
			
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
	 * 월별 경영실적항목 변경 및 신규 처리
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MEis064DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi[]     = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis064DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = new GauceDataSet[2];
			dSet[0]   = helper.getDataSet("DS_BIZ_TREE");
			dSet[1]   = helper.getDataSet("DS_BIZ_DTL");
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
	 * 월별경영실적항목 삭제 처리
	 * </p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis064DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis064DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = helper.getDataSet("DS_BIZ_TREE");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.delete(form, mi, strUserId);
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
		MEis064DAO dao      = null;
		String strGoTo      = null;
		int ret             = 0;
		
		try {
			dao       = new MEis064DAO();
			dSet      = new GauceDataSet[2];
			helper    = new GauceHelper2(request, response, form);
			strGoTo   = form.getParam("goTo");
			dSet[0]   = helper.getDataSet("DS_BIZ_CD");
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
		MEis064DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis064DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = helper.getDataSet("DS_BIZ_CD");
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
	
	/**
	 * <p>
	 * 항목마스터 복사
	 * </p>
	 * 
	 */
	public ActionForward copyBizMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MEis064DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		String ret[]        = null;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MEis064DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = helper.getDataSet("DS_BIZ_MST");
			mi        = helper.getMutiInput(dSet);
			
			ret       = dao.copyBizMst(form, mi, strUserId);
			if(!"".equals(ret[1]) || !"".equals(ret[2])){
				String errorMsg = "";
				String strBizCd = ret[1] + "," + ret[2];
				if(strBizCd.startsWith(",")) strBizCd = strBizCd.substring(1);
				if(strBizCd.endsWith(","))   strBizCd = strBizCd.substring(0, strBizCd.length()-1);
				if(!"".equals(ret[1])) errorMsg = "실적항목코드  " + ret[1] + " : 월별경영실적항목마스터에 존재";
				if(!"".equals(ret[2])) errorMsg = errorMsg + "<br>" + "실적항목코드  " +  ret[2].substring(0, ret[2].length()-1) + " : 월별경영실적항목명세에 존재";
				helper.writeException("USER", "001", strBizCd);
				helper.writeException("USER", "002", errorMsg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret[0] + "건 처리되었습니다");
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>월별경영실적항목마스터 전월조회</p>
	 */
	public ActionForward searchPre(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis064DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis064DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchPre(form);
			helper.setDataSetHeader(dSet, "H_SEL_MST");
			
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
	 * <p>월별경영실적항목명세 전월조회</p>
	 */
	public ActionForward searchPreDtl(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis064DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis064DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchPreDtl(form);
			helper.setDataSetHeader(dSet, "H_SEL_DTL");
			
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
