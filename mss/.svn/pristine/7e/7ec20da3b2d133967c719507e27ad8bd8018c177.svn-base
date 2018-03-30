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

public class MGif502DAO extends AbstractDAO {

	 /**
	 * 상품권 폐기 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDuseMst(ActionForm form,String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strDustlDtFrom = String2.nvl(form.getParam("strDustlDtFrom"));   //폐기일자 fromstrDustlDtTo
		String strDustlDtTo = String2.nvl(form.getParam("strDustlDtTo"));	//폐기일자to
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDUSE_MST") + "\n";
		
		sql.setString(i++, userId);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDustlDtFrom);
		sql.setString(i++, strDustlDtTo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 상품권 폐기 디테일 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDuseDtl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strDustDt = String2.nvl(form.getParam("strDustDt"));   //폐기일자 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDUSE_DTL") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDustDt);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
