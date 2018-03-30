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
 * <p>긴급매가가격등록</p>
 * 
 * @created  on 1.0, 2010/04/13
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod605DAO extends AbstractDAO {
	
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
		String evnetCd = mi.getString("EVENT_GUBUN").equals("0")?"00000000000":mi.getString("EVENT_CD");
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, evnetCd);
		sql.setString(i++, mi.getString("STR_CD"));
		sql.setString(i++, evnetCd);
		sql.setString(i++, mi.getString("STR_CD"));
		sql.setString(i++, evnetCd);
		
		if(skuType.equals("3")){
			strQuery += svc.getQuery("SEL_MASTER_STYLE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE") + "\n";
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
		}else{
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
		}
		
		// 정상일경우 행사 가격이 있으면 제외
		if(mi.getString("EVENT_GUBUN").equals("0")){                   
			strQuery += svc.getQuery("SEL_MASTER_WHERE_NOT_EXISTS_EVENT") + "\n";			
		}
		
		if( !mi.getString("PUMMOK_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD") + "\n";
		}
		
		if( !mi.getString("VEN_CD").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_VEN_CD") + "\n";
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
	 * 단품의 긴급매가가격을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSkuMaster(ActionForm form) throws Exception {		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));         //점코드
		String strEventCd = String2.nvl(form.getParam("strEventCd"));     //행사코드
		String strSkuType = String2.nvl(form.getParam("strSkuType"));     //단품유형
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));   //품번코드
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));         //단품코드

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strEventCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		if(strSkuType.equals("3")){
			strQuery += svc.getQuery("SEL_MASTER_STYLE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE") + "\n";
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPumbunCd);
		}else{
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPumbunCd);
		}
		strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
		
		if(strEventCd.equals("00000000000")){                                    // 정상일경우 행사 가격이 있으면 제외
			strQuery += svc.getQuery("SEL_MASTER_WHERE_NOT_EXISTS_EVENT") + "\n";			
		}
		sql.setString(i++, strSkuCd);

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
			String strRdEventGubun = String2.nvl(form.getParam("strRdEventGubun"));
			
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT() || mi.IS_UPDATE()) {
					if( mi.getString("CHECK").equals("T")){
						i = 0;
						
						// 마진율 유효성체크  MARIO OUTLET START 2011-08-10
					    // 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
						if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {
							
							if(strRdEventGubun.equals("0")) {
								sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));							
							} else {
								sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK_HANGSA"));
							}
							
							sql.setString(++i, mi.getString("STR_CD"));	
							sql.setString(++i, strPumbunCd);
							sql.setString(++i, mi.getString("BF_EMG_MG_RATE"));	
							sql.setString(++i, mi.getString("APP_S_DT"));
							
							if(!strRdEventGubun.equals("0")) {
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
						
						sql.put(svc.getQuery("SEL_EMG_NOT_CONF_CNT"));							
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("SKU_CD"));					
						sql.setString(++i, mi.getString("EVENT_CD"));					
						sql.setString(++i, mi.getString("APP_S_DT"));
						Map map = selectMap( sql );							
						String notConfCnt = String2.nvl((String)map.get("CNT"));
						if( !notConfCnt.equals("0")) {
							throw new Exception("[USER]"+"("+mi.getString("SKU_CD")+")<br>["+mi.getString("SKU_NAME")+"]<br>확정되지 않은 긴급매가가 존재합니다.");
						}
						sql.close();
						
						i = 0;
						sql.put(svc.getQuery("INS_EMGPRICE"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("SKU_CD"));
						sql.setString(++i, mi.getString("EVENT_CD"));
						sql.setString(++i, mi.getString("APP_S_DT"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("SKU_CD"));
						sql.setString(++i, mi.getString("EVENT_CD"));
						sql.setString(++i, mi.getString("APP_S_DT"));
						sql.setString(++i, mi.getString("APP_E_DT"));
						sql.setString(++i, "1");                         // 미 확정
						sql.setString(++i, mi.getString("BF_EMG_COST_PRC"));
						sql.setString(++i, mi.getString("BF_EMG_SALE_PRC"));
						sql.setString(++i, mi.getString("BF_EMG_MG_RATE"));
						sql.setString(++i, strID);
						sql.setString(++i, strID);
					}
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
}
