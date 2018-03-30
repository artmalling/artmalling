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

/**
 * <p>
 * 매입사별 POS 카드매출현황 DAO
 * </p>
 * 
 * @created on 1.0, 2011/08/10
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal926DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal926DAO.class);

	/**
	 * <p>
	 * 매입사별 POS 카드매출현황 목록 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramSaleDt1 = String2.nvl(form.getParam("paramSaleDt1"));
		String paramSaleDt2 = String2.nvl(form.getParam("paramSaleDt2"));
		String paramPosNo1  = String2.nvl(form.getParam("paramPosNo1"));
		String paramPosNo2  = String2.nvl(form.getParam("paramPosNo2"));
		String paramBcompCd = String2.nvl(form.getParam("paramBcompCd"));
		
		connect("pot");
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		
		if(paramPosNo1.equals("")){
			paramPosNo1 = "0000";
		}
		if(paramPosNo2.equals("")){
			paramPosNo2 = "9999";
		}

		query = svc.getQuery("SEL_MASTER");
		
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * <p>
	 * 매입사별 POS 카드매출현황 목록 조회
	 * </p>
	 * 
	 */
	public List searchDetail(ActionForm form) throws Exception { 
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";   
 
	    int i = 1;
		
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd")); 
		String paramSaleDt1 = String2.nvl(form.getParam("paramSaleDt1"));
		String paramSaleDt2 = String2.nvl(form.getParam("paramSaleDt2"));
		String paramPosNo1  = String2.nvl(form.getParam("paramPosNo1"));
		String paramPosNo2  = String2.nvl(form.getParam("paramPosNo2"));
		String paramBcompCd = String2.nvl(form.getParam("paramBcompCd"));
		
		connect("pot");
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		if(paramPosNo1.equals("")){
			paramPosNo1 = "0000";
		}
		if(paramPosNo2.equals("")){
			paramPosNo2 = "9999";
		}
		
		query = svc.getQuery("SEL_DETAIL");
		
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);

		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
}
