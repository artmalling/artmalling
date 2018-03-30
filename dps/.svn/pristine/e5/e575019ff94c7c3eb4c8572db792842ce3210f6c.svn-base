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
 * <p>조직/바이어(SM)관리</p>
 * 
 * @created  on 1.0, 2010/02/08
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod002DAO extends AbstractDAO {

	
	private String newBuyerCd = "";
	private boolean orgUseN = false;
	private boolean buyerUseN = false;
	/**
	 * 조직 마스터 트리을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTreeMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));
		String strUseYn = String2.nvl(form.getParam("strUseYn"));
		String strOrgCd = String2.nvl(form.getParam("strOrgCd"));
		String strOrgNm = URLDecoder.decode(String2.nvl(form.getParam("strOrgNm")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_TREE_ORGMST") + "\n";
		strQuery += svc.getQuery("SEL_TREE_ORGMST_UP_S") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strOrgFlag.equals("%")){
			sql.setString(i++, strOrgFlag);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_ORG_FLAG") + "\n";
		}
		if( !strUseYn.equals("%")){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_USE_YN") + "\n";
		}
		if( !strOrgCd.equals("")){
			sql.setString(i++, strOrgCd);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_ORG_CD") + "\n";
		}
		if( !strOrgNm.equals("")){
			sql.setString(i++, strOrgNm);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_ORG_NAME") + "\n";
		}
		strQuery += svc.getQuery("SEL_TREE_ORGMST_UP_E") + "\n";

		strQuery += svc.getQuery("SEL_TREE_ORGMST_DOWN_S") + "\n";
		sql.setString(i++, strStrCd);

		if( !strOrgFlag.equals("%")){
			sql.setString(i++, strOrgFlag);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_ORG_FLAG") + "\n";
		}
		if( !strUseYn.equals("%")){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_USE_YN") + "\n";
		}
		if( !strOrgCd.equals("")){
			sql.setString(i++, strOrgCd);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_ORG_CD") + "\n";
		}
		if( !strOrgNm.equals("")){
			sql.setString(i++, strOrgNm);
			strQuery += svc.getQuery("SEL_TREE_ORGMST_WHERE_ORG_NAME") + "\n";
		}

		strQuery += svc.getQuery("SEL_TREE_ORGMST_DOWN_E") + "\n";
		
		strQuery += svc.getQuery("SEL_TREE_ORGMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 바이어 정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBuyerMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strOrgCd = String2.nvl(form.getParam("strOrgCd"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));
		String serchOrgCd = "";
		
		if(strOrgCd.length() == 10 ){
			serchOrgCd = strOrgCd.substring(0, 2);
			if( !strOrgCd.substring(2, 4).equals("00")){
				serchOrgCd += strOrgCd.substring(2, 4);
				if( !strOrgCd.substring(4, 6).equals("00") ){
					serchOrgCd += strOrgCd.substring(4, 6);
					if( !strOrgCd.substring(6, 8).equals("00") ){
						serchOrgCd += strOrgCd.substring(6, 8) + "00";
					}
				}
			}
		}
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_BUYERMST") + "\n";
		if( !serchOrgCd.equals("") && serchOrgCd.length() < 10){
			strQuery += svc.getQuery("SEL_BUYERMST_WHERE_LIKE_PC_ORG_CD") + "\n";
			sql.setString(i++, serchOrgCd);	
		} else {
			strQuery += svc.getQuery("SEL_BUYERMST_WHERE_PC_ORG_CD") + "\n";
			sql.setString(i++, serchOrgCd);				
		}
		
		if( !strOrgFlag.equals("") ) {
			strQuery += svc.getQuery("SEL_BUYERMST_WHERE_ORG_FLAG") + "\n";
			sql.setString(i++, strOrgFlag);	
			
		}
		
		strQuery += svc.getQuery("SEL_BUYERMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 바이어 조직정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBuyerDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strBuyerCd = String2.nvl(form.getParam("strBuyerCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_BUYERORG") + "\n";
		sql.setString(i++, strBuyerCd);			
		strQuery += svc.getQuery("SEL_BUYERORG_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	/**
	 * 조직정보,
	 * 바이어 보,
	 * 바이어 조직정보
	 * 
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
			 
			for(int idx = 0 ; idx < 3 ; idx++){
				// 조직정보
				if( idx == 0){
					ret += saveOrgmst(form, mi[idx], strID);
				//바이어(SM) 정보
				}else if ( idx == 1){
					ret += saveBuyermst(form, mi[idx], strID);
					
				//바이어(SM) 담당자 정보
				}else if ( idx == 2){
					ret += saveBuyerorg(form, mi[idx], strID);
								
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
	 *  조직 마스터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveOrgmst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";
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
				// 조직정보
				if ( mi.IS_INSERT()) {
					
					sql.put(svc.getQuery("SEL_ORGMST_ORGCD_CNT"));							
					sql.setString(1, mi.getString("ORG_CD"));								
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 조직코드 입니다.");
					}
					sql.close();
					i = 0;							
					String bfOrgCd = mi.getString("BF_ORG_CD");
					
					sql.put(svc.getQuery("INS_ORGMST"));
					sql.setString(++i, mi.getString("ORG_CD"));
					sql.setString(++i, mi.getString("ORG_NAME"));
					sql.setString(++i, mi.getString("ORG_SHORT_NAME"));
					sql.setString(++i, mi.getString("ORG_FLAG"));
					sql.setString(++i, mi.getString("ORG_LEVEL"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("DEPT_CD"));
					sql.setString(++i, mi.getString("TEAM_CD"));
					sql.setString(++i, mi.getString("PC_CD"));
					sql.setString(++i, mi.getString("CORNER_CD"));
					sql.setString(++i, mi.getString("P_ORG_CD"));
					sql.setString(++i, mi.getString("ORG_CD"));
					sql.setString(++i, mi.getString("SAP_ORG_CD"));
					sql.setString(++i, !bfOrgCd.equals("")?bfOrgCd:mi.getString("ORG_CD"));
					sql.setString(++i, mi.getString("MNG_ORG_YN"));
					//sql.setString(++i, mi.getString("FLOR_CD"));
					sql.setString(++i, mi.getString("EMP_CNT"));
					sql.setString(++i, mi.getString("AREA_SIZE"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SORT_ORDER"));
					sql.setString(++i, mi.getString("BUDGET_YN"));
					sql.setString(++i, mi.getString("KOSTL_CD"));
					
					
				} else if (mi.IS_UPDATE()){

					i = 0;							
					String bfOrgCd = mi.getString("BF_ORG_CD");
					sql.put(svc.getQuery("UPD_ORGMST"));
					sql.setString(++i, mi.getString("ORG_NAME"));
					sql.setString(++i, mi.getString("ORG_SHORT_NAME"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("DEPT_CD"));
					sql.setString(++i, mi.getString("TEAM_CD"));
					sql.setString(++i, mi.getString("PC_CD"));
					sql.setString(++i, mi.getString("CORNER_CD"));
					sql.setString(++i, mi.getString("P_ORG_CD"));
					sql.setString(++i, mi.getString("SAP_ORG_CD"));
					sql.setString(++i, !bfOrgCd.equals("")?bfOrgCd:mi.getString("ORG_CD"));
					sql.setString(++i, mi.getString("MNG_ORG_YN"));
					//sql.setString(++i, mi.getString("FLOR_CD"));
					sql.setString(++i, mi.getString("EMP_CNT"));
					sql.setString(++i, mi.getString("AREA_SIZE"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("SORT_ORDER"));
					sql.setString(++i, mi.getString("BUDGET_YN"));
					sql.setString(++i, mi.getString("KOSTL_CD"));
					
					sql.setString(++i, mi.getString("ORG_CD"));
					
					orgUseN = mi.getString("USE_YN").equals("N");

				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}else {

					if( orgUseN ){
						sql.close();
						i = 0;				
						sql.put(svc.getQuery("UPD_ORGMST_USE_YN"));
						sql.setString(++i, mi.getString("USE_YN"));
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("ORG_CD"));

						update(sql);

						sql.close();
						sql.put(svc.getQuery("SEL_ORGMST_USE_YN"));
						sql.setString(1,  mi.getString("ORG_CD"));

						List list = select2List( sql );

						if( list.size() > 0 ) {
							
							for( int j = 0; j < list.size(); j++){

								Map keys = new HashMap();
								keys.put("ORG_CD", ((List)list.get(j)).get(0));
								sql.close();
								update(Util.getHistorySQL("PC_ORGMST", "PC_ORGHIST", "DPS", keys, "ORG_CD", strID));
							}
							
						}

						sql.close();
						i = 0;				
						sql.put(svc.getQuery("UPD_BUYERMST_USE_YN"));
						sql.setString(++i, "N");
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("ORG_CD"));

						update(sql);						

						sql.close();
						i = 0;				
						sql.put(svc.getQuery("UPD_BUYERORG_USE_YN"));
						sql.setString(++i, "N");
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("ORG_CD"));

						update(sql);
						
						sql.close();
						sql.put(svc.getQuery("SEL_BUYERORG_USE_YN"));							
						sql.setString(1, mi.getString("ORG_CD"));	
						list = select2List( sql );
						
						for( int j = 0; j < list.size(); j++){
							Map keys = new HashMap();
							keys.put("BUYER_CD", ((List)list.get(j)).get(0));
							keys.put("APP_S_DT", ((List)list.get(j)).get(1));
							sql.close();
							update(Util.getHistorySQL("PC_BUYERORG", "PC_BUYERORGHIST", "DPS", keys, "BUYER_CD", strID));
						}
						
					} else {

						//조직정보
						Map keys = new HashMap();
						keys.put("ORG_CD", mi.getString("ORG_CD"));
						sql.close();
						update(Util.getHistorySQL("PC_ORGMST", "PC_ORGHIST", "DPS", keys, "ORG_CD", strID));
					}

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
	 * 바이어(SM) 마스터 저장
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveBuyermst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
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

			while (mi.next()) {
				sql.close();
				// 조직정보
				if ( mi.IS_INSERT()) {
					
					sql.put(svc.getQuery("SEL_BUYERMST_NEW_CD"));							
					sql.setString(1, mi.getString("STR_CD"));							
					sql.setString(2, mi.getString("TEAM_CD"));							
					sql.setString(3, mi.getString("STR_CD"));							
					sql.setString(4, mi.getString("TEAM_CD"));
					
					Map map = selectMap( sql );
					newBuyerCd = String2.nvl((String)map.get("NEW_BUYER_CD"));
					if( newBuyerCd.equals("")) {
						throw new Exception("[USER]"+"바이어 코드를 생성 할 수 없습니다.");
					}
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("INS_BUYERMST"));
					sql.setString(++i, newBuyerCd);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("TEAM_CD"));
					sql.setString(++i, mi.getString("BUYER_NAME"));
					sql.setString(++i, mi.getString("PC_ORG_CD"));
					sql.setString(++i, mi.getString("ORG_FLAG"));
					sql.setString(++i, mi.getString("MAIN_FLAG"));
					sql.setString(++i, mi.getString("BUYER_FLAG"));
					sql.setString(++i, orgUseN?"N":mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					i = 0;							
					sql.put(svc.getQuery("UPD_BUYERMST"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("TEAM_CD"));
					sql.setString(++i, mi.getString("BUYER_NAME"));
					sql.setString(++i, mi.getString("PC_ORG_CD"));
					sql.setString(++i, mi.getString("ORG_FLAG"));
					sql.setString(++i, mi.getString("MAIN_FLAG"));
					sql.setString(++i, mi.getString("BUYER_FLAG"));
					sql.setString(++i, orgUseN?"N":mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("BUYER_CD"));
					
					buyerUseN = mi.getString("USE_YN").equals("N");
					
				} else {
				}

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}else{
					
					if( buyerUseN ){
						sql.close();
						i = 0;				
						sql.put(svc.getQuery("UPD_BUYERORG_USE_YN"));
						sql.setString(++i, "N");
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("PC_ORG_CD"));

						update(sql);
						
						sql.close();
						sql.put(svc.getQuery("SEL_BUYERORG_USE_YN"));							
						sql.setString(1, mi.getString("PC_ORG_CD"));	
						List list = select2List( sql );
						
						for( int j = 0; j < list.size(); j++){
							Map keys = new HashMap();
							keys.put("BUYER_CD", ((List)list.get(j)).get(0));
							keys.put("APP_S_DT", ((List)list.get(j)).get(1));
							sql.close();
							update(Util.getHistorySQL("PC_BUYERORG", "PC_BUYERORGHIST", "DPS", keys, "BUYER_CD", strID));
						}
						
					}
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
	 * 바이어(SM) 조직 저장
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveBuyerorg(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String buyerOrgKeyCnt = "";
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
				
				String buyerCd = String2.nvl(mi.getString("BUYER_CD"));
				buyerCd = buyerCd.equals("")?newBuyerCd:buyerCd;
				String appEDt = "";
				if ( mi.IS_INSERT()) {
					
					sql.put(svc.getQuery("SEL_BUYERORG_KEY_CNT"));							
					sql.setString(1, buyerCd);							
					sql.setString(2, mi.getString("APP_S_DT"));	
					Map map = selectMap( sql );
					buyerOrgKeyCnt = String2.nvl((String)map.get("CNT"));
					if( !buyerOrgKeyCnt.equals("0")) {
						throw new Exception("[USER]"+"적용시작일이 중복 되었습니다.");
					}
					sql.close();
					sql.put(svc.getQuery("SEL_BUYERORG_APP_E_DT"));							
					sql.setString(1, buyerCd);							
					sql.setString(2, mi.getString("APP_S_DT"));	
					sql.setString(3, mi.getString("OLD_APP_S_DT"));
					map = selectMap( sql );
					appEDt = String2.nvl((String)map.get("APP_E_DT"));
					
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("INS_BUYERORG"));
					sql.setString(++i, buyerCd);
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("TEAM_CD"));
					sql.setString(++i, appEDt);
					sql.setString(++i, mi.getString("EMP_NO"));
					sql.setString(++i, mi.getString("PC_ORG_CD"));
					sql.setString(++i, buyerUseN||orgUseN?"N":mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					sql.put(svc.getQuery("SEL_BUYERORG_APP_E_DT"));							
					sql.setString(1, buyerCd);							
					sql.setString(2, mi.getString("APP_S_DT"));	
					sql.setString(3, mi.getString("OLD_APP_S_DT"));
					Map map = selectMap( sql );
					appEDt = String2.nvl((String)map.get("APP_E_DT"));
					
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("UPD_BUYERORG"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("TEAM_CD"));
					sql.setString(++i, appEDt);
					sql.setString(++i, mi.getString("EMP_NO"));
					sql.setString(++i, mi.getString("PC_ORG_CD"));
					sql.setString(++i, buyerUseN||orgUseN?"N":mi.getString("USE_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, buyerCd);
					sql.setString(++i, mi.getString("OLD_APP_S_DT"));
				} else {
					
				}	

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}else {

					sql.close();
					sql.put(svc.getQuery("SEL_BUYERORG_UPD_APP_E_DT"));							
					sql.setString(1, buyerCd);							
					sql.setString(2, mi.getString("APP_S_DT"));	
					sql.setString(3, mi.getString("APP_S_DT"));	
					sql.setString(4, mi.getString("APP_S_DT"));	
					List list = select2List( sql );
					
					
					if( list.size() > 0 ) {
						sql.close();
						sql.put(svc.getQuery("UPD_BUYERORG_APP_E_DT"));							
						sql.setString(1, buyerCd);							
						sql.setString(2, mi.getString("APP_S_DT"));	
						sql.setString(3, mi.getString("APP_S_DT"));	
						sql.setString(4, mi.getString("APP_S_DT"));	
						
						update(sql);
						
						for( int j = 0; j < list.size(); j++){
							Map keys = new HashMap();
							keys.put("BUYER_CD", ((List)list.get(j)).get(0));
							keys.put("APP_S_DT", ((List)list.get(j)).get(1));
							sql.close();
							update(Util.getHistorySQL("PC_BUYERORG", "PC_BUYERORGHIST", "DPS", keys, "BUYER_CD", strID));
						}
					}


					Map keys = new HashMap();
					keys.put("BUYER_CD", buyerCd);
					keys.put("APP_S_DT", mi.getString("APP_S_DT"));
					sql.close();
					update(Util.getHistorySQL("PC_BUYERORG", "PC_BUYERORGHIST", "DPS", keys, "BUYER_CD", strID));
					
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
}
