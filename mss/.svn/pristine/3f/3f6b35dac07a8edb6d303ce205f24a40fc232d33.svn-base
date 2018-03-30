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
 * <p>관리비 정산</p>
 * 
 * @created  on 1.0, 2010.05.02
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen303DAO extends AbstractDAO {

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
			String strStrCd = String2.nvl(form.getParam("strStrCd")); 	// [조회용]시설구분(점코드)
			String strCalYM = String2.nvl(form.getParam("strCalYM"));	// [조회용]부과년월
			String strVenCd = String2.nvl(form.getParam("strVenCd"));	// [조회용]협력사
			
			sql.put(svc.getQuery("SEL_MR_CALMST"));
			sql.setString(++i, strStrCd);
			sql.setString(++i, strCalYM);
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
	 * 계약마스터 조회(관리비항목별 내역)
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
			String strCalType = String2.nvl(form.getParam("strCalType"));	// 정산유형
			
			sql.put(svc.getQuery("SEL_MR_CALITEM"));
			sql.setString(++i, strCalType);
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
	 * 관리비정산
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List procCalculate(ActionForm form, String userId) throws Exception {
		int rtCd 			    = 0;
		String rtMsg 			= null;
		List list 				= null;
		ProcedureWrapper psql 	= null;
		ProcedureResultSet prs 	= null;
		try {
        	begin();
            connect("pot");
            psql = new ProcedureWrapper();
			int i=1;
            
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// [조회용]시설구분(점코드)
			String strFclFlag 	= String2.nvl(form.getParam("strFclFlag"));	// [조회용]시설코드
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// [조회용]부과년월
			String strCalFlag 	= String2.nvl(form.getParam("strCalFlag"));	// 정산구분
			
			//시설코드가 오피스일 시 별도의 정산 프로시져[2010.07.18]
			//if (strFclFlag.equals("4")) { 
			//	psql.put("MSS.PR_MRCALOFFICE", 5);
			//} else {
				psql.put("MSS.PR_MRCALMNTN", 6);
			//}
			
			psql.setString(i++, strStrCd);
			psql.setString(i++, strCalYM);
			psql.setString(i++, userId);
			psql.setString(i++, strCalFlag);
			System.out.println(strCalFlag);
			psql.registerOutParameter(i++, DataTypes.INTEGER);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
					
			prs = updateProcedure(psql);
			rtCd = prs.getInt(5);
			rtMsg = prs.getString(6);
			
			System.out.println(rtCd);
			System.out.println(rtMsg);
			
			if (rtCd != 0) {
                throw new Exception("[USER]" + rtMsg);
            }
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
	 * 관리비재정산
	 * </p>
	
	@SuppressWarnings("rawtypes")
	public List reProcCalculate(ActionForm form, String userId) throws Exception {
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
            
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// [조회용]시설구분(점코드)
			//String strFclFlag 	= String2.nvl(form.getParam("strFclFlag"));	// [조회용]시설코드
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// [조회용]부과년월
			String strCntrId 	= String2.nvl(form.getParam("strCntrId"));	// 계약ID
						
			psql.put("MSS.PR_MRCALMNTN_RECAL", 6);
			
			psql.setString(i++, strStrCd);
			psql.setString(i++, strCalYM);
			psql.setString(i++, strCntrId);
			psql.setString(i++, userId);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
					
			prs = updateProcedure(psql);
			rtCd = prs.getString(5);
			rtMsg = prs.getString(6);
			
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
 */
	/**
	 * <p>
	 * 관리비정산 저장
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
				if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_CALMST"));
					int i = 0;
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("MOD_REASON"));
					sql.setString(++i, mi.getString("MOD_ARREAR_AMT"));
					sql.setString(++i, mi.getString("MOD_RENT_ARREAR_AMT"));
					sql.setString(++i, mi.getString("MOD_TOT_BAL_AMT"));
					sql.setString(++i, mi.getString("MOD_RENT_TOT_BAL_AMT"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_YM"));
				}  
				
				res = update(sql);
				if (res != 1) {
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
	 * 관리비정산내역 저장
	 * </p>
	 */
	public int detailSave(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
		int res = 0;
		String rtCd 			= null;
		String rtMsg 			= null;
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		ProcedureResultSet prs 	= null;

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			svc = (Service) form.getService();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// [조회용]시설구분(점코드)
			//String strFclFlag 	= String2.nvl(form.getParam("strFclFlag"));	// [조회용]시설코드
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// [조회용]부과년월
			String strCntrId 	= String2.nvl(form.getParam("strCntrId"));	// 계약ID
			
			while (mi.next()) {
				sql.close();
				int i = 0;
				if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_CALITEM"));
					
					sql.setString(++i, mi.getString("MOD_USE_AMT"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("CAL_TYPE"));
					sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
				}  
				
				res = update(sql);
				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				ret += res;
				System.out.println(ret + "ret1111");
				
				if (ret > 0) {
				//sql.close();
					i = 0;
					psql.put("MSS.PR_MRCALMNTN_RECAL", 6);
				
					psql.setString(++i, strStrCd);
					psql.setString(++i, strCalYM);
					psql.setString(++i, strCntrId);
					psql.setString(++i, userID);
					psql.registerOutParameter(++i, DataTypes.VARCHAR);
					psql.registerOutParameter(++i, DataTypes.VARCHAR);
						
					prs = updateProcedure(psql);
					rtCd = prs.getString(5);
					rtMsg = prs.getString(6);
				/*
					if( rtCd != "0" ){
						throw new Exception("[USER]" + prs.getString(6));
					}*/
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
