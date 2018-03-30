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
 * @created  on 1.0, 2011.08.05
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif313DAO extends AbstractDAO {

	 /**
	 * 상품권 재사용내역 조회 마스터 조회
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
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));		//점코드
		String strReqYmdFrom 	= String2.nvl(form.getParam("strReqYmdFrom"));	//입고 from
		String strReqYmdTo 		= String2.nvl(form.getParam("strReqYmdTo"));	//입고to
		String strGiftCd 		= String2.nvl(form.getParam("strGiftCd"));		//입고to
		String strGiftType 		= String2.nvl(form.getParam("strGiftType"));	//상품권종류
		String strGiftAmt 		= String2.nvl(form.getParam("strGiftAmt"));		//금종
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_GIFTREUSE_MASTER") + "\n";
		sql.setString(i++, strGiftAmt);
		sql.setString(i++, strGiftType);
		sql.setString(i++, strGiftCd);
		sql.setString(i++, strReqYmdFrom);
		sql.setString(i++, strReqYmdTo);
		sql.setString(i++, strStrCd);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 상품권 재사용내역 조회 디테일 조회
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
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));		//점코드
		String strReqYmdFrom 	= String2.nvl(form.getParam("strReqYmdFrom"));	//입고 from
		String strReqYmdTo 		= String2.nvl(form.getParam("strReqYmdTo"));	//입고to
		String strGiftCd 		= String2.nvl(form.getParam("strGiftCd"));		//입고to
		String strGiftType 		= String2.nvl(form.getParam("strGiftType"));	//상품권종류
		String strGiftAmt 		= String2.nvl(form.getParam("strGiftAmt"));		//금종
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_GIFTREUSE_DETAIL") + "\n";
		
		sql.setString(i++, strGiftAmt);
		sql.setString(i++, strGiftType);
		sql.setString(i++, strGiftCd);
		sql.setString(i++, strReqYmdFrom);
		sql.setString(i++, strReqYmdTo);
		sql.setString(i++, strStrCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
