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
import common.util.*;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>타임아웃관리  </p>
 * 
 * @created  on 1.0, 2010/07/05
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MEdi107DAO extends AbstractDAO {

	/**
	 * 마스터 을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchList(ActionForm form, String userId, String org_flag) throws Exception {
		int i = 1;      
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;  
		Util util = new Util();
		    
		String strQuery = "";
		
		try {
			String strStrCd		= String2.nvl(form.getParam("strStrCd"));   
			String strVenCd		= String2.nvl(form.getParam("strVenCd"));   
			String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));   
			String strCustName	= URLDecoder.decode(String2.nvl(form.getParam("strCustName")), "UTF-8");
			String strCardNo	= String2.nvl(form.getParam("strCardNo"));   
			String strSdt		= String2.nvl(form.getParam("strSdt"));  
			String strEdt		= String2.nvl(form.getParam("strEdt"));
	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			connect("pot");
	
			strQuery =svc.getQuery("SEL_LIST") + "\n";      //SM
			
			sql.setString(i++, strStrCd);   
			sql.setString(i++, strVenCd);
			sql.setString(i++, strPumbunCd);
			
			if(!strCustName.equals("")) {
				strQuery += svc.getQuery("SEL_LIST_CUST_NAME") +"\n";
				sql.setString(i++, strCustName);
				
				System.out.println(strCustName);
			}else if(!strCardNo.equals("")) {
				strQuery += svc.getQuery("SEL_LIST_CARD_NO") +"\n";
				sql.setString(i++, strCardNo);
			}else if(!strSdt.equals("") && !strEdt.equals("")) {
				strQuery += svc.getQuery("SEL_LIST_REG_DATE") +"\n";
				sql.setString(i++, strSdt);
				sql.setString(i++, strEdt);
			}
			sql.put(strQuery);

			list = select2List(sql);
			
			System.out.println(list);
			
	        //복호화
	      /*list = util.decryptedStr(list,4);	// 카드 번호
	        list = util.decryptedStr(list,14);	// 집전화 번호1
	        list = util.decryptedStr(list,15);	// 집전화 번호2
	        list = util.decryptedStr(list,16);	// 집전화 번호3	
	        list = util.decryptedStr(list,17);	// 휴대폰 번호3
	        list = util.decryptedStr(list,18);	// 휴대폰 번호3
	        list = util.decryptedStr(list,19);	// 휴대폰 번호3
	        list = util.decryptedStr(list,30);	// E-mail 번호1
	        list = util.decryptedStr(list,31);	// E-mail 번호2 */

		} catch (Exception e) {
            //throw e;
			//System.out.println("111111");
			e.printStackTrace();
        }
		return list;
	}
}
