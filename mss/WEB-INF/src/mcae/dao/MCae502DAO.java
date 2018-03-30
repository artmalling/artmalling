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

public class MCae502DAO extends AbstractDAO {
	/**
	 * 행사 마스터 정보 조회
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
		
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strEventCd 	= String2.nvl(form.getParam("strEventCd"));   
		String strDate 	= String2.nvl(form.getParam("strDate")); 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);  
		sql.setString(i++, strDate);  
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
     * <p>사은행사 마감체크</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getEventMagam(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        ProcedureWrapper proc = new ProcedureWrapper();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));	// 행사코드

            sql.put(svc.getQuery("SEL_MAGAM"));
            sql.setString(++i, strEventCd);                  
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
	
	/**
	* 반품등록전표 저장/수정
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
 
	        	String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
				String strEventCd	= String2.nvl(form.getParam("strEventCd"));
				String strSaleDt 	= String2.nvl(form.getParam("strSaleDt"));  
				
				if (mi.IS_UPDATE()) { 			// 저장	 
					if(mi.getString("FLAG").equals("T")) {
						sql.put(svc.getQuery("INS_EVTSKUSTOCK")); 
						sql.setString(++i, strSaleDt);   
						sql.setString(++i, strStrCd);   
						sql.setString(++i, mi.getString("EVENT_CD")); 	
						sql.setString(++i, mi.getString("SKU_CD")); 
						sql.setString(++i, mi.getString("SRVY_QTY")); 
						sql.setString(++i, mi.getString("LOSS_QTY")); 
						sql.setString(++i, userId);	
						res = update(sql);

						sql.close();  
						
						i = 0; 
						 
						sql.put(svc.getQuery("INS_STKSKU")); 
						sql.setString(++i, strSaleDt);   
						sql.setString(++i, strStrCd);   
						sql.setString(++i, mi.getString("EVENT_CD")); 	
						sql.setString(++i, strSaleDt);   
						sql.setString(++i, strStrCd);   
						sql.setString(++i, mi.getString("EVENT_CD")); 
						sql.setString(++i, mi.getString("SKU_CD")); 
						sql.setString(++i, mi.getString("QTY")); 
						sql.setString(++i, mi.getString("SRVY_QTY")); 
						sql.setString(++i, mi.getString("LOSS_QTY")); 
						sql.setString(++i, userId);	 	 
						sql.setString(++i, userId);	 	
						res = update(sql);

						sql.close();  
					} 
				}  
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+res);
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
