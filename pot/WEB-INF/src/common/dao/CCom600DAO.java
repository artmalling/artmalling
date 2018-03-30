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
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>공통으로 사용되는 DAO</p>
 * 
 * @created  on 1.0, 2010/03/17
 * @created  by 김재겸
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom600DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 센터코드 조회
     *
     * @param  : 
     * @return :
     */
    public List getCultureCenter(ActionForm form, MultiInput mi, String userId) throws Exception {
        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String strSql = "";
        int i = 0;
        
        try {
            connect("pot");
        
            svc = (Service) form.getService();
            sql = new SqlWrapper();
            
            mi.next();
            
            String strAuthYn = mi.getString("AUTH_YN");
            String strAllCenterYn = mi.getString("ALL_CENTER_YN");
            String strAllYn = mi.getString("ALL_YN");
            String strUseYn = mi.getString("USE_YN");
            
            strSql = svc.getQuery("SEL_HEADER") + "\n";
            
            // 전체 포함
            if (strAllYn.equals("Y")) {
                strSql += svc.getQuery("SEL_ALL_YN") + "\n";
            }
            
            // 전점 포함
            if (strAllCenterYn.equals("Y")) {
                strSql += svc.getQuery("SEL_ALL_CENTER_YN") + "\n";
            }
            
            // 권한
            if (strAuthYn.equals("Y")) {
                strSql += svc.getQuery("SEL_CNTRMST_AUTH") + "\n";
                sql.setString(++i, userId);
            } else {
                strSql += svc.getQuery("SEL_CNTRMST") + "\n";
                
                // 사용여부
                if (strUseYn.equals("Y")) {
                    strSql += svc.getQuery("SEL_COMBO_USE_YN") + "\n";
                }
            }
            
            strSql += svc.getQuery("SEL_TAIL");
            
            sql.put(strSql);
            
            list = select2List(sql);

        } catch (Exception e) {
            throw e;
        }
      
        return list;
    }    
}
