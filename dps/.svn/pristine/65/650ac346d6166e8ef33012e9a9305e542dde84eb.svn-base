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
 * <p>발행대상전표 매입 세금계산서 생성</p>
 * 
 * @created  on 1.0, 2011/04/11 
 * @created  by 박래형 
 *   
 * @modified on  
 * @modified by                    
 * @caused   by           
 */ 
 
public class PPay305DAO extends AbstractDAO {
 
	/**
	 * 특정 대금지불 산출현황 마스터 데이터 조회
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
		String strBumun    = String2.nvl(form.getParam("strBumun"));   
		String strTeam     = String2.nvl(form.getParam("strTeam"));   
		String strPc       = String2.nvl(form.getParam("strPc"));  
		String strYyyymm   = String2.nvl(form.getParam("strYyyymm"));   
		String strPayCyc   = String2.nvl(form.getParam("strPayCyc"));  
		String strPayCnt   = String2.nvl(form.getParam("strPayCnt"));
		String strPayDt    = String2.nvl(form.getParam("strPayDt")); 
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));    
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));    
		String strBizType  = String2.nvl(form.getParam("strBizType"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		if("1".equals(org_flag)){
			sql.put(svc.getQuery("SEL_MASTER"));  
		}else if("2".equals(org_flag)){
			sql.put(svc.getQuery("SEL_MASTER1"));   
		}
		
		sql.setString(i++, strStrCd);       
		sql.setString(i++, strBumun);       
		sql.setString(i++, strTeam);       
		sql.setString(i++, strPc);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strPayDt);
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strBizType);  
		sql.setString(i++, userId);  
		sql.setString(i++, org_flag);  
		
		ret = select2List(sql);
		return ret;
	}
 
	/**
	 * 특정 대금지불 산출현황 마스터 데이터 조회
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
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_DETAIL"));     
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);    
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strPumbunCd);  
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지불일자(콤보)
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getPayDt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));   
		String strYyyymm   = String2.nvl(form.getParam("strYyyymm"));   
		String strPayCyc   = String2.nvl(form.getParam("strPayCyc"));  
		String strPayCnt   = String2.nvl(form.getParam("strPayCnt"));   

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_PAY_DT"));     
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);

		ret = select2List(sql);
		return ret;
	}
}
