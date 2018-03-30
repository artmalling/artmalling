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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
//00 import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
//00 import kr.fujitsu.ffw.model.SqlWrapper;
//00 import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 매출회계전표생성
 * </p>
 * 
 * @created on 1.0, 2010/05/11
 * @created by 김경은
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class POrd123DAO extends AbstractDAO {

	/**
	 * 매출회계전표생성처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId)
			throws Exception {

		int resp = 0; // 프로시저 리턴값
		int i = 0;

		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null; // 프로시저 사용위함
		try {

			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper(); // 프로시저 사용위함
			ProcedureResultSet prs = null;

			mi1.next();

			i = 1;
			psql.put("DPS.PR_POMYEONGDONG_INOUT", 5); // argument 갯수

			psql.setString(i++, mi1.getString("STR_CD")); // 점코드
			psql.setString(i++, mi1.getString("PAY_YM")); // 전송년월
			psql.setString(i++, userId); // 사용자

			psql.registerOutParameter(i++, DataTypes.INTEGER);// 4
			psql.registerOutParameter(i++, DataTypes.VARCHAR);// 5

			// proceduare call
			prs = updateProcedure(psql);

			resp += prs.getInt(4);
			System.out.println(resp + "registerOutParameter");
			if (resp < 0) {
				throw new Exception("[USER]" + prs.getString(5));
			}
			
			
			psql.close();
			i = 1;
			psql.put("DPS.PR_POMYEONGDONG_INOUT2", 5); // argument 갯수

			psql.setString(i++, mi1.getString("STR_CD")); // 점코드
			psql.setString(i++, mi1.getString("PAY_YM")); // 전송년월
			psql.setString(i++, userId); // 사용자

			psql.registerOutParameter(i++, DataTypes.INTEGER);// 4
			psql.registerOutParameter(i++, DataTypes.VARCHAR);// 5

			// proceduare call
			prs = updateProcedure(psql);

			resp += prs.getInt(4);
			System.out.println(resp + "registerOutParameter");
			if (resp < 0) {
				throw new Exception("[USER]" + prs.getString(5));
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
	 * 최종 매입 년월 구하기.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public List getLastMonth(ActionForm form) throws Exception {       /* Action에서 call*/
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LASTMONTH"));

		// SELECT CALL
		ret = select2List(sql);
		return ret;
	}	
}
