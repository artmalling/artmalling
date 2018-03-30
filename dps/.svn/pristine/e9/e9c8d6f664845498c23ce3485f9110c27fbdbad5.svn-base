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

public class PSal446DAO extends AbstractDAO {

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
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strVenCd 	    = String2.nvl(form.getParam("strVenCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strPummmokFlag 	= String2.nvl(form.getParam("strPummmokFlag"));
		String strOrgFlag 	    = String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit 		= String2.nvl(form.getParam("strEmUnit"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strEventFlag 	= String2.nvl(form.getParam("strEventFlag"));
		String strEventRate 	= String2.nvl(form.getParam("strEventRate"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
				strUnit = "1000";
		}
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		if(strOrgFlag.equals("1")){
			
			if(strPummmokFlag.equals("1")){
				strQuery = svc.getQuery("SEL_SALE_MG_PUMBUN2") + "\n";
				System.out.println("--------------------SEL_SALE_MG_PUMBUN2-----------------------");
				
				sql.setString(i++, strUnit);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strPumbunCd);
				sql.setString(i++, strEventFlag);
				sql.setString(i++, strEventRate);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, userid);
				sql.setString(i++, strVenCd);
				/*if(!strVenCd.equals("")){
					strQuery += svc.getQuery("SEL_SALE_MG_WHERE_VEN_CD") + "\n";
					sql.setString(i++, strVenCd);
				}*/
				
			}else if(strPummmokFlag.equals("2")){
				strQuery = svc.getQuery("SEL_SALE_MG_PUMBUN3") + "\n";
				System.out.println("--------------------SEL_SALE_MG_PUMBUN3-----------------------");
				
				sql.setString(i++, strUnit);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strPumbunCd);
				sql.setString(i++, strEventFlag);
				sql.setString(i++, strEventRate);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, userid);
				sql.setString(i++, strVenCd);
				/*if(!strVenCd.equals("")){
					strQuery += svc.getQuery("SEL_SALE_MG_WHERE_VEN_CD") + "\n";
					sql.setString(i++, strVenCd);
				}*/
				
			}else if(strPummmokFlag.equals("3")){
				strQuery = svc.getQuery("SEL_SALE_MG_PUMBUN4") + "\n";
				System.out.println("---------------------SEL_SALE_MG_PUMBUN4----------------------");
				
				sql.setString(i++, strUnit);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strPumbunCd);
				sql.setString(i++, strEventFlag);
				sql.setString(i++, strEventRate);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, userid);
				sql.setString(i++, strVenCd);
				/*if(!strVenCd.equals("")){
					strQuery += svc.getQuery("SEL_SALE_MG_WHERE_VEN_CD") + "\n";
					sql.setString(i++, strVenCd);
				}*/
			
			}
		}else if(strOrgFlag.equals("2")){
			
			if(strPummmokFlag.equals("1")){
				strQuery = svc.getQuery("SEL_SALE_MG_PUMBUN2") + "\n";
				System.out.println("-------------------SEL_SALE_MG_PUMBUN2------------------------");
				
				sql.setString(i++, strUnit);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strPumbunCd);
				sql.setString(i++, strEventFlag);
				sql.setString(i++, strEventRate);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, userid);
				sql.setString(i++, strVenCd);
				/*if(!strVenCd.equals("")){
					strQuery += svc.getQuery("SEL_SALE_MG_WHERE_VEN_CD") + "\n";
					sql.setString(i++, strVenCd);
				}*/
				
			}else if(strPummmokFlag.equals("2")){
				strQuery = svc.getQuery("SEL_SALE_MG_PUMBUN3") + "\n";
				System.out.println("---------------------SEL_SALE_MG_PUMBUN3----------------------");

				sql.setString(i++, strUnit);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strPumbunCd);
				sql.setString(i++, strEventFlag);
				sql.setString(i++, strEventRate);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, userid);
				sql.setString(i++, strVenCd);
				/*if(!strVenCd.equals("")){
					strQuery += svc.getQuery("SEL_SALE_MG_WHERE_VEN_CD") + "\n";
					sql.setString(i++, strVenCd);
				}*/
				
			}else if(strPummmokFlag.equals("3")){
				strQuery = svc.getQuery("SEL_SALE_MG_PUMBUN4") + "\n";
				System.out.println("--------------------SEL_SALE_MG_PUMBUN4-----------------------");
				
				sql.setString(i++, strUnit);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strPumbunCd);
				sql.setString(i++, strEventFlag);
				sql.setString(i++, strEventRate);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, userid);
				sql.setString(i++, strVenCd);
				/*if(!strVenCd.equals("")){
					strQuery += svc.getQuery("SEL_SALE_MG_WHERE_VEN_CD") + "\n";
					sql.setString(i++, strVenCd);
				}*/
			
			}
		}
		if(strPummmokFlag.equals("1")){
			strQuery += svc.getQuery("SEL_SALE_MG_ORDER") + "\n";
		}else if(strPummmokFlag.equals("2")){
			strQuery += svc.getQuery("SEL_SALE_MG_ORDER2") + "\n";
		}else{
			strQuery += svc.getQuery("SEL_SALE_MG_ORDER") + "\n";
		}
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 행사구분 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMgHs(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strPumBunCd = String2.nvl(form.getParam("strPumBunCd"));
		String strSdate    = String2.nvl(form.getParam("strSdate"));
		String strEdate    = String2.nvl(form.getParam("strEdate"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_HS_MG"));
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPumBunCd);
		sql.setString(++i, strSdate);
		sql.setString(++i, strEdate);
		
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
	

}
