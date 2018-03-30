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
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>기간별매입현황집계표</p>
 *  
 * @created  on 1.0, 2010/01/26 
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on  
 * @modified by  
 * @caused   by   
 */

public class POrd404DAO extends AbstractDAO {    	  
	/**
	 * 기간별매입현황집계표
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null; 
		Service svc = null;
		String strQuery = "";
		int i = 1;   
				
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strBumun        = String2.nvl(form.getParam("strBumun"));
		String strTeam         = String2.nvl(form.getParam("strTeam"));
		String strPc           = String2.nvl(form.getParam("strPc"));
		String strStartDt      = String2.nvl(form.getParam("strStartDt")); 
		String strEndDt        = String2.nvl(form.getParam("strEndDt"));  
		
		String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));   

		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot"); 
 
		sql.setString(i++, strStrCd);	 //1
		sql.setString(i++, strBumun);	 //2
		sql.setString(i++, strTeam);	  //3
		sql.setString(i++, strPc);	  //4

		sql.setString(i++, strStartDt);	 //5
		sql.setString(i++, strEndDt); //6			
		sql.setString(i++, strPumbunCd); //7	
						
		strQuery = svc.getQuery("SEL_LIST");
		

		
		
		sql.put(strQuery);
	//	System.out.println("1111111111111");
		ret = select2List(sql); 

		return ret;
	}
}
