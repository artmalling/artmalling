/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

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
import mgif.dao.MGif207DAO;
import org.apache.log4j.Logger;
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

public class MGif207Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

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
	 * <p>반품 전표별 조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif207DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
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
	 * <p>상품권번호 금종 조회</p>
	 * 
	 */
	public ActionForward getGiftAmttype(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif207DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_AMT_TYPE");
			list = dao.getGiftAmttype(form);
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
	 * <p>상품권번호 금종 조회</p>
	 * 
	 */
	public ActionForward getGiftNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif207DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT_NO");
			helper.setDataSetHeader(dSet, "H_GIFT_NO");
			list = dao.getGiftNo(form);
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
	 * <p>반품 전표별 상세내역 조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif207DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_DETAIL");
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
	 * <p>반품등록전표 저장/수정 </p>	
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);			
			dSet = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			
			MultiInput mi = helper.getMutiInput(dSet);			
			dao = new MGif207DAO();	
			
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}		
		return mapping.findForward("save");
	}
	
	/**
	 * <p>반품등록전표 삭제</p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");	
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);					
			dSet = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			
			MultiInput mi = helper.getMutiInput(dSet);	
			dao = new MGif207DAO();
			ret = dao.delete(form, mi, userId);		
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close("처리되었습니다");
		}
		return mapping.findForward("delete");
	}
	
	/**
	 * <p>반품등록전표 확정</p>	
	 */
	public ActionForward conf(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");	
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);		
			dSet = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			
			MultiInput mi = helper.getMutiInput(dSet);	
			dao = new MGif207DAO();			
			ret = dao.conf(form, mi, userId);		
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close("반품확정 되었습니다");
		}
		return mapping.findForward("conf");
	}
	
	/**
	 * <p>상품권상태정보 조회</p>
	 * 
	 */
	public ActionForward getGiftStat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif207DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getGiftStat(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			helper.writeException("GAUCE", "002", e.getMessage());	
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	
	/**
	 * <p>유효 상품권정보 조회</p>
	 * 
	 */
	public ActionForward getGiftCnt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif207DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MGif207DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_GIFT_CNT");
			helper.setDataSetHeader(dSet, "H_GIFTCARD_CNT");
			list = dao.getGiftCnt(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			helper.writeException("GAUCE", "002", e.getMessage());	
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
}
