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

import org.apache.log4j.Logger;

import pcod.dao.PCod221DAO;
import pcod.dao.PCod304DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p>백화점영업관리> 기준정보> 브랜드코드> 브랜드관리</p>
 * 
 * @created  on 1.0, 2010/02/16
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod221Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod221Action.class);

	/**
	 * <p>브랜드를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}

	/** 
	 * <p>
	 * 브랜드 마스터를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod221DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_PBN_COND");
			dSet[1] = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet[1], "H_SEL_MASTER");
			dao = new PCod221DAO();
			MultiInput mi = new MultiInput(dSet[0]);			
			list = dao.searchMaster(form, mi);
			helper.setListToDataset(list, dSet[1]);

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
	 * 브랜드관리품목을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPbnpmk(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod221DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_PBNPMK");
			helper.setDataSetHeader(dSet, "H_SEL_PBNPMK");
			dao = new PCod221DAO();		
			list = dao.searchPbnpmk(form);
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
	 * 점별 브랜드을 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchStrpbn(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod221DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_STRPBN");
			helper.setDataSetHeader(dSet, "H_SEL_STRPBN");
			dao = new PCod221DAO();		
			list = dao.searchStrpbn(form);
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
	 * 협력사담당자를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchPbnvenemp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod221DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_PBNVENEMP");
			helper.setDataSetHeader(dSet, "H_SEL_PBNVENEMP");
			dao = new PCod221DAO();		
			list = dao.searchPbnvenemp(form);
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
	 * 브랜드정보
	 * 저장/수정
	 * </p>
	 * 
	 */
	public ActionForward savePbnmst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod221DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_MASTER");
			
			MultiInput mi = new MultiInput(dSet);			
			dao = new PCod221DAO();			
			ret = dao.savePbnmst(form, mi, userId);
			
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
	 * 점별 브랜드, 브랜드별 품목, 브랜드별 협력사 담당자
	 * 저장/수정/삭제
	 * </p>
	 * 
	 */
	public ActionForward saveDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod221DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			dao = new PCod221DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_PBNPMK");			
			MultiInput mi = new MultiInput(dSet);	
			
			ret = dao.savePbnpmk(form, mi, userId);	
			
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_STRPBN");			
			mi = new MultiInput(dSet);	
			
			ret += dao.saveStrpbn(form, mi, userId);	

			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_PBNVENEMP");			
			mi = new MultiInput(dSet);	
			
			ret += dao.savePbnvenemp(form, mi, userId);	

			
			
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
	 * <p> 전송처리 </p> 
	 * 
	 */
	public ActionForward sendpbnemg(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

        int rst = 0;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        PCod221DAO dao = null;
        HttpSession session = request.getSession();
        String userId = null;        

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
        	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
          
            dao = new PCod221DAO();
            helper = new GauceHelper2(request, response, form);
           
            rst = dao.sendpbnemg(form, userId);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
	}    	

	/**
	 * <p> 전송처리 </p> 
	 * 
	 */
	public ActionForward sendpmkemg(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

        int rst = 0;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        PCod221DAO dao = null;
        HttpSession session = request.getSession();
        String userId = null;        

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
        	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
          
            dao = new PCod221DAO();
            helper = new GauceHelper2(request, response, form);
           
            rst = dao.sendpmkemg(form, userId);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
	}    		
}

