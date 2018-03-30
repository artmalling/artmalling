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
 * 관리비입금내역등록
 * </p>
 * 
 * @created on 1.0, 2010.05.12
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MRen405DAO extends AbstractDAO {

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
			String strCalSYM 	= String2.nvl(form.getParam("strCalSYM"));	// 부과년월
			String strCalEYM 	= String2.nvl(form.getParam("strCalEYM"));	// 부과년월
			String strRentType 	= String2.nvl(form.getParam("strRentType"));// 임대형태
			String strVenCd 	= String2.nvl(form.getParam("strVenCd"));	// 협력사코드
			int i = 0;
			
			sql.put(svc.getQuery("SEL_MR_CALPAY"));
			sql.setString(++i, strStrCd);
			sql.setString(++i, strRentType);
			sql.setString(++i, strVenCd);
			sql.setString(++i, strCalSYM);
			sql.setString(++i, strCalEYM);
			sql.setString(++i, strStrCd);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}


	/**
	 * <p>
	 * 관리비입금내역 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
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
					sql.put(svc.getQuery("INS_MR_CALPAY"));
					int i = 0;
					sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("PAY_DT"));
					sql.setDouble(++i, mi.getDouble("PAY_AMT"));
					sql.setDouble(++i, mi.getDouble("PAY_RENT_AMT"));
					sql.setString(++i, "");
					sql.setString(++i, userID);
					sql.setString(++i, userID);
				} else if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_CALPAY"));
					int i = 0;
					sql.setString(++i, mi.getString("PAY_DT"));
					sql.setDouble(++i, mi.getDouble("PAY_AMT"));
					sql.setDouble(++i, mi.getDouble("PAY_RENT_AMT"));
					sql.setString(++i, "");
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_YM"));
				} else {
					sql.put(svc.getQuery("DEL_MR_CALPAY"));
					int i = 0;
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_YM"));
				}
				res = update(sql);
				if (res == 1) {
					sql.close();
					sql.put(svc.getQuery("UPD_PAY_FLAG"));
					int i = 0;
					sql.setDouble(++i, mi.getDouble("REAL_CHAREG_AMT"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_YM"));
					update(sql);
				} else {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
	 * <p>
	 * 관리비입금내역조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getVenInfo(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 시설구분
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// 부과년월
			String strVenCd 	= String2.nvl(form.getParam("strVenCd"));	// 협력사코드
			String strCntrId 	= String2.nvl(form.getParam("strCntrId"));	// 계약ID
			int i = 0;
			
			sql.put(svc.getQuery("SEL_VENINFO"));
			sql.setString(++i, strCntrId);
			sql.setString(++i, strVenCd);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strCalYM);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
