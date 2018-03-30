/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/23
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod208DAO extends AbstractDAO {

	/**
	 * 브랜드정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String strID) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		
		// 20120507 * DHL 주석처리 -->
		//String strBrandGb   = String2.nvl(form.getParam("strBrandGb"));
		// 20120507 * DHL 주석처리 <--
		
		String strBrandCd 	= String2.nvl(form.getParam("strBrandCd"));
		String strBrandNm 	= String2.nvl(form.getParam("strBrandNm")); 
		String strVenCd 	= String2.nvl(form.getParam("strVenCd"));
		String strVenNm 	= String2.nvl(form.getParam("strVenNm"));
		String strCd 	= String2.nvl(form.getParam("strCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_BRAND_MST"));

		sql.setString(i++, strCd);
		sql.setString(i++, strBrandCd);
		sql.setString(i++, strBrandNm);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strVenNm);
		sql.setString(i++, strID);

		ret = select2List(sql);
		
		return ret;
	}


	/**
	 * 브랜드을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;		
		int i;
		
		String strBrandCd 	= String2.nvl(form.getParam("strBrandCd"));
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			System.out.println(strBrandCd);
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_UPDATE()) {
					
					i = 0;
					
					sql.put(svc.getQuery("UPD_BRDMST"));

					sql.setString(++i, strBrandCd);	
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]"+"[USER]" + "데이터의 적합성 문제로 인하여"
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
	 * 브랜드정보    삭제  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int del(ActionForm form, MultiInput mi, String strID)
			throws Exception {
		
		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;		
		int i;
		
		String strBrandCd 	= String2.nvl(form.getParam("strBrandCd"));
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			System.out.println(strBrandCd);
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_UPDATE()) {
					
					i = 0;
					
					sql.put(svc.getQuery("DEL_BRDMST"));
		
					
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
				} 
				
				res = update(sql);
		
				if (res != 1) {
					throw new Exception("[USER]"+"[USER]" + "데이터의 적합성 문제로 인하여"
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
}
