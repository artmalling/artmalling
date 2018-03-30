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
 * <p>임대계약마스터조회</p>
 * @created on 1.0, 2010.04.08
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom215DAO extends AbstractDAO {
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
			
			// SCHLOC : C:계약마스터관리, H:주거세대마스터 조회
			String strSearchFlag = "";
			if (mi.getString("SCHLOC").equals("H")) {
				strSearchFlag = "_HOME";
			}else {
				if (mi.getString("FLCCD").equals("51")) {
					strSearchFlag = "_CES";
				}else {
					strSearchFlag = "";
				}
			}
			
			int i = 0;
			
			//미등록계량기 체크 Y,N,E:일반계약ID조회
			if (mi.getString("USEYN").equals("Y")) {
				sql.put(svc.getQuery("SEL_CODE"+strSearchFlag)); //SEL_CODE_CES
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
			} else if (mi.getString("USEYN").equals("E")) {
				sql.put(svc.getQuery("SEL_CODE_NORMAL"));
			} else {
				sql.put(svc.getQuery("SEL_CODE_NOCHK"+strSearchFlag));
			}
			
			if (mi.getString("USEYN").equals("N")) {
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기용도
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
				sql.setString(++i, mi.getString("GTYPE"));		//계량기구분
			}
			
			if (mi.getString("SCHLOC").equals("H")) {
				sql.setString(++i, mi.getString("VENNM"));	//호
			}
			sql.setString(++i, mi.getString("VENCD"));	//협력사CD (주거세대마스터일시 동)
			sql.setString(++i, mi.getString("FLCCD"));	//시설구분
			sql.setString(++i, mi.getString("CODE"));	//계량기ID
			
			if (mi.getString("USEYN").equals("E")) {
				//sql.setString(++i, mi.getString("GTYPE"));		//계량기용도
				sql.setString(++i, mi.getString("GKINDCD"));	//계량기구분
			}
			
			//추가 조건이 있을경우
			String addCondition = mi.getString("ADD_CONDITION");
			if (!addCondition.equals("")) {
				String[] addConds = addCondition.split("#G#");
				for (int idx = 0; idx < addConds.length; idx++) {
					switch(idx){ 
				        case 0: //추가
				        	//sql.put(svc.getQuery("SEL_CODE_W_GAUG_LVL"));
					        //sql.setString(++i, addConds[idx] );
				        	break;
					}
				}
			}
			
			sql.put(svc.getQuery("SEL_CODE_END"+strSearchFlag));
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
