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
 * @created  on 1.0, 2011/03/14
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif316DAO extends AbstractDAO {
	
	  /**
	 * 상품권 판매 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftSaleMst(ActionForm form,String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strSaleDtFrom = String2.nvl(form.getParam("strSaleDtFrom"));   //판매기간 from
		String strSaleDtTo = String2.nvl(form.getParam("strSaleDtTo"));	//판매기간to
		String strSaleFlag = String2.nvl(form.getParam("strSaleFlag"));	//판매 구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_SALE_MST") + "\n";
		
		//sql.setString(i++, userId);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtFrom);
		sql.setString(i++, strSaleDtTo);
		//sql.setString(i++, userId);
		//sql.setString(i++, strStrCd);
		//sql.setString(i++, strSaleDtFrom);
		//sql.setString(i++, strSaleDtTo);
		sql.setString(i++, strSaleFlag);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	  /**
	 * 금종정보 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));   //판매기간 from
		String strSaleSlipNo = String2.nvl(form.getParam("strSaleSlipNo"));	//판매전표번호
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_AMT_MST") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strSaleSlipNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	  /**
	 * 상품권 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDtlAmtMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strSaleDtFrom = String2.nvl(form.getParam("strSaleDtFrom"));   //판매기간 from
		String strSaleDtTo = String2.nvl(form.getParam("strSaleDtTo"));	//판매전표번호
		String strSaleFlag = String2.nvl(form.getParam("strSaleFlag"));	//금종타입
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_AMT_DETAIL") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtFrom);
		sql.setString(i++, strSaleDtTo);
		sql.setString(i++, strSaleFlag);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
}
