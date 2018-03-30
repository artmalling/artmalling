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

import pord.dao.POrd505DAO;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/10
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd505Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd505Action.class);

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
	 * <p>  </p>
	 * 
	 */
	public ActionForward popUpList(ActionMapping mapping, ActionForm form,
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
			logger.error("[popUpList]", e);
		}  

		return mapping.findForward("popUpList");
	}
	
	                    
	/**
	 * <p> INVOICE 리스트 조회 </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		POrd505DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();
		org_flag 				= sessionInfo.getORG_FLAG();

		try {
			dao = new POrd505DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list = dao.getList(form, userId, org_flag); 
			
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
	 * <p> INVOICE 마스터 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd505DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd505DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			list = dao.getMaster(form); 
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
	 * <p> INVOICE 디테일 조회  </p> 
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd505DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd505DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getDetail(form);
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
	 * <p> INVOICE 등록/수정/삭제 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String msg = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		 
		POrd505DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null; 
		String ord_flag = null; 

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId     = sessionInfo.getUSER_ID();
			ord_flag   = sessionInfo.getORG_FLAG();
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_DETAIL"); 
			  
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			helper.setDataSetHeader(dSet[1], "H_DETAIL");
			  
			MultiInput mi1 = helper.getMutiInput(dSet[0]);
			MultiInput mi2 = helper.getMutiInput(dSet[1]); 
			 
			dao = new POrd505DAO();    
			// 등록및수정, 삭제 분기
			if(form.getParam("strFlag").equals("save")){
				ret = dao.save(form, mi1, mi2, userId, ord_flag);
				msg = "저장되었습니다.";
			}else{
				ret = dao.delete(form, userId);
				msg = "삭제되었습니다.";
			}  			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, msg); 
		}
		return mapping.findForward("save");
	}

    /**
     * <p>
     * OFFER_NO 팝업
     * </p>
     */
    public ActionForward getOfferNoPopup(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
    }    

	/**
	 * <p>
	 * 팝업에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

	List list = null;
	GauceHelper2 helper = null;
	GauceDataSet dSet = null;
	POrd505DAO dao = null;
	
	String strGoTo = form.getParam("goTo"); // 분기할곳
	
	try {
	
		dao = new POrd505DAO();
		helper = new GauceHelper2(request, response, form);
		dSet = helper.getDataSet("DS_O_RESULT");
		helper.setDataSetHeader(dSet, "H_OFFERINFO");
		list = dao.searchOnPop(form);
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
	 * <p>
	 * OFFER_NO 팝업 없이 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnWithoutPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

	List list = null;
	GauceHelper2 helper = null;
	GauceDataSet dSet = null;
	POrd505DAO dao = null;
	
	String strGoTo = form.getParam("goTo"); // 분기할곳
	
	try {
	
		dao = new POrd505DAO();
		helper = new GauceHelper2(request, response, form);
		dSet = helper.getDataSet("DS_O_RESULT");
		helper.setDataSetHeader(dSet, "H_OFFERINFO");
		list = dao.searchOnPop(form);
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
	 * <p> 단품코드 상세정보 조회 </p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		POrd505DAO dao 		= null;

		String strGoTo 		= form.getParam("goTo"); // 분기할곳

		try {
			dao  = new POrd505DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_SKU_INFO");
			helper.setDataSetHeader(dSet, "H_SKU_INFO");
			list = dao.getSkuInfo(form);

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
	 * <p> OFFER NO 수기입력시 정보 가져온다 </p>
	 * 
	 */
	public ActionForward getOfferNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		POrd505DAO dao 		= null;

		String strGoTo 		= form.getParam("goTo"); // 분기할곳

		try {
			dao 	= new POrd505DAO(); 
			helper 	= new GauceHelper2(request, response, form);
			dSet 	= helper.getDataSet("DS_O_OFFER_INFO");
			helper.setDataSetHeader(dSet, "H_OFFER_INFO"); 
			
			list 	= dao.getOfferNo(form); 
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
	 * <p>OFFER에 등록된 단품 정보 조회.</p>
	 * 
	 */
	public ActionForward getOffSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd505DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			dao = new POrd505DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_SKU_INFO");
			helper.setDataSetHeader(dSet, "H_SKU_INFO");
			list = dao.getOffSkuInfo(form);
			
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
	 * <p>INVOICE_NO 조회.</p>
	 * 
	 */
	public ActionForward checkInvoiceNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd505DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			dao = new POrd505DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_INVOICE_INFO");
			helper.setDataSetHeader(dSet, "H_INVOICE_INFO");
			list = dao.checkInvoiceNo(form);			
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
	 * <p> INVOICE 체크사항 </p>
	 * 
	 */
	public ActionForward chkInvoiceStat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;
		POrd505DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		try {
			dao = new POrd505DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_INVOICE_STAT");
			helper.setDataSetHeader(dSet, "H_INVOICE_STAT");
			list = dao.chkInvoiceStat(form); 
			
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
