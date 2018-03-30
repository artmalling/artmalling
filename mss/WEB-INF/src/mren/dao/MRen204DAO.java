/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import common.util.FileControlMgr;
import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>계약마스터관리 </p>
 * 
 * @created  on 1.0, 2010.04.14
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen204DAO extends AbstractDAO {

	/**
	 * <p>
	 * 계약마스터 조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;

		Util util = new Util();
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			int i = 0;
			// parameters
			String strFlcFlag = String2.nvl(form.getParam("strFlcFlag")); 	// [조회용]시설구분(점코드)
			String strVenCd = String2.nvl(form.getParam("strVenCd")); 		// [조회용]협력사
			String strStayNow = String2.nvl(form.getParam("strStayNow")); 	// [조회용]현거주여부
			String strRentType = String2.nvl(form.getParam("strRentType")); // [조회용]임대형태
			String strRentFlag = String2.nvl(form.getParam("strRentFlag")); // [조회용]임대구분
			String strCntrType = String2.nvl(form.getParam("strCntrType")); // [조회용]계약유형
			String strIOFlag = String2.nvl(form.getParam("strIOFlag")); 	// [조회용]조회기간구분
			String strSdt = String2.nvl(form.getParam("strSdt")); 			// [조회용]기간S
			String strEdt = String2.nvl(form.getParam("strEdt")); 			// [조회용]기간E
			sql.put(svc.getQuery("SEL_MR_CNTRMST"));
			sql.setString(++i, strVenCd);
			sql.setString(++i, strRentType);
			sql.setString(++i, strRentFlag);
			sql.setString(++i, strCntrType);
			sql.setString(++i, strFlcFlag);
			// 1:계약시작일, 2:계약종료일
			if (strIOFlag.equals("1")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_SDT"));
				sql.setString(++i, strSdt);
				sql.setString(++i, strEdt);
			} else if (strIOFlag.equals("2")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_EDT"));
				sql.setString(++i, strSdt);
				sql.setString(++i, strEdt);
			}
			// 현거주여부
			if (strStayNow.equals("Y")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_STAY_NOW"));
			}

			sql.put(svc.getQuery("SEL_MR_CNTRMST_ORDER_BY"));
			list = select2List(sql);
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	
}	
