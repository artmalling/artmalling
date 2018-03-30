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
import common.dao.CCom430DAO;

/**
 * <p>우편번호 팝업(신주소/구주소)</p>
 * 우편번호 조회 팝업화면의 DAO함수를 Call하고 
 * jsp에 응답하는 Controller기능의 Action
 * 
 * @created  on 1.0, 2010/05/11
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom430Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom430Action.class);

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

    public ActionForward getOldAddr(ActionMapping mapping, ActionForm form,
      HttpServletRequest request, HttpServletResponse response)
      throws Exception 
    {
    	List list = null;
    	GauceHelper2  helper = null;
    	GauceDataSet  dSet[] = null;
    	CCom430DAO    dao   = null;
    	MultiInput    mi     = null;
    	
    	String strGoTo = form.getParam("goTo"); // 분기할곳
    	
    	try 
    	{
    		helper = new GauceHelper2(request, response, form);
    		dSet = new GauceDataSet[2];
    		dSet[0] = helper.getDataSet("DS_I_POPUP");
    		dSet[1] = helper.getDataSet("DS_O_POPUP");
      
    		mi = helper.getMutiInput(dSet[0]);
    		helper.setDataSetHeader(dSet[1],  "H_SEL_ADDR");
      
    		dao = new CCom430DAO();
    		list = dao.getOldAddr(form,mi);
    		helper.setListToDataset(list, dSet[1]);      
    	} 
    	catch (Exception e) 
    	{
    		logger.error("", e);
    		helper.writeException("GAUCE", "002", e.getMessage());
    	} 
    	finally 
    	{
    		helper.close(dSet);
    	}
    	return mapping.findForward(strGoTo);
    }


	public ActionForward getNewAddr(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom430DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_POPUP");
			dSet[1] = helper.getDataSet("DS_O_POPUP");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_SEL_POPUP");

			dao = new CCom430DAO();
			list = dao.getNewAddr(form, mi);
			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	
	/**
     * <p> 시도,시군구 콤보 조회 </p>
     */
    public ActionForward getEtcCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom430DAO   dao    = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
         
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");
            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMMON");
            dao = new CCom430DAO(); 
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
