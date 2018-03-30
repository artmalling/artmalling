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
 * <p>신선단품 관리</p>
 * 
 * @created  on 1.0, 2010/03/15
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod502DAO extends AbstractDAO {
	
	/**
	 * 신선단품 마스터을 조회한다.
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
		
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));
		String strSkuName = URLDecoder.decode( String2.nvl(form.getParam("strSkuName")), "UTF-8");
		String strUseYn = String2.nvl(form.getParam("strUseYn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_SKUMST") + "\n";
		sql.setString(i++, strPumbunCd);
		
		if( !strPummokCd.equals("%")){
			sql.setString(i++, strPummokCd);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMMOK_CD") + "\n";
		}
		
		if( !strSkuCd.equals("")){
			sql.setString(i++, strSkuCd);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_SKU_CD") + "\n";
		}
		if( !strSkuName.equals("")){
			sql.setString(i++, strSkuName);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_SKU_NAME") + "\n";
		}
		if( !strUseYn.equals("%")){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_USE_YN") + "\n";
		}
		strQuery += svc.getQuery("SEL_SKUMST_ORDER");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 점별단품 을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_STRSKUMST");
		sql.setString(i++, strSkuCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strSkuCd);

		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 신선단품 마스터와 점별단품  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			 
			for(int idx = 0 ; idx < 2 ; idx++){
				// 단품마스터정보
				if( idx == 0){
					ret += saveSkumst(form, mi[idx], strID);
				// 점별단품 정보
				}else if ( idx == 1){
					ret += saveStrsku(form, mi[idx], strID);
				}			
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
	 *  단품마스터정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveSkumst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			String newSkuCd = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String svcFlag = "";
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					i = 0;
					svcFlag = "I";
					sql.put(svc.getQuery("SEL_SKUMST_NEW_CD"));
					Map map = selectMap( sql );
					newSkuCd = String2.nvl((String)map.get("NEW_SKU_CD"));
					if( newSkuCd.equals("")) {
						throw new Exception("[USER]"+"단품코드를 생성 할 수 없습니다.");
					}
					String checkSum = Util.getSkuCdCheckSum(newSkuCd);
					newSkuCd = newSkuCd + checkSum;
					sql.close();
					i = 0;
					
					sql.put(svc.getQuery("INS_SKUMST"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("PUMBUN_TYPE"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, mi.getString("SKU_TYPE"));
					sql.setString(++i, mi.getString("STYLE_TYPE"));
					sql.setString(++i, mi.getString("PLU_FLAG"));
					sql.setString(++i, mi.getString("MODEL_NO"));
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, mi.getString("MAKER_CD"));
					sql.setString(++i, mi.getString("SET_YN"));
					sql.setString(++i, mi.getString("GIFT_FLAG"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					svcFlag = "U";
					newSkuCd = mi.getString("SKU_CD");
					i = 0;
					sql.put(svc.getQuery("UPD_STRSKUMST_SKU"));
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("PUMBUN_TYPE"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SKU_CD"));
					//점별단품 정보 수정
					update(sql);
					
					sql.close();
					i = 0;
					sql.put(svc.getQuery("UPD_SKUMST"));
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("PUMBUN_TYPE"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, mi.getString("SKU_TYPE"));
					sql.setString(++i, mi.getString("STYLE_TYPE"));
					sql.setString(++i, mi.getString("PLU_FLAG"));
					sql.setString(++i, mi.getString("MODEL_NO"));
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, mi.getString("MAKER_CD"));
					sql.setString(++i, mi.getString("SET_YN"));
					sql.setString(++i, mi.getString("GIFT_FLAG"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SKU_CD"));

				} else {
						
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				//History
				Map keys = new HashMap();
				keys.put("SKU_CD", newSkuCd);
				sql.close();
				update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));
				
				if(svcFlag.equals("U")){
					sql.close();
					keys = new HashMap();
					keys.put("SKU_CD", newSkuCd);
					update(Util.getHistorySQL("PC_STRSKUMST", "PC_STRSKUHIST", "DPS", keys, "STR_CD,SKU_CD", strID));
				}
				
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}

	/**
	 * <p>
	 * 점별단품 저장
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveStrsku(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			String strSkuCd = String2.nvl(form.getParam("strSkuCd"));
			String strSkuName = URLDecoder.decode( String2.nvl(form.getParam("strSkuName")), "UTF-8");
			String strRecpName = URLDecoder.decode( String2.nvl(form.getParam("strRecpName")), "UTF-8");
			String strPumbunType = String2.nvl(form.getParam("strPumbunType"));
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
			String strSkuType = String2.nvl(form.getParam("strSkuType"));
			String strStyleType = String2.nvl(form.getParam("strStyleType"));
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			
			while (mi.next()) {
				sql.close();
				if (mi.IS_UPDATE()){
					i = 0;
					if( mi.getString("SKU_CD").equals("")){
						
						sql.put(svc.getQuery("INS_STRSKUMST"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, strSkuCd);
						sql.setString(++i, strSkuName);
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, strRecpName);
						sql.setString(++i, strPumbunType);
						sql.setString(++i, strPumbunCd);
						sql.setString(++i, strSkuType);
						sql.setString(++i, strStyleType);
						sql.setString(++i, mi.getString("SAL_COST_PRC"));
						sql.setString(++i, mi.getString("SALE_PRC"));
						sql.setString(++i, mi.getString("SALE_MG_RATE"));
						sql.setString(++i, mi.getString("SALE_S_DT"));
						sql.setString(++i, mi.getString("SALE_E_DT"));
						sql.setString(++i, mi.getString("BUY_S_DT"));
						sql.setString(++i, mi.getString("BUY_E_DT"));
						sql.setString(++i, mi.getString("USE_YN"));
						sql.setString(++i, strID);
						sql.setString(++i, strID);
						//점별단품 마스터 저장
						res = update(sql);
						sql.close();
						i = 0;
						
						sql.put(svc.getQuery("SEL_BARCDMST_BAR_CODE_CNT"));							
						sql.setString(++i, strSkuCd);					
						sql.setString(++i, strSkuCd);
						Map map = selectMap( sql );							
						String barCodeCnt = String2.nvl((String)map.get("CNT"));
						if( !barCodeCnt.equals("0")) {
							throw new Exception("[USER]"+"중복되는 소스마킹코드 입니다.");
						}
						sql.close();

						i = 0;
						sql.put(svc.getQuery("INS_BARCDMST"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, strSkuCd);
						sql.setString(++i, strSkuCd);
						sql.setString(++i, strPumbunCd);
						sql.setString(++i, strID);
						sql.setString(++i, strID);
						//소스마킹코드 저장
						update(sql);
						sql.close();
						i = 0;

						sql.put(svc.getQuery("INS_STRSKUPRCMST"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, strSkuCd);
						sql.setString(++i, "00000000000");
						sql.setString(++i, "99991231");
						sql.setString(++i, mi.getString("SAL_COST_PRC"));
						sql.setString(++i, mi.getString("SALE_PRC"));
						sql.setString(++i, mi.getString("SALE_MG_RATE"));
						sql.setString(++i, mi.getString("SAL_COST_PRC"));
						sql.setString(++i, mi.getString("SALE_PRC"));
						sql.setString(++i, mi.getString("SALE_MG_RATE"));
						sql.setString(++i, "0");
						sql.setString(++i, strID);
						sql.setString(++i, strID);
						//점별단품가격 저장
						update(sql);

					}else{

						sql.put(svc.getQuery("UPD_STRSKUMST"));
						sql.setString(++i, strSkuName);
						sql.setString(++i, strRecpName);
						sql.setString(++i, mi.getString("SALE_S_DT"));
						sql.setString(++i, mi.getString("SALE_E_DT"));
						sql.setString(++i, mi.getString("BUY_S_DT"));
						sql.setString(++i, mi.getString("BUY_E_DT"));
						sql.setString(++i, mi.getString("USE_YN"));
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, strSkuCd);
						//점별단품 마스터 저장
						res = update(sql);
					}
				} else {
				}

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				Map keys = new HashMap();
				keys.put("STR_CD", mi.getString("STR_CD"));
				keys.put("SKU_CD", strSkuCd);
				sql.close();
				update(Util.getHistorySQL("PC_STRSKUMST", "PC_STRSKUHIST", "DPS", keys, "STR_CD,SKU_CD", strID));
				
				ret += res;
			}


		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
}
