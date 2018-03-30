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

public class PSal454DAO extends AbstractDAO {

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));		
		String strOrgFlag  		= String2.nvl(form.getParam("strOrgFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_SALE_PUMBUN"));

			// 일실적
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			//일목표
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			
			// 월실적
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			//월목표
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			
			// 년실적
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			//년목표
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2")){
			sql.put(svc.getQuery("SEL_SALE_PUMBUN2"));


			// 일실적
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			//일목표
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			
			// 월실적
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			//월목표
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			
			// 년실적
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			//년목표
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
		}
		else{
			if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1")){
				sql.put(svc.getQuery("SEL_SALE_PC"));

				// 일실적
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				//일목표
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				
				// 월실적
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				//월목표
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				
				// 년실적
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				//년목표
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				
			} else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2")){
				sql.put(svc.getQuery("SEL_SALE_PC2"));

				// 일실적
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				//일목표
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				
				// 월실적
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				//월목표
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				
				// 년실적
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				//년목표
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
			}

			else{
				if(strPCCd.equals("%") &&  strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1")){
					sql.put(svc.getQuery("SEL_SALE_TEAM"));

					
					// 일실적
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					//일목표
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					
					// 월실적
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					//월목표
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					// 년실적
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					//년목표
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					
				}else if(strPCCd.equals("%") &&  strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2")){
					sql.put(svc.getQuery("SEL_SALE_TEAM2"));

					
					// 일실적
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					//일목표
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					// 월실적
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					//월목표
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					
					// 년실적
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					//년목표
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
				}
				else{
					if(strOrgFlag.equals("1")){
						sql.put(svc.getQuery("SEL_SALE_DEPT"));

						
						// 일실적
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
					
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
					
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
					
						//일목표
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
					
						// 월실적
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
					
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
					
						//월목표
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
					
						// 년실적
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
					
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
					
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
					
						//년목표
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
					
						sql.setString(i++, strSaleDtS);

					
					}else if(strOrgFlag.equals("2")){
						sql.put(svc.getQuery("SEL_SALE_DEPT2"));

						// 일실적
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
						//일목표
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						
						// 월실적
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
						//월목표
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						
						// 년실적
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
						
						//년목표
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strSaleDtS);
					
					}
					 
				}
				
			}
				
		}
		

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCmprdt(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CMPRDT"));
		
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		

		ret = select2List(sql);
		
		return ret;
	}

}
