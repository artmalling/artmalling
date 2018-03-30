/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction; 
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import dmbo.dao.DMbo303DAO;

import common.vo.SessionInfo;

/**
 * <p>무료주차시간조회</p>
 * 
 * @created  on 1.0, 2010/01/18
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2010/03/18
 * @modified by 김영진
 * @caused   by 무료주차시간조회
 */
public class DMbo303Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo303Action.class);

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
     * <p>무료주차시간조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        DMbo303DAO   dao    = null; 
        GauceDataSet dSet   = null;
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
		HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        try {
 
            dao    = new DMbo303DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_MASTER");
			
            helper.setDataSetHeader(dSet, "H_MASTER");
               
            String strBrchId = sessionInfo.getBRCH_ID();
			list  = dao.searchMaster(form, strBrchId);
			
			helper.setListToDataset(list,  dSet);

        } catch (Exception e) {
            logger.error("", e); 
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>무료주차시간조회 상세</p>
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        DMbo303DAO   dao    = null; 
        GauceDataSet dSet   = null;
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
		HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        try {
 
            dao    = new DMbo303DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_DETAIL");
			
            helper.setDataSetHeader(dSet, "H_DETAIL");

            String strBrchId = sessionInfo.getBRCH_ID();
			list  = dao.searchDetail(form, strBrchId);
			
			helper.setListToDataset(list,  dSet);

        } catch (Exception e) {
            logger.error("", e); 
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
}
