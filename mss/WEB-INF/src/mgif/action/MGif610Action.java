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

import mgif.dao.MGif610DAO;

import com.gauce.GauceDataSet;

import common.util.Util;

/**
 * <p>제휴쿠폰 정산관리</p>
 * 
 * @created on 1.0, 2011/04/28
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif610Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif607Action.class);

	/** 
	 * <p>제휴쿠폰 정산관리 화면로딩</p>
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
	 * <p>결제 및 정산 내역조회</p>
	 */
	public ActionForward searchCalInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet[] = null;
		GauceHelper2 helper = null;
		MGif610DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MGif610DAO();
			dSet    = new GauceDataSet[2];
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			dSet[0] = helper.getDataSet("DS_PAY_DTL");
			dSet[1] = helper.getDataSet("DS_CAL_DTL");
			helper.setDataSetHeader(dSet[0], "H_SEL_PAY_DTL");
            helper.setDataSetHeader(dSet[1], "H_SEL_CAL_DTL");
			
            //결제내역조회
			list    = dao.searchPayDtl(form);
			helper.setListToDataset(list, dSet[0]);
			
			//정산내역조회
			list    = dao.searchCalDtl(form);
			helper.setListToDataset(list, dSet[1]);
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
	 * 제휴쿠폰 정산처리
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MGif610DAO dao      = null;
		String strUserId    = null;
		String strGoTo      = null;
		MultiInput mi       = null;
		int ret             = 0;
		
		try {
			helper    = new GauceHelper2(request, response, form);
			dao       = new MGif610DAO();
			
			strGoTo   = form.getParam("goTo");
			strUserId = Util.getUserId(request);
			dSet      = helper.getDataSet("DS_PAY_DTL");
            mi        = helper.getMutiInput(dSet);
			
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
