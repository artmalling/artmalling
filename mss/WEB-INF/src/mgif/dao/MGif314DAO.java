/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

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

public class MGif314DAO extends AbstractDAO {

	 /**
	 * 상품권 개인카드 매출 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strSYYYYMM = String2.nvl(form.getParam("strSYYYYMM"));   //조회월
		String strCardNo = String2.nvl(form.getParam("strCardNo"));	//조회 신용카드 번호
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.setString(i++, strSYYYYMM+"01");
		sql.setString(i++, strSYYYYMM+"31");
		sql.setString(i++, strCardNo);
		
		if(!strStrCd.equals("%")){
			sql.setString(i++, strStrCd);
			strQuery += svc.getQuery("SEL_MASTER_W_STR") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
}
