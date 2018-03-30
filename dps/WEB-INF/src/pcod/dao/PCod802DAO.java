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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>POS조회</p>
 * 
 * @created  on 1.0, 2010/05/02
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod802DAO extends AbstractDAO {

	/**
	 * POS 마스터 을 조회한다.
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

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strPosName = URLDecoder.decode( String2.nvl(form.getParam("strPosName")), "UTF-8");
		String strShopName = URLDecoder.decode( String2.nvl(form.getParam("strShopName")), "UTF-8");
		String strMstPosNo = String2.nvl(form.getParam("strMstPosNo"));
		String strMstPosName = URLDecoder.decode( String2.nvl(form.getParam("strMstPosName")), "UTF-8");
		String strPosFlag = String2.nvl(form.getParam("strPosFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_POSMST") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strPosNo.equals("") ){
			sql.setString(i++, strPosNo);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_POS_NO") + "\n";
		}
		if( !strPosName.equals("") ){
			sql.setString(i++, strPosName);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_POS_NAME") + "\n";
		}
		if( !strShopName.equals("") ){
			sql.setString(i++, strShopName);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_SHOP_NAME") + "\n";
		}
		if( !strPosFlag.equals("%") ){
			sql.setString(i++, strPosFlag);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_POS_FLAG") + "\n";
		}
		if( !strMstPosNo.equals("") ){
			sql.setString(i++, strMstPosNo);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_MST_POS_NO") + "\n";
		}
		if( !strMstPosName.equals("") ){
			sql.setString(i++, strMstPosName);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_MST_POS_NAME") + "\n";
		}
		strQuery += svc.getQuery("SEL_POSMST_ORDER") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
