/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.HashMap;
import java.util.Iterator;
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
 * <p>PC별품번조회순서 관리</p>
 * 
 * @created  on 1.0, 2010/03/04
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod207DAO extends AbstractDAO {

	/**
	 * 조직을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));
		String strOrgCd   = String2.nvl(form.getParam("strOrgCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		int i = 1;
		
		sql.put(svc.getQuery("SEL_ORGMST"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strOrgCd);
		
		//권한
		sql.put(svc.getQuery("SEL_ORGMST_WHERE_AUTH"));
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, userId);
		
		sql.put(svc.getQuery("SEL_ORGMST_ORDER"));

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 점별품번을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));
		String strOrgCd   = String2.nvl(form.getParam("strOrgCd"));
		String strUseYn   = String2.nvl(form.getParam("strUseYn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		int i = 1;
		
		sql.put(svc.getQuery("SEL_STRPBN"));
		sql.setString(i++, strStrCd);
		
		if( strOrgFlag.equals("1")){  //판매
			sql.put(svc.getQuery("SEL_STRPBN_WHERE_SALE_ORG_CD"));			
		}else{                        //매입
			sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUY_ORG_CD"));			
		}
		sql.setString(i++, strOrgCd);
		
		if(!strUseYn.equals("%")){
			sql.put(svc.getQuery("SEL_STRPBN_WHERE_USE_YN"));
			sql.setString(i++, strUseYn);
		}
		
		sql.put(svc.getQuery("SEL_STRPBN_ORDER"));

		ret = select2List(sql);

		return ret;
	}

	/**
	 *  <p>
	 *  점별 품번 마스터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveStrpbn(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if (mi.IS_UPDATE()){

					i = 0;							
					sql.put(svc.getQuery("UPD_STRPBN_SORT_NO"));
					sql.setString(++i, mi.getString("SORT_NO"));
					sql.setString(++i, strID);
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}else {

					//점별품번정보
					Map keys = new HashMap();
					keys.put("STR_CD", strStrCd);
					keys.put("PUMBUN_CD", mi.getString("PUMBUN_CD"));
					sql.close();
					update(Util.getHistorySQL("PC_STRPBN", "PC_STRPBNHIST", "DPS", keys, "STR_CD,PUMBUN_CD", strID));

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
