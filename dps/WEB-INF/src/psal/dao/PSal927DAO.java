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
 * <p> 청구대상 데이터 조회DAO </p>
 * 
 * @created on 1.0, 2010/05/31
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal927DAO extends AbstractDAO {
	/**
	 * <p>
	 * 청구대상 데이터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		//String query = "";
		String strQuery = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		String strReqDt    = String2.nvl(form.getParam("strReqDt"));
		String strReqToDt  = String2.nvl(form.getParam("strReqToDt")); 
		String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));   
		String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));  
		String strCardNo   = String2.nvl(form.getParam("strCardNo"));    
		String strApprNo   = String2.nvl(form.getParam("strApprNo"));  
		String strDivMonth   = String2.nvl(form.getParam("strDivMonth"));  

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery += svc.getQuery("SEL_MASTER") + "\n";

		//query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strReqDt   );
		sql.setString(i++, strReqToDt   );
		
		if(!strBcompCd.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
			sql.setString(i++, strBcompCd);
		}
		if(!strJbrchId.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
			sql.setString(i++, strJbrchId);
		}
		if(!strCardNo.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
			sql.setString(i++, strCardNo);
		}
		if(!strApprNo.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
			sql.setString(i++, strApprNo);
		}
		if(!strDivMonth.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
			sql.setString(i++, strDivMonth);
		}	

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 *  매출회계전표생성처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {
				
		int res = 0;
		
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

			while (mi.next()) { 
				
				if (mi.IS_UPDATE()){
					sql.close();         
	                  int i=0;
	                  
	                  sql.put(svc.getQuery("SEL_UPD_BUYREQPREP")); 
	                  
	                  sql.setString(++i, mi.getString("REC_FLAG"));
	                  sql.setString(++i, mi.getString("DEVICE_ID"));
	                  sql.setString(++i, mi.getString("WORK_FLAG"));
	                  sql.setString(++i, mi.getString("COMP_NO"));
	                  sql.setString(++i, mi.getString("CARD_NO"));
	                  sql.setString(++i, mi.getString("EXP_DT"));
	                  sql.setString(++i, mi.getString("DIV_MONTH"));
	                  sql.setDouble(++i, mi.getDouble("APPR_AMT"));
	                  sql.setDouble(++i, mi.getDouble("SVC_AMT"));
	                  sql.setString(++i, mi.getString("APPR_NO"));
	                  sql.setString(++i, mi.getString("APPR_DT"));
	                  sql.setString(++i, mi.getString("APPR_TIME"));
	                  sql.setString(++i, mi.getString("CAN_DT"));
	                  sql.setString(++i, mi.getString("CAN_TIME"));
	                  sql.setString(++i, mi.getString("CCOMP_CD"));
	                  sql.setString(++i, mi.getString("BCOMP_CD"));
	                  sql.setString(++i, mi.getString("JBRCH_ID"));
	                  sql.setString(++i, mi.getString("DOLLAR_FLAG"));
	                  sql.setString(++i, mi.getString("FILLER")); 
	                  sql.setString(++i, userId); 	                 
	                  sql.setString(++i, mi.getString("REQ_DT"));
	                  sql.setString(++i, mi.getString("FCL_FLAG"));
	                  sql.setString(++i, mi.getString("SEQ_NO")); 
	                  
	                  res = update(sql);
	                  
	                  if (res != 1) {
	                      throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
	                              + "데이터 입력을 하지 못했습니다.");
	                  }
	                  
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
}
