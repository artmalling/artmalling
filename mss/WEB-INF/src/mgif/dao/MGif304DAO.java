/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>상품권 교환 판매등록</p>
 * 
 * @created  on 1.0, 2011/05/17
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif304DAO extends AbstractDAO {
	
	/**
	 * 상품권 번호 정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftNoInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		if(form.getParam("strGbn").equals("R")){
			strQuery = svc.getQuery("SEL_GIFT_INFO_01") + "\n";
			sql.setString(i++, form.getParam("strGiftNo"));
		}else if(form.getParam("strGbn").equals("S")){
			strQuery = svc.getQuery("SEL_GIFT_INFO_02") + "\n";
			sql.setString(i++, form.getParam("strStrCd"));
			sql.setString(i++, form.getParam("strGiftNo"));
		}
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권 번호 정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		if(form.getParam("strGbn").equals("R")){
			strQuery = svc.getQuery("SEL_RETURN") + "\n";
			sql.setString(i++, form.getParam("strGiftENo"));
			sql.setString(i++, form.getParam("strGiftENo"));
		}else if(form.getParam("strGbn").equals("S")){
			strQuery = svc.getQuery("SEL_SALE") + "\n";
			sql.setString(i++, form.getParam("strStrCd"));
			sql.setString(i++, form.getParam("strGiftENo"));
			sql.setString(i++, form.getParam("strGiftENo"));
		}
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권판매 정보 등록
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		String ret = "";
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			// 회수내역 저장
			saveReturn(svc, mi[0], userId, form);
			
			// 판매내역 저장
			ret = saveSale(svc, mi[1], userId, form);
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	
	/**
	 * 사은행사 사은품 저장/수정/삭제
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public int saveReturn(Service svc, MultiInput mi, String userId, ActionForm form)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		String strSlipNo= "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_DRAWL_SLIP_NO"));
			Map map = (Map) selectMap(sql);
			strSlipNo = map.get("DRAWL_SLIP_NO").toString();
		
			while(mi.next()){
				sql.close();
				i = 1;
				sql.put(svc.getQuery("INS_GIFTDRAWL")); 
				sql.setString(i++, form.getParam("strSaleDt"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, strSlipNo);
				sql.setString(i++, form.getParam("strSaleDt"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, strSlipNo);
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
				sql.setString(i++, mi.getString("ISSUE_TYPE"));
				sql.setString(i++, mi.getString("AMT"));
				sql.setString(i++, mi.getString("GIFTCARD_NO"));
				sql.setString(i++, mi.getString("SALE_STR"));
				sql.setString(i++, mi.getString("SALE_DT"));
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				sql.close();
				i = 1;
				sql.put(svc.getQuery("UPD_GIFTMST_R")); 
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, form.getParam("strSaleDt"));
				sql.setString(i++, userId);
				sql.setString(i++, mi.getString("SALE_EMP_ID"));
				sql.setString(i++, userId);
				sql.setString(i++, mi.getString("GIFTCARD_NO"));
				
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return res;
	}
	
	/**
	 * 사은행사 사은품 저장/수정/삭제
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public String saveSale(Service svc, MultiInput mi, String userId, ActionForm form)
			throws Exception {
		String ret;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		String strSlipNo= "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_SALE_SLIP_NO"));
			Map map = (Map) selectMap(sql);
			strSlipNo = map.get("SALE_SLIP_NO").toString();
		
			sql.close();
			i = 1;
			sql.put(svc.getQuery("INS_SALEMST")); 
			sql.setString(i++, form.getParam("strSaleDt"));
			sql.setString(i++, form.getParam("strStrCd"));
			sql.setString(i++, strSlipNo);
			sql.setString(i++, form.getParam("strPartCd"));
			sql.setString(i++, form.getParam("strSSum"));
			sql.setString(i++, form.getParam("strSaleDt"));
			sql.setString(i++, form.getParam("strStrCd"));
			sql.setString(i++, strSlipNo);
			sql.setString(i++, userId);
			sql.setString(i++, userId);
			
			res = update(sql);

			if (res != 1) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
				
			while(mi.next()){
				sql.close();
				i = 1;
				sql.put(svc.getQuery("INS_SALEDTL")); 
				sql.setString(i++, form.getParam("strSaleDt"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, strSlipNo);
				sql.setString(i++, form.getParam("strSaleDt"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, strSlipNo);
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
				sql.setString(i++, mi.getString("ISSUE_TYPE"));
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
				sql.setString(i++, mi.getString("QTY"));
				sql.setString(i++, mi.getString("AMT"));
				sql.setString(i++, mi.getString("GIFTCARD_NO"));
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				sql.close();
				i = 1;
				sql.put(svc.getQuery("UPD_GIFTMST_S")); 
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, form.getParam("strSaleDt"));
				sql.setString(i++, form.getParam("strPartCd"));
				sql.setString(i++, userId);
				sql.setString(i++, form.getParam("strSSum"));
				sql.setString(i++, userId);
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, mi.getString("GIFTCARD_NO"));
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
			
			sql.close();
			// MASTER 
			sql.put(svc.getQuery("SEL_SALE_SLIP_NO_FULL"));
			sql.setString(1, form.getParam("strStrCd"));				 	// 판매점
			sql.setString(2, form.getParam("strSaleDt"));				 	// 판매일
			sql.setString(3, strSlipNo); 									// 판매전표번호
			Map rstMap = (Map) selectMap(sql);
			ret = rstMap.get("SALE_SLIP_NO").toString();
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

}
