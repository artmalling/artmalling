/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>자사위탁판매 정산</p>
 * 
 * @created  on 1.0, 2011/06/07
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif604DAO extends AbstractDAO {
	/**
	 * 위탁매출 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getList(ActionForm form) throws Exception {

		List ret[] = new List[2];
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strYM = String2.nvl(form.getParam("strYM"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_OUTREQCONF") + "\n";
		sql.put(strQuery);
		sql.setString(1, strStrCd);
		sql.setString(2, strYM);
		sql.setString(3, strVenCd);
		sql.setString(4, strStrCd);
		sql.setString(5, strYM);
		sql.setString(6, strVenCd);
		ret[0] = select2List(sql);
		
		sql.close();
		strQuery = svc.getQuery("SEL_JOINCAL") + "\n";
		sql.put(strQuery);
		sql.setString(1, strStrCd);
		sql.setString(2, strYM);
		sql.setString(3, strVenCd);
		ret[1] = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 자사위타판매 정산 저장
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
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				i = 1;
				sql.close();
				sql.put(svc.getQuery("INS_JOINCAL"));
				sql.setString(i++, mi.getString("CAL_YM"));
				sql.setString(i++, mi.getString("OUT_STR"));
				sql.setString(i++, mi.getString("VEN_CD"));
				sql.setString(i++, mi.getString("OUT_AMT"));
				sql.setString(i++, mi.getString("PAY_AMT"));
				sql.setString(i++, mi.getString("FEE_PAY_AMT"));
				sql.setString(i++, mi.getString("CUR_BOND_AMT"));
				sql.setString(i++, userId);
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
}
