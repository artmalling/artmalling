/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;
 
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>물품 입고/반품 등록</p>
 *  
 * @created  on 1.0, 2010/01/26 
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on  
 * @modified by 
 * @caused   by   
 */

public class POrd401DAO extends AbstractDAO {    	  
	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
				
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strBumun        = String2.nvl(form.getParam("strBumun"));
		String strTeam         = String2.nvl(form.getParam("strTeam"));
		String strPc           = String2.nvl(form.getParam("strPc"));
		String strOrgCd        = String2.nvl(form.getParam("strOrgCd"));
		String strStartDt      = String2.nvl(form.getParam("strStartDt"));  
		String strSkuFlag1     = String2.nvl(form.getParam("strSkuFlag1"));  
		String strSkuFlag2     = String2.nvl(form.getParam("strSkuFlag2"));  
		String strSlipflag1    = String2.nvl(form.getParam("strSlipflag1"));  
		String strSlipflag2    = String2.nvl(form.getParam("strSlipflag2"));  
		String strSlipflag3    = String2.nvl(form.getParam("strSlipflag3"));  
		String strSlipflag4    = String2.nvl(form.getParam("strSlipflag4"));  
		String strSlipflag5    = String2.nvl(form.getParam("strSlipflag5"));  
		String strSlipflag6    = String2.nvl(form.getParam("strSlipflag6"));  
		String strSlipflag7    = String2.nvl(form.getParam("strSlipflag7"));   
		String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));   
		
/*
		System.out.println("strSlipflag1 = " + strSlipflag1);
		System.out.println("strSlipflag2 = " + strSlipflag2); 
		System.out.println("strSlipflag3 = " + strSlipflag3); 
		System.out.println("strSlipflag4 = " + strSlipflag4);
		System.out.println("strSlipflag5 = " + strSlipflag5);
		System.out.println("strSlipflag6 = " + strSlipflag6);
		System.out.println("strSlipflag7 = " + strSlipflag7);
*/		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot"); 
/*	
		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());	
		sql.put(slipFlagList);							// 전표구분 조건
			

		System.out.println("org_flag :::  " + org_flag);
		sql.put(svc.getQuery("SEL_LIST1")); 
		sql.setString(i++, strSlipflag1); 	//	A
		sql.setString(i++, strSlipflag2);	//  B 
		sql.setString(i++, strSlipflag4);	//	D 
		sql.setString(i++, strSlipflag3);	//	C 
		sql.setString(i++, strSlipflag6);	//	F 
		sql.setString(i++, strSlipflag5);	//	E 
		sql.setString(i++, strSlipflag7);	//	G   
		
		sql.setString(i++, strSlipflag1); 	//	A
		sql.setString(i++, strSlipflag2);	//  B 
		sql.setString(i++, strSlipflag4);	//	D 
		sql.setString(i++, strSlipflag3);	//	C 
		sql.setString(i++, strSlipflag6);	//	F 
		sql.setString(i++, strSlipflag5);	//	E 
//		sql.setString(i++, strSlipflag7);	//	G 
		
		sql.setString(i++, strSlipflag1); 	//	A 
		sql.setString(i++, strSlipflag2);	//  B 
		sql.setString(i++, strSlipflag4);	//	D 
		sql.setString(i++, strSlipflag3);	//	C 
		sql.setString(i++, strSlipflag6);	//	F 
		sql.setString(i++, strSlipflag5);	//	E 
		sql.setString(i++, strSlipflag7);	//	G 
		
		sql.setString(i++, strSlipflag7);	//	G 
		
		sql.setString(i++, strSlipflag1); 	//	A
		sql.setString(i++, strSlipflag2);	//  B 
		sql.setString(i++, strSlipflag4);	//	D 
		sql.setString(i++, strSlipflag3);	//	C 
		sql.setString(i++, strSlipflag6);	//	F 
		sql.setString(i++, strSlipflag5);	//	E 
		
		sql.setString(i++, strStrCd);	
		sql.setString(i++, strStartDt);	
		sql.setString(i++, strStrCd);	
		sql.setString(i++, strBumun);	 
		sql.setString(i++, strTeam);	
		sql.setString(i++, strPc);	
		sql.setString(i++, userId);	
*/		
		if("1".equals(org_flag)){						// 판매 		

			System.out.println("org_flag11 :::  " + org_flag);
			sql.setString(i++, strSlipflag1); 	//	A 
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			
			sql.setString(i++, strSlipflag1); 	//	A
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			
			sql.setString(i++, strSlipflag1); 	//	A 
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			 
			sql.setString(i++, strSlipflag1); 	//	A
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E  

			sql.setString(i++, strSlipflag7);	//	G 			
			sql.setString(i++, strSlipflag7);	//	G 
			
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strStartDt);	
			
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strBumun);	 
			sql.setString(i++, strTeam);	
			sql.setString(i++, strPc);	
			
			sql.setString(i++, strSkuFlag1);	
			sql.setString(i++, strSkuFlag2);	
			sql.setString(i++, strPumbunCd);	
			
			sql.setString(i++, userId);	
			sql.setString(i++, org_flag);	
			sql.put(svc.getQuery("SEL_LIST1")); 
			
		}else if("2".equals(org_flag)){					// 매입
			System.out.println("org_flag22 :::  " + org_flag);
			sql.setString(i++, strSlipflag1); 	//	A
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			
			sql.setString(i++, strSlipflag1); 	//	A
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			
			sql.setString(i++, strSlipflag1); 	//	A 
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			 
			sql.setString(i++, strSlipflag1); 	//	A
			sql.setString(i++, strSlipflag2);	//  B 
			sql.setString(i++, strSlipflag4);	//	D 
			sql.setString(i++, strSlipflag3);	//	C 
			sql.setString(i++, strSlipflag6);	//	F 
			sql.setString(i++, strSlipflag5);	//	E 
			
			sql.setString(i++, strSlipflag7);	//	G 			
			sql.setString(i++, strSlipflag7);	//	G 
			
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strStartDt);	
			
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strBumun);	
			sql.setString(i++, strTeam);	
			sql.setString(i++, strPc);	
			
			sql.setString(i++, strSkuFlag1);	
			sql.setString(i++, strSkuFlag2);	
			sql.setString(i++, strPumbunCd);	
			
			sql.setString(i++, userId);	
			sql.setString(i++, org_flag);
			sql.put(svc.getQuery("SEL_LIST2")); 
		}
		
//		System.out.println(sql);
		ret = select2List(sql);
		return ret;
	}
}
