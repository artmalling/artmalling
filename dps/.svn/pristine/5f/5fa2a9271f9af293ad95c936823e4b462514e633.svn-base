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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import psal.dao.PSal538DAO;
import psal.dao.PSal901DAO;
import psal.dao.PSal917DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>카드매출 데이터 Action</p>
 * 
 * @created  on 1.0, 2010/05/31	
 * @created  by 김영진 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal917Action extends DispatchAction { 
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal917Action.class);

	/**
	 * <p>카드매출 데이터 조회 화면으로 이동한다.</p>
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
     * <p>카드매출 데이터를 조회한다.</p>
     * 
     */      
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal917DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal917DAO();
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
    public ActionForward saveData(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
    	
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal917DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입)     
		int ret             = 0;
		String res		    = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_MASTER");
                   
            helper.setDataSetHeader(dSet[0], "H_MASTER");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal917DAO();    
			res = dao.saveData(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], res);
		}
		return mapping.findForward("valCheck");
	} 
    
	/**
	 * <p> 점별 VANID 공통코드 조회  </p>
	 * 
	 */
	public ActionForward searchVanId(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	        
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
	
		List list			= null;
		PSal917DAO dao     = null; 
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
	
		try {
						
			dao    = new PSal917DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_VANID");   
			helper.setDataSetHeader(dSet, "H_SEL_VANID_CODE");  
			list   = dao.searchVanId(form); 
						
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
