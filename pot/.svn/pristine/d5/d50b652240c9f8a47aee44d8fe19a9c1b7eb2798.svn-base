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
 * <p>특판사원 조회</p>
 * @created on 1.0, 2010/02/21
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom209DAO extends AbstractDAO {
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
			sql.put(svc.getQuery("SEL_CODE"));
			sql.setString(++i, mi.getString("CODE"));
			sql.setString(++i, mi.getString("NAME"));
			
			//추가 조건이 있을경우
			String addCondition = mi.getString("ADD_CONDITION");
			if (!addCondition.equals("")) {
				String[] addConds = addCondition.split("#G#");
				for (int idx = 0; idx < addConds.length; idx++) {
					switch(idx){ 
				        case 0: //조직코드
				        	sql.put(svc.getQuery("SEL_CODE_W_ORG_CD"));
					        sql.setString(++i, addConds[idx] );
					    	break;
				        case 1: //점코드
					        if( !addConds[idx].equals("") ){
				        	sql.put(svc.getQuery("SEL_CODE_W_STR_CD"));
					        sql.setString(++i, addConds[idx] );
					        } 
					    	break;
					}
				}
			}
			list = select2List(sql);
		} catch (Exception e) {
			 throw e;
		}
		return list;
	}
}
