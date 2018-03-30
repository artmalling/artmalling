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
 * 계량기매핑관리
 * </p>
 * 
 * @created on 1.0, 2010.04.08
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MRen109DAO extends AbstractDAO {

	/**
	 * <p>
	 * 계량기정보
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
			String strFlcFlag = String2.nvl(form.getParam("strFlcFlag")); // 시설구분
			String strGaugType = String2.nvl(form.getParam("strGaugType"));// 계량기구분
			String strGaugID = String2.nvl(form.getParam("strGaugID")); // 계량기ID
			String strVenCd = String2.nvl(form.getParam("strVenCd")); // 협력사코드
			int i = 0;

			if (strVenCd.equals("")) {
				sql.put(svc.getQuery("SEL_MR_GAUGMST"));
				sql.setString(++i, strGaugID);
				sql.setString(++i, strGaugType);
				sql.setString(++i, strFlcFlag);
			} else {
				sql.put(svc.getQuery("SEL_MR_GAUGMST_W_VENCD"));
				sql.setString(++i, strGaugID);
				sql.setString(++i, strVenCd);
				sql.setString(++i, strGaugType);
				sql.setString(++i, strFlcFlag);
			}

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 계량기 매핑 정보 조회
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
			String strGaugID = String2.nvl(form.getParam("strGaugID")); // 시설구분
			int i = 0;

			sql.put(svc.getQuery("SEL_MR_GAUGMST_DTL"));
			sql.setString(++i, strGaugID);
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 계량기 매핑 정보 저장
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
					sql.put(svc.getQuery("INS_MR_GAUGMST_DTL"));
					int i = 0;
					sql.setString(++i, mi.getString("GAUG_ID"));
					sql.setString(++i, mi.getString("CNTR_ID"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					//sql.setString(++i, mi.getString("DIV_RATE"));
					sql.setDouble(++i, mi.getDouble("DIV_RATE"));
					sql.setString(++i, userID);
					sql.setString(++i, userID);
				} else if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_GAUGMST_DTL"));
					int i = 0;
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					sql.setDouble(++i, mi.getDouble("DIV_RATE"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("GAUG_ID"));
					sql.setString(++i, mi.getString("CNTR_ID"));
				} else if (mi.IS_DELETE()) {
					sql.put(svc.getQuery("DEL_MR_GAUGMST_DTL"));
					int i = 0;
					sql.setString(++i, mi.getString("GAUG_ID"));
					sql.setString(++i, mi.getString("CNTR_ID"));
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
}
