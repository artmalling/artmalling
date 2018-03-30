/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
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

public class PSal540DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strGubun 		= String2.nvl(form.getParam("strGubun"));
		String strBrdCd 		= URLDecoder.decode( String2.nvl(form.getParam("strBrdCd")), "UTF-8");
		String strBrdNm 		= URLDecoder.decode( String2.nvl(form.getParam("strBrdNm")), "UTF-8");
		String strEmUnit 		 = String2.nvl(form.getParam("strEmUnit"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		System.out.println(strBrdNm);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strGubun.equals("1")){
			strQuery = svc.getQuery("SEL_SALE_MALL");
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);

			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strBrdCd);
			sql.setString(i++, strBrdNm);
			
			sql.put(strQuery);
			
		}else if(strGubun.equals("2")){
			strQuery = svc.getQuery("SEL_SALE_BRAND");
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strBrdCd);
			sql.setString(i++, strBrdNm);
			
			sql.put(strQuery);
		}else if(strGubun.equals("3")){
			strQuery = svc.getQuery("SEL_SALE_PC");
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);

			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strBrdCd);
			sql.setString(i++, strBrdNm);
			
			sql.put(strQuery);
		}else if(strGubun.equals("4")){
			strQuery = svc.getQuery("SEL_SALE_PUMMOK");
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strBrdCd);
			sql.setString(i++, strBrdNm);
			
			sql.put(strQuery);
		}else if(strGubun.equals("5")){
			strQuery = svc.getQuery("SEL_SALE_BRAND2");
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strBrdCd);
			sql.setString(i++, strBrdNm);
			
			sql.put(strQuery);
		}else if(strGubun.equals("6")){
			strQuery = svc.getQuery("SEL_SALE_PC2");
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strBrdCd);
			sql.setString(i++, strBrdNm);
			
			sql.put(strQuery);
		}
		
		ret = select2List(sql);
		
		return ret;
	}


}
