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

public class PSal453DAO extends AbstractDAO {

	/**
	 * 마스터를 조회한다.
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
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strCornerCd      = String2.nvl(form.getParam("strCornerCd"));// 
	    
	   
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("1")){  //매장
			sql.put(svc.getQuery("SEL_SALE_CORNER"));
			/* 코너(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);

			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("1")){  //매장
			/* 코너(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
			sql.put(svc.getQuery("SEL_SALE_BRAND2"));
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("2")){  //매장
			/* 코너(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
			sql.put(svc.getQuery("SEL_SALE_CORNER3"));
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCmprDtS1);
			sql.setString(i++, strCmprDtE1);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCmprDtS2);
			sql.setString(i++, strCmprDtE2);
			
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("2")){  //매장
			/* 코너(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
			sql.put(svc.getQuery("SEL_SALE_BRAND4"));
			
		    sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strCmprDtS1);
			sql.setString(i++, strCmprDtE1);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strCmprDtS2);
			sql.setString(i++, strCmprDtE2);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
		
		}

		
		else{
			if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("1")){
				sql.put(svc.getQuery("SEL_SALE_PC"));
				/* PC(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
				
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);

				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
		
			}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("1")){
				/* PC(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
				sql.put(svc.getQuery("SEL_SALE_PC2"));
				
								
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);

				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
		
			}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("2")){
				/* PC(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
				sql.put(svc.getQuery("SEL_SALE_PC3"));
				
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCmprDtS1);
				sql.setString(i++, strCmprDtE1);
							
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCmprDtS2);
				sql.setString(i++, strCmprDtE2);
				
				sql.setString(i++, strStrCd);			
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
		
			}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("2")){
				/* PC(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
				sql.put(svc.getQuery("SEL_SALE_PC4"));
				
							    
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCmprDtS1);
				sql.setString(i++, strCmprDtE1);
							
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCmprDtS2);
				sql.setString(i++, strCmprDtE2);
				
				sql.setString(i++, strStrCd);			
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
						
			}
			else{
				
				if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("1") && strCmprFlag.equals("1")){
					/* 팀(매장) -전년대비  매장, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
					sql.put(svc.getQuery("SEL_SALE_TEAM"));
					
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
				}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("2") && strCmprFlag.equals("1")){
					/* 팀(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
					sql.put(svc.getQuery("SEL_SALE_TEAM2"));
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);


				}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("1") && strCmprFlag.equals("2")){
					/* 팀(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
					sql.put(svc.getQuery("SEL_SALE_TEAM3"));
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
								
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					
					sql.setString(i++, strStrCd);			
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					

				}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("2") && strCmprFlag.equals("2")){
					sql.put(svc.getQuery("SEL_SALE_TEAM4"));
					/* 팀(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
								
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					
					sql.setString(i++, strStrCd);			
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
				}


				else{
					if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("1") && strCmprFlag.equals("1")){
						/* 부분(매장) -전년대비 매장, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체  */
						 
