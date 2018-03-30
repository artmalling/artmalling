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
 * <p>행사조회</p>
 * 
 * @created  on 1.0, 2010/05/03
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod704DAO extends AbstractDAO {


	/**
	 * 행사코드을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String orgFlag, String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	

	    
		String strEventDtFrom  = String2.nvl(form.getParam("strEventDtFrom"));
		String strEventDtTo    = String2.nvl(form.getParam("strEventDtTo"));
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strEventCd      = String2.nvl(form.getParam("strEventCd"));
		String strEventName    = URLDecoder.decode( String2.nvl(form.getParam("strEventName")), "UTF-8");
		String strEventType    = String2.nvl(form.getParam("strEventType"));
		String strEventMngFlag = String2.nvl(form.getParam("strEventMngFlag"));
		String strEventLCd     = String2.nvl(form.getParam("strEventLCd"));
		String strEventMCd     = String2.nvl(form.getParam("strEventMCd"));
		String strEventSCd     = String2.nvl(form.getParam("strEventSCd"));		

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EVTMST") + "\n";	
		sql.setString(i++, strEventDtFrom);
		sql.setString(i++, strEventDtTo);
		sql.setString(i++, orgFlag);
		sql.setString(i++, userId);

		if( !strStrCd.equals("%")){
			sql.setString(i++, strStrCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_STR_CD") + "\n";
		}
		if( !strEventCd.equals("")){
			sql.setString(i++, strEventCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_CD") + "\n";
		}
		if( !strEventName.equals("")){
			sql.setString(i++, strEventName);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_NAME") + "\n";
		}
		if( !strEventType.equals("%")){
			sql.setString(i++, strEventType);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_TYPE") + "\n";
		}
		if( !strEventMngFlag.equals("%")){
			sql.setString(i++, strEventMngFlag);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_MNG_FLAG") + "\n";
		}
		if( !strEventLCd.equals("%")){
			sql.setString(i++, strEventLCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_L_CD") + "\n";
		}
		if( !strEventMCd.equals("%")){
			sql.setString(i++, strEventMCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_M_CD") + "\n";
		}
		if( !strEventSCd.equals("%")){
			sql.setString(i++, strEventSCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_S_CD") + "\n";
		}

		strQuery += svc.getQuery("SEL_EVTMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
}
