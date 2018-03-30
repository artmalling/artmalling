/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae413DAO extends AbstractDAO {
	/**
	 * 사은행사지급내역(사원별)
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
			
		String strStrCd  = String2.nvl(form.getParam("strStrCd"));
		String strSaledt = String2.nvl(form.getParam("strSaledt"));
		String strPosno  = String2.nvl(form.getParam("strPosno"));
		String strTranno = String2.nvl(form.getParam("strTranno"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strSaledt.equals("")){
			sql.setString(i++, strSaledt);
			strQuery += svc.getQuery("SEL_SALE_DT") + "\n";
		}
		
		if( !strPosno.equals("")){
			sql.setString(i++, strPosno);
			strQuery += svc.getQuery("SEL_POS_NO") + "\n";
		}
		
		if( !strTranno.equals("")){
			sql.setString(i++, strTranno);
			strQuery += svc.getQuery("SEL_TRAN_NO") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_EVENT_ORDER");
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	

}
