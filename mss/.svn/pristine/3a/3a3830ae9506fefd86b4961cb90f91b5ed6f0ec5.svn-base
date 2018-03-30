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
 * <p>발행신청</p>
 * 
 * @created  on 1.0, 2011/04/08
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif111DAO extends AbstractDAO {
	/**
	 * 상품권종류 콤보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftTypeCd(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_COMBO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행신청 마스터 조회
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
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strSdt"));
		sql.setString(i++, form.getParam("strEdt"));
		sql.setString(i++, form.getParam("strSearchGb"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행신청 상세조회
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
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, form.getParam("strReqDt"));
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strReqSlipNo"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행신청 상세조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getNewDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_NEW_DETAIL") + "\n";
		sql.setString(i++, form.getParam("strREQ_DT"));
		sql.setString(i++, form.getParam("strGiftTypeCd"));
		
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
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				i=1;
				sql.close();
				// 신규 등록
				if(mi.getString("REQ_SEQ_NO").equals("") && !mi.getString("REQ_QTY").equals("0")){ 
					if(strSlipNo.equals("")){
						sql.put(svc.getQuery("SEL_SLIP_NO"));
						Map map = (Map) selectMap(sql);
						strSlipNo = map.get("SLIP_NO").toString();
						sql.close();
					}
					sql.put(svc.getQuery("INS_DETAIL"));
					sql.setString(i++, form.getParam("strReqDt"));				 	// 적용일자
					sql.setString(i++, form.getParam("strStrCd"));				 	// 신청점
					sql.setString(i++, strSlipNo); 									// 신청번호
					sql.setString(i++, form.getParam("strReqDt"));				 	// 적용일자
					sql.setString(i++, form.getParam("strStrCd"));				 	// 신청점
					sql.setString(i++, strSlipNo); 									// 신청번호
					sql.setString(i++, form.getParam("strGiftTypeCd"));				// 상품권종류코드
					sql.setString(i++, mi.getString("ISSUE_TYPE"));				 	// 발행형태
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));				// 금종
					sql.setString(i++, mi.getString("REQ_QTY"));					// 신청수량
					sql.setString(i++, mi.getString("GIFT_S_NO"));					// 상품권시작번호
					sql.setString(i++, mi.getString("GIFT_E_NO"));					// 상품권종료번호
					sql.setString(i++, "01");										// 상태구분  01:신청 ,02:발행의뢰 ,03:입고
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 
				}
				// 수정수량이 0인경우 삭제
				if(!mi.getString("REQ_SEQ_NO").equals("") && mi.getString("REQ_QTY").equals("0")){ 
					sql.put(svc.getQuery("DEL_DETAIL"));
					sql.setString(i++, form.getParam("strReqDt"));				// 신청일자
					sql.setString(i++, form.getParam("strStrCd"));				// 신청점
					sql.setString(i++, form.getParam("strReqSlipNo"));			// 신청번호
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				// 신청순번
				}
				// 수정수량이 0이 아닌경우 수량 및 시작, 종료번호 수정
				if(!mi.getString("REQ_SEQ_NO").equals("") && !mi.getString("REQ_QTY").equals("0")){ 
					sql.put(svc.getQuery("UPD_DETAIL"));
					sql.setString(i++, mi.getString("REQ_QTY"));				// 수정수량
					sql.setString(i++, mi.getString("GIFT_S_NO"));				// 상품권시작번호
					sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
					sql.setString(i++, userId);									// 수정자
					sql.setString(i++, form.getParam("strReqDt"));				// 신청일자
					sql.setString(i++, form.getParam("strStrCd"));				// 신청점
					sql.setString(i++, form.getParam("strReqSlipNo"));			// 신청번호
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				// 신청순번
				}
				
				res = update(sql);
				
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				ret += 1;
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
