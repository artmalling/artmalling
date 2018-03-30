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
 * <p>
 * 단품가격예약등록
 * </p>
 * 
 * @created on 1.0, 2010/04/01
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PCod610DAO extends AbstractDAO {

	/**
	 * 단품가격을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, String userId, String orgFlag)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strQuery   = "";
		String strLoc     = "searchMaster";
		String strSkuType = "";
		int i             = 1;

		try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			strSkuType  = String2.trimToEmpty(form.getParam("strSkuType")); //단품종류

			connect("pot");
			mi.next();
			sql.setString(i++, mi.getString("ADJ_DATE"));
			sql.setString(i++, mi.getString("ADJ_DATE")); // MARIO OUTLET 2011-08-11
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setInt(i++, mi.getInt("INC_RATE"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setInt(i++, mi.getInt("INC_RATE"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setInt(i++, mi.getInt("INC_RATE"));
			sql.setString(i++, mi.getString("INC_FLAG"));
			sql.setInt(i++, mi.getInt("INC_RATE"));
			sql.setString(i++, mi.getString("ADJ_DATE"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, userId);
			sql.setString(i++, orgFlag);
			if("3".equals(strSkuType)) strQuery = svc.getQuery("SEL_SKUMST_CLOTH") + "\n";
			else strQuery = svc.getQuery("SEL_SKUMST") + "\n";

			if (!mi.getString("STR_CD").equals("%")) {
				sql.setString(i++, mi.getString("STR_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_STR_CD") + "\n";
			}

			if (!mi.getString("PUMMOK_CD").equals("%")) {
				sql.setString(i++, mi.getString("PUMMOK_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMMOK_CD") + "\n";
			}

			if (!mi.getString("VEN_CD").equals("")) {
				sql.setString(i++, mi.getString("VEN_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_VEN_CD") + "\n";
			}

			if (!mi.getString("SKU_CD").equals("")
					|| !mi.getString("SKU_NM").equals("")) {
				sql.setString(i++, mi.getString("SKU_CD"));
				sql.setString(i++, mi.getString("SKU_NM"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_LIKE_SKU_CD") + "\n";
			}

			if (!mi.getString("STYLE_CD_A").equals("")
					|| !mi.getString("STYLE_NM_A").equals("")) {
				sql.setString(i++, mi.getString("STYLE_CD_A"));
				sql.setString(i++, mi.getString("STYLE_NM_A"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_CD") + "\n";
			}

			if (!mi.getString("STYLE_CD_B").equals("")
					|| !mi.getString("STYLE_NM_B").equals("")) {
				sql.setString(i++, mi.getString("STYLE_CD_B"));
				sql.setString(i++, mi.getString("STYLE_NM_B"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_CD") + "\n";
			}

			if (!mi.getString("BRAND_CD_A").equals("%")) {
				sql.setString(i++, mi.getString("BRAND_CD_A"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_BRAND_CD") + "\n";
			}

			if (!mi.getString("BRAND_CD_B").equals("%")) {
				sql.setString(i++, mi.getString("BRAND_CD_B"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_BRAND_CD") + "\n";
			}

			if (!mi.getString("SUB_BRD_CD_A").equals("%")) {
				sql.setString(i++, mi.getString("SUB_BRD_CD_A"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_SUB_BRD_CD") + "\n";
			}

			if (!mi.getString("SUB_BRD_CD_B").equals("%")) {
				sql.setString(i++, mi.getString("SUB_BRD_CD_B"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_SUB_BRD_CD") + "\n";
			}

			if (!mi.getString("PLAN_YEAR").equals("%")) {
				sql.setString(i++, mi.getString("PLAN_YEAR"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_PLAN_YEAR") + "\n";
			}

			if (!mi.getString("SEASON_CD").equals("%")) {
				sql.setString(i++, mi.getString("SEASON_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_SEASON_CD") + "\n";
			}

			if (!mi.getString("ITEM_CD").equals("%")) {
				sql.setString(i++, mi.getString("ITEM_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_ITEM_CD") + "\n";
			}

			if (!mi.getString("MNG_CD1").equals("")) {
				sql.setString(i++, mi.getString("MNG_CD1"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD1") + "\n";
			}

			if (!mi.getString("MNG_CD2").equals("")) {
				sql.setString(i++, mi.getString("MNG_CD2"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD2") + "\n";
			}

			if (!mi.getString("MNG_CD3").equals("")) {
				sql.setString(i++, mi.getString("MNG_CD3"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD3") + "\n";
			}

			if (!mi.getString("MNG_CD4").equals("")) {
				sql.setString(i++, mi.getString("MNG_CD4"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD4") + "\n";
			}

			if (!mi.getString("MNG_CD5").equals("")) {
				sql.setString(i++, mi.getString("MNG_CD5"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD5") + "\n";
			}

			if("3".equals(strSkuType)) strQuery += svc.getQuery("SEL_SKUMST_ORDER_TYPE1"); //단품코드가 의류단품일경우 정렬순서
			else strQuery += svc.getQuery("SEL_SKUMST_ORDER_TYPE2"); //단품코드가 규격/신선일경우 정렬순서
			
			sql.put(strQuery);

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(strLoc + "():\n" + e.getMessage());
		}
		return ret;
	}
	
	/**
	 * 단건의 점별단품가격정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSkuPrcInfo(ActionForm form) throws Exception {

		List ret           = null;
		SqlWrapper sql     = null;
		Service svc        = null;
		String strQuery    = "";
		String strLoc      = "searchSkuPrcInfo";
		String strStoreCd  = "";
		String strSkuCd    = "";
		String strPumbunCd = "";
		String strStartDt  = "";
		String strIncFlag  = "";
		String strIncRate  = "";
		String strSkuType  = "";
		int i              = 1;

		try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			strStoreCd  = String2.trimToEmpty(form.getParam("strStoreCd"));  //점코드
			strSkuCd    = String2.trimToEmpty(form.getParam("strSkuCd"));    //단품코드
			strPumbunCd = String2.trimToEmpty(form.getParam("strPumbunCd")); //품번코드
			strStartDt  = String2.trimToEmpty(form.getParam("strStartDt"));  //적용시작일
			strIncFlag  = String2.trimToEmpty(form.getParam("strIncFlag"));  //인상인하구분
			strIncRate  = String2.trimToEmpty(form.getParam("strIncRate"));  //인상인하율
			strSkuType  = String2.trimToEmpty(form.getParam("strSkuType"));  //단품구분

			connect("pot");
			
			sql.setString(i++, strStartDt);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strSkuCd);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncRate);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncRate);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncRate);
			sql.setString(i++, strIncFlag);
			sql.setString(i++, strIncRate);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strSkuCd);
			if("3".equals(strSkuType)) strQuery = svc.getQuery("SEL_SKUMST2_CLOTH") + "\n";
			else strQuery = svc.getQuery("SEL_SKUMST2") + "\n";
			
			sql.put(strQuery);

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(strLoc + "():\n" + e.getMessage());
		}
		return ret;
	}

	/**
	 * 단품가격을 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret        = 0;
		int res        = 0;
		int i          = 0; 
		SqlWrapper sql = null;
		Service svc    = null;

		
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			//String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
			String strPumbunCd_1 = String2.nvl(form.getParam("strPumbunCd_1"));
			String newSkuCd = "";

			while (mi.next()) {
				newSkuCd = "";
				if("T".equals(mi.getString("CHECK_FLAG"))){
					
					// 마진율 유효성체크  MARIO OUTLET START 2011-08-10
					// 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
				   if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {						
						i = 0;

						sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));							
						sql.setString(++i, mi.getString("STR_CD"));	
						sql.setString(++i, strPumbunCd_1);
						sql.setString(++i, mi.getString("NEW_SALE_MG_RATE"));	
						sql.setString(++i, mi.getString("NEW_APP_S_DT"));
						
						
						Map map1 = selectMap( sql );							
						String mgRateCnt = String2.nvl((String)map1.get("CNT"));
						if( mgRateCnt.equals("0")) {
							throw new Exception("[USER]"+"마진율이 적합하지 않습니다.");
						}
						sql.close();
					}
				   
					// 마진율 유효성체크  MARIO OUTLET END
					/*if(!"".equals(mi.getString("ORI_APP_S_DT"))){
						//기존가격의 적용종료일 수정
						i = 0;
						
						sql.put(svc.getQuery("UPD_SKUPRC"));
						sql.setString(++i, Util.addDay(mi.getString("NEW_APP_S_DT"), -1));
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("SKU_CD"));
						sql.setString(++i, mi.getString("ORI_APP_S_DT"));

						res = update(sql);

						if (res != 1) {
							throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
									+ "데이터 수정을 하지 못했습니다.");
						}
						
						sql.close();
					}*/
					

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
					}
				   
				   i = 0;
					sql.put(svc.getQuery("SEL_SKUMST_SKU_CD_CNT"));							
					sql.setString(++i, newSkuCd);
					Map map = selectMap( sql );							
					String skuCdCnt = String2.nvl((String)map.get("CNT"));
					if( !skuCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 단품코드 입니다.");
					}
					sql.close();
				   
				   
				   i = 0;
					
					sql.put(svc.getQuery("INS_SKUMST"));
					
					sql.setString(++i, newSkuCd);
					sql.setString(++i, strPumbunCd_1);
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SKU_CD"));
					
					res = update(sql);

					if (res != 1) {
						throw new Exception("[USER]"+ "SKUMST 데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					ret += res;
   
				    sql.close();
				    
				    
				    i = 0;
					
					sql.put(svc.getQuery("INS_STRSKUMST"));
					
					sql.setString(++i, newSkuCd);
					sql.setString(++i, strPumbunCd_1);
					sql.setString(++i, strPumbunCd_1);
					sql.setInt(++i, mi.getInt("NEW_SAL_COST_PRC"));
					sql.setInt(++i, mi.getInt("NEW_SALE_PRC"));
					sql.setDouble(++i, mi.getDouble("NEW_SALE_MG_RATE"));
					sql.setString(++i, mi.getString("NEW_APP_S_DT"));
					sql.setString(++i, mi.getString("NEW_APP_S_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SKU_CD"));
					
					res = update(sql);

					if (res != 1) {
						throw new Exception("[USER]"+ res + " " + i + "STRSKUMST 데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					ret += res;
   
				    sql.close();
				    
				    i = 0;
					
					sql.put(svc.getQuery("INS_BARCDMST"));
					
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, newSkuCd);
					sql.setString(++i, strPumbunCd_1);
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
					
					res = update(sql);

					if (res != 1) {
						throw new Exception("[USER]"+ "BARCDMST 데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					ret += res;
   
				    sql.close();
				    
				    i = 0;
					
					sql.put(svc.getQuery("INS_STRSKUPRCMST"));
					
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("NEW_APP_S_DT"));
					sql.setInt(++i, mi.getInt("NEW_SAL_COST_PRC"));
					sql.setInt(++i, mi.getInt("NEW_SALE_PRC"));
					sql.setDouble(++i, mi.getDouble("NEW_SALE_MG_RATE"));
					sql.setInt(++i, mi.getInt("NEW_SAL_COST_PRC"));
					sql.setInt(++i, mi.getInt("NEW_SALE_PRC"));
					sql.setDouble(++i, mi.getDouble("NEW_SALE_MG_RATE"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
					
					res = update(sql);

					if (res != 1) {
						throw new Exception("[USER]"+ "STRSKUPRCMST 데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					ret += res;
   
				    sql.close();
				    
				    
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

}
