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
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

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

public class CCom200DAO extends AbstractDAO {
	/**
	 * 행사코드별 협력사 콤보 목록 가져오기
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getComboCd(ActionForm form)
			throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String getSql = null;

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		connect("pot");
		getSql = svc.getQuery(form.getParam("strSvcId"));
		sql.put(getSql);
		if(form.getParam("strSvcId").equals("SEL_VEN_BY_EVENT")){
			sql.setString(1, form.getParam("strCondiCd"));
			sql.setString(2, form.getParam("strStrCd"));
		}
		

		ret = select2List(sql);
		return ret;
	}

}
