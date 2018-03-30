/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
/**
 * <p>판매분매입 자동 전표 생성</p>
 * @created  on 1.0, 2010/05/11
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class PStk504DAO extends AbstractDAO {
	
	/**
	 *  판매분매입 자동 전표 생성한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
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

			mi.next();
			
			i = 0;
			sql.close();
			sql.put(svc.getQuery("SEL_MONTH_SALE_CLOSE"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));
			sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));
			sql.setString(++i, mi.getString("CLOSE_YM"));

			List list = select2List( sql );

			if( list.size() <= 0 ) {
				throw new Exception("[USER]" + mi.getString("CLOSE_YM") + " 의 매출월마감이 미완료 되었습니다.");
			}
			
			
			i = 0;
			sql.close();
			sql.put(svc.getQuery("SEL_MONTH_BUY_CLOSE"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("CLOSE_YM"));

			list = select2List( sql );

			if( list.size() > 0 ) {
				throw new Exception("[USER]" + mi.getString("CLOSE_YM") + " 의 매입월마감이 완료 되었습니다.");
			}
			

			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			i = 0;        
			
			if (mi.getString("AUTO_SLIP_FLAG").equals("01")) {
				psql.put("DPS.PR_POAUTOINSLP_SLIDING", 4);		
			     
			    System.out.println(mi.getString("CLOSE_YM"));
			    System.out.println(mi.getString("STR_CD"));
			    
	            psql.setString(++i, mi.getString("CLOSE_YM"));      //매출년월
	            psql.setString(++i, mi.getString("STR_CD")); 		//점코드
	            psql.registerOutParameter(++i, DataTypes.INTEGER);  //RETURN 결과값
	            psql.registerOutParameter(++i, DataTypes.VARCHAR);  //RETURN 메시지

	            prs = updateProcedure(psql);
	            
	            resp = prs.getInt(3);    
	            if (resp != 0) {
	                throw new Exception("[USER]"+ prs.getString(4));
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
