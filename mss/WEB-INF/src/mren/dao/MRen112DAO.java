/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package mren.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>계량기시설구분등록</p>
 * 
 * @created  on 1.0, 2010.05.20
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen112DAO extends AbstractDAO {

	 /**
     * <p>계량기시설구분 내역조회</p>
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            sql.put(svc.getQuery("SEL_MR_GAUGMST"));
            
            sql.setString(++i, URLDecoder.decode(String2.nvl(form.getParam("strInstPlc")), "UTF-8"));	// [조회용]설치장소       	       
            sql.setString(++i, String2.nvl(form.getParam("strGaugID")));	// [조회용]계량기ID              
            sql.setString(++i, String2.nvl(form.getParam("strGaugType"))); 	// [조회용]계량기구분             
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>계량기시설구분 저장</p>
     */
    public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc = null;
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            while (mi.next()) {
            	sql.close();

            	sql.put(svc.getQuery("UPD_MR_GAUGMST"));
				int i = 0;
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("GAUG_KIND_CD"));
				sql.setString(++i, userID); 
				sql.setString(++i, mi.getString("GAUG_ID"));
				res = update(sql);
                    
                if (res != 1) {
                	throw new Exception("" + "데이터의 적합성 문제로 인하여"
                			+ "데이터 입력을 하지 못했습니다.");
                }

                ret += res;
            }
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
        return ret;
    }
    
	/**
	 * <p>공통코드</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper();
			int i = 0;
			String strEtcCode	= String2.nvl(form.getParam("strEtcCode"));	// 공통코드(코드)
			
			sql.put(svc.getQuery("SEL_TC_COMMCODE"));
			sql.setString(++i, strEtcCode);              
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
