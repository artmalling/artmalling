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
 * <p>지점입고 확정</p>
 * 
 * @created  on 1.0, 2011/04/27
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif205DAO extends AbstractDAO {
	/**
	 * 지점입고 확정  마스터 조회
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
		
		String strReqStr = String2.nvl(form.getParam("strReqStr"));	//점코드
		String strHStr = String2.nvl(form.getParam("strHStr"));	//점코드
		String strSdt = String2.nvl(form.getParam("strSdt"));   	//일자 from
		String strEdt = String2.nvl(form.getParam("strEdt"));		//일자to
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strReqStr);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strHStr);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점입고 확정 디테일 조회
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
		String strOutDt = String2.nvl(form.getParam("strOutDt"));	//입고일자
		String strOutStr = String2.nvl(form.getParam("strOutStr"));   //점코드
		String strOutSlipNo = String2.nvl(form.getParam("strOutSlipNo"));		//발행순번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strOutStr);
		sql.setString(i++, strOutDt);
		sql.setString(i++, strOutSlipNo);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점입고 확정 내역 조회
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
		sql.setString(1, String2.nvl(form.getParam("strGiftNo")));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지점입고 확정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			mi[0].next();
			i=1;
			sql.close();
			sql.put(svc.getQuery("UPD_OUTREQCONF"));
			sql.setString(i++, form.getParam("strInConfDt"));				 	// 발행형태
			sql.setString(i++, userId);	
			sql.setString(i++, mi[0].getString("OUT_STR"));				// 발행형태
			sql.setString(i++, mi[0].getString("OUT_DT"));				// 발행형태
			sql.setString(i++, mi[0].getString("OUT_SLIP_NO"));				// 발행형태
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			while(mi[1].next()){
				i=1;
				sql.close();
				sql.put(svc.getQuery("UPD_GIFTMST"));
				sql.setString(i++, form.getParam("strInConfDt"));				 	// 입고일
				sql.setString(i++, mi[1].getString("REQ_STR"));						// 입고점
				sql.setString(i++, userId);											// 입고자사번
				sql.setString(i++, userId);											// 수정자
				sql.setString(i++, mi[1].getString("GIFT_S_NO"));				// 시작번호
				sql.setString(i++, mi[1].getString("GIFT_E_NO"));				// 종료번호
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
