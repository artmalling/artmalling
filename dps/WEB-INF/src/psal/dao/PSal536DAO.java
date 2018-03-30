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

import common.util.*;

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

public class PSal536DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List list 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		Util util		= new Util();
	
		int i 			= 1;
		
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strS_dt		= String2.nvl(form.getParam("strS_dt"));
		String strE_dt		= String2.nvl(form.getParam("strE_dt"));
		String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));
		String strOrdererCd	= String2.nvl(form.getParam("strOrdererCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strS_dt);
		sql.setString(i++, strE_dt);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strOrdererCd);
		
		list = select2List(sql);
		
		System.out.println(list);
		//list = util.decryptedStr(list,3);
		
		
		//System.out.println(util.decryptedStr(ret,3));
		
		return list;
	}
	
}
