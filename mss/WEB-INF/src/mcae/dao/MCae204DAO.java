/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;


import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
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

public class MCae204DAO extends AbstractDAO {
	/**
	 * 경품행사 응모자 조회 -MASTER
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strSdt		= String2.nvl(form.getParam("strSdt"));   
		String strEdt		= String2.nvl(form.getParam("strEdt"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	} 
	
	/**
	 * 응모자 조회 -MASTER_EVENT
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster_Event(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));    
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MASTER_EVENT") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strEventCd); 
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	} 
	
	/**
	 * 응모자 조회 -DETAIL
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
	
        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();

        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
    		int i = 1; 
    		
    		String strEntryDt	= String2.nvl(form.getParam("strEntryDt"));
    		String strStrCd		= String2.nvl(form.getParam("strStrCd"));  
    		String strEventCd	= String2.nvl(form.getParam("strEventCd"));

    		sql.put(svc.getQuery("SEL_DETAIL"));
    		sql.setString(i++, strEntryDt);  
    		sql.setString(i++, strStrCd); 
    		sql.setString(i++, strEventCd);               
            list = select2List(sql);
            //복호화
          /*list = util.decryptedStr(list,1);	// 주민번호
            list = util.decryptedStr(list,2);	// 전화번호1
            list = util.decryptedStr(list,3);	// 전화번호2
            list = util.decryptedStr(list,4);	// 전화번호3
            list = util.decryptedStr(list,5);	// 휴대폰번호1
            list = util.decryptedStr(list,6);	// 휴대폰번호2
            list = util.decryptedStr(list,7);	// 휴대폰번호3
            list = util.decryptedStr(list,9);	// 이메일주소*/
        } catch (Exception e) {
            throw e;
        }
        return list;
        
	} 
	
	/**
	*  경품행사 응모마스터 삭제
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int delete(ActionForm form, MultiInput mi, String userId) throws Exception {
		
		int ret = 0;
		int res = 0;
		int i = 1;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			
			String strEntryDt   = String2.nvl(form.getParam("strEntryDt"));
			String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			String strEventCd 	= String2.nvl(form.getParam("strEventCd"));  
			
			svc = (Service) form.getService();
			sql.close();
			sql.put(svc.getQuery("DEL_PRMMENTY")); 

			sql.setString(i++, strEntryDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
			res = update(sql);		
  
			ret += res;
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
