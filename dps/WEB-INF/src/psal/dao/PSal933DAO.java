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
 * <p> 입금상세데이터 조회DAO </p>
 * 
 * @created on 1.0, 2010/06/01
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal933DAO extends AbstractDAO {
	/**
	 * <p>
	 * 입금상세데이터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		String strPayDtS   = String2.nvl(form.getParam("strPayDtS"));  
		String strPayDtE   = String2.nvl(form.getParam("strPayDtE"));   
		String strCcomCd   = String2.nvl(form.getParam("strCcomCd"));  
		String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));   
		String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));  
		String strDataFlag = String2.nvl(form.getParam("strDataFlag"));  
		String strCardNo   = String2.nvl(form.getParam("strCardNo"));    
		String strApprNo   = String2.nvl(form.getParam("strApprNo"));  
		String strGubun 	= String2.nvl(form.getParam("strGubun"));
		
		if(strGubun.equals("2")){
		    strPayDtS  = String2.nvl(form.getParam("strPayDtS")).substring(2,8);    
		    strPayDtE  = String2.nvl(form.getParam("strPayDtE")).substring(2,8);
		}
		
		connect("pot"); 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
        sql.setString(i++, strGubun);
		sql.setString(i++, strPayDtS  );   
		sql.setString(i++, strPayDtE  );
		sql.setString(i++, strCcomCd  );
		sql.setString(i++, strBcompCd );
		sql.setString(i++, strJbrchId );
		sql.setString(i++, strDataFlag );
		sql.setString(i++, strCardNo  );
		sql.setString(i++, strApprNo  );

		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
}
