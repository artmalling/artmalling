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
 * <p>특정/임대을 대금지불산출 관리</p>
 * 
 * @created  on 1.0, 2011/05/13
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class PPay302DAO extends AbstractDAO {
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
	 *  특정/임대을 대금지불산출 관리한다.
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
			
			i = 1;            
			psql.put("DPS.PR_PPPAYCALC", 13);  
			     
            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
            psql.setString(i++, mi1.getString("FLAG")); 		// 구분(특정:2, 수수료:3)
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
            psql.setString(i++, "PPAY302");
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//12
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//13

            prs = updateProcedure(psql);
            
            resp += prs.getInt(12);    

            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(13));
            }else{
            	res = prs.getString(13);
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
	 *  특정/임대을 대금지불산출 관리전  Validation Check 한다.
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
			psql.put("DPS.PR_PPPAYSALCHK", 8); 
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
