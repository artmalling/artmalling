/*
 * Copyright (c) 2010 대성디큐브. All rights reserved.
 *
 * This software is the confidential and proprietary information of 대성디큐브.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 대성디큐브
 */

package psal.action;

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

import psal.dao.PSal514DAO; 
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on  
 * @modified by 
 * @caused   by 
 */

public class PSal514Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal514Action.class);

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
	 * <p>
	 * 마스터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list1 = null;
		List list2 = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal514DAO dao = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();

			dao = new PSal514DAO();
			helper = new GauceHelper2(request, response, form);
			
            dSet   = new GauceDataSet[2];
            
			dSet[0] = helper.getDataSet("DS_O_MASTER");
			dSet[1] = helper.getDataSet("DS_O_GIFT");
			
			helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
			helper.setDataSetHeader(dSet[1], "H_SEL_GIFT");
			
			list1 = dao.searchMaster(form, OrgFlag, userid);
			list2 = dao.searchGift(form, OrgFlag, userid);
			
			helper.setListToDataset(list1, dSet[0]);
			helper.setListToDataset(list2, dSet[1]);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

 
	

    /**
     * <p> 점별 센서 정보를 등록한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        PSal514DAO dao = null;

        int ret = 0;
        int ret1 = 0;
        String userId = null;
        String userNm = null;
            
        try {
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[1];
            
            dSet[0] = helper.getDataSet("DS_O_MASTER");
            //dSet[1] = helper.getDataSet("DS_O_GIFT");
            helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
            //helper.setDataSetHeader(dSet[1], "H_SEL_GIFT");
            
//            MultiInput mi  = helper.getMutiInput(dSet[0]);
//            MultiInput mig = helper.getMutiInput(dSet[1]);

			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			//mi[1] = helper.getMutiInput(dSet[1]);            
            
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            userNm = sessionInfo.getUSER_NAME();
                 
            dao  = new PSal514DAO();
            ret  = dao.saveData(form  , mi[0],  userId, userNm);
            //ret1 = dao.saveGfData(form, mi[1], userId, userNm);
                
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if (ret != 0)
            	helper.close("정상적으로 처리 되었습니다.");
           
        }
        return mapping.findForward("saveData");
    }    	
    public ActionForward saveGfData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        PSal514DAO dao = null;

        int ret = 0;
        int ret1 = 0;
        String userId = null;
        String userNm = null;
            
        try {
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[1];
            
            //dSet[0] = helper.getDataSet("DS_O_MASTER");
            dSet[0] = helper.getDataSet("DS_O_GIFT");
            //helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
            helper.setDataSetHeader(dSet[0], "H_SEL_GIFT");
            
//            MultiInput mi  = helper.getMutiInput(dSet[0]);
//            MultiInput mig = helper.getMutiInput(dSet[1]);

			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			//mi[1] = helper.getMutiInput(dSet[1]);            
            
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            userNm = sessionInfo.getUSER_NAME();
                 
            dao  = new PSal514DAO();
            //ret  = dao.saveData(form  , mi[0],  userId, userNm);
            ret1 = dao.saveGfData(form, mi[0], userId, userNm);
                
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if (ret1 != 0)
            	helper.close("정상적으로 처리 되었습니다.");
           
        }
        return mapping.findForward("saveGfData");
    } 
}
