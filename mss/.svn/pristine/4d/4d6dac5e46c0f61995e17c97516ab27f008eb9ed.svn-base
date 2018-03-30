/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcou.action;

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
import mcou.dao.MCou105DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>상담일지작성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCou105Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCou105Action.class);

    /** 
     * <p>화면 LODA</p>
     * 
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        try {
            GauceHelper2.initialize(form, request, response);
        } catch (Exception e) {
            logger.error("", e);
        }
        return mapping.findForward("list");
    }
    
    /** 
     * <p>상담일지작성POP(신청내역선택) LODA</p>
     * 
     */
    public ActionForward listSelect(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	try {
    		GauceHelper2.initialize(form, request, response);
    	} catch (Exception e) {
    		logger.error("", e);
    	}
    	return mapping.findForward("listSelect");
    }
    
    /** 
     * <p>상담일지작성POP(신청내역상세) LODA</p>
     * 
     */
    public ActionForward listDtl(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	try {
    		GauceHelper2.initialize(form, request, response);
    	} catch (Exception e) {
    		logger.error("", e);
    	}
    	return mapping.findForward("listDtl");
    }
    
    /**
     * <p> 마스터 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou105DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        HttpSession session = request.getSession();
        try { 
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session
            .getAttribute("sessionInfo");
            String userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_IO_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELDAILY");
            dao = new MCou105DAO();
            list = dao.getMaster(form, userId); 
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
     * <p>저장</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {

        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou105DAO dao		= null;
        int  	ret 		= 0;
        HttpSession session = request.getSession();
        String userId = null;
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
			
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELDAILY");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new MCou105DAO();
            ret = dao.save(form, mi, userId);
           
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
     * <p> 상담일지작성(신청내역pop)조회 </p>
     * 
     */
	public ActionForward getListSelect(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        @SuppressWarnings("rawtypes")
		List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou105DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        HttpSession session = request.getSession();
        try {
 
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session
            .getAttribute("sessionInfo");
            String userId = sessionInfo.getUSER_ID();
        	
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELREQ_P");

            dao = new MCou105DAO();
            list = dao.getListSelect(form, userId); 
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
     * <p> 마스터 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public ActionForward getBuyer(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou105DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        HttpSession session = request.getSession();
        try { 
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session
            .getAttribute("sessionInfo");
            String userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_LC_BUYER");			
            helper.setDataSetHeader(dSet, "H_SEL_BUYER");
            dao = new MCou105DAO();
            list = dao.getBuyer(form, userId); 
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
