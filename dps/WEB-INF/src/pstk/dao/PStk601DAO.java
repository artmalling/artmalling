/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;
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
 * <p>직영운영점 규격단품 장부재고관리</p>
 * 
 * @created  on 1.0, 2010/05/13
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk601DAO extends AbstractDAO {


	/**
	 * 직영운영점 규격단품 장부재고관리한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strStkSDt      = String2.nvl(form.getParam("strStkSDt"));
		String strStkEDt      = String2.nvl(form.getParam("strStkEDt"));
		String strStkYm       = String2.nvl(form.getParam("strStkYm"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery += svc.getQuery("SEL_MASTER");
		sql.put(strQuery);
		sql.setString(i++, strStkEDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkSDt);
		sql.setString(i++, strStkEDt);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strStkEDt);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 직영운영 장부재고매가관리
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret        = 0;
		int res        = 0;
		int nProCnt    = 0;
		Util util      = new Util();
		SqlWrapper sql = null;
		Service svc    = null;
		int nSeqNo     = 0;

		ProcedureResultSet prs = null;
		
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				if (mi.IS_UPDATE()) {

					i = 0;		
					// SEQ를 생성한다.
					sql.put(svc.getQuery("SEL_SEQ"));
					sql.setString(++i, mi.getString("CURRENT_DT"));		
					sql.setString(++i, mi.getString("STR_CD"));		
					sql.setString(++i, mi.getString("PUMBUN_CD"));		
					sql.setString(++i, mi.getString("SKU_CD"));
					
					Map mapSeqNo = (Map)selectMap(sql);
					nSeqNo = Integer.parseInt(mapSeqNo.get("SEQ").toString());
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("INS_MASTER"));
					sql.setString(++i, mi.getString("CURRENT_DT"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("SKU_CD"));
					sql.setInt(++i, nSeqNo);
					sql.setInt(++i, mi.getInt("CURRENT_QTY"));
					sql.setDouble(++i, mi.getDouble("COST_PRC"));
					sql.setDouble(++i, mi.getDouble("SALE_PRC"));
					sql.setDouble(++i, mi.getDouble("SALE_AMT"));
					sql.setDouble(++i, mi.getDouble("CURRENT_SALE_AMT"));
					sql.setDouble(++i, mi.getDouble("GAP_SALE_AMT"));		
					sql.setString(++i, "N");		// 처리여부
					sql.setString(++i, "");			// 전표번호
					sql.setString(++i, strID);					
					res = update(sql);

					ret += res;
					if (ret < 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
			}
			
			// 재고반영 프로시저
			prs = callProc(form);
			nProCnt = prs.getInt(4);    
	        
	        if (nProCnt < 0) {
	            throw new Exception("[USER]"+ prs.getString(5));
	        } 

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 *  <p>
	 *  재고반영 프로시저 호출
	 *  </p>
	 * @throws Exception
	 */
	public ProcedureResultSet callProc(ActionForm form)throws Exception {

		int i;		
		ProcedureWrapper psql  = null;	//프로시저 사용위함
		ProcedureResultSet prs = null;
		psql = new ProcedureWrapper();	//프로시저 사용위함

		String strCurrenDt = String2.nvl(form.getParam("strCurrenDt"));
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		i = 1;
		psql.put("DPS.PR_POAUTOPRCMODSLP_DC", 5);  
        psql.setString(i++, strCurrenDt);		// 처리일자
        psql.setString(i++, strStrCd);			// 점코드
        psql.setString(i++, strPumbunCd);		// 브랜드코드
        psql.registerOutParameter(i++, DataTypes.INTEGER);//4
        psql.registerOutParameter(i++, DataTypes.VARCHAR);//5

        prs  = updateProcedure(psql);                                            
		return prs;
	}
}
