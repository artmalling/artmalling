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

public class PSal318DAO extends AbstractDAO {

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userid) throws Exception {// String OrgFlag,
		
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strCuLv 		    = String2.nvl(form.getParam("strCuLv"));
		int intGubun              = 0;	//금액을 원단위로 표현할지 천원단위로 표현할지를 결정한다.
		
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));
		String strOrgFlag      = String2.nvl(form.getParam("strOrgFlag"));
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));
		String strEmUnit        = String2.nvl(form.getParam("strEmUnit"));
		
		
		/*if("0".equals(strCuLv)){	    //원단위 표현일때 나눌수를 셋팅
			intGubun = 1;
			
		}else if("1".equals(strCuLv)){	//천원단위로 표현할떄 나눌수를 셋팅
			intGubun = 1000;
		}*/
		if(strEmUnit.equals("02")){
			intGubun=1000;
		}else{
			intGubun=1;
		}
		System.out.println("intGubun : "+intGubun);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		strQuery = svc.getQuery("SEL_TIMESALEPUMBUN_SEL") + "\n"; 
		
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		sql.setInt(i++, 1);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		sql.setInt(i++, intGubun);
		
		
			
			
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);

		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, userid);
								
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);

	

		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, userid);

		
		

		strQuery += svc.getQuery("SEL_TIMESALEPUMBUN_ORDERBY"); 
		

		sql.put(strQuery);
		ret = select2List(sql);
		
		
		return ret;
	}

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCmprdt(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CMPRDT"));
		
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		

		ret = select2List(sql);
		
		return ret;
	}

}
