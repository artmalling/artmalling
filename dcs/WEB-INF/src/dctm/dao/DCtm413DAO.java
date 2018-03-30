package dctm.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm413DAO extends AbstractDAO {
	/**
     * <p>주민번호변경이력 조회</p>
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
        String strCustId   = String2.nvl(form.getParam("strCustId"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strSSNo     = String2.nvl(form.getParam("strSSNo"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        if ("".equals(strCustId) && "".equals(strCardNo) && "".equals(strSSNo) )
        {
            sql.setString(i++, strSdt);
            sql.setString(i++, strEdt);   
            strQuery = svc.getQuery("SEL_MASTER2") + "\n"; 
        }
        else
        {
            sql.setString(i++, strSdt);
            sql.setString(i++, strEdt);
            
            strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
            
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
        }
   
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2); 
        //ret = util.decryptedStr(ret, 3); 
        return ret;
    }
}
