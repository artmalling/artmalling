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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>영업관리 > 매출관리 > POS정산 > POS마감현황</p>
 * 
 * @created  on 1.0, 2010/07/07
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal509DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {

		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFloorCd 		= String2.nvl(form.getParam("strFloorCd"));
		String strPosFlag 		= String2.nvl(form.getParam("strPosFlag"));
		String strDt            = String2.nvl(form.getParam("strDt"));//Date2.getThisDay("YYYYMMDD");
		String strHallCd  		= String2.nvl(form.getParam("strHallCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strHallCd);
		
		if( !strPosFlag.equals("")&&!strPosFlag.equals("%")){
			sql.put(svc.getQuery("SEL_MASTER_WHERE_POS_FLAG"));
			sql.setString(i++, strPosFlag);
		}

		if( !strFloorCd.equals("")&&!strFloorCd.equals("%")){
			sql.put(svc.getQuery("SEL_MASTER_WHERE_FLOR_CD"));
			sql.setString(i++, strFloorCd);
		}
		sql.put(svc.getQuery("SEL_MASTER_ORDER"));

		ret = select2List(sql);

		return ret;
	}
	

	/**
	 * 일별매출정보을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDay(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strDt 		= String2.nvl(form.getParam("strDt"));
		String strPosNo  	= String2.nvl(form.getParam("strPosNo"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DAY_INFO"));
		
		sql.setString(i++, strPosNo);
		sql.setString(i++, strDt);

		ret = select2List(sql);

		return ret;
	}

}
