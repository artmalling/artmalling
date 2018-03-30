/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2011/02/21
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae103DAO extends AbstractDAO {
	/**
	 * 카드사 마스터 관리 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		 
		String strStrCd  = String2.nvl(form.getParam("strStrCd"));
		String strPumbun = String2.nvl(form.getParam("strPumbun"));
		String strVenCd  = String2.nvl(form.getParam("strVenCd"));
		String strSkuCd  = String2.nvl(form.getParam("strSkuCd"));
		String strSkuGb  = String2.nvl(form.getParam("strSkuGb"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbun);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strSkuCd);
		sql.setString(i++, strSkuGb);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
 
}