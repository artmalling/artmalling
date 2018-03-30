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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>공제협력사 매출세금계산서 일괄 생성</p>
 * 
 * @created  on 1.0, 2010/04/18
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by   
 */

public class PPay105DAO extends AbstractDAO {

	/**
	 * 공제협력사 매출세금계산서 일괄 생성조회
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

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));   
		String strYyyymm   = String2.nvl(form.getParam("strYyyymm"));  
		String strPayCyc   = String2.nvl(form.getParam("strPayCyc"));  
		String strPayCnt   = String2.nvl(form.getParam("strPayCnt"));  
		String strSaleSdt  = String2.nvl(form.getParam("strSaleSdt"));
		String strSaleEdt  = String2.nvl(form.getParam("strSaleEdt")); 
		String strTaxSdt   = String2.nvl(form.getParam("strTaxSdt"));  
		String strTaxEdt   = String2.nvl(form.getParam("strTaxEdt"));  
		String strEdiSeaNo = String2.nvl(form.getParam("strEdiSeaNo"));  
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));
		String strBizType  = String2.nvl(form.getParam("strBizType"));    
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));     
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strYyyymm);           
		sql.setString(i++, strPayCyc);                               
		sql.setString(i++, strPayCnt);     
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strEdiSeaNo);
		sql.setString(i++, strBizType); 
		
		if(!"".equals(strTaxSdt) || !"".equals(strTaxSdt) ){		
			sql.put(svc.getQuery("SEL_TAX_DT"));
			sql.setString(i++, strTaxSdt);  
			sql.setString(i++, strTaxEdt);  
		} 
	
		sql.put(svc.getQuery("SEL_GROUPBY"));
		ret = select2List(sql);
		return ret;
	}
	
                  
	/**
	 *  공제협력사 매출세금계산서 일괄 생성(저장)한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int ret 			= 0;
		int res 			= 0;
		int resp    		= 0;     //프로시저 리턴값
		int i   			= 0;
		String strSysDate 	= "";    // DB날짜 가져오기
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			String strSaleSdt  = String2.nvl(form.getParam("strSaleSdt"));
			String strSaleEdt  = String2.nvl(form.getParam("strSaleEdt"));
			
			// 현재날짜시간 구하기
			sql.put(svc.getQuery("SEL_SYSDATE"));
			Map mapSysDate = (Map)selectMap(sql);             
			strSysDate = mapSysDate.get("TODAY").toString();
			// 마스터
			while (mi1.next()) {
				if(mi1.IS_UPDATE()){// 저장
					if("T".equals(mi1.getString("SEL"))){
						i = 1;            
						psql.put("DPS.PR_PPTAXCRT", 18);  
     
						psql.setString(i++, strSysDate);					// 등록일시
			            psql.setString(i++, userId);       					// 등록자
			            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
			            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
			            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
			            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
			            psql.setString(i++, " ");							// 거래형태(' ')
			            psql.setString(i++, "1");							// 과세구분(1:과세)   
			            psql.setString(i++, "2");							// 세금계산서구분(1:매입/2:매출)
			            psql.setString(i++, mi1.getString("REASON_CD"));	//공제코드(공제임)
			            psql.setString(i++, mi1.getString("VEN_CD"));		// 
			            psql.setString(i++, strSaleSdt);
			            psql.setString(i++, strSaleEdt);
			            
			            psql.setString(i++, ""); 					    // 지불년월
			            psql.setString(i++, "");						// 지불주기
			            psql.setString(i++, "");						// 지불회차
			            
			            psql.registerOutParameter(i++, DataTypes.INTEGER);//17
			            psql.registerOutParameter(i++, DataTypes.VARCHAR);//18

			            prs = updateProcedure(psql);             
			            
			            resp += prs.getInt(17);    

			            if (resp <= 0) {
			                throw new Exception("[USER]"+ prs.getString(18));
			            }
					}
				}
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
}
