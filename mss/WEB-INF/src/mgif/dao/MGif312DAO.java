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
 * <p>가맹점 제휴상품권 회수관리</p>
 * 
 * @created  on 1.0, 2011.08.02
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif312DAO extends AbstractDAO {
	
	/**
	 * 마스터 조회
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
		sql.setString(i++, form.getParam("strSDt"));
		sql.setString(i++, form.getParam("strEDt"));
		sql.setString(i++, form.getParam("strVenCd"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상세 조회
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
		sql.setString(i++, form.getParam("strSlipNo"));
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strDrawlDt"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 가맹점 상품권 회수 등록
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
		
			String strRowStatus = form.getParam("strRowStatus");
			
			if (strRowStatus.equals("1")) { //신규
				sql = new SqlWrapper();
				svc = (Service) form.getService();
				sql.put(svc.getQuery("SEL_DRAWL_SLIP_NO"));
				Map map = (Map) selectMap(sql);
				strSlipNo = map.get("DRAWL_SLIP_NO").toString();
				
				while(mi.next()){
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_MG_BRCHDRAWL")); 
					sql.setString(i++, mi.getString("DRAWL_DT"));
					sql.setString(i++, mi.getString("DRAWL_STR"));
					sql.setString(i++, strSlipNo);
					sql.setString(i++, mi.getString("DRAWL_DT"));
					sql.setString(i++, mi.getString("DRAWL_STR"));
					sql.setString(i++, strSlipNo);
					sql.setString(i++, mi.getString("VEN_CD"));
					sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(i++, mi.getString("DRAWL_QTY"));
					sql.setString(i++, mi.getString("DRAWL_AMT"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					res = update(sql);
		
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
			} else {
				while(mi.next()){
					if (mi.IS_INSERT()) {
						sql.close();
						i = 1;
						sql.put(svc.getQuery("INS_MG_BRCHDRAWL")); 
						sql.setString(i++, mi.getString("DRAWL_DT"));
						sql.setString(i++, mi.getString("DRAWL_STR"));
						sql.setString(i++, mi.getString("DRAWL_SLIP_NO"));
						sql.setString(i++, mi.getString("DRAWL_DT"));
						sql.setString(i++, mi.getString("DRAWL_STR"));
						sql.setString(i++, mi.getString("DRAWL_SLIP_NO"));
						sql.setString(i++, mi.getString("VEN_CD"));
						sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
						sql.setString(i++, mi.getString("ISSUE_TYPE"));
						sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
						sql.setString(i++, mi.getString("DRAWL_QTY"));
						sql.setString(i++, mi.getString("DRAWL_AMT"));
						sql.setString(i++, userId);
						sql.setString(i++, userId);
						res = update(sql);
					} else if (mi.IS_UPDATE()) {
						sql.close();
						i = 1;
						sql.put(svc.getQuery("UPD_MG_BRCHDRAWL")); 
						sql.setString(i++, mi.getString("DRAWL_QTY"));
						sql.setString(i++, mi.getString("DRAWL_AMT"));
						sql.setString(i++, userId);
						sql.setString(i++, mi.getString("SEQ_NO"));
						sql.setString(i++, mi.getString("DRAWL_SLIP_NO"));
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, mi.getString("DRAWL_DT"));
						res = update(sql);
					} else if (mi.IS_DELETE()) {
						sql.close();
						i = 1;
						sql.put(svc.getQuery("DEL_MG_BRCHDRAWL_DTL")); 
						sql.setString(i++, mi.getString("SEQ_NO"));
						sql.setString(i++, mi.getString("DRAWL_SLIP_NO"));
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, mi.getString("DRAWL_DT"));
						res = update(sql);
					}
					
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
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
	
	/**
	 * 가맹점 상품권 회수 삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i =1;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			mi.next();
			sql.close();
			i = 1;
			sql.put(svc.getQuery("DEL_MG_BRCHDRAWL")); 
			sql.setString(i++, mi.getString("DRAWL_SLIP_NO"));
			sql.setString(i++, mi.getString("DRAWL_STR"));
			sql.setString(i++, mi.getString("DRAWL_DT"));
			res = update(sql);

			if (res < 1) {
				throw new Exception("[USER]"+"삭제되지 않았습니다.");
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
	 * 상품권종류 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftTpm(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		String strGiftType 		= String2.nvl(form.getParam("strGiftType"));	//상품권종류
		if (strGiftType.equals("")||strGiftType.equals(null)) strGiftType = "02";
		
		strQuery = svc.getQuery("SEL_MG_GIFTTPMST") + "\n";
		sql.setString(i++, strGiftType);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권금종 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftAmt(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_MG_GIFTAMTMST") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
}
