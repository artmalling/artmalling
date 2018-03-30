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
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;

/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/23
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal216DAO extends AbstractDAO {

	/**
	 * 실행PC별가중치 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		//String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		//String strPCCd       = String2.nvl(form.getParam("strPCCd"));
		String strPlanYm     = String2.nvl(form.getParam("strPlanYm"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_ACTPUMBUN"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanYm);
		sql.setString(i++, userId);
		sql.setString(i++, strTeamCd);
		//sql.setString(i++, strPCCd);

		
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 실행PC별가중치 상세 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		int k           = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd       = String2.nvl(form.getParam("strPCCd"));
		String strYYYYMM     = String2.nvl(form.getParam("strYYYYMM"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		//sql.put(svc.getQuery("H_SEL_DETAIL"));
		
		strQuery  = svc.getQuery("H_SEL_DETAIL")+ "\n ";
		
		sql.setString(i++, strYYYYMM);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYYYYMM);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, userId);
		
		
        sql.put(strQuery);
        
		ret = select2List(sql);
		
		return ret;
	}
	
	public int searchDetail_new(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		int k           = 1;
		int res = 0;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd       = String2.nvl(form.getParam("strPCCd"));
		String strYYYYMM     = String2.nvl(form.getParam("strYYYYMM"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		
		
		try {
			connect("pot");
			begin();
			//sql.put(svc.getQuery("H_SEL_DETAIL"));
			
			strQuery  = svc.getQuery("H_SEL_DETAIL_NEW")+ "\n ";
			
			//sql.setString(i++, strStrCd);
			sql.setString(i++, strYYYYMM);
			sql.setString(i++, userId);
			sql.setString(i++, userId);
			//sql.setString(i++, strYYYYMM);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strYYYYMM);
			sql.setString(i++, strYYYYMM);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strYYYYMM);
			
			sql.setString(i++, strYYYYMM);
			sql.setString(i++, strYYYYMM);
			sql.setString(i++, strStrCd);
			
			sql.setString(i++, strYYYYMM);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strYYYYMM);
			
			
			sql.setString(i++, userId);
	
			//sql.setString(i++, strDeptCd);
			//sql.setString(i++, strTeamCd);
			//sql.setString(i++, strPCCd);
			
			//sql.setString(i++, strYYYYMM);
			//sql.setString(i++, strYYYYMM);
			
			
			
			
			
	        sql.put(strQuery);
	        
			//ret = select2List(sql);
	        res = update(sql); 


		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}

	/**
	 * 영업일정보 체크 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBfyyWeek(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strYYYYMM   = String2.nvl(form.getParam("strYYYYMM"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_BFYY_WEEK"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strYYYYMM);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초품번별월매출계획 확정데이터  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchConfFlag(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strYYYYMM 		= String2.nvl(form.getParam("strYYYYMM"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_CONF_FLAG_M"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strYYYYMM);
		
		ret = select2List(sql);
		
		return ret;
	}



	/**
	 * 당초PC별월매출계획   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String saveconf(ActionForm form, MultiInput mi1, String userId)
			throws Exception {


		int resp    		= 0;     //프로시저 리턴값
		int i   			= 0;
		String res          = "";
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		String yyyymm 		= String2.nvl(form.getParam("yyyymm"));
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		
		try {
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;

			
			System.out.println(userId);
			System.out.println(yyyymm);
			System.out.println(strStrCd);
			
			i = 1;
			psql.put("DPS.PR_PSACTUPDATE", 4); 
			psql.setString(i++, strStrCd);
            psql.setString(i++, yyyymm); 	
            psql.setString(i++, userId);		
            

            psql.registerOutParameter(i++, DataTypes.VARCHAR);
            prs = updateProcedure(psql);

 

            if (resp != 0) {
                throw new Exception("[USER-처리되었습니다.]");
            }else{
            	res = prs.getString(4);
            }
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}

	/**
	 * 실행품번별일매출계획   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strFlag  = "";
        int i = 1;
        int k = 1;
        ProcedureResultSet procResult = null;
        
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 	= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd    = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 	    = String2.nvl(form.getParam("strPCCd"));
		String strYYYYMM 	= String2.nvl(form.getParam("strYYYYMM"));
		String strEndDate   = String2.nvl(form.getParam("strEndDate"));

		int endDate         = Integer.parseInt(strEndDate);
		int originSaleIRate = 0;
		int originProfIRate = 0;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				
				if (mi[0].IS_INSERT() || mi[0].IS_UPDATE()) {
					
					for(k=1; k <= endDate; k++ ){

						
						i = 1;
						sql.close(); 
						sql.put(svc.getQuery("UPD_PS_ACTPUMBUN"));

						
						
						sql.setString(i++, strYYYYMM);
						
						if(k < 10){
							sql.setString(i++, strYYYYMM+"0"+k);
						}
						else{
							sql.setString(i++, strYYYYMM+k);
						}

						if(k < 10){
							sql.setString(i++, mi[0].getString("SALE0"+k));
							sql.setString(i++, mi[0].getString("SALE0"+k));
						}
						else {
							sql.setString(i++, mi[0].getString("SALE"+k));
							sql.setString(i++, mi[0].getString("SALE"+k));
						}
						
						sql.setString(i++, strID);
						sql.setString(i++, strStrCd);	
						sql.setString(i++, mi[0].getString("PUMBUN_CD"));

						res = update(sql);
		                
					}
					if(res > 0 ) ret = 1;
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
	
	public int search_new(ActionForm form, MultiInput mi[], String strID)
			throws Exception {
		
		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strFlag  = "";
		int i = 1;
		int k = 1;
		ProcedureResultSet procResult = null;
		
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 	= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd    = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 	    = String2.nvl(form.getParam("strPCCd"));
		String strYYYYMM 	= String2.nvl(form.getParam("strYYYYMM"));
		String strEndDate   = String2.nvl(form.getParam("strEndDate"));
		
		int endDate         = Integer.parseInt(strEndDate);
		int originSaleIRate = 0;
		int originProfIRate = 0;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
		
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				
				if (mi[0].IS_UPDATE()) {
					
					for(k=1; k <= endDate; k++ ){
		
						
						i = 1;
						sql.close();
						sql.put(svc.getQuery("UPD_PS_ACTPUMBUN"));
		
						
						sql.setString(i++, mi[0].getString("ORIGIN_NORM_SAMT"+k));	
						sql.setString(i++, mi[0].getString("ORIGIN_EVT_SAMT"+k));	
						sql.setString(i++, mi[0].getString("ORIGIN_SALE_TAMT"+k));	
						sql.setString(i++, mi[0].getString("ORIGIN_PROF_TAMT"+k));	
						sql.setString(i++, mi[0].getString("ORIGIN_SALE_CRATE"+k));	
						sql.setString(i++, mi[0].getString("ORIGIN_PROF_CRATE"+k));	
						
						//매출 신장율계산
						int bfyySaleTamt    = Integer.parseInt(mi[0].getString("BFYY_SALE_TAMT"+k));
						if(bfyySaleTamt == 0){
							originSaleIRate = 0;
						}
						else{
							int originSaleTamt  = Integer.parseInt(mi[0].getString("ORIGIN_SALE_TAMT"+k));
							originSaleIRate     = (originSaleTamt-bfyySaleTamt)/bfyySaleTamt*100;
						}
						
						sql.setString(i++, originSaleIRate+"");
						//이익 신장율계산
						int bfyyProfTamt    = Integer.parseInt(mi[0].getString("BFYY_PROF_TAMT"+k));
						if(bfyySaleTamt == 0){
							originSaleIRate = 0;
						}
						else{
							int originProfTamt  = Integer.parseInt(mi[0].getString("ORIGIN_PROF_TAMT"+k));
							originProfIRate     = (originProfTamt-bfyyProfTamt)/bfyyProfTamt*100;
						}
						
						sql.setString(i++, originProfIRate+"");
						
						sql.setString(i++, strID);
						sql.setString(i++, strStrCd);	
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);	
						sql.setString(i++, strPCCd);
						sql.setString(i++, mi[0].getString("PUMBUN_CD"));
						sql.setString(i++, strYYYYMM);
						if(k < 10){
							sql.setString(i++, strYYYYMM+"0"+k);
						}
						else{
							sql.setString(i++, strYYYYMM+k);
						}
						
						res = update(sql);
		                
					}
					if(res > 0 ) ret = 1;
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
	 * 실행
	 * 
	 * @param svc
	 * @param mi
	 * @return int
	 * @throws Exception
	 */

	private ProcedureResultSet insertAll(String strStrCd, String strYYYYMM, String strDeptCd, String strTeamCd, String strPCCd, String strID) 
	throws Exception {
		
		
		ProcedureWrapper    proc = null;
		proc = new ProcedureWrapper(); 
		
		//신규,수정,삭제 동시 프로시져
		
	    int i = 0;
	    
	    proc.put("DPS.PR_PSACTPUMBUN", 8);

		proc.setString(++i, strStrCd);        //1
		proc.setString(++i, strYYYYMM);       //2
		proc.setString(++i, strDeptCd);       //3
		proc.setString(++i, strTeamCd);       //4
		proc.setString(++i, strPCCd);         //5
		proc.setString(++i, strID);           //6
		
		proc.registerOutParameter(++i, DataTypes.VARCHAR);//7
        proc.registerOutParameter(++i, DataTypes.VARCHAR);//8
		
			
		return  updateProcedure(proc);
	}


}
