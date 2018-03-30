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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2011/02/21
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae105DAO extends AbstractDAO {
	/**
	 * 대상 범위 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strTrgCd = String2.nvl(form.getParam("strTrgCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strTrgCd);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 *  대상 범위 마스터 내용 등록/ 수정
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
				if (mi.IS_INSERT()) { // 저장
					
					sql.put(svc.getQuery("INS_EVTTRGMST")); 
					
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("TRG_NAME"));
					sql.setString(i++, mi.getString("TRG_F"));
					sql.setString(i++, mi.getString("TRG_T"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);

				}else if(mi.IS_UPDATE()){// 수정
					sql.put(svc.getQuery("UPD_EVTTRGMST")); 
					
					sql.setString(i++, mi.getString("TRG_NAME"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("TRG_CD"));
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
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
