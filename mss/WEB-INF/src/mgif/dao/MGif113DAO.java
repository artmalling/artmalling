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
 * <p>발행입고확정</p>
 * 
 * @created  on 1.0, 2011/04/18
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif113DAO extends AbstractDAO {
	/**
	 * 발행입고확정 마스터 조회
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
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행입고확정 디테일 조회
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
		
		String strReqDt = String2.nvl(form.getParam("strReqDt"));	//발행신청일자
		String strStrCd = String2.nvl(form.getParam("strStrCd"));   //점코드
		String strReqSlipNo = String2.nvl(form.getParam("strReqSlipNo"));		//발행순번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strReqDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqSlipNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권번호 등록시 유효성 체크 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkGiftCardNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));			//발행신청일자
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));   		//점코드
		String strIssueType = String2.nvl(form.getParam("strIssueType"));	//발행순번
		String strGiftAmtType = String2.nvl(form.getParam("strGiftAmtType"));	//발행순번
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTCARD_NO") + "\n";
		sql.setString(i++, strGiftCardNo);
		sql.setString(i++, strGiftAmtType);
		sql.setString(i++, strGiftTypeCd);
		sql.setString(i++, strIssueType);
		sql.setString(i++, strGiftCardNo);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	
	/**
	 * 상품권번호 등록시 미등록 상품권수량 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftCnt(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strSNo = String2.nvl(form.getParam("strSNo"));			//시작번호
		String strENo = String2.nvl(form.getParam("strENo"));			//종료번호
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTCNT") + "\n";
		sql.setString(i++, strSNo);
		sql.setString(i++, strENo);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행신청 저장&수정
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
		String strInDt = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				i=1;
				sql.close();
				// 신규 등록
				if(!mi.getString("IN_GIFT_S_NO").equals("") 
						&& !mi.getString("IN_GIFT_E_NO").equals("") 
						&& !mi.getString("IN_QTY").equals("0")){ 
					if(strSlipNo.equals("") || !strInDt.equals(mi.getString("IN_DT"))){
						sql.put(svc.getQuery("SEL_SLIP_NO"));
						Map map = (Map) selectMap(sql);
						strSlipNo = map.get("SLIP_NO").toString();
						sql.close();
					}
					// 발행입고 등록
					sql.put(svc.getQuery("INS_GIFTISSUEIN"));
					sql.setString(i++, mi.getString("IN_DT"));				 	// IN_DT 입고일
					sql.setString(i++, mi.getString("STR_CD"));				 	// STR_CD 입고점
					sql.setString(i++, strSlipNo); 								// IN_SLIP_NO 입고전표번호
					sql.setString(i++, mi.getString("IN_DT"));				 	// IN_DT 입고일
					sql.setString(i++, mi.getString("STR_CD"));				 	// STR_CD 입고점
					sql.setString(i++, strSlipNo); 								// IN_SLIP_NO 입고전표번호
					sql.setString(i++, mi.getString("GIFT_TYPE_CD"));			// GIFT_TYPE_CD 상품권종류코드
					sql.setString(i++, mi.getString("ISSUE_TYPE"));				// ISSUE_TYPE 발행형태
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE")); 			// GIFT_AMT_TYPE 금종
					sql.setString(i++, mi.getString("IN_QTY"));					// IN_QTY 입고수량
					sql.setString(i++, mi.getString("IN_GIFT_S_NO"));			// GIFT_S_NO 상품권시작번호
					sql.setString(i++, mi.getString("IN_GIFT_E_NO"));			// GIFT_E_NO 상품권 종료번호
					sql.setString(i++, mi.getString("REQ_DT"));					// REQ_DT 신청일자
					sql.setString(i++, mi.getString("REQ_SLIP_NO"));			// REQ_SLIP_NO 신청번호
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				// REQ_SEQ_NO 신청순번
					sql.setString(i++, userId);									// IN_EMP_ID 입고자사번
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 
				
					res = update(sql);
					
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					ret += 1;
					i = 1;
					sql.close();
					// 상품마스터 생성
					sql.put(svc.getQuery("INS_GIFTMST"));
					sql.setString(i++, mi.getString("IN_DT"));				 	// ISSUE_IN_DT
					sql.setString(i++, mi.getString("STR_CD"));				 	// ISSUE_IN_STR
					sql.setString(i++, userId);  								// ISSUE_IN_EMP_ID
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 

					sql.setString(i++, mi.getString("IN_DT"));				 	// IN_DT
					sql.setString(i++, mi.getString("STR_CD"));				 	// IN_STR
					sql.setString(i++, userId);  								// IN_EMP_ID
					
					sql.setString(i++, mi.getString("REQ_DT"));				 	// REQ_DT
					sql.setString(i++, mi.getString("STR_CD"));				 	// REQ_STR
					sql.setString(i++, mi.getString("REQ_SLIP_NO")); 			// REQ_SLIP_NO
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				// REQ_SEQ_NO
					sql.setString(i++, mi.getString("IN_GIFT_S_NO"));			// GIFT_S_NO 상품권시작번호
					sql.setString(i++, mi.getString("IN_GIFT_E_NO"));			// GIFT_E_NO 상품권 종료번호
					
					res = update(sql);
					
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					
					i = 1;
					sql.close();
					// 발행의뢰 테이블 입고 설정
					sql.put(svc.getQuery("UPD_GIFTREQ"));
					sql.setString(i++, userId); 
					sql.setString(i++, mi.getString("IN_GIFT_S_NO"));			// GIFT_S_NO 상품권시작번호
					sql.setString(i++, mi.getString("IN_GIFT_E_NO"));			// GIFT_E_NO 상품권 종료번호
					
					res = update(sql);
					
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					
					i = 1;
					sql.close();
					// 발행의뢰 테이블 입고 설정
					sql.put(svc.getQuery("UPD_GIFTISSUEREQ"));
					sql.setString(i++, userId); 
					sql.setString(i++, mi.getString("REQ_DT"));				 	// REQ_DT
					sql.setString(i++, mi.getString("STR_CD"));				 	// REQ_STR
					sql.setString(i++, mi.getString("REQ_SLIP_NO")); 			// REQ_SLIP_NO
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				// REQ_SEQ_NO
					res = update(sql);
					
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					
					strInDt = mi.getString("IN_DT");
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
