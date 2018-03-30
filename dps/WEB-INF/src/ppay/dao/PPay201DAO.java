/*
 * Copyright (c) 2010 한국후지쯔 All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔
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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>선급금/공제/보류 조회</p>
 * 
 * @created  on 1.0, 2010/05/09
 * @created  by 김경은
 * 
 * @modified on  
 * @modified by                    
 * @caused   by 
 */

public class PPay201DAO extends AbstractDAO {

	/**
	 * 선급금/공제/보류 조회
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
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm  = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc  = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt  = String2.nvl(form.getParam("strPayCnt"));
		String strVenCd   = String2.nvl(form.getParam("strVenCd"));
		String strPumCd   = String2.nvl(form.getParam("strPumCd"));
	
		sql = new SqlWrapper();     
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 선급금/공제/보류  상세 데이터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form) throws Exception {
		                         
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm  = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc  = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt  = String2.nvl(form.getParam("strPayCnt"));
		String strVenCd   = String2.nvl(form.getParam("strVenCd"));
		String strPumCd   = String2.nvl(form.getParam("strPumCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[3];
		
		connect("pot");
         
		i = 1;
		sql.close();
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		ret[0] = select2List(sql);  
		
		i = 1;
		sql.close();
		
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		ret[1] = select2List(sql);   

		
		i = 1;
		sql.close();
		
		strQuery = svc.getQuery("SEL_DETAIL3") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		ret[2] = select2List(sql);   

		return ret;
	}
}
