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
 * <p>월손익계산</p>
 * s
 * @created  on 1.0, 2010/05/11
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class PStk501DAO extends AbstractDAO {
	
	/**
	 *  월손익계산처리한다.
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
			sql.put(svc.getQuery("SEL_MONTH_PROFIT_CLOSE"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));
			sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));
			sql.setString(++i, mi.getString("CLOSE_YM"));

			List list = select2List( sql );

			if( list.size() > 0 ) {
				throw new Exception("[USER]" + mi.getString("CLOSE_YM") + " 의 손익월마감이 완료 되었습니다.");
			}
            
			
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			i = 0;        
			
			     
			//psql.put("DPS.PR_PTPBNMONPROFIT_CS", 4);
			psql.put("DPS.PR_PTPBNMONPROFIT", 4);
            psql.setString(++i, mi.getString("STR_CD")); 		//점코드
            psql.setString(++i, mi.getString("CLOSE_YM"));     //손익년월
            psql.registerOutParameter(++i, DataTypes.INTEGER);  //RETURN 결과값
            psql.registerOutParameter(++i, DataTypes.VARCHAR);  //RETURN 메시지

            prs = updateProcedure(psql);
            
            resp = prs.getInt(3);    
            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(4));
            }
            
            /////////////////////
            psql.close();
            i = 0;
			psql.put("DPS.PR_PTSKUMONPROFIT_CS", 4);
            psql.setString(++i, mi.getString("STR_CD")); 		//점코드
            psql.setString(++i, mi.getString("CLOSE_YM"));     //손익년월
            psql.registerOutParameter(++i, DataTypes.INTEGER);  //RETURN 결과값
            psql.registerOutParameter(++i, DataTypes.VARCHAR);  //RETURN 메시지

            prs = updateProcedure(psql);
            
            resp = prs.getInt(3);    
            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(4));
            }
            
			sql.close();
			i = 0;
			sql.put(svc.getQuery("MERGE_MCLOSE"));
			sql.setString(++i, mi.getString("STR_CD"));					
			sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
			sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
			sql.setString(++i, mi.getString("CLOSE_YM"));			
			sql.setString(++i, "Y");			
			sql.setString(++i, "N");		
			sql.setString(++i, userId);	

			resp = update(sql);

			if (resp != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
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
