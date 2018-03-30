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
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal534DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;

		int i 			= 1;
		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strOriginAreaCd 	  = String2.nvl(form.getParam("strOriginAreaCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOriginAreaCd);
		
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOriginAreaCd);
	
		ret = select2List(sql);
		
		return ret;
	}
	
}
