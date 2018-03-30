/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;
 
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>물품 입고/반품 등록</p> 
 * 
 * @created  on 1.0, 2010/01/26
 * @created  by 박래형(FUJITSU KOREA LTD.) 
 * 
 * @modified on  
 * @modified by 
 * @caused   by    
 */

public class POrd121DAO extends AbstractDAO {    	 
	/**
	 * 전표별 발주현황 마스터 리스트 내역 조회 
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		 
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";  
		int i = 1;   
				
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strOrgCd        = String2.nvl(form.getParam("strOrgCd")); 
		String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));    
		String strAutoTrgFlag  = String2.nvl(form.getParam("strAutoTrgFlag"));   
		String strStartDt      = String2.nvl(form.getParam("strStartDt"));     
		String strEndDt        = String2.nvl(form.getParam("strEndDt"));      
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot"); 
		 		 
		sql.put(svc.getQuery("SEL_LIST"));   
		sql.setString(i++, strStrCd);      
		sql.setString(i++, strPumbunCd); 			// 품번
		sql.setString(i++, strStartDt);    
		sql.setString(i++, strEndDt);    
		sql.setString(i++, strAutoTrgFlag); 	    // 전표구분
		sql.setString(i++, userId); 			    // 조직권한
		sql.setString(i++, org_flag); 			    // 조직구분
		    
		if("1".equals(org_flag)){						// 판매
			sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
			sql.setString(i++, strOrgCd);
		}else if("2".equals(org_flag)){					// 매입
			sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
			sql.setString(i++, strOrgCd);          
		}
				
		ret = select2List(sql);
		System.out.println("ret = " + ret.size());
		return ret;
	}   	 
	/**
	 * 전표별 발주현황 디테일 리스트 내역 조회 
	 *  
	 * @param form    
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));  
		String strChkDt     = String2.nvl(form.getParam("strChkDt"));  
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd")); 
		String strVenCd     = String2.nvl(form.getParam("strVenCd"));  
		String strBizType   = String2.nvl(form.getParam("strBizType"));  
		String strTaxFlag   = String2.nvl(form.getParam("strTaxFlag"));
		String strSlipNo    = String2.nvl(form.getParam("strSlipNo")); 
		String strSaleFlag  = String2.nvl(form.getParam("strSaleFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		  
		connect("pot");

		sql.setString(i++, strStrCd);  
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag);
		sql.setString(i++, strSlipNo); 	
		sql.setString(i++, strSaleFlag);
		
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);
		sql.close();
		
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strChkDt);
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strChkDt);
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag); 
		sql.setString(i++, strSlipNo); 	
		
		ret[1] = select2List(sql);
		return ret;
		
	}
	
	/** 
	 * 조회(매입,반품,점출입,매가인상하)
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail1(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null; 
		String strQuery = ""; 
		int i = 1;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));  
		String strChkDt     = String2.nvl(form.getParam("strChkDt"));  
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd")); 
		String strVenCd     = String2.nvl(form.getParam("strVenCd"));  
		String strBizType   = String2.nvl(form.getParam("strBizType"));  
		String strTaxFlag   = String2.nvl(form.getParam("strTaxFlag"));  
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		
		
		sql.put(svc.getQuery("SEL_DETAIL1"));  
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag); 
		
 
//		System.out.println(sql); 
		ret = select2List(sql);
		System.out.println("121DAOret.size() = " +  ret.size());
		return ret;
	}
	
	/**
	 * 규격단품 대출입발주  상세 내역 조회                                                                       
	 * 
	 * @param form                     
	 * @return
	 * @throws Exception 
	 */
	public List[] getDetail2(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";  
		int i = 1;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));  
		String strChkDt     = String2.nvl(form.getParam("strChkDt"));  
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd")); 
		String strVenCd     = String2.nvl(form.getParam("strVenCd"));  
		String strBizType   = String2.nvl(form.getParam("strBizType"));  
		String strTaxFlag   = String2.nvl(form.getParam("strTaxFlag"));  
 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		/*
		sql.setString(i++, strStrCd); 
		if("C".equals(strSlipFlag)) 
			sql.setString(i++, strSlipNo);
		else
			sql.setString(i++, strPSlipNo);
		*/
		
		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag); 
		ret[0] = select2List(sql);                                       

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strChkDt); 
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag); 
		ret[1] = select2List(sql);

		return ret;
	} 
}
