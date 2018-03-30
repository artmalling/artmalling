/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>OK캐쉬백상품권 교환 현황표</p>
 * 
 * @created  on 1.0, 2010/03/03
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo639DAO extends AbstractDAO {

	/**
     * <p>상품권 교환 현황표 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util      util  = new Util();
        int i = 1;
        
        String strProcSDt   = String2.nvl(form.getParam("strProcSDt"));
        String strProcEDt   = String2.nvl(form.getParam("strProcEDt"));
        String strBrchId    = String2.nvl(form.getParam("strBrchId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strProcSDt);
        sql.setString(i++, strProcEDt);
        sql.setString(i++, strBrchId);
        sql.setString(i++, strProcSDt);
        sql.setString(i++, strProcEDt);
        
        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,4);     //이동전화1복호화.
		//ret = util.decryptedStr(ret,5);     //이동전화2 복호화.
		//ret = util.decryptedStr(ret,6);     //이동전화3 복호화.
		//ret = util.decryptedStr(ret,7);     //카드번호 복호화.
        return ret;
    }
    
    public List httpstore(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null; 
		Util      util  = new Util();
		String strQuery = "";

		int i = 1;
        String strProcSDt   = String2.nvl(form.getParam("strProcSDt"));
        String strProcEDt   = String2.nvl(form.getParam("strProcEDt"));
        String strBrchId    = String2.nvl(form.getParam("strBrchId"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
  
		connect("pot");

		sql.setString(i++, strProcSDt);
	    sql.setString(i++, strProcEDt);
	    sql.setString(i++, strBrchId);
	    sql.setString(i++, strProcSDt);
	    sql.setString(i++, strProcEDt);
	     
	    strQuery = svc.getQuery("SEL_MASTER_REPORT"); 

		sql.put(strQuery);
	    ret = this.select(sql);
		return ret; 
	}
}

