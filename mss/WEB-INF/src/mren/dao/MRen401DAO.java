/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 관리비청구서관리
 * </p>
 * 
 * @created on 1.0, 2010.05.16
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MRen401DAO extends AbstractDAO {

	/**
	 * <p>
	 * 관리비입금내역조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 시설구분
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// 부과년월
			String strRentType 	= String2.nvl(form.getParam("strRentType"));// 임대형태
			String strVenCd 	= String2.nvl(form.getParam("strVenCd"));	// 협력사코드
			int i = 0;
			
			sql.put(svc.getQuery("SEL_MR_CALMST"));
			sql.setString(++i, strRentType);
			sql.setString(++i, strVenCd);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strCalYM);
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 *  마감내역 확인
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getCheckClose(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;  
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 시설구분
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// 부과년월
			int i = 0;
			
			sql.put(svc.getQuery("SEL_CLOSE_YN"));
			sql.setString(++i, strCalYM);
			sql.setString(++i, strStrCd);
			list = select2List(sql);
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPrintList(ActionForm form) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = ""; 
		int i = 1;
		String strCntrId = String2.nvl(form.getParam("strCntrId"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		String strCalYm = String2.nvl(form.getParam("strCalYm")); 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		sql.setString(i++, strCntrId);
		sql.setString(i++, strVenCd);
		sql.setString(i++,  strCalYm);
		
		/* 단일 출력  */
		strQuery = svc.getQuery("SEL_PRINT");
		sql.put(strQuery);
		ret = select2List(sql);
			
		return ret;
	}


	/**
	 * <p>
	 * 저장
	 * </p>
	 */
	public String billingProcess(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		String ret = "";
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
			
			while (mi.next()) {
				sql.close();
				if (mi.IS_INSERT()) {
					
					if(mi.getString("CHRG_YN").equals("Y")){
						sql.put(svc.getQuery("UPD_MR_CALMST"));
					}else{
						sql.put(svc.getQuery("UPD_MR_CALMST_CANCEL"));
					}
					
					int i = 0;
					sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CHRG_YN"));
					sql.setString(++i, userID);
				} 
				
				
				
				
				res += update(sql);
				
				if (mi.getString("CHRG_YN").equals("Y")) { 
					ret = "청구내역 생성["+res+"건]이";
				} else {
					ret = "청구내역 생성취소["+res+"건]가  ";
				}
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
