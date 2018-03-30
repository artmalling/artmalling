/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.ArrayList;
import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae205DAO extends AbstractDAO {
	/**
	 * 경품행사 조회 -MASTER
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strSdt		= String2.nvl(form.getParam("strSdt"));   
		String strEdt		= String2.nvl(form.getParam("strEdt"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	}
	
	/**
	 * 경품행사 조회 -MASTER
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		  List       list = null;
	        SqlWrapper  sql = null;
	        Service     svc = null;
	        Util util = new Util();

	        try {
	            connect("pot");
	            svc  = (Service)form.getService();
	            sql  = new SqlWrapper();
	            int i = 1;

	            String strStrCd		= String2.nvl(form.getParam("strStrCd")); 
	    		String strEventCd	= String2.nvl(form.getParam("strEventCd"));

	            sql.put(svc.getQuery("SEL_DETAIL"));
	            sql.setString(i++, strStrCd); 
				sql.setString(i++, strEventCd);          
	            list = select2List(sql);
	            //복호화
	         /* list = util.decryptedStr(list,2);	// 주민등록번호
	            list = util.decryptedStr(list,3);	// 전화번호1
	            list = util.decryptedStr(list,4);	// 전화번호2
	            list = util.decryptedStr(list,5);	// 전화번호3
	            list = util.decryptedStr(list,6);	// 핸드폰번호1
	            list = util.decryptedStr(list,7);	// 핸드폰번호2
	            list = util.decryptedStr(list,8);	// 핸드폰번호3
	            list = util.decryptedStr(list,10);	// 이메일 */
	            
	        } catch (Exception e) { 
	        	System.out.println("!!!!!!!!!!!!" +e);
	            throw e;
	        }
	        return list;
		 
	}
	
	/**
	 * <p>순위,경품명 조회</p>
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
			
			String strStrCd		= String2.nvl(form.getParam("strStrCd"));	// 공통코드(코드)
			String strEventCd	= String2.nvl(form.getParam("strEventCd"));	// 공통코드(코드)
			
			sql.put(svc.getQuery("SEL_RANK"));
			sql.setString(++i, strStrCd);   
			sql.setString(++i, strEventCd);              
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		} 
		return list;
	}
	 
	/**
	* 경품행사 당첨자 등록
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
        Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
        List	list 	 = null; 
					
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	

			while (mi.next()) {				
				int i=0;
				sql.close();		
  
	        	String strStrCd 	= String2.nvl(form.getParam("strStrCd"));   
	        	String strEventCd 	= String2.nvl(form.getParam("strEventCd"));      
	 
				if (mi.IS_INSERT()) { 			// 저장	  
						sql.put(svc.getQuery("INS_PRMMWIN"));
						
						sql.setString(++i, strStrCd);    
						sql.setString(++i, strEventCd);      
						sql.setString(++i, strStrCd);    
						sql.setString(++i, strEventCd);  
						sql.setString(++i, mi.getString("WIN_NAME")); 	
						sql.setString(++i, mi.getString("SS_NO")); 
						sql.setString(++i, mi.getString("PHONE1_NO")); 
						sql.setString(++i, mi.getString("PHONE2_NO"));
						sql.setString(++i, mi.getString("PHONE3_NO"));
						sql.setString(++i, mi.getString("HP1_NO")); 
						sql.setString(++i, mi.getString("HP2_NO"));
						sql.setString(++i, mi.getString("HP3_NO"));
						sql.setString(++i, mi.getString("RANK_SEQ_NO"));
						sql.setString(++i, mi.getString("ADDR"));
						sql.setString(++i, mi.getString("EMAIL"));
						sql.setString(++i, mi.getString("TAX_AMT")); 
						sql.setString(++i, userId);	 
						sql.setString(++i, userId);	 
						res = update(sql);  
				}   else if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_PRMMWIN"));   

					sql.setString(++i, mi.getString("WIN_NAME")); 	
					sql.setString(++i, mi.getString("SS_NO")); 
					sql.setString(++i, mi.getString("PHONE1_NO")); 
					sql.setString(++i, mi.getString("PHONE2_NO"));
					sql.setString(++i, mi.getString("PHONE3_NO"));
					sql.setString(++i, mi.getString("HP1_NO")); 
					sql.setString(++i, mi.getString("HP2_NO"));
					sql.setString(++i, mi.getString("HP3_NO"));
					sql.setString(++i, mi.getString("RANK_SEQ_NO"));
					sql.setString(++i, mi.getString("ADDR"));
					sql.setString(++i, mi.getString("EMAIL"));
					sql.setString(++i, mi.getString("TAX_AMT"));  
					sql.setString(++i, userId);
					sql.setString(++i, strStrCd);    
					sql.setString(++i, strEventCd);    
					sql.setString(++i, mi.getString("SEQ_NO"));  
					
					res = update(sql);  
				} else if (mi.IS_DELETE()) {
				    sql.put(svc.getQuery("DEL_PRMMWIN"));    
					sql.setString(++i, strStrCd);    
					sql.setString(++i, strEventCd);    
					sql.setString(++i, mi.getString("SEQ_NO"));  
					
					res = update(sql);  
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
}
