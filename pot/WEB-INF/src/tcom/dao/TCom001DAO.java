/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

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

import common.vo.SessionInfo;
 

/**
 * <p>로그인 체크</p>
 *
 * @created  on 1.0, 2010/12/10
 * @created  by 정지인(FUJITSU KOREA LTD.)
 *
 * @modified on
 * @modified by
 * @caused   by
 */

public class TCom001DAO extends AbstractDAO {

	/**
	 * 사용자 조회
	 * @param string
	 *
	 * @param svc
	 * @return Map
	 */
	public Map chkID(ActionForm form, SessionInfo sessionInfo, HttpServletRequest request) throws Exception {

		Map myMap 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;

		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_TC_USRMST"));
			if( sessionInfo != null) {
				sql.setString(1, sessionInfo.getUSER_ID());
			}
			else {
				String userId = "";
				HttpSession session = request.getSession();
				if ("".equals(form.getParam("id"))) {
					userId = (String)session.getAttribute("dupLoginId");
				}
				else {
					userId = form.getParam("id").toString();
				}
				sql.setString(1, userId);
			}

			connect("pot");
			myMap = selectMap(sql);

		} catch (Exception e) {
			throw e;
		}

		return myMap;
	}

	/**
	 * 공지사항조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchNotice(ActionForm form, String strPart, String strOrgCd, int iStartRow, int iEndRow) throws Exception {

		List ret		= null;
		SqlWrapper sql	= null;
		Service svc		= null;
		//String strLoc	= null;
		String strQuery	= "";

		int i=0;

		try {

			sql	= new SqlWrapper();
			svc	= (Service) form.getService();

			strQuery = svc.getQuery("SEL_NOTICE_LIST1") + "\n";

			strQuery += svc.getQuery("SEL_NOTICE_WHERE1") + "\n";
			sql.setString(++i, strOrgCd);

			strQuery += svc.getQuery("SEL_NOTICE_LIST2") + "\n";

			if( !strPart.equals("ALL")){
				strQuery += svc.getQuery("SEL_NOTICE_WHERE2") + "\n";
				sql.setString(++i, strPart);
			}

			strQuery += svc.getQuery("SEL_NOTICE_ORDER") + "\n";
			sql.setInt(++i, iStartRow);
			sql.setInt(++i, iEndRow);

			connect("pot");
			sql.put(strQuery);
			ret = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

	/**
	 * 공지사항 총 건수
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public Map searchNoticeCnt(ActionForm form, String strPart, String strOrgCd) throws Exception {

		Map ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		int i = 0;

		String strQuery = "";
		try {

			svc = (Service) form.getService();
			sql = new SqlWrapper();

			strQuery = svc.getQuery("SEL_NOTICE_TOTAL_CNT1") + "\n";

			if( !strPart.equals("ALL")){
				sql.setString(++i, strPart);
				strQuery += svc.getQuery("SEL_NOTICE_TOTAL_CNT_WHERE1") + "\n";
			}

			strQuery +=  svc.getQuery("SEL_NOTICE_TOTAL_CNT2") + "\n";

			if( !strPart.equals("ALL")){
				sql.setString(++i, strPart);
				strQuery += svc.getQuery("SEL_NOTICE_TOTAL_CNT_WHERE1") + "\n";
			}

			strQuery += svc.getQuery("SEL_NOTICE_TOTAL_CNT_WHERE2") + "\n";
			sql.setString(++i, strOrgCd);


			strQuery += svc.getQuery("SEL_NOTICE_TOTAL_CNT_END") + "\n";

			connect("pot");

			sql.put(strQuery);
			ret = selectMap(sql);

		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

	/**
	 * 날씨 예보조회_일자만조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public Map searchWeater(ActionForm form) throws Exception {

		Map ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;

		try {

			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_WEATHER"));
			connect("pot");

			ret = selectMap(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}


	/**
	 * 매출속보 조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSale(ActionForm form, MultiInput mi) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strDt    = String2.nvl(form.getParam("strDt"));
		String strUnit  = String2.nvl(form.getParam("strUnit"));

		strUnit  = strUnit.equals("")?"1":(Integer.valueOf(strUnit)<1?"1":strUnit);

		connect("pot");

		strQuery           += "SELECT TIME_TAB.TIME_GUBN "       +"\n";
		strQuery           += "     , TIME_TAB.TIME_GUBN_NAME "  +"\n";
		strQuery           += "     , TIME_VISIT.IN_CNT             AS IN_CNT "        +"\n";
		strQuery           += "     , TIME_VISIT.IN_TOT_CNT         AS IN_TOT_CNT "    +"\n";
		strQuery           += "     , TIME_SALE.TEAM_TOTAL_AMT " +"\n";
		strQuery           += "     , TIME_SALE.TEAM_TOTAL_CNT " +"\n";
		// 시간별 팀조직 매출 정보 조회
		String teamList     = "";

		String columnQuery1 = "SELECT TIME_GUBN " + "\n";
		columnQuery1       += "     , SUM(NORM_SALE_AMT)/"+strUnit+"       AS TEAM_TOTAL_AMT " + "\n";
		columnQuery1       += "     , SUM(CUST_CNT)                        AS TEAM_TOTAL_CNT " + "\n";

		String columnQuery2 = "  FROM (SELECT TIME_GUBN" + "\n";
		columnQuery2       += "             , NORM_SALE_AMT " + "\n";
		columnQuery2       += "             , CUST_CNT " + "\n";
		int teamCnt        = 0;

		while (mi.next()) {
			if( teamCnt != 0 ){
				teamList   += ",";
			}
			teamList       += "'"+mi.getString("CODE_CD")+"'";

			strQuery       += "     , TIME_SALE.TEAM_"+mi.getString("CODE_CD")+"_AMT " +"\n";
			strQuery       += "     , TIME_SALE.TEAM_"+mi.getString("CODE_CD")+"_CNT " +"\n";

			columnQuery1   += "     , SUM(TEAM_"+mi.getString("CODE_CD")+"_AMT)/"+strUnit+" AS TEAM_"+mi.getString("CODE_CD")+"_AMT" + "\n";
			columnQuery1   += "     , SUM(TEAM_"+mi.getString("CODE_CD")+"_CNT)             AS TEAM_"+mi.getString("CODE_CD")+"_CNT" + "\n";

			columnQuery2   += "             , CASE WHEN TEAM_CD = '"+mi.getString("CODE_CD")+"' THEN NORM_SALE_AMT END AS TEAM_"+mi.getString("CODE_CD")+"_AMT" + "\n";
			columnQuery2   += "             , CASE WHEN TEAM_CD = '"+mi.getString("CODE_CD")+"' THEN CUST_CNT      END AS TEAM_"+mi.getString("CODE_CD")+"_CNT" + "\n";
			teamCnt++;
		}

		columnQuery2       += "          FROM (" + "\n";
		columnQuery2       += svc.getQuery("SEL_TIMEPBN_ORG") + "\n";
		columnQuery2       += "               )" + "\n";
		columnQuery2       += "         WHERE TEAM_CD IN ("+teamList+")" + "\n";
		columnQuery2       += "        )" + "\n";
		columnQuery2       += "  GROUP BY TIME_GUBN" + "\n";

		// 조직별 시간대별 매출 조건
		sql.setString(++i, strStrCd);
		sql.setString(++i, strDt);

		strQuery           += "  FROM ( " +"\n";
		strQuery           += "        " + svc.getQuery("SEL_TIME_TAB_INFO")+"\n";
		strQuery           += "       ) TIME_TAB " +"\n";

		// 조직별 시간대별 매출 합치기
		strQuery           += "     , ( " +"\n";
		strQuery           += "        " + columnQuery1 + columnQuery2 + "\n";
		strQuery           += "       ) TIME_SALE" +"\n";

		// 시간대별 내점 객수 합치기
		strQuery           += "     , ( " +"\n";
		strQuery           += "        " + svc.getQuery("SEL_TIME_BLOCK") + "\n";
		strQuery           += "       ) TIME_VISIT" +"\n";
		// 시간대별 내점 객수  조건
		sql.setString(++i, strStrCd);
		sql.setString(++i, strDt);
		sql.setString(++i, "0");      // BLOCK_CD


		strQuery           += " WHERE TIME_TAB.TIME_GUBN = TIME_SALE.TIME_GUBN(+)"  +"\n";
		strQuery           += "   AND TIME_TAB.TIME_GUBN = TIME_VISIT.TIME_GUBN(+)" +"\n";
		strQuery           += " ORDER BY TIME_GUBN" +"\n";

		//System.out.println("======= T ==== E ==== S ==== T ======== S ==== Q ==== L =========");
		//System.out.println(strQuery);
		//System.out.println("================ E =========== N ========= D ====================");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}


	/**
	 * 매출속보 조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSale2(ActionForm form ,String userId) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		//String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strDt    = String2.nvl(form.getParam("strDt"));
		String strcmpDt = String2.nvl(form.getParam("strcmpDt"));

		connect("pot");

		sql.put(svc.getQuery("SEL_TODAY_SALE"));

		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		sql.setString(i++, strcmpDt);
		sql.setString(i++, userId);
		
		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		sql.setString(i++, strcmpDt);
		sql.setString(i++, userId);

		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		
		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		sql.setString(i++, strcmpDt);
		sql.setString(i++, userId);

		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		

		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		sql.setString(i++, strcmpDt);
		sql.setString(i++, userId);
		

		sql.setString(i++, strDt);
		sql.setString(i++, userId);
		
		ret = select2List(sql);

		return ret;
	}


	/**
	 * 체류객수 조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchVisit(ActionForm form) throws Exception{
		List ret		= null;
		SqlWrapper sql	= null;
		Service svc		= null;

		try{
			String strStrCd = String2.nvl(form.getParam("strStrCd"));
			String strDt    = String2.nvl(form.getParam("strDt"));

			svc = (Service) form.getService();
			sql	= new SqlWrapper();

			sql.put(svc.getQuery("SEL_VISIT"));
			sql.setString(1, strStrCd);
			sql.setString(2, strDt);

			connect("pot");
			ret = select2List(sql);
		}catch(Exception e){
			throw e;
		}
		return ret;
	}

	/**
	 * 날씨 실황정보조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchWeaterCast(ActionForm form) throws Exception {

		List ret		= null;
		SqlWrapper sql	= null;
		Service svc		= null;

		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_WEATHERCAST"));
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

	/**
	 *  배너 정보조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */

	public List searchBanner(ActionForm form) throws Exception{
		List ret		= null;
		SqlWrapper sql	= null;
		Service svc		= null;

		try{
			svc = (Service) form.getService();
			sql	= new SqlWrapper();

			sql.put(svc.getQuery("SEL_BANNER"));
			connect("pot");

			ret = select2List(sql);
		}catch(Exception e){
			throw e;
		}
		return ret;
	}

	/**
	 * TODOLIST 조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchToDoList(ActionForm form, String userId, String orgFlag) throws Exception{
		List ret		= null;
		SqlWrapper sql	= null;
		Service svc		= null;

		try{
			svc = (Service) form.getService();
			sql	= new SqlWrapper();

			sql.put(svc.getQuery("SEL_TODOLIST"));
			int i = 0;
			sql.setString(++i, userId);
			sql.setString(++i, orgFlag);
			sql.setString(++i, userId);
			sql.setString(++i, userId);
			sql.setString(++i, userId);
			connect("pot");

			ret = select2List(sql);
		}catch(Exception e){
			throw e;
		}
		return ret;
	}


	/**
	 * TO DO LIST 사용자열람여부 update
	 *
	 * @param form
	 * @param mi
	 * @return
	 * @throws Exception
	 */
	public int saveTodoReadFlag(ActionForm form, MultiInput mi)
			throws Exception {
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int ret 		= 0;
		//int res 		= 0;

		int i;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				i = 0;
				sql.put(svc.getQuery("UPT_TODOLIST_READFLAG"));

				sql.setString(++i, mi.getString("TDL_DATE"));
				sql.setString(++i, mi.getString("TDL_USER_ID"));
				sql.setString(++i, mi.getString("TDL_SEQ"));

				ret = update(sql);

				if (ret < 1)
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 처리하지 못했습니다.");

			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}

	/**
	 * TODOLIST 상세조회
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectTodoDetail(ActionForm form) throws Exception{
		List ret		= null;
		SqlWrapper sql	= null;
		Service svc		= null;

		try{
			String strUserId 	= String2.nvl(form.getParam("strUserId"));	//수신자
			String strTdlDate   = String2.nvl(form.getParam("strTdlDate")); //의뢰일자
			String strTdlSeq  	= String2.nvl(form.getParam("strTdlSeq"));	//의뢰순번

			svc = (Service) form.getService();
			sql	= new SqlWrapper();

			sql.put(svc.getQuery("SEL_TODOLIST_DETAIL"));
			sql.setString(1, strTdlDate);
			sql.setString(2, strUserId);
			sql.setString(3, strTdlSeq);

			connect("pot");
			ret = select2List(sql);
		}catch(Exception e){
			throw e;
		}
		return ret;
	}


	/**
	 * 아트몰링 조직별 매출속보 마스터 조회 한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster_art(ActionForm form, String userid, String strOrgFlag) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strTeamCd    = "%";
		String strPartCd    = "%";
		String strPcCd 	    = "%";
		String strSaleDtS   = String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE   = String2.nvl(form.getParam("strSaleDtE"));
		String strBfSaleDtS = String2.nvl(form.getParam("strBfSaleDtS"));
		String strBfSaleDtE = String2.nvl(form.getParam("strBfSaleDtE"));
		String strBrandCd   = "";
		String strSelFlag   = "1";	// 원단위구분(원단위로 세팅)
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_MASTER"));
		
		// 원단위
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		
		// 점별 합계
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strTeamCd);
		sql.setString(++i, strPartCd);
		sql.setString(++i, strPcCd);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		
		// 점별 합계(전별 파트별)
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strTeamCd);
		sql.setString(++i, strPartCd);
		sql.setString(++i, strPcCd);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, strOrgFlag);
		
		// 점별 파트별
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strTeamCd);
		sql.setString(++i, strPartCd);
		sql.setString(++i, strPcCd);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		
		// 점별 파트별(전별 파트별)
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strTeamCd);
		sql.setString(++i, strPartCd);
		sql.setString(++i, strPcCd);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, strOrgFlag);
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 아트몰링 조직별 매출속보 디테일 조회 한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail_art(ActionForm form, String userid, String strOrgFlag) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strSearchCd  = String2.nvl(form.getParam("strSearchCd"));
		String strSaleDtS   = String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE   = String2.nvl(form.getParam("strSaleDtE"));
		String strBfSaleDtS = String2.nvl(form.getParam("strBfSaleDtS"));
		String strBfSaleDtE = String2.nvl(form.getParam("strBfSaleDtE"));
		String strSelFlag   = "1";
		String strBrandCd   = "";
		String strGrpCd     = String2.nvl(form.getParam("strGrpCd"));

		String strSelId    = "SEL_DETAIL"  + strGrpCd;
		String strGrpOrdId = "SEL_GRP_ORD" + strGrpCd;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery(strSelId));
		sql.put(svc.getQuery("SEL_BODY"));
		sql.put(svc.getQuery(strGrpOrdId));
		
		// 원단위
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);

		// 점별 조직별 조회조건
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSearchCd);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSearchCd);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBfSaleDtS);
		sql.setString(++i, strBfSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, strOrgFlag);
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
}
