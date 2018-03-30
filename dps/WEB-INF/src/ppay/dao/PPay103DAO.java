/*
 * Copyright (c) 2010 한국후지쯔 All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**          
 * <p>매입세금계산서 수기접수 처리</p>
 * 
 * @created  on 1.0, 2010/04/11
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by           
 */

public class PPay103DAO extends AbstractDAO {

	/**
	 * 매입세금계산서 수기접수 처리 조회
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));   
		String strYyyymm   = String2.nvl(form.getParam("strYyyymm"));  
		String strPayCyc   = String2.nvl(form.getParam("strPayCyc"));  
		String strPayCnt   = String2.nvl(form.getParam("strPayCnt"));  
		String strBizType  = String2.nvl(form.getParam("strBizType")); 
		String strTaxFlag  = String2.nvl(form.getParam("strTaxFlag")); 
		String strSaleSdt  = String2.nvl(form.getParam("strSaleSdt"));
		String strSaleEdt  = String2.nvl(form.getParam("strSaleEdt")); 
		String strTaxSdt   = String2.nvl(form.getParam("strTaxSdt"));  
		String strTaxEdt   = String2.nvl(form.getParam("strTaxEdt"));  
		String strEdiSeaNo = String2.nvl(form.getParam("strEdiSeaNo"));  
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));   
		String strEtaxStat = String2.nvl(form.getParam("strEtaxStat"));   
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST1")); 
		sql.setString(i++, strEdiSeaNo);
		sql.setString(i++, strTaxSdt);  
		sql.setString(i++, strTaxEdt);
		
		if("K".equals(strEtaxStat))
			sql.put(svc.getQuery("WHERE_ETAX_STAT1"));          
		else if("Z".equals(strEtaxStat))
			sql.put(svc.getQuery("WHERE_ETAX_STAT3"));
		
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag);    
		sql.setString(i++, strEdiSeaNo);  
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strTaxSdt);  
		sql.setString(i++, strTaxEdt);
		
		sql.put(svc.getQuery("SEL_LIST2")); 
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);  
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag);    
		sql.setString(i++, strEdiSeaNo);  
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strTaxSdt);  
		sql.setString(i++, strTaxEdt);   
		
		if("K".equals(strEtaxStat))
			sql.put(svc.getQuery("WHERE_ETAX_STAT2"));          
		else if("Z".equals(strEtaxStat))
			sql.put(svc.getQuery("WHERE_ETAX_STAT4"));
	
		ret = select2List(sql);
		return ret;
	}
	

	/**
	 * 매입세금계산서 상세 데이터 조회
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
          
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));   
		String strIssueDt    = String2.nvl(form.getParam("strIssueDt"));  
		String strIssueSeqNo = String2.nvl(form.getParam("strIssueSeqNo"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);            
		sql.setString(i++, strIssueDt);             
		sql.setString(i++, strIssueSeqNo);  
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strIssueDt);
		sql.setString(i++, strIssueSeqNo);
		ret[1] = select2List(sql);

		return ret;
	}
	
	/**
	 *  매입세금계산서 생성(저장)한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId, String org_flag)
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
				if(mi1.IS_UPDATE()){// 저장
					
					i = 1;
					// 
					sql.put(svc.getQuery("UPD_MASTER")); 
					
					sql.setString(i++, "K");   								/* 세금계산서상태(승인:K) */  
					sql.setString(i++, mi1.getString("ETAX_NO"));        
					sql.setString(i++, mi1.getString("TAX_ITEM_VAT_AMT"));
					sql.setString(i++, mi1.getString("VAT_AMT"));  
					sql.setString(i++, mi1.getString("TOT_AMT"));      
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));   
					sql.setString(i++, mi1.getString("TAX_ISSUE_DT"));        
					sql.setString(i++, mi1.getString("TAX_ISSUE_SEQ_NO"));   
					sql.setString(i++, mi1.getString("VEN_CD"));        
				}
				res = update(sql);

					
				if (res <= 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
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
