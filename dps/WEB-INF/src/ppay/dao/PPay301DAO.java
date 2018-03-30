/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
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
 * <p>세금계산서 미발행 일괄 유보처리</p>
 * 
 * @created  on 1.0, 2011/05/11
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class PPay301DAO extends AbstractDAO {
	/**
	 * 작업 내역 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;            
		
		String strPayYm      = String2.nvl(form.getParam("strPayYm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));
		
		sql = new SqlWrapper();                     
		svc = (Service) form.getService();
		connect("pot");  
		  
		i = 1;      
		sql.put(svc.getQuery("SEL_LIST"));
        sql.setString(i++, strPayYm); 		// 지불년월 
        sql.setString(i++, strPayCyc);		// 지불주기
        sql.setString(i++, strPayCnt);		// 지불회차
        sql.setString(i++, strStrCd); 		// 점코드
        sql.setString(i++, strVenCd);		// 협력사
		
		ret = select2List(sql);                                                                                                  
		return ret;                   
	}
	
	
	/**
	 *  세금계산서 미발행 일괄 유보처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String save(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		String res          = "";
		int i   			= 0;
		
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

			mi1.next();

			// 세금계산서 확인건 반영
			if("Y".equals(mi1.getString("CHK1"))){
				i = 1;            
				psql.put("DPS.PR_PPTAXCONFPAY", 12);  
				     
	            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY301");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12
	
	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    
	            if (resp != 0) {
	                throw new Exception("[USER-세금계산서 확인건 반영]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
	            	
			}
			
			// 세금계산서 미확인건 유보처리
			if("Y".equals(mi1.getString("CHK2"))){
				i = 1;            
				psql.put("DPS.PR_PPNETAXDEF", 12);  
				     
	            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사 
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY301");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12
	
	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    
	            System.out.println(prs.getInt(11) +"::"+prs.getString(12));
	            if (resp != 0) {
	                throw new Exception("[USER-세금계산서 미확인건 유보처리]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
	
	/**
	 *  세금계산서 미발행 일괄 유보처리전  Validation Check 한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String valCheck(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		String res			= "";
		int i   			= 0;
		
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

			mi1.next();
				
			i = 1;    
			psql.put("DPS.PR_PPPAYORDCHK", 8); 
			psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
            psql.setString(i++, userId);
            psql.setString(i++, org_flag);
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8

            prs = updateProcedure(psql);
            
            resp += prs.getInt(7);    

            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(8));
            }else{
            	res = prs.getString(8);
            }
            
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
}
