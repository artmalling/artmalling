/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;


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
 * <p>상품권무인정산입금내역</p>
 * 
 * @created  on 1.0, 2016/10/27
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal612DAO extends AbstractDAO {

	/**
	 * 상품권무인정산입금내역 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 0;	
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
		String strSaleEndDt   = String2.nvl(form.getParam("strSaleEndDt"));
		String strPosNo       = String2.nvl(form.getParam("strPosNo"));
		String strGiftNo 	  = String2.nvl(form.getParam("strGiftNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strSaleEndDt);
		sql.setString(++i, strGiftNo);
		sql.setString(++i, strPosNo);
//		sql.setString(++i, strId);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 상품권무인정산입금내역 상세조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;                         
		String strQuery = "";
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStrDt = String2.nvl(form.getParam("strStrDt"));
		String strEndDt = String2.nvl(form.getParam("strEndDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		//String strGiftNo = String2.nvl(form.getParam("strGiftNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrDt);
		sql.setString(++i, strEndDt);
		//sql.setString(++i, strGiftNo);
		sql.setString(++i, strPosNo);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 무인정산자료 비교표 상세조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkProcess(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;                         
		String strQuery = "";
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strProcDt = String2.nvl(form.getParam("strDate"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_DATE") + "\n";
		sql.setString(++i, strStrCd);
		sql.setString(++i, strProcDt);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strProcDt);
		sql.put(strQuery);
		
		ret = select2List(sql);
		commit();
		return ret;
	}
	
	/**
	 *  공제 회계전송
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String runProcess(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		String res          = "";
		int i   			= 0;
		
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			System.out.println("try");
			connect("pot");
			begin();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;

			String strStrCd = String2.nvl(form.getParam("strStrCd"));
			String strDate  = String2.nvl(form.getParam("strDate"));
			String strGb	= String2.nvl(form.getParam("strGb"));
			
			
			//mi1.next();
			i = 1;
			psql.put("DPS.PR_PSVALEX_CUR_IFS_M", 5);
			
		     
            psql.setString(i++, strStrCd); 		// 점코드
            psql.setString(i++, strDate);		// 처리일자
            psql.setString(i++, strGb);			// 처리구분
            psql.registerOutParameter(i++, DataTypes.INTEGER);	// 4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);	// 5
            System.out.println("procdure call");
            prs = updateProcedure(psql);
            System.out.println(prs);
            resp += prs.getInt(4);    
            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(5));
            }else{
            	res = prs.getString(5);
            }
			
            commit();
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
}

