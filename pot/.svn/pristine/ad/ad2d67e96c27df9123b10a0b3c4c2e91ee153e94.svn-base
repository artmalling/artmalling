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
import kr.fujitsu.ffw.util.String2;


/**
 * <p>OFFER SHEET DAO</p> 
 * 
 * @created  on 1.0, 2010/03/24
 * @created  by 정진영
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */  

public class CCom023DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * OFFER SHEET HEADER 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOffmst(ActionForm form, MultiInput mi ) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;   
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();        
        i=0;
        mi.next();
        sql.put(svc.getQuery("SEL_OFFMST"));
        sql.setString(++i, mi.getString("STR_CD"));
        sql.setString(++i, mi.getString("OFFER_FROM_DT"));
        sql.setString(++i, mi.getString("OFFER_TO_DT"));
        sql.setString(++i, mi.getString("OFFER_SHEET_NO"));
        sql.setString(++i, mi.getString("PUMBUN_CD"));
        sql.setString(++i, mi.getString("PUMBUN_NAME"));
        sql.setString(++i, mi.getString("VEN_CD"));
        sql.setString(++i, mi.getString("VEN_NAME"));

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
    /**
     * OFFER SHEET DETAIL 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOffdtl(ActionForm form ) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i;
      try {
        connect("pot"); 
        svc = (Service) form.getService();
        sql = new SqlWrapper();        
        i=0;
        
        String strStrCd       = String2.nvl(form.getParam("strStrCd"));
        String strOfferYm     = String2.nvl(form.getParam("strOfferYm"));
        String strOfferSeqNo  = String2.nvl(form.getParam("strOfferSeqNo"));
        
        sql.put(svc.getQuery("SEL_OFFDTL"));
        sql.setString(++i, strStrCd);
        sql.setString(++i, strOfferYm);
        sql.setString(++i, strOfferSeqNo);
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
