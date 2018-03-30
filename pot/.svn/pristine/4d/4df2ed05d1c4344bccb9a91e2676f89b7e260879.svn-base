/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import tcom.dao.TCom007DAO;

import com.gauce.GauceDataSet;
import common.util.Util;

/**
 * <p>
 * 즐겨찾기관리
 * </p>
 * 
 * @created on 1.0, 2010/06/09
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class TCom007Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom007Action.class);
    
	/**
	 * <p>
	 * 즐겨찾기추가
	 * </p>
	 */
	public ActionForward addFavorite(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom007DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		String strUserId    = null;
		try {
			dao       = new TCom007DAO();
			helper    = new GauceHelper2(request, response, form);
			strUserId = Util.getUsrCd(request);
			dSet      = helper.getDataSet("DSPOST");
			
			dao.addFavorite(form, strUserId);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, "성공적으로 추가 되었습니다 .");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 즐겨찾기삭제
	 * </p>
	 */
	public ActionForward delFavorite(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom007DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		String strUserId    = null;
		try {
			dao       = new TCom007DAO();
			helper    = new GauceHelper2(request, response, form);
			strUserId = Util.getUsrCd(request);
			dSet      = helper.getDataSet("DSPOST");
			
			dao.delFavorite(form, strUserId);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, "성공적으로 삭제 되었습니다 .");
		}
		return mapping.findForward(strGoTo);
	}
}
