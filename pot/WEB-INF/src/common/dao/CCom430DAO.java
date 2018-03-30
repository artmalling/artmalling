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
 * <p>
 * * 우편번호 조회 팝업(신주소/구주소)
 * </p>
 * 우편번호 조회 팝업화면 DAO
 * 
 * @created on 1.0, 2010/05/11
 * @created by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom430DAO extends AbstractDAO {
	/**
	 * 조회조건으로  구주소 조회
	 * 
	 * @param form
	 * @param mi
	 *            : 코드/코드명
	 * @return List : 분류 코드 조회 결과
	 */
	public List getOldAddr(ActionForm form, MultiInput mi) throws Exception {
		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
		
		mi.next();
		connect("pot");
		
		svc = (Service) form.getService();
		sql = new SqlWrapper();
        int i = 1;
        
        sql.put(svc.getQuery("SEL_ADDR"));
        sql.setString(i++, mi.getString("ADDR1"));
		sql.setString(i++, mi.getString("ADDR1"));
		sql.setString(i++, mi.getString("ADDR1"));
		
		ret = select2List(sql);
		return ret;
	} 

	
	/**
	 * 조회조건으로 신주소 조회
	 * 
	 * @param form
	 * @param mi
	 *            : 코드/코드명
	 * @return List : 분류 코드 조회 결과
	 */
	public List getNewAddr(ActionForm form, MultiInput mi) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		String adrQuery = "";

		mi.next();
		
		connect("pot");
		
		svc = (Service) form.getService();
		sql = new SqlWrapper();
        int i = 1;
        
        sql.put(svc.getQuery("SEL_NEW_ADDR"));
        
        if (mi.getString("BLDG1").length() > 0) 
        	sql.put(svc.getQuery("SEL_NEW_ADDR_BLDG1"));
        
        if (mi.getString("BLDG2").length() > 0) 
        	sql.put(svc.getQuery("SEL_NEW_ADDR_BLDG2"));
        
        sql.put(svc.getQuery("SEL_NEW_ADDR_ORDERBY"));
        
		
		sql.setString(i++, mi.getString("ROAD_NM"));
		sql.setString(i++, mi.getString("SI_DO"));
		sql.setString(i++, mi.getString("SI_GUN_GU"));
		
		
		if (mi.getString("BLDG1").length() > 0) 
			sql.setInt(i++, Integer.parseInt(mi.getString("BLDG1")));
		
		if (mi.getString("BLDG2").length() > 0) 
			sql.setInt(i++, Integer.parseInt(mi.getString("BLDG2")));
		
		ret = select2List(sql);

		return ret;
	}

    /**
     * <p>시도 / 시군구 콤보 처리</p>
     * 
     */
    public List getEtcCode(ActionForm form, MultiInput mi) throws Exception {
        List list      = null;
        SqlWrapper sql = null;
        Service svc    = null; 
        String  getSql = "";

        try {
            connect("pot");
            svc = (Service) form.getService();
            sql = new SqlWrapper();
            mi.next();
            String allGb      = mi.getString("ALL_GB");
            String nulGb      = mi.getString("NUL_GB");
            String strSidoNew = mi.getString("SIDO_NEW");
            
            if(!strSidoNew.equals("ALL")){
                getSql = getSql + svc.getQuery("SEL_ETC_CODE2");
                sql.setString(1, strSidoNew);
            }else{
                getSql = getSql + svc.getQuery("SEL_ETC_CODE");
            }
      
            sql.put(getSql);
 
            list = select2List(sql);

        } catch (Exception e) {
            throw e;
        }
        return list;
    }  
}
