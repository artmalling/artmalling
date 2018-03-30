/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;
import java.util.Map;

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
 * <p>관리비입금내역관리 </p>
 * 
 * @created  on 1.0, 2010.05.06
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen404DAO extends AbstractDAO {
	
	/**
	 * <p>관리비입금내역 마스터 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
	        
			String strStrCd		= String2.nvl(form.getParam("strStrCd"));		// 시설구분(점코드)
			String strCalYM		= String2.nvl(form.getParam("strCalYM"));		// 부과년월
			String strVenCd		= String2.nvl(form.getParam("strVenCd"));		// 협력사
			String strRentFlag	= String2.nvl(form.getParam("strRentFlag"));	// 임대형태
			String strPayFlag	= String2.nvl(form.getParam("strPayFlag"));		// 입금상태구분
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_CALMST"));
			sql.setString(++i, strPayFlag);
			sql.setString(++i, strRentFlag);
			sql.setString(++i, strVenCd);
			sql.setString(++i, strCalYM);
			sql.setString(++i, strStrCd);
			list = select2List(sql);	         
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	

	
	/**
	 * <p>관리비입금내역 디테일 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public List[] getDetail(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
				
		String strCalType	 = String2.nvl(form.getParam("strCalType"));	// 정산구분
		String strCntrId	 = String2.nvl(form.getParam("strCntrId"));	    // 계약ID
		String strCalYM		 = String2.nvl(form.getParam("strCalYM"));	    // 부과년월
		String strMntnRentGb = String2.nvl(form.getParam("strMntnRentGb"));	// 관리비임대료구분
		int i = 0;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		  
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MR_CALPAY"));
		
		sql.setString(++i, strCalType);
		sql.setString(++i, strCntrId);
		sql.setString(++i, strCalYM);
		sql.setString(++i, strMntnRentGb);
		
		ret[0] = select2List(sql);
		sql.close();
		
		i= 0;
		sql.put(svc.getQuery("SEL_CALMST_COUNT"));
		
		sql.setString(++i, strCalYM);
		sql.setString(++i, strCntrId);
		sql.setString(++i, strCalType); 	
		
		ret[1] = select2List(sql);
		return ret;
		
	}
	/*
	public List getDetail(ActionForm form, MultiInput mi) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			String strCalType	 = String2.nvl(form.getParam("strCalType"));	// 정산구분
			String strCntrId	 = String2.nvl(form.getParam("strCntrId"));	    // 계약ID
			String strCalYM		 = String2.nvl(form.getParam("strCalYM"));	    // 부과년월
			String strMntnRentGb = String2.nvl(form.getParam("strMntnRentGb"));	// 관리비임대료구분
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_CALPAY"));
			
			sql.setString(++i, strCalType);
			sql.setString(++i, strCntrId);
			sql.setString(++i, strCalYM);
			sql.setString(++i, strMntnRentGb);
			list = select2List(sql);	
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	*/	
	/**
	 * <p>수정/삭제시 Validation</p>
	 */
	/*
	@SuppressWarnings("rawtypes")
	public List getValidation(ActionForm form, MultiInput mi) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
			String strCalType	 = String2.nvl(form.getParam("strCalType"));	// 정산구분
			String strCntrId	 = String2.nvl(form.getParam("strCntrId"));	    // 계약ID
			String strCalYM		 = String2.nvl(form.getParam("strCalYM"));	    // 부과년월
			
			int i = 0;
			sql.put(svc.getQuery("SEL_CALMST_COUNT"));
			
			sql.setString(++i, strCalYM);
			sql.setString(++i, strCntrId);
			sql.setString(++i, strCalType);
			
			//sql.setString(++i, strMntnRentGb);
			list = select2List(sql);	
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}*/
	
	/**
	 * <p>관리비입금내역 미수잔액 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getCalBal(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
	        
			String strCalType	 = String2.nvl(form.getParam("strCalType"));	// 정산구분
			String strCntrId	 = String2.nvl(form.getParam("strCntrId"));	    // 계약ID
			String strCalYM		 = String2.nvl(form.getParam("strCalYM"));	    // 부과년월
			String strMntnRentGb = String2.nvl(form.getParam("strMntnRentGb"));	// 관리비임대료구분
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_CALBAL"));
			
			sql.setString(++i, strCalType);
			sql.setString(++i, strCntrId);
			sql.setString(++i, strCalYM);
			sql.setString(++i, strMntnRentGb);
			list = select2List(sql);	         
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 관리비입금내역관리 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			
			svc = (Service) form.getService();
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			int resp = 0;//프로시저 리턴값
						
			String strCalType	  = String2.nvl(form.getParam("strCalType"));	    // 정산구분
			String strCntrID	  = String2.nvl(form.getParam("strCntrID"));	    // 계약ID
			String strCalYM		  = String2.nvl(form.getParam("strCalYM"));	        // 부과년월
			String strRealAmt	  = String2.nvl(form.getParam("strRealAmt"));	    // 관리비청구액
			String strRealRentAmt = String2.nvl(form.getParam("strRealRentAmt"));	// 임대료청구액
			String strMntnRentGb  = String2.nvl(form.getParam("strMntnRentGb"));	// 관리비임대료구분
			String strBalArrAmt   = String2.nvl(form.getParam("strBalArrAmt"));	    // 미수연체료
			
			while (mi.next()) {
				sql.close();
				if (mi.IS_INSERT()) {
					sql.put(svc.getQuery("INS_MR_CALPAY"));
					int i = 0;
					sql.setString(++i, strCalYM);
					sql.setString(++i, strCntrID);
					sql.setString(++i, strCalType);
					sql.setString(++i, strCalType);
					sql.setString(++i, strCntrID);
					sql.setString(++i, strCalYM);
					sql.setString(++i, mi.getString("PAY_DT"));
					sql.setString(++i, mi.getString("PAY_AMT"));
					sql.setString(++i, mi.getString("PAY_ARR_AMT"));
					sql.setString(++i, strMntnRentGb);
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, userID);
					sql.setString(++i, userID);
				} else if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_CALPAY"));
					int i = 0;
					sql.setString(++i, mi.getString("PAY_DT"));
					sql.setString(++i, mi.getString("PAY_AMT"));
					sql.setString(++i, mi.getString("PAY_ARR_AMT"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					sql.setString(++i, strCalType);
					sql.setString(++i, strCntrID);
					sql.setString(++i, strCalYM);
				} else if (mi.IS_DELETE()) {
					sql.put(svc.getQuery("DEL_MR_CALPAY"));
					int i = 0;
					sql.setString(++i, mi.getString("PAY_SEQ_NO"));
					sql.setString(++i, strCalType);
					sql.setString(++i, strCntrID);
					sql.setString(++i, strCalYM);
				}
				res = update(sql);
				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}
			
			if (ret > 0) {
				sql.close();
				int i = 0;
				
				if(strMntnRentGb.equals("M")){
					sql.put(svc.getQuery("UPD_PAY_FLAG"));
					sql.setString(++i, strRealAmt);
				}else{
					sql.put(svc.getQuery("UPD_PAY_RENT_FLAG"));
					sql.setString(++i, strRealRentAmt);
				}				
				
				sql.setString(++i, strCalType);
				sql.setString(++i, strCntrID);
				sql.setString(++i, strCalYM);
				sql.setString(++i, strMntnRentGb);
				sql.setString(++i, strCalType);
				sql.setString(++i, strCntrID);
				sql.setString(++i, strCalYM);
				//update(sql);
				
				res = update(sql);
				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			
				System.out.println(strCalYM);
				System.out.println(strCntrID);
				System.out.println(strMntnRentGb);
				System.out.println(strBalArrAmt);
				psql.put("MSS.PR_MRCALBAL", 7);                 // 미납금생성
				
	            psql.setString(1, strCalYM);                    // 부과년월
	            psql.setString(2, strCntrID);                   // 계약ID
	            psql.setString(3, strMntnRentGb);               // 임대료/관리비구분		            
	            psql.setString(4, strBalArrAmt);                // 미수연체료
	            psql.setString(5, userID);                      // 작업자ID
	            psql.registerOutParameter(6, DataTypes.INTEGER);// RETURN결과
	            psql.registerOutParameter(7, DataTypes.VARCHAR);// RETURN메시지
	            
	            prs = updateProcedure(psql);

				res = update(sql);
				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				//ret += res;
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
	 * <p>
	 * 관리비입금내 미납연체료  저장
	 * </p>
	 */
	public int balsave(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			
			svc = (Service) form.getService();
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			int resp = 0;//프로시저 리턴값
			

			System.out.println("save============1111");		

			String strCntrID	  = String2.nvl(form.getParam("strCntrID"));	    // 계약ID
			String strCalYM		  = String2.nvl(form.getParam("strCalYM"));	        // 부과년월
			String strCalType	  = String2.nvl(form.getParam("strCalType"));	    // 정산구분
			String strMntnRentGb  = String2.nvl(form.getParam("strMntnRentGb"));	// 관리비임대료구분
			String strRealAmt	  = String2.nvl(form.getParam("strRealAmt"));	    // 관리비청구액
			String strARR_RATE    = String2.nvl(form.getParam("strARR_RATE"));	    // 연체율
			String strBalArrAmt   = String2.nvl(form.getParam("strBalArrAmt"));	    // 익월 미수연체료
			String strMOD_ARREAR_AMT   = String2.nvl(form.getParam("strMOD_ARREAR_AMT"));	    // 미수연체이자
		
			while (mi.next()) {
				
				System.out.println("save============3333");	
				System.out.println("strMOD_RENT_ARREAR_AMT" + strMOD_ARREAR_AMT);	
				sql.close();
				
				sql.put(svc.getQuery("INS_MR_CALBAL"));
				int i = 0;

				sql.setString(++i, strCalYM);
				sql.setString(++i, strCntrID);
				sql.setString(++i, strMntnRentGb);
				sql.setString(++i, strCalType);
				
				sql.setString(++i, strCalYM);
				sql.setString(++i, strCntrID);
				sql.setString(++i, strMntnRentGb);
				sql.setString(++i, strCalType);
				sql.setString(++i, strRealAmt);
				sql.setString(++i, strBalArrAmt);
				sql.setString(++i, strARR_RATE);
				sql.setString(++i, userID);
				sql.setString(++i, userID);
				sql.setString(++i, strMOD_ARREAR_AMT);	 
				
				sql.setString(++i, strRealAmt);
				sql.setString(++i, strBalArrAmt);
				sql.setString(++i, strARR_RATE);
				sql.setString(++i, userID);
				sql.setString(++i, strMOD_ARREAR_AMT);	
			
				res = update(sql);
				if (res != 1) {
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
}	
