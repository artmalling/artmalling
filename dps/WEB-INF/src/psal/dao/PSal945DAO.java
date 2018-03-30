/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper; 
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

/**
 * <p>매출일자별 청구현황DAO </p>
 * 
 * @created on 1.0, 2010/05/30
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal945DAO extends AbstractDAO { 
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal945DAO.class);

	/**
	 * <p>
	 * 매출일자별 청구현황조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = ""; 

		int i = 1;
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strChrgDtS 	= String2.nvl(form.getParam("strChrgDtS"));
		String strChrgDtE 	= String2.nvl(form.getParam("strChrgDtE"));
		String strBcompCd 	= String2.nvl(form.getParam("strBcompCd"));;
		String strGubun 	= String2.nvl(form.getParam("strGubun"));

		sql = new SqlWrapper();
		svc = (Service) form.getService(); 

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strGubun );
		sql.setString(i++, strChrgDtS );
		sql.setString(i++, strChrgDtE );
		sql.setString(i++, strBcompCd );
		
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
}
