/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import dmtc.dao.DMtc701DAO;
import dmtc.dao.DMtc702DAO;


import common.vo.SessionInfo;
/**
 * <p></p>
 * 
 * @created on 1.1, 2010/02/21
 * @created by 장형욱
 * @caused   by 기부적립 조회
 */

public class DMtc702Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DMtc702Action.class);

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
           
            String toDay   = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM"); 
            
            Calendar calendar = Calendar.getInstance(); 
            Date date = dateFormat.parse(toDay); 
            calendar.setTime(date); 
            calendar.add(Calendar.MONTH, -1); 

            toDay = dateFormat.format(calendar.getTime())+ "01"; 
            int listday = calendar.getActualMaximum(calendar.DATE);
            String toDate = dateFormat.format(calendar.getTime()) + Integer.toString(listday);
            
            request.setAttribute("fromDate", toDay);
            request.setAttribute("toDate", toDate);

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
     * <p>기부기획을 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMtc702DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DMtc702DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form);
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
     * <p>기부기획을  상세조회</p>
     * 
     */    
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMtc702DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao    = new DMtc702DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            
            list   = dao.searchDetail(form);
            ArrayList ol = new ArrayList();
            
            for ( int i = 0; i < list.size(); i++ )
            {
                ol = (ArrayList)list.get(i);
                HashMap om = new HashMap();
                om.put("mobile1", ol.get(2));
                om.put("mobile2", ol.get(3));
                om.put("mobile3", ol.get(4));
                
                String mobile  = om.get("mobile1").toString();
                       mobile += "-" + om.get("mobile2").toString();
                       mobile += "-" + om.get("mobile3").toString();    
                       
                ol.set(2, mobile);
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