						sql.put(svc.getQuery("SEL_SALE_DEPT"));
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);

				
					}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("2") && strCmprFlag.equals("1")){
						/* 부분(매입) -전년대비 매입, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체*/
						sql.put(svc.getQuery("SEL_SALE_DEPT2"));
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);


					}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("1") && strCmprFlag.equals("2")){
						/* 부분(매장) -전주대비 매장, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체*/
						sql.put(svc.getQuery("SEL_SALE_DEPT3"));
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS1);
						sql.setString(i++, strCmprDtE1);
									
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS2);
						sql.setString(i++, strCmprDtE2);
						
						sql.setString(i++, strStrCd);			
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
					}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("2") && strCmprFlag.equals("2")){
						/* 부분(매입) -전주대비 매입, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체 */
						sql.put(svc.getQuery("SEL_SALE_DEPT4"));
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS1);
						sql.setString(i++, strCmprDtE1);
									
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS2);
						sql.setString(i++, strCmprDtE2);
						
						sql.setString(i++, strStrCd);			
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
					}
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
		
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strCornerCd 		= String2.nvl(form.getParam("strCornerCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strOrgFlag      = String2.nvl(form.getParam("strOrgFlag"));// 대비일자 2-2
	   
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(!strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("1") && strCmprFlag.equals("1")){
			/* 단품(매장)-전년대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU"));
			
			
		    sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
		
		}else if(!strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("2") && strCmprFlag.equals("1")){
			/* 단품(매입)-전년대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU2"));
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			
		}else if(!strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("1") && strCmprFlag.equals("2")){
			/* 단품(매장)-전주대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU3"));
			
			
		    sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);			
			sql.setString(i++, strCmprDtS1);
			sql.setString(i++, strCmprDtE1);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			
			sql.setString(i++, strStrCd);			
			sql.setString(i++, strCmprDtS2);
			sql.setString(i++, strCmprDtE2);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			
			
		}else if(!strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("2") && strCmprFlag.equals("2")){
			/* 단품(매입)-전주대비 */
			sql.put(svc.getQuery("SEL_SALE_SKU4"));
			

			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);			
			sql.setString(i++, strCmprDtS1);
			sql.setString(i++, strCmprDtE1);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			
			sql.setString(i++, strStrCd);			
			sql.setString(i++, strCmprDtS2);
			sql.setString(i++, strCmprDtE2);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			
		}



		else{
			if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){
				/* 품번(매장)-전년대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND"));    //SEL_SALE_PUMBUN	
							
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
			
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){
				/* 품번(매입)-전년대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND2"));    //SEL_SALE_PUMBUN	
						
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
	
				
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){
				/* 품번(매장)-전주대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND3"));    //SEL_SALE_PUMBUN
					
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS1);
				sql.setString(i++, strCmprDtE1);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS2);
				sql.setString(i++, strCmprDtE2);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
			
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){
				/* 품번(매입)-전주대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/
				sql.put(svc.getQuery("SEL_SALE_BRAND4"));    //SEL_SALE_PUMBUN
							
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS1);
				sql.setString(i++, strCmprDtE1);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS2);
				sql.setString(i++, strCmprDtE2);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
			    
			}

			else{
				if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){  //매장
					sql.put(svc.getQuery("SEL_SALE_CORNER"));
					/* 코너(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);

					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
				}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){  //매장
					/* 코너(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					sql.put(svc.getQuery("SEL_SALE_BRAND2"));
					
				    sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
				}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){  //매장
					/* 코너(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					sql.put(svc.getQuery("SEL_SALE_CORNER3"));
					
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					
					
				}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){  //매장
					/* 코너(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/
					sql.put(svc.getQuery("SEL_SALE_BRAND4"));
					
					
				    sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strCmprDtS1);
					sql.setString(i++, strCmprDtE1);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strCmprDtS2);
					sql.setString(i++, strCmprDtE2);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCornerCd);
				
				}

				
				else{
					if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){
						sql.put(svc.getQuery("SEL_SALE_PC"));
						/* PC(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
						
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						
				
					}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){
						/* PC(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
						sql.put(svc.getQuery("SEL_SALE_PC2"));
						
										
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
				
					}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){
						/* PC(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
						sql.put(svc.getQuery("SEL_SALE_PC3"));
						
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS1);
						sql.setString(i++, strCmprDtE1);
									
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS2);
						sql.setString(i++, strCmprDtE2);
						
						sql.setString(i++, strStrCd);			
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
				
					}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){
						/* PC(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/
						sql.put(svc.getQuery("SEL_SALE_PC4"));
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS1);
						sql.setString(i++, strCmprDtE1);
									
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS2);
						sql.setString(i++, strCmprDtE2);
						
						sql.setString(i++, strStrCd);			
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
								
					}
					else{
						
						if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("1") && strCmprFlag.equals("1")){
							/* 팀(매장) -전년대비  매장, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
							sql.put(svc.getQuery("SEL_SALE_TEAM"));
							
							
							sql.setString(i++, strStrCd);						
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);

							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);
							
						}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("2") && strCmprFlag.equals("1")){
							/* 팀(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
							sql.put(svc.getQuery("SEL_SALE_TEAM2"));
							
							sql.setString(i++, strStrCd);						
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);

							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);


						}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("1") && strCmprFlag.equals("2")){
							/* 팀(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
							sql.put(svc.getQuery("SEL_SALE_TEAM3"));
							
							sql.setString(i++, strStrCd);						
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strSaleDtS);			
							sql.setString(i++, strSaleDtE);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strCmprDtS1);
							sql.setString(i++, strCmprDtE1);
										
							sql.setString(i++, strStrCd);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strCmprDtS2);
							sql.setString(i++, strCmprDtE2);
							
							sql.setString(i++, strStrCd);			
							sql.setString(i++, strSaleDtS);			
							sql.setString(i++, strSaleDtE);
							

						}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("2") && strCmprFlag.equals("2")){
							sql.put(svc.getQuery("SEL_SALE_TEAM4"));
							/* 팀(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/
							
							sql.setString(i++, strStrCd);						
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strSaleDtS);			
							sql.setString(i++, strSaleDtE);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strCmprDtS1);
							sql.setString(i++, strCmprDtE1);
										
							sql.setString(i++, strStrCd);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strCmprDtS2);
							sql.setString(i++, strCmprDtE2);
							
							sql.setString(i++, strStrCd);			
							sql.setString(i++, strSaleDtS);			
							sql.setString(i++, strSaleDtE);
							
						}


						else{
							if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("1") && strCmprFlag.equals("1")){
								/* 부분(매장) -전년대비 매장, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체  */
								 
								sql.put(svc.getQuery("SEL_SALE_DEPT"));
								
								sql.setString(i++, strStrCd);						
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);

								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);

						
							}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("2") && strCmprFlag.equals("1")){
								/* 부분(매입) -전년대비 매입, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체*/
								sql.put(svc.getQuery("SEL_SALE_DEPT2"));
								
								sql.setString(i++, strStrCd);						
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);

								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);


							}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("1") && strCmprFlag.equals("2")){
								/* 부분(매장) -전주대비 매장, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체*/
								sql.put(svc.getQuery("SEL_SALE_DEPT3"));
								
								sql.setString(i++, strStrCd);						
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strSaleDtS);			
								sql.setString(i++, strSaleDtE);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
											
								sql.setString(i++, strStrCd);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								
								sql.setString(i++, strStrCd);			
								sql.setString(i++, strSaleDtS);			
								sql.setString(i++, strSaleDtE);
								
							}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("2") && strCmprFlag.equals("2")){
								/* 부분(매입) -전주대비 매입, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체 */
								sql.put(svc.getQuery("SEL_SALE_DEPT4"));
								
								sql.setString(i++, strStrCd);						
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strSaleDtS);			
								sql.setString(i++, strSaleDtE);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strCmprDtS1);
								sql.setString(i++, strCmprDtE1);
											
								sql.setString(i++, strStrCd);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strCmprDtS2);
								sql.setString(i++, strCmprDtE2);
								
								sql.setString(i++, strStrCd);			
								sql.setString(i++, strSaleDtS);			
								sql.setString(i++, strSaleDtE);
								
							}
						}
					}					
				}
			}
		}
		
		
		

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
		
		
			sql.put(svc.getQuery("SEARCH_CMPR_DATE"));  
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			
			
			try {
				ret = select2List(sql);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return ret;
	}

	
}
