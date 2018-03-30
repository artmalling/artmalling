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
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif603DAO extends AbstractDAO {

	/**
	 * 자사쿠폰 회수내역 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCouPonMst(ActionForm form,String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strYmFrom = String2.nvl(form.getParam("strYmFrom"));   //년월 FROM
		String strYmTo = String2.nvl(form.getParam("strYmTo"));	//년월to
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_COUPON_MST") + "\n";
		
		sql.setString(i++, userId);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYmFrom);
		sql.setString(i++, strYmTo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 자사쿠폰 회수내역 디테일 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCouPonDtl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strYm = String2.nvl(form.getParam("strYm"));   //월
		String strCampaignId = String2.nvl(form.getParam("strCampaignId"));   //월
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_COUPON_USE") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYm);
		sql.setString(i++, strCampaignId);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
