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


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>긴급매가가격수정</p>
 * 
 * @created  on 1.0, 2010/04/15
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod606DAO extends AbstractDAO {
	
	/**
	 * 긴급매가가격을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();

		String skuType = mi.getString("SKU_TYPE");
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		if(skuType.equals("3")){
			strQuery += svc.getQuery("SEL_MASTER_STYLE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE") + "\n";
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("APP_DT_S"));
			sql.setString(i++, mi.getString("APP_DT_E"));
		}else{
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("APP_DT_S"));
			sql.setString(i++, mi.getString("APP_DT_E"));
		}
		
		if( !mi.getString("PUMMOK_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD") + "\n";
		}
		
		if( !mi.getString("SKU_CD").equals("")){
			sql.setString(i++, mi.getString("SKU_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
		}
		
		if( !mi.getString("SKU_NAME").equals("")){
			sql.setString(i++, mi.getString("SKU_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_NAME") + "\n";
		}		
		
		if( !mi.getString("A_STYLE_CD").equals("")){
			sql.setString(i++, mi.getString("A_STYLE_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_CD") + "\n";
		}
		
		if( !mi.getString("A_STYLE_NAME").equals("")){
			sql.setString(i++, mi.getString("A_STYLE_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_NAME") + "\n";
		}
		
		if( !mi.getString("A_BRAND_CD").equals("%")){
			sql.setString(i++, mi.getString("A_BRAND_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BRAND_CD") + "\n";
		}
		
		if( !mi.getString("A_SUB_BRD_CD").equals("%")){
			sql.setString(i++, mi.getString("A_SUB_BRD_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SUB_BRD_CD") + "\n";
		}
		
		if( !mi.getString("PLAN_YEAR_CD").equals("%")){
			sql.setString(i++, mi.getString("PLAN_YEAR_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PLAN_YEAR_CD") + "\n";
		}
		
		if( !mi.getString("SEASON_CD").equals("%")){
			sql.setString(i++, mi.getString("SEASON_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SEASON_CD") + "\n";
		}
		
		if( !mi.getString("ITEM_CD").equals("%")){
			sql.setString(i++, mi.getString("ITEM_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_ITEM_CD") + "\n";
		}
		
		if( !mi.getString("B_STYLE_CD").equals("")){
			sql.setString(i++, mi.getString("B_STYLE_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_CD") + "\n";
		}
		
		if( !mi.getString("B_STYLE_NAME").equals("")){
			sql.setString(i++, mi.getString("B_STYLE_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_NAME") + "\n";
		}
		
		if( !mi.getString("B_BRAND_CD").equals("%")){
			sql.setString(i++, mi.getString("B_BRAND_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BRAND_CD") + "\n";
		}
		
		if( !mi.getString("B_SUB_BRD_CD").equals("%")){
			sql.setString(i++, mi.getString("B_SUB_BRD_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SUB_BRD_CD") + "\n";
		}
		
		if( !mi.getString("MNG_CD1").equals("")){
			sql.setString(i++, mi.getString("MNG_CD1"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD1") + "\n";
		}
		
		if( !mi.getString("MNG_CD2").equals("")){
			sql.setString(i++, mi.getString("MNG_CD2"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD2") + "\n";
		}
		
		if( !mi.getString("MNG_CD3").equals("")){
			sql.setString(i++, mi.getString("MNG_CD3"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD3") + "\n";
		}
		
		if( !mi.getString("MNG_CD4").equals("")){
			sql.setString(i++, mi.getString("MNG_CD4"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD4") + "\n";
		}
		
		if( !mi.getString("MNG_CD5").equals("")){
			sql.setString(i++, mi.getString("MNG_CD5"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD5") + "\n";
		}
				
		if(skuType.equals("3"))
		    strQuery += svc.getQuery("SEL_MASTER_STYLE_ORDER");
		else
		    strQuery += svc.getQuery("SEL_MASTER_ORDER");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 긴급 단가를 저장한다.
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int save( ActionForm form, MultiInput mi, String strID) throws Exception{
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
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
			
			while (mi.next()) {
				sql.close();
				if ( mi.IS_UPDATE()) {
					
					i = 0;
					
					// 마진율 유효성체크  MARIO OUTLET START 2011-08-10
				    // 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
				   if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {
						
						
						
						if(mi.getString("EVENT_CD").equals("00000000000")) {
							sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));							
						} else {
							sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK_HANGSA"));
						}
						
						sql.setString(++i, mi.getString("STR_CD"));	
						sql.setString(++i, strPumbunCd);
						sql.setString(++i, mi.getString("EMG_MG_RATE"));	
						sql.setString(++i, mi.getString("APP_S_DT"));
						
						if(!mi.getString("EVENT_CD").equals("00000000000")) {
							sql.setString(++i, mi.getString("APP_E_DT"));
						}
						
						Map map1 = selectMap( sql );							
						String mgRateCnt = String2.nvl((String)map1.get("CNT"));
						if( mgRateCnt.equals("0")) {
							throw new Exception("[USER]"+"마진율이 적합하지 않습니다.");
						}
					 }
					
					 // 마진율 유효성체크  MARIO OUTLET END
					
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("SEL_EMG_CONF_FLAG"));							
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("EVENT_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));				
					sql.setString(++i, mi.getString("SEQ_NO"));
					Map map = selectMap( sql );							
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"("+mi.getString("SKU_CD")+")<br>["+mi.getString("SKU_NAME")+"]<br>확정되어 긴급매가를 수정할수 없습니다.");
					}
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("UPD_EMGPRICE"));
					sql.setString(++i, mi.getString("EMG_COST_PRC"));
					sql.setString(++i, mi.getString("EMG_SALE_PRC"));
					sql.setString(++i, mi.getString("EMG_MG_RATE"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("EVENT_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));				
					sql.setString(++i, mi.getString("SEQ_NO"));
					
				} else {
						
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
	 * 긴급 단가를 삭제한다.
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int delete( ActionForm form, MultiInput mi) throws Exception{
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
					sql.put(svc.getQuery("SEL_EMG_CONF_FLAG"));							
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("EVENT_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));				
					sql.setString(++i, mi.getString("SEQ_NO"));
					Map map = selectMap( sql );							
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"("+mi.getString("SKU_CD")+")<br>["+mi.getString("SKU_NAME")+"]<br>확정되어 긴급매가를 삭제할수 없습니다.");
					}
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("DEL_EMGPRICE"));
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("EVENT_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));				
					sql.setString(++i, mi.getString("SEQ_NO"));
					
				} else {
					continue;	
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제를 하지 못했습니다.");
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
