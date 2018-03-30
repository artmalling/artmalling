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

public class PSal320DAO extends AbstractDAO {

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
		
		String YYYY		 		= String2.nvl(form.getParam("YYYY"));
		String P_YYYY	 		= String2.nvl(form.getParam("P_YYYY"));
		String strEmUnit 		= String2.nvl(form.getParam("strEmUnit"));
		
		int intGubun              = 0;	//금액을 원단위로 표현할지 천원단위로 표현할지를 결정한다.
		
		
		if(strEmUnit.equals("02")){
			intGubun=1000;
		}else{
			intGubun=1;
		}
		System.out.println("intGubun : "+intGubun);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));
		
		//YYYY
		//P_YYYY
		//strEmUnit
		//////////////////////////////////////////////////////////////////	1관
		sql.setString(i++, YYYY);	//총매출액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//매출실장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		
		sql.setString(i++, P_YYYY);	//전년총매출액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익율
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		
		sql.setString(i++, YYYY);	//객수
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객수
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		sql.setString(i++, YYYY);	//객수신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//객단가
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객단가
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, YYYY);	//객단가신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		////////////////////////////////////////////////////////////////////			2관
		sql.setString(i++, YYYY);	//총매출액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		

		
		sql.setString(i++, YYYY);	//매출실장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		
		sql.setString(i++, P_YYYY);	//전년총매출액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익율
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		sql.setString(i++, YYYY);	//객수
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객수
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		sql.setString(i++, YYYY);	//객수신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//객단가
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객단가
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, YYYY);	//객단가신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		////////////////////////////////////////////////////////////////////1,2관
		sql.setString(i++, YYYY);	//총매출액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		

		
		sql.setString(i++, YYYY);	//매출실장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		sql.setString(i++, P_YYYY);	//전년총매출액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익율
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		
		sql.setString(i++, YYYY);	//객수
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객수
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		sql.setString(i++, YYYY);	//객수신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//객단가
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객단가
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, YYYY);	//객단가신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		////////////////////////////////////////////////////////////////////3관
		sql.setString(i++, YYYY);	//총매출액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//매출실장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		
		sql.setString(i++, P_YYYY);	//전년총매출액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익율
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		
		sql.setString(i++, YYYY);	//객수
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객수
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		sql.setString(i++, YYYY);	//객수신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//객단가
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객단가
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, YYYY);	//객단가신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		////////////////////////////////////////////////////////////////////총합
		sql.setString(i++, YYYY);	//총매출액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익액
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//이익율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		

		
		sql.setString(i++, YYYY);	//매출실장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		
		sql.setString(i++, P_YYYY);	//전년총매출액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익액
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setInt(i++, intGubun);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, P_YYYY);	//전년이익율
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, YYYY);	//객수
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객수
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		
		sql.setString(i++, YYYY);	//객수신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, YYYY);	//객단가
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		
		sql.setString(i++, P_YYYY);	//전년객단가
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		
		sql.setString(i++, YYYY);	//객단가신장율
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, P_YYYY);
		sql.setString(i++, YYYY);
		
		
		

		ret = select2List(sql);
		
		return ret;
	}


}
