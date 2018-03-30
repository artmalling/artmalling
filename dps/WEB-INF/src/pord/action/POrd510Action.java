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

import pord.dao.POrd510DAO;

import com.gauce.GauceDataSet;
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

public class POrd510Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd510Action.class);

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
	 * <p>수입제경비 등록/확정 마스터 조회  </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd510DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd510DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.getMaster(form);
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
	 * <p>수입제경비 등록/확정 상세 조회  </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd510DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd510DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getDetail(form);
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
	 * <p>수입제경비 등록/확정 마스터 조회  </p>
	 * 
	 */
	public ActionForward checkCostCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd510DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd510DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_COSTCD");
			helper.setDataSetHeader(dSet, "H_COSTCD");
			list = dao.checkCostCd(form);
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
	 * 제경비 등록 수정 삭제 
	 * </p>
	 * 
	 * <p>
	 * 공통코드 삭제의 경우 데이터를 삭제하지 않고, 사용유무 Flag를 False 처리한다.
	 * </p>
	 * 
	 */
	public ActionForward conf(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd510DAO dao      = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳	
		String msg     = null;
		
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			
			dSet[0] = helper.getDataSet("DS_IO_MASTER");			
            helper.setDataSetHeader(dSet[0], "H_MASTER");            
			MultiInput mi1 = helper.getMutiInput(dSet[0]);	
			 
			dao = new POrd510DAO();    
		    ret = dao.conf(form, mi1, userId);	
			if(form.getParam("strYNGbn").equals("Y")){ 
				msg = "건 확정 되었습니다.";
			}else{
				msg = "건 확정취소 되었습니다.";				
			}
		    	
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0],ret + msg); 
		}
		return mapping.findForward(strGoTo);
	}
	

	
	/**
	 * <p>마감(확정)처리 여부</p>
	 * 
	 */
	public ActionForward checkYnFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd510DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd510DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_RESULT");
			list = dao.checkYnFlag(form);
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
