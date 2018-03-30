/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>배치실행로그</p>
 *  
 * @created  on 1.0, 2010/07/28
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom303DAO extends AbstractDAO { 

	/**
	 *  시스템구분 별 배치코드를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectBatchCd(ActionForm form) throws Exception {
		
		List list 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i = 0;	 

        try { 
        	// 시스템구분 
			String strSysGbn = String2.nvl(form.getParam("strSysGbn"));
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			sql.put(svc.getQuery("SEL_BATCH"));
			sql.setString(++i, strSysGbn);
			 
			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	} 
	/**
	 *  배치로그 리스트를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectList(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try { 
 
			String strSys 		= String2.nvl(form.getParam("strSys"));		//시스템구분
			String strBatch   	= String2.nvl(form.getParam("strBatch"));	//프로세스id 	 
			String strSdate    	= String2.nvl(form.getParam("strSdate"));	//기간 1
			String strEdate    	= String2.nvl(form.getParam("strEdate"));	//기간 2 
			String strSucsYn  	= String2.nvl(form.getParam("strSucsYn"));	//성공여부  
			
			/*
			System.out.println( "--------------------------strSys  		===> " + strSys 	);
			System.out.println( "--------------------------strBatch    	===> " + strBatch   );
			System.out.println( "--------------------------strSdate   	===> " + strSdate  	); 
			System.out.println( "--------------------------strEdate    	===> " + strEdate	);
			System.out.println( "--------------------------strSucsYn   	===> " + strSucsYn	);
			*/
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			
			strQuery = svc.getQuery("SEL_LOG_LIST") + "\n"; 
			
			if( !strSdate.equals("")&&!strEdate.equals("")){ 
				sql.setString(i++, strSdate);
				sql.setString(i++, strEdate);
				strQuery += svc.getQuery("SEL_LOG_WHERE_RUN_DATE") + "\n";
			}
			
			if( !strSys.equals("%")){
				sql.setString(i++, strSys);
				strQuery += svc.getQuery("SEL_LOG_WHERE_SUBSYS") + "\n";
			}
			 
			if( !strBatch.equals("%")){
				sql.setString(i++, strBatch);
				strQuery += svc.getQuery("SEL_LOG_WHERE_BATCH") + "\n";
			}
			
			if( !strSucsYn.equals("%")){
				sql.setString(i++, strSucsYn);
				strQuery += svc.getQuery("SEL_LOG_WHERE_SUCSS_YN") + "\n";
			}
			
			
			strQuery += svc.getQuery("SEL_LOG_ORDER");
			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        
        return list;
	}

	/**
	 *  사용자 로그인이력을 보여준다.
	 *  POPUP
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectLogHistory(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try { 
			String strUserId = String2.nvl(form.getParam("strUserId"));	//사용자id 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper(); 

			sql.put(svc.getQuery("SEL_LOG_HISTORY"));
			sql.setString(1, strUserId);  
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        
        return list;
	}
}
