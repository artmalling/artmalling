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

public class PSal316DAO extends AbstractDAO {

	/** 
	 * 마스터를 조회한다.
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
		String strLevelCd 		= String2.nvl(form.getParam("strLevelCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));// 매출일자 start
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));// 매출일자 end
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strCornerCd      = String2.nvl(form.getParam("strCornerCd"));// 
	    String strOrgFlag       = String2.nvl(form.getParam("strOrgFlag")); // 조직구분  
	    String strEmUnit 		 = String2.nvl(form.getParam("strEmUnit")); // 단위(01:원,02:천원)
	    
	    String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		    
		connect("pot");
		 
		if(strOrgFlag.equals("1")){ //조직구분이 매장일때
			if(strCmprFlag.equals("1")){//대비구분이 전년대비일때
				if(strLevelCd.equals("01")){//레벨이 1일때
					 
					System.out.println(strSaleDtS);
					System.out.println(strSaleDtE);
				    if(strSaleDtS.equals(strSaleDtE)) {
				    	sql.put(svc.getQuery("SEL_SALE_TEAM1"));//매장 전년대비 팀
				    	System.out.println("SEL_SALE_TEAM1");
						
				    	sql.setString(i++, strUnit);
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
				    } else {
				    	sql.put(svc.getQuery("SEL_SALE_TEAM1-1"));//매장 전년대비 팀
				    	System.out.println("SEL_SALE_TEAM1-1");
						
				    	sql.setString(i++, strUnit);
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
				    }
				    
					
				    
				}else if(strLevelCd.equals("02")){//조직구분이 매장일때 대비구분이 전년대비일때 레벨이 2일때
					
					sql.put(svc.getQuery("SEL_SALE_HALL1"));//매장 전년대비 관
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				    
				}else{//조직구분이 매장일때 대비구분이 전년대비일때  그 외 레벨일때
					
					
					sql.put(svc.getQuery("SEL_SALE_PC1"));//매장 전년대비 PC
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
				}
			}else{//대비구분이 전주대비일때
				if(strLevelCd.equals("01")){//레벨이 1일때
					
				    
				    sql.put(svc.getQuery("SEL_SALE_TEAM3"));//매장 전주대비 팀
				    
				    sql.setString(i++, strUnit);
				    sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
				}else if(strLevelCd.equals("02")){//레벨이 2일때
					
					sql.put(svc.getQuery("SEL_SALE_HALL3"));//매입 전주대비 관
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					
				}else{//그 외 레벨일때
					
					sql.put(svc.getQuery("SEL_SALE_PC3"));//매장 전주대비 PC별
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					 
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				    
				}
			}
		}else{//조직구분이 매입일때
			if(strCmprFlag.equals("1")){//대비구분이 전년대비일때
				if(strLevelCd.equals("01")){//레벨이 1일때
					
				    
				    sql.put(svc.getQuery("SEL_SALE_TEAM2"));//매입 전년대비 팀
				    
				    sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
				}else if(strLevelCd.equals("02")){//레벨이 2일때
					
					sql.put(svc.getQuery("SEL_SALE_HALL2"));//매입 전년대비 관
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				    
				}else{//그 외 레벨일때
					
					sql.put(svc.getQuery("SEL_SALE_PC2"));//매입 전년대비 관
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);             
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				}
			}else{//대비구분이 전주 대비일때
				if(strLevelCd.equals("01")){//레벨이 1일때
					
				    
				    sql.put(svc.getQuery("SEL_SALE_TEAM4"));//매입 전년대비 팀
				    
				    sql.setString(i++, strUnit);
				    sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				    
				}else if(strLevelCd.equals("02")){//레벨이 2일때
					
					sql.put(svc.getQuery("SEL_SALE_HALL4"));

					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				    
				}else{//그 외 레벨일때
					
					sql.put(svc.getQuery("SEL_SALE_PC4"));//매입 전주대비 pc별
					
					sql.setString(i++, strUnit);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);	
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);		
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, userid);
					
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
					
				}
			}
		}

		ret = select2List(sql);
		
		
		return ret;
	}

	/**
	 * 마스터를 조회한다.(더블클릭시)
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster2(ActionForm form,  String userid) throws Exception {
				
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strLevelCd 		= String2.nvl(form.getParam("strLevelCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));// 매출일자 start
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));// 매출일자 end
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strCornerCd      = String2.nvl(form.getParam("strCornerCd"));// 
	    String strOrgFlag       = String2.nvl(form.getParam("strOrgFlag")); // 조직구분
	    
	    String strStrCd         = String2.nvl(form.getParam("strStrCd")); 
	    String strDeptCd        = String2.nvl(form.getParam("strDeptCd")); 
	    String strTeamCd        = String2.nvl(form.getParam("strTeamCd")); 
	    String strPCCd          = String2.nvl(form.getParam("strPCCd")); 
	    String strPumbunCd      = String2.nvl(form.getParam("strPumbunCd"));
	    String strGubunCd       = String2.nvl(form.getParam("strGubunCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		
		if(strGubunCd.equals("1")&&!strPumbunCd.equals("")&&strOrgFlag.equals("1")&&strCmprFlag.equals("1")){//매장 전년대비
			/* 단품(매장)-전년대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU"));
			
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strPumbunCd);
			
		}else if(strGubunCd.equals("1")&&!strPumbunCd.equals("") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){
			/* 단품(매입)-전년대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU2"));
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strPumbunCd);
			
			
			
		}else if(strGubunCd.equals("1")&&!strPumbunCd.equals("") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){
			/* 단품(매장)-전주대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU3"));
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strCmprDtS1);//대비기간 시작 1
			sql.setString(i++, strCmprDtE1);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
			sql.setString(i++, strCmprDtS2);//대비기간 시작 1
			sql.setString(i++, strCmprDtE2);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
			
			
		}else if(strGubunCd.equals("1")&&!strPumbunCd.equals("") &&  strOrgFlag.equals("2") && strCmprFlag.equals("2")){
			/* 단품(매입)-전주대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU4"));
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strCmprDtS1);//대비기간 시작 1
			sql.setString(i++, strCmprDtE1);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
			sql.setString(i++, strCmprDtS2);//대비기간 시작 1
			sql.setString(i++, strCmprDtE2);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
			
			
		} else {
			if(!strCornerCd.equals("00") && !strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){
				/* 품번(매장)-전년대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND"));    //SEL_SALE_PUMBUN				
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){
				/* 품번(매입)-전년대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND2"));    //SEL_SALE_PUMBUN
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){
				/* 품번(매장)-전주대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND3"));    //SEL_SALE_PUMBUN
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
			
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){
				/* 품번(매입)-전주대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND4"));    //SEL_SALE_PUMBUN
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
			
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				
				sql.setString(i++, userid);
				
			} else {
				if(!strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){  //매장
					sql.put(svc.getQuery("SEL_SALE_CORNER"));
					/* 코너(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);//추가

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
					sql.setString(i++, strSaleDtE);
					
				}else if(!strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){  //매장
					/* 코너(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					sql.put(svc.getQuery("SEL_SALE_BRAND2"));
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
				}else if(!strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){  //매장
					/* 코너(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					sql.put(svc.getQuery("SEL_SALE_CORNER3"));
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
				
					sql.setString(i++, strCmprDtS1);//대비기간 시작 1
					sql.setString(i++, strCmprDtE1);//대비기간 종료1
								
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS2);//대비기간 시작 2
					sql.setString(i++, strCmprDtE2);//대비기간 종료2
					
					sql.setString(i++, userid);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
				}else if(!strPCCd.equals("") && !strTeamCd.equals("") && !strDeptCd.equals("") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){  //매장
					/* 코너(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					
					sql.put(svc.getQuery("SEL_SALE_BRAND4"));
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					sql.setString(i++, strCmprDtS1);//대비기간 시작 1
					sql.setString(i++, strCmprDtE1);//대비기간 종료1
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					sql.setString(i++, strCmprDtS2);//대비기간 시작 1
					sql.setString(i++, strCmprDtE2);//대비기간 종료1
					
					sql.setString(i++, userid);
					
				} else {
					if(strOrgFlag.equals("1")){ //조직구분이 매장일때
						if(strCmprFlag.equals("1")){//대비구분이 전년대비일때
							if(strLevelCd.equals("01")){//레벨이 1일때
								
							    
							    sql.put(svc.getQuery("SEL_SALE_TEAM1"));//매장 전년대비 팀
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);

								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
							    
							}else if(strLevelCd.equals("02")){//조직구분이 매장일때 대비구분이 전년대비일때 레벨이 2일때
								
								sql.put(svc.getQuery("SEL_SALE_HALL1"));//매장 전년대비 관
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
							    
							}else{//조직구분이 매장일때 대비구분이 전년대비일때  그 외 레벨일때
								
								
								sql.put(svc.getQuery("SEL_SALE_PC1"));//매장 전년대비 PC
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
							}
						}else{//대비구분이 전주대비일때
							if(strLevelCd.equals("01")){//레벨이 1일때
								
							    
							    sql.put(svc.getQuery("SEL_SALE_TEAM3"));//매장 전주대비 팀
							    
							    sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);	
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);	
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
							}else if(strLevelCd.equals("02")){//레벨이 2일때
								
								sql.put(svc.getQuery("SEL_SALE_HALL3"));//매입 전주대비 관
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								
							}else{//그 외 레벨일때
								
								sql.put(svc.getQuery("SEL_SALE_PC3"));//매장 전주대비 PC별
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);	
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
							    
							}
						}
					}else{//조직구분이 매입일때
						if(strCmprFlag.equals("1")){//대비구분이 전년대비일때
							if(strLevelCd.equals("01")){//레벨이 1일때
								
							    
							    sql.put(svc.getQuery("SEL_SALE_TEAM2"));//매입 전년대비 팀
							    

								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);

								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
							}else if(strLevelCd.equals("02")){//레벨이 2일때
								
								sql.put(svc.getQuery("SEL_SALE_HALL2"));//매입 전년대비 관
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
							    
							}else{//그 외 레벨일때
								
								sql.put(svc.getQuery("SEL_SALE_PC2"));//매입 전년대비 관
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);             
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
							}
						}else{//대비구분이 전주 대비일때
							if(strLevelCd.equals("01")){//레벨이 1일때
								
							    
							    sql.put(svc.getQuery("SEL_SALE_TEAM4"));//매입 전년대비 팀
							    
							    sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);	
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);	
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
							    
							}else if(strLevelCd.equals("02")){//레벨이 2일때
								
								sql.put(svc.getQuery("SEL_SALE_HALL4"));
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
							    
							}else{//그 외 레벨일때
								
								sql.put(svc.getQuery("SEL_SALE_PC4"));//매입 전주대비 pc별
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);	
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);		
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								sql.setString(i++, userid);
								
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, userid);
								
							}
						}
					}
				}//3 if end
				
			}//2 if end
			
		}//1 if end

		ret =  select2List(sql);
		
		return ret;
	}


    /**
	* 대비일자 조회한다.
	*
	* @param  : 
	* @return :
	*/
	public List searchCmprDate(ActionForm form) {
		// TODO Auto-generated method stub
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               

		//strStrCd	
		//strSaleDtS
		String strStrCd=String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS=String2.nvl(form.getParam("strSaleDtS"));
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		try {
		
		sql.put(svc.getQuery("SEARCH_CMPR_DATE"));  
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
			
			
		
			ret = select2List(sql);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return ret;
	}

	
}
