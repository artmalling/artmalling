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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif213DAO extends AbstractDAO {
	/**
	 * 상품권판반납 등록 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getConf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strPoutType = String2.nvl(form.getParam("strPoutType"));		//반납유형
		String strGiftNo = String2.nvl(form.getParam("strGiftNo"));		//반납유형
		String strStrCd = String2.nvl(form.getParam("strStrCd"));		//반납유형
		String strPoutDt = String2.nvl(form.getParam("strPoutDt"));		// 반납일자
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_INSERT") + "\n";
		sql.setString(i++, strPoutType);
		sql.setString(i++, strPoutType);
		sql.setString(i++, strGiftNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPoutDt);
		
		//if(strPoutType.equals("1") || strPoutType.equals("4")){
			strQuery += svc.getQuery("SEL_GIFT_INSERT_WHERE_POUT_TYPE") + "\n";
			sql.setString(i++, strPoutType);
		//}
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 유효 상품권 개수 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCnt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		strQuery = svc.getQuery("SEL_CNT") + "\n";
		sql.setString(1, String2.nvl(form.getParam("strSGiftNo")));
		sql.setString(2, String2.nvl(form.getParam("strEGiftNo")));
		sql.setString(3, String2.nvl(form.getParam("strPoutType")));
		sql.setString(4, String2.nvl(form.getParam("strPoutType")));
		sql.setString(5, String2.nvl(form.getParam("strPoutDt")));
		sql.setString(6, String2.nvl(form.getParam("strStrCd")));
		sql.setString(7, String2.nvl(form.getParam("strPoutType")));
		sql.setString(8, String2.nvl(form.getParam("strSGiftNo")));
		sql.setString(9, String2.nvl(form.getParam("strEGiftNo")));	
		sql.setString(10, String2.nvl(form.getParam("strPoutDt")));
		sql.setString(11, String2.nvl(form.getParam("strStrCd")));
		sql.setString(12, String2.nvl(form.getParam("strPoutType")));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 불출내역  확정
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
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo = "";
		String strPoutType = String2.nvl(form.getParam("strPoutType"));		//반납유형
		String strStrCd = String2.nvl(form.getParam("strStrCd"));		//반납유형
		String strPoutDt = String2.nvl(form.getParam("strPoutDt"));		// 반납일자
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				i=1;
				sql.close();
				
				if(strSlipNo.equals("")){
					sql.put(svc.getQuery("SEL_SLIP_NO"));
					Map map = (Map) selectMap(sql);
					strSlipNo = map.get("SLIP_NO").toString();
					sql.close();
				}
				
				sql.put(svc.getQuery("INS_MG_POUTREQCONF"));
				 
				sql.setString(i++, mi.getString("CONF_DT"));				 	
				sql.setString(i++, mi.getString("STR_CD"));				
				sql.setString(i++, strSlipNo); 								
				sql.setString(i++, mi.getString("CONF_DT"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, strSlipNo); 	
				
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));			// 금종
				sql.setString(i++, mi.getString("ISSUE_TYPE"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));			// 상품권종료번호
				
				sql.setString(i++, mi.getString("CONF_QTY"));
				sql.setString(i++, mi.getString("CONF_AMT"));
				
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				
				sql.setString(i++, mi.getString("POUT_TYPE"));				// 상품권종료번호
				sql.setString(i++, mi.getString("EVENT_CD"));				// 상품권종료번호
				
				sql.setString(i++, userId); 
				sql.setString(i++, userId); 
				 
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += 1;
				
				//상품권 마스터 수정
				i=1;
				sql.close(); 
				sql.put(svc.getQuery("UPD_MG_GIFTMST"));
				
				sql.setString(i++, mi.getString("CONF_DT")); 
				sql.setString(i++, userId);  
				sql.setString(i++, mi.getString("POUT_TYPE"));				//불출유형
				sql.setString(i++, userId); 
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				sql.setString(i++, mi.getString("CONF_DT"));				// 불출일자 체크
				sql.setString(i++, strPoutType);
				sql.setString(i++, strPoutType);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strPoutType);
				res = update(sql);
				if (res == 0) {
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
