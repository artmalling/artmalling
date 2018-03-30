/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * <p>주거세대마스터 조회</p>
 * @created on 1.0, 2010.03.28
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom212DAO extends AbstractDAO {
	/**
	 * 조회
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List getDate(ActionForm form, MultiInput mi)
			throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			connect("pot");
			mi.next();
			int i = 0;
			
			
			//조회구분 : 0: 주거세대마스터체크 0, 1: 주거마스터만 조인 
			if (mi.getString("SGBN").equals("1")) {
				sql.put(svc.getQuery("SEL_CODE"));
			} else {
				sql.put(svc.getQuery("SEL_CODE_USEYN"));
			}
			sql.setString(++i, mi.getString("STRCD"));
			sql.setString(++i, mi.getString("CODE"));
			
			// 동
			if (!mi.getString("NAME").equals("")) {
				sql.put(svc.getQuery("SEL_CODE_W_DONG"));
				sql.setString(++i, mi.getString("NAME"));
			}
			// 호
			if (!mi.getString("NAME2").equals("")) {
				sql.put(svc.getQuery("SEL_CODE_W_HO"));
				sql.setString(++i, mi.getString("NAME2"));
			}
			
			//추가 조건이 있을경우
			String addCondition = mi.getString("ADD_CONDITION");
			if (!addCondition.equals("")) {
				String[] addConds = addCondition.split("#G#");
				for (int idx = 0; idx < addConds.length; idx++) {
					switch(idx){ 
				        case 0: //조직코드
				        	//sql.put(svc.getQuery("SEL_CODE_W_ORG_CD"));
					        //sql.setString(++i, addConds[idx] );
					    	break;
					}
				}
			}
			sql.put(svc.getQuery("SEL_CODE_ORDER_BY"));
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
