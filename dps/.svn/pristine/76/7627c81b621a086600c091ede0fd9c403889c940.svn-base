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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import common.vo.SessionInfo;

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

public class PSal924DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal924DAO.class); 

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
		String paramStrCd 		= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 		= String2.nvl(form.getParam("paramReqDt"));
		String paramReqToDt 	= String2.nvl(form.getParam("paramReqToDt"));
		String paramChrgSeq 	= String2.nvl(form.getParam("paramChrgSeq"));
		String paramCcompCd 	= String2.nvl(form.getParam("paramCcompCd"));
		String paramBcompCd 	= String2.nvl(form.getParam("paramBcompCd"));
		String paramBrchId 		= String2.nvl(form.getParam("paramBrchId"));
		String paramCardNo 		= String2.nvl(form.getParam("paramCardNo"));
		String paramApprNo 		= String2.nvl(form.getParam("paramApprNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); // + "\n";
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.setString(i++, paramReqToDt);
		sql.setString(i++, paramChrgSeq);
		sql.setString(i++, paramCcompCd);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramBrchId);
		sql.setString(i++, paramCardNo);
		sql.setString(i++, paramApprNo);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
}
