/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.ArrayList;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
 
 /**
 * <p>사은행사 브랜드 부담예정 현황</p>
 * 
 * @created  on 1.0, 2016/11/18
 * @created  by 윤지영
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 

public class MCae910DAO extends AbstractDAO {
	
	/**
	* 사은행사 브랜드 부담예정 현황
	* 
	* @param form
	* @return
	* @throws Exception
	*/
	public List getEventInfo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();  
		connect("pot");
		
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));		// 점코드
		String strEND_YM	= String2.nvl(form.getParam("strEND_YM"));   	// 행사종료년월	
        String strEventCd	= String2.nvl(form.getParam("strEventCd"));		// 행사정보
         
		strQuery = svc.getQuery("SEL_EVENTINFO");
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEND_YM); 
		sql.setString(i++, strEventCd);
		sql.setString(i++, strEventCd);
		
		ret = select2List(sql);    
        
		return ret;
	}
	
	/**
	* 사은행사 브랜드 부담예정 현황 상세조회
	* 
	* @param form
	* @return
	* @throws Exception
	*/
	public List getDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		ArrayList<List> list 	= new ArrayList<List>();
		ArrayList           al              = null;
		
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();  
		connect("pot");
		
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));		// 점코드
        String strEventCd	= String2.nvl(form.getParam("strEventCd"));		// 행사정보
         
		strQuery = svc.getQuery("SEL_EVENTINFO_DTL");
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd); 
		
		ret = select2List(sql); 
         
		return ret;
	}

}
