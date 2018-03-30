/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

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

import tcom.dao.TCom104DAO;
import tcom.dao.TCom301DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
/**
 * <p>다운로드로그</p>
 *  
 * @created  on 1.0, 2010/06/28
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class TCom301Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom301Action.class);

	/**
	 * <p>페이지LOAD.</p>
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
	 *  시스템구분 별 대분류를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward selectLcode(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom301DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom301DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_LCODE");
			helper.setDataSetHeader(dSet, "H_SEL_CODE");
			
			list = dao.selectLcode(form);
			helper.setListToDataset(list, dSet);

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
	 *  대분류 별 중분류를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward selectMcode(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom301DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom301DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_MCODE");
			helper.setDataSetHeader(dSet, "H_SEL_CODE");
			
			list = dao.selectMcode(form);
			helper.setListToDataset(list, dSet);

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
	 *  중분류 별 소분류를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward selectScode(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom301DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom301DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_SCODE");
			helper.setDataSetHeader(dSet, "H_SEL_CODE");
			
			list = dao.selectScode(form);
			helper.setListToDataset(list, dSet);

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
	 *  다운로드로그 리스트를 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward selectList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom301DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom301DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_LIST");
			helper.setDataSetHeader(dSet, "H_SEL_LIST");
			
			list = dao.selectList(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
}
