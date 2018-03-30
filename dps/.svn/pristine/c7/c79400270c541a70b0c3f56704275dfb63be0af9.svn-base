/*
 * Copyright (c) 2130 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.net.URLDecoder;
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
 * <p>마감관리</p>
 * 
 * @created  on 1.0, 2010/05/17
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk213DAO extends AbstractDAO {

	/**
	 * 마스터정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form , String userId , String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStkYm = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		//sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		//sql.setString(i++, userId);
		//sql.setString(i++, orgFlag);
		
		strQuery = svc.getQuery("SEL_SCHEDULE") + "\n";
		
		if( !strStkYm.equals("")){
			sql.setString(i++, strStkYm);
			strQuery += svc.getQuery("SEL_SCHEDULE_STK_YM") + "\n";
		}	

		strQuery += svc.getQuery("SEL_SCHEDULE_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 디을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOverLap(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String orgCdCnt = "";
		int i = 1;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStkYm = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_SCHEDULE_STRCD_CNT") + "\n";
		
		sql.put(strQuery);		

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 재고실사일정을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String conf(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret  = 0;
		//int res  = 0;
		String res = "";
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		SqlWrapper sql = null;
		Service svc = null;
		
		int i;
		try {
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			connect("pot");
			begin();
			
		    String strMagamFlag   = String2.nvl(form.getParam("strMagamFlag")); 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {

				psql.put("DPS.PR_PTSTKSKUMAGAM", 6);    
	            psql.setString(1, mi.getString("STR_CD"));     //점코드
	            psql.setString(2, mi.getString("STK_YM"));     //재고조사년월
	            psql.setString(3, mi.getString("CLOSE_DT"));    //확정일자
	            if(mi.getString("CLOSE_ID").equals(""))
	            	psql.setString(4, strID);
	            else
	            	psql.setString(4, mi.getString("CLOSE_ID"));//확정자
	            
	            psql.setString(5, strMagamFlag); 
	            psql.registerOutParameter(6, DataTypes.INTEGER);//8
	            prs = updateProcedure(psql);
	            		            
	            resp = prs.getInt(6);
	            
				res = prs.getString(6);	            
	            if (resp != 0) {
	                throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "확정(확정취소)하지 못했습니다.");
	            }

		            
		            		            
	            psql = new ProcedureWrapper();
				psql.put("DPS.PR_PTSTKPBNMAGAM", 6);    
				psql.setString(1, mi.getString("STR_CD"));     //점코드
	            psql.setString(2, mi.getString("STK_YM"));     //재고조사년월
	            psql.setString(3, mi.getString("CLOSE_DT"));    //확정일자
	            if(mi.getString("CLOSE_ID").equals(""))
	            	psql.setString(4, strID);
	            else
	            	psql.setString(4, mi.getString("CLOSE_ID"));//확정자
	            
	            psql.setString(5, strMagamFlag); 
	            psql.registerOutParameter(6, DataTypes.INTEGER);//8
	            prs = updateProcedure(psql);
	            resp = prs.getInt(6);


				res = prs.getString(6);	            
	            if (resp != 0) {
	                throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "확정(확정취소)하지 못했습니다.");
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
