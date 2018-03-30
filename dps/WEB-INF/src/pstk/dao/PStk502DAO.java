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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/05/12
 * @created  by 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk502DAO extends AbstractDAO {


	/**
	 * 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List search(ActionForm form, String userid) throws Exception { 
		 
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strFromYm     = String2.nvl(form.getParam("strFromYm"));			
		String strToYm    	 = String2.nvl(form.getParam("strToYm"));
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		
		String strFlag1       = String2.nvl(form.getParam("strFlag1"));
		String strFlag2       = String2.nvl(form.getParam("strFlag2"));
		
		String strCheckBox1       = String2.nvl(form.getParam("strCheckBox1"));
		String strCheckBox2       = String2.nvl(form.getParam("strCheckBox2"));
		String strCheckBox3       = String2.nvl(form.getParam("strCheckBox3"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		if(strFlag1.equals("A")){
			if(strFlag2.equals("1")){
				strQuery = svc.getQuery("SEL_MASTER1");
			} else if(strFlag2.equals("2")){
				strQuery = svc.getQuery("SEL_MASTER2");
			} else {
				strQuery = svc.getQuery("SEL_MASTER3");
			}
		} else if(strFlag1.equals("B")){
			if(strFlag2.equals("1")){
				strQuery = svc.getQuery("SEL_MASTER4");
			} else if(strFlag2.equals("2")){
				strQuery = svc.getQuery("SEL_MASTER5");
			} else {
				strQuery = svc.getQuery("SEL_MASTER6");
			}
		} else if(strFlag1.equals("C")){
			if(strFlag2.equals("1")){
				strQuery = svc.getQuery("SEL_MASTER7");
			} else if(strFlag2.equals("2")){
				strQuery = svc.getQuery("SEL_MASTER8");
			} else {
				strQuery = svc.getQuery("SEL_MASTER9");
			}
		}

		sql.put(strQuery);
		
		sql.setString(i++, strFromYm);
		sql.setString(i++, strToYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, userid);

		ret = select2List(sql);
		
		return ret;
	}
	
	public List searchMonth(ActionForm form, String userid) throws Exception { 
		 
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strFromYm     = String2.nvl(form.getParam("strFromYm"));			
		String strToYm    	 = String2.nvl(form.getParam("strToYm"));
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		
		String strFlag1       = String2.nvl(form.getParam("strFlag1"));
		String strFlag2       = String2.nvl(form.getParam("strFlag2"));
		
		String strCheckBox1       = String2.nvl(form.getParam("strCheckBox1"));
		String strCheckBox2       = String2.nvl(form.getParam("strCheckBox2"));
		String strCheckBox3       = String2.nvl(form.getParam("strCheckBox3"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		if(strFlag1.equals("A")){
			if(strFlag2.equals("1")){
				strQuery = svc.getQuery("SEL_MASTER1");
			} else if(strFlag2.equals("2")){
				strQuery = svc.getQuery("SEL_MASTER2");
			} else {
				strQuery = svc.getQuery("SEL_MASTER3");
			}
		} else if(strFlag1.equals("B")){
			if(strFlag2.equals("1")){
				strQuery = svc.getQuery("SEL_MASTER4");
			} else if(strFlag2.equals("2")){
				strQuery = svc.getQuery("SEL_MASTER5");
			} else {
				strQuery = svc.getQuery("SEL_MASTER6");
			}
		} else if(strFlag1.equals("C")){
			if(strFlag2.equals("1")){
				strQuery = svc.getQuery("SEL_MASTER7");
			} else if(strFlag2.equals("2")){
				strQuery = svc.getQuery("SEL_MASTER8");
			} else {
				strQuery = svc.getQuery("SEL_MASTER9");
			}
		}

		sql.put(strQuery);
		
		sql.setString(i++, strFromYm);
		sql.setString(i++, strToYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, userid);
		
		sql.setString(i++, strCheckBox1);
		sql.setString(i++, strCheckBox2);
		sql.setString(i++, strCheckBox3);
		
		sql.setString(i++, strFromYm); 
		sql.setString(i++, strToYm);
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, userid);
		
		sql.setString(i++, strCheckBox1);
		sql.setString(i++, strCheckBox2);
		sql.setString(i++, strCheckBox3);
		
		ret = select2List(sql);
		
		return ret;
	}
}
