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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import mgif.dao.MGif607DAO;

import com.gauce.GauceDataSet;

import common.util.Util;

/**
 * <p>가맹점 정산</p>
 * 
 * @created on 1.0, 2011/04/21
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif607Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif607Action.class);

	/** 
	 * <p>가맹점 정산 화면로딩</p>
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
	 * <p>회수 및 정산 내역조회</p>
	 */
	public ActionForward searchCalInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet[] = null;
		GauceHelper2 helper = null;
		MGif607DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MGif607DAO();
			dSet    = new GauceDataSet[3];
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			dSet[0] = helper.getDataSet("DS_COL_DTL");
			dSet[1] = helper.getDataSet("DS_CAL_DTL");
			dSet[2] = helper.getDataSet("DS_CALDTL");
			helper.setDataSetHeader(dSet[0], "H_SEL_COL_DTL");
            helper.setDataSetHeader(dSet[1], "H_SEL_CAL_DTL");
            helper.setDataSetHeader(dSet[2], "H_SEL_CALDTL");
			
            //회수내역조회
			list    = dao.searchColDtl(form);
			helper.setListToDataset(list, dSet[0]);
			
			//정산내역조회
			list    = dao.searchCalDtl(form);
			helper.setListToDataset(list, dSet[1]);
			
			//정산상세내역조회
			list    = dao.searchCalDtl2(form);
			helper.setListToDataset(list, dSet[2]);
			
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/**
	 * <p>
	 * 회수내역 정산처리
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[]   = null;
		MGif607DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi[]       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MGif607DAO();
			dSet      = new GauceDataSet[2];
			mi		  = new MultiInput[2];
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet[0]      = helper.getDataSet("DS_COL_DTL");
            mi[0]        = helper.getMutiInput(dSet[0]);
            dSet[1]      = helper.getDataSet("DS_CALDTL");
            mi[1]        = helper.getMutiInput(dSet[1]);
			
			ret       = dao.save(form, mi, strUserId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward("blank");
	}
}
