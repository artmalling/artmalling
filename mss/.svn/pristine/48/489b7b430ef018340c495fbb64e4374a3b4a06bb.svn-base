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

public class MGif311DAO extends AbstractDAO {

	 /**
	 * 자사상품권 회수 비교표 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDrawlMst(ActionForm form,String userId, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strDrawlYmdFrom = String2.nvl(form.getParam("strDrawlYmdFrom"));   //회수일자 from
		String strReqYmdTo = String2.nvl(form.getParam("strDrawlYmdTo"));		//회수일자to
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDRAWL_MASTER") + "\n";
		
		sql.setString(i++, userId);
		sql.setString(i++, orgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDrawlYmdFrom);
		sql.setString(i++, strReqYmdTo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 자사상품권 회수 비교표 디테일 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDrawlDtl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strDrawStr = String2.nvl(form.getParam("strDrawStr"));	//점코드
		String strDrawlDt = String2.nvl(form.getParam("strDrawlDt"));   //회수일자 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDRAWL_DETAIL") + "\n";
		
		sql.setString(i++, strDrawStr);
		sql.setString(i++, strDrawlDt);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 자사상품권 회수 비교표 팝업 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	 @SuppressWarnings("rawtypes")
	public List getGiftDrawlPop(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strDrawStr = String2.nvl(form.getParam("strDrawStr"));	//점코드
		String strDrawlDt = String2.nvl(form.getParam("strDrawlDt"));   //회수일자 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDRAWL_POP") + "\n";
		
		sql.setString(i++, strDrawStr);
		sql.setString(i++, strDrawlDt);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	
}
