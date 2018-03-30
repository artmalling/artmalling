/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
/**
 * <p>매입전표자동생성</p>
 * 
 * @created  on 1.0, 2012.08.27
 * @created  by 강진
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class POrd405DAO extends AbstractDAO {
	
	/**
	 *  매입전표자동생성처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId)
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

			mi1.next();
			
			i = 1;            
			if(mi1.getString("SEND_FLAG").equals("08")){				// 영업팀 매입전표
            	psql.put("DPS.PR_DUZON_IF_PO_MEAIP", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                
			} else if(mi1.getString("SEND_FLAG").equals("13")){			// 식음팀 임대전표
				psql.put("DPS.PR_DUZON_IF_FNB_RENT", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                 
			} else if(mi1.getString("SEND_FLAG").equals("14")){			// 식음팀 관리비전표
				psql.put("DPS.PR_DUZON_IF_FNB_DEDUCT", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                
			} else if(mi1.getString("SEND_FLAG").equals("15")){			// PDA 사용료
				psql.put("DPS.PR_DUZON_IF_GJ_02", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                
			} else if(mi1.getString("SEND_FLAG").equals("16")){			// 온라인 배송비
				psql.put("DPS.PR_DUZON_IF_GJ_04", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                
			} else if(mi1.getString("SEND_FLAG").equals("17")){			// 온라인 촬용비
				psql.put("DPS.PR_DUZON_IF_GJ_20", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                
			} else if(mi1.getString("SEND_FLAG").equals("18")){			// 조명기구 보수료
				psql.put("DPS.PR_DUZON_IF_GJ_06", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
                
			} else if(mi1.getString("SEND_FLAG").equals("19")){			// 공장/창고 사용료
				psql.put("DPS.PR_DUZON_IF_GJ_01", 5);
            	psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
                psql.setString(i++, mi1.getString("PAY_YM"));       // 전송년월
                psql.setString(i++, userId);		                // 사용자            
                
                psql.registerOutParameter(i++, DataTypes.INTEGER);//4
                psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
                
                prs = updateProcedure(psql);
                System.out.println("STR_CD="+mi1.getString("STR_CD"));
                System.out.println("PAY_YM="+mi1.getString("PAY_YM"));
                System.out.println("userId="+userId);
                
                resp += prs.getInt(4);  
                System.out.println("resp="+resp);
                System.out.println(resp+ "registerOutParameter");
			}
			
			
            
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
	
	/**
	 *  매입전표자동생성전  Validation Check 한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String valCheck(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		String res			= "";
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

			mi1.next();
				
			i = 1;    
			psql.put("DPS.PR_PPPAYORDSALCHK", 8); 
			psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
            psql.setString(i++, userId);
            psql.setString(i++, org_flag);
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8

            prs = updateProcedure(psql);
            
            resp += prs.getInt(7);    

            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(8));
            }else{
            	res = prs.getString(8);
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
