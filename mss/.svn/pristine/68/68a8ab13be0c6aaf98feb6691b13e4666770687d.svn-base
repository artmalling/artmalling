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
 * <p>계약해지등록 </p>
 * 
 * @created  on 1.0, 계약해지등록
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen501DAO extends AbstractDAO {
	
	/**
	 * <p>계량기용도&온수차등요금제 콤보조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
			String strStrCd		= String2.nvl(form.getParam("strStrCd"));		// 시설구분(점코드)
			String strVenCd		= String2.nvl(form.getParam("strVenCd"));		// 협력사
			String strCntrType	= String2.nvl(form.getParam("strCntrType"));	// 계약유형
			String strRentType	= String2.nvl(form.getParam("strRentType"));	// 임대형태
			String strRentFlag	= String2.nvl(form.getParam("strRentFlag"));	// 임대구분
			String strCloseFlag	= String2.nvl(form.getParam("strCloseFlag"));	// 해지사유
			String strSGbn		= String2.nvl(form.getParam("strSGbn"));		// 조회기간구분
			String strSDT		= String2.nvl(form.getParam("strSDT"));			// 기간S
			String strEDT		= String2.nvl(form.getParam("strEDT"));			// 기간E
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_CNTRMST"));
			sql.setString(++i, strCloseFlag);
			sql.setString(++i, strRentFlag);
			sql.setString(++i, strRentType);
			sql.setString(++i, strCntrType);
			sql.setString(++i, strVenCd);
			sql.setString(++i, strStrCd);
			
			if (strSGbn.equals("1")) { //계약시작일
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_SDT"));
				sql.setString(++i, strSDT);
				sql.setString(++i, strEDT);
			} else if (strSGbn.equals("2")) { //계약종료일
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_EDT"));
				sql.setString(++i, strSDT);
				sql.setString(++i, strEDT);	
			} else if (strSGbn.equals("3")) { //계약해지일
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_CAN_DT"));
				sql.setString(++i, strSDT);
				sql.setString(++i, strEDT);
			}
			sql.put(svc.getQuery("SEL_MR_CNTRMST_ORDER"));
			
			list = select2List(sql);	         
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>계량기용도&온수차등요금제 콤보조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getDetail(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			String strCntrId	= String2.nvl(form.getParam("strCntrId"));	// 계약ID
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_CALBAL"));
			sql.setString(++i, strCntrId);
			list = select2List(sql);	
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 계약해지등록 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				if (mi.IS_UPDATE()) {
					//계약변경이력등록
					sql.close();
					sql.put(svc.getQuery("UPD_MR_CNTRMST"));
					int i = 0;
					sql.setString(++i, mi.getString("CNTR_CAN_DT"));
					sql.setString(++i, mi.getString("CNTR_CAN_REAS_CD"));
					sql.setString(++i, mi.getString("ADD_DED_AMT"));
					sql.setString(++i, mi.getString("RTRN_AMT"));
					sql.setString(++i, mi.getString("ADD_DED_REASON"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("CNTR_ID"));
					res = update(sql);
					
					if (res != 1) {
						throw new Exception("" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					
					//계약변경이력등록
					sql.close();
					sql.put(svc.getQuery("INS_MR_CNTRHST"));
					i = 0;
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, userID);
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("CNTR_ID"));
					update(sql);
				} 
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
}	
