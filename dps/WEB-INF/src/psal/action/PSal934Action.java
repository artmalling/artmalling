/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import psal.dao.PSal934DAO;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created on 1.1, 2010/05/26
 * @created by 김영진
 * @caused  by 반송건 재청구 생성 
 */

public class PSal934Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(PSal934Action.class);

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
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[list]", e);
        }

        return mapping.findForward("list");
    }
    
    /**
     * <p>반송건 재청구 생성 조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal934DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {      
            dao    = new PSal934DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
           
            list   = dao.searchMaster(form, request);
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
     * <p>반송건 재청구 생성 상세 조회</p>
     * 
     */    
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal934DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao    = new PSal934DAO();
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
     * <p>반송건 청구 데이터 읽어오기</p>
     * 
     */    
    public ActionForward searchRead(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal934DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao    = new PSal934DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_DETAIL_D");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            
           list   = dao.searchRebyReq(form);
           if(list.size() == 0){
               list   = dao.searchDetail(form);
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
     * <p>재청구 등록</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal934DAO dao      = null;
        int ret             = 0;
        HttpSession session = request.getSession();
        String userId = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
 
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL_D");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new PSal934DAO();
            ret = dao.save(form, mi, userId);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, ret+"건 처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
    }
    
    
    /**
     * <p>재청구 일괄 등록</p>
     * 
     */
    public ActionForward saveBatch(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal934DAO dao      = null;
        int ret             = 0;
        HttpSession session = request.getSession();
        String userId = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
   
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID(); 
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new PSal934DAO(); 
            ret = dao.saveBatch(form, mi, userId); 

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, ret+"건 처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
    }
}
