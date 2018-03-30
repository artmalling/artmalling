/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>자사위탁판매 입금등록</p>
 * 
 * @created  on 1.0, 2011/06/09
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif605DAO extends AbstractDAO {
	/**
	 * 자사 위탁 판매 정산내역 조회
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
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSCalYm = String2.nvl(form.getParam("strCalSYm"));
		String strECalYm = String2.nvl(form.getParam("strCalEYm"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_VENPAY") + "\n";
		sql.put(strQuery);
		sql.setString(1, strSCalYm);
		sql.setString(2, strECalYm);
		sql.setString(3, strStrCd);
		sql.setString(4, strVenCd);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 협력사 수수료 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getVenFee(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPayDt = String2.nvl(form.getParam("strPayDt"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_VENFEE") + "\n";
		sql.put(strQuery);
		sql.setString(1, strPayDt);
		sql.setString(2, strStrCd);
		sql.setString(3, strVenCd);
		ret = select2List(sql);
		return ret;
	}
	/**
	 * 자사위타판매 정산 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			i = 1;
			sql.close();
			while(mi.next()){
				sql.close();
				if(mi.IS_INSERT()){
					sql.put(svc.getQuery("INS_VENPAY"));
					sql.setString(i++, mi.getString("PAY_DT"));		  
					sql.setString(i++, mi.getString("PAY_DT"));		                              
					sql.setString(i++, mi.getString("STR_CD"));                               
					sql.setString(i++, mi.getString("VEN_CD"));    
					sql.setString(i++, mi.getString("PAY_DT"));	
					sql.setString(i++, mi.getString("PAY_DT"));		  
					sql.setString(i++, mi.getString("STR_CD"));                               
					sql.setString(i++, mi.getString("VEN_CD"));    
					sql.setString(i++, mi.getString("FEE_RATE"));                             
					sql.setString(i++, mi.getString("PAY_AMT"));                               
					sql.setString(i++, mi.getString("FEE_PAY_AMT"));                          
					sql.setString(i++, userId);                                      
					sql.setString(i++, userId);                                      
					res = update(sql);                                               
				}else if(mi.IS_UPDATE()){                                            
					sql.put(svc.getQuery("UPD_VENPAY"));                             
					sql.setString(i++, mi.getString("PAY_AMT"));   
					sql.setString(i++, mi.getString("FEE_PAY_AMT"));                        
					sql.setString(i++, userId);         
					sql.setString(i++, mi.getString("PAY_DT"));		
					sql.setString(i++, mi.getString("PAY_DT"));	
					sql.setString(i++, mi.getString("STR_CD"));                      
					sql.setString(i++, mi.getString("VEN_CD"));                        
					sql.setString(i++, mi.getString("SEQ_NO"));                        
					res = update(sql);                                               
				}else if(mi.IS_DELETE()){
					sql.put(svc.getQuery("DEL_VENPAY"));                             
					sql.setString(i++, mi.getString("PAY_DT"));	
					sql.setString(i++, mi.getString("PAY_DT"));	
					sql.setString(i++, mi.getString("STR_CD"));                      
					sql.setString(i++, mi.getString("VEN_CD"));                        
					sql.setString(i++, mi.getString("SEQ_NO"));                        
					res = update(sql);                 
				}
				                                                                     
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
}
