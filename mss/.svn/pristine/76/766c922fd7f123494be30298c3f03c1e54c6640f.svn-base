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
/**
 * <p>회수등록</p>
 * 
 * @created  on 1.0, 2011/05/19
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif307DAO extends AbstractDAO {
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
		strQuery = svc.getQuery("SEL_GIFTCARD") + "\n";
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
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo;
		int i =1;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sql.put(svc.getQuery("SEL_DRAWL_SLIP_NO"));
			Map map = (Map) selectMap(sql);
			strSlipNo = map.get("DRAWL_SLIP_NO").toString();
		
			while(mi.next()){
				sql.close();
				i = 1;
				sql.put(svc.getQuery("INS_GIFTDRAWL")); 
				sql.setString(i++, form.getParam("strDrawlDt"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, strSlipNo);
				sql.setString(i++, form.getParam("strDrawlDt"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, strSlipNo);
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
				sql.setString(i++, mi.getString("ISSUE_TYPE"));
				sql.setString(i++, form.getParam("strDrawlFlag")); 
				sql.setString(i++, mi.getString("GIFTCERT_AMT"));
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
				sql.put(svc.getQuery("UPD_GIFTMST")); 
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, form.getParam("strDrawlDt"));
				sql.setString(i++, form.getParam("strDrawlFlag"));
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				sql.setString(i++, mi.getString("GIFTCARD_NO"));
				
				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
