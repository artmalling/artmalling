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

import com.gauce.GauceDataSet;

import psal.dao.PSal401DAO;
import psal.dao.PSal446DAO;
import psal.dao.PSal458DAO;
import psal.dao.PSal540DAO;
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

public class PSal540Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal540Action.class);

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
	 * 마스터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PSal540DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal540DAO();
			helper = new GauceHelper2(request, response, form);
			
			if(request.getParameter("strGubun").equals("1")){
				dSet = helper.getDataSet("DS_O_MASTER");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER");
				list = dao.searchMaster(form, OrgFlag, userid);
				helper.setListToDataset(list, dSet);
				
				
			}else if(request.getParameter("strGubun").equals("2")){
				dSet = helper.getDataSet("DS_O_MASTER2");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER2");
				list = dao.searchMaster(form, OrgFlag, userid);
				helper.setListToDataset(list, dSet);
				
			}else if(request.getParameter("strGubun").equals("3")){
				dSet = helper.getDataSet("DS_O_MASTER3");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER3");
				list = dao.searchMaster(form, OrgFlag, userid);
				helper.setListToDataset(list, dSet);
			}else if(request.getParameter("strGubun").equals("4")){
				dSet = helper.getDataSet("DS_O_MASTER4");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER4");
				list = dao.searchMaster(form, OrgFlag, userid);
				helper.setListToDataset(list, dSet);
			}else if(request.getParameter("strGubun").equals("5")){
				dSet = helper.getDataSet("DS_O_MASTER5");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER5");
				list = dao.searchMaster(form, OrgFlag, userid);
				helper.setListToDataset(list, dSet);
			}else if(request.getParameter("strGubun").equals("6")){
				dSet = helper.getDataSet("DS_O_MASTER6");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER6");
				list = dao.searchMaster(form, OrgFlag, userid);
				helper.setListToDataset(list, dSet);
			}
			
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/**
     * <p>출력</p>
     */
    public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳
		GauceHelper2.initialize(form, request, response);
		return mapping.findForward(strGoTo);
	}
}