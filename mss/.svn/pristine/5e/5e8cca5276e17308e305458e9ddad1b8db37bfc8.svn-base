/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 물품 입고/반품 등록
 * </p>
 * 
 * @created on 1.0, 2011/01/26
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae301DAO extends AbstractDAO {

	/**
	 * 물품 입고/반품 마스터 내역 조회
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

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt = String2.nvl(form.getParam("strSdt"));
		String strEdt = String2.nvl(form.getParam("strEdt"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		String strBuyFlg = String2.nvl(form.getParam("strBuyFlg"));
		String strEvtCd = String2.nvl(form.getParam("strEvtCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strBuyFlg);
		sql.setString(i++, strEvtCd);
		sql.setString(i++, strUserId);
		sql.setString(i++, strOrgFlag);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 물품 입고/반품 상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strIndt = String2.nvl(form.getParam("strIndt"));
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		String strBuyFlag = String2.nvl(form.getParam("strBuyFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		if (!strSlipNo.equals("")) {
			strQuery = svc.getQuery("SEL_DETAIL") + "\n";
			sql.setString(i++, strIndt);
			sql.setString(i++, strSlipNo);
		} else {
			strQuery = svc.getQuery("SEL_SKU") + "\n";
			sql.setString(i++, strIndt);
			sql.setString(i++, strBuyFlag);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
			sql.setString(i++, strVenCd);
		}

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	 * 물품 입고/반품 내용을 저장, 수정 처리한다.
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
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				i = 1;
				sql.close();
				if (mi.IS_INSERT()) { // 저장
					sql.close();

					if (strSlipNo.equals("")
							&& mi.getString("SLIP_NO").equals("")) {
						sql.put(svc.getQuery("SEL_SLIP_NO"));
						Map map = (Map) selectMap(sql);
						strSlipNo = map.get("SLIP_NO").toString();
						sql.close();
					}
					if(mi.getString("QTY").equals("") || mi.getString("QTY").equals("0")) continue;
						sql.put(svc.getQuery("INS_EVTSKUONOUT"));
						sql.setString(i++, mi.getString("IN_DT"));
						sql.setString(i++, strSlipNo);
						sql.setString(i++, mi.getString("IN_DT"));
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, strSlipNo);
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, mi.getString("BUY_FLAG"));
						sql.setString(i++, mi.getString("VEN_CD"));
						sql.setString(i++, mi.getString("PUMBUN_CD"));
						sql.setString(i++, mi.getString("EVENT_CD"));
						sql.setString(i++, mi.getString("SKU_CD"));
						sql.setString(i++, mi.getString("BUY_COST_PRC"));
						sql.setString(i++, mi.getString("QTY"));
						sql.setString(i++, userId);
						sql.setString(i++, userId);
				} else if (mi.IS_UPDATE()) {// 수정
					sql.put(svc.getQuery("UPD_EVTSKUONOUT"));

					sql.setString(i++, mi.getString("QTY"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("IN_DT"));
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("SLIP_NO"));
					sql.setString(i++, mi.getString("SEQ_NO"));
				} else if (mi.IS_DELETE()) { // 삭제
					sql.put(svc.getQuery("DEL_MST_EVTSKUONOUT"));

					sql.setString(i++, mi.getString("SLIP_NO"));
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
	 * 물품 입고/반품 내용을 삭제 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, String userId) throws Exception {
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();
			sql.put(svc.getQuery("DEL_MST_EVTSKUONOUT"));

			sql.setString(1, form.getParam("strInDt"));
			sql.setString(2, form.getParam("strSlipNo"));
			res = update(sql);

			if (res < 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
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
