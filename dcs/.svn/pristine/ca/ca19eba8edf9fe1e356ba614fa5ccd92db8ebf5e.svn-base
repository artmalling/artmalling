/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dcom.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;

import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * <p>회원정보조회</p>
 * 
 * @created  on 1.0, 2010/02/25
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCom100DAO extends AbstractDAO {

    /**
     * <p>회원정보 조회</p>
     * 
     */
	public List searchCustinfo(ActionForm form, MultiInput mi, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List       ret = null;
		SqlWrapper sql = null;
		Service    svc = null;
		Util      util = new Util();
		String strQuery = "";
		int idx = 1; 
		
		HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
		if (!mi.next())
			throw new Exception(
					"# DCom100DAO.getOneWithoutPop] MuiltiInput is null");
		
		svc = (Service) form.getService(); 
		sql = new SqlWrapper();

		connect("pot");		
		strQuery = svc.getQuery(mi.getString("SERVICE_ID")) + "\n"; 
		
		String strSsNo   = mi.getString("SS_NO");
		String strCustId = mi.getString("CUST_ID");
		String strCardNo = mi.getString("CARD_NO");
		String strFlag   = String2.nvl(mi.getString("COMP_PERS_FLAG"));
		String strScrId  = mi.getString("SCR_ID");
		
		if("".equals(strFlag) || "%".equals(strFlag)) {
			strFlag = "P";
		}
		 
		if(strFlag.equals("C")){
			strQuery = svc.getQuery(mi.getString("SERVICE_ID") + "_COM") + "\n";
			strFlag = "P";
		}
		
		sql.setString(idx++, strFlag);
		//sql.setString(idx++, sessionInfo.getBRCH_ID());

        System.out.println("strSsNo===== " + strSsNo);
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_SS_NO") + "\n";
			sql.setString(idx++, strSsNo);
			//sql.setString(idx++, util.encryptedStr(strSsNo));
		}else{
			//sql.setString(idx++, strSsNo);
		}
		

        System.out.println("strCustId===== " + strCustId);
        
		if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_CUST_ID") + "\n";
			sql.setString(idx++, strCustId);
	        System.out.println("strCustId===== " + strCustId);
		}		

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_CARD_NO") + "\n";
			sql.setString(idx++, strCardNo);
			//sql.setString(idx++, util.encryptedStr(strCardNo));
		}else{
			//sql.setString(idx++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_CUSTINFO_ORDER") + "\n";
		
		if(!strScrId.equals("DCTM111")){
		    if(!strScrId.equals("DCTM110")){
		    	strQuery += "\n       AND A.SCED_REQ_DT IS NULL ";
	        }else{
	        	strQuery += "\n       AND A.SCED_REQ_DT IS NOT NULL ";
            }
		}	
		 
        sql.put(strQuery);
		ret = select2List(sql);
		/*
		ret = util.decryptedStr(ret,1);     //자택전화1 복호화.
		ret = util.decryptedStr(ret,2);     //자택전화2 복호화.
		ret = util.decryptedStr(ret,3);     //자택전화3 복호화.
		ret = util.decryptedStr(ret,4);     //이동전화1 복호화.
		ret = util.decryptedStr(ret,5);     //이동전화2 복호화.
		ret = util.decryptedStr(ret,6);     //이동전화3 복호화.
		ret = util.decryptedStr(ret,7);     //주민등록번호 복호화.
		ret = util.decryptedStr(ret,11);    //EMAIL1 복호화.
		ret = util.decryptedStr(ret,12);    //EMAIL2 복호화.
		ret = util.decryptedStr(ret,17);    //카드번호 복호화.
		*/
		return ret;
	}	

    /**
	 * 팝업 없이 회원정보 조회하기
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getOneWithoutPop(ActionForm form, MultiInput mi)
			throws Exception {

		List       ret  = null; 
		SqlWrapper sql  = null;
		Service    svc  = null;
		String strQuery = "";
		int idx = 1;
		
		Util      util  = new Util();
		
		if (!mi.next())
			throw new Exception(
					"# DCom100DAO.getOneWithoutPop] MuiltiInput is null");

		svc = (Service) form.getService(); 
		sql = new SqlWrapper();

		connect("pot");
		
		strQuery = svc.getQuery(mi.getString("SERVICE_ID") + "_ONE") + "\n"; 
		
		String strSsNo   = mi.getString("SS_NO");
		String strCustId = mi.getString("CUST_ID");
		String strCardNo = mi.getString("CARD_NO");
		String strFlag   = mi.getString("COMP_PERS_FLAG");
		String strScrId  = mi.getString("SCR_ID");
		
		if(strFlag.equals("C")){
			strQuery = svc.getQuery(mi.getString("SERVICE_ID") + "_TWO") + "\n";
			sql.setString(idx++, "P");
		}else{
			sql.setString(idx++, strFlag);
		}
		
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_CUSTSRCH_SS_NO") + "\n";
			sql.setString(idx++, strSsNo);
			//sql.setString(idx++, util.encryptedStr(strSsNo));
		}else{
			//sql.setString(idx++, strSsNo);
		}
		
		if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_CUSTSRCH_CUST_ID") + "\n";
			sql.setString(idx++, strCustId);
		}		

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_CUSTSRCH_CARD_NO") + "\n";
			sql.setString(idx++, strCardNo);
			//sql.setString(idx++, util.encryptedStr(strCardNo));
		}else{
			//sql.setString(idx++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_CUSTSRCH_ORDER") + "\n";
		
		if(!strScrId.equals("DCTM111")){
		    if(!strScrId.equals("DCTM110")){
		    	strQuery += "     AND SCED_REQ_DT IS NULL ";
	        }else{
	        	strQuery += "     AND SCED_REQ_DT IS NOT NULL ";
            }
		}
		sql.put(strQuery);
		
		ret = select2List(sql);
		/*
		ret = util.decryptedStr(ret,2);     //주민번호 복호화.
		ret = util.decryptedStr(ret,3);     //카드번호복호화.
		*/
		return ret;
	}
	
	
	/**
     * <p>가맹점 권한 조회</p>
     * 
     */
	public List getCommonResult(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		try {

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");

			query = svc.getQuery("SEL_" + form.getParam("sqlId"));
			// 업무에 따른 분기;
			if ("GET_USER_AUTH".equals(form.getParam("sqlId"))) { // 가맹점 권한 조회
				String BRCH_ID = form.getParam("BRCH_ID");
				int i = 1;
				sql.setString(i++, BRCH_ID);
			}
			sql.put(query);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	
	/**
	 * <p>
	 * 클럽목록 조회
	 * </p>
	 * 
	 */
	public List getClubCode(ActionForm form, MultiInput mi) throws Exception {
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
//				getSql = ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT FROM DUAL   ")
//						+ ("\n UNION \n");
			}

			getSql = getSql + svc.getQuery("SEL_CLUB_CODE");

			sql.put(getSql);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 제휴신용카드사 조회
	 * </p>
	 * 
	 */
	public List getCardCode(ActionForm form, MultiInput mi) throws Exception {
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
//				getSql = ("SELECT '%' AS CODE , '전체' AS NAME , 0  AS SORT FROM DUAL   ")
//						+ ("\n UNION \n");
			}

			if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
//				getSql = ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT FROM DUAL   ")
//						+ ("\n UNION \n");
			}

			getSql = getSql + svc.getQuery("SEL_CARD_CODE");

			sql.put(getSql);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}	
	
}
