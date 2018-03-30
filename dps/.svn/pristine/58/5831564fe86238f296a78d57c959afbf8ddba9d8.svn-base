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
 * <p>재고조정확정(집계)관리</p>
 * 
 * @created  on 1.0, 2010/04/12
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk214DAO extends AbstractDAO {

	/**
	 * 실사재고 마스터정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userId) throws Exception {		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strSrvyDt     = String2.nvl(form.getParam("strSrvyDt"));
		String strStkYyyy    = String2.nvl(form.getParam("strStkYyyy"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_TOTAL_SKU") + "\n";
		
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, strPumbunCd);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, strPumbunCd);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, strPumbunCd);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, strPumbunCd);
		
		
		sql.setString(i++, strStkYm);


		sql.put(strQuery);

		ret = select2List(sql);
		return ret;		
	}
	
	
	/**
	 * 재고실사일을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSrvyDt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));	
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_SRVY_DT");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 마진정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMargin(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));		
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));		

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);	
		
		strQuery = svc.getQuery("SEL_EVENT_FLAG");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 재고조정을 확정(집계)한다.
	 * @param form
	 * @param mi
	 * @return
	 */	
	public String conf( ActionForm form, MultiInput mi, String strID) throws Exception{
		int ret  = 0;
		//int res  = 0;
		String res = "";
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";
		int i;
		try {
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			connect("pot");
			begin();
			
		    String strStkDt   = String2.nvl(form.getParam("strStkDt")); 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				/*
				if(!mi.getString("CONF_ID").equals("")){
					sql.put(svc.getQuery("SEL_SCHEDULE_STRCD_CNT"));							
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
				}
				*/
				String strFlag    = mi.getString("FLAG");
				
				// 단품
				if(strFlag.equals("1")){
					psql.put("DPS.PR_PTTOTALSKU", 9);    
		            psql.setString(1, mi.getString("STR_CD"));     //점코드
		            psql.setString(2, mi.getString("STK_YM"));     //재고조사년월
		            psql.setString(3, strStkDt);                   //재고일자
		            psql.setString(4, mi.getString("PUMBUN_CD"));  //품번코드
		            psql.setString(5, mi.getString("CONF_DT"));    //확정일자
		            if(mi.getString("CONF_ID").equals(""))
		            	psql.setString(6, strID);
		            else
		            	psql.setString(6, mi.getString("CONF_ID"));//확정자
		            psql.setString(7, strID);     //입력자
		            psql.registerOutParameter(8, DataTypes.VARCHAR);//8
		            psql.registerOutParameter(9, DataTypes.VARCHAR);//9
		            prs = updateProcedure(psql);
		            
		        // 비단품
				}else if(strFlag.equals("2")){
					psql.put("DPS.PR_PTTOTALPBN", 9);    
		            psql.setString(1, mi.getString("STR_CD"));     //점코드
		            psql.setString(2, mi.getString("STK_YM"));     //재고조사년월
		            psql.setString(3, strStkDt);                   //재고일자
		            psql.setString(4, mi.getString("PUMBUN_CD"));  //품번코드		            
		            psql.setString(5, mi.getString("CONF_DT"));    //확정일자
		            if(mi.getString("CONF_ID").equals(""))
		            	psql.setString(6, strID);
		            else
		            	psql.setString(6, mi.getString("CONF_ID"));//확정자
		            psql.setString(7, strID);     //입력자
		            psql.registerOutParameter(8, DataTypes.VARCHAR);//8
		            psql.registerOutParameter(9, DataTypes.VARCHAR);//9
		            prs = updateProcedure(psql);
				}	
	            
				resp = prs.getInt(8);
				res = prs.getString(9);	            
	            if (resp != 0) {
	                throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "확정(확정취소)하지 못했습니다.");
	            }
				//ret += resp;
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
