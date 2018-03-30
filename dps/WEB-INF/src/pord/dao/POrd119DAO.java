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
 
public class POrd119DAO extends AbstractDAO {    	  
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
		String strGiJunDtType  = String2.nvl(form.getParam("strGiJunDtType"));
		String strStartDt      = String2.nvl(form.getParam("strStartDt")); 
		String strEndDt        = String2.nvl(form.getParam("strEndDt"));    
		String slipFlagList    = String2.nvl(form.getParam("slipFlagList"));   
		String strSearchFlag   = String2.nvl(form.getParam("strSearchFlag"));  
		String strFlag         = String2.nvl(form.getParam("strFlag"));     
		String strOrdOwnFlag   = String2.nvl(form.getParam("strOrdOwnFlag")); 
//		String strConfFlag     = String2.nvl(form.getParam("strConfFlag"));     
		String strTaxFlag      = String2.nvl(form.getParam("strTaxFlag")); 
//		
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
	
		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 13) + ' ' + slipFlagList.substring(13, slipFlagList.length());		
		
		if("1".equals(org_flag)){				//SM
			sql.put(svc.getQuery("SEL_LIST1"));  
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strGiJunDtType);   
			sql.setString(i++, strStartDt);   
			sql.setString(i++, strEndDt);  
			
			sql.setString(i++, strSearchFlag);  
			sql.setString(i++, strFlag);  
			   
			sql.setString(i++, userId); 
			sql.setString(i++, org_flag); 	
			sql.setString(i++, strStrCd);   
			sql.setString(i++, strBumun);   
			sql.setString(i++, strTeam);   
			sql.setString(i++, strPc); 
			sql.setString(i++, strOrdOwnFlag);  
			sql.setString(i++, strTaxFlag);  
			
						
		}else if("2".equals(org_flag)){									//바이어
			sql.put(svc.getQuery("SEL_LIST2")); 
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strGiJunDtType);   
			sql.setString(i++, strStartDt);   
			sql.setString(i++, strEndDt);  
			
			sql.setString(i++, strSearchFlag);  
			sql.setString(i++, strFlag);  
			   
			sql.setString(i++, userId); 
			sql.setString(i++, org_flag); 	
			sql.setString(i++, strStrCd);   
			sql.setString(i++, strBumun);   
			sql.setString(i++, strTeam);   
			sql.setString(i++, strPc); 		
			sql.setString(i++, strOrdOwnFlag);  
		}
		 
		sql.put(slipFlagList);		//전표구분
/*
		if("2".equals(strConfFlag)){
			sql.put(svc.getQuery("SEL_CONF"));	 
			
		}else if("3".equals(strConfFlag)){
			System.out.println("strConfFlag = " + strConfFlag);
			sql.put(svc.getQuery("SEL_UNCONF"));	 
		}
*/		
								// 전표구분 조건	  
		
		//정렬 기준
		if("1".equals(strSearchFlag)){
			sql.put(svc.getQuery("OB_PUMBUN"));
		}else if("2".equals(strSearchFlag)){
			sql.put(svc.getQuery("OB_BUYER"));
		}else if("3".equals(strSearchFlag)){
			sql.put(svc.getQuery("OB_VEN"));
		}
		
		ret = select2List(sql); 
		return ret;
	}   	 
	/** 
	 * 발주현황 조회(매입,반품,점출입,매가인상하)
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail1(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null; 
		String strQuery = ""; 
		int i = 1;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));  
		String strSlip     = String2.nvl(form.getParam("strSlip"));  
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));  
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		
		
		sql.put(svc.getQuery("SEL_DETAIL1"));  
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSlip); 
		sql.setString(i++, strSlipFlag); 
		
 
//		System.out.println(sql); 
		ret = select2List(sql);
		System.out.println("ret.size() = " +  ret.size());
		return ret;
	}
	
	/**
	 * 규격단품 대출입발주  상세 내역 조회                                                                       
	 * 
	 * @param form                     
	 * @return 
	 * @throws Exception 
	 */
	public List[] getDetail2(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";  
		int i = 1;
 
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo   = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호
		String strPSlipNo  = String2.nvl(form.getParam("strPSlipNo"));		// 대출전표번호 
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));		// 대출전표번호
 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd); 
		if("C".equals(strSlipFlag)) 
			sql.setString(i++, strSlipNo);
		else
			sql.setString(i++, strPSlipNo);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		ret[0] = select2List(sql);                                       

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPSlipNo);
		ret[1] = select2List(sql);
 
		return ret;
	}
	/** 
	 * 발주현황 조회(대입)
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail3(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null; 
		String strQuery = ""; 
		int i = 1;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));  
		String strSlip     = String2.nvl(form.getParam("strSlip"));  
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));  
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		
		sql.put(svc.getQuery("SEL_DETAIL3")); 
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSlip); 
		sql.setString(i++, strSlipFlag); 

//		System.out.println(sql);
		ret = select2List(sql);
		return ret;
	}
}
