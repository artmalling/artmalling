/*
 * Copyrigh606t (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
//import java.util.Map;

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

public class DMtc606DAO extends AbstractDAO {
	
	/**
     * <p>일변 POS 마감 조회</p>
     * 
     */        
    public List searchList(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt       = String2.nvl(form.getParam("strSdt"));
        
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        connect("pot");
        System.out.println("222222");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        
        
        //sql.setString(i++, strSdt);
        //sql.setString(i++, strSdt);
        //sql.setString(i++, strSdt);
        //sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        sql.setString(i++, strSdt);
        
        System.out.println("33333333");
        
        sql.put(strQuery);
        System.out.println("4444444");
        System.out.println(sql);
        ret = select2List(sql);
        System.out.println("5555555");
        return ret;
    }
}
