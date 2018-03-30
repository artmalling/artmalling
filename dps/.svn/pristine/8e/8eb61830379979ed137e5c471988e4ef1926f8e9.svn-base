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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

 
/**  
 * <p> 규격단품 매입발주 등록  DAO </p>
 *   
 * @created  on 1.0, 2010/02/16
 * @created  by 
 * 
 * @modified on 
 * @modified by 
 * @caused   by  
 */

public class POrd117DAO extends AbstractDAO {
    	
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
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strBumun      = String2.nvl(form.getParam("strBumun"));
		String strTeam       = String2.nvl(form.getParam("strTeam"));
		String strPc         = String2.nvl(form.getParam("strPc"));
		String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
		String strGJdateType = String2.nvl(form.getParam("strGJdateType"));
		String strStartDt    = String2.nvl(form.getParam("strStartDt"));
		String strEndDt      = String2.nvl(form.getParam("strEndDt"));    
		String strProcStat   = String2.nvl(form.getParam("strProcStat")); 
		String strPumbun     = String2.nvl(form.getParam("strPumbun"));   
		String strBizType    = String2.nvl(form.getParam("strBizType"));
		String strVen        = String2.nvl(form.getParam("strVen"));       
		// String strSlip_flag  = String2.nvl(form.getParam("strSlip_flag"));
		String slipFlagList  = String2.nvl(form.getParam("slipFlagList")); 
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		String autoSlipFlag  = String2.nvl(form.getParam("autoSlipFlag"));
		String strSkuFlag    = "1";	// 단품
		String strSkuType    = "1"; // 규격단품  

		System.out.println("slipFlagList = " + slipFlagList);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());
	
		/* System.out.println("slipFlagList = " + slipFlagList); */
		sql.put(svc.getQuery("SEL_LIST"));
		/* sql.setString(i++, strSkuFlag); */
		/*sql.setString(i++, strSkuType);   */  
		sql.setString(i++, strStrCd);	
		                    
		sql.setString(i++, userId);           
		sql.setString(i++, org_flag); 
		 
		if("".equals(strSlipNo)){
			if("1".equals(org_flag)){						// 판매
				sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
				sql.setString(i++, strProcStat);
				sql.setString(i++, strPumbun);
				sql.setString(i++, strVen);
				sql.setString(i++, autoSlipFlag);	
				sql.setString(i++, strOrgCd);
			}else if("2".equals(org_flag)){					// 매입
				sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
				sql.setString(i++, strProcStat);
				sql.setString(i++, strPumbun);
				sql.setString(i++, strVen);
				sql.setString(i++, autoSlipFlag);		
				sql.setString(i++, strOrgCd);          
			}
			if("N".equals(strProcStat)){						//미확정
				sql.put(svc.getQuery("SEL_NON_CONF"));
				//sql.setString(i++, '01');
			}
			  
			if("0".equals(strGJdateType)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);
			} else if("1".equals(strGJdateType)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		             
			} else if("2".equals(strGJdateType)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);			
			} else if("3".equals(strGJdateType)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		
			}

			sql.put(slipFlagList);		//전표구분
		}else{
			sql.put(svc.getQuery("SEL_GROUP")); 
			sql.put(svc.getQuery("WHERE_SLIP_NO")); 
			sql.setString(i++, strSlipNo); 
			
		}
		
		sql.put(svc.getQuery("SEL_ORDERBY"));  
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 규격단품 매입발주  상세 내역 조회
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

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		
		ret[1] = select2List(sql);

		return ret;
	}
	/**
	 * 규격단품 대출입발주  상세 내역 조회                                                                       
	 * 
	 * @param form                     
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail1(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		try{
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo   = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호
		String strPSlipNo  = String2.nvl(form.getParam("strPSlipNo"));		// 대출전표번호
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));		// 대출전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[3];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		if("C".equals(strSlipFlag))
			sql.setString(i++, strSlipNo);
		else
			sql.setString(i++, strPSlipNo);
		
		strQuery = svc.getQuery("SEL_MASTER1") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo); 
		ret[1] = select2List(sql);                                       

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPSlipNo);
		ret[2] = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return ret;
	}
	/**
	 * 의류단품 점출입발주  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail3(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strSlipFlag= String2.nvl(form.getParam("strSlipFlag"));		// 점출점
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점출점
		 String strPStrCd  = String2.nvl(form.getParam("strPStrCd"));	  // 접입점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 점출전표번호
		 String strPSlipNo = String2.nvl(form.getParam("strPSlipNo"));	// 점입전표번호 */

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");
		// 1. 마스터
		if("E".equals(strSlipFlag))
			sql.setString(i++, strStrCd);
		else
			sql.setString(i++, strPStrCd);
				
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER3") + "\n";
		sql.put(strQuery);
		ret[0] = select2List(sql);

		sql.close();
		i= 1; 
		// 3. 점출상세
		strQuery = svc.getQuery("SEL_DETAIL3") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);            
		ret[1] = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 의류단품 매가인상하  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail4(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER4") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL4") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		
		ret[1] = select2List(sql);

		return ret;
	}
    
	/**
	 * INVOICE 등록  마스터 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster5(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);      
		sql.setString(i++, strSlipNo);     
		
		strQuery = svc.getQuery("SEL_MASTER5") + "\n";  

		sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
	} 
	
	/**
	 * INVOICE 등록  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail5(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strInvoiceYm = String2.nvl(form.getParam("strInvoiceYm"));
		String strInvoiceSeqNo = String2.nvl(form.getParam("strInvoiceSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strInvoiceYm);     
		sql.setString(i++, strInvoiceSeqNo);  
		strQuery = svc.getQuery("SEL_DETAIL5") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?");
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
	/**
	 * 품목 매입발주 매입/반품  내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	
	public List getMaster6(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_MASTER6") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("ret.size()= " + ret.size());
		return ret;
	}
	
	/**
	 * 품목 매입발주 매입/반품  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail6(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

//		System.out.println("디테일조회안타나");
		strQuery = svc.getQuery("SEL_DETAIL6") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}
	
}
