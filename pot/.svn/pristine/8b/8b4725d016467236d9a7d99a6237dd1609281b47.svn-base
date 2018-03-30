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
 * <p>계량기마스터조회</p>
 * @created on 1.0, 2010.04.05
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom214DAO extends AbstractDAO {
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
			//미등록계량기 체크 T,F
			if (mi.getString("USEYN").equals("T")) {
				sql.put(svc.getQuery("SEL_CODE"));
			} else {
				if (mi.getString("FLCCD").equals("")) {
					sql.put(svc.getQuery("SEL_CODE_NOCHK_LIKE"));
				} else {
					sql.put(svc.getQuery("SEL_CODE_NOCHK"));
				}
			}
			sql.setString(++i, mi.getString("GAUGKIND"));	//계량기용도
			sql.setString(++i, mi.getString("GAUGKIND"));	//계량기용도
			sql.setString(++i, mi.getString("CODE"));		//계량기ID
			sql.setString(++i, mi.getString("GAUGTYPE"));	//계량기구분
			sql.setString(++i, mi.getString("FLCCD"));		//시설구분
			//추가 조건이 있을경우
			String addCondition = mi.getString("ADD_CONDITION");
			if (!addCondition.equals("")) {
				String[] addConds = addCondition.split("#G#");
				for (int idx = 0; idx < addConds.length; idx++) {
					switch(idx){ 
				        case 0: //계량기레벨
				        	sql.put(svc.getQuery("SEL_CODE_W_GAUG_LVL"));
					        sql.setString(++i, addConds[idx] );
					    	break;
				        case 1: //미등록계량기만(T)
				        	if (addConds[idx].equals("T")) {
				        		sql.put(svc.getQuery("SEL_CODE_W_GAUG_ID_CHK"));
				        	}
				        	break;
					}
				}
			}
			sql.put(svc.getQuery("SEL_CODE_END"));
			
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
