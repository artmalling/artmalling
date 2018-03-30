/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.action;

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
import pcod.dao.PCod304DAO;

import org.apache.log4j.Logger;

import pcod.dao.PCod304DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on  1.1, 2010/02/14
 * @modified by  박종은(FUJITSU KOREA LTD.)
 * @caused   by 
 */

public class PCod304Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod304Action.class);

	/**
	 * <p>페이지를 로드한다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}


	/** 
	 * <p>
	 * 마진 마스터를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchMaster(form);
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
	 * 정상마진정보를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
			list = dao.searchDetail(form);
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
	 * 행사마진정보를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL2");
			list = dao.searchDetail2(form);
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
	 * 점별품번의 최저마진율을 조회한다
	 * </p>
	 * 
	 */
	public ActionForward searchMargin(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MARGIN");
			helper.setDataSetHeader(dSet, "H_SEL_MARGIN");
			list = dao.searchMargin(form);
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
	 * 점별품번, 행사구분의 db 중복  조회한다
	 * </p>
	 * 
	 */
	public ActionForward searchDBMargin(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CHK");
			helper.setDataSetHeader(dSet, "H_SEL_CHK");
			list = dao.searchDBMargin(form);
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
	 * 마진마스터 저장/수정
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod304DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_SEL_DETAIL");
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			dao = new PCod304DAO();
			
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 마진구분 정보를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMgInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MG_INFO");
			helper.setDataSetHeader(dSet, "H_SEL_MGINFO");
			list = dao.searchMgInfo(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);

	}
	
	public ActionForward searchPumbunCheck(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod304DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod304DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_PUMBUN_CHECK");
			helper.setDataSetHeader(dSet, "H_SEL_PUMBUNINFO");
			list = dao.searchPumbunCheck(form);
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
	 * <p> 전송처리 </p> 
	 * 
	 */
	public ActionForward sendmgemg(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

        int rst = 0;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        PCod304DAO dao = null;
        HttpSession session = request.getSession();
        String userId = null;        

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
        	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
          
            dao = new PCod304DAO();
            helper = new GauceHelper2(request, response, form);
           
            rst = dao.sendmgemg(form, userId);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
	}    	
}
