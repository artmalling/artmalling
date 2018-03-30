/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

/**
 * <p>
 * 좌측 프레임 구성
 * </p>
 * 
 * @created on 1.0, 2010/12/14
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class DCtm134DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm134DAO.class);

	/**
	 * <p>
	 * 클럽회원 마스터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form, GauceDataSet dSet) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";

		String strFromDt 	= dSet.getDataRow(0).getColumnValue(0).toString(); 
        String strToDt 		= dSet.getDataRow(0).getColumnValue(1).toString(); 
        
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MASTER"); // + "\n";
		int i = 1;
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 클럽회원 목록 조회
	 * </p>
	 * 
	 */
	public List searchDetail(ActionForm form, GauceDataSet dSet) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

//		String strName = String2.nvl(form.getParam("strName"));
//		String strClubId = String2.nvl(form.getParam("strClubId"));
//		String strFromDt = String2.nvl(form.getParam("strFromDt"));
//		String strToDt = String2.nvl(form.getParam("strToDt"));
//		String strCompFlag = String2.nvl(form.getParam("strCompFlag"));
		
		String strName   	= dSet.getDataRow(0).getColumnValue(0).toString();    
        String strClubId   	= dSet.getDataRow(0).getColumnValue(1).toString();        
        String strCompFlag 	= dSet.getDataRow(0).getColumnValue(2).toString(); 
        String strFromDt 	= dSet.getDataRow(0).getColumnValue(3).toString(); 
        String strToDt 		= dSet.getDataRow(0).getColumnValue(4).toString(); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
		sql.setString(i++, strName);
		sql.setString(i++, strClubId);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);
		sql.setString(i++, strCompFlag);

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
}
