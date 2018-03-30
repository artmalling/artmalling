/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
  
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;  
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import pcod.dao.PCodA02DAO;   

import com.gauce.GauceDataSet;  


/**
 * <p>백화점영업관리> 기준정보> 기타관리> EOD로그조회  </p>
 * 
 * @created  on 1.0, 2010/08/04
 * @created  by 김경은
 * 
 * 
 * @modified on    
 * @modified by 
 * @caused   by 
 */

public class PCodA02Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCodA02Action.class);

	/**
	 * <p>화면를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	/** 
	 * <p>
	 * 마스터를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null; 
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodA02DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCodA02DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.searchMaster(form);
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
     * 공통코드를 조회한다.(프로세스)
     * </p>
     *
     * <p>
     * 공통코드관련된 내용을 하나의 SQL을 이용하여 처리한다.
     * </p>
     */
    public ActionForward getProcId(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;  
        GauceDataSet dSet   = null;
        PCodA02DAO   dao   = null;
        MultiInput   mi     = null;

        try {
            helper = new GauceHelper2(request, response, form);

            dao = new PCodA02DAO();
            
            helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_PROC_ID");
			helper.setDataSetHeader(dSet, "H_PROC_ID");
			list = dao.getProcId(form);
			            
            if (list != null) {
                helper.setListToDataset(list, dSet);
            }
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward("getEtcCode");
    }
}
