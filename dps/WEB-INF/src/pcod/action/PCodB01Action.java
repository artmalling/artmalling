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

import pcod.dao.PCodB01DAO;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;


/**
 * <p>백화점영업관리> 기준정보> 기타관리> 타임아웃관리  </p>
 * 
 * @created  on 1.0, 2010/07/05
 * @created  by 정진영(FKSS)
 * 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCodB01Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCodA01Action.class);

	/**
	 * <p>화면를 보여준다.</p>
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
	 * 마스터를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodB01DAO dao = null;
		MultiInput mi = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			helper = new GauceHelper2(request, response, form);
			if(request.getParameter("strSrchGubun").equals("N")){
				
				dSet = helper.getDataSet("DS_MASTER");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER");
				
			}else{
				dSet = helper.getDataSet("DS_MASTER2");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER2");
			}
			dao = new PCodB01DAO();
			
			list = dao.searchMaster(form, mi, request);
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
	 * 타임아웃
	 * 저장
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCodB01DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId = sessionInfo.getUSER_ID();

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			helper = new GauceHelper2(request, response, form);
			
			if(request.getParameter("strSrchGubun").equals("N")){
				
				dSet = helper.getDataSet("DS_MASTER");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER");
				
			}else{
				dSet = helper.getDataSet("DS_MASTER2");
				helper.setDataSetHeader(dSet, "H_SEL_MASTER2");
			}
			MultiInput mi = helper.getMutiInput(dSet);			
			dao = new PCodB01DAO();		
			
			ret = dao.save(form, mi, userId); 
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
}
