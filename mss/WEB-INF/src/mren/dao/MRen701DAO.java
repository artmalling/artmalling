/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

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
 * <p>임대회계전표생성</p>
 * 
 * @created  on 1.0, 2010/05/11
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class MRen701DAO extends AbstractDAO {
	
	/**
	 *  임대회계전표생성처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
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
			//psql.put("DPS.PR_PPNETAXDEF", 11);
			System.out.println(mi1.getString("SEND_FLAG"));
            if(mi1.getString("SEND_FLAG").equals("03")){
            	psql.put("MSS.PR_MRACCMNTN_CHAREG_IFS", 5);            	
			}else if(mi1.getString("SEND_FLAG").equals("04")){
				psql.put("MSS.PR_MRACCMNTN_COST_IFS", 5);				
			}else if(mi1.getString("SEND_FLAG").equals("05")){
				psql.put("DPS.PR_COMIS_IFS", 5);
			}
			     
            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
            psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
            psql.setString(i++, userId);		                // 사용자            
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//5

            prs = updateProcedure(psql);
            
            resp += prs.getInt(4);    
            System.out.println(resp+ "registerOutParameter");
            if (resp < 0) {
                throw new Exception("[USER]"+ prs.getString(5));
            }
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
	
	/**
	 *  임대회계전표생성전  Validation Check 한다.
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
			psql.put("DPS.PR_PPPAYORDSALCHK", 8); 
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
