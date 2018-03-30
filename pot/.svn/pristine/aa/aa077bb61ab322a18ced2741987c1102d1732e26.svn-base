/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package common.action;

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

import com.gauce.GauceDataSet;
import common.dao.CCom400DAO;


/**
 * <p>가맹점 찾기  팝업</p>
 * 
 * @created  on 1.0, 2010/01/25	
 * @created  by 남형석
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom400Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom400Action.class);

    /**
     * <p>
     * 분류 코드 Pop-up 헤더
     * </p>
     *
     * <p>
     * 분류 코드 Pop-up 헤더 정보를 가져온다.
     * </p>
     */
	
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception 
    {
        GauceHelper2  helper = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
      
        try 
        {
            GauceHelper2.initialize(form, request, response);
        } 
        catch (Exception e) 
        {
            logger.error("", e);
            helper.writeException("GAUCE","002",e.getMessage());
        }
        return mapping.findForward(strGoTo);
    }

    /**
     * <p>분류 조회 Pop</p>
     *
     * <p>분류 조회 Pop</p>
     */
    
    
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom400DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new CCom400DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MASTER");
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


}
