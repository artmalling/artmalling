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
 * <p>프로그램사용로그</p>
 *  
 * @created  on 1.0, 2010/06/28
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom302DAO extends AbstractDAO { 

	/**
	 *  시스템구분 별 대분류를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectLcode(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;	 

        try { 
 
			String strSubSystem = String2.nvl(form.getParam("strSubSystem"));	// 시스템구분 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			sql.put(svc.getQuery("SEL_LCODE"));
			sql.setString(++i, strSubSystem);
			 
			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

	/**
	 *  대분류 별 중분류를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectMcode(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;	 

        try { 
 
			String strLcode = String2.nvl(form.getParam("strLcode"));	// 대분류 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			sql.put(svc.getQuery("SEL_MCODE"));
			sql.setString(++i, strLcode);
			 
			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

	/**
	 *  중분류 별 소분류를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectScode(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;	 

        try { 
 
			String strLcode = String2.nvl(form.getParam("strLcode"));	// 대분류 
			String strMcode = String2.nvl(form.getParam("strMcode"));	// 중분류 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			sql.put(svc.getQuery("SEL_SCODE"));
			sql.setString(++i, strLcode);
			sql.setString(++i, strMcode);
			 
			 
			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	/**
	 *  프로그램사용로그를 조회한다.
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
 
			String strSystemGbn = String2.nvl(form.getParam("strSystemGbn"));	//시스템구분
			String strLcode   	= String2.nvl(form.getParam("strLcode"));		//대분류 	
			String strMcode  	= String2.nvl(form.getParam("strMcode"));		//중분류
			String strScode  	= String2.nvl(form.getParam("strScode"));		//소분류
			String strSdate    	= String2.nvl(form.getParam("strSdate"));		//기간 1
			String strEdate    	= String2.nvl(form.getParam("strEdate"));		//기간 2
			String strUserCd  	= URLDecoder.decode(String2.nvl(form.getParam("strUserCd")), "UTF-8");//사용자id/명  
			
			/*
			System.out.println( "--------------------------strSystemGbn  ===> " + strSystemGbn );
			System.out.println( "--------------------------strLcode    ===> " + strLcode   );
			System.out.println( "--------------------------strDeptCd   ===> " + strDeptCd  );
			System.out.println( "--------------------------strTeamCd   ===> " + strTeamCd  );
			System.out.println( "--------------------------strPcCd     ===> " + strPcCd    );
			*/
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			
			strQuery = svc.getQuery("SEL_VISIT_LIST") + "\n";

			if( !strSystemGbn.equals("%")){
				sql.setString(i++, strSystemGbn);
				strQuery += svc.getQuery("SEL_VISIT_WHERE_SUB_SYSTEM") + "\n";
			}
			
			if( !strLcode.equals("%")){
				sql.setString(i++, strLcode);
				strQuery += svc.getQuery("SEL_VISIT_WHERE_LCODE") + "\n";
			}

			if( !strMcode.equals("%")){
				sql.setString(i++, strMcode);
				strQuery += svc.getQuery("SEL_VISIT_WHERE_MCODE") + "\n";
			}

			if( !strScode.equals("%")){
				sql.setString(i++, strScode);
				strQuery += svc.getQuery("SEL_VISIT_WHERE_SCODE") + "\n";
			}
 
			if( !strUserCd.equals("")){
				sql.setString(i++, strUserCd);
				sql.setString(i++, strUserCd);
				strQuery += svc.getQuery("SEL_VISIT_WHERE_USER_CD") + "\n";
			}
			
			if( !strSdate.equals("")&&!strEdate.equals("")){ 
				sql.setString(i++, strSdate);
				sql.setString(i++, strEdate);
				strQuery += svc.getQuery("SEL_VISIT_WHERE_VISIT_DATE") + "\n";
			}
			
			strQuery += svc.getQuery("SEL_VISIT_ORDER");
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
