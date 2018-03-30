/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 경영지원
 * </p>
 * 협력사 조회 팝업DAO
 * 
 * @created on 1.0, 2010/01/25
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom211DAO extends AbstractDAO {
	/**
	 * 상품권  관련 공통  콤보
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getGiftCombo(ActionForm form)
			throws Exception {
		List ret = null;
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		String getSql = null;
		int i = 1;
		connect("pot");
		getSql = svc.getQuery("SEL_GIFT_"+form.getParam("strFlag").toString()+"_COMBO");
		sql.put(getSql);
		String addCondition = form.getParam("addCondition");       
		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
		        	sql.put(svc.getQuery("SEL_GIFT_"+form.getParam("strFlag").toString()+"_COMBO_CONDI_0"+idx));
		            sql.setString(i++, addConds[idx] );
			}				
		}
		ret = select2List(sql);
		return ret;
	}
}
