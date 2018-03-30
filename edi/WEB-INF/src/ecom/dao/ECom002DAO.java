/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;



/**
 * <p>
 * 로그인 체크
 * </p>
 * 
 * @created on 1.0, 2010/12/10
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class ECom002DAO extends AbstractDAO2{
 
	/**
	 * 매출정보조회
	 * 
	 * @param string
	 * 
	 * @param svc
	 * @return Map
	 */
	
	public StringBuffer getSale(ActionForm form) throws Exception {
		
		//List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		//String query = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService(); 
			
			String strcd = String2.nvl(form.getParam("strcd"));					 
			String vencd = String2.nvl(form.getParam("vencd"));				 
			String strIlja = String2.nvl(form.getParam("strIlja"));			 

			connect("pot");
			
			sql.put(svc.getQuery("SEL_SALE"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, strIlja); 
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}
	
	/**
	 * 대금정보조회
	 * 
	 * @param string
	 * 
	 * @param svc
	 * @return Map
	 */
	
	public StringBuffer getbillmst(ActionForm form) throws Exception {
		
		//List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		//String query = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService(); 
			
			String strcd = String2.nvl(form.getParam("strcd"));					 
			String vencd = String2.nvl(form.getParam("vencd"));				 
			String strIlja = String2.nvl(form.getParam("strIlja"));			   
			connect("pot");
			
			sql.put(svc.getQuery("SEL_BILL"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, strIlja); 
			sql.setString(++i, strIlja); 
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}
 
}
