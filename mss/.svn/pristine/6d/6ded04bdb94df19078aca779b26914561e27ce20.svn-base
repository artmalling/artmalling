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

public class MGif612DAO extends AbstractDAO {
	/**
	 * 제휴상품권(쿠폰)매출 채권관리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMst(ActionForm form,String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strYm = String2.nvl(form.getParam("strYm"));   //마감년월
		String strVenCd =  String2.nvl(form.getParam("strVenCd"));	//제휴협력사
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_JOINCAL_MST") + "\n";
		
		sql.setString(i++, strYm);
		sql.setString(i++, strStrCd);
		if(!strVenCd.equals("")){
			strQuery += svc.getQuery("SEL_WHERE_VEN_CD") + "\n";
			sql.setString(i++, strVenCd);
		}
		
		strQuery += svc.getQuery("SEL_ORDER") + "\n";
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}

}
