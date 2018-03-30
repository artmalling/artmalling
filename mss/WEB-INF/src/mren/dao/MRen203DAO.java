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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen203DAO extends AbstractDAO {
	/**
	 * <p>
	 * 계약마스터 조회
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
			int i = 0;
			// parameters
			String strFlcFlag = String2.nvl(form.getParam("strFlcFlag")); 	// [조회용]시설구분(점코드)
			String strVenCd = String2.nvl(form.getParam("strVenCd")); 		// [조회용]협력사
			String strPayGb = String2.nvl(form.getParam("strPayGb")); 	// [조회용]입금상태
			String strRentType = String2.nvl(form.getParam("strRentType")); // [조회용]임대형태
			String strRentFlag = String2.nvl(form.getParam("strRentFlag")); // [조회용]임대구분
			String strCntrType = String2.nvl(form.getParam("strCntrType")); // [조회용]계약유형
			String strIOFlag = String2.nvl(form.getParam("strIOFlag")); 	// [조회용]조회기간구분
			String strSdt = String2.nvl(form.getParam("strSdt")); 			// [조회용]기간S
			String strEdt = String2.nvl(form.getParam("strEdt")); 			// [조회용]기간E
			
			sql.put(svc.getQuery("SEL_MR_CNTRMST"));
			sql.setString(++i, strVenCd);
			sql.setString(++i, strRentType);
			sql.setString(++i, strRentFlag);
			sql.setString(++i, strCntrType);
			sql.setString(++i, strFlcFlag);
			sql.setString(++i, strPayGb);
			// 1:계약시작일, 2:계약종료일
			if (strIOFlag.equals("1")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_SDT"));
				sql.setString(++i, strSdt);
				sql.setString(++i, strEdt);
			} else if (strIOFlag.equals("2")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_EDT"));
				sql.setString(++i, strSdt);
				sql.setString(++i, strEdt);
			}
			
			sql.put(svc.getQuery("SEL_MR_CNTRMST_ORDER_BY"));
			list = select2List(sql);
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 임대보증금 조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getDetail(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			svc = (Service) form.getService(); 
			sql = new SqlWrapper();
			int i = 0;
			// parameters
			String strCntrId = String2.nvl(form.getParam("strCntrId")); 	// 계약 id
			
			sql.put(svc.getQuery("SEL_MR_DEPOSPAY"));
			sql.setString(++i, strCntrId);
			
			list = select2List(sql);
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 계약마스터관리 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		String gubun = "";

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			String strCntrId = String2.nvl(form.getParam("strCntrId")); 	// 계약 id
			String strPayGb = String2.nvl(form.getParam("strPayGb")); 	// 입금상태
			
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
					int i = 0;
					gubun = "I";
					//입금정보 등록
					sql.close();
					sql.put(svc.getQuery("INS_MR_DEPOSPAY"));
					i = 0; 
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					sql.setString(++i, mi.getString("PAY_DT"));
					sql.setString(++i, mi.getString("PAY_AMT"));
					sql.setString(++i, userID);
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("PAY_SLIP_NO"));
					
					res = update(sql);
						
				} else if (mi.IS_UPDATE()) {
					int i = 0;
					gubun = "I";  
					//입금정보수정 
					sql.close();  
					sql.put(svc.getQuery("UPD_MR_DEPOSPAY"));
					i = 0;
					sql.setString(++i, mi.getString("PAY_AMT"));
					sql.setString(++i, mi.getString("PAY_DT"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					
					res = update(sql);
					
				} else if (mi.IS_DELETE()) {
					int i = 0;
					gubun = "D";  
					//입금정보삭제
					sql.close();
					sql.put(svc.getQuery("DEL_MR_DEPOSPAY"));
					i = 0;
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					
					res = update(sql);
					
				}
				
				ret += res;
				
				if(gubun.equals("I")) {
				
					//계약마스터 이력 등록 수정 (입금상태)
					int i = 0;
					sql.close();
					sql.put(svc.getQuery("UPD_MR_CNTRMST"));
					i = 0;
					
					sql.setString(++i, strPayGb);
					sql.setString(++i, userID);
					sql.setString(++i,strCntrId);
					
					res = update(sql);
					
					//계약마스터 등록
					sql.close();
					sql.put(svc.getQuery("INS_MR_CNTRHST"));
					i = 0;
					sql.setString(++i, strCntrId);
					sql.setString(++i, userID);
					sql.setString(++i, userID);
					sql.setString(++i, strCntrId);
					res = update(sql);
				} else {
					//계약마스터 이력 등록 수정 (입금상태)
					int i = 0;
					sql.close();
					sql.put(svc.getQuery("UPD_MR_CNTRMST"));
					i = 0;
					
					sql.setString(++i, "0");
					sql.setString(++i, userID);
					sql.setString(++i,strCntrId);
					
					res = update(sql);
					
					//계약마스터 등록
					sql.close();
					sql.put(svc.getQuery("INS_MR_CNTRHST"));
					i = 0;
					sql.setString(++i, strCntrId);
					sql.setString(++i, userID);
					sql.setString(++i, userID);
					sql.setString(++i, strCntrId);
					res = update(sql);
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
