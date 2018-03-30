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
 * <p>월평가내역확정/p> 
 * 
 * @created  on 1.0, 2011/06/27
 * @created  by 김경은
 * 
 * @modified on   
 * @modified by                    
 * @caused   by           
 */

public class PSal705DAO extends AbstractDAO {
	/**
	 * 월평가내역확정  데이터 조회
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null; 
		Service svc = null;
		int i = 1;          

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strBumun      = String2.nvl(form.getParam("strBumun"));
		String strTeam       = String2.nvl(form.getParam("strTeam"));
		String strPc         = String2.nvl(form.getParam("strPc"));
		String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
		String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));
		String strBizType    = String2.nvl(form.getParam("strBizType"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER")); 
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		//sql.setString(i++, strOrgCd); 
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		//sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, userId); 
		sql.setString(i++, strOrgCd); 
		

		ret = select2List(sql);
		return ret;
	}
	

	/**
	 *  월평가내역확정 한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int conf(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		
		SqlWrapper sql = null;
		Service svc    = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				
				sql.close();
				if(mi1.IS_UPDATE()){// 수정

					i = 1;        
					sql.put(svc.getQuery("CONF_MASTER"));                               

					sql.setString(i++, mi1.getString("SEL"));  
					sql.setString(i++, mi1.getString("NORM_SAMT"));   	 		
					sql.setString(i++, mi1.getString("EVT_SAMT"));   	 		
					sql.setString(i++, mi1.getString("TOT_SAMT"));   	 		  
					sql.setString(i++, mi1.getString("PYUNG_SALE"));   	 		
					sql.setString(i++, mi1.getString("SALE_PROF_AMT"));
					sql.setDouble(i++, mi1.getDouble("SALE_PROF_RATE"));
					sql.setDouble(i++, mi1.getDouble("SALE_PROF_RATE"));
					sql.setDouble(i++, mi1.getDouble("SALE_IRATE"));
					sql.setDouble(i++, mi1.getDouble("SALE_IRATE"));
					
					sql.setString(i++, userId); 
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("EVALU_YM"));       	 // 평가년월 
					sql.setString(i++, mi1.getString("PUMBUN_CD"));   	 	 // 품번 
				}

				res = update(sql);
				
				// 월별상세 데이터를 저장한다.
				saveYmDetail(form, mi1, userId);
				
				// 년도별 마스터  데이터를 저장한다. 
				//saveYyMaster(form, mi1, userId);
				
				// 년도별상세 데이터를 저장한다.
				//saveYyDetail(form, mi1, userId);
				
				if (res <= 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}
			
			// 월평가내역 집계처리한다.
			//pSVenEvalue(form, mi1, userId);
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 *  월별 상세데이터를 저장한다.
	 *  
	 * @param mi1
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int saveYmDetail(ActionForm form, MultiInput mi1, String userId) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;	
		String strEvaluCd[]    = {"01","02","03","04","05","06","07"};
		String strEvaluScore[] = {"SALE_SCORE","PROF_SCORE","PROF_RATE_SCORE","EXPAN_RATE_SCORE","PYUNG_RATE_SCORE","BUYER_SCORE","CS_SCORE"};
		
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			System.out.println("len::"+strEvaluCd.length+"::"+strEvaluCd+"::"+strEvaluScore);
			for (int k=0; k < strEvaluCd.length; k++){
				sql.close();
				i = 1; 
				
				// 상세테이블에 저장
				sql.put(svc.getQuery("INS_YM_DETAIL"));
				
				sql.setString(i++, mi1.getString("STR_CD"));           
				sql.setString(i++, mi1.getString("EVALU_YM"));   				
				sql.setString(i++, mi1.getString("PUMBUN_CD"));   		
				sql.setString(i++, strEvaluCd[k]);					
				sql.setString(i++, mi1.getString("SEL"));  
				
				sql.setString(i++, mi1.getString(strEvaluScore[k]));   			  
				sql.setString(i++, userId);
				
				sql.setString(i++, mi1.getString("STR_CD"));           
				sql.setString(i++, mi1.getString("EVALU_YM"));   				
				sql.setString(i++, mi1.getString("PUMBUN_CD"));   		
				sql.setString(i++, strEvaluCd[k]);
				sql.setString(i++, mi1.getString(strEvaluScore[k]));   	
				sql.setString(i++, mi1.getString("SEL"));  
				sql.setString(i++, userId); 
				sql.setString(i++, userId);                 
	
				res = update(sql);
			}
			
			if(ret == 0){
				ret = res;        
			}
			
			if (res <= 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}                                                   
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 *  년별 마스터데이터를 저장한다.
	 *  
	 * @param mi1
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int saveYyMaster(ActionForm form, MultiInput mi1, String userId) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;	
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.close();
			i = 1; 
			
			// 마스터 테이블에 저장
			sql.put(svc.getQuery("INS_YY_MASTER"));
			
			sql.setString(i++, mi1.getString("EVALU_YM").substring(0,4));
			sql.setString(i++, mi1.getString("STR_CD"));           
			sql.setString(i++, mi1.getString("EVALU_YM").substring(0,4));   				
			sql.setString(i++, mi1.getString("PUMBUN_CD"));   	
			sql.setString(i++, mi1.getString("SEL"));  
			
			sql.setString(i++, userId);
			
			sql.setString(i++, mi1.getString("ORG_CD")); 
			sql.setString(i++, mi1.getString("AREA_SIZE"));
			sql.setString(i++, mi1.getString("PUMBUN_GRADE"));
			sql.setString(i++, mi1.getString("PUMBUN_WEIGHT"));
			
			sql.setString(i++, mi1.getString("SEL"));  
			sql.setString(i++, userId);
			sql.setString(i++, userId);		

			res = update(sql);
			
			if (res <= 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}                                                   
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 *  년별 상세데이터를 저장한다.
	 *  
	 * @param mi1
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int saveYyDetail(ActionForm form, MultiInput mi1, String userId) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;	
		String strEvaluCd[]    = {"01","02","03","04","05","06","07"};
		String strEvaluScore[] = {"SALE_SCORE","PROF_SCORE","PROF_RATE_SCORE","EXPAN_RATE_SCORE","PYUNG_RATE_SCORE","BUYER_SCORE","CS_SCORE"};
		
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			System.out.println("len::"+strEvaluCd.length+"::"+strEvaluCd+"::"+strEvaluScore);
			for (int k=0; k < strEvaluCd.length; k++){
				sql.close();
				i = 1;  
				
				// 상세테이블에 저장
				sql.put(svc.getQuery("INS_YY_DETAIL"));
				
				sql.setString(i++, mi1.getString("EVALU_YM").substring(0,4));
				sql.setString(i++, mi1.getString("STR_CD"));           
				sql.setString(i++, mi1.getString("EVALU_YM").substring(0,4));   				
				sql.setString(i++, mi1.getString("PUMBUN_CD"));   		
				sql.setString(i++, strEvaluCd[k]);		
				sql.setString(i++, mi1.getString("SEL"));  

				sql.setString(i++, userId);
				sql.setString(i++, mi1.getString("SEL"));  
				sql.setString(i++, userId);
				sql.setString(i++, userId);		
	
				res = update(sql);
			}
			
			if(ret == 0){
				ret = res;        
			}
			
			if (res <= 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}                                                   
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 *  월평가내역 집계처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int pSVenEvalue(ActionForm form, MultiInput mi1, String userId)
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
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;

			String strStrCd      = String2.nvl(form.getParam("strStrCd"));
			String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));
			
			i = 1;            
			psql.put("DPS.PR_PSVENEVALUE", 5);  
			     
			psql.setString(i++, strStrCd);   	 		 // 점코드 
			psql.setString(i++, strEvaluYm); 
            psql.setString(i++, userId);
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

            prs = updateProcedure(psql);
            
            resp += prs.getInt(4);    

            if (resp < 0) {
                throw new Exception("[USER]"+ prs.getString(5));
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
