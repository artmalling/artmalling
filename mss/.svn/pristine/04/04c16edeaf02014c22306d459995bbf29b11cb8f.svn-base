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

public class MGif211DAO extends AbstractDAO {
	/**
	 * 점내 불출내역 확정  마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		 
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strOrgCd = String2.nvl(form.getParam("strOrgCd"));		//부서
		String strSdt = String2.nvl(form.getParam("strSdt"));   	//일자 from
		String strEdt = String2.nvl(form.getParam("strEdt"));		//일자to
		String strPoutType = String2.nvl(form.getParam("strPoutType"));		//불출 유형
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
 
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOrgCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strPoutType);

		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 점내 불출내역 확정 디테일 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strReqDt = String2.nvl(form.getParam("strReqDt"));	//불출일자
		String strReqStr = String2.nvl(form.getParam("strReqStr"));   //점코드
		String strReqSlipNo = String2.nvl(form.getParam("strReqSlipNo"));		//발행순번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strReqStr);
		sql.setString(i++, strReqDt);
		sql.setString(i++, strReqSlipNo);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점출고 확정 내역 조회
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
		sql = new SqlWrapper();
		int i = 1;
		
		svc = (Service) form.getService();
		
		String strStrCd =  String2.nvl(form.getParam("strStrCd"));
		String strPoutDt = String2.nvl(form.getParam("strPoutDt"));
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));
		String strGiftNo = String2.nvl(form.getParam("strGiftNo"));
		String strOutDt = String2.nvl(form.getParam("strOutDt"));
		
		connect("pot");
		
		strQuery = svc.getQuery("SEL_CONF") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPoutDt);
		sql.setString(i++, strSlipNo);
		sql.setString(i++, strGiftNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOutDt);
		
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
		sql.setString(1, String2.nvl(form.getParam("strStrCd")));
		sql.setString(2, String2.nvl(form.getParam("strPoutDt")));
		sql.setString(3, String2.nvl(form.getParam("strSlipNo")));
		//sql.setString(4, String2.nvl(form.getParam("strPoutDt")));
		sql.setString(4, String2.nvl(form.getParam("strOutDt")));
		sql.setString(5, String2.nvl(form.getParam("strSGiftNo")));
		sql.setString(6, String2.nvl(form.getParam("strEGiftNo")));
		//sql.setString(6, "104002101000006254");
		sql.setString(7, String2.nvl(form.getParam("strStrCd")));
		sql.setString(8, String2.nvl(form.getParam("strPoutDt")));
		sql.setString(9, String2.nvl(form.getParam("strSlipNo")));
		//sql.setString(10, String2.nvl(form.getParam("strPoutDt")));
		sql.setString(10, String2.nvl(form.getParam("strOutDt")));
		sql.setString(11, String2.nvl(form.getParam("strSGiftNo")));
		sql.setString(12, String2.nvl(form.getParam("strEGiftNo")));
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
				
				sql.setString(i++, form.getParam("strConfDt"));				 	
				sql.setString(i++, mi.getString("STR_CD"));				
				sql.setString(i++, strSlipNo); 								
				sql.setString(i++, form.getParam("strConfDt"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, strSlipNo); 	
				
				sql.setString(i++, mi.getString("POUT_REQ_SLIP_NO"));				 	
				sql.setString(i++, mi.getString("POUT_REQ_SEQ_NO"));				
				sql.setString(i++, mi.getString("POUT_REQ_DT"));			// 금종
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));			// 금종
				sql.setString(i++, mi.getString("ISSUE_TYPE"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));			// 상품권종료번호 
				
				sql.setString(i++, mi.getString("CONF_QTY"));
				sql.setString(i++, mi.getString("CONF_AMT"));
				
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				
				sql.setString(i++, mi.getString("POUT_TYPE"));				// 상품권종료번호
				sql.setString(i++, mi.getString("EVENT_CD"));				// 행사코드
				sql.setString(i++, userId); 
				sql.setString(i++, userId); 
				sql.setString(i++, form.getParam("strOrgCd")); 
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += 1;

				i=1;
				sql.close();
				sql.put(svc.getQuery("UPD_MG_GIFTMST"));
				
		        sql.setString(i++, mi.getString("POUT_TYPE"));				// 신청수량
		        sql.setString(i++, mi.getString("POUT_TYPE"));				// 신청수량
				sql.setString(i++, form.getParam("strConfDt"));	
				sql.setString(i++, userId); 
				sql.setString(i++, mi.getString("POUT_TYPE"));				// 상품권 종류
				sql.setString(i++, userId); 
				sql.setString(i++, form.getParam("strOrgCd")); 
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				sql.setString(i++, mi.getString("STR_CD"));					// 상품권종료번호
				sql.setString(i++, form.getParam("strConfDt"));				// 확정일자
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
			}
			
			i=1;
			sql.close();
			sql.put(svc.getQuery("UPD_MG_POUTREQ"));
			
			sql.setString(i++, form.getParam("strReqDt"));				 	// 일자
			sql.setString(i++, userId); 
			sql.setString(i++, form.getParam("strReqDt"));				 	// 일자
			sql.setString(i++, form.getParam("strReqStr"));				// 점
			sql.setString(i++, form.getParam("strReqSlipNo"));			// 금종
			
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
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
