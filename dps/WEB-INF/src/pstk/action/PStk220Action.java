/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.action;

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

//import pstk.dao.PStk202DAO;
import pstk.dao.PStk220DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>백화점영업관리> 재고수불> 재고실사> 실사재고등록(단품)</p>
 * 
 * @created  on 1.0, 2010/04/04
 * @created  by 이재득
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk220Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PStk220Action.class);

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
	 * 실사재고(단품)을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {	
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchMaster(form);
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
	 * 실사재고(단품)을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMasterExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {	
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_EXCEL");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchMasterExcel(form);
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
	 * <p> 엑셀업로드 팝업 </p>
	 * 
	 */
	public ActionForward popUpList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)            
			throws Exception { 
                            
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
			//System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
           
            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());
            } 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[popUpList]", e);
		}  

		return mapping.findForward("popUpList");
	}
	
	/** 
	 * <p>
	 * 품번에따른 재고실사 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPbnStk(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;
		//String userId = null;
		//HttpSession session = request.getSession();

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {			
			//SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			//userId = sessionInfo.getUSER_ID();
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_PBNSTK");
			helper.setDataSetHeader(dSet, "H_SEL_PBNSTK");
			list = dao.searchPbnStk(form);
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
	 * 품번에따른 재고실사 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPbnInf(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {	
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_PBNINF");
			helper.setDataSetHeader(dSet, "H_SEL_PBNINF");
			list = dao.searchPbnInf(form);
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
	 * 마감 조회한다.
	 * </p>
	 * 
	 */
	public ActionForward searchCloseDt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {	
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_CLOSE");
			helper.setDataSetHeader(dSet, "H_SEL_CLOSE");
			list = dao.searchCloseDt(form);
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
	 * 단품코드를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSkuCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;
		String userId = null;
		HttpSession session = request.getSession();

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {			
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			String orgFlag = sessionInfo.getORG_FLAG();
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_SKUCD");
			helper.setDataSetHeader(dSet, "H_SEL_SKUCD");
			list = dao.searchSkuCd(form , userId , orgFlag);
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
	 * 단품코드유효성체크 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSkuCheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;		

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new PStk220DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_SKUCHECK");
			helper.setDataSetHeader(dSet, "H_SEL_SKUCHECK");
			list = dao.searchSkuCheck(form);
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
	 * 실사재고를 저장/수정
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");

			MultiInput mi = helper.getMutiInput(dSet);
			
			dao = new PStk220DAO();
			
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 인정LOSS율을 삭제한다.
	 * </p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PStk220DAO dao = null;
		int ret = 0;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			dao = new PStk220DAO();		
			MultiInput mi = new MultiInput(dSet);			
			ret = dao.delete(form, mi);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "삭제 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}

}
