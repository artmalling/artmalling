/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

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

import dctm.dao.DCtm202DAO;

import common.vo.SessionInfo;
/**
 * <p>법인카드조회</p>
 * 
 * @created  on 1.0, 2010/02/25
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm202Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm202Action.class);

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
     * <p>법인카드  리스트를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

    	List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
        DCtm202DAO   dao    = null; 
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
        	
            dao     = new DCtm202DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form);
			helper.setListToDataset(list,  dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>법인카드 대표카드를 변경한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
            
            GauceHelper2 helper = null;
            GauceDataSet dSet   = null;
            DCtm202DAO dao      = null;
            int ret             = 0;
            
            HttpSession session = request.getSession();
            String userId       = null;
            String strGoTo      = form.getParam("goTo"); // 분기할곳
           
            try {
                dao    = new DCtm202DAO();
                SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
                userId = sessionInfo.getUSER_ID();
                helper = new GauceHelper2(request, response, form);
                dSet = helper.getDataSet("DS_O_MASTER");
                helper.setDataSetHeader(dSet, "H_MASTER");
                MultiInput mi = helper.getMutiInput(dSet);
                
                ret = dao.save(form, mi, userId);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                //helper.close(dSet, ret + "건 저장  되었습니다.");
                helper.close("정상적으로 처리 되었습니다.");
            }
            return mapping.findForward("saveData");
    }    
}
