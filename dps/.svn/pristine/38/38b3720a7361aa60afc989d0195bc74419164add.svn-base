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

import psal.dao.PSal701DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
                   
/**
 * <p>평가항목배점관리</p>                                 
 *                                       
 * @created  on 1.0, 2011/06/13            
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                                                    
 * @caused   by 
 */                                                                            
                         
public class PSal701Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal701Action.class);
                         
	/**
	 * <p>평가항목배점관리 화면 </p>                      
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
	 * <p> 평가항목배점관리 리스트 조회  </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PSal701DAO dao 		= null;
		                       
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo"); 
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PSal701DAO(); 
			helper = new GauceHelper2(request, response, form);    
			dSet   = helper.getDataSet("DS_O_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list   = dao.getList(form);                             
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
	 * <p> 평가항목배점관리 마스터 조회  </p>
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
		PSal701DAO dao 		= null;
		                       
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PSal701DAO(); 
			helper = new GauceHelper2(request, response, form);    
			dSet   = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_LIST");
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
	 * <p> 평가항목배점관리 저장  </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal701DAO dao      = null;     
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");

            helper.setDataSetHeader(dSet[0], "H_LIST");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal701DAO();    
			// 등록및수정
			if(form.getParam("strFlag").equals("save")){ 
				ret = dao.save(form, mi1, userId, org_flag);
			}
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], "저장되었습니다"); 
		}
		return mapping.findForward("save");
	}
	
	/**
	 * <p> 평가항목배점관리 삭제  </p> 
	 *  
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal701DAO dao      = null;     
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_LIST");                       

            helper.setDataSetHeader(dSet[0], "H_LIST");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal701DAO();               

			ret = dao.delete(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());         
		} finally {
//			helper.close(dSet[0], ret + "건 처리되었습니다");
			helper.close(dSet[0], "삭제되었습니다.");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 평가항목배점관리 저장(전월내역복사)  </p> 
	 * 
	 */
	public ActionForward copy(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PSal701DAO dao      = null;       
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {  
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();  
			org_flag = sessionInfo.getORG_FLAG();                  
			  
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_LIST");  

            helper.setDataSetHeader(dSet[0], "H_LIST");

			MultiInput mi1 = helper.getMutiInput(dSet[0]);

			dao = new PSal701DAO();    
			ret = dao.copy(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[0], "전월내역이 복사 되었습니다"); 
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 평가항목배점관리 확정여부  </p>
	 * 
	 */
	public ActionForward confCheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		PSal701DAO dao 		= null;
		                       
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo"); 
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new PSal701DAO(); 
			helper = new GauceHelper2(request, response, form);    
			dSet   = helper.getDataSet("DS_O_CHECK");  
			helper.setDataSetHeader(dSet, "H_CHECK");
			list   = dao.confCheck(form);                             
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
