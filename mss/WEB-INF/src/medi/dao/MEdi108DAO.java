/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package medi.dao;

import java.net.*;
import java.util.List;
import java.util.Map;

import common.util.*;
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
 * @created  on 1.0, 2012/06/25
 * @created  by 홍종영
 *  
 * @modified on  
 * @modified by                    
 * @caused   by            
 */ 
 
public class MEdi108DAO extends AbstractDAO {
 
	/**
	 * 특정 대금지불 산출현황 마스터 데이터 조회
	 *       
	 * @param form   
	 * @return  
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;  
		Util util = new Util();
		int i = 1;            
		try {
			
			String strStrCd		= String2.nvl(form.getParam("strStrCd"));   
			String strVenCd		= String2.nvl(form.getParam("strVenCd"));   
			String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));   
			String strCustName	= URLDecoder.decode(String2.nvl(form.getParam("strCustName")), "UTF-8");
			String strCardNo	= String2.nvl(form.getParam("strCardNo"));   
			String strSaleSdt	= String2.nvl(form.getParam("strSaleSdt"));  
			String strSaleEdt	= String2.nvl(form.getParam("strSaleEdt"));
			String strSale_S = String2.nvl(form.getParam("strSale_S"));
			String strSale_E = String2.nvl(form.getParam("strSale_E"));
			String strBirth_S = String2.nvl(form.getParam("strBirth_S"));
			String strBirth_E = String2.nvl(form.getParam("strBirth_E"));
			String strHomeAddr1 = URLDecoder.decode(String2.nvl(form.getParam("strHomeAddr1")), "UTF-8");
			String strAge = String2.nvl(form.getParam("strAge"));
			
			System.out.println(">>>>>>>>>>>>>>   " + java.net.URLDecoder.decode(String2.nvl(form.getParam("strCustName")), "EUC_KR"));
			
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			connect("pot");
		
			
			sql.put(svc.getQuery("SEL_MASTER1"));      //SM
			
			sql.setString(i++, strSaleSdt);   
			sql.setString(i++, strSaleEdt);
			
			sql.setString(i++, strSaleSdt);   
			sql.setString(i++, strSaleEdt);
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strVenCd);
			sql.setString(i++, strCustName);
			
			sql.setString(i++, strCardNo);
			//지역
			if(strHomeAddr1 != null && !strHomeAddr1.equals("")){
				sql.put(svc.getQuery("SEL_MASTER2"));
				sql.setString(i++, strHomeAddr1);				
			}
			
			//연령대
			String age1 = "";
			String age2 = "";
			if(strAge != null && strAge.equals("01")){
				age1 = "0";
				age2 = "19";
			}else if(strAge != null && strAge.equals("02")){
				age1 = "20";
				age2 = "29";
			}else if(strAge != null && strAge.equals("03")){
				age1 = "30";
				age2 = "39";
			}else if(strAge != null && strAge.equals("04")){
				age1 = "40";
				age2 = "49";
			}else if(strAge != null && strAge.equals("05")){
				age1 = "50";
				age2 = "59";
			}else if(strAge != null && strAge.equals("06")){
				age1 = "60";
				age2 = "69";
			}else if(strAge != null && strAge.equals("07")){
				age1 = "60";
				age2 = "999";
			}else if(strAge != null && strAge.equals("00")){
				age1 = "0";
				age2 = "999";
			}
			if(strAge != null){
				sql.put(svc.getQuery("SEL_MASTER3"));
				sql.setString(i++, age1);
				sql.setString(i++, age2);
			}
			//생월	
			if(strBirth_S != null && strBirth_E != null && !strBirth_S.equals("00") && !strBirth_E.equals("00")){
				sql.put(svc.getQuery("SEL_MASTER4"));
				sql.setString(i++, strBirth_S); 
				sql.setString(i++, strBirth_E);
			}else{ 
				sql.put(svc.getQuery("SEL_MASTER4"));
				sql.setString(i++, "01");
				sql.setString(i++, "12"); 
			}
			
			//매출액
			if(strSale_S != null && strSale_E != null && !strSale_S.equals("") && !strSale_E.equals("")){
				sql.put(svc.getQuery("SEL_MASTER5"));
				sql.setString(i++, strSaleSdt);
				sql.setString(i++, strSaleEdt);
				sql.setString(i++, strSale_S);
				sql.setString(i++, strSale_E);
			}
			sql.put(svc.getQuery("SEL_MASTER6"));
			sql.setString(i++, userId);
			
			
			list = select2List(sql);
	        //복호화
	      /*list = util.decryptedStr(list,5);	// 휴대폰번호1
	        list = util.decryptedStr(list,7);	// 휴대폰번호2
	        list = util.decryptedStr(list,8);	// 휴대폰번호3
	        list = util.decryptedStr(list,9);	// 카드번호  */
		} catch (Exception e) {
            throw e;
        }
		return list;
	}
	
	
	public List getDetail(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;  
		int i = 1;            

		String strStrCd		= String2.nvl(form.getParam("strStrCd"));   
		String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));   
		String strCustNo	= String2.nvl(form.getParam("strCustNo"));   
		String strSaleSdt	= String2.nvl(form.getParam("strSaleSdt"));  
		String strSaleEdt	= String2.nvl(form.getParam("strSaleEdt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		
		sql.put(svc.getQuery("SEL_DETAIL"));      //SD
		
		sql.setString(i++, strSaleSdt);   
		sql.setString(i++, strSaleEdt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCustNo); 
		sql.setString(i++, strPumbunCd);


		ret = select2List(sql);
		return ret;
	}
}
