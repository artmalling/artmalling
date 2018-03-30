/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
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
 * <p>단품가격예약수정(규격/신선) 관리</p>
 * 
 * @created  on 1.0, 2010/04/05
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod602DAO extends AbstractDAO {
	
	/**
	 * 단품 가격을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userId, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));
		String strSkuName = URLDecoder.decode(String2.nvl(form.getParam("strSkuName")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, orgFlag);
		sql.setString(i++, userId);
		
		if( !strStrCd.equals("%")){
			sql.setString(i++, strStrCd);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STR_CD") + "\n";
		}
		
		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_VEN_CD") + "\n";
		}
		
		if( !strPummokCd.equals("%")){
			sql.setString(i++, strPummokCd);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD") + "\n";
		}

		if( !strSkuCd.equals("")){
			sql.setString(i++, strSkuCd);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
		}
		
		if( !strSkuName.equals("")){
			sql.setString(i++, strSkuName);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 단품 가격을 수정  처리한다.
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
				if ( mi.IS_UPDATE()) {
					
					i = 0;
					// 마진율 유효성체크  MARIO OUTLET START 2011-08-10
					// 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
				   if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {
						sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));							
						sql.setString(++i, mi.getString("STR_CD"));	
						sql.setString(++i, mi.getString("PUMBUN_CD"));
						sql.setString(++i, mi.getString("NORM_MG_RATE"));	
						sql.setString(++i, mi.getString("APP_S_DT"));
						
						
						Map map1 = selectMap( sql );							
						String mgRateCnt = String2.nvl((String)map1.get("CNT"));
						if( mgRateCnt.equals("0")) {
							throw new Exception("[USER]"+"마진율이 적합하지 않습니다.");
						}
					}
					// 마진율 유효성체크  MARIO OUTLET END
					
					

					sql.close();
					
					i = 0;			
					sql.put(svc.getQuery("UPD_STRSKUPRCMST"));		
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("NORM_COST_PRC"));
					sql.setString(++i, mi.getString("NORM_SALE_PRC"));	
					sql.setString(++i, mi.getString("NORM_MG_RATE"));	
					sql.setString(++i, mi.getString("NORM_COST_PRC"));
					sql.setString(++i, mi.getString("NORM_SALE_PRC"));	
					sql.setString(++i, mi.getString("NORM_MG_RATE"));	
					sql.setString(++i, strID);					
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("SKU_CD"));	
					sql.setString(++i, mi.getString("ORG_APP_S_DT"));	
					// 단품 정상가격 수정
					res = update(sql);
					
					sql.close();
					i = 0;			
					sql.put(svc.getQuery("UPD_STRSKUPRCMST_APP_E_DT"));		
					sql.setString(++i, Util.addDay(mi.getString("APP_S_DT"), -1));
					sql.setString(++i, strID);					
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("SKU_CD"));	
					sql.setString(++i, mi.getString("APP_S_DT"));	
					// 단품 가격 적용종료일  수정
					update(sql);					
				}	
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
	 * 단품 가격을 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi, String strID)
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
				if ( mi.IS_DELETE()) {
					i = 0;			
					sql.put(svc.getQuery("DEL_STRSKUPRCMST"));		
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("SKU_CD"));	
					sql.setString(++i, mi.getString("ORG_APP_S_DT"));	
					// 단품 정상가격 삭제ㅇ
					res = update(sql);
					
					sql.close();
					i = 0;			
					sql.put(svc.getQuery("UPD_STRSKUPRCMST_APP_E_DT"));		
					sql.setString(++i, "99991231");
					sql.setString(++i, strID);					
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("SKU_CD"));	
					sql.setString(++i, mi.getString("ORG_APP_S_DT"));	
					// 단품 가격 적용종료일  수정
					update(sql);		
				}else{
					continue;
				}
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
}
