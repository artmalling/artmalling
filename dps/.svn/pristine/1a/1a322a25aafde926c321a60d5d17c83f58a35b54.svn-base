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

import common.util.Util;
//import java.util.Map;

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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal532DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strOriginAreaCd 	  = String2.nvl(form.getParam("strOriginAreaCd"));
		String strPumbunCd        = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOriginAreaCd);
		sql.setString(i++, strPumbunCd);
	
		ret = select2List(sql);
		
		return ret;
	}


	/**
	 * 디테일조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDitail(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strOriginAreaCd 	  = String2.nvl(form.getParam("strOriginAreaCd"));
		String strPumbunCd        = String2.nvl(form.getParam("strPumbunCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DITAIL"));
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		ret = select2List(sql);
		
		return ret;
	}


	
	/**
	 * 공제등록 조회 
	 *        
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkKeyVlaue(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
		int i = 1;               
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm = String2.nvl(form.getParam("strSaleYm"));
		String strOrdererCd = String2.nvl(form.getParam("strOrdererCd"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strGubun = String2.nvl(form.getParam("strGubun"));
		
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
		
			sql.put(svc.getQuery("CHECK_JUNGBOK"));
			
			sql.setString(i++, strSaleYm);
			sql.setString(i++, strStrCd);		
			sql.setString(i++, strPumbunCd);	
	      	                      
			ret = select2List(sql);
			
		return ret;
	}	
	
	/**
	 * 공제등록 조회 
	 *        
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkKeyVlaue2(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
		int i = 1;               
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm = String2.nvl(form.getParam("strSaleYm"));
		String strOrdererCd = String2.nvl(form.getParam("strOrdererCd"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strGubun = String2.nvl(form.getParam("strGubun"));
		
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
			sql.put(svc.getQuery("CHECK_JUNGBOK2"));
			
			sql.setString(i++, strSaleYm);
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strOrdererCd);	
			sql.setString(i++, strPumbunCd);	
	      	                      
			ret = select2List(sql);
		
		return ret;
	}

	/**
	 *  공제등록  등록/수정한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1[],String userId, String org_flag)
			throws Exception {
		int ret 	= 0;
		try{
		connect("pot");
		begin();
		ret+=saveMaster(form, mi1[0],userId,org_flag);
		ret+=saveDetail(form, mi1[1],userId,org_flag);
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}	
		return ret;
	}

	private int saveMaster(ActionForm form, MultiInput mi1, String userId,String org_flag)throws Exception {
		int ret 	= 0;
		int res 	= 0;
		int i   	= 0; 
		
		
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				sql.close();
				if (mi1.IS_INSERT()) { // 저장	
						i = 1; 
						
						sql.put(svc.getQuery("INS_MASTER"));
						
						
						sql.setString(i++, mi1.getString("SALE_YM"));  
						sql.setString(i++, mi1.getString("STR_CD"));             
						sql.setString(i++, mi1.getString("ORDERER_CD"));     
						sql.setString(i++, mi1.getString("PUMBUN_CD"));     
						sql.setString(i++, mi1.getString("ORDERER_COMIS_RATE"));
						sql.setString(i++, mi1.getString("MARIO_PROF_RATE"));
						sql.setString(i++, mi1.getString("AGENCY_PROF_RATE"));        // 순번만들기
						sql.setString(i++, userId);
						sql.setString(i++, userId);
					
				}else if(mi1.IS_UPDATE()){// 수정 
					i = 1;
					// 1. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
					
					
					sql.setString(i++, mi1.getString("ORDERER_CD"));  
					sql.setString(i++, mi1.getString("ORDERER_COMIS_RATE"));             
					sql.setString(i++, mi1.getString("MARIO_PROF_RATE"));     
					sql.setString(i++, mi1.getString("AGENCY_PROF_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("SALE_YM"));  
					sql.setString(i++, mi1.getString("STR_CD"));             
					sql.setString(i++, mi1.getString("ORDERER_CD"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));

				}else if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("DEL_MASTER")); 
					
					
					sql.setString(i++, mi1.getString("SALE_YM"));  
					sql.setString(i++, mi1.getString("STR_CD"));             
					sql.setString(i++, mi1.getString("ORDERER_CD")); 
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
				}
				res = update(sql);

				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				ret += res;
			}
		} catch (Exception e) { 
			rollback();
			throw e;
		} finally { 
			end();
		}
		return ret;
	}

	public int saveDetail(ActionForm form, MultiInput mi1, String userId,
			String org_flag)throws Exception {
		int ret 	= 0;
		int res 	= 0;
		int i   	= 0; 
		
		
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				sql.close();
				if (mi1.IS_INSERT()) { // 저장
					// 2.전표번호를 생성한다.(MAX+1 이용)
						i = 1; 
						// 1. 마스터테이블에 저장
						
						sql.put(svc.getQuery("INS_DETAIL"));
						
						sql.setString(i++, mi1.getString("SALE_YM"));  
						sql.setString(i++, mi1.getString("STR_CD"));      
						sql.setString(i++, mi1.getString("PUMBUN_CD"));
						sql.setString(i++, mi1.getString("MARIO_PROF_RATE"));
						sql.setString(i++, userId);
						sql.setString(i++, userId);
					
				}else if(mi1.IS_UPDATE()){// 수정 
					i = 1;
					// 1. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_DETAIL")); 
					 
					sql.setString(i++, mi1.getString("MARIO_PROF_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("SALE_YM"));  
					sql.setString(i++, mi1.getString("STR_CD")); 
					sql.setString(i++, mi1.getString("PUMBUN_CD")); 
					

				}else if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("DEL_DETAIL")); 
					
					sql.setString(i++, mi1.getString("SALE_YM"));  
					sql.setString(i++, mi1.getString("STR_CD"));             
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					
				}
				res = update(sql);

				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				ret += res;
			}
		} catch (Exception e) { 
			rollback();
			throw e;
		} finally { 
			end();
		}
		return ret;
	}


	public List searchCharge(ActionForm form, String orgFlag, String userid)throws Exception {
	
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strOriginAreaCd 	  = String2.nvl(form.getParam("strOriginAreaCd"));
		String strPumbunCd        = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		sql.put(svc.getQuery("SEL_CHARGE"));
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strSaleYm);
		
		ret = select2List(sql);
		
		return ret;
	}


	public List searchInterest(ActionForm form, String orgFlag, String userid)throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strPumbunCd        = String2.nvl(form.getParam("strPumbunCd"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MARIO_PROF_RATE"));
		
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
	
		ret = select2List(sql);
		
		return ret;
	}
public List searchMarioeek(ActionForm form, String orgFlag, String userid)throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strPumbunCd        = String2.nvl(form.getParam("strPumbunCd"));
		
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MARIO_PROF_RATE2"));
		
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
	
		ret = select2List(sql);
		
		return ret;
	}
public String valCheck(ActionForm form, MultiInput mi1, String userId, String org_flag)
		throws Exception {
		int resp    		= 0;     //프로시저 리턴값
		String res			= "";
		int i   			= 0;
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStrDt = String2.nvl(form.getParam("strStrDt"));
		
		
		
		try {
		
		connect("pot");
		begin();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		psql = new ProcedureWrapper();	//프로시저 사용위함
		ProcedureResultSet prs = null;
		
		i = 1;    
		psql.put("DPS.PR_PSCOMISONLIECP", 5); 
		psql.setString(i++, strStrCd); 		// 점코드
		psql.setString(i++, strStrDt); 		// 지불년월
		psql.setString(i++, userId);		// 지불주기
		psql.registerOutParameter(i++, DataTypes.INTEGER);//5
		psql.registerOutParameter(i++, DataTypes.VARCHAR);//6
		
		prs = updateProcedure(psql);
		
		resp += prs.getInt(4);         
		
		
		if (resp != 0) {
		    throw new Exception("[USER]"+ prs.getString(5));
		}else{
			res = prs.getString(5);
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
