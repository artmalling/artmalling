/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;


/**
 * <p>공통으로 사용되는 가맹점번호 DAO</p>
 * 
 * @created  on 1.0, 2010/01/24
 * @created  by 조형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom029DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    
    
    
    /**
     * 점별 품번별 행사코드
     *
     * @param  : 
     * @return :              
     */
    public List getBrchCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      String      getSql = "";

      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
           
        mi.next();
//        String allGb   = mi.getString("ALL_GB");
//        
//        if ((allGb.equals("Y")) || (allGb.equals("y"))) {
//            getSql = ("SELECT '%' AS CODE , '전체' AS NAME FROM DUAL   ") + ("\n UNION \n");  
//        }
       
        getSql = getSql + svc.getQuery("SEL_BRCH");
      
        sql.put(getSql);

        sql.setString(1, mi.getString("BCOMP_CD"));              

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }    
}
