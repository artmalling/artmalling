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

import dmbo.dao.DMbo618DAO;

import common.util.Util;
import common.vo.SessionInfo;
/**
 * <p></p>
 * 
 * @created  on 1.0, 2010.05.29
 * @created  by 강진(FUJITSU KOREA LTD.)
 * @caused   by 부정적립예상 통계 조회(브랜드)
 * 
 */

public class DMbo618Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DMbo618Action.class);

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
     * <p>부정적립예상 통계 조회(브랜드)</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo618DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DMbo618DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            ArrayList ol = new ArrayList();
            list   = dao.searchMaster(form);
            
            for ( int i = 0; i < list.size(); i++ )
            {
                ol = (ArrayList)list.get(i);
                HashMap om = new HashMap();
                om.put("homeph1", ol.get(3));
                om.put("homeph2", ol.get(4));
                om.put("homeph3", ol.get(5));
                
                om.put("mobile1", ol.get(6));
                om.put("mobile2", ol.get(7));
                om.put("mobile3", ol.get(8));
                
                String homeph  = om.get("homeph1").toString();
                       homeph += "-" + om.get("homeph2").toString();
                       homeph += "-" + om.get("homeph3").toString();    
                       
                String mobile  = om.get("mobile1").toString();
                       mobile += "-" + om.get("mobile2").toString();
                       mobile += "-" + om.get("mobile3").toString();                          
                
                if (!"".equals(om.get("homeph1").toString()))
                	ol.set(3, homeph);
                
                if (!"".equals(om.get("mobile1").toString()))    
                	ol.set(6, mobile);
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
     * <p>부정적립예상 통계 상세조회 (브랜드)</p>
     * 
     */    
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo618DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao    = new DMbo618DAO();
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
    
    public ActionForward httpstore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		DMbo618DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳    
     
		try {
 
			dao = new DMbo618DAO();
			list = dao.httpstore(form);

			Util.forwardXML(response, Util.makeOZXML(list, new String[]{"SS_NO","HOME_PH1","HOME_PH2","HOME_PH3","MOBILE_PH1","MOBILE_PH2","MOBILE_PH3","CARD_NO"}));
            
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		} 
		return mapping.findForward("save");
	}
}
