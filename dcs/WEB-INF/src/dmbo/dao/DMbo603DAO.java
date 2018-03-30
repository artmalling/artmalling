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

import com.gauce.GauceDataSet;
import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>영수증적립내역상세조회</p>
 * 
 * @created  on 1.0, 2010.03.25
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo603DAO extends AbstractDAO {

    public List select1(ActionForm form, GauceDataSet dSet) throws Exception {
        List       list  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";

        String BRCH_ID = String2.nvl(form.getParam("BRCH_ID"));
        String CUST_ID = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO   = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO = String2.nvl(form.getParam("CARD_NO"));
        
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        //sql.setString(i++, BRCH_ID); //가맹점
        //sql.setString(i++, BRCH_ID); //가맹점

        strQuery = svc.getQuery("SEL_CUST") + "\n";
        
        if (!String2.isEmpty(String2.trim((SS_NO)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_SS_NO") + "\n";
			sql.setString(i++, SS_NO);
		}
		
		if (!String2.isEmpty(String2.trim((CUST_ID)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_CUST_ID") + "\n";
			sql.setString(i++, CUST_ID);
		}		

		if (!String2.isEmpty(String2.trim((CARD_NO)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_CARD_NO") + "\n";
			sql.setString(i++, CARD_NO);
		}
		
		strQuery += svc.getQuery("SEL_CUSTINFO_ORDER");
        
        sql.put(strQuery);   
        list = select2List(sql);  
        
    /*  list = util.decryptedStr(list, dSet.indexOfColumn("HOME_PH1"));    //집전화1
        list = util.decryptedStr(list, dSet.indexOfColumn("HOME_PH2"));    //집전화2
        list = util.decryptedStr(list, dSet.indexOfColumn("HOME_PH3"));    //집전화3
        list = util.decryptedStr(list, dSet.indexOfColumn("MOBILE_PH1"));  //휴대전화1
        list = util.decryptedStr(list, dSet.indexOfColumn("MOBILE_PH2"));  //휴대전화2
        list = util.decryptedStr(list, dSet.indexOfColumn("MOBILE_PH3"));  //휴대전화3
        list = util.decryptedStr(list, dSet.indexOfColumn("SS_NO"));       //주민번호
        list = util.decryptedStr(list, dSet.indexOfColumn("EMAIL1"));      //EMAIL1
        list = util.decryptedStr(list, dSet.indexOfColumn("EMAIL2"));      //EMAIL2  */
        
        return list; 
    }
    
    
    public List select2(ActionForm form, GauceDataSet dSet, String MBSH_NO_IN) throws Exception {
        List list = null;
        
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";

        
        String CUST_ID      = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO        = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO      = String2.nvl(form.getParam("CARD_NO"));
        String SALE_DT_FROM = String2.nvl(form.getParam("SALE_DT_FROM"));
        String SALE_DT_TO   = String2.nvl(form.getParam("SALE_DT_TO"));
        
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, SALE_DT_FROM); //영업일자 FROM
        sql.setString(i++, SALE_DT_TO);   //영업일자 TO

        strQuery = svc.getQuery("SEL_MASTER"); 
        strQuery += MBSH_NO_IN;
        strQuery += svc.getQuery("SEL_MASTER_ORDER");
        
        sql.put(strQuery);   
        list = select2List(sql);  
        
        return list;
    }
    
    public List select3(ActionForm form, GauceDataSet dSet) throws Exception {
        List list = null;
        
        SqlWrapper sql  = null;
        Service    svc  = null;
        String strQuery = "";

        String STR_CD  = String2.nvl(form.getParam("STR_CD"));
        String SALE_DT = String2.nvl(form.getParam("SALE_DT"));
        String POS_NO  = String2.nvl(form.getParam("POS_NO"));
        String TRAN_NO = String2.nvl(form.getParam("TRAN_NO"));  
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, STR_CD);  //점코드
        sql.setString(i++, SALE_DT); //영업일자
        sql.setString(i++, POS_NO);  //POS번호
        sql.setString(i++, TRAN_NO); //거래번호

        strQuery = svc.getQuery("SEL_DETAIL"); 
        
        sql.put(strQuery);   
        list = select2List(sql);  
        
        return list;
    }
    
    public List select4(ActionForm form, GauceDataSet dSet) throws Exception {
        List list = null;
        
        SqlWrapper sql  = null;
        Service    svc  = null;
        String strQuery = "";

        String STR_CD  = String2.nvl(form.getParam("STR_CD"));
        String SALE_DT = String2.nvl(form.getParam("SALE_DT"));
        String POS_NO  = String2.nvl(form.getParam("POS_NO"));
        String TRAN_NO = String2.nvl(form.getParam("TRAN_NO")); 
        String BRCH_ID = String2.nvl(form.getParam("BRCH_ID"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, STR_CD);  //점코드
        sql.setString(i++, SALE_DT); //영업일자
        sql.setString(i++, POS_NO);  //POS번호
        sql.setString(i++, TRAN_NO); //거래번호
        sql.setString(i++, BRCH_ID); //가맹점번호
        sql.setString(i++, SALE_DT); //영업일자
        sql.setString(i++, POS_NO);  //POS번호
        sql.setString(i++, TRAN_NO); //거래번호
        sql.setString(i++, BRCH_ID); //가맹점번호

        strQuery = svc.getQuery("SEL_DETAIL2"); 
        
        sql.put(strQuery);   
        list = select2List(sql);  
        
        return list;
    }
    
    public List select5(ActionForm form) throws Exception {
        List list = null;
        
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";

        
        String CUST_ID      = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO        = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO      = String2.nvl(form.getParam("CARD_NO"));
        
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;

        strQuery = svc.getQuery("SEL_SUB") + "\n"; 
        
        if (!String2.isEmpty(String2.trim((SS_NO)))){
			strQuery += svc.getQuery("SEL_SUB_SS_NO") + "\n";
			sql.setString(i++, SS_NO);
		}
		
		if (!String2.isEmpty(String2.trim((CUST_ID)))){
			strQuery += svc.getQuery("SEL_SUB_CUST_ID") + "\n";
			sql.setString(i++, CUST_ID);
		}		

		if (!String2.isEmpty(String2.trim((CARD_NO)))){
			strQuery += svc.getQuery("SEL_SUB_CARD_NO") + "\n";
			sql.setString(i++, CARD_NO);
		}
        
        sql.put(strQuery);   
        list = select2List(sql);  
        
        return list;
    }
}
