/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>저장품재고현황</p>
 * 
 * @created  on 1.0, 2010/06/02
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

/*
 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
 */
public class PStk405DAO extends AbstractDAO {
	
	/**
	 * 저장품재고조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
    public List searchMaster(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));       //점
		String strFromDt     = String2.nvl(form.getParam("strFromDt"));      //기간(from)
		String strToDt       = String2.nvl(form.getParam("strToDt"));        //기간(to)
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));       //협력사
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));    //품번
		String strSkuCd      = String2.nvl(form.getParam("strSkuCd"));  //단품
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		// 기간 내 수량 조회
		strQuery = "WITH TERM_STOREGOOD AS(" +  "\n";
		strQuery += svc.getQuery("WITH_SEL_TERM_STOREGOOD") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("WITH_SEL_STOREGOOD_WHERE_VEN_CD") + "\n";
		}
		if( !strSkuCd.equals("")){
			sql.setString(i++, strSkuCd);
			strQuery += svc.getQuery("WITH_SEL_STOREGOOD_WHERE_SKU_CD") + "\n";
		}
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("WITH_SEL_STOREGOOD_WHERE_PUMBUN_CD") + "\n";
		}
		strQuery += svc.getQuery("WITH_SEL_STOREGOOD_GROUP") +  "\n";

		// 기간 전 수량 조회
		strQuery += "), BAS_STOREGOOD AS(" +  "\n";

		strQuery += svc.getQuery("WITH_SEL_BAS_STOREGOOD") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);

		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("WITH_SEL_STOREGOOD_WHERE_VEN_CD") + "\n";
		}
		if( !strSkuCd.equals("")){
			sql.setString(i++, strSkuCd);
			strQuery += svc.getQuery("WITH_SEL_STOREGOOD_WHERE_SKU_CD") + "\n";
		}
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("WITH_SEL_STOREGOOD_WHERE_PUMBUN_CD") + "\n";
		}
		strQuery += svc.getQuery("WITH_SEL_STOREGOOD_GROUP") +  "\n";

		strQuery += ")" +  "\n";
		
		// 테이블에 맞게 조회
		strQuery += svc.getQuery("SEL_STOREGOOD");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }
}
