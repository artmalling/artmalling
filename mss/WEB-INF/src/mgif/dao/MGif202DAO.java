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
 * <p>지점출고 확정</p>
 * 
 * @created  on 1.0, 2011/04/26
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif202DAO extends AbstractDAO {
	/**
	 * 지점출고 확정  마스터 조회
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
		String strSdt = String2.nvl(form.getParam("strSdt"));   	//일자 from
		String strEdt = String2.nvl(form.getParam("strEdt"));		//일자to
		String strGiftType = String2.nvl(form.getParam("strGiftType"));		//상품권종류구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strGiftType);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점출고 확정 디테일 조회
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
		String strReqDt = String2.nvl(form.getParam("strReqDt"));	//입고일자
		String strReqStr = String2.nvl(form.getParam("strReqStr"));   //점코드
		String strReqSlipNo = String2.nvl(form.getParam("strReqSlipNo"));		//발행순번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strReqDt);
		sql.setString(i++, strReqStr);
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
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_CONF") + "\n";
		sql.setString(1, String2.nvl(form.getParam("strIssueInStr")));
		sql.setString(2, String2.nvl(form.getParam("strIssueInDt")));
		sql.setString(3, String2.nvl(form.getParam("strGiftNo")));
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
		sql.setString(1, String2.nvl(form.getParam("strIssueInStr")));
		sql.setString(2, String2.nvl(form.getParam("strSGiftNo")));
		sql.setString(3, String2.nvl(form.getParam("strEGiftNo")));
		//sql.setString(3, "104002101000009021");
		sql.setString(4, String2.nvl(form.getParam("strIssueInDt")));
		sql.setString(5, String2.nvl(form.getParam("strIssueInStr")));
		sql.setString(6, String2.nvl(form.getParam("strSGiftNo")));
		sql.setString(7, String2.nvl(form.getParam("strEGiftNo")));
		sql.setString(8, String2.nvl(form.getParam("strIssueInDt")));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점출고 확정
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
				sql.put(svc.getQuery("INS_OUTREQCONF"));
				sql.setString(i++, form.getParam("strOutDt"));				 	// 적용일자
				sql.setString(i++, form.getParam("strOutStr"));				// 신청점
				sql.setString(i++, strSlipNo); 								// 신청번호
				sql.setString(i++, form.getParam("strOutDt"));				 	// 적용일자
				sql.setString(i++, form.getParam("strOutStr"));				// 신청점
				sql.setString(i++, strSlipNo); 								// 신청번호
				sql.setString(i++, mi.getString("REQ_DT"));				 	// 발행형태
				sql.setString(i++, mi.getString("REQ_STR"));				// 발행형태
				sql.setString(i++, mi.getString("REQ_SLIP_NO"));			// 금종
				sql.setString(i++, mi.getString("REQ_SEQ_NO"));			// 금종
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));			// 금종
				sql.setString(i++, mi.getString("ISSUE_TYPE"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));			// 상품권종료번호
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				sql.setString(i++, mi.getString("OUT_QTY"));				// 상품권종료번호
				sql.setString(i++, userId); 
				sql.setString(i++, userId); 
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += 1;

				i=1;
				sql.close();
				sql.put(svc.getQuery("UPD_GIFTMST"));
				sql.setString(i++, form.getParam("strOutDt"));				 	// 적용일자
				sql.setString(i++, userId); 
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
			
			i=1;
			sql.close();
			sql.put(svc.getQuery("UPD_OUTREQ"));
			sql.setString(i++, userId); 
			sql.setString(i++, form.getParam("strReqDt"));				 	// 발행형태
			sql.setString(i++, form.getParam("strReqStr"));				// 발행형태
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
