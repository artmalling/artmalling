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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>계약해지정산</p>
 * 
 * @created  on 1.0, 2010.05.23
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen502DAO extends AbstractDAO {

	/**
	 * <p>
	 * 계약해지정산 조회
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
			String strStrCd = String2.nvl(form.getParam("strStrCd"));	// [조회용]시설구분(점코드)
			String strVenCd = String2.nvl(form.getParam("strVenCd"));	// [조회용]협력사
			String strReas 	= String2.nvl(form.getParam("strReas"));	// [조회용]해지사유
			String strSDt 	= String2.nvl(form.getParam("strSDt"));		// [조회용]해지기간(F)
			String strEDt 	= String2.nvl(form.getParam("strEDt"));		// [조회용]해지기간(T)
			
			//해지기간 조회조건에 따라 분리
			if (strSDt.equals("")||strSDt.equals(null)) {
				sql.put(svc.getQuery("SEL_MR_CALMST_NONDATE"));
				sql.setString(++i, strReas);
				sql.setString(++i, strVenCd);
				sql.setString(++i, strStrCd);
			} else {
				sql.put(svc.getQuery("SEL_MR_CALMST"));
				sql.setString(++i, strSDt);
				sql.setString(++i, strEDt);
				sql.setString(++i, strReas);
				sql.setString(++i, strVenCd);
				sql.setString(++i, strStrCd);
			}
			list = select2List(sql);
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 계약해지정산 조회(관리비항목별 내역)
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
			String strStrCd = String2.nvl(form.getParam("strStrCd")); 		// 시설구분(점코드)
			String strCalYM = String2.nvl(form.getParam("strCalYM"));		// 부과년월
			String strCntrId = String2.nvl(form.getParam("strCntrId"));		// 계약ID

			sql.put(svc.getQuery("SEL_MR_CALITEM"));
			sql.setString(++i, strCntrId);
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
	 * 계약해지정산
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List procCalculate(ActionForm form, String userId) throws Exception {
		String rtCd 			= null;
		String rtMsg 			= null;
		List list 				= null;
		ProcedureWrapper psql 	= null;
		ProcedureResultSet prs 	= null;
		try {
        	begin();
            connect("pot");
            psql = new ProcedureWrapper();
			int i=1;
			String strIStrCd  = String2.nvl(form.getParam("strIStrCd")); 	// 시설구분(점코드)
			String strICntrId = String2.nvl(form.getParam("strICntrId"));	// 계약ID
			
			psql.put("MSS.PR_MRCALCNTRCAN", 5);
			psql.setString(i++, strIStrCd);
			psql.setString(i++, strICntrId);
			psql.setString(i++, userId);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
					
			prs = updateProcedure(psql);
			rtCd = prs.getString(4);
			rtMsg = prs.getString(5);
			//재조회
			list = getMaster(form);
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return list;
	}
	

	/**
	 * <p>
	 * 계약해지정산저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput miMSt, MultiInput miDtl, String userID)
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
			
			//마스터 과세관리비, 
			while (miMSt.next()) {
				sql.close();
				if (miMSt.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_CALMST"));
					int i = 0;
					sql.setDouble(++i, miMSt.getDouble("TAX_AMT"));
					sql.setDouble(++i, miMSt.getDouble("TAX_VAT_AMT"));
					sql.setDouble(++i, miMSt.getDouble("NTAX_AMT"));
					sql.setString(++i, userID);
					sql.setString(++i, miMSt.getString("CNTR_ID"));
					sql.setString(++i, miMSt.getString("CAL_YM"));
				}  
				
				res = update(sql);
				if (res == 1) {
					sql.close();
					sql.put(svc.getQuery("UPD_MR_CNTRMST"));
					int i = 0;
					sql.setDouble(++i, miMSt.getDouble("RTRN_AMT"));
					sql.setString(++i, userID);
					sql.setString(++i, miMSt.getString("CNTR_ID"));
					update(sql);
				} else {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				ret += res;
			}
			
			//계약해지성산내역
			while (miDtl.next()) {
				sql.close();
				if (miDtl.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_CALITEM"));
					int i = 0;
					sql.setDouble(++i, miDtl.getDouble("USE_AMT"));
					sql.setString(++i, userID);
					sql.setString(++i, miDtl.getString("STR_CD"));
					sql.setString(++i, miDtl.getString("CNTR_ID"));
					sql.setString(++i, miDtl.getString("CAL_YM"));
					sql.setString(++i, miDtl.getString("MNTN_ITEM_CD"));
				}  
				
				res = update(sql);
				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
