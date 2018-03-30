/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

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
import dctm.dao.DCtm214DAO;

import common.vo.SessionInfo;
/**
 * <p>카드중지이력</p>
 * 
 * @created  on 1.0, 2010/03/18
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm214Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DCtm214Action.class);

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
     * <p>카드중지이력을 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        
        List list           = null;
        GauceHelper2 helper = null;
        GauceDataSet[] dSet   = null;
        DCtm214DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo");
        
        String[] brchId =  {sessionInfo.getBRCH_ID()};
        form.setParam("BRCH_ID", brchId);

        try {
            dSet   = new GauceDataSet[1];
            dao    = new DCtm214DAO();
            helper = new GauceHelper2(request, response, form);
            dSet[0]   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            
            //dSet[1]   = helper.getDataSet("DS_O_CUST");
            //helper.setDataSetHeader(dSet[1], "H_CUST");
            
            list   = dao.searchMaster(form);
            helper.setListToDataset(list,  dSet[0]);

            //List cust = dao.searchCust(form);
            //helper.setListToDataset(cust,  dSet[1]);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
}
