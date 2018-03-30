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
 * 가맹점번호관리
 * </p>
 * 
 * @created on 1.0, 2010/05/23
 * @created by 조형욱
 *  
 * @modified on 
 * @modified by
 * @caused by   
 */

public class PSal903DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal903DAO.class);

	/**
	 * <p>
	 * 가맹점번호관리 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String paramStrCd = String2.nvl(form.getParam("paramStrCd"));
		String paramBcompCd = String2.nvl(form.getParam("paramBcompCd"));
		String paramJbrchType = String2.nvl(form.getParam("paramJbrchType"));
		String paramSignyn = String2.nvl(form.getParam("paramSignyn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); // + "\n";
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramSignyn);
		sql.setString(i++, paramJbrchType);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 가맹점번호관리 상세조회
	 * </p>
	 * 
	 */
	public List searchDetail(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String paramStrCd = String2.nvl(form.getParam("paramStrCd"));
		String paramBcompCd   = String2.nvl(form.getParam("paramBcompCd"));
		String paramJbrchId   = String2.nvl(form.getParam("paramJbrchId"));
		String paramJbrchType = String2.nvl(form.getParam("paramJbrchType"));

		sql = new SqlWrapper();
		svc = (Service) form.getService(); 

		connect("pot");

		query = svc.getQuery("SEL_DETAIL"); 
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramBcompCd);
		sql.setString(i++, paramJbrchId);
		sql.setString(i++, paramJbrchType);
		sql.put(query);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 클럽목록 조회
	 * </p>
	 * 
	 */
	public List getStrmstCode(ActionForm form, MultiInput mi) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String getSql = "";
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			String allGb = mi.getString("ALL_GB");
			String nulGb = mi.getString("NUL_GB");

			if ((allGb.equals("Y")) || (allGb.equals("y"))) {
				getSql = ("SELECT '%' AS CODE , '전체' AS NAME , '0'  AS SORT FROM DUAL   ")
						+ ("\n UNION \n");
			}

			if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
				// getSql =
				// ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT FROM DUAL   ")
				// + ("\n UNION \n");
			}

			getSql = getSql + svc.getQuery("SEL_STRMST_CODE");

			sql.put(getSql);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 클럽회원 마스터 조회
	 * </p>
	 * 
	 */
	public List getCardcompCode(ActionForm form, MultiInput mi)
			throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String getSql = "";
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			String allGb = mi.getString("ALL_GB");
			String nulGb = mi.getString("NUL_GB");

			if ((allGb.equals("Y")) || (allGb.equals("y"))) {
				getSql = ("SELECT '%' AS CODE , '전체' AS NAME , '0'  AS SORT FROM DUAL   ")
						+ ("\n UNION \n");
			}

			if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
				// getSql =
				// ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT FROM DUAL   ")
				// + ("\n UNION \n");
			}

			getSql = getSql + svc.getQuery("SEL_CARDCOMP_CODE");

			sql.put(getSql);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 가맹점관리 등록
	 * </p>
	 * 
	 */
	public int saveDetail(ActionForm form, MultiInput mi,
			HttpServletRequest request) throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			String strUserId = sessionInfo.getUSER_ID();

			logger.debug("mi TotalRowNum: " + mi.getTotalRowNum());

			while (mi.next()) {
				sql.close();
				if (mi.IS_UPDATE()) { // 저장
					int i = 1;
					sql.put(svc.getQuery("UPD_BRANCH"));

					sql.setString(i++, mi.getString("JBRCH_NM"));
					sql.setString(i++, mi.getString("JBRCH_TYPE"));
					sql.setString(i++, mi.getString("SIGN_YN"));
					sql.setString(i++, mi.getString("SIGN_AMT"));
					sql.setString(i++, mi.getString("PAY_DAY")); 
					sql.setString(i++, mi.getString("DEL_YN")); 
					sql.setString(i++, strUserId); // 로그인ID
					sql.setString(i++, mi.getString("STR_CD")); //
					sql.setString(i++, mi.getString("BCOMP_CD"));
					sql.setString(i++, mi.getString("JBRCH_ID"));

				} else if (mi.IS_INSERT()) {              
					int i = 1;
					sql.put(svc.getQuery("INS_BRANCH"));
					
					sql.setString(i++, mi.getString("STR_CD")); 
					sql.setString(i++, mi.getString("BCOMP_CD"));
					sql.setString(i++, mi.getString("JBRCH_ID"));
					sql.setString(i++, mi.getString("JBRCH_GB"));
					sql.setString(i++, mi.getString("JBRCH_NM"));
					sql.setString(i++, mi.getString("JBRCH_TYPE"));
					sql.setString(i++, mi.getString("SIGN_YN"));
					sql.setString(i++, mi.getString("SIGN_AMT"));
					sql.setString(i++, mi.getString("PAY_DAY"));
					sql.setString(i++, mi.getString("DEL_YN"));
					sql.setString(i++, strUserId); // 로그인ID
					sql.setString(i++, strUserId); // 로그인ID
				}
				res = update(sql);

				//
				if (res < 1) {
					// throw new Exception("데이타 처리중 오류가 발생하였습니다.");
				}
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end(); // commit()과 동일
		}

		return ret;
	}
	
	/**
	 * <p>
	 * 비용분담율 등록
	 * </p>
	 * 
	 */
	public int deleteMaster(ActionForm form, MultiInput mi,
			HttpServletRequest request) throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			String strUserId = sessionInfo.getUSER_ID();

			logger.debug("mi TotalRowNum: " + mi.getTotalRowNum());

			while (mi.next()) {
				sql.close();
				int i = 1;
				sql.put(svc.getQuery("DEL_BRANCH"));
				sql.setString(i++, mi.getString("DEL_YN"));
				sql.setString(i++, strUserId); // 로그인ID
				sql.setString(i++, mi.getString("STR_CD")); //
				sql.setString(i++, mi.getString("BCOMP_CD"));
				sql.setString(i++, mi.getString("JBRCH_ID"));

				res = update(sql);

				//
				if (res < 1) {
					// throw new Exception("데이타 처리중 오류가 발생하였습니다.");
				}
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end(); // commit()과 동일
		}

		return ret;
	}
}
