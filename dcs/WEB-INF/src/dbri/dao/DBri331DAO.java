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
public class DBri331DAO extends AbstractDAO {

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
        
        String strFromBSDate   = String2.nvl(form.getParam("strFromBSDate"));
        String strToBSDate= String2.nvl(form.getParam("strToBSDate"));
        String strFromENTDate   = String2.nvl(form.getParam("strFromENTDate"));
        String strToENTDate= String2.nvl(form.getParam("strToENTDate"));  
        String strStrCd= String2.nvl(form.getParam("strStrCd"));  
  
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strFromBSDate);		/*매출일자(시작)*/
        sql.setString(i++, strToBSDate);		/*매출일자(종료)*/
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strFromBSDate);		/*매출일자(시작)*/
        sql.setString(i++, strToBSDate);		/*매출일자(종료)*/
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strFromENTDate);		/*대비일자(시작)*/
        sql.setString(i++, strToENTDate);		/*대비일자(종료)*/
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strFromENTDate);		/*대비일자(시작)*/
        sql.setString(i++, strToENTDate);		/*대비일자(종료)*/

         
        
        //
        strQuery = svc.getQuery("SEL_MASTER_NEW");
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
        
        String strFromBSDate   = String2.nvl(form.getParam("strFromBSDate"));
        String strToBSDate= String2.nvl(form.getParam("strToBSDate"));
        String strFromENTDate   = String2.nvl(form.getParam("strFromENTDate"));
        String strToENTDate= String2.nvl(form.getParam("strToENTDate"));  
        String strStrCd= String2.nvl(form.getParam("strStrCd"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);
        sql.setString(i++, strFromBSDate);
        sql.setString(i++, strToBSDate);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strFromBSDate);
        sql.setString(i++, strToBSDate);
        
        
        strQuery = svc.getQuery("SEL_DETAIL_PRE") + "\n";
        
        /*
        if (strFromBSDate.equals(strFromENTDate)==true&&strToBSDate.equals(strToENTDate)==true) { // 조회일자와 대비일자가 다르다면 
        	
        }
        else
        {
        	strQuery = strQuery + svc.getQuery("SEL_DETAIL_POST") + "\n";
        	sql.setString(i++, strStrCd);
        	sql.setString(i++, strFromENTDate);
            sql.setString(i++, strToENTDate);
            sql.setString(i++, strStrCd);
        	sql.setString(i++, strFromENTDate);
            sql.setString(i++, strToENTDate);
        }
        */
        strQuery = strQuery + svc.getQuery("SEL_DETAIL_END") ;
        

        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    	} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
    }
}
