/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>점별행사단품조회</p>
 * 
 * @created  on 1.0, 2010/05/16
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod708DAO extends AbstractDAO {


	/**
	 * 행사를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEvtmst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));
		String strEventCd      = String2.nvl(form.getParam("strEventCd"));
		String strEventDtFrom  = String2.nvl(form.getParam("strEventDtFrom"));
		String strEventDtTo    = String2.nvl(form.getParam("strEventDtTo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EVTMST") + "\n"; 	
		sql.setString(i++, strStrCd);
		
		if(strPumbunCd.equals("")) {
			sql.setString(i++, "%");
		} else {
			sql.setString(i++, strPumbunCd);
		}
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventDtFrom);
		sql.setString(i++, strEventDtTo);
		
		if(!strEventCd.equals("")){
			sql.setString(i++, strEventCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_CD") + "\n";	
		}
		
		strQuery += svc.getQuery("SEL_EVTMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 점별행사단품을 조회한다.
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

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strEventCd     = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));


		connect("pot");
		
		strQuery = svc.getQuery("SEL_STREVTSKU")+ "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);

		strQuery += svc.getQuery("SEL_STREVTSKU_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}	
}
