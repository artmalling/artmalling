/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.action;

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

import mpro.dao.MPro104DAO;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro104Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MPro104Action.class);

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
        MPro104DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MASTER");

            dao = new MPro104DAO();
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
     * <p> SMS리스트(디테일) 조회 </p> 
     * 
     */ 
    @SuppressWarnings("rawtypes")
    public ActionForward getDetail(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    throws Exception {
    	List list			= null;
    	GauceHelper2 helper	= null;
    	GauceDataSet dSet	= null;
    	MPro104DAO dao		= null;
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {
    		
    		helper = new GauceHelper2(request, response, form);
    		dSet = new GauceDataSet();
    		dSet = helper.getDataSet("DS_IO_DETAIL");			
    		helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
    		
    		dao = new MPro104DAO();
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
    
    /**
     * <p>저장</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {

        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MPro104DAO dao		= null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new MPro104DAO();
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
}
