/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>판매사원조회</p>
 * 
 * @created  on 1.0, 2010/05/03
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod806DAO extends AbstractDAO {

	/**
	 * 판매사원 마스터 을 조회한다.
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

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleUserId  = String2.nvl(form.getParam("strSaleUserId"));
		String strEmpName     = URLDecoder.decode( String2.nvl(form.getParam("strEmpName")), "UTF-8");
		String strOrgCd       = String2.nvl(form.getParam("strOrgCd"));
		String strOrgName     = URLDecoder.decode( String2.nvl(form.getParam("strOrgName")), "UTF-8");
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
		String strPumbunName  = URLDecoder.decode( String2.nvl(form.getParam("strPumbunName")), "UTF-8");
		String strPosAuthFlag = String2.nvl(form.getParam("strPosAuthFlag"));
		String strEmpFlag = String2.nvl(form.getParam("strEmpFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_SALEUSERMST") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strSaleUserId.equals("") ){
			sql.setString(i++, strSaleUserId);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_SALE_USER_ID") + "\n";
		}
		if( !strEmpName.equals("") ){
			sql.setString(i++, strEmpName);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_EMP_NAME") + "\n";
		}
		if( !strOrgCd.equals("") ){
			sql.setString(i++, strOrgCd);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_ORG_CD") + "\n";
		}
		if( !strOrgName.equals("") ){
			sql.setString(i++, strOrgName);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_ORG_NAME") + "\n";
		}
		if( !strPumbunCd.equals("") ){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_PUMBUN_CD") + "\n";
		}
		if( !strPumbunName.equals("") ){
			sql.setString(i++, strPumbunName);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_PUMBUN_NAME") + "\n";
		}
		if( !strPosAuthFlag.equals("%") ){
			sql.setString(i++, strPosAuthFlag);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_POS_AUTH_FLAG") + "\n";
		}
		if( !strEmpFlag.equals("%") ){
			sql.setString(i++, strEmpFlag);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_EMP_FLAG") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_SALEUSERMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
