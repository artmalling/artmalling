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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>규격단품 관리</p>
 * 
 * @created  on 1.0, 2010/01/24
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod501DAO extends AbstractDAO {
	
	/**
	 * 규격단품 마스터을 조회한다.
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
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strSkuCd);

		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 규격단품 마스터와 점별단품  저장, 수정  처리한다.
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

					svcFlag = "I";
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
						Map map = selectMap( sql );
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
						Map map = selectMap( sql );							
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
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("PUMBUN_TYPE"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, mi.getString("SKU_TYPE"));
					sql.setString(++i, mi.getString("STYLE_TYPE"));
					sql.setString(++i, mi.getString("PLU_FLAG"));
					sql.setString(++i, mi.getString("INPUT_PLU_CD"));
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
					sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
					sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, mi.getString("BOTTLE_CD"));
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
					sql.setString(++i, mi.getString("BOTTLE_CD"));
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
					sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
					sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, mi.getString("BOTTLE_CD"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, newSkuCd);

				} else {
						
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				sql.close();
				Map keys = new HashMap();
				keys.put("SKU_CD", newSkuCd);
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
			String strSkuName = URLDecoder.decode(String2.nvl(form.getParam("strSkuName")), "UTF-8");
			String strRecpName = URLDecoder.decode(String2.nvl(form.getParam("strRecpName")), "UTF-8");
			String strPumbunType = String2.nvl(form.getParam("strPumbunType"));
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
			String strSkuType = String2.nvl(form.getParam("strSkuType"));
			String strStyleType = String2.nvl(form.getParam("strStyleType"));
			String strBottleCd = String2.nvl(form.getParam("strBottleCd"));
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			
			while (mi.next()) {
				sql.close();
				if (mi.IS_UPDATE()){
					i = 0;
					if( mi.getString("SKU_CD").equals("")){
						
						// 마진율 유효성체크  MARIO OUTLET START 2011-08-10
						// 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
						if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {
							sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));							
							sql.setString(++i, mi.getString("STR_CD"));	
							sql.setString(++i, strPumbunCd);
							sql.setString(++i, mi.getString("SALE_MG_RATE"));	
							
							if(mi.getInt("SALE_S_DT") < mi.getInt("BUY_S_DT")) {
								sql.setString(++i, mi.getString("SALE_S_DT"));
							} else {
								sql.setString(++i, mi.getString("BUY_S_DT"));
							}
							
							Map map1 = selectMap( sql );							
							String mgRateCnt = String2.nvl((String)map1.get("CNT"));
							if( mgRateCnt.equals("0")) {
								throw new Exception("[USER]"+"마진율이 적합하지 않습니다.");
							}
							sql.close();
							
							i = 0;
						}
						// 마진율 유효성체크  MARIO OUTLET END
						
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
						sql.setString(++i, strBottleCd);
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
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, strRecpName);
						sql.setString(++i, strBottleCd);
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

	public int sendskuprcemg(ActionForm form, String userId)
			throws Exception {

		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		int resp    		  = 0;      //프로시저 리턴값
		
		try {
	
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();
			ProcedureResultSet prs = null;
			
			int i = 1;            
			psql.put("DPS.PR_PCSKUPRCPOS_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("strPumbunCd"));     //            
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
            //psql.registerOutParameter(i++, DataTypes.VARCHAR);//6

            prs = updateProcedure(psql);
            
            resp += prs.getInt(4);    

            if (resp < 0) {
                throw new Exception("[USER]"+ prs.getString(5));
            }
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}    
		
}
