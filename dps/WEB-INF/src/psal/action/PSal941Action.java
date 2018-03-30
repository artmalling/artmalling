/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package psal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import kr.fujitsu.ffw.base.BaseProperty;

import org.apache.log4j.Logger;

import psal.dao.PSal941DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
import ksnet.SignPad;

/**
 * <p>전자서명 Action</p>
 * 
 * @created  on 1.0, 2010/06/09
 * @created  by 김영진 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal941Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal941Action.class);

	/**
	 * <p>전자서명 조회 화면으로 이동한다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		try {
			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}
   
		return mapping.findForward("list");
	}

	
	/**
     * <p>전자서명을 조회한다.</p>
     * 
     */      
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal941DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal941DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_MASTER");
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
     * <p>전자서명을 조회한다.</p>
     * 
     */      
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal941DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal941DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");            
            list   = dao.searchDetail(form);
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
     * <p>전자서명을 조회한다.</p>
     * 
     */      
    public ActionForward searchSignbmp(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
		
        try { 
            helper = new GauceHelper2(request, response, form);
            
            GauceDataSet pSet = helper.getDataSet("DS_I_DATA");
            String signData   	= pSet.getDataRow(0).getColumnValue(0).toString();
            System.out.println(signData);
            //SignbmpJni jt = new SignbmpJni();
            SignPad sp    = new SignPad();
            
            //int result = sp.saveToBMP(signData, "C:/java/data_in/dps/mnt/image/sign.bmp");
            int result = sp.saveToBMP(signData, BaseProperty.get("signImgPath") + "sign.bmp");
            
            //System.out.println(BaseProperty.get("signImgPath") +"sign.bmp");
            //System.out.println(result);
            //int result = jt.KSNET_SIGNBMP_EXTRACT(signData, signData.length(), "");
        } catch (Exception e) {
        	e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(strGoTo);
    }

}
