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
 * <p>상품권판매결재내역조회</p>
 * 
 * @created  on 1.0, 2011/08/30
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif323DAO extends AbstractDAO {

	 /**
	 * 일자별 판매내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form,String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strSDate = String2.nvl(form.getParam("strSDate"));   //조회시작일
		String strEDate = String2.nvl(form.getParam("strEDate"));	//조회종료일
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSDate);
		sql.setString(i++, strEDate);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 세부결제 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStr = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strSDate = String2.nvl(form.getParam("strSDate"));   //조회시작일
		String strEDate = String2.nvl(form.getParam("strEDate"));	//조회종료일
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.setString(i++, strStr);
		sql.setString(i++, strSDate);
		sql.setString(i++, strEDate);
		sql.setString(i++, strStr);
		sql.setString(i++, strSDate);
		sql.setString(i++, strEDate);
		sql.setString(i++, strStr);
		sql.setString(i++, strSDate);
		sql.setString(i++, strEDate);
		sql.setString(i++, strStr);
		sql.setString(i++, strSDate);
		sql.setString(i++, strEDate);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
