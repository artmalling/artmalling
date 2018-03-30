/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.action;

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

import pcod.dao.PCod101DAO;
import pcod.dao.PCodC01DAO;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;


/**
 * <p>기준정보 > 기타관리 > 협력사 사원관리  </p>
 * 
 * @created  on 1.0, 2012/07/10
 * @created  by 조승배(FKSS)
 * 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCodC01Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCodA01Action.class);

	/**
	 * <p>화면를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 

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
	 * <p>상세를 보여준다.</p>
	 * 
	 */
	public ActionForward detail(ActionMapping mapping, ActionForm form,
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
	 * 마스터를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodC01DAO dao = null;
		MultiInput mi = null;
		String userId       = null;
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   = sessionInfo.getUSER_ID();
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			dao = new PCodC01DAO();
			
			list = dao.searchMaster(form, mi, request, userId);
			
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
	
	public ActionForward searchdetail(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodC01DAO dao = null;
		MultiInput mi = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL5");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL1");
			dao = new PCodC01DAO();
			
			list = dao.searchdetail(form, mi, request);
			
			
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
	 * 디테일을 조회 한다.
	 * </p>
	 * 
	 */
	
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodC01DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			//dSet = new GauceDataSet;
			
			dSet = helper.getDataSet("DS_IO_MASTER");			  
            helper.setDataSetHeader(dSet, "H_INS_MASTER");			  
			MultiInput mi1 = helper.getMutiInput(dSet);
			 
			dao = new PCodC01DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.save(form, mi1, userId, org_flag);
			System.out.println("save end");
		} catch (Exception e) { 
			//logger.error("", e);
			//helper.writeException("GAUCE", "002", e.getMessage());
			
			e.printStackTrace();
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			System.out.println(ret);
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward savedetail(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodC01DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			//dSet = new GauceDataSet;
			
			dSet = helper.getDataSet("DS_IO_DETAIL5");			  
            helper.setDataSetHeader(dSet, "H_SEL_DETAIL1");			  
			MultiInput mi1 = helper.getMutiInput(dSet);
			 
			dao = new PCodC01DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.savedetail(form, mi1, userId, org_flag);
			System.out.println("save end");
		} catch (Exception e) { 
			//logger.error("", e);
			//helper.writeException("GAUCE", "002", e.getMessage());
			
			e.printStackTrace();
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			System.out.println(ret);
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward delete(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodC01DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			//dSet = new GauceDataSet;
			
			dSet = helper.getDataSet("DS_IO_MASTER");			  
            helper.setDataSetHeader(dSet, "H_INS_MASTER");			  
			MultiInput mi1 = helper.getMutiInput(dSet);
			 
			dao = new PCodC01DAO();    
			// 등록및수정, 삭제 분기
			
			
			ret = dao.delete(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			//logger.error("", e);
			//helper.writeException("GAUCE", "002", e.getMessage());
			
			e.printStackTrace();
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
}
