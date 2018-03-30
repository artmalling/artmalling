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
 * 청구데이터 DAO
 * </p>
 * 
 * @created on 1.0, 2010/05/23
 * @created by 조형욱
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal925DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal925DAO.class);

	/**
	 * <p>
	 * 청구데이터 목록 조회
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
		String paramBcompCd = String2.nvl(form.getParam("paramBcompCd"));
		String paramSaleDt1 = String2.nvl(form.getParam("paramSaleDt1"));
		String paramSaleDt2 = String2.nvl(form.getParam("paramSaleDt2"));
		String paramReqDt1  = String2.nvl(form.getParam("paramReqDt1"));
		String paramReqDt2  = String2.nvl(form.getParam("paramReqDt2"));
		String paramPosNo1  = String2.nvl(form.getParam("paramPosNo1"));
		String paramPosNo2  = String2.nvl(form.getParam("paramPosNo2"));
		String paramBrchCd  = String2.nvl(form.getParam("paramBrchCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); // + "\n";
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);		
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramReqDt1);
		sql.setString(i++, paramReqDt2);
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramReqDt1);
		sql.setString(i++, paramReqDt2);
		sql.setString(i++, paramPosNo1); 
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramBrchCd);
		
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramReqDt1);
		sql.setString(i++, paramReqDt2);
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramReqDt1);
		sql.setString(i++, paramReqDt2);
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramBrchCd);
		
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramSaleDt1);
		sql.setString(i++, paramSaleDt2);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramReqDt1);
		sql.setString(i++, paramReqDt2);
		sql.setString(i++, paramPosNo1);
		sql.setString(i++, paramPosNo2);
		sql.setString(i++, paramBrchCd);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
}
