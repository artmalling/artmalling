package dctm.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>회원정보변경 이력조회</p>
 * 
 * @created  on 1.0, 2017.01.03
 * @created  by 윤지영
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 

public class DCtm415DAO extends AbstractDAO {
	
	/**
	* <p>회원정보변경 이력조회</p>
	* 
	*/        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        Util util = new Util();
  
        String strSdt      = String2.nvl(form.getParam("strSdt"));
        String strEdt      = String2.nvl(form.getParam("strEdt"));
        String strSearchgbn = String2.nvl(form.getParam("strSearchgbn"));
        String strCustId   = String2.nvl(form.getParam("strCustId"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strSSNo     = String2.nvl(form.getParam("strSSNo"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
     
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        
        //조회구분에 따라 조회 
        //(1: 회원명 , 2:주소, 3:생년월일, 4:휴대전화, 5:카드번호)
        if(strSearchgbn.equals("1")){  
        	strQuery = svc.getQuery("SEL_MASTER_CUST") + "\n";  
        } else if (strSearchgbn.equals("2")){ 
        	strQuery = svc.getQuery("SEL_MASTER_ADDR") + "\n";  
        } else if (strSearchgbn.equals("3")){ 
        	strQuery = svc.getQuery("SEL_MASTER_SSNO") + "\n";  
        } else if (strSearchgbn.equals("4")){ 
        	strQuery = svc.getQuery("SEL_MASTER_MOBILE") + "\n";  
        } else if (strSearchgbn.equals("5")){ 
        	strQuery = svc.getQuery("SEL_MASTER_CARD") + "\n";  
        }
        
        if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSSNo)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSSNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
       
   
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
}
