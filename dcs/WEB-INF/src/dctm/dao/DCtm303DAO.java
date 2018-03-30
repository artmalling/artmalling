/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>소멸예정포인트조회</p>
 * 
 * @created  on 1.0, 2010/03/22
 * @created  by 김영진
 * 
 * @modified on  
 * @modified by 
 * @caused   by 
 */ 

public class DCtm303DAO extends AbstractDAO {

	/**
     * <p>소멸예정포인트조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        
        String strAddYm    = String2.nvl(form.getParam("strAddYm"));
        sql = new SqlWrapper();
        svc = (Service) form.getService();
 
        connect("pot"); 
         
        //if(strSrchGubun.equals("1")){
        strQuery = svc.getQuery("SEL_MONTH_MASTER"); 
        //}else if(strSrchGubun.equals("2")){
        //    strQuery = svc.getQuery("SEL_MONTH_MASTER");
        //} 
        
        sql.setString(i++, strAddYm); 
        sql.setString(i++, strAddYm); 
        sql.setString(i++, strAddYm);
        sql.setString(i++, strAddYm); 
        sql.setString(i++, strAddYm);
     
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        //if(strSrchGubun.equals("1")){
        //ret = util.decryptedStr(ret,3); //카드번호 복호화.
        //ret = util.decryptedStr(ret,9); //이동전화번호1 복호화.
        //ret = util.decryptedStr(ret,10); //이동전화번호2 복호화.
        //ret = util.decryptedStr(ret,11); //이동전화번호3 복호화.
        //ret = util.decryptedStr(ret,12); //이메일1 복호화.
        //ret = util.decryptedStr(ret,14); //이메일2 복호화.
        //}
        return ret; 
    }
}

