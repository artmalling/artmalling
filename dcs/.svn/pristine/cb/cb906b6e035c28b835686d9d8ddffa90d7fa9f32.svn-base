/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

import java.util.ArrayList;
import java.util.HashMap;
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

import common.vo.SessionInfo;

import dmbo.dao.DMbo714DAO;

/**
 * <p>회원별 방문횟수조회</p>
 * 
 * @created  on 1.0, 2010/06/30
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo714Action extends DispatchAction {
	/**
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo714Action.class);

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
     * <p>회원별 방문횟수 마스터를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

    	List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
        DMbo714DAO   dao    = null; 
        String strGoTo = form.getParam("goTo"); // 분기할곳
 
        try {
        	
            dao     = new DMbo714DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_MASTER");
			
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			list  = dao.searchMaster(form, request, response);
			helper.setListToDataset(list,  dSet[0]);
			
        } catch (Exception e) {
            logger.error("", e); 
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>회원별 방문횟수  상세 조회한다.</p>
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo714DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
 
            dao    = new DMbo714DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_DETAIL");
            
            helper.setDataSetHeader(dSet, "H_DETAIL");
            list   = dao.searchDetail(form);
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
