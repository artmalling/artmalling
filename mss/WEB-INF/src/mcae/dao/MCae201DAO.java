/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
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

public class MCae201DAO extends AbstractDAO {
	/**
	 * 경품행사 마스터조회 -MASTER
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt = String2.nvl(form.getParam("strSdt"));
		String strEdt = String2.nvl(form.getParam("strEdt"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
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
	 * 경품행사 마스터조회 -MASTER
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd")); 
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	* 경품행사 마스터  저장/수정
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
 
				String strStrCd  = String2.nvl(form.getParam("strStrCd"));
				String strEventCd  = String2.nvl(form.getParam("strEventCd")); 
				
				if (mi.IS_INSERT()) { 			// 저장  
					sql.put(svc.getQuery("INS_PRMMINFO"));
					
					sql.setString(++i, strStrCd);   
					sql.setString(++i, strEventCd);   
					sql.setString(++i, strStrCd); 				
					sql.setString(++i, strEventCd);  
					sql.setString(++i, mi.getString("RANK"));
					sql.setString(++i, mi.getString("PRMM_NAME"));
					sql.setString(++i, mi.getString("WIN_CNT"));  
					sql.setString(++i, userId);
					sql.setString(++i, userId);	
					res = update(sql);
					
				} else if(mi.IS_DELETE()){ 		// 삭제 
					sql.put(svc.getQuery("DEL_PRMMINFO")); 
					
					sql.setString(++i, strStrCd);    
					sql.setString(++i, strEventCd);  
					sql.setString(++i, mi.getString("SEQ_NO"));
					res = update(sql);  
				}else if(mi.IS_UPDATE()){ 
					sql.put(svc.getQuery("UPD_PRMMINFO")); 
					 
					sql.setString(++i, mi.getString("RANK"));  
					sql.setString(++i, mi.getString("PRMM_NAME"));  
					sql.setString(++i, mi.getString("WIN_CNT"));   
					sql.setString(++i, userId);
                    sql.setString(++i, strStrCd);    
					sql.setString(++i, strEventCd); 	 
					sql.setString(++i, mi.getString("SEQ_NO"));  
					res = update(sql);
					
					sql.close();
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
