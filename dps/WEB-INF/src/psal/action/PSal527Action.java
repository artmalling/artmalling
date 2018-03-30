/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.action;

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

import psal.dao.PSal527DAO;


import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal527Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal527Action.class);

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
	 * 당초팀별년매출계획 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchOrgMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal527DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();

			dao = new PSal527DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_CHKORGMST");
			helper.setDataSetHeader(dSet, "CHECK");
			
			list = dao.searchOrgMst(form, OrgFlag);
			for(int i=0; i<list.size(); i++){
				
				System.out.println("list : "+list.get(i).toString());
			}
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
	 * <p>엑셀 데이터를 검증한다.</p>
	 * 
	 */
	public ActionForward deleteData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal527DAO dao = null;
		List list = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			dao = new PSal527DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			
			dSet[0] = helper.getDataSet("DS_MASTER");
			dSet[1] = helper.getDataSet("DS_RESULT");
			MultiInput mi = new MultiInput(dSet[0]);
			
			helper.setDataSetHeader(dSet[1], "H_MASTER");
			list = dao.deleteData(form, mi);
			
			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>엑셀 데이터를 저장한다.</p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal527DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();

			dao = new PSal527DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
			MultiInput mi = null;
			
			helper.setDataSetHeader(dSet, "H_SKU2");
			
			mi = new MultiInput(dSet);
			ret = dao.saveStnSkumst(form, mi, userId);
				
			
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
	 * 당초팀별년매출계획 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal527DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userId = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
			userId = sessionInfo.getUSER_ID();
			
			dao = new PSal527DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.searchMaster(form, OrgFlag, userId);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 확정처리
	 * </p>
	 * 
	 */
	public ActionForward valCheck(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal527DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입)     
		int ret             = 0;
		String res		    = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_MASTER");
                   
            helper.setDataSetHeader(dSet[0], "H_MASTER");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal527DAO();    
		
			res = dao.valCheck(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], res);
		}
		return mapping.findForward("valCheck");
	}

}
