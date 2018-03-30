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
 * <p>부정적립예상 통계 조회(브랜드)</p>
 * 
 * @created  on 1.0, 2010.05.29
 * @created  by 강진(FUJITSU KOREA LTD.)
 * @caused   by 부정적립예상 통계 조회(브랜드)
 * 
 */

public class DMbo620DAO extends AbstractDAO {

    /**
     * <p>부정적립예상 통계 조회(브랜드)</p>
     * 
     */    
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util util = new Util();
        int i = 1;
        
        String strS_DT = String2.nvl(form.getParam("S_DT"));
        String strE_DT = String2.nvl(form.getParam("E_DT"));       
        int intS_dt = strS_DT.compareTo("20140519");
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        connect("pot");

        
        //4월29일 이전조회 못하게 강제 막음
        if (intS_dt <= 0) {
        	strS_DT = "20140519";
        }

          
        strQuery = svc.getQuery("SEL_MASTER_01") + "\n";
        
        sql.setString(i++, strS_DT);
        sql.setString(i++, strE_DT);
                         
        sql.put(strQuery);
        ret = select2List(sql);
        
        //ret = util.decryptedStr(ret, 2);  
             
        
        return ret;
    }
    
    /**
     * <p>부정적립예상 통계 상세조회(브랜드)</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        Util util = new Util();
        int i = 1;
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        String strCardNo = String2.nvl(form.getParam("strCardNo")); 
        String strSdt    = String2.nvl(form.getParam("strSdt"));
        String strEdt    = String2.nvl(form.getParam("strEdt")); 
        
        connect("pot");

        sql.setString(i++, strCardNo);
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);

        return ret;
    }        
    
    /**
     * <p>부정적립예상 통계 현황표(브랜드) - REPORT</p>
     * 
     */
    public List httpstore(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null; 
		Util      util  = new Util();
		String strQuery = "";
		int i = 1;
        String strSdt = String2.nvl(form.getParam("strSdt"));
        String strEdt = String2.nvl(form.getParam("strEdt"));       
        String strCnt = String2.nvl(form.getParam("strCnt")); 
        String strAddPoint = String2.nvl(form.getParam("strAddPoint"));
        String strCustType = String2.nvl(form.getParam("strCustType"));        
        String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));        
        
        System.out.println(strSdt);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
  
		connect("pot");

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strCnt);
        sql.setString(i++, strCustType);
        sql.setString(i++, strPumbunCd);        

        strQuery = svc.getQuery("SEL_MASTER_REPORT")+ "\n";
        
        if(!strAddPoint.equals("")){
        	strQuery += svc.getQuery("SEL_MASTER_WHERE_ADD_POINT"); 
        	sql.setString(i++, strAddPoint);
        }
        
		sql.put(strQuery);
	    ret = this.select(sql);
		return ret; 
	}
}

