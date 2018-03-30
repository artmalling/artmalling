/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
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

import common.vo.SessionInfo;

import mcae.dao.MCae610DAO;



/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/01/18
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2010/03/02
 * @modified by 김영진
 * @caused   by OKCASHBAG상품권교환 추가
 */

public class MCae610Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae610Action.class);

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
     * <p>상품권교환 리스트를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
        MCae610DAO   dao    = null; 
         
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        String strCardNo = form.getParam("strCardNo"); // 카드번호
        
        try {
            dao    = new MCae610DAO();
            helper = new GauceHelper2(request, response, form);
			dSet   = new  GauceDataSet[2];
			list   = new  List[2];

			
			
			dSet[0] = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet[0], "H_TODAY");
			list  = dao.searchMaster(form);
			helper.setListToDataset(list[0],  dSet[0]);
			
			dSet[1] = helper.getDataSet("DS_O_CUSTDETAIL");
			helper.setDataSetHeader(dSet[1], "H_CUSTDETAIL");
			list  = dao.searchMaster(form);
			helper.setListToDataset(list[1],  dSet[1]);
			
			
        	
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
    }
    
	 /**
     * <p>상품권금액을 조회한다.</p>
     * 
     */
    public ActionForward check_cnt(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae610DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae610DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_CNT");
			helper.setDataSetHeader(dSet, "H_CNT");
			list = dao.check_cnt(form);
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
     * <p>상품권 교환 소켓통신 및 저장</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        MCae610DAO dao      = null;
        GauceDataSet dSet[] = null;
        List list           = null;
		int ret          = 0;
        int rtnCode         = 0;
        String rtnMsg       = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        HttpSession session = request.getSession();
        
        try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
                
			helper = new GauceHelper2(request, response, form); 
			dSet = new GauceDataSet[1];

			dSet[0] = helper.getDataSet("DS_I_MASTER");

            helper.setDataSetHeader(dSet[0], "H_MASTER");	

            MultiInput mi[] = new MultiInput[1];

			mi[0] = helper.getMutiInput(dSet[0]);

			dao = new MCae610DAO();    

			ret = dao.save(form, mi, request);

		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			helper.close(dSet[0], "지급 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
    }	
    
    public ActionForward delete(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        MCae610DAO dao      = null;
        GauceDataSet dSet[] = null;
        List list           = null;
		int ret          = 0;
        int rtnCode         = 0;
        String rtnMsg       = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        HttpSession session = request.getSession();
        
        try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			System.out.println("111111111111111111111111111111");
			helper = new GauceHelper2(request, response, form); 
			dSet = new GauceDataSet[1];

			dSet[0] = helper.getDataSet("DS_O_MASTER");

            helper.setDataSetHeader(dSet[0], "H_TODAY");	

            MultiInput mi[] = new MultiInput[1];

			mi[0] = helper.getMutiInput(dSet[0]);

			dao = new MCae610DAO();    

			ret = dao.delete(form, mi, request);

		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			helper.close(dSet[0], "삭제되었습니다");
		}
		return mapping.findForward(strGoTo);
    }
    
}

