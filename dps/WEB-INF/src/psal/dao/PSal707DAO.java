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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/** 
 * <p>월평가내역조회(누계)</p> 
 *  
 * @created  on 1.0, 2011/07/11
 * @created  by 김경은  
 * 
 * @modified on    
 * @modified by                    
 * @caused   by             
 */

public class PSal707DAO extends AbstractDAO { 
	/**  
	 * 월평가내역(누계) 데이터 조회
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

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strBumun       = String2.nvl(form.getParam("strBumun"));
		String strTeam        = String2.nvl(form.getParam("strTeam"));
		String strPc          = String2.nvl(form.getParam("strPc"));
		String strOrgCd       = String2.nvl(form.getParam("strOrgCd"));
		String strSEvaluYm    = String2.nvl(form.getParam("strSEvaluYm"));
		String strEEvaluYm    = String2.nvl(form.getParam("strEEvaluYm"));
		String strBizType     = String2.nvl(form.getParam("strBizType"));  
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService(); 
		connect("pot"); 
	
		sql.put(svc.getQuery("SEL_MASTER")); 
		sql.setString(i++, strSEvaluYm);
		sql.setString(i++, strEEvaluYm);
		sql.setString(i++, strOrgCd); 
		sql.setString(i++, userId); 
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSEvaluYm);
		sql.setString(i++, strEEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSEvaluYm);
		sql.setString(i++, strEEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSEvaluYm);
		sql.setString(i++, strEEvaluYm);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSEvaluYm);
		sql.setString(i++, strEEvaluYm);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, userId); 
		sql.setString(i++, strOrgCd); 

		ret = select2List(sql);
		return ret;
	}
	
}
