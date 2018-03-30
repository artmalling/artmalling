/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
 

/**
 * <p>예제  DAO</p>
 * 
 * @created  on 1.0, 2010/01/13
 * @created  by 박래형(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 

public class POrd502DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */    	
	
	/**
	 * 규격단품 매입발주 리스트 내역 조회
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
		
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strSOrderDt	= String2.nvl(form.getParam("strSOrderDt"));
		String strEOrderdDt	= String2.nvl(form.getParam("strEOrderdDt"));
		
		String strPumbun	= String2.nvl(form.getParam("strPumbun"));
		String strVen		= String2.nvl(form.getParam("strVen"));
		
		String strOrderNo   = URLDecoder.decode(String2.nvl(form.getParam("strOrderNo")), "UTF-8");
		Integer intOrderNo  = 0;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
/* 
		if("".equals(strOrderNo)){
			System.out.println("타나");
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOrderDt);     
			sql.setString(i++, strEOrderdDt);        
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);   		 
			sql.setString(i++, userId);   		
			strQuery = svc.getQuery("SEL_LIST_ODD_ORDER_NO") + "\n";
			
		}else{	
*/	
//			intOrderNo	= Integer.valueOf(strOrderNo);
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOrderDt);     
			sql.setString(i++, strEOrderdDt);      
//			sql.setInt(i++, intOrderNo);        
			sql.setString(i++, strOrderNo);        
			sql.setString(i++, strPumbun); 
			sql.setString(i++, strVen);   		
			sql.setString(i++, userId);   		
			sql.setString(i++, org_flag);   		 
			strQuery = svc.getQuery("SEL_LIST") + "\n";			
//		}

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 규격단품 매입발주 마스터 내역 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strOrderYm = String2.nvl(form.getParam("strOrderYm"));
		String strOrderSeqNo = String2.nvl(form.getParam("strOrderSeqNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOrderYm);     
		sql.setString(i++, strOrderSeqNo);  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 규격단품 매입발주  상세 내역 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strOrderYm = String2.nvl(form.getParam("strOrderYm"));
		String strOrderSeqNo = String2.nvl(form.getParam("strOrderSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);    
		sql.setString(i++, strStrCd);    
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOrderYm);     
		sql.setString(i++, strOrderSeqNo); 
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOrderYm);     
		sql.setString(i++, strOrderSeqNo);  
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";

		sql.put(strQuery);

		System.out.println("Why?");
		ret = select2List(sql);
		System.out.println("ret.size() " + ret.size());

		return ret;
	}
}
