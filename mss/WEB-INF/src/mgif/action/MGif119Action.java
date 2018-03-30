/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import mgif.dao.MGif119DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>
 * </p>
 * 
 * @created on 1.0, 2011/03/24
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif119Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif119Action.class);
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
	 * <p>상품권종류 조회</p>
	 */
    @SuppressWarnings("rawtypes")
	public ActionForward getEtcCodeSub_Type(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MGif119DAO dao		= null;
        String strGoTo = form.getParam("goTo");
        try {
        	dao = new MGif119DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_GIFT_TYPE_CD");
			helper.setDataSetHeader(dSet, "H_GIFT_TYPE_CD");
			list = dao.getEtcCodeSub_Type(form);
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
	 * <p>상품권종류 조회</p>
	 */
    @SuppressWarnings("rawtypes")
	public ActionForward getEtcCodeSub_Amt(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MGif119DAO dao		= null;
        String strGoTo = form.getParam("goTo");
        try {
        	
        	dao = new MGif119DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_GIFT_AMT_TYPE");
			helper.setDataSetHeader(dSet, "H_GIFT_AMT_TYPE");
			list = dao.getEtcCodeSub_Amt(form);
			helper.setListToDataset(list, dSet); 
 
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }

	 public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
	            HttpServletRequest request, HttpServletResponse response)
	            throws Exception {

	        List list = null;
	        GauceHelper2 helper = null;
	        GauceDataSet dSet = null;
	        MGif119DAO dao = null;

	        String strGoTo = form.getParam("goTo"); // 분기할곳

	        try {
	            dao = new MGif119DAO();
	            helper = new GauceHelper2(request, response, form);
	            dSet = helper.getDataSet("DS_O_MASTER");
	            helper.setDataSetHeader(dSet, "H_MASTER");
	            list = dao.searchMaster(form);
	            helper.setListToDataset(list, dSet);

	        } catch (Exception e) {
	            e.printStackTrace();
	            logger.error("", e);
	            helper.writeException("GAUCE", "101", e.getMessage());
	        } finally {
	            helper.close(dSet);
	        }
	        return mapping.findForward(strGoTo);
	    }
}