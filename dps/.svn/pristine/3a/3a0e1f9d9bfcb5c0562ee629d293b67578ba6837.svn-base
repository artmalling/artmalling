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
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>품번이동 관리</p>
 * 
 * @created  on 1.0, 2010/02/08
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod205DAO extends AbstractDAO {

	/**
	 * 품번이동 마스터를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strModDate = String2.nvl(form.getParam("strModDate"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));

		connect("pot");

		sql.put(svc.getQuery("SEL_PBNTRNSMST"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strModDate);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strOrgFlag);
/*
		sql.setString(i++, userId);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, userId);
		sql.setString(i++, strOrgFlag);
*/	

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 품번이동 상세를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String userId) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strModDate = String2.nvl(form.getParam("strModDate"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));
		String strBfOrgCd = String2.nvl(form.getParam("strBfOrgCd"));
		String strAftOrgCd = String2.nvl(form.getParam("strAftOrgCd"));

		connect("pot");

		sql.put(svc.getQuery("SEL_PBNTRNSDTL"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strModDate);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strBfOrgCd);
		sql.setString(i++, strAftOrgCd);
		sql.setString(i++, strBfOrgCd);
		sql.setString(i++, strOrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strBfOrgCd);
		sql.setString(i++, strModDate);
		sql.setString(i++, strAftOrgCd);
/*
		sql.setString(i++, userId);
*/	

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번이동 마스터에서 오늘 이후 변경 일자를 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTodayAfModDt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		String strStrCd = String2.nvl(form.getParam("strStrCd"));

		connect("pot");

		sql.put(svc.getQuery("SEL_TODAY_AF_MOD_DT"));
		sql.setString(i++, strStrCd);
		ret = select2List(sql);
		return ret;
	}
	


	/**
	 *  <p>
	 *  품번이동 마스터, 품번이동 상세
	 *  
	 *  저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			String strStrCd = String2.nvl(form.getParam("strStrCd"));
			String strModDate = String2.nvl(form.getParam("strModDate"));
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi[0].next()) {
				sql.close();
				if ( mi[0].IS_INSERT()) {		
					i = 0;						
					sql.put(svc.getQuery("SEL_PBNTRNSMST_CNT"));		
					sql.setString(++i, mi[0].getString("STR_CD"));
					sql.setString(++i, mi[0].getString("MOD_DT"));	
					sql.setString(++i, mi[0].getString("MOD_BF_ORG_CD"));	
					sql.setString(++i, mi[0].getString("MOD_AFT_ORG_CD"));		
					Map map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 데이터 입니다.");
					}
					sql.close();
					i = 0;			
					sql.put(svc.getQuery("INS_PBNTRNSMST"));		
					sql.setString(++i, mi[0].getString("STR_CD"));
					sql.setString(++i, mi[0].getString("ORG_FLAG"));
					sql.setString(++i, mi[0].getString("MOD_DT"));	
					sql.setString(++i, mi[0].getString("MOD_BF_ORG_CD"));	
					sql.setString(++i, mi[0].getString("MOD_AFT_ORG_CD"));	
					sql.setString(++i, mi[0].getString("PROC_YN"));	
					sql.setString(++i, strID);					
					sql.setString(++i, strID);				
				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				ret += res;
			}
			
			while (mi[1].next()) {
				res = 0;
				sql.close();
				if ( mi[1].IS_UPDATE()) {
					if( mi[1].getString("SEL").equals("T")){
						i = 0;			
						sql.put(svc.getQuery("INS_PBNTRNSDTL"));	
						sql.setString(++i, strStrCd);
						sql.setString(++i, strModDate);	
						sql.setString(++i, mi[1].getString("MOD_BF_ORG_CD"));
						sql.setString(++i, mi[1].getString("MOD_AFT_ORG_CD"));	
						sql.setString(++i, mi[1].getString("PUMBUN_CD"));	
						sql.setString(++i, mi[1].getString("PROC_YN"));	
						sql.setString(++i, strID);					
						sql.setString(++i, strID);			
					}else{
						i = 0;			
						sql.put(svc.getQuery("DEL_PBNTRNSDTL"));	
						sql.put(svc.getQuery("DEL_PBNTRNSDTL_WHERE_PUMBUN_CD"));		
						sql.setString(++i, strStrCd);
						sql.setString(++i, strModDate);	
						sql.setString(++i, mi[1].getString("MOD_BF_ORG_CD"));	
						sql.setString(++i, mi[1].getString("MOD_AFT_ORG_CD"));	
						sql.setString(++i, mi[1].getString("PUMBUN_CD"));
					}	
				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 처리 하지 못했습니다.");
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
	 *  <p>
	 *  품번이동 마스터, 상세 
	 *  삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) 
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
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					i = 0;				
					sql.put(svc.getQuery("DEL_PBNTRNSDTL"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("MOD_DT"));	
					sql.setString(++i, mi.getString("MOD_BF_ORG_CD"));	
					sql.setString(++i, mi.getString("MOD_AFT_ORG_CD"));	

					res = update(sql);	
					
					sql.close();					
					i = 0;							
					sql.put(svc.getQuery("DEL_PBNTRNSMST"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("MOD_DT"));	
					sql.setString(++i, mi.getString("MOD_BF_ORG_CD"));	
					sql.setString(++i, mi.getString("MOD_AFT_ORG_CD"));	
					
				} else {
						
				}
				res += update(sql);

				if (res < 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
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
