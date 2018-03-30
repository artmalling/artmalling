/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;



import com.gauce.GauceDataSet;

import dctm.dao.DCtm428DAO;

import common.vo.SessionInfo;
/**
 * <p>고객수신동의수신현황조회</p>
 * 
 * @created  on 1.0, 2012.05.23
 * @created  by 강진(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2012.05.23
 * @modified by 
 * @caused   by 고객수신동의송신현황조회
 */

public class DCtm428Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm428Action.class);

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
	
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list			= null;
		DCtm428DAO dao 		= null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳                            

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	
			dao    = new DCtm428DAO();  
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");                    
			list   = dao.searchMaster(form); 
			
			for (int j = 0; j < list.size(); j++) {
                List tmplist = (List) list.get(j);
                String mp1 = tmplist.get(7).toString(); //MOBILE_PH1
                String mp2 = tmplist.get(8).toString(); //MOBILE_PH2
                String mp3 = tmplist.get(9).toString(); //MOBILE_PH3
                
                String em1 = tmplist.get(10).toString(); //EMAIL1
                String em2 = tmplist.get(11).toString(); //EMAIL2
                if (mp1.length() > 0 || mp2.length() > 0 || mp3.length() > 0) {
                    tmplist.set(5, mp1 + "-" +mp2 + "-" + mp3); //MOBILE_PH1
                }
                
                if (em1.length() > 0 || em2.length() > 0) {
                    tmplist.set(6, em1 + "@" +em2); //EMAIL1
                }
                list.set(j, tmplist);
            }			
			
			helper.setListToDataset(list, dSet);            

		} catch (Exception e) {
			logger.error("", e);                       
			System.out.println(e.getMessage());
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}        
		return mapping.findForward(strGoTo);
	}
}
