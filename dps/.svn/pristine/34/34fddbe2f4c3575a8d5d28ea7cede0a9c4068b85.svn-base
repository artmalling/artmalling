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
import java.util.Map;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>발행대상전표 매입 세금계산서 생성</p>
 * 
 * @created  on 1.0, 2010/04/11
 * @created  by 박래형
 *  
 * @modified on  
 * @modified by                    
 * @caused   by                 
 */     

public class PPay109DAO extends AbstractDAO { 

	/**
	 * 매입세금계산서 마스터 데이터 조회
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
		String strBizType    = String2.nvl(form.getParam("strBizType")); 
		String strTaxFlag    = String2.nvl(form.getParam("strTaxFlag")); 
		String strSaleSdt    = String2.nvl(form.getParam("strSaleSdt"));
		String strSaleEdt    = String2.nvl(form.getParam("strSaleEdt")); 
		String strTaxSdt     = String2.nvl(form.getParam("strTaxSdt"));   
		String strTaxEdt     = String2.nvl(form.getParam("strTaxEdt"));   
		String strEdiSeaNo   = String2.nvl(form.getParam("strEdiSeaNo"));  
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));   
		String strEtaxStat   = String2.nvl(form.getParam("strEtaxStat"));   
		String strTaxInvFlag = String2.nvl(form.getParam("strTaxInvFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");   
	
		sql.put(svc.getQuery("SEL_MASTER"));     
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);        
		sql.setString(i++, strPayCnt);  
		sql.setString(i++, strBizType);   
		sql.setString(i++, strTaxFlag);    
		sql.setString(i++, strEdiSeaNo);  
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strTaxInvFlag);  
		
		
		if("K".equals(strEtaxStat)){			
			sql.put(svc.getQuery("WHERE_ETAXSTAT"));
			sql.setString(i++, strEtaxStat);
			
		}else if("%".equals(strEtaxStat)){
			sql.put(svc.getQuery("WHERE_ETAXSTAT"));
			sql.setString(i++, strEtaxStat);
			
		}else{
			sql.put(svc.getQuery("WHERE_ETAXSTAT2"));			
		}
		
		if(!"".equals(strTaxSdt) || !"".equals(strTaxSdt) ){		
			sql.put(svc.getQuery("SEL_TAX_DT"));
			sql.setString(i++, strTaxSdt);  
			sql.setString(i++, strTaxEdt);  
		} 
	
		sql.put(svc.getQuery("ORDER_BY"));
		ret = select2List(sql);
		return ret;
	}
}
