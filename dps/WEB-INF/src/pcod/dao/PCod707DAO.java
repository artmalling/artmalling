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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
//import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>품번행사조회</p>
 * 
 * @created  on 1.0, 2010/05/03
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod707DAO extends AbstractDAO {

	
	/**
	 * 점별행사품번을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strID, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		String strEventDtFrom = String2.nvl(form.getParam("strEventDtFrom"));
		String strEventDtTo   = String2.nvl(form.getParam("strEventDtTo"));
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strEventCd     = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
		String strPumbunName  = URLDecoder.decode(String2.nvl(form.getParam("strPumbunName")), "UTF-8");


		connect("pot");
		
		strQuery = svc.getQuery("SEL_STREVTPBN")+ "\n";
		sql.setString(i++, strEventDtFrom);
		sql.setString(i++, strEventDtTo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);

		if( !strEventCd.equals("")){
			sql.setString(i++, strEventCd);
			strQuery += svc.getQuery("SEL_STREVTPBN_WHERE_EVENT_CD") + "\n";
		}
		
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_STREVTPBN_WHERE_PUMBUN_CD") + "\n";
		}

		if( !strPumbunName.equals("")){
			sql.setString(i++, strPumbunName);
			strQuery += svc.getQuery("SEL_STREVTPBN_WHERE_PUMBUN_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_STREVTPBN_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}	
}
