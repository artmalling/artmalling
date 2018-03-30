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
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import common.util.Util;
import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/02/25
 * @created  by (FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo102DAO extends AbstractDAO {

	/**
     * <p>회원별 에누리 한도  마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        String strCustId    = String2.nvl(form.getParam("strCustId"));
        String strAppYear    = String2.nvl(form.getParam("strAppYear"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService();  
 
        connect("pot");
        
         
        sql.setString(i++, strCustId);
        sql.setString(i++, strAppYear);

        strQuery = svc.getQuery("SEL_MASTER"); 

        sql.put(strQuery);   
        ret = select2List(sql); 
        
        return ret; 
    }
    
    /**
     * <p>회원별 에누리 한도  디테일 조회</p>
     * 
     */
    public List searchDetail(ActionForm form, String userId) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        String strCustId    = String2.nvl(form.getParam("strCustId"));
        String strAppYear   = String2.nvl(form.getParam("strAppYear"));
        String strBrchId    = String2.nvl(form.getParam("strBrchId"));
        String strNewFlag   = String2.nvl(form.getParam("strNewFlag"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        if(strNewFlag.equals("Y")){
        	sql.setString(i++, strCustId); 
            sql.setString(i++, strAppYear);
            sql.setString(i++, userId);            
        	sql.setString(i++, strBrchId);
            sql.setString(i++, strCustId); 
            sql.setString(i++, strAppYear); 

            strQuery = svc.getQuery("SEL_DETAIL_NEW");
        }else{
        	sql.setString(i++, strBrchId);
            sql.setString(i++, strCustId); 
            sql.setString(i++, strAppYear); 

            strQuery = svc.getQuery("SEL_DETAIL");
        }
        
        sql.put(strQuery);   
        ret = select2List(sql); 
        
                   
        
        
        return ret; 
    }
    
    /**
     * <p>회원별 에누리 한도  저장</p>
     * 
     */
    public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {
   
		int ret = 0;
		int res = 0;
		int resD = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		
		String orgCdCnt = "";

		int i;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
		
			while (mi.next()) {
				sql.close();
				
				
				if (mi.IS_INSERT()) {					
					
				} else if (mi.IS_UPDATE()) {
					String flag = mi.getString("FLAG");
					
					i = 0;
					System.out.println(flag + "FLAG");
					if(flag.equals("S")){ //변경등록(Update)
						sql.put(svc.getQuery("UPD_DC_HANDO"));
						
						sql.setString(++i, mi.getString("DC_HANDO_AMT"));
						sql.setString(++i, mi.getString("HANDO_MOD_ID"));
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("CUST_ID"));
						sql.setString(++i, mi.getString("APP_YEAR"));
						
					}else if(flag.equals("N")){   //신규등록(Insert)
						sql.put(svc.getQuery("INS_DC_HANDO"));
						
						sql.setString(++i, mi.getString("CUST_ID"));
						sql.setString(++i, mi.getString("APP_YEAR"));
						sql.setString(++i, mi.getString("DC_HANDO_AMT"));
						sql.setString(++i, mi.getString("HANDO_USED_AMT"));
						sql.setString(++i, mi.getString("HANDO_MOD_ID"));
						sql.setString(++i, strID);
						sql.setString(++i, strID);
					}
		
					res = update(sql);
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여" +
								"데이터 입력을 하지 못했습니다.");
						
					//데이터 신규 입력 및 수정 입력 시 
					}					
					
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("SEL_HIST_COUNT"));							
					sql.setString(++i, mi.getString("CUST_ID"));
					sql.setString(++i, mi.getString("APP_YEAR"));
					sql.setString(++i, mi.getString("HANDO_MOD_DT"));
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					System.out.println(orgCdCnt);
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"한도 변경은 하루에 한번만 가능합니다.");
					}
					sql.close();
					
					i = 0;
					
					sql.put(svc.getQuery("INS_DC_HANDO_HIST"));
					
					sql.setString(++i, mi.getString("CUST_ID"));
					sql.setString(++i, mi.getString("APP_YEAR"));
					if(flag.equals("N")){
						sql.setString(++i, mi.getString("DC_HANDO_AMT"));
					}else{
						sql.setString(++i, mi.getString("MOD_DC_HANDO_AMT"));
					}
					sql.setString(++i, mi.getString("DC_HANDO_AMT"));
					sql.setString(++i, mi.getString("MOD_REASON"));
					sql.setString(++i, strID);
					
					res = update(sql);
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여" +
								"데이터 입력을 하지 못했습니다.");
					}
					
					ret += res;
				}
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
