/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.dao;

import java.util.List;
import java.util.Map;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>특정/임대을B 매출수수료 산출현황</p>
 * 
 * @created  on 1.0, 2011/05/18
 * @created  by 김경은 
 *   
 * @modified on  
 * @modified by                    
 * @caused   by           
 */ 
 
public class PPay310DAO extends AbstractDAO {
 
	/**
	 * 특정/임대을B 매출수수료 산출현황 마스터 데이터 조회
	 *       
	 * @param form   
	 * @return 
	 * @throws Exception
	 */ 
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null; 
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;            

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));   
		String strYyyymm   = String2.nvl(form.getParam("strYyyymm"));   
		String strPayCyc   = String2.nvl(form.getParam("strPayCyc"));  
		String strPayCnt   = String2.nvl(form.getParam("strPayCnt"));   
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));    
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));    
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));     
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);    
		sql.setString(i++, strVenCd);  
		
		ret = select2List(sql);
		return ret;
	}
 
	/**
	 * 특정/임대을B 매출수수료 산출현황 디테일 데이터 조회
	 *       
	 * @param form   
	 * @return 
	 * @throws Exception
	 */
	public List getDetail(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;            

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));   
		String strYyyymm   = String2.nvl(form.getParam("strYyyymm"));   
		String strPayCyc   = String2.nvl(form.getParam("strPayCyc"));  
		String strPayCnt   = String2.nvl(form.getParam("strPayCnt"));   
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));    
		String strBrandCd  = String2.nvl(form.getParam("strBrandCd"));    
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_DETAIL"));     
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);   
		sql.setString(i++, strVenCd);   
		sql.setString(i++, strBrandCd);  
		
		ret = select2List(sql);
		return ret;
	}
}
