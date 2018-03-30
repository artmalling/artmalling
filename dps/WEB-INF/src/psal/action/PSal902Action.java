/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package psal.action;

import java.util.List;

import org.apache.log4j.Logger;

import psal.dao.PSal902DAO;
import pstk.dao.PStk201DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

/**
 * <p>예제</p>
 * 
 * @created  on 1.0, 2010/05/23	
 * @created  by 조형욱
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal902Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal902Action.class);

	/**
	 * <p>매입사별 입금일 관리 화면으로 이동한다.</p>
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
     * <p>매입사별 입금일 리스트를 조회한다.</p>
     * 
     */      
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal902DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal902DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_IO_MASTER");
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
     * <p>적립율을  등록한다.</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
            
            GauceHelper2 helper = null;
            GauceDataSet dSet[] = null;
            PSal902DAO dao      = null;
            int ret             = 0;
            HttpSession session = request.getSession();
    		String userId = null;
            
            String strGoTo      = form.getParam("goTo"); // 분기할곳
            try {
            	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

    			userId = sessionInfo.getUSER_ID();
    			
                dao    = new PSal902DAO();  
                helper = new GauceHelper2(request, response, form);
                
                dSet = new GauceDataSet[2];
    			dSet[0] = helper.getDataSet("DS_IO_MASTER");
    			dSet[1] = helper.getDataSet("DS_IO_MASTER");
    			
    			helper.setDataSetHeader(dSet[0], "H_MASTER");
    			helper.setDataSetHeader(dSet[1], "H_MASTER");
    			
    			
    			MultiInput mi[] = new MultiInput[2];
    			mi[0] = helper.getMutiInput(dSet[0]);
    			mi[1] = helper.getMutiInput(dSet[1]);
    			
    			//dao = new PStk201DAO();		
    			ret = dao.save(form, mi, userId);
    			
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("정상적으로 처리 되었습니다.");
            }
            return mapping.findForward(strGoTo);
    }
    

}
