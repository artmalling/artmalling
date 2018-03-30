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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>발행입고확정</p>
 * 
 * @created  on 1.0, 2011/04/18
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif114DAO extends AbstractDAO {
	/**
	 * 발행입고확정 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCombo(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_COMBO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행입고확정 마스터 조회
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
		String strSdt = String2.nvl(form.getParam("strSdt"));   	//일자 from
		String strEdt = String2.nvl(form.getParam("strEdt"));		//일자to
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));	// 상품권종류코드
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strGiftTypeCd);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행입고확정 디테일 조회
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
		String strReqDt = String2.nvl(form.getParam("strReqDt"));	//입고일자
		String strStrCd = String2.nvl(form.getParam("strStrCd"));   //점코드
		String strReqSlipNo = String2.nvl(form.getParam("strReqSlipNo"));		//발행순번
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));	// 상품권종류코드
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strReqDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqSlipNo);
		sql.setString(i++, strGiftTypeCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
