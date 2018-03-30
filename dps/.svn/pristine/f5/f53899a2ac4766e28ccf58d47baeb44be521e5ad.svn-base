/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>발주매입 공통 DAO</p>
 * 
 * @created  on 1.0, 2010/02/17
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd000DAO extends AbstractDAO {
	/**
	 * 로그인사번이 바이어/SM인지를 조회('Y')
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getBuyerYN(ActionForm form, String org_flag, String userId) throws Exception {
		
		String ret = null;
		SqlWrapper sql = null;
		Service svc = null;      
		String strQuery = "";
		int i = 1;
	
		String strToday = String2.nvl(form.getParam("strToday"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		strQuery = svc.getQuery("SEL_BUYERYN") + "\n";
		sql.put(strQuery);
		
		sql.setString(i++, strToday); 
		sql.setString(i++, org_flag);     
		sql.setString(i++, userId);  

		Map mapBuyerYN = (Map)selectMap(sql);
		if(mapBuyerYN.size() > 0){
			ret = mapBuyerYN.get("BuyerYN").toString();
		}else{
			ret = " ";
		}
		return ret;
	}
	
	/**
	 * 협력사별 반올림구분
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getVenRoundFlag(ActionForm form) throws Exception {
		
		String ret = null;
		SqlWrapper sql = null;
		Service svc = null;      
		String strQuery = "";
		int i = 1;
	
		String strToday    = String2.nvl(form.getParam("strToday"));
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		strQuery = svc.getQuery("SEL_ROUNDFLAG") + "\n";
		sql.put(strQuery);
	
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strVenCd);  
		//sql.setString(i++, strToday); 

		Map mapRoundFlag = (Map)selectMap(sql);
		if(mapRoundFlag.size() > 0){
			ret = mapRoundFlag.get("RUND_FLAG").toString();
		}else{
			ret = " ";
		}

		return ret;
	}
    

}
