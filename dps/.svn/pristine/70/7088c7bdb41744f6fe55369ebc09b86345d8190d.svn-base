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

import org.apache.log4j.Logger;
import ksnet.SignPad;

/**
 * <p>
 * 전자서명조회 DAO
 * </p>
 * 
 * @created on 1.0, 2010/06/09 
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal941DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal941DAO.class);

	/**
	 * <p>
	 * 전자서명조회 
	 * </p>
	 *   
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List       ret = null;
		SqlWrapper sql = null;
		Service    svc = null;
        String strQuery = "";
        
		int i = 1;
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strSaleDt 	= String2.nvl(form.getParam("strSaleDt"));
		String strPosNo 	= String2.nvl(form.getParam("strPosNo"));
		String strTranNoS 	= String2.nvl(form.getParam("strTranNoS"));
		String strTranNoE 	= String2.nvl(form.getParam("strTranNoE"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

        strQuery = svc.getQuery("SEL_MASTER"); 
        
		sql.setString( i++,  strStrCd   );
		sql.setString( i++,  strSaleDt  );
		sql.setString( i++,  strPosNo   );
        
		if (!"".equals(strTranNoS) && !"".equals(strTranNoE)){
			strQuery += "\n               AND A.TRAN_NO  BETWEEN ? AND ? ";
			sql.setString( i++,  strTranNoS );
			sql.setString( i++,  strTranNoE );
		}else if (!"".equals(strTranNoS)){
			strQuery += "\n               AND A.TRAN_NO  = ? ";
			sql.setString( i++,  strTranNoS );
		}

		sql.put(strQuery);
		ret = select2List(sql);
		
		

		return ret;
	}
	
	/**
	 * <p>
	 * 전자서명조회 
	 * </p>
	 *   
	 */
	public List searchDetail(ActionForm form) throws Exception {
		List       ret = null;
		SqlWrapper sql = null;
		Service    svc = null;
        String strQuery = "";
        
		int i = 1;
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strSaleDt 	= String2.nvl(form.getParam("strSaleDt"));
		String strPosNo 	= String2.nvl(form.getParam("strPosNo"));
		String strTranNo 	= String2.nvl(form.getParam("strTranNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

        strQuery = svc.getQuery("SEL_DETAIL"); 
        
		sql.setString( i++,  strStrCd   );
		sql.setString( i++,  strSaleDt  );
		sql.setString( i++,  strPosNo   );
		sql.setString( i++,  strTranNo  );

		sql.put(strQuery);
		ret = select2List(sql);
		
		

		return ret;
	}
}
