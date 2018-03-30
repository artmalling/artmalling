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

import pcod.dao.PCod505DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod505Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod505Action.class);

	/**
	 * <p>페이지를 로드한다.</p>
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
	 * <p>엑셀 데이터를 검증한다.</p>
	 * 
	 */
	public ActionForward checkExcelData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod505DAO dao = null;
		List list = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			dao = new PCod505DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_EXECL_LOAD");
			dSet[1] = helper.getDataSet("DS_RESULT");
			MultiInput mi = new MultiInput(dSet[0]);
			switch( Integer.parseInt(form.getParam("strCheckType"))){
				case 1: // 규격단품
					helper.setDataSetHeader(dSet[1], "H_SKU");
					list = dao.checkSkuExcelData(form, mi);
					break;
				case 2: // 신선단품
					helper.setDataSetHeader(dSet[1], "H_FRESH");
					list = dao.checkFreshExcelData(form, mi);
					break;
				case 3: // 의류단퓸(A)
					helper.setDataSetHeader(dSet[1], "H_ASTYLE");
					list = dao.checkAStyleExcelData(form, mi);
					break;
				case 4: // 의류단퓸(B)
					helper.setDataSetHeader(dSet[1], "H_BSTYLE");
					list = dao.checkBStyleExcelData(form, mi);
					break;
			}
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
	 * <p>엑셀 데이터를 저장한다.</p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod505DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();

			dao = new PCod505DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_EXCEL_DATA");
			MultiInput mi = null;
			switch( Integer.parseInt(form.getParam("strCheckType"))){
				case 1: // 규격단품
					helper.setDataSetHeader(dSet, "H_SKU");
					mi = new MultiInput(dSet);
					ret = dao.saveStnSkumst(form, mi, userId);
					break;
				case 2: // 신선단품
					helper.setDataSetHeader(dSet, "H_FRESH");
					mi = new MultiInput(dSet);
					ret = dao.saveFreshSkumst(form, mi, userId);
					break;
				case 3: // 의류단퓸(A)
					helper.setDataSetHeader(dSet, "H_ASTYLE");
					mi = new MultiInput(dSet);
					ret = dao.saveAStylemst(form, mi, userId);
					break;
				case 4: // 의류단퓸(B)
					helper.setDataSetHeader(dSet, "H_BSTYLE");
					mi = new MultiInput(dSet);
					ret = dao.saveBStylemst(form, mi, userId);
					break;
			}
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
}
