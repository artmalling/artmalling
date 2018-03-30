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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif408DAO extends AbstractDAO {
	
	
	/**
	 * 상품권 종류 조회
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
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_CHECK") + "\n";
		
		sql.put(strQuery);
		sql.setString(i++, form.getParam("strGiftCardNo"));
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권 종류 조회
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
		strQuery = svc.getQuery("SEL_GIFT_TYPE_CD") + "\n";
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 금종 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftAmtCd(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권종류 코드
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_AMT_CD") + "\n";
		
		sql.setString(i++, strGiftTypeCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권 번호에 대한 그리드 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftAmtMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권종류 코드
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));
		String strGiftAmtCd = String2.nvl(form.getParam("strGiftAmtCd"));
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));
		String strGiftCardENo = String2.nvl(form.getParam("strGiftCardENo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_AMT_MST") + "\n";
		
		sql.setString(i++, strGiftTypeCd);
		sql.setString(i++, strGiftAmtCd);
		sql.setString(i++, strGiftCardNo); 
		sql.setString(i++, strGiftCardENo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}

	/**
	 * 상품권 번호에 대한 상세 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권번호
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_MST") + "\n";
		
		sql.setString(i++, strGiftCardNo);
		sql.setString(i++, strGiftCardNo);
		sql.put(strQuery);
		
		
		System.out.println("strQuery : " + strQuery);
		System.out.println("strGiftCardNo : " + strGiftCardNo);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권 번호에 대한 판매정보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권번호
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_SALE_MST") + "\n";
		
		sql.setString(i++, strGiftCardNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}  
	 
	/**
	 * 상품권 번호에 대한 회수정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDrawl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권번호
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_DRAWL") + "\n";
		
		sql.setString(i++, strGiftCardNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	/**
	 * 상품권 번호에 대한 영수증 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */

	public List getReceipt(ActionForm form) throws Exception{
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권 번호
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_PS_DISITEM") + "\n";
		sql.setString(i++, strGiftCardNo);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	/**
	 * 상품권 번호에 대한 재사용내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftReuse(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		//상품권번호
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_GIFTREUSE") + "\n";
		
		sql.setString(i++, strGiftCardNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
}
