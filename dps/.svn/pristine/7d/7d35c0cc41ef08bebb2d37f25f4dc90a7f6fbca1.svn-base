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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
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

public class POrd120DAO extends AbstractDAO {    	 
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
		String strSlipIssueCnt = String2.nvl(form.getParam("strSlipIssueCnt"));    
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());		
		
		sql.put(svc.getQuery("SEL_LIST")); 
		sql.setString(i++, strStrCd);  
		sql.setString(i++, userId); 
		sql.setString(i++, org_flag); 
		
		if("1".equals(org_flag)){						// 판매 
			sql.put(svc.getQuery("SEL_SALE_ORG_CD")); 
			sql.setString(i++, strOrgCd);
		}else if("2".equals(org_flag)){					// 매입
			sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
			sql.setString(i++, strOrgCd);          
		}
		
		if("0".equals(strGiJunDtType)){					// 발주일 
			sql.put(svc.getQuery("SEL_ORD_DT"));
			sql.setString(i++, strStartDt); 
			sql.setString(i++, strEndDt);
		} else if("1".equals(strGiJunDtType)){			// 발주확정일 
			sql.put(svc.getQuery("SEL_ORD_CONF"));     
			sql.setString(i++, strStartDt); 
			sql.setString(i++, strEndDt);		             
		} else if("2".equals(strGiJunDtType)){			// 납품예정일
			sql.put(svc.getQuery("SEL_DELI_DT")); 
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);			
		} else if("3".equals(strGiJunDtType)){			// 검품확정일
			sql.put(svc.getQuery("SEL_CHK_DT"));
			sql.setString(i++, strStartDt); 
			sql.setString(i++, strEndDt);		
		} 
		
		if("A".equals(strSlipIssueCnt)){			    // 발행건수 있으면 
			sql.put(svc.getQuery("SEL_SLIP_ISSUE_CNT"));
			
		}else if("B".equals(strSlipIssueCnt)){			// 미발행이면 
			sql.put(svc.getQuery("SEL_NON_SLIP_ISSUE_CNT"));    
		}

		sql.put(slipFlagList);							// 전표구분 조건
		
		sql.setString(i++, strStrCd);					// 정렬조건
		sql.put(svc.getQuery("SEL_ORDERBY"));  
//		System.out.println(sql);
		ret = select2List(sql);
		return ret;
	}
	
	
	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPrintList(ActionForm form) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = ""; 
		int i = 1;
		
		String strStrcd = String2.nvl(form.getParam("strStrCd"));
		String strSlpno = String2.nvl(form.getParam("strSlipNo"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		sql.setString(i++, strStrcd);
		sql.setString(i++, strSlpno);
		
		/* 단일 출력  */
		strQuery = svc.getQuery("SEL_PRINT");
		sql.put(strQuery);
		ret = select2List(sql);
			
		return ret;
	}
	
	
	/**
	 *전표출력시 마스터 데이터 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		System.out.println(" 데이터 업데이트 DAO");

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				
				sql.close();
				if (mi.IS_INSERT()) { // 저장
					int i = 1;					
					
					sql.put(svc.getQuery("UPD_DATA")); 			
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("SLIP_NO"));
				}				
				res = update(sql);

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
