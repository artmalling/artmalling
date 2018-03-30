/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dbri.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>회원 매출 객단가 현황(월)</p>
 * 
 * @created  on 1.0, 2010.05.30
 * @created  by 강진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri332DAO extends AbstractDAO {

    /**
     * <p>회원 매출 객단가 현황(월)</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
    	try{
    	List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        

        String strFromENTDate   = String2.nvl(form.getParam("strFromENTDate"));
        String strToENTDate= String2.nvl(form.getParam("strToENTDate"));  
        String strLocalNm= String2.nvl(form.getParam("strLocalNm")); 
        String strOptions= String2.nvl(form.getParam("strOptions"));
                
        if (strOptions.equals("ALL")) {
        	strOptions = "%"; 		
        } else if (strOptions.equals("INMALL")) {
        	strOptions = "C";
        } else {
        	strOptions = "M";
        }
        
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strFromENTDate);		/*가입일자(시작)*/
        sql.setString(i++, strToENTDate);		/*가입일자(종료)*/
        sql.setString(i++, strOptions);			/*조회 옵션*/
        sql.setString(i++, strFromENTDate);		/*가입일자(시작)*/
        sql.setString(i++, strToENTDate);		/*가입일자(종료)*/
      	sql.setString(i++, strOptions);			/*조회 옵션*/
        sql.setString(i++, strFromENTDate);		/*가입일자(시작)*/
        sql.setString(i++, strToENTDate);		/*가입일자(종료)*/
        sql.setString(i++, strLocalNm);			/*지역명*/
        sql.setString(i++, strLocalNm);			/*지역명*/ 
         
        
        strQuery = svc.getQuery("SEL_MASTER");
        //strQuery = svc.getQuery("SEL_MASTER_NEW");
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    	} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
    }
    
    public List searchDetail(ActionForm form) throws Exception {
    	try{
    	List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        

        String strFromENTDate   = String2.nvl(form.getParam("strFromENTDate"));
        String strToENTDate= String2.nvl(form.getParam("strToENTDate"));  
        String strSido= String2.nvl(form.getParam("strSido"));  
        String strSigungu= String2.nvl(form.getParam("strSigungu"));
        String strOptions= String2.nvl(form.getParam("strOptions"));

        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");


        sql.setString(i++, strFromENTDate);
        sql.setString(i++, strToENTDate);
        sql.setString(i++, strOptions);
        sql.setString(i++, strFromENTDate);
        sql.setString(i++, strToENTDate);
        sql.setString(i++, strSido);
        sql.setString(i++, strSigungu);
         
        
        strQuery = svc.getQuery("SEL_DETAIL");
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    	} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
    }
}

