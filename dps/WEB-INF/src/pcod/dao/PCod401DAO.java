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
 * <p>품목코드관리</p>
 * 
 * @created  on 1.0, 2010/02/08
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod401DAO extends AbstractDAO {

	String newPummokCd = "";
	String pummokcut = "";//품목 단축코드
	/**
	 * 품목 마스터 트리을 조회한다.
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
		
		String strLCd = String2.nvl(form.getParam("strLCd"));
		String strMCd = String2.nvl(form.getParam("strMCd"));
		String strSCd = String2.nvl(form.getParam("strSCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_TREE_PMKMST") + "\n";

		strQuery += svc.getQuery("SEL_TREE_PMKMST_UP_S") + "\n";
		if( !strLCd.equals("%") && !strLCd.equals("")){
			sql.setString(i++, strLCd);
			strQuery += svc.getQuery("SEL_TREE_PMKMST_WHERE_L_CD") + "\n";
		}
		if( !strMCd.equals("%") && !strMCd.equals("")){
			sql.setString(i++, strMCd);
			strQuery += svc.getQuery("SEL_TREE_PMKMST_WHERE_M_CD") + "\n";
		}
		if( !strSCd.equals("%") && !strSCd.equals("")){
			sql.setString(i++, strSCd);
			strQuery += svc.getQuery("SEL_TREE_PMKMST_WHERE_S_CD") + "\n";
		}
		strQuery += svc.getQuery("SEL_TREE_PMKMST_UP_E") + "\n";
		
		if( (!strLCd.equals("%") && !strLCd.equals(""))
				|| (!strMCd.equals("%") && !strMCd.equals(""))
				|| (!strSCd.equals("%") && !strSCd.equals("")) ){
			strQuery += svc.getQuery("SEL_TREE_PMKMST_DOWN_S") + "\n";
			if( !strLCd.equals("%") && !strLCd.equals("")){
				sql.setString(i++, strLCd);
				strQuery += svc.getQuery("SEL_TREE_PMKMST_WHERE_L_CD") + "\n";
			}
			if( !strMCd.equals("%") && !strMCd.equals("")){
				sql.setString(i++, strMCd);
				strQuery += svc.getQuery("SEL_TREE_PMKMST_WHERE_M_CD") + "\n";
			}
			if( !strSCd.equals("%") && !strSCd.equals("")){
				sql.setString(i++, strSCd);
				strQuery += svc.getQuery("SEL_TREE_PMKMST_WHERE_S_CD") + "\n";
			}
			strQuery += svc.getQuery("SEL_TREE_PMKMST_DOWN_E") + "\n";
			
		}
		strQuery += svc.getQuery("SEL_TREE_PMKMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 점별 목표이익율을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchStrpmkprfrt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_STRPMKPRFRT");
		sql.setString(i++, strPummokCd);
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 품목 마스터,
	 * 점별 목표이익율,
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
				// 품목 마스터
				if( idx == 0){
					ret += savePmkmst(form, mi[idx], strID);
				//점별 목표이익율
				}else if ( idx == 1){
					ret += saveStrpmkprfrt(form, mi[idx], strID);
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
	 *  품목 마스터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int savePmkmst(ActionForm form, MultiInput mi, String strID) 
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
				
				if ( mi.IS_INSERT()) {
					newPummokCd = mi.getString("L_CD");
					newPummokCd += mi.getString("M_CD").equals("")?"00":mi.getString("M_CD");
					newPummokCd += mi.getString("S_CD").equals("")?"00":mi.getString("S_CD");
					newPummokCd += mi.getString("D_CD").equals("")?"00":mi.getString("D_CD");
					
					//pummokcut 품목 단축코드
					pummokcut = mi.getString("L_CD").substring(1);
					pummokcut += mi.getString("M_CD").equals("")?"0":mi.getString("M_CD").substring(1);
					pummokcut += mi.getString("S_CD").equals("")?"0":mi.getString("S_CD").substring(1);
					pummokcut += mi.getString("D_CD").equals("")?"0":mi.getString("D_CD").substring(1);
					
					
					
					sql.put(svc.getQuery("SEL_PMKMST_PUMMOK_CD_CNT"));							
					sql.setString(1, newPummokCd);								
					Map map = selectMap( sql );							
					String pummokCdCnt = String2.nvl((String)map.get("CNT"));
					if( !pummokCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 분류코드 입니다.");
					}
					
					sql.close();
					i = 0;
					
					sql.put(svc.getQuery("INS_PMKMST"));
					
					sql.setString(++i, newPummokCd);
					sql.setString(++i, mi.getString("PUMMOK_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, pummokcut);//품목 단축 코드 들어가야 할곳
					sql.setString(++i, mi.getString("PUMMOK_LEVEL"));
					sql.setString(++i, mi.getString("L_CD"));
					sql.setString(++i, mi.getString("M_CD").equals("")?"00":mi.getString("M_CD"));
					sql.setString(++i, mi.getString("S_CD").equals("")?"00":mi.getString("S_CD"));
					sql.setString(++i, mi.getString("D_CD").equals("")?"00":mi.getString("D_CD"));
					sql.setString(++i, mi.getString("P_PUMMOK_CD"));
					sql.setString(++i, mi.getString("FCL_FLAG"));
					sql.setString(++i, mi.getString("FRESH_YN"));
					sql.setString(++i, mi.getString("TAG_FLAG"));
					sql.setString(++i, mi.getString("UNIT_CD"));
					sql.setString(++i, "Y");                          // 사용여부 "Y" 고정
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				
					
				} else if (mi.IS_UPDATE()){

					i = 0;							
					sql.put(svc.getQuery("UPD_PMKMST"));
					sql.setString(++i, mi.getString("PUMMOK_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, mi.getString("TAG_FLAG"));
					sql.setString(++i, mi.getString("UNIT_CD"));
					sql.setString(++i, mi.getString("FCL_FLAG"));
					sql.setString(++i, strID);
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
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}

	/**
	 * <p>
	 * 점별 목표이익율 저장
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveStrpmkprfrt(ActionForm form, MultiInput mi, String strID) 
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
				//품목코드 지정
				newPummokCd = mi.getString("PUMMOK_CD").equals("")? newPummokCd:mi.getString("PUMMOK_CD");
				//신규입력된데이터
				if ( mi.IS_INSERT()) {
					//종료일자 조회
					i = 0;							
					sql.put(svc.getQuery("SEL_STRPMKPRFRT_APP_E_DT"));			
					sql.setString(++i, newPummokCd);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					Map map = selectMap( sql );							
					String appEDt = String2.nvl((String)map.get("APP_E_DT"));
					sql.close();

					//신규입력
					i = 0;							
					sql.put(svc.getQuery("INS_STRPMKPRFRT"));	
					sql.setString(++i, newPummokCd);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, appEDt);
					sql.setString(++i, mi.getString("GOAL_PROF_RATE"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				//수정된 데이터
				} else if (mi.IS_UPDATE()){

					//종료일자 조회
					i = 0;							
					sql.put(svc.getQuery("SEL_STRPMKPRFRT_APP_E_DT"));			
					sql.setString(++i, newPummokCd);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("OLD_APP_S_DT"));
					Map map = selectMap( sql );							
					String appEDt = String2.nvl((String)map.get("APP_E_DT"));
					sql.close();

					i = 0;							
					sql.put(svc.getQuery("UPD_STRPMKPRFRT"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, appEDt);
					sql.setString(++i, mi.getString("GOAL_PROF_RATE"));
					sql.setString(++i, strID);
					sql.setString(++i, newPummokCd);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("OLD_APP_S_DT"));
					
					
				} else {
				}

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				// 시작일이 작은 항목에 종료일자 수정( 시작일 -1 )
				sql.close();
				i = 0;							
				sql.put(svc.getQuery("UPD_STRPMKPRFRT_APP_E_DT"));		
				sql.setString(++i, mi.getString("APP_S_DT"));	
				sql.setString(++i, newPummokCd);
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("APP_S_DT"));
				update(sql);
				
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
