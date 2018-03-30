/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package meis.dao;

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
 * <p>경영실적생성</p>
 * 
 * @created on 1.0, 2011/06/20
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis070DAO extends AbstractDAO {

	/**
	 * 년월별경영실적보고서 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizRslt(ActionForm form) throws Exception {

		List ret           = null;
		SqlWrapper sql     = null;
		Service svc        = null;
		String strLoc      = null;
		int i              = 1;
		//파라미터 변수선언
		String strRsltYm = null;

		try {
			//파라미터 값 가져오기
			strRsltYm   = String2.trimToEmpty(form.getParam("strRsltYm"));

			strLoc = "SEL_BIZ_RSLT";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strRsltYm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 보고서 생성/삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		SqlWrapper sql = null;
		ProcedureResultSet procResult = null;
		
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			while(mi.next()){
				if("Y".equals(mi.getString("CREATE_FLAG2"))){
					//삭제
					deleteReport(svc, mi);
					ret++;
				} else {
					//생성
					procResult = create(svc, mi);
					//에러처리
					if (!"0".equals(procResult.getString(3)))
						throw new Exception("[USER]"+ procResult.getString(4));
					ret++;
				}
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
	 *  <p>보고서 삭제</p>
	 */
	private int deleteReport(Service svc, MultiInput mi) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_REPORT";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("RSLT_YEAR"));
		sql.setString(++i, mi.getString("STR_CD"));

		ret = this.update(sql);
		
		return ret;
	}
	
	/**
	 * 보고서 생성
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	private ProcedureResultSet create(Service svc, MultiInput mi)
			throws Exception {

		ProcedureWrapper proc = null;
		int i = 0;
		proc = new ProcedureWrapper();
		proc.put("MSS.PR_MEBIZRSLTRPT", 4);

		proc.setString(++i, mi.getString("STR_CD"));
		proc.setString(++i, mi.getString("RSLT_YEAR"));
		proc.registerOutParameter(++i, DataTypes.VARCHAR);
		proc.registerOutParameter(++i, DataTypes.VARCHAR);

		return updateProcedure(proc);

	}
}
