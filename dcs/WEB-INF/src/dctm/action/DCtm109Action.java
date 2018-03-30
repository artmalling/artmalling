/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.util.ArrayList;
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
import dctm.dao.DCtm109DAO;

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

public class DCtm109Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm108Action.class);

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
     * <p>카드분실해제등록 조회한다.</p>
     * 
     */
    
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm109DAO      dao     = null;
        ArrayList    arrList= new ArrayList();

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DCtm109DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_MASTER");
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
     * <p>카드분실해제등록 한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
         
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm109DAO dao = null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = null;
        String strBrchId = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            SessionInfo sessionInfo = (SessionInfo) session
                    .getAttribute("sessionInfo");
            
            userId = sessionInfo.getUSER_ID();
            strBrchId = sessionInfo.getBRCH_ID();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSet);
            
            dao = new DCtm109DAO();
            ret = dao.saveData(form, mi, userId, strBrchId);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, ret + "건 처리되었습니다");
        }
        return mapping.findForward(strGoTo);
    }   	

}
