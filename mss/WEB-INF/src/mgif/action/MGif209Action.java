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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import mgif.dao.MGif209DAO;
import mren.dao.MRen102DAO;

import com.gauce.GauceDataSet;

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

public class MGif209Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif209Action.class);

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
	 * <p>
	 * 사고/해지 등록 조회
	 * </p>
	 * 
	 */                  
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//System.out.println("1");
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif209DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
    
		try {
			dao = new MGif209DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
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
	 * <p>상품권종류&금종 조회</p>
	 */
    @SuppressWarnings("rawtypes")
	public ActionForward getEtcCodeSub(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MGif209DAO dao		= null;
        String strGoTo = form.getParam("goTo");
        try {
        	String strDSName	= String2.nvl(form.getParam("strDSName"));	// 데이터셋명
        	helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet(strDSName);			
            helper.setDataSetHeader(dSet, "H_ETCCODE");

            dao = new MGif209DAO();
            list = dao.getEtcCodeSub(form);
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
	 * <p>
	 * 상품권번호에 대한 상품권종류&금종&상품권금액  조회
	 * </p>
	 * 
	 */                  
	public ActionForward getSpno(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//System.out.println("1");
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif209DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
    
		try {
			dao = new MGif209DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_SPNO");
			list = dao.getSpno(form);
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
     * <p>사고/해지등록 저장</p>
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {

        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MGif209DAO dao		= null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = null;
        String strGoTo = form.getParam("goTo");
        try {
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new MGif209DAO();
            ret = dao.save(form, mi, userId);
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet, ret + "건 처리되었습니다");
        }
        return mapping.findForward(strGoTo);
    }

}