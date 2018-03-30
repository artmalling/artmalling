/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

import org.apache.log4j.Logger;

import common.vo.SessionInfo;


/**
 * <p>예제  DAO</p>
 * 
 * @created  on 1.0, 2010/05/23
 * @created  by 조형욱
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal902DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
	private Logger logger = Logger.getLogger(PSal902DAO.class);
	
	/**
	 * <p>
	 * 클럽회원 마스터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MASTER"); // + "\n";
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
    

	/**
     * <p>비용분담율 등록</p>
     * 
     */
    public int save(ActionForm form, MultiInput mi[], String userId) throws Exception {
    	
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null; 
        
        try {
        	connect("pot");
			begin();
			 
			for(int idx = 0 ; idx < 3 ; idx++){
				// CPAYDAY
				if( idx == 0){
					ret = saveCpayDay(form, mi[idx], userId);
				//BRANCH
				}else if ( idx == 1){
					saveBrach(form, mi[idx], userId);					
				}				
			}
        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();	//commit()과 동일
        }
        
        return ret;
    }
    
    /**
     * <p>비용분담율 등록</p>
     * 
     */
    public int saveCpayDay(ActionForm form, MultiInput mi, String userId) throws Exception {
    	
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null; 
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            logger.debug("mi TotalRowNum: "+ mi.getTotalRowNum());
            
            while (mi.next()) {
            	sql.close();
            	logger.debug("IN_UP_CODE: "+ mi.getString("IN_UP_CODE"));
                if (mi.getString("IN_UP_CODE").equals("U")) { // 저장
                    int i=1;   
                    sql.put(svc.getQuery("UPD_CPAYDAY"));
                    sql.setString(i++, mi.getString("PAY_DAY"));       	//매입사입금일
                    sql.setString(i++, userId);                      //로그인ID
                    sql.setString(i++, mi.getString("BCOMP_CD"));     	//매입사코드
                } 
                else if (mi.getString("IN_UP_CODE").equals("I")) {    	//INSERT
                    int i=1;   
                    sql.put(svc.getQuery("INS_CPAYDAY"));
                    sql.setString(i++, mi.getString("BCOMP_CD"));    	//가맹점ID
                    sql.setString(i++, mi.getString("PAY_DAY"));    	//매입사코드
                    sql.setString(i++, userId);               		//로그인ID
                    sql.setString(i++, userId);                   	//로그인ID
                }
                res = update(sql);  
                
                // 
                if (res < 1) {
                	throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
                }
            }
        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();	//commit()과 동일
        }
        
        return ret;
    }
    
    /**
     * <p>비용분담율 등록</p>
     * 
     */
    public int saveBrach(ActionForm form, MultiInput mi, String userId) throws Exception {
    	
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null; 
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();

            
            logger.debug("mi TotalRowNum: "+ mi.getTotalRowNum());
            
            while (mi.next()) {
            	sql.close();
            	//logger.debug("IN_UP_CODE: "+ mi.getString("IN_UP_CODE"));
                //if (mi.getString("IN_UP_CODE").equals("U")) { // 저장
                    int i=1;   
                    sql.put(svc.getQuery("UPD_BRANCH"));
                    sql.setString(i++, mi.getString("PAY_DAY"));       	//매입사입금일
                    //sql.setString(i++, userId);                      //로그인ID
                    sql.setString(i++, mi.getString("BCOMP_CD"));     	//매입사코드
                
                res = update(sql);  
                
                // 
                if (res < 1) {
                	throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
                }
            }
        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();	//commit()과 동일
        }
        
        return ret;
    }
}
