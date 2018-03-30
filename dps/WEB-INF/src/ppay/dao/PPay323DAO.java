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
 * <p> 매입전표 회계전송 </p>
 * 
 * @created  on 1.0, 2017/01/25
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class PPay323DAO extends AbstractDAO {

	/**
	 *  매입전표 회계전송
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
		
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
	
			connect("pot");
			begin();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;

			mi1.next();
			
			i = 1;
			psql.put("DPS.PR_DUZON_MAEIP_IF", 6);  	// 직매입/특정매입 매입 회계 인터페이스
		     
            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
            psql.setString(i++, mi1.getString("FLAG")); 		// 거래형태
            psql.setString(i++, userId);
            psql.registerOutParameter(i++, DataTypes.INTEGER);	// 5
            psql.registerOutParameter(i++, DataTypes.VARCHAR);	// 6
            prs = updateProcedure(psql);
            
            resp += prs.getInt(5);    
            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(6));
            }else{
            	res = prs.getString(6);
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