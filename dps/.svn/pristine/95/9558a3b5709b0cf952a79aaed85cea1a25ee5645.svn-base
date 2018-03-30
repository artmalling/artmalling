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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
 * <p>품번 관리</p>
 * 
 * @created  on 1.0, 2010/02/08
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod201DAO extends AbstractDAO {

	/**
	 * 품번을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		mi.next();
		strQuery = svc.getQuery("SEL_PBNMST") + "\n";

		if( !mi.getString("BIZ_TYPE").equals("%")){
			sql.setString(i++, mi.getString("BIZ_TYPE"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_BIZ_TYPE") + "\n";
		}
		if( !mi.getString("SKU_FLAG").equals("%")){
			sql.setString(i++, mi.getString("SKU_FLAG"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_SKU_FLAG") + "\n";
		}
		if( !mi.getString("PUMBUN_TYPE").equals("%")){
			sql.setString(i++, mi.getString("PUMBUN_TYPE"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_PUMBUN_TYPE") + "\n";
		}
		if( !mi.getString("PUMBUN_FLAG").equals("%")){
			sql.setString(i++, mi.getString("PUMBUN_FLAG"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_PUMBUN_FLAG") + "\n";
		}
		if( !mi.getString("SKU_TYPE").equals("%")){
			sql.setString(i++, mi.getString("SKU_TYPE"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_SKU_TYPE") + "\n";
		}
		if( !mi.getString("USE_YN").equals("%")){
			sql.setString(i++, mi.getString("USE_YN"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_USE_YN") + "\n";
		}
		if( !mi.getString("REC_PUMBUN").equals("")){
			sql.setString(i++, mi.getString("REC_PUMBUN"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_REP_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("VEN_CD").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_VEN_CD") + "\n";
		}
		if( !mi.getString("VEN_NAME").equals("")){
			sql.setString(i++, mi.getString("VEN_NAME"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_VEN_NAME") + "\n";
		}
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_NAME").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_NAME"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_PUMBUN_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_PBNMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 품번담당품목을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnpmk(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_PBNPMK") + "\n";
		sql.setString(i++, strPumbunCd);
		
		strQuery += svc.getQuery("SEL_PBNPMK_ORDER");
		
		sql.put(strQuery);

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
	public List searchStrpbn(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_STRPBN") + "\n";
		sql.setString(i++, strPumbunCd);
		
		strQuery += svc.getQuery("SEL_STRPBN_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	/**
	 * 협력사담당자를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnvenemp(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		/* String strVenCd = String2.nvl(form.getParam("strVenCd")); */
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_PBNVENEMP") + "\n";
		sql.setString(i++, strPumbunCd);
		/* sql.setString(i++, strVenCd); */
		
		
		strQuery += svc.getQuery("SEL_PBNVENEMP_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	

	/**
	 *  <p>
	 *  품번 마스터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int savePbnmst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String newPumbunCd = "";
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			boolean pbnUseN = false;
			while (mi.next()) {
				List listStrPbn = new ArrayList();
				sql.close();
				if ( mi.IS_INSERT()) {					
					i = 0;			
					sql.put(svc.getQuery("SEL_NEW_PUMBUN_CD"));
					sql.setString(++i, mi.getString("BIZ_TYPE"));
					sql.setString(++i, mi.getString("TAX_FLAG"));				

					Map map = selectMap( sql );
					newPumbunCd = String2.nvl((String)map.get("NEW_PUMBUN_CD"));
					if( newPumbunCd.equals("")) {
						throw new Exception("[USER]"+"품번 코드를 생성 할 수 없습니다.");
					}
					
					/* 하나의 협력사에 하나의 공병 품번만 존재해야 함  2010.05.30 */
					if( mi.getString("PUMBUN_TYPE").equals("2")){
						i = 0;				
						sql.close();
						sql.put(svc.getQuery("SEL_CHECK_BOTTLE_CNT"));
						sql.setString(++i, mi.getString("VEN_CD"));	

						map = selectMap( sql );
						String cnt = String2.nvl((String)map.get("CNT"));
						if( !cnt.equals("0")) {
							throw new Exception("[USER]"+"["+mi.getString("VEN_CD")+"] 협력사에 이미 공병 품번이 등록 되어 있습니다.");
						}
					}
					i = 0;				
					sql.close();
					sql.put(svc.getQuery("INS_PBNMST"));					
					sql.setString(++i, newPumbunCd);					
					sql.setString(++i, mi.getString("PUMBUN_NAME"));					
					sql.setString(++i, mi.getString("RECP_NAME"));					
					sql.setString(++i, mi.getString("VEN_CD"));					
					sql.setString(++i, mi.getString("BIZ_TYPE"));					
					sql.setString(++i, mi.getString("BIZ_FLAG"));				
					sql.setString(++i, mi.getString("REP_PUMBUN_CD").equals("")?newPumbunCd:mi.getString("REP_PUMBUN_CD"));					
					sql.setString(++i, mi.getString("TAX_FLAG"));					
					sql.setString(++i, mi.getString("PUMBUN_FLAG"));					
					sql.setString(++i, mi.getString("PUMBUN_TYPE"));					
					sql.setString(++i, mi.getString("SKU_FLAG"));					
					sql.setString(++i, mi.getString("SKU_TYPE"));					
					sql.setString(++i, mi.getString("STYLE_TYPE"));					
					sql.setString(++i, mi.getString("ITG_ORD_FLAG"));					
					sql.setString(++i, mi.getString("BRAND_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));					
					sql.setString(++i, mi.getString("APP_E_DT"));					
					sql.setString(++i, mi.getString("USE_YN"));					
					sql.setString(++i, strID);					
					sql.setString(++i, strID);				
				} else if (mi.IS_UPDATE()){
					
					// MARIO OUTLET 2011.09.14
					if( mi.getString("USE_YN").equals("N")){

						sql.close();
						i = 0;
						sql.put(svc.getQuery("SEL_STRPBN_USED"));
						sql.setString(++i, mi.getString("PUMBUN_CD"));

						List list = select2List( sql );

						if( list.size() > 0 ) {
							throw new Exception("[USER]" + "점별 품번관리에서 사용중인 품번입니다."
									+ "점별 품번 사용여부를 NO로 변경 저장한 후 품번의 사용여부를 변경하십시요.");
						}
					}
					
					
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("UPD_PBNMST"));
					sql.setString(++i, mi.getString("PUMBUN_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("REP_PUMBUN_CD"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("PUMBUN_FLAG"));
					sql.setString(++i, mi.getString("ITG_ORD_FLAG"));
					sql.setString(++i, mi.getString("BRAND_CD"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					if(!mi.getString("PUMBUN_NAME").equals(mi.getString("ORG_PUMBUN_NAME"))){
						listStrPbn.add(" PUMBUN_NAME = '"+mi.getString("PUMBUN_NAME")+"' ");
					}
					if(!mi.getString("RECP_NAME").equals(mi.getString("ORG_RECP_NAME"))){
						listStrPbn.add(" RECP_NAME   = '"+mi.getString("RECP_NAME")+"' ");
					}
					if( mi.getInt("APP_E_DT") < mi.getInt("ORG_APP_E_DT")){
						if( mi.getInt("APP_E_DT") < mi.getInt("APP_S_DT"))
							listStrPbn.add(" APP_S_DT   = '"+mi.getString("APP_E_DT")+"' ");
						listStrPbn.add(" APP_E_DT   = '"+mi.getString("APP_E_DT")+"' ");
					}
					pbnUseN = mi.getString("USE_YN").equals("N");

				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}else {
					String pumbunCd =  mi.getString("PUMBUN_CD").equals("")? newPumbunCd :  mi.getString("PUMBUN_CD");

					if( listStrPbn.size() > 0 ){

						sql.close();
						i = 0;				
						//점별품번
						String sqlQuery = "UPDATE DPS.PC_STRPBN " + "\n" + "   SET ";
						for( int k = 0 ; k < listStrPbn.size() ; k++){
							if( k != 0)
								sqlQuery += "     , ";
							sqlQuery += listStrPbn.get(k).toString() + "\n"  ;
						}
						sqlQuery  += "     , MOD_DATE       = SYSDATE"+ "\n"  ;
						sqlQuery  += "     , MOD_ID         = ?"+ "\n"  ;
						sqlQuery  += " WHERE PUMBUN_CD      = ?"  ;
						sql.put(sqlQuery);
						sql.setString(++i, strID);
						sql.setString(++i, pumbunCd);
						update(sql);
						listStrPbn = null;
						
						if( !pbnUseN){

							sql.close();
							sql.put(svc.getQuery("SEL_STRPBN_USE_YN"));
							sql.setString(1,  pumbunCd);

							List list = select2List( sql );

							if( list.size() > 0 ) {
								
								for( int j = 0; j < list.size(); j++){
									Map keys = new HashMap();
									keys.put("STR_CD", ((List)list.get(j)).get(0));
									keys.put("PUMBUN_CD", ((List)list.get(j)).get(1));
									sql.close();
									update(Util.getHistorySQL("PC_STRPBN", "PC_STRPBNHIST", "DPS", keys, "STR_CD,PUMBUN_CD", strID));
								}
								
							}
						}
					}
					
					if( pbnUseN ){
						sql.close();
						i = 0;				
						//점별품번
						sql.put(svc.getQuery("UPD_STRPBN_USE_YN"));
						sql.setString(++i, "N");
						sql.setString(++i, strID);
						sql.setString(++i, pumbunCd);

						update(sql);

						sql.close();
						sql.put(svc.getQuery("SEL_STRPBN_USE_YN"));
						sql.setString(1,  pumbunCd);

						List list = select2List( sql );

						if( list.size() > 0 ) {
							
							for( int j = 0; j < list.size(); j++){
								Map keys = new HashMap();
								keys.put("STR_CD", ((List)list.get(j)).get(0));
								keys.put("PUMBUN_CD", ((List)list.get(j)).get(1));
								sql.close();
								update(Util.getHistorySQL("PC_STRPBN", "PC_STRPBNHIST", "DPS", keys, "STR_CD,PUMBUN_CD", strID));
							}
							
						}

						sql.close();
						i = 0;				
						//품번별품목
						sql.put(svc.getQuery("UPD_PBNPMK_USE_YN"));
						sql.setString(++i, "N");
						sql.setString(++i, strID);
						sql.setString(++i, pumbunCd);

						update(sql);						

						sql.close();
						i = 0;		
						//품번별협력사담당자
						sql.put(svc.getQuery("UPD_PBNVENEMP_USE_YN"));
						sql.setString(++i, "N");
						sql.setString(++i, strID);
						sql.setString(++i, pumbunCd);

						update(sql);
						
					}

					//품번정보
					Map keys = new HashMap();
					keys.put("PUMBUN_CD", pumbunCd);
					sql.close();
					update(Util.getHistorySQL("PC_PBNMST", "PC_PBNHIST", "DPS", keys, "PUMBUN_CD", strID));

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
	 *  품번별 품목 을 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int savePbnpmk(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String pumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					i = 0;						
					sql.put(svc.getQuery("SEL_PBNPMK_CNT"));					
					sql.setString(++i, pumbunCd);					
					sql.setString(++i, mi.getString("PUMMOK_CD"));		
					Map map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 데이터 입니다.");
					}
					sql.close();
					
					i = 0;			
					sql.put(svc.getQuery("INS_PBNPMK"));							
					sql.setString(++i, pumbunCd);					
					sql.setString(++i, mi.getString("PUMMOK_CD"));					
					sql.setString(++i, mi.getString("TAG_FLAG"));					
					sql.setString(++i, mi.getString("TAG_PRT_OWN_FLAG"));					
					sql.setString(++i, mi.getString("USE_YN"));				
					sql.setString(++i, strID);					
					sql.setString(++i, strID);				
				} else if (mi.IS_UPDATE()){

					i = 0;							
					sql.put(svc.getQuery("UPD_PBNPMK"));
					sql.setString(++i, mi.getString("TAG_FLAG"));
					sql.setString(++i, mi.getString("TAG_PRT_OWN_FLAG"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, pumbunCd);
					sql.setString(++i, mi.getString("PUMMOK_CD"));
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
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		String pumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strPumbunName = URLDecoder.decode( String2.nvl(form.getParam("strPumbunName")), "UTF-8");
		String strRecpName = URLDecoder.decode( String2.nvl(form.getParam("strRecpName")), "UTF-8");
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		String strBizType = String2.nvl(form.getParam("strBizType"));
		String strBizFlag = String2.nvl(form.getParam("strBizFlag"));
		String strPumbunType = String2.nvl(form.getParam("strPumbunType"));
		String strSkuFlag = String2.nvl(form.getParam("strSkuFlag"));
		String strSkuType = String2.nvl(form.getParam("strSkuType"));
		String strStyleType = String2.nvl(form.getParam("strStyleType"));
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {		
					i = 0;						
					sql.put(svc.getQuery("SEL_STRPBN_CNT"));					
					sql.setString(++i, pumbunCd);					
					sql.setString(++i, mi.getString("STR_CD"));		
					map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 데이터 입니다.");
					}
					if( !mi.getString("BUY_ORG_CD").equals("")){
						sql.close();	
						i = 0;									
						sql.put(svc.getQuery("SEL_CHECK_BUY_ORG_CD_KOSTL"));					
						sql.setString(++i, strVenCd);					
						sql.setString(++i, mi.getString("BUY_ORG_CD"));		
						map = selectMap( sql );							
						String buyOrgCheckflag = String2.nvl((String)map.get("FLAG"));
						
						// MARIO OUTLET START
						/*
						if( !buyOrgCheckflag.equals("2")) {
							if(buyOrgCheckflag.equals("1"))
								throw new Exception("[USER]"+"매입조직에 코스트센터 코드가 등록 되어있지 않습니다.");
							else
								throw new Exception("[USER]"+"매입조직의 코스트센터 코드가 동일 협력사의 다른 품번의 매입조직의 코스트센터 코드와 다릅니다.");
						}
						*/
						// MARIO OUTLET END
						
						
					}

					if( !mi.getString("SALE_ORG_CD").equals("")){
						sql.close();	
						i = 0;									
						sql.put(svc.getQuery("SEL_CHECK_SALE_ORG_CD_KOSTL"));					
						sql.setString(++i, strVenCd);					
						sql.setString(++i, mi.getString("SALE_ORG_CD"));		
						map = selectMap( sql );							
						String saleOrgCheckflag = String2.nvl((String)map.get("FLAG"));
						
						// MARIO OUTLET START
						/*
						if( !saleOrgCheckflag.equals("2")) {
							if(saleOrgCheckflag.equals("1"))
								throw new Exception("[USER]"+"판매조직에 코스트센터 코드가 등록 되어있지 않습니다.");
							else
								throw new Exception("[USER]"+"판매조직의 코스트센터 코드가 동일 협력사의 다른 품번의 판매조직의 코스트센터 코드와 다릅니다.");
						}
						*/
						// MARIO OUTLET END
						
					}
					sql.close();	
					i = 0;									
					sql.put(svc.getQuery("INS_STRPBN"));								
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, pumbunCd);				
					sql.setString(++i, strPumbunName);
					sql.setString(++i, strRecpName);
					sql.setString(++i, strVenCd);
					sql.setString(++i, strBizType);
					sql.setString(++i, strBizFlag);
					sql.setString(++i, strPumbunType);
					sql.setString(++i, strSkuFlag);
					sql.setString(++i, strSkuType);
					sql.setString(++i, strStyleType);
					sql.setString(++i, mi.getString("STR_CD"));		
					sql.setString(++i, strVenCd);	               
					sql.setString(++i, mi.getString("CHAR_BUYER_CD"));
					sql.setString(++i, mi.getString("BUY_ORG_CD"));
					sql.setString(++i, mi.getString("CHAR_SM_CD"));
					sql.setString(++i, mi.getString("SALE_ORG_CD"));
					sql.setString(++i, mi.getString("SALE_BUY_FLAG"));
					sql.setString(++i, mi.getString("CHK_YN"));
					sql.setString(++i, "3"); // mi.getString("COST_CAL_WAY")); //기본값 "3" 입력요청 2010.06.22
					sql.setString(++i, mi.getString("LOW_MG_RATE"));
					//sql.setString(++i, mi.getString("SBNS_CAL_RATE"));
					sql.setString(++i, mi.getString("HALL_CD"));            // 20120507 * DHL * 추가 
					sql.setString(++i, mi.getString("FLOR_CD"));
					sql.setString(++i, mi.getString("AREA_SIZE"));
					sql.setString(++i, mi.getString("ADV_ORD_YN"));
					sql.setString(++i, mi.getString("EVALU_YN"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, mi.getString("EDI_YN"));
					sql.setString(++i, mi.getString("RENTB_MGAPP_FLAG"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SLIDING_FLAG")); // MARIO OUTLET
					sql.setString(++i, mi.getString("VEN_MNG_FLAG"));      // 20120507 * DHL * 추가
					sql.setString(++i, mi.getString("MPOS_USE"));
					sql.setString(++i, mi.getString("E_MAIL"));
					
				} else if (mi.IS_UPDATE()){

					// MARIO OUTLET 2011.09.14
					if (mi.getString("USE_YN").equals("Y")) {
						sql.close();
						i = 0;
						sql.put(svc.getQuery("SEL_PBNMST_NOTUSED"));
						sql.setString(++i, pumbunCd);

						List list = select2List( sql );

						if( list.size() > 0 ) {
							throw new Exception("[USER]" + "품번관리에서 사용여부 NO인 품번입니다."
									+ "품번의 사용여부를 YES로 변경 저장한 후 점별 품번의 사용여부를 변경하십시요.");
						}
					}
					
					
					if( !mi.getString("BUY_ORG_CD").equals("")){
						sql.close();	
						i = 0;									
						sql.put(svc.getQuery("SEL_CHECK_BUY_ORG_CD_KOSTL"));					
						sql.setString(++i, strVenCd);					
						sql.setString(++i, mi.getString("BUY_ORG_CD"));		
						map = selectMap( sql );							
						String buyOrgCheckflag = String2.nvl((String)map.get("FLAG"));
						
						// MARIO OUTLET START
						/*
						if( !buyOrgCheckflag.equals("2")) {
							if(buyOrgCheckflag.equals("1"))
								throw new Exception("[USER]"+"매입조직에 코스트센터 코드가 등록 되어있지 않습니다.");
							else
								throw new Exception("[USER]"+"매입조직의 코스트센터 코드가 동일 협력사의 다른 품번의 매입조직의 코스트센터 코드와 다릅니다.");
						}
						*/
						// MARIO OUTLET END
						
					}

					if( !mi.getString("SALE_ORG_CD").equals("")){
						sql.close();	
						i = 0;									
						sql.put(svc.getQuery("SEL_CHECK_SALE_ORG_CD_KOSTL"));					
						sql.setString(++i, strVenCd);					
						sql.setString(++i, mi.getString("SALE_ORG_CD"));		
						map = selectMap( sql );							
						String saleOrgCheckflag = String2.nvl((String)map.get("FLAG"));
						// MARIO OUTLET START
						/*
						if( !saleOrgCheckflag.equals("2")) {
							if(saleOrgCheckflag.equals("1"))
								throw new Exception("[USER]"+"판매조직에 코스트센터 코드가 등록 되어있지 않습니다.");
							else
								throw new Exception("[USER]"+"판매조직의 코스트센터 코드가 동일 협력사의 다른 품번의 판매조직의 코스트센터 코드와 다릅니다.");
						}
						*/
						// MARIO OUTLET END
					}
					sql.close();	
					i = 0;							
					sql.put(svc.getQuery("UPD_STRPBN"));
					sql.setString(++i, mi.getString("BUY_ORG_CD"));
					sql.setString(++i, mi.getString("CHAR_BUYER_CD"));
					sql.setString(++i, mi.getString("SALE_ORG_CD"));
					sql.setString(++i, mi.getString("CHAR_SM_CD"));
					sql.setString(++i, mi.getString("SALE_BUY_FLAG"));
					sql.setString(++i, mi.getString("CHK_YN"));
					sql.setString(++i, "3"); // mi.getString("COST_CAL_WAY")); //기본값 "3" 입력요청 2010.06.22
					sql.setString(++i, mi.getString("LOW_MG_RATE"));
					//sql.setString(++i, mi.getString("SBNS_CAL_RATE"));
					sql.setString(++i, mi.getString("HALL_CD"));           // 20120507 * DHL * 추가
					sql.setString(++i, mi.getString("FLOR_CD"));
					sql.setString(++i, mi.getString("AREA_SIZE"));
					sql.setString(++i, mi.getString("ADV_ORD_YN"));
					sql.setString(++i, mi.getString("EVALU_YN"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					sql.setString(++i, mi.getString("USE_YN"));				
					sql.setString(++i, mi.getString("EDI_YN"));		
					sql.setString(++i, mi.getString("RENTB_MGAPP_FLAG"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SLIDING_FLAG")); //MARIO OUTLET
					sql.setString(++i, mi.getString("VEN_MNG_FLAG"));      // 20120507 * DHL * 추가
					sql.setString(++i, mi.getString("MPOS_USE"));
					sql.setString(++i, mi.getString("E_MAIL"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, pumbunCd);
				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}else {

					//점별품번정보
					Map keys = new HashMap();
					keys.put("STR_CD", mi.getString("STR_CD"));
					keys.put("PUMBUN_CD", pumbunCd);
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

	/**
	 *  <p>
	 *  품번별 협력사담당자를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int savePbnvenemp(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String pumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					i = 0;			
					sql.put(svc.getQuery("INS_PBNVENEMP"));							
					sql.setString(++i, pumbunCd);									
					sql.setString(++i, pumbunCd);			// SEQ_NO
					sql.setString(++i, mi.getString("VEN_TASK_FLAG"));					
					sql.setString(++i, mi.getString("CHAR_NAME"));					
					sql.setString(++i, mi.getString("PHONE1_NO"));				
					sql.setString(++i, mi.getString("PHONE2_NO"));					
					sql.setString(++i, mi.getString("PHONE3_NO"));					
					sql.setString(++i, mi.getString("HP1_NO"));					
					sql.setString(++i, mi.getString("HP2_NO"));					
					sql.setString(++i, mi.getString("HP3_NO"));					
					sql.setString(++i, mi.getString("EMAIL"));					
					sql.setString(++i, mi.getString("SMEDI_ID"));						
					sql.setString(++i, mi.getString("USE_YN"));				
					sql.setString(++i, strID);					
					sql.setString(++i, strID);				
				} else if (mi.IS_UPDATE()){

					i = 0;							
					sql.put(svc.getQuery("UPD_PBNVENEMP"));
					sql.setString(++i, mi.getString("VEN_TASK_FLAG"));					
					sql.setString(++i, mi.getString("CHAR_NAME"));					
					sql.setString(++i, mi.getString("PHONE1_NO"));				
					sql.setString(++i, mi.getString("PHONE2_NO"));					
					sql.setString(++i, mi.getString("PHONE3_NO"));					
					sql.setString(++i, mi.getString("HP1_NO"));					
					sql.setString(++i, mi.getString("HP2_NO"));					
					sql.setString(++i, mi.getString("HP3_NO"));					
					sql.setString(++i, mi.getString("EMAIL"));					
					sql.setString(++i, mi.getString("SMEDI_ID"));						
					sql.setString(++i, mi.getString("USE_YN"));		
					sql.setString(++i, strID);
					sql.setString(++i, pumbunCd);
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
	

	public int sendpbnemg(ActionForm form, String userId)
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
			psql.put("DPS.PR_PCPBNPOS_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("strPumbunCd"));  // 품번           
            
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


	public int sendpmkemg(ActionForm form, String userId)
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
			psql.put("DPS.PR_PCPBNPMKPOS_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("strPumbunCd"));  // 품번           
            
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
