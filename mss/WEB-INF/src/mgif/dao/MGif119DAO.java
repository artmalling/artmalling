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
 * <p>자사상품권 종류 마스터 등록</p>
 * 
 * @created  on 1.0, 2011/03/24
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MGif119DAO extends AbstractDAO {
	/**
	 * <p>상품권종류</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub_Type(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
		
			sql.put(svc.getQuery("SEL_GIFT_TYPE_CD"));
			list = select2List(sql);	
		 
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>상품권종류</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub_Amt(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			
			String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));
			
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
			connect("pot");
			 
			sql.setString(1, strGiftTypeCd);
		
			sql.put(svc.getQuery("SEL_GIFT_AMT_TYPE"));
			list = select2List(sql);	
		 
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	

	public List searchMaster(ActionForm form) throws Exception {

        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String strQuery = "";
        int i = 1;

        // 파라미터
        
        String strGiftType 	= String2.nvl(form.getParam("strGiftType"));
        String strSdts 		= String2.nvl(form.getParam("strSdts"));
        String strEdte 		= String2.nvl(form.getParam("strEdte"));
        String strAmtType 	= String2.nvl(form.getParam("strAmtType"));
        String strGiftNo 	= String2.nvl(form.getParam("strGiftNo"));
        String strUseStorCd	= String2.nvl(form.getParam("strUseStorCd"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        strQuery = svc.getQuery("SEL_MASTER_SEARCH");
        
        sql.setString(i++, strGiftNo);
        sql.setString(i++, strUseStorCd);
        sql.setString(i++, strSdts);
        sql.setString(i++, strEdte);
        sql.setString(i++, strGiftType);
        sql.setString(i++, strAmtType);
        
        sql.put(strQuery);
        
        // SELECT목록
        list = select2List(sql);

        return list;
    }
	
	
}
