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

import pord.dao.POrd503DAO;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p></p> 
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd503Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd503Action.class);

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
	 * <p> 의류단품 매입발주 등록 - 엑셀업로드 팝업 </p>
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
	 * <p> 규격단품 매입발주 리스트 조회 </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd503DAO dao = null;

		String userId 		= null;  
		String org_flag 		= null;  
		String strGoTo = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();

		try {
			
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag                = sessionInfo.getORG_FLAG();
			
			dao = new POrd503DAO(); 
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
	 * <p> ORDER SHEET 마스터 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd503DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd503DAO(); 
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
	 * <p> ORDER SHEET 디테일 조회  </p> 
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd503DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd503DAO();
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
	 * <p> ORDER SHEET 등록/수정/삭제 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String msg = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		 
		POrd503DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null; 

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_DETAIL"); 
			  
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			helper.setDataSetHeader(dSet[1], "H_DETAIL");
			  
			MultiInput mi1 = helper.getMutiInput(dSet[0]);
			MultiInput mi2 = helper.getMutiInput(dSet[1]); 
//			System.out.println("신규타나");
			 
			dao = new POrd503DAO();    
			// 등록및수정, 삭제 분기
			if(form.getParam("strFlag").equals("save")){
				ret = dao.save(form, mi1, mi2, userId);
				msg = "저장되었습니다.";
			}else{
				ret = dao.delete(form, userId);
				msg = "삭제되었습니다.";
			}  
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, msg); 
		}
		return mapping.findForward("save");
	}

	

	/**
	 * <p>
	 * 팝업에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOfferrNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

	List list = null;
	GauceHelper2 helper = null;
	GauceDataSet dSet = null;
	POrd503DAO dao = null;
	
	String strGoTo = form.getParam("goTo"); // 분기할곳
	
	try {
	
		dao = new POrd503DAO();
		helper = new GauceHelper2(request, response, form);
		dSet = helper.getDataSet("DS_O_OFFERNO");
		helper.setDataSetHeader(dSet, "H_OFFERNO");
		list = dao.searchOfferrNo(form);
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
     * 행사테마 팝업
     * </p>
     */
    public ActionForward getOrderNoPopup(ActionMapping mapping, ActionForm form,
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
	POrd503DAO dao = null;
	
	String strGoTo = form.getParam("goTo"); // 분기할곳
	
	try {
	
		dao = new POrd503DAO();
		helper = new GauceHelper2(request, response, form);
		dSet = helper.getDataSet("DS_O_RESULT");
		helper.setDataSetHeader(dSet, "H_ORDERINFO");
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
	 * 팝업에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOrderNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

	List list = null;
	GauceHelper2 helper = null;
	GauceDataSet dSet = null;
	POrd503DAO dao = null;
	
	String strGoTo = form.getParam("goTo"); // 분기할곳
	
	try {
	
		dao = new POrd503DAO();
		helper = new GauceHelper2(request, response, form);
		dSet = helper.getDataSet("DS_O_ORDERNO");
		helper.setDataSetHeader(dSet, "H_ORDERNO");
		list = dao.searchOrderNo(form);
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
	 * Popup.js 에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnWithoutPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

	List list = null;
	GauceHelper2 helper = null;
	GauceDataSet dSet = null;
	POrd503DAO dao = null;
	
	String strGoTo = form.getParam("goTo"); // 분기할곳
	
	try {
	
		dao = new POrd503DAO();
		helper = new GauceHelper2(request, response, form);
		dSet = helper.getDataSet("DS_O_RESULT");
		helper.setDataSetHeader(dSet, "H_ORDERINFO");
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
	 * <p>단품 매가원가 조회.</p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd503DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd503DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_SKU_SALEPRC");
			helper.setDataSetHeader(dSet, "H_SKU_SALEPRC");
			list = dao.getSkuInfo(form);
			
			System.out.println("list size : "+ list.size());
			helper.setListToDataset(list, dSet);

			System.out.println("lwqerqwerqwer : "+ helper.setListToDataset(list, dSet));

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
	public ActionForward checkTreatmentOffNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd503DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new POrd503DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_CHECKTREATMENTOFF_NO");
			helper.setDataSetHeader(dSet, "H_CHECKTREATMENTOFF_NO");
			list = dao.checkTreatmentOffNo(form); 
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
