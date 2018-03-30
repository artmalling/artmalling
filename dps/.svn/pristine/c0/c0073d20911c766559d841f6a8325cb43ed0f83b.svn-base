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

public class POrd507DAO extends AbstractDAO {
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

		String  strStrCd	   = String2.nvl(form.getParam("strStrCd"));
		String  strStanddard   = String2.nvl(form.getParam("strStanddard"));
		String  strSStandardDt = String2.nvl(form.getParam("strSStandardDt"));
		String  strEStandardDt = String2.nvl(form.getParam("strEStandardDt"));
		String  strStandardNo  = String2.nvl(form.getParam("strStandardNo"));
		String  strPumbun	   = String2.nvl(form.getParam("strPumbun"));
		String  strVen	       = String2.nvl(form.getParam("strVen")); 
	
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();   
		connect("pot");		
		System.out.println("구분값 : "+ strStanddard);
		
		if("1".equals(strStanddard)){					// OFFER_DT
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag);  
			sql.put(svc.getQuery("SEL_LIST_OFFER"));
			
		} else if("2".equals(strStanddard)){			// INVOICE_DT

			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);			
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag);  
			sql.put(svc.getQuery("SEL_LIST_INVOICE"));
			
		} else if("3".equals(strStanddard)){			// ORDER_DT	

			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo); 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSStandardDt);
			sql.setString(i++, strEStandardDt); 
			sql.setString(i++, strStandardNo);  
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag);  
			sql.put(svc.getQuery("SEL_LIST_ORDER"));			
		} 
		
		ret = select2List(sql);
		return ret;
	}
}
