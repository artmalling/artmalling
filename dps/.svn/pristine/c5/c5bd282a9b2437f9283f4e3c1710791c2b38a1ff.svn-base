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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;


/**
 * <p>예제  DAO</p>
 *  
 * @created  on 1.0, 2010/03/24
 * @created  by 박래형(FKSS)
 * 
 * @modified on  
 * @modified by 
 * @caused   by 
 */  

public class POrd506DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */    	
	
	/**
	 * INVOICE 등록 리스트 내역 조회
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
		
		String  strStrCd	    = String2.nvl(form.getParam("strStrCd"));
		String  strSInvoiceDt	= String2.nvl(form.getParam("strSInvoiceDt"));
		String  strEInvoiceDt	= String2.nvl(form.getParam("strEInvoiceDt"));
		
		String  strInvoiceNo	= URLDecoder.decode(String2.nvl(form.getParam("strInvoiceNo")), "UTF-8");
		String  strOfferNo	    = URLDecoder.decode(String2.nvl(form.getParam("strOfferNo")), "UTF-8");
		Integer intInvoiceNo    = 0;
		Integer intOfferNo      = 0;
		 
		String  strPumbun	    = String2.nvl(form.getParam("strPumbun"));
		String  strVen		    = String2.nvl(form.getParam("strVen"));
		String  strSlipNo	    = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		

		if("".equals(strSlipNo)){
			sql.put(svc.getQuery("SEL_LIST")); 
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strSInvoiceDt);     
			sql.setString(i++, strEInvoiceDt);    
			sql.setString(i++, strInvoiceNo);     
			sql.setString(i++, strOfferNo);   
			sql.setString(i++, strPumbun);  
			sql.setString(i++, strVen);  
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag);  
		}else{
			sql.put(svc.getQuery("SEL_LIST_SLIP_NO")); 
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strSlipNo);
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag); 
		}
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * INVOICE 등록  마스터 내역 조회
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
		String strInvoiceYm = String2.nvl(form.getParam("strInvoiceYm"));
		String strInvoiceSeqNo = String2.nvl(form.getParam("strInvoiceSeqNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);      
		sql.setString(i++, strInvoiceYm);     
		sql.setString(i++, strInvoiceSeqNo);  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";  

		sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
	} 
	
	/**
	 * INVOICE 등록  상세 내역 조회
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
		String strInvoiceYm = String2.nvl(form.getParam("strInvoiceYm"));
		String strInvoiceSeqNo = String2.nvl(form.getParam("strInvoiceSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strInvoiceYm);     
		sql.setString(i++, strInvoiceSeqNo);  
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?");
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
}
