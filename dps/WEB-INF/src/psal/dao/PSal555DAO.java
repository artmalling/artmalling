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

public class PSal555DAO extends AbstractDAO {

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
		
		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String CyyyyCmmCdd		= String2.nvl(form.getParam("CyyyyCmmCdd"));
		String CyyyyCmm01		= String2.nvl(form.getParam("CyyyyCmm01"));
		String Cyyyy0101		= String2.nvl(form.getParam("Cyyyy0101"));
		String CyyyyPmm01		= String2.nvl(form.getParam("CyyyyPmm01"));
		String CyyyyPmm31		= String2.nvl(form.getParam("CyyyyPmm31"));
		String PyyyyCmm01		= String2.nvl(form.getParam("PyyyyCmm01"));
		String PyyyyCmmCdd		= String2.nvl(form.getParam("PyyyyCmmCdd"));
		String Pyyyy0101		= String2.nvl(form.getParam("Pyyyy0101"));
		String PyyyyCmm31		= String2.nvl(form.getParam("PyyyyCmm31"));
		String PyyyyPmm31		= String2.nvl(form.getParam("PyyyyPmm31"));
		String Cyyyy01			= String2.nvl(form.getParam("Cyyyy01"));
		String CyyyyPmm			= String2.nvl(form.getParam("CyyyyPmm"));
		String PPyyyy			= String2.nvl(form.getParam("PPyyyy"));
		String PPyyyy1			= String2.nvl(form.getParam("PPyyyy1"));
		String strEmUnit		= String2.nvl(form.getParam("strEmUnit"));
		String if_check			= CyyyyCmmCdd.substring(4,6);

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER")); 

		
		
		sql.setString(i++, strEmUnit);
		
		sql.setString(i++, CyyyyCmmCdd);
		sql.setString(i++, CyyyyCmm01);
		sql.setString(i++, CyyyyCmmCdd);
		sql.setString(i++, strStrCd);
		
		sql.setString(i++, PyyyyCmm01);
		sql.setString(i++, PyyyyCmmCdd);
		sql.setString(i++, strStrCd);
		
		sql.setString(i++, CyyyyPmm31.substring(0,4)+"0101");
		sql.setString(i++, CyyyyPmm31);
		sql.setString(i++, strStrCd);
		
		
		if(if_check.equals("01")) {
			System.out.println("aaaaaaaaa");
			sql.setString(i++, PPyyyy1+"0101"); 
			sql.setString(i++, PPyyyy1+CyyyyPmm31.substring(4,8));
			
		} else {
			System.out.println("bbbbbbb");
			sql.setString(i++, PPyyyy+"0101");
			sql.setString(i++, PPyyyy+CyyyyPmm31.substring(4,8));
		}
		
		
		
		
		
		sql.setString(i++, strStrCd);
		
		
		
		sql.setString(i++, Cyyyy01);
		sql.setString(i++, CyyyyPmm);
		
		
		list = select2List(sql);
		
				
		
		return list;
	}
	
}
