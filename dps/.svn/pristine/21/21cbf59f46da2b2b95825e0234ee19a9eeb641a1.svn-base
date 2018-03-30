/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>점별행사장관리</p>
 * 
 * @created  on 1.0, 2010/02/09
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod702DAO extends AbstractDAO {


	/**
	 * 점별 행사장을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EVTMST") + "\n";

		if( !strStrCd.equals("%")){
			sql.setString(i++, strStrCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_STR_CD") + "\n";
		}

		strQuery += svc.getQuery("SEL_EVTMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 점별 행사장을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;			
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {

					i = 0;
					
					sql.put(svc.getQuery("INS_EVTMST"));
					
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("EVENT_PLACE_NAME"));
					sql.setString(++i, mi.getString("EVENT_POSITION"));
					sql.setString(++i, mi.getString("AREA_SIZE"));
					sql.setString(++i, mi.getString("FLOR_CD"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				} else if (mi.IS_UPDATE()) {
					
					i = 0;
					
					sql.put(svc.getQuery("UPD_EVTMST"));

					sql.setString(++i, mi.getString("EVENT_PLACE_NAME"));
					sql.setString(++i, mi.getString("EVENT_POSITION"));
					sql.setString(++i, mi.getString("AREA_SIZE"));
					sql.setString(++i, mi.getString("FLOR_CD"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]"+"[USER]" + "데이터의 적합성 문제로 인하여"
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
