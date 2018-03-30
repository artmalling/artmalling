/*
 * Copyright (c) 2010 한국후지쯔 All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>공제등록</p>
 * 
 * @created  on 1.0, 2010/05/31
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PPay205DAO extends AbstractDAO { 

	/**
	 * 공제등록 조회 
	 *        
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm     = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));
		String strPumCd      = String2.nvl(form.getParam("strPumCd"));
		String strRsCd       = String2.nvl(form.getParam("strRsCd"));
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);          
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		sql.setString(i++, strRsCd);

      	                      
		ret = select2List(sql);
		
		return ret;
	}
	
		
	/**
	 * 선급금/공제/보류  상세 데이터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form) throws Exception {
		                         
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm  = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc  = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt  = String2.nvl(form.getParam("strPayCnt"));
		String strVenCd   = String2.nvl(form.getParam("strVenCd"));
		String strPumCd   = String2.nvl(form.getParam("strPumCd"));
		String strRsCd    = String2.nvl(form.getParam("strRsCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[3];
		
		connect("pot");
         
		i = 1;
		sql.close();
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		sql.setString(i++, strRsCd);
		ret[0] = select2List(sql);  
		
		i = 1;
		sql.close();
		
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		sql.setString(i++, strRsCd);
		ret[1] = select2List(sql);   

		
		i = 1;
		sql.close();
		
		strQuery = svc.getQuery("SEL_DETAIL3") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);               
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		sql.setString(i++, strRsCd);
		ret[2] = select2List(sql);   

		return ret;
	}
	/**
	 * 당초PC별월매출계획   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveconf(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0; 

		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				sql.close();
				
				if(mi1.IS_UPDATE()){// 수정 
					
					i = 1;
					// 1. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
					
					sql.setString(i++, mi1.getString("SEL"));
					sql.setString(i++, mi1.getString("STR_CD")); 
					sql.setString(i++, mi1.getString("PAY_YM"));
					sql.setString(i++, mi1.getString("PAY_CYC"));    
					sql.setString(i++, mi1.getString("PAY_CNT")); 
					sql.setString(i++, mi1.getString("VEN_CD"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					sql.setString(i++, mi1.getString("REASON_CD"));
					
				}
				res = update(sql);
				

				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
