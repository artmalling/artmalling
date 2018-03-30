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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.util.Util;
import common.vo.SessionInfo;

import dmbo.dao.DMbo629DAO;
/**
 * <p>EXCEL UPLOAD 적립</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo629Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo629Action.class);
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
	 * EXCEL UPLOAD 미확정 자료 조회.
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
	    
        GauceHelper2 helper = null;
        GauceDataSet dSet   = new GauceDataSet();
        DMbo629DAO   dao    = null; 
        
        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String[] USER_IDS = { sessionInfo.getUSER_ID() };
        form.setParam("USER_ID", USER_IDS);
        try {
            
            dao    = new DMbo629DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            List list = dao.searchMaster(form);
            helper.setListToDataset(list, dSet);


        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(form.getParam("goTo"));
    }
	
	public ActionForward delData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		
		
		int rtnCode = 0;
		
        DMbo629DAO   dao    = null; 
        
        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String[] USER_IDS = { sessionInfo.getUSER_ID() };
        form.setParam("USER_ID", USER_IDS);
        try {
            
            dao    = new DMbo629DAO();
            
            rtnCode = dao.delData(form);

        } catch (Exception e) {
            logger.error("", e);
        } 
 
        return mapping.findForward(form.getParam("goTo"));
    }
	

    /**
     * <p> EXCEL UPLOAD 자료 등록 </p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        DMbo629DAO dao      = null;
        GauceDataSet dSet   = new GauceDataSet();
        
        int rtnCode = 0;
        String rtnMsg  = "";
        form = Util.setParam(form, "USER_ID", sessionInfo.getUSER_ID());
        
        dao = new DMbo629DAO();
        
        try {
            
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            MultiInput input = helper.getMutiInput(dSet);
            
            rtnCode = dao.saveData(form, input);
            if (-1 == rtnCode) {
                rtnMsg = "EXCEL UPLOAD시 유효하지 않은 자료가 발견되었습니다.";
            }
 //           rtnCode = dao.dataCheck(form, input);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if(-1 == rtnCode){
                helper.writeException("GAUCE", "002", rtnMsg);
                helper.close (rtnMsg + " 에러코드 [-1]");
            }else{
                helper.close("정상적으로 처리 되었습니다.");
            }
        }
        
        return mapping.findForward(form.getParam("goTo"));
    }   

    /**
     * <p> EXCEL 미확정자료 확정처리 </p>
     * 
     */
    public ActionForward confData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        DMbo629DAO dao      = null;
        GauceDataSet dSet   = new GauceDataSet();
        
        
        int rtnCode = 0;
        String rtnMsg  = "";
        
        String[] userId =  { sessionInfo.getUSER_ID() };
        form.setParam("USER_ID", userId);
               
        dao = new DMbo629DAO();
        
        try {
            
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            MultiInput input = helper.getMutiInput(dSet);
            rtnCode = dao.confData(form, input);
            
            if (-1 == rtnCode) {
                rtnMsg = "확정처리시 장애가 발생하였습니다.";
            }
      
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if(-1 == rtnCode){
                helper.writeException("GAUCE", "002", rtnMsg);
                helper.close (rtnMsg + " 에러코드 [9999]");
            }else{
                helper.close("정상적으로 처리 되었습니다.");
            }
        }
        
        return mapping.findForward(form.getParam("goTo"));
    }   
}
