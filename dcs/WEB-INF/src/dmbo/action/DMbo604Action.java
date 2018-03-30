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
import common.vo.SessionInfo;

import dcom.socket.dClientDept;
import dctm.dao.DCtm209DAO;
import dmbo.dao.DMbo604DAO;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/01/18
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo604Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo604Action.class);

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
	 * <p>포인트 강제 적립/차감 정보를 조회한다.</p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;

		GauceHelper2 helper = null;
	    GauceDataSet dSet   = null;
		
		DMbo604DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			 
            dao    = new DMbo604DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form, dSet);
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
	 * <p>포인트 강제 적립/차감 정보를 등록한다.</p>
	 * 
	 */
	public ActionForward saveData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DMbo604DAO dao = null;
        dClientDept client = null;

        int ret = 0;
        String sendData = "";
            
        try {
		
            helper = new GauceHelper2(request, response, form);
				
            //dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_I_POINT");							
            dao = new DMbo604DAO();
				
            ret = dao.saveData(form, dSet, request);
 
 
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            //helper.close(dSet, ret + "건 변경 되었습니다.");
            helper.close("정상적으로 처리 되었습니다.");
        }
        return mapping.findForward("searchMaster");
    }	
	
	/**
	 * <p>당일 포인트 강제 적립/차감 정보를 조회한다.</p>
	 * 
	 */
	public ActionForward searchTodayList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null; 
		
		GauceHelper2 helper = null;
	    GauceDataSet dSet   = null;
		
		DMbo604DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			 
            dao    = new DMbo604DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_MASTER2"); 
            helper.setDataSetHeader(dSet, "H_MASTER2");
            
            list   = dao.searchTodayList(form, request);
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
