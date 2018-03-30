/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dbri.action;

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

import dbri.dao.DBri320DAO;

import common.vo.SessionInfo;

/**
 * <p>SMS 회원 조회(브랜드)</p>
 * 
 * @created  on 1.1, 2012.06.04
 * @created  by 강진
 * @caused   by SMS 회원 조회(브랜드)
 */
public class DBri320Action extends DispatchAction {
    /**
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DBri320Action.class);

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
     * <p>SMS 회원 조회(브랜드)을 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DBri320DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
 
            dao    = new DBri320DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form);
			
			for (int j = 0; j < list.size(); j++) {
                List tmplist = (List) list.get(j);
                String mp1 = tmplist.get(7).toString(); //MOBILE_PH1
                String mp2 = tmplist.get(8).toString(); //MOBILE_PH2
                String mp3 = tmplist.get(9).toString(); //MOBILE_PH3
                
                String em1 = tmplist.get(10).toString(); //EMAIL1
                String em2 = tmplist.get(11).toString(); //EMAIL2
                if (mp1.length() > 0 || mp2.length() > 0 || mp3.length() > 0) {
                    tmplist.set(3, mp1 + "-" +mp2 + "-" + mp3); //MOBILE_PH1
                }
                
                if (em1.length() > 0 || em2.length() > 0) {
                    tmplist.set(4, em1 + "@" +em2); //EMAIL1
                }
                list.set(j, tmplist);
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
}

