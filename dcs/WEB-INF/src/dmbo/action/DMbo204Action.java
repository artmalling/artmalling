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

import dmbo.dao.DMbo204DAO;

import common.vo.SessionInfo;

/**
 * <p>제휴카드사 비용분담율 관리</p>
 * 
 * @created  on 1.0, 2010/05/19
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo204Action extends DispatchAction {
	/* 
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo204Action.class);

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
     * <p>적립율 등록 조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo204DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
 
            dao    = new DMbo204DAO();
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
            GauceDataSet dSet   = null;
            DMbo204DAO dao      = null;
            int ret             = 0;
            
            String strGoTo      = form.getParam("goTo"); // 분기할곳
            try {
            	
                dao    = new DMbo204DAO();  
                helper = new GauceHelper2(request, response, form);
                
                dSet = helper.getDataSet("DS_IO_MASTER");
                helper.setDataSetHeader(dSet, "H_MASTER");
                MultiInput mi = helper.getMutiInput(dSet);
                ret = dao.save(form, mi, request);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("정상적으로 처리 되었습니다.");
            }
            return mapping.findForward(strGoTo);
    }    
    
    /**
     * <p> 적립월 콤보박스 처리 </p>
     */
    public ActionForward getDcEtcCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        DMbo204DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
         
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON"); 
            dSet[1] = helper.getDataSet("DS_O_COMMON");
            mi = helper.getMutiInput(dSet[0]); 
            helper.setDataSetHeader(dSet[1], "H_COMMON");
            dao = new DMbo204DAO(); 
            list = dao.getEtcCode(form, mi);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward(strGoTo);
    }
    
}
