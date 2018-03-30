/*
 * Copyright (c) 2016 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package common.action;

import java.util.List;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import common.dao.CCom999DAO;
import common.vo.SessionInfo;

import com.gauce.GauceDataSet;

/**
 * <p>아트몰링 추가개발 팝업</p>
 * 
 * @created  on 1.0, 2016/10/25
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom999Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom999Action.class);

    /**
     * <p>
     * 점별 POS 팝업화면 호출
     * </p>
     */
    public ActionForward popUpPosNo(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
    }

    /**
     * <p>
     * 점별 브랜드 팝업화면 호출
     * </p>
     */
    public ActionForward popUpPumbunCd(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
    }
    
	/**
	 * <p>
	 * 점별 POS 조회(POPUP, 단건)
	 * </p>
	 * 
	 */
	public ActionForward searchPosNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom999DAO dao      = null;
		MultiInput mi       = null;
		
		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		String strGoTo = form.getParam("goTo");
		
		try {
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");
			
			mi      = helper.getMutiInput(dSet[0]);			// 조회조건	DataSet	
			helper.setDataSetHeader(dSet[1], "H_STR_POS_MST1");

			dao  = new CCom999DAO();
			list = dao.searchPosNo(form, mi, userId, orgFlag);

			System.out.println("list = " + list.size());

			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {

//			System.out.println("1111111111111111 = " + e.getMessage());
			System.out.println("1111111111111111 = " + e.toString());
//			System.out.println("1111111111111111 = " + e.getLocalizedMessage());
//			System.out.println("1111111111111111 = " + e.hashCode());
//			System.out.println("1111111111111111 = " + e.getCause());
//			System.out.println("1111111111111111 = " + e.getStackTrace());
			
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
    
	/**
	 * <p>
	 * 점별 POS 조회(POPUP, 단건)
	 * </p>
	 * 
	 */
	public ActionForward searchPumbunCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom999DAO dao      = null;
		MultiInput mi       = null;
		
		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		String strGoTo = form.getParam("goTo");
		
		try {
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");
			
			mi      = helper.getMutiInput(dSet[0]);			// 조회조건	DataSet	
			helper.setDataSetHeader(dSet[1], "H_STR_PUMBUN_MST1");

			dao  = new CCom999DAO();
			list = dao.searchPumbunCd(form, mi, userId, orgFlag);
			System.out.println("list = " + list.size());
			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {

//			System.out.println("1111111111111111 = " + e.getMessage());
//			System.out.println("1111111111111111 = " + e.toString());
//			System.out.println("1111111111111111 = " + e.getLocalizedMessage());
//			System.out.println("1111111111111111 = " + e.hashCode());
//			System.out.println("1111111111111111 = " + e.getCause());
//			System.out.println("1111111111111111 = " + e.getStackTrace());
			
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
}
