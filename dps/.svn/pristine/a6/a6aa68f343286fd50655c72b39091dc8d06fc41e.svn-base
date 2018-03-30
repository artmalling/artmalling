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

public class PSal202DAO extends AbstractDAO {

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
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd       = String2.nvl(form.getParam("strPCCd"));
		String strPlanYm     = String2.nvl(form.getParam("strPlanYm"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_SCHEDULE"));

		sql.setString(i++, strPlanYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYm);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYm);
		

		sql.setString(i++, strPlanYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYm);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYm);

		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYm);

		sql.setString(i++, userId);
		
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
		SqlWrapper sql3 = null;
		Service svc 	= null;
		Service svcm 	= null;
		String strQuery = "";
		String strMQuery = "";
		int i 			= 1;
		int k           = 1;
		String listPcCd = "";
		String listPcCd2 = "";
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd       = String2.nvl(form.getParam("strPCCd"));
		String strYYYYMM     = String2.nvl(form.getParam("strYYYYMM"));
		String strEndDate    = String2.nvl(form.getParam("strEndDate"));
		
		int endDate = Integer.parseInt(strEndDate);
		
		sql = new SqlWrapper();
		sql2 = new SqlWrapper();
		sql3 = new SqlWrapper();
		svc = (Service) form.getService();
		svcm = (Service) form.getService();
		
		connect("pot");
		
		sql3.close();
		sql3.put(svcm.getQuery("SEL_PS_ACTPCWEIGHT_BFYYSCH"));

		sql3.setString(i++, strYYYYMM);
		sql3.setString(i++, strStrCd);
		sql3.setString(i++, strDeptCd);
		sql3.setString(i++, strTeamCd);
		sql3.setString(i++, strPCCd);
		sql3.setString(i++, strYYYYMM);	
		
		Map map = selectMap( sql3 );
		
		listPcCd = String2.nvl((String)map.get("PC_CD"));
		i 			= 1;
		sql2.close();
		sql2.put(svc.getQuery("SEL_PS_SCHEDULE_DETAIL2"));

		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strDeptCd);
		sql2.setString(i++, strTeamCd);
		sql2.setString(i++, strPCCd);
		sql2.setString(i++, strYYYYMM);
		
		Map map2 = selectMap( sql2 );
		
		listPcCd2 = String2.nvl((String)map2.get("PC_CD"));
		i 			= 1;
		if( !listPcCd.equals("") && !listPcCd2.equals("")){	
			strQuery  = svc.getQuery("SEL_PS_SCHEDULE_DETAIL1")+ "\n ";
	
			sql.setString(i++, strYYYYMM);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strYYYYMM);
	
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strYYYYMM);
			
			
			
	        for(k=1;k <= endDate;k++){
	        	strQuery += svc.getQuery("SEL_PS_SCHEDULE_UNION")+ "\n ";
	        	
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strYYYYMM);
				sql.setString(i++, k+"");
				sql.setString(i++, strYYYYMM);
				if(k >= 10){
				    sql.setString(i++, k+"");
				}
				else{
					sql.setString(i++, "0"+k);
				}
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strYYYYMM);
				sql.setString(i++, k+"");
				sql.setString(i++, strYYYYMM);
				if(k >= 10){
				    sql.setString(i++, k+"");
				}
				else{
					sql.setString(i++, "0"+k);
				}
	        }
	        strQuery += svc.getQuery("SEL_PS_SCHEDULE_WHERE")+ "\n ";
	        sql.setString(i++, userId);
	        
	        sql.put(strQuery);
	        
			ret = select2List(sql);
		}
		else{
			if( listPcCd.equals("") && listPcCd2.equals("")){	
				strQuery  = svc.getQuery("SEL_PS_SCHEDULE_DETAIL3")+ "\n ";
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strYYYYMM);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strYYYYMM);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strYYYYMM);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strYYYYMM);
				
				
				
		        for(k=1;k <= endDate;k++){
		        	strQuery += svc.getQuery("SEL_PS_SCHEDULE_UNION")+ "\n ";
		        	
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strYYYYMM);
					sql.setString(i++, k+"");
					sql.setString(i++, strYYYYMM);
					if(k >= 10){
					    sql.setString(i++, k+"");
					}
					else{
						sql.setString(i++, "0"+k);
					}
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strYYYYMM);
					sql.setString(i++, k+"");
					sql.setString(i++, strYYYYMM);
					if(k >= 10){
					    sql.setString(i++, k+"");
					}
					else{
						sql.setString(i++, "0"+k);
					}
		        }
		        strQuery += svc.getQuery("SEL_PS_SCHEDULE_WHERE")+ "\n ";
		        sql.setString(i++, userId);
		        sql.put(strQuery);
		        
				ret = select2List(sql);
			}
			else{
				if( listPcCd.equals("") && !listPcCd2.equals("")){	
					strQuery  = svc.getQuery("SEL_PS_SCHEDULE_DETAIL5")+ "\n ";
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strYYYYMM);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strYYYYMM);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strYYYYMM);
					
					
					
			        for(k=1;k <= endDate;k++){
			        	strQuery += svc.getQuery("SEL_PS_SCHEDULE_UNION")+ "\n ";
			        	
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strYYYYMM);
						sql.setString(i++, k+"");
						sql.setString(i++, strYYYYMM);
						if(k >= 10){
						    sql.setString(i++, k+"");
						}
						else{
							sql.setString(i++, "0"+k);
						}
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strYYYYMM);
						sql.setString(i++, k+"");
						sql.setString(i++, strYYYYMM);
						if(k >= 10){
						    sql.setString(i++, k+"");
						}
						else{
							sql.setString(i++, "0"+k);
						}
			        }
			        strQuery += svc.getQuery("SEL_PS_SCHEDULE_WHERE")+ "\n ";
			        sql.setString(i++, userId);
			        
			        sql.put(strQuery);
			        
					ret = select2List(sql);
				}
				else{
                    strQuery  = svc.getQuery("SEL_PS_SCHEDULE_DETAIL7")+ "\n ";

        			sql.setString(i++, strYYYYMM);
        			
        			sql.setString(i++, strStrCd);
        			sql.setString(i++, strDeptCd);
        			sql.setString(i++, strTeamCd);
        			sql.setString(i++, strPCCd);
        			sql.setString(i++, strYYYYMM);
                    
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strYYYYMM);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strYYYYMM);
					
					
					
			        for(k=1;k <= endDate;k++){
			        	strQuery += svc.getQuery("SEL_PS_SCHEDULE_UNION")+ "\n ";
			        	
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strYYYYMM);
						sql.setString(i++, k+"");
						sql.setString(i++, strYYYYMM);
						if(k >= 10){
						    sql.setString(i++, k+"");
						}
						else{
							sql.setString(i++, "0"+k);
						}
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strYYYYMM);
						sql.setString(i++, k+"");
						sql.setString(i++, strYYYYMM);
						if(k >= 10){
						    sql.setString(i++, k+"");
						}
						else{
							sql.setString(i++, "0"+k);
						}
			        }
			        strQuery += svc.getQuery("SEL_PS_SCHEDULE_WHERE")+ "\n ";
			        sql.setString(i++, userId);
			        
			        sql.put(strQuery);
			        
					ret = select2List(sql);
				}
			}
		}
		return ret;
	}

	/**
	 * 영업일정보 체크 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSchedule(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleSDate   = String2.nvl(form.getParam("strSaleSDate"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_SCHEDULE_CHK"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleSDate);

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
	 * 당초품번별월매출계획 확정데이터  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchActConf(ActionForm form, String OrgFlag) throws Exception {
		
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
		sql.put(svc.getQuery("SEL_ACT_CONF"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strYYYYMM);
		
		ret = select2List(sql);
		
		return ret;
	}



	/**
	 * 영업일정보   저장, 수정  처리한다.
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
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_INSERT()) {
					i = 1;
                    sql.put(svc.getQuery("SEL_WEIGHT"));
                    
					sql.setString(1, strStrCd);	
					sql.setString(2, strDeptCd);
					sql.setString(3, strTeamCd);					
					sql.setString(4, strPCCd);				
					sql.setString(5, strYYYYMM);	

					Map map = selectMap( sql );
					strFlag = String2.nvl((String)map.get("FLAG"));
					if( strFlag.equals("")) {
						for(k=1;k <= endDate; k++){
							sql.close();
							i = 1;
							if(mi[0].getString("GUBUN").equals("실행")){
								sql.put(svc.getQuery("INS_PS_ACTPCWEIGHT"));
								
				                sql.setString(i++, strStrCd);
				                sql.setString(i++, strYYYYMM);
				                if(k < 10){
				                	sql.setString(i++, strYYYYMM+"0"+k);
				                }
				                else{
				                	sql.setString(i++, strYYYYMM+k);
				                }
				                sql.setString(i++, strDeptCd);
				                sql.setString(i++, strTeamCd);
				                sql.setString(i++, strPCCd);
				                sql.setString(i++, mi[0].getString("DAY"+k));
				                sql.setString(i++, strID);
				                sql.setString(i++, strID);
				                res = update(sql);
				                ret += res;
							}
						}
					}
					else{
						for(k=1;k <= endDate; k++){
							sql.close();
							i = 1;
							if(mi[0].getString("GUBUN").equals("실행")){
		                        sql.put(svc.getQuery("UPD_PS_ACTPCWEIGHT"));
		                        
		                        sql.setString(i++, mi[0].getString("DAY"+k));
		                        sql.setString(i++, strID);
				                sql.setString(i++, strStrCd);
				                sql.setString(i++, strDeptCd);
				                sql.setString(i++, strTeamCd);
				                sql.setString(i++, strPCCd);
				                sql.setString(i++, strYYYYMM);
				                if(k < 10){
				                	sql.setString(i++, strYYYYMM+"0"+k);
				                }
				                else{
				                	sql.setString(i++, strYYYYMM+k);
				                }
				                
				                res = update(sql);
				                ret += res;
							}
						}
					}
					
				}
				if(res != 0 && mi[0].getString("GUBUN").equals("실행")){
					procResult = insertAll(strStrCd, strYYYYMM, strDeptCd, strTeamCd, strPCCd, strID);
					if (!procResult.getString(7).equals("0") ) {
						throw new Exception(procResult.getString(8));
					}
				}
			}
			
			ret = 1;
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
	    proc.put("DPS.PR_PSACTWEIGHT", 8);

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

	
	/**
	 * 해당월의 영업일자를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List countSaleDate(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strYYYYMM 		= String2.nvl(form.getParam("strYYYYMM"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_SALEDATE_COUNT"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strYYYYMM);
		
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 영업일 가중치 정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDayWeight(ActionForm form) throws Exception {
		
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
		sql.put(svc.getQuery("SEL_DAY_WEIGHT"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strYYYYMM);

		ret = select2List(sql);
		
		return ret;
	}
}
