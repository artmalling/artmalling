/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package ppay.dao;

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
 * <p>실지불액 계산/확정/이월처리</p> 
 * 
 * @created  on 1.0, 2011/05/17
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by 
 */
   
public class PPay306DAO extends AbstractDAO {  
	    
	/**
	 * 작업 내역 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;            
		
		String strPayYm      = String2.nvl(form.getParam("strPayYm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));
		
		sql = new SqlWrapper();                     
		svc = (Service) form.getService();
		connect("pot");  
		  
		i = 1;      
		sql.put(svc.getQuery("SEL_LIST"));
        sql.setString(i++, strPayYm); 		// 지불년월 
        sql.setString(i++, strPayCyc);		// 지불주기
        sql.setString(i++, strPayCnt);		// 지불회차
        sql.setString(i++, strStrCd); 		// 점코드
        sql.setString(i++, strVenCd);		// 협력사
		
		ret = select2List(sql);                                                                                                  
		return ret;                   
	}
	
	/**
	 *  실지불액 계산/확정/이월처리한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String save(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		int i   			= 0;
		String res          = "";
		
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
				
			// 특정, 임대을 지불대상액 확정
			if("Y".equals(mi1.getString("CHK1"))){
				i = 1;    
				psql.put("DPS.PR_PPPAYCONF", 12); 
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-특정,임대을 지불대상액 확정]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 공제 확정
			if("Y".equals(mi1.getString("CHK2"))){
				i = 1;    
				psql.put("DPS.PR_PPDEDCONF", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-공제확정]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 선급금,보류확정
			if("Y".equals(mi1.getString("CHK3"))){
				i = 1;    
				psql.put("DPS.PR_PPPREDEFCONF", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-선급금/보류 확정]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 실지불액확정
			if("Y".equals(mi1.getString("CHK4"))){
				i = 1;    
				psql.put("DPS.PR_PPRPAYCONF", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-실지불액확정]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 이월처리
			if("Y".equals(mi1.getString("CHK5"))){
				i = 1;    
				psql.put("DPS.PR_PPPAYDTLCF", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-이월처리]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			/*
			// 특정 매출수수료 SAP I/F
			if("Y".equals(mi1.getString("CHK6"))){
				i = 1;    
				psql.put("DPS.PR_PPPAYSAP_IFS", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-특정 매출수수료 SAP I/F]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 공제 SAP I/F
			if("Y".equals(mi1.getString("CHK7"))){
				i = 1;    
				psql.put("DPS.PR_PPDEDSAP_IFS", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-공제 SAP I/F]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 특정 매출수수료 SAP I/F (역분개)
			if("Y".equals(mi1.getString("CHK8"))){
				i = 1;    
				psql.put("DPS.PR_PPPAYCANSAP_IFS", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-특정 매출수수료 SAP I/F]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 공제 SAP I/F (역분개)
			if("Y".equals(mi1.getString("CHK9"))){
				i = 1;    
				psql.put("DPS.PR_PPDEDCANSAP_IFS", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-공제 SAP I/F]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 임대을 매출수수료 SAP I/F
			if("Y".equals(mi1.getString("CHK10"))){
				i = 1;    
				psql.put("DPS.PR_PPCOMISSAP_IFS", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-임대을 매출수수료 SAP I/F]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}
			
			// 임대을 매출수수료 SAP I/F (역분개)
			if("Y".equals(mi1.getString("CHK11"))){
				i = 1;    
				psql.put("DPS.PR_PPCOMISCANSAP_IFS", 12);
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            
	            if("".equals(mi1.getString("VEN_CD")))				// 협력사
	            	psql.setString(i++, "%");							
	            else
	            	psql.setString(i++, mi1.getString("VEN_CD"));		
	            
	            psql.setString(i++, mi1.getString("TERM_S_DT"));
	            psql.setString(i++, mi1.getString("TERM_E_DT"));
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            psql.setString(i++, "PPAY306");
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//11
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//12

	            prs = updateProcedure(psql);
	            
	            resp += prs.getInt(11);    

	            if (resp != 0) {
	                throw new Exception("[USER-임대을 매출수수료 SAP I/F]"+ prs.getString(12));
	            }else{
	            	res = prs.getString(12);
	            }
			}*/
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
	
	
	/**
	 *  실지불액 계산/확정/이월처리전  Validation Check 한다.
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

			String chk = String2.nvl(form.getParam("CHK"));   
			
			mi1.next();
			System.out.println("chk:"+chk+"::"+mi1.getString("CHK1"));
			// 특정, 임대을 지불대상액 확정
			if("Y".equals(mi1.getString("CHK1")) && "1".equals(chk)){
				i = 1;    
				psql.put("DPS.PR_PPPAYSALCHK", 8); 
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8

	            prs = updateProcedure(psql);
	            
	            resp = prs.getInt(7);    
System.out.println("resp:"+resp+":"+prs.getString(8));
	            if (resp != 0) {
	                throw new Exception("[USER-특정,임대을 지불대상액 확정]"+ prs.getString(8));
	            }else{
	            	res = prs.getString(8);
	            }
			}else{
				res = "OK";
			}
			
			// 공제 확정
			if("Y".equals(mi1.getString("CHK2")) && "2".equals(chk)){
				i = 1;    
				//psql.put("DPS.PR_PPPAYORDSALRENCHK", 8); 
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
	            
	            resp = prs.getInt(7); 
	            if (resp != 0) {
	                throw new Exception("[USER-공제확정]"+ prs.getString(8));
	            }else{
	            	res = prs.getString(8);
	            }
			}
			
			// 선급금/보류 확정
			if("Y".equals(mi1.getString("CHK3")) && "3".equals(chk)){
				i = 1;    
				psql.put("DPS.PR_PPPAYCHK", 8); 
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8

	            prs = updateProcedure(psql);
	            
	            resp = prs.getInt(7); 
	            if (resp != 0) {
	                throw new Exception("[USER-선급금/보류확정]"+ prs.getString(8));
	            }else{
	            	res = prs.getString(8);
	            }
			}
			
			// 실지불액확정
			if("Y".equals(mi1.getString("CHK4")) && "4".equals(chk)){
				i = 1;    
				//psql.put("DPS.PR_PPPAYORDSALRENCHK", 8);
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
	            
	            resp = prs.getInt(7); 

	            if (resp != 0) {
	                throw new Exception("[USER-실지불액확정]"+ prs.getString(8));
	            }else{
	            	res = prs.getString(8);
	            }
			}
			
			// 이월처리
			if("Y".equals(mi1.getString("CHK5")) && "5".equals(chk)){
				i = 1;    
				psql.put("DPS.PR_PPPAYCHK", 8); 
				psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
	            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
	            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
	            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
	            psql.setString(i++, userId);
	            psql.setString(i++, org_flag);
	            
	            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
	            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8

	            prs = updateProcedure(psql);
	            
	            resp = prs.getInt(7); 

	            if (resp != 0) {
	                throw new Exception("[USER-이월처리]"+ prs.getString(8));
	            }else{
	            	res = prs.getString(8);
	            }
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
