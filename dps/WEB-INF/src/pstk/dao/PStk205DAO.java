/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>PDA실사재고수정및확정</p>
 * 
 * @created  on 1.0, 2010/04/12
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk205DAO extends AbstractDAO {


	/**
	 * PDA실사재고를 조회한다.
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
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMBUN_CD");
			sql.setString(i++, strPumbunCd);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 디테일정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strStkDt = String2.nvl(form.getParam("strStkDt"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		int i = 1;
		
		sql.put(svc.getQuery("SEL_DETAIL"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		sql.put(svc.getQuery("SEL_DETAIL_ORDER"));

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnStk(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_PBNSTK");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnInf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd      = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_PBNINF");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 단품코드를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSkuCd(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSkuCd      = String2.nvl(form.getParam("strSkuCd"));		
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strStkDt = String2.nvl(form.getParam("strStkDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");;
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strSkuCd);
		
		strQuery = svc.getQuery("SEL_SKU_CD");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * PDA실사재고를   수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
		String orgCdCnt = "";
		//String strQuery = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd        = String2.nvl(form.getParam("strStrCd"));
			String strStkYm        = String2.nvl(form.getParam("strStkYm"));
			String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));
			String strPdaNo        = String2.nvl(form.getParam("strPdaNo"));

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {					
                    i = 0;
                    
					sql.put(svc.getQuery("SEL_STKSKU_INS_CNT"));							
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("SKU_CD"));
					sql.setString(++i, strPumbunCd);
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
					
					i = 0;	
					
					sql.put(svc.getQuery("INS_STKSKU"));
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStkYm);
					sql.setString(++i, mi.getString("SKU_CD"));	
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStkYm);
					
					sql.setString(++i, "1");
					sql.setString(++i, strPdaNo);
					sql.setString(++i, strPumbunCd);
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, mi.getString("SRVY_QTY"));
					sql.setString(++i, mi.getString("BUY_COST_PRC"));
					sql.setString(++i, mi.getString("BUY_SALE_PRC"));
					sql.setString(++i, mi.getString("SRVY_COST_AMT"));
					sql.setString(++i, mi.getString("SRVY_SALE_AMT"));
					sql.setString(++i, mi.getString("NORM_QTY"));
					sql.setString(++i, mi.getString("NORM_AMT"));
					sql.setString(++i, mi.getString("INFRR_QTY"));
					sql.setString(++i, mi.getString("INFRR_AMT"));
					sql.setString(++i, userId);
					sql.setString(++i, userId);
					
				} else if (mi.IS_UPDATE()) {
					i = 0;					
					
					sql.put(svc.getQuery("UPD_STKSKU"));	
										
					sql.setString(++i, mi.getString("NORM_QTY"));
					sql.setString(++i, mi.getString("NORM_AMT"));
					sql.setString(++i, mi.getString("INFRR_QTY"));
					sql.setString(++i, mi.getString("INFRR_AMT"));
					sql.setString(++i, mi.getString("SRVY_QTY"));					
					sql.setString(++i, userId);
					sql.setString(++i, strStrCd);					
					sql.setString(++i, strStkYm);
					sql.setString(++i, mi.getString("SKU_CD"));
					sql.setString(++i, mi.getString("SEQ_NO"));
					
					
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
