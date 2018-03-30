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

import common.util.Util;

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

public class PSal529DAO extends AbstractDAO {
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		 = String2.nvl(form.getParam("strStrCd"));
		String strCondSaleYm = String2.nvl(form.getParam("strCondSaleYm"));   
		String strSdt		 = String2.nvl(form.getParam("strSdt"));
		String strEdt		 = String2.nvl(form.getParam("strEdt"));
		String strOrder		 = String2.nvl(form.getParam("strOrder"));
		String strPumbunCd	 = String2.nvl(form.getParam("strPumbunCd"));
		String strMappingYn	 = String2.nvl(form.getParam("strMappingYn"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strCondSaleYm);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strMappingYn);

		sql.setString(i++, strCondSaleYm);  
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOrder);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMappingYn);
		
		sql.setString(i++, strSdt);  
		sql.setString(i++, strEdt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOrder);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMappingYn);

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	public List getDetail(ActionForm form) throws Exception {
		  List       list = null;
	        SqlWrapper  sql = null;
	        Service     svc = null;
	        Util util = new Util();

	        try {
	            connect("pot");
	            svc  = (Service)form.getService();
	            sql  = new SqlWrapper();
	            int i = 1;

	    		String strStrCd		 = String2.nvl(form.getParam("strStrCd"));
	    		String strCondSaleYm = String2.nvl(form.getParam("strCondSaleYm"));   
	    		String strSdt		 = String2.nvl(form.getParam("strSdt"));
	    		String strEdt		 = String2.nvl(form.getParam("strEdt"));
	    		String strOrder		 = String2.nvl(form.getParam("strOrder"));
	    		String strPumbunCd	 = String2.nvl(form.getParam("strPumbunCd"));
	    		String strMappingYn	 = String2.nvl(form.getParam("strMappingYn"));

	            sql.put(svc.getQuery("SEL_DETAIL"));
	            
	    		sql.setString(i++, strCondSaleYm);  
	    		sql.setString(i++, strStrCd);
	    		sql.setString(i++, strOrder);
	    		sql.setString(i++, strPumbunCd);
	    		sql.setString(i++, strMappingYn);
	    		
	    		sql.setString(i++, strSdt);  
	    		sql.setString(i++, strEdt);
	    		sql.setString(i++, strStrCd);
	    		sql.setString(i++, strOrder);
	    		sql.setString(i++, strPumbunCd);
	    		sql.setString(i++, strMappingYn);
				          
	            list = select2List(sql);
           
	        } catch (Exception e) { 
	        	System.out.println("!!!!!!!!!!!!" +e);
	            throw e;
	        }
	        return list;
		 
	}
}
