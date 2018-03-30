/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.action;

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

import ppay.dao.PPay110DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>전자세금계산서 조회</p>
 * 
 * @created  on 1.0, 2010/04/11
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by         
 */

public class PPay110Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PPay110Action.class);

	/**
	 * <p>전자세금계산서 조회</p>
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
	 * <p> 매입세금계산서 마스터 데이터 조회  </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PPay110DAO dao 		= null;
		                       
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PPay110DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list   = dao.getMaster(form, userId, org_flag);                  
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
	 * <p> 매입세금계산서 디테일 데이터 조회  </p> 
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;      
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;                
		PPay110DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new PPay110DAO();              
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[1];
			
			list    = new  List[1];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_DETAIL");
			
			System.out.println("디테일 넘어오나");
			list    = dao.getDetail(form);        
			for(int i=0;i<list.length;i++){          
				helper.setListToDataset(list[i], dSet[i]);
			}
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet[0]);
		}
		return mapping.findForward(strGoTo);
	}
}
