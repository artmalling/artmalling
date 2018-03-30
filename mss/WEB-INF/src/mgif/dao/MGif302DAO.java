/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>상품권 판매등록</p>
 * 
 * @created  on 1.0, 2011/05/09
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif302DAO extends AbstractDAO {
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
		strQuery = svc.getQuery("SEL_SALE_INFO") + "\n";
		if(form.getParam("strGiftSNo").equals("")){
			sql.setString(i++, form.getParam("strGiftENo"));
			sql.setString(i++, form.getParam("strGiftENo"));
		}else{
			sql.setString(i++, form.getParam("strGiftSNo"));
			sql.setString(i++, form.getParam("strGiftENo"));
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
	public List getGiftNoInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_INFO") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strGiftNo"));
		
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
	public String save(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		String ret;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// MASTER 
			sql.put(svc.getQuery("SEL_SLIP_NO"));
			Map map = (Map) selectMap(sql);
			strSlipNo = map.get("SALE_SLIP_NO").toString();
			
			sql.close();
			sql.put(svc.getQuery("INS_SALEMST"));
			sql.setString(i++, form.getParam("strSaleDt"));				 	// 판매일
			sql.setString(i++, form.getParam("strStrCd"));				 	// 판매점
			sql.setString(i++, strSlipNo); 									// 판매전표번호
			sql.setString(i++, form.getParam("strPartCd"));				 	// 판매부서코드
			sql.setString(i++, form.getParam("strSaleAmt"));				// 판매금액
			sql.setString(i++, form.getParam("strSaleDt"));				 	// 판매일
			sql.setString(i++, form.getParam("strStrCd"));				 	// 판매점
			sql.setString(i++, strSlipNo); 									// 판매전표번호
			sql.setString(i++, URLDecoder.decode(form.getParam("strPumNo"), "UTF-8")); 					// 품의서번호 
			sql.setString(i++, form.getParam("strRemark"));				 	// 적요
			sql.setString(i++, userId);										// 등록자
			sql.setString(i++, userId); 
			res = update(sql);
			
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			// DETAIL
			while(mi.next()){
				i=1;
				sql.close();
				sql.put(svc.getQuery("INS_SALEDTL"));
				sql.setString(i++, form.getParam("strSaleDt"));				 	// 판매일
				sql.setString(i++, form.getParam("strStrCd"));				 	// 판매점
				sql.setString(i++, strSlipNo); 									// 판매전표번호
				sql.setString(i++, form.getParam("strSaleDt"));				 	// 판매일
				sql.setString(i++, form.getParam("strStrCd"));				 	// 판매점
				sql.setString(i++, strSlipNo); 									// 판매전표번호
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));				// 상품권종류코드
				sql.setString(i++, mi.getString("ISSUE_TYPE"));					// 발행형태
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));				// 금종
				sql.setString(i++, mi.getString("QTY"));					// 수량
				sql.setString(i++, mi.getString("AMT"));					// 금액
				sql.setString(i++, mi.getString("GIFTCARD_NO"));				// 상품권번호
				sql.setString(i++, userId); 
				sql.setString(i++, userId); 
				
				res = update(sql);
				
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				i=1;
				sql.close();
				sql.put(svc.getQuery("UPD_GIFTMST"));
				sql.setString(i++, form.getParam("strStrCd"));				 	// 판매점
				sql.setString(i++, form.getParam("strSaleDt"));				 	// 판매일
				sql.setString(i++, form.getParam("strPartCd"));				 	// 판매부서코드
				sql.setString(i++, userId); 									// 판매자
				sql.setString(i++, mi.getString("AMT"));					// 금액
				sql.setString(i++, userId); 									// 수정자
				sql.setString(i++, mi.getString("GIFTCARD_NO"));				// 상품권번호
				res = update(sql);
				
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
			}
			sql.close();
			// MASTER 
			sql.put(svc.getQuery("SEL_SALE_SLIP_NO"));
			sql.setString(1, form.getParam("strStrCd"));				 	// 판매점
			sql.setString(2, form.getParam("strSaleDt"));				 	// 판매일
			sql.setString(3, strSlipNo); 									// 판매전표번호
			Map rstMap = (Map) selectMap(sql);
			ret = rstMap.get("SALE_SLIP_NO").toString();
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}

}
