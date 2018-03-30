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
 * <p>실사재고등록(단품)</p>
 * 
 * @created  on 1.0, 2010/04/04
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk220DAO extends AbstractDAO {


	/**
	 * 실사재고(단품)을 조회한다.
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
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strSkuType    = String2.nvl(form.getParam("strSkuType"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStkDt);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_STKSKU") + "\n";
		
		if(strSkuType.equals("3")){			
			strQuery += svc.getQuery("SEL_STKSKU_ORDER_STYLE");
		}else{			
			strQuery += svc.getQuery("SEL_STKSKU_ORDER");
		}
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 실사재고(단품)을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMasterExcel(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
				
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		/*
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		*/
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_STKSKU_EXCEL") + "\n";
		
		strQuery += svc.getQuery("SEL_STKSKU_ORDER");
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
	public List searchPbnStk(ActionForm form) throws Exception {
		
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
		
		sql.setString(i++, strPumbunCd);
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
	 * 마감 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCloseDt(ActionForm form) throws Exception {
		
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
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_CLOSE");
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
	public List searchSkuCd(ActionForm form , String userId , String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));		
		String strStkYm   = String2.nvl(form.getParam("strStkYm"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));		
		String strSkuCd   = String2.nvl(form.getParam("strSkuCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);
		
		/*
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);
		*/
		
		
		strQuery = svc.getQuery("SEL_SKU_CD");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 단품 유요성 체크.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSkuCheck(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null; 
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 

		connect("pot");
		
		String strStrCd   	= String2.nvl(form.getParam("strStrCd"));
		String strModelNo   = String2.nvl(form.getParam("strModelNo"));
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd"));
		
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strModelNo);
		strQuery = svc.getQuery("SEL_SKU_CHECK");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 실사재고를  저장, 수정  처리한다.
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
		String strQuery = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd        = String2.nvl(form.getParam("strStrCd"));
			String strStkYm        = String2.nvl(form.getParam("strStkYm"));
			String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {			
					i = 0;	
					
					sql.put(svc.getQuery("INS_STKSKU"));
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStkYm);
					sql.setString(++i, mi.getString("SKU_CD"));	
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStkYm);
					
					sql.setString(++i, "0");
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
					sql.setString(++i, mi.getString("SRVY_COST_AMT"));
					sql.setString(++i, mi.getString("SRVY_SALE_AMT"));
					sql.setString(++i, mi.getString("BUY_COST_PRC"));
					sql.setString(++i, mi.getString("BUY_SALE_PRC"));
					sql.setString(++i, userId);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));
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
	
	/**
	 *  <p>
	 *  인정LOSS율을 삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) 
						throws Exception {

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
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					i = 0;	
					
					sql.put(svc.getQuery("DEL_STKSKU"));
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("STK_YM"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("SEQ_NO"));					
					
					res = update(sql);					
				}else{
					continue;
				} 

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
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
