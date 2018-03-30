/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.net.URLDecoder;
import java.util.List;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2010/05/23
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom027DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 카드발급사 조회
     *
     * @param  : 
     * @return :
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strCcompCd = String2.nvl(form.getParam("strCcompCd"));
        String strCcompNm     = String2.nvl(form.getParam("strCcompNm"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strCcompCd);
        sql.setString(i++, strCcompNm);
        
        strQuery = svc.getQuery("SEL_MASTER"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
}
