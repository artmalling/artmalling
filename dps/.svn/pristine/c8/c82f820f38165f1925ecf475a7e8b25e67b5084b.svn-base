/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>F&B코너조회 </p>
 * 
 * @created  on 1.0, 2010/05/23
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod904DAO extends AbstractDAO {

	/**
	 * F&B매장메뉴분류  마스터 을 조회한다.
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

		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strFnbShopCd    = String2.nvl(form.getParam("strFnbShopCd"));
		String strMenuFlagCd   = String2.nvl(form.getParam("strMenuFlagCd"));
		String strMenuFlagName = URLDecoder.decode( String2.nvl(form.getParam("strMenuFlagName")), "UTF-8");
		String strUseYn        = String2.nvl(form.getParam("strUseYn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_FNBMENUKIND") + "\n";
		sql.setString(i++, strStrCd);

		if( !strFnbShopCd.equals("%") ){
			sql.setString(i++, strFnbShopCd);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_FNB_SHOP_CD") + "\n";
		}
		if( !strMenuFlagCd.equals("")){
			sql.setString(i++, strMenuFlagCd);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_MENU_FLAG_CD") + "\n";
			
		}
		if( !strMenuFlagName.equals("") ){
			sql.setString(i++, strMenuFlagName);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_MENU_FLAG_NAME") + "\n";
		}
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_FNBMENUKIND_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
