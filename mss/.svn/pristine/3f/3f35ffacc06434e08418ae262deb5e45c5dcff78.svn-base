/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;
import common.util.Util;
import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>약속대장관리</p>
 * 
 * @created  on 1.0, 2011/02/16
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro101DAO extends AbstractDAO {
	/**
	 * 약속대장목록 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String strUserId, String strOrgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		Util util = new Util();
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSearchFlag = String2.nvl(form.getParam("strSearchFlag"));
		String strSdt = String2.nvl(form.getParam("strSdt"));
		String strEdt = String2.nvl(form.getParam("strEdt"));
		String strCustNm = URLDecoder.decode(form.getParam("strCustNm"), "UTF-8");
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strPromType = String2.nvl(form.getParam("strPromType"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCustNm);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPromType);
		sql.setString(i++, strUserId);
		sql.setString(i++, strOrgFlag);
		
		if(strSearchFlag.equals("01")){ // 01: 접수일자
			strQuery += svc.getQuery("ADD_TAKE_DT") + "\n";
		}else if(strSearchFlag.equals("02")){ // 02: 입고예정일
			strQuery += svc.getQuery("ADD_IN_DELI_DT") + "\n";
		}else if(strSearchFlag.equals("03")){ // 03: 약속일자
			strQuery += svc.getQuery("ADD_PROM_DT") + "\n";
		}
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.put(strQuery);
		
		ret = select2List(sql);
/*      ret = util.decryptedStr(ret,10);        //휴대전화1
		ret = util.decryptedStr(ret,11);        //휴대전화2
		ret = util.decryptedStr(ret,12);        //휴대전화3
		ret = util.decryptedStr(ret,13);        //전화1
		ret = util.decryptedStr(ret,14);        //전화2
		ret = util.decryptedStr(ret,15);        //전화3
		ret = util.decryptedStr(ret,38);        //택배휴대전화1
		ret = util.decryptedStr(ret,39);        //택배휴대전화2
		ret = util.decryptedStr(ret,40);        //택배휴대전화3
		ret = util.decryptedStr(ret,41);        //택배전화1
		ret = util.decryptedStr(ret,42);        //택배전화2
		ret = util.decryptedStr(ret,43);        //택배전화3  */
		
		return ret;
	}
	
	/**
	 *  약속 내역 저장/수정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i   = 1;
		SqlWrapper sql = null;
		Service svc = null;
		Util util = new Util();
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if (mi.IS_INSERT()) { // 저장
					sql.put(svc.getQuery("INS_PROMISECERT")); 
					sql.setString(i++, mi.getString("TAKE_DT"));
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("TAKE_USER_ID"));
					sql.setString(i++, mi.getString("CUST_NM"));
					sql.setString(i++, mi.getString("POST_NO"));
					sql.setString(i++, mi.getString("CUST_POST_SEQ"));
					sql.setString(i++, mi.getString("ADDR"));
					sql.setString(i++, mi.getString("DTL_ADDR"));
					sql.setString(i++, mi.getString("MOBILE_PH1").toString());
					sql.setString(i++, mi.getString("MOBILE_PH2").toString());
					sql.setString(i++, mi.getString("MOBILE_PH3").toString());
					sql.setString(i++, mi.getString("HOME_PH1").toString());
					sql.setString(i++, mi.getString("HOME_PH2").toString());
					sql.setString(i++, mi.getString("HOME_PH3").toString());
					sql.setString(i++, mi.getString("FRST_PROM_DT"));
					sql.setString(i++, mi.getString("FRST_PROM_HH")+mi.getString("FRST_PROM_MM"));
					sql.setString(i++, mi.getString("FRST_PROM_DT"));
					sql.setString(i++, mi.getString("FRST_PROM_HH")+mi.getString("FRST_PROM_MM"));
					sql.setString(i++, mi.getString("PROM_TYPE"));
					sql.setString(i++, mi.getString("PROM_DTL"));
					sql.setString(i++, mi.getString("DELI_TYPE"));
					sql.setString(i++, mi.getString("DELI_STR"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("SKU_NM"));
					sql.setString(i++, mi.getString("IN_DELI_DT"));
					sql.setString(i++, mi.getString("SMS_YN"));
					sql.setString(i++, mi.getString("COUR_CUST_NM"));
					sql.setString(i++, mi.getString("COUR_POST_NO"));
					sql.setString(i++, mi.getString("COUR_POST_SEQ"));
					sql.setString(i++, mi.getString("COUR_ADDR"));
					sql.setString(i++, mi.getString("COUR_DTL_ADDR"));
					sql.setString(i++, mi.getString("COUR_MOBILE_PH1").toString());
					sql.setString(i++, mi.getString("COUR_MOBILE_PH2").toString());
					sql.setString(i++, mi.getString("COUR_MOBILE_PH3").toString());
					sql.setString(i++, mi.getString("COUR_HOME_PH1").toString());
					sql.setString(i++, mi.getString("COUR_HOME_PH2").toString());
					sql.setString(i++, mi.getString("COUR_HOME_PH3").toString());
					sql.setString(i++, mi.getString("COUR_COMP_NM"));
					sql.setString(i++, mi.getString("COUR_SEND_NO"));
					sql.setString(i++, mi.getString("PROC_STAT"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);

				}else if(mi.IS_UPDATE()){// 수정
					sql.put(svc.getQuery("UPD_PROMISECERT")); 
					
					sql.setString(i++, mi.getString("CUST_NM"));
					sql.setString(i++, mi.getString("POST_NO"));
					sql.setString(i++, mi.getString("CUST_POST_SEQ"));
					sql.setString(i++, mi.getString("ADDR"));
					sql.setString(i++, mi.getString("DTL_ADDR"));
					sql.setString(i++, mi.getString("MOBILE_PH1").toString());
					sql.setString(i++, mi.getString("MOBILE_PH2").toString());
					sql.setString(i++, mi.getString("MOBILE_PH3").toString());
					sql.setString(i++, mi.getString("HOME_PH1").toString());
					sql.setString(i++, mi.getString("HOME_PH2").toString());
					sql.setString(i++, mi.getString("HOME_PH3").toString());
					sql.setString(i++, mi.getString("FRST_PROM_DT"));
					sql.setString(i++, mi.getString("FRST_PROM_HH")+mi.getString("FRST_PROM_MM"));
					sql.setString(i++, mi.getString("PROM_TYPE"));
					sql.setString(i++, mi.getString("PROM_DTL"));
					sql.setString(i++, mi.getString("DELI_TYPE"));
					sql.setString(i++, mi.getString("DELI_STR"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("SKU_NM"));
					sql.setString(i++, mi.getString("IN_DELI_DT"));
					sql.setString(i++, mi.getString("SMS_YN"));
					sql.setString(i++, mi.getString("COUR_CUST_NM"));
					sql.setString(i++, mi.getString("COUR_POST_NO"));
					sql.setString(i++, mi.getString("COUR_POST_SEQ"));
					sql.setString(i++, mi.getString("COUR_ADDR"));
					sql.setString(i++, mi.getString("COUR_DTL_ADDR"));
					sql.setString(i++, mi.getString("COUR_MOBILE_PH1").toString());
					sql.setString(i++, mi.getString("COUR_MOBILE_PH2").toString());
					sql.setString(i++, mi.getString("COUR_MOBILE_PH3").toString());
					sql.setString(i++, mi.getString("COUR_HOME_PH1").toString());
					sql.setString(i++, mi.getString("COUR_HOME_PH2").toString());
					sql.setString(i++, mi.getString("COUR_HOME_PH3").toString());
					sql.setString(i++, mi.getString("COUR_COMP_NM"));
					sql.setString(i++, mi.getString("COUR_SEND_NO"));
					sql.setString(i++, mi.getString("PROC_STAT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("TAKE_DT"));
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("TAKE_SEQ"));
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
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
	 * 약속변경 POPUP - 이전 약속 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getHistory(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strTakeDt = String2.nvl(form.getParam("strTakeDt"));
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strTakeSeq = String2.nvl(form.getParam("strTakeSeq"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, strTakeDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strTakeSeq);
		
		strQuery = svc.getQuery("SEL_PROMISEHIS") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 약속변경 POPUP - 이전 약속 히스토리 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getHistoryList(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strTakeDt = String2.nvl(form.getParam("strTakeDt"));
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strTakeSeq = String2.nvl(form.getParam("strTakeSeq"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, strTakeDt);
		sql.setString(i++, strTakeSeq);
		sql.setString(i++, strStrCd);
		
		strQuery = svc.getQuery("SEL_HIS_MASTER") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 *  약속 변경  내역 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveHistory(ActionForm form, MultiInput miChg, MultiInput miHis, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i   = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			miChg.next();
			miHis.next();
			for(int j=0;j<5;j++){
				if(!miChg.getString("MOD_PROM_DT").equals("") 
						&& !miChg.getString("MOD_PROM_HH").equals("") 
						&& !miChg.getString("MOD_PROM_MM").equals("") && j == 0){ // 약속일
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS01")); 
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					sql.setString(i++, "01");
					sql.setString(i++, miChg.getString("MOD_REASON01"));
					sql.setString(i++, miChg.getString("MOD_REASON_DTL01"));
					sql.setString(i++, miChg.getString("MOD_TAKE_DT01"));
					sql.setString(i++, miHis.getString("LAST_PROM_DT"));
					sql.setString(i++, miChg.getString("MOD_PROM_DT"));
					sql.setString(i++, miHis.getString("LAST_PROM_TIME"));
					sql.setString(i++, miChg.getString("MOD_PROM_HH")+miChg.getString("MOD_PROM_MM"));
					sql.setString(i++, userId);
					res = update(sql);
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_01")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, miChg.getString("MOD_PROM_DT"));
					sql.setString(i++, miChg.getString("MOD_PROM_HH")+miChg.getString("MOD_PROM_MM"));
					sql.setString(i++, userId);
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					res += update(sql);
					
				}else if(!miChg.getString("MOD_IN_DELI_DT").equals("") && j == 1){ // 입고예정일
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS02")); 
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					sql.setString(i++, "02");
					sql.setString(i++, miChg.getString("MOD_REASON02"));
					sql.setString(i++, miChg.getString("MOD_REASON_DTL02"));
					sql.setString(i++, miChg.getString("MOD_TAKE_DT02"));
					sql.setString(i++, miHis.getString("IN_DELI_DT"));
					sql.setString(i++, miChg.getString("MOD_IN_DELI_DT"));
					sql.setString(i++, userId);
					res = update(sql);
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_02")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, miChg.getString("MOD_IN_DELI_DT"));
					sql.setString(i++, userId);
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					res += update(sql);
				}else if(!miChg.getString("MOD_DELI_STR").equals("") && j == 2){ // 인도점
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS03")); 
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					sql.setString(i++, "03");
					sql.setString(i++, miChg.getString("MOD_REASON03"));
					sql.setString(i++, miChg.getString("MOD_REASON_DTL03"));
					sql.setString(i++, miChg.getString("MOD_TAKE_DT03"));
					sql.setString(i++, miHis.getString("DELI_STR"));
					sql.setString(i++, miChg.getString("MOD_DELI_STR"));
					sql.setString(i++, userId);
					res = update(sql);
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_03")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, miChg.getString("MOD_DELI_STR"));
					sql.setString(i++, userId);
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					String aa= sql.toString();
					res += update(sql);
				}else if(!miChg.getString("MOD_DELI_TYPE").equals("") && j == 3){ // 인도방식
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS04")); 
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					sql.setString(i++, "04");
					sql.setString(i++, miChg.getString("MOD_REASON04"));
					sql.setString(i++, miChg.getString("MOD_REASON_DTL04"));
					sql.setString(i++, miChg.getString("MOD_TAKE_DT04"));

					sql.setString(i++, miHis.getString("DELI_TYPE"));
					sql.setString(i++, miChg.getString("MOD_DELI_TYPE"));
					sql.setString(i++, userId);
					res = update(sql);
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_04")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, miChg.getString("MOD_DELI_TYPE"));
					sql.setString(i++, userId);
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					res += update(sql);
				}else if(miChg.getString("MOD_CANCEL").equals("T") && j == 4){ // 취소
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS05")); 
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					sql.setString(i++, "05");
					sql.setString(i++, miChg.getString("MOD_REASON05"));
					sql.setString(i++, miChg.getString("MOD_REASON_DTL05"));
					sql.setString(i++, miChg.getString("MOD_TAKE_DT05"));
					sql.setString(i++, userId);
					res = update(sql);
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_05")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, "4");
					sql.setString(i++, userId);
					sql.setString(i++, miHis.getString("TAKE_DT"));
					sql.setString(i++, miHis.getString("STR_CD"));
					sql.setString(i++, miHis.getString("TAKE_SEQ"));
					res += update(sql);
				}
			}
			
			if (res != 2) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			ret += res;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
