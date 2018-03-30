/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.util.Map;

import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;




/**
 * <p>비밀번호변경</p>
 *  
 * @created  on 1.0, 2010/06/23
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom008DAO extends AbstractDAO { 

	/**
	 * 비밀번호변경
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int savePassword(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int res 	   = 0;
		Util util      = new Util();
		SqlWrapper sql = null;
		Service    svc = null;
		int i;
		
		
		try {
			
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strUserid 		= null;
			String strOldPasswd 	= null;
			String strNewPasswd 	= null;

			while( mi.next()) {
				strUserid 		= mi.getString("USER_ID");		// 사용자 ID
				strOldPasswd 	= mi.getString("OLD_PASS_WD");	// 사용자 OLD PW
				strNewPasswd 	= mi.getString("NEW_PASS_WD");	// 사용자 NEW PW
				
				
				i = 0;				
				sql.close();
				sql.put(svc.getQuery("SEL_USER_PWD"));
				sql.setString(++i, strUserid);	
				sql.setString(++i, strOldPasswd);	

				Map map = selectMap( sql );
				String cnt = String2.nvl((String)map.get("COUNT"));

				if( !cnt.equals("1")) {
					throw new Exception("[USER]"+"현재 비밀번호가 일치하지 않습니다.");
				}

				i = 0;
                sql.close();
				sql.put(svc.getQuery("UPT_USER_PWD"));
				
				sql.setString(++i, strNewPasswd); 
				sql.setString(++i, strID); 
				sql.setString(++i, strUserid);   
				
				res = update(sql);  

				if( res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 비밀번호를 변경하지 못했습니다.");
				}
				
			}
			
		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
}
