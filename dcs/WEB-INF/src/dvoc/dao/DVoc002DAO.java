/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */ 

package dvoc.dao;

import java.util.List;
import java.util.Map;

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
 * 예제 DAO
 * </p>
 * 
 * @created on 1.0, 2010/05/23
 * @created by 조형욱
 * 
 * @modified on
 * @modified by fkss(2010.07.19)
 * @caused by
 */

public class DVoc002DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DVoc002DAO.class);

	/**
	 * <p>
	 * 고객 클레임 마스터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		 String strStrCd           = String2.nvl(form.getParam("strStrCd"));
	     String strSrecDt     = String2.nvl(form.getParam("strSrecDt"));
	     String strErecDt       = String2.nvl(form.getParam("strErecDt"));
	     String strClmKind             = String2.nvl(form.getParam("strClmKind"));
	     String strProgGbn           = String2.nvl(form.getParam("strProgGbn"));
	     String strSrecSeq     = String2.nvl(form.getParam("strSrecSeq"));
	     String strErecSeq       = String2.nvl(form.getParam("strErecSeq"));
	     String strMbrGb             = String2.nvl(form.getParam("strMbrGb"));
	     String strRecType        = String2.nvl(form.getParam("strRecType"));
	     String strCustId        = String2.nvl(form.getParam("strCustId"));
	     String strCustNm        = String2.nvl(form.getParam("strCustNm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); // + "\n";
	    sql.setString(i++, strStrCd);
        sql.setString(i++, strSrecDt);
        sql.setString(i++, strErecDt);
        sql.setString(i++, strClmKind);
        sql.setString(i++, strProgGbn);
        sql.setString(i++, strSrecSeq);
        sql.setString(i++, strErecSeq);
        sql.setString(i++, strMbrGb);
        sql.setString(i++, strRecType);
        sql.setString(i++, strCustId);
        sql.setString(i++, strCustNm);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	/**
	 * 계약변경이력 POPUP - 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		
		try {
			
			String strStrCd	 	= String2.nvl(form.getParam("strStrCd"));
			String strCustId 	= String2.nvl(form.getParam("strCustId"));
			String strRecDt     = String2.nvl(form.getParam("strRecDt"));
			String strRecSeq     = String2.nvl(form.getParam("strRecSeq"));
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");
			sql.put(svc.getQuery("SEL_DETAIL"));
			sql.setString(i++, strStrCd);
			sql.setString(i++, strCustId);
			sql.setString(i++, strRecDt);
			sql.setString(i++, strRecSeq);

			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		} 
		return list;
	}

}
