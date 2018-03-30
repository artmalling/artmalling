/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.action;

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

import com.gauce.GauceDataSet;

import pord.dao.POrd304DAO;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd304Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd304Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
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
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}
	

	/**
	 * <p>
	 * 품번에 따른 단품 종류 체크 위함(신선단품은 제외한다.)
	 * 
	 */
	public ActionForward checkPbnSkuType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd304DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_PBN_SKU_TYPE");
			helper.setDataSetHeader(dSet, "H_PBN_SKU_TYPE");
			list = dao.checkPbnSkuType(form); 
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
	 * TAG 발행의뢰  마스터 조회
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session = request.getSession();
		String userId = null;

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			dao = new POrd304DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.getMaster(form, userId); 
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
	 * TAG 발행의뢰 단품 디테일 조회
	 * </p>
	 * 
	 */
	public ActionForward getPbnSku(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			dao = new POrd304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
			list = dao.getPbnSku(form);
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
	 * <p>단품 매가원가 조회.</p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd304DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_SKU_SALEPRC");
			helper.setDataSetHeader(dSet, "H_SKU_SALEPRC");
			list = dao.getSkuInfo(form);
			//System.out.println("list size : "+ list.size());
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
	 * <p> TAG 발행 의뢰 마스터 등록</p>
	 * 
	 */
	public ActionForward saveMaster(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

//		System.out.println("마스터 삭제");
		String msg = null;
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		 
		POrd304DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_DETAIL"); 
			  
            helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
			helper.setDataSetHeader(dSet[1], "H_SEL_DETAIL");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);
			MultiInput mi2 = helper.getMutiInput(dSet[1]); 
			 
			dao = new POrd304DAO();    
			// 등록및수정, 삭제 분기
			if(form.getParam("strFlag").equals("save")){ 
				ret = dao.saveMaster(form, mi1, mi2, userId);
				msg = "저장되었습니다.";
			}else{
				ret = dao.deleMaster(form, userId);
				msg = "삭제되었습니다.";
			}  
			System.out.println("ret : " + ret);
		} catch (Exception e) { 
			logger.error("", e);
			System.out.println("aaaaaaaa");
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
//			helper.close(dSet, ret + "건 처리되었습니다"); 
			helper.close(dSet, msg); 
		}
		System.out.println("cccccccc");
		return mapping.findForward("saveMaster");
	}

}
