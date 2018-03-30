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
 * <p>아트몰링 추가개발 팝업</p>
 * 
 * @created  on 1.0, 2016/10/25
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom999DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 점별 POS 조회(POPUP, 단건)
     *
     * @param  : 
     * @return :
     */
    public List searchPosNo(ActionForm form, MultiInput mi, String userId , String orgFlag) throws Exception {
      List list      = null;
      SqlWrapper sql = null;
      Service svc    = null;
      int i;
      
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i = 0;
        mi.next();
        
		if(mi.getString("PID").equals("PCOD711")){			// 행사장 POS관리
			sql.put(svc.getQuery("SEL_STR_POS_MST_START1"));
			sql.put(svc.getQuery("SEL_STR_POS_MST_WHERE1"));
			sql.put(svc.getQuery("SEL_STR_POS_MST_ORDER1"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("POS_NO"));
		}
        
        list = select2List(sql);
        sql.close();

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
    /**
     * 점별 브랜드 조회(POPUP, 단건)
     *
     * @param  : 
     * @return :
     */
    public List searchPumbunCd(ActionForm form, MultiInput mi, String userId , String orgFlag) throws Exception {
      List list      = null;
      SqlWrapper sql = null;
      Service svc    = null;
      int i;
      String strQuery = "";

      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i = 0;
        mi.next();

        System.out.println(mi.getString("PID"));
        System.out.println(mi.getString("PID"));
        System.out.println(mi.getString("PID"));
        System.out.println(mi.getString("PID"));
        System.out.println(mi.getString("PID"));
        
		if(mi.getString("PID").equals("PCOD713")){			// 점별 브랜드 조회
			sql.put(svc.getQuery("SEL_STR_PUMBUN_MST_START1"));
			sql.put(svc.getQuery("SEL_STR_PUMBUN_MST_ORDER1"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("PUMBUN_CD"));
			sql.setString(++i, mi.getString("PUMBUN_CD"));
			sql.setString(++i, mi.getString("PUMBUN_NAME"));
			
		}else if(mi.getString("PID").equals("PSAL212")){	// 매출수기등록 품번
			

            strQuery  = svc.getQuery("SEL_STR_PUMBUN_MST_START1") + "\n";
            strQuery += svc.getQuery("WHERE_PUMBUN_TYPE") + "\n";
            strQuery += svc.getQuery("WHERE_SKU_FLAG") + "\n";
            strQuery += svc.getQuery("WHERE_IN_BIZ_TYPE") + "\n";
            strQuery += svc.getQuery("SEL_STR_PUMBUN_MST_ORDER1") + "\n";
            strQuery  = strQuery.replaceAll("_ARR_PARAMS_", mi.getString("BIZE_TYPE"));
            
//            System.out.println("strQuery = " + strQuery);
			sql.put(strQuery);
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("PUMBUN_CD"));
			sql.setString(++i, mi.getString("PUMBUN_CD"));
			sql.setString(++i, mi.getString("PUMBUN_NAME"));
			sql.setString(++i, mi.getString("PUMBUN_TYPE"));
			sql.setString(++i, mi.getString("SKU_FLAG"));
			
		}else if(mi.getString("PID").equals("PSAl213")){	// 매출수기등록 단품
			
			sql.put(svc.getQuery("SEL_STR_PUMBUN_MST_START1"));
			sql.put(svc.getQuery("WHERE_PUMBUN_TYPE"));
			sql.put(svc.getQuery("WHERE_SKU_FLAG"));
			sql.put(svc.getQuery("WHERE_SKU_TYPE"));
			sql.put(svc.getQuery("SEL_STR_PUMBUN_MST_ORDER1"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("PUMBUN_CD"));
			sql.setString(++i, mi.getString("PUMBUN_CD"));
			sql.setString(++i, mi.getString("PUMBUN_NAME"));
			sql.setString(++i, mi.getString("PUMBUN_TYPE"));
			sql.setString(++i, mi.getString("SKU_FLAG"));
			sql.setString(++i, mi.getString("SKU_TYPE"));
		}
        
        list = select2List(sql);
        sql.close();

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
