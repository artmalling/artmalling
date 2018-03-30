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

import org.apache.log4j.Logger;

import mcou.dao.MCou101DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>[상담/계약]신규상담내역</p>
 * 
 * @created  on 1.0, 2011/01/24
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCou101Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(MCou101Action.class);

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
     * <p>리스트POP화면 LODA</p>
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
     * <p>바이어 정보변경 POP화면 LODA</p>
     * 
     */
    public ActionForward listCngBuyer(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	try {
    		GauceHelper2.initialize(form, request, response);
    	} catch (Exception e) {
    		logger.error("", e);
    	}
    	return mapping.findForward("listCngBuyer");
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
        MCou101DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        HttpSession session = request.getSession();
        try {
        	
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            String userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELREQ");
 
            dao = new MCou101DAO();
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
     * <p> POP(마스터) 조회 </p>
     * 
     */
	public ActionForward getListMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        @SuppressWarnings("rawtypes")
		List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou101DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        HttpSession session = request.getSession();
        try {
        	
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            String userId = sessionInfo.getUSER_ID();
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELREQ_P");

            dao = new MCou101DAO();
            list = dao.getListMaster(form, userId); 
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
	 * <p> POP(마스터) 조회(첨부파일) </p>
	 * 
	 */
	public ActionForward getListMasterFiles(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		@SuppressWarnings("rawtypes")
		List list			= null;
		GauceHelper2 helper	= null;
		GauceDataSet dSet	= null;
		MCou101DAO dao		= null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		HttpSession session = request.getSession();
		try {
			
			//session 정보
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			String userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_O_REQFILSE");			
			helper.setDataSetHeader(dSet, "H_SEL_MO_REQFILSE");
			
			dao = new MCou101DAO();
			list = dao.getListMasterFiles(form, userId); 
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
     * <p> POP(상세) 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public ActionForward getListDetail(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	List list			= null;
    	GauceHelper2 helper	= null;
    	GauceDataSet dSet	= null;
    	MCou101DAO dao		= null;
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

    		helper = new GauceHelper2(request, response, form);
    		dSet = new GauceDataSet();
    		dSet = helper.getDataSet("DS_IO_DETAIL");			
    		helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELANS_P");
    		
    		dao = new MCou101DAO(); 
    		list = dao.getListDetail(form); 
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
    public ActionForward listSave(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {

        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou101DAO dao		= null;
        int  ret			= 0;
        HttpSession session = request.getSession();
        String userId = null;
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELANS_P");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new MCou101DAO();
            ret = dao.listSave(form, mi, userId);
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
     * <p>답변내역 삭제</p>
     * 
     */
    public ActionForward listDel(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	
    	GauceHelper2 helper	= null;
    	GauceDataSet dSet	= null;
    	MCou101DAO dao		= null;
    	
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {
    		helper = new GauceHelper2(request, response, form);
    		dSet = helper.getDataSet("DS_IO_DETAIL");
    		helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELANS_P");
    		MultiInput mi = helper.getMutiInput(dSet);
    		dao = new MCou101DAO();
    		dao.listDel(form, mi);
    		
    	} catch (Exception e) {
    		logger.error("", e);
    		helper.writeException("GAUCE", "002", e.getMessage());
    	} finally {
    		// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
    		helper.close(dSet, "삭제 처리되었습니다");
    	}
    	return mapping.findForward(strGoTo);
    }
    
	/**
     * <p> 현재 바이어 정보 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public ActionForward getBuyer(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	List list			= null;
    	GauceHelper2 helper	= null;
    	GauceDataSet dSet	= null;
    	MCou101DAO dao		= null;
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

    		helper = new GauceHelper2(request, response, form);
    		dSet = new GauceDataSet();
    		dSet = helper.getDataSet("DS_IO_MASTER");			
    		helper.setDataSetHeader(dSet, "H_SEL_CHANGE_BUYER");
    		
    		dao = new MCou101DAO(); 
    		list = dao.getBuyer(form); 
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
     * <p> 바이어변경저장/이력저장 </p>
     * 
     */
    public ActionForward buyerCngSave(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception { 

        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCou101DAO dao		= null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = null;

        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session
            .getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_CHANGE_BUYER");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new MCou101DAO();
            ret = dao.buyerCngSave(form, mi, userId);
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 저장, 삭제, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, ret + "건 처리되었습니다");
        }
        return mapping.findForward("save");
    }
}
