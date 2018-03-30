/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;

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
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk203DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */

	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkSdt     = String2.nvl(form.getParam("strStkSdt"));
		String strStkEDt     = String2.nvl(form.getParam("strStkEDt"));
		String strStkYmBf    = String2.nvl(form.getParam("strStkYmBf"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strSkuType    = String2.nvl(form.getParam("strSkuType"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strStkEDt);
		

		strQuery = svc.getQuery("SEL_STKSKU") + "\n";
		
		if(strSkuType.equals("3")){			
			strQuery += svc.getQuery("SEL_STKSKU_ORDER_STYLE");
		}else{			
			strQuery += svc.getQuery("SEL_STKSKU_ORDER");
		}
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnStk(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_PBNSTK");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnInf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd      = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_PBNINF");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
    

}
