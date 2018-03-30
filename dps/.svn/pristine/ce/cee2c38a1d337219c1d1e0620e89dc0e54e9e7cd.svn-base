/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.action;

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

import pord.dao.POrd102DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p> 규격단품 매입발주 등록 </p>                                                   
 * 
 * @created  on 1.0, 2010/02/16                              
 * @created  by 김경은 
 *  
 * @modified on    
 * @modified by                                      
 * @caused   by     
 */                           

public class POrd102Action extends DispatchAction {
	/*                                                        
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd102Action.class);

	/**            
	 * <p> 규격단품 매입발주 등록 화면 </p>                                          
	 * 
	 */                                                   
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			HttpSession session     = request.getSession();
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
	 * <p> 규격단품 매입발주 리스트 조회 </p>
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
		POrd102DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new POrd102DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list   = dao.getList(form, userId, org_flag); 
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
	 * <p> 규격단품 매입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd102DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd102DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet[0], "H_MASTER");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet[1], "H_DETAIL");
			
			list    = dao.getDetail(form);        
			for(int i=0;i<list.length;i++){          
				helper.setListToDataset(list[i], dSet[i]);
			}
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 단품코드 상세정보 조회 </p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		POrd102DAO dao 		= null;

		String strGoTo 		= form.getParam("goTo"); // 분기할곳

		try {
			dao 	= new POrd102DAO(); 
			helper 	= new GauceHelper2(request, response, form);
			dSet 	= helper.getDataSet("DS_O_SKU_INFO");
			helper.setDataSetHeader(dSet, "H_SKU_INFO"); 
			
			list 	= dao.getSkuInfo(form); 
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
	 * <p> 규격단품 매입발주 등록/수정/삭제 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd102DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		String strMessage   = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_DETAIL"); 
			  
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			helper.setDataSetHeader(dSet[1], "H_DETAIL");
			  
			MultiInput mi1 = helper.getMutiInput(dSet[0]);
			MultiInput mi2 = helper.getMutiInput(dSet[1]); 
			 
			dao = new POrd102DAO();    
			// 등록및수정, 삭제 분기
			if(form.getParam("strFlag").equals("save")){ 
				ret = dao.save(form, mi1, mi2, userId, org_flag);
				strMessage = "저장되었습니다.";
			}else{
				ret = dao.delete(form, userId);
				strMessage = "삭제되었습니다.";
			}  
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, strMessage); 
		}
		return mapping.findForward("save");
	}
	
	
	public ActionForward filePop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
    	List list 			 = null;
    	GauceHelper2  helper = null;
		POrd102DAO dao 		 = null;
		GauceDataSet dSet 	 = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

			GauceHelper2.initialize(form, request, response); 
        
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(strGoTo, e);
            helper.writeException("GAUCE","002",e.getMessage());
        }
		return mapping.findForward(strGoTo);
	}
	
}
