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
 * <p>의류단품 관리(B-TYPE)</p>
 * 
 * @created  on 1.0, 2010/03/18
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod504DAO extends AbstractDAO {
	
	/**
	 * 스타일 마스터을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchStyle(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		
		String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		String strStyleCd = String2.nvl(form.getParam("strStyleCd"));
		String strStyleName = URLDecoder.decode( String2.nvl(form.getParam("strStyleName")), "UTF-8");		
		String strBrandCd = String2.nvl(form.getParam("strBrandCd"));
		String strSubBrdCd = String2.nvl(form.getParam("strSubBrdCd"));
		String strMngCd1 = String2.nvl(form.getParam("strMngCd1"));
		String strMngCd2 = String2.nvl(form.getParam("strMngCd2"));
		String strMngCd3 = String2.nvl(form.getParam("strMngCd3"));
		String strMngCd4 = String2.nvl(form.getParam("strMngCd4"));
		String strMngCd5 = String2.nvl(form.getParam("strMngCd5"));
		String strUseYn = String2.nvl(form.getParam("strUseYn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_STYLEMST") + "\n";
		sql.setString(i++, strPumbunCd);
		
		if( !strPummokCd.equals("%")){
			sql.setString(i++, strPummokCd);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_PUMMOK_CD") + "\n";
		}
		
		if( !strStyleCd.equals("")){
			sql.setString(i++, strStyleCd);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_STYLE_CD") + "\n";
		}
		if( !strStyleName.equals("")){
			sql.setString(i++, strStyleName);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_STYLE_NAME") + "\n";
		}

		if( !strBrandCd.equals("%")){
			sql.setString(i++, strBrandCd);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_BRAND_CD") + "\n";
		}

		if( !strSubBrdCd.equals("%")){
			sql.setString(i++, strSubBrdCd);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_SUB_BRD_CD") + "\n";
		}
		
		if( !strMngCd1.equals("")){
			sql.setString(i++, strMngCd1);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_MNG_CD1") + "\n";
		}
		if( !strMngCd2.equals("")){
			sql.setString(i++, strMngCd2);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_MNG_CD2") + "\n";
		}
		if( !strMngCd3.equals("")){
			sql.setString(i++, strMngCd3);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_MNG_CD3") + "\n";
		}
		if( !strMngCd4.equals("")){
			sql.setString(i++, strMngCd4);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_MNG_CD4") + "\n";
		}
		if( !strMngCd5.equals("")){
			sql.setString(i++, strMngCd5);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_MNG_CD5") + "\n";
		}
		if( !strUseYn.equals("%")){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_STYLEMST_WHERE_USE_YN") + "\n";
		}

		strQuery += svc.getQuery("SEL_STYLEMST_ORDER");

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
	public List searchStrsku(ActionForm form) throws Exception {

		List ret = null;
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strStyleCd = String2.nvl(form.getParam("strStyleCd"));
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_STRSKUMST");
		sql.setString(i++, strSkuCd);

		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}
	/**
	 * 스타일 마스터,단품 마스터, 점별단품
	 * 저장, 수정  처리한다.
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

		try {
			connect("pot");
			begin();
			 
			for(int idx = 0 ; idx < 2 ; idx++){
				// 스타일마스터정보
				if( idx == 0){
					ret += saveStylemst(form, mi[idx], strID);
				// 단품마스터정보
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
	 *  스타일마스터정보를 저장한다.  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveStylemst(ActionForm form, MultiInput mi, String strID ) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String strSkuUpdateGb = String2.nvl(form.getParam("strSkuUpdateGb"));
		boolean skuUpdateGb = strSkuUpdateGb.equals("Y");
		boolean skuIns = false;
		String newSkuCd = "";
		Map map = null;
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				skuIns = false;
				if ( mi.IS_INSERT()) {

					i = 0;
					sql.put(svc.getQuery("SEL_STYLEMST_STYLE_CD_CNT"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));					
					sql.setString(++i, mi.getString("STYLE_CD"));
					
					map = selectMap( sql );
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 스타일 코드 입니다.");
					}
					sql.close();
					
					i = 0;
					
					sql.put(svc.getQuery("INS_STYLEMST"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));					
					sql.setString(++i, mi.getString("STYLE_CD"));					
					sql.setString(++i, mi.getString("STYLE_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, mi.getString("BRAND_CD"));
					sql.setString(++i, mi.getString("SUB_BRD_CD"));
					sql.setString(++i, mi.getString("MNG_CD1"));
					sql.setString(++i, mi.getString("MNG_CD2"));
					sql.setString(++i, mi.getString("MNG_CD3"));
					sql.setString(++i, mi.getString("MNG_CD4"));
					sql.setString(++i, mi.getString("MNG_CD5"));
					sql.setString(++i, "");                            //SIZE_TYPE
					sql.setString(++i, mi.getString("MAKER_CD"));
					sql.setString(++i, mi.getString("SEX_CD"));
					sql.setString(++i, mi.getString("CURRENCY_CD"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, mi.getString("VEN_STYLE_CD"));
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);

					//스타일 신규 입력
					res = update(sql);

					sql.close();
					i = 0;
					newSkuCd = mi.getString("SKU_CD");

					if( !mi.getString("INPUT_PLU_CD").equals("") && newSkuCd.equals("")){
						newSkuCd = String2.leftPad(mi.getString("INPUT_PLU_CD"), 13,'0');
						if(newSkuCd.substring(0,1).equals("2")){
							throw new Exception("[USER]"+"사용할수 없는 소스마킹코드입니다.");
						}
						if(!Util.isSkuCdCheckSum(newSkuCd)){
							throw new Exception("[USER]"+"사용할수 없는 소스마킹코드입니다.");							
						}
					}
					
					//단품코드 자동발번
					if( newSkuCd.equals("")){
						sql.put(svc.getQuery("SEL_SKUMST_NEW_CD"));
						map = selectMap( sql );
						newSkuCd = String2.nvl((String)map.get("NEW_SKU_CD"));
						if( newSkuCd.equals("")) {
							throw new Exception("[USER]"+"단품코드를 생성 할 수 없습니다.");
						}
						String checkSum = Util.getSkuCdCheckSum(newSkuCd);
						newSkuCd = newSkuCd + checkSum;
						sql.close();
					//단품코드 중복체크
					}else{
						i = 0;
						sql.put(svc.getQuery("SEL_BARCDMST_BAR_CODE_CNT"));							
						sql.setString(++i, newSkuCd);	
						sql.setString(++i, newSkuCd);
						map = selectMap( sql );							
						String barCodeCnt = String2.nvl((String)map.get("CNT"));
						if( !barCodeCnt.equals("0")) {
							throw new Exception("[USER]"+"중복되는 소스마킹코드 입니다.");
						}
						sql.close();
						i = 0;
						
						sql.put(svc.getQuery("SEL_SKUMST_SKU_CD_CNT"));							
						sql.setString(++i, newSkuCd);
						map = selectMap( sql );							
						String skuCdCnt = String2.nvl((String)map.get("CNT"));
						if( !skuCdCnt.equals("0")) {
							throw new Exception("[USER]"+"중복되는 단품코드 입니다.");
						}
						sql.close();
					}
					i = 0;
					
					sql.put(svc.getQuery("INS_SKUMST"));
					sql.setString(++i, "");
					sql.setString(++i, "");
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("INPUT_PLU_CD"));
					sql.setString(++i, mi.getString("PUMBUN_TYPE"));
					sql.setString(++i, mi.getString("PLU_FLAG"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("STYLE_CD"));
					//단품 마스터 저장
					res = update(sql);
					sql.close();
					i = 0;
					
					skuIns = true;
					
				} else if (mi.IS_UPDATE()){
					i = 0;
					sql.put(svc.getQuery("UPD_STYLEMST"));
					sql.setString(++i, mi.getString("STYLE_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, mi.getString("BRAND_CD"));
					sql.setString(++i, mi.getString("SUB_BRD_CD"));
					sql.setString(++i, mi.getString("MNG_CD1"));
					sql.setString(++i, mi.getString("MNG_CD2"));
					sql.setString(++i, mi.getString("MNG_CD3"));
					sql.setString(++i, mi.getString("MNG_CD4"));
					sql.setString(++i, mi.getString("MNG_CD5"));
					sql.setString(++i, "");                        //SIZE_TYPE
					sql.setString(++i, mi.getString("MAKER_CD"));
					sql.setString(++i, mi.getString("SEX_CD"));
					sql.setString(++i, mi.getString("CURRENCY_CD"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, mi.getString("VEN_STYLE_CD"));
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("STYLE_CD"));

					//스타일 정보 수정
					res = update(sql);
					
					if(skuUpdateGb){
						sql.close();
						i = 0;
						sql.put(svc.getQuery("UPD_SKUMST"));
						sql.setString(++i, mi.getString("STYLE_NAME"));
						sql.setString(++i, mi.getString("RECP_NAME"));
						sql.setString(++i, mi.getString("PUMBUN_TYPE"));
						sql.setString(++i, mi.getString("PUMMOK_CD"));
						sql.setString(++i, mi.getString("VEN_STYLE_CD"));
						sql.setString(++i, mi.getString("SALE_UNIT_CD"));
						sql.setString(++i, mi.getString("CMP_SPEC_CD"));
						sql.setString(++i, mi.getString("CMP_SPEC_UNIT"));
						sql.setString(++i, mi.getString("BAS_SPEC_CD"));
						sql.setString(++i, mi.getString("BAS_SPEC_UNIT"));
						sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
						sql.setString(++i, mi.getString("MAKER_CD"));
						sql.setString(++i, mi.getString("REMARK"));
						sql.setString(++i, mi.getString("USE_YN"));    
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("PUMBUN_CD"));
						sql.setString(++i, mi.getString("STYLE_CD"));
						//단품 정보 수정
						update(sql);
						sql.close();
						i = 0;
						sql.put(svc.getQuery("UPD_STRSKUMST_SKU"));
						sql.setString(++i, mi.getString("STYLE_NAME"));
						sql.setString(++i, mi.getString("RECP_NAME"));
						sql.setString(++i, mi.getString("PUMBUN_TYPE"));
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("PUMBUN_CD"));
						sql.setString(++i, mi.getString("STYLE_CD"));
						//점별단품 정보 수정
						update(sql);
					}
				} else {
						
				}
				

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				sql.close();
				Map keys = new HashMap();
				keys.put("PUMBUN_CD", mi.getString("PUMBUN_CD"));
				keys.put("STYLE_CD", mi.getString("STYLE_CD"));
				update(Util.getHistorySQL("PC_STYLEMST", "PC_STYLEHIST", "DPS", keys, "PUMBUN_CD,STYLE_CD", strID));
				if(skuIns){
					//History
					sql.close();
					keys = new HashMap();
					keys.put("SKU_CD", newSkuCd);
					update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));		
				}
				if(skuUpdateGb){
					sql.close();
					keys = new HashMap();
					keys.put("PUMBUN_CD", mi.getString("PUMBUN_CD"));
					keys.put("STYLE_CD", mi.getString("STYLE_CD"));
					update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));
					
					sql.close();
					keys = new HashMap();
					keys.put("PUMBUN_CD", mi.getString("PUMBUN_CD"));
					keys.put("STYLE_CD", mi.getString("STYLE_CD"));
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
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String strSkuCd = String2.nvl(form.getParam("strSkuCd"));

			while (mi.next()) {
				sql.close();
				if (mi.IS_UPDATE()){
					i = 0;
					if( mi.getString("FLAG").equals("0")){
						
						sql.put(svc.getQuery("INS_STRSKUMST"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, strSkuCd);
						sql.setString(++i, mi.getString("SKU_NAME"));
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, mi.getString("RECP_NAME"));
						sql.setString(++i, mi.getString("PUMBUN_TYPE"));
						sql.setString(++i, mi.getString("PUMBUN_CD"));
						sql.setString(++i, mi.getString("SKU_TYPE"));
						sql.setString(++i, mi.getString("STYLE_TYPE"));
						sql.setString(++i, mi.getString("STYLE_CD"));
						sql.setString(++i, "");
						sql.setString(++i, "");						
						sql.setString(++i, mi.getString("SAL_COST_PRC"));
						sql.setString(++i, mi.getString("SALE_PRC"));
						sql.setString(++i, mi.getString("SALE_MG_RATE"));
						sql.setString(++i, mi.getString("ADV_ORD_YN"));
						sql.setString(++i, mi.getString("LOW_ORD_QTY"));
						sql.setString(++i, mi.getString("OTM_STK_QTY"));
						sql.setString(++i, mi.getString("LEAD_TIME"));
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
						sql.setString(++i, mi.getString("PUMBUN_CD"));
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
						sql.setString(++i, mi.getString("SKU_NAME"));
						sql.setString(++i, mi.getString("RECP_NAME"));
						sql.setString(++i, mi.getString("ADV_ORD_YN"));
						sql.setString(++i, mi.getString("LOW_ORD_QTY"));
						sql.setString(++i, mi.getString("OTM_STK_QTY"));
						sql.setString(++i, mi.getString("LEAD_TIME"));
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
				sql.close();				
				Map keys = new HashMap();
				keys.put("STR_CD", mi.getString("STR_CD"));
				keys.put("SKU_CD", strSkuCd);
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
