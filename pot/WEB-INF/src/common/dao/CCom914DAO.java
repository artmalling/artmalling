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
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>도움말팝업 DAO</p>
 * 
 * @created  on 1.0, 2010/06/21
 * @created  by HSEON(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom914DAO extends AbstractDAO2 {
    /**
     * <p>공지사항을 조회한다.</p>
     * 
     */
	public List selectNotice(ActionForm form) throws Exception {

		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;
        int 		i 		= 0;
        try {
        	String strNoti = String2.nvl(form.getParam("strNoti"));	// 시스템구분
 
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_NOTICE"));  
 
            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strNoti+"&iTable=COM.TC_NOTI&iColumn=NOTI_CONTENT&iSelColumn=NOTI_ID");
            sql.setString(++i, strNoti);
            
    		connect("pot");	
            list = executeQueryByList(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

	/**
     * 공지사항 상세 조회2 : 부문
	 * 
	 * @param form
	 * @return
	 * @throws Exception
     */
    public List selectNoticeDept(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;

    	String strNoti = String2.nvl(form.getParam("strNoti"));	// 시스템구분

        try {
        	
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_NOTICE_DEPT"));
            sql.setString(1, strNoti);

    		connect("pot");	
            list = executeQueryByList(sql);
            
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * 공지사항별 조회한 사용자 존재 여부 확인
     * @param form
     * @return
     * @throws Exception
     */
    public List searchNoticeUserCnt(ActionForm form) throws Exception {
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;
        List	   	list 	= null;

    	String strNoti = String2.nvl(form.getParam("strNoti"));		// 시스템구분
    	String strUserID = String2.nvl(form.getParam("userid"));	// 사용자 id

        try {
        	
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_NOTI_USER_ID"));
            
            sql.setString(1, strNoti);
            sql.setString(2, strUserID);

    		connect("pot");	
    		list = executeQueryByList(sql);
            
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * 공지사항별 조회한 사용자 정보 등록
     * @param form
     * @return
     * @throws Exception
     */
    public int insertNoticeUserID(ActionForm form) throws Exception {
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;
        int ret = 0;

    	String strNoti = String2.nvl(form.getParam("strNoti"));		// 시스템구분
    	String strUserID = String2.nvl(form.getParam("userid"));	// 사용자 id

        try {
        	
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();
    		
    		connect("pot");
    		begin();
            
            sql.put(svc.getQuery("INS_NOTI_USER_ID"));
            
            sql.setString(1, strNoti);
            sql.setString(2, strUserID);

    		ret = executeUpdate(sql);
            
        } catch (Exception e) {
            throw e;
        } finally {
			end();
		}
        
        return ret;
    }
    
}
