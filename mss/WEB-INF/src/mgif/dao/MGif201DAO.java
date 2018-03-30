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
 * <p>지점출고 신청</p>
 * 
 * @created  on 1.0, 2011/04/21
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif201DAO extends AbstractDAO {

	/**
	 * 콤보데이터셋 조회
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
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		try{
			connect("pot");
			strQuery = svc.getQuery("SEL_GIFT_TYPE_CD");
			sql.put(strQuery);
			ret = select2List(sql);
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	
	/**
	 * 지점출고 신청  마스터 조회
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
	 * 지점출고신청 디테일 조회
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
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));		//발행순번
		String strStatFlag = String2.nvl(form.getParam("strStatFlag"));		//발행순번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		if(strStatFlag.equals("01")){
			strQuery = svc.getQuery("SEL_DETAIL_O") + "\n";
		}else if(strStatFlag.equals("02")){
			strQuery = svc.getQuery("SEL_DETAIL_J") + "\n";
		}
		
		sql.setString(i++, strReqDt);
		sql.setString(i++, strReqStr);
		sql.setString(i++, strReqSlipNo);
		sql.setString(i++, strGiftTypeCd);
		sql.setString(i++, strReqDt);
		sql.setString(i++, strReqStr);
		sql.setString(i++, strReqSlipNo);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점출고신청 금종정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftTypeAmt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strReqDt = String2.nvl(form.getParam("strReqDt"));	//신청일자
		String strStrCd = String2.nvl(form.getParam("strStrCd"));   //신청점
		String strHStrCd = String2.nvl(form.getParam("strHStrCd"));		//본사점
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));		//상품권종류
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_TYPE_AMT") + "\n";
		sql.setString(i++, strReqDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strHStrCd);
		sql.setString(i++, strGiftTypeCd);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점출고신청
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
				// 신규 등록 :: 신청순번이 없는경우 신규 등록
				if( mi.getString("REQ_SEQ_NO").equals("")){
					if(strSlipNo.equals("") && mi.getString("REQ_SLIP_NO").equals("")){
						sql.put(svc.getQuery("SEL_SLIP_NO"));
						Map map = (Map) selectMap(sql);
						strSlipNo = map.get("SLIP_NO").toString();
						sql.close();
					}else if(strSlipNo.equals("") && !mi.getString("REQ_SLIP_NO").equals("")){
						strSlipNo = mi.getString("REQ_SLIP_NO");
					}
					sql.put(svc.getQuery("INS_OUTREQ"));
					sql.setString(i++, mi.getString("REQ_DT"));				 	// 적용일자
					sql.setString(i++, mi.getString("REQ_STR"));				 	// 신청점
					sql.setString(i++, strSlipNo); 									// 신청번호
					sql.setString(i++, mi.getString("REQ_DT"));				 	// 적용일자
					sql.setString(i++, mi.getString("REQ_STR"));				 	// 신청점
					sql.setString(i++, strSlipNo); 									// 신청번호
					sql.setString(i++, mi.getString("HSTR_CD"));				 	// 발행형태
					sql.setString(i++, mi.getString("GIFT_TYPE_CD"));				 	// 발행형태
					sql.setString(i++, mi.getString("ISSUE_TYPE"));				// 금종
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));				// 금종
					sql.setString(i++, mi.getString("REQ_QTY"));					// 신청수량
					sql.setString(i++, userId);					// 상품권시작번호
					sql.setString(i++, mi.getString("STAT_FLAG"));					// 상품권종료번호
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 
				}else if(!mi.getString("REQ_SEQ_NO").equals("") && !mi.getString("REQ_QTY").equals("0")){
					sql.put(svc.getQuery("UPD_OUTREQ"));
					sql.setString(i++, mi.getString("REQ_QTY"));					// 신청수량
					sql.setString(i++, userId);								// 상품권시작번호
					sql.setString(i++, mi.getString("REQ_DT"));				 	// 적용일자
					sql.setString(i++, mi.getString("REQ_STR"));				 	// 신청점
					sql.setString(i++, mi.getString("REQ_SLIP_NO")); 									// 신청번호
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				 	// 적용일자
				}else if(mi.getString("REQ_QTY").equals("0")){
					sql.put(svc.getQuery("DEL_OUTREQ"));
					sql.setString(i++, mi.getString("REQ_DT"));				 	// 적용일자
					sql.setString(i++, mi.getString("REQ_STR"));				 	// 신청점
					sql.setString(i++, mi.getString("REQ_SLIP_NO")); 									// 신청번호
					sql.put(svc.getQuery("DEL_OUTREQ_SEQ"));
					sql.setString(i++, mi.getString("REQ_SEQ_NO"));				 	// 적용일자
				}
				
				res = update(sql);
				
				if (res == 0) {
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
	
	/**
	 * 지점출고삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
				i=1;
				sql.close();
				sql.put(svc.getQuery("DEL_OUTREQ"));
				sql.setString(i++, form.getParam("strReqDt"));				// 적용일자
				sql.setString(i++, form.getParam("strStrCd"));				// 신청점 	
				sql.setString(i++, form.getParam("strReqSlipNo")); 			// 신청번호
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
		return res;
	}
}
