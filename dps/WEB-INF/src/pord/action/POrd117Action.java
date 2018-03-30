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

import pord.dao.POrd101DAO;
import pord.dao.POrd117DAO;
import pord.dao.POrd506DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p> 규격단품 매입발주 등록 </p> 
 * 
 * @created  on 1.0, 2010/02/16
 * @created  by 신명섭
 *  
 * @modified on 
 * @modified by     
 * @caused   by 
 */

public class POrd117Action extends DispatchAction {
	/*              
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd117Action.class);

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
	   	POrd117DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new POrd117DAO(); 
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
		POrd117DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd117DAO();
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
	 * <p> 규격단품 대출입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd117DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd117DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = new GauceDataSet[3];
			             
			list = new  List[3];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER1");     
			helper.setDataSetHeader(dSet[0], "H_MASTER1");         
			dSet[1] = helper.getDataSet("DS_IO_DETAIL1");
			helper.setDataSetHeader(dSet[1], "H_DETAIL1");
			dSet[2] = helper.getDataSet("DS_IO_DETAIL2");
			helper.setDataSetHeader(dSet[2], "H_DETAIL1");
			               
			list = dao.getDetail1(form);                

			for(int i=0;i<list.length;i++){
				helper.setListToDataset(list[i], dSet[i]);
				System.out.println("list:::::"+list[i].size());
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
	 * <p> 의류단품 점출입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail3(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd117DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd117DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER3");
			helper.setDataSetHeader(dSet[0], "H_MASTER3");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL3");
			helper.setDataSetHeader(dSet[1], "H_DETAIL3");
			
			list    = dao.getDetail3(form);        
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
	 * <p> 매가인상하발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail4(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd117DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd117DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER4");
			helper.setDataSetHeader(dSet[0], "H_MASTER4");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL4");
			helper.setDataSetHeader(dSet[1], "H_DETAIL4");
			
			list    = dao.getDetail4(form);        
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
	 * <p> ORDER SHEET 마스터 조회 </p>
	 * 
	 */
	public ActionForward getMaster5(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd117DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd117DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER5");
			helper.setDataSetHeader(dSet, "H_MASTER5");
			list = dao.getMaster5(form); 
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
	 * <p> ORDER SHEET 디테일 조회  </p> 
	 * 
	 */
	public ActionForward getDetail5(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd117DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd117DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL5");
			helper.setDataSetHeader(dSet, "H_DETAIL5");
			list = dao.getDetail5(form);
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
	 * <p>품목 매입발주 매입/반품  디테일 내용을 조회한다.</p>
	 * 
	 */
	public ActionForward getMaster6(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd117DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd117DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER6");
			helper.setDataSetHeader(dSet, "H_MASTER6");
			list = dao.getMaster6(form);
			//System.out.println("list size : "+ list.size());
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
	 *  <p>품목 매입발주 매입/반품  디테일 내용을 조회한다.</p>
	 * 
	 */
	public ActionForward getDetail6(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd117DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd117DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL6");
			helper.setDataSetHeader(dSet, "H_DETAIL6");
			list = dao.getDetail6(form);
//			System.out.println("list size : "+ list.size());
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
