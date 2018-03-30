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
 * <p>F&B매장조회</p>
 * 
 * @created  on 1.0, 2010/05/23
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod902DAO extends AbstractDAO {

	/**
	 * F&B매장 마스터 을 조회한다.
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
		String strVenCd        = String2.nvl(form.getParam("strVenCd"));
		String strVenName      = URLDecoder.decode( String2.nvl(form.getParam("strVenName")), "UTF-8");
		String strFnbShopCd    = String2.nvl(form.getParam("strFnbShopCd"));
		String strFnbShopName  = URLDecoder.decode( String2.nvl(form.getParam("strFnbShopName")), "UTF-8");
		String strChnalFlag    = String2.nvl(form.getParam("strChnalFlag"));
		String strFnbFlag      = String2.nvl(form.getParam("strFnbFlag"));
		String strFnbBizKind   = String2.nvl(form.getParam("strFnbBizKind"));
		String strUseYn        = String2.nvl(form.getParam("strUseYn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_FNBSHOPMST") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_VEN_CD") + "\n";
			
		}
		if( !strVenName.equals("") ){
			sql.setString(i++, strVenName);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_VEN_NAME") + "\n";
		}
		if( !strFnbShopCd.equals("") ){
			sql.setString(i++, strFnbShopCd);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_FNB_SHOP_CD") + "\n";
		}
		if( !strFnbShopName.equals("") ){
			sql.setString(i++, strFnbShopName);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_FNB_SHOP_NAME") + "\n";
		}
		if( !strChnalFlag.equals("%") ){
			sql.setString(i++, strChnalFlag);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_CHNAL_FLAG") + "\n";
		}

		if( !strFnbFlag.equals("%") ){
			sql.setString(i++, strFnbFlag);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_FNB_FLAG") + "\n";
		}

		if( !strFnbBizKind.equals("%") ){
			sql.setString(i++, strFnbBizKind);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_FNB_BIZ_KIND") + "\n";
		}
		
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_FNBSHOPMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
