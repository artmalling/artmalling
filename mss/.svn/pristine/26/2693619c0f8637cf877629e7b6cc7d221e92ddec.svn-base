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

public class MGif406DAO extends AbstractDAO {
	/**
	 * <p>상품권종류</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub_Type(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
		
			sql.put(svc.getQuery("SEL_GIFT_TYPE_CD"));
			list = select2List(sql);	
		 
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>상품권종류</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub_Amt(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			
			String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));
			
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
			connect("pot");
			 
			sql.setString(1, strGiftTypeCd);
		
			sql.put(svc.getQuery("SEL_GIFT_AMT_TYPE"));
			list = select2List(sql);	
		 
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * Master 조회
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
		
		String strCD    	= String2.nvl(form.getParam("strCD"));
		String strDtFrom  	= String2.nvl(form.getParam("strDtFrom")); 
		String strDtTo  	= String2.nvl(form.getParam("strDtTo")); 
		String strGiftType  = String2.nvl(form.getParam("strGiftType")); 
		String strGiftAmt  	= String2.nvl(form.getParam("strGiftAmt")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strCD);
		sql.setString(i++, strDtFrom);
		sql.setString(i++, strCD);
		sql.setString(i++, strDtFrom); 
		sql.setString(i++, strCD);
		sql.setString(i++, strDtFrom);
		sql.setString(i++, strCD);
		sql.setString(i++, strDtFrom);
		sql.setString(i++, strDtTo);
		sql.setString(i++, strGiftType);
		sql.setString(i++, strGiftAmt);
		 
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
		
	}

}
