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

import mcou.dao.MCou104DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>[상담/계약]바이어변경이력조회</p>
 * 
 * @created  on 1.0, 2011/03/03
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCou104Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(MCou104Action.class);

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
        MCou104DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MO_COUNSELREQ");
 
            dao = new MCou104DAO();
            list = dao.getMaster(form); 
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
     * <p> 디테일 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public ActionForward getDetail(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	List list			= null;
    	GauceHelper2 helper	= null;
    	GauceDataSet dSet	= null;
    	MCou104DAO dao		= null;
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

    		helper = new GauceHelper2(request, response, form);
    		dSet = new GauceDataSet();
    		dSet = helper.getDataSet("DS_IO_DETAIL");			
    		helper.setDataSetHeader(dSet, "H_SEL_MO_BUYERMODHIS");
    		
    		dao = new MCou104DAO(); 
    		list = dao.getDetail(form); 
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
